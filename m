Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825F4C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 18:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF52D80C8F;
	Thu,  6 Feb 2025 19:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CQdfTmXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DE980AE1; Thu,  6 Feb 2025 16:16:10 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CBD3806FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 16:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so833839276.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854966; x=1739459766; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V4ztT4KxDk4XPT0mKlx2qVG0asnq2oKYW2YrnFsqbEs=;
 b=CQdfTmXt+J7fyn7KjlIr0ycAen0U4QZyMsLiqDbyUywfGAf9fPZC0SQh28LMwhbg7L
 fT3Q+sfYeOKk3wttfnJ7e8lVej1BKa4WFyEj+mwZydFDHNc+flGbr0jy++1gwt4xov8i
 IjApGU6HYdh4d8ExXk2byRY28U1XLs8cDXM66AypChVI8NzrHWVWKWATSZcJFda0Jx85
 IqzItrY+8uvqhTtVhDSv17NBAguBxJ54IIwO210lGMe+e2nZ9apE1g2PjGxUI2yczBjb
 zKMtCiDMbyBODTIS+uXnjl+12pWyHPKh/7VPwpaVFBsIvaJiEyLhfxrdBWamxS/jEQyx
 A3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854966; x=1739459766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V4ztT4KxDk4XPT0mKlx2qVG0asnq2oKYW2YrnFsqbEs=;
 b=q9fgB/DHeYHu5oeEAnzLXSL3IdR9Ora2/PT2F9Zg6lUFENRhTR3cHaS4cb3FgYHkV/
 lvpl5xM61x1bTVkexAZdMy6Ek/Ce/sJ0xGll95A8b1/HEK5VUZBUhwTTdppCWCqglbbI
 6nrA4nkRiLyvRtPvv5TQxih/7EOeZA9jpnOYp9KVT3PtiYIhnDfESJUkIPGCGKYrmNdL
 rkTS5hrPeW3eqfkxrqOZGrHUa4EXaI0HB9vGBT0Xvc5maYvTn1O7ptGTG3g+Tl3a4z62
 XPQidEug5ODy4WFx87dWwx4IGS0EKlVrmld9th/52UXgZf6iu1OWp2xT6OYgaY7aTIQ2
 sC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+I2EzsaWdi/rb0/KR4jvugqb6s/xm/IOxh76aS+DZtaBrOoVFNvYwXR9b719a8L+CjF1rOyU=@lists.denx.de
X-Gm-Message-State: AOJu0YyXGQ40qWNJrwVS3wn1Mnz5bwT9Aqbcq85+7KQD2h6O2yyNjFbX
 jnq34JRBdaOr5IHKDwc8btMKaPryqSvhUjsbUFVXQVDuPtw+xTBXIhhutIEO+NAS88AwJSF4IL9
 iLGUixTfjKKZC800oqu6ZCPlL6yaEMUIX6SqR3Q==
X-Gm-Gg: ASbGncv2EBUeDZv/SsEXRq6a7VRMToC8COLp9vaYIc0EOiC9GUwLVy62M/rj8+SDVcK
 /TlewdNjM0Y32XxXGVpUlCuBbZTwgjvSpaWAj89UhZX8/QdlCS+6KtFTuhibeDA9x01LtvNLtQQ
 ==
X-Google-Smtp-Source: AGHT+IGPb78hmorbvOwL8/h83Dw9Y/nn+QZsmdGpL2HEIf5ssUvPzmjifjjPGBQF1VDdqMbUMy+o/rWT3hV4U81XSe0=
X-Received: by 2002:a05:6902:723:b0:e38:a15d:4082 with SMTP id
 3f1490d57ef6-e5b3523b9b3mr3664234276.5.1738854966117; Thu, 06 Feb 2025
 07:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
In-Reply-To: <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Feb 2025 17:15:30 +0200
X-Gm-Features: AWEUYZn2mVWyu_wOl0HdIcyThs9l3BBK-5I3LxU_S1f18otDuNOGKg6d54PFzk8
Message-ID: <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Peng Fan <peng.fan@nxp.com>, Richard Henderson <richard.henderson@linaro.org>, 
 Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Joshua Watt <jpewhacker@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Feb 2025 19:58:54 +0100
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

