Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6403BC48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 18:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2CD87DEF;
	Sun,  3 Mar 2024 19:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAlSC9dK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAEF887F28; Sun,  3 Mar 2024 19:24:29 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E08087D37
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 19:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso3033709a34.0
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709490264; x=1710095064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xeaBX16iXiDY42W7f9iTf0vMIZrOAeVBBog5HSYpsoU=;
 b=TAlSC9dKnrzwC2xc4sDjUrXd2pZ0ZYgXotd9FcM2cqZvuMS2eG2e1KbjYmEQ/jjNpn
 0dGZAT3gPn8uPwFNjQNhLybAwPGMTgWrU5lVMzNqH9WiEpv43GWmpkP2oU8JVWD8lmfU
 W7RODjmdLvV9l5qMN484tyNRX6jXW5n2yitHCEQSxUOXwwhMKyz03ImBbQRwUpaGeexC
 dZmaoQSXmPeet+FfRvaWitWPUqMwx8gGLW9VTJp9ahJkcvYBanghEAEeCLRqehR6wWv/
 0RU3llGPS0Z4iMcoAJaeQnAU/ucgcp3aIHywru84oTU8O7C+sMWMOs1c/CaAd18+w1PG
 pgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709490264; x=1710095064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xeaBX16iXiDY42W7f9iTf0vMIZrOAeVBBog5HSYpsoU=;
 b=QD+z8+B9i+HRy50++CM45ygtB+CT5Y2bQq2e8wiKHK5QGT/ktzOELLv2bfOCx8lMWD
 Vl+CIdpbwuBg9wJo/Jv3xH/vHZUBPP72djhQVy2wg8hH6sncNEglhT72un9Wui4M/9X7
 bx5trLKGlr4Db0SatO5dNQv2Dp4322Twb55Xbc12A4un2rBsgiD5iITz6qzU64LiEiL6
 53PaHWNZDMTj0frZ7oYwGVutx/oMo+zcXLXcixamAS5pqbom5RN4fh73eLrXsi79Slbw
 vQ3vyrNlLRsBepZIBWxzlVIOrc7iINe3RghWhBuI9dcnoJyUFdPQAnOVx0xPHKVX8Ehq
 H7gg==
X-Gm-Message-State: AOJu0YykESFDy2ssEx12e6Kt/Agn5f8ZKNg+qBurEA8+V7LVbr5C/rFs
 7Ab5Y8yjamsjNUH2husE6NNEbj2KqJ4T+vZi2s/wGRNaar7VUSwBQujmOcnUygQ=
X-Google-Smtp-Source: AGHT+IGYFkvtz8A1otYM3EjI/hq5nZZwoB885KVKG5eTmnvWoluKEzWTRRjwlWxxD2jKFDpBMPTzwQ==
X-Received: by 2002:a9d:73ce:0:b0:6e4:dc5c:f627 with SMTP id
 m14-20020a9d73ce000000b006e4dc5cf627mr4173351otk.13.1709490264440; 
 Sun, 03 Mar 2024 10:24:24 -0800 (PST)
Received: from localhost.localdomain ([98.97.42.244])
 by smtp.gmail.com with ESMTPSA id
 v184-20020a6389c1000000b005e43cb66a7asm6100797pgd.87.2024.03.03.10.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 10:24:23 -0800 (PST)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Benjamin Schneider <ben@bens.haus>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Robert Marko <robert.marko@sartura.hr>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: dts: armada-37xx: update devicetrees from linux
Date: Sun,  3 Mar 2024 18:24:20 +0000
Message-Id: <20240303182420.10265-1-ben@bens.haus>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 03 Mar 2024 19:28:34 +0100
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

