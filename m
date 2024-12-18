Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0172EE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 09:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A69802EF;
	Wed, 18 Dec 2024 10:25:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yJQH+PGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD5B380304; Wed, 18 Dec 2024 10:25:24 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65DC68022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6ef60e500d7so44928897b3.0
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734513921; x=1735118721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D9v44OaqwFy9svn0RjmQ9QbUJUfA84tB9DWcyiv1uIc=;
 b=yJQH+PGPcYiY7LB0niwk6MqXbCHvc0tDH9ku9J91v60Ar/sR8gkJ8X6wIVIJOYejHH
 KeNylbWn6scrMwaO2+uAv8vgT7ayBnRS/a9lt8AB6xv/1O4fKg0NjVVZYBnIaR2I9Rui
 hd2UxSnv5WMPze3/kYjPoR4ytP6QVfag+0D8BXQleOQGDs1Z/WzliwhxRFwvVqQ61zGM
 QM1b9/b5NEbFyJGe5KIYXd0PJstDUBDoK+8f8QoZZk9q1qicTSYXJrzhAmbeASVETAo3
 XTpyaeH6x+3H5Li2QSS0K2ZzqFIXK1r5M2Dev1QJ+fX/WnseCh7hws8fkgkiGcOJS1Qr
 x5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734513921; x=1735118721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9v44OaqwFy9svn0RjmQ9QbUJUfA84tB9DWcyiv1uIc=;
 b=nByJiEvaTD3Cdbiso9hMMcTI9pRkXlzdtQ2SWVL5n+lCYSFDUmLJJGY5kTB4YA9l0g
 Cj7XDLtvBjd2x8kH/6BChHYly1EXpuwx9uMy1XVPb+tpJVK/v36xnISi6iabYUNxNOxR
 baADu83BwpdsuU15L04MJxJ53311xaUCZPmlwB/6SRxUi7fmB+DwWbt8cLPYnQTzI0Zt
 K/x1a6nKJ6TH35wOxaXjAl4laZgwqAjzzlcXvuXTL1NXqmSXweJ+nZXxDpU7vpZIT6q5
 JCQ3r3Go+Db2jpPejk0sEvaa9DMUtDQ2N+4kRbhwjFwCdwu5GMdL9Gd75W2dHbLtXap9
 JS6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOzvxDUNLcmhN4NK0RbGtH0OaCq/NuKojRTtvB3hQVceSF/0RLiAQ1oGj2DbBr1OoMuoFbmBs=@lists.denx.de
X-Gm-Message-State: AOJu0YxlXCaR2PUd3+q7iVV3z5OPmyvpQ6lfOIMuLWgqL95OVTRr2hdN
 3jUR56R1bXhjcrhy21NGfuHXdm8rWGT9TiLyCOVi2KwbZpQVLhgHpHlfGTiKT84hkt/nITQsoCV
 fWYMxtE85wQ2H8uO3nsz1VZVaxFSRitj6UPov4w==
X-Gm-Gg: ASbGncsgW1E2HUXm7J+ZaNXR/AgC+i/DD6DmyGaVVsT9e+ON8OLJC0khjU3oMMCu2ty
 Fw7fNxZOCGcJhaiS9cKt4r3W/OXdqftlldMDZLQ==
X-Google-Smtp-Source: AGHT+IHXVGBcz3YUqEhHMk3EfIu+Owen9k+k0zGP3xkbBLvviCM6xo9MqR6L26SLlouthwb4TjR7E5IjibAU2IzB6/w=
X-Received: by 2002:a05:690c:700c:b0:6ef:97a2:49e6 with SMTP id
 00721157ae682-6f3d2696b61mr15990577b3.31.1734513921273; Wed, 18 Dec 2024
 01:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
In-Reply-To: <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Dec 2024 11:24:45 +0200
Message-ID: <CAC_iWjJxi9mkaAbR6DFHCZ13FNSnkWKSkFLZa_PLpvDOuZq9bw@mail.gmail.com>
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Thanks Frieder

On Wed, 18 Dec 2024 at 11:17, Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
> > tried to adjust the usable memory limits on a 4GB boundary.
>
> I would be nice to also mention 74f88b72219e ("ARM: imx: imx8m: Fix
> board_get_usable_ram_top()") which actually introduces the value of
> 0xFFFF_FFFF. I guess it would even qualify for another Fixes tag.

Ah thanks, Tom can you amend it or want me to send a v2?

>
> >
> > ram_top is described as 'top address of RAM used by U-Boot' and we want
> > to preserve that. This is defined as a phys_addr_t and unfortunately
> > its size differs across architectures. This has lead us to a weird
> > state where 32bit boards define it 'SZ_4GB - 1' and 64bit boards as
> > 'SZ_4GB' unless it was otherwise defined.
> >
> > With some recent LMB changes and specifically
> > commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> > the board fails to boot properly although the commit above is correct
> > since it's making sure that no memory above ram_top is usable -- but
> > added to our memory map so EFI can hand it over to the booted OS.
> >
> > The reason for that is that during the LMB init we add all usable memory
> > in lmb_add_memory(). In that function any memory above ram_top gets added
> > as 'reserved' for LMB. With the current values tha's set to 0xFFFF_FFFF
> > for this board. Later LMB is trying to protect the memory area U-Boot lives
> > in with lmb_reserve_common(). The latter fails though since it tries to
> > add U-Boot top (which is 0xFFFF_FFFF as well) to U-Boot 'bottom'. This call
> > will fail since 1 byte of that memory range is already marked as 'reserved'.
> >
> > Since we are close to the release, LMB seems to assume that the address
> > is rounded up and is the 'next address' and so does parsing and adding
> > memory ranges from DT files, bump the ram_top of the board by 1byte.
> >
> > In the long run we should change all of the above and have 32b and 64b
> > platforms define ram_top identically.
>
> Some more ideas for cleaning up the situation in the long run:
>
> * Get rid of board_get_usable_ram_top() and fix the drivers that require
>   address space below SZ_4G.
>
> * Parse the 'dma-ranges' property in the SoC node of the devicetree
>   which already tells us what address space is usable (at least for
>   i.MX8M).
>
> Anyway, the change looks good to me for now, so:

Yep both of these are valid and good ideas.

>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Thanks
/Ilias

>
> >
> > Add a Fixes tag although the commit is correct, so people can figure out
> > the broken scenarios in the future.
> >
> > Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Fixes: commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank")
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/mach-imx/imx8m/soc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
> > index 9588b8b28bf2..85dc8b51a145 100644
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -362,7 +362,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >        * space below the 4G address boundary (which is 3GiB big),
> >        * even when the effective available memory is bigger.
> >        */
> > -     top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, 0xffffffff);
> > +     top_addr = clamp_val((u64)PHYS_SDRAM + gd->ram_size, 0, SZ_4G);
> >
> >       /*
> >        * rom_pointer[0] stores the TEE memory start address.
>
