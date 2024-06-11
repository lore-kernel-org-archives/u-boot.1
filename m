Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32763C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 18:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F85A88768;
	Tue, 11 Jun 2024 20:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qsx2FaJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C665F8874B; Tue, 11 Jun 2024 20:52:32 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8346788748
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 20:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-df78b040314so6243349276.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718131948; x=1718736748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=47tQMnsLChSUUl8miFPBwCN3UMiZ7WJoxqWSxPM/OB0=;
 b=Qsx2FaJssd364XZxPlfXx2yTBDO1EF1aOvnMk05QcE5DYJdF+V70K8vSsSRylVLUt0
 WlbbIal6TxL2vcBkBVij+BUSxbV6ZYZ/lu1DWOZCO0i8Qndn0Nc2udvlFv3X6yPjKfEh
 2JqjzJU9an5DPbnD+sbEUHl5NiG99rtuuVt/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718131948; x=1718736748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47tQMnsLChSUUl8miFPBwCN3UMiZ7WJoxqWSxPM/OB0=;
 b=CC58+1isULEWm8xphMZDiQC82e1TXuRxmgTiIGh7sr7z45iAimepfBHgaeoWTiNJVX
 8JCvelHeSTQtLdd/Fex7ImAWhrBlkzKgvGwPPFgwfA6MuXUXyPmMUs1og7ey6Cjiz/ii
 ebQpbRKi7RWkIX1+mqWExH+fiSCHjRrjWP2VyPlDk6OpYbcrhMJ6wECujJzXLD5m7GIa
 yfK0IM8NsKvW3ngbHsFClGc/wDg5yDldPogTjzps6KUiuZ2C6FbH2U5/WbLDMdBYrBWn
 /7LuWxYj+h52t+A59GXWNCEH4iB9L0c1p7rB6skWP4tvL06BQuhySJg/4d/IHOIrio1d
 ogTQ==
X-Gm-Message-State: AOJu0YydtrI4HEJBeOOMvG702apMKHuCXrj2ufTN3gjv4aijB/ev2l3V
 FH+19eUhdA+ab0MjY12AcPvh+gDurNJJbXNn8cPui254ru7oFaYJDQuUv9xuwfnAU+qEd6qmPBG
 Zd/13R8uQBz7RilD9ScPnL3v/RmraqJg3j++l
X-Google-Smtp-Source: AGHT+IFlGcalIf83WV7B/tIqdHpV6ua/fWHikZ86ZcaRFsNBIonrsH2kRqVUdv2YSD33O/EJI2SQe7pJAWqwTOlc0EY=
X-Received: by 2002:a0d:ea81:0:b0:62c:e9f8:8228 with SMTP id
 00721157ae682-62ce9f88409mr96918927b3.25.1718131947377; Tue, 11 Jun 2024
 11:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 12:52:15 -0600
Message-ID: <CAFLszThkfmJ96aBhDUipzeTeq8ADGPRrYtWfNDFr+E45r=x6rQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/31] Make U-Boot memory reservations coherent
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>
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

On Fri, 7 Jun 2024 at 12:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> The aim of this patch series is to fix the current state of
> incoherence between modules when it comes to memory usage. The primary
> issue that this series is trying to fix is that the EFI memory module
> which is responsible for allocating and freeing memory, does not have
> any visibility of the memory that is being used by the LMB
> module. This is further complicated by the fact that the LMB
> allocations are caller specific -- the LMB memory map is not global
> nor persistent. This means that the memory "allocated" by the LMB
> module might be relevant only for a given function. Hence one of the
> requirements for making the memory usage visible across modules is to
> make LMB allocations persistent and global, and then have means to
> communicate the use of memory across modules.
>
> The first set of patches in this series work on making the LMB memory
> map persistent and global.

For the purposes of testing at least, it should be possible to create
a new LMB. You could have a global_data pointer to the current
(global) one, like we do with driver model.

> This is being done keeping in mind the
> usage of LMB memory by platforms where the same memory region can be
> used to load multiple different images. What is not allowed is to
> overwrite memory that has been allocated by the other module,
> currently the EFI memory module. This is being achieved by introducing
> a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> re-requested once allocated.
>
> The second set of patches are then introducing a notification
> mechanism to indicate any changes to a respective module's memory
> map. This way, any memory allocation/reservation by a module gets
> notified to any interested listners, who then update their memory map
> accordingly, thus keeping memory usage coherent.

What is the need for this listener?

>
> Todo's
> ------
> I have run these patches through CI, but the LMB unit tests need an
> overhaul. I have currently marked these tests for manual run, as
> running these would obviously tamper the LMB memory map, thus
> affecting subsequent tests. The current set of LMB tests are written
> with the assumption of local LMB memory maps. This needs to be
> reworked.

See above

>
> Secondly, there needs to be a test written for testing the various
> scenarios of memory being allocated and freed by different modules,
> namely LMB and EFI. I have written a couple of commands for testing
> the changes that I have made -- I have also included these temporary
> commands to assist anyone who might want to test these changes. But I
> will be working on adding a more comprehensive test.
>
> Lastly, as the series touches common code, there is obviously an
> increase in the size of the image, moreover since the LMB memory is
> now persistent, and the variables do not reside on the stack. I want
> to check if there can be ways of decreasing the size impact of the
> changes.

