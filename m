Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBD0CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 10:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B9A82A9E;
	Mon, 27 Oct 2025 11:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8NOozof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA3B982C7F; Mon, 27 Oct 2025 11:59:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C49F80107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 11:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b472842981fso610043466b.1
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761562773; x=1762167573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PuO+87WD7Bs69dVskhbpak8Z+BifPXMl4MEvnG1Kbb4=;
 b=m8NOozof2di9gU356CeeympM9FS2G5pBsWjqo1ufKmenaHRrppUg94aCl364/Ib6Lp
 kyB2h5DI4UXEn3xlTrcLizSS3MHVN+cpCW1+t8jEOIRnpFpRSu5YmDmcf+SEZkxjpeBF
 jabbzc/PBi0zJyEAN6y7caIStla82jn5Vli+TBA8bZsJY0tanHWsNFSlcpEYYEkWIbmB
 1nWvIYZ+4/mhKdDRWOWKg4+D5ZRhP5aTUosbpmqtUZcGlMzt+QeoXhu8vM89mTZGDh5/
 XZUCjhVytUIEN640oBI4xOeUh38rlCz6f17CeRTpwVrhWW+bUwWs4teG2MMXCL8je71V
 IZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761562773; x=1762167573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuO+87WD7Bs69dVskhbpak8Z+BifPXMl4MEvnG1Kbb4=;
 b=DankW4oJmMEc9xgkvobrrIDMvZ5YgcKqAeOlFJhF7xXcNyjBo/8XqNmxHx8APQZYr1
 a2br4RhnBCBua5BLGd6ZYX85I+TWL4wGyF84xG4iLCtD3CkmgWol/O0gHWxxDQkssdUd
 w6VultI/zFXn0nI9WU1n+6hdaghuKxU9xlALDCacstZRebygr9QV6LOCCf4lXxS/AL3w
 p6Uf33YnZ0wZhkBu3z7Tjp8qZTrokEWRSOCpGjh1JUCeMvPIRGmSre6wg5+gotKt7kjf
 DaJOOx/o9qhhBE/RsoXwObd6tvGBbDatki3pWyLUH18B0UPnYalvpb/YN3Seev7ajlAf
 sM1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk80HDsQein9enGi8cdbSmVNqvNEgMm94In9z3wHtKJufb6YM4swrUPX1iEvHL1GpCYZsOTmM=@lists.denx.de
X-Gm-Message-State: AOJu0YyPD2Dy6mW/Evg6xMCt4nyA7qFTQyTPAbp6YuTnzkHJkdb+hNFU
 r3NVV/FUj32hGAtxLg0vYBDUobNtPSDkVQSfxUmus1SzSzk6a7YjlJ4A
X-Gm-Gg: ASbGncvEkdjLCBrqc38GV9oLdcDngxTUfLA32LJttBBddz0S4x5D8oakiRiVjKzPEZB
 VgyQvgrZSR557DXeOZvozxxQHuUPHKvym9qMhsc89+ViYhbfCqfbKBVFAPGx1hLlTuQPfdHMIMu
 pmK1StYh5wPKOTK3kJRrUtHCRZB0dMgRr6HgxoLwYHi4SDneyGaICWiCykXJDcFIlP04l6THUXs
 CwE1mqQqT1mE1KO1hVYO5Qs5eSBpdV6X5okphDDnKVGG6/Xcq7/FHrX6vip4XuoqNMAbSYFaNBM
 Lsr29b0r8epsu0aB1LYq1ngtapZbVM9Vlet5WqK86eauIIjY6kY7sgq3tqwz4Hy4pyVohkxwPew
 t5Fm87geg4N1Ok2KBuj5RPHscr7p4I5jdPic0gwRjFhcIGtYhEPhtyddWSIzxxaPz7jApASuCuh
 Z5G7atmFL2+3QTcqL1DvVNFroOpzd+JvTH94THBl4XjpSK0cInQM3AgO/yugZXuAcpXbnC8PG4P
 d5AY2rkuGnVrFLgxijqQnA=
X-Google-Smtp-Source: AGHT+IHpmIFCP9aKnYByotSMmYNAdL95JH35FNQahY6uXpOqs8ZwjFslUu5QQpXn8o7SMfA1Somw+g==
X-Received: by 2002:a17:906:eecc:b0:b57:8477:8754 with SMTP id
 a640c23a62f3a-b6471f3b8ffmr4583309466b.21.1761562772333; 
 Mon, 27 Oct 2025 03:59:32 -0700 (PDT)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85309069sm715512866b.10.2025.10.27.03.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 03:59:31 -0700 (PDT)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Ye Li <ye.li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 u-boot@lists.denx.de, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Subject: [PATCH v1] board: toradex: add Toradex SMARC iMX95
Date: Mon, 27 Oct 2025 11:58:57 +0100
Message-ID: <20251027105859.258497-1-ernestvanhoecke@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add support for the Toradex SMARC iMX95.

Link: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Co-developed-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
Device tree is being upstreamed to Linux. [1] Later, we can switch to
OF_UPSTREAM.

