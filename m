Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D00FEE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 20:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4BE83B9D;
	Fri,  6 Feb 2026 21:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="WixoR/Co";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6778483B9D; Fri,  6 Feb 2026 21:55:47 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE4583A64
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 21:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=QQ1C7mJybbmGC57v8mxKE0+jQQdCAHGn41/9MHf7BtQ=; b=WixoR/CoYSa+IM+YsDM3oPvfv+
 nB7WGq5McAvPJT9yo8uo+exqb9nzWX792FN/WByXdAwNBKqfMI9uQ8C6obGV6IndgqM55/txmyR4N
 yGIgp+95YkZsaOTSDga6PalQr5Jg3KKYK0Fkg+oqyCnoh37IXfmvSgy6sIejrKb2B5d0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35962
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1voSrd-0001FX-Qx; Fri, 06 Feb 2026 15:55:42 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: hvilleneuve@dimonoff.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	hugo@hugovil.com
Date: Fri,  6 Feb 2026 15:55:24 -0500
Message-ID: <20260206205537.2906980-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206205537.2906980-1-hugo@hugovil.com>
References: <20260206205537.2906980-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH 1/6] arm: dts: imx8mn-var-som: Move SOM-specific nodes to SOM
 u-boot.dtsi
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move SOM-specific stuff into a new SOM u-boot.dtsi file.
This way, it can be used by multiple boards.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../dts/imx8mn-var-som-symphony-u-boot.dtsi   | 63 +------------------
 ...u-boot.dtsi => imx8mn-var-som-u-boot.dtsi} | 39 +++---------
 2 files changed, 9 insertions(+), 93 deletions(-)
 copy arch/arm/dts/{imx8mn-var-som-symphony-u-boot.dtsi => imx8mn-var-som-u-boot.dtsi} (75%)

diff --git a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi b/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
index 2bbc4a49418..a94a571df5e 100644
--- a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
@@ -3,52 +3,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 
-#include "imx8mn-u-boot.dtsi"
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
-	bootph-pre-ram;
-};
-
-&{/soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators} {
-	bootph-pre-ram;
-};
-
-&eeprom_som {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	eth_mac_address: eth-mac-address@19 {
-		reg = <0x19 0x06>;
-	};
-};
-
-&fec1 {
-	nvmem-cells = <&eth_mac_address>;
-	nvmem-cell-names = "mac-address";
-};
-
-&gpio1 {
-	bootph-pre-ram;
-};
-
-&gpio2 {
-	bootph-pre-ram;
-};
-
-&gpio4 {
-	bootph-pre-ram;
-};
-
-&i2c1 {
-	bootph-all;
-};
-
-&pinctrl_i2c1 {
-	bootph-all;
-};
-
-&pinctrl_pmic {
-	bootph-pre-ram;
-};
+#include "imx8mn-var-som-u-boot.dtsi"
 
 &pinctrl_reg_usdhc2_vmmc {
 	bootph-pre-ram;
@@ -62,14 +17,6 @@
 	bootph-pre-ram;
 };
 
-&pinctrl_usdhc3 {
-	bootph-pre-ram;
-};
-
-&pinctrl_wdog {
-	bootph-pre-ram;
-};
-
 &uart4 {
 	bootph-pre-ram;
 };
@@ -77,11 +24,3 @@
 &usdhc2 {
 	bootph-pre-ram;
 };
-
-&usdhc3 {
-	bootph-pre-ram;
-};
-
-&eeprom_som {
-	bootph-all;
-};
diff --git a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi b/arch/arm/dts/imx8mn-var-som-u-boot.dtsi
similarity index 75%
copy from arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
copy to arch/arm/dts/imx8mn-var-som-u-boot.dtsi
index 2bbc4a49418..c27ad08377e 100644
--- a/arch/arm/dts/imx8mn-var-som-symphony-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-var-som-u-boot.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2021 Collabora Ltd.
+ * Copyright 2025 Dimonoff
  */
 
 #include "imx8mn-u-boot.dtsi"
@@ -14,6 +14,7 @@
 };
 
 &eeprom_som {
+	bootph-all;
 	#address-cells = <1>;
 	#size-cells = <1>;
 	eth_mac_address: eth-mac-address@19 {
@@ -42,46 +43,22 @@
 	bootph-all;
 };
 
+&usdhc3 {
+	bootph-pre-ram;
+};
+
 &pinctrl_i2c1 {
 	bootph-all;
 };
 
-&pinctrl_pmic {
-	bootph-pre-ram;
-};
-
-&pinctrl_reg_usdhc2_vmmc {
-	bootph-pre-ram;
-};
-
-&pinctrl_uart4 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc2 {
-	bootph-pre-ram;
-};
-
-&pinctrl_usdhc3 {
-	bootph-pre-ram;
-};
-
 &pinctrl_wdog {
 	bootph-pre-ram;
 };
 
-&uart4 {
+&pinctrl_pmic {
 	bootph-pre-ram;
 };
 
-&usdhc2 {
+&pinctrl_usdhc3 {
 	bootph-pre-ram;
 };
-
-&usdhc3 {
-	bootph-pre-ram;
-};
-
-&eeprom_som {
-	bootph-all;
-};
-- 
2.47.3

