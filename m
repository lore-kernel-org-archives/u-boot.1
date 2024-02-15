Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981E5C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D842E87F76;
	Thu, 15 Feb 2024 21:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EkyrO2ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E5487F67; Thu, 15 Feb 2024 21:53:41 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CFBF87E83
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33cf7812777so722257f8f.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030373; x=1708635173; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dgXyCD4i7pdnGWCYYpUapZozc5dNH7qHSnKYm+5wLzE=;
 b=EkyrO2eyVtPPpjVD3YfOb0TdJPyDHf9VFdrNLptu356MXOu1cx7dUSXsiFgLy98AUb
 Au8vW7rbik4fTQzkyHrM28n4KfKo8+mq4ZAqBarZhH68KsLl9fLRo4rVD5AB8Hhp8jBj
 K33zblo8+TraGoJuFRRCH/WmOMtEAc+bMnXW+mXKEAx+HFAYF9l1c32Bdu9pE8UNYGTm
 urH4uaYWDLWIf2eMlgPbmWgsFo6VlsjAd69d+tprf5AmwkW/QSvyKMWMd/JcDCuM+PTi
 yXaQ083P/7gm5qzMCNOquK9zAvQKJy6kUsvcpQLEQwgPKFLpFvndSZpDH29pT9hJJuRQ
 /k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030373; x=1708635173;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dgXyCD4i7pdnGWCYYpUapZozc5dNH7qHSnKYm+5wLzE=;
 b=tgh0qcHZ96DmBzQz4V7SMrXHFYWfXulwBMW+8qdS5DI7hzt9qHtMoTaj/QmcDsl/C6
 C0kXcVjtKMimVgxAWj8GETZBfmmzbEwQ7bemp2qZONiLeQwIlY8qe/j0CGSqie15G7Xg
 2zRMiX/cbbB/kIGPszBND49xAq85F6lh5do/yoTBo7HC0dV8dU8EZL5Xj4VMDIcj87GD
 jo02txtbgNZSpQbm+nvI0cGSVLcxVhvNtUY3MdDTwwXzcJjTobltXGvK6HE27h9CEE+q
 lPVr6g36GaQ8TdwDo3CzvvQFSHa3h0O7d4SqQUxnkRPU5FJQ0JGOPO1m1e5x8IreLyNO
 NScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj8z0Cfxwb7r96WFVIe5tWl/6IrI3PllUYo72Z4QzD0cP5qxutMNON2TD7nmLMvbI4m4HSXAanBu34rpoyl2TPNW1EGw==
X-Gm-Message-State: AOJu0Yy13qwGALjl0IJyxlsMsiqbEnhSuxjFNomF4YZffvRf8bo2WcmD
 /Pf+aA04ymGFbBUnf+oAkyetgL7bXw6GaJ6oXt2IYmitplmpTrDUrilTnSiiuuDOK2/iMPqfFjW
 2
X-Google-Smtp-Source: AGHT+IG97/4/WYgohHGEDcc7TrV20mkamzDh0Wi8yeqNZI2c8VFk+PRbQSDtKfz2+/gHd4xcEOaNfQ==
X-Received: by 2002:adf:f2c3:0:b0:33b:48ee:8a35 with SMTP id
 d3-20020adff2c3000000b0033b48ee8a35mr2474438wrp.3.1708030373561; 
 Thu, 15 Feb 2024 12:52:53 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:46 +0000
Subject: [PATCH v4 28/39] dts: sdm845: import supporting dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-28-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8827;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5uL8P5ObobohhBGwsLv0VSJTIAjNpe+AHme5wP/FlQ8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlW3Fa6cZZK6/fi5Ia6uixRlZHs5L5ziTm1YttXiry
 ZZ/vKO4o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEykuZvhf13nsUla0czKG4W+
 3Ok+vP4zu9ps76uL37dJ75OJ7WnYco3hv7vIt3T2e61JZZqs5w1NTpk5795j2BkdrfxtgeVmkU0
 XdAE=
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

Import the PM8998 and PMI8998 PMIC DTSI files from Linux as well
as the common audio codec in preperation for replacing board DTS files
with upstream.

Taken from kernel tag v6.7

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
2.43.1

