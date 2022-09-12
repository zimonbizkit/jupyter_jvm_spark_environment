FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y build-essential && \
    apt install -y curl && \
    apt install -y rustc python3 python3-pip && \
    apt install -y openjdk-8-jre-headless && \
    apt install -y wget && \
    apt install -y x11-apps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## INSTALL MINICONDA3
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda

ENV PATH=$CONDA_DIR/bin:$PATH


RUN python3 -m pip install --no-cache-dir --upgrade pip
#&& \
#     conda update -n base -c defaults conda

RUN conda install -c conda-forge jupyterlab

#uncomment for JVM (java kernels)
#RUN conda install -c ipywidgets beakerx
RUN conda update conda

ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

# prepare entry point
RUN mkdir /jupyter/
RUN chmod 775 /jupyter


ENV JAVA_OPTS -Xms128m -Xmx256m

# Install coursier, installer for scala and almond as kernel of jupyter notebook
RUN curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier

# Compatible for apache spark 2.4.3 , that is compatible with AWS Glue 2.0
RUN ./coursier launch --fork almond:0.9.0 --scala 2.12.10 -- --install

RUN rm -rf coursier

ENV DISPLAY=:0.0

WORKDIR /jupyter
CMD ["jupyter-lab","--ip=0.0.0.0","--no-browser","--allow-root"]