Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A683C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 057E78805D;
	Tue,  5 Mar 2024 14:25:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nQdE/+Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFEC987FA5; Tue,  5 Mar 2024 14:25:28 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB528806B
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AE311CE1AA9;
 Tue,  5 Mar 2024 13:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC203C43390;
 Tue,  5 Mar 2024 13:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709645122;
 bh=Ht0e+X/bmW++Yud63Et2Akjy++EfvUbLhkblbeqApVo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=nQdE/+TjjNor8QSwg+gsLCBw8tYEHHiAegqtEIP1DlQh86kGpJTrdHXcUsZ1XBUmv
 zS33zNL1+pq0TMsvEMpKYgNZkLAO6D3RZ/5oX++EXULg15X6D44u5fKndBaN36kDhx
 vvZeu+lk72DjQI8MLxvXmOTzOM5xG3f7lDVOuy+kjC+Or5cj/MMr6CUeGLdU7gnDbd
 E93dZNtQAFEKen1yc5/JgsaT/cX4Xnm95usDsbdQR2AwJwIkLBxxji7x8P5Uj6sS/9
 6AoJDGL5fGGFdzIpkB0Z4kINbUVQtfK4zCAm/k0iCrlKvkq2vent24wvUVkntpQcG/
 MH9jDQAq/FI4A==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 05 Mar 2024 15:24:57 +0200
Subject: [PATCH not-for-merge 5/5] arm: dts: k3-am625-beagleplay: Fix
 Ethernet PHY reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-for-2024-07-beagleplay-eth-v1-5-e1294a575cc1@kernel.org>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
In-Reply-To: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=Ht0e+X/bmW++Yud63Et2Akjy++EfvUbLhkblbeqApVo=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBl5x0rv71po08omtsqO3Ub9ZCrsWGNBrpMdodJ4
 lfb0kpJN4iJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZecdKwAKCRDSWmvTvnYw
 k0hxEACPH5i7DFlnbsfXxT2VSbYb8VjwXhnBNsbx4fdkrw39g7EjDCwtCcyvRoNocdQyZXWNVos
 2SWjRsEdLVIb6TissdHe3HYmZMefBYWZCVPtjGxisq1KT83StuM3i5pedRx/15tpN7913bym5nq
 FJXMkcftchVwhZDb25Iy64NEdlfSRKNzhnVlJb4fistkNsH7NXUsaWnLSj/BySX59d57eDV1zGX
 cQ6k31myF8Sr2RG7WQ3FZiEXAhKTbAdv56QZRaLEzrI1T2K29XmcdmSNxr1kNFFkicBrySqDT8X
 rUzOBCDq7roE+tTKAumc00H1lyfODfUpUSn8VRuBaBrxW6p7cA98PPKC+nXT874FbT0LRaVeqUL
 0Z7bsEM1jw4T/m2rdUc3KZFrmBa6jhPPJCHqAVuBXEMZoa7Q6GEFCYlrZyD4wudT0iSnBXygr/Z
 uZ/nLRYyaa46xfEokrHzSgwRUI0eukZwVszAbz3tu8xJ/2yy5/J2sgMDACndmu5VTopiwprrZXL
 zXy/GYU27JynQ6ACmyAMYPbXIbDmLvokZZkB9Ne7sZCAm+T4NkXik/PwmakrVFPbGNgA06AKA3A
 eZ7SgwKcMkX6kfAaAH4BxcsqLZJcu5Bzz70cYQTKbHbPLenWAjCg3+Wy87bozerxOuDxD4TzBXc
 x+B9agVVWbX+jJw==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

Move GPIO pinmux to MDIO node. Add GB Ethernet reset GPIO.

Add PIN_INPUT to Fix SPE ethernet reset gpio so that
reading the GPIO can give correct status.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/dts/k3-am625-beagleplay.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay.dts b/arch/arm/dts/k3-am625-beagleplay.dts
index a34e0df2ab..8ab838f169 100644
--- a/arch/arm/dts/k3-am625-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-beagleplay.dts
@@ -292,6 +292,8 @@
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AD24) MDIO0_MDC */
 			AM62X_IOPAD(0x015c, PIN_INPUT, 0) /* (AB22) MDIO0_MDIO */
+			AM62X_IOPAD(0x003c, PIN_INPUT, 7) /* (M25) GPMC0_AD0.GPIO0_15 */
+			AM62X_IOPAD(0x018c, PIN_INPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
 		>;
 	};
 
@@ -383,7 +385,6 @@
 			AM62X_IOPAD(0x016c, PIN_INPUT, 1) /* (Y18) RGMII2_TD0.RMII2_TXD0 */
 			AM62X_IOPAD(0x0170, PIN_INPUT, 1) /* (AA18) RGMII2_TD1.RMII2_TXD1 */
 			AM62X_IOPAD(0x0164, PIN_INPUT, 1) /* (AA19) RGMII2_TX_CTL.RMII2_TX_EN */
-			AM62X_IOPAD(0x018c, PIN_OUTPUT, 7) /* (AC21) RGMII2_RD2.GPIO1_5 */
 			AM62X_IOPAD(0x0190, PIN_INPUT, 7) /* (AE22) RGMII2_RD3.GPIO1_6 */
 			AM62X_IOPAD(0x01f0, PIN_OUTPUT, 5) /* (A18) EXT_REFCLK1.CLKOUT0 */
 		>;
@@ -597,6 +598,9 @@
 
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
+		reset-gpios = <&main_gpio0 15 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <10000>;
+		reset-deassert-us = <50000>;
 	};
 
 	cpsw3g_phy1: ethernet-phy@1 {
@@ -615,7 +619,7 @@
 		"USR0", "USR1", "USR2", "USR3", "", "", "USR4",	/* 3-9 */
 		"EEPROM_WP",					/* 10 */
 		"CSI2_CAMERA_GPIO1", "CSI2_CAMERA_GPIO2",	/* 11-12 */
-		"CC1352P7_BOOT", "CC1352P7_RSTN", "", "", "",	/* 13-17 */
+		"CC1352P7_BOOT", "CC1352P7_RSTN", "GBE_RSTN", "", "",	/* 13-17 */
 		"USR_BUTTON", "", "", "", "", "", "", "", "",	/* 18-26 */
 		"", "", "", "", "", "", "", "", "", "HDMI_INT",	/* 27-36 */
 		"", "VDD_WLAN_EN", "", "", "WL_IRQ", "GBE_INTN",/* 37-42 */

-- 
2.34.1

