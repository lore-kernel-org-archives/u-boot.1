Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF5C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210A180B9E;
	Sun,  9 Feb 2025 17:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mjn6xtmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EF280819; Sun,  9 Feb 2025 15:36:11 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E20A980141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5de6c708315so998583a12.0
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739111768; x=1739716568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H1DB250h8/yIueYlKQu+w7iaUe8lIHRHaZKEdKmPq3U=;
 b=Mjn6xtmTh7OZ3SYs/zfAETdzCHnIKsjKPmrIys/D3xJ8nFVihz50m4GOJucb1E+GeX
 vDF8YhJKPgPT588uDf2VJanlsw/GHKtWr6R/ZNyvhjiUVD3SQLEaU3jRC80NOQp3iidl
 /V0b7nqJsgsWyHXCtEuAO4wMY0AtkqklKZi+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111768; x=1739716568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H1DB250h8/yIueYlKQu+w7iaUe8lIHRHaZKEdKmPq3U=;
 b=TS5bbJRO1TP1KVOFfb3sJeCgunN2MISs/cU2QyRm5DR1xhmGPHMp2qvp2rzCLxi5Ve
 ihZ1HhZaRMJPowOripyYgUgg50G3gylgXpS6T+/3KGra20p+uCEFX8K03bsn17cYOATo
 xtdPeod59/c9ioT9QupSfk/ChmY3YIFkacHAegOM6bXxquLUfQ0fh0NrfNvnIyvBS2oH
 KIV1+9d1bqBn0ufZqrI6bwsPNP6hozbqeB9e5dg/1j/4m5zTykKdfsA+jqqFu8I8Kgq/
 Srub6nSrThTZKpgI3c33RvaX5ioJ50uYOJ9bT2cx+vvr2X8AO/58N7iq3McTo78SrkRR
 gBOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw9QMGBtmmR+QAN/HpF6kdKM778QZmXWgHblusXA7aTPnDcNzgXJL3RDxih4W7nYeYBo4gjF4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0mPLClBsh7KCA4c8ZnxnaL5Eas46YakYCkjLGQf3q1WVj60E4
 wXRemh65y8fLk+e30VNxp09vWacIpKMMfyTxkYigOMPip3r3uNuh/tdIFV72d3YHXwmMdCmZ7eo
 t75RXjDFrUyY+L5N00EC/4lMy5nfWN6v7Ju8C
X-Gm-Gg: ASbGncsh4IxXqlzBskhnaoYEv4DGFd6IodDQONpgR2lEc4CctoXVYH6vLJmAQjQsKms
 s/nncx9p63iwC5XT7DWHwuaz3T/J8m9xSTOXJLBU4BU2yiBIhiUhObTG5Al+EIUztRPZE934sIQ
 ==
X-Google-Smtp-Source: AGHT+IEvMgQik+UByed/E5IDzR9OwDY1eTR+kmhnb45lzs/rUF4mkTZTKeiVaKPz+DfSNRJSDgKuj1u43tLs3LS2ww8=
X-Received: by 2002:a05:6402:40cd:b0:5da:105b:86c1 with SMTP id
 4fb4d7f45d1cf-5de45073493mr10436225a12.23.1739111768249; Sun, 09 Feb 2025
 06:36:08 -0800 (PST)
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
 <CAC_iWj+cL=kmJL16u2U1rD+Vn_0812VNZ0pJmBNrTgyJmmxATg@mail.gmail.com>
In-Reply-To: <CAC_iWj+cL=kmJL16u2U1rD+Vn_0812VNZ0pJmBNrTgyJmmxATg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 9 Feb 2025 07:35:31 -0700
X-Gm-Features: AWEUYZnsTtSaBQkBzbvg4TCVAmPBd-j1sSlpXET9gBdSRmsGAbuyJVqA-pcRuLE
Message-ID: <CAFLszTjqiZ3UczOCP75ko=gDfH-t20i00g19nvf77UZoTF=g6g@mail.gmail.com>
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
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

