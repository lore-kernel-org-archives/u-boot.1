Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D7C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8646A811B3;
	Thu, 27 Feb 2025 17:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CIGTfDQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1EB81113; Thu, 27 Feb 2025 17:27:36 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FBC81197
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:27:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2feb9076cdcso401076a91.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673652; x=1741278452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BY/DNwhR7YTmkrGAgxlih+lOhv0ZcrpdHYIDC2J7TSE=;
 b=CIGTfDQvuOkHVpIrb+lhCAfTZ+XpFm7srU92uAWXDilyVRI3ol7Dsp9ge/cEQt9HCP
 /fU6ALJWyFN7h/UjCeMQI0PHMeeQ57S3llB939dDS5IkvkMUuz/o5+0y26WSFUKvGHH2
 tqIYWjMDO4ghI+QIOujj9kD5qYEuOsjHj4J+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673652; x=1741278452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BY/DNwhR7YTmkrGAgxlih+lOhv0ZcrpdHYIDC2J7TSE=;
 b=QBuVOExolZTk7eH86zHSqiCwyHzJoF1+eDTc/+tqeKUbCcevSZl4vEWsaSFkNWf2QP
 eIdjaFyuNbV9Yc/v6icpSoEW2QWKM1Agu3hkE8XBK6F5b888F5Rubn2Dq0FA5CSdH9jy
 lXosHEmbUVZ/JAu4oo/MH7S/WWPcr5yH0XjQVZZuJYWPOjJTOkhz+rfS/y2wiAJyucaU
 bOPAqQ9zrOZlr1ShVtUjQae6yAQJa0eOr8pde4EtsRNIXHGcFIM1qC2EgA5A7AJO+TcA
 igXRyHES3DP9MobrQ6g6/0AMr6WTOiw/jEYYHn6mSh9vUNPkeY78OSwUKOT3O5Iryzhk
 1l4g==
X-Gm-Message-State: AOJu0YziwAElkECLycrW8TGhUdLnQ3et7THgPzElrXUNI4M1rVpErMxB
 zaxUVZ7QgyCLVvMzYV96C+MOGG/8m2mLKWJnlBwFKGWtBqWb6RJpDtwoukwJNrLCheBwWIqZBeS
 WbbGZiWsncM0/gNPPR/WgDOQO6lAiKWfQXzWj
X-Gm-Gg: ASbGnctFNEIcbKXkn2AZt+tvC81xbvYqmW8POunDnS37s5xADuln99G+QKcXzxaClJd
 F+lnBUBwtOJS2Ji6w0PVPrcTnWrHjiAU/IEpgeETWtNrUg6kYIlS+TyfCgigRWinx0IM/ejs4+U
 L3VUxnuNP5
X-Google-Smtp-Source: AGHT+IFHNOvcFnOTwz/EJ9nxmB2hgotAxvDlxb+n90yn+jEkc6dsKRlzmG8YXOkYjnl4kkIo+eBVcQEvwKg54wvsnfE=
X-Received: by 2002:a17:90b:3ccc:b0:2ee:b0b0:8e02 with SMTP id
 98e67ed59e1d1-2fce872448amr41345695a91.28.1740673652581; Thu, 27 Feb 2025
 08:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-2-sjg@chromium.org>
 <f244a0ff-32ac-451a-b088-93f142150630@kwiboo.se>
In-Reply-To: <f244a0ff-32ac-451a-b088-93f142150630@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:26:35 -0700
X-Gm-Features: AQ5f1JodnJ30YkPG-e8h__FhMRs27vkcw_gnlBQAbU4gGKBvws6dHmqMuibqzcA
Message-ID: <CAFLszTi6TFHhkU9GnjhUFQT6WNpttMfEswSMQWQ1T1ShiV+cfg@mail.gmail.com>
Subject: Re: [PATCH v2 01/35] tpl: Rename TPL_NEEDS_SEPARATE_STACK to
 TPL_HAVE_INIT_STACK
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Chen-Yu Tsai <wens@csie.org>, 
 Dragan Simic <dsimic@manjaro.org>, Gary Bisson <bisson.gary@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Mon, 17 Feb 2025 at 13:28, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-09 22:14, Simon Glass wrote:
> > The most common word for features that make a platform work is to use
> > 'HAVE_xxx'. Rename this option to match.
>
> We already have HAS_CUSTOM_SYS_INIT_SP_ADDR related to the init stack
> pointer address, maybe the new symbol should be named something similar
> to that? e.g. HAS_xPL_INIT_SP_ADDR

