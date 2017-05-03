FROM golang:1.8-alpine

ENV GOPATH /go
COPY . /go/src/github.com/alehano/rethinkdb_exporter

RUN apk add --update -t build-deps git mercurial make \
    && apk add -u musl && rm -rf /var/cache/apk/* \
    && cd /go/src/github.com/alehano/rethinkdb_exporter \
    && go get && go build && cp rethinkdb_exporter /bin/rethinkdb_exporter \
    && rm -rf /go && apk del --purge build-deps

EXPOSE     9123
ENTRYPOINT [ "/bin/rethinkdb_exporter" ]
