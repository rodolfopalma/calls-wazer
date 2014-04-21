###
CENTRAL CBS TWEETS FETCHER SCRIPT
Author: RODOLFO PALMA OTERO
Email: rpalmaotero[at]gmail[dot]com
Description: Fetches CentralCBS's latest 20 tweets (~10 calls), for each call parses the location url and generates a Waze enabled link.
License: MIT
###

###
offline dev
llamados = [
	"10-3-1 CALLE SAN DIEGO / AVDA 10 DE JULIO HUAMACHUCO RX7 (12:59:15)",
	"Ubicación del 10-3-1 RX7 (12:59:13) https://maps.google.cl/maps?q=-33.4541281337642+-70.6500534016461&t=m&z=17 …",
	"SALE B4,R12 A 10-4-1 FERMIN VIVACETA / PRESIDENTE EDUARDO FREI MONTALVA (10:0:58)",
	"Ubicación del 10-4-1 B4,R12 (10:0:56) https://maps.google.cl/maps?q=-33.4292148326736+-70.6605522553895&t=m&z=17 … ",
	"Boletín Informativo del Material Mayor C.B.S. (8:12:46)",
	"0-9 : K1, K2, S2, X2, B1, RH1, B2, Z2, B3, B4, H4, B5, Q6, RH6, RX6, Q7, RX7, Q8 (8:12:46)",
	"0-9 : RX8, Z10, B11, Q12, R12, BX13, Q15, RX15, B16, BX16, RH16, B17, H17, B18, H18, BX19, RH19, B21  (8:12:45)",
	"0-8 Disponible : J1, K3, S3, , M7, B9, M9, B10, BX11, MX13, RX14, MX15, Z18, B20, BX20, B22 (8:12:45)",
	"0-8 En Taller : S1, X1, M8, B13, B14, B19, BX21, M22 (8:12:45)",
	"Boletín Informativo del Material Mayor C.B.S. (8:12:44)",
	"SALE RX7,B5 A 10-4-1 AVDA MANUEL ANTONIO MATTA / CALLE SAN FRANCISCO DE ASIS (7:16:1)",
	"Ubicación del 10-4-1 RX7,B5 (7:16:0) https://maps.google.cl/maps?q=-33.458663969114+-70.6453300299584&t=m&z=17 …",
	"10-4-1 AVDA ELIODORO YAÑEZ / AVDA LOS LEONES RX14,BX13 (6:33:43)",
	"Ubicación del 10-4-1 RX14,BX13 (6:33:41) https://maps.google.cl/maps?q=-33.4300018313782+-70.6027990283267&t=m&z=17 …",
	"10-2 CALLE CAMINO LAS LOMAS / AVDA RAUL LABBE BX19 (4:16:37)",
	"Ubicación del 10-2 BX19 (4:16:36) https://maps.google.cl/maps?q=-33.3630372378509+-70.5102593135189&t=m&z=17 …",
	"10-2 CALLE VIEL / AVDA ÑUBLE B17 (2:45:23)",
	"Ubicación del 10-2 B17 (2:45:21) https://maps.google.cl/maps?q=-33.4699926692812+-70.6567027520337&t=m&z=17 …",
	"SALE RX15,BX13 A 10-3-1 CALLE FLANDES / AVDA CRISTOBAL COLON (1:44:0)",
	"Ubicación del 10-3-1 RX14,BX13 (1:43:59) https://maps.google.cl/maps?q=-33.4240344083891+-70.5815128839514&t=m&z=17 …"
]
###

callsSection = document.getElementById "llamados"
workingTweet = false
parentDiv = null

handleCall = (tweetText) ->
	location = /Ubicación del .* (https\:\/\/maps\.google\.cl\/maps\?q\=(.*))&t/.exec tweetText
	call = /^(10|INCENDIO|SALE).*/.exec tweetText

	if workingTweet and location
		parentUl = document.createElement "ul"

		googleItem = document.createElement "li"
		googleAnchor = document.createElement "a"
		googleAnchor.innerText = "Google Maps" 
		googleAnchor.setAttribute "href", location[1]
		googleItem.appendChild googleAnchor

		wazeItem = document.createElement "li"
		wazeAnchor = document.createElement "a"
		wazeAnchor.innerText = "Waze"
		wazeAnchor.setAttribute "href", "waze://?ll=" + location[2].replace("+", ",")
		wazeItem.appendChild wazeAnchor

		parentUl.appendChild googleItem
		parentUl.appendChild wazeAnchor

		parentDiv.appendChild parentUl

		callsSection.appendChild parentDiv
		parentDiv = null
		workingTweet = false

	if call
		workingTweet = true

		parentDiv = document.createElement "div"
		parentDiv.setAttribute "class", "llamado"

		parentP = document.createElement "p"
		parentP.setAttribute "class", "direccion"
		parentP.innerText = tweetText

		parentDiv.appendChild parentP


for llamado in llamados
	handleCall llamado


twitterFetcher.fetch('456863422018113536', '', 20, true, true, true, '', false, (tweets) ->

	el = document.createElement "div"

	for tweet in tweets
		el.innerHTML = tweet
		tweetText = (el.getElementsByClassName "tweet")[0].innerText

		handleCall tweetText

		el.innerHTML = ""
);