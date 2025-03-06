Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF109C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D940D81DB4;
	Thu,  6 Mar 2025 17:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VlQiu7VG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A728141D; Thu,  6 Mar 2025 17:06:04 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9DE81DAB
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71e10e6a1ceso189750a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277160; x=1741881960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yi5Zb3rhsY22v8Q189HIVxB6Vx4taCu780oTrHqKjAE=;
 b=VlQiu7VGA6k9udveiuGR9tkTwUYQ8Yne6Oro8nTWqiroqgysziUd1n9ajEaFlENVjF
 Y06xB6eIQOq54yLet5+VtZPU26DLnTM3+zwHzsasbaQ0/mfAsamJtcZwVqOUI7LCBXbz
 HpTXlVfg/jCVzvIvnrErOa+bGmzae82RpyS8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277160; x=1741881960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yi5Zb3rhsY22v8Q189HIVxB6Vx4taCu780oTrHqKjAE=;
 b=SS/rpxUbZccfZU6bUs4Jx2xqp1yNp0FQ+UDS0yK3iBP3wj4Hg1EMvMaIRGbDY/rsST
 e0U80/xqiF8Cz9x8/0Yx6lXxEL0uY+1z5qr1IoV+b/LxICZCEEbui0EqtSKwgBJiYtHw
 VWv2d1PobWLUiINa76hDOe0ZFXpXwwMDlgLmqPPbDXgkIgkeI/RBBxX/VAlRGTxCnOAa
 o/MddmUlEtUj/AxXv2ohCHjIsTaF6/gmBbLWw/tcjbV2paluq3Ko2Zuh6PkUpAxtwS1U
 gLGkrtoybdrUi0YXuQGC+S7IelneXdCReGpbq0zPuPB5lc2vKiDW3HOZhy/3NLj1CUJo
 mEIw==
X-Gm-Message-State: AOJu0YxT1FeuP6Inj3xaI2HkyTwOlufUnwSa+wj2zwIbthE8axZiFNgU
 bi1cGjQjN5fr9yWDclQaZ+GNBnxrMGjAYLIklNAFc4BM1wfh8RQ2blkWPvCqiKhZM+1zVmnjzYE
 =
X-Gm-Gg: ASbGncswS3EorGspzLx+MI6CsVF4Ql9zXokYOrx9udBWQegYQl5kStvRcK1r45xo+S3
 ezgRYHauJqlYzXfP+h8ULzJNLpw2inw+lDMX8c9nE33Mui1l/eTtq8GqPXLM+xc9kWeKu6AWKsr
 8tKbelOWREs4eBFNvLF5fudwsmZm3NuemzSeISDMi6V/9ztn1MgaQ8rCjuqsZeEgiN/HeA+uoX5
 BP66Kj8htOlcBXNN6mIEAOjFIYZ+NpBuvzPFDuBCqpL10/lV2hEPyS0DmLyY7phqYqCpfvaIa5Q
 JKIbrZoMGgnA2Ke6NEYz5l6FKrXKZXl3VXgavC+E5DjfRJvc1da8WD2fJzbUcOY8yOTaO7o3T7n
 ZOeCSig==
X-Google-Smtp-Source: AGHT+IEt9PKIJYtsKKSOLjMcPvtMRY9+hBcKlUvCblIGRKxT3d68Xpii25BGuJ47LM4FKZ62P1zwqw==
X-Received: by 2002:a05:6830:4903:b0:72a:1143:8673 with SMTP id
 46e09a7af769-72a1fc823abmr4485668a34.18.1741277160594; 
 Thu, 06 Mar 2025 08:06:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 35/47] x86: emulation: Support BLOBLIST_TABLES properly
Date: Thu,  6 Mar 2025 09:04:02 -0700
Message-ID: <20250306160428.3041057-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

The existing QEMU implementation mostly ignored BLOBLIST_TABLES and
allocates the bulk of the tables with malloc(). Update it to place all
tables in the bloblist. Since QEMU declares a size of 128KB regardless
of the size of its tables, this requires a larger bloblist.

