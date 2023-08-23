Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB91CC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D93E864DB;
	Wed, 23 Aug 2023 23:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I7OwzWu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FF0864CD; Wed, 23 Aug 2023 23:11:11 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70CC855CE
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34bad74fb3dso20341525ab.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825067; x=1693429867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MTms7vHMET3h+O5CE49RbVmJwpBDFDE0OKwGgNTamp0=;
 b=I7OwzWu4WAaa1Ku5/ZaEBXNxqsZ/pocMGDAfnYI+ZhbmQZ/DuVAIPn432xk/fAFE1j
 a5a6DZtRQcsm73vGyV4B9n93PCuXGqFOaTCMWIG/36hbbNLRhl86ml26Ix6VCsmf22KZ
 s7Ph057my0mLxv/cTmQey7+YUDD02iM1GRIIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825067; x=1693429867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTms7vHMET3h+O5CE49RbVmJwpBDFDE0OKwGgNTamp0=;
 b=J0pXDeF/9HfETuIogN5WHNhtY9WMJNzKbm9Lc9tdG16EDOVLsjlzSG/udQcftNfJWA
 tvml7TIvQRulFseTjILa/FG9a01S3yzg+S5lXUZiY1YO5hKImjhWy5l4jwzGbYf+y4Ps
 lW9wFAHZOk50T7+Oo1l6VX18NPqwTQGQ4J9YwfM363FxuyzIvX/H4pz0gcFTTs/ufhoz
 60O+J5jRrK5iV35Aqwore81afrld/4940EucRVmdLALPpyFWRmDbUq1Rmo3z8PExpJBy
 sOWsPdmdEkm+rakfWLANLSZqzvQyq1HySF+MkqJCV0px71W6B20/cqL1JcZAltimlICX
 MvXQ==
X-Gm-Message-State: AOJu0YxFp2ZkA2SjJHVjDlZy4TMil1nbmfO3WifSbhfVFu7GBLesRG14
 oQ1PuQy0TF1bUuiw5gLWqWF9GIyEPav0DNJwZyA=
X-Google-Smtp-Source: AGHT+IHpV7HoI0+/q4Yxb8QCvqXQ1vI/raoY8JZqHiXovBASOvM26uP4jSz6TyrRDEHSaHgM8qV67A==
X-Received: by 2002:a05:6e02:2199:b0:349:501:129f with SMTP id
 j25-20020a056e02219900b003490501129fmr5066528ila.2.1692825067260; 
 Wed, 23 Aug 2023 14:11:07 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 00/20] x86: efi: Fixes and improvements for coreboot
Date: Wed, 23 Aug 2023 15:10:17 -0600
Message-ID: <20230823211059.1235147-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This little series fixes various bugs and annoyances in coreboot and
coreboot64.

With this both coreboot and coreboot64 start up and work reasonably well
on Brya (x86 Chromebook) and U-Boot can boot common Linux distros.

- Make coreboot64 debug UART start reliably
- Avoid the long USB-init delay on startup
- Correct the timer speed on coreboo64
- Fix a bootstd cros bug (will likely be squashed into another patch)
- Fix the terribly slow console scrolling

With v2 I have also brought in some lost x86 patches so they are all in
one series.

Changes in v4:
- Fix arm and riscv
- Rewrite this to use events instead

Changes in v3:
- Allow SMBIOS if EFI_LOADER is enabled
- Reword the help
- Use log_debug() to show the message
- Squash in the next patch

Changes in v2:
- Update the malloc size too
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch
- Add new patch

Simon Glass (20):
  x86: coreboot: Add IDE and SATA
  x86: coreboot: Enable standard boot
  x86: coreboot: Rearrange arch_cpu_init()
  x86: Set the CPU vendor in SPL
  x86: Allow APCI in SPL
  x86: coreboot: Look for DBG2 UART in SPL too
  x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
  x86: coreboot: Drop USB init on startup
  x86: coreboot: Align options between coreboot and coreboot64
  x86: coreboot: Enable VIDEO_COPY
  efi: x86: Correct the condition for installing ACPI tables
  x86: smbios: Add a Kconfig indicating SMBIOS-table presence
  bootstd: Keep track of use of usb stop
  Record the position of the SMBIOS tables
  efi: Use the installed SMBIOS tables
  x86: coreboot: Record the position of the SMBIOS tables
  x86: doc: Move into its own directory
  x86: doc: Update summaries and add links
  x86: doc: Split out manual booting into its own file
  x86: doc: coreboot: Mention 64-bit Linux distros

 arch/arm/include/asm/global_data.h      |   3 +
 arch/riscv/include/asm/global_data.h    |   3 +
 arch/sandbox/include/asm/global_data.h  |   1 +
 arch/x86/cpu/coreboot/coreboot.c        |  16 +-
 arch/x86/cpu/x86_64/cpu.c               |   7 +
 arch/x86/dts/coreboot.dts               |   1 +
 arch/x86/include/asm/global_data.h      |   1 +
 arch/x86/lib/coreboot/cb_sysinfo.c      |   1 +
 arch/x86/lib/tables.c                   |   3 +
 board/Marvell/mvebu_armada-37xx/board.c |   2 +
 boot/bootdev-uclass.c                   |  27 +++
 configs/coreboot64_defconfig            |  25 +-
 configs/coreboot_defconfig              |  21 +-
 doc/arch/index.rst                      |   2 +-
 doc/arch/x86/index.rst                  |  12 +
 doc/arch/x86/manual_boot.rst            | 276 ++++++++++++++++++++++
 doc/arch/{ => x86}/x86.rst              | 295 ++----------------------
 doc/board/coreboot/coreboot.rst         |  38 ++-
 drivers/serial/Kconfig                  |   2 +-
 drivers/usb/host/usb-uclass.c           |   8 +
 drivers/video/coreboot.c                |  12 +
 include/asm-generic/global_data.h       |   8 +
 include/bootdev.h                       |   9 +
 lib/Kconfig                             |  24 +-
 lib/efi_loader/Makefile                 |   4 +-
 lib/efi_loader/efi_setup.c              |  20 +-
 lib/efi_loader/efi_smbios.c             |  72 +++---
 test/py/tests/test_event_dump.py        |   1 +
 28 files changed, 544 insertions(+), 350 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 create mode 100644 doc/arch/x86/manual_boot.rst
 rename doc/arch/{ => x86}/x86.rst (64%)

-- 
2.42.0.rc1.204.g551eb34607-goog

