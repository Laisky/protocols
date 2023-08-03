.PHONY: install
install:
	go install golang.org/x/vuln/cmd/govulncheck@latest
	go install golang.org/x/tools/cmd/goimports@latest
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.30.0
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0
	# go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway
	# go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2
	# go install github.com/Laisky/mockery/v2@9eecbca

.PHONY: lint
lint:
	buf lint
	go mod tidy
	# govulncheck ./...
	goimports -local "github.com/Laisky/protocols" -w .
	gofmt -s -w .

	# go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
	# golangci-lint run --timeout 3m -E golint,depguard,gocognit,goconst,gofmt,misspell,exportloopref,nilerr #,gosec,lll
	golangci-lint run -c .golangci.lint.yml --allow-parallel-runners
