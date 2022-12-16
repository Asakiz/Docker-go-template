# Our base image
FROM golang:1.19 as base

# Our workspace
WORKDIR /app
COPY . /app

# Get the dependecies
RUN go mod download

# Build the binary with pure-Go implementations
RUN CGO_ENABLED=0 go build -o main .

FROM gcr.io/distroless/static-debian11

# Our final workspace
WORKDIR /app

# Copy the binary from the build stage
COPY --from=base /app/main .

CMD ["/app/main"]