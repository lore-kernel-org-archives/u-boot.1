Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10191E743C9
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639E986EC9;
	Thu, 28 Sep 2023 23:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E1F186E22; Thu, 28 Sep 2023 23:56:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4ADC886EC6
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E20E1063;
 Thu, 28 Sep 2023 14:57:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A96A3F59C;
 Thu, 28 Sep 2023 14:56:38 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 20/22] riscv: dts: allwinner: Add the D1/D1s SoC devicetree
Date: Thu, 28 Sep 2023 22:54:53 +0100
Message-Id: <20230928215455.28094-21-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

From: Samuel Holland <samuel@sholland.org>

D1 (aka D1-H), D1s (aka F133), R528, and T113 are a family of SoCs based
on a single die, or at a pair of dies derived from the same design.

D1 and D1s contain a single T-HEAD Xuantie C906 CPU, whereas R528 and
T113 contain a pair of Cortex-A7's. D1 and R528 are the full version of
the chip with a BGA package, whereas D1s and T113 are low-pin-count QFP
variants.

Because the original design supported both ARM and RISC-V CPUs, some
peripherals are duplicated. In addition, all variants except D1s contain
a HiFi 4 DSP with its own set of peripherals.

The devicetrees are organized to minimize duplication:
 - Common perhiperals are described in sunxi-d1s-t113.dtsi
 - DSP-related peripherals are described in sunxi-d1-t113.dtsi
 - RISC-V specific hardware is described in sun20i-d1s.dtsi
 - Functionality unique to the D1 variant is described in sun20i-d1.dtsi

The SOC_PERIPHERAL_IRQ macro handles the different #interrupt-cells
values between the ARM (GIC) and RISC-V (PLIC) versions of the SoC.

The files have been copied from a Linux v6.6-rc3 source tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/riscv/dts/sun20i-common-regulators.dtsi |  28 +
 arch/riscv/dts/sun20i-d1.dtsi                |  66 ++
 arch/riscv/dts/sun20i-d1s.dtsi               |  76 ++
 arch/riscv/dts/sunxi-d1-t113.dtsi            |  15 +
 arch/riscv/dts/sunxi-d1s-t113.dtsi           | 927 +++++++++++++++++++
 include/dt-bindings/clock/sun20i-d1-r-ccu.h  |  19 +
 include/dt-bindings/reset/sun20i-d1-r-ccu.h  |  16 +
 7 files changed, 1147 insertions(+)
 create mode 100644 arch/riscv/dts/sun20i-common-regulators.dtsi
 create mode 100644 arch/riscv/dts/sun20i-d1.dtsi
 create mode 100644 arch/riscv/dts/sun20i-d1s.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1-t113.dtsi
 create mode 100644 arch/riscv/dts/sunxi-d1s-t113.dtsi
 create mode 100644 include/dt-bindings/clock/sun20i-d1-r-ccu.h
 create mode 100644 include/dt-bindings/reset/sun20i-d1-r-ccu.h

