BINARY=go-grpc-auth-svc

proto:
	protoc pkg/**/pb/*.proto --go_out=plugins=grpc:.

server:
	go run cmd/main.go

engine:
	go build -o ${BINARY} cmd/*.go

docker:
	docker build -t ${BINARY} .

docker_run:
	docker run --name ${BINARY} -p50001:50001 -d --network bridge-network ${BINARY}

docker_stop:
	docker stop ${BINARY}
	
docker_rm:
	docker rm $(shell docker ps -a -f name=${BINARY} -q)

docker_push_local:
	docker tag 	${BINARY} docker.okidog.xyz/${BINARY}
	docker push docker.okidog.xyz/${BINARY}

.PHONY: proto server engine docker docker_run docker_stop docker_rm docker_push_local
