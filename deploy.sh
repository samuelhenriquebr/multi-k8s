docker build -t samuelhenriquebr/multi-client:latest -t samuelhenriquebr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samuelhenriquebr/multi-server:latest -t samuelhenriquebr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samuelhenriquebr/multi-worker:latest -t samuelhenriquebr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samuelhenriquebr/multi-client:latest
docker push samuelhenriquebr/multi-server:latest
docker push samuelhenriquebr/multi-worker:latest

docker push samuelhenriquebr/multi-client:$SHA
docker push samuelhenriquebr/multi-server:$SHA
docker push samuelhenriquebr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samuelhenriquebr/multi-server:$SHA
kubectl set image deployments/client-deployment client=samuelhenriquebr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samuelhenriquebr/multi-worker:$SHA