Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40510C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0E58033D;
	Wed,  5 Feb 2025 22:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aI0JNtCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28863806FE; Wed,  5 Feb 2025 17:55:02 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9DB80104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso7438762276.1
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738774498; x=1739379298; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uI9ekpeFrvhAm2q2+kreRTOpRG0JD+DQJknKGvxM/Gs=;
 b=aI0JNtCgNQI/MzBwlmQvf1wJ/28PENAx3inVmCEX3Yf9UcuZ0vCWE5YDh3FxX1eSLz
 ceuhzxgeZ1Ktddfz0+INMYLLwq9XmBhNOv3hdMQBhxQey2pKzKwNhU++s4xK/iY4LOFH
 grglIRkvKEI1RGJjS4fwaO7m9MicXIO8zRkEMnaQnx7oLyUx5EtN+V8hJo3GThoPkodd
 qg99PqdP4D61gefKeI1UE+fu1CN6L1s+p6xL53+86yLJUTpaXJ3RDqgaLcFWw+66KrAY
 U74zWxeqeunH+ttdeJPX52AXL9xTht0V1GD/x6E5/KUuJ2Bl4GNaRB/CR78xhb9nuuv/
 EMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738774498; x=1739379298;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uI9ekpeFrvhAm2q2+kreRTOpRG0JD+DQJknKGvxM/Gs=;
 b=oC0Qzf5EaCP+QJwA5TJ3jQ2KBIuQ+9rI5h4uO4elqGCjs1iJ/sPxd9CwjurCPtNCce
 vo2YKjksH6wVqDZINqHQykkcdztRZ+vu08KvT8VqaM+IkI6xcdC1gkfMHKaK8gH+LLqx
 VsO0qjZ9eBpQEPp13kFMJCgDGLX51UQGSlBjlatIg3MEiYIcZ1rSAGCF/mzX4iyHASHi
 WgEiWFB92qZtZNpfFCZ2Yb50cgoPDm73SURIgOjOlsa/ubBXpJhOZvjo1pw3QdKgl4p5
 Ul/rjXpWd8jAeAKQFb3jOWBUdi66ZlB3Vae/zX9ieM9EuQXAzf/MlrMYtsSWbwrsrjxK
 4KJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCihTEiyD43uadni4WaHhRF6C+3v+ArbDu9jC1L+NE65b9Jz1ZjF/hcPs9uYE/26N6Cnrx1KA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyab4A+44Djam44LocXgjuX59Q/rou1V3LasLay5qrYLwOXwnw
 /KfNHd9zh06tIOnXc/6YLHxyNQquKJ/Wtjp4M7E5W/PhtSMaXRZ8Sc1ENf8bwEILMhNqFge2SHH
 pyhsIHrjM2MEo28o5iEEqTSpCsTELITtOfG79bQ==
X-Gm-Gg: ASbGncsnC5+dLnitTcbCfffjBvCd99f8Lc2St49gDCZsKm0C6lCYmWyddKhLVa0+6J/
 HG/CkdGf9VVtcB1rEaZlOL5/nBAW/ZEmY0SzhxG3vHtOZQ0/IB50t4J037KY0vFOvptSWi3n9
X-Google-Smtp-Source: AGHT+IGqAMpl0DEF/w1cWyHZHUheXrcJSBfVlVhpG1Zxp7YK74sAeURPHFunQPgdtE2f70ldiDTPdbQM71CvtpG7atk=
X-Received: by 2002:a05:6902:1087:b0:e5b:1710:d3d0 with SMTP id
 3f1490d57ef6-e5b25c042e0mr3007905276.43.1738774498190; Wed, 05 Feb 2025
 08:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
In-Reply-To: <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 18:54:22 +0200
X-Gm-Features: AWEUYZkSPJNvNzB7m8gOwYokZassVvZ5oI8FyPUKZVniwSW50R0H6ECDuKWDzy8
Message-ID: <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:30:51 +0100
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

