#! perl -w
# Toby Thurston ---  7 Sep 2007
use strict;

# StationName     Eeg�in'9_Lat_Sec  EDeg�in'_Long_Sec  ETRS89_Height  ETRS89_East  ETRS89_North  OSGB36_East  OSGB36_North  ODN_Height
my %test_input = (
  Scilly        => [ 49.922263943333, -6.299777527222,  100.000,   91400.000,    11400.000,   91492.135,    11318.801,  46.882 ],
  Liz1          => [ 49.960061383056, -5.203046100278,  124.269,  170277.189,    11652.895,  170370.706,    11572.404,  71.222 ],
  Plym          => [ 50.438858254722, -4.108645639722,  215.251,  250265.789,    62095.883,  250359.798,    62016.567, 163.081 ],
  Scp1          => [ 50.575636651667, -1.297822771389,   94.688,  449719.403,    75415.594,  449816.359,    75335.859,  48.571 ],
  OSHQ          => [ 50.931279377500, -1.450514340556,  100.405,  438614.045,   114871.192,  438710.908,   114792.248,  54.029 ],
  Nfo1          => [ 51.374470259167,  1.444547306944,   99.439,  639720.224,   169645.824,  639821.823,   169565.856,  55.110 ],
  Nas1          => [ 51.400782203889, -3.551283487222,  112.371,  292090.289,   168081.281,  292184.858,   168003.462,  60.615 ],
  Bris          => [ 51.427547433611, -2.544076186111,  104.018,  362174.408,   170056.500,  362269.979,   169978.688,  54.467 ],
  Lond          => [ 51.489365646111, -0.119925564167,   66.057,  530526.413,   178467.043,  530624.963,   178388.461,  20.518 ],
  Carm          => [ 51.858908967500, -4.308524766111,   81.351,  241030.731,   220409.858,  241124.573,   220332.638,  27.590 ],
  Colc          => [ 51.894366375278,  0.897243275000,   75.273,  599345.196,   225801.485,  599445.578,   225722.824,  30.192 ],
  Nort          => [ 52.251609509167, -0.912489570000,  131.594,  474237.874,   262125.333,  474335.957,   262047.752,  83.961 ],
  Droi          => [ 52.255293816389, -2.154586149444,  101.526,  389448.042,   261989.271,  389544.178,   261912.151,  51.977 ],
  King          => [ 52.751366874444,  0.401535476944,   66.431,  562079.805,   319862.042,  562180.535,   319784.993,  20.890 ],
  Nott          => [ 52.962191095000, -1.197476561667,   93.825,  453904.269,   340910.743,  454002.822,   340834.941,  45.253 ],
  Dare          => [ 53.344802806667, -2.640493207222,   88.411,  357359.683,   383364.152,  357455.831,   383290.434,  36.750 ],
  Lyn1          => [ 53.416285157778, -4.289180693056,  100.776,  247865.448,   393566.264,  247958.959,   393492.906,  46.314 ],
  Lyn2          => [ 53.416309251667, -4.289177926389,  100.854,  247865.718,   393568.938,  247959.229,   393495.580,  46.393 ],
  Blac          => [ 53.779110256944, -3.040454906944,   64.940,  331439.160,   431992.943,  331534.552,   431920.792,  12.636 ],
  Leed          => [ 53.800215199167, -1.663791675833,  215.609,  422143.679,   433891.207,  422242.174,   433818.699, 165.891 ],
  IoMS          => [ 54.086663180833, -4.634521685000,   84.366,  227685.882,   468918.331,  227778.318,   468847.386,  29.335 ],
  Fla1          => [ 54.116851443333, -0.077731326667,   86.778,  525643.491,   470775.610,  525745.658,   470703.211,  41.217 ],
  IoMN          => [ 54.329195410556, -4.388491180000,   94.503,  244687.517,   495324.611,  244780.625,   495254.884,  39.891 ],
  Carl          => [ 54.895423405278, -2.938277414722,   93.541,  339824.598,   556102.504,  339921.133,   556034.759,  41.077 ],
  Newc          => [ 54.979122740000, -1.616576845556,  125.878,  424539.719,   565080.533,  424639.343,   565012.700,  76.551 ],
  Glas          => [ 55.853999529722, -4.296490155556,   71.617,  256247.486,   664760.292,  256340.914,   664697.266,  17.414 ],
  Edin          => [ 55.924782652500, -3.294792187778,  119.032,  319092.329,   671010.630,  319188.423,   670947.532,  66.362 ],
  Mala          => [ 57.006066965278, -5.828366926389,   68.494,  167542.805,   797124.153,  167634.190,   797067.142,  13.190 ],
  Gir1          => [ 57.139025193056, -2.048560316111,  108.610,  397061.069,   805408.146,  397160.479,   805349.734,  58.902 ],
  Inve          => [ 57.486250003333, -4.219263989444,   66.178,  266961.481,   846233.646,  267056.756,   846176.969,  13.230 ],
  Stkilda       => [ 57.813518421667, -8.578544610278,  100.000,    9500.003,   899499.996,    9587.897,   899448.993,  43.424 ],
  Flannan       => [ 58.212622481389, -7.592555631111,  140.404,   71622.450,   938567.303,   71713.120,   938516.401,  83.594 ],
  But1          => [ 58.515603618056, -6.260914556389,  115.026,  151874.984,   966535.331,  151968.641,   966483.777,  58.836 ],
  Thur          => [ 58.581204614444, -3.726310213056,   98.634,  299624.627,   967256.596,  299721.879,   967202.990,  46.011 ],
  Ork_Main_Ork  => [ 58.718937183056, -3.073926035278,  100.000,  337800.000,   981800.000,  337898.195,   981746.359,  48.631 ],
  Ork_Main_Main => [ 58.721082864444, -3.137882873056,  100.000,  334100.000,   982100.000,  334198.101,   982046.419,  48.439 ],
  Orkney        => [ 59.037438710000, -3.214540010556,  100.000,  330300.000,  1017400.000,  330398.311,  1017347.013,  47.978 ],
  SuleSkerry    => [ 59.093350350833, -4.417576741667,  100.000,  261500.000,  1025500.000,  261596.767,  1025447.599,  46.347 ],
  NorthRona     => [ 59.096716177778, -5.827993408889,  140.716,  180766.824,  1029654.640,  180862.449,  1029604.111,  85.197 ],
  FairIsle      => [ 59.534707943333, -1.625169658333,  100.000,  421200.000,  1072200.000,  421300.513,  1072147.236,  50.951 ],
  Sum1          => [ 59.854099142500, -1.274869112222,  149.890,  440623.592,  1107930.781,  440725.061,  1107878.445, 100.991 ],
  Foula         => [ 60.133080920833, -2.073828223611,  140.716,  395898.578,  1138780.346,  395999.656,  1138728.948,  89.901 ],
  );

