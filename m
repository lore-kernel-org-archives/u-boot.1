Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5120CDD540
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 15:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A01988FB8;
	Wed, 18 Sep 2024 17:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="S37jsjQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E1288FAD; Wed, 18 Sep 2024 17:23:02 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005B688DA3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d43657255so825423566b.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 08:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726672979; x=1727277779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGDh9xAX2ZcL0g+2rGROaPBkAzhtNo5Kbu8H5Jb0aOs=;
 b=S37jsjQ4bXnWE15wNURZ0za5/tilXUNAdRPXe8iH7/hgoM/I3oOigB+340zGOgtUOm
 v+Ssh2TJx/VHAjk3ePxp8ooPQWhmIUX8nkmn+bng9T3I6z8nhZ1qY63x7e5Bw/Xrqx9K
 VIZ1OL6rA448qAfFqtHuqcNnxEKTd0nTEMWjSEY5aTBsH/7WUCGNK2wKBmYme9L00QRW
 F5AwsS4FS5ZSgJWZh+84CNM+F/dr2yqCyfy7ckzHLTqEMtUqdtCJa0ELbS0Pn5wE5IA6
 f9nL546nce3DTHLBF5mT8zWJsyeGM0X64xfSwBVBXIZflICr+nJwQoUVCok6hxYfZ8gw
 iq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726672979; x=1727277779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGDh9xAX2ZcL0g+2rGROaPBkAzhtNo5Kbu8H5Jb0aOs=;
 b=ODgleGJcLKejo2ij6l7zT04BdzlokeE//kV2oqMNZp2t9QHTYZC8Cutnm6f87Qym92
 1N9f0yMyanLESF4Tej1uDy5iIAIz7o7T0i0cAu/G7F1SHhN5U6Wq5AKzFIfzRQVW9he6
 lQ6ClEYFvXKZ7qi+p6N3tHgO5SSddWw5+x274v7uaOnj9Pr5EOF4WUNtt29+CblFE13w
 RALZQHZ9zCax6Pjepn93GWJOY3fkkiH35gR+Uw/9p0eInIhLOpXNCO6+20XGmPZknU14
 AC60K7VsDQpD5Dakp2TBjAplcq4zu9PcivbjSwuR/WqLEgluwhS9tZzE5YYL+76X51Os
 j/xw==
X-Gm-Message-State: AOJu0Yx/xMfenayHOEoCx7UvA6+e5SZbDpirSiefpg3WcTisHWWvQcSM
 oUt1oPUcMtSHDhrfIRiE/K3J/FE81K2zmn4X560bwCs3LZU02rkoO3cyiEZ95LgxcoFP82uNFi6
 O
X-Google-Smtp-Source: AGHT+IHMj+z1f/l8CDDOF2S2j3jdizJEs3HJOtE8fjwjIPHLE2p+kGApf27NfAqUbBG88q+cDrk7iQ==
X-Received: by 2002:a17:907:72c9:b0:a77:e2e3:354d with SMTP id
 a640c23a62f3a-a9047ca8193mr1764256966b.23.1726672979304; 
 Wed, 18 Sep 2024 08:22:59 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 08:22:58 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 30/35] arm: cpu: Add ACPI parking protocol support
