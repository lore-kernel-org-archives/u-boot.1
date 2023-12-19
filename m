Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E805C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37C1A87767;
	Tue, 19 Dec 2023 17:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VOJc/MmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18D987767; Tue, 19 Dec 2023 17:05:14 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C92D18786F
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e3845abdaso3352200e87.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001887; x=1703606687; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7DlRCcUoEIvW/sNuGC8yavuGq03NoOc9Dcd5RhswoBo=;
 b=VOJc/MmMvCcLG+ARuBtRyz8ZKeqHwPRhk/VH2S0T9PPoNaB1OoRvxatFEHor1w2qvG
 Wiuj7Hqx2bAANaALAxzXvBnFQLcbva/yzK+lG8IVNL8HT2SM0BdA2z7SSpCp+4TGO2T/
 nc0hCQNy8I/fMZWF9lMj36471Px9py6l5IxcIJVRvn03XNkMUBjJ9SLU7W4GQV/03x8F
 idZzVnJFOfReXcNwB6/rA75rlYeWxT3CJ44tuQYJJ/EyY8xtYdD2SBW/U4QKn60CeUXd
 MRUFP4anBG1tVcyzNqmsIBbP2BtXeNTRHb25DhQGZJk9xc3/zgaD5QBzXEQGqDI79y5T
 rXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001887; x=1703606687;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7DlRCcUoEIvW/sNuGC8yavuGq03NoOc9Dcd5RhswoBo=;
 b=HFytEI+UrSlUMXxZV1RCv0C4VPQYaJ+EvFPMuJB45UaZ9tHRlYxU2pbok1UEkVv0BB
 ZYDJ8ebEkGaVg1okLnEu1YQ4vZDCEH7IQ4nA8yoke9Ou029ZaX/haLyJz/ewCL4w0/7M
 LqPAQOKjjJtmwup1UusdKOSOAlmJJE1oRh7efftZJYeHp/EnXhsvSX39vpa71umM2k3r
 h6kuRBjcCxsIrEFFYVpkzcgSjMwvzL7hNgoCJabHzwrZXkT5OSlwGFtt5fmL7h8FFGer
 HBgUUZ0xvgCP2zWcLw6QdpswEj4bLhvL7r63LZdCQZa9U3sK1Yox4PiX1LoCSIC3msUD
 e2zA==
X-Gm-Message-State: AOJu0YwzWI+6S3bnExc0mruGAHDMyjJoGjt4tPhHe0ozP2A2XV1R2NPD
 E4YZQUqLTTJh4Hx/mrh4s9Qukw==
X-Google-Smtp-Source: AGHT+IHwRudLh/cZBnxaLjp6wS5jHLyHTLhJj8uWmmrvqb+NDn7hOaAcizp0JOJ1xg5yhpIQBbZJbA==
X-Received: by 2002:ac2:4e07:0:b0:50e:1943:e8e5 with SMTP id
 e7-20020ac24e07000000b0050e1943e8e5mr5334641lfr.136.1703001882907; 
 Tue, 19 Dec 2023 08:04:42 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:21 +0000
Subject: [PATCH v2 20/32] dts: sdm845: import supporting dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-20-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8748;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kG8ufA5EIYsWeqBixz+7vyGKY02FEtpp3QrG2nnX2eA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/czVgbXbKyXzNh848vL5BOPf0dMq7ntlCe/qOZi48
 UVxnmNIRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIvhbDb1bxNx4ZJmkzUo45
 xVsv+uSVuynmiJv6A4+j4ia/5/9V82dk6Go23x29Yl99WaiFPBfDRelj3Os8yvcVZrmvVWuOZTl
 qCwA=
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

Import the PM8998 and PMI8998 PMIC DTSI files from Linux 6.7-rc3 as well
as the common audio codec in preperation for replacing board DTS files
with upstream.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/pm8998.dtsi         | 130 +++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/pmi8998.dtsi        |  98 +++++++++++++++++++++++++++++
 arch/arm/dts/sdm845-wcd9340.dtsi |  86 ++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)

