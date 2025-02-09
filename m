Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCCCC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562F88083C;
	Sun,  9 Feb 2025 15:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBIFatDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F3D8083C; Sun,  9 Feb 2025 15:27:21 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BBB80821
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa0f222530so6489352a91.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111237; x=1739716037; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c/Mk4YCO4QTTFqee3zxn50eNI/U3ocpikLSv55J6h8Q=;
 b=QBIFatDGVWTjkNxHp4yGHPFCzFdIz3oibR+W6aUQGWf3kdajXg9+XSREl4Tz16+8mx
 7mfF04fE8DEjThF30LHxoeD88HGLQCUBflvSPvKV9dbc6m39NBFGYsET4ZtcF2X/SLN9
 ajnnt44T1y0Jb/e/QEes8ogYDBblwnRKG6OIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111237; x=1739716037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/Mk4YCO4QTTFqee3zxn50eNI/U3ocpikLSv55J6h8Q=;
 b=GXz4eyTfqt4z2+8uLvzHI8qXRS0pkcHSAjmmwubKKvxLgsKpOV66SmPhwGG62V8uGq
 GIlUZDDQGJnfzlh9uxuTbsmcwFEbzy3oWfA/ZOV1J5RHB4jekfs9cno+bo1/Dqeqc9gJ
 9T2tH5gpgZCz1Rtjj6FxaohYF0C+7gxT2vtIkz1BxRNkTaxtc14L2xA+WcEk5li/jccb
 +itMVXA8OOfXxcWLanyJmIwwVOtpOLyHekFHWfWd69u7sYvTNS6eDZ0RFVcA1FSfBIVE
 umrG3/DGoowla25PEwrDG8fUqWGlliceBsHi7SP3qTiG+EEwPvSrqXJfz+S0LSceruxT
 ayJQ==
X-Gm-Message-State: AOJu0YxwbL6jiwu6zprvG7GEiICPnMHakvckpI8e3q7gToxsptDAOBN/
 2rkIwQ/atOjiBApgcVs/qQ07B+/RTW0q3gZBCdRrhdxjpMz0m4lkPqegdPUVnd83KA5MAZ8HRm+
 fr0T0R0gR0biidtx9IgjbxlsI4io1PMkm/rmH
X-Gm-Gg: ASbGncvFV7U4WCOlIh1s+vTWWXIwaJMByO2SuQAYXEEnb/TfJpxWXG1q5cLtWyYV9dY
 0hJEawNqMRFI68DLjTeFpKCqF20KEy5tjWQDlhBsGugfT3VL+sFYkAQBjWLqtz41MhIy3rjLR2A
 ==
X-Google-Smtp-Source: AGHT+IE6kZSQubIcBzGQPJHDTkKkVKbcP9IP3ri7+6ghKgWj37IH2GXN4RrsFyoKu7INfsLL1ByoPCS4gGsfb2UeMp4=
X-Received: by 2002:a17:90b:3f4d:b0:2f2:8bdd:cd8b with SMTP id
 98e67ed59e1d1-2fa243eef5cmr15264622a91.29.1739111236772; Sun, 09 Feb 2025
 06:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-22-sjg@chromium.org>
 <440fa821-6eb7-4b5f-a513-97c96145abdd@kwiboo.se>
In-Reply-To: <440fa821-6eb7-4b5f-a513-97c96145abdd@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:27:01 -0700
X-Gm-Features: AWEUYZkLzL2mrk6-evfiQxa3Ti4lMkT9UqkWCpsv_ncUIzKuTJCQQFkFY5kDelE
Message-ID: <CAFLszTi0p-U6ttMbqGPfFhs1PgZag3PMW0rUQOahymS=DpGzPA@mail.gmail.com>
Subject: Re: [PATCH 21/29] rockchip: Provide a VPL phase on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Chen-Yu Tsai <wens@csie.org>, 
 Christopher Obbard <chris.obbard@collabora.com>,
 Dragan Simic <dsimic@manjaro.org>, 
 Greg Malysa <greg.malysa@timesys.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
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

