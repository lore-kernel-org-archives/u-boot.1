Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2236CC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5B680756;
	Fri, 14 Feb 2025 14:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xjohl3do";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7630980B98; Fri, 14 Feb 2025 14:32:50 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A17806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:32:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e5dab3f3880so1614016276.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 05:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739539965; x=1740144765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L4kQhohDxbnmVaSG+NKJRfCWmIunV6DJ8GDo35Ksc94=;
 b=xjohl3doS3t2mjvUHVbUCxBJ9EsN8l8QZCJDtNyeGl4wk/fBGdnr7s/IKyaRbIkFq5
 0LztlEOUzeMi+kxf98+53zzRFK+lNtAZErrvZwDKGDl5O3S3bB3Ku8M6iQTQDTBAuvUU
 Tj2CDl/ODUoa0iy1kt3XmFa0qjN4Mt5ZUPoGqa0Jcc0N48lJUdp8Cf5avMaFT0QjUCAQ
 8a6qf+lnEUw1w+ASjlnKZbDe0ZT5nt3BGHiBMOzmm5y7e5Jw68N//j/nrc1ylPOx+SZe
 kZNS03NuCp9iX5i3UXgh4xNGNXD58sPYPfcGIHqxUPChKuMZHsnl2hPvzLLKTv/du5Ix
 w9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739539965; x=1740144765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L4kQhohDxbnmVaSG+NKJRfCWmIunV6DJ8GDo35Ksc94=;
 b=TXWjn6WCCq6CqeM32TYERxhqYhp6mM4lOupCqlGDNpae2MXyUVNJrIExJT6Mz1+Gmv
 96etnW+03P6rpXcVFSH5hzeL34AW2dmmRnR8XT1xlVPHjJJJEx/hKg15NBlX/tcLPXXF
 /XS5TyzQuJS/FAmuyt+oyHYCs9vR5vplXOoZvAVrLsGWXjM+mKBf1C7WxTZ+8iiT0CFf
 miJVa8vmzdZzxCcCK38HMVkKO7en9M1vj1xCdBIMQdSRcdUeInahsST4rlB+7sAMLUKS
 cK2ouloGdbuCvWZrL7pkaS9ov94PxiCttuwoKMRCER/SIUyOs1J1rJoCyAAsoEN8WTdz
 IonQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzW96dk3DhN1V9f5l6modvRVQZeG/IgCQw7DxQO2dj45OGDLaztBiAqiQvPmGUPhEjU8Axeg=@lists.denx.de
X-Gm-Message-State: AOJu0YzYLonxvvX7kAFUENaKO7CQx5RmJ5bevF30zWDbDMNAhNyrdzVu
 2ToV+iKWTNrECbbPlDzPA7tbGKCgerPyZGkFiwg/jZQLCQoKmiG0pcufVZmWfI771H+pYPlNBcf
 jvjMHKSNhYQBJffra97RHbIQD9bqygkBXGvGEtw==
X-Gm-Gg: ASbGnctrJJ5VPy/iLHBvNFnBQ5Z/ngHY4Wkmd3/fKPTBK8PAicmpCZCpdi8jU/sR3OM
 cxM2ZDnl1AWZmMmRBsSeDvURDTCkIKW1SSY7vxYHzpvtJJE9v2j9aTR2hCzrp5/X61w+U+KLefA
 ==
X-Google-Smtp-Source: AGHT+IEspthkBOIjicfiLAQgHQSKwQpgGeVX2F3zVh+60oSrzbgpWs81FnpG86MiDbjEQ1O/bZ6T40wla/+O9ZVgSFE=
X-Received: by 2002:a05:6902:218c:b0:e5d:bdbd:acc9 with SMTP id
 3f1490d57ef6-e5dbdbdaef7mr1727581276.6.1739539965418; Fri, 14 Feb 2025
 05:32:45 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <CAFLszThdr-HFauinZASNLT8if67ntJpPMfc6mrRJgCFy+UwsSA@mail.gmail.com>
 <CAC_iWjJky86gtsmPZwoYmeM1W=N4Ny=eowh4a-AYhMFQxPKWcg@mail.gmail.com>
 <CAFLszTj8xc_qF2+VNSaEK6dfo6RFwX1cA-be0xLpukCiRMtjsQ@mail.gmail.com>
