Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C0FD18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A5C891B2;
	Mon, 14 Oct 2024 17:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TlgjifEm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4514E891FD; Mon, 14 Oct 2024 17:51:19 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BEC3891E9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so20051056d6.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921073; x=1729525873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3M5Us/KEqkOxU9BMydHddK4ofwhQi5yMuP/73mePYhI=;
 b=TlgjifEmgyi6HqAnySw8Yo7u2sxF702U5d0g7RetMA4e9mHvf/UgtPDUlBOq6hKcZK
 bHxCR8W5ZZTVZlP4kbNM/RBWjXcC6lDAWzeGvjj2rel3kYccAZIKNZOx5vLVEU5v8v93
 Ok/jl7H2m2Sdymw0ZxcNWqEUnGo2cmc/cnWXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921073; x=1729525873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3M5Us/KEqkOxU9BMydHddK4ofwhQi5yMuP/73mePYhI=;
 b=tBD4rlajxTQtwpoA1z4jLd8R8a9sE7Pkhe6po5iD8pmp6ubHAk8nYAVDSl0OdHofju
 4kYdUI3w3kX3ZGnmnht+pJMtEa33dqRskFKCpU+lOkKiNdOoKrtxFMxsmf5n7P6i3MGF
 Uup3b9QBfobAwqAhum0rMgk9/iKiZQJstyJtrB16Nm6cYTWQqRFobpfBEkvma3zT8Jnx
 mW6rf3himp/hZ9UemnH/QdbG/DZ9knnvIe131Vn9e28SKLKVb6FOUD/LqhvabYljgPKX
 xjMpVBPYRVlt3GVSkCADkb4J2eIwagrI26c4qoleaMLX7v0R/V5pj9mCiiuVpQ5qD7I+
 HvRg==
X-Gm-Message-State: AOJu0Ywt/wy4PdtqVTHfXaTEfCFdZcrm6AD8+ZVZV8qfpMmbsOq9v1Ad
 GNm67XD9dOq8Fz/LrD9p49pJuchlW/fKHiSUGxCNpiOla00001yU5YyP7G3RCnb8Xbt8LChLVAn
 X1qe5Q/kFibDWf5muS6Lp2s3QRi7ftvVPPKxn
X-Google-Smtp-Source: AGHT+IH9U3jjMoAvAzDjYXZiz3Flx9hNsy6hY05LBDCfyj6eMZYFiZiMbjEuq5HNpWVa3qCIBzO4h4WrKa5ukuKOOwk=
X-Received: by 2002:a05:6214:2b8b:b0:6cb:e6fa:4960 with SMTP id
 6a1803df08f44-6cbf9bde36dmr142102806d6.0.1728921073337; Mon, 14 Oct 2024
 08:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:51:02 -0600
