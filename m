Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC15C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C938781C;
	Tue, 19 Dec 2023 17:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K3B9uiy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C4B878D1; Tue, 19 Dec 2023 17:05:26 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A778788F
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c580ba223so59481035e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001894; x=1703606694; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nG+k/k1ohEMDTdf4Nm0hqWP3t24U2Xb27MbfT3eIoOw=;
 b=K3B9uiy9E9oHX0DD5ZyRpkLt0kzGJHPgYSk96037paHmZRkb87ULQHSuZm6iPnQfCE
 0p0ocWBk2YfecSE4XIXn3NC3QpgijQNOhyPIFMcbt+cIqR/KN1AefG5TC9z/MCmE70pL
 l5eRoB5bPVuLeaDJkJE3BP7jw/w1UaDSrk57Xa7Q7pVMxkQIl57M+IuSAYYaztsfjeGX
 pf88iR5hGbNLyLNVxh2uo/dvGlZJrFVpGnc9gl+MkEgiUs8LTixYjOsm6YpmZMBwOtOj
 oLQg6UxXS+OtAjC40yavp//jmWMfkG6pYZgo2Wtxjmcd3IzaknwYHC6U23K0wQgTPzr+
 xCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001894; x=1703606694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nG+k/k1ohEMDTdf4Nm0hqWP3t24U2Xb27MbfT3eIoOw=;
 b=nhgEwsTExYZ96QAEyOrdy8qIpCnUPFfIl/clqYpOc1bdQ+WnZmDMA8Cv3gGFuu9UG5
 8LQjd9t4hohg/VLh7iNvCcMxSI03sAZW6EJqx/buw2equ3Ib1/weNk9AjhfYiZgXoK7H
 6RCXpTbqcPbbvysxj4tDlPJpg/bbG2Cqwe5F0r7mvrjaZJ7DdtAWicwyCMgMnV7FfIV+
 helnfLEr97f5ogiK5tjo1uD31GFTAsOXU8SFHoeYilgbupVKjK8nSUfSsY+lC3HsybQX
 NDnKFHXJG9R4VW8NzegTY2PjqYG8ohojuyLI+tOkVGadrk9d/l7sqnHdwx1yf4ET0iwX
 PhmA==
X-Gm-Message-State: AOJu0YyYpRRcCyumja1STK7Lm+oRgrW7pRFtxzAXcPjg5gg/r4vMrcSP
 VHJApOu8Q8/5rwXo/Hbv36tRtA==
X-Google-Smtp-Source: AGHT+IHWY65F6hM18fwQ9PkA0U3dQ6Fwr7Mri1zdrjS9tDexGulv6dHY41owTd7G3/pkZi44xcf74Q==
X-Received: by 2002:a05:600c:2195:b0:40c:2c90:e068 with SMTP id
 e21-20020a05600c219500b0040c2c90e068mr10493813wme.32.1703001894136; 
 Tue, 19 Dec 2023 08:04:54 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:31 +0000
Subject: [PATCH v2 30/32] dts: qcs404-evb: replace with upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-30-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=74166;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=CzYKZ8A68cWPb9andqgZxTafTIl9EsgvMrEHcIMh+pQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Sx1186d8Ap+evbY6XkLJ8+acXrTVh051qjNmt/Oi
 TqsDw7X7yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATubqOkWHBjs6EVB6LHpse
 Hs+ue8c+d7vfYN5xZM9S595Gf74lT0UZ/mdsWH7+Vltx0of9Fr0Z9xZll9bK7tvquj1IY5Oe5HW
 Dg88A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Drop the U-Boot specific DTS in favour of upstream. We'll only include
the -4000 variant as that is what U-Boot already supported.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/Makefile                    |    2 +-
 arch/arm/dts/pms405.dtsi                 |  149 +++
 arch/arm/dts/qcs404-evb-4000-u-boot.dtsi |   26 +
 arch/arm/dts/qcs404-evb-4000.dts         |   96 ++
 arch/arm/dts/qcs404-evb-uboot.dtsi       |   30 -
 arch/arm/dts/qcs404-evb.dts              |  390 -------
 arch/arm/dts/qcs404-evb.dtsi             |  389 +++++++
 arch/arm/dts/qcs404.dtsi                 | 1829 ++++++++++++++++++++++++++++++
 8 files changed, 2490 insertions(+), 421 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 95470fd6133b..34c473965bef 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -604,7 +604,7 @@ dtb-$(CONFIG_ARCH_SNAPDRAGON) += apq8016-sbc.dtb \
 	apq8096-db820c.dtb \
 	sdm845-db845c.dtb \
 	sdm845-samsung-starqltechn.dtb \
-	qcs404-evb.dtb
+	qcs404-evb-4000.dtb
 
 dtb-$(CONFIG_TARGET_STEMMY) += ste-ux500-samsung-stemmy.dtb
 
