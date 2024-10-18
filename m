Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A825D3F281
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD7B88D5B;
	Fri, 18 Oct 2024 22:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kz67zR6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F90188D72; Fri, 18 Oct 2024 22:14:27 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10FC488B11
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cbe9914487so15210846d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729282463; x=1729887263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=AVCgqipw1prpa86KwsMP2ODjXhkr9OSs1nViapBWASk=;
 b=kz67zR6B3hujCq8u9qybQi9ocyYR97Hd8xynmMtAky+yCI/jrpWyJu/19KgjpTrOIP
 RBFiBxeCh3Vho0tMoPo1k/vcdc2kR/pd8Uch0Xo8TJBKro1O7qXr/7ld5bGI3m3dgrwy
 hEBN1RPOW1GvvlgOpQhm3R02ue6ZWgzCQgzWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729282463; x=1729887263;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AVCgqipw1prpa86KwsMP2ODjXhkr9OSs1nViapBWASk=;
 b=hHQeieWR4Ye/6fEn4VwivPaNQpemP4Dc+RC0x09Hxaq9T84SMll7UvMwy2wErunAma
 9Gz9wNqGyETq/gJ7FfqaUnW5lHWr/7+GXCInjNVOkB3RNV7T5qDHXlJzTF1dqwYHlPBm
 IpuhV/AuFNPJV6JVLNNLX+2kU8pjxk6cac/ND6Ek0eOFeQbn0DNJpU1jjoCm89tvBFH2
 KyaA0LdjCd9n4ZuEt3qHko3/1sBF5tFciSPohcaLUdHFlfTN6QREd6Q7P1/CQ9BB5wZg
 UOD7FVTUozPRmhufAZEwOBoNzog9I14C/+SRxRLC6EEKK6L3HjnBQyZ7KVxuGps2Uq9S
 iZYg==
X-Gm-Message-State: AOJu0YyX0c1dJ4WXFXGAqUfz4BvzFmKveK8aF4aVCQaOa/df9qynagST
 neghljKJC2D52r5lAjuZUg46+nc7uIArOTUPf4z9c1YOPCH4nby3aRLf+c8NM3bnsnGCOb3iD6h
 lJSghEgOysfXrW1m2F3CgJCEyG4fKGXeDwJSbm88lhZAccVU=
X-Google-Smtp-Source: AGHT+IFbEllhOail1P0EQpggxFCZbhxpr62WUGqoeX0vP3axKLs0Q2sT3FD0uQtfhTPeNqNHvHjd3fOsOirBB0TD+tU=
X-Received: by 2002:a05:6214:5d92:b0:6cb:ea54:7ac with SMTP id
 6a1803df08f44-6cde14d1ce9mr49794396d6.13.1729282462791; Fri, 18 Oct 2024
 13:14:22 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 14:14:11 -0600
Message-ID: <CAFLszThHBm15BCyZTQ9BhqW-_z-2zT0LhaJ=QfcfaMjv78rjFw@mail.gmail.com>
Subject: Please pull u-boot-dm (take 2)
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

The following changes since commit 8ab2178de069194d2eed8fe1b90db7e12cf032bb:

  Merge tag 'u-boot-imx-master-20241018a' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-10-18
09:05:04 -0600)

are available in the Git repository at:

  git://git.denx.de/u-boot-dm.git tags/dm-pull-17oct24-take2

for you to fetch changes up to 44917d586657eeae0401bc29af80011a264002e7:

  x86: cpu: Add missing header inclusion (2024-10-18 14:10:22 -0600)

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

