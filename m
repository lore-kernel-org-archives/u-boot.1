Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8A3C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD3D87F15;
	Thu, 15 Feb 2024 21:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mp+6HxjS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB85287E49; Thu, 15 Feb 2024 21:54:03 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7F487E44
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33cddf4b4b5so960884f8f.0
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030380; x=1708635180; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Pn2CbclRZ2iDH7xRNCYe6hR7Kz1RBtG9UI97nWJtYQ=;
 b=mp+6HxjSvXCk5V85AvwLGkXgFJiEX2gcYzNfzxmZ3mcYfe4zUj0e/9VWiWcrYoSIRj
 5oxv0UTixbHuC5rJz0+iDyzQYALSe5LlqOrJEBAtx5mZhm2vMO1vwxiJrsyygJIFJV3J
 DiDc7M8BC6AQx7wD+gt3UWvyJe1p+XKfZylH28lWo9tDuNRA+hzaDwoCvjPSIs5W2bgS
 8xV20aDhqEyD4SeqmOcLrgwQnj/+l8oiV+Knlq/SO/8LiKWImWTC2yc4z3ihnZIRBmfi
 PF5lQwwhrbi8araKsIiQAG6464AQETwez/hVjQWjrHQktSuQ+Fh5zxGafbXfEtB/hJYL
 KlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030380; x=1708635180;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Pn2CbclRZ2iDH7xRNCYe6hR7Kz1RBtG9UI97nWJtYQ=;
 b=QivR0oFB68zJTykJU9chzFIRScIhBbPnTgK6LMwcHkEpdtDbZ+B4naTZbm3J70R/k8
 7OGvgsJYyXbuI+ON29UeJlB2QYiigYYQj5Ta6pkj44kDyKfwqIk9r/2h3O5U6KLRiV43
 bkX36Nl1eDJP9rTYgECxtS+2ZQGJX96ySavhWK09ZTs1Vhmt8PozlhNXFda3CoeOBVLX
 jJCB5pDljFCldGER4ltDP5f7hIDwQs8p2MEzhu4w/QEP9tZfCXe+sneB4m4lmm4WL3RI
 f6WMBlbfINki+YDD2wa4ct3mQRuJLj/fPHVp3ilAYqBs5c9QlcTgtLjjV8i/qSADahs0
 ihLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEQXc9I9BCbJPGnDTGvd3QFU6LCfzWuVFwLsAbT/Qr3fgLucjJuYSztglCy8XdFO5Otmac560Lbqe9rmMrpjiUsur4cQ==
X-Gm-Message-State: AOJu0YxJhkOowzvpMPch84vjUQG54kqnfujJTM+SDlm6PXW0asrd8QZP
 7KVljcqfAjlHbjMhymi740r5Ivs6Zspltn6Y+OSyP9yT5cJl5TF8FaV1EGdj5l76LG9UESU9tcj
 4
X-Google-Smtp-Source: AGHT+IEhumUSMKWYYu8PXFvgV2oVzad9x89Y/dQ/ZGGVKCQuGWuOXWQCd5yADoo3CiLKhWNSXirx0g==
X-Received: by 2002:a5d:49c6:0:b0:33b:6942:df07 with SMTP id
 t6-20020a5d49c6000000b0033b6942df07mr2006002wrs.21.1708030380441; 
 Thu, 15 Feb 2024 12:53:00 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:59 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:52 +0000
Subject: [PATCH v4 34/39] dts: msm8996: import PMIC dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-34-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5871;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LeYYoVpYYH96rFUcUGmN4Z1DRV1VtQiFod+6f9MXCNU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzle1Zi6NXLa95GfxI7dzTsxu0LOedvLC6MO6xFlf+z
 B/7FgREdZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ8LEy/Pc6eUHFcsmFducC
 g+t8VZVVNZ9uS278Nbfo7+OMMN4/N64w/A9K/dTYFXf/VfnrkKcv/ga/PndqV9Y63qPpJxZcNDU
 y+PgMAA==
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

Import PM8994 and PMI8994 DTSI files in preparation for switching
MSM8996 boards to upstream DTS.

Taken from kernel tag v6.7

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/pm8994.dtsi  | 152 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/pmi8994.dtsi |  65 ++++++++++++++++++++
 2 files changed, 217 insertions(+)

diff --git a/arch/arm/dts/pm8994.dtsi b/arch/arm/dts/pm8994.dtsi
new file mode 100644
index 000000000000..d44a95caf04a
--- /dev/null
+++ b/arch/arm/dts/pm8994.dtsi
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8994-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8994_temp>;
+
+			trips {
+				pm8994_alert0: pm8994-alert0 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8994_crit: pm8994-crit {
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
+
+	pmic@0 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8994_pon: pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
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
+
+			pm8994_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		pm8994_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8994_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8994_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+			channel@8 {
+				reg = <VADC_DIE_TEMP>;
+				label = "die_temp";
+			};
+			channel@9 {
+				reg = <VADC_REF_625MV>;
+				label = "ref_625mv";
+			};
+			channel@a {
+				reg = <VADC_REF_1250MV>;
+				label = "ref_1250mv";
+			};
+			channel@e {
+				reg = <VADC_GND_REF>;
+			};
+			channel@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+
+		pm8994_gpios: gpio@c000 {
+			compatible = "qcom,pm8994-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8994_gpios 0 0 22>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8994_mpps: mpps@a000 {
+			compatible = "qcom,pm8994-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8994_mpps 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8994", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8994_lpg: pwm {
+			compatible = "qcom,pm8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		pm8994_spmi_regulators: regulators {
+			compatible = "qcom,pm8994-regulators";
+		};
+	};
+};
diff --git a/arch/arm/dts/pmi8994.dtsi b/arch/arm/dts/pmi8994.dtsi
new file mode 100644
index 000000000000..36d6a1fb553a
--- /dev/null
+++ b/arch/arm/dts/pmi8994.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pmic@2 {
+		compatible = "qcom,pmi8994", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8994_gpios: gpio@c000 {
+			compatible = "qcom,pmi8994-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8994_gpios 0 0 10>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pmi8994_mpps: mpps@a000 {
+			compatible = "qcom,pmi8994-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8994_mpps 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pmic@3 {
+		compatible = "qcom,pmi8994", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmi8994_lpg: pwm {
+			compatible = "qcom,pmi8994-lpg";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		pmi8994_spmi_regulators: regulators {
+			compatible = "qcom,pmi8994-regulators";
+		};
+
+		pmi8994_wled: wled@d800 {
+			compatible = "qcom,pmi8994-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
+			qcom,cabc;
+			qcom,external-pfet;
+			status = "disabled";
+		};
+	};
+};

-- 
2.43.1

