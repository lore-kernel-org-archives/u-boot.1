Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC072CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3193787019;
	Wed, 18 Oct 2023 20:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAD3586D94; Wed, 18 Oct 2023 20:34:10 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E552887030
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1qtBMg-009obO-W6; Wed, 18 Oct 2023 18:33:55 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm: dts: imx8mp-venice-gw73xx: add TPM device
Date: Wed, 18 Oct 2023 11:33:52 -0700
Message-Id: <20231018183352.2168191-1-tharvey@gateworks.com>
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

Add the TPM device found on the GW73xx revision F PCB.

This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi | 9 +++++++++
 arch/arm/dts/imx8mp-venice-gw73xx.dtsi           | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
index 70433c073293..4d0e9a1e67c5 100644
--- a/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw73xx-2x-u-boot.dtsi
@@ -10,6 +10,15 @@
 	reset-post-delay-us = <300000>;
 };
 
+&gpio1 {
+	tpm_rst {
+		gpio-hog;
+		output-high;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
+	};
+};
+
 &gpio4 {
 	dio_1 {
 		gpio-hog;
diff --git a/arch/arm/dts/imx8mp-venice-gw73xx.dtsi b/arch/arm/dts/imx8mp-venice-gw73xx.dtsi
index 1c05398c862c..88c3c006fa20 100644
--- a/arch/arm/dts/imx8mp-venice-gw73xx.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw73xx.dtsi
@@ -95,8 +95,14 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>,
+		   <&gpio1 10 GPIO_ACTIVE_LOW>;
 	status = "okay";
+	tpm@1 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		spi-max-frequency = <36000000>;
+	};
 };
 
 &gpio4 {
@@ -327,6 +333,7 @@
 			MX8MP_IOMUXC_ECSPI2_MOSI__ECSPI2_MOSI	0x140
 			MX8MP_IOMUXC_ECSPI2_MISO__ECSPI2_MISO	0x140
 			MX8MP_IOMUXC_ECSPI2_SS0__GPIO5_IO13	0x140
+			MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10	0x140
 		>;
 	};
 
-- 
2.25.1

