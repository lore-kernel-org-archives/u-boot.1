Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7482FC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35DB04056B;
	Tue, 25 Aug 2026 23:32:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ig06SK39eCmW; Tue, 25 Aug 2026 23:32:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787700758;
	bh=M/gMuXWLMMVwQW/7WlSYPT2x63aOrAElfAR0kXL6EPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VWAJhtBiyDbMisjeUw8tqbOOcdzFpwLdoNtpB1ST7dPAoOpyrb43Uxbl2+sD5lRiv
	 UIY9a7PC82+A+jpoV0QoDH6wQ+felDe9H5DAsbTZzeZkdBVFn+/VjB8UtRFkU40LnS
	 l3w81bHJrAe3rD5PRixzBmttYDAPiEyjShS5tahnRQ9SqGwu0oQJ8dpDzdh567TwIE
	 H0EFTZeEu5LSfZG1udVmW/wxwJh8qROH1SYh0PY5ewh1CusAgvCzH5n+nfU492Y24P
	 eL5Mu3bfWLkqiZU+UQpIA5Z5BimI7KvGx3jXyby04yFlMet3q5nu9IzUlS1YXedM0n
	 p27MeQV9KoG3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1F924054F;
	Tue, 25 Aug 2026 23:32:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EC6A23E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11199605F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqW9GE9aSvu0 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:32:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XJKVDL+C
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD8D4605F8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:32:32 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4af173320f9so386612b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787700751; x=1788305551;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M/gMuXWLMMVwQW/7WlSYPT2x63aOrAElfAR0kXL6EPc=;
 b=XJKVDL+C/HSobPAD1IMqFEu3AnffPbeGc3nKg8H8bL0XsdzP8dsLvpir4c6Q+n4Gnb
 rbz1xu+Hcb2rZFy+84NYqoyysheDZGPe02RijmvJeIpCuMl9kdRBIMzOX9hGhGlHZVkE
 9k4cGEArGKwiHRdq4zQoru0l8UEXbFCwDsl2GqKo4A/SwVb607CS/T4gDouKpD8ZrjrS
 LicV9C+PNj9KFt7jlQXMAuUBk9Bni9BRikIszYjW+/xU+VtwIyBnZx4N4lCyS1WE9Tmc
 5H0RxFJpxOux5jpCNwiRr7xOW6aZFXV6J/iJEj5fUgK99TcPZkyJyw4q1jsQhzYPYdyX
 zgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787700751; x=1788305551;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M/gMuXWLMMVwQW/7WlSYPT2x63aOrAElfAR0kXL6EPc=;
 b=Etg/gAySoktiYASBnocGQB6lAJXtzidx5EsIod3WWUWeHOvfpI1wwLEUkZHwJ/WPzA
 QLAAR7ystii5fTmt6Rv0PMviIDtlv6S6KupF6JUZdg45K+eP5iCltGHzXgDMb0V+RHQq
 H/gGc9CJIEOEFBgwsy5I0be26Sk3ahgQ6BQMg6vieAOleBsY2Gsv2VsUnFiTuvwKloRq
 OVbpD/Yx4lj5+LibM6cH0PQRs+nT6qRtu78EadTQ7EhpFHR+FXCPXVPgds+vexct7ihX
 Ura0+iMIb16+ysp2JKKg8jsXgH+9tyE9xGhjLgMMwh9Ns4i2aG6l1d9/6b4nVhiRnX/x
 akrA==
X-Gm-Message-State: AFuF++lmjouAHivNxikp+mvjeylVXxYxwBVVxnHv4gty1DQBIHIyoete
 CdJ1Uir8BdTCQPFOnyNpQbgfHJYJN5UToXrDB0YqFUazn/jl0dZDWY4HbvoLfvNk5GE=