[1]: https://lore.kernel.org/all/20251024144921.77714-3-francesco@dolcini.it/
---
 .../dts/imx95-toradex-smarc-dev-u-boot.dtsi   |  110 ++
 arch/arm/dts/imx95-toradex-smarc-dev.dts      |  277 ++++
 arch/arm/dts/imx95-toradex-smarc.dtsi         | 1153 +++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |    5 +
 board/toradex/smarc-imx95/Kconfig             |   36 +
 board/toradex/smarc-imx95/MAINTAINERS         |   11 +
 board/toradex/smarc-imx95/Makefile            |    8 +
 board/toradex/smarc-imx95/smarc-imx95.c       |   31 +
 board/toradex/smarc-imx95/smarc-imx95.env     |   20 +
 board/toradex/smarc-imx95/spl.c               |  119 ++
 configs/toradex-smarc-imx95_defconfig         |  172 +++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/smarc-imx95.rst             |  172 +++
 include/configs/toradex-smarc-imx95.h         |   24 +
 14 files changed, 2139 insertions(+)
 create mode 100644 arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-toradex-smarc-dev.dts
 create mode 100644 arch/arm/dts/imx95-toradex-smarc.dtsi
 create mode 100644 board/toradex/smarc-imx95/Kconfig
 create mode 100644 board/toradex/smarc-imx95/MAINTAINERS
 create mode 100644 board/toradex/smarc-imx95/Makefile
 create mode 100644 board/toradex/smarc-imx95/smarc-imx95.c
 create mode 100644 board/toradex/smarc-imx95/smarc-imx95.env
 create mode 100644 board/toradex/smarc-imx95/spl.c
 create mode 100644 configs/toradex-smarc-imx95_defconfig
 create mode 100644 doc/board/toradex/smarc-imx95.rst
 create mode 100644 include/configs/toradex-smarc-imx95.h

