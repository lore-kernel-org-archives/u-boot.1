Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F68C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2416280C58;
	Thu,  6 Feb 2025 14:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGa1aFVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD8A80AE5; Thu,  6 Feb 2025 13:58:24 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD31980BA3
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so9619855e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738846697; x=1739451497; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z+58eoaCxkosE7QZ7FX6A8VBs+Pzr1Nq167JJcs+HJQ=;
 b=AGa1aFVWC8vTXxC64R0fWMBsRf8elr9dF+t4m1znNw47ae2i6J1vA7BkpfVlqAXb2k
 KzjRwEccv8wI7+7LRnM2cLweKqOedfIDnz5vy/88FyirOT/I55p7O2DyNAcoJXx/W06Y
 hibupG0JzzIIKKm3kbGnSkIZrmQKVx3KoMMdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738846697; x=1739451497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z+58eoaCxkosE7QZ7FX6A8VBs+Pzr1Nq167JJcs+HJQ=;
 b=LUtJfXWLg2tGGYqU+7jDpWVXfLjD6AUCI8T1qh1d32v3001WfJW6bOmzekE5YJscqz
 6Rpj7E51OZl9l6xqevbgDeTP5v/SWPsLuE+Jj6Rkg6ssS5eZEie/8lg7sF7+gIG/rVhx
 z+uH9c9v0nqT+z4LREHbBfxDNkBdIaot4OWKH3ry0injzgJrZNS4QFwLbfQY4/MwEXVh
 z7ri3alFAaeqJqcbJTaOSoO9IYzsfFinD88JifdtGVN/Xcglk6U2Wc7bBtZxGlEsOt6y
 N+xPnyaZ6Paw2GbN4bU6B9f6FlebpBNSwGCWZsppgS9m8SRs6Aad60hh56sTkvOYcfv2
 DDnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiyyZOfWD4sPqxPFF4tkeV3mrkkDxdnpFxR+HzD6y1/ZV5bICLWwQUe9EUYUYdP3fXiu/+11o=@lists.denx.de
X-Gm-Message-State: AOJu0YzBJ18+2odFLQCYBMhYg1ZCwCDrmsbOTBuStFbAXop90F2259Em
 HV71CzUzqzgDWUQxMORMrnUeTSIFomN2jz2QD9GhZRD+8zTkXxbl5Lvt3/q/t7KLnpCrm+f+xST
 kJnUhhs4gknneFaH1kgemoUOkKaaTb87RlA5m
X-Gm-Gg: ASbGncs3yGzwK0tF+dTgCgv40sZiH9UNA8BVzgvzDi3QyFJ3qv6J1CwtdUf4gEWoOHB
 Rdjc7dj+54KrKosqvQuijIrc1E9pmYV3JJ2d39zmexQnltYaAOJAT1vz0chf4s16L7JlMHtm9sA
 ==
X-Google-Smtp-Source: AGHT+IHwznOeVrgkh5EL3TKS3DDB+NNbGaXClOJvanlWT8oRnnGjqJQspBoOZttLZQop0tOz5ENK5pIaWL6hBPJe+5s=
X-Received: by 2002:a5d:524f:0:b0:38b:ec2d:c0cf with SMTP id
 ffacd0b85a97d-38db491062cmr5798388f8f.44.1738846697151; Thu, 06 Feb 2025
 04:58:17 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
In-Reply-To: <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:58:05 -0700
X-Gm-Features: AWEUYZm0zpQgWN3QRHX7KNurw2iAaOc2FrKowRENM428k-JVd2o0Txn2-wo8gjE
Message-ID: <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
X-Mailman-Approved-At: Thu, 06 Feb 2025 14:07:31 +0100
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

Hi Ilias,

On Thu, 6 Feb 2025 at 05:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 6 Feb 2025 at 14:30, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Heinrich,
> > >
> > > On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > > > For armv8 we are adding proper page permissions for the relocated U-Boot
> > > > > binary. Add a weak function that can be used across architectures to change
> > > > > the page permissions
> > > > >
> > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > ---
> > > > >   arch/arc/lib/cache.c           |  2 ++
> > > > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > > > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > > > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > > > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > > > >   arch/arm/lib/cache.c           |  2 ++
> > > > >   arch/m68k/lib/cache.c          |  2 ++
> > > > >   arch/nios2/lib/cache.c         |  2 ++
> > > > >   arch/powerpc/lib/cache.c       |  2 ++
> > > > >   arch/riscv/lib/cache.c         |  2 ++
> > > > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > > > >   arch/xtensa/lib/cache.c        |  2 ++
> > > > >   include/cpu_func.h             | 16 ++++++++++++++++
> > > > >   13 files changed, 59 insertions(+)
> > > > >
> > > > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > > > index 5169fc627fa5..5c79243d7223 100644
> > > > > --- a/arch/arc/lib/cache.c
> > > > > +++ b/arch/arc/lib/cache.c
> > > > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > > > >
> > > > >       __ic_entire_invalidate();
> > > > >   }
> > > > > +
> > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > > > > index 5b87a3af91b2..857311b3dfad 100644
> > > > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > > > >       dcache_enable();
> > > > >   #endif
> > > > >   }
> > > > > +
> > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > > > > index d11420d2fdd0..14c9be77db8d 100644
> > > > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > > > >   __weak void v7_outer_cache_inval_all(void) {}
> > > > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > > > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > > > > index b6d08b7aad73..458a214e9577 100644
> > > > > --- a/arch/arm/cpu/armv7m/cache.c
> > > > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > > > >       dcache_enable();
> > > > >   #endif
> > > > >   }
> > > > > +
> > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > > > index 670379e17b7a..1cf3870177ee 100644
> > > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > > @@ -1028,6 +1028,28 @@ skip_break:
> > > > >       __asm_invalidate_tlb_all();
> > > > >   }
> > > > >
> > > > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > > > +{
> > > > > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > > > > +
> > > > > +     switch (perm) {
> > > > > +     case MMU_ATTR_RO:
> > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > > > > +             break;
> > > > > +     case MMU_ATTR_RX:
> > > > > +             attrs |= PTE_BLOCK_RO;
> > > > > +             break;
> > > > > +     case MMU_ATTR_RW:
> > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > > > +             break;
> > > > > +     default:
> > > > > +             log_err("Unknown attribute %llx\n", perm);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > > > +}
> > > > > +
> > > > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > > > >
> > > > >   /*
> > > > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > > > index 516754caeaf9..c7704d8ee354 100644
> > > > > --- a/arch/arm/lib/cache.c
> > > > > +++ b/arch/arm/lib/cache.c
> > > > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > > > >
> > > > >       return 0;
> > > > >   }
> > > > > +
> > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > >
> > > > I would prefer if the weak function would return -ENOSYS indicating the
> > > > missing implementation and the real function would return 0 in case of
> > > > success or an error code on failure. This way the EFI protocol could set
> > > > the return code if the architecture does not provide support for setting
> > > > the attributes the passed addresses are invalid.
> > >
> > > Sure I'll change that in v2
> >
> > Instead of a weak function could you define an API for it, including
> > structs for the information, a command to adjust it, tests, etc? This
> > needs a little more thought.
> >
> > How about adding to cpu_ops and the information there? The cpu_func.h
> > which is supposed to be deprecated.
>
> Looking at it, I think it's easier as well. I can add move that
> function in cpu_ops, so it becomes NULL for other architectures. But
> since this patchset is doing enough already, I'll just move that. In
> the future, we can move all the cache* and mapping* functions there as
> well

That sounds great, thank you. I suspect that RISC-V will follow your lead here.

Regards,
Simon
