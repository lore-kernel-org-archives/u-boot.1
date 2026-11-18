Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCB3606A331
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a2xeU6h+;
	dkim=pass (2048-bit key, unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256 header.s=default header.b=reFSYM7B
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7ACAE81258;
	Wed, 18 Nov 2026 14:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NIAcEWzXv60; Wed, 18 Nov 2026 14:21:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5146E81225
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795011691;
	b=r/kpznFyZgbaFWMNCebruFQRYCJQr/3thnDt/bfp/Gxt82L5XxOkhWAgZdU5oH1kJNgo
	 26DYShKeeG12O1b1BneR/FCVInnXfT5hd9CY1oKZfOJyXEm3Py97Uu5ly9Up2dzOmnNH1
	 3GeLkOZU71/br3BcXNuYJ07GbKf7I1bXbFNc73dSvdk8FQT0Vgr4ENzXhd0Ikg3kVr1WT
	 Ae0Sp8kE+DxfMZBkVgNnaEpHS++8M4SE3BBbm7TRt2zuG6aHiCAOEBbpIGmQnwBYkJteL
	 4OHAFkiw4+b77V+GSNpmLsbuWN8w5nrLuoE6yhjjs56F9osvlzKOuRXEA48HqY6M1JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795011691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4QEDbPyd/q1jcOglg7x27fW0Wp0Odk7Azw0DSou63LU=;
	b=B82f1Mm7nDB/uVhS/o35l4Xd8DfkIRmNuyCBJUHn9QNhPCvD3A80Qy6xRFE5m9ze5nrj
	 jFzf98PbuFw6FegiMtf0s4vZ+YB5/spp4lSGaqPIoVRPvNk0cM4lyKJ5ThXf+dyTBaijM
	 DxpOeeaNXYnrZ52H2oGs0RW4YoNRGxNTGMX81oYj8ydo0LYHVnLCKwQ7bmO3iq5vsvCIh
	 AiwXGrBNbL7MFO0a8u8GElp8xkgNUm1CZLlsl5wGx7N/28TSVg933/WY0rK7vyOT20aRW
	 1W23DgXA4mUUzpKDUFeG5y/uw2nBl9IXS3WwIKr8vBvrUUCeRGWCuqdGlGUj5zFquxg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795011691;
	bh=4QEDbPyd/q1jcOglg7x27fW0Wp0Odk7Azw0DSou63LU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a2xeU6h+D1C+MMk1r0d//WMJdt5hxkNSwlE2XOj/nPqHYRnILaYwgAHkGRNbQy2Ed
	 bOC6o1RgZrbpavfX2h5yaXM2K3O0lwjBUAlWvJWvtcaPE0h83WR83SVcmc5155zfvL
	 adS5xf3tKB+F0Q6puf1B1IOAxDIE2VBb4qCquN3IALgPr6XYnZI/I3cHN/uye3Lt2i
	 beR7f+OyggyYElqAFw4vqyw9lk2Tit5PJSFx3Sb2+qUuuN32HfRICdLDCvyvbxUKbc
	 Dfqe0dvPtGZMbHX7dz+DZhm2yktJewDpIJQrhnDCRPMASaLCtceK94VqSYNXex8fog
	 vMVyWxp4cZqVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5146E81225;
	Wed, 18 Nov 2026 14:21:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 671A370B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5823B60A7C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:21:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c9tOJsab6aND for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 14:21:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA82D6085E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=217.194.8.81
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.194.8.81;
 helo=mail11.truemail.it; envelope-from=francesco@dolcini.it;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=dolcini.it header.i=@dolcini.it header.a=rsa-sha256
 header.s=default header.b=reFSYM7B
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA82D6085E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 14:21:23 +0000 (UTC)
Received: from francesco-nb.. (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 44C111F9FF;
 Wed, 18 Nov 2026 15:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1795011680;
 bh=4QEDbPyd/q1jcOglg7x27fW0Wp0Odk7Azw0DSou63LU=; h=From:To:Subject;
 b=reFSYM7B4dEm7GPZyqm711w5zAl4Q/s/QGp6mOTCgeWpRAOTUoDEtJJenetJOePPy
 fOaYto2BTXtS7RIJRhcfz50qnTNRMc8WA0UWZz1LVFJl8r41iDJhdFmaG9526RzkBF
 G+shBTly6umTRKsKC7GV10fy4OSb5nWQmRHTol4D68cKZZ9C9tVL4WIcs09rO9VhEc
 hGOVPsXijA86SwUaU5BTS4N/0tJWgZ2X1zU2gsb6ECqcZGVEKvl6toFsxmwEVrFSNJ
 e2Ns5ZQSn1xiQPe6WCyOiFvupTANXLbFPvZwY/TmkqeR9mx+M2JsrPQT1VUA0zpJS5
 mFxY2MVgL3ygg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Antoine Gouby <antoine.gouby@toradex.com>, u-boot@lists.u-boot-project.org,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] board: toradex: add initial support for OSM iMX95
Date: Wed, 18 Nov 2026 15:21:11 +0100
Message-ID: <20261118142113.421797-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Antoine Gouby <antoine.gouby@toradex.com>

Add initial U-Boot support for the Toradex OSM iMX95 SoM, mated with
the OSM Development Board.

The device tree files are a copy of the ones in Linux v7.4-rc1, the
board will be moved to OF_UPSTREAM once dts/upstream is synchronized
with a Linux version that includes them.

Link: https://www.toradex.com/computer-on-modules/osm-arm-family/nxp-imx95
Link: https://www.toradex.com/products/carrier-board/osm-development-board
Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Co-developed-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Signed-off-by: Antoine Gouby <antoine.gouby@toradex.com>
Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../arm/dts/imx95-toradex-osm-dev-u-boot.dtsi |   66 ++
 arch/arm/dts/imx95-toradex-osm-dev.dts        |  404 +++++++
 arch/arm/dts/imx95-toradex-osm.dtsi           | 1032 +++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |    5 +
 board/toradex/common/tdx-common.c             |    3 +-
 board/toradex/osm-imx95/Kconfig               |   36 +
 board/toradex/osm-imx95/MAINTAINERS           |   11 +
 board/toradex/osm-imx95/Makefile              |    8 +
 board/toradex/osm-imx95/osm-imx95.c           |   52 +
 board/toradex/osm-imx95/osm-imx95.env         |   20 +
 board/toradex/osm-imx95/spl.c                 |   76 ++
 configs/toradex-osm-imx95_defconfig           |  184 +++
 doc/board/toradex/index.rst                   |    1 +
 doc/board/toradex/osm-imx95.rst               |  176 +++
 include/configs/toradex-osm-imx95.h           |   28 +
 15 files changed, 2101 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx95-toradex-osm-dev.dts
 create mode 100644 arch/arm/dts/imx95-toradex-osm.dtsi
 create mode 100644 board/toradex/osm-imx95/Kconfig
 create mode 100644 board/toradex/osm-imx95/MAINTAINERS
 create mode 100644 board/toradex/osm-imx95/Makefile
 create mode 100644 board/toradex/osm-imx95/osm-imx95.c
 create mode 100644 board/toradex/osm-imx95/osm-imx95.env
 create mode 100644 board/toradex/osm-imx95/spl.c
 create mode 100644 configs/toradex-osm-imx95_defconfig
 create mode 100644 doc/board/toradex/osm-imx95.rst
 create mode 100644 include/configs/toradex-osm-imx95.h

diff --git a/arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi b/arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi
new file mode 100644
index 000000000000..15e1d9914464
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
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
+&lpi2c3 {
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_ctrl_gpio_exp_int {
+	bootph-pre-ram;
+};
+
+&pinctrl_emmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_emmc_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c_som {
+	bootph-pre-ram;
+};
+
+&pinctrl_i2c_som_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart_con {
+	bootph-pre-ram;
+};
+
+&som_gpio_expander_0 {
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
diff --git a/arch/arm/dts/imx95-toradex-osm-dev.dts b/arch/arm/dts/imx95-toradex-osm-dev.dts
new file mode 100644
index 000000000000..b3d54be07c43
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-osm-dev.dts
@@ -0,0 +1,404 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * https://www.toradex.com/computer-on-modules/osm-arm-family/nxp-imx95
+ * https://www.toradex.com/products/carrier-board/osm-development-board
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/usb/pd.h>
+#include "imx95-toradex-osm.dtsi"
+
+/ {
+	model = "Toradex OSM iMX95 on OSM Development Board";
+	compatible = "toradex,osm-imx95-dev",
+		     "toradex,osm-imx95",
+		     "fsl,imx95";
+
+	aliases {
+		eeprom1 = &carrier_eeprom;
+	};
+
+	reg_carrier_1p8v: regulator-carrier-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-carrier 1V8";
+	};
+
+	sfp: sfp {
+		compatible = "sff,sfp";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_b0>, <&pinctrl_gpio_b1>,
+			    <&pinctrl_gpio_b2>, <&pinctrl_gpio_b3>;
+		i2c-bus = <&i2c_mux_carrier_sfp>;
+		los-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <3000>;
+		mod-def0-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		rate-select0-gpios = <&som_gpio_expander_0 4 GPIO_ACTIVE_HIGH>;
+		rate-select1-gpios = <&som_gpio_expander_1 3 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpio5 11 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpio5 8 GPIO_ACTIVE_HIGH>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,bitclock-master = <&codec_dai>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "verdin-wm8904";
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
+/* OSM ADC_0, ADC_1 */
+&adc1 {
+	status = "okay";
+};
+
+/* OSM ETH_A */
+&enetc_port0 {
+	phy-handle = <&ethphy_a>;
+	phy-mode = "rgmii-id";
+
+	status = "okay";
+};
+
+/* OSM ETH_B */
+&enetc_port1 {
+	phy-handle = <&ethphy_b>;
+	phy-mode = "rgmii-id";
+
+	status = "okay";
+};
+
+/* OSM ETH_C */
+&enetc_port2 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	sfp = <&sfp>;
+
+	status = "okay";
+};
+
+/* OSM CAN_A */
+&flexcan2 {
+	status = "okay";
+};
+
+/* OSM CAN_B */
+&flexcan3 {
+	status = "okay";
+};
+
+&gpio5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_a1>, <&pinctrl_gpio_a2>, <&pinctrl_gpio_a3>,
+		    <&pinctrl_gpio_a4>, <&pinctrl_gpio_a5>, <&pinctrl_gpio_a6>;
+};
+
+/* OSM I2C_A */
+&lpi2c1 {
+	status = "okay";
+
+	fan_controller: fan-controller@19 {
+		compatible = "ti,amc6821";
+		reg = <0x19>;
+		#pwm-cells = <2>;
+
+		fan {
+			cooling-levels = <255>;
+			pwms = <&fan_controller 40000 PWM_POLARITY_INVERTED>;
+		};
+	};
+
+	wm8904_1a: audio-codec@1a {
+		compatible = "wlf,wm8904";
+		reg = <0x1a>;
+		clocks = <&scmi_clk IMX95_CLK_SAI3>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&reg_carrier_1p8v>;
+		CPVDD-supply = <&reg_carrier_1p8v>;
+		DBVDD-supply = <&reg_carrier_1p8v>;
+		DCVDD-supply = <&reg_carrier_1p8v>;
+		MICVDD-supply = <&reg_carrier_1p8v>;
+	};
+
+	gpio@20 {
+		compatible = "nxp,pcal6408";
+		reg = <0x20>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"PWR_CTRL_CAN_A", /* 0 */
+			"PWR_CTRL_CAN_B",
+			"PWR_CTRL_USB-HUB",
+			"LVDS_MUX_CTRL",
+			"USB_MUX_CTRL",
+			"I2CA_IOEXP_P5",
+			"I2CA_IOEXP_P6",
+			"I2CA_IOEXP_P7";
+
+		lvds_mux_ctrl: lvds-mux-ctrl-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			line-name = "LVDS_MUX_CTRL";
+			output-low;
+		};
+
+		usb_mux_ctrl: usb-mux-ctrl-hog {
+			gpio-hog;
+			gpios = <4 GPIO_ACTIVE_HIGH>;
+			line-name = "USB_MUX_CTRL";
+			output-high;
+		};
+	};
+
+	power-monitor@40 {
+		compatible = "ti,ina219";
+		reg = <0x40>;
+		shunt-resistor = <10000>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp1075";
+		reg = <0x4f>;
+	};
+
+	tcpc@52 {
+		compatible = "nxp,ptn5110", "tcpci";
+		reg = <0x52>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_a0>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		connector {
+			compatible = "usb-c-connector";
+			data-role = "dual";
+			label = "USB_A";
+			op-sink-microwatt = <0>;
+			power-role = "dual";
+			try-power-role = "sink";
+			self-powered;
+			sink-pdos = <PDO_FIXED(5000, 0, PDO_FIXED_USB_COMM)>;
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			port {
+				usb_c_a_conn_hs: endpoint {
+					remote-endpoint = <&usb_a_hs>;
+				};
+			};
+		};
+	};
+
+	carrier_eeprom: eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+/* OSM I2C_B */
+&lpi2c5 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c_mux_carrier_cam_a: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mux_carrier_lvds: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* I2C on DSI connector pin #4 and #6 */
+		i2c_mux_carrier_dsi_1: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* I2C on DSI connector pin #52 and #54 */
+		i2c_mux_carrier_dsi_2: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mux_carrier_cam_b: i2c@4 {
+			reg = <4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c_mux_carrier_sfp: i2c@5 {
+			reg = <5>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+/* OSM SPI_A */
+&lpspi4 {
+	status = "okay";
+};
+
+/* OSM UART_CON, used as the Linux Console */
+&lpuart1 {
+	status = "okay";
+};
+
+/* OSM UART_D */
+&lpuart2 {
+	status = "okay";
+};
+
+/* OSM UART_C */
+&lpuart3 {
+	status = "okay";
+};
+
+/* OSM UART_B */
+&lpuart5 {
+	status = "okay";
+};
+
+/* OSM UART_A */
+&lpuart6 {
+	status = "okay";
+};
+
+&netc_blk_ctrl {
+	status = "okay";
+};
+
+/* OSM MDIO, shared between all ethernet ports */
+&netc_emdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mdio>;
+
+	status = "okay";
+
+	ethphy_a: ethernet-phy@2 {
+		reg = <2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_a7>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+
+	ethphy_b: ethernet-phy@3 {
+		reg = <3>;
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
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
+/* OSM I2S_A */
+&sai3 {
+	status = "okay";
+};
+
+/* OSM PWM_0 */
+&tpm3 {
+	status = "okay";
+};
+
+/* OSM PWM_1 */
+&tpm4 {
+	status = "okay";
+};
+
+/* OSM PWM_2 */
+&tpm5 {
+	status = "okay";
+};
+
+/* OSM PWM_3 */
+&tpm6 {
+	status = "okay";
+};
+
+/* OSM USB_A */
+&usb2 {
+	status = "okay";
+
+	port {
+		usb_a_hs: endpoint {
+			remote-endpoint = <&usb_c_a_conn_hs>;
+		};
+	};
+};
+
+/* OSM USB_C */
+&usb3 {
+	status = "okay";
+};
+
+&usb3_phy {
+	status = "okay";
+};
+
+/* OSM SDIO_A */
+&usdhc2 {
+	status = "okay";
+};
+
+/* OSM SDIO_B */
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm/dts/imx95-toradex-osm.dtsi b/arch/arm/dts/imx95-toradex-osm.dtsi
new file mode 100644
index 000000000000..8eb7ea4ed9ee
--- /dev/null
+++ b/arch/arm/dts/imx95-toradex-osm.dtsi
@@ -0,0 +1,1032 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex OSM iMX95 SoM
+ *
+ * https://www.toradex.com/computer-on-modules/osm-arm-family/nxp-imx95
+ */
+
+#include "imx95.dtsi"
+
+/ {
+	aliases {
+		can0 = &flexcan2;
+		can1 = &flexcan3;
+		eeprom0 = &som_eeprom;
+		ethernet0 = &enetc_port0;
+		ethernet1 = &enetc_port1;
+		ethernet2 = &enetc_port2;
+		i2c0 = &lpi2c3;
+		i2c1 = &lpi2c1;
+		i2c2 = &lpi2c5;
+		mmc0 = &usdhc1;
+		mmc1 = &usdhc2;
+		mmc2 = &usdhc3;
+		rtc0 = &rtc_i2c;
+		rtc1 = &scmi_bbm;
+		serial0 = &lpuart1;
+		serial1 = &lpuart6;
+		serial2 = &lpuart5;
+		serial3 = &lpuart3;
+		serial4 = &lpuart2;
+		usb0 = &usb2;
+		usb1 = &usb3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	clk_serdes_eth_ref: clock-eth-ref {
+		compatible = "gpio-gate-clock";
+		#clock-cells = <0>;
+		/* CTRL_ETH_REF_CLK_STBY# */
+		enable-gpios = <&som_gpio_expander_0 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "On-module +V1.8";
+	};
+
+	reg_usb_a_vbus: regulator-usb-a-vbus {
+		compatible = "regulator-fixed";
+		/* OSM USB_A_EN (OSM_AC16) */
+		gpios = <&som_gpio_expander_0 0 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_A_EN";
+	};
+
+	reg_usb_c_vbus: regulator-usb-c-vbus {
+		compatible = "regulator-fixed";
+		/* OSM USB_C_EN (OSM_C10) */
+		gpios = <&som_gpio_expander_0 2 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "USB_C_EN";
+	};
+
+	reg_sdio_a_vmmc: regulator-usdhc2-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sdio_a_pwr_en>;
+		gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "SDIO_A_PWR_EN";
+		startup-delay-us = <20000>;
+	};
+
+	reg_sdio_a_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_sdio_a_vsel>;
+		gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "PMIC_SDIO_A_VSEL";
+		states = <1800000 0x1>, <3300000 0x0>;
+	};
+
+	remoteproc-cm7 {
+		compatible = "fsl,imx95-cm7";
+		mbox-names = "tx", "rx", "rxdb";
+		mboxes = <&mu7 0 1 &mu7 1 1 &mu7 3 1>;
+		memory-region = <&vdev0buffer>, <&vdev0vring0>, <&vdev0vring1>,
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
+			alloc-ranges = <0 0x80000000 0 0x7f000000>;
+			linux,cma-default;
+			reusable;
+			size = <0 0x3c000000>;
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
+		vdev0buffer: vdev0buffer@88020000 {
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
+/* OSM ADC_0, ADC_1 */
+&adc1 {
+	vref-supply = <&reg_1p8v>;
+};
+
+/* OSM ETH_A */
+&enetc_port0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth_a>;
+};
+
+/* OSM ETH_B */
+&enetc_port1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_eth_b>;
+};
+
+/* OSM ETH_C */
+&enetc_port2 {
+	clocks = <&clk_serdes_eth_ref>;
+	clock-names = "ref";
+};
+
+/* OSM CAN_A */
+&flexcan2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can_a>;
+};
+
+/* OSM CAN_B */
+&flexcan3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can_b>;
+};
+
+&gpio1 {
+	gpio-line-names =
+		"OSM_AA15", /* 0 */
+		"OSM_AA16",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"OSM_F19",
+		"OSM_AA23",
+		"OSM_G19", /* 10 */
+		"OSM_L17"; /* OSM GPIO_A_7/SPI_B_CS1# */
+
+	status = "okay";
+};
+
+&gpio2 {
+	gpio-line-names =
+		"", /* 0 */
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
+		"OSM_AA21",
+		"OSM_AA20",
+		"",
+		"",
+		"",
+		"",
+		"I2C_SOM_SDA",
+		"I2C_SOM_SCL";
+};
+
+&gpio3 {
+	gpio-line-names =
+		"OSM_J21", /* 0 */
+		"",
+		"",
+		"",
+		"",
+		"",
+		"",
+		"OSM_D21",
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
+		"PMIC_SDIO_A_VSEL";
+};
+
+&gpio4 {
+	gpio-line-names =
+		"", /* 0 */
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
+		"CTRL_GPIO_EXP_INT#",
+		"OSM_T2";
+};
+
+&gpio5 {
+	gpio-line-names =
+		"OSM_D17", /* OSM GPIO_A_0 */
+		"OSM_E17", /* OSM GPIO_A_1 */
+		"OSM_F17", /* OSM GPIO_A_2 */
+		"OSM_G17", /* OSM GPIO_A_3 */
+		"",
+		"",
+		"",
+		"",
+		"OSM_E19",
+		"OSM_H17", /* OSM GPIO_A_4 */
+		"OSM_J17", /* OSM GPIO_A_5 */
+		"OSM_D19",
+		"",
+		"OSM_K17", /* OSM GPIO_A_6/SPI_A_CS1# */
+		"OSM_Y15";
+};
+
+/* OSM I2C_A */
+&lpi2c1 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c_a>;
+	pinctrl-1 = <&pinctrl_i2c_a_gpio>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio1 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* I2C_SOM */
+&lpi2c3 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c_som>, <&pinctrl_ctrl_gpio_exp_int>;
+	pinctrl-1 = <&pinctrl_i2c_som_gpio>, <&pinctrl_ctrl_gpio_exp_int>;
+	clock-frequency = <400000>;
+	scl-gpios = <&gpio2 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	status = "okay";
+
+	som_gpio_expander_0: gpio@20 {
+		compatible = "nxp,pcal6416";
+		reg = <0x20>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio4>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"OSM_AC16", /* 0 */
+			"OSM_AC15",
+			"OSM_C10",
+			"OSM_C8",
+			"OSM_H19", /* OSM GPIO_B_4 */
+			"OSM_J19", /* OSM GPIO_B_5 */
+			"OSM_K19", /* OSM GPIO_B_6 */
+			"OSM_L19", /* OSM GPIO_B_7 */
+			"OSM_V2",
+			"OSM_L33",
+			"OSM_AN23", /* 10 */
+			"OSM_AN14",
+			"USB_RECOVERY_CTRL#",
+			"CTRL_ETH_REF_CLK_STBY#",
+			"CTRL_DSI_EN/CSI_EN#",
+			"SPI_B_TPM_CS#";
+
+		/*
+		 * Switch USB to default position:
+		 *   - SoC USB2 -> OSM USB_A
+		 *   - SoC USB1 -> OSM USB_C
+		 * Reset configuration:
+		 *   - SoC USB1 -> OSM USB_A (USB recovery)
+		 *   - SoC USB2 not connected
+		 */
+		usb_recov_ctrl: usb-recov-ctrl-hog {
+			gpio-hog;
+			gpios = <12 GPIO_ACTIVE_HIGH>;
+			line-name = "USB_RECOVERY_CTRL#";
+			output-high;
+		};
+	};
+
+	som_gpio_expander_1: gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio4>;
+		interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-line-names =
+			"OSM_D3",  /* OSM GPIO_C_0 */
+			"OSM_D4",  /* OSM GPIO_C_1 */
+			"OSM_E3",  /* OSM GPIO_C_2/CAM_B_PWR   */
+			"OSM_E4",  /* OSM GPIO_C_3/CAM_B_RST#  */
+			"OSM_F3",  /* OSM GPIO_C_4/DISP_VDD_EN */
+			"OSM_F4",  /* OSM GPIO_C_5/DISP_BL_EN  */
+			"OSM_G3",  /* OSM GPIO_C_6/CAM_A_PWR   */
+			"OSM_G4",  /* OSM GPIO_C_7/CAM_A_RST#  */
+			"OSM_U32",
+			"OSM_U33",
+			"OSM_V32", /* 10 */
+			"OSM_V33",
+			"OSM_W32",
+			"OSM_W33",
+			"OSM_Y32",
+			"OSM_Y33";
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
+/* OSM I2C_B */
+&lpi2c5 {
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c_b>;
+	pinctrl-1 = <&pinctrl_i2c_b_gpio>;
+	clock-frequency = <100000>;
+	scl-gpios = <&gpio2 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio2 22 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+};
+
+/* OSM SPI_B */
+&lpspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi_b>, <&pinctrl_spi_b_cs0_gpio>;
+	cs-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>,
+		   <&som_gpio_expander_0 15 GPIO_ACTIVE_LOW>;
+
+	status = "okay";
+
+	som_tpm: tpm@1 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0x1>;
+		/*
+		 * Maximum TPM-supported speed is 18.5 MHz, limited to 12 MHz
+		 * here as lpspi1's per-clock (twice the max speed) is 24 MHz
+		 */
+		spi-max-frequency = <12000000>;
+	};
+};
+
+/* OSM SPI_A */
+&lpspi4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi_a>, <&pinctrl_spi_a_cs0_gpio>;
+	cs-gpios = <&gpio5 14 GPIO_ACTIVE_LOW>;
+};
+
+/* OSM UART_CON, used as the Linux Console */
+&lpuart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_con>;
+};
+
+/* OSM UART_D */
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_d>;
+};
+
+/* OSM UART_C */
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_c>;
+};
+
+/* OSM UART_B */
+&lpuart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_b>;
+	uart-has-rtscts;
+};
+
+/* OSM UART_A */
+&lpuart6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart_a>;
+	uart-has-rtscts;
+};
+
+&mu7 {
+	status = "okay";
+};
+
+/* OSM PCIE_A */
+&pcie0 {
+	/* PCIE_A_PERST# (OSM V2) */
+	reset-gpios = <&som_gpio_expander_0 8 GPIO_ACTIVE_LOW>;
+};
+
+/* OSM PCIE_B */
+&pcie1 {
+	/* PCIE_B_PERST# (OSM L33) */
+	reset-gpios = <&som_gpio_expander_0 9 GPIO_ACTIVE_LOW>;
+};
+
+/* OSM I2S_A */
+&sai3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s_a>, <&pinctrl_i2s_mclk>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI3>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>,
+			       <393216000>,
+			       <361267200>,
+			       <12288000>;
+	#sound-dai-cells = <0>;
+	fsl,sai-mclk-direction-output;
+};
+
+/* OSM I2S_B */
+&sai5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2s_b>;
+	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
+			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
+			  <&scmi_clk IMX95_CLK_SAI5>;
+	assigned-clock-parents = <0>, <0>, <0>, <0>,
+				 <&scmi_clk IMX95_CLK_AUDIOPLL1>;
+	assigned-clock-rates = <3932160000>,
+			       <3612672000>,
+			       <393216000>,
+			       <361267200>,
+			       <12288000>;
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
+/* OSM PWM_0 */
+&tpm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0>;
+};
+
+/* OSM PWM_1 */
+&tpm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+};
+
+/* OSM PWM_2 */
+&tpm5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+};
+
+/* OSM PWM_3 */
+&tpm6 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm3>;
+};
+
+/* OSM USB_A */
+&usb2 {
+	adp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	usb-role-switch;
+	vbus-supply = <&reg_usb_a_vbus>;
+};
+
+/* OSM USB_C */
+&usb3 {
+	fsl,disable-port-power-control;
+};
+
+&usb3_dwc3 {
+	dr_mode = "host";
+};
+
+&usb3_phy {
+	vbus-supply = <&reg_usb_c_vbus>;
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_emmc>;
+	pinctrl-1 = <&pinctrl_emmc>;
+	pinctrl-2 = <&pinctrl_emmc_200mhz>;
+	no-sd;
+	no-sdio;
+	non-removable;
+
+	status = "okay";
+};
+
+/* OSM SDIO_A */
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_sdio_a>, <&pinctrl_sdio_a_cd>;
+	pinctrl-1 = <&pinctrl_sdio_a>, <&pinctrl_sdio_a_cd>;
+	pinctrl-2 = <&pinctrl_sdio_a_200mhz>, <&pinctrl_sdio_a_cd>;
+	pinctrl-3 = <&pinctrl_sdio_a_sleep>, <&pinctrl_sdio_a_cd>;
+	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
+	disable-wp;
+	vmmc-supply = <&reg_sdio_a_vmmc>;
+	vqmmc-supply = <&reg_sdio_a_vqmmc>;
+};
+
+/* OSM SDIO_B */
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_sdio_b>;
+	pinctrl-1 = <&pinctrl_sdio_b>;
+	pinctrl-2 = <&pinctrl_sdio_b_200mhz>;
+	disable-wp;
+};
+
+&wdog3 {
+	fsl,ext-reset-output;
+
+	status = "okay";
+};
+
+&scmi_iomuxc {
+	/* OSM MDIO, shared between all ethernet ports */
+	pinctrl_mdio: emdiogrp {
+		fsl,pins = <IMX95_PAD_ENET1_MDC__NETCMIX_TOP_NETC_MDC	0x50e>, /* OSM T16 */
+			   <IMX95_PAD_ENET1_MDIO__NETCMIX_TOP_NETC_MDIO	0x90e>; /* OSM T15 */
+	};
+
+	/* OSM ETH_A */
+	pinctrl_eth_a: enetc0grp {
+		fsl,pins = <IMX95_PAD_ENET1_TX_CTL__NETCMIX_TOP_ETH0_RGMII_TX_CTL	0x57e>, /* OSM K16 */
+			   <IMX95_PAD_ENET1_TXC__NETCMIX_TOP_ETH0_RGMII_TX_CLK		0x58e>, /* OSM J15 */
+			   <IMX95_PAD_ENET1_TD0__NETCMIX_TOP_ETH0_RGMII_TD0		0x50e>, /* OSM H15 */
+			   <IMX95_PAD_ENET1_TD1__NETCMIX_TOP_ETH0_RGMII_TD1		0x50e>, /* OSM G15 */
+			   <IMX95_PAD_ENET1_TD2__NETCMIX_TOP_ETH0_RGMII_TD2		0x50e>, /* OSM H16 */
+			   <IMX95_PAD_ENET1_TD3__NETCMIX_TOP_ETH0_RGMII_TD3		0x50e>, /* OSM G16 */
+			   <IMX95_PAD_ENET1_RX_CTL__NETCMIX_TOP_ETH0_RGMII_RX_CTL	0x57e>, /* OSM M15 */
+			   <IMX95_PAD_ENET1_RXC__NETCMIX_TOP_ETH0_RGMII_RX_CLK		0x58e>, /* OSM R15 */
+			   <IMX95_PAD_ENET1_RD0__NETCMIX_TOP_ETH0_RGMII_RD0		0x57e>, /* OSM K15 */
+			   <IMX95_PAD_ENET1_RD1__NETCMIX_TOP_ETH0_RGMII_RD1		0x57e>, /* OSM L15 */
+			   <IMX95_PAD_ENET1_RD2__NETCMIX_TOP_ETH0_RGMII_RD2		0x57e>, /* OSM N15 */
+			   <IMX95_PAD_ENET1_RD3__NETCMIX_TOP_ETH0_RGMII_RD3		0x57e>; /* OSM P15 */
+	};
+
+	/* OSM ETH_B */
+	pinctrl_eth_b: enetc1grp {
+		fsl,pins = <IMX95_PAD_ENET2_TX_CTL__NETCMIX_TOP_ETH1_RGMII_TX_CTL	0x57e>, /* OSM J2 */
+			   <IMX95_PAD_ENET2_TXC__NETCMIX_TOP_ETH1_RGMII_TX_CLK		0x58e>, /* OSM H1 */
+			   <IMX95_PAD_ENET2_TD0__NETCMIX_TOP_ETH1_RGMII_TD0		0x50e>, /* OSM G1 */
+			   <IMX95_PAD_ENET2_TD1__NETCMIX_TOP_ETH1_RGMII_TD1		0x50e>, /* OSM F1 */
+			   <IMX95_PAD_ENET2_TD2__NETCMIX_TOP_ETH1_RGMII_TD2		0x50e>, /* OSM G2 */
+			   <IMX95_PAD_ENET2_TD3__NETCMIX_TOP_ETH1_RGMII_TD3		0x50e>, /* OSM F2 */
+			   <IMX95_PAD_ENET2_RX_CTL__NETCMIX_TOP_ETH1_RGMII_RX_CTL	0x57e>, /* OSM L1 */
+			   <IMX95_PAD_ENET2_RXC__NETCMIX_TOP_ETH1_RGMII_RX_CLK		0x58e>, /* OSM P1 */
+			   <IMX95_PAD_ENET2_RD0__NETCMIX_TOP_ETH1_RGMII_RD0		0x57e>, /* OSM J1 */
+			   <IMX95_PAD_ENET2_RD1__NETCMIX_TOP_ETH1_RGMII_RD1		0x57e>, /* OSM K1 */
+			   <IMX95_PAD_ENET2_RD2__NETCMIX_TOP_ETH1_RGMII_RD2		0x57e>, /* OSM M1 */
+			   <IMX95_PAD_ENET2_RD3__NETCMIX_TOP_ETH1_RGMII_RD3		0x57e>; /* OSM N1 */
+	};
+
+	/* OSM CAN_A */
+	pinctrl_can_a: flexcan2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO25__CAN2_TX	0x39e>, /* OSM AC17 */
+			   <IMX95_PAD_GPIO_IO27__CAN2_RX	0x39e>; /* OSM AB17 */
+	};
+
+	/* OSM CAN_B */
+	pinctrl_can_b: flexcan3grp {
+		fsl,pins = <IMX95_PAD_CCM_CLKO3__CAN3_TX	0x39e>, /* OSM AC19 */
+			   <IMX95_PAD_CCM_CLKO4__CAN3_RX	0x39e>; /* OSM AB19 */
+	};
+
+	/* OSM GPIO_B_2 */
+	pinctrl_gpio_b2: gpio1io8grp {
+		fsl,pins = <IMX95_PAD_PDM_CLK__AONMIX_TOP_GPIO1_IO_BIT8	0x31e>; /* OSM F19 */
+	};
+
+	/* OSM SPI_B_CS0# */
+	pinctrl_spi_b_cs0_gpio: gpio1io9grp {
+		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM0__AONMIX_TOP_GPIO1_IO_BIT9	0x3fe>; /* OSM AA23 */
+	};
+
+	/* OSM GPIO_B_3 */
+	pinctrl_gpio_b3: gpio1io10grp {
+		fsl,pins = <IMX95_PAD_PDM_BIT_STREAM1__AONMIX_TOP_GPIO1_IO_BIT10	0x31e>; /* OSM G19 */
+	};
+
+	/* OSM GPIO_A_7/SPI_B_CS1# */
+	pinctrl_gpio_a7: gpio1io11grp {
+		fsl,pins = <IMX95_PAD_SAI1_TXFS__AONMIX_TOP_GPIO1_IO_BIT11	0x31e>; /* OSM L17 */
+	};
+
+	/* OSM PWM_0 as GPIO */
+	pinctrl_pwm0_gpio: gpio2io12grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__GPIO2_IO_BIT12	0x31e>; /* OSM E18 */
+	};
+
+	/* OSM GPIO_A_0 */
+	pinctrl_gpio_a0: gpio5io0grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA0__GPIO5_IO_BIT0	0x31e>; /* OSM D17 */
+	};
+
+	/* OSM GPIO_A_1 */
+	pinctrl_gpio_a1: gpio5io1grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA1__GPIO5_IO_BIT1	0x31e>; /* OSM E17 */
+	};
+
+	/* OSM GPIO_A_2 */
+	pinctrl_gpio_a2: gpio5io2grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA2__GPIO5_IO_BIT2	0x31e>; /* OSM F17 */
+	};
+
+	/* OSM GPIO_A_3 */
+	pinctrl_gpio_a3: gpio5io3grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA3__GPIO5_IO_BIT3	0x31e>; /* OSM G17 */
+	};
+
+	/* OSM GPIO_B_1 */
+	pinctrl_gpio_b1: gpio5io8grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DQS__GPIO5_IO_BIT8	0x31e>; /* OSM E19 */
+	};
+
+	/* OSM GPIO_A_4 */
+	pinctrl_gpio_a4: gpio5io9grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SCLK__GPIO5_IO_BIT9		0x31e>; /* OSM H17 */
+	};
+
+	/* OSM GPIO_A_5 */
+	pinctrl_gpio_a5: gpio5io10grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS0_B__GPIO5_IO_BIT10	0x31e>; /* OSM J17 */
+	};
+
+	/* OSM GPIO_B_0 */
+	pinctrl_gpio_b0: gpio5io11grp {
+		fsl,pins = <IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11	0x31e>; /* OSM D19 */
+	};
+
+	/* OSM GPIO_A_6/SPI_A_CS1# */
+	pinctrl_gpio_a6: gpio5io13grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO33__GPIO5_IO_BIT13		0x31e>; /* OSM K17 */
+	};
+
+	/* OSM SPI_A_CS0# */
+	pinctrl_spi_a_cs0_gpio: gpio5io14grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO34__GPIO5_IO_BIT14	0x3fe>; /* OSM Y15 */
+	};
+
+	pinctrl_ctrl_gpio_exp_int: gpioexpintgrp {
+		fsl,pins = <IMX95_PAD_ENET2_MDC__GPIO4_IO_BIT14	0x31e>; /* CTRL_GPIO_EXP_INT# */
+	};
+
+	/* OSM I2C_A as GPIOs */
+	pinctrl_i2c_a_gpio: lpi2c1gpiogrp {
+		fsl,pins = <IMX95_PAD_I2C1_SDA__AONMIX_TOP_GPIO1_IO_BIT1	0x40000b9e>, /* OSM AA16 */
+			   <IMX95_PAD_I2C1_SCL__AONMIX_TOP_GPIO1_IO_BIT0	0x40000b9e>; /* OSM AA15 */
+	};
+
+	/* OSM I2C_A */
+	pinctrl_i2c_a: lpi2c1grp {
+		fsl,pins = <IMX95_PAD_I2C1_SDA__AONMIX_TOP_LPI2C1_SDA	0x40000b9e>, /* OSM AA16 */
+			   <IMX95_PAD_I2C1_SCL__AONMIX_TOP_LPI2C1_SCL	0x40000b9e>; /* OSM AA15 */
+	};
+
+	/* I2C_SOM (On-module I2C) as GPIOs */
+	pinctrl_i2c_som_gpio: lpi2c3gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__GPIO2_IO_BIT28	0x40001b9e>, /* I2C_SOM_SDA */
+			   <IMX95_PAD_GPIO_IO29__GPIO2_IO_BIT29	0x40001b9e>; /* I2C_SOM_SCL */
+	};
+
+	/* I2C_SOM (On-module I2C) */
+	pinctrl_i2c_som: lpi2c3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO28__LPI2C3_SDA	0x40001b9e>, /* I2C_SOM_SDA */
+			   <IMX95_PAD_GPIO_IO29__LPI2C3_SCL	0x40001b9e>; /* I2C_SOM_SCL */
+	};
+
+	/* OSM I2C_B as GPIOs */
+	pinctrl_i2c_b_gpio: lpi2c5gpiogrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__GPIO2_IO_BIT22	0x40001b9e>, /* OSM AA21 */
+			   <IMX95_PAD_GPIO_IO23__GPIO2_IO_BIT23	0x40001b9e>; /* OSM AA20 */
+	};
+
+	/* OSM I2C_B */
+	pinctrl_i2c_b: lpi2c5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO22__LPI2C5_SDA	0x40001b9e>, /* OSM AA21 */
+			   <IMX95_PAD_GPIO_IO23__LPI2C5_SCL	0x40001b9e>; /* OSM AA20 */
+	};
+
+	/* OSM SPI_B */
+	pinctrl_spi_b: lpspi1grp {
+		fsl,pins = <IMX95_PAD_SAI1_TXD0__AONMIX_TOP_LPSPI1_SCK	0x3fe>, /* OSM Y21 */
+			   <IMX95_PAD_SAI1_RXD0__AONMIX_TOP_LPSPI1_SOUT	0x3fe>, /* OSM Y23 */
+			   <IMX95_PAD_SAI1_TXC__AONMIX_TOP_LPSPI1_SIN	0x3fe>; /* OSM Y22 */
+	};
+
+	/* OSM SPI_A */
+	pinctrl_spi_a: lpspi4grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO37__LPSPI4_SCK	0x3fe>, /* OSM U16 */
+			   <IMX95_PAD_GPIO_IO36__LPSPI4_SOUT	0x3fe>, /* OSM V15 */
+			   <IMX95_PAD_GPIO_IO35__LPSPI4_SIN	0x3fe>; /* OSM U15 */
+	};
+
+	/* OSM UART_CON */
+	pinctrl_uart_con: lpuart1grp {
+		fsl,pins = <IMX95_PAD_UART1_TXD__AONMIX_TOP_LPUART1_TX	0x31e>, /* OSM D23 */
+			   <IMX95_PAD_UART1_RXD__AONMIX_TOP_LPUART1_RX	0x31e>; /* OSM D22 */
+	};
+
+	/* OSM UART_D */
+	pinctrl_uart_d: lpuart2grp {
+		fsl,pins = <IMX95_PAD_UART2_TXD__AONMIX_TOP_LPUART2_TX	0x31e>, /* OSM C23 */
+			   <IMX95_PAD_UART2_RXD__AONMIX_TOP_LPUART2_RX	0x31e>; /* OSM C22 */
+	};
+
+	/* OSM UART_C */
+	pinctrl_uart_c: lpuart3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO14__LPUART3_TX	0x31e>, /* OSM B23 */
+			   <IMX95_PAD_GPIO_IO15__LPUART3_RX	0x31e>; /* OSM A22 */
+	};
+
+	/* OSM UART_B */
+	pinctrl_uart_b: lpuart5grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO00__LPUART5_TX	0x31e>, /* OSM D13 */
+			   <IMX95_PAD_GPIO_IO01__LPUART5_RX	0x31e>, /* OSM D14 */
+			   <IMX95_PAD_GPIO_IO02__LPUART5_CTS_B	0x31e>, /* OSM D16 */
+			   <IMX95_PAD_GPIO_IO03__LPUART5_RTS_B	0x31e>; /* OSM D15 */
+	};
+
+	/* OSM UART_A */
+	pinctrl_uart_a: lpuart6grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO04__LPUART6_TX	0x31e>, /* OSM B13 */
+			   <IMX95_PAD_GPIO_IO05__LPUART6_RX	0x31e>, /* OSM A14 */
+			   <IMX95_PAD_GPIO_IO06__LPUART6_CTS_B	0x31e>, /* OSM C14 */
+			   <IMX95_PAD_GPIO_IO07__LPUART6_RTS_B	0x31e>; /* OSM C13 */
+	};
+
+	/* OSM PCIE_WAKE# */
+	pinctrl_pcie_wake: pciewakegrp {
+		fsl,pins = <IMX95_PAD_ENET2_MDIO__GPIO4_IO_BIT15	0x31e>; /* OSM T2 */
+	};
+
+	/* OSM I2S_A */
+	pinctrl_i2s_a: sai3grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO16__SAI3_TX_BCLK		0x11e>, /* OSM W20 */
+			   <IMX95_PAD_GPIO_IO20__SAI3_RX_DATA_BIT0	0x11e>, /* OSM V21 */
+			   <IMX95_PAD_GPIO_IO21__SAI3_TX_DATA_BIT0	0x11e>, /* OSM W21 */
+			   <IMX95_PAD_GPIO_IO26__SAI3_TX_SYNC		0x11e>; /* OSM W18 */
+	};
+
+	/* OSM I2S_MCLK */
+	pinctrl_i2s_mclk: sai3mclkgrp {
+		fsl,pins = <IMX95_PAD_GPIO_IO17__SAI3_MCLK	0x31e>; /* OSM V18 */
+	};
+
+	/* OSM I2S_B */
+	pinctrl_i2s_b: sai5grp {
+		fsl,pins = <IMX95_PAD_XSPI1_DATA6__SAI5_TX_BCLK		0x11e>, /* OSM T19 */
+			   <IMX95_PAD_XSPI1_DATA7__SAI5_RX_DATA_BIT0	0x11e>, /* OSM V19 */
+			   <IMX95_PAD_XSPI1_DATA4__SAI5_TX_DATA_BIT0	0x11e>, /* OSM W19 */
+			   <IMX95_PAD_XSPI1_DATA5__SAI5_TX_SYNC		0x11e>; /* OSM T18 */
+	};
+
+	/* OSM PWM_0 */
+	pinctrl_pwm0: tpm3ch2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO12__TPM3_CH2	0x51e>; /* OSM E18 */
+	};
+
+	/* OSM PWM_1 */
+	pinctrl_pwm1: tpm4ch2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO13__TPM4_CH2	0x51e>; /* OSM F18 */
+	};
+
+	/* OSM PWM_2 */
+	pinctrl_pwm2: tpm5ch2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO18__TPM5_CH2	0x51e>; /* OSM G18 */
+	};
+
+	/* OSM PWM_3 */
+	pinctrl_pwm3: tpm6ch2grp {
+		fsl,pins = <IMX95_PAD_GPIO_IO19__TPM6_CH2	0x51e>; /* OSM H18 */
+	};
+
+	/* On-module eMMC (max 200MHz) */
+	pinctrl_emmc_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x15fe>, /* eMMC_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x13fe>, /* eMMC_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x13fe>, /* eMMC_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x13fe>, /* eMMC_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x13fe>, /* eMMC_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x13fe>, /* eMMC_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x13fe>, /* eMMC_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x13fe>, /* eMMC_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x13fe>, /* eMMC_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x13fe>, /* eMMC_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x15fe>; /* eMMC_STROBE */
+	};
+
+	/* On-module eMMC (max 100MHz) */
+	pinctrl_emmc: usdhc1grp {
+		fsl,pins = <IMX95_PAD_SD1_CLK__USDHC1_CLK	0x158e>, /* eMMC_CLK    */
+			   <IMX95_PAD_SD1_CMD__USDHC1_CMD	0x138e>, /* eMMC_CMD    */
+			   <IMX95_PAD_SD1_DATA0__USDHC1_DATA0	0x138e>, /* eMMC_DATA0  */
+			   <IMX95_PAD_SD1_DATA1__USDHC1_DATA1	0x138e>, /* eMMC_DATA1  */
+			   <IMX95_PAD_SD1_DATA2__USDHC1_DATA2	0x138e>, /* eMMC_DATA2  */
+			   <IMX95_PAD_SD1_DATA3__USDHC1_DATA3	0x138e>, /* eMMC_DATA3  */
+			   <IMX95_PAD_SD1_DATA4__USDHC1_DATA4	0x138e>, /* eMMC_DATA4  */
+			   <IMX95_PAD_SD1_DATA5__USDHC1_DATA5	0x138e>, /* eMMC_DATA5  */
+			   <IMX95_PAD_SD1_DATA6__USDHC1_DATA6	0x138e>, /* eMMC_DATA6  */
+			   <IMX95_PAD_SD1_DATA7__USDHC1_DATA7	0x138e>, /* eMMC_DATA7  */
+			   <IMX95_PAD_SD1_STROBE__USDHC1_STROBE	0x158e>; /* eMMC_STROBE */
+	};
+
+	/* OSM SDIO_A (max 200MHz) */
+	pinctrl_sdio_a_200mhz: usdhc2-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x15fe>, /* OSM F21 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x13fe>, /* OSM E20 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x13fe>, /* OSM G20 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x13fe>, /* OSM G21 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x13fe>, /* OSM H20 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x13fe>; /* OSM H21 */
+	};
+
+	/* OSM SDIO_A_CD# */
+	pinctrl_sdio_a_cd: usdhc2-cdgrp {
+		fsl,pins = <IMX95_PAD_SD2_CD_B__GPIO3_IO_BIT0	0x1100>; /* OSM J21 */
+	};
+
+	/* OSM SDIO_A_PWR_EN */
+	pinctrl_sdio_a_pwr_en: usdhc2-pwrengrp {
+		fsl,pins = <IMX95_PAD_SD2_RESET_B__GPIO3_IO_BIT7	0x11e>; /* OSM D21 */
+	};
+
+	/* OSM SDIO_A (sleep mode) */
+	pinctrl_sdio_a_sleep: usdhc2-sleepgrp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x400>, /* OSM F21 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x400>, /* OSM E20 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x400>, /* OSM G20 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x400>, /* OSM G21 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x400>, /* OSM H20 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x400>; /* OSM H21 */
+	};
+
+	/* PMIC_SDIO_A_VSEL */
+	pinctrl_sdio_a_vsel: usdhc2-vselgrp {
+		fsl,pins = <IMX95_PAD_SD2_VSELECT__GPIO3_IO_BIT19	0x4>; /* PMIC_SDIO_A_VSEL */
+	};
+
+	/* OSM SDIO_A (max 100MHz) */
+	pinctrl_sdio_a: usdhc2grp {
+		fsl,pins = <IMX95_PAD_SD2_CLK__USDHC2_CLK	0x158e>, /* OSM F21 */
+			   <IMX95_PAD_SD2_CMD__USDHC2_CMD	0x138e>, /* OSM E20 */
+			   <IMX95_PAD_SD2_DATA0__USDHC2_DATA0	0x138e>, /* OSM G20 */
+			   <IMX95_PAD_SD2_DATA1__USDHC2_DATA1	0x138e>, /* OSM G21 */
+			   <IMX95_PAD_SD2_DATA2__USDHC2_DATA2	0x138e>, /* OSM H20 */
+			   <IMX95_PAD_SD2_DATA3__USDHC2_DATA3	0x138e>; /* OSM H21 */
+	};
+
+	/* OSM SDIO_B (max 200MHz) */
+	pinctrl_sdio_b_200mhz: usdhc3-200mhzgrp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x15fe>, /* OSM K20 */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x13fe>, /* OSM K21 */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x13fe>, /* OSM L20 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x13fe>, /* OSM L21 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x13fe>, /* OSM M21 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x13fe>; /* OSM N20 */
+	};
+
+	/* OSM SDIO_B (max 100MHz) */
+	pinctrl_sdio_b: usdhc3grp {
+		fsl,pins = <IMX95_PAD_SD3_CLK__USDHC3_CLK	0x158e>, /* OSM K20 */
+			   <IMX95_PAD_SD3_CMD__USDHC3_CMD	0x138e>, /* OSM K21 */
+			   <IMX95_PAD_SD3_DATA0__USDHC3_DATA0	0x138e>, /* OSM L20 */
+			   <IMX95_PAD_SD3_DATA1__USDHC3_DATA1	0x138e>, /* OSM L21 */
+			   <IMX95_PAD_SD3_DATA2__USDHC3_DATA2	0x138e>, /* OSM M21 */
+			   <IMX95_PAD_SD3_DATA3__USDHC3_DATA3	0x138e>; /* OSM N20 */
+	};
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 9072e63d7d16..19a2baa14df0 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -217,6 +217,10 @@ config TARGET_AQUILA_IMX95
 	select IMX95
 	imply OF_UPSTREAM
 
