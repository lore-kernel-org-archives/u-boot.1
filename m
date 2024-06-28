Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D0DC2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 09:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396A0885A3;
	Fri, 28 Jun 2024 11:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LgNR8P1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499AE885A8; Fri, 28 Jun 2024 11:33:38 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB47885A2
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 11:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XWMi091417;
 Fri, 28 Jun 2024 04:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719567212;
 bh=3K4IBQtMDScIFhGrL7ZhO/8p93P0piKWAFu/A/dBO/o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LgNR8P1Tp0T+G53OFeIYOgmmU1/asY09E+KPctclWmRCU5hhTd1jT7RNy7hHCIDtN
 pCouazUTSLARYI6v93lizDdB1bc4no0kGaq+Cy4ecWeK9OMfLhCXKzg7oWZvZQ0RoA
 6fIDeKbTu6OMiXeKi0FeSf3uxuSfitlpBUZWPKGY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S9XWHb008280
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 04:33:32 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 04:33:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 04:33:32 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S9XFW9088895;
 Fri, 28 Jun 2024 04:33:29 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: [PATCH V3 2/4] doc: beagle: am62x_beagleplay: Update the boot flow to
 show TIFS Stub
Date: Fri, 28 Jun 2024 15:02:50 +0530
Message-ID: <20240628093252.1864609-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628093252.1864609-1-d-gole@ti.com>
References: <20240628093252.1864609-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Add the AM62x boot flow to show at which point the TIFS Stub actually
gets loaded.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst  | 2 +-
 doc/board/ti/img/boot_diagram_am62.svg | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x=
_beagleplay.rst
index 7784e62b0b71..be42e4d9c2ed 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -23,7 +23,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
=20
-.. image:: ../ti/img/boot_diagram_k3_current.svg
+.. image:: ../ti/img/boot_diagram_am62.svg
   :alt: Boot flow diagram
=20
 - On this platform, 'TI Foundational Security' (TIFS) functions as the
diff --git a/doc/board/ti/img/boot_diagram_am62.svg b/doc/board/ti/img/boot=
_diagram_am62.svg
new file mode 100644
index 000000000000..10b7eff6ce63
--- /dev/null
+++ b/doc/board/ti/img/boot_diagram_am62.svg
@@ -0,0 +1,4 @@
+<?xml version=3D"1.0" encoding=3D"UTF-8"?>
+<!-- Do not edit this file with editors other than draw.io -->
+<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics=
/SVG/1.1/DTD/svg11.dtd">
+<svg xmlns=3D"http://www.w3.org/2000/svg" style=3D"background-color: rgb(2=
55, 255, 255);" xmlns:xlink=3D"http://www.w3.org/1999/xlink" version=3D"1.1=
" width=3D"706px" height=3D"951px" viewBox=3D"-0.5 -0.5 706 951" content=3D=
"&lt;mxfile host=3D&quot;confluence.itg.ti.com&quot; modified=3D&quot;2024-=
06-28T08:45:50.931Z&quot; agent=3D&quot;Mozilla/5.0 (X11; Linux x86_64; rv:=
109.0) Gecko/20100101 Firefox/118.0&quot; etag=3D&quot;ufQvR89fuflntMrs8rcJ=
&quot; version=3D&quot;22.0.8&quot; type=3D&quot;atlas&quot;&gt;&lt;diagram=
 id=3D&quot;2E521vy4SbTbFAe6AtXR&quot; name=3D&quot;Page-1&quot;&gt;7V1bc+K=
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
nw/L8Lanf/Bw=3D=3D&lt;/diagram&gt;&lt;/mxfile&gt;"><defs/><g><rect x=3D"482=
" y=3D"581" width=3D"10" height=3D"70" fill=3D"rgb(255, 255, 255)" stroke=
=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><rect x=3D"235.5" y=3D"50" width=
=3D"144.75" height=3D"40" rx=3D"6" ry=3D"6" fill=3D"rgb(255, 255, 255)" str=
oke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><path d=3D"M 307.88 90 L 307.8=
8 940" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" strok=
e-dasharray=3D"3 3" pointer-events=3D"all"/><g transform=3D"translate(-0.5 =
-0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;=
" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=
=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://=
www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; =
justify-content: unsafe center; width: 143px; height: 1px; padding-top: 70p=
x; margin-left: 237px;"><div style=3D"box-sizing: border-box; font-size: 0p=
x; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div s=
tyle=3D"display: inline-block; font-size: 12px; font-family: Verdana; color=
: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal;=
 overflow-wrap: normal;">Cortex-R</div></div></div></foreignObject><text x=
=3D"308" y=3D"74" fill=3D"rgb(0, 0, 0)" font-family=3D"Verdana" font-size=
=3D"12px" text-anchor=3D"middle">Cortex-R</text></switch></g><rect x=3D"298=
.75" y=3D"160" width=3D"10" height=3D"130" fill=3D"rgb(255, 255, 255)" stro=
ke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><rect x=3D"301" y=3D"161" width=
=3D"71.5" height=3D"30" fill=3D"#ffe6cc" stroke=3D"#d79b00" pointer-events=
=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject styl=
e=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=3D=
"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/featu=
re#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"disp=
lay: flex; align-items: unsafe center; justify-content: unsafe center; widt=
h: 70px; height: 1px; padding-top: 176px; margin-left: 302px;"><div style=
=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-drawi=
o-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fon=
t-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2=
; pointer-events: all; white-space: normal; overflow-wrap: normal;">ROM</di=
v></div></div></foreignObject><text x=3D"337" y=3D"180" fill=3D"rgb(0, 0, 0=
)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">ROM<=
/text></switch></g><rect x=3D"299.75" y=3D"305" width=3D"10" height=3D"205"=
 fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"=
