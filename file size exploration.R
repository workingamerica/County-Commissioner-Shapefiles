# why are some so large?

x <- readOGR(
  dsn="NC Forsyth_County_Commissioners_Districts.geojson"
)
x

plot(x)
names(x)
# x$variables
# variables(x)
x$COMM
x$DistrictNa
x$Party1
x$Party2
x$Party3
x$Party4
x$RepName4


x <- readOGR(
  #dsn="VA Fairfax OpenData_S1.geojson"
  dsn = "WI Dane Commissioner Districts.geojson"
)
x
plot(x)
names(x)
