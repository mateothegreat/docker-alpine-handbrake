#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS          := default
NAME	    := appsoa/docker-alpine-handbrake
ALIAS	    ?= handbrake
VERSION	    ?= 3.4
TAG         := $(NAME):$(VERSION)
AUTHOR      := "$(shell git config --get user.name)"
export 

all:  build docker/push

build:                  ; docker/build

docker/logs:            ; docker logs -f $(ALIAS)
docker/push:            ; docker push $(TAG)
docker/shell:           ; docker run -it --sysctl net.ipv6.conf.all.disable_ipv6=0 \
										--cap-add=NET_ADMIN \
										--privileged \
										--name motion \
										--entrypoint=/bin/sh $(NAME):$(VERSION)

docker/exec:            ; docker exec -it $(ALIAS) /bin/bash
docker/run:

	docker run -it  --rm \
					$(NAME):$(VERSION) --help

docker/run/detached:    

	docker run -d  	--rm \
					--privileged \
					--cap-add=NET_ADMIN \
					--sysctl net.ipv6.conf.all.disable_ipv6=0 \
					-p 8081:8081 \
					--name motion \
					-e "DATA_PATH=/data"                                                    \
					-e "MOTION_IMAGE_OUTPUT_TYPE=webp"                                      \
					-e "CAMERA_ID=00000000-0000-0000-0000-DOCKER000001"                     \
					-e "MOTION_CONF_TEMPLATE=/conf/tested.30fps.1pic.conf"                  \
					-e "MOTION_URL=rtsp://admin:Speco123001!@10.2.0.102:11200"    			\
					$(NAME):$(VERSION)