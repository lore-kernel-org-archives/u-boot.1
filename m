Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D26CC02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F53807D7;
	Sun,  9 Feb 2025 15:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZeqNx+IY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F2A5807FE; Sun,  9 Feb 2025 15:26:53 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268A080141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5dcef33eeceso6660484a12.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111210; x=1739716010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ElJcGEkEp/PrgzUS0ltJJpkO9990IlFM1Qxj2KXzvQ=;
 b=ZeqNx+IYZTQ8C8Evc1P3VyHlD1ga7c8jMUvBDsICQYBWBSA6EUKvarGPRrjTTnm/Yu
 Ez3ls+c6wODbd4iRX+DtBDWCmKF4+HjjIKDakXo0V8kA2q0NUP+Y1wFGS+qQyE4lMAYH
 t79j08CBN8CIoaNFNUqsVKd7mp5qocPBHcBtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111210; x=1739716010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ElJcGEkEp/PrgzUS0ltJJpkO9990IlFM1Qxj2KXzvQ=;
 b=aIBZOFDC5XOW5UkoYCTdg0LuiXMyVq64N9aLiRKOcvZfP2b7S0T/IJL6r0WbhFD4f+
 E00UXXYkZRbhPLrhjQKZ/OWxMtFfJkOA4v/lVdF7+nUc2V50H0cHJRO19AjRh4dsLlhJ
 +Nd4ukq3/MWInui8fIpqu9B2WpJgTI3zN2c+yTSlD8Zx91K2PEmoKEp8OiyUdEgH6rLS
 lx/q0ZlZNX3En/qwxB6z9N+0obs8kPgQbtDC00l9ycvDM/nOpDdWuxYKV8DI2PDvdw/f
 O0HOltmYGEghOWygcECQ173qnEawyQHZtcVJrhb7wKwVLR5qUrb/2bUe9yiZUKdIUaKx
 hFnw==
X-Gm-Message-State: AOJu0Ywhx1XFERKcTmPXrbDbwssPK+ISEZO6ZjW8PFbayRyByS2gZPdw
 X2VCh1/duHxpao1bFqB7wLEcD0ar7ZH8eDy1WvL9jdaaVUYJZFBn5uIdw5JxQfldfOQJ+HIlok6
 H0Gf2cNqktESgoaY8TRb+lBuMW5JHhX2eZ6LP
X-Gm-Gg: ASbGncu5YaRn+M8r/s2Bx/qgUyuOqTNBdhlDQIhRrT6tBDFIH4ErCl1bfMgTN581ik9
 X3Lv07r01s8rrX6fR64F48+ttqx4u6BQiHo43YKC0Lu5HFnNzJoZAweiS5qiWdoQM4hKvZkHk3Q
 ==
X-Google-Smtp-Source: AGHT+IFZAEwrBlBmg8f794t9Y/7juIVj9MFyDtZIFYovt/VeiwVVGp6xjIrVp2l6jVfxcNFGDzuHU/MdmtBZYdj3qW0=
X-Received: by 2002:a05:6402:50ce:b0:5de:5025:2bd9 with SMTP id
 4fb4d7f45d1cf-5de50252d3amr9961992a12.11.1739111210478; Sun, 09 Feb 2025
 06:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-6-sjg@chromium.org>
 <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
In-Reply-To: <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:26:38 -0700
X-Gm-Features: AWEUYZlByEor-4Zqro_70SvY3c6XM9Q9nbyQDXjVZchwfb98c-8p4aAmTcmCcDc
Message-ID: <CAFLszTi3VMhdX=n8GvvG3ZW7=oy3Eac9KaSBaCaBi7m17e0gfQ@mail.gmail.com>
Subject: Re: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 huang lin <hl@rock-chips.com>
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

On Wed, 5 Feb 2025 at 15:18, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-02-05 02:54, Simon Glass wrote:
> > TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
> > want to be able to update the RAM-init code in the field.
>
> If I understand your description here, you mean that both TPL and VPL
> are meant to be "burned" onto the board and not intended to be updatable?

Yes, that's right. If you look at [1] and click on 'vbe-intro' there
is a diagram that shows the flow.

>
> Is this a typo or do I misunderstand something? Else I do not understand
> why you would need TPL->VPL->SPL, please explain.
>
> >
> > So when VPL is being used, init the RAM later, in SPL.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 6fa8f268770..9ac16dfdc71 100644
> > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > +++ b/drivers/ram/rockchip/sdram_rk3399.c
> > @@ -194,6 +194,7 @@ struct io_setting {
> >  static bool phase_sdram_init(void)
> >  {
> >       return xpl_phase() == PHASE_TPL ||
> > +             (IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
> >               (!IS_ENABLED(CONFIG_TPL) &&
> >                !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
> >                !not_xpl());
> > @@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
> >       .of_to_plat = rk3399_dmc_of_to_plat,
> >       .probe = rk3399_dmc_probe,
> >       .priv_auto      = sizeof(struct dram_info),
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> > +#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
> > +     !defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
> > +     !defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
> >       .plat_auto      = sizeof(struct rockchip_dmc_plat),
> >  #endif
> >  };
>
> These two conditions are starting to get ridiculous.
>
> With "[PATCH 24/29] rockchip: Allow SPL to set up SDRAM" you are
> depending on TPL_RAM to decide if RAM should be initialized. Maybe that
> is something we can use here to simplify?

The problem is that TPL_RAM means that the ram driver is present,
which isn't the same thing as actually doing the RAM init in that
phase. If we had a Kconfig value for 'phase' then we could perhaps
have CONFIG_PHASE_RAM=tpl or something like that. I plan to get back
to my rejected XPL series soon and that is something I could
incorporate when that goes in.

>
> Basically we will have 3 possible DRAM init scenarios to support:
> - ROCKCHIP_EXTERNA_TPL=y -> DRAM init happen in external TPL and SPL
>   should only read DRAM size
> - VPL=y or TPL=n -> both DRAM init and read DRAM size happen in SPL
> - TPL=y -> DRAM init in TPL and SPL should only read DRAM size

Yes that's my understanding too. For the last one, for clarity:

 - TPL=y -> DRAM init in TPL; SPL should only read DRAM size

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/develop/vbe.html#verified-boot-for-embedded-vbe
