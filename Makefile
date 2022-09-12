all: help
##-------------------------------------------------------------------------
##
##		    Scala, Spark ,current status and possibilities
##
##  		@author: [          ]
##
## ------------------------------------------------------------------------
## Available commands are:
## ------------------------------------------------------------------------
## 	help			Displays a list of commands

AWS_S3_LOCAL_BUCKET=searchevents
MAKES_AND_MODELS_BUCKET=makesandmodels
STOPWORDS_BUCKET=stopwords

.PHONY : help
help : Makefile
	@sed -n 's/^##//p' $<


##	build:			Brings the environment on and builds the containers from scratch
.PHONY : build
build:
	docker-compose up --build -d

##	up:			Brings the environment on
.PHONY : up
up:
	docker-compose -f docker-compose.yml up -d

##	up:			Brings the environment off
.PHONY : down
down:
	docker-compose -f docker-compose.yml down