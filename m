Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42996C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9858820E;
	Fri, 12 Apr 2024 11:55:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aG9T+wIG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0897881CA; Fri, 12 Apr 2024 11:55:24 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC45881FC
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-23333ef4a02so510708fac.1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915719; x=1713520519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82/TQ1E39pwtMwQ9JBj4/O/enzIBlJlLMvA9T9zvATs=;
 b=aG9T+wIG90n5r+LNMrzTSMOkvwVOptIEgEGZrRhQaZ8igjp42oMPeRlsyPbuWxZbDA
 V77YxVsm+8kMJsoNZ6DhLhmnjSzkdEvJpL5JgjN4pcUnEMzvjO074HKXKM/kqMTEgjai
 4QRxbQy3SnEhi0r/OlBH1sz2pcGaV986m5XoqwWRkoIQwKugzsafp849vsY4RB6JCMjT
 E5IDCOE74/x3P6N9z9owJ8IUX69h8uhNzAGFgp/apYz8S1/4YdZX13Xmc9qnlwzZVu/a
 64Sv9zwFo4nAL4+9vukjpX52UnpYhrQiz6p+pbRpZAM+d27GblcewLpQdOznooGQQWbx
 yS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915719; x=1713520519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82/TQ1E39pwtMwQ9JBj4/O/enzIBlJlLMvA9T9zvATs=;
 b=aVNR6aVt2ox+xT8DSVnsfq4qCARyNU+hzy/VYtatcVV1SLQkEz+CG++3TH6A1Z/LH/
 sxXMWO+4WZZOzaH9VnuRpEGCOZF6VgIDHMX00Re3ezsZK4Eb7Lbs6ki194EZc9TFKCNH
 mtWX+nwCHtpxmCNtrcqrkIL3HcozLUHVZdbhsWIos1bddtp/Aw5pklW0+UhxhIpgRHFw
 Lzyw3elQ9bkG7moic6NlBJ9WeYkRYs0pux/ZjgbAnzZ5oT6mZG9/rAvTZobDFkUpRWyA
 +oCOQ37XEx75y/VGypo1fiTPQjY+psDCWGULjLDHFBLtm7L/oEqQcWPKlp8dvcCryTE9
 F5Mg==
X-Gm-Message-State: AOJu0YzxM5gsq8f5qkbAY2hnSaAYO7wTMeWfOMzn20Vv2AjR5a5pxTxv
 RxMeGlOGFwEwxN0A+E+ViHYi1Mw2FML5nUBLEuAW43vhx+oPRnj3PGdyJu2K104dkSRBWzBFMRF
 c
X-Google-Smtp-Source: AGHT+IGJuWUJgXW6XpNgIEhc09D0mYuL3lK2g8xP6Fmzllhqlgvw2f4x/GgXXfZWI9YOIFMpEny8/g==
X-Received: by 2002:a05:6870:f694:b0:22c:ca8c:d133 with SMTP id
 el20-20020a056870f69400b0022cca8cd133mr2314398oab.23.1712915718718; 
 Fri, 12 Apr 2024 02:55:18 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:55:18 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 6/7] arm: dts: qcom: Add Schneider HMIBSC board dts
Date: Fri, 12 Apr 2024 15:24:37 +0530
Message-Id: <20240412095438.410570-7-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Schneider HMIBSC board dts has already been reviewed upstream on the
linux-arm-msm mailing list. So once it comes through the Linux kernel
release cycle into the U-Boot dts/upstream subtree, a switch to
OF_UPSTREAM can be made. For the time being maintain the U-Boot copy.

Link: https://lore.kernel.org/linux-kernel/20240403043416.3800259-4-sumit.garg@linaro.org/
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/dts/apq8016-schneider-hmibsc.dts | 491 ++++++++++++++++++++++
 1 file changed, 491 insertions(+)
 create mode 100644 arch/arm/dts/apq8016-schneider-hmibsc.dts

