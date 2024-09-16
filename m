Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A3FC3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 06:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F5E88E5D;
	Mon, 16 Sep 2024 08:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w1XBJFub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A27488D33; Mon, 16 Sep 2024 08:33:06 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B8C88E5F
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5365c512b00so4707494e87.3
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 23:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726468383; x=1727073183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jTHvTOstYIDd7v7pSiE25EEigoUIMSbvUWbUBNZT9Yw=;
 b=w1XBJFubGEYFsan9wLj5TT/byndpRq4R0Iw37bBVbmTgsqI7m4uBa0UO+MosFGGb8r
 HaoZX3n35f33nGGCDdnDWt/dahW0qSOPSjDcSUWTKJawpTE7OzSqKqhguWb2RwZa5cdc
 XwoW3JSK25iyq79611ueZzh1wg9wliA/ygOguevuGuQBeCVDoISn9rotAif1jyWUHUlU
 4OwI8x5dUsm+l/JOlJro+EPhXZSpwObVjc/0lnDQGU0okCfC5TdfKgkgMhqTC69ZTlAO
 G1GHR/To4pIK7HIX1mwDEspLh+euz8S/a9iO8GueXMK7ecdbyhWpdCgFs3cepqd9Xj3J
 Tn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726468383; x=1727073183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jTHvTOstYIDd7v7pSiE25EEigoUIMSbvUWbUBNZT9Yw=;
 b=fqbWd9wcVuFUT1cVoH3Mtqe6CGvNmzjfimZFq32LVnJMbiV95GBSfZoavjSp2G0gGV
 Y9ZcLsneiLF8F4ZbjKRRMW8++VfpiAIDTKZbZj0Mud/R5aWWqAiYuwLKPuNFsC168nbo
 CjE2ylFmkIEdUm5S9FsqEBT2CBTMmREqUXOZxkKflXIkING49fa71jMWyvUedbXoe6gH
 T+/XOzlaA9lPkPFZg7S8XPEDajd+XJfA/ieugZdHxLxVkLPVKqhJkDrT75PTCFiO5mo9
 j2JkFWqzDpg2ZIK2tQACjTqDk3c67gHV6BNrScFzuQKkZvLIbwgPwmqmOLqQYBvqtgKU
 rK5g==
X-Gm-Message-State: AOJu0YyFqFD5uUFqWRWnasDWtpVcF8grJqW6/N8L9mV+F72irDZZijeM
 GUMf5JgNKv+hIJkxxKMcQtau8QGwLvk0YG8LrN56FLCzUF2IoXlsAehfCxQuZgvJwjh+VvmhVYO
 gNJ58EbgjCNJ7bOOqQABp9dG01v6V/CxNL3l34Q==
X-Google-Smtp-Source: AGHT+IGfSmIRPQKLsJNZkZpM8S2whv+bR4s4qVU9a/AJ0BXgOjwLOy5xBp5ONwmKR23+RSeB5IPCLhyKAU90uBX213k=
X-Received: by 2002:a05:6512:3e17:b0:52c:df3d:4e9d with SMTP id
 2adb3069b0e04-53678feb12amr8408344e87.37.1726468382973; Sun, 15 Sep 2024
 23:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-6-sughosh.ganu@linaro.org>
 <7c94a278-e7a1-4c82-9135-6cfedba1143b@ti.com>
In-Reply-To: <7c94a278-e7a1-4c82-9135-6cfedba1143b@ti.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 16 Sep 2024 12:02:52 +0530
Message-ID: <CADg8p94UpbpKaaz=UdrBr7UBiy4dauXrDUNehwghTxmJRBPTFg@mail.gmail.com>
Subject: Re: [PATCH v4 05/27] lmb: make LMB memory map persistent and global
To: Vaishnav Achath <vaishnav.a@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>,
 Nishanth Menon <nm@ti.com>
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

