Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4211BC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9998B809D0;
	Tue, 11 Feb 2025 14:11:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R8XAiUnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D54F80A55; Tue, 11 Feb 2025 14:11:44 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71888800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5de6e26d4e4so5180625a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739279502; x=1739884302; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mp0gj2Tj93eBl9Q1sayVTzGvQvzUbcaf0X1u/8tWXHs=;
 b=R8XAiUnS4A7FNkk8dKXuWpcKPB1TDb8cPAlmwaM4os/Ub2QBcmWYJ3TfMWhQmmypqh
 54WHB5IpWp8Vb5aRMoTU34rnGiRAAEWl0lRt3XxBLt05BM+G3jgYzjCemB4xmFZGnpZK
 Qmz8+7H8BZPhnToGkAG/JmCHzJrIDbaYuU5vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279502; x=1739884302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mp0gj2Tj93eBl9Q1sayVTzGvQvzUbcaf0X1u/8tWXHs=;
 b=jatgh/031vG5yvRdKC3Xs2iA2rsX8QtbyQYRylTOGsQxnXEfuCoFIYuDCZdR+hziYb
 rwi7a6M7ZO5LZnDO4IGWEbb/IzKuZMIhiZ3LmhaQzdJD6iQDtfZlyZqS+VBWKPked0ro
 zXsCXMWeTkqSCQYn4A0AJkehr/hN7shmLRwdyPkEctqCqdK694wwA+j3G02AueF4veAh
 vpsI0HbHtVj6eB8bEp38+qgWS6c901dbIf0njR5FPW3BIQaN3Q8Kx30hY/o6OfM159ln
 /rX0BLjHukeTb9EBLOIq+/J7YcPnLUkxvf9XJ4FO2hbpZ2DmRoRrQZCmnc8aSz01AI1P
 Q5YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRjMAlzOFDlZNxFubDn/Eb8rhovCW+PHv/zODR0WvltLOrFScsd5GBCs9Da9zU5e49GW2FJqo=@lists.denx.de
X-Gm-Message-State: AOJu0YykYKA+RfuLo/mosXag7DjGWixlhxT+TKyDUU9B2kthmT5oo4UQ
 ohFdoXR1xAt4oMiBOSnIFAesUpIvaSNw6b34+iGBMQu/UBQGGdm7jlnBfzWa+X2Diphk++Qad2I
 ksTNg1h2EsA4uR2+klbZw9SXgXRUa+LJkoTvy
X-Gm-Gg: ASbGncstVvfz7UU/s7BnvABYcZ79/1WZL6Z8AVWFMKTkjwkOPDjMBO+nyeBuryCvhwa
 7nvlkxJMd5sUOrtIVEt52qlhd9Mds9xb4I/u6e7P93dQOBkeoaA5MTrtmErVDEHMTzDjMc1Rfub
 zgnM2QVjsZ9e6TVbh62K7rjje3KAnb5A==
X-Google-Smtp-Source: AGHT+IEHfbYu5vmryDixl9Pg0VGmwiiBxtVkdUIA3j+LPsKn2Ztysr62Tp4pS2a5Wbahfk/c3RP/e6yY9oKAwT0+Z4U=
X-Received: by 2002:a05:6402:3907:b0:5d4:3105:c929 with SMTP id
 4fb4d7f45d1cf-5de450aa428mr17396274a12.23.1739279501810; Tue, 11 Feb 2025
 05:11:41 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-6-sjg@chromium.org>
 <d6eb6aa3-8b38-4bf0-942f-ffc8a068e444@kwiboo.se>
 <CAFLszTi3VMhdX=n8GvvG3ZW7=oy3Eac9KaSBaCaBi7m17e0gfQ@mail.gmail.com>
 <20250210170649.GP1233568@bill-the-cat>
In-Reply-To: <20250210170649.GP1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Feb 2025 06:11:29 -0700
X-Gm-Features: AWEUYZnb6-BsZYRkCXOLM0wIo_LHJXY9Is_V0w7pgJDrydkkSsIOdo7BW-dMb_o
Message-ID: <CAFLszTj5u1L3L2DsHG54uGT0VDOo6uNEtwUao0o8zGm3LGYh+Q@mail.gmail.com>
Subject: Re: [PATCH 05/29] rockchip: Allow RAM init to happen in SPL on rk3399
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
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

On Mon, 10 Feb 2025 at 10:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 07:26:38AM -0700, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Wed, 5 Feb 2025 at 15:18, Jonas Karlman <jonas@kwiboo.se> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 2025-02-05 02:54, Simon Glass wrote:
> > > > TPL runs before VPL. The earliest updatable phase with VBE is SPL. We
> > > > want to be able to update the RAM-init code in the field.
> > >
> > > If I understand your description here, you mean that both TPL and VPL
> > > are meant to be "burned" onto the board and not intended to be updatable?
> >
> > Yes, that's right. If you look at [1] and click on 'vbe-intro' there
> > is a diagram that shows the flow.
> >
> > >
> > > Is this a typo or do I misunderstand something? Else I do not understand
> > > why you would need TPL->VPL->SPL, please explain.
> > >
> > > >
> > > > So when VPL is being used, init the RAM later, in SPL.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  drivers/ram/rockchip/sdram_rk3399.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > > > index 6fa8f268770..9ac16dfdc71 100644
> > > > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > > > +++ b/drivers/ram/rockchip/sdram_rk3399.c
> > > > @@ -194,6 +194,7 @@ struct io_setting {
> > > >  static bool phase_sdram_init(void)
> > > >  {
> > > >       return xpl_phase() == PHASE_TPL ||
> > > > +             (IS_ENABLED(CONFIG_VPL) && xpl_phase() == PHASE_SPL) ||
> > > >               (!IS_ENABLED(CONFIG_TPL) &&
> > > >                !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL) &&
> > > >                !not_xpl());
> > > > @@ -3195,8 +3196,9 @@ U_BOOT_DRIVER(dmc_rk3399) = {
> > > >       .of_to_plat = rk3399_dmc_of_to_plat,
> > > >       .probe = rk3399_dmc_probe,
> > > >       .priv_auto      = sizeof(struct dram_info),
> > > > -#if defined(CONFIG_TPL_BUILD) || \
> > > > -     (!defined(CONFIG_TPL) && defined(CONFIG_XPL_BUILD))
> > > > +#if defined(CONFIG_VPL) && defined(CONFIG_SPL_BUILD) || \
> > > > +     !defined(CONFIG_VPL) && defined(CONFIG_TPL_BUILD) || \
> > > > +     !defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD)
> > > >       .plat_auto      = sizeof(struct rockchip_dmc_plat),
> > > >  #endif
> > > >  };
> > >
> > > These two conditions are starting to get ridiculous.
> > >
> > > With "[PATCH 24/29] rockchip: Allow SPL to set up SDRAM" you are
> > > depending on TPL_RAM to decide if RAM should be initialized. Maybe that
> > > is something we can use here to simplify?
> >
> > The problem is that TPL_RAM means that the ram driver is present,
> > which isn't the same thing as actually doing the RAM init in that
> > phase. If we had a Kconfig value for 'phase' then we could perhaps
> > have CONFIG_PHASE_RAM=tpl or something like that. I plan to get back
> > to my rejected XPL series soon and that is something I could
> > incorporate when that goes in.
>
> Please note that if you're going to revisit the "XPL" series I rejected
> you need to do what I asked instead or there's just going to be a larger
> gap between mainline and your downstream fork.

Yes I recall you wanted to completely separate the phases at the
defconfig level, which I am not keen on. I will send a proposal and
let's see if we can figure something out there.

Regards,
Simon
