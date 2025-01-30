Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0126C02190
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 10:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726D281F69;
	Thu, 30 Jan 2025 11:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k+YPOSa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 641D582099; Thu, 30 Jan 2025 11:32:17 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143C180C85
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 11:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso1179579276.0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738233134; x=1738837934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QOAuh5fR4Oz9Xh6rB8VKo+ZJXIMN4TYOAUeOsRZMqes=;
 b=k+YPOSa8uANVNLJ11hsiMqhbabeIgL/ZQGUVKROqth3bnr5pEV67jRAk5XumXFhh/y
 /Fk1htyZF8kGHTqGGSyiJJKw8FuIXGFZ026VLV3EjICJo3fIznslyyygXUwq+p5uny7a
 /Akh4Y2u7AoEveHoGbfZqXLHiyocHTZ/7C7oZSHjNS818QhfZx3bjKoffe067f/cZdg6
 gSSLPjDUzVtVr6JiMYioHhJu4HmaHJKdtrAahNIu3n2oRWUfb0HWoXoyMHqtDORriwTx
 tsaxIxIA7eKjJLwFKiaDlzWXwLhr7vFDg5GwGQUyEFfWFKXK6iiycZBtCFzzY95pjj88
 NdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738233134; x=1738837934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QOAuh5fR4Oz9Xh6rB8VKo+ZJXIMN4TYOAUeOsRZMqes=;
 b=U3SQh9LO2P31ICK66OPlZFeKKz7u4c64j+w5vVh44zHOk5P3mO7bNT21IiCWpOTkCv
 /N1mQCZuTW5rlTyJiJoFY+8C5oRazqhB2h3jjGyTdnPPc1tzfTs2u6w+B3E1xt/KgCq2
 Muf6WNiymPrl6KPfZ/xeGvLpAWW1EUxoIoaLkr36HfuIig4+GpLJJn91T5EFql5mrFTM
 IiF1rfbZvDDuAc96AjMz5DjO32HCedH+iqf8kvESE56rf0SbO8kAsIHu94tMwq3QDYt9
 rT29VU39QBX6pbsphYdGPVW1R7tR7JBO0K2U6Z/LZ/ayE7CorOCLCGqqmXw8V1WEJdn8
 v08Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhG8fDiVw4VAIdwiyab2F7Yh+wigY9loil+sRL+rW6aKk2WmoarwAlpIByYduLEp2MPUpDC1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzyf+bzFU/oTGWUZnvgvnUfLzlkMYUU+u33S/1noQtG+GOl8Aa
 Y8M/DuKnwkc1Dy8JaxzpkpipT8qlcNhoyOY9qjuAagmfPO34B0oTxWIIRCGp3SHcYJFTEkEhVTI
 4NgmZWMSKoKM0K/7Jpn+zj1VTFjNgspIowBGMNw==
X-Gm-Gg: ASbGncvOqViZOc0FzYlsBmydOrJ1xDy9i3EPbz2tlGMgmFhSqwYW9nWomhRaUw+PNb3
 7LE8D3vLh8hDC9hKVOcTOvY21/2hAIUln5ZdRgN9UXE+k0SyHYdDchBgxtW9MeowtYtXVpk+s
X-Google-Smtp-Source: AGHT+IFtNPN6bw7aPMXkV0VGqQ8yiTfGf9ddBw3Gt0C9P/cXDatMgOrInmd+o3REbaHU/a3U96FgIro+dcb0+DBMbNA=
X-Received: by 2002:a05:6902:1248:b0:e57:f9a6:18eb with SMTP id
 3f1490d57ef6-e58a4aa8364mr4895094276.4.1738233133786; Thu, 30 Jan 2025
 02:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <20250130072100.27297-4-ilias.apalodimas@linaro.org>
 <60b99e2f-a354-4449-bdd2-abba07615321@gmx.de>
In-Reply-To: <60b99e2f-a354-4449-bdd2-abba07615321@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 30 Jan 2025 12:31:37 +0200
X-Gm-Features: AWEUYZneqAvPvJoeoYE07SrCZ8I50ccKVT6Zf7p-_j9JFsqlsqSFoLnlxyjT83g
Message-ID: <CAC_iWjKEptv2wdJ7JB=6tF_Ar-_2qAvh-78wze7GwgdkA54pXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com
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

On Thu, 30 Jan 2025 at 12:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 1/30/25 07:20, Ilias Apalodimas wrote:
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
> >   arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
> >   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
> >   arch/arm/include/asm/system.h           |  3 ++-
> >   arch/arm/mach-snapdragon/board.c        |  2 +-
> >   4 files changed, 34 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index a4ca56c8ed42..60d0870013e8 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >    * The procecess is break-before-make. The target region will be marked as
> >    * invalid during the process of changing.
> >    */
> > -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> > +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
>
> The function description should be moved to the include or be completed
> here.
>

That's a preexisting function, but I can move it around on the next iteration

> >   {
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
> >   }
> >
> > +void mmu_set_attrs(phys_addr_t addr, size_t size, int type)
>
> Please, add a function description.
>
> The function should either be static or added to an include file.

Yea I will

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
> >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> >
> >   /*
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
> >   #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
> >   #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
> >   #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
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
> >   #endif
> >               {
> > @@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
> >                                       PTE_BLOCK_MEMTYPE(MT_NORMAL)    |
> >                                       PTE_BLOCK_OUTER_SHARE           |
> >                                       PTE_BLOCK_NS                    |
> > -                                     PTE_TYPE_VALID);
> > +                                     PTE_TYPE_VALID, true);
> >               }
> >       }
> >   }
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > index dbf9ab43e280..0a8ca19e45e9 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -287,8 +287,9 @@ void flush_l3_cache(void);
> >    * @emerg: Also map the region in the emergency table
> >    */
> >   void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> > -void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
> > +void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
>
> Please, add a function description.

Thanks
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> > +void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
> >   /*
> >    * smc_call() - issue a secure monitor call
> >    *
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
>