Date: Wed, 18 Sep 2024 17:20:34 +0200
Message-ID: <20240918152136.3395170-31-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
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
other platforms, like ARMv7.

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
Changelog v4:
- Shorten names
- Fix coding style
- Drop extern from the headers
---
 arch/arm/cpu/armv8/Makefile       |   1 +
 arch/arm/cpu/armv8/acpi_park_v8.S | 113 ++++++++++++++++++++++
 arch/arm/include/asm/acpi_table.h |  32 +++++++
 arch/arm/lib/acpi_table.c         | 149 ++++++++++++++++++++++++++++++
 include/acpi/acpi_table.h         |  10 ++
 include/bloblist.h                |   1 +
 lib/Kconfig                       |  16 ++++
 lib/acpi/acpi_table.c             |   4 +
 8 files changed, 326 insertions(+)
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
index 0000000000..e2d2644dd4
--- /dev/null
+++ b/arch/arm/cpu/armv8/acpi_park_v8.S
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 9elements GmbH
+ *   Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ *
+ * This file provides ARMv8 specific code for the generic part of the
+ * ACPI parking protocol implementation. It contains the spinning code
+ * that will be installed into the parking protocol and it points the
+ * secondary CPUs to their own parking protocol page once it has been
+ * set up by the generic part.
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
+0:	/* x0 points to the 4K-aligned, parking protocol page */
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
+	/* x0 points to the 4K-aligned, parking protocol page */
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
+	/* Check CPU ID is valid */
+	cmp	w1, w3
+	b.eq	0b
+
+	/* Check jump address valid */
+	ldr	x1, [x0, #ACPI_PP_CPU_JMP_OFFSET]
+	cmp	x1, x2
+	b.eq	0b
+
+	/* Clear jump address before jump */
+	str	x2, [x0, #ACPI_PP_CPU_JMP_OFFSET]
+	dsb	sy
+
+	br	x1
+ENDPROC(acpi_pp_code_start)
+	/* Secondary Boot Code ends here */
+__secondary_pp_code_end:
diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index c65eabe837..7386f55ad3 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -4,6 +4,7 @@
 #define __ASM_ACPI_TABLE_H__
 
 #ifndef __ACPI__
+#ifndef __ASSEMBLY__
 
 #include <acpi/acpi_table.h>
 
@@ -109,7 +110,38 @@ int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
 			const u32 sets, const u8 assoc, const u8 attributes,
 			const u16 line_size);
 
+/* Multi-processor Startup for ARM Platforms */
+/**
+ * struct acpi_pp_page - MP startup handshake mailbox
+ *
+ * Defines a 4096 byte memory region that is used for starting secondary CPUs on
+ * an Arm system that follows the "Multi-processor Startup for ARM Platforms" spec.
+ *
+ * @cpu_id:           MPIDR as returned by the Multiprocessor Affinity Register.
+ *                    On 32bit Arm systems the upper bits are unused.
+ * @jumping_address:  On 32bit Arm systems the address must be below 4 GiB
+ * @os_reserved:      Reserved for OS use. Firmware must not access this memory.
+ * @spinning_code:    Reserved for firmware use. OS must not access this memory.
+ *                    The spinning code will be installed by firmware and the secondary
+ *                    CPUs will enter it before the control is handed over to the OS.
+ */
+struct acpi_pp_page {
+	u64 cpu_id;
+	u64 jumping_address;
+	u8 os_reserved[2032];
+	u8 spinning_code[2048];
+} __packed;
+
 #endif /* !__ASSEMBLY__ */
 #endif /* !__ACPI__ */
 
+/* Multi-processor Startup for ARM Platforms defines */
+#define ACPI_PP_CPU_ID_INVALID		0xffffffff
+#define ACPI_PP_JMP_ADR_INVALID		0
+#define ACPI_PP_PAGE_SIZE		4096
+#define ACPI_PP_CPU_ID_OFFSET		0
+#define ACPI_PP_CPU_JMP_OFFSET		8
+#define ACPI_PP_CPU_CODE_OFFSET		2048
+#define ACPI_PP_VERSION			1
+
 #endif /* __ASM_ACPI_TABLE_H__ */
diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
index b264a31cbb..5b59997fb2 100644
--- a/arch/arm/lib/acpi_table.c
+++ b/arch/arm/lib/acpi_table.c
@@ -10,9 +10,45 @@
 #include <acpi/acpigen.h>
 #include <acpi/acpi_device.h>
 #include <acpi/acpi_table.h>
+#include <asm-generic/io.h>
+#include <bloblist.h>
+#include <cpu_func.h>
 #include <dm/acpi.h>
 #include <dm/uclass.h>
+#include <efi_loader.h>
+#include <linux/log2.h>
+#include <linux/sizes.h>
+#include <malloc.h>
 #include <string.h>
+#include <tables_csum.h>
+
+/* defined in assembly file */
+/**
+ * acpi_pp_code_size - Spinloop code size *
+ */
+extern u16 acpi_pp_code_size;
+
+/**
+ * acpi_pp_tables - Start of ACPI PP tables.
+ */
+extern ulong acpi_pp_tables;
+
+/**
+ * acpi_pp_etables - End of ACPI PP tables.
+ */
+extern ulong acpi_pp_etables;
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
 
 void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
 			  uint perf_gsiv, ulong phys_base, ulong gicv,
@@ -125,3 +161,116 @@ void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx)
 
 	return ctx->current;
 }
