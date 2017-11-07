# ---------------------------------------------------------------------------#
#                   SCRAPER - TUCARRO.COM
#                           2017                     
#                                                
# OBJETIVO: Extraer información del Carro Mazda2 desde tucarro.com
# Desarrollado por: Ana Maria Lopez / Pedro Pablo Villegas
# Curso: Modelos Lineales
# Profesor: Juan Carlos Correa
# 
# ---------------------------------------------------------------------------#
#                            INICIO DE PROCESO
# ---------------------------------------------------------------------------#
# Estructura de Directorios
dir.principal  <- 'D:/UNAL/Modelos Lineales/Mazda2/Solucion'
dir.funciones  <- 'D:/UNAL/Modelos Lineales/Mazda2/Solucion/Code'
dir.input      <- 'D:/UNAL/Modelos Lineales/Mazda2/Solucion/Data/in/'
dir.output     <- 'D:/UNAL/Modelos Lineales/Mazda2/Solucion/Data/out/'
# --------------------------------------------------------------------------#
#                            INSTALAR LIBRERIAS
# --------------------------------------------------------------------------#
setwd(dir.funciones)
options(warn = -1)
list.files()
# cargando/instalando librerias necesarias
source(list.files(pattern = "PKG"))
# --------------------------------------------------------------------------#
#                            CAPTURAR INFORMACION
# --------------------------------------------------------------------------#
#URL 
url <- 'http://carros.tucarro.com.co/carros-camionetas/mazda/mazda-2/'
#url <- 'http://carros.tucarro.com.co/carros-camionetas/renault/clio/'

#Leyendo Codigo HTML
webpage <- read_html(url)
#Capturar Cantidad de Resultados.
result_data_html <- str_replace_all(html_text(html_nodes(webpage,'.page'),'.fromPage'),"\t"," ")
result_data_html <- str_trim(result_data_html)
result_data_html <- strsplit(result_data_html," ")
total_data <- as.integer(unlist(result_data_html)[4])
i <- 1
all_data <- NULL
#Recorrer Paginas
while (i<=total_data){
  
  #Leyendo Codigo HTML
  webpage <- read_html(url)
  
  #Using CSS selectors to scrap the rankings section
  title_data_html <- html_nodes(webpage,'.list-view-item-title')
  price_data_html <- html_nodes(webpage,'.ch-price')
  model_data_html <- html_nodes(webpage,'.destaque')
  site_data_html <- html_nodes(webpage,'.more-info')

  #Results
  result_data_html <- str_replace_all(html_text(html_nodes(webpage,'.page'),'.fromPage'),"\t"," ")
  result_data_html <- str_trim(result_data_html)
  result_data_html <- strsplit(result_data_html," ")
  #str(result_data_html)
  
  #URL
  url_data_html <- html_attr(html_children(title_data_html), "href", default = NA_character_)
  
  #Converting the ranking data to text
  title_data <- str_trim(html_text(title_data_html))
  price_data <- str_trim(html_text(price_data_html))
  model_data <- str_extract(str_trim(html_text(model_data_html)), "[0-9 ]{1,4}")
  kms_data <- str_trim(substr(str_trim(html_text(model_data_html)),8,20))
  site_data <- str_trim(html_text(site_data_html))
  range_data <- str_trim(str_replace_all(unlist(result_data_html)[2],"-",":"))
  id_data <- c(unlist(strsplit(range_data,":"))[1]:unlist(strsplit(range_data,":"))[2])
  #total_data <- unlist(result_data_html)[4]
  
  #Captura URL pagina siguiente
  pag_data_html <- html_nodes(webpage,'.last-child')
  
  i <- as.integer(unlist(strsplit(range_data,":"))[2]) + 1
  url <- html_attr(html_children(pag_data_html), "href", default = NA_character_)
  
  if(length(price_data)!=length(title_data))
     price_data <- price_data[-1]
  
  #if(url!='http://carros.tucarro.com.co/carros-camionetas/renault/clio/_Desde_201' | url!='http://carros.tucarro.com.co/carros-camionetas/renault/clio/_Desde_101')  
  data <- data.frame(
                      Id=id_data,
                      Titulo=title_data,
                      Precio=price_data,
                      Modelo_anyo=model_data,
                      Kilometros=kms_data,
                      Ubicacion=site_data,
                      URL=url_data_html
                    )
 
   all_data <- rbind(all_data,data)
}

#Adicionar Columnas 
all_data["Color"] <- NA
all_data["Combustible"] <- NA
all_data["Recorrido"] <- NA
all_data["Marca"] <- NA

all_data["Departamento"] <- NA
all_data["Ciudad"] <- NA
all_data["Barrio"] <- NA

