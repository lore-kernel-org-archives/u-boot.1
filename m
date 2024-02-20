Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F62C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FE487FAE;
	Tue, 20 Feb 2024 15:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OjSnJ2l9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A480E87FC9; Tue, 20 Feb 2024 15:08:53 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1149387FE9
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e2d83d2568so3767879a34.3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438122; x=1709042922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfPX0cUJ7RNjUkaTT0ejWcnMZI/LyxUpw6tgH9JB3Ig=;
 b=OjSnJ2l9WpRYPUeboTVREszGY82QKtqxWUZpxebF5+TsBt/Bpt7gVKm+l0zw6OP3XP
 UL16qpgk+WVc/7BKmP/w0Gl3ZX0GX1zLlv/LhZ00BwKg85OhrTDby4Qdiae/VrFVVn4B
 eH8hvFCKeFgdoJJmhSC1dvOUnb9MGXsDkotMLVFg1xZ6af6TzaaQoUu4BLPnbklTLwxt
 p6kikN8Qznt7t0Ls7ZqIMs9s28kCE4yDAqyxnOn1+ua6ODD8LAruFFv2uQhi1l76JNMF
 HRbc35/HoOt+xjw4Mb+XYnKW5HQloj9zTmFScKC4ifJ7UOfd6DQ6UuPAxsZgAmq5kZIx
 0GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438122; x=1709042922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfPX0cUJ7RNjUkaTT0ejWcnMZI/LyxUpw6tgH9JB3Ig=;
 b=QAMNov51KCgKB6WSiiwzifbn7q3eM7U36ch6Go72pBcTVQPDmXPofgkcGU/EBkD7Pn
 ew7XdiejbiMjEP+y42uLCtGONdicHF1EfkatK4WXn2XqgVuOOvaQX/3FHT6hJPiLsM+X
 07vF+1K6ukV0HWAnarOWwpDg947RaaHMK+1IU9i0sIaxT9MiZ6nD4Kel7sdnwrtCXLj1
 RULHJXUyx4LHqSG9776RXfwPLDYaYGhfITVCf51SJ6YL8JYDip0lWK6UNpsre/XuFQx7
 Eyl9Vjf1Gg5asIuj38k6AAEslrUpLdSM9H+5C0mHhmGxW9nZub0VbbhTqmvUVKD2Udrp
 qD7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGr0GERZt94+tMU9qOZsmf5uHhHagwjkg1K8/I6OjtX2RsY+ddGXLPj8z9Xxix0gZwwKERZ4WT+NQuHN0y5bWJrH1UaA==
X-Gm-Message-State: AOJu0YyiFfSlp2QCEzBjTKvqWIhgmqpAqf7nFj9nQ1P3+xgGD3H2GcaT
 3e3k6CFkdC8Lu6bLBDC11PMZ9ebympskVjcynDNYMPdGpkdFzF3I4Ul+mHSi1ZlX9Nn64x0Ra4O
 FBv3lf0EYvZozrydwf6mmwEIOm0YTFtNkk954ZA==
X-Google-Smtp-Source: AGHT+IFs/pIzOgDnjzTjNCW0+WwrCyKRyEYWm8Dd+ZKslOcSXQAcrvlRhtuHs3T3RgtJ1OGb9mPlpP3ru0hGHTI7WrM=
X-Received: by 2002:a05:6808:3a05:b0:3c1:3e44:3ded with SMTP id
 gr5-20020a0568083a0500b003c13e443dedmr19187326oib.19.1708438122344; Tue, 20
 Feb 2024 06:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-31-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-31-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:38:31 +0530
Message-ID: <CAFA6WYM7pBPWWL_sh6OL_Axe2z-0tOF9rVuQtzNp9kDfQhu7xQ@mail.gmail.com>
Subject: Re: [PATCH v4 31/39] dts: msm8916: import PMIC dtsi files
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Import the supporting pm8916.dtsi and msm8916-pm8916.dtsi files from
> upstream in preparation for switching boards over.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/msm8916-pm8916.dtsi | 157 ++++++++++++++++++++++++++++++++++
>  arch/arm/dts/pm8916.dtsi         | 178 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 335 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


-Sumit