On Thu, 6 Feb 2025 at 09:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 6 Feb 2025 at 17:48, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 6 Feb 2025 at 08:16, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 6 Feb 2025 at 14:58, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ilias,
> > > >
> > > > On Thu, 6 Feb 2025 at 05:52, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Thu, 6 Feb 2025 at 14:30, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Wed, 5 Feb 2025 at 09:54, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Heinrich,
> > > > > > >
> > > > > > > On Wed, 5 Feb 2025 at 18:48, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > >
> > > > > > > > On 2/5/25 08:16, Ilias Apalodimas wrote:
> > > > > > > > > For armv8 we are adding proper page permissions for the relocated U-Boot
> > > > > > > > > binary. Add a weak function that can be used across architectures to change
> > > > > > > > > the page permissions
> > > > > > > > >
> > > > > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > > > > ---
> > > > > > > > >   arch/arc/lib/cache.c           |  2 ++
> > > > > > > > >   arch/arm/cpu/arm926ejs/cache.c |  2 ++
> > > > > > > > >   arch/arm/cpu/armv7/cache_v7.c  |  1 +
> > > > > > > > >   arch/arm/cpu/armv7m/cache.c    |  2 ++
> > > > > > > > >   arch/arm/cpu/armv8/cache_v8.c  | 22 ++++++++++++++++++++++
> > > > > > > > >   arch/arm/lib/cache.c           |  2 ++
> > > > > > > > >   arch/m68k/lib/cache.c          |  2 ++
> > > > > > > > >   arch/nios2/lib/cache.c         |  2 ++
> > > > > > > > >   arch/powerpc/lib/cache.c       |  2 ++
> > > > > > > > >   arch/riscv/lib/cache.c         |  2 ++
> > > > > > > > >   arch/sh/cpu/sh4/cache.c        |  2 ++
> > > > > > > > >   arch/xtensa/lib/cache.c        |  2 ++
> > > > > > > > >   include/cpu_func.h             | 16 ++++++++++++++++
> > > > > > > > >   13 files changed, 59 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/arch/arc/lib/cache.c b/arch/arc/lib/cache.c
> > > > > > > > > index 5169fc627fa5..5c79243d7223 100644
> > > > > > > > > --- a/arch/arc/lib/cache.c
> > > > > > > > > +++ b/arch/arc/lib/cache.c
> > > > > > > > > @@ -819,3 +819,5 @@ void sync_n_cleanup_cache_all(void)
> > > > > > > > >
> > > > > > > > >       __ic_entire_invalidate();
> > > > > > > > >   }
> > > > > > > > > +
> > > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > > diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > > index 5b87a3af91b2..857311b3dfad 100644
> > > > > > > > > --- a/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > > +++ b/arch/arm/cpu/arm926ejs/cache.c
> > > > > > > > > @@ -88,3 +88,5 @@ void enable_caches(void)
> > > > > > > > >       dcache_enable();
> > > > > > > > >   #endif
> > > > > > > > >   }
> > > > > > > > > +
> > > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > > diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > > index d11420d2fdd0..14c9be77db8d 100644
> > > > > > > > > --- a/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > > +++ b/arch/arm/cpu/armv7/cache_v7.c
> > > > > > > > > @@ -209,3 +209,4 @@ __weak void v7_outer_cache_flush_all(void) {}
> > > > > > > > >   __weak void v7_outer_cache_inval_all(void) {}
> > > > > > > > >   __weak void v7_outer_cache_flush_range(u32 start, u32 end) {}
> > > > > > > > >   __weak void v7_outer_cache_inval_range(u32 start, u32 end) {}
> > > > > > > > > +__weak void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > > diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
> > > > > > > > > index b6d08b7aad73..458a214e9577 100644
> > > > > > > > > --- a/arch/arm/cpu/armv7m/cache.c
> > > > > > > > > +++ b/arch/arm/cpu/armv7m/cache.c
> > > > > > > > > @@ -370,3 +370,5 @@ void enable_caches(void)
> > > > > > > > >       dcache_enable();
> > > > > > > > >   #endif
> > > > > > > > >   }
> > > > > > > > > +
> > > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > > > diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > > index 670379e17b7a..1cf3870177ee 100644
> > > > > > > > > --- a/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > > +++ b/arch/arm/cpu/armv8/cache_v8.c
> > > > > > > > > @@ -1028,6 +1028,28 @@ skip_break:
> > > > > > > > >       __asm_invalidate_tlb_all();
> > > > > > > > >   }
> > > > > > > > >
> > > > > > > > > +void pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm)
> > > > > > > > > +{
> > > > > > > > > +     u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
> > > > > > > > > +
> > > > > > > > > +     switch (perm) {
> > > > > > > > > +     case MMU_ATTR_RO:
> > > > > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
> > > > > > > > > +             break;
> > > > > > > > > +     case MMU_ATTR_RX:
> > > > > > > > > +             attrs |= PTE_BLOCK_RO;
> > > > > > > > > +             break;
> > > > > > > > > +     case MMU_ATTR_RW:
> > > > > > > > > +             attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
> > > > > > > > > +             break;
> > > > > > > > > +     default:
> > > > > > > > > +             log_err("Unknown attribute %llx\n", perm);
> > > > > > > > > +             return;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     mmu_change_region_attr(addr, size, attrs, false);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >   #else       /* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
> > > > > > > > >
> > > > > > > > >   /*
> > > > > > > > > diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> > > > > > > > > index 516754caeaf9..c7704d8ee354 100644
> > > > > > > > > --- a/arch/arm/lib/cache.c
> > > > > > > > > +++ b/arch/arm/lib/cache.c
> > > > > > > > > @@ -170,3 +170,5 @@ __weak int arm_reserve_mmu(void)
> > > > > > > > >
> > > > > > > > >       return 0;
> > > > > > > > >   }
> > > > > > > > > +
> > > > > > > > > +void __weak pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm) {}
> > > > > > > >
> > > > > > > > I would prefer if the weak function would return -ENOSYS indicating the
> > > > > > > > missing implementation and the real function would return 0 in case of
> > > > > > > > success or an error code on failure. This way the EFI protocol could set
> > > > > > > > the return code if the architecture does not provide support for setting
> > > > > > > > the attributes the passed addresses are invalid.
> > > > > > >
> > > > > > > Sure I'll change that in v2
> > > > > >
> > > > > > Instead of a weak function could you define an API for it, including
> > > > > > structs for the information, a command to adjust it, tests, etc? This
> > > > > > needs a little more thought.
> > > > > >
> > > > > > How about adding to cpu_ops and the information there? The cpu_func.h
> > > > > > which is supposed to be deprecated.
> > > > >
> > > > > Looking at it, I think it's easier as well. I can add move that
> > > > > function in cpu_ops, so it becomes NULL for other architectures. But
> > > > > since this patchset is doing enough already, I'll just move that. In
> > > > > the future, we can move all the cache* and mapping* functions there as
> > > > > well
> > > >
> > > > That sounds great, thank you. I suspect that RISC-V will follow your lead here.
> > >
> > > I wrote the code but cpu uclass isn't even close to doing what we want.
> > > Grepping for defined boards with a cpu uclass driver for arm gives me
> > > back < 20 boards. Given the fact we already found 3 bugs with this
> > > patch applied, I prefer to have a wider coverage and fix U-Boot.
> > > I've uploaded the uclass version here [0], once more boards decide to
> > > use it I will be happy to switch to that, but unfortunately for now,
> > > I'll am obliged to keep the weak function definition.
> >
> > Please at least post the patches as an RFC.
> >
> > We had the same issue with EFI_LOADER back in the day (not wanting to
> > depend on CONFIG_DM) and it has cost us a lot of time.
> >
> > Perhaps make EFI_LOADER select CPU, or depend on CPU? If that's the
> > way you want to go, I'd be happy to do a precursor series to deal with
> > the fallout.
>
> That's not the problem. I can easily add a select of CPU_CONFIG on
> that new Kconfig.
>
> The problem is that I  grep 20 boards supporting it, and out of those
> 20 boards only 6-7 are usable. The rest have cpu compatible nodes that
> don't exist on any DT. e.g grep for 'xlnx,microblaze-7.10'. It's
> defined as a 'cpu driver' but there are no DTs. As a result that cpu
> dm pointer the code relies on, never gets created.
>
> So the result is that this code will never execute unless you run on
> very few boards. I've already sent a link to code that does use DM and
> 'works', so if and when boards adopt it I can resend it.

So perhaps very few boards care? Those that do want this new feature
could enable CPU.

You could even add both interfaces and encourage people to use the CPU
one. At least then people who are trying to DTRT can do so.

I don't like this approach to developing new features - hacking in a
non-DM API so that the code is used more. This is what happened with
EFI_LOADER too. But it's your tree and you obviously don't agree, so
go for it!

Regards,
Simon



>
> Thanks
> /Ilias
>
> >
> > >
> > > [0] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions_uclass?ref_type=heads
> >
> > Regards,
> > Simon
