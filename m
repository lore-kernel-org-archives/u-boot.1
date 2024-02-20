Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1ACC5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2406587FE2;
	Tue, 20 Feb 2024 15:08:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eoCC7skV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F13187FCE; Tue, 20 Feb 2024 15:08:42 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EEEB87FD4
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e2e5824687so1817407a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438115; x=1709042915; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBPsQdgMXjHmp+Mtosm3SmhQxpRvYcWlMwb3Nb6WsQk=;
 b=eoCC7skV6SQYzTDUzhen3lSkQa18/ck/HhTayJUh6T/wzGcrIEkJCncJdYxi4Go+5m
 xCVcYkHrkq5Gc8qLvxJS4LR7N85ODVrAfNgJ+ch1EzFAKJG9+eKM1DE4K2GzzcvvxFOu
 tVx9KO/b4anrfTgK3UCtRe7sHczgywdRnwipD1IJfgUVFyZ5McSX01zqRiJU3JbHDiNd
 c0xc5HgoqTE4nzQNE7832mgy2KWp8T0j2GCWTRt8W8nbefKTqkFk88BZejibgFFWj3OS
 MJ4WssNfJf1P0BO14rSxRVSWMzCS0M6OD714kxrTo3HW5vPkxwrEBBq9+fhilPdtrB9N
 tR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438115; x=1709042915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBPsQdgMXjHmp+Mtosm3SmhQxpRvYcWlMwb3Nb6WsQk=;
 b=um5O/hYSE/FSRv2BHVgZWrf42GZSIBEhYYATFlqMny/hFQr/hGiWMIs/DybIgUec4g
 Bgq0UeoOv9rIPYiRdhAvuioJP1sgE0XO29PSkTcv71oTGzWd7uI/qv7ZRqUkZz63K/Pl
 lluyNrSqFrkI+wfblPQSAgqBGYWLUL52+u3MKZisAg2UPxmjRaCbGOW4gt3MSsz/cEEp
 OQJhp07lmVPlBx/6cFaoe1TtqetqtNRtgwOvSsGAT0FLTbGFLaEgAntZABBYsDHd9v73
 qABbdUusybSfVFZU/rn+iolnqTSWB8PjEJr2bVO2+MaHGp4u4KFm0f1r54HcFrbzqqwP
 I/DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUz9FwptF2+DTvALoI17EeqIRc1xVkL+gcIMKScoClkLSizOq8tp8g/8kVtzyYA1XNaCxxZkynvqQQeaQRQuX3p3SkUA==
X-Gm-Message-State: AOJu0YxwE8BhN9qXOdn+2I3VvWU29adbPDcrNrNDRlF4vWdHphI6+BgQ
 gJ35bIOzq39l2dTlac5K3pl+wnu1z8h/9bZDNSea9YVrLM5/6GU4+xRRpVI+nwHHjBEQYLWe278
 iZM+ewdOG46atM07cM8Wnl1u0pAD/pO5b0qK63w==
X-Google-Smtp-Source: AGHT+IEbj5vWkXBeeHxNwzflajNwTxXH0s6d3qtDOum+b3QcnJuwepAOKVdcij2bbBOq67D4aPenyqZUo/yqkohbDys=
X-Received: by 2002:a05:6808:30a6:b0:3c1:5ab6:5e5d with SMTP id
 bl38-20020a05680830a600b003c15ab65e5dmr7039396oib.24.1708438115542; Tue, 20
 Feb 2024 06:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-34-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-34-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:38:24 +0530
Message-ID: <CAFA6WYNDoKDZ_NCA=4TkgnWU_aNd8CRfJsOXA4H72LBnM0M1tQ@mail.gmail.com>
Subject: Re: [PATCH v4 34/39] dts: msm8996: import PMIC dtsi files
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

On Fri, 16 Feb 2024 at 02:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Import PM8994 and PMI8994 DTSI files in preparation for switching
> MSM8996 boards to upstream DTS.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/pm8994.dtsi  | 152 ++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/dts/pmi8994.dtsi |  65 ++++++++++++++++++++
>  2 files changed, 217 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


-Sumit