Update existing armada-37xx DTS files with those in linux v6.8
and add devicetree for ESPRESSObin Ultra device.

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---

 arch/arm/dts/armada-3720-db.dts               |   6 +-
 .../arm/dts/armada-3720-espressobin-ultra.dts | 167 ++++++++++++++++++
 arch/arm/dts/armada-3720-espressobin.dts      |   2 +-
 arch/arm/dts/armada-3720-espressobin.dtsi     |  22 ++-
 arch/arm/dts/armada-3720-turris-mox.dts       | 133 +++++++-------
 arch/arm/dts/armada-3720-uDPU.dts             |   8 +-
 arch/arm/dts/armada-3720-uDPU.dtsi            |   8 +-
 arch/arm/dts/armada-372x.dtsi                 |   2 +-
 arch/arm/dts/armada-37xx.dtsi                 |  28 ++-
 9 files changed, 286 insertions(+), 90 deletions(-)
 create mode 100644 arch/arm/dts/armada-3720-espressobin-ultra.dts

diff --git a/arch/arm/dts/armada-3720-db.dts b/arch/arm/dts/armada-3720-db.dts
index 1ee92406b7..0cfb384920 100644
--- a/arch/arm/dts/armada-3720-db.dts
+++ b/arch/arm/dts/armada-3720-db.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "Marvell Armada 3720 Development Board DB-88F3720-DDR3";
-	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3710";
+	compatible = "marvell,armada-3720-db", "marvell,armada3720", "marvell,armada3700";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
@@ -164,7 +164,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi_quad_pins>;
 
