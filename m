Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7083C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CC5807D7;
	Sun,  9 Feb 2025 15:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hklmxecW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F5D480821; Sun,  9 Feb 2025 15:31:35 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EC080141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f83a8afcbbso5526209a91.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111491; x=1739716291; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEiBYsFynjgUha/zlmbKXZsIpHrw6kpStr5j0MPJL9Q=;
 b=hklmxecWSy7ujJ3vqnqFeACYu3CeQxht5yzsC727vYiRbFktQJCjXV4lNRXF9vJONY
 0+Agy7xeh/HvRTXfrdFe+x2voxz3N8E47Dqo0jxVe/ki0Av8EEzEed5EzD97i92QO5iU
 Rqe2yT6HisPQpKvHgzE32nHX9hSwibVkf/t9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111491; x=1739716291;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEiBYsFynjgUha/zlmbKXZsIpHrw6kpStr5j0MPJL9Q=;
 b=a1uOFIsvyL41FhYPvrKMCR1H0ZT8YBNZBVpZzwK8Q1csoLTdXTi3BxPTKbxmLXtW4N
 3xFWScZZTnA0HK1H7txZtPrQ01NsyoNCu5qz0gpRbFtUlAHs0jD6FIOyOSTzJ8rq0p1a
 cL0HEstd69LGI0opPCEqA2N6Yn1iIRtRzrc7aLEVL8xL+2YiFAZsj5eWkhcCJn3T/YcS
 uG/jA1KaFiurPTVchXpB1YtZH/ySQCLg1Dv5oxsqcEVLPTWQ076aqvZafmZxlHmQKIbh
 QdC7WOB2H00yXUiSCk4mTV1g6WdpQ5xQ8CIyt2LZbF+2zRa4G1M4u5RdmWTVjCsV+TFK
 bCGw==
X-Gm-Message-State: AOJu0Yz1QsT3pzVKbuKPBRC1VQH+RY4lBMMEI7JcHmnAMFgj1iva1TP6
 LktulT67mcUWHeK1v12X/Px+V9rUqqtRjllUIXwcTer8L0UZPFwwIgQpGb830n7t4fxbICPqf98
 XPwHT5dmLYMnGBcFx3HZzkINtWz8dSQVDQWFJibXFiITCwFo=
X-Gm-Gg: ASbGncsMC5p6jp2Q0WuEEbxKCTo8TdfALfSN5VNqpmbf212EgONOEqnEUdib5WNd7ZV
 dj1N/yu21Z6JIxDLtJEGgVpjzjaiQDiMJunoSapkZZRJMWDDCnhVTIXDiHDnB39BM1PpJgOodGA
 ==
X-Google-Smtp-Source: AGHT+IEBTp+Z//FAC4OqIj7On6Gn7QNjlqtHV6lHKqD90StXlXhZnALrIJ6Ar/nQsptG3D4sX03J0fWFqH0g8Sd4ZkY=
X-Received: by 2002:a17:90b:1c0b:b0:2fa:42f3:e3e4 with SMTP id
 98e67ed59e1d1-2fa42f3e4c1mr9345975a91.3.1739111488330; Sun, 09 Feb 2025
 06:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-26-sjg@chromium.org>
 <b52ff2d2-3ab1-4c1f-9e1c-d8dc2a40025f@kwiboo.se>
In-Reply-To: <b52ff2d2-3ab1-4c1f-9e1c-d8dc2a40025f@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:31:14 -0700
X-Gm-Features: AWEUYZmhizUBvSk7mIS_idY26keoeZBv6Az_R4SWLy96A6DvVnqtUFp_w6Y0aRo
Message-ID: <CAFLszThqaBwLJqpoagaDyAbkfsFDALmiTudxdwvBOOLpVRVC=A@mail.gmail.com>
Subject: Re: [PATCH 25/29] rockchip: Add a generic rk3399 board
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Christopher Obbard <chris.obbard@collabora.com>, 
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, huang lin <hl@rock-chips.com>
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

Hi Jonas,

On Sat, 8 Feb 2025 at 19:11, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:55, Simon Glass wrote:
> > This build-target is used to build an image which can run on multiple
> > rk3399 boards, using VBE to boot.
>
> Since this target is intended to be used with VBE on LPDDR4 boards, can
> you use a different target name, maybe rk3399-vbe-lpddr4 or similar?
>
> >
> > To use it, the TPL binary for a particular board must be placed into the
> > first part of the image. The rest of the image (i.e. VPL, SPL and
> > U-Boot) are largely generic and can work on any supported board.
>
> I like the concept of this and I also think this can be supported using
> current "traditional" TPL+SPL and FIT separation with fit,compatible and
> FIT_BEST_MATCH, I will run some tests using that :-)