/><rect x=3D"302" y=3D"306" width=3D"105.5" height=3D"30" fill=3D"#d5e8d4" =
stroke=3D"#82b366" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -=
0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;"=
 pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D=
"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www=
.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; jus=
tify-content: unsafe center; width: 104px; height: 1px; padding-top: 321px;=
 margin-left: 303px;"><div style=3D"box-sizing: border-box; font-size: 0px;=
 text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div sty=
le=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color=
: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal;=
 overflow-wrap: normal;">Cortex-R SPL</div></div></div></foreignObject><tex=
t x=3D"355" y=3D"325" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-=
size=3D"12px" text-anchor=3D"middle">Cortex-R SPL</text></switch></g><rect =
x=3D"308.75" y=3D"190" width=3D"90" height=3D"40" rx=3D"6" ry=3D"6" fill=3D=
"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"tran=
slate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-a=
lign: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" require=
dFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=
=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsa=
fe center; justify-content: unsafe center; width: 88px; height: 1px; paddin=
g-top: 210px; margin-left: 310px;"><div style=3D"box-sizing: border-box; fo=
nt-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0=
); "><div style=3D"display: inline-block; font-size: 12px; font-family: Hel=
vetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-s=
pace: normal; overflow-wrap: normal;">Load and auth tiboot3.bin</div></div>=
</div></foreignObject><text x=3D"354" y=3D"214" fill=3D"rgb(0, 0, 0)" font-=
family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Load and aut=
h t...</text></switch></g><rect x=3D"309" y=3D"262" width=3D"90" height=3D"=
32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-eve=
nts=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject s=
tyle=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 88px; height: 1px; padding-top: 278px; margin-left: 310px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-draw=
io-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fo=
nt-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.=
2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load s=
ystem<br />config data</div></div></div></foreignObject><text x=3D"354" y=
=3D"282" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px"=
 text-anchor=3D"middle">Load system...</text></switch></g><rect x=3D"310" y=
=3D"336" width=3D"90" height=3D"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" str=
oke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5=
 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left=
;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=
=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://=
www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; =
justify-content: unsafe center; width: 88px; height: 1px; padding-top: 352p=
x; margin-left: 311px;"><div style=3D"box-sizing: border-box; font-size: 0p=
x; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div s=
tyle=3D"display: inline-block; font-size: 12px; font-family: Helvetica; col=
or: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: norma=
l; overflow-wrap: normal;">DDR Config</div></div></div></foreignObject><tex=
t x=3D"355" y=3D"356" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-=
size=3D"12px" text-anchor=3D"middle">DDR Config</text></switch></g><rect x=
=3D"310" y=3D"368" width=3D"90" height=3D"32" rx=3D"4.8" ry=3D"4.8" fill=3D=
"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"tran=
slate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-a=
lign: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" require=
dFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=
=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsa=
fe center; justify-content: unsafe center; width: 88px; height: 1px; paddin=
g-top: 384px; margin-left: 311px;"><div style=3D"box-sizing: border-box; fo=
nt-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0=
); "><div style=3D"display: inline-block; font-size: 12px; font-family: Hel=
vetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-s=
pace: normal; overflow-wrap: normal;">Load tispl.bin</div></div></div></for=
eignObject><text x=3D"355" y=3D"388" fill=3D"rgb(0, 0, 0)" font-family=3D"H=
elvetica" font-size=3D"12px" text-anchor=3D"middle">Load tispl.bin</text></=
switch></g><rect x=3D"310" y=3D"440" width=3D"90" height=3D"32" rx=3D"4.8" =
ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g=
 transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflo=
w: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" heigh=
t=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibi=
lity"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; a=
lign-items: unsafe center; justify-content: unsafe center; width: 88px; hei=
ght: 1px; padding-top: 456px; margin-left: 311px;"><div style=3D"box-sizing=
: border-box; font-size: 0px; text-align: center;" data-drawio-colors=3D"co=
lor: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; =
font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-even=
ts: all; white-space: normal; overflow-wrap: normal;">Start Cortex-A</div><=
/div></div></foreignObject><text x=3D"355" y=3D"460" fill=3D"rgb(0, 0, 0)" =
font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">Start C=
ortex-A</text></switch></g><rect x=3D"310" y=3D"472" width=3D"90" height=3D=
"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-ev=
ents=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject =
style=3D"overflow: visible; text-align: left;" pointer-events=3D"none" widt=
h=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/f=
eature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"=
display: flex; align-items: unsafe center; justify-content: unsafe center; =
width: 88px; height: 1px; padding-top: 488px; margin-left: 311px;"><div sty=
le=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-dra=
wio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; f=
ont-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1=
.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start=
 DM</div></div></div></foreignObject><text x=3D"355" y=3D"492" fill=3D"rgb(=
0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middl=
e">Start DM</text></switch></g><rect x=3D"300" y=3D"530" width=3D"10" heigh=
t=3D"410" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-event=
s=3D"all"/><path d=3D"M 347.5 565 L 347.5 570 L 347.5 573.63" fill=3D"none"=
 stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke"=