-	m25p80@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <108000000>;
@@ -180,7 +180,7 @@
 				reg = <0x0 0x200000>;
 			};
 			partition@200000 {
-				label = "U-Boot Env";
+				label = "U-boot Env";
 				reg = <0x200000 0x10000>;
 			};
 			partition@210000 {
diff --git a/arch/arm/dts/armada-3720-espressobin-ultra.dts b/arch/arm/dts/armada-3720-espressobin-ultra.dts
new file mode 100644
index 0000000000..870bb380a4
--- /dev/null
+++ b/arch/arm/dts/armada-3720-espressobin-ultra.dts
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree file for ESPRESSObin-Ultra board.
+ * Copyright (C) 2019 Globalscale technologies, Inc.
+ *
+ * Jason Hung <jhung@globalscaletechnologies.com>
+ */
+
+/dts-v1/;
+
+#include "armada-3720-espressobin.dtsi"
+
+/ {
+	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
+	compatible = "globalscale,espressobin-ultra", "globalscale,espressobin",
+		     "marvell,armada3720", "marvell,armada3700";
+
+	aliases {
+		/* ethernet1 is WAN port */
+		ethernet1 = &switch0port5;
+		ethernet2 = &switch0port1;
+		ethernet3 = &switch0port2;
+		ethernet4 = &switch0port3;
+		ethernet5 = &switch0port4;
+	};
+
+	/delete-node/ regulator;
+
+	reg_usb3_vbus: usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb3-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&gpionb 19 GPIO_ACTIVE_HIGH>;
+	};
+
+	usb3_phy: usb3-phy {
+		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_usb3_vbus>;
+	};
+
+	gpio-leds {
+		pinctrl-names = "default";
+		compatible = "gpio-leds";
+		/* No assigned functions to the LEDs by default */
+		led1 {
+			label = "ebin-ultra:blue:led1";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+		led2 {
+			label = "ebin-ultra:green:led2";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+		led3 {
+			label = "ebin-ultra:red:led3";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+		led4 {
+			label = "ebin-ultra:yellow:led4";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+};
+
+&sdhci1 {
+	/delete-property/ vqmmc-supply;
+	status = "disabled";
+};
+
+&spi0 {
+	flash@0 {
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x3e0000>;
+			};
+			partition@3e0000 {
+				label = "hw-info";
+				reg = <0x3e0000 0x10000>;
+				read-only;
+			};
+			partition@3f0000 {
+				label = "u-boot-env";
+				reg = <0x3f0000 0x10000>;
+			};
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <100000>;
+
+	rtc@51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&usb3 {
+	usb-phy = <&usb3_phy>;
+};
+
+&mdio {
+	extphy: ethernet-phy@1 {
+		reg = <1>;
+
+		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&switch0 {
+	reg = <3>;
+
+	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
+
+	ethernet-ports {
+		switch0port1: ethernet-port@1 {
+			reg = <1>;
+			label = "lan0";
+			phy-handle = <&switch0phy0>;
+		};
+
+		switch0port2: ethernet-port@2 {
+			reg = <2>;
+			label = "lan1";
+			phy-handle = <&switch0phy1>;
+		};
+
+		switch0port3: ethernet-port@3 {
+			reg = <3>;
+			label = "lan2";
+			phy-handle = <&switch0phy2>;
+		};
+
+		switch0port4: ethernet-port@4 {
+			reg = <4>;
+			label = "lan3";
+			phy-handle = <&switch0phy3>;
+		};
+
+		switch0port5: ethernet-port@5 {
+			reg = <5>;
+			label = "wan";
+			phy-handle = <&extphy>;
+			phy-mode = "sgmii";
+		};
+	};
+
+	mdio {
+		switch0phy3: ethernet-phy@14 {
+			reg = <0x14>;
+		};
+	};
+};
diff --git a/arch/arm/dts/armada-3720-espressobin.dts b/arch/arm/dts/armada-3720-espressobin.dts
index 1542d836c0..c5a834b33b 100644
--- a/arch/arm/dts/armada-3720-espressobin.dts
+++ b/arch/arm/dts/armada-3720-espressobin.dts
@@ -16,5 +16,5 @@
 
 / {
 	model = "Globalscale Marvell ESPRESSOBin Board";
-	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3710";
+	compatible = "globalscale,espressobin", "marvell,armada3720", "marvell,armada3700";
 };
diff --git a/arch/arm/dts/armada-3720-espressobin.dtsi b/arch/arm/dts/armada-3720-espressobin.dtsi
index 5fc613d241..fed2dcecb3 100644
--- a/arch/arm/dts/armada-3720-espressobin.dtsi
+++ b/arch/arm/dts/armada-3720-espressobin.dtsi
@@ -13,7 +13,7 @@
 / {
 	aliases {
 		ethernet0 = &eth0;
-		/* for dsa slave device */
+		/* for DSA user port device */
 		ethernet1 = &switch0port1;
 		ethernet2 = &switch0port2;
 		ethernet3 = &switch0port3;
@@ -145,19 +145,17 @@
 };
 
 &mdio {
-	switch0: switch0@1 {
+	switch0: ethernet-switch@1 {
 		compatible = "marvell,mv88e6085";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		reg = <1>;
 
 		dsa,member = <0 0>;
 
-		ports {
+		ethernet-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0port0: port@0 {
+			switch0port0: ethernet-port@0 {
 				reg = <0>;
 				label = "cpu";
 				ethernet = <&eth0>;
@@ -168,19 +166,19 @@
 				};
 			};
 
-			switch0port1: port@1 {
+			switch0port1: ethernet-port@1 {
 				reg = <1>;
 				label = "wan";
 				phy-handle = <&switch0phy0>;
 			};
 
-			switch0port2: port@2 {
+			switch0port2: ethernet-port@2 {
 				reg = <2>;
 				label = "lan0";
 				phy-handle = <&switch0phy1>;
 			};
 
-			switch0port3: port@3 {
+			switch0port3: ethernet-port@3 {
 				reg = <3>;
 				label = "lan1";
 				phy-handle = <&switch0phy2>;
@@ -192,13 +190,13 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy0: switch0phy0@11 {
+			switch0phy0: ethernet-phy@11 {
 				reg = <0x11>;
 			};
-			switch0phy1: switch0phy1@12 {
+			switch0phy1: ethernet-phy@12 {
 				reg = <0x12>;
 			};
-			switch0phy2: switch0phy2@13 {
+			switch0phy2: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 		};
diff --git a/arch/arm/dts/armada-3720-turris-mox.dts b/arch/arm/dts/armada-3720-turris-mox.dts
index 595b4b5abb..f1a9f22343 100644
--- a/arch/arm/dts/armada-3720-turris-mox.dts
+++ b/arch/arm/dts/armada-3720-turris-mox.dts
@@ -14,7 +14,7 @@
 / {
 	model = "CZ.NIC Turris Mox Board";
 	compatible = "cznic,turris-mox", "marvell,armada3720",
-		     "marvell,armada3710";
+		     "marvell,armada3700";
 
 	aliases {
 		spi0 = &spi0;
@@ -35,7 +35,7 @@
 
 	leds {
 		compatible = "gpio-leds";
-		red {
+		led {
 			label = "mox:red:activity";
 			gpios = <&gpiosb 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
@@ -45,7 +45,7 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		reset {
+		key-reset {
 			label = "reset";
 			linux,code = <KEY_RESTART>;
 			gpios = <&gpiosb 20 GPIO_ACTIVE_LOW>;
@@ -100,11 +100,11 @@
 	sfp: sfp {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
-		los-gpio = <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&moxtet_sfp 2 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&moxtet_sfp 4 GPIO_ACTIVE_HIGH>;
-		rate-select0-gpio = <&moxtet_sfp 5 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&moxtet_sfp 0 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&moxtet_sfp 1 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&moxtet_sfp 2 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&moxtet_sfp 4 GPIO_ACTIVE_HIGH>;
+		rate-select0-gpios = <&moxtet_sfp 5 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 
 		/* enabled by U-Boot if SFP module is present */
@@ -125,9 +125,12 @@
 	/delete-property/ mrvl,i2c-fast-mode;
 	status = "okay";
 
+	/* MCP7940MT-I/MNY RTC */
 	rtc@6f {
 		compatible = "microchip,mcp7940x";
 		reg = <0x6f>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>; /* GPIO2_5 */
 	};
 };
 
@@ -136,6 +139,7 @@
 	pinctrl-0 = <&pcie_reset_pins &pcie_clkreq_pins>;
 	status = "okay";
 	reset-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+	slot-power-limit-milliwatt = <10000>;
 	/*
 	 * U-Boot port for Turris Mox has a bug which always expects that "ranges" DT property
 	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) address cells and
@@ -144,7 +148,7 @@
 	 * no remapping) and that this address is the lowest from all specified ranges. If these
 	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
 	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
-	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller supports 32-bit IO mapping.
+	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal IO size is just 64 kB.
 	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
 	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
 	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
@@ -211,7 +215,7 @@
 	assigned-clock-parents = <&tbg 1>;
 	assigned-clock-rates = <20000000>;
 
-	spi-flash@0 {
+	flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "jedec,spi-nor";
@@ -300,10 +304,16 @@
 		reg = <1>;
 	};
 
-	/* switch nodes are enabled by U-Boot if modules are present */
+	/*
+	 * NOTE: switch nodes are enabled by U-Boot if modules are present
+	 * DO NOT change this node name (switch0@10) even if it is not following
+	 * conventions! Deployed U-Boot binaries are explicitly looking for
+	 * this node in order to augment the device tree!
+	 * Also do not touch the "ports" or "port@n" nodes. These are also ABI.
+	 */
 	switch0@10 {
-		compatible = "marvell,mv88e6190";
-		reg = <0x10 0>;
+		compatible = "marvell,turris-mox-mv88e6190", "marvell,mv88e6190";
+		reg = <0x10>;
 		dsa,member = <0 0>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(0)>;
@@ -313,35 +323,35 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy1: switch0phy1@1 {
+			switch0phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch0phy2: switch0phy2@2 {
+			switch0phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch0phy3: switch0phy3@3 {
+			switch0phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch0phy4: switch0phy4@4 {
+			switch0phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch0phy5: switch0phy5@5 {
+			switch0phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch0phy6: switch0phy6@6 {
+			switch0phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch0phy7: switch0phy7@7 {
+			switch0phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch0phy8: switch0phy8@8 {
+			switch0phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -426,9 +436,10 @@
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch0@2 {
-		compatible = "marvell,mv88e6085";
-		reg = <0x2 0>;
+		compatible = "marvell,turris-mox-mv88e6085", "marvell,mv88e6085";
+		reg = <0x2>;
 		dsa,member = <0 0>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
@@ -438,19 +449,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch0phy1_topaz: switch0phy1@11 {
+			switch0phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch0phy2_topaz: switch0phy2@12 {
+			switch0phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch0phy3_topaz: switch0phy3@13 {
+			switch0phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch0phy4_topaz: switch0phy4@14 {
+			switch0phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
@@ -493,9 +504,10 @@
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch1@11 {
-		compatible = "marvell,mv88e6190";
-		reg = <0x11 0>;
+		compatible = "marvell,turris-mox-mv88e6190", "marvell,mv88e6190";
+		reg = <0x11>;
 		dsa,member = <0 1>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(1)>;
@@ -505,35 +517,35 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1phy1: switch1phy1@1 {
+			switch1phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch1phy2: switch1phy2@2 {
+			switch1phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch1phy3: switch1phy3@3 {
+			switch1phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch1phy4: switch1phy4@4 {
+			switch1phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch1phy5: switch1phy5@5 {
+			switch1phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch1phy6: switch1phy6@6 {
+			switch1phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch1phy7: switch1phy7@7 {
+			switch1phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch1phy8: switch1phy8@8 {
+			switch1phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -618,9 +630,10 @@
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch1@2 {
-		compatible = "marvell,mv88e6085";
-		reg = <0x2 0>;
+		compatible = "marvell,turris-mox-mv88e6085", "marvell,mv88e6085";
+		reg = <0x2>;
 		dsa,member = <0 1>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
@@ -630,19 +643,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch1phy1_topaz: switch1phy1@11 {
+			switch1phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch1phy2_topaz: switch1phy2@12 {
+			switch1phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch1phy3_topaz: switch1phy3@13 {
+			switch1phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch1phy4_topaz: switch1phy4@14 {
+			switch1phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
@@ -685,9 +698,10 @@
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch2@12 {
-		compatible = "marvell,mv88e6190";
-		reg = <0x12 0>;
+		compatible = "marvell,turris-mox-mv88e6190", "marvell,mv88e6190";
+		reg = <0x12>;
 		dsa,member = <0 2>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_PERIDOT(2)>;
@@ -697,35 +711,35 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2phy1: switch2phy1@1 {
+			switch2phy1: ethernet-phy@1 {
 				reg = <0x1>;
 			};
 
-			switch2phy2: switch2phy2@2 {
+			switch2phy2: ethernet-phy@2 {
 				reg = <0x2>;
 			};
 
-			switch2phy3: switch2phy3@3 {
+			switch2phy3: ethernet-phy@3 {
 				reg = <0x3>;
 			};
 
-			switch2phy4: switch2phy4@4 {
+			switch2phy4: ethernet-phy@4 {
 				reg = <0x4>;
 			};
 
-			switch2phy5: switch2phy5@5 {
+			switch2phy5: ethernet-phy@5 {
 				reg = <0x5>;
 			};
 
-			switch2phy6: switch2phy6@6 {
+			switch2phy6: ethernet-phy@6 {
 				reg = <0x6>;
 			};
 
-			switch2phy7: switch2phy7@7 {
+			switch2phy7: ethernet-phy@7 {
 				reg = <0x7>;
 			};
 
-			switch2phy8: switch2phy8@8 {
+			switch2phy8: ethernet-phy@8 {
 				reg = <0x8>;
 			};
 		};
@@ -801,9 +815,10 @@
 		};
 	};
 
+	/* NOTE: this node name is ABI, don't change it! */
 	switch2@2 {
-		compatible = "marvell,mv88e6085";
-		reg = <0x2 0>;
+		compatible = "marvell,turris-mox-mv88e6085", "marvell,mv88e6085";
+		reg = <0x2>;
 		dsa,member = <0 2>;
 		interrupt-parent = <&moxtet>;
 		interrupts = <MOXTET_IRQ_TOPAZ>;
@@ -813,19 +828,19 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			switch2phy1_topaz: switch2phy1@11 {
+			switch2phy1_topaz: ethernet-phy@11 {
 				reg = <0x11>;
 			};
 
-			switch2phy2_topaz: switch2phy2@12 {
+			switch2phy2_topaz: ethernet-phy@12 {
 				reg = <0x12>;
 			};
 
-			switch2phy3_topaz: switch2phy3@13 {
+			switch2phy3_topaz: ethernet-phy@13 {
 				reg = <0x13>;
 			};
 
-			switch2phy4_topaz: switch2phy4@14 {
+			switch2phy4_topaz: ethernet-phy@14 {
 				reg = <0x14>;
 			};
 		};
diff --git a/arch/arm/dts/armada-3720-uDPU.dts b/arch/arm/dts/armada-3720-uDPU.dts
index a75734d88a..c76eceabd3 100644
--- a/arch/arm/dts/armada-3720-uDPU.dts
+++ b/arch/arm/dts/armada-3720-uDPU.dts
@@ -11,10 +11,10 @@
 	sfp_eth0: sfp-eth0 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
-		los-gpio = <&gpiosb 2 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&gpiosb 3 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&gpiosb 4 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&gpiosb 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&gpiosb 4 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
 };
diff --git a/arch/arm/dts/armada-3720-uDPU.dtsi b/arch/arm/dts/armada-3720-uDPU.dtsi
index 3f79923376..3a9b690718 100644
--- a/arch/arm/dts/armada-3720-uDPU.dtsi
+++ b/arch/arm/dts/armada-3720-uDPU.dtsi
@@ -61,10 +61,10 @@
 	sfp_eth1: sfp-eth1 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c1>;
-		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
+		los-gpios = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpios = <&gpiosb 8 GPIO_ACTIVE_LOW>;
+		tx-disable-gpios = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
 };
diff --git a/arch/arm/dts/armada-372x.dtsi b/arch/arm/dts/armada-372x.dtsi
index 5ce55bdbb9..02ae1e1532 100644
--- a/arch/arm/dts/armada-372x.dtsi
+++ b/arch/arm/dts/armada-372x.dtsi
@@ -13,7 +13,7 @@
 
 / {
 	model = "Marvell Armada 3720 SoC";
-	compatible = "marvell,armada3720", "marvell,armada3710";
+	compatible = "marvell,armada3720", "marvell,armada3700";
 
 	cpus {
 		cpu1: cpu@1 {
diff --git a/arch/arm/dts/armada-37xx.dtsi b/arch/arm/dts/armada-37xx.dtsi
index 0bb4f60763..e300145ad1 100644
--- a/arch/arm/dts/armada-37xx.dtsi
+++ b/arch/arm/dts/armada-37xx.dtsi
@@ -35,6 +35,11 @@
 			reg = <0 0x4000000 0 0x200000>;
 			no-map;
 		};
+
+		tee@4400000 {
+			reg = <0 0x4400000 0 0x1000000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -132,10 +137,20 @@
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: clock-controller@12010 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					 <&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					      "TBG-B-S", "xtal";
+				#clock-cells = <1>;
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +162,7 @@
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
@@ -434,7 +449,7 @@
 				#mbox-cells = <1>;
 			};
 
-			sdhci1: sdhci@d0000 {
+			sdhci1: mmc@d0000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
 				reg = <0xd0000 0x300>,
@@ -445,7 +460,7 @@
 				status = "disabled";
 			};
 
-			sdhci0: sdhci@d8000 {
+			sdhci0: mmc@d8000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
 				reg = <0xd8000 0x300>,
@@ -489,17 +504,18 @@
 			bus-range = <0x00 0xff>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <1>;
+			clocks = <&sb_periph_clk 13>;
 			msi-parent = <&pcie0>;
 			msi-controller;
 			/*
 			 * The 128 MiB address range [0xe8000000-0xf0000000] is
 			 * dedicated for PCIe and can be assigned to 8 windows
-			 * with size a power of two. Use one 1 MiB window for
+			 * with size a power of two. Use one 64 KiB window for
 			 * IO at the end and the remaining seven windows
 			 * (totaling 127 MiB) for MEM.
 			 */
 			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
-				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0 IO */
+				  0x81000000 0 0x00000000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc 0>,
 					<0 0 0 2 &pcie_intc 1>,
-- 
2.34.1

