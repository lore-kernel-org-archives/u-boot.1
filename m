Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7459D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E960B891E3;
	Fri, 18 Oct 2024 01:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CjXJFYX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A66D8890C1; Fri, 18 Oct 2024 01:23:54 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D94891C6
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so10371576d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207431; x=1729812231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k+Afva1i21BpAGA1g+5t5Lk3Ud8gsVgnF3AWgmpGBmk=;
 b=CjXJFYX/AP0u5d3Kx8mt+sP3agjj8PHpyc4kn7N1YlCgmB8Ulws6/UHrH7B79QLuDy
 xroKMlM32x0kUQurzKqXHRgPnxm1Oorxlc4gxIvdyxPapvApsmxAfhO8J1OQINrO+x9M
 05BIcOeepJVDCKR67f8u3t1rIXyHtKRpoWhPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207431; x=1729812231;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+Afva1i21BpAGA1g+5t5Lk3Ud8gsVgnF3AWgmpGBmk=;
 b=TPbOEWhUh0odNqhJDbylYCVzV+6jj37hKcMTz4FOOO0u5sNzxG8L/GhUPtokKlr67D
 ewHB73qkUD0R9yd2v30/IZEi3ar6Ooa9Kl/1sjuwG43pdAVHiXEajy5lyJllwt0JK5n0
 Br4RM5zMi8yRH1CGC+PCtzTFk7VyaAGT5Ac/ZHt/KT3BopQ/nmMrneXYlP2KK81mgkh1
 FH2zk7kX/huVt3rk5ZsVEaOGiEAB0dlnmptIF6ChUdqENrc9/m7Vo6Upl5wF1aWA1ylt
 SNM04Ype8iaXFvfXGBzRKyEnEMW+pmg2I7EB4LMEILVVnvavFj0FOhUe94rZT+0F35Sq
 zYkQ==
X-Gm-Message-State: AOJu0YwnyHc+ZKFG3dm1qnoVAAfi58sALtx/zGaviV5n6DfQlVl83hM0
 X9UfR6iW6KjDuwBve0MkH7m13NU54EyBfPwAWP/rXY7nPC0yEinBi4G+6itULL+PRZl2/sLqf63
 xhIDtjuzn4NlIfPUR02UNSE7BJxsjdv74LuwKzrcEnywfSx8=
X-Google-Smtp-Source: AGHT+IGBWPlSkTQd+FxJI5ssDu2C+SYd6htTPk8gbzPwlsg5Dkk78wcCG4bXt5q8+45simi4vcTr8xSMmjBMFRtnGtk=
X-Received: by 2002:a05:6214:5505:b0:6cc:4256:231c with SMTP id
 6a1803df08f44-6cde155b9aamr7688606d6.31.1729207430802; Thu, 17 Oct 2024
 16:23:50 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:40 -0600
Message-ID: <CAFLszTiu=mRQLfG35HMYd004Res6-SNFVBU8qosZjzFY8q9AsA@mail.gmail.com>
Subject: Please pull u-boot-dm
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

I have kept back some of the coreboot patches until the docker change
is applied. It needs a newer version of coreboot.

- Simon

https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/22775
https://dev.azure.com/simon0972/u-boot/_build/results?buildId=69&view=results

