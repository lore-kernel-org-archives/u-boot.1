Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A3C02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F45080821;
	Thu,  6 Feb 2025 11:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qBZlbC7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144B4807FE; Thu,  6 Feb 2025 10:43:11 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A072807E4
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 10:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3983426f80so556244276.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738834987; x=1739439787; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4IGYPD8GgPZv2wu5oaYvEi1WZpThdV0T/HZKzytY5U=;
 b=qBZlbC7TGc3VMicwyCF+mToNJo6AlyZUdg7Eo50KPgwgNTmYRhRuj2uJQ6n/lCQIhG
 InB8gmUPLf4QsxrU1nzhquco8SPHkBGZU6jhu1PIEQZqq+E77YcEIzrysV0ziZI89YYB
 vpt3C5UqLHUoKE3/dtk7jyBMibCZCXN0WUGPcKLgkkTDG9qcZOg05XmpQoJUcY3bQZhC
 sXdSle8AusM1lHdflfhrhl0HOB7i5mwMT8RWVz3FWuS6T/lDsQjih+LhtxhnmMdLs8Bp
 Xb7rllbOydTJLZy2wJipj1YSIi/f5vWXhiLnq/Hwb5afvtnhNQyn+iCdOduJD22cyo1u
 HXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738834987; x=1739439787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4IGYPD8GgPZv2wu5oaYvEi1WZpThdV0T/HZKzytY5U=;
 b=O7YY9z3PAMGjeZsLgmPCJY2e86zsw4LK1d2ri6quU5SIhcU/mVEVCS5oFtlVZS51wH
 wTEydKc9CWWu3nzOYDk1DoVYLHSUlNnU52EMo5DrZ4IWNNHqoSxk852vlQDzbvDuh0Ta
 5vMLIRir15sO6MQncjPSEzfDr4LYZfJm8HjBEgtH1uA1BGb0s3XTJDnWMzE8aEZiSExe
 0U6Y7f33+P2dhZxGzLQo1VnbgFRqZyeSCzIDXw7R9pnMd6aT85JG2tyWZDLi617huJqo
 IX1E/Pj0tDNyRDm3cWPYkA0sd9jhKqvBzLpBaArgBggBkja5RbXtVGfeQLOCaZQjv3gS
 e2jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWgPaYuItNyELPkE/Pyu3ggck6qFloBG+ioCrL14YH6XeRVVA61vBzMI013/h8IHSm3P+zVRE=@lists.denx.de
X-Gm-Message-State: AOJu0YwdhyV6wN30os2HqsNKr0fiZRloiQ0i4oxbwsF8IWVrFqbK8zb/
 Bkb1rZCmwAD0kOfF5nwrxaNiaMpuoueyzu3ufJc+jTyXFGQw+6DfF/gm6DbUeRtamXkobaKl7nA
 4Dz0sbhDStHLE9Ri3HWGT4LsxbCJpRWWtxEuxgw==
X-Gm-Gg: ASbGnctzYufLcH+q+Pr6L5j71TitJHBOASP73W8KxezT2V7ATs+KDf3dknB9w4zAeuc
 srsXQ5EyYenvAD2QR9SKDGDOeUbC3q3PuVJdiBEAQq6zCQg/1ecm+ssFoRhgTRR/q82bkmqEBMg
 ==
X-Google-Smtp-Source: AGHT+IF+pDWuYZzrLceainE7S8I8yPM4Q0GFOH5D1jT8SMl7k89qGvU1DQlvBDh66Kpq7F48r5Aev1+sghoLVFTYJPI=
X-Received: by 2002:a05:6902:2849:b0:e58:3449:3ad6 with SMTP id
 3f1490d57ef6-e5b25a2d4e4mr5609631276.22.1738834987236; Thu, 06 Feb 2025
 01:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
