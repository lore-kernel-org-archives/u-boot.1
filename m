Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C24C54E64
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 16:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A4687EAF;
	Mon, 25 Mar 2024 17:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2D7387F33; Mon, 25 Mar 2024 17:27:27 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1233487C40
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 17:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1ronAS-0033ho-9n;
 Mon, 25 Mar 2024 16:27:24 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm: dts: imx8m*-venice-gw72xx: add TPM device
Date: Mon, 25 Mar 2024 09:27:22 -0700
Message-Id: <20240325162722.1350593-1-tharvey@gateworks.com>
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

The GW71xx baseboard has a TPM that defined in the upstream dt however
we need to ensure the GPIO reset line is de-asserted which we do in boot
firmware with a gpio hog.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi | 7 +++++++
 arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi b/arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi
index b3592331c72b..07789c8d8835 100644
--- a/arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-venice-gw71xx-0x-u-boot.dtsi
@@ -25,6 +25,13 @@
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
diff --git a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
index 5c33f8c9cdcf..216a7a0d8d7c 100644
--- a/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-venice-gw71xx-2x-u-boot.dtsi
@@ -4,6 +4,15 @@
  */
 #include "imx8mp-venice-gw702x-u-boot.dtsi"
 
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
-- 
2.25.1

