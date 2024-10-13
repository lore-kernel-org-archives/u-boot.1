Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19B1CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 10:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA50888FB7;
	Sun, 13 Oct 2024 12:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF07188F5E; Sun, 13 Oct 2024 12:56:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7BB9A88F85
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC6A1007;
 Sun, 13 Oct 2024 03:56:57 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 674DD3F71E;
 Sun, 13 Oct 2024 03:56:25 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 15/15] efi_memory: rename variable to highlight overlap
 with free memory
Date: Sun, 13 Oct 2024 16:25:22 +0530
Message-Id: <20241013105522.391414-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
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

The variable overlap_only_ram is used to specify that the new memory
region that is being created needs to come from the free memory pool
-- this is done by carving out the memory region from the free
memory. The name is a bit confusing though, as other allocated memory
regions, like boot-services code and data are also part of the RAM
memory. Rename the variable to overlap_conventional to highlight the
fact that it is the free/conventional memory that is being referred to
in this context.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Rename overlap_no_freemem to overlap_conventional as suggested by
  Ilias.

 include/efi_loader.h        | 16 +++++++-----
 lib/efi_loader/efi_memory.c | 51 ++++++++++++++++++++-----------------
 2 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6b9a66a06c..291eca5c07 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -788,15 +788,17 @@ efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:		start address, must be a multiple of EFI_PAGE_SIZE
- * @pages:		number of pages to add
- * @memory_type:	type of memory added
- * @overlap_only_ram:	region may only overlap RAM
- * Return:		status code
+ * @start:			start address, must be a multiple of
+ *				EFI_PAGE_SIZE
+ * @pages:			number of pages to add
+ * @memory_type:		type of memory added
+ * @overlap_conventional:	region may only overlap free(conventional)
+ *				memory
+ * Return:			status code
  */
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-					  int memory_type,
-					  bool overlap_only_ram);
+				   int memory_type,
+				   bool overlap_conventional);
 
 /* Called by board init to initialize the EFI drivers */
 efi_status_t efi_driver_init(void);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index f59f7780e9..b63b5cca71 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -173,17 +173,19 @@ static void efi_mem_sort(void)
 /**
  * efi_mem_carve_out() - unmap memory region
  *
- * @map:		memory map
- * @carve_desc:		memory region to unmap
- * @overlap_only_ram:	the carved out region may only overlap RAM
- * Return:		the number of overlapping pages which have been
- *			removed from the map,
- *			EFI_CARVE_NO_OVERLAP, if the regions don't overlap,
- *			EFI_CARVE_OVERLAPS_NONRAM, if the carve and map overlap,
- *			and the map contains anything but free ram
- *			(only when overlap_only_ram is true),
- *			EFI_CARVE_LOOP_AGAIN, if the mapping list should be
- *			traversed again, as it has been altered.
+ * @map:			memory map
+ * @carve_desc:			memory region to unmap
+ * @overlap_conventional:	the carved out region may only overlap free,
+ *				or conventional memory
+ * Return:			the number of overlapping pages which have been
+ *				removed from the map,
+ *				EFI_CARVE_NO_OVERLAP, if the regions don't
+ *				overlap, EFI_CARVE_OVERLAPS_NONRAM, if the carve
+ *				and map overlap, and the map contains anything
+ *				but free ram(only when overlap_conventional is
+ *				true),
+ *				EFI_CARVE_LOOP_AGAIN, if the mapping list should
+ *				be traversed again, as it has been altered.
  *
  * Unmaps all memory occupied by the carve_desc region from the list entry
  * pointed to by map.
@@ -193,7 +195,7 @@ static void efi_mem_sort(void)
  */
 static s64 efi_mem_carve_out(struct efi_mem_list *map,
 			     struct efi_mem_desc *carve_desc,
-			     bool overlap_only_ram)
+			     bool overlap_conventional)
 {
 	struct efi_mem_list *newmap;
 	struct efi_mem_desc *map_desc = &map->desc;
@@ -208,7 +210,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 		return EFI_CARVE_NO_OVERLAP;
 
 	/* We're overlapping with non-RAM, warn the caller if desired */
-	if (overlap_only_ram && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
+	if (overlap_conventional && (map_desc->type != EFI_CONVENTIONAL_MEMORY))
 		return EFI_CARVE_OVERLAPS_NONRAM;
 
 	/* Sanitize carve_start and carve_end to lie within our bounds */
@@ -258,15 +260,17 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 /**
  * efi_add_memory_map_pg() - add pages to the memory map
  *
- * @start:		start address, must be a multiple of EFI_PAGE_SIZE
- * @pages:		number of pages to add
- * @memory_type:	type of memory added
- * @overlap_only_ram:	region may only overlap RAM
- * Return:		status code
+ * @start:			start address, must be a multiple of
+ *				EFI_PAGE_SIZE
+ * @pages:			number of pages to add
+ * @memory_type:		type of memory added
+ * @overlap_conventional:	region may only overlap free(conventional)
+ *				memory
+ * Return:			status code
  */
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-					  int memory_type,
-					  bool overlap_only_ram)
+				   int memory_type,
+				   bool overlap_conventional)
 {
 	struct efi_mem_list *lmem;
 	struct efi_mem_list *newlist;
@@ -275,7 +279,8 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	struct efi_event *evt;
 
 	EFI_PRINT("%s: 0x%llx 0x%llx %d %s\n", __func__,
-		  start, pages, memory_type, overlap_only_ram ? "yes" : "no");
+		  start, pages, memory_type, overlap_conventional ?
+		  "yes" : "no");
 
 	if (memory_type >= EFI_MAX_MEMORY_TYPE)
 		return EFI_INVALID_PARAMETER;
@@ -312,7 +317,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 			s64 r;
 
 			r = efi_mem_carve_out(lmem, &newlist->desc,
-					      overlap_only_ram);
+					      overlap_conventional);
 			switch (r) {
 			case EFI_CARVE_OUT_OF_RESOURCES:
 				free(newlist);
@@ -348,7 +353,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 		}
 	} while (carve_again);
 
-	if (overlap_only_ram && (carved_pages != pages)) {
+	if (overlap_conventional && (carved_pages != pages)) {
 		/*
 		 * The payload wanted to have RAM overlaps, but we overlapped
 		 * with an unallocated region. Error out.
-- 
2.34.1

