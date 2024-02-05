Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE5C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 19:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E964287BFC;
	Mon,  5 Feb 2024 20:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B282879AF; Mon,  5 Feb 2024 20:09:11 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C4387B7F
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 20:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rX4Kz-00BXW2-Fy;
 Mon, 05 Feb 2024 19:09:01 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 2/5] arm: dts: imx8mm-venice-gw7901: add TPM device
Date: Mon,  5 Feb 2024 11:08:55 -0800
Message-Id: <20240205190858.3076363-3-tharvey@gateworks.com>
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

Add the TPM device found on the GW7901 revision D PCB.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/dts/imx8mm-venice-gw7901.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/imx8mm-venice-gw7901.dts b/arch/arm/dts/imx8mm-venice-gw7901.dts
index ec8d80b76aee..9c1d68f2b741 100644
--- a/arch/arm/dts/imx8mm-venice-gw7901.dts
+++ b/arch/arm/dts/imx8mm-venice-gw7901.dts
@@ -269,7 +269,8 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi1>;
-	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>,
+		   <&gpio4 24 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	flash@0 {
@@ -278,6 +279,12 @@
 		spi-max-frequency = <40000000>;
 		status = "okay";
 	};
+
+	tpm@1 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		spi-max-frequency = <36000000>;
+	};
 };
 
 &fec1 {
@@ -967,6 +974,7 @@
 			MX8MM_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x82
 			MX8MM_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x82
 			MX8MM_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x140
+			MX8MM_IOMUXC_SAI2_TXFS_GPIO4_IO24	0x140
 		>;
 	};
 
-- 
2.25.1

