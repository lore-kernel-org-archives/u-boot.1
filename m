Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BDBC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE00C88001;
	Fri, 14 Jun 2024 18:36:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dQaqK3Gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF0D8887A; Fri, 14 Jun 2024 18:36:18 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E322288A5F
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZtTt013687;
 Fri, 14 Jun 2024 11:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718382955;
 bh=LT6qkYOCXyx21IuX5owr9ltbmH7mO2i0535QE0s9/x8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dQaqK3Gs2nAgQkFrn/zEfN3rHBlGYGWCxihhwc+qWGP92HJcX4FD/1qSoInp9r212
 Pxe4YgmdRaH3TYSdVmMM+jo+DwGD3lxkqXmYQljCo8ruLg4u/Z6NNhBdR0H2iyy7Xt
 jmK56XSJMybcMgoJTZamzncvPpD1K6aC2NhIT2lM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EGZsJu076574
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 11:35:55 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 11:35:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 11:35:54 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EGZsvT027232;
 Fri, 14 Jun 2024 11:35:54 -0500
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
Subject: [PATCH v7 24/24] doc: board: ti: j784s4: document OSPI NOR layout
Date: Fri, 14 Jun 2024 11:35:51 -0500
Message-ID: <20240614163551.2610212-25-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240614163551.2610212-1-j-humphreys@ti.com>
References: <20240614163551.2610212-1-j-humphreys@ti.com>
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

Added OSPI NOR flash layout diagram, as well as example commands to flash
firmware to it.  Added OSPI boot mode pin setting.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 doc/board/ti/img/ospi_sysfw3.svg | 802 +++++++++++++++++++++++++++++++
 doc/board/ti/j784s4_evm.rst      |  28 ++
 2 files changed, 830 insertions(+)
 create mode 100644 doc/board/ti/img/ospi_sysfw3.svg

