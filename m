Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F29C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F34876E4;
	Tue, 19 Dec 2023 17:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UIFgiCsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1625B8786C; Tue, 19 Dec 2023 17:05:27 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251E787889
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c38de1ee4so47401425e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001892; x=1703606692; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+ljen5oRSDtfAEM2vUPL3Dvr0aQ/DKE18GR/C1MkvxI=;
 b=UIFgiCsqkApGfoK8PlmbcwAfWIGNdGcy61s7McavryVWBtaslLTC3u5WTPQCO70W7l
 YeDyjxahxts+peOFuI4DpXkwBDXRWkF7gnHT9J86N6DKU09zPzTUmMAkeXhTjoAx2bF1
 Q7MBEByrVMB0jZrTIx7RKDra2+6AznfXZFAcUZWLAsYE91m6iXbaikMAGBUFDhzKmJ9f
 vEismCdjvTjKQSeXbFc+Q/28dl6RvW6rcW4THoglOs0oApVEegRj6Z0zJJetzXcy3RRw
 QNGoplUd+7VuU7TDPekKCjn1pUUFEgsmPT544zH8U2YIV50roZ06TzASf+0VRSY/oH3O
 S3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001892; x=1703606692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ljen5oRSDtfAEM2vUPL3Dvr0aQ/DKE18GR/C1MkvxI=;
 b=V/cA09dzioxvHSqftlWlhzyxXqPmBTh3JEz6gny8Vpoj8f9JgG/h3ARP+E3B13kEjB
 1IJCZeyxg32xk0gzjIGJAPFDPoi3LrINDYTetYdICNG15GhUQtO/xzQRMI+cgr5q8oAc
 GVcueN5uXi7qEnIxzVXzPvU3E+YG+Y/lNRADXvq0o17kd759hFcTT7busZZ9kgLCQPNo
 awPRhLgtLO+utA1NyhfHKtk9DYxeqFHin0//Cw2jc8150GmS5eE2Ssb03EiR8vYx4AI9
 T977TvZf7bi9wkBVfaA2jz4bIdL/a0r0dMZfsPZFFodZoDnsqxo/SJJFz6Z2HrPv/V/q
 +txQ==
X-Gm-Message-State: AOJu0YxQOa7jLKQk8kou3OfZdWGSruYYBKv/+wWjP5WnbGSbcR2YLpvd
 R06pW1o7JFs4gDVQ7Upsm2i66w==
X-Google-Smtp-Source: AGHT+IFqVU9BsudgBJ/cdg2idwCioxm0ZUvujvq2it9Qam8kgf+lm7pZ2lSgIrKiG2kcGLLw2/VZwg==
X-Received: by 2002:a05:600c:3147:b0:40c:3fa7:bba8 with SMTP id
 h7-20020a05600c314700b0040c3fa7bba8mr8332600wmo.155.1703001891808; 
 Tue, 19 Dec 2023 08:04:51 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:51 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:29 +0000
Subject: [PATCH v2 28/32] dts: msm8996: replace with upstream DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-28-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=131813;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cAKJoM1vyIb1GNQTMQ3LN31iaPdlfmVjXW/TC+2HAHE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SxfWoIXNWZwrNj3bZXEv/k739+/8Jb5zc816RveV
 OYHTo390VHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmolTM8N+b6Z3E0fqV8o68
 ijonqs5aNU/idZxkG7X8yPmIDJW5odMY/tc7fnwUn1W+/4lUqqPvojC2iy1zz3pfMl2e+vLK3Ea
 u9ecA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-Mailman-Approved-At: Tue, 19 Dec 2023 17:10:55 +0100
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

Drop the U-Boot specific dragonboard820c.dts file in favour of the
upstream apq8096-db820c.dts and an additional -u-boot.dtsi with the
U-Boot specific additions.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/Makefile                   |    2 +-
 arch/arm/dts/apq8096-db820c-u-boot.dtsi |   10 +
 arch/arm/dts/apq8096-db820c.dts         | 1137 +++++++++
 arch/arm/dts/dragonboard820c-uboot.dtsi |   32 -
 arch/arm/dts/dragonboard820c.dts        |  153 --
 arch/arm/dts/msm8996.dtsi               | 3884 +++++++++++++++++++++++++++++++
 configs/dragonboard820c_defconfig       |    2 +-
 7 files changed, 5033 insertions(+), 187 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 836113eb66e4..95470fd6133b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -601,7 +601,7 @@ dtb-$(CONFIG_TARGET_SL28) += fsl-ls1028a-kontron-sl28.dtb \
 dtb-$(CONFIG_TARGET_TEN64) += fsl-ls1088a-ten64.dtb
 
 dtb-$(CONFIG_ARCH_SNAPDRAGON) += apq8016-sbc.dtb \
-	dragonboard820c.dtb \
+	apq8096-db820c.dtb \
 	sdm845-db845c.dtb \
 	sdm845-samsung-starqltechn.dtb \
 	qcs404-evb.dtb
