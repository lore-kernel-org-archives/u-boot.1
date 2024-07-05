Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE52C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 16:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E24889C2;
	Fri,  5 Jul 2024 18:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PYIylK6O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87615889C0; Fri,  5 Jul 2024 18:49:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDCB6889C2
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 18:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465Gnb9s003516;
 Fri, 5 Jul 2024 11:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720198177;
 bh=USsx6FkTOQ/zE1MLny8IYl/fl6oLDT2zfnY6IbjHbCw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PYIylK6Olw1/DVr+cvth6OueLWx5VKkyKomPJaXVPSRjeARIjivd7yYEdjuVm2N7E
 8rDJkPgDoG+O2uw8f2ev1wJ1YbCYDctXqMPkJlSkFWqdmTGsKjXXh0cKrBxpr3nTqJ
 Tmv/T9XmTPrVh0vsaQ3ZBZxkiTs8Y27apbaydP3g=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465GnbuS114000
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 11:49:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 11:49:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 11:49:37 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465Gmhd2028675;
 Fri, 5 Jul 2024 11:49:32 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V5 3/6] doc: beagle: am62x_beagleplay: Add TIFS Stub in image
 format
Date: Fri, 5 Jul 2024 22:18:30 +0530
Message-ID: <20240705164833.2386549-4-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705164833.2386549-1-d-gole@ti.com>
References: <20240705164833.2386549-1-d-gole@ti.com>
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

Mention the TIFS Stub in the TISP image format

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst      |   2 +-
 doc/board/ti/img/tifsstub_dm_tispl.bin.svg | 353 +++++++++++++++++++++
 2 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index 375f26fc5f3e..e7347610173e 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -86,7 +86,7 @@ Image formats
 
 - tispl.bin
 
-.. image:: ../ti/img/dm_tispl.bin.svg
+.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
   :alt: tispl.bin image format
 
 Additional hardware for U-Boot development
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