diff --git a/arch/riscv/dts/sun20i-common-regulators.dtsi b/arch/riscv/dts/sun20i-common-regulators.dtsi
new file mode 100644
index 00000000000..9b03fca2444
--- /dev/null
+++ b/arch/riscv/dts/sun20i-common-regulators.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+/ {
+	reg_vcc: vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_vcc_3v3: vcc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&reg_vcc>;
+	};
+};
+
+&pio {
+	vcc-pb-supply = <&reg_vcc_3v3>;
+	vcc-pc-supply = <&reg_vcc_3v3>;
+	vcc-pd-supply = <&reg_vcc_3v3>;
+	vcc-pe-supply = <&reg_vcc_3v3>;
+	vcc-pf-supply = <&reg_vcc_3v3>;
+	vcc-pg-supply = <&reg_vcc_3v3>;
+};
diff --git a/arch/riscv/dts/sun20i-d1.dtsi b/arch/riscv/dts/sun20i-d1.dtsi
new file mode 100644
index 00000000000..97e7cbb3259
--- /dev/null
+++ b/arch/riscv/dts/sun20i-d1.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include "sun20i-d1s.dtsi"
+#include "sunxi-d1-t113.dtsi"
+
+/ {
+	soc {
+		lradc: keys@2009800 {
+			compatible = "allwinner,sun20i-d1-lradc",
+				     "allwinner,sun50i-r329-lradc";
+			reg = <0x2009800 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(61) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LRADC>;
+			resets = <&ccu RST_BUS_LRADC>;
+			status = "disabled";
+		};
+
+		i2s0: i2s@2032000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2032000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(26) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>,
+				 <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S0>;
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+	};
+};
+
+&pio {
+	/omit-if-no-ref/
+	dmic_pb11_d0_pin: dmic-pb11-d0-pin {
+		pins = "PB11";
+		function = "dmic";
+	};
+
+	/omit-if-no-ref/
+	dmic_pe17_clk_pin: dmic-pe17-clk-pin {
+		pins = "PE17";
+		function = "dmic";
+	};
+
+	/omit-if-no-ref/
+	i2c0_pb10_pins: i2c0-pb10-pins {
+		pins = "PB10", "PB11";
+		function = "i2c0";
+	};
+
+	/omit-if-no-ref/
+	i2c2_pb0_pins: i2c2-pb0-pins {
+		pins = "PB0", "PB1";
+		function = "i2c2";
+	};
+
+	/omit-if-no-ref/
+	uart0_pb8_pins: uart0-pb8-pins {
+		pins = "PB8", "PB9";
+		function = "uart0";
+	};
+};
diff --git a/arch/riscv/dts/sun20i-d1s.dtsi b/arch/riscv/dts/sun20i-d1s.dtsi
new file mode 100644
index 00000000000..8275630af97
--- /dev/null
+++ b/arch/riscv/dts/sun20i-d1s.dtsi
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#define SOC_PERIPHERAL_IRQ(nr)	(nr + 16)
+
+#include "sunxi-d1s-t113.dtsi"
+
+/ {
+	cpus {
+		timebase-frequency = <24000000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "thead,c906", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&ccu CLK_RISCV>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <256>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			mmu-type = "riscv,sv39";
+			operating-points-v2 = <&opp_table_cpu>;
+			riscv,isa = "rv64imafdc";
+			#cooling-cells = <2>;
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	opp_table_cpu: opp-table-cpu {
+		compatible = "operating-points-v2";
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <900000 900000 1100000>;
+		};
+
+		opp-1080000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <900000 900000 1100000>;
+		};
+	};
+
+	soc {
+		interrupt-parent = <&plic>;
+
+		riscv_wdt: watchdog@6011000 {
+			compatible = "allwinner,sun20i-d1-wdt";
+			reg = <0x6011000 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(131) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+		};
+
+		plic: interrupt-controller@10000000 {
+			compatible = "allwinner,sun20i-d1-plic",
+				     "thead,c900-plic";
+			reg = <0x10000000 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>,
+					      <&cpu0_intc 9>;
+			interrupt-controller;
+			riscv,ndev = <175>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/riscv/dts/sunxi-d1-t113.dtsi b/arch/riscv/dts/sunxi-d1-t113.dtsi
new file mode 100644
index 00000000000..b7156123df5
--- /dev/null
+++ b/arch/riscv/dts/sunxi-d1-t113.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+/ {
+	soc {
+		dsp_wdt: watchdog@1700400 {
+			compatible = "allwinner,sun20i-d1-wdt";
+			reg = <0x1700400 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(122) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "reserved";
+		};
+	};
+};
diff --git a/arch/riscv/dts/sunxi-d1s-t113.dtsi b/arch/riscv/dts/sunxi-d1s-t113.dtsi
new file mode 100644
index 00000000000..822f022eec2
--- /dev/null
+++ b/arch/riscv/dts/sunxi-d1s-t113.dtsi
@@ -0,0 +1,927 @@
+// SPDX-License-Identifier: (GPL-2.0+ or MIT)
+// Copyright (C) 2021-2022 Samuel Holland <samuel@sholland.org>
+
+#include <dt-bindings/clock/sun6i-rtc.h>
+#include <dt-bindings/clock/sun8i-de2.h>
+#include <dt-bindings/clock/sun8i-tcon-top.h>
+#include <dt-bindings/clock/sun20i-d1-ccu.h>
+#include <dt-bindings/clock/sun20i-d1-r-ccu.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/sun8i-de2.h>
+#include <dt-bindings/reset/sun20i-d1-ccu.h>
+#include <dt-bindings/reset/sun20i-d1-r-ccu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	dcxo: dcxo-clk {
+		compatible = "fixed-clock";
+		clock-output-names = "dcxo";
+		#clock-cells = <0>;
+	};
+
+	de: display-engine {
+		compatible = "allwinner,sun20i-d1-display-engine";
+		allwinner,pipelines = <&mixer0>, <&mixer1>;
+		status = "disabled";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		ranges;
+		dma-noncoherent;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		pio: pinctrl@2000000 {
+			compatible = "allwinner,sun20i-d1-pinctrl";
+			reg = <0x2000000 0x800>;
+			interrupts = <SOC_PERIPHERAL_IRQ(69) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(71) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(73) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(75) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(77) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(79) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_APB0>,
+				 <&dcxo>,
+				 <&rtc CLK_OSC32K>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#gpio-cells = <3>;
+			#interrupt-cells = <3>;
+
+			/omit-if-no-ref/
+			can0_pins: can0-pins {
+				pins = "PB2", "PB3";
+				function = "can0";
+			};
+
+			/omit-if-no-ref/
+			can1_pins: can1-pins {
+				pins = "PB4", "PB5";
+				function = "can1";
+			};
+
+			/omit-if-no-ref/
+			clk_pg11_pin: clk-pg11-pin {
+				pins = "PG11";
+				function = "clk";
+			};
+
+			/omit-if-no-ref/
+			dsi_4lane_pins: dsi-4lane-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD9";
+				drive-strength = <30>;
+				function = "dsi";
+			};
+
+			/omit-if-no-ref/
+			lcd_rgb666_pins: lcd-rgb666-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5",
+				       "PD6", "PD7", "PD8", "PD9", "PD10", "PD11",
+				       "PD12", "PD13", "PD14", "PD15", "PD16", "PD17",
+				       "PD18", "PD19", "PD20", "PD21";
+				function = "lcd0";
+			};
+
+			/omit-if-no-ref/
+			mmc0_pins: mmc0-pins {
+				pins = "PF0", "PF1", "PF2", "PF3", "PF4", "PF5";
+				function = "mmc0";
+			};
+
+			/omit-if-no-ref/
+			mmc1_pins: mmc1-pins {
+				pins = "PG0", "PG1", "PG2", "PG3", "PG4", "PG5";
+				function = "mmc1";
+			};
+
+			/omit-if-no-ref/
+			mmc2_pins: mmc2-pins {
+				pins = "PC2", "PC3", "PC4", "PC5", "PC6", "PC7";
+				function = "mmc2";
+			};
+
+			/omit-if-no-ref/
+			rgmii_pe_pins: rgmii-pe-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9",
+				       "PE11", "PE12", "PE13", "PE14", "PE15";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			rmii_pe_pins: rmii-pe-pins {
+				pins = "PE0", "PE1", "PE2", "PE3", "PE4",
+				       "PE5", "PE6", "PE7", "PE8", "PE9";
+				function = "emac";
+			};
+
+			/omit-if-no-ref/
+			spi0_pins: spi0-pins {
+				pins = "PC2", "PC3", "PC4", "PC5";
+				function = "spi0";
+			};
+
+			/omit-if-no-ref/
+			uart1_pg6_pins: uart1-pg6-pins {
+				pins = "PG6", "PG7";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart1_pg8_rts_cts_pins: uart1-pg8-rts-cts-pins {
+				pins = "PG8", "PG9";
+				function = "uart1";
+			};
+
+			/omit-if-no-ref/
+			uart3_pb_pins: uart3-pb-pins {
+				pins = "PB6", "PB7";
+				function = "uart3";
+			};
+		};
+
+		ccu: clock-controller@2001000 {
+			compatible = "allwinner,sun20i-d1-ccu";
+			reg = <0x2001000 0x1000>;
+			clocks = <&dcxo>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		gpadc: adc@2009000 {
+			compatible = "allwinner,sun20i-d1-gpadc";
+			reg = <0x2009000 0x400>;
+			clocks = <&ccu CLK_BUS_GPADC>;
+			resets = <&ccu RST_BUS_GPADC>;
+			interrupts = <SOC_PERIPHERAL_IRQ(57) IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+			#io-channel-cells = <1>;
+		};
+
+		dmic: dmic@2031000 {
+			compatible = "allwinner,sun20i-d1-dmic",
+				     "allwinner,sun50i-h6-dmic";
+			reg = <0x2031000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(24) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMIC>,
+				 <&ccu CLK_DMIC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_DMIC>;
+			dmas = <&dma 8>;
+			dma-names = "rx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		i2s1: i2s@2033000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2033000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(27) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>,
+				 <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S1>;
+			dmas = <&dma 4>, <&dma 4>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		i2s2: i2s@2034000 {
+			compatible = "allwinner,sun20i-d1-i2s",
+				     "allwinner,sun50i-r329-i2s";
+			reg = <0x2034000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(28) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>,
+				 <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dmas = <&dma 5>, <&dma 5>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#sound-dai-cells = <0>;
+		};
+
+		timer: timer@2050000 {
+			compatible = "allwinner,sun20i-d1-timer",
+				     "allwinner,sun8i-a23-timer";
+			reg = <0x2050000 0xa0>;
+			interrupts = <SOC_PERIPHERAL_IRQ(59) IRQ_TYPE_LEVEL_HIGH>,
+				     <SOC_PERIPHERAL_IRQ(60) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>;
+		};
+
+		wdt: watchdog@20500a0 {
+			compatible = "allwinner,sun20i-d1-wdt-reset",
+				     "allwinner,sun20i-d1-wdt";
+			reg = <0x20500a0 0x20>;
+			interrupts = <SOC_PERIPHERAL_IRQ(63) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcxo>, <&rtc CLK_OSC32K>;
+			clock-names = "hosc", "losc";
+			status = "reserved";
+		};
+
+		uart0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500000 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(2) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			dmas = <&dma 14>, <&dma 14>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart1: serial@2500400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500400 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(3) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			dmas = <&dma 15>, <&dma 15>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart2: serial@2500800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500800 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(4) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			dmas = <&dma 16>, <&dma 16>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart3: serial@2500c00 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2500c00 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(5) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
+			dmas = <&dma 17>, <&dma 17>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart4: serial@2501000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2501000 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(6) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
+			dmas = <&dma 18>, <&dma 18>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		uart5: serial@2501400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x2501400 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupts = <SOC_PERIPHERAL_IRQ(7) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_UART5>;
+			resets = <&ccu RST_BUS_UART5>;
+			dmas = <&dma 19>, <&dma 19>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		i2c0: i2c@2502000 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(9) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
+			dmas = <&dma 43>, <&dma 43>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c1: i2c@2502400 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(10) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
+			dmas = <&dma 44>, <&dma 44>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c2: i2c@2502800 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502800 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(11) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
+			dmas = <&dma 45>, <&dma 45>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c3: i2c@2502c00 {
+			compatible = "allwinner,sun20i-d1-i2c",
+				     "allwinner,sun8i-v536-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x2502c00 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(12) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2C3>;
+			resets = <&ccu RST_BUS_I2C3>;
+			dmas = <&dma 46>, <&dma 46>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		can0: can@2504000 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(21) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN0>;
+			resets = <&ccu RST_BUS_CAN0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&can0_pins>;
+			status = "disabled";
+		};
+
+		can1: can@2504400 {
+			compatible = "allwinner,sun20i-d1-can";
+			reg = <0x02504400 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(22) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CAN1>;
+			resets = <&ccu RST_BUS_CAN1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&can1_pins>;
+			status = "disabled";
+		};
+
+		syscon: syscon@3000000 {
+			compatible = "allwinner,sun20i-d1-system-control";
+			reg = <0x3000000 0x1000>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		dma: dma-controller@3002000 {
+			compatible = "allwinner,sun20i-d1-dma";
+			reg = <0x3002000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(50) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DMA>, <&ccu CLK_MBUS_DMA>;
+			clock-names = "bus", "mbus";
+			resets = <&ccu RST_BUS_DMA>;
+			dma-channels = <16>;
+			dma-requests = <48>;
+			#dma-cells = <1>;
+		};
+
+		sid: efuse@3006000 {
+			compatible = "allwinner,sun20i-d1-sid";
+			reg = <0x3006000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
+		crypto: crypto@3040000 {
+			compatible = "allwinner,sun20i-d1-crypto";
+			reg = <0x3040000 0x800>;
+			interrupts = <SOC_PERIPHERAL_IRQ(52) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_CE>,
+				 <&ccu CLK_CE>,
+				 <&ccu CLK_MBUS_CE>,
+				 <&rtc CLK_IOSC>;
+			clock-names = "bus", "mod", "ram", "trng";
+			resets = <&ccu RST_BUS_CE>;
+		};
+
+		mbus: dram-controller@3102000 {
+			compatible = "allwinner,sun20i-d1-mbus";
+			reg = <0x3102000 0x1000>,
+			      <0x3103000 0x1000>;
+			reg-names = "mbus", "dram";
+			interrupts = <SOC_PERIPHERAL_IRQ(43) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_MBUS>,
+				 <&ccu CLK_DRAM>,
+				 <&ccu CLK_BUS_DRAM>;
+			clock-names = "mbus", "dram", "bus";
+			dma-ranges = <0 0x40000000 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interconnect-cells = <1>;
+		};
+
+		mmc0: mmc@4020000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4020000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(40) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC0>;
+			reset-names = "ahb";
+			cap-sd-highspeed;
+			max-frequency = <150000000>;
+			no-mmc;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc1: mmc@4021000 {
+			compatible = "allwinner,sun20i-d1-mmc";
+			reg = <0x4021000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(41) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC1>;
+			reset-names = "ahb";
+			cap-sd-highspeed;
+			max-frequency = <150000000>;
+			no-mmc;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		mmc2: mmc@4022000 {
+			compatible = "allwinner,sun20i-d1-emmc",
+				     "allwinner,sun50i-a100-emmc";
+			reg = <0x4022000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(42) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
+			resets = <&ccu RST_BUS_MMC2>;
+			reset-names = "ahb";
+			cap-mmc-highspeed;
+			max-frequency = <150000000>;
+			mmc-ddr-1_8v;
+			mmc-ddr-3_3v;
+			no-sd;
+			no-sdio;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi0: spi@4025000 {
+			compatible = "allwinner,sun20i-d1-spi",
+				     "allwinner,sun50i-r329-spi";
+			reg = <0x04025000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(15) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 22>, <&dma 22>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi@4026000 {
+			compatible = "allwinner,sun20i-d1-spi-dbi",
+				     "allwinner,sun50i-r329-spi-dbi",
+				     "allwinner,sun50i-r329-spi";
+			reg = <0x04026000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(16) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma 23>, <&dma 23>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		usb_otg: usb@4100000 {
+			compatible = "allwinner,sun20i-d1-musb",
+				     "allwinner,sun8i-a33-musb";
+			reg = <0x4100000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(29) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
+			extcon = <&usbphy 0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		usbphy: phy@4100400 {
+			compatible = "allwinner,sun20i-d1-usb-phy";
+			reg = <0x4100400 0x100>,
+			      <0x4101800 0x100>,
+			      <0x4200800 0x100>;
+			reg-names = "phy_ctrl",
+				    "pmu0",
+				    "pmu1";
+			clocks = <&dcxo>,
+				 <&dcxo>;
+			clock-names = "usb0_phy",
+				      "usb1_phy";
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
+			reset-names = "usb0_reset",
+				      "usb1_reset";
+			status = "disabled";
+			#phy-cells = <1>;
+		};
+
+		ehci0: usb@4101000 {
+			compatible = "allwinner,sun20i-d1-ehci",
+				     "generic-ehci";
+			reg = <0x4101000 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(30) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_BUS_EHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>,
+				 <&ccu RST_BUS_EHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@4101400 {
+			compatible = "allwinner,sun20i-d1-ohci",
+				     "generic-ohci";
+			reg = <0x4101400 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(31) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI0>,
+				 <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_BUS_OHCI0>;
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb@4200000 {
+			compatible = "allwinner,sun20i-d1-ehci",
+				     "generic-ehci";
+			reg = <0x4200000 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(33) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_BUS_EHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>,
+				 <&ccu RST_BUS_EHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@4200400 {
+			compatible = "allwinner,sun20i-d1-ohci",
+				     "generic-ohci";
+			reg = <0x4200400 0x100>;
+			interrupts = <SOC_PERIPHERAL_IRQ(34) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_OHCI1>;
+			phys = <&usbphy 1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		emac: ethernet@4500000 {
+			compatible = "allwinner,sun20i-d1-emac",
+				     "allwinner,sun50i-a64-emac";
+			reg = <0x4500000 0x10000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(46) IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&ccu CLK_BUS_EMAC>;
+			clock-names = "stmmaceth";
+			resets = <&ccu RST_BUS_EMAC>;
+			reset-names = "stmmaceth";
+			syscon = <&syscon>;
+			status = "disabled";
+
+			mdio: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		display_clocks: clock-controller@5000000 {
+			compatible = "allwinner,sun20i-d1-de2-clk",
+				     "allwinner,sun50i-h5-de2-clk";
+			reg = <0x5000000 0x10000>;
+			clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		mixer0: mixer@5100000 {
+			compatible = "allwinner,sun20i-d1-de2-mixer-0";
+			reg = <0x5100000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER0>,
+				 <&display_clocks CLK_MIXER0>;
+			clock-names = "bus", "mod";
+			resets = <&display_clocks RST_MIXER0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer0_out: port@1 {
+					reg = <1>;
+
+					mixer0_out_tcon_top_mixer0: endpoint {
+						remote-endpoint = <&tcon_top_mixer0_in_mixer0>;
+					};
+				};
+			};
+		};
+
+		mixer1: mixer@5200000 {
+			compatible = "allwinner,sun20i-d1-de2-mixer-1";
+			reg = <0x5200000 0x100000>;
+			clocks = <&display_clocks CLK_BUS_MIXER1>,
+				 <&display_clocks CLK_MIXER1>;
+			clock-names = "bus", "mod";
+			resets = <&display_clocks RST_MIXER1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				mixer1_out: port@1 {
+					reg = <1>;
+
+					mixer1_out_tcon_top_mixer1: endpoint {
+						remote-endpoint = <&tcon_top_mixer1_in_mixer1>;
+					};
+				};
+			};
+		};
+
+		dsi: dsi@5450000 {
+			compatible = "allwinner,sun20i-d1-mipi-dsi",
+				     "allwinner,sun50i-a100-mipi-dsi";
+			reg = <0x5450000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&tcon_top CLK_TCON_TOP_DSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			phys = <&dphy>;
+			phy-names = "dphy";
+			status = "disabled";
+
+			port {
+				dsi_in_tcon_lcd0: endpoint {
+					remote-endpoint = <&tcon_lcd0_out_dsi>;
+				};
+			};
+		};
+
+		dphy: phy@5451000 {
+			compatible = "allwinner,sun20i-d1-mipi-dphy",
+				     "allwinner,sun50i-a100-mipi-dphy";
+			reg = <0x5451000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(92) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_MIPI_DSI>,
+				 <&ccu CLK_MIPI_DSI>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_MIPI_DSI>;
+			#phy-cells = <0>;
+		};
+
+		tcon_top: tcon-top@5460000 {
+			compatible = "allwinner,sun20i-d1-tcon-top";
+			reg = <0x5460000 0x1000>;
+			clocks = <&ccu CLK_BUS_DPSS_TOP>,
+				 <&ccu CLK_TCON_TV>,
+				 <&ccu CLK_TVE>,
+				 <&ccu CLK_TCON_LCD0>;
+			clock-names = "bus", "tcon-tv0", "tve0", "dsi";
+			clock-output-names = "tcon-top-tv0", "tcon-top-dsi";
+			resets = <&ccu RST_BUS_DPSS_TOP>;
+			#clock-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_top_mixer0_in: port@0 {
+					reg = <0>;
+
+					tcon_top_mixer0_in_mixer0: endpoint {
+						remote-endpoint = <&mixer0_out_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer0_out: port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer0_out_tcon_lcd0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer0>;
+					};
+
+					tcon_top_mixer0_out_tcon_tv0: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer0>;
+					};
+				};
+
+				tcon_top_mixer1_in: port@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer1_in_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&mixer1_out_tcon_top_mixer1>;
+					};
+				};
+
+				tcon_top_mixer1_out: port@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_top_mixer1_out_tcon_lcd0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_lcd0_in_tcon_top_mixer1>;
+					};
+
+					tcon_top_mixer1_out_tcon_tv0: endpoint@2 {
+						reg = <2>;
+						remote-endpoint = <&tcon_tv0_in_tcon_top_mixer1>;
+					};
+				};
+
+				tcon_top_hdmi_in: port@4 {
+					reg = <4>;
+
+					tcon_top_hdmi_in_tcon_tv0: endpoint {
+						remote-endpoint = <&tcon_tv0_out_tcon_top_hdmi>;
+					};
+				};
+
+				tcon_top_hdmi_out: port@5 {
+					reg = <5>;
+				};
+			};
+		};
+
+		tcon_lcd0: lcd-controller@5461000 {
+			compatible = "allwinner,sun20i-d1-tcon-lcd";
+			reg = <0x5461000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(90) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_LCD0>,
+				 <&ccu CLK_TCON_LCD0>;
+			clock-names = "ahb", "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_TCON_LCD0>,
+				 <&ccu RST_BUS_LVDS0>;
+			reset-names = "lcd", "lvds";
+			#clock-cells = <0>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_lcd0_in: port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_lcd0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_lcd0>;
+					};
+
+					tcon_lcd0_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_lcd0>;
+					};
+				};
+
+				tcon_lcd0_out: port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_lcd0_out_dsi: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&dsi_in_tcon_lcd0>;
+					};
+				};
+			};
+		};
+
+		tcon_tv0: lcd-controller@5470000 {
+			compatible = "allwinner,sun20i-d1-tcon-tv";
+			reg = <0x5470000 0x1000>;
+			interrupts = <SOC_PERIPHERAL_IRQ(91) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_TCON_TV>,
+				 <&tcon_top CLK_TCON_TOP_TV0>;
+			clock-names = "ahb", "tcon-ch1";
+			resets = <&ccu RST_BUS_TCON_TV>;
+			reset-names = "lcd";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon_tv0_in: port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					tcon_tv0_in_tcon_top_mixer0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon_top_mixer0_out_tcon_tv0>;
+					};
+
+					tcon_tv0_in_tcon_top_mixer1: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&tcon_top_mixer1_out_tcon_tv0>;
+					};
+				};
+
+				tcon_tv0_out: port@1 {
+					reg = <1>;
+
+					tcon_tv0_out_tcon_top_hdmi: endpoint {
+						remote-endpoint = <&tcon_top_hdmi_in_tcon_tv0>;
+					};
+				};
+			};
+		};
+
+		ppu: power-controller@7001000 {
+			compatible = "allwinner,sun20i-d1-ppu";
+			reg = <0x7001000 0x1000>;
+			clocks = <&r_ccu CLK_BUS_R_PPU>;
+			resets = <&r_ccu RST_BUS_R_PPU>;
+			#power-domain-cells = <1>;
+		};
+
+		r_ccu: clock-controller@7010000 {
+			compatible = "allwinner,sun20i-d1-r-ccu";
+			reg = <0x7010000 0x400>;
+			clocks = <&dcxo>,
+				 <&rtc CLK_OSC32K>,
+				 <&rtc CLK_IOSC>,
+				 <&ccu CLK_PLL_PERIPH0_DIV3>;
+			clock-names = "hosc", "losc", "iosc", "pll-periph";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		rtc: rtc@7090000 {
+			compatible = "allwinner,sun20i-d1-rtc",
+				     "allwinner,sun50i-r329-rtc";
+			reg = <0x7090000 0x400>;
+			interrupts = <SOC_PERIPHERAL_IRQ(144) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_BUS_R_RTC>,
+				 <&dcxo>,
+				 <&r_ccu CLK_R_AHB>;
+			clock-names = "bus", "hosc", "ahb";
+			#clock-cells = <1>;
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/sun20i-d1-r-ccu.h b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
new file mode 100644
index 00000000000..f95c170711e
--- /dev/null
+++ b/include/dt-bindings/clock/sun20i-d1-r-ccu.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_
+#define _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_
+
+#define CLK_R_AHB		0
+
+#define CLK_BUS_R_TIMER		2
+#define CLK_BUS_R_TWD		3
+#define CLK_BUS_R_PPU		4
+#define CLK_R_IR_RX		5
+#define CLK_BUS_R_IR_RX		6
+#define CLK_BUS_R_RTC		7
+#define CLK_BUS_R_CPUCFG	8
+
+#endif /* _DT_BINDINGS_CLK_SUN20I_D1_R_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-r-ccu.h b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
new file mode 100644
index 00000000000..e20babc990a
--- /dev/null
+++ b/include/dt-bindings/reset/sun20i-d1-r-ccu.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#ifndef _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_
+#define _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_
+
+#define RST_BUS_R_TIMER		0
+#define RST_BUS_R_TWD		1
+#define RST_BUS_R_PPU		2
+#define RST_BUS_R_IR_RX		3
+#define RST_BUS_R_RTC		4
+#define RST_BUS_R_CPUCFG	5
+
+#endif /* _DT_BINDINGS_RST_SUN20I_D1_R_CCU_H_ */
-- 
2.35.8

