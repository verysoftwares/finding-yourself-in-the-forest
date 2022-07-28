-- title:  finding yourself in the forest
-- author: verysoftwares
-- desc:   adventure game. eat to unlock verbs.
-- script: lua
-- saveid: FYITF


--aliases
cos=math.cos
sin=math.sin
ins=table.insert
rem=table.remove
fmt=string.format
sub=string.sub
flr=math.floor
min=math.min
max=math.max

-- kaikki sfx nollan wavet kAyttAAn waveformia 4
-- oon ollu idiuutti
for w=0,30-1,1 do
		cur_smp=3
		cur_smp=flr(cur_smp)
		local addr=0x100e4*2 +0*(4*30+4+2*4) +1 +(w)*4
		poke4(addr, cur_smp)
end
for w=0,30-1,1 do
		cur_smp=2
		cur_smp=flr(cur_smp)
		local addr=0x100e4*2 +2*(4*30+4+2*4) +1 +(w)*4
		poke4(addr, cur_smp)
end
function titlemusic2()
		for i=1,14 do--(t*.03)%14 do
		for w=0,32-1,1 do
				local addr=0xffe4*2 +1*32 +w
				cur_smp=peek4(0xffe4*2 +1*32 +(w+1)%32)
				poke4(addr, cur_smp)
		end end
		for w=0,32-1,1 do
				cur_smp=((t*.00881+w)*(w+(t+800*t*.03)*.006*2.72*.72)*.05467)%24
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +3*32 +w
				poke4(addr, cur_smp)
		end
		
					local sqvol=0
					if t<360 then sqvol=-2 end
					if t>480 and t%480==240 then sqvol=sqvol-2 end
					if t%480 ==360 then sqvol=sqvol+1 end

	  if t< 480*2+480*2+480*2 +240*4*2+480+480 and 
			   t>=480*2+480*2+480*2          and
						t%480==360                then
				sfx(1,
				    -1+12*1+12*flr(((t)%120)/120)+t%12,
								100-10-4-1,
								1,
								0x3,
								0)
			end

	
	if t<480*2+480*2+480*2+480+480+480 then 
		if t>=240 and t%120==0 then
				sfx(1,
				    -1+12*1+12*flr(((t)%120)/120)+t%12,
								100-10,
								1,
								0x1+0x3+((t)%480)/120+sqvol,
								0)
		end
		if t>480 and (t%480==200 or t%480==220) then
				--trace(flr(((t%480)%200)/10))
				sfx(1,
				    -1+12*1-4-flr(((t%480)%200)/10),
								12+3*flr(((t%480)%200)/10),
								1,
								0x1+0x4+1+flr(((t%480)%200)/20),
								0)
		end
		if t%480>450 then
				sfx(1,
				    -1+12*1+12*flr(((t)%120)/120)+t%12
								-(t%480-450),
								100-10,
								1,
								0x1+0x5,
								0)
		end
		end
		
		if t<480*2+480*2+480*2+480 then
		
		if t%20==0 then
				sfx(0,
				    -1+12*2+12*flr(((t)%480)/132)+t%12,
								15,
								0,
								0x1+((t)%120)/20+((t)%240)/80,
								0)
		end
		end
		if t>=60*8-30 and t%10==0 then
				sfx(3,
				    -1+12*3+9*flr(((t)%60)/12)+t%14,
								6,
								3,								
								0x4+((t-90)%240)/40,
								0)
		end
		if t>=240 and
		    t <480*2+480*2+480*2  +480  +960*3+234 +480+480
		then
		breathe2()  
		end
end

function breathe1()
		for w=0,32-1,1 do
				cur_smp=(3+sin(w*.2*.01)*2
				        +3+sin(w+t*.045*55*.01)*2
												+3+sin(w+t*.06*225*.001)*2
												+3+sin(w+t*12*.0001)*1)
				cur_smp=flr(cur_smp*.75+rand(1,3))%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if t%1==0 then
				sfx(2,
				    -1+12*2+flr(sin(t/50.0)*4),
								32,
								2,
								0x9+flr(sin(t/50.0)*4),
								0)
		end
end

function breathe2()
		local freq=.633---t*.02
		for w=0,32-1,1 do
				-- try only x as argument for
				-- life signal
				freq=.633*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+t)*.2*freq,12*9282+(w+t)*.245*freq,12*771+(w+t)*.1*freq)-.5)*6
				freq=.47
				cur_smp=cur_smp+(perlin((w+t*.3)*.42*freq,12*92482+(w+t)*.245*freq,12*7471+(w+t)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if t%31==0 then
				sfx(2,
				    -1+12*3,
								32,
								2,
								0x8+flr(sin(t/80.0)*4),
								0)
		end
end

function breathe3()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+t)*.2*freq,12*9282+(w+t)*.245*freq,12*771+(w+t)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+t*.3)*.42*freq,12*92482+(w+t)*.245*freq,12*7471+(w+t)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if t%(9)==0 then
				sfx(2,
				    -1+12*3+t%21-t%23,
								9+1,
								2,
								0x8,
								0)
		end
end

function breathe7()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(40)==0 then
				sfx(2,
				    -1+3+12*3+mt%12-mt%16,
								20+1,
								2,
								0x8,
								0)
		end
end

function breathe8()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(13)==0 then
				sfx(2,
				    -4+12*3+mt%12+mt%8-mt%16,
								13+1,
								2,
								0x8,
								0)
		end
end

function breathe9()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(130)==0 then
				sfx(2,
				    -4+12*3+mt%13+mt%8-mt%16,
								130+1,
								2,
								0x8,
								0)
		end
		if mt%(13)==0 then
				sfx(2,
				    -4+12*3+mt%13+mt%8-mt%16,
								6+1,
								3,
								0x8,
								0)
		end
end

function breathe10()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(5)==0 then
				sfx(2,
				    -4+12*5+mt%13+mt%8-mt%16,
								5+1,
								3,
								0x8,
								0)
		end
end

function breathe11()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(55)==0 then
				sfx(2,
				    -5+12*2+mt%13+mt%8-mt%14,
								55+1,
								3,
								0x8,
								0)
		end
end

function breathe12()
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
		
		if mt%(155)==0 then
				sfx(2,
				    -5+12*3+mt%13+mt%8-mt%14,
								155+1,
								2,
								0x8,
								0)
		end
		if mt%(66)==0 then
				sfx(2,
				    -5+12*4+mt%13+mt%8-mt%14,
								55+1,
								3,
								0x8,
								0)		
		end
end

function breathe13()
		if mt%(1)==0 then
				sfx(8,
				    -5+12*3+mt%23+mt%18-mt%24,
								1+1,
								2,
								0x8,
								0)
		end
		local freq=.88---t*.02
		for w=0,32-1,1 do
				freq=.88*.75--+1.5+sin(t*.001)
				cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
				freq=.407
				cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +2*32 +w
				poke4(addr, cur_smp)
		end
end

function breathen(dur,upv,dnv)
		local dur=dur or math.random(9,160)
		local upv=upv or math.random(1,52)
		local dnv=dnv or 0
		while dnv==0 or dnv<0 do
				dnv=upv+math.random(-12,12)
		end
		trace(dur,8)
		trace(upv,9)
		trace(dnv,10)
		return function()
				local freq=.88---t*.02
				for w=0,32-1,1 do
						freq=.88*.75--+1.5+sin(t*.001)
						cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
						freq=.407
						cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
						cur_smp=flr(cur_smp)%16
						local addr=0xffe4*2 +2*32 +w
						poke4(addr, cur_smp)
				end
				
				if mt%(dur)==0 then
						sfx(2,
						    -1+12*3+mt%upv-mt%dnv,
										dur+1,
										2,
										0x8,
										0)
				end
		end
end

function breathex()
		for i=1,14 do--(t*.03)%14 do
		for w=0,32-1,1 do
				local addr=0xffe4*2 +1*32 +w
				cur_smp=peek4(0xffe4*2 +1*32 +(w+1)%32)
				poke4(addr, cur_smp)
		end end
		for w=0,32-1,1 do
				cur_smp=((t*.00881+w)*(w+(t+800*t*.03)*.006*2.72*.72)*.05467)%24
				cur_smp=flr(cur_smp)%16
				local addr=0xffe4*2 +3*32 +w
				poke4(addr, cur_smp)
		end

				--if paramsus['w']~=4 then
				local freq=.88---t*.02
				for w=0,32-1,1 do
						freq=.88*.75--+1.5+sin(t*.001)
						cur_smp=6+(perlin((w+mt)*.2*freq,12*9282+(w+mt)*.245*freq,12*771+(w+mt)*.1*freq)-.5)*6
						freq=.407
						cur_smp=cur_smp+(perlin((w+mt*.3)*.42*freq,12*92482+(w+mt)*.245*freq,12*7471+(w+mt)*.1*freq))*7
						cur_smp=flr(cur_smp)%16
						local addr=0xffe4*2 +0*32 +w
						poke4(addr, cur_smp)
				end
				--end
				
				if mt%(paramsus['dt'])==0 then
						local vol=15
						if paramsus['w']~=1 then vol=8 end
						sfx(4-1+paramsus['w'],
						    -1+12*3+mt%paramsus['p+']+mt%paramsus['p2+']-mt%paramsus['p-'],
										paramsus['dt']+1,
										2,
										vol,
										0)
				end
end

function shutup()
	for ch=0,3 do
				sfx(ch,
				    0,
								0,
								ch,
								0,
								0)
		end
end

tst='111111ffffffffffffffff9999999999999999999999999999'

function yesplacefgm()
		local cur_smp
		trace(#suddensndfgm)
		local mah=flr(12)
		trace(t*32*mah/#suddensndfgm)
		if t%1==0 then
		for w=0,32-1,1 do
				cur_smp=sub(suddensndfgm,
				            1+(t*32*mah+mah*w)%#suddensndfgm,
																1+(t*32*mah+mah*w)%#suddensndfgm)
				local addr=0xffe4*2 +2*32 +w
				cur_smp=flr(tonumber(cur_smp,16))%16
				poke4(addr, cur_smp)
		end
		
				sfx(2,
				    -1+12*3,
								32,
								2,
								0x8,
								0)
		end
end

breathe4=breathen(120,12,16)
breathe5=breathen(10,20,16)
breathe6=breathen(63,30,28)--breathen(10,20,16)--breathen(31,44,55)--breathen(44,16,40)

function titlescr()
	-- audio layer %)
			
	if not debug then
			titlemusic2()
			--breathe13()
	end
			
			--brth()
			--titlemusic()

			--yesplacefgm()
			--breathe2()

	-- bg layer
			cls(0)
			if t==0 then grid() 
			elseif t==1 then grid2() 
			elseif t==2 then grid3()
			else
			grid4() end

	-- preview places
			if t%(60*8)==0 then
					old_prp=preview_place
					preview_place=choice(places)
					while preview_place==old_prp do preview_place=choice(places) end
			end
			borders(12*6-8,4,8+min(t*8,12*8)+8,8+min(t*8,12*8)+8,
											8+((t-t%(60*8))*(t%(60*8)*.1))%8
										)
			rect(12*6,8+4,min(t*8,8*12),min(t*8,8*12),0)
			if t%(60*8)<60*6 then
				clip(12*6,8+4,min(t*8,8*12),min(t*8,8*12))
					for i=1-1,12-1 do
					spr(224+(t*.03)%2,
					12*6+11*8+i*8+16-t%(60*8)*.45,
					8+4+i*8)
					end
				clip()
			end
			clip(12*6,8+4,min(t*8,8*12),min(t*8,8*12))
			draw_place(preview_place,12*6,8+4)
			clip()
			if t%(60*8)>=60*6 then
				clip(12*6,8+4,8*12,8*12)
					for i=1-1,3-1 do
					spr(224+(t*.03)%2,
					12*6+11*8+i*4*8+16-(t%(60*8)-60*6)*1.8,
					8+4+i*4*8,0,
					4)
					end
				clip()
			end

	for i=1,math.min(t,16) do
	--print('finding yourself in the forest\n2020',
	--8+16*2-i*2,8+16*9-i*2,(15-i)%16)
	chainc=0
	titleprint('finding', 12,12)
	titleprint('yourself',12+2*12,12)
	titleprint('in',      12*6+12*8+12,12)
	titleprint('the',     12*6+12*8+12*3,12)
	titleprint('forest',  12*6+12*8+12*5,12)

	end

	if t>=240 then
	meirl_print('by Leonard Somero\n    2019-2022',0+1+math.max(240-(t-240)*4.8,0),12*10+1)
	meirl_print('   published via\n   verysoftwares',math.min(-240+(t-240)*4.8,12*5+12*9+4-3),12*10+1)
	end
	
	if t>=360 then
			local anykey='Press any key.'
			for c=0,#anykey-1 do
					local char=sub(anykey,c+1,c+1)
					local cx=12*6+c*6+8+1
					local cy=12*10+4
					cx=cx+cos((t*.115+c*.1))*3
					cy=cy+sin((t*.1+c*.115))*3
					print(char,cx,cy,
					8+(t*.2+c*.2)%8)
			end
	end
	
	if t>0 then
 for k=1,65 do
	if keyp(k) then 
			if t<360-1 then t=360-1
			else t=0; mt=0; shutup(); TIC=gameon; shutup() end 
	end end end
	
	--viewmusic()
 t=t+1
end

function gameon()

	--input
	if focus ==hotspots then
   -- basic arrow input for hotspot selection.
   		cycle(hotspots)
   
   -- X: cancel hotspot verb
   		if btnp(5) then 
   				focus=verbs; inform(nil); while #hotspots>0 do rem(hotspots) end; hotspots.i=1 
       -- with omstarts
     				if cur(verbs) =="Plant" then
     						inform("Nevermind, let's put that back.")
     						ins(inventory, plantdat.next)
     						plantdat.next=nil
     				end
     				if cur(verbs) =="Chop" then
     						inform("What, why not?")
     				end
   
   -- Z: resolve hotspot verb
   		elseif btnp(4) then
   				hspot=cur(hotspots)
   				inform(nil)

       if cur(verbs)=='Move' then
       track({verb={cur(verbs),'hotspot resolve'},
              place={x=hspot.nextx,y=hspot.nexty},
             })
       --trace(hspot.nextx,6)
       --trace(hspot.nexty,7)
       else
       track({verb={cur(verbs),'hotspot resolve',hspot.id},
              place={x=place.x,y=place.y},
             })
							end

   				local action= hotspot_verb_resolve[cur(verbs)]
       if action then action() 
       else trace(fmt('undefined hotspot verb %s',cur(verbs))) end 

   				while #hotspots>0 do rem(hotspots) end
   				hotspots.i=1
   				if not (focus ==lore) then focus=verbs end
   		end
	elseif focus ==inventory then
   -- arrows to select item.
   		cycle(inventory)
   -- X: cancel.
   		if btnp(5) then focus=verbs; inform(nil)
   -- Z: use verb on inventory item.
   		elseif btnp(4) then
   			 inform(nil)
       -- global flag, default true,
       -- false value signals cancelled item usage.
       inv_success=true

       local action= inventory_verb_resolve[cur(verbs)]
       if action then action() 
       else trace(fmt('undefined inventory verb %s',cur(verbs))) end 

       if inv_success then
     				rem(inventory,inventory.i)
     				if inventory.i>#inventory then inventory.i=#inventory end
     				if inventory.i<1 then inventory.i=1 end
     				if not (focus ==lore) and not plantdat.next then focus=verbs end
       end
   		end
	elseif focus ==verbs then
   -- arrow input to navigate.
   		cycle(verbs)
   -- Z: select, action happens, focus state may change.
   		if btnp(4) then
       -- was defined, where needed?
   			   --lastverb=cur(verbs)
       local action= select_verb[cur(verbs)]
       if action then action() 
       --[[if cur(verbs)~='Move' and cur(verbs)~='Climb' and cur(verbs)~='Plant' then
       track({verb={cur(verbs),'hotspot resolve'},
              place={x=place.x,y=place.y},
             })
       end]]
       else trace(fmt('undefined verb selection %s',cur(verbs))) end 
   		end
	end
	
	--BG
	cls(0)

	--have you soft-locked?
	softlock=false
	if not flags["S"] then
	if #verbs ==1 then
			if #inventory ==0 then
					softlock=true
			end
	end
	if not verb_has("Move") then
			--if no banana in inventory
			if not inv_has(5) then
					softlock=true
					if area_has(5) and (verb_has('Pick up') or inv_has(37)) then 
							softlock=false
					end
					--banana tree, save me
					if softlock and place.x ==0 and place.y ==0 then
							--well, i could still throw something.
							if verb_has("Throw") then
									if #inventory>=1 then
											softlock=false
											--oh, but i only have item(s) 
											--that will cause an
											--'it did not fly far' event.
											--if then
											--		softlock=true
											--end
									end 
							else
									--oh well, i still have grapes, 
									--or can pick some up,
									--and something to throw with,
									-- including more grapes.
							end
					end
					old_hotspots=hotspots
					hotspots={}
					climb_hotspots()
					if #hotspots>0 and verb_has('Climb') then
							softlock=false
					end
					hotspots=old_hotspots
			end
	end
	if place.x ==12 and place.y ==24*2 then
			if not verb_has('Reflect') then
					softlock=true
			end
	end
	end	--if not flags["S"]
	if softlock or flags["S"] then
			flags["S"]=true
			sustain("Retry",1)
	end

	--scenery layer
	if flags[3] or pmem(10) ==1 then
			for my=0,12-1 do
				for mx=0,12-1 do
					sp = mget(place.x+mx, place.y+my)
					spr(sp,8+mx*8,8+my*8,0)
				end
			end

			--plant sites
			pos=placestr()
			if plantdat[pos] then
					for i,pl in ipairs(plantdat[pos]) do
							for ply=0,pl.h-1 do
							for plx=0,pl.w-1 do
							spr(82,8+(pl.x+plx)*8,8+(pl.y+ply)*8,0)
							end
							end
					end
			end

			--object layer
			for my=0,12-1 do
				for mx=0,12-1 do
					sp = mget(place.x+mx, place.y+12+my)
					ck=0; if sp ==69 or sp ==70 or sp ==85 or sp ==86 or sp ==41+16 or sp ==117 or sp ==117+1 or sp ==117+16 or sp ==117+16+1 then ck=14 end
					spr(sp,8+mx*8,8+my*8,ck)
				end
			end
			--duck layer :)
			if flags["D"] and not flags["DG"] then
					if place.x ==12*2 and place.y ==0 then
							if flags["DB"] then 
									   spr(238,8+6*8,8+5*8-2*8,0,2,0,0,2,2)
							else spr(238,8+6*8,8+5*8,    0,1,0,0,2,2) end
					end
					if place.x ==12*2+12*2 and place.y ==112 then
									   spr(238,8,8+12*8-4*8,0,2,0,0,2,2)
					end
			end

			--mirror room..
			if place.x ==12 and place.y ==24*2 then
					--spr(71,8*(6-2+1),8*(6-3),0,1,0,0,4,4)
					if flags["E2"] or flags["E4"] then
							spr(71+4,8*(6-2+1),8*(6-3),0,1,0,0,4,4)
					end
			end
			
			--screen borders
				borders(0,0,8+12*8+8,8+12*8+8,6)
			--hotspots
			if focus ==hotspots then
				for i,hspot in ipairs(hotspots) do
						if i ==hotspots.i then
							surround(hspot.x,hspot.y,hspot.w,hspot.h)
						end
			
						if cur(verbs) =="Move" or cur(verbs) =="Climb" or cur(verbs) =="Chop" then
								--we have invisible arrows as hotspots
								spr(hspot.id,8+hspot.x*8,8+hspot.y*8,0,1,0,hspot.rot,hspot.w,hspot.h) 
						end
				end
			end
			
	end
	
	--sidebar
	if flags[1] or pmem(10) ==1 then
			tx=8*12+4*8-8
			ty=8
			--sidebar borders
				borders(tx-8,ty-8,8*10,8+12*8+8,11)
			--sidebar txt
			for i,verb in ipairs(verbs) do
		
				if focus ==verbs and i ==verbs.i then
					--highlight chosen verb
					for char=1,#verb do
						print(sub(verb,char,char),tx+(char-1)*8+cos(t*0.2+char*8)*2,ty+sin(t*0.2+char*8)*2,verbdat[verb].col)
					end
				else
					tw=print(verb,tx,ty,verbdat[verb].col)
					if verb =="Eat" then print(" (inf)",tx+tw,ty)
					else print(fmt(" (%d)",verbsus[verb]),tx+tw,ty) end
				end
				ty=ty+8
				--if we go overboard, increment column..
			end
	end

	--inventory
	if flags[2] or pmem(10) ==1 then
			ix=tx+8*10+8
			iy=8
				--inventory borders
				borders(tx+8*10-8,0,8*6,8+12*8+8,8)
			--inventory items
			for i,item in ipairs(inventory) do
				ck=0; if item.id ==69 or item.id ==41+16 then ck=14 end
				spr(item.id,ix,iy,ck,1,0,0,item.w,item.h)
				if focus ==inventory and i ==inventory.i then
					surround(ix/8-1,iy/8-1,item.w,item.h)
				end
				iy=iy+item.h*8
			end
			inventory.h=(iy-8)/8
	end
	
	--bottom text
 -- with game loop's msgbatch end event
 lorespam(function()
   focus=verbs
   --but if this is an ending then reset
   if flags["E"] then 
					-- test: gather inputs to string :)
					trace(gatherstr(tloggs),9)
					trace(gatherstr(kloggs),9)
     pmem(10,1)
     reset() 
   end
 end)

	--white box
	--if pmem(0) then --which is 'any ending cleared' flag
	if (pmem(0) ==1 or flags["P"]) and lore.msg ==nil then
			borders(0,8+12*8+8,240,136-(8+12*8+8),15)
			--print numeric amount after resets
			--print(fmt("%d/%d",amt_thoughts(),total_thoughts()),8,8+12*8+8+8)
			print(amt_thoughts(),8,8+12*8+8+8)
			
			if amt_thoughts()>0 then
					--draw percentage balance
					bal,neg,pos=alignment()
					neg_w=(240-8*4)* neg/(neg+pos)
					rect(8+8*2,8+12*8+8+8,neg_w,8,6)
					rect(8+8*2+neg_w,8+12*8+8+8,240-8*4-neg_w,8,11)
			end
	end
	
	if not bugged(placestr()) then
	if place.x==0 and place.y==0 then
	breathe4()
	end
	if place.x==228 and place.y==0 then
	breathe6()
	end
	if place.x==228-12 and place.y==0 then
	breathe5()
	end
	if place.x==192 and place.y==0 then
	breathe7()
	end
	if place.x==12 and place.y==0 then
	breathe8()
	end
	if place.x==24 and place.y==0 then
	breathe9()
	end
	if place.x==0 and place.y==24 then
	breathe10()
	end
	if place.x==24 and place.y==24 then
	breathe11()
	end
	if place.x==48 and place.y==112 then
	breathe12()
	end
	else
	breathe13()
	flies= flies or {}
	local function counthere()
			local out=0
			for i,f in ipairs(flies) do
					if f.src==placestr() then out=out+1 end
			end
			return out
	end
	while counthere()<40 do ins(flies,{x=math.random(8,8+11*8),y=math.random(8,8+11*8),r=math.random(0,3),src=placestr()}) end 
	end

	for i,f in ipairs(flies) do
			if (f.x<8 or f.x>=8*13 or f.y<8 or f.y>=8*13) then
					f.src=placestr()
			end
			if f.src==placestr() then
			f.x=f.x+math.random(-1,1)
			f.y=f.y+math.random(-1,1)
			if f.x<0 then f.x=0 end; if f.x>=240-8 then f.x=240-8 end
			if f.y<0 then f.y=0 end; if f.y>=136-8 then f.y=136-8 end
			if (i*0.4+t*0.4)%6<1 then f.r=math.random(0,3) end
			spr(137+(t*0.2)%2,f.x,f.y,14,1,0,f.r,1,1)
			end
	end
	
	t=t+1
	mt=mt+1
end

plantstats={
		['0,0']={total=0,bugged=true},
		['228,0']={total=0,bugged=true},
}

function bugged(pos)
		return plantstats[pos] and plantstats[pos].bugged
end

params={'p+','p2+','p-','dt','w',i=1}
function autiotupa()
		cls(0)
		if focus ==params then
   -- arrow input to navigate.
   	cycle2(params)
  end

		borders(0,0,8+12*8+8,8+12*8+8,6)
		spr(256,8,8*2,1,1,0,0,12,8)
		print('p+',8+29,8+43+8-1,3,false,1,true)
		print('p2+',8+29+12+1,8+43+8-1,3,false,1,true)
		print('p-',8+29+12+1+12+1+4,8+43+8-1,3,false,1,true)
		print('dt',8+29+6,8+43+8-1+15+2,3,false,1,true)
		print('w',8+29+6+12+1+5,8+43+8-1+15+2,3,false,1,true)

			tx=8*12+4*8-8
			ty=8
			--sidebar borders
				borders(tx-8,ty-8,8*10,8+12*8+8,11)
			--sidebar txt
			for i,param in ipairs(params) do
		
				if focus ==params and i ==params.i then
					--highlight chosen verb
					local col=2
					for char=1,#(param..fmt(" (%d)",paramsus[param])) do
						local mark=sub(param..fmt(" (%d)",paramsus[param]),char,char)
						if mark=='(' then col=15 end
						print(mark,tx+(char-1)*8+cos(t*0.2+char*8)*2,ty+sin(t*0.2+char*8)*2,col)
					end
				else
					tw=print(param,tx,ty,2)
					print(fmt(" (%d)",paramsus[param]),tx+tw,ty,15)
				end
				ty=ty+8
				--if we go overboard, increment column..
			end
			
		-- listen to the radio
		breathex()
			
		mt=mt+1
		t=t+1
end

