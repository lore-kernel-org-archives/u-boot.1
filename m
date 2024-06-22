Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4623C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 13:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3302F87C86;
	Sat, 22 Jun 2024 15:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XjnWm7g+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E46CB87C86; Sat, 22 Jun 2024 15:36:13 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6207E879AF
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6f8d0a00a35so2743025a34.2
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719063370; x=1719668170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ma7nMJpSbNx/p8amK9Z/VOUQKY3Ji1FFv/eUKJIC3+Q=;
 b=XjnWm7g+8mePEmjKzNBNXVeiLcoiPdiaxnmHjktWwCBXFDR/xf45qxjwxYOqCuyVkw
 E/HYhw23wN0fGfX2GdiZwTjXGNg+H2zAJUtKK6stAqVia63YkCL5U72IokUNiiRWq1zF
 62axTrCqcar1n0xoxJAx/xN2gu7XYyo7h72cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719063370; x=1719668170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ma7nMJpSbNx/p8amK9Z/VOUQKY3Ji1FFv/eUKJIC3+Q=;
 b=STSm4wUqG3Hhn3VQc+CMTYovV31rWTdDWsUHkMfdsPAwDN1gWOlH8Np/Rd+RWcScHS
 CBhinuXcS6hsrSMgbATJ8ESWBt2Bu9461PC5I/uwuCqOQIzMxcLQU5WBlQm9Qc8fZenq
 RM1u5UJ7aMP1mS3kHArEsKIfFfE48wPnOSV3F4OkA//+yJP+jw4qbpmQpk6vYcIatTyT
 HBXzz6+ld8f6cOape5Q3JJsgFEi5EJLuk+p972UZovslqkGlUdi4wHZEA3DdNPdcV9bS
 G43CFfv0YACVeCrMWcQo4GWZrUrZJlzS8Wau46cxvDtCBEohgVyo4+PeBssQQC8hHYsq
 UY7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXikGiF0inFe1ka7alCsXUCrrTETgbfRNV1VgW59Jw3tlBGwGULjYrnjKccEuMSDGnSgyedfpLb+dRW1nh95EvId3bi/A==
X-Gm-Message-State: AOJu0Yx7VvrycjfpbTrqr30wjSvnCmF+EW00kun5lPWBAPDrshPWz6AB
 nac0DScUcchKBTQep026jHsMcl3RgtNYezUaXf8u6ybJDaHquYfyDeItu+wWw+WRfRPTwbvolET
 zMik+k9I0pK8PvJE3VbtDNQxz48r3PL9eLKvq
X-Google-Smtp-Source: AGHT+IHVEn45PApl+7Yw6ajzMLQ8wKcb/sX8NZ5PtK/RRgd6KKK16gaUXf4zgRoPvA1iJTFODGpbz2oteW4LifXxse0=
X-Received: by 2002:a05:6830:1e61:b0:6fa:1666:6366 with SMTP id
 46e09a7af769-700ac4be3demr938156a34.14.1719063369893; Sat, 22 Jun 2024
 06:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-17-sjg@chromium.org>
 <3dbe42b8-7f9d-4b67-b903-692860518461@kwiboo.se>
 <CAFLszTgF9cBnQkLQX24yd-Z3KKoujkiwbBBP2c26vyOBbOaLtQ@mail.gmail.com>
 <7fa48725-c965-4a41-bab1-74e987569855@rock-chips.com>
In-Reply-To: <7fa48725-c965-4a41-bab1-74e987569855@rock-chips.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 22 Jun 2024 07:35:59 -0600
Message-ID: <CAFLszTiJy0O8V-3uJTbehoAqsN5v8ZxwHDLDQi952z86eKtXcw@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] rockchip: Avoid #ifdefs in RK3399 SPL
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, Jeffy Chen <jeffy.chen@rock-chips.com>,
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

Hi Kever,

