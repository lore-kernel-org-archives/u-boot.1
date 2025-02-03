Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA5C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 10:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F78380243;
	Mon,  3 Feb 2025 11:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22FF80214; Mon,  3 Feb 2025 11:59:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C925F805D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88E9111FB;
 Mon,  3 Feb 2025 03:00:02 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E576C3F5A1;
 Mon,  3 Feb 2025 02:59:34 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v4 2/5] efi_loader: add a function to remove memory from the
 EFI map
Date: Mon,  3 Feb 2025 16:29:09 +0530
Message-Id: <20250203105912.196654-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203105912.196654-1-sughosh.ganu@linaro.org>
References: <20250203105912.196654-1-sughosh.ganu@linaro.org>
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

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

With upcoming changes supporting pmem nodes, we need to remove the
pmem area from the EFI memory map. Add a function to do that.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V3: None

 include/efi_loader.h        | 11 +++++---
 lib/efi_loader/efi_memory.c | 51 +++++++++++++++++++++++++++----------
 lib/lmb.c                   |  4 +--
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index dcae6a731a0..d10e3ca4895 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -853,7 +853,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 
 /**
- * efi_add_memory_map_pg() - add pages to the memory map
+ * efi_update_memory_map() - update the memory map by adding/removing pages
  *
  * @start:			start address, must be a multiple of
  *				EFI_PAGE_SIZE
@@ -861,11 +861,14 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
  * @memory_type:		type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
  *				memory
+ * @remove:			remove memory map
  * Return:			status code
  */
-efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-				   int memory_type,
-				   bool overlap_conventional);
+efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
+				   bool overlap_conventional, bool remove);
+
+/* Remove memory from the EFI memory map */
+efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type);
 
 /* Called by board init to initialize the EFI drivers */
 efi_status_t efi_driver_init(void);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 1212772471e..2362995abf6 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -258,7 +258,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 }
 
 /**
- * efi_add_memory_map_pg() - add pages to the memory map
+ * efi_update_memory_map() - update the memory map by adding/removing pages
  *
  * @start:			start address, must be a multiple of
  *				EFI_PAGE_SIZE
@@ -266,11 +266,11 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
  * @memory_type:		type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
  *				memory
+ * @remove:			remove memory map
  * Return:			status code
  */
-efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-				   int memory_type,
-				   bool overlap_conventional)
+efi_status_t efi_update_memory_map(u64 start, u64 pages, int memory_type,
+				   bool overlap_conventional, bool remove)
 {
 	struct efi_mem_list *lmem;
 	struct efi_mem_list *newlist;
@@ -278,9 +278,9 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	uint64_t carved_pages = 0;
 	struct efi_event *evt;
 
-	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
+	EFI_PRINT("%s: 0x%llx 0x%llx %d %s %s\n", __func__,
 		  start, pages, memory_type, overlap_conventional ?
-		  "yes" : "no");
+		  "yes" : "no", remove ? "remove" : "add");
 
 	if (memory_type >= EFI_MAX_MEMORY_TYPE)
 		return EFI_INVALID_PARAMETER;
@@ -363,7 +363,10 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	}
 
 	/* Add our new map */
-        list_add_tail(&newlist->link, &efi_mem);
+	if (!remove)
+		list_add_tail(&newlist->link, &efi_mem);
+	else
+		free(newlist);
 
 	/* And make sure memory is listed in descending order */
 	efi_mem_sort();
@@ -400,7 +403,29 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type)
 	pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
 	start &= ~EFI_PAGE_MASK;
 
-	return efi_add_memory_map_pg(start, pages, memory_type, false);
+	return efi_update_memory_map(start, pages, memory_type, false, false);
+}
+
+/**
+ * efi_remove_memory_map() - remove memory area to the memory map
+ *
+ * @start:		start address of the memory area
+ * @size:		length in bytes of the memory area
+ * @memory_type:	type of memory removed
+ *
+ * Return:		status code
+ *
+ * This function automatically aligns the start and size of the memory area
+ * to EFI_PAGE_SIZE.
+ */
+efi_status_t efi_remove_memory_map(u64 start, u64 size, int memory_type)
+{
+	u64 pages;
+
+	pages = efi_size_in_pages(size + (start & EFI_PAGE_MASK));
+	start &= ~EFI_PAGE_MASK;
+
+	return efi_update_memory_map(start, pages, memory_type, false, true);
 }
 
 /**
@@ -501,7 +526,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 
 	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
+	ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
 		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
@@ -822,8 +847,8 @@ static void add_u_boot_and_runtime(void)
 		       uboot_stack_size) & ~EFI_PAGE_MASK;
 	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
 		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
-			      false);
+	efi_update_memory_map(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
+			      false, false);
 #if defined(__aarch64__)
 	/*
 	 * Runtime Services must be 64KiB aligned according to the
@@ -841,8 +866,8 @@ static void add_u_boot_and_runtime(void)
 	runtime_end = (uintptr_t)__efi_runtime_stop;
 	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
 	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(runtime_start, runtime_pages,
-			      EFI_RUNTIME_SERVICES_CODE, false);
+	efi_update_memory_map(runtime_start, runtime_pages,
+			      EFI_RUNTIME_SERVICES_CODE, false, false);
 }
 
 int efi_memory_init(void)
diff --git a/lib/lmb.c b/lib/lmb.c
index 7ca44591e1d..d5aea1ed8fe 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -455,11 +455,11 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
 	efi_addr &= ~EFI_PAGE_MASK;
 
-	status = efi_add_memory_map_pg(efi_addr, pages,
+	status = efi_update_memory_map(efi_addr, pages,
 				       op == MAP_OP_RESERVE ?
 				       EFI_BOOT_SERVICES_DATA :
 				       EFI_CONVENTIONAL_MEMORY,
-				       false);
+				       false, false);
 	if (status != EFI_SUCCESS) {
 		log_err("%s: LMB Map notify failure %lu\n", __func__,
 			status & ~EFI_ERROR_MASK);
-- 
2.34.1

