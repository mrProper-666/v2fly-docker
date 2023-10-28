FROM --platform="${TARGETPLATFORM}" alpine:latest
LABEL maintainer="mrProper-666 <mrproper.aka.dax@gmail.com>"

WORKDIR /tmp
ARG TARGETPLATFORM
ARG TAG
COPY v2ray.sh "${WORKDIR}"/v2ray.sh

RUN set -ex \
    && apk add --no-cache ca-certificates jq \
    && mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray \
    && ln -sf /dev/stdout /var/log/v2ray/access.log \
    && ln -sf /dev/stderr /var/log/v2ray/error.log \
    && chmod +x "${WORKDIR}"/v2ray.sh \
    && "${WORKDIR}"/v2ray.sh "${TARGETPLATFORM}"

ENTRYPOINT ["/usr/bin/v2ray", "run"]
