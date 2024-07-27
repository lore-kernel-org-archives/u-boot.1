Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F73BC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B69308875B;
	Sat, 27 Jul 2024 09:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="evyI4qHW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AE23885AE; Sat, 27 Jul 2024 09:20:31 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABBF8877E
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7a8553db90so312944966b.2
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064828; x=1722669628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJ/lnjHbJa+yt3TgX9MW8pErewLjb7MhOxHgeEMHXZI=;
 b=evyI4qHWr+PsVaIxwtCXaQOuWZJiCDSjgLA1B7xy/TrXMX8dbWRfEOcdBJWr97VNYC
 Arz+TyGWXak1gzaRUOYrY53wBqwmxyYZPlKUiQ0XCUSpHKo8dNH+Qo1OcpsHl5OAgwDh
 v2OmCQQiKpkAOvV97kFWb2kfgSy8uqKcc/uGHrvRcOBqFnIha4kc+IWsG6NZAVzPaRDE
 YTniZ0FxxvtsIbhoS/YIRE605H1ITbf3J7pdhufY1jyjBubtoqB2hIDcWkrkVM0wKrqz
 4Tn1pLt8DEPeQ5oMNvM/ZKL8Cb7qejdktdATu+PumGEStYNwpVhdMy/GZq7hSqVIz9FT
 dynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064828; x=1722669628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJ/lnjHbJa+yt3TgX9MW8pErewLjb7MhOxHgeEMHXZI=;
 b=TdbtZKisnyywqZsmIJR30BoSrf9D01CU9toyWE/lgvNTl0Pi4N6DkQVjUKL8hW7m7c
 HIsIrq+awhDqAaI9MLG17CyaBilpUlL2bewn3Jf6XMqJi6sX+QRnoJ4e+xfkc8ztWaSq
 6MkdS6mCJUKtKqPETZcd6m8CVBv5p2si+Q4zMksqN2V146SFu0jZqT2IyIxBGWhO4kLn
 iZ7pglZTnTM1JftmLQippASOsm1vIQHLtChFAO7nJSRXRMmxN8AYq7Mfs7xx8RT3Foyf
 RCU3erdPVJTIiBJvqU2krwZRd3PD1nB49kCvpq/Vq9B7PgMAG5dPSoOkuWWpnvaN6k+a
 iTBA==
X-Gm-Message-State: AOJu0YwwI6zbrEkh2YyoY66PGiDZTWPUWQ/rpxxcsDVjDbaVLDSZYzjF
 dUdICgrhuADCpOnt+z+nEZe0o6Ng4CCk44zXvYmyh3z7zw7zDKTxBOo5e6dVTTSdf4PutkCFQfb
 z2ew=
X-Google-Smtp-Source: AGHT+IHffVqFPdMS+Yonn9nXQQ+2GN1T5Fg/j1eqm+Fq+AeZQ5RclWI7u/sv0x945ZdM+FXMcCNCaQ==
X-Received: by 2002:a17:907:868b:b0:a77:d0a0:ea6d with SMTP id
 a640c23a62f3a-a7d3ffa1f51mr117339266b.24.1722064828486; 
 Sat, 27 Jul 2024 00:20:28 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:28 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 12/17] arm: bcm283x: Write ACPI tables
Date: Sat, 27 Jul 2024 09:17:13 +0200
Message-ID: <20240727071742.1735703-13-patrick.rudolph@9elements.com>
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

Allocate a 64KiB buffer for ACPI tables and provide SoC specific tables
for BCM2711:
- MADT
- FADT
- PPTT
- GTDT
- SPCR

Board specific tables like DSDT and SSDT are added in a separate patch.

When ACPI is enabled for a different SoC compliation will fail by
design, indicating the required functions that needs to be implemented.
When ACPI is not enabled the added code does nothing, keeping existing
behaviour.

