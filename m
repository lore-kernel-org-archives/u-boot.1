Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2192FCF6499
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92C2C8891B;
	Sun, 29 Sep 2024 13:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kQNiUd6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C32889AE; Sun, 29 Sep 2024 13:49:07 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CB988770
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so24375306d6.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 04:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727610544; x=1728215344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NVPA6LlN46/XqXQGMrVvEbN+Nb7KvZItT/4sHTwi7Tw=;
 b=kQNiUd6RcNhkx2+1+0U8WI6+roN2EPgrNBakjelv8k95eQb2u99n/d1R96G8BpojgL
 uqH1T0ePwtXU9awIGmvldfVSSQ2cwmOKG9LrgxjVC9XL2NdFQktPs2XlH7d4gWgrNbeX
 17DW0uKNa7q0NyUoLAfpx14zTBG2p50eDO+4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727610544; x=1728215344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NVPA6LlN46/XqXQGMrVvEbN+Nb7KvZItT/4sHTwi7Tw=;
 b=RXOcQDYfQTxf9egimEsjd8Aiay0ayWhJDshYU5dQ/BWSJmHADHq72DtzjrzD5Nfqfh
 NQMycVmV+kJLadEHHs0mnw+SHQbStnTRtxz6qxlzcSQsq/n1PHaA0uibnVB2GmcOTWrx
 jV1U03nIEg+e1zt/2IeTna6m7iK+/vmsPAsXDbOiuB2ih94JZKox5yWsUQ+aHwHLocU9
 aG6fF+WpY3aeiybNNl7NGmELYaZrR3Z/Na/Gc1a6dry0sskN3acWl/7sP8DthueFLOj2
 AUhWuLFs02WVhQHup/XKdg6OXoHrS8UaD866PR52JXoThB5h9LqxcuAIaUd7nV9ipd+I
 fUow==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3mZJVuTY+ore2vGqCqmC90uLo8K5Y2PUe+I6KM1PVzIq/N4h4Y4LG6t6ZckPZzW6jtZPa/FY=@lists.denx.de
X-Gm-Message-State: AOJu0YwlG9aQJ9UsoGPw+Ep4Pex7zEN9FJbyJgEkpJFuQQbdqYoKkXbT
 0kpjsW3JTWxgViKemRchYUFD9olzED6A3U9PrUgBEonDyGZT7g5FQrclXrOXtnKhU+qxgTdXJVt
 T4FqFjWR/w96IOfZSD9ZPzptYOWNvB4SkpLzYRQt5Zmb31NJj5Q==
X-Google-Smtp-Source: AGHT+IE3YsDzMfdGZmZU47f2zdpvVi6jT4nLyauRd1vOJNfEXbhTN4G3/E/F/uwGG5dgfx+TJ0BgKqjMJ9IsEqzTCKA=
X-Received: by 2002:a05:6214:4497:b0:6cb:2186:275d with SMTP id
 6a1803df08f44-6cb3b5f7ef9mr162879206d6.26.1727610543891; Sun, 29 Sep 2024
 04:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-6-sjg@chromium.org>
 <1099eb05-949a-41ec-9ffd-fad4498224a6@kwiboo.se>
In-Reply-To: <1099eb05-949a-41ec-9ffd-fad4498224a6@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 13:48:53 +0200
Message-ID: <CAFLszThPOj_CdVa22xB7J-h=qatda_ePUhb-JiG6QH4n75DuVQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/30] global: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 29 Sept 2024 at 13:00, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-28 22:00, Simon Glass wrote:
> > Use the new symbol to refer to any 'SPL' build, including TPL and VPL
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
>
> [snip]
>
> > diff --git a/arch/arm/include/asm/arch-rockchip/boot0.h b/arch/arm/include/asm/arch-rockchip/boot0.h
> > index 0c375e543a5..edb2a31c348 100644
> > --- a/arch/arm/include/asm/arch-rockchip/boot0.h
> > +++ b/arch/arm/include/asm/arch-rockchip/boot0.h
> > @@ -12,7 +12,7 @@
> >   * To make life easier for everyone, we build the SPL binary with
> >   * space for this 4-byte header already included in the binary.
> >   */
> > -#ifdef CONFIG_SPL_BUILD
> > +#ifdef CONFIG_XPL_BUILD
> >       /*
> >        * We need to add 4 bytes of space for the 'RK33' at the
> >        * beginning of the executable.  However, as we want to keep
> > @@ -39,7 +39,7 @@ entry_counter:
> >       .word   0
> >  #endif
> >
> > -#if (defined(CONFIG_SPL_BUILD) || defined(CONFIG_ARM64))
> > +#if (defined(CONFIG_XPL_BUILD) || defined(CONFIG_ARM64))
> >       /* U-Boot proper of armv7 do not need this */
> >       b reset
> >  #endif
> > @@ -54,7 +54,7 @@ _start:
> >       ARM_VECTORS
> >  #endif
> >
> > -#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_SPL_BUILD) && \
> > +#if !defined(CONFIG_TPL_BUILD) && defined(CONFIG_XPL_BUILD) && \
>
> This is meant to be for SPL where TF-A is loaded into part of SRAM,
> and is only needed/used when CONFIG_TPL=n, so no need to replace it with
> XPL_BUILD.

I'm not sure if there is a misunderstanding here.

XPL_BUILD is the new SPL_BUILD, i.e. it means the same as SPL_BUILD
used to. So all occurrences of SPL_BUILD need to change to XPL_BUILD.

