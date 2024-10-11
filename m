Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF78CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 762D4892FD;
	Fri, 11 Oct 2024 12:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Az57C4N8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB1E8892F6; Fri, 11 Oct 2024 12:34:39 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B009B8930E
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9977360f9fso252673866b.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642877; x=1729247677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhNFAyKTRhPyMBwMXcIjoRaZAf21p4UR86E9/nmPokY=;
 b=Az57C4N8UP9QT9E9fUkvzFQ5gUaU20UrCyxo6HyP5cffggww2SLmP5R9YbOZKMhdtV
 BpjRjTw/eUAmoqJENi0ZPxOOMvGhSS6qHLT9aSwV6EHE+uWLRKVXorXfEEiKlgoJit+J
 T/fR+9SV8ORf2XWnp5euLEX5uSxQu6aQNXPV8St5forXRV9C5A+u//jT/ZnGPlfHM6Ze
 YDtK1oQ+/jL3r01rUH7wroUrkzB9SjGUuFhT21eb5XAh0gGum5SvCQc8ILMLUjoMTZYJ
 YIivu7d8LsXf/717uD9VSeX6WwYij3bIQ1bXya0zppIEQAt5Ol8F8wU9lRwE6ECAFqSJ
 KXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642877; x=1729247677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhNFAyKTRhPyMBwMXcIjoRaZAf21p4UR86E9/nmPokY=;
 b=DqHxjSr0JyjDbYGDLIb1qZLbAmH9ZDH3wp0c0CKMF7BIWNsK1PS1FIvxuyOcacn+ja
 z6f5/S64xXPKHMm8ZB7QQ2TKCJXoH5QsDgfFXOUBbNvpEb3MtsPG2mpfUqU2voMPCd61
 izMIp0kcFwV/0b9ieTzyvszvmSDbpzCjmdfhgnCc6sAp8LJ+4gsVwSfUazCRsWp53Pep
 H4l0DrQrOBMiRcH+bhHX7G0nmJdcE1dED6T0nIPmr49x/09Wm18X0FTJh9EEmG6Wbq/h
 BcOfueHq89tOqXNUJgN7Rm1F3p7/1wWkhqle4TcRhSK9DPMfp+KQea5f/enNF9lolbVL
 ywUg==
X-Gm-Message-State: AOJu0Yys0fEwvH09fielo5YQoWL4kwPQhV7zfUwox/Kz/kq8Wdt3ABnR
 hg3n61LYNSxion8yUvpeTsl+Mm25e5lbI8m360QIV9TCh3vqbuCjiA70h9x7C+/xSsLkA4TZDtR
 XgLk=
X-Google-Smtp-Source: AGHT+IFIWAfsASky1k6dh19cHXaLq0aSfB5BBLitOXDPVnKBJtvaMzhYtLmPSA9ODjKd5nvMeFIP5Q==
X-Received: by 2002:a17:907:f1e2:b0:a99:42a3:db9b with SMTP id
 a640c23a62f3a-a99b9605e05mr168930966b.48.1728642877046; 
 Fri, 11 Oct 2024 03:34:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 07/37] arm: acpi: Add generic ACPI methods
Date: Fri, 11 Oct 2024 12:22:48 +0200
Message-ID: <20241011102419.12523-8-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

Add generic ACPI code to generate
- MADT GICC
- MADT GICD
- MADT GICR
- MADT GIC ITS
- PPTT processor
- PPTT cache

as commonly used on arm platforms.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
---
Changelog v2:
- Add full comments to exported functions
Changelog v6:
- Update header order

---
 arch/arm/include/asm/acpi_table.h | 115 ++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile             |   1 +
 arch/arm/lib/acpi_table.c         | 114 +++++++++++++++++++++++++++++
 include/acpi/acpi_table.h         |  34 ++++++++-
 4 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/lib/acpi_table.c