Fix up the e820 table to handle this, keeping the old code as an option
for now, to assist with any future bug-fixing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to support BLOBLIST_TABLES properly in QEMU

 arch/x86/cpu/qemu/e820.c      | 18 +++++++++++++-----
 arch/x86/lib/tables.c         |  9 ++++++++-
 configs/qemu-x86_64_defconfig |  2 +-
 configs/qemu-x86_defconfig    |  2 +-
 drivers/misc/qfw_acpi.c       | 32 +++++++++++++++++++++++++++-----
 5 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/x86/cpu/qemu/e820.c b/arch/x86/cpu/qemu/e820.c
index 2b0ad179489..078d1d86b02 100644
--- a/arch/x86/cpu/qemu/e820.c
+++ b/arch/x86/cpu/qemu/e820.c
@@ -6,6 +6,7 @@
  * (C) Copyright 2019 Bin Meng <bmeng.cn@gmail.com>
  */
 
+#include <bloblist.h>
 #include <env_internal.h>
 #include <malloc.h>
 #include <asm/e820.h>
@@ -27,12 +28,19 @@ unsigned int install_e820_map(unsigned int max_entries,
 	e820_next(&ctx, E820_RESERVED, ISA_END_ADDRESS);
 
 	/*
-	 * since we use memalign(malloc) to allocate high memory for
-	 * storing ACPI tables, we need to reserve them in e820 tables,
-	 * otherwise kernel will reclaim them and data will be corrupted
+	 * if we use bloblist to allocate high memory for storing ACPI tables,
+	 * we need to reserve that region in e820 tables, otherwise the kernel
+	 * will reclaim them and data will be corrupted. The ACPI tables may not
+	 * have been written yet, so use the whole bloblist size
 	 */
-	e820_to_addr(&ctx, E820_RAM, gd->relocaddr - TOTAL_MALLOC_LEN);
-	e820_next(&ctx, E820_RESERVED, TOTAL_MALLOC_LEN);
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		e820_to_addr(&ctx, E820_RAM, (ulong)gd->bloblist);
+		e820_next(&ctx, E820_ACPI, bloblist_get_total_size());
+	} else {
+		/* If using memalign() reserve that whole region instead */
+		e820_to_addr(&ctx, E820_RAM, gd->relocaddr - TOTAL_MALLOC_LEN);
+		e820_next(&ctx, E820_ACPI, TOTAL_MALLOC_LEN);
+	}
 	e820_to_addr(&ctx, E820_RAM, qemu_get_low_memory_size());
 	e820_add(&ctx, E820_RESERVED, CONFIG_PCIE_ECAM_BASE,
 		 CONFIG_PCIE_ECAM_SIZE);
diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 44fe80c5224..ec52992209f 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -45,6 +45,13 @@ struct table_info {
 	int align;
 };
 
