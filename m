Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9C4C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 01:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC5D88010;
	Tue, 19 Mar 2024 02:58:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fsKynq/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C302488020; Tue, 19 Mar 2024 00:45:09 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B428646E
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 00:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bschnei@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso3515587a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710805505; x=1711410305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u1COLzYt+3HH0fytwK9Jd235DZt2Zpmc+sSlsWEEpNo=;
 b=fsKynq/qO4mSAnjsRwmV2HLjoOInLoRyw5VgdjNmyAx5F/SNTkajHuApN+IaIs9Gtj
 F/6U+bS4BLKyxuOw1G8NgqvW3IGLI3iiZst6/Y0Uvb/pUoF1eace0exnyluzagnSRgfS
 sRXoVkLKPVjiBAi9LlgmyDAdDmSAV0C8DjebE/Xiy54oYfKigL5VarzVETJ5/BXRMh/c
 7oHF/3gTuCMfvnkU9jz/MvfnMkstgtJLW0QZCe74hhrsWdQjbbIvmcVkhvltQnQTnRc7
 5J1riEPtNb5Ds9t2ht1j/eCdFEJhOJ7RB4Hn3CE8eBIzRi2Di0iEmmQMUxmdJQh874+d
 x47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710805505; x=1711410305;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u1COLzYt+3HH0fytwK9Jd235DZt2Zpmc+sSlsWEEpNo=;
 b=vnGDBFZBC5pn5Z6TUrc3wbrXsP3KIbyFeeWXMOA2aoB03JT2O1WnxfP+1/j8sMfUun
 +YJUifwa/XxvjENg+I65aoJG0w1kriIu7JPg/zXyFq+OV0YzvrpJrh+01AWLLI9+OWM1
 kc2IiwtyuoHVSHdB2X8IioS55hwkZCXHVEXOq389b3BKmGosGB6Mtk+xCEA7dT9STV7K
 5tdE7JEcvcTO4HmUwQq95yfoLN2mkXevqstjGqs33iZLCaBMRrNh9xVpA7Bln4Nt+Tn0
 5+6dl7Ak3HrDZ++aYa0G1+NY7KQuY/r2e1Vi8EtQOHNniakurbod9VHNrBqeQ7o3EdnV
 T/Ag==
X-Gm-Message-State: AOJu0Yz/3arb5YzdoYDjLPWKleANJex3T5XLWNYIKetjdqKa/yQ8UgvS
 XIe+waI8z8QrsikURpmus4Zh+oLQEzeIt1Gqt8pq/YETuQ8YUoxFWNnB3P6w17A=
X-Google-Smtp-Source: AGHT+IEQTJusrnRTCUyxSzRuqnayiRBj9wSOnMZKnhc3MEOXI8u1nVYXVPrCygkG52gfAPMpT8EyCQ==
X-Received: by 2002:a17:90a:71c9:b0:29b:c47a:24c7 with SMTP id
 m9-20020a17090a71c900b0029bc47a24c7mr8476758pjs.27.1710805504607; 
 Mon, 18 Mar 2024 16:45:04 -0700 (PDT)
Received: from localhost.localdomain ([98.97.39.70])
 by smtp.gmail.com with ESMTPSA id
 f22-20020a17090aa79600b0029baf777c59sm8303620pjq.17.2024.03.18.16.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 16:45:04 -0700 (PDT)
From: Benjamin Schneider <bschnei@gmail.com>
X-Google-Original-From: Benjamin Schneider <ben@bens.haus>
To: u-boot@lists.denx.de
Cc: Benjamin Schneider <ben@bens.haus>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Robert Marko <robert.marko@sartura.hr>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3] arm: dts: armada-37xx: update devicetrees from linux
Date: Mon, 18 Mar 2024 16:44:48 -0700
Message-Id: <20240318234448.16646-1-ben@bens.haus>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 Mar 2024 02:58:11 +0100
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

Update existing armada-37xx DTS files with those in linux
and add devicetree for ESPRESSObin Ultra device.

Signed-off-by: Benjamin Schneider <ben@bens.haus>
---

Changes in v3:
- fix U-Boot typo
- fix comment also missing from linux

Changes in v2:
- upstream is missing a patch for PCIe mem

 arch/arm/dts/armada-3720-db.dts               |   4 +-
 .../arm/dts/armada-3720-espressobin-ultra.dts | 167 ++++++++++++++++++
 arch/arm/dts/armada-3720-espressobin.dts      |   2 +-
 arch/arm/dts/armada-3720-espressobin.dtsi     |  22 ++-
 arch/arm/dts/armada-3720-turris-mox.dts       | 131 ++++++++------
 arch/arm/dts/armada-3720-uDPU.dts             |   8 +-
 arch/arm/dts/armada-3720-uDPU.dtsi            |   8 +-
 arch/arm/dts/armada-372x.dtsi                 |   2 +-
 arch/arm/dts/armada-37xx.dtsi                 |  34 +++-
 9 files changed, 287 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/dts/armada-3720-espressobin-ultra.dts

diff --git a/arch/arm/dts/armada-3720-db.dts b/arch/arm/dts/armada-3720-db.dts
index 1ee92406b7..717c896b81 100644
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
index 595b4b5abb..db9d8242cd 100644
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
index 0bb4f60763..c2ca3cd13f 100644
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
@@ -416,14 +431,14 @@
 			crypto: crypto@90000 {
 				compatible = "inside-secure,safexcel-eip97ies";
 				reg = <0x90000 0x20000>;
-				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "mem", "ring0", "ring1",
-						  "ring2", "ring3", "eip";
+					     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "ring0", "ring1", "ring2",
+						  "ring3", "eip", "mem";
 				clocks = <&nb_periph_clk 15>;
 			};
 
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
@@ -489,6 +504,7 @@
 			bus-range = <0x00 0xff>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <1>;
+			clocks = <&sb_periph_clk 13>;
 			msi-parent = <&pcie0>;
 			msi-controller;
 			/*
-- 
2.34.1

