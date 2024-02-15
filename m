Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A844EC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56FEF87F74;
	Thu, 15 Feb 2024 21:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="afFFSxQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B54CC87ED7; Thu, 15 Feb 2024 21:53:47 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43ABE8718A
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41239bbab1aso58135e9.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030377; x=1708635177; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aAgUaZ7u1D8eTt07EvcX8Y+mmPl9PlP3RYowakTJ+Mk=;
 b=afFFSxQWFtY4KxfTh8Bq5fEwPRl6ohQND1tj/upC/0302enQJe8bXU3kVM5rh1Y0KE
 ngFpQeB1JCYhDiedoMlJS/aYBgd6nwHe5VpoY90tRdJar99vDDt9G39GcK9W7mhulRKi
 CRFOIathJPUFAYbAg0T/P6jR4Kue6RgNuxjybmj4oPdJyzTP99Fr8vQUXSKwB5CvYLoq
 9/+aIoZnpjy/651TW8LzDTnz5cRHaSpTLdChUZZLbjxDk0axj3f6XVcFiVNbt2lKi7Tn
 y0D0L7WCmmyp1aUjO1uEZ/6SId1ygh3d+KXN2dzC/bHWBCJiFSCFi1yI3TwXaNnuxxI2
 BDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030377; x=1708635177;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAgUaZ7u1D8eTt07EvcX8Y+mmPl9PlP3RYowakTJ+Mk=;
 b=iVkBUr7NRJ94rOJSdM6fFUv9Bs++wctYBvin4XVn0bG8dHMgPtwPrurN9lxhguL4fW
 2vgf+3gurzUEsCOuDfHBen9Rg1VJLFLadSxoPNETIY/JDVZs9ybEeLkrHH82VJ59OU97
 +5pg041kHFNiT1V37CEfcw+r/Z1h/XabTeW9or8yMs9JttwzKwQSiAb+Cp+Cp/bUVtgh
 FUeMvgrrP4ss92NB91OeXPpRdy4Kxua78huIfc1qPg8xqhkO8L1ZkuhZ+ocaQIbPO/HK
 qsquMYVQZHUW3dEXgPdQNIbezVincP0fgVKDW49o/T7oH+xxVaYXKbaUgllX+ddrK4g7
 iwjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPb1TYfjhukiIdYtKT6wK0USoxvQLJEI17IPCvAjkwyR2IqawWgl+6QmSSR3zAFb4yBf11ufSb/8ZTXs6VRqsKcpkavw==
X-Gm-Message-State: AOJu0YwyGhRfrIqKWUPseIOzue24g1w6sr+peG9Rx2Vas3WAtHBCSeWR
 NT15rbV7EZK8diD7yh1jWM8wVc73XG08fb9IEBxMeuEYXlGSVNom4PYVooYaXz86ap0S5FbQ+aK
 Z
X-Google-Smtp-Source: AGHT+IHhKJ7SHZ87jq2DnAULOt/STB4fDF0/96oYjrKbg+nDpHTw3+3JJNIf6aDCvJf+jzaEtW7bIw==
X-Received: by 2002:a05:600c:4691:b0:410:cbc5:b4ab with SMTP id
 p17-20020a05600c469100b00410cbc5b4abmr2905777wmo.19.1708030376970; 
 Thu, 15 Feb 2024 12:52:56 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:56 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:49 +0000
Subject: [PATCH v4 31/39] dts: msm8916: import PMIC dtsi files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-31-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9340;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XSpc+BGZ0g95PCxSI2C5ir0A0AmOuOlOfrlGqYM/Rqg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzle2qtzt+5W2JqrvsOIm/V4U1zV1c8U3PPPNJOb0Gz
 otm/JrUUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTAC7yi+F/wZLEs12uE28XOkud
 z2kuWLzWbs6mP6n/Axfvz2Nb0NT5npGh+9xi94uf8qpXrD33ILnv+F7e+9tmTW131Z6ydJ2/pGh
 9JAA=
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

Import the supporting pm8916.dtsi and msm8916-pm8916.dtsi files from
upstream in preparation for switching boards over.

Taken from kernel tag v6.7

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/msm8916-pm8916.dtsi | 157 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/pm8916.dtsi         | 178 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 335 insertions(+)

