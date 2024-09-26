Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ED3CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 08:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9392388D3F;
	Thu, 26 Sep 2024 10:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="V+848eo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2B888D1A; Thu, 26 Sep 2024 10:02:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E24D88A0A
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 10:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8a706236bfso43342466b.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727337724; x=1727942524; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=awnsr1cTgnzyhOjUZnJqRCeCJ2+BinQ3duxBePjaP3I=;
 b=V+848eo0KXRDXzm3AcgwINxr9iW2SsCr03e74pMRb+DWkQj92BSW1je7Gc57wR3uaq
 Xf7Ln8DX4cZ+NKXPLzKbeeURkBDN/qJ5Ub0B14hIWYs2F8UsgwX6SNVEAcXuOOomf3Ig
 MnIBW/N0kgr/YdE7B8GkOGkHN4HYGpMyYquCpLT3kNGDM6P6mAfrG7ff8VL8XyhaZkea
 HTUHKpiUimVPM9mjtO+cgsUMMrBazTHuM9Ey44jPbOvhslQ0g7id3Mudujj+8Nila9nT
 4xnV92T9d4nT/tkhNrXanp7/LNjg+n3MpeSZDL2YS+IWljSH0+UztAoWuhUPD6tJKIYg
 /Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727337724; x=1727942524;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=awnsr1cTgnzyhOjUZnJqRCeCJ2+BinQ3duxBePjaP3I=;
 b=IaPl7EKe4cmg9GTtUxv7x8f2WGyxcMjA9FU2yVf5yJA3LFFeam3AS/YX2LUXwfPfsE
 Q6B4QRXhQUnZtdsBWxBLsJKX1FY4zTRd97C2BmrW9aIhozfrFQWcBRRFF1oz1Lp4vvnC
 6dGiP6u9jNzPkHwhMrr2Jl4cDgVOJbVv7r36cQT0jZrtLNoQq6iXIHFilN79Lj0VQLyI
 tx5Hu8x3EL6GDuVs3Hb4fUWjGLYjDUmZIvXTsq+csVCItnkq8kWg4CL1Ap3BEkTa+BeI
 QyJLz4xtDNcgybYBYQkIn7/UoWaVZSSbywv9coGmkE5YziLjmFRy+kLpsaYIGcCiiuwW
 uXAA==
X-Gm-Message-State: AOJu0Yy5RF/gf/5pDPHdkI2ve9Q9z6gK5o91SZMPNObRSQnYWRxg5u7f
 eeQnjpHJBg8LAWf94ReqTPd4VQe3nm7l/uoCZiKC/r9oysU4mBXOLn4Xs38v47buxTRF1VOrb1u
 a
X-Google-Smtp-Source: AGHT+IGZzpUooWyyGpiNn6Syo0Y9QKGxpbLJtIrRLWe3zataOlZZM4FcPk5IL6gjmXgkAkyIRepIGA==
X-Received: by 2002:a05:6402:1e94:b0:5c0:8eb1:2800 with SMTP id
 4fb4d7f45d1cf-5c720620507mr5647352a12.11.1727337724247; 
 Thu, 26 Sep 2024 01:02:04 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 01:02:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v5 00/36] Implement ACPI on aarch64
Date: Thu, 26 Sep 2024 09:58:48 +0200
Message-ID: <20240926080021.148031-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
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

Based on the existing work done by Simon Glass this series adds
support for booting aarch64 devices using ACPI only.
As first target QEMU SBSA support is added, which relies on ACPI
only to boot an OS. As secondary target the Raspberry Pi4 was used,
which is broadly available and allows easy testing of the proposed
solution.

The series is split into ACPI cleanups and code movements, adding
Arm specific ACPI tables and finally SoC and mainboard related
changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
mandatory ACPI tables are supported, allowing to boot into Linux
without errors.

The QEMU SBSA support is feature complete and provides the same
functionality as the EDK2 implementation.

The changes were tested on real hardware as well on QEMU v9.0:

qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
                    -pflash secure-world.rom \
                    -pflash unsecure-world.rom

qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
-smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
-dtb bcm2711-rpi-4-b.dtb -nographic

Tested against FWTS V24.03.00.

Known issues:
- The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
  USB or ethernet devices!
- The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
  cache related).
- PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
  Linux kernel module doesn't support ACPI yet.

Maximilian Brune (3):
  acpi: x86: Move SPCR and DBG2 into common code
  acpi: x86: Write FADT in common code
  serial: serial_pl01x: Implement .getinfo() for PL01