-- narrator gonna narrate.
-- pmem activity going on.
narrator=22
pg_screens={camx=0}
function postgame()
		focus=lore
  
		-- audio layer
				breathe2()
  
		-- BG
    cls(0)
    grid4()

  -- visualize screenz
  local camw=0
  local scrx=0
  for i,scr in ipairs(pg_screens) do
    if scr.verb then
      clip(pg_screens.camx+camw+0,8,8*8,8+8+8)
      cls(0)
      clip()
      borders(pg_screens.camx+camw+0,8,8*8,8+8+8,11)
      print(scr.verb,pg_screens.camx+camw+8,8+8,verbdat[scr.verb].col)
      --if i<#pg_screens then
      scrx=scrx+8*8
      camw=camw+8*8
      --end
    end
    if scr.place then
      clip(pg_screens.camx+camw,0,8+12*8+8,8+12*8+8)
      cls(0)
      clip()
      borders(pg_screens.camx+camw,4,8+12*8+8,8+12*8+8,6)
      draw_place(scr.place,pg_screens.camx+camw+8,4+8)
      --if i<#pg_screens then
      scrx=scrx+8+12*8+8
      camw=camw+8+12*8+8
      --end
    end
  end
  if pg_screens.camx+camw>240 then pg_screens.camx=pg_screens.camx-8 end

  -- bottom text
  -- with postgame msgbatch end event
  if narrator==22 then
    lorespam(function()
      narrate()
    end)
  else
    narrator= narrator-1
    if narrator==0 then 
						trace(gatherstr(tloggs),9)
						trace(gatherstr(kloggs),9)
						shutup(); reset() 
				end
  end

  t=t+1
end

btnp2=btnp
kloggs={}
tloggs={}
function keylog(k)
		if btnp2(k) then
				ins(kloggs,k)
				ins(tloggs,t)
				--trace(fmt('%.10d:%d',t,k),5)
				return true
		end
end

function gatherstr(tb)
		local out= ''
		for i=1,#tb do
				out= out .. fmt('%d,', tb[i])
		end
		return out
end

btnp=keylog

-- changeable functions.
-- top of game logic priority buffer.

function narrate()
  if #tracker==0 then
  narrator=narrator-1
  return
  end

  local info=tracker[1]
  rem(tracker,1)
  if highlight(info) then
  else
    narrate()
  end
  --if #tracker==0 then
  --   inform_multi({'See you again, the forest will be here tomorrow.'})
  --end
end

function countverbs(vrb)
		local out2=0
		for i=1,#tracker do
				local tr=tracker[i]
				if tr.verb[1]==vrb then out2=out2+1 end
		end
		return out2
end
function countunique(vrb,infoplace)
		local seenplaces={infoplace}
		local function matchplace(p)
				for j,w in ipairs(seenplaces) do
						if w.x==p.x and w.y==p.y then
								return true
						end
				end
				return false
		end
		for i=1,#tracker do
				local tr=tracker[i]
				if tr.verb[1]==vrb and not matchplace(tr.place) then ins(seenplaces,tr.place) end
		end
		return #seenplaces
end

firsttimes={}
function highlight(info)
  -- play of the games :)
  local out=true
  if info.verb then
    local verb=info.verb[1]
    local cntx=info.verb[2]
    local arg=info.verb[3]
    if cntx=='hotspot resolve' then
      -- if is first occurence in pmem and..
						local narrator_say ={fmt('On this run, you first learned to %s here.',verb)}
						--[[for i=#tracker,1,-1 do
								local tr=tracker[i]
								if tr.verb and tr.verb[1]==verb then
										rem(tracker,i)
								end
						end]]
						if indexof(firsttimes,verb)==-1 then 
						if verb=='Move' and info.place.x==12 and info.place.y==0 then
								ins(narrator_say,'You\'ll need a new verb to properly utilize that area.')
								ins(narrator_say,'Perhaps head to a different direction next time.')
						end
						if verb=='Move' and info.place.x==0 and info.place.y==24 then
								ins(narrator_say,'It doesn\'t seem like there\'s anything to do there that early.')
								ins(narrator_say,'Perhaps head to a different direction next time.')
						end
						if verb=='Move' and info.place.x==228 and info.place.y==0 then
								ins(narrator_say,'That direction seems very fruitful, if you\'ll excuse the pun.')
						end
						if verb=='Retry' and #inventory>0 and not (place.x ==12 and place.y ==24*2) then
								ins(narrator_say,'Since you were still carrying items, they were dropped here.')
								ins(narrator_say,'You might find them useful on your next run.')
						end
						if verb=='Retry' and place.x ==12 and place.y ==24*2 then
								ins(narrator_say,'Oh dear. You were so close to the end.')
								ins(narrator_say,'You came here missing a crucial verb. What can you do with a mirror?')
						end
						if verb=='Throw' then
								ins(narrator_say,fmt('You threw items in %d different places.',countunique('Throw',info.place)))
								ins(narrator_say,'Experiment with throwing in new locations.')
						end
						if verb=='Reflect' then
								local _,neg,pos=alignment()
								ins(narrator_say,fmt('You reflected a total of %d times, with %d positive thoughts and %d negative ones.',countverbs('Reflect')+1,pos,neg))
								ins(narrator_say,'Be sure to reflect often on your journey. Somewhere in this forest, you will be judged based on your thoughts.')
						end
						end
						if indexof(firsttimes,verb)~=-1 then 
						out=false
						if indexof(firsttimes,'Throw')==-1 and indexof(firsttimes,'nothrow')==-1 and verb=='Eat' and arg==69 and countverbs('Throw')==0 then
								rem(narrator_say,1)
								ins(narrator_say,'Here you ate grapes and learned Throw, but you never threw anything.')
								ins(narrator_say,'I would recommend picking up small rocks and throwing those. You never know what might happen.')
								out=true
								ins(firsttimes,'nothrow')
						end
						if indexof(firsttimes,'Climb')==-1 and indexof(firsttimes,'noclimb')==-1 and verb=='Eat' and arg==57 and countverbs('Climb')==0 then
								rem(narrator_say,1)
								ins(narrator_say,'Here you ate an acorn and learned Climb, but you never climbed anywhere.')
								ins(narrator_say,'I would recommend checking each location for a climb spot.')
								out=true
								ins(firsttimes,'noclimb')
						end
						else
						ins(firsttimes,verb)
						end
						if #tracker==0 then ins(narrator_say,'See you again tomorrow. The forest will still be here.') end
						
      if out then
        inform_multi(narrator_say)
      		ins(pg_screens, {verb=verb})
        ins(pg_screens, {place=info.place})
      end
      --if verb=='Pick up' then
        --ins(firsttimes,info.verb[1])
        return out
      --end 
    end
  end
  out=false
  return out
end


tracker ={}
function track(info)
  -- expect well-formed packets.
  -- parsed by narrator in postgame.
  ins(tracker,info)
end


function grid4()
		for y=0,136,12 do for x=0,240,12 do
				local period1=(0xa+x+y+(t+2148+(t+2148)*.01)/240)%16
				local period2=(0xa+x+y+(t+2148+(t+2148)*.0135)/240)%16
				line(x,y,240,y,
				period1%3)
				line(x,y,x,136,
				period2%3)
		end end
end

function viewmusic()
		--[[for w=0,30-1,2 do
				local smp=peek(0x100e4+1 +(w*2))
				smp=flr(smp/16)
				rect((w/2)*3,8+smp,2,16-smp,0xc)
		end]]
		--[[for w=0,30-1,1 do
				local smp=peek4(0x100e4*2 +1 +(w)*4)
				rect(w*3,26+16-smp,2,smp,0xc)
		end]]
		for w=0,3 do for s=0,32-1,1 do
				local smp=peek4(0xffe4*2 +w*32 +s)
				rect(12*15-4+s*2,12*8-4+16-smp,2,smp,0x4-3+w)
		end end
end

-- glitchy, prolly UQ's theme..
function titlemusic()
		--[[for w=0,30-1,1 do
				cur_smp =(t*w)%256
				cur_smp=flr(cur_smp)
				local addr= 0x100e4+1 +(w*1)
				poke(addr, cur_smp)
		end]]
		if t%120==0 then
		--sfx(1,12,90,1,0x2+((t)%480)/80,0)
		end
		if t%(20*6)==0 then
		--sfx(1,11+4,100-10,1,0x4+((t)%120)/20,0)
		end
		if t%(20*6)==20 or t%(20*6)==40 or t%(20*6)==60 then
		--sfx(1,12+11-1,10,1,0x4+((t)%120)/20,0)
		end
		if t%(20*6)==80 then
		--sfx(1,12+11-4,10,1,0x4+((t)%120)/20,0)
		end
		if t%(20*6)==100 then
		--sfx(1,12+11-6,10,1,0x4+((t)%120)/20,0)
		end
  if t%20==0 then
		--[[for w=0,30-1,2 do
				cur_smp =(160+t*.01+w*20)%(256)--+(t*.1)%120
				--cur_smp =20*4+(160+t+w*20)%(20*6)
				--cur_smp=220
				cur_smp=flr(cur_smp)
				local addr= 0x100e4+1 +(w*2)
				poke(addr, cur_smp)
		end]]
		
						-- noise rhythm
						-- based on wrong math
						for w=0,24-1,3 do
								cur_smp =(160+t+w*20)%(256)--+(t*.1)%120
								--cur_smp =20*4+(160+t+w*20)%(20*6)
								--cur_smp=220
								cur_smp=flr(cur_smp)
								local addr= 0x100e4+1 +(w*3)
								poke(addr, cur_smp)
						end
		
										--[[--cursed
										for w=0,30-1,1 do
												local addr=0x100e4+1+30*(w)
												cur_smp=(w+t*.2)%16
												cur_smp=flr(cur_smp)
  								--rect(w*3,26+smp,2,16-smp,0xc)
												poke4(addr,cur_smp)
										end]]
		
		
		
 
					
  local amp=0
		if  (t% (480*2+480*2+ 480* 2)) >=
 	       (480*2+480*2+ 960-20) then
    								                     amp=amp+6  end
--	 	   																				 										          if  t% (480*2+480*2 +480* 2) and
--                                                		 >= (480*2+480*2 +960-10) then
--			 				   																	 																															                  amp=amp+1  end
          
   
  
 		
 
  if t>=480*2+480*2+480*2 and t%480==360  then
		sfx(0,12*3-1,15,
		    3,
      0x1,
						0)
		end

		if t>480 and t<480*2+480*2+480*2 then
		sfx(0,12*3-1,15,
		    3,
						0x0+((t)%120)/20+((t)%240)/80+flr(2+sin((t-120)/80.0)*2),
						0)
		--sfx(1,flr(12*5-(t%120)/20),6,1,0x2+((t-20)%120)/20)
		end
		end
end

