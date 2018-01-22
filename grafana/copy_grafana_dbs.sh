#!/bin/sh
# for proj in k8s prometheus opentracing fluentd linkerd grpc coredns containerd rkt cncf
for proj in k8s prometheus opentracing fluentd linkerd grpc coredns containerd rkt
do
    echo $proj
    cp "/var/lib/grafana.${proj}/grafana.db" "/var/www/html/grafana.${proj}.db" || exit 1
done
echo 'OK'
