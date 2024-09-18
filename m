Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CB7CDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5659D88FAF;
	Wed, 18 Sep 2024 17:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="VgmdVHpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AE5788F33; Wed, 18 Sep 2024 17:22:52 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD71A88DBB
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52f01b8738dso5064201e87.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672968; x=1727277768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2q8CAGbPrqT/c8qZQYhXGkN0d6kR9WGY0/gEVzK+xIs=;
 b=VgmdVHpeMzGyMVO0bMQRMl3ZnbNFuHQTNZuzSesz6cSHrqPPSDH+2Xz1S6BVNZlsT6
 yKuEW0huF7I82TqXwralaqeU7GjcFyDCt/HmiQaUisTgP0SGcLqf4v5s8vbBQF52FafY
 vlsop/93r79Spz/rHQ4c2trXW+lzsp9Cv40B7zQFrWLDBKWC5DRrUmwUphW/3ARj4N6L
 J/ESzv8/WNOrWmaZx43iyaX++hRh37QA6pHWYRDmh3XaPQNyFiT/jZwabmrJIR8OXO04
 CnZw8r4JgwY2Ik++IBh8dMabRpXvCtFpNcu9CIDlY4N9VGxCQp6NjF01FAbgoEeAQnFJ
 d9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672968; x=1727277768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2q8CAGbPrqT/c8qZQYhXGkN0d6kR9WGY0/gEVzK+xIs=;
 b=ZYxjVvgd4b/vX7r2dH8J1QiBzRJwRKgsC06sS/PqRPPYdTHxXm1H38ZKWvSA/w89wS
 +Z7+bzjw8SbCLhK0EMDSjUbM0C52+YD73soCUOdKQfDLnBNc/ca3GJOhGUrOT8Ea8VAx
 iYqF0SAZE5jxfzwePYbwWfdm37jgeqjEhP+WQwi4p6mfc7f0hrn30rPMyIy9mGmTmGr4
 qmFd6nRsSXw+bH0SgHVq5QP+F362nZ1ZtPJwXuEjinKKmbzV2EMOTyhsF0OQESHV04Z1
 Nv0R/oU7a/8YwjFlc5GQS7gm/8fZXjPWjXUvwVgSQIjUtvMdqNjZgen0dZVsdNk+ZcI8
 z7JA==
X-Gm-Message-State: AOJu0YzAFED12MK9AEIp474yXQShIq3zMirOSYTSfL2XBScxV9VshQZE
 t5Gpi39WBhCmV6Ez65IOaNhO+8mV2tEdgyyKQZo359ZHO/tI2CInQ8ypiInCICQeSp5xdCMpR42
 f
X-Google-Smtp-Source: AGHT+IHsykDpLqChvXz3KOV93Cmy6f/5nCxdvqZfmGl7re4yr1tUK/TfETMLGYk9nKc9BHBkCTGenA==
X-Received: by 2002:a05:6512:230b:b0:535:6d34:5cd7 with SMTP id
 2adb3069b0e04-53678fb2001mr11887517e87.11.1726672967748; 
 Wed, 18 Sep 2024 08:22:47 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:47 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 25/35] board: emulation: Add QEMU sbsa support
Date: Wed, 18 Sep 2024 17:20:29 +0200
Message-ID: <20240918152136.3395170-26-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for Arm sbsa [1] v0.3+ that is supported by QEMU [2].

Unlike other Arm based platforms the machine only provides a minimal
FDT that contains number of CPUs, ammount of memory and machine-version.
The boot firmware has to provide ACPI tables to the OS.

Add a minimal amount of devicetree nodes to make the board useable within
U-Boot, provide documentation how to use, enable binman to fabricate both
ROMs that are required to boot and add ACPI tables to make it full compatible
to the EDK2 reference implementation.

The board was tested using Fedora 40 Aarch64 Workstation. It's able
to boot from USB and AHCI or network.

Tested and found working:
- serial
- PCI
- xHCI
- Bochs display
- AHCI
- network using e1000e
- CPU init
- Booting Fedora 40

1: Server Base System Architecture (SBSA)
2: https://www.qemu.org/docs/master/system/arm/sbsa.html

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v3:
- Add GIC and GIC-ITS to devicetree
- Select GICv3 driver
- Drop acpi_fill_madt and use driver model instead
Changelog v4:
- Drop CPU platform code
- Enhance the DT to allow MADT generation from DT
---
 arch/arm/Kconfig                            |   1 +
 arch/arm/dts/qemu-sbsa.dts                  |  49 ++
 arch/arm/include/asm/arch-qemu-sbsa/boot0.h |  33 ++
 arch/arm/mach-qemu/Kconfig                  |  36 +-
 board/emulation/qemu-arm/MAINTAINERS        |   2 +
 board/emulation/qemu-sbsa/Kconfig           |  58 ++
 board/emulation/qemu-sbsa/Makefile          |   8 +
 board/emulation/qemu-sbsa/acpi.c            | 197 +++++++
 board/emulation/qemu-sbsa/dsdt.asl          | 483 ++++++++++++++++
 board/emulation/qemu-sbsa/lowlevel_init.S   |  22 +
 board/emulation/qemu-sbsa/qemu-sbsa.c       | 602 ++++++++++++++++++++
 board/emulation/qemu-sbsa/qemu-sbsa.env     |  14 +
 board/emulation/qemu-sbsa/qemu-sbsa.h       |  38 ++
 board/emulation/qemu-sbsa/smc.c             |  72 +++
 configs/qemu-arm-sbsa_defconfig             |  10 +
 doc/board/emulation/index.rst               |   1 +
 doc/board/emulation/qemu-sbsa.rst           |  98 ++++
 doc/develop/driver-model/virtio.rst         |   1 +
 include/configs/qemu-sbsa.h                 | 104 ++++
 19 files changed, 1823 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/qemu-sbsa.dts
 create mode 100644 arch/arm/include/asm/arch-qemu-sbsa/boot0.h
 create mode 100644 board/emulation/qemu-sbsa/Kconfig
 create mode 100644 board/emulation/qemu-sbsa/Makefile
 create mode 100644 board/emulation/qemu-sbsa/acpi.c
 create mode 100644 board/emulation/qemu-sbsa/dsdt.asl
 create mode 100644 board/emulation/qemu-sbsa/lowlevel_init.S
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.c
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.env
 create mode 100644 board/emulation/qemu-sbsa/qemu-sbsa.h
 create mode 100644 board/emulation/qemu-sbsa/smc.c
 create mode 100644 configs/qemu-arm-sbsa_defconfig
 create mode 100644 doc/board/emulation/qemu-sbsa.rst
 create mode 100644 include/configs/qemu-sbsa.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 50327f5349..e85a7131d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2367,6 +2367,7 @@ source "board/broadcom/bcmns3/Kconfig"
 source "board/cavium/thunderx/Kconfig"
 source "board/eets/pdu001/Kconfig"
 source "board/emulation/qemu-arm/Kconfig"
+source "board/emulation/qemu-sbsa/Kconfig"
 source "board/freescale/ls2080aqds/Kconfig"
 source "board/freescale/ls2080ardb/Kconfig"
 source "board/freescale/ls1088a/Kconfig"
diff --git a/arch/arm/dts/qemu-sbsa.dts b/arch/arm/dts/qemu-sbsa.dts
new file mode 100644
index 0000000000..4ae0a5c342
--- /dev/null
+++ b/arch/arm/dts/qemu-sbsa.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Empty device tree for qemu_arm64
+
+ * Copyright 2021 Google LLC
+ */
+#include "configs/qemu-sbsa.h"
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	binman: binman {
+		multiple-images;
+	};
+};
+
+&binman {
+	secure-world {
+		filename = "secure-world.rom";
+		size = <0x10000000>;
+		pad-byte = <0x00>;
+
+		bl1 {
+			offset = <0x0>;
+			description = "ARM Trusted Firmware BL1";
+			filename = "bl1.bin";
+			type = "blob-ext";
+		};
+
+		fip {
+			offset = <0x12000>;
+			description = "ARM Trusted Firmware FIP";
+			filename = "fip.bin";
+			type = "blob-ext";
+		};
+	};
+
+	unsecure-world {
+		filename = "unsecure-world.rom";
+		pad-byte = <0x00>;
+		size = <0x10000000>;
+
+		u-boot {
+		};
+	};
+};
diff --git a/arch/arm/include/asm/arch-qemu-sbsa/boot0.h b/arch/arm/include/asm/arch-qemu-sbsa/boot0.h
new file mode 100644
index 0000000000..1ca75145d2
--- /dev/null
+++ b/arch/arm/include/asm/arch-qemu-sbsa/boot0.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * sbsa-ref starts U-Boot in XIP memory. Need to relocate U-Boot
+ * to DRAM which is already up. Instead of using SPL this simple loader
+ * is being used.
+ */
+relocate_check:
+	/* x0 contains the pointer to FDT provided by ATF */
+	adr	x1, _start		/* x1 <- Runtime value of _start */
+	ldr	x2, _TEXT_BASE		/* x2 <- Linked value of _start */
+	subs	x9, x1, x2		/* x9 <- Run-vs-link offset */
+	beq	reset
+
+	adrp	x1, __image_copy_start		/* x2 <- address bits [31:12] */
+	add	x1, x1, :lo12:__image_copy_start/* x2 <- address bits [11:00] */
+	adrp	x3, __image_copy_end		/* x3 <- address bits [31:12] */
+	add	x3, x3, :lo12:__image_copy_end	/* x3 <- address bits [11:00] */
+
+copy_loop:
+	ldp	x10, x11, [x1], #16	/* copy from source address [x1] */
+	stp	x10, x11, [x2], #16	/* copy to   target address [x2] */
+	cmp	x1, x3			/* until source end address [x3] */
+	b.lo	copy_loop
+
+	isb
+	ldr	x2, _TEXT_BASE		/* x2 <- Linked value of _start */
+	br	x2			/* Jump to linked address */
+	/* Never reaches this point */
+1:
+	wfi
+	b 1b
+
+relocate_done:
\ No newline at end of file
diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 186c3582eb..9c06c6a3a5 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -3,12 +3,6 @@ if ARCH_QEMU
 config SYS_VENDOR
 	default "emulation"
 
