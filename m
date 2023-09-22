Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EBAE6FE42
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 15:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B99886784;
	Fri, 22 Sep 2023 17:04:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KGivDQD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442F386784; Fri, 22 Sep 2023 17:04:40 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FF186661
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 17:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5043a01ee20so1349887e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695395077; x=1695999877; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=b14K30Vcpb+U/pFYmf8yfTJylAixitjMYv3laVMt0n4=;
 b=KGivDQD4UoFj7CbKicNWxORQ6GvRKuqe7IPg2dcCTfeyWEBHFTBagBD3qn9kH6WUCi
 FXxHXixcZHncZSi8jax5CtnUfoIBPMJhotnBaW/399mWJ9pJcM9+lzIDTF4v+68hHMWE
 dIwezsJVRhPEKlzcBBCUIN2W41Gh1w9PYAejMVd6BW9jtZLMDV1358UlosDhymtp1gIf
 MMvgRYGj4dhmftyW00/wJDpIMyIVpby9ak9Vm/zSzBUPHf3F2tlni32PsRNJAEnoyAXw
 BDCVO1wCmwO72hkvpG5BwEz4isdhZ5gHQQSn3gDd85+YUKWsoWOEzutHMGNgExrxQenQ
 iINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695395077; x=1695999877;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b14K30Vcpb+U/pFYmf8yfTJylAixitjMYv3laVMt0n4=;
 b=NYH499W+7dFokFkdvdnKGSIqSvwWz2H4YePJkkyNzrnX+pwwiL2/av53FWGi9/7d+N
 YjhbMUszGDU1enY+sg1tfrbe1eRRh7E9y0Qys47kEdl+IzeOUKPXNt3wkCbE8j4lwMCE
 3YwioH9AmWG74KG4gtr+/SNlolm4JkZRl6MY2P9SKBQYkokBZsR+R+kKXti9ngcMVXHk
 x5QZRJVGfZKw+9ImzVUDiSM34uwbp3o6fInq77JDS7muNK6wzJYAEP6wjpXhKrIsqsta
 hE1n1G1+qePZYs+wShNe4ljByNI3qJtc5TavCXWFDI+nHHzPaSCHTIy9ZaaKQ87bwPXA
 56BQ==
X-Gm-Message-State: AOJu0Yw03uf6Kpri1UvxkSdife39me/3DLa1FvjsjnicCsRVXg+/f120
 2c4/PbhDyHpPYV6TJJCAMEdl/thxER+klWU3yCc=
X-Google-Smtp-Source: AGHT+IGswgvrH0Dtc8O3yfssXVq4zatiVgyRpOxmZd8XkTgZ0v8xprZLQiVOF0y05xs7ggM8mLBbcFOrv2ePN56Yn2U=
X-Received: by 2002:a05:6512:3591:b0:500:a66b:b189 with SMTP id
 m17-20020a056512359100b00500a66bb189mr7015188lfr.51.1695395076743; Fri, 22
 Sep 2023 08:04:36 -0700 (PDT)
MIME-Version: 1.0
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 22 Sep 2023 23:04:24 +0800
Message-ID: <CAEUhbmUrZp5bgVOb+n28YL7D0FGz6pmVFPt77E3nd2X3rTynsA@mail.gmail.com>
Subject: Please pull u-boot-x86 into -next
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The following changes since commit 5d2fae79c7d60eaf7f50322e4ec125d2f58544e9:

  Merge tag 'xilinx-for-v2024.01-rc1-v2' of
https://source.denx.de/u-boot/custodians/u-boot-microblaze into next
(2023-09-21 10:51:58 -0400)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-x86.git tags/x86-pull-20230922

for you to fetch changes up to 5728246dfa11400d4f7aa8262ea630d8c09a85b9:

  x86: doc: coreboot: Mention 64-bit Linux distros (2023-09-22 06:05:40 +0800)

----------------------------------------------------------------
- Add bootstd support to 64-bit efi payload
- Fix a bug of missing setting size of initrd in pxeboot
- Allow Python packages to be dropped
- Reland "x86: Move FACP table into separate functions"
- Fixes for chromebook_link64 and chromebook_samus_tpl
- Fixes and improvements for coreboot
- x86 documentation updates

----------------------------------------------------------------
Andy Shevchenko (1):
      x86: Prevent from missing the FADT chaining

