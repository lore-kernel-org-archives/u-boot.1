Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72002C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB48D87548;
	Mon, 27 Nov 2023 20:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0010A876BC; Mon, 27 Nov 2023 20:37:04 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9454187538
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1r7hPg-00AzoS-Ar; Mon, 27 Nov 2023 19:37:00 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm: dts: imx8mm-venice-gw72xx: add TPM device
Date: Mon, 27 Nov 2023 11:36:58 -0800
Message-Id: <20231127193658.685119-1-tharvey@gateworks.com>
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

Add the TPM device found on the GW72xx revision F PCB.

This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi |  7 +++++++
 arch/arm/dts/imx8mm-venice-gw72xx.dtsi           | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi
index 92e44d4ba96b..31f9d47bced8 100644
--- a/arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw72xx-0x-u-boot.dtsi
@@ -39,6 +39,13 @@
 		gpios = <9 GPIO_ACTIVE_HIGH>;
 		line-name = "dio1";
 	};
+
+	tpm_rst {
+		gpio-hog;
+		output-high;
+		gpios = <11 GPIO_ACTIVE_HIGH>;
+		line-name = "tpm_rst#";
+	};
 };
 
 &gpio4 {
diff --git a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
index 41d0de6a7027..97ed34a3c586 100644
--- a/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw72xx.dtsi
@@ -84,8 +84,15 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi2>;
-	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>,
+		   <&gpio1 10 GPIO_ACTIVE_LOW>;
 	status = "okay";
+
+	tpm@1 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		spi-max-frequency = <36000000>;
+	};
 };
 
 &gpio1 {
@@ -314,6 +321,7 @@
 			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0xd6
 			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0xd6
 			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0xd6
+			MX8MM_IOMUXC_GPIO1_IO10_GPIO1_IO10	0xd6
 		>;
 	};
 
-- 
2.25.1