The following changes since commit 8efc954fc77eaa734b9fe0cba4b33b75b6e8dbb8:

  Makefile: Drop SPL_FIT_SOURCE support (2024-10-17 08:36:10 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-17oct24

for you to fetch changes up to d9cfa1e3a3d6977feb8265703a6612f1477e9508:

  x86: cpu: Add missing header inclusion (2024-10-17 14:36:23 -0600)

----------------------------------------------------------------
A few new x86 commands and minor improvements
expo improvements
binman support for signing FIT images

----------------------------------------------------------------
Alexander Kochetkov (3):
      binman: fix passing loadables to mkimage on first run
      image-host: fix 'unknown error' error message
      binman: implement signing FIT images during image build

Andy Shevchenko (4):
      x86: cpu: Use default print_cpuinfo() for all
      x86: cpu: Mark a few functions static
      x86: cpu: Add a few prototypes to the header file
      x86: cpu: Add missing header inclusion

Dmitrii Merkurev (1):
      virtio: blk: introduce virtio-block erase support

Marek Vasut (1):
      sandbox: dts: Add missing sandbox, emul phandle to sandbox-pmic

Simon Glass (33):
      video: Allow querying the font size
      coreboot: Switch to a monospaced font
      x86: Show the CPU vendor in bdinfo
      x86: Ensure the CPU identity exists for timer init
      x86: Avoid timer-clock overflow
      x86: Sync up tsc_timer with Linux
      x86: Add a cpuid command
      x86: Add msr command
      x86: coreboot: Update the timestamp code to use sysinfo
      x86: coreboot: Add timestamps from coreboot to bootstage
      x86: coreboot: Enable receiving timestamps from coreboot
      blk: Make functions available unconditionally
      bootstd: Avoid calling unavailable block functions
      bootstd: Avoid depending on BLK
      buildman: Correct some warnings about regex strings
      sandbox_spl: Restrict use of UPL when not enabled
      u_boot_pylib: Support running coverage on selected functions
      binman: Support getting test-coverage on just one test
      binman: Add a tutorial on resolving test-coverage bugs
      video: Add a dark-grey console colour
      video: Avoid starting a new line to close to the bottom
      expo: Place menu items to the right of all labels
      expo: Set the initial next_id to 1
      expo: Use standard numbering for save and discard
      expo: Allow menu items to have values
      expo: Add a little more cedit CMOS logging
      expo: Support menu-item values in cedit
      expo: Drop unneceesary calls to expo_str()
      expo: Drop scene_title_set()
      expo: Add forward declaration for udevice to cedit
      docker: Update coreboot
      doc: Update coreboot's CI information
      x86: Enable RTC command by default

Tom Rini (1):
      x86: Make default_print_cpuinfo be a weak alias for print_cpuinfo

 MAINTAINERS                                    |   1 +
 arch/sandbox/cpu/spl.c                         |   5 +-
 arch/sandbox/dts/cedit.dtsi                    |   3 +
 arch/sandbox/dts/sandbox_pmic.dtsi             |   1 +
 arch/x86/cpu/broadwell/cpu.c                   |  12 -
 arch/x86/cpu/coreboot/coreboot.c               |  12 +-
 arch/x86/cpu/coreboot/timestamp.c              |  11 +-
 arch/x86/cpu/cpu.c                             |   8 +-
 arch/x86/cpu/cpu_x86.c                         |   1 +
 arch/x86/cpu/efi/app.c                         |   5 -
 arch/x86/cpu/efi/payload.c                     |   5 -
 arch/x86/cpu/i386/cpu.c                        |  99 ++++---
 arch/x86/cpu/i386/interrupt.c                  |   2 +-
 arch/x86/cpu/ivybridge/cpu.c                   |  14 -
 arch/x86/cpu/mtrr.c                            |   2 +-
 arch/x86/cpu/qemu/qemu.c                       |   6 -
 arch/x86/cpu/quark/quark.c                     |   6 -
 arch/x86/cpu/slimbootloader/slimbootloader.c   |   5 -
 arch/x86/cpu/tangier/tangier.c                 |   5 -
 arch/x86/cpu/x86_64/cpu.c                      |   6 +
 arch/x86/cpu/x86_64/misc.c                     |   5 -
 arch/x86/include/asm/cpu.h                     |   7 +
 arch/x86/include/asm/u-boot-x86.h              |  18 +-
 arch/x86/lib/bdinfo.c                          |   7 +-
 arch/x86/lib/fsp/fsp_common.c                  |   6 -
 boot/Kconfig                                   |   2 +-
 boot/bootdev-uclass.c                          |   3 +
 boot/cedit.c                                   | 191 +++++++++----
 boot/expo.c                                    |   3 +
 boot/expo_build.c                              |  36 ++-
 boot/scene.c                                   |  61 +++-
 boot/scene_internal.h                          |  30 +-
 boot/scene_menu.c                              |  26 +-
 boot/scene_textline.c                          |   3 +-
 cmd/Kconfig                                    |   1 +
 cmd/font.c                                     |  17 +-
 cmd/x86/Makefile                               |   2 +-
 cmd/x86/cpuid.c                                |  37 +++
 cmd/x86/msr.c                                  |  52 ++++
 configs/coreboot64_defconfig                   |   3 +
 configs/coreboot_defconfig                     |   5 +
 configs/gardena-smart-gateway-mt7688_defconfig |   1 +
 doc/board/coreboot/coreboot.rst                |  14 +-
 doc/develop/binman_tests.rst                   | 734
++++++++++++++++++++++++++++++++++++++++++++++++
 doc/develop/cedit.rst                          |   7 +-
 doc/develop/expo.rst                           |  26 +-
 doc/develop/index.rst                          |   1 +
 doc/usage/cmd/cedit.rst                        |  15 +-
 doc/usage/cmd/cpuid.rst                        |  68 +++++
 doc/usage/cmd/font.rst                         |   6 +-
 doc/usage/cmd/msr.rst                          |  61 ++++
 doc/usage/index.rst                            |   2 +
 drivers/timer/tsc_timer.c                      |  18 +-
 drivers/video/vidconsole-uclass.c              |   4 +-
 drivers/video/video-uclass.c                   |   3 +
 drivers/virtio/virtio_blk.c                    |  91 +++++-
 drivers/virtio/virtio_blk.h                    |  47 ++++
 include/blk.h                                  |   9 +-
 include/cedit.h                                |   1 +
 include/expo.h                                 |  43 ++-
 include/test/cedit-test.h                      |  30 +-
 include/video.h                                |   4 +-
 include/video_console.h                        |   8 +
 test/boot/cedit.c                              |  22 +-
 test/boot/expo.c                               |  26 +-
 test/boot/files/expo_ids.h                     |   3 +-
 test/boot/files/expo_layout.dts                |   5 +-
 test/cmd/Makefile                              |   1 +
 test/cmd/cpuid.c                               |  22 ++
 test/cmd/font.c                                |  21 +-
 test/cmd/msr.c                                 |  38 +++
 tools/binman/binman.rst                        |  10 +-
 tools/binman/btool/mkimage.py                  |   5 +-
 tools/binman/entries.rst                       |   7 +
 tools/binman/etype/fit.py                      |  57 +++-
 tools/binman/ftest.py                          |  95 +++++++
 tools/binman/main.py                           |   6 +-
 tools/binman/test/340_fit_signature.dts        |  98 +++++++
 tools/binman/test/340_rsa2048.key              |  28 ++
 tools/binman/test/341_fit_signature.dts        |  98 +++++++
 tools/binman/test/342_fit_signature.dts        |  61 ++++
 tools/buildman/builder.py                      |   6 +-
 tools/buildman/toolchain.py                    |   8 +-
 tools/docker/Dockerfile                        |   7 +-
 tools/expo.py                                  |  33 ++-
 tools/image-host.c                             |   2 +-
 tools/u_boot_pylib/test_util.py                |  13 +-
 87 files changed, 2241 insertions(+), 348 deletions(-)
 create mode 100644 cmd/x86/cpuid.c
 create mode 100644 cmd/x86/msr.c
 create mode 100644 doc/develop/binman_tests.rst
 create mode 100644 doc/usage/cmd/cpuid.rst
 create mode 100644 doc/usage/cmd/msr.rst
 create mode 100644 test/cmd/cpuid.c
 create mode 100644 test/cmd/msr.c
 create mode 100644 tools/binman/test/340_fit_signature.dts
 create mode 100644 tools/binman/test/340_rsa2048.key
 create mode 100644 tools/binman/test/341_fit_signature.dts
 create mode 100644 tools/binman/test/342_fit_signature.dts

Regards,
Simon
