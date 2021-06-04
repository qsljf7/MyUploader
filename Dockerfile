FROM node:latest
ARG Dir=/node/qsl

WORKDIR $Dir
ADD . $Dir
RUN npm install && npm run build

from nginx:stable-alpine

COPY --from=0 $Dir/*.tgz /
EXPOSE 80
RUN tar xf /duap.tgz -C /usr/share/nginx/html
CMD ["nginx","-g","daemon off;"]
