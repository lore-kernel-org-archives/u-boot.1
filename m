Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9814DD1F9C2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012EC889AA;
	Tue, 15 Oct 2024 21:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yBpLLCzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF47889C3; Tue, 15 Oct 2024 21:26:33 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35388897F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso4164881a91.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729020389; x=1729625189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0V4gNayZteqFb6DcqeTXjSUst/1AQMu8r01fxfy04U4=;
 b=yBpLLCzq0Hvw5eVndIw4nYLnrq+63LVt+ZUlneyUuUmCR86zuGhslHSq0sCJ494p0G
 FRDWk4ayQ76Flz+9nmjfiBK2DBi5FQMbIfVnbluMAgIYU5heKyTHJWhi54zi1neT1+6I
 7hQxF8gNHfo79O7FTRpBRzJ/0FEYsMZwEd2C0vDme7kNW062plrcGfn15Dr7Pm5ff0/n
 QHTQTWycbpYLpkLbuyYZfTmW81/kvV1AvXsSI6KdAarcHToqy0Yx7B+CgoDfZh9QalgB
 K5UyEm5ohZwYg2UyAAPSlJTp+7ZQDPPHqEUEdsLmzMSxTHMZeHpVMmS12MtwPzuoeibI
 +LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729020389; x=1729625189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0V4gNayZteqFb6DcqeTXjSUst/1AQMu8r01fxfy04U4=;
 b=OzVE45f/FABNvNvyrY5r7c3mufzT7549flWzMtCWy6exWDwcysCC6aR0v4rR0qHgqO
 whKgcdntlGp+k0xAjABGKufGFQ4NxTAJLq3UYNvEmyTkv7B0RyyPNyYkufwEbVkHKw2W
 bqODRWZOZNaQEP6t/ezKldarM49swJTlsF1K9+umN2ii8BbQp1txFS7pIqxrjP96bEXa
 MAlXHzdzh7/B+qGBMB0dJrKYAdD+LmqQSSN9/wOSXiMHXVqDh9lF1MJlrrxukx54P1Tt
 8C2BnptVgjHViNdCQQZtzZgEAQcoWFWzxdryEKiqUsSYa9WdcUfkvPKRJloYfCeuw82J
 3xOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw3jdp6YSBPOfJxdzbSfzdcVGlcN7HTXXO4P+0n/tHMfVV8a5T13L/nSXsq31zyTNYGsG6sMI=@lists.denx.de
X-Gm-Message-State: AOJu0YyW29c8tp6h/HCwPMYDMFfbNhN9AIUhO1B+8z/aeRLg9doGwFV5
 R+7l3hLSZemkB6YjRrebgbg+YoZxHvCFzrlA+uAciroQaUk9rFOk3DAH1xVluYKxTYNeD0RAFHB
 bmiXGyu/iH4qG85WS/lAG73CH4Lky/JTEmg5u041+b/+t6t7m
X-Google-Smtp-Source: AGHT+IGVESTWg3lnx+NG/0E/qSy9N9pclx38ETehNzct6T7zP8CCoyiOC3nxf6bCUZZ4D/fijCz44ic3W9FMRUQZUHY=
X-Received: by 2002:a17:90b:e8c:b0:2e0:a77e:8305 with SMTP id
 98e67ed59e1d1-2e31536f27cmr15441645a91.39.1729020389374; Tue, 15 Oct 2024
 12:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <CAFLszThyzu=ADuijsLAamkhAfNGHE4WtssFwSKRBfU25EytbLQ@mail.gmail.com>
 <20241015191605.GS53053@bill-the-cat>
In-Reply-To: <20241015191605.GS53053@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 22:25:52 +0300
Message-ID: <CAC_iWj+rfT6b8BSKCgAT8tc3K-uy6MDCh2i1Rn5fzg+YHY+jEg@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Make EFI memory allocations synchronous with LMB
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
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

Thanks Tom,