+config TARGET_TORADEX_OSM_IMX95
+	bool "Support Toradex OSM iMX95"
+	select IMX95
+
 config TARGET_TORADEX_SMARC_IMX95
 	bool "Support Toradex SMARC iMX95"
 	select IMX95
@@ -254,6 +258,7 @@ source "board/nxp/imx95_evk/Kconfig"
 source "board/nxp/imx95_navq/Kconfig"
 source "board/nxp/imx95_frdm/Kconfig"
 source "board/toradex/aquila-imx95/Kconfig"
+source "board/toradex/osm-imx95/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
 source "board/toradex/verdin-imx95/Kconfig"
 source "board/nxp/imx952_evk/Kconfig"
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 2a8589f5e41c..4a2c4de50970 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -196,7 +196,8 @@ static int settings_r(void)
 		eth_env_set_enetaddr("eth1addr", ethaddr);
 	}
 
-	if (IS_ENABLED(CONFIG_TARGET_TORADEX_SMARC_IMX95) &&
+	if ((IS_ENABLED(CONFIG_TARGET_TORADEX_OSM_IMX95) ||
+	     IS_ENABLED(CONFIG_TARGET_TORADEX_SMARC_IMX95)) &&
 	    !eth_env_get_enetaddr("eth2addr", ethaddr)) {
 		/*
 		 * Third MAC address is allocated from block
diff --git a/board/toradex/osm-imx95/Kconfig b/board/toradex/osm-imx95/Kconfig
new file mode 100644
index 000000000000..fc59bbdad3e3
--- /dev/null
+++ b/board/toradex/osm-imx95/Kconfig
@@ -0,0 +1,36 @@
+if TARGET_TORADEX_OSM_IMX95
+
+config SYS_BOARD
+	default "osm-imx95"
+
+config SYS_VENDOR
+	default "toradex"
+
+config SYS_CONFIG_NAME
+	default "toradex-osm-imx95"
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
diff --git a/board/toradex/osm-imx95/MAINTAINERS b/board/toradex/osm-imx95/MAINTAINERS
new file mode 100644
index 000000000000..65379ac332e7
--- /dev/null
+++ b/board/toradex/osm-imx95/MAINTAINERS
@@ -0,0 +1,11 @@
+Toradex OSM iMX95
+F:	arch/arm/dts/imx95-toradex-osm.dtsi
+F:	arch/arm/dts/imx95-toradex-osm-dev.dts
+F:	arch/arm/dts/imx95-toradex-osm-dev-u-boot.dtsi
+F:	board/toradex/osm-imx95/
+F:	configs/toradex-osm-imx95_defconfig
+F:	doc/board/toradex/osm-imx95.rst
+F:	include/configs/toradex-osm-imx95.h
+M:	Francesco Dolcini <francesco.dolcini@toradex.com>
+S:	Maintained
+W:	https://www.toradex.com/computer-on-modules/osm-arm-family/nxp-imx95
diff --git a/board/toradex/osm-imx95/Makefile b/board/toradex/osm-imx95/Makefile
new file mode 100644
index 000000000000..ad6da98faa87
--- /dev/null
+++ b/board/toradex/osm-imx95/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (c) Toradex
+
+obj-y += osm-imx95.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/toradex/osm-imx95/osm-imx95.c b/board/toradex/osm-imx95/osm-imx95.c
new file mode 100644
index 000000000000..bf3cba9f9850
--- /dev/null
+++ b/board/toradex/osm-imx95/osm-imx95.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <errno.h>
+#include <fdt_support.h>
+#include <init.h>
+
+#include "../common/tdx-cfg-block.h"
+
+/*
+ * The address wrap-around is not linear: address bits above the module
+ * capacity alias back to the base with some low address bits XORed, as
+ * measured on 4GB and 8GB modules (bit 32 -> XOR 0xc000, bit 33 -> XOR
+ * 0x2000).
+ */
+static const struct ram_alias_check ram_alias_checks[] = {
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_4G), (void *)((uintptr_t)PHYS_SDRAM + 0xc000), SZ_8G },
+	{ (void *)((uintptr_t)PHYS_SDRAM + SZ_2G), (void *)(PHYS_SDRAM), SZ_4G },
+	{ NULL }
+};
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	phys_size_t sz;
+
+	sz = probe_ram_size_by_alias(ram_alias_checks);
+	if (!sz) {
+		puts("## WARNING: Less than 4GB RAM detected\n");
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
+
+#if IS_ENABLED(CONFIG_OF_BOARD_FIXUP)
+int board_fix_fdt(void *fdt)
+{
+	/* Remove nodes based on fuses. */
+	return imx9_uboot_fixup_by_fuse(fdt);
+}
+#endif
diff --git a/board/toradex/osm-imx95/osm-imx95.env b/board/toradex/osm-imx95/osm-imx95.env
new file mode 100644
index 000000000000..e4750bec7939
--- /dev/null
+++ b/board/toradex/osm-imx95/osm-imx95.env
@@ -0,0 +1,20 @@
+boot_scripts=boot.scr
+boot_script_dhcp=boot.scr
+boot_targets=mmc1 mmc0 dhcp
+console=ttyLP0
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
diff --git a/board/toradex/osm-imx95/spl.c b/board/toradex/osm-imx95/spl.c
new file mode 100644
index 000000000000..bc869d0b7e67
--- /dev/null
+++ b/board/toradex/osm-imx95/spl.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) Toradex */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
+#include <asm/sections.h>
+#include <asm/global_data.h>
+#include <hang.h>
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
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
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
+	arch_cpu_init();
+
+	/* Need dm_init() to run before any SCMI calls */
+	spl_early_init();
+
+	/* Need to enable SCMI drivers and ELE driver before console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* MU not probed, nothing can be outputed, hang */
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
diff --git a/configs/toradex-osm-imx95_defconfig b/configs/toradex-osm-imx95_defconfig
new file mode 100644
index 000000000000..c38ea0d2a537
--- /dev/null
+++ b/configs/toradex-osm-imx95_defconfig
@@ -0,0 +1,184 @@
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
+CONFIG_DEFAULT_DEVICE_TREE="imx95-toradex-osm-dev"
+CONFIG_TARGET_TORADEX_OSM_IMX95=y
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
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_SPL_IMX_QB=y
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
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
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx95-toradex-osm-${fdt_board}.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_LOG=y
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="OSM iMX95 # "
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
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
+CONFIG_REMOTEPROC=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RNG=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Toradex"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
+CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_USB_GADGET_OS_DESCRIPTORS=y
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_ULP_WATCHDOG=y
+CONFIG_WDT=y
+# CONFIG_SPL_SHA1 is not set
+CONFIG_LZO=y
diff --git a/doc/board/toradex/index.rst b/doc/board/toradex/index.rst
index 10af3a5b7582..f6ab1ea3b686 100644
--- a/doc/board/toradex/index.rst
+++ b/doc/board/toradex/index.rst
@@ -12,6 +12,7 @@ Toradex
    colibri_imx7
    colibri-imx8x
    colibri_vf
