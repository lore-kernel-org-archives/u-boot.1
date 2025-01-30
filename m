Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F4C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD7582012;
	Thu, 30 Jan 2025 10:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ifLoHTXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECED82027; Thu, 30 Jan 2025 10:20:57 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F52180C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e39779a268bso782091276.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 01:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738228854; x=1738833654; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NOiFjmjy0G2zxobn8Rs5RNWUP0PlKuG4k3cwHAXZLDg=;
 b=ifLoHTXP/b3il8lYkmWTD67ElgEMJf3Ij2L41OI3rzSE7guNW2HOFk3csOlPS/5DaJ
 gzTGd6V1I9LNG9gh1QoJH2imFKNB2FoqQ/ih4E9zXxjHJnlWKFUf9Zh0RjWZwPOdO7Zk
 Y6byilB158FW4u693MPRWHMfQxLcdZCAMRucGOdnKDhFpQv60Z8uDxJmGuqXud44B2ct
 ZxpItM/AgaCBog6KdWIK05CPfe7jHZ7j3IBolhcKWUMiQX147/Lw8HtxDM2uDQCy1edv
 aeE3IRIPB1xilX/aZDTUb24WG9L5Drauxqjm8xJc+UTWwEj6HJLmUSQ2Qs/DnAMIk/Ip
 N/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738228854; x=1738833654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NOiFjmjy0G2zxobn8Rs5RNWUP0PlKuG4k3cwHAXZLDg=;
 b=uOccAWGZSMv6MYK6Nnj5t1de5A+LLmxBuCL4QA6tvzuDknnBH3Xw+wzx3OVax7XC4a
 lx4r9p+rmtwlVa04tnGf9bHANV2/kJGb1jFB7U+o/LxTuUGkR6A+VpgqNKEHrQxM4THA
 q8HQTBFV6pFITyPceyHKlPzMdjUmlze3/1bgVV/XW/83iTPm47pxLXfgQSeRxb5wmTxi
 fqvt7uEc9w4WlHOvpE11xKne4/OKJmRzmRBjZkGNMOVPtOQBSt0n9ymI3uLWIVvMZTkR
 JPfRB9tUTAGwoU0sTh02NGl873wbwzEUqlIkZRBey6RQEVib4w6+MXUwNoJJp8g9Hs28
 oPlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL5FvAniSenK2vdbl72cfZCJPYNMEqjEyLHwVTHRiSxKiTDffStdIk4XhKtwaFU9B+1Ubx4wE=@lists.denx.de
X-Gm-Message-State: AOJu0Yygs+0gaCl6kmPL5dXIodasxP0mTw+4UT53ukmTLl0L3ayMkyuC
 YwXsZP69vwi+mRlh25qKmHLMptaBWqFLFtueSwJL611glRH1+A7wZMMxGt4SmRX8TmXhA1/npt6
 fD4p3XMFeJGoGRrrdOI8ZszIp31QWkclTxCKnMg==
X-Gm-Gg: ASbGncuV0unOt7SofYzMFIgkJvoZBV0cDgX3qOuN+ydJCo30/Jo0o2zvcYklZMc5UXY
 6yFDqfJmZTtcFEr19ZB5DkGJ0qHxxVPGJLVk/lFka1YzgJ+afhtMCwbTQiGjs4NXCsyw0nqZ5
X-Google-Smtp-Source: AGHT+IGuMWS302JyRWl+l7ouVG2VT1+Tnyp4nnENJe5nKET49kJChun/ObgmzONK3BpfruppD+XDDARZRFwhNNmjbBg=
X-Received: by 2002:a05:6902:218b:b0:e59:a174:85e7 with SMTP id
 3f1490d57ef6-e5ac895d46fmr2225003276.17.1738228853857; Thu, 30 Jan 2025
 01:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-4-ilias.apalodimas@linaro.org>
 <2d16982b-1f7e-4fca-817c-d929ec3f598a@linaro.org>
