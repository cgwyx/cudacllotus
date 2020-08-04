FROM nvidia/opencl:runtime-ubuntu18.04

RUN apt-get update &&\
    apt-get install golang-go gcc git bzr jq pkg-config mesa-opencl-icd ocl-icd-opencl-dev curl   clinfo -y &&\
    apt upgrade

RUN git clone -b ntwk-calibration https://github.com/filecoin-project/lotus.git &&\
    cd lotus &&\
    make clean all &&\
    make install

VOLUME ["/root","/var"]

#RUN sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list \
#  && sed -i "s/security.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list \
#  && rm -f /etc/apt/sources.list.d/*

#COPY docker-entrypoint.sh /docker-entrypoint.sh

#RUN chmod +x /docker-entrypoint.sh

# API port
EXPOSE 1234/tcp

# P2P port
EXPOSE 1347/tcp

# API port
EXPOSE 2345/tcp

# API port
EXPOSE 3456/tcp

ENV IPFS_GATEWAY=https://proof-parameters.s3.cn-south-1.jdcloud-oss.com/ipfs/

ENV FIL_PROOFS_MAXIMIZE_CACHING=1

ENV FIL_PROOFS_USE_GPU_COLUMN_BUILDER=1

ENV FIL_PROOFS_USE_GPU_TREE_BUILDER=1

#WORKDIR /storage
WORKDIR /lotus

#ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["./lotus", "daemon", "&"]
