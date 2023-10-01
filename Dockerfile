FROM node:20-alpine3.16 AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM nginx:1.23.4-alpine
COPY --from=build /app/dist /etc/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80