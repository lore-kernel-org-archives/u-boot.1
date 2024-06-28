Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73904C30658
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 12:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E2B188590;
	Fri, 28 Jun 2024 14:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mkcAQXcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554B1885A2; Fri, 28 Jun 2024 14:41:53 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3237587FEE
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 14:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SCfgD7087766;
 Fri, 28 Jun 2024 07:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719578502;
 bh=jvd1ivfSvysdSYt3hRxUm+0wqO2Mc+oatwsnP+B5BWg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mkcAQXcq3skKTq6lNsXVY6dN94f9ltSoOfwPo+do3DNKJL6d87oMGT41+psd5MCQ8
 eQd6iGAVUy9IPmzd7x/thpuWVxRMgAT9jjxcX/S2YtzZqhz/PHFB1i1FSW0uA3dqeG
 ejeKQx85A7UgcvdaC4nnAb875JxgJI4XlIFQ9LRk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SCfg6V106576
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 07:41:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 07:41:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 07:41:42 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SCfgqE099570;
 Fri, 28 Jun 2024 07:41:42 -0500
Date: Fri, 28 Jun 2024 07:41:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH V3 3/4] doc: beagle: am62x_beagleplay: Add TIFS Stub in
 image format
Message-ID: <20240628124142.lqnzhf5df3cc5mxy@malformed>
References: <20240628093252.1864609-1-d-gole@ti.com>
 <20240628093252.1864609-4-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240628093252.1864609-4-d-gole@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 15:02-20240628, Dhruva Gole wrote:
> Mention the TIFS Stub in the TISP image format
>=20
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  doc/board/beagle/am62x_beagleplay.rst      | 2 +-
>  doc/board/ti/img/tifsstub_dm_tispl.bin.svg | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>  create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg
>=20
> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am6=
2x_beagleplay.rst
> index be42e4d9c2ed..a70727adb621 100644
> --- a/doc/board/beagle/am62x_beagleplay.rst
> +++ b/doc/board/beagle/am62x_beagleplay.rst
> @@ -87,7 +87,7 @@ Image formats
> =20
>  - tispl.bin
> =20
> -.. image:: ../ti/img/dm_tispl.bin.svg
> +.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
>    :alt: tispl.bin image format
> =20
>  Additional hardware for U-Boot development
> diff --git a/doc/board/ti/img/tifsstub_dm_tispl.bin.svg b/doc/board/ti/im=
g/tifsstub_dm_tispl.bin.svg
> new file mode 100644
> index 000000000000..04e4f15da21f
> --- /dev/null
> +++ b/doc/board/ti/img/tifsstub_dm_tispl.bin.svg
> @@ -0,0 +1,4 @@
> +<?xml version=3D"1.0" encoding=3D"UTF-8"?>

License is missing among other formatting issues.
I usually pass it through inkscape to ensure the formatting issues are
cleared up.

> +<!-- Do not edit this file with editors other than draw.io -->
Drop this.

> +<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphi=
cs/SVG/1.1/DTD/svg11.dtd">
> +<svg xmlns=3D"http://www.w3.org/2000/svg" style=3D"background-color: rgb=
(255, 255, 255);" xmlns:xlink=3D"http://www.w3.org/1999/xlink" version=3D"1=
=2E1" width=3D"231px" height=3D"351px" viewBox=3D"-0.5 -0.5 231 351" conten=
t=3D"&lt;mxfile host=3D&quot;confluence.itg.ti.com&quot; modified=3D&quot;2=
024-06-28T06:00:12.998Z&quot; agent=3D&quot;Mozilla/5.0 (X11; Linux x86_64;=
 rv:109.0) Gecko/20100101 Firefox/118.0&quot; etag=3D&quot;tyHDTMUXFR0F8l2W=
