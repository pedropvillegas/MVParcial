# lectura de los datos desde un archivo de texto
radiac<-read.table("G:/Unal/Multivar_maes/
                   radiac_cerr_abier.dat", header = TRUE)
list(radiac)
attach(radiac)
# obtenci´on de los gr´aficos Q-Q para evaluar normalidad univariada
par(mfrow=c(1,2))
qqnorm(cerrada); qqline(cerrada)
qqnorm(abierta); qqline(abierta)
# prueba normal univariada
install.packages("MVN")
install.packages("normwhn.test")
library(MVN)
uniPlot(data, type = "histogram")
#uniPlot(data, type = "box")
uniNorm(data, type = "SW", desc = TRUE)

# normalidad bivariada
# test de Mardia
mardiaTest(data, cov = TRUE, qqplot = TRUE)
# Test de Shapiro Wilk multivariado
roystonTest(data, qqplot = T)
library(normwhn.test)
# test de Doornik-Hansen: Jarque-Bera multivariado
normality.test1(data)
# Parece que no hay Normalidad multivariada
# obtenci´on de las transformaciones potenciales para cada
variable individual
library(car)
t_abi=powerTransform(abierta)
t_cerr=powerTransform(cerrada)
summary(t_abi)
summary(t_cerr)
# transformaci´on de los datos: se usan transformaciones
de 0.25 para cada variable
cerr_t=cerradaˆ0.25
abie_t=abiertaˆ0.25
radiac1=data.frame(cbind(cerr_t, abie_t))
uniPlot(radiac1, type = "box")
uniPlot(radiac1, type = "histogram")
par(mfrow=c(1,2))
qqnorm(cerr_t); qqline(cerr_t)
qqnorm(abie_t); qqline(abie_t)
# prueba normal univariada
uniNorm(radiac1, type = "SW", desc = TRUE)
par(mfrow=c(1,2))
plot(radiac)
plot(radiac1)
#Pruebas de normalidad bivariada y gr´afico chi-cuadrado
en los datos transformados
# test de Mardia
mardiaTest(radiac1, cov = TRUE, qqplot = TRUE)
# Test de Shapiro Wilk multivariado
roystonTest(radiac1, qqplot = T)
# test de Doornik-Hansen: Jarque-Bera multivariado
normality.test1(radiac1)
# Parece que no hay Normalidad multivariada en los datos
transformados
# obtenci´on de las transformaciones potenciales simult´aneas
trans_biv=powerTransform(radiac)
summary(trans_biv)
# transformaci´on de los datos: se usan transformaciones
de 0.16 para cada variable
cerr_t1=cerradaˆ0.16
abie_t1=abiertaˆ0.16
radiac2=data.frame(cbind(cerr_t1, abie_t1))
uniPlot(radiac2, type = "box")
uniPlot(radiac2, type = "histogram")
# obtenci´on de los gr´aficos Q-Q individuales para
las dos variables transformadas
par(mfrow=c(1,2))
qqnorm(cerr_t1); qqline(cerr_t1)
qqnorm(abie_t1); qqline(abie_t1)
# prueba normal univariada
uniNorm(radiac2, type = "SW", desc = TRUE)
#obtenci´on del gr´afico chi-cuadrado para evaluar
normalidad bivariada
# test de Mardia
mardiaTest(radiac2, cov = TRUE, qqplot = TRUE)
# Test de Shapiro Wilk multivariado
roystonTest(radiac2, qqplot = T)
# test de Doornik-Hansen: Jarque_Bera multivariado
normality.test1(radiac2)
# Parece que no hay Normalidad multivariada
en los datos transformados
plot(radiac2)