Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD6CC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 16:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684DA88493;
	Thu,  9 May 2024 18:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sbO8N27x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920B48847B; Thu,  9 May 2024 18:41:54 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1955188470
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 18:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449GfZOf039000;
 Thu, 9 May 2024 11:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715272895;
 bh=FFzqrQ2BdS7A1m58SN6zKIwpI077ih7lnzEshQ1iGXI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=sbO8N27x5pzz9pN0D7iFu7Rd4vVyCtQ5v7Fb4ey5qFm0tjReNAjkSb5aFybfPCNHZ
 kNAa5h9sBkpvPbHVikKwfOY9QCOsct06IeifjQ0DaoGqOhJP2trR+DxcMUIFBjyCls
 Cd9UzBGCAUqe19aRyoA5pJp8ycx6hLLQwTtU/JO4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449GfZOE063053
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 11:41:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 11:41:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 11:41:35 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449GfZvV116961;
 Thu, 9 May 2024 11:41:35 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH v4 14/19] doc: board: ti: am62x: document OSPI layout
Date: Thu, 9 May 2024 11:41:18 -0500
Message-ID: <20240509164123.1753050-15-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509164123.1753050-1-j-humphreys@ti.com>
References: <20240509164123.1753050-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Added OSPI flash layout diagram, as well as example commands to flash
firmware to it.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/am62x_sk.rst        |  24 +
 doc/board/ti/img/ospi_sysfw2.svg | 802 +++++++++++++++++++++++++++++++
 2 files changed, 826 insertions(+)
 create mode 100644 doc/board/ti/img/ospi_sysfw2.svg

diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b12dc85f06b..3655826a274 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -150,6 +150,30 @@ Image formats:
 .. image:: img/dm_tispl.bin.svg
   :alt: tispl.bin image format
 
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, and u-boot.img,
+over tftp and then flash those to OSPI at their respective addresses.
+
+.. prompt:: bash =>
+
+  sf probe
+  tftp ${loadaddr} tiboot3.bin
+  sf update $loadaddr 0x0 $filesize
+  tftp ${loadaddr} tispl.bin
+  sf update $loadaddr 0x80000 $filesize
+  tftp ${loadaddr} u-boot.img
+  sf update $loadaddr 0x280000 $filesize
+
+Flash layout for OSPI:
+
+.. image:: img/ospi_sysfw2.svg
+  :alt: OSPI flash partition layout
+
 A53 SPL DDR Memory Layout
 -------------------------
 
diff --git a/doc/board/ti/img/ospi_sysfw2.svg b/doc/board/ti/img/ospi_sysfw2.svg
new file mode 100644
index 00000000000..06711df4117
--- /dev/null
+++ b/doc/board/ti/img/ospi_sysfw2.svg
@@ -0,0 +1,802 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!--SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause-->
+
+<!--Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/-->
+
+<svg
+   version="1.1"
+   width="321px"
+   height="336px"
+   viewBox="-0.5 -0.5 321 336"
+   id="svg24863"
+   sodipodi:docname="ospi_sysfw2.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview24865"
+     pagecolor="#505050"
+     bordercolor="#eeeeee"
+     borderopacity="1"
+     inkscape:pageshadow="0"
+     inkscape:pageopacity="0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="2.5982143"
+     inkscape:cx="160.49485"
+     inkscape:cy="168"
+     inkscape:window-width="3370"
+     inkscape:window-height="1376"
+     inkscape:window-x="70"
+     inkscape:window-y="27"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g24861" />
+  <defs
+     id="defs24667" />
+  <g
+     id="g24861">
+    <g
+       id="g24671">
+      <rect
+         x="120"
+         y="15"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24669" />
+    </g>
+    <g
+       id="g24679">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24677">
+        <switch
+           id="switch24675">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 35px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tiboot3(512k)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="39"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24673">ospi.tiboot3(512k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24683">
+      <rect
+         x="60"
+         y="5"
+         width="60"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24681" />
+    </g>
+    <g
+       id="g24691">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24689">
+        <switch
+           id="switch24687">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 58px; height: 1px; padding-top: 20px; margin-left: 60px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x0</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="24"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24685">0x0</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24695">
+      <rect
+         x="120"
+         y="55"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24693" />
+    </g>
+    <g
+       id="g24703">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24701">
+        <switch
+           id="switch24699">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 75px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tispl(2M)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="79"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24697">ospi.tispl(2M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24707">
+      <rect
+         x="0"
+         y="45"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24705" />
+    </g>
+    <g
+       id="g24715">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24713">
+        <switch
+           id="switch24711">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 60px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x80000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="64"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24709">0x80000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24719">
+      <rect
+         x="120"
+         y="95"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24717" />
+    </g>
+    <g
+       id="g24727">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24725">
+        <switch
+           id="switch24723">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 115px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.u-boot(4M)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="119"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24721">ospi.u-boot(4M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24731">
+      <rect
+         x="0"
+         y="85"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24729" />
+    </g>
+    <g
+       id="g24739">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24737">
+        <switch
+           id="switch24735">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 100px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x280000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="104"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24733">0x280000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24743">
+      <rect
+         x="120"
+         y="135"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24741" />
+    </g>
+    <g
+       id="g24751">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24749">
+        <switch
+           id="switch24747">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 155px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env(128K)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="159"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24745">ospi.env(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24755">
+      <rect
+         x="0"
+         y="125"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24753" />
+    </g>
+    <g
+       id="g24763">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24761">
+        <switch
+           id="switch24759">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 140px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x680000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="144"
+             fill="#000000"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24757">0x680000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24767">
+      <rect
+         x="120"
+         y="175"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24765" />
+    </g>
+    <g
+       id="g24775">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24773">
+        <switch
+           id="switch24771">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 195px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env.backup(128K)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="199"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24769">ospi.env.backup(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24779">
+      <rect
+         x="0"
+         y="165"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24777" />
+    </g>
+    <g
+       id="g24787">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24785">
+        <switch
+           id="switch24783">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 180px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6C0000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="184"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24781">0x6C0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24791">
+      <rect
+         x="120"
+         y="215"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24789" />
+    </g>
+    <g
+       id="g24799">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24797">
+        <switch
+           id="switch24795">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 235px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">padding(768K)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="239"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24793">padding(768K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24803">
+      <rect
+         x="0"
+         y="205"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24801" />
+    </g>
+    <g
+       id="g24811">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24809">
+        <switch
+           id="switch24807">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 220px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x740000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="224"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24805">0x740000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24815">
+      <rect
+         x="120"
+         y="255"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24813" />
+    </g>
+    <g
+       id="g24823">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24821">
+        <switch
+           id="switch24819">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 275px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.rootfs(UBIFS)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="279"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24817">ospi.rootfs(UBIFS)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24827">
+      <rect
+         x="0"
+         y="245"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24825" />
+    </g>
+    <g
+       id="g24835">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24833">
+        <switch
+           id="switch24831">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 260px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x800000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="264"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24829">0x800000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24839">
+      <rect
+         x="120"
+         y="295"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect24837" />
+    </g>
+    <g
+       id="g24847">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24845">
+        <switch
+           id="switch24843">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 315px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.phypattern(256k)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="319"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text24841">ospi.phypattern(256k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g24851">
+      <rect
+         x="0"
+         y="285"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect24849" />
+    </g>
+    <g
+       id="g24859">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g24857">
+        <switch
+           id="switch24855">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 300px; margin-left: 0px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x3FC0000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="304"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text24853">0x3FC0000</text>
+        </switch>
+      </g>
+    </g>
+  </g>
+</svg>
-- 
2.34.1