Patrick Rudolph (31):
  acpi: x86: Move MADT to common code
  acpi: Fix typo
  acpi: Add define for GTDT
  arm: acpi: Add generic ACPI methods
  acpi: Add fill_madt to acpi_ops
  acpi: acpi_table: Bump revisions
  acpi: Add ACPITAB for PPTT and GTDT
  acpi: acpi_table: Add IORT support
  acpi: Move function prototype
  acpi_table: Support platforms with unusable RSDT
  efi_loader: Allocate and write ACPI tables
  acpi: Add processor device
  drivers: usb: Add generic XHCI
  drivers: ata: Rename ahci_mvebu
  drivers/cpu: Add generic armv8 cpu driver
  arm: gic-v3-its: Rename objects
  arm: gic-v3-its: Implement of_xlate
  arm: lib: Add GICV2 driver
  drivers: misc: irq-uclass: Update irq_get_by_index
  drivers/arm: Implement acpi_fill_madt
  common: Enable BLOBLIST_TABLES on arm
  board: emulation: Add QEMU sbsa support
  arm: mach-bcm283x: Map the ARM local MMIO as well
  arm: bcm283x: Generate ACPI tables
  arm: cpu: Add ACPI parking protocol support
  armv8: cpu: Enable ACPI parking protocol
  arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
  arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
  bloblist: Fix use of uninitialized variable
  configs: Add RPI4 ACPI defconfig
  azure-pipelines: Enable qemu_sbsa