all_data["Modelo"] <- NA
all_data["Unico"] <- NA
all_data["Placa"] <- NA
all_data["Anyo"] <- NA

all_data["Version"] <- NA
all_data["FrenosABS"] <- NA
all_data["Aire"] <- NA
all_data["Airbag"] <- NA

all_data["Asientos"] <- NA
all_data["Cilindros"] <- NA
all_data["Direccion"] <- NA
all_data["Financiamiento"] <- NA

all_data["Motor"] <- NA
all_data["Negociable"] <- NA
all_data["MotorReparado"] <- NA
all_data["Sonido"] <- NA

all_data["Traccion"] <- NA
all_data["Transmision"] <- NA
all_data["Vidrios"] <- NA


#Seguridad
##Alarma con control 
##Asegurado 
##Rastreo satelital

all_data["AlarmaControl"] <- NA
all_data["Asegurado"] <- NA
all_data["RastreoSatelital"] <- NA

#Sonido
##Caja de CD's 
##DVD 
##Planta 
##Sub-Buffer (Bajos)

all_data["CD"] <- NA
all_data["DVD"] <- NA
all_data["Planta"] <- NA
all_data["Buffer"] <- NA

#Exterior
##Estribos 
##Forro llanta de repuesto 
##Llantas nuevas 
##Luces anti niebla 
##Película de Seguridad 
##Retrovisores eléctricos 
##Revision tecnomecánica 
##Rines de lujo 
##Spoiler 
##Sun Roof (Quemacoco)

all_data["Estribos"] <- NA
all_data["ForroLlantaRepuesto"] <- NA
all_data["LlantasNuevas"] <- NA
all_data["LucesAntiNiebla"] <- NA
all_data["PeliculaSeguridad"] <- NA
all_data["RetrovisoresElectricos"] <- NA
all_data["ReVTecnicoMecanica"] <- NA
all_data["RinesLujo"] <- NA
all_data["Spoiler"] <- NA
all_data["SunRoof"] <- NA

#Equipamiento
##Bloqueo central 
##Forro del volante 
##Forros de asientos 
##Volante deportivo

all_data["BloqueoCentral"] <- NA
all_data["ForroVolante"] <- NA
all_data["ForroAsientos"] <- NA
all_data["VolanteDeportivo"] <- NA


