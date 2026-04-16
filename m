Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05599F8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:47:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC61384214;
	Thu, 16 Apr 2026 10:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnigMvtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C66A841D5; Thu, 16 Apr 2026 10:47:27 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E408407E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso91975235e9.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776329243; x=1776934043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MEu99eCQvPziLBMxwc4YYZjDT42Yzl5Tx8rDkzcJfV0=;
 b=hnigMvtqK0vUaIyXrHXyIIWNwYx3vwVvIS8dju7lFiEx5HHrhdYszhWzLpYLf8hctL
 xTl292JEHs/5PtIhrCxmSPB1hV9KjHpDP3162qYW/22XqOBewyTd9+osA+5u0HNA4BCg
 n9VxLw5yy7fIRSEtNLO0xvEh9XaVZ++AGiTd4yDPRrcuofsnJGb3etKK7Xo3wP3GsxOw
 aYuhAH3TcrkyriMxmlvIp5D5zP7kES6BDjXr2vaq9c1q9ctRIs22ET+8Q4K0aHK8nTOU
 JZqnyZV/vRKD7idS1TEJiNUVr8jSJ2xsbg4KOAPX7aLlYkTTM5frNryAtYwMYeN824o6
 ZEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776329243; x=1776934043;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MEu99eCQvPziLBMxwc4YYZjDT42Yzl5Tx8rDkzcJfV0=;
 b=V6ilSLoOisLbPpImeEv7xcOhd1sFFdWQiqAFBDuTaWWokpkmVA4gCj+NxQ42AxOICf
 f2uh8W86+LZE9/t+iV0TQBGi1lYItqAc8A0GsDMZZbZ5HE0OiYYlZjPEKmfc9fOVe+Dg
 pEeEp6DXSkl7oLuRCrttlH7OyIuWZnQjveoN+NpBO2YPw7uD2lgTvaBpNRCp/6/VIAMA
 YxEg9DxAMF4fjKZqPLxs7iZqPH5dB8MnOBD3L6p3Tj7vsTBN5m5mB9DoUN0zbx3bU1fn
 HycDbFnAngkdL9fgqIRjocn9hjII6RZmZ3tvIEmFlNAS6r5R4l4JvFOL9xdd1mp1HMxm
 ZLmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XHqVqAxQvmwybQtmvLfB4zp6rhH4K6du/VjjMRQ/Lifuz6hL5YLFoUJHfTdvuig79E8ICEQ8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb9jldtpgjmeHcD7PbomzpnKWaQ3LmDdY+qSI/txJceEF1x1EK
 hqABxVF5MGKnBGc+vMWviQ0ltxgIsxmfN/yctZ2zFYvlctGyhwNJYqnp
X-Gm-Gg: AeBDievy/+pfzdk0jLCyKN470JU8KGLV3aJDXYG8lhdHIz+dZrq/4hSouXef6HbG+B+
 nWwNON7FcE43oQ+d+otXY/KAgBju1BINTZB9loKyy3AvPxQKrtkzBAWstzD9f9G4zSeaUXMSVLR
 CcM77kjMk9X/6pBA1MfMQxzGqNK0XubOrRKY4pCE0HiuK4ibxNLS9LD/LOaGu5ItOzllmcSa1yG
 6MjbOViOa6PV9gtlmPPtmSwx3kvL42PSoR/nlKajBTtKRgb+ydwTMPBWfiKA7AE+K7L6KcxnRzu
 kHgTcYYFPbT85V81+n8izErinLcpBoghizhY5ocgRDS0CY/O6wzVm/cHxTeQxGoIbE7WPke0Hc1
 wYkTo1MM24jwQG/JEgqG19kS5tNRoesdOLLC09OtCbciqkX10oR9zHSVHWdhR1zMAZjgMvBRaw2
 3hi+Mtm0QEQNxV31V7lsfXR5jvKU6X/Udhfs6Q5m85w8td/ZCujkWzojG4CZNcFkGMBZUR/SEwI
 adZed1PpDfBCg6Xaa5QW8IV23LP7x6/RkszlGIe5KbFXa0d
X-Received: by 2002:a05:600c:5298:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-488d688687cmr353753045e9.26.1776329242440; 
 Thu, 16 Apr 2026 01:47:22 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm13391674f8f.10.2026.04.16.01.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 01:47:21 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: [PATCH v1 2/3] board: toradex: add Toradex Verdin iMX95
Date: Thu, 16 Apr 2026 10:45:24 +0200
Message-ID: <20260416084535.1490476-3-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
References: <20260416084535.1490476-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add support for the Toradex Verdin iMX95.

Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/dts/imx95-verdin-dev.dtsi            |  239 ++++
 .../arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi |  112 ++
 arch/arm/dts/imx95-verdin-wifi-dev.dts        |   21 +
 arch/arm/dts/imx95-verdin-wifi.dtsi           |   50 +
 arch/arm/dts/imx95-verdin.dtsi                | 1172 +++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |    5 +
 board/toradex/verdin-imx95/Kconfig            |   36 +
 board/toradex/verdin-imx95/MAINTAINERS        |   13 +
 board/toradex/verdin-imx95/Makefile           |    8 +
 board/toradex/verdin-imx95/spl.c              |   75 ++
 board/toradex/verdin-imx95/verdin-imx95.c     |   79 ++
 board/toradex/verdin-imx95/verdin-imx95.env   |   20 +
 configs/verdin-imx95_defconfig                |  183 +++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/verdin-imx95.rst            |  171 +++
 include/configs/verdin-imx95.h                |   27 +
 16 files changed, 2212 insertions(+)
 create mode 100644 arch/arm/dts/imx95-verdin-dev.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin-wifi-dev.dts
 create mode 100644 arch/arm/dts/imx95-verdin-wifi.dtsi
 create mode 100644 arch/arm/dts/imx95-verdin.dtsi
 create mode 100644 board/toradex/verdin-imx95/Kconfig
 create mode 100644 board/toradex/verdin-imx95/MAINTAINERS
 create mode 100644 board/toradex/verdin-imx95/Makefile
 create mode 100644 board/toradex/verdin-imx95/spl.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.c
 create mode 100644 board/toradex/verdin-imx95/verdin-imx95.env
 create mode 100644 configs/verdin-imx95_defconfig
 create mode 100644 doc/board/toradex/verdin-imx95.rst
 create mode 100644 include/configs/verdin-imx95.h

