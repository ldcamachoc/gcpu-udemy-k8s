docker build -t ldcamachoc/multi-k8s-client:latest -t ldcamachoc/multi-k8s-client:$SHA  -f ./client/Dockerfile ./client
docker build -t ldcamachoc/multi-k8s-server:latest -t ldcamachoc/multi-k8s-server:$SHA  -f ./server/Dockerfile ./server
docker build -t ldcamachoc/multi-k8s-worker:latest -t ldcamachoc/multi-k8s-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push ldcamachoc/multi-k8s-client:latest
docker push ldcamachoc/multi-k8s-server:latest
docker push ldcamachoc/multi-k8s-worker:latest

docker push ldcamachoc/multi-k8s-client:$SHA
docker push ldcamachoc/multi-k8s-server:$SHA
docker push ldcamachoc/multi-k8s-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=ldcamachoc/multi-k8s-server:$SHA
kubectl set image deployments/client-deployment client=ldcamachoc/multi-k8s-client:$SHA
kubectl set image deployments/worker-deployment worker=ldcamachoc/multi-k8s-worker:$SHA