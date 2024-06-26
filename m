Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE29C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 14:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85E89880FB;
	Wed, 26 Jun 2024 16:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mg9cYpQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C770F8826B; Wed, 26 Jun 2024 16:54:20 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A43E9880AD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 16:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-79c04e6e1b9so151332085a.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719413657; x=1720018457; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=koPDnn+rrzJfdlW2ln/86OohRBB4JeQem9wvF+5qY6o=;
 b=Mg9cYpQ80icBtm7PDW9Fz+AoFAEew2Md09+9q3RJa6fHMFRj5GjqGRNRV5nXYIj3HA
 IX3oPZgaIe8cgsNBWrDBlm8EyKVl4MFBpwL1UKvkVYQnH0qctbZF12s9P7Qu/kmJr6ZJ
 bV9UgpbuWwJc8hY3iYA0ec3Qc5LWSnjkt1Lmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719413657; x=1720018457;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=koPDnn+rrzJfdlW2ln/86OohRBB4JeQem9wvF+5qY6o=;
 b=G5cx2eOZlJE9N9jgOEZoiORTrHvW/8GEifJSfy2kQ1AxNYpQDS52lrMp5HsAnPXnZf
 dM18qpEn7sEaw6exFI5mQi+sJztObxPBXYE1qwCp933FCyvP1gq68c6DFPgqnyC1xzqK
 1GznioQgtBYvTXhtu8M55lVyBptDgi1j9i+awwxFJjF68I3+R81kYxB+mUx/+17Wmufk
 uH1rvNYs6P02t26Lsuy//QPAcSE03+XX5i4Bpb374zb/8W2P9IEmJNrxltU4D8PFboKe
 XlaK59r5jpJ6AJypRqp8gz+AllydDGSDYoX9kXx24JdL1cAMk5R7Iqn9jlisBcu7w2Cv
 hVzA==
X-Gm-Message-State: AOJu0YzofxQ6k8ZJczvP8LR+9OhILXGcyu/ne3E/p4QXtGRgH7bItteh
 +K5bdMfCHJCyV0xZJZyJDxHActZ3bWw60WMA4hQuXlGMVPiPw00bMRIzHTnjNnsZY7otkTW6cvd
 5mR8eFkgiwZdrqUqBwoOPlQnWzaqKXT2bhw+i
X-Google-Smtp-Source: AGHT+IGTmD1aZGW2YR/0wbwdf0LLJZNcFdQZ/aLiQ67IFHmGnHVAtGmD0o/A8GbRG8vyFK9XsGA39inox8GpaVuz7ws=
X-Received: by 2002:a0c:c983:0:b0:6b2:d51c:f5b3 with SMTP id
 6a1803df08f44-6b5363ceea0mr114688376d6.18.1719413657371; Wed, 26 Jun 2024
 07:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-15-sjg@chromium.org>
 <c74cd79e-8df6-4d89-96d8-50175e452a78@kwiboo.se>
In-Reply-To: <c74cd79e-8df6-4d89-96d8-50175e452a78@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Jun 2024 15:54:06 +0100
Message-ID: <CAFLszTiAZQWVfJ_5mCSzdFzf_9HJuhLwk+SWhtGs=Sg2eNCYMw@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
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

Hi Jonas,

On Mon, 24 Jun 2024 at 09:53, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-06-23 19:53, Simon Glass wrote:
> > The code here is confusing due to large blocks which are #ifdefed out.
> > Add a function phase_sdram_init() which returns whether SDRAM init
> > should happen in the current phase, using that as needed to control the
> > code flow.
> >
> > This increases code size by about 500 bytes in SPL when the cache is on,
> > since it must call the rather large rockchip_sdram_size() function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Drop the non-dcache optimisation, since the cache should normally be on
> >
> > Changes in v3:
> > - Split out the refactoring into a separate patch
> >
> >  drivers/ram/rockchip/sdram_rk3399.c | 42 +++++++++++++++--------------
> >  1 file changed, 22 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 3c4e20f4e80..949a082d00c 100644
> > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > +++ b/drivers/ram/rockchip/sdram_rk3399.c
>
> [snip]
>
> > @@ -191,6 +186,17 @@ struct io_setting {
> >       },
> >  };
> >
> > +/**
> > + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> > + *
> > + * Returns: true to do SDRAM init in this phase, false to not
> > + */
> > +static bool phase_sdram_init(void)
> > +{
> > +     return spl_phase() == PHASE_TPL ||
> > +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
>
> This also need to check for !IS_ENABLED(CONFIG_ROCKCHIP_EXTERNAL_TPL).

I don't see this condition in the current code...I am wondering how
this works today?

Regards,
Simon
