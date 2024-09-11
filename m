Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20124EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7304891EF;
	Wed, 11 Sep 2024 08:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="NndM9ZLl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915FF891EC; Wed, 11 Sep 2024 08:26:13 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C791891D0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso255527766b.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035971; x=1726640771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PliyWNIKWbUJ9NcN9IM/7pobBLlktjaXtINXr/9IvAE=;
 b=NndM9ZLlC3ehzhw0XcenA1l3T8mmexKFjD35tP2ZlkBKaO2dI+cqr1II1OS+HcRGda
 V9zghqew0ZCie1mEzDDJHujhTVUuGCiBme01Xb5spBe1iC5tZOKs/fAe2e7zDJcROnLP
 qbj2+uIVUBTXRMmYbHFOGckdLHAlU6sbe+1yUsxQkmK91NxCkJSU3q4TbrROvcKp9bLU
 xlr5rA27fBj1aQBFUT8Ik6drDla3cIfLggyyNWexSYsCEnGaFg83peGv8KZvDaoRGJTg
 CnvSoZCbvx8Yh7VlqhH+4DnLc4ra5o1DyHBMf65dpHXerhAjdB9QGRRKjZM/VzyFIXFJ
 Bo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035971; x=1726640771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PliyWNIKWbUJ9NcN9IM/7pobBLlktjaXtINXr/9IvAE=;
 b=fWpNEO8qkqWkjrs1jRBFPkSPJ1rTyqmv8OHWUOJPpT0/ZvxkWbCOVNFrWskL3P/aQ4
 RKBFHEqM+b1pxolbW0qEMjCPlNrx9FC13AKEqCJHkgOOgFJETIxhpoHbKIOLlsbMhD3x
 OQ4Of1xXZX4Y7oAfpUk6JfGyswkVv0AkUq6lbWQLBwyujklg5zZCrjL1PLUoqk85nQD2
 TmPbgQesNsTtPZOEdyXht7+NUp7F7yv+58mdJCmOE3mPYnC+3hkZneVlqjNlHGI3BNx1
 0cxcOt1xDysJlNTjnOihndz+NYypOMoSZyx6jrzJLqY9YfIZjmfyXns21MNHYO9vmJyl
 NGlQ==
X-Gm-Message-State: AOJu0Yz7jvobhTKxwl7EaL2Gxn2/q/4va6JNDqG8UHDfy/3cYHTQX9xR
 CnAOEV+B5DS2H+ZT9gM0ta/p6wdW6g0RqJ0eSprCettFd2T/2nm93jN0y1PlnA5mZIwO1FDSm9v
 I
X-Google-Smtp-Source: AGHT+IEBJlFOT8YQnM1hIsWQWWUb6+C4z4+EQxfctB3beMSQ44z6gND76iuSywD4DLRDgXZUA/f87A==
X-Received: by 2002:a17:907:e21b:b0:a8a:8de6:a605 with SMTP id
 a640c23a62f3a-a9004833832mr204334066b.17.1726035970593; 
 Tue, 10 Sep 2024 23:26:10 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:26:10 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 27/30] arm: cpu: Add ACPI parking protocol support
Date: Wed, 11 Sep 2024 08:24:17 +0200
Message-ID: <20240911062511.494855-28-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
Changelog v2:
- Use shorter function names
- Drop the use of atomics, they do not work on real hardware
- Rewrite code and verify on real hardware that CPUs are spinning
  inside their parking protocol spin-loop code

---
 arch/arm/cpu/armv8/Makefile       |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S | 107 ++++++++++++++++++++++++++
 arch/arm/cpu/armv8/start.S        |   4 +
 arch/arm/include/asm/acpi_table.h |  45 +++++++++++
 arch/arm/lib/acpi_table.c         | 123 ++++++++++++++++++++++++++++++
 include/acpi/acpi_table.h         |  10 +++
 include/bloblist.h                |   1 +
 lib/Kconfig                       |  15 ++++
 lib/acpi/acpi_table.c             |   4 +
 9 files changed, 310 insertions(+)
 create mode 100644 arch/arm/cpu/armv8/acpi_park_v8.S

diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
index bba4f570db..4f4368ff8c 100644
--- a/arch/arm/cpu/armv8/Makefile
+++ b/arch/arm/cpu/armv8/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ARM_SMCCC)		+= smccc-call.o
 
 ifndef CONFIG_SPL_BUILD
 obj-$(CONFIG_ARMV8_SPIN_TABLE) += spin_table.o spin_table_v8.o
+obj-$(CONFIG_ACPI_PARKING_PROTOCOL) += acpi_park_v8.o
 else
 obj-$(CONFIG_ARCH_SUNXI) += fel_utils.o
 endif
diff --git a/arch/arm/cpu/armv8/acpi_park_v8.S b/arch/arm/cpu/armv8/acpi_park_v8.S
new file mode 100644
index 0000000000..4dc7ff216c
--- /dev/null
+++ b/arch/arm/cpu/armv8/acpi_park_v8.S
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 9elements GmbH
+ *   Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/acpi_table.h>
+
+/* Filled by C code */
+.global acpi_pp_tables
+acpi_pp_tables:
+	.quad 0
+
+.global acpi_pp_etables
+acpi_pp_etables:
+	.quad 0
+
+/* Read by C code */
+.global acpi_pp_code_size
+acpi_pp_code_size:
+	.word __secondary_pp_code_end - __secondary_pp_code_start
+
+.global acpi_pp_secondary_jump
+ENTRY(acpi_pp_secondary_jump)
+0:
+	/*
+	 * Cannot use atomic operations since the MMU and D-cache
+	 * might be off. Use the MPIDR instead to find the spintable.
+	 */
+
+	/* Check if parking protocol table is ready */
+	ldr	x1, =acpi_pp_tables
+	ldr	x0, [x1]
+	cbnz	x0, 0f
+	wfe
+	b	0b
+
+0:	/* Get end of page tables in x3 */
+	ldr	x1, =acpi_pp_etables
+	ldr	x3, [x1]
+
+	/* Get own CPU ID in w2 */
+	mrs	x2, mpidr_el1
+	lsr	x9, x2, #32
+	bfi	x2, x9, #24, #8	/* w2 is aff3:aff2:aff1:aff0 */
+
+0:	/* Loop over all parking protocol pages */
+	cmp	x0, x3
+	b.ge	hlt
+
+	/* Fetch CPU_ID from current page */
+	ldr	x1, [x0, #ACPI_PP_CPU_ID_OFFSET]
+	lsr	x9, x1, #32
+	bfi	x1, x9, #24, #8	/* w1 is aff3:aff2:aff1:aff0 */
+
+	/* Compare CPU_IDs */
+	cmp	w1, w2
+	b.eq	0f
+
+	add	x0, x0, #ACPI_PP_PAGE_SIZE
+	b	0b
+
+hlt:	wfi
+	b	hlt	/* Should never happen. */
+
+0:	/* x0 points to the 4K aligned parking protocol page */
+	add	x2, x0, #ACPI_PP_CPU_CODE_OFFSET
+
+	/* Jump to spin code in own parking protocol page */
+	br	x2
+ENDPROC(acpi_pp_secondary_jump)
+
+.align 8
+__secondary_pp_code_start:
+.global acpi_pp_code_start
+ENTRY(acpi_pp_code_start)
+	/* x0 points to the 4K aligned parking protocol page */
+
+	/* Prepare defines for spinning code */
+	mov	w3, #ACPI_PP_CPU_ID_INVALID
+	mov	x2, #ACPI_PP_JMP_ADR_INVALID
+
+	/* Mark parking protocol page as ready */
+	str	w3, [x0, #ACPI_PP_CPU_ID_OFFSET]
+	dsb	sy
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
+ENDPROC(acpi_pp_code_start)
+	/* Secondary Boot Code ends here */
+__secondary_pp_code_end:
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 7461280261..f56870768e 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -178,6 +178,10 @@ pie_fixup_done:
 	branch_if_master x0, master_cpu
 	b	spin_table_secondary_jump
 	/* never return */
+#elif defined(CONFIG_ACPI_PARKING_PROTOCOL) && !defined(CONFIG_SPL_BUILD)
+	branch_if_master x0, master_cpu
+	b	acpi_pp_secondary_jump
+	/* never return */
 #elif defined(CONFIG_ARMV8_MULTIENTRY)
 	branch_if_master x0, master_cpu
 
diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index c65eabe837..c9ea7e04b4 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -4,6 +4,7 @@
 #define __ASM_ACPI_TABLE_H__
 
 #ifndef __ACPI__
+#ifndef __ASSEMBLY__
 
 #include <acpi/acpi_table.h>
 
@@ -109,7 +110,51 @@ int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
 			const u32 sets, const u8 assoc, const u8 attributes,
 			const u16 line_size);
 
+/* Multi-processor Startup for ARM Platforms */
+struct acpi_parking_protocol_page {
+	u64 cpu_id;
+	u64 jumping_address;
+	u8 os_reserved[2032];
+	u8 cpu_spinning_code[2048];
+} __packed;
+
+/* Architecture specific functions */
+/**
+ * acpi_pp_code_size - Spinloop code size *
+ */
+extern u16 acpi_pp_code_size;
+
+/**
+ * acpi_pp_tables - Start of ACPI PP tables.
+ */
+extern u64 acpi_pp_tables;
+
+/**
+ * acpi_pp_etables - End of ACPI PP tables.
+ */
+extern u64 acpi_pp_etables;
+
+/**
+ * acpi_pp_code_start() - Spinloop code
+ *
+ * Architectural spinloop code to be installed in each parking protocol
+ * page. The spinloop code must be less than 2048 bytes.
+ *
+ * The spinloop code will be entered after calling
+ * acpi_parking_protocol_install().
+ *
+ */
+void acpi_pp_code_start(void);
+
 #endif /* !__ASSEMBLY__ */
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
index 75a0bc5b6e..d648d85049 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -10,8 +10,16 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <asm-generic/io.h>
 #include <dm/acpi.h>
+#include <bloblist.h>
+#include <cpu_func.h>
+#include <efi_loader.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+#include <malloc.h>
 #include <string.h>
+#include <tables_csum.h>
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 			  uint perf_gsiv, ulong phys_base, ulong gicv,
@@ -120,3 +128,118 @@ __weak void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
 	acpi_fill_madt_subtbl(ctx);
 	return ctx->current;
 }