In-Reply-To: <CAFLszTj8xc_qF2+VNSaEK6dfo6RFwX1cA-be0xLpukCiRMtjsQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Feb 2025 15:32:09 +0200
X-Gm-Features: AWEUYZkvw2U7lM32H2DII_I1BmjydDz43YcHt6vXcxeP68RzxNZXJiIUivIQZk0
Message-ID: <CAC_iWjKP=yCa+bEXBhmphp7Sdx2-ZV1wga49YK4z7WTe8J_Gvw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Fix page permission on arm64 architectures
To: Simon Glass <sjg@chromium.org>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Sun, 9 Feb 2025 at 16:28, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 6 Feb 2025 at 05:40, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 6 Feb 2025 at 14:33, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 30 Jan 2025 at 00:21, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we are
> > > > better off mapping binaries with proper permissions.
> > > >
> > > > This is an attempt to map the U-Boot binary properly, but leave the
> > > > area we load binaries unaffected and RWX.
> > > >
> > > > patch #1 adds printing capabilities for page permissions in meminfo
> > > > patch #2 prepares our linker scripts, aligns sections in page boundaries etc
> > > > patch #3 is adding a function to change page tables
> > > > patch #4 sets the permissions for .rodata, .text and .data
> > > >
> > > > There's a few problems problem in this RFC ...
> > > > - U-Boot has no MMU APIs in place. As a result I just wired up the function
> > > >   changing the page permissions in board_r.c but only for arm64. In the long
> > > >   term we should add an API that other archs can use if they wish/can
> > >
> > > But this creates more work for others. It would be better to do the
> > > job properly at the start. You don't need to support other archs, but
> > > you should create a plausible API and some structs which others can
> > > use. See cpu.h for some ideas. Of course you can't predict the future,
> > > but others will build on it if you make an effort. Otherwise, I doubt
> > > anyone else will (later) clean it up.
> >
> > I can move that function to cpu_ops.h and have if NULL for other archs
> >
> > >
> > > > - meminfo doesn't align all results properly (Caleb?)
> > > > - I am not setting the permissions of EFI runtime services section on purpose.
> > > >   Since the OS is allowed to call SetVirtualAddressMap, we need to reset the
> > > >   pages to RWX just before ExitBootServices, so the OS can relocate that code.
> > > >   In arm64 this isn't a huge problem, because we explicitly disable SVAM if
> > > >   if VA_BITS > 39, but other OSes/archs will have a problem.
> > > >
> > > > # TODO:
> > > > - Long term. Add an MMU API and use that instead of exporting arch specific
> > > >   functions
> > > > - Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
> > > > - Set the permissions of EFI runtime services anbd reset them before EBS()
> > > > - Fix alignment when printing pages & information
> > > > - Add a Kconfig option so the feature can be turned off.
> > > >   The reason is that QEMU CI and some boards, fail because they are trying to
> > > >   write RO pages. This usually happens due to variables being wrongly defined as
> > > >   const, but with the updated page permissions this leads to a crash [0] [1].
> > > >   In both cases the reported ESR is 0x9600004f which translates to
> > > >   "Abort caused by writing to memory" "Permission fault, level 3.". On top of
> > > >   that not setting pages as RO (and only setting .data and .text sections) works
> > > >   fine. So until we find and fix the bugs above we can't turn this on
> > > >   unconditionally.
> > > >
> > > > # Open questions
> > > > - Is initr_reloc_global_data() the right place to change permissions? Or is there
> > > >   a better/safer place to do that?
> > > >
> > > > # How to test patches
> > > > - Aplly them an enable
> > > >   CONFIG_CMD_MEMINFO=y
> > > >   CONFIG_CMD_MEMINFO_MAP=y
> > > >   'meminfo' should print something along the lines of
> > > > => meminfo
> > > > DRAM:  8 GiB
> > > > Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
> > > > [0x23ffe1000]                     |  Table |               |
> > > >   [0x23ffe2000]                   |  Table |               |
> > > >     [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inner-shareable
> > > >     [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-shareable
> > > >   [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inner-shareable
> > > >   [0x23ffea000]                   |  Table |               |
> > > >     [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inner-shareable
> > > >     [0x23ffeb000]                 |  Table |               |
> > > >       [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inner-shareable
> > > >       [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inner-shareable
> > > >       [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inner-shareable
> > > >       [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inner-shareable
> > > >       [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inner-shareable
> > > >       [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inner-shareable
> > > >     [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inner-shareable
> > > >   [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | Inner-shareable
> > > >   [0x23ffe3000]                   |  Table |               |
> > > >     [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | Non-shareable
> > > > [0x23ffe4000]                     |  Table |               |
> > > >   [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | Non-shareable
> > >
> > > No, this is not a memory map.
> >
> > This is *literally* the memory map.
>
> The memory map currently has a single address and describes what each
> region is for. This looks like a detailed list of some other
> attributes.


>
> >
> > > Please make all that stuff an option.
> > > Try to use generic structs to print it, not ARM-specific code.
> >
> > How? The information in the page tables is arch specific.
>
> enum cpu_mem_permission {
>    CPUMP_RO = BIT(0),
>    CPUMP_RW = BIT(1),
>    etc.
> };

We have that to set the options.
The RFC was also printing a generic RW, RX, RO, but people wanted to
be able to print arch-specific flags when dumping it.

>
> struct cpu_mem_attrs {
>    uint permission;   /* enum cpu_mem_permission */
>    (more things here)
> };
>
> Regards,
> Simon
>
>

/Ilias
> >
> > Thanks
> > /Ilias
> > >
> > > >
> > > > [0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> > > > [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714
> > > >
> > > > Ilias Apalodimas (4):
> > > >   meminfo: add memory details for armv8
> > > >   arm: Prepare linker scripts for memory permissions
> > > >   arm64: mmu_change_region_attr() add an option not to break PTEs
> > > >   arm64: Change mapping for data/rodata/text
> > > >
> > > >  Makefile                                | 15 +++++----
> > > >  arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++--
> > > >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
> > > >  arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
> > > >  arch/arm/include/asm/armv8/mmu.h        |  2 ++
> > > >  arch/arm/include/asm/system.h           |  3 +-
> > > >  arch/arm/mach-snapdragon/board.c        |  2 +-
> > > >  cmd/meminfo.c                           |  5 +++
> > > >  common/board_r.c                        |  7 ++++
> > > >  include/asm-generic/sections.h          |  2 ++
> > > >  lib/efi_loader/efi_runtime.c            |  2 ++
> > > >  11 files changed, 97 insertions(+), 28 deletions(-)
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Regards,
> > > Simon