/><path d=3D"M 347.5 578.88 L 344 571.88 L 347.5 573.63 L 351 571.88 Z" fil=
l=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer=
-events=3D"all"/><rect x=3D"302" y=3D"535" width=3D"71.5" height=3D"30" fil=
l=3D"#e1d5e7" stroke=3D"#9673a6" pointer-events=3D"all"/><g transform=3D"tr=
anslate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text=
-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requi=
redFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=
=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsa=
fe center; justify-content: unsafe center; width: 70px; height: 1px; paddin=
g-top: 550px; margin-left: 303px;"><div style=3D"box-sizing: border-box; fo=
nt-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0=
); "><div style=3D"display: inline-block; font-size: 12px; font-family: Hel=
vetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-s=
pace: normal; overflow-wrap: normal;">Device Mgr</div></div></div></foreign=
Object><text x=3D"338" y=3D"554" fill=3D"rgb(0, 0, 0)" font-family=3D"Helve=
tica" font-size=3D"12px" text-anchor=3D"middle">Device Mgr</text></switch><=
/g><path d=3D"M 299 456 L 139.37 456" fill=3D"none" stroke=3D"rgb(0, 0, 0)"=
 stroke-miterlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 134.12 45=
6 L 141.12 452.5 L 139.37 456 L 141.12 459.5 Z" fill=3D"rgb(0, 0, 0)" strok=
e=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><g tran=
sform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: vi=
sible; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"=
100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"=
><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-=
items: unsafe center; justify-content: unsafe center; width: 1px; height: 1=
px; padding-top: 440px; margin-left: 257px;"><div style=3D"box-sizing: bord=
er-box; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: r=
gb(0, 0, 0); background-color: rgb(255, 255, 255); "><div style=3D"display:=
 inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0)=
; line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 25=
5); white-space: nowrap;">Start Cortex-A</div></div></div></foreignObject><=
text x=3D"257" y=3D"443" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" fo=
nt-size=3D"11px" text-anchor=3D"middle">Start Cort...</text></switch></g><p=
ath d=3D"M 481 711 L 139.37 711" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stro=
ke-miterlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 134.12 711 L 1=
41.12 707.5 L 139.37 711 L 141.12 714.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"=
rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M=
 482 692 L 317.37 691.04" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-mite=
rlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 312.12 691.01 L 319.1=
4 687.55 L 317.37 691.04 L 319.1 694.55 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"=
rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M=
 482 799 L 317.37 798.04" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-mite=
rlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 312.12 798.01 L 319.1=
4 794.55 L 317.37 798.04 L 319.1 801.55 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"=
rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M=
 481 791 L 139.37 791" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterli=
mit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 134.12 791 L 141.12 787.=
5 L 139.37 791 L 141.12 794.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, =
0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M 481 890 L=
 315.37 890.96" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"=
10" pointer-events=3D"stroke"/><path d=3D"M 310.12 890.99 L 317.1 887.45 L =
315.37 890.96 L 317.14 894.45 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, =
0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M 481 879 L=
 139.37 881.95" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"=
10" pointer-events=3D"stroke"/><path d=3D"M 134.12 881.99 L 141.09 878.43 L=
 139.37 881.95 L 141.15 885.43 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0,=
 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><rect x=3D"302" y=3D"=
580" width=3D"71.5" height=3D"30" fill=3D"#e1d5e7" stroke=3D"#9673a6" point=
er-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignOb=
ject style=3D"overflow: visible; text-align: left;" pointer-events=3D"none"=
 width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SV=
G11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" styl=
e=3D"display: flex; align-items: unsafe center; justify-content: unsafe cen=
ter; width: 70px; height: 1px; padding-top: 595px; margin-left: 303px;"><di=
v style=3D"box-sizing: border-box; font-size: 0px; text-align: center;" dat=
a-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-blo=
ck; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-heig=
ht: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">=
Load TIFS Stub in TCM</div></div></div></foreignObject><text x=3D"338" y=3D=
"599" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" te=
xt-anchor=3D"middle">Load TIFS St...</text></switch></g><path d=3D"M 482 64=
0 L 315.37 640" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"=
10" pointer-events=3D"stroke"/><path d=3D"M 310.12 640 L 317.12 636.5 L 315=
.37 640 L 317.12 643.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" str=
oke-miterlimit=3D"10" pointer-events=3D"all"/><rect x=3D"437" y=3D"50" widt=
h=3D"116.5" height=3D"40" rx=3D"6" ry=3D"6" fill=3D"rgb(255, 255, 255)" str=
oke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><path d=3D"M 495.25 90 L 495.2=
5 820" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" strok=
e-dasharray=3D"3 3" pointer-events=3D"all"/><g transform=3D"translate(-0.5 =
-0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;=
" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=
=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://=
www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; =
justify-content: unsafe center; width: 115px; height: 1px; padding-top: 70p=
x; margin-left: 438px;"><div style=3D"box-sizing: border-box; font-size: 0p=
x; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div s=
tyle=3D"display: inline-block; font-size: 12px; font-family: Verdana; color=
: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal;=
 overflow-wrap: normal;">Cortex-A</div></div></div></foreignObject><text x=