diff --git a/doc/board/ti/img/ospi_sysfw3.svg b/doc/board/ti/img/ospi_sysfw3.svg
new file mode 100644
index 00000000000..382867c6f4f
--- /dev/null
+++ b/doc/board/ti/img/ospi_sysfw3.svg
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
+   id="svg205"
+   sodipodi:docname="ospi_sysfw3.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview207"
+     pagecolor="#505050"
+     bordercolor="#eeeeee"
+     borderopacity="1"
+     inkscape:pageshadow="0"
+     inkscape:pageopacity="0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="3.4732143"
+     inkscape:cx="160.37018"
+     inkscape:cy="168"
+     inkscape:window-width="3370"
+     inkscape:window-height="1376"
+     inkscape:window-x="70"
+     inkscape:window-y="27"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g203" />
+  <defs
+     id="defs9" />
+  <g
+     id="g203">
+    <g
+       id="g13">
+      <rect
+         x="120"
+         y="15"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect11" />
+    </g>
+    <g
+       id="g21">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g19">
+        <switch
+           id="switch17">
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
+             id="text15">ospi.tiboot3(512k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g25">
+      <rect
+         x="60"
+         y="5"
+         width="60"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect23" />
+    </g>
+    <g
+       id="g33">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g31">
+        <switch
+           id="switch29">
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
+             id="text27">0x0</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g37">
+      <rect
+         x="120"
+         y="55"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect35" />
+    </g>
+    <g
+       id="g45">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g43">
+        <switch
+           id="switch41">
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
+             id="text39">ospi.tispl(2M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g49">
+      <rect
+         x="0"
+         y="45"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect47" />
+    </g>
+    <g
+       id="g57">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g55">
+        <switch
+           id="switch53">
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
+             id="text51">0x80000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g61">
+      <rect
+         x="120"
+         y="95"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect59" />
+    </g>
+    <g
+       id="g69">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g67">
+        <switch
+           id="switch65">
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
+             id="text63">ospi.u-boot(4M)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g73">
+      <rect
+         x="0"
+         y="85"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect71" />
+    </g>
+    <g
+       id="g81">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g79">
+        <switch
+           id="switch77">
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
+             fill="#000000"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text75">0x280000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g85">
+      <rect
+         x="120"
+         y="135"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect83" />
+    </g>
+    <g
+       id="g93">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g91">
+        <switch
+           id="switch89">
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
+             id="text87">ospi.env(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g97">
+      <rect
+         x="0"
+         y="125"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect95" />
+    </g>
+    <g
+       id="g105">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g103">
+        <switch
+           id="switch101">
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
+             fill="rgb(0, 0, 0)"
+             font-family="Helvetica"
+             font-size="12px"
+             text-anchor="end"
+             id="text99">0x680000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g109">
+      <rect
+         x="120"
+         y="175"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect107" />
+    </g>
+    <g
+       id="g117">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g115">
+        <switch
+           id="switch113">
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
+             id="text111">ospi.env.backup(128K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g121">
+      <rect
+         x="0"
+         y="165"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect119" />
+    </g>
+    <g
+       id="g129">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g127">
+        <switch
+           id="switch125">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6A0000</xhtml:pre>
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
+             id="text123">0x6A0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g133">
+      <rect
+         x="120"
+         y="215"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect131" />
+    </g>
+    <g
+       id="g141">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g139">
+        <switch
+           id="switch137">
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
+                   style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">padding(1280K)</xhtml:div>
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
+             id="text135">padding(1280K)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g145">
+      <rect
+         x="0"
+         y="205"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect143" />
+    </g>
+    <g
+       id="g153">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g151">
+        <switch
+           id="switch149">
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
+                     style="box-sizing: border-box; font-family: SFMono-Regular, Menlo, Monaco, Consolas, &quot;Liberation Mono&quot;, &quot;Courier New&quot;, Courier, monospace; line-height: 1.4; margin-top: 0px; margin-bottom: 0px; padding: 12px; overflow: auto; color: rgb(64, 64, 64); text-align: start;">0x6C0000</xhtml:pre>
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
+             id="text147">0x6C0000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g157">
+      <rect
+         x="120"
+         y="255"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect155" />
+    </g>
+    <g
+       id="g165">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g163">
+        <switch
+           id="switch161">
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
+             id="text159">ospi.rootfs(UBIFS)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g169">
+      <rect
+         x="0"
+         y="245"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect167" />
+    </g>
+    <g
+       id="g177">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g175">
+        <switch
+           id="switch173">
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
+             id="text171">0x800000</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g181">
+      <rect
+         x="120"
+         y="295"
+         width="200"
+         height="40"
+         fill="none"
+         stroke="rgb(0, 0, 0)"
+         pointer-events="all"
+         id="rect179" />
+    </g>
+    <g
+       id="g189">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g187">
+        <switch
+           id="switch185">
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
+             id="text183">ospi.phypattern(256k)</text>
+        </switch>
+      </g>
+    </g>
+    <g
+       id="g193">
+      <rect
+         x="0"
+         y="285"
+         width="120"
+         height="30"
+         fill="none"
+         stroke="none"
+         pointer-events="all"
+         id="rect191" />
+    </g>
+    <g
+       id="g201">
+      <g
+         transform="translate(-0.5 -0.5)"
+         id="g199">
+        <switch
+           id="switch197">
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
+             id="text195">0x3FC0000</text>
+        </switch>
+      </g>
+    </g>
+  </g>
+</svg>
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 5c4bd2c927d..2ffec3dbd3b 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -153,6 +153,31 @@ Image formats
 .. image:: img/dm_tispl.bin.svg
     :alt: tispl.bin format
 
+OSPI:
+-----
+ROM supports booting from OSPI from offset 0x0.
+
+Flashing images to OSPI NOR:
+
+Below commands can be used to download tiboot3.bin, tispl.bin, and
+u-boot.img over tftp and then flash those to OSPI at their respective
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
+
+Flash layout for OSPI NOR:
+
+.. image:: img/ospi_sysfw3.svg
+  :alt: OSPI NOR flash partition layout
+
 R5 Memory Map
 -------------
 
@@ -262,6 +287,9 @@ section.
    * - SD
      - 0000
 
+   * - OSPI
+     - 0010
+
    * - EMMC
      - 0110
 
-- 
2.34.1