diff --git a/arch/arm/include/asm/acpi_table.h b/arch/arm/include/asm/acpi_table.h
index e69de29bb2..c65eabe837 100644
--- a/arch/arm/include/asm/acpi_table.h
+++ b/arch/arm/include/asm/acpi_table.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __ASM_ACPI_TABLE_H__
+#define __ASM_ACPI_TABLE_H__
+
+#ifndef __ACPI__
+
+#include <acpi/acpi_table.h>
+
+/**
+ * acpi_write_madt_gicc() - Write out a MADT GICC sub-table
+ *
+ * Write out the GIC CPU Interface sub-table.
+ *
+ * @gicc:             Pointer to place to put the sub-table
+ * @cpu_num:          GIC's CPU Interface Number
+ * @perf_gsiv:        The GSIV used for Performance Monitoring Interrupts
+ * @phys_base:        Address at which the processor can access this
+ *                    GIC CPU Interface
+ * @gicv:             Address of the GIC virtual CPU interface registers
+ * @gich:             Address of the GIC virtual interface control block
+ *                    registers
+ * @vgic_maint_irq:   GSIV for Virtual GIC maintenance interrupt
+ * @gicr_base:        Physical address of the associated Redistributor
+ * @mpidr:            MPIDR as defined by ARM architecture
+ * @efficiency:       Describes the relative power efficiency
+ */
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, u64 gicr_base,
+			  ulong mpidr, uint efficiency);
+
+/**
+ * acpi_write_madt_gicd() - Write out a MADT GICD sub-table
+ *
+ * Write out the GIC Distributor sub-table.
+ *
+ * @gicd:            Pointer to place to put the sub-table
+ * @gic_id:          This GIC Distributor's hardware ID
+ * @phys_base:       The 64-bit physical address for this Distributor
+ * @gic_version:     GIC version
+ */
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version);
+
+/**
+ * acpi_write_madt_gicr() - Write out a MADT GICR sub-table
+ *
+ * Write out the GIC Redistributor sub-table.
+ *
+ * @gicr:                            Pointer to place to put the sub-table
+ * @discovery_range_base_address:    Physical address of a page range
+ *                                   containing all GIC Redistributors
+ * @discovery_range_length:          Length of the GIC Redistributor
+ *                                   Discovery page range
+ */
+void acpi_write_madt_gicr(struct acpi_madt_gicr *gicr,
+			  u64 discovery_range_base_address,
+			  u32 discovery_range_length);
+
+/**
+ * acpi_write_madt_its() - Write out a MADT ITS sub-table
+ *
+ * Write out the GIC Interrupt Translation Service sub-table.
+ *
+ * @its:                    Pointer to place to put the sub-table
+ * @its_id:                 Uniqueue GIC ITS ID
+ * @physical_base_address:  Physical address for the Interrupt
+ *                          Translation Service
+ */
+void acpi_write_madt_its(struct acpi_madt_its *its,
+			 u32 its_id,
+			 u64 physical_base_address);
+
+/**
+ * acpi_pptt_add_proc() - Write out a PPTT processor sub-table
+ *
+ * Write out the Processor Properties Topology Table processor sub-table.
+ *
+ * @ctx:                   ACPI context pointer
+ * @flags:                 Processor Structure Flags
+ * @parent:                Reference to parent processor
+ * @proc_id:               ACPI processor ID as defined in MADT
+ * @num_resources:         Number of resource structure references
+ * @resource_list:         References to other PPTT structures
+ * Return: offset from start of PPTT in bytes
+ */
+int acpi_pptt_add_proc(struct acpi_ctx *ctx, const u32 flags, const u32 parent,
+		       const u32 proc_id, const u32 num_resources,
+		       const u32 *resource_list);
+
+/**
+ * acpi_pptt_add_cache() - Write out a PPTT cache sub-table
+ *
+ * Write out the Processor Properties Topology Table cache sub-table.
+ *
+ * @ctx: ACPI context pointer
+ * @flags:                Cache Structure Flags
+ * @next_cache_level:     Reference to next level of cache
+ * @size:                 Size of the cache in bytes
+ * @sets:                 Number of sets in the cache
+ * @assoc:                Integer number of ways
+ * @attributes:           Allocation type, Cache type, policy
+ * @line_size:            Line size in bytes
+ * Return: offset from start of PPTT in bytes
+ */
+int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
+			const u32 next_cache_level, const u32 size,
+			const u32 sets, const u8 assoc, const u8 attributes,
+			const u16 line_size);
+
+#endif /* !__ASSEMBLY__ */
+#endif /* !__ACPI__ */
+
+#endif /* __ASM_ACPI_TABLE_H__ */
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba61..a7efed6771 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -86,6 +86,7 @@ obj-y	+= psci-dt.o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
 obj-$(CONFIG_BLOBLIST)  += xferlist.o