=3D"495" y=3D"74" fill=3D"rgb(0, 0, 0)" font-family=3D"Verdana" font-size=
=3D"12px" text-anchor=3D"middle">Cortex-A</text></switch></g><rect x=3D"482=
" y=3D"510" width=3D"10" height=3D"70" fill=3D"rgb(255, 255, 255)" stroke=
=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><path d=3D"M 482 565 L 139.37 565=
" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-ev=
ents=3D"stroke"/><path d=3D"M 134.12 565 L 141.12 561.5 L 139.37 565 L 141.=
12 568.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=
=3D"10" pointer-events=3D"all"/><path d=3D"M 482 614.97 L 140.37 614.67" fi=
ll=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=
=3D"stroke"/><path d=3D"M 135.12 614.66 L 142.12 611.17 L 140.37 614.67 L 1=
42.11 618.17 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterl=
imit=3D"10" pointer-events=3D"all"/><rect x=3D"482" y=3D"600" width=3D"71.5=
" height=3D"30" fill=3D"#d5e8d4" stroke=3D"#82b366" pointer-events=3D"all"/=
><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"over=
flow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" he=
ight=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex=
; align-items: unsafe center; justify-content: unsafe center; width: 70px; =
height: 1px; padding-top: 615px; margin-left: 483px;"><div style=3D"box-siz=
ing: border-box; font-size: 0px; text-align: center;" data-drawio-colors=3D=
"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size: 12p=
x; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-e=
vents: all; white-space: normal; overflow-wrap: normal;">OP-TEE</div></div>=
</div></foreignObject><text x=3D"518" y=3D"619" fill=3D"rgb(0, 0, 0)" font-=
family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">OP-TEE</text=
></switch></g><rect x=3D"577" y=3D"50" width=3D"116.5" height=3D"40" rx=3D"=
6" ry=3D"6" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-eve=
nts=3D"all"/><path d=3D"M 635.25 90 L 635.25 950" fill=3D"none" stroke=3D"r=
gb(0, 0, 0)" stroke-miterlimit=3D"10" stroke-dasharray=3D"3 3" pointer-even=
ts=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject st=
yle=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 115px; height: 1px; padding-top: 70px; margin-left: 578px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-draw=
io-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fo=
nt-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2;=
 pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R=
/M<br />C6x/C7x</div></div></div></foreignObject><text x=3D"635" y=3D"74" f=
ill=3D"rgb(0, 0, 0)" font-family=3D"Verdana" font-size=3D"12px" text-anchor=
=3D"middle">Cortex-R/M...</text></switch></g><rect x=3D"631" y=3D"910" widt=
h=3D"10" height=3D"38" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" =
pointer-events=3D"all"/><rect x=3D"633" y=3D"912" width=3D"71.5" height=3D"=
30" fill=3D"#e1d5e7" stroke=3D"#9673a6" pointer-events=3D"all"/><g transfor=
m=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visibl=
e; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%=
" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><di=
v xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-item=
s: unsafe center; justify-content: unsafe center; width: 70px; height: 1px;=
 padding-top: 927px; margin-left: 634px;"><div style=3D"box-sizing: border-=
box; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(=
0, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; font-fami=
ly: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; =
white-space: normal; overflow-wrap: normal;">Aux f/w</div></div></div></for=
eignObject><text x=3D"669" y=3D"931" fill=3D"rgb(0, 0, 0)" font-family=3D"H=
elvetica" font-size=3D"12px" text-anchor=3D"middle">Aux f/w</text></switch>=
</g><rect x=3D"77" y=3D"50" width=3D"100" height=3D"40" rx=3D"6" ry=3D"6" f=
ill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/>=
<path d=3D"M 127 90 L 127 940" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke=
-miterlimit=3D"10" stroke-dasharray=3D"3 3" pointer-events=3D"all"/><g tran=
sform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: vi=
sible; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"=
100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"=
><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-=
items: unsafe center; justify-content: unsafe center; width: 98px; height: =
1px; padding-top: 70px; margin-left: 78px;"><div style=3D"box-sizing: borde=
r-box; font-size: 0px; text-align: center;" data-drawio-colors=3D"color: rg=
b(0, 0, 0); "><div style=3D"display: inline-block; font-size: 12px; font-fa=
mily: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; =
white-space: normal; overflow-wrap: normal;">TIFS/DMSC</div></div></div></f=
oreignObject><text x=3D"127" y=3D"74" fill=3D"rgb(0, 0, 0)" font-family=3D"=
Verdana" font-size=3D"12px" text-anchor=3D"middle">TIFS/DMSC</text></switch=
></g><rect x=3D"122" y=3D"130" width=3D"10" height=3D"110" fill=3D"rgb(255,=
 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><rect x=3D"79" =
y=3D"132" width=3D"50" height=3D"30" fill=3D"#ffe6cc" stroke=3D"#d79b00" po=
inter-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreig=
nObject style=3D"overflow: visible; text-align: left;" pointer-events=3D"no=
ne" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR=
/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" s=
tyle=3D"display: flex; align-items: unsafe center; justify-content: unsafe =
center; width: 48px; height: 1px; padding-top: 147px; margin-left: 80px;"><=
div style=3D"box-sizing: border-box; font-size: 0px; text-align: center;" d=
ata-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-b=
lock; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-he=
ight: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;=
">ROM</div></div></div></foreignObject><text x=3D"104" y=3D"151" fill=3D"rg=
b(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"mid=
dle">ROM</text></switch></g><rect x=3D"122" y=3D"253" width=3D"10" height=
=3D"687" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-events=
=3D"all"/><path d=3D"M 297 238 L 138.37 238" fill=3D"none" stroke=3D"rgb(0,=
 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 13=
3.12 238 L 140.12 234.5 L 138.37 238 L 140.12 241.5 Z" fill=3D"rgb(0, 0, 0)=
" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/>=
<g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overf=
low: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" hei=
ght=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensi=
bility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex;=
 align-items: unsafe center; justify-content: unsafe center; width: 1px; he=
ight: 1px; padding-top: 230px; margin-left: 267px;"><div style=3D"box-sizin=
g: border-box; font-size: 0px; text-align: center;" data-drawio-colors=3D"c=
olor: rgb(0, 0, 0); background-color: rgb(255, 255, 255); "><div style=3D"d=
isplay: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0=
, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, =
255, 255); white-space: nowrap;">Start TIFS</div></div></div></foreignObjec=
t><text x=3D"267" y=3D"233" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica"=
 font-size=3D"11px" text-anchor=3D"middle">Start TIFS</text></switch></g><r=
ect x=3D"80" y=3D"255" width=3D"50" height=3D"30" fill=3D"#f8cecc" stroke=
=3D"#b85450" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)">=
<switch><foreignObject style=3D"overflow: visible; text-align: left;" point=
er-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http:=
//www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.or=
g/1999/xhtml" style=3D"display: flex; align-items: unsafe center; justify-c=
ontent: unsafe center; width: 48px; height: 1px; padding-top: 270px; margin=
-left: 81px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-al=
ign: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"di=
splay: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0,=
 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflo=
