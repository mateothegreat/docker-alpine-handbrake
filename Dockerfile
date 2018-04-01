FROM alpine:edge

RUN	echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --no-cache --update handbrake && \
    HandBrakeCLI --version

VOLUME [ "/data" ]

ENTRYPOINT [ "HandBrakeCLI" ]

CMD [ "--help" ]