+obj-$(CONFIG_GENERATE_ACPI_TABLE) += acpi_table.o
 
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
diff --git a/arch/arm/lib/acpi_table.c b/arch/arm/lib/acpi_table.c
new file mode 100644
index 0000000000..286ed7ceca
--- /dev/null
+++ b/arch/arm/lib/acpi_table.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on acpi.c from coreboot
+ *
+ * Copyright (C) 2024 9elements GmbH
+ */
+
+#define LOG_CATEGORY LOGC_ACPI
+
+#include <string.h>
+#include <acpi/acpigen.h>
+#include <acpi/acpi_device.h>
+#include <acpi/acpi_table.h>
+
+void acpi_write_madt_gicc(struct acpi_madt_gicc *gicc, uint cpu_num,
+			  uint perf_gsiv, ulong phys_base, ulong gicv,
+			  ulong gich, uint vgic_maint_irq, u64 gicr_base,
+			  ulong mpidr, uint efficiency)
+{
+	memset(gicc, '\0', sizeof(struct acpi_madt_gicc));
+	gicc->type = ACPI_APIC_GICC;
+	gicc->length = sizeof(struct acpi_madt_gicc);
+	gicc->cpu_if_num = cpu_num;
+	gicc->processor_id = cpu_num;
+	gicc->flags = ACPI_MADTF_ENABLED;
+	gicc->perf_gsiv = perf_gsiv;
+	gicc->phys_base = phys_base;
+	gicc->gicv = gicv;
+	gicc->gich = gich;
+	gicc->vgic_maint_irq = vgic_maint_irq;
+	gicc->gicr_base = gicr_base;
+	gicc->mpidr = mpidr;
+	gicc->efficiency = efficiency;
+}
+
+void acpi_write_madt_gicd(struct acpi_madt_gicd *gicd, uint gic_id,
+			  ulong phys_base, uint gic_version)
+{
+	memset(gicd, '\0', sizeof(struct acpi_madt_gicd));
+	gicd->type = ACPI_APIC_GICD;
+	gicd->length = sizeof(struct acpi_madt_gicd);
+	gicd->gic_id = gic_id;
+	gicd->phys_base = phys_base;
+	gicd->gic_version = gic_version;
+}
+
+void acpi_write_madt_gicr(struct acpi_madt_gicr *gicr,
+			  u64 discovery_range_base_address,
+			  u32 discovery_range_length)
+{
+	memset(gicr, '\0', sizeof(struct acpi_madt_gicr));
+	gicr->type = ACPI_APIC_GICR;
+	gicr->length = sizeof(struct acpi_madt_gicr);
+	gicr->discovery_range_base_address = discovery_range_base_address;
+	gicr->discovery_range_length = discovery_range_length;
+}
+
+void acpi_write_madt_its(struct acpi_madt_its *its,
+			 u32 its_id,
+			 u64 physical_base_address)
+{
+	memset(its, '\0', sizeof(struct acpi_madt_its));
+	its->type = ACPI_APIC_ITS;
+	its->length = sizeof(struct acpi_madt_its);
+	its->gic_its_id = its_id;
+	its->physical_base_address = physical_base_address;
+}
+
+int acpi_pptt_add_proc(struct acpi_ctx *ctx, const u32 flags, const u32 parent,
+		       const u32 proc_id, const u32 num_resources,
+		       const u32 *resource_list)
+{
+	struct acpi_pptt_proc *proc = ctx->current;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+	proc->hdr.type = ACPI_PPTT_TYPE_PROC;
+	proc->flags = flags;
+	proc->parent = parent;
+	proc->proc_id = proc_id;
+	proc->num_resources = num_resources;
+	proc->hdr.length = sizeof(struct acpi_pptt_proc) +
+		sizeof(u32) * num_resources;
+
+	if (resource_list)
+		memcpy(proc + 1, resource_list, sizeof(u32) * num_resources);
+
+	acpi_inc(ctx, proc->hdr.length);
+
+	return offset;
+}
+
+int acpi_pptt_add_cache(struct acpi_ctx *ctx, const u32 flags,
+			const u32 next_cache_level, const u32 size,
+			const u32 sets, const u8 assoc, const u8 attributes,
+			const u16 line_size)
+{
+	struct acpi_pptt_cache *cache = ctx->current;
+	int offset;
+
+	offset = ctx->current - ctx->tab_start;
+	cache->hdr.type = ACPI_PPTT_TYPE_CACHE;
+	cache->hdr.length = sizeof(struct acpi_pptt_cache);
+	cache->flags = flags;
+	cache->next_cache_level = next_cache_level;
+	cache->size = size;
+	cache->sets = sets;
+	cache->assoc = assoc;
+	cache->attributes = attributes;
+	cache->line_size = line_size;
+	acpi_inc(ctx, cache->hdr.length);
+
+	return offset;
+}
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index c6a3e44a95..7d994a985f 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -342,7 +342,10 @@ enum acpi_apic_types {
 	ACPI_APIC_LX2APIC,		/* Processor local x2APIC */
 	ACPI_APIC_LX2APIC_NMI,		/* Local x2APIC NMI */
 	ACPI_APIC_GICC,			/* Generic Interrupt Ctlr CPU i/f */
-	ACPI_APIC_GICD			/* Generic Interrupt Ctlr Distributor */
+	ACPI_APIC_GICD,			/* Generic Interrupt Ctlr Distributor */
+	ACPI_APIC_MSI_FRAME,		/* Generic Interrupt MSI Frame */
+	ACPI_APIC_GICR,			/* Generic Interrupt Ctlr Redistributor */
+	ACPI_APIC_ITS,			/* Interrupt Translation Service */
 };
 
 /* MADT: Processor Local APIC Structure */
@@ -437,6 +440,35 @@ struct acpi_madt_gicd {
 	u8 reserved3[3];
 } __packed;
 
+/**
+ * struct __packed acpi_madt_gicr - GIC Redistributor (type 0xe)
+ *
+ * This holds information about the Generic Interrupt Controller (GIC)
+ * Redistributor interface. See ACPI Spec v6.3 section 5.2.12.17
+ */
+struct acpi_madt_gicr {
+	u8 type;
+	u8 length;
+	u16 reserved;
+	u64 discovery_range_base_address;
+	u32 discovery_range_length;
+} __packed;
+
+/**
+ * struct __packed acpi_madt_its - GIC Interrupt Translation Service (type 0xf)
+ *
+ * This holds information about the Interrupt Translation Service (ITS)
+ * Structure. See ACPI Spec v6.3 section 5.2.12.18
+ */
+struct acpi_madt_its {
+	u8 type;
+	u8 length;
+	u16 reserved;
+	u32 gic_its_id;
+	u64 physical_base_address;
+	u32 reserved2;
+} __packed;
+
 /* MCFG (PCI Express MMIO config space BAR description table) */
 struct acpi_mcfg {
 	struct acpi_table_header header;
-- 
2.46.2

