Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD31C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 22:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEA888866;
	Sat,  1 Jun 2024 00:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JbStMHgr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D75788842; Sat,  1 Jun 2024 00:21:56 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A3788836
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 00:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLYjc017875;
 Fri, 31 May 2024 17:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717194094;
 bh=dC3ug1f9QVHP5/uLuJOmvvTf0Nxe/opFuSF0lJd29XI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=JbStMHgrUkiLaPS4kf1wc9HxVM51uW62czMLSe0CcYbYB+Gy45qUUfw57KX7F7cFT
 P40YXE6WN46PFPUJ6Y0Y1z+4NZGosDPKG2FTvCDgQa6Ww7C3NwlfBJNWg2Q1VFdhag
 h8emafBWd5K9M6kLbpgAXtY37Zs+BEvDuA/dBqiI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44VMLYuT005574
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 May 2024 17:21:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 17:21:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 17:21:33 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44VMLX4l006250;
 Fri, 31 May 2024 17:21:33 -0500
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
Subject: [PATCH v5 08/23] doc: board: ti: j721e: document OSPI layout
Date: Fri, 31 May 2024 17:21:03 -0500
Message-ID: <20240531222118.2618041-9-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531222118.2618041-1-j-humphreys@ti.com>
References: <20240531222118.2618041-1-j-humphreys@ti.com>
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

Updated OSPI flash layout diagram.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/img/ospi_sysfw.svg | 1464 +++++++++++++++++--------------
 doc/board/ti/j721e_evm.rst      |   58 +-
 2 files changed, 847 insertions(+), 675 deletions(-)

diff --git a/doc/board/ti/img/ospi_sysfw.svg b/doc/board/ti/img/ospi_sysfw.svg
index 648f6fd03e5..2a2fd3f4863 100644
--- a/doc/board/ti/img/ospi_sysfw.svg
+++ b/doc/board/ti/img/ospi_sysfw.svg
@@ -1,725 +1,897 @@
 <?xml version="1.0" encoding="UTF-8" standalone="no"?>
 <!--SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause-->
 
-<!--Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/-->
+<!--Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/-->
 
 <svg
    version="1.1"
    width="321px"
-   height="336px"
-   viewBox="-0.5 -0.5 321 336"
-   id="svg142"
+   height="376px"
+   viewBox="-0.5 -0.5 321 376"
+   id="svg19243"
    sodipodi:docname="ospi_sysfw.svg"
    inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
    xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
    xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
-   xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns="http://www.w3.org/2000/svg"
    xmlns:svg="http://www.w3.org/2000/svg"
    xmlns:xhtml="http://www.w3.org/1999/xhtml">
   <sodipodi:namedview
-     id="namedview144"
-     pagecolor="#ffffff"
-     bordercolor="#666666"
-     borderopacity="1.0"
-     inkscape:pageshadow="2"
-     inkscape:pageopacity="0.0"
+     id="namedview19245"
+     pagecolor="#505050"
+     bordercolor="#eeeeee"
+     borderopacity="1"
+     inkscape:pageshadow="0"
+     inkscape:pageopacity="0"
      inkscape:pagecheckerboard="0"
      showgrid="false"
-     inkscape:zoom="2.0297619"
-     inkscape:cx="156.66862"
-     inkscape:cy="168"
-     inkscape:window-width="3440"
-     inkscape:window-height="1416"
-     inkscape:window-x="0"
-     inkscape:window-y="0"
+     inkscape:zoom="2.3218085"
+     inkscape:cx="160.65063"
+     inkscape:cy="188"
+     inkscape:window-width="3370"
+     inkscape:window-height="1376"
+     inkscape:window-x="70"
+     inkscape:window-y="27"
      inkscape:window-maximized="1"
-     inkscape:current-layer="svg142" />
+     inkscape:current-layer="g19241" />
   <defs
-     id="defs2" />
+     id="defs19023" />
   <g
