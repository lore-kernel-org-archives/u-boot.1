Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16167C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74E1805D7;
	Wed, 12 Mar 2025 06:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VW+GKvVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D846811C1; Tue, 11 Mar 2025 19:45:28 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C157807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 19:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e634c42a296so4407081276.3
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741718724; x=1742323524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=McGa6ujeybnHiIqp5b00DLI5A+FKlgDZcOuADqsX5oo=;
 b=VW+GKvVn8voy7NcAQt5jNCKhhEjDEXcLJHyHZg/aMHn87Aszy1X8+VaSMkbaxVJrRG
 HGF6sPbkxWVUx4hnKXEpjMcGbF2XcBKDUh3qGC1PFcWP5Q5y9HWe4hc4aoQIUaq4PlP9
 cYNnoQ5tWZJgIxlcKHQzEgvwiSurkormrgetMWGhDMQTm256nwcYzRKe/vkdBH0kzwSE
 bxUKWRMVa6vSV3uquctGVnfk/i00t+JlDjQ5iEXKYB+YLkV6CWjr7/BvNbImxgo+S5U5
 md0DTLnONn3uCjJaF4ArwVpioySr9IHeiL2Zj1U8P/R83RBFbz8wc0JmxCl0vtv3XfdV
 0Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741718724; x=1742323524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McGa6ujeybnHiIqp5b00DLI5A+FKlgDZcOuADqsX5oo=;
 b=sAJeHDzSTCoRO5TmYiee7U47RI0llXa5GeFq5vWE5HPoXm2kEOxdBNAh39n0zPCvb0
 6uH1xaw9ZHZgl3RyaHyaCBByAFfsOh4yvr1hI/6lwWbkX8WIafMHwKXnA0aGwqxcZhCY
 UIeG1fG5SSEiY9cqPYGf+nDYSwuVQAawbdRnYerSJRi2MK5VKpGcXMDN+SWkP2LfqvP6
 WImNYuLwJRFqPQyklLee2ieXUQ2mR1LWNAQhc36k/LVz466w0PqLEIXCuffiw509XeKN
 TJZYsXuQQpalV14y1B0UZRs/BSX18BAB5l75+mD+RBjakuF2GjQbuSJtRUeUsyWYaXru
 Sd2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckk27+JF3L2y1T5/FAeSyyq58NECq0cD8yPP89ibvYlmFNb9ExBSuFiMEnumnoTLUsXNsQ2Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyRjZRIZ78vO1FqDRyG0S9LtdTmmhMX3PMyJDAn0/+SMSU5k6Tp
 dt6bzzv4pjaEbkyhZYiTWIWO+T0ymjNyfSlUcYvKYpPKR3iSN+7iYrRQoFYwffvPzKUAwG9cY48
 w58ao5Bn2BNVtlNPjbcXKfJp3PFBfUihCJcbulg==
X-Gm-Gg: ASbGnct8LQU14DFmI2TMEN3SOre3Tt9ROmYETFLQbU8LUT+GEWXH1tubGGE6zROL/yd
 TjPX3fgMd6J+rtiGw2cvaRzz6sMPI1dpE38DCaQyLXe52Hz31Bp82UCvx63Nv3LKIHS6oNYzw+7
 5glf0IhnNoJY8PAyNehmo3QpHD/NU=
X-Google-Smtp-Source: AGHT+IEZUObAwc/eU6LxHpDuIiQ8Dh6HjdHRQs3UtHxmZv2SPmO7n0M4B8KQ7I5jiKJoUMxpZRtvAwPQT4yUFSNqS7o=
X-Received: by 2002:a05:6902:2002:b0:e5d:aeb7:6e62 with SMTP id
 3f1490d57ef6-e63b51589a0mr5673492276.7.1741718724104; Tue, 11 Mar 2025
 11:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
 <20250301164922.397441-5-ilias.apalodimas@linaro.org>
 <20250311183054.38dc735e@donnerap.manchester.arm.com>
In-Reply-To: <20250311183054.38dc735e@donnerap.manchester.arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 20:44:48 +0200
X-Gm-Features: AQ5f1JrJQqaOhZyDCOvo2Zlqpu_2XAJw1p65p2qhJhqOcqWVdjGM1eRTjKVe1xA
Message-ID: <CAC_iWjKMz-SH-hOOiuDX4PVYkJT4WkGAkQPdaqELrUWRrMr==w@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: mmu_change_region_attr() add an option not
 to break PTEs
To: Andre Przywara <andre.przywara@arm.com>
Cc: xypron.glpk@gmx.de, mark.kettenis@xs4all.nl, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini <trini@konsulko.com>, 
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, 
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 12 Mar 2025 06:42:09 +0100
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

Hi Andre,