for(i in 1:length(all_data$Id))
{
  url <- as.character(all_data[i,"URL"])
  #url <-'http://articulo.tucarro.com.co/MCO-454409780-mazda-mazda-2-_JM'
  #url <- 'http://articulo.tucarro.com.co/MCO-451857284-mazda-mazda-2-_JM'
  webpage <- read_html(url)
  
  details_data_html <- html_nodes(webpage,'.attribute-group')
  second_data_hml <- html_nodes(webpage,'.attribute-list')
  detail_ubicacion_html <- strsplit(str_replace_all(str_replace_all(html_text(html_children(html_nodes(webpage,'.vip-location-info'))),"\t",""),"\n",""),":")
  
  details_data <- strsplit(str_replace_all(str_replace_all(html_text(details_data_html),"\t",""),"\n",""),":")
  second_data <- unlist(strsplit(str_trim(str_replace_all(html_text(second_data_hml),"\n","")),"\t"))
  detail_ubicacion <- unlist(strsplit(as.character(detail_ubicacion_html[2]),"-"))
  
  for (j in 1:length(details_data))
  {
    if(unlist(details_data[j])[1] == "Color")
      all_data[i,"Color"] <- str_trim(unlist(details_data[j])[2])
    if(unlist(details_data[j])[1] == "Combustible")
      all_data[i,"Combustible"] <- str_trim(unlist(details_data[j])[2])
    if(unlist(details_data[j])[1] == "Recorrido")
      all_data[i,"Recorrido"] <- str_trim(unlist(details_data[j])[2])   
    if(unlist(details_data[j])[1] == "Marca")
      all_data[i,"Marca"] <- str_trim(unlist(details_data[j])[2]) 
    
    if(unlist(details_data[j])[1] == "Modelo")
      all_data[i,"Modelo"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Único dueño")
      all_data[i,"Unico"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Placa")
      all_data[i,"Placa"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Año")
      all_data[i,"Anyo"] <- str_trim(unlist(details_data[j])[2]) 
    
    if(unlist(details_data[j])[1] == "Versión")
      all_data[i,"Version"] <- str_trim(unlist(details_data[j])[2])   
    if(unlist(details_data[j])[1] == "Frenos ABS")
      all_data[i,"FrenosABS"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Aire Acondicionado")
      all_data[i,"Aire"] <- str_trim(unlist(details_data[j])[2])  
    if(unlist(details_data[j])[1] == "Airbag")
      all_data[i,"Airbag"] <- str_trim(unlist(details_data[j])[2]) 
    
    if(unlist(details_data[j])[1] == "Asientos")
      all_data[i,"Asientos"] <- str_trim(unlist(details_data[j])[2])   
    if(unlist(details_data[j])[1] == "Nro. de cilindros")
      all_data[i,"Cilindros"] <- str_trim(unlist(details_data[j])[2])  
    if(unlist(details_data[j])[1] == "Dirección")
      all_data[i,"Direccion"] <- str_trim(unlist(details_data[j])[2])   
    if(unlist(details_data[j])[1] == "Doy financiamiento")
      all_data[i,"Financiamiento"] <- str_trim(unlist(details_data[j])[2])  
    
    if(unlist(details_data[j])[1] == "Motor")
      all_data[i,"Motor"] <- str_trim(unlist(details_data[j])[2])   
    if(unlist(details_data[j])[1] == "Negociable")
      all_data[i,"Negociable"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Motor recién reparado")
      all_data[i,"MotorReparado"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Sonido")
      all_data[i,"Sonido"] <- str_trim(unlist(details_data[j])[2]) 
    
    if(unlist(details_data[j])[1] == "Tracción")
      all_data[i,"Traccion"] <- str_trim(unlist(details_data[j])[2])  
    if(unlist(details_data[j])[1] == "Transmisión")
      all_data[i,"Transmision"] <- str_trim(unlist(details_data[j])[2]) 
    if(unlist(details_data[j])[1] == "Vidrios")
      all_data[i,"Vidrios"] <- str_trim(unlist(details_data[j])[2]) 
  } 
  if(!is.null(second_data))
    for (j in 1:length(second_data))
    { 
      if(second_data[j] == "Alarma con control")
        all_data[i,"AlarmaControl"] <- 1
      if(second_data[j] == "Asegurado")
        all_data[i,"Asegurado"] <- 1
      if(second_data[j] == "Rastreo satelital")  
        all_data[i,"RastreoSatelital"] <- 1
      if(second_data[j] == "Caja de CD's")
        all_data[i,"CD"] <- 1
      if(second_data[j] == "DVD")
        all_data[i,"DVD"] <- 1
      if(second_data[j] == "Planta")
        all_data[i,"Planta"] <- 1
      if(second_data[j] == "Sub-Buffer (Bajos)")
        all_data[i,"Buffer"] <- 1
      if(second_data[j] == "Estribos")
        all_data[i,"Estribos"] <- 1
      if(second_data[j] == "Forro llanta de repuesto")
        all_data[i,"ForroLlantaRepuesto"] <- 1
      if(second_data[j] == "Llantas nuevas")
        all_data[i,"LlantasNuevas"] <- 1
      if(second_data[j] == "Luces anti niebla")
        all_data[i,"LucesAntiNiebla"] <- 1
      if(second_data[j] == "Película de Seguridad")
        all_data[i,"PeliculaSeguridad"] <- 1
      if(second_data[j] == "Retrovisores eléctricos")
        all_data[i,"RetrovisoresElectricos"] <- 1
      if(second_data[j] == "Revision tecnomecánica")
        all_data[i,"ReVTecnicoMecanica"] <- 1
      if(second_data[j] == "Rines de lujo")
        all_data[i,"RinesLujo"] <- 1
      if(second_data[j] == "Spoiler")
        all_data[i,"Spoiler"] <- 1
      if(second_data[j] == "Sun Roof (Quemacoco)")
        all_data[i,"SunRoof"] <- 1
      if(second_data[j] == "Bloqueo central")
        all_data[i,"BloqueoCentral"] <- 1
      if(second_data[j] == "Forro del volante")
        all_data[i,"ForroVolante"] <- 1
      if(second_data[j] == "Forros de asientos")
        all_data[i,"ForroAsientos"] <- 1
      if(second_data[j] == "Volante deportivo")
        all_data[i,"VolanteDeportivo"] <- 1     
    }
  if(!is.null(detail_ubicacion))
    for (j in 1:length(detail_ubicacion))
    { 
      if(j==1)
        all_data[i,"Departamento"] <- detail_ubicacion[j] 
      if(j==2)
        all_data[i,"Ciudad"] <- detail_ubicacion[j] 
      if(j==3)
        all_data[i,"Barrio"] <- detail_ubicacion[j] 
    }
}

all_data$fecha_grabacion <- Sys.Date()

fecha <- format(Sys.Date(),"%Y%m%d")

write.table(all_data, 
            paste(dir.output,"Datos_Mazda2_",fecha,'.csv',sep=''),
            sep="|", col.names=TRUE, row.names=FALSE, quote=TRUE, na="",dec=',',fileEncoding = "UTF-8")