Perhaps some part of the feature set could be made optional?

Regards,
Simon


>
>
> Sughosh Ganu (31):
>   lmb: remove the unused lmb_is_reserved() function
>   lmb: staticize __lmb_alloc_base()
>   lmb: make the lmb reservations persistent
>   lmb: remove local instances of the lmb structure variable
>   lmb: pass a flag to image_setup_libfdt() for lmb reservations
>   lmb: reserve and add common memory regions post relocation
>   lmb: remove lmb_init_and_reserve_range() function
>   lmb: replcace the lmb_init_and_reserve() function
>   lmb: allow for resizing lmb regions
>   event: add events to notify memory map changes
>   lib: Kconfig: add a config symbol for getting memory map updates
>   add a function to check if an address is in RAM memory
>   efi_memory: notify of any changes to the EFI memory map
>   lmb: notify of any changes to the LMB memory map
>   efi_memory: add an event handler to update memory map
>   lmb: add an event handler to update memory map
>   lmb: remove call to efi_lmb_reserve()
>   sandbox: iommu: remove lmb allocation in the driver
>   zynq: lmb: do not add to lmb map before relocation
>   test: cedit: use allocated address for reading file
>   test: event: update the expected event dump output
>   test: lmb: run the LMB tests only on sandbox
>   test: lmb: initialise the lmb structure before tests
>   test: lmb: add a test case for checking overlapping region add
>   test: lmb: adjust the test case to handle overlapping regions
>   test: lmb: run lmb tests only manually
>   test: bdinfo: dump the global LMB memory map
>   cmd: bdinfo: only dump the current LMB memory
>   temp: mx6sabresd: bump up the size limit of the board
>   temp: cmd: efi_mem: add a command to test efi alloc/free
>   temp: cmd: efi: add a command to dump EFI memory map
>
>  arch/arc/lib/cache.c                 |   4 +-
>  arch/arm/lib/stack.c                 |   4 +-
>  arch/arm/mach-apple/board.c          |  17 +-
>  arch/arm/mach-snapdragon/board.c     |  17 +-
>  arch/arm/mach-stm32mp/dram_init.c    |   8 +-
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |   6 +-
>  arch/m68k/lib/bootm.c                |   7 +-
>  arch/microblaze/lib/bootm.c          |   4 +-
>  arch/mips/lib/bootm.c                |  11 +-
>  arch/nios2/lib/bootm.c               |   4 +-
>  arch/powerpc/cpu/mpc85xx/mp.c        |   4 +-
>  arch/powerpc/include/asm/mp.h        |   4 +-
>  arch/powerpc/lib/bootm.c             |  14 +-
>  arch/riscv/lib/bootm.c               |   4 +-
>  arch/sandbox/cpu/cpu.c               |   5 +
>  arch/sh/lib/bootm.c                  |   4 +-
>  arch/x86/lib/bootm.c                 |   4 +-
>  arch/xtensa/lib/bootm.c              |   4 +-
>  board/xilinx/common/board.c          |  33 --
>  boot/bootm.c                         |  26 +-
>  boot/bootm_os.c                      |   5 +-
>  boot/image-board.c                   |  34 +--
>  boot/image-fdt.c                     |  36 +--
>  cmd/Makefile                         |   2 +
>  cmd/bdinfo.c                         |   5 +-
>  cmd/booti.c                          |   2 +-
>  cmd/bootz.c                          |   2 +-
>  cmd/efi_map_dump.c                   |  28 ++
>  cmd/efi_memory.c                     | 155 ++++++++++
>  cmd/elf.c                            |   2 +-
>  cmd/load.c                           |   7 +-
>  common/board_r.c                     |  20 ++
>  common/event.c                       |   4 +
>  configs/mx6sabresd_defconfig         |   2 +-
>  drivers/iommu/apple_dart.c           |   8 +-
>  drivers/iommu/sandbox_iommu.c        |  17 +-
>  fs/fs.c                              |   7 +-
>  include/efi_loader.h                 |   2 +
>  include/event.h                      |  28 ++
>  include/image.h                      |  27 +-
>  include/lmb.h                        |  96 +++---
>  lib/Kconfig                          |  10 +
>  lib/efi_loader/efi_dt_fixup.c        |   2 +-
>  lib/efi_loader/efi_helper.c          |   2 +-
>  lib/efi_loader/efi_memory.c          | 127 +++++++-
>  lib/lmb.c                            | 442 ++++++++++++++++++---------
>  net/tftp.c                           |   5 +-
>  net/wget.c                           |   5 +-
>  test/boot/cedit.c                    |   5 +-
>  test/cmd/bdinfo.c                    |  22 +-
>  test/lib/Makefile                    |   2 +-
>  test/lib/lmb.c                       | 274 +++++++++--------
>  test/py/tests/test_event_dump.py     |   2 +
>  53 files changed, 1001 insertions(+), 570 deletions(-)
>  create mode 100644 cmd/efi_map_dump.c
>  create mode 100644 cmd/efi_memory.c
>
> --
> 2.34.1
>
>