diff --git a/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
new file mode 100644
index 000000000000..97ce7402e503
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/* Copyright (C) 2025 Toradex */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&lpi2c4 {
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+/* Conflict with JTAG interface */
+&lpuart5 {
+	status = "disabled";
+};
+
+&pinctrl_lpi2c4 {
+	bootph-pre-ram;
+};
+
+&pinctrl_lpi2c4_gpio {
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
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_cd {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_pwr_en {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_vsel {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vqmmc {
+	bootph-pre-ram;
+};
+
+&som_gpio_expander_0 {
+	bootph-pre-ram;
+};
+
+&som_gpio_expander_1 {
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
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/dts/imx95-toradex-smarc-dev.dts b/arch/arm/dts/imx95-toradex-smarc-dev.dts
new file mode 100644
index 000000000000..5b05f256fd52
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-smarc-dev.dts
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
+ * https://www.toradex.com/products/carrier-board/smarc-development-board-kit
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/pwm/pwm.h>
+#include "imx95-toradex-smarc.dtsi"
+
+/ {
+	model = "Toradex SMARC iMX95 on Toradex SMARC Development Board";
+	compatible = "toradex,smarc-imx95-dev",
+		     "toradex,smarc-imx95",
+		     "fsl,imx95";
+
+	reg_carrier_1p8v: regulator-carrier-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-carrier 1V8";
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "tdx-smarc-wm8904";
+		simple-audio-card,routing =
+			"Headphone Jack", "HPOUTL",
+			"Headphone Jack", "HPOUTR",
+			"IN2L", "Line In Jack",
+			"IN2R", "Line In Jack",
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Headphone", "Headphone Jack",
+			"Line", "Line In Jack";
+
+		codec_dai: simple-audio-card,codec {
+			clocks = <&scmi_clk IMX95_CLK_SAI3>;
+			sound-dai = <&wm8904_1a>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+	};
+};
+
+/* SMARC GBE0 */
+&enetc_port0 {
+	status = "okay";
+};
+
+/* SMARC GBE1 */
+&enetc_port1 {
+	status = "okay";
+};
+
+/* SMARC CAN0 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* SMARC CAN1 */
+&flexcan2 {
+	status = "okay";
+};
+
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio12>, <&pinctrl_gpio13>;
+};
+
+&gpio4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio10>, <&pinctrl_gpio11>;
+};
+
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>,
+		    <&pinctrl_gpio3>,
+		    <&pinctrl_gpio4>,
+		    <&pinctrl_gpio6>,
+		    <&pinctrl_gpio8>,
+		    <&pinctrl_gpio9>;
+};
+
+/* SMARC I2C_CAM0 */
+&i2c_cam0 {
+	status = "okay";
+};
+
+/* SMARC I2C_CAM1 */
+&i2c_cam1 {
+	status = "okay";
+};
+
+/* SMARC I2C_GP */
+&lpi2c2 {
+	status = "okay";
+
+	wm8904_1a: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sai3>, <&pinctrl_sai3_mclk>;
+		#sound-dai-cells = <0>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		clock-names = "mclk";
+		AVDD-supply = <&reg_carrier_1p8v>;
+		CPVDD-supply = <&reg_carrier_1p8v>;
+		DBVDD-supply = <&reg_carrier_1p8v>;
+		DCVDD-supply = <&reg_carrier_1p8v>;
+		MICVDD-supply = <&reg_carrier_1p8v>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+
+};
+
+/* SMARC I2C_PM */
+&lpi2c3 {
+	clock-frequency = <100000>;
+	status = "okay";
+
+	fan_controller: fan@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+		#pwm-cells = <2>;
+
+		fan {
+			cooling-levels = <255>;
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+
+	/* Current measurement into module VCC */
+	hwmon@40 {
+		compatible = "ti,ina226";
+		reg = <0x40>;
+		shunt-resistor = <5000>;
+	};
+};
+
+/* SMARC I2C_LCD */
+&lpi2c5 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* I2C on DSI Connector Pins 4/6 */
+		i2c_dsi_0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* I2C on DSI Connector Pins 52/54 */
+		i2c_dsi_1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMARC SPI0 */
+&lpspi6 {
+	status = "okay";
+};
+
+/* SMARC SER1, used as the Linux Console */
+&lpuart1 {
+	status = "okay";
+};
+
+/* SMARC SER0, RS485 */
+&lpuart2 {
+	linux,rs485-enabled-at-boot-time;
+	rs485-rts-active-low;
+	rs485-rx-during-tx;
+	status = "okay";
+};
+
+/* SMARC SER3, RS232 */
+&lpuart3 {
+	status = "okay";
+};
+
+/* SMARC MDIO, shared between all ethernet ports */
+&netc_emdio {
+	status = "okay";
+
+	ethphy3: ethernet-phy@4 {
+		reg = <4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio7>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+/* SMARC PCIE_A / M2 Key B */
+&pcie0 {
+	status = "okay";
+};
+
+/* SMARC PCIE_B /  M2 Key E */
+&pcie1 {
+	status = "okay";
+};
+
+/* SMARC I2S0 */
+&sai3 {
+	status = "okay";
+};
+
+/* SMARC LCD0_BKLT_PWM */
+&tpm3 {
+	status = "okay";
+};
+
+/* SMARC LCD1_BKLT_PWM */
+&tpm4 {
+	status = "okay";
+};
+
+/* SMARC GPIO5 as PWM */
+&tpm5 {
+	status = "okay";
+};
+
+/* SMARC USB0 */
+&usb2 {
+	status = "okay";
+};
+
+/* SMARC USB1..4 */
+&usb3 {
+	status = "okay";
+};
+
+&usb3_dwc3 {
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+/* SMARC SDIO */
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx95-toradex-smarc.dtsi b/arch/arm/dts/imx95-toradex-smarc.dtsi
new file mode 100644
index 000000000000..e99f1a57af8c
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-smarc.dtsi
@@ -0,0 +1,1153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2025 Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/net/ti-dp83867.h>
+#include "imx95.dtsi"
+
+/ {
+	aliases {
+		can0 = &flexcan1;
+		can1 = &flexcan2;
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		rtc0 = &rtc_i2c;
+		rtc1 = &scmi_bbm;
+		serial0 = &lpuart2;
+		serial1 = &lpuart1;
+		serial3 = &lpuart3;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+
+	clk_dsi2dp_bridge: clock-dsi2dp-bridge {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+	};
+
+	clk_serdes_eth_ref: clock-eth-ref {
+		compatible = "gpio-gate-clock";
+		#clock-cells = <0>;
+		/* CTRL_ETH_REF_CLK_STBY# */
+		enable-gpios = <&som_gpio_expander_1 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		/* SMARC P64 - USB0_OTG_ID */
+		id-gpios = <&som_gpio_expander_0 3 GPIO_ACTIVE_HIGH>;
+		label = "USB0";
+		self-powered;
+		type = "micro";
+		vbus-supply = <&reg_usb0_vbus>;
+
+		port {
+			usb_dr_connector: endpoint {
+				remote-endpoint = <&usb0_otg_id>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		smarc_key_sleep: key-sleep {
+			gpios = <&som_ec_gpio_expander 4 GPIO_ACTIVE_LOW>;
+			label = "SMARC_SLEEP#";
+			wakeup-source;
+			linux,code = <KEY_SLEEP>;
+		};
+
+		smarc_switch_lid: switch-lid {
+			gpios = <&som_ec_gpio_expander 2 GPIO_ACTIVE_LOW>;
+			label = "SMARC_LID#";
+			linux,code = <SW_LID>;
+			linux,input-type = <EV_SW>;
+		};
+	};
+
+	reg_module_1p8v: regulator-module-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-module +V1.8";
+	};
+
+	/* Non PMIC On-module Supplies */
+	reg_module_dp_1p2v: regulator-module-dp-1p2v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1200000>;
+		regulator-min-microvolt = <1200000>;
+		regulator-name = "On-module +V1.2_DP";
+		vin-supply = <&reg_module_1p8v>;
+	};
+
+	reg_usb0_vbus: regulator-usb0-vbus {
+		compatible = "regulator-fixed";
+		/* SMARC P62 - USB0_EN_OC# */
+		gpios = <&som_gpio_expander_0 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB0_EN_OC#";
+	};
+
+	reg_usb1_vbus: regulator-usb1-vbus {
+		compatible = "regulator-fixed";
+		/* CTRL_V_BUS_USB_HUB or SMARC P71 - USB2_EN_OC# */
+		gpios = <&som_gpio_expander_0 6 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "CTRL_V_BUS_USB_HUB";
+	};
+
+	reg_usdhc2_vmmc: regulator-vmmc-usdhc2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
+		enable-active-high;
+		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "SDIO_PWR_EN";
+		startup-delay-us = <20000>;
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
+	reg_wifi_en: regulator-wifi-en {
+		compatible = "regulator-fixed";
+		/* CTRL_EN_WIFI */
+		gpios = <&som_gpio_expander_1 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "CTRL_EN_WIFI";
+		startup-delay-us = <2000>;
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
+	};
+};
+
+/* SMARC GBE0 */
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc0>, <&pinctrl_enetc0_1588_tmr>;
+	phy-handle = <&ethphy1>;
+	phy-mode = "rgmii-id";
+};
+
+/* SMARC GBE1 */
+&enetc_port1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enetc1>, <&pinctrl_enetc1_1588_tmr>;
+	phy-handle = <&ethphy2>;
+	phy-mode = "rgmii-id";
+};
+
+/* SMARC CAN0 */
+&flexcan1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+};
+
+/* SMARC CAN1 */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+};
+
+&gpio1 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "SMARC_I2C_GP_CK",
+			  "SMARC_I2C_GP_DAT",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "CTRL_IO_EXP_INT_B";
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names = "SMARC_SPI0_CS0#", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO5",
+			  "",
+			  "I2C_CAM_DAT",
+			  "I2C_CAM_CK",
+			  "SMARC_GPIO12", /* 10 */
+			  "SMARC_GPIO13",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SPI1_CS0#",
+			  "",
+			  "", /* 20 */
+			  "",
+			  "SMARC_I2C_LCD_DAT",
+			  "SMARC_I2C_LCD_CK",
+			  "SMARC_SPI0_CS1#",
+			  "",
+			  "",
+			  "",
+			  "SMARC_I2C_PM_DAT",
+			  "SMARC_I2C_PM_CK",
+			  "I2C_SOM_DAT", /* 30 */
+			  "I2C_SOM_CK";
+	status = "okay";
+};
+
+&gpio3 {
+	gpio-line-names = "SMARC_SDIO_CD#", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SDIO_PWR_EN",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "PMIC_SD2_VSEL";
+	status = "okay";
+};
+
+&gpio4 {
+	gpio-line-names = "", /* 0 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 10 */
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO11",
+			  "SMARC_GPIO10",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "", /* 20 */
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_SMB_ALERT#";
+	status = "okay";
+};
+
+&gpio5 {
+	gpio-line-names = "SMARC_GPIO2", /* 0 */
+			  "SMARC_GPIO3",
+			  "SMARC_GPIO4",
+			  "SMARC_GPIO6",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SMARC_GPIO9",
+			  "SMARC_GPIO7",
+			  "SMARC_GPIO8", /* 10 */
+			  "SMARC_SPI1_CS1#",
+			  "",
+			  "SPI1_TPM_CS#";
+	status = "okay";
+};
+
+/* SMARC I2C_GP */
+&lpi2c2 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio1 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "st,24c32", "atmel,24c32";
+		reg = <0x50>;
+		pagesize = <32>;
+	};
+};
+
+/* SMARC I2C_PM */
+&lpi2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* I2C_SOM */
+&lpi2c4 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c4>, <&pinctrl_ctrl_io_exp_int_b>;
+	pinctrl-1 = <&pinctrl_lpi2c4_gpio>, <&pinctrl_ctrl_io_exp_int_b>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	som_gpio_expander_0: gpio@20 {
+		compatible = "nxp,pcal6408";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_PCIE_WAKE#", /* 0 */
+			"SMARC_PCIE_B_RST#",
+			"SMARC_PCIE_A_RST#",
+			"SMARC_USB0_OTG_ID",
+			"SMARC_USB0_EN", /* SMARC USB0_EN_OC# - Open Drain Output */
+			"SMARC_USB0_OC#", /* SMARC USB0_EN_OC# - Over-Current Sense Input */
+			"",
+			"SMARC_PCIE_C_RST#";
+	};
+
+	som_gpio_expander_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_GPIO0", /* 0 */
+			"SMARC_GPIO1",
+			"SMARC_LCD0_VDD_EN",
+			"SMARC_LCD0_BKLT_EN",
+			"SMARC_LCD1_VDD_EN",
+			"SMARC_LCD1_BKLT_EN",
+			"",
+			"",
+			"",
+			"",
+			"", /* 10 */
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"SMARC_SDIO_WP";
+	};
+
+	embedded-controller@28 {
+		compatible = "toradex,smarc-imx95-ec", "toradex,smarc-ec";
+		reg = <0x28>;
+	};
+
+	som_ec_gpio_expander: gpio@29 {
+		compatible = "toradex,ecgpiol16", "nxp,pcal6416";
+		reg = <0x29>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ec_int>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"SMARC_CHARGER_PRSNT#",
+			"SMARC_CHARGING#",
+			"SMARC_LID#",
+			"SMARC_BATLOW#",
+			"SMARC_SLEEP#";
+	};
+
+	/* SMARC DP0 */
+	som_dsi2dp_bridge: bridge@2c {
+		compatible = "ti,sn65dsi86";
+		reg = <0x2c>;
+		clocks = <&clk_dsi2dp_bridge>;
+		clock-names = "refclk";
+		vcc-supply = <&reg_module_dp_1p2v>;
+		vcca-supply = <&reg_module_dp_1p2v>;
+		vccio-supply = <&reg_module_1p8v>;
+		vpll-supply = <&reg_module_1p8v>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				sn65dsi86_in: endpoint {
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				sn65dsi86_out: endpoint {
+					data-lanes = <3 2 1 0>;
+				};
+			};
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
+	eeprom@50 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
+/* SMARC I2C_LCD */
+&lpi2c5 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	pinctrl-1 = <&pinctrl_lpi2c5_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* I2C_CAM */
+&lpi2c7 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_lpi2c7>;
+	pinctrl-1 = <&pinctrl_lpi2c7_gpio>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 9 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9543";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* SMARC I2C_CAM0 */
+		i2c_cam0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* SMARC I2C_CAM1 */
+		i2c_cam1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* SMARC SPI1 */
+&lpspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi4>;
+	cs-gpios = <&gpio2 18 GPIO_ACTIVE_LOW>,
+		   <&gpio5 11 GPIO_ACTIVE_LOW>,
+		   <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	som_tpm: tpm@2 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0x2>;
+		spi-max-frequency = <18500000>;
+	};
+};
+
+/* SMARC SPI0 */
+&lpspi6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi6>;
+	cs-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>,
+		   <&gpio2 24 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC SER1, used as the Linux Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+/* SMARC SER0 */
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	uart-has-rtscts;
+};
+
+/* SMARC SER3 */
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+};
+
+/* SMARC MDIO, shared between all ethernet ports */
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_emdio>;
+
+	ethphy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&som_gpio_expander_1>;
+		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+
+	ethphy2: ethernet-phy@2 {
+		reg = <2>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+};
+
+&netcmix_blk_ctrl {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+&netc_timer {
+	status = "okay";
+};
+
+/* SMARC PCIE_A */
+&pcie0 {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpios = <&som_gpio_expander_0 2 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC PCIE_B */
+&pcie1 {
+	pinctrl-0 = <&pinctrl_pcie1>;
+	pinctrl-names = "default";
+	reset-gpios = <&som_gpio_expander_0 1 GPIO_ACTIVE_LOW>;
+};
+
+/* SMARC I2S0 */
+&sai3 {
+	#sound-dai-cells = <0>;
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
+	fsl,sai-mclk-direction-output;
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
+/* SMARC LCD0_BKLT_PWM */
+&tpm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd0_bklt_pwm>;
+};
+
+/* SMARC LCD1_BKLT_PWM */
+&tpm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd1_bklt_pwm>;
+};
+
+/* SMARC GPIO5 as PWM */
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio5_pwm>;
+};
+
+/* SMARC USB0 */
+&usb2 {
+	adp-disable;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	vbus-supply = <&reg_usb0_vbus>;
+
+	port {
+		usb0_otg_id: endpoint {
+			remote-endpoint = <&usb_dr_connector>;
+		};
+	};
+};
+
+&usb3 {
+	fsl,disable-port-power-control;
+};
+
+/* SMARC USB1..4  */
+&usb3_dwc3 {
+	dr_mode = "host";
+};
+
+&usb3_phy {
+	vbus-supply = <&reg_usb1_vbus>;
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
+	status = "okay";
+};
+
+/* SMARC SDIO */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>,<&pinctrl_usdhc2_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
+	wp-gpios = <&som_gpio_expander_1 15 GPIO_ACTIVE_HIGH>;
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
+};
+
+&scmi_bbm {
+	linux,code = <KEY_POWER>;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	/* SMARC CAM_MCK */
+	pinctrl_cam_mck: cammckgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO1__CCMSRCGPCMIX_TOP_CLKO_1	0x51e>; /* SMARC S6 - CAM_MCK */
+	};
+
+	pinctrl_ec_int: ecintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x31e>; /* SAI1_TXFS - EC_MCU_INT# */
+	};
+
+	/* SMARC MDIO, shared between all ethernet ports */
+	pinctrl_emdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC		0x50e>, /* SMARC S45 - MDIO_CLK */
+			   <IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO		0x90e>; /* SMARC S46 - MDIO_DAT */
+	};
+
+	/* SMARC GBE0 */
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
+	/* SMARC GBE0_SDP */
+	pinctrl_enetc0_1588_tmr: enetc01588tmrgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO2__NETCMIX_TOP_NETC_TMR_1588_PP1	0x51e>; /* SMARC P6 - GBE0_SDP */
+	};
+
+	/* SMARC GBE1 */
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
+	/* SMARC GBE1_SDP */
+	pinctrl_enetc1_1588_tmr: enetc11588tmrgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO4__NETCMIX_TOP_NETC_TMR_1588_PP2	0x51e>; /* SMARC P5 - GBE1_SDP */
+	};
+
+	/* SMARC CAN0 */
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_CAN1_TX		0x39e>, /* SMARC P143 - CAN0_TX */
+			   <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_CAN1_RX	0x39e>; /* SMARC P144 - CAN0_RX */
+	};
+
+	/* SMARC CAN1 */
+	pinctrl_flexcan2: flexcan2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* SMARC P145 - CAN1_TX */
+			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* SMARC P146 - CAN1_RX */
+	};
+
+	/* SMARC GPIO2 */
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0	0x31e>; /* SMARC P110 - GPIO2 */
+	};
+
+	/* SMARC GPIO3 */
+	pinctrl_gpio3: gpio3grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1	0x31e>; /* SMARC P111 - GPIO3 */
+	};
+
+	/* SMARC GPIO4 */
+	pinctrl_gpio4: gpio4grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2	0x31e>; /* SMARC P112 - GPIO4 */
+	};
+
+	/* SMARC GPIO5 */
+	pinctrl_gpio5: gpio5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__GPIO2_IO_BIT6	0x31e>; /* SMARC P113 - GPIO5 */
+	};
+
+	/* SMARC GPIO5 as PWM */
+	pinctrl_gpio5_pwm: gpio5pwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO06__TPM5_CH0	0x11e>; /* SMARC P113 - PWM_OUT */
+	};
+
+	/* SMARC GPIO6 */
+	pinctrl_gpio6: gpio6grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3	0x31e>; /* SMARC P114 - GPIO6 */
+	};
+
+	/* SMARC GPIO7 */
+	pinctrl_gpio7: gpio7grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9 0x31e>; /* SMARC P115 - GPIO7 */
+	};
+
+	/* SMARC GPIO8 */
+	pinctrl_gpio8: gpio8grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10	0x31e>; /* SMARC P116 - GPIO8 */
+	};
+
+	/* SMARC GPIO9 */
+	pinctrl_gpio9: gpio9grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8	0x31e>; /* SMARC P117 - GPIO9 */
+	};
+
+	/* SMARC GPIO10 */
+	pinctrl_gpio10: gpio10grp {
+		fsl,pins = <IMX95_PAD_ENET2_MDIO__GPIO4_IO_BIT15	0x31e>; /* SMARC P118 - GPIO10 */
+	};
+
+	/* SMARC GPIO11 */
+	pinctrl_gpio11: gpio11grp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__GPIO4_IO_BIT14	0x31e>; /* SMARC P119 - GPIO11 */
+	};
+
+	/* SMARC GPIO12 */
+	pinctrl_gpio12: gpio12grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO10__GPIO2_IO_BIT10	0x31e>; /* SMARC S142 - GPIO12 */
+	};
+
+	/* SMARC GPIO13 */
+	pinctrl_gpio13: gpio13grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11	0x31e>; /* SMARC S123 - GPIO13 */
+	};
+
+	pinctrl_ctrl_io_exp_int_b: ioexpintgrp {
+		fsl,pins = <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_GPIO1_IO_BIT14 0x31e>; /* CTRL_IO_EXP_INT_B */
+	};
+
+	/* SMARC LCD0_BKLT_PWM */
+	pinctrl_lcd0_bklt_pwm: lcd0bkltpwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__TPM3_CH2	0x51e>; /* SMARC S141 - LCD0_BKLT_PWM */
+	};
+
+	/* SMARC LCD1_BKLT_PWM */
+	pinctrl_lcd1_bklt_pwm: lcd1bkltpwmgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO13__TPM4_CH2	0x51e>; /* SMARC S122 - LCD1_BKLT_PWM */
+	};
+
+	/* SMARC I2C_GP */
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_LPI2C2_SCL	0x40001b9e>, /* SMARC S48 - I2C_GP_CK  */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_LPI2C2_SDA	0x40001b9e>; /* SMARC S49 - I2C_GP_DAT */
+	};
+
+	/* SMARC I2C_GP as GPIOs */
+	pinctrl_lpi2c2_gpio: lpi2c2gpiogrp {
+		fsl,pins = <IMX95_PAD_I2C2_SCL__AONMIX_TOP_GPIO1_IO_BIT2	0x40001b9e>, /* SMARC S48 - I2C_GP_CK  */
+			   <IMX95_PAD_I2C2_SDA__AONMIX_TOP_GPIO1_IO_BIT3	0x40001b9e>; /* SMARC S49 - I2C_GP_DAT */
+	};
+
+	/* SMARC I2C_PM */
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* SMARC P122 - I2C_PM_DAT */
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* SMARC P121 - I2C_PM_CK  */
+	};
+
+	/* SMARC I2C_PM as GPIOs */
+	pinctrl_lpi2c3_gpio: lpi2c3gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* SMARC P122 - I2C_PM_DAT */
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* SMARC P121 - I2C_PM_CK  */
+	};
+
+	/* I2C_SOM */
+	pinctrl_lpi2c4: lpi2c4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__LPI2C4_SCL	0x40001b9e>, /* I2C_SOM_CK  */
+			   <IMX95_PAD_GPIO_IO30__LPI2C4_SDA	0x40001b9e>; /* I2C_SOM_DAT */
+	};
+
+	/* I2C_SOM as GPIOs */
+	pinctrl_lpi2c4_gpio: lpi2c4gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO31__GPIO2_IO_BIT31	0x40001b9e>, /* I2C_SOM_CK  */
+			   <IMX95_PAD_GPIO_IO30__GPIO2_IO_BIT30	0x40001b9e>; /* I2C_SOM_DAT */
+	};
+
+	/* SMARC I2C_LCD */
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* SMARC S140 - I2C_LCD_DAT */
+			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* SMARC S139 - I2C_LCD_CK  */
+	};
+
+	/* SMARC I2C_LCD as GPIOs */
+	pinctrl_lpi2c5_gpio: lpi2c5gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* SMARC S140 - I2C_LCD_DAT */
+			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* SMARC S139 - I2C_LCD_CK  */
+	};
+
+	/* I2C_CAM */
+	pinctrl_lpi2c7: lpi2c7grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__LPI2C7_SDA	0x40001b9e>, /* I2C_CAM_DAT */
+			   <IMX95_PAD_GPIO_IO09__LPI2C7_SCL	0x40001b9e>; /* I2C_CAM_CK  */
+	};
+
+	/* I2C_CAM as GPIOs */
+	pinctrl_lpi2c7_gpio: lpi2c7gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO08__GPIO2_IO_BIT8	0x40001b9e>, /* I2C_CAM_DAT */
+			   <IMX95_PAD_GPIO_IO09__GPIO2_IO_BIT9	0x40001b9e>; /* I2C_CAM_CK  */
+	};
+
+	/* SMARC SPI1 */
+	pinctrl_lpspi4: lpspi4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO37__LPSPI4_SCK		0x3fe>, /* SMARC P56 - SPI1_CK   */
+			   <IMX95_PAD_GPIO_IO36__LPSPI4_SOUT		0x3fe>, /* SMARC P58 - SPI1_DO   */
+			   <IMX95_PAD_GPIO_IO19__LPSPI4_SIN		0x3fe>, /* SMARC P57 - SPI1_DIN  */
+			   <IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13		0x3fe>, /* SPI1_TPM_CS#          */
+			   <IMX95_PAD_GPIO_IO18__GPIO2_IO_BIT18		0x3fe>, /* SMARC P54 - SPI1_CS0# */
+			   <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x3fe>; /* SMARC P55 - SPI1_CS1# */
+	};
+
+	/* SMARC SPI0 */
+	pinctrl_lpspi6: lpspi6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO00__GPIO2_IO_BIT0		0x3fe>, /* SMARC P43 - SPI0_CS0# */
+			   <IMX95_PAD_GPIO_IO24__GPIO2_IO_BIT24		0x3fe>, /* SMARC P31 - SPI0_CS1# */
+			   <IMX95_PAD_GPIO_IO01__LPSPI6_SIN		0x3fe>, /* SMARC P45 - SPI0_DIN  */
+			   <IMX95_PAD_GPIO_IO02__LPSPI6_SOUT		0x3fe>, /* SMARC P46 - SPI0_DO   */
+			   <IMX95_PAD_GPIO_IO03__LPSPI6_SCK		0x3fe>; /* SMARC P44 - SPI0_CK   */
+	};
+
+	/* SMARC PCIE_A */
+	pinctrl_pcie0: pcie0grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO32__HSIOMIX_TOP_PCIE1_CLKREQ_B	0x40001b1e>; /* SMARC P78 - PCIE_A_CKREQ# */
+	};
+
+	/* SMARC PCIE_B */
+	pinctrl_pcie1: pcie1grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B	0x40001b1e>; /* SMARC P77 - PCIE_B_CKREQ# */
+	};
+
+	/* SMARC I2S0 */
+	pinctrl_sai3: sai3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x11e>, /* SMARC S38 - I2S0_CK */
+			   <IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0	0x11e>, /* SMARC S41 - I2S0_SDIN */
+			   <IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0	0x11e>, /* SMARC S40 - I2S0_SDOUT */
+			   <IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x11e>; /* SMARC S39 - I2S0_LRCK */
+	};
+
+	/* SMARC AUDIO_MCK */
+	pinctrl_sai3_mclk: sai3mclkgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO17__SAI3_MCLK	0x31e>; /* SMARC S42 - AUDIO_MCK */
+	};
+
+	/* SMARC I2S2 */
+	pinctrl_sai5: sai5grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK		0x11e>, /* SMARC S53 - I2S2_CK */
+			   <IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0	0x11e>, /* SMARC S51 - I2S2_SDOUT */
+			   <IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0	0x11e>, /* SMARC S52 - I2S2_SDIN */
+			   <IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC		0x11e>; /* SMARC S50 - I2S2_LRCK */
+	};
+
+	/* SMARC SMB_ALERT# */
+	pinctrl_smb_alert_gpio: smbalertgrp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28	0x31e>; /* SMARC P1 - SMB_ALERT# */
+	};
+
+	/* SMARC SER1, used as the Linux Console */
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>, /* SMARC P134 - SER1_TX */
+			   <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>; /* SMARC P135 - SER1_RX */
+	};
+
+	/* SMARC SER0 */
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPUART2_CTS_B	0x31e>, /* SMARC P132 - SER0_CTS# */
+			   <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPUART2_RTS_B	0x31e>, /* SMARC P131 - SER0_RTS# */
+			   <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX		0x31e>, /* SMARC P130 - SER0_RX   */
+			   <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX		0x31e>; /* SMARC P129 - SER0_TX   */
+	};
+
+	/* SMARC SER3 */
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART3_TX	0x31e>, /* SMARC P140 - SER3_TX */
+			   <IMX95_PAD_GPIO_IO15__LPUART3_RX	0x31e>; /* SMARC P141 - SER3_RX */
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
+	/* SMARC SDIO */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x158e>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x138e>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x138e>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x138e>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x138e>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x138e>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x15fe>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x13fe>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x13fe>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x13fe>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x13fe>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x13fe>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO */
+	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK		0x400>, /* SMARC P36 - SDIO_CK  */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD		0x400>, /* SMARC P34 - SDIO_CMD */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0		0x400>, /* SMARC P39 - SDIO_D0  */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1		0x400>, /* SMARC P40 - SDIO_D1  */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2		0x400>, /* SMARC P41 - SDIO_D2  */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3		0x400>; /* SMARC P42 - SDIO_D3  */
+	};
+
+	/* SMARC SDIO_CD# */
+	pinctrl_usdhc2_cd: usdhc2-cdgrp {
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* SMARC P35 - SDIO_CD# */
+	};
+
+	/* SMARC SDIO_PWR_EN */
+	pinctrl_usdhc2_pwr_en: usdhc2-pwrengrp {
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* SMARC P37 - SDIO_PWR_EN */
+	};
+
+	pinctrl_usdhc2_vsel: usdhc2-vselgrp {
+		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x4>; /* PMIC_SD2_VSEL */
+	};
+
+	/* On-module Wi-Fi */
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x158e>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x138e>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x138e>, /* SD3_DATA0 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x138e>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x138e>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x138e>; /* SD3_DATA3 */
+	};
+
+	/* On-module Wi-Fi */
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x15fe>, /* SD3_CLK   */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x13fe>, /* SD3_CMD   */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe>, /* SD3_DATA1 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe>, /* SD3_DATA2 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe>, /* SD3_DATA3 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe>; /* SD3_DATA4 */
+	};
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 48f458fa55c0..6ad02b9d5810 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -113,6 +113,10 @@ config TARGET_IMX943_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_TORADEX_SMARC_IMX95
+	bool "Support Toradex SMARC iMX95"
+	select IMX95
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -123,6 +127,7 @@ source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
 source "board/freescale/imx94_evk/Kconfig"
 source "board/freescale/imx95_evk/Kconfig"
