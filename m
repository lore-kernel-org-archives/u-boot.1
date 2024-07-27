Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B931C3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675BD885BF;
	Sat, 27 Jul 2024 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Rz0eOq/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F22B885AE; Sat, 27 Jul 2024 09:20:08 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8677187873
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7ab5fc975dso213301366b.1
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064805; x=1722669605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oxTfNvNrC2wpm8iY+Eoky8sx1Gqn0NuOugQl9GSPbkY=;
 b=Rz0eOq/D/h1mbHKzhCgL1oOMnwKvTC8GpOPto9ALG26xSQHnIVbWk5MFx1yZTa7cdw
 sh01A5Td1VnLcaYWFuksyxTorVAn2riCG9AjzJ7C2ilpNyaA3u4GpTSw/9xOAzmNpxQn
 qcKsg/Cwzj/lnskfj/zJg7UqyZuh8ylsJyb1K0b2McgfRyBeW5QwR9w8xbHZzP7otUPt
 kse4isZbD6MK3Gs+1TE6dtxqFhpA8PPWY+mraYXZf2FeQWz89xJk4Ub+IBPAQ8oQIJH7
 CNzlrHrZwY9qusgV09Cze8EdmB7ydKgSHiABzkkfnxZAxFY0zAEvnGzbsFcrUKw5LYcF
 v4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064805; x=1722669605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oxTfNvNrC2wpm8iY+Eoky8sx1Gqn0NuOugQl9GSPbkY=;
 b=J4xUHTjodsi4QO8CnLWDdnOu2srQdrWNu72dGrUPBuyRHMJSTXioAhgCM6si5Amkki
 uRcHwqwzeEG1+mEyQB/kp59SxkIgo9/fn7BDXF4jfNEUvsJitWmQwWsCLrRvjmL2vGD2
 gaq2XqaPfJ8/GfoG+kygKkoqq6QhdCGK5nIKMGuVt5QTT5bHUns1wsYo26CY/fybcP/r
 BUFfQ6o/PdCZp1V2xH2RmjGt4eGQiq6+clfcWqaXcMSd3V7RIwMWoRr1TCr3rAO4CcUt
 fV4OqvOJnlyXK+JBCHIFHd4wk3Iy3dqYupdo89R42WCnjADgxXTUZZAO516YMy5mgImf
 R53w==
X-Gm-Message-State: AOJu0YyOiLJShZ5JXT2qrO3WYAm8xQFPElY8wQw4qH1jHu47gb8c9vbs
 QkbNzLA8Xw3pLDMOn3IAEpVM7Rz+bc97yVIJBC9ahM3PGCjO43wGNnxaMQjDoAVxOiW6fL2edQT
 5ohA=
X-Google-Smtp-Source: AGHT+IFztjhRKxzvp29ojqd+fd2F528HJ++Lfkn6xXYOTDC8XcsJ0lxtZQyUaho8raqhtCWtA9X6ZQ==
X-Received: by 2002:a17:906:d551:b0:a7a:b070:92c0 with SMTP id
 a640c23a62f3a-a7d4006dcffmr125639866b.23.1722064804749; 
 Sat, 27 Jul 2024 00:20:04 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:04 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 00/17] Implement ACPI on aarch64
Date: Sat, 27 Jul 2024 09:17:01 +0200
Message-ID: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
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
support for booting aarch64 devices using ACPI only. As target the
Raspberry Pi4 was used, which is broadly available and allows easy
testing of the proposed solution.

The series is split into ACPI cleanups and code movements, adding
Arm specific ACPI tables and finally SoC and mainboard related
changes to boot a Linux on the RPi4. Currently only the mandatory
ACPI tables are supported, allowing to boot into Linux without errors.

The changes were tested on real hardware as well on QEMU v9.0:

qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
-smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
-dtb bcm2711-rpi-4-b.dtb -nographic

Please note that the current implementation still requires a DTB to be
provided to U-Boot and that the DTB is used within U-Boot to load drivers,
to disable/enable certain hardware blocks in ACPI. The DTB is not passed
to the OS when using the bootefi cmd.

Tested against FWTS V24.03.00.

Known issues:
- The QEMU support is currently limited as it doesn't emulate PCI, USB or
  ethernet devices!
- The SMP bringup doesn't work on real hardware, but works in QEMU.
- PCI isn't working on real hardware since the pcie_brcmstb Linux kernel
  module doesn't support ACPI yet.

