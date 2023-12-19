Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C11CC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E90E878CF;
	Tue, 19 Dec 2023 17:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m5TY9pF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47DC48784A; Tue, 19 Dec 2023 17:05:18 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ABD87705
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40c39ef63d9so51891545e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001889; x=1703606689; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZkW2+cAyClkWCHJCesNA+B/BKkYS4ezL45ZoOGJSX0=;
 b=m5TY9pF425U0uWmaOVWAeALFy13QO8jXKazmhprL2ix5cJBRtKoS/7SrEf8mmVNbKp
 3WW7CzEDFmxkAl/bABjW2o8P4KLUFTO8QozftDSyHWyane0sYobjZx47f9TRl9s3nG2s
 5sc51vSXGdiRVXYKrZ+9+gVIiHU7i9EJKcUuqoGQGTvzXZ1JVpaF4WetsmKL7/lMuZDY
 jtEKF5lvjMCiSMNIoAr2oSNmIENpWgbiaWELEz2ukKKgjW1+vLZZmZ/hBO3tgR3/1oiv
 x6sSVxrgF/DCGFp3bCtAyElZ3QZ9ZrxDlkGQBeybgouQaD4/bTGS0G4dEalhpvLWAIh+
 6jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001889; x=1703606689;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZkW2+cAyClkWCHJCesNA+B/BKkYS4ezL45ZoOGJSX0=;
 b=RZFRzO/R3JvxNrd7ZrFDWF8kveRFGVZi2WTcZl+uMTfaq4H2j8JozpqMhDlrbYqTNp
 FDv2jVw+6TlaY7x70QXarVPKDohUGjMsFIGv42kIuBGbh6RxxiUFbTyL4AWe+Wc+VRJR
 n/8xjl0Cmg1MBfpK11Bc/Vb5Rt2RHJrOV+PgmWA+dg9qOxf72S7JAkFuGAxf3mhomqcE
 9z6UOMI+h62X67kypo9lnNvjkvCv9asNdkRKNwrTE1cyjBeFkTf74qBadyQAK8PGpdJG
 K/bAVy2fGzTGG6McrtVBdtKJVOM3gKZe2xHkm3CfSmqbVydzVDiSU068bIHEVDMbTVuB
 WqLQ==
X-Gm-Message-State: AOJu0YyfiR/XFtlY6mzj7WOm/q4nS6lwA15Bz65FszlwPBCxUZm9wrWs
 FoBOD4n1PE4VEpiZ2RNcGhAasg==
X-Google-Smtp-Source: AGHT+IGg761Dboe4GumJkWWM+/DRq4lLBwemx2OHHYuCNYw2GUTQbj8wQQnzQLbur+rm4JOy/a6mnw==
X-Received: by 2002:a05:600c:519b:b0:40c:6de5:7613 with SMTP id
 fa27-20020a05600c519b00b0040c6de57613mr3783827wmb.173.1703001889596; 
 Tue, 19 Dec 2023 08:04:49 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:27 +0000
Subject: [PATCH v2 26/32] dts: msm8996: import PMIC dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-26-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5790;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=FSnie/BOv8k0n4xvFNwLCSICswUrpxIYKwtYdqTYdLg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SxsT3dwM4WZTs+yCFSe28uX39idvjYq5VoYG3NU5
 Opzujc7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwEQytzL8M9L97BtkrlwfszI8
 6VNA6mKl5IhXxteWJ/892/3b+YGaPCPDMrmAXfFdzNU+9Spvztn8q/EwVBG+cmM970SXkJIbHHG
 aAA==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/pm8994.dtsi  | 152 ++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/pmi8994.dtsi |  65 ++++++++++++++++++++
 2 files changed, 217 insertions(+)

diff --git a/arch/arm/dts/pm8994.dtsi b/arch/arm/dts/pm8994.dtsi
new file mode 100644
index 000000000000..672094c8ca58
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
+			adc-chan@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+				label = "vph_pwr";
+			};
+			adc-chan@8 {
+				reg = <VADC_DIE_TEMP>;
+				label = "die_temp";
+			};
+			adc-chan@9 {
+				reg = <VADC_REF_625MV>;
+				label = "ref_625mv";
+			};
+			adc-chan@a {
+				reg = <VADC_REF_1250MV>;
+				label = "ref_1250mv";
+			};
+			adc-chan@e {
+				reg = <VADC_GND_REF>;
+			};
+			adc-chan@f {
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
2.42.1

