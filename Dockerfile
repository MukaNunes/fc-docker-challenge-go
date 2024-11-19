FROM golang:alpine AS builder
WORKDIR /app

RUN apk add upx && apk cache clean

COPY ./main.go /
RUN go build -ldflags "-s -w" -o /app /main.go && upx --best --lzma main

# FROM alpine:3.6
FROM busybox:uclibc
COPY --from=builder /app /app
ENTRYPOINT ["/app/main"]