On Mon, 16 Sept 2024 at 11:34, Vaishnav Achath <vaishnav.a@ti.com> wrote:
>
> Hi Sughosh
>
> On 26/08/24 17:29, Sughosh Ganu wrote:
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [sjg: Optimise the logic to add a region in lmb_add_region_flags()]
> > [sjg: Use a stack to store pointer of lmb struct when running lmb tests]
> > ---
> > Changes since V3:
> > * Fix checkpatch warnings of spaces between function name and
> >    open parantheses.
> > * s/uint64_t/u64 as suggested by checkpatch.
> > * Remove unneccessary parantheses in lmb.c as suggested by checkpatch.
> > * Fix alignment in test/cmd/bdinfo.c as suggested by checkpatch.
> >
> >   arch/arc/lib/cache.c                 |   4 +-
> >   arch/arm/lib/stack.c                 |   4 +-
> >   arch/arm/mach-apple/board.c          |  17 +-
> >   arch/arm/mach-snapdragon/board.c     |  17 +-
> >   arch/arm/mach-stm32mp/dram_init.c    |   8 +-
> >   arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
> >   arch/m68k/lib/bootm.c                |   7 +-
> >   arch/microblaze/lib/bootm.c          |   4 +-
> >   arch/mips/lib/bootm.c                |  11 +-
> >   arch/nios2/lib/bootm.c               |   4 +-
> >   arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
> >   arch/powerpc/include/asm/mp.h        |   4 +-
> >   arch/powerpc/lib/bootm.c             |  14 +-
> >   arch/riscv/lib/bootm.c               |   4 +-
> >   arch/sh/lib/bootm.c                  |   4 +-
> >   arch/x86/lib/bootm.c                 |   4 +-
> >   arch/xtensa/lib/bootm.c              |   4 +-
> >   board/xilinx/common/board.c          |   8 +-
> >   boot/bootm.c                         |  26 +-
> >   boot/bootm_os.c                      |   5 +-
> >   boot/image-board.c                   |  34 +-
> >   boot/image-fdt.c                     |  35 +-
> >   cmd/bdinfo.c                         |   6 +-
> >   cmd/booti.c                          |   2 +-
> >   cmd/bootz.c                          |   2 +-
> >   cmd/elf.c                            |   2 +-
> >   cmd/load.c                           |   7 +-
> >   drivers/iommu/apple_dart.c           |   8 +-
> >   drivers/iommu/sandbox_iommu.c        |  16 +-
> >   fs/fs.c                              |   7 +-
>
> In fs the reserved region is not being freed after read, while
> other loaders free them (cmd/load.c), this patch uncovers the issue
> since now other loaders cannot use the same memory location for load.
> For example now someone cannot do:

The idea with the LMB memory is that it is not really an allocation,
but setting aside memory for use. Now there was a discussion earlier
on the mailing list if this is actually an allocation or not, but this
is what the functions have been called from it's early days. But the
way the code is designed now, even with the global and persistent
memory map, we have the LMB_NONE flag which is used to allow for the
same memory region to be re-allocated/re-reserved.

>
> mmc load .. $loadaddr ...
> <do something with above contents>
> tftp $loadaddr ..

The issue above is what I mentioned to Prasad in one of my earlier
replies to the patch that he had sent [1]. What can be done is to
unify the manner in which callers ask for LMB memory -- that would
mean changing the behaviour of the tftp code to use the logic used in
the fs_read_lmb_check() function. I believe this method of loading to
an address is more beneficial as it allows memory re-use.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-September/564610.html

>
> where this worked previously since it was not global, I have sent a
> fix for this :
> https://lore.kernel.org/all/20240916054038.2125910-1-vaishnav.a@ti.com/
>
> Thanks and Regards,
> Vaishnav
>
> >   include/image.h                      |  28 +-
> >   include/lmb.h                        | 111 ++----
> >   lib/efi_loader/efi_dt_fixup.c        |   2 +-
> >   lib/efi_loader/efi_helper.c          |   2 +-
> >   lib/lmb.c                            | 446 +++++++++++++---------
> >   net/tftp.c                           |   5 +-
> >   net/wget.c                           |   5 +-
> >   test/cmd/bdinfo.c                    |  41 +-
> >   test/lib/lmb.c                       | 542 +++++++++++++--------------
> >   39 files changed, 714 insertions(+), 746 deletions(-)
> >
>
