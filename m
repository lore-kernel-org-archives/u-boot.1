Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC746C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9D087E1E;
	Mon, 11 Mar 2024 12:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JXMqDPnv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11FA487DD3; Mon, 11 Mar 2024 12:11:21 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB4A087F69
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f25fso1743037b3a.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155475; x=1710760275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OEWLc6mLFoiSUhzbGt+0UkUaS2XPrJ2LAOzkTRtTRow=;
 b=JXMqDPnv9kin94CzpcxZP5lXKOBCTRGnBH1ymRuBtzeQusrTTGzTi4TwDiYR1RhqR/
 J2/YkYw4oFOuj3w1VEmPCgzbkbxjO01bXlJsOeTP+wWcHB52TJ8FsM17PTxB3PtKU9Hx
 ti8Z71QnDNheSQZIPyFYRIB4AnViueIeCN+aUAuv9/JZSYT/dlArfolTuJPFzg52OFva
 cdQMxFLhj9W3llSkdLFxo+NxQNcex18Ya7wBT4xDWaw/D4auEC4A/ug4N/9M2tbHKmWs
 3US09IVymlLGTY62ta6uNXn1KoxGk9NskYsScfShZVQlcJ7n+CH8PJhWJb4gfxIevwI+
 guBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155475; x=1710760275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OEWLc6mLFoiSUhzbGt+0UkUaS2XPrJ2LAOzkTRtTRow=;
 b=RSf3oGkz/0WmKEhGkQecaYiWe7mA+1JXnhHCVzaKotfzbYbThWZV4dtXlEjtfeWAU/
 iG/kYBRpAOsMquYm2dx/2IGi1YgHA+aWNHbdI7+FZBqFGQMbT+qo/EubsLuRhANSyRbn
 FT9hFhAjinqqdkCxYq0Iex9HGP0cbqEsuuzKuH/DYybUQp+JjXeTcwmrloURQqqq+Gcc
 f1Zk0jM6NSjn9OCYB0LjA70Ij7FG8J70QeZLhX2FWs5NbwItL1RlZKvztnZih7H4MQEh
 8bxeYusUIdcxv9AGZxuNK1LuxDft2Rh4ppqyXsPPS9igDxIe914mxPgpWB9ms2XBEWec
 yWyg==
X-Gm-Message-State: AOJu0Ywe8I0PraV85AnyNqmI9f3WO5S10+/WdIvmWUPYwKHNk1PXefKm
 so0P4bhBuMTgKWsm8ttZ82EMRzOccNyWzosjmjmX2tfVB5YCZAkOrOdM285KnPYX7lDdBghLqOY
 8
X-Google-Smtp-Source: AGHT+IFZod2UHEngjepNwlep1me1CQcvX3SqQby/Wad5jTi9kf5a08BqQrpHEc/d28KtMF1hdVqfKA==
X-Received: by 2002:a05:6a21:328f:b0:1a1:6a45:98db with SMTP id
 yt15-20020a056a21328f00b001a16a4598dbmr4256465pzb.2.1710155474661; 
 Mon, 11 Mar 2024 04:11:14 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:11:14 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 5/5] board: add support for Schneider HMIBSC board
Date: Mon, 11 Mar 2024 16:40:26 +0530
Message-Id: <20240311111027.44577-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311111027.44577-1-sumit.garg@linaro.org>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
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

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 2GiB RAM
- 64GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI

Features enabled in U-Boot:
- RAUC updates
- Environment protection
- USB based ethernet adaptors

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/dts/apq8016-hmibsc.dts    | 496 +++++++++++++++++++++++++++++
 board/schneider/hmibsc/MAINTAINERS |   6 +
 configs/hmibsc_defconfig           |  87 +++++
 doc/board/index.rst                |   1 +
 doc/board/schneider/hmibsc.rst     |  45 +++
 doc/board/schneider/index.rst      |   9 +
 include/configs/hmibsc.h           |  57 ++++
 7 files changed, 701 insertions(+)
 create mode 100644 arch/arm/dts/apq8016-hmibsc.dts
 create mode 100644 board/schneider/hmibsc/MAINTAINERS
 create mode 100644 configs/hmibsc_defconfig
 create mode 100644 doc/board/schneider/hmibsc.rst
 create mode 100644 doc/board/schneider/index.rst
 create mode 100644 include/configs/hmibsc.h