That would be quite confusing, since we still need SYS_INIT_SP_ADDR
that option to work.

The name would have to be xPL_HAS_SP_INIT_SP_ADDR to fit with the
naming convention and allow CONFIG_IS_ENABLED() and avoid more
confusion. Plus, SYS_INIT_SP_ADDR is actually a fallback for when the
xPL builds don't provide their own address.

So I think this needs to be separate, particularly as Tom is talking
of splitting the deconfig files, at which point we wouldn't be able to
make xPL use SYS_INIT_SP_ADDR as a default.

>
> >
> > Update the help to use the word 'phase' rather than 'stage', since
> > that is the current terminology. Also clarify that, absent this setting,
> > the stack pointer generally comes from the value used by U-Boot proper,
> > rather than SPL.
>
> The last statement is not fully correct, see below.
>
> >
> > Move the option just above TPL_STACK which depends on it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch to rename TPL_NEEDS_SEPARATE_STACK
> >
> >  arch/arm/lib/crt0.S            |  2 +-
> >  arch/arm/lib/crt0_64.S         |  2 +-
> >  arch/arm/mach-rockchip/Kconfig | 14 +++++++-------
> >  common/spl/Kconfig.tpl         | 19 ++++++++++---------
> >  configs/mk808_defconfig        |  2 +-
> >  5 files changed, 20 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> > index a691d844847..a7e6f50d39a 100644
> > --- a/arch/arm/lib/crt0.S
> > +++ b/arch/arm/lib/crt0.S
> > @@ -100,7 +100,7 @@ ENTRY(_main)
> >   * Set up initial C runtime environment and call board_init_f(0).
> >   */
> >
> > -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
> > +#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> >       ldr     r0, =(CONFIG_TPL_STACK)
> >  #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
> >       ldr     r0, =(CONFIG_SPL_STACK)
>
> Here we can see that SPL_STACK is used as the first fallback for
> XPL_BUILD's.

Oh dear. I believe that is unintended, but I'm not sure which way to
take it. For now I'll update the comment.