w-wrap: normal;">TIFS</div></div></div></foreignObject><text x=3D"105" y=3D=
"274" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" te=
xt-anchor=3D"middle">TIFS</text></switch></g><path d=3D"M 62 0 L 178 0 L 19=
2 14 L 192 35 L 62 35 L 62 0 Z" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0=
, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=3D"M 178 =
0 L 178 14 L 192 14" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimi=
t=3D"10" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><swi=
tch><foreignObject style=3D"overflow: visible; text-align: left;" pointer-e=
vents=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://ww=
w.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/19=
99/xhtml" style=3D"display: flex; align-items: unsafe flex-start; justify-c=
ontent: unsafe center; width: 128px; height: 1px; padding-top: 1px; margin-=
left: 63px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-ali=
gn: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"dis=
play: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0,=
 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-w=
rap: normal;">Security Enclave Boot=C2=A0Processor</div></div></div></forei=
gnObject><text x=3D"127" y=3D"13" fill=3D"rgb(0, 0, 0)" font-family=3D"Verd=
ana" font-size=3D"12px" text-anchor=3D"middle">Security Enclave Boot...</te=
xt></switch></g><path d=3D"M 241 0 L 361 0 L 375 14 L 375 35 L 241 35 L 241=
 0 Z" fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=
=3D"10" pointer-events=3D"all"/><path d=3D"M 361 0 L 361 14 L 375 14" fill=
=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=
=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject styl=
e=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=3D=
"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/featu=
re#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"disp=
lay: flex; align-items: unsafe flex-start; justify-content: unsafe center; =
width: 132px; height: 1px; padding-top: 1px; margin-left: 242px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-draw=
io-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fo=
nt-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2;=
 pointer-events: all; white-space: normal; overflow-wrap: normal;">Boot Loa=
der <br />Processor</div></div></div></foreignObject><text x=3D"308" y=3D"1=
3" fill=3D"rgb(0, 0, 0)" font-family=3D"Verdana" font-size=3D"12px" text-an=
chor=3D"middle">Boot Loader...</text></switch></g><path d=3D"M 437 0 L 523 =
0 L 537 14 L 537 35 L 437 35 L 437 0 Z" fill=3D"rgb(255, 255, 255)" stroke=
=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><path d=
=3D"M 523 0 L 523 14 L 537 14" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke=
-miterlimit=3D"10" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -=
0.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;"=
 pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D=
"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www=
.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe flex-start;=
 justify-content: unsafe center; width: 98px; height: 1px; padding-top: 1px=
; margin-left: 438px;"><div style=3D"box-sizing: border-box; font-size: 0px=
; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div st=
yle=3D"display: inline-block; font-size: 12px; font-family: Verdana; color:=
 rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; =
overflow-wrap: normal;">Main CPU</div></div></div></foreignObject><text x=
=3D"487" y=3D"13" fill=3D"rgb(0, 0, 0)" font-family=3D"Verdana" font-size=
=3D"12px" text-anchor=3D"middle">Main CPU</text></switch></g><path d=3D"M 5=
77 0 L 663 0 L 677 14 L 677 35 L 577 35 L 577 0 Z" fill=3D"rgb(255, 255, 25=
5)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"=
/><path d=3D"M 663 0 L 663 14 L 677 14" fill=3D"none" stroke=3D"rgb(0, 0, 0=
)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><g transform=3D"transla=
te(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible; text-alig=
n: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFe=
atures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"h=
ttp://www.w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe fl=
ex-start; justify-content: unsafe center; width: 98px; height: 1px; padding=
-top: 1px; margin-left: 578px;"><div style=3D"box-sizing: border-box; font-=
size: 0px; text-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); =
"><div style=3D"display: inline-block; font-size: 12px; font-family: Verdan=
a; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space:=
 normal; overflow-wrap: normal;">Auxiliary<br />Processor</div></div></div>=
