% Aquí va el código.
ganador(1997,peterhansel,moto(1995, 1)).
ganador(1998,peterhansel,moto(1998, 1)).
ganador(2010,sainz,auto(touareg)).
ganador(2010,depress,moto(2009, 2)).
ganador(2010,karibov,camion([vodka, mate])).
ganador(2010,patronelli,cuatri(yamaha)).
ganador(2011,principeCatar,auto(touareg)).
ganador(2011,coma,moto(2011, 2)).
ganador(2011,chagin,camion([repuestos, mate])).
ganador(2011,patronelli,cuatri(yamaha)).
ganador(2012,peterhansel,auto(countryman)).
ganador(2012,depress,moto(2011, 2)).
ganador(2012,deRooy,camion([vodka, bebidas])).
ganador(2012,patronelli,cuatri(yamaha)).
ganador(2013,peterhansel,auto(countryman)).
ganador(2013,depress,moto(2011, 2)).
ganador(2013,nikolaev,camion([vodka, bebidas])).
ganador(2013,patronelli,cuatri(yamaha)).
ganador(2014,coma,auto(countryman)).
ganador(2014,coma,moto(2013, 3)).
ganador(2014,karibov,camion([tanqueExtra])).
ganador(2014,casale,cuatri(yamaha)).
ganador(2015,principeCatar,auto(countryman)).
ganador(2015,coma,moto(2013, 2)).
ganador(2015,mardeev,camion([])).
ganador(2015,sonic,cuatri(yamaha)).
ganador(2016,peterhansel,auto(2008)).
ganador(2016,prince,moto(2016, 2)).
ganador(2016,deRooy,camion([vodka, mascota])).
ganador(2016,patronelli,cuatri(yamaha)).
ganador(2017,peterhansel,auto(3008)).
ganador(2017,sunderland,moto(2016, 4)).
ganador(2017,nikolaev,camion([ruedaExtra])).
ganador(2017,karyakin,cuatri(yamaha)).
ganador(2018,sainz,auto(3008)).
ganador(2018,walkner,moto(2018, 3)).
ganador(2018,nicolaev,camion([vodka, cama])).
ganador(2018,casale,cuatri(yamaha)).
ganador(2019,principeCatar,auto(hilux)).
ganador(2019,prince,moto(2018, 2)).
ganador(2019,nikolaev,camion([cama, mascota])).
ganador(2019,cavigliasso,cuatri(yamaha)).
pais(peterhansel,francia).
pais(sainz,espania).
pais(depress,francia).
pais(karibov,rusia).
pais(patronelli,argentina).
pais(principeCatar,catar).
pais(coma,espania).
pais(chagin,rusia).
pais(deRooy,holanda).
pais(nikolaev,rusia).
pais(casale,chile).
pais(mardeev,rusia).
pais(sonic,polonia).
pais(prince,australia).
pais(sunderland,reinoUnido).
pais(karyakin,rusia).
pais(walkner,austria).
pais(cavigliasso,argentina).

modeloYmarca(2008,peugeot).
modeloYmarca(3008,peugeot).
modeloYmarca(countryman,mini).
modeloYmarca(touareg,volkswagen).
modeloYmarca(hilux,toyota).

ganadorReincidente(Corredor):-
    ganador(Anio1,Corredor,_),
    ganador(Anio2,Corredor,_),
    Anio1\=Anio2.

inspiraA(Corredor1,Corredor2):-
    pais(Corredor1,Pais),
    pais(Corredor2,Pais),
    Corredor1\=Corredor2,
    puedeInspirar(Corredor1,Corredor2).

puedeInspirar(Corredor1,Corredor2):-  
    ganador(Anio,Corredor1,_),
    not(ganador(Anio,Corredor2,_)).

puedeInspirar(Corredor1,Corredor2):-
    ganador(Anio1,Corredor1,_),
    ganador(Anio2,Corredor2,_),
    Anio1<Anio2.

/*
La marca de un auto se obtiene a partir del modelo del auto. 
La marca de las motos dependen del año de fabricación: las fabricadas a partir del 2000 inclusive son ktm, las anteriores yamaha.
La marca de los camiones es kamaz si lleva vodka, sino la marca es iveco.
La marca del cuatri se indica en cada uno.*/