diff --git a/arch/arm/dts/pm8998.dtsi b/arch/arm/dts/pm8998.dtsi
new file mode 100644
index 000000000000..3f82715392c6
--- /dev/null
+++ b/arch/arm/dts/pm8998.dtsi
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/* Copyright 2018 Google LLC. */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pm8998-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8998_temp>;
+
+			trips {
+				pm8998_alert0: pm8998-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
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
+	pm8998_lsid0: pmic@0 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8998_pon: pon@800 {
+			compatible = "qcom,pm8998-pon";
+
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pm8998_pwrkey: pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+
+			pm8998_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8998_adc ADC5_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8998_coincell: charger@2800 {
+			compatible = "qcom,pm8998-coincell", "qcom,pm8941-coincell";
+			reg = <0x2800>;
+
+			status = "disabled";
+		};
+
+		pm8998_adc: adc@3100 {
+			compatible = "qcom,spmi-adc-rev2";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@6 {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
+		};
+
+		pm8998_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm-hc";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8998_gpios: gpio@c000 {
+			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8998_gpios 0 0 26>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+	};
+
+	pm8998_lsid1: pmic@1 {
+		compatible = "qcom,pm8998", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
diff --git a/arch/arm/dts/pmi8998.dtsi b/arch/arm/dts/pmi8998.dtsi
new file mode 100644
index 000000000000..cd3f0790fd42
--- /dev/null
+++ b/arch/arm/dts/pmi8998.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmi8998_lsid0: pmic@2 {
+		compatible = "qcom,pmi8998", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8998_charger: charger@1000 {
+			compatible = "qcom,pmi8998-charger";
+			reg = <0x1000>;
+
+			interrupts = <0x2 0x13 0x4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x16 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x13 0x6 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "usb-plugin",
+					  "bat-ov",
+					  "wdog-bark",
+					  "usbin-icl-change";
+
+			io-channels = <&pmi8998_rradc 3>,
+				      <&pmi8998_rradc 4>;
+			io-channel-names = "usbin_i", "usbin_v";
+
+			status = "disabled";
+		};
+
+		pmi8998_gpios: gpio@c000 {
+			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8998_gpios 0 0 14>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmi8998_rradc: adc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+		};
+	};
+
+	pmi8998_lsid1: pmic@3 {
+		compatible = "qcom,pmi8998", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		labibb {
+			compatible = "qcom,pmi8998-lab-ibb";
+
+			ibb: ibb {
+				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>,
+					     <0x3 0xdc 0x0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "sc-err", "ocp";
+			};
+
+			lab: lab {
+				interrupts = <0x3 0xde 0x1 IRQ_TYPE_EDGE_RISING>,
+					     <0x3 0xde 0x0 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-names = "sc-err", "ocp";
+			};
+		};
+
+		pmi8998_lpg: pwm {
+			compatible = "qcom,pmi8998-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		pmi8998_flash: led-controller@d300 {
+			compatible = "qcom,pmi8998-flash-led", "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
+		pmi8998_wled: leds@d800 {
+			compatible = "qcom,pmi8998-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
+			label = "backlight";
+
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/dts/sdm845-wcd9340.dtsi b/arch/arm/dts/sdm845-wcd9340.dtsi
new file mode 100644
index 000000000000..c15d48860646
--- /dev/null
+++ b/arch/arm/dts/sdm845-wcd9340.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 SoC device tree source
+ *
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+&slim {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		wcd9340_ifd: ifd@0,0 {
+			compatible = "slim217,250";
+			reg = <0 0>;
+		};
+
+		wcd9340: codec@1,0 {
+			compatible = "slim217,250";
+			reg = <1 0>;
+			slim-ifc-dev = <&wcd9340_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			clock-names = "extclk";
+			clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+
+			pinctrl-0 = <&wcd_intr_default>;
+			pinctrl-names = "default";
+
+			qcom,micbias1-microvolt = <1800000>;
+			qcom,micbias2-microvolt = <1800000>;
+			qcom,micbias3-microvolt = <1800000>;
+			qcom,micbias4-microvolt = <1800000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wcdgpio: gpio-controller@42 {
+				compatible = "qcom,wcd9340-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x42 0x2>;
+			};
+
+			swm: swm@c85 {
+				compatible = "qcom,soundwire-v1.3.0";
+				reg = <0xc85 0x40>;
+				interrupts-extended = <&wcd9340 20>;
+
+				qcom,dout-ports = <6>;
+				qcom,din-ports = <2>;
+				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
+				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
+				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
+
+				#sound-dai-cells = <1>;
+				clocks = <&wcd9340>;
+				clock-names = "iface";
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
+
+&tlmm {
+	wcd_intr_default: wcd-intr-default-state {
+		pins = "gpio54";
+		function = "gpio";
+
+		bias-pull-down;
+		drive-strength = <2>;
+	};
+};

-- 
2.42.1

