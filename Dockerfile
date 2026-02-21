FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod .
COPY main.go .
COPY templates ./templates

RUN CGO_ENABLED=0 go build -o compiled_app .

FROM scratch

WORKDIR /app

COPY --from=builder app/compiled_app .
COPY --from=builder app/templates .
EXPOSE 8080
CMD [ "compiled_app" ]