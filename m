Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E0FC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE15E809A8;
	Thu,  6 Feb 2025 14:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kzQUK9pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACDE8083C; Thu,  6 Feb 2025 13:30:57 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8212807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab34a170526so133257466b.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 04:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738845055; x=1739449855; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XnVAh0Sn4/hldnjsJ1dayFY+SCT8mLJE3QAMqj1STKM=;
 b=kzQUK9pXI6HOD269z5vN17q2T+ymizB6K+214n2GM7DDZB/RSG0MhPbg9nKmAClESw
 OtvY6JAoXezZr4Hy38WdCXm5xw777P/a5/DoL9vIjBwAU8TSkadk59LRRGlzIy5mG8ab
 WuFIYkiPtHAefrroYCHQPBh/Xum2Qwt3MKLQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738845055; x=1739449855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XnVAh0Sn4/hldnjsJ1dayFY+SCT8mLJE3QAMqj1STKM=;
 b=S+QvBsBswCxQlapt0HRepti9pCotOAICO1dQbw8MqKLCkan4bqMFtg0sW4rKvetIef
 VJqo9VAXCcwmOFxZs9KFe75LsrpeQMc1Q0WTvEHdx8G3DtXgSWm25B4BHpo6235KJxEO
 5hrr9+Wat08pUAkGVc+7rUqwQVNU+l7mBn50di6teg43MiUD/9zPuqCeXzzWgESS/d+O
 omm8/obM/+J6T/z/ZKFxwcB8wSOFXIuWgqYaza9iEgApphvkiWxIJY3xDiqGYDKe5nbP
 SwANcHmHz81Ng5WGmqf1P3thPgQz+1wk5YywGkDuY9FIpdX+OmZuSwp/eFyNXTXb8V0V
 gDLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtvEIKtETI0QsVg2uVJbvqgeUr1MhdK2fzRVuh1S2elgfp2UGOhAE9+vm9Aa4JFl4EQluS72M=@lists.denx.de
X-Gm-Message-State: AOJu0YyaAwgzRFgGXhrPbfqNmk9cBW8irAi7c5DElEAvRfmpFZxc0g8p
 /f62+ypxP/JdJsz+njVqGsAv+S+Qu+cTrqwfyC8EiQoiDopqgcr1SVaMSYqkltrGbRoJSlJSn85
 5GGyA8kUnYZICmJcRRbx9bn3puYRkgAXDae/O
X-Gm-Gg: ASbGncv4rI1REz1k3b8A6m+b65q8n08qS2e4TLZ3sksHlaB+ZcJS24wtFmgxJe/JGD+
 gYhvHe4h1yEz/wrCAh1xspHmVK140eMXLYGM+1DMwnvXPabR8B9zrWWS0yFlaGh7pl6KCg/42eg
 ==
X-Google-Smtp-Source: AGHT+IFC1yu1nokR20bA1n6BJXqq43vzmpJWOoAOFqU35QguAirTyEPEiDjxC3GtP6BYxjaBJrpJrm68+6nUbss0cLk=
X-Received: by 2002:a17:907:96a2:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab75e27cdebmr750759366b.33.1738845054978; Thu, 06 Feb 2025
 04:30:54 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
In-Reply-To: <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 05:30:43 -0700
X-Gm-Features: AWEUYZlXye92K-zal9_pyiRjPEnm8rWN5nTmO9QEBx7ZKFx-A2pfzqAJk1_yLzM
Message-ID: <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
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

On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Heinrich,
>
> On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > For armv8 we are adding proper page permissions for the relocated U-Boot
> > > binary. Add a weak function that can be used across architectures to change
> > > the page permissions
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > >   arch/arc/lib/cache.c           |  2 ++
> > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > >   arch/arm/lib/cache.c           |  2 ++
> > >   arch/m68k/lib/cache.c          |  2 ++
> > >   arch/nios2/lib/cache.c         |  2 ++
> > >   arch/powerpc/lib/cache.c       |  2 ++
> > >   arch/riscv/lib/cache.c         |  2 ++
> > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > >   arch/xtensa/lib/cache.c        |  2 ++
> > >   include/cpu_func.h             | 16 ++++++++++++++++
> > >   13 files changed, 59 insertions(+)
> > >
> > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > index 5169fc627fa5..5c79243d7223 100644
> > > --- a/arch/arc/lib/cache.c
> > > +++ b/arch/arc/lib/cache.c
> > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > >
> > >       __ic_entire_invalidate();
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > > index 5b87a3af91b2..857311b3dfad 100644
> > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > >       dcache_enable();
> > >   #endif
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > > index d11420d2fdd0..14c9be77db8d 100644
> > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > >   __weak void v7_outer_cache_inval_all(void) {}
> > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > > index b6d08b7aad73..458a214e9577 100644
> > > --- a/arch/arm/cpu/armv7m/cache.c
> > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > >       dcache_enable();
> > >   #endif
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > index 670379e17b7a..1cf3870177ee 100644
> > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > @@ -1028,6 +1028,28 @@ skip_break:
> > >       __asm_invalidate_tlb_all();
> > >   }
> > >
> > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > +{
> > > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > > +
> > > +     switch (perm) {
> > > +     case MMU_ATTR_RO:
> > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > > +             break;
> > > +     case MMU_ATTR_RX:
> > > +             attrs |= PTE_BLOCK_RO;
> > > +             break;
> > > +     case MMU_ATTR_RW:
> > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > +             break;
> > > +     default:
> > > +             log_err("Unknown attribute %llx\n", perm);
> > > +             return;
> > > +     }
> > > +
> > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > +}
> > > +
> > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > >
> > >   /*
> > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > index 516754caeaf9..c7704d8ee354 100644
> > > --- a/arch/arm/lib/cache.c
> > > +++ b/arch/arm/lib/cache.c
> > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > >
> > >       return 0;
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> >
> > I would prefer if the weak function would return -ENOSYS indicating the
> > missing implementation and the real function would return 0 in case of
> > success or an error code on failure. This way the EFI protocol could set
> > the return code if the architecture does not provide support for setting
> > the attributes the passed addresses are invalid.
>
> Sure I'll change that in v2

Instead of a weak function could you define an API for it, including
structs for the information, a command to adjust it, tests, etc? This
needs a little more thought.

How about adding to cpu_ops and the information there? The cpu_func.h
which is supposed to be deprecated.

Regards,
SImon
