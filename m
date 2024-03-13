Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01191C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 06:39:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF49879E8;
	Wed, 13 Mar 2024 07:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nkud7GH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB38787653; Wed, 13 Mar 2024 07:39:14 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CFFA8785A
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 07:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7dc3a92c4b8so87001241.0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 23:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710311950; x=1710916750; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Gs17OYNVhly6lVf4p2Oc90hhOD8aAPv4XjRRb0w0PA8=;
 b=nkud7GH7C1covKc+U15EfDANvKA2R+V4IHCwnE+59emMTRoU/Hbng/wz52h4y/l/nd
 /FggkfgkWjqBv82MuV/Q4TM5oTzCCc64H13Zwv6j83dCCV53KzmZrrvkolqT/AEBGkhh
 7CgNrK3pkW3en5bTgSW24Kl/ZP1IpW+uVd2bTTdYsvdyYbLWlVP67wiczvZGLqYLKewS
 2Bb9dmwzF+pLp8CArZEy9SoXNjT3djqUF8AzxNzgFxy2LjCNuV3eJq132K0Zd2UUONkJ
 y97/KHbH2uCct5WDojf/StVwj54oEfHpLDvNCF0/oJM8GaK8pp92TER9+gopQDgPGVze
 PqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710311950; x=1710916750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gs17OYNVhly6lVf4p2Oc90hhOD8aAPv4XjRRb0w0PA8=;
 b=VvcinozRmnP2ZACKUD5AiO05Je2HXR5yce9BbxQ855JHwjvIdloj5ITHkW9Z84eSrY
 6m9DYPl/YrCqMrV5VgBI8homKH1ulby707JbwxuHIfT+vZPpY8sXz2jksYt9kdHoyxUV
 cJ9Ftfph8mSxMOJrzn4XC/mCh09e5pQRIGG1MNaFQ22b2+jO0X8bMiI6mW7TqaeNdY/b
 EjSCOHEExXSr9t3z/48N4iB00NvKBf5RYy4PuMgIgDFTFeDu+fLe6W9mxZ+l8pjBdl8E
 ShGQz5Os4ZAEWFme7VuRBf0yknV4ufeuBFJa4wfNnsDKlJNOp42QWYjPa/6EE2/Gr2ye
 rIjw==
X-Gm-Message-State: AOJu0YwwbInsdPwQkyGxw/flTsMaloaDww6AW/OHYZ0o63xdXJJAtIJF
 d5f2SIWCsN5xyY9GzIZqbMj17AQiXWVAi+1B+DI5yfByHsi7w8vA50By4rg2aePHnV6+GPimVp1
 EYKFZdsvPIhVMqgSsjEdLMz+etwidybNmlrB6XQ==
X-Google-Smtp-Source: AGHT+IE4mizlhwKdz/RvTy8a8bMxZXfhk+1mr2/O0PfHroO5e58J47u1sySUeiJoHBJyT17rsOteJQyqV/1bPpnrUx0=
X-Received: by 2002:a05:6102:274d:b0:473:3752:f1e3 with SMTP id
 p13-20020a056102274d00b004733752f1e3mr7329668vsu.31.1710311950428; Tue, 12
 Mar 2024 23:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-6-sumit.garg@linaro.org>
 <Ze8XM9cvZt7fSYg5@gerhold.net>
In-Reply-To: <Ze8XM9cvZt7fSYg5@gerhold.net>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 13 Mar 2024 12:08:58 +0530
Message-ID: <CAFA6WYOP2Y2byfTWVKv5j6Yu61q64hG_JHBRDspabnybh5KMSA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] board: add support for Schneider HMIBSC board
To: Stephan Gerhold <stephan@gerhold.net>
Cc: u-boot@lists.denx.de, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, sjg@chromium.org, 
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
 jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org
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

Hi Stephan,

On Mon, 11 Mar 2024 at 20:07, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Mon, Mar 11, 2024 at 04:40:26PM +0530, Sumit Garg wrote:
> > Support for Schneider Electric HMIBSC. Features:
> > - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> > - 2GiB RAM
> > - 64GiB eMMC, SD slot
> > - WiFi and Bluetooth
> > - 2x Host, 1x Device USB port
> > - HDMI
> > - Discrete TPM2 chip over SPI
> >
> > Features enabled in U-Boot:
> > - RAUC updates
> > - Environment protection
> > - USB based ethernet adaptors
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I'm entirely sure which requirements or conventions we are following for
> adding device trees directly to U-Boot instead of Linux. My understanding
> is that the goal is to get U-Boot DTs as close as possible to the
> upstream Linux DTs, so I effectively looked at this as if it were
> submitted to linux-arm-msm. I think most of my comments should be
> trivial to fix anyway without much effort. :-)