diff --git a/arch/arm/dts/pms405.dtsi b/arch/arm/dts/pms405.dtsi
new file mode 100644
index 000000000000..461ad97032f7
--- /dev/null
+++ b/arch/arm/dts/pms405.dtsi
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pms405-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pms405_temp>;
+
+			trips {
+				pms405_alert0: pms405-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pms405_crit: pms405-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus {
+	pms405_0: pms405@0 {
+		compatible = "qcom,pms405", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pms405_gpios: gpio@c000 {
+			compatible = "qcom,pms405-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pms405_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pon@800 {
+			compatible = "qcom,pms405-pon";
+			reg = <0x0800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+		};
+
+		pms405_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pms405_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pms405_adc: adc@3100 {
+			compatible = "qcom,pms405-adc", "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <ADC5_REF_GND>;
+				qcom,pre-scaling = <1 1>;
+				label = "ref_gnd";
+			};
+
+			channel@1 {
+				reg = <ADC5_1P25VREF>;
+				qcom,pre-scaling = <1 1>;
+				label = "vref_1p25";
+			};
+
+			channel@131 {
+				reg = <ADC5_VPH_PWR>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+
+			channel@6 {
+				reg = <ADC5_DIE_TEMP>;
+				qcom,pre-scaling = <1 1>;
+				label = "die_temp";
+			};
+
+			channel@77 {
+				reg = <ADC5_AMUX_THM1_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				label = "pa_therm1";
+			};
+
+			channel@79 {
+				reg = <ADC5_AMUX_THM3_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				label = "pa_therm3";
+			};
+
+			channel@76 {
+				reg = <ADC5_XO_THERM_100K_PU>;
+				qcom,ratiometric;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				label = "xo_therm";
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
+	};
+
+	pms405_1: pms405@1 {
+		compatible = "qcom,pms405", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+
+		pms405_spmi_regulators: regulators {
+			compatible = "qcom,pms405-regulators";
+		};
+	};
+};
diff --git a/arch/arm/dts/qcs404-evb-4000-u-boot.dtsi b/arch/arm/dts/qcs404-evb-4000-u-boot.dtsi
new file mode 100644
index 000000000000..5f1be85bd834
--- /dev/null
+++ b/arch/arm/dts/qcs404-evb-4000-u-boot.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <dt-bindings/gpio/gpio.h>
+
+/delete-node/ &usb3_vbus_reg;
+/delete-node/ &usb_vbus_boost_pin;
+
+/ {
+	/* U-Boot uses different bindings for GPIO regulators, this
+	 * one is required for USB
+	 */
+	usb3_vbus_reg: usb3_vbus_reg {
+		compatible = "regulator-gpio";
+		regulator-name = "usb3_vbus_reg";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-gpios = <&pms405_gpios 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		states = <0 0>, <5000000 1>;
+	};
+};
+
+&usb3_dwc3 {
+	/* Make sure the VBUS supply is switched on */
+	vbus-supply = <&usb3_vbus_reg>;
+};
diff --git a/arch/arm/dts/qcs404-evb-4000.dts b/arch/arm/dts/qcs404-evb-4000.dts
new file mode 100644
index 000000000000..358827c2fbd3
--- /dev/null
+++ b/arch/arm/dts/qcs404-evb-4000.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "qcs404-evb.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
+	compatible = "qcom,qcs404-evb-4000", "qcom,qcs404-evb",
+		     "qcom,qcs404";
+};
+
+&ethernet {
+	status = "okay";
+
+	snps,reset-gpio = <&tlmm 60 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 10000>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_defaults>;
+
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii";
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1: phy@4 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			device_type = "ethernet-phy";
+			reg = <0x4>;
+		};
+	};
+};
+
+&tlmm {
+	ethernet_defaults: ethernet-defaults-state {
+		int-pins {
+			pins = "gpio61";
+			function = "rgmii_int";
+			bias-disable;
+			drive-strength = <2>;
+		};
+		mdc-pins {
+			pins = "gpio76";
+			function = "rgmii_mdc";
+			bias-pull-up;
+		};
+		mdio-pins {
+			pins = "gpio75";
+			function = "rgmii_mdio";
+			bias-pull-up;
+		};
+		tx-pins {
+			pins = "gpio67", "gpio66", "gpio65", "gpio64";
+			function = "rgmii_tx";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+		rx-pins {
+			pins = "gpio73", "gpio72", "gpio71", "gpio70";
+			function = "rgmii_rx";
+			bias-disable;
+			drive-strength = <2>;
+		};
+		tx-ctl-pins {
+			pins = "gpio68";
+			function = "rgmii_ctl";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+		rx-ctl-pins {
+			pins = "gpio74";
+			function = "rgmii_ctl";
+			bias-disable;
+			drive-strength = <2>;
+		};
+		tx-ck-pins {
+			pins = "gpio63";
+			function = "rgmii_ck";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+		rx-ck-pins {
+			pins = "gpio69";
+			function = "rgmii_ck";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
+};
diff --git a/arch/arm/dts/qcs404-evb-uboot.dtsi b/arch/arm/dts/qcs404-evb-uboot.dtsi
deleted file mode 100644
index b4c5f3fa4301..000000000000
--- a/arch/arm/dts/qcs404-evb-uboot.dtsi
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * U-Boot addition to handle QCS404 EVB pre-relocation devices
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-/ {
-	soc {
-		bootph-all;
-
-		pinctrl_north@1300000 {
-			bootph-all;
-		};
-
-		clock-controller@1800000 {
-			bootph-all;
-		};
-
-		serial@78b1000 {
-			bootph-all;
-		};
-	};
-};
-
-&pms405_gpios {
-	usb_vbus_boost_pin {
-		gpios = <&pms405_gpios 2 0>;
-	};
-};
diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
deleted file mode 100644
index 07bf7dd0b32f..000000000000
--- a/arch/arm/dts/qcs404-evb.dts
+++ /dev/null
@@ -1,390 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm QCS404 based evaluation board device tree source
- *
- * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
- */
-
-/dts-v1/;
-
-#include "skeleton64.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/qcom,gcc-qcs404.h>
-
-/ {
-	model = "Qualcomm Technologies, Inc. QCS404 EVB";
-	compatible = "qcom,qcs404-evb", "qcom,qcs404";
-	#address-cells = <0x2>;
-	#size-cells = <0x2>;
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	aliases {
-		serial0 = &debug_uart;
-		i2c0 = &blsp1_i2c0;
-		i2c1 = &blsp1_i2c1;
-		i2c2 = &blsp1_i2c2;
-		i2c3 = &blsp1_i2c3;
-		i2c4 = &blsp1_i2c4;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x80000000 0 0x40000000>;
-	};
-
-	soc {
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-		ranges = <0x0 0x0 0x0 0xffffffff>;
-		compatible = "simple-bus";
-
-		soc_gpios: pinctrl_north@1300000 {
-			compatible = "qcom,qcs404-pinctrl";
-			reg = <0x1300000 0x200000>;
-			gpio-controller;
-			gpio-count = <120>;
-			gpio-bank-name="soc";
-			#gpio-cells = <2>;
-
-			blsp1_uart2: uart {
-				pins = "GPIO_17", "GPIO_18";
-				function = "blsp_uart2";
-			};
-
-			blsp1_i2c0_default: blsp1-i2c0-default {
-				pins = "GPIO_32", "GPIO_33";
-				function = "blsp_i2c0";
-			};
-
-			blsp1_i2c1_default: blsp1-i2c1-default {
-				pins = "GPIO_24", "GPIO_25";
-				function = "blsp_i2c1";
-			};
-
-			blsp1_i2c2_default: blsp1-i2c2-default {
-				sda {
-					pins = "GPIO_19";
-					function = "blsp_i2c_sda_a2";
-				};
-
-				scl {
-					pins = "GPIO_20";
-					function = "blsp_i2c_scl_a2";
-				};
-			};
-
-			blsp1_i2c3_default: blsp1-i2c3-default {
-				pins = "GPIO_84", "GPIO_85";
-				function = "blsp_i2c3";
-			};
-
-			blsp1_i2c4_default: blsp1-i2c4-default {
-				pins = "GPIO_117", "GPIO_118";
-				function = "blsp_i2c4";
-			};
-
-			ethernet_defaults: ethernet-defaults {
-				int {
-					pins = "GPIO_61";
-					function = "rgmii_int";
-					bias-disable;
-					drive-strength = <2>;
-				};
-				mdc {
-					pins = "GPIO_76";
-					function = "rgmii_mdc";
-					bias-pull-up;
-				};
-				mdio {
-					pins = "GPIO_75";
-					function = "rgmii_mdio";
-					bias-pull-up;
-				};
-				tx {
-					pins = "GPIO_67", "GPIO_66", "GPIO_65", "GPIO_64";
-					function = "rgmii_tx";
-					bias-pull-up;
-					drive-strength = <16>;
-				};
-				rx {
-					pins = "GPIO_73", "GPIO_72", "GPIO_71", "GPIO_70";
-					function = "rgmii_rx";
-					bias-disable;
-					drive-strength = <2>;
-				};
-				tx-ctl {
-					pins = "GPIO_68";
-					function = "rgmii_ctl";
-					bias-pull-up;
-					drive-strength = <16>;
-				};
-				rx-ctl {
-					pins = "GPIO_74";
-					function = "rgmii_ctl";
-					bias-disable;
-					drive-strength = <2>;
-				};
-				tx-ck {
-					pins = "GPIO_63";
-					function = "rgmii_ck";
-					bias-pull-up;
-					drive-strength = <16>;
-				};
-				rx-ck {
-					pins = "GPIO_69";
-					function = "rgmii_ck";
-					bias-disable;
-					drive-strength = <2>;
-				};
-			};
-		};
-
-		blsp1_i2c0: i2c@78b5000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x078b5000 0x600>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP0_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default";
-			pinctrl-0 = <&blsp1_i2c0_default>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		blsp1_i2c1: i2c@78b6000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x078b6000 0x600>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default";
-			pinctrl-0 = <&blsp1_i2c1_default>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		blsp1_i2c2: i2c@78b7000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x078b7000 0x600>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default";
-			pinctrl-0 = <&blsp1_i2c2_default>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		blsp1_i2c3: i2c@78b8000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x078b8000 0x600>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default";
-			pinctrl-0 = <&blsp1_i2c3_default>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		blsp1_i2c4: i2c@78b9000 {
-			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x078b9000 0x600>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
-			pinctrl-names = "default";
-			pinctrl-0 = <&blsp1_i2c4_default>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		gcc: clock-controller@1800000 {
-			compatible = "qcom,gcc-qcs404";
-			reg = <0x1800000 0x80000>;
-			#address-cells = <0x1>;
-			#size-cells = <0x0>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-		};
-
-		debug_uart: serial@78b1000 {
-			compatible = "qcom,msm-uartdm-v1.4";
-			reg = <0x78b1000 0x200>;
-			clock = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
-				<&gcc GCC_BLSP1_AHB_CLK>;
-			bit-rate = <0xFF>;
-			pinctrl-names = "uart";
-			pinctrl-0 = <&blsp1_uart2>;
-		};
-
-		sdhci@7804000 {
-			compatible = "qcom,sdhci-msm-v5";
-			reg = <0x7804000 0x1000 0x7805000 0x1000>;
-			clock = <&gcc GCC_SDCC1_APPS_CLK>,
-				<&gcc GCC_SDCC1_AHB_CLK>;
-			bus-width = <0x8>;
-			index = <0x0>;
-			non-removable;
-			mmc-ddr-1_8v;
-			mmc-hs400-1_8v;
-		};
-
-		usb3_phy: phy@78000 {
-			compatible = "qcom,usb-ss-28nm-phy";
-			#phy-cells = <0>;
-			reg = <0x78000 0x400>;
-			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
-				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
-			clock-names = "ahb", "pipe";
-			resets = <&gcc GCC_USB3_PHY_BCR>,
-				 <&gcc GCC_USB3PHY_PHY_BCR>;
-			reset-names = "com", "phy";
-		};
-
-		usb2_phy_prim: phy@7a000 {
-			compatible = "qcom,usb-hs-28nm-femtophy";
-			#phy-cells = <0>;
-			reg = <0x7a000 0x200>;
-			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
-				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
-			clock-names = "ahb", "sleep";
-			resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
-				 <&gcc GCC_USB2A_PHY_BCR>;
-			reset-names = "phy", "por";
-		};
-
-		usb2_phy_sec: phy@7c000 {
-			compatible = "qcom,usb-hs-28nm-femtophy";
-			#phy-cells = <0>;
-			reg = <0x7c000 0x200>;
-			clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
-				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
-			clock-names = "ahb", "sleep";
-			resets = <&gcc GCC_QUSB2_PHY_BCR>,
-				 <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
-			reset-names = "phy", "por";
-		};
-
-		usb3: usb@7678800 {
-			compatible = "qcom,dwc3";
-			reg = <0x7678800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			clocks = <&gcc GCC_USB30_MASTER_CLK>,
-				 <&gcc GCC_SYS_NOC_USB3_CLK>,
-				 <&gcc GCC_USB30_SLEEP_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
-			clock-names = "core", "iface", "sleep", "mock_utmi";
-
-			dwc3@7580000 {
-				compatible = "snps,dwc3";
-				reg = <0x7580000 0xcd00>;
-				phys = <&usb2_phy_prim>, <&usb3_phy>;
-				phy-names = "usb2-phy", "usb3-phy";
-				dr_mode = "host";
-				snps,has-lpm-erratum;
-				snps,hird-threshold = /bits/ 8 <0x10>;
-				snps,usb3_lpm_capable;
-				maximum-speed = "super-speed";
-			};
-		};
-
-		usb2: usb@79b8800 {
-			compatible = "qcom,dwc3";
-			reg = <0x79b8800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>,
-				 <&gcc GCC_PCNOC_USB2_CLK>,
-				 <&gcc GCC_USB_HS_INACTIVITY_TIMERS_CLK>,
-				 <&gcc GCC_USB20_MOCK_UTMI_CLK>;
-			clock-names = "core", "iface", "sleep", "mock_utmi";
-
-			dwc3@78c0000 {
-				compatible = "snps,dwc3";
-				reg = <0x78c0000 0xcc00>;
-				phys = <&usb2_phy_sec>;
-				phy-names = "usb2-phy";
-				dr_mode = "peripheral";
-				snps,has-lpm-erratum;
-				snps,hird-threshold = /bits/ 8 <0x10>;
-				snps,usb3_lpm_capable;
-				maximum-speed = "high-speed";
-			};
-		};
-
-		ethernet: ethernet@7a80000 {
-			compatible = "qcom,qcs404-ethqos";
-			reg = <0x07a80000 0x10000>,
-				<0x07a96000 0x100>;
-			reg-names = "stmmaceth", "rgmii";
-			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii";
-			clocks = <&gcc GCC_ETH_AXI_CLK>,
-				 <&gcc GCC_ETH_SLAVE_AHB_CLK>,
-				 <&gcc GCC_ETH_PTP_CLK>,
-				 <&gcc GCC_ETH_RGMII_CLK>;
-
-			resets = <&gcc GCC_EMAC_BCR>;
-			reset-names = "emac";
-
-			snps,tso;
-			rx-fifo-depth = <4096>;
-			tx-fifo-depth = <4096>;
-
-			snps,reset-gpio = <&soc_gpios 60 GPIO_ACTIVE_LOW>;
-			snps,reset-active-low;
-			snps,reset-delays-us = <0 10000 10000>;
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&ethernet_defaults>;
-
-			phy-handle = <&phy1>;
-			phy-mode = "rgmii";
-			max-speed = <1000>;
-
-			mdio {
-				#address-cells = <0x1>;
-				#size-cells = <0x0>;
-				compatible = "snps,dwmac-mdio";
-				phy1: phy@3 {
-					compatible = "ethernet-phy-ieee802.3-c22";
-					device_type = "ethernet-phy";
-					reg = <0x3>;
-				};
-			};
-		};
-
-		spmi@200f000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0x200f000 0x001000>,
-			      <0x2400000 0x800000>,
-			      <0x2c00000 0x800000>;
-			reg-names = "core", "chnls", "obsrvr";
-			#address-cells = <0x1>;
-			#size-cells = <0x1>;
-
-			pms405_0: pms405@0 {
-				compatible = "qcom,spmi-pmic";
-				reg = <0x0 0x1>;
-				#address-cells = <0x1>;
-				#size-cells = <0x1>;
-
-				pms405_gpios: pms405_gpios@c000 {
-					compatible = "qcom,pms405-gpio";
-					reg = <0xc000 0x400>;
-					gpio-controller;
-					gpio-ranges = <&pms405_gpios 0 0 12>;
-					#gpio-cells = <2>;
-				};
-			};
-		};
-	};
-};
-
-#include "qcs404-evb-uboot.dtsi"
diff --git a/arch/arm/dts/qcs404-evb.dtsi b/arch/arm/dts/qcs404-evb.dtsi
new file mode 100644
index 000000000000..10655401528e
--- /dev/null
+++ b/arch/arm/dts/qcs404-evb.dtsi
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "qcs404.dtsi"
+#include "pms405.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+		serial1 = &blsp1_uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_ch0_3p3:
+	vdd_esmps3_3p3: vdd-esmps3-3p3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "eSMPS3_3P3";
+
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	usb3_vbus_reg: regulator-usb3-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "VBUS_BOOST_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pms405_gpios 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_vbus_boost_pin>;
+		vin-supply = <&vph_pwr>;
+		enable-active-high;
+
+		/* TODO: Drop this when introducing role switching */
+		regulator-always-on;
+	};
+};
+
+&blsp1_uart3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+		vddio-supply = <&vreg_l6_1p8>;
+		vddxo-supply = <&vreg_l5_1p8>;
+		vddrf-supply = <&vreg_l1_1p3>;
+		vddch0-supply = <&vdd_ch0_3p3>;
+
+		local-bd-address = [ 02 00 00 00 5a ad ];
+
+		max-speed = <3200000>;
+	};
+};
+
+&blsp1_dma {
+	qcom,controlled-remotely;
+};
+
+&blsp2_dma {
+	qcom,controlled-remotely;
+};
+
+&gcc {
+	protected-clocks = <GCC_BIMC_CDSP_CLK>,
+			   <GCC_CDSP_CFG_AHB_CLK>,
+			   <GCC_CDSP_BIMC_CLK_SRC>,
+			   <GCC_CDSP_TBU_CLK>,
+			   <141>, /* GCC_WCSS_Q6_AHB_CLK */
+			   <142>; /* GCC_WCSS_Q6_AXIM_CLK */
+};
+
+&pms405_spmi_regulators {
+	vdd_s3-supply = <&vph_pwr>;
+
+	pms405_s3: s3 {
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "vdd_apc";
+		regulator-initial-mode = <1>;
+		regulator-min-microvolt = <1048000>;
+		regulator-max-microvolt = <1384000>;
+	};
+};
+
+&pcie {
+	status = "okay";
+
+	perst-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&perst_state>;
+};
+
+&pcie_phy {
+	status = "okay";
+
+	vdda-vp-supply = <&vreg_l3_1p05>;
+	vdda-vph-supply = <&vreg_l5_1p8>;
+};
+
+&remoteproc_adsp {
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+};
+
+&remoteproc_wcss {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pms405-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_l1_l2-supply = <&vreg_s5_1p35>;
+		vdd_l3_l8-supply = <&vreg_s5_1p35>;
+		vdd_l4-supply = <&vreg_s5_1p35>;
+		vdd_l5_l6-supply = <&vreg_s4_1p8>;
+		vdd_l7-supply = <&vph_pwr>;
+		vdd_l9-supply = <&vreg_s5_1p35>;
+		vdd_l10_l11_l12_l13-supply = <&vph_pwr>;
+
+		vreg_s4_1p8: s4 {
+			regulator-min-microvolt = <1728000>;
+			regulator-max-microvolt = <1920000>;
+		};
+
+		vreg_s5_1p35: s5 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l1_1p3: l1 {
+			regulator-min-microvolt = <1240000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l2_1p275: l2 {
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1280000>;
+		};
+
+		vreg_l3_1p05: l3 {
+			regulator-min-microvolt = <1048000>;
+			regulator-max-microvolt = <1160000>;
+		};
+
+		vreg_l4_1p2: l4 {
+			regulator-min-microvolt = <1144000>;
+			regulator-max-microvolt = <1256000>;
+		};
+
+		vreg_l5_1p8: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l6_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		vreg_l7_1p8: l7 {
+			regulator-min-microvolt = <1616000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		vreg_l8_1p2: l8 {
+			regulator-min-microvolt = <1136000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_l10_3p3: l10 {
+			regulator-min-microvolt = <2936000>;
+			regulator-max-microvolt = <3088000>;
+		};
+
+		vreg_l11_sdc2: l11 {
+			regulator-min-microvolt = <2696000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l12_3p3: l12 {
+			regulator-min-microvolt = <3050000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l13_3p3: l13 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&sdcc1 {
+	status = "okay";
+
+	supports-cqe;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	bus-width = <8>;
+	non-removable;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&sdc1_on>;
+	pinctrl-1 = <&sdc1_off>;
+};
+
+&tlmm {
+	perst_state: perst-state {
+		pins = "gpio43";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
+	sdc1_on: sdc1-on-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <16>;
+		};
+
+		cmd-pins {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		data-pins {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <10>;
+		};
+
+		rclk-pins {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	sdc1_off: sdc1-off-state {
+		clk-pins {
+			pins = "sdc1_clk";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		cmd-pins {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		data-pins {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+
+		rclk-pins {
+			pins = "sdc1_rclk";
+			bias-pull-down;
+		};
+	};
+
+	usb3_id_pin: usb3-id-state {
+		pins = "gpio116";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&pms405_gpios {
+	usb_vbus_boost_pin: usb-vbus-boost-state {
+		pinconf {
+			pins = "gpio3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+			power-source = <1>;
+		};
+	};
+	usb3_vbus_pin: usb3-vbus-state {
+		pinconf {
+			pins = "gpio12";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			input-enable;
+			bias-pull-down;
+			power-source = <1>;
+		};
+	};
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&usb2_phy_sec {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+
+};
+
+&usb3_dwc3 {
+	dr_mode = "host";
+};
+
+&usb2_phy_prim {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3_phy {
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	status = "okay";
+};
+
+&wifi {
+	status = "okay";
+	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
+	vdd-1.8-xo-supply = <&vreg_l5_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l1_1p3>;
+};
+
+/* PINCTRL - additions to nodes defined in qcs404.dtsi */
+
+&blsp1_uart2_default {
+	rx-pins {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tx-pins {
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&blsp1_uart3_default {
+	cts-pins {
+		bias-disable;
+	};
+
+	rts-tx-pins {
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rx-pins {
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm/dts/qcs404.dtsi b/arch/arm/dts/qcs404.dtsi
new file mode 100644
index 000000000000..2721f32dfb71
--- /dev/null
+++ b/arch/arm/dts/qcs404.dtsi
@@ -0,0 +1,1829 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/qcom,gcc-qcs404.h>
+#include <dt-bindings/clock/qcom,turingcc-qcs404.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
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
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		CPU0: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x100>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
+		};
+
+		CPU1: cpu@101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x101>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
+		};
+
+		CPU2: cpu@102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x102>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
+		};
+
+		CPU3: cpu@103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x103>;
+			enable-method = "psci";
+			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2_0>;
+			#cooling-cells = <2>;
+			clocks = <&apcs_glb>;
+			operating-points-v2 = <&cpu_opp_table>;
+			power-domains = <&cpr>;
+			power-domain-names = "cpr";
+		};
+
+		L2_0: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP_0: cpu-sleep-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "standalone-power-collapse";
+				arm,psci-suspend-param = <0x40000003>;
+				entry-latency-us = <125>;
+				exit-latency-us = <180>;
+				min-residency-us = <595>;
+				local-timer-stop;
+			};
+		};
+	};
+
+	cpu_opp_table: opp-table-cpu {
+		compatible = "operating-points-v2-kryo-cpu";
+		opp-shared;
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			required-opps = <&cpr_opp1>;
+		};
+		opp-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			required-opps = <&cpr_opp2>;
+		};
+		opp-1401600000 {
+			opp-hz = /bits/ 64 <1401600000>;
+			required-opps = <&cpr_opp3>;
+		};
+	};
+
+	cpr_opp_table: opp-table-cpr {
+		compatible = "operating-points-v2-qcom-level";
+
+		cpr_opp1: opp1 {
+			opp-level = <1>;
+			qcom,opp-fuse-level = <1>;
+		};
+		cpr_opp2: opp2 {
+			opp-level = <2>;
+			qcom,opp-fuse-level = <2>;
+		};
+		cpr_opp3: opp3 {
+			opp-level = <3>;
+			qcom,opp-fuse-level = <3>;
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-qcs404", "qcom,scm";
+			#reset-cells = <1>;
+		};
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0x80000000 0 0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	rpm: remoteproc {
+		compatible = "qcom,qcs404-rpm-proc", "qcom,rpm-proc";
+
+		glink-edge {
+			compatible = "qcom,glink-rpm";
+
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			mboxes = <&apcs_glb 0>;
+
+			rpm_requests: rpm-requests {
+				compatible = "qcom,rpm-qcs404";
+				qcom,glink-channels = "rpm_requests";
+
+				rpmcc: clock-controller {
+					compatible = "qcom,rpmcc-qcs404", "qcom,rpmcc";
+					#clock-cells = <1>;
+					clocks = <&xo_board>;
+					clock-names = "xo";
+				};
+
+				rpmpd: power-controller {
+					compatible = "qcom,qcs404-rpmpd";
+					#power-domain-cells = <1>;
+					operating-points-v2 = <&rpmpd_opp_table>;
+
+					rpmpd_opp_table: opp-table {
+						compatible = "operating-points-v2";
+
+						rpmpd_opp_ret: opp1 {
+							opp-level = <16>;
+						};
+
+						rpmpd_opp_ret_plus: opp2 {
+							opp-level = <32>;
+						};
+
+						rpmpd_opp_min_svs: opp3 {
+							opp-level = <48>;
+						};
+
+						rpmpd_opp_low_svs: opp4 {
+							opp-level = <64>;
+						};
+
+						rpmpd_opp_svs: opp5 {
+							opp-level = <128>;
+						};
+
+						rpmpd_opp_svs_plus: opp6 {
+							opp-level = <192>;
+						};
+
+						rpmpd_opp_nom: opp7 {
+							opp-level = <256>;
+						};
+
+						rpmpd_opp_nom_plus: opp8 {
+							opp-level = <320>;
+						};
+
+						rpmpd_opp_turbo: opp9 {
+							opp-level = <384>;
+						};
+
+						rpmpd_opp_turbo_no_cpr: opp10 {
+							opp-level = <416>;
+						};
+
+						rpmpd_opp_turbo_plus: opp11 {
+							opp-level = <512>;
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
+		tz_apps_mem: memory@85900000 {
+			reg = <0 0x85900000 0 0x500000>;
+			no-map;
+		};
+
+		xbl_mem: memory@85e00000 {
+			reg = <0 0x85e00000 0 0x100000>;
+			no-map;
+		};
+
+		smem_region: memory@85f00000 {
+			reg = <0 0x85f00000 0 0x200000>;
+			no-map;
+		};
+
+		tz_mem: memory@86100000 {
+			reg = <0 0x86100000 0 0x300000>;
+			no-map;
+		};
+
+		wlan_fw_mem: memory@86400000 {
+			reg = <0 0x86400000 0 0x1100000>;
+			no-map;
+		};
+
+		adsp_fw_mem: memory@87500000 {
+			reg = <0 0x87500000 0 0x1a00000>;
+			no-map;
+		};
+
+		cdsp_fw_mem: memory@88f00000 {
+			reg = <0 0x88f00000 0 0x600000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@89500000 {
+			reg = <0 0x89500000 0 0x100000>;
+			no-map;
+		};
+
+		uefi_mem: memory@9f800000 {
+			reg = <0 0x9f800000 0 0x800000>;
+			no-map;
+		};
+	};
+
+	smem {
+		compatible = "qcom,smem";
+
+		memory-region = <&smem_region>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+
+		hwlocks = <&tcsr_mutex 3>;
+	};
+
+	soc: soc@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0xffffffff>;
+		compatible = "simple-bus";
+
+		turingcc: clock-controller@800000 {
+			compatible = "qcom,qcs404-turingcc";
+			reg = <0x00800000 0x30000>;
+			clocks = <&gcc GCC_CDSP_CFG_AHB_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+
+			status = "disabled";
+		};
+
+		rpm_msg_ram: sram@60000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0x00060000 0x6000>;
+		};
+
+		usb3_phy: phy@78000 {
+			compatible = "qcom,usb-ss-28nm-phy";
+			reg = <0x00078000 0x400>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "ref", "ahb", "pipe";
+			resets = <&gcc GCC_USB3_PHY_BCR>,
+				 <&gcc GCC_USB3PHY_PHY_BCR>;
+			reset-names = "com", "phy";
+			status = "disabled";
+		};
+
+		usb2_phy_prim: phy@7a000 {
+			compatible = "qcom,usb-hs-28nm-femtophy";
+			reg = <0x0007a000 0x200>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "ahb", "sleep";
+			resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+				 <&gcc GCC_USB2A_PHY_BCR>;
+			reset-names = "phy", "por";
+			status = "disabled";
+		};
+
+		usb2_phy_sec: phy@7c000 {
+			compatible = "qcom,usb-hs-28nm-femtophy";
+			reg = <0x0007c000 0x200>;
+			#phy-cells = <0>;
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+				 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+			clock-names = "ref", "ahb", "sleep";
+			resets = <&gcc GCC_QUSB2_PHY_BCR>,
+				 <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
+			reset-names = "phy", "por";
+			status = "disabled";
+		};
+
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qcs404-qfprom", "qcom,qfprom";
+			reg = <0x000a4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			cpr_efuse_speedbin: speedbin@13c {
+				reg = <0x13c 0x4>;
+				bits = <2 3>;
+			};
+
+			tsens_s0_p1: s0-p1@1f8 {
+				reg = <0x1f8 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s0_p2: s0-p2@1f8 {
+				reg = <0x1f8 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s1_p1: s1-p1@1f9 {
+				reg = <0x1f9 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s1_p2: s1-p2@1fa {
+				reg = <0x1fa 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s2_p1: s2-p1@1fb {
+				reg = <0x1fb 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s2_p2: s2-p2@1fb {
+				reg = <0x1fb 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s3_p1: s3-p1@1fc {
+				reg = <0x1fc 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s3_p2: s3-p2@1fd {
+				reg = <0x1fd 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s4_p1: s4-p1@1fe {
+				reg = <0x1fe 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s4_p2: s4-p2@1fe {
+				reg = <0x1fe 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s5_p1: s5-p1@200 {
+				reg = <0x200 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s5_p2: s5-p2@200 {
+				reg = <0x200 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s6_p1: s6-p1@201 {
+				reg = <0x201 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s6_p2: s6-p2@202 {
+				reg = <0x202 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s7_p1: s7-p1@203 {
+				reg = <0x203 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s7_p2: s7-p2@203 {
+				reg = <0x203 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_s8_p1: s8-p1@204 {
+				reg = <0x204 0x2>;
+				bits = <4 6>;
+			};
+
+			tsens_s8_p2: s8-p2@205 {
+				reg = <0x205 0x1>;
+				bits = <2 6>;
+			};
+
+			tsens_s9_p1: s9-p1@206 {
+				reg = <0x206 0x1>;
+				bits = <0 6>;
+			};
+
+			tsens_s9_p2: s9-p2@206 {
+				reg = <0x206 0x2>;
+				bits = <6 6>;
+			};
+
+			tsens_mode: mode@208 {
+				reg = <0x208 1>;
+				bits = <0 3>;
+			};
+
+			tsens_base1: base1@208 {
+				reg = <0x208 2>;
+				bits = <3 8>;
+			};
+
+			tsens_base2: base2@208 {
+				reg = <0x209 2>;
+				bits = <3 8>;
+			};
+
+			cpr_efuse_quot_offset1: qoffset1@231 {
+				reg = <0x231 0x4>;
+				bits = <4 7>;
+			};
+			cpr_efuse_quot_offset2: qoffset2@232 {
+				reg = <0x232 0x4>;
+				bits = <3 7>;
+			};
+			cpr_efuse_quot_offset3: qoffset3@233 {
+				reg = <0x233 0x4>;
+				bits = <2 7>;
+			};
+			cpr_efuse_init_voltage1: ivoltage1@229 {
+				reg = <0x229 0x4>;
+				bits = <4 6>;
+			};
+			cpr_efuse_init_voltage2: ivoltage2@22a {
+				reg = <0x22a 0x4>;
+				bits = <2 6>;
+			};
+			cpr_efuse_init_voltage3: ivoltage3@22b {
+				reg = <0x22b 0x4>;
+				bits = <0 6>;
+			};
+			cpr_efuse_quot1: quot1@22b {
+				reg = <0x22b 0x4>;
+				bits = <6 12>;
+			};
+			cpr_efuse_quot2: quot2@22d {
+				reg = <0x22d 0x4>;
+				bits = <2 12>;
+			};
+			cpr_efuse_quot3: quot3@230 {
+				reg = <0x230 0x4>;
+				bits = <0 12>;
+			};
+			cpr_efuse_ring1: ring1@228 {
+				reg = <0x228 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_ring2: ring2@228 {
+				reg = <0x228 0x4>;
+				bits = <4 3>;
+			};
+			cpr_efuse_ring3: ring3@229 {
+				reg = <0x229 0x4>;
+				bits = <0 3>;
+			};
+			cpr_efuse_revision: revision@218 {
+				reg = <0x218 0x4>;
+				bits = <3 3>;
+			};
+		};
+
+		rng: rng@e3000 {
+			compatible = "qcom,prng-ee";
+			reg = <0x000e3000 0x1000>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+		};
+
+		bimc: interconnect@400000 {
+			reg = <0x00400000 0x80000>;
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+			reg = <0x004a9000 0x1000>, /* TM */
+			      <0x004a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_mode>,
+				      <&tsens_base1>, <&tsens_base2>,
+				      <&tsens_s0_p1>, <&tsens_s0_p2>,
+				      <&tsens_s1_p1>, <&tsens_s1_p2>,
+				      <&tsens_s2_p1>, <&tsens_s2_p2>,
+				      <&tsens_s3_p1>, <&tsens_s3_p2>,
+				      <&tsens_s4_p1>, <&tsens_s4_p2>,
+				      <&tsens_s5_p1>, <&tsens_s5_p2>,
+				      <&tsens_s6_p1>, <&tsens_s6_p2>,
+				      <&tsens_s7_p1>, <&tsens_s7_p2>,
+				      <&tsens_s8_p1>, <&tsens_s8_p2>,
+				      <&tsens_s9_p1>, <&tsens_s9_p2>;
+			nvmem-cell-names = "mode",
+					   "base1", "base2",
+					   "s0_p1", "s0_p2",
+					   "s1_p1", "s1_p2",
+					   "s2_p1", "s2_p2",
+					   "s3_p1", "s3_p2",
+					   "s4_p1", "s4_p2",
+					   "s5_p1", "s5_p2",
+					   "s6_p1", "s6_p2",
+					   "s7_p1", "s7_p2",
+					   "s8_p1", "s8_p2",
+					   "s9_p1", "s9_p2";
+			#qcom,sensors = <10>;
+			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "uplow";
+			#thermal-sensor-cells = <1>;
+		};
+
+		pcnoc: interconnect@500000 {
+			reg = <0x00500000 0x15080>;
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@580000 {
+			reg = <0x00580000 0x23080>;
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus", "bus_a";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+		remoteproc_cdsp: remoteproc@b00000 {
+			compatible = "qcom,qcs404-cdsp-pas";
+			reg = <0x00b00000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 229 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			/*
+			 * If the node was using the PIL binding, then include properties:
+			 * clocks = <&xo_board>,
+			 *          <&gcc GCC_CDSP_CFG_AHB_CLK>,
+			 *          <&gcc GCC_CDSP_TBU_CLK>,
+			 *          <&gcc GCC_BIMC_CDSP_CLK>,
+			 *          <&turingcc TURING_WRAPPER_AON_CLK>,
+			 *          <&turingcc TURING_Q6SS_AHBS_AON_CLK>,
+			 *          <&turingcc TURING_Q6SS_AHBM_AON_CLK>,
+			 *          <&turingcc TURING_Q6SS_Q6_AXIM_CLK>;
+			 * clock-names = "xo",
+			 *               "sway",
+			 *               "tbu",
+			 *               "bimc",
+			 *               "ahb_aon",
+			 *               "q6ss_slave",
+			 *               "q6ss_master",
+			 *               "q6_axim";
+			 * resets = <&gcc GCC_CDSP_RESTART>;
+			 * reset-names = "restart";
+			 * qcom,halt-regs = <&tcsr 0x19004>;
+			 */
+
+			memory-region = <&cdsp_fw_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <5>;
+				mboxes = <&apcs_glb 12>;
+
+				label = "cdsp";
+			};
+		};
+
+		usb3: usb@7678800 {
+			compatible = "qcom,qcs404-dwc3", "qcom,dwc3";
+			reg = <0x07678800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_USB30_MASTER_CLK>,
+				 <&gcc GCC_SYS_NOC_USB3_CLK>,
+				 <&gcc GCC_USB30_SLEEP_CLK>,
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
+			clock-names = "core", "iface", "sleep", "mock_utmi";
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <200000000>;
+			status = "disabled";
+
+			usb3_dwc3: usb@7580000 {
+				compatible = "snps,dwc3";
+				reg = <0x07580000 0xcd00>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy_prim>, <&usb3_phy>;
+				phy-names = "usb2-phy", "usb3-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				dr_mode = "otg";
+			};
+		};
+
+		usb2: usb@79b8800 {
+			compatible = "qcom,qcs404-dwc3", "qcom,dwc3";
+			reg = <0x079b8800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>,
+				 <&gcc GCC_PCNOC_USB2_CLK>,
+				 <&gcc GCC_USB_HS_INACTIVITY_TIMERS_CLK>,
+				 <&gcc GCC_USB20_MOCK_UTMI_CLK>;
+			clock-names = "core", "iface", "sleep", "mock_utmi";
+			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
+					  <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			assigned-clock-rates = <19200000>, <133333333>;
+			status = "disabled";
+
+			usb@78c0000 {
+				compatible = "snps,dwc3";
+				reg = <0x078c0000 0xcc00>;
+				interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+				phys = <&usb2_phy_sec>;
+				phy-names = "usb2-phy";
+				snps,has-lpm-erratum;
+				snps,hird-threshold = /bits/ 8 <0x10>;
+				snps,usb3_lpm_capable;
+				dr_mode = "peripheral";
+			};
+		};
+
+		tlmm: pinctrl@1000000 {
+			compatible = "qcom,qcs404-pinctrl";
+			reg = <0x01000000 0x200000>,
+			      <0x01300000 0x200000>,
+			      <0x07b00000 0x200000>;
+			reg-names = "south", "north", "east";
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-ranges = <&tlmm 0 0 120>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			blsp1_i2c0_default: blsp1-i2c0-default-state {
+				pins = "gpio32", "gpio33";
+				function = "blsp_i2c0";
+			};
+
+			blsp1_i2c1_default: blsp1-i2c1-default-state {
+				pins = "gpio24", "gpio25";
+				function = "blsp_i2c1";
+			};
+
+			blsp1_i2c2_default: blsp1-i2c2-default-state {
+				sda-pins {
+					pins = "gpio19";
+					function = "blsp_i2c_sda_a2";
+				};
+
+				scl-pins {
+					pins = "gpio20";
+					function = "blsp_i2c_scl_a2";
+				};
+			};
+
+			blsp1_i2c3_default: blsp1-i2c3-default-state {
+				pins = "gpio84", "gpio85";
+				function = "blsp_i2c3";
+			};
+
+			blsp1_i2c4_default: blsp1-i2c4-default-state {
+				pins = "gpio117", "gpio118";
+				function = "blsp_i2c4";
+			};
+
+			blsp1_uart0_default: blsp1-uart0-default-state {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "blsp_uart0";
+			};
+
+			blsp1_uart1_default: blsp1-uart1-default-state {
+				pins = "gpio22", "gpio23";
+				function = "blsp_uart1";
+			};
+
+			blsp1_uart2_default: blsp1-uart2-default-state {
+				rx-pins {
+					pins = "gpio18";
+					function = "blsp_uart_rx_a2";
+				};
+
+				tx-pins {
+					pins = "gpio17";
+					function = "blsp_uart_tx_a2";
+				};
+			};
+
+			blsp1_uart3_default: blsp1-uart3-default-state {
+				cts-pins {
+					pins = "gpio84";
+					function = "blsp_uart3";
+				};
+
+				rts-tx-pins {
+					pins = "gpio85", "gpio82";
+					function = "blsp_uart3";
+				};
+
+				rx-pins {
+					pins = "gpio83";
+					function = "blsp_uart3";
+				};
+			};
+
+			blsp2_i2c0_default: blsp2-i2c0-default-state {
+				pins = "gpio28", "gpio29";
+				function = "blsp_i2c5";
+			};
+
+			blsp1_spi0_default: blsp1-spi0-default-state {
+				pins = "gpio30", "gpio31", "gpio32", "gpio33";
+				function = "blsp_spi0";
+			};
+
+			blsp1_spi1_default: blsp1-spi1-default-state {
+				mosi-pins {
+					pins = "gpio22";
+					function = "blsp_spi_mosi_a1";
+				};
+
+				miso-pins {
+					pins = "gpio23";
+					function = "blsp_spi_miso_a1";
+				};
+
+				cs-n-pins {
+					pins = "gpio24";
+					function = "blsp_spi_cs_n_a1";
+				};
+
+				clk-pins {
+					pins = "gpio25";
+					function = "blsp_spi_clk_a1";
+				};
+			};
+
+			blsp1_spi2_default: blsp1-spi2-default-state {
+				pins = "gpio17", "gpio18", "gpio19", "gpio20";
+				function = "blsp_spi2";
+			};
+
+			blsp1_spi3_default: blsp1-spi3-default-state {
+				pins = "gpio82", "gpio83", "gpio84", "gpio85";
+				function = "blsp_spi3";
+			};
+
+			blsp1_spi4_default: blsp1-spi4-default-state {
+				pins = "gpio37", "gpio38", "gpio117", "gpio118";
+				function = "blsp_spi4";
+			};
+
+			blsp2_spi0_default: blsp2-spi0-default-state {
+				pins = "gpio26", "gpio27", "gpio28", "gpio29";
+				function = "blsp_spi5";
+			};
+
+			blsp2_uart0_default: blsp2-uart0-default-state {
+				pins = "gpio26", "gpio27", "gpio28", "gpio29";
+				function = "blsp_uart5";
+			};
+		};
+
+		gcc: clock-controller@1800000 {
+			compatible = "qcom,gcc-qcs404";
+			reg = <0x01800000 0x80000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+
+			clocks = <&xo_board>,
+				 <&sleep_clk>,
+				 <&pcie_phy>,
+				 <0>,
+				 <0>,
+				 <0>;
+
+			assigned-clocks = <&gcc GCC_APSS_AHB_CLK_SRC>;
+			assigned-clock-rates = <19200000>;
+		};
+
+		tcsr_mutex: hwlock@1905000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x01905000 0x20000>;
+			#hwlock-cells = <1>;
+		};
+
+		tcsr: syscon@1937000 {
+			compatible = "qcom,qcs404-tcsr", "syscon";
+			reg = <0x01937000 0x25000>;
+		};
+
+		sram@290000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0x00290000 0x10000>;
+		};
+
+		spmi_bus: spmi@200f000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0200f000 0x001000>,
+			      <0x02400000 0x800000>,
+			      <0x02c00000 0x800000>,
+			      <0x03800000 0x200000>,
+			      <0x0200a000 0x002100>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
+		remoteproc_wcss: remoteproc@7400000 {
+			compatible = "qcom,qcs404-wcss-pas";
+			reg = <0x07400000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 153 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wcss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&wlan_fw_mem>;
+
+			qcom,smem-states = <&wcss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 156 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <1>;
+				mboxes = <&apcs_glb 16>;
+
+				label = "wcss";
+			};
+		};
+
+		pcie_phy: phy@7786000 {
+			compatible = "qcom,qcs404-pcie2-phy", "qcom,pcie2-phy";
+			reg = <0x07786000 0xb8>;
+
+			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+			resets = <&gcc GCC_PCIEPHY_0_PHY_BCR>,
+				 <&gcc GCC_PCIE_0_PIPE_ARES>;
+			reset-names = "phy", "pipe";
+
+			clock-output-names = "pcie_0_pipe_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			status = "disabled";
+		};
+
+		sdcc1: mmc@7804000 {
+			compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
+			reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
+			reg-names = "hc", "cqhci";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo_board>;
+			clock-names = "iface", "core", "xo";
+
+			status = "disabled";
+		};
+
+		blsp1_dma: dma-controller@7884000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07884000 0x25000>;
+			interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "okay";
+		};
+
+		blsp1_uart0: serial@78af000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078af000 0x200>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART0_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 0>, <&blsp1_dma 1>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart0_default>;
+			status = "disabled";
+		};
+
+		blsp1_uart1: serial@78b0000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b0000 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart1_default>;
+			status = "disabled";
+		};
+
+		blsp1_uart2: serial@78b1000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b1000 0x200>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 4>, <&blsp1_dma 5>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			status = "okay";
+		};
+
+		ethernet: ethernet@7a80000 {
+			compatible = "qcom,qcs404-ethqos";
+			reg = <0x07a80000 0x10000>,
+				<0x07a96000 0x100>;
+			reg-names = "stmmaceth", "rgmii";
+			clock-names = "stmmaceth", "pclk", "ptp_ref", "rgmii";
+			clocks = <&gcc GCC_ETH_AXI_CLK>,
+				<&gcc GCC_ETH_SLAVE_AHB_CLK>,
+				<&gcc GCC_ETH_PTP_CLK>,
+				<&gcc GCC_ETH_RGMII_CLK>;
+			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq", "eth_lpi";
+
+			snps,tso;
+			rx-fifo-depth = <4096>;
+			tx-fifo-depth = <4096>;
+
+			status = "disabled";
+		};
+
+		wifi: wifi@a000000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0xa000000 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_msa_mem>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		blsp1_uart3: serial@78b2000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x078b2000 0x200>;
+			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>, <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp1_dma 6>, <&blsp1_dma 7>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_uart3_default>;
+			status = "disabled";
+		};
+
+		blsp1_i2c0: i2c@78b5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP0_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi0: spi@78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP0_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c1: i2c@78b6000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c1_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi1: spi@78b6000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b6000 0x600>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi1_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c2: i2c@78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c2_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi2: spi@78b7000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b7000 0x600>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi2_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c3: i2c@78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c3_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi3: spi@78b8000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi3_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_i2c4: i2c@78b9000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_i2c4_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp1_spi4: spi@78b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x078b9000 0x600>;
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp1_spi4_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_dma: dma-controller@7ac4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x07ac4000 0x17000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		blsp2_uart0: serial@7aef000 {
+			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
+			reg = <0x07aef000 0x200>;
+			interrupts = <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_UART0_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp2_dma 0>, <&blsp2_dma 1>;
+			dma-names = "tx", "rx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_uart0_default>;
+			status = "disabled";
+		};
+
+		blsp2_i2c0: i2c@7af5000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x07af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP0_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_i2c0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		blsp2_spi0: spi@7af5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x07af5000 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_QUP0_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "core", "iface";
+			pinctrl-names = "default";
+			pinctrl-0 = <&blsp2_spi0_default>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		sram@8600000 {
+			compatible = "qcom,qcs404-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x1000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0 0x08600000 0x1000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0x94c 0xc8>;
+			};
+		};
+
+		intc: interrupt-controller@b000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x0b000000 0x1000>,
+			      <0x0b002000 0x1000>;
+		};
+
+		apcs_glb: mailbox@b011000 {
+			compatible = "qcom,qcs404-apcs-apps-global",
+				     "qcom,msm8916-apcs-kpss-global", "syscon";
+			reg = <0x0b011000 0x1000>;
+			#mbox-cells = <1>;
+			clocks = <&apcs_hfpll>, <&gcc GCC_GPLL0_AO_OUT_MAIN>;
+			clock-names = "pll", "aux";
+			#clock-cells = <0>;
+		};
+
+		apcs_hfpll: clock-controller@b016000 {
+			compatible = "qcom,hfpll";
+			reg = <0x0b016000 0x30>;
+			#clock-cells = <0>;
+			clock-output-names = "apcs_hfpll";
+			clocks = <&xo_board>;
+			clock-names = "xo";
+		};
+
+		watchdog@b017000 {
+			compatible = "qcom,apss-wdt-qcs404", "qcom,kpss-wdt";
+			reg = <0x0b017000 0x1000>;
+			clocks = <&sleep_clk>;
+		};
+
+		cpr: power-controller@b018000 {
+			compatible = "qcom,qcs404-cpr", "qcom,cpr";
+			reg = <0x0b018000 0x1000>;
+			interrupts = <0 15 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&xo_board>;
+			clock-names = "ref";
+			vdd-apc-supply = <&pms405_s3>;
+			#power-domain-cells = <0>;
+			operating-points-v2 = <&cpr_opp_table>;
+			acc-syscon = <&tcsr>;
+
+			nvmem-cells = <&cpr_efuse_quot_offset1>,
+				<&cpr_efuse_quot_offset2>,
+				<&cpr_efuse_quot_offset3>,
+				<&cpr_efuse_init_voltage1>,
+				<&cpr_efuse_init_voltage2>,
+				<&cpr_efuse_init_voltage3>,
+				<&cpr_efuse_quot1>,
+				<&cpr_efuse_quot2>,
+				<&cpr_efuse_quot3>,
+				<&cpr_efuse_ring1>,
+				<&cpr_efuse_ring2>,
+				<&cpr_efuse_ring3>,
+				<&cpr_efuse_revision>;
+			nvmem-cell-names = "cpr_quotient_offset1",
+				"cpr_quotient_offset2",
+				"cpr_quotient_offset3",
+				"cpr_init_voltage1",
+				"cpr_init_voltage2",
+				"cpr_init_voltage3",
+				"cpr_quotient1",
+				"cpr_quotient2",
+				"cpr_quotient3",
+				"cpr_ring_osc1",
+				"cpr_ring_osc2",
+				"cpr_ring_osc3",
+				"cpr_fuse_revision";
+		};
+
+		timer@b120000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0b120000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame@b121000 {
+				frame-number = <0>;
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b121000 0x1000>,
+				      <0x0b122000 0x1000>;
+			};
+
+			frame@b123000 {
+				frame-number = <1>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b123000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b124000 {
+				frame-number = <2>;
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b124000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b125000 {
+				frame-number = <3>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b125000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b126000 {
+				frame-number = <4>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b126000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b127000 {
+				frame-number = <5>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0xb127000 0x1000>;
+				status = "disabled";
+			};
+
+			frame@b128000 {
+				frame-number = <6>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				reg = <0x0b128000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		remoteproc_adsp: remoteproc@c700000 {
+			compatible = "qcom,qcs404-adsp-pas";
+			reg = <0x0c700000 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 293 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&adsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&xo_board>;
+			clock-names = "xo";
+
+			memory-region = <&adsp_fw_mem>;
+
+			qcom,smem-states = <&adsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,remote-pid = <2>;
+				mboxes = <&apcs_glb 8>;
+
+				label = "adsp";
+			};
+		};
+
+		pcie: pci@10000000 {
+			compatible = "qcom,pcie-qcs404";
+			reg = <0x10000000 0xf1d>,
+			      <0x10000f20 0xa8>,
+			      <0x07780000 0x2000>,
+			      <0x10001000 0x2000>;
+			reg-names = "dbi", "elbi", "parf", "config";
+			device_type = "pci";
+			linux,pci-domain = <0>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			ranges = <0x81000000 0x0 0x00000000 0x10003000 0x0 0x00010000>, /* I/O */
+				 <0x82000000 0x0 0x10013000 0x10013000 0x0 0x007ed000>; /* memory */
+
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_0_AUX_CLK>,
+				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+			clock-names = "iface", "aux", "master_bus", "slave_bus";
+
+			resets = <&gcc GCC_PCIE_0_AXI_MASTER_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_SLAVE_ARES>,
+				 <&gcc GCC_PCIE_0_AXI_MASTER_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE_0_BCR>,
+				 <&gcc GCC_PCIE_0_AHB_ARES>;
+			reset-names = "axi_m",
+				      "axi_s",
+				      "axi_m_sticky",
+				      "pipe_sticky",
+				      "pwr",
+				      "ahb";
+
+			phys = <&pcie_phy>;
+			phy-names = "pciephy";
+
+			status = "disabled";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 2 0xff08>,
+			     <GIC_PPI 3 0xff08>,
+			     <GIC_PPI 4 0xff08>,
+			     <GIC_PPI 1 0xff08>;
+	};
+
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+		interrupts = <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 10>;
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
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 14>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-wcss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apcs_glb 18>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		wcss_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		wcss_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	thermal-zones {
+		aoss-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 0>;
+
+			trips {
+				aoss_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		q6-hvx-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 1>;
+
+			trips {
+				q6_hvx_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		lpass-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				lpass_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		wlan-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				wlan_alert0: trip-point0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+
+		cluster-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cluster_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cluster_alert1: trip-point1 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cluster_crit: cluster-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cluster_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu0_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu0_alert1: trip-point1 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu0_crit: cpu-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu0_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 6>;
+
+			trips {
+				cpu1_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu1_alert1: trip-point1 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu1_crit: cpu-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu1_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu2-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 7>;
+
+			trips {
+				cpu2_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu2_alert1: trip-point1 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu2_crit: cpu-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu2_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu3-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 8>;
+
+			trips {
+				cpu3_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+				cpu3_alert1: trip-point1 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu3_crit: cpu-crit {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+			cooling-maps {
+				map0 {
+					trip = <&cpu3_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						       <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 9>;
+
+			trips {
+				gpu_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+			};
+		};
+	};
+};

-- 
2.42.1

