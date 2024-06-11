Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516DAC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 19:14:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBA59886EE;
	Tue, 11 Jun 2024 21:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KEnvuSa7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7FF886F7; Tue, 11 Jun 2024 21:14:04 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D02885E7
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dfa727d47c1so6256855276.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718133240; x=1718738040; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=99bZlP6rRbv+KiL/K5Jr2fD9l081HgfEzexIjobD49I=;
 b=KEnvuSa7e8upMf4Bki9/7zixCYm4AKllQBgh6z9EWwY7acacPeQI18GY6MKEvrB5hY
 GgOWN8Td7rq1x1Uhypa19mKoaBhkPtWc1RrhhXvQ/xwpI9Kh38gdRnSAb1dWzQPoNNsH
 im7qaOcHqLJYt+o4iKBWtXZN7e6dg6IMeWYvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718133240; x=1718738040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=99bZlP6rRbv+KiL/K5Jr2fD9l081HgfEzexIjobD49I=;
 b=XkUUaYXxCqvcxrAB+cTmyz9zGdgGwgmIT6mNsN0rRRN3Oig7BU63YVexf8ULMdjd+t
 vMF4mPwB7P1zHIcqgtAg4cLzY3J6WiDbLrcNJc4/vwjaWWSVeUNLNQ3fAwCbSI9Z9EQg
 WQ5uUdaI8WW8ukqLFc431DO1EHffhpjvGoCrybBcTAeHO/IetLMInAYKy/lZ9kYARmal
 D47VLfU5yY1xNnSeZa756ML1oz0OZjRdTLPbFF7mqnH7HMfnbPPKPuBk3ip04vlSG0hI
 pinVvYrs1qVVwtNYiQmgduW0y/NOQRHZbBkcyL1BRroAkBPGrRamfLQ9A4pXYmGkz0G0
 xGPg==
X-Gm-Message-State: AOJu0YwLkygGMOR5c8II/D5iyYzzyh0qnxUMRzmbSqJGoORLc0xLckN9
 lv+VO8vgyI1bYsVYIv5Qx2PtD7Mp7qSUFavK+ffc3NGp0UDXq0q3RtzcGWBfeRoPJTVK574DON9
 4Kspt5pd8AJdG6qXM7CeFtGerU8JQirVeQrKc
X-Google-Smtp-Source: AGHT+IHsWgVgKrxuT5YuPEKQ6tSj9vVUk1FGIv4yQvcHJpJzWk/IVeGVPl9XeSISCa8hqudRE3hFJkdUP/SDhV8zYVY=
X-Received: by 2002:a5b:9d1:0:b0:dfb:1e8d:1313 with SMTP id
 3f1490d57ef6-dfb1e8d148amr8155094276.39.1718133240438; Tue, 11 Jun 2024
 12:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-8-sjg@chromium.org>
 <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
In-Reply-To: <282d4379-2094-42ff-8ac1-6327655ca2d5@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 13:13:49 -0600
Message-ID: <CAFLszTipUGTiPihWEsg4BWzqZuc06TVy5OrgEzghwogy9dmTpA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] rockchip: Ensure memory size is available in
 RK3399 SPL
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, huang lin <hl@rock-chips.com>
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

Hi Quentin,

