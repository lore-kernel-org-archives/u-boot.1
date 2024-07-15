Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B03C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A2B68887B;
	Mon, 15 Jul 2024 13:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="noXEve8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205B888842; Mon, 15 Jul 2024 13:39:51 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC70887FD
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e03a17a50a9so4268243276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043587; x=1721648387; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nF3qCY7F+aXJO8Zy32nN4dhUblQkYjrt+Kf9xNdnLb4=;
 b=noXEve8PIuU+RAae3X01NL/YkNMT8wD0fC/LSz/sK4tODdy6pV8g2vFTKXHcdsAU4h
 lRn4ZNPnenm7NuyxFdaKlrlVFx7i5LXuL3ibZKBRvPdBvOHAUDrHC+29M1azQhfvJh52
 0M9ivdF78QYMVgbQuTKTyQgNh+OB0DAtqfdEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043587; x=1721648387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nF3qCY7F+aXJO8Zy32nN4dhUblQkYjrt+Kf9xNdnLb4=;
 b=h7Sj9ckAzXEZIeYbEk+ciehQauJHUsVO9x2CgfCbTaW5gKj8GI1HXX9PtppQ9B9Cxd
 VPOpZnmsGz57GZXKD0Ng/lS+nbk9lNOSFZmhVns644AMlhuQTA7qpbLjOHAqu/zq/7Np
 R72pHID9S0rO+/WiK5alTmw9TwM8Nf2wh0owqURI9johmHSjpoyv9gZOPCBnQPhydR9I
 7uoXhUFwwuJrov5e5l+S7EYjh8iPAxAXqNUvabs7nVm6hbEsLNHs9nKsdRgnZ3LC/XoP
 WwqnZY9GJIXQDAdTYJdhrZSDKf4wmK//Fhi7toSGH14iwv53vgvasTeEHpR17SdueG2f
 bHXA==
X-Gm-Message-State: AOJu0Yy57ay29IIoVP587vxmfERqVedlXDTmqz4DVazlIEljO594tbKi
 m3rxHizTD/hw6iBonEtuvrznnEjK8wgStcVr4dg2hbc56w1CreEHfln6MTYYNlEsX7xl+S8f/da
 LxwJ0Ay+O/GYtNQ+BY5VwXtmEZMgqK903WbFT
X-Google-Smtp-Source: AGHT+IF9qYJfW/XtAOwr/rLeqb1QBs1roqeACPQX5767586Oxpsvbg92f8xyTrhgfSSA+1S0xp2SdYoqelkjqOW0kYU=
X-Received: by 2002:a25:99c5:0:b0:dff:4044:517c with SMTP id
 3f1490d57ef6-e041b161dabmr20277380276.56.1721043587570; Mon, 15 Jul 2024
 04:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240703212338.1436606-1-trini@konsulko.com>
 <20240711212710.2743991-1-trini@konsulko.com>
 <CAFLszThp7ygWBVMmksYQrO8HTRSm5optwSh63==5fMEQ7btM+g@mail.gmail.com>
 <20240713165017.GC38804@bill-the-cat>