On Fri, 21 Jun 2024 at 21:49, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Simon,
>
> On 2024/6/21 22:57, Simon Glass wrote:
> > Hi Jonas,
> >
> > On Fri, 21 Jun 2024 at 00:45, Jonas Karlman <jonas@kwiboo.se> wrote:
> >> Hi Simon,
> >>
> >> On 2024-06-21 01:06, Simon Glass wrote:
> >>> The code here is confusing due to large blocks which are #ifdefed out.
> >>> Add a function phase_sdram_init() which returns whether SDRAM init
> >>> should happen in the current phase, using that as needed to control the
> >>> code flow.
> >>>
> >>> This increases code size by about 500 bytes in SPL when the cache is on,
> >>> since it must call the rather large rockchip_sdram_size() function.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>> Changes in v3:
> >>> - Split out the refactoring into a separate patch
> >>> - Drop the non-dcache optimisation, since the cache should normally be on
> >>>
> >>>   drivers/ram/rockchip/sdram_rk3399.c | 47 ++++++++++++++++-------------
> >>>   1 file changed, 26 insertions(+), 21 deletions(-)
> >>>
> >>> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
> >>> index 3c4e20f4e80..2f37dd712e7 100644
> >>> --- a/drivers/ram/rockchip/sdram_rk3399.c
> >>> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> >>> @@ -13,6 +13,7 @@
> >>>   #include <log.h>
> >>>   #include <ram.h>
> >>>   #include <regmap.h>
> >>> +#include <spl.h>
> >>>   #include <syscon.h>
> >>>   #include <asm/arch-rockchip/clock.h>
> >>>   #include <asm/arch-rockchip/cru.h>
> >>> @@ -63,8 +64,6 @@ struct chan_info {
> >>>   };
> >>>
> >>>   struct dram_info {
> >>> -#if defined(CONFIG_TPL_BUILD) || \
> >>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> >>>        u32 pwrup_srefresh_exit[2];
> >>>        struct chan_info chan[2];
> >>>        struct clk ddr_clk;
> >>> @@ -75,7 +74,6 @@ struct dram_info {
> >>>        struct rk3399_pmusgrf_regs *pmusgrf;
> >>>        struct rk3399_ddr_cic_regs *cic;
> >>>        const struct sdram_rk3399_ops *ops;
> >>> -#endif
> >>>        struct ram_info info;
> >>>        struct rk3399_pmugrf_regs *pmugrf;
> >>>   };
> >>> @@ -92,9 +90,6 @@ struct sdram_rk3399_ops {
> >>>                                        struct rk3399_sdram_params *params);
> >>>   };
> >>>
> >>> -#if defined(CONFIG_TPL_BUILD) || \
> >>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> >>> -
> >>>   struct rockchip_dmc_plat {
> >>>   #if CONFIG_IS_ENABLED(OF_PLATDATA)
> >>>        struct dtd_rockchip_rk3399_dmc dtplat;
> >>> @@ -191,6 +186,17 @@ struct io_setting {
> >>>        },
> >>>   };
> >>>
> >>> +/**
> >>> + * phase_sdram_init() - Check if this is the phase where SDRAM init happens
> >>> + *
> >>> + * Returns: true to do SDRAM init in this phase, false to not
> >>> + */
> >>> +static bool phase_sdram_init(void)
> >>> +{
> >>> +     return spl_phase() == PHASE_TPL ||
> >>> +         (!IS_ENABLED(CONFIG_TPL) && !spl_in_proper());
> >>> +}
> >>> +
> >>>   static struct io_setting *
> >>>   lpddr4_get_io_settings(const struct rk3399_sdram_params *params, u32 mr5)
> >>>   {
> >>> @@ -3024,7 +3030,7 @@ static int rk3399_dmc_of_to_plat(struct udevice *dev)
> >>>        struct rockchip_dmc_plat *plat = dev_get_plat(dev);
> >>>        int ret;
> >>>
> >>> -     if (!CONFIG_IS_ENABLED(OF_REAL))
> >>> +     if (!CONFIG_IS_ENABLED(OF_REAL) || !phase_sdram_init())
> >>>                return 0;
> >>>
> >>>        ret = dev_read_u32_array(dev, "rockchip,sdram-params",
> >>> @@ -3138,22 +3144,24 @@ static int rk3399_dmc_init(struct udevice *dev)
> >>>
> >>>        return 0;
> >>>   }
> >>> -#endif
> >>>
> >>>   static int rk3399_dmc_probe(struct udevice *dev)
> >>>   {
> >>>        struct dram_info *priv = dev_get_priv(dev);
> >>>
> >>> -#if defined(CONFIG_TPL_BUILD) || \
> >>> -     (!defined(CONFIG_TPL) && defined(CONFIG_SPL_BUILD))
> >>> -     if (rk3399_dmc_init(dev))
> >>> -             return 0;
> >>> -#endif
> >>> -     priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> >>> -     debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> >>> -     priv->info.base = CFG_SYS_SDRAM_BASE;
> >>> -     priv->info.size =
> >>> -             rockchip_sdram_size((phys_addr_t)&priv->pmugrf->os_reg2);
> >>> +     if (phase_sdram_init()) {
> >>> +             if (rk3399_dmc_init(dev))
> >>> +                     return 0;
> >>> +     } else {
> >>> +             priv->pmugrf = syscon_get_first_range(ROCKCHIP_SYSCON_PMUGRF);
> >>> +             debug("%s: pmugrf = %p\n", __func__, priv->pmugrf);
> >>> +     }
> >>> +
> >>> +     if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)) {
> >> This check should be dropped, this driver intent is to initialize dram
> >> in first phase (normally TPL), and report the size to any other phase.
> > This whole patch can be dropped :-) Here I am just trying to avoid
> > code-size growth when the cache is off. But yes, it is not needed.
> >
> >> The main need for phase_sdram_init() and disable of DCACHE can probably
> >> be avoided if bob/kevin can move to use separate TPL and SPL instead of
> >> doing both dram init and everything else in SPL.
> >>
> >> My best guess is that enabling of caches in SPL cause issue for bob and
> >> kevin because they only use SPL not TPL+SPL like (if I am not mistaken)
> >> all other Rockchip arm64 targets.
> >>
> >> Using SPL-only was not something I tested when caches was enabled in SPL.
> >>
> >> Maybe bob/kevin can be changed to also use TPL+SPL similar to all other
> >> RK3399 boards?
> >>
> >> How U-Boot works on these chromebooks is still a mystery to me.
> >>
> >> When coreboot is involved it would only load U-Boot proper and SPL or
> >> TPL+SPL would never be involved at all?
> >>
> >> If I understand correctly SPL is only involved for bare metal boot, if
> >> this is the case then using TPL + back-to-brom to load SPL should
> >> probably work fine?, and would align all RK3399 boards to work in a
> >> similar way and reduce the need for special care/handling in the code.
> > These boards were the first rk3399 support we had in mainline, I
> > believe. Everything else came later but conversions were not done for
> > these existing boards.
> >
> > I actually intensely dislike the back-to-brom stuff. If the ROM had an
> > actual API (mmc_read(), etc.) then that would be fine. But just
> > jumping back makes it hard to control what is going on.
> The logic of BootRom is very simple and very clear:
> - Read image from boot medium and check the availability(format of
> rockchip IDB,
>      which is packed by the mkimage rksd/rkspi);
> - Load TPL/dram init blob to the internal SRAM(size limit by the sram),
> and jump to the entry;
> - Back to bootRom with '0' return means the dram init success, bootRom
> will get next image for dram;
> - Read SPL image from boot medium to DDR start address(no size limit),
> and jump to the ddr entry;
> - The signature verify will be done for all the firmware load by bootRom
> if the secure boot feature is enabled;
> This model works for all Rockchip SoCs, although some SoCs have very
> limit SRAM size(only available
> for DRAM init) and some other SoCs like rk3399 have bigger SRAM size.

Thanks for the info. Is there a document that describes this exactly?
Some questions it should cover:

- What is the signature verification?
- What offsets are used?
- What memory addresses are things loaded to?
- What other values of 'back to bootRom' are supported?
- Is there a jump table listing available functions for U-Boot to call?
- How to call the ROM functions to read blocks from mmc, SPI, etc.

>
> Thanks,
> - Kever
> > It is interesting to hear that SPL-only is causing a problem. Do you
> > have any inkling of what that might be? I could take a look at
> > converting the boards to use TPL, but it does seem a bit sideways to
> > the issue here. Is the bootrom doing some magic, perhaps? Is there
> > decent documentation for the boot ROM these days?
> >
> > Regards,
> > Simon


Regards,
Simon
