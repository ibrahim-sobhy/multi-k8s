docker build -t ibrahimsobhy/multi-client:latest -t ibrahimsobhy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ibrahimsobhy/multi-server:latest -t ibrahimsobhy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ibrahimsobhy/multi-worker:latest -t ibrahimsobhy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ibrahimsobhy/multi-client:latest
docker push ibrahimsobhy/multi-server:latest
docker push ibrahimsobhy/multi-worker:latest

docker push ibrahimsobhy/multi-client:$SHA
docker push ibrahimsobhy/multi-server:$SHA
docker push ibrahimsobhy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ibrahimsobhy/multi-server:$SHA
kubectl set image deployments/client-deployment server=ibrahimsobhy/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ibrahimsobhy/multi-worker:$SHA