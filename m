Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA2AC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 12:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C79B800C1;
	Tue,  4 Feb 2025 13:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t0BTXTI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2FFA800CF; Tue,  4 Feb 2025 13:12:53 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C9E800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 13:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e46ac799015so5116994276.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 04:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738671170; x=1739275970; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oqnn0rMMf2KWA4nH/e4dvVZ5Xv1ibicrMF1Vzf1cx1Q=;
 b=t0BTXTI0h8EIb3RjvAz1W5+TXRkVxPgEjhMNIbMAfu+FfL0TME+u6X+M6RzNFmPf7r
 DKilUgZnYOxPP99syhTzzp5c4v5BXOPbCsfWqhOtkcs2GKZUVtivbN2WFJnHHWaxp7eY
 enMLykkYAr1s47HjCxYkNdz/VogtEfFDCksIZjLKuoav5h6CW4194gtrwfTygvWa5cCi
 fxY/Vya6GlHQdm3kwj0O7KQ+6EixRfge+TYwKjAM3XxQiOamQ7bjQJ4m6Yo/A9A0IPOF
 c2AqrVanWFKd1ZgL2tOwBBidry7FddHspEgeOx5FbXMeH4thqwmUKDhkWdxYpfdolXkw
 VXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738671170; x=1739275970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oqnn0rMMf2KWA4nH/e4dvVZ5Xv1ibicrMF1Vzf1cx1Q=;
 b=crMNZ7/D4eBR7OrxuC9Mo8Y59r7bGWqTPnzeryAFiwKHj0He2rS7A0Zrn3egNYXaf8
 8ZYrm5Bpcm6hM4xvJ88h0qJeGVNv9/DpJxHWeVhFA9MYrPmSTcnCWsvL4+axijh4L6GN
 4x+45ecSZeRK47deprQjr+SzpfkeNGdvflE/lWk3QmFJkFXsokZs74F4u+xIj6vMPer6
 r1AOAssDcu3PMFO40oJHPec1rwo7mx1i6OPzuM5gx5MtnGZ7gp4UEhjAvf/s04V/2w9R
 25k53ZWAq6rxrsFnZh4ogLXyDLTiMnlrHOVGq2HD2cJq5GAAo5W1DsYU7kHik+4z/VOo
 rK6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9r/LxVYRtCch/vdlppQ1lCBbs/TItsMReWPtz4NcLK/JNNHNnPvz5HzsI8Gzbphro3n9evo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5l453+OxlgfSnMbv+31jnoEdcK+WvvZPHt1VJvyN56XX6R8O+
 kVkXpOATIPvDkVHB9jhj/Z+qx7d+gnxOgR5BhApKky8BxFuDdhLCqCj0Y/mNE4SP6LVFXfjFuXF
 j3n92ZPj/olgjHNdQ8oCmE6ksUvJCSMnHuL8QRA==
X-Gm-Gg: ASbGncs6t+o8KHEbOIekJymSvb3WIJkG/bgvn2wHNyBY2aaRxziCWJYQbludYfuhD7K
 aUnsHzEqgjojMADW5NqkQR/chjdp7y7ZtowmfzVW1eHDsltlAYAPtcaFvbCJRq3PPKD6TkKZk
X-Google-Smtp-Source: AGHT+IEs0g4Ux8F0RAXnTQFZK2P2CLEjt0rsV0mSUOi29AJcS4dBs3NDOfSYx83sIETipqzVAj38kxRKQt+i908LDsA=
X-Received: by 2002:a05:6902:917:b0:e58:ac80:3492 with SMTP id
 3f1490d57ef6-e58ac803577mr17610420276.9.1738671169823; Tue, 04 Feb 2025
 04:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
 <b0c9dc17-4229-49db-beab-7a825270be8f@amd.com>
In-Reply-To: <b0c9dc17-4229-49db-beab-7a825270be8f@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 14:12:14 +0200
X-Gm-Features: AWEUYZlf5U8fuQRmPdVcEOBHI0Rg6HtBwB-3NPGalrZVn4DmdIPVKQhUYXdBhYs
Message-ID: <CAC_iWjKQbJuGcxbdgC=E_yR1vFr8E+NjkxDPs2y0jw52EtLm1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Fix page permission on arm64 architectures
To: Love Kumar <love.kumar@amd.com>
Cc: maz@kernel.org, trini@konsulko.com, CFSworks@gmail.com, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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
Content-Transfer-Encoding: quoted-printable
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

Hi Love,

