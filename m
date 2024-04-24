Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A60EC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 00:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5979988CF3;
	Wed, 24 Apr 2024 02:18:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF8F88CEC; Wed, 24 Apr 2024 02:18:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9B87888CEE
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91EB6DA7;
 Tue, 23 Apr 2024 17:18:55 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8843F7BD;
 Tue, 23 Apr 2024 17:18:26 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 1/4] sunxi: dts: arm/arm64: update devicetree files from
 Linux-v6.9-rc4
Date: Wed, 24 Apr 2024 01:18:05 +0100
Message-Id: <20240424001808.14388-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240424001808.14388-1-andre.przywara@arm.com>
References: <20240424001808.14388-1-andre.przywara@arm.com>
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

Sync the devicetree files from the official Linux kernel tree, v6.9-rc4.
This is covering Allwinner SoCs with 32-bit and 64-bit ARM cores.

Besides some cosmectic changes, this adds S/PDIF, DMA, and thermal
support to the H616 .dtsi. Nothing that U-Boot needs for itself, but
helpful to pass on to kernels.
This also adds new devicetrees, for some LonganPi H616 board, and the
Remix Mini PC. The latter will get a defconfig next.

As before, this omits the non-backwards compatible changes to the R_INTC
controller, to remain compatible with older kernels.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/sun50i-h6-beelink-gs1.dts        |   2 +
 arch/arm/dts/sun50i-h6-tanix.dtsi             |   2 +
 arch/arm/dts/sun50i-h6.dtsi                   |   7 +-
 .../dts/sun50i-h616-bigtreetech-cb1-manta.dts |   2 +-
 arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi |   4 +-
 arch/arm/dts/sun50i-h616-bigtreetech-pi.dts   |   2 +-
 arch/arm/dts/sun50i-h616.dtsi                 | 155 ++++++++
 .../arm/dts/sun50i-h618-longan-module-3h.dtsi |  75 ++++
 arch/arm/dts/sun50i-h618-longanpi-3h.dts      | 144 +++++++
 .../arm/dts/sun50i-h618-transpeed-8k618-t.dts |  23 ++
 arch/arm/dts/sun50i-h64-remix-mini-pc.dts     | 356 ++++++++++++++++++
 arch/arm/dts/sun8i-r40-feta40i.dtsi           |   7 +
 12 files changed, 771 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
 create mode 100644 arch/arm/dts/sun50i-h618-longanpi-3h.dts
 create mode 100644 arch/arm/dts/sun50i-h64-remix-mini-pc.dts

diff --git a/arch/arm/dts/sun50i-h6-beelink-gs1.dts b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
index d6897ec9799..87432c4f1ff 100644
--- a/arch/arm/dts/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm/dts/sun50i-h6-beelink-gs1.dts
@@ -291,6 +291,8 @@
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/sun50i-h6-tanix.dtsi b/arch/arm/dts/sun50i-h6-tanix.dtsi
index 4903d635811..855b7d43bc5 100644
--- a/arch/arm/dts/sun50i-h6-tanix.dtsi
+++ b/arch/arm/dts/sun50i-h6-tanix.dtsi
@@ -166,6 +166,8 @@
 };
 
 &spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spdif_tx_pin>;
 	status = "okay";
 };
 
diff --git a/arch/arm/dts/sun50i-h6.dtsi b/arch/arm/dts/sun50i-h6.dtsi
index 3c85c8cc8ea..09e21689284 100644
--- a/arch/arm/dts/sun50i-h6.dtsi
+++ b/arch/arm/dts/sun50i-h6.dtsi
@@ -405,6 +405,7 @@
 				function = "spi1";
 			};
 
