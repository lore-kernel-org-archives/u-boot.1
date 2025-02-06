Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3DFC02199
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 18:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF30A80EBB;
	Thu,  6 Feb 2025 19:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R4hY/ejU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B90380AE1; Thu,  6 Feb 2025 17:21:51 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DA68083C
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 17:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so871909276.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 08:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738858906; x=1739463706; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LGq4t5om6shF9Dt9n1Y/cPgoHECThuqCG2LFn+7Ybdo=;
 b=R4hY/ejUfQxTovwxXVlPqqz3s2BWfx912NKi0AbhVJQHPZjiM8qKGGzwer7pldn/+R
 NNDYY+sbdtHl6qks8IuybshJSx4pTg5WagCnQSKDWGQdrRWIKnEViB0Rbsqzj6rT5lvi
 dqIczf52oeNOtD5MRQQD+8sohq1PxoUxS5cfQdmoa9HridrXPZPU7cpLljCP57vUwPyO
 TpHf2yuWFJAkwSZKQp1BxOyBCZZ/FfovHYIscvqvWhpga9NnzU/PEMGhzjjhiQxocL+V
 0TLwyhM7fJ6io+nmSPDxg1rJiGFbNM/7/8lmuI1cGEDC7pWqavkQTR2DJFuu2kbk9Da7
 2XJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738858906; x=1739463706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LGq4t5om6shF9Dt9n1Y/cPgoHECThuqCG2LFn+7Ybdo=;
 b=bxR2jvoPb05wFOLRCDs9O/SANYRoPX0liB1/RaCQHZjuv3GVkVPVi/DMGMnverUOaM
 e56g7y47T1qLAw/T3V1x72FlEGtrL2KlSxQB+NOMhd+JbNKkTyKIObAj261O6JQa2FP1
 1Shl2B5a3uIlEnaNpiuLp79kzFh6ajftK07g6p3dIz6L/EulwZkP6BslbFjJPW8r2956
 rdp7QQ1mbXN6AG/YZ/dlL37Ruebl+Po0ZZwpjpIVoJCtIf6QKH6WLbx5gajbZn+RKdPM
 sDc7eA2+QoOLTevVWL5LW1jYj+gqO19CSe/Ca6K11ZO+iYlXzA45se9prf0RP/OP0yLd
 8ZMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzBNyqiTlJhRaAJl1wh1ZG7KdD1ZsVpWfREb14ZqifL23rktDNCFqo/XZzLbB/cE97eAOiNZw=@lists.denx.de
X-Gm-Message-State: AOJu0YzV7GNEM5OwVjkL/sojsN5iGkGLneTKC6NG+Y89jZFNM4AOEtJP
 tMKwusXyesvAT701z5cVSXYDF7mJyJSHHxH+VM+LWIkgc1mnIEp5poB17r7UHTxBYukRwRf0ltz
 NC9gk4wCExVK4JyeIm5ODUIBii/RdVsH4R8KNsA==
X-Gm-Gg: ASbGnctKhd/4T/W/GatY9LzjIg2oEPkblgBO5zlX/rxgeoj2VgkQd9XGyKnjLGsnPLk
 S2ldKuc4i/32GKlsiQYKjZuySav/OjHcSuLQ2ODdsEvNUXGyZoHh0Vj2pUwyIPT833IPmRnnJlA
 ==
X-Google-Smtp-Source: AGHT+IF4lnn/qIOVS0rfMALBS6XBHhSLTneMf70ql29NPLxv5ljOWJQzREhf7yddO6alP1mxyUx362si5eozFcJ8pNs=
X-Received: by 2002:a05:6902:240d:b0:e58:aa00:ffd5 with SMTP id
 3f1490d57ef6-e5b259d4f4bmr6589436276.4.1738858906418; Thu, 06 Feb 2025
 08:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-6-ilias.apalodimas@linaro.org>
 <0b9360a3-c0f6-49dd-9678-6eac530c29a7@gmx.de>
 <CAC_iWjK2uZMyJSHmAk_wJxgaV92bpE1naoqvdHvdURjfBRpSGA@mail.gmail.com>
 <CAFLszTiESUm8bqdqZdaLDTz65UXpyTLxm+rCoViZMchO4QWY4g@mail.gmail.com>
 <CAC_iWjJ7tiTyqq1CXupHMWpfBLSFTu3oEpE798C5N61-zVNo9A@mail.gmail.com>
 <CAFLszTiPkL=V_fAFThccQH-Q3Sj7XuUWJW=DJX2O9yqDF8AVhA@mail.gmail.com>
 <CAC_iWjJDNPWTVLXZS3_G42Tn4+m_nZtr+4XTJb-SKZ55UbCudQ@mail.gmail.com>
 <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
In-Reply-To: <CAFLszTiys=22YpObG33wPWoGDfogtSLNk7MsKHxb2ecGmncHYg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Feb 2025 18:21:10 +0200
X-Gm-Features: AWEUYZmv9RY2ztpVUnSZ7j9AVOyPmx9rArJNCQYun2-ddn337o5v1NolW90nj5w
Message-ID: <CAC_iWj+cL=kmJL16u2U1rD+Vn_0812VNZ0pJmBNrTgyJmmxATg@mail.gmail.com>
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

Hi Simon,

