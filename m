Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8468AC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC7E88582;
	Fri, 21 Jun 2024 16:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h3kHBinA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2D3588582; Fri, 21 Jun 2024 16:58:13 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AAD88550
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6f97b836c42so1079624a34.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981890; x=1719586690; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H+g7JmdfcSGcLHhnPXk5g9o+Uw+tgop4opxdWtPXbag=;
 b=h3kHBinAuSlxcFG1Ia7TZpAPp/X6pVtskSxizH/zIvgha6yNwAWV8z8ENWE+zsfvu6
 3PDd7kDIDftJidLVKl6WQ1hzp3GutgWQi3nhQkvtFMp3PaGgFHLHYG4xQyulb+NoD2tD
 pvUjc1xks9ShT7kwRfyCQmsFRFeZQSsLKXOLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981890; x=1719586690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+g7JmdfcSGcLHhnPXk5g9o+Uw+tgop4opxdWtPXbag=;
 b=ensmJOhflxIqFnZezwQDpIW3MGQYdEJlrXEtdewROfansSmf5zlZGy5rTR+jHk92uL
 TdFAp1JlDz79RWljTh8XomsyKYtXFf5NH0er0ii0ipyCu6MsFBOedaCWoD8X37Ec4DVS
 B+RMwizybc8VEdqnQTeY5igCX0g2SGZjB/xvjwVkTY5TRTTH5TW7Lrw3s+olVPLpEb6k
 tVAyAebFkyh7PqjH6b4pgw1HBXZRJidcAPOyDQmb1idTOGt1LQD2Bn5rw/2dRj1PkzPA
 8Mc1GYjYXUTrRlHpWqAaTTefQZkgBmHwo+uoq1KT0JPwymFkf/Sr0vU9gG86PxW4mNjm
 2Kvw==
X-Gm-Message-State: AOJu0Yz/xbyMaavkMgT365Puy2/YbaMZVcM/TF9M2ZG1HD4U1F3uv+CT
 VcgLFL+gLl1gbBszBD+cTWYsvPLF4Asdmb8XYlAfk/txgRNG9RnDBc8fQoC9k4pPb94MGMPbh/R
 2KVQGI+q8N0JvZqNCALrGJZoV8+fjiVDTCpui
X-Google-Smtp-Source: AGHT+IH3KbYH6YW4XP1sktsMXgQEvJe5NOspb8bGGoGhcm5qaZEOS2LduVUiGCI55y6PHCO4f+VI+9O8GQLoima03OE=
X-Received: by 2002:a05:6830:4b9:b0:700:9dd6:956 with SMTP id
 46e09a7af769-7009dd609d1mr1804908a34.15.1718981890105; Fri, 21 Jun 2024
 07:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-17-sjg@chromium.org>
 <3dbe42b8-7f9d-4b67-b903-692860518461@kwiboo.se>
In-Reply-To: <3dbe42b8-7f9d-4b67-b903-692860518461@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:59 -0600
Message-ID: <CAFLszTgF9cBnQkLQX24yd-Z3KKoujkiwbBBP2c26vyOBbOaLtQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] rockchip: Avoid #ifdefs in RK3399 SPL
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
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

Hi Jonas,

On Fri, 21 Jun 2024 at 00:45, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-06-21 01:06, Simon Glass wrote:
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
> > Changes in v3:
> > - Split out the refactoring into a separate patch
> > - Drop the non-dcache optimisation, since the cache should normally be on
> >
> >  drivers/ram/rockchip/sdram_rk3399.c | 47 ++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 3c4e20f4e80..2f37dd712e7 100644
> > --- a/drivers/ram/rockchip/sdram_rk3399.c
> > +++ b/drivers/ram/rockchip/sdram_rk3399.c
> > @@ -13,6 +13,7 @@
> >  #include <log.h>
> >  #include <ram.h>
> >  #include <regmap.h>
> > +#include <spl.h>
> >  #include <syscon.h>
> >  #include <asm/arch-rockchip/clock.h>
> >  #include <asm/arch-rockchip/cru.h>
> > @@ -63,8 +64,6 @@ struct chan_info {
> >  };
> >
> >  struct dram_info {
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
> >  };
> > @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
> >                                       struct rk3399_sdram_params *params);
> >  };
> >
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> > -
> >  struct rockchip_dmc_plat {
> >  #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >       struct dtd_rockchip_rk3399_dmc dtplat;
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
> > +}
> > +
> >  static struct io_setting *
> >  lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
> >  {
> > @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
> >       struct rockchip_dmc_plat *plat = dev_get_plat(dev);
> >       int ret;
> >
> > -     if (!CONFIG_IS_ENABLED(OF_REAL))
> > +     if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
> >               return 0;
> >
> >       ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> > @@ -3138,22 +3144,24 @@ static int rk3399_dmc_init(struct udevice *dev)
> >
> >       return 0;
> >  }
> > -#endif
> >
> >  static int rk3399_dmc_probe(struct udevice *dev)
> >  {
> >       struct dram_info *priv = dev_get_priv(dev);
> >
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> > -     if (rk3399_dmc_init(dev))
> > -             return 0;
> > -#endif
> > -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > -     debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > -     priv->info.base = CFG_SYS_SDRAM_BASE;
> > -     priv->info.size =
> > -             rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> > +     if (phase_sdram_init()) {
> > +             if (rk3399_dmc_init(dev))
> > +                     return 0;
> > +     } else {
> > +             priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > +             debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > +     }
> > +
> > +     if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
>
> This check should be dropped, this driver intent is to initialize dram
> in first phase (normally TPL), and report the size to any other phase.

This whole patch can be dropped :-) Here I am just trying to avoid
code-size growth when the cache is off. But yes, it is not needed.

>
> The main need for phase_sdram_init() and disable of DCACHE can probably
> be avoided if bob/kevin can move to use separate TPL and SPL instead of
> doing both dram init and everything else in SPL.
>
> My best guess is that enabling of caches in SPL cause issue for bob and
> kevin because they only use SPL not TPL+SPL like (if I am not mistaken)
> all other Rockchip arm64 targets.
>
> Using SPL-only was not something I tested when caches was enabled in SPL.
>
> Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
> RK3399 boards?
>
> How U-Boot works on these chromebooks is still a mystery to me.
>
> When coreboot is involved it would only load U-Boot proper and SPL or
> TPL+SPL would never be involved at all?
>
> If I understand correctly SPL is only involved for bare metal boot, if
> this is the case then using TPL + back-to-brom to load SPL should
> probably work fine?, and would align all RK3399 boards to work in a
> similar way and reduce the need for special care/handling in the code.

These boards were the first rk3399 support we had in mainline, I
believe. Everything else came later but conversions were not done for
these existing boards.

I actually intensely dislike the back-to-brom stuff. If the ROM had an
actual API (mmc_read(), etc.) then that would be fine. But just
jumping back makes it hard to control what is going on.

It is interesting to hear that SPL-only is causing a problem. Do you
have any inkling of what that might be? I could take a look at
converting the boards to use TPL, but it does seem a bit sideways to
the issue here. Is the bootrom doing some magic, perhaps? Is there
decent documentation for the boot ROM these days?

Regards,
Simon
