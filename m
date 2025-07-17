Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CBAC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 23:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5396F835B9;
	Fri, 18 Jul 2025 01:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B4B08354B; Fri, 18 Jul 2025 01:57:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 61E1A83616
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 01:57:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494A21762;
 Thu, 17 Jul 2025 16:57:07 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B64863F694;
 Thu, 17 Jul 2025 16:57:13 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/20] arm64: dts: allwinner: a523: add X96Q-Pro+ support
Date: Fri, 18 Jul 2025 00:54:52 +0100
Message-ID: <20250717235455.32528-18-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250717235455.32528-1-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
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

The X96QPro+ is a TV box using the Allwinner H728 SoC. That SoC seems to
be a package variant of the A523 family, at least it uses the same SoC
ID and is compatible as far as we can assess.

It comes with the following specs:
  - Allwinner H728 SoC: 8 Arm Cortex-A55 cores, Mali-G57 MC1 GPU
  - 2 or 4GiB DDR3L DRAM
  - 32, 64, or 128 GiB eMMC flash
  - AXP717 + AXP323 PMICs
  - Gigabit Ethernet (using MAXIO PHY)
  - HDMI port
  - 2 * USB 2.0 ports
  - 1 * USB 3.0 port
  - microSD card slot
  - TOSLINK digital audio output
  - 3.5mm A/V port
  - infrared sensor
  - 7-segment display
  - 5V barrel plug power supply
  - power button

The PCB provides holes for soldering a UART header or cable, this is
connected to the debug UART0. There is another set of UART pins
available. The board also features a FEL button (accessible through the
3.5mm socket) and a reset button (only accessible when case is open).

This .dts just describes the basic peripherals as far as we support them
at the moment. The PMIC rail assignments are reverse engineered as far
as possible, by dumping them from a running Android system, and correlating
them to other boards using the same SoC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://patch.msgid.link/20250307005712.16828-13-andre.przywara@arm.com
[wens@csie.org: Squash in SD card detect pull resistor fix]
Link: https://patch.msgid.link/20250425003422.3465-1-andre.przywara@arm.com
Signed-off-by: Chen-Yu Tsai <wens@csie.org>

[ upstream commit: 4ee87d875071390b4e24ce46dbdd792216d61651 ]

(cherry picked from commit 693da0a03149b77a3e2bc11cfd314df8cc2fab40)
---
 .../arm64/allwinner/sun55i-h728-x96qpro+.dts  | 287 ++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 dts/upstream/src/arm64/allwinner/sun55i-h728-x96qpro+.dts

diff --git a/dts/upstream/src/arm64/allwinner/sun55i-h728-x96qpro+.dts b/dts/upstream/src/arm64/allwinner/sun55i-h728-x96qpro+.dts
new file mode 100644
index 00000000000..59db103546f
--- /dev/null
+++ b/dts/upstream/src/arm64/allwinner/sun55i-h728-x96qpro+.dts
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+// Copyright (C) 2024 Arm Ltd.
+
+/dts-v1/;
+
+#include "sun55i-a523.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "X96Q Pro+";
+	compatible = "amediatech,x96q-pro-plus", "allwinner,sun55i-h728";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext_osc32k";
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply from the barrel plug */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: vcc3v3 {
+		/* 3.3V dummy supply for the SD card */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc5v>;
+		regulator-always-on;
+	};
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>; /* PF6 */
+	bus-width = <4>;
+	disable-wp;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_cldo3>;
+	vqmmc-supply = <&reg_cldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pb-supply = <&reg_cldo3>;	/* via VCC-IO */
+	vcc-pc-supply = <&reg_cldo1>;
+	vcc-pd-supply = <&reg_dcdc4>;
+	vcc-pe-supply = <&reg_dcdc4>;
+	vcc-pf-supply = <&reg_cldo3>;	/* actually switchable */
+	vcc-pg-supply = <&reg_bldo1>;
+	vcc-ph-supply = <&reg_cldo3>;	/* via VCC-IO */
+	vcc-pi-supply = <&reg_dcdc4>;
+	vcc-pj-supply = <&reg_dcdc4>;
+	vcc-pk-supply = <&reg_bldo3>;
+};
+
+&r_i2c0 {
+	status = "okay";
+
+	axp717: pmic@34 {
+		compatible = "x-powers,axp717";
+		reg = <0x34>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+		vin4-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			/* Supplies the "little" cluster (1.0(?) GHz cores) */
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-name = "vdd-cpul";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <920000>;
+				regulator-max-microvolt = <920000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1360000>;
+				regulator-max-microvolt = <1360000>;
+				regulator-name = "vdd-dram";
+			};
+
+			reg_dcdc4: dcdc4 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd-dcdc4";
+			};
+
+			reg_aldo1: aldo1 {
+				/* not connected */
+			};
+
+			reg_aldo2: aldo2 {
+				/* not connected */
+			};
+
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-aldo3";
+			};
+
+			reg_aldo4: aldo4 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pll-dxco-avcc";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pg-wifi-lvds";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-dram-1v8";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-name = "vcc-bldo3";
+			};
+
+			reg_bldo4: bldo4 {
+				/* not connected */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-codec-sd";
+			};
+
+			reg_cldo2: cldo2 {
+			};
+
+			reg_cldo3: cldo3 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-codec-eth-sd";
+			};
+
+			reg_cldo4: cldo4 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-eth-phy";
+			};
+
+			reg_cpusldo: cpusldo {
+				/* supplies the management core */
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-name = "vdd-cpus";
+			};
+		};
+	};
+
+	axp323: pmic@36 {
+		compatible = "x-powers,axp323";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+
+		regulators {
+			aldo1 {
+				/* not connected */
+			};
+
+			dldo1 {
+				/* not connected */
+			};
+
+			/* Supplies the "big" cluster (1.8 GHz cores) */
+			reg_dcdc1_323: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-name = "vdd-cpub";
+			};
+
+			/* DCDC2 is polyphased with DCDC1 */
+
+			reg_dcdc3_323: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1050000>;
+				regulator-max-microvolt = <1050000>;
+				regulator-name = "vdd-dcdc3";
+			};
+		};
+	};
+};
+
+&r_pio {
+/*
+ * Specifying the supply would create a circular dependency.
+ *
+ *	vcc-pl-supply = <&reg_aldo3>;
+ */
+	vcc-pm-supply = <&reg_aldo3>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&usb_otg {
+	/* USB0 is a USB-A receptacle, always powered, so force host mode. */
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	status = "okay";
+};
-- 
2.46.3