+
+/**
+ * acpi_write_pp_setup_one_page() - Fill out one page used by the PP
+ *
+ * Fill out the struct acpi_parking_protocol_page to contain the spin-loop
+ * code and the mailbox area. After this function the page is ready for
+ * the secondary core's to enter the spin-loop code.
+ *
+ * @page:                 Pointer to current parking protocol page
+ * @gicc:                 Pointer to corresponding GICC sub-table
+ */
+static void acpi_write_pp_setup_one_page(struct acpi_parking_protocol_page *page,
+					 struct acpi_madt_gicc *gicc)
+{
+	void *reloc_addr;
+
+	/* Update GICC. Mark parking protocol as available. */
+	gicc->parking_proto = ACPI_PP_VERSION;
+	gicc->parked_addr = virt_to_phys(page);
+
+	/* Prepare parking protocol page */
+	memset(page, '\0', sizeof(struct acpi_parking_protocol_page));
+
+	/* Init mailbox. Set MPIDR so core's will find their page. */
+	page->cpu_id = gicc->mpidr;
+	page->jumping_address = ACPI_PP_JMP_ADR_INVALID;
+
+	/* Relocate spinning code */
+	reloc_addr = &page->cpu_spinning_code[0];
+
+	debug("Relocating spin table from %p to %p (size %x)\n",
+	      &acpi_pp_code_start, reloc_addr, acpi_pp_code_size);
+	memcpy(reloc_addr, &acpi_pp_code_start, acpi_pp_code_size);
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		flush_dcache_range((unsigned long)page,
+				   (unsigned long)(page + 1));
+}
+
+void acpi_write_parking_protocol(struct acpi_madt *madt)
+{
+	struct acpi_parking_protocol_page *start, *page;
+	struct acpi_madt_gicc *gicc;
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
+	if (acpi_pp_code_size > sizeof(page->cpu_spinning_code)) {
+		log_err("Spinning code too big to fit: %d\n",
+			acpi_pp_code_size);
+		return;
+	}
+
+	/* Count all MADT GICCs including BSP */
+	for (int i = sizeof(struct acpi_madt); i < madt->header.length;
+	     i += gicc->length) {
+		gicc = (struct acpi_madt_gicc *)((void *)madt + i);
+		if (gicc->type != ACPI_APIC_GICC)
+			continue;
+		ncpus++;
+	}
+	debug("Found %d GICCs in MADT\n", ncpus);
+
+	/* Allocate pages linearly due to assembly code requirements */
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		start = bloblist_add(BLOBLISTT_ACPI_PP, ACPI_PP_PAGE_SIZE * ncpus,
+				     ilog2(SZ_4K));
+	} else {
+		start = memalign(ACPI_PP_PAGE_SIZE, ACPI_PP_PAGE_SIZE * ncpus);
+	}
+	if (!start) {
+		log_err("Failed to allocate memory for ACPI parking protocol pages\n");
+		return;
+	}
+	log_debug("Allocated parking protocol at %p\n", start);
+	page = start;
+
+	if (IS_ENABLED(CONFIG_EFI_LOADER)) {
+		/* Default mapping is 'BOOT CODE'. Mark as reserved instead. */
+		int ret = efi_add_memory_map((u64)(uintptr_t)start,
+					     ncpus * ACPI_PP_PAGE_SIZE,
+					     EFI_RESERVED_MEMORY_TYPE);
+
+		if (ret != EFI_SUCCESS)
+			log_err("Reserved memory mapping failed addr %p size %x\n",
+				start, ncpus * ACPI_PP_PAGE_SIZE);
+	}
+
+	/* Prepare the parking protocol pages */
+	for (int i = sizeof(struct acpi_madt); i < madt->header.length;
+	     i += gicc->length) {
+		gicc = (struct acpi_madt_gicc *)((void *)madt + i);
+		if (gicc->type != ACPI_APIC_GICC)
+			continue;
+
+		acpi_write_pp_setup_one_page(page++, gicc);
+	}
+
+	acpi_pp_etables = virt_to_phys(start) +
+			  ACPI_PP_PAGE_SIZE * ncpus;
+	acpi_pp_tables = virt_to_phys(start);
+
+	/* Make sure other cores see written value in memory */
+	flush_dcache_all();
+
+	/* Send an event to wake up the secondary CPU. */
+	asm("dsb	ishst\n"
+	    "sev");
+}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 3dd24b520d..abf69f16ba 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -1237,6 +1237,16 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
  */
 void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx);
 
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
  * acpi_get_rsdp_addr() - get ACPI RSDP table address
  *
diff --git a/include/bloblist.h b/include/bloblist.h
index b0706b5637..ff32d3fecf 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -110,6 +110,7 @@ enum bloblist_tag_t {
 	BLOBLISTT_ACPI_TABLES = 4,
 	BLOBLISTT_TPM_EVLOG = 5,
 	BLOBLISTT_TPM_CRB_BASE = 6,
+	BLOBLISTT_ACPI_PP = 7,
 
 	/* Standard area to allocate blobs used across firmware components */
 	BLOBLISTT_AREA_FIRMWARE = 0x10,
diff --git a/lib/Kconfig b/lib/Kconfig
index ea444354eb..a93b494288 100644
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
index 8aab41212a..7b419144dc 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -290,6 +290,10 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	/* (Re)calculate length and checksum */
 	header->length = (uintptr_t)current - (uintptr_t)madt;
+
+	if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
+		acpi_write_parking_protocol(madt);
+
 	header->checksum = table_compute_checksum((void *)madt, header->length);
 	acpi_add_table(ctx, madt);
 	ctx->current = (void *)madt + madt->header.length;
-- 
2.46.0

