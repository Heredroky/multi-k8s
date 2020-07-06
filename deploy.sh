docker build -t heredroky/multi-client:latest -t heredroky/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t heredroky/multi-server:latest -t heredroky/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t heredroky/multi-worker:latest -t heredroky/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push heredroky/multi-client:latest
docker push heredroky/multi-server: latest
docker push heredroky/multi-worker: latest

docker push heredroky/multi-client:$SHA
docker push heredroky/multi-server: $SHA
docker push heredroky/multi-worker: $SHA
kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=heredroky/multi-server:$SHA
kubectl set image deployments/client-deployment client=heredroky/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=heredroky/multi-worker:$SHA