Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6753EE01F3
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCFE889161;
	Wed, 11 Sep 2024 08:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="BftFhkHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E937289169; Wed, 11 Sep 2024 08:25:19 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA32A89163
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c3c34e3c39so8885748a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035916; x=1726640716; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QnfcBnTVjTvCRoYyBz7iAgM3j70IZAtJS4u6Bmm0Ryc=;
 b=BftFhkHUN9C99lI5tEdj3OSno4vu7fgl3hxFMBJLsrdu9ICIou9+2F66ZoYt01BIt+
 EFvJ1M9BIe3kIH+c8GJwUMcWt0KQJu31I1pOPBlPIODeaTS8OtVBm6meE5tTO6BubGko
 YrUFVjwm8kDL4LHkiY39ZQ16/+mLfABbC0OPqoRLnxOsx/iOz/GEb11g1T1Fra2hGGs+
 g5UCmADVFILdBxpHqcoITt7BLGAOcdIwC7RXHfgelgn9eSMv5OzChWBOvgfal2NwM1Ke
 HP5xIza79C+TFt23xpLVSLzw7siAAI27IsXAUYYc1sPmK1JMpHvQDd+cNmGEMCKYf1H1
 vGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035916; x=1726640716;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QnfcBnTVjTvCRoYyBz7iAgM3j70IZAtJS4u6Bmm0Ryc=;
 b=Yf10zLQGyeJnj864ISNDfcVqbqsodqQPZtraYTZU1S/yZKDeCoyjydYZzsv50FGeDg
 coLrYSyqS9EB0z+K8QL2ShTpTMYL8vqujVgcLIjHWlz1Xw1Mvb10lmxRhWef5t60U7FA
 Ob3KHK6V927xhBmdNJW/+amKqA3krR0j545y9YlxDAo0B+rLtTac5KCPGkeGsXQveT8+
 ARc0EN7nFGo5FN46naEnGFkUDE7q348occv8sb6NKrPj3jQmtcO3lNLhwu4effBU8vMn
 /hZzk4VC2KiTYHkV5DLhz+GzTVWoXka+sIsp2s/va7H5T8gSpmyiDOzQvZC1JWVkac56
 QnCA==
X-Gm-Message-State: AOJu0YzYKeIXK5Wfy3GVdjalZBDNW5rQzr9CrbICLCOX928JoAS8CIkm
 76DuKM0+efte+trQ3/d0RrT5mqV1isSbKStvWjaBw8D8sYo1sUfY9MQARXgctaRzL09rhX1ywJ6
 2
X-Google-Smtp-Source: AGHT+IEBq6h/3KEPXAToSdGp+FwklU7XL+OumNfc4xHXA+UHJysIqpJ6oU0lJxiV7r95lhQ4i5aF4A==
X-Received: by 2002:a17:906:d552:b0:a7a:9ca6:527 with SMTP id
 a640c23a62f3a-a8ffaaacddamr261082266b.8.1726035915982; 
 Tue, 10 Sep 2024 23:25:15 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:15 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v3 00/30] Implement ACPI on aarch64
Date: Wed, 11 Sep 2024 08:23:50 +0200
Message-ID: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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

Patrick Rudolph (25):
  acpi: x86: Move MADT to common code
  acpi: Fix typo
  acpi: Add define for GTDT
  arm: acpi: Add generic ACPI methods
  acpi: Add fill_madt to acpi_ops
  acpi: acpi_table: Bump revisions
  acpi: Add ACPITAB for PPTT and GTDT
  acpi: acpi_table: Add IORT support
  acpi: Move function prototype
  acpi: acpi_table: Support ACPI 2.0 platforms
  efi_loader: Allocate and write ACPI tables
  acpi: Add processor device
  drivers: usb: Add generic XHCI
  drivers: ata: Rename ahci_mvebu
  drivers/cpu: Add generic armv8 cpu driver
  arm: gic-v3-its: Rename objects
  drivers/arm: Implement acpi_fill_madt
  common: Enable BLOBLIST_TABLES on arm
  board: emulation: Add QEMU sbsa support
  arm: mach-bcm283x: Map the ARM local MMIO as well
  arm: bcm283x: Generate ACPI tables
  arm: cpu: Add ACPI parking protocol support
  arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
  arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
  configs: Add RPI4 ACPI defconfig

