Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70B9CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30EE386C00;
	Wed, 20 Sep 2023 05:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6BTd3KQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D65786C00; Wed, 20 Sep 2023 05:00:35 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706FF86BC4
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso238742039f.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178832; x=1695783632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BoWuIZslAKIECp3U9U4lVchJZeGm3yYBZZsuhqn9A/k=;
 b=Y6BTd3KQDxF07U96pKUYqq3tCXR3/UZLghpPozDBDfJfuzZ4bg5BeDNCp3fZjfTuP8
 6l+JYTTme94okvxoarhELEFMPeNgt1cCzoutwCLGNzpqEeTcKDjZAWH3Ay6Mv739NYqq
 X6QLh5d5NQGzwVVlQgwr5b11USK5aAeUHcWyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178832; x=1695783632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BoWuIZslAKIECp3U9U4lVchJZeGm3yYBZZsuhqn9A/k=;
 b=oz+qAKVfogUJ1IvrjFFnP92TUu3Qby+mVKK95OQlq1pCgdNnaF/54GfuDvkqeCA5+T
 2e7au3EGynh+Zrvg/2dIbk0T/9wrPeSN+NWWDpll1x1GsMrrCxED7Wawn/pAOOZ+J02o
 Xzc8Bmwu+PxQc/yG4dhSOveHgN/W2ifWGhhkLjjS+Kr5Sz5y7iVqO/baIt7XiF4sAMNk
 FdJ0xHhoCiavei+Vbzv/3hQW/9lAMyrn/uWzH9QK+ARjGpGhEoJqAVbEU3tgBV74oUN2
 kxsAxSoV6WYtc3POFbKgZgwdJNaoRxYHf7bwIbUP4wvhvil0+oCLBYW7MWH357QhQ9Ev
 WY0Q==
X-Gm-Message-State: AOJu0Yzzm32M6SeNucl/eG/8oRiF4XGVgtfrMtTf/g32OZz8auwslqMm
 Mszp77q8Fks94TYl5Wo2wpxxZqFZXzVsVt9ByK0=
X-Google-Smtp-Source: AGHT+IGlVUlf+C/apAGixhMp1HlyOOdyMOi20gpoHn/BIyFflvgI/clIohjm6ggMJI+X3bWkYhQmHg==
X-Received: by 2002:a05:6e02:17ca:b0:350:f956:91c1 with SMTP id
 z10-20020a056e0217ca00b00350f95691c1mr826925ilu.24.1695178832044; 
 Tue, 19 Sep 2023 20:00:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 00/20] x86: efi: Fixes and improvements for coreboot
Date: Tue, 19 Sep 2023 21:00:01 -0600
Message-ID: <20230920030027.1385833-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
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

Changes in v5:
- Use 'lzma' instead of 'LZMA'
- Drop unwanted space
- Correct 'teechnique' typo in commit message
- Make use of the uSE_PREBOOT mechanism

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

 arch/arm/include/asm/global_data.h     |   3 +
 arch/riscv/include/asm/global_data.h   |   3 +
 arch/sandbox/include/asm/global_data.h |   1 +
 arch/x86/cpu/coreboot/Kconfig          |   1 +
 arch/x86/cpu/coreboot/coreboot.c       |  16 +-
 arch/x86/cpu/x86_64/cpu.c              |   7 +
 arch/x86/dts/coreboot.dts              |   1 +
 arch/x86/include/asm/global_data.h     |   1 +
 arch/x86/lib/coreboot/cb_sysinfo.c     |   1 +
 arch/x86/lib/tables.c                  |   3 +
 boot/bootdev-uclass.c                  |  27 +++
 configs/coreboot64_defconfig           |  25 ++-
 configs/coreboot_defconfig             |  21 +-
 doc/arch/index.rst                     |   2 +-
 doc/arch/x86/index.rst                 |  12 +
 doc/arch/x86/manual_boot.rst           | 276 +++++++++++++++++++++++
 doc/arch/{ => x86}/x86.rst             | 295 ++-----------------------
 doc/board/coreboot/coreboot.rst        |  38 +++-
 drivers/serial/Kconfig                 |   2 +-
 drivers/usb/host/usb-uclass.c          |   8 +
 drivers/video/coreboot.c               |  12 +
 include/asm-generic/global_data.h      |   8 +
 include/bootdev.h                      |   9 +
 lib/Kconfig                            |  24 +-
 lib/efi_loader/Makefile                |   4 +-
 lib/efi_loader/efi_setup.c             |  20 +-
 lib/efi_loader/efi_smbios.c            |  72 +++---
 test/py/tests/test_event_dump.py       |   1 +
 28 files changed, 543 insertions(+), 350 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 create mode 100644 doc/arch/x86/manual_boot.rst
 rename doc/arch/{ => x86}/x86.rst (64%)

-- 
2.42.0.459.ge4e396fd5e-goog