On Thu, 6 Feb 2025 at 17:48, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 6 Feb 2025 at 08:16, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 6 Feb 2025 at 14:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 6 Feb 2025 at 05:52, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 6 Feb 2025 at 14:30, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > > > On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > > > > > > For armv8 we are adding proper page permissions for the relocated U-Boot
> > > > > > > > binary. Add a weak function that can be used across architectures to change
> > > > > > > > the page permissions
> > > > > > > >
> > > > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > > ---
> > > > > > > >   arch/arc/lib/cache.c           |  2 ++
> > > > > > > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > > > > > > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > > > > > > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > > > > > > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > > > > > > >   arch/arm/lib/cache.c           |  2 ++
> > > > > > > >   arch/m68k/lib/cache.c          |  2 ++
> > > > > > > >   arch/nios2/lib/cache.c         |  2 ++
> > > > > > > >   arch/powerpc/lib/cache.c       |  2 ++
> > > > > > > >   arch/riscv/lib/cache.c         |  2 ++
> > > > > > > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > > > > > > >   arch/xtensa/lib/cache.c        |  2 ++
> > > > > > > >   include/cpu_func.h             | 16 ++++++++++++++++
> > > > > > > >   13 files changed, 59 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > > > > > > index 5169fc627fa5..5c79243d7223 100644
> > > > > > > > --- a/arch/arc/lib/cache.c
> > > > > > > > +++ b/arch/arc/lib/cache.c
> > > > > > > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > > > > > > >
> > > > > > > >       __ic_entire_invalidate();
> > > > > > > >   }
> > > > > > > > +
> > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > index 5b87a3af91b2..857311b3dfad 100644
> > > > > > > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > > > > > > >       dcache_enable();
> > > > > > > >   #endif
> > > > > > > >   }
> > > > > > > > +
> > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > index d11420d2fdd0..14c9be77db8d 100644
> > > > > > > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > > > > > > >   __weak void v7_outer_cache_inval_all(void) {}
> > > > > > > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > > > > > > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > > > > > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > > > > > > > index b6d08b7aad73..458a214e9577 100644
> > > > > > > > --- a/arch/arm/cpu/armv7m/cache.c
> > > > > > > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > > > > > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > > > > > > >       dcache_enable();
> > > > > > > >   #endif
> > > > > > > >   }
> > > > > > > > +
> > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > index 670379e17b7a..1cf3870177ee 100644
> > > > > > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > @@ -1028,6 +1028,28 @@ skip_break:
> > > > > > > >       __asm_invalidate_tlb_all();
> > > > > > > >   }
> > > > > > > >
> > > > > > > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > > > > > > +{
> > > > > > > > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > > > > > > > +
> > > > > > > > +     switch (perm) {
> > > > > > > > +     case MMU_ATTR_RO:
> > > > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > > > > > > > +             break;
> > > > > > > > +     case MMU_ATTR_RX:
> > > > > > > > +             attrs |= PTE_BLOCK_RO;
> > > > > > > > +             break;
> > > > > > > > +     case MMU_ATTR_RW:
> > > > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > > > > > > +             break;
> > > > > > > > +     default:
> > > > > > > > +             log_err("Unknown attribute %llx\n", perm);
> > > > > > > > +             return;
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > > > > > > >
> > > > > > > >   /*
> > > > > > > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > > > > > > index 516754caeaf9..c7704d8ee354 100644
> > > > > > > > --- a/arch/arm/lib/cache.c
> > > > > > > > +++ b/arch/arm/lib/cache.c
> > > > > > > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > > > > > > >
> > > > > > > >       return 0;
> > > > > > > >   }
> > > > > > > > +
> > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > >
> > > > > > > I would prefer if the weak function would return -ENOSYS indicating the
> > > > > > > missing implementation and the real function would return 0 in case of
> > > > > > > success or an error code on failure. This way the EFI protocol could set
> > > > > > > the return code if the architecture does not provide support for setting
> > > > > > > the attributes the passed addresses are invalid.
> > > > > >
> > > > > > Sure I'll change that in v2
> > > > >
> > > > > Instead of a weak function could you define an API for it, including
> > > > > structs for the information, a command to adjust it, tests, etc? This
> > > > > needs a little more thought.
> > > > >
> > > > > How about adding to cpu_ops and the information there? The cpu_func.h
> > > > > which is supposed to be deprecated.
> > > >
> > > > Looking at it, I think it's easier as well. I can add move that
> > > > function in cpu_ops, so it becomes NULL for other architectures. But
> > > > since this patchset is doing enough already, I'll just move that. In
> > > > the future, we can move all the cache* and mapping* functions there as
> > > > well
> > >
> > > That sounds great, thank you. I suspect that RISC-V will follow your lead here.
> >
> > I wrote the code but cpu uclass isn't even close to doing what we want.
> > Grepping for defined boards with a cpu uclass driver for arm gives me
> > back < 20 boards. Given the fact we already found 3 bugs with this
> > patch applied, I prefer to have a wider coverage and fix U-Boot.
> > I've uploaded the uclass version here [0], once more boards decide to
> > use it I will be happy to switch to that, but unfortunately for now,
> > I'll am obliged to keep the weak function definition.
>
> Please at least post the patches as an RFC.
>
> We had the same issue with EFI_LOADER back in the day (not wanting to
> depend on CONFIG_DM) and it has cost us a lot of time.
>
> Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
> way you want to go, I'd be happy to do a precursor series to deal with
> the fallout.

That's not the problem. I can easily add a select of CPU_CONFIG on
that new Kconfig.

The problem is that I  grep 20 boards supporting it, and out of those
20 boards only 6-7 are usable. The rest have cpu compatible nodes that
don't exist on any DT. e.g grep for 'xlnx,microblaze-7.10'. It's
defined as a 'cpu driver' but there are no DTs. As a result that cpu
dm pointer the code relies on, never gets created.

So the result is that this code will never execute unless you run on
very few boards. I've already sent a link to code that does use DM and
'works', so if and when boards adopt it I can resend it.

Thanks
/Ilias

>
> >
> > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions_uclass?ref_type=heads
>
> Regards,
> Simon