On Tue, 11 Jun 2024 at 05:27, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 6/10/24 4:59 PM, Simon Glass wrote:
> > At present gd->ram_size is 0 in SPL, meaning that it is not possible to
> > enable the cache. Correct this by always populating the RAM size
> > correctly.
> >
> > Part of the confusion here comes from the large blocks of code which
> > are #ifdefed out. Add a function phase_sdram_init() which returns
> > whether SDRAM init should happen in the current phase, using that as
> > needed to control the code flow.
> >
> > This increases code size by about 500 bytes in SPL when the cache is on,
> > since it must call the rather large rockchip_sdram_size() function.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch to correct memory size in SPL
> >
> >   drivers/ram/rockchip/sdram_rk3399.c | 49 ++++++++++++++++-------------
> >   1 file changed, 27 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 02cc4a38cf0..2f37dd712e7 100644
> > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > +++ b/drivers/ram/rockchip/sdram_rk3399.c
> > @@ -13,6 +13,7 @@
> >   #include <log.h>
> >   #include <ram.h>
> >   #include <regmap.h>
> > +#include <spl.h>
> >   #include <syscon.h>
> >   #include <asm/arch-rockchip/clock.h>
> >   #include <asm/arch-rockchip/cru.h>
> > @@ -63,8 +64,6 @@ struct chan_info {
> >   };
> >
> >   struct dram_info {
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> >       u32 pwrup_srefresh_exit[2];
> >       struct chan_info chan[2];
> >       struct clk ddr_clk;
> > @@ -75,7 +74,6 @@ struct dram_info {
> >       struct rk3399_pmusgrf_regs *pmusgrf;
> >       struct rk3399_ddr_cic_regs *cic;
> >       const struct sdram_rk3399_ops *ops;
> > -#endif
> >       struct ram_info info;
> >       struct rk3399_pmugrf_regs *pmugrf;
> >   };
> > @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
> >                                       struct rk3399_sdram_params *params);
> >   };
> >
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> > -
> >   struct rockchip_dmc_plat {
> >   #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >       struct dtd_rockchip_rk3399_dmc dtplat;
> > @@ -191,6 +186,17 @@ struct io_setting {
> >       },
> >   };
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
> > +}
> > +
> >   static struct io_setting *
> >   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
> >   {
> > @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
> >       struct rockchip_dmc_plat *plat = dev_get_plat(dev);
> >       int ret;
> >
> > -     if (!CONFIG_IS_ENABLED(OF_REAL))
> > +     if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
> >               return 0;
> >
> >       ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> > @@ -3138,23 +3144,25 @@ static int rk3399_dmc_init(struct udevice *dev)
> >
> >       return 0;
> >   }
> > -#endif
> >
> >   static int rk3399_dmc_probe(struct udevice *dev)
> >   {
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> > -     if (rk3399_dmc_init(dev))
> > -             return 0;
> > -#else
> >       struct dram_info *priv = dev_get_priv(dev);
> >
> > -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > -     debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > -     priv->info.base = CFG_SYS_SDRAM_BASE;
> > -     priv->info.size =
> > -             rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> > -#endif
> > +     if (phase_sdram_init()) {
> > +             if (rk3399_dmc_init(dev))
> > +                     return 0;
> > +     } else {
> > +             priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > +             debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > +     }
> > +
> > +     if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> > +             priv->info.base = CFG_SYS_SDRAM_BASE;
> > +             priv->info.size =
> > +                     rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
> > +     }
> > +
>
> Isn't the whole change summarized to making sure that priv->info.base
> and priv->info.size are set when DCACHE is enabled AND we're in the
> first stage BL (TPL or SPL if no TPL)?
>
> i.e., shouldn't the following code be enough:
>
> """
> static int rk3399_dmc_probe(struct udevice *dev)
> {
> #if defined(CONFIG_TPL_BUILD) || \
>         (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
>         if (rk3399_dmc_init(dev))
>                 return 0;
> #else
>         struct dram_info *priv = dev_get_priv(dev);
>
>         priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
>         debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> #endif
>         priv->info.base = CFG_SYS_SDRAM_BASE;
>         priv->info.size =
>                 rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
>
>         return 0;
> }
> """
> ?

Yes, that's the nub of it. Of course, it doesn't actually fix the
problem. I presume the SRAM appears in the page tables?

>
> Then what's after the endif could be guarded by if
> (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) { if we need to but it's not clear
> to me why that is needed?

Just to avoid increasing code size when the cache is off.

>
> Basically, I'm not sure the migration from ifdefs to the
> phase_sdram_init() function is necessary. I'm not against it, but it
> makes the whole thing much harder to read and hides the actual changes.

Yes well it would have been a lot better if I had put it in a separate
patch, which I forgot to do.

>
> Additionally, why was the cast to phys_addr_t changed to a ulong? The
> function actually expects a phys_addr_t.

Hmm that is something that we brought in for 32-bit machines. For
64-bit I don't really see why we are using it. It makes printf() hard.

But anyway, I should have left it alone :-)

>
> Finally, can you please explain why gd->ram_size being 0 is an issue for
> the caches, where is this checked? I'm not too familiar with the caches
> in general :)

It puts the MMU table just below the top of RAM which is currently
base + size (0 + 0) = somewhere like (4GB - 64KB).

Regards,
Simon