diff --git a/arch/arm/dts/msm8916-pm8916.dtsi b/arch/arm/dts/msm8916-pm8916.dtsi
new file mode 100644
index 000000000000..b1a7eafbee31
--- /dev/null
+++ b/arch/arm/dts/msm8916-pm8916.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * msm8916-pm8916.dtsi describes common properties (e.g. regulator connections)
+ * that apply to most devices that make use of the MSM8916 SoC and PM8916 PMIC.
+ * Many regulators have a fixed purpose in the original reference design and
+ * were rarely re-used for different purposes. Devices that deviate from the
+ * typical reference design should not make use of this include and instead add
+ * the necessary properties in the board-specific device tree.
+ */
+
+#include "msm8916.dtsi"
+#include "pm8916.dtsi"
+
+&camss {
+	vdda-supply = <&pm8916_l2>;
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l6>;
+};
+
+&mdss_dsi0_phy {
+	vddio-supply = <&pm8916_l6>;
+};
+
+&mpss {
+	pll-supply = <&pm8916_l7>;
+};
+
+&pm8916_codec {
+	vdd-cdc-io-supply = <&pm8916_l5>;
+	vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	vdd-micbias-supply = <&pm8916_l13>;
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8916_l8>;
+	vqmmc-supply = <&pm8916_l5>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8916_l11>;
+	vqmmc-supply = <&pm8916_l12>;
+};
+
+&usb_hs_phy {
+	v1p8-supply = <&pm8916_l7>;
+	v3p3-supply = <&pm8916_l13>;
+};
+
+&wcnss {
+	vddpx-supply = <&pm8916_l7>;
+};
+
+&wcnss_iris {
+	vddxo-supply = <&pm8916_l7>;
+	vddrfa-supply = <&pm8916_s3>;
+	vddpa-supply = <&pm8916_l9>;
+	vdddig-supply = <&pm8916_l5>;
+};
+
+&rpm_requests {
+	pm8916_rpm_regulators: regulators {
+		compatible = "qcom,rpm-pm8916-regulators";
+		vdd_l1_l2_l3-supply = <&pm8916_s3>;
+		vdd_l4_l5_l6-supply = <&pm8916_s4>;
+		vdd_l7-supply = <&pm8916_s4>;
+
+		/* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
+
+		pm8916_s3: s3 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <1350000>;
+			regulator-always-on; /* Needed for L2 */
+		};
+
+		pm8916_s4: s4 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <2150000>;
+			regulator-always-on; /* Needed for L5/L7 */
+		};
+
+		/*
+		 * Some of the regulators are unused or managed by another
+		 * processor (e.g. the modem). We should still define nodes for
+		 * them to ensure the vote from the application processor can be
+		 * dropped in case the regulators are already on during boot.
+		 *
+		 * The labels for these nodes are omitted on purpose because
+		 * boards should configure a proper voltage before using them.
+		 */
+		l1 {};
+
+		pm8916_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-always-on; /* Needed for LPDDR RAM */
+		};
+
+		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
+
+		l4 {};
+
+		pm8916_l5: l5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for most digital I/O */
+		};
+
+		pm8916_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8916_l7: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for CPU PLL */
+		};
+
+		pm8916_l8: l8 {
+			regulator-min-microvolt = <2900000>;
+			regulator-max-microvolt = <2900000>;
+		};
+
+		pm8916_l9: l9 {
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		l10 {};
+
+		pm8916_l11: l11 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+			regulator-allow-set-load;
+			regulator-system-load = <200000>;
+		};
+
+		pm8916_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8916_l13: l13 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		l14 {};
+		l15 {};
+		l16 {};
+		l17 {};
+		l18 {};
+	};
+};
diff --git a/arch/arm/dts/pm8916.dtsi b/arch/arm/dts/pm8916.dtsi
new file mode 100644
index 000000000000..f4de86787743
--- /dev/null
+++ b/arch/arm/dts/pm8916.dtsi
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pm8916_0: pmic@0 {
+		compatible = "qcom,pm8916", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pon@800 {
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
+			pm8916_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+
+			watchdog {
+				compatible = "qcom,pm8916-wdt";
+				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
+				timeout-sec = <60>;
+			};
+		};
+
+		pm8916_usbin: usb-detect@1300 {
+			compatible = "qcom,pm8941-misc";
+			reg = <0x1300>;
+			interrupts = <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "usb_vbus";
+			status = "disabled";
+		};
+
+		pm8916_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8916_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8916_vadc: adc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			channel@0 {
+				reg = <VADC_USBIN>;
+				qcom,pre-scaling = <1 10>;
+			};
+			channel@7 {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+			};
+			channel@8 {
+				reg = <VADC_DIE_TEMP>;
+			};
+			channel@9 {
+				reg = <VADC_REF_625MV>;
+			};
+			channel@a {
+				reg = <VADC_REF_1250MV>;
+			};
+			channel@e {
+				reg = <VADC_GND_REF>;
+			};
+			channel@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8916_mpps: mpps@a000 {
+			compatible = "qcom,pm8916-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8916_mpps 0 0 4>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		pm8916_gpios: gpio@c000 {
+			compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			gpio-ranges = <&pm8916_gpios 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8916_1: pmic@1 {
+		compatible = "qcom,pm8916", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8916_pwm: pwm {
+			compatible = "qcom,pm8916-pwm";
+
+			#pwm-cells = <2>;
+
+			status = "disabled";
+		};
+
+		pm8916_vib: vibrator@c000 {
+			compatible = "qcom,pm8916-vib";
+			reg = <0xc000>;
+			status = "disabled";
+		};
+
+		pm8916_codec: audio-codec@f000 {
+			compatible = "qcom,pm8916-wcd-analog-codec";
+			reg = <0xf000>;
+			interrupt-parent = <&spmi_bus>;
+			interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+				     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+				     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+			interrupt-names = "cdc_spk_cnp_int",
+					  "cdc_spk_clip_int",
+					  "cdc_spk_ocp_int",
+					  "mbhc_ins_rem_det1",
+					  "mbhc_but_rel_det",
+					  "mbhc_but_press_det",
+					  "mbhc_ins_rem_det",
+					  "mbhc_switch_int",
+					  "cdc_ear_ocp_int",
+					  "cdc_hphr_ocp_int",
+					  "cdc_hphl_ocp_det",
+					  "cdc_ear_cnp_int",
+					  "cdc_hphr_cnp_int",
+					  "cdc_hphl_cnp_int";
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+	};
+};

-- 
2.43.1