+source "board/toradex/smarc-imx95/Kconfig"
 
 endif
 
diff --git a/board/toradex/smarc-imx95/Kconfig b/board/toradex/smarc-imx95/Kconfig
new file mode 100644
index 000000000000..97b2c3da1884
--- /dev/null
+++ b/board/toradex/smarc-imx95/Kconfig
@@ -0,0 +1,36 @@
+if TARGET_TORADEX_SMARC_IMX95
+
+config SYS_BOARD
+	default "smarc-imx95"
+
+config SYS_VENDOR
+	default "toradex"
+
+config SYS_CONFIG_NAME
+	default "toradex-smarc-imx95"
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
diff --git a/board/toradex/smarc-imx95/MAINTAINERS b/board/toradex/smarc-imx95/MAINTAINERS
new file mode 100644
index 000000000000..73517d36f1f2
--- /dev/null
+++ b/board/toradex/smarc-imx95/MAINTAINERS
@@ -0,0 +1,11 @@
+Toradex SMARC iMX95
+F:	arch/arm/dts/imx95-toradex-smarc.dtsi
+F:	arch/arm/dts/imx95-toradex-smarc-dev.dts
+F:	arch/arm/dts/imx95-toradex-smarc-dev-u-boot.dtsi
+F:	board/toradex/smarc-imx95/
+F:	configs/toradex-smarc-imx95_defconfig
+F:	doc/board/toradex/smarc-imx95.rst
+F:	include/configs/toradex-smarc-imx95.h
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
+S:	Maintained
+W:	https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
diff --git a/board/toradex/smarc-imx95/Makefile b/board/toradex/smarc-imx95/Makefile
new file mode 100644
index 000000000000..e5d0b0c7e8c1
--- /dev/null
+++ b/board/toradex/smarc-imx95/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2025 Toradex
+
+obj-y += smarc-imx95.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/toradex/smarc-imx95/smarc-imx95.c b/board/toradex/smarc-imx95/smarc-imx95.c
new file mode 100644
index 000000000000..c2cf872d9f9d
--- /dev/null
+++ b/board/toradex/smarc-imx95/smarc-imx95.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <fdt_support.h>
+#include <init.h>
+
+#include "../common/tdx-cfg-block.h"
+
+int board_early_init_f(void)
+{
+	/* UART1: A55 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
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
diff --git a/board/toradex/smarc-imx95/smarc-imx95.env b/board/toradex/smarc-imx95/smarc-imx95.env
new file mode 100644
index 000000000000..b94250bbc52e
--- /dev/null
+++ b/board/toradex/smarc-imx95/smarc-imx95.env
@@ -0,0 +1,20 @@
+boot_scripts=boot.scr
+boot_script_dhcp=boot.scr
+boot_targets=mmc1 mmc0 dhcp
+console=ttyLP1
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
+		if test $confirm = y; then
+			setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt
+			${blkcnt} / 0x200; mmc dev 0 1; mmc write ${loadaddr} 0x0
+			${blkcnt};
+		fi
diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
new file mode 100644
index 000000000000..e0e39b8bb94d
--- /dev/null
+++ b/board/toradex/smarc-imx95/spl.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (C) 2025 Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <asm/global_data.h>
+#include <clk.h>
+#include <dm/ofnode.h>
+#include <dm/uclass.h>
+#include <hang.h>
+#include <i2c.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define EC_I2C_BUS_NODE_PATH	"/soc/bus@42000000/i2c@42540000"
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
+static void ec_boot_notify(void)
+{
+	struct udevice *bus;
+	struct udevice *i2c_dev;
+	ofnode node;
+	int ret;
+	u8 val = 0x03;
+
+	node = ofnode_path(EC_I2C_BUS_NODE_PATH);
+	if (!ofnode_valid(node)) {
+		puts("Failed to find Toradex EC I2C BUS node\n");
+		return;
+	}
+
+	ret = uclass_get_device_by_ofnode(UCLASS_I2C, node, &bus);
+	if (ret) {
+		puts("Failed to get Toradex EC I2C BUS\n");
+		return;
+	}
+
+	ret = dm_i2c_probe(bus, 0x28, 0, &i2c_dev);
+	if (ret) {
+		puts("Toradex EC not found\n");
+		return;
+	}
+
+	/* USB configuration before this command (when SoC starts in recovery):
+	 * - SoC USB1 -> Smarc USB0
+	 * - SoC USB2 -> NC
+	 * After the command:
+	 * - SoC USB1 -> SoM hub -> Smarc USB1, USB2, USB3 and USB4
+	 * - SoC USB2 -> Smarc USB0
+	 */
+	ret = dm_i2c_write(i2c_dev, 0xD0, &val, 1);
+	if (ret)
+		puts("Cannot send command to Toradex EC\n");
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
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	ec_boot_notify();
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
new file mode 100644
index 000000000000..6f7b406e8175
--- /dev/null
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -0,0 +1,172 @@
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
+CONFIG_DEFAULT_DEVICE_TREE="imx95-toradex-smarc-dev"
+CONFIG_TARGET_TORADEX_SMARC_IMX95=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
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
+CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx95-toradex-smarc-${fdt_board}.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_LOG=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
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
+CONFIG_SYS_PROMPT="SMARC iMX95 # "
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
+CONFIG_REGMAP=y
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
+CONFIG_PHYLIB=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
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
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_ULP_WATCHDOG=y
+# CONFIG_SPL_SHA1 is not set
+CONFIG_LZO=y
+CONFIG_HEXDUMP=y
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 68934566ad7c..b6d49cc187e2 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -10,6 +10,7 @@ Toradex
    colibri_imx7
    colibri-imx8x
    smarc-imx8mp
+   smarc-imx95
    verdin-am62
    verdin-am62p
    verdin-imx8mm
diff --git a/doc/board/toradex/smarc-imx95.rst b/doc/board/toradex/smarc-imx95.rst
new file mode 100644
index 000000000000..31524fe1a24c
--- /dev/null
+++ b/doc/board/toradex/smarc-imx95.rst
@@ -0,0 +1,172 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Toradex SMARC iMX95 Module
+==========================
+
+- SoM: https://www.toradex.com/computer-on-modules/smarc-arm-family/nxp-imx95
+- Carrier board: https://www.toradex.com/products/carrier-board/smarc-development-board-kit
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
+    $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
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
+    $ make board=toradex-smarc-imx95 oei=ddr DEBUG=1 r=B0 all
+    $ cp build/toradex-smarc-imx95/ddr/oei-m33-ddr.bin $(srctree)
+
+    $ make board=toradex-smarc-imx95 oei=tcm DEBUG=1 r=B0 all
+    $ cp build/toradex-smarc-imx95/tcm/oei-m33-tcm.bin $(srctree)
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
+    $ make config=tdx-smarc-imx95 all
+    $ cp build/tdx-smarc-imx95/m33_image.bin $(srctree)
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
+    $ make toradex-smarc-imx95_defconfig
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
+    U-Boot SPL 2025.10-00635-g78345766559d (Oct 21 2025 - 17:53:04 +0200)
+    SYS Boot reason: por, origin: -1, errid: -1
+    Trying to boot from MMC1
+    Primary set selected
+    Load image from MMC/SD 0xd9000
+    NOTICE:  BL31: v2.12.0(release):lf-6.12.20-2.0.0
+    NOTICE:  BL31: Built : 17:34:12, Oct 21 2025
+
+
+    U-Boot 2025.10-00635-g78345766559d (Oct 21 2025 - 17:53:04 +0200)
+
+    CPU:   NXP i.MX95 Rev2.0 A55 at 1800 MHz - invalid sensor data
+    DRAM:  7.8 GiB
+    Core:  305 devices, 26 uclasses, devicetree: separate
+    MMC:   FSL_SDHC: 0, FSL_SDHC: 1
+    Loading Environment from MMC... Reading from MMC(0)... OK
+    In:    serial@44380000
+    Out:   serial@44380000
+    Err:   serial@44380000
+    Model: Toradex 0096 SMARC iMX95 Hexa 8GB WB IT V1.1A
+    Serial#: 12594027
+
+    BuildInfo:
+      - ELE firmware version 2.0.2-2a118457
+
+    Net:   No ethernet found.
+    Hit any key to stop autoboot: 0
+    SMARC iMX95 #
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
new file mode 100644
index 000000000000..e1aebd70af2d
--- /dev/null
+++ b/include/configs/toradex-smarc-imx95.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2025 Toradex */
+
+#ifndef __IMX95_TORADEX_SMARC_H
+#define __IMX95_TORADEX_SMARC_H
+
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+/* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above */
+#define SZ_6G	_AC(0x180000000, ULL)
+
+/* first 256MB reserved for firmware */
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	SZ_2M
+
+#define CFG_SYS_SDRAM_BASE	0x90000000
+#define PHYS_SDRAM		0x90000000
+#define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
+#define PHYS_SDRAM_2_SIZE	SZ_6G
+
+#define WDOG_BASE_ADDR	WDG3_BASE_ADDR
+
+#endif
-- 
2.43.0

