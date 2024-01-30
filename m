Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4535C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A073587E2D;
	Tue, 30 Jan 2024 15:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BkD3VkN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BDF87D7E; Tue, 30 Jan 2024 15:06:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2791187E3B
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e80046246so22051025e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623540; x=1707228340; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H5NQmC7l90h6HABYZqlKqgSEPnfiX6UA0m/Uin4hHm4=;
 b=BkD3VkN55X+prsnkOwljd2/a87Kc5KgogGb+QnuCoVds4Ji8ERQvuv2jg+QGMdHRZt
 rofEpUtP6FioYIcajc5jNM8IDcuemd2KKghxKoD2PECERF+KaSB4ar7mPKVomYXx/Cxk
 ygqpbpD5eFZfwCiIwiXc96bww7QSEFNjpjt7LPWZcQVdXTsdYyHfVqXvst68lZpxkYn7
 WO7bbsoqdoP/SWKL+WYeXDc1pAgpAewSOfqtX3XAWp6/+mzQrXs08egJ0yYKe4+tkKKm
 VaPwgao6ew5QvcLhtt5if4CM4dl6vkoH6YYXHc8uNdroMs7VjJ+Hn3RW6sYdCxFx+y9T
 IBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623540; x=1707228340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H5NQmC7l90h6HABYZqlKqgSEPnfiX6UA0m/Uin4hHm4=;
 b=sCNFPEwNkI1HKNlz76TEvW+TOM5CFi/RQ8C+oR6F2mYnZBjqCIysVEG4zqeDRfowwL
 7a88do5Ffwp3LPc+CPI8GtjhDnyfgW4Zi9VsMEk/DdNohuH1pOT1uIjldKgmQCz2B0Om
 v5Uoi+YH226iTmxNNt56U5AlofoZJuonRYJiLIh6yw04STc89h/kjWxu0mIDj6GVloZm
 Y8AuG4ue1BtA0NKv4VOdqqFKyxSiCW4GEuL6THJ871GAOarf0nFyaq8qwPb1KDoSf4GT
 JGJNNt6o9zSKF0Fh8VdLwCOowkerwKR5nHgKed9xskmmztbP5PrYMzuaZkia1r7fncKh
 oclg==
X-Gm-Message-State: AOJu0YzxCe5mkGmAz9gYFQP0BugdhMLMtlUYwBgq56jcqDf+S0ZiVTxL
 tEpMxSRfDf0uWYYEte4UoVdC0AvYLeXSXyxKbOEOF6DYTeqiTRK9FYcjynrLNDc=
X-Google-Smtp-Source: AGHT+IEayott1cwADRObTIvtH/2kExSU7Ah+IIgCYGFS5qiMmE02kMWPAJFuZim/ripiksNNSlDdMA==
X-Received: by 2002:a05:600c:3516:b0:40f:25be:e811 with SMTP id
 h22-20020a05600c351600b0040f25bee811mr1374514wmq.8.1706623540711; 
 Tue, 30 Jan 2024 06:05:40 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:17 +0000
Subject: [PATCH v3 29/36] dts: msm8996: import PMIC dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-29-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
 bh=kT4EAkOZe1h7KnKSrDjVdYd3e/cqxnf3NQHCY/ykDu0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTEIiVo/aSiPmXp4xiaFtTtbaqGdVpdk/GSc0LNpxy
 OIPQ97RjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR088Y/gdwKK9dPMds38lf
 lgzlvEu95zM//G9Zd0UjZveLWV8m/PzGyNBiVyBSwH1un8zLEzcVg87V+W84PT3V3NIp/f/zbXl
 10xYBAA==
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
2.43.0