On Tue, 11 Mar 2025 at 20:31, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Sat,  1 Mar 2025 18:49:02 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> Hi Ilias,
>
> > The ARM ARM on section 8.17.1 describes the cases where
>
> Thanks for referencing the ARM ARM! The section name would be D8.17.1, and
> please mention the version of the document, since the numbering is not
> stable across the different releases. So something like:
>
> The ARM ARM (Rev L.a) in section D8.17.1 ("Using break-before-make when
> updating translation table entries") ...

Sure

>
> > break-before-make is required when changing live page tables.
> > Since we can use this function to tweak block and page permssions,
> > where BBM is not required add an extra argument to the function.
>
> It looks like one of the two existing users of this function (the
> snapdragon code) just calls this function with attr=PTE_TYPE_FAULT, so
> that would not need to call the full BBM version.
> The Layerscape code indeed requires it, though.

Yep, I'll leave it up the qualcomm maintainers to pick that

>
> > While at it add a function description.
>
> I think these sentences describe the v2 and older, but don't fit the
> current patch anymore.
>
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c | 48 ++++++++++++++++++++---------------
> >  arch/arm/include/asm/system.h | 18 +++++++++++++
> >  2 files changed, 46 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index c4b3da4a8da7..29100913bc82 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -967,61 +967,69 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
> >       flush_dcache_range(real_start, real_start + real_size);
> >  }
> >
> > -/*
> > - * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
> > - * The procecess is break-before-make. The target region will be marked as
> > - * invalid during the process of changing.
> > - */
> > -void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> > +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
> >  {
> >       int level;
> >       u64 r, size, start;
> >
> > -     start = addr;
> > -     size = siz;
> >       /*
> >        * Loop through the address range until we find a page granule that fits
> > -      * our alignment constraints, then set it to "invalid".
> > +      * our alignment constraints, then set it to the new cache attributes
>
> It's not cache attributes (those would require BBM), but "permissions" or
> just attributes.

Yep correct

>
> Otherwise this looks correct, just changing the permission indeed does not
> require BBM, so it's just the comment and the commit message that might
> need changing. And clever function split up!

That was what Richard requested, the initial one was just taking a
bool argument, but this is indeed better

Since it's only commit message changes, if n one else objects, I'll
amend it on my PR to Tom

Thanks for taking the time
/Ilias
>
> Cheers,
> Andre
>
> >        */
> > +     start = addr;
> > +     size = siz;
> >       while (size > 0) {
> >               for (level = 1; level < 4; level++) {
> > -                     /* Set PTE to fault */
> > -                     r = set_one_region(start, size, PTE_TYPE_FAULT, true,
> > -                                        level);
> > +                     /* Set PTE to new attributes */
> > +                     r = set_one_region(start, size, attrs, true, level);
> >                       if (r) {
> > -                             /* PTE successfully invalidated */
> > +                             /* PTE successfully updated */
> >                               size -= r;
> >                               start += r;
> >                               break;
> >                       }
> >               }
> >       }
> > -
> >       flush_dcache_range(gd->arch.tlb_addr,
> >                          gd->arch.tlb_addr + gd->arch.tlb_size);
> >       __asm_invalidate_tlb_all();
> > +}
> > +
> > +/*
> > + * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
> > + * The procecess is break-before-make. The target region will be marked as
> > + * invalid during the process of changing.
> > + */
> > +void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
> > +{
> > +     int level;
> > +     u64 r, size, start;
> >
> > +     start = addr;
> > +     size = siz;
> >       /*
> >        * Loop through the address range until we find a page granule that fits
> > -      * our alignment constraints, then set it to the new cache attributes
> > +      * our alignment constraints, then set it to "invalid".
> >        */
> > -     start = addr;
> > -     size = siz;
> >       while (size > 0) {
> >               for (level = 1; level < 4; level++) {
> > -                     /* Set PTE to new attributes */
> > -                     r = set_one_region(start, size, attrs, true, level);
> > +                     /* Set PTE to fault */
> > +                     r = set_one_region(start, size, PTE_TYPE_FAULT, true,
> > +                                        level);
> >                       if (r) {
> > -                             /* PTE successfully updated */
> > +                             /* PTE successfully invalidated */
> >                               size -= r;
> >                               start += r;
> >                               break;
> >                       }
> >               }
> >       }
> > +
> >       flush_dcache_range(gd->arch.tlb_addr,
> >                          gd->arch.tlb_addr + gd->arch.tlb_size);
> >       __asm_invalidate_tlb_all();
> > +
> > +     mmu_change_region_attr_nobreak(addr, siz, attrs);
> >  }
> >
> >  #else        /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> > index 091082281c73..849b3d0efb7a 100644
> > --- a/arch/arm/include/asm/system.h
> > +++ b/arch/arm/include/asm/system.h
> > @@ -303,8 +303,26 @@ void flush_l3_cache(void);
> >   * @emerg: Also map the region in the emergency table
> >   */
> >  void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
> > +
> > +/**
> > + * mmu_change_region_attr() - change a mapped region attributes
> > + *
> > + * @start: Start address of the region
> > + * @size:  Size of the region
> > + * @aatrs: New attributes
> > + */
> >  void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
> >
> > +/**
> > + * mmu_change_region_attr_nobreak() - change a mapped region attributes without doing
> > + *                                    break-before-make
> > + *
> > + * @start: Start address of the region
> > + * @size:  Size of the region
> > + * @aatrs: New attributes
> > + */
> > +void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs);
> > +
> >  /*
> >   * smc_call() - issue a secure monitor call
> >   *
>
