Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EB1CDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C528588D70;
	Wed, 18 Sep 2024 17:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="N0lMbOu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C173E88D75; Wed, 18 Sep 2024 17:22:01 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9298288D59
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a789c4fc5so167454766b.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672918; x=1727277718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jjc0IjFZHoqBHZCJI5RORcRKGzJyabYnxeq6Pb7CR8E=;
 b=N0lMbOu7/sSn67x6WmpWCoIKWaXcsUup8l3BAcqycuzGA199iL/Xi2C0aNygB8T/Hk
 VhX+9oph3+IM0oErFuktwctrj7QnYMFi+jwNJ74llMFeFHhBpBufdJ1agY/hY1kS/CVb
 7U94uOUTZ2R6C+mzl6tZETjAMXM66A4yM+c4gK8dcONm6AeF6c/oMgQoL0u1VXKNF8tb
 fxKE1MbMf69Y0rRY2O3Q1VKfWJcjJzoeADyLQiDYOzDO9TCTgyCUD38CtXCnmcqDFNG9
 wkp3cTIUjxqCH1nMBDfqs1+mcp9UYg/gwButAU62Kzj2iJ0GJb3bDMX7LMjiOItKW/e9
 NXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672918; x=1727277718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jjc0IjFZHoqBHZCJI5RORcRKGzJyabYnxeq6Pb7CR8E=;
 b=BvkgyOUaOb0yIZ9llzq6uJ0XawJqN1CN040emPR5y7G6Bm9TYeVJBeFf9ENSdFYdXk
 BXhgfbcpAjbGvpeylXi8BHNWmtaMp0m7ulSUg952Ixq4y57huDE9n4KC8yX6lcoS+CKL
 F056gm/PpLFHaCeoerHkrSJnM4Fi5966U4uPJh31RST5LuqHMTFyHSMMwDzWZixzW1z5
 CIhE38itUFlkHQbIP8D/N9F+QCMGdBC/AjBFZM+MGbZnBmZB3HoNu414iI9ko2ONOPUS
 V8NzBFhk46uuMaUDMJoB3+5Akz0HleVDLR6ho00mmkEJzjmBUw9PCmpaC3g2hgPDpKXl
 Fdow==
X-Gm-Message-State: AOJu0Yzpcw4PS2v8RQg7sXNbbzJyvY82iW12b8CD5TiYi/nQRlTzRJ0v
 9m8cHhPxrjJheiB799BYCGllxtU2/wx5ShV6OPB6B4BZAvKkhOP3WubjRrfU8QNKc/j91RdXxUs
 U
X-Google-Smtp-Source: AGHT+IGFz183I5sJPehtnNfwRFLZn2eAZds62yAJKle+eTAPth1xxb9oQsz+a4BKdg1xqF4utv50BA==
X-Received: by 2002:a17:907:869f:b0:a8d:55e1:a653 with SMTP id
 a640c23a62f3a-a8ffab6fb3cmr2917047266b.13.1726672917549; 
 Wed, 18 Sep 2024 08:21:57 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:21:57 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v4 00/35] Implement ACPI on aarch64
Date: Wed, 18 Sep 2024 17:20:04 +0200
Message-ID: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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

Patrick Rudolph (30):
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

Simon Glass (2):
  arm: mach-bcm283x: Bring in some header files from tianocore
  board: raspberrypi: Add ASL files from tianocore

 MAINTAINERS                                   |   2 +-
 arch/arm/Kconfig                              |   9 +
 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S             | 113 ++++
 arch/arm/cpu/armv8/start.S                    |  12 +
 arch/arm/dts/qemu-sbsa.dts                    |  49 ++
 arch/arm/include/asm/acpi_table.h             | 147 +++++
 arch/arm/include/asm/arch-qemu-sbsa/boot0.h   |  33 +
 arch/arm/lib/Makefile                         |   2 +
 arch/arm/lib/acpi_table.c                     | 276 ++++++++
 arch/arm/lib/gic-v2.c                         |  89 +++
 arch/arm/lib/gic-v3-its.c                     | 118 +++-
 arch/arm/mach-bcm283x/Kconfig                 |  18 +-
 arch/arm/mach-bcm283x/Makefile                |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c          | 128 ++++
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++
 .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++
 .../include/mach/acpi/bcm2836_gpio.h          |  19 +
 .../include/mach/acpi/bcm2836_gpu.h           |  47 ++
 .../include/mach/acpi/bcm2836_pwm.h           |  33 +
 .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
 .../include/mach/acpi/bcm2836_sdio.h          |  21 +
 arch/arm/mach-bcm283x/init.c                  |  12 +-
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
 arch/x86/lib/acpi_table.c                     | 245 +------
 board/emulation/qemu-arm/MAINTAINERS          |   2 +
 board/emulation/qemu-sbsa/Kconfig             |  58 ++
 board/emulation/qemu-sbsa/Makefile            |   8 +
 board/emulation/qemu-sbsa/acpi.c              | 197 ++++++
 board/emulation/qemu-sbsa/dsdt.asl            | 483 ++++++++++++++
 board/emulation/qemu-sbsa/lowlevel_init.S     |  22 +
 board/emulation/qemu-sbsa/qemu-sbsa.c         | 602 ++++++++++++++++++
 board/emulation/qemu-sbsa/qemu-sbsa.env       |  14 +
 board/emulation/qemu-sbsa/qemu-sbsa.h         |  38 ++
 board/emulation/qemu-sbsa/smc.c               |  72 +++
 board/raspberrypi/rpi/.gitignore              |   3 +
 board/raspberrypi/rpi/Makefile                |   2 +
 board/raspberrypi/rpi/acpitables.h            |  90 +++
 board/raspberrypi/rpi/dsdt.asl                | 290 +++++++++
 board/raspberrypi/rpi/emmc.asl                | 136 ++++
 board/raspberrypi/rpi/gpudevs.asl             | 372 +++++++++++
 board/raspberrypi/rpi/pci.asl                 | 177 +++++
 board/raspberrypi/rpi/pep.asl                 |  90 +++
 board/raspberrypi/rpi/rhpx.asl                | 195 ++++++
 board/raspberrypi/rpi/rpi.c                   | 183 ++++++
 board/raspberrypi/rpi/sdhc.asl                | 111 ++++
 board/raspberrypi/rpi/uart.asl                | 208 ++++++
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
 configs/rpi_4_acpi_defconfig                  |  70 ++
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
 drivers/cpu/bcm283x_cpu.c                     | 218 +++++++
 drivers/misc/irq-uclass.c                     |  66 +-
 drivers/pci/pcie_brcmstb.c                    | 101 +--
 drivers/serial/serial_pl01x.c                 |  24 +
 drivers/usb/host/Kconfig                      |   8 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-generic.c               |  77 +++
 include/acpi/acpi_table.h                     | 324 +++++++++-
 include/acpi/acpigen.h                        |  12 +
 include/bloblist.h                            |   1 +
 include/configs/qemu-sbsa.h                   | 104 +++
 include/dm/acpi.h                             |  26 +
 include/irq.h                                 |  14 +
 include/serial.h                              |   1 +
 lib/Kconfig                                   |  31 +-
 lib/acpi/acpi_table.c                         | 564 +++++++++++++++-
 lib/acpi/acpigen.c                            |  11 +
 lib/efi_loader/efi_acpi.c                     |  80 ++-
 test/dm/acpi.c                                |  43 ++
 test/dm/irq.c                                 |  15 +
 test/py/tests/test_event_dump.py              |   1 +
 111 files changed, 6871 insertions(+), 542 deletions(-)
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

