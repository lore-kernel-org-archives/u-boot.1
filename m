Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111D4E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 21:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F91D8022B;
	Wed, 18 Dec 2024 22:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFCC80241; Wed, 18 Dec 2024 22:20:43 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C4588021D
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 22:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1tO1TA-002gP5-Og;
 Wed, 18 Dec 2024 21:20:36 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] arm: dts: imx8mp-venice-gw7*xx: fix TPM reset
Date: Wed, 18 Dec 2024 13:20:35 -0800
Message-Id: <20241218212035.1892970-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

With an IMX8MP based SOM the SPI RST is gpio4_9 instead of gpio1_11.
Fix this.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: include additional boards affected by this
---
 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi | 16 +++++++---------
 arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi | 16 +++++++---------
 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi | 16 +++++++---------
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
index 216a7a0d8d7c..a291b7abab62 100644
--- a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
@@ -4,15 +4,6 @@
  */
 #include "imx8mp-venice-gw702x-u-boot.dtsi"
 
-&gpio1 {
-	tpm_rst {
-		gpio-hog;
-		output-high;
-		gpios = <11 GPIO_ACTIVE_HIGH>;
-		line-name = "tpm_rst#";
-	};
-};
-
 &gpio4 {
 	dio_1 {
 		gpio-hog;
@@ -21,6 +12,13 @@
 		line-name = "dio1";
 	};
 
+	tpm_rst {
+		gpio-hog;
+		output-high;
+		gpios = <9 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
+	};
+
 	dio_0 {
 		gpio-hog;
 		input;
diff --git a/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
index 525316d11892..bdf5370fcdf6 100644
--- a/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw72xx-2x-u-boot.dtsi
@@ -4,15 +4,6 @@
  */
 #include "imx8mp-venice-gw702x-u-boot.dtsi"
 
-&gpio1 {
-	tpm_rst {
-		gpio-hog;
-		output-high;
-		gpios = <11 GPIO_ACTIVE_HIGH>;
-		line-name = "tpm_rst#";
-	};
-};
-
 &gpio4 {
 	dio_1 {
 		gpio-hog;
@@ -21,6 +12,13 @@
 		line-name = "dio1";
 	};
 
+	tpm_rst {
+		gpio-hog;
+		output-high;
+		gpios = <9 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
+	};
+
 	dio_0 {
 		gpio-hog;
 		input;
diff --git a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
index 4d0e9a1e67c5..7e6f66bd9dd9 100644
--- a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
@@ -10,15 +10,6 @@
 	reset-post-delay-us = <300000>;
 };
 
-&gpio1 {
-	tpm_rst {
-		gpio-hog;
-		output-high;
-		gpios = <11 GPIO_ACTIVE_HIGH>;
-		line-name = "tpm_rst#";
-	};
-};
-
 &gpio4 {
 	dio_1 {
 		gpio-hog;
@@ -27,6 +18,13 @@
 		line-name = "dio1";
 	};
 
+	tpm_rst {
+		gpio-hog;
+		output-high;
+		gpios = <9 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
+	};
+
 	dio_0 {
 		gpio-hog;
 		input;
-- 
2.25.1

