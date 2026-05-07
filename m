Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D540CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 17:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EEE84B8D;
	Thu,  7 May 2026 19:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bBg9zuIV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W4kmWKK9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF24A84BD4; Thu,  7 May 2026 19:38:16 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DAD484B58
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 19:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBKGV3sbnz9v9m;
 Thu,  7 May 2026 19:38:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778175490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPBQuQ7RA2Yei4knsSjtPQ5r9UBmCx/lKn8q+eLhuHc=;
 b=bBg9zuIV+QzIO+YJ54EywZ7Wp75FRSfyw6FBfBf1VlUF7jNEnSjMlUl58dL3+IyGASk+x3
 aRA82gQi1cVWE5eqEVxTAPhj5mlPiFMMWWHZJpc+Gps0WOCZq8ne/Y6bWjpBUzwzVcZq5I
 uPK66tCk0kpl57UirISickzW/uhduKGmlQ0XzFlZDO2zFN7PlEXHUi50Ja9xByoF62SBDH
 Y2lmCSqRS/KDqG7hRh/rXKAvUdN0I2A2+sgaDIpvD0NY6F3HXNM842pS0uLdc+0mZred0W
 qQorZopy7CUD2yymrfbBdxAthpIUZceHMHb+mb4I2viTXybD/qmgTSsCMao9/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778175488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zPBQuQ7RA2Yei4knsSjtPQ5r9UBmCx/lKn8q+eLhuHc=;
 b=W4kmWKK99sreBO8Re+3U25j8E8JNuPL37LOFTPmKbpJMm+hO51LLlC84N2TdvbT42+hL4H
 0LkW6lTDoQzaR/WBZg3rDg0nVwjXsc6P1luVS9OEyya49O9U5QLn9rRWpHmee4B6Xe8Arv
 nnAUs1A1d0Nrp+umMJm+DULYqYDxkEZDlXuxOKE83c+EDX7BktyyuKalQCK30e8bBAgckk
 NX9WTNSrgyDAnOPNZDVgE4F4hS4z9xF90r3EnxvbqCRh21p9UsCrd99bIhZ9/lmXNI5B5S
 hHwuro51dIWZ1tAle/a0euq0vpXLE5YDEHOvU618rAk7c1n0fHzd+g+TsHeV5g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Khanh Le <khanh.le.xr@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] arm64: dts: renesas: Switch to upstream DT on Renesas
 R-Car X5H R8A78000
Date: Thu,  7 May 2026 19:37:48 +0200
Message-ID: <20260507173802.61639-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: cu7rchizncnfqxwydt495g587izp6xky
X-MBO-RS-ID: 1e506f0fca5a6501f25
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

Enable OF_UPSTREAM to use upstream Linux kernel DT source as a base
for U-Boot control DT. Retain currently present parts of the DT which
are not yet part of upstream Linux kernel DT in -u-boot.dtsi files
until they get replaced by upstream equivalents. Add renesas/ prefix
to the DEFAULT_DEVICE_TREE as part of the switch.

Unused i2c2..i2c8 nodes have been removed, and will become available
once upstream Linux kernel DT adds those nodes.

The DRAM_RSV_SIZE has been updated to cover first 518 MiB of DRAM,
which are reserved for firmware and other use.

Note that all DT parts in -u-boot.dtsi are not considered stable DT
bindings and may change before they land in Linux kernel and become
stable DT ABI.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Khanh Le <khanh.le.xr@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/Makefile                      |    7 -
 arch/arm/dts/r8a78000-ironhide-u-boot.dtsi |  174 +++
 arch/arm/dts/r8a78000-ironhide.dts         |  257 -----
 arch/arm/dts/r8a78000-u-boot.dtsi          |  375 +++++--
 arch/arm/dts/r8a78000.dtsi                 | 1164 --------------------
 configs/r8a78000_ironhide_defconfig        |    3 +-
 include/configs/rcar-gen5-common.h         |    2 +-
 7 files changed, 481 insertions(+), 1501 deletions(-)
 delete mode 100644 arch/arm/dts/r8a78000-ironhide.dts
 delete mode 100644 arch/arm/dts/r8a78000.dtsi

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index e79cfb4b633..b32e919c63a 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -906,13 +906,6 @@ dtb-$(CONFIG_RZA1) += \
 	r7s72100-genmai.dtb \
 	r7s72100-gr-peach.dtb
 
-dtb-$(CONFIG_RCAR_GEN5) += \
-	r8a78000-ironhide.dtb
-
-ifdef CONFIG_RCAR_GEN5
-DTC_FLAGS += -R 4 -p 0x1000
-endif
-
 dtb-$(CONFIG_TARGET_AT91SAM9261EK) += at91sam9261ek.dtb
 
 dtb-$(CONFIG_TARGET_PM9261) += at91sam9261ek.dtb
diff --git a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
index 9c72f3e55f4..eebad1281fc 100644
--- a/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-ironhide-u-boot.dtsi
@@ -5,4 +5,178 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/net/ti-dp83869.h>
 #include "r8a78000-u-boot.dtsi"