diff --git a/arch/arm/dts/apq8016-hmibsc.dts b/arch/arm/dts/apq8016-hmibsc.dts
new file mode 100644
index 00000000000..490ab5fd2fa
--- /dev/null
+++ b/arch/arm/dts/apq8016-hmibsc.dts
@@ -0,0 +1,496 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Linaro Ltd.
+ */
+
+/dts-v1/;
+
+#include "msm8916-pm8916.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
+
+/ {
+	model = "Schneider Electric HMIBSC Board";
+	compatible = "qcom,apq8016-hmibsc", "qcom,apq8016";
+
+	aliases {
+		serial0 = &blsp_uart1;
+		serial1 = &blsp_uart2;
+		usid0 = &pm8916_0;
+		i2c1 = &blsp_i2c6;
+		i2c3 = &blsp_i2c4;
+		i2c4 = &blsp_i2c3;
+		spi0 = &blsp_spi5;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	memory@80000000 {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+
+	reserved-memory {
+		ramoops@bff00000 {
+			compatible = "ramoops";
+			reg = <0x0 0xbff00000 0x0 0x100000>;
+
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+		};
+	};
+
+	usb2513 {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
+		initial-mode = <1>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_id_default>;
+	};
+
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7533_out>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&msm_key_volp_n_default>;
+
+		button {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pm8916_mpps_leds>;
+
+		compatible = "gpio-leds";
+
+		led@5 {
+			label = "apq8016-hmibsc:green:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led@6 {
+			label = "apq8016-hmibsc:yellow:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
+	};
+};
+
+&blsp_i2c4 {
+	status = "okay";
+	label = "I2C2";
+
+	adv_bridge: bridge@39 {
+		status = "okay";
+
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,dsi-lanes = <4>;
+		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
+		clock-names = "cec";
+
+		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
+
+		avdd-supply = <&pm8916_l6>;
+		a2vdd-supply = <&pm8916_l6>;
+		dvdd-supply = <&pm8916_l6>;
+		pvdd-supply = <&pm8916_l6>;
+		v1p2-supply = <&pm8916_l6>;
+		v3p3-supply = <&pm8916_l17>;
+
+		pinctrl-names = "default","sleep";
+		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
+		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
+		#sound-dai-cells = <1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7533_in: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				adv7533_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
+&blsp_i2c6 {
+	status = "okay";
+	label = "I2C1";
+
+	rtc1: s35390a@30 {
+		compatible = "sii,s35390a";
+		reg = <0x30>;
+	};
+
+	eeprom1: 24c256@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&blsp_i2c3 {
+	status = "okay";
+	label = "I2C4";
+
+	eeprom: 24c32@50 {
+		compatible = "onsemi,24c32";
+		reg = <0x50>;
+	};
+};
+
+&blsp_spi5 {
+	status = "okay";
+	label = "SPI0";
+	cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
+
+	tpm@0 {
+		compatible = "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
+
+&blsp_uart1 {
+	status = "okay";
+	label = "UART0";
+};
+
+&blsp_uart2 {
+	status = "okay";
+	label = "UART1";
+};
+
+&lpass {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&adv7533_in>;
+};
+
+&pm8916_0 {
+	pon@800 {
+		pwrkey {
+			status = "okay";
+			interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+		};
+	};
+};
+
+&pm8916_codec {
+	status = "okay";
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+};
+
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+};
+
+&sound {
+	status = "okay";
+
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
+	model = "DB410c";
+	audio-routing =
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+
+	quaternary-dai-link {
+		link-name = "ADV7533";
+		cpu {
+			sound-dai = <&lpass MI2S_QUATERNARY>;
+		};
+		codec {
+			sound-dai = <&adv_bridge 0>;
+		};
+	};
+
+	primary-dai-link {
+		link-name = "WCD";
+		cpu {
+			sound-dai = <&lpass MI2S_PRIMARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
+		};
+	};
+
+	tertiary-dai-link {
+		link-name = "WCD-Capture";
+		cpu {
+			sound-dai = <&lpass MI2S_TERTIARY>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
+		};
+	};
+};
+
+&usb {
+	status = "okay";
+	extcon = <&usb_id>, <&usb_id>;
+
+	pinctrl-names = "default", "device";
+	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
+	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&wcnss {
+	status = "okay";
+	firmware-name = "qcom/apq8016/wcnss.mbn";
+};
+
+&wcnss_ctrl {
+	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
+};
+
+/* Enable CoreSight */
+&cti0 { status = "okay"; };
+&cti1 { status = "okay"; };
+&cti12 { status = "okay"; };
+&cti13 { status = "okay"; };
+&cti14 { status = "okay"; };
+&cti15 { status = "okay"; };
+&debug0 { status = "okay"; };
+&debug1 { status = "okay"; };
+&debug2 { status = "okay"; };
+&debug3 { status = "okay"; };
+&etf { status = "okay"; };
+&etm0 { status = "okay"; };
+&etm1 { status = "okay"; };
+&etm2 { status = "okay"; };
+&etm3 { status = "okay"; };
+&etr { status = "okay"; };
+&funnel0 { status = "okay"; };
+&funnel1 { status = "okay"; };
+&replicator { status = "okay"; };
+&stm { status = "okay"; };
+&tpiu { status = "okay"; };
+
+/*
+ * 2mA drive strength is not enough when connecting multiple
+ * I2C devices with different pull up resistors.
+ */
+
+&blsp_i2c4_default {
+	drive-strength = <16>;
+};
+
+&blsp_i2c6_default {
+	drive-strength = <16>;
+};
+
+&tlmm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio_rs232_high &gpio_rs232_low>;
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	adv7533_int_active: adv533-int-active-state {
+		pins = "gpio31";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_int_suspend: adv7533-int-suspend-state {
+		pins = "gpio31";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	adv7533_switch_active: adv7533-switch-active-state {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_switch_suspend: adv7533-switch-suspend-state {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_key_volp_n_default: msm-key-volp-n-default-state {
+		pins = "gpio107";
+		function = "gpio";
+
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	gpio_rs232_high: gpio_rs232_high {
+		bootph-all;
+		pins = "gpio99";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+
+	gpio_rs232_low: gpio_rs232_low {
+		bootph-all;
+		pins = "gpio100";
+		function = "gpio";
+
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&pm8916_gpios {
+	gpio-line-names =
+		"USB_HUB_RESET_N_PM",
+		"USB_SW_SEL_PM";
+
+	usb_hub_reset_pm: usb-hub-reset-pm-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		input-disable;
+		output-high;
+	};
+
+	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		output-low;
+	};
+
+	usb_sw_sel_pm: usb-sw-sel-pm-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-high;
+	};
+
+	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-low;
+	};
+};
+
+&pm8916_mpps {
+	gpio-line-names =
+		"WLAN_LED_CTRL",
+		"BT_LED_CTRL";
+
+	pm8916_mpps_leds: pm8916-mpps-state {
+		pins = "mpp2", "mpp3";
+		function = "digital";
+
+		output-low;
+	};
+};
+
+&blsp_uart1_default {
+	bootph-all;
+};
diff --git a/board/schneider/hmibsc/MAINTAINERS b/board/schneider/hmibsc/MAINTAINERS
new file mode 100644
index 00000000000..0f31bbda966
--- /dev/null
+++ b/board/schneider/hmibsc/MAINTAINERS
@@ -0,0 +1,6 @@
+HMIBSC BOARD
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	board/schneider/hmibsc/
+F:	include/configs/hmibsc.h
+F:	configs/hmibsc_defconfig
diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
new file mode 100644
index 00000000000..02b9615114b
--- /dev/null
+++ b/configs/hmibsc_defconfig
@@ -0,0 +1,87 @@
+CONFIG_ARM=y
+CONFIG_SYS_BOARD="hmibsc"
+CONFIG_COUNTER_FREQUENCY=19000000
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x8f600000
+CONFIG_SYS_MALLOC_LEN=0x802000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8007fff0
+CONFIG_ENV_SIZE=0x2000
+CONFIG_ENV_OFFSET=0x0
+CONFIG_DEFAULT_DEVICE_TREE="apq8016-hmibsc"
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_IDENT_STRING="\nSchneider Electric-HMIBSC"
+CONFIG_SYS_LOAD_ADDR=0x80080000
+CONFIG_REMAKE_ELF=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_FIT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_CBSIZE=2048
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+CONFIG_SYS_PROMPT="hmibsc => "
+CONFIG_SYS_MAXARGS=64
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_FS_GENERIC=y
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_MD5SUM=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_USB=y
+CONFIG_BOOTP_BOOTFILESIZE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_ENV_FLAGS=y
+CONFIG_CMD_ENV_EXISTS=y
+CONFIG_CMD_NVEDIT_INFO=y
+CONFIG_ENV_WRITEABLE_LIST=y
+CONFIG_ENV_ACCESS_IGNORE_FORCE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=2
+CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_APQ8016=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x91000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SPMI_MSM=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_MSM=y
+CONFIG_USB_ULPI_VIEWPORT=y
+CONFIG_USB_ULPI=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_PHYLIB=y
+CONFIG_USB_ETHER_LAN75XX=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_CI_UDC=y
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 62357c99388..bc6c27a8457 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -42,6 +42,7 @@ Board-specific doc
    renesas/index
    rockchip/index
    samsung/index
+   schneider/index
    sielaff/index
    siemens/index
    sifive/index
diff --git a/doc/board/schneider/hmibsc.rst b/doc/board/schneider/hmibsc.rst
new file mode 100644
index 00000000000..f09fb5af1b3
--- /dev/null
+++ b/doc/board/schneider/hmibsc.rst
@@ -0,0 +1,45 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
+
+HMIBSC
+======
+
+The HMIBSC is an IIoT Edge Box Core board based on the Qualcomm APQ8016E SoC.
+More information can be found on the `SE product page`_.
+
+U-Boot can be used as a replacement for Qualcomm's original Android bootloader
+(a fork of Little Kernel/LK). Like LK, it is installed directly into the ``aboot``
+partition. Note that the U-Boot port used to be loaded as an Android boot image
+through LK. This is no longer the case, now U-Boot can replace LK entirely.
+
+.. _SE product page: https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
+
+Build steps
+-----------
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, build U-Boot for ``hmibsc``::
+
+  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+  $ make hmibsc_defconfig
+  $ make
+
+This will build ``u-boot.elf`` in the configured output directory.
+
+Installation
+------------
+
+Although the HMIBSC does not have secure boot set up by default, the firmware
+still expects firmware ELF images to be "signed". The signature does not provide
+any security in this case, but it provides the firmware with some required
+metadata.
+
+To "sign" ``u-boot.elf`` you can use e.g. `qtestsign`_::
+
+  $ ./qtestsign.py aboot u-boot.elf
+
+Then install the resulting ``u-boot-test-signed.mbn`` to the ``aboot`` partition
+on your device, e.g. with ``fastboot flash aboot u-boot-test-signed.mbn``.
+
+U-Boot should be running after a reboot (``fastboot reboot``).
+
+.. _qtestsign: https://github.com/msm8916-mainline/qtestsign
diff --git a/doc/board/schneider/index.rst b/doc/board/schneider/index.rst
new file mode 100644
index 00000000000..55792ed3100
--- /dev/null
+++ b/doc/board/schneider/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Schneider Electric
+==================
+
+.. toctree::
+   :maxdepth: 2
+
+   hmibsc
diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
new file mode 100644
index 00000000000..66dfa549ce1
--- /dev/null
+++ b/include/configs/hmibsc.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Board configuration file for HMIBSC
+ *
+ * (C) Copyright 2024 Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#ifndef __CONFIGS_HMIBSC_H
+#define __CONFIGS_HMIBSC_H
+
+/* PHY needs a longer aneg time */
+#define PHY_ANEG_TIMEOUT		8000
+
+#define HMIBSC_BOOTCOMMAND \
+	"setenv devtype mmc; setenv devnum 0; " \
+	"test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
+	"test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
+	"test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
+	"setenv raucslot; " \
+	"for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
+	"  if test \"x${raucslot}\" != \"x\"; then " \
+	"      echo \"skip remaining slots...\"; " \
+	"  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
+	"    if test ${BOOT_A_LEFT} -gt 0; then " \
+	"      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
+	"      echo \"Found valid RAUC slot A\"; " \
+	"      setenv raucslot \"rauc.slot=A\"; " \
+	"      setenv raucpart A; setenv distro_bootpart 6;" \
+	"    fi; " \
+	"  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
+	"    if test ${BOOT_B_LEFT} -gt 0; then " \
+	"      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
+	"      echo \"Found valid RAUC slot B\"; " \
+	"      setenv raucslot \"rauc.slot=B\"; " \
+	"      setenv raucpart B; setenv distro_bootpart 7;" \
+	"    fi; " \
+	"  fi; " \
+	"done; " \
+	"if test -n \"${raucslot}\"; then " \
+	"  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
+	"  saveenv; " \
+	"else " \
+	"  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
+	"  setenv BOOT_A_LEFT 3; " \
+	"  setenv BOOT_B_LEFT 3; " \
+	"  saveenv; " \
+	"  reset; " \
+	"fi; " \
+	"load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
+
+#define CFG_EXTRA_ENV_SETTINGS \
+	"loadaddr=0x90000000\0" \
+	"bootcmd="	HMIBSC_BOOTCOMMAND		"\0"
+
+#define CFG_ENV_FLAGS_LIST_STATIC "BOOT_A_LEFT:dw,BOOT_B_LEFT:dw,BOOT_ORDER:sw"
+
+#endif
-- 
2.34.1