On Wed, 5 Feb 2025 at 09:06, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:55, Simon Glass wrote:
> > Add support for this new phase, which runs after TPL. It determines the
> > state of the machine, then selects which SPL image to use. SDRAM init is
> > then done in SPL, so that it is updatable.
>
> I am still unsure how this makes it more updatable, what happen when
> DRAM init fails and board freezes? Are we relying on e.g. a watchdog to
> properly reset a frozen board and try next image?

Yes, that's right. Also, when you do an upgrade you are not changing
the only copy, thus avoiding bricking devices with a bad or partial
update.

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  arch/arm/include/asm/spl.h               |   1 +
> >  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
> >  arch/arm/mach-rockchip/Makefile          |   6 +-
> >  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
> >  arch/arm/mach-rockchip/spl-boot-order.c  |   3 +-
> >  arch/arm/mach-rockchip/spl.c             |   3 +
> >  arch/arm/mach-rockchip/tpl.c             |   2 +-
> >  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++++
> >  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
> >  common/spl/Kconfig                       |   1 +
> >  10 files changed, 203 insertions(+), 7 deletions(-)
> >  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> >  create mode 100644 arch/arm/mach-rockchip/vpl.c
> >
>
> [snip]
>
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 269c219a6f8..7e6e9411e79 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
>
> [snip]
>
> > @@ -455,7 +459,7 @@ config SPL_ROCKCHIP_BACK_TO_BROM
> >
> >  config TPL_ROCKCHIP_BACK_TO_BROM
> >       bool "TPL returns to bootrom"
> > -     default y
> > +     default y if !VPL
> >       select ROCKCHIP_BROM_HELPER if !ROCKCHIP_RK3066
> >       select TPL_BOOTROM_SUPPORT
> >       depends on TPL
> > @@ -496,6 +500,16 @@ config ROCKCHIP_EXTERNAL_TPL
> >         Enable this option and build with ROCKCHIP_TPL=/path/to/ddr.bin to
> >         include the external TPL in the image built by binman.
> >
> > +config VPL_ROCKCHIP_COMMON_BOARD
> > +     bool "Rockchip VPL common board file"
> > +     depends on VPL
> > +     default y
> > +     help
> > +       Rockchip SoCs have similar boot process, prefer to use TPL to start
> > +       VPL, then ATF for DRAM init and back to bootrom, and SPL as Trust
> > +       ATF/U-Boot loader. VPL common board is a basic VPL board init which
> > +       can be shared for most SoCs to avoid copy-paste for different SoCs.
>
> This help text is not correct, with VPL=y back to bootrom is not used
> and TF-A is never used for DRAM init, only TPL/SPL or Rockchip TPL.

OK I copied it from above. I'll rewrite it.

>
> > +
> >  config ROCKCHIP_BOOT_MODE_REG
> >       hex "Rockchip boot mode flag register address"
> >       help
>
> [snip]
>
> > diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
> > index 3dce9b30898..d580d4fc84c 100644
> > --- a/arch/arm/mach-rockchip/spl-boot-order.c
> > +++ b/arch/arm/mach-rockchip/spl-boot-order.c
> > @@ -99,7 +99,8 @@ __weak const char *board_spl_was_booted_from(void)
> >  void board_boot_order(u32 *spl_boot_list)
> >  {
> >       /* In case of no fdt (or only plat), use spl_boot_device() */
> > -     if (!CONFIG_IS_ENABLED(OF_CONTROL) || CONFIG_IS_ENABLED(OF_PLATDATA)) {
> > +     if (IS_ENABLED(CONFIG_VPL) || !CONFIG_IS_ENABLED(OF_CONTROL) ||
> > +         CONFIG_IS_ENABLED(OF_PLATDATA)) {
> >               spl_boot_list[0] = spl_boot_device();
> >               return;
> >       }
>
> Another option could be to just skip spl-boot-order.o for VPL, the
> default implementation should work as-is, not sure what is best.

OK, I'll do that, thanks.

Regards,
Simon
