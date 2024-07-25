Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B9DC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9388807C;
	Thu, 25 Jul 2024 11:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ofwtao6F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B883E88496; Thu, 25 Jul 2024 11:39:03 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41CA28810A
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P9cteY030792;
 Thu, 25 Jul 2024 04:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721900335;
 bh=zQQwjG2FsSHKkBRj7umvNkzKvv7OksPKQdQbkttl7K8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ofwtao6FjoH69xqdqHh4kx3LZ6uKZGTWoMEc8XYOPAUF6RtB1TYbVWHV31Z/EoyxE
 2Z8bUGzRK0p5gwgl/zrtfdFuDQXLdzNMUIy9AEt7FbCol4mdEGeVslVoSGpp43K0IV
 1HjikdRUWpz+7azAMeBT15FruT1mk1OejtzFXmmE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P9ctkI079302
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 04:38:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 04:38:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 04:38:55 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P9ad8V066876;
 Thu, 25 Jul 2024 04:38:51 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 4/7] doc: ti: am62*: Mention TIFS Stub in img fmts and boot
 flow
Date: Thu, 25 Jul 2024 15:05:44 +0530
Message-ID: <20240725093546.4193107-5-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725093546.4193107-1-d-gole@ti.com>
References: <20240725093546.4193107-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Since AM62x, AM62P and AM62A all use similar boot flows and their low
power mode s/w ARCH is also similar in the way that they make use of the
TIFS Stub, update their documentation to show where TIFS Stub is.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/ti/am62ax_sk.rst                 |    4 +-
 doc/board/ti/am62px_sk.rst                 |    4 +-
 doc/board/ti/am62x_sk.rst                  |    4 +-
 doc/board/ti/img/boot_diagram_am62.svg     | 1983 ++++++++++++++++++++
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg |  353 ++++
 5 files changed, 2342 insertions(+), 6 deletions(-)
 create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 72fa5a8d8cdd..262340ef59a3 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -47,7 +47,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -148,7 +148,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Switch Setting for Boot Mode
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index bcef6653cb92..99bdc0348692 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -55,7 +55,7 @@ Boot Flow:
 The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
 family. Below is the pictorial representation:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -157,7 +157,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index e2a848d159ff..b9d35244d446 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -46,7 +46,7 @@ Boot Flow:
 ----------
 Below is the pictorial representation of boot flow:
 
-.. image:: img/boot_diagram_k3_current.svg
+.. image:: img/boot_diagram_am62.svg
   :alt: Boot flow diagram
 
 - Here TIFS acts as master and provides all the critical services. R5/A53
@@ -165,7 +165,7 @@ Image formats:
 
 - tispl.bin
 
