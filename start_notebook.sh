#!/usr/bin/env bash

# use this only when Docker has been installed: https://docs.docker.com/install/
# Docker provides a thin abstraction layer to manage dependencies 

################### DEFAULTS ###################
# we recommended using https://jupyter-docker-stacks.readthedocs.io/en/latest/
CONTAINER=jupyter/datascience-notebook
CONTAINER_VERSION=latest # fix version for projects! for testing us latest.

# by default we use the path from where you call this script
DATA_PATH="${PWD}/notebooks"

# instance details
NOTEBOOK_PASSWORD='sha1:e2c30624efd6:14f56db72bbc127e9f180cac3a653a5ba6cbd00e'
# password "example" generated in a notebook with:
# from notebook.auth import passwd; passwd()
HOST_PORT=10000
################### DEFAULTS ###################

# parse arguments
while getopts c:v:d:t:p: option 
do 
 case "${option}" 
 in 
 c) CONTAINER=${OPTARG};; 
 v) CONTAINER_VERSION=${OPTARG};;  
 d) DATA_PATH=${OPTARG};; 
 t) NOTEBOOK_TOKEN=${OPTARG};;  
 p) HOST_PORT=${OPTARG};;   
 esac 
done

# set container to use
CONTAINER="${CONTAINER}:${CONTAINER_VERSION}"

# start container
docker run -it -p ${HOST_PORT}:8888 -v ${DATA_PATH}:/home/jovyan/work -e JUPYTER_ENABLE_LAB=yes ${CONTAINER} start-notebook.sh --NotebookApp.token='' --NotebookApp.password=${NOTEBOOK_PASSWORD}