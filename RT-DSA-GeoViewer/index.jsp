<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 //EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>GIS Analysis</title>


<!-- Bootstrap Styles-->

<link href="content/style/ihover.css" rel="stylesheet">
<link href="content/style/ihover.min.css" rel="stylesheet">
<link href="content/assets/css/bootstrap.css" rel="stylesheet" />
<!-- FontAwesome Styles-->
<link href="content/assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="content/assets/js/morris/morris-0.4.3.min.css"
        rel="stylesheet" />

<!-- My Style -->
<link href="content/assets/css/mystyle.css" />


<!-- Custom Styles-->
<link href="content/assets/css/custom-styles.css" rel="stylesheet" />
<!-- Google Fonts-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
        rel='stylesheet' type='text/css' />



<style>
#info {
        width: screen.width;
        height: 150px;
}

#map-canvas {
        width: screen.width;
        height: 900px;
}
</style>


<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
<script
        src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript">
        function initialize(eve) {
                var allData = [];
                var map, pointarray, heatmap;
                var event = eve;
                //alert(event);
                $
                                .ajax({
                                        url : "http://lasir.umkc.edu:8080/RT-DSA-GeoViewer/webresources/ocisa/heatmap?event="
                                                        + event,
                                        type : 'GET',
                                        async : false,
                                        success : function disp(data) {
                                                var latlonList = data.split(';');
                                                var i = 0;
                                                while (i < latlonList.length - 1) {
                                                        var latlon = latlonList[i].split(' ');
                                                        var latlng = new google.maps.LatLng(latlon[0],latlon[1]);
                                                        allData[i]=latlng;
                                                         i++;
                                                }
                                        },
                                        error : function(XMLHttpRequest, textStatus, errorThrown) {
                                                alert(errorThrown);
                                        }

                                });
                var mapOptions = {
                        zoom : 6,
                        center : allData[0],
                        mapTypeId : google.maps.MapTypeId.TERRAIN
                };
               
                var colors = [
                'rgba(255,255, 0, 0)',
                'rgba(255,255,0,1)',
                'rgba(128,255,0,1)',
                'rgba(255,255,51,1)',
                'rgba(153,76,0,1)',
                'rgba(76,153,0,1)',
                'rgba(128,255,10,1)',
                'rgba(255,255,153,1)',
                'rgba(255, 0, 0,1)'    // red
                ];

        
                map = new google.maps.Map(document.getElementById('map-canvas'),
                                mapOptions);
                pointArray = new google.maps.MVCArray(allData);
                heatmap = new google.maps.visualization.HeatmapLayer({
                        data : allData
                });
                heatmap.setMap(map);
                heatmap.set('radius', 25);
                //heatmap.set('gradient', colors);
        }

        function mapForDamage(eve)
        {
                var allData = [];
                var map, pointarray, heatmap;
                var event = eve;
                var firstLatLon;
            $
                            .ajax({
                                    url : "http://lasir.umkc.edu:8080/RT-DSA-GeoViewer/webresources/ocisa/damageMap?event="
                                                    + event,
                                    type : 'GET',
                                    async : false,
                                    success : function disp(data) {
                                            var latlonList = data.split(';');
                                            var i = 0;
                                            while (i < latlonList.length - 1) {
                                                    var latlon = latlonList[i].split(':');
                                                    allData.push({location: new google.maps.LatLng(parseFloat(latlon[1]),parseFloat(latlon[2])), weight: latlon[0]});
                                                    if(i == 0){
                                                    firstLatLon = new google.maps.LatLng(parseFloat(latlon[1]),parseFloat(latlon[2]));
                                                    }
                                                    i++;
                                            }
                                    },
                                    error : function(XMLHttpRequest, textStatus, errorThrown) {
                                            alert(errorThrown);
                                    }

                            });
            var mapOptions = {
                    zoom : 13,
                    center : firstLatLon,
                    mapTypeId : google.maps.MapTypeId.SATELLITE
            };

            map = new google.maps.Map(document.getElementById('map-canvas'),
                            mapOptions);
            var pointArray = new google.maps.MVCArray(allData);
            heatmap = new google.maps.visualization.HeatmapLayer({
                    data : pointArray,
                    dissipating: true,
            });
            heatmap.setMap(map);
            heatmap.set('radius',30);
        }
        
        function createMap(eve)
        {
         alert("In Create Map"); 
          var allData = [];
                var map, pointarray, heatmap;
                var event = eve;
                var firstLatLon;
            $
                            .ajax({
                                    url : "http://lasir.umkc.edu:8080/RT-DSA-GeoViewer/webresources/ocisa/heatmap?event="
                                                    + event,
                                    type : 'GET',
                                    async : false,
                                    success : function disp(data) {
                                            var latlonList = data.split(';');
                                            var i = 0;
                                            while (i < latlonList.length - 1) {
                                                    var latlon = latlonList[i].split(' ');
                                                    allData.push(new google.maps.LatLng(parseFloat(latlon[0]),parseFloat(latlon[1])));
                                                    if(i == 0){
                                                    firstLatLon = new google.maps.LatLng(parseFloat(latlon[0]),parseFloat(latlon[1]));
                                                    }
                                                    i++;
                                            }
                                    },
                                    error : function(XMLHttpRequest, textStatus, errorThrown) {
                                            alert(errorThrown);
                                    }

                            });

                var mapOptions = {
    		zoom: 4,
	        center: myLatlng
	        }
	   var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
           var markers = [];
           var k=0;
           while(k < allData.length){
	           var marker = new google.maps.Marker({
	           position: allData[k],
        	   map: map,
	           title: 'Imaging Data'
           });
           markers.push(marker); 
           }

        }  
        function getMap()
        {
             var event = document.querySelector('input[name="database"]:checked').value; 
             alert(event);
             createMap(event);
        }

        function getEvent()
        {
                var event = document.querySelector('input[name="database"]:checked').value;
                var option =  document.querySelector('input[name="viewing"]:checked').value;
                if(option == "Imaging")
                        {
                           initialize(event);
                        }
                else if(option == "Damage")
                        {
                           mapForDamage(event);
                        }
                else
                        {
                           //Do Nothing
                        }
        }
        function getHeatMap()
        {
                //alert("Using Image Events");
                var event = document.querySelector('input[name="database"]:checked').value;
                initialize(event);
        }

        function getHeatMapEvent()
        {
                var event = document.querySelector('input[name="database"]:checked').value;
                mapForDamage(event);
        }




