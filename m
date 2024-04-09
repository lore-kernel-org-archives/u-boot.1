Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA5C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 03:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CF688172;
	Tue,  9 Apr 2024 05:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="q7kmFEP7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBA488173; Tue,  9 Apr 2024 05:35:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB9B880F1
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 05:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712633701; x=1713238501; i=xypron.glpk@gmx.de;
 bh=xAShVKZ0iRfKZns14Sksxh80yHR/L1R8e0huHlnJDS0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=q7kmFEP7T5ozXN92sCbSCotsovWgNOSgdyaAR/qEPqMKHun10cLWyOzcmZ3NRfCF
 gDtR7dswYqVJaWMOuWycxMGwovliLB/xEVgmZN39kkDFXNeE1ScfsaBpRVDY+l4Rj
 UKYbbJBajETE26xA6Vw91OrhntbBVEs5wn6PCmEAy4hbL24HIf+630yB4zuIFOIxg
 me2n+vRGh4jR5XvcOT9Vg62c+Sjgfxilkpdez9xF0lK8MdmsMjeBoPZxHEmpqS0Bc
 JkY4RNqiXbPgbPVtj12GgOOu6lpRmJLQMe7FW2va/Lxoe+rRNeQcKKEt7dwM2KLbE
 sYjVrUJTrIzGl9446w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1sG3DY41Im-00Uqeg; Tue, 09
 Apr 2024 05:35:01 +0200
Message-ID: <ee9a13b7-6b52-4bc8-8876-e194e1a66f92@gmx.de>
Date: Tue, 9 Apr 2024 05:34:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] ti:keys Add EFI signature list
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240408213349.96610-1-j-humphreys@ti.com>
 <20240408213349.96610-2-j-humphreys@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240408213349.96610-2-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jzXNcgPkq97smg0z/0nsalGNyqyUbskI0x30xiiPVuTCFbWG4zY
 TlAa1US3/Ql4a6BX5LWbAQeX1OmPn0Igj9BtkXrbnhKpyuVXUIfGXMKv6Q3AG6R+UxsBmO8
 tdXGBMVF6HyC1gC0d8Ds2G1DYf5wQk866VOCOsEOIBoLZxKwJCnK2h/F2HuUV3QeprZ7kQy
 cppIEb1q7Q77sr6mfT+xw==
UI-OutboundReport: notjunk:1;M01:P0:Sji/PFmoCL8=;3nsc+rFENDNS6qK4Tn2RZAuXEU9
 pOGdFcxxHPvj3RJWlxqTw0oMexcOw2MAAtefM1+cOZ21jXYJhYIPMiFYrUxkneo+J9bN1eQiD
 JcIRSXtDmJZdwnyXjMnNxIiJcn1JQllRVznVBsUsS1V3mMrma04APXNBV1urDt7BTecGfD+/Z
 z8jOiuGYNaEB2p3X9Eg0VdQ5vcWQqixaM5KQTXI+rK95MnL4ZEDlk4mf4ZrxmuBVLzlZN/8W5
 vqCPApoPiwFOCW4RYO0DqueGXCY76XWz8+ycNTzSVWrhIHCzSu2XMB02Mxx61QeWGKJ6j1uu5
 7D7bKGU9YItLYo1LRcy7rZQqgbDrqgagJsPBBDDsb2NiqUc5j0FUBjIqV9RQniE3Gv4lUBnXp
 4I6e9cQOuP30IYtBwoL58Pfq1peeEao/d+bH/yxF7FzRzwvyydAn+NB8zMb/jfcl3ud+AKhih
 Vza9YtdnStfhWqWb8laXoiLCciRGWxZNms7KrowvYU0122MjVDBYEda/uC44uUtdyb3+qxXrr
 1+t4tTbtVC6g3Zt4bbah5I+wwRNve9pwr5qbwGSSCi9fThdKMmtgNX//iQlIIGmCWlLD+UshU
 fpv0E3FF0eyTzcVUFjLoWrEZPlPguTm5pSTQxdWlZwfbFPDcKysnygtN/aemOQPFUIsE+PTTs
 sigOc9awkFrXUWDLbkHep+r4B7+PG4Y6KnLEiTU1amSEzN5OgFFTl7Ou7WHwv5bkVpDYLtaDR
 +tudZup912IDE0BsLEu8wr2jzsltD9ZvlvyvZpfQB+BJA5cLDCS1U3p0yNIgwXErEHLJl/LNs
 +/F18xWsFr7kaD683oB7XTtUTjYEHOekORwoXhkUPtdc4=
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

On 4/8/24 23:33, Jonathan Humphreys wrote:
> EFI signature list using TI dummy keys.

Adding vendor public keys into the code base to lock down generated
binaries to the vendors unpublished private key does not match well with
the intent of the GNU public license.

Best regards

Heinrich