>
> > diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> > index 32401f544a7..62a0abe1fed 100644
> > --- a/arch/arm/lib/crt0_64.S
> > +++ b/arch/arm/lib/crt0_64.S
> > @@ -69,7 +69,7 @@ ENTRY(_main)
> >  /*
> >   * Set up initial C runtime environment and call board_init_f(0).
> >   */
> > -#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_NEEDS_SEPARATE_STACK)
> > +#if defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_HAVE_INIT_STACK)
> >       ldr     x0, =(CONFIG_TPL_STACK)
> >  #elif defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_STACK)
> >       ldr     x0, =(CONFIG_SPL_STACK)
> > diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> > index 4d3157b2edd..4c515593718 100644
> > --- a/arch/arm/mach-rockchip/Kconfig
> > +++ b/arch/arm/mach-rockchip/Kconfig
> > @@ -9,7 +9,7 @@ config ROCKCHIP_PX30
> >       select SPL
> >       select TPL
> >       select TPL_TINY_FRAMEWORK if TPL
> > -     select TPL_NEEDS_SEPARATE_STACK if TPL
> > +     select TPL_HAVE_INIT_STACK if TPL
> >       imply SPL_SEPARATE_BSS
> >       select SPL_SERIAL
> >       select TPL_SERIAL
> > @@ -106,7 +106,7 @@ config ROCKCHIP_RK322X
> >       select TPL
> >       select TPL_DM
> >       select TPL_OF_LIBFDT
> > -     select TPL_NEEDS_SEPARATE_STACK if TPL
> > +     select TPL_HAVE_INIT_STACK if TPL
> >       select SPL_DRIVERS_MISC
> >       imply ROCKCHIP_COMMON_BOARD
> >       imply SPL_SERIAL
> > @@ -139,7 +139,7 @@ config ROCKCHIP_RK3288
> >       imply TPL_DRIVERS_MISC
> >       imply TPL_LIBCOMMON_SUPPORT
> >       imply TPL_LIBGENERIC_SUPPORT
> > -     imply TPL_NEEDS_SEPARATE_STACK
> > +     imply TPL_HAVE_INIT_STACK
> >       imply TPL_OF_CONTROL
> >       imply TPL_OF_PLATDATA
> >       imply TPL_RAM
> > @@ -197,7 +197,7 @@ config ROCKCHIP_RK3328
> >       select SPL
> >       select SUPPORT_TPL
> >       select TPL
> > -     select TPL_NEEDS_SEPARATE_STACK if TPL
> > +     select TPL_HAVE_INIT_STACK if TPL
> >       imply ARMV8_CRYPTO
> >       imply ARMV8_SET_SMPEN
> >       imply MISC
> > @@ -225,7 +225,7 @@ config ROCKCHIP_RK3368
> >       select ARM64
> >       select SUPPORT_SPL
> >       select SUPPORT_TPL
> > -     select TPL_NEEDS_SEPARATE_STACK if TPL
> > +     select TPL_HAVE_INIT_STACK if TPL
> >       imply ROCKCHIP_COMMON_BOARD
> >       imply SPL_ROCKCHIP_COMMON_BOARD
> >       imply SPL_SEPARATE_BSS
> > @@ -257,7 +257,7 @@ config ROCKCHIP_RK3399
> >       select SPL_RAM if SPL
> >       select SPL_REGMAP if SPL
> >       select SPL_SYSCON if SPL
> > -     select TPL_NEEDS_SEPARATE_STACK if TPL
> > +     select TPL_HAVE_INIT_STACK if TPL
> >       select SPL_SEPARATE_BSS
> >       select CLK
> >       select FIT
> > @@ -392,7 +392,7 @@ config ROCKCHIP_RV1126
> >       select SKIP_LOWLEVEL_INIT_ONLY
> >       select TPL
> >       select SUPPORT_TPL
> > -     select TPL_NEEDS_SEPARATE_STACK
> > +     select TPL_HAVE_INIT_STACK
> >       select TPL_ROCKCHIP_BACK_TO_BROM
> >       select SPL
> >       select SUPPORT_SPL
> > diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> > index 22ca7016453..980d6da202a 100644
> > --- a/common/spl/Kconfig.tpl
> > +++ b/common/spl/Kconfig.tpl
> > @@ -106,12 +106,6 @@ config TPL_LDSCRIPT
> >         May be left empty to trigger the Makefile infrastructure to
> >         fall back to the linker-script used for the SPL stage.
> >
> > -config TPL_NEEDS_SEPARATE_STACK
> > -     bool "TPL needs a separate initial stack-pointer"
> > -     help
> > -       Enable, if the TPL stage should not inherit its initial
> > -       stack-pointer from the settings for the SPL stage.
> > -
> >  config TPL_POWER
> >       bool "Support power drivers"
> >       help
> > @@ -140,11 +134,18 @@ config TPL_MAX_SIZE
> >       help
> >         The maximum size (in bytes) of the TPL stage.
> >
> > +config TPL_HAVE_INIT_STACK
> > +     bool "TPL requires a initial, fixed, stack-pointer location"
> > +     help
> > +       Enable if the TPL phase should not use inherit its initial
>
> "should not use inherit its initial" does not sound correct.

Fixed

>
> > +       stack-pointer from the settings for U-Boot proper, but should set
>
> Here you are changing from SPL to proper, however the SPL address will
> be used as the fallback (if it is defined) and then SYS_INIT_SP_ADDR.

OK, I'll update that.

>
> > +       its own value.
> > +
> >  config TPL_STACK
> > -     hex "Address of the initial stack-pointer for the TPL stage"
> > -     depends on TPL_NEEDS_SEPARATE_STACK
> > +     hex "Address of the initial stack-pointer for the TPL phase"
> > +     depends on TPL_HAVE_INIT_STACK
> >       help
> > -       The address of the initial stack-pointer for the TPL stage.
> > +       The address of the initial stack-pointer for the TPL phase
>
> Did you remove the . (period) on purpose?

Yes, as it is not a sentence

>
> Regards,
> Jonas
>
> >         Usually this will be the (aligned) top-of-stack.
> >
> >  config TPL_READ_ONLY
> > diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
> > index e47d0b594f3..a1f089a23ea 100644
> > --- a/configs/mk808_defconfig
> > +++ b/configs/mk808_defconfig
> > @@ -48,7 +48,7 @@ CONFIG_SPL_NO_BSS_LIMIT=y
> >  CONFIG_SPL_SEPARATE_BSS=y
> >  CONFIG_SPL_FS_EXT4=y
> >  CONFIG_SYS_MMCSD_FS_BOOT_PARTITION=2
> > -CONFIG_TPL_NEEDS_SEPARATE_STACK=y
> > +CONFIG_TPL_HAVE_INIT_STACK=y
> >  # CONFIG_BOOTM_PLAN9 is not set
> >  # CONFIG_BOOTM_RTEMS is not set
> >  # CONFIG_BOOTM_VXWORKS is not set
>

Regards,
Simon
