Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD9C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A7B885BE;
	Sat,  8 Jun 2024 00:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AsZrmkKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BC988542; Sat,  8 Jun 2024 00:39:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F43D8853B
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457MdUBl079354;
 Fri, 7 Jun 2024 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717799970;
 bh=K5bfWiPhHFv7+39mexlJIPsoYS/qjCtXmr5HgZNF5KE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=AsZrmkKGDMk50SXLd9tu5OejVFjl/93Hj14IpCZ5ZGIMb/lNb/BK3GnDZCiAKXb4+
 bEbeUi2IknU5HAsj677uFe0XdXAWjuLIpdpzzRH4Vn7L0TImx2iZxYRsgRWtwzzxTy
 m1b9KmcbZ87BrCsHaTEZq7OfDfAKVu5O+If8PWYo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457MdUoL015738
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Jun 2024 17:39:30 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 17:39:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 17:39:29 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457MdUN0011250;
 Fri, 7 Jun 2024 17:39:30 -0500
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
Subject: [PATCH v6 06/24] doc: board: ti: am64x: document OSPI layout
Date: Fri, 7 Jun 2024 17:38:40 -0500
Message-ID: <20240607223858.1971290-7-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607223858.1971290-1-j-humphreys@ti.com>
References: <20240607223858.1971290-1-j-humphreys@ti.com>
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
 doc/board/ti/am64x_evm.rst           |  24 +
 doc/board/ti/img/ospi_sysfw-am64.svg | 802 +++++++++++++++++++++++++++
 2 files changed, 826 insertions(+)
 create mode 100644 doc/board/ti/img/ospi_sysfw-am64.svg

diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
index 6ae35b3fee3..88997b6a283 100644
--- a/doc/board/ti/am64x_evm.rst
+++ b/doc/board/ti/am64x_evm.rst
@@ -140,6 +140,30 @@ Image formats:
 .. image:: img/nodm_tispl.bin.svg
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
+  sf update $loadaddr 0x100000 $filesize
+  tftp ${loadaddr} u-boot.img
+  sf update $loadaddr 0x300000 $filesize
+
+Flash layout for OSPI:
+
+.. image:: img/ospi_sysfw-am64.svg
+  :alt: OSPI flash partition layout
+
 Switch Setting for Boot Mode
 ----------------------------
 
diff --git a/doc/board/ti/img/ospi_sysfw-am64.svg b/doc/board/ti/img/ospi_sysfw-am64.svg
new file mode 100644
index 00000000000..f6244dce596
--- /dev/null
+++ b/doc/board/ti/img/ospi_sysfw-am64.svg
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
+   id="svg28701"
+   sodipodi:docname="ospi_sysfw-am64.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview28703"
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
+     inkscape:current-layer="g28699" />
+  <defs
+     id="defs28505" />
+  <g
+     id="g28699">
+    <g
+       id="g28509">
+      <rect
+         x="120"
+         y="15"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28507" />
+    </g>
+    <g
+       id="g28517">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28515">
+        <switch
+           id="switch28513">
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
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">ospi.tiboot3(1M)</xhtml:div>
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
+             id="text28511">ospi.tiboot3(1M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28521">
+      <rect
+         x="60"
+         y="5"
+         width="60"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28519" />
+    </g>
+    <g
+       id="g28529">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28527">
+        <switch
+           id="switch28525">
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
+             id="text28523">0x0</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28533">
+      <rect
+         x="120"
+         y="55"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28531" />
+    </g>
+    <g
+       id="g28541">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28539">
+        <switch
+           id="switch28537">
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
+             id="text28535">ospi.tispl(2M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28545">
+      <rect
+         x="0"
+         y="45"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28543" />
+    </g>
+    <g
+       id="g28553">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28551">
+        <switch
+           id="switch28549">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x100000</xhtml:pre>
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
+             id="text28547">0x100000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28557">
+      <rect
+         x="120"
+         y="95"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28555" />
+    </g>
+    <g
+       id="g28565">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28563">
+        <switch
+           id="switch28561">
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
+             id="text28559">ospi.u-boot(4M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28569">
+      <rect
+         x="0"
+         y="85"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28567" />
+    </g>
+    <g
+       id="g28577">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28575">
+        <switch
+           id="switch28573">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x300000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="104"
+             fill="#000000"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text28571">0x300000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28581">
+      <rect
+         x="120"
+         y="135"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28579" />
+    </g>
+    <g
+       id="g28589">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28587">
+        <switch
+           id="switch28585">
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
+             id="text28583">ospi.env(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28593">
+      <rect
+         x="0"
+         y="125"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28591" />
+    </g>
+    <g
+       id="g28601">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28599">
+        <switch
+           id="switch28597">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x700000</xhtml:pre>
+                </xhtml:div>
+              </xhtml:div>
+            </xhtml:div>
+          </foreignObject>
+          <text
+             x="118"
+             y="144"
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text28595">0x700000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28605">
+      <rect
+         x="120"
+         y="175"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28603" />
+    </g>
+    <g
+       id="g28613">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28611">
+        <switch
+           id="switch28609">
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
+             id="text28607">ospi.env.backup(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28617">
+      <rect
+         x="0"
+         y="165"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28615" />
+    </g>
+    <g
+       id="g28625">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28623">
+        <switch
+           id="switch28621">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x720000</xhtml:pre>
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
+             id="text28619">0x720000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28629">
+      <rect
+         x="120"
+         y="215"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28627" />
+    </g>
+    <g
+       id="g28637">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28635">
+        <switch
+           id="switch28633">
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
+             id="text28631">padding(768K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28641">
+      <rect
+         x="0"
+         y="205"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28639" />
+    </g>
+    <g
+       id="g28649">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28647">
+        <switch
+           id="switch28645">
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
+             id="text28643">0x740000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28653">
+      <rect
+         x="120"
+         y="255"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28651" />
+    </g>
+    <g
+       id="g28661">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28659">
+        <switch
+           id="switch28657">
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
+             id="text28655">ospi.rootfs(UBIFS)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28665">
+      <rect
+         x="0"
+         y="245"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28663" />
+    </g>
+    <g
+       id="g28673">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28671">
+        <switch
+           id="switch28669">
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
+             id="text28667">0x800000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28677">
+      <rect
+         x="120"
+         y="295"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect28675" />
+    </g>
+    <g
+       id="g28685">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28683">
+        <switch
+           id="switch28681">
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
+             id="text28679">ospi.phypattern(256k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g28689">
+      <rect
+         x="0"
+         y="285"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect28687" />
+    </g>
+    <g
+       id="g28697">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g28695">
+        <switch
+           id="switch28693">
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
+             id="text28691">0x3FC0000</text>
+        </switch>
+      </g>
+    </g>
+  </g>
+</svg>
-- 
2.34.1