Message-ID: <CAFLszTgvAb7DtjEC-tJ-D+5bk55d2VfNqedyeR0Vt5pX9dpvUA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make EFI memory allocations synchronous with LMB
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> This is part two of the series to have the EFI and LMB modules have a
> coherent view of memory. Part one of this goal was to change the LMB
> module to have a global and persistent memory map. Those patches have
> now been applied to the next branch.
>
> These patches are changing the EFI memory allocation API's such that
> they rely on the LMB module to allocate RAM memory. This fixes the
> current scenario where the EFI memory module has no visibility of the
> allocations/reservations made by the LMB module. One thing to note
> here is that this is limited to the RAM memory region, i.e. the
> EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> added to the EFI memory map, still gets handled by the EFI memory
> module.
>
>
> Some test logs to highlight the issue that is being fixed by the series.
>
> Without patch series
> --------------------
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
>  reserved.count = 0x3
>  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
>  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
>  reserved[2]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
>
>
> => efidebug memmap -- does not show regions allocated by lmb
>
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-000000007f751000 WB
> BOOT DATA        000000007f751000-000000007f756000 WB
> RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> BOOT DATA        000000007f757000-000000007f758000 WB
> RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> BOOT DATA        000000007f77a000-000000007f781000 WB
> BOOT CODE        000000007f781000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT CODE        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT CODE        00000000817d0000-0000000082100000 WB
> =>
>
>
> Trying to allocate EFI memory with already allocated region succeeds(should fail)
> ---------------------------------------------------------------------------------
>
> => efi_mem alloc 2000 42000000
> Address returned 0x42000000
>
> => efidebug memmap
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-0000000042000000 WB
> BOOT DATA        0000000042000000-0000000042002000 WB
> CONVENTIONAL     0000000042002000-000000007f751000 WB
> BOOT DATA        000000007f751000-000000007f756000 WB
> RUNTIME DATA     000000007f756000-000000007f757000 WB|RT
> BOOT DATA        000000007f757000-000000007f758000 WB
> RUNTIME DATA     000000007f758000-000000007f77a000 WB|RT
> BOOT DATA        000000007f77a000-000000007f781000 WB
> BOOT CODE        000000007f781000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT CODE        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT CODE        00000000817d0000-0000000082100000 WB
> =>
>
>
> With patch series
> -----------------
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
>  reserved.count = 0x4
>  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
>  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
>  reserved[2]    [0x7f77a000-0x7f77cfff], 0x00003000 bytes flags: no-notify, no-overwrite
>  reserved[3]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
>
>
> => efidebug memmap -- now shows the lmb allocated memory regions also
> Missing TPMv2 device for EFI_TCG_PROTOCOL
> Type             Start            End              Attributes
> ================ ================ ================ ==========
> CONVENTIONAL     0000000040000000-0000000042000000 WB
> BOOT DATA        0000000042000000-0000000042200000 WB
> CONVENTIONAL     0000000042200000-000000007f74d000 WB
> BOOT DATA        000000007f74d000-000000007f752000 WB
> RUNTIME DATA     000000007f752000-000000007f753000 WB|RT
> BOOT DATA        000000007f753000-000000007f754000 WB
> RUNTIME DATA     000000007f754000-000000007f776000 WB|RT
> BOOT DATA        000000007f776000-00000000807b5000 WB
> RUNTIME DATA     00000000807b5000-00000000807b6000 WB|RT
> BOOT DATA        00000000807b6000-00000000817c0000 WB
> RUNTIME CODE     00000000817c0000-00000000817d0000 WB|RT
> BOOT DATA        00000000817d0000-0000000082100000 WB
> =>
>
>
> Trying to allocate EFI memory with already allocated region fails as expected
> -----------------------------------------------------------------------------
>
> => efi_mem alloc 2000 42000000
> efi_allocate_pages failed 800000000000000e
> =>
>
> Trying to allocate EFI memory with non-allocated region succeeds
> ----------------------------------------------------------------
>
> => efi_mem alloc 2000 42200000
> Address returned 0x42200000
>
>
> lmb_dump_all:
>  memory.count = 0x1
>  memory[0]      [0x40000000-0x820fffff], 0x42100000 bytes flags: none
>  reserved.count = 0x5
>  reserved[0]    [0xe100000-0xeffffff], 0x00f00000 bytes flags: no-map
>  reserved[1]    [0x42000000-0x421fffff], 0x00200000 bytes flags: no-map
>  reserved[2]    [0x42200000-0x42201fff], 0x00002000 bytes flags: no-notify, no-overwrite
>  reserved[3]    [0x7f74e000-0x7f77cfff], 0x0002f000 bytes flags: no-notify, no-overwrite
>  reserved[4]    [0x7f77da00-0x820fffff], 0x02982600 bytes flags: no-overwrite
>
> Changes since V2:
> * Use map_to_sysmem() to get the user-visible address to be shared
>   with the lmb API's.
> * Fix the wording of some comments in efi_add_known_memory() as
>   suggested by Ilias.
> * Rename overlap_no_freemem to overlap_conventional as suggested by
>   Ilias.
>
>
>
> Sughosh Ganu (15):
>   lmb: add versions of the lmb API with flags
>   lmb: add a flag to allow suppressing memory map change notification
>   efi: memory: use the lmb API's for allocating and freeing memory
>   lib: Kconfig: add a config symbol for getting lmb memory map updates
>   add a function to check if an address is in RAM memory
>   lmb: notify of any changes to the LMB memory map
>   efi_memory: do not add U-Boot memory to the memory map
>   ti: k3: remove efi_add_known_memory() function definition
>   stm32mp: remove efi_add_known_memory() function definition
>   lmb: allow for boards to specify memory map
>   layerscape: use the lmb API's to add RAM memory
>   x86: e820: use the lmb API for adding RAM memory
>   efi_memory: do not add RAM memory to the memory map
>   lmb: remove call to efi_lmb_reserve()
>   efi_memory: rename variable to highlight overlap with free memory
>
>  arch/arm/cpu/armv8/fsl-layerscape/cpu.c |   8 +-
>  arch/arm/mach-k3/common.c               |  11 --
>  arch/arm/mach-stm32mp/dram_init.c       |  11 --
>  arch/x86/lib/e820.c                     |  47 +++--
>  common/board_r.c                        |   5 +
>  include/efi_loader.h                    |  27 ++-
>  include/lmb.h                           |  61 +++++++
>  lib/Kconfig                             |  36 ++++
>  lib/efi_loader/Kconfig                  |   2 +
>  lib/efi_loader/efi_memory.c             | 217 +++++++----------------
>  lib/lmb.c                               | 220 +++++++++++++++++++-----
>  11 files changed, 402 insertions(+), 243 deletions(-)
>
> --
> 2.34.1
>
>

One minor question in my mind with all of this is what exactly is the
status of images. I know that the EFI app itself is considered an
image and is passed into the app. So once the app is finished, the
memory becomes available.

But what about the devicetree? Is that provided as an image? Is it
'boottime data'? Who / what is responsible for deciding when that is
no-longer needed? Does it just fall away as soon as exit-boot-services
is called? What about overlays, logos, or anything else? Some of those
need to be passed to Linux, some don't...

BTW at some point it would be good to have tests for this part of EFI.
E.g. set up some lmb, boot an app in sandbox and check that the
correct memory map appears?

Regards,
SImon