-config SYS_BOARD
-	default "qemu-arm"
-
-config SYS_CONFIG_NAME
-	default "qemu-arm"
-
 choice
 	prompt "QEMU ARM architecture"
 	default TARGET_QEMU_ARM_64BIT
@@ -25,6 +19,36 @@ config TARGET_QEMU_ARM_64BIT
 	select ARM64
 	select BOARD_LATE_INIT
 
+config TARGET_QEMU_ARM_SBSA
+	bool "SBSA Reference"
+	select ARM64
+	select BINMAN
+	select BOARD_LATE_INIT
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select MISC_INIT_R
 endchoice
 
+if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
+
+config SYS_BOARD
+	default "qemu-arm"
+
+config SYS_CONFIG_NAME
+	default "qemu-arm"
+
+endif
+
+if TARGET_QEMU_ARM_SBSA
+
+config SYS_BOARD
+	default "qemu-sbsa"
+
+config SYS_CONFIG_NAME
+	default "qemu-sbsa"
+
+config SYS_SOC
+	default "qemu-sbsa"
+
+endif
+
 endif
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 5154262f29..7bc0ee698c 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -4,5 +4,7 @@ S:	Maintained
 F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
+F:	include/configs/qemu-sbsa.h
 F:	configs/qemu_arm_defconfig
 F:	configs/qemu_arm64_defconfig