On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/5/25 08:16, Ilias Apalodimas wrote:
> > For armv8 we are adding proper page permissions for the relocated U-Boot
> > binary. Add a weak function that can be used across architectures to change
> > the page permissions
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   arch/arc/lib/cache.c           |  2 ++
> >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> >   arch/arm/lib/cache.c           |  2 ++
> >   arch/m68k/lib/cache.c          |  2 ++
> >   arch/nios2/lib/cache.c         |  2 ++
> >   arch/powerpc/lib/cache.c       |  2 ++
> >   arch/riscv/lib/cache.c         |  2 ++
> >   arch/sh/cpu/sh4/cache.c        |  2 ++
> >   arch/xtensa/lib/cache.c        |  2 ++
> >   include/cpu_func.h             | 16 ++++++++++++++++
> >   13 files changed, 59 insertions(+)
> >
> > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > index 5169fc627fa5..5c79243d7223 100644
> > --- a/arch/arc/lib/cache.c
> > +++ b/arch/arc/lib/cache.c
> > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> >
> >       __ic_entire_invalidate();
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > index 5b87a3af91b2..857311b3dfad 100644
> > --- a/arch/arm/cpu/arm926ejs/cache.c
> > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > @@ -88,3 +88,5 @@ void enable_caches(void)
> >       dcache_enable();
> >   #endif
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > index d11420d2fdd0..14c9be77db8d 100644
> > --- a/arch/arm/cpu/armv7/cache_v7.c
> > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> >   __weak void v7_outer_cache_inval_all(void) {}
> >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > index b6d08b7aad73..458a214e9577 100644
> > --- a/arch/arm/cpu/armv7m/cache.c
> > +++ b/arch/arm/cpu/armv7m/cache.c
> > @@ -370,3 +370,5 @@ void enable_caches(void)
> >       dcache_enable();
> >   #endif
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > index 670379e17b7a..1cf3870177ee 100644
> > --- a/arch/arm/cpu/armv8/cache_v8.c
> > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > @@ -1028,6 +1028,28 @@ skip_break:
> >       __asm_invalidate_tlb_all();
> >   }
> >
> > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > +{
> > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > +
> > +     switch (perm) {
> > +     case MMU_ATTR_RO:
> > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > +             break;
> > +     case MMU_ATTR_RX:
> > +             attrs |= PTE_BLOCK_RO;
> > +             break;
> > +     case MMU_ATTR_RW:
> > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > +             break;
> > +     default:
> > +             log_err("Unknown attribute %llx\n", perm);
> > +             return;
> > +     }
> > +
> > +     mmu_change_region_attr(addr, size, attrs, false);
> > +}
> > +
> >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> >
> >   /*
> > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > index 516754caeaf9..c7704d8ee354 100644
> > --- a/arch/arm/lib/cache.c
> > +++ b/arch/arm/lib/cache.c
> > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> >
> >       return 0;
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
>
> I would prefer if the weak function would return -ENOSYS indicating the
> missing implementation and the real function would return 0 in case of
> success or an error code on failure. This way the EFI protocol could set
> the return code if the architecture does not provide support for setting
> the attributes the passed addresses are invalid.

Sure I'll change that in v2

Cheers
/Ilias
>
> Best regards
>
> Heinrich
>
> > diff --git a/arch/m68k/lib/cache.c b/arch/m68k/lib/cache.c
> > index 370ad40f1423..b275646384a5 100644
> > --- a/arch/m68k/lib/cache.c
> > +++ b/arch/m68k/lib/cache.c
> > @@ -151,3 +151,5 @@ __weak void flush_dcache_range(unsigned long start, unsigned long stop)
> >   {
> >       /* An empty stub, real implementation should be in platform code */
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
> > index 8f543f2a2f26..7a93a8fcc6a7 100644
> > --- a/arch/nios2/lib/cache.c
> > +++ b/arch/nios2/lib/cache.c
> > @@ -127,3 +127,5 @@ void dcache_disable(void)
> >   {
> >       flush_dcache_all();
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
> > index a9cd7b8d30ac..3d0536caccde 100644
> > --- a/arch/powerpc/lib/cache.c
> > +++ b/arch/powerpc/lib/cache.c
> > @@ -58,3 +58,5 @@ void invalidate_icache_all(void)
> >   {
> >       puts("No arch specific invalidate_icache_all available!\n");
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
> > index 71e4937ab542..1c751e562157 100644
> > --- a/arch/riscv/lib/cache.c
> > +++ b/arch/riscv/lib/cache.c
> > @@ -151,3 +151,5 @@ __weak void enable_caches(void)
> >       if (!zicbom_block_size)
> >               log_debug("Zicbom not initialized.\n");
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/sh/cpu/sh4/cache.c b/arch/sh/cpu/sh4/cache.c
> > index 99acc5999652..22e0f1484a33 100644
> > --- a/arch/sh/cpu/sh4/cache.c
> > +++ b/arch/sh/cpu/sh4/cache.c
> > @@ -126,3 +126,5 @@ int dcache_status(void)
> >   {
> >       return 0;
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
> > index e6a7f6827fc2..aacc2d2627d6 100644
> > --- a/arch/xtensa/lib/cache.c
> > +++ b/arch/xtensa/lib/cache.c
> > @@ -57,3 +57,5 @@ void invalidate_icache_all(void)
> >   {
> >       __invalidate_icache_all();
> >   }
> > +
> > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > diff --git a/include/cpu_func.h b/include/cpu_func.h
> > index 7e81c4364a73..17b6d199302a 100644
> > --- a/include/cpu_func.h
> > +++ b/include/cpu_func.h
> > @@ -69,6 +69,22 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
> >   void invalidate_dcache_range(unsigned long start, unsigned long stop);
> >   void invalidate_dcache_all(void);
> >   void invalidate_icache_all(void);
> > +
> > +enum pgprot_attrs {
> > +     MMU_ATTR_RO,
> > +     MMU_ATTR_RX,
> > +     MMU_ATTR_RW,
> > +};
> > +
> > +/** pgprot_set_attrs() - Set page table permissions
> > + *
> > + * @addr: Physical address start
> > + * @size: size of memory to change
> > + * @perm: New permissions
> > + *
> > + **/
> > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);
> > +
> >   /**
> >    * noncached_init() - Initialize non-cached memory region
> >    *
>