+
+/ {
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		mmc0 = &mmc0;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
+&eth_pcs {
+	phys = <&mp_phy 2 1>;
+	status = "okay";
+};
+
+&hscif0 {
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&mmc0 {
+	pinctrl-0 = <&mmc0_pins>;
+	pinctrl-1 = <&mmc0_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	bus-width = <8>;
+	full-pwr-cycle-in-suspend;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+
+	status = "okay";
+};
+
+&mp_phy {
+	status = "okay";
+};
+
+&pfc {
+	pinctrl-0 = <&scif_clk_pins>;
+	pinctrl-names = "default";
+
+	eth25g2_pins: eth25g2 {
+		groups = "eth25g2_mdio", "eth25g2_link", "eth25g2_phyint";
+		function = "eth25g2";
+		drive-strength = <24>;
+	};
+
+	ethes0_pins: ethes0 {
+		groups = "ethes0_match", "ethes0_capture", "ethes0_pps";
+		function = "ethes0";
+		drive-strength = <24>;
+	};
+
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
+	i2c0_pins: i2c0 {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	i2c1_pins: i2c1 {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
+	mmc0_pins: mmc0 {
+		groups = "mmc0_data8", "mmc0_ctrl", "mmc0_ds";
+		function = "mmc0";
+		drive-strength = <24>;
+	};
+
+	rsw3_pins: rsw3 {
+		groups = "rsw3_match", "rsw3_capture", "rsw3_pps";
+		function = "rsw3";
+		drive-strength = <24>;
+	};
+
+	scif_clk_pins: scif-clk {
+		groups = "scif_clk";
+		function = "scif_clk";
+	};
+};
+
+&rswitch3 {
+	pinctrl-0 = <&rsw3_pins>, <&eth25g2_pins>, <&ethes0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ethernet-ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * NOTE: Only port@4 is configured for R-Car X5H board.
+		 * Other ports (0-3, 5-12) are currently unused or not
+		 * connected.
+		 */
+		port@4 {
+			reg = <4>;
+			renesas,connect_to_xpcs;
+			phy-handle = <&dp83869_phy>;
+			phy-mode = "sgmii";
+			phys = <&eth_pcs 5>;
+
+			mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dp83869_phy: ethernet-phy@2 {
+					reg = <2>;
+					ti,sgmii-interface;
+					ti,max-output-impedance;
+					ti,refclk-output-enable;
+					ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
+				};
+			};
+		};
+	};
+};
+
+&ufs0 {
+	status = "okay";
+};
+
+&ufs1 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/r8a78000-ironhide.dts b/arch/arm/dts/r8a78000-ironhide.dts
deleted file mode 100644
index 601f2740b54..00000000000
--- a/arch/arm/dts/r8a78000-ironhide.dts
+++ /dev/null
@@ -1,257 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-/*
- * Device Tree Source for the Ironhide board
- *
- * Copyright (C) 2025 Renesas Electronics Corp.
- */
-
-/dts-v1/;
-#include "r8a78000.dtsi"
-#include <dt-bindings/net/ti-dp83869.h>
-
-/ {
-	model = "Renesas Ironhide board based on r8a78000";
-	compatible = "renesas,ironhide", "renesas,r8a78000";
-
-	aliases {
-		i2c0 = &i2c0;
-		i2c1 = &i2c1;
-		i2c2 = &i2c2;
-		i2c3 = &i2c3;
-		i2c4 = &i2c4;
-		i2c5 = &i2c5;
-		i2c6 = &i2c6;
-		i2c7 = &i2c7;
-		i2c8 = &i2c8;
-		mmc0 = &mmc0;
-		serial0 = &hscif0;
-	};
-
-	chosen {
-		stdout-path = "serial0:1843200n8";
-	};
-
-	memory@40000000 {
-		device_type = "memory";
-		reg = <0x0 0x40000000 0x0 0x80000000>;
-	};
-
-	memory@1080000000 {
-		device_type = "memory";
-		reg = <0x10 0x80000000 0x0 0x80000000>;
-	};
-
-	memory@1200000000 {
-		device_type = "memory";
-		reg = <0x12 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1400000000 {
-		device_type = "memory";
-		reg = <0x14 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1600000000 {
-		device_type = "memory";
-		reg = <0x16 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1800000000 {
-		device_type = "memory";
-		reg = <0x18 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1a00000000 {
-		device_type = "memory";
-		reg = <0x1a 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1c00000000 {
-		device_type = "memory";
-		reg = <0x1c 0x00000000 0x1 0x00000000>;
-	};
-
-	memory@1e00000000 {
-		device_type = "memory";
-		reg = <0x1e 0x00000000 0x1 0x00000000>;
-	};
-
-	reg_1p8v: regulator-1p8v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	reg_3p3v: regulator-3p3v {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-};
-
-&extal_clk {
-	clock-frequency = <16666600>;
-};
-
-&extalr_clk {
-	clock-frequency = <32768>;
-};
-
-&hscif0 {
-	pinctrl-0 = <&hscif0_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-	status = "okay";
-};
-
-&i2c0 {
-	pinctrl-0 = <&i2c0_pins>;
-	pinctrl-names = "default";
-	clock-frequency = <400000>;
-	status = "okay";
-
-	eeprom@50 {
-		compatible = "rohm,br24g01", "atmel,24c01";
-		reg = <0x50>;
-		pagesize = <8>;
-	};
-};
-
-&i2c1 {
-	pinctrl-0 = <&i2c1_pins>;
-	pinctrl-names = "default";
-	clock-frequency = <400000>;
-	status = "okay";
-};
-
-&eth_pcs {
-	phys = <&mp_phy 2 1>;
-	status = "okay";
-};
-
-&mmc0 {
-	pinctrl-0 = <&mmc0_pins>;
-	pinctrl-1 = <&mmc0_pins>;
-	pinctrl-names = "default", "state_uhs";
-
-	bus-width = <8>;
-	full-pwr-cycle-in-suspend;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	no-sd;
-	no-sdio;
-	non-removable;
-
-	vmmc-supply = <&reg_3p3v>;
-	vqmmc-supply = <&reg_1p8v>;
-
-	status = "okay";
-};
-
-&ufs0 {
-	status = "okay";
-};
-
-&ufs1 {
-	status = "okay";
-};
-
-&mp_phy {
-	status = "okay";
-};
-
-&pfc {
-	pinctrl-0 = <&scif_clk_pins>;
-	pinctrl-names = "default";
-
-	eth25g2_pins: eth25g2 {
-		groups = "eth25g2_mdio", "eth25g2_link", "eth25g2_phyint";
-		function = "eth25g2";
-		drive-strength = <24>;
-	};
-
-	ethes0_pins: ethes0 {
-		groups = "ethes0_match", "ethes0_capture", "ethes0_pps";
-		function = "ethes0";
-		drive-strength = <24>;
-	};
-
-	hscif0_pins: hscif0 {
-		groups = "hscif0_data", "hscif0_ctrl";
-		function = "hscif0";
-	};
-
-	i2c0_pins: i2c0 {
-		groups = "i2c0";
-		function = "i2c0";
-	};
-
-	i2c1_pins: i2c1 {
-		groups = "i2c1";
-		function = "i2c1";
-	};
-
-	mmc0_pins: mmc0 {
-		groups = "mmc0_data8", "mmc0_ctrl", "mmc0_ds";
-		function = "mmc0";
-		drive-strength = <24>;
-	};
-
-	rsw3_pins: rsw3 {
-		groups = "rsw3_match", "rsw3_capture", "rsw3_pps";
-		function = "rsw3";
-		drive-strength = <24>;
-	};
-
-	scif_clk_pins: scif-clk {
-		groups = "scif_clk";
-		function = "scif_clk";
-	};
-};
-
-&rswitch3 {
-	pinctrl-0 = <&rsw3_pins>, <&eth25g2_pins>, <&ethes0_pins>;
-	pinctrl-names = "default";
-	status = "okay";
-
-	ethernet-ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/*
-		 * NOTE: Only port@4 is configured for R-Car X5H board.
-		 * Other ports (0-3, 5-12) are currently unused or not
-		 * connected.
-		 */
-		port@4 {
-			reg = <4>;
-			renesas,connect_to_xpcs;
-			phy-handle = <&dp83869_phy>;
-			phy-mode = "sgmii";
-			phys = <&eth_pcs 5>;
-
-			mdio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				dp83869_phy: ethernet-phy@2 {
-					reg = <2>;
-					ti,sgmii-interface;
-					ti,max-output-impedance;
-					ti,refclk-output-enable;
-					ti,clk-output-sel = <DP83869_CLK_O_SEL_REF_CLK>;
-				};
-			};
-		};
-	};
-};
-
-&scif_clk {
-	clock-frequency = <26000000>;
-};
diff --git a/arch/arm/dts/r8a78000-u-boot.dtsi b/arch/arm/dts/r8a78000-u-boot.dtsi
index 1bc73252430..5e29ad3df33 100644
--- a/arch/arm/dts/r8a78000-u-boot.dtsi
+++ b/arch/arm/dts/r8a78000-u-boot.dtsi
@@ -5,9 +5,41 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/clock/r8a78000-clock-scmi.h>
+#include <dt-bindings/power/r8a78000-power-scmi.h>
+#include <dt-bindings/reset/r8a78000-reset-scmi.h>
+
 / {
-	soc {
-		bootph-all;
+	firmware {
+		scmi {
+			compatible = "arm,scmi";
+			arm,poll-transport;
+			mbox-names = "tx", "rx";
+			mboxes = <&mailbox 0>, <&mailbox 1>;
+			shmem = <&cpu_scp_lpri0>, <&cpu_scp_hpri0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_devpd: protocol@11 {
+				reg = <0x11>;
+				#power-domain-cells = <1>;
+			};
+
+			scmi_clk: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
+		method = "smc";
 	};
 
 	/* Placeholder clock until the clock provider is in place */
@@ -38,10 +70,6 @@
 	};
 };
 
-&cpg {
-	bootph-all;
-};
-
 &extal_clk {
 	bootph-all;
 };
@@ -50,90 +78,297 @@
 	bootph-all;
 };
 
-&gpio0 {
-	clocks = <&clk_stub_gpio>;
+&prr {
+	bootph-all;
 };
 
-&gpio1 {
-	clocks = <&clk_stub_gpio>;
-};
+&soc {
+	bootph-all;
 
-&gpio2 {
-	clocks = <&clk_stub_gpio>;
-};
+	mailbox: mfis_mbox@18842000 {
+		compatible = "renesas,mfis-mbox";
+		#mbox-cells = <1>;
+		reg = <0 0x18842004 0 0x8>;
+		interrupts = <GIC_SPI 4362 IRQ_TYPE_LEVEL_HIGH>;
+	};
 
-&gpio3 {
-	clocks = <&clk_stub_gpio>;
-};
+	pfc: pinctrl@c0400000 {
+		compatible = "renesas,pfc-r8a78000";
+		reg = <0 0xc1080000 0 0x104>, <0 0xc1080800 0 0x104>,
+		      <0 0xc1081000 0 0x104>, <0 0xc0800000 0 0x104>,
+		      <0 0xc0800800 0 0x104>, <0 0xc0400000 0 0x104>,
+		      <0 0xc0400800 0 0x104>, <0 0xc0401000 0 0x104>,
+		      <0 0xc0401800 0 0x104>, <0 0xc9b00000 0 0x104>,
+		      <0 0xc9b00800 0 0x104>;
+	};
 
-&gpio4 {
-	clocks = <&clk_stub_gpio>;
-};
+	mmc0: mmc@c0880000 {
+		compatible = "renesas,rcar-gen5-sdhi";
+		reg = <0 0xc0880000 0 0x2000>;
+		clock-names = "core";
+		max-frequency = <200000000>;
+		clocks = <&clk_stub_mmc>;
+		status = "disabled";
+	};
 
-&gpio5 {
-	clocks = <&clk_stub_gpio>;
-};
+	ufs0: ufs@c0a80000 {
+		compatible = "renesas,r8a78000-ufs";
+		reg = <0 0xc0a80000 0 0x1100>, <0 0xc0a00000 0 0x40000>;
+		reg-names = "hcr", "phy";
+		interrupts = <GIC_SPI 4284 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS0>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS0>;
+		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS0>;
+		freq-table-hz = <38400000 38400000>;
+		status = "disabled";
+	};
 
-&gpio6 {
-	clocks = <&clk_stub_gpio>;
-};
+	ufs1: ufs@c0a90000 {
+		compatible = "renesas,r8a78000-ufs";
+		reg = <0 0xc0a90000 0 0x1100>, <0 0xc0a40000 0 0x40000>;
+		reg-names = "hcr", "phy";
+		interrupts = <GIC_SPI 4285 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS1>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS1>;
+		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS1>;
+		freq-table-hz = <38400000 38400000>;
+		status = "disabled";
+	};
 
-&gpio7 {
-	clocks = <&clk_stub_gpio>;
-};
+	scp: sram@c1000000 {
+		compatible = "arm,rcar-sram-ns", "mmio-sram";
+		reg = <0x0 0xc1000000 0x0 0x80000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x0 0xc1000000 0x80000>;
 
-&gpio8 {
-	clocks = <&clk_stub_gpio>;
-};
+		cpu_scp_lpri0: scp-shmem@60000 {
+			compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
+			reg = <0x61200 0x0100>;
+		};
 
-&gpio9 {
-	clocks = <&clk_stub_gpio>;
-};
+		cpu_scp_hpri0: scp-shmem@60300 {
+			compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
+			reg = <0x61300 0x100>;
+		};
+	};
 
-&gpio10 {
-	clocks = <&clk_stub_gpio>;
-};
+	cpg: clock-controller@c64f0000 {
+		compatible = "renesas,r8a78000-cpg-mssr";
+		reg = <0 0xc64f0000 0 0x4000>;
+		clocks = <&extal_clk>, <&extalr_clk>;
+		clock-names = "extal", "extalr";
+		#clock-cells = <2>;
+		#power-domain-cells = <0>;
+		#reset-cells = <1>;
+		bootph-all;
+	};
 
-&i2c0 {
-	clocks = <&clk_stub_i2c0>;
-};
+	i2c0: i2c@c11d0000 {
+		compatible = "renesas,i2c-r8a78000",
+			     "renesas,rcar-gen5-i2c";
+		reg = <0 0xc11d0000 0 0x40>;
+		i2c-scl-internal-delay-ns = <110>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk_stub_i2c0>;
+		status = "disabled";
+	};
 
-&i2c1 {
-	clocks = <&clk_stub_i2c1>;
-};
+	i2c1: i2c@c06c0000 {
+		compatible = "renesas,i2c-r8a78000",
+			     "renesas,rcar-gen5-i2c";
+		reg = <0 0xc06c0000 0 0x40>;
+		i2c-scl-internal-delay-ns = <110>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&clk_stub_i2c1>;
+		status = "disabled";
+	};
 
-&i2c2 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio0: gpio@c1080110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc1080110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 28>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c3 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio1: gpio@c1080910 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc1080910 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 22>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c4 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio2: gpio@c1081110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc1081110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 29>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c5 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio3: gpio@c0800110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0800110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 17>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c6 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio4: gpio@c0800910 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0800910 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 16>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c7 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio5: gpio@c0400110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0400110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 160 23>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&i2c8 {
-	clocks = <&clk_stub_i2c1>;
-};
+	gpio6: gpio@c0400910 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0400910 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 192 31>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&mmc0 {
-	clocks = <&clk_stub_mmc>;
-};
+	gpio7: gpio@c0401110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0401110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 224 31>;
+		clocks = <&clk_stub_gpio>;
+	};
 
-&prr {
-	bootph-all;
+	gpio8: gpio@c0401910 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc0401910 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 256 32>;
+		gpio-reserved-ranges = <16 10>;
+		clocks = <&clk_stub_gpio>;
+	};
+
+	gpio9: gpio@c9b00110 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc9b00110 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 288 17>;
+		clocks = <&clk_stub_gpio>;
+	};
+
+	gpio10: gpio@c9b00910 {
+		compatible = "renesas,gpio-r8a78000",
+			     "renesas,rcar-gen5-gpio";
+		reg = <0 0xc9b00910 0 0xc0>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 320 14>;
+		clocks = <&clk_stub_gpio>;
+	};
+
+	mp_phy: mp_phy@c9a00000 {
+		compatible = "renesas,r8a78000-multi-protocol-phy";
+		reg = <0 0xc9a00000 0 0x100000>;
+		#phy-cells = <2>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY01>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY11>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY21>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY31>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY02>;
+		clock-names = "mpphy01", "mpphy11", "mpphy21",
+			      "mpphy31", "mpphy02";
+		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_MPP0>,
+				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP1>,
+				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP2>,
+				<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP3>;
+		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY01>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY11>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY21>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY31>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY02>;
+		status = "disabled";
+	};
+
+	rswitch3: ethernet@c9bc0000 {
+		compatible = "renesas,r8a78000-ether-switch3",
+				"renesas,etherswitch";
+		reg = <0 0xc9bc0000 0 0x40000>, <0 0xc9b80000 0 0x240000>;
+		reg-names = "base", "secure_base";
+		power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_RSW>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSN>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3AES>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES0>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES1>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES2>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES3>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES4>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES5>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES6>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES7>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3MFWD>;
+		clock-names = "rsw3", "rsw3tsn", "rsw3aes",
+			      "rsw3tsntes0", "rsw3tsntes1", "rsw3tsntes2",
+			      "rsw3tsntes3", "rsw3tsntes4", "rsw3tsntes5",
+			      "rsw3tsntes6", "rsw3tsntes7", "rsw3mfwd";
+		status = "disabled";
+	};
+
+	eth_pcs: phy@c9c50000 {
+		compatible = "renesas,r8a78000-ether-pcs";
+		reg = <0 0xc9c50000 0 0x4000>;
+		#phy-cells = <1>;
+		clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS0>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS1>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS2>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS3>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS4>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS5>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS6>,
+			 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS7>;
+		clock-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
+			      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
+		resets = <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS0>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS1>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS2>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS3>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS4>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS5>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS6>,
+			 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS7>;
+		reset-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
+			      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/dts/r8a78000.dtsi b/arch/arm/dts/r8a78000.dtsi
deleted file mode 100644
index 89c2881fa94..00000000000
--- a/arch/arm/dts/r8a78000.dtsi
+++ /dev/null
@@ -1,1164 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-/*
- * Device Tree Source for the R-Car X5H (R8A78000) SoC
- *
- * Copyright (C) 2025 Renesas Electronics Corp.
- */
-
-#include <dt-bindings/clock/r8a78000-clock-scmi.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/r8a78000-power-scmi.h>
-#include <dt-bindings/reset/r8a78000-reset-scmi.h>
-
-/ {
-	compatible = "renesas,r8a78000";
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&gic>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&a720_0>;
-				};
-				core1 {
-					cpu = <&a720_1>;
-				};
-				core2 {
-					cpu = <&a720_2>;
-				};
-				core3 {
-					cpu = <&a720_3>;
-				};
-			};
-
-			cluster1 {
-				core0 {
-					cpu = <&a720_4>;
-				};
-				core1 {
-					cpu = <&a720_5>;
-				};
-				core2 {
-					cpu = <&a720_6>;
-				};
-				core3 {
-					cpu = <&a720_7>;
-				};
-			};
-
-			cluster2 {
-				core0 {
-					cpu = <&a720_8>;
-				};
-				core1 {
-					cpu = <&a720_9>;
-				};
-				core2 {
-					cpu = <&a720_10>;
-				};
-				core3 {
-					cpu = <&a720_11>;
-				};
-			};
-
-			cluster3 {
-				core0 {
-					cpu = <&a720_12>;
-				};
-				core1 {
-					cpu = <&a720_13>;
-				};
-				core2 {
-					cpu = <&a720_14>;
-				};
-				core3 {
-					cpu = <&a720_15>;
-				};
-			};
-
-			cluster4 {
-				core0 {
-					cpu = <&a720_16>;
-				};
-				core1 {
-					cpu = <&a720_17>;
-				};
-				core2 {
-					cpu = <&a720_18>;
-				};
-				core3 {
-					cpu = <&a720_19>;
-				};
-			};
-
-			cluster5 {
-				core0 {
-					cpu = <&a720_20>;
-				};
-				core1 {
-					cpu = <&a720_21>;
-				};
-				core2 {
-					cpu = <&a720_22>;
-				};
-				core3 {
-					cpu = <&a720_23>;
-				};
-			};
-
-			cluster6 {
-				core0 {
-					cpu = <&a720_24>;
-				};
-				core1 {
-					cpu = <&a720_25>;
-				};
-				core2 {
-					cpu = <&a720_26>;
-				};
-				core3 {
-					cpu = <&a720_27>;
-				};
-			};
-
-			cluster7 {
-				core0 {
-					cpu = <&a720_28>;
-				};
-				core1 {
-					cpu = <&a720_29>;
-				};
-				core2 {
-					cpu = <&a720_30>;
-				};
-				core3 {
-					cpu = <&a720_31>;
-				};
-			};
-		};
-
-		a720_0: cpu@0 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x0>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_0>;
-		};
-
-		a720_1: cpu@100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_1>;
-		};
-
-		a720_2: cpu@200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_2>;
-		};
-
-		a720_3: cpu@300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_3>;
-		};
-
-		a720_4: cpu@10000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x10000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_4>;
-		};
-
-		a720_5: cpu@10100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x10100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_5>;
-		};
-
-		a720_6: cpu@10200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x10200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_6>;
-		};
-
-		a720_7: cpu@10300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x10300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_7>;
-		};
-
-		a720_8: cpu@20000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x20000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_8>;
-		};
-
-		a720_9: cpu@20100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x20100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_9>;
-		};
-
-		a720_10: cpu@20200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x20200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_10>;
-		};
-
-		a720_11: cpu@20300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x20300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_11>;
-		};
-
-		a720_12: cpu@30000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x30000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_12>;
-		};
-
-		a720_13: cpu@30100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x30100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_13>;
-		};
-
-		a720_14: cpu@30200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x30200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_14>;
-		};
-
-		a720_15: cpu@30300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x30300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_15>;
-		};
-
-		a720_16: cpu@40000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x40000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_16>;
-		};
-
-		a720_17: cpu@40100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x40100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_17>;
-		};
-
-		a720_18: cpu@40200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x40200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_18>;
-		};
-
-		a720_19: cpu@40300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x40300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_19>;
-		};
-
-		a720_20: cpu@50000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x50000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_20>;
-		};
-
-		a720_21: cpu@50100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x50100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_21>;
-		};
-
-		a720_22: cpu@50200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x50200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_22>;
-		};
-
-		a720_23: cpu@50300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x50300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_23>;
-		};
-
-		a720_24: cpu@60000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x60000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_24>;
-		};
-
-		a720_25: cpu@60100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x60100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_25>;
-		};
-
-		a720_26: cpu@60200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x60200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_26>;
-		};
-
-		a720_27: cpu@60300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x60300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_27>;
-		};
-
-		a720_28: cpu@70000 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x70000>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_28>;
-		};
-
-		a720_29: cpu@70100 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x70100>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_29>;
-		};
-
-		a720_30: cpu@70200 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x70200>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_30>;
-		};
-
-		a720_31: cpu@70300 {
-			compatible = "arm,cortex-a720ae";
-			reg = <0x0 0x70300>;
-			device_type = "cpu";
-			next-level-cache = <&L2_CA720_31>;
-		};
-
-		L2_CA720_0: cache-controller-200 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_0>;
-		};
-
-		L2_CA720_1: cache-controller-201 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_0>;
-		};
-
-		L2_CA720_2: cache-controller-202 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_0>;
-		};
-
-		L2_CA720_3: cache-controller-203 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_0>;
-		};
-
-		L2_CA720_4: cache-controller-204 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_1>;
-		};
-
-		L2_CA720_5: cache-controller-205 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_1>;
-		};
-
-		L2_CA720_6: cache-controller-206 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_1>;
-		};
-
-		L2_CA720_7: cache-controller-207 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_1>;
-		};
-
-		L2_CA720_8: cache-controller-208 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_2>;
-		};
-
-		L2_CA720_9: cache-controller-209 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_2>;
-		};
-
-		L2_CA720_10: cache-controller-210 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_2>;
-		};
-
-		L2_CA720_11: cache-controller-211 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_2>;
-		};
-
-		L2_CA720_12: cache-controller-212 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_3>;
-		};
-
-		L2_CA720_13: cache-controller-213 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_3>;
-		};
-
-		L2_CA720_14: cache-controller-214 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_3>;
-		};
-
-		L2_CA720_15: cache-controller-215 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_3>;
-		};
-
-		L2_CA720_16: cache-controller-216 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_4>;
-		};
-
-		L2_CA720_17: cache-controller-217 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_4>;
-		};
-
-		L2_CA720_18: cache-controller-218 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_4>;
-		};
-
-		L2_CA720_19: cache-controller-219 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_4>;
-		};
-
-		L2_CA720_20: cache-controller-220 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_5>;
-		};
-
-		L2_CA720_21: cache-controller-221 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_5>;
-		};
-
-		L2_CA720_22: cache-controller-222 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_5>;
-		};
-
-		L2_CA720_23: cache-controller-223 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_5>;
-		};
-
-		L2_CA720_24: cache-controller-224 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_6>;
-		};
-
-		L2_CA720_25: cache-controller-225 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_6>;
-		};
-
-		L2_CA720_26: cache-controller-226 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_6>;
-		};
-
-		L2_CA720_27: cache-controller-227 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_6>;
-		};
-
-		L2_CA720_28: cache-controller-228 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_7>;
-		};
-
-		L2_CA720_29: cache-controller-229 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_7>;
-		};
-
-		L2_CA720_30: cache-controller-230 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_7>;
-		};
-
-		L2_CA720_31: cache-controller-231 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <2>;
-			next-level-cache = <&L3_CA720_7>;
-		};
-
-		L3_CA720_0: cache-controller-30 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_1: cache-controller-31 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_2: cache-controller-32 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_3: cache-controller-33 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_4: cache-controller-34 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_5: cache-controller-35 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_6: cache-controller-36 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-
-		L3_CA720_7: cache-controller-37 {
-			compatible = "cache";
-			cache-unified;
-			cache-level = <3>;
-		};
-	};
-
-	/*
-	 * In the early phase, there is no clock control support,
-	 * so assume that the clocks are enabled by default.
-	 * Therefore, dummy clocks are used.
-	 */
-	dummy_clk_sgasyncd16: dummy-clk-sgasyncd16 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <66666000>;
-	};
-
-	dummy_clk_sgasyncd4: dummy-clk-sgasyncd4 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <266660000>;
-	};
-
-	extal_clk: extal-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* clock-frequency must be set on board */
-	};
-
-	extalr_clk: extalr-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		/* clock-frequency must be set on board */
-	};
-
-	firmware {
-		scmi {
-			compatible = "arm,scmi";
-			arm,poll-transport;
-			mbox-names = "tx", "rx";
-			mboxes = <&mailbox 0>, <&mailbox 1>;
-			shmem = <&cpu_scp_lpri0>, <&cpu_scp_hpri0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			scmi_devpd: protocol@11 {
-				reg = <0x11>;
-				#power-domain-cells = <1>;
-			};
-
-			scmi_clk: protocol@14 {
-				reg = <0x14>;
-				#clock-cells = <1>;
-			};
-
-			scmi_reset: protocol@16 {
-				reg = <0x16>;
-				#reset-cells = <1>;
-			};
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-1.0", "arm,psci-0.2";
-		method = "smc";
-	};
-
-	/* External SCIF clock - to be overridden by boards that provide it */
-	scif_clk: scif-clk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>; /* optional */
-	};
-
-	soc: soc {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		mailbox: mfis_mbox@18842000 {
-			compatible = "renesas,mfis-mbox";
-			#mbox-cells = <1>;
-			reg = <0 0x18842004 0 0x8>;
-			interrupts = <GIC_SPI 4362 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		prr: chipid@189e0044 {
-			compatible = "renesas,prr";
-			reg = <0 0x189e0044 0 4>;
-		};
-
-		/* Application Processors manage View-1 of a GIC-720AE */
-		gic: interrupt-controller@39000000 {
-			compatible = "arm,gic-v3";
-			#interrupt-cells = <3>;
-			#address-cells = <0>;
-			interrupt-controller;
-			reg = <0 0x39000000 0 0x10000>,
-			      <0 0x39080000 0 0x800000>;
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		pfc: pinctrl@c0400000 {
-			compatible = "renesas,pfc-r8a78000";
-			reg = <0 0xc1080000 0 0x104>, <0 0xc1080800 0 0x104>,
-			      <0 0xc1081000 0 0x104>, <0 0xc0800000 0 0x104>,
-			      <0 0xc0800800 0 0x104>, <0 0xc0400000 0 0x104>,
-			      <0 0xc0400800 0 0x104>, <0 0xc0401000 0 0x104>,
-			      <0 0xc0401800 0 0x104>, <0 0xc9b00000 0 0x104>,
-			      <0 0xc9b00800 0 0x104>;
-		};
-
-		scif0: serial@c0700000 {
-			compatible = "renesas,scif-r8a78000",
-				     "renesas,rcar-gen5-scif", "renesas,scif";
-			reg = <0 0xc0700000 0 0x40>;
-			interrupts = <GIC_SPI 4074 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		scif1: serial@c0704000 {
-			compatible = "renesas,scif-r8a78000",
-				     "renesas,rcar-gen5-scif", "renesas,scif";
-			reg = <0 0xc0704000 0 0x40>;
-			interrupts = <GIC_SPI 4075 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		scif3: serial@c0708000 {
-			compatible = "renesas,scif-r8a78000",
-				     "renesas,rcar-gen5-scif", "renesas,scif";
-			reg = <0 0xc0708000 0 0x40>;
-			interrupts = <GIC_SPI 4076 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		scif4: serial@c070c000 {
-			compatible = "renesas,scif-r8a78000",
-				     "renesas,rcar-gen5-scif", "renesas,scif";
-			reg = <0 0xc070c000 0 0x40>;
-			interrupts = <GIC_SPI 4077 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		mmc0: mmc@c0880000 {
-			compatible = "renesas,rcar-gen5-sdhi";
-			reg = <0 0xc0880000 0 0x2000>;
-			clock-names = "core";
-			max-frequency = <200000000>;
-			status = "disabled";
-		};
-
-		ufs0: ufs@c0a80000 {
-			compatible = "renesas,r8a78000-ufs";
-			reg = <0 0xc0a80000 0 0x1100>, <0 0xc0a00000 0 0x40000>;
-			reg-names = "hcr", "phy";
-			interrupts = <GIC_SPI 4284 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS0>;
-			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS0>;
-			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS0>;
-			freq-table-hz = <38400000 38400000>;
-			status = "disabled";
-		};
-
-		ufs1: ufs@c0a90000 {
-			compatible = "renesas,r8a78000-ufs";
-			reg = <0 0xc0a90000 0 0x1100>, <0 0xc0a40000 0 0x40000>;
-			reg-names = "hcr", "phy";
-			interrupts = <GIC_SPI 4285 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_UFS1>;
-			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_UFS1>;
-			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_UFS1>;
-			freq-table-hz = <38400000 38400000>;
-			status = "disabled";
-		};
-
-		scp: sram@c1000000 {
-			compatible = "arm,rcar-sram-ns", "mmio-sram";
-			reg = <0x0 0xc1000000 0x0 0x80000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x0 0xc1000000 0x80000>;
-
-			cpu_scp_lpri0: scp-shmem@60000 {
-				compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
-				reg = <0x61200 0x0100>;
-			};
-
-			cpu_scp_hpri0: scp-shmem@60300 {
-				compatible = "arm,rcar-scp-shmem", "arm,scmi-shmem";
-				reg = <0x61300 0x100>;
-			};
-		};
-
-		cpg: clock-controller@c64f0000 {
-			compatible = "renesas,r8a78000-cpg-mssr";
-			reg = <0 0xc64f0000 0 0x4000>;
-			clocks = <&extal_clk>, <&extalr_clk>;
-			clock-names = "extal", "extalr";
-			#clock-cells = <2>;
-			#power-domain-cells = <0>;
-			#reset-cells = <1>;
-		};
-
-		hscif0: serial@c0710000 {
-			compatible = "renesas,hscif-r8a78000",
-				     "renesas,rcar-gen5-hscif", "renesas,hscif";
-			reg = <0 0xc0710000 0 0x60>;
-			interrupts = <GIC_SPI 4078 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		hscif1: serial@c0714000 {
-			compatible = "renesas,hscif-r8a78000",
-				     "renesas,rcar-gen5-hscif", "renesas,hscif";
-			reg = <0 0xc0714000 0 0x60>;
-			interrupts = <GIC_SPI 4079 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		hscif2: serial@c0718000 {
-			compatible = "renesas,hscif-r8a78000",
-				     "renesas,rcar-gen5-hscif", "renesas,hscif";
-			reg = <0 0xc0718000 0 0x60>;
-			interrupts = <GIC_SPI 4080 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		hscif3: serial@c071c000 {
-			compatible = "renesas,hscif-r8a78000",
-				     "renesas,rcar-gen5-hscif", "renesas,hscif";
-			reg = <0 0xc071c000 0 0x60>;
-			interrupts = <GIC_SPI 4081 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
-			clock-names = "fck", "brg_int", "scif_clk";
-			status = "disabled";
-		};
-
-		i2c0: i2c@c11d0000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc11d0000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c1: i2c@c06c0000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06c0000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c2: i2c@c06c8000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06c8000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c3: i2c@c06d0000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06d0000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c4: i2c@c06d8000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06d8000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c5: i2c@c06e0000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06e0000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c6: i2c@c06e8000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06e8000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c7: i2c@c06f0000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06f0000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		i2c8: i2c@c06f8000 {
-			compatible = "renesas,i2c-r8a78000",
-				     "renesas,rcar-gen5-i2c";
-			reg = <0 0xc06f8000 0 0x40>;
-			i2c-scl-internal-delay-ns = <110>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		gpio0: gpio@c1080110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc1080110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 0 28>;
-		};
-
-		gpio1: gpio@c1080910 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc1080910 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 32 22>;
-		};
-
-		gpio2: gpio@c1081110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc1081110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 64 29>;
-		};
-
-		gpio3: gpio@c0800110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0800110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 96 17>;
-		};
-
-		gpio4: gpio@c0800910 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0800910 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 128 16>;
-		};
-
-		gpio5: gpio@c0400110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0400110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 160 23>;
-		};
-
-		gpio6: gpio@c0400910 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0400910 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 192 31>;
-		};
-
-		gpio7: gpio@c0401110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0401110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 224 31>;
-		};
-
-		gpio8: gpio@c0401910 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc0401910 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 256 32>;
-			gpio-reserved-ranges = <16 10>;
-		};
-
-		gpio9: gpio@c9b00110 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc9b00110 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 288 17>;
-		};
-
-		gpio10: gpio@c9b00910 {
-			compatible = "renesas,gpio-r8a78000",
-				     "renesas,rcar-gen5-gpio";
-			reg = <0 0xc9b00910 0 0xc0>;
-			#gpio-cells = <2>;
-			gpio-controller;
-			gpio-ranges = <&pfc 0 320 14>;
-		};
-
-		mp_phy: mp_phy@c9a00000 {
-			compatible = "renesas,r8a78000-multi-protocol-phy";
-			reg = <0 0xc9a00000 0 0x100000>;
-			#phy-cells = <2>;
-			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY01>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY11>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY21>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY31>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_MPPHY02>;
-			clock-names = "mpphy01", "mpphy11", "mpphy21",
-				      "mpphy31", "mpphy02";
-			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_MPP0>,
-					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP1>,
-					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP2>,
-					<&scmi_devpd X5H_POWER_DOMAIN_ID_MPP3>;
-			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY01>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY11>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY21>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY31>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_MPPHY02>;
-			status = "disabled";
-		};
-
-		rswitch3: ethernet@c9bc0000 {
-			compatible = "renesas,r8a78000-ether-switch3",
-					"renesas,etherswitch";
-			reg = <0 0xc9bc0000 0 0x40000>, <0 0xc9b80000 0 0x240000>;
-			reg-names = "base", "secure_base";
-			power-domains = <&scmi_devpd X5H_POWER_DOMAIN_ID_RSW>;
-			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSN>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3AES>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES0>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES1>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES2>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES3>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES4>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES5>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES6>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3TSNTES7>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_RSW3MFWD>;
-			clock-names = "rsw3", "rsw3tsn", "rsw3aes",
-				      "rsw3tsntes0", "rsw3tsntes1", "rsw3tsntes2",
-				      "rsw3tsntes3", "rsw3tsntes4", "rsw3tsntes5",
-				      "rsw3tsntes6", "rsw3tsntes7", "rsw3mfwd";
-			status = "disabled";
-		};
-
-		eth_pcs: phy@c9c50000 {
-			compatible = "renesas,r8a78000-ether-pcs";
-			reg = <0 0xc9c50000 0 0x4000>;
-			#phy-cells = <1>;
-			clocks = <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS0>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS1>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS2>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS3>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS4>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS5>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS6>,
-				 <&scmi_clk SCP_CLOCK_ID_MDLC_XPCS7>;
-			clock-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
-				      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
-			resets = <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS0>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS1>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS2>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS3>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS4>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS5>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS6>,
-				 <&scmi_reset SCP_RESET_DOMAIN_ID_XPCS7>;
-			reset-names = "xpcs0", "xpcs1", "xpcs2", "xpcs3",
-				      "xpcs4", "xpcs5", "xpcs6", "xpcs7";
-			status = "disabled";
-		};
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
-	};
-};
diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
index 180704e75af..f8a1403ae0d 100644
--- a/configs/r8a78000_ironhide_defconfig
+++ b/configs/r8a78000_ironhide_defconfig
@@ -5,12 +5,11 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN5=y
 CONFIG_TARGET_IRONHIDE=y
 
