Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B2C48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 19:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE7E87C3E;
	Mon,  5 Feb 2024 20:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CFC8798F; Mon,  5 Feb 2024 20:09:11 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FBDC87AEC
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 20:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rX4Ky-00BXW2-WC;
 Mon, 05 Feb 2024 19:09:01 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/5] arm: dts: imx8mm-venice-gw7901: add digital I/O direction
 control GPIO's
Date: Mon,  5 Feb 2024 11:08:54 -0800
Message-Id: <20240205190858.3076363-2-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205190858.3076363-1-tharvey@gateworks.com>
References: <20240205190858.3076363-1-tharvey@gateworks.com>
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

The GW7901 has GPIO's to configure the direction of its isolated
digital I/O signals. Add the GPIO pinmux, line names, and hog
configuration.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi | 14 ++++++++++++++
 arch/arm/dts/imx8mm-venice-gw7901.dts         |  4 +++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi
index e68030e7b22c..9fa21942c0c6 100644
--- a/arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw7901-u-boot.dtsi
@@ -43,6 +43,20 @@
 };
 
 &gpio4 {
+	dig1ctl {
+		gpio-hog;
+		output-low;
+		gpios = <4 GPIO_ACTIVE_HIGH>;
+		line-name = "dig1_ctl";
+	};
+
+	dig2ctl {
+		gpio-hog;
+		output-low;
+		gpios = <5 GPIO_ACTIVE_HIGH>;
+		line-name = "dig2_ctl";
+	};
+
 	uart3_rs232 {
 		gpio-hog;
 		output-high;
diff --git a/arch/arm/dts/imx8mm-venice-gw7901.dts b/arch/arm/dts/imx8mm-venice-gw7901.dts
index 826627bd4503..ec8d80b76aee 100644
--- a/arch/arm/dts/imx8mm-venice-gw7901.dts
+++ b/arch/arm/dts/imx8mm-venice-gw7901.dts
@@ -303,7 +303,7 @@
 
 &gpio4 {
 	gpio-line-names = "", "", "", "",
-		"", "", "uart3_rs232#", "uart3_rs422#",
+		"dig1_ctl", "dig2_ctl", "uart3_rs232#", "uart3_rs422#",
 		"uart3_rs485#", "", "", "", "", "", "", "",
 		"", "", "", "", "", "", "", "",
 		"", "", "", "uart4_rs485#", "", "sim1det#", "sim2det#", "";
@@ -820,6 +820,8 @@
 
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
+			MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4	0x40000041 /* DIG1_CTL */
+			MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5	0x40000041 /* DIG2_CTL */
 			MX8MM_IOMUXC_SPDIF_TX_GPIO5_IO3		0x40000041 /* DIG2_OUT */
 			MX8MM_IOMUXC_SPDIF_RX_GPIO5_IO4		0x40000041 /* DIG2_IN */
 			MX8MM_IOMUXC_GPIO1_IO06_GPIO1_IO6	0x40000041 /* DIG1_IN */
-- 
2.25.1

