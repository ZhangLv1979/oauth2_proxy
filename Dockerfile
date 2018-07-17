FROM golang:1-alpine

ENV OAUTH2_PROXY_CLIENT_ID = demoapp
ENV OAUTH2_PROXY_CLIENT_SECRET = 5df37222-d528-40a3-96de-ede27b793c07
ENV OAUTH2_PROXY_COOKIE_SECRET = changeme
ENV OAUTH2_PROXY_UPSTREAM = http://example.com
ENV OAUTH2_PROXY_REDIRECTURL = http://example.com/oauth2/callback

LABEL maintainer="Zhang Lv <zhanglv@eazytec.com>"

# When this Dockerfile was last refreshed (year/month/day)
ENV OAUTH2_PROXY_VERSION 2.2

# Install CA certificates
# RUN echo "http://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories
RUN apk add --no-cache --virtual=build-dependencies ca-certificates git
# Checkout bitly's latest google-auth-proxy code from Github
RUN go get github.com/bitly/oauth2_proxy

# Expose the ports we need and setup the ENTRYPOINT w/ the default argument
# to be pass in.
EXPOSE 8080 4180
ENTRYPOINT [ "oauth2_proxy" ]
CMD [ "--upstream=http://example.com", "--http-address=0.0.0.0:4180", "--email-domain=*", "--redirect-url=http://example.com/oauth2/callback", "--provider=oidc", "--client-id=demoapp", "--client-secret=5df37222-d528-40a3-96de-ede27b793c07", "--oidc-issuer-url=https://auth.eazytec-cloud.com/auth/realms/property" ]