Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BFFE64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF3489780;
	Thu, 21 Nov 2024 23:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BTJFCgA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57DA18978E; Thu, 21 Nov 2024 23:32:43 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE50896C5
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6eebae6f013so15262767b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228357; x=1732833157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaQBvJJGrJfoaRmxmW4Il5dtaPsJb0cwjI7xbYriTNQ=;
 b=BTJFCgA/FzXLtBRhSCzAZCzSDx5AzV3LQU9mSZDwwfC3fnRABoUWnSlImrAYRfs73g
 Lewj0g/p+9vyxxWOCTf3yUZGXaC80l0BUnCmppa92gWKe5WMe5SMz0nQK+sQ2lnUn0P0
 q0UlrTHqhAdtV9YH76hvv8YA/J3gzwDaOloeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228357; x=1732833157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaQBvJJGrJfoaRmxmW4Il5dtaPsJb0cwjI7xbYriTNQ=;
 b=ntBAaYDOoFv3Vx7CRCQ8KMhVMU5qJUHdWQoxMcsdyxkPeTS5vKEdEQLODw/HvUKdUp
 zWXw+P5LY9czdS+uCmPZ87InQ7WrdMC887sIjB+9uQL8NXJfPXABYcbiWLEP7nYHXF/3
 RqfVxx9OuNhfe1ZQFqptqVOV7/Q4VjaBtfB+k/jygexaPsOcKqwRVU7zVRuikNGi6LDi
 U4lYc/ihGzmECjXKC1tQreTS9jiLDLBWX27wdMpPxekFcbVGCybwijycImxtgldgHZ2S
 jw2F2AIwrb7OoEUhR1mqlfxW+jKiIdQslOsjhIMlyifRNdF18hG/vkup3C6acAR9k8C6
 5tcw==
X-Gm-Message-State: AOJu0YyyWTvPj0xKE482z/pKf4AjuHsd95RHbasVsffaSXE5sJmFDOJJ
 uQ4rGkgk8zThrR6Dj50nCEUAaTP0q6MJqKbob8Zj9VA0p1/4/pB4GnqXWXYvggSSzFqj1qYDF4o
 =
X-Gm-Gg: ASbGncu0r9OQOD44WdfBu8JgZIt9fdoduazNlW3zCUqaeE2jBHuH0KSz63hMwwFkoRG
 5XXpa4hSrTBvSlCOKoOvMWuaGrJZ1LF22fPc7iPO2jGlsLdxPvDtrP2LhwecqzCuDJAhpV46iJG
 LW7SszeguBT0SrArrPkiOF+Cz3WggvwM3uekqNREAvHHDm8PYegJNxnZA8ULKZ7JWMdQUs4jdyw
 Re9Q+uxL0cmC4dHXm6EJ3Sq38JCYaynqjDIbEt3D/EsHec=
X-Google-Smtp-Source: AGHT+IGNHJrWLfLs+VNpDQPtnNVbVdvGf80LYHd0l3KHniScHozFt0ZM5eTwMyDkj5xw6O9/gtGlWQ==
X-Received: by 2002:a05:690c:7281:b0:6e3:2e50:8bd0 with SMTP id
 00721157ae682-6eee08a1141mr11282387b3.13.1732228357278; 
 Thu, 21 Nov 2024 14:32:37 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 8/8] bootstd: Remove prepared images
Date: Thu, 21 Nov 2024 15:32:14 -0700
Message-ID: <20241121223217.330117-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

These are no-longer used. Drop them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add patch to remove prepared images

 test/py/tests/bootstd/flash1.img.xz | Bin 4924 -> 0 bytes
 test/py/tests/bootstd/mmc1.img.xz   | Bin 4480 -> 0 bytes
 test/py/tests/bootstd/mmc4.img.xz   | Bin 7072 -> 0 bytes
 3 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 test/py/tests/bootstd/flash1.img.xz
 delete mode 100644 test/py/tests/bootstd/mmc1.img.xz
 delete mode 100644 test/py/tests/bootstd/mmc4.img.xz