Simon Glass (32):
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

 MAINTAINERS                                  |   1 +
 arch/sandbox/cpu/spl.c                       |   5 +-
 arch/sandbox/dts/cedit.dtsi                  |   3 +
 arch/sandbox/dts/sandbox_pmic.dtsi           |   1 +
 arch/x86/cpu/broadwell/cpu.c                 |  12 -
 arch/x86/cpu/coreboot/coreboot.c             |  12 +-
 arch/x86/cpu/coreboot/timestamp.c            |  11 +-
 arch/x86/cpu/cpu.c                           |   8 +-
 arch/x86/cpu/cpu_x86.c                       |   1 +
 arch/x86/cpu/efi/app.c                       |   5 -
 arch/x86/cpu/efi/payload.c                   |   5 -
 arch/x86/cpu/i386/cpu.c                      |  99 ++++----
 arch/x86/cpu/i386/interrupt.c                |   2 +-
 arch/x86/cpu/ivybridge/cpu.c                 |  14 --
 arch/x86/cpu/mtrr.c                          |   2 +-
 arch/x86/cpu/qemu/qemu.c                     |   6 -
 arch/x86/cpu/quark/quark.c                   |   6 -
 arch/x86/cpu/slimbootloader/slimbootloader.c |   5 -
 arch/x86/cpu/tangier/tangier.c               |   5 -
 arch/x86/cpu/x86_64/cpu.c                    |   6 +
 arch/x86/cpu/x86_64/misc.c                   |   5 -
 arch/x86/include/asm/cpu.h                   |   7 +
 arch/x86/include/asm/u-boot-x86.h            |  18 +-
 arch/x86/lib/bdinfo.c                        |   7 +-
 arch/x86/lib/fsp/fsp_common.c                |   6 -
 boot/bootdev-uclass.c                        |   3 +
 boot/cedit.c                                 | 191 ++++++++++-----
 boot/expo.c                                  |   3 +
 boot/expo_build.c                            |  36 ++-
 boot/scene.c                                 |  61 ++++-
 boot/scene_internal.h                        |  30 ++-
 boot/scene_menu.c                            |  26 ++-
 boot/scene_textline.c                        |   3 +-
 cmd/Kconfig                                  |   1 +
 cmd/font.c                                   |  17 +-
 cmd/x86/Makefile                             |   2 +-
 cmd/x86/cpuid.c                              |  37 +++
 cmd/x86/msr.c                                |  52 +++++
 configs/coreboot64_defconfig                 |   3 +
 configs/coreboot_defconfig                   |   5 +
 doc/board/coreboot/coreboot.rst              |  14 +-
 doc/develop/binman_tests.rst                 | 734
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/develop/cedit.rst                        |   7 +-
 doc/develop/expo.rst                         |  26 ++-
 doc/develop/index.rst                        |   1 +
 doc/usage/cmd/cedit.rst                      |  15 +-
 doc/usage/cmd/cpuid.rst                      |  68 ++++++
 doc/usage/cmd/font.rst                       |   6 +-
 doc/usage/cmd/msr.rst                        |  61 +++++
 doc/usage/index.rst                          |   2 +
 drivers/timer/tsc_timer.c                    |  18 +-
 drivers/video/vidconsole-uclass.c            |   4 +-
 drivers/video/video-uclass.c                 |   3 +
 drivers/virtio/virtio_blk.c                  |  91 ++++++--
 drivers/virtio/virtio_blk.h                  |  47 ++++
 include/blk.h                                |   9 +-
 include/cedit.h                              |   1 +
 include/expo.h                               |  43 +++-
 include/test/cedit-test.h                    |  30 +--
 include/video.h                              |   4 +-
 include/video_console.h                      |   8 +
 test/boot/cedit.c                            |  22 +-
 test/boot/expo.c                             |  26 ++-
 test/boot/files/expo_ids.h                   |   3 +-
 test/boot/files/expo_layout.dts              |   5 +-
 test/cmd/Makefile                            |   1 +
 test/cmd/cpuid.c                             |  22 ++
 test/cmd/font.c                              |  21 +-
 test/cmd/msr.c                               |  38 +++
 tools/binman/binman.rst                      |  10 +-
 tools/binman/btool/mkimage.py                |   5 +-
 tools/binman/entries.rst                     |   7 +
 tools/binman/etype/fit.py                    |  57 ++++-
 tools/binman/ftest.py                        |  95 ++++++++
 tools/binman/main.py                         |   6 +-
 tools/binman/test/340_fit_signature.dts      |  98 ++++++++
 tools/binman/test/340_rsa2048.key            |  28 +++
 tools/binman/test/341_fit_signature.dts      |  98 ++++++++
 tools/binman/test/342_fit_signature.dts      |  61 +++++
 tools/buildman/builder.py                    |   6 +-
 tools/buildman/toolchain.py                  |   8 +-
 tools/docker/Dockerfile                      |   7 +-
 tools/expo.py                                |  33 ++-
 tools/image-host.c                           |   2 +-
 tools/u_boot_pylib/test_util.py              |  13 +-
 85 files changed, 2239 insertions(+), 347 deletions(-)
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