diff --git a/arch/arm/dts/imx95-verdin-dev.dtsi b/arch/arm/dts/imx95-verdin-dev.dtsi
new file mode 100644
index 000000000000..803480eef476
--- /dev/null
+++ b/arch/arm/dts/imx95-verdin-dev.dtsi
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Common dtsi for Verdin iMX95 SoM on development carrier board
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
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
+			clocks = <&scmi_clk IMX95_CLK_SAI3>;
+			sound-dai = <&nau8822_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+	};
+};
+
+/* Verdin ADC_1, ADC_2, ADC_3 and ADC_4 */
+&adc1 {
+	status = "okay";
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&enetc_port0 {
+	status = "okay";
+};
+
+/* Verdin ETH_2_RGMII */
+&enetc_port1 {
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+/* Verdin QSPI_1 */
+&flexspi1 {
+	status = "okay";
+};
+
+&gpio1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio1>,
+		    <&pinctrl_gpio2>,
+		    <&pinctrl_gpio3>;
+};
+
+&gpio3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio6>;
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio5>;
+};
+
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio4>;
+};
+
+/* Verdin I2C_3_HDMI */
+&i3c2 {
+	status = "okay";
+};
+
+/* Verdin I2C_2_DSI */
+&lpi2c3 {
+	status = "okay";
+};
+
+/* Verdin I2C_1 */
+&lpi2c4 {
+	status = "okay";
+
+	nau8822_1a: audio-codec@1a {
+		compatible = "nuvoton,nau8822";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai3_mclk>;
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
+/* Verdin I2C_4_CSI */
+&lpi2c5 {
+	status = "okay";
+};
+
+/* Verdin UART_3, used as the Linux console */
+&lpuart1 {
+	status = "okay";
+};
+
+/* Verdin UART_4 */
+&lpuart2 {
+	status = "okay";
+};
+
+/* Verdin UART_1, connector X50 through RS485 transceiver */
+&lpuart7 {
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+	linux,rs485-enabled-at-boot-time;
+
+	status = "okay";
+};
+
+/* Verdin UART_2 */
+&lpuart8 {
+	status = "okay";
+};
+
+&netc_emdio {
+	ethphy2: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_eth2_rgmii_int>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <0>;
+	};
+};
+
+/* Verdin PCIE_1 */
+&pcie0 {
+	status = "okay";
+};
+
+/* Verdin I2S_1 */
+&sai3 {
+	status = "okay";
+};
+
+/* Verdin PWM_1 */
+&tpm4 {
+	status = "okay";
+};
+
+/* Verdin PWM_2 */
+&tpm5 {
+	status = "okay";
+};
+
+/* Verdin PWM_3_DSI */
+&tpm6 {
+	status = "okay";
+};
+
+/* Verdin USB_1 */
+&usb2 {
+	status = "okay";
+};
+
+/* Verdin USB_2 */
+&usb3 {
+	fsl,permanently-attached;
+
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	status = "okay";
+};
+
+/* Verdin CTRL_WAKE1_MICO# */
+&verdin_gpio_keys {
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
new file mode 100644
index 000000000000..83802156d523
--- /dev/null
+++ b/arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/* Copyright (c) Toradex */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem} {
+	filename = "lpddr4x_imem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem} {
+	filename = "lpddr4x_dmem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb} {
+	filename = "lpddr4x_imem_qb_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb} {
+	filename = "lpddr4x_dmem_qb_v202409.bin";
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400000 0 0x40>;
+	bootph-pre-ram;
+
+	ctrl-sleep-moci-hog {
+		bootph-pre-ram;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_sleep_moci>;
+		gpio-hog;
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpios = <14 GPIO_ACTIVE_HIGH>;
+		line-name = "CTRL_SLEEP_MOCI#";
+		output-high;
+	};
+};
+
+&som_gpio_expander {
+	bootph-pre-ram;
+};
+
+&lpi2c2 {
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+&pinctrl_ctrl_sleep_moci {
+	bootph-pre-ram;
+};
+
+&pinctrl_io_exp_int {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&som_gpio_expander {
+	bootph-pre-ram;
+};
+
+&usb2 {
+	/delete-property/power-domains;
+};
+
+&usb3 {
+	status = "disabled";
+};
+
+&usb3_dwc3 {
+	status = "disabled";
+};
+
+&usb_recov_ctrl {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx95-verdin-wifi-dev.dts b/arch/arm/dts/imx95-verdin-wifi-dev.dts
new file mode 100644
index 000000000000..345d37247025
--- /dev/null
+++ b/arch/arm/dts/imx95-verdin-wifi-dev.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
+ * https://www.toradex.com/products/carrier-board/verdin-development-board-kit
+ */
+
+/dts-v1/;
+
+#include "imx95-verdin.dtsi"
+#include "imx95-verdin-wifi.dtsi"
+#include "imx95-verdin-dev.dtsi"
+
+/ {
+	model = "Toradex Verdin iMX95 WB on Verdin Development Board";
+	compatible = "toradex,verdin-imx95-wifi-dev",
+		     "toradex,verdin-imx95-wifi",
+		     "toradex,verdin-imx95",
+		     "fsl,imx95";
+};
diff --git a/arch/arm/dts/imx95-verdin-wifi.dtsi b/arch/arm/dts/imx95-verdin-wifi.dtsi
new file mode 100644
index 000000000000..256c9ed04605
--- /dev/null
+++ b/arch/arm/dts/imx95-verdin-wifi.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Common dtsi for Verdin iMX95 SoM WB variant
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
+ */
+
+/ {
+	reg_wifi_en: regulator-wifi-en {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_wifi_pwr_en>;
+		/* PMIC_EN_WIFI */
+		gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "PDn_MAYA-W260";
+		startup-delay-us = <2000>;
+	};
+};
+
+/* On-module Bluetooth */
+&lpuart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_bt_uart>;
+	uart-has-rtscts;
+
+	status = "okay";
+
+	som_bt: bluetooth {
+		compatible = "nxp,88w8987-bt";
+		fw-init-baudrate = <3000000>;
+	};
+};
+
+/* On-module Wi-Fi */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	keep-power-in-suspend;
+	non-removable;
+	vmmc-supply = <&reg_wifi_en>;
+
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx95-verdin.dtsi b/arch/arm/dts/imx95-verdin.dtsi
new file mode 100644
index 000000000000..29cd4b91a16c
--- /dev/null
+++ b/arch/arm/dts/imx95-verdin.dtsi
@@ -0,0 +1,1172 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Common dtsi for Verdin iMX95 SoM
+ *
+ * https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy-imx8-pcie.h>
+#include "imx95.dtsi"
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		eeprom0 = &som_eeprom;
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		i2c0 = &lpi2c2;
+		i2c1 = &lpi2c4;
+		i2c2 = &lpi2c3;
+		i2c3 = &i3c2;
+		i2c4 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		rtc0 = &rtc_i2c;
+		rtc1 = &scmi_bbm;
+		serial0 = &lpuart7;
+		serial1 = &lpuart8;
+		serial2 = &lpuart1;
+		serial3 = &lpuart2;
+		serial4 = &lpuart6;
+		usb0 = &usb2;
+		usb1 = &usb3;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		/* Verdin USB_1_ID (SODIMM 161) */
+		id-gpios = <&som_gpio_expander 5 GPIO_ACTIVE_HIGH>;
+		label = "USB_1";
+		self-powered;
+		vbus-supply = <&reg_usb1_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb1_id>;
+			};
+		};
+	};
+
+	verdin_gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ctrl_wake1_mico>;
+
+		status = "disabled";
+
+		verdin_key_wakeup: key-wakeup {
+			/* Verdin CTRL_WAKE1_MICO# (SODIMM 252) */
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-module +V1.8";
+	};
+
+	/*
+	 * By default we enable CTRL_SLEEP_MOCI#, this is required to have
+	 * peripherals on the carrier board powered.
+	 * If more granularity or power saving is required this can be disabled
+	 * in the carrier board device tree files.
+	 */
+	reg_force_sleep_moci: regulator-force-sleep-moci {
+		compatible = "regulator-fixed";
+		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
+		gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "CTRL_SLEEP_MOCI#";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		/* Verdin USB_1_EN (SODIMM 155) */
+		gpios = <&som_gpio_expander 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_1_EN";
+	};
+
+	reg_usb2_vbus: regulator-usb2-vbus {
+		compatible = "regulator-fixed";
+		/* Verdin USB_2_EN (SODIMM 185) */
+		gpios = <&som_gpio_expander 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_2_EN";
+	};
+
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
+		gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		regulator-name = "PMIC_SD2_VSEL";
+	};
+
+	reg_usdhc2_vmmc: regulator-vmmc-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
+		/* Verdin SD_1_PWR_EN (SODIMM 76) */
+		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "SD_1_PWR_EN";
+		startup-delay-us = <20000>;
+	};
+
+	cm7: remoteproc-cm7 {
+		compatible = "fsl,imx95-cm7";
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&mu7 0 1
+			  &mu7 1 1
+			  &mu7 3 1>;
+		memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+				<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>, <&m7_reserved>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux_cma: linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x3c000000>;
+			alloc-ranges = <0 0x80000000 0 0x7F000000>;
+			linux,cma-default;
+		};
+
+		m7_reserved: memory@80000000 {
+			reg = <0 0x80000000 0 0x1000000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@88000000 {
+			reg = <0 0x88000000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@88008000 {
+			reg = <0 0x88008000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@88010000 {
+			reg = <0 0x88010000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@88018000 {
+			reg = <0 0x88018000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@88020000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x88020000 0 0x100000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@88220000 {
+			reg = <0 0x88220000 0 0x1000>;
+			no-map;
+		};
+	};
+};
+
+/* Verdin ADC_1, ADC_2, ADC_3 and ADC_4 */
+&adc1 {
+	vref-supply = <&reg_1p8v>;
+};
+
+/* Verdin ETH_1 (On-module PHY) */
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>;
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+};
+
+/* Verdin ETH_2_RGMII */
+&enetc_port1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc1>;
+};
+
+/* Verdin CAN_1 */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+/* Verdin CAN_2 */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+/* Verdin QSPI_1 */
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+};
+
+&gpio1 {
+	gpio-line-names =
+		"", /* 0 */
+		"",
+		"",
+		"",
+		"SODIMM_147",
+		"SODIMM_149",
+		"SODIMM_151",
+		"SODIMM_153",
+		"SODIMM_20",
+		"SODIMM_22",
+		"SODIMM_252", /* 10 */
+		"",
+		"SODIMM_189",
+		"IO_EXP_INT",
+		"SODIMM_256",
+		"";
+
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"SODIMM_206", /* 0 */
+		"SODIMM_198",
+		"SODIMM_200",
+		"SODIMM_196",
+		"",
+		"SODIMM_15",
+		"SODIMM_16",
+		"",
+		"SODIMM_131",
+		"SODIMM_129",
+		"SODIMM_135", /* 10 */
+		"SODIMM_133",
+		"SODIMM_139",
+		"SODIMM_137",
+		"SODIMM_143",
+		"SODIMM_141",
+		"SODIMM_30",
+		"SODIMM_38",
+		"SODIMM_208",
+		"SODIMM_19",
+		"SODIMM_36", /* 20 */
+		"SODIMM_34",
+		"SODIMM_93",
+		"SODIMM_95",
+		"SODIMM_210",
+		"SODIMM_24",
+		"SODIMM_32",
+		"SODIMM_26",
+		"SODIMM_53",
+		"SODIMM_55",
+		"SODIMM_12", /* 30 */
+		"SODIMM_14";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"SODIMM_84", /* 0 */
+		"SODIMM_78",
+		"SODIMM_74",
+		"SODIMM_80",
+		"SODIMM_82",
+		"SODIMM_70",
+		"SODIMM_72",
+		"SODIMM_76",
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
+		"PMIC_SD2_VSEL",
+		"", /* 20 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"SODIMM_91",
+		"SODIMM_218",
+		"",
+		"",
+		"", /* 30 */
+		"";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"SODIMM_59", /* 0 */
+		"SODIMM_57",
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
+		"SODIMM_193",
+		"SODIMM_191",
+		"SODIMM_215",
+		"SODIMM_217",
+		"SODIMM_219",
+		"SODIMM_221",
+		"SODIMM_211", /* 20 */
+		"SODIMM_213",
+		"SODIMM_199",
+		"SODIMM_197",
+		"SODIMM_201",
+		"SODIMM_203",
+		"SODIMM_205",
+		"SODIMM_207",
+		"SODIMM_216",
+		"SODIMM_202";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"SODIMM_56", /* 0 */
+		"SODIMM_58",
+		"SODIMM_60",
+		"SODIMM_62",
+		"SODIMM_46",
+		"SODIMM_44",
+		"SODIMM_42",
+		"SODIMM_48",
+		"SODIMM_66",
+		"SODIMM_52",
+		"SODIMM_54", /* 10 */
+		"SODIMM_64",
+		"SODIMM_212",
+		"",
+		"",
+		"",
+		"",
+		"";
+};
+
+/* Verdin I2C_3_HDMI */
+&i3c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i3c2>;
+	i2c-scl-hz = <400000>;
+};
+
+/* CTRL_I2C (On-module I2C) */
+&lpi2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>, <&pinctrl_io_exp_int>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>, <&pinctrl_io_exp_int>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
+
+	status = "okay";
+
+	som_gpio_expander: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+			"SODIMM_220", /* 0 */
+			"SODIMM_222",
+			"SODIMM_17",
+			"SODIMM_21",
+			"SODIMM_244",
+			"SODIMM_161",
+			"SODIMM_157",
+			"SODIMM_155",
+			"SODIMM_185",
+			"SODIMM_187",
+			"USB_RECOV_CTRL#", /* 10 */
+			"ENET1_INT#",
+			"TPM_INT#",
+			"TPM_CS#",
+			"",
+			"";
+
+		/*
+		 * Switch USB to default position:
+		 *   - SoC USB2 -> Verdin USB_1
+		 *   - SoC USB1 -> Verdin USB_2
+		 * Reset configuration:
+		 *   - SoC USB1 -> Verdin USB_1 (USB recovery)
+		 *   - SoC USB2 not connected
+		 */
+		usb_recov_ctrl: usb-recov-ctrl-hog {
+			gpio-hog;
+			gpios = <10 GPIO_ACTIVE_HIGH>;
+			line-name = "USB_RECOV_CTRL#";
+			output-high;
+		};
+	};
+
+	rtc_i2c: rtc@32 {
+		compatible = "epson,rx8130";
+		reg = <0x32>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp1075";
+		reg = <0x48>;
+	};
+
+	som_eeprom: eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/* Verdin I2C_2_DSI */
+&lpi2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
+};
+
+/* Verdin I2C_1 */
+&lpi2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c4>;
+	pinctrl-1 = <&pinctrl_lpi2c4_gpio>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
+};
+
+/* Verdin I2C_4_CSI */
+&lpi2c5 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	single-master;
+};
+
+/* Verdin SPI_1 */
+&lpspi6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi6>, <&pinctrl_spi1_cs>;
+	cs-gpios = <&gpio4 29 GPIO_ACTIVE_LOW>,
+		   <&som_gpio_expander 13 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+
+	som_tpm: tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		interrupt-parent = <&som_gpio_expander>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		/*
+		 * Maximum TPM-supported speed is 18.5 MHz, limited to 12 MHz
+		 * here as lpspi6's per-clock (twice the max speed) is 24 MHz
+		 */
+		spi-max-frequency = <12000000>;
+	};
+};
+
+/* Verdin UART_3, used as the Linux console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+/* Verdin UART_4 */
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+};
+
+/* Verdin UART_1 */
+&lpuart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	uart-has-rtscts;
+};
+
+/* Verdin UART_2 */
+&lpuart8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart8>, <&pinctrl_uart8_cts>, <&pinctrl_uart8_rts>;
+	uart-has-rtscts;
+};
+
+&mu7 {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_bus0 {
+	msi-map = <0x0 &its 0x60 0x1>,	//ENETC0 PF
+		  <0x10 &its 0x61 0x1>, //ENETC0 VF0
+		  <0x20 &its 0x62 0x1>, //ENETC0 VF1
+		  <0x40 &its 0x63 0x1>, //ENETC1 PF
+		  <0x50 &its 0x65 0x1>, //ENETC1 VF0
+		  <0x60 &its 0x66 0x1>, //ENETC1 VF1
+		  <0x80 &its 0x64 0x1>, //ENETC2 PF
+		  <0xc0 &its 0x67 0x1>; //NETC Timer
+	iommu-map = <0x0 &smmu 0x20 0x1>,
+		    <0x10 &smmu 0x21 0x1>,
+		    <0x20 &smmu 0x22 0x1>,
+		    <0x40 &smmu 0x23 0x1>,
+		    <0x50 &smmu 0x25 0x1>,
+		    <0x60 &smmu 0x26 0x1>,
+		    <0x80 &smmu 0x24 0x1>,
+		    <0xc0 &smmu 0x27 0x1>;
+};
+
+/* Verdin ETH_2_RGMII_MDIO, shared between all ethernet ports */
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+
+	status = "okay";
+
+	ethphy1: ethernet-phy@0 {
+		reg = <0>;
+		interrupt-parent = <&som_gpio_expander>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+};
+
+&netc_timer {
+	status = "okay";
+};
+
+&netcmix_blk_ctrl {
+	status = "okay";
+};
+
+/* Verdin PCIE_1 */
+&pcie0 {
+	/* PCIE_1_RESET# (SODIMM 244) */
+	reset-gpios = <&som_gpio_expander 4 GPIO_ACTIVE_LOW>;
+};
+
+/* Verdin I2S_1 */
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai3>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>, <393216000>,
+			       <361267200>, <12288000>;
+	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
+};
+
+&scmi_bbm {
+	linux,code = <KEY_POWER>;
+};
+
+&thermal_zones {
+	/* PF09 Main PMIC */
+	pf09-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 2>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_ARM PMIC */
+	pf53-arm-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 4>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+
+	/* PF53 VDD_SOC PMIC */
+	pf53-soc-thermal {
+		polling-delay = <2000>;
+		polling-delay-passive = <250>;
+		thermal-sensors = <&scmi_sensor 3>;
+
+		trips {
+			trip0 {
+				hysteresis = <2000>;
+				temperature = <155000>;
+				type = "critical";
+			};
+		};
+	};
+};
+
+/* Verdin PWM_1 */
+&tpm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm4>;
+};
+
+/* Verdin PWM_2 */
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm5>;
+};
+
+/* Verdin PWM_3_DSI */
+&tpm6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tpm6>;
+};
+
+/* Verdin USB_1 */
+&usb2 {
+	dr_mode = "otg";
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	vbus-supply = <&reg_usb1_vbus>;
+
+	port {
+		usb1_id: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+/* Verdin USB_2 */
+&usb3 {
+	fsl,disable-port-power-control;
+};
+
+&usb3_dwc3 {
+	dr_mode = "host";
+};
+
+&usb3_phy {
+	vbus-supply = <&reg_usb2_vbus>;
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+
+	status = "okay";
+};
+
+/* Verdin SD_1 */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_usdhc2_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	/* On-module Bluetooth on WB SKUs, module-specific UART otherwise */
+	pinctrl_bt_uart: btuartgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO04__LPUART6_TX	0x31e>, /* WiFi_UART_SoC_TXD */
+			   <IMX95_PAD_GPIO_IO33__LPUART6_RX	0x31e>, /* WiFi_UART_SoC_RXD */
+			   <IMX95_PAD_GPIO_IO34__LPUART6_CTS_B	0x31e>, /* WiFi_UART_SoC_CTS */
+			   <IMX95_PAD_GPIO_IO07__LPUART6_RTS_B	0x31e>; /* WiFi_UART_SoC_RTS */
+	};
+
+	/* Verdin CSI_1_MCLK */
+	pinctrl_csi1_mclk: csi1mclkgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1	0x51e>; /* SODIMM 91 */
+	};
+
+	/* Verdin CTRL_SLEEP_MOCI# */
+	pinctrl_ctrl_sleep_moci: ctrlsleepmocigrp {
+		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14	0x51e>; /* SODIMM 256 */
+	};
+
+	/* Verdin CTRL_WAKE1_MICO# */
+	pinctrl_ctrl_wake1_mico: ctrlwake1micogrp {
+		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10	0x31e>; /* SODIMM 252 */
+	};
+
+	/* Verdin ETH_2_RGMII_MDIO, shared between all ethernet ports */
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__NETCMIX_TOP_NETC_MDC	0x50e>, /* ENET2_MDC, SODIMM 193 */
+			   <IMX95_PAD_ENET2_MDIO__NETCMIX_TOP_NETC_MDIO	0x90e>; /* ENET2_MDIO, SODIMM 191 */
+	};
+
+	/* Verdin ETH_1 (On-module PHY) */
+	pinctrl_enetc0: enetc0grp {
+		fsl,pins = <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>, /* ENET1_TX_CTL */
+			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>, /* ENET1_TXC    */
+			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e>, /* ENET1_TDO    */
+			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e>, /* ENET1_TD1    */
+			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e>, /* ENET1_TD2    */
+			   <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e>, /* ENET1_TD3    */
+			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>, /* ENET1_RX_CTL */
+			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>, /* ENET1_RXC    */
+			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>, /* ENET1_RD0    */
+			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>, /* ENET1_RD1    */
+			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>, /* ENET1_RD2    */
+			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>; /* ENET1_RD3    */
+	};
+
+	/* Verdin ETH_2_RGMII */
+	pinctrl_enetc1: enetc1grp {
+		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e>, /* ENET2_TX_CTL */
+			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK		0x58e>, /* ENET2_TXC    */
+			   <IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x50e>, /* ENET2_TD0    */
+			   <IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x50e>, /* ENET2_TD1    */
+			   <IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x50e>, /* ENET2_TD2    */
+			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x50e>, /* ENET2_TD3    */
+			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e>, /* ENET2_RX_CTL */
+			   <IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK		0x58e>, /* ENET2_RXC    */
+			   <IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e>, /* ENET2_RD0    */
+			   <IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e>, /* ENET2_RD1    */
+			   <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e>, /* ENET2_RD2    */
+			   <IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e>; /* ENET2_RD3    */
+	};
+
+	/* Verdin ETH_2_RGMII_INT#  */
+	pinctrl_eth2_rgmii_int: eth2rgmiiintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_GPIO1_IO_BIT12	0x31e>; /* SODIMM 189 */
+	};
+
+	/* Verdin CAN_1 */
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* SODIMM 20 */
+			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* SODIMM 22 */
+	};
+
+	/* Verdin CAN_2 */
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* SODIMM 24 */
+			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* SODIMM 26 */
+	};
+
+	/* Verdin QSPI_1 */
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B	0x3fe>, /* SODIMM 54 */
+			   <IMX95_PAD_XSPI1_SS1_B__FLEXSPI1_A_SS1_B	0x3fe>, /* SODIMM 64 */
+			   <IMX95_PAD_XSPI1_SCLK__XSPI_CLK		0x3fe>, /* SODIMM 52 */
+			   <IMX95_PAD_XSPI1_DATA0__XSPI_DATA_BIT0	0x3fe>, /* SODIMM 56 */
+			   <IMX95_PAD_XSPI1_DATA1__XSPI_DATA_BIT1	0x3fe>, /* SODIMM 58 */
+			   <IMX95_PAD_XSPI1_DATA2__XSPI_DATA_BIT2	0x3fe>, /* SODIMM 60 */
+			   <IMX95_PAD_XSPI1_DATA3__XSPI_DATA_BIT3	0x3fe>, /* SODIMM 62 */
+			   <IMX95_PAD_XSPI1_DQS__XSPI_DQS		0x3fe>; /* SODIMM 66 */
+	};
+
+	/* Verdin GPIO_1 */
+	pinctrl_gpio1: gpio1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0	0x51e>; /* SODIMM 206 */
+	};
+
+	/* Verdin GPIO_2 */
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18	0x51e>; /* SODIMM 208 */
+	};
+
+	/* Verdin GPIO_3 */
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO24__GPIO2_IO_BIT24	0x51e>; /* SODIMM 210 */
+	};
+
+	/* Verdin GPIO_4 */
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO32__GPIO5_IO_BIT12	0x51e>; /* SODIMM 212 */
+	};
+
+	/* Verdin GPIO_5_CSI */
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28	0x51e>; /* SODIMM 216 */
+	};
+
+	/* Verdin GPIO_6_CSI */
+	pinctrl_gpio6: gpio6grp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO2__GPIO3_IO_BIT27	0x51e>; /* SODIMM 218 */
+	};
+
+	/* Verdin I2S_2_BCLK as GPIO (conflict with Verdin I2S_2) */
+	pinctrl_i2s_2_bclk_gpio: i2s2bclkgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA6__GPIO5_IO_BIT6	0x51e>; /* SODIMM 42 */
+	};
+
+	/* Verdin I2S_2_D_IN as GPIO (conflict with Verdin I2S_2) */
+	pinctrl_i2s_2_d_in_gpio: i2s2dingpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA7__GPIO5_IO_BIT7	0x31e>; /* SODIMM 48 */
+	};
+
+	/* Verdin I2S_2_D_OUT as GPIO (conflict with Verdin I2S_2) */
+	pinctrl_i2s_2_d_out_gpio: i2s2doutgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA4__GPIO5_IO_BIT4	0x51e>; /* SODIMM 46 */
+	};
+
+	/* Verdin I2S_2_SYNC as GPIO (conflict with Verdin I2S_2) */
+	pinctrl_i2s_2_sync_gpio: i2s2syncgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA5__GPIO5_IO_BIT5	0x51e>; /* SODIMM 44 */
+	};
+
+	/* Verdin I2C_3_HDMI */
+	pinctrl_i3c2: i3c2cgrp {
+		fsl,pins = <IMX95_PAD_ENET1_MDC__I3C2_SCL	0x40001186>, /* SODIMM 59 */
+			   <IMX95_PAD_ENET1_MDIO__I3C2_SDA	0x40001186>; /* SODIMM 57 */
+	};
+
+	pinctrl_io_exp_int: ioexpintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_GPIO1_IO_BIT13	0x31e>; /* IO_EXP_INT */
+	};
+
+	/* CTRL_I2C (On-module I2C) */
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* CTRL_I2C_SCL */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* CTRL_I2C_SDA */
+	};
+
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* CTRL_I2C_SCL */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* CTRL_I2C_SDA */
+	};
+
+	/* Verdin I2C_2_DSI */
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* SODIMM 53 */
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* SODIMM 55 */
+	};
+
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* SODIMM 53 */
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* SODIMM 55 */
+	};
+
+	/* Verdin I2C_1 */
+	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>, /* SODIMM 14 */
+			   <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>; /* SODIMM 12 */
+	};
+
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>, /* SODIMM 14 */
+			   <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>; /* SODIMM 12 */
+	};
+
+	/* Verdin I2C_4_CSI */
+	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* SODIMM 93 */
+			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* SODIMM 95 */
+	};
+
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* SODIMM 93 */
+			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* SODIMM 95 */
+	};
+
+	/* Verdin SPI_1 */
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO01__LPSPI6_SIN	0x3fe>, /* SODIMM 198 */
+			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT	0x3fe>, /* SODIMM 200 */
+			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK	0x3fe>; /* SODIMM 196 */
+	};
+
+	/* Verdin QSPI_1_CLK as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_clk_gpio: qspi1clkgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9		0x11e>; /* SODIMM 52 */
+	};
+
+	/* Verdin QSPI_1_CS2# as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_cs2_gpio: qspi1cs2gpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x11e>; /* SODIMM 64 */
+	};
+
+	/* Verdin QSPI_1_CS# as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_cs_gpio: qspi1csgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10	0x11e>; /* SODIMM 54 */
+	};
+
+	/* Verdin QSPI_1_DQS as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_dqs_gpio: qspi1dqsgpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8		0x11e>; /* SODIMM 66 */
+	};
+
+	/* Verdin QSPI_1_IO0 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io0_gpio: qspi1io0gpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0	0x119e>; /* SODIMM 56 */
+	};
+
+	/* Verdin QSPI_1_IO1 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io1_gpio: qspi1io1gpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1	0x119e>; /* SODIMM 58 */
+	};
+
+	/* Verdin QSPI_1_IO2 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io2_gpio: qspi1io2gpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2	0x11e>; /* SODIMM 60 */
+	};
+
+	/* Verdin QSPI_1_IO3 as GPIO (conflict with Verdin QSPI_1 interface) */
+	pinctrl_qspi1_io3_gpio: qspi1io3gpiogrp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3	0x11e>; /* SODIMM 62 */
+	};
+
+	/* Verdin I2S_1 */
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x11e>, /* SODIMM 30 */
+			   <IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0	0x11e>, /* SODIMM 36 */
+			   <IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0	0x11e>, /* SODIMM 34 */
+			   <IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x11e>; /* SODIMM 32 */
+	};
+
+	/* Verdin I2S_1_MCLK */
+	pinctrl_sai3_mclk: sai3mclkgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO17__SAI3_MCLK	0x31e>; /* SODIMM 38 */
+	};
+
+	/* Verdin I2S_2 */
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0	0x11e>, /* SODIMM 46 */
+			   <IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC		0x11e>, /* SODIMM 44 */
+			   <IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK		0x11e>, /* SODIMM 42 */
+			   <IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0	0x11e>; /* SODIMM 48 */
+	};
+
+	/* Verdin SPI_1_CS */
+	pinctrl_spi1_cs: spi1csgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO4__GPIO4_IO_BIT29	0x3fe>; /* SODIMM 202 */
+	};
+
+	/* Verdin PWM_1 */
+	pinctrl_tpm4: tpm4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO05__TPM4_CH0	0x11e>; /* SODIMM 15 */
+	};
+
+	/* Verdin PWM_2 */
+	pinctrl_tpm5: tpm5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* SODIMM 16 */
+	};
+
+	/* Verdin PWM_3_DSI as GPIO */
+	pinctrl_tpm6_gpio: tpm6gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO19__GPIO2_IO_BIT19	0x51e>; /* SODIMM 19 */
+	};
+
+	/* Verdin PWM_3_DSI */
+	pinctrl_tpm6: tpm6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO19__TPM6_CH2	0x11e>; /* SODIMM 19 */
+	};
+
+	/* Verdin UART_3, used as the Linux Console */
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>, /* SODIMM 147 */
+			   <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>; /* SODIMM 149 */
+	};
+
+	/* Verdin UART_4 */
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX	0x31e>, /* SODIMM 151 */
+			   <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX	0x31e>; /* SODIMM 153 */
+	};
+
+	/* Verdin UART_1 */
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__LPUART7_TX	0x31e>, /* SODIMM 131 */
+			   <IMX95_PAD_GPIO_IO09__LPUART7_RX	0x31e>, /* SODIMM 129 */
+			   <IMX95_PAD_GPIO_IO10__LPUART7_CTS_B	0x31e>, /* SODIMM 135 */
+			   <IMX95_PAD_GPIO_IO11__LPUART7_RTS_B	0x31e>; /* SODIMM 133 */
+	};
+
+	/* Verdin UART_2 CTS */
+	pinctrl_uart8_cts: uart8ctsgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART8_CTS_B	0x31e>; /* SODIMM 143 */
+	};
+
+	/* Verdin UART_2 RTS */
+	pinctrl_uart8_rts: uart8rtsgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO15__LPUART8_RTS_B	0x31e>; /* SODIMM 141 */
+	};
+
+	/* Verdin UART_2 RX/TX */
+	pinctrl_uart8: uart8grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__LPUART8_TX	0x31e>, /* SODIMM 139 */
+			   <IMX95_PAD_GPIO_IO13__LPUART8_RX	0x31e>; /* SODIMM 137 */
+	};
+
+	/* On-module eMMC */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* SD1_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* SD1_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* SD1_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* SD1_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* SD1_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* SD1_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* SD1_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* SD1_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* SD1_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* SD1_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* SD1_STROBE */
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* SD1_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* SD1_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* SD1_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* SD1_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* SD1_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* SD1_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* SD1_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* SD1_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* SD1_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* SD1_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* SD1_STROBE */
+	};
+
+	/* Verdin SD_1 */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x158e>, /* SODIMM 78 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x138e>, /* SODIMM 74 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x138e>, /* SODIMM 80 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x138e>, /* SODIMM 82 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x138e>, /* SODIMM 70 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x138e>; /* SODIMM 72 */
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x15fe>, /* SODIMM 78 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x13fe>, /* SODIMM 74 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe>, /* SODIMM 80 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe>, /* SODIMM 82 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe>, /* SODIMM 70 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe>; /* SODIMM 72 */
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x400>, /* SODIMM 78 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x400>, /* SODIMM 74 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x400>, /* SODIMM 80 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x400>, /* SODIMM 82 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x400>, /* SODIMM 70 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x400>; /* SODIMM 72 */
+	};
+
+	/* Verdin SD_1_CD# */
+	pinctrl_usdhc2_cd: usdhc2-cdgrp {
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* SODIMM 84 */
+	};
+
+	/* Verdin SD_1_PWR_EN */
+	pinctrl_usdhc2_pwr_en: usdhc2-pwrengrp {
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* SODIMM 76 */
+	};
+
+	pinctrl_usdhc2_vsel: usdhc2-vselgrp {
+		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x4>; /* PMIC_SD2_VSEL */
+	};
+
+	/* On-module Wi-Fi on WB SKUs, module-specific SDIO otherwise */
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x158e>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x138e>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x138e>, /* SD3_DATA0 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x138e>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x138e>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x138e>; /* SD3_DATA3 */
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x15fe>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x13fe>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe>, /* SD3_DATA3 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe>; /* SD3_DATA4 */
+	};
+
+	pinctrl_wifi_pwr_en: wifipwrengrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x51e>; /* PMIC_EN_WIFI */
+	};
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 2308457df23e..27e887213a8c 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -171,6 +171,10 @@ config TARGET_TORADEX_SMARC_IMX95
 	select IMX95
 	imply OF_UPSTREAM
 
