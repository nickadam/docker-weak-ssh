FROM alpine:3.10

RUN apk add \
  dumb-init \
  rsync \
  openssh-client \
  openssh-server \
  openssh-sftp-server \
  openssh \
  nmap-ncat \
  shadow

COPY docker-entrypoint.sh /

EXPOSE 22/tcp 80/tcp

ENTRYPOINT ["dumb-init", "./docker-entrypoint.sh"]
