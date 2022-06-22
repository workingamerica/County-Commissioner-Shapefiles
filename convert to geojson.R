# http://zevross.com/blog/2016/01/13/tips-for-reading-spatial-files-into-r-with-rgdal/
# 
library(rgdal)
ogrDrivers()$name


# OH Cuyahoga -------------------------------------------------------------

ogrListLayers( dsn="data/OH Cuyahoga New County Council 2021_region")

# can I read the whole (unzipped) folder? looks like yes! :O And it looks nicer when you do....
x <- readOGR(
  dsn="data/OH Cuyahoga New County Council 2021_region"
)
x

plot(x)

writeOGR(
  x,
  dsn = "OH Cuyahoga Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)


# MI Washtenaw -------------------------------------------------------------

ogrListLayers( dsn="data/MI Washtenaw BOCDistricts/BOCDistricts")

x <- readOGR(
  dsn="data/MI Washtenaw BOCDistricts/BOCDistricts"
)
x

plot(x)

writeOGR(
  x,
  dsn = "MI Washtenaw Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)

# WI Dane -----------------------------------------------------------------

ogrListLayers( dsn="WI Dane_Supervisor_Districts_2021/Dane_Supervisor_Districts_2021")

x <- readOGR(
  dsn="WI Dane_Supervisor_Districts_2021/Dane_Supervisor_Districts_2021"
)
x

plot(x)

writeOGR(
  dakota2,
  dsn = "WI Dane Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)


# NV Clark ----------------------------------------------------------------

ogrListLayers( dsn="data/NV Clark Election/Election.gdb")
#  [1] "senate_p"   "school_p"   "regent_p"   "precinct_p" "ward_p"     "congress_p" "pollpnts_x"
# [8] "educat_p"   "township_p" "commiss_p"  "assembly_p"

# can I read the whole (unzipped) folder? looks like yes! :O And it looks nicer when you do....
x <- readOGR(
  dsn="data/NV Clark Election/Election.gdb",
  layer = "commiss_p"
)
x

plot(x)

writeOGR(
  x,
  dsn = "NV Clark Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)


# MN --------------------------------------------------------------

ogrListLayers("data/MN ALL DISTRICTS shp_bdry_votingdistricts") # list layers

x <- readOGR(
  dsn="data/MN ALL DISTRICTS shp_bdry_votingdistricts"
  )
x
names(x)
summary(x)
class(x)

head(x$CTYCOMDIST)

# seems like we have to dissolve/aggregate the polygons:
# https://stackoverflow.com/questions/49259960/merging-the-polygons-inside-a-spatial-polygons-data-frame-based-on-a-field-in-th

library(sp)
library(raster)

levels( as.factor( x$CTYCOMDIST )) # 1:7
levels(as.factor((x$COUNTYNAME)))

dakota <- x[x$COUNTYNAME=="Dakota", ] # note, it will complain unless the comma is present.
levels( as.factor( dakota$CTYCOMDIST )) # 1:7

#spatial polygons dataframe:
# spdf_m = SpatialPolygonsDataFrame(sps_m,data_m)

dakota2 = aggregate(dakota, by = "CTYCOMDIST") # from raster pkg

dakota2 # 7 features!

#plot spdf:
plot(dakota2)
plot(dakota)
# IT WORKED!!!

writeOGR(
  dakota2,
  dsn = "MI Dakota Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)

levels( as.factor( x$COUNTYNAME )) 
county = "St. Louis" #"Washington" #"Ramsey" "Anoka"
mn <- x[x$COUNTYNAME==county, ] # note, it will complain unless the comma is present.
levels( as.factor( mn$CTYCOMDIST )) # 1:7

mn2 = aggregate(mn, by = "CTYCOMDIST") # from raster pkg
mn2 # 7 features!

#plot spdf:
plot(mn)
plot(mn2)
# IT WORKED!!!

writeOGR(
  mn2,
  dsn = glue::glue("MN {county} Commissioner Districts.geojson"),
  layer = "county commissioner",
  driver = "GeoJSON"
)


hennep <- readOGR(dsn="MN Hennepin Commissioner_Districts.geojson")
plot(hennep) #looks good

# MI Oakland --------------------------------------------------------------

x <- readOGR(dsn="oakland-county-mi-commissioner-district.shp")

names(x)
summary(x)

writeOGR(
  x,
  dsn = "MI Oakland Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)


# GA - Henry --------------------------------------------------------------

x <- readOGR(
  # dsn = "GA Henry Commission Districts.kmz" # ah, it's a zip
  dsn = "GA Henry Commission Districts/doc.kml"
)

names(x)
summary(x)

writeOGR(
  x,
  dsn = "GA Henry Commissioner Districts.geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)



# GA - Gwinnett -----------------------------------------------------------

x <- readOGR(
  dsn = "GA Gwinnett/gwinnett-county-ga-commission-district.shp" # dsn = data source name
)

names(x)
summary(x)

writeOGR(
  x,
  dsn = "GA Gwinnett Commissioner Districts_geojson",
  layer = "county commissioner",
  driver = "GeoJSON"
)

# did it work? looks like yes!
y <- readOGR(
  dsn = "GA Gwinnett Commissioner Districts.geojson" # dsn = data source name
)
summary(y)
summary(x)


# GA - Dekalb  ------------------------------------------------------------

x <- readOGR(
  dsn = "GA Dekalb/dekalb-county-ga-commissioner-districts.shp" # dsn = data source name
)

names(x)
x$NAME
x$REPNAME
x$LASTUPDATE

summary(x)


writeOGR(
  x,
  dsn = "GA Dekalb Commissioner Districts_geojson", # need to rename afterward because it has Feelings about '.'
  layer = "countycommissioner", # ok to make this up? seems like it!
  driver = "GeoJSON"
)

