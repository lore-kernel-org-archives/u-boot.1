Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F095C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAD987C38;
	Wed, 14 Aug 2024 14:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bGrUdNxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B48889BD; Wed, 14 Aug 2024 14:42:02 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0C1787C38
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf66fe9d8bso1069886d6.0
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723639319; x=1724244119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nmFEXyh9mw63f1MHUh0l/paWTKAamOWhKF8/chYtxvY=;
 b=bGrUdNxSEQKAH4TRyAWb1BF9RPuUqlYijq09v1N52YEPq/MW+IHjyWRho+lxJPqp9/
 BSogEENbUvyU6IViWcYe6i0f9RGVdYX3dgJhxRnXES4ozdqytYkGAj5S8rkBw26R94G3
 l337ZUgTrhhldNDTnluF8bVHcQh6FPg1yCotw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723639319; x=1724244119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nmFEXyh9mw63f1MHUh0l/paWTKAamOWhKF8/chYtxvY=;
 b=kgDNrpwmK4VhrW+8kHMpklrmpjqulp7E/FtZdUiobPCYnSbtsfOFXK5m9d2bSyb4qc
 DcBY6a+vg8MRRzBRtM+sgHwQi4uNozJJQB0pWuQl0k/BspRklQVaQOh/FqORGcO0/5dU
 Efnktj30zT+GvJJuXFHdZZXXkwKwVyYw+xPDAkXouTzprqhgDdw/LdetamqLcSmEbMh+
 r/MiZk5I609PLHEA3eu8y3OijnIv0zFECFse6vYQM60ENy2RwCGxOdP/NaNjFi1MKWy2
 GUd+kYvXmRGykmD3hM9o2jmQXv9W51wJsrLhkinN0EY+TXqsK4UXKaaK55YBoTjwwwsn
 V1jw==
X-Gm-Message-State: AOJu0Ywo1EbsOYOkzwaErbrlWKNixrfvpUay19yzWb7aqK/CcMDrMMxb
 uxJSd7OojbkAsPtH/lSASwf75FyOac+VTt/IPbWDbrFGNRq+rAEWOoXsGrSxb5QkROlxDG79sQw
 O/wxdcXx/HqzAsdxBk0cZY1RM/yncPw72SQ1tUw3xgJOvseM=
X-Google-Smtp-Source: AGHT+IESewk2oVEdVcsJ10vU+dqkXsvex0N5xufPO1trVJwwawHmnWgSPuHiFEskqrSoznbGRGDu5SQ/h9Yy/5t2Y+Q=
X-Received: by 2002:a0c:e888:0:b0:6bf:69c2:1d39 with SMTP id
 6a1803df08f44-6bf69c21e5fmr4082336d6.7.1723639318761; Wed, 14 Aug 2024
 05:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240811145209.4191404-1-sjg@chromium.org>
 <CAC_iWjJXXKi5AV6-M+5D8vC5SJrr71T6HyKj-KjTHJ7QGYZUxg@mail.gmail.com>
In-Reply-To: <CAC_iWjJXXKi5AV6-M+5D8vC5SJrr71T6HyKj-KjTHJ7QGYZUxg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 Aug 2024 06:41:48 -0600
Message-ID: <CAFLszTgA-iED7B9pzJi9Lr2MyajTMYBy+zfqt_KKa+UXKqNAdw@mail.gmail.com>
Subject: Re: [PATCH v3 00/40] efi: Add a test for EFI bootmeth
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
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

Hi Ilias,

On Mon, 12 Aug 2024 at 07:28, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Sun, 11 Aug 2024 at 17:52, Simon Glass <sjg@chromium.org> wrote:
> >
> > The test coverage for the EFI bootmeth is incomplete since it does not
> > actually boot the application.
> >
> > This series creates a simple test for this purpose. It includes a
> > surprising number patches to make this work:
> >
> > - sandbox memory-mapping conflict with PCI
> > - the fix for that causes the mbr test to crash as it sets up pointers
> >   instead of addresses for its 'mmc' commands
> > - the mmc and read commands which cast addresses to pointers
> > - ANSI output from the EFI loader confusing the unit-testing checker
> > - bug in bootdev_next_prio() which causes an infinite loop in EFI test
> > - Hang in sandbox virtio due to EFI probing all block devices
> > - a tricky bug to do with USB keyboard and stdio
> > - a few other minor things
>
> This series is unreviewable and I doubt I am the only one who thinks so.
> There are 40 patches of completely unrelated stuff.
> Please split them up properly.

How about just reviewing the EFI patches? There are only about 14 of those.

Regards,
Simon

