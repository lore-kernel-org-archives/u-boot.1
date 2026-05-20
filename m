Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA3ACD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0294884857;
	Wed, 20 May 2026 14:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54EBE84659; Wed, 20 May 2026 10:25:00 +0200 (CEST)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A0F38467A
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 May
 2026 16:24:49 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 May 2026 16:24:49 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 20 May 2026 16:24:49 +0800
Subject: [PATCH v2 2/5] arm: dts: aspeed: Add initial AST27xx SoC device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260520-ast2700_clk-v2-2-c778b2908e5e@aspeedtech.com>
References: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
In-Reply-To: <20260520-ast2700_clk-v2-0-c778b2908e5e@aspeedtech.com>
To: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Chia-Wei
 Wang" <chiawei_wang@aspeedtech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Andre Przywara
 <andre.przywara@arm.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Peng Fan <peng.fan@nxp.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Brian Sune <briansune@gmail.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, Gabriel Fernandez
 <gabriel.fernandez@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Finley Xiao <finley.xiao@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779265488; l=21807;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=od0zo8zl85KlddHmj/7y4dNXtIOnQvH6Z0ep9fTEr7E=;
 b=G44iFwZxl6O8PgVJTw1EVjsRQkIKirecCGQSaunW6646fJO5T8RGsiKRWg5o6yVwgeb8OHiJV
 /pFc/pTVw1HAl54FMdjO2fthNJn+fODoFe6xukNpJvyXOgLefT/o2ja
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=
X-Mailman-Approved-At: Wed, 20 May 2026 14:49:56 +0200
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

Add initial device tree support for the ASPEED AST27xx family, the
8th-generation Baseboard Management Controller (BMC) SoCs.

AST27xx SOC Family
 - https://www.aspeedtech.com/server_ast2700/
 - https://www.aspeedtech.com/server_ast2720/
 - https://www.aspeedtech.com/server_ast2750/

The AST27xx features a dual-SoC architecture consisting of two ties,
referred to as SoC0 and SoC1 - interconnected through an internal
property bus. Both SoCs share the same address decoding scheme,
while each maintains independent clock and reset domains.

- SoC0 (CPU die): contains a dual-core Cortex-A35 cluster and two
  Cortex-M4 cores, along with high-speed peripherals.
- SoC1 (I/O die): includes the BootMCU (responsible for system
  boot) and its own clock/reset domains low-speed peripherals.

The device tree describes the SoC0 and SoC1 domains and their peripheral
layouts.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm/dts/Makefile            |   2 +
 arch/arm/dts/ast2700-evb.dts     |  88 +++++
 arch/arm/dts/ast2700-u-boot.dtsi |  25 ++
 arch/arm/dts/ast2700.dtsi        | 693 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 808 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d5dd0867622..7ba3e145a8f 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1056,6 +1056,8 @@ dtb-$(CONFIG_ASPEED_AST2600) += \
 	ast2600-evb.dtb \
 	ast2600-sbp1.dtb \
 	ast2600-x4tf.dtb
+dtb-$(CONFIG_ASPEED_AST2700) += \
+	ast2700-evb.dtb
 
 dtb-$(CONFIG_STM32MP15X) += \
 	stm32mp157c-odyssey.dtb
