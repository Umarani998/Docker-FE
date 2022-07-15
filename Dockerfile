# get the base node image
FROM node:alpine as builder

# set the working dir for container
WORKDIR /frontend

# copy the json file first
COPY ./package.json /frontend

# install npm dependencies
RUN npm install

# copy other project files
COPY . .

# build the folder
RUN npm run build

# Handle Nginx
#taking nginx base image
FROM nginx
#copying created build folder to nginx root index html file
COPY --from=builder /frontend/build /usr/share/nginx/html
#copying root folder nginx conf to nginx root default conf
COPY ./docker/nginx/default.conf /etc/nginx/conf.d/default.conf