>
> Thanks
> /Ilias
> >
> > Changes in v3:
> > - Include the usb.h header file in all cases
> > - Correct the commit subject and message
> > - Add a Fixes tag
> > - use SZ_512 instead of 0x200
> > - Drop the extra- rules since scripts/Makefile.lib takes care of it
> > - Add new patch to drop crt0/relocal extra- rules
> > - Update commit message to describe how the problem will be addressed
> > - Fix 'virtual' typo
> > - Put back the Linaro copyright accidentally removed
> > - Add a Fixes tag
> > - Mention the issue created for this problem
> >
> > Changes in v2:
> > - Fix 'use' typo
> > - Reword commit message
> > - Use 'Firmware vendor' instead of just 'Vendor'
> > - Add many new patches to resolve all the outstanding test issues
> >
> > Simon Glass (40):
> >   nvmxip: Drop the message on probe
> >   nvmxip: Avoid probing on boot
> >   bootstd: Add UT_TESTF_CONSOLE_REC to bootflow tests
> >   test/py: Fix some pylint warnings in test_ut.py
> >   scripts: Update pylint.base
> >   bootstd: Create a function to reset USB
> >   usb: Drop old non-DM code
> >   log: Add a new log category for the console
> >   usb: Add DEV_FLAGS_DM to stdio for USB keyboard
> >   dm: usb: Deal with USB keyboard persisting across tests
> >   test: mbr: Adjust test to use lower-case hex
> >   test: mbr: Adjust test to drop 0x
> >   sandbox: Change the range used for memory-mapping tags
> >   sandbox: Update cpu to use logging
> >   sandbox: Unmap old tags
> >   sandbox: Add some debugging to pci_io
> >   sandbox: Implement reference counting for address mapping
> >   mmc: Use map_sysmem() with buffers in the mmc command
> >   read: Tidy up use of map_sysmem() in the read command
> >   cmd: Fix memory-mapping in cmp command
> >   test: mbr: Unmap the buffers after use
> >   test: mbr: Use a constant for the block size
> >   test: mbr: Use RAM for the buffers
> >   test: mbr: Drop a duplicate test
> >   efi: Use puts() in cout so that console recording works
> >   efi_loader: Put back copyright message
> >   efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
> >   efi: arm: x86: riscv: Drop crt0/relocal extra- rules
> >   efi_loader: Shorten the app rules
> >   efi_loader: Shorten the app rules further
> >   efi: Show the vendor in helloworld
> >   Revert "bootdev: avoid infinite probe loop"
> >   bootstd: Make bootdev_next_prio() continue after failure
> >   efi: Use the same filename for all sandbox builds
> >   bootstd: Add debugging for efi bootmeth
> >   efi: Disable ANSI output for tests
> >   efi: Add a test app
> >   efi: Avoid using sandbox virtio devices
> >   test: Set up an image suitable for EFI testing
> >   efi: Add a test for the efi bootmeth
> >
> >  arch/arm/lib/Makefile               |   8 -
> >  arch/riscv/lib/Makefile             |   4 -
> >  arch/sandbox/cpu/cpu.c              |  38 ++-
> >  arch/sandbox/cpu/state.c            |   9 +-
> >  arch/sandbox/dts/test.dts           |   2 +-
> >  arch/sandbox/include/asm/state.h    |   3 +
> >  arch/sandbox/lib/pci_io.c           |   9 +-
> >  arch/x86/lib/Makefile               |  16 -
> >  boot/bootdev-uclass.c               |  23 +-
> >  boot/bootmeth_efi.c                 |  11 +-
> >  cmd/Kconfig                         |  14 +-
> >  cmd/mem.c                           |  26 +-
> >  cmd/mmc.c                           |  15 +-
> >  cmd/read.c                          |  10 +-
> >  cmd/usb.c                           |  20 --
> >  common/console.c                    |  36 +++
> >  common/log.c                        |   1 +
> >  common/usb_kbd.c                    |  74 +----
> >  configs/octeontx2_95xx_defconfig    |   2 +-
> >  configs/octeontx2_96xx_defconfig    |   2 +-
> >  configs/octeontx_81xx_defconfig     |   2 +-
> >  configs/octeontx_83xx_defconfig     |   2 +-
> >  doc/arch/sandbox/sandbox.rst        |  21 +-
> >  doc/develop/uefi/uefi.rst           |   2 +-
> >  drivers/mtd/nvmxip/nvmxip-uclass.c  |  10 +-
> >  drivers/usb/Kconfig                 |   3 +-
> >  include/console.h                   |   8 +
> >  include/efi_default_filename.h      |  24 +-
> >  include/efi_loader.h                |  21 +-
> >  include/log.h                       |   2 +
> >  include/usb.h                       |  20 +-
> >  lib/efi_loader/Kconfig              |  22 ++
> >  lib/efi_loader/Makefile             |  47 +--
> >  lib/efi_loader/efi_console.c        |  28 +-
> >  lib/efi_loader/efi_disk.c           |  14 +-
> >  lib/efi_loader/helloworld.c         |   6 +
> >  lib/efi_loader/testapp.c            |  68 ++++
> >  scripts/pylint.base                 | 462 ++++++++++++++++------------
> >  test/boot/bootdev.c                 |  37 ++-
> >  test/boot/bootflow.c                | 119 +++++--
> >  test/boot/bootstd_common.c          |   6 +
> >  test/boot/bootstd_common.h          |   8 +
> >  test/cmd/mbr.c                      | 173 ++++++-----
> >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
> >  test/py/tests/test_efi_fit.py       |   2 +-
> >  test/py/tests/test_efi_loader.py    |   2 +-
> >  test/py/tests/test_ut.py            | 146 +++++----
> >  test/test-main.c                    |  38 +++
> >  48 files changed, 962 insertions(+), 654 deletions(-)
> >  create mode 100644 lib/efi_loader/testapp.c
> >  create mode 100644 test/py/tests/bootstd/flash1.img.xz
> >
> > --
> > 2.34.1
> >