+config TARGET_VERDIN_IMX95
+	bool "Support Toradex Verdin iMX95 module"
+	select IMX95
+
 config TARGET_IMX952_EVK
 	bool "imx952_evk"
 	select IMX_SM_CPU
@@ -195,6 +199,7 @@ source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
+source "board/toradex/verdin-imx95/Kconfig"
 source "board/nxp/imx952_evk/Kconfig"
 
 endif
diff --git a/board/toradex/verdin-imx95/Kconfig b/board/toradex/verdin-imx95/Kconfig
new file mode 100644
index 000000000000..ef4206c343c0
--- /dev/null
+++ b/board/toradex/verdin-imx95/Kconfig
@@ -0,0 +1,36 @@
+if TARGET_VERDIN_IMX95
+
+config SYS_BOARD
+	default "verdin-imx95"
+
+config SYS_VENDOR
+	default "toradex"
+
+config SYS_CONFIG_NAME
+	default "verdin-imx95"
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
diff --git a/board/toradex/verdin-imx95/MAINTAINERS b/board/toradex/verdin-imx95/MAINTAINERS
new file mode 100644
index 000000000000..d19ee3ebfe5d
--- /dev/null
+++ b/board/toradex/verdin-imx95/MAINTAINERS
@@ -0,0 +1,13 @@
+Verdin iMX95
+F:	arch/arm/dts/imx95-verdin.dtsi
+F:	arch/arm/dts/imx95-verdin-dev.dtsi
+F:	arch/arm/dts/imx95-verdin-wifi.dtsi
+F:	arch/arm/dts/imx95-verdin-wifi-dev.dts
+F:	arch/arm/dts/imx95-verdin-wifi-dev-u-boot.dtsi
+F:	board/toradex/verdin-imx95/
+F:	configs/verdin-imx95_defconfig
+F:	doc/board/toradex/verdin-imx95.rst
+F:	include/configs/verdin-imx95.h
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
+S:	Maintained
+W:	https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
diff --git a/board/toradex/verdin-imx95/Makefile b/board/toradex/verdin-imx95/Makefile
new file mode 100644
index 000000000000..bc1b6811bbec
--- /dev/null
+++ b/board/toradex/verdin-imx95/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Toradex
+
+obj-y += verdin-imx95.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/toradex/verdin-imx95/spl.c b/board/toradex/verdin-imx95/spl.c
new file mode 100644
index 000000000000..9f501c11c1d8
--- /dev/null
+++ b/board/toradex/verdin-imx95/spl.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <asm/global_data.h>
+#include <clk.h>
+#include <dm/uclass.h>
+#include <hang.h>
+#include <i2c.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+	if (IS_ENABLED(CONFIG_SPL_RECOVER_DATA_SECTION))
+		spl_save_restore_data();
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls */
+	spl_early_init();
+
+	/* Need to enable SCMI drivers and ELE driver before console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* MU not probed, nothing can be outputed, hang */
+
+	arch_cpu_init();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/board/toradex/verdin-imx95/verdin-imx95.c b/board/toradex/verdin-imx95/verdin-imx95.c
new file mode 100644
index 000000000000..8f7ada7a8215
--- /dev/null
+++ b/board/toradex/verdin-imx95/verdin-imx95.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <env.h>
+#include <errno.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <stdio.h>
+#include <string.h>
+
+#include "../common/tdx-cfg-block.h"
+#include "../common/tdx-common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void select_dt_from_module_version(void)
+{
+	char variant[32];
+	char *env_variant = env_get("variant");
+	bool is_wifi = false;
+
+	if (IS_ENABLED(CONFIG_TDX_CFG_BLOCK)) {
+		/*
+		 * If we have a valid config block and it says we are a
+		 * module with Wi-Fi/Bluetooth make sure we use the -wifi
+		 * device tree.
+		 */
+		is_wifi = (tdx_hw_tag.prodid == VERDIN_IMX95H_8G_WIFI_BT_IT);
+	}
+
+	if (is_wifi)
+		strlcpy(&variant[0], "wifi", sizeof(variant));
+	else
+		strlcpy(&variant[0], "nonwifi", sizeof(variant));
+
+	if (!env_variant || strcmp(variant, env_variant)) {
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
+const struct ram_alias_check ram_alias_check[] = {
+	{ (void *)(PHYS_SDRAM + SZ_8G), (void *)(PHYS_SDRAM), SZ_16G },
+	{ (void *)(PHYS_SDRAM + SZ_4G), (void *)(PHYS_SDRAM), SZ_8G },
+	{ (void *)(PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
+	{ (void *)(PHYS_SDRAM + SZ_1G), (void *)(PHYS_SDRAM), SZ_2G },
+	{ NULL }
+};
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t sz;
+
+	sz = probe_ram_size_by_alias(ram_alias_check);
+	if (!sz) {
+		puts("## WARNING: Less than 2GB RAM detected\n");
+		return -EINVAL;
+	}
+
+	*size = sz - PHYS_SDRAM_FW_RSVD;
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF_LIBFDT) && IS_ENABLED(CONFIG_OF_BOARD_SETUP)
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/toradex/verdin-imx95/verdin-imx95.env b/board/toradex/verdin-imx95/verdin-imx95.env
new file mode 100644
index 000000000000..5ca6cb18aaaa
--- /dev/null
+++ b/board/toradex/verdin-imx95/verdin-imx95.env
@@ -0,0 +1,20 @@
+boot_scripts=boot.scr
+boot_script_dhcp=boot.scr
+boot_targets=mmc1 mmc0 dhcp
+console=ttyLP2
+fdt_board=dev
+fdt_addr=0x9c400000
+fdt_addr_r=0x9c400000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0x94400000
+kernel_comp_size=0x8000000
+ramdisk_addr_r=0x9c800000
+scriptaddr=0x9c600000
+
+update_uboot=
+		askenv confirm Did you load flash.bin (y/N)?;
+		if test "$confirm" = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt
+			${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0
+			${blkcnt};
+		fi
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
new file mode 100644
index 000000000000..6dbf921e64be
--- /dev/null
+++ b/configs/verdin-imx95_defconfig
@@ -0,0 +1,183 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0xFFFFDE00
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imx95-verdin-wifi-dev"
+CONFIG_TARGET_VERDIN_IMX95=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTDELAY=1
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -b"
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx95-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_LOG=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="Verdin iMX95 # "
+CONFIG_CMD_ASKENV=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_READ=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BOOTCOUNT=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_SYSBOOT=y
+CONFIG_CMD_UUID=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_SCMI=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_EMMC_HW_PARTITION=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_VERSION_VARIABLE=y
+CONFIG_PROT_UDP=y
+CONFIG_IP_DEFRAG=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ENV=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x90400000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
+CONFIG_GPIO_HOG=y
+CONFIG_SPL_GPIO_HOG=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_I2C_EEPROM=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY_IMX8MQ_USB=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_DWC3=y
+# CONFIG_USB_DWC3_GADGET is not set
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_ULP_WATCHDOG=y
+# CONFIG_SPL_SHA1 is not set
+CONFIG_LZO=y
+CONFIG_HEXDUMP=y
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 27f059542e6a..2a45bde6991a 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -16,3 +16,4 @@ Toradex
    verdin-am62p
    verdin-imx8mm
    verdin-imx8mp
+   verdin-imx95
diff --git a/doc/board/toradex/verdin-imx95.rst b/doc/board/toradex/verdin-imx95.rst
new file mode 100644
index 000000000000..d252277cc208
--- /dev/null
+++ b/doc/board/toradex/verdin-imx95.rst
@@ -0,0 +1,171 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Verdin iMX95 Module
+==========================
+
+- SoM: https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx95
+- Carrier board: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
+
+Quick Start
+-----------
+
+- Setup environment
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Setup environment
+-----------------
+
+Suggested current toolchains are ARM 14.3 (https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads):
+
+- https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-arm-none-linux-gnueabihf.tar.xz
+- https://developer.arm.com/-/media/Files/downloads/gnu/14.3.rel1/binrel/arm-gnu-toolchain-14.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz
+
+.. code-block:: console
+
+    $ export TOOLS=<path/to/directory/with/toolchains>
+    $ export CROSS_COMPILE_32=<path/to/arm/toolchain/bin/>arm-none-linux-gnueabihf-
+    $ export CROSS_COMPILE_64=<path/to/arm64/toolchain/bin/>aarch64-none-linux-gnu-
+
+Get ahab-container.img
+----------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+    $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+    $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+---------------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+    $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
+
+Get and Build OEI Images
+------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get OEI from: https://git.toradex.com/cgit/imx-oei-toradex.git/
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://git.toradex.com/cgit/imx-oei-toradex.git/
+    $ cd imx-oei-toradex
+
+    $ make board=toradex-verdin-imx95 oei=ddr DEBUG=1 r=B0 all
+    $ cp build/toradex-verdin-imx95/ddr/oei-m33-ddr.bin $(srctree)
+
+The Makefile will set `DDR_CONFIG` automatically based on the selected silicon
+revision.
+
+Get and Build the System Manager Image
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get System Manager from: https://git.toradex.com/cgit/imx-sm-toradex.git/
+branch: main
+
+.. code-block:: console
+
+    $ git clone -b main https://git.toradex.com/cgit/imx-sm-toradex.git/
+    $ cd imx-sm-toradex
+    $ make config=verdin-imx95 all
+    $ cp build/verdin-imx95/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.12
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ unset LDFLAGS
+    $ unset AS
+    $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
+    $ cd imx-atf
+    $ make PLAT=imx95 bl31
+    $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ make verdin-imx95_defconfig
+    $ make
+
+Flash to eMMC
+-------------
+
+.. code-block:: console
+
+    > tftpboot ${loadaddr} flash.bin
+    > setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0x200
+    > mmc dev 0 1 && mmc write ${loadaddr} 0x0 ${blkcnt}
+
+As a convenience, instead of the last two commands, one may also use the update
+U-Boot wrapper:
+
+.. code-block:: console
+
+    > run update_uboot
+
+Boot
+----
+
+Boot sequence is:
+
+* SPL ---> ATF (TF-A) ---> U-Boot proper
+
+Output:
+
+.. code-block:: console
+
+    U-Boot SPL 2026.04-00756-ge7053d7cab88 (Apr 15 2026 - 12:27:34 +0200)
+    SYS Boot reason: pmic, origin: -1, errid: -1
+    SYS shutdown reason: pmic, origin: -1, errid: -1
+    Trying to boot from MMC1
+    Primary set selected
+    Load image from MMC/SD 0xca000
+    NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0
+    NOTICE:  BL31: Built : 17:34:12, Oct 21 2025
+
+
+    U-Boot 2026.04-00756-ge7053d7cab88 (Apr 15 2026 - 12:27:34 +0200)
+
+    CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz - invalid sensor data
+    DRAM:  7.8 GiB
+    Core:  323 devices, 28 uclasses, devicetree: separate
+    MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
+    Loading Environment from MMC... Reading from MMC(0)... OK
+    In:    serial@44380000
+    Out:   serial@44380000
+    Err:   serial@44380000
+    Model: Toradex 0089 Verdin iMX95 Hexa 8GB WB IT V1.0B
+    Serial#: 12594936
+
+    BuildInfo:
+      - ELE firmware version 2.0.2-2a118457
+
+    Setting variant to wifi
+    Net:   No ethernet found.
+    Hit any key to stop autoboot: 0
+    Verdin iMX95 #
diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
new file mode 100644
index 000000000000..044975410064
--- /dev/null
+++ b/include/configs/verdin-imx95.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Toradex */
+
+#ifndef __VERDIN_IMX95_H
+#define __VERDIN_IMX95_H
+
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+/* For 32GB modules: 2GB from 0x80000000..0xffffffff, 30GB above.
+ * Actual size is determited at runtime.
+ */
+#define SZ_30G	_AC(0x780000000, ULL)
+
+/* The first 256MB of SDRAM is reserved for firmware (Cortex M7) */
+#define PHYS_SDRAM_FW_RSVD	SZ_256M
+#define CFG_SYS_INIT_RAM_ADDR	PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_SIZE	SZ_2M
+
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM
+#define PHYS_SDRAM		(0x80000000 + PHYS_SDRAM_FW_RSVD)
+#define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
+#define PHYS_SDRAM_2_SIZE	SZ_30G
+
+#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
+
+#endif
-- 
2.43.0