+/* QEMU's tables include quite a bit of empty space */
+#ifdef CONFIG_QEMU
+#define ACPI_SIZE	(192 << 10)
+#else
+#define ACPI_SIZE	SZ_64K
+#endif
+
 static struct table_info table_list[] = {
 #ifdef CONFIG_GENERATE_PIRQ_TABLE
 	{ "pirq", write_pirq_routing_table },
@@ -60,7 +67,7 @@ static struct table_info table_list[] = {
 	 * that the calculation of gd->table_end works properly
 	 */
 #ifdef CONFIG_GENERATE_ACPI_TABLE
-	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, SZ_64K, SZ_4K},
+	{ "acpi", write_acpi_tables, BLOBLISTT_ACPI_TABLES, ACPI_SIZE, SZ_4K},
 #endif
 #ifdef CONFIG_GENERATE_SMBIOS_TABLE
 	/*
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ae34cc2a6f8..58b1fbf132d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -1,7 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0x1110000
 CONFIG_SYS_MALLOC_F_LEN=0x1800
-CONFIG_BLOBLIST_SIZE_RELOC=0x20000
+CONFIG_BLOBLIST_SIZE_RELOC=0x40000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 7afa3827e61..099d3f32d1b 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -1,7 +1,7 @@
 CONFIG_X86=y
 CONFIG_TEXT_BASE=0xFFF00000
 CONFIG_SYS_MALLOC_F_LEN=0x1000
-CONFIG_BLOBLIST_SIZE_RELOC=0x20000
+CONFIG_BLOBLIST_SIZE_RELOC=0x40000
 CONFIG_NR_DRAM_BANKS=8
 CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 0d0cf764689..ec00ba65ade 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -25,17 +25,18 @@ DECLARE_GLOBAL_DATA_PTR;
  *
  * @entry : BIOS linker command entry which tells where to allocate memory
  *          (either high memory or low memory)
- * @addr  : The address that should be used for low memory allcation. If the
+ * @addr  : The address that should be used for low memory allocation. If the
  *          memory allocation request is 'ZONE_HIGH' then this parameter will
  *          be ignored.
  * @return: 0 on success, or negative value on failure
  */
-static int bios_linker_allocate(struct udevice *dev,
+static int bios_linker_allocate(struct acpi_ctx *ctx, struct udevice *dev,
 				struct bios_linker_entry *entry, ulong *addr)
 {
 	uint32_t size, align;
 	struct fw_file *file;
 	unsigned long aligned_addr;
+	struct acpi_rsdp *rsdp;
 
 	align = le32_to_cpu(entry->alloc.align);
 	/* align must be power of 2 */
@@ -58,7 +59,9 @@ static int bios_linker_allocate(struct udevice *dev,
 	 * If allocation zone is ZONE_FSEG, then we use the 'addr' passed
 	 * in which is low memory
 	 */
-	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH) {
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		aligned_addr = ALIGN(*addr, align);
+	} else if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH) {
 		aligned_addr = (unsigned long)memalign(align, size);
 		if (!aligned_addr) {
 			printf("error: allocating resource\n");
@@ -83,8 +86,13 @@ static int bios_linker_allocate(struct udevice *dev,
 		       (void *)aligned_addr);
 	file->addr = aligned_addr;
 
+	rsdp = (void *)aligned_addr;
+	if (!strncmp(rsdp->signature, RSDP_SIG, sizeof(rsdp->signature)))
+		ctx->rsdp = rsdp;
+
 	/* adjust address for low memory allocation */
-	if (entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG)
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES) ||
+	    entry->alloc.zone == BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG)
 		*addr = (aligned_addr + size);
 
 	return 0;
@@ -209,19 +217,23 @@ ulong write_acpi_tables(ulong addr)
 	qfw_read_entry(dev, be16_to_cpu(file->cfg.select), size, table_loader);
 
 	for (i = 0; i < (size / sizeof(*entry)); i++) {
+		log_content("entry %d: addr %lx\n", i, addr);
 		entry = table_loader + i;
 		switch (le32_to_cpu(entry->command)) {
 		case BIOS_LINKER_LOADER_COMMAND_ALLOCATE:
-			ret = bios_linker_allocate(dev, entry, &addr);
+			log_content("   - %s\n", entry->alloc.file);
+			ret = bios_linker_allocate(ctx, dev, entry, &addr);
 			if (ret)
 				goto out;
 			break;
 		case BIOS_LINKER_LOADER_COMMAND_ADD_POINTER:
+			log_content("   - %s\n", entry->pointer.src_file);
 			ret = bios_linker_add_pointer(dev, entry);
 			if (ret)
 				goto out;
 			break;
 		case BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM:
+			log_content("   - %s\n", entry->cksum.file);
 			ret = bios_linker_add_checksum(dev, entry);
 			if (ret)
 				goto out;
@@ -246,6 +258,16 @@ out:
 
 	free(table_loader);
 
+	if (!ctx->rsdp) {
+		printf("error: no RSDP found\n");
+		return addr;
+	}
+	struct acpi_rsdp *rsdp = ctx->rsdp;
+
+	rsdp->length = sizeof(*rsdp);
+	rsdp->xsdt_address = 0;
+	rsdp->ext_checksum = table_compute_checksum((u8 *)rsdp, sizeof(*rsdp));
+
 	gd_set_acpi_start(acpi_get_rsdp_addr());
 
 	return addr;
-- 
2.43.0