</foreignObject><text x=3D"627" y=3D"13" fill=3D"rgb(0, 0, 0)" font-family=
=3D"Verdana" font-size=3D"12px" text-anchor=3D"middle">Auxiliary...</text><=
/switch></g><path d=3D"M 7 120 L 120.63 120" fill=3D"none" stroke=3D"rgb(0,=
 0, 0)" stroke-miterlimit=3D"10" stroke-dasharray=3D"12 12" pointer-events=
=3D"stroke"/><path d=3D"M 125.88 120 L 118.88 123.5 L 120.63 120 L 118.88 1=
16.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"=
10" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><=
foreignObject style=3D"overflow: visible; text-align: left;" pointer-events=
=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.=
org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xh=
tml" style=3D"display: flex; align-items: unsafe flex-end; justify-content:=
 unsafe flex-start; width: 1px; height: 1px; padding-top: 118px; margin-lef=
t: 9px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-align: =
left;" data-drawio-colors=3D"color: rgb(0, 0, 0); background-color: rgb(255=
, 255, 255); "><div style=3D"display: inline-block; font-size: 11px; font-f=
amily: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: al=
l; background-color: rgb(255, 255, 255); white-space: nowrap;">H/w Seq: Res=
et rls</div></div></div></foreignObject><text x=3D"9" y=3D"118" fill=3D"rgb=
(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"11px">H/w Seq: Reset rls<=
/text></switch></g><path d=3D"M 298 200 L 138.37 199.98" fill=3D"none" stro=
ke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke"/><pa=
th d=3D"M 133.12 199.98 L 140.12 196.48 L 138.37 199.98 L 140.12 203.48 Z" =
fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" poin=
ter-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignO=
bject style=3D"overflow: visible; text-align: left;" pointer-events=3D"none=
" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/S=
VG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" sty=
le=3D"display: flex; align-items: unsafe center; justify-content: unsafe ce=
nter; width: 1px; height: 1px; padding-top: 190px; margin-left: 257px;"><di=
v style=3D"box-sizing: border-box; font-size: 0px; text-align: center;" dat=
a-drawio-colors=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255=
); "><div style=3D"display: inline-block; font-size: 11px; font-family: Hel=
vetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; backgro=
und-color: rgb(255, 255, 255); white-space: nowrap;">Auth tiboot3.bin</div>=
</div></div></foreignObject><text x=3D"257" y=3D"193" fill=3D"rgb(0, 0, 0)"=
 font-family=3D"Helvetica" font-size=3D"11px" text-anchor=3D"middle">Auth t=
iboo...</text></switch></g><path d=3D"M 133 159 L 301.01 159" fill=3D"none"=
 stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke"=
/><path d=3D"M 306.26 159 L 299.26 162.5 L 301.01 159 L 299.26 155.5 Z" fil=
l=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer=
-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObje=
ct style=3D"overflow: visible; text-align: left;" pointer-events=3D"none" w=
idth=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG1=
1/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=
=3D"display: flex; align-items: unsafe center; justify-content: unsafe cent=
er; width: 1px; height: 1px; padding-top: 150px; margin-left: 178px;"><div =
style=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-=
drawio-colors=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);=
 "><div style=3D"display: inline-block; font-size: 11px; font-family: Helve=
tica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; backgroun=
d-color: rgb(255, 255, 255); white-space: nowrap;">Release Reset</div></div=
></div></foreignObject><text x=3D"178" y=3D"153" fill=3D"rgb(0, 0, 0)" font=
-family=3D"Helvetica" font-size=3D"11px" text-anchor=3D"middle">Release Re.=
..</text></switch></g><path d=3D"M 299 281.94 L 139.37 281.04" fill=3D"none=
" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke=
"/><path d=3D"M 134.12 281.01 L 141.14 277.55 L 139.37 281.04 L 141.1 284.5=
5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10"=
 pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><for=
eignObject style=3D"overflow: visible; text-align: left;" pointer-events=3D=
"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org=
/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml=
" style=3D"display: flex; align-items: unsafe center; justify-content: unsa=
fe center; width: 1px; height: 1px; padding-top: 270px; margin-left: 237px;=
"><div style=3D"box-sizing: border-box; font-size: 0px; text-align: center;=
" data-drawio-colors=3D"color: rgb(0, 0, 0); background-color: rgb(255, 255=
, 255); "><div style=3D"display: inline-block; font-size: 11px; font-family=
: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; ba=
ckground-color: rgb(255, 255, 255); white-space: nowrap;">Load system confi=
g data</div></div></div></foreignObject><text x=3D"237" y=3D"273" fill=3D"r=
gb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"11px" text-anchor=3D"mi=
ddle">Load syste...</text></switch></g><rect x=3D"308.75" y=3D"230" width=
=3D"90" height=3D"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, =
0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switc=
h><foreignObject style=3D"overflow: visible; text-align: left;" pointer-eve=
nts=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.=
w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/1999=
/xhtml" style=3D"display: flex; align-items: unsafe center; justify-content=
: unsafe center; width: 88px; height: 1px; padding-top: 246px; margin-left:=
 310px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-align: =