-- verb has been chosen
-- and resolves in hotspots' context.
hotspot_verb_resolve ={

  ['Pick up'] = function()
   --collect object
      
    -- set to true if no room
    ignore_pickup=false

    -- [[ event system pickup ]]
    --[[//under construction//]]

				if hspot.id==27 then
						inform('It\'s too heavy to lift!')
						return
				end
				if hspot.id==236 then
						inform('A pressure plate. It\'s bolted into the ground.')
						return
				end
				if hspot.id==250 then
						inform('This isn\'t a cartoon, you can\'t pick up the hole.')
						return
				end
				if hspot.id==173 and not flags['hs'] then
						inform_multi({'Damn, that\'s one heavy statue!'})
						flags['hs']=true
				end

    -- jos mahtuu
    if inventory.h+hspot.h<=12 then
      ins(inventory,hspot)
      sustain("Pick up",-1)
    else
      -- no eipA mahtunu
      ignore_pickup=true
      if not flags["I"] then inform_once("You're already carrying a lot. When will you have enough?"); flags["I"]=true; thoughts.read["I"]=1
      elseif flags["I"] then inform("How much is enough?") 
      end
    end

    if hspot.id==115 then
    		if not flags['sh'] then
    		inform_multi({'"With great power..."'})
      flags['sh']=true
      elseif not flags['sh2'] then
    		inform_multi({'"...comes great responsibility."'})
      flags['sh2']=true
      end
    end
    
    if not ignore_pickup then    
      hspot=cur(hotspots)
      for my=hspot.y,hspot.y+hspot.h-1 do
       for mx=hspot.x,hspot.x+hspot.w-1 do
        mset(place.x+mx, place.y+12+my, 0)
       end
      end
      hspot.x=nil; hspot.y=nil
    end
  end,

  ['Move'] = function()
    hspot=cur(hotspots)
    place.x=hspot.nextx; place.y=hspot.nexty
    inform_once("Arrived to a new place.")
    fed=false
    mt=0
				shutup()
    --complex function that can result in 'Windows.. NOW!'
    resolve_plants()        
    sustain("Move",-1)  
  end,

  ['Climb'] = function()
    hspot=cur(hotspots)

    --if place.x ==216 and place.y ==0 then
      -- fix rope, goto oraakkeli & plant verb shrooms
      --inform("A steep climb to a valley below.. Nothing there that is necessary for what you came here to do.")
    --else      
      --if place.x ==12*2 and place.y ==0 then 
      --  inform_multi('You climb on the duck, who seems validated.')
      --  duck force..
      --end
      place.x=hspot.nextx; place.y=hspot.nexty
      if place.x<0 then place.x=place.x+240 end; if place.x>=240 then place.x=place.x-240 end
      if place.y<0 then place.y=place.y+136 end; if place.y>=136 then place.y=place.y-136 end
      inform_once("Landed to a new place.")
      if place.x ==12*2+12*2 and place.y ==112 then 
        if flags["H"] then
          inform_once("<Duck> You haven't Talked to me at all, what's wrong?")
        end
        flags["H"]=true 
      end
      fed=false
      --complex function that can result in 'Windows.. NOW!'
      mt=0
      shutup()
      resolve_plants()
      sustain("Climb",-1)
    --end
  end,

  ['Plant'] = function()
    plantdat.next.x=hspot.x; plantdat.next.y=hspot.y
    ins(plantdat[placestr()], plantdat.next)
    plantdat.next=nil
    inform("3)")
    sustain("Plant",-1)
  end,

  ['Chop'] = function()
    --remove connected trees at same or above height
    sustain("Chop",-1)
  end,
}

-- select verb from green box,
-- with consequence of selection.
select_verb ={

  ['Pick up'] = function()
    focus=hotspots
    obj_hotspots(hotspots)
    if #hotspots>1 then inform(fmt("Pick up which of %d items?", #hotspots)) end
    if #hotspots ==0 then focus=verbs; inform("Nothing here to pick up.") end
  end,

  ['Eat'] = function()
     if #inventory==0 then
        inform('Wizard needs food, badly!')
        return
     end
     if not flags[2] then 
       flags[1]=true --in the case of a speedrunner-caused race condition
       flags[2]=true 
       inform_once(init_msg2)
     end
     focus=inventory
  end,

  ['Move'] = function()
    focus=hotspots
    mov_hotspots()
    if #hotspots>1 then inform(fmt("Move to which of %d directions?", #hotspots)) end
    if #hotspots ==0 then focus=verbs; inform("There are no exits here.") end
  end,

  ['Climb'] = function()
    focus=hotspots
    climb_hotspots()
    if #hotspots>1 then inform(fmt("Climb to which of %d locations?", #hotspots)) end
    if #hotspots ==0 then focus=verbs; inform("Nothing here to climb.") end
  end,

  ['Throw'] = function()
    if #inventory==0 then
       -- omstart: you wanna throw yourself or something?
       inform_multi({'You wanna throw yourself,',
                     'but you\'re not strong enough yet.'})
       -- omstartin lisAmAAre: millon ittensA heittAminen toimis
       return
    end
    inform("What is worth throwing away?")
    focus=inventory    
  end,

  ['Reflect'] = function()
    if place.x ==0 and place.y ==0 then make_thought(1) end
    if place.x ==12 and place.y ==0 then make_thought(2) end
    if place.x ==24 and place.y ==0 then make_thought(5) end
    if place.x ==216 and place.y ==0 then make_thought(7) end
    if place.x ==228 and place.y ==0 then make_thought(3) end
    if place.x ==0 and place.y ==24 then make_thought(4) end
    if place.x ==24 and place.y ==24 then make_thought(6) end
    if place.x ==48 and place.y ==112 then make_thought(8) end

    -- split: ending_reflect    
    if place.x ==12 and place.y ==24+24 then
      --judge an ending
      flags["E"]=true 
      
      --true end if pmem1-5 are 1
            
      if amt_thoughts() ==0 then
        pmem(0,1)
        inform_multi(endings[1])
        --pmem(1)=1
      end
      if amt_thoughts()>=1 then --and amt_thoughts()<=total_thoughts()-5 then
        if mostly_negative() then 
        --endings[2][#(endings[2])] = fmt("You got this ending because you had between 1 to %d thoughts, most of them negative. I hope this experience wasn't so bad", total_thoughts())
        inform_multi(endings[2]); flags["E2"]=true; pmem(0,1); pmem(2,1) end
        if mostly_positive() then 
        --endings[4][#(endings[4])] = fmt()
        inform_multi(endings[4]); flags["E4"]=true; pmem(0,1); pmem(4,1) end
      end
      --not in this build
      --[[if amt_thoughts()>total_thoughts()-5 then
        if mostly_negative() then inform_multi(endings[3]) end
        if mostly_positive() then inform_multi(endings[5]) end
      end
      --]]
      
    end
    sustain("Reflect",-1)

    track({verb={'Reflect','hotspot resolve'},
           place={x=place.x,y=place.y},
          })
  end,

  ['Retry'] = function()
    --drop loot
    -- polish: animation for inventory
    -- draining out.
    --if #inventory==0 then
    --  inform('..')
    --  return
    --end

    for i=1,12 do
      if not inventory[i] then break end
      pmem(100+i-1, inventory[i].id)
    end
    pmem(111+1, place.x)
    pmem(111+2, place.y)
    
    pmem(10,1)

    track({verb={'Retry','hotspot resolve'},
           place={x=place.x,y=place.y},
          })

    narrate()
    TIC=postgame
  end,

  ['Plant'] = function()
    --purple verb: first select an item,
    --then a place for it.
    inform("1) Select an item.")
    --if there's no space to even plant an acorn,
    --then cancel right here.
    pos=placestr()
    if plantdat[pos] ==nil then plantdat[pos]={} end 
    virtual_hotspots={}
    get_greens(57, virtual_hotspots)
    if #virtual_hotspots>0 then
      focus=inventory
    else
      inform("It's already crowded in here.")
    end
  end,

  ['Chop'] = function()
    focus=hotspots
    chop_hotspots(hotspots)
    --usually no more than 1.
    if #hotspots>=1 then inform("Haa!") end
    if #hotspots ==0 then focus=verbs; inform("Nothing here to choppity chop-chop.") end
  end,
}

inventory_verb_resolve ={

  ['Eat'] = function()
    fed=true
    item=cur(inventory)
    if goodfood(item.id) then 
      lastaction={"Because you just ate something good, you have a positive thought.",val=1}
    else
      lastaction={"Because you just ate something bad, you have a negative thought.",val=-1}
    end
    if item.id ==37 then --apple
      if not flags[3] then flags[3]=true end
      inform("Eating an apple gave you the energy to pick up 8 items.")
      sustain("Pick up",8)
    end
    if item.id ==115 then --mushroom
    		inform('Eating a mushroom gave you the energy to plant 3 times.')
      sustain('Plant',3)
    end
    if --[[item.id ==7 or]] item.id ==11 then --rock
      inform_once("The rock does not sit well with you. You lost some energy to pick things up.")
      if flags["rock_chomp"] then inform("You should know better by now.") end
      sustain("Pick up",-2)
      flags["rock_chomp"]=true
    end
    -- bug: still disappears from inventory.
    -- communicate with outside layer
    -- that action was cancelled when
    -- item was unrecognized or an omstart.
    if item.id ==27 or item.id ==7 or item.id ==173 then
      inform("You really gonna eat all that, huh.")
      inv_success = false
    end
    if item.id ==5 then --banana
      inform("Eating a banana gave you the energy to move 4 times.")
      sustain("Move",4)
    end
    if item.id ==39 then --pear
						if not flags['P'] then
      inform_multi({
        "Isn't this what you came here for?",
        "Eating a pear gave you the energy to reflect 11 thoughts."
      })
      else
      		inform('Eating a pear gave you the energy to reflect 11 thoughts.')
      end
      flags["P"]=true
      sustain("Reflect",11)
    end
    if item.id ==69 then --grapes
      inform("Eating grapes gave you the energy to throw 6 items.")
      sustain("Throw",6)
    end
    if item.id ==41+16 then --acorn
      inform("Eating an acorn gave you the energy to climb 2 times.")
      sustain("Climb",2)
    end
    if item.id ==25 then
    		inform('It tastes minty fresh, but doesn\'t give you much energy.')
    end
    
    track({verb={'Eat','hotspot resolve',item.id},
           place={x=place.x,y=place.y},
          })
  end,

  ['Throw'] = function()
    -- default true, can be cancelled.
    success_throw=true

    if cur(inventory).id ==25 then
      if place.x ==0 and place.y ==24 then inform("You hesitate.") 
      else
      if closedrop(6-1,12-2,25,2,2) then
      inform("It didn't fly very far.")
      else
      inform('You hesitate.')
      success_throw=false
      end
      end
      --success_throw=false
      --well, it still drains 1 throw energy.
    end
    if cur(inventory).id ==27 then
      --inform("It didn't fly very far.")
      --closedrop(6-2,12-3,27,3,3)
      --if place.x ==0 and place.y ==24 then inform("It's not heavy enough to push the plate down.") end
      --success_throw=false
    end
    if cur(inventory).id ==173 then
      --owl statue
      if closedrop(6-2,12-4,173,3,4) then
      if place.x ==0 and place.y ==24 then
        --mirror room opened 
        if not flags['B'] then inform("It pushes the plate down.")
        flags["B"]=true
        drop(12-3-2,12-2-2,250,2,1)
        end
      else
      inform("It didn't fly very far.")
      end
      else
      inform('You hesitate.')
      success_throw=false
      end
      --success_throw=false
    end
    if place.x ==0 and place.y ==24 and (cur(inventory).id~=173 and cur(inventory).id~=27 and cur(inventory).id~=25) then 
      -- buggy
      --[[sp=cur(inventory).id
      sw=cur(inventory).w; sh=cur(inventory).h
      if not obj_exists(4,3,nil,0,-24) then
        inform("It flew all the way to the other screen.") 
        drop(2,12-2,sp,sw,sh,0,-24)
      else
        inform("You don't think there's enough room.")
        success_throw = false
      end]]
      
      if spawn(0,0,cur(inventory).id,true) then
      		success_throw=true
        inform('It flew all the way to the other screen.')
      else
      		success_throw=false
        inform('You hesitate.')
      end
    end

    if not success_throw then 
      inv_success = false
      return 
    end

    track({verb={'Throw','hotspot resolve',cur(inventory).id},
           place={x=place.x,y=place.y},
          })

				if cur(inventory).id==173 or cur(inventory).id==25 or cur(inventory).id==27 then if success_throw then sustain('Throw',-1) end; return end

    if place.x ==216 and place.y ==0 then
      inform("It hit a tree, and grapes fell down.")
      --drop 2x2 grapes at 2,8
      if obj_exists(2,8,69) then inform("More grapes fell in the exact same spot, squishing the earlier grapes.") end
      drop(2,8,69,2,2) 
    end
    if place.x ==216+12 and place.y ==0 then
      inform("It hit a tree, and an apple fell down.")
      if obj_exists(4,8,37) then inform("Another apple fell in the exact same spot, squishing the earlier apple.") end
      drop(4,8,37,2,2)
    end
    --something new falls down at place 0,0?
    --no, just a regular banana.. makes more sense since there is already one.
    if place.x ==0 and place.y ==0 then
      inform("It hit a tree, and a banana fell down.")
      if obj_exists(8,8,5) then 
        --foreshadow multitext
        inform_multi({
          "Another banana fell in the exact same spot, squishing the earlier banana.",
          "..wait, how can this happen? don't you have to pick up the initial banana to get to Throw?",
          "please send a bug request-- report to..",
          "..!",
          "..ah, nevermind, i just made a logical error.",
        }) 
        --
        --please send a bug report to..
        --..!
        --..ah, nevermind, i just made a logical error.
        --if pmem(0) ==1 then
        --good job, this counts as a positive reflection.
        thoughts.read["F"]=2
      end
      drop(8,8,5,2,2)          

    end
    if place.x ==12 and place.y ==0 then
      inform("It hit a tree, and an acorn fell down.")
      if obj_exists(5,9,41+16) then drop(5,9,41+16,1,1); inform("Another acorn fell in the exact same spot, shattering the earlier acorn.")
      elseif obj_exists(5,9,11) then inform("An acorn fell onto the small rock, shattering to pieces.")
      else drop(5,9,41+16,1,1) end
      
    end
    if place.x ==12*2 and place.y ==0 then
      done=false
      if not flags["D"] then 
        --sets D in a timed event.
        inform(duck_msg) 
        done=true
      end
      
      if flags["DQ"] and not flags["DB"] then
        --softlocked.. and also when interrupting during the first duck_msg
        inform("Ooh, you're fast.")
        done=true
      end
      
      if not flags["DG"] and not done then 
        if goodfood(cur(inventory).id) then 
          if not flags["DB"] then 
            --sets DB in a timed event. 
            inform(duck_msg2) 
            flags["DQ"]=true
          elseif flags["DB"] then
            inform("Haums.")
          end
        else
          --can be neutral items, like the herb.
          sp=cur(inventory).id
          if sp ==7 or sp ==7+2*2 then
            inform("You throw a harmful item at the duck, who nimbly dodges. They don't feel safe with you anymore.")
            flags["DG"]=true
          end
        end
      elseif flags["DG"] then
        inform("But nobody came.")
        flags["S"]=true
      end
      
    end
    if place.x ==12*2+12*2 and place.y ==112 then
      --island: spawn many acorns? some sort of reflection when all are dropped?
      inform("It hit a tree, and an acorn fell down.")
      if obj_exists(4,3,41+16) then drop(4,3,41+16,1,1); inform("Another acorn fell in the exact same spot, shattering the earlier acorn.") 
      else drop(4,3,41+16,1,1) end
    end

    -- function has returned by now
    -- if throw was unsuccessful.
    sustain("Throw",-1)
  end,

  ['Plant'] = function()
    --purple verb: first select an item,
    --then a place for it.
    plantdat.next=cur(inventory)
    if plantdat.next~=nil then
    get_greens(cur(inventory).id, hotspots)
    if plantable(cur(inventory).id) then
    inform(fmt("2) Select one of %d available spots.", #hotspots))
    focus=hotspots
    return
    else
    inv_success=false
    inform('Any item but that one.')
    plantdat.next=nil
    while #hotspots>0 do rem(hotspots,#hotspots) end
    return
    end
    else inv_success=false end
    if #hotspots==0 then
      inv_success = false
      inform('2) Umm, pick an area that isn\'t so full of stuff.')
    		plantdat.next=nil
      return
    end
  end,
}

function plantable(id)
		return fget(id,1)
end

db={
  --id by corner given; what does it represent?
  [5]={w=2,h=2,canon="banana"},
  [37]={w=2,h=2,canon="apple"},
  [69]={w=2,h=2,canon="grapes"},
  [39]={w=2,h=2,canon="pear"},
  [57]={w=1,h=1,canon="acorn"},
  [25]={w=2,h=2,canon="herb"},
  [115]={w=2,h=2,canon='mushroom'},
  [11]={w=1,h=1,canon="small rock"},
  [7]={w=2,h=2,canon="medium rock"},
  [27]={w=3,h=3,canon="BIG ROCK"},
  [117]={w=2,h=2,canon="bun"},
  [236]={w=2,h=2,canon='pitchplate'},
		[173]={w=3,h=4,canon='Henry'},
		[250]={w=2,h=1,canon='hole'},
		[135]={w=2,h=2,canon='carrot'},
}

endings={
  any=true,

  --we can add "i" upon first read, and check it to see endings read.
  --no thoughts at all, reflect was never used.
  {
    "You reflect in the mirror.",
    "There is nothing to look at, and no one to look at it. Perhaps not even that much.",
    "None of your experiences here generated any thoughts, and that isn't enough data to judge them as 'mainly positive' or 'mainly negative'.",
    "You must be very unaffected by wordly experiences. Either you're a speedrunner, or an enlightened person/arahant.",
    "Good job either way, I look up to those people.",
  },
  --mostly negative thoughts, some in total
  {
    "You reflect in the mirror.",
    "You have been having mostly negative thoughts, so your view of yourself is negative as well.",
    "You don't feel like you have any demand in this world. You've tried so many practices but nothing seems to stick.",
    "Everyone else seems to advance on a daily basis, while you just get further lost.",
    "When you feel that jealousy, it's not about their popularity, but their clear sense of identity.",
    "I hope you keep exploring the details in the forest.",
  },
  --mostly negative thoughts, (almost) all in total
  {
    "",
  },
  --mostly positive thoughts, some in total
  {
    "You reflect in the mirror.",
    "You have been having mostly positive thoughts, so your view of yourself is positive as well.",
    "Perhaps you haven't found your true identity yet. There's still time to explore the possibilities.",
    "However, you already understand the truth that what is practiced, reverberates.",
    "Therefore, you pay some mind to what kinds of food, media and thoughts you consume.",
    "I hope you keep exploring the details in the forest.",
  },
  --mostly positive thoughts, (almost) all in total
  {
    "",
  },


  --first ending: reveal meta information about retries, to motivate the true end
  --this counter shows as a white box where the text would be, after a special postgame event from eating the pear
  --"Now that you know this, the next retry will have a counter.",
  --5 endings in total, none/some/all reflections


  --true end: all previous endings seen
  --prize: postmortem
}

thoughts={
  read={},

  {"You wonder whether video games make any difference, or if they're just distractions.",
   "You have learned so much from the process of developing video games."
  },
  {"Since all continents have been visited, there's no place left to explore on Earth.",
   "Since all continents have been visited, there's so many places to explore on Earth!",
  },
  {"Her celebrated empathy turns out to be conditional, exclusive to a handful few.",
   "She has healthy personal boundaries."
  },
  {
   "Only a beast demands worship.",
   "The Buddhists have many terms for different joys. This makes you cry a bit.",
  },
  {
    "People who are loud, so in love with what they say, drown out your voice.",
    "There won't need to be a revolution, just gradual changes within individuals.",
  },
  {
    "\"I generated this knot, so I can open it.\"",
    "\"We are standing on the shoulders of giants.\"",
  },
  {
    "You're shocked by the weight of having to be alive one year from now.",
    "Living day by day is where your wisdom has always come from.",
  },
  {
    "It was years ago that someone noted you're balding, and you still wear a hat everywhere.",
    "The ways in which your impermanent body crumbles haven't prevented you from developing an authentic life.",
  },
  --[[
  "You're shocked by the weight of having to be alive one year from now.",
  "It was years ago that someone noted you're balding, and you still wear a hat everywhere.",
  "When you said you're fine, it wasn't a lie right then. It just keeps changing so suddenly.",
  "It's not their popularity that you're jealous of, but their clear sense of identity.",
  "People rarely know what they want, they don't examine their impulses. Yet they still act.",
  --"positive"
  "You've got to fix yourself before there can be someone to fix the world.",
  --]]
}

-- just titlescreen safe ones for now..
places={
  {x=0,   y=0   },
  {x=12,  y=0   },
  {x=24,  y=0   },
  {x=216, y=0   },
  {x=228, y=0   },
  {x=0,   y=24  },
  {x=192, y=0   },
  --{x=24,  y=24  },
  --{x=48,  y=112 },
}

--game state
debug=true
place={x=0,y=0}
--if debug then place.x=48; place.y=112 end
verbs={"Eat",i=1}
verbsus={}
verbdat={["Eat"]={col=8}, ["Pick up"]={col=6}, ["Move"]={col=6}, ["Reflect"]={col=11}, ["Throw"]={col=8}, ["Plant"]={col=1}, ["Climb"]={col=6}, ["Retry"]={col=11}, ["Plant"]={col=1}, ["Chop"]={col=6}}
plantdat={next=nil}
inventory={i=1,h=2*8+2*8,{id=37,w=2,h=2}}--{id=41+16,w=1,h=1}--,{id=37,w=2,h=2}}
hotspots={i=1}
flags={}
fed=false
init_msg="Welcome to the forest. You can use Z to select, X to cancel."
init_msg2="If there are multiple items to choose from, scroll with the arrow keys."
duck_msg="It falls into the water, attracting a duck curious for food."
duck_msg2="The duck nimbly catches it and gobbles it up. They get bigger, but not too big."
lore={i=1,msg=init_msg,long=0}
focus=verbs
t=0; mt=0

--asdf test
--sustain("Plant",5)
--sustain("Chop",3)
   --sustain("Retry",1)

math.randomseed(time()*999)
rand=math.random
rand();rand();rand()

function grid()
  for y=0,240,12 do for x=0,136,12 do
    line(x,y,240-x,136-y,0xf)
  end end
end
function grid2()
  for y=0,240,12 do for x=0,136,12 do
    line(x,y,240,136,0xa)
  end end
end
function grid3()
  for y=0,240,12 do for x=0,136,12 do
    line(x,y,240,136,(0xa+x+y)%16)
  end end
end

function draw_place(place,offx,offy)
   offx=offx or 8; offy=offy or 8
   for my=0,12-1 do
    for mx=0,12-1 do
     sp = mget(place.x+mx, place.y+my)
     spr(sp,offx+mx*8,offy+my*8,0)
    end
   end
end

function choice(tb) return tb[rand(1,#tb)] end

function titleprint(msg,x,y)
  -- refers to global chainc
  for c=0,math.min(t*.11-chainc,#msg-1) do
    local char=sub(msg,c+1,c+1)
    local cx=x+4.5
    local cy=y+4+c*12
    local minus=0
    if ((chainc+c+1)*.8 +t*.8)%160>152 then 
    minus=0xe end
    if c==0 then
      local fn
      if char=='f' then fn=494 end
      if char=='t' then fn=492 end
      if char=='i' then fn=490 end
      if char=='y' then fn=488 end
      spr(fn,cx-4,cy-4,0,1,0,0,2,2)      
    else
    if char=='i' then cx=cx+1.5 end
    cx=cx+cos((t+c+chainc*5)*.06)*3
    cy=cy+sin((t+c+chainc*5)*.043)*3
    print(char,cx,cy,(0xf-minus)%16)
    end
    chainc=chainc+1
  end
end

function meirl_print(msg,x,y)
  local cy=y
  local cx=x
  local tc=0xa
  for c=0,#msg-1 do
    local char=sub(msg,c+1,c+1)
    if char=='i' then cx=cx+1 end
    local minus=0
    if ((c)*.8 +t*.4)%120>112 then 
    minus=0xe end
    print(char,cx,cy,tc-minus,false,1,true)
    cx=cx+4
    if char=='\n' then cy=cy+6;cx=x;tc=0x7 end
    if char=='i' then cx=cx-1 end
  end
end

function cycle(tbl)
  if btnp(0) or btnp(2) then tbl.i=tbl.i-1; if tbl.i<1 then tbl.i=#tbl end end
  if btnp(1) or btnp(3) then tbl.i=tbl.i+1; if tbl.i>#tbl then tbl.i=1 end end
end

function cycle2(tbl)
  if btnp(0) then tbl.i=tbl.i-1; if tbl.i<1 then tbl.i=#tbl end end
  if btnp(1) then tbl.i=tbl.i+1; if tbl.i>#tbl then tbl.i=1 end end
		if btnp(2) then psustain(cur(params),-1) end
		if btnp(3) then psustain(cur(params),1) end
end

function cur(tbl)
  return tbl[tbl.i]
end

function obj_hotspots(target_tbl,px,py)
  --generates hotspots from object layer.
  px=px or 0; py=py or 0
 
  for my=0,12-1 do
   for mx=0,12-1 do
    sp = mget(px+place.x+mx, py+place.y+12+my)
    if sp>0 and db[sp] and not pos_checked(target_tbl, {mx,my}) then
     --parse a rectangular area.
     --sprite adjacency rules apply.
     rx=1; ry=1
     while mget(px+place.x+mx+rx, py+place.y+12+my) ==sp+rx and rx<db[sp].w do rx=rx+1 end
     while mget(px+place.x+mx, py+place.y+12+my+ry) ==sp+ry*16 and ry<db[sp].h do ry=ry+1 end
     
     --we now have our object.
     ins(target_tbl, {id=sp,x=mx,y=my,w=rx,h=ry})
     
    end
   end
  end
end

function pos_checked(target_tbl, comp)
  for i,h in ipairs(target_tbl) do
   if h.x<=comp[1] and comp[1]<h.x+h.w and h.y<=comp[2] and comp[2]<h.y+h.h then return true end
  end
  return false
end

function borders(x,y,w,h,col)
  --rect(0,0,8+8*12+8,8,6); rect(0,8+8*12,8+8*12+8,8,6);
  --rect(0,8,8,8*12,6); rect(8+8*12,8,8,8*12,6)
  --spr(80,0,0,15); spr(81,8+12*8,0,15)
  --spr(96,0,8+12*8,15); spr(97,8+12*8,8+12*8,15)
  --for bx=0,12-1 do spr(112,8+bx*8,0,15); spr(112,8+bx*8,8+12*8,15) end 
  --for by=0,12-1 do spr(113,0,8+by*8,15); spr(113,8+12*8,8+by*8,15) end 

  rect(x,y,w,8,col); rect(x,y+h-8,w,8,col);
  rect(x,y+8,8,h-2*8,col); rect(x+w-8,y+8,8,h-2*8,col)
  spr(80,x,y,15); spr(81,x+w-8,y,15)
  spr(96,x,y+h-8,15); spr(97,x+w-8,y+h-8,15)
  for bx=0,(w-2*8)/8-1 do spr(112,x+8+bx*8,y,15); spr(112,x+8+bx*8,y+8+h-2*8,15) end 
  for by=0,(h-2*8)/8-1 do spr(113,x,y+8+by*8,15); spr(113,x+8+w-2*8,y+8+by*8,15) end 

end

function surround(hx,hy,hw,hh)
  --draws cursor around a variable-size object.
  spr(80,8+hx*8-8,8+hy*8-8,0)
  spr(81,8+hx*8+hw*8,8+hy*8-8,0)
  spr(96,8+hx*8-8,8+hy*8+hh*8,0)
  spr(97,8+hx*8+hw*8,8+hy*8+hh*8,0)
end

function sustain(verb,amt)
  if verb =="Eat" then return end
  if amt>0 then
   if indexof(verbs,verb) ==-1 then
    ins(verbs,verb)
    verbsus[verb]=0
   end
   verbsus[verb]=verbsus[verb]+amt
  else
   if indexof(verbs,verb)> -1 then
    verbsus[verb]=verbsus[verb]+amt
    if verbsus[verb]<=0 then
     rem(verbs,indexof(verbs,verb))
     --no need to check for underflow
     --since 'Eat' can't be exhausted.
     -- umm, except when that one event happens
     -- in the deep forest..
     if verbs.i>#verbs then verbs.i=#verbs end
    end
   end
  end
end

paramsus={
		['p+']=1,
		['p2+']=1,
		['p-']=1,
		['dt']=55,
		['w']=1,
}
function psustain(param,amt)
  paramsus[param]=paramsus[param]+amt
  if paramsus[param]<1 then
		 	paramsus[param]=1
  end
  if param=='w' and paramsus[param]>4 then
				paramsus[param]=4
  end
end

function indexof(tbl,item)
  for i,v in ipairs(tbl) do if v ==item then return i end end
  return -1
end

function inform(msg)
  lore.msg=msg
  lore.i=1
  lore.long=0
end

function inform_once(msg)
  if not flags[msg] then
    inform(msg)
    flags[msg]=true
  end
end

function mov_hotspots()
  --check if there's adjacent screens to move to
  --and generate arrows as hotspots.
  
  found, nextx, nexty = adj_screen(12,0) 
  if found then
    ins(hotspots, {id=128,rot=1,x=12-2,y=6-1,w=2,h=2,nextx=nextx,nexty=nexty})
  end
  found, nextx, nexty = adj_screen(-12,0) 
  if found then
    ins(hotspots, {id=128,rot=3,x=0,y=6-1,w=2,h=2,nextx=nextx,nexty=nexty})
  end
  found, nextx, nexty = adj_screen(0,24) 
  if found then
    ins(hotspots, {id=128,rot=2,x=6-1,y=12-2,w=2,h=2,nextx=nextx,nexty=nexty})
  end
  found, nextx, nexty = adj_screen(0,-24) 
  if found then
    ins(hotspots, {id=128,rot=0,x=6-1,y=0,w=2,h=2,nextx=nextx,nexty=nexty})
  end
   
end

function adj_screen(dx,dy)
  --whether there's anything at all in the 12x12 area.
  px=place.x+dx; if px<0 then px=px+240 end; if px>=240 then px=px-240 end
  py=place.y+dy; if py<0 then py=py+136 end; if py>=136 then py=py-136 end
  for my=0,12-1 do
    for mx=0,12-1 do
     sp = mget(px+mx, py+my)
     if sp>0 then return true, px, py end
    end
  end
  return false, px, py
end

function drop(dx,dy,did,dw,dh,ppx,ppy)
  --potential mechanic: items dropping in other screens?
    --ppx,ppy as offset from current place
  ppx=ppx or 0; ppy=ppy or 0
  for py=0,dh-1 do
  for px=0,dw-1 do
    mset(ppx+place.x+dx+px, ppy+place.y+12+dy+py, did+px+py*16)
  end
  end
end

function fardrop(dx,dy,did,dw,dh,ppx,ppy)
  for py=0,dh-1 do
  for px=0,dw-1 do
    mset(dx+px, dy+py+12, did+px+py*16)
  end
  end
end

function closedrop(dx,dy,did,dw,dh)
		for py=0,dh-1 do
		for px=0,dw-1 do
				local m=mget(place.x+dx+px,place.y+12+dy+py) 
				if m~=0 and m~=236 and m~=236+1 and m~=236+16 and m~=236+16+1 then
				return false
				end
		end
		end
		for py=0,dh-1 do
		for px=0,dw-1 do
				mset(place.x+dx+px, place.y+12+dy+py, did+px+py*16)
		end
		end		
		return true
end

function obj_exists(dx,dy,did,px,py)
  virtual_hotspots={}
  obj_hotspots(virtual_hotspots,px,py)
  for i,hspot in ipairs(virtual_hotspots) do
    if (did ==nil or hspot.id ==did) and hspot.x ==dx and hspot.y ==dy then
      return hspot
    end
  end
  return nil
end

function amt_thoughts()
  out=0
  if thoughts.read["F"] then out=out+1 end
  if thoughts.read["I"] then out=out+1 end
  for i=1,#thoughts*2 do
    if thoughts.read[i] then out=out+1 end
  end
  return out
end

function total_thoughts()
  out=#thoughts*2
  out=out+1 --"F" flag
  out=out+1 --"I" flag
  return out
end

function climb_hotspots()
  if place.x ==216 and place.y ==0 then
    ins(hotspots,{id=128,rot=2,x=3,y=4,w=2,h=2,nextx=place.x-24,nexty=place.y})
  end
  if place.x ==192 and place.y ==0 then
    ins(hotspots,{id=128,rot=0,x=6,y=0,w=2,h=2,nextx=place.x+24,nexty=place.y})
  end
  if place.x ==12*2 and place.y ==0 then
    if flags["DB"] and not flags["DG"] then
      ins(hotspots,{id=128,rot=2,x=6+1,y=5-2-1,w=2,h=2,nextx=place.x+12*2,nexty=place.y-24})
    end
  end
  if place.x ==12*2+12*2 and place.y ==112 then
    ins(hotspots,{id=128,rot=2,x=1,y=12-3-2,w=2,h=2,nextx=place.x-12*2,nexty=place.y+24})
  end
  if place.x ==0 and place.y ==24 then
    if flags["B"] then
      ins(hotspots,{id=128,rot=2,x=12-3-2,y=12-2-2-2,w=2,h=2,nextx=place.x+12,nexty=place.y+24})
    end
  end
end

function goodfood(sp)
  --return sp ==5 or sp ==5+32*1 or sp ==5+32*2 or sp ==5+32*1+2*1 or sp ==5+32*1+2*2+16
  return plantable(sp)
end

function alignment()
  local bal=0
  local neg=0
  local pos=0
  for k,th in pairs(thoughts.read) do
    if th ==1 then bal=bal-1; neg=neg+1 end
    if th ==2 then bal=bal+1; pos=pos+1 end
  end
  return bal,neg,pos
end

function mostly_negative()
  local bal,neg,pos=alignment()
  return bal<0
end

function mostly_positive()
  local bal,neg,pos=alignment()
  return bal>=0
end

function inform_multi(msgbatch)
  focus=lore
  lore.i=1
  lore.long=0  
  lore.msgbatch=msgbatch
  lore.msgbatch.j=1
  lore.msg=lore.msgbatch[lore.msgbatch.j]
end

function make_thought(no)
  out={}
  if not fed then lastaction={"Because you haven't eaten in a while, you have a negative thought.",val=-1} end
  if lastaction.val ==1 then i=2 end
  if lastaction.val ==-1 then i=1 end
  ins(out, lastaction[1])
  ins(out, thoughts[no][i])
  thoughts.read[(no-1)*2+i]=i
  inform_multi(out)
end

function inv_has(id)
  for i,item in ipairs(inventory) do
    if item.id ==id then return item end
  end
  return nil
end

function area_has(id)
  virtual_hotspots={}
  obj_hotspots(virtual_hotspots)
  for i,item in ipairs(virtual_hotspots) do
    if item.id ==id then return item end
  end
  return nil
end

function verb_has(id)
  for i,item in ipairs(verbs) do
    if item ==id then return item end
  end
  return nil
end

function spawn(px,py,id,far)
  --logic for lootdropping and Planting
  
  if id==173 then return false end

  --get first available green tile
  
  iw=db[id].w; ih=db[id].h
  fgx,fgy=get_green(px,py,iw,ih)
  if fgx ==nil then return false end
  
  if far then fardrop(px+fgx,py+fgy,id,iw,ih)
  else drop(fgx,fgy,id,iw,ih) end

  return true
end

function get_green(px,py,iw,ih)
  for my=0,12-1 do
    for mx=0,12-1 do
      sp = mget(px+mx, py+my)
      if sp ==51 then
        clear=true
        for iy=0,ih-1 do
        for ix=0,iw-1 do
        gx=px+mx+ix; gy=12+py+my+iy
        if mx+ix>=12 or my+iy>=12 or mget(gx, gy)>0 then 
          clear=false
        end
        end
        end
        if clear then return mx,my end
      end
    end
  end
  return nil,nil
end

function safe_plant(sx,sy,sw,sh)
		for ssy=sy+12,sy+12+sh-1 do
		for ssx=sx,sx+sw-1 do
				if mget(ssx,ssy)~=0 --[[or mget(ssx,ssy-12)~=51]] then return false end
		end
		end
		return true
end

function get_greens(id, target_tbl)
  --all hotspots for a certain-sized object
  px=place.x; py=place.y
  iw=db[id].w; ih=db[id].h
  
  for my=0,12-1 do
    for mx=0,12-1 do
      if mx+iw<=12 and my+ih<=12 then
      sp = mget(px+mx, py+my)
      if sp ==51 and safe_plant(px+mx,py+my,iw,ih) then
        if not within_planted(mx,my) then
          ins(target_tbl, {id=id,x=mx,y=my,w=iw,h=ih})
        end
      end
      end
    end
  end
end

function within_planted(mx,my)
  return pos_checked(plantdat[placestr()],{mx,my})
end

function placestr(px,py)
  --such as the index of plantdat
  px=px or place.x; py=py or place.y
  return fmt("%d,%d",px,py)
end

function resolve_plants()
  --at your own risk.
  
  pos=placestr()
  if not plantdat[pos] then return end
  
  count=0
  abort=plantsites()
  
  trace(fmt("%d items spawned from plant sites.", count))
  if not abort and not flags["P1"] and not flags["P01"] then
    inform_once("Abundance.")
    flags["P1"]=true
  end
  
  -- test adfs
  --inform("Because you get input in a new language, but haven't forgotten your earlier one, you get a bilingual thought.")
  
  plantdat[pos]=nil
end

function plantsites()
  --rotate plant sites and spawn total 3 from each
  pos=placestr()
  for i=1,3 do
  for j,pl in ipairs(plantdat[pos]) do
    --if duck id then spawn insects
    if count ==5 and not flags["Ps"] then
      inform_once("First came the small animals.")
      flags["P01"]=true
      spawn(place.x,place.y,117)
      --Ps set when the bun leaves
      --flags["Ps"]=true
      return true
    end
    if spawn(place.x,place.y,pl.id) then
    count=count+1
    end
  end
  end

end

function chop_hotspots(target_tbl)
  target_tbl=target_tbl or hotspots
  px=place.x; py=place.y
  for my=0,12-1 do
    for mx=0,12-1 do
      sp = mget(px+mx, py+my)
      if sp ==68 then
        ins(target_tbl, {id=128,rot=2,x=mx-1,y=my-2,w=2,h=2})
      end
    end
  end
end

function lorespam(postlore)
 lx=8
 ly=8+8*12+8+8
 
 if lore.msg then
		 local skip=false
		 if lore.i>1 and lore.i<#lore.msg and btnp(4) then
		 		lore.i=#lore.msg
					skip=true
		 end
		 
   for char=1,lore.i do
     lw=print(sub(lore.msg,char,char),lx,ly+lore.long,
              8+(t*0.1*0.4+char*0.1)%8,false,1,true)
     lx=lx+lw
     if lx>=240-8-3 then 
       if not (sub(lore.msg,char,char) ==" ") and not (sub(lore.msg,char+1,char+1) ==" ") then 
         print("-",lx,ly+lore.long,
               8+(t*0.1*0.4+(char+1)*0.1)%8,false,1,true) 
       end
       lx=8; ly=ly+8 
     end
     if ly>=8+8*12+8+8+2*8 then
       lore.long=-8
     end     
   end

   if lore.i<=#lore.msg then
     lore.i=lore.i+2
          
     if lore.i>#lore.msg then 
       lore.i=#lore.msg
       --end-of-message events.
       if lore.msg ==init_msg then flags[1]=true end
       if lore.msg ==duck_msg then flags["D"]=true end
       if lore.msg ==duck_msg2 then flags["DB"]=true end

       if focus ==lore then
         if (not skip) and btnp(4) then
           lore.msgbatch.j=lore.msgbatch.j+1
           lore.msg=lore.msgbatch[lore.msgbatch.j]
           lore.i=1
           lore.long=0 

           if lore.msg ==nil then 
             lore.msgbatch=nil 
             postlore()
           end
         end
       end
     end
   end
 end

end

--populate dropped loot from last try
for i=1,12 do
		if pmem(100+i-1) ==0 then break end
		spawn(pmem(111+1), pmem(111+2), pmem(100+i-1), true)
		pmem(100+i-1, 0)
end

if debug then sustain('Climb',4) end
if debug then sustain('Throw',3) end
if debug then ins(inventory,{id=173,w=3,h=4}) end
if debug then
-- beginner's mind :)
	-- keep tutorial regardless of
	-- cartridge changes.
		pmem(10, 0)
end
if debug then spawn(0,0,5); spawn(0,0,5); spawn(0,0,7) end
if debug then sustain('Plant',6) end

--if game has ever been reset, 
--suppress init_msgs
if pmem(10) ==1 then lore.msg=nil; flags[1]=true; flags[2]=true; flags[3]=true end

-- run game.
		TIC=titlescr
--if debug then TIC=autiotupa; focus=params end

--sustain('Climb',4)

-- breathe. %)
-- my lua implementation of Perlin noise
-- from August 2019.

function perlin(x,y,z)
		--Perlin noise by Ken Perlin,
		--inventor of Perlin noise
		--and winner of Academy Award for Perlin noise,
		--which is his invention.
		xi=math.floor(x)%256; --if xi>255 then xi=255 end
		yi=math.floor(y)%256; --if yi>255 then yi=255 end
		zi=math.floor(z)%256; --if zi>255 then zi=255 end
		xf=x-math.floor(x)
		yf=y-math.floor(y)
		zf=z-math.floor(z)
		u=fade(xf)
		v=fade(yf)
		w=fade(zf)
		
		local p=per_p
		aaa = p[p[p[    xi ]+    yi ]+    zi ]
 	aba = p[p[p[    xi ]+  yi+1 ]+    zi ]
  aab = p[p[p[    xi ]+    yi ]+  zi+1 ]
  abb = p[p[p[    xi ]+  yi+1 ]+  zi+1 ]
  baa = p[p[p[  xi+1 ]+    yi ]+    zi ]
  bba = p[p[p[  xi+1 ]+  yi+1 ]+    zi ]
  bab = p[p[p[  xi+1 ]+    yi ]+  zi+1 ]
  bbb = p[p[p[  xi+1 ]+  yi+1 ]+  zi+1 ]

		x1=lerp(grad(aaa,xf,yf,zf),
									 grad(baa,xf-1,yf,zf),
										u)
		x2=lerp(grad(aba,xf,yf-1,zf),
									 grad(bba,xf-1,yf-1,zf),
										u)
		y1=lerp(x1,x2,v)

		x1=lerp(grad(aab,xf,yf,zf-1),
									 grad(bab,xf-1,yf,zf-1),
										u)
		x2=lerp(grad(abb,xf,yf-1,zf-1),
									 grad(bbb,xf-1,yf-1,zf-1),
										u)
		y2=lerp(x1,x2,v)


		return (lerp(y1,y2,w)+1)/2

end

function fade(tt)
		return tt*tt*tt*(tt*(tt*6-15)+10)
end

function grad(hash,x,y,z)
		hash=hash%16
		
		if hash==0 then return x+y end
		if hash==1 then return -x+y end
		if hash==2 then return x-y end
		if hash==3 then return -x-y end
		if hash==4 then return x+z end
		if hash==5 then return -x+z end
		if hash==6 then return x-z end
		if hash==7 then return -x-z end
		if hash==8 then return y+z end
		if hash==9 then return -y+z end
		if hash==10 then return y-z end
		if hash==11 then return -y-z end
		if hash==12 then return y+x end
		if hash==13 then return -y+z end
		if hash==14 then return y-x end
		if hash==15 then return -y-z end
end

function lerp(a,b,x)
		return a+x * (b-a)
end

--https://xkcd.com/221/
permutation = {151,160,137,91,90,15,
   131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
   190, 6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
   88,237,149,56,87,174,20,125,136,171,168, 68,175,74,165,71,134,139,48,27,166,
   77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
   102,143,54, 65,25,63,161, 1,216,80,73,209,76,132,187,208, 89,18,169,200,196,
   135,130,116,188,159,86,164,100,109,198,173,186, 3,64,52,217,226,250,124,123,
   5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
   223,183,170,213,119,248,152, 2,44,154,163, 70,221,153,101,155,167, 43,172,9,
   129,22,39,253, 19,98,108,110,79,113,224,232,178,185, 112,104,218,246,97,228,
   251,34,242,193,238,210,144,12,191,179,162,241, 81,51,145,235,249,14,239,107,
   49,192,214, 31,181,199,106,157,184, 84,204,176,115,121,50,45,127, 4,150,254,
   138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180}
per_p = {}
for i=0,512-1 do
		per_p[i] = permutation[i%256+1]
end

suddensndfgm= '524946463482090057415645666d74201000000001000100225600002256000001000800646174610f820900817b7f888785817e7b7a797a797776767a7f8587857f7b828b938f8b848583807e7c7d7a7873706e7172736f7373706e71747877777a797a797d7f8284878c979ea2a6a8abadaeacaaa8a5a4a5a4a7a6a6a7a3a3a7aaadaaaba9a6a09b968f898482817f7c797580817b716969676766696f70736a676b707272696567625f595b59564d484848464640424753554e545b62615e626b707170737982817d75737374747881848a8d959ba5a8acadafaca7a7a9a8a49e9a94908d898481808180817b7f868e8c838c93988e847e7c828787827f7b7c7c7d7f83888b8e979aa0a3a4a6a9aaabaca9a7a4a09c9b96918c88837d7f807e817f8082807e7e7c7d7879736a6b6a68646267676d7376767576787a7977736f6b676c7674726e7074797b7875757b7a7a77757270706f6b625b5857575454514d4b4c4a4749474a494d53514f4c535a66697380898c8a817e878c918f908d8f8a8a8c8b89828381868f8f8d8688888b8b8c908e90949ea3a4a3a1a2a3a4a4a6a8aea5a09a9e9f9ea09d9fa1aeb2adafafb2b7bab8b1aaa9a6a1999390928a86818383807d7a7b797d79716c6a6c7074736f6966686d727b8083807d7d7f83858886807c77757575726f655e5a595855524d4950565655504c4f5254514f53535961626262676c7071768a929393929ca5abb1b7beb5b1b3b3b6b4b7b3b1a9aaadaea79694908f8b8b8c8b8b827e78797e7a74726b6f757b766b60626c72736e71757e7b7b7a7f868c8a8c929296999e9a9999999da19d978f8d8b86807a797f817e7976777a7e7e7b7d83828386817c74696e706f66656b685f4f4a4b4f5b5d544c4d596260524f4f575a5b575c6161635f61626c71767374767a7c7c7b797b7a80868e8c8a898f98a2a29b9da7b7b6b3b7bfc4c2bbb9bbc2b9b6b7b5b0a49e989c8b88848a857d797a827a746b737575706b6a6a67656664626263697376736c6a6c747e838383858d92989ba5a9a79c9596989f9fa0a6a9a8a096938f908f9695938884888b8777726b6c64646765615d5a5556595e5f5c524f52666e68635b5f5f6b7479797473757878756f767a7b716a676f78767366615f65676a686c71756f616066727b7b766f6e7374726c727e8c8b89848991979a9394949a9795888b959893837b777f7d82848b877c716c717a7f7a736f767d83797168686c777f81898d90888179889398958f908583808d88786e6c756e6b666e77756f68686d72747473767b81817a7675797e84878f91898883808b969d958b88889696959397a2a1a09897949392969f9e9d989a969694979c9f9e9997938f8e94a0a2958f8a989e9b9c9da49f9c969a9d9fa9aaa59b959092949496948e847c817d776d616d7575655854596165615b56595d5d65696e645d5c5a616b716f6864656a73777a7f84837d787b8b939894918b878c90978b86849298948f898b8f948e908c8d8c928f89858690858177878c8b817d837976717c8385817c7776767b77787d746e71797b77706865646f736f69615e5958556468645d5a5c5d5e595b5d6363666873787a7d81807b797c89939c9a9490929ba09c97908f949ea5a49c94989a99918a89868b8987796f71686b70746e625d5c60605f59595a615a5c616b6d6766677272726d6f7173777c7f7f7b76727f8a8c88808181878c908d858b8f938d8c90919494999da6a4a59e9390919b95958e99999a9597a3a2a3a2abaca59d948d9299a5a1a1a09c958f92979388807b7c7a7665665f5c53545e5d5d585555595a5f65676a6f70706c7a878785848583898d91979a97887975747d84857e74706a625f5d5c6163625c585759585a5b615f585357616b6f6872777d78777e818b92989799979da7a8a59ea5aaa9a9a9afb8b6b3b9a7a9b1bbbaafa19c9fa2a39b9c989b9497999c95887f7f898b8677747677777779797a78797676727a7f828a8d8a7b6e6b71777878777b787a7a7b7b797a76787a7e7b706f6e7470747a7c7c707a797a7474787b78727c80857b736d6d6b68676564626d7377726d6967696e6a696b69676766686a6d6f706c6e797577757e878a8c86858a8e98a3a7a7a2a0a0a4a6a9a5aaa9a8a5a7aaa49e979a9fa6a4a7a5a4959192928f818a8c8d7e726b6c6f747b7d817973706b696967645f666d6f6c6767677274756e6f767c807f87868783878d8f8d858489929390878581807f7f867d736c6967707c7b746766666778828683807f7874747c858b86808180848a898c9093928c867f7d7c7f7f7b7a756f7272716b66646b707070695f5a595b61666a605952535c646d747876716f71787d7d7e7c7a7773726e70797f8a989fa3a2a2a1a5a3a19b999b9c9a8f868484888d9294939294979494949899938e86828182868179706d6c6e706f6f6e7678736b6465696f746e6866626162676864686c706c6b6e696868727c7f807d8085888a8d969c9da09b9794989ea5a39c9795979ca0a5a9adafaba49fa2a6a3a0938e8e989b94928d8c878a919ca09fa09f9d9a999a9a97938f8d8b959993949195969691878384888a8887807f807f7e7b8386807c726c696a6e6e6c696b6b6a6b70727269687073746d6e71777e8079736f726f737977736d6a696b6c70777976726e70757d7a78757d868b8b837a7576778186897f7b80818284848b989da09c9c9fa19e9a938c8989908f9392938d837f7e828486858381807a757373727068625e5f5c5856575b5e5e60605f5c5b5c606668666365686970726c6d6d717e878b8e8e919395979a9ea2a6a29d9895949895918f86807b7c7b7a77797c80837e7c777375787c7879746f6768726f6e64615c5c5f6468625c585e656b6969686e7275716d6a6f74787f807f7b80848e86878a8c8c88888a948e8c8992959796999fa2a7a6adacadaaafaaa2a2a5aca1978f8c8a868d929794939495979698969089827d79757470707173727173767874716f6f787d7d808284858178736e7177818987878987898c969d9c978f89838c8f9288817c7a776f716e6b68686a71757172707370747e82817b7975747070716e6a6767666a6d7173747476797f848b888a8c908d8684858e898682807c80868a8e8e92969ca2a4a29f9b999c9f9f9f9fa09f9f9e9b98979593918d8b8d8d88837f818484888a8a888383858a8e8b888686868382796e625d595957535454565556555a5c636c6f6f6c6a6c716e6f6f7578797e81817d79777e848a8887838d918a86817f7d808389888c91989a93969799a1a7aca59f9ea3a5a0a3a2a19e9b9c98938e8989898c888a8e9ba2a39c959396999a948e8b89867b807f7b736c6a6463646d757479767a7c817f7975767d7a7974746f696665666a6c6a6a6e777b7b78747274747b8182847f7b7776777876767474767878777b7d7f81848688868481807f7874767a808485827e7d767778858c8d8d8d92918f89898b91908e8a838083878a8987888b8c847b727377777773736c6e777d817e7e7d7d797674726f6e706f6d676361615f5f6063676972797f7e7c7a80807a78767574747175777880848686898e90919293959591918b827973706d69646361636161626366687175767474767778787775777878736c6869706b6a66696a696b6d73757a818184868685818788898a8c8c9194959b9c9fa1a5a7a7a4a3a0a5a8a9a9a8a9a49f9998979698989b9ea1a3a5a7a6a8a4a3a3a9aba7a29c9a9a9a9a8d84838082818685857c797d8087898a85827e7d7c82898a878179746e707778756c6a676a696967686869707677736f6f777e7f7b77797c76716a6e6e6a69676a6e7272777b7e7e7e818183828685818281857d79797976727374747075797f80807d8080808285898d8b857d7b8282837f7b7c82878a8c837f848b89878b8d92918f88837e7d7c80818182858c88878982807e8486837d77757473767c75706d6b6b696a6b72767b7e8482817d7c7b77706b64666d6b6a635f5b5e5e67686268727f84858285898e89868384848083807d767474757371716f6d6d6c6b6b6d72787d808083888d8a88878b8f9392929093938c8b85847c7a7a82837d80828a8b90949a999a989fa19d979399969b999b94908c8d908d87807e7d7f83888d8a85888d949691929297959697989898928e8987847e888b8a86807a756e646161655e5555595c5d5d5d5d5c5f6269696d6e7072767b8082817a72787f80837d776e6d7c868e939594918c8783807e7c7d7876737777726d6b6b6c6c706f7481898c858181929597938e8e8f908b86808e9491867c797b848d8b8c9093928e8689999da09b9084868a888b8f8e887d76767a7b7a7a787b828786817976767d82848487898b867c8081817b71686460616568676565686c6865626a6e6f6a6767696b6b6d70767a7d7977726d6762636b70777a787775808688827d7d888f938f8e949da39fa29e9a97999b9d98979994928b8f8d8d888582818080888d91909192999c999d9ea49d9c9a9c9a94989c9c948b847f7d7b77736c696a6d737271707e888788827a81898f8a84838387858784858182797272777f7c776c7071756e6f7278797974767e84847d7c797b7e88898c85858d90918b88817f7877797e7f7a7a74726e6f726e6b656c6f6f737a8a89828082898d8f8e8c8a8d8c888a8e979797989c9f9e9d999397999a958f8a7d726b6c6d6c69686968696869676b737879757473716b6766696f777b7d7f7f7e797f82827f746c6a767f817d7672757b7f776d646b7272726a655b5c636969665f5c5e646c6f707370716d758087878180838a8580757672716f72797c7c747c828a8a88837e787b7e7e818587888884817f7c7d85888b8a8a86867f8087888a8c8c8a8b8f97a1a39da3aab2b2aea6a2a5a9acabacaba69d95919596958b807a7e7f79756f716e727a7c7b7d7e898f928f909397979491929698968e8a86847d77717677786d686a605c5c61636362615e5d5e61686e75797b7a797778787d7c7c757377808583898a8d8a8b89868488928e898182868b8d8b88888a8c939699969595857e79828480766f727479797975716c6c6a696b6d6b6b6b6c6d70727474797d89989c9d9a9d9c9b928d9092928c817d7a7979797575716d6a6b6d6d6c6c71787b766d67676a7173797f87898686888885807b797675757b828685817f7e818686847e83878a8b88837f7e7e7c767776767472757a80827f78736f717071717c828582828b8e949395918b87898f8f8786838a8a84878d9a9fa2a0a2a3a4a2a1a09f9d978f857d80878b90897c706e797c7d7d7a7b7773706e6c6e6f737d8a969ca0a2a9abaca8a4a1a1a2a1a09b93867d7c7d7a71655e5b5c5b595a534e494546494f4f464548545d696e7576767d838a8d93929189878b999f9ea1a29da29d968e8e969086766f6f76777b7a7c7d797d818a8783807f8384837d76706f6f6f767b7e7a7b7c8486888c9193918c86888d92918f8889898e949ca2a4a9a9a79e948f878584807a7172716d6a66636465626365686b6f73797d8182848384817e7b82898a8b8888848482847f75716e6967615d5e6066625d5e625d5a5c5f6162686c6f7272727378828889878888898887888e9392959593908f94999b99948d88838889888280847f7c777c8083807f7f858e959d9b928b888d90928f8b8f939a9898989c9b989597a1a3a49e9c9793929191908d8c8a898a8f9496979192959a99938e8d8e8d88807a76757777746f686566696c646163696d6e7980898b87817e848c9498968f8782817f7e7e818281817e80797777726f6c6d6c66645d5e5f6263616669686a7079858c8d857f7e82878988848079787b80888f91908e8a878683807b74706e6f6969686c6b6765666c6d70717a8185817a6c6c6966656669696b6e7879808590969895969a9ea1a19e9a958f8c898b8c8b857e76767477777a7d79736f6f69656261646764605b5e62646d7173757778787f8d969b989999989e9c9897918c868887827c777774797e817c7674777d82837f807d7775727575787c7c82848883848d949c9fa2a5a6a6a5a3a2a4a4a5a09897979c96918d8e909091919294908a8483858889888986868485817b797b84868b8d929495898382898e8b8e8b8b8b8b89878381817f7d787d7d7c777579797b7675706d6e6f7272737776787b79797b7c7c808585827a7977787b8289898b8a8c8d8d8c8d8e93949289858386857b74696a6768645e646a6b68645e6165686c6d726f7071716f6d6e727b7e82868e939396979b9fa6a5a09e9ea09d978e8c8a87817c78726f6e6e6e74717374797a757473726e6a67686564605e58525458605b5c60656c6e75777975767e8183807f7d7f828582827b7f899294909697969596989c9d9c938c868b8c89837e7d7776747d807d7f7e81878e9392908b87888e959b9fa0a2a4a4a7a19a908e938f8b878d908f8378707178736f6b6b6d6a696b6f7372747471797e82817f7f83888d949698989ea7abada6aaaaa8a79d9a9798928a827d7c7a766f67626262615c5d5e605b585557565252505151565654575b6163676e747e868d9292979c9fa3a5a49d97908e8982828384817e84888a857f7a808888807470707273716d696a6e6b6d6e717170737a868b939ca1a5a5a7a9adaea9a2a1a2a7adada79ea0a2a1989390928d847f8088858075797a7b766d6f7275736f6f747d8082808281807e7d7e7b7c7d807d776e6b6a7478756d6a716f685f5c5556585e61605c5857585a5c61666969696a69696c7075777e8084828286878789909296989ea1a6a29e9d9592919495928c8884898a8882808686847d7b7f868d87848086888785858a89878584868b8c8d91979c989e9d9b9b9ea3a5a4a1a19e9e9e9b97948e8f918f897d7c7d7e7e7872757b80807c7a76757573727371706e6f6f72797b80838c8e8b8482868b8d8c898887817c777978777478818485828484817f7a7774736f6a6a6965625e5c5e6264615f5e63635f58575e65696665676b757c82878d8f8b8984827a797b7f817e828891918e89838387898b8990908d827976767a77757375797a7d7e82827e828586838081858e989b9c9a9a98928b84817e79706b696861605c5a5d5e5e5b5e64696b6b6c6e6f6d6964686c6f6e6e717b848a87879196979aa1a3a5a2a2a1a4a5a6a4a5a4a0a19e99918d8d949897928b8285847f78716f6e6e6c6d6a69686c6b696464677178797a7b82878e93969a9d9b9a9698989b999a9c999896929394959a9b9c96989da4a5a599979b9f9e96908e918e8e8c9293928e8a8a898787899296958f8b8c8782767976746b696d6a68655f5d625d5b5a5554565856575d63696e6a696d787f817b7674767c83848a9096948f8e929d9b9a95959698978f88817f7b7774727473767c7b7366626163615f5d5c6062626160666c6b6d6c7072787a7b858f95938e8b8c9197999a9898979993969a9d998f8983857e7e7f8284868988847a7774726a6460606060585352575a595958585a5f636d7378797b7d8283848786847e7b7a7e797674787b7b7f808180808082828381838a919491959695928d8d8e8e89827e828d8c8c898c8e8f92959b9fa2a2a09d9f9b9896918d8d8b89878687847d756f6d6e6e68666361626365615d595c5c5b54565e6972787f83858687898f9296949b9fa7a3a5a9aba89d9e9da0989494989b959086827e8287857a6c696a676361615f615e5a5b606667676261616469727c828891989fa1a4a09795939591918e8c807d7e84847e797574726f697073756c66676666616365676b6a686b707e85888b9096999b9b9c9b9b9a979a9ca1a5acb6b6b3acb1b4b6ada4a0999a9a9793969c9f9a90857d787371727475716f6c6c6d6f71675e595a5d5a5e5b5752545d5d5b57545960656c727780878d90939595928d8b8a8b83796f6b6b6d6c686163676871767b7f86878a8c93999c9d9aa2a8afa5a09c9d978c85828687857e7a757168666c6d6b67635e5a575b5f6462615f63676b6b6b6f717c89969b9c9a9ea1a6a6a3a3a6a5a49b99989b99938f8e9699a29eaeabaa929194afa77e8085a7847f838983707378766b5c5b6a6d695d5b6471827c685b5b61787864605e6c5f5f606c6d68656979899b99928f8d8b9facb5998e98999a8e807473767976655f65797f6e7877756c666d777e706c6e829a8d8281898d7d7c737271767e675e5a787a61544e5b5d6367778580766d6d7569646a7279747a7b80919fa9a4a7b1b2aca2a1a6abb1a7988786938a848895908a778485857d7c8a746b5e6b6c655e5a6262635f5c59535f605d545d7c75625a556e7673676c8687846f7b7e7e8f979b8b83838d99a2a5a4a6a6afc1bab3a9b0bab5b4a29b93958a7d80878977635a5c6c7a766b66778a9087797684919187808d8a7c727581867f726d6b838a88736f7c7a78747884998e857b878e8b888183858e949b9ca2a3aaaaaaa39d9da0adbabab09d9a9798989aa390877b8a8c8388878a7665697372737173726b6e6e676c68675d606e737161625f6c65707c7e77696a73897e77787b7e7d7a6d626060676f7a7d7a6e6967757c79848b8f837973777f86847a6c6965636066686f6a6d76787b7b8f9ba1978f8e9ba4a0a6a39c9e9c9e90919aaeb18d857d828c999c8f89807e848d8f897c7166615f5857576160564d4d555a5a5765757e7e6b6d7a8a8f8987878d837e7d84847e7773757e807e6f6c7a7d81767d7d7e797477748c91907871788a90798f8f937b767c75736d8c9c9a8877787887998e827884887f7587908f807c899093839499a49085808e95918a838c79766c7b7b7a706f7b8380828e8b8e879ca3a89d9ea7a49a829096999c9b9f94949997917f8c8f957e767d788789877468616b6f6c6f6b6a5d58586169687b7d766a6978808d92a8aea49f9ba1a0a7a5a39c9792979791a2aaad9c8d7e82817280868f80786f6b6357565b685a4b494f585c55575454585e625c57535d646a605e6c68685e6c72717f88978f96a6a8a19e9ca0a1a3a8b0afb0aba8a3a6b0a5a39eaeaba188879da1997e727185847d6865757b7f685f5e61645e74786f5e555261635754596d645c515561747872626974766f5e5c6475766a616672929f98908b939ca5ada7abbabfbfb3aca7a6aeada5a0a09b8d87817b7d7b726960615d62696c655b5c616b645a4f566065686461585a656869676e6a7073817e78727a948b867b8d99a19e9ca1a5abacb1b5bdb8b7adafa6a5acbbb7a59d99a5a09f999289888c8f897d71767283978d7f6a7f888772666b7377625f676c6a5e5b5d7a85796d666e828a7c6d5e665f6d798986766f6e7f757b8190908283827f74767b88969b9a8f8c8b9ba0a296909192908d94999e887460676c6d6c6f7476746c605b585f5f68736b604f636c6f60585974807d6f6b7785826861678a847c726f848b8170626067707b77798284848285847d8588917f7775737471848d7a67666c7e706e71787974737a8e8f8e7d847e6f7275867d89a59d92797c7d84a2b9b2a69799aaa3a19eaaafad97889387919a9a8a7271737a797f848f918e8f959e968a94a09c897875869f9a908d939fa3937d718495988371747e8b89807675909a85776f8289847c7b8a94918a7f7687949c9690908e8e8c8f89807d7c76756d6b6c7d8e8777788c878d98a0a18e9c97928384968983787f7f7e8694a09b8b7c71778a8c84747a7c7c7b80858e8179756a67666e707068605c6063665a57576c746c61595d606468686b67605150566160575e667872706a8394a09898a8a09d889b999686899fa1a09ca8a4a89db6b6a6a39ea5918e8fa4a9a18878737c81786d6568605d505c5a52535d564343464f5b616560605f61594c4952656259494d536363687187938c7e779da2a593837d8388908d7e99a9b2a99f9ca8b2b6aca4a1a5a9a3aaacafacacaf9d979ca4978d80847f707473806e727f8379645c63728181766566797b755c635f5c59656667555875777b6c838a918e9498a6a8a58f8b9e98978aa1aaaea9a39d9b9b9e9b9b9f97a6a39690929fa09a88837e798486856f68717371636b6d706b696868718b958d8d879a9781746e796c6d7873726b767a808594aea39d969c9e9a9f9b9392907f797477828c8f86796f727b898e897b6e6464666c6d66686560585357585e616d756d646163626a645c545f79888f8a84868f969588837e7e7b7b7c80848987899299a49fa0989ba3a8a7a59792969490797c777e7f8a9783736d81959f968579787a7270707572675b565a616b63677579745f5a555b636b6f6a6b767b848891928a9796817177757870788c8f887a78828ea8a799888ba1a6a08c8585948f8b7a86878282869d9b9a8c82757d8fa0a08f7f7570797771666776716d5f6e73767471766d7485898b8e9ba1a8a9a8a192a1a7b2968a878e8c8483879688807f8392a8a5a0919ea09d9696969284828c8581758a979f8f827f8690918f8c9198998a7a6c68727a7b6f675e61585e6c736c5a5454585f615e7683867b757b84887f776f6d7a7b6e574a51575d5c646b6d686b707b818c93a09e8b8d8b918d8f9289837b838588858d9da7a4928d92a7a5988a8574727878787175736e645b55555a6259514c4b50585b606970747476767b7d828180796c5c545967787a7366667087908e8789929fa09593939e939295999587837c8ca3aead9f9a9ba5adb2b1aba5a1a9aba8948785898d8a857d767070767a78787d75747780806f8184846b5c575b615c6e6d6553525c6a6e646268798e9682818d9eada79f95969693a2aab19f94918e959dabb2b1a9a4ada9adb2ada8a5a79f8e7b7b7d7e827e726964636b717e787c83827e7d8491a1978c828081797d7f91908e78645d687b898a7a8184938180848781726a696f757168646b7e78725d6461686e79756b606478766e5c60636d615a555e625e55504b5c615b52566c7b7e6d6f72827f7d7c777e78756e7685847e747f8584828291a0b4bdb6a69b9ca5acaca7a39b99959087838c868786857c706d748682807c766f69625f62666a655f4f44454f5f5c4f4c484a464a54677b83817a7a839592928f9fa49991868e878e93948c898994a3aeb1b6bdc1bdafaeaeb4b2b5b0b0a4938684918f908b9593898f918f95918d8b91908976737c7b7361605d5e585c616e6f695a555a6e77757679827f7971727a9089866c655d66777d785b6c727b797d8d8c97a1a59d8f8d95a6a4a6aaa0978d909498908387929ca1a19c98999a9c9c9b96908c8a888a857c6a5848525c625d585d565d686358606d848a896e697e82877681797664697f7d745b6873867671717c878581726d6c7973746470878e85705c5a666d70667177827a7b83929b9791898a939b969a9697908d827f787f89867b6c767e8580776f7b878f7f6f616b7270736f765b5351657173777070717c8ba19f9e9195908990969f8c86829a9e93817d919cabacb2aa9fa0acaeaa9b908d908d81726c78848979654f4b4c58635d564f5657555d697b878c86888c8c8b8685888e8a7b7670717a88969694928e8e92979a93948d8484878f8c8b8b8a837a70808c939399aaaeb0a79f9ca8a8aba4a2988d8c92a08c8176726b666f7b827e69636870706462606a5f5f60615c53575b645f5e5b666d70737984857f7174848a9786888e98948481838d89806e6e717a71706f91a09c8f838c89908a949193857265595c5c5a56524f4a443e3c414c5d67685d585b7283877e736d71757070727f7a7a7582767e8d9b9d8a95949c7e7d8d9da49e9691988f877c777478707173767277809090827373888f95959797978e83787d878f93887874767d77757f7b7d787d77767f807d7478797c797e8797a1a09c9390878c92a5a9a4a9aba5aca99da8adaeaeada69e8a82859ea79a8f83818b9aa5a6a4a1998c7a7270776d6c71655a4b4441464b473c303a4044474c5555575656595e656e7b8186807d74757d91a3a193848e999a919ea8ada09696a3aba7a299979b9c9389848e90948d8f877d828da1a6aaa7a49a8f939499a29e9e9d9894958483918e8875736b6278868a7c695d56595964676c706e5e50484c5d5b65767e7c6a605755677784796f677278787c7f867368636e757280999e9d867e84979d92979ca4a1967f848b9490846e6e6960676b776c69686a6c788a898d89938e86848a97989080808896939289919393888481817a66777c7d6c60626660584d636e6959484b454f5164645c5c616f66677182919aa09f9ba4aab1a3999b9f9789857f8b96aaa8a2888799a0a197a1a5a695826e6f7a9089888b8d8e878e8a8478858784706570707f888c7d6662656d787c7c77726e636166717a7d7a7b858384848a8887867e777574736e726b5c4e4c5c6067636a66605c6177777b7780838c89847a748aa1b3b3b0a9acb0beb2b3b4b9b0999fa5b3aeaba8aeaeac9f948393988a827b72686469827e807088857d717a97999784878486746e6f7f8a897f6d5c5e6c6f776a66665e574d535251555e696259545564787f766159525a576986897e6168787b7f71789195928c8185939a95828b91969da0a4a9aeaea99c8e959da1a5a08b7c827f816c696c767363605e68615e5b5d5d615b5c64727a7976758080888f959ba4aea4a19ca39c8899aac0b8ab9d8c8a90a1a7a79b8d7d726b6e7175726961636165646275838a7d767c88959e9d9890948d867576868e8b7f6e697473705d686d7e6b5955545e69716e6a60686d7f737a8a96979083858f9894827e838d97947e8e98a89d94959896989ea09f999492979a9a88a3aaa59c97a1938e86857d716f6a61626361615e5e5f575252657477847f7468606560676e838782787e91989b929fa2a6908da7a8a0968e9a9d978176808a938c826e665b5f68706f645f5b5e5e666c7f898e8f8d8b80847e797779837a7572777d837d7a7a78797a716656626862625b5a4749526b7a766f717074747e89897c69646b82756f64787f7f6d6775787e728289998d8a8184909ea7a9a4949fa1a6999c9fada6947c778c8a8d82776b66676f74868f919797847d767a8a7f7e7c8386858486899ca5a59c9ba9acb2adafaba79b959a8e91969894877d787471727272635d556362544c4f5e65635d5861787d79696c707878787b7c89888b7d7c7c82868f94979686777076808a807a7582898782828c939ea0a6a3a0a7b2afb1a09fa29d94858f979f99938f9da5a8a59f98a5ada9a8a1a29a9ea3aba7948a938f84838994948b77635b61605e595453524e4a4a4b54585d534949556c68645b5953535961718590999f9d989391949d9792898d8a837c787a787f87878684817b7b817a787276767374767b7e7e7c7a7b818b94999692918f92969896908b8a8c8475757882807268605a5e615d5e5a544f4e4f5960636d6f7164636e6564636c727a7a71655a646e7a77777c87919a9498a1b2b7aba9a8b3b4b8bdb9b8baa89c959ea5a5a39b958c837a767476767a7a7a746c66686a6b6a67615751555d67716f6e6d78818b8e989a968d878e8e9087867d727274776d6b72787d74736a6165696b7275776d5f5f6270787775706c7986959396999a978692949b9daab8b6aa909ba7b6b2acaca098959794979b9692959ea5a19f9da2a7a9a49e9696918e8e817a74767470717675756a7080807e797b869b9c988e878486817c797a80808a87847977757f7c716a645d56595a62524a48484b4e575e625e584d525869646975787b7a848d969a9b989b9e9a908e90979390888a89808f939389817e7a7a8182878888837975727572757c837e7871797b828592a2a7a1919397a2a5a7a0a7a1987f767f7f7f7b7a7d8687867f878f90918d909791877b76736f6e69676163686a6c737276747e7e77858e94918e8c9291969ea59f9688858a918d82757789888370777e8a89857b71675962676e6a67534d464c575d5d565a606c6a6f747e8b979ca1a19a9595a6b0a9a4979090979d938e97a3998d798b8e8b7e7a83837d7077849b948b807473757f7f727f889383829397998e8d8e9491938b878d979e968776787a7671655e535a6d6b6a656b6c6c6d6d747576757969676a6d68625e646e6f695d5d63706c6a65758084888a958c8a899499847469697376776b76756d6d6d756f71727a7768635d61575b64686559595a5e666c6b696e6f6c6e75878f9898a09c92949ba5a4a19ca3a7ab9f9ea6b0b2a68f80898b8d8b919b9e9489838390928d827f858686888a91959e9b9397a1b1a8a0959b9a91949ca09b918b96969790877e7e7b7d7d7c756b71757a74737376736b5e575656575c6259524a464a59646a63655e5a647482837d7678818b8c857a80868a7f787c787b7e86898d878e8c88929b9e998e7f888b90898a90959689928d877e808a9ca4a1a6acb1b5b1afb0a69e9b9fa5a9a79d8d8f8c8a7f81908f8b84766e6f6968656a6c695d595e5e574d47484b4c5254575c616761646d7f847f777d9896988f837871777e7a7676777a757074707681807e7a8387867d777279766b5a586870746769666e6c6d6569717c897c746f7f8c9796999d9a8f828083867d70686c7a8c8c837b7374798187807569687379786d5b56626f736b605b606c716d696c7a878f8e88848593a3b0ab9e9d9ea8b0b8bab6aca49b948f8c8d85838192958e827e8690948e877c7670707173736f6b666b777d82838889878e9297908b8786868586827d7573757b7d796d646768707273716d6b6968616a675f5d616c69665c5f61636a6e726e717a80888b8e919da2a1a19ea3a6a79e9794a2adb4b4b3b1b6b8bababdc2bbb0a1999aa59b8f807f87888776747f7977736f675f5e647072746d74746e6b696c79827d7c747671746c6e707c8d847b71828d8d89817c787a7e746b585e59564a5064605c4c595e615a5a686b63616578817b746e747a807e83848482807e8587867a71757a88928f8a888b8f807670768c847f747a7974787f938987868b8d91929aa5a6a297999fa9a6a3a1a4a19585878f98a0a1a193909692908c8a8a8b9193928a8176808580786e6c6d6d646561676f72716b7172777a848d9591898385908e8a8084888b8c8d8e8b89828b909a8f898a909191917f6e5b6c757861534d585b4b5c6067585654676e6c646673797b6e70788086888a90867d73808a8e949398857d778082838a8f948b868a8a89837e7c81857c7a7c8b8f857b706e707b8a9597918881878c969f949097a4aea7a1907d79787d858989877a76717c796e64657275725d6d7581716b687d83787a7d8e8b8a7c756970757776747e868b857e737a7b7e706b707b84807e746f696e7986867b726d726f67626165635b504e5c6063605f5f606f767c717176878f8785828e8b93949f9d9b9ea29d8d979ea8a3a3aba9acaaa8a29d999aa0948c83898b87857d78727276736c6f7287908f8986888f928f91959994908889858283868b939899918e929793887f8184847c7c8682796665646f666b707b796b66667268645e5e60686b7071706b665f606266727e897e6e5c626c77858c90999d9990837e8694a09b93918b8a8783808d94948f8d888fa5a4acb9b3b1abb3b4b1b2b8bdc1bcafacadbab0a99ca3a5a1a19a856d7b7d8c60535a66663f5f5d5942415056502f3637473d4554514b35535d5c52455564838a83665c6f7587989a9ea0b2b4aa8b7b8f889db0baac93848b9eb1a97f7d7e8a9d9095a2a395736e6c7a77839a9c967e756b6883919476687a72797288918c7f787d8aa6aea6897a758991958486938b77605a667f735c47425373655f647480605449545e777e787b797873716b8e9e9d897e8a7e796c7e888e89817975777a8f9a8b726561766f7e8a918673696c7e82887f999d9b8681819b9f888c93b39f9c95a2a097958d8e909b9ea48d868a959a9291897d888a8977717f7a7b727d7d7779766c68686a6e69676264646e62666e706c61717d847b777e858d928e8b88a7b5b5ada8a6a7a6acc0bdb7a0acaaa9968e8c918c7c797883776e616366746a6b6a716d676a73716c69789091836a5f617667645b77817f685b607080768b8a917f817f8f8b7e76706a685e6a878a7e53656a7a6b71897e75665c5e677f8472605562636d6c7c8182786d6e7473798586826d7e80807a819d8b8276828a8ca5afae998a8592a0a99c8f857e83858f97a2a69b8c83818a8ca3a6a29293aba19c8ba1aaa4a7a3a29c998b9c9b877c6b5e55656f70675e5c5a61716f76847c705c606673838f9184767178878e9c9699a49e9679959da590877d8a877778809b8d876f8b9097716e8d908f716d626b687b79786b707f786b5250525c5c5f5d6c757d6f605759646a86897f665a627a8b8979688097978b888391a1a69e978a94b3aba38b96969f92918f908468707a9181786367697d92a9a48c7d7d8ca0a18b8a96c0b3ae989b9083797f988c84756e67685a5a71817268646a70717e817d7d7c827274738e8b647d878f827677819196988a7d86927d566a77836e6469747c6875738369686d736e5c56536a5d6158746f58515567696b6d7b685d48666f6c747d91817b7386969ba5987b74758b929da2a39a8285829da7b6b3a9a2a7b5bbbaababa7a88e807383857976727c7779777a75736e778097998683949b9b9093a8a59d819396938d868777716c7f898e7d7473706f6a7379866e5f61597c84756c657a676e85766d67737c7c857d62787d7f645e716f705c737269686b6d70777b7479756b7b87967f726f78889298969d8d8c938b87879eaaa29c93929ea89f99a8b3b6a3979ca6a88c9286888492a9998875788198827f858b897b787d95997f6d686a72728688865f4e5664777a857a6d626b7d8b939a918f8ea3a597999d9b907a75848c8c7b78778574717a767a6f8b8872696c80868067625b5d6e7a766b58627073736c72716d6c6c6b75788766605d7a77565f67856c68657b7e74686b808f93929aa5a69192909d8a8891919497877d73848470656481878f887d737571706e7594a39a836c6b66727a827c7173757c72706b8b999e8c8894a1a89ba49f99857e8f9e9486757d85928c8b8e9ea08b9296b3a5aaa7aea08c868da19e967c918f8b72676a6965687c6e67635d6172635950545d6f5d53574c4e4c5c5e5f5556526770758186735e6375928379707d89928e8886899097999aa49e9a899aa1adaab2c0b4a896adbcb5afaeaea69a8b80888f927f72756f6d606b6e698187816152546270756a605b5265748b7a6f5b747b74858a97756c6a818373635f6a767e7571665e6a726f66585d62858e846558647782736b636e707a73837b6a5e5f7f645f566d6f5f737a75696070877d736682939c877c7e8e94858384a1a2aa9caeafb1b0b4b5bbb59db0b4b7a59fa3ae999595a3a08a8e8f9c8e8c8ca3a9998e817e8998a3958578726f67787f715a636461595b7176796c716d6f7d8b958a7b696f737d6a697b7d817a7975768fa2898367718aa19e7f716e85828a898c806f6a6c6e8386806c708f8f8e787e777587a0937b6c6b817d7d756a66746a6a69645f55686e7d59586e7e80686e73888a8b80828c95909b9b9d8a8ba5a4a892a2968d808b9faaa79a8b8aa29187718c969583736b696b6d79797765727c938d8f8d837b748e9da0958b8396a3ac9486799598898d8f8c7a7c83a08f836b7c81828182907e78697d7b76625d61717156625f6050556e6a654d5658647366553b4e54534b4d5b666a605f5b60708080868282838e9d9e998d705a6c83908f8380818791918d8c96a4b4b09c8e8a95a2a8a4989397a7b3b3b7ad9d97a6b1bbafabb2a69e8c918c84919289766a6e636770625750626f6e706e717a8a959188858a888f9c928a8588876f776c6d6577948f7f626064786f737682775a566288886958586e776067647561656a756b55555f7d7877656c6667616e827d736a798a796c5d6e929d9a8396a5afa99e9fa2b0bdb7ab9cb1bdb5b0a5a7948f8d8e8f939b9a90888385918781767f80768a8a836a626b787a695e5b6b818d8177686d7a8b92807184949688706d7386838070776f5f61646e6a6a6e757f8c83828499a6a99d8c857f9fa08b786c6f787e73716d79777f85807767737b8c6e686e726646596371584f666f64514550657a796f625f5c56616e867972686b6e6c7d838880869598958e8f9ba5b3b2b2afafb2b4c2c3b79d9092a6b4b79c8d909497888d8b94867e6d736f646d6c65516366685a5a63666d7677797b7f817395a4b290859693988ea29b898386928d766863707a7b786f6c5e62747f867f7e776e7e89908b888891907c706465646a716a6866705c5e67727265787f856e6260767e756259617684836f626b747f7893998e7a878d9e878cb1a29f89a6a6a286849b9d9b89898facb1b7aeb3aca5aab2c1b3aeaeb9a9a8a7a390786a6d7e776c595e687c635143566567645b67535c64747067625d54514b5b7d7f7c68635e5f7585898f8c897e7e82817c717777746c6c7478765c5b5f6a8365667b8f8f736c666d82929a908989827f7d75727172757695a7b394838c969c9fa5a3a6a4b9b8a38a7e829eada9968d9aa0a092898a93a3a3998a8b958568728681705567757e6d5f576b7c8367535b637a809ca0a7868493a3a89d82758296b9a78e7b747787979d9a8c7d7983929287806768738c91827e787667584d5672a09d83747a777f8d8781728c94997d717480836d675957626f6f645761484e5c757d6b6b666b6c8d9897796869757d6f76778a898f8381746e8298a4a0937f9dadb78f7b878f9398a39f907a7483a9a69f8f848891968f88706d6c857d5e4d4c6a6c746b736b6c72615450637f97a1967c8d9db5a9a6aca6aab0a8a3a1adac91a09fad81757d8aa39e9c6f5a5371888f7d675a5459616e717155494d606e776860616a6a544e507e81816e51636c6e6763646b6d71696b7877787c70737f7c7d808e9a9b90847d95a3908696a5aa97878c96a7a6b0abaa9997a39ea2a2b8b5a98b8ba8b4b3a08d899e937d79888c8d8a7872766d635460686464617a5b5f6b6b5f435a6b846d6671707571787b808599a9aea08c837f91a6a7988484919aaca28a77747f7e7f77878c8a796b646071787e6e64615858606d736e6961616e7f8a7f706867727e7a6f666c7b8d837a839185818797977a7d7d9c8f999e9b91808a8b927e8185abaeac736d8d978f5c6a71918b9188886d749ca2a1867c7486909e8f998d897172878a8d7c979ca9878393999590938078758490a1887866706f6a60657d736b5b5f666f7570616774938f908e7e6f7e9b90846d8e9d9b836c646a777480756b646c80756c5d5d59545d6a7f6c5d514b686c61565d7c7c7a6869666573819885848c989682827f7b9dab9d988b8d8fa6c7c3b19d88929daea9abb1aea07c7a768a7c86938d7758626c7d695e5c5c6268849c96947971688888737b8db4a59371889290928e9b8b95a8ada38b80736862647379918974645d6d555765757762635c6963728680746974889a9f947883878d919da4927b70778f9f9a8f838f858a7a968f7a7d88a584787094a193897e82858e928d867f7b7b82998d8882858a8b99968e7d777a7f8391848b979a8d6a747a8b8a95a58871717c847d74646e8c83714f57627475716e6d7475939898776d778995959d9c97857a8ca1947f6c6b7a918d8a918b9191867372647384928561605e685654606769595c575b61595859696a5d5d6070798386877e6d6d71827f89919b998e949aa6928a9ba8ada89b9b9fadabaaa29b94849aa4b1918e999d9a9086868e948d707c7d8879756c685154727779655e52545661617c7f716f717b8485717571778091a393816d6f6e708a7d8996a49468686f8c8a91a28a8277929380858f9d9b8d706d758c93928374626a7b8c968591847b696f797b6c595e6c7f705b434a54605e53454b5a71645b565175848b705e526d7f8483848f918f7f7c7d8997a39ea5a39fa5aaabaca4948e8facbcb9ac9a8e8c8c96938e7977827e796a7777706661646a726c675d577083856c52657d9290768084969098a79e947e9aa1a07c6d7d8895899486716c6e7c78808c8b7b777b7470678a9a9988797978838b8d8a838f989e978c807d7d7d8289a0898484826f6e6d807d687074846f6a6f797a6a5c524e80998e7862697385898e868092a29c967b78839ba8a88f808f90a1a7afa3958992aaa8a597a4a49b9b9ea6a9a3918480979e99938f8a8275727174838c937b707373736c656272707a82857d6d69696e7180888588837f7677817a7876726c6961656e848778665f74686f797e7b6d67646e778078766f778b7f776c87928c8d8a92969a9092898386909597896f6f768b796e6b6d7b7b7e626480888a7273655b6679878c81677a86908378726c6e6f858e8c78626a7b93907f76809da29e8c807f8f959589848588a2aaa28c8285929b979490918885939996876f70798589827b6663636f6b5d595e6e656266707d7b928f7c777375798f949c827c818b86726566866e6e707a83898b816f5c53586f828c85796d67686b7888868a76747d96a4a29b918f878680929694908e91817b827e82838a83747b848b8887888a827c758c98968372726567687f898776666d61748b9b8d6f646e91a4af9487777d959996858185999d937b71768ea0a49a7a72819da4997e7787928f756b6d79767970685c5f7075726156525d646b67787b6e7b7e896e6f7b8b8976777a897d7e86938b878290928f807e8f989e8c99969487858c9aa7aaada1918b8f9d9f9f9696a6aeb3a49d9b9d9994847f8089867d6f6c7d69635f68706e6d6763707a7a776f76777970655f606f6d77837e6d575864776f6660636d767b797c6c696d66625f72828c846b5b5d6c8395918171849ba9a5907f7c8a97a39e988c9090988b77737a8b857c776f63647581887e756f7692a4a78d7a7476818e969fa7a79b82888d919e9e9d8b828891a3aeab9a8a85909b9ca2a19d9b948a83848a959aa3918f8ea0997f78716f627a8c9c8d7d685a514f5566788a88716b677568655d7377666f707472777a72655b5878878e7e736c6e70678088907c7c92929389837a7d767878817f7b757781746d75877873777c858d9494887f74756b768c8d85697f848667545157666e86887f716a718176767d7b7d828385848682817a7d8a8b9091999e9e978f829ba8a8998a9194979299858da2a99f85858a97a0a39a9186808e999d9e9585837e767b7c7a65566875796f5d5d5b5451516369797e78614a4c62817f70565e6980767780786e575e678587928f8a7e7f8995937a828290828487878279818a97837a758d9ea19b8f878e9b9ba499a1afb3ac94969aa3a9adb0988e959ca09b918a89959d9e9a98989e9e96876b6d6d868a7b7972796969696b645f697f9b918474818b84908686737d939e9e93978e816776777271788c8178665b54505e61595a5c69524845555d53696d715f5f7e8881776f6f798e8e90908e8a8483868a9ea28d8a838c7e889c9e987e817e85838d887f7d7f8474675d667182746e647b868f79727e7d8072949ea481747d7e7d6a7e949a978f87878990958e847a7074868a908c8a837d7b8191848382918b736763818c8b8273787b7f7f83918e9192918a827d8496958e8b6e6f809c9e84776c6e78838e898981797d8795897962605e5c647080807968554e556570766b6b79736b536c7b87837d797186949f85736f7988938e888b8d92918c889097a19aa49c8a949799938a87807d7e879098a19490999a9c9a9d9fa3a5a19391877c7f8a979d957f777a95959a8e83828b9b92887781868b756559727d6e7368695559646b675862686d5b4a464b646c6b5c545764726f7a736c5e698b999e8c7f736c8fa8b4a89684818588908d857e8d8a806a6671797a76615d66787a686669806e6f748484766f7392939a958a8a98a598919d9192958d8b918b8681868e90968e8667626a7f836d6f665e616c88776a66627f939f8f7f717b86939696948f867b94a3a798847b84949ea8a0917f757e82969a947e6f6965615862696e6e665156596b5c616c7d7f6b6d6f84737577898e7e736c6f7f87939893897b8f9ca39285828c949293929f92887a726f6b787c7d6c6b74786a70808b846a676f848381757e7e7c73707a84908e918b90828a9aa29b7e7a8397a5a2958476717371716b7a786c5f5e6c7076737c828380786e76828f8f877d7179879d918a82756b647c92a2927e6c6a6a6a7e90a69b91867c797c8a939f93928b8b7a7d8e8f83636366767c7c6c797a7a69667d787e727f756f63728e908c7b807e78768f9aa0847c8f9da3909491a29c9d998274687d83866e6c7a8d8e767572756e717b8c868482817e7b68677694a1927d6f837e8e95a39a887e8196949a9e99907f6f6276908c7d605f5f696469707b7a677376876f68677174646e6a6f5d5c5f66646f7c88826674819791909487817d8a928fa2a291928f927f798278808d9992766968828e88898a89837e72758098957f6d6a7c868f84847a707989a09b98938f8c8a8a8b93959fa0a093887d86857b766e725c5c6272767566605967614e4857817d775b5f5c677380858880869e9e9d8d95928e8682798f969183809d8a826e70685d67685e59676d71605b5c757d7d6c6e7f8a8a797d808f7868556c7e9089858a82837a93938b879a9b9a86899ba3a1917e77868d94898a7b75646876838376747a988a89818c8d827e7c75636a6c78686b707e77606c7c958e87808b98a38f7e7d7f8b888c889992968174626c8b89846c7872715b616c8b8c7a666c8c8f85686b7696857d7478808d8d938e86787e9aa09e848a8690868b8f97958c8d8b8d817a70706b6a61646779828a8e82725d5d6473787a7e6d67657679767376878283799da9ae94888f8f8c7499a5a39b9a93928a8e95958f8c7f89a2b2b2938c7e897785a1a79d8c787a91968d6d767976706d7788968e6e696b7993a2a7989097918e8d8281869ba49d8a787076828e8473707273777a7d7b726c645b5f646469666654555a7c84776d6a7876787482857c7374858d85746e6e80938a7560666b6468666e767f7e7262526a787b757382838779767b80847d7d7b86898d8790a4a19787858a96a0a29aa1a29f92857e777a7a8c8d81837f7a6f727172716f776971809091846b5e60758480817b836e6e7b7c786876898f92909399968e8d7d828a9f9b857c809283756b666f7b7d79697b818065586471796c6e6f7b847f75696a6556667687827d807980868a7b6469778e908d83807d7b76666c788f938c73696f797b71717481949f98958d8e8c969e9f988c979ea5998c756c777d887c787a6f69676c6f69655a4e596678665856535b5e707172788ba0a5a19ea2a79d908a93a0acaa9ea8b1bcafa497aab5b8b8b6b3ab9f8c8a8d9c908b8599a19c9899937e796f6d6f7a89868589766b606e767a6b5f5a616450554b4635363b3f3237424e5043535b695f61687c88829091987f7d8f8a8a858a8b8a8a8c93949ba6abb1bcc2c6bfbaaca9a0a8a09388889580756776786d615c687f939b8f888e8f8c74737880848b8e9180787b7778767b8291a4b4b6b5aba7a3a7aab5b6aea0999e91817c76736c61595864616c7f72644e50525b626a766760565f5d5d505c7c888f878e908f8b7e76756d6e7a848a7e858387858c9494918f9da7a897867d7676746d6d75807b6b565d5d534d4b54585c5860615f544d49545b606b76808c908b8885898b949ea1908a7f918c7a6a6a817f7a67676d817f7c7b6360667e88897f7f8b91959288879fa4afa59383808b989d949094b2abb4b9c9ccbec9c9cab7b3b4bebeb89c8c8a827372777e7e6f7e81836f635e5957535a5e646561564d4f5c6d7a807c78787b828a959c94887d7a8082837f807b7462544b4f55575e5b5b50515061605648495468746e6c67645e646a787881889c9f9c9fa7bcb6b2a8adb7c5c8c6c4b5afb0b1aca19794a5a9a08f777d7d7b77757b7d7e767167635d61666566676f716961585269767672737877797c89939d9e9d9a9d999a9aabb2afa394927a7b7c9694857470798892959e9d917c8a95a2939094968d7b6c6a7a7e7b645b545d57595e57534e5151545558595c605a4f4d4a485e6b6e5c5150575f5468696d60697d888575737681898b848d97a2a0a2a6afa4a8b9c2c7c6c1c5d6dcdccec5bbbac6ccc4bba9969393928e8985868d8c85716e73716a5d5b64717065534f525f5a54514d525c6364615852545d656763677a938a81738a95978a828a8e9996a5a09d8f91989e9c98999fa8a49c8d9191968987857c716e7874767772707472706d6e727b8080846f6c7880868284808081847f7c6c6b737c7f7b70697270726a74706c6166737f817674717a6f6d697b838486877d737c838a7c75748fa1a29a887d7678747c7976706e6e66605a62635c575451565b626a6b655c5f62646362636d75797270788d9b9e93909ca8b2abb3afb1a4a4a8a39d9faba29a8d88868c88878284838182817f767170788186847d74797c7e7b7468646d7b8b82786e7176797d7a797479838786868588878c888283899393928f8988979ea5a49f999ba49f9b9c9699a3a4a0939da4a6adacaa9e9898a0a9b3ada69c988f807d7d7b767d7b736357554b484448433943484a47433c464a494f57665d5856627373756b6c7573777b8e989793919891908c959d9d9e9a99979a9c9d999b9395939a9fa2a89c9793a5aba99a9292a1a9a6989096969b98a19d968b898e9496929394908a8e9394988f82797f9897958c847b797e81847b7266686a756b696966615a5e626d6a6e6a6b5f6069757d7d81807f77757788969a98918b939699918f9492918e898285888b89826e6366676e6e6d665f5d5b584e4a494946403a373a3b3f4443423d40454b564a45454b5056596370726c606164687a82807c797c82888d9292958f9092a2aca9abb1b6bababcc0c1c0bcbfbfc1b7b3aebbc3c1bfbcc0bfc1bfc9cbc8b9b3bebfbbb0a49f9d9da2a4a2a0988f8077736c69676b665a463a3d4045443d3939424642424f5656595d63686e737e8a92938c80838992918f928e8e8d85786e6a6b6f77776f60605d6054566265655c57535a606b69726a666472868e8b7d888e959699a5a5a19d9eabb1ac9d918f99a5adaba398a0a4a2a7a4a095908c93938f8784858a8a878a9391827e7b7f8a8d807e7a817f868f8a857d848b9692939199978c9496999088827d878a9097a2a7a3988c87888d8e8e8a857e7d6d6c728080706660686a747c7e7e776d635c5e626a6a695a464147525a54423a3a44494d4845413d3c3f444f53535554534b4b4b53586064615e61667380858377838e9da4acb0aca7a2b0b7b8b5b1b4b2b0ababb0bac7c6c7c8c5c6c6c6c1bbb5b0b5adb0b5ac9f948f95a4a09b919597918b83817d7978797a766e6f72787c797068686d757471636a7e88877974727e838a898a7a767c888e857f76746e6f6f767d87817d7b77787e879098928c818b8f92897e7d7b82878c8c8a8582786e6c6f71716a655b5f6e6965595d5c5c575b67696960625f6362636165666d72787972838b938d8f929ea09a9b9ba58f8177777b818f979a9c939399a5ada6a1928b7a7776736a6361646a6b686476807f6e625f758484776c6a64656366605d5d646b6c6b635b5d6263686970777f7e766a5b696d665d585d616365696f6b63636c7d7e7767727c8b8c8c8f989f9ea09ea196979da0a3a6a9aaa59c9099a9aaa79da3a9aaaba59c908d9494928792938e8c8a8c8e8d888d9091a0a49d8d7980909598958f867982869083808486857d83848b767478969e957e77818a90888a887f6d6d727e8281778389917e7681848d879089837e7e83868d979491888e8f87817874727675726c6f7b82827a716f71858c8c79747b84827167616967655f5e5d6267737879767577818788847f7c766d60616878726e6972777778767b7372726f707c8a87807368625d686b6b64666d7a8281827c706b6b747b88958b81777e827f7e8992978c8c95a1a7a2a1a0a99c96929aa1a79e94898d91908b7e78635d5f6565676a6d665d5a606b6e6c666a696a5c585e656d696057575c625e605d5f626b766c666f8077726e778289949490837e7c98a4a19792999ca3a5a29b9a969795999ba3b1bbaba098a4c0bfbeb7b3b0aeb2aea19b95948f8f8f8e8984838995918c7b848482766a68626762654e4a4e62676055535d666e666c696d62666c736e5e5f6271676363686c716f787e83868b929492887e7783798085887f6e615e676c716f7c858f888a999c9490929da6a4a7a29b958f8e888c949d9a8b7e7c8c9da7a3998e8a8e928e9ca8a18f796e797b8387867d6c706c6c5f636f868e867e7b837c766a737d8b89847c797a7c807c776c6f727a7f7d706a68727c8284746d6d8493968b828084857b7c7572727e7b6c605554606f7c7067666e77756e636468777e8b8271686a7577756d6d6b76818f97948b817c7c7b7277757d74767d7f7e757b7a80737a8a9fa4999ca1b6b0a5998a8f98a4a2a19a938b818a898879798b97a09b9a9ba4a7a49d908985949c9e8a6f706d7e817d727179777876818888888587848d98989081868c958a847f8386838a9193949396a09a968c8e8f92928e8a837d757371747577756f665f62687569625855525664615d4f4e4c4d53585c5e636567625957596269727d7d7e7d78706a676871787d817d7d78757177838a8c868d9093898487939e9f9e9a9ea0acb4b8b3ad9d929391999b9a938a84807e7b838a9393989ba3a6a39e948e8282838f8f847a73746c6c717a7c81898d9191938c8279757b706b67655f555755524a484c525b626566686c70716d6a656469737d7b71635f6064666563676b696a6663646b736e6960676c7377747169676a78797b77868f92908f9597a1a3afaeaaa3a2a5aaa9a89e9ea9a5a4a6afababadb2b2aeb0b6c0bcb7aeaba9a9a4a4a49c9486837e7c7b7c7e7b7b7c7773767a8a8f8c7c74777d84868b88867874757e8383838182807e7b818b99918982858d94999c9c9b93949fa19d90827c82848b8c908f857b747781919aa39e94908f918d887f7472737276736d666363625e57585f6e7474696b67685e606c6b6d696964585356585c595e666c706d645f63676b676a6662595555595e6064625f6265636b73797c7971706a717a807a6a6d72807c7b7974767a8d9ba3a7a8aaabacaea5a3a9adafa79f999392909191908e928d92989d9e9c9ea1a6a59f959a9da08e827c78746d6f6c69626364625b58565e666c6a66666e787a7c76716b6e74888d887c7b8887897d796e71818585777975777f8d9b9f9b939ba0a399918891908c86899797968b8582847e807f7f7e807f898b8f8a8e9c9b9a9597969893918aa0a5a2938e989594898d8983777369645a5b6765635b574f45444b5a60666b6260616a7275797c7e777475777778797f83858e97a6a5a9adb2b3aeaeadb0a8aab1b8b4a5958a898d92939ca19e999696979695989da2a39c989c9a9d9b938573797976686160686a615c5c66666456555c60636467696b645a5657595d5e6158565b5a5c595f5d595d66777672615d5d6b7f8285868c8f91868286888a818a8582797e8a8a867c7979817a7c867f7c7578858d928a827f838b8c8d8c8a91928d868381868989868996918d848a8c8b91979ea09c9ca5aaadaba8a19e999ca29f9b948b84828081848180808383817f828f97a3a5a196959b9f9f9996908d878580776a605a5c5f5f595254595e524c4f525e686b62565c6c726f6e6e7176756f72757c80807e7673737f85867d7b7f868a87878a9a948d8c8f979d9d9c9b9b9fa4ada9a499969391979893877d79888d8b796d6a74776d695e5c5b5c6372716c625f5e62676b6c6d6862646b7b74706773797e84888f89878c8f8c857c7f7f7a746b6862626662636568665f5f6575838b857b706e72797d79757c848b908d909296989487868588959c9c99979595918e949ba29d90837a7e8b8a807467615f646b6f6a635d58646c6c625b5d68747a827d7369605c6168706d6f7a766d6664717b7f7d7a7e7c7d7882848881848c979c9796959e9aa0a4ababa7a29f9c999b9c9ea0a4a8b5bdbeb8b3b1b8bdc0bfc2c1c4bdb1a7a7b0aea5958b8b93928d7a72706d6b6a6861594e4953636f747271686c717d7d75737278726f6f72726c6359565b63635d5e5c5f595a5b5b5857575d63696962666d7b7473787a838f8e8a838b93959693918b939aa5a0a0a3a3a29c9b9da5a8a9a19e999c9ca1a4a6a3a09c9fa8a0938b82807e7e828584807769646065595a63696655514f555a5f5a5d5b5b595d70778589867b777c89908e80736b74797a7c7a766b5c52525c6c6c6860686f706b666e6f76706a687185888d908e8478757d89918d7b6a636b737e8487847f7e808281848a8f8a8684858988817877727980837e74787b7a746659616d7775706e71777b7c7c7f838a8d8b8c8a8592989d918a8b99a39fa09ca2a0aab4c4c5b8ada3a1a2a5a6aaaaa9a0998f898a8c8c8c867e80848783807f797778797e84929da4a6a7acadafacadabaeafada4978f8c90887d6e66615f64676b5b53515a5b534f4c4d474546546170736d6a676a6c6e6f6f6f72787a766c625a5e6e72777472685a55545c595754504c4e53575d5c686b6c686b79797a7a868d9289817c7e838d9caab2aa9e979daab7b7b4b6b3afa69badb7b5aaa19eacb6b9babbc4c3beaaada9a59e99998a80767474797778746f7478787b777378818e8d8e8e8e86797172808e97969189877c7a776e625b5c5a544a4a4c52504d4f4746454a4943464f5c6462575b616d7477766f6861666d747b828991969a989593949ea8acaca7a89c9ba19a968d9194979a9fa6a4a5a5a7a29e9c939196a0a49e9c9593929495887f7d8185898485868f8b7b77737a7273767b75716d7678727175847f7f7d7b7e879096988f877e8687837b777374716b737a77726b6e787c7f79848788868d9d9ca0999d999d9391918d847671758780817e7d766b6b7576706761665e5d5e5e5a54575a5e5e60656a70737a7a7b797a787f7e7a706266688189857c78808085848172605c5c6363656c6362626b6a615e65787f827b818b909689807873706d7985919091919da5a5b0b2b7a7a5afb6b5aba39da199958d8e92928f8886879194948a827a797371615e656666616e706b5f59596772766d6c777e7e869191867270768385807373716f68636566665d64646969707778777076787b7d7b7474707a87918e807e8597929699a8b2b4b3b4c0bebbadbbbcb8b1aba7a19f9d9e9495939fa2a29c9ca19c958c8c888885868593938c7f7c888385838c8f8a898a877c7d7a797a7a7f73757b7e776a5d59576361575f666d60534b4d555f5c5f6d6a645c555f6460575a69737770676065676d6d6e6c6b6a717d8b9493908b8983859798978c827e818989857e858a93857e7f8f9b9e978d8a898d8d9ba1a294867c7d858890969e9d9b93908d95a0a4a0979ea19f998e817a76747272716d68655c58555e6d737a716b6b777f7e766b676163665c5756656f716c6873727a808c8f8d8f929d9c99918a8a909898938688898b888686848a8c9596988f8c8c908e877e78776c677179766f656163696d7176797a787d81878d8d877f7d83898e908f8c888b8783706365676b7275736b6166696e635a575f6b746d645a5e605e656f7e827d6c707684878e8e8e98a3b1babfbab2aaababb4b9bab4a79a929290959d9d968c827e8083858480756b65656a746c6660636460656464676560697382878d909697939290938b867f7b706967686b6267656769748072676168727b7a797978756f696b748794978d868d9199a2aeb4b8b6c0c0bbc2c5c8c7c1b7b0afb6b0aeaeadaba4a29c958d8d979489827d7d7e7a807e786c686a6b6b686a6c7474736f767a79777476787a7575747a736c67656d7579776e616062686362606760514e4c4f5155565b5d5d605c54514d505253565b57595f60605d5e5f63676f76808384858a908f8b8184888f979a9a918f9298969ba5a5a39e9a9ca7aeb3b3b0aba6a4a3a3a5a49c9f9d9f9b9ea2a19fa0a2a09c989ea09b928884878b8a847a77777973736c69676f79726b656b72787b7c8384838184858888817b7980868b8e92999190949a9e979b958f85858a8e8a7b70676d6e7a7c7f797b7d817a6a6d707a706b656967615d5a575e5e5c555d7378735c574f5256606f808c8c887d7f87979da098999ca09b8d8883867e7d7f888a8679757c8990807b777a827d7c7c7c776d6c6b6f7378797f7d7b73788a8e8a7c76767d96a4a69d96948c88818077726c6c69635a5354525c676b675e5e6266707474757470655e5d6f837c786c73868f96979c9c9798939190969c9e9d98999792877c7d7f888f8d847a787a78757a7872615b60717b736b605a57575a555f7577726060646e7f8c93949492939699979591919499949790898e929696928e96a0abaaaaabaca8a19c9da8a4a2a4a4a19a968e94a4a6a398989ba5a9aaaba8a7a2a2998f827f85817e7b7976766b5b564e55575a585b6460605c65686b5f5c686b70727b7f7c7b76737684949d9c8f8e909194949aa0a29c94847f818280797672737274757472746b6a6e6b676161667171676056656965636670787e7b898b8a878585868688898e95948e828080828e9380736d6b6e6769707479777d796f706f6c645e5a585755514e50555854555453585e6267757b7b79787b858b8b8f91919694908683899398938c8589858a8f9da3a096898e8f9b999691959d9b958a89898d8d8c899091928e95a4aaada6a3a0a4a3a6a8a4a09d93999389878a9591887572737d7c766c635f5d6f767463544a4f576262615750555d6b6f7b88949790817b7d8c99a19a938f94989799948e8886868e9194959a98998a899196907d73707477766e757c817f766e74808d85786f6f787e929aa29c979491969aa095908e887f736c696a6f6f6d645f605a5a5d656e7271675951505a5c5a57565f6a757a797374777d8a949aa0a3a3988d8489949eaab1b5b8b9b4b4aeacadafa9a597949c9d9f9d9d9b99918b86898c8d888584888c8c949694938d81817f828383807773707074756d6e685f676f7a7c80828283828585817b756d70727b71685e554e51555f5c4a5a6677766f605f5d5c5b6276808578756a656168746d655f595d5e5f5e5f615f5f5d5e6166636260666663626367686867717a7f84827f83899caaadb1b7a29697a3afa8bebbaba29da5a0a5adb1afa9a9acb0b9bbbcb5b5bab8b19691939aa09c91827a74797474727473757780918b847779797779797c7b7d827e75706a6d6e6e767b7e8182838c959d9d9b9b97979698938c7d79827f807d7a787a77787c847f7f7f7d776f6a686b7075758285867265605c5a5258564f514c483b3639323b424751504c4a4e5a646c6f6e6558545763696e6b777e83939ea69e9c9da4a79f9da5ababa09389888f999f9fa09a9c9ea7a2928a84877a79817b7b7c78726c676773767a77716a676d6971808e9281857e718a9ba7988e8d929994a5a7a09c917b746e7f98a3a6a0978e87898883766e7070726c7069615e60626968627385909488726f7b81847f83908b87848384857a716d6a69676b6d737072707d837e84858b8d949d9f9b9b9c9ea2a6aaaba495867c95a4a3a6a2a2a2a8acafaea8a8a39f9391949ca0998c8c898497a3a79b8d81858c939a9c97978a73726f7772757a807d706761656e706760646768686c73726e686562585c57565562766d5f4d50545c6774818f938c8c88888a888785807a717d84867b7172757e82878a9292948d999d9f9d9b9993928b8982899093857960627a80795e55535a6d736c5f575a5758555857514d4a4e4d525c61606062696e766a686c7c8c959d9b988f8e938f8b857d776e777a77716c696d7476777980819ea99f9d8c797983929da4a6a29d98979496928f8c88848184898f8b8b92989c99928a8584827e7881898b8d8b8e8c8e8c8c88878a8d8d7e71607f8f907d544a3c4a515958595b61625d676f7f7376808e9797a2a9aaa89e8e8d8e909396a6acafa79c93929590898080808481848c8f92968b848382817d7f818a939c9f958b939da5a195969ba7a29f949b9a988e888d807d797c7c7b747170645d5c5b61666c6160606963584e50635d56454a4d564f4f535a5e585e5b56595d626163676665615e60646983929b989ba3b1b9b7b6b5b8c0c4c1cbd1d1c5b49ca8aca8afaeb0a69e9287808486837b726d6a6e6e757f7870616f767d7c7e7d756a60626b727976666b6a635f686c7266605857534b4c515a554e3e505b6d6064768b95858e8d979babbdc5c9bcb1ababb7b5b1a9a19b96979694877f7e767068625d5d5f656d6f70727e8480817c808283807d7c828e8e8e8a91908980797674747871717b7f807c7f7f7f828890949994918f95a4a5a59ca09ea19ea3aeaea8959b9ca091867e777578757b8c91907b746c6e717b7e7b7975757471696a696d6a6f7c848b8b9793867670757e878b8a87888787847f7b75716e6f747b7e7e7b7a7a7e848f8f91918e8c8d979d9b978c7f7a6c6b707e827c665857565856575149444240494d4d4b474040403f3e434c565c5b61696b6a6e7078757a808b8e8d7d767b8287858684818080838e98a19e9a989ca2a6a39d9ea39d9fa7b3bbb7bebdb5aea59fa5abadb2b0aaa9a7a3a29f9d9f9c968c88898c878583847e74757b898a8b86979d99948c8f756761636b737a7a775c4d525156565a575b626465606d6f69605c5f6c75747b7c857f8483908f878c939e9990826f595d60737a77726a656568676766646668696e75878a9297a3a9aeabaaabb1b5bbbbbdb49ca1a2a79e99929a9c96999aa29fa19e99909083848a90908586878d96a09fa09fa4a9aaa091817c808a8e8e898a8e867d6e6a666562605c615e58504e564f4a464a4f555d67748480756a67707e8788877877838a90908d8a8b949ca0a3a09a999f9e99887c7d757a888d918f919090929596918d8c888684818181807d756d696d665348414d5350493d37333a4447433f40464f4e50565b626565646765646157535a6e7d74727c88949595989fa4a39b9593969899989a9fa7acaeb8bec6bdb9b6bababdc9ccd1cbc3babcb4b6b8b6a9948e8c8d81766d645f5e5b595b53525060645a595151516267684f4a525b5a4a494b6060676b6a6b6d7b8281868b8f8d8d8e8d8d868b929ba3a3a2a8a7aaa7a49c929ca5b0b0aba1a2a19f9a96939390888a8479726e6e716f6b656260606c747776767e7879777c7364605f6260616260616475828a919395959089847f7e7a84827c706c7172726f73767c7b84939d9e9281767c79818b8a8a85828e9695968d86828b999a94877a7983858683868a96999e9da19c8f9296a08f7d838e93907d868a8f99a1aa9790939ea5a09b8a796b6464616267696e78736e6164606b7e87887c79716e6866585f58564f617d8a846963667b756d595554595f615a606a74827f7b6c717075767e838d8a808d99a49e979098a5b0b1aea8a6a6abaaacab9f978e8a8a939b9f9b92878386919691857c7e7f8582817c7b798090868692969d867468697a889491968f878893a2a69f8e7e777d7779827c787574726e6e6f71727b7b7c7781979d998e6f636d7578696a65666b706f6d696c67738c8f8f7f868684919e998889899091959a8b8286929f9e9f8d74646272747e848c8c877e77766d696766645f5854524f535354636c6d70727684929c9c9a9a9c9e9b9890858c91938e8379767b7c837c838d8e857a6e6c73797b776b5e5a50515865655b4a3e3c484f484a4b4b47454953656f706f6e74767b78776f6f6a707a7671687985918c8e95a7b3aea59ca7afb6b4abb6b7ad9d8b7d7f84879ea8a89e9695999b9395929495999b918f9d9b908a8793948c8382898e8f9084889aa1a19385776d6e6f72757d847e716162686e6d6a6d7173747c83929fa2998d7f7d868a929296918c8184949c9d8e81756f7a889ea5a5a0918f8e94928e828582787671706b6c727075818b95938779767b8b979da5b2b4a8896a6878928b7b665e5d5972797569626566727a8c8e8d7774818584706b616b707f7f7a71738083858087867e7871706d71797a7c7885867d6f696d696a7580868684878f9e948e8a939b9798908c8b8e8d857b72777e877f7c808b9291979ea6a3a09fa09e99929396999d9e9f948e898a8a8d8b88827e767371767a756855565855524d48443d3a3840454b4242484d535c65758e8a877f8c928d92928f9799928a8080777d7d828b969f989490abbfc6c6c2c6c3c4bbb4a8a0999a9d9c96869ea8a99e9091918c8887837f776c656066675d574f5245464a5049383337425963595e5f6b6c6e6d6c6e71736a6259636666625f5d5b5b5a616666635f676c829a9f9785868c9fa6acb0b3ada39b989998abb4b6bec2c7c6c6c4c5c2b8b5afa9a4a098978f897b716e6d6c727a766f6770839a9e9b979495989190959797918b888d8d897f6963747f816f5f5452575454524f4c4c535c6464656b5f5a555151545a5f645d5f65757f7c7a7572706e6e766a66636768625f585a525453656e7371788488887e909ca599939fa599908e84817b828892979b9c96938d9fa4a79998a7a49f8e8b8a91969ea7a7a19da2aebdc4c5bfbeb6b3ada59b9a939395847363605d5d544e474b4a463e3b3d40454a59555b5c757f7c7475868f9386827771706d675f5d686e7d8e8c8c8c8f8b8285878d999a9b978d858a8996a7a69d8c8e90949fa8b3acaeb5b7b6b1ada59998958d8b7b716e6f70737576747a725c5754635e6978776d5a64707c827c716f778a93989fa1a49b87746e788d9e9e9e928482878f82766e70756e7068685b6477868d8a97a19b8d9497a09797998b78655c62746f6658504e4d504e4c4d58666f726e768192887c7970838c8e908f9587858598998b898aa18d8d929792877c7d9086807464585f66645f555552504e505a687a8e979fa29a94959ea7afa7a2a1a098837d7575838a74676363615a5452555d65625f5c5d5c5b5f63666d74778e9b9999908a7673778290959d9793959297a19f9c96918f8e9698988b8180828a8fa0a6a5a6a39d988d838e9a9386746562595e63665c503e41545a5742413c3b41495453575c69747b868a877f7b879ba1a9aab2afa5a5a6aaa79f9599a0aba49d99959b9fa29e998e8b8d8c8b95969da1a6adb8c8c3bcb3b0b3b9c4c6beb7b2b6a9a49e978c7879787a7b7e7b756b6664665e564d50595a56494d525a55565b616869655f5e585c62696c6c645e5a5d6360584f4a535862625e5451596f84827564687485898d90959a9a9b97939495928377818c8f8a827268636e788283848688867d797a83878f939a9d9d9c9fa5a2a2a9ada9a5a2a19d96928f8d8f8e8a77696666696568645e5c5b58514b505868787c787d87999d9799999e918b8988816e6b686e6d70706b6b707c827e6c606164645d5753545352555a656a6a66666c64666f7b8482817d7b869098938e8e89878282848985878a92959593949597a3aeb7b8b9b8b1aaa6aaaca8a2958984868d8d887d80807e7f7d7d767d7b787474767b78727a87979d9a97959ba6aeaca49fa1a1abaaa09b98a3a5a7a39d918e948e83706965686a6a695d5d6171757264626a747268656e86848069636c727674757a7a7a7576736b706e6a564d4e5b676d625a5d5b5e5f666869645f5d5b60676f7375757674757c838b8d8d8c8b8a8884817c8b969a99908777747581858b93968e7f726f757f817d6b63646c706a72726f625b5b66757b7e77706e6e727680898f8d9097a1a9acb5b7b9b5b3b3b4b7c0bdbdbbbab2a6a7acb1aa9f91979da1a099908270615f5f666b6864677582888782817a7b818180787e7b74767677716865605b57535855514844414e514949464a43413f4e5a64605c5d5d656d74737373828588828b9ea9b1b0afaeb1b0b2b1b4b6baafacacbcc2b9b9b1b3b2b7bdbfbdb9b7b5aa99938f8f8c8c938e8f918e8b8c8887898b8e908b837d6e655b63666a6b707c7d7e7c7976777a8183817672747b7b756a645f6260615d65706f67574f4d5554555257545c6574787074768177736d72716c747b7e7e7a766a6e7f86877a7168666b716d6a6c6e6f6d6c6e71777c878b8e90969d968e84888d928f898281848d8b8c8f94918b898180808a8e8f8b89898c88837e7f84807a6c757a7d7467605d62686664615e5f5f646c70726d6f79898e87786f7474797d888e93908d8e9299a2a7a9acafb4b0a99e9694999ea1a39e978f95a9a9a8a09086808e9499867e8485868083868f92958e88837e7c7573718489857f7d7e827b6e64626a6c6f6a655d55565657535151535354545d666f777f8685878a8f969694898080858d8b88848f9ba2a49e9d94969ca6adadaca9a9ababaaa5a7a49f9ea0a3a6a1968e847c79736664605e60656b6665676868686b6b71798483766b626066717e8e999da4a7a6a29e9c9794908d8785776e69676f73746c6662696d6a635c566366655959646564565b60676a6c6b6b6c6e7377797c746d666a6e70717275767572706b6a5d5b616e75726d6a6c71777c7f8081838f9396969189929596928c8c8485899195979aa1a9aeb1b3b0b0b8bec9cfd0c8bebfc2bfb8bab6ada59a918b8883807b7774726b655c595256605d5b5355514c48464d504846444e575a666f75848a888b8d92918e8a7465616a727077716c676c757d807c776b635f6771777d80837f80828588889094969297a8abada8a3a0a1acb3b6b8b1b0adb8bdbcb8b1a9b0b3ada99f998a858a8e94989f9f9a989798918a837d797770666152534c464649514f51535b5f625c626b787e7c7571767d8789908d8a7e7c8b8e8d887f8284857e756e635c59595c5e5f5e5c5f5d5e585e6f777a7571717b858e989fa3a4a39ca0afb4b8b7a79b97959794968e82787272767b7b767066686c77726e675d67707a716d6e747571696b788084837674818a9390a0a4a09b9089776b606b767470656063666e787f888b95938b84889999968d898a92847a6d6d6b6c6a6e868c93949386807d868e98a2a8aba9a7a5a5a8adaca79f95919391949a968f86766a656364615b5f5f5557555a515357544e474d545b5e5d5f626d798991909ca3aaa7a69d929293959ca1a4a29e9d938b85898b888c909096928d8185989c9d948e88818d989b9f948d8889919aa09d95909092908e918c8e8e9490867971736a67676967625f5b5854565d686b71737978716d656259575959544e4648524e4c49515a626565686d7a7f817a7c868b8a8078737372737176797e818891949694948e8a898986888a8c89807c7e8184817c746a6f767f8082848c94999ea1a1a2a1a1aab3b9b6b4bab9bcaf9b9da0aaa4a0a09996909493978f9296978f7e787475767b7c898a827a7b89909691939396918e88898482827b76787575746e685e5e5c5a555459626a706f706f6f68656963656268625d4e536673776d6a6569696c7072777d828484898d9396978d8887888f847f7b7f7f7c7e828b8e8e85807b7d82868c7e777175736a737b8a837c71737880888b8f90999fa8aaadaab0aea5a29fa1a4a8aaa3978a898d96948e84848c8d8f898988877e7770788689806b61606c6c6d6b6c6d6f777d84889097a1a29e9fa3a6a7a39f9e98948e9490847870756e726f7e7e787478827d7564635d584f4d53584f4b4a4d5155585b63605e58666a6d6769757579757e7b74635d64696c67655f63656f6f6a6b717f7f7e7a7a787776797f7e7c78746f7071787d837f7b7271717e8f97a09b989798989a959baebac3bfbebab9b7b2ada29a949a9c9a96959b9c9fa09f9791898d8b878785817c7874767779797c848c939697979a9897948d8c948c877b75746f66676460626567625b56555c6b73776f65585451596168665a61646b686860585f6b777d7e83818b9a9e988d929599908b8b979e9e8a818b9cafb2b8afa7a2a1a19f938b84888c8d8b847f7a7b7f7e7b7874706c74787a7a7a7c7a7a807b82949ea89e998b8e93968f81888f95908a7f8f9c9e9e91807b7c7c8481806d64605e58504b51565756555b5b605a717678676a8482816e8488888185928c8a888e92919294a09d90848489979c94857b808ca07867677e8978776f70777c767274898f9998a19e9a99a4a2979191a29a9b939388827b7b7b756d67666d847974687477776d67646e8488866a5749565f6564666d777d7f747687a0afab9f91948a949fb3b5ad968f9b9da6a5a7968b898d979ca7a49c98999b9588746c64625b5758565656504d4d4f4d474a535c616b7279706b6b757d7e807e828994989790908e959d9d958c7f7c808284817e76736f747677716a64605e62636a757b7b7377777b7c87999e9e9797999fa5a8aaadaba59e928b858583807f848c8d89817f7c7a736f70777a75726f727379818f9d94827c7d84939b9a969390949492919598948c82868b8e857b737475757b808582848789837b746f727a7b76695f5854575c656568656c67615c616f767a75767782858e91918e90989b9e9a948e8d92999f9fa1a7abada8a8a29a918d908d8c898a86756d67656c696b6871726e6d6e73777d818b8f908b89898d8e8989888d89898a8d91949392909094959593918f867f78736f6b6d6e726b68676a6b69696767626165626262626263615e585154596063656363615c595c626a71757a7f8487898a8d91918e8784828889847f7977787d848e949a97999b9d9fa1a7adb6b6b8bbbabbbcb7b4b2b2a5a3a8aead9f98939997958c91918d8a81716a66646c6f6e635c5457534e4a4a4d4f484646494b4552585f50505e656e7071706f6b655e5b606b747c7c7f7e7f8185838382878d8d857c808d97978b7b767c89837d76818683786f727884878d84756f696d747675706d6c6a777e85858c9999999996979997938f93928d88828275707471736f6c7381908b81767b838a847e7b7f8a97a0a7aaa69e979fa9aeb0a99e9c9ca0a1a9aeb1aca7a5a4a6a8a7a5a097908b8787878788878c8c89807c808a929292918f8a7d79808c92897e7678797d7676706c6d717a706d6a707574706e726c6760636a67635d5e60625e5a5959565553535b626c67635e64686d6a6e7a81867f8b929b9a9fa0a1a1a4a8b5bebcbbb6b8b4b8b8bfbbb2aba59d9a938d8b8b8e887f737171777d7f7e7a7a7c82888b8b8c8a888682807f7c77716e6d6b68656464676a6d706f706f727578776f645b585c605f5c565859605c5b5c656c6d6c6a6a68655f63646662646a726e70767c7e78777478797f7c888a8983828385848485868785868a9399999a99989b908d909396958f8d8c92959695989e98928993979b8e8783939a96908a8c89888a94928d80787068625a4f525350515151535351586067727777787a82848785857b7c848c92919594938e878180808383817c746d666565646f7271686264696e676260605e5b5759595c5c6365625f5d5d5c5a5558585e5d636a6c6b696b6f777372717070727b7e858e92969598969890949ea7a69e9ea6b5b4b3b2b5b6b7afa89e98909097989488848288888b8f9195979a9997999da1a1a3a4abacaca4a0a097918e8e89848285898c8a878687888a8d909496968f91939e9ea09f9e999196969593989c9c928b8785807374757c73695d5958595e656d69645b5f5f5c5e6164605c575e6a6c6f615c5f6368676a6664656a70747373747b888e94969c9e9d97979d9d9fa19f9fa0a0a8acadaaa7a3aab3b9bbbdc1c0bfbbb8b3aba8a59e9a928c868587878786898d8e8e8e9093949598979a9fa4a299928f958e8b84868174726b63656460605e60626869685d595a5e626265635c5e616a68696c686157585b6265696d6d6c6b676360605f605d5d5d5d62676d69645f63686c7072777a808681817f868885878688888e8b8981828b949a9ba0a3a6a2a0a3a6aaaea7a09b9997919394989492918e8f908e8681827f7e79747171767a79756b605f6060635e5752515255575356595f6971747676797f7a747074787c72665d5c5e5b5f6166626465625f5b6063676360615e5f636666666664666b7274717070727b8384847f787f848b858280807e7e7a7b80817e797375797e81878e8e8f94989c9d9591959ba0979b96968d8b8b87817981827d76757a7f7d7d7f8d92938c88898984757c828e837d7979776e757986878f969a9c9c9c9c9fa2a09a958d8a8a9091938b888587888a98a1a6a3a09fa0a5aaabaaa8a49e98989996908783827d78746a68686e6f6d6f6c64605f60676d6e69635f5f5f6361605e595c626c70706e787d8079767b797d80808084868d908f8d9097a0a6a3a7b0b8bbb5b0b6c0c9cbcac7c8c9c9c3bdbeb7b5afb4ac9e918d958f8d8889888b8786827f7c7e817b76696d6a6b67686f787d7f80807e7e7b777b7e857b756b747776727075777675787879787d7c7b7574787c7f807e7d7a7977727474766f6762616265626061636363656465656e777f818286848a9095938b8b909899999897999ba2a7adadafadaca8a4a0a0a1a7a4a39f9b96908d888a81858c908c827f838e92938f878380807d7d7b7a77766d67645e5f64747b77726d6f747a7f7f8080807e7874747c7777716a6868687274756d6f797a79757679817a736a6f6c665e5a6361625c5a575a5c5f6367696b6a6d6c6c6f70746d696a70726f6d6c6f6a6968666463626264696d7274787c82898e929596979d9f9d9fa0a0a1a3a6abaeada39a95949593a0a3a39b979a8e86847f7e7d7c776e645e5a5c585b6569707177746d737a7e7369646a77858782726e6e70757373727b7d797471737173777a7c7a7775787a81868a88817e7b7d79756a67686b716d6f70706e686b6c6d6e6e726b676264656764666d7377777b7d80808185898b8a85857e73707076716b6163636568707a78746b6c6e756f71747b7b767982888e919397919296a0a4a79fa0a5a7a69c9e9e9f9b98949798928f898282817e7d83898e8b8d959fa7a6a5a09ea1a3a49f9ea19e9b9498938a82818a85827d7b7b8287858179726d6a6b6b68635e5d5c5b5755545358585550525e60646864656972776f6766687070767f7874737c878f8d8d9099a1a3a6abb8b4b8bdbfc1bfc5c6c8c1bab6b3adaaa8a7a4a1a4a49e9d9895969da29e958c8e8e8d85828282817c83847b77727c85867f777a828c89837b8184867b716d6d6c655f5a5c5b5c575d5e60524d5a656a6a68737a757e7f8580828180776e727a8177706f7c8c9593887a818b9790857f858d8c887c787782837e74727c8387887b797e898b81818089878887898b8b9192938e8d867e87919ba1a4a6a4a4a5aaaaa3acafaaaea89e97938e948f857b76756b5d6372797d766d5f5750536062635c595552565a5d5f6269686c717b82838485898d8a8684888b8a86817e77767a7a7d7c7a756e727379787e868b8b8484899395918382848480766d66696a686563615e5e61626463686864615f636565625d5856595e6667615d575e6160666d7779797373757a7f83827b7372717479777472757d86909899999d9fa5a5a8a8afaea89e95918787878c877b6f66646a6d6b696a707576706e7073757678797d7d7877716f6967686f74767d8285807c79777a8083837b77726e6c68686867635d5957565556565a5c5d5e60656b72757774736a696c6d695f626567616263696a727882827d7f86909aa09ea6a6ac9c989ea3a9aaaba8a5aaadaca8a3a3a6adaca7a09fa3aaaba6968f8f93938c8a888a8f908f8b8b908f8f90969a9a9a999ba1a09d9894918d8c8a8886858288888884858a91939088828083827a78788284857e7b777e8c908f898c929a9b9a95908e8e959796909094989387817f8482817d8181828280807e858b949091939a9f9e9f9c9e95908b91949897989b9593949ea3a7abababa8a2a0a6a4a4a1a0998f8f8d8c88868a8989878785807e79706d6966605a595b605f5a504b4d51535356565a5d6571787d7d858c9497999d9fa3a5aaa79c9591959696918885807c7b7a7c767476787b7d75707273777c766e6d6b6c6d6f6e6b70797c7a77737576797b756e686d747676726d6a6864615d595c5f615e5d5f63696f75737777797674757b81807e7a848b8d8783838f95948f8a8e909496979699959698958f8888858b8d897c736e747d7c766e706e6b625e5a686e70615d6567675b5d5a5c5c63686d66676973777070727a818682848487847f7c787c82827a6b696c727474736d6f6c68686a6f6c6d6e6f6c63616166635f5a5a5e64686a6c71757570686c7277747272798184817e7d848c908d877f818e8f918e92928f96999d9c9ca1a2a39a949a9fa39c938f8e9295928c8684858d8887868c8c898481817c79787a7976747b8082776f6d77838b8a827a7573717a7f837b736d6f716f6d686562676e6b676367707780818285878d96999a97989b9d9d9c9a999b9a9b98948c8a8d919394959592908f908f8b87848686867a75777e868b89827e7c808c92999a96908891979e9b9a9a97a1a3a19c99979fa4a5a5a3a1a7a9a6a6a4a6a09d9697928c8b8a8a837d757677767272757a7b797a797e878e8e8b8484898d909190908f88878b949b99948c888a8e8a857a737072716e6c6a6b6e6d64615d616970726e6762676e7678797d8285837c757c888b8d8c8d8e8d8d87847e82878c887f78798285878485888d8a8a8b8c8c8d908c8a858b8b8a8e949896928d9093949a9b9b99989997999a9a978e8c8d9191908d8d94948f8580828687847e7b7777726d65646a69665b61626364697175736e6f716f6f757d837e74676c7278777372726f65646264686a6868666360626763605a55555c5d5c58545c62655e58535d666969696b6f727375787f7e807e8585827f8085807c818e8f918e909290989d9fa0a3a6a8a5a4a2a4a6a7a39f9a9ea9a19b9393928d8887888b87868c8f8e80776d6b6a6d706f6e6e7376756f6a696f74797b7a79777370707373716b6a6f6b69676a6c6c6e6f726866676e7372706c6c71787f7d7c7c7c7a7b7d7f807c7f7e7f7a7b7e7f7d76787b807f7b736c6b6d72726b666367666359575b616867696c6d6e6d787f82868585828386898c8e8a8a89909394979ba19fa19e9d9a9ca4ababa69a989fa9aba19c97989897928c8a8a867d726a6b777a786d676266696e6d6a6b6d726f6f717b828687898c8f93969fa2a29e9c9c9e9f9d928b8d8e8d8a8787888887898a908e87827f858b909293929294989a999693989c9f9d9b989ba19b998f8d8e928f8688898e847f7b7a7978757272706f6b71777d7b78767f858182859099969191919593928c8a90989c968e8890979794908e999b9996959a9897979c9a98989da2a29a8d8380848b8884817f79716a696b6f6d686361685f5b575d6668686365656867696b7175747373787c7e7d7a79716e6d6e706e7476787777767576797d7a797b82878a8b898787858483858c8b89888c939d9e9d9a96979c9b978f8a858585837d73716f716d6b66696d707272706e6d6e6d7073797c7b7977777a7e79786d6a69696664707a82766961636c767c7a766e6e72787a797a7b80777575797b7b8082837e7e7c7a797b7a7a75706d70787b7a716661626562575a585a62686664636b75797b77848d938c847e7f83888a898c86837d807c7872757e87887f79757d7b7c7671777e8885817b7e828a8e93969b9c9a96969c9d9f9d9996959393939797969087827d777679858a857e77797d817f7e79757373726d68646465635f5c57585c5e605e62666d6b665e616c74746c63636a6e6c68656871726f6770778180828b90938b88878a8f8f8e8b8b8988817e7d7b7871797d807a777782898b88868a8c8e8a91949798a1a3a29a93938f93979f9e9a989a9d9992898e9397979593949491908f928f8e9197969797989896959396999fa2a09b95999998908a888988828382837e7b7b7f8b8f8d8d8b8a8e9398969491929695958f8986899192908d888b9295928885878f918f908f8b847a787a7e7f7a7775797d8284888b90939796948f919a9f9e938c848a8c8f8a817b7a7a71675d6168716f706e7a7c797573777778797a818e8d8b85888c8f91949391868b9ca6a79d9491969a9b9598999b958d87878d94918a8281848e8c87857f858a918c867f7b7d7f807973696a70746f625b5a62616469666661615c585d626462615e5c5a5c61636362606061666a6d6b6b7072797e8483807c7c7d807f79767675736f6f7171706e717377787c838886827e7f8485847f7a7a7c786e61646c6c696566696768676c6e71696a6c72706a68686c6a676164666b64646577807c746e767d8181817c77767b8487877b6e707a8a847c71797f7e817e817f82817e7880828a867e7576818282787269686c757b79726d6c7483807e7a8183807c7a7f7f817976737377716e6a757a79767373767a7c808485857d74747678746f6c6c6e6a66666d736e6967696d6e69676f78858e8c86847c818e9395928d87827c7f85919896969091949d9e9a96969d9b989288868c91918a837d7f8386868f959995908d969ea5a39b9d9fa6a7a2a09e9da09f9b9a999d999a9996928b85807a7776757374756e696f7878766f6e72777e8282848589858991969a94958f89868990929496908e93928f7c79788391949084828284838080828685878380808485898a8c8e91939396969ca0a1a29f9a9a979ea2a59e938f97a6a6a1969593958b87828a8b8a868a959896908b838280888b897f756f7376766d6a6d747976787d898c8c888381848c8d88837f878788827f7a7f878e8f898b8c908d867b8182817c787a7575726c655b60666d6b6863626b6f746d6c6f7d817b726f767b7f7c76737574736a6f707571747b7674717c847f797b7d81807f7d7b7976757370717173767f888c8c868180858a8f8d8d877d7e808381808081888d8e8c8787838384888d939695908680808184847e776e7376786c606163646563615e5b5c5f5f5f5f5e646b757577787c78736e738386867d808387867d7b7d8082838382807d756a65646b686c6e6f685e60626a6866616a7176706a6d6f7e858785868e8c91949b9b95989899949293989b9b918f95989b958c83818991888178787c7f7e7b7f848d8c8d8e8f8c89888a908c8a888987848182848a8c867f787e8283817b7e7d7b76757b77746c6b686162605e5a5b60636363646562646572767a777274787e7971686b6b6f6b7079858a87807f8791948b909397989792938f827f8285857c797d81827a757173777b7d7d7f81827e7b7a819192939091959da2a09a9493929692979fa19e9a928f92908a807773757e827c7067666e777b7d7d7f8386858886888a8e8f8d92969891898285898b8a8782807b7876787e7b7b7a8991928e8a8f919192959493908f909897938a817f838d9390898387878985827e7f8082837e8586868286908d8a888a8f93a09f9695969d9e9e9da0a3a49792909492887e7a7d7c767882848074747880807e7b7b7e828a8d8c8985838388909595918f91999c9d9a'

-- <TILES>
-- 001:efffffffff222222f8888888f8222222f8fffffff8ff0ffff8ff0ffff8ff0fff
-- 002:fffffeee2222ffee88880fee22280feefff80fff0ff80f0f0ff80f0f0ff80f0f
-- 003:efffffffff222222f8888888f8222222f8fffffff8fffffff8ff0ffff8ff0fff
-- 004:fffffeee2222ffee88880fee22280feefff80ffffff80f0f0ff80f0f0ff80f0f
-- 005:000110000001100000eee00000eee0000eeee0000ee1ee000eeeee000eee1ee0
-- 007:000000000000000000000000000000000000000700007777000777aa0077aaaa
-- 008:000000000000000000000000000000007aaa0000aaaaa000aaaaaa00aaaaaaaa
-- 011:000000000000000000aaa30003aa3a00aaa33aa0aa7a73aaaa7aa73a0a7aaa73
-- 017:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 018:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- 019:f8fffffff8888888f888f888f8888ffff8888888f2222222ff000fffefffffef
-- 020:fff800ff88880ffef8880fee88880fee88880fee2222ffee000ffeeeffffeeee
-- 021:00eeeee000eee1ee000eee1e000eeee10000eeee00000eee000000ee00000000
-- 022:0000000000000000ee0000001eee0110111eee10ee11ee00eeeee000eeee0000
-- 023:00aaaaaa0aaaaaaa0aaaaaaa0aaaaaaaa7aaaaaaaaaaaaaaaaaaaaaa0aaaaaaa
-- 024:aaaaaaaaaaaaaaa7aaaaaa7aaaaa77aaaaa7aaaaaaa7aaaaaaa7aaaaaaaa7aa0
-- 025:0000000000000000000000000000000000000055000055550005550505055000
-- 026:0000050005500450055544000055440000004455500440555044000004405500
-- 027:00000000000000aa000000aa00000aaa00000aaa0000aaaa0000aaaa000aaaaa
-- 028:aaa00000aa7777aaa777aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 029:00000000000000000000000000000000a0000000a0000000aa000000aa000000
-- 032:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 033:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 034:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 035:1111111111111111111131111111111111111111111111111311111311111111
-- 036:eaaaaaaaaeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeaaaaaaaae
-- 037:00000001000066010066666606666666066aa66666aaa6666aaa66666aaa6666
-- 038:1100000010066000166666006666666066666660666666666666666666666666
-- 039:00000001000000010000000b000000bb00000bbb00000bbb00000bbb0000bbbb
-- 040:1100000000000000b0000000bb000000bbb00000bbb00000bbb00000bbbb0000
-- 041:5440000000440554000445540550440455500044550000540000055400000004
-- 042:4400555040000550055000000555000000550000500000000000000000000000
-- 043:00aaaaaa00aaaaaa0aaaaaa70aaaaaaa0aaaaaaa0aaaaaaa0aaaaaaaaaaaaaaa
-- 044:aaaaaaaaaaaaaa77aaaaa77a7aaa77aa77aa7aaaa7aa7aaaaaa7aaaaaa77aaaa
-- 045:a7aa000077aaa000aaaaa000aaaaaa00aaaaaa00aaaaaaa0aaaaaa70aaaaa7a7
-- 048:aa6661aaaa6661aaaa6661aaaa6661aaaa6661aaaa6661aaaa6661aaaa6661aa
-- 050:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 051:bbbbbbbbbbbbbbbbbbbbabbbbbbbbbbbbbbbbbbbbbbbbbbbbabbbbbabbbbbbbb
-- 053:66a6a666666a6666666666666666666606666666066666660066661600061100
-- 054:6666666666666666666666666666666166666610666661100611110000011000
-- 055:0000bbbb000bbcbb00bbccbb00bbcbcb00bbbcbb00bbbbbb000bbbbb0000bbb0
-- 056:bbbb0000bbbbb000bbbbbb00bbbbbb00bbbbbb00bbbb5b00bbb5b0000bbb0000
-- 057:e33a333e3a3030a333333a33e40a004ee44a044eee4004eeee4444eeeee44eee
-- 059:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00aaaaaa
-- 060:aa7aaaaaaa7aaaaaa77aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00aaaaaa
-- 061:aaaaaa7aaaaaa7a7aaaa7a7aaaaaa7a7aaaa7a70aaaaa700aaaaa000aaa00000
-- 064:aa6661aaaa6661aaaa666111aa666666aa666666aa666666aaaaaaaaaaaaaaaa
-- 065:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 066:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 067:4444444444444444444444444444444444444444444444444444444444444444
-- 068:4444444404444444004444440004444400004444000004440000004400000004
-- 069:eeee555eeee50055eeee1110eee1a005eee10001eeee1010ee110001e11a0000
-- 070:55555eee050055ee0555055e0550555e550011ee01a0011e1000001e1000011e
-- 071:0000ffff0000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 072:ffffffff00000000000000000000000000000000000000000000000000000000
-- 073:ffffffff000000000000000000000000000000000000000000000000000000f0
-- 074:ffff0000000f0000000f000000ff0000000f0000f00f0000000f0000000f0000
-- 075:0000ffff0000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 076:ffffffff0000000000000000000000000000aaaa00aa00000aa000000a000000
-- 077:ffffffff000000000000000000000000aaaa00000000aa0000000aa0000000f0
-- 078:ffff0000000f0000000f000000ff0000000f0000f00f0000000f0000000f0000
-- 080:0000000000000000000ffff000fffff000ff000000ff000000ff000000000000
-- 081:00000000000000000ffff0000fffff000000ff000000ff000000ff0000000000
-- 082:0fee00000f00ee000f0000ee0f00ee000fee00000f0000000f0000000f000000
-- 083:8888888888888888888888888888888888888888888888888888888888888888
-- 084:b8888888bb888888bbb88888bbbb8888bbbbb888bbbbbb88bbbbbbb8bbbbbbbb
-- 085:e1000001e1110110ee111001eeee1a00eeee1000eeee1100eeeee111eeeeee11
-- 086:011011eea0011eee000011ee100011ee11111eee1e11eeee1eeeeeeeeeeeeeee
-- 087:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 088:00000000000000000000000000000000000000000000000000000000000000f0
-- 089:000000000000f0000000000000f0000000000000f00000f0000000000000f000
-- 090:000f0000000f0000000f0000000f00000f0f0000000f0000000f0000000f0000
-- 091:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 092:0a0000000a0000000a0000000a0000000a0000000a0000000a0000000a0000f0
-- 093:000000a00000f0a0000000a000f000a0000000a0f00000f0000000a00000f0a0
-- 094:000f0000000f0000000f0000000f00000f0f0000000f0000000f0000000f0000
-- 096:0000000000ff000000ff000000ff000000fffff0000ffff00000000000000000
-- 097:000000000000ff000000ff000000ff000fffff000ffff0000000000000000000
-- 099:0000000000000000000000000000000000000000000000008888888888888888
-- 100:0000000000000000000000000000000000000000bbbb0000bbbbbbbbbbbbbbbb
-- 101:0000000100000011000000140000004400000041000000110000001400000004
-- 102:1000000044000000410000001100000014000000440000004100000010000000
-- 103:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0f0
-- 104:000000000000f0000000000000f000f000000000f000f00000f0000000000000
-- 105:00f0000000000000f00000000000000000000000000000000000000000000000
-- 106:000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 107:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0f0
-- 108:0a0000000a00f0000aa0000000fa00f00000a000f000f00000f0a000aaaa0000
-- 109:00f000a0000000a0f0000aa00000aa00000a0000000a0000000a00000000aaaa
-- 110:000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 112:000000000000000000000000ffffffffffffffff000000000000000000000000
-- 113:000ff000000ff000000ff000000ff000000ff000000ff000000ff000000ff000
-- 115:0000000a00000aa80000aff8000affff00af88ff00af888f0afffaaa0afa3aff
-- 116:a00000008aa0000088fa000088ffa000fffffa00fff88a00aaf88fa0fa3affa0
-- 117:eeefefffeeeffffeeeefffeeeeffffeeeff0fffeefffffffefffffffeeefffff
-- 118:eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeffeeeeeeffffeeeefffffeee
-- 119:0000f0000000f0f00000f0000000ff000000f0000000f0000000f0000000ffff
-- 120:f0000000000000000000000000000000000000000000000000000000ffffffff
-- 121:00000000000000000000000000000000000000000000000000000000ffffffff
-- 122:000f0000000f0000000f0000000f0000000f0000000f0000000f0000ffff0000
-- 123:0000f0aa0000faf00000f0000000ff000000f0000000f0000000f0000000ffff
-- 124:f0000000000000000000000000000000000000000000000000000000ffffffff
-- 125:00000000000000000000000000000000000000000000000000000000ffffffff
-- 126:aa0f00000aaf0000000f0000000f0000000f0000000f0000000f0000ffff0000
-- 128:000000000000000f000000ff00000fff0000ffff000fffff00fffff00fffff0f
-- 129:00000000f0000000ff000000fff00000ffff0000fffff0000fffff00f0fffff0
-- 131:00a33fff000a3fff000000ff00000fff00000fff00000fff00000fff000000ff
-- 132:ffa33a00fff3a000fff00000fff00000ffff0000ffff0000ffff0000fff00000
-- 133:eeeeffffeeeeffffeeeefffaeeefffefeeefffefeeeffeefeefffeeeeeffeeff
-- 134:ffffffeeaafffffffffffffffffffffefffffffefffffffeffffffeefffffeee
-- 135:0000000000000000000000050000000000000000000000990000099900000996
-- 136:0bbb0b50bb0b5b00000bbb0000b50bb00b5005b09bb000b099000b0099000000
-- 137:eeeeeeeee0e00e0ee0e00e0eee0330eee0e33e0eee0330eee0e33e0ee0eeee0e
-- 138:eeeeeeeeeee00eeeee0000eee0e33e0ee033330eee3003eee03ee30eee0ee0ee
-- 144:00fff0ff000000ff000000ff000000ff000000ff000000ff000000ff0000000f
-- 145:ff0fff00ff000000ff000000ff000000ff000000ff000000ff000000f0000000
-- 151:0000999900096999000999990099999009969900099960000999000009900000
-- 152:6900000090000000000000000000000000000000000000000000000000000000
-- 160:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 161:bbbbbbbbbbbbbbbbbbbbbbbfbbbbbbffbbbbbbffbbbbbffdbbbbffddbbbbffdd
-- 162:bfff0000ffaff00ffaaafffffffaaaffdddfffddddddfdddddddfdddfdddfddd
-- 163:fff6666600ff6666000f6666ff00f6660ff0f66600f00f66000fff66f000fff6
-- 164:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 165:00000000000000000000000f000000ff000000ff00000ff00000ff000000ff00
-- 166:0fff0000ff0ff00ff000fffffff000ff000fff000000f0000000f000f000f000
-- 167:fff6666600ff6666000f6666ff00f6660ff0f66600f00f66000fff66f000fff6
-- 168:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 169:00000000000000000000000f000000ff000000ff00000ff00000ff000000ff00
-- 170:0000000000ff0ff00f00000ff0000000f00000000000f000f0000000f0000000
-- 171:000000000000000000000000f00ff000f0f00f0000f00f00f00ff000f0000000
-- 172:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 173:00000000000000000000000f000000ff000000ff00000ffa0000ffaa0000ffaa
-- 174:0fff0000ffaff00ffaaafffffffaaaffaaafffaaaaaafaaaaaaafaaafaaafaaa
-- 175:fff00000aaff0000aaaf0000ffaaf000affaf000aafaaf00aaafff00faaafff0
-- 176:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 177:bbbbfdddbbbbfdddbbbbffddbbbf00ffbbbf0000bbbf0000bbbf0000bbff0000
-- 178:ddddfddddddf0fdddddf0fddfff000ff00f000f60f00000f00660ff60066f666
-- 179:0000f6f60000f6f6000ff666ffff6666666666666666666f6666666f66666f66
-- 180:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 181:0000f0000000f0000000ff00000f00ff000f0000000f0000000f000000ff0000
-- 182:0000f000000f0f00000f0f00fff000ff00f000f60f00000f00660ff60066f666
-- 183:0000f6f60000f6f6000ff666ffff6666666666666666666f6666666f66666f66
-- 184:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 185:0000f0000000f0000000ff00000f00ff000f0000000f0000000f000000ff0000
-- 186:0f00000f00ff0ff0000000000000f0000000f00000000fff0000000000000000
-- 187:00000000000000000000000000f0000000f00000ff0000000000000000000000
-- 188:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 189:0000faaa0000faaa0000ffaa000faaff000faaaa000faaaa000faaaa00ffaaaa
-- 190:aaaafaaaaaafafaaaaafafaafffaaaffaafaaafaafaaaaafaaffaffaaafafaaa
-- 191:aaaafaf0aaaafaf0aaaffaa0ffffaaa0aaaaaaa0aaaaaaafaaaaaaafaaaaafaa
-- 192:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 193:bbf00000bbf00000bbb60000bbb60000bbb60000bbb66000bbbb6000bbbb6006
-- 194:06666666066f6666066f666606666666066f6666666f666666666666666f6666
-- 195:6666666f6666f66f666666fb666f6fbb666fffbb66ff00fb6ff000fbfff00fbb
-- 196:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 197:00f0000000f00000000600000006000000060000000660000000600000006006
-- 198:06666666066f6666066f666606666666066f6666666f666666666666666f6666
-- 199:6666666f6666f66f666666f0666f6f00666fff0066ff00f06ff000f0fff00f00
-- 200:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 201:00f0000000f00000000f0000000f0000000f0000000ff0000000f0000000f00f
-- 202:0ff000000f0f00000f0f00000f0000000f0f0000ff0f0000f0000000f00f0000
-- 203:0000000f0000f00f000000f0000f0f00000fff0000ff00f00ff000f0fff00f00
-- 204:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 205:00faaaaa00faaaaa000faaaa000faaaa000faaaa000ffaaa0000faaa0000faaf
-- 206:affaaaaaafafaaaaafafaaaaafaaaaaaafafaaaaffafaaaafaaaaaaafaafaaaa
-- 207:aaaaaaafaaaafaafaaaaaaf0aaafaf00aaafff00aaffaaf0affaaaf0fffaaf00
-- 208:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 209:bbbb6606bbbbb666bbbbbb66bbbbbb66bbbbb666bbbbb666bbbbb666bbbbb666
-- 210:666666ff666ffff6666ff66666666666666666f666666666666f666666f6666f
-- 211:f0fffbbbf0fffbbbfff0fbbbf0f0fbbb6f000fbb6f000fbbf0f00fbb00fffbbb
-- 212:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 213:0000660600000666000000660000006600000666000006660000066600000666
-- 214:666666ff666ffff6666ff66666666666666666f666666666666f666666f6666f
-- 215:f0fff000f0fff000fff0f000f0f0f0006f000f006f000f00f0f00f0000fff000
-- 216:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 217:0000ff0f00000fff000000f0000000ff00000f0000000f0000000f0000000f00
-- 218:000000ff000ffff00f0ff000f0000000000f00f00000f000000f000000f0000f
-- 219:f0fff000f0fff000fff0f000f0f0f0000f000f000f000f00f0f00f0000fff000
-- 220:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 221:0000ffaf00000fff000000fa000000ff00000faa00000faa00000faa00000faa
-- 222:aaaaaaffaaaffffaafaffaaafaaaaaaaaaafaafaaaaafaaaaaafaaaaaafaaaaf
-- 223:fafff000fafff000fffaf000fafaf000afaaaf00afaaaf00f0faaf0000fff000
-- 224:0300030070000f700003fff300307f0000f703003fff300007f0000000300070
-- 225:000000003000070000007f70000007000070000007f700000070000000000030
-- 236:00000000000000000000000000000000000000000000000000000000000fffff
-- 237:00000000000000000000000000000000000000000000000000000000fffff000
-- 238:000000000000000000044441004411110041e1400ee1e140e1111400eee11400
-- 239:0000000000000000100000000000000000000000000000000000000000000001
-- 250:0000000000000000000000004440111104411111000444440004400000000000
-- 251:0000000000000000001114401111144414444000400400000000000000000000
-- 252:00ffffff00ffffff0ffffffffaaffffffffaaaaaffffffffffffffffffffffff
-- 253:ffffff00ffffaf00ffffaaf0ffffaaf0aaaaafffffffffffffffffffffffffff
-- 254:0041144004411144041111110411141104411144004411110d041111000ddd44
-- 255:000444414444111444111440111114404111114014444440111114d04ddd4000
-- </TILES>

-- <SPRITES>
-- 000:11111111111111111111111111111111111111111111111177711111777aaaa1
-- 001:1111111111111111111111111111111111111111111111111111111111111111
-- 002:1111111111111111111111111111111111111111111111111111111111111111
-- 003:1111111111111111111111111111111111111111111111111111111111111111
-- 004:1111111111111111111111111111111111111111111111111111111111111111
-- 005:1111111111111111111111111111111111111111111111111111111111111111
-- 006:1111111111111111111111111111111111111111111111111111111111111111
-- 007:1111111111111111111111111111111111111111111111111111111111111111
-- 008:1111111111111111111111111111111111111111111111111111111111111111
-- 009:1111111111111111111111111111111111111111111111111111111111111111
-- 010:1111111111111111111111111111111111111111111111111111111111111111
-- 011:1111111111111111111111111111111111111111111117771111a7771aaaa777
-- 016:777111aa11111111111111111111111111111111111111111111111111111111
-- 017:aaaa1111111aaaa1111111aa1111111111111111111111111111111111111111
-- 018:1111111111111111aa11111111aaa11111111aa11111111a1111111111111111
-- 019:1111111111111111111111111111111111111111a11111111aa11111111aaa11
-- 020:1111111111111111111111111111111111111111111111111111111111111111
-- 021:1111111111111111111111111111111111111111111111111111111111111111
-- 022:1111111111111111111111111111111111111111111111111111111111111111
-- 023:1111111111111111111111111111111111111111111111111111111111111111
-- 024:11111111111111111111111111111111111111111111111a11111aaa111aaa11
-- 025:111111111111111111111111111111aa111aaa11aaa111111111111111111111
-- 026:111111aa111aaaa11aa11111a111111111111111111111111111111111111111
-- 027:aa11111111111111111111111111111111111111111111111111111111111111
-- 032:1111111111111111111111111111111111111111111111111111111111111111
-- 033:1111111111111111111111111111111111111111111111111111111111111111
-- 034:1111111111111111111111111111111111111111111111111111111111111111
-- 035:111111aa11111111111111111111111111111111111111111111111111111111
-- 036:a11111111aaa11111111aaa11111111a11111111111111111111111111111111
-- 037:111111111111111111111111a11111111aa11111111aa11111111aaa1111111a
-- 038:11111111111111111111111111111111111111111111111a11111aa1a111aa11
-- 039:11111111111111aa1111aaa111aaa111aa111111111111111111111111111111
-- 040:aaa1111111111111111111111111111111111111111111111111111111111111
-- 041:1111111111111111111111111111111111111111111111111111111111111111
-- 042:1111111111111111111111111111111111111111111111111111111111111111
-- 043:1111111111111111111111111111111111111111111111111111111111111111
-- 048:1111111111111111111111111111111111111111111111aa111aaaaa11aaaaa7
-- 049:11111111111111111111111a111aaaaaaaaaaaaaaaaa7777a777777777777777
-- 050:111111111111111aaaaaaaaaaaaaaaaaaaa77777777777777777777777777777
-- 051:11111111aaaaaaaaaa777777777000007770000077700000777777777777777a
-- 052:11111111aaa777777777777700000000000000000000000077777777a7777777
-- 053:1111111177777777777777770000000000f000000000000077777777777777aa
-- 054:1aa1a1117777777777777777000000000060fff0000000007777777777777777
-- 055:11111111777777777777777700000000f0000000000000007777777777777aa7
-- 056:1111111177777777777777770000077700000777000007777777777777777777
-- 057:1111111177777777777777777777777777777777777777777777777777777777
-- 058:1111111171111111777711117777777777777777777777777777777777777777
-- 059:1111111111111111111111111111111177711111777777117777777177777771
-- 064:1aaaa7771aaa77771aa77777aaa77777aa777773aa777330a777730077773300
-- 065:7777777777777777777777773333333330000333000000330000030000003000
-- 066:7777777777777777777777773377777730337777300033773333333700330037
-- 067:77777faa7777fffa777aafff777aaafa77aaafaa77aaafaa777aaa3a777aaa33
-- 068:aaa77777aaaa7777faaa3777a3333777aa333377aa333377a333377733333777
-- 069:7777faaa777fffaa77aaffff77aaafaa7aaafaaa7aaafaaa77aaa3aa77aaa333
-- 070:aa777777aaa77777aaa3777733337777a3333777a33337773333777733337777
-- 071:777faaaa77fffaaa7aaffffa7aaafaa3aaafaaaaaaafaaaa7aaa3aa37aaa3333
-- 072:a7777777aa777777aa3777773337777733337777333377773337777333377773
-- 073:7777777777777777777773337733300033000003333000303003333000003330
-- 074:7777777777777777333333770330033330330003000333300003330000300330
-- 075:7777777177777777777777777777777737777777337777770037777700337777
-- 080:7773333077730003777300007773000077300000773333007730033377300003
-- 081:0003300033300000033333000300033033000033300000030000003000000030
-- 082:0033000303333003330030003000030330000333000000303300033303000303
-- 083:7777aa3377777333377777733777777737777777377777773777777737777777
-- 084:33337777333777773777777777777777777777777777777777777777777777aa
-- 085:777aa33377773333777777337777777777777777777777777777777777777777
-- 086:33377777337777777777777777777777777777777777777777777777777777aa
-- 087:77aa333377733333777773377777777777777777777777777777777777777777
-- 088:3377773337777730777777307777773077777730777777307777773077777730
-- 089:0003000300330000003000000300000333300003333000033003003030003030
-- 090:3330003003000033333000033030000300030030000333300000330000000300
-- 091:0003777700337777333037773000377733003777030037770300377703303777
-- 096:7730003377300030773300307773030077773300777733007777733077777773
-- 097:3000003003300300003303000003330000033000000033000000333033003030
-- 098:0030030300333000000330030003300300033337000333770003777703377777
-- 099:3777777737777777377777777777777777777777777777777777777777777777
-- 100:7777faaa777fffaa77aaffff77aaafaa7aaafaaa7aaafaaa77aaa3aa77aaa333
-- 101:aa777777aaa77777aaa3777733337777a3333777a33337773333777733337777
-- 102:7777faaa777fffaa77aaffff77aaafaa7aaafaaa7aaafaaa77aaa3aa77aaa333
-- 103:aa777777aaa77777aaa3777733337777a3333777a33337773333777733337777
-- 104:7777773377777773777777737777777377777777777777777777777777777777
-- 105:0000030000000330000003300000030330000303330030007330300077333000
-- 106:0000333000003030000330330003000330030003330300000303000000330033
-- 107:0033377700037777003377770037777733377777337777773777777377777773
-- 112:7777777717777777177777771777777711777777117777771117777711111177
-- 113:7333333377777777777777777777777777777777777777777777777777777777
-- 114:3777777777777777777777777777777777777777777777777777777777777777
-- 115:7777777777777777777777777777777777777777777777777777777777777777
-- 116:777aa33377773333777777337777777777777777777777777777777777777777
-- 117:3337777733777777777777777777777777777777777777777777777777777777
-- 118:777aa33377773333777777337777777777777777777777777777777777777777
-- 119:3337777733777777777777777777777777777777777777777777777777777777
-- 120:7777777777777777777777777777777777777777777777777777777777777777
-- 121:7777733377777777777777777777777777777777777777777777777777777777
-- 122:3333333777777777777777777777777777777777777777777777777733333333
-- 123:7777773377777733777777337777733377773331777333317333331133333111
-- 134:aaaaaaaaaa222222222fffff222fffffaa222233aaa22a3faaaaaa3faaaaaa2f
-- 135:aaaaaaa2222aaaa222222aa2fff2222a3fffff2233ffffff3f33ffff3f3f3fff
-- 136:22aaaaaad2aaaaaa22aaafaaa22aa2f2aa2aa2ff2222a2fff2222ffffff2ffff
-- 137:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa22f2aaa223ff2aa2afff22222fff2f2ff
-- 138:222aaaaa2c2aaaaa222aaaa2aaaaa2ffaa22ffffa22fffaaffffaa33ffaa3332
-- 139:aaaaaaaaaa222222222ffaa2ffaaaa22aa22222aa223a22a32a372aa2a3722aa
-- 140:0000ffff0000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 141:ff88f88f08000008800000008000000000008000800000008000000008000008
-- 142:ffffffff00000000800880008080080000800800800880008000000000000000
-- 143:ffff0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 150:aaaaaaa2aaaaaaaaaa72227aaa2fff2aaa2fff2aa2ff2272a2ff222fa22ff22f
-- 151:fa3a33ff22a33333aa2af3f3aa27a333aaa2233f2aaa222f2aaaaa222aaaaa22
-- 152:ffffffffffffffff2fffffffffffffffffffffffff2fffff2ff2222fffffffff
-- 153:fffff2fffffffffffffffffaffffffffffffffffffffff2fff2222ffffcffff2
-- 154:fa3332a3a333f37333f37337a3333732aa333322aa222aaa222aaaaa222aaaa2
-- 155:a322aaaa722aaaaa22aaaaaa27a2227aaa2fff2aaa2fff2a22322ff22f222ff2
-- 156:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 157:0088088000000000000080000000800000000888000000000000000000000000
-- 158:0000000000000000008000000080000088000000000000000000000000000000
-- 159:000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 166:aa22ffffaaa2ffffaaa22fffaaaa22ffaaaaa2ffaaaaa2ffaaaaa2ffaaaaaa2f
-- 167:2aaaa22f2aaaaa27f2aaaaaaf2aaaaaaf22aaaaaff232222fffa7fffffffffff
-- 168:ffffcf22ffffcff22fffffffaa2fff2f22ff2fff2ffff2fffffffff2ffffffff
-- 169:22fcffff2fffffffff2ffffaf2ffffa2ffff222ffff2ffff22ffffffffffffff
-- 170:aa22aaa2aa22aaa2a22aaaaa222aaaa2aaaaaaa22aaaaa22f222272ffffff7ff
-- 171:2f22fff22fffff222ffff222fffff2aaffff22aafff22aaafff2aaaafff2aaaa
-- 172:0000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f000
-- 175:000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 182:aaaaaa22aaaaaaa2aaaaaaa2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 183:fffffffffffff22fff2f22aa2a22aaaaaaaaa222aaaa2cccaaa2ccccaa2cccff
-- 184:ffffcfffffffcccfafffcfcc22cfffffcccccccccfffccc2fffff2ccfff22ccc
-- 185:ffffffffccfccfffccccfffffcffcc22cccccccc222ffccccccfffffcccccfff
-- 186:ffffffffffffffffaf22ffff2aa22f2fc22aa22accc22aaaccccc2aaffcccc22
-- 187:ff2aaaaaf22aaaaaf2aaaaaaf2aaaaaa2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
-- 188:0000f0000000f000000ff000000fff00000fff00000f0f0000000f000000ffff
-- 189:00000000000000000000000000000000000000000000000000000000ffffffff
-- 190:00000000000000000000000000000000000000000000000000fffff0ffffffff
-- 191:000f0000000f0000000f0000000f0000000f0000000f0000000f0000ffff0000
-- 192:9999999999999999994444449941111199411111994111119941111199411111
-- 193:1111111141111111411111111111111111144444111100001111111111111111
-- 194:1111000011110000111100001111000041110000401100004011000040110000
-- 195:999999999fffffff9fffffff9fffffff9fffffff9fffffff9fffffff9fffffff
-- 196:99999999ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
-- 197:99940000fff90000fff90000fff90000fff90000fff90000fff90000fff90000
-- 198:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa2aaaaaa2faaaaa2faaaa2da33a22faff7
-- 199:a2cccfff2ccccfff2ccccccc2ccccccca33ccccc3773cccc773aa3d373aa7add
-- 200:f2ccccccccccccccccccccccccccccc3cccc33333333333733337377d3d73777
-- 201:cccc22ccccc2cccccc3ccccc3333cccc73773ccc377773337777777377777777
-- 202:ccccccccccccccccccccccccccccccc2ccccc337333323733332273233732272
-- 203:2aaaaaaa2aaaaaaa2aaaaaaaaaaaaaaa22aaaaaa772aaaaa22a22aaa222ad2aa
-- 208:9941111199411111994111119941111114411111111111111111111111111111
-- 209:1111111111111111111111111111111111111111111111111111111111111111
-- 210:4011000040110000401100004011000040110000401100001011000011110000
-- 211:9fffffff9fffffff9fffffff9fffffff9ffffff89fffffff9fffffdf9ffffddd
-- 212:ff8ffffff888ffffff8fffff8fff8fff88f888ff8fff8fffffafffbffaaafbbb
-- 213:fff90000fff90000fff90000fff90000fff90000fff90000fff90000fff90000
-- 214:223a3ff322227773a222222aaaa22222aaaaa222aaaaaaa2aaaaaaaaaaaaaaaa
-- 215:3aaaaadd3aaaaaddaaaaaadd3a77aaad2222222222222223a2222233aaaa2332
-- 216:ad3d7777d7d777777d7da777d7daaaa73aaaaaaa722222222222333322333333
-- 217:77777777777777777777777777777777aaaaadd7222222223333322233333372
-- 218:773732777777722277777722777daaaaaa332222223222227272222277222aaa
-- 219:2222a22a72332222a233322a22232aaa2222aaaa222aaaaaaaaaaaaaaaaaaaaa
-- 224:1111111111111111111411111114011111140111111401111114011111140111
-- 225:1111111111111111111111111111111111111111111111111111111111111111
-- 226:1111000011110000111100001111000011990000119900001199000011990000
-- 227:9fffffdf9fff7fff9ff777fa9fff7fff9f7fff7f9777f7f79f7fff7f9fffffff
-- 228:ffafffbfafffafffaafaaaf7afffafffffffffffffffffffffffffffffffffff
-- 229:fff900007ff9000077f900007ff90000fff90000fff90000fff90000fff90000
-- 232:05dd50050bddb00b0bfdb50b0bfddbbb05dfdddd005bbbbb0000000b0000000b
-- 233:bdb50000dddb0000dfdb0000dfdd0000dfdb0000dfdb0000dfdb0000dfdb0000
-- 234:00005bdb0000bddd0000bdfd00005bbb00005ddd0000bdfd0000bdfd0000bdfd
-- 235:50000000b0000000b00000005000000050000000b0000000d0000000b0000000
-- 236:0005bdb5000bdddb05bbdfdb0ddddfdd05bbdfdb000bdfdb000bdfdb000bdfdb
-- 237:0000000000000000dbbb0000dddd0000bbb50000000000000000000000000000
-- 238:00005bbd0000bddd0005ddfd000bdfdb000bdfdb05bbdfdb0ddddfdd05bbdfdb
-- 239:ddb50000dddb0000bbdd0000505b000000000000bb000000dd000000b5000000
-- 240:1114011111140111111401111114444411110000111111111111111111111111
-- 241:1111111111111111111111114111111100111111111111111111999911119999
-- 242:1199000011990000119900001199000011990000119900009999000099990000
-- 243:9fffffff9fffffff9fffffff9fffffff9fffffff9fffffff9fffffff49999999
-- 244:ffffffffffffffffffffffffffffffffffffffffffffffffffffffff99999999
-- 245:fff90000fff90000fff90000fff90000fff90000fff90000fff9000099990000
-- 248:005b505b00dddbbd00bddddd0005bdff00000000000000000000000000000000
-- 249:dfdb0000dfd50000fdb00000bb50000000000000000000000000000000000000
-- 250:0000bdfd0000bdfd00005bdb000005b500000000000000000000000000000000
-- 251:b0000000b0000000500000000000000000000000000000000000000000000000
-- 252:000bdfdb0005dfdd0000bdfd00005bbf00000000000000000000000000000000
-- 253:505b0000bbdd0000dddb0000fdb5000000000000000000000000000000000000
-- 254:000bdfdb000bdfdb000bdfdb0005bdb500000000000000000000000000000000
-- </SPRITES>

-- <MAP>
-- 000:003434000000340000340000003434343400343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000000000000034340000000000340034003434340034340034
-- 001:003434000034340000340000003434343400343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000000000343434343434340000340034003434340034340034
-- 002:343434340000340000340000003400443400343400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000000034000034340000000000340034003434340034340034
-- 003:003434003400340000343400003400003400343400000000464636363636363636363636000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000330000000034340000000000340034003434340034340034
-- 004:003434000000340000340000003434343400343400323232333333334535353535353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000323200000034340000000000340034003434340044340034
-- 005:003434000000340000340000003434343433333333333333333333333333353535353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000333333566634340000000000340034003434340034340034
-- 006:323434323232323232323232323434343432323232323232333333333333353535353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000566632323232000000000000000000000000323232323234340000000000323234323434343232323232
-- 007:333434333333333333333333333333333333333333333333333333333333333345353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000343434343434566632323232000000000000000000000000333333333333333333333333333333333434343333333333
-- 008:323232323232323232323232323232323232323232323232333333333333333333353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333333333333332323232000000000000000000000000323232323232323232323232323232323232323232323232
-- 009:333333333333333333333333333333333333334242424242333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333333333333333323232000000000000000000000000333333333333333333333333333333333333333333333333
-- 010:323232323232323232323232323232424242424242424242333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333333333333333323232000000000000000000000000323232323232323232323232323232323232323232323232
-- 011:333333333333333333333333424242424242424242424242333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333333333333333333232000000000000000000000000333333333333333333333333333333333333333333333333
-- 014:000000000000000000000000000072820000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000054640000000000000000005060000000
-- 015:000000000000000000000000000073830000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000055650000000000000000005161000000
-- 016:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000052620000000000000000
-- 017:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000053630000000000000000
-- 018:0000000000000000000000000000000000000091a1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000000000000000
-- 019:0000708000000000000000000000000000000092a2007080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 020:000071810000000050600000000000000000000000007181000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 021:0000000000000000516100000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003747000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 022:000000000000000000000000000000000000000000000000506000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003848000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 023:000000000000000000000000000000000000000000000000516100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 024:000000000000000000000000000000000000000000000000333333334242423333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 025:000000000000000000000000000000000000000000000000333333333342423333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 026:343434343434343434343434000000000000000000000000333333333342423333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 027:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 028:323232323232323232323232000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 029:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 030:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 031:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 032:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 033:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 034:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 035:333333333333333333333333000000000000000000000000333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 038:000000000000000000000000000000000000000000000000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 039:00000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 040:000000000000000000000000000000000000000000000000000000000070800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 041:00000000000000000000000000000000000000000000000000000000007181b1c1d10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 042:0000000000000000000000000000000000000000000000000000b000000000b2c2d20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 043:0000000000000000000000000000000000000000000000007080b0b0000000b3c3d30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 044:000000000000000000000000000000000000000000000000718100000000007080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 045:000000000000000000000000000000000000000000000000000000000000007181000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 046:0000000000cede0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 047:0000000000cfdf0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 050:00000000000000000000000000000000748494a400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 051:00000000000000000000000000000000758595a500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 052:00000000000000000000000000000000768696a600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 053:00000000000000000000000000000000778797a700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 112:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353535353534343535353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 113:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333334534343533333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 114:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333334343333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 115:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 116:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 117:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 118:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 119:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353333333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 120:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353533333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 121:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353535333333333333333335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 122:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353535353333333333334535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 123:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000353535353535353535353535000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 125:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000daeafa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 126:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dbebfb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 127:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000dcecfc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 128:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddedfd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <WAVES>
-- 000:21100112deeffeed21100112deeffeed
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- 004:21100112deeffeed21100112deeffeed
-- </WAVES>

-- <SFX>
-- 000:0300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003002090b8000000
-- 003:010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100000000000000
-- 005:010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100010001000100000000000000
-- 006:030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300000000000000
-- 007:040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400040004000400406000000000
-- 008:030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300000000000000
-- </SFX>

-- <FLAGS>
-- 000:00000000002020000000000000000000000000000020200000202000000000000000000000202020202020000000000000000000002020202020000000000000000000000020200000000000000000000000000000202000000000000000000000000000000000000000000000000000000000202000000000000000000000000000002020000020200000000000000000000000000000202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </FLAGS>

-- <PALETTE>
-- 000:140c1c44243430346d4e4a4e854c30346524d04648757161597dced27d2c8595a16daa2cd2aa996dc2cadad45edeeed6
-- </PALETTE>

