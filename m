Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A97C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:05:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F50B87F1C;
	Mon, 11 Mar 2024 13:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9C4687E64; Mon, 11 Mar 2024 13:03:23 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F080C87FAD
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ttb515JT5ztSV;
 Mon, 11 Mar 2024 13:03:01 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ttb505b0jz3f; Mon, 11 Mar 2024 13:03:00 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 11 Mar 2024 13:01:59 +0100
Subject: [PATCH v4 16/20] board: rockchip: add Theobroma-Systems RK3588
 Jaguar SBC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-jaguar-v4-16-d2ca1af68ed3@theobroma-systems.com>
References: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
In-Reply-To: <20240311-jaguar-v4-0-d2ca1af68ed3@theobroma-systems.com>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

JAGUAR is a Single-Board Computer (SBC) based around the rk3588 SoC and
is targeting Autonomous Mobile Robots (AMR).

It features:
 * LPDDR4X (up to 16GB)
 * 1Gbps Ethernet on RJ45 connector (KSZ9031 or KSZ9131)
 * PCIe 3.0 4-lane on M.2 M-key connector
 * PCIe 2.1 1-lane on M.2 E-key
 * USB 2.0 on M.2 E-key
 * 2x USB3 OTG type-c ports with DP Alt-Mode
 * USB2 host port
 * HDMI output
 * 2x camera connectors, each exposing:
   * 2-lane MIPI-CSI
   * 1v2, 1v8, 2v8 power rails
   * I2C bus
   * GPIOs
 * PPS input
 * CAN
 * RS485 UART
 * FAN connector
 * SD card slot
 * eMMC (up to 256GB)
 * RTC backup battery
 * Companion microcontroller
   * ISL1208 RTC emulation
   * AMC6821 PWM emulation
   * On/off buzzer control
 * Secure Element
 * 80-pin Mezzanine connector for daughterboards:
   * GPIOs
   * 1Gbps Ethernet
   * PCIe 2.1 1-lane
   * 2x 2-lane MIPI-CSI
   * ADC channel
   * I2C bus
   * PWM
   * UART
   * SPI
   * SDIO
   * CAN
   * I2S
   * 1v8, 3v3, 5v0, dc-in (12-24V) power rails

The Device Tree comes from next-20240110 Linux kernel.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi             |  33 +
 arch/arm/dts/rk3588-jaguar.dts                     | 803 +++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  28 +
 board/theobroma-systems/jaguar_rk3588/Kconfig      |  16 +
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS  |  13 +
 board/theobroma-systems/jaguar_rk3588/Makefile     |  10 +
 .../jaguar_rk3588/jaguar_rk3588.c                  |  53 ++
 configs/jaguar-rk3588_defconfig                    | 114 +++
 doc/board/index.rst                                |   1 +
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |   9 +
 doc/board/theobroma-systems/jaguar_rk3588.rst      | 100 +++
 include/configs/jaguar_rk3588.h                    |  15 +
 14 files changed, 1197 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b102ffb5f68..f31f3904ffd 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -194,6 +194,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
+	rk3588-jaguar.dtb \
 	rk3588-nanopc-t6.dtb \
 	rk3588s-orangepi-5.dtb \
 	rk3588-orangepi-5-plus.dtb \