-     id="g132">
-    <rect
-       x="120"
-       y="15"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect4" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g10">
-      <switch
-         id="switch8">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 35px; margin-left: 121px;">
+     id="g19241">
+    <g
+       id="g19027">
+      <rect
+         x="120"
+         y="15"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19025" />
+    </g>
+    <g
+       id="g19035">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19033">
+        <switch
+           id="switch19031">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 35px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tiboot3(512k)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tiboot3(512k)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="39"
-           fill="#000000"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text6">ospi.tiboot3(512k)</text>
-      </switch>
-    </g>
-    <rect
-       x="60"
-       y="5"
-       width="60"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect12" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g18">
-      <switch
-         id="switch16">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 58px; height: 1px; padding-top: 20px; margin-left: 60px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="39"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19029">ospi.tiboot3(512k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19039">
+      <rect
+         x="60"
+         y="5"
+         width="60"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19037" />
+    </g>
+    <g
+       id="g19047">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19045">
+        <switch
+           id="switch19043">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 58px; height: 1px; padding-top: 20px; margin-left: 60px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x0</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x0</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="24"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text14">0x0</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="55"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect20" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g26">
-      <switch
-         id="switch24">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 75px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="24"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19041">0x0</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19051">
+      <rect
+         x="120"
+         y="55"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19049" />
+    </g>
+    <g
+       id="g19059">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19057">
+        <switch
+           id="switch19055">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 75px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tispl(2M)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tispl(2M)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="79"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text22">ospi.tispl(2M)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="45"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect28" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g34">
-      <switch
-         id="switch32">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 60px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="79"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19053">ospi.tispl(2M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19063">
+      <rect
+         x="0"
+         y="45"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19061" />
+    </g>
+    <g
+       id="g19071">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19069">
+        <switch
+           id="switch19067">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 60px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x80000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x80000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="64"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text30">0x80000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="95"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect36" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g42">
-      <switch
-         id="switch40">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 115px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="64"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19065">0x80000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19075">
+      <rect
+         x="120"
+         y="95"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19073" />
+    </g>
+    <g
+       id="g19083">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19081">
+        <switch
+           id="switch19079">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 115px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.u-boot(4M)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.u-boot(4M)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="119"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text38">ospi.u-boot(4M)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="85"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect44" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g50">
-      <switch
-         id="switch48">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 100px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="119"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19077">ospi.u-boot(4M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19087">
+      <rect
+         x="0"
+         y="85"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19085" />
+    </g>
+    <g
+       id="g19095">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19093">
+        <switch
+           id="switch19091">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 100px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x280000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x280000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="104"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text46">0x280000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="135"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect52" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g58">
-      <switch
-         id="switch56">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 155px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="104"
+             fill="#000000"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19089">0x280000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19099">
+      <rect
+         x="120"
+         y="135"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19097" />
+    </g>
+    <g
+       id="g19107">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19105">
+        <switch
+           id="switch19103">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 155px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env(128K)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env(128K)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="159"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text54">ospi.env(128K)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="125"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect60" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g66">
-      <switch
-         id="switch64">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 140px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="159"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19101">ospi.env(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19111">
+      <rect
+         x="0"
+         y="125"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19109" />
+    </g>
+    <g
+       id="g19119">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19117">
+        <switch
+           id="switch19115">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 140px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x680000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x680000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="144"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text62">0x680000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="175"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect68" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g74">
-      <switch
-         id="switch72">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 195px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="144"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19113">0x680000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19123">
+      <rect
+         x="120"
+         y="175"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19121" />
+    </g>
+    <g
+       id="g19131">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19129">
+        <switch
+           id="switch19127">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 195px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env.backup(128K)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.env.backup(128K)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="199"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text70">ospi.env.backup(128K)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="165"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect76" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g82">
-      <switch
-         id="switch80">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 180px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="199"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19125">ospi.env.backup(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19135">
+      <rect
+         x="0"
+         y="165"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19133" />
+    </g>
+    <g
+       id="g19143">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19141">
+        <switch
+           id="switch19139">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 180px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6A0000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6A0000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="184"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text78">0x6A0000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="215"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect84" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g90">
-      <switch
-         id="switch88">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 235px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="184"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19137">0x6A0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19147">
+      <rect
+         x="120"
+         y="215"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19145" />
+    </g>
+    <g
+       id="g19155">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19153">
+        <switch
+           id="switch19151">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 235px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.sysfw(1M)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.sysfw(1M)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="239"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text86">ospi.sysfw(1M)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="205"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect92" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g98">
-      <switch
-         id="switch96">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 220px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="239"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19149">ospi.sysfw(1M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19159">
+      <rect
+         x="0"
+         y="205"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19157" />
+    </g>
+    <g
+       id="g19167">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19165">
+        <switch
+           id="switch19163">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 220px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6C0000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6C0000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="224"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text94">0x6C0000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="255"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect100" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g106">
-      <switch
-         id="switch104">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 275px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="224"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19161">0x6C0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19171">
+      <rect
+         x="120"
+         y="255"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19169" />
+    </g>
+    <g
+       id="g19179">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19177">
+        <switch
+           id="switch19175">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 275px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">padding(256K)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">padding(256K)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="279"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text102">padding(256K)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="245"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect108" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g114">
-      <switch
-         id="switch112">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 260px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="279"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19173">padding(256K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19183">
+      <rect
+         x="0"
+         y="245"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19181" />
+    </g>
+    <g
+       id="g19191">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19189">
+        <switch
+           id="switch19187">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 260px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x7C0000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x7C0000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="264"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text110">0x7C0000</text>
-      </switch>
-    </g>
-    <rect
-       x="120"
-       y="295"
-       width="200"
-       height="40"
-       fill="rgb(255, 255, 255)"
-       stroke="rgb(0, 0, 0)"
-       pointer-events="all"
-       id="rect116" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g122">
-      <switch
-         id="switch120">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 315px; margin-left: 121px;">
+          </foreignObject>
+          <text
+             x="118"
+             y="264"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19185">0x7C0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19195">
+      <rect
+         x="120"
+         y="295"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19193" />
+    </g>
+    <g
+       id="g19203">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19201">
+        <switch
+           id="switch19199">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 315px; margin-left: 121px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.rootfs(UBIFS)</xhtml:div>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.rootfs(UBIFS)</xhtml:div>
+              </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="220"
-           y="319"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="middle"
-           id="text118">ospi.rootfs(UBIFS)</text>
-      </switch>
-    </g>
-    <rect
-       x="0"
-       y="285"
-       width="120"
-       height="30"
-       fill="none"
-       stroke="none"
-       pointer-events="all"
-       id="rect124" />
-    <g
-       transform="translate(-0.5 -0.5)"
-       id="g130">
-      <switch
-         id="switch128">
-        <foreignObject
-           pointer-events="none"
-           width="100%"
-           height="100%"
-           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-           style="overflow: visible; text-align: left;">
-          <xhtml:div
-             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 300px; margin-left: 0px;">
+          </foreignObject>
+          <text
+             x="220"
+             y="319"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19197">ospi.rootfs(UBIFS)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19207">
+      <rect
+         x="0"
+         y="285"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19205" />
+    </g>
+    <g
+       id="g19215">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19213">
+        <switch
+           id="switch19211">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x800000</xhtml:pre>
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
+             id="text19209">0x800000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19219">
+      <rect
+         x="120"
+         y="335"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect19217" />
+    </g>
+    <g
+       id="g19227">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19225">
+        <switch
+           id="switch19223">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
+            <xhtml:div
+               style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 198px; height: 1px; padding-top: 355px; margin-left: 121px;">
+              <xhtml:div
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: center;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.phypattern(128k)</xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="220"
+             y="359"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="middle"
+             id="text19221">ospi.phypattern(128k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g19231">
+      <rect
+         x="0"
+         y="325"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect19229" />
+    </g>
+    <g
+       id="g19239">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19237">
+        <switch
+           id="switch19235">
+          <foreignObject
+             pointer-events="none"
+             width="100%"
+             height="100%"
+             requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+             style="overflow: visible; text-align: left;">
             <xhtml:div
-               data-drawio-colors="color: rgb(0, 0, 0); "
-               style="box-sizing: border-box; font-size: 0px; text-align: right;">
+               style="display: flex; align-items: unsafe center; justify-content: unsafe flex-end; width: 118px; height: 1px; padding-top: 340px; margin-left: 0px;">
               <xhtml:div
-                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
-                <xhtml:pre
-                   style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x800000</xhtml:pre>
+                 data-drawio-colors="color: rgb(0, 0, 0); "
+                 style="box-sizing: border-box; font-size: 0px; text-align: right;">
+                <xhtml:div
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">
+                  <xhtml:pre
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x3FE0000</xhtml:pre>
+                </xhtml:div>
               </xhtml:div>
             </xhtml:div>
-          </xhtml:div>
-        </foreignObject>
-        <text
-           x="118"
-           y="304"
-           fill="rgb(0, 0, 0)"
-           font-family="Helvetica"
-           font-size="12px"
-           text-anchor="end"
-           id="text126">0x800000</text>
-      </switch>
+          </foreignObject>
+          <text
+             x="118"
+             y="344"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text19233">0x3FE0000</text>
+        </switch>
+      </g>
     </g>
   </g>
-  <switch
-     id="switch140">
-    <g
-       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
-       id="g134" />
-    <a
-       transform="translate(0,-5)"
-       xlink:href="https://www.diagrams.net/doc/faq/svg-export-text-problems"
-       target="_blank"
-       id="a138">
-      <text
-         text-anchor="middle"
-         font-size="10px"
-         x="50%"
-         y="100%"
-         id="text136">Text is not SVG - cannot display</text>
-    </a>
-  </switch>
 </svg>
diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
index a422a9bf1a0..80d91cafab0 100644
--- a/doc/board/ti/j721e_evm.rst
+++ b/doc/board/ti/j721e_evm.rst
@@ -150,6 +150,33 @@ Image formats:
 .. image:: img/sysfw.itb.svg
   :alt: sysfw.itb image format
 
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
+and sysfw.itb over tftp and then flash those to OSPI at their respective
+addresses.
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
+  tftp ${loadaddr} sysfw.itb
+  sf update $loadaddr 0x6C0000 $filesize
+
+Flash layout for OSPI:
+
+.. image:: img/ospi_sysfw.svg
+  :alt: OSPI flash partition layout
+
 R5 Memory Map:
 --------------
 
@@ -193,35 +220,8 @@ R5 Memory Map:
      - 0x41cffbfc
      - 0x41cfffff
 
-OSPI:
------
-ROM supports booting from OSPI from offset 0x0.
-
-Flashing images to OSPI:
-
-Below commands can be used to download tiboot3.bin, tispl.bin, u-boot.img,
-and sysfw.itb over tftp and then flash those to OSPI at their respective
-addresses.
-
-.. prompt:: bash =>
-
-  sf probe
-  tftp ${loadaddr} tiboot3.bin
-  sf update $loadaddr 0x0 $filesize
-  tftp ${loadaddr} tispl.bin
-  sf update $loadaddr 0x80000 $filesize
-  tftp ${loadaddr} u-boot.img
-  sf update $loadaddr 0x280000 $filesize
-  tftp ${loadaddr} sysfw.itb
-  sf update $loadaddr 0x6C0000 $filesize
-
-Flash layout for OSPI:
-
-.. image:: img/ospi_sysfw.svg
-  :alt: OSPI flash partition layout
-
-Firmwares:
-----------
+Firmware:
+---------
 
 The J721e u-boot allows firmware to be loaded for the Cortex-R5 subsystem.
 The CPSW5G in J7200 and CPSW9G in J721E present in MAIN domain is configured
-- 
2.34.1