Simon Glass (35):
      Allow Python packages to be dropped
      x86: coreboot: Avoid a declaration after a label
      Reland "x86: Move FACP table into separate functions""
      x86: doc: Document the -cdrom issues I ran into
      dm: core: Allow marking driver model as dead
      x86: broadwell: Show the memory delay
      x86: Add some log categories
      x86: samus_tpl: Correct text base and alloc sizes
      x86: spl: Change the condition for copying U-Boot to RAM
      x86: broadwell: Avoid initing the CPU twice
      x86: broadwell: Set up MTRRs
      x86: dm: Mark driver model as dead when disabling CAR
      x86: doc: Update the list of supported Chromebooks
      x86: coreboot: Document cbmem console struct
      x86: Update cbmem driver
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

Thomas Mittelstaedt (3):
      x86: efi-payload64: Add support for SCSI devices
      x86: efi-payload64: Add bootstd support
      x86: pxeboot: bugfix: Set variable for size of initrd

Troy Kisky (1):
      x86: cpu: i386: cpu: only set pci_ram_top if CONFIG_IS_ENABLED(PCI)

 Makefile                                |   9 +++
 arch/arm/include/asm/global_data.h      |   3 +
 arch/riscv/include/asm/global_data.h    |   3 +
 arch/sandbox/include/asm/global_data.h  |   1 +
 arch/x86/cpu/apollolake/acpi.c          |  13 ++--
 arch/x86/cpu/baytrail/acpi.c            |  23 +++++---
 arch/x86/cpu/broadwell/cpu.c            |  10 ++--
 arch/x86/cpu/broadwell/sdram.c          |   2 +
 arch/x86/cpu/coreboot/Kconfig           |   1 +
 arch/x86/cpu/coreboot/coreboot.c        |  16 ++---
 arch/x86/cpu/i386/cpu.c                 |   2 +-
 arch/x86/cpu/intel_common/mrc.c         |  18 +++++-
 arch/x86/cpu/quark/acpi.c               |  23 +++++---
 arch/x86/cpu/tangier/acpi.c             |  23 +++++---
 arch/x86/cpu/x86_64/cpu.c               |   7 +++
 arch/x86/dts/chromebook_samus.dts       |   1 +
 arch/x86/dts/coreboot.dts               |   1 +
 arch/x86/include/asm/acpi_table.h       |   2 -
 arch/x86/include/asm/coreboot_tables.h  |  17 +++++-
 arch/x86/include/asm/global_data.h      |   1 +
 arch/x86/lib/acpi_table.c               |  15 -----
 arch/x86/lib/coreboot/cb_sysinfo.c      |   1 +
 arch/x86/lib/init_helpers.c             |   7 +--
 arch/x86/lib/spl.c                      |   5 +-
 arch/x86/lib/tables.c                   |   3 +
 arch/x86/lib/tpl.c                      |   2 +
 board/Marvell/mvebu_armada-37xx/board.c |   3 +-
 board/coreboot/coreboot/coreboot.c      |  14 ++---
 boot/bootdev-uclass.c                   |  27 +++++++++
 boot/pxe_utils.c                        |   2 +-
 common/spl/spl.c                        |   2 +-
 configs/chromebook_samus_tpl_defconfig  |   4 +-
 configs/coreboot64_defconfig            |  25 ++++----
 configs/coreboot_defconfig              |  21 ++++---
 configs/efi-x86_payload64_defconfig     |   6 +-
 doc/arch/index.rst                      |   2 +-
 doc/arch/x86/index.rst                  |  12 ++++
 doc/arch/x86/manual_boot.rst            | 276
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/arch/{ => x86}/x86.rst              | 300
++++++---------------------------------------------------------------------------------------
 doc/board/coreboot/coreboot.rst         |  45 +++++++++++++-
 doc/board/emulation/qemu-x86.rst        |   3 +
 doc/build/tools.rst                     |   9 +++
 drivers/misc/Kconfig                    |   8 +++
 drivers/misc/cbmem_console.c            |  43 ++++++++------
 drivers/serial/Kconfig                  |   2 +-
 drivers/usb/host/usb-uclass.c           |   8 +++
 drivers/video/coreboot.c                |  12 ++++
 include/acpi/acpi_table.h               |   7 +++
 include/asm-generic/global_data.h       |  20 +++++++
 include/bootdev.h                       |   9 +++
 lib/Kconfig                             |  24 +++++++-
 lib/efi_loader/Makefile                 |   4 +-
 lib/efi_loader/efi_setup.c              |  20 +++----
 lib/efi_loader/efi_smbios.c             |  72 +++++++++++++++--------
 scripts/dtc/Makefile                    |   2 +
 test/py/tests/test_event_dump.py        |   1 +
 56 files changed, 752 insertions(+), 440 deletions(-)
 create mode 100644 doc/arch/x86/index.rst
 create mode 100644 doc/arch/x86/manual_boot.rst
 rename doc/arch/{ => x86}/x86.rst (64%)

Regards,
Bin