On Tue, 15 Oct 2024 at 22:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 15, 2024 at 12:45:59PM -0600, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 15 Oct 2024 at 09:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > >
> > > This is part two of the series to have the EFI and LMB modules have a
> > > coherent view of memory. Part one of this goal was to change the LMB
> > > module to have a global and persistent memory map. Those patches have
> > > now been applied to the next branch.
> > >
> > > These patches are changing the EFI memory allocation API's such that
> > > they rely on the LMB module to allocate RAM memory. This fixes the
> > > current scenario where the EFI memory module has no visibility of the
> > > allocations/reservations made by the LMB module. One thing to note
> > > here is that this is limited to the RAM memory region, i.e. the
> > > EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> > > added to the EFI memory map, still gets handled by the EFI memory
> > > module.
> > >
> > >
> > > Changes since V3:
> > > * Add comments for the LMB_NOOVERWRITE and LMB_NONOTIFY flags
> > > * Drop use of is_addr_in_ram() function
> > > * Drop use of CONFIG_MEM_MAP_UPDATE_NOTIFY symbol to check if the
> > >   notification needs to be sent.
> > > * s/lmb_notify/lmb_should_notify
> > > * Put a check for EFI_LOADER in the lmb_should_notify() function
> > >
> > >
> > > Some test logs to highlight the issue that is being fixed by the series.
> > >
> > > Without patch series
> > > --------------------
> > >
> > > lmb_dump_all:
> > >  memory.count = 0x1
> > >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> > >  reserved.count = 0x3
> > >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> > >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> > >  reserved[2]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
> > >
> > >
> > > => efidebug memmap -- does not show regions allocated by lmb
> > >
> > > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > > Type             Start            End              Attributes
> > > ================ ================ ================ ==========
> > > CONVENTIONAL     0000000040000000-000000007f751000 WB
> > > BOOT DATA        000000007f751000-000000007f756000 WB
> > > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > > BOOT DATA        000000007f757000-000000007f758000 WB
> > > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > > BOOT DATA        000000007f77a000-000000007f781000 WB
> > > BOOT CODE        000000007f781000-00000000807b5000 WB
> > > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > > BOOT CODE        00000000817d0000-0000000082100000 WB
> > > =>
> > >
> > >
> > > Trying to allocate EFI memory with already allocated region succeeds(should fail)
> > > ---------------------------------------------------------------------------------
> > >
> > > => efi_mem alloc 2000 42000000
> > > Address returned 0x42000000
> > >
> > > => efidebug memmap
> > > Type             Start            End              Attributes
> > > ================ ================ ================ ==========
> > > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > > BOOT DATA        0000000042000000-0000000042002000 WB
> > > CONVENTIONAL     0000000042002000-000000007f751000 WB
> > > BOOT DATA        000000007f751000-000000007f756000 WB
> > > RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> > > BOOT DATA        000000007f757000-000000007f758000 WB
> > > RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> > > BOOT DATA        000000007f77a000-000000007f781000 WB
> > > BOOT CODE        000000007f781000-00000000807b5000 WB
> > > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > > BOOT CODE        00000000807b6000-00000000817c0000 WB
> > > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > > BOOT CODE        00000000817d0000-0000000082100000 WB
> > > =>
> > >
> > >
> > > With patch series
> > > -----------------
> > >
> > > lmb_dump_all:
> > >  memory.count = 0x1
> > >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> > >  reserved.count = 0x4
> > >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> > >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> > >  reserved[2]    [0x7f74f000-0x7f77dfff], 0x0002f000 bytes flags: no-notify, no-overwrite
> > >  reserved[3]    [0x7f77ea00-0x820fffff], 0x02981600 bytes flags: no-overwrite
> > >
> > >
> > > => efidebug memmap
> > > Type             Start            End              Attributes
> > > ================ ================ ================ ==========
> > > BOOT DATA        000000000e100000-000000000f000000 WB
> > > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > > BOOT DATA        0000000042000000-0000000042200000 WB
> > > CONVENTIONAL     0000000042200000-000000007f74e000 WB
> > > BOOT DATA        000000007f74e000-000000007f753000 WB
> > > RUNTIME DATA     000000007f753000-000000007f754000 WB|RT
> > > BOOT DATA        000000007f754000-000000007f755000 WB
> > > RUNTIME DATA     000000007f755000-000000007f777000 WB|RT
> > > BOOT DATA        000000007f777000-00000000807b6000 WB
> > > RUNTIME DATA     00000000807b6000-00000000807b7000 WB|RT
> > > BOOT DATA        00000000807b7000-00000000817c0000 WB
> > > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > > BOOT DATA        00000000817d0000-0000000082100000 WB
> > >
> > >
> > > Trying to allocate EFI memory with already allocated region fails
> > > -----------------------------------------------------------------
> > >
> > > => efi_mem alloc 2000 42000000
> > > efi_allocate_pages failed 800000000000000e
> > > =>
> > >
> > > Trying to allocate EFI memory with non-allocated region succeeds
> > > ----------------------------------------------------------------
> > >
> > > => efi_mem alloc 2000 42200000
> > > Address returned 0x42200000
> > >
> > > => efidebug memmap
> > > Type             Start            End              Attributes
> > > ================ ================ ================ ==========
> > > BOOT DATA        000000000e100000-000000000f000000 WB
> > > CONVENTIONAL     0000000040000000-0000000042000000 WB
> > > BOOT DATA        0000000042000000-0000000042202000 WB
> > > CONVENTIONAL     0000000042202000-000000007f74d000 WB
> > > BOOT DATA        000000007f74d000-000000007f752000 WB
> > > RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
> > > BOOT DATA        000000007f753000-000000007f754000 WB
> > > RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
> > > BOOT DATA        000000007f776000-00000000807b5000 WB
> > > RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> > > BOOT DATA        00000000807b6000-00000000817c0000 WB
> > > RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> > > BOOT DATA        00000000817d0000-0000000082100000 WB
> > > =>
> > >
> > > lmb_dump_all:
> > >  memory.count = 0x1
> > >  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
> > >  reserved.count = 0x5
> > >  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
> > >  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
> > >  reserved[2]    [0x42200000-0x42201fff], 0x00002000 bytes flags: no-notify, no-overwrite
> > >  reserved[3]    [0x7f74e000-0x7f77cfff], 0x0002f000 bytes flags: no-notify, no-overwrite
> > >  reserved[4]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
> > >
> > >
> > > Sughosh Ganu (15):
> > >   lmb: add versions of the lmb API with flags
> > >   lmb: add a flag to allow suppressing memory map change notification
> > >   lmb: add and reserve memory above ram_top
> > >   efi: memory: use the lmb API's for allocating and freeing memory
> > >   lmb: notify of any changes to the LMB memory map
> > >   efi_memory: do not add U-Boot memory to the memory map
> > >   ti: k3: remove efi_add_known_memory() function definition
> > >   stm32mp: remove efi_add_known_memory() function definition
> > >   lmb: allow for boards to specify memory map
> > >   layerscape: use the lmb API's to add RAM memory
> > >   x86: e820: use the lmb API for adding RAM memory
> > >   efi_memory: do not add RAM memory to the memory map
> > >   lmb: remove call to efi_lmb_reserve()
> > >   efi_memory: rename variable to highlight overlap with free memory
> > >   lmb: replace the double-underscore with single-underscore for all
> > >     functions
> > >
> > >  arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
> > >  arch/arm/mach-k3/common.c               |  11 --
> > >  arch/arm/mach-stm32mp/dram_init.c       |  11 --
> > >  arch/x86/lib/e820.c                     |  47 +++--
> > >  include/efi_loader.h                    |  27 ++-
> > >  include/lmb.h                           |  63 ++++++
> > >  lib/Kconfig                             |  19 ++
> > >  lib/efi_loader/Kconfig                  |   1 +
> > >  lib/efi_loader/efi_memory.c             | 217 ++++++---------------
> > >  lib/lmb.c                               | 242 ++++++++++++++++++------
> > >  10 files changed, 389 insertions(+), 257 deletions(-)
> >
> > I have stated my objections and won't repeat them here. With -master
> > currently broken for EFI, and many of the patches in this series being
> > required even with my view of the world, I think the best thing is to
> > apply this series now, and move on.
>
> Thank you, Simon, for saying this. I will be applying this shortly.

I know this is kind of urgent, but it's late here, I'll be able to
have a look at the patches tomorrow. From a quick skim they look
reasonable, so feel free to apply it and we can send fixes if anything
isn't working as intended.

Thanks
/Ilias
>
> --
> Tom