-.. image:: img/dm_tispl.bin.svg
+.. image:: img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 OSPI:
diff --git a/doc/board/ti/img/boot_diagram_am62.svg b/doc/board/ti/img/boot_diagram_am62.svg
new file mode 100644
index 000000000000..44c54dbd2c1e
--- /dev/null
+++ b/doc/board/ti/img/boot_diagram_am62.svg
@@ -0,0 +1,1983 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
+
+<!-- Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/ -->
+
+<svg
+   version="1.1"
+   width="706px"
+   height="951px"
+   viewBox="-0.5 -0.5 706 951"
+   id="svg420"
+   sodipodi:docname="boot_diagram_am62.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview422"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="0.86961094"
+     inkscape:cx="259.31137"
+     inkscape:cy="305.88392"
+     inkscape:window-width="1920"
+     inkscape:window-height="1008"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g138" />
+  <defs
+     id="defs2" />
+  <g
+     id="g410">
+    <rect
+       x="482"
+       y="581"
+       width="10"
+       height="70"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect4" />
+    <rect
+       x="235.5"
+       y="50"
+       width="144.75"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect6" />
+    <path
+       d="M 307.88 90 L 307.88 940"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path8" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g14">
+      <switch
+         id="switch12">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 143px; height: 1px; padding-top: 70px; margin-left: 237px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="308"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text10">Cortex-R</text>
+      </switch>
+    </g>
+    <rect
+       x="298.75"
+       y="160"
+       width="10"
+       height="130"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect16" />
+    <rect
+       x="301"
+       y="161"
+       width="71.5"
+       height="30"
+       fill="#ffe6cc"
+       stroke="#d79b00"
+       pointer-events="all"
+       id="rect18" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g24">
+      <switch
+         id="switch22">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 176px; margin-left: 302px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ROM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="337"
+           y="180"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text20">ROM</text>
+      </switch>
+    </g>
+    <rect
+       x="299.75"
+       y="305"
+       width="10"
+       height="205"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect26" />
+    <rect
+       x="302"
+       y="306"
+       width="105.5"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect28" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g34">
+      <switch
+         id="switch32">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 104px; height: 1px; padding-top: 321px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R SPL</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="325"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text30">Cortex-R SPL</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="190"
+       width="90"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect36" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g42">
+      <switch
+         id="switch40">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 210px; margin-left: 310px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load and auth tiboot3.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354"
+           y="214"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text38">Load and auth t...</text>
+      </switch>
+    </g>
+    <rect
+       x="309"
+       y="262"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect44" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g50">
+      <switch
+         id="switch48">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 278px; margin-left: 310px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load system<xhtml:br />
+config data</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354"
+           y="282"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text46">Load system...</text>
+      </switch>
+    </g>
+    <rect
+       x="310"
+       y="336"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect52" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g58">
+      <switch
+         id="switch56">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 352px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">DDR Config</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="356"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text54">DDR Config</text>
+      </switch>
+    </g>
+    <rect
+       x="310"
+       y="368"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect60" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g66">
+      <switch
+         id="switch64">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 384px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load tispl.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="388"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text62">Load tispl.bin</text>
+      </switch>
+    </g>
+    <rect
+       x="310"
+       y="440"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect68" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g74">
+      <switch
+         id="switch72">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 456px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start Cortex-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="460"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text70">Start Cortex-A</text>
+      </switch>
+    </g>
+    <rect
+       x="310"
+       y="472"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect76" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g82">
+      <switch
+         id="switch80">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 488px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start DM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="492"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text78">Start DM</text>
+      </switch>
+    </g>
+    <rect
+       x="300"
+       y="530"
+       width="10"
+       height="410"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect84" />
+    <path
+       d="M 347.5 565 L 347.5 570 L 347.5 573.63"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path86" />
+    <path
+       d="M 347.5 578.88 L 344 571.88 L 347.5 573.63 L 351 571.88 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path88" />
+    <rect
+       x="302"
+       y="535"
+       width="71.5"
+       height="30"
+       fill="#e1d5e7"
+       stroke="#9673a6"
+       pointer-events="all"
+       id="rect90" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g96">
+      <switch
+         id="switch94">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 550px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Device Mgr</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="338"
+           y="554"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text92">Device Mgr</text>
+      </switch>
+    </g>
+    <path
+       d="M 299 456 L 139.37 456"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path98" />
+    <path
+       d="M 134.12 456 L 141.12 452.5 L 139.37 456 L 141.12 459.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path100" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g106">
+      <switch
+         id="switch104">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 440px; margin-left: 257px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Start Cortex-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="257"
+           y="443"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text102">Start Cort...</text>
+      </switch>
+    </g>
+    <path
+       d="M 481 711 L 139.37 711"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path108" />
+    <path
+       d="M 134.12 711 L 141.12 707.5 L 139.37 711 L 141.12 714.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path110" />
+    <path
+       d="M 482 692 L 317.37 691.04"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path112" />
+    <path
+       d="M 312.12 691.01 L 319.14 687.55 L 317.37 691.04 L 319.1 694.55 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path114" />
+    <path
+       d="M 482 799 L 317.37 798.04"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path116" />
+    <path
+       d="M 312.12 798.01 L 319.14 794.55 L 317.37 798.04 L 319.1 801.55 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path118" />
+    <path
+       d="M 481 791 L 139.37 791"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path120" />
+    <path
+       d="M 134.12 791 L 141.12 787.5 L 139.37 791 L 141.12 794.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path122" />
+    <path
+       d="M 481 890 L 315.37 890.96"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path124" />
+    <path
+       d="M 310.12 890.99 L 317.1 887.45 L 315.37 890.96 L 317.14 894.45 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path126" />
+    <path
+       d="M 481 879 L 139.37 881.95"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path128" />
+    <path
+       d="M 134.12 881.99 L 141.09 878.43 L 139.37 881.95 L 141.15 885.43 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path130" />
+    <rect
+       x="302"
+       y="580"
+       width="71.5"
+       height="30"
+       fill="#e1d5e7"
+       stroke="#9673a6"
+       pointer-events="all"
+       id="rect132" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g138">
+      <switch
+         id="switch136">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 595px; margin-left: 303px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load TIFS Stub in TCM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="338"
+           y="599"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text134">Load TIFS St...</text>
+      </switch>
+    </g>
+    <path
+       d="M 482 640 L 315.37 640"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path140" />
+    <path
+       d="M 310.12 640 L 317.12 636.5 L 315.37 640 L 317.12 643.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path142" />
+    <rect
+       x="437"
+       y="50"
+       width="116.5"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect144" />
+    <path
+       d="M 495.25 90 L 495.25 820"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path146" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g152">
+      <switch
+         id="switch150">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 115px; height: 1px; padding-top: 70px; margin-left: 438px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="495"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text148">Cortex-A</text>
+      </switch>
+    </g>
+    <rect
+       x="482"
+       y="510"
+       width="10"
+       height="70"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect154" />
+    <path
+       d="M 482 565 L 139.37 565"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path156" />
+    <path
+       d="M 134.12 565 L 141.12 561.5 L 139.37 565 L 141.12 568.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path158" />
+    <path
+       d="M 482 614.97 L 140.37 614.67"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path160" />
+    <path
+       d="M 135.12 614.66 L 142.12 611.17 L 140.37 614.67 L 142.11 618.17 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path162" />
+    <rect
+       x="482"
+       y="600"
+       width="71.5"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect164" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g170">
+      <switch
+         id="switch168">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 615px; margin-left: 483px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">OP-TEE</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="518"
+           y="619"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text166">OP-TEE</text>
+      </switch>
+    </g>
+    <rect
+       x="577"
+       y="50"
+       width="116.5"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect172" />
+    <path
+       d="M 635.25 90 L 635.25 950"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path174" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g180">
+      <switch
+         id="switch178">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 115px; height: 1px; padding-top: 70px; margin-left: 578px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-R/M<xhtml:br />
+C6x/C7x</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="635"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text176">Cortex-R/M...</text>
+      </switch>
+    </g>
+    <rect
+       x="631"
+       y="910"
+       width="10"
+       height="38"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect182" />
+    <rect
+       x="633"
+       y="912"
+       width="71.5"
+       height="30"
+       fill="#e1d5e7"
+       stroke="#9673a6"
+       pointer-events="all"
+       id="rect184" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g190">
+      <switch
+         id="switch188">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 927px; margin-left: 634px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Aux f/w</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="669"
+           y="931"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text186">Aux f/w</text>
+      </switch>
+    </g>
+    <rect
+       x="77"
+       y="50"
+       width="100"
+       height="40"
+       rx="6"
+       ry="6"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect192" />
+    <path
+       d="M 127 90 L 127 940"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="3 3"
+       pointer-events="all"
+       id="path194" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g200">
+      <switch
+         id="switch198">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 70px; margin-left: 78px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS/DMSC</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="127"
+           y="74"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text196">TIFS/DMSC</text>
+      </switch>
+    </g>
+    <rect
+       x="122"
+       y="130"
+       width="10"
+       height="110"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect202" />
+    <rect
+       x="79"
+       y="132"
+       width="50"
+       height="30"
+       fill="#ffe6cc"
+       stroke="#d79b00"
+       pointer-events="all"
+       id="rect204" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g210">
+      <switch
+         id="switch208">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 48px; height: 1px; padding-top: 147px; margin-left: 80px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ROM</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="104"
+           y="151"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text206">ROM</text>
+      </switch>
+    </g>
+    <rect
+       x="122"
+       y="253"
+       width="10"
+       height="687"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect212" />
+    <path
+       d="M 297 238 L 138.37 238"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path214" />
+    <path
+       d="M 133.12 238 L 140.12 234.5 L 138.37 238 L 140.12 241.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path216" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g222">
+      <switch
+         id="switch220">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 230px; margin-left: 267px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Start TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="267"
+           y="233"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text218">Start TIFS</text>
+      </switch>
+    </g>
+    <rect
+       x="80"
+       y="255"
+       width="50"
+       height="30"
+       fill="#f8cecc"
+       stroke="#b85450"
+       pointer-events="all"
+       id="rect224" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g230">
+      <switch
+         id="switch228">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 48px; height: 1px; padding-top: 270px; margin-left: 81px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="105"
+           y="274"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text226">TIFS</text>
+      </switch>
+    </g>
+    <path
+       d="M 62 0 L 178 0 L 192 14 L 192 35 L 62 35 L 62 0 Z"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path232" />
+    <path
+       d="M 178 0 L 178 14 L 192 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path234" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g240">
+      <switch
+         id="switch238">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 128px; height: 1px; padding-top: 1px; margin-left: 63px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Security Enclave Boot Processor</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="127"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text236">Security Enclave Boot...</text>
+      </switch>
+    </g>
+    <path
+       d="M 241 0 L 361 0 L 375 14 L 375 35 L 241 35 L 241 0 Z"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path242" />
+    <path
+       d="M 361 0 L 361 14 L 375 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path244" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g250">
+      <switch
+         id="switch248">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 132px; height: 1px; padding-top: 1px; margin-left: 242px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Boot Loader <xhtml:br />
+Processor</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="308"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text246">Boot Loader...</text>
+      </switch>
+    </g>
+    <path
+       d="M 437 0 L 523 0 L 537 14 L 537 35 L 437 35 L 437 0 Z"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path252" />
+    <path
+       d="M 523 0 L 523 14 L 537 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path254" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g260">
+      <switch
+         id="switch258">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 1px; margin-left: 438px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Main CPU</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="487"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text256">Main CPU</text>
+      </switch>
+    </g>
+    <path
+       d="M 577 0 L 663 0 L 677 14 L 677 35 L 577 35 L 577 0 Z"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path262" />
+    <path
+       d="M 663 0 L 663 14 L 677 14"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path264" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g270">
+      <switch
+         id="switch268">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-start; justify-content: unsafe center; width: 98px; height: 1px; padding-top: 1px; margin-left: 578px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Verdana; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Auxiliary<xhtml:br />
+Processor</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="627"
+           y="13"
+           fill="rgb(0, 0, 0)"
+           font-family="Verdana"
+           font-size="12px"
+           text-anchor="middle"
+           id="text266">Auxiliary...</text>
+      </switch>
+    </g>
+    <path
+       d="M 7 120 L 120.63 120"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       stroke-dasharray="12 12"
+       pointer-events="stroke"
+       id="path272" />
+    <path
+       d="M 125.88 120 L 118.88 123.5 L 120.63 120 L 118.88 116.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path274" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g280">
+      <switch
+         id="switch278">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe flex-end; justify-content: unsafe flex-start; width: 1px; height: 1px; padding-top: 118px; margin-left: 9px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: left;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">H/w Seq: Reset rls</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="9"
+           y="118"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           id="text276">H/w Seq: Reset rls</text>
+      </switch>
+    </g>
+    <path
+       d="M 298 200 L 138.37 199.98"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path282" />
+    <path
+       d="M 133.12 199.98 L 140.12 196.48 L 138.37 199.98 L 140.12 203.48 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path284" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g290">
+      <switch
+         id="switch288">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 190px; margin-left: 257px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Auth tiboot3.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="257"
+           y="193"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text286">Auth tiboo...</text>
+      </switch>
+    </g>
+    <path
+       d="M 133 159 L 301.01 159"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292" />
+    <path
+       d="M 306.26 159 L 299.26 162.5 L 301.01 159 L 299.26 155.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g300">
+      <switch
+         id="switch298">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 150px; margin-left: 178px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Release Reset</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="178"
+           y="153"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text296">Release Re...</text>
+      </switch>
+    </g>
+    <path
+       d="M 299 281.94 L 139.37 281.04"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path302" />
+    <path
+       d="M 134.12 281.01 L 141.14 277.55 L 139.37 281.04 L 141.1 284.55 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path304" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g310">
+      <switch
+         id="switch308">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 270px; margin-left: 237px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Load system config data</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="237"
+           y="273"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text306">Load syste...</text>
+      </switch>
+    </g>
+    <rect
+       x="308.75"
+       y="230"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect312" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g318">
+      <switch
+         id="switch316">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 246px; margin-left: 310px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start TIFS</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="354"
+           y="250"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text314">Start TIFS</text>
+      </switch>
+    </g>
+    <rect
+       x="310"
+       y="400"
+       width="90"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect320" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g326">
+      <switch
+         id="switch324">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 88px; height: 1px; padding-top: 416px; margin-left: 311px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load DM f/w</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="355"
+           y="420"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text322">Load DM f/w</text>
+      </switch>
+    </g>
+    <path
+       d="M 303 510 L 333 510 L 333 530 L 309.12 530"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path328" />
+    <path
+       d="M 302.12 530 L 309.12 526.5 L 309.12 533.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path330" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g336">
+      <switch
+         id="switch334">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe flex-start; width: 1px; height: 1px; padding-top: 521px; margin-left: 337px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: left;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">branch</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="337"
+           y="524"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           id="text332">branch</text>
+      </switch>
+    </g>
+    <path
+       d="M 133 511 L 137 511 L 476.63 511"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path338" />
+    <path
+       d="M 481.88 511 L 474.88 514.5 L 476.63 511 L 474.88 507.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path340" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g346">
+      <switch
+         id="switch344">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 500px; margin-left: 177px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Release Reset</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="177"
+           y="503"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text342">Release Re...</text>
+      </switch>
+    </g>
+    <rect
+       x="484"
+       y="513"
+       width="71.5"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect348" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g354">
+      <switch
+         id="switch352">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 70px; height: 1px; padding-top: 528px; margin-left: 485px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TF-A </xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="520"
+           y="532"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text350">TF-A </text>
+      </switch>
+    </g>
+    <rect
+       x="482"
+       y="662"
+       width="10"
+       height="78"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect356" />
+    <rect
+       x="484"
+       y="665"
+       width="83"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect358" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g364">
+      <switch
+         id="switch362">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 680px; margin-left: 485px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-A SPL</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="526"
+           y="684"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text360">Cortex-A SPL</text>
+      </switch>
+    </g>
+    <rect
+       x="482"
+       y="748"
+       width="10"
+       height="192"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect366" />
+    <rect
+       x="484"
+       y="751"
+       width="83"
+       height="30"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect368" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g374">
+      <switch
+         id="switch372">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 81px; height: 1px; padding-top: 766px; margin-left: 485px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">U-Boot</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="526"
+           y="770"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text370">U-Boot</text>
+      </switch>
+    </g>
+    <rect
+       x="492"
+       y="700"
+       width="103"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect376" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g382">
+      <switch
+         id="switch380">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 716px; margin-left: 493px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load u-boot.img</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="544"
+           y="720"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text378">Load u-boot.img</text>
+      </switch>
+    </g>
+    <rect
+       x="492"
+       y="820"
+       width="103"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect384" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g390">
+      <switch
+         id="switch388">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 836px; margin-left: 493px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Load Aux core f/w<xhtml:br />
+(optional)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="544"
+           y="840"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text386">Load Aux core f/w...</text>
+      </switch>
+    </g>
+    <rect
+       x="492"
+       y="860"
+       width="103"
+       height="32"
+       rx="4.8"
+       ry="4.8"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect392" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g398">
+      <switch
+         id="switch396">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 101px; height: 1px; padding-top: 876px; margin-left: 493px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Start Aux core<xhtml:br />
+(optional)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="544"
+           y="880"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text394">Start Aux core...</text>
+      </switch>
+    </g>
+    <path
+       d="M 311 909 L 628.38 909"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path400" />
+    <path
+       d="M 633.63 909 L 626.63 912.5 L 628.38 909 L 626.63 905.5 Z"
+       fill="rgb(0, 0, 0)"
+       stroke="rgb(0, 0, 0)"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path402" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g408">
+      <switch
+         id="switch406">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 1px; height: 1px; padding-top: 900px; margin-left: 357px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); background-color: rgb(255, 255, 255); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 11px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; background-color: rgb(255, 255, 255); white-space: nowrap;">Release Reset</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="357"
+           y="903"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="11px"
+           text-anchor="middle"
+           id="text404">Release Re...</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch418">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g412" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a416">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text414">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
diff --git a/doc/board/ti/img/tifsstub_dm_tispl.bin.svg b/doc/board/ti/img/tifsstub_dm_tispl.bin.svg
new file mode 100644
index 000000000000..5d56d81f6674
--- /dev/null
+++ b/doc/board/ti/img/tifsstub_dm_tispl.bin.svg
@@ -0,0 +1,353 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause -->
+
+<!-- Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/ -->
+
+<svg
+   version="1.1"
+   width="231px"
+   height="351px"
+   viewBox="-0.5 -0.5 231 351"
+   id="svg72"
+   sodipodi:docname="tifsstub_dm_tispl.bin.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview74"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="2.3561254"
+     inkscape:cx="115.65599"
+     inkscape:cy="276.72551"
+     inkscape:window-width="1920"
+     inkscape:window-height="1008"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="svg72" />
+  <defs
+     id="defs2" />
+  <g
+     id="g62">
+    <rect
+       x="0"
+       y="0"
+       width="230"
+       height="350"
+       rx="34.5"
+       ry="34.5"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       pointer-events="all"
+       id="rect4" />
+    <rect
+       x="40"
+       y="30"
+       width="160"
+       height="60"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect6" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g12">
+      <switch
+         id="switch10">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 60px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">FIT Header</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="64"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text8">FIT Header</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="160"
+       width="160"
+       height="50"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect14" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g20">
+      <switch
+         id="switch18">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 185px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TIFS Stub<xhtml:br />
+(GP, HS-FS, HS-SE)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="189"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text16">TIFS Stub...</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="90"
+       width="160"
+       height="30"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect22" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g28">
+      <switch
+         id="switch26">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 105px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">TF-A</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="109"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text24">TF-A</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="120"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect30" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g36">
+      <switch
+         id="switch34">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 140px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">OP-TEE</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="144"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text32">OP-TEE</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="210"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect38" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g44">
+      <switch
+         id="switch42">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 230px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">R5 DM FW</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="234"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text40">R5 DM FW</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="250"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect46" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g52">
+      <switch
+         id="switch50">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 270px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Cortex-A SPL</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="274"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text48">Cortex-A SPL</text>
+      </switch>
+    </g>
+    <rect
+       x="40"
+       y="290"
+       width="160"
+       height="40"
+       fill="none"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect54" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g60">
+      <switch
+         id="switch58">
+        <foreignObject
+           style="overflow: visible; text-align: left;"
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 158px; height: 1px; padding-top: 310px; margin-left: 41px;">
+            <xhtml:div
+               style="box-sizing: border-box; font-size: 0px; text-align: center;"
+               data-drawio-colors="color: rgb(0, 0, 0); ">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">SPL DTB 1..N</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="120"
+           y="314"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text56">SPL DTB 1..N</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch70">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g64" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.drawio.com/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a68">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text66">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
-- 
2.34.1

