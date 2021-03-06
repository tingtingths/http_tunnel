FROM golang:1.14 as builder

ENV GOPATH /go

RUN mkdir -p /app

COPY . /app

WORKDIR /app

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o tunnel

RUN chmod -R +x /app

FROM alpine:latest

RUN apk --no-cache add ca-certificates

COPY --from=builder /app/tunnel /app/tunnel

EXPOSE 8080

CMD ["/app/tunnel"]
