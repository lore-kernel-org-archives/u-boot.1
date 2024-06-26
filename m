Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA7DC27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 14:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08BF788307;
	Wed, 26 Jun 2024 16:54:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EuM105rv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B4C8844F; Wed, 26 Jun 2024 16:54:50 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F15880AD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 16:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-700cc97b220so907352a34.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719413687; x=1720018487; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n6obnP/4dNCNaKP4Yaq2Ei6WxlRiVZS4kd6pnQrODkM=;
 b=EuM105rv3FgPDXMDb/uuA0lUu4NdJtbiPTIu8gG2r5AW6ivr7YdUNH75IyMxDlZwUI
 B9QlKjW7zqZoFq3JozXmy12GBXwvzOMmMiPYPf22e9d51UDr0sndgqCKbo+g+qebNodW
 iYrpDh+zalbDKEOyFx2je04EoxBYHAWFUd0eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719413687; x=1720018487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6obnP/4dNCNaKP4Yaq2Ei6WxlRiVZS4kd6pnQrODkM=;
 b=wLDxb7B+0W+0Bg3KiKIRjtEWMjik3YTwvyBRzKo/+fYX8tkL5AT1KC71gbdIPjftjd
 YXs446D2Ablez7vZ0bC+pkZ6iIcgz39J89d+ATFpxYddURamarOgXtJGPGBWSCXNoiQN
 t7MB27VszGVAXRGM08pJ+mqjcN0J24D7aVpoZcUb4CXvKkiL8i7QSvh5ss1sKvPi8MkZ
 zt6S86C3tx7cOC2QA0Uzwu14SOGds9gI8tZxb9hhq5/5wXfetuxhgF7IW3SnTfZ2twtK
 U6WKvyzSUnASYeQZMraiy9G6R4sqN/c2Ii4k2T4j+p6MRPy0ygk6gfYpmJX4BWuWKuri
 eqEA==
X-Gm-Message-State: AOJu0YwWL1luVXjIXpk9H2SMODmV45zYXI+wMxjqvW8Tk4y28JRUu6TH
 sxc81Bo5/0cJUPQZdMDbXSRlECkNS184LGwZ1OfAlLROmKIAONUKvTHAYvwfqKEXjK3VqMFrdyn
 ARPGLKj5cCP9ruC1yI06EsXzm/63mJ5qFEfWxlw5US1fSiLU=
X-Google-Smtp-Source: AGHT+IFxzt9d7zD3dD806+tGmz5c6s8HOrDlQxKnDwxVdQVt2fZuUERcfu8UoEm3Z3vKz35rN2j4Q/GULemhk7jOY8o=
X-Received: by 2002:a05:6830:6b84:b0:6f9:a3c6:a864 with SMTP id
 46e09a7af769-700b11b09b1mr10679220a34.10.1719413686709; Wed, 26 Jun 2024
 07:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240623175302.1463973-1-sjg@chromium.org>
 <20240623175302.1463973-15-sjg@chromium.org>
 <dc4f2532-4039-425f-8309-f62f73b5feaf@cherry.de>
In-Reply-To: <dc4f2532-4039-425f-8309-f62f73b5feaf@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 26 Jun 2024 15:54:36 +0100
Message-ID: <CAFLszTiwsc5qyYe2-Y_BxPhq8Dsintk7Tnt6ahn=X1UyDx2nag@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] rockchip: Avoid #ifdefs in RK3399 SPL
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
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

On Mon, 24 Jun 2024 at 09:24, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 6/23/24 7:53 PM, Simon Glass wrote:
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
> >   drivers/ram/rockchip/sdram_rk3399.c | 42 +++++++++++++++--------------
> >   1 file changed, 22 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> > index 3c4e20f4e80..949a082d00c 100644
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
> > @@ -3138,22 +3144,21 @@ static int rk3399_dmc_init(struct udevice *dev)
> >
> >       return 0;
> >   }
> > -#endif
> >
> >   static int rk3399_dmc_probe(struct udevice *dev)
> >   {
> >       struct dram_info *priv = dev_get_priv(dev);
> >
> > -#if defined(CONFIG_TPL_BUILD) || \
> > -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> > -     if (rk3399_dmc_init(dev))
> > -             return 0;
> > -#endif
> > -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > -     debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > +     if (phase_sdram_init()) {
> > +             if (rk3399_dmc_init(dev))
> > +                     return 0;
> > +     } else {
> > +             priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> > +             debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> > +     }
> > +
>
> I'm not sure we need to put the debug message into an else as this
> pmugrf is also used when dmc_init passes.
>
> Additionally, we could also just set priv->pmugrf before the if
> condition and remove it from dmc_init if we really wanted to.
>
> >       priv->info.base = CFG_SYS_SDRAM_BASE;
> > -     priv->info.size =
> > -             rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> > +     priv->info.size = rockchip_sdram_size((ulong)&priv->pmugrf->os_reg2);
> >
>
> Can you please say a few words about this change in the commit log? Why
> phys_addr_t->ulong here?

Oh dear, it keeps coming back! Removed now.

>
> Otherwise looks ok to me,
> Cheers,
> Quentin

Regards,
Simon
