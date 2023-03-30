#!/bin/bash

# Get project name from user
read -p "Enter project name: " project_name

# Create project directory and move into it
mkdir $project_name
cd $project_name

# Initialize Git
git init

# Initialize Yarn and install dependencies
yarn init -y
yarn add fastify fastify-cli typescript ts-node-dev eslint prettier eslint-config-prettier eslint-plugin-prettier tap --dev

# Create TypeScript config file
npx tsc --init

# Configure typescript
echo "{
  \"compilerOptions\": {
        \"target\": \"ESNext\",
        \"module\": \"commonjs\",
        \"rootDir\": \"./\",
        \"moduleResolution\": \"node\",
        \"baseUrl\": \"./\",
        \"outDir\": \"./build\",
        \"esModuleInterop\": true,
        \"forceConsistentCasingInFileNames\": true,
        \"strict\": true,
        \"skipLibCheck\": true
    },
}" > tsconfig.json

# Configure ESLint
npx eslint --init

# Configure Prettier
echo "{
  \"trailingComma\": \"es5\",
  \"singleQuote\": true,
  \"printWidth\": 120,
  \"tabWidth\": 2
}" > .prettierrc

# Create gitignore file
touch .gitignore

# Create dockerfile file
touch dockerfile

# Create dockerfile file
touch .dockerignore

# Create index.ts file
touch server.ts

# Populate index.ts file with basic Fastify server code
echo "import fastify from 'fastify';

const server = fastify({
  logger: true,
});

server.get('/', async (request, reply) => {
  return { hello: 'world' };
});

const start = async () => {
  try {
    await server.listen(3000);
  } catch (error) {
    server.log.error(error);
    process.exit(1);
  }
};

start();" > server.ts

# Add start script and test script to package.json
yarn add --dev ts-node
yarn add --dev tap
sed -i '' 's/"test": "echo \\"Error: no test specified\\" && exit 1"/"start": "ts-node-dev index.ts",\n"test": "tap test/**/*.test.ts"/g' package.json

# Create README markdown
echo "# $project_name" > README.md

mkdir build
mkdir controllers
cd controllers
touch index.ts
cd ../
mkdir routes
cd routes
touch index.ts
cd ../

# Open project directory in IntelliJ IDEA
cd $project_name
idea .

# Display success message
echo "Successfully created and configured Fastify project with TypeScript, ESLint, Prettier, Git, Node Tap, README markdown, and opened in IntelliJ IDEA!"
