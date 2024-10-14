Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74525D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8A9890A4;
	Mon, 14 Oct 2024 15:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Ch26pGdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB11789074; Mon, 14 Oct 2024 15:12:16 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 310CB88FCC
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431291b27f1so17623805e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911523; x=1729516323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Szu5jr2hjv1EGPtmT9XrJtjceSI+2lUsIT7mTNDXFEY=;
 b=Ch26pGdEFDljKzhpZCrfT744nXaQD0Eg90KalJmkqLEJejucukwhiwPwCfOKdnw8j2
 DD96qA61CKVT2BQvdFHPyy0pZ7xGCKT6Xw4xuejQqbMPeIy4/i5sRZMZjclac2DzvvU2
 mHC/LAIgemogCAxq5mw9Bq0siquLf2l9zM3YY4vlsezyTx2wVgLkC1veISlLt2jvnxUR
 2lyu23guNjUt3Jo1QpRQhPqsXA/P903AD17pTlkbUj0/XwQPL05i8zuEEtmlKekmcRJN
 FpsR/7bSp8EjkPSJ3ot1+YggcRf5zGABPev5uVRlzhMM+sS+eXb5eybuWA84ZSYhMXcI
 AmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911523; x=1729516323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Szu5jr2hjv1EGPtmT9XrJtjceSI+2lUsIT7mTNDXFEY=;
 b=LGI+6PDYhsBl4oaBJqVernOhQkW5h+IPAXAgyh4vTK/HyZarVGWgAGSoIElezkIcht
 WfE0cZAYB4aicC19xvlZHTPFYyjbHkaIBXn5ryFrIOnwfXsjuki6BTlaWmvNYsjiPCV2
 q8vx3PEM1PYQsvHxSJxXfdAUwcJnOn6UeX+Hs8fCaqhteTdMAOoPgODME5yMaSo6q7ab
 C0bwYcsdTShjV1xqrV0fiareo0tjjxqYe+lRcZolvEzkw9fBFrz+IfyBI9PlYCZaO8Gb
 4x+SiSosJ8vLECIRF4e8qVZgYQVO0Q+XcwEk64luLsU67i1g/l31SUEwzJ197cjvGY9e
 2G/Q==
X-Gm-Message-State: AOJu0Yz+Yk5XVnVgFc/c/l+1GdqCaf53BQEXQZ0Nyegp+NSDhRpeO9H8
 ddR0te0++6Dqz/Nsl2pBdSPfccIF6KWTVIXwtUTW21iTnDcLeOvUt9BfQgnihbT5T1IMN72wZ12
 I
X-Google-Smtp-Source: AGHT+IH4owHwVzcP6Y5Cng5gk9inKEmsax8W1k59KnEk4IFA79pEBbtR9naHGsIUY9zH7ZAl5eM+4w==
X-Received: by 2002:a05:600c:1e18:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4311deaea26mr102661615e9.1.1728911523058; 
 Mon, 14 Oct 2024 06:12:03 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:02 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v8 00/37] Implement ACPI on aarch64
Date: Mon, 14 Oct 2024 15:10:16 +0200
Message-ID: <20241014131152.267405-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
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

Patrick Rudolph (32):
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
  acpi: Allocate and write ACPI tables
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
  arm: Implement read_mpidr on armv7
  arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
  arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
  bloblist: Fix use of uninitialized variable
  configs: Add RPI4 ACPI defconfig
  CI: Enable qemu_sbsa

Simon Glass (2):
  arm: mach-bcm283x: Bring in some header files from tianocore
  board: raspberrypi: Add ASL files from tianocore

 .azure-pipelines.yml                          |   8 +
 .gitlab-ci.yml                                |  11 +
 MAINTAINERS                                   |   2 +-
 arch/arm/Kconfig                              |  11 +-
 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S             | 113 ++++
 arch/arm/cpu/armv8/start.S                    |  12 +
 arch/arm/dts/qemu-sbsa.dts                    | 137 ++++
 arch/arm/include/asm/acpi_table.h             | 147 ++++
 arch/arm/include/asm/arch-qemu-sbsa/boot0.h   |  34 +
 arch/arm/include/asm/system.h                 |   9 +
 arch/arm/lib/Makefile                         |   2 +
 arch/arm/lib/acpi_table.c                     | 276 ++++++++
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
 arch/x86/lib/acpi_table.c                     | 245 +------
 board/emulation/qemu-arm/MAINTAINERS          |   2 +
 board/emulation/qemu-sbsa/Kconfig             |  58 ++
 board/emulation/qemu-sbsa/Makefile            |   8 +
 board/emulation/qemu-sbsa/acpi.c              | 192 ++++++
 board/emulation/qemu-sbsa/dsdt.asl            | 483 ++++++++++++++
 board/emulation/qemu-sbsa/lowlevel_init.S     |  22 +
 board/emulation/qemu-sbsa/qemu-sbsa.c         | 273 ++++++++
 board/emulation/qemu-sbsa/qemu-sbsa.env       |  14 +
 board/emulation/qemu-sbsa/qemu-sbsa.h         |  38 ++
 board/emulation/qemu-sbsa/smc.c               |  71 ++
 board/raspberrypi/rpi/.gitignore              |   3 +
 board/raspberrypi/rpi/Makefile                |   2 +
 board/raspberrypi/rpi/acpitables.h            |  90 +++
 board/raspberrypi/rpi/dsdt.asl                | 254 +++++++
 board/raspberrypi/rpi/emmc.asl                | 136 ++++
 board/raspberrypi/rpi/gpudevs.asl             | 372 +++++++++++
 board/raspberrypi/rpi/pci.asl                 | 177 +++++
 board/raspberrypi/rpi/pep.asl                 |  90 +++
 board/raspberrypi/rpi/rhpx.asl                | 195 ++++++
 board/raspberrypi/rpi/rpi.c                   | 183 +++++
 board/raspberrypi/rpi/sdhc.asl                | 111 +++
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
 configs/rpi_4_acpi_defconfig                  |  10 +
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
 drivers/cpu/bcm283x_cpu.c                     | 214 ++++++
 drivers/misc/irq-uclass.c                     |  66 +-
 drivers/pci/pcie_brcmstb.c                    | 101 +--
 drivers/serial/serial_pl01x.c                 |  24 +
 drivers/usb/host/Kconfig                      |   8 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-generic.c               |  75 +++
 include/acpi/acpi_table.h                     | 324 ++++++++-
 include/acpi/acpigen.h                        |  12 +
 include/bloblist.h                            |   1 +
 include/configs/qemu-sbsa.h                   |  89 +++
 include/dm/acpi.h                             |  26 +
 include/irq.h                                 |  14 +
 include/serial.h                              |   1 +
 lib/Kconfig                                   |  31 +-
 lib/acpi/acpi_table.c                         | 630 +++++++++++++++++-
 lib/acpi/acpigen.c                            |  11 +
 test/dm/acpi.c                                |  43 ++
 test/dm/irq.c                                 |  15 +
 test/py/tests/test_event_dump.py              |   1 +
 113 files changed, 6512 insertions(+), 542 deletions(-)
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
2.46.2