Yes, it should work.

>
> Also think with some cleanup work we should even be able to build a
> generic Rockchip AArch64 U-Boot proper FIT, for now there is parts that
> is too SoC dependent.

Yes, I hope that all SoCs eventually go this way.

>
> >
> > With VBE, memory-init happens in SPL so that this code is updatable in
> > the field. Due to size constraints, the type of memory on the board is
> > defined at build-time. So it is not possible to use the same VBE image
> > on boards with different SDRAM (DDR3 vs LPDDR4 for example). This may
> > become possible with newer boards with more SRAM.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/dts/rk3399-generic-u-boot.dtsi |  32 ++++++
> >  arch/arm/dts/rk3399-generic.dts         |  30 ++++++
> >  board/rockchip/evb_rk3399/MAINTAINERS   |   5 +
> >  configs/rk3399-generic_defconfig        | 133 ++++++++++++++++++++++++
> >  4 files changed, 200 insertions(+)
> >  create mode 100644 arch/arm/dts/rk3399-generic-u-boot.dtsi
> >  create mode 100644 arch/arm/dts/rk3399-generic.dts
> >  create mode 100644 configs/rk3399-generic_defconfig
> >
> > diff --git a/arch/arm/dts/rk3399-generic-u-boot.dtsi b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..732727d9b03
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3399-generic-u-boot.dtsi
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +#include "rk3399-u-boot.dtsi"
> > +#include "rk3399-sdram-lpddr4-100.dtsi"
>
> This is not generic and limits this to lpddr4 boards.

In fact this isn't what I intended, so I'm going to change this file.

>
> > +/ {
> > +     chosen {
> > +             u-boot,spl-boot-order = "same-as-spl", &spi_flash, &sdmmc, &sdhci;
> > +     };
> > +};
> > +
> > +&sdhci {
> > +     cap-mmc-highspeed;
> > +     mmc-ddr-1_8v;
> > +};
> > +
> > +&spi1 {
> > +     spi_flash: flash@0 {
> > +             bootph-all;
> > +     };
> > +};
> > +
> > +&vdd_center {
> > +     regulator-min-microvolt = <950000>;
> > +     regulator-max-microvolt = <950000>;
> > +};
> > +
> > +&vdd_log {
> > +     regulator-init-microvolt = <950000>;
> > +};
> > diff --git a/arch/arm/dts/rk3399-generic.dts b/arch/arm/dts/rk3399-generic.dts
> > new file mode 100644
> > index 00000000000..f13bb7f6b4b
> > --- /dev/null
> > +++ b/arch/arm/dts/rk3399-generic.dts
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> > + * Copyright (c) 2018 Akash Gajjar <Akash_Gajjar@mentor.com>
> > + * Copyright (c) 2019 Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3399-rockpro64.dtsi"
>
> This is far from generic, please see my minimal generic dts at [1]. You
> can possible build something using that and a vbe-lpddr4-rk3399
> defconfig or similar?

Just a note on this...I like putting the SoC first (rk3399-generic)
since it matches the devicetree naming. Also, if (as I hope) we end up
with generic boards for all modern SoCs, we'll avoid having a
directory full of 'generic-xxx' files. The differentiating piece is
the SoC name, not that it is generic, so I think it should be first.

Regards,
Simon


>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20250204072710.468610-3-jonas@kwiboo.se/
>
> Regards,
> Jonas
>
> > +
> > +/ {
> > +     model = "RK3399 Generic";
> > +     compatible = "pine64,rockpro64-v2.1", "pine64,rockpro64", "rockchip,rk3399";
> > +};
> > +
> > +&i2c1 {
> > +     es8316: codec@11 {
> > +             compatible = "everest,es8316";
> > +             reg = <0x11>;
> > +             clocks = <&cru SCLK_I2S_8CH_OUT>;
> > +             clock-names = "mclk";
> > +             #sound-dai-cells = <0>;
> > +
> > +             port {
> > +                     es8316_p0_0: endpoint {
> > +                             remote-endpoint = <&i2s1_p0_0>;
> > +                     };
> > +             };
> > +     };
> > +};
>
> [snip]