diff --git a/arch/arm/dts/apq8096-db820c-u-boot.dtsi b/arch/arm/dts/apq8096-db820c-u-boot.dtsi
new file mode 100644
index 000000000000..6bce5f8d7edf
--- /dev/null
+++ b/arch/arm/dts/apq8096-db820c-u-boot.dtsi
@@ -0,0 +1,10 @@
+
+/ {
+	/* Ensure that the fdtfile variable is generated properly */
+	compatible = "qcom,apq8096-db820c", "qcom,apq8096";
+};
+
+&sdhc2 {
+	status = "okay";
+	clock-frequency = <100000000>;
+};
diff --git a/arch/arm/dts/apq8096-db820c.dts b/arch/arm/dts/apq8096-db820c.dts
new file mode 100644
index 000000000000..e8148b3d6c50
--- /dev/null
+++ b/arch/arm/dts/apq8096-db820c.dts
@@ -0,0 +1,1137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "msm8996.dtsi"
+#include "pm8994.dtsi"
+#include "pmi8994.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/sound/qcom,wcd9335.h>
+
+/*
+ * GPIO name legend: proper name = the GPIO line is used as GPIO
+ *         NC      = not connected (pin out but not routed from the chip to
+ *                   anything the board)
+ *         "[PER]" = pin is muxed for [peripheral] (not GPIO)
+ *         LSEC    = Low Speed External Connector
+ *         P HSEC  = Primary High Speed External Connector
+ *         S HSEC  = Secondary High Speed External Connector
+ *         J14     = Camera Connector
+ *         TP      = Test Points
+ *
+ * Line names are taken from the schematic "DragonBoard 820c",
+ * drawing no: LM25-P2751-1
+ *
+ * For the lines routed to the external connectors the
+ * lines are named after the 96Boards CE Specification 1.0,
+ * Appendix "Expansion Connector Signal Description".
+ *
+ * When the 96Board naming of a line and the schematic name of
+ * the same line are in conflict, the 96Board specification
+ * takes precedence, which means that the external UART on the
+ * LSEC is named UART0 while the schematic and SoC names this
+ * UART3. This is only for the informational lines i.e. "[FOO]",
+ * the GPIO named lines "GPIO-A" thru "GPIO-L" are the only
+ * ones actually used for GPIO.
+ */
+
+/ {
+	model = "Qualcomm Technologies, Inc. DB820c";
+	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc", "qcom,apq8096";
+
+	aliases {
+		serial0 = &blsp2_uart2;
+		serial1 = &blsp2_uart3;
+		serial2 = &blsp1_uart2;
+		i2c0 = &blsp1_i2c3;
+		i2c1 = &blsp2_i2c1;
+		i2c2 = &blsp2_i2c1;
+		spi0 = &blsp1_spi1;
+		spi1 = &blsp2_spi6;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	div1_mclk: divclk1 {
+		compatible = "gpio-gate-clock";
+		pinctrl-0 = <&audio_mclk>;
+		pinctrl-names = "default";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 0>;
+	};
+
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_up_gpio>;
+
+		button {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	usb2_id: usb2-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&pmi8994_gpios 6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb2_vbus_det_gpio>;
+	};
+
+	usb3_id: usb3-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&pm8994_gpios 22 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_vbus_det_gpio>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	wlan_en: wlan-en-1-8v {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en_gpios>;
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8994_gpios 8 0>;
+
+		/* WLAN card specific delay */
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+};
+
+&blsp1_i2c3 {
+	/* On Low speed expansion: LS-I2C0 */
+	status = "okay";
+};
+
+&blsp1_spi1 {
+	/* On Low speed expansion */
+	status = "okay";
+};
+
+&blsp1_uart2 {
+	label = "BT-UART";
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6174-bt";
+
+		/* bt_disable_n gpio */
+		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
+
+		clocks = <&divclk4>;
+	};
+};
+
+&adsp_pil {
+	status = "okay";
+	firmware-name = "qcom/apq8096/adsp.mbn";
+};
+
+&blsp2_i2c1 {
+	/* On High speed expansion: HS-I2C2 */
+	status = "okay";
+};
+
+&blsp2_i2c1 {
+	/* On Low speed expansion: LS-I2C1 */
+	status = "okay";
+};
+
+&blsp2_spi6 {
+	/* On High speed expansion */
+	status = "okay";
+};
+
+&blsp2_uart2 {
+	label = "LS-UART1";
+	status = "okay";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart2_2pins_default>;
+	pinctrl-1 = <&blsp2_uart2_2pins_sleep>;
+};
+
+&blsp2_uart3 {
+	label = "LS-UART0";
+	status = "disabled";
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&blsp2_uart3_4pins_default>;
+	pinctrl-1 = <&blsp2_uart3_4pins_sleep>;
+};
+
+&camss {
+	vdda-supply = <&vreg_l2a_1p25>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&hsusb_phy1 {
+	status = "okay";
+
+	vdd-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&hsusb_phy2 {
+	status = "okay";
+
+	vdd-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&mdp {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_hdmi {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&hdmi_hpd_active &hdmi_ddc_active>;
+	pinctrl-1 = <&hdmi_hpd_suspend &hdmi_ddc_suspend>;
+
+	core-vdda-supply = <&vreg_l12a_1p8>;
+	core-vcc-supply = <&vreg_s4a_1p8>;
+};
+
+&mdss_hdmi_phy {
+	status = "okay";
+
+	vddio-supply = <&vreg_l12a_1p8>;
+	vcca-supply = <&vreg_l28a_0p925>;
+	#phy-cells = <0>;
+};
+
+&mmcc {
+	vdd-gfx-supply = <&vdd_gfx>;
+};
+
+&mss_pil {
+	status = "okay";
+	pll-supply = <&vreg_l12a_1p8>;
+	firmware-name = "qcom/apq8096/mba.mbn", "qcom/apq8096/modem.mbn";
+};
+
+&pm8994_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&tlmm {
+	gpio-line-names =
+		"[SPI0_DOUT]", /* GPIO_0, BLSP1_SPI_MOSI, LSEC pin 14 */
+		"[SPI0_DIN]", /* GPIO_1, BLSP1_SPI_MISO, LSEC pin 10 */
+		"[SPI0_CS]", /* GPIO_2, BLSP1_SPI_CS_N, LSEC pin 12 */
+		"[SPI0_SCLK]", /* GPIO_3, BLSP1_SPI_CLK, LSEC pin 8 */
+		"[UART1_TxD]", /* GPIO_4, BLSP8_UART_TX, LSEC pin 11 */
+		"[UART1_RxD]", /* GPIO_5, BLSP8_UART_RX, LSEC pin 13 */
+		"[I2C1_SDA]", /* GPIO_6, BLSP8_I2C_SDA, LSEC pin 21 */
+		"[I2C1_SCL]", /* GPIO_7, BLSP8_I2C_SCL, LSEC pin 19 */
+		"GPIO-H", /* GPIO_8, LCD0_RESET_N, LSEC pin 30 */
+		"TP93", /* GPIO_9 */
+		"GPIO-G", /* GPIO_10, MDP_VSYNC_P, LSEC pin 29 */
+		"[MDP_VSYNC_S]", /* GPIO_11, S HSEC pin 55 */
+		"NC", /* GPIO_12 */
+		"[CSI0_MCLK]", /* GPIO_13, CAM_MCLK0, P HSEC pin 15 */
+		"[CAM_MCLK1]", /* GPIO_14, J14 pin 11 */
+		"[CSI1_MCLK]", /* GPIO_15, CAM_MCLK2, P HSEC pin 17 */
+		"TP99", /* GPIO_16 */
+		"[I2C2_SDA]", /* GPIO_17, CCI_I2C_SDA0, P HSEC pin 34 */
+		"[I2C2_SCL]", /* GPIO_18, CCI_I2C_SCL0, P HSEC pin 32 */
+		"[CCI_I2C_SDA1]", /* GPIO_19, S HSEC pin 38 */
+		"[CCI_I2C_SCL1]", /* GPIO_20, S HSEC pin 36 */
+		"FLASH_STROBE_EN", /* GPIO_21, S HSEC pin 5 */
+		"FLASH_STROBE_TRIG", /* GPIO_22, S HSEC pin 1 */
+		"GPIO-K", /* GPIO_23, CAM2_RST_N, LSEC pin 33 */
+		"GPIO-D", /* GPIO_24, LSEC pin 26 */
+		"GPIO-I", /* GPIO_25, CAM0_RST_N, LSEC pin 31 */
+		"GPIO-J", /* GPIO_26, CAM0_STANDBY_N, LSEC pin 32 */
+		"BLSP6_I2C_SDA", /* GPIO_27 */
+		"BLSP6_I2C_SCL", /* GPIO_28 */
+		"GPIO-B", /* GPIO_29, TS0_RESET_N, LSEC pin 24 */
+		"GPIO30", /* GPIO_30, S HSEC pin 4 */
+		"HDMI_CEC", /* GPIO_31 */
+		"HDMI_DDC_CLOCK", /* GPIO_32 */
+		"HDMI_DDC_DATA", /* GPIO_33 */
+		"HDMI_HOT_PLUG_DETECT", /* GPIO_34 */
+		"PCIE0_RST_N", /* GPIO_35 */
+		"PCIE0_CLKREQ_N", /* GPIO_36 */
+		"PCIE0_WAKE", /* GPIO_37 */
+		"SD_CARD_DET_N", /* GPIO_38 */
+		"TSIF1_SYNC", /* GPIO_39, S HSEC pin 48 */
+		"W_DISABLE_N", /* GPIO_40 */
+		"[BLSP9_UART_TX]", /* GPIO_41 */
+		"[BLSP9_UART_RX]", /* GPIO_42 */
+		"[BLSP2_UART_CTS_N]", /* GPIO_43 */
+		"[BLSP2_UART_RFR_N]", /* GPIO_44 */
+		"[BLSP3_UART_TX]", /* GPIO_45 */
+		"[BLSP3_UART_RX]", /* GPIO_46 */
+		"[I2C0_SDA]", /* GPIO_47, LS_I2C0_SDA, LSEC pin 17 */
+		"[I2C0_SCL]", /* GPIO_48, LS_I2C0_SCL, LSEC pin 15 */
+		"[UART0_TxD]", /* GPIO_49, BLSP9_UART_TX, LSEC pin 5 */
+		"[UART0_RxD]", /* GPIO_50, BLSP9_UART_RX, LSEC pin 7 */
+		"[UART0_CTS]", /* GPIO_51, BLSP9_UART_CTS_N, LSEC pin 3 */
+		"[UART0_RTS]", /* GPIO_52, BLSP9_UART_RFR_N, LSEC pin 9 */
+		"[CODEC_INT1_N]", /* GPIO_53 */
+		"[CODEC_INT2_N]", /* GPIO_54 */
+		"[BLSP7_I2C_SDA]", /* GPIO_55 */
+		"[BLSP7_I2C_SCL]", /* GPIO_56 */
+		"MI2S_MCLK", /* GPIO_57, S HSEC pin 3 */
+		"[PCM_CLK]", /* GPIO_58, QUA_MI2S_SCK, LSEC pin 18 */
+		"[PCM_FS]", /* GPIO_59, QUA_MI2S_WS, LSEC pin 16 */
+		"[PCM_DO]", /* GPIO_60, QUA_MI2S_DATA0, LSEC pin 20 */
+		"[PCM_DI]", /* GPIO_61, QUA_MI2S_DATA1, LSEC pin 22 */
+		"GPIO-E", /* GPIO_62, LSEC pin 27 */
+		"TP87", /* GPIO_63 */
+		"[CODEC_RST_N]", /* GPIO_64 */
+		"[PCM1_CLK]", /* GPIO_65 */
+		"[PCM1_SYNC]", /* GPIO_66 */
+		"[PCM1_DIN]", /* GPIO_67 */
+		"[PCM1_DOUT]", /* GPIO_68 */
+		"AUDIO_REF_CLK", /* GPIO_69 */
+		"SLIMBUS_CLK", /* GPIO_70 */
+		"SLIMBUS_DATA0", /* GPIO_71 */
+		"SLIMBUS_DATA1", /* GPIO_72 */
+		"NC", /* GPIO_73 */
+		"NC", /* GPIO_74 */
+		"NC", /* GPIO_75 */
+		"NC", /* GPIO_76 */
+		"TP94", /* GPIO_77 */
+		"NC", /* GPIO_78 */
+		"TP95", /* GPIO_79 */
+		"GPIO-A", /* GPIO_80, MEMS_RESET_N, LSEC pin 23 */
+		"TP88", /* GPIO_81 */
+		"TP89", /* GPIO_82 */
+		"TP90", /* GPIO_83 */
+		"TP91", /* GPIO_84 */
+		"[SD_DAT0]", /* GPIO_85, BLSP12_SPI_MOSI, P HSEC pin 1 */
+		"[SD_CMD]", /* GPIO_86, BLSP12_SPI_MISO, P HSEC pin 11 */
+		"[SD_DAT3]", /* GPIO_87, BLSP12_SPI_CS_N, P HSEC pin 7 */
+		"[SD_SCLK]", /* GPIO_88, BLSP12_SPI_CLK, P HSEC pin 9 */
+		"TSIF1_CLK", /* GPIO_89, S HSEC pin 42 */
+		"TSIF1_EN", /* GPIO_90, S HSEC pin 46 */
+		"TSIF1_DATA", /* GPIO_91, S HSEC pin 44 */
+		"NC", /* GPIO_92 */
+		"TSIF2_CLK", /* GPIO_93, S HSEC pin 52 */
+		"TSIF2_EN", /* GPIO_94, S HSEC pin 56 */
+		"TSIF2_DATA", /* GPIO_95, S HSEC pin 54 */
+		"TSIF2_SYNC", /* GPIO_96, S HSEC pin 58 */
+		"NC", /* GPIO_97 */
+		"CAM1_STANDBY_N", /* GPIO_98 */
+		"NC", /* GPIO_99 */
+		"NC", /* GPIO_100 */
+		"[LCD1_RESET_N]", /* GPIO_101, S HSEC pin 51 */
+		"BOOT_CONFIG1", /* GPIO_102 */
+		"USB_HUB_RESET", /* GPIO_103 */
+		"CAM1_RST_N", /* GPIO_104 */
+		"NC", /* GPIO_105 */
+		"NC", /* GPIO_106 */
+		"NC", /* GPIO_107 */
+		"NC", /* GPIO_108 */
+		"NC", /* GPIO_109 */
+		"NC", /* GPIO_110 */
+		"NC", /* GPIO_111 */
+		"NC", /* GPIO_112 */
+		"PMI8994_BUA", /* GPIO_113 */
+		"PCIE2_RST_N", /* GPIO_114 */
+		"PCIE2_CLKREQ_N", /* GPIO_115 */
+		"PCIE2_WAKE", /* GPIO_116 */
+		"SSC_IRQ_0", /* GPIO_117 */
+		"SSC_IRQ_1", /* GPIO_118 */
+		"SSC_IRQ_2", /* GPIO_119 */
+		"NC", /* GPIO_120 */
+		"GPIO121", /* GPIO_121, S HSEC pin 2 */
+		"NC", /* GPIO_122 */
+		"SSC_IRQ_6", /* GPIO_123 */
+		"SSC_IRQ_7", /* GPIO_124 */
+		"GPIO-C", /* GPIO_125, TS_INT0, LSEC pin 25 */
+		"BOOT_CONFIG5", /* GPIO_126 */
+		"NC", /* GPIO_127 */
+		"NC", /* GPIO_128 */
+		"BOOT_CONFIG7", /* GPIO_129 */
+		"PCIE1_RST_N", /* GPIO_130 */
+		"PCIE1_CLKREQ_N", /* GPIO_131 */
+		"PCIE1_WAKE", /* GPIO_132 */
+		"GPIO-L", /* GPIO_133, CAM2_STANDBY_N, LSEC pin 34 */
+		"NC", /* GPIO_134 */
+		"NC", /* GPIO_135 */
+		"BOOT_CONFIG8", /* GPIO_136 */
+		"NC", /* GPIO_137 */
+		"NC", /* GPIO_138 */
+		"GPS_SSBI2", /* GPIO_139 */
+		"GPS_SSBI1", /* GPIO_140 */
+		"NC", /* GPIO_141 */
+		"NC", /* GPIO_142 */
+		"NC", /* GPIO_143 */
+		"BOOT_CONFIG6", /* GPIO_144 */
+		"NC", /* GPIO_145 */
+		"NC", /* GPIO_146 */
+		"NC", /* GPIO_147 */
+		"NC", /* GPIO_148 */
+		"NC"; /* GPIO_149 */
+
+	sdc2_cd_on: sdc2-cd-on-state {
+		pins = "gpio38";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <16>;
+	};
+
+	sdc2_cd_off: sdc2-cd-off-state {
+		pins = "gpio38";
+		function = "gpio";
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+
+	hdmi_hpd_active: hdmi-hpd-active-state {
+		pins = "gpio34";
+		function = "hdmi_hot";
+		bias-pull-down;
+		drive-strength = <16>;
+	};
+
+	hdmi_hpd_suspend: hdmi-hpd-suspend-state {
+		pins = "gpio34";
+		function = "hdmi_hot";
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+
+	hdmi_ddc_active: hdmi-ddc-active-state {
+		pins = "gpio32", "gpio33";
+		function = "hdmi_ddc";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	hdmi_ddc_suspend: hdmi-ddc-suspend-state {
+		pins = "gpio32", "gpio33";
+		function = "hdmi_ddc";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
+
+&pcie0 {
+	status = "okay";
+	perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+	vddpe-3v3-supply = <&wlan_en>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie1 {
+	status = "okay";
+	perst-gpios = <&tlmm 130 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie2 {
+	status = "okay";
+	perst-gpios = <&tlmm 114 GPIO_ACTIVE_LOW>;
+	vdda-supply = <&vreg_l28a_0p925>;
+};
+
+&pcie_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+};
+
+&pm8994_gpios {
+	gpio-line-names =
+		"NC",
+		"KEY_VOLP_N",
+		"NC",
+		"BL1_PWM",
+		"GPIO-F", /* BL0_PWM, LSEC pin 28 */
+		"BL1_EN",
+		"NC",
+		"WLAN_EN",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"NC",
+		"DIVCLK1",
+		"DIVCLK2",
+		"DIVCLK3",
+		"DIVCLK4",
+		"BT_EN",
+		"PMIC_SLB",
+		"PMIC_BUA",
+		"USB_VBUS_DET";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ls_exp_gpio_f &bt_en_gpios>;
+
+	ls_exp_gpio_f: pm8994-gpio5-state {
+		pinconf {
+			pins = "gpio5";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+		};
+	};
+
+	bt_en_gpios: bt-en-pios-state {
+		pinconf {
+			pins = "gpio19";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	wlan_en_gpios: wlan-en-gpios-state {
+		pinconf {
+			pins = "gpio8";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+			bias-pull-down;
+		};
+	};
+
+	audio_mclk: clk-div1-state {
+		pinconf {
+			pins = "gpio15";
+			function = "func1";
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+		};
+	};
+
+	volume_up_gpio: pm8996-gpio2-state {
+		pinconf {
+			pins = "gpio2";
+			function = "normal";
+			input-enable;
+			drive-push-pull;
+			bias-pull-up;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+		};
+	};
+
+	divclk4_pin_a: divclk4-state {
+		pinconf {
+			pins = "gpio18";
+			function = PMIC_GPIO_FUNC_FUNC2;
+
+			bias-disable;
+			power-source = <PM8994_GPIO_S4>;
+		};
+	};
+
+	usb3_vbus_det_gpio: pm8996-gpio22-state {
+		pinconf {
+			pins = "gpio22";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+		};
+	};
+};
+
+&pm8994_mpps {
+	gpio-line-names =
+		"VDDPX_BIAS",
+		"WIFI_LED",
+		"NC",
+		"BT_LED",
+		"PM_MPP05",
+		"PM_MPP06",
+		"PM_MPP07",
+		"NC";
+};
+
+&pm8994_spmi_regulators {
+	qcom,saw-reg = <&saw3>;
+	vdd_s11-supply = <&vph_pwr>;
+
+	s9 {
+		qcom,saw-slave;
+	};
+	s10 {
+		qcom,saw-slave;
+	};
+	s11 {
+		qcom,saw-leader;
+		regulator-name = "VDD_APCC";
+		regulator-always-on;
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
+	};
+};
+
+&pmi8994_gpios {
+	gpio-line-names =
+		"NC",
+		"SPKR_AMP_EN1",
+		"SPKR_AMP_EN2",
+		"TP61",
+		"NC",
+		"USB2_VBUS_DET",
+		"NC",
+		"NC",
+		"NC",
+		"NC";
+
+	usb2_vbus_det_gpio: pmi8996-gpio6-state {
+		pinconf {
+			pins = "gpio6";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; /* 1.8V */
+		};
+	};
+};
+
+&pmi8994_lpg {
+	qcom,power-source = <1>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmi8994_mpp2_userled4>;
+
+	qcom,dtest = <0 0>,
+		     <0 0>,
+		     <0 0>,
+		     <4 1>;
+
+	status = "okay";
+
+	led@1 {
+		reg = <1>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <1>;
+
+		linux,default-trigger = "heartbeat";
+		default-state = "on";
+	};
+
+	led@2 {
+		reg = <2>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <0>;
+	};
+
+	led@3 {
+		reg = <3>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <2>;
+	};
+
+	led@4 {
+		reg = <4>;
+		color = <LED_COLOR_ID_GREEN>;
+		function = LED_FUNCTION_HEARTBEAT;
+		function-enumerator = <3>;
+	};
+};
+
+&pmi8994_mpps {
+	pmi8994_mpp2_userled4: mpp2-userled4-state {
+		pins = "mpp2";
+		function = "sink";
+
+		output-low;
+		qcom,dtest = <4>;
+	};
+};
+
+&pmi8994_spmi_regulators {
+	vdd_s2-supply = <&vph_pwr>;
+
+	vdd_gfx: s2 {
+		regulator-name = "VDD_GFX";
+		regulator-min-microvolt = <980000>;
+		regulator-max-microvolt = <980000>;
+	};
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_l1-supply = <&vreg_s1b_1p025>;
+		vdd_l2_l26_l28-supply = <&vreg_s3a_1p3>;
+		vdd_l3_l11-supply = <&vreg_s3a_1p3>;
+		vdd_l4_l27_l31-supply = <&vreg_s3a_1p3>;
+		vdd_l5_l7-supply = <&vreg_s5a_2p15>;
+		vdd_l6_l12_l32-supply = <&vreg_s5a_2p15>;
+		vdd_l8_l16_l30-supply = <&vph_pwr>;
+		vdd_l9_l10_l18_l22-supply = <&vph_pwr_bbyp>;
+		vdd_l13_l19_l23_l24-supply = <&vph_pwr_bbyp>;
+		vdd_l14_l15-supply = <&vreg_s5a_2p15>;
+		vdd_l17_l29-supply = <&vph_pwr_bbyp>;
+		vdd_l20_l21-supply = <&vph_pwr_bbyp>;
+		vdd_l25-supply = <&vreg_s3a_1p3>;
+		vdd_lvs1_2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p3: s3 {
+			regulator-name = "vreg_s3a_1p3";
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		/**
+		 * 1.8v required on LS expansion
+		 * for mezzanine boards
+		 */
+		vreg_s4a_1p8: s4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+		vreg_s5a_2p15: s5 {
+			regulator-name = "vreg_s5a_2p15";
+			regulator-min-microvolt = <2150000>;
+			regulator-max-microvolt = <2150000>;
+		};
+		vreg_s7a_1p0: s7 {
+			regulator-name = "vreg_s7a_1p0";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		vreg_l1a_1p0: l1 {
+			regulator-name = "vreg_l1a_1p0";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l2a_1p25: l2 {
+			regulator-name = "vreg_l2a_1p25";
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1250000>;
+		};
+		vreg_l3a_0p875: l3 {
+			regulator-name = "vreg_l3a_0p875";
+			regulator-min-microvolt = <850000>;
+			regulator-max-microvolt = <850000>;
+		};
+		vreg_l4a_1p225: l4 {
+			regulator-name = "vreg_l4a_1p225";
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+		vreg_l6a_1p2: l6 {
+			regulator-name = "vreg_l6a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+		vreg_l8a_1p8: l8 {
+			regulator-name = "vreg_l8a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l9a_1p8: l9 {
+			regulator-name = "vreg_l9a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l10a_1p8: l10 {
+			regulator-name = "vreg_l10a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l11a_1p15: l11 {
+			regulator-name = "vreg_l11a_1p15";
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+		vreg_l12a_1p8: l12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l13a_2p95: l13 {
+			regulator-name = "vreg_l13a_2p95";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+		vreg_l14a_1p8: l14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l15a_1p8: l15 {
+			regulator-name = "vreg_l15a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l16a_2p7: l16 {
+			regulator-name = "vreg_l16a_2p7";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2700000>;
+		};
+		vreg_l17a_2p8: l17 {
+			regulator-name = "vreg_l17a_2p8";
+			regulator-min-microvolt = <2500000>;
+			regulator-max-microvolt = <2500000>;
+		};
+		vreg_l18a_2p85: l18 {
+			regulator-name = "vreg_l18a_2p85";
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <2900000>;
+		};
+		vreg_l19a_2p8: l19 {
+			regulator-name = "vreg_l19a_2p8";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+		};
+		vreg_l20a_2p95: l20 {
+			regulator-name = "vreg_l20a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+		};
+		vreg_l21a_2p95: l21 {
+			regulator-name = "vreg_l21a_2p95";
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+		vreg_l22a_3p0: l22 {
+			regulator-name = "vreg_l22a_3p0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+		vreg_l23a_2p8: l23 {
+			regulator-name = "vreg_l23a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l24a_3p075: l24 {
+			regulator-name = "vreg_l24a_3p075";
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+		vreg_l25a_1p2: l25 {
+			regulator-name = "vreg_l25a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+		vreg_l26a_0p8: l27 {
+			regulator-name = "vreg_l26a_0p8";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+		vreg_l28a_0p925: l28 {
+			regulator-name = "vreg_l28a_0p925";
+			regulator-min-microvolt = <925000>;
+			regulator-max-microvolt = <925000>;
+			regulator-allow-set-load;
+		};
+		vreg_l29a_2p8: l29 {
+			regulator-name = "vreg_l29a_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+		};
+		vreg_l30a_1p8: l30 {
+			regulator-name = "vreg_l30a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+		vreg_l32a_1p8: l32 {
+			regulator-name = "vreg_l32a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_lvs1a_1p8: lvs1 {
+			regulator-name = "vreg_lvs1a_1p8";
+		};
+
+		vreg_lvs2a_1p8: lvs2 {
+			regulator-name = "vreg_lvs2a_1p8";
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pmi8994-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_bst_byp-supply = <&vph_pwr>;
+
+		vph_pwr_bbyp: boost-bypass {
+			regulator-name = "vph_pwr_bbyp";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_s1b_1p025: s1 {
+			regulator-name = "vreg_s1b_1p025";
+			regulator-min-microvolt = <1025000>;
+			regulator-max-microvolt = <1025000>;
+		};
+	};
+};
+
+&sdhc2 {
+	/* External SD card */
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_state_on &sdc2_cd_on>;
+	pinctrl-1 = <&sdc2_state_off &sdc2_cd_off>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vreg_l21a_2p95>;
+	vqmmc-supply = <&vreg_l13a_2p95>;
+	status = "okay";
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
+&slim_msm {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		tasha_ifd: tas-ifd@0,0 {
+			compatible = "slim217,1a0";
+			reg = <0 0>;
+		};
+
+		wcd9335: codec@1,0 {
+			compatible = "slim217,1a0";
+			reg = <1 0>;
+
+			clock-names = "mclk", "slimbus";
+			clocks = <&div1_mclk>,
+				 <&rpmcc RPM_SMD_BB_CLK1>;
+			interrupt-parent = <&tlmm>;
+			interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+				     <53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "intr1", "intr2";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			pinctrl-0 = <&cdc_reset_active &wcd_intr_default>;
+			pinctrl-names = "default";
+
+			reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+			slim-ifc-dev = <&tasha_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			vdd-buck-supply = <&vreg_s4a_1p8>;
+			vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+			vdd-tx-supply = <&vreg_s4a_1p8>;
+			vdd-rx-supply = <&vreg_s4a_1p8>;
+			vdd-io-supply = <&vreg_s4a_1p8>;
+		};
+	};
+};
+
+&sound {
+	compatible = "qcom,apq8096-sndcard";
+	model = "DB820c";
+	audio-routing = "RX_BIAS", "MCLK",
+		"MM_DL1",  "MultiMedia1 Playback",
+		"MM_DL2",  "MultiMedia2 Playback",
+		"MultiMedia3 Capture", "MM_UL3";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI";
+		cpu {
+			sound-dai = <&q6afedai HDMI_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&mdss_hdmi 0>;
+		};
+	};
+
+	slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_6_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 AIF4_PB>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9335 AIF1_CAP>;
+		};
+	};
+};
+
+&ufsphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+};
+
+&ufshc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l25a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vdd-hba-supply = <&vreg_l25a_1p2>;
+
+	vcc-max-microamp = <600000>;
+	vccq-max-microamp = <450000>;
+	vccq2-max-microamp = <450000>;
+};
+
+&usb2 {
+	status = "okay";
+	extcon = <&usb2_id>;
+};
+
+&usb2_dwc3 {
+	extcon = <&usb2_id>;
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+};
+
+&usb3 {
+	status = "okay";
+	extcon = <&usb3_id>;
+};
+
+&usb3_dwc3 {
+	extcon = <&usb3_id>;
+	dr_mode = "otg";
+};
+
+&usb3phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l28a_0p925>;
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+};
+
+&venus {
+	status = "okay";
+};
diff --git a/arch/arm/dts/dragonboard820c-uboot.dtsi b/arch/arm/dts/dragonboard820c-uboot.dtsi
deleted file mode 100644
index d93c7c1fbdee..000000000000
--- a/arch/arm/dts/dragonboard820c-uboot.dtsi
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * U-Boot addition to handle Dragonboard 820c pins
- *
- * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
- */
-
-/ {
-	smem {
-		bootph-all;
-	};
-
-	soc {
-		bootph-all;
-
-		pinctrl@1010000 {
-			bootph-all;
-
-			uart {
-				bootph-all;
-			};
-		};
-
-		clock-controller@300000 {
-			bootph-all;
-		};
-
-		serial@75b0000 {
-			bootph-all;
-		};
-	};
-};
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
deleted file mode 100644
index 282c37e28f42..000000000000
--- a/arch/arm/dts/dragonboard820c.dts
+++ /dev/null
@@ -1,153 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm APQ8096 based Dragonboard 820C board device tree source
- *
- * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
- */
-
-/dts-v1/;
-
-#include "skeleton64.dtsi"
-#include <dt-bindings/clock/qcom,gcc-msm8996.h>
-
-/ {
-	model = "Qualcomm Technologies, Inc. DB820c";
-	compatible = "arrow,apq8096-db820c", "qcom,apq8096-sbc";
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		serial0 = &blsp2_uart2;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x80000000 0 0xc0000000>;
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		smem_mem: smem_region@86300000 {
-			reg = <0x0 0x86300000 0x0 0x200000>;
-			no-map;
-		};
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	smem {
-		compatible = "qcom,smem";
-		memory-region = <&smem_mem>;
-	};
-
-	soc: soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0xffffffff>;
-		compatible = "simple-bus";
-
-		gcc: clock-controller@300000 {
-			compatible = "qcom,gcc-msm8996";
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
-			reg = <0x300000 0x90000>;
-		};
-
-		pinctrl: pinctrl@1010000 {
-			compatible = "qcom,msm8996-pinctrl";
-			reg = <0x1010000 0x400000>;
-
-			blsp8_uart: uart {
-				function = "blsp_uart8";
-				pins = "GPIO_4", "GPIO_5";
-				drive-strength = <8>;
-				bias-disable;
-			};
-		};
-
-		blsp2_uart2: serial@75b0000 {
-			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
-			reg = <0x75b0000 0x1000>;
-			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>;
-			clock-names = "core";
-			pinctrl-names = "uart";
-			pinctrl-0 = <&blsp8_uart>;
-		};
-
-		sdhc2: sdhci@74a4900 {
-			compatible = "qcom,sdhci-msm-v4";
-			reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
-			index = <0x0>;
-			bus-width = <4>;
-			clock = <&gcc GCC_SDCC1_APPS_CLK>;
-			clock-frequency = <200000000>;
-		 };
-
-		spmi_bus: spmi@400f000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x0400f000 0x1000>,
-			      <0x04400000 0x800000>,
-			      <0x04c00000 0x800000>,
-			      <0x05800000 0x200000>,
-			      <0x0400a000 0x002100>;
-			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-
-			pmic0: pm8994@0 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x0 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
-				pm8994_pon: pon@800 {
-					compatible = "qcom,pm8916-pon";
-					reg = <0x800 0x100>;
-					mode-bootloader = <0x2>;
-					mode-recovery = <0x1>;
-
-					pwrkey {
-						compatible = "qcom,pm8941-pwrkey";
-						debounce = <15625>;
-						bias-pull-up;
-					};
-
-					pm8994_resin: resin {
-						compatible = "qcom,pm8941-resin";
-						debounce = <15625>;
-						bias-pull-up;
-					};
-				};
-
-				pm8994_gpios: pm8994_gpios@c000 {
-					compatible = "qcom,pm8994-gpio";
-					reg = <0xc000 0x400>;
-					gpio-controller;
-					gpio-ranges = <&pm8994_gpios 0 0 22>;
-					#gpio-cells = <2>;
-				};
-			};
-
-			pmic1: pm8994@1 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x1 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-			};
-		};
-	};
-
-};
-
-#include "dragonboard820c-uboot.dtsi"
diff --git a/arch/arm/dts/msm8996.dtsi b/arch/arm/dts/msm8996.dtsi
new file mode 100644
index 000000000000..6ba9da9e6a8b
--- /dev/null
+++ b/arch/arm/dts/msm8996.dtsi
@@ -0,0 +1,3884 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-msm8996.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8996.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/interconnect/qcom,msm8996.h>
+#include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
+#include <dt-bindings/firmware/qcom,scm.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	interrupt-parent = <&intc>;
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+			clock-output-names = "sleep_clk";
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		CPU0: cpu@0 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_0>;
+			L2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		CPU1: cpu@1 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 0>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster0_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_0>;
+		};
+
+		CPU2: cpu@100 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_1>;
+			L2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		CPU3: cpu@101 {
+			device_type = "cpu";
+			compatible = "qcom,kryo";
+			reg = <0x0 0x101>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			capacity-dmips-mhz = <1024>;
+			clocks = <&kryocc 1>;
+			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
+			operating-points-v2 = <&cluster1_opp>;
+			#cooling-cells = <2>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&CPU2>;
+				};
+
+				core1 {
+					cpu = <&CPU3>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x00000004>;
+				entry-latency-us = <130>;
+				exit-latency-us = <80>;
+				min-residency-us = <300>;
+			};
+		};
+	};
+
+	cluster0_opp: opp-table-cluster0 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		/* Nominal fmax for now */
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-422400000 {
+			opp-hz = /bits/ 64 <422400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
+		};
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
+		};
+		opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1228800000 {
+			opp-hz = /bits/ 64 <1228800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-supported-hw = <0xd>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
+		};
+		opp-1363200000 {
+			opp-hz = /bits/ 64 <1363200000>;
+			opp-supported-hw = <0x2>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-supported-hw = <0xd>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1132800>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-supported-hw = <0x9>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
+		};
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-supported-hw = <0x04>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1593600000 {
+			opp-hz = /bits/ 64 <1593600000>;
+			opp-supported-hw = <0x9>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
+		};
+	};
+
+	cluster1_opp: opp-table-cluster1 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+		opp-shared;
+
+		/* Nominal fmax for now */
+		opp-307200000 {
+			opp-hz = /bits/ 64 <307200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-403200000 {
+			opp-hz = /bits/ 64 <403200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-480000000 {
+			opp-hz = /bits/ 64 <480000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-556800000 {
+			opp-hz = /bits/ 64 <556800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-729600000 {
+			opp-hz = /bits/ 64 <729600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <307200>;
+		};
+		opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <384000>;
+		};
+		opp-883200000 {
+			opp-hz = /bits/ 64 <883200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <460800>;
+		};
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <537600>;
+		};
+		opp-1036800000 {
+			opp-hz = /bits/ 64 <1036800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <595200>;
+		};
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <672000>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <748800>;
+		};
+		opp-1324800000 {
+			opp-hz = /bits/ 64 <1324800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <825600>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <902400>;
+		};
+		opp-1478400000 {
+			opp-hz = /bits/ 64 <1478400000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <979200>;
+		};
+		opp-1555200000 {
+			opp-hz = /bits/ 64 <1555200000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1056000>;
+		};
+		opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1190400>;
+		};
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1228800>;
+		};
+		opp-1785600000 {
+			opp-hz = /bits/ 64 <1785600000>;
+			opp-supported-hw = <0xf>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-supported-hw = <0xe>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1382400>;
+		};
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-supported-hw = <0x4>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1305600>;
+		};
+		opp-1920000000 {
+			opp-hz = /bits/ 64 <1920000000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1459200>;
+		};
+		opp-1996800000 {
+			opp-hz = /bits/ 64 <1996800000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+		opp-2073600000 {
+			opp-hz = /bits/ 64 <2073600000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+		opp-2150400000 {
+			opp-hz = /bits/ 64 <2150400000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <200000>;
+			opp-peak-kBps = <1593600>;
+		};
+	};
+
+	firmware {
+		scm {
+			compatible = "qcom,scm-msm8996", "qcom,scm";
+			qcom,dload-mode = <&tcsr_2 0x13000>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0x0 0x80000000 0x0 0x0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	rpm: remoteproc {
+		compatible = "qcom,msm8996-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-msm8996";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-msm8996", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,msm8996-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp1: opp1 {
+							opp-level = <1>;
+						};
+
+						rpmpd_opp2: opp2 {
+							opp-level = <2>;
+						};
+
+						rpmpd_opp3: opp3 {
+							opp-level = <3>;
+						};
+
+						rpmpd_opp4: opp4 {
+							opp-level = <4>;
+						};
+
+						rpmpd_opp5: opp5 {
+							opp-level = <5>;
+						};
+
+						rpmpd_opp6: opp6 {
+							opp-level = <6>;
+						};
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hyp_mem: memory@85800000 {
+			reg = <0x0 0x85800000 0x0 0x600000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0x0 0x85e00000 0x0 0x200000>;
+			no-map;
+		};
+
+		smem_mem: smem-mem@86000000 {
+			reg = <0x0 0x86000000 0x0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@86200000 {
+			reg = <0x0 0x86200000 0x0 0x2600000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs {
+			compatible = "qcom,rmtfs-mem";
+
+			size = <0x0 0x200000>;
+			alloc-ranges = <0x0 0xa0000000 0x0 0x2000000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
+
+		mpss_mem: mpss@88800000 {
+			reg = <0x0 0x88800000 0x0 0x6200000>;
+			no-map;
+		};
+
+		adsp_mem: adsp@8ea00000 {
+			reg = <0x0 0x8ea00000 0x0 0x1b00000>;
+			no-map;
+		};
+
+		slpi_mem: slpi@90500000 {
+			reg = <0x0 0x90500000 0x0 0xa00000>;
+			no-map;
+		};
+
+		gpu_mem: gpu@90f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0x90f00000 0x0 0x100000>;
+			no-map;
+		};
+
+		venus_mem: venus@91000000 {
+			reg = <0x0 0x91000000 0x0 0x500000>;
+			no-map;
+		};
+
+		mba_mem: mba@91500000 {
+			reg = <0x0 0x91500000 0x0 0x200000>;
+			no-map;
+		};
+
+		mdata_mem: mpss-metadata {
+			alloc-ranges = <0x0 0xa0000000 0x0 0x20000000>;
+			size = <0x0 0x4000>;
+			no-map;
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_mem>;
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		mpss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		mpss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+
+		interrupts = <GIC_SPI 178 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apcs_glb 26>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		pcie_phy: phy-wrapper@34000 {
+			compatible = "qcom,msm8996-qmp-pcie-phy";
+			reg = <0x00034000 0x488>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00034000 0x4000>;
+
+			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
+				<&gcc GCC_PCIE_PHY_CFG_AHB_CLK>,
+				<&gcc GCC_PCIE_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_PCIE_PHY_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_BCR>,
+				<&gcc GCC_PCIE_PHY_COM_NOCSR_BCR>;
+			reset-names = "phy", "common", "cfg";
+
+			status = "disabled";
+
+			pciephy_0: phy@1000 {
+				reg = <0x1000 0x130>,
+				      <0x1200 0x200>,
+				      <0x1400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+				clock-names = "pipe0";
+				resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+				reset-names = "lane0";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_0_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+
+			pciephy_1: phy@2000 {
+				reg = <0x2000 0x130>,
+				      <0x2200 0x200>,
+				      <0x2400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
+				clock-names = "pipe1";
+				resets = <&gcc GCC_PCIE_1_PHY_BCR>;
+				reset-names = "lane1";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_1_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+
+			pciephy_2: phy@3000 {
+				reg = <0x3000 0x130>,
+				      <0x3200 0x200>,
+				      <0x3400 0x1dc>;
+
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
+				clock-names = "pipe2";
+				resets = <&gcc GCC_PCIE_2_PHY_BCR>;
+				reset-names = "lane2";
+
+				#clock-cells = <0>;
+				clock-output-names = "pcie_2_pipe_clk_src";
+
+				#phy-cells = <0>;
+			};
+		};
+
+		rpm_msg_ram: sram@68000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00068000 0x6000>;
+		};
+
+		qfprom@74000 {
+			compatible = "qcom,msm8996-qfprom", "qcom,qfprom";
+			reg = <0x00074000 0x8ff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qusb2p_hstx_trim: hstx_trim@24e {
+				reg = <0x24e 0x2>;
+				bits = <5 4>;
+			};
+
+			qusb2s_hstx_trim: hstx_trim@24f {
+				reg = <0x24f 0x1>;
+				bits = <1 4>;
+			};
+
+			speedbin_efuse: speedbin@133 {
+				reg = <0x133 0x1>;
+				bits = <5 3>;
+			};
+		};
+
+		rng: rng@83000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x00083000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		gcc: clock-controller@300000 {
+			compatible = "qcom,gcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x00300000 0x90000>;
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&sleep_clk>,
+				 <&pciephy_0>,
+				 <&pciephy_1>,
+				 <&pciephy_2>,
+				 <&ssusb_phy_0>,
+				 <&ufsphy_lane 0>,
+				 <&ufsphy_lane 1>,
+				 <&ufsphy_lane 2>;
+			clock-names = "cxo",
+				      "cxo2",
+				      "sleep_clk",
+				      "pcie_0_pipe_clk_src",
+				      "pcie_1_pipe_clk_src",
+				      "pcie_2_pipe_clk_src",
+				      "usb3_phy_pipe_clk_src",
+				      "ufs_rx_symbol_0_clk_src",
+				      "ufs_rx_symbol_1_clk_src",
+				      "ufs_tx_symbol_0_clk_src";
+		};
+
+		bimc: interconnect@408000 {
+			compatible = "qcom,msm8996-bimc";
+			reg = <0x00408000 0x5a000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				 <&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		tsens0: thermal-sensor@4a9000 {
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			#qcom,sensors = <13>;
+			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: thermal-sensor@4ad000 {
+			compatible = "qcom,msm8996-tsens", "qcom,tsens-v2";
+			reg = <0x004ad000 0x1000>, /* TM */
+			      <0x004ac000 0x1000>; /* SROT */
+			#qcom,sensors = <8>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow", "critical";
+			#thermal-sensor-cells = <1>;
+		};
+
+		cryptobam: dma-controller@644000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x00644000 0x24000>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_CE1_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+		};
+
+		crypto: crypto@67a000 {
+			compatible = "qcom,crypto-v5.4";
+			reg = <0x0067a000 0x6000>;
+			clocks = <&gcc GCC_CE1_AHB_CLK>,
+				 <&gcc GCC_CE1_AXI_CLK>,
+				 <&gcc GCC_CE1_CLK>;
+			clock-names = "iface", "bus", "core";
+			dmas = <&cryptobam 6>, <&cryptobam 7>;
+			dma-names = "rx", "tx";
+		};
+
+		cnoc: interconnect@500000 {
+			compatible = "qcom,msm8996-cnoc";
+			reg = <0x00500000 0x1000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_CNOC_CLK>,
+				 <&rpmcc RPM_SMD_CNOC_A_CLK>;
+		};
+
+		snoc: interconnect@524000 {
+			compatible = "qcom,msm8996-snoc";
+			reg = <0x00524000 0x1c000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+		a0noc: interconnect@543000 {
+			compatible = "qcom,msm8996-a0noc";
+			reg = <0x00543000 0x6000>;
+			#interconnect-cells = <1>;
+			clock-names = "aggre0_snoc_axi",
+				      "aggre0_cnoc_ahb",
+				      "aggre0_noc_mpu_cfg";
+			clocks = <&gcc GCC_AGGRE0_SNOC_AXI_CLK>,
+				 <&gcc GCC_AGGRE0_CNOC_AHB_CLK>,
+				 <&gcc GCC_AGGRE0_NOC_MPU_CFG_AHB_CLK>;
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+		};
+
+		a1noc: interconnect@562000 {
+			compatible = "qcom,msm8996-a1noc";
+			reg = <0x00562000 0x5000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_AGGR1_NOC_CLK>,
+				 <&rpmcc RPM_SMD_AGGR1_NOC_A_CLK>;
+		};
+
+		a2noc: interconnect@583000 {
+			compatible = "qcom,msm8996-a2noc";
+			reg = <0x00583000 0x7000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a", "aggre2_ufs_axi", "ufs_axi";
+			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
+				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				 <&gcc GCC_UFS_AXI_CLK>;
+		};
+
+		mnoc: interconnect@5a4000 {
+			compatible = "qcom,msm8996-mnoc";
+			reg = <0x005a4000 0x1c000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a", "iface";
+			clocks = <&rpmcc RPM_SMD_MMAXI_CLK>,
+				 <&rpmcc RPM_SMD_MMAXI_A_CLK>,
+				 <&mmcc AHB_CLK_SRC>;
+		};
+
+		pnoc: interconnect@5c0000 {
+			compatible = "qcom,msm8996-pnoc";
+			reg = <0x005c0000 0x3000>;
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_A_CLK>;
+		};
+
+		tcsr_mutex: hwlock@740000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x00740000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr_1: syscon@760000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x00760000 0x20000>;
+		};
+
+		tcsr_2: syscon@7a0000 {
+			compatible = "qcom,tcsr-msm8996", "syscon";
+			reg = <0x007a0000 0x18000>;
+		};
+
+		mmcc: clock-controller@8c0000 {
+			compatible = "qcom,mmcc-msm8996";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+			reg = <0x008c0000 0x40000>;
+			clocks = <&xo_board>,
+				 <&gcc GPLL0>,
+				 <&gcc GCC_MMSS_NOC_CFG_AHB_CLK>,
+				 <&mdss_dsi0_phy 1>,
+				 <&mdss_dsi0_phy 0>,
+				 <&mdss_dsi1_phy 1>,
+				 <&mdss_dsi1_phy 0>,
+				 <&mdss_hdmi_phy>;
+			clock-names = "xo",
+				      "gpll0",
+				      "gcc_mmss_noc_cfg_ahb_clk",
+				      "dsi0pll",
+				      "dsi0pllbyte",
+				      "dsi1pll",
+				      "dsi1pllbyte",
+				      "hdmipll";
+			assigned-clocks = <&mmcc MMPLL9_PLL>,
+					  <&mmcc MMPLL1_PLL>,
+					  <&mmcc MMPLL3_PLL>,
+					  <&mmcc MMPLL4_PLL>,
+					  <&mmcc MMPLL5_PLL>;
+			assigned-clock-rates = <624000000>,
+					       <810000000>,
+					       <980000000>,
+					       <960000000>,
+					       <825000000>;
+		};
+
+		mdss: display-subsystem@900000 {
+			compatible = "qcom,mdss";
+
+			reg = <0x00900000 0x1000>,
+			      <0x009b0000 0x1040>,
+			      <0x009b8000 0x1040>;
+			reg-names = "mdss_phys",
+				    "vbif_phys",
+				    "vbif_nrt_phys";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clocks = <&mmcc MDSS_AHB_CLK>,
+				 <&mmcc MDSS_MDP_CLK>;
+			clock-names = "iface", "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			status = "disabled";
+
+			mdp: display-controller@901000 {
+				compatible = "qcom,msm8996-mdp5", "qcom,mdp5";
+				reg = <0x00901000 0x90000>;
+				reg-names = "mdp_phys";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc SMMU_MDP_AXI_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				clock-names = "iface",
+					      "bus",
+					      "core",
+					      "iommu",
+					      "vsync";
+
+				iommus = <&mdp_smmu 0>;
+
+				assigned-clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_VSYNC_CLK>;
+				assigned-clock-rates = <300000000>,
+					 <19200000>;
+
+				interconnects = <&mnoc MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
+						<&mnoc MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
+						<&mnoc MASTER_ROTATOR &bimc SLAVE_EBI_CH0>;
+				interconnect-names = "mdp0-mem", "mdp1-mem", "rotator-mem";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdp5_intf3_out: endpoint {
+							remote-endpoint = <&mdss_hdmi_in>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdp5_intf1_out: endpoint {
+							remote-endpoint = <&mdss_dsi0_in>;
+						};
+					};
+
+					port@2 {
+						reg = <2>;
+						mdp5_intf2_out: endpoint {
+							remote-endpoint = <&mdss_dsi1_in>;
+						};
+					};
+				};
+			};
+
+			mdss_dsi0: dsi@994000 {
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0x00994000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <4>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE0_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK0_CLK>,
+					 <&mmcc MDSS_ESC0_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+				assigned-clocks = <&mmcc BYTE0_CLK_SRC>, <&mmcc PCLK0_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+				phys = <&mdss_dsi0_phy>;
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dsi0_in: endpoint {
+							remote-endpoint = <&mdp5_intf1_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dsi0_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi0_phy: phy@994400 {
+				compatible = "qcom,dsi-phy-14nm";
+				reg = <0x00994400 0x100>,
+				      <0x00994500 0x300>,
+				      <0x00994800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+				status = "disabled";
+			};
+
+			mdss_dsi1: dsi@996000 {
+				compatible = "qcom,msm8996-dsi-ctrl",
+					     "qcom,mdss-dsi-ctrl";
+				reg = <0x00996000 0x400>;
+				reg-names = "dsi_ctrl";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <5>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_BYTE1_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_AXI_CLK>,
+					 <&mmcc MMSS_MISC_AHB_CLK>,
+					 <&mmcc MDSS_PCLK1_CLK>,
+					 <&mmcc MDSS_ESC1_CLK>;
+				clock-names = "mdp_core",
+					      "byte",
+					      "iface",
+					      "bus",
+					      "core_mmss",
+					      "pixel",
+					      "core";
+				assigned-clocks = <&mmcc BYTE1_CLK_SRC>, <&mmcc PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+
+				phys = <&mdss_dsi1_phy>;
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_dsi1_in: endpoint {
+							remote-endpoint = <&mdp5_intf2_out>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						mdss_dsi1_out: endpoint {
+						};
+					};
+				};
+			};
+
+			mdss_dsi1_phy: phy@996400 {
+				compatible = "qcom,dsi-phy-14nm";
+				reg = <0x00996400 0x100>,
+				      <0x00996500 0x300>,
+				      <0x00996800 0x188>;
+				reg-names = "dsi_phy",
+					    "dsi_phy_lane",
+					    "dsi_pll";
+
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+
+				clocks = <&mmcc MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
+				clock-names = "iface", "ref";
+				status = "disabled";
+			};
+
+			mdss_hdmi: hdmi-tx@9a0000 {
+				compatible = "qcom,hdmi-tx-8996";
+				reg = <0x009a0000 0x50c>,
+				      <0x00070000 0x6158>,
+				      <0x009e0000 0xfff>;
+				reg-names = "core_physical",
+					    "qfprom_physical",
+					    "hdcp_physical";
+
+				interrupt-parent = <&mdss>;
+				interrupts = <8>;
+
+				clocks = <&mmcc MDSS_MDP_CLK>,
+					 <&mmcc MDSS_AHB_CLK>,
+					 <&mmcc MDSS_HDMI_CLK>,
+					 <&mmcc MDSS_HDMI_AHB_CLK>,
+					 <&mmcc MDSS_EXTPCLK_CLK>;
+				clock-names =
+					"mdp_core",
+					"iface",
+					"core",
+					"alt_iface",
+					"extp";
+
+				phys = <&mdss_hdmi_phy>;
+				#sound-dai-cells = <1>;
+
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						mdss_hdmi_in: endpoint {
+							remote-endpoint = <&mdp5_intf3_out>;
+						};
+					};
+				};
+			};
+
+			mdss_hdmi_phy: phy@9a0600 {
+				#phy-cells = <0>;
+				compatible = "qcom,hdmi-phy-8996";
+				reg = <0x009a0600 0x1c4>,
+				      <0x009a0a00 0x124>,
+				      <0x009a0c00 0x124>,
+				      <0x009a0e00 0x124>,
+				      <0x009a1000 0x124>,
+				      <0x009a1200 0x0c8>;
+				reg-names = "hdmi_pll",
+					    "hdmi_tx_l0",
+					    "hdmi_tx_l1",
+					    "hdmi_tx_l2",
+					    "hdmi_tx_l3",
+					    "hdmi_phy";
+
+				clocks = <&mmcc MDSS_AHB_CLK>,
+					 <&gcc GCC_HDMI_CLKREF_CLK>,
+					 <&xo_board>;
+				clock-names = "iface",
+					      "ref",
+					      "xo";
+
+				#clock-cells = <0>;
+
+				status = "disabled";
+			};
+		};
+
+		gpu: gpu@b00000 {
+			compatible = "qcom,adreno-530.2", "qcom,adreno";
+
+			reg = <0x00b00000 0x3f000>;
+			reg-names = "kgsl_3d0_reg_memory";
+
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&mmcc GPU_GX_GFX3D_CLK>,
+				<&mmcc GPU_AHB_CLK>,
+				<&mmcc GPU_GX_RBBMTIMER_CLK>,
+				<&gcc GCC_BIMC_GFX_CLK>,
+				<&gcc GCC_MMSS_BIMC_GFX_CLK>;
+
+			clock-names = "core",
+				"iface",
+				"rbbmtimer",
+				"mem",
+				"mem_iface";
+
+			interconnects = <&bimc MASTER_GRAPHICS_3D &bimc SLAVE_EBI_CH0>;
+			interconnect-names = "gfx-mem";
+
+			power-domains = <&mmcc GPU_GX_GDSC>;
+			iommus = <&adreno_smmu 0>;
+
+			nvmem-cells = <&speedbin_efuse>;
+			nvmem-cell-names = "speed_bin";
+
+			operating-points-v2 = <&gpu_opp_table>;
+
+			status = "disabled";
+
+			#cooling-cells = <2>;
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				/*
+				 * 624Mhz is only available on speed bins 0 and 3.
+				 * 560Mhz is only available on speed bins 0, 2 and 3.
+				 * All the rest are available on all bins of the hardware.
+				 */
+				opp-624000000 {
+					opp-hz = /bits/ 64 <624000000>;
+					opp-supported-hw = <0x09>;
+				};
+				opp-560000000 {
+					opp-hz = /bits/ 64 <560000000>;
+					opp-supported-hw = <0x0d>;
+				};
+				opp-510000000 {
+					opp-hz = /bits/ 64 <510000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-401800000 {
+					opp-hz = /bits/ 64 <401800000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-315000000 {
+					opp-hz = /bits/ 64 <315000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-214000000 {
+					opp-hz = /bits/ 64 <214000000>;
+					opp-supported-hw = <0xff>;
+				};
+				opp-133000000 {
+					opp-hz = /bits/ 64 <133000000>;
+					opp-supported-hw = <0xff>;
+				};
+			};
+
+			zap-shader {
+				memory-region = <&gpu_mem>;
+			};
+		};
+
+		tlmm: pinctrl@1010000 {
+			compatible = "qcom,msm8996-pinctrl";
+			reg = <0x01010000 0x300000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			gpio-ranges = <&tlmm 0 0 150>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				spi-pins {
+					pins = "gpio0", "gpio1", "gpio3";
+					function = "blsp_spi1";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio2";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp1_spi1_sleep: blsp1-spi1-sleep-state {
+				pins = "gpio0", "gpio1", "gpio2", "gpio3";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_uart2_2pins_default: blsp2-uart2-2pins-state {
+				pins = "gpio4", "gpio5";
+				function = "blsp_uart8";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_uart2_2pins_sleep: blsp2-uart2-2pins-sleep-state {
+				pins = "gpio4", "gpio5";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_default: blsp2-i2c2-state {
+				pins = "gpio6", "gpio7";
+				function = "blsp_i2c8";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c2_sleep: blsp2-i2c2-sleep-state {
+				pins = "gpio6", "gpio7";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c6_default: blsp1-i2c6-state {
+				pins = "gpio27", "gpio28";
+				function = "blsp_i2c6";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_i2c6_sleep: blsp1-i2c6-sleep-state {
+				pins = "gpio27", "gpio28";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci0_default: cci0-default-state {
+				pins = "gpio17", "gpio18";
+				function = "cci_i2c";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			camera0_state_on:
+			camera_rear_default: camera-rear-default-state {
+				camera0_mclk: mclk0-pins {
+					pins = "gpio13";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera0_rst: rst-pins {
+					pins = "gpio25";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera0_pwdn: pwdn-pins {
+					pins = "gpio26";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			cci1_default: cci1-default-state {
+				pins = "gpio19", "gpio20";
+				function = "cci_i2c";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			camera1_state_on:
+			camera_board_default: camera-board-default-state {
+				mclk1-pins {
+					pins = "gpio14";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				pwdn-pins {
+					pins = "gpio98";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				rst-pins {
+					pins = "gpio104";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			camera2_state_on:
+			camera_front_default: camera-front-default-state {
+				camera2_mclk: mclk2-pins {
+					pins = "gpio15";
+					function = "cam_mclk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				camera2_rst: rst-pins {
+					pins = "gpio23";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				pwdn-pins {
+					pins = "gpio133";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+				};
+			};
+
+			pcie0_state_on: pcie0-state-on-state {
+				perst-pins {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio36";
+					function = "pci_e0";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio37";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			pcie0_state_off: pcie0-state-off-state {
+				perst-pins {
+					pins = "gpio35";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio36";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio37";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			blsp1_uart2_default: blsp1-uart2-default-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_uart2";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_uart2_sleep: blsp1-uart2-sleep-state {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp1_i2c3_default: blsp1-i2c3-default-state {
+				pins = "gpio47", "gpio48";
+				function = "blsp_i2c3";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_i2c3_sleep: blsp1-i2c3-sleep-state {
+				pins = "gpio47", "gpio48";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_uart3_4pins_default: blsp2-uart3-4pins-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_uart9";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_uart3_4pins_sleep: blsp2-uart3-4pins-sleep-state {
+				pins = "gpio49", "gpio50", "gpio51", "gpio52";
+				function = "blsp_uart9";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c3_default: blsp2-i2c3-state-state {
+				pins = "gpio51", "gpio52";
+				function = "blsp_i2c9";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c3_sleep: blsp2-i2c3-sleep-state {
+				pins = "gpio51", "gpio52";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			wcd_intr_default: wcd-intr-default-state {
+				pins = "gpio54";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_i2c1_default: blsp2-i2c1-state {
+				pins = "gpio55", "gpio56";
+				function = "blsp_i2c7";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c1_sleep: blsp2-i2c1-sleep-state {
+				pins = "gpio55", "gpio56";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			blsp2_i2c5_default: blsp2-i2c5-state {
+				pins = "gpio60", "gpio61";
+				function = "blsp_i2c11";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			/* Sleep state for BLSP2_I2C5 is missing.. */
+
+			cdc_reset_active: cdc-reset-active-state {
+				pins = "gpio64";
+				function = "gpio";
+				drive-strength = <16>;
+				bias-pull-down;
+				output-high;
+			};
+
+			cdc_reset_sleep: cdc-reset-sleep-state {
+				pins = "gpio64";
+				function = "gpio";
+				drive-strength = <16>;
+				bias-disable;
+				output-low;
+			};
+
+			blsp2_spi6_default: blsp2-spi6-default-state {
+				spi-pins {
+					pins = "gpio85", "gpio86", "gpio88";
+					function = "blsp_spi12";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs-pins {
+					pins = "gpio87";
+					function = "gpio";
+					drive-strength = <16>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			blsp2_spi6_sleep: blsp2-spi6-sleep-state {
+				pins = "gpio85", "gpio86", "gpio87", "gpio88";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			blsp2_i2c6_default: blsp2-i2c6-state {
+				pins = "gpio87", "gpio88";
+				function = "blsp_i2c12";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp2_i2c6_sleep: blsp2-i2c6-sleep-state {
+				pins = "gpio87", "gpio88";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			pcie1_state_on: pcie1-on-state {
+				perst-pins {
+					pins = "gpio130";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio131";
+					function = "pci_e1";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio132";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			pcie1_state_off: pcie1-off-state {
+				/* Perst is missing? */
+				clkreq-pins {
+					pins = "gpio131";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio132";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			pcie2_state_on: pcie2-on-state {
+				perst-pins {
+					pins = "gpio114";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				clkreq-pins {
+					pins = "gpio115";
+					function = "pci_e2";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				wake-pins {
+					pins = "gpio116";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			pcie2_state_off: pcie2-off-state {
+				/* Perst is missing? */
+				clkreq-pins {
+					pins = "gpio115";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				wake-pins {
+					pins = "gpio116";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			sdc1_state_on: sdc1-on-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc1_state_off: sdc1-off-state {
+				clk-pins {
+					pins = "sdc1_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd-pins {
+					pins = "sdc1_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data-pins {
+					pins = "sdc1_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				rclk-pins {
+					pins = "sdc1_rclk";
+					bias-pull-down;
+				};
+			};
+
+			sdc2_state_on: sdc2-on-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <16>;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <10>;
+				};
+			};
+
+			sdc2_state_off: sdc2-off-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					bias-disable;
+					drive-strength = <2>;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					bias-pull-up;
+					drive-strength = <2>;
+				};
+			};
+		};
+
+		sram@290000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x00290000 0x10000>;
+		};
+
+		spmi_bus: spmi@400f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0400f000 0x1000>,
+			      <0x04400000 0x800000>,
+			      <0x04c00000 0x800000>,
+			      <0x05800000 0x200000>,
+			      <0x0400a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		bus@0 {
+			power-domains = <&gcc AGGRE0_NOC_GDSC>;
+			compatible = "simple-pm-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0xffffffff>;
+
+			pcie0: pcie@600000 {
+				compatible = "qcom,pcie-msm8996";
+				status = "disabled";
+				power-domains = <&gcc PCIE0_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				reg = <0x00600000 0x2000>,
+				      <0x0c000000 0xf1d>,
+				      <0x0c000f20 0xa8>,
+				      <0x0c100000 0x100000>;
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_0>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0c200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0c300000 0x0c300000 0x0 0xd00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie0_state_on>;
+				pinctrl-1 = <&pcie0_state_off>;
+
+				linux,pci-domain = <0>;
+
+				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+					<&gcc GCC_PCIE_0_AUX_CLK>,
+					<&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie1: pcie@608000 {
+				compatible = "qcom,pcie-msm8996";
+				power-domains = <&gcc PCIE1_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+
+				status = "disabled";
+
+				reg = <0x00608000 0x2000>,
+				      <0x0d000000 0xf1d>,
+				      <0x0d000f20 0xa8>,
+				      <0x0d100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_1>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0d200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0d300000 0x0d300000 0x0 0xd00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 413 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 272 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 273 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 274 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 275 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie1_state_on>;
+				pinctrl-1 = <&pcie1_state_off>;
+
+				linux,pci-domain = <1>;
+
+				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
+					<&gcc GCC_PCIE_1_AUX_CLK>,
+					<&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_1_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+
+			pcie2: pcie@610000 {
+				compatible = "qcom,pcie-msm8996";
+				power-domains = <&gcc PCIE2_GDSC>;
+				bus-range = <0x00 0xff>;
+				num-lanes = <1>;
+				status = "disabled";
+				reg = <0x00610000 0x2000>,
+				      <0x0e000000 0xf1d>,
+				      <0x0e000f20 0xa8>,
+				      <0x0e100000 0x100000>;
+
+				reg-names = "parf", "dbi", "elbi","config";
+
+				phys = <&pciephy_2>;
+				phy-names = "pciephy";
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x0e200000 0x0 0x100000>,
+					 <0x02000000 0x0 0x0e300000 0x0e300000 0x0 0x1d00000>;
+
+				device_type = "pci";
+
+				interrupts = <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 0x7>;
+				interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+						<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+						<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+						<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&pcie2_state_on>;
+				pinctrl-1 = <&pcie2_state_off>;
+
+				linux,pci-domain = <2>;
+				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>,
+					<&gcc GCC_PCIE_2_AUX_CLK>,
+					<&gcc GCC_PCIE_2_CFG_AHB_CLK>,
+					<&gcc GCC_PCIE_2_MSTR_AXI_CLK>,
+					<&gcc GCC_PCIE_2_SLV_AXI_CLK>;
+
+				clock-names = "pipe",
+						"aux",
+						"cfg",
+						"bus_master",
+						"bus_slave";
+			};
+		};
+
+		ufshc: ufshc@624000 {
+			compatible = "qcom,msm8996-ufshc", "qcom,ufshc",
+				     "jedec,ufs-2.0";
+			reg = <0x00624000 0x2500>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
+
+			phys = <&ufsphy_lane>;
+			phy-names = "ufsphy";
+
+			power-domains = <&gcc UFS_GDSC>;
+
+			clock-names =
+				"core_clk_src",
+				"core_clk",
+				"bus_clk",
+				"bus_aggr_clk",
+				"iface_clk",
+				"core_clk_unipro_src",
+				"core_clk_unipro",
+				"core_clk_ice",
+				"ref_clk",
+				"tx_lane0_sync_clk",
+				"rx_lane0_sync_clk";
+			clocks =
+				<&gcc UFS_AXI_CLK_SRC>,
+				<&gcc GCC_UFS_AXI_CLK>,
+				<&gcc GCC_SYS_NOC_UFS_AXI_CLK>,
+				<&gcc GCC_AGGRE2_UFS_AXI_CLK>,
+				<&gcc GCC_UFS_AHB_CLK>,
+				<&gcc UFS_ICE_CORE_CLK_SRC>,
+				<&gcc GCC_UFS_UNIPRO_CORE_CLK>,
+				<&gcc GCC_UFS_ICE_CORE_CLK>,
+				<&rpmcc RPM_SMD_LN_BB_CLK>,
+				<&gcc GCC_UFS_TX_SYMBOL_0_CLK>,
+				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
+			freq-table-hz =
+				<100000000 200000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<150000000 300000000>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>,
+				<0 0>;
+
+			interconnects = <&a2noc MASTER_UFS &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &cnoc SLAVE_UFS_CFG>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
+			lanes-per-direction = <1>;
+			#reset-cells = <1>;
+			status = "disabled";
+		};
+
+		ufsphy: phy@627000 {
+			compatible = "qcom,msm8996-qmp-ufs-phy";
+			reg = <0x00627000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref";
+
+			resets = <&ufshc 0>;
+			reset-names = "ufsphy";
+			status = "disabled";
+
+			ufsphy_lane: phy@627400 {
+				reg = <0x627400 0x12c>,
+				      <0x627600 0x200>,
+				      <0x627c00 0x1b4>;
+				#clock-cells = <1>;
+				#phy-cells = <0>;
+			};
+		};
+
+		camss: camss@a34000 {
+			compatible = "qcom,msm8996-camss";
+			reg = <0x00a34000 0x1000>,
+			      <0x00a00030 0x4>,
+			      <0x00a35000 0x1000>,
+			      <0x00a00038 0x4>,
+			      <0x00a36000 0x1000>,
+			      <0x00a00040 0x4>,
+			      <0x00a30000 0x100>,
+			      <0x00a30400 0x100>,
+			      <0x00a30800 0x100>,
+			      <0x00a30c00 0x100>,
+			      <0x00a31000 0x500>,
+			      <0x00a00020 0x10>,
+			      <0x00a10000 0x1000>,
+			      <0x00a14000 0x1000>;
+			reg-names = "csiphy0",
+				"csiphy0_clk_mux",
+				"csiphy1",
+				"csiphy1_clk_mux",
+				"csiphy2",
+				"csiphy2_clk_mux",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"csi_clk_mux",
+				"vfe0",
+				"vfe1";
+			interrupts = <GIC_SPI 78 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 79 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 80 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
+				<GIC_SPI 315 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "csiphy0",
+				"csiphy1",
+				"csiphy2",
+				"csid0",
+				"csid1",
+				"csid2",
+				"csid3",
+				"ispif",
+				"vfe0",
+				"vfe1";
+			power-domains = <&mmcc VFE0_GDSC>,
+					<&mmcc VFE1_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				<&mmcc CAMSS_ISPIF_AHB_CLK>,
+				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI1PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI2PHYTIMER_CLK>,
+				<&mmcc CAMSS_CSI0_AHB_CLK>,
+				<&mmcc CAMSS_CSI0_CLK>,
+				<&mmcc CAMSS_CSI0PHY_CLK>,
+				<&mmcc CAMSS_CSI0PIX_CLK>,
+				<&mmcc CAMSS_CSI0RDI_CLK>,
+				<&mmcc CAMSS_CSI1_AHB_CLK>,
+				<&mmcc CAMSS_CSI1_CLK>,
+				<&mmcc CAMSS_CSI1PHY_CLK>,
+				<&mmcc CAMSS_CSI1PIX_CLK>,
+				<&mmcc CAMSS_CSI1RDI_CLK>,
+				<&mmcc CAMSS_CSI2_AHB_CLK>,
+				<&mmcc CAMSS_CSI2_CLK>,
+				<&mmcc CAMSS_CSI2PHY_CLK>,
+				<&mmcc CAMSS_CSI2PIX_CLK>,
+				<&mmcc CAMSS_CSI2RDI_CLK>,
+				<&mmcc CAMSS_CSI3_AHB_CLK>,
+				<&mmcc CAMSS_CSI3_CLK>,
+				<&mmcc CAMSS_CSI3PHY_CLK>,
+				<&mmcc CAMSS_CSI3PIX_CLK>,
+				<&mmcc CAMSS_CSI3RDI_CLK>,
+				<&mmcc CAMSS_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_CLK>,
+				<&mmcc CAMSS_CSI_VFE0_CLK>,
+				<&mmcc CAMSS_VFE0_AHB_CLK>,
+				<&mmcc CAMSS_VFE0_STREAM_CLK>,
+				<&mmcc CAMSS_VFE1_CLK>,
+				<&mmcc CAMSS_CSI_VFE1_CLK>,
+				<&mmcc CAMSS_VFE1_AHB_CLK>,
+				<&mmcc CAMSS_VFE1_STREAM_CLK>,
+				<&mmcc CAMSS_VFE_AHB_CLK>,
+				<&mmcc CAMSS_VFE_AXI_CLK>;
+			clock-names = "top_ahb",
+				"ispif_ahb",
+				"csiphy0_timer",
+				"csiphy1_timer",
+				"csiphy2_timer",
+				"csi0_ahb",
+				"csi0",
+				"csi0_phy",
+				"csi0_pix",
+				"csi0_rdi",
+				"csi1_ahb",
+				"csi1",
+				"csi1_phy",
+				"csi1_pix",
+				"csi1_rdi",
+				"csi2_ahb",
+				"csi2",
+				"csi2_phy",
+				"csi2_pix",
+				"csi2_rdi",
+				"csi3_ahb",
+				"csi3",
+				"csi3_phy",
+				"csi3_pix",
+				"csi3_rdi",
+				"ahb",
+				"vfe0",
+				"csi_vfe0",
+				"vfe0_ahb",
+				"vfe0_stream",
+				"vfe1",
+				"csi_vfe1",
+				"vfe1_ahb",
+				"vfe1_stream",
+				"vfe_ahb",
+				"vfe_axi";
+			iommus = <&vfe_smmu 0>,
+				 <&vfe_smmu 1>,
+				 <&vfe_smmu 2>,
+				 <&vfe_smmu 3>;
+			status = "disabled";
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci: cci@a0c000 {
+			compatible = "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xa0c000 0x1000>;
+			interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&mmcc CAMSS_GDSC>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CLK>,
+				 <&mmcc CAMSS_AHB_CLK>;
+			clock-names = "camss_top_ahb",
+				      "cci_ahb",
+				      "cci",
+				      "camss_ahb";
+			assigned-clocks = <&mmcc CAMSS_CCI_AHB_CLK>,
+					  <&mmcc CAMSS_CCI_CLK>;
+			assigned-clock-rates = <80000000>, <37500000>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&cci0_default &cci1_default>;
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		adreno_smmu: iommu@b40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,adreno-smmu", "qcom,smmu-v2";
+			reg = <0x00b40000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+
+			clocks = <&gcc GCC_MMSS_BIMC_GFX_CLK>,
+				 <&mmcc GPU_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&mmcc GPU_GDSC>;
+		};
+
+		venus: video-codec@c00000 {
+			compatible = "qcom,msm8996-venus";
+			reg = <0x00c00000 0xff000>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc VENUS_GDSC>;
+			clocks = <&mmcc VIDEO_CORE_CLK>,
+				 <&mmcc VIDEO_AHB_CLK>,
+				 <&mmcc VIDEO_AXI_CLK>,
+				 <&mmcc VIDEO_MAXI_CLK>;
+			clock-names = "core", "iface", "bus", "mbus";
+			interconnects = <&mnoc MASTER_VIDEO_P0 &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &mnoc SLAVE_VENUS_CFG>;
+			interconnect-names = "video-mem", "cpu-cfg";
+			iommus = <&venus_smmu 0x00>,
+				 <&venus_smmu 0x01>,
+				 <&venus_smmu 0x0a>,
+				 <&venus_smmu 0x07>,
+				 <&venus_smmu 0x0e>,
+				 <&venus_smmu 0x0f>,
+				 <&venus_smmu 0x08>,
+				 <&venus_smmu 0x09>,
+				 <&venus_smmu 0x0b>,
+				 <&venus_smmu 0x0c>,
+				 <&venus_smmu 0x0d>,
+				 <&venus_smmu 0x10>,
+				 <&venus_smmu 0x11>,
+				 <&venus_smmu 0x21>,
+				 <&venus_smmu 0x28>,
+				 <&venus_smmu 0x29>,
+				 <&venus_smmu 0x2b>,
+				 <&venus_smmu 0x2c>,
+				 <&venus_smmu 0x2d>,
+				 <&venus_smmu 0x31>;
+			memory-region = <&venus_mem>;
+			status = "disabled";
+
+			video-decoder {
+				compatible = "venus-decoder";
+				clocks = <&mmcc VIDEO_SUBCORE0_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE0_GDSC>;
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+				clocks = <&mmcc VIDEO_SUBCORE1_CLK>;
+				clock-names = "core";
+				power-domains = <&mmcc VENUS_CORE1_GDSC>;
+			};
+		};
+
+		mdp_smmu: iommu@d00000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00d00000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			clocks = <&mmcc SMMU_MDP_AXI_CLK>,
+				 <&mmcc SMMU_MDP_AHB_CLK>;
+			clock-names = "bus", "iface";
+
+			power-domains = <&mmcc MDSS_GDSC>;
+		};
+
+		venus_smmu: iommu@d40000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00d40000 0x20000>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_VIDEO_GDSC>;
+			clocks = <&mmcc SMMU_VIDEO_AXI_CLK>,
+				 <&mmcc SMMU_VIDEO_AHB_CLK>;
+			clock-names = "bus", "iface";
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
+		vfe_smmu: iommu@da0000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x00da0000 0x10000>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&mmcc MMAGIC_CAMSS_GDSC>;
+			clocks = <&mmcc SMMU_VFE_AXI_CLK>,
+				 <&mmcc SMMU_VFE_AHB_CLK>;
+			clock-names = "bus", "iface";
+			#iommu-cells = <1>;
+		};
+
+		lpass_q6_smmu: iommu@1600000 {
+			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
+			reg = <0x01600000 0x20000>;
+			#iommu-cells = <1>;
+			power-domains = <&gcc HLOS1_VOTE_LPASS_CORE_GDSC>;
+
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+		                <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_HLOS1_VOTE_LPASS_ADSP_SMMU_CLK>,
+				 <&gcc GCC_HLOS1_VOTE_LPASS_CORE_SMMU_CLK>;
+			clock-names = "bus", "iface";
+		};
+
+		slpi_pil: remoteproc@1c00000 {
+			compatible = "qcom,msm8996-slpi-pil";
+			reg = <0x01c00000 0x4000>;
+
+			interrupts-extended = <&intc 0 390 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&slpi_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&xo_board>,
+				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+			clock-names = "xo", "aggre2";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,smem-states = <&slpi_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			power-domains = <&rpmpd MSM8996_VDDSSCX>;
+			power-domain-names = "ssc_cx";
+
+			status = "disabled";
+
+			smd-edge {
+				interrupts = <GIC_SPI 176 IRQ_TYPE_EDGE_RISING>;
+
+				label = "dsps";
+				mboxes = <&apcs_glb 25>;
+				qcom,smd-edge = <3>;
+				qcom,remote-pid = <3>;
+			};
+		};
+
+		mss_pil: remoteproc@2080000 {
+			compatible = "qcom,msm8996-mss-pil";
+			reg = <0x2080000 0x100>,
+			      <0x2180000 0x020>;
+			reg-names = "qdsp6", "rmb";
+
+			interrupts-extended = <&intc 0 448 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&mpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
+				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
+				 <&gcc GCC_BOOT_ROM_AHB_CLK>,
+				 <&xo_board>,
+				 <&gcc GCC_MSS_GPLL0_DIV_CLK>,
+				 <&gcc GCC_MSS_SNOC_AXI_CLK>,
+				 <&gcc GCC_MSS_MNOC_BIMC_AXI_CLK>,
+				 <&rpmcc RPM_SMD_PCNOC_CLK>,
+				 <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "iface", "bus", "mem", "xo", "gpll0_mss",
+				      "snoc_axi", "mnoc_axi", "pnoc", "qdss";
+
+			resets = <&gcc GCC_MSS_RESTART>;
+			reset-names = "mss_restart";
+
+			power-domains = <&rpmpd MSM8996_VDDCX>,
+					<&rpmpd MSM8996_VDDMX>;
+			power-domain-names = "cx", "mx";
+
+			qcom,smem-states = <&mpss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			qcom,halt-regs = <&tcsr_1 0x3000 0x5000 0x4000>;
+
+			status = "disabled";
+
+			mba {
+				memory-region = <&mba_mem>;
+			};
+
+			mpss {
+				memory-region = <&mpss_mem>;
+			};
+
+			metadata {
+				memory-region = <&mdata_mem>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+
+				label = "mpss";
+				mboxes = <&apcs_glb 12>;
+				qcom,smd-edge = <0>;
+				qcom,remote-pid = <1>;
+			};
+		};
+
+		stm@3002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x3002000 0x1000>,
+			      <0x8280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint =
+						  <&funnel0_in>;
+					};
+				};
+			};
+		};
+
+		tpiu@3020000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x3020000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out1>;
+					};
+				};
+			};
+		};
+
+		funnel@3021000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3021000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@7 {
+					reg = <7>;
+					funnel0_in: endpoint {
+						remote-endpoint =
+						  <&stm_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel0_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		funnel@3022000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3022000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@6 {
+					reg = <6>;
+					funnel1_in: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					funnel1_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3023000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3023000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+
+			out-ports {
+				port {
+					funnel2_out: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_in2>;
+					};
+				};
+			};
+		};
+
+		funnel@3025000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3025000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&funnel1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					merge_funnel_in2: endpoint {
+						remote-endpoint =
+						  <&funnel2_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&etf_in>;
+					};
+				};
+			};
+		};
+
+		replicator@3026000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x3026000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint =
+						  <&etf_out>;
+					};
+				};
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint =
+						  <&etr_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint =
+						  <&tpiu_in>;
+					};
+				};
+			};
+		};
+
+		etf@3027000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3027000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint =
+						  <&merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint =
+						  <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etr@3028000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x3028000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+			arm,scatter-gather;
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint =
+						  <&replicator_out0>;
+					};
+				};
+			};
+		};
+
+		debug@3810000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3810000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU0>;
+		};
+
+		etm@3840000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3840000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU0>;
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3910000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3910000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU1>;
+		};
+
+		etm@3940000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3940000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU1>;
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@39b0000 { /* APSS Funnel 0 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x39b0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel0_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3a10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3a10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU2>;
+		};
+
+		etm@3a40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3a40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU2>;
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in0>;
+					};
+				};
+			};
+		};
+
+		debug@3b10000 {
+			compatible = "arm,coresight-cpu-debug", "arm,primecell";
+			reg = <0x3b10000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU3>;
+		};
+
+		etm@3b40000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x3b40000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			cpu = <&CPU3>;
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bb0000 { /* APSS Funnel 1 */
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bb0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_funnel1_in0: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_funnel1_in1: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_funnel1_out: endpoint {
+						remote-endpoint =
+						  <&apss_merge_funnel_in1>;
+					};
+				};
+			};
+		};
+
+		funnel@3bc0000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x3bc0000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
+			clock-names = "apb_pclk", "atclk";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					apss_merge_funnel_in0: endpoint {
+						remote-endpoint =
+						  <&apss_funnel0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					apss_merge_funnel_in1: endpoint {
+						remote-endpoint =
+						  <&apss_funnel1_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					apss_merge_funnel_out: endpoint {
+						remote-endpoint =
+						  <&funnel1_in>;
+					};
+				};
+			};
+		};
+
+		kryocc: clock-controller@6400000 {
+			compatible = "qcom,msm8996-apcc";
+			reg = <0x06400000 0x90000>;
+
+			clock-names = "xo", "sys_apcs_aux";
+			clocks = <&rpmcc RPM_SMD_XO_A_CLK_SRC>, <&apcs_glb>;
+
+			#clock-cells = <1>;
+		};
+
+		usb3: usb@6af8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x06af8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq", "ss_phy_irq";
+
+			clocks = <&gcc GCC_SYS_NOC_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
+
+			interconnects = <&a2noc MASTER_USB3 &bimc SLAVE_EBI_CH0>,
+					<&bimc MASTER_AMPSS_M0 &snoc SLAVE_USB3>;
+			interconnect-names = "usb-ddr", "apps-usb";
+
+			power-domains = <&gcc USB30_GDSC>;
+			status = "disabled";
+
+			usb3_dwc3: usb@6a00000 {
+				compatible = "snps,dwc3";
+				reg = <0x06a00000 0xcc00>;
+				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy1>, <&ssusb_phy_0>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,hird-threshold = /bits/ 8 <0>;
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+				snps,is-utmi-l1-suspend;
+				tx-fifo-resize;
+			};
+		};
+
+		usb3phy: phy@7410000 {
+			compatible = "qcom,msm8996-qmp-usb3-phy";
+			reg = <0x07410000 0x1c4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_USB3_CLKREF_CLK>;
+			clock-names = "aux", "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				<&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "phy", "common";
+			status = "disabled";
+
+			ssusb_phy_0: phy@7410200 {
+				reg = <0x07410200 0x200>,
+				      <0x07410400 0x130>,
+				      <0x07410600 0x1a8>;
+				#phy-cells = <0>;
+
+				#clock-cells = <0>;
+				clock-output-names = "usb3_phy_pipe_clk_src";
+				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
+				clock-names = "pipe0";
+			};
+		};
+
+		hsusb_phy1: phy@7411000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07411000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX1_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
+			nvmem-cells = <&qusb2p_hstx_trim>;
+			status = "disabled";
+		};
+
+		hsusb_phy2: phy@7412000 {
+			compatible = "qcom,msm8996-qusb2-phy";
+			reg = <0x07412000 0x180>;
+			#phy-cells = <0>;
+
+			clocks = <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
+				<&gcc GCC_RX2_USB2_CLKREF_CLK>;
+			clock-names = "cfg_ahb", "ref";
+
+			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
+			nvmem-cells = <&qusb2s_hstx_trim>;
+			status = "disabled";
+		};
+
+		sdhc1: mmc@7464900 {
+			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x07464900 0x11c>, <0x07464000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				<&gcc GCC_SDCC1_APPS_CLK>,
+				<&rpmcc RPM_SMD_XO_CLK_SRC>;
+			resets = <&gcc GCC_SDCC1_BCR>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_state_on>;
+			pinctrl-1 = <&sdc1_state_off>;
+
+			bus-width = <8>;
+			non-removable;
+			status = "disabled";
+		};
+
+		sdhc2: mmc@74a4900 {
+			compatible = "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4";
+			reg = <0x074a4900 0x314>, <0x074a4000 0x800>;
+			reg-names = "hc", "core";
+
+			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+				<&gcc GCC_SDCC2_APPS_CLK>,
+				<&rpmcc RPM_SMD_XO_CLK_SRC>;
+			resets = <&gcc GCC_SDCC2_BCR>;
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc2_state_on>;
+			pinctrl-1 = <&sdc2_state_off>;
+
+			bus-width = <4>;
+			status = "disabled";
+		 };
+
+		blsp1_dma: dma-controller@7544000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07544000 0x2b000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			qcom,controlled-remotely;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp1_uart2: serial@7570000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07570000 0x1000>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
+			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi@7575000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07575000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_spi1_default>;
+			pinctrl-1 = <&blsp1_spi1_sleep>;
+			dmas = <&blsp1_dma 12>, <&blsp1_dma 13>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c3: i2c@7577000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07577000 0x1000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c3_default>;
+			pinctrl-1 = <&blsp1_i2c3_sleep>;
+			dmas = <&blsp1_dma 16>, <&blsp1_dma 17>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c6: i2c@757a000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x757a000 0x1000>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_i2c6_default>;
+			pinctrl-1 = <&blsp1_i2c6_sleep>;
+			dmas = <&blsp1_dma 22>, <&blsp1_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_dma: dma-controller@7584000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07584000 0x2b000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			qcom,controlled-remotely;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
+
+		blsp2_uart2: serial@75b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b0000 0x1000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_uart3: serial@75b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x075b1000 0x1000>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART3_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			status = "disabled";
+		};
+
+		blsp2_i2c1: i2c@75b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b5000 0x1000>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c1_default>;
+			pinctrl-1 = <&blsp2_i2c1_sleep>;
+			dmas = <&blsp2_dma 12>, <&blsp2_dma 13>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c2: i2c@75b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b6000 0x1000>;
+			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c2_default>;
+			pinctrl-1 = <&blsp2_i2c2_sleep>;
+			dmas = <&blsp2_dma 14>, <&blsp2_dma 15>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c3: i2c@75b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x075b7000 0x1000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			clock-frequency = <400000>;
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c3_default>;
+			pinctrl-1 = <&blsp2_i2c3_sleep>;
+			dmas = <&blsp2_dma 16>, <&blsp2_dma 17>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c5: i2c@75b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x75b9000 0x1000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP5_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_i2c5_default>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_i2c6: i2c@75ba000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x75ba000 0x1000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_i2c6_default>;
+			pinctrl-1 = <&blsp2_i2c6_sleep>;
+			dmas = <&blsp2_dma 22>, <&blsp2_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_spi6: spi@75ba000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x075ba000 0x600>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP6_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp2_spi6_default>;
+			pinctrl-1 = <&blsp2_spi6_sleep>;
+			dmas = <&blsp2_dma 22>, <&blsp2_dma 23>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2: usb@76f8800 {
+			compatible = "qcom,msm8996-dwc3", "qcom,dwc3";
+			reg = <0x076f8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hs_phy_irq";
+
+			clocks = <&gcc GCC_PERIPH_NOC_USB20_AHB_CLK>,
+				<&gcc GCC_USB20_MASTER_CLK>,
+				<&gcc GCC_USB20_MOCK_UTMI_CLK>,
+				<&gcc GCC_USB20_SLEEP_CLK>,
+				<&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>;
+			clock-names = "cfg_noc",
+				      "core",
+				      "iface",
+				      "sleep",
+				      "mock_utmi";
+
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB20_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <60000000>;
+
+			power-domains = <&gcc USB30_GDSC>;
+			qcom,select-utmi-as-pipe-clk;
+			status = "disabled";
+
+			usb2_dwc3: usb@7600000 {
+				compatible = "snps,dwc3";
+				reg = <0x07600000 0xcc00>;
+				interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&hsusb_phy2>;
+				phy-names = "usb2-phy";
+				maximum-speed = "high-speed";
+				snps,dis_u2_susphy_quirk;
+				snps,dis_enblslpm_quirk;
+			};
+		};
+
+		slimbam: dma-controller@9184000 {
+			compatible = "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0x09184000 0x32000>;
+			num-channels = <31>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+		};
+
+		slim_msm: slim-ngd@91c0000 {
+			compatible = "qcom,slim-ngd-v1.5.0";
+			reg = <0x091c0000 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&slimbam 3>, <&slimbam 4>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+		};
+
+		adsp_pil: remoteproc@9300000 {
+			compatible = "qcom,msm8996-adsp-pil";
+			reg = <0x09300000 0x80000>;
+
+			interrupts-extended = <&intc 0 162 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			power-domains = <&rpmpd MSM8996_VDDCX>;
+			power-domain-names = "cx";
+
+			status = "disabled";
+
+			smd-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				label = "lpass";
+				mboxes = <&apcs_glb 8>;
+				qcom,smd-edge = <1>;
+				qcom,remote-pid = <2>;
+
+				apr {
+					power-domains = <&gcc HLOS1_VOTE_LPASS_ADSP_GDSC>;
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							dai@1 {
+								reg = <1>;
+							};
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&lpass_q6_smmu 1>;
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+			};
+		};
+
+		apcs_glb: mailbox@9820000 {
+			compatible = "qcom,msm8996-apcs-hmss-global";
+			reg = <0x09820000 0x1000>;
+
+			#mbox-cells = <1>;
+			#clock-cells = <0>;
+		};
+
+		timer@9840000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x09840000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@9850000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09850000 0x1000>,
+				      <0x09860000 0x1000>;
+			};
+
+			frame@9870000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09870000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@9880000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09880000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@9890000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x09890000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98a0000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098a0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98b0000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098b0000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@98c0000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x098c0000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		saw3: syscon@9a10000 {
+			compatible = "syscon";
+			reg = <0x09a10000 0x1000>;
+		};
+
+		cbf: clock-controller@9a11000 {
+			compatible = "qcom,msm8996-cbf";
+			reg = <0x09a11000 0x10000>;
+			clocks = <&rpmcc RPM_SMD_XO_A_CLK_SRC>, <&apcs_glb>;
+			#clock-cells = <0>;
+			#interconnect-cells = <1>;
+		};
+
+		intc: interrupt-controller@9bc0000 {
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x40000>;
+			reg = <0x09bc0000 0x10000>,
+			      <0x09c00000 0x100000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	sound: sound {
+	};
+
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 3>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu0_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 5>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu1_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 8>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu2_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 10>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu3_crit: cpu-crit {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-top-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 6>;
+
+			trips {
+				gpu1_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-bottom-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 7>;
+
+			trips {
+				gpu2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		m4m-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 1>;
+
+			trips {
+				m4m_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		l3-or-venus-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 2>;
+
+			trips {
+				l3_or_venus_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster0-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 7>;
+
+			trips {
+				cluster0_l2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster1-l2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens0 12>;
+
+			trips {
+				cluster1_l2_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		camera-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 1>;
+
+			trips {
+				camera_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-dsp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 2>;
+
+			trips {
+				q6_dsp_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		mem-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 3>;
+
+			trips {
+				mem_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		modemtx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens1 4>;
+
+			trips {
+				modemtx_alert0: trip-point0 {
+					temperature = <90000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index 5a8cfb7d7a25..b622f309cc48 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x804000
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
 CONFIG_ENV_SIZE=0x4000
-CONFIG_DEFAULT_DEVICE_TREE="dragonboard820c"
+CONFIG_DEFAULT_DEVICE_TREE="apq8096-db820c"
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 820C"
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_DISTRO_DEFAULTS=y

-- 
2.42.1

