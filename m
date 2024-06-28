Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F0AC3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EFD885C5;
	Fri, 28 Jun 2024 11:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jgX4RzXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CB7885B6; Fri, 28 Jun 2024 11:33:47 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8888A87D40
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S9Xbos028160;
 Fri, 28 Jun 2024 04:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719567217;
 bh=E2V6dEcsPdbdLgC7pSDWU1vXcomYF0OYTb6VwwAO5Gc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jgX4RzXdk83ENos8m/1DwVOnaOcaKWdgxuWCY0uudki+NVm5ymr0Db8JQIh61ahx/
 MsPdYz0yj6icdA9/ylNg5TiNQkCeONX4zgzf02eKYgx3K9MMlIt2vUPcmTuEwGhSZ+
 lF89iqyf6Ebb1fLUzM5VIPErHA8c4v54mepmnKoQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S9XbWQ008297
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 04:33:37 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 04:33:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 04:33:37 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XFWA088895;
 Fri, 28 Jun 2024 04:33:34 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH V3 3/4] doc: beagle: am62x_beagleplay: Add TIFS Stub in image
 format
Date: Fri, 28 Jun 2024 15:02:51 +0530
Message-ID: <20240628093252.1864609-4-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628093252.1864609-1-d-gole@ti.com>
References: <20240628093252.1864609-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
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

Mention the TIFS Stub in the TISP image format

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst      | 2 +-
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x=
_beagleplay.rst
index be42e4d9c2ed..a70727adb621 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -87,7 +87,7 @@ Image formats
=20
 - tispl.bin
=20
-.. image:: ../ti/img/dm_tispl.bin.svg
+.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
=20
 Additional hardware for U-Boot development
diff --git a/doc/board/ti/img/tifsstub_dm_tispl.bin.svg b/doc/board/ti/img/=
tifsstub_dm_tispl.bin.svg
new file mode 100644
index 000000000000..04e4f15da21f
--- /dev/null
+++ b/doc/board/ti/img/tifsstub_dm_tispl.bin.svg
@@ -0,0 +1,4 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8"?>
+<!-- Do not edit this file with editors other than draw.io -->
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics=
/SVG/1.1/DTD/svg11.dtd">
+<svg xmlns=3D"http://www.w3.org/2000/svg" style=3D"background-color: rgb(2=
55, 255, 255);" xmlns:xlink=3D"http://www.w3.org/1999/xlink" version=3D"1.1=
" width=3D"231px" height=3D"351px" viewBox=3D"-0.5 -0.5 231 351" content=3D=
"&lt;mxfile host=3D&quot;confluence.itg.ti.com&quot; modified=3D&quot;2024-=
06-28T06:00:12.998Z&quot; agent=3D&quot;Mozilla/5.0 (X11; Linux x86_64; rv:=
109.0) Gecko/20100101 Firefox/118.0&quot; etag=3D&quot;tyHDTMUXFR0F8l2WlmTa=
&quot; version=3D&quot;22.0.8&quot; type=3D&quot;atlas&quot;&gt;&lt;diagram=
 id=3D&quot;prx1HvI4_W0GNTyXR3Yw&quot; name=3D&quot;Page-1&quot;&gt;1Zfvj5o=
