#!/bin/bash
# Asegúrate de que se detengan en caso de error
set -e

# Instalar Faker si no está instalado
echo "Instalando Faker..."
composer require fakerphp/faker --dev

# Instalar dependencias de Composer
echo "Instalando dependencias de Composer..."
composer install --no-dev --optimize-autoloader

# Ejecutar migraciones
echo "Ejecutando migraciones..."
php artisan migrate --force

# Ejecutar seeding si es necesario
echo "Ejecutando seeders..."
php artisan db:seed --class=RolesAndPermissionsSeeder

# Cachear configuraciones
echo "Cacheando configuraciones..."
php artisan config:cache

# Cachear rutas
echo "Cacheando rutas..."
php artisan route:cache

# Listar rutas para verificar que todo está en orden
echo "Listando rutas..."
php artisan route:list

chmod -R 775 /var/www/html/database
php artisan serve --host=0.0.0.0 --port=10000