+			/omit-if-no-ref/
 			spdif_tx_pin: spdif-tx-pin {
 				pins = "PH7";
 				function = "spdif";
@@ -654,10 +655,8 @@
 			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			resets = <&ccu RST_BUS_SPDIF>;
-			dmas = <&dma 2>;
-			dma-names = "tx";
-			pinctrl-names = "default";
-			pinctrl-0 = <&spdif_tx_pin>;
+			dmas = <&dma 2>, <&dma 2>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts b/arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts
index dbce61b355d..4bfb52609c9 100644
--- a/arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts
+++ b/arch/arm/dts/sun50i-h616-bigtreetech-cb1-manta.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
  */
diff --git a/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi b/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
index 1fed2b46cfe..af421ba24ce 100644
--- a/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
+++ b/arch/arm/dts/sun50i-h616-bigtreetech-cb1.dtsi
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
  */
@@ -93,7 +93,7 @@
 		interrupt-controller;
 		#interrupt-cells = <1>;
 
-		regulators{
+		regulators {
 			reg_dcdc1: dcdc1 {
 				regulator-name = "vdd-gpu-sys";
 				regulator-min-microvolt = <810000>;
diff --git a/arch/arm/dts/sun50i-h616-bigtreetech-pi.dts b/arch/arm/dts/sun50i-h616-bigtreetech-pi.dts
index 832f08b2b26..ff84a379447 100644
--- a/arch/arm/dts/sun50i-h616-bigtreetech-pi.dts
+++ b/arch/arm/dts/sun50i-h616-bigtreetech-pi.dts
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
  * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
  */
diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
index d549d277d97..b2e85e52d1a 100644
--- a/arch/arm/dts/sun50i-h616.dtsi
+++ b/arch/arm/dts/sun50i-h616.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/reset/sun50i-h616-ccu.h>
 #include <dt-bindings/reset/sun50i-h6-r-ccu.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -133,11 +134,28 @@
 			#reset-cells = <1>;
 		};
 
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun50i-h616-dma",
+				     "allwinner,sun50i-a100-dma";
+			reg = <0x03002000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			dma-channels = <16>;
+			dma-requests = <49>;
+			resets = <&ccu RST_BUS_DMA>;
+			#dma-cells = <1>;
+		};
+
 		sid: efuse@3006000 {
 			compatible = "allwinner,sun50i-h616-sid", "allwinner,sun50i-a64-sid";
 			reg = <0x03006000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: thermal-sensor-calibration@14 {
+				reg = <0x14 0x8>;
+			};
 		};
 
 		watchdog: watchdog@30090a0 {
@@ -240,6 +258,11 @@
 				function = "spi1";
 			};
 
+			spdif_tx_pin: spdif-tx-pin {
+				pins = "PH4";
+				function = "spdif";
+			};
+
 			uart0_ph_pins: uart0-ph-pins {
 				pins = "PH0", "PH1";
 				function = "uart0";
@@ -256,6 +279,12 @@
 				pins = "PG8", "PG9";
 				function = "uart1";
 			};
+
+			/omit-if-no-ref/
+			x32clk_fanout_pin: x32clk-fanout-pin {
+				pins = "PG10";
+				function = "clock";
+			};
 		};
 
 		gic: interrupt-controller@3021000 {
@@ -339,6 +368,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
@@ -350,6 +381,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
@@ -361,6 +394,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
@@ -372,6 +407,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART3>;
 			status = "disabled";
 		};
@@ -383,6 +420,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART4>;
+			dmas = <&dma 18>, <&dma 18>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART4>;
 			status = "disabled";
 		};
@@ -394,6 +433,8 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART5>;
+			dmas = <&dma 19>, <&dma 19>;
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART5>;
 			status = "disabled";
 		};
@@ -405,6 +446,8 @@
 			reg = <0x05002000 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C0>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins>;
@@ -420,6 +463,8 @@
 			reg = <0x05002400 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -433,6 +478,8 @@
 			reg = <0x05002800 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -446,6 +493,8 @@
 			reg = <0x05002c00 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C3>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -459,6 +508,8 @@
 			reg = <0x05003000 0x400>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_I2C4>;
+			dmas = <&dma 47>, <&dma 47>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_I2C4>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -472,6 +523,8 @@
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_SPI0>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -485,6 +538,8 @@
 			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
 			resets = <&ccu RST_BUS_SPI1>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -511,6 +566,34 @@
 			};
 		};
 
