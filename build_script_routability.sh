mkdir $(pwd)/temp
NO_PROXY=.innovation.insee.eu
curl data/pbf/france-transfrontalier-latest.osm.pbf --output $(pwd)/temp/data.osm.pbf
curl data/car_routability.lua --output $(pwd)/temp/car_routability.lua
docker run -t -v $(pwd)/temp:/data osrm/osrm-backend osrm-extract -p /data/car_routability.lua /data/data.osm.pbf
docker run -t -v $(pwd)/temp:/data osrm/osrm-backend osrm-partition /data/data.osrm
docker run -t -v $(pwd)/temp:/data osrm/osrm-backend osrm-customize /data/data.osrm
cd $(pwd)/temp && tar -zcvf ../data_routability.tar.gz *