use Geo::Coordinates::OSTN02 qw/ETRS89_to_OSGB36 OSGB36_to_ETRS89/;
use Geo::Coordinates::OSGB   qw/grid_to_ll ll_to_grid/;

use Test::Simple tests => 168;

my $eps  = 0.002; # within 2mm is OK

for my $k (sort keys %test_input ) {
    my ($lat,$lon, $z) = @{$test_input{$k}}[0,1,2];
    my ($x,$y)         = @{$test_input{$k}}[3,4];
    my ($gotx, $goty) = ll_to_grid($lat,$lon,'ETRS89');
    ok( $gotx == $x && $goty == $y , "Create X Y: $k: $x:$gotx $y:$goty" );
}

for my $k (sort keys %test_input ) {
    my ($lat,$lon, $z) = @{$test_input{$k}}[0,1,2];
    my ($x,$y)         = @{$test_input{$k}}[3,4];
    my ($e,$n,$h)      = @{$test_input{$k}}[5,6,7];
    my ($gote, $gotn, $goth) = ETRS89_to_OSGB36($x, $y, $z);
    ok( abs($gote-$e)<$eps && abs($gotn-$n)<$eps && abs($goth-$h)<$eps, "ETRS89_to_OSGB36: $k" );
}

for my $k (sort keys %test_input ) {
    my ($lat,$lon, $z) = @{$test_input{$k}}[0,1,2];
    my ($x,$y)         = @{$test_input{$k}}[3,4];
    my ($e,$n,$h)      = @{$test_input{$k}}[5,6,7];
    my ($gotX, $gotY, $gotZ) = OSGB36_to_ETRS89($e, $n, $h);
    ok( abs($gotX-$x)<$eps && abs($gotY-$y)<$eps && abs($gotZ-$z)<$eps, "OSGB36_to_ETRS89: $k" );
}

$eps = 1.1e-6; # decimal degrees, which is about 20cm latitude, 10cm longitude
for my $k (sort keys %test_input ) {
    my ($lat,$lon, $z) = @{$test_input{$k}}[0,1,2];
    my ($x,$y)         = @{$test_input{$k}}[3,4];
    my ($e,$n,$h)      = @{$test_input{$k}}[5,6,7];
    my ($gotlat, $gotlon) = grid_to_ll($x,$y,'ETRS89');
    ok( abs($lat-$gotlat)<$eps && abs($lon-$gotlon)<$eps, "back to LL: $k");
}
