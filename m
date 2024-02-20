Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA3FC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 247A588017;
	Tue, 20 Feb 2024 19:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EwP1bYXi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97C288012; Tue, 20 Feb 2024 19:29:41 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F7C787FFE
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 7F54922700;
 Tue, 20 Feb 2024 19:29:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708453772;
 bh=puvB1Obnz7pzmUtFvvxvoAKJ4LTi3qx4YxE8alfNcVY=; h=From:To:Subject;
 b=EwP1bYXiWbaI8D7c9B3NokpqOWgLbhSI/0lzvhdRkpSqSSEcin8Ol49OWtExilPpS
 ryOnasEu2J50Az33lX3XUYCLcKKFDbsPqy4E9fNEupdV9YpAzw52eWN5Q7WWE6JZOk
 bYk71V8PcjdGcAgE3LerA0gwxxUxT36OvGw6epSsPDLAUj9gbnzb6m9zcVwjzXV874
 NI0MDxWgcfSuo2VhHrBVgWwUeZvnk/JuWPINnBYIbC+Ll3ArmF2iYYja3cNYWpJzcG
 DEoXVVdqFgAdPxWbVKV4R0H+zH017D7qnHvRL5xQuruHO7b9shiCJ8lryxbUtLVybp
 EntzbJRNUwzNQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 4/7] arm: dts: Refactor device trees using "&{/aliases}"
 syntax
Date: Tue, 20 Feb 2024 19:29:23 +0100
Message-Id: <20240220182926.101161-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220182926.101161-1-francesco@dolcini.it>
References: <20240220182926.101161-1-francesco@dolcini.it>
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