+F:	configs/qemu-arm-sbsa_defconfig
diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
new file mode 100644
index 0000000000..fe2313ebc6
--- /dev/null
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -0,0 +1,58 @@
+if TARGET_QEMU_ARM_SBSA
+
+config SYS_SOC
+	default "qemu-sbsa"
+
+config TEXT_BASE
+	default 0x10000100000
+
+config SYS_LOAD_ADDR
+	default 0x10000100000
+
+config PRE_CON_BUF_ADDR
+	default 0x100000FF000
+
+config DEFAULT_DEVICE_TREE
+	default "qemu-sbsa"
+
+config BINMAN_FDT
+	default n
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select AHCI
+	select ACPIGEN
+	select ACPI
+	select CPU
+	select CPU_ARMV8
+	select DM
+	select DM_USB
+	select DM_MTD
+	select GENERATE_ACPI_TABLE
+	select HAS_ROM
+	select MTD
+	select OF_BOARD
+	select PCI
+	select PCIE_ECAM_GENERIC
+	select USB
+	select GIC_V3
+	select GIC_V3_ITS
+	imply AHCI_GENERIC
+	imply USB_XHCI_HCD
+	imply USB_XHCI_GENERIC
+	imply USB_STORAGE
+	imply E1000
+	imply NET_RANDOM_ETHADDR
+	imply VIDEO_BOCHS
+	imply CFI_FLASH
+	imply SYS_MTDPARTS_RUNTIME
+	imply SET_DFU_ALT_INFO
+
+if DEBUG_UART
+
+config DEBUG_UART_BASE
+	default 0x60000000
+endif
+
+source "board/emulation/common/Kconfig"
+endif
diff --git a/board/emulation/qemu-sbsa/Makefile b/board/emulation/qemu-sbsa/Makefile
new file mode 100644
index 0000000000..bacae320e7
--- /dev/null
+++ b/board/emulation/qemu-sbsa/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y	+= qemu-sbsa.o
+obj-y	+= lowlevel_init.o
+obj-y	+= smc.o
+
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += dsdt_generated.o
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi.o
diff --git a/board/emulation/qemu-sbsa/acpi.c b/board/emulation/qemu-sbsa/acpi.c
new file mode 100644
index 0000000000..5c9677a241
--- /dev/null
+++ b/board/emulation/qemu-sbsa/acpi.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 9elements GmbH
+ */
+
+#include <acpi/acpi_table.h>
+#include <asm/acpi_table.h>
+#include <asm/armv8/sec_firmware.h>
+#include <configs/qemu-sbsa.h>
+#include <cpu.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <tables_csum.h>
+#include <string.h>
+
+#include "qemu-sbsa.h"
+
+#define SBSAQEMU_MADT_GIC_VBASE          0x2c020000
+#define SBSAQEMU_MADT_GIC_HBASE          0x2c010000
+#define SBSAQEMU_MADT_GIC_PMU_IRQ        23
+
+#define SBSA_PLATFORM_WATCHDOG_COUNT    1
+#define SBSA_PLATFORM_TIMER_COUNT       (SBSA_PLATFORM_WATCHDOG_COUNT)
+
+#define L2_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | ACPI_PPTT_WRITE_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_UNIFIED << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L2_SIZE 0x80000
+#define L2_SETS 0x400
+#define L2_WAYS 8
+
+#define L1D_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | ACPI_PPTT_WRITE_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_DATA << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L1D_SIZE 0x8000
+#define L1D_SETS 0x100
+#define L1D_WAYS 2
+
+#define L1I_ATTRIBUTES (ACPI_PPTT_READ_ALLOC | \
+			(ACPI_PPTT_CACHE_TYPE_INSTR << \
+			 ACPI_PPTT_CACHE_TYPE_SHIFT))
+#define L1I_SIZE 0x8000
+#define L1I_SETS 0x100
+#define L1I_WAYS 2
+
+int acpi_fill_iort(struct acpi_ctx *ctx)
+{
+	u32 its_offset, smmu_offset;
+	u64 gic_its_base = 0;
+
+	smc_get_gic_its_base(&gic_its_base);
+	if (gic_its_base == 0)
+		return 0;
+
+	u32 identifiers[] = { 0 };
+
+	its_offset = acpi_iort_add_its_group(ctx, ARRAY_SIZE(identifiers),
+					     identifiers);
+
+	struct acpi_iort_id_mapping map_smmu[] = {{
+		0, 0xffff, 0, its_offset, 0
+	}};
+
+	smmu_offset = acpi_iort_add_smmu_v3(ctx,
+					    SBSA_SMMU_BASE_ADDR, // Base address
+					    ACPI_IORT_SMMU_V3_COHACC_OVERRIDE, // Flags
+					    0,  // VATOS address
+					    0,  // SMMUv3 Model
+					    74, // Event
+					    75, // Pri
+					    77, // Gerror
+					    76, // Sync
+					    0,  // Proximity domain
+					    1,  // DevIDMappingIndex
+					    ARRAY_SIZE(map_smmu),
+					    map_smmu);
+
+	struct acpi_iort_id_mapping map_rc[] = {{
+		0, 0xffff, 0, smmu_offset, 0
+	}};
+
+	acpi_iort_add_rc(ctx,
+			 BIT(0) | BIT(56),  // CacheCoherent + CPM
+			 0,  // AtsAttribute
+			 0,  // PciSegmentNumber
+			 64, // MemoryAddressSizeLimit
+			 ARRAY_SIZE(map_rc),
+			 map_rc);
+	return 0;
+}
+
+void acpi_fill_fadt(struct acpi_fadt *fadt)
+{
+	fadt->flags = ACPI_FADT_HW_REDUCED_ACPI | ACPI_FADT_LOW_PWR_IDLE_S0;
+	fadt->preferred_pm_profile = ACPI_PM_PERFORMANCE_SERVER;
+	fadt->arm_boot_arch = ACPI_ARM_PSCI_COMPLIANT;
+}
+
+int acpi_fill_mcfg(struct acpi_ctx *ctx)
+{
+	size_t size;
+
+	/* PCI Segment Group 0, Start Bus Number 0, End Bus Number is 255 */
+	size = acpi_create_mcfg_mmconfig((void *)ctx->current,
+					 SBSA_PCIE_ECAM_BASE_ADDR, 0, 0, 255);
+	acpi_inc(ctx, size);
+
+	return 0;
+}
+
+static int sbsa_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	struct acpi_gtdt *gtdt;
+
+	gtdt = ctx->current;
+	header = &gtdt->header;
+
+	memset(gtdt, '\0', sizeof(struct acpi_gtdt));
+
+	acpi_fill_header(header, "GTDT");
+	header->length = sizeof(struct acpi_gtdt);
+	header->revision = acpi_get_table_revision(ACPITAB_GTDT);
+
+	gtdt->cnt_ctrl_base = 0xFFFFFFFFFFFFFFFF;
+	gtdt->sec_el1_gsiv = 29;
+	gtdt->sec_el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->el1_gsiv = 30;
+	gtdt->el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->virt_el1_gsiv = 27;
+	gtdt->virt_el1_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->el2_gsiv = 26;
+	gtdt->el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	gtdt->cnt_read_base = 0xffffffffffffffff;
+
+	// FIXME: SBSA watchdog
+	//gtdt->plat_timer_count = SBSA_PLATFORM_TIMER_COUNT;
+	//gtdt->plat_timer_offset;
+	//gtdt->virt_el2_gsiv = 28;
+	//gtdt->virt_el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
+	header->checksum = table_compute_checksum(header, header->length);
+
+	acpi_add_table(ctx, gtdt);
+
+	acpi_inc(ctx, sizeof(struct acpi_gtdt));
+
+	return 0;
+};
+
+ACPI_WRITER(5gtdt, "GTDT", sbsa_write_gtdt, 0);
+
+static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	int cluster_offset, l2_offset;
+	u32 offsets[2];
+
+	header = ctx->current;
+	ctx->tab_start = ctx->current;
+
+	memset(header, '\0', sizeof(struct acpi_table_header));
+
+	acpi_fill_header(header, "PPTT");
+	header->revision = acpi_get_table_revision(ACPITAB_PPTT);
+	acpi_inc(ctx, sizeof(*header));
+
+	cluster_offset = acpi_pptt_add_proc(ctx, ACPI_PPTT_PHYSICAL_PACKAGE |
+					    ACPI_PPTT_CHILDREN_IDENTICAL,
+					    0, 0, 0, NULL);
+
+	l2_offset = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_VALID, 0, L2_SIZE,
+					L2_SETS, L2_WAYS, L2_ATTRIBUTES, 64);
+
+	offsets[0] = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_VALID, l2_offset,
+					 L1D_SIZE, L1D_SETS, L1D_WAYS,
+					 L1D_ATTRIBUTES, 64);
+
+	offsets[1] = acpi_pptt_add_cache(ctx, ACPI_PPTT_ALL_BUT_WRITE_POL,
+					 l2_offset, L1I_SIZE, L1I_SETS,
+					 L1I_WAYS, L1I_ATTRIBUTES, 64);
+
+	for (int i = 0; i < uclass_id_count(UCLASS_CPU); i++) {
+		acpi_pptt_add_proc(ctx, ACPI_PPTT_CHILDREN_IDENTICAL |
+				   ACPI_PPTT_NODE_IS_LEAF | ACPI_PPTT_PROC_ID_VALID,
+				   cluster_offset, i, 2, offsets);
+	}
+
+	header->length = ctx->current - ctx->tab_start;
+	header->checksum = table_compute_checksum(header, header->length);
+
+	acpi_inc(ctx, header->length);
+	acpi_add_table(ctx, header);
+
+	return 0;
+};
+
+ACPI_WRITER(5pptt, "PPTT", acpi_write_pptt, 0);
diff --git a/board/emulation/qemu-sbsa/dsdt.asl b/board/emulation/qemu-sbsa/dsdt.asl
new file mode 100644
index 0000000000..3ba9d548d5
--- /dev/null
+++ b/board/emulation/qemu-sbsa/dsdt.asl
@@ -0,0 +1,483 @@
+/** @file
+*  Differentiated System Description Table Fields (DSDT).
+*
+*  Copyright (c) 2020, Linaro Ltd. All rights reserved.
+*
+*  SPDX-License-Identifier: BSD-2-Clause-Patent
+**/
+
+#include <configs/qemu-sbsa.h>
+
+#define LINK_DEVICE(Uid, LinkName, Irq)                                        \
+        Device (LinkName) {                                                    \
+            Name (_HID, EISAID("PNP0C0F"))                                     \
+            Name (_UID, Uid)                                                   \
+            Name (_PRS, ResourceTemplate() {                                   \
+                Interrupt (ResourceProducer, Level, ActiveHigh, Exclusive) { Irq } \
+            })                                                                 \
+            Method (_STA) {                                                    \
+              Return (0xF)                                                     \
+            }                                                                  \
+            Method (_CRS, 0) { Return (_PRS) }                                 \
+            Method (_SRS, 1) { }                                               \
+            Method (_DIS) { }                                                  \
+        }
+
+#define PRT_ENTRY(Address, Pin, Link)                                          \
+        Package (4) {                                                          \
+            Address, Pin, Link, Zero                                           \
+          }
+
+DefinitionBlock ("Dsdt.aml", "DSDT", 2, "U-Boot", "SBSAQEMU", 2) {
+  Scope (_SB) {
+    // UART PL011
+    Device (COM0) {
+      Name (_HID, "ARMH0011")
+      Name (_UID, Zero)
+      Name (_CRS, ResourceTemplate () {
+        Memory32Fixed (ReadWrite,
+                       CFG_SYS_SERIAL0,
+                       0x00001000)
+        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 33 }
+      })
+      Method (_STA) {
+        Return (0xF)
+      }
+    }
+
+    // AHCI Host Controller
+    Device (AHC0) {
+      Name (_HID, "LNRO001E")
+      Name (_CLS, Package (3) {
+        0x01,
+        0x06,
+        0x01,
+      })
+      Name (_CCA, 1)
+      Name (_CRS, ResourceTemplate() {
+        Memory32Fixed (ReadWrite,
+                       SBSA_AHCI_BASE_ADDR,
+                       SBSA_AHCI_LENGTH)
+        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 42 }
+      })
+      Method (_STA) {
+        Return (0xF)
+      }
+    }
+
+
+    // USB XHCI Host Controller
+    Device (USB0) {
+        Name (_HID, "PNP0D10")      // _HID: Hardware ID
+        Name (_UID, 0x00)            // _UID: Unique ID
+        Name (_CCA, 0x01)            // _CCA: Cache Coherency Attribute
+        Name (XHCI, 0xF)            // will be set using AcpiLib
+        Method (_STA) {
+          Return (XHCI)
+        }
+        Name (_CRS, ResourceTemplate() {
+            Memory32Fixed (ReadWrite,
+                           SBSA_XHCI_BASE_ADDR,
+                           SBSA_XHCI_LENGTH)
+            Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive) { 43 }
+        })
+
+        // Root Hub
+        Device (RHUB) {
+            Name (_ADR, 0x00000000)  // Address of Root Hub should be 0 as per ACPI 5.0 spec
+            Method (_STA) {
+              Return (0xF)
+            }
+
+            // Ports connected to Root Hub
+            Device (HUB1) {
+                Name (_ADR, 0x00000001)
+                Name (_UPC, Package() {
+                    0x00,       // Port is NOT connectable
+                    0xFF,       // Don't care
+                    0x00000000, // Reserved 0 must be zero
+                    0x00000000  // Reserved 1 must be zero
+                })
+                Method (_STA) {
+                  Return (0xF)
+                }
+
+                Device (PRT1) {
+                    Name (_ADR, 0x00000001)
+                    Name (_UPC, Package() {
+                        0xFF,        // Port is connectable
+                        0x00,        // Port connector is A
+                        0x00000000,
+                        0x00000000
+                    })
+                    Name (_PLD, Package() {
+                        Buffer(0x10) {
+                            0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                            0x31, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+                        }
+                    })
+                    Method (_STA) {
+                      Return (0xF)
+                    }
+                } // USB0_RHUB_HUB1_PRT1
+                Device (PRT2) {
+                    Name (_ADR, 0x00000002)
+                    Name (_UPC, Package() {
+                        0xFF,        // Port is connectable
+                        0x00,        // Port connector is A
+                        0x00000000,
+                        0x00000000
+                    })
+                    Name (_PLD, Package() {
+                        Buffer(0x10) {
+                            0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                            0x31, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+                        }
+                    })
+                    Method (_STA) {
+                      Return (0xF)
+                    }
+                } // USB0_RHUB_HUB1_PRT2
+
+                Device (PRT3) {
+                    Name (_ADR, 0x00000003)
+                    Name (_UPC, Package() {
+                        0xFF,        // Port is connectable
+                        0x09,        // Type C connector - USB2 and SS with Switch
+                        0x00000000,
+                        0x00000000
+                    })
+                    Name (_PLD, Package() {
+                        Buffer (0x10) {
+                            0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                            0x31, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+                        }
+                    })
+                    Method (_STA) {
+                      Return (0xF)
+                    }
+                } // USB0_RHUB_HUB1_PRT3
+
+                Device (PRT4) {
+                    Name (_ADR, 0x00000004)
+                    Name (_UPC, Package() {
+                        0xFF,        // Port is connectable
+                        0x09,        // Type C connector - USB2 and SS with Switch
+                        0x00000000,
+                        0x00000000
+                    })
+                    Name (_PLD, Package() {
+                        Buffer (0x10){
+                            0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+                            0x31, 0x1C, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+                        }
+                    })
+                    Method (_STA) {
+                      Return (0xF)
+                    }
+                } // USB0_RHUB_HUB1_PRT4
+            } // USB0_RHUB_HUB1
+        } // USB0_RHUB
+    } // USB0
+
+    Device (PCI0)
+    {
+      Name (_HID, EISAID ("PNP0A08")) // PCI Express Root Bridge
+      Name (_CID, EISAID ("PNP0A03")) // Compatible PCI Root Bridge
+      Name (_SEG, Zero) // PCI Segment Group number
+      Name (_BBN, Zero) // PCI Base Bus Number
+      Name (_UID, "PCI0")
+      Name (_CCA, One)    // Initially mark the PCI coherent (for JunoR1)
+
+      Method (_STA) {
+        Return (0xF)
+      }
+
+      Method (_CBA, 0, NotSerialized) {
+          return (SBSA_PCIE_ECAM_BASE_ADDR)
+      }
+
+      LINK_DEVICE(0, GSI0, 0x23)
+      LINK_DEVICE(1, GSI1, 0x24)
+      LINK_DEVICE(2, GSI2, 0x25)
+      LINK_DEVICE(3, GSI3, 0x26)
+
+      Name (_PRT, Package ()  // _PRT: PCI Routing Table
+      {
+        PRT_ENTRY(0x0000FFFF, 0, GSI0),
+        PRT_ENTRY(0x0000FFFF, 0, GSI1),
+        PRT_ENTRY(0x0000FFFF, 0, GSI2),
+        PRT_ENTRY(0x0000FFFF, 0, GSI3),
+
+        PRT_ENTRY(0x0001FFFF, 0, GSI1),
+        PRT_ENTRY(0x0001FFFF, 1, GSI2),
+        PRT_ENTRY(0x0001FFFF, 2, GSI3),
+        PRT_ENTRY(0x0001FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x0002FFFF, 0, GSI2),
+        PRT_ENTRY(0x0002FFFF, 1, GSI3),
+        PRT_ENTRY(0x0002FFFF, 2, GSI0),
+        PRT_ENTRY(0x0002FFFF, 3, GSI1),
+
+        PRT_ENTRY(0x0003FFFF, 0, GSI3),
+        PRT_ENTRY(0x0003FFFF, 1, GSI0),
+        PRT_ENTRY(0x0003FFFF, 2, GSI1),
+        PRT_ENTRY(0x0003FFFF, 3, GSI2),
+
+        PRT_ENTRY(0x0004FFFF, 0, GSI0),
+        PRT_ENTRY(0x0004FFFF, 1, GSI1),
+        PRT_ENTRY(0x0004FFFF, 2, GSI2),
+        PRT_ENTRY(0x0004FFFF, 3, GSI3),
+
+        PRT_ENTRY(0x0005FFFF, 0, GSI1),
+        PRT_ENTRY(0x0005FFFF, 1, GSI2),
+        PRT_ENTRY(0x0005FFFF, 2, GSI3),
+        PRT_ENTRY(0x0005FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x0006FFFF, 0, GSI2),
+        PRT_ENTRY(0x0006FFFF, 1, GSI3),
+        PRT_ENTRY(0x0006FFFF, 2, GSI0),
+        PRT_ENTRY(0x0006FFFF, 3, GSI1),
+
+        PRT_ENTRY(0x0007FFFF, 0, GSI3),
+        PRT_ENTRY(0x0007FFFF, 1, GSI0),
+        PRT_ENTRY(0x0007FFFF, 2, GSI1),
+        PRT_ENTRY(0x0007FFFF, 3, GSI2),
+
+        PRT_ENTRY(0x0008FFFF, 0, GSI0),
+        PRT_ENTRY(0x0008FFFF, 1, GSI1),
+        PRT_ENTRY(0x0008FFFF, 2, GSI2),
+        PRT_ENTRY(0x0008FFFF, 3, GSI3),
+
+        PRT_ENTRY(0x0009FFFF, 0, GSI1),
+        PRT_ENTRY(0x0009FFFF, 1, GSI2),
+        PRT_ENTRY(0x0009FFFF, 2, GSI3),
+        PRT_ENTRY(0x0009FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x000AFFFF, 0, GSI2),
+        PRT_ENTRY(0x000AFFFF, 1, GSI3),
+        PRT_ENTRY(0x000AFFFF, 2, GSI0),
+        PRT_ENTRY(0x000AFFFF, 3, GSI1),
+
+        PRT_ENTRY(0x000BFFFF, 0, GSI3),
+        PRT_ENTRY(0x000BFFFF, 1, GSI0),
+        PRT_ENTRY(0x000BFFFF, 2, GSI1),
+        PRT_ENTRY(0x000BFFFF, 3, GSI2),
+
+        PRT_ENTRY(0x000CFFFF, 0, GSI0),
+        PRT_ENTRY(0x000CFFFF, 1, GSI1),
+        PRT_ENTRY(0x000CFFFF, 2, GSI2),
+        PRT_ENTRY(0x000CFFFF, 3, GSI3),
+
+        PRT_ENTRY(0x000DFFFF, 0, GSI1),
+        PRT_ENTRY(0x000DFFFF, 1, GSI2),
+        PRT_ENTRY(0x000DFFFF, 2, GSI3),
+        PRT_ENTRY(0x000DFFFF, 3, GSI0),
+
+        PRT_ENTRY(0x000EFFFF, 0, GSI2),
+        PRT_ENTRY(0x000EFFFF, 1, GSI3),
+        PRT_ENTRY(0x000EFFFF, 2, GSI0),
+        PRT_ENTRY(0x000EFFFF, 3, GSI1),
+
+        PRT_ENTRY(0x000FFFFF, 0, GSI3),
+        PRT_ENTRY(0x000FFFFF, 1, GSI0),
+        PRT_ENTRY(0x000FFFFF, 2, GSI1),
+        PRT_ENTRY(0x000FFFFF, 3, GSI2),
+
+        PRT_ENTRY(0x0010FFFF, 0, GSI0),
+        PRT_ENTRY(0x0010FFFF, 1, GSI1),
+        PRT_ENTRY(0x0010FFFF, 2, GSI2),
+        PRT_ENTRY(0x0010FFFF, 3, GSI3),
+
+        PRT_ENTRY(0x0011FFFF, 0, GSI1),
+        PRT_ENTRY(0x0011FFFF, 1, GSI2),
+        PRT_ENTRY(0x0011FFFF, 2, GSI3),
+        PRT_ENTRY(0x0011FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x0012FFFF, 0, GSI2),
+        PRT_ENTRY(0x0012FFFF, 1, GSI3),
+        PRT_ENTRY(0x0012FFFF, 2, GSI0),
+        PRT_ENTRY(0x0012FFFF, 3, GSI1),
+
+        PRT_ENTRY(0x0013FFFF, 0, GSI3),
+        PRT_ENTRY(0x0013FFFF, 1, GSI0),
+        PRT_ENTRY(0x0013FFFF, 2, GSI1),
+        PRT_ENTRY(0x0013FFFF, 3, GSI2),
+
+        PRT_ENTRY(0x0014FFFF, 0, GSI0),
+        PRT_ENTRY(0x0014FFFF, 1, GSI1),
+        PRT_ENTRY(0x0014FFFF, 2, GSI2),
+        PRT_ENTRY(0x0014FFFF, 3, GSI3),
+
+        PRT_ENTRY(0x0015FFFF, 0, GSI1),
+        PRT_ENTRY(0x0015FFFF, 1, GSI2),
+        PRT_ENTRY(0x0015FFFF, 2, GSI3),
+        PRT_ENTRY(0x0015FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x0016FFFF, 0, GSI2),
+        PRT_ENTRY(0x0016FFFF, 1, GSI3),
+        PRT_ENTRY(0x0016FFFF, 2, GSI0),
+        PRT_ENTRY(0x0016FFFF, 3, GSI1),
+
+        PRT_ENTRY(0x0017FFFF, 0, GSI3),
+        PRT_ENTRY(0x0017FFFF, 1, GSI0),
+        PRT_ENTRY(0x0017FFFF, 2, GSI1),
+        PRT_ENTRY(0x0017FFFF, 3, GSI2),
+
+        PRT_ENTRY(0x0018FFFF, 0, GSI0),
+        PRT_ENTRY(0x0018FFFF, 1, GSI1),
+        PRT_ENTRY(0x0018FFFF, 2, GSI2),
+        PRT_ENTRY(0x0018FFFF, 3, GSI3),
+
+        PRT_ENTRY(0x0019FFFF, 0, GSI1),
+        PRT_ENTRY(0x0019FFFF, 1, GSI2),
+        PRT_ENTRY(0x0019FFFF, 2, GSI3),
+        PRT_ENTRY(0x0019FFFF, 3, GSI0),
+
+        PRT_ENTRY(0x001AFFFF, 0, GSI2),
+        PRT_ENTRY(0x001AFFFF, 1, GSI3),
+        PRT_ENTRY(0x001AFFFF, 2, GSI0),
+        PRT_ENTRY(0x001AFFFF, 3, GSI1),
+
+        PRT_ENTRY(0x001BFFFF, 0, GSI3),
+        PRT_ENTRY(0x001BFFFF, 1, GSI0),
+        PRT_ENTRY(0x001BFFFF, 2, GSI1),
+        PRT_ENTRY(0x001BFFFF, 3, GSI2),
+
+        PRT_ENTRY(0x001CFFFF, 0, GSI0),
+        PRT_ENTRY(0x001CFFFF, 1, GSI1),
+        PRT_ENTRY(0x001CFFFF, 2, GSI2),
+        PRT_ENTRY(0x001CFFFF, 3, GSI3),
+
+        PRT_ENTRY(0x001DFFFF, 0, GSI1),
+        PRT_ENTRY(0x001DFFFF, 1, GSI2),
+        PRT_ENTRY(0x001DFFFF, 2, GSI3),
+        PRT_ENTRY(0x001DFFFF, 3, GSI0),
+
+        PRT_ENTRY(0x001EFFFF, 0, GSI2),
+        PRT_ENTRY(0x001EFFFF, 1, GSI3),
+        PRT_ENTRY(0x001EFFFF, 2, GSI0),
+        PRT_ENTRY(0x001EFFFF, 3, GSI1),
+
+        PRT_ENTRY(0x001FFFFF, 0, GSI3),
+        PRT_ENTRY(0x001FFFFF, 1, GSI0),
+        PRT_ENTRY(0x001FFFFF, 2, GSI1),
+        PRT_ENTRY(0x001FFFFF, 3, GSI2),
+      })
+
+      // Root complex resources
+      Name (_CRS, ResourceTemplate () {
+        WordBusNumber ( // Bus numbers assigned to this root
+        ResourceProducer,
+        MinFixed, MaxFixed, PosDecode,
+        0,   // AddressGranularity
+        0,   // AddressMinimum - Minimum Bus Number
+        0xff,// AddressMaximum - Maximum Bus Number
+        0,   // AddressTranslation - Set to 0
+        256  // RangeLength - Number of Busses
+        )
+
+        // IO to mmio window
+        QWordIO (
+          ResourceProducer, MinFixed,
+          MaxFixed, PosDecode,
+          EntireRange,
+          0x00000000,                              // Granularity
+          0x0000,                                  // Min Base Address
+          0xffff,                                  // Max Base Address
+          SBSA_PIO_BASE_ADDR,                      // Translate
+          SBSA_PIO_LENGTH                          // Length
+        )
+
+        DWordMemory ( // 32-bit BAR Windows
+          ResourceProducer, PosDecode,
+          MinFixed, MaxFixed,
+          Cacheable, ReadWrite,
+          0x00000000,                              // Granularity
+          SBSA_PCIE_MMIO_BASE_ADDR,                // Min Base Address
+          SBSA_PCIE_MMIO_END,                      // Max Base Address
+          0,                                       // Translate
+          SBSA_PCIE_MMIO_LENGTH                    // Length
+          )
+
+        QWordMemory ( // 64-bit BAR Windows
+          ResourceProducer, PosDecode,
+          MinFixed, MaxFixed,
+          Cacheable, ReadWrite,
+          0x00000000,                              // Granularity
+          SBSA_PCIE_MMIO_HIGH_BASE_ADDR,           // Min Base Address
+          SBSA_PCIE_MMIO_HIGH_END,                 // Max Base Address
+          0,                                       // Translate
+          SBSA_PCIE_MMIO_HIGH_LENGTH               // Length
+          )
+      }) // Name(_CRS)
+
+      Device (RES0)
+      {
+        Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
+        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+        {
+           QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+           0x0000000000000000,                       // Granularity
+           SBSA_PCIE_ECAM_BASE_ADDR,                 // Range Minimum
+           SBSA_PCIE_ECAM_END,                       // Range Maximum
+           0x0000000000000000,                       // Translation Offset
+           SBSA_PCIE_ECAM_LENGTH,                    // Length
+           ,, , AddressRangeMemory, TypeStatic)
+        })
+        Method (_STA) {
+          Return (0xF)
+        }
+      }
+
+      // OS Control Handoff
+      Name (SUPP, Zero) // PCI _OSC Support Field value
+      Name (CTRL, Zero) // PCI _OSC Control Field value
+
+      /*
+       * See [1] 6.2.10, [2] 4.5
+       */
+      Method (_OSC,4) {
+        // Check for proper UUID
+        If (Arg0 == ToUUID("33DB4D5B-1FF7-401C-9657-7441C03DD766")) {
+          // Create DWord-adressable fields from the Capabilities Buffer
+          CreateDWordField (Arg3,0,CDW1)
+          CreateDWordField (Arg3,4,CDW2)
+          CreateDWordField (Arg3,8,CDW3)
+
+          // Save Capabilities DWord2 & 3
+          Store (CDW2,SUPP)
+          Store (CDW3,CTRL)
+
+          // Only allow native hot plug control if OS supports:
+          // * ASPM
+          // * Clock PM
+          // * MSI/MSI-X
+          If ((SUPP & 0x16) != 0x16) {
+            CTRL &= 0x1E // Mask bit 0 (and undefined bits)
+          }
+
+          // Always allow native PME, AER (no dependencies)
+
+          // Never allow SHPC (no SHPC controller in this system)
+          CTRL &= 0x1D
+
+          If (Arg1 != One) {         // Unknown revision
+            CDW1 |= 0x08
+          }
+
+          If (CDW3 != CTRL) {        // Capabilities bits were masked
+            CDW1 |= 0x10
+          }
+
+          // Update DWORD3 in the buffer
+          Store (CTRL,CDW3)
+          Return (Arg3)
+        } Else {
+          CDW1 |= 4 // Unrecognized UUID
+          Return (Arg3)
+        }
+      } // End _OSC
+    }
+  } // Scope (_SB)
+}
diff --git a/board/emulation/qemu-sbsa/lowlevel_init.S b/board/emulation/qemu-sbsa/lowlevel_init.S
new file mode 100644
index 0000000000..c997721af9
--- /dev/null
+++ b/board/emulation/qemu-sbsa/lowlevel_init.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2016
+ * Cédric Schieli <cschieli@gmail.com>
+ */
+
+#include <config.h>
+
+/*
+ * Routine: save_boot_params (called after reset from start.S)
+ * Description: save ATAG/FDT address provided by the firmware at boot time
+ */
+
+.global save_boot_params
+save_boot_params:
+	/* The firmware provided ATAG/FDT address can be found in r2/x0 */
+	adr	x8, fw_dtb_pointer
+	str	x0, [x8]
+
+
+	/* Returns */
+	b	save_boot_params_ret
diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.c b/board/emulation/qemu-sbsa/qemu-sbsa.c
new file mode 100644
index 0000000000..0d59b114c8
--- /dev/null
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.c
@@ -0,0 +1,602 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2017 Tuomas Tynkkynen
+ */
+
+#include <asm/armv8/mmu.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <env.h>
+#include <fdtdec.h>
+#include <fdt_support.h>
+#include <init.h>
+#include <log.h>
+#include <usb.h>
+
+#include "qemu-sbsa.h"
+
+/* Assigned in lowlevel_init.S
+ * Push the variable into the .data section so that it
+ * does not get cleared later.
+ */
+unsigned long __section(".data") fw_dtb_pointer;
+
+static struct mm_region qemu_sbsa_mem_map[] = {
+	{
+		/* Secure flash */
+		.virt = SBSA_SECURE_FLASH_BASE_ADDR,
+		.phys = SBSA_SECURE_FLASH_BASE_ADDR,
+		.size = SBSA_SECURE_FLASH_LENGTH,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Flash */
+		.virt = SBSA_FLASH_BASE_ADDR,
+		.phys = SBSA_FLASH_BASE_ADDR,
+		.size = SBSA_FLASH_LENGTH,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* Lowmem peripherals */
+		.virt = SBSA_PERIPH_BASE_ADDR,
+		.phys = SBSA_PERIPH_BASE_ADDR,
+		.size = SBSA_PCIE_MMIO_BASE_ADDR - SBSA_PERIPH_BASE_ADDR,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* 32-bit address PCIE MMIO space */
+		.virt = SBSA_PCIE_MMIO_BASE_ADDR,
+		.phys = SBSA_PCIE_MMIO_BASE_ADDR,
+		.size = SBSA_PCIE_MMIO_LENGTH,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCI-E ECAM memory area */
+		.virt = SBSA_PCIE_ECAM_BASE_ADDR,
+		.phys = SBSA_PCIE_ECAM_BASE_ADDR,
+		.size = SBSA_PCIE_ECAM_LENGTH,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* Highmem PCI-E MMIO memory area */
+		.virt = SBSA_PCIE_MMIO_HIGH_BASE_ADDR,
+		.phys = SBSA_PCIE_MMIO_HIGH_BASE_ADDR,
+		.size = SBSA_PCIE_MMIO_HIGH_LENGTH,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* DRAM */
+		.virt = SBSA_MEM_BASE_ADDR,
+		.phys = SBSA_MEM_BASE_ADDR,
+		.size = 0x800000000000ULL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	}, {
+		/* List terminator */
+		0,
+	}
+};
+
+struct mm_region *mem_map = qemu_sbsa_mem_map;
+
+int board_late_init(void)
+{
+	/* start usb so that usb keyboard can be used as input device */
+	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
+		usb_init();
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+/*
+ * If the firmware passed a device tree use it for U-Boot.
+ * It only contains CPU count and usable DRAM, but no devices.
+ */
+void *board_fdt_blob_setup(int *err)
+{
+	*err = 0;
+
+	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC) {
+		*err = -ENXIO;
+		return NULL;
+	}
+	return (void *)fw_dtb_pointer;
+}
+
+/*
+ * QEMU doesn't set compatible on cpus, so add it for the CPU driver.
+ */
+static int fdtdec_fix_cpus(void *fdt_blob)
+{
+	int cpus_offset, off, ret;
+	u64 mpidr, i = 0;
+
+	cpus_offset = fdt_path_offset(fdt_blob, "/cpus");
+	if (cpus_offset < 0) {
+		puts("couldn't find /cpus node\n");
+		return cpus_offset;
+	}
+
+	for (off = fdt_first_subnode(fdt_blob, cpus_offset);
+	     off >= 0;
+	     off = fdt_next_subnode(fdt_blob, off)) {
+		if (strncmp(fdt_get_name(fdt_blob, off, NULL), "cpu@", 4))
+			continue;
+
+		ret = fdt_setprop_string(fdt_blob, off, "compatible", "arm,armv8");
+		if (ret < 0)
+			return ret;
+
+		ret = fdt_setprop_string(fdt_blob, off, "device_type", "cpu");
+		if (ret < 0)
+			return ret;
+
+		ret = smc_get_mpidr(i++, &mpidr);
+		if (ret) {
+			log_err("Failed to get MPIDR for processor %lld from SMC: %d\n",
+				i, ret);
+			mpidr = i;
+		}
+
+		ret = fdt_setprop_u64(fdt_blob, off, "reg", mpidr);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+/*
+ * QEMU doesn't add the UART, so add one.
+ */
+static int fdtdec_add_uart(void *fdt)
+{
+	u64 reg[2];
+	int offs, ret;
+
+	offs = fdt_path_offset(fdt, "/soc/uart0");
+	if (offs < 0)
+		return offs;
+
+	ret = fdt_setprop_string(fdt, offs, "compatible", "arm,pl011");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "status", "okay");
+	if (ret < 0)
+		return ret;
+
+	reg[0] = cpu_to_fdt64((u64)SBSA_UART_BASE_ADDR);
+	reg[1] = cpu_to_fdt64((u64)SBSA_UART_LENGTH);
+	ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 2);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * QEMU doesn't add the AHCI, so add one.
+ */
+static int fdtdec_add_ahci(void *fdt)
+{
+	u64 reg[2];
+	int offs, ret;
+
+	offs = fdt_path_offset(fdt, "/soc/ahci");
+	if (offs < 0)
+		return offs;
+
+	ret = fdt_setprop_string(fdt, offs, "compatible", "generic-ahci");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "status", "okay");
+	if (ret < 0)
+		return ret;
+
+	reg[0] = cpu_to_fdt64((u64)SBSA_AHCI_BASE_ADDR);
+	reg[1] = cpu_to_fdt64((u64)SBSA_AHCI_LENGTH);
+	ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 2);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * QEMU doesn't add the XHCI, so add one.
+ */
+static int fdtdec_add_xhci(void *fdt)
+{
+	u64 reg[2];
+	int offs, ret;
+
+	offs = fdt_path_offset(fdt, "/soc/xhci");
+	if (offs < 0)
+		return offs;
+	
+	ret = fdt_setprop_string(fdt, offs, "compatible", "generic-xhci");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "status", "okay");
+	if (ret < 0)
+		return ret;
+
+	reg[0] = cpu_to_fdt64((u64)SBSA_XHCI_BASE_ADDR);
+	reg[1] = cpu_to_fdt64((u64)SBSA_XHCI_LENGTH);
+	ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 2);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * QEMU doesn't add the ECAM, so add one.
+ */
+static int fdtdec_add_ecam(void *fdt)
+{
+	u32 reg32[2], range[21];
+	u64 reg[2];
+	int offs, ret;
+	
+	offs = fdt_path_offset(fdt,  "/soc/pci");
+	if (offs < 0)
+		return offs;
+
+	ret = fdt_setprop_string(fdt, offs, "compatible", "pci-host-ecam-generic");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "device_type", "pci");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "status", "okay");
+	if (ret < 0)
+		return ret;
+
+	reg[0] = cpu_to_fdt64((u64)SBSA_PCIE_ECAM_BASE_ADDR);
+	reg[1] = cpu_to_fdt64((u64)SBSA_PCIE_ECAM_LENGTH);
+	ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 2);
+	if (ret < 0)
+		return ret;
+
+	reg32[0] = 0;
+	reg32[1] = 0xff;
+	ret = fdt_setprop(fdt, offs, "bus-range", reg32, sizeof(u32) * 2);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_cell(fdt, offs, "#address-cells", 3);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_cell(fdt, offs, "#size-cells", 2);
+	if (ret < 0)
+		return ret;
+
+	range[0] = cpu_to_fdt32(0x01000000);
+	range[1] = cpu_to_fdt32(0);
+	range[2] = cpu_to_fdt32(0);
+	range[3] = cpu_to_fdt32((u64)SBSA_PIO_BASE_ADDR >> 32);
+	range[4] = cpu_to_fdt32((u64)SBSA_PIO_BASE_ADDR & 0xffffffff);
+	range[5] = cpu_to_fdt32((u64)SBSA_PIO_LENGTH >> 32);
+	range[6] = cpu_to_fdt32((u64)SBSA_PIO_LENGTH & 0xffffffff);
+
+	range[7] = cpu_to_fdt32(0x02000000);
+	range[8] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_BASE_ADDR >> 32);
+	range[9] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_BASE_ADDR & 0xffffffff);
+	range[10] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_BASE_ADDR >> 32);
+	range[11] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_BASE_ADDR & 0xffffffff);
+	range[12] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_LENGTH >> 32);
+	range[13] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_LENGTH & 0xffffffff);
+
+	range[14] = cpu_to_fdt32(0x43000000);
+	range[15] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_BASE_ADDR >> 32);
+	range[16] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_BASE_ADDR & 0xffffffff);
+	range[17] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_BASE_ADDR >> 32);
+	range[18] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_BASE_ADDR & 0xffffffff);
+	range[19] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_LENGTH >> 32);
+	range[20] = cpu_to_fdt32((u64)SBSA_PCIE_MMIO_HIGH_LENGTH & 0xffffffff);
+
+	ret = fdt_setprop(fdt, offs, "ranges", range, sizeof(range));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * QEMU's GIC node is incomplete, fix it.
+ */
+static int fdtdec_fix_gic(void *fdt)
+{
+	u64 gic_dist_base = SBSA_GIC_DIST_BASE_ADDR;
+	u64 gic_redist_base = SBSA_GIC_REDIST_BASE_ADDR;
+	u64 gic_its_base = 0;
+	unsigned int phandle;
+	u64 reg[10];
+	u32 reg32;
+	int offs, ret;
+
+	smc_get_gic_dist_base(&gic_dist_base);
+	smc_get_gic_redist_base(&gic_redist_base);
+	smc_get_gic_its_base(&gic_its_base);
+
+	offs = fdt_path_offset(fdt, "/intc");
+	if (offs < 0) {
+		puts("couldn't find /intc node\n");
+		return offs;
+	}
+
+	ret = fdt_setprop_string(fdt, offs, "compatible", "arm,gic-v3");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_string(fdt, offs, "status", "okay");
+	if (ret < 0)
+		return ret;
+
+	reg[0] = cpu_to_fdt64(gic_dist_base);
+	reg[1] = cpu_to_fdt64((u64)SBSA_GIC_DIST_LENGTH);
+	reg[2] = cpu_to_fdt64(gic_redist_base);
+	reg[3] = cpu_to_fdt64((u64)SBSA_GIC_REDIST_LENGTH);
+	reg[4] = cpu_to_fdt64(0x2c000000);
+	reg[5] = cpu_to_fdt64(0x10000);
+	reg[6] = cpu_to_fdt64(SBSA_GIC_HBASE_ADDR);
+	reg[7] = cpu_to_fdt64((u64)SBSA_GIC_HBASE_LENGTH);
+	reg[8] = cpu_to_fdt64(SBSA_GIC_VBASE_ADDR);
+	reg[9] = cpu_to_fdt64((u64)SBSA_GIC_VBASE_LENGTH);
+
+	ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 10);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_cell(fdt, offs, "#interrupt-cells", 1);
+	if (ret < 0)
+		return ret;
+
+	reg32 = 25;
+	ret = fdt_setprop(fdt, offs, "interrupts", &reg32, sizeof(reg32));
+	if (ret < 0)
+		return ret;
+
+	if (gic_its_base != 0) {
+		offs = fdt_path_offset(fdt, "/");
+		if (offs < 0)
+			return offs;
+
+		ret = fdt_add_subnode(fdt, offs, "its");
+		if (ret < 0)
+			return ret;
+
+		offs = fdt_path_offset(fdt, "/its");
+		if (offs < 0)
+			return offs;
+
+		ret = fdt_setprop_string(fdt, offs, "compatible", "arm,gic-v3-its");
+		if (ret < 0)
+			return ret;
+
+		ret = fdt_setprop_string(fdt, offs, "status", "okay");
+		if (ret < 0)
+			return ret;
+
+		reg[0] = cpu_to_fdt64(gic_its_base);
+		reg[1] = 0;
+
+		ret = fdt_setprop(fdt, offs, "reg", reg, sizeof(u64) * 2);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Add global interrupt-parent */
+	phandle = fdt_create_phandle_by_compatible(fdt, "arm,gic-v3");
+	if (!phandle)
+		return -ENOENT;
+
+	offs = fdt_path_offset(fdt, "/");
+	if (offs < 0)
+		return offs;
+
+	ret = fdt_setprop_u32(fdt, offs, "interrupt-parent", phandle);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * QEMU doesn't add device to FDT since it's an ACPI platform.
+ * Add devices for U-Boot drivers here.
+ */
+static int fdtdec_add_devices(void *fdt)
+{
+	const char *path, *subpath;
+	int offs, ret;
+
+	offs = fdt_increase_size(fdt, 1024);
+	if (offs)
+		return -ENOMEM;
+
+	path = "/";
+	offs = fdt_path_offset(fdt, path);
+	if (offs < 0) {
+		printf("Could not find root node.\n");
+		return offs;
+	}
+
+	subpath = "soc";
+	ret = fdt_add_subnode(fdt, offs, subpath);
+	if (ret < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return ret;
+	}
+
+	path = "/soc";
+	offs = fdt_path_offset(fdt, path);
+	if (offs < 0)
+		return offs;
+
+	ret = fdt_setprop_string(fdt, offs, "compatible", "simple-bus");
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_cell(fdt, offs, "#address-cells", 2);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_cell(fdt, offs, "#size-cells", 2);
+	if (ret < 0)
+		return ret;
+
+	ret = fdt_setprop_empty(fdt, offs, "ranges");
+	if (ret < 0)
+		return ret;
+
+	subpath = "uart0";
+	ret = fdt_add_subnode(fdt, offs, subpath);
+	if (ret < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return ret;
+	}
+
+	subpath = "ahci";
+	ret = fdt_add_subnode(fdt, offs, subpath);
+	if (ret < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return ret;
+	}
+
+	subpath = "xhci";
+	ret = fdt_add_subnode(fdt, offs, subpath);
+	if (ret < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return ret;
+	}
+
+	subpath = "pci";
+	ret = fdt_add_subnode(fdt, offs, subpath);
+	if (ret < 0) {
+		printf("Could not create %s node.\n", subpath);
+		return ret;
+	}
+
+	ret = fdtdec_add_uart(fdt);
+	if (ret < 0)
+		return ret;
+
+	ret = fdtdec_add_ahci(fdt);
+	if (ret < 0)
+		return ret;
+	
+	ret = fdtdec_add_xhci(fdt);
+	if (ret < 0)
+		return ret;
+
+	ret = fdtdec_add_ecam(fdt);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int fdtdec_board_setup(const void *fdt_blob)
+{
+	int ret;
+
+	ret = fdtdec_fix_cpus((void *)fdt_blob);
+	if (ret < 0)
+		log_err("Failed to fix CPUs in FDT: %d\n", ret);
+
+	ret = fdtdec_fix_gic((void *)fdt_blob);
+	if (ret < 0)
+		log_err("Failed to fix INTC in FDT: %d\n", ret);
+
+	ret = fdtdec_add_devices((void *)fdt_blob);
+	if (ret < 0)
+		log_err("Failed to add devices to FDT: %d\n", ret);
+
+	return 0;
+}
+
+int misc_init_r(void)
+{
+	return env_set_hex("fdt_addr", (uintptr_t)gd->fdt_blob);
+}
+
+void reset_cpu(void)
+{
+}
+
+int dram_init(void)
+{
+	if (fdtdec_setup_mem_size_base() != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	fdtdec_setup_memory_banksize();
+
+	return 0;
+}
+
+void enable_caches(void)
+{
+	 icache_enable();
+	 dcache_enable();
+}
+
+u8 flash_read8(void *addr)
+{
+	u8 ret;
+
+	asm("ldrb %w0, %1" : "=r"(ret) : "m"(*(u8 *)addr));
+	return ret;
+}
+
+u16 flash_read16(void *addr)
+{
+	u16 ret;
+
+	asm("ldrh %w0, %1" : "=r"(ret) : "m"(*(u16 *)addr));
+	return ret;
+}
+
+u32 flash_read32(void *addr)
+{
+	u32 ret;
+
+	asm("ldr %w0, %1" : "=r"(ret) : "m"(*(u32 *)addr));
+	return ret;
+}
+
+void flash_write8(u8 value, void *addr)
+{
+	asm("strb %w1, %0" : "=m"(*(u8 *)addr) : "r"(value));
+}
+
+void flash_write16(u16 value, void *addr)
+{
+	asm("strh %w1, %0" : "=m"(*(u16 *)addr) : "r"(value));
+}
+
+void flash_write32(u32 value, void *addr)
+{
+	asm("str %w1, %0" : "=m"(*(u32 *)addr) : "r"(value));
+}
diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.env b/board/emulation/qemu-sbsa/qemu-sbsa.env
new file mode 100644
index 0000000000..88fdb0ec1c
--- /dev/null
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.env
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* environment for qemu-arm and qemu-arm64 */
+
+stdin=serial,usbkbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+fdt_high=0xffffffffffffffff
+initrd_high=0xffffffffffffffff
+scriptaddr=0x100000300000
+pxefile_addr_r=0x10000400000
+kernel_addr_r=0x10000200000
+ramdisk_addr_r=0x10001000000
+boot_targets=qfw usb scsi virtio nvme dhcp
diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.h b/board/emulation/qemu-sbsa/qemu-sbsa.h
new file mode 100644
index 0000000000..391a70bdc4
--- /dev/null
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 9elements GmbH
+ */
+
+/**
+ * smc_get_mpidr() - Call into SMC and get the MPIDR for given CPU
+ *
+ * @id:		CPU index
+ * @mpidr:	Pointer where to place the MPIDR
+ * @return 0 if OK, other -ve on error
+ */
+int smc_get_mpidr(unsigned long id, u64 *mpidr);
+
+/**
+ * smc_get_gic_dist_base() - Call into SMC and get GIC dist base address
+ *
+ * @mpidr:	Pointer where to place the base address
+ * @return 0 if OK, other -ve on error
+ */
+int smc_get_gic_dist_base(u64 *base);
+
+/**
+ * smc_get_gic_redist_base() - Call into SMC and get the GIC redistributor
+ *                             base address
+ *
+ * @mpidr:	Pointer where to place the base address
+ * @return 0 if OK, other -ve on error
+ */
+int smc_get_gic_redist_base(u64 *base);
+
+/**
+ * smc_get_gic_its_base() - Call into SMC and get the ITS base address
+ *
+ * @mpidr:	Pointer where to place the base address
+ * @return 0 if OK, other -ve on error
+ */
+int smc_get_gic_its_base(u64 *base);
diff --git a/board/emulation/qemu-sbsa/smc.c b/board/emulation/qemu-sbsa/smc.c
new file mode 100644
index 0000000000..fc08356aec
--- /dev/null
+++ b/board/emulation/qemu-sbsa/smc.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 9elements GmbH
+ */
+
+#include <config.h>
+#include <cpu.h>
+#include <init.h>
+#include <log.h>
+#include <linux/arm-smccc.h>
+
+#define SMC_SIP_FUNCTION_ID(n)  (0xC2000000 | (n))
+
+#define SIP_SVC_VERSION        SMC_SIP_FUNCTION_ID(1)
+#define SIP_SVC_GET_GIC        SMC_SIP_FUNCTION_ID(100)
+#define SIP_SVC_GET_GIC_ITS    SMC_SIP_FUNCTION_ID(101)
+#define SIP_SVC_GET_CPU_COUNT  SMC_SIP_FUNCTION_ID(200)
+#define SIP_SVC_GET_CPU_NODE   SMC_SIP_FUNCTION_ID(201)
+#define SIP_SVC_GET_MEMORY_NODE_COUNT SMC_SIP_FUNCTION_ID(300)
+#define SIP_SVC_GET_MEMORY_NODE SMC_SIP_FUNCTION_ID(301)
+
+int smc_get_mpidr(unsigned long id, u64 *mpidr)
+{
+	struct arm_smccc_res res;
+
+	res.a0 = ~0;
+	arm_smccc_smc(SIP_SVC_GET_CPU_NODE, id, 0, 0, 0, 0, 0, 0, &res);
+
+	if (!res.a0)
+		*mpidr = res.a2;
+
+	return res.a0;
+}
+
+int smc_get_gic_dist_base(u64 *base)
+{
+	struct arm_smccc_res res;
+
+	res.a0 = ~0;
+	arm_smccc_smc(SIP_SVC_GET_GIC, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (!res.a0)
+		*base = res.a1;
+
+	return res.a0;
+}
+
+int smc_get_gic_redist_base(u64 *base)
+{
+	struct arm_smccc_res res;
+
+	res.a0 = ~0;
+	arm_smccc_smc(SIP_SVC_GET_GIC, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (!res.a0)
+		*base = res.a2;
+
+	return res.a0;
+}
+
+int smc_get_gic_its_base(u64 *base)
+{
+	struct arm_smccc_res res;
+
+	res.a0 = ~0;
+	arm_smccc_smc(SIP_SVC_GET_GIC_ITS, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (!res.a0)
+		*base = res.a1;
+
+	return res.a0;
+}
diff --git a/configs/qemu-arm-sbsa_defconfig b/configs/qemu-arm-sbsa_defconfig
new file mode 100644
index 0000000000..a58c3dec4c
--- /dev/null
+++ b/configs/qemu-arm-sbsa_defconfig
@@ -0,0 +1,10 @@
+CONFIG_ARM=y
+CONFIG_ARCH_QEMU=y
+CONFIG_TARGET_QEMU_ARM_SBSA=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="bootflow scan"
+CONFIG_EFI_PARTITION=y
+CONFIG_PARTITION_TYPE_GUID=y
+CONFIG_EFI_MEDIA=y
+CONFIG_FS_FAT=y
+CONFIG_EFI_VARIABLE_NO_STORE=y
diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index 98a0b26ad2..0419d72415 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -13,5 +13,6 @@ Emulation
    qemu-mips
    qemu-ppce500
    qemu-riscv
+   qemu-sbsa
    qemu-x86
    qemu-xtensa
diff --git a/doc/board/emulation/qemu-sbsa.rst b/doc/board/emulation/qemu-sbsa.rst
new file mode 100644
index 0000000000..d4b7fe53be
--- /dev/null
+++ b/doc/board/emulation/qemu-sbsa.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2024, Patrick Rudolph <patrick.rudolph@9elements.com>
+
+QEMU ARM SBSA
+=============
+
+QEMU for ARM supports Arm Server Base System Architecture Reference board,
+short 'sbsa-ref' that utilizes ACPI over FDT. This document describes how to run
+U-Boot under it. Only AArch64 is supported.
+
+The 'sbsa' platform provides the following as the basic functionality:
+
+    - A freely configurable amount of CPU cores
+    - U-Boot loaded and executing in the emulated flash at address 0x10000000
+    - No device tree blob
+    - A freely configurable amount of RAM
+    - A PL011 serial port
+    - An ARMv7/ARMv8 architected timer
+    - PSCI for rebooting the system
+    - A generic ECAM-based PCI host controller
+
+Additionally, a number of optional peripherals can be added to the PCI bus.
+
+Compile ARM Trusted Firmware (ATF)
+----------------------------------
+
+Get and Build the ARM Trusted firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/ARM-software/arm-trusted-firmware
+
+.. code-block:: bash
+
+  git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git tfa
+  cd tfa
+  make CROSS_COMPILE=aarch64-linux-gnu- all fip \
+    ARM_LINUX_KERNEL_AS_BL33=1 DEBUG=1 PLAT=qemu_sbsa
+
+Copy the resulting FIP and BL1 binary
+
+.. code-block:: bash
+
+  cp build/qemu_sbsa/debug/fip.bin ../
+  cp build/qemu_sbsa/debug/bl1.bin ../
+
+Building U-Boot
+---------------
+Set the CROSS_COMPILE environment variable as usual, and run:
+
+.. code-block:: bash
+
+    make qemu-arm-sbsa_defconfig
+    make
+
+Running U-Boot
+--------------
+The minimal QEMU command line to get U-Boot up and running is:
+
+.. code-block:: bash
+
+    qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
+                        -pflash secure-world.rom \
+                        -pflash unsecure-world.rom
+
+Note that for some odd reason qemu-system-aarch64 needs to be explicitly
+told to use a 64-bit CPU or it will boot in 32-bit mode. The -nographic argument
+ensures that output appears on the terminal. Use Ctrl-A X to quit.
+
+Booting distros
+---------------
+
+It is possible to install and boot a standard Linux distribution using
+sbsa by setting up a root disk::
+
+.. code-block:: bash
+
+    qemu-img create root.img 20G
+
+then using the installer to install. For example, with Debian 12::
+
+.. code-block:: bash
+
+    qemu-system-aarch64 \
+      -machine sbsa -cpu cortex-a57 -m 4G -smp 4 \
+      -pflash secure-world.rom \
+      -pflash unsecure-world.rom \
+      -device virtio-rng-pci \
+      -device usb-kbd -device usb-tablet \
+      -cdrom debian-12.0.0-arm64-netinst.iso \
+      -hda root.img
+
+Debug UART
+----------
+
+The debug UART on the ARM sbsa board uses these settings::
+
+    CONFIG_DEBUG_UART=y
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index 8ac9c94caf..31b94d0467 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -34,6 +34,7 @@ The following QEMU targets are supported.
 
   - qemu_arm_defconfig
   - qemu_arm64_defconfig
+  - qemu-arm-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
   - qemu-x86_defconfig
diff --git a/include/configs/qemu-sbsa.h b/include/configs/qemu-sbsa.h
new file mode 100644
index 0000000000..cbcae64501
--- /dev/null
+++ b/include/configs/qemu-sbsa.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024 9elements GmbH
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+/* Physical memory map */
+
+/* SECURE_FLASH */
+#define SBSA_SECURE_FLASH_BASE_ADDR	0x00000000
+#define SBSA_SECURE_FLASH_LENGTH	0x01000000
+
+/* FLASH */
+#define SBSA_FLASH_BASE_ADDR		0x10000000
+#define SBSA_FLASH_LENGTH		0x01000000
+
+/* PERIPH */
+#define SBSA_PERIPH_BASE_ADDR		0x40000000
+
+/* GIC_DIST */
+#define SBSA_GIC_DIST_BASE_ADDR		0x40060000
+#define SBSA_GIC_DIST_LENGTH		0x00020000
+
+#define SBSA_GIC_VBASE_ADDR		0x2c020000
+#define SBSA_GIC_VBASE_LENGTH		0x00010000
+
+#define SBSA_GIC_HBASE_ADDR		0x2c010000
+#define SBSA_GIC_HBASE_LENGTH		0x00010000
+
+/* GIC_REDIST */
+#define SBSA_GIC_REDIST_BASE_ADDR	0x40080000
+#define SBSA_GIC_REDIST_LENGTH		0x04000000
+
+/* GIC_ITS */
+#define SBSA_GIC_ITS_BASE_ADDR		0x44081000
+
+/* UART */
+#define SBSA_UART_BASE_ADDR		0x60000000
+#define SBSA_UART_LENGTH		0x00001000
+
+/* RTC */
+#define SBSA_RTC_BASE_ADDR		0x60010000
+
+/* GPIO */
+#define SBSA_GPIO_BASE_ADDR		0x60020000
+
+/* SMMU */
+#define SBSA_SMMU_BASE_ADDR		0x60050000
+
+/* SATA */
+#define SBSA_AHCI_BASE_ADDR		0x60100000
+#define SBSA_AHCI_LENGTH		0x00010000
+
+/* xHCI */
+#define SBSA_XHCI_BASE_ADDR		0x60110000
+#define SBSA_XHCI_LENGTH		0x00010000
+
+/* PIO */
+#define SBSA_PIO_BASE_ADDR		0x7fff0000
+#define SBSA_PIO_LENGTH			0x00010000
+
+/* PCIE_MMIO */
+#define SBSA_PCIE_MMIO_BASE_ADDR	0x80000000
+#define SBSA_PCIE_MMIO_LENGTH		0x70000000
+#define SBSA_PCIE_MMIO_END		0xefffffff
+
+/* PCIE_ECAM */
+#define SBSA_PCIE_ECAM_BASE_ADDR	0xf0000000
+#define SBSA_PCIE_ECAM_LENGTH		0x10000000
+#define SBSA_PCIE_ECAM_END		0xffffffff
+
+/* PCIE_MMIO_HIGH */
+#ifdef __ACPI__
+#define SBSA_PCIE_MMIO_HIGH_BASE_ADDR	0x100000000
+#define SBSA_PCIE_MMIO_HIGH_LENGTH	0xFF00000000
+#define SBSA_PCIE_MMIO_HIGH_END		0xFFFFFFFFFF
+#else
+#define SBSA_PCIE_MMIO_HIGH_BASE_ADDR	0x100000000ULL
+#define SBSA_PCIE_MMIO_HIGH_LENGTH	0xFF00000000ULL
+#define SBSA_PCIE_MMIO_HIGH_END		0xFFFFFFFFFFULL
+#endif
+
+/* MEM */
+#ifdef __ACPI__
+#define SBSA_MEM_BASE_ADDR		0x10000000000
+#else
+#define SBSA_MEM_BASE_ADDR		0x10000000000ULL
+#endif
+
+#define CFG_SYS_SDRAM_BASE		SBSA_MEM_BASE_ADDR
+#define CFG_SYS_UBOOT_BASE		CONFIG_TEXT_BASE
+
+#define CFG_SYS_INIT_RAM_ADDR		CFG_SYS_SDRAM_BASE
+#define CFG_SYS_INIT_RAM_SIZE		0x10000000
+
+/* PL011 Serial Configuration */
+#define CFG_SYS_SERIAL0			SBSA_UART_BASE_ADDR
+#define CFG_PL011_CLOCK			24000000
+
+/* For timer, QEMU emulates an ARMv7/ARMv8 architected timer */
+
+#endif /* __CONFIG_H */
-- 
2.46.0

