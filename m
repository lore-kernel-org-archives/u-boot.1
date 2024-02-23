Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4F1C48BC4
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2AA887C7F;
	Fri, 23 Feb 2024 10:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="O8l1xtMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D545879FC; Fri, 23 Feb 2024 10:13:29 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6D387C92
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 007CE215BF;
 Fri, 23 Feb 2024 10:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708679519;
 bh=IEMNHV49DMqNn5fMQSDvHZjTWFC6L37YJXzdFfoi1eM=; h=From:To:Subject;
 b=O8l1xtMMsXEeaO1d+4+eNXvJf2+A1sD2w31zKY37rmn3is3ZTZyH/BRqf21panpwB
 TbCPLUAfjvS/f8JP/npkza750nFE7i76VPXBHbCldsWxXyrxOgpPl99sybxn5btfSX
 C5++GE/iVh3sUDZTkvltTrIb1ZOa5PVabkaaIn6uga91WKA2PlOJxgget2p7FVqtc6
 a/rG08gHM6cfekzEbqODVYsXbTaqZs55dqR43UCmAPHEG+IOgE1/OgLOPqDjcKMt6T
 SHo13pCJs4PEZPA1UUPS8tl9YH5vQuhe1f8p2PHJxKZ9jcdvK6YFIbywG31MqMq+22
 /sgQC/+fJM0vg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 4/7] arm: dts: Refactor device trees using "&{/aliases}"
 syntax
Date: Fri, 23 Feb 2024 10:11:40 +0100
Message-Id: <20240223091143.9561-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
References: <20240223091143.9561-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Use the common syntax to define aliases.

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com> # Verdin iMX8M Plus
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../dts/imx6dl-colibri-eval-v3-u-boot.dtsi    | 18 ++++++++-----
 arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi    | 26 ++++++++++---------
 .../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi | 10 ++++---
 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    | 12 ++++-----
 .../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    | 12 ++++-----
 5 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
index 31f3a48dd9f0..0eea4d1862ae 100644
--- a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
@@ -5,13 +5,17 @@
 
 #include "imx6qdl-u-boot.dtsi"
 
-&{/aliases} {
-	/* U-Boot won't find PMIC otherwise */
-	i2c0 = &i2c3;
-	i2c1 = &i2c2;
-	/* SDHCI instance order: eMMC, 4-bit SD/MMC (U-Boot won't find ConfigBlock otherwise) */
-	mmc0 = &usdhc3;
-	mmc1 = &usdhc1;
+/ {
+	aliases {
+		/* U-Boot won't find PMIC otherwise */
+		i2c0 = &i2c3;
+		i2c1 = &i2c2;
+		/* SDHCI instance order: eMMC, 4-bit SD/MMC
+		 * (U-Boot won't find ConfigBlock otherwise)
+		 */
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc1;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
index 3d19796cb698..3c6e503d043b 100644
--- a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
+++ b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
@@ -5,18 +5,20 @@
 
 #include "imx6qdl-u-boot.dtsi"
 
-&{/aliases} {
-	/* U-Boot won't find PMIC otherwise */
-	i2c0 = &i2c1;
-	i2c1 = &i2c2;
-	i2c2 = &i2c3;
-	/*
-	 * SDHCI instance order: eMMC, 8-bit SD/MMC, 4-bit SD
-	 * (U-Boot won't find ConfigBlock otherwise)
-	 */
-	mmc0 = &usdhc3;
-	mmc1 = &usdhc1;
-	mmc2 = &usdhc2;
+/ {
+	aliases {
+		/* U-Boot won't find PMIC otherwise */
+		i2c0 = &i2c1;
+		i2c1 = &i2c2;
+		i2c2 = &i2c3;
+		/*
+		 * SDHCI instance order: eMMC, 8-bit SD/MMC, 4-bit SD
+		 * (U-Boot won't find ConfigBlock otherwise)
+		 */
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc1;
+		mmc2 = &usdhc2;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
index 57ca28edb70d..b2c12a413daf 100644
--- a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
@@ -5,10 +5,12 @@
 
 #include "imx7s-u-boot.dtsi"
 
-&{/aliases} {
-	/* SDHCI instance order: eMMC, SD/MMC */
-	mmc0 = &usdhc3;
-	mmc1 = &usdhc1;
+/ {
+	aliases {
+		/* SDHCI instance order: eMMC, SD/MMC */
+		mmc0 = &usdhc3;
+		mmc1 = &usdhc1;
+	};
 };
 
 &lcdif {
diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 8efa4ddc734a..515f195ab759 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -6,6 +6,12 @@
 #include "imx8mm-u-boot.dtsi"
 
 / {
+	aliases {
+		eeprom0 = &eeprom_module;
+		eeprom1 = &eeprom_carrier_board;
+		eeprom2 = &eeprom_display_adapter;
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
@@ -13,12 +19,6 @@
 	};
 };
 
-&{/aliases} {
-	eeprom0 = &eeprom_module;
-	eeprom1 = &eeprom_carrier_board;
-	eeprom2 = &eeprom_display_adapter;
-};
-
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@25} {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 2a1aa1935a76..67f1d45ce269 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -6,6 +6,12 @@
 #include "imx8mp-u-boot.dtsi"
 
 / {
+	aliases {
+		eeprom0 = &eeprom_module;
+		eeprom1 = &eeprom_carrier_board;
+		eeprom2 = &eeprom_display_adapter;
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
@@ -13,12 +19,6 @@
 	};
 };
 
-&{/aliases} {
-	eeprom0 = &eeprom_module;
-	eeprom1 = &eeprom_carrier_board;
-	eeprom2 = &eeprom_display_adapter;
-};
-
 &clk {
 	bootph-all;
 	bootph-pre-ram;
-- 
2.39.2