Maximilian Brune (3):
  acpi: x86: Move SPCR and DBG2 into common code
  acpi: x86: Write FADT in common code
  serial: serial_pl01x: Implement .getinfo() for PL01

Patrick Rudolph (12):
  acpi: x86: Move MADT to common code
  acpi: Fix typo
  acpi: Add define for GTDT
  arm: acpi: Add generic ACPI methods
  acpi: acpi_table: Bump revisions
  acpi: Add ACPITAB for PPTT and GTDT
  arm: mach-bcm283x: Map the ARM local MMIO as well
  arm: bcm283x: Write ACPI tables
  arm: cpu: Add ACPI parking protocol support
  arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
  arm: mach-bcm283x: Enable ARMV8_MULTIENTRY
  configs: Add RPI4 ACPI defconfig

Simon Glass (2):
  arm: mach-bcm283x: Bring in some header files from tianocore
  board: raspberrypi: Add ASL files from tianocore

 arch/arm/cpu/armv8/Makefile                   |   1 +
 arch/arm/cpu/armv8/parking_protocol_v8.S      | 102 +++++
 arch/arm/cpu/armv8/start.S                    |   4 +
 arch/arm/include/asm/acpi_table.h             |  70 ++++
 arch/arm/lib/Makefile                         |   1 +
 arch/arm/lib/acpi_table.c                     | 131 ++++++
 arch/arm/mach-bcm283x/Kconfig                 |   4 +
 arch/arm/mach-bcm283x/Makefile                |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c          | 172 ++++++++
 .../mach-bcm283x/include/mach/acpi/bcm2711.h  | 152 +++++++
 .../mach-bcm283x/include/mach/acpi/bcm2836.h  | 127 ++++++
 .../include/mach/acpi/bcm2836_gpio.h          |  19 +
 .../include/mach/acpi/bcm2836_gpu.h           |  47 +++
 .../include/mach/acpi/bcm2836_pwm.h           |  33 ++
 .../include/mach/acpi/bcm2836_sdhost.h        |  18 +
 .../include/mach/acpi/bcm2836_sdio.h          |  21 +
 arch/arm/mach-bcm283x/init.c                  |  79 +++-
 arch/sandbox/lib/Makefile                     |   9 +-
 arch/sandbox/lib/acpi_table.c                 |   7 +
 arch/x86/cpu/apollolake/acpi.c                |  20 +-
 arch/x86/cpu/baytrail/acpi.c                  |  17 +-
 arch/x86/cpu/intel_common/acpi.c              |  20 +-
 arch/x86/cpu/quark/acpi.c                     |  19 +-
 arch/x86/cpu/tangier/acpi.c                   |  31 +-
 arch/x86/include/asm/acpi_table.h             |  26 +-
 arch/x86/lib/acpi_table.c                     | 243 +-----------
 board/raspberrypi/rpi/.gitignore              |   3 +
 board/raspberrypi/rpi/Makefile                |   2 +
 board/raspberrypi/rpi/acpitables.h            |  91 +++++
 board/raspberrypi/rpi/dsdt.asl                | 290 ++++++++++++++
 board/raspberrypi/rpi/emmc.asl                | 136 +++++++
 board/raspberrypi/rpi/gpudevs.asl             | 372 ++++++++++++++++++
 board/raspberrypi/rpi/pci.asl                 | 177 +++++++++
 board/raspberrypi/rpi/pep.asl                 |  90 +++++
 board/raspberrypi/rpi/rhpx.asl                | 195 +++++++++
 board/raspberrypi/rpi/rpi.c                   | 182 +++++++++
 board/raspberrypi/rpi/sdhc.asl                | 111 ++++++
 board/raspberrypi/rpi/uart.asl                | 208 ++++++++++
 boot/bootflow.c                               |   8 +-
 configs/rpi_4_acpi_defconfig                  |  79 ++++
 drivers/pci/pcie_brcmstb.c                    | 101 +----
 drivers/serial/serial_pl01x.c                 |  24 ++
 include/acpi/acpi_table.h                     | 107 +++--
 include/serial.h                              |   1 +
 lib/Kconfig                                   |  15 +
 lib/acpi/acpi_table.c                         | 317 ++++++++++++++-
 46 files changed, 3414 insertions(+), 472 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/parking_protocol_v8.S
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
 create mode 100644 configs/rpi_4_acpi_defconfig

-- 
2.45.2