+		spdif: spdif@5093000 {
+			compatible = "allwinner,sun50i-h616-spdif";
+			reg = <0x05093000 0x400>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			clock-names = "apb", "spdif";
+			resets = <&ccu RST_BUS_SPDIF>;
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		ths: thermal-sensor@5070400 {
+			compatible = "allwinner,sun50i-h616-ths";
+			reg = <0x05070400 0x400>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_THS>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_THS>;
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+			allwinner,sram = <&syscon>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		usbotg: usb@5100000 {
 			compatible = "allwinner,sun50i-h616-musb",
 				     "allwinner,sun8i-h3-musb";
@@ -734,6 +817,8 @@
 			reg = <0x07081400 0x400>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB2_I2C>;
+			dmas = <&dma 48>, <&dma 48>;
+			dma-names = "rx", "tx";
 			resets = <&r_ccu RST_R_APB2_I2C>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -755,4 +840,74 @@
 			#size-cells = <0>;
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <500>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths 2>;
+			sustainable-power = <1000>;
+
+			trips {
+				cpu_threshold: cpu-trip-0 {
+					temperature = <60000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu_target: cpu-trip-1 {
+					temperature = <70000>;
+					type = "passive";
+					hysteresis = <0>;
+				};
+				cpu_critical: cpu-trip-2 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <500>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths 0>;
+			sustainable-power = <1100>;
+
+			trips {
+				gpu_temp_critical: gpu-trip-0 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+
+		ve-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 1>;
+
+			trips {
+				ve_temp_critical: ve-trip-0 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+
+		ddr-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&ths 3>;
+
+			trips {
+				ddr_temp_critical: ddr-trip-0 {
+					temperature = <110000>;
+					type = "critical";
+					hysteresis = <0>;
+				};
+			};
+		};
+	};
 };
diff --git a/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi b/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
new file mode 100644
index 00000000000..8c1263a3939
--- /dev/null
+++ b/arch/arm/dts/sun50i-h618-longan-module-3h.dtsi
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include "sun50i-h616.dtsi"
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp313: pmic@36 {
+		compatible = "x-powers,axp313a";
+		reg = <0x36>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-1v8-pll";
+			};
+
+			reg_dldo1: dldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-3v3-io";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <990000>;
+				regulator-name = "vdd-gpu-sys";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-always-on;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-dram";
+			};
+		};
+	};
+};
+
+&pio {
+	vcc-pc-supply = <&reg_dldo1>;
+	vcc-pf-supply = <&reg_dldo1>;
+	vcc-pg-supply = <&reg_aldo1>;
+	vcc-ph-supply = <&reg_dldo1>;
+	vcc-pi-supply = <&reg_dldo1>;
+};
diff --git a/arch/arm/dts/sun50i-h618-longanpi-3h.dts b/arch/arm/dts/sun50i-h618-longanpi-3h.dts
new file mode 100644
index 00000000000..18b29c6b867
--- /dev/null
+++ b/arch/arm/dts/sun50i-h618-longanpi-3h.dts
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/dts-v1/;
+
+#include "sun50i-h618-longan-module-3h.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Sipeed Longan Pi 3H";
+	compatible = "sipeed,longan-pi-3h", "sipeed,longan-module-3h", "allwinner,sun50i-h618";
+
+	aliases {
+		ethernet0 = &emac0;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <0>;
+			gpios = <&pio 6 2 GPIO_ACTIVE_LOW>; /* PG2 */
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_ORANGE>;
+			function = LED_FUNCTION_INDICATOR;
+			function-enumerator = <1>;
+			gpios = <&pio 6 4 GPIO_ACTIVE_LOW>; /* PG4 */
+		};
+	};
+
+	reg_vcc5v: regulator-vcc5v {
+		/* board wide 5V supply directly from the USB-C socket */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&reg_vcc5v>;
+	};
+};
+
+&axp313 {
+	vin1-supply = <&reg_vcc5v>;
+	vin2-supply = <&reg_vcc5v>;
+	vin3-supply = <&reg_vcc5v>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+/* WiFi & BT combo module is connected to this Host */
+&ehci3 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&emac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	allwinner,rx-delay-ps = <3100>;
+	allwinner,tx-delay-ps = <700>;
+	phy-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&mdio0 {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;	/* PF6 */
+	vmmc-supply = <&reg_vcc3v3>;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usbotg {
+	/*
+	 * PHY0 pins are connected to a USB-C socket, but a role switch
+	 * is not implemented: both CC pins are pulled to GND.
+	 * The VBUS pins power the device, so a fixed peripheral mode
+	 * is the best choice.
+	 * The board can be powered via GPIOs, in this case port0 *can*
+	 * act as a host (with a cable/adapter ignoring CC), as VBUS is
+	 * then provided by the GPIOs. Any user of this setup would
+	 * need to adjust the DT accordingly: dr_mode set to "host",
+	 * enabling OHCI0 and EHCI0.
+	 */
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc5v>;
+	usb2_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
index 8ea1fd41aeb..ac0a2b7ea6f 100644
--- a/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
+++ b/arch/arm/dts/sun50i-h618-transpeed-8k618-t.dts
@@ -15,6 +15,7 @@
 	compatible = "transpeed,8k618-t", "allwinner,sun50i-h618";
 
 	aliases {
+		ethernet1 = &sdio_wifi;
 		serial0 = &uart0;
 	};
 
@@ -39,6 +40,15 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		pinctrl-0 = <&x32clk_fanout_pin>;
+		pinctrl-names = "default";
+		reset-gpios = <&pio 6 18 GPIO_ACTIVE_LOW>; /* PG18 */
+	};
 };
 
 &ehci0 {
@@ -60,6 +70,19 @@
 	status = "okay";
 };
 
+&mmc1 {
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_aldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: wifi@1 {
+		reg = <1>;
+	};
+};
+
 &mmc2 {
 	vmmc-supply = <&reg_dldo1>;
 	vqmmc-supply = <&reg_aldo1>;
diff --git a/arch/arm/dts/sun50i-h64-remix-mini-pc.dts b/arch/arm/dts/sun50i-h64-remix-mini-pc.dts
new file mode 100644
index 00000000000..b6e3c169797
--- /dev/null
+++ b/arch/arm/dts/sun50i-h64-remix-mini-pc.dts
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2023 ARM Ltd.
+
+/dts-v1/;
+
+#include "sun50i-a64.dtsi"
+#include "sun50i-a64-cpu-opp.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	model = "Remix Mini PC";
+	compatible = "jide,remix-mini-pc", "allwinner,sun50i-h64",
+		     "allwinner,sun50i-a64";
+
+	aliases {
+		ethernet1 = &rtl8723bs;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	reg_vcc5v: regulator-5v {
+		/* board wide 5V supply directly from the DC input */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&codec {
+	status = "okay";
+};
+
+&codec_analog {
+	cpvdd-supply = <&reg_eldo1>;
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu1 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu2 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&cpu3 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
+&dai {
+	status = "okay";
+};
+
+&de {
+	status = "okay";
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
+&hdmi {
+	hvcc-supply = <&reg_dldo1>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+/* Connects to the AC200 chip */
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c0_pins {
+	bias-pull-up;
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_dcdc1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_aldo1>;
+	vqmmc-supply = <&reg_dldo4>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8723bs: wifi@1 {
+		reg = <1>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>, <&mmc2_ds_pin>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_eldo1>;
+	bus-width = <8>;
+	non-removable;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-hw-reset;
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
+	vcc-pb-supply = <&reg_dcdc1>;
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_dcdc1>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_dldo4>;
+	vcc-ph-supply = <&reg_dcdc1>;
+};
+
+&r_ir {
+	status = "okay";
+};
+
+&r_pio {
+	/*
+	 * We cannot add that supply for now since it would create a circular
+	 * dependency between pinctrl, the regulator and the RSB Bus.
+	 *
+	 * vcc-pl-supply = <&reg_aldo2>;
+	 */
+};
+
+&r_rsb {
+	status = "okay";
+
+	axp803: pmic@3a3 {
+		compatible = "x-powers,axp803";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_LOW>;
+		x-powers,drive-vbus-en;
+
+		vin1-supply = <&reg_vcc5v>;
+		vin2-supply = <&reg_vcc5v>;
+		vin3-supply = <&reg_vcc5v>;
+		vin5-supply = <&reg_vcc5v>;
+		vin6-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		dldoin-supply = <&reg_vcc5v>;
+		eldoin-supply = <&reg_vcc5v>;
+		fldoin-supply = <&reg_vcc5v>;
+		drivevbus-supply = <&reg_vcc5v>;
+		ips-supply = <&reg_vcc5v>;
+
+		status = "okay";
+	};
+};
+
+#include "axp803.dtsi"
+
+&ac_power_supply {
+	status = "okay";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1040000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-cpux";
+};
+
+/* DCDC3 is polyphased with DCDC2 */
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+/* Deviates from the reset default of 1.1V. */
+&reg_dcdc6 {
+	regulator-always-on;
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_aldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_aldo2 {
+	/* Specifying R_PIO consumer would create circular dependency. */
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pl";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-pll-avcc";
+};
+
+/* AC200 power supply */
+&reg_dldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ave-33";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-io";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_eldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-cpvdd-dram-emmc";
+};
+
+/* Supplies the arisc management core, needed by TF-A to power off cores. */
+&reg_fldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
+
+&simplefb_hdmi {
+	vcc-hdmi-supply = <&reg_dcdc1>;
+};
+
+&sound {
+	simple-audio-card,aux-devs = <&codec_analog>;
+	simple-audio-card,widgets = "Microphone", "Microphone Jack",
+				    "Headphone", "Headphone Jack";
+	simple-audio-card,routing =
+			"Left DAC", "DACL",
+			"Right DAC", "DACR",
+			"Headphone Jack", "HP",
+			"ADCL", "Left ADC",
+			"ADCR", "Right ADC",
+			"MIC2", "Microphone Jack";
+	status = "okay";
+};
+
+/* On the (unpopulated) UART pads. */
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pb_pins>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "realtek,rtl8723bs-bt";
+		enable-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		max-speed = <1500000>;
+	};
+};
+
+&usb_otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy {
+	usb0_vbus-supply = <&reg_drivevbus>;
+	usb1_vbus-supply = <&reg_drivevbus>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/sun8i-r40-feta40i.dtsi b/arch/arm/dts/sun8i-r40-feta40i.dtsi
index 9f39b5a2bb3..c12361d0317 100644
--- a/arch/arm/dts/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/dts/sun8i-r40-feta40i.dtsi
@@ -42,6 +42,13 @@
 	vcc-pg-supply = <&reg_dldo1>;
 };
 
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3-tv-usb";
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1800000>;
-- 
2.35.8

