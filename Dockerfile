# docker file for build pb files
FROM golang:1.17.3-buster

RUN apt update && apt install -y unzip

RUN go env -w GOPROXY=https://goproxy.cn,direct

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.27.1
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0
RUN go install github.com/envoyproxy/protoc-gen-validate@v0.6.1

RUN go install \
  github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.5.0 \
  github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.5.0

RUN go install github.com/bufbuild/buf/cmd/buf@v1.0.0-rc6

ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip /usr/local/protoc-3.17.3.zip
RUN unzip /usr/local/protoc-3.17.3.zip -d /usr/local/protoc
ENV PATH=$PATH:/usr/local/protoc/bin