In-Reply-To: <2d16982b-1f7e-4fca-817c-d929ec3f598a@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 11:20:17 +0200
X-Gm-Features: AWEUYZkRkcfm82glZdl_Wo323QWVic9KrVlqkvUhaj8KS8dRbVuKKQITtzu1A8w
Message-ID: <CAC_iWjLfc1PLARLAB1sTvi3QRwGY0ZpmNurDWPqNfRa8oajqaQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
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

Hi Jerome,

On Thu, 30 Jan 2025 at 11:11, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Ilias,
>
> On 1/30/25 08:20, Ilias Apalodimas wrote:
> > The ARM ARM on section 8.17.1 describes the cases where
> > break-before-make is required when changing live page tables.
> > Since we can use this function to tweak block and page permssions,
> > where BBM is not required add an extra argument to the function.
> >
> > While at it add a function we can use to change the attributes of normal
> > memory without breaking the pages tables first
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
> >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
> >  arch/arm/include/asm/system.h           |  3 ++-
> >  arch/arm/mach-snapdragon/board.c        |  2 +-
> >  4 files changed, 34 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index a4ca56c8ed42..60d0870013e8 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >   * The procecess is break-before-make. The target region will be marked as
> >   * invalid during the process of changing.
> >   */
> > -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> > +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
> >  {
> >       int level;
> >       u64 r, size, start;
> >
> > +     if (!bbm)
> > +             goto skip_bbm;
> > +
> >       start = addr;
> >       size = siz;
> >       /*
> > @@ -997,6 +1000,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> >                          gd->arch.tlb_addr + gd->arch.tlb_size);
> >       __asm_invalidate_tlb_all();
> >
> > +skip_bbm:
> >       /*
> >        * Loop through the address range until we find a page granule that fits
> >        * our alignment constraints, then set it to the new cache attributes
> > @@ -1020,6 +1024,27 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> >       __asm_invalidate_tlb_all();
> >  }
> >
> > +void mmu_set_attrs(phys_addr_t addr, size_t size, int type)
>
> type should be an enum

yea, I mentioned that in the cover letter.

Thanks!
/Ilias
>
> > +{
> > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > +
> > +     switch (type) {
> > +     case 1:
> > +     /* RO */
> > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > +             break;
> > +     case 2:
> > +             /* RX */
> > +             attrs |= PTE_BLOCK_RO;
> > +             break;
> > +     case 3:
> > +             /* RW */
> > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > +     }
> > +
> > +     mmu_change_region_attr(addr, size, attrs, false);
> > +}
> > +
> >  #else        /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> >
> >  /*
> > diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > index d2d3e346a36f..caf1dab05936 100644
> > --- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > +++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
> > @@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >       } else {
> >               mmu_change_region_attr(
> >                                       CFG_SYS_SDRAM_BASE,
> > @@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >  #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
> >  #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
> >  #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
> > @@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >                       mmu_change_region_attr(
> >                                       CONFIG_SYS_DDR_BLOCK3_BASE,
> >                                       gd->ram_size -
> > @@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >               } else
> >  #endif
> >               {
> > @@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >               }
> >       }
> >  }
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > index dbf9ab43e280..0a8ca19e45e9 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -287,8 +287,9 @@ void flush_l3_cache(void);
> >   * @emerg: Also map the region in the emergency table
> >   */
> >  void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> > -void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
> > +void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
> >
> > +void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
> >  /*
> >   * smc_call() - issue a secure monitor call
> >   *
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> > index 2ef936aab757..13f4e8e640ef 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
> >               if (i == count || start + size < res[i].start - SZ_2M) {
> >                       debug("  0x%016llx - 0x%016llx: reserved\n",
> >                             start, start + size);
> > -                     mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
> > +                     mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
> >                       /* If this is the final region then quit here before we index
> >                        * out of bounds...
> >                        */