X-Gm-Gg: AR+sD127KgtRoyCWzDCCjN10Nr1hW7pRhh0mlc+jMruX1xyYfVtB+nsrhUSPar484Ak
 q0iNwCpXZdN+Q3P7a+9bhyUhAvrmDcAls87LCYbXPyaa8DJHr6eUYhecitvPXOIyrzOeEztCbjn
 ZQHTpgPQT+rEnlkgu8TAGtPrQDyTXyCiFEKXxDl/hDc6UwKCAGeAs371Fqk1BRSj5Ozs1jQF91E
 T4RQkMWWiTnAeJcFlnc4pbyASXRwex/LQ+jG0bBsDIMNnqevzOIr8wOTT/h8kBO4XbQFz0Qx+yh
 lqUmq3lBZ6ThMyXaezrcsXC5EX1uaDOdtRtNLqEBPvpNXTztzGTYXmJIeA2ra0ztmq18X33k3JZ
 NF5Hy7q+J+TcXkkTdXhgQYOneAn+TPsaoZmwZTpK8RYN4Xs/+IyhTY38ObPd8NwAjNuiRxSTzl8
 1+/IlLaGKNFWZMpFl0ieyK0b53asQ54ZVhwnTDV66Im2vXyxEFdzH5QgHb2MQQ7qKG
X-Received: by 2002:a05:6808:5184:b0:4aa:cad:cb4c with SMTP id
 5614622812f47-4b366908457mr3738985b6e.1.1787700751306; 
 Tue, 25 Aug 2026 16:32:31 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:e96b:b637:f05:5bfd])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36ab734ddsm238211b6e.14.2026.08.25.16.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:32:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 25 Aug 2026 18:31:48 -0500
Subject: [PATCH v3 3/4] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mtk-genio-360-bringup-v3-3-8e79e93882ad@baylibre.com>
References: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
In-Reply-To: <20260825-mtk-genio-360-bringup-v3-0-8e79e93882ad@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13268;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=SyJCWX9WoS7fw1dwkQQdYmuML9iqzAmLMj3ORbCkqww=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqjiX5+saul5MTM66A34P+D2ZiD6//zVDf/QVKx
 U2PZgZ/P96JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCao4l+RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AzH8H/iKO1Sl2/uP8SlvjQyt53JsLFkcGfndA8/W/dyv
 NCq7p6PzVWSW0uoM6ee5OZM4BlJxiFr2mtyoTWY6Kmn5ZGezvYh8FJFN/m9CReoKEe4WX2WRYaE
 H1xzbVtSZd8URS97INKC3l38AQ9GyDffFJeAj124iFmuEz0vZPzhHZD2P9mwVTytySlY9N1mrBL
 uU17ELzM9OnAG2ypUQK2q/IhF0t6aLBGTwak6odM6LbIXq3H47OS1o13l43wE2BbmJl/4nb1iVj
 5a4W+tmY0x+A3qBe9dn9mZAoSTXKEGEE37XmwCtq8xIcZv32dTIEIkE9Q8aS8HQG17QvyZHbdTp
 VV/k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a devicetree for the MediaTek Genio 360 Evaluation Kit board.

Upstreaming of this board has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 512 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 527 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 1b533721bb4..bd093e219d9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1089,6 +1089,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8366-genio-360-evk.dtb \
 	mt8371-genio-520-evk.dtb \
 	mt8371-genio-520-evk-ufs.dtb \
 	mt8391-genio-720-evk.dtb \
diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
new file mode 100644
index 00000000000..dbf92125f6e
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8366.dtsi"
+#include "mt6366.dtsi"
+
+/ {
+	memory@40000000 {
+		device_type = "memory";
+		/* 4GB */
+		reg = <0 0x40000000 0x1 0x00000000>;
+	};
+
+	firmware: firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
+		};
+
+		/* 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		dsi_reserved: dsi@60000000 {
+			reg = <0 0x60000000 0 0x02000000>;
+			no-map;
+		};
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	usb_p0_vbus: regulator-usb-p0-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-p0-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 53 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-p1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	/*
+	 * Panel VDD and IOVCC rails are switched by the same enable GPIO,
+	 * so both -supply properties on the panel node point at this one
+	 * regulator instead of duplicating the GPIO across two nodes. This
+	 * works as long as we don't care what the voltage is. Technically,
+	 * there are two separate regulators though.
+	 */
+	regulator_dsi0_lcm: regulator-dsi0-lcm {
+		compatible = "regulator-fixed";
+		regulator-name = "dsi0-lcm";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dsi0_lcm_pins_default>;
+		gpio = <&pio 119 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	backlight_lcd0: backlight-lcd0 {
+		compatible = "pwm-backlight";
+		pwms = <&disp_pwm0 0 500000>;
+		brightness-levels = <0 1023>;
+		num-interpolated-steps = <1023>;
+		default-brightness-level = <576>;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&snor {
+	pinctrl-names = "default";
+	pinctrl-0 = <&snor_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&disp_pwm0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&disp_pwm0_pin_default>;
+};
+
+&dsi0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "startek,kd070fhfid078", "himax,hx8279";
+		reg = <0>;
+		reset-gpios = <&pio 65 GPIO_ACTIVE_HIGH>;
+		enable-gpios = <&pio 63 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&panel0_pins_default>;
+		backlight = <&backlight_lcd0>;
+		vdd-supply = <&regulator_dsi0_lcm>;
+		iovcc-supply = <&regulator_dsi0_lcm>;
+		status = "okay";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+
+	port {
+		dsi0_out: endpoint {
+			remote-endpoint = <&panel0_in>;
+		};
+	};
+};
+
+&mipi_tx_config0 {
+	status = "okay";
+};
+
+&mutex0 {
+	status = "okay";
+};
+
+&disp_ovl0_4l {
+	status = "okay";
+};
+
+&disp_rdma0 {
+	status = "okay";
+};
+
+&smi_larb0 {
+	status = "okay";
+};
+
+&smi_disp_common {
+	status = "okay";
+};
+
+&pio {
+	disp_pwm0_pin_default: disp-pwm0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO64__FUNC_DISP_PWM0>;
+			output-high;
+		};
+	};
+
+	panel0_pins_default: panel0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO63__FUNC_GPIO63>,
+				 <PINMUX_GPIO65__FUNC_GPIO65>;
+			output-high;
+		};
+	};
+
+	mmc0_pins_default: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	usb0_default_pins: usb0-default-pins {
+		pins-vbus-valid {
+			pinmux = <PINMUX_GPIO54__FUNC_VBUSVALID>;
+		};
+	};
+
+	dsi0_lcm_pins_default: dsi0-lcm-pins {
+		pins {
+			pinmux = <PINMUX_GPIO119__FUNC_GPIO119>;
+			output-high;
+		};
+	};
+
+	snor_pins: snor-pins {
+		pins0 {
+			pinmux = <PINMUX_GPIO57__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO59__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO60__FUNC_SPINOR_IO1>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO58__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO61__FUNC_SPINOR_IO2>,
+				 <PINMUX_GPIO62__FUNC_SPINOR_IO3>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+	};
+
+	eth_default: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-high;
+		};
+	};
+
+	eth_sleep: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	role-switch-default-mode = "peripheral";
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host0 {
+	status = "okay";
+};
+
+&usb_host1 {
+	vbus-supply = <&usb_p1_vbus>;
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host2 {
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	mmc-hs400-enhanced-strobe;
+	hs400-ds-delay = <0x10100>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	no-sdio;
+	no-sd;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	cd-gpios = <&pio 94 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6366_vmch_reg>;
+	vqmmc-supply = <&mt6366_vmc_reg>;
+	no-sdio;
+	no-mmc;
+};
+
+&eth {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy: ethernet-phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt8366-genio-360-evk.dts b/arch/arm/dts/mt8366-genio-360-evk.dts
new file mode 100644
index 00000000000..1bf94e9512c
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+/dts-v1/;
+
+#include "mt8366-genio-360-evk-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-360 EVK";
+	compatible = "mediatek,genio-360-evk", "mediatek,mt8366";
+};

-- 
2.43.0