+
+/**
+ * acpi_write_pp_setup_one_page() - Fill out one page used by the PP
+ *
+ * Fill out the struct acpi_pp_page to contain the spin-loop
+ * code and the mailbox area. After this function the page is ready for
+ * the secondary core's to enter the spin-loop code.
+ *
+ * @page:                 Pointer to current parking protocol page
+ * @gicc:                 Pointer to corresponding GICC sub-table
+ */
+static void acpi_write_pp_setup_one_page(struct acpi_pp_page *page,
+					 struct acpi_madt_gicc *gicc)
+{
+	void *reloc;
+
+	/* Update GICC. Mark parking protocol as available. */
+	gicc->parking_proto = ACPI_PP_VERSION;
+	gicc->parked_addr = virt_to_phys(page);
+
+	/* Prepare parking protocol page */
+	memset(page, '\0', sizeof(struct acpi_pp_page));
+
+	/* Init mailbox. Set MPIDR so core's will find their page. */
+	page->cpu_id = gicc->mpidr;
+	page->jumping_address = ACPI_PP_JMP_ADR_INVALID;
+
+	/* Relocate spinning code */
+	reloc = &page->spinning_code[0];
+
+	log_debug("Relocating spin table from %lx to %lx (size %x)\n",
+		  (ulong)&acpi_pp_code_start, (ulong)reloc, acpi_pp_code_size);
+	memcpy(reloc, &acpi_pp_code_start, acpi_pp_code_size);
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		flush_dcache_range((unsigned long)page,
+				   (unsigned long)(page + 1));
+}
+
+void acpi_write_park(struct acpi_madt *madt)
+{
+	struct acpi_pp_page *start, *page;
+	struct acpi_madt_gicc *gicc;
+	int ret, i, ncpus = 0;
+
+	/*
+	 * According to the "Multi-processor Startup for ARM Platforms":
+	 * - Every CPU as specified by MADT GICC has it's own 4K page
+	 * - Every page is divided into two sections: OS and FW reserved
+	 * - Memory occupied by "Parking Protocol" must be marked 'Reserved'
+	 * - Spinloop code should reside in FW reserved 2048 bytes
+	 * - Spinloop code will check the mailbox in OS reserved area
+	 */
+
+	if (acpi_pp_code_size > sizeof(page->spinning_code)) {
+		log_err("Spinning code too big to fit: %d\n",
+			acpi_pp_code_size);
+		return;
+	}
+
+	/* Count all MADT GICCs including BSP */
+	for (i = sizeof(struct acpi_madt); i < madt->header.length;
+	     i += gicc->length) {
+		gicc = (struct acpi_madt_gicc *)((void *)madt + i);
+		if (gicc->type != ACPI_APIC_GICC)
+			continue;
+		ncpus++;
+	}
+	log_debug("Found %#x GICCs in MADT\n", ncpus);
+
+	/* Allocate pages linearly due to assembly code requirements */
+	start = bloblist_add(BLOBLISTT_ACPI_PP, ACPI_PP_PAGE_SIZE * ncpus,
+			     ilog2(SZ_4K));
+	if (!start) {
+		log_err("Failed to allocate memory for ACPI-parking-protocol pages\n");
+		return;
+	}
+	log_debug("Allocated parking protocol at %p\n", start);
+	page = start;
+
+	if (IS_ENABLED(CONFIG_EFI_LOADER)) {
+		/* Default mapping is 'BOOT CODE'. Mark as reserved instead. */
+		ret = efi_add_memory_map((u64)(uintptr_t)start,
+					 ncpus * ACPI_PP_PAGE_SIZE,
+					 EFI_RESERVED_MEMORY_TYPE);
+
+		if (ret)
+			log_err("Reserved memory mapping failed addr %p size %x\n",
+				start, ncpus * ACPI_PP_PAGE_SIZE);
+	}
+
+	/* Prepare the parking protocol pages */
+	for (i = sizeof(struct acpi_madt); i < madt->header.length;
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
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		flush_dcache_all();
+
+	/* Send an event to wake up the secondary CPU. */
+	asm("dsb	ishst\n"
+	    "sev");
+}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 07c5f65d75..b8b1f1338c 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -1237,6 +1237,16 @@ int acpi_iort_add_smmu_v3(struct acpi_ctx *ctx,
  */
 void *acpi_fill_madt(struct acpi_madt *madt, struct acpi_ctx *ctx);
 
+/**
+ * acpi_write_park() - Installs the ACPI parking protocol.
+ *
+ * Sets up the ACPI parking protocol and installs the spinning code for
+ * secondary CPUs.
+ *
+ * @madt: The MADT to update
+ */
+void acpi_write_park(struct acpi_madt *madt);
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
index ea444354eb..f4d587136c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -314,6 +314,22 @@ config GENERATE_ACPI_TABLE
 	  by the operating system. It defines platform-independent interfaces
 	  for configuration and power management monitoring.
 
+config ACPI_PARKING_PROTOCOL
+	bool "Support ACPI parking protocol method"
+	depends on GENERATE_ACPI_TABLE
+	depends on ARMV8_MULTIENTRY
+	depends on BLOBLIST_TABLES
+	default y if !SEC_FIRMWARE_ARMV8_PSCI && !ARMV8_PSCI
+	help
+	  Say Y here to support "ACPI parking protocol" enable method
+	  for booting Linux.
+
+	  To use this feature, you must do:
+	    - Bring secondary CPUs into U-Boot proper in a board-specific
+	      manner.  This must be done *after* relocation.  Otherwise, the
+	      secondary CPUs will spin in unprotected memory-area because the
+	      master CPU protects the relocated spin code.
+
 config SPL_TINY_MEMSET
 	bool "Use a very small memset() in SPL"
 	depends on SPL
diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index d6357bdc4d..3a1b18f93b 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -286,6 +286,10 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 
 	/* (Re)calculate length and checksum */
 	header->length = (uintptr_t)current - (uintptr_t)madt;
+
+	if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
+		acpi_write_park(madt);
+
 	header->checksum = table_compute_checksum((void *)madt, header->length);
 	acpi_add_table(ctx, madt);
 	ctx->current = (void *)madt + madt->header.length;
-- 
2.46.0