On Tue, 4 Feb 2025 at 13:53, Love Kumar <love.kumar@amd.com> wrote:
>
> Hi Ilias,
>
>
> On 30/01/25 12:50 pm, Ilias Apalodimas wrote:
> > U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we ar=
e
> > better off mapping binaries with proper permissions.
> >
> > This is an attempt to map the U-Boot binary properly, but leave the
> > area we load binaries unaffected and RWX.
> >
> > patch #1 adds printing capabilities for page permissions in meminfo
> > patch #2 prepares our linker scripts, aligns sections in page boundarie=
s etc
> > patch #3 is adding a function to change page tables
> > patch #4 sets the permissions for .rodata, .text and .data
> >
> > There's a few problems problem in this RFC ...
> > - U-Boot has no MMU APIs in place. As a result I just wired up the func=
tion
> >    changing the page permissions in board_r.c but only for arm64. In th=
e long
> >    term we should add an API that other archs can use if they wish/can
> > - meminfo doesn't align all results properly (Caleb?)
> > - I am not setting the permissions of EFI runtime services section on p=
urpose.
> >    Since the OS is allowed to call SetVirtualAddressMap, we need to res=
et the
> >    pages to RWX just before ExitBootServices, so the OS can relocate th=
at code.
> >    In arm64 this isn't a huge problem, because we explicitly disable SV=
AM if
> >    if VA_BITS > 39, but other OSes/archs will have a problem.
> >
> > # TODO:
> > - Long term. Add an MMU API and use that instead of exporting arch spec=
ific
> >    functions
> > - Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
> > - Set the permissions of EFI runtime services anbd reset them before EB=
S()
> > - Fix alignment when printing pages & information
> > - Add a Kconfig option so the feature can be turned off.
> >    The reason is that QEMU CI and some boards, fail because they are tr=
ying to
> >    write RO pages. This usually happens due to variables being wrongly =
defined as
> >    const, but with the updated page permissions this leads to a crash [=
0] [1].
> >    In both cases the reported ESR is 0x9600004f which translates to
> >    "Abort caused by writing to memory" "Permission fault, level 3.". On=
 top of
> >    that not setting pages as RO (and only setting .data and .text secti=
ons) works
> >    fine. So until we find and fix the bugs above we can't turn this on
> >    unconditionally.
> >
> > # Open questions
> > - Is initr_reloc_global_data() the right place to change permissions? O=
r is there
> >    a better/safer place to do that?
> >
> > # How to test patches
> > - Aplly them an enable
> >    CONFIG_CMD_MEMINFO=3Dy
> >    CONFIG_CMD_MEMINFO_MAP=3Dy
> >    'meminfo' should print something along the lines of
> > =3D> meminfo
> > DRAM:  8 GiB
> > Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
> > [0x23ffe1000]                     |  Table |               |
> >    [0x23ffe2000]                   |  Table |               |
> >      [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inn=
er-shareable
> >      [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-=
shareable
> >    [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inn=
er-shareable
> >    [0x23ffea000]                   |  Table |               |
> >      [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inn=
er-shareable
> >      [0x23ffeb000]                 |  Table |               |
> >        [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inn=
er-shareable
> >        [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inne=
r-shareable
> >        [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inne=
r-shareable
> >        [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inn=
er-shareable
> >        [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inne=
r-shareable
> >        [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inn=
er-shareable
> >      [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inn=
er-shareable
> >    [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | In=
ner-shareable
> >    [0x23ffe3000]                   |  Table |               |
> >      [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | No=
n-shareable
> > [0x23ffe4000]                     |  Table |               |
> >    [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | N=
on-shareable
> >
> > [0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0=
-450ccdadfa7e@cherry.de/
> > [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714
> >
> > Ilias Apalodimas (4):
> >    meminfo: add memory details for armv8
> >    arm: Prepare linker scripts for memory permissions
> >    arm64: mmu_change_region_attr() add an option not to break PTEs
> >    arm64: Change mapping for data/rodata/text
> >
> >   Makefile                                | 15 +++++----
> >   arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++-=
-
> >   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
> >   arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
> >   arch/arm/include/asm/armv8/mmu.h        |  2 ++
> >   arch/arm/include/asm/system.h           |  3 +-
> >   arch/arm/mach-snapdragon/board.c        |  2 +-
> >   cmd/meminfo.c                           |  5 +++
> >   common/board_r.c                        |  7 ++++
> >   include/asm-generic/sections.h          |  2 ++
> >   lib/efi_loader/efi_runtime.c            |  2 ++
> >   11 files changed, 97 insertions(+), 28 deletions(-)
>
> This patch series is increasing u-boot size by 13kB which is breaking
> our mini u-boot configurations.
>

There's not much I can do about it, since sections need to be
page-aligned to be able to set permissions.
On v1 I'll have the option under a Kconfig, so you need to keep it disabled=
.

/Ilias

> Without patch:
> text       data     bss     dec     hex filename
> 0        115632       0  115632   1c3b0=E2=80=83u-boot.elf
>
> With patch:
> text       data     bss     dec     hex filename
> 0        128688       0  128688   1f6b0=E2=80=83u-boot.elf
>
> Regards,
> Love Kumar
>
> >
> > --
> > 2.43.0
> >