-# CONFIG_OF_UPSTREAM is not set
 CONFIG_ARMV8_PSCI=y
 CONFIG_ARM_SMCCC=y
 CONFIG_BAUDRATE=1843200
 CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} r8a78000-ironhide.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
-CONFIG_DEFAULT_DEVICE_TREE="r8a78000-ironhide"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a78000-ironhide"
 CONFIG_CLK_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_SCMI=y
diff --git a/include/configs/rcar-gen5-common.h b/include/configs/rcar-gen5-common.h
index 81b5e2aa5bb..9edc37cba8b 100644
--- a/include/configs/rcar-gen5-common.h
+++ b/include/configs/rcar-gen5-common.h
@@ -12,7 +12,7 @@
 #define CFG_SYS_BAUDRATE_TABLE		{ 38400, 115200, 921600, 1843200, 3250000 }
 
 /* Memory */
-#define DRAM_RSV_SIZE			0x08000000
+#define DRAM_RSV_SIZE			0x20600000
 #define CFG_SYS_SDRAM_BASE		(0x40000000 + DRAM_RSV_SIZE)
 #define CFG_SYS_SDRAM_SIZE		(0x80000000u - DRAM_RSV_SIZE)
 #define CFG_MAX_MEM_MAPPED		(0x80000000u - DRAM_RSV_SIZE)
-- 
2.53.0