>
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>   arch/arm/mach-k3/keys/custMpk.esl | Bin 0 -> 1523 bytes
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-k3/keys/custMpk.esl
>
> diff --git a/arch/arm/mach-k3/keys/custMpk.esl b/arch/arm/mach-k3/keys/c=
ustMpk.esl
> new file mode 100644
> index 0000000000000000000000000000000000000000..2feb704e0a5fd126410de451=
d3c0fa4d3edccc52
> GIT binary patch
> literal 1523
> zcmZ1&d0^?2Da*aux2_hA(f&~MnUw(yu0v@E4?-F=3Du^u*PVqVQ8QZ((-^A*$m*Kg7c
> z&78AJODc2mtxpELY@Awc9&O)w85y}*84Mcd8gd(OvN4CUun9AT2E#ZUJWL@GhWtR)
> zKpA!(HkZVloWx>7bput902hy3NNPo5v4Uq_aY<2WZfaf$h@G5YRFGekSdyAzC~P1I
> zQpnB26;PC)oLXF*UsMbeWai-t@l*&dEdVMmF_blshP#N9QH-w`BJNO<sh6CeYal1i
> zYh-L-W?*PwYGi0=3D7A4MWYz$;tLb-$9{Y^|t$U)A?%D~*j#Lr;R#Kgta#Kg$3Uu2!<
> zjryX?*~({Md+?>+QS$x7=3Dil`0?bc6sZ`Vxxl^6N{>i2E;SY*4-T$+0G;)5dxe+2CR
> z@4+)sDPWdQb@%6KTpDVdm)v}?GSpG(w_UV)&i+#e3fJowDZO)JR83lIcbw(hMu}}Y
> z2ZZwYAI-LVx@^G;HdkgxaX&Hnl_l3&{H|3l7uX@Vl5di{>fQQ{pDynFlySp2(z~g)
> z{LIBUzm&K9j_CMw_SIFfPdcT#zmg6g<ji}(R`6geJLk-#o7bK^&&fT}#2zsD`=3Dc9g
> zFUCK<Fz@{2kel&$W6zl<d|WNk#ZsNRd{_N_SJxWvh0*K$j!m)c@oT>{#b(Lp`M3Uj
> zGOKycyEe+n{G(Rmg}jB!)0ySk-!kkj_R7#OT+}pcG0VXh?f+ftRvnyw#hUea^Iyfn
> ze|zgKPKrqe@jYWU?v<50X(n^lZ*G%j$JyCh`*Px|H*K=3D2WXP)hx>jng+}Q}N^KoDN
> z8dh8T-~Dmrp2?yk3O6Gqbz7O@<TEz<^zIa7d#PKtHKHeAg?V0DMSin^o3F|IEfQWk
> zcmJwBy6&2hKub%G{j3IK(?7m@uI43#1e~wSZJ5sTtDjrp@7@{O3(faN{`Gp}x{$M5
> z{A7`c@pjfYq1Z=3DJvgZ^-zCC<(HFTBwYhTX$k`7IJX`SM!H}f`Mv+(Op6uVY(<(^o4
> zpyXAj9nF_c-1A<UIel9%6Eh<NBXSA>W=3DdcRVPvS;*B%(4`P|iK>Vg$XDgN9sr}Df{
> z7X0es=3DRPHr8RB+*)}q}h%gn?x9PO4y*Qog};x<<LS+lxk$@$kYlG_hXu6p%jvB<%l
> zmcsdI9w!^rFPt^&c~{1?L~DJ4TRPv>t%rn8xi;KBE9A!Dppb9yru|>RCb9PcXWpE>
> zKlQ}fzw*izXI|}|r!O*nb&cP9#VhHRn;B<SRflN2Jl(*;W4e0LD$ORRIdjjhURZH+
> zXWR0Vllb2@>`1LC^xvIctvLCYhRA_6yCS~2&!0SH1xwv(O~<l(HQxHJxzF!T_>+5t
> z^|E$S{MM^8j9J5`sQ6pud{2Lz?k`zncbjvHj%eutjusUol}8;%cbPLCO|e;ZJ^tXe
> z_N{pmM}uCi3UWO3=3DhMc<s}m1Jx4GS4F(<_N`R|o+)eAK3Yx{o$ygRe!;<_EoF&UhP
> zrslJ=3D2XA9^$j#UDYwo;ZvZwb!|L%YP%v|ie|7-1PP+q3DZ&vEWgHHrjHv|NzEVjO?
> zKFeRbXv>iTPl?N16Xv@buq_d@TU<MB;uD_jX^$J`&*C>`uX0_s&g9M2C6cKx4E;{?
> zt`1&)Tk-yb?sKMPI~!}xt*d*!tMat!r1`}jul#i@lDB8rnu>ba_-^4!iQ5{|tb3TX
> z>fTMIw2!Me3{Dw*WZotC<4@h<H`zaL+~Es<{Ccj5yS7zyNU!YsTG`^JqA6NkU%vnV
> D66<<J
>
> literal 0
> HcmV?d00001
>