On Thu, 6 Feb 2025 at 14:58, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 6 Feb 2025 at 05:52, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 6 Feb 2025 at 14:30, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Heinrich,
> > > >
> > > > On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > >
> > > > > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > > > > For armv8 we are adding proper page permissions for the relocated U-Boot
> > > > > > binary. Add a weak function that can be used across architectures to change
> > > > > > the page permissions
> > > > > >
> > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > ---
> > > > > >   arch/arc/lib/cache.c           |  2 ++
> > > > > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > > > > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > > > > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > > > > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > > > > >   arch/arm/lib/cache.c           |  2 ++
> > > > > >   arch/m68k/lib/cache.c          |  2 ++
> > > > > >   arch/nios2/lib/cache.c         |  2 ++
> > > > > >   arch/powerpc/lib/cache.c       |  2 ++
> > > > > >   arch/riscv/lib/cache.c         |  2 ++
> > > > > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > > > > >   arch/xtensa/lib/cache.c        |  2 ++
> > > > > >   include/cpu_func.h             | 16 ++++++++++++++++
> > > > > >   13 files changed, 59 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > > > > index 5169fc627fa5..5c79243d7223 100644
> > > > > > --- a/arch/arc/lib/cache.c
> > > > > > +++ b/arch/arc/lib/cache.c
> > > > > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > > > > >
> > > > > >       __ic_entire_invalidate();
> > > > > >   }
> > > > > > +
> > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > index 5b87a3af91b2..857311b3dfad 100644
> > > > > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > > > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > > > > >       dcache_enable();
> > > > > >   #endif
> > > > > >   }
> > > > > > +
> > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > index d11420d2fdd0..14c9be77db8d 100644
> > > > > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > > > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > > > > >   __weak void v7_outer_cache_inval_all(void) {}
> > > > > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > > > > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > > > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > > > > > index b6d08b7aad73..458a214e9577 100644
> > > > > > --- a/arch/arm/cpu/armv7m/cache.c
> > > > > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > > > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > > > > >       dcache_enable();
> > > > > >   #endif
> > > > > >   }
> > > > > > +
> > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > index 670379e17b7a..1cf3870177ee 100644
> > > > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > @@ -1028,6 +1028,28 @@ skip_break:
> > > > > >       __asm_invalidate_tlb_all();
> > > > > >   }
> > > > > >
> > > > > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > > > > +{
> > > > > > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > > > > > +
> > > > > > +     switch (perm) {
> > > > > > +     case MMU_ATTR_RO:
> > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > > > > > +             break;
> > > > > > +     case MMU_ATTR_RX:
> > > > > > +             attrs |= PTE_BLOCK_RO;
> > > > > > +             break;
> > > > > > +     case MMU_ATTR_RW:
> > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > > > > +             break;
> > > > > > +     default:
> > > > > > +             log_err("Unknown attribute %llx\n", perm);
> > > > > > +             return;
> > > > > > +     }
> > > > > > +
> > > > > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > > > > +}
> > > > > > +
> > > > > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > > > > >
> > > > > >   /*
> > > > > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > > > > index 516754caeaf9..c7704d8ee354 100644
> > > > > > --- a/arch/arm/lib/cache.c
> > > > > > +++ b/arch/arm/lib/cache.c
> > > > > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > > > > >
> > > > > >       return 0;
> > > > > >   }
> > > > > > +
> > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > >
> > > > > I would prefer if the weak function would return -ENOSYS indicating the
> > > > > missing implementation and the real function would return 0 in case of
> > > > > success or an error code on failure. This way the EFI protocol could set
> > > > > the return code if the architecture does not provide support for setting
> > > > > the attributes the passed addresses are invalid.
> > > >
> > > > Sure I'll change that in v2
> > >
> > > Instead of a weak function could you define an API for it, including
> > > structs for the information, a command to adjust it, tests, etc? This
> > > needs a little more thought.
> > >
> > > How about adding to cpu_ops and the information there? The cpu_func.h
> > > which is supposed to be deprecated.
> >
> > Looking at it, I think it's easier as well. I can add move that
> > function in cpu_ops, so it becomes NULL for other architectures. But
> > since this patchset is doing enough already, I'll just move that. In
> > the future, we can move all the cache* and mapping* functions there as
> > well
>
> That sounds great, thank you. I suspect that RISC-V will follow your lead here.

I wrote the code but cpu uclass isn't even close to doing what we want.
Grepping for defined boards with a cpu uclass driver for arm gives me
back < 20 boards. Given the fact we already found 3 bugs with this
patch applied, I prefer to have a wider coverage and fix U-Boot.
I've uploaded the uclass version here [0], once more boards decide to
use it I will be happy to switch to that, but unfortunately for now,
I'll am obliged to keep the weak function definition.

[0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions_uclass?ref_type=heads

Thanks
/Ilias

>
> Regards,
> Simon