Simon Glass (2):
  arm: mach-bcm283x: Bring in some header files from tianocore
  board: raspberrypi: Add ASL files from tianocore

 .azure-pipelines.yml                          |   8 +
 MAINTAINERS                                   |   2 +-
 arch/arm/Kconfig                              |  11 +-
 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S             | 113 ++++
 arch/arm/cpu/armv8/start.S                    |  12 +
 arch/arm/dts/qemu-sbsa.dts                    | 138 +++++
 arch/arm/include/asm/acpi_table.h             | 147 +++++
 arch/arm/include/asm/arch-qemu-sbsa/boot0.h   |  34 ++
 arch/arm/lib/Makefile                         |   2 +
 arch/arm/lib/acpi_table.c                     | 276 +++++++++
 arch/arm/lib/gic-v2.c                         |  89 +++
 arch/arm/lib/gic-v3-its.c                     | 118 +++-
 arch/arm/mach-bcm283x/Kconfig                 |  16 +-
 arch/arm/mach-bcm283x/Makefile                |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c          | 128 ++++
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++
 .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++
 .../include/mach/acpi/bcm2836_gpio.h          |  19 +
 .../include/mach/acpi/bcm2836_gpu.h           |  47 ++
 .../include/mach/acpi/bcm2836_pwm.h           |  33 +
 .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
 .../include/mach/acpi/bcm2836_sdio.h          |  21 +
 arch/arm/mach-bcm283x/init.c                  |   2 +-
 arch/arm/mach-qemu/Kconfig                    |  36 +-
 arch/sandbox/dts/test.dts                     |   3 +
 arch/sandbox/lib/Makefile                     |   9 +-
 arch/sandbox/lib/acpi_table.c                 |  11 +
 arch/x86/cpu/apollolake/acpi.c                |  20 +-
 arch/x86/cpu/baytrail/acpi.c                  |  17 +-
 arch/x86/cpu/intel_common/acpi.c              |  22 +-
 arch/x86/cpu/quark/acpi.c                     |  19 +-
 arch/x86/cpu/tangier/acpi.c                   |  33 +-
 arch/x86/include/asm/acpi_table.h             |  28 +-
 arch/x86/lib/acpi_table.c                     | 245 +-------
 board/emulation/qemu-arm/MAINTAINERS          |   2 +
 board/emulation/qemu-sbsa/Kconfig             |  59 ++
 board/emulation/qemu-sbsa/Makefile            |   8 +
 board/emulation/qemu-sbsa/acpi.c              | 193 ++++++
 board/emulation/qemu-sbsa/dsdt.asl            | 483 +++++++++++++++
 board/emulation/qemu-sbsa/lowlevel_init.S     |  22 +
 board/emulation/qemu-sbsa/qemu-sbsa.c         | 312 ++++++++++
 board/emulation/qemu-sbsa/qemu-sbsa.env       |  14 +
 board/emulation/qemu-sbsa/qemu-sbsa.h         |  38 ++
 board/emulation/qemu-sbsa/smc.c               |  72 +++
 board/raspberrypi/rpi/.gitignore              |   3 +
 board/raspberrypi/rpi/Makefile                |   2 +
 board/raspberrypi/rpi/acpitables.h            |  90 +++
 board/raspberrypi/rpi/dsdt.asl                | 254 ++++++++
 board/raspberrypi/rpi/emmc.asl                | 136 +++++
 board/raspberrypi/rpi/gpudevs.asl             | 372 ++++++++++++
 board/raspberrypi/rpi/pci.asl                 | 177 ++++++
 board/raspberrypi/rpi/pep.asl                 |  90 +++
 board/raspberrypi/rpi/rhpx.asl                | 195 ++++++
 board/raspberrypi/rpi/rpi.c                   | 183 ++++++
 board/raspberrypi/rpi/sdhc.asl                | 111 ++++
 board/raspberrypi/rpi/uart.asl                | 208 +++++++
 boot/bootflow.c                               |   8 +-
 common/Kconfig                                |   1 +
 common/bloblist.c                             |   2 +-
 configs/clearfog_defconfig                    |   2 +-
 configs/clearfog_gt_8k_defconfig              |   2 +-
 configs/clearfog_sata_defconfig               |   2 +-
 configs/clearfog_spi_defconfig                |   2 +-
 configs/db-88f6820-gp_defconfig               |   2 +-
 configs/ds116_defconfig                       |   2 +-
 configs/helios4_defconfig                     |   2 +-
 configs/mvebu_crb_cn9130_defconfig            |   2 +-
 configs/mvebu_db-88f3720_defconfig            |   2 +-
 configs/mvebu_db_armada8k_defconfig           |   2 +-
 configs/mvebu_db_cn9130_defconfig             |   2 +-
 configs/mvebu_espressobin-88f3720_defconfig   |   2 +-
 .../mvebu_espressobin_ultra-88f3720_defconfig |   2 +-
 configs/mvebu_mcbin-88f8040_defconfig         |   2 +-
 configs/mvebu_puzzle-m801-88f8040_defconfig   |   2 +-
 configs/n2350_defconfig                       |   2 +-
 configs/octeon_nic23_defconfig                |   2 +-
 configs/qemu-arm-sbsa_defconfig               |  10 +
 configs/rpi_4_acpi_defconfig                  |  71 +++
 configs/turris_omnia_defconfig                |   2 +-
 doc/board/emulation/index.rst                 |   1 +
 doc/board/emulation/qemu-sbsa.rst             |  98 +++
 doc/develop/driver-model/virtio.rst           |   1 +
 drivers/ata/Kconfig                           |  12 +-
 drivers/ata/Makefile                          |   2 +-
 drivers/ata/{ahci_mvebu.c => ahci_generic.c}  |  17 +-
 drivers/core/acpi.c                           |  16 +
 drivers/cpu/Kconfig                           |   7 +
 drivers/cpu/Makefile                          |   2 +
 drivers/cpu/armv8_cpu.c                       | 151 +++++
 drivers/cpu/armv8_cpu.h                       |  31 +
 drivers/cpu/bcm283x_cpu.c                     | 217 +++++++
 drivers/misc/irq-uclass.c                     |  66 +-
 drivers/pci/pcie_brcmstb.c                    | 101 +---
 drivers/serial/serial_pl01x.c                 |  24 +
 drivers/usb/host/Kconfig                      |   8 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-generic.c               |  77 +++
 include/acpi/acpi_table.h                     | 324 +++++++++-
 include/acpi/acpigen.h                        |  12 +
 include/bloblist.h                            |   1 +
 include/configs/qemu-sbsa.h                   | 104 ++++
 include/dm/acpi.h                             |  26 +
 include/irq.h                                 |  14 +
 include/serial.h                              |   1 +
 lib/Kconfig                                   |  31 +-
 lib/acpi/acpi_table.c                         | 564 ++++++++++++++++--
 lib/acpi/acpigen.c                            |  11 +
 lib/efi_loader/efi_acpi.c                     |  80 ++-
 test/dm/acpi.c                                |  43 ++
 test/dm/irq.c                                 |  15 +
 test/py/tests/test_event_dump.py              |   1 +
 112 files changed, 6629 insertions(+), 543 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/acpi_park_v8.S
 create mode 100644 arch/arm/dts/qemu-sbsa.dts
 create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
 create mode 100644 arch/arm/lib/acpi_table.c
 create mode 100644 arch/arm/lib/gic-v2.c
 create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2711.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpio.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_gpu.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_pwm.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdhost.h
 create mode 100644 arch/arm/mach-bcm283x/include/mach/acpi/bcm2836_sdio.h
 create mode 100644 arch/sandbox/lib/acpi_table.c
 create mode 100644 board/emulation/qemu-sbsa/Kconfig
 create mode 100644 board/emulation/qemu-sbsa/Makefile
 create mode 100644 board/emulation/qemu-sbsa/acpi.c
 create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
 create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
 create mode 100644 board/emulation/qemu-sbsa/smc.c
 create mode 100644 board/raspberrypi/rpi/.gitignore
 create mode 100644 board/raspberrypi/rpi/acpitables.h
 create mode 100644 board/raspberrypi/rpi/dsdt.asl
 create mode 100644 board/raspberrypi/rpi/emmc.asl
 create mode 100644 board/raspberrypi/rpi/gpudevs.asl
 create mode 100644 board/raspberrypi/rpi/pci.asl
 create mode 100644 board/raspberrypi/rpi/pep.asl
 create mode 100644 board/raspberrypi/rpi/rhpx.asl
 create mode 100644 board/raspberrypi/rpi/sdhc.asl
 create mode 100644 board/raspberrypi/rpi/uart.asl
 create mode 100644 configs/qemu-arm-sbsa_defconfig
 create mode 100644 configs/rpi_4_acpi_defconfig
 create mode 100644 doc/board/emulation/qemu-sbsa.rst
 rename drivers/ata/{ahci_mvebu.c => ahci_generic.c} (71%)
 create mode 100644 drivers/cpu/armv8_cpu.c
 create mode 100644 drivers/cpu/armv8_cpu.h
 create mode 100644 drivers/cpu/bcm283x_cpu.c
 create mode 100644 drivers/usb/host/xhci-generic.c
 create mode 100644 include/configs/qemu-sbsa.h

-- 
2.46.0