center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display=
: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0=
); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wra=
p: normal;">Start TIFS</div></div></div></foreignObject><text x=3D"354" y=
=3D"250" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px"=
 text-anchor=3D"middle">Start TIFS</text></switch></g><rect x=3D"310" y=3D"=
400" width=3D"90" height=3D"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=
=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0=
.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;" =
pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"=
http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.=
w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; just=
ify-content: unsafe center; width: 88px; height: 1px; padding-top: 416px; m=
argin-left: 311px;"><div style=3D"box-sizing: border-box; font-size: 0px; t=
ext-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=
=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color: =
rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; o=
verflow-wrap: normal;">Load DM f/w</div></div></div></foreignObject><text x=
=3D"355" y=3D"420" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-siz=
e=3D"12px" text-anchor=3D"middle">Load DM f/w</text></switch></g><path d=3D=
"M 303 510 L 333 510 L 333 530 L 309.12 530" fill=3D"none" stroke=3D"rgb(0,=
 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"stroke"/><path d=3D"M 30=
2.12 530 L 309.12 526.5 L 309.12 533.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"r=
gb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-events=3D"all"/><g transform=
=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"overflow: visible=
; text-align: left;" pointer-events=3D"none" width=3D"100%" height=3D"100%"=
 requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"><div=
 xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex; align-items=
: unsafe center; justify-content: unsafe flex-start; width: 1px; height: 1p=
x; padding-top: 521px; margin-left: 337px;"><div style=3D"box-sizing: borde=
r-box; font-size: 0px; text-align: left;" data-drawio-colors=3D"color: rgb(=
0, 0, 0); background-color: rgb(255, 255, 255); "><div style=3D"display: in=
line-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); l=
ine-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255);=
 white-space: nowrap;">branch</div></div></div></foreignObject><text x=3D"3=
37" y=3D"524" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"=
11px">branch</text></switch></g><path d=3D"M 133 511 L 137 511 L 476.63 511=
" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" pointer-ev=
ents=3D"stroke"/><path d=3D"M 481.88 511 L 474.88 514.5 L 476.63 511 L 474.=
88 507.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=
=3D"10" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><swit=
ch><foreignObject style=3D"overflow: visible; text-align: left;" pointer-ev=
ents=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://www=
.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/199=
9/xhtml" style=3D"display: flex; align-items: unsafe center; justify-conten=
t: unsafe center; width: 1px; height: 1px; padding-top: 500px; margin-left:=
 177px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-align: =
center;" data-drawio-colors=3D"color: rgb(0, 0, 0); background-color: rgb(2=
55, 255, 255); "><div style=3D"display: inline-block; font-size: 11px; font=
-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: =
all; background-color: rgb(255, 255, 255); white-space: nowrap;">Release Re=
set</div></div></div></foreignObject><text x=3D"177" y=3D"503" fill=3D"rgb(=
0, 0, 0)" font-family=3D"Helvetica" font-size=3D"11px" text-anchor=3D"middl=
e">Release Re...</text></switch></g><rect x=3D"484" y=3D"513" width=3D"71.5=
" height=3D"30" fill=3D"#d5e8d4" stroke=3D"#82b366" pointer-events=3D"all"/=
><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"over=
flow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" he=
ight=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Extens=
ibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: flex=
; align-items: unsafe center; justify-content: unsafe center; width: 70px; =
height: 1px; padding-top: 528px; margin-left: 485px;"><div style=3D"box-siz=
ing: border-box; font-size: 0px; text-align: center;" data-drawio-colors=3D=
"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size: 12p=
x; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-e=
vents: all; white-space: normal; overflow-wrap: normal;">TF-A=C2=A0</div></=
div></div></foreignObject><text x=3D"520" y=3D"532" fill=3D"rgb(0, 0, 0)" f=
ont-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">TF-A=C2=
=A0</text></switch></g><rect x=3D"482" y=3D"662" width=3D"10" height=3D"78"=
 fill=3D"rgb(255, 255, 255)" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"=
/><rect x=3D"484" y=3D"665" width=3D"83" height=3D"30" fill=3D"#d5e8d4" str=
oke=3D"#82b366" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5=
)"><switch><foreignObject style=3D"overflow: visible; text-align: left;" po=
inter-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"ht=
tp://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3=
.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; justif=
y-content: unsafe center; width: 81px; height: 1px; padding-top: 680px; mar=
gin-left: 485px;"><div style=3D"box-sizing: border-box; font-size: 0px; tex=
t-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=
=3D"display: inline-block; font-size: 12px; font-family: Helvetica; color: =
rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; o=
verflow-wrap: normal;">Cortex-A SPL</div></div></div></foreignObject><text =
x=3D"526" y=3D"684" fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-si=
ze=3D"12px" text-anchor=3D"middle">Cortex-A SPL</text></switch></g><rect x=
=3D"482" y=3D"748" width=3D"10" height=3D"192" fill=3D"rgb(255, 255, 255)" =
stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all"/><rect x=3D"484" y=3D"751" w=
idth=3D"83" height=3D"30" fill=3D"#d5e8d4" stroke=3D"#82b366" pointer-event=
s=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject sty=
le=3D"overflow: visible; text-align: left;" pointer-events=3D"none" width=
=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/fe=
ature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"d=
isplay: flex; align-items: unsafe center; justify-content: unsafe center; w=
idth: 81px; height: 1px; padding-top: 766px; margin-left: 485px;"><div styl=
e=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-draw=
io-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; fo=
nt-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.=
2; pointer-events: all; white-space: normal; overflow-wrap: normal;">U-Boot=
</div></div></div></foreignObject><text x=3D"526" y=3D"770" fill=3D"rgb(0, =
0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=3D"middle">=
U-Boot</text></switch></g><rect x=3D"492" y=3D"700" width=3D"103" height=3D=
"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-ev=
ents=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject =
style=3D"overflow: visible; text-align: left;" pointer-events=3D"none" widt=
h=3D"100%" height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/f=
eature#Extensibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"=
display: flex; align-items: unsafe center; justify-content: unsafe center; =
width: 101px; height: 1px; padding-top: 716px; margin-left: 493px;"><div st=
yle=3D"box-sizing: border-box; font-size: 0px; text-align: center;" data-dr=
awio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; =
font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: =
1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load=
 u-boot.img</div></div></div></foreignObject><text x=3D"544" y=3D"720" fill=