Simon Glass (2):
  arm: mach-bcm283x: Bring in some header files from tianocore
  board: raspberrypi: Add ASL files from tianocore

 MAINTAINERS                                   |   2 +-
 arch/arm/Kconfig                              |   2 +
 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S             | 107 ++++
 arch/arm/cpu/armv8/start.S                    |   4 +
 arch/arm/dts/qemu-sbsa.dts                    |  49 ++
 arch/arm/include/asm/acpi_table.h             | 160 +++++
 arch/arm/include/asm/arch-qemu-sbsa/boot0.h   |  33 +
 arch/arm/lib/Makefile                         |   1 +
 arch/arm/lib/acpi_table.c                     | 245 ++++++++
 arch/arm/lib/gic-v3-its.c                     |  97 ++-
 arch/arm/mach-bcm283x/Kconfig                 |   4 +
 arch/arm/mach-bcm283x/Makefile                |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c          | 150 +++++
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++
 .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++
 .../include/mach/acpi/bcm2836_gpio.h          |  19 +
 .../include/mach/acpi/bcm2836_gpu.h           |  47 ++
 .../include/mach/acpi/bcm2836_pwm.h           |  33 +
 .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
 .../include/mach/acpi/bcm2836_sdio.h          |  21 +
 arch/arm/mach-bcm283x/init.c                  |  10 +-
 arch/arm/mach-qemu/Kconfig                    |  36 +-
 arch/sandbox/lib/Makefile                     |   9 +-
 arch/sandbox/lib/acpi_table.c                 |   7 +
 arch/x86/cpu/apollolake/acpi.c                |  20 +-
 arch/x86/cpu/baytrail/acpi.c                  |  17 +-
 arch/x86/cpu/intel_common/acpi.c              |  21 +-
 arch/x86/cpu/quark/acpi.c                     |  19 +-
 arch/x86/cpu/tangier/acpi.c                   |  32 +-
 arch/x86/include/asm/acpi_table.h             |  28 +-
 arch/x86/lib/acpi_table.c                     | 244 +-------
 board/emulation/qemu-arm/MAINTAINERS          |   2 +
 board/emulation/qemu-sbsa/Kconfig             |  58 ++
 board/emulation/qemu-sbsa/Makefile            |   8 +
 board/emulation/qemu-sbsa/acpi.c              | 235 ++++++++
 board/emulation/qemu-sbsa/dsdt.asl            | 483 +++++++++++++++
 board/emulation/qemu-sbsa/lowlevel_init.S     |  22 +
 board/emulation/qemu-sbsa/qemu-sbsa.c         | 481 +++++++++++++++
 board/emulation/qemu-sbsa/qemu-sbsa.env       |  14 +
 board/emulation/qemu-sbsa/qemu-sbsa.h         |  38 ++
 board/emulation/qemu-sbsa/smc.c               |  72 +++
 board/raspberrypi/rpi/.gitignore              |   3 +
 board/raspberrypi/rpi/Makefile                |   2 +
 board/raspberrypi/rpi/acpitables.h            |  90 +++
 board/raspberrypi/rpi/dsdt.asl                | 290 +++++++++
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
 configs/rpi_4_acpi_defconfig                  |  72 +++
 configs/turris_omnia_defconfig                |   2 +-
 doc/board/emulation/index.rst                 |   1 +
 doc/board/emulation/qemu-sbsa.rst             |  98 +++
 doc/develop/driver-model/virtio.rst           |   1 +
 drivers/ata/Kconfig                           |  12 +-
 drivers/ata/Makefile                          |   2 +-
 drivers/ata/{ahci_mvebu.c => ahci_generic.c}  |  17 +-
 drivers/core/acpi.c                           |  16 +
 drivers/cpu/Kconfig                           |   6 +
 drivers/cpu/Makefile                          |   3 +
 drivers/cpu/armv8_cpu.c                       | 117 ++++
 drivers/cpu/bcm283x_cpu.c                     | 194 ++++++
 drivers/pci/pcie_brcmstb.c                    | 101 +---
 drivers/serial/serial_pl01x.c                 |  24 +
 drivers/usb/host/Kconfig                      |   8 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-generic.c               |  76 +++
 include/acpi/acpi_table.h                     | 324 +++++++++-
 include/acpi/acpigen.h                        |  12 +
 include/bloblist.h                            |   1 +
 include/configs/qemu-sbsa.h                   |  98 +++
 include/cpu.h                                 |  27 +-
 include/dm/acpi.h                             |  26 +
 include/serial.h                              |   1 +
 lib/Kconfig                                   |  30 +-
 lib/acpi/acpi_table.c                         | 568 ++++++++++++++++--
 lib/acpi/acpigen.c                            |  11 +
 lib/efi_loader/efi_acpi.c                     |  80 ++-
 test/dm/acpi.c                                |  42 ++
 test/py/tests/test_event_dump.py              |   1 +
 105 files changed, 6473 insertions(+), 541 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/acpi_park_v8.S
 create mode 100644 arch/arm/dts/qemu-sbsa.dts
 create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
 create mode 100644 arch/arm/lib/acpi_table.c
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
 create mode 100644 drivers/cpu/bcm283x_cpu.c
 create mode 100644 drivers/usb/host/xhci-generic.c
 create mode 100644 include/configs/qemu-sbsa.h

-- 
2.46.0