lmTa&quot; version=3D&quot;22.0.8&quot; type=3D&quot;atlas&quot;&gt;&lt;dia=
gram id=3D&quot;prx1HvI4_W0GNTyXR3Yw&quot; name=3D&quot;Page-1&quot;&gt;1Zf=
vj5owGMf/GpLthReggOzlieCZ7TZ3mJjszaXSCs0KNbVOvb9+rRSF1W3eMnPhDbTf5+mP5/MtjV=
ogKvcTDtfFI0OYWq6N9hYYW67reMCTL6UcamXoDGsh5wTppLOQkhesRVurW4LwppMoGKOCrLtix=
qoKZ6KjQc7Zrpu2YrS76hrmekX7LKQZpNhIWxAkiloN/Vb2AyZ50azs2DpSwiZZC5sCIrZrSSC2=
QMQZE3Wr3EeYKngNl3pc8pvoaWMcV+KaAeGsmIJkST6uv0L/efE8fsm/DfQsPyDd6oL1ZsWhIcD=
ZtkJYTeJYYLQriMDpGmYqupOeS60QJdXhFaE0YpTx41iAfBwiT+obwdl33IqE7hIEgYyYZTR7wl=
zgfUvSZU0wK7HgB5mioyDQiPUZc5v+7uyYC7RWtNwCjY1Qn5L8NPcZpGxolq/g6hpck+lcCg8YI=
sz/wNh+HeOKVfj/QPTsXyB+MCE6wQWIwa0YAoPhfJqkUknFdmm5AZUbGC0lzCBXrXeTmeVGinE6=
UGm6mcbv+4Dbc6/EfbMj65m4k8G9wU7WJ7qAut82wiu4PVpzARykJK9kN5Pg5GcARgoYkbftvQ6=
UBCG10kVTurbdwITTffA3E8CtTPANE77MBvM47sMRBuGV9Lxb0QsMek8SqD1+lI9k0QeG3vCtGQ=
4NhhFT1airwE5nn/pA0XfemmJoUDyis8dzWa/t3N197gXHa+/Df+Aou+ffvsdY6x8EiH8C&lt;/=
diagram&gt;&lt;/mxfile&gt;"><defs/><g><rect x=3D"0" y=3D"0" width=3D"230" h=
eight=3D"350" rx=3D"34.5" ry=3D"34.5" fill=3D"#d5e8d4" stroke=3D"#82b366" p=
ointer-events=3D"all"/><rect x=3D"40" y=3D"30" width=3D"160" height=3D"60" =
fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=
=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible=
; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%"=
 requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div=
 xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items=
: unsafe center; justify-content: unsafe center; width: 158px; height: 1px;=
 padding-top: 60px; margin-left: 41px;"><div style=3D"box-sizing: border-bo=
x; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0,=
 0, 0); "><div style=3D"display: inline-block; font-size: 12px; font-family=
: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; wh=
ite-space: normal; overflow-wrap: normal;">FIT Header</div></div></div></fo=
reignObject><text x=3D"120" y=3D"64" fill=3D"rgb(0, 0, 0)" font-family=3D"H=
elvetica" font-size=3D"12px" text-anchor=3D"middle">FIT Header</text></swit=
ch></g><rect x=3D"40" y=3D"160" width=3D"160" height=3D"50" fill=3D"none" s=
troke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0=
=2E5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: =
left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatu=
res=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http=
://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe cente=
r; justify-content: unsafe center; width: 158px; height: 1px; padding-top: =
185px; margin-left: 41px;"><div style=3D"box-sizing: border-box; font-size:=
 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><di=
v style=3D"display: inline-block; font-size: 12px; font-family: Helvetica; =
color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: no=
rmal; overflow-wrap: normal;">TIFS Stub<br />(GP, HS-FS, HS-SE)</div></div>=
</div></foreignObject><text x=3D"120" y=3D"189" fill=3D"rgb(0, 0, 0)" font-=
family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">TIFS Stub...=
</text></switch></g><rect x=3D"40" y=3D"90" width=3D"160" height=3D"30" fil=
l=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"=
translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; te=
xt-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" req=
uiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xml=
ns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: un=
safe center; justify-content: unsafe center; width: 158px; height: 1px; pad=
ding-top: 105px; margin-left: 41px;"><div style=3D"box-sizing: border-box; =
font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0,=
 0); "><div style=3D"display: inline-block; font-size: 12px; font-family: H=
elvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white=
-space: normal; overflow-wrap: normal;">TF-A</div></div></div></foreignObje=
ct><text x=3D"120" y=3D"109" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica=
" font-size=3D"12px" text-anchor=3D"middle">TF-A</text></switch></g><rect x=
=3D"40" y=3D"120" width=3D"160" height=3D"40" fill=3D"none" stroke=3D"rgb(0=
, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><swi=
tch><foreignObject style=3D"overflow: visible; text-align: left;" pointer-e=
vents=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://ww=
w.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/19=
99/xhtml" style=3D"display: flex; align-items: unsafe center; justify-conte=
nt: unsafe center; width: 158px; height: 1px; padding-top: 140px; margin-le=
ft: 41px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-align=
: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"displ=
ay: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0,=
 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-w=
rap: normal;">OP-TEE</div></div></div></foreignObject><text x=3D"120" y=3D"=
144" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" tex=
t-anchor=3D"middle">OP-TEE</text></switch></g><rect x=3D"40" y=3D"210" widt=
h=3D"160" height=3D"40" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-event=
s=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject sty=
le=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 158px; height: 1px; padding-top: 230px; margin-left: 41px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-draw=
io-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fo=
nt-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.=
2; pointer-events: all; white-space: normal; overflow-wrap: normal;">R5 DM =
FW</div></div></div></foreignObject><text x=3D"120" y=3D"234" fill=3D"rgb(0=
, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle=
">R5 DM FW</text></switch></g><rect x=3D"40" y=3D"250" width=3D"160" height=
=3D"40" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g tr=
ansform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: =
visible; text-align: left;" pointer-events=3D"none" width=3D"100%" height=
=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibil=
ity"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; al=
ign-items: unsafe center; justify-content: unsafe center; width: 158px; hei=
ght: 1px; padding-top: 270px; margin-left: 41px;"><div style=3D"box-sizing:=
 border-box; font-size: 0px; text-align: center;" data-drawio-colors=3D"col=
or: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; f=
ont-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-event=
s: all; white-space: normal; overflow-wrap: normal;">Cortex-A SPL</div></di=
v></div></foreignObject><text x=3D"120" y=3D"274" fill=3D"rgb(0, 0, 0)" fon=
t-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Cortex-A S=
PL</text></switch></g><rect x=3D"40" y=3D"290" width=3D"160" height=3D"40" =
fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=
=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible=
; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%"=
 requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div=
 xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items=
: unsafe center; justify-content: unsafe center; width: 158px; height: 1px;=
 padding-top: 310px; margin-left: 41px;"><div style=3D"box-sizing: border-b=
ox; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0=
, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; font-famil=
y: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; w=
hite-space: normal; overflow-wrap: normal;">SPL DTB 1..N</div></div></div><=
/foreignObject><text x=3D"120" y=3D"314" fill=3D"rgb(0, 0, 0)" font-family=
=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">SPL DTB 1..N</text=
></switch></g></g><switch><g requiredFeatures=3D"http://www.w3.org/TR/SVG11=
/feature#Extensibility"/><a transform=3D"translate(0,-5)" xlink:href=3D"htt=
ps://www.drawio.com/doc/faq/svg-export-text-problems" target=3D"_blank"><te=
xt text-anchor=3D"middle" font-size=3D"10px" x=3D"50%" y=3D"100%">Text is n=
ot SVG - cannot display</text></a></switch></svg>
> \ No newline at end of file
> --=20
> 2.34.1
>=20

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D