</script>
</head>

<body bgcolor="#99CCFF" onload="initialize('Tornado')">
        <div class="container-fluid">
                <div class="row text-center">
                        <h2 class="page-header">
                                <font color="#2447B2"><strong>Real-Time Disaster
                                                Scene Analytics GeoViewer</strong></font>
                        </h2>
                </div>
                <div class="row">

                        <div class="col-md-2"></div>
                        <div class="col-md-5">
                                <h4 class="text-left">
                                        <font color="#2447B2"><strong>Disaster Scene
                                                        Databases</strong></font>
                                </h4>
                                <table class="table-condensed">
                                         <tr>
                                                <td class="text-left"><input type="radio" name="database"
                                                        value="Tornado" checked onClick="getEvent()"> <font
                                                        color="#2447B2"><b> 2013 Moore Tornado</b></font></td>
                                        </tr>

                                        <tr>
                                                <td class="text-left"><input type="radio" name="database"
                                                        value="Earthquake" onClick="getEvent()"> <font
                                                        color="#2447B2"><b> 2014 South Napa Valley Earthquake</b></font></td>
                                        </tr>
                                        <tr>
                                                <td class="text-left"><input type="radio" name="database"
                                                        value="oevents" onClick="getEvent()"><font
                                                        color="#2447B2"><b> TestData for RT-DSA (Offline)</b></font></td>
                                        </tr>

                                        <tr>
                                                <td class="text-left"><input type="radio" name="database"
                                                        value="all" onClick="getEvent()"> <font color="#2447B2"><b>
                                                                        All Events</b></font></td>
                                        </tr>

                                </table>
                        </div>
                        <div class="col-md-5">
                                <h4>
                                        <font color="#2447B2"><strong>Viewing Options</strong></font>
                                </h4>
                                <table class="table-condensed table-right">
                                        <tr>
                                                <td class="text-left"><input type="radio" id="images"
                                                        name="viewing" value="Map" onClick="getMap()"><font
                                                        color="#2447B2"><b> Imaging Data</b></font></td>
                                        </tr>

                                        <tr>
                                                <td class="text-left"><input type="radio" id="imaginEvent"
                                                        name="viewing" value="Imaging" checked onClick="getHeatMap()"><font
                                                        color="#2447B2"><b> Image Event HeatMap</b></font></td>
                                        </tr>
                                        <tr>
                                                <td class="text-left"><input type="radio" id="damageRating"
                                                        name="viewing" value="Damage" onClick="getHeatMapEvent()">
                                                        <font color="#2447B2"><b> Damage Rating HeatMap</b></font></td>
                                        </tr>
                                </table>
                        </div>
                </div>
        </div>


        <div id="map-canvas"></div>

</body>
<script src="content/assets/js/jquery-1.10.2.js"></script>
<!-- Bootstrap Js -->
<script src="content/assets/js/bootstrap.min.js"></script>
<!-- Metis Menu Js -->
<script src="content/assets/js/jquery.metisMenu.js"></script>
<!-- Morris Chart Js -->
<script src="content/assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="content/assets/js/morris/morris.js"></script>
<!-- Custom Js -->
<script src="content/assets/js/custom-scripts.js"></script>

</html>