In-Reply-To: <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Feb 2025 11:42:31 +0200
X-Gm-Features: AWEUYZmWlNek3q7GIE4a-4MeVHTsTHq8DmvGltT4CR_7yKatzYEWvHoZF-MeSd0
Message-ID: <CAC_iWjLwGnWYRPUvETp1ASar7eUvbZkrtpnzt5U7FT_dgsH_3w@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] treewide: Add a function to change page permissions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
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
X-Mailman-Approved-At: Thu, 06 Feb 2025 11:41:33 +0100
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

Hi Heinrich,

[...]

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

Okay, I ad a look at EFI_MEMORY_ATTRIBUTE_PROTOCOL.SetMemoryAttributes.
This function does not support EFI_UNSUPPORTED if you don't have code
around to set the PTEs.

So, I think we should
- make the prototype an int and return an error
- add a new bool *supported argument? And if the caller calls the function
with base & size == 0, set that value?
That way we can choose not to install the protocol at all if the
functionality doesn't exist.

Thanks
/Ilias
>
> Cheers
> /Ilias
> >
> > Best regards
> >
> > Heinrich
> >
> > > diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> > > index 370ad40f1423..b275646384a5 100644
> > > --- a/arch/m68k/lib/cache.c
> > > +++ b/arch/m68k/lib/cache.c
> > > @@ -151,3 +151,5 @@ __weak void flush_dcache_range(unsigned long start, unsigned long stop)
> > >   {
> > >       /* An empty stub, real implementation should be in platform code */
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
> > > index 8f543f2a2f26..7a93a8fcc6a7 100644
> > > --- a/arch/nios2/lib/cache.c
> > > +++ b/arch/nios2/lib/cache.c
> > > @@ -127,3 +127,5 @@ void dcache_disable(void)
> > >   {
> > >       flush_dcache_all();
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
> > > index a9cd7b8d30ac..3d0536caccde 100644
> > > --- a/arch/powerpc/lib/cache.c
> > > +++ b/arch/powerpc/lib/cache.c
> > > @@ -58,3 +58,5 @@ void invalidate_icache_all(void)
> > >   {
> > >       puts("No arch specific invalidate_icache_all available!\n");
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
> > > index 71e4937ab542..1c751e562157 100644
> > > --- a/arch/riscv/lib/cache.c
> > > +++ b/arch/riscv/lib/cache.c
> > > @@ -151,3 +151,5 @@ __weak void enable_caches(void)
> > >       if (!zicbom_block_size)
> > >               log_debug("Zicbom not initialized.\n");
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> > > index 99acc5999652..22e0f1484a33 100644
> > > --- a/arch/sh/cpu/sh4/cache.c
> > > +++ b/arch/sh/cpu/sh4/cache.c
> > > @@ -126,3 +126,5 @@ int dcache_status(void)
> > >   {
> > >       return 0;
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
> > > index e6a7f6827fc2..aacc2d2627d6 100644
> > > --- a/arch/xtensa/lib/cache.c
> > > +++ b/arch/xtensa/lib/cache.c
> > > @@ -57,3 +57,5 @@ void invalidate_icache_all(void)
> > >   {
> > >       __invalidate_icache_all();
> > >   }
> > > +
> > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > diff --git a/include/cpu_func.h b/include/cpu_func.h
> > > index 7e81c4364a73..17b6d199302a 100644
> > > --- a/include/cpu_func.h
> > > +++ b/include/cpu_func.h
> > > @@ -69,6 +69,22 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
> > >   void invalidate_dcache_range(unsigned long start, unsigned long stop);
> > >   void invalidate_dcache_all(void);
> > >   void invalidate_icache_all(void);
> > > +
> > > +enum pgprot_attrs {
> > > +     MMU_ATTR_RO,
> > > +     MMU_ATTR_RX,
> > > +     MMU_ATTR_RW,
> > > +};
> > > +
> > > +/** pgprot_set_attrs() - Set page table permissions
> > > + *
> > > + * @addr: Physical address start
> > > + * @size: size of memory to change
> > > + * @perm: New permissions
> > > + *
> > > + **/
> > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
> > > +
> > >   /**
> > >    * noncached_init() - Initialize non-cached memory region
> > >    *
> >
