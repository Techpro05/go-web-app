FROM golang:1.23 as base

WORKDIR /app

COPY go.mod  .

RUN go mod download

COPY . .

RUN go build -o webapp .

#Final Stage

FROM gcr.io/distroless/base

COPY --from=base /app/webapp .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./webapp"]