In-Reply-To: <20240713165017.GC38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:35 +0100
Message-ID: <CAFLszTg_MRtMnX5FzKcvzMQgT=XK1qKr8-jUEUJoOitMrWOqhQ@mail.gmail.com>
Subject: Re: [v2] bootstash: Do not provide a default address for all
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Sat, 13 Jul 2024 at 17:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jul 13, 2024 at 04:13:50PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 11 Jul 2024 at 22:27, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > A valid memory location to stash bootstage information at will be
> > > architecture dependent. Move the existing defaults to the main Kconfig
> > > file for this option and set 0x0 as the default only for sandbox.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Changes in v2:
> > > - Seeing that BOOTSTAGE_STASH_ADDR did not depend on BOOTSTAGE_STASH in
> > >   turn lead to discovering that (minor) BOOTSTAGE_STASH_SIZE was also
> > >   missing a depends on line and then that a number of places built code
> > >   with BOOTSTAGE_STASH_ADDR=0x0 as a compiles-but-likely-fails option.
> > >   Rework a number of spots to guard usage around BOOTSTAGE_STASH being
> > >   enabled.
> > > ---
> > >  arch/arm/mach-rockchip/tpl.c      |  4 ++--
> > >  arch/arm/mach-stm32mp/Kconfig.13x |  3 ---
> > >  arch/arm/mach-stm32mp/Kconfig.15x |  3 ---
> > >  arch/arm/mach-stm32mp/Kconfig.25x |  3 ---
> > >  arch/x86/cpu/cpu.c                |  2 ++
> > >  boot/Kconfig                      |  6 +++++-
> > >  cmd/bootstage.c                   |  8 +++++++-
> > >  common/board_f.c                  |  2 ++
> > >  common/bootstage.c                |  2 ++
> > >  common/spl/spl.c                  |  2 ++
> > >  include/bootstage.h               | 14 ++++++++------
> > >  11 files changed, 30 insertions(+), 19 deletions(-)
> >
> > There is quite a bit going on in this patch.
>
> Yes, there was unfortunately some underlying bugs.
>
> > > diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
> > > index 50f04f9474a0..a47cba5163ab 100644
> > > --- a/arch/arm/mach-rockchip/tpl.c
> > > +++ b/arch/arm/mach-rockchip/tpl.c
> > > @@ -92,10 +92,10 @@ void board_init_f(ulong dummy)
> > >  int board_return_to_bootrom(struct spl_image_info *spl_image,
> > >                             struct spl_boot_device *bootdev)
> > >  {
> > > -#ifdef CONFIG_BOOTSTAGE_STASH
> > > -       int ret;
> > > +       int __maybe_unused ret;
> > >
> > >         bootstage_mark_name(BOOTSTAGE_ID_END_TPL, "end tpl");
> > > +#if IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> >
> > It should be enough to just call bootstage_stash_default() here,
> > unconditionally. It does nothing if not enabled.
>
> Nope, we don't have ADDR/SIZE defined. The current defaulting them to
> 0 leads to the case today where platforms which don't enable stash have
> ~700 bytes of stash related code being kept.

Yes I see.
>
> [snip]
> > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > index 7794ddccade1..47db4ead5050 100644
> > > --- a/common/spl/spl.c
> > > +++ b/common/spl/spl.c
> > > @@ -472,11 +472,13 @@ static int spl_common_init(bool setup_malloc)
> > >                       ret);
> > >                 return ret;
> > >         }
> > > +#if CONFIG_IS_ENABLED(BOOTSTAGE)
> >
> > I don't think this #ifdef is needed.
>
> As part of being able to discard the stash functionality, it is.
>
> > >         if (!u_boot_first_phase()) {
> > >                 ret = bootstage_unstash_default();
> > >                 if (ret)
> > >                         log_debug("Failed to unstash bootstage: ret=%d\n", ret);
> > >         }
> > > +#endif
> > >         bootstage_mark_name(get_bootstage_id(true),
> > >                             spl_phase_name(spl_phase()));
> > >  #if CONFIG_IS_ENABLED(LOG)
> > > diff --git a/include/bootstage.h b/include/bootstage.h
> > > index f4e77b09d747..2d4987f31414 100644
> > > --- a/include/bootstage.h
> > > +++ b/include/bootstage.h
> > > @@ -462,18 +462,20 @@ int _bootstage_unstash_default(void);
> > >
> > >  static inline int bootstage_stash_default(void)
> > >  {
> > > -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
> > > -               return _bootstage_stash_default();
> > > -
> > > +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> > > +       return _bootstage_stash_default();
> > > +#else
> > >         return 0;
> > > +#endif
> >
> > I believe you can leave this as it is.
> >
> > >  }
> > >
> > >  static inline int bootstage_unstash_default(void)
> > >  {
> > > -       if (CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH))
> > > -               return _bootstage_unstash_default();
> > > -
> > > +#if CONFIG_IS_ENABLED(BOOTSTAGE) && IS_ENABLED(CONFIG_BOOTSTAGE_STASH)
> > > +       return _bootstage_unstash_default();
> > > +#else
> > >         return 0;
> > > +#endif
> >
> > and this
>
> Nope, this too is required to discard "stash" when not enabled.

Yes, got it, but my point was that the header file already has this
logic. I'll send a new version to show what I am talking about...

Regards,
Simon