> diff --git a/arch/arm/dts/msm8916-pm8916.dtsi b/arch/arm/dts/msm8916-pm8916.dtsi
> new file mode 100644
> index 000000000000..b1a7eafbee31
> --- /dev/null
> +++ b/arch/arm/dts/msm8916-pm8916.dtsi
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * msm8916-pm8916.dtsi describes common properties (e.g. regulator connections)
> + * that apply to most devices that make use of the MSM8916 SoC and PM8916 PMIC.
> + * Many regulators have a fixed purpose in the original reference design and
> + * were rarely re-used for different purposes. Devices that deviate from the
> + * typical reference design should not make use of this include and instead add
> + * the necessary properties in the board-specific device tree.
> + */
> +
> +#include "msm8916.dtsi"
> +#include "pm8916.dtsi"
> +
> +&camss {
> +       vdda-supply = <&pm8916_l2>;
> +};
> +
> +&mdss_dsi0 {
> +       vdda-supply = <&pm8916_l2>;
> +       vddio-supply = <&pm8916_l6>;
> +};
> +
> +&mdss_dsi0_phy {
> +       vddio-supply = <&pm8916_l6>;
> +};
> +
> +&mpss {
> +       pll-supply = <&pm8916_l7>;
> +};
> +
> +&pm8916_codec {
> +       vdd-cdc-io-supply = <&pm8916_l5>;
> +       vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
> +       vdd-micbias-supply = <&pm8916_l13>;
> +};
> +
> +&sdhc_1 {
> +       vmmc-supply = <&pm8916_l8>;
> +       vqmmc-supply = <&pm8916_l5>;
> +};
> +
> +&sdhc_2 {
> +       vmmc-supply = <&pm8916_l11>;
> +       vqmmc-supply = <&pm8916_l12>;
> +};
> +
> +&usb_hs_phy {
> +       v1p8-supply = <&pm8916_l7>;
> +       v3p3-supply = <&pm8916_l13>;
> +};
> +
> +&wcnss {
> +       vddpx-supply = <&pm8916_l7>;
> +};
> +
> +&wcnss_iris {
> +       vddxo-supply = <&pm8916_l7>;
> +       vddrfa-supply = <&pm8916_s3>;
> +       vddpa-supply = <&pm8916_l9>;
> +       vdddig-supply = <&pm8916_l5>;
> +};
> +
> +&rpm_requests {
> +       pm8916_rpm_regulators: regulators {
> +               compatible = "qcom,rpm-pm8916-regulators";
> +               vdd_l1_l2_l3-supply = <&pm8916_s3>;
> +               vdd_l4_l5_l6-supply = <&pm8916_s4>;
> +               vdd_l7-supply = <&pm8916_s4>;
> +
> +               /* pm8916_s1 is managed by rpmpd (MSM8916_VDDCX) */
> +
> +               pm8916_s3: s3 {
> +                       regulator-min-microvolt = <1250000>;
> +                       regulator-max-microvolt = <1350000>;
> +                       regulator-always-on; /* Needed for L2 */
> +               };
> +
> +               pm8916_s4: s4 {
> +                       regulator-min-microvolt = <1850000>;
> +                       regulator-max-microvolt = <2150000>;
> +                       regulator-always-on; /* Needed for L5/L7 */
> +               };
> +
> +               /*
> +                * Some of the regulators are unused or managed by another
> +                * processor (e.g. the modem). We should still define nodes for
> +                * them to ensure the vote from the application processor can be
> +                * dropped in case the regulators are already on during boot.
> +                *
> +                * The labels for these nodes are omitted on purpose because
> +                * boards should configure a proper voltage before using them.
> +                */
> +               l1 {};
> +
> +               pm8916_l2: l2 {
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1200000>;
> +                       regulator-always-on; /* Needed for LPDDR RAM */
> +               };
> +
> +               /* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
> +
> +               l4 {};
> +
> +               pm8916_l5: l5 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-always-on; /* Needed for most digital I/O */
> +               };
> +
> +               pm8916_l6: l6 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +               };
> +
> +               pm8916_l7: l7 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-always-on; /* Needed for CPU PLL */
> +               };
> +
> +               pm8916_l8: l8 {
> +                       regulator-min-microvolt = <2900000>;
> +                       regulator-max-microvolt = <2900000>;
> +               };
> +
> +               pm8916_l9: l9 {
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +               };
> +
> +               l10 {};
> +
> +               pm8916_l11: l11 {
> +                       regulator-min-microvolt = <2950000>;
> +                       regulator-max-microvolt = <2950000>;
> +                       regulator-allow-set-load;
> +                       regulator-system-load = <200000>;
> +               };
> +
> +               pm8916_l12: l12 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <2950000>;
> +               };
> +
> +               pm8916_l13: l13 {
> +                       regulator-min-microvolt = <3075000>;
> +                       regulator-max-microvolt = <3075000>;
> +               };
> +
> +               l14 {};
> +               l15 {};
> +               l16 {};
> +               l17 {};
> +               l18 {};
> +       };
> +};
> diff --git a/arch/arm/dts/pm8916.dtsi b/arch/arm/dts/pm8916.dtsi
> new file mode 100644
> index 000000000000..f4de86787743
> --- /dev/null
> +++ b/arch/arm/dts/pm8916.dtsi
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +
> +       pm8916_0: pmic@0 {
> +               compatible = "qcom,pm8916", "qcom,spmi-pmic";
> +               reg = <0x0 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pon@800 {
> +                       compatible = "qcom,pm8916-pon";
> +                       reg = <0x800>;
> +                       mode-bootloader = <0x2>;
> +                       mode-recovery = <0x1>;
> +
> +                       pwrkey {
> +                               compatible = "qcom,pm8941-pwrkey";
> +                               interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
> +                               debounce = <15625>;
> +                               bias-pull-up;
> +                               linux,code = <KEY_POWER>;
> +                       };
> +
> +                       pm8916_resin: resin {
> +                               compatible = "qcom,pm8941-resin";
> +                               interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +                               debounce = <15625>;
> +                               bias-pull-up;
> +                               status = "disabled";
> +                       };
> +
> +                       watchdog {
> +                               compatible = "qcom,pm8916-wdt";
> +                               interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
> +                               timeout-sec = <60>;
> +                       };
> +               };
> +
> +               pm8916_usbin: usb-detect@1300 {
> +                       compatible = "qcom,pm8941-misc";
> +                       reg = <0x1300>;
> +                       interrupts = <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>;
> +                       interrupt-names = "usb_vbus";
> +                       status = "disabled";
> +               };
> +
> +               pm8916_temp: temp-alarm@2400 {
> +                       compatible = "qcom,spmi-temp-alarm";
> +                       reg = <0x2400>;
> +                       interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
> +                       io-channels = <&pm8916_vadc VADC_DIE_TEMP>;
> +                       io-channel-names = "thermal";
> +                       #thermal-sensor-cells = <0>;
> +               };
> +
> +               pm8916_vadc: adc@3100 {
> +                       compatible = "qcom,spmi-vadc";
> +                       reg = <0x3100>;
> +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       #io-channel-cells = <1>;
> +
> +                       channel@0 {
> +                               reg = <VADC_USBIN>;
> +                               qcom,pre-scaling = <1 10>;
> +                       };
> +                       channel@7 {
> +                               reg = <VADC_VSYS>;
> +                               qcom,pre-scaling = <1 3>;
> +                       };
> +                       channel@8 {
> +                               reg = <VADC_DIE_TEMP>;
> +                       };
> +                       channel@9 {
> +                               reg = <VADC_REF_625MV>;
> +                       };
> +                       channel@a {
> +                               reg = <VADC_REF_1250MV>;
> +                       };
> +                       channel@e {
> +                               reg = <VADC_GND_REF>;
> +                       };
> +                       channel@f {
> +                               reg = <VADC_VDD_VADC>;
> +                       };
> +               };
> +
> +               rtc@6000 {
> +                       compatible = "qcom,pm8941-rtc";
> +                       reg = <0x6000>, <0x6100>;
> +                       reg-names = "rtc", "alarm";
> +                       interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +               };
> +
> +               pm8916_mpps: mpps@a000 {
> +                       compatible = "qcom,pm8916-mpp", "qcom,spmi-mpp";
> +                       reg = <0xa000>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&pm8916_mpps 0 0 4>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               pm8916_gpios: gpio@c000 {
> +                       compatible = "qcom,pm8916-gpio", "qcom,spmi-gpio";
> +                       reg = <0xc000>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pm8916_gpios 0 0 4>;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       pm8916_1: pmic@1 {
> +               compatible = "qcom,pm8916", "qcom,spmi-pmic";
> +               reg = <0x1 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pm8916_pwm: pwm {
> +                       compatible = "qcom,pm8916-pwm";
> +
> +                       #pwm-cells = <2>;
> +
> +                       status = "disabled";
> +               };
> +
> +               pm8916_vib: vibrator@c000 {
> +                       compatible = "qcom,pm8916-vib";
> +                       reg = <0xc000>;
> +                       status = "disabled";
> +               };
> +
> +               pm8916_codec: audio-codec@f000 {
> +                       compatible = "qcom,pm8916-wcd-analog-codec";
> +                       reg = <0xf000>;
> +                       interrupt-parent = <&spmi_bus>;
> +                       interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
> +                                    <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
> +                       interrupt-names = "cdc_spk_cnp_int",
> +                                         "cdc_spk_clip_int",
> +                                         "cdc_spk_ocp_int",
> +                                         "mbhc_ins_rem_det1",
> +                                         "mbhc_but_rel_det",
> +                                         "mbhc_but_press_det",
> +                                         "mbhc_ins_rem_det",
> +                                         "mbhc_switch_int",
> +                                         "cdc_ear_ocp_int",
> +                                         "cdc_hphr_ocp_int",
> +                                         "cdc_hphl_ocp_det",
> +                                         "cdc_ear_cnp_int",
> +                                         "cdc_hphr_cnp_int",
> +                                         "cdc_hphl_cnp_int";
> +                       #sound-dai-cells = <1>;
> +                       status = "disabled";
> +               };
> +       };
> +};
>
> --
> 2.43.1
>
