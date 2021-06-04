FROM node:latest
ARG Dir=/node/qsl

WORKDIR $Dir
ADD . $Dir
RUN npm install && nohup npm run build &
RUN tar zcvf dist.tar.gz $Dir/dist

FROM nginx:stable-alpine
COPY --from=0 $Dir/dist.tar.gz /
EXPOSE 80
RUN tar xf /dist.tar.gz -C /usr/share/nginx/html
CMD ["nginx","-g","daemon off;"]