> diff --git a/arch/arm/dts/pm8994.dtsi b/arch/arm/dts/pm8994.dtsi
> new file mode 100644
> index 000000000000..d44a95caf04a
> --- /dev/null
> +++ b/arch/arm/dts/pm8994.dtsi
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/iio/qcom,spmi-vadc.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +/ {
> +       thermal-zones {
> +               pm8994-thermal {
> +                       polling-delay-passive = <250>;
> +                       polling-delay = <1000>;
> +
> +                       thermal-sensors = <&pm8994_temp>;
> +
> +                       trips {
> +                               pm8994_alert0: pm8994-alert0 {
> +                                       temperature = <95000>;
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                               pm8994_crit: pm8994-crit {
> +                                       temperature = <125000>;
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                       };
> +               };
> +       };
> +};
> +
> +&spmi_bus {
> +
> +       pmic@0 {
> +               compatible = "qcom,pm8994", "qcom,spmi-pmic";
> +               reg = <0x0 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               rtc@6000 {
> +                       compatible = "qcom,pm8941-rtc";
> +                       reg = <0x6000>, <0x6100>;
> +                       reg-names = "rtc", "alarm";
> +                       interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
> +               };
> +
> +               pm8994_pon: pon@800 {
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
> +                       pm8994_resin: resin {
> +                               compatible = "qcom,pm8941-resin";
> +                               interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +                               debounce = <15625>;
> +                               bias-pull-up;
> +                               status = "disabled";
> +                       };
> +               };
> +
> +               pm8994_temp: temp-alarm@2400 {
> +                       compatible = "qcom,spmi-temp-alarm";
> +                       reg = <0x2400>;
> +                       interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +                       io-channels = <&pm8994_vadc VADC_DIE_TEMP>;
> +                       io-channel-names = "thermal";
> +                       #thermal-sensor-cells = <0>;
> +               };
> +
> +               pm8994_vadc: adc@3100 {
> +                       compatible = "qcom,spmi-vadc";
> +                       reg = <0x3100>;
> +                       interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       #io-channel-cells = <1>;
> +
> +                       channel@7 {
> +                               reg = <VADC_VSYS>;
> +                               qcom,pre-scaling = <1 3>;
> +                               label = "vph_pwr";
> +                       };
> +                       channel@8 {
> +                               reg = <VADC_DIE_TEMP>;
> +                               label = "die_temp";
> +                       };
> +                       channel@9 {
> +                               reg = <VADC_REF_625MV>;
> +                               label = "ref_625mv";
> +                       };
> +                       channel@a {
> +                               reg = <VADC_REF_1250MV>;
> +                               label = "ref_1250mv";
> +                       };
> +                       channel@e {
> +                               reg = <VADC_GND_REF>;
> +                       };
> +                       channel@f {
> +                               reg = <VADC_VDD_VADC>;
> +                       };
> +               };
> +
> +               pm8994_gpios: gpio@c000 {
> +                       compatible = "qcom,pm8994-gpio", "qcom,spmi-gpio";
> +                       reg = <0xc000>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pm8994_gpios 0 0 22>;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               pm8994_mpps: mpps@a000 {
> +                       compatible = "qcom,pm8994-mpp", "qcom,spmi-mpp";
> +                       reg = <0xa000>;
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +                       gpio-ranges = <&pm8994_mpps 0 0 8>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       pmic@1 {
> +               compatible = "qcom,pm8994", "qcom,spmi-pmic";
> +               reg = <0x1 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pm8994_lpg: pwm {
> +                       compatible = "qcom,pm8994-lpg";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       #pwm-cells = <2>;
> +
> +                       status = "disabled";
> +               };
> +
> +               pm8994_spmi_regulators: regulators {
> +                       compatible = "qcom,pm8994-regulators";
> +               };
> +       };
> +};
> diff --git a/arch/arm/dts/pmi8994.dtsi b/arch/arm/dts/pmi8994.dtsi
> new file mode 100644
> index 000000000000..36d6a1fb553a
> --- /dev/null
> +++ b/arch/arm/dts/pmi8994.dtsi
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +
> +       pmic@2 {
> +               compatible = "qcom,pmi8994", "qcom,spmi-pmic";
> +               reg = <0x2 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pmi8994_gpios: gpio@c000 {
> +                       compatible = "qcom,pmi8994-gpio", "qcom,spmi-gpio";
> +                       reg = <0xc000>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pmi8994_gpios 0 0 10>;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +
> +               pmi8994_mpps: mpps@a000 {
> +                       compatible = "qcom,pmi8994-mpp", "qcom,spmi-mpp";
> +                       reg = <0xa000>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pmi8994_mpps 0 0 4>;
> +                       #gpio-cells = <2>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };
> +       };
> +
> +       pmic@3 {
> +               compatible = "qcom,pmi8994", "qcom,spmi-pmic";
> +               reg = <0x3 SPMI_USID>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pmi8994_lpg: pwm {
> +                       compatible = "qcom,pmi8994-lpg";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       #pwm-cells = <2>;
> +
> +                       status = "disabled";
> +               };
> +
> +               pmi8994_spmi_regulators: regulators {
> +                       compatible = "qcom,pmi8994-regulators";
> +               };
> +
> +               pmi8994_wled: wled@d800 {
> +                       compatible = "qcom,pmi8994-wled";
> +                       reg = <0xd800>, <0xd900>;
> +                       interrupts = <0x3 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
> +                                    <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
> +                       interrupt-names = "ovp", "short";
> +                       qcom,cabc;
> +                       qcom,external-pfet;
> +                       status = "disabled";
> +               };
> +       };
> +};
>
> --
> 2.43.1
>