diff --git a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
new file mode 100644
index 00000000000..dcda4f99d6e
--- /dev/null
+++ b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include "rk3588-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
+	};
+};
+
+&emmc_pwrseq {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_reset {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdhci {
+	/* U-Boot currently cannot handle anything below HS200 for eMMC on RK3588 */
+	/delete-property/ mmc-ddr-1_8v;
+	/delete-property/ cap-mmc-highspeed;
+};
diff --git a/arch/arm/dts/rk3588-jaguar.dts b/arch/arm/dts/rk3588-jaguar.dts
new file mode 100644
index 00000000000..4ce70fb75a3
--- /dev/null
+++ b/arch/arm/dts/rk3588-jaguar.dts
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/usb/pd.h>
+#include "rk3588.dtsi"
+
+/ {
+	model = "Theobroma Systems RK3588-SBC Jaguar";
+	compatible = "tsd,rk3588-jaguar", "rockchip,rk3588";
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 0>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		/* Can be controlled through SW2 but also GPIO1 on CP2102 on P20 */
+		button-bios-disable {
+			label = "BIOS_DISABLE";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <0>;
+		};
+	};
+
+	aliases {
+		ethernet0 = &gmac0;
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		rtc0 = &rtc_twi;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	/* DCIN is 12-24V but standard is 12V */
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	emmc_pwrseq: emmc-pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		pinctrl-0 = <&emmc_reset>;
+		pinctrl-names = "default";
+		reset-gpios = <&gpio2 RK_PA3 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led1_pin>;
+		status = "okay";
+
+		/* LED1 on PCB */
+		led-1 {
+			gpios = <&gpio1 RK_PD4 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+			color = <LED_COLOR_ID_AMBER>;
+		};
+	};
+
+	pps {
+		compatible = "pps-gpio";
+		gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+	};
+
+	vcc_1v1_nldo_s3: vcc-1v1-nldo-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v1_nldo_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v2_s3: vcc-1v2-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v2_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	/* Exposed on P14 and P15 */
+	vcc_2v8_s3: vcc-2v8-s3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_2v8_s3";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc_5v0_usb_a: vcc-5v0-usb-a-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_a_vcc";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+		gpio = <&gpio1 RK_PB4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_5v0_usb_c1: vcc-5v0-usb-c1-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_usbc1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc_5v0_usb_c2: vcc-5v0-usb-c2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_usbc2";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+		gpio = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vcc3v3_mdot2: vcc3v3-mdot2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3_mdot2";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vcc5v0_usb: vcc5v0-usb-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&combphy1_ps {
+	status = "okay";
+};
+
+&cpu_b0 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b1 {
+	cpu-supply = <&vdd_cpu_big0_s0>;
+};
+
+&cpu_b2 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_b3 {
+	cpu-supply = <&vdd_cpu_big1_s0>;
+};
+
+&cpu_l0 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l1 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l2 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&cpu_l3 {
+	cpu-supply = <&vdd_cpu_lit_s0>;
+};
+
+&gmac0 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	phy-supply = <&vcc_1v2_s3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac0_miim
+		     &gmac0_rx_bus2
+		     &gmac0_tx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus
+		     &eth0_pins
+		     &eth_reset>;
+	tx_delay = <0x10>;
+	rx_delay = <0x10>;
+	snps,reset-gpio = <&gpio4 RK_PC3 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 100000>;
+
+	status = "okay";
+};
+
+&gpio1 {
+	mdot2e-w-disable1-n-hog {
+		gpios = <RK_PB1 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m.2 E-key W_DISABLE1#";
+		gpio-hog;
+	};
+};
+
+&gpio4 {
+	mdot2e-w-disable2-n-hog {
+		gpios = <RK_PC1 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m.2 E-key W_DISABLE2#";
+		gpio-hog;
+	};
+};
+
+&i2c0 {
+	pinctrl-0 = <&i2c0m2_xfer>;
+	status = "okay";
+
+	fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	vdd_npu_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_npu_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <950000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	vdd_cpu_big1_s0: regulator@43 {
+		compatible = "rockchip,rk8603", "rockchip,rk8602";
+		reg = <0x43>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big1_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+
+	rtc_twi: rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c1 {
+	pinctrl-0 = <&i2c1m4_xfer>;
+};
+
+&i2c6 {
+	pinctrl-0 = <&i2c6m4_xfer>;
+};
+
+&i2c7 {
+	status = "okay";
+
+	/* SE050 Secure Element at 0x48; GPIO1_A4 for enable pin */
+
+	/* Also on 0x55 */
+	eeprom@54 {
+		compatible = "st,24c04", "atmel,24c04";
+		reg = <0x54>;
+		pagesize = <16>;
+		vcc-supply = <&vcc_3v3_s3>;
+	};
+};
+
+&i2c8 {
+	pinctrl-0 = <&i2c8m2_xfer>;
+	status = "okay";
+
+	vdd_cpu_big0_s0: regulator@42 {
+		compatible = "rockchip,rk8602";
+		reg = <0x42>;
+		fcs,suspend-voltage-selector = <1>;
+		regulator-name = "vdd_cpu_big0_s0";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <550000>;
+		regulator-max-microvolt = <1050000>;
+		regulator-ramp-delay = <2300>;
+		vin-supply = <&vcc5v0_sys>;
+
+		regulator-state-mem {
+			regulator-off-in-suspend;
+		};
+	};
+};
+
+&mdio0 {
+	rgmii_phy: ethernet-phy@6 {
+		/* KSZ9031 or KSZ9131 */
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x6>;
+		clocks = <&cru REFCLKO25M_ETH0_OUT>;
+	};
+};
+
+&pcie2x1l0 {
+	reset-gpios = <&gpio4 RK_PB3 GPIO_ACTIVE_HIGH>; /* WIFI_PERST0# */
+	vpcie3v3-supply = <&vcc3v3_mdot2>;
+	status = "okay";
+};
+
+&pinctrl {
+	emmc {
+		emmc_reset: emmc-reset {
+			rockchip,pins = <2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	ethernet {
+		eth_reset: eth-reset {
+			rockchip,pins = <4 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	leds {
+		led1_pin: led1-pin {
+			rockchip,pins = <1 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8_s0>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	mmc-pwrseq = <&emmc_pwrseq>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
+	supports-cqe;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vcc_1v8_s3>;
+	status = "okay";
+};
+
+&sdmmc {
+	broken-cd;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	max-frequency = <150000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_bus4 &sdmmc_cmd &sdmmc_clk>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-ddr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_3v3_s3>;
+	vqmmc-supply = <&vccio_sd_s0>;
+	status = "okay";
+};
+
+&spi2 {
+	assigned-clocks = <&cru CLK_SPI2>;
+	assigned-clock-rates = <200000000>;
+	num-cs = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2m2_cs0 &spi2m2_pins>;
+	status = "okay";
+
+	pmic@0 {
+		compatible = "rockchip,rk806";
+		reg = <0x0>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
+			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
+		spi-max-frequency = <1000000>;
+		system-power-controller;
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc5-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
+		vcc8-supply = <&vcc5v0_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc_2v0_pldo_s3>;
+		vcc12-supply = <&vcc5v0_sys>;
+		vcc13-supply = <&vcc_1v1_nldo_s3>;
+		vcc14-supply = <&vcc_1v1_nldo_s3>;
+		vcca-supply = <&vcc5v0_sys>;
+
+		rk806_dvs1_null: dvs1-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs2_null: dvs2-null-pins {
+			pins = "gpio_pwrctrl2";
+			function = "pin_fun0";
+		};
+
+		rk806_dvs3_null: dvs3-null-pins {
+			pins = "gpio_pwrctrl3";
+			function = "pin_fun0";
+		};
+
+		regulators {
+			vdd_gpu_s0: dcdc-reg1 {
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+				regulator-name = "vdd_gpu_s0";
+				regulator-enable-ramp-delay = <400>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_cpu_lit_s0: dcdc-reg2 {
+				regulator-name = "vdd_cpu_lit_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_log_s0: dcdc-reg3 {
+				regulator-name = "vdd_log_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <750000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdd_vdenc_s0: dcdc-reg4 {
+				regulator-name = "vdd_vdenc_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <550000>;
+				regulator-max-microvolt = <950000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_ddr_s0: dcdc-reg5 {
+				regulator-name = "vdd_ddr_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <675000>;
+				regulator-max-microvolt = <900000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdd2_ddr_s3: dcdc-reg6 {
+				regulator-name = "vdd2_ddr_s3";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc_2v0_pldo_s3: dcdc-reg7 {
+				regulator-name = "vdd_2v0_pldo_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <2000000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <2000000>;
+				};
+			};
+
+			vcc_3v3_s3: dcdc-reg8 {
+				regulator-name = "vcc_3v3_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vddq_ddr_s0: dcdc-reg9 {
+				regulator-name = "vddq_ddr_s0";
+				regulator-always-on;
+				regulator-boot-on;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s3: dcdc-reg10 {
+				regulator-name = "vcc_1v8_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcca_1v8_s0: pldo-reg1 {
+				regulator-name = "vcca_1v8_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc_1v8_s0: pldo-reg2 {
+				regulator-name = "vcc_1v8_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdda_1v2_s0: pldo-reg3 {
+				regulator-name = "vdda_1v2_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcca_3v3_s0: pldo-reg4 {
+				regulator-name = "vcca_3v3_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vccio_sd_s0: pldo-reg5 {
+				regulator-name = "vccio_sd_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <12500>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			pldo6_s3: pldo-reg6 {
+				regulator-name = "pldo6_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vdd_0v75_s3: nldo-reg1 {
+				regulator-name = "vdd_0v75_s3";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <750000>;
+				};
+			};
+
+			vdda_ddr_pll_s0: nldo-reg2 {
+				regulator-name = "vdda_ddr_pll_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+					regulator-suspend-microvolt = <850000>;
+				};
+			};
+
+			vdda_0v75_s0: nldo-reg3 {
+				regulator-name = "vdda_0v75_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdda_0v85_s0: nldo-reg4 {
+				regulator-name = "vdda_0v85_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vdd_0v75_s0: nldo-reg5 {
+				regulator-name = "vdd_0v75_s0";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <750000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+};
+
+&tsadc {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&u2phy2_host {
+	phy-supply = <&vcc_5v0_usb_a>;
+	status = "okay";
+};
+
+&u2phy3 {
+	status = "okay";
+};
+
+&u2phy3_host {
+	status = "okay";
+};
+
+/* Mule-ATtiny debug UART; typically baudrate 9600 */
+&uart0 {
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
+
+/* Main debug interface on P20 micro-USB B port and P21 header */
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
+
+/* RS485 on P19 */
+&uart3 {
+	pinctrl-0 = <&uart3m2_xfer &uart3_rtsn>;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+/* Mule-ATtiny UPDI flashing UART */
+&uart7 {
+	pinctrl-0 = <&uart7m0_xfer>;
+	status = "okay";
+};
+
+/* host0 on P10 USB-A */
+&usb_host0_ehci {
+	status = "okay";
+};
+
+/* host0 on P10 USB-A */
+&usb_host0_ohci {
+	status = "okay";
+};
+
+/* host1 on M.2 E-key */
+&usb_host1_ehci {
+	status = "okay";
+};
+
+/* host1 on M.2 E-key */
+&usb_host1_ohci {
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index a2193fbd41f..c6b79b6cd75 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -6,6 +6,33 @@ config TARGET_EVB_RK3588
 	help
 	  RK3588 EVB is a evaluation board for Rockchp RK3588.
 
+config TARGET_JAGUAR_RK3588
+	bool "Theobroma Systems SBC-RK3588-AMR (Jaguar)"
+	select BOARD_LATE_INIT
+	help
+	  The SBC-RK3588-AMR is a Single Board Computer designed by
+	  Theobroma Systems for autonomous mobile robots.
+
+	  It provides the following features:
+	    * up to 32GB LDDR4
+	    * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
+	    * SD card
+	    * Gigabit Ethernet
+	    * 1x USB-A 2.0 host
+	    * PCIe M.2 2230 Key M (Gen 2 1-lane) for WiFi+BT
+	    * PCIe M.2 2280 Key M (Gen 3 4-lane) for NVMe
+	    * CAN
+	    * RS485 UART
+	    * 2x USB Type-C 3.1 host/device
+	    * HDMI output
+	    * 2x camera connectors (MIPI-CSI 2-lane + I2C/SPI for IMUs + GPIOs)
+	    * EEPROM
+	    * Secure Element
+	    * ATtiny companion controller implementing:
+	      - low-power RTC functionality (ISL1208 emulation)
+	      - fan controller (AMC6821 emulation)
+	    * 80-pin Mezzanine connector
+
 config TARGET_NANOPCT6_RK3588
 	bool "FriendlyElec NanoPC-T6 RK3588 board"
 	select BOARD_LATE_INIT
@@ -174,5 +201,6 @@ source board/turing/turing-rk1-rk3588/Kconfig
 source board/rockchip/evb_rk3588/Kconfig
 source board/radxa/rock5a-rk3588s/Kconfig
 source board/radxa/rock5b-rk3588/Kconfig
+source board/theobroma-systems/jaguar_rk3588/Kconfig
 
 endif
diff --git a/board/theobroma-systems/jaguar_rk3588/Kconfig b/board/theobroma-systems/jaguar_rk3588/Kconfig
new file mode 100644
index 00000000000..0ff417af4dd
--- /dev/null
+++ b/board/theobroma-systems/jaguar_rk3588/Kconfig
@@ -0,0 +1,16 @@
+if TARGET_JAGUAR_RK3588
+
+config SYS_BOARD
+	default "jaguar_rk3588"
+
+config SYS_VENDOR
+	default "theobroma-systems"
+
+config SYS_CONFIG_NAME
+	default "jaguar_rk3588"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ENV_IS_NOWHERE
+
+endif
diff --git a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
new file mode 100644
index 00000000000..28fae4b479f
--- /dev/null
+++ b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
@@ -0,0 +1,13 @@
+JAGUAR-RK3588 (SBC-RK3588-AMR Single Board Computer)
+M:	Klaus Goger <klaus.goger@theobroma-systems.com>
+M:	Quentin Schulz <quentin.schulz@theobroma-systems.com>
+M:	Heiko Stuebner <heiko.stuebner@cherry.de>
+S:	Maintained
+F:	board/theobroma-systems/jaguar_rk3588
+F:	board/theobroma-systems/common
+F:	doc/board/theobroma-systems/
+F:	include/configs/jaguar_rk3588.h
+F:	arch/arm/dts/rk3588-jaguar*
+F:	configs/jaguar-rk3588_defconfig
+W:	https://theobroma-systems.com/product/jaguar-sbc-rk3588/
+T:	git git://git.theobroma-systems.com/jaguar-u-boot.git
diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile b/board/theobroma-systems/jaguar_rk3588/Makefile
new file mode 100644
index 00000000000..532aab01532
--- /dev/null
+++ b/board/theobroma-systems/jaguar_rk3588/Makefile
@@ -0,0 +1,10 @@
+#
+# Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+#
+# SPDX-License-Identifier:	GPL-2.0+
+#
+
+obj-y += jaguar_rk3588.o
+ifneq ($(CONFIG_SPL_BUILD),y)
+obj-y	+= ../common/common.o
+endif
diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
new file mode 100644
index 00000000000..a6d44f10db3
--- /dev/null
+++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include <phy.h>
+#include <eth_phy.h>
+
+#include <asm/types.h>
+#include <asm/arch-rockchip/cru_rk3588.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/arch-rockchip/ioc_rk3588.h>
+#include <asm-generic/u-boot.h>
+#include <dm/device.h>
+#include <dm/uclass-id.h>
+#include <linux/bitfield.h>
+
+#include "../common/common.h"
+
+#define GPIO2C3_SEL_MASK		GENMASK(15, 12)
+#define GPIO2C3_ETH0_REFCLKO_25M	FIELD_PREP(GPIO2C3_SEL_MASK, 1)
+
+#define REFCLKO25M_ETH0_OUT_SEL_MASK	BIT(15)
+#define REFCLKO25M_ETH0_OUT_SEL_CPLL	FIELD_PREP(REFCLKO25M_ETH0_OUT_SEL_MASK, 1)
+#define REFCLKO25M_ETH0_OUT_DIV_MASK	GENMASK(14, 8)
+#define REFCLKO25M_ETH0_OUT_DIV(x)	FIELD_PREP(REFCLKO25M_ETH0_OUT_DIV_MASK, (x) - 1)
+
+#define REFCLKO25M_ETH0_OUT_EN		BIT(4)
+
+void setup_eth0refclko(void)
+{
+	/* Configure and enable ETH0_REFCLKO_25MHz */
+	static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
+	static struct rk3588_cru * const cru = (void *)CRU_BASE;
+
+	/* 1. Pinmux */
+	rk_clrsetreg(&bus_ioc->gpio2c_iomux_sel_l, GPIO2C3_SEL_MASK, GPIO2C3_ETH0_REFCLKO_25M);
+	/* 2. Parent clock selection + divider => CPLL (1.5GHz) / 60 => 25MHz */
+	rk_clrsetreg(&cru->clksel_con[15],
+		     REFCLKO25M_ETH0_OUT_SEL_MASK | REFCLKO25M_ETH0_OUT_DIV_MASK,
+		     REFCLKO25M_ETH0_OUT_SEL_CPLL | REFCLKO25M_ETH0_OUT_DIV(60));
+	/* 3. Enable clock */
+	rk_clrreg(&cru->clkgate_con[5], REFCLKO25M_ETH0_OUT_EN);
+}
+
+int rockchip_early_misc_init_r(void)
+{
+	setup_boottargets();
+
+	setup_eth0refclko();
+
+	return 0;
+}
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
new file mode 100644
index 00000000000..f55bfb1c82b
--- /dev/null
+++ b/configs/jaguar-rk3588_defconfig
@@ -0,0 +1,114 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_ENV_SIZE=0x1f000
+CONFIG_DEFAULT_DEVICE_TREE="rk3588-jaguar"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_TARGET_JAGUAR_RK3588=y
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xfeb50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CYCLIC=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_ATF=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SF is not set
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_CMD_MII is not set
+# CONFIG_CMD_BLOCK_CACHE is not set
+# CONFIG_CMD_EFICONFIG is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EROFS=y
+CONFIG_CMD_SQUASHFS=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+# CONFIG_SARADC_ROCKCHIP is not set
+CONFIG_SPL_CLK=y
+CONFIG_CLK_GPIO=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SPL_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_SPL_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+# CONFIG_SPI_FLASH is not set
+CONFIG_SF_DEFAULT_BUS=5
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 62357c99388..f0a11f84ccc 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -53,6 +53,7 @@ Board-specific doc
    ste/index
    tbs/index
    thead/index
+   theobroma-systems/index
    ti/index
    toradex/index
    variscite/index
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index e23ca4231cc..1d5451183be 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -120,6 +120,7 @@ List of mainline supported Rockchip boards:
      - Turing Machines RK1 (turing-rk1-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B (rock5b-rk3588)
+     - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
 
diff --git a/doc/board/theobroma-systems/index.rst b/doc/board/theobroma-systems/index.rst
new file mode 100644
index 00000000000..945f7a2f976
--- /dev/null
+++ b/doc/board/theobroma-systems/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Theobroma Systems
+=================
+
+.. toctree::
+   :maxdepth: 2
+
+   jaguar_rk3588
diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
new file mode 100644
index 00000000000..db15f945d3b
--- /dev/null
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+SBC-RK3588-AMR Jaguar
+=====================
+
+The SBC-RK3588-AMR is a Single Board Computer designed by
+Theobroma Systems for autonomous mobile robots.
+
+It provides the following features:
+
+ * up to 32GB LDDR4
+ * up to 128GB on-module eMMC (with 8-bit 1.8V interface)
+ * SD card
+ * Gigabit Ethernet
+ * 1x USB-A 2.0 host
+ * PCIe M.2 2230 Key M (Gen 2 1-lane) for WiFi+BT
+ * PCIe M.2 2280 Key M (Gen 3 4-lane) for NVMe
+ * CAN
+ * RS485 UART
+ * 2x USB Type-C 3.1 host/device
+ * HDMI output
+ * 2x camera connectors (MIPI-CSI 2-lane I2C/SPI for IMUs GPIOs)
+ * EEPROM
+ * Secure Element
+ * ATtiny companion controller implementing:
+
+   - low-power RTC functionality (ISL1208 emulation)
+   - fan controller (AMC6821 emulation)
+
+ * 80-pin Mezzanine connector
+
+Here is the step-by-step to boot to U-Boot on SBC-RK3588-AMR Jaguar from Theobroma
+Systems.
+
+Get the TF-A and DDR init (TPL) binaries
+----------------------------------------
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkbin
+   cd rkbin
+   export RKBIN=$(pwd)
+   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.38.elf
+   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.11.bin
+   sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
+   ./tools/ddrbin_tool tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
+   export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
+
+This will setup all required external dependencies for compiling U-Boot. This will
+be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
+gains support for open-source DRAM initialization in TPL.
+
+Build U-Boot
+------------
+
+.. prompt:: bash
+
+   cd ../u-boot
+   make CROSS_COMPILE=aarch64-linux-gnu- jaguar-rk3588_defconfig all
+
+This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
+(eMMC or SD card).
+
+Flash the image
+---------------
+
+Copy ``u-boot-rockchip.bin`` to offset 32k for SD/eMMC.
+
+SD-Card
+~~~~~~~
+
+.. prompt:: bash
+
+   dd if=u-boot-rockchip.bin of=/dev/sdX seek=64
+
+.. note::
+
+   Replace ``/dev/sdX`` to match your SD card kernel device.
+
+eMMC
+~~~~
+
+``rkdeveloptool`` allows to flash the on-board eMMC via the USB OTG interface
+with help of the Rockchip loader binary.
+
+To enter the USB flashing mode, remove any SD card, insert a USB-C cable in the
+``DOWNLOAD`` USB Type-C connector (P11) and then power cycle or reset the board
+while pressing the ``BIOS`` (SW2) button. A new USB device should have appeared
+on your PC (check with ``lsusb -d 2207:350b``).
+
+To flash U-Boot on the eMMC with ``rkdeveloptool``:
+
+.. prompt:: bash
+
+   git clone https://github.com/rockchip-linux/rkdeveloptool
+   cd rkdeveloptool
+   autoreconf -i && CPPFLAGS=-Wno-format-truncation ./configure && make
+   ./rkdeveloptool db "$RKDB"
+   ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
diff --git a/include/configs/jaguar_rk3588.h b/include/configs/jaguar_rk3588.h
new file mode 100644
index 00000000000..843028c5385
--- /dev/null
+++ b/include/configs/jaguar_rk3588.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Theobroma Systems Design und Consulting GmbH
+ */
+
+#ifndef __JAGUAR_RK3588_H
+#define __JAGUAR_RK3588_H
+
+#define ROCKCHIP_DEVICE_SETTINGS \
+		"stdout=serial,vidconsole\0" \
+		"stderr=serial,vidconsole\0"
+
+#include <configs/rk3588_common.h>
+
+#endif /* __JAGUAR_RK3588_H */

-- 
2.44.0

