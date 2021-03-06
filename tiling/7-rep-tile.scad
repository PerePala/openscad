use <../lib/tile_fns.scad>

/* 
 7-rep-tile, Gosper Island
  based on a hexagon
  see http://mathafou.free.fr/pbm_en/sol218.html
   https://archive.bridgesmathart.org/2015/bridges2015-423.pdf  
Kit Wallace 2019-10-04
*/

k=1;  //order of rep
inset=-0.1; // expand slighly to counter laser kerf
width=40;
    
function lr_to_peri(f) =
  [for (i=[0:len(f)-1])
      let(d=f[i])
      [1,d=="L"? 120: d=="R"? -120 : 0]
  ];

function reverse_last(s) =
   flatten(concat(
       len(s)>1 
           ?[for (i=[0:len(s)-2]) s[i]] 
           : [],
       let (c=s[len(s)-1])
       c=="R" ? "L" : "R"
    ));
           
function f(s,k) =
   k==0
     ? s
     : let (t= flatten(
             concat(
             s,
             reverse_last(s),
             s 
             )
             ))
       f(t,k-1);
 
seed="L";
lr=f(seed,k);
echo(lr);
peri=repeat(lr_to_peri(lr),6);
// peri_report(peri);
unit_tile=peri_to_tile(peri);           
scaled_width=width/pow(2,k);
scaled_tile=scale_tile(unit_tile,scaled_width);
fill_tile(inset_tile(scaled_tile,inset));