+   osm-imx95
    smarc-imx8mp
    smarc-imx95
    verdin-am62
diff --git a/doc/board/toradex/osm-imx95.rst b/doc/board/toradex/osm-imx95.rst
new file mode 100644
index 000000000000..26795711e56a
--- /dev/null
+++ b/doc/board/toradex/osm-imx95.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+Toradex OSM iMX95 Module
+========================
+
+- SoM: https://www.toradex.com/computer-on-modules/osm-arm-family/nxp-imx95
+- Carrier board: https://www.toradex.com/products/carrier-board/osm-development-board
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
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.6-c0b284c.bin
+    $ sh firmware-ele-imx-2.0.6-c0b284c.bin --auto-accept
+    $ cp firmware-ele-imx-2.0.6-c0b284c/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+---------------------------
+
+Note: `$srctree` is the U-Boot source directory
+
+.. code-block:: console
+
+    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.32-1991416.bin
+    $ sh firmware-imx-8.32-1991416.bin --auto-accept
+    $ cp firmware-imx-8.32-1991416/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
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
+    $ make board=toradex-osm-imx95 oei=ddr DEBUG=1 r=B0 all
+    $ cp build/toradex-osm-imx95/ddr/oei-m33-ddr.bin $(srctree)
+
+Only the B0 silicon revision is supported.
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
+    $ make config=tdx-osm-imx95 all
+    $ cp build/tdx-osm-imx95/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: `$srctree` is the U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.14
+
+.. code-block:: console
+
+    $ export CROSS_COMPILE=$CROSS_COMPILE_64
+    $ unset LDFLAGS
+    $ unset AS
+    $ git clone -b lf_v2.14 https://github.com/nxp-imx/imx-atf.git
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
+    $ make toradex-osm-imx95_defconfig
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
+    U-Boot SPL 2027.01-rc2-00001-gecf711918d4a (Nov 13 2026 - 15:28:54 +0000)
+    SYS Boot reason: por
+    WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
+    QB save failed
+    Trying to boot from MMC1
+    Load image from MMC/SD 0xca800
+    NOTICE:  BL31: v2.14.1(release):lf-6.18.20-2.0.0
+    NOTICE:  BL31: Built : 15:28:45, Nov 13 2026
+
+
+    U-Boot 2027.01-rc2-00001-gecf711918d4a (Nov 13 2026 - 15:28:54 +0000)
+
+    CPU:   NXP i.MX9596 Rev2.0 A55 at 1800 MHz
+    CPU:   Industrial temperature grade (-40C to 105C) - invalid sensor data
+    DRAM:  7.8 GiB
+    Core:  312 devices, 29 uclasses, devicetree: separate
+    WDT:   Started watchdog@42490000 with servicing every 1000ms (40s timeout)
+    MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
+    Loading Environment from MMC...Reading from MMC(0)... Loading Environment from MMC... OK
+    In:    serial@44380000
+    Out:   serial@44380000
+    Err:   serial@44380000
+    Model: Toradex OSM iMX95 on OSM Development Board
+    Toradex SoM: 0225 V1.0A (02251000)
+    Serial#: 08994735
+
+    BuildInfo:
+      - ELE firmware version 2.0.6-9a9290a
+
+    Net:   WARNING: no MAC address assigned for MAC0
+    imx_get_mac_from_fuse: fuse read err: 0
+    eth0: enetc-0 [PRIME]WARNING: no MAC address assigned for MAC1
+    imx_get_mac_from_fuse: fuse read err: 0
+    , eth1: enetc-1
+    Hit any key to stop autoboot: 0
+    OSM iMX95 #
diff --git a/include/configs/toradex-osm-imx95.h b/include/configs/toradex-osm-imx95.h
new file mode 100644
index 000000000000..b6ce16d2cedc
--- /dev/null
+++ b/include/configs/toradex-osm-imx95.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) Toradex */
+
+#ifndef __TORADEX_OSM_IMX95_H
+#define __TORADEX_OSM_IMX95_H
+
+#include <linux/sizes.h>
+#include <asm/arch/imx-regs.h>
+
+/* module has 8GB, 2GB from 0x80000000..0xffffffff, 6GB above.
+ * Actual size is determined at runtime.
+ */
+#define SZ_6G	_AC(0x180000000, ULL)
+
+/* The first 256MB of SDRAM is reserved for firmware (Cortex M7) */
+#define PHYS_SDRAM_FW_RSVD	SZ_256M
+#define CFG_SYS_INIT_RAM_ADDR	PHYS_SDRAM
+#define CFG_SYS_INIT_RAM_SIZE	SZ_2M
+
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM
+#define PHYS_SDRAM		(0x80000000 + PHYS_SDRAM_FW_RSVD)
+#define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
+#define PHYS_SDRAM_2_SIZE	SZ_6G
+
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
+
+#endif
-- 
2.47.3

