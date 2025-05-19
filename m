Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F978C3ABDD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 18:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADB082A4B;
	Mon, 19 May 2025 20:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJ54iNZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A9382BAA; Mon, 19 May 2025 17:47:59 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2745E82B4A
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 17:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ivitro@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a36e950e41so893570f8f.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747669670; x=1748274470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7xPqhMYm1S8CKSBAxruS6GUSyQy6QlS/t7AJ7gbwq9w=;
 b=jJ54iNZMVK2ntF7NzLkIJ9ETl5m3YYPc9A7QMrCh/RPF8LOh/K9UWT3Uy2lcJODcxL
 FcfEEP1QYwHTDPWcZ27a5jt8KVo99bMLHtpw9uWNXLXSyozzore6b9xPuGhwggKrb0lE
 oB25T+54ZWK1/f7HTzxHkySeTzlJvkQxItSzf63OHY7Kw4G3cWRr7fy9i5kPViU0zaE4
 8SLiGvYDlgoQvA+N1rIXpUhAW9EjrXLJrETwAiege/XALavNW5JcZ0fncKnS7oQVHGyt
 jCRWvz9Ae2krKSxLiy07oDZNoyn7B8hqpfQptFAZnx9IhVRhAPC6QMV64LxhggHOaExK
 f9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747669670; x=1748274470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xPqhMYm1S8CKSBAxruS6GUSyQy6QlS/t7AJ7gbwq9w=;
 b=F5uv9SSrPvoMF204/VtuylW3pc4+oNziqgnCYmq6PiNmyPtlM8UOzB3oym2KEx6dzZ
 jVFi5SaSl/686pJ2cW01Z8nEJcgn7xx9lAYMF4RJAsK6/Op8vVzIe0/OeiYF4nwyE0/8
 hoFaXaIkXmHZ1LUX4YBBBa5s1hA9I9ycS8Pp5vGOv7RKAAX/WfGknrtALWYNQ5M9pDnb
 zkgGFHYNmL8T2pC+P1Bp+y2puXdwrlQfKFo/1KlhZfa7gbGUt8XeUNFU3icjiyyovdey
 zN5yHEvnbFYewl+xkGwgrS1TdcPPL6ERjf1brii8Df5fjKnN0DD0RubRQqnR8RcNiEDZ
 rxhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUdhdc8KXEAJrh0qb/q3ij08PP2PmbkFxG0wH4VjZQ3ftbL0WKqSU48EbrSTnNl+o+aQt/JyE=@lists.denx.de
X-Gm-Message-State: AOJu0YxOC/zLa3PDIZSez9xKxJOPk/kYa2kHXZibciCk1Fv1/eNSz+vH
 JUAox/y5ljf8Mid1+5h22UxbiOgWxJVPgnom0SatZ2uyxrvRaqMV5kAh
X-Gm-Gg: ASbGncuzGUMaq8qu0GBdokQ8e+58tcboZefDBljHv1x89sq7afgwQvHIWIv7tf88Ufi
 4EMwf/sCb/owUT62m5qZYXVu7vtQU7IFHoPeFWVafYchtjHTo9qoZuW1dfzVg4WJZMoPnyeL8I1
 VH6QpQCr3/bTFBDGV+W6BLYavi73tXL+/zvX4t9NKA71nfCdsr8HHX6kt2zs1KBkQBNzQu3cFbG
 4LIpm7LPTbZKRDo49dJWLmVBAtvuP0uPav00agynsnvicNdN9soVGRiIApotyhmIGJ0CTyxmlwx
 c9XdXB2Bhi/rkail6YCJT68OaATp+MguhVMBYp43e4RqQEvL0WLc4pz9Rw==
X-Google-Smtp-Source: AGHT+IFdPPfxSHsbj30wbYyRjPn+SvPMJM1g7C0g81NVM/cC2lJU/iF4YNHPEePLG41NPsCXXpCCUQ==
X-Received: by 2002:a05:6000:310a:b0:3a3:6a77:3350 with SMTP id
 ffacd0b85a97d-3a36a77371amr5775774f8f.8.1747669669436; 
 Mon, 19 May 2025 08:47:49 -0700 (PDT)
Received: from vitor-nb.. ([2001:8a0:e602:d900:701:eee6:e08d:c042])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd4fe161sm151621085e9.8.2025.05.19.08.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 08:47:48 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de,
 ivitro@gmail.com, Vitor Soares <vitor.soares@toradex.com>
Subject: [PATCH v1] board: toradex: add verdin am62p support
Date: Mon, 19 May 2025 16:47:45 +0100
Message-Id: <20250519154745.429751-1-ivitro@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 May 2025 20:58:22 +0200
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

From: Parth Pancholi <parth.pancholi@toradex.com>

This adds initial support for the Toradex Verdin AM62P module.

The module consists of an TI AM62P family SoC, a TPS65219 PMIC, a
Gigabit Ethernet PHY, up to 8GB of LPDDR4 RAM, an eMMC, a TLA2024 ADC,
an I2C EEPROM, an RX8130 RTC, plus an optional Bluetooth/Wi-Fi module.

These specific changes adds support for Toradex Verdin AM62P Quad 2GB WB
IT module.

Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
Link: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
Device tree is the same from current Linux next, with audio_refclk0
removed since it's not present in U-Boot k3-am62p-main.dtsi.
The audio_refclk0 was added to k3-am62p-main.dtsi in Linux v6.15,
while U-Boot is currently synced with Linux v6.14;

Full alignment will be completed once the board device tree is in
mainline Linux [1], at which point we'll move to OF_UPSTREAM.

This patch depends on [2], which should be applied first.

[1] https://lore.kernel.org/all/20250430102815.149162-1-francesco@dolcini.it/
[2] https://lore.kernel.org/u-boot/20250519084630.376452-1-ivitro@gmail.com/

 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-am62p-verdin-dev.dtsi         |  243 ++
 arch/arm/dts/k3-am62p-verdin-wifi.dtsi        |   31 +
 arch/arm/dts/k3-am62p-verdin.dtsi             | 1399 ++++++++
 .../arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi | 2801 +++++++++++++++++
 arch/arm/dts/k3-am62p5-verdin-r5.dts          |   84 +
 .../dts/k3-am62p5-verdin-wifi-dev-binman.dtsi |  325 ++
 .../dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi |  167 +
 arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts    |   22 +
 arch/arm/mach-k3/am62px/Kconfig               |    1 +
 board/toradex/verdin-am62p/Kconfig            |   83 +
 board/toradex/verdin-am62p/MAINTAINERS        |   17 +
 board/toradex/verdin-am62p/Makefile           |    6 +
 board/toradex/verdin-am62p/board-cfg.yaml     |   37 +
 board/toradex/verdin-am62p/pm-cfg.yaml        |   12 +
 board/toradex/verdin-am62p/rm-cfg.yaml        | 1083 +++++++
 board/toradex/verdin-am62p/sec-cfg.yaml       |  378 +++
 board/toradex/verdin-am62p/tifs-rm-cfg.yaml   |  927 ++++++
 board/toradex/verdin-am62p/verdin-am62p.c     |  151 +
 board/toradex/verdin-am62p/verdin-am62p.env   |   41 +
 configs/verdin-am62p_a53_defconfig            |  199 ++
 configs/verdin-am62p_r5_defconfig             |  117 +
 doc/board/toradex/verdin-am62p.rst            |  196 ++
 include/configs/verdin-am62p.h                |   15 +
 24 files changed, 8338 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am62p-verdin-dev.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-verdin-wifi.dtsi
 create mode 100644 arch/arm/dts/k3-am62p-verdin.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-verdin-r5.dts
 create mode 100644 arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts
 create mode 100644 board/toradex/verdin-am62p/Kconfig
 create mode 100644 board/toradex/verdin-am62p/MAINTAINERS
 create mode 100644 board/toradex/verdin-am62p/Makefile
 create mode 100644 board/toradex/verdin-am62p/board-cfg.yaml
 create mode 100644 board/toradex/verdin-am62p/pm-cfg.yaml
 create mode 100644 board/toradex/verdin-am62p/rm-cfg.yaml
 create mode 100644 board/toradex/verdin-am62p/sec-cfg.yaml
 create mode 100644 board/toradex/verdin-am62p/tifs-rm-cfg.yaml
 create mode 100644 board/toradex/verdin-am62p/verdin-am62p.c
 create mode 100644 board/toradex/verdin-am62p/verdin-am62p.env
 create mode 100644 configs/verdin-am62p_a53_defconfig
 create mode 100644 configs/verdin-am62p_r5_defconfig
 create mode 100644 doc/board/toradex/verdin-am62p.rst
 create mode 100644 include/configs/verdin-am62p.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 32b698a7f411..0355d39936ab 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1112,7 +1112,9 @@ dtb-$(CONFIG_SOC_K3_AM62A7) += \
 	k3-am62a7-r5-sk.dtb \
 	k3-am62a7-r5-phycore-som-2gb.dtb
 
-dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb
+dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb \
+			       k3-am62p5-verdin-r5.dtb \
+			       k3-am62p5-verdin-wifi-dev.dtb
 
 dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7622-rfb.dtb \
