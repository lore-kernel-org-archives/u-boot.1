Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F18C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CD8288F1D;
	Thu, 25 Apr 2024 14:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eLFdNhjb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E7588EF0; Thu, 25 Apr 2024 14:21:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7FC88F23
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 54E7E6160D;
 Thu, 25 Apr 2024 12:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF897C113CE;
 Thu, 25 Apr 2024 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714047676;
 bh=rsYwkgDOfUqPuMVFzJYWdi7Fb2asENACPVuKGgQm/PU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=eLFdNhjbuBWw3ELC9zkx3X+4QD0oSVxGbujYDtQZkVU+f9pS0wt7++9R4DzxWvzR5
 SPVfEuMyjaWrcz5if9BWqFAQdZTeIdCqRhS3uKEpdYCciAKIMbE6IFVCk6Imx1vg7h
 Q6/vzq9ioC/DzFrg84XB8Fjht9pPfnnw5BYS+IrkB01fQR3I56MQMm2QHOvG0AfQYv
 hxlZ6mRG9lIYbV51oilQMeneawsDAOdpMcTd2ID7T4zFDZ2Fg0AhrFEq7mv04Rwq0z
 JtMi98UMOUnMXtKU7VU9gyj1gDS0tnJ0JPwCL6pvKeWbV4gwlxgMLdLyIkP1CAUhrY
 74zllT5bXe2rA==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 25 Apr 2024 15:20:54 +0300
Subject: [PATCH not-for-merge 3/3] arm: dts: k3-am625-beagleplay: Fix
 Ethernet PHY reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-for-2024-07-beagleplay-eth-v1-3-6c985de1c316@kernel.org>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
In-Reply-To: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2075; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=rsYwkgDOfUqPuMVFzJYWdi7Fb2asENACPVuKGgQm/PU=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmKkqsROpTRoHOSU361YbJ91XQFs+MAc+LBd9K0
 GkFMqRBywWJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZipKrAAKCRDSWmvTvnYw
 kw+hD/46/bfZ/fBHxVkCzOUp7QDDmgYku+BiEwGIlDNr2nnw3FHKmqaiSHpKbchqzKwU9P2D7ba
 NSFDI+BN7JJCJVpYl6lgPBkjK4KCJsiA+yCVYFFo/+r1ox9rXGHBheRxHQ9Nk73pjngFOnH2KNu
 3v6ioVTp5OkKfbghzheMvm1edJkxWoLV6g7o6euvqDhsw/GZ0WXn8F9wS1trFK+UuQDeQugH9b3
 m5bzbEzeNHQqKqiRlZTQy+bBjLNtBv5IWINPiaVxgfji1x8Frtolm9u9OGk5rmJUZb2JmtOgHWh
 3hEjCbXm5UTTeFnoQh3u5EijtQ87Siz/Rv+6lIb5cq/YX++NVDvbEvzImKnG7EhTGPdoPy7Zbjo
 QnH/2AtaR32/ThHEJlQI7EqTQpOifMb41j9d5VcLlxytfcNDWtN4oPS43Da551LfnbwTO7EudJG
 J0ZO+zYPF7Sq2Fa+HQe7l2Oppf56p7ztMzNEW6yhdqc+qHS/GUn//51bsap9LHHAIgM/ifYaCFH
 y5fbRmjpSx8+4gmWsTJkozro/U718S5fer7kum7bFXPk778E5x4tyEKpROXTeGGf7FJbyArwW42
 FjwmHs/THUqwZ9nTj0hiptDRZnXeLQjUjsKf3NE5xdxGIBh73yss/1c35wjDzxWv6S/XQToYjPL
 wEPkytr8aPCnlbQ==
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
index a34e0df2ab8..8ab838f1697 100644
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

