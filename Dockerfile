FROM node:18-alpine

# Install system dependencies
RUN apk add --no-cache postgresql-client

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package.json package-lock.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Copy the exported SQL file
COPY backup.sql .

# Expose the desired port
EXPOSE 4000

# Set the command to run your application
CMD ["npm", "run", "server"]

# Import the database during the container build
RUN psql -U "ubaidurrehman" -h "database" -d "user_manager" -f backup.sql