diff --git a/arch/arm/dts/ast2700-evb.dts b/arch/arm/dts/ast2700-evb.dts
new file mode 100644
index 00000000000..0b51a946ad9
--- /dev/null
+++ b/arch/arm/dts/ast2700-evb.dts
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+#include "ast2700.dtsi"
+#include "ast2700-u-boot.dtsi"
+
+/ {
+	model = "AST2700 EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	memory {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x0 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = &uart12;
+	};
+
+};
+
+&uart12 {
+	status = "okay";
+};
+
+&mdio0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mdio1 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ethphy1: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+};
+
+&mac1 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
+	rx-internal-delay-ps = <0>;
+	tx-internal-delay-ps = <0>;
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@1 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+
+	flash@2 {
+		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&wdt0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/ast2700-u-boot.dtsi b/arch/arm/dts/ast2700-u-boot.dtsi
new file mode 100644
index 00000000000..8830eca3a43
--- /dev/null
+++ b/arch/arm/dts/ast2700-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&soc0 {
+	bootph-all;
+};
+
+&sdrammc {
+	bootph-all;
+};
+
+&syscon0 {
+	bootph-all;
+};
+
+&uart12 {
+	bootph-all;
+};
+
+&soc1 {
+	bootph-all;
+};
+
+&syscon1 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/ast2700.dtsi b/arch/arm/dts/ast2700.dtsi
new file mode 100644
index 00000000000..3dd6826fd0c
--- /dev/null
+++ b/arch/arm/dts/ast2700.dtsi
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <dt-bindings/clock/aspeed,ast2700-scu.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/reset/aspeed,ast2700-scu.h>
+
+/ {
+	model = "Aspeed BMC";
+	compatible = "aspeed,ast2700";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
+		serial6 = &uart6;
+		serial7 = &uart7;
+		serial8 = &uart8;
+		serial9 = &uart9;
+		serial10 = &uart10;
+		serial11 = &uart11;
+		serial12 = &uart12;
+		mmc0 = &emmc;
+		mmc1 = &sdhci;
+		ethernet0 = &mac0;
+		ethernet1 = &mac1;
+		ethernet2 = &mac2;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a35";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
+		};
+
+	};
+
+	arm-pmu {
+			compatible = "arm,cortex-a35-pmu";
+			interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+							<GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+							<GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+							<GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	gic: interrupt-controller@12200000 {
+		compatible = "arm,gic-v3";
+		reg = <0 0x12200000 0 0x10000>, /* GICD */
+				<0 0x12280000 0 0x80000>, /* GICR */
+				<0 0x40440000 0 0x1000>;  /* GICC */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x0 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee-core@430080000 {
+			reg = <0x4 0x30080000 0x0 0x1000000>;
+			no-map;
+		};
+	};
+
+	soc0: soc@10000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x10000000 0x0 0x10000000 0x0 0x4000000>;
+
+	uhci0: usb@12040000 {
+		compatible = "aspeed,ast2700-uhci", "generic-uhci";
+		reg = <0x0 0x12040000 0x0 0x100>;
+		#ports = <2>;
+		clocks = <&syscon0 SCU0_CLK_GATE_UHCICLK>;
+		resets = <&syscon0 SCU0_RESET_UHCI>;
+		status = "disabled";
+	};
+
+	ehci0: usb@12061000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x12061000 0x0 0x100>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTA_VHUB_EHCI>;
+		status = "disabled";
+	};
+
+		vhuba0: usb-vhub@12060000 {
+			compatible = "aspeed,ast2700-usb-vhuba0";
+			reg = <0 0x12060000 0 0x350>;
+			clocks = <&syscon0 SCU0_CLK_GATE_PORTAUSB2CLK>;
+			resets = <&syscon0 SCU0_RESET_PORTA_VHUB_EHCI>;
+			status = "disabled";
+		};
+
+		vhubb0: usb-vhub@12062000 {
+			compatible = "aspeed,ast2700-usb-vhubb0";
+			reg = <0x0 0x12062000 0x0 0x350>;
+			clocks = <&syscon0 SCU0_CLK_GATE_PORTBUSB2CLK>;
+			resets = <&syscon0 SCU0_RESET_PORTB_VHUB_EHCI>;
+			status = "disabled";
+		};
+
+	ehci1: usb@12063000 {
+		compatible = "aspeed,ast2700-ehci", "generic-ehci";
+		reg = <0x0 0x12063000 0x0 0x100>;
+		clocks = <&syscon0 SCU0_CLK_GATE_PORTBUSB2CLK>;
+		resets = <&syscon0 SCU0_RESET_PORTB_VHUB_EHCI>;
+		status = "disabled";
+	};
+
+		emmc_controller: sdc@12090000 {
+			compatible = "aspeed,ast2700-sd-controller";
+			reg = <0 0x12090000 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x12090000 0x10000>;
+			clocks = <&syscon0 SCU0_CLK_GATE_EMMCCLK>;
+			resets = <&syscon0 SCU0_RESET_EMMC>;
+			status = "disable";
+
+			emmc: sdhci@100 {
+				compatible = "aspeed,ast2700-sdhci";
+				reg = <0x100 0x100>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon0 SCU0_CLK_GATE_EMMCCLK>;
+				status = "disable";
+			};
+		};
+
+	intc0: interrupt-controller@12100000 {
+			compatible = "aspeed,ast2700-intc0";
+			reg = <0x0 0x12100000 0x0 0x3c00>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+	};
+
+		sdrammc: sdrammc@12c00000 {
+			compatible = "aspeed,ast2700-sdrammc";
+			reg = <0 0x12c00000 0 0x3000 0 0x13000000 0 0x300 >;
+			clocks = <&syscon0 SCU0_CLK_MPLL>;
+			resets = <&syscon0 SCU0_RESET_SDRAM>;
+			aspeed,scu0 = <&syscon0>;
+			aspeed,scu1 = <&syscon1>;
+		};
+
+		syscon0: syscon@12c02000 {
+			compatible = "aspeed,ast2700-scu0", "syscon", "simple-mfd";
+			reg = <0x0 0x12c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x12c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			pinctrl0: pinctrl@400 {
+				compatible = "aspeed,ast2700-soc0-pinctrl";
+				reg = <0x400 0x318>;
+			};
+		};
+
+		gpio0: gpio@12c11000 {
+			compatible = "aspeed,ast2700-gpio";
+			reg = <0x0 0x12c11000 0x0 0x1000>;
+			gpio-ranges = <&pinctrl0 0 0 12>;
+			ngpios = <12>;
+			clocks = <&syscon0 SCU0_CLK_APB>;
+		};
+
+		uart4: serial@12c1a000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x12c1a000 0x0 0x1000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon0 SCU0_CLK_GATE_UART4CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+	mbox0: mbox@12c1c200 {
+		compatible = "aspeed,ast2700-mailbox";
+		reg = <0x0 0x12c1c200 0x0 0x100>, <0x0 0x12c1c300 0x0 0x100>;
+		reg-names = "tx", "rx";
+		#mbox-cells = <1>;
+	};
+
+	mbox1: mbox@12c1c600 {
+		compatible = "aspeed,ast2700-mailbox";
+		reg = <0x0 0x12c1c600 0x0 0x100>, <0x0 0x12c1c700 0x0 0x100>;
+		reg-names = "tx", "rx";
+		#mbox-cells = <1>;
+	};
+	};
+
+	soc1: soc@14000000 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x0 0x14000000 0x0 0x14000000 0x2 0xec000000>;
+
+		fmc: spi@14000000 {
+			reg = <0x0 0x14000000 0x0 0xc4>, <0x1 0x00000000 0x0 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "aspeed,ast2700-fmc";
+			status = "disabled";
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+			num-cs = <3>;
+
+			flash@0 {
+				reg = <0>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+
+			flash@1 {
+				reg = <1>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+
+			flash@2 {
+				reg = <2>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+		};
+
+		spi0: spi@14010000 {
+			reg = <0x0 0x14010000 0x0 0xc4>, <0x1 0x80000000 0x0 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "aspeed,ast2700-spi";
+			status = "disabled";
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+			num-cs = <2>;
+
+			flash@0 {
+				reg = <0>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+
+			flash@1 {
+				reg = <1>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+		};
+
+		spi1: spi@14020000 {
+			reg = <0x0 0x14020000 0x0 0xc4>, <0x2 0x00000000 0x0 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "aspeed,ast2700-spi";
+			status = "disabled";
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+			num-cs = <2>;
+
+			flash@0 {
+				reg = <0>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+
+			flash@1 {
+				reg = <1>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+		};
+
+		spi2: spi@14030000 {
+			reg = <0x0 0x14030000 0x0 0xc4>, <0x2 0x80000000 0x0 0x80000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "aspeed,ast2700-spi";
+			status = "disabled";
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+			resets = <&syscon1 SCU1_RESET_SPI2>;
+			num-cs = <2>;
+
+			flash@0 {
+				reg = <0>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+
+			flash@1 {
+				reg = <1>;
+				compatible = "jedec,spi-nor";
+				status = "disabled";
+			};
+		};
+
+	mdio0: mdio@14040000 {
+		compatible = "aspeed,ast2700-mdio";
+		reg = <0 0x14040000 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		status = "disabled";
+	};
+
+	mdio1: mdio@14040008 {
+		compatible = "aspeed,ast2700-mdio";
+		reg = <0 0x14040008 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		status = "disabled";
+	};
+
+	mdio2: mdio@14040010 {
+		compatible = "aspeed,ast2700-mdio";
+		reg = <0 0x14040010 0 0x8>;
+		resets = <&syscon1 SCU1_RESET_MII>;
+		status = "disabled";
+	};
+
+		mac0: ftgmac@14050000 {
+			compatible = "aspeed,ast2700-mac", "faraday,ftgmac100";
+			reg = <0x0 0x14050000 0x0 0x200>;
+			clocks = <&syscon1 SCU1_CLK_GATE_MAC0CLK>;
+			resets = <&syscon1 SCU1_RESET_MAC0>;
+			status = "disabled";
+		};
+
+		mac1: ftgmac@14060000 {
+			compatible = "aspeed,ast2700-mac", "faraday,ftgmac100";
+			reg = <0x0 0x14060000 0x0 0x200>;
+			clocks = <&syscon1 SCU1_CLK_GATE_MAC1CLK>;
+			resets = <&syscon1 SCU1_RESET_MAC1>;
+			status = "disabled";
+		};
+
+		mac2: ftgmac@14070000 {
+			compatible = "aspeed,ast2700-mac", "faraday,ftgmac100";
+			reg = <0x0 0x14070000 0x0 0x200>;
+			clocks = <&syscon1 SCU1_CLK_GATE_MAC2CLK>;
+			resets = <&syscon1 SCU1_RESET_MAC2>;
+			status = "disabled";
+		};
+
+		sdio_controller: sdc@14080000 {
+			compatible = "aspeed,ast2700-sd-controller";
+			reg = <0 0x14080000 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&syscon1 SCU1_CLK_GATE_SDCLK>;
+			resets = <&syscon1 SCU1_RESET_SD>;
+			ranges = <0 0 0x14080000 0x10000>;
+			status = "disable";
+
+			sdhci: sdhci@100 {
+				compatible = "aspeed,ast2700-sdhci";
+				reg = <0x100 0x100>;
+				sdhci,auto-cmd12;
+				clocks = <&syscon1 SCU1_CLK_GATE_SDCLK>;
+			};
+		};
+
+	uhci1: usb@14110000 {
+			compatible = "aspeed,ast2700-uhci", "generic-uhci";
+			reg = <0x0 0x14110000 0x0 0x100>;
+			#ports = <2>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UHCICLK>;
+			resets = <&syscon1 SCU1_RESET_UHCI>;
+			status = "disabled";
+	};
+
+	vhubc: usb-vhub@14120000 {
+			compatible = "aspeed,ast2700-usb-vhub";
+			reg = <0x0 0x14120000 0x0 0x820>;
+			clocks = <&syscon1 SCU1_CLK_GATE_PORTCUSB2CLK>;
+			resets = <&syscon1 SCU1_RESET_PORTC_VHUB_EHCI>;
+			aspeed,vhub-downstream-ports = <7>;
+			aspeed,vhub-generic-endpoints = <21>;
+			status = "disabled";
+	};
+
+	ehci2: usb@14121000 {
+			compatible = "aspeed,ast2700-ehci", "generic-ehci";
+			reg = <0x0 0x14121000 0x0 0x100>;
+			clocks = <&syscon1 SCU1_CLK_GATE_PORTCUSB2CLK>;
+			resets = <&syscon1 SCU1_RESET_PORTC_VHUB_EHCI>;
+			status = "disabled";
+	};
+
+	vhubd: usb-vhub@14122000 {
+			compatible = "aspeed,ast2700-usb-vhub";
+			reg = <0x0 0x14122000 0x0 0x820>;
+			clocks = <&syscon1 SCU1_CLK_GATE_PORTDUSB2CLK>;
+			resets = <&syscon1 SCU1_RESET_PORTD_VHUB_EHCI>;
+			aspeed,vhub-downstream-ports = <7>;
+			aspeed,vhub-generic-endpoints = <21>;
+			status = "disabled";
+	};
+
+	ehci3: usb@14123000 {
+			compatible = "aspeed,ast2700-ehci", "generic-ehci";
+			reg = <0x0 0x14123000 0x0 0x100>;
+			clocks = <&syscon1 SCU1_CLK_GATE_PORTDUSB2CLK>;
+			resets = <&syscon1 SCU1_RESET_PORTD_VHUB_EHCI>;
+			status = "disabled";
+	};
+
+		syscon1: syscon@14c02000 {
+			compatible = "aspeed,ast2700-scu1", "syscon", "simple-mfd";
+			reg = <0x0 0x14c02000 0x0 0x1000>;
+			ranges = <0x0 0x0 0x14c02000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			pinctrl1: pinctrl@400 {
+					compatible = "aspeed,ast2700-soc1-pinctrl";
+					reg = <0x400 0x2a0>;
+			};
+		};
+
+	gpio1: gpio@14c0b000 {
+			compatible = "aspeed,ast2700-gpio";
+			reg = <0x0 0x14c0b000 0x0 0x1000>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl1 0 0 216>;
+			ngpios = <216>;
+			clocks = <&syscon1 SCU1_CLK_AHB>;
+	};
+
+		intc1: interrupt-controller@14c18000 {
+			compatible = "aspeed,ast2700-intc1";
+			reg = <0 0x14c18000 0 0x400>;
+			interrupt-controller;
+			interrupt-parent = <&intc0>;
+			#interrupt-cells = <1>;
+		};
+
+		uart0: serial@14c33000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33000 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART0CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart1: serial@14c33100 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33100 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART1CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart2: serial@14c33200 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33200 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART2CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart3: serial@14c33300 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33300 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART3CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart5: serial@14c33400 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33400 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART5CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart6: serial@14c33500 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33500 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART6CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart7: serial@14c33600 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33600 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART7CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart8: serial@14c33700 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33700 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART8CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart9: serial@14c33800 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33800 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART9CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart10: serial@14c33900 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33900 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART10CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart11: serial@14c33a00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33a00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART11CLK>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+		uart12: serial@14c33b00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33b00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_GATE_UART12CLK>;
+			clock-frequency = <1846154>;
+			no-loopback-test;
+			status = "disabled";
+		};
+
+	uart13: serial@14c33c00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33c00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART13>;
+			no-loopback-test;
+			status = "disabled";
+	};
+
+	uart14: serial@14c33d00 {
+			compatible = "ns16550a";
+			reg = <0x0 0x14c33d00 0x0 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&syscon1 SCU1_CLK_UART14>;
+			no-loopback-test;
+			status = "disabled";
+	};
+
+		wdt0: watchdog@14c37000 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37000 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@14c37080 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37080 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@14c37100 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37100 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt3: watchdog@14c37180 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37180 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt4: watchdog@14c37200 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37200 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt5: watchdog@14c37280 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37280 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt6: watchdog@14c37300 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37300 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt7: watchdog@14c37380 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37380 0x0 0x80>;
+			status = "disabled";
+		};
+
+		wdt_abr: watchdog@14c37400 {
+			compatible = "aspeed,ast2700-wdt";
+			reg = <0x0 0x14c37400 0x0 0x80>;
+			status = "disabled";
+		};
+
+		mbox2: mbox@14c39200 {
+			compatible = "aspeed,ast2700-mailbox";
+			reg = <0x0 0x14c39200 0x0 0x100>, <0x0 0x14c39300 0x0 0x100>;
+			reg-names = "tx", "rx";
+			#mbox-cells = <1>;
+		};
+
+	};
+};

-- 
2.34.1