diff --git a/test/py/tests/bootstd/flash1.img.xz b/test/py/tests/bootstd/flash1.img.xz
deleted file mode 100644
index 29b78c62a9bf264fa8b795b82b432bf3ab4e2765..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 4924
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
YhlPdFIp0xdukLa_CjZAFrJ4EP0QdZp5dZ)H

diff --git a/test/py/tests/bootstd/mmc1.img.xz b/test/py/tests/bootstd/mmc1.img.xz
deleted file mode 100644
index cebf7b9c53b3ed2370dbc65f0d26dd9bf096fab8..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 4480
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
LKYtbgI|lnVW!bv$

diff --git a/test/py/tests/bootstd/mmc4.img.xz b/test/py/tests/bootstd/mmc4.img.xz
deleted file mode 100644
index f4db011969fa8bea352ee2b8318dfdd72ccf72d8..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 7072
zcmeHMXHXPemhDEeB*{$<O3qP00SQfRGB!aPP%@H(AV?6T$yrcB10Ol3mYf?TXAlq(
z5SpApY@lIgYWK%h?T>YK=i8dCo!_rs)w`$8ednHYvC;uhGXMY=J=Xxn0k8v^0002R
zICSLp_5uFxGXTI1d#!1VGNTr`mE;p*%0&LKnku_|*GGQJP@UYW>mQ)!S^JbvQYkY(
z46W26RjbZTot!9{G(@Wx*b0~aDkttKa_KAZeVurk05wnjsJ_IcR{H{__QF(ucVN)d
z-lkL|MungQ%rzK*PZ?3resA^mSYFFcDUpiomLlbs$1BrccSmp2c);YP*MZAdA4P;r
zx)LHz--dSCq8=FjI!}@k#Vf2iaO-y0Q6rg5x>r_d#oRJh%S~@#`fl6K0NSzbTVcAs
zVU9<L`Mg+pePzJ!J<4LvriA%s`1lv^3nICYVLq4dNVy|ayAZ65TweLbm%fY>|8&%T
zehHBty>Ke+c_zbISABGfV`}TDd7fk`WnO^o*aJOcQsyS>S(b6*O&6LGScxq-nbF&l
z*qMRP8MmRcj(#7Av-nQP<^Upc`t<1=?K~Rt2J!%<2ZDf`%-k@-T&=+>XQBar-B(1t
zIWn5YMc0ek@OGsbLxJFV9r0XZj~xB>g{ATEQ_?k_0UO039vtE!mUDLlehppJo8dgN
z_#G_I+Il8h88;u0@txv$alb}7m5QSvYx_x@TO6VHAEUJN{PX7=TC9YhuOzoIKNvq*
z(=3aAaItuM_%+49PLt%wKG{E%^SD=CZRrWN>fHFNs57I?s72}X2*y>K&x&IUGm4|e
zOy*1KwUVDx6VJ`VZB6)j?7{0&n1MYu@P1k)Sb&WChpcfXJj9eR2ReE+Irq~w_3j$b
zl11cmE}08${Wex|jtL-PP{I{Nwye8FaMmkX9lxr0%8?%}5o~jUo;cZ3W#&62hWv2C
zq6bxHm3rO0GA}2!5GgY+TCzoXl6i<HuPwhEZD*y57kg^b5SG7MraJp1?ikPZNrIcL
zWm0~yA+Om3WK1ful9W8`>-7zkC)_Ufwe?e04UaqZC+nq>&zo>;{2hB8+4c>IFBu=|
z9F?u{9~Co9i)(W<K{f(#J?GgE9J6;AIE8eXWq)nEX&3XeYa_gs$y6!^Sg9BtSVnd}
z4Dk0&oblw#pU8OhbvHHQ_<+>E)`0>k;nxwH%!CXBw$?Gx)U+_uVIfdkQIq}M(;=yJ
z-ba1<51*$@-(mh)=>A<06cw4}+7?*rw+t@|Y{W}_TFrVOT0;%x++b-W-ApK%oQk`V
zm)XekQd)nd%lpW6DvvK<N$#W3QDme$c(#sd+qU?wSycn0k)zQmNT-vi_aq?5k^8V`
zN>GJ={HlXtkISHGSkWn70bl`l4BhopV0ur(D1>@MPSyN5c{zG=3<m<24Fe~Mca(Pm
z@0ssaB3lI~K3m<cIvn95)1MKRJECbdg*SW1Q7<1_;&|;0J~5+qjq;KT(v)>+QZ~Vd
zOFv*Wfw?*#Fp#K;Az5Ue&L=$@8(O@co4%_{I1A$T^=P!tN0q%>NI2kjzJwI6;+-9X
znN3>wHy$Ib#}h_KH&eH%Ag9)<Je!^cH@ok*hsh#Hc&D*_dkCz3#O7tv$|rBbj*?IQ
zq&%eB?~Ozibto2kcbVvDPWVD!VQagZiCMeCoRMT=Qg$0&v58COO9M>4A_uOcB8Ic<
znHrI<IN6a6n6$KKV)Y0Wm7Zho9zOmk()XXlMqcXW89s07s>OUGXE3=QRL?n6%I?7d
zVo6}4rC?ybi&@xmt==9{L{z_?xwST&`JU2qoTv%4WQjLx&6hQ}fr+`kDMIj66pztv
zPi3Y7T`K;z*bxtm52Bx2Np|eeIl83UjT9{XHNHGF5y<dlH`KZW<ivcwHOBvgdSmBF
z7GmwGL!{c41<ZuXwUBEhxkTsoh0#vujspM+?$^B_xAqSb3v0hcyqi9A1j&qoncQ3E
zoScYx$e?6JeuY*>(zMoSMH$14?dZ4S!J0!+=)yENaE`praq+X~_#1M}6QO2xcioGQ
zi@Jo9Z)gsfL*C}+9^|VaPeQ7!+q%6dkAX5#)|IIhK~>{+K5q64Jvwx7Uk9QlOo%=A
zQm`?@3o1~tYlPP>N6=0%PVgD(%az3&BCz?F(XI=v*9kW}{cqbYe>5FHf8s#Oh1LwV
zs3sZJ1oSC-QoI!>RQTCyfHCoj+(WMmmd2@iGWcg3_l;9OwkD%wB4>=ZzC~)I1VfOL
zH0d9;KaJCp{h`(Ua^l^5M)Z({nrJh0{KZ2O{_r;`g-4kH`Vv=hLYu(nlhM5)ZbR$|
zOWa9HY%4$Z(lBb5kWGWNWPB4)j!Mqj)H?X5(GlE7K;&zWo>3A<I{qElpt~G(mzZ=$
zAq}u_>klHny|P;~t_n{Q+T`L6nS}eR?m5MrusxpPh{?2!=r?>xC)_?4pf3Cjoeb=J
z^=u;fzpID<aubHQeF=02?0Fd$V>_w>MHvu{aiXsO<$cC{Paq-Q$<m8P8n2ho)UYe4
zX1fDi!cWSI=YEjadv_YQDWpp3nNvwv+)9W3_|@S~W0r+$z28^r2o`}DR)b|OZOxOk
zoQMHCl`{K62yXpzh<-+0C|jV^VoLhY8JgjqVTo2JvD!BtU=Ko0;7h8f61psizvF>_
zhD`p06nf?8iVJZ|0p$O?QU50{>c2B~{4SpQ<O+3&TS|P}-vI2?7cK?H!wilvLv~p3
zO+?UJDk3wXe~ceH%_K>NhUFRN=DxPINO4o{wIR5rlg)QAqLVMtY~};qXYG~o-7lzq
zr^#Z|Af39Og=6}WGuvG5U@_=rzY^cEVUqs-f!46Il;&3ftN7UM(Zk#F_Y=(DoSB!f
z@Y((nK+FO|dBVA7eJ{l6(TzI(D)Oz=h?w8|?>IE3WommRaXrD+59F{W6!c;RYz-{O
z81@tW!QRy&&*X*J_5D7<XFuoLGlO*;Sat3>HgnS$ZFQDBZg2)F6H8obxdS@cS1ydm
zfZ_3`miv=L)6)mUGsp>F<jH)cZ+ftuy==8!Za&sfA(CMM7oL2>WL(o|;?k!VxP2NW
zcsz46t~T$<1j$J~&<0Z6PgwnBAlsLt{MH!M*Wr2m1(TcKU+a}N4yTB7w5)bs-dWOg
zZr^(qeh*zlFr%Jgf0yixY|F3i&TH@9x<W3AZM?-B&FIlt&epmHl5}iWmxU3L&d24c
zpjLZ)ksbFd#n8%M!O#!WjncUJA}XvIr-Jbeyy;C$;Mi|-pD2@b?sc$zgsu(o^4X2i
zvdyPx*}aGXY@&wb&>n`1KAd?z>^H{fa`k7-)OB<|-$ue&p*KX-*QF1$6NyiqVqY<Z
zea1@mMdat=39B|)eJB)8#jSc63sJok&TV-tS}D7k*hz&x5Y})8&*z%f5Yr|EoC<ZM
z9Co~C1LB0t(Ar_%o|Hku<@mUeV$3FjkMr=GCZ%7DFx;@J51&Qh$_Z47po2q3-SmWD
zOg;_s$XB`T-WuUCk&X^$%Y|%t991!7VGp|o!p-|R!)rC|Evdoe@+=QWFRRYWY(2_G
z0~n!EK%ycXJ}L7C_n7C^v7-m4t#OvPcZn-bUTd}6F8aWgAI0roVXB)!mE^JqgLJB^
z>yLVg4i^xzNqOD3jQ(NmPesZH0cT8HpwQxqgS0maYiC|<Bih=>6&3ewX6xnLT{0Y;
zbs-`Ltj!&d<D>Z=TgK%0{=!ssRIEDWP-#6`x`s{235*_&ot;{`eb*-B!x_^UAFT^2
zJr7bD$u%w_NP!R()+!wIP!F`6!5oYeURk;buv`7q>}#=6b--)lW_A}xe-xRtRvg}h
z>?-jSU^574^ka+BO`Q$5c-V5o4@XWhq;qthe0fpIzO4RjyJ|n`a7DZp6()&-1eM<O
z70Du^jPvx8UGF4nGa1@?zGJL-y}|u5B4QDgEv7`r8kXFq8cWJCsZGX>k-56xqUsH*
zYDynV=W$Ie-eM<=ov)z6eWa(Boe0$mUU@Z73E_w)$y0W0%VFjCE-km%Dre!}3KE$<
zMt^Av33Qsh7$7`}$nojO)Lk|73otQfFd_5pD6y(?ut&wZ)Rfe>@=~o>XBTi4E2zqb
zlZBkVk3@I6Dsptbg*5Pv)~Aj=stGM~yOg41_vX75uHt03as8eLR0}x_kiH=9jwpM8
z@ffZ_Q%cjiYD6`zVbYLZ%$!SV6jXRNh5HtR$hLR04X#CrA+EjYt!uB<zv+0b&Z9Ff
z_Qt}h(9n5+W6yw(9pdV+z+3f8+eU5+-9<VKHrydDOfcnmr-n0Y=0j><Lt)g>3C-L-
zX<^HBjgby6dOxj!VJz5gz0hF%BonvtoUYw8jhdtZ5bxS=ndC%7H>euQsTRKLlwB&4
zblF2t#mbF$^bvydX#_50NZII&v*S<)^Jw{?Pb)a2t!4DXiMgDXMHBj2;|uPoS(Dun
zDp!n+Yhd2-wmBvuA*Sb7Xy!L$Q{ADCBtDUAt;%H`3$2bqtqDVb@^1GEnDhUG9{&gF
zGQ%qNArZI4c<R3)H5c?DA(uafo||oyuVipgsv6DOPPZizH9zEuiKcYvGB1WRGmw1b
zXd=*ULGe{}%xZ)bA(nQgw$)k{`)S47X1=Hzlfrul#|?BBy@oo-kAP%k7_BD}0yW7}
zHg4a<Uq==fH%Nf&yFLs^V88nhnl0weF_{GFVi%u%lk|i3xQ86Zb=0tC>B%dUoTy#e
zZ)+$$AXL3VhCOBEp_}7g-i1xysGU-plDn;pCDJi9-M|RRVay*))XdTywC-C$D?)!F
zgwn8mocFU!qRMaLncreDZK0>^YPTd}S|Ee2AlqyN_&gLzVU)jJA{kbWytrP@@^3Uf
ztbiW792Pvz-${w&L|yOpE09P>2H@GLiBNWRDe{)F{-msXR9YG92($m17dD>FLQhvC
z+zXGJFB+Tjy{g>u=euIynw~9Gm*-taa2A9WBv|q3q*(CIH0JVizMP3}TOD+AX_<A_
zO3^KhC*YZQ(F=8PLsXob+6XY=mF#@c1KbHEEPwaV5W+8<YFx44)*Dt|F+=vpoN>1~
zLWxcjHFI;Q?GiZ*dayo#?vocSN}AE3Ji*ayu6NCGG<9#P%9ktL<42F8BujipOgl<D
zo*R2%j7~BNwAzi}L+3{c%S%g|^bxZyRm=f?oVzQ$ooD3jfxFs|dIw;z3EJfL)$vzE
z@4bx59f%cP6CW#IQxtUF`_OfVwX%@zZ8XM2*9e7G7Tm8w+2S#iafq+4tT3kg^tjJd
z)u3l<q?1Xco6WYZSrbmo{dUe9`N0<wIzQqHo;c1tr+Bw5tz+dNf)9{#hsNLk$lso&
zVFN*erMDO+l86O@Mj~`|!}N#T1FP=uf2R`;3J}p=PP(8hs)xbEZ7BS5avmV%ukL5D
zJT*3@pVJV$T&W3;%6iEXrAi`qSfSB8jp02aV!r4aSz)B+x>^2MF>fns-SkpMtol{6
z@7zK09fX|L;Y+bRwWIFoql2<8au^S$_pF-yq+_o_m9xJ*44f~E;AnOG1xl=5lBVrq
zPu2P3wUiufo*2FsacSRDUHunn_xM<rQ^kXaQ(H<C2K}{}ML^_AQikLoXo@=-17g*U
z+uge5_xXW$A5K+_P<IFh5kB8lBih?;A{}fl!o3%}A37$uI3{CjwrN^^7}uGnpKTeJ
z&dy7ZGU>mUb3A;Dq~CSw)HHACW-VA+S5~?7iXdME(dwl2)}jfsS!i-<lx=3hH@oMo
z$Vc-8O%+&dD(K~1aWFB`ks$x+k)3%B%hSv}VM6WxA<bajw-O##XHyY1Rv8~cVTI==
zN5UR5n+jvApA|zL(<AN>d*UT^eRkO-rt~;3VJr77NYNm`2^L3bhb-_&PVHH%wx(|R
zO{|7#bK=8S_xf4WHF>*tf+N7Z><8wyh~8AGF3*F@H2^aaFJuiMPm5SCR2qgWSO5|x
zAk|zvsUED4f8VG5W7EFh9lQVMK_d{iUI1}R3l#sY-}IAZi{LUe!hV)c)?p8Pt@md*
z-v1*=Vn#Q{|7H;deg`<vBtSW+4!U3#`M;4F{F5RG8J-#Vm#O}1mjAom{col^8z}Kx
z6#LKF(VxqM+@Np;I%tQ0{c>=rb(`3Fy276vh5ddx3j@Crga1XfzmsYqghl{7Kzq!n
pcF<o}Z2;3}KI-mavEBe6Mk*vEgcwDdLRgEkzry+3A+D*}UjQf@%fJ8t

-- 
2.43.0

