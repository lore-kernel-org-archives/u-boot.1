Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04DC25B75
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 12:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A94388339;
	Mon, 13 May 2024 14:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="La8ssV/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E8C2882ED; Mon, 13 May 2024 14:14:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFD688275
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 14:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DF4E660DBC;
 Mon, 13 May 2024 12:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58754C113CC;
 Mon, 13 May 2024 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715602464;
 bh=pASTJCKMR/YR+bPypX4mdEU8wHRfa9QUOmy81C6YsGw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=La8ssV/XIh/PiveTB/OJLKLCy/jnO2E/lH51RchTARqkwrrI/j+mnC4lAe4l9dROf
 FSyMRVaIL9KFN7IzGLUx/t/kVeIkLfSM90PLcZcO09B6wei0nYtsmK671JaUZZ9xSo
 Rl6FaWH03K2Xf4ba0NSAAMLsq3uE16zbJDwXpPFGU3anCs3oTMWMwjAC81AMSlGOI7
 XXvfqp26s592qTiTnFb+QmGkL1LRiM4VaL4pQgDu6cGW7lT/PDDcQdD0omDTsOTqBf
 bFMN4Y+IkKD5b03B8AUpWWcCcyWNQwvVLZF2nTEsOqzMf5GRXYkDUphojbHQfxFl+B
 /SjzA3MoeVVBQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Mon, 13 May 2024 15:13:56 +0300
Subject: [PATCH v2 3/3] arm: dts: k3-am625-beagleplay: Fix Ethernet PHY
 reset GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-for-2024-07-beagleplay-eth-v2-3-a9bf457c3bb8@kernel.org>
References: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
In-Reply-To: <20240513-for-2024-07-beagleplay-eth-v2-0-a9bf457c3bb8@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>
Cc: srk@ti.com, s-vadapalli@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, 
 danishanwar@ti.com, u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=pASTJCKMR/YR+bPypX4mdEU8wHRfa9QUOmy81C6YsGw=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmQgQRvD0+tBhX21zs81gQHhZF6idw7MWicpdkK
 wA0F7In/wWJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZkIEEQAKCRDSWmvTvnYw
 k2DgEAC1qzt819RL/GAq0JHKwON4aJPtIhdq45ax0hQBqmxQj2G/ZXVbPZLTwgmswWptQaU6INZ
 kYKxZF6I/y2TEi+SDF3yvaN4v4bYqO/nybewm8EicGlmgRmHx4D2zEYq8mRZA+VILZWF+iMcPSZ
 TTsi4qyjH/M4dHGMWV12puFTRZfFmWku2jYwir587gOSVdIRQJZevbV5VdTDGkl3whhG4HK9323
 6rv2Ly9evPG0E78RyZSiQYQAm0thb0CG22G9btmVCXT90qOQftksQMwDr7iQGL35R2K043ome1n
 4ph7xubqAO1hXV5JwyZoGgYszLQ2m0SYprv98lv2GxrzraQqiGqoNwU7NTJUS67HnFaFRi5LEZM
 iOnbAPKo2SWxZcxGMdI8ANm7+5FYaEiIJFpRlPfMQDFf35IVEbFQDdKq6zqWEfVjZFB8WrZCCbC
 oH2/J7/2YzzaWoXFplqGmtDqDJEH/SXkeuryjYOoSslW/c0fZUjvObdyyScQA8Aw7/t9ACyBo6U
 +i6pYD5Zr/zdPCrxwWUDA0DFrFOtUtfmws+F4J1EJfAs0gGpeUh3CNUQUJuhS2i3uZi+lz4Oq1I
 lMRU987RMhg+kpeyT3zy7RIE8WaTyo2W1K+1dOZ7p1nqw/STSStHFDEQRxv3s83339RkZFzU++a
 od4S++ssDtEFePA==
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
Commit 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40 on linux-next
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