Before it was a bit unclear and murky as to what was intended,
particularly as apparently many people were not too sure of the real
meaning of SPL_BUILD. Resolving that is the intent of this rename.

Of course I think follow-up patches could tidy things up, now that we
have a 'real' SPL_BUILD (which means SPL and not also TPL, VPL). I
included some of those in the v1 series, but of course then people
wonder why they can't be squashed into the rename, so it just confuses
the whole process.

So my goal with this patch is to completely rename everything.


>
> >       (CONFIG_ROCKCHIP_SPL_RESERVE_IRAM > 0)
> >       .space CONFIG_ROCKCHIP_SPL_RESERVE_IRAM /* space for the ATF data */
> >  #endif
> > diff --git a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> > index 49a1f763795..ae273de3144 100644
> > --- a/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> > +++ b/arch/arm/include/asm/arch-rockchip/cru_rv1126.h
> > @@ -11,7 +11,7 @@
> >  #define KHz          1000
> >  #define OSC_HZ               (24 * MHz)
> >
> > -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> > +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> >  #define APLL_HZ              (1008 * MHz)
> >  #else
> >  #define APLL_HZ              (816 * MHz)
> > @@ -20,7 +20,7 @@
> >  #define CPLL_HZ              (500 * MHz)
> >  #define HPLL_HZ              (1400 * MHz)
> >  #define PCLK_PDPMU_HZ        (100 * MHz)
> > -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> > +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> >  #define ACLK_PDBUS_HZ        (396 * MHz)
> >  #else
> >  #define ACLK_PDBUS_HZ        (500 * MHz)
> > @@ -32,7 +32,7 @@
> >  #define HCLK_PDCORE_HZ       (200 * MHz)
> >  #define HCLK_PDAUDIO_HZ      (150 * MHz)
> >  #define CLK_OSC0_DIV_HZ      (32768)
> > -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> > +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> >  #define ACLK_PDVI_HZ (297 * MHz)
> >  #define CLK_ISP_HZ   (297 * MHz)
> >  #define ACLK_PDISPP_HZ       (297 * MHz)
> > @@ -324,7 +324,7 @@ enum {
> >       DCLK_VOP_DIV_SHIFT      = 0,
> >       DCLK_VOP_DIV_MASK       = 0xff,
> >
> > -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> > +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> >       /* CRU_CLK_SEL49_CON */
> >       ACLK_PDVI_SEL_SHIFT     = 6,
> >       ACLK_PDVI_SEL_MASK      = 0x3 << ACLK_PDVI_SEL_SHIFT,
> > @@ -397,7 +397,7 @@ enum {
> >       CLK_GMAC_SRC_DIV_SHIFT  = 0,
> >       CLK_GMAC_SRC_DIV_MASK   = 0x1f << CLK_GMAC_SRC_DIV_SHIFT,
> >
> > -#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> > +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_KERNEL_BOOT)
> >       /* CRU_CLK_SEL68_CON */
> >       ACLK_PDISPP_SEL_SHIFT   = 6,
> >       ACLK_PDISPP_SEL_MASK    = 0x3 << ACLK_PDISPP_SEL_SHIFT,
>
> I am pretty sure all these are meant for SPL where it is possible to
> SPL_KERNEL_BOOT, so no need to replace these with XPL_BUILD.
>
> [snip]
>
> > diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
> > index 2d7d0f82a2f..edccb2a3980 100644
> > --- a/arch/arm/mach-rockchip/rk3399/rk3399.c
> > +++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
> > @@ -51,7 +51,7 @@ static struct mm_region rk3399_mem_map[] = {
> >
> >  struct mm_region *mem_map = rk3399_mem_map;
> >
> > -#ifdef CONFIG_SPL_BUILD
> > +#ifdef CONFIG_XPL_BUILD
> >
> >  #define TIMER_END_COUNT_L    0x00
> >  #define TIMER_END_COUNT_H    0x04
> > @@ -83,7 +83,7 @@ void rockchip_stimer_init(void)
> >  int arch_cpu_init(void)
> >  {
> >
> > -#ifdef CONFIG_SPL_BUILD
> > +#ifdef CONFIG_XPL_BUILD
> >       struct rk3399_pmusgrf_regs *sgrf;
> >       struct rk3399_grf_regs *grf;
> >
> > @@ -136,7 +136,7 @@ void board_debug_uart_init(void)
> >       struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
> >       struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
> >
> > -     if (IS_ENABLED(CONFIG_SPL_BUILD) &&
> > +     if (IS_ENABLED(CONFIG_XPL_BUILD) &&
>
> This should not be changed to XPL, this part is meant for SPL and does
> not even compile when CONFIG_TPL=y and TPL_BUILD is defined.

The existing code before this series builds fine, though. I did not
change it to SPL_BUILD...it has been that way for a while. I am
changing it to XPL_BUILD which (by the end of this series) means
exactly the same as SPL_BUILD used to.

>
> >           (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
> >            IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
> >               rk_setreg(&grf->io_vsel, 1 << 0);
> > @@ -169,7 +169,7 @@ void board_debug_uart_init(void)
> >  }
> >  #endif
> >
> > -#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
> > +#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
>
> Following is intended for SPL as can be observed from the !TPL_BUILD,
> please do not change this to XPL_BUILD.

These and following are similar comments, so I will skip them for now.

[..]

Regards,
Simon
