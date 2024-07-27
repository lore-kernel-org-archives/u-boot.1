Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305A8C3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94094887B9;
	Sat, 27 Jul 2024 09:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="OZX+E4bk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA2588756; Sat, 27 Jul 2024 09:20:37 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8696C88700
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so423701266b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064835; x=1722669635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=efT8skWO5NIs/VnokTr3QMPx5/k2IviYeMfMGCxNzeg=;
 b=OZX+E4bkcxIxmFRcs4BVEyiyrkyxrGiAad65xswd9Q9KZwIVpLkJcqFCdLanlLXGca
 QwFC5CTpDWg/5w3s5PbPo20aEz8T2X/wQGA3QNVLEXluOf6w1eokaM2RFXlD3MW9ukFy
 NkXf2i2etwhwTL//WdbZIRoQJCN3e3BmC65Bd4Lo6LhTzJMDbs9Oesrz71oVQLMVNC8G
 VNCm9w+c+4cR07XxQxpYjzUur9BYyzCRS8rB31G4tvCDpfwjw8otYc/d8LD0qCcL2nVZ
 BhTLRAXzVIJc4GZN5PlbDY6tPmubrLyzAoSxkMggMGwckiOF5hmADyJsQH5EbX+KjY+y
 u2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064835; x=1722669635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efT8skWO5NIs/VnokTr3QMPx5/k2IviYeMfMGCxNzeg=;
 b=V79itBAJ6v105qgc8AirAvUExEa0pDQ0ljFZKTEt4jwVmpf0g9Z3ukbKNwlKSrJn3x
 NfaVCVhc6GpPOedSwti6xI/KLXHgYatjY9IqUatCF1RgD+gDcgUc6RAw19QIA7OfREJc
 s7aGPow+ejRbDNlA5VLPO4MEHag99Osd+ektRAEMAro/V2JlwoBsmvOBBhQm/uUUtKWn
 8aU+4E4IhvEBF3xj/wlbpIHjMS78mU+p52HfwsQ7I4qDoZkZfFvulwtqEIWLW6BRE0cq
 LaerhnlHgk3YWL2xOSJo7c1WdautCna0OwEHZ9odGenkq6YOXpMRHRZIs4VgLO6VAMAp
 6+8g==
X-Gm-Message-State: AOJu0Yz2Z+xHFH+LbENr06b1MB5TsXExEAEfPpd/xIoxnRfPcQ5EOhoG
 Ny0gpMzgTgRxAqIT+VKxu2HPTJ0yzBv/U1gpOsEs87bUgIOIa7RlC/7hX8RRu25fC6QQ4hl8P6M
 ocm8=
X-Google-Smtp-Source: AGHT+IGlrT4NzYju3xmXvWOGmyRupDhhztQaqYmAx9N4VJ4rJqaPTNw3rdUviQM48EkBJ/hoqPvMKQ==
X-Received: by 2002:a17:907:7b8b:b0:a7a:afe8:1013 with SMTP id
 a640c23a62f3a-a7d3f81db08mr179684066b.1.1722064835030; 
 Sat, 27 Jul 2024 00:20:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: mbrugger@suse.com, pbrobinson@gmail.com, trini@konsulko.com,
 bmeng.cn@gmail.com, Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 14/17] arm: cpu: Add ACPI parking protocol support
Date: Sat, 27 Jul 2024 09:17:15 +0200
Message-ID: <20240727071742.1735703-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

On Arm platforms that use ACPI they cannot rely on the "spin-table"
CPU bringup usually defined in the FDT. Thus implement the
'ACPI Multi-processor Startup for ARM Platforms', also referred to as
'ACPI parking protocol'.

The ACPI parking protocol works similar to the spin-table mechanism, but
the specification also covers lots of shortcomings of the spin-table
implementations.

Every CPU defined in the ACPI MADT table has it's own 4K page where the
spinloop code and the OS mailbox resides. When selected the U-Boot board
code must make sure that the secondary CPUs enter u-boot after relocation
as well, so that they can enter the spinloop code residing in the ACPI
parking protocol pages.

The OS will then write to the mailbox and generate an IPI to release the
CPUs from the spinloop code.

For now it's only implemented on ARMv8, but can easily be extended to
other platforms.

TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv8/Makefile              |   1 +
 arch/arm/cpu/armv8/parking_protocol_v8.S | 102 +++++++++++++++++++++++
 arch/arm/cpu/armv8/start.S               |   4 +
 arch/arm/include/asm/acpi_table.h        |  52 ++++++++++++
 arch/arm/lib/acpi_table.c                |  87 +++++++++++++++++++
 include/acpi/acpi_table.h                |  10 +++
 lib/Kconfig                              |  15 ++++
 lib/acpi/acpi_table.c                    |   3 +
 8 files changed, 274 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/parking_protocol_v8.S

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570db..9bb07bdf12 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ARM_SMCCC)		+= smccc-call.o
 
 ifndef CONFIG_SPL_BUILD
 obj-$(CONFIG_ARMV8_SPIN_TABLE) += spin_table.o spin_table_v8.o
+obj-$(CONFIG_ACPI_PARKING_PROTOCOL) += parking_protocol_v8.o
 else
 obj-$(CONFIG_ARCH_SUNXI) += fel_utils.o
 endif
diff --git a/arch/arm/cpu/armv8/parking_protocol_v8.S b/arch/arm/cpu/armv8/parking_protocol_v8.S
new file mode 100644
index 0000000000..b7f6abbd85
--- /dev/null
+++ b/arch/arm/cpu/armv8/parking_protocol_v8.S
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 9elements GmbH
+ *   Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/acpi_table.h>
+
+__secondary_cpuif_id:
+	.quad 0
+
+__secondary_parking_protocol_tables:
+	.quad 0
+
+__secondary_parking_protocol_ncpus:
+	.quad 0
+
+.global acpi_parking_protocol_code_size
+acpi_parking_protocol_code_size:
+	.word __secondary_parking_protocol_code_end - __secondary_parking_protocol_code_start
+
+.global acpi_parking_protocol_install
+ENTRY(acpi_parking_protocol_install)
+	ldr	x2, =__secondary_parking_protocol_ncpus
+	str	x1, [x2]
+	ldr	x2, =__secondary_parking_protocol_tables
+	str	x0, [x2]
+	dsb	ishst
+	sev
+	ret
+ENDPROC(acpi_parking_protocol_install)
+
+.global acpi_parking_protocol_secondary_jump
+ENTRY(acpi_parking_protocol_secondary_jump)
+0:
+	/* Store a unique cpuif id in x0 */
+	ldr	x2, =__secondary_cpuif_id
+	ldaxr	w0, [x2]
+	add	w0, w0, #1  // =1
+	stlxr	w1, w0, [x2]
+	cbnz	w1, 0b
+
+0:	/* Check if parking protocol table is ready */
+	ldr	x1, =__secondary_parking_protocol_tables
+	ldr	x2, [x1]
+	cbnz	x2, 0f
+	wfe
+	b	0b
+
+0:	/* Sanity check cpuif id */
+	ldr	x1, =__secondary_parking_protocol_ncpus
+	ldr	x3, [x1]
+	cmp	w0, w3
+	b.lt	0f
+
+hlt:	wfi
+	b	hlt	/* Should never happen. */
+
+	/* Find spinning code in ACPI parking protocol table */
+0:	mov	x1, #ACPI_PP_PAGE_SIZE
+	mul	x3, x0, x1
+	add	x2, x2, x3
+	mov	x0, x2		/* Backup ACPI page ptr for later use */
+
+	mov	x1, #ACPI_PP_CPU_CODE_OFFSET
+	add	x2, x2, x1
+
+	/* Jump to spin code in own parking protocol page */
+	br	x2
+ENDPROC(acpi_parking_protocol_secondary_jump)
+
+.align 8
+__secondary_parking_protocol_code_start:
+.global acpi_parking_protocol_code_start
+ENTRY(acpi_parking_protocol_code_start)
+	/* x0 points to the 4K aligned parking protocol page */
+
+	/* Prepare defines for spinning code */
+	mov	w3, #ACPI_PP_CPU_ID_INVALID
+	mov	x2, #ACPI_PP_JMP_ADR_INVALID
+
+0:	wfe
+	ldr	w1, [x0, #ACPI_PP_CPU_ID_OFFSET]
+
+	/* Check CPU ID is not invalid */
+	cmp	w1, w3
+	b.eq	0b
+
+	/* Check jump address not invalid */
+	ldr	x1, [x0, #ACPI_PP_CPU_JMP_ADDR_OFFSET]
+	cmp	x1, x2
+	b.eq	0b
+
+	/* Clear jump address before jump */
+	str	x2, [x0, #ACPI_PP_CPU_JMP_ADDR_OFFSET]
+	dsb	sy
+
+	br	x1
+ENDPROC(acpi_parking_protocol_code_start)
+	/* Secondary Boot Code ends here */
+__secondary_parking_protocol_code_end:
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..32a295c832 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,10 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	b	acpi_parking_protocol_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index 8a25e93847..3c6736239d 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -4,6 +4,7 @@
 #define __ASM_ACPI_TABLE_H__
 
 #ifndef __ACPI__
+#ifndef __ASSEMBLY__
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 			  uint perf_gsiv, ulong phys_base, ulong gicv,
@@ -13,6 +14,57 @@ void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
 			  ulong phys_base, uint gic_version);
 
+/* Multi-processor Startup for ARM Platforms */
+struct acpi_parking_protocol_page {
+	u32 cpu_id;
+	u32 reserved;
+	u64 jumping_address;
+	u8 os_reserved[2032];
+	u8 cpu_spinning_code[2048];
+} __packed;
+
+/* Architecture specific functions */
+/**
+ * acpi_parking_protocol_code_size - Spinloop code size *
+ */
+extern u32 acpi_parking_protocol_code_size;
+
+/**
+ * parking_protocol_code_start() - Spinloop code
+ *
+ * Architectural spinloop code to be installed in each parking protocol
+ * page. The spinloop code must be less than 2048 bytes.
+ *
+ * The spinloop code will be entered after calling
+ * acpi_parking_protocol_install().
+ *
+ */
+void acpi_parking_protocol_code_start(void);
+
+/**
+ * acpi_parking_protocol_install() - Installs the parking protocol.
+ *
+ * Installs the reserved memory containing the spinloop code and the
+ * OS mailbox as required by the ACPI Multi-processor Startup for
+ * ARM Platforms specification.
+ *
+ * The secondary CPUs will wait for this function to be called in order
+ * to enter the spinloop code residing in the tables.
+ *
+ * @tables: ACPI parking protocol tables.
+ * @num_cpus: Number of allocated pages.
+ */
+void acpi_parking_protocol_install(uintptr_t tables, size_t num_cpus);
+
+#endif /* !__ASSEMBLY__ */
 #endif /* !__ACPI__ */
 
+#define ACPI_PP_CPU_ID_INVALID		0xffffffff
+#define ACPI_PP_JMP_ADR_INVALID		0
+#define ACPI_PP_PAGE_SIZE		4096
+#define ACPI_PP_CPU_ID_OFFSET		0
+#define ACPI_PP_CPU_JMP_ADDR_OFFSET	8
+#define ACPI_PP_CPU_CODE_OFFSET		2048
+#define ACPI_PP_VERSION			1
+
 #endif /* __ASM_ACPI_TABLE_H__ */
diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
index ea3a6343c9..2fa25ec50e 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -10,7 +10,11 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <cpu_func.h>
+#include <efi_loader.h>
+#include <malloc.h>
 #include <string.h>
+#include <tables_csum.h>
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 			  uint perf_gsiv, ulong phys_base, ulong gicv,
@@ -42,3 +46,86 @@ void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
 	gicd->phys_base = phys_base;
 	gicd->gic_version = gic_version;
 }
+
+void acpi_write_parking_protocol(struct acpi_madt *madt)
+{
+	struct acpi_parking_protocol_page *page;
+	struct acpi_madt_gicc *gicc;
+	void *reloc_addr;
+	u64 start;
+	int ncpus = 0;
+
+	/* According to the "Multi-processor Startup for ARM Platforms":
+	 * - Every CPU as specified by MADT GICC has it's own 4K page
+	 * - Every page is divided into two sections: OS and FW reserved
+	 * - Memory occupied by "Parking Protocol" must be marked 'Reserved'
+	 * - Spinloop code should reside in FW reserved 2048 bytes
+	 * - Spinloop code will check the mailbox in OS reserved area
+	 */
+
+	if (acpi_parking_protocol_code_size > sizeof(page->cpu_spinning_code)) {
+		log_err("Spinning code too big to fit: %d\n",
+			acpi_parking_protocol_code_size);
+	}
+
+	/* Count all cores including BSP */
+	for (int i = sizeof(struct acpi_madt); i < madt->header.length; ) {
+		gicc = (struct acpi_madt_gicc *)((void *)madt + i);
+		if (gicc->type != ACPI_APIC_GICC) {
+			i += gicc->length;
+			continue;
+		}
+		ncpus++;
+		i += gicc->length;
+	}
+	debug("Found %d GICCs in MADT\n", ncpus);
+
+	/* Allocate pages linearly due to assembly code requirements */
+	page = memalign(ACPI_PP_PAGE_SIZE, ACPI_PP_PAGE_SIZE * ncpus);
+	start = (u64)(uintptr_t)page;
+
+#if CONFIG_IS_ENABLED(EFI_LOADER)
+	int ret = efi_add_memory_map(start, ncpus * ACPI_PP_PAGE_SIZE, EFI_RESERVED_MEMORY_TYPE);
+
+	if (ret != EFI_SUCCESS)
+		log_err("Reserved memory mapping failed addr %llx size %x\n",
+			start, ncpus * ACPI_PP_PAGE_SIZE);
+#endif
+
+	/* Prepare the parking protocol pages */
+	for (int i = sizeof(struct acpi_madt); i < madt->header.length; ) {
+		gicc = (struct acpi_madt_gicc *)((void *)madt + i);
+		if (gicc->type != ACPI_APIC_GICC) {
+			i += gicc->length;
+			continue;
+		}
+
+		/* Update GICC */
+		gicc->parking_proto = ACPI_PP_VERSION;
+		gicc->parked_addr = (uint64_t)(uintptr_t)page;
+
+		/* Prepare parking protocol page */
+		memset(page, 0, sizeof(struct acpi_parking_protocol_page));
+		page->cpu_id = ACPI_PP_CPU_ID_INVALID;
+		page->jumping_address = ACPI_PP_JMP_ADR_INVALID;
+
+		/* Relocate spinning code */
+		reloc_addr = &page->cpu_spinning_code[0];
+
+		debug("Relocating spin table from %p to %p (size %x)\n",
+		      &acpi_parking_protocol_code_start, reloc_addr,
+		      acpi_parking_protocol_code_size);
+		memcpy(reloc_addr, &acpi_parking_protocol_code_start,
+		       acpi_parking_protocol_code_size);
+
+		if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+			flush_dcache_range((unsigned long)page,
+					   (unsigned long)page +
+					   sizeof(struct acpi_parking_protocol_page));
+		page++;
+		i += gicc->length;
+	}
+
+	/* Point secondary CPUs to new spin loop code */
+	acpi_parking_protocol_install(start, ncpus);
+}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 26c5e9f21a..994bfd7f8d 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -951,6 +951,16 @@ void acpi_fill_fadt(struct acpi_fadt *fadt);
  */
 void *acpi_fill_madt(struct acpi_madt *madt, void *current);
 
+/**
+ * acpi_write_parking_protocol() - Installs the ACPI parking protocol.
+ *
+ * Sets up the ACPI parking protocol and installs the spinning code for
+ * secondary CPUs.
+ *
+ * @madt: The MADT to update
+ */
+void acpi_write_parking_protocol(struct acpi_madt *madt);
+
 /**
  * acpi_write_dbg2_pci_uart() - Write out a DBG2 table
  *
diff --git a/lib/Kconfig b/lib/Kconfig
index 2059219a12..43e4fa3253 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -314,6 +314,21 @@ config GENERATE_ACPI_TABLE
 	  by the operating system. It defines platform-independent interfaces
 	  for configuration and power management monitoring.
 
+config ACPI_PARKING_PROTOCOL
+	bool "Support ACPI parking protocol method"
+	depends on GENERATE_ACPI_TABLE
+	depends on ARMV8_MULTIENTRY
+	default y if !SEC_FIRMWARE_ARMV8_PSCI && !ARMV8_PSCI
+	help
+	  Say Y here to support "ACPI parking protocol" enable method
+	  for booting Linux.
+
+	  To use this feature, you must do:
+	    - Bring secondary CPUs into U-Boot proper in a board specific
+	      manner.  This must be done *after* relocation.  Otherwise, the
+	      secondary CPUs will spin in unprotected memory area because the
+	      master CPU protects the relocated spin code.
+
 config SPL_TINY_MEMSET
 	bool "Use a very small memset() in SPL"
 	depends on SPL
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index eb3c83ab02..56eb4a10d0 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -271,6 +271,9 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	/* (Re)calculate length and checksum */
 	header->length = (uintptr_t)current - (uintptr_t)madt;
 
+	if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
+		acpi_write_parking_protocol(madt);
+
 	header->checksum = table_compute_checksum((void *)madt, header->length);
 	acpi_add_table(ctx, madt);
 	acpi_inc(ctx, madt->header.length);
-- 
2.45.2