TEST: Booted on RPi4 with only ACPI enabled, providing no FDT to the OS.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-bcm283x/Makefile       |   4 +
 arch/arm/mach-bcm283x/bcm2711_acpi.c | 172 +++++++++++++++++++++++++++
 arch/arm/mach-bcm283x/init.c         |  30 +++++
 3 files changed, 206 insertions(+)
 create mode 100644 arch/arm/mach-bcm283x/bcm2711_acpi.c

diff --git a/arch/arm/mach-bcm283x/Makefile b/arch/arm/mach-bcm283x/Makefile
index 7cd068832f..38e320307d 100644
--- a/arch/arm/mach-bcm283x/Makefile
+++ b/arch/arm/mach-bcm283x/Makefile
@@ -4,3 +4,7 @@
 
 obj-$(CONFIG_BCM2835) += lowlevel_init.o
 obj-y	+= init.o reset.o mbox.o msg.o phys2bus.o
+
+ifeq ($(CONFIG_GENERATE_ACPI_TABLE),y)
+obj-$(CONFIG_BCM2711) += bcm2711_acpi.o
+endif
\ No newline at end of file
diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
new file mode 100644
index 0000000000..ab0f77c245
--- /dev/null
+++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2024 9elements GmbH
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ */
+
+#include <acpi/acpi_table.h>
+#include <asm/acpi_table.h>
+#include <asm/armv8/sec_firmware.h>
+#include <asm/arch/acpi/bcm2711.h>
+#include <tables_csum.h>
+#include <string.h>
+
+void acpi_fill_fadt(struct acpi_fadt *fadt)
+{
+	fadt->flags = ACPI_FADT_HW_REDUCED_ACPI | ACPI_FADT_LOW_PWR_IDLE_S0;
+
+	if (CONFIG_IS_ENABLED(SEC_FIRMWARE_ARMV8_PSCI) &&
+	    sec_firmware_support_psci_version() != PSCI_INVALID_VER)
+		fadt->arm_boot_arch = ACPI_ARM_PSCI_COMPLIANT;
+}
+
+void *acpi_fill_madt(struct acpi_madt *madt, void *current)
+{
+	struct acpi_madt_gicc *gicc;
+	struct acpi_madt_gicd *gicd;
+
+	madt->lapic_addr = 0;
+	madt->flags = 0;
+
+	gicc = current;
+	for (int i = 0; i < 4; i++) {
+		acpi_write_madt_gicc(gicc++, i, 0x30 + i, BCM2711_GIC400_BASE_ADDRESS + 0x2000,
+				     BCM2711_GIC400_BASE_ADDRESS + 0x6000,
+				     BCM2711_GIC400_BASE_ADDRESS + 0x4000,
+				     0x19, i, 1);
+	}
+
+	gicd = (struct acpi_madt_gicd *)gicc;
+	acpi_write_madt_gicd(gicd++, 0, BCM2711_GIC400_BASE_ADDRESS + 0x1000, 2);
+	return gicd;
+}
+
+static u32 *add_proc(struct acpi_ctx *ctx, int flags, int parent, int proc_id,
+		     int num_resources)
+{
+	struct acpi_pptt_proc *proc = ctx->current;
+	u32 *resource_list;
+
+	proc->hdr.type = ACPI_PPTT_TYPE_PROC;
+	proc->flags = flags;
+	proc->parent = parent;
+	proc->proc_id = proc_id;
+	proc->num_resources = num_resources;
+	proc->hdr.length = sizeof(struct acpi_pptt_proc) +
+		sizeof(u32) * num_resources;
+	resource_list = ctx->current + sizeof(struct acpi_pptt_proc);
+	acpi_inc(ctx, proc->hdr.length);
+
+	return resource_list;
+}
+
+static int add_cache(struct acpi_ctx *ctx, int flags, int size, int sets,
+		     int assoc, int attributes, int line_size)
+{
+	struct acpi_pptt_cache *cache = ctx->current;
+	int ofs;
+
+	ofs = ctx->current - ctx->tab_start;
+	cache->hdr.type = ACPI_PPTT_TYPE_CACHE;
+	cache->hdr.length = sizeof(struct acpi_pptt_cache);
+	cache->flags = flags;
+	cache->next_cache_level = 0;
+	cache->size = size;
+	cache->sets = sets;
+	cache->assoc = assoc;
+	cache->attributes = attributes;
+	cache->line_size = line_size;
+	acpi_inc(ctx, cache->hdr.length);
+
+	return ofs;
+}
+
+static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
+{
+	struct acpi_table_header *header;
+	int proc_ofs;
+	u32 *proc_ptr;
+	int ofs, ofs0, ofs1, i;
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
+	proc_ofs = ctx->current - ctx->tab_start;
+	proc_ptr = add_proc(ctx, ACPI_PPTT_PHYSICAL_PACKAGE |
+			    ACPI_PPTT_CHILDREN_IDENTICAL, 0, 0, 1);
+
+	ofs = add_cache(ctx, ACPI_PPTT_ALL_VALID, 0x100000, 0x400, 0x10,
+			ACPI_PPTT_WRITE_ALLOC |
+			(ACPI_PPTT_CACHE_TYPE_UNIFIED <<
+			 ACPI_PPTT_CACHE_TYPE_SHIFT), 0x40);
+	*proc_ptr = ofs;
+
+	for (i = 0; i < 4; i++) {
+		proc_ptr = add_proc(ctx, ACPI_PPTT_CHILDREN_IDENTICAL |
+				    ACPI_PPTT_NODE_IS_LEAF | ACPI_PPTT_PROC_ID_VALID,
+				    proc_ofs, i, 2);
+
+		ofs0 = add_cache(ctx, ACPI_PPTT_ALL_VALID, 0x8000, 0x100, 2,
+				 ACPI_PPTT_WRITE_ALLOC, 0x40);
+
+		ofs1 = add_cache(ctx, ACPI_PPTT_ALL_BUT_WRITE_POL, 0xc000, 0x100, 3,
+				 ACPI_PPTT_CACHE_TYPE_INSTR <<
+				 ACPI_PPTT_CACHE_TYPE_SHIFT, 0x40);
+		proc_ptr[0] = ofs0;
+		proc_ptr[1] = ofs1;
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
+
+static int rpi_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
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
+	gtdt->cnt_ctrl_base = BCM2711_ARM_LOCAL_BASE_ADDRESS + 0x1c;
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
+	header->checksum = table_compute_checksum(header, header->length);
+
+	acpi_add_table(ctx, gtdt);
+
+	acpi_inc(ctx, sizeof(struct acpi_gtdt));
+
+	return 0;
+};
+
+ACPI_WRITER(5gtdt, "GTDT", rpi_write_gtdt, 0);
\ No newline at end of file
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 7a1de22e0a..80a10f2212 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -6,11 +6,13 @@
  * project.
  */
 
+#include <acpi/acpi_table.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <dm/device.h>
 #include <fdt_support.h>
 #include <asm/global_data.h>
+#include <malloc.h>
 
 #define BCM2711_RPI4_PCIE_XHCI_MMIO_PHYS	0x600000000UL
 #define BCM2711_RPI4_PCIE_XHCI_MMIO_SIZE	0x400000UL
@@ -240,3 +242,31 @@ void enable_caches(void)
 	dcache_enable();
 }
 #endif
+
+#ifdef CONFIG_GENERATE_ACPI_TABLE
+static int last_stage_init(void)
+{
+	ulong end;
+	void *ptr;
+
+	/* Reserve 64K for ACPI tables, aligned to a 4K boundary */
+	ptr = memalign(SZ_4K, SZ_64K);
+
+	/* Generate ACPI tables */
+	end = write_acpi_tables((uintptr_t)ptr);
+	if (end < 0) {
+		log_err("Failed to write tables\n");
+		return log_msg_ret("table", end);
+	}
+	if (end > ((ulong)ptr + SZ_64K)) {
+		log_err("ACPI tables overflowed\n");
+		return 0;
+	}
+
+	gd->arch.table_start = (uintptr_t)ptr;
+	gd->arch.table_end = end;
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
+#endif
\ No newline at end of file
-- 
2.45.2