wGMf/GpLthReggOzlieCZ7TZ3mJjszaXSCs0KNbVOvb9+rRSF1W3eMnPhDbTf5+mP5/MtjVogKv=
cTDtfFI0OYWq6N9hYYW67reMCTL6UcamXoDGsh5wTppLOQkhesRVurW4LwppMoGKOCrLtixqoKZ=
6KjQc7Zrpu2YrS76hrmekX7LKQZpNhIWxAkiloN/Vb2AyZ50azs2DpSwiZZC5sCIrZrSSC2QMQZ=
E3Wr3EeYKngNl3pc8pvoaWMcV+KaAeGsmIJkST6uv0L/efE8fsm/DfQsPyDd6oL1ZsWhIcDZtkJ=
YTeJYYLQriMDpGmYqupOeS60QJdXhFaE0YpTx41iAfBwiT+obwdl33IqE7hIEgYyYZTR7wlzgfU=
vSZU0wK7HgB5mioyDQiPUZc5v+7uyYC7RWtNwCjY1Qn5L8NPcZpGxolq/g6hpck+lcCg8YIsz/w=
Nh+HeOKVfj/QPTsXyB+MCE6wQWIwa0YAoPhfJqkUknFdmm5AZUbGC0lzCBXrXeTmeVGinE6UGm6=
mcbv+4Dbc6/EfbMj65m4k8G9wU7WJ7qAut82wiu4PVpzARykJK9kN5Pg5GcARgoYkbftvQ6UBCG=
10kVTurbdwITTffA3E8CtTPANE77MBvM47sMRBuGV9Lxb0QsMek8SqD1+lI9k0QeG3vCtGQ4Nhh=
FT1airwE5nn/pA0XfemmJoUDyis8dzWa/t3N197gXHa+/Df+Aou+ffvsdY6x8EiH8C&lt;/diag=
ram&gt;&lt;/mxfile&gt;"><defs/><g><rect x=3D"0" y=3D"0" width=3D"230" heigh=
t=3D"350" rx=3D"34.5" ry=3D"34.5" fill=3D"#d5e8d4" stroke=3D"#82b366" point=
er-events=3D"all"/><rect x=3D"40" y=3D"30" width=3D"160" height=3D"60" fill=
=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"t=
ranslate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; tex=
t-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requ=
iredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmln=
s=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: uns=
afe center; justify-content: unsafe center; width: 158px; height: 1px; padd=
ing-top: 60px; margin-left: 41px;"><div style=3D"box-sizing: border-box; fo=
nt-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0=
); "><div style=3D"display: inline-block; font-size: 12px; font-family: Hel=
vetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-s=
pace: normal; overflow-wrap: normal;">FIT Header</div></div></div></foreign=
Object><text x=3D"120" y=3D"64" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvet=
ica" font-size=3D"12px" text-anchor=3D"middle">FIT Header</text></switch></=
g><rect x=3D"40" y=3D"160" width=3D"160" height=3D"50" fill=3D"none" stroke=
=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0=
.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;" =
pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"=
http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.=
w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; just=
ify-content: unsafe center; width: 158px; height: 1px; padding-top: 185px; =
margin-left: 41px;"><div style=3D"box-sizing: border-box; font-size: 0px; t=
ext-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=
=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color: =
rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; o=
verflow-wrap: normal;">TIFS Stub<br />(GP, HS-FS, HS-SE)</div></div></div><=
/foreignObject><text x=3D"120" y=3D"189" fill=3D"rgb(0, 0, 0)" font-family=
=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">TIFS Stub...</text=
></switch></g><rect x=3D"40" y=3D"90" width=3D"160" height=3D"30" fill=3D"n=
one" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"transl=
ate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-ali=
gn: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredF=
eatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"=
http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe c=
enter; justify-content: unsafe center; width: 158px; height: 1px; padding-t=
op: 105px; margin-left: 41px;"><div style=3D"box-sizing: border-box; font-s=
ize: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "=
><div style=3D"display: inline-block; font-size: 12px; font-family: Helveti=
ca; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space=
: normal; overflow-wrap: normal;">TF-A</div></div></div></foreignObject><te=
xt x=3D"120" y=3D"109" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font=
-size=3D"12px" text-anchor=3D"middle">TF-A</text></switch></g><rect x=3D"40=
" y=3D"120" width=3D"160" height=3D"40" fill=3D"none" stroke=3D"rgb(0, 0, 0=
)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><f=
oreignObject style=3D"overflow: visible; text-align: left;" pointer-events=
=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.=
org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xh=
tml" style=3D"display: flex; align-items: unsafe center; justify-content: u=
nsafe center; width: 158px; height: 1px; padding-top: 140px; margin-left: 4=
1px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-align: cen=
ter;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: i=
nline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); =
line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: =
normal;">OP-TEE</div></div></div></foreignObject><text x=3D"120" y=3D"144" =
fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anc=
hor=3D"middle">OP-TEE</text></switch></g><rect x=3D"40" y=3D"210" width=3D"=
160" height=3D"40" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"=
all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D=
"overflow: visible; text-align: left;" pointer-events=3D"none" width=3D"100=
%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#E=
xtensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display:=
 flex; align-items: unsafe center; justify-content: unsafe center; width: 1=
58px; height: 1px; padding-top: 230px; margin-left: 41px;"><div style=3D"bo=
x-sizing: border-box; font-size: 0px; text-align: center;" data-drawio-colo=
rs=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size=
: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; poin=
ter-events: all; white-space: normal; overflow-wrap: normal;">R5 DM FW</div=
></div></div></foreignObject><text x=3D"120" y=3D"234" fill=3D"rgb(0, 0, 0)=
" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">R5 DM=
 FW</text></switch></g><rect x=3D"40" y=3D"250" width=3D"160" height=3D"40"=
 fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=
=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible=
; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%"=
 requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div=
 xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items=
: unsafe center; justify-content: unsafe center; width: 158px; height: 1px;=
 padding-top: 270px; margin-left: 41px;"><div style=3D"box-sizing: border-b=
ox; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0=
, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; font-famil=
y: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; w=
hite-space: normal; overflow-wrap: normal;">Cortex-A SPL</div></div></div><=
/foreignObject><text x=3D"120" y=3D"274" fill=3D"rgb(0, 0, 0)" font-family=
=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Cortex-A SPL</text=
></switch></g><rect x=3D"40" y=3D"290" width=3D"160" height=3D"40" fill=3D"=
none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"trans=
late(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-al=
ign: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" required=
Features=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D=
"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe =
center; justify-content: unsafe center; width: 158px; height: 1px; padding-=
top: 310px; margin-left: 41px;"><div style=3D"box-sizing: border-box; font-=
size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); =
"><div style=3D"display: inline-block; font-size: 12px; font-family: Helvet=
ica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-spac=
e: normal; overflow-wrap: normal;">SPL DTB 1..N</div></div></div></foreignO=
bject><text x=3D"120" y=3D"314" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvet=
ica" font-size=3D"12px" text-anchor=3D"middle">SPL DTB 1..N</text></switch>=
</g></g><switch><g requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#E=
xtensibility"/><a transform=3D"translate(0,-5)" xlink:href=3D"https://www.d=
rawio.com/doc/faq/svg-export-text-problems" target=3D"_blank"><text text-an=
chor=3D"middle" font-size=3D"10px" x=3D"50%" y=3D"100%">Text is not SVG - c=
annot display</text></a></switch></svg>
\ No newline at end of file
--=20
2.34.1