marcaDeLaFortuna(Corredor,Marca):-
    ganador(_,Corredor,Vehiculo),
    not(ganoConDistintaMarca(Corredor)),
    marcaDelVehiculo(Vehiculo,Marca).

ganoConDistintaMarca(Corredor):-
    ganador(_,Corredor,Vehiculo1),
    ganador(_,Corredor,Vehiculo2),
    marcaDelVehiculo(Vehiculo1,Marca1),
    marcaDelVehiculo(Vehiculo2,Marca2),
    Marca1\=Marca2.

marcaDelVehiculo(auto(Modelo),Marca):-
    modeloYmarca(Modelo,Marca).

marcaDelVehiculo(moto(AnioDeFabricacion, _),yamaha):-
    AnioDeFabricacion>1999.
   

marcaDelVehiculo(moto(AnioDeFabricacion, _),kms):-
    AnioDeFabricacion<2000.


marcaDelVehiculo(camion(Items),kamaz):-
    member(vodka,Items).

marcaDelVehiculo(camion(Items),iveco):-
    not(marcaDelVehiculo(camion(Items),kamaz)).
    
marcaDelVehiculo(cuatri(Marca),Marca).

heroePopular(Corredor):-
    ganador(Anio,Corredor,Vehiculo),
    inspiraA(Corredor,_),
    not(noFueELUnicoSinVehiculoCaro(Anio,Corredor)),
    not(vehiculoCaro(Vehiculo)).
  


noFueELUnicoSinVehiculoCaro(Anio,Corredor1):-
    ganador(Anio,Corredor1,Vehiculo1),
    ganador(Anio,Corredor2,Vehiculo2),
    Corredor1\=Corredor2,
    not(vehiculoCaro(Vehiculo1)),
    not(vehiculoCaro(Vehiculo2)).

vehiculoCaro(Vehiculo):-
    marcaDelVehiculo(Vehiculo,mini).
vehiculoCaro(Vehiculo):-
    marcaDelVehiculo(Vehiculo,toyota).
vehiculoCaro(Vehiculo):-
    marcaDelVehiculo(Vehiculo,iveco).
vehiculoCaro(cuatri(_)).
vehiculoCaro(moto(_,CantDeSuspensionesExtras)):-
    CantDeSuspensionesExtras>2.

etapa(marDelPlata,santaRosa,60).
etapa(santaRosa,sanRafael,290).
etapa(sanRafael,sanJuan,208).
etapa(sanJuan,chilecito,326).
etapa(chilecito,fiambala,177).
etapa(fiambala,copiapo,274).
etapa(copiapo,antofagasta,477).
etapa(antofagasta,iquique,557).
etapa(iquique,arica,377).
etapa(arica,arequipa,478).
etapa(arequipa,nazca,246).
etapa(nazca,pisco,276).
etapa(pisco,lima,29).

kmEntreDosLocalizaciones(Origen,Destino,Distancia):-
    etapa(Origen,Destino, Distancia).

kmEntreDosLocalizaciones(Origen,Destino,DistanciaTotal):-
    etapa(Origen, PuntoIntermedio, DistanciaEnElMedio),
    kmEntreDosLocalizaciones(PuntoIntermedio,Destino,DistanciaFinal),
    DistanciaTotal is DistanciaEnElMedio + DistanciaFinal.

distanciaMaxEnKm(Vehiculo,2000):-
    vehiculoCaro(Vehiculo).

distanciaMaxEnKm(Vehiculo, 1800):-
    marcaDelVehiculo(Vehiculo,_),
    not(vehiculoCaro(Vehiculo)).

distanciaMaxEnKm(camion(Items), Limite):-
    length(Items, Cantidad),
    Limite is Cantidad * 1000.

hastaDondePuedeLLegar(Vehiculo,Origen,PuntoMasLejano):-
    distanciaMaxEnKm(Vehiculo,DistanciaPosible),
    kmEntreDosLocalizaciones(Origen,PuntoMasLejano,DistanciaTotal),
    DistanciaTotal>DistanciaPosible.

%marDelPlata fiambala