diff --git a/arch/arm/dts/k3-am62p-verdin-dev.dtsi b/arch/arm/dts/k3-am62p-verdin-dev.dtsi
new file mode 100644
index 000000000000..4cf382260778
--- /dev/null
+++ b/arch/arm/dts/k3-am62p-verdin-dev.dtsi
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ *
+ * Common dtsi for Verdin AM62P SoM on Development carrier board
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+ * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
+ */
+
+/ {
+	aliases {
+		eeprom1 = &carrier_eeprom;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "verdin-nau8822";
+		simple-audio-card,routing =
+			"Headphones", "LHP",
+			"Headphones", "RHP",
+			"Speaker", "LSPK",
+			"Speaker", "RSPK",
+			"Line Out", "AUXOUT1",
+			"Line Out", "AUXOUT2",
+			"LAUX", "Line In",
+			"RAUX", "Line In",
+			"LMICP", "Mic In",
+			"RMICP", "Mic In";
+		simple-audio-card,widgets =
+			"Headphones", "Headphones",
+			"Line Out", "Line Out",
+			"Speaker", "Speaker",
+			"Microphone", "Mic In",
+			"Line", "Line In";
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp0>;
+		};
+	};
+};
+
+/* Verdin ETHs */
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1>, <&pinctrl_rgmii2>;
+	status = "okay";
+};
+
+/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
+&cpsw3g_mdio {
+	status = "okay";
+
+	carrier_eth_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eth2_rgmii_int>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <42 IRQ_TYPE_EDGE_FALLING>;
+		micrel,led-mode = <0>;
+	};
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&cpsw_port1 {
+	status = "okay";
+};
+
+/* Verdin ETH_2_RGMII */
+&cpsw_port2 {
+	phy-handle = <&carrier_eth_phy>;
+	phy-mode = "rgmii-rxid";
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&epwm0 {
+	status = "okay";
+};
+
+/* Verdin PWM_1, PWM_2 */
+&epwm2 {
+	status = "okay";
+};
+
+&main_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie_1_reset>,
+		    <&pinctrl_gpio_5>,
+		    <&pinctrl_gpio_6>,
+		    <&pinctrl_gpio_7>,
+		    <&pinctrl_gpio_8>;
+};
+
+/* Verdin I2C_1 */
+&main_i2c0 {
+	status = "okay";
+
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s1_mclk>;
+		#sound-dai-cells = <0>;
+	};
+
+	carrier_gpio_expander: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	/* Current measurement into module VCC */
+	hwmon@40 {
+		compatible = "ti,ina219";
+		reg = <0x40>;
+		shunt-resistor = <10000>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75c";
+		reg = <0x4f>;
+	};
+
+	carrier_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* Verdin I2C_2_DSI */
+&main_i2c1 {
+	status = "okay";
+};
+
+/* Verdin I2C_4_CSI */
+&main_i2c3 {
+	status = "okay";
+};
+
+/* Verdin CAN_1 */
+&main_mcan0 {
+	status = "okay";
+};
+
+/* Verdin SPI_1 */
+&main_spi1 {
+	status = "okay";
+};
+
+/* Verdin UART_3, used as the Linux console */
+&main_uart0 {
+	status = "okay";
+};
+
+/* Verdin UART_1, connector X50 through RS485 transceiver */
+&main_uart1 {
+	rs485-rx-during-tx;
+	linux,rs485-enabled-at-boot-time;
+	status = "okay";
+};
+
+/* Verdin I2S_1 */
+&mcasp0 {
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_1>,
+		    <&pinctrl_gpio_2>,
+		    <&pinctrl_gpio_3>,
+		    <&pinctrl_gpio_4>;
+};
+
+/* Verdin I2C_3_HDMI */
+&mcu_i2c0 {
+	status = "okay";
+};
+
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	status = "okay";
+};
+
+/* Verdin UART_4 */
+&mcu_uart0 {
+	status = "okay";
+};
+
+/* Verdin QSPI_1 */
+&ospi0 {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&sdhci1 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usbss0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usbss1 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+/* Verdin CTRL_WAKE1_MICO# */
+&verdin_gpio_keys {
+	status = "okay";
+};
+
+/* Verdin PCIE_1_RESET# */
+&verdin_pcie_1_reset_hog {
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&wkup_uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-am62p-verdin-wifi.dtsi b/arch/arm/dts/k3-am62p-verdin-wifi.dtsi
new file mode 100644
index 000000000000..04d3124b5e0f
--- /dev/null
+++ b/arch/arm/dts/k3-am62p-verdin-wifi.dtsi
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ *
+ * Common dtsi for Verdin AM62P SoM WB variant
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+ */
+
+/* On-module Bluetooth */
+&main_uart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart6>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+		fw-init-baudrate = <3000000>;
+	};
+};
+
+/* On-module Wi-Fi */
+&sdhci2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci2>;
+	keep-power-in-suspend;
+	non-removable;
+	ti,fails-without-test-cd;
+	status = "okay";
+};
diff --git a/arch/arm/dts/k3-am62p-verdin.dtsi b/arch/arm/dts/k3-am62p-verdin.dtsi
new file mode 100644
index 000000000000..b78b2ac76f32
--- /dev/null
+++ b/arch/arm/dts/k3-am62p-verdin.dtsi
@@ -0,0 +1,1399 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ *
+ * Common dtsi for Verdin AM62P SoM
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	aliases {
+		can0 = &main_mcan0;
+		can1 = &mcu_mcan0;
+		eeprom0 = &som_eeprom;
+		ethernet0 = &cpsw_port1;
+		ethernet1 = &cpsw_port2;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &main_i2c0;
+		i2c2 = &main_i2c1;
+		i2c3 = &mcu_i2c0;
+		i2c4 = &main_i2c3;
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+		mmc2 = &sdhci2;
+		rtc0 = &som_rtc_i2c;
+		rtc1 = &wkup_rtc0;
+		serial0 = &main_uart1;
+		serial1 = &wkup_uart0;
+		serial2 = &main_uart0;
+		serial3 = &mcu_uart0;
+		serial4 = &main_uart6;
+		usb0 = &usb0;
+		usb1 = &usb1;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_id>;
+		id-gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
+		label = "USB_1";
+		self-powered;
+		vbus-supply = <&reg_usb0_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb0_ep>;
+			};
+		};
+	};
+
+	verdin_gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
+		status = "disabled";
+
+		key-wakeup {
+			debounce-interval = <10>;
+			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
+			gpios = <&main_gpio0 1 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	memory@80000000 {
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		device_type = "memory";
+	};
+
+	opp-table {
+		/* Add 1.4GHz OPP. Requires VDD_CORE to be at 0.85V */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
+	reg_force_sleep_moci: regulator-force-sleep-moci {
+		compatible = "regulator-fixed";
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpios = <&som_gpio_expander 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "CTRL_SLEEP_MOCI#";
+	};
+
+	/* Verdin SD_1 Power Supply */
+	reg_sd1_vmmc: regulator-sdhci1-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sd1_pwr_en>;
+		/* Verdin SD_1_PWR_EN (SODIMM 76) */
+		gpios = <&main_gpio0 47 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_SD";
+		startup-delay-us = <2000>;
+	};
+
+	reg_sd1_vqmmc: regulator-sdhci1-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sd_vsel>;
+		/* PMIC_VSEL_SD */
+		gpios = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
+		regulator-name = "LDO1-VSEL-SD (PMIC)";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <1800000 0x0>,
+			 <3300000 0x1>;
+		vin-supply = <&reg_sd_3v3_1v8>;
+	};
+
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0_en>;
+		/* Verdin USB_1_EN (SODIMM 155) */
+		gpios = <&main_gpio1 50 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "USB_1_EN";
+	};
+
+	/* Module Power Supply */
+	reg_vsodimm: regulator-vsodimm {
+		compatible = "regulator-fixed";
+		regulator-name = "+V_SODIMM";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure_tfa_ddr: tfa@9e780000 {
+			reg = <0x00 0x9e780000 0x00 0x80000>;
+			no-map;
+		};
+
+		secure_ddr: optee@9e800000 {
+			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
+			no-map;
+		};
+
+		wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x00 0x9c900000 0x00 0x01e00000>;
+			no-map;
+		};
+	};
+};
+
+&main_pmx0 {
+	/* Verdin PWM_3_DSI */
+	pinctrl_epwm0_b: main-epwm0b-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01b8, PIN_OUTPUT, 2) /* (E20) SPI0_CS1.EHRPWM0_B */ /* SODIMM 19 */
+		>;
+	};
+
+	/* Verdin PWM_2 */
+	pinctrl_epwm2_a: main-epwm2a-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0124, PIN_OUTPUT, 4) /* (J25) MMC2_SDCD.EHRPWM2_A */ /* SODIMM 16 */
+		>;
+	};
+
+	/* Verdin PWM_1 */
+	pinctrl_epwm2_b: main-epwm2b-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0128, PIN_OUTPUT, 4) /* (K25) MMC2_SDWP.EHRPWM2_B */ /* SODIMM 15 */
+		>;
+	};
+
+	/* Verdin QSPI_1_CLK as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_clk_gpio: main-gpio0-0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0000, PIN_INPUT, 7) /* (P23) OSPI0_CLK.GPIO0_0 */ /* SODIMM 52 */
+		>;
+	};
+
+	/* Verdin CTRL_WAKE1_MICO# */
+	pinctrl_ctrl_wake1_mico: main-gpio0-1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0004, PIN_INPUT, 7) /* (N23) OSPI0_LBCLKO.GPIO0_1 */ /* SODIMM 252 */
+		>;
+	};
+
+	/* Verdin QSPI_1_DQS as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_dqs_gpio: main-gpio0-2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0008, PIN_INPUT, 7) /* (P22) OSPI0_DQS.GPIO0_2 */ /* SODIMM 66 */
+		>;
+	};
+
+	/* Verdin QSPI_1_IO0 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io0_gpio: main-gpio0-3-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x000c, PIN_INPUT, 7) /* (L25) OSPI0_D0.GPIO0_3 */ /* SODIMM 56 */
+		>;
+	};
+
+	/* Verdin QSPI_1_IO1 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io1_gpio: main-gpio0-4-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0010, PIN_INPUT, 7) /* (N24) OSPI0_D1.GPIO0_4 */ /* SODIMM 58 */
+		>;
+	};
+
+	/* Verdin QSPI_1_IO2 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io2_gpio: main-gpio0-5-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0014, PIN_INPUT, 7) /* (N25) OSPI0_D2.GPIO0_5 */ /* SODIMM 60 */
+		>;
+	};
+
+	/* Verdin QSPI_1_IO3 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io3_gpio: main-gpio0-6-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0018, PIN_INPUT, 7) /* (M24) OSPI0_D3.GPIO0_6 */ /* SODIMM 62 */
+		>;
+	};
+
+	/* Verdin QSPI_1_CS# as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_cs_gpio: main-gpio0-11-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x002c, PIN_INPUT, 7) /* (M25) OSPI0_CSn0.GPIO0_11 */ /* SODIMM 54 */
+		>;
+	};
+
+	/* Verdin QSPI_1_CS2# as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_cs2_gpio: main-gpio0-12-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0030, PIN_INPUT, 7) /* (L24) OSPI0_CSn1.GPIO0_12 */ /* SODIMM 64 */
+		>;
+	};
+
+	/* Verdin MSP_37 as GPIO */
+	pinctrl_msp37_gpio: main-gpio0-13-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0034, PIN_INPUT, 7) /* (L22) OSPI0_CSn2.GPIO0_13 */ /* SODIMM 174 - WiFi_W_WKUP_HOST# */
+		>;
+	};
+
+	/* Verdin PCIE_1_RESET# */
+	pinctrl_pcie_1_reset: main-gpio0-14-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0038, PIN_INPUT, 7) /* (L23) OSPI0_CSn3.GPIO0_14 */ /* SODIMM 244 */
+		>;
+	};
+
+	pinctrl_sd_vsel: main-gpio0-21-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0054, PIN_INPUT, 7) /* (V24) GPMC0_AD6.GPIO0_21 */ /* PMIC_SD_VSEL */
+		>;
+	};
+
+	pinctrl_tpm_extint: main-gpio0-25-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0064, PIN_INPUT, 7) /* (AA25) GPMC0_AD10.GPIO0_25 */ /* TPM_EXTINT# */
+		>;
+	};
+
+	pinctrl_wifi_wkup_bt: main-gpio0-29-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0074, PIN_INPUT, 7) /* (AB24) GPMC0_AD14.GPIO0_29 */ /* WiFi_WKUP_BT# */
+		>;
+	};
+
+	pinctrl_wifi_wkup_wlan: main-gpio0-30-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0078, PIN_INPUT, 7) /* (AC24) GPMC0_AD15.GPIO0_30 */ /* WiFi_WKUP_WLAN# */
+		>;
+	};
+
+	/* Verdin USB_1_ID */
+	pinctrl_usb0_id: main-gpio0-31-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x007c, PIN_INPUT, 7) /* (Y25) GPMC0_CLK.GPIO0_31 */ /* SODIMM 161 */
+		>;
+	};
+
+	/* Verdin USB_1_OC# */
+	pinctrl_usb1_oc: main-gpio0-32-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0084, PIN_INPUT, 7) /* (R25) GPMC0_ADVn_ALE.GPIO0_32 */ /* SODIMM 157 */
+		>;
+	};
+
+	/* Verdin I2S_2_D_IN as GPIO (conflict with Verdin I2S_2 interface) */
+	pinctrl_i2s_2_d_in_gpio: main-gpio0-33-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0088, PIN_INPUT, 7) /* (R24) GPMC0_OEn_REn.GPIO0_33 */ /* SODIMM 48 */
+		>;
+	};
+
+	/* Verdin I2S_2_D_OUT as GPIO (conflict with Verdin I2S_2 interface) */
+	pinctrl_i2s_2_d_out_gpio: main-gpio0-34-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x008c, PIN_INPUT, 7) /* (T25) GPMC0_WEn.GPIO0_34 */ /* SODIMM 46 */
+		>;
+	};
+
+	/* Verdin I2S_2_BCLK as GPIO (conflict with Verdin I2S_2 interface) */
+	pinctrl_i2s_2_bclk_gpio: main-gpio0-35-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 7) /* (U24) GPMC0_BE0n_CLE.GPIO0_35 */ /* SODIMM 42 */
+		>;
+	};
+
+	pinctrl_eth_int: main-gpio0-36-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0094, PIN_INPUT, 7) /* (T24) GPMC0_BE1n.GPIO0_36 */ /* ETH_INT# */
+		>;
+	};
+
+	/* Verdin I2S_2_SYNC as GPIO (conflict with Verdin I2S_2 interface) */
+	pinctrl_i2s_2_sync_gpio: main-gpio0-37-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 7) /* (AA24) GPMC0_WAIT0.GPIO0_37 */ /* SODIMM 44 */
+		>;
+	};
+
+	/* Verdin DSI_1_INT# */
+	pinctrl_dsi1_int: main-gpio0-38-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x009c, PIN_INPUT, 7) /* (AD24) GPMC0_WAIT1.GPIO0_38 */ /* SODIMM 17 */
+		>;
+	};
+
+	/* Verdin DSI_1_BLK_EN# */
+	pinctrl_dsi1_bkl_en: main-gpio0-39-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00a0, PIN_INPUT, 7) /* (P24) GPMC0_WPn.GPIO0_39 */ /* SODIMM 21 */
+		>;
+	};
+
+	/* Verdin USB_2_OC# */
+	pinctrl_usb2_oc: main-gpio0-41-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00a8, PIN_INPUT, 7) /* (T23) GPMC0_CSn0.GPIO0_41 */ /* SODIMM 187 */
+		>;
+	};
+
+	/* Verdin ETH_2_RGMII_INT# */
+	pinctrl_eth2_rgmii_int: main-gpio0-42-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00ac, PIN_INPUT, 7) /* (U23) GPMC0_CSn1.GPIO0_42 */ /* SODIMM 189 */
+		>;
+	};
+
+	/* Verdin SD_1_PWR_EN */
+	pinctrl_sd1_pwr_en: main-gpio0-47-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c0, PIN_INPUT, 7) /* (AA23) VOUT0_DATA2.GPIO0_47 */ /* SODIMM 76 */
+		>;
+	};
+
+	/* Verdin GPIO_5 */
+	pinctrl_gpio_5: main-gpio0-49-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c8, PIN_INPUT, 7) /* (AB23) VOUT0_DATA4.GPIO0_49 */ /* SODIMM 216 */
+		>;
+	};
+
+	/* Verdin GPIO_6 */
+	pinctrl_gpio_6: main-gpio0-50-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00cc, PIN_INPUT, 7) /* (AD23) VOUT0_DATA5.GPIO0_50 */ /* SODIMM 218 */
+		>;
+	};
+
+	/* Verdin GPIO_7 */
+	pinctrl_gpio_7: main-gpio0-51-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00d0, PIN_INPUT, 7) /* (AC23) VOUT0_DATA6.GPIO0_51 */ /* SODIMM 220 */
+		>;
+	};
+
+	/* Verdin GPIO_8 */
+	pinctrl_gpio_8: main-gpio0-52-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00d4, PIN_INPUT, 7) /* (AE23) VOUT0_DATA7.GPIO0_52 */ /* SODIMM 222 */
+		>;
+	};
+
+	/* Verdin MSP_36 as GPIO */
+	pinctrl_msp36_gpio: main-gpio0-57-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00e8, PIN_INPUT, 7) /* (AD21) VOUT0_DATA12.GPIO0_57 */ /* SODIMM 172 - WiFi_BT_WKUP_HOST#  */
+		>;
+	};
+
+	pinctrl_wifi_sd_int: main-gpio0-59-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00f0, PIN_INPUT, 7) /* (AA20) VOUT0_DATA14.GPIO0_59 */ /* WIFI_SD_INT */
+		>;
+	};
+
+	pinctrl_wifi_spi_cs: main-gpio0-60-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00f4, PIN_INPUT, 7) /* (Y20) VOUT0_DATA15.GPIO0_60 */ /* WIFI_SPI_CS# */
+		>;
+	};
+
+	/* Verdin PWM_3_DSI as GPIO */
+	pinctrl_pwm3_dsi_gpio: main-gpio1-16-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01b8, PIN_OUTPUT, 7) /* (E20) SPI0_CS1.GPIO1_16 */ /* SODIMM 19 */
+		>;
+	};
+
+	/* Verdin SD_1_CD# */
+	pinctrl_sd1_cd: main-gpio1-48-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0240, PIN_INPUT, 7) /* (D23) MMC1_SDCD.GPIO1_48 */ /* SODIMM 84 */
+		>;
+	};
+
+	/* Verdin MSP_29 as GPIO */
+	pinctl_msp29_gpio: main-gpio1-49-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0244, PIN_INPUT, 7) /* (D24) MMC1_SDWP.GPIO1_49 */ /* SODIMM 154 */
+		>;
+	};
+
+	/* Verdin USB_1_EN */
+	pinctrl_usb0_en: main-gpio1-50-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0254, PIN_INPUT, 7) /* (G22) USB0_DRVVBUS.GPIO1_50 */ /* SODIMM 155 */
+		>;
+	};
+
+	/* Verdin I2C_1 */
+	pinctrl_main_i2c0: main-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e0, PIN_INPUT_PULLUP, 0) /* (B25) I2C0_SCL */ /* SODIMM 14 */
+			AM62PX_IOPAD(0x01e4, PIN_INPUT_PULLUP, 0) /* (A24) I2C0_SDA */ /* SODIMM 12 */
+		>;
+	};
+
+	/* Verdin I2C_2_DSI */
+	pinctrl_main_i2c1: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */ /* SODIMM 55 */
+			AM62PX_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (B24) I2C1_SDA */ /* SODIMM 53 */
+		>;
+	};
+
+	/* Verdin I2C_4_CSI */
+	pinctrl_main_i2c3: main-i2c3-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A23) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
+			AM62PX_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (C22) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
+		>;
+	};
+
+	/* Verdin CAN_1 */
+	pinctrl_main_mcan0: main-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01dc, PIN_INPUT, 0)  /* (F20) MCAN0_RX */ /* SODIMM 22 */
+			AM62PX_IOPAD(0x01d8, PIN_OUTPUT, 0) /* (B23) MCAN0_TX */ /* SODIMM 20 */
+		>;
+	};
+
+	/* Verdin MSP_3/MSP_8 as CAN */
+	pinctrl_main_mcan1: main-mcan1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00b4, PIN_INPUT, 5)  /* (U25) GPMC0_CSn3.MCAN1_RX */ /* SODIMM 92  */
+			AM62PX_IOPAD(0x00b0, PIN_OUTPUT, 5) /* (T22) GPMC0_CSn2.MCAN1_TX */ /* SODIMM 104 */
+		>;
+	};
+
+	/* Verdin SD_1 */
+	pinctrl_sdhci1: main-mmc1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x023c, PIN_INPUT,  0) /* (H20) MMC1_CMD  */ /* SODIMM 74 */
+			AM62PX_IOPAD(0x0234, PIN_OUTPUT, 0) /* (J24) MMC1_CLK  */ /* SODIMM 78 */
+			AM62PX_IOPAD(0x0230, PIN_INPUT,  0) /* (H21) MMC1_DAT0 */ /* SODIMM 80 */
+			AM62PX_IOPAD(0x022c, PIN_INPUT,  0) /* (H23) MMC1_DAT1 */ /* SODIMM 82 */
+			AM62PX_IOPAD(0x0228, PIN_INPUT,  0) /* (H22) MMC1_DAT2 */ /* SODIMM 70 */
+			AM62PX_IOPAD(0x0224, PIN_INPUT,  0) /* (H25) MMC1_DAT3 */ /* SODIMM 72 */
+		>;
+	};
+
+	/* On-module Wi-Fi on WB SKUs, module-specific SDIO otherwise */
+	pinctrl_sdhci2: main-mmc2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0120, PIN_INPUT,  0) /* (K24) MMC2_CMD  */ /* SODIMM 160, WiFi_SDIO_CMD   */
+			AM62PX_IOPAD(0x0118, PIN_OUTPUT, 0) /* (K21) MMC2_CLK  */ /* SODIMM 156, WiFi_SDIO_CLK   */
+			AM62PX_IOPAD(0x011C, PIN_INPUT,  0) /* () MMC2_CLKLB   */
+			AM62PX_IOPAD(0x0114, PIN_INPUT,  0) /* (K23) MMC2_DAT0 */ /* SODIMM 162, WiFi_SDIO_DATA0 */
+			AM62PX_IOPAD(0x0110, PIN_INPUT,  0) /* (K22) MMC2_DAT1 */ /* SODIMM 164, WiFi_SDIO_DATA1 */
+			AM62PX_IOPAD(0x010c, PIN_INPUT,  0) /* (L20) MMC2_DAT2 */ /* SODIMM 166, WiFi_SDIO_DATA2 */
+			AM62PX_IOPAD(0x0108, PIN_INPUT,  0) /* (L21) MMC2_DAT3 */ /* SODIMM 168, WiFi_SDIO_DATA3 */
+		>;
+	};
+
+	/* Verdin QSPI_1 */
+	pinctrl_ospi0: main-ospi0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0000, PIN_OUTPUT, 0) /* (P23) OSPI0_CLK  */ /* SODIMM 52 */
+			AM62PX_IOPAD(0x002c, PIN_OUTPUT, 0) /* (M25) OSPI0_CSn0 */ /* SODIMM 54 */
+			AM62PX_IOPAD(0x0030, PIN_OUTPUT, 0) /* (L24) OSPI0_CSn1 */ /* SODIMM 64 */
+			AM62PX_IOPAD(0x000c, PIN_INPUT,  0) /* (L25) OSPI0_D0   */ /* SODIMM 56 */
+			AM62PX_IOPAD(0x0010, PIN_INPUT,  0) /* (N24) OSPI0_D1   */ /* SODIMM 58 */
+			AM62PX_IOPAD(0x0014, PIN_INPUT,  0) /* (N25) OSPI0_D2   */ /* SODIMM 60 */
+			AM62PX_IOPAD(0x0018, PIN_INPUT,  0) /* (M24) OSPI0_D3   */ /* SODIMM 62 */
+			AM62PX_IOPAD(0x0008, PIN_INPUT,  0) /* (P22) OSPI0_DQS  */ /* SODIMM 66 */
+		>;
+	};
+
+	/* Verdin ETH_1 RGMII (On-module PHY) */
+	pinctrl_rgmii1: main-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x014c, PIN_INPUT, 0) /* (B15) RGMII1_RD0    */ /* RGMII_RXD0   */
+			AM62PX_IOPAD(0x0150, PIN_INPUT, 0) /* (B16) RGMII1_RD1    */ /* RGMII_RXD1   */
+			AM62PX_IOPAD(0x0154, PIN_INPUT, 0) /* (A14) RGMII1_RD2    */ /* RGMII_RXD2   */
+			AM62PX_IOPAD(0x0158, PIN_INPUT, 0) /* (B14) RGMII1_RD3    */ /* RGMII_RXD3   */
+			AM62PX_IOPAD(0x0148, PIN_INPUT, 0) /* (A16) RGMII1_RXC    */ /* RGMII_RXC    */
+			AM62PX_IOPAD(0x0144, PIN_INPUT, 0) /* (A15) RGMII1_RX_CTL */ /* RGMII_RX_CTL */
+			AM62PX_IOPAD(0x0134, PIN_INPUT, 0) /* (A18) RGMII1_TD0    */ /* RGMII_TXD0   */
+			AM62PX_IOPAD(0x0138, PIN_INPUT, 0) /* (C17) RGMII1_TD1    */ /* RGMII_TXD1   */
+			AM62PX_IOPAD(0x013c, PIN_INPUT, 0) /* (A17) RGMII1_TD2    */ /* RGMII_TXD2   */
+			AM62PX_IOPAD(0x0140, PIN_INPUT, 0) /* (C16) RGMII1_TD3    */ /* RGMII_TXD3   */
+			AM62PX_IOPAD(0x0130, PIN_INPUT, 0) /* (B17) RGMII1_TXC    */ /* RGMII_TXC    */
+			AM62PX_IOPAD(0x012c, PIN_INPUT, 0) /* (B18) RGMII1_TX_CTL */ /* RGMII_TX_CTL */
+		>;
+	};
+
+	/* Verdin ETH_2 RGMII */
+	pinctrl_rgmii2: main-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0184, PIN_INPUT, 0) /* (E19) RGMII2_RD0    */ /* SODIMM 201 */
+			AM62PX_IOPAD(0x0188, PIN_INPUT, 0) /* (E16) RGMII2_RD1    */ /* SODIMM 203 */
+			AM62PX_IOPAD(0x018c, PIN_INPUT, 0) /* (E17) RGMII2_RD2    */ /* SODIMM 205 */
+			AM62PX_IOPAD(0x0190, PIN_INPUT, 0) /* (C19) RGMII2_RD3    */ /* SODIMM 207 */
+			AM62PX_IOPAD(0x0180, PIN_INPUT, 0) /* (D19) RGMII2_RXC    */ /* SODIMM 197 */
+			AM62PX_IOPAD(0x017c, PIN_INPUT, 0) /* (F19) RGMII2_RX_CTL */ /* SODIMM 199 */
+			AM62PX_IOPAD(0x016c, PIN_INPUT, 0) /* (B19) RGMII2_TD0    */ /* SODIMM 221 */
+			AM62PX_IOPAD(0x0170, PIN_INPUT, 0) /* (A21) RGMII2_TD1    */ /* SODIMM 219 */
+			AM62PX_IOPAD(0x0174, PIN_INPUT, 0) /* (D17) RGMII2_TD2    */ /* SODIMM 217 */
+			AM62PX_IOPAD(0x0178, PIN_INPUT, 0) /* (A19) RGMII2_TD3    */ /* SODIMM 215 */
+			AM62PX_IOPAD(0x0168, PIN_INPUT, 0) /* (D16) RGMII2_TXC    */ /* SODIMM 213 */
+			AM62PX_IOPAD(0x0164, PIN_INPUT, 0) /* (A20) RGMII2_TX_CTL */ /* SODIMM 211 */
+		>;
+	};
+
+	/* TPM SPI, Optional Module Specific SPI */
+	pinctrl_main_spi0: main-spi0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01bc, PIN_INPUT,  0) /* (B21) SPI0_CLK */ /* TPM_SPI_CLK  - SODIMM 148 */
+			AM62PX_IOPAD(0x01c0, PIN_OUTPUT, 0) /* (B20) SPI0_D0  */ /* TPM_SPI_MOSI - SODIMM 150 */
+			AM62PX_IOPAD(0x01c4, PIN_INPUT,  0) /* (C21) SPI0_D1  */ /* TPM_SPI_MISO - SODIMM 152 */
+			AM62PX_IOPAD(0x01b4, PIN_INPUT,  0) /* (D20) SPI0_CS0 */ /* TPM_SPI_CS */
+		>;
+	};
+
+	/* Verdin SPI_1 */
+	pinctrl_main_spi1: main-spi1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0020, PIN_INPUT,  1) /* (N22) OSPI0_D5.SPI1_CLK */ /* SODIMM 196 */
+			AM62PX_IOPAD(0x0024, PIN_OUTPUT, 1) /* (P21) OSPI0_D6.SPI1_D0  */ /* SODIMM 200 */
+			AM62PX_IOPAD(0x0028, PIN_INPUT,  1) /* (N20) OSPI0_D7.SPI1_D1  */ /* SODIMM 198 */
+		>;
+	};
+
+	/* Verdin SPI_1_CS */
+	pinctrl_main_spi1_cs0: main-spi1-cs0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x001c, PIN_OUTPUT, 1) /* (N21) OSPI0_D4.SPI1_CS0 */ /* SODIMM 202 */
+		>;
+	};
+
+	/* Verdin I2S_1 MCLK */
+	pinctrl_i2s1_mclk: main-system-audio-ext-reflock0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00c4, PIN_OUTPUT, 5) /* (Y23) VOUT0_DATA3.AUDIO_EXT_REFCLK0 */ /* SODIMM 38 */
+		>;
+	};
+
+	pinctrl_eth_clock: main-system-clkout0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01f0, PIN_OUTPUT_PULLUP, 5) /* (C25) EXT_REFCLK1.CLKOUT0 */ /* ETH_25MHz_CLK */
+		>;
+	};
+
+	pinctrl_pmic_extint: main-system-extint-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01f4, PIN_INPUT, 0) /* (C23) EXTINTn */ /* PMIC_EXTINT# */
+		>;
+	};
+
+	/* Verdin UART_3, used as the Linux console */
+	pinctrl_uart0: main-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x1c8, PIN_INPUT,  0) /* (A22) UART0_RXD */ /* SODIMM 147 */
+			AM62PX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (B22) UART0_TXD */ /* SODIMM 149 */
+		>;
+	};
+
+	/* Verdin UART_1 */
+	pinctrl_uart1: main-uart1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01ac, PIN_INPUT,  2) /* (G23) MCASP0_AFSR.UART1_RXD  */ /* SODIMM 129 */
+			AM62PX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (G20) MCASP0_ACLKR.UART1_TXD */ /* SODIMM 131 */
+			AM62PX_IOPAD(0x0194, PIN_INPUT,  2) /* (D25) MCASP0_AXR3.UART1_CTSn */ /* SODIMM 135 */
+			AM62PX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (E25) MCASP0_AXR2.UART1_RTSn */ /* SODIMM 133 */
+		>;
+	};
+
+	/* Verdin MSP 41, 42, 44 and 45 as UART */
+	pinctrl_uart2: main-uart2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00b8, PIN_INPUT,  4) /* (AE24) VOUT0_DATA0.UART2_RXD */ /* SODIMM 192 */
+			AM62PX_IOPAD(0x00bc, PIN_OUTPUT, 4) /* (W23) VOUT0_DATA1.UART2_TXD  */ /* SODIMM 190 */
+			AM62PX_IOPAD(0x0104, PIN_INPUT,  4) /* (Y21) VOUT0_PCLK.UART2_CTSn  */ /* SODIMM 184 */
+			AM62PX_IOPAD(0x0100, PIN_OUTPUT, 4) /* (W20) VOUT0_VSYNC.UART2_RTSn */ /* SODIMM 186 */
+		>;
+	};
+
+	/* Bluetooth on WB SKUs */
+	pinctrl_uart6: main-uart6-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x00d8, PIN_INPUT,  4) /* (AE22) VOUT0_DATA8.UART6_RXD   */ /* WiFi_UART_RXD */
+			AM62PX_IOPAD(0x00dc, PIN_OUTPUT, 4) /* (AC22) VOUT0_DATA9.UART6_TXD   */ /* WiFi_UART_TXD */
+			AM62PX_IOPAD(0x00e4, PIN_INPUT,  4) /* (AE21) VOUT0_DATA11.UART6_CTSn */ /* WiFi_UART_CTS */
+			AM62PX_IOPAD(0x00e0, PIN_OUTPUT, 4) /* (W22)  VOUT0_DATA10.UART6_RTSn */ /* WiFi_UART_RTS */
+		>;
+	};
+
+	/* Verdin USB_2_EN */
+	pinctrl_usb1: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0258, PIN_OUTPUT, 0) /* (G21) USB1_DRVVBUS */ /* SODIMM 185 */
+		>;
+	};
+
+	/* Verdin I2S_1 */
+	pinctrl_mcasp0: mcasp0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x01a4, PIN_INPUT, 0) /* (F24) MCASP0_ACLKX */ /* SODIMM 30 */
+			AM62PX_IOPAD(0x01a8, PIN_INPUT, 0) /* (F25) MCASP0_AFSX  */ /* SODIMM 32 */
+			AM62PX_IOPAD(0x01a0, PIN_INPUT, 0) /* (F23) MCASP0_AXR0  */ /* SODIMM 34 */
+			AM62PX_IOPAD(0x019c, PIN_INPUT, 0) /* (E24) MCASP0_AXR1  */ /* SODIMM 36 */
+		>;
+	};
+
+	/* Verdin I2S_2 */
+	pinctrl_mcasp1: mcasp1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0090, PIN_INPUT, 2) /* (U24)  GPMC0_BE0n_CLE.MCASP1_ACLKX */ /* SODIMM 42 */
+			AM62PX_IOPAD(0x0098, PIN_INPUT, 2) /* (AA24) GPMC0_WAIT0.MCASP1_AFSX     */ /* SODIMM 44 */
+			AM62PX_IOPAD(0x008c, PIN_INPUT, 2) /* (T25)  GPMC0_WEn.MCASP1_AXR0       */ /* SODIMM 46 */
+			AM62PX_IOPAD(0x0088, PIN_INPUT, 2) /* (R24)  GPMC0_OEn_REn.MCASP1_AXR1   */ /* SODIMM 48 */
+		>;
+	};
+
+	/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
+	pinctrl_mdio: mdio0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_IOPAD(0x0160, PIN_OUTPUT, 0) /* (F17) MDIO0_MDC  */ /* SODIMM 193 */
+			AM62PX_IOPAD(0x015c, PIN_INPUT,  0) /* (F16) MDIO0_MDIO */ /* SODIMM 191 */
+		>;
+	};
+};
+
+&mcu_pmx0 {
+	/* Verdin GPIO_1 */
+	pinctrl_gpio_1: mcu-gpio0-1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0004, PIN_INPUT, 7) /* (E10) MCU_SPI0_CS1.MCU_GPIO0_1 */ /* SODIMM 206 */
+		>;
+	};
+
+	/* Verdin GPIO_2 */
+	pinctrl_gpio_2: mcu-gpio0-2-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0008, PIN_INPUT, 7) /* (C10) MCU_SPI0_CLK.MCU_GPIO0_2 */ /* SODIMM 208 */
+		>;
+	};
+
+	/* Verdin GPIO_3 */
+	pinctrl_gpio_3: mcu-gpio0-3-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x000c, PIN_INPUT, 7) /* (B11) MCU_SPI0_D0.MCU_GPIO0_3 */ /* SODIMM 210 */
+		>;
+	};
+
+	/* Verdin GPIO_4 */
+	pinctrl_gpio_4: mcu-gpio0-4-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0010, PIN_INPUT, 7) /* (D10) MCU_SPI0_D1.MCU_GPIO0_4 */ /* SODIMM 212 */
+		>;
+	};
+
+	/* Verdin I2C_3_HDMI */
+	pinctrl_mcu_i2c0: mcu-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0044, PIN_INPUT, 0) /* (E11) MCU_I2C0_SCL */ /* SODIMM 59 */
+			AM62PX_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D11) MCU_I2C0_SDA */ /* SODIMM 57 */
+		>;
+	};
+
+	/* Verdin CAN_2 */
+	pinctrl_mcu_mcan0: mcu-mcan0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0038, PIN_INPUT,  0) /* (D6) MCU_MCAN0_RX */ /* SODIMM 22 */
+			AM62PX_MCU_IOPAD(0x0034, PIN_OUTPUT, 0) /* (E8) MCU_MCAN0_TX */ /* SODIMM 20 */
+		>;
+	};
+
+	/* Verdin MSP_13/MSP_18 as CAN */
+	pinctrl_mcu_mcan1: mcu-mcan1-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0040, PIN_INPUT,  0) /* (E7) MCU_MCAN1_RX */ /* SODIMM 116 */
+			AM62PX_MCU_IOPAD(0x003c, PIN_OUTPUT, 0) /* (F8) MCU_MCAN1_TX */ /* SODIMM 128 */
+		>;
+	};
+
+	/* Verdin UART_4 */
+	pinctrl_mcu_uart0: mcu-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0014, PIN_INPUT,  0) /* (B6) MCU_UART0_RXD */ /* SODIMM 151 */
+			AM62PX_MCU_IOPAD(0x0018, PIN_OUTPUT, 0) /* (C8) MCU_UART0_TXD */ /* SODIMM 153 */
+		>;
+	};
+
+	/* On-module I2C - PMIC_I2C */
+	pinctrl_wkup_i2c0: wkup-i2c0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x004c, PIN_INPUT, 0) /* (A13) WKUP_I2C0_SCL */ /* PMIC_I2C_SCL */
+			AM62PX_MCU_IOPAD(0x0050, PIN_INPUT, 0) /* (C11) WKUP_I2C0_SDA */ /* PMIC_I2C_SDA */
+		>;
+	};
+
+	/* Verdin CSI_1_MCLK */
+	pinctrl_wkup_clkout0: wkup-system-clkout0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x0084, PIN_OUTPUT, 0) /* (F13) WKUP_CLKOUT0 */ /* SODIMM 91 */
+		>;
+	};
+
+	/* Verdin UART_2 */
+	pinctrl_wkup_uart0: wkup-uart0-default-pins {
+		pinctrl-single,pins = <
+			AM62PX_MCU_IOPAD(0x002c, PIN_INPUT,  0) /* (C7) WKUP_UART0_CTSn */ /* SODIMM 143 */
+			AM62PX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C6) WKUP_UART0_RTSn */ /* SODIMM 141 */
+			AM62PX_MCU_IOPAD(0x0024, PIN_INPUT,  0) /* (D8) WKUP_UART0_RXD  */ /* SODIMM 137 */
+			AM62PX_MCU_IOPAD(0x0028, PIN_OUTPUT, 0) /* (D7) WKUP_UART0_TXD  */ /* SODIMM 139 */
+		>;
+	};
+};
+
+&cpsw3g {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1>;
+	status = "disabled";
+};
+
+/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
+&cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio>, <&pinctrl_eth_clock>;
+	assigned-clocks = <&k3_clks 157 36>;
+	assigned-clock-parents = <&k3_clks 157 38>;
+	assigned-clock-rates = <25000000>;
+	status = "disabled";
+
+	som_eth_phy: ethernet-phy@0 {
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eth_int>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <36 IRQ_TYPE_EDGE_FALLING>;
+		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+	};
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&cpsw_port1 {
+	phy-handle = <&som_eth_phy>;
+	phy-mode = "rgmii-rxid";
+	status = "disabled";
+};
+
+/* Verdin ETH_2_RGMII */
+&cpsw_port2 {
+	status = "disabled";
+};
+
+/* Verdin PWM_3_DSI */
+&epwm0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_epwm0_b>;
+	status = "disabled";
+};
+
+/* Verdin PWM_1, PWM_2 */
+&epwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_epwm2_a>, <&pinctrl_epwm2_b>;
+	status = "disabled";
+};
+
+&mailbox0_cluster0 {
+	status = "okay";
+
+	mbox_r5_0: mbox-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&mailbox0_cluster1 {
+	status = "okay";
+
+	mbox_mcu_r5_0: mbox-mcu-r5-0 {
+		ti,mbox-rx = <0 0 0>;
+		ti,mbox-tx = <1 0 0>;
+	};
+};
+
+&main_gpio0 {
+	gpio-line-names =
+		"SODIMM_52",
+		"SODIMM_252",
+		"SODIMM_66",
+		"SODIMM_56",
+		"SODIMM_58",
+		"SODIMM_60",
+		"SODIMM_62",
+		"",
+		"",
+		"",
+		"", /* 10 */
+		"SODIMM_54",
+		"SODIMM_64",
+		"SODIMM_174",
+		"SODIMM_244",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 20 */
+		"PMIC_SD_VSEL",
+		"",
+		"",
+		"",
+		"TPM_EXTINT#",
+		"",
+		"",
+		"",
+		"WiFi_WKUP_BT#",
+		"WiFi_WKUP_WLAN#", /* 30 */
+		"SODIMM_161",
+		"SODIMM_157",
+		"",
+		"",
+		"",
+		"ETH_INT#",
+		"",
+		"SODIMM_17",
+		"SODIMM_21",
+		"", /* 40 */
+		"SODIMM_187",
+		"SODIMM_189",
+		"",
+		"",
+		"",
+		"",
+		"SODIMM_76",
+		"",
+		"SODIMM_216",
+		"SODIMM_218", /* 50 */
+		"SODIMM_220",
+		"SODIMM_222",
+		"",
+		"",
+		"",
+		"",
+		"SODIMM_172",
+		"",
+		"WIFI_SD_INT",
+		"WIFI_SPI_CS#", /* 60 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 70 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 80 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 90 */
+		"";
+
+	verdin_pcie_1_reset_hog: pcie-1-reset-hog {
+		gpio-hog;
+		/* Verdin PCIE_1_RESET# (SODIMM 244) */
+		gpios = <14 GPIO_ACTIVE_LOW>;
+		line-name = "PCIE_1_RESET#";
+		output-low;
+		status = "disabled";
+	};
+};
+
+&main_gpio1 {
+	gpio-line-names =
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 10 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 20 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 30 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 40 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"SODIMM_84",
+		"SODIMM_154",
+		"SODIMM_155", /* 50 */
+		"";
+};
+
+/* Verdin I2C_1 */
+&main_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_i2c0>;
+	status = "disabled";
+};
+
+/* Verdin I2C_2_DSI */
+&main_i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_i2c1>;
+	status = "disabled";
+};
+
+/* Verdin I2C_4_CSI */
+&main_i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_i2c3>;
+	status = "disabled";
+};
+
+/* Verdin CAN_1 */
+&main_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_mcan0>;
+	status = "disabled";
+};
+
+/* TPM SPI, optional SPI on module specific pins */
+&main_spi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_spi0>;
+	ti,pindir-d0-out-d1-in;
+	status = "okay";
+
+	tpm@0 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tpm_extint>;
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+/* Verdin SPI_1 */
+&main_spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_main_spi1>, <&pinctrl_main_spi1_cs0>;
+	ti,pindir-d0-out-d1-in;
+	status = "disabled";
+};
+
+/* Verdin UART_3, used as the Linux console */
+&main_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "disabled";
+};
+
+/* Verdin UART_1 */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	uart-has-rtscts;
+	status = "disabled";
+};
+
+/* Verdin I2S_1 */
+&mcasp0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcasp0>;
+	op-mode = <0>; /* I2S mode */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 2 0 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tdm-slots = <2>;
+	rx-num-evt = <0>;
+	tx-num-evt = <0>;
+	#sound-dai-cells = <0>;
+	status = "disabled";
+};
+
+/* Verdin I2S_2 */
+&mcasp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcasp1>;
+	op-mode = <0>; /* I2S mode */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 2 0 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tdm-slots = <2>;
+	rx-num-evt = <0>;
+	tx-num-evt = <0>;
+	#sound-dai-cells = <0>;
+	status = "disabled";
+};
+
+&mcu_gpio0 {
+	gpio-line-names =
+		"",
+		"SODIMM_206",
+		"SODIMM_208",
+		"SODIMM_210",
+		"SODIMM_212",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 10 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"", /* 20 */
+		"",
+		"",
+		"";
+};
+
+/* Verdin I2C_3_HDMI */
+&mcu_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_i2c0>;
+	status = "disabled";
+};
+
+/* Verdin CAN_2 */
+&mcu_mcan0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_mcan0>;
+	status = "disabled";
+};
+
+/* Verdin UART_4 */
+&mcu_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mcu_uart0>;
+	status = "disabled";
+};
+
+/* Verdin QSPI_1 */
+&ospi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ospi0>;
+	status = "disabled";
+};
+
+/* On-module eMMC */
+&sdhci0 {
+	no-mmc-hs400;
+	non-removable;
+	ti,driver-strength-ohm = <50>;
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1>, <&pinctrl_sd1_cd>;
+	cd-gpios = <&main_gpio1 48 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	vqmmc-supply = <&reg_sd1_vqmmc>;
+	ti,fails-without-test-cd;
+	status = "disabled";
+};
+
+/* Verdin USB_1 */
+&usbss0 {
+	ti,vbus-divider;
+	status = "disabled";
+};
+
+&usb0 {
+	adp-disable;
+	usb-role-switch;
+	status = "disabled";
+
+	port {
+		usb0_ep: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+/* Verdin USB_2 */
+&usbss1 {
+	ti,vbus-divider;
+	status = "disabled";
+};
+
+&usb1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "host";
+	status = "disabled";
+};
+
+/* On-module I2C - PMIC_I2C */
+&wkup_i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wkup_i2c0>;
+	clock-frequency = <400000>;
+	status = "okay";
+
+	som_gpio_expander: gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names = "SODIMM_256";
+	};
+
+	pmic@30 {
+		compatible = "ti,tps65219";
+		reg = <0x30>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic_extint>;
+		interrupt-parent = <&gic500>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+
+		buck1-supply = <&reg_vsodimm>;
+		buck2-supply = <&reg_vsodimm>;
+		buck3-supply = <&reg_vsodimm>;
+		ldo1-supply = <&reg_3v3>;
+		ldo2-supply = <&reg_1v8>;
+		ldo3-supply = <&reg_3v3>;
+		ldo4-supply = <&reg_3v3>;
+		system-power-controller;
+		ti,power-button;
+
+		regulators {
+			reg_3v3: buck1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "+V3.3 (PMIC BUCK1)";
+			};
+
+			reg_1v8: buck2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8 (PMIC BUCK2)"; /* On-module and SODIMM 214 */
+			};
+
+			buck3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1100000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-name = "+VDD_DDR (PMIC BUCK3)";
+			};
+
+			reg_sd_3v3_1v8: ldo1 {
+				regulator-allow-bypass;
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-name = "+V3.3_1.8_SD (PMIC LDO1)";
+			};
+
+			ldo2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <850000>;
+				regulator-min-microvolt = <850000>;
+				regulator-name = "+V_PMIC_LDO2 (PMIC LDO4)"; // +VDDR_CORE
+			};
+
+			ldo3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <1800000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-name = "+V1.8A (PMIC LDO3)";
+			};
+
+			ldo4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-max-microvolt = <2500000>;
+				regulator-min-microvolt = <2500000>;
+				regulator-name = "+V2.5_ETH (PMIC LDO4)";
+			};
+		};
+	};
+
+	som_rtc_i2c: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+	};
+
+	som_adc: adc@49 {
+		compatible = "ti,tla2024";
+		reg = <0x49>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#io-channel-cells = <1>;
+
+		/* Verdin (ADC_4 - ADC_3) */
+		channel@0 {
+			reg = <0>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin (ADC_4 - ADC_1) */
+		channel@1 {
+			reg = <1>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin (ADC_3 - ADC_1) */
+		channel@2 {
+			reg = <2>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin (ADC_2 - ADC_1) */
+		channel@3 {
+			reg = <3>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin ADC_4 */
+		channel@4 {
+			reg = <4>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin ADC_3 */
+		channel@5 {
+			reg = <5>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin ADC_2 */
+		channel@6 {
+			reg = <6>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+
+		/* Verdin ADC_1 */
+		channel@7 {
+			reg = <7>;
+			ti,datarate = <4>;
+			ti,gain = <2>;
+		};
+	};
+
+	som_eeprom: eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/* Verdin UART_2 */
+&wkup_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wkup_uart0>;
+	uart-has-rtscts;
+	status = "disabled";
+};
diff --git a/arch/arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi b/arch/arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi
new file mode 100644
index 000000000000..4534b0ae44bc
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi
@@ -0,0 +1,2801 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * This file was generated with the
+ * AM62Px SysConfig DDR Configuration Tool for AM64x, AM625, AM623, AM62Ax, AM62Px, AM62Dx, AM62Lx v0.10.30
+ * Sun Mar 09 2025 17:28:17 GMT+0100 (Central European Standard Time)
+ * DDR Type: LPDDR4
+ * F0 = 50MHz    F1 = NA     F2 = 1600MHz
+ * Density (per channel): 8Gb
+ * Number of Ranks: 1
+*/
+
+
+#define DDRSS_PLL_FHS_CNT 3
+#define DDRSS_PLL_FREQUENCY_1 800000000
+#define DDRSS_PLL_FREQUENCY_2 800000000
+#define DDRSS_SDRAM_IDX 15
+#define DDRSS_REGION_IDX 17
+
+#define DDRSS_CTL_0_DATA 0x00000B00
+#define DDRSS_CTL_1_DATA 0x00000000
+#define DDRSS_CTL_2_DATA 0x00000000
+#define DDRSS_CTL_3_DATA 0x00000000
+#define DDRSS_CTL_4_DATA 0x00000000
+#define DDRSS_CTL_5_DATA 0x00000000
+#define DDRSS_CTL_6_DATA 0x00000000
+#define DDRSS_CTL_7_DATA 0x00002710
+#define DDRSS_CTL_8_DATA 0x000186A0
+#define DDRSS_CTL_9_DATA 0x00000005
+#define DDRSS_CTL_10_DATA 0x00000064
+#define DDRSS_CTL_11_DATA 0x0004E200
+#define DDRSS_CTL_12_DATA 0x0030D400
+#define DDRSS_CTL_13_DATA 0x00000005
+#define DDRSS_CTL_14_DATA 0x00000C80
+#define DDRSS_CTL_15_DATA 0x0004E200
+#define DDRSS_CTL_16_DATA 0x0030D400
+#define DDRSS_CTL_17_DATA 0x00000005
+#define DDRSS_CTL_18_DATA 0x00000C80
+#define DDRSS_CTL_19_DATA 0x01010100
+#define DDRSS_CTL_20_DATA 0x01010100
+#define DDRSS_CTL_21_DATA 0x01000110
+#define DDRSS_CTL_22_DATA 0x02010002
+#define DDRSS_CTL_23_DATA 0x0000000A
+#define DDRSS_CTL_24_DATA 0x000186A0
+#define DDRSS_CTL_25_DATA 0x00000000
+#define DDRSS_CTL_26_DATA 0x00000000
+#define DDRSS_CTL_27_DATA 0x00000000
+#define DDRSS_CTL_28_DATA 0x00000000
+#define DDRSS_CTL_29_DATA 0x00020200
+#define DDRSS_CTL_30_DATA 0x00000000
+#define DDRSS_CTL_31_DATA 0x00000000
+#define DDRSS_CTL_32_DATA 0x00000000
+#define DDRSS_CTL_33_DATA 0x00000000
+#define DDRSS_CTL_34_DATA 0x08000010
+#define DDRSS_CTL_35_DATA 0x00004040
+#define DDRSS_CTL_36_DATA 0x00000000
+#define DDRSS_CTL_37_DATA 0x00000000
+#define DDRSS_CTL_38_DATA 0x00000000
+#define DDRSS_CTL_39_DATA 0x00000000
+#define DDRSS_CTL_40_DATA 0x0000040C
+#define DDRSS_CTL_41_DATA 0x00000000
+#define DDRSS_CTL_42_DATA 0x00000E38
+#define DDRSS_CTL_43_DATA 0x00000000
+#define DDRSS_CTL_44_DATA 0x00000E38
+#define DDRSS_CTL_45_DATA 0x00000000
+#define DDRSS_CTL_46_DATA 0x05000804
+#define DDRSS_CTL_47_DATA 0x00000A00
+#define DDRSS_CTL_48_DATA 0x09090004
+#define DDRSS_CTL_49_DATA 0x00000303
+#define DDRSS_CTL_50_DATA 0x006B0014
+#define DDRSS_CTL_51_DATA 0x09110048
+#define DDRSS_CTL_52_DATA 0x00004220
+#define DDRSS_CTL_53_DATA 0x006B0014
+#define DDRSS_CTL_54_DATA 0x09110048
+#define DDRSS_CTL_55_DATA 0x09004220
+#define DDRSS_CTL_56_DATA 0x000A0A09
+#define DDRSS_CTL_57_DATA 0x040001B6
+#define DDRSS_CTL_58_DATA 0x090D2005
+#define DDRSS_CTL_59_DATA 0x00001710
+#define DDRSS_CTL_60_DATA 0x0C0036D8
+#define DDRSS_CTL_61_DATA 0x090D200D
+#define DDRSS_CTL_62_DATA 0x00001710
+#define DDRSS_CTL_63_DATA 0x0C0036D8
+#define DDRSS_CTL_64_DATA 0x0304200D
+#define DDRSS_CTL_65_DATA 0x04050002
+#define DDRSS_CTL_66_DATA 0x1F211F21
+#define DDRSS_CTL_67_DATA 0x01010008
+#define DDRSS_CTL_68_DATA 0x043F3F07
+#define DDRSS_CTL_69_DATA 0x03252503
+#define DDRSS_CTL_70_DATA 0x00002525
+#define DDRSS_CTL_71_DATA 0x00000101
+#define DDRSS_CTL_72_DATA 0x00000000
+#define DDRSS_CTL_73_DATA 0x01000000
+#define DDRSS_CTL_74_DATA 0x000E0803
+#define DDRSS_CTL_75_DATA 0x000000BB
+#define DDRSS_CTL_76_DATA 0x000001C0
+#define DDRSS_CTL_77_DATA 0x0000185E
+#define DDRSS_CTL_78_DATA 0x000001C0
+#define DDRSS_CTL_79_DATA 0x0000185E
+#define DDRSS_CTL_80_DATA 0x00000005
+#define DDRSS_CTL_81_DATA 0x00000007
+#define DDRSS_CTL_82_DATA 0x00000010
+#define DDRSS_CTL_83_DATA 0x000000E0
+#define DDRSS_CTL_84_DATA 0x00000304
+#define DDRSS_CTL_85_DATA 0x000000E0
+#define DDRSS_CTL_86_DATA 0x00000304
+#define DDRSS_CTL_87_DATA 0x03004000
+#define DDRSS_CTL_88_DATA 0x00001201
+#define DDRSS_CTL_89_DATA 0x000C0005
+#define DDRSS_CTL_90_DATA 0x2408000C
+#define DDRSS_CTL_91_DATA 0x0A050524
+#define DDRSS_CTL_92_DATA 0x170C0803
+#define DDRSS_CTL_93_DATA 0x170C0803
+#define DDRSS_CTL_94_DATA 0x03010103
+#define DDRSS_CTL_95_DATA 0x00010301
+#define DDRSS_CTL_96_DATA 0x000F000F
+#define DDRSS_CTL_97_DATA 0x01CC01CC
+#define DDRSS_CTL_98_DATA 0x01CC01CC
+#define DDRSS_CTL_99_DATA 0x00000000
+#define DDRSS_CTL_100_DATA 0x03030000
+#define DDRSS_CTL_101_DATA 0x05050501
+#define DDRSS_CTL_102_DATA 0x03031804
+#define DDRSS_CTL_103_DATA 0x0C080C08
+#define DDRSS_CTL_104_DATA 0x08030318
+#define DDRSS_CTL_105_DATA 0x030C080C
+#define DDRSS_CTL_106_DATA 0x00000303
+#define DDRSS_CTL_107_DATA 0x00000301
+#define DDRSS_CTL_108_DATA 0x00000001
+#define DDRSS_CTL_109_DATA 0x00000000
+#define DDRSS_CTL_110_DATA 0x40020100
+#define DDRSS_CTL_111_DATA 0x00038010
+#define DDRSS_CTL_112_DATA 0x00050004
+#define DDRSS_CTL_113_DATA 0x00000004
+#define DDRSS_CTL_114_DATA 0x00040003
+#define DDRSS_CTL_115_DATA 0x00040005
+#define DDRSS_CTL_116_DATA 0x00030000
+#define DDRSS_CTL_117_DATA 0x00050004
+#define DDRSS_CTL_118_DATA 0x00000004
+#define DDRSS_CTL_119_DATA 0x00002EC0
+#define DDRSS_CTL_120_DATA 0x00002EC0
+#define DDRSS_CTL_121_DATA 0x00002EC0
+#define DDRSS_CTL_122_DATA 0x00002EC0
+#define DDRSS_CTL_123_DATA 0x00002EC0
+#define DDRSS_CTL_124_DATA 0x00000000
+#define DDRSS_CTL_125_DATA 0x0000051D
+#define DDRSS_CTL_126_DATA 0x00061780
+#define DDRSS_CTL_127_DATA 0x00061780
+#define DDRSS_CTL_128_DATA 0x00061780
+#define DDRSS_CTL_129_DATA 0x00061780
+#define DDRSS_CTL_130_DATA 0x00061780
+#define DDRSS_CTL_131_DATA 0x00000000
+#define DDRSS_CTL_132_DATA 0x0000AA92
+#define DDRSS_CTL_133_DATA 0x00061780
+#define DDRSS_CTL_134_DATA 0x00061780
+#define DDRSS_CTL_135_DATA 0x00061780
+#define DDRSS_CTL_136_DATA 0x00061780
+#define DDRSS_CTL_137_DATA 0x00061780
+#define DDRSS_CTL_138_DATA 0x00000000
+#define DDRSS_CTL_139_DATA 0x0000AA92
+#define DDRSS_CTL_140_DATA 0x00000000
+#define DDRSS_CTL_141_DATA 0x00000000
+#define DDRSS_CTL_142_DATA 0x00000000
+#define DDRSS_CTL_143_DATA 0x00000000
+#define DDRSS_CTL_144_DATA 0x00000000
+#define DDRSS_CTL_145_DATA 0x00000000
+#define DDRSS_CTL_146_DATA 0x00000000
+#define DDRSS_CTL_147_DATA 0x00000000
+#define DDRSS_CTL_148_DATA 0x00000000
+#define DDRSS_CTL_149_DATA 0x00000000
+#define DDRSS_CTL_150_DATA 0x00000000
+#define DDRSS_CTL_151_DATA 0x00000000
+#define DDRSS_CTL_152_DATA 0x00000000
+#define DDRSS_CTL_153_DATA 0x00000000
+#define DDRSS_CTL_154_DATA 0x00000000
+#define DDRSS_CTL_155_DATA 0x00000000
+#define DDRSS_CTL_156_DATA 0x00000000
+#define DDRSS_CTL_157_DATA 0x00000000
+#define DDRSS_CTL_158_DATA 0x03050000
+#define DDRSS_CTL_159_DATA 0x03080308
+#define DDRSS_CTL_160_DATA 0x00000000
+#define DDRSS_CTL_161_DATA 0x08010000
+#define DDRSS_CTL_162_DATA 0x000E0808
+#define DDRSS_CTL_163_DATA 0x01000000
+#define DDRSS_CTL_164_DATA 0x0E080808
+#define DDRSS_CTL_165_DATA 0x00000000
+#define DDRSS_CTL_166_DATA 0x08080801
+#define DDRSS_CTL_167_DATA 0x0000080E
+#define DDRSS_CTL_168_DATA 0x00040003
+#define DDRSS_CTL_169_DATA 0x00000007
+#define DDRSS_CTL_170_DATA 0x00000000
+#define DDRSS_CTL_171_DATA 0x00000000
+#define DDRSS_CTL_172_DATA 0x00000000
+#define DDRSS_CTL_173_DATA 0x00000000
+#define DDRSS_CTL_174_DATA 0x00000000
+#define DDRSS_CTL_175_DATA 0x00000000
+#define DDRSS_CTL_176_DATA 0x01000000
+#define DDRSS_CTL_177_DATA 0x00000000
+#define DDRSS_CTL_178_DATA 0x00001700
+#define DDRSS_CTL_179_DATA 0x0000100E
+#define DDRSS_CTL_180_DATA 0x00000002
+#define DDRSS_CTL_181_DATA 0x00000000
+#define DDRSS_CTL_182_DATA 0x00000001
+#define DDRSS_CTL_183_DATA 0x00000002
+#define DDRSS_CTL_184_DATA 0x00000C00
+#define DDRSS_CTL_185_DATA 0x00008000
+#define DDRSS_CTL_186_DATA 0x00000C00
+#define DDRSS_CTL_187_DATA 0x00008000
+#define DDRSS_CTL_188_DATA 0x00000C00
+#define DDRSS_CTL_189_DATA 0x00008000
+#define DDRSS_CTL_190_DATA 0x00000000
+#define DDRSS_CTL_191_DATA 0x00000000
+#define DDRSS_CTL_192_DATA 0x00000000
+#define DDRSS_CTL_193_DATA 0x00000000
+#define DDRSS_CTL_194_DATA 0x00000000
+#define DDRSS_CTL_195_DATA 0x0005000A
+#define DDRSS_CTL_196_DATA 0x0404000D
+#define DDRSS_CTL_197_DATA 0x0000000D
+#define DDRSS_CTL_198_DATA 0x00A00140
+#define DDRSS_CTL_199_DATA 0x0C0C0190
+#define DDRSS_CTL_200_DATA 0x00000190
+#define DDRSS_CTL_201_DATA 0x00A00140
+#define DDRSS_CTL_202_DATA 0x0C0C0190
+#define DDRSS_CTL_203_DATA 0x00000190
+#define DDRSS_CTL_204_DATA 0x00000000
+#define DDRSS_CTL_205_DATA 0x00000000
+#define DDRSS_CTL_206_DATA 0x00000000
+#define DDRSS_CTL_207_DATA 0x00000000
+#define DDRSS_CTL_208_DATA 0x00000004
+#define DDRSS_CTL_209_DATA 0x00000000
+#define DDRSS_CTL_210_DATA 0x00000000
+#define DDRSS_CTL_211_DATA 0x00000054
+#define DDRSS_CTL_212_DATA 0x0000002D
+#define DDRSS_CTL_213_DATA 0x00000000
+#define DDRSS_CTL_214_DATA 0x00000054
+#define DDRSS_CTL_215_DATA 0x0000002D
+#define DDRSS_CTL_216_DATA 0x00000000
+#define DDRSS_CTL_217_DATA 0x00000004
+#define DDRSS_CTL_218_DATA 0x00000000
+#define DDRSS_CTL_219_DATA 0x00000000
+#define DDRSS_CTL_220_DATA 0x00000054
+#define DDRSS_CTL_221_DATA 0x0000002D
+#define DDRSS_CTL_222_DATA 0x00000000
+#define DDRSS_CTL_223_DATA 0x00000054
+#define DDRSS_CTL_224_DATA 0x0000002D
+#define DDRSS_CTL_225_DATA 0x00000000
+#define DDRSS_CTL_226_DATA 0x00000000
+#define DDRSS_CTL_227_DATA 0x00000029
+#define DDRSS_CTL_228_DATA 0x000000A9
+#define DDRSS_CTL_229_DATA 0x000000A9
+#define DDRSS_CTL_230_DATA 0x00000029
+#define DDRSS_CTL_231_DATA 0x000000A9
+#define DDRSS_CTL_232_DATA 0x000000A9
+#define DDRSS_CTL_233_DATA 0x00000000
+#define DDRSS_CTL_234_DATA 0x00000000
+#define DDRSS_CTL_235_DATA 0x00000000
+#define DDRSS_CTL_236_DATA 0x00000000
+#define DDRSS_CTL_237_DATA 0x00000000
+#define DDRSS_CTL_238_DATA 0x00000000
+#define DDRSS_CTL_239_DATA 0x00000000
+#define DDRSS_CTL_240_DATA 0x00000000
+#define DDRSS_CTL_241_DATA 0x00000000
+#define DDRSS_CTL_242_DATA 0x00000000
+#define DDRSS_CTL_243_DATA 0x00000000
+#define DDRSS_CTL_244_DATA 0x00000000
+#define DDRSS_CTL_245_DATA 0x00000000
+#define DDRSS_CTL_246_DATA 0x00000000
+#define DDRSS_CTL_247_DATA 0x00000000
+#define DDRSS_CTL_248_DATA 0x00000000
+#define DDRSS_CTL_249_DATA 0x00000000
+#define DDRSS_CTL_250_DATA 0x00000000
+#define DDRSS_CTL_251_DATA 0x00000000
+#define DDRSS_CTL_252_DATA 0x00000000
+#define DDRSS_CTL_253_DATA 0x00000000
+#define DDRSS_CTL_254_DATA 0x00000000
+#define DDRSS_CTL_255_DATA 0x00000000
+#define DDRSS_CTL_256_DATA 0x00000000
+#define DDRSS_CTL_257_DATA 0x35003535
+#define DDRSS_CTL_258_DATA 0x00002735
+#define DDRSS_CTL_259_DATA 0x00000027
+#define DDRSS_CTL_260_DATA 0x00000027
+#define DDRSS_CTL_261_DATA 0x00000027
+#define DDRSS_CTL_262_DATA 0x00000027
+#define DDRSS_CTL_263_DATA 0x00000027
+#define DDRSS_CTL_264_DATA 0x00000000
+#define DDRSS_CTL_265_DATA 0x00000000
+#define DDRSS_CTL_266_DATA 0x0000002B
+#define DDRSS_CTL_267_DATA 0x0000002B
+#define DDRSS_CTL_268_DATA 0x0000002B
+#define DDRSS_CTL_269_DATA 0x0000002B
+#define DDRSS_CTL_270_DATA 0x0000002B
+#define DDRSS_CTL_271_DATA 0x0000002B
+#define DDRSS_CTL_272_DATA 0x00000000
+#define DDRSS_CTL_273_DATA 0x00000000
+#define DDRSS_CTL_274_DATA 0x00000015
+#define DDRSS_CTL_275_DATA 0x00000015
+#define DDRSS_CTL_276_DATA 0x00000000
+#define DDRSS_CTL_277_DATA 0x00000015
+#define DDRSS_CTL_278_DATA 0x00000015
+#define DDRSS_CTL_279_DATA 0x00000020
+#define DDRSS_CTL_280_DATA 0x00010000
+#define DDRSS_CTL_281_DATA 0x00000100
+#define DDRSS_CTL_282_DATA 0x00000000
+#define DDRSS_CTL_283_DATA 0x00000000
+#define DDRSS_CTL_284_DATA 0x00000101
+#define DDRSS_CTL_285_DATA 0x00000000
+#define DDRSS_CTL_286_DATA 0x00000000
+#define DDRSS_CTL_287_DATA 0x00000000
+#define DDRSS_CTL_288_DATA 0x00000000
+#define DDRSS_CTL_289_DATA 0x00000000
+#define DDRSS_CTL_290_DATA 0x00000000
+#define DDRSS_CTL_291_DATA 0x00000000
+#define DDRSS_CTL_292_DATA 0x00000000
+#define DDRSS_CTL_293_DATA 0x00000000
+#define DDRSS_CTL_294_DATA 0x00000000
+#define DDRSS_CTL_295_DATA 0x00000000
+#define DDRSS_CTL_296_DATA 0x0C181511
+#define DDRSS_CTL_297_DATA 0x00000304
+#define DDRSS_CTL_298_DATA 0x00000000
+#define DDRSS_CTL_299_DATA 0x00000000
+#define DDRSS_CTL_300_DATA 0x00000000
+#define DDRSS_CTL_301_DATA 0x00000000
+#define DDRSS_CTL_302_DATA 0x00000000
+#define DDRSS_CTL_303_DATA 0x00000000
+#define DDRSS_CTL_304_DATA 0x00000000
+#define DDRSS_CTL_305_DATA 0x00000000
+#define DDRSS_CTL_306_DATA 0x00000000
+#define DDRSS_CTL_307_DATA 0x00000000
+#define DDRSS_CTL_308_DATA 0x00000000
+#define DDRSS_CTL_309_DATA 0x00000000
+#define DDRSS_CTL_310_DATA 0x00000000
+#define DDRSS_CTL_311_DATA 0x00020000
+#define DDRSS_CTL_312_DATA 0x00400100
+#define DDRSS_CTL_313_DATA 0x00080032
+#define DDRSS_CTL_314_DATA 0x01000200
+#define DDRSS_CTL_315_DATA 0x06400040
+#define DDRSS_CTL_316_DATA 0x00020030
+#define DDRSS_CTL_317_DATA 0x00400100
+#define DDRSS_CTL_318_DATA 0x00300640
+#define DDRSS_CTL_319_DATA 0x00030000
+#define DDRSS_CTL_320_DATA 0x00500050
+#define DDRSS_CTL_321_DATA 0x00000100
+#define DDRSS_CTL_322_DATA 0x01010000
+#define DDRSS_CTL_323_DATA 0x00000101
+#define DDRSS_CTL_324_DATA 0x1FFF0000
+#define DDRSS_CTL_325_DATA 0x000FFF00
+#define DDRSS_CTL_326_DATA 0xFFFFFFFF
+#define DDRSS_CTL_327_DATA 0x00FFFF00
+#define DDRSS_CTL_328_DATA 0x0B000000
+#define DDRSS_CTL_329_DATA 0x0001FFFF
+#define DDRSS_CTL_330_DATA 0x01010101
+#define DDRSS_CTL_331_DATA 0x01010101
+#define DDRSS_CTL_332_DATA 0x00000118
+#define DDRSS_CTL_333_DATA 0x00000C01
+#define DDRSS_CTL_334_DATA 0x00040100
+#define DDRSS_CTL_335_DATA 0x00040100
+#define DDRSS_CTL_336_DATA 0x00000000
+#define DDRSS_CTL_337_DATA 0x00000000
+#define DDRSS_CTL_338_DATA 0x01030303
+#define DDRSS_CTL_339_DATA 0x00000001
+#define DDRSS_CTL_340_DATA 0x00000000
+#define DDRSS_CTL_341_DATA 0x00000000
+#define DDRSS_CTL_342_DATA 0x00000000
+#define DDRSS_CTL_343_DATA 0x7FFFFFFF
+#define DDRSS_CTL_344_DATA 0x00000000
+#define DDRSS_CTL_345_DATA 0x00000000
+#define DDRSS_CTL_346_DATA 0x00000000
+#define DDRSS_CTL_347_DATA 0x00000000
+#define DDRSS_CTL_348_DATA 0x00000000
+#define DDRSS_CTL_349_DATA 0x00000000
+#define DDRSS_CTL_350_DATA 0x00000000
+#define DDRSS_CTL_351_DATA 0x00000000
+#define DDRSS_CTL_352_DATA 0x00000000
+#define DDRSS_CTL_353_DATA 0x00000000
+#define DDRSS_CTL_354_DATA 0x00000000
+#define DDRSS_CTL_355_DATA 0x00000000
+#define DDRSS_CTL_356_DATA 0x00000000
+#define DDRSS_CTL_357_DATA 0x00000000
+#define DDRSS_CTL_358_DATA 0x00000000
+#define DDRSS_CTL_359_DATA 0x00000000
+#define DDRSS_CTL_360_DATA 0xFFFFFFFF
+#define DDRSS_CTL_361_DATA 0xFFFF0000
+#define DDRSS_CTL_362_DATA 0x00000000
+#define DDRSS_CTL_363_DATA 0xFFFFFFFF
+#define DDRSS_CTL_364_DATA 0x00000000
+#define DDRSS_CTL_365_DATA 0x00FFFFFF
+#define DDRSS_CTL_366_DATA 0xFFFF00FF
+#define DDRSS_CTL_367_DATA 0x0000FFFF
+#define DDRSS_CTL_368_DATA 0x00000000
+#define DDRSS_CTL_369_DATA 0x00000000
+#define DDRSS_CTL_370_DATA 0x00000000
+#define DDRSS_CTL_371_DATA 0x00000000
+#define DDRSS_CTL_372_DATA 0x00000000
+#define DDRSS_CTL_373_DATA 0x00000000
+#define DDRSS_CTL_374_DATA 0x00000000
+#define DDRSS_CTL_375_DATA 0x00000000
+#define DDRSS_CTL_376_DATA 0x00000000
+#define DDRSS_CTL_377_DATA 0x00000000
+#define DDRSS_CTL_378_DATA 0x00000000
+#define DDRSS_CTL_379_DATA 0x00000000
+#define DDRSS_CTL_380_DATA 0x00000000
+#define DDRSS_CTL_381_DATA 0x00000000
+#define DDRSS_CTL_382_DATA 0x00000000
+#define DDRSS_CTL_383_DATA 0x01000101
+#define DDRSS_CTL_384_DATA 0x01010001
+#define DDRSS_CTL_385_DATA 0x00010101
+#define DDRSS_CTL_386_DATA 0x01080803
+#define DDRSS_CTL_387_DATA 0x05020201
+#define DDRSS_CTL_388_DATA 0x0C081818
+#define DDRSS_CTL_389_DATA 0x0008040C
+#define DDRSS_CTL_390_DATA 0x0B100406
+#define DDRSS_CTL_391_DATA 0x0B100406
+#define DDRSS_CTL_392_DATA 0x10100806
+#define DDRSS_CTL_393_DATA 0x01000000
+#define DDRSS_CTL_394_DATA 0x06030601
+#define DDRSS_CTL_395_DATA 0x04000103
+#define DDRSS_CTL_396_DATA 0x1B000004
+#define DDRSS_CTL_397_DATA 0x00000176
+#define DDRSS_CTL_398_DATA 0x00000200
+#define DDRSS_CTL_399_DATA 0x00000200
+#define DDRSS_CTL_400_DATA 0x00000200
+#define DDRSS_CTL_401_DATA 0x00000200
+#define DDRSS_CTL_402_DATA 0x00000693
+#define DDRSS_CTL_403_DATA 0x00000E9C
+#define DDRSS_CTL_404_DATA 0x03000202
+#define DDRSS_CTL_405_DATA 0x33200404
+#define DDRSS_CTL_406_DATA 0x000030BC
+#define DDRSS_CTL_407_DATA 0x00000200
+#define DDRSS_CTL_408_DATA 0x00000200
+#define DDRSS_CTL_409_DATA 0x00000200
+#define DDRSS_CTL_410_DATA 0x00000200
+#define DDRSS_CTL_411_DATA 0x0000DB4E
+#define DDRSS_CTL_412_DATA 0x0001E758
+#define DDRSS_CTL_413_DATA 0x0F160402
+#define DDRSS_CTL_414_DATA 0x33200A07
+#define DDRSS_CTL_415_DATA 0x000030BC
+#define DDRSS_CTL_416_DATA 0x00000200
+#define DDRSS_CTL_417_DATA 0x00000200
+#define DDRSS_CTL_418_DATA 0x00000200
+#define DDRSS_CTL_419_DATA 0x00000200
+#define DDRSS_CTL_420_DATA 0x0000DB4E
+#define DDRSS_CTL_421_DATA 0x0001E758
+#define DDRSS_CTL_422_DATA 0x0F160402
+#define DDRSS_CTL_423_DATA 0x00200A07
+#define DDRSS_CTL_424_DATA 0x00000000
+#define DDRSS_CTL_425_DATA 0x02000A00
+#define DDRSS_CTL_426_DATA 0x00050003
+#define DDRSS_CTL_427_DATA 0x00010101
+#define DDRSS_CTL_428_DATA 0x00010101
+#define DDRSS_CTL_429_DATA 0x00010001
+#define DDRSS_CTL_430_DATA 0x00000101
+#define DDRSS_CTL_431_DATA 0x02000201
+#define DDRSS_CTL_432_DATA 0x02010000
+#define DDRSS_CTL_433_DATA 0x06000200
+#define DDRSS_CTL_434_DATA 0x00001E1E
+#define DDRSS_PI_0_DATA 0x00000B00
+#define DDRSS_PI_1_DATA 0x00000000
+#define DDRSS_PI_2_DATA 0x00000000
+#define DDRSS_PI_3_DATA 0x01000000
+#define DDRSS_PI_4_DATA 0x00000001
+#define DDRSS_PI_5_DATA 0x00010064
+#define DDRSS_PI_6_DATA 0x00000000
+#define DDRSS_PI_7_DATA 0x00000000
+#define DDRSS_PI_8_DATA 0x00000000
+#define DDRSS_PI_9_DATA 0x00000000
+#define DDRSS_PI_10_DATA 0x00000000
+#define DDRSS_PI_11_DATA 0x00000002
+#define DDRSS_PI_12_DATA 0x00000005
+#define DDRSS_PI_13_DATA 0x00050001
+#define DDRSS_PI_14_DATA 0x08000000
+#define DDRSS_PI_15_DATA 0x00010300
+#define DDRSS_PI_16_DATA 0x00000005
+#define DDRSS_PI_17_DATA 0x00000000
+#define DDRSS_PI_18_DATA 0x00000000
+#define DDRSS_PI_19_DATA 0x00000000
+#define DDRSS_PI_20_DATA 0x00000000
+#define DDRSS_PI_21_DATA 0x00000000
+#define DDRSS_PI_22_DATA 0x00000000
+#define DDRSS_PI_23_DATA 0x00000000
+#define DDRSS_PI_24_DATA 0x00000000
+#define DDRSS_PI_25_DATA 0x00000000
+#define DDRSS_PI_26_DATA 0x01010000
+#define DDRSS_PI_27_DATA 0x0A000100
+#define DDRSS_PI_28_DATA 0x00000028
+#define DDRSS_PI_29_DATA 0x05000000
+#define DDRSS_PI_30_DATA 0x00320000
+#define DDRSS_PI_31_DATA 0x00000000
+#define DDRSS_PI_32_DATA 0x00000000
+#define DDRSS_PI_33_DATA 0x01010102
+#define DDRSS_PI_34_DATA 0x00000000
+#define DDRSS_PI_35_DATA 0x00000000
+#define DDRSS_PI_36_DATA 0x00000000
+#define DDRSS_PI_37_DATA 0x00000001
+#define DDRSS_PI_38_DATA 0x000000AA
+#define DDRSS_PI_39_DATA 0x00000055
+#define DDRSS_PI_40_DATA 0x000000B5
+#define DDRSS_PI_41_DATA 0x0000004A
+#define DDRSS_PI_42_DATA 0x00000056
+#define DDRSS_PI_43_DATA 0x000000A9
+#define DDRSS_PI_44_DATA 0x000000A9
+#define DDRSS_PI_45_DATA 0x000000B5
+#define DDRSS_PI_46_DATA 0x00000000
+#define DDRSS_PI_47_DATA 0x00000000
+#define DDRSS_PI_48_DATA 0x00050500
+#define DDRSS_PI_49_DATA 0x00000019
+#define DDRSS_PI_50_DATA 0x000007D0
+#define DDRSS_PI_51_DATA 0x00000300
+#define DDRSS_PI_52_DATA 0x00000000
+#define DDRSS_PI_53_DATA 0x00000000
+#define DDRSS_PI_54_DATA 0x01000000
+#define DDRSS_PI_55_DATA 0x00010101
+#define DDRSS_PI_56_DATA 0x01000000
+#define DDRSS_PI_57_DATA 0x03000000
+#define DDRSS_PI_58_DATA 0x00000000
+#define DDRSS_PI_59_DATA 0x00001705
+#define DDRSS_PI_60_DATA 0x00000000
+#define DDRSS_PI_61_DATA 0x00000000
+#define DDRSS_PI_62_DATA 0x00000000
+#define DDRSS_PI_63_DATA 0x0A0A140A
+#define DDRSS_PI_64_DATA 0x10020101
+#define DDRSS_PI_65_DATA 0x01000210
+#define DDRSS_PI_66_DATA 0x05000404
+#define DDRSS_PI_67_DATA 0x00010001
+#define DDRSS_PI_68_DATA 0x0001000E
+#define DDRSS_PI_69_DATA 0x01010500
+#define DDRSS_PI_70_DATA 0x00010000
+#define DDRSS_PI_71_DATA 0x00000034
+#define DDRSS_PI_72_DATA 0x00000000
+#define DDRSS_PI_73_DATA 0x00000000
+#define DDRSS_PI_74_DATA 0x0000FFFF
+#define DDRSS_PI_75_DATA 0x00000000
+#define DDRSS_PI_76_DATA 0x00000000
+#define DDRSS_PI_77_DATA 0x00000000
+#define DDRSS_PI_78_DATA 0x00000000
+#define DDRSS_PI_79_DATA 0x01000000
+#define DDRSS_PI_80_DATA 0x01010001
+#define DDRSS_PI_81_DATA 0x02000008
+#define DDRSS_PI_82_DATA 0x01000200
+#define DDRSS_PI_83_DATA 0x00000100
+#define DDRSS_PI_84_DATA 0x02000100
+#define DDRSS_PI_85_DATA 0x02000200
+#define DDRSS_PI_86_DATA 0x00000000
+#define DDRSS_PI_87_DATA 0x00000000
+#define DDRSS_PI_88_DATA 0x00000000
+#define DDRSS_PI_89_DATA 0x00000000
+#define DDRSS_PI_90_DATA 0x00000000
+#define DDRSS_PI_91_DATA 0x00000000
+#define DDRSS_PI_92_DATA 0x00000000
+#define DDRSS_PI_93_DATA 0x00000000
+#define DDRSS_PI_94_DATA 0x00000000
+#define DDRSS_PI_95_DATA 0x00000000
+#define DDRSS_PI_96_DATA 0x00000000
+#define DDRSS_PI_97_DATA 0x00000000
+#define DDRSS_PI_98_DATA 0x00000000
+#define DDRSS_PI_99_DATA 0x01000400
+#define DDRSS_PI_100_DATA 0x0E0D0F10
+#define DDRSS_PI_101_DATA 0x080A1413
+#define DDRSS_PI_102_DATA 0x01000009
+#define DDRSS_PI_103_DATA 0x00000302
+#define DDRSS_PI_104_DATA 0x00000008
+#define DDRSS_PI_105_DATA 0x08000000
+#define DDRSS_PI_106_DATA 0x00000100
+#define DDRSS_PI_107_DATA 0x00000000
+#define DDRSS_PI_108_DATA 0x0000AA00
+#define DDRSS_PI_109_DATA 0x00000000
+#define DDRSS_PI_110_DATA 0x00000000
+#define DDRSS_PI_111_DATA 0x00010000
+#define DDRSS_PI_112_DATA 0x00000000
+#define DDRSS_PI_113_DATA 0x00000000
+#define DDRSS_PI_114_DATA 0x00000000
+#define DDRSS_PI_115_DATA 0x00000000
+#define DDRSS_PI_116_DATA 0x00000000
+#define DDRSS_PI_117_DATA 0x00000000
+#define DDRSS_PI_118_DATA 0x00000000
+#define DDRSS_PI_119_DATA 0x00000000
+#define DDRSS_PI_120_DATA 0x00000000
+#define DDRSS_PI_121_DATA 0x00000000
+#define DDRSS_PI_122_DATA 0x00000000
+#define DDRSS_PI_123_DATA 0x00000000
+#define DDRSS_PI_124_DATA 0x00000000
+#define DDRSS_PI_125_DATA 0x00000000
+#define DDRSS_PI_126_DATA 0x00000000
+#define DDRSS_PI_127_DATA 0x00000000
+#define DDRSS_PI_128_DATA 0x00000000
+#define DDRSS_PI_129_DATA 0x00000000
+#define DDRSS_PI_130_DATA 0x00000000
+#define DDRSS_PI_131_DATA 0x00000000
+#define DDRSS_PI_132_DATA 0x00000000
+#define DDRSS_PI_133_DATA 0x00000000
+#define DDRSS_PI_134_DATA 0x00000000
+#define DDRSS_PI_135_DATA 0x00000000
+#define DDRSS_PI_136_DATA 0x00000008
+#define DDRSS_PI_137_DATA 0x00000000
+#define DDRSS_PI_138_DATA 0x00000000
+#define DDRSS_PI_139_DATA 0x00000000
+#define DDRSS_PI_140_DATA 0x00000000
+#define DDRSS_PI_141_DATA 0x00000000
+#define DDRSS_PI_142_DATA 0x00000000
+#define DDRSS_PI_143_DATA 0x00000000
+#define DDRSS_PI_144_DATA 0x00000000
+#define DDRSS_PI_145_DATA 0x00010000
+#define DDRSS_PI_146_DATA 0x00000000
+#define DDRSS_PI_147_DATA 0x00000000
+#define DDRSS_PI_148_DATA 0x0000000A
+#define DDRSS_PI_149_DATA 0x000186A0
+#define DDRSS_PI_150_DATA 0x00000100
+#define DDRSS_PI_151_DATA 0x00000000
+#define DDRSS_PI_152_DATA 0x00000000
+#define DDRSS_PI_153_DATA 0x00000000
+#define DDRSS_PI_154_DATA 0x00000000
+#define DDRSS_PI_155_DATA 0x00000000
+#define DDRSS_PI_156_DATA 0x01000000
+#define DDRSS_PI_157_DATA 0x00010003
+#define DDRSS_PI_158_DATA 0x02000101
+#define DDRSS_PI_159_DATA 0x01030001
+#define DDRSS_PI_160_DATA 0x00010400
+#define DDRSS_PI_161_DATA 0x06000105
+#define DDRSS_PI_162_DATA 0x01070001
+#define DDRSS_PI_163_DATA 0x00000000
+#define DDRSS_PI_164_DATA 0x00000000
+#define DDRSS_PI_165_DATA 0x00000000
+#define DDRSS_PI_166_DATA 0x00010001
+#define DDRSS_PI_167_DATA 0x00000000
+#define DDRSS_PI_168_DATA 0x00000000
+#define DDRSS_PI_169_DATA 0x00000000
+#define DDRSS_PI_170_DATA 0x00000000
+#define DDRSS_PI_171_DATA 0x00010000
+#define DDRSS_PI_172_DATA 0x00000004
+#define DDRSS_PI_173_DATA 0x00000000
+#define DDRSS_PI_174_DATA 0x00010000
+#define DDRSS_PI_175_DATA 0x00000000
+#define DDRSS_PI_176_DATA 0x00080000
+#define DDRSS_PI_177_DATA 0x00F000F0
+#define DDRSS_PI_178_DATA 0x00202001
+#define DDRSS_PI_179_DATA 0x00000034
+#define DDRSS_PI_180_DATA 0x00000058
+#define DDRSS_PI_181_DATA 0x00020058
+#define DDRSS_PI_182_DATA 0x02000200
+#define DDRSS_PI_183_DATA 0x00000004
+#define DDRSS_PI_184_DATA 0x00000E0C
+#define DDRSS_PI_185_DATA 0x000E3800
+#define DDRSS_PI_186_DATA 0x00380000
+#define DDRSS_PI_187_DATA 0x0000000E
+#define DDRSS_PI_188_DATA 0x000000BB
+#define DDRSS_PI_189_DATA 0x000001C0
+#define DDRSS_PI_190_DATA 0x0000185E
+#define DDRSS_PI_191_DATA 0x000001C0
+#define DDRSS_PI_192_DATA 0x0400185E
+#define DDRSS_PI_193_DATA 0x01010404
+#define DDRSS_PI_194_DATA 0x00001501
+#define DDRSS_PI_195_DATA 0x00250025
+#define DDRSS_PI_196_DATA 0x01000100
+#define DDRSS_PI_197_DATA 0x00000100
+#define DDRSS_PI_198_DATA 0x00000000
+#define DDRSS_PI_199_DATA 0x05080803
+#define DDRSS_PI_200_DATA 0x01011818
+#define DDRSS_PI_201_DATA 0x01010101
+#define DDRSS_PI_202_DATA 0x000C0C0A
+#define DDRSS_PI_203_DATA 0x00000000
+#define DDRSS_PI_204_DATA 0x00000000
+#define DDRSS_PI_205_DATA 0x04000000
+#define DDRSS_PI_206_DATA 0x0A021010
+#define DDRSS_PI_207_DATA 0x0404020A
+#define DDRSS_PI_208_DATA 0x00090031
+#define DDRSS_PI_209_DATA 0x00190041
+#define DDRSS_PI_210_DATA 0x00190041
+#define DDRSS_PI_211_DATA 0x01010101
+#define DDRSS_PI_212_DATA 0x0003000D
+#define DDRSS_PI_213_DATA 0x00030190
+#define DDRSS_PI_214_DATA 0x01000190
+#define DDRSS_PI_215_DATA 0x000E000E
+#define DDRSS_PI_216_DATA 0x01910100
+#define DDRSS_PI_217_DATA 0x01000191
+#define DDRSS_PI_218_DATA 0x01910191
+#define DDRSS_PI_219_DATA 0x301B3200
+#define DDRSS_PI_220_DATA 0x0101301B
+#define DDRSS_PI_221_DATA 0x0A070601
+#define DDRSS_PI_222_DATA 0x180F090D
+#define DDRSS_PI_223_DATA 0x180F0911
+#define DDRSS_PI_224_DATA 0x000C0011
+#define DDRSS_PI_225_DATA 0x00001000
+#define DDRSS_PI_226_DATA 0x00000C00
+#define DDRSS_PI_227_DATA 0x00001000
+#define DDRSS_PI_228_DATA 0x00000C00
+#define DDRSS_PI_229_DATA 0x02001000
+#define DDRSS_PI_230_DATA 0x001E000D
+#define DDRSS_PI_231_DATA 0x001E0190
+#define DDRSS_PI_232_DATA 0x00000190
+#define DDRSS_PI_233_DATA 0x00001900
+#define DDRSS_PI_234_DATA 0x32000056
+#define DDRSS_PI_235_DATA 0x06000101
+#define DDRSS_PI_236_DATA 0x00230204
+#define DDRSS_PI_237_DATA 0x3212005A
+#define DDRSS_PI_238_DATA 0x13000101
+#define DDRSS_PI_239_DATA 0x00230A10
+#define DDRSS_PI_240_DATA 0x3212005A
+#define DDRSS_PI_241_DATA 0x13000101
+#define DDRSS_PI_242_DATA 0x00000A10
+#define DDRSS_PI_243_DATA 0x05030900
+#define DDRSS_PI_244_DATA 0x00040900
+#define DDRSS_PI_245_DATA 0x0000018A
+#define DDRSS_PI_246_DATA 0x20010004
+#define DDRSS_PI_247_DATA 0x0A0A0A03
+#define DDRSS_PI_248_DATA 0x250D0000
+#define DDRSS_PI_249_DATA 0x1F090021
+#define DDRSS_PI_250_DATA 0x0000315C
+#define DDRSS_PI_251_DATA 0x20060048
+#define DDRSS_PI_252_DATA 0x17101718
+#define DDRSS_PI_253_DATA 0x250D0000
+#define DDRSS_PI_254_DATA 0x1F090021
+#define DDRSS_PI_255_DATA 0x0000315C
+#define DDRSS_PI_256_DATA 0x20060048
+#define DDRSS_PI_257_DATA 0x17101718
+#define DDRSS_PI_258_DATA 0x00000000
+#define DDRSS_PI_259_DATA 0x00000176
+#define DDRSS_PI_260_DATA 0x00000E9C
+#define DDRSS_PI_261_DATA 0x000030BC
+#define DDRSS_PI_262_DATA 0x0001E758
+#define DDRSS_PI_263_DATA 0x000030BC
+#define DDRSS_PI_264_DATA 0x0001E758
+#define DDRSS_PI_265_DATA 0x01CC000F
+#define DDRSS_PI_266_DATA 0x030301CC
+#define DDRSS_PI_267_DATA 0x00000003
+#define DDRSS_PI_268_DATA 0x00000000
+#define DDRSS_PI_269_DATA 0x08030503
+#define DDRSS_PI_270_DATA 0x00000803
+#define DDRSS_PI_271_DATA 0x00002710
+#define DDRSS_PI_272_DATA 0x000186A0
+#define DDRSS_PI_273_DATA 0x00000005
+#define DDRSS_PI_274_DATA 0x00000064
+#define DDRSS_PI_275_DATA 0x0000000F
+#define DDRSS_PI_276_DATA 0x0004E200
+#define DDRSS_PI_277_DATA 0x000186A0
+#define DDRSS_PI_278_DATA 0x00000005
+#define DDRSS_PI_279_DATA 0x00000C80
+#define DDRSS_PI_280_DATA 0x000001CC
+#define DDRSS_PI_281_DATA 0x0004E200
+#define DDRSS_PI_282_DATA 0x000186A0
+#define DDRSS_PI_283_DATA 0x00000005
+#define DDRSS_PI_284_DATA 0x00000C80
+#define DDRSS_PI_285_DATA 0x010001CC
+#define DDRSS_PI_286_DATA 0x00320040
+#define DDRSS_PI_287_DATA 0x00010008
+#define DDRSS_PI_288_DATA 0x06400040
+#define DDRSS_PI_289_DATA 0x00010030
+#define DDRSS_PI_290_DATA 0x06400040
+#define DDRSS_PI_291_DATA 0x00000330
+#define DDRSS_PI_292_DATA 0x00280050
+#define DDRSS_PI_293_DATA 0x03040404
+#define DDRSS_PI_294_DATA 0x00000303
+#define DDRSS_PI_295_DATA 0x01010000
+#define DDRSS_PI_296_DATA 0x04040202
+#define DDRSS_PI_297_DATA 0x67670808
+#define DDRSS_PI_298_DATA 0x67676767
+#define DDRSS_PI_299_DATA 0x67676767
+#define DDRSS_PI_300_DATA 0x67676767
+#define DDRSS_PI_301_DATA 0x00006767
+#define DDRSS_PI_302_DATA 0x00000000
+#define DDRSS_PI_303_DATA 0x00000000
+#define DDRSS_PI_304_DATA 0x00000000
+#define DDRSS_PI_305_DATA 0x00000000
+#define DDRSS_PI_306_DATA 0x55000000
+#define DDRSS_PI_307_DATA 0x00000000
+#define DDRSS_PI_308_DATA 0x3C00005A
+#define DDRSS_PI_309_DATA 0x00005500
+#define DDRSS_PI_310_DATA 0x00005A00
+#define DDRSS_PI_311_DATA 0x0055003C
+#define DDRSS_PI_312_DATA 0x00000000
+#define DDRSS_PI_313_DATA 0x3C00005A
+#define DDRSS_PI_314_DATA 0x00005500
+#define DDRSS_PI_315_DATA 0x00005A00
+#define DDRSS_PI_316_DATA 0x1716153C
+#define DDRSS_PI_317_DATA 0x13121118
+#define DDRSS_PI_318_DATA 0x06050414
+#define DDRSS_PI_319_DATA 0x02010007
+#define DDRSS_PI_320_DATA 0x00000003
+#define DDRSS_PI_321_DATA 0x00000000
+#define DDRSS_PI_322_DATA 0x00000000
+#define DDRSS_PI_323_DATA 0x01000000
+#define DDRSS_PI_324_DATA 0x04020201
+#define DDRSS_PI_325_DATA 0x00080804
+#define DDRSS_PI_326_DATA 0x00000000
+#define DDRSS_PI_327_DATA 0x00000000
+#define DDRSS_PI_328_DATA 0x00000000
+#define DDRSS_PI_329_DATA 0x00000004
+#define DDRSS_PI_330_DATA 0x00000000
+#define DDRSS_PI_331_DATA 0x00000029
+#define DDRSS_PI_332_DATA 0x00000000
+#define DDRSS_PI_333_DATA 0x00000000
+#define DDRSS_PI_334_DATA 0x00000000
+#define DDRSS_PI_335_DATA 0x20002B27
+#define DDRSS_PI_336_DATA 0x00000000
+#define DDRSS_PI_337_DATA 0x00000054
+#define DDRSS_PI_338_DATA 0x0000002D
+#define DDRSS_PI_339_DATA 0x000000A9
+#define DDRSS_PI_340_DATA 0x00000000
+#define DDRSS_PI_341_DATA 0x00000000
+#define DDRSS_PI_342_DATA 0x35000000
+#define DDRSS_PI_343_DATA 0x20152B27
+#define DDRSS_PI_344_DATA 0x00000000
+#define DDRSS_PI_345_DATA 0x00000054
+#define DDRSS_PI_346_DATA 0x0000002D
+#define DDRSS_PI_347_DATA 0x000000A9
+#define DDRSS_PI_348_DATA 0x00000000
+#define DDRSS_PI_349_DATA 0x00000000
+#define DDRSS_PI_350_DATA 0x35000000
+#define DDRSS_PI_351_DATA 0x20152B27
+#define DDRSS_PI_352_DATA 0x00000000
+#define DDRSS_PI_353_DATA 0x00000004
+#define DDRSS_PI_354_DATA 0x00000000
+#define DDRSS_PI_355_DATA 0x00000029
+#define DDRSS_PI_356_DATA 0x00000000
+#define DDRSS_PI_357_DATA 0x00000000
+#define DDRSS_PI_358_DATA 0x00000000
+#define DDRSS_PI_359_DATA 0x20002B27
+#define DDRSS_PI_360_DATA 0x00000000
+#define DDRSS_PI_361_DATA 0x00000054
+#define DDRSS_PI_362_DATA 0x0000002D
+#define DDRSS_PI_363_DATA 0x000000A9
+#define DDRSS_PI_364_DATA 0x00000000
+#define DDRSS_PI_365_DATA 0x00000000
+#define DDRSS_PI_366_DATA 0x35000000
+#define DDRSS_PI_367_DATA 0x20152B27
+#define DDRSS_PI_368_DATA 0x00000000
+#define DDRSS_PI_369_DATA 0x00000054
+#define DDRSS_PI_370_DATA 0x0000002D
+#define DDRSS_PI_371_DATA 0x000000A9
+#define DDRSS_PI_372_DATA 0x00000000
+#define DDRSS_PI_373_DATA 0x00000000
+#define DDRSS_PI_374_DATA 0x35000000
+#define DDRSS_PI_375_DATA 0x20152B27
+#define DDRSS_PI_376_DATA 0x00000000
+#define DDRSS_PI_377_DATA 0x00000004
+#define DDRSS_PI_378_DATA 0x00000000
+#define DDRSS_PI_379_DATA 0x00000029
+#define DDRSS_PI_380_DATA 0x00000000
+#define DDRSS_PI_381_DATA 0x00000000
+#define DDRSS_PI_382_DATA 0x00000000
+#define DDRSS_PI_383_DATA 0x20002B27
+#define DDRSS_PI_384_DATA 0x00000000
+#define DDRSS_PI_385_DATA 0x00000054
+#define DDRSS_PI_386_DATA 0x0000002D
+#define DDRSS_PI_387_DATA 0x000000A9
+#define DDRSS_PI_388_DATA 0x00000000
+#define DDRSS_PI_389_DATA 0x00000000
+#define DDRSS_PI_390_DATA 0x35000000
+#define DDRSS_PI_391_DATA 0x20152B27
+#define DDRSS_PI_392_DATA 0x00000000
+#define DDRSS_PI_393_DATA 0x00000054
+#define DDRSS_PI_394_DATA 0x0000002D
+#define DDRSS_PI_395_DATA 0x000000A9
+#define DDRSS_PI_396_DATA 0x00000000
+#define DDRSS_PI_397_DATA 0x00000000
+#define DDRSS_PI_398_DATA 0x35000000
+#define DDRSS_PI_399_DATA 0x20152B27
+#define DDRSS_PI_400_DATA 0x00000000
+#define DDRSS_PI_401_DATA 0x00000004
+#define DDRSS_PI_402_DATA 0x00000000
+#define DDRSS_PI_403_DATA 0x00000029
+#define DDRSS_PI_404_DATA 0x00000000
+#define DDRSS_PI_405_DATA 0x00000000
+#define DDRSS_PI_406_DATA 0x00000000
+#define DDRSS_PI_407_DATA 0x20002B27
+#define DDRSS_PI_408_DATA 0x00000000
+#define DDRSS_PI_409_DATA 0x00000054
+#define DDRSS_PI_410_DATA 0x0000002D
+#define DDRSS_PI_411_DATA 0x000000A9
+#define DDRSS_PI_412_DATA 0x00000000
+#define DDRSS_PI_413_DATA 0x00000000
+#define DDRSS_PI_414_DATA 0x35000000
+#define DDRSS_PI_415_DATA 0x20152B27
+#define DDRSS_PI_416_DATA 0x00000000
+#define DDRSS_PI_417_DATA 0x00000054
+#define DDRSS_PI_418_DATA 0x0000002D
+#define DDRSS_PI_419_DATA 0x000000A9
+#define DDRSS_PI_420_DATA 0x00000000
+#define DDRSS_PI_421_DATA 0x00000000
+#define DDRSS_PI_422_DATA 0x35000000
+#define DDRSS_PI_423_DATA 0x20152B27
+#define DDRSS_PHY_0_DATA 0x04F00000
+#define DDRSS_PHY_1_DATA 0x00000000
+#define DDRSS_PHY_2_DATA 0x00030200
+#define DDRSS_PHY_3_DATA 0x00000000
+#define DDRSS_PHY_4_DATA 0x00000000
+#define DDRSS_PHY_5_DATA 0x01030000
+#define DDRSS_PHY_6_DATA 0x00010000
+#define DDRSS_PHY_7_DATA 0x01030004
+#define DDRSS_PHY_8_DATA 0x01000000
+#define DDRSS_PHY_9_DATA 0x00000000
+#define DDRSS_PHY_10_DATA 0x00000000
+#define DDRSS_PHY_11_DATA 0x00000000
+#define DDRSS_PHY_12_DATA 0x01010000
+#define DDRSS_PHY_13_DATA 0x00010000
+#define DDRSS_PHY_14_DATA 0x00C00001
+#define DDRSS_PHY_15_DATA 0x00CC0008
+#define DDRSS_PHY_16_DATA 0x00660601
+#define DDRSS_PHY_17_DATA 0x00000003
+#define DDRSS_PHY_18_DATA 0x00000000
+#define DDRSS_PHY_19_DATA 0x00000001
+#define DDRSS_PHY_20_DATA 0x0000AAAA
+#define DDRSS_PHY_21_DATA 0x00005555
+#define DDRSS_PHY_22_DATA 0x0000B5B5
+#define DDRSS_PHY_23_DATA 0x00004A4A
+#define DDRSS_PHY_24_DATA 0x00005656
+#define DDRSS_PHY_25_DATA 0x0000A9A9
+#define DDRSS_PHY_26_DATA 0x0000B7B7
+#define DDRSS_PHY_27_DATA 0x00004848
+#define DDRSS_PHY_28_DATA 0x00000000
+#define DDRSS_PHY_29_DATA 0x00000000
+#define DDRSS_PHY_30_DATA 0x08000000
+#define DDRSS_PHY_31_DATA 0x0F000008
+#define DDRSS_PHY_32_DATA 0x00000F0F
+#define DDRSS_PHY_33_DATA 0x00E4E400
+#define DDRSS_PHY_34_DATA 0x00071020
+#define DDRSS_PHY_35_DATA 0x000C0020
+#define DDRSS_PHY_36_DATA 0x00062000
+#define DDRSS_PHY_37_DATA 0x00000000
+#define DDRSS_PHY_38_DATA 0x55555555
+#define DDRSS_PHY_39_DATA 0xAAAAAAAA
+#define DDRSS_PHY_40_DATA 0x55555555
+#define DDRSS_PHY_41_DATA 0xAAAAAAAA
+#define DDRSS_PHY_42_DATA 0x00005555
+#define DDRSS_PHY_43_DATA 0x01000100
+#define DDRSS_PHY_44_DATA 0x00800180
+#define DDRSS_PHY_45_DATA 0x00000001
+#define DDRSS_PHY_46_DATA 0x00000000
+#define DDRSS_PHY_47_DATA 0x00000000
+#define DDRSS_PHY_48_DATA 0x00000000
+#define DDRSS_PHY_49_DATA 0x00000000
+#define DDRSS_PHY_50_DATA 0x00000000
+#define DDRSS_PHY_51_DATA 0x00000000
+#define DDRSS_PHY_52_DATA 0x00000000
+#define DDRSS_PHY_53_DATA 0x00000000
+#define DDRSS_PHY_54_DATA 0x00000000
+#define DDRSS_PHY_55_DATA 0x00000000
+#define DDRSS_PHY_56_DATA 0x00000000
+#define DDRSS_PHY_57_DATA 0x00000000
+#define DDRSS_PHY_58_DATA 0x00000000
+#define DDRSS_PHY_59_DATA 0x00000000
+#define DDRSS_PHY_60_DATA 0x00000000
+#define DDRSS_PHY_61_DATA 0x00000000
+#define DDRSS_PHY_62_DATA 0x00000000
+#define DDRSS_PHY_63_DATA 0x00000000
+#define DDRSS_PHY_64_DATA 0x00000000
+#define DDRSS_PHY_65_DATA 0x00000000
+#define DDRSS_PHY_66_DATA 0x00000000
+#define DDRSS_PHY_67_DATA 0x00000104
+#define DDRSS_PHY_68_DATA 0x00000000
+#define DDRSS_PHY_69_DATA 0x00000000
+#define DDRSS_PHY_70_DATA 0x00000000
+#define DDRSS_PHY_71_DATA 0x00000000
+#define DDRSS_PHY_72_DATA 0x00000000
+#define DDRSS_PHY_73_DATA 0x00000000
+#define DDRSS_PHY_74_DATA 0x081F07FF
+#define DDRSS_PHY_75_DATA 0x10200080
+#define DDRSS_PHY_76_DATA 0x00000008
+#define DDRSS_PHY_77_DATA 0x00000401
+#define DDRSS_PHY_78_DATA 0x00000000
+#define DDRSS_PHY_79_DATA 0x01CC0B01
+#define DDRSS_PHY_80_DATA 0x1003CC0B
+#define DDRSS_PHY_81_DATA 0x20000140
+#define DDRSS_PHY_82_DATA 0x07FF0200
+#define DDRSS_PHY_83_DATA 0x0000DD01
+#define DDRSS_PHY_84_DATA 0x00100303
+#define DDRSS_PHY_85_DATA 0x00000000
+#define DDRSS_PHY_86_DATA 0x00000000
+#define DDRSS_PHY_87_DATA 0x00031000
+#define DDRSS_PHY_88_DATA 0x00100010
+#define DDRSS_PHY_89_DATA 0x00100010
+#define DDRSS_PHY_90_DATA 0x00100010
+#define DDRSS_PHY_91_DATA 0x00100010
+#define DDRSS_PHY_92_DATA 0x02000010
+#define DDRSS_PHY_93_DATA 0x00000004
+#define DDRSS_PHY_94_DATA 0x51516042
+#define DDRSS_PHY_95_DATA 0x31C06000
+#define DDRSS_PHY_96_DATA 0x07AB0340
+#define DDRSS_PHY_97_DATA 0x00C0C001
+#define DDRSS_PHY_98_DATA 0x0B000000
+#define DDRSS_PHY_99_DATA 0x000B0A0A
+#define DDRSS_PHY_100_DATA 0x42100010
+#define DDRSS_PHY_101_DATA 0x010C073E
+#define DDRSS_PHY_102_DATA 0x000F0C2D
+#define DDRSS_PHY_103_DATA 0x01000140
+#define DDRSS_PHY_104_DATA 0x00F50120
+#define DDRSS_PHY_105_DATA 0x00000C00
+#define DDRSS_PHY_106_DATA 0x00000299
+#define DDRSS_PHY_107_DATA 0x00030200
+#define DDRSS_PHY_108_DATA 0x02800000
+#define DDRSS_PHY_109_DATA 0x80800000
+#define DDRSS_PHY_110_DATA 0x000B2010
+#define DDRSS_PHY_111_DATA 0x43180276
+#define DDRSS_PHY_112_DATA 0x00000005
+#define DDRSS_PHY_113_DATA 0x04190419
+#define DDRSS_PHY_114_DATA 0x04190419
+#define DDRSS_PHY_115_DATA 0x04190419
+#define DDRSS_PHY_116_DATA 0x04190419
+#define DDRSS_PHY_117_DATA 0x00000419
+#define DDRSS_PHY_118_DATA 0x0000A000
+#define DDRSS_PHY_119_DATA 0x00A000A0
+#define DDRSS_PHY_120_DATA 0x00A000A0
+#define DDRSS_PHY_121_DATA 0x00A000A0
+#define DDRSS_PHY_122_DATA 0x00A000A0
+#define DDRSS_PHY_123_DATA 0x00A000A0
+#define DDRSS_PHY_124_DATA 0x00A000A0
+#define DDRSS_PHY_125_DATA 0x00A000A0
+#define DDRSS_PHY_126_DATA 0x00A000A0
+#define DDRSS_PHY_127_DATA 0x01E600A0
+#define DDRSS_PHY_128_DATA 0x01000000
+#define DDRSS_PHY_129_DATA 0x00000000
+#define DDRSS_PHY_130_DATA 0x00000000
+#define DDRSS_PHY_131_DATA 0x00080200
+#define DDRSS_PHY_132_DATA 0x00000000
+#define DDRSS_PHY_133_DATA 0x20202020
+#define DDRSS_PHY_134_DATA 0x20202020
+#define DDRSS_PHY_135_DATA 0xF0F02020
+#define DDRSS_PHY_136_DATA 0x00000000
+#define DDRSS_PHY_137_DATA 0x00000000
+#define DDRSS_PHY_138_DATA 0x00000000
+#define DDRSS_PHY_139_DATA 0x00000000
+#define DDRSS_PHY_140_DATA 0x00000000
+#define DDRSS_PHY_141_DATA 0x00000000
+#define DDRSS_PHY_142_DATA 0x00000000
+#define DDRSS_PHY_143_DATA 0x00000000
+#define DDRSS_PHY_144_DATA 0x00000000
+#define DDRSS_PHY_145_DATA 0x00000000
+#define DDRSS_PHY_146_DATA 0x00000000
+#define DDRSS_PHY_147_DATA 0x00000000
+#define DDRSS_PHY_148_DATA 0x00000000
+#define DDRSS_PHY_149_DATA 0x00000000
+#define DDRSS_PHY_150_DATA 0x00000000
+#define DDRSS_PHY_151_DATA 0x00000000
+#define DDRSS_PHY_152_DATA 0x00000000
+#define DDRSS_PHY_153_DATA 0x00000000
+#define DDRSS_PHY_154_DATA 0x00000000
+#define DDRSS_PHY_155_DATA 0x00000000
+#define DDRSS_PHY_156_DATA 0x00000000
+#define DDRSS_PHY_157_DATA 0x00000000
+#define DDRSS_PHY_158_DATA 0x00000000
+#define DDRSS_PHY_159_DATA 0x00000000
+#define DDRSS_PHY_160_DATA 0x00000000
+#define DDRSS_PHY_161_DATA 0x00000000
+#define DDRSS_PHY_162_DATA 0x00000000
+#define DDRSS_PHY_163_DATA 0x00000000
+#define DDRSS_PHY_164_DATA 0x00000000
+#define DDRSS_PHY_165_DATA 0x00000000
+#define DDRSS_PHY_166_DATA 0x00000000
+#define DDRSS_PHY_167_DATA 0x00000000
+#define DDRSS_PHY_168_DATA 0x00000000
+#define DDRSS_PHY_169_DATA 0x00000000
+#define DDRSS_PHY_170_DATA 0x00000000
+#define DDRSS_PHY_171_DATA 0x00000000
+#define DDRSS_PHY_172_DATA 0x00000000
+#define DDRSS_PHY_173_DATA 0x00000000
+#define DDRSS_PHY_174_DATA 0x00000000
+#define DDRSS_PHY_175_DATA 0x00000000
+#define DDRSS_PHY_176_DATA 0x00000000
+#define DDRSS_PHY_177_DATA 0x00000000
+#define DDRSS_PHY_178_DATA 0x00000000
+#define DDRSS_PHY_179_DATA 0x00000000
+#define DDRSS_PHY_180_DATA 0x00000000
+#define DDRSS_PHY_181_DATA 0x00000000
+#define DDRSS_PHY_182_DATA 0x00000000
+#define DDRSS_PHY_183_DATA 0x00000000
+#define DDRSS_PHY_184_DATA 0x00000000
+#define DDRSS_PHY_185_DATA 0x00000000
+#define DDRSS_PHY_186_DATA 0x00000000
+#define DDRSS_PHY_187_DATA 0x00000000
+#define DDRSS_PHY_188_DATA 0x00000000
+#define DDRSS_PHY_189_DATA 0x00000000
+#define DDRSS_PHY_190_DATA 0x00000000
+#define DDRSS_PHY_191_DATA 0x00000000
+#define DDRSS_PHY_192_DATA 0x00000000
+#define DDRSS_PHY_193_DATA 0x00000000
+#define DDRSS_PHY_194_DATA 0x00000000
+#define DDRSS_PHY_195_DATA 0x00000000
+#define DDRSS_PHY_196_DATA 0x00000000
+#define DDRSS_PHY_197_DATA 0x00000000
+#define DDRSS_PHY_198_DATA 0x00000000
+#define DDRSS_PHY_199_DATA 0x00000000
+#define DDRSS_PHY_200_DATA 0x00000000
+#define DDRSS_PHY_201_DATA 0x00000000
+#define DDRSS_PHY_202_DATA 0x00000000
+#define DDRSS_PHY_203_DATA 0x00000000
+#define DDRSS_PHY_204_DATA 0x00000000
+#define DDRSS_PHY_205_DATA 0x00000000
+#define DDRSS_PHY_206_DATA 0x00000000
+#define DDRSS_PHY_207_DATA 0x00000000
+#define DDRSS_PHY_208_DATA 0x00000000
+#define DDRSS_PHY_209_DATA 0x00000000
+#define DDRSS_PHY_210_DATA 0x00000000
+#define DDRSS_PHY_211_DATA 0x00000000
+#define DDRSS_PHY_212_DATA 0x00000000
+#define DDRSS_PHY_213_DATA 0x00000000
+#define DDRSS_PHY_214_DATA 0x00000000
+#define DDRSS_PHY_215_DATA 0x00000000
+#define DDRSS_PHY_216_DATA 0x00000000
+#define DDRSS_PHY_217_DATA 0x00000000
+#define DDRSS_PHY_218_DATA 0x00000000
+#define DDRSS_PHY_219_DATA 0x00000000
+#define DDRSS_PHY_220_DATA 0x00000000
+#define DDRSS_PHY_221_DATA 0x00000000
+#define DDRSS_PHY_222_DATA 0x00000000
+#define DDRSS_PHY_223_DATA 0x00000000
+#define DDRSS_PHY_224_DATA 0x00000000
+#define DDRSS_PHY_225_DATA 0x00000000
+#define DDRSS_PHY_226_DATA 0x00000000
+#define DDRSS_PHY_227_DATA 0x00000000
+#define DDRSS_PHY_228_DATA 0x00000000
+#define DDRSS_PHY_229_DATA 0x00000000
+#define DDRSS_PHY_230_DATA 0x00000000
+#define DDRSS_PHY_231_DATA 0x00000000
+#define DDRSS_PHY_232_DATA 0x00000000
+#define DDRSS_PHY_233_DATA 0x00000000
+#define DDRSS_PHY_234_DATA 0x00000000
+#define DDRSS_PHY_235_DATA 0x00000000
+#define DDRSS_PHY_236_DATA 0x00000000
+#define DDRSS_PHY_237_DATA 0x00000000
+#define DDRSS_PHY_238_DATA 0x00000000
+#define DDRSS_PHY_239_DATA 0x00000000
+#define DDRSS_PHY_240_DATA 0x00000000
+#define DDRSS_PHY_241_DATA 0x00000000
+#define DDRSS_PHY_242_DATA 0x00000000
+#define DDRSS_PHY_243_DATA 0x00000000
+#define DDRSS_PHY_244_DATA 0x00000000
+#define DDRSS_PHY_245_DATA 0x00000000
+#define DDRSS_PHY_246_DATA 0x00000000
+#define DDRSS_PHY_247_DATA 0x00000000
+#define DDRSS_PHY_248_DATA 0x00000000
+#define DDRSS_PHY_249_DATA 0x00000000
+#define DDRSS_PHY_250_DATA 0x00000000
+#define DDRSS_PHY_251_DATA 0x00000000
+#define DDRSS_PHY_252_DATA 0x00000000
+#define DDRSS_PHY_253_DATA 0x00000000
+#define DDRSS_PHY_254_DATA 0x00000000
+#define DDRSS_PHY_255_DATA 0x00000000
+#define DDRSS_PHY_256_DATA 0x04F00000
+#define DDRSS_PHY_257_DATA 0x00000000
+#define DDRSS_PHY_258_DATA 0x00030200
+#define DDRSS_PHY_259_DATA 0x00000000
+#define DDRSS_PHY_260_DATA 0x00000000
+#define DDRSS_PHY_261_DATA 0x01030000
+#define DDRSS_PHY_262_DATA 0x00010000
+#define DDRSS_PHY_263_DATA 0x01030004
+#define DDRSS_PHY_264_DATA 0x01000000
+#define DDRSS_PHY_265_DATA 0x00000000
+#define DDRSS_PHY_266_DATA 0x00000000
+#define DDRSS_PHY_267_DATA 0x00000000
+#define DDRSS_PHY_268_DATA 0x01010000
+#define DDRSS_PHY_269_DATA 0x00010000
+#define DDRSS_PHY_270_DATA 0x00C00001
+#define DDRSS_PHY_271_DATA 0x00CC0008
+#define DDRSS_PHY_272_DATA 0x00660601
+#define DDRSS_PHY_273_DATA 0x00000003
+#define DDRSS_PHY_274_DATA 0x00000000
+#define DDRSS_PHY_275_DATA 0x00000001
+#define DDRSS_PHY_276_DATA 0x0000AAAA
+#define DDRSS_PHY_277_DATA 0x00005555
+#define DDRSS_PHY_278_DATA 0x0000B5B5
+#define DDRSS_PHY_279_DATA 0x00004A4A
+#define DDRSS_PHY_280_DATA 0x00005656
+#define DDRSS_PHY_281_DATA 0x0000A9A9
+#define DDRSS_PHY_282_DATA 0x0000B7B7
+#define DDRSS_PHY_283_DATA 0x00004848
+#define DDRSS_PHY_284_DATA 0x00000000
+#define DDRSS_PHY_285_DATA 0x00000000
+#define DDRSS_PHY_286_DATA 0x08000000
+#define DDRSS_PHY_287_DATA 0x0F000008
+#define DDRSS_PHY_288_DATA 0x00000F0F
+#define DDRSS_PHY_289_DATA 0x00E4E400
+#define DDRSS_PHY_290_DATA 0x00071020
+#define DDRSS_PHY_291_DATA 0x000C0020
+#define DDRSS_PHY_292_DATA 0x00062000
+#define DDRSS_PHY_293_DATA 0x00000000
+#define DDRSS_PHY_294_DATA 0x55555555
+#define DDRSS_PHY_295_DATA 0xAAAAAAAA
+#define DDRSS_PHY_296_DATA 0x55555555
+#define DDRSS_PHY_297_DATA 0xAAAAAAAA
+#define DDRSS_PHY_298_DATA 0x00005555
+#define DDRSS_PHY_299_DATA 0x01000100
+#define DDRSS_PHY_300_DATA 0x00800180
+#define DDRSS_PHY_301_DATA 0x00000000
+#define DDRSS_PHY_302_DATA 0x00000000
+#define DDRSS_PHY_303_DATA 0x00000000
+#define DDRSS_PHY_304_DATA 0x00000000
+#define DDRSS_PHY_305_DATA 0x00000000
+#define DDRSS_PHY_306_DATA 0x00000000
+#define DDRSS_PHY_307_DATA 0x00000000
+#define DDRSS_PHY_308_DATA 0x00000000
+#define DDRSS_PHY_309_DATA 0x00000000
+#define DDRSS_PHY_310_DATA 0x00000000
+#define DDRSS_PHY_311_DATA 0x00000000
+#define DDRSS_PHY_312_DATA 0x00000000
+#define DDRSS_PHY_313_DATA 0x00000000
+#define DDRSS_PHY_314_DATA 0x00000000
+#define DDRSS_PHY_315_DATA 0x00000000
+#define DDRSS_PHY_316_DATA 0x00000000
+#define DDRSS_PHY_317_DATA 0x00000000
+#define DDRSS_PHY_318_DATA 0x00000000
+#define DDRSS_PHY_319_DATA 0x00000000
+#define DDRSS_PHY_320_DATA 0x00000000
+#define DDRSS_PHY_321_DATA 0x00000000
+#define DDRSS_PHY_322_DATA 0x00000000
+#define DDRSS_PHY_323_DATA 0x00000104
+#define DDRSS_PHY_324_DATA 0x00000000
+#define DDRSS_PHY_325_DATA 0x00000000
+#define DDRSS_PHY_326_DATA 0x00000000
+#define DDRSS_PHY_327_DATA 0x00000000
+#define DDRSS_PHY_328_DATA 0x00000000
+#define DDRSS_PHY_329_DATA 0x00000000
+#define DDRSS_PHY_330_DATA 0x081F07FF
+#define DDRSS_PHY_331_DATA 0x10200080
+#define DDRSS_PHY_332_DATA 0x00000008
+#define DDRSS_PHY_333_DATA 0x00000401
+#define DDRSS_PHY_334_DATA 0x00000000
+#define DDRSS_PHY_335_DATA 0x01CC0B01
+#define DDRSS_PHY_336_DATA 0x1003CC0B
+#define DDRSS_PHY_337_DATA 0x20000140
+#define DDRSS_PHY_338_DATA 0x07FF0200
+#define DDRSS_PHY_339_DATA 0x0000DD01
+#define DDRSS_PHY_340_DATA 0x00100303
+#define DDRSS_PHY_341_DATA 0x00000000
+#define DDRSS_PHY_342_DATA 0x00000000
+#define DDRSS_PHY_343_DATA 0x00031000
+#define DDRSS_PHY_344_DATA 0x00100010
+#define DDRSS_PHY_345_DATA 0x00100010
+#define DDRSS_PHY_346_DATA 0x00100010
+#define DDRSS_PHY_347_DATA 0x00100010
+#define DDRSS_PHY_348_DATA 0x02000010
+#define DDRSS_PHY_349_DATA 0x00000004
+#define DDRSS_PHY_350_DATA 0x51516042
+#define DDRSS_PHY_351_DATA 0x31C06000
+#define DDRSS_PHY_352_DATA 0x07AB0340
+#define DDRSS_PHY_353_DATA 0x00C0C001
+#define DDRSS_PHY_354_DATA 0x0B000000
+#define DDRSS_PHY_355_DATA 0x000B0A0A
+#define DDRSS_PHY_356_DATA 0x42100010
+#define DDRSS_PHY_357_DATA 0x010C073E
+#define DDRSS_PHY_358_DATA 0x000F0C2D
+#define DDRSS_PHY_359_DATA 0x01000140
+#define DDRSS_PHY_360_DATA 0x00F50120
+#define DDRSS_PHY_361_DATA 0x00000C00
+#define DDRSS_PHY_362_DATA 0x00000299
+#define DDRSS_PHY_363_DATA 0x00030200
+#define DDRSS_PHY_364_DATA 0x02800000
+#define DDRSS_PHY_365_DATA 0x80800000
+#define DDRSS_PHY_366_DATA 0x000B2010
+#define DDRSS_PHY_367_DATA 0x65328017
+#define DDRSS_PHY_368_DATA 0x00000004
+#define DDRSS_PHY_369_DATA 0x04190419
+#define DDRSS_PHY_370_DATA 0x04190419
+#define DDRSS_PHY_371_DATA 0x04190419
+#define DDRSS_PHY_372_DATA 0x04190419
+#define DDRSS_PHY_373_DATA 0x00000419
+#define DDRSS_PHY_374_DATA 0x0000A000
+#define DDRSS_PHY_375_DATA 0x00A000A0
+#define DDRSS_PHY_376_DATA 0x00A000A0
+#define DDRSS_PHY_377_DATA 0x00A000A0
+#define DDRSS_PHY_378_DATA 0x00A000A0
+#define DDRSS_PHY_379_DATA 0x00A000A0
+#define DDRSS_PHY_380_DATA 0x00A000A0
+#define DDRSS_PHY_381_DATA 0x00A000A0
+#define DDRSS_PHY_382_DATA 0x00A000A0
+#define DDRSS_PHY_383_DATA 0x01E600A0
+#define DDRSS_PHY_384_DATA 0x01000000
+#define DDRSS_PHY_385_DATA 0x00000000
+#define DDRSS_PHY_386_DATA 0x00000000
+#define DDRSS_PHY_387_DATA 0x00080200
+#define DDRSS_PHY_388_DATA 0x00000000
+#define DDRSS_PHY_389_DATA 0x20202020
+#define DDRSS_PHY_390_DATA 0x20202020
+#define DDRSS_PHY_391_DATA 0xF0F02020
+#define DDRSS_PHY_392_DATA 0x00000000
+#define DDRSS_PHY_393_DATA 0x00000000
+#define DDRSS_PHY_394_DATA 0x00000000
+#define DDRSS_PHY_395_DATA 0x00000000
+#define DDRSS_PHY_396_DATA 0x00000000
+#define DDRSS_PHY_397_DATA 0x00000000
+#define DDRSS_PHY_398_DATA 0x00000000
+#define DDRSS_PHY_399_DATA 0x00000000
+#define DDRSS_PHY_400_DATA 0x00000000
+#define DDRSS_PHY_401_DATA 0x00000000
+#define DDRSS_PHY_402_DATA 0x00000000
+#define DDRSS_PHY_403_DATA 0x00000000
+#define DDRSS_PHY_404_DATA 0x00000000
+#define DDRSS_PHY_405_DATA 0x00000000
+#define DDRSS_PHY_406_DATA 0x00000000
+#define DDRSS_PHY_407_DATA 0x00000000
+#define DDRSS_PHY_408_DATA 0x00000000
+#define DDRSS_PHY_409_DATA 0x00000000
+#define DDRSS_PHY_410_DATA 0x00000000
+#define DDRSS_PHY_411_DATA 0x00000000
+#define DDRSS_PHY_412_DATA 0x00000000
+#define DDRSS_PHY_413_DATA 0x00000000
+#define DDRSS_PHY_414_DATA 0x00000000
+#define DDRSS_PHY_415_DATA 0x00000000
+#define DDRSS_PHY_416_DATA 0x00000000
+#define DDRSS_PHY_417_DATA 0x00000000
+#define DDRSS_PHY_418_DATA 0x00000000
+#define DDRSS_PHY_419_DATA 0x00000000
+#define DDRSS_PHY_420_DATA 0x00000000
+#define DDRSS_PHY_421_DATA 0x00000000
+#define DDRSS_PHY_422_DATA 0x00000000
+#define DDRSS_PHY_423_DATA 0x00000000
+#define DDRSS_PHY_424_DATA 0x00000000
+#define DDRSS_PHY_425_DATA 0x00000000
+#define DDRSS_PHY_426_DATA 0x00000000
+#define DDRSS_PHY_427_DATA 0x00000000
+#define DDRSS_PHY_428_DATA 0x00000000
+#define DDRSS_PHY_429_DATA 0x00000000
+#define DDRSS_PHY_430_DATA 0x00000000
+#define DDRSS_PHY_431_DATA 0x00000000
+#define DDRSS_PHY_432_DATA 0x00000000
+#define DDRSS_PHY_433_DATA 0x00000000
+#define DDRSS_PHY_434_DATA 0x00000000
+#define DDRSS_PHY_435_DATA 0x00000000
+#define DDRSS_PHY_436_DATA 0x00000000
+#define DDRSS_PHY_437_DATA 0x00000000
+#define DDRSS_PHY_438_DATA 0x00000000
+#define DDRSS_PHY_439_DATA 0x00000000
+#define DDRSS_PHY_440_DATA 0x00000000
+#define DDRSS_PHY_441_DATA 0x00000000
+#define DDRSS_PHY_442_DATA 0x00000000
+#define DDRSS_PHY_443_DATA 0x00000000
+#define DDRSS_PHY_444_DATA 0x00000000
+#define DDRSS_PHY_445_DATA 0x00000000
+#define DDRSS_PHY_446_DATA 0x00000000
+#define DDRSS_PHY_447_DATA 0x00000000
+#define DDRSS_PHY_448_DATA 0x00000000
+#define DDRSS_PHY_449_DATA 0x00000000
+#define DDRSS_PHY_450_DATA 0x00000000
+#define DDRSS_PHY_451_DATA 0x00000000
+#define DDRSS_PHY_452_DATA 0x00000000
+#define DDRSS_PHY_453_DATA 0x00000000
+#define DDRSS_PHY_454_DATA 0x00000000
+#define DDRSS_PHY_455_DATA 0x00000000
+#define DDRSS_PHY_456_DATA 0x00000000
+#define DDRSS_PHY_457_DATA 0x00000000
+#define DDRSS_PHY_458_DATA 0x00000000
+#define DDRSS_PHY_459_DATA 0x00000000
+#define DDRSS_PHY_460_DATA 0x00000000
+#define DDRSS_PHY_461_DATA 0x00000000
+#define DDRSS_PHY_462_DATA 0x00000000
+#define DDRSS_PHY_463_DATA 0x00000000
+#define DDRSS_PHY_464_DATA 0x00000000
+#define DDRSS_PHY_465_DATA 0x00000000
+#define DDRSS_PHY_466_DATA 0x00000000
+#define DDRSS_PHY_467_DATA 0x00000000
+#define DDRSS_PHY_468_DATA 0x00000000
+#define DDRSS_PHY_469_DATA 0x00000000
+#define DDRSS_PHY_470_DATA 0x00000000
+#define DDRSS_PHY_471_DATA 0x00000000
+#define DDRSS_PHY_472_DATA 0x00000000
+#define DDRSS_PHY_473_DATA 0x00000000
+#define DDRSS_PHY_474_DATA 0x00000000
+#define DDRSS_PHY_475_DATA 0x00000000
+#define DDRSS_PHY_476_DATA 0x00000000
+#define DDRSS_PHY_477_DATA 0x00000000
+#define DDRSS_PHY_478_DATA 0x00000000
+#define DDRSS_PHY_479_DATA 0x00000000
+#define DDRSS_PHY_480_DATA 0x00000000
+#define DDRSS_PHY_481_DATA 0x00000000
+#define DDRSS_PHY_482_DATA 0x00000000
+#define DDRSS_PHY_483_DATA 0x00000000
+#define DDRSS_PHY_484_DATA 0x00000000
+#define DDRSS_PHY_485_DATA 0x00000000
+#define DDRSS_PHY_486_DATA 0x00000000
+#define DDRSS_PHY_487_DATA 0x00000000
+#define DDRSS_PHY_488_DATA 0x00000000
+#define DDRSS_PHY_489_DATA 0x00000000
+#define DDRSS_PHY_490_DATA 0x00000000
+#define DDRSS_PHY_491_DATA 0x00000000
+#define DDRSS_PHY_492_DATA 0x00000000
+#define DDRSS_PHY_493_DATA 0x00000000
+#define DDRSS_PHY_494_DATA 0x00000000
+#define DDRSS_PHY_495_DATA 0x00000000
+#define DDRSS_PHY_496_DATA 0x00000000
+#define DDRSS_PHY_497_DATA 0x00000000
+#define DDRSS_PHY_498_DATA 0x00000000
+#define DDRSS_PHY_499_DATA 0x00000000
+#define DDRSS_PHY_500_DATA 0x00000000
+#define DDRSS_PHY_501_DATA 0x00000000
+#define DDRSS_PHY_502_DATA 0x00000000
+#define DDRSS_PHY_503_DATA 0x00000000
+#define DDRSS_PHY_504_DATA 0x00000000
+#define DDRSS_PHY_505_DATA 0x00000000
+#define DDRSS_PHY_506_DATA 0x00000000
+#define DDRSS_PHY_507_DATA 0x00000000
+#define DDRSS_PHY_508_DATA 0x00000000
+#define DDRSS_PHY_509_DATA 0x00000000
+#define DDRSS_PHY_510_DATA 0x00000000
+#define DDRSS_PHY_511_DATA 0x00000000
+#define DDRSS_PHY_512_DATA 0x04F00000
+#define DDRSS_PHY_513_DATA 0x00000000
+#define DDRSS_PHY_514_DATA 0x00030200
+#define DDRSS_PHY_515_DATA 0x00000000
+#define DDRSS_PHY_516_DATA 0x00000000
+#define DDRSS_PHY_517_DATA 0x01030000
+#define DDRSS_PHY_518_DATA 0x00010000
+#define DDRSS_PHY_519_DATA 0x01030004
+#define DDRSS_PHY_520_DATA 0x01000000
+#define DDRSS_PHY_521_DATA 0x00000000
+#define DDRSS_PHY_522_DATA 0x00000000
+#define DDRSS_PHY_523_DATA 0x00000000
+#define DDRSS_PHY_524_DATA 0x01010000
+#define DDRSS_PHY_525_DATA 0x00010000
+#define DDRSS_PHY_526_DATA 0x00C00001
+#define DDRSS_PHY_527_DATA 0x00CC0008
+#define DDRSS_PHY_528_DATA 0x00660601
+#define DDRSS_PHY_529_DATA 0x00000003
+#define DDRSS_PHY_530_DATA 0x00000000
+#define DDRSS_PHY_531_DATA 0x00000001
+#define DDRSS_PHY_532_DATA 0x0000AAAA
+#define DDRSS_PHY_533_DATA 0x00005555
+#define DDRSS_PHY_534_DATA 0x0000B5B5
+#define DDRSS_PHY_535_DATA 0x00004A4A
+#define DDRSS_PHY_536_DATA 0x00005656
+#define DDRSS_PHY_537_DATA 0x0000A9A9
+#define DDRSS_PHY_538_DATA 0x0000B7B7
+#define DDRSS_PHY_539_DATA 0x00004848
+#define DDRSS_PHY_540_DATA 0x00000000
+#define DDRSS_PHY_541_DATA 0x00000000
+#define DDRSS_PHY_542_DATA 0x08000000
+#define DDRSS_PHY_543_DATA 0x0F000008
+#define DDRSS_PHY_544_DATA 0x00000F0F
+#define DDRSS_PHY_545_DATA 0x00E4E400
+#define DDRSS_PHY_546_DATA 0x00071020
+#define DDRSS_PHY_547_DATA 0x000C0020
+#define DDRSS_PHY_548_DATA 0x00062000
+#define DDRSS_PHY_549_DATA 0x00000000
+#define DDRSS_PHY_550_DATA 0x55555555
+#define DDRSS_PHY_551_DATA 0xAAAAAAAA
+#define DDRSS_PHY_552_DATA 0x55555555
+#define DDRSS_PHY_553_DATA 0xAAAAAAAA
+#define DDRSS_PHY_554_DATA 0x00005555
+#define DDRSS_PHY_555_DATA 0x01000100
+#define DDRSS_PHY_556_DATA 0x00800180
+#define DDRSS_PHY_557_DATA 0x00000000
+#define DDRSS_PHY_558_DATA 0x00000000
+#define DDRSS_PHY_559_DATA 0x00000000
+#define DDRSS_PHY_560_DATA 0x00000000
+#define DDRSS_PHY_561_DATA 0x00000000
+#define DDRSS_PHY_562_DATA 0x00000000
+#define DDRSS_PHY_563_DATA 0x00000000
+#define DDRSS_PHY_564_DATA 0x00000000
+#define DDRSS_PHY_565_DATA 0x00000000
+#define DDRSS_PHY_566_DATA 0x00000000
+#define DDRSS_PHY_567_DATA 0x00000000
+#define DDRSS_PHY_568_DATA 0x00000000
+#define DDRSS_PHY_569_DATA 0x00000000
+#define DDRSS_PHY_570_DATA 0x00000000
+#define DDRSS_PHY_571_DATA 0x00000000
+#define DDRSS_PHY_572_DATA 0x00000000
+#define DDRSS_PHY_573_DATA 0x00000000
+#define DDRSS_PHY_574_DATA 0x00000000
+#define DDRSS_PHY_575_DATA 0x00000000
+#define DDRSS_PHY_576_DATA 0x00000000
+#define DDRSS_PHY_577_DATA 0x00000000
+#define DDRSS_PHY_578_DATA 0x00000000
+#define DDRSS_PHY_579_DATA 0x00000104
+#define DDRSS_PHY_580_DATA 0x00000000
+#define DDRSS_PHY_581_DATA 0x00000000
+#define DDRSS_PHY_582_DATA 0x00000000
+#define DDRSS_PHY_583_DATA 0x00000000
+#define DDRSS_PHY_584_DATA 0x00000000
+#define DDRSS_PHY_585_DATA 0x00000000
+#define DDRSS_PHY_586_DATA 0x081F07FF
+#define DDRSS_PHY_587_DATA 0x10200080
+#define DDRSS_PHY_588_DATA 0x00000008
+#define DDRSS_PHY_589_DATA 0x00000401
+#define DDRSS_PHY_590_DATA 0x00000000
+#define DDRSS_PHY_591_DATA 0x01CC0B01
+#define DDRSS_PHY_592_DATA 0x1003CC0B
+#define DDRSS_PHY_593_DATA 0x20000140
+#define DDRSS_PHY_594_DATA 0x07FF0200
+#define DDRSS_PHY_595_DATA 0x0000DD01
+#define DDRSS_PHY_596_DATA 0x00100303
+#define DDRSS_PHY_597_DATA 0x00000000
+#define DDRSS_PHY_598_DATA 0x00000000
+#define DDRSS_PHY_599_DATA 0x00031000
+#define DDRSS_PHY_600_DATA 0x00100010
+#define DDRSS_PHY_601_DATA 0x00100010
+#define DDRSS_PHY_602_DATA 0x00100010
+#define DDRSS_PHY_603_DATA 0x00100010
+#define DDRSS_PHY_604_DATA 0x02000010
+#define DDRSS_PHY_605_DATA 0x00000004
+#define DDRSS_PHY_606_DATA 0x51516042
+#define DDRSS_PHY_607_DATA 0x31C06000
+#define DDRSS_PHY_608_DATA 0x07AB0340
+#define DDRSS_PHY_609_DATA 0x00C0C001
+#define DDRSS_PHY_610_DATA 0x0B000000
+#define DDRSS_PHY_611_DATA 0x000B0A0A
+#define DDRSS_PHY_612_DATA 0x42100010
+#define DDRSS_PHY_613_DATA 0x010C073E
+#define DDRSS_PHY_614_DATA 0x000F0C2D
+#define DDRSS_PHY_615_DATA 0x01000140
+#define DDRSS_PHY_616_DATA 0x00F50120
+#define DDRSS_PHY_617_DATA 0x00000C00
+#define DDRSS_PHY_618_DATA 0x00000299
+#define DDRSS_PHY_619_DATA 0x00030200
+#define DDRSS_PHY_620_DATA 0x02800000
+#define DDRSS_PHY_621_DATA 0x80800000
+#define DDRSS_PHY_622_DATA 0x000B2010
+#define DDRSS_PHY_623_DATA 0x78610245
+#define DDRSS_PHY_624_DATA 0x00000003
+#define DDRSS_PHY_625_DATA 0x04190419
+#define DDRSS_PHY_626_DATA 0x04190419
+#define DDRSS_PHY_627_DATA 0x04190419
+#define DDRSS_PHY_628_DATA 0x04190419
+#define DDRSS_PHY_629_DATA 0x00000419
+#define DDRSS_PHY_630_DATA 0x0000A000
+#define DDRSS_PHY_631_DATA 0x00A000A0
+#define DDRSS_PHY_632_DATA 0x00A000A0
+#define DDRSS_PHY_633_DATA 0x00A000A0
+#define DDRSS_PHY_634_DATA 0x00A000A0
+#define DDRSS_PHY_635_DATA 0x00A000A0
+#define DDRSS_PHY_636_DATA 0x00A000A0
+#define DDRSS_PHY_637_DATA 0x00A000A0
+#define DDRSS_PHY_638_DATA 0x00A000A0
+#define DDRSS_PHY_639_DATA 0x01E600A0
+#define DDRSS_PHY_640_DATA 0x01000000
+#define DDRSS_PHY_641_DATA 0x00000000
+#define DDRSS_PHY_642_DATA 0x00000000
+#define DDRSS_PHY_643_DATA 0x00080200
+#define DDRSS_PHY_644_DATA 0x00000000
+#define DDRSS_PHY_645_DATA 0x20202020
+#define DDRSS_PHY_646_DATA 0x20202020
+#define DDRSS_PHY_647_DATA 0xF0F02020
+#define DDRSS_PHY_648_DATA 0x00000000
+#define DDRSS_PHY_649_DATA 0x00000000
+#define DDRSS_PHY_650_DATA 0x00000000
+#define DDRSS_PHY_651_DATA 0x00000000
+#define DDRSS_PHY_652_DATA 0x00000000
+#define DDRSS_PHY_653_DATA 0x00000000
+#define DDRSS_PHY_654_DATA 0x00000000
+#define DDRSS_PHY_655_DATA 0x00000000
+#define DDRSS_PHY_656_DATA 0x00000000
+#define DDRSS_PHY_657_DATA 0x00000000
+#define DDRSS_PHY_658_DATA 0x00000000
+#define DDRSS_PHY_659_DATA 0x00000000
+#define DDRSS_PHY_660_DATA 0x00000000
+#define DDRSS_PHY_661_DATA 0x00000000
+#define DDRSS_PHY_662_DATA 0x00000000
+#define DDRSS_PHY_663_DATA 0x00000000
+#define DDRSS_PHY_664_DATA 0x00000000
+#define DDRSS_PHY_665_DATA 0x00000000
+#define DDRSS_PHY_666_DATA 0x00000000
+#define DDRSS_PHY_667_DATA 0x00000000
+#define DDRSS_PHY_668_DATA 0x00000000
+#define DDRSS_PHY_669_DATA 0x00000000
+#define DDRSS_PHY_670_DATA 0x00000000
+#define DDRSS_PHY_671_DATA 0x00000000
+#define DDRSS_PHY_672_DATA 0x00000000
+#define DDRSS_PHY_673_DATA 0x00000000
+#define DDRSS_PHY_674_DATA 0x00000000
+#define DDRSS_PHY_675_DATA 0x00000000
+#define DDRSS_PHY_676_DATA 0x00000000
+#define DDRSS_PHY_677_DATA 0x00000000
+#define DDRSS_PHY_678_DATA 0x00000000
+#define DDRSS_PHY_679_DATA 0x00000000
+#define DDRSS_PHY_680_DATA 0x00000000
+#define DDRSS_PHY_681_DATA 0x00000000
+#define DDRSS_PHY_682_DATA 0x00000000
+#define DDRSS_PHY_683_DATA 0x00000000
+#define DDRSS_PHY_684_DATA 0x00000000
+#define DDRSS_PHY_685_DATA 0x00000000
+#define DDRSS_PHY_686_DATA 0x00000000
+#define DDRSS_PHY_687_DATA 0x00000000
+#define DDRSS_PHY_688_DATA 0x00000000
+#define DDRSS_PHY_689_DATA 0x00000000
+#define DDRSS_PHY_690_DATA 0x00000000
+#define DDRSS_PHY_691_DATA 0x00000000
+#define DDRSS_PHY_692_DATA 0x00000000
+#define DDRSS_PHY_693_DATA 0x00000000
+#define DDRSS_PHY_694_DATA 0x00000000
+#define DDRSS_PHY_695_DATA 0x00000000
+#define DDRSS_PHY_696_DATA 0x00000000
+#define DDRSS_PHY_697_DATA 0x00000000
+#define DDRSS_PHY_698_DATA 0x00000000
+#define DDRSS_PHY_699_DATA 0x00000000
+#define DDRSS_PHY_700_DATA 0x00000000
+#define DDRSS_PHY_701_DATA 0x00000000
+#define DDRSS_PHY_702_DATA 0x00000000
+#define DDRSS_PHY_703_DATA 0x00000000
+#define DDRSS_PHY_704_DATA 0x00000000
+#define DDRSS_PHY_705_DATA 0x00000000
+#define DDRSS_PHY_706_DATA 0x00000000
+#define DDRSS_PHY_707_DATA 0x00000000
+#define DDRSS_PHY_708_DATA 0x00000000
+#define DDRSS_PHY_709_DATA 0x00000000
+#define DDRSS_PHY_710_DATA 0x00000000
+#define DDRSS_PHY_711_DATA 0x00000000
+#define DDRSS_PHY_712_DATA 0x00000000
+#define DDRSS_PHY_713_DATA 0x00000000
+#define DDRSS_PHY_714_DATA 0x00000000
+#define DDRSS_PHY_715_DATA 0x00000000
+#define DDRSS_PHY_716_DATA 0x00000000
+#define DDRSS_PHY_717_DATA 0x00000000
+#define DDRSS_PHY_718_DATA 0x00000000
+#define DDRSS_PHY_719_DATA 0x00000000
+#define DDRSS_PHY_720_DATA 0x00000000
+#define DDRSS_PHY_721_DATA 0x00000000
+#define DDRSS_PHY_722_DATA 0x00000000
+#define DDRSS_PHY_723_DATA 0x00000000
+#define DDRSS_PHY_724_DATA 0x00000000
+#define DDRSS_PHY_725_DATA 0x00000000
+#define DDRSS_PHY_726_DATA 0x00000000
+#define DDRSS_PHY_727_DATA 0x00000000
+#define DDRSS_PHY_728_DATA 0x00000000
+#define DDRSS_PHY_729_DATA 0x00000000
+#define DDRSS_PHY_730_DATA 0x00000000
+#define DDRSS_PHY_731_DATA 0x00000000
+#define DDRSS_PHY_732_DATA 0x00000000
+#define DDRSS_PHY_733_DATA 0x00000000
+#define DDRSS_PHY_734_DATA 0x00000000
+#define DDRSS_PHY_735_DATA 0x00000000
+#define DDRSS_PHY_736_DATA 0x00000000
+#define DDRSS_PHY_737_DATA 0x00000000
+#define DDRSS_PHY_738_DATA 0x00000000
+#define DDRSS_PHY_739_DATA 0x00000000
+#define DDRSS_PHY_740_DATA 0x00000000
+#define DDRSS_PHY_741_DATA 0x00000000
+#define DDRSS_PHY_742_DATA 0x00000000
+#define DDRSS_PHY_743_DATA 0x00000000
+#define DDRSS_PHY_744_DATA 0x00000000
+#define DDRSS_PHY_745_DATA 0x00000000
+#define DDRSS_PHY_746_DATA 0x00000000
+#define DDRSS_PHY_747_DATA 0x00000000
+#define DDRSS_PHY_748_DATA 0x00000000
+#define DDRSS_PHY_749_DATA 0x00000000
+#define DDRSS_PHY_750_DATA 0x00000000
+#define DDRSS_PHY_751_DATA 0x00000000
+#define DDRSS_PHY_752_DATA 0x00000000
+#define DDRSS_PHY_753_DATA 0x00000000
+#define DDRSS_PHY_754_DATA 0x00000000
+#define DDRSS_PHY_755_DATA 0x00000000
+#define DDRSS_PHY_756_DATA 0x00000000
+#define DDRSS_PHY_757_DATA 0x00000000
+#define DDRSS_PHY_758_DATA 0x00000000
+#define DDRSS_PHY_759_DATA 0x00000000
+#define DDRSS_PHY_760_DATA 0x00000000
+#define DDRSS_PHY_761_DATA 0x00000000
+#define DDRSS_PHY_762_DATA 0x00000000
+#define DDRSS_PHY_763_DATA 0x00000000
+#define DDRSS_PHY_764_DATA 0x00000000
+#define DDRSS_PHY_765_DATA 0x00000000
+#define DDRSS_PHY_766_DATA 0x00000000
+#define DDRSS_PHY_767_DATA 0x00000000
+#define DDRSS_PHY_768_DATA 0x04F00000
+#define DDRSS_PHY_769_DATA 0x00000000
+#define DDRSS_PHY_770_DATA 0x00030200
+#define DDRSS_PHY_771_DATA 0x00000000
+#define DDRSS_PHY_772_DATA 0x00000000
+#define DDRSS_PHY_773_DATA 0x01030000
+#define DDRSS_PHY_774_DATA 0x00010000
+#define DDRSS_PHY_775_DATA 0x01030004
+#define DDRSS_PHY_776_DATA 0x01000000
+#define DDRSS_PHY_777_DATA 0x00000000
+#define DDRSS_PHY_778_DATA 0x00000000
+#define DDRSS_PHY_779_DATA 0x00000000
+#define DDRSS_PHY_780_DATA 0x01010000
+#define DDRSS_PHY_781_DATA 0x00010000
+#define DDRSS_PHY_782_DATA 0x00C00001
+#define DDRSS_PHY_783_DATA 0x00CC0008
+#define DDRSS_PHY_784_DATA 0x00660601
+#define DDRSS_PHY_785_DATA 0x00000003
+#define DDRSS_PHY_786_DATA 0x00000000
+#define DDRSS_PHY_787_DATA 0x00000001
+#define DDRSS_PHY_788_DATA 0x0000AAAA
+#define DDRSS_PHY_789_DATA 0x00005555
+#define DDRSS_PHY_790_DATA 0x0000B5B5
+#define DDRSS_PHY_791_DATA 0x00004A4A
+#define DDRSS_PHY_792_DATA 0x00005656
+#define DDRSS_PHY_793_DATA 0x0000A9A9
+#define DDRSS_PHY_794_DATA 0x0000B7B7
+#define DDRSS_PHY_795_DATA 0x00004848
+#define DDRSS_PHY_796_DATA 0x00000000
+#define DDRSS_PHY_797_DATA 0x00000000
+#define DDRSS_PHY_798_DATA 0x08000000
+#define DDRSS_PHY_799_DATA 0x0F000008
+#define DDRSS_PHY_800_DATA 0x00000F0F
+#define DDRSS_PHY_801_DATA 0x00E4E400
+#define DDRSS_PHY_802_DATA 0x00071020
+#define DDRSS_PHY_803_DATA 0x000C0020
+#define DDRSS_PHY_804_DATA 0x00062000
+#define DDRSS_PHY_805_DATA 0x00000000
+#define DDRSS_PHY_806_DATA 0x55555555
+#define DDRSS_PHY_807_DATA 0xAAAAAAAA
+#define DDRSS_PHY_808_DATA 0x55555555
+#define DDRSS_PHY_809_DATA 0xAAAAAAAA
+#define DDRSS_PHY_810_DATA 0x00005555
+#define DDRSS_PHY_811_DATA 0x01000100
+#define DDRSS_PHY_812_DATA 0x00800180
+#define DDRSS_PHY_813_DATA 0x00000001
+#define DDRSS_PHY_814_DATA 0x00000000
+#define DDRSS_PHY_815_DATA 0x00000000
+#define DDRSS_PHY_816_DATA 0x00000000
+#define DDRSS_PHY_817_DATA 0x00000000
+#define DDRSS_PHY_818_DATA 0x00000000
+#define DDRSS_PHY_819_DATA 0x00000000
+#define DDRSS_PHY_820_DATA 0x00000000
+#define DDRSS_PHY_821_DATA 0x00000000
+#define DDRSS_PHY_822_DATA 0x00000000
+#define DDRSS_PHY_823_DATA 0x00000000
+#define DDRSS_PHY_824_DATA 0x00000000
+#define DDRSS_PHY_825_DATA 0x00000000
+#define DDRSS_PHY_826_DATA 0x00000000
+#define DDRSS_PHY_827_DATA 0x00000000
+#define DDRSS_PHY_828_DATA 0x00000000
+#define DDRSS_PHY_829_DATA 0x00000000
+#define DDRSS_PHY_830_DATA 0x00000000
+#define DDRSS_PHY_831_DATA 0x00000000
+#define DDRSS_PHY_832_DATA 0x00000000
+#define DDRSS_PHY_833_DATA 0x00000000
+#define DDRSS_PHY_834_DATA 0x00000000
+#define DDRSS_PHY_835_DATA 0x00000104
+#define DDRSS_PHY_836_DATA 0x00000000
+#define DDRSS_PHY_837_DATA 0x00000000
+#define DDRSS_PHY_838_DATA 0x00000000
+#define DDRSS_PHY_839_DATA 0x00000000
+#define DDRSS_PHY_840_DATA 0x00000000
+#define DDRSS_PHY_841_DATA 0x00000000
+#define DDRSS_PHY_842_DATA 0x081F07FF
+#define DDRSS_PHY_843_DATA 0x10200080
+#define DDRSS_PHY_844_DATA 0x00000008
+#define DDRSS_PHY_845_DATA 0x00000401
+#define DDRSS_PHY_846_DATA 0x00000000
+#define DDRSS_PHY_847_DATA 0x01CC0B01
+#define DDRSS_PHY_848_DATA 0x1003CC0B
+#define DDRSS_PHY_849_DATA 0x20000140
+#define DDRSS_PHY_850_DATA 0x07FF0200
+#define DDRSS_PHY_851_DATA 0x0000DD01
+#define DDRSS_PHY_852_DATA 0x00100303
+#define DDRSS_PHY_853_DATA 0x00000000
+#define DDRSS_PHY_854_DATA 0x00000000
+#define DDRSS_PHY_855_DATA 0x00031000
+#define DDRSS_PHY_856_DATA 0x00100010
+#define DDRSS_PHY_857_DATA 0x00100010
+#define DDRSS_PHY_858_DATA 0x00100010
+#define DDRSS_PHY_859_DATA 0x00100010
+#define DDRSS_PHY_860_DATA 0x02000010
+#define DDRSS_PHY_861_DATA 0x00000004
+#define DDRSS_PHY_862_DATA 0x51516042
+#define DDRSS_PHY_863_DATA 0x31C06000
+#define DDRSS_PHY_864_DATA 0x07AB0340
+#define DDRSS_PHY_865_DATA 0x00C0C001
+#define DDRSS_PHY_866_DATA 0x0B000000
+#define DDRSS_PHY_867_DATA 0x000B0A0A
+#define DDRSS_PHY_868_DATA 0x42100010
+#define DDRSS_PHY_869_DATA 0x010C073E
+#define DDRSS_PHY_870_DATA 0x000F0C2D
+#define DDRSS_PHY_871_DATA 0x01000140
+#define DDRSS_PHY_872_DATA 0x00F50120
+#define DDRSS_PHY_873_DATA 0x00000C00
+#define DDRSS_PHY_874_DATA 0x00000299
+#define DDRSS_PHY_875_DATA 0x00030200
+#define DDRSS_PHY_876_DATA 0x02800000
+#define DDRSS_PHY_877_DATA 0x80800000
+#define DDRSS_PHY_878_DATA 0x000B2010
+#define DDRSS_PHY_879_DATA 0x01462358
+#define DDRSS_PHY_880_DATA 0x00000007
+#define DDRSS_PHY_881_DATA 0x04190419
+#define DDRSS_PHY_882_DATA 0x04190419
+#define DDRSS_PHY_883_DATA 0x04190419
+#define DDRSS_PHY_884_DATA 0x04190419
+#define DDRSS_PHY_885_DATA 0x00000419
+#define DDRSS_PHY_886_DATA 0x0000A000
+#define DDRSS_PHY_887_DATA 0x00A000A0
+#define DDRSS_PHY_888_DATA 0x00A000A0
+#define DDRSS_PHY_889_DATA 0x00A000A0
+#define DDRSS_PHY_890_DATA 0x00A000A0
+#define DDRSS_PHY_891_DATA 0x00A000A0
+#define DDRSS_PHY_892_DATA 0x00A000A0
+#define DDRSS_PHY_893_DATA 0x00A000A0
+#define DDRSS_PHY_894_DATA 0x00A000A0
+#define DDRSS_PHY_895_DATA 0x01E600A0
+#define DDRSS_PHY_896_DATA 0x01000000
+#define DDRSS_PHY_897_DATA 0x00000000
+#define DDRSS_PHY_898_DATA 0x00000000
+#define DDRSS_PHY_899_DATA 0x00080200
+#define DDRSS_PHY_900_DATA 0x00000000
+#define DDRSS_PHY_901_DATA 0x20202020
+#define DDRSS_PHY_902_DATA 0x20202020
+#define DDRSS_PHY_903_DATA 0xF0F02020
+#define DDRSS_PHY_904_DATA 0x00000000
+#define DDRSS_PHY_905_DATA 0x00000000
+#define DDRSS_PHY_906_DATA 0x00000000
+#define DDRSS_PHY_907_DATA 0x00000000
+#define DDRSS_PHY_908_DATA 0x00000000
+#define DDRSS_PHY_909_DATA 0x00000000
+#define DDRSS_PHY_910_DATA 0x00000000
+#define DDRSS_PHY_911_DATA 0x00000000
+#define DDRSS_PHY_912_DATA 0x00000000
+#define DDRSS_PHY_913_DATA 0x00000000
+#define DDRSS_PHY_914_DATA 0x00000000
+#define DDRSS_PHY_915_DATA 0x00000000
+#define DDRSS_PHY_916_DATA 0x00000000
+#define DDRSS_PHY_917_DATA 0x00000000
+#define DDRSS_PHY_918_DATA 0x00000000
+#define DDRSS_PHY_919_DATA 0x00000000
+#define DDRSS_PHY_920_DATA 0x00000000
+#define DDRSS_PHY_921_DATA 0x00000000
+#define DDRSS_PHY_922_DATA 0x00000000
+#define DDRSS_PHY_923_DATA 0x00000000
+#define DDRSS_PHY_924_DATA 0x00000000
+#define DDRSS_PHY_925_DATA 0x00000000
+#define DDRSS_PHY_926_DATA 0x00000000
+#define DDRSS_PHY_927_DATA 0x00000000
+#define DDRSS_PHY_928_DATA 0x00000000
+#define DDRSS_PHY_929_DATA 0x00000000
+#define DDRSS_PHY_930_DATA 0x00000000
+#define DDRSS_PHY_931_DATA 0x00000000
+#define DDRSS_PHY_932_DATA 0x00000000
+#define DDRSS_PHY_933_DATA 0x00000000
+#define DDRSS_PHY_934_DATA 0x00000000
+#define DDRSS_PHY_935_DATA 0x00000000
+#define DDRSS_PHY_936_DATA 0x00000000
+#define DDRSS_PHY_937_DATA 0x00000000
+#define DDRSS_PHY_938_DATA 0x00000000
+#define DDRSS_PHY_939_DATA 0x00000000
+#define DDRSS_PHY_940_DATA 0x00000000
+#define DDRSS_PHY_941_DATA 0x00000000
+#define DDRSS_PHY_942_DATA 0x00000000
+#define DDRSS_PHY_943_DATA 0x00000000
+#define DDRSS_PHY_944_DATA 0x00000000
+#define DDRSS_PHY_945_DATA 0x00000000
+#define DDRSS_PHY_946_DATA 0x00000000
+#define DDRSS_PHY_947_DATA 0x00000000
+#define DDRSS_PHY_948_DATA 0x00000000
+#define DDRSS_PHY_949_DATA 0x00000000
+#define DDRSS_PHY_950_DATA 0x00000000
+#define DDRSS_PHY_951_DATA 0x00000000
+#define DDRSS_PHY_952_DATA 0x00000000
+#define DDRSS_PHY_953_DATA 0x00000000
+#define DDRSS_PHY_954_DATA 0x00000000
+#define DDRSS_PHY_955_DATA 0x00000000
+#define DDRSS_PHY_956_DATA 0x00000000
+#define DDRSS_PHY_957_DATA 0x00000000
+#define DDRSS_PHY_958_DATA 0x00000000
+#define DDRSS_PHY_959_DATA 0x00000000
+#define DDRSS_PHY_960_DATA 0x00000000
+#define DDRSS_PHY_961_DATA 0x00000000
+#define DDRSS_PHY_962_DATA 0x00000000
+#define DDRSS_PHY_963_DATA 0x00000000
+#define DDRSS_PHY_964_DATA 0x00000000
+#define DDRSS_PHY_965_DATA 0x00000000
+#define DDRSS_PHY_966_DATA 0x00000000
+#define DDRSS_PHY_967_DATA 0x00000000
+#define DDRSS_PHY_968_DATA 0x00000000
+#define DDRSS_PHY_969_DATA 0x00000000
+#define DDRSS_PHY_970_DATA 0x00000000
+#define DDRSS_PHY_971_DATA 0x00000000
+#define DDRSS_PHY_972_DATA 0x00000000
+#define DDRSS_PHY_973_DATA 0x00000000
+#define DDRSS_PHY_974_DATA 0x00000000
+#define DDRSS_PHY_975_DATA 0x00000000
+#define DDRSS_PHY_976_DATA 0x00000000
+#define DDRSS_PHY_977_DATA 0x00000000
+#define DDRSS_PHY_978_DATA 0x00000000
+#define DDRSS_PHY_979_DATA 0x00000000
+#define DDRSS_PHY_980_DATA 0x00000000
+#define DDRSS_PHY_981_DATA 0x00000000
+#define DDRSS_PHY_982_DATA 0x00000000
+#define DDRSS_PHY_983_DATA 0x00000000
+#define DDRSS_PHY_984_DATA 0x00000000
+#define DDRSS_PHY_985_DATA 0x00000000
+#define DDRSS_PHY_986_DATA 0x00000000
+#define DDRSS_PHY_987_DATA 0x00000000
+#define DDRSS_PHY_988_DATA 0x00000000
+#define DDRSS_PHY_989_DATA 0x00000000
+#define DDRSS_PHY_990_DATA 0x00000000
+#define DDRSS_PHY_991_DATA 0x00000000
+#define DDRSS_PHY_992_DATA 0x00000000
+#define DDRSS_PHY_993_DATA 0x00000000
+#define DDRSS_PHY_994_DATA 0x00000000
+#define DDRSS_PHY_995_DATA 0x00000000
+#define DDRSS_PHY_996_DATA 0x00000000
+#define DDRSS_PHY_997_DATA 0x00000000
+#define DDRSS_PHY_998_DATA 0x00000000
+#define DDRSS_PHY_999_DATA 0x00000000
+#define DDRSS_PHY_1000_DATA 0x00000000
+#define DDRSS_PHY_1001_DATA 0x00000000
+#define DDRSS_PHY_1002_DATA 0x00000000
+#define DDRSS_PHY_1003_DATA 0x00000000
+#define DDRSS_PHY_1004_DATA 0x00000000
+#define DDRSS_PHY_1005_DATA 0x00000000
+#define DDRSS_PHY_1006_DATA 0x00000000
+#define DDRSS_PHY_1007_DATA 0x00000000
+#define DDRSS_PHY_1008_DATA 0x00000000
+#define DDRSS_PHY_1009_DATA 0x00000000
+#define DDRSS_PHY_1010_DATA 0x00000000
+#define DDRSS_PHY_1011_DATA 0x00000000
+#define DDRSS_PHY_1012_DATA 0x00000000
+#define DDRSS_PHY_1013_DATA 0x00000000
+#define DDRSS_PHY_1014_DATA 0x00000000
+#define DDRSS_PHY_1015_DATA 0x00000000
+#define DDRSS_PHY_1016_DATA 0x00000000
+#define DDRSS_PHY_1017_DATA 0x00000000
+#define DDRSS_PHY_1018_DATA 0x00000000
+#define DDRSS_PHY_1019_DATA 0x00000000
+#define DDRSS_PHY_1020_DATA 0x00000000
+#define DDRSS_PHY_1021_DATA 0x00000000
+#define DDRSS_PHY_1022_DATA 0x00000000
+#define DDRSS_PHY_1023_DATA 0x00000000
+#define DDRSS_PHY_1024_DATA 0x00000000
+#define DDRSS_PHY_1025_DATA 0x00000000
+#define DDRSS_PHY_1026_DATA 0x00000000
+#define DDRSS_PHY_1027_DATA 0x00000000
+#define DDRSS_PHY_1028_DATA 0x00000000
+#define DDRSS_PHY_1029_DATA 0x00000100
+#define DDRSS_PHY_1030_DATA 0x00000200
+#define DDRSS_PHY_1031_DATA 0x00000000
+#define DDRSS_PHY_1032_DATA 0x00000000
+#define DDRSS_PHY_1033_DATA 0x00000000
+#define DDRSS_PHY_1034_DATA 0x00000000
+#define DDRSS_PHY_1035_DATA 0x00400000
+#define DDRSS_PHY_1036_DATA 0x00000080
+#define DDRSS_PHY_1037_DATA 0x00DCBA98
+#define DDRSS_PHY_1038_DATA 0x03000000
+#define DDRSS_PHY_1039_DATA 0x00200000
+#define DDRSS_PHY_1040_DATA 0x00000000
+#define DDRSS_PHY_1041_DATA 0x00000000
+#define DDRSS_PHY_1042_DATA 0x00000000
+#define DDRSS_PHY_1043_DATA 0x00000000
+#define DDRSS_PHY_1044_DATA 0x00000000
+#define DDRSS_PHY_1045_DATA 0x0000002A
+#define DDRSS_PHY_1046_DATA 0x00000015
+#define DDRSS_PHY_1047_DATA 0x00000015
+#define DDRSS_PHY_1048_DATA 0x0000002A
+#define DDRSS_PHY_1049_DATA 0x00000033
+#define DDRSS_PHY_1050_DATA 0x0000000C
+#define DDRSS_PHY_1051_DATA 0x0000000C
+#define DDRSS_PHY_1052_DATA 0x00000033
+#define DDRSS_PHY_1053_DATA 0x0A418820
+#define DDRSS_PHY_1054_DATA 0x003F0000
+#define DDRSS_PHY_1055_DATA 0x000F013F
+#define DDRSS_PHY_1056_DATA 0x20202003
+#define DDRSS_PHY_1057_DATA 0x00202020
+#define DDRSS_PHY_1058_DATA 0x20008008
+#define DDRSS_PHY_1059_DATA 0x00000810
+#define DDRSS_PHY_1060_DATA 0x00000F00
+#define DDRSS_PHY_1061_DATA 0x000304CC
+#define DDRSS_PHY_1062_DATA 0x03000003
+#define DDRSS_PHY_1063_DATA 0x00030000
+#define DDRSS_PHY_1064_DATA 0x00000300
+#define DDRSS_PHY_1065_DATA 0x00000300
+#define DDRSS_PHY_1066_DATA 0x00000300
+#define DDRSS_PHY_1067_DATA 0x00000300
+#define DDRSS_PHY_1068_DATA 0x42080010
+#define DDRSS_PHY_1069_DATA 0x0000803E
+#define DDRSS_PHY_1070_DATA 0x00000001
+#define DDRSS_PHY_1071_DATA 0x01000002
+#define DDRSS_PHY_1072_DATA 0x00008000
+#define DDRSS_PHY_1073_DATA 0x00000000
+#define DDRSS_PHY_1074_DATA 0x00000000
+#define DDRSS_PHY_1075_DATA 0x00000000
+#define DDRSS_PHY_1076_DATA 0x00000000
+#define DDRSS_PHY_1077_DATA 0x00000000
+#define DDRSS_PHY_1078_DATA 0x00000000
+#define DDRSS_PHY_1079_DATA 0x00000000
+#define DDRSS_PHY_1080_DATA 0x00000000
+#define DDRSS_PHY_1081_DATA 0x00000000
+#define DDRSS_PHY_1082_DATA 0x00000000
+#define DDRSS_PHY_1083_DATA 0x00000000
+#define DDRSS_PHY_1084_DATA 0x00000000
+#define DDRSS_PHY_1085_DATA 0x00000000
+#define DDRSS_PHY_1086_DATA 0x00000000
+#define DDRSS_PHY_1087_DATA 0x00000000
+#define DDRSS_PHY_1088_DATA 0x00000000
+#define DDRSS_PHY_1089_DATA 0x00000000
+#define DDRSS_PHY_1090_DATA 0x00000000
+#define DDRSS_PHY_1091_DATA 0x00000000
+#define DDRSS_PHY_1092_DATA 0x00000000
+#define DDRSS_PHY_1093_DATA 0x00000000
+#define DDRSS_PHY_1094_DATA 0x00000000
+#define DDRSS_PHY_1095_DATA 0x00000000
+#define DDRSS_PHY_1096_DATA 0x00000000
+#define DDRSS_PHY_1097_DATA 0x00000000
+#define DDRSS_PHY_1098_DATA 0x00000000
+#define DDRSS_PHY_1099_DATA 0x00000000
+#define DDRSS_PHY_1100_DATA 0x00000000
+#define DDRSS_PHY_1101_DATA 0x00000000
+#define DDRSS_PHY_1102_DATA 0x00000000
+#define DDRSS_PHY_1103_DATA 0x00000000
+#define DDRSS_PHY_1104_DATA 0x00000000
+#define DDRSS_PHY_1105_DATA 0x00000000
+#define DDRSS_PHY_1106_DATA 0x00000000
+#define DDRSS_PHY_1107_DATA 0x00000000
+#define DDRSS_PHY_1108_DATA 0x00000000
+#define DDRSS_PHY_1109_DATA 0x00000000
+#define DDRSS_PHY_1110_DATA 0x00000000
+#define DDRSS_PHY_1111_DATA 0x00000000
+#define DDRSS_PHY_1112_DATA 0x00000000
+#define DDRSS_PHY_1113_DATA 0x00000000
+#define DDRSS_PHY_1114_DATA 0x00000000
+#define DDRSS_PHY_1115_DATA 0x00000000
+#define DDRSS_PHY_1116_DATA 0x00000000
+#define DDRSS_PHY_1117_DATA 0x00000000
+#define DDRSS_PHY_1118_DATA 0x00000000
+#define DDRSS_PHY_1119_DATA 0x00000000
+#define DDRSS_PHY_1120_DATA 0x00000000
+#define DDRSS_PHY_1121_DATA 0x00000000
+#define DDRSS_PHY_1122_DATA 0x00000000
+#define DDRSS_PHY_1123_DATA 0x00000000
+#define DDRSS_PHY_1124_DATA 0x00000000
+#define DDRSS_PHY_1125_DATA 0x00000000
+#define DDRSS_PHY_1126_DATA 0x00000000
+#define DDRSS_PHY_1127_DATA 0x00000000
+#define DDRSS_PHY_1128_DATA 0x00000000
+#define DDRSS_PHY_1129_DATA 0x00000000
+#define DDRSS_PHY_1130_DATA 0x00000000
+#define DDRSS_PHY_1131_DATA 0x00000000
+#define DDRSS_PHY_1132_DATA 0x00000000
+#define DDRSS_PHY_1133_DATA 0x00000000
+#define DDRSS_PHY_1134_DATA 0x00000000
+#define DDRSS_PHY_1135_DATA 0x00000000
+#define DDRSS_PHY_1136_DATA 0x00000000
+#define DDRSS_PHY_1137_DATA 0x00000000
+#define DDRSS_PHY_1138_DATA 0x00000000
+#define DDRSS_PHY_1139_DATA 0x00000000
+#define DDRSS_PHY_1140_DATA 0x00000000
+#define DDRSS_PHY_1141_DATA 0x00000000
+#define DDRSS_PHY_1142_DATA 0x00000000
+#define DDRSS_PHY_1143_DATA 0x00000000
+#define DDRSS_PHY_1144_DATA 0x00000000
+#define DDRSS_PHY_1145_DATA 0x00000000
+#define DDRSS_PHY_1146_DATA 0x00000000
+#define DDRSS_PHY_1147_DATA 0x00000000
+#define DDRSS_PHY_1148_DATA 0x00000000
+#define DDRSS_PHY_1149_DATA 0x00000000
+#define DDRSS_PHY_1150_DATA 0x00000000
+#define DDRSS_PHY_1151_DATA 0x00000000
+#define DDRSS_PHY_1152_DATA 0x00000000
+#define DDRSS_PHY_1153_DATA 0x00000000
+#define DDRSS_PHY_1154_DATA 0x00000000
+#define DDRSS_PHY_1155_DATA 0x00000000
+#define DDRSS_PHY_1156_DATA 0x00000000
+#define DDRSS_PHY_1157_DATA 0x00000000
+#define DDRSS_PHY_1158_DATA 0x00000000
+#define DDRSS_PHY_1159_DATA 0x00000000
+#define DDRSS_PHY_1160_DATA 0x00000000
+#define DDRSS_PHY_1161_DATA 0x00000000
+#define DDRSS_PHY_1162_DATA 0x00000000
+#define DDRSS_PHY_1163_DATA 0x00000000
+#define DDRSS_PHY_1164_DATA 0x00000000
+#define DDRSS_PHY_1165_DATA 0x00000000
+#define DDRSS_PHY_1166_DATA 0x00000000
+#define DDRSS_PHY_1167_DATA 0x00000000
+#define DDRSS_PHY_1168_DATA 0x00000000
+#define DDRSS_PHY_1169_DATA 0x00000000
+#define DDRSS_PHY_1170_DATA 0x00000000
+#define DDRSS_PHY_1171_DATA 0x00000000
+#define DDRSS_PHY_1172_DATA 0x00000000
+#define DDRSS_PHY_1173_DATA 0x00000000
+#define DDRSS_PHY_1174_DATA 0x00000000
+#define DDRSS_PHY_1175_DATA 0x00000000
+#define DDRSS_PHY_1176_DATA 0x00000000
+#define DDRSS_PHY_1177_DATA 0x00000000
+#define DDRSS_PHY_1178_DATA 0x00000000
+#define DDRSS_PHY_1179_DATA 0x00000000
+#define DDRSS_PHY_1180_DATA 0x00000000
+#define DDRSS_PHY_1181_DATA 0x00000000
+#define DDRSS_PHY_1182_DATA 0x00000000
+#define DDRSS_PHY_1183_DATA 0x00000000
+#define DDRSS_PHY_1184_DATA 0x00000000
+#define DDRSS_PHY_1185_DATA 0x00000000
+#define DDRSS_PHY_1186_DATA 0x00000000
+#define DDRSS_PHY_1187_DATA 0x00000000
+#define DDRSS_PHY_1188_DATA 0x00000000
+#define DDRSS_PHY_1189_DATA 0x00000000
+#define DDRSS_PHY_1190_DATA 0x00000000
+#define DDRSS_PHY_1191_DATA 0x00000000
+#define DDRSS_PHY_1192_DATA 0x00000000
+#define DDRSS_PHY_1193_DATA 0x00000000
+#define DDRSS_PHY_1194_DATA 0x00000000
+#define DDRSS_PHY_1195_DATA 0x00000000
+#define DDRSS_PHY_1196_DATA 0x00000000
+#define DDRSS_PHY_1197_DATA 0x00000000
+#define DDRSS_PHY_1198_DATA 0x00000000
+#define DDRSS_PHY_1199_DATA 0x00000000
+#define DDRSS_PHY_1200_DATA 0x00000000
+#define DDRSS_PHY_1201_DATA 0x00000000
+#define DDRSS_PHY_1202_DATA 0x00000000
+#define DDRSS_PHY_1203_DATA 0x00000000
+#define DDRSS_PHY_1204_DATA 0x00000000
+#define DDRSS_PHY_1205_DATA 0x00000000
+#define DDRSS_PHY_1206_DATA 0x00000000
+#define DDRSS_PHY_1207_DATA 0x00000000
+#define DDRSS_PHY_1208_DATA 0x00000000
+#define DDRSS_PHY_1209_DATA 0x00000000
+#define DDRSS_PHY_1210_DATA 0x00000000
+#define DDRSS_PHY_1211_DATA 0x00000000
+#define DDRSS_PHY_1212_DATA 0x00000000
+#define DDRSS_PHY_1213_DATA 0x00000000
+#define DDRSS_PHY_1214_DATA 0x00000000
+#define DDRSS_PHY_1215_DATA 0x00000000
+#define DDRSS_PHY_1216_DATA 0x00000000
+#define DDRSS_PHY_1217_DATA 0x00000000
+#define DDRSS_PHY_1218_DATA 0x00000000
+#define DDRSS_PHY_1219_DATA 0x00000000
+#define DDRSS_PHY_1220_DATA 0x00000000
+#define DDRSS_PHY_1221_DATA 0x00000000
+#define DDRSS_PHY_1222_DATA 0x00000000
+#define DDRSS_PHY_1223_DATA 0x00000000
+#define DDRSS_PHY_1224_DATA 0x00000000
+#define DDRSS_PHY_1225_DATA 0x00000000
+#define DDRSS_PHY_1226_DATA 0x00000000
+#define DDRSS_PHY_1227_DATA 0x00000000
+#define DDRSS_PHY_1228_DATA 0x00000000
+#define DDRSS_PHY_1229_DATA 0x00000000
+#define DDRSS_PHY_1230_DATA 0x00000000
+#define DDRSS_PHY_1231_DATA 0x00000000
+#define DDRSS_PHY_1232_DATA 0x00000000
+#define DDRSS_PHY_1233_DATA 0x00000000
+#define DDRSS_PHY_1234_DATA 0x00000000
+#define DDRSS_PHY_1235_DATA 0x00000000
+#define DDRSS_PHY_1236_DATA 0x00000000
+#define DDRSS_PHY_1237_DATA 0x00000000
+#define DDRSS_PHY_1238_DATA 0x00000000
+#define DDRSS_PHY_1239_DATA 0x00000000
+#define DDRSS_PHY_1240_DATA 0x00000000
+#define DDRSS_PHY_1241_DATA 0x00000000
+#define DDRSS_PHY_1242_DATA 0x00000000
+#define DDRSS_PHY_1243_DATA 0x00000000
+#define DDRSS_PHY_1244_DATA 0x00000000
+#define DDRSS_PHY_1245_DATA 0x00000000
+#define DDRSS_PHY_1246_DATA 0x00000000
+#define DDRSS_PHY_1247_DATA 0x00000000
+#define DDRSS_PHY_1248_DATA 0x00000000
+#define DDRSS_PHY_1249_DATA 0x00000000
+#define DDRSS_PHY_1250_DATA 0x00000000
+#define DDRSS_PHY_1251_DATA 0x00000000
+#define DDRSS_PHY_1252_DATA 0x00000000
+#define DDRSS_PHY_1253_DATA 0x00000000
+#define DDRSS_PHY_1254_DATA 0x00000000
+#define DDRSS_PHY_1255_DATA 0x00000000
+#define DDRSS_PHY_1256_DATA 0x00000000
+#define DDRSS_PHY_1257_DATA 0x00000000
+#define DDRSS_PHY_1258_DATA 0x00000000
+#define DDRSS_PHY_1259_DATA 0x00000000
+#define DDRSS_PHY_1260_DATA 0x00000000
+#define DDRSS_PHY_1261_DATA 0x00000000
+#define DDRSS_PHY_1262_DATA 0x00000000
+#define DDRSS_PHY_1263_DATA 0x00000000
+#define DDRSS_PHY_1264_DATA 0x00000000
+#define DDRSS_PHY_1265_DATA 0x00000000
+#define DDRSS_PHY_1266_DATA 0x00000000
+#define DDRSS_PHY_1267_DATA 0x00000000
+#define DDRSS_PHY_1268_DATA 0x00000000
+#define DDRSS_PHY_1269_DATA 0x00000000
+#define DDRSS_PHY_1270_DATA 0x00000000
+#define DDRSS_PHY_1271_DATA 0x00000000
+#define DDRSS_PHY_1272_DATA 0x00000000
+#define DDRSS_PHY_1273_DATA 0x00000000
+#define DDRSS_PHY_1274_DATA 0x00000000
+#define DDRSS_PHY_1275_DATA 0x00000000
+#define DDRSS_PHY_1276_DATA 0x00000000
+#define DDRSS_PHY_1277_DATA 0x00000000
+#define DDRSS_PHY_1278_DATA 0x00000000
+#define DDRSS_PHY_1279_DATA 0x00000000
+#define DDRSS_PHY_1280_DATA 0x00000000
+#define DDRSS_PHY_1281_DATA 0x00000000
+#define DDRSS_PHY_1282_DATA 0x00000000
+#define DDRSS_PHY_1283_DATA 0x00000000
+#define DDRSS_PHY_1284_DATA 0x00000000
+#define DDRSS_PHY_1285_DATA 0x00000100
+#define DDRSS_PHY_1286_DATA 0x00000200
+#define DDRSS_PHY_1287_DATA 0x00000000
+#define DDRSS_PHY_1288_DATA 0x00000000
+#define DDRSS_PHY_1289_DATA 0x00000000
+#define DDRSS_PHY_1290_DATA 0x00000000
+#define DDRSS_PHY_1291_DATA 0x00400000
+#define DDRSS_PHY_1292_DATA 0x00000080
+#define DDRSS_PHY_1293_DATA 0x00DCBA98
+#define DDRSS_PHY_1294_DATA 0x03000000
+#define DDRSS_PHY_1295_DATA 0x00200000
+#define DDRSS_PHY_1296_DATA 0x00000000
+#define DDRSS_PHY_1297_DATA 0x00000000
+#define DDRSS_PHY_1298_DATA 0x00000000
+#define DDRSS_PHY_1299_DATA 0x00000000
+#define DDRSS_PHY_1300_DATA 0x00000000
+#define DDRSS_PHY_1301_DATA 0x0000002A
+#define DDRSS_PHY_1302_DATA 0x00000015
+#define DDRSS_PHY_1303_DATA 0x00000015
+#define DDRSS_PHY_1304_DATA 0x0000002A
+#define DDRSS_PHY_1305_DATA 0x00000033
+#define DDRSS_PHY_1306_DATA 0x0000000C
+#define DDRSS_PHY_1307_DATA 0x0000000C
+#define DDRSS_PHY_1308_DATA 0x00000033
+#define DDRSS_PHY_1309_DATA 0x0A418820
+#define DDRSS_PHY_1310_DATA 0x00000000
+#define DDRSS_PHY_1311_DATA 0x000F0000
+#define DDRSS_PHY_1312_DATA 0x20202003
+#define DDRSS_PHY_1313_DATA 0x00202020
+#define DDRSS_PHY_1314_DATA 0x20008008
+#define DDRSS_PHY_1315_DATA 0x00000810
+#define DDRSS_PHY_1316_DATA 0x00000F00
+#define DDRSS_PHY_1317_DATA 0x000304CC
+#define DDRSS_PHY_1318_DATA 0x03000003
+#define DDRSS_PHY_1319_DATA 0x00030000
+#define DDRSS_PHY_1320_DATA 0x00000300
+#define DDRSS_PHY_1321_DATA 0x00000300
+#define DDRSS_PHY_1322_DATA 0x00000300
+#define DDRSS_PHY_1323_DATA 0x00000300
+#define DDRSS_PHY_1324_DATA 0x42080010
+#define DDRSS_PHY_1325_DATA 0x0000803E
+#define DDRSS_PHY_1326_DATA 0x00000001
+#define DDRSS_PHY_1327_DATA 0x01000002
+#define DDRSS_PHY_1328_DATA 0x00008000
+#define DDRSS_PHY_1329_DATA 0x00000000
+#define DDRSS_PHY_1330_DATA 0x00000000
+#define DDRSS_PHY_1331_DATA 0x00000000
+#define DDRSS_PHY_1332_DATA 0x00000000
+#define DDRSS_PHY_1333_DATA 0x00000000
+#define DDRSS_PHY_1334_DATA 0x00000000
+#define DDRSS_PHY_1335_DATA 0x00000000
+#define DDRSS_PHY_1336_DATA 0x00000000
+#define DDRSS_PHY_1337_DATA 0x00000000
+#define DDRSS_PHY_1338_DATA 0x00000000
+#define DDRSS_PHY_1339_DATA 0x00000000
+#define DDRSS_PHY_1340_DATA 0x00000000
+#define DDRSS_PHY_1341_DATA 0x00000000
+#define DDRSS_PHY_1342_DATA 0x00000000
+#define DDRSS_PHY_1343_DATA 0x00000000
+#define DDRSS_PHY_1344_DATA 0x00000000
+#define DDRSS_PHY_1345_DATA 0x00000000
+#define DDRSS_PHY_1346_DATA 0x00000000
+#define DDRSS_PHY_1347_DATA 0x00000000
+#define DDRSS_PHY_1348_DATA 0x00000000
+#define DDRSS_PHY_1349_DATA 0x00000000
+#define DDRSS_PHY_1350_DATA 0x00000000
+#define DDRSS_PHY_1351_DATA 0x00000000
+#define DDRSS_PHY_1352_DATA 0x00000000
+#define DDRSS_PHY_1353_DATA 0x00000000
+#define DDRSS_PHY_1354_DATA 0x00000000
+#define DDRSS_PHY_1355_DATA 0x00000000
+#define DDRSS_PHY_1356_DATA 0x00000000
+#define DDRSS_PHY_1357_DATA 0x00000000
+#define DDRSS_PHY_1358_DATA 0x00000000
+#define DDRSS_PHY_1359_DATA 0x00000000
+#define DDRSS_PHY_1360_DATA 0x00000000
+#define DDRSS_PHY_1361_DATA 0x00000000
+#define DDRSS_PHY_1362_DATA 0x00000000
+#define DDRSS_PHY_1363_DATA 0x00000000
+#define DDRSS_PHY_1364_DATA 0x00000000
+#define DDRSS_PHY_1365_DATA 0x00000000
+#define DDRSS_PHY_1366_DATA 0x00000000
+#define DDRSS_PHY_1367_DATA 0x00000000
+#define DDRSS_PHY_1368_DATA 0x00000000
+#define DDRSS_PHY_1369_DATA 0x00000000
+#define DDRSS_PHY_1370_DATA 0x00000000
+#define DDRSS_PHY_1371_DATA 0x00000000
+#define DDRSS_PHY_1372_DATA 0x00000000
+#define DDRSS_PHY_1373_DATA 0x00000000
+#define DDRSS_PHY_1374_DATA 0x00000000
+#define DDRSS_PHY_1375_DATA 0x00000000
+#define DDRSS_PHY_1376_DATA 0x00000000
+#define DDRSS_PHY_1377_DATA 0x00000000
+#define DDRSS_PHY_1378_DATA 0x00000000
+#define DDRSS_PHY_1379_DATA 0x00000000
+#define DDRSS_PHY_1380_DATA 0x00000000
+#define DDRSS_PHY_1381_DATA 0x00000000
+#define DDRSS_PHY_1382_DATA 0x00000000
+#define DDRSS_PHY_1383_DATA 0x00000000
+#define DDRSS_PHY_1384_DATA 0x00000000
+#define DDRSS_PHY_1385_DATA 0x00000000
+#define DDRSS_PHY_1386_DATA 0x00000000
+#define DDRSS_PHY_1387_DATA 0x00000000
+#define DDRSS_PHY_1388_DATA 0x00000000
+#define DDRSS_PHY_1389_DATA 0x00000000
+#define DDRSS_PHY_1390_DATA 0x00000000
+#define DDRSS_PHY_1391_DATA 0x00000000
+#define DDRSS_PHY_1392_DATA 0x00000000
+#define DDRSS_PHY_1393_DATA 0x00000000
+#define DDRSS_PHY_1394_DATA 0x00000000
+#define DDRSS_PHY_1395_DATA 0x00000000
+#define DDRSS_PHY_1396_DATA 0x00000000
+#define DDRSS_PHY_1397_DATA 0x00000000
+#define DDRSS_PHY_1398_DATA 0x00000000
+#define DDRSS_PHY_1399_DATA 0x00000000
+#define DDRSS_PHY_1400_DATA 0x00000000
+#define DDRSS_PHY_1401_DATA 0x00000000
+#define DDRSS_PHY_1402_DATA 0x00000000
+#define DDRSS_PHY_1403_DATA 0x00000000
+#define DDRSS_PHY_1404_DATA 0x00000000
+#define DDRSS_PHY_1405_DATA 0x00000000
+#define DDRSS_PHY_1406_DATA 0x00000000
+#define DDRSS_PHY_1407_DATA 0x00000000
+#define DDRSS_PHY_1408_DATA 0x00000000
+#define DDRSS_PHY_1409_DATA 0x00000000
+#define DDRSS_PHY_1410_DATA 0x00000000
+#define DDRSS_PHY_1411_DATA 0x00000000
+#define DDRSS_PHY_1412_DATA 0x00000000
+#define DDRSS_PHY_1413_DATA 0x00000000
+#define DDRSS_PHY_1414_DATA 0x00000000
+#define DDRSS_PHY_1415_DATA 0x00000000
+#define DDRSS_PHY_1416_DATA 0x00000000
+#define DDRSS_PHY_1417_DATA 0x00000000
+#define DDRSS_PHY_1418_DATA 0x00000000
+#define DDRSS_PHY_1419_DATA 0x00000000
+#define DDRSS_PHY_1420_DATA 0x00000000
+#define DDRSS_PHY_1421_DATA 0x00000000
+#define DDRSS_PHY_1422_DATA 0x00000000
+#define DDRSS_PHY_1423_DATA 0x00000000
+#define DDRSS_PHY_1424_DATA 0x00000000
+#define DDRSS_PHY_1425_DATA 0x00000000
+#define DDRSS_PHY_1426_DATA 0x00000000
+#define DDRSS_PHY_1427_DATA 0x00000000
+#define DDRSS_PHY_1428_DATA 0x00000000
+#define DDRSS_PHY_1429_DATA 0x00000000
+#define DDRSS_PHY_1430_DATA 0x00000000
+#define DDRSS_PHY_1431_DATA 0x00000000
+#define DDRSS_PHY_1432_DATA 0x00000000
+#define DDRSS_PHY_1433_DATA 0x00000000
+#define DDRSS_PHY_1434_DATA 0x00000000
+#define DDRSS_PHY_1435_DATA 0x00000000
+#define DDRSS_PHY_1436_DATA 0x00000000
+#define DDRSS_PHY_1437_DATA 0x00000000
+#define DDRSS_PHY_1438_DATA 0x00000000
+#define DDRSS_PHY_1439_DATA 0x00000000
+#define DDRSS_PHY_1440_DATA 0x00000000
+#define DDRSS_PHY_1441_DATA 0x00000000
+#define DDRSS_PHY_1442_DATA 0x00000000
+#define DDRSS_PHY_1443_DATA 0x00000000
+#define DDRSS_PHY_1444_DATA 0x00000000
+#define DDRSS_PHY_1445_DATA 0x00000000
+#define DDRSS_PHY_1446_DATA 0x00000000
+#define DDRSS_PHY_1447_DATA 0x00000000
+#define DDRSS_PHY_1448_DATA 0x00000000
+#define DDRSS_PHY_1449_DATA 0x00000000
+#define DDRSS_PHY_1450_DATA 0x00000000
+#define DDRSS_PHY_1451_DATA 0x00000000
+#define DDRSS_PHY_1452_DATA 0x00000000
+#define DDRSS_PHY_1453_DATA 0x00000000
+#define DDRSS_PHY_1454_DATA 0x00000000
+#define DDRSS_PHY_1455_DATA 0x00000000
+#define DDRSS_PHY_1456_DATA 0x00000000
+#define DDRSS_PHY_1457_DATA 0x00000000
+#define DDRSS_PHY_1458_DATA 0x00000000
+#define DDRSS_PHY_1459_DATA 0x00000000
+#define DDRSS_PHY_1460_DATA 0x00000000
+#define DDRSS_PHY_1461_DATA 0x00000000
+#define DDRSS_PHY_1462_DATA 0x00000000
+#define DDRSS_PHY_1463_DATA 0x00000000
+#define DDRSS_PHY_1464_DATA 0x00000000
+#define DDRSS_PHY_1465_DATA 0x00000000
+#define DDRSS_PHY_1466_DATA 0x00000000
+#define DDRSS_PHY_1467_DATA 0x00000000
+#define DDRSS_PHY_1468_DATA 0x00000000
+#define DDRSS_PHY_1469_DATA 0x00000000
+#define DDRSS_PHY_1470_DATA 0x00000000
+#define DDRSS_PHY_1471_DATA 0x00000000
+#define DDRSS_PHY_1472_DATA 0x00000000
+#define DDRSS_PHY_1473_DATA 0x00000000
+#define DDRSS_PHY_1474_DATA 0x00000000
+#define DDRSS_PHY_1475_DATA 0x00000000
+#define DDRSS_PHY_1476_DATA 0x00000000
+#define DDRSS_PHY_1477_DATA 0x00000000
+#define DDRSS_PHY_1478_DATA 0x00000000
+#define DDRSS_PHY_1479_DATA 0x00000000
+#define DDRSS_PHY_1480_DATA 0x00000000
+#define DDRSS_PHY_1481_DATA 0x00000000
+#define DDRSS_PHY_1482_DATA 0x00000000
+#define DDRSS_PHY_1483_DATA 0x00000000
+#define DDRSS_PHY_1484_DATA 0x00000000
+#define DDRSS_PHY_1485_DATA 0x00000000
+#define DDRSS_PHY_1486_DATA 0x00000000
+#define DDRSS_PHY_1487_DATA 0x00000000
+#define DDRSS_PHY_1488_DATA 0x00000000
+#define DDRSS_PHY_1489_DATA 0x00000000
+#define DDRSS_PHY_1490_DATA 0x00000000
+#define DDRSS_PHY_1491_DATA 0x00000000
+#define DDRSS_PHY_1492_DATA 0x00000000
+#define DDRSS_PHY_1493_DATA 0x00000000
+#define DDRSS_PHY_1494_DATA 0x00000000
+#define DDRSS_PHY_1495_DATA 0x00000000
+#define DDRSS_PHY_1496_DATA 0x00000000
+#define DDRSS_PHY_1497_DATA 0x00000000
+#define DDRSS_PHY_1498_DATA 0x00000000
+#define DDRSS_PHY_1499_DATA 0x00000000
+#define DDRSS_PHY_1500_DATA 0x00000000
+#define DDRSS_PHY_1501_DATA 0x00000000
+#define DDRSS_PHY_1502_DATA 0x00000000
+#define DDRSS_PHY_1503_DATA 0x00000000
+#define DDRSS_PHY_1504_DATA 0x00000000
+#define DDRSS_PHY_1505_DATA 0x00000000
+#define DDRSS_PHY_1506_DATA 0x00000000
+#define DDRSS_PHY_1507_DATA 0x00000000
+#define DDRSS_PHY_1508_DATA 0x00000000
+#define DDRSS_PHY_1509_DATA 0x00000000
+#define DDRSS_PHY_1510_DATA 0x00000000
+#define DDRSS_PHY_1511_DATA 0x00000000
+#define DDRSS_PHY_1512_DATA 0x00000000
+#define DDRSS_PHY_1513_DATA 0x00000000
+#define DDRSS_PHY_1514_DATA 0x00000000
+#define DDRSS_PHY_1515_DATA 0x00000000
+#define DDRSS_PHY_1516_DATA 0x00000000
+#define DDRSS_PHY_1517_DATA 0x00000000
+#define DDRSS_PHY_1518_DATA 0x00000000
+#define DDRSS_PHY_1519_DATA 0x00000000
+#define DDRSS_PHY_1520_DATA 0x00000000
+#define DDRSS_PHY_1521_DATA 0x00000000
+#define DDRSS_PHY_1522_DATA 0x00000000
+#define DDRSS_PHY_1523_DATA 0x00000000
+#define DDRSS_PHY_1524_DATA 0x00000000
+#define DDRSS_PHY_1525_DATA 0x00000000
+#define DDRSS_PHY_1526_DATA 0x00000000
+#define DDRSS_PHY_1527_DATA 0x00000000
+#define DDRSS_PHY_1528_DATA 0x00000000
+#define DDRSS_PHY_1529_DATA 0x00000000
+#define DDRSS_PHY_1530_DATA 0x00000000
+#define DDRSS_PHY_1531_DATA 0x00000000
+#define DDRSS_PHY_1532_DATA 0x00000000
+#define DDRSS_PHY_1533_DATA 0x00000000
+#define DDRSS_PHY_1534_DATA 0x00000000
+#define DDRSS_PHY_1535_DATA 0x00000000
+#define DDRSS_PHY_1536_DATA 0x00000000
+#define DDRSS_PHY_1537_DATA 0x00000000
+#define DDRSS_PHY_1538_DATA 0x00000000
+#define DDRSS_PHY_1539_DATA 0x00000000
+#define DDRSS_PHY_1540_DATA 0x00000000
+#define DDRSS_PHY_1541_DATA 0x00000100
+#define DDRSS_PHY_1542_DATA 0x00000200
+#define DDRSS_PHY_1543_DATA 0x00000000
+#define DDRSS_PHY_1544_DATA 0x00000000
+#define DDRSS_PHY_1545_DATA 0x00000000
+#define DDRSS_PHY_1546_DATA 0x00000000
+#define DDRSS_PHY_1547_DATA 0x00400000
+#define DDRSS_PHY_1548_DATA 0x00000080
+#define DDRSS_PHY_1549_DATA 0x00DCBA98
+#define DDRSS_PHY_1550_DATA 0x03000000
+#define DDRSS_PHY_1551_DATA 0x00200000
+#define DDRSS_PHY_1552_DATA 0x00000000
+#define DDRSS_PHY_1553_DATA 0x00000000
+#define DDRSS_PHY_1554_DATA 0x00000000
+#define DDRSS_PHY_1555_DATA 0x00000000
+#define DDRSS_PHY_1556_DATA 0x00000000
+#define DDRSS_PHY_1557_DATA 0x0000002A
+#define DDRSS_PHY_1558_DATA 0x00000015
+#define DDRSS_PHY_1559_DATA 0x00000015
+#define DDRSS_PHY_1560_DATA 0x0000002A
+#define DDRSS_PHY_1561_DATA 0x00000033
+#define DDRSS_PHY_1562_DATA 0x0000000C
+#define DDRSS_PHY_1563_DATA 0x0000000C
+#define DDRSS_PHY_1564_DATA 0x00000033
+#define DDRSS_PHY_1565_DATA 0x0A418820
+#define DDRSS_PHY_1566_DATA 0x10000000
+#define DDRSS_PHY_1567_DATA 0x000F0000
+#define DDRSS_PHY_1568_DATA 0x20202003
+#define DDRSS_PHY_1569_DATA 0x00202020
+#define DDRSS_PHY_1570_DATA 0x20008008
+#define DDRSS_PHY_1571_DATA 0x00000810
+#define DDRSS_PHY_1572_DATA 0x00000F00
+#define DDRSS_PHY_1573_DATA 0x000304CC
+#define DDRSS_PHY_1574_DATA 0x03000003
+#define DDRSS_PHY_1575_DATA 0x00030000
+#define DDRSS_PHY_1576_DATA 0x00000300
+#define DDRSS_PHY_1577_DATA 0x00000300
+#define DDRSS_PHY_1578_DATA 0x00000300
+#define DDRSS_PHY_1579_DATA 0x00000300
+#define DDRSS_PHY_1580_DATA 0x42080010
+#define DDRSS_PHY_1581_DATA 0x0000803E
+#define DDRSS_PHY_1582_DATA 0x00000001
+#define DDRSS_PHY_1583_DATA 0x01000002
+#define DDRSS_PHY_1584_DATA 0x00008000
+#define DDRSS_PHY_1585_DATA 0x00000000
+#define DDRSS_PHY_1586_DATA 0x00000000
+#define DDRSS_PHY_1587_DATA 0x00000000
+#define DDRSS_PHY_1588_DATA 0x00000000
+#define DDRSS_PHY_1589_DATA 0x00000000
+#define DDRSS_PHY_1590_DATA 0x00000000
+#define DDRSS_PHY_1591_DATA 0x00000000
+#define DDRSS_PHY_1592_DATA 0x00000000
+#define DDRSS_PHY_1593_DATA 0x00000000
+#define DDRSS_PHY_1594_DATA 0x00000000
+#define DDRSS_PHY_1595_DATA 0x00000000
+#define DDRSS_PHY_1596_DATA 0x00000000
+#define DDRSS_PHY_1597_DATA 0x00000000
+#define DDRSS_PHY_1598_DATA 0x00000000
+#define DDRSS_PHY_1599_DATA 0x00000000
+#define DDRSS_PHY_1600_DATA 0x00000000
+#define DDRSS_PHY_1601_DATA 0x00000000
+#define DDRSS_PHY_1602_DATA 0x00000000
+#define DDRSS_PHY_1603_DATA 0x00000000
+#define DDRSS_PHY_1604_DATA 0x00000000
+#define DDRSS_PHY_1605_DATA 0x00000000
+#define DDRSS_PHY_1606_DATA 0x00000000
+#define DDRSS_PHY_1607_DATA 0x00000000
+#define DDRSS_PHY_1608_DATA 0x00000000
+#define DDRSS_PHY_1609_DATA 0x00000000
+#define DDRSS_PHY_1610_DATA 0x00000000
+#define DDRSS_PHY_1611_DATA 0x00000000
+#define DDRSS_PHY_1612_DATA 0x00000000
+#define DDRSS_PHY_1613_DATA 0x00000000
+#define DDRSS_PHY_1614_DATA 0x00000000
+#define DDRSS_PHY_1615_DATA 0x00000000
+#define DDRSS_PHY_1616_DATA 0x00000000
+#define DDRSS_PHY_1617_DATA 0x00000000
+#define DDRSS_PHY_1618_DATA 0x00000000
+#define DDRSS_PHY_1619_DATA 0x00000000
+#define DDRSS_PHY_1620_DATA 0x00000000
+#define DDRSS_PHY_1621_DATA 0x00000000
+#define DDRSS_PHY_1622_DATA 0x00000000
+#define DDRSS_PHY_1623_DATA 0x00000000
+#define DDRSS_PHY_1624_DATA 0x00000000
+#define DDRSS_PHY_1625_DATA 0x00000000
+#define DDRSS_PHY_1626_DATA 0x00000000
+#define DDRSS_PHY_1627_DATA 0x00000000
+#define DDRSS_PHY_1628_DATA 0x00000000
+#define DDRSS_PHY_1629_DATA 0x00000000
+#define DDRSS_PHY_1630_DATA 0x00000000
+#define DDRSS_PHY_1631_DATA 0x00000000
+#define DDRSS_PHY_1632_DATA 0x00000000
+#define DDRSS_PHY_1633_DATA 0x00000000
+#define DDRSS_PHY_1634_DATA 0x00000000
+#define DDRSS_PHY_1635_DATA 0x00000000
+#define DDRSS_PHY_1636_DATA 0x00000000
+#define DDRSS_PHY_1637_DATA 0x00000000
+#define DDRSS_PHY_1638_DATA 0x00000000
+#define DDRSS_PHY_1639_DATA 0x00000000
+#define DDRSS_PHY_1640_DATA 0x00000000
+#define DDRSS_PHY_1641_DATA 0x00000000
+#define DDRSS_PHY_1642_DATA 0x00000000
+#define DDRSS_PHY_1643_DATA 0x00000000
+#define DDRSS_PHY_1644_DATA 0x00000000
+#define DDRSS_PHY_1645_DATA 0x00000000
+#define DDRSS_PHY_1646_DATA 0x00000000
+#define DDRSS_PHY_1647_DATA 0x00000000
+#define DDRSS_PHY_1648_DATA 0x00000000
+#define DDRSS_PHY_1649_DATA 0x00000000
+#define DDRSS_PHY_1650_DATA 0x00000000
+#define DDRSS_PHY_1651_DATA 0x00000000
+#define DDRSS_PHY_1652_DATA 0x00000000
+#define DDRSS_PHY_1653_DATA 0x00000000
+#define DDRSS_PHY_1654_DATA 0x00000000
+#define DDRSS_PHY_1655_DATA 0x00000000
+#define DDRSS_PHY_1656_DATA 0x00000000
+#define DDRSS_PHY_1657_DATA 0x00000000
+#define DDRSS_PHY_1658_DATA 0x00000000
+#define DDRSS_PHY_1659_DATA 0x00000000
+#define DDRSS_PHY_1660_DATA 0x00000000
+#define DDRSS_PHY_1661_DATA 0x00000000
+#define DDRSS_PHY_1662_DATA 0x00000000
+#define DDRSS_PHY_1663_DATA 0x00000000
+#define DDRSS_PHY_1664_DATA 0x00000000
+#define DDRSS_PHY_1665_DATA 0x00000000
+#define DDRSS_PHY_1666_DATA 0x00000000
+#define DDRSS_PHY_1667_DATA 0x00000000
+#define DDRSS_PHY_1668_DATA 0x00000000
+#define DDRSS_PHY_1669_DATA 0x00000000
+#define DDRSS_PHY_1670_DATA 0x00000000
+#define DDRSS_PHY_1671_DATA 0x00000000
+#define DDRSS_PHY_1672_DATA 0x00000000
+#define DDRSS_PHY_1673_DATA 0x00000000
+#define DDRSS_PHY_1674_DATA 0x00000000
+#define DDRSS_PHY_1675_DATA 0x00000000
+#define DDRSS_PHY_1676_DATA 0x00000000
+#define DDRSS_PHY_1677_DATA 0x00000000
+#define DDRSS_PHY_1678_DATA 0x00000000
+#define DDRSS_PHY_1679_DATA 0x00000000
+#define DDRSS_PHY_1680_DATA 0x00000000
+#define DDRSS_PHY_1681_DATA 0x00000000
+#define DDRSS_PHY_1682_DATA 0x00000000
+#define DDRSS_PHY_1683_DATA 0x00000000
+#define DDRSS_PHY_1684_DATA 0x00000000
+#define DDRSS_PHY_1685_DATA 0x00000000
+#define DDRSS_PHY_1686_DATA 0x00000000
+#define DDRSS_PHY_1687_DATA 0x00000000
+#define DDRSS_PHY_1688_DATA 0x00000000
+#define DDRSS_PHY_1689_DATA 0x00000000
+#define DDRSS_PHY_1690_DATA 0x00000000
+#define DDRSS_PHY_1691_DATA 0x00000000
+#define DDRSS_PHY_1692_DATA 0x00000000
+#define DDRSS_PHY_1693_DATA 0x00000000
+#define DDRSS_PHY_1694_DATA 0x00000000
+#define DDRSS_PHY_1695_DATA 0x00000000
+#define DDRSS_PHY_1696_DATA 0x00000000
+#define DDRSS_PHY_1697_DATA 0x00000000
+#define DDRSS_PHY_1698_DATA 0x00000000
+#define DDRSS_PHY_1699_DATA 0x00000000
+#define DDRSS_PHY_1700_DATA 0x00000000
+#define DDRSS_PHY_1701_DATA 0x00000000
+#define DDRSS_PHY_1702_DATA 0x00000000
+#define DDRSS_PHY_1703_DATA 0x00000000
+#define DDRSS_PHY_1704_DATA 0x00000000
+#define DDRSS_PHY_1705_DATA 0x00000000
+#define DDRSS_PHY_1706_DATA 0x00000000
+#define DDRSS_PHY_1707_DATA 0x00000000
+#define DDRSS_PHY_1708_DATA 0x00000000
+#define DDRSS_PHY_1709_DATA 0x00000000
+#define DDRSS_PHY_1710_DATA 0x00000000
+#define DDRSS_PHY_1711_DATA 0x00000000
+#define DDRSS_PHY_1712_DATA 0x00000000
+#define DDRSS_PHY_1713_DATA 0x00000000
+#define DDRSS_PHY_1714_DATA 0x00000000
+#define DDRSS_PHY_1715_DATA 0x00000000
+#define DDRSS_PHY_1716_DATA 0x00000000
+#define DDRSS_PHY_1717_DATA 0x00000000
+#define DDRSS_PHY_1718_DATA 0x00000000
+#define DDRSS_PHY_1719_DATA 0x00000000
+#define DDRSS_PHY_1720_DATA 0x00000000
+#define DDRSS_PHY_1721_DATA 0x00000000
+#define DDRSS_PHY_1722_DATA 0x00000000
+#define DDRSS_PHY_1723_DATA 0x00000000
+#define DDRSS_PHY_1724_DATA 0x00000000
+#define DDRSS_PHY_1725_DATA 0x00000000
+#define DDRSS_PHY_1726_DATA 0x00000000
+#define DDRSS_PHY_1727_DATA 0x00000000
+#define DDRSS_PHY_1728_DATA 0x00000000
+#define DDRSS_PHY_1729_DATA 0x00000000
+#define DDRSS_PHY_1730_DATA 0x00000000
+#define DDRSS_PHY_1731_DATA 0x00000000
+#define DDRSS_PHY_1732_DATA 0x00000000
+#define DDRSS_PHY_1733_DATA 0x00000000
+#define DDRSS_PHY_1734_DATA 0x00000000
+#define DDRSS_PHY_1735_DATA 0x00000000
+#define DDRSS_PHY_1736_DATA 0x00000000
+#define DDRSS_PHY_1737_DATA 0x00000000
+#define DDRSS_PHY_1738_DATA 0x00000000
+#define DDRSS_PHY_1739_DATA 0x00000000
+#define DDRSS_PHY_1740_DATA 0x00000000
+#define DDRSS_PHY_1741_DATA 0x00000000
+#define DDRSS_PHY_1742_DATA 0x00000000
+#define DDRSS_PHY_1743_DATA 0x00000000
+#define DDRSS_PHY_1744_DATA 0x00000000
+#define DDRSS_PHY_1745_DATA 0x00000000
+#define DDRSS_PHY_1746_DATA 0x00000000
+#define DDRSS_PHY_1747_DATA 0x00000000
+#define DDRSS_PHY_1748_DATA 0x00000000
+#define DDRSS_PHY_1749_DATA 0x00000000
+#define DDRSS_PHY_1750_DATA 0x00000000
+#define DDRSS_PHY_1751_DATA 0x00000000
+#define DDRSS_PHY_1752_DATA 0x00000000
+#define DDRSS_PHY_1753_DATA 0x00000000
+#define DDRSS_PHY_1754_DATA 0x00000000
+#define DDRSS_PHY_1755_DATA 0x00000000
+#define DDRSS_PHY_1756_DATA 0x00000000
+#define DDRSS_PHY_1757_DATA 0x00000000
+#define DDRSS_PHY_1758_DATA 0x00000000
+#define DDRSS_PHY_1759_DATA 0x00000000
+#define DDRSS_PHY_1760_DATA 0x00000000
+#define DDRSS_PHY_1761_DATA 0x00000000
+#define DDRSS_PHY_1762_DATA 0x00000000
+#define DDRSS_PHY_1763_DATA 0x00000000
+#define DDRSS_PHY_1764_DATA 0x00000000
+#define DDRSS_PHY_1765_DATA 0x00000000
+#define DDRSS_PHY_1766_DATA 0x00000000
+#define DDRSS_PHY_1767_DATA 0x00000000
+#define DDRSS_PHY_1768_DATA 0x00000000
+#define DDRSS_PHY_1769_DATA 0x00000000
+#define DDRSS_PHY_1770_DATA 0x00000000
+#define DDRSS_PHY_1771_DATA 0x00000000
+#define DDRSS_PHY_1772_DATA 0x00000000
+#define DDRSS_PHY_1773_DATA 0x00000000
+#define DDRSS_PHY_1774_DATA 0x00000000
+#define DDRSS_PHY_1775_DATA 0x00000000
+#define DDRSS_PHY_1776_DATA 0x00000000
+#define DDRSS_PHY_1777_DATA 0x00000000
+#define DDRSS_PHY_1778_DATA 0x00000000
+#define DDRSS_PHY_1779_DATA 0x00000000
+#define DDRSS_PHY_1780_DATA 0x00000000
+#define DDRSS_PHY_1781_DATA 0x00000000
+#define DDRSS_PHY_1782_DATA 0x00000000
+#define DDRSS_PHY_1783_DATA 0x00000000
+#define DDRSS_PHY_1784_DATA 0x00000000
+#define DDRSS_PHY_1785_DATA 0x00000000
+#define DDRSS_PHY_1786_DATA 0x00000000
+#define DDRSS_PHY_1787_DATA 0x00000000
+#define DDRSS_PHY_1788_DATA 0x00000000
+#define DDRSS_PHY_1789_DATA 0x00000000
+#define DDRSS_PHY_1790_DATA 0x00000000
+#define DDRSS_PHY_1791_DATA 0x00000000
+#define DDRSS_PHY_1792_DATA 0x00000000
+#define DDRSS_PHY_1793_DATA 0x00010100
+#define DDRSS_PHY_1794_DATA 0x00000000
+#define DDRSS_PHY_1795_DATA 0x00000000
+#define DDRSS_PHY_1796_DATA 0x00000000
+#define DDRSS_PHY_1797_DATA 0x00000000
+#define DDRSS_PHY_1798_DATA 0x00050000
+#define DDRSS_PHY_1799_DATA 0x04000000
+#define DDRSS_PHY_1800_DATA 0x00000055
+#define DDRSS_PHY_1801_DATA 0x00000000
+#define DDRSS_PHY_1802_DATA 0x00000000
+#define DDRSS_PHY_1803_DATA 0x00000000
+#define DDRSS_PHY_1804_DATA 0x00000000
+#define DDRSS_PHY_1805_DATA 0x00002001
+#define DDRSS_PHY_1806_DATA 0x00004003
+#define DDRSS_PHY_1807_DATA 0x50020028
+#define DDRSS_PHY_1808_DATA 0x01010000
+#define DDRSS_PHY_1809_DATA 0x80080001
+#define DDRSS_PHY_1810_DATA 0x10200000
+#define DDRSS_PHY_1811_DATA 0x00000008
+#define DDRSS_PHY_1812_DATA 0x00000000
+#define DDRSS_PHY_1813_DATA 0x06000000
+#define DDRSS_PHY_1814_DATA 0x010F0F0E
+#define DDRSS_PHY_1815_DATA 0x00040101
+#define DDRSS_PHY_1816_DATA 0x0000010F
+#define DDRSS_PHY_1817_DATA 0x00000000
+#define DDRSS_PHY_1818_DATA 0x00000064
+#define DDRSS_PHY_1819_DATA 0x00000000
+#define DDRSS_PHY_1820_DATA 0x00000000
+#define DDRSS_PHY_1821_DATA 0x0F0F0F01
+#define DDRSS_PHY_1822_DATA 0x0F0F0F02
+#define DDRSS_PHY_1823_DATA 0x0F0F0F0F
+#define DDRSS_PHY_1824_DATA 0x0F0F0804
+#define DDRSS_PHY_1825_DATA 0x00800120
+#define DDRSS_PHY_1826_DATA 0x00041B42
+#define DDRSS_PHY_1827_DATA 0x00004201
+#define DDRSS_PHY_1828_DATA 0x00000000
+#define DDRSS_PHY_1829_DATA 0x00000000
+#define DDRSS_PHY_1830_DATA 0x00000000
+#define DDRSS_PHY_1831_DATA 0x00000000
+#define DDRSS_PHY_1832_DATA 0x00000000
+#define DDRSS_PHY_1833_DATA 0x00000000
+#define DDRSS_PHY_1834_DATA 0x03010100
+#define DDRSS_PHY_1835_DATA 0x00540007
+#define DDRSS_PHY_1836_DATA 0x000040A2
+#define DDRSS_PHY_1837_DATA 0x00024410
+#define DDRSS_PHY_1838_DATA 0x00004410
+#define DDRSS_PHY_1839_DATA 0x00004410
+#define DDRSS_PHY_1840_DATA 0x00004410
+#define DDRSS_PHY_1841_DATA 0x00004410
+#define DDRSS_PHY_1842_DATA 0x00004410
+#define DDRSS_PHY_1843_DATA 0x00004410
+#define DDRSS_PHY_1844_DATA 0x00004410
+#define DDRSS_PHY_1845_DATA 0x00004410
+#define DDRSS_PHY_1846_DATA 0x00004410
+#define DDRSS_PHY_1847_DATA 0x00000000
+#define DDRSS_PHY_1848_DATA 0x00000076
+#define DDRSS_PHY_1849_DATA 0x00000400
+#define DDRSS_PHY_1850_DATA 0x00000008
+#define DDRSS_PHY_1851_DATA 0x00000000
+#define DDRSS_PHY_1852_DATA 0x00000000
+#define DDRSS_PHY_1853_DATA 0x00000000
+#define DDRSS_PHY_1854_DATA 0x00000000
+#define DDRSS_PHY_1855_DATA 0x00000000
+#define DDRSS_PHY_1856_DATA 0x03000000
+#define DDRSS_PHY_1857_DATA 0x00000000
+#define DDRSS_PHY_1858_DATA 0x00000000
+#define DDRSS_PHY_1859_DATA 0x00000000
+#define DDRSS_PHY_1860_DATA 0x04102006
+#define DDRSS_PHY_1861_DATA 0x00041020
+#define DDRSS_PHY_1862_DATA 0x01C98C98
+#define DDRSS_PHY_1863_DATA 0x3F400000
+#define DDRSS_PHY_1864_DATA 0x3F3F1F3F
+#define DDRSS_PHY_1865_DATA 0x0000001F
+#define DDRSS_PHY_1866_DATA 0x00000000
+#define DDRSS_PHY_1867_DATA 0x00000000
+#define DDRSS_PHY_1868_DATA 0x00000000
+#define DDRSS_PHY_1869_DATA 0x00000001
+#define DDRSS_PHY_1870_DATA 0x00000000
+#define DDRSS_PHY_1871_DATA 0x00000000
+#define DDRSS_PHY_1872_DATA 0x00000000
+#define DDRSS_PHY_1873_DATA 0x00000000
+#define DDRSS_PHY_1874_DATA 0x76542310
+#define DDRSS_PHY_1875_DATA 0x06010198
+#define DDRSS_PHY_1876_DATA 0x00000000
+#define DDRSS_PHY_1877_DATA 0x00000000
+#define DDRSS_PHY_1878_DATA 0x00000000
+#define DDRSS_PHY_1879_DATA 0x00040700
+#define DDRSS_PHY_1880_DATA 0x00000000
+#define DDRSS_PHY_1881_DATA 0x00000000
+#define DDRSS_PHY_1882_DATA 0x00000000
+#define DDRSS_PHY_1883_DATA 0x00000000
+#define DDRSS_PHY_1884_DATA 0x00000000
+#define DDRSS_PHY_1885_DATA 0x00000002
+#define DDRSS_PHY_1886_DATA 0x00000000
+#define DDRSS_PHY_1887_DATA 0x00000000
+#define DDRSS_PHY_1888_DATA 0x0001F7C3
+#define DDRSS_PHY_1889_DATA 0x03000003
+#define DDRSS_PHY_1890_DATA 0x00000000
+#define DDRSS_PHY_1891_DATA 0x00001142
+#define DDRSS_PHY_1892_DATA 0x01020000
+#define DDRSS_PHY_1893_DATA 0x00000080
+#define DDRSS_PHY_1894_DATA 0x03900390
+#define DDRSS_PHY_1895_DATA 0x03900390
+#define DDRSS_PHY_1896_DATA 0x03900390
+#define DDRSS_PHY_1897_DATA 0x03900390
+#define DDRSS_PHY_1898_DATA 0x03000300
+#define DDRSS_PHY_1899_DATA 0x03000300
+#define DDRSS_PHY_1900_DATA 0x00000300
+#define DDRSS_PHY_1901_DATA 0x00000300
+#define DDRSS_PHY_1902_DATA 0x00000300
+#define DDRSS_PHY_1903_DATA 0x00000300
+#define DDRSS_PHY_1904_DATA 0x00000004
+#define DDRSS_PHY_1905_DATA 0x3183BF77
+#define DDRSS_PHY_1906_DATA 0x00000000
+#define DDRSS_PHY_1907_DATA 0x0C000DFF
+#define DDRSS_PHY_1908_DATA 0x30000DFF
+#define DDRSS_PHY_1909_DATA 0x3F0DFF11
+#define DDRSS_PHY_1910_DATA 0x00EF0000
+#define DDRSS_PHY_1911_DATA 0x780DFFCC
+#define DDRSS_PHY_1912_DATA 0x00000C11
+#define DDRSS_PHY_1913_DATA 0x00018011
+#define DDRSS_PHY_1914_DATA 0x0089FF00
+#define DDRSS_PHY_1915_DATA 0x000C3F11
+#define DDRSS_PHY_1916_DATA 0x01990000
+#define DDRSS_PHY_1917_DATA 0x000C3F91
+#define DDRSS_PHY_1918_DATA 0x01990000
+#define DDRSS_PHY_1919_DATA 0x3F0DFF11
+#define DDRSS_PHY_1920_DATA 0x00EF0000
+#define DDRSS_PHY_1921_DATA 0x00018011
+#define DDRSS_PHY_1922_DATA 0x0089FF00
+#define DDRSS_PHY_1923_DATA 0x20040005
diff --git a/arch/arm/dts/k3-am62p5-verdin-r5.dts b/arch/arm/dts/k3-am62p5-verdin-r5.dts
new file mode 100644
index 000000000000..983a3bfe6707
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-verdin-r5.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Toradex Verdin AM62P dts file for R5 SPL
+ * Copyright 2025 Toradex - https://www.toradex.com/
+ */
+
+#include "k3-am62p5-verdin-wifi-dev.dts"
+#include "k3-am62p5-verdin-lpddr4-1600.dtsi"
+#include "k3-am62a-ddr.dtsi"
+
+#include "k3-am62p5-verdin-wifi-dev-u-boot.dtsi"
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		clock-names = "gtc", "core";
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 36>;
+		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 38>;
+		assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-all;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 20>,
+			<&secure_proxy_main 21>;
+		bootph-all;
+	};
+};
+
+&cbass_main {
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x00 0x44860000 0x00 0x20000>,
+		      <0x00 0x43600000 0x00 0x10000>;
+		reg-names = "rt", "scfg", "target_data";
+		bootph-all;
+	};
+
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&sa3_secproxy 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-all;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
new file mode 100644
index 000000000000..13fac18d7aac
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ */
+
+#include "k3-binman.dtsi"
+
+#if IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_R5)
+
+&binman {
+	tiboot3-am62px-hs-fs-verdin.bin {
+		filename = "tiboot3-am62px-hs-fs-verdin.bin";
+		symlink = "tiboot3.bin";
+
+		ti-secure-rom {
+			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
+				  <&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs>;
+			content-sysfw = <&ti_fs_enc_fs>;
+			content-sysfw-data = <&combined_tifs_cfg_fs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
+			content-dm-data = <&combined_dm_cfg_fs>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c4a800>;
+		};
+
+		u_boot_spl_fs: u-boot-spl {
+			no-expanded;
+		};
+
+		ti_fs_enc_fs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		sysfw_inner_cert_fs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_dm_cfg_fs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tiboot3-am62px-hs-verdin.bin {
+		filename = "tiboot3-am62px-hs-verdin.bin";
+
+		ti-secure-rom {
+			content = <&u_boot_spl_hs>, <&ti_fs_enc_hs>, <&combined_tifs_cfg_hs>,
+				  <&combined_dm_cfg_hs>, <&sysfw_inner_cert_hs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_hs>;
+			content-sysfw = <&ti_fs_enc_hs>;
+			content-sysfw-data = <&combined_tifs_cfg_hs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_hs>;
+			content-dm-data = <&combined_dm_cfg_hs>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c4a800>;
+		};
+
+		u_boot_spl_hs: u-boot-spl {
+			no-expanded;
+		};
+
+		ti_fs_enc_hs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_tifs_cfg_hs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+
+		sysfw_inner_cert_hs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+		combined_dm_cfg_hs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
+#endif /* CONFIG_TARGET_VERDIN_AM62P_R5 */
+
+#if IS_ENABLED(CONFIG_TARGET_VERDIN_AM62P_A53)
+
+#define SPL_VERDIN_AM62P_DTB "spl/dts/k3-am62p5-verdin-wifi-dev.dtb"
+#define VERDIN_AM62P_DTB "u-boot.dtb"
+
+&binman {
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+	};
+
+	ti-spl {
+		insert-template = <&ti_spl_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm>;
+						keyfile = "custMpk.pem";
+					};
+
+					dm: ti-dm {
+						filename = "ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+						optional;
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62p5-verdin-wifi-dev";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&spl_verdin_am62p_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					spl_verdin_am62p_dtb: blob-ext {
+						filename = SPL_VERDIN_AM62P_DTB;
+					};
+
+				};
+
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62p5-verdin-wifi-dev";
+					firmware = "atf";
+					loadables = "tee", "tifsstub-hs", "tifsstub-fs",
+						    "dm", "spl";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	u-boot {
+		insert-template = <&u_boot_template>;
+
+		fit {
+			images {
+				uboot {
+					description = "U-Boot for Verdin AM62P5 Boards";
+				};
+
+				fdt-0 {
+					description = "k3-am62p5-verdin-wifi-dev";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&verdin_am62p_dtb>;
+						keyfile = "custMpk.pem";
+					};
+
+					verdin_am62p_dtb: blob-ext {
+						filename = VERDIN_AM62P_DTB;
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62p5-verdin-wifi-dev";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+
+			};
+		};
+	};
+};
+
+&binman {
+	firmware-verdin-am62px-hs.bin {
+		filename = "firmware-verdin-am62px-hs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am62px-hs-verdin.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+
+	firmware-verdin-am62px-hs-fs.bin {
+		filename = "firmware-verdin-am62px-hs-fs.bin";
+
+		blob-ext@1 {
+			filename = "tiboot3-am62px-hs-fs-verdin.bin";
+		};
+
+		blob-ext@2 {
+			filename = "tispl.bin";
+			/*
+			 * This value matches CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
+			 * from R5 SPL config.
+			 */
+			offset = <0x80000>;
+		};
+
+		blob-ext@3 {
+			filename = "u-boot.img";
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)>;
+		};
+	};
+};
+
+#endif /* CONFIG_TARGET_VERDIN_AM62P_A53 */
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi
new file mode 100644
index 000000000000..366867d1e6a5
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ */
+
+#include "k3-am62p5-verdin-wifi-dev-binman.dtsi"
+
+/ {
+	chosen {
+		tick-timer = &main_timer0;
+	};
+
+	memory@80000000 {
+		bootph-pre-ram;
+	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
+&carrier_eth_phy {
+	bootph-all;
+};
+
+&cpsw3g {
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
+&cpsw3g_mdio {
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	/delete-property/ assigned-clock-rates;
+	bootph-all;
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&cpsw_port1 {
+	bootph-all;
+};
+
+/* Verdin ETH_2_RGMII */
+&cpsw_port2 {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+};
+
+&k3_clks {
+	bootph-all;
+};
+
+&k3_pds {
+	bootph-all;
+};
+
+&k3_reset {
+	bootph-all;
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+/* Verdin I2C_1 */
+&main_i2c0 {
+	bootph-all;
+};
+
+&main_pktdma {
+	bootph-all;
+};
+
+&mcu_pmx0 {
+	bootph-all;
+};
+
+/* Verdin UART_3, used as the Linux console */
+&main_uart0 {
+	bootph-all;
+};
+
+&main_pmx0 {
+	bootph-all;
+};
+
+&pinctrl_main_i2c0 {
+	bootph-all;
+};
+
+&pinctrl_mdio {
+	bootph-all;
+};
+
+&pinctrl_rgmii1 {
+	bootph-all;
+};
+
+&pinctrl_rgmii2 {
+	bootph-all;
+};
+
+&pinctrl_uart0 {
+	bootph-all;
+};
+
+&pinctrl_wkup_i2c0 {
+	bootph-all;
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&sdhci0 {
+	bootph-all;
+};
+
+&sdhci2 {
+	status = "disabled";
+};
+
+&som_eth_phy {
+	bootph-all;
+};
+
+&som_gpio_expander {
+	bootph-all;
+
+	ctrl-sleep-moci-hog {
+		bootph-all;
+		gpio-hog;
+		gpios = <0 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+		output-high;
+	};
+};
+
+/* Required for USB DFU Boot */
+&usb0 {
+	/* Enable peripheral mode only during bootup
+	 * to support DFU while allowing Linux to stay
+	 * in OTG mode
+	 */
+	dr_mode = "peripheral";
+	bootph-all;
+};
+
+/* Required for USB DFU Boot */
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
+/* Required for USB DFU Boot */
+&usbss0 {
+	bootph-all;
+};
+
+/* On-module I2C - PMIC_I2C */
+&wkup_i2c0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts b/arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts
new file mode 100644
index 000000000000..bbc2770d5f5d
--- /dev/null
+++ b/arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+ * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
+ */
+
+/dts-v1/;
+
+#include "k3-am62p5.dtsi"
+#include "k3-am62p-verdin.dtsi"
+#include "k3-am62p-verdin-wifi.dtsi"
+#include "k3-am62p-verdin-dev.dtsi"
+
+/ {
+	model = "Toradex Verdin AM62P WB on Verdin Development Board";
+	compatible = "toradex,verdin-am62p-wifi-dev",
+		     "toradex,verdin-am62p-wifi",
+		     "toradex,verdin-am62p",
+		     "ti,am62p5";
+};
diff --git a/arch/arm/mach-k3/am62px/Kconfig b/arch/arm/mach-k3/am62px/Kconfig
index 76ae86b66222..0f1fcfab5fc3 100644
--- a/arch/arm/mach-k3/am62px/Kconfig
+++ b/arch/arm/mach-k3/am62px/Kconfig
@@ -29,5 +29,6 @@ config TARGET_AM62P5_R5_EVM
 endchoice
 
 source "board/ti/am62px/Kconfig"
+source "board/toradex/verdin-am62p/Kconfig"
 
 endif
diff --git a/board/toradex/verdin-am62p/Kconfig b/board/toradex/verdin-am62p/Kconfig
new file mode 100644
index 000000000000..7bf0133b669d
--- /dev/null
+++ b/board/toradex/verdin-am62p/Kconfig
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025 Toradex
+#
+
+choice
+	prompt "Toradex Verdin AM62P based boards"
+	optional
+
+config TARGET_VERDIN_AM62P_A53
+        bool "Toradex Verdin AM62P running on A53"
+        select ARM64
+        select BINMAN
+        select OF_SYSTEM_SETUP
+
+config TARGET_VERDIN_AM62P_R5
+        bool "Toradex Verdin AM62P running on R5"
+        select CPU_V7R
+        select SYS_THUMB_BUILD
+        select K3_LOAD_SYSFW
+        select RAM
+        select SPL_RAM
+        select K3_DDRSS
+        select BINMAN
+        imply SYS_K3_SPL_ATF
+
+endchoice
+
+if TARGET_VERDIN_AM62P_A53
+
+config SYS_BOARD
+	default "verdin-am62p"
+
+config SYS_CONFIG_NAME
+	default "verdin-am62p"
+
+config SYS_VENDOR
+	default "toradex"
+
+config TDX_CFG_BLOCK
+	default y
+
+config TDX_CFG_BLOCK_2ND_ETHADDR
+	default y
+
+config TDX_CFG_BLOCK_DEV
+	default "0"
+
+config TDX_CFG_BLOCK_EXTRA
+	default y
+
+# Toradex config block in eMMC, at the end of 1st "boot sector"
+config TDX_CFG_BLOCK_OFFSET
+	default "-512"
+
+config TDX_CFG_BLOCK_PART
+	default "1"
+
+config TDX_HAVE_EEPROM_EXTRA
+	default y
+
+config TDX_HAVE_MMC
+	default y
+
+source "board/toradex/common/Kconfig"
+
+endif
+
+if TARGET_VERDIN_AM62P_R5
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+config SYS_BOARD
+	default "verdin-am62p"
+
+config SYS_CONFIG_NAME
+	default "verdin-am62p"
+
+config SYS_VENDOR
+	default "toradex"
+
+endif
diff --git a/board/toradex/verdin-am62p/MAINTAINERS b/board/toradex/verdin-am62p/MAINTAINERS
new file mode 100644
index 000000000000..97094e0e756a
--- /dev/null
+++ b/board/toradex/verdin-am62p/MAINTAINERS
@@ -0,0 +1,17 @@
+Verdin AM62P
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
+W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+S:	Maintained
+F:	arch/arm/dts/k3-am62p-verdin-dev.dtsi
+F:	arch/arm/dts/k3-am62p-verdin-wifi.dtsi
+F:	arch/arm/dts/k3-am62p-verdin.dtsi
+F:	arch/arm/dts/k3-am62p5-verdin-lpddr4-1600.dtsi
+F:	arch/arm/dts/k3-am62p5-verdin-r5.dts
+F:	arch/arm/dts/k3-am62p5-verdin-wifi-dev-binman.dtsi
+F:	arch/arm/dts/k3-am62p5-verdin-wifi-dev-u-boot.dtsi
+F:	arch/arm/dts/k3-am62p5-verdin-wifi-dev.dts
+F:	board/toradex/verdin-am62p/
+F:	configs/verdin-am62p_a53_defconfig
+F:	configs/verdin-am62p_r5_defconfig
+F:	doc/board/toradex/verdin-am62p.rst
+F:	include/configs/verdin-am62p.h
diff --git a/board/toradex/verdin-am62p/Makefile b/board/toradex/verdin-am62p/Makefile
new file mode 100644
index 000000000000..2eef6f4f592e
--- /dev/null
+++ b/board/toradex/verdin-am62p/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright 2025 Toradex
+#
+
+obj-y += verdin-am62p.o
diff --git a/board/toradex/verdin-am62p/board-cfg.yaml b/board/toradex/verdin-am62p/board-cfg.yaml
new file mode 100644
index 000000000000..d539011aff9f
--- /dev/null
+++ b/board/toradex/verdin-am62p/board-cfg.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for AM62Px SoCs
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size: 0x10
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/toradex/verdin-am62p/pm-cfg.yaml b/board/toradex/verdin-am62p/pm-cfg.yaml
new file mode 100644
index 000000000000..3ff27ce702c2
--- /dev/null
+++ b/board/toradex/verdin-am62p/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for AM62Px
+#
+#
+---
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/toradex/verdin-am62p/rm-cfg.yaml b/board/toradex/verdin-am62p/rm-cfg.yaml
new file mode 100644
index 000000000000..73da85eeaded
--- /dev/null
+++ b/board/toradex/verdin-am62p/rm-cfg.yaml
@@ -0,0 +1,1083 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62P
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 1112
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 1676
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1676
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1676
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 5
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 1695
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 1
+            type: 1695
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 3
+            num_resource: 1
+            type: 1695
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 30
+            num_resource: 2
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 5
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 525
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 781
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 909
+            num_resource: 626
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 25
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 25
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 25
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 25
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 25
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 25
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 32
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51
+            num_resource: 32
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 6
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 6
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 124
+            num_resource: 10
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 4
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 4
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 6
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 6
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 25
+            num_resource: 10
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51200
+            num_resource: 12
+            type: 12738
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 12739
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 128
+            type: 12813
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
diff --git a/board/toradex/verdin-am62p/sec-cfg.yaml b/board/toradex/verdin-am62p/sec-cfg.yaml
new file mode 100644
index 000000000000..bfd6a4e5dbdd
--- /dev/null
+++ b/board/toradex/verdin-am62p/sec-cfg.yaml
@@ -0,0 +1,378 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security configuration for AM62Px
+#
+---
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        otp_entry:
+            -  # 1
+                host_id: 0
+                host_perms: 0
+            -  # 2
+                host_id: 0
+                host_perms: 0
+            -  # 3
+                host_id: 0
+                host_perms: 0
+            -  # 4
+                host_id: 0
+                host_perms: 0
+            -  # 5
+                host_id: 0
+                host_perms: 0
+            -  # 6
+                host_id: 0
+                host_perms: 0
+            -  # 7
+                host_id: 0
+                host_perms: 0
+            -  # 8
+                host_id: 0
+                host_perms: 0
+            -  # 9
+                host_id: 0
+                host_perms: 0
+            -  # 10
+                host_id: 0
+                host_perms: 0
+            -  # 11
+                host_id: 0
+                host_perms: 0
+            -  # 12
+                host_id: 0
+                host_perms: 0
+            -  # 13
+                host_id: 0
+                host_perms: 0
+            -  # 14
+                host_id: 0
+                host_perms: 0
+            -  # 15
+                host_id: 0
+                host_perms: 0
+            -  # 16
+                host_id: 0
+                host_perms: 0
+            -  # 17
+                host_id: 0
+                host_perms: 0
+            -  # 18
+                host_id: 0
+                host_perms: 0
+            -  # 19
+                host_id: 0
+                host_perms: 0
+            -  # 20
+                host_id: 0
+                host_perms: 0
+            -  # 21
+                host_id: 0
+                host_perms: 0
+            -  # 22
+                host_id: 0
+                host_perms: 0
+            -  # 23
+                host_id: 0
+                host_perms: 0
+            -  # 24
+                host_id: 0
+                host_perms: 0
+            -  # 25
+                host_id: 0
+                host_perms: 0
+            -  # 26
+                host_id: 0
+                host_perms: 0
+            -  # 27
+                host_id: 0
+                host_perms: 0
+            -  # 28
+                host_id: 0
+                host_perms: 0
+            -  # 29
+                host_id: 0
+                host_perms: 0
+            -  # 30
+                host_id: 0
+                host_perms: 0
+            -  # 31
+                host_id: 0
+                host_perms: 0
+            -  # 32
+                host_id: 0
+                host_perms: 0
+        write_host_id: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x5A
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]
diff --git a/board/toradex/verdin-am62p/tifs-rm-cfg.yaml b/board/toradex/verdin-am62p/tifs-rm-cfg.yaml
new file mode 100644
index 000000000000..80269748057f
--- /dev/null
+++ b/board/toradex/verdin-am62p/tifs-rm-cfg.yaml
@@ -0,0 +1,927 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62P
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj : 0x0
+            boardcfg_abi_min : 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size : 356
+            host_cfg_entries:
+                - #1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 904
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1677
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1677
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1677
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 18
+                type: 1678
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 75
+                num_resource: 5
+                type: 1678
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 75
+                num_resource: 5
+                type: 1678
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 1678
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 1679
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 2
+                type: 1679
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 5
+                type: 1679
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1696
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1696
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1696
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1697
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 5
+                type: 1697
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 5
+                type: 1697
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 2
+                type: 1697
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 12
+                type: 1698
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 1698
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 5
+                type: 1698
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 35
+                type: 1802
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 35
+                type: 1802
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 35
+                type: 1802
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 168
+                num_resource: 8
+                type: 1802
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 29
+                type: 1807
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4608
+                num_resource: 99
+                type: 1808
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5120
+                num_resource: 24
+                type: 1809
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5632
+                num_resource: 51
+                type: 1810
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 6144
+                num_resource: 51
+                type: 1811
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 8192
+                num_resource: 32
+                type: 1812
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 8704
+                num_resource: 32
+                type: 1813
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 9216
+                num_resource: 32
+                type: 1814
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 9728
+                num_resource: 25
+                type: 1815
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 10240
+                num_resource: 25
+                type: 1816
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 10752
+                num_resource: 25
+                type: 1817
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 11264
+                num_resource: 25
+                type: 1818
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 11776
+                num_resource: 25
+                type: 1819
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 12288
+                num_resource: 25
+                type: 1820
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1936
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1936
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1936
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 32
+                type: 1937
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 32
+                type: 1937
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 32
+                type: 1937
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 32
+                type: 1937
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 8
+                type: 1938
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 8
+                type: 1939
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 99
+                num_resource: 10
+                type: 1942
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 3
+                type: 1942
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 3
+                type: 1942
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 6
+                type: 1943
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 6
+                type: 1943
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 10
+                type: 1943
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 10
+                type: 1943
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1944
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1945
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1946
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1947
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1955
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1955
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1955
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 1956
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 1956
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 4
+                type: 1956
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 4
+                type: 1956
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 1
+                type: 1957
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 1958
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1961
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1961
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1961
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1962
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1962
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1962
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 6
+                type: 1964
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 6
+                type: 1964
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 10
+                type: 1964
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 10
+                type: 1964
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 1965
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1966
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 1
+                type: 1967
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 1
+                type: 1969
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1970
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 1
+                type: 1971
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1972
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 2112
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 2122
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12750
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12769
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12810
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 6
+                type: 12826
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 6
+                type: 12827
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 6
+                type: 12828
+                host_id: 128
+                reserved: 0
diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
new file mode 100644
index 000000000000..105b3120fc05
--- /dev/null
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Board specific initialization for Verdin AM62P SoM
+ *
+ * Copyright 2025 Toradex - https://www.toradex.com/
+ *
+ */
+
+#include <config.h>
+#include <asm/arch/hardware.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <k3-ddrss.h>
+#include <spl.h>
+
+#include "../common/tdx-cfg-block.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+static u8 hw_cfg;
+
+static void read_hw_cfg(void)
+{
+	struct gpio_desc gpio_hw_cfg;
+	static const int gpios[] = { 58, 61, 62 }; /* HW_CFG0, HW_CFG1, HW_CFG2 */
+	char gpio_name[20];
+	int i;
+
+	printf("HW CFG: ");
+
+	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
+		snprintf(gpio_name, sizeof(gpio_name), "gpio@600000_%d", gpios[i]);
+
+		if (dm_gpio_lookup_name(gpio_name, &gpio_hw_cfg) < 0) {
+			printf("Lookup error: GPIO %d\n", gpios[i]);
+			continue;
+		}
+
+		if (dm_gpio_request(&gpio_hw_cfg, "hw_cfg")) {
+			printf("GPIO request error: %d\n", gpios[i]);
+			continue;
+		}
+
+		if (dm_gpio_get_value(&gpio_hw_cfg) == 1)
+			hw_cfg |= BIT(i);
+
+		dm_gpio_free(NULL, &gpio_hw_cfg);
+	}
+
+	printf("0x%02x\n", hw_cfg);
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
+
+	if (gd->ram_size < SZ_1G)
+		puts("## WARNING: Less than 1GB RAM detected\n");
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		printf("Error setting up memory banksize. %d\n", ret);
+
+	/* Use the detected RAM size, we only support 1 bank right now. */
+	gd->bd->bi_dram[0].size = gd->ram_size;
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_SPL_LOAD_FIT)
+int board_fit_config_name_match(const char *name)
+{
+	return 0;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
+
+static void select_dt_from_module_version(void)
+{
+	char variant[32];
+	char *env_variant = env_get("variant");
+	int is_wifi = 0;
+
+	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
+		/*
+		 * If we have a valid config block and it says we are a module with
+		 * Wi-Fi/Bluetooth make sure we use the -wifi device tree.
+		 */
+		is_wifi = (tdx_hw_tag.prodid == VERDIN_AM62PQ_2G_WIFI_BT_IT);
+	}
+
+	if (is_wifi)
+		strlcpy(&variant[0], "wifi", sizeof(variant));
+	else
+		strlcpy(&variant[0], "nonwifi", sizeof(variant));
+
+	if (strcmp(variant, env_variant)) {
+		printf("Setting variant to %s\n", variant);
+		env_set("variant", variant);
+	}
+}
+
+int board_late_init(void)
+{
+	select_dt_from_module_version();
+
+	return 0;
+}
+
+#define MCU_CTRL_LFXOSC_32K_BYPASS_VAL	BIT(4)
+
+void spl_board_init(void)
+{
+	u32 val;
+
+	/*
+	 * We use the 32k FOUT from the Epson RX8130CE RTC chip,
+	 * configure LFXOSC accordingly, see AM62P datasheet,
+	 * Table 6-23, LFXOSC Modes of Operation.
+	 */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~MCU_CTRL_LFXOSC_32K_DISABLE_VAL;
+	val |= MCU_CTRL_LFXOSC_32K_BYPASS_VAL;
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Make sure to mux up to take the SoC 32k from the LFOSC input */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+
+	read_hw_cfg();
+}
diff --git a/board/toradex/verdin-am62p/verdin-am62p.env b/board/toradex/verdin-am62p/verdin-am62p.env
new file mode 100644
index 000000000000..f8b7363dcf51
--- /dev/null
+++ b/board/toradex/verdin-am62p/verdin-am62p.env
@@ -0,0 +1,41 @@
+#define CFG_RAMDISK_ADDR_R		0x90300000
+#define CFG_SCRIPTADDR			0x90280000
+
+boot_script_dhcp=boot.scr
+boot_targets=mmc1 mmc0 dhcp
+console=ttyS2
+fdt_addr_r=0x90200000
+fdt_board=dev
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0x80200000
+kernel_comp_size=0x08000000
+ramdisk_addr_r=CFG_RAMDISK_ADDR_R
+scriptaddr=CFG_SCRIPTADDR
+
+dfu_alt_info_ram=
+	tispl.bin ram 0x80080000 0x200000;
+	u-boot.img ram 0x81000000 0x400000;
+	loadaddr ram CONFIG_SYS_LOAD_ADDR 0x80000;
+	scriptaddr ram CFG_SCRIPTADDR 0x80000;
+	ramdisk_addr_r ram CFG_RAMDISK_ADDR_R 0x8000000
+
+update_tiboot3=
+		askenv confirm Did you load tiboot3.bin (y/N)?;
+		if test $confirm = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
+			mmc dev 0 1; mmc write ${loadaddr} 0x0 ${blkcnt};
+		fi
+
+update_tispl=
+		askenv confirm Did you load tispl.bin (y/N)?;
+		if test $confirm = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
+			mmc dev 0 1; mmc write ${loadaddr} 0x400 ${blkcnt};
+		fi
+
+update_uboot=
+		askenv confirm Did you load u-boot.img (y/N)?;
+		if test $confirm = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200;
+			mmc dev 0 1; mmc write ${loadaddr} 0x1400 ${blkcnt};
+		fi
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
new file mode 100644
index 000000000000..cb0bf2c78385
--- /dev/null
+++ b/configs/verdin-am62p_a53_defconfig
@@ -0,0 +1,199 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SOC_K3_AM62P5=y
+CONFIG_TARGET_VERDIN_AM62P_A53=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFDE00
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62p5-verdin-wifi-dev"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_BOOTM_LEN=0x40000000
+CONFIG_SYS_LOAD_ADDR=0x88200000
+CONFIG_SPL_SIZE_LIMIT=0x80000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0xB0000000
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_BOOTSTD_FULL=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="bootflow scan -b"
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_LOG=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SYS_PROMPT="Verdin AM62P # "
+CONFIG_CMD_ADTIMG=y
+CONFIG_CMD_ASKENV=y
+# CONFIG_CMD_EXPORTENV is not set
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_BCB=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BOOTCOUNT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_UUID=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4_WRITE=y
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_IP_DEFRAG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x88200000
+CONFIG_FASTBOOT_BUF_SIZE=0x8000000
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_DM_I2C_GPIO=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_SPL_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_PHY_ADDR_ENABLE=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_ETHERNET_ID=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_RGMII=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_DSP=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_HEXDUMP=y
diff --git a/configs/verdin-am62p_r5_defconfig b/configs/verdin-am62p_r5_defconfig
new file mode 100644
index 000000000000..d1cc9b81640c
--- /dev/null
+++ b/configs/verdin-am62p_r5_defconfig
@@ -0,0 +1,117 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_LEN=0x08000000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SOC_K3_AM62P5=y
+CONFIG_K3_QOS=y
+CONFIG_TARGET_VERDIN_AM62P_R5=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c4a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62p5-verdin-r5"
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c4b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SIZE_LIMIT=0x3C000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x5000
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+CONFIG_CMD_DFU=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_MISC=y
+CONFIG_ESM_K3=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
diff --git a/doc/board/toradex/verdin-am62p.rst b/doc/board/toradex/verdin-am62p.rst
new file mode 100644
index 000000000000..fbd160d72f94
--- /dev/null
+++ b/doc/board/toradex/verdin-am62p.rst
@@ -0,0 +1,196 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. sectionauthor:: Parth Pancholi <parth.pancholi@toradex.com>
+
+Verdin AM62P Module
+==================
+
+- SoM: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62p
+- Carrier board: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
+
+Quick Start
+-----------
+
+- Setup environment variables
+- Get binary-only TI Linux firmware
+- Build the ARM trusted firmware binary
+- Build the OPTEE binary
+- Build U-Boot for the R5
+- Build U-Boot for the A53
+- Flash to eMMC
+- Boot
+
+Setup environment
+-----------------
+
+Suggested current toolchains are ARM 11.3 (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads):
+
+- https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
+- https://developer.arm.com/-/media/Files/downloads/gnu/11.3.rel1/binrel/arm-gnu-toolchain-11.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE_32=<path/to/arm/toolchain/bin/>arm-none-linux-gnueabihf-
+    $ export CROSS_COMPILE_64=<path/to/arm64/toolchain/bin/>aarch64-none-linux-gnu-
+
+Get the TI Linux Firmware
+-------------------------
+
+.. code-block:: bash
+
+    $ echo "Downloading TI Linux Firmware..."
+    $ git clone -b ti-linux-firmware https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
+
+Get and Build the ARM Trusted Firmware (Trusted Firmware A)
+-----------------------------------------------------------
+
+.. code-block:: bash
+
+    $ echo "Downloading and building TF-A..."
+    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+    $ cd trusted-firmware-a
+
+Then build ATF (TF-A):
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE="$CROSS_COMPILE_64"
+    $ make PLAT=k3 K3_PM_SYSTEM_SUSPEND=1 TARGET_BOARD=lite SPD=opteed
+
+Get and Build OPTEE
+-------------------
+
+.. code-block:: bash
+
+    $ echo "Downloading and building OPTEE..."
+    $ git clone https://github.com/OP-TEE/optee_os.git
+    $ cd optee_os
+
+Then build OPTEE:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE="$CROSS_COMPILE_32"
+    $ export CROSS_COMPILE64="$CROSS_COMPILE_64"
+    $ make PLATFORM=k3-am62px CFG_ARM64_core=y
+
+Build U-Boot for R5
+-------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE="$CROSS_COMPILE_32"
+    $ export BINMAN_INDIRS=<path/to/ti-linux-firmware>
+    $ make O=/tmp/verdin-am62p-r5 verdin-am62p_r5_defconfig
+    $ make O=/tmp/verdin-am62p-r5
+
+Build U-Boot for A53
+--------------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ export BL31=<path/to/atf>/build/k3/lite/release/bl31.bin
+    $ export TEE=<path/to/optee>/out/arm-plat-k3/core/tee-pager_v2.bin
+    $ export BINMAN_INDIRS="<path/to/ti-linux-firmware> /tmp/verdin-am62p-r5"
+    $ make O=/tmp/verdin-am62p-a53 verdin-am62p_a53_defconfig
+    $ make O=/tmp/verdin-am62p-a53
+
+Flash to eMMC
+-------------
+
+.. code-block:: console
+
+    => mmc dev 0 1
+    => fatload mmc 1 ${loadaddr} tiboot3.bin
+    => mmc write ${loadaddr} 0x0 0x400
+    => fatload mmc 1 ${loadaddr} tispl.bin
+    => mmc write ${loadaddr} 0x400 0x1000
+    => fatload mmc 1 ${loadaddr} u-boot.img
+    => mmc write ${loadaddr} 0x1400 0x2000
+
+As a convenience, instead of having to remember all those addresses and sizes,
+one may also use the update U-Boot wrappers:
+
+.. code-block:: console
+
+    => tftpboot ${loadaddr} tiboot3.bin
+    => run update_tiboot3
+
+    => tftpboot ${loadaddr} tispl.bin
+    => run update_tispl
+
+    => tftpboot ${loadaddr} u-boot.img
+    => run update_uboot
+
+Boot
+----
+
+Output:
+
+.. code-block:: console
+
+U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:46:57 +0100)
+SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+Changed A53 CPU frequency to 1250000000Hz (U grade) in DT
+SPL initial stack usage: 17080 bytes
+Trying to boot from MMC1
+Authentication passed
+Authentication passed
+Authentication passed
+Loading Environment from nowhere... OK
+init_env from device 9 not supported!
+Authentication passed
+Authentication passed
+Starting ATF on ARM64 core...
+
+NOTICE:  BL31: v2.12.0(release):v2.12.0-1106-g4301798db096
+NOTICE:  BL31: Built : 10:57:58, May  9 2025
+I/TC:
+I/TC: OP-TEE version: 4.6.0-18-g76d920d354df (gcc version 12.3.1 20230626 (Arm GNU Toolchain 12.3.Rel1 (Build arm-12.35))) #4 Tue May  6 19:48:13 UTC 2025 aarch64
+I/TC: WARNING: This OP-TEE configuration might be insecure!
+I/TC: WARNING: Please check https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
+I/TC: Primary CPU initializing
+I/TC: GIC redistributor base address not provided
+I/TC: Assuming default GIC group status and modifier
+I/TC: SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+I/TC: Activated SA2UL device
+I/TC: Enabled firewalls for SA2UL TRNG device
+I/TC: SA2UL TRNG initialized
+I/TC: SA2UL Drivers initialized
+I/TC: HUK Initialized
+I/TC: Primary CPU switching to normal world boot
+
+U-Boot SPL 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
+SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
+SPL initial stack usage: 1760 bytes
+HW CFG: 0x00
+Trying to boot from MMC1
+Authentication passed
+Authentication passed
+
+
+U-Boot 2025.04-00006-g51dc98d36470 (May 12 2025 - 15:47:54 +0100)
+
+SoC:   AM62PX SR1.0 HS-FS
+DRAM:  2 GiB
+Core:  147 devices, 31 uclasses, devicetree: separate
+MMC:   mmc@fa10000: 0, mmc@fa00000: 1
+Loading Environment from MMC... Reading from MMC(0)... OK
+In:    serial@2800000
+Out:   serial@2800000
+Err:   serial@2800000
+Model: Toradex 0099 Verdin AM62P Quad 2GB WB IT V1.0A
+Serial#: 15664919
+Carrier: Toradex Dahlia V1.1D, Serial# 11287149
+am65_cpsw_nuss ethernet@8000000: K3 CPSW: nuss_ver: 0x6BA01903 cpsw_ver: 0x6BA81903 ale_ver: 0x00290105 Ports:2
+Setting variant to wifi
+Net:
+Warning: ethernet@8000000port@1 MAC addresses don't match:
+Address in ROM is               58:a1:5f:b8:93:f9
+Address in environment is       00:14:2d:ef:07:17
+eth0: ethernet@8000000port@1 [PRIME]Could not get PHY for mdio@f00: addr 7
+am65_cpsw_nuss_port ethernet@8000000port@2: phy_connect() failed
+
+Hit any key to stop autoboot:  0
+Verdin AM62P #
+
diff --git a/include/configs/verdin-am62p.h b/include/configs/verdin-am62p.h
new file mode 100644
index 000000000000..eef360ee9b66
--- /dev/null
+++ b/include/configs/verdin-am62p.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Configuration header file for Verdin AM62P SoM
+ *
+ * Copyright 2025 Toradex - https://www.toradex.com/
+ */
+
+#ifndef __VERDIN_AM62P_H
+#define __VERDIN_AM62P_H
+
+/* DDR Configuration */
+#define CFG_SYS_SDRAM_BASE	0x80000000
+#define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */
+
+#endif /* __VERDIN_AM62P_H */
-- 
2.34.1