=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anchor=
=3D"middle">Load u-boot.img</text></switch></g><rect x=3D"492" y=3D"820" wi=
dth=3D"103" height=3D"32" rx=3D"4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb=
(0, 0, 0)" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0.5)"><s=
witch><foreignObject style=3D"overflow: visible; text-align: left;" pointer=
-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"http://=
www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.w3.org/=
1999/xhtml" style=3D"display: flex; align-items: unsafe center; justify-con=
tent: unsafe center; width: 101px; height: 1px; padding-top: 836px; margin-=
left: 493px;"><div style=3D"box-sizing: border-box; font-size: 0px; text-al=
ign: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); "><div style=3D"di=
splay: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0,=
 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflo=
w-wrap: normal;">Load Aux core f/w<br />(optional)</div></div></div></forei=
gnObject><text x=3D"544" y=3D"840" fill=3D"rgb(0, 0, 0)" font-family=3D"Hel=
vetica" font-size=3D"12px" text-anchor=3D"middle">Load Aux core f/w...</tex=
t></switch></g><rect x=3D"492" y=3D"860" width=3D"103" height=3D"32" rx=3D"=
4.8" ry=3D"4.8" fill=3D"none" stroke=3D"rgb(0, 0, 0)" pointer-events=3D"all=
"/><g transform=3D"translate(-0.5 -0.5)"><switch><foreignObject style=3D"ov=
erflow: visible; text-align: left;" pointer-events=3D"none" width=3D"100%" =
height=3D"100%" requiredFeatures=3D"http://www.w3.org/TR/SVG11/feature#Exte=
nsibility"><div xmlns=3D"http://www.w3.org/1999/xhtml" style=3D"display: fl=
ex; align-items: unsafe center; justify-content: unsafe center; width: 101p=
x; height: 1px; padding-top: 876px; margin-left: 493px;"><div style=3D"box-=
sizing: border-box; font-size: 0px; text-align: center;" data-drawio-colors=
=3D"color: rgb(0, 0, 0); "><div style=3D"display: inline-block; font-size: =
12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointe=
r-events: all; white-space: normal; overflow-wrap: normal;">Start Aux core<=
br />(optional)</div></div></div></foreignObject><text x=3D"544" y=3D"880" =
fill=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"12px" text-anc=
hor=3D"middle">Start Aux core...</text></switch></g><path d=3D"M 311 909 L =
628.38 909" fill=3D"none" stroke=3D"rgb(0, 0, 0)" stroke-miterlimit=3D"10" =
pointer-events=3D"stroke"/><path d=3D"M 633.63 909 L 626.63 912.5 L 628.38 =
909 L 626.63 905.5 Z" fill=3D"rgb(0, 0, 0)" stroke=3D"rgb(0, 0, 0)" stroke-=
miterlimit=3D"10" pointer-events=3D"all"/><g transform=3D"translate(-0.5 -0=
.5)"><switch><foreignObject style=3D"overflow: visible; text-align: left;" =
pointer-events=3D"none" width=3D"100%" height=3D"100%" requiredFeatures=3D"=
http://www.w3.org/TR/SVG11/feature#Extensibility"><div xmlns=3D"http://www.=
w3.org/1999/xhtml" style=3D"display: flex; align-items: unsafe center; just=
ify-content: unsafe center; width: 1px; height: 1px; padding-top: 900px; ma=
rgin-left: 357px;"><div style=3D"box-sizing: border-box; font-size: 0px; te=
xt-align: center;" data-drawio-colors=3D"color: rgb(0, 0, 0); background-co=
lor: rgb(255, 255, 255); "><div style=3D"display: inline-block; font-size: =
11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointe=
r-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">=
Release Reset</div></div></div></foreignObject><text x=3D"357" y=3D"903" fi=
ll=3D"rgb(0, 0, 0)" font-family=3D"Helvetica" font-size=3D"11px" text-ancho=
r=3D"middle">Release Re...</text></switch></g></g><switch><g requiredFeatur=
es=3D"http://www.w3.org/TR/SVG11/feature#Extensibility"/><a transform=3D"tr=
anslate(0,-5)" xlink:href=3D"https://www.drawio.com/doc/faq/svg-export-text=
-problems" target=3D"_blank"><text text-anchor=3D"middle" font-size=3D"10px=
" x=3D"50%" y=3D"100%">Text is not SVG - cannot display</text></a></switch>=
</svg>
\ No newline at end of file
--=20
2.34.1