diff --git a/arch/arm/dts/apq8016-schneider-hmibsc.dts b/arch/arm/dts/apq8016-schneider-hmibsc.dts
new file mode 100644
index 00000000000..75c6137e5a1
--- /dev/null
+++ b/arch/arm/dts/apq8016-schneider-hmibsc.dts
@@ -0,0 +1,491 @@
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
+	compatible = "schneider,apq8016-hmibsc", "qcom,apq8016";
+
+	aliases {
+		i2c1 = &blsp_i2c6;
+		i2c3 = &blsp_i2c4;
+		i2c4 = &blsp_i2c3;
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
+		serial0 = &blsp_uart1;
+		serial1 = &blsp_uart2;
+		spi0 = &blsp_spi5;
+		usid0 = &pm8916_0;
+	};
+
+	chosen {
+		stdout-path = "serial0";
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
+		pinctrl-0 = <&msm_key_volp_n_default>;
+		pinctrl-names = "default";
+
+		button {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pm8916_mpps_leds>;
+		pinctrl-names = "default";
+
+		led-1 {
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
+			gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+
+		led-2 {
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "bluetooth-power";
+			default-state = "off";
+		};
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
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
+	usb-hub {
+		compatible = "smsc,usb3503";
+		reset-gpios = <&pm8916_gpios 1 GPIO_ACTIVE_LOW>;
+		initial-mode = <1>;
+	};
+
+	usb_id: usb-id {
+		compatible = "linux,extcon-usb-gpio";
+		id-gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&blsp_i2c3 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+	};
+};
+
+&blsp_i2c4 {
+	status = "okay";
+
+	adv_bridge: bridge@39 {
+		compatible = "adi,adv7533";
+		reg = <0x39>;
+		interrupts-extended = <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+
+		adi,dsi-lanes = <4>;
+		clocks = <&rpmcc RPM_SMD_BB_CLK2>;
+		clock-names = "cec";
+		pd-gpios = <&tlmm 32 GPIO_ACTIVE_HIGH>;
+
+		avdd-supply = <&pm8916_l6>;
+		a2vdd-supply = <&pm8916_l6>;
+		dvdd-supply = <&pm8916_l6>;
+		pvdd-supply = <&pm8916_l6>;
+		v1p2-supply = <&pm8916_l6>;
+		v3p3-supply = <&pm8916_l17>;
+
+		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
+		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
+		pinctrl-names = "default","sleep";
+		#sound-dai-cells = <0>;
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
+
+	rtc@30 {
+		compatible = "sii,s35390a";
+		reg = <0x30>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c256";
+		reg = <0x50>;
+	};
+};
+
+&blsp_spi5 {
+	cs-gpios = <&tlmm 18 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	tpm@0 {
+		compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+	};
+};
+
+&blsp_uart1 {
+	label = "UART0";
+	status = "okay";
+};
+
+&blsp_uart2 {
+	label = "UART1";
+	status = "okay";
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
+&pm8916_codec {
+	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+	status = "okay";
+};
+
+&pm8916_gpios {
+	gpio-line-names =
+		"USB_HUB_RESET_N_PM",
+		"USB_SW_SEL_PM",
+		"NC",
+		"NC";
+
+	usb_hub_reset_pm: usb-hub-reset-pm-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		input-disable;
+		output-high;
+	};
+
+	usb_hub_reset_pm_device: usb-hub-reset-pm-device-state {
+		pins = "gpio1";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		input-disable;
+		output-low;
+	};
+
+	usb_sw_sel_pm: usb-sw-sel-pm-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-high;
+	};
+
+	usb_sw_sel_pm_device: usb-sw-sel-pm-device-state {
+		pins = "gpio2";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		power-source = <PM8916_GPIO_VPH>;
+		input-disable;
+		output-low;
+	};
+};
+
+&pm8916_mpps {
+	gpio-line-names =
+		"NC",
+		"WLAN_LED_CTRL",
+		"BT_LED_CTRL",
+		"NC";
+
+	pm8916_mpps_leds: pm8916-mpps-state {
+		pins = "mpp2", "mpp3";
+		function = "digital";
+		output-low;
+	};
+};
+
+&pm8916_resin {
+	linux,code = <KEY_POWER>;
+	status = "okay";
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
+	pinctrl-0 = <&sdc2_default &sdc2_cd_default>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_cd_default>;
+	pinctrl-names = "default", "sleep";
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sound {
+	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
+	pinctrl-1 = <&cdc_pdm_sleep &sec_mi2s_sleep>;
+	pinctrl-names = "default", "sleep";
+	model = "HMIBSC";
+	audio-routing =
+		"AMIC2", "MIC BIAS Internal2",
+		"AMIC3", "MIC BIAS External1";
+	status = "okay";
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
+&tlmm {
+	pinctrl-0 = <&uart1_mux0_rs232_high &uart1_mux1_rs232_low>;
+	pinctrl-names = "default";
+
+	adv7533_int_active: adv533-int-active-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_int_suspend: adv7533-int-suspend-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	adv7533_switch_active: adv7533-switch-active-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	adv7533_switch_suspend: adv7533-switch-suspend-state {
+		pins = "gpio32";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_key_volp_n_default: msm-key-volp-n-default-state {
+		pins = "gpio107";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	sdc2_cd_default: sdc2-cd-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	/*
+	 * UART1 being the debug console supports various modes of
+	 * operation (RS-232/485/422) controlled via GPIOs configured
+	 * mux as follows:
+	 *
+	 *   gpio100    gpio99    UART mode
+	 *   0          0         loopback
+	 *   0          1         RS-232
+	 *   1          0         RS-485
+	 *   1          1         RS-422
+	 *
+	 * The default mode configured here is RS-232 mode.
+	 */
+	uart1_mux0_rs232_high: uart1-mux0-rs232-state {
+		bootph-all;
+		pins = "gpio99";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-high;
+	};
+
+	uart1_mux1_rs232_low: uart1-mux1-rs232-state {
+		bootph-all;
+		pins = "gpio100";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	usb_id_default: usb-id-default-state {
+		pins = "gpio110";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	extcon = <&usb_id>, <&usb_id>;
+	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
+	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
+	pinctrl-names = "default", "device";
+	status = "okay";
+};
+
+&usb_hs_phy {
+	extcon = <&usb_id>;
+};
+
+&wcnss {
+	firmware-name = "qcom/apq8016/wcnss.mbn";
+	status = "okay";
+};
+
+&wcnss_ctrl {
+	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3620";
+};
+
+&wcnss_mem {
+	status = "okay";
+};
+
+/* PINCTRL - additions to nodes defined in msm8916.dtsi */
+
+/*
+ * 2mA drive strength is not enough when connecting multiple
+ * I2C devices with different pull up resistors.
+ */
+&blsp_i2c4_default {
+	drive-strength = <16>;
+};
+
+&blsp_i2c6_default {
+	drive-strength = <16>;
+};
+
+&blsp_uart1_default {
+	bootph-all;
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
-- 
2.34.1

