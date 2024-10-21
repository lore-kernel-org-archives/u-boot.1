Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9125D1712E
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 20:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462AB88C53;
	Mon, 21 Oct 2024 22:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729540849;
	bh=ZJGpKdrQ4MMzy72B9MvrsgA+HNrWhuQw8MDzqBB2hIE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UKzuAB+uoqiKzZ0Ln7sUSbdDFTf+kt1MRGq5NVLEjUpuqfDtAGLzFFkB795h/8VQT
	 RgqVJhbsHBt2fy5UHQRt/GZR0a3/843BzoBfMP5v7CQY0w2KOLWqf6qO+X8lm7G1R1
	 8onML3joYaR6A25Xfi4YuW9hbXZ2SJ06ne6EduzEO0QMDLKssI/FS1IJxEdPuAPqna
	 D0W2zOiPypmDs6+WyK8tUK/USUPGPmV8glyobiJr/iZv/PdM2WgZtLB0CTAG3+A/rm
	 psDJXAe/Rs+l9aAKiUVwmM4PSCrio1g7BmnHHGqixMsQLHIgx0RuZ9h1jnGOxP8jFN
	 hBOVMOKsXoJ4w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7A14488D97;
 Mon, 21 Oct 2024 22:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729540846;
 bh=ZJGpKdrQ4MMzy72B9MvrsgA+HNrWhuQw8MDzqBB2hIE=;
 h=From:To:Cc:Subject:Date:From;
 b=Kn89l0AJlc7XFBteNzV2gCAE7CegYBUSnJycgflxqgZQkgC1zChjXuRAMcUQS/IZH
 AMJxbPLm55HhMMzIJ5fcRNYKGkKF5KIguYEOpWpWEDLjqbLZxpdND4ATfxlBJMYl18
 X1EElQRZJzweoO0jgH/rz5RFb7ohkDjXMYvh5fAz4SrHOLouANCTuvjOBLo3DHZpeW
 hsc1LQmWC+2itoLwLxsCs//8PX9oYz8lAyOhnPoSfNAd9vWYRBhMZPtne38Ad8cv/z
 1JMGdPs787IS1xHXMqtrXUQQJsRYytCT5sImiuxqU0oJb5SwLabiEzTvGEOixjPKLx
 S4WxWTarrCY1g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: Sort DH STM32 DHCOM DTSI
Date: Mon, 21 Oct 2024 22:00:21 +0200
Message-ID: <20241021200034.204305-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Sort the DTSI alphabetically. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi | 50 +++++++++++-----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
index 0d9b2201e90..4c334e4cd7a 100644
--- a/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
+++ b/arch/arm/dts/stm32mp15xx-dhcom-u-boot.dtsi
@@ -12,6 +12,7 @@
 
 / {
 	aliases {
+		eeprom0 = &eeprom0;
 		i2c1 = &i2c2;
 		i2c3 = &i2c4;
 		i2c4 = &i2c5;
@@ -19,15 +20,14 @@
 		mmc1 = &sdmmc2;
 		spi0 = &qspi;
 		usb0 = &usbotg_hs;
-		eeprom0 = &eeprom0;
 	};
 
 	config {
-		u-boot,boot-led = "heartbeat";
-		u-boot,error-led = "error";
-		dh,som-coding-gpios = <&gpiof 12 0>, <&gpiof 13 0>, <&gpiof 15 0>;
 		dh,ddr3-coding-gpios = <&gpioz 6 0>, <&gpioz 7 0>;
 		dh,mac-coding-gpios = <&gpioc 3 0>;
+		dh,som-coding-gpios = <&gpiof 12 0>, <&gpiof 13 0>, <&gpiof 15 0>;
+		u-boot,boot-led = "heartbeat";
+		u-boot,error-led = "error";
 	};
 };
 
@@ -51,19 +51,6 @@
 	};
 };
 
-&phy0 {
-	/delete-property/ reset-gpios;
-};
-
-&pmic {
-	bootph-all;
-	bootph-pre-ram;
-
-	regulators {
-		bootph-pre-ram;
-	};
-};
-
 &flash0 {
 	bootph-pre-ram;
 
@@ -95,6 +82,19 @@
 	};
 };
 
+&phy0 {
+	/delete-property/ reset-gpios;
+};
+
+&pmic {
+	bootph-all;
+	bootph-pre-ram;
+
+	regulators {
+		bootph-pre-ram;
+	};
+};
+
 &qspi {
 	bootph-pre-ram;
 };
@@ -241,6 +241,14 @@
 	};
 };
 
+&reg11 {
+	bootph-pre-ram;
+};
+
+&reg18 {
+	bootph-pre-ram;
+};
+
 &sdmmc1 {
 	bootph-pre-ram;
 	st,use-ckin;
@@ -303,14 +311,6 @@
 	};
 };
 
-&reg11 {
-	bootph-pre-ram;
-};
-
-&reg18 {
-	bootph-pre-ram;
-};
-
 &usb33 {
 	bootph-pre-ram;
 };
-- 
2.45.2