Thanks for your review and yeah I would be happy to incorporate your comments.

>
> With the comments fixed it would be likely also easy to get it in
> upstream in Linux, so I wonder if it's worth first adding it here in
> U-Boot (I know you discussed this on v1 already a bit).

I will post a DTS patch for Linux kernel too as soon as I get a go
ahead from the vendor. But for the time being it shouldn't be a
barrier to U-Boot support.

>
> > ---
> >  arch/arm/dts/apq8016-hmibsc.dts    | 496 +++++++++++++++++++++++++++++
> >  board/schneider/hmibsc/MAINTAINERS |   6 +
> >  configs/hmibsc_defconfig           |  87 +++++
> >  doc/board/index.rst                |   1 +
> >  doc/board/schneider/hmibsc.rst     |  45 +++
> >  doc/board/schneider/index.rst      |   9 +
> >  include/configs/hmibsc.h           |  57 ++++
> >  7 files changed, 701 insertions(+)
> >  create mode 100644 arch/arm/dts/apq8016-hmibsc.dts
> >  create mode 100644 board/schneider/hmibsc/MAINTAINERS
> >  create mode 100644 configs/hmibsc_defconfig
> >  create mode 100644 doc/board/schneider/hmibsc.rst
> >  create mode 100644 doc/board/schneider/index.rst
> >  create mode 100644 include/configs/hmibsc.h
> >
> > diff --git a/arch/arm/dts/apq8016-hmibsc.dts b/arch/arm/dts/apq8016-hmibsc.dts
> > new file mode 100644
> > index 00000000000..490ab5fd2fa
> > --- /dev/null
> > +++ b/arch/arm/dts/apq8016-hmibsc.dts
> > @@ -0,0 +1,496 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2015, The Linux Foundation. All rights reserved.
> > + * Copyright (c) 2024, Linaro Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "msm8916-pm8916.dtsi"
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
> > +#include <dt-bindings/sound/apq8016-lpass.h>
> > +
> > +/ {
> > +     model = "Schneider Electric HMIBSC Board";
> > +     compatible = "qcom,apq8016-hmibsc", "qcom,apq8016";
>
> A Schneider Electric specific compatible would be likely more accurate,
> since I assume this board wasn't designed by Qualcomm?

Okay, I will make it: "schneider,apq8016-hmibsc" instead.

>
> I would personally also prefer to use the "apq8016-<vendor>-<board>.dts"
> naming convention that we typically use for smartphones/tablets
> upstream, although you can also keep it as-is since e.g. apq8039-t2.dts
> is also named without vendor.

That sounds better. I will rename DTS file as "apq8016-schneider-hmibsc.dts"

>
> > +
> > +     aliases {
> > +             serial0 = &blsp_uart1;
> > +             serial1 = &blsp_uart2;
> > +             usid0 = &pm8916_0;
> > +             i2c1 = &blsp_i2c6;
> > +             i2c3 = &blsp_i2c4;
> > +             i2c4 = &blsp_i2c3;
> > +             spi0 = &blsp_spi5;
>
> You might want to add mmcX aliases here to ensure consistent naming of
> eMMC and SD card (this used to be in msm8916.dtsi but not anymore).
>

Ack.

> > [...]
> > +&blsp_i2c6 {
> > +     status = "okay";
> > +     label = "I2C1";
> > +
> > +     rtc1: s35390a@30 {
>
> rtc@
>

Ack.

> > +             compatible = "sii,s35390a";
> > +             reg = <0x30>;
> > +     };
> > +
> > +     eeprom1: 24c256@50 {
>
> eeprom@
>

Ack.

> > +             compatible = "atmel,24c256";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > +&blsp_i2c3 {
>
> i2c3 should come before i2c6 (sorted alphabetically)
>

Ack.

> > +     status = "okay";
> > +     label = "I2C4";
> > +
> > +     eeprom: 24c32@50 {
>
> eeprom@

Ack.

>
> > +             compatible = "onsemi,24c32";
> > +             reg = <0x50>;
> > +     };
> > +};
> > +
> > [...]
> > +
> > +&pm8916_0 {
> > +     pon@800 {
> > +             pwrkey {
> > +                     status = "okay";
> > +                     interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
>
> This line would really benefit from a comment that explains what exactly
> it does and why this is done. :)
>
> It looks like you are redefining the pwrkey with the resin interrupt.
> I guess your goal is to have KEY_POWER assigned to the resin pin?
> In that case, I think it would be cleaner to describe this using:
>
> &pm8916_resin {
>         status = "okay";
>         linux,code = <KEY_POWER>;
> };

This works much better, I will use it instead.

>
> and leave the pwrkey node alone (or perhaps disable it if it causes
> trouble).
>
> Aside from the confusion, I think overriding only the interrupt of the
> pwrkey will also misbehave in unexpected ways since e.g. the Linux
> pm8941-pwrkey driver will still write the configured debounce time and
> pull up to the pwrkey registers, and not to the resin ones.
>
> > +             };
> > +     };
> > +};
> > +
> > [...]
> > +
> > +&tlmm {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&gpio_rs232_high &gpio_rs232_low>;
> > +
> > +     sdc2_cd_default: sdc2-cd-default-state {
> > +             pins = "gpio38";
> > +             function = "gpio";
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
> > +
> > +     usb_id_default: usb-id-default-state {
> > +             pins = "gpio110";
> > +             function = "gpio";
> > +
> > +             drive-strength = <8>;
> > +             bias-pull-up;
> > +     };
> > +
> > +     adv7533_int_active: adv533-int-active-state {
> > +             pins = "gpio31";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_int_suspend: adv7533-int-suspend-state {
> > +             pins = "gpio31";
> > +             function = "gpio";
> > +
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_switch_active: adv7533-switch-active-state {
> > +             pins = "gpio32";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +     };
> > +
> > +     adv7533_switch_suspend: adv7533-switch-suspend-state {
> > +             pins = "gpio32";
> > +             function = "gpio";
> > +
> > +             drive-strength = <2>;
> > +             bias-disable;
> > +     };
> > +
> > +     msm_key_volp_n_default: msm-key-volp-n-default-state {
> > +             pins = "gpio107";
> > +             function = "gpio";
> > +
> > +             drive-strength = <8>;
> > +             bias-pull-up;
> > +     };
> > +
> > +     gpio_rs232_high: gpio_rs232_high {
>
> Pretty sure DT schema checks would complain about this node name (need
> -state suffix, no underscores).

We have the dtbs_check in U-Boot too. I will use that before posting
the next version.

>
> > +             bootph-all;
> > +             pins = "gpio99";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +             output-high;
> > +     };
> > +
> > +     gpio_rs232_low: gpio_rs232_low {
>
> Same here.
>
> Also, since I'm looking at this a bit more closely now, are there maybe
> more clear label/node names you could use here, or a comment you could
> add what exactly these pins do? I guess this enables something about
> RS232 but it's not clear what exactly.

Actually these GPIOs are a mux to select among different UART modes
(RS232/422/485). This configuration allows you to select RS232 mode.
How about following label/node names?

uart1_mux0_rs232_high: uart1-mux0-rs232-state

uart1_mux1_rs232_low: uart1-mux1-rs232-state

>
> > +             bootph-all;
> > +             pins = "gpio100";
> > +             function = "gpio";
> > +
> > +             drive-strength = <16>;
> > +             bias-disable;
> > +             output-low;
> > +     };
> > +};
> > +
> > [...]
> > diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
> > new file mode 100644
> > index 00000000000..02b9615114b
> > --- /dev/null
> > +++ b/configs/hmibsc_defconfig
> > @@ -0,0 +1,87 @@
> > +CONFIG_ARM=y
> > +CONFIG_SYS_BOARD="hmibsc"
> > +CONFIG_COUNTER_FREQUENCY=19000000
>
> I see you just copied this from the existing defconfigs but
> CONFIG_COUNTER_FREQUENCY should be unneeded, since TZ is the one
> responsible (and only one capable) of configuring this. And it also
> looks wrong to me, because the timer frequency on these Qualcomm boards
> is 19.2 MHz and not 19.0 MHz. :'D
>
> I guess I'll prepare a patch to fix it for the existing boards.

Okay I will drop that config.

-Sumit

>
> Thanks,
> Stephan
