Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BEFC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B348888D;
	Thu,  4 Jul 2024 09:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A661885D7; Thu,  4 Jul 2024 09:36:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 751C68881D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01177367;
 Thu,  4 Jul 2024 00:37:17 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1A903F762;
 Thu,  4 Jul 2024 00:36:48 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 13/48] lmb: make LMB memory map persistent and global
Date: Thu,  4 Jul 2024 13:05:09 +0530
Message-Id: <20240704073544.670249-14-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

The current LMB API's for allocating and reserving memory use a
per-caller based memory view. Memory allocated by a caller can then be
overwritten by another caller. Make these allocations and reservations
persistent using the alloced list data structure.

Two alloced lists are declared -- one for the available(free) memory,
and one for the used memory. Once full, the list can then be extended
at runtime.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Use alloced list structure for the available and reserved memory
  lists instead of static arrays.
* Corresponding changes in the code made as a result of the above
  change.
* Rename the reserved memory list as 'used'.

 include/lmb.h |  77 +++--------
 lib/lmb.c     | 346 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 224 insertions(+), 199 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 99fcf5781f..27cdb18c37 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -24,78 +24,18 @@ enum lmb_flags {
 };
 
 /**
- * struct lmb_property - Description of one region.
+ * struct lmb_region - Description of one region.
  *
  * @base:	Base address of the region.
  * @size:	Size of the region
  * @flags:	memory region attributes
  */
-struct lmb_property {
+struct lmb_region {
 	phys_addr_t base;
 	phys_size_t size;
 	enum lmb_flags flags;
 };
 
-/*
- * For regions size management, see LMB configuration in KConfig
- * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (boolean)
- *
- * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
- *         => CONFIG_LMB_MAX_REGIONS is used to configure the region size,
- *         directly in the array lmb_region.region[], with the same
- *         configuration for memory and reserved regions.
- *
- * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
- *         region is configurated *independently* with
- *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
- *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
- *         lmb_region.region is only a pointer to the correct buffer,
- *         initialized in lmb_init(). This configuration is useful to manage
- *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
- */
-
-/**
- * struct lmb_region - Description of a set of region.
- *
- * @cnt: Number of regions.
- * @max: Size of the region array, max value of cnt.
- * @region: Array of the region properties
- */
-struct lmb_region {
-	unsigned long cnt;
-	unsigned long max;
-#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
-#else
-	struct lmb_property *region;
-#endif
-};
-
-/**
- * struct lmb - Logical memory block handle.
- *
- * Clients provide storage for Logical memory block (lmb) handles.
- * The content of the structure is managed by the lmb library.
- * A lmb struct is  initialized by lmb_init() functions.
- * The lmb struct is passed to all other lmb APIs.
- *
- * @memory: Description of memory regions.
- * @reserved: Description of reserved regions.
- * @memory_regions: Array of the memory regions (statically allocated)
- * @reserved_regions: Array of the reserved regions (statically allocated)
- */
-struct lmb {
-	struct lmb_region memory;
-	struct lmb_region reserved;
-#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
-#endif
-};
-
-void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob);
 long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve(phys_addr_t base, phys_size_t size);
 /**
@@ -134,6 +74,19 @@ void board_lmb_reserve(void);
 void arch_lmb_reserve(void);
 void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
+/**
+ * lmb_mem_regions_init() - Initialise the LMB memory
+ *
+ * Initialise the LMB subsystem related data structures. There are two
+ * alloced lists that are initialised, one for the free memory, and one
+ * for the used memory.
+ *
+ * Initialise the two lists as part of board init.
+ *
+ * Return: 0 if OK, -ve on failure.
+ */
+int lmb_mem_regions_init(void);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_LMB_H */
diff --git a/lib/lmb.c b/lib/lmb.c
index 80945e3cae..a46bc8a7a3 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2001 Peter Bergner.
  */
 
+#include <alist.h>
 #include <efi_loader.h>
 #include <image.h>
 #include <mapmem.h>
@@ -15,24 +16,30 @@
 
 #include <asm/global_data.h>
 #include <asm/sections.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define LMB_ALLOC_ANYWHERE	0
+#define LMB_ALIST_INITIAL_SIZE	4
 
-static void lmb_dump_region(struct lmb_region *rgn, char *name)
+struct alist lmb_free_mem;
+struct alist lmb_used_mem;
+
+static void lmb_dump_region(struct alist *lmb_rgn_lst, char *name)
 {
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 	unsigned long long base, size, end;
 	enum lmb_flags flags;
 	int i;
 
-	printf(" %s.cnt = 0x%lx / max = 0x%lx\n", name, rgn->cnt, rgn->max);
+	printf(" %s.count = 0x%hx\n", name, lmb_rgn_lst->count);
 
-	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		base = rgn[i].base;
+		size = rgn[i].size;
 		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		flags = rgn[i].flags;
 
 		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
 		       name, i, base, end, size, flags);
@@ -42,8 +49,8 @@ static void lmb_dump_region(struct lmb_region *rgn, char *name)
 void lmb_dump_all_force(void)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb->memory, "memory");
-	lmb_dump_region(&lmb->reserved, "reserved");
+	lmb_dump_region(&lmb_free_mem, "memory");
+	lmb_dump_region(&lmb_used_mem, "reserved");
 }
 
 void lmb_dump_all(void)
@@ -73,61 +80,71 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
+static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
 				unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 
 	return lmb_addrs_overlap(base1, size1, base2, size2);
 }
-static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
+
+static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
-static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
+static void lmb_remove_region(struct alist *lmb_rgn_lst, unsigned long r)
 {
 	unsigned long i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	for (i = r; i < rgn->cnt - 1; i++) {
-		rgn->region[i].base = rgn->region[i + 1].base;
-		rgn->region[i].size = rgn->region[i + 1].size;
-		rgn->region[i].flags = rgn->region[i + 1].flags;
+	for (i = r; i < lmb_rgn_lst->count - 1; i++) {
+		rgn[i].base = rgn[i + 1].base;
+		rgn[i].size = rgn[i + 1].size;
+		rgn[i].flags = rgn[i + 1].flags;
 	}
-	rgn->cnt--;
+	lmb_rgn_lst->count--;
 }
 
 /* Assumption: base addr of region 1 < base addr of region 2 */
-static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
+static void lmb_coalesce_regions(struct alist *lmb_rgn_lst, unsigned long r1,
 				 unsigned long r2)
 {
-	rgn->region[r1].size += rgn->region[r2].size;
-	lmb_remove_region(rgn, r2);
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	rgn[r1].size += rgn[r2].size;
+	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
 /*Assumption : base addr of region 1 < base addr of region 2*/
-static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
-				     unsigned long r2)
+static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
+				     unsigned long r1, unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	phys_addr_t base1 = rgn[r1].base;
+	phys_size_t size1 = rgn[r1].size;
+	phys_addr_t base2 = rgn[r2].base;
+	phys_size_t size2 = rgn[r2].size;
 
 	if (base1 + size1 > base2 + size2) {
 		printf("This will not be a case any time\n");
 		return;
 	}
-	rgn->region[r1].size = base2 + size2 - base1;
-	lmb_remove_region(rgn, r2);
+	rgn[r1].size = base2 + size2 - base1;
+	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
 void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
@@ -233,20 +250,22 @@ void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
 				   enum lmb_flags flags)
 {
-	return rgn->region[r1].flags == flags;
+	return rgn[r1].flags == flags;
 }
 
-static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
-				      phys_addr_t base, phys_size_t size,
-				      enum lmb_flags flags)
+static long lmb_merge_overlap_regions(struct alist *lmb_rgn_lst,
+				      unsigned long i, phys_addr_t base,
+				      phys_size_t size, enum lmb_flags flags)
 {
 	phys_size_t rgnsize;
 	unsigned long rgn_cnt, idx;
 	phys_addr_t rgnbase, rgnend;
 	phys_addr_t mergebase, mergeend;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
 	rgn_cnt = 0;
 	idx = i;
+
 	/*
 	 * First thing to do is to identify how many regions does
 	 * the requested region overlap.
@@ -254,9 +273,9 @@ static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
 	 * regions into a single region, and remove the merged
 	 * regions.
 	 */
-	while (idx < rgn->cnt - 1) {
-		rgnbase = rgn->region[idx].base;
-		rgnsize = rgn->region[idx].size;
+	while (idx < lmb_rgn_lst->count - 1) {
+		rgnbase = rgn[idx].base;
+		rgnsize = rgn[idx].size;
 
 		if (lmb_addrs_overlap(base, size, rgnbase,
 				      rgnsize)) {
@@ -268,64 +287,70 @@ static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
 	}
 
 	/* The merged region's base and size */
-	rgnbase = rgn->region[i].base;
+	rgnbase = rgn[i].base;
 	mergebase = min(base, rgnbase);
-	rgnend = rgn->region[idx].base + rgn->region[idx].size;
+	rgnend = rgn[idx].base + rgn[idx].size;
 	mergeend = max(rgnend, (base + size));
 
-	rgn->region[i].base = mergebase;
-	rgn->region[i].size = mergeend - mergebase;
+	rgn[i].base = mergebase;
+	rgn[i].size = mergeend - mergebase;
 
 	/* Now remove the merged regions */
 	while (--rgn_cnt)
-		lmb_remove_region(rgn, i + 1);
+		lmb_remove_region(lmb_rgn_lst, i + 1);
 
 	return 0;
 }
 
-static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
+static long lmb_resize_regions(struct alist *lmb_rgn_lst, unsigned long i,
 			       phys_addr_t base, phys_size_t size,
 			       enum lmb_flags flags)
 {
 	long ret = 0;
 	phys_addr_t rgnend;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	if (i == rgn->cnt - 1 ||
-		base + size < rgn->region[i + 1].base) {
+	if (i == lmb_rgn_lst->count - 1 ||
+		base + size < rgn[i + 1].base) {
 		if (!lmb_region_flags_match(rgn, i, flags))
 			return -1;
 
-		rgnend = rgn->region[i].base + rgn->region[i].size;
-		rgn->region[i].base = min(base, rgn->region[i].base);
+		rgnend = rgn[i].base + rgn[i].size;
+		rgn[i].base = min(base, rgn[i].base);
 		rgnend = max(base + size, rgnend);
-		rgn->region[i].size = rgnend - rgn->region[i].base;
+		rgn[i].size = rgnend - rgn[i].base;
 	} else {
-		ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
+		ret = lmb_merge_overlap_regions(lmb_rgn_lst, i, base, size,
+						flags);
 	}
 
 	return ret;
 }
 
 /* This routine called with relocation disabled. */
-static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
+static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
 {
-	unsigned long coalesced = 0;
 	long ret, i;
+	unsigned long coalesced = 0;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	if (rgn->cnt == 0) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
-		rgn->cnt = 1;
+	if (alist_err(lmb_rgn_lst))
+		return -1;
+
+	if (alist_empty(lmb_rgn_lst)) {
+		rgn[0].base = base;
+		rgn[0].size = size;
+		rgn[0].flags = flags;
+		lmb_rgn_lst->count = 1;
 		return 0;
 	}
 
 	/* First try and coalesce this LMB with another. */
-	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
-		phys_size_t rgnflags = rgn->region[i].flags;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
+		phys_size_t rgnflags = rgn[i].flags;
 		phys_addr_t end = base + size - 1;
 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
 		if (rgnbase <= base && end <= rgnend) {
@@ -340,19 +365,19 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		if (ret > 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
+			rgn[i].base -= size;
+			rgn[i].size += size;
 			coalesced++;
 			break;
 		} else if (ret < 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].size += size;
+			rgn[i].size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			ret = lmb_resize_regions(rgn, i, base, size,
-						 flags);
+			ret = lmb_resize_regions(lmb_rgn_lst, i, base,
+						 size, flags);
 			if (ret < 0)
 				return -1;
 
@@ -361,99 +386,106 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		}
 	}
 
-	if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
-		if (lmb_regions_adjacent(rgn, i, i + 1)) {
-			lmb_coalesce_regions(rgn, i, i + 1);
+	if (i < lmb_rgn_lst->count - 1 &&
+	    rgn[i].flags == rgn[i + 1].flags) {
+		if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
+			lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
 			coalesced++;
-		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
+		} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
 			/* fix overlapping area */
-			lmb_fix_over_lap_regions(rgn, i, i + 1);
+			lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
 			coalesced++;
 		}
 	}
 
 	if (coalesced)
 		return coalesced;
-	if (rgn->cnt >= rgn->max)
-		return -1;
+
+	if (alist_full(lmb_rgn_lst)) {
+		if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
+			return -1;
+		else
+			rgn = lmb_rgn_lst->data;
+	}
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
-	for (i = rgn->cnt-1; i >= 0; i--) {
-		if (base < rgn->region[i].base) {
-			rgn->region[i + 1].base = rgn->region[i].base;
-			rgn->region[i + 1].size = rgn->region[i].size;
-			rgn->region[i + 1].flags = rgn->region[i].flags;
+	for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
+		if (base < rgn[i].base) {
+			rgn[i + 1].base = rgn[i].base;
+			rgn[i + 1].size = rgn[i].size;
+			rgn[i + 1].flags = rgn[i].flags;
 		} else {
-			rgn->region[i + 1].base = base;
-			rgn->region[i + 1].size = size;
-			rgn->region[i + 1].flags = flags;
+			rgn[i + 1].base = base;
+			rgn[i + 1].size = size;
+			rgn[i + 1].flags = flags;
 			break;
 		}
 	}
 
-	if (base < rgn->region[0].base) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
+	if (base < rgn[0].base) {
+		rgn[0].base = base;
+		rgn[0].size = size;
+		rgn[0].flags = flags;
 	}
 
-	rgn->cnt++;
+	lmb_rgn_lst->count++;
 
 	return 0;
 }
 
-static long lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
+static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 			   phys_size_t size)
 {
-	return lmb_add_region_flags(rgn, base, size, LMB_NONE);
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
 }
 
 /* This routine may be called with relocation disabled. */
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *_rgn = &(lmb->memory);
+	struct alist *lmb_rgn_lst = &lmb_free_mem;
 
-	return lmb_add_region(_rgn, base, size);
+	return lmb_add_region(lmb_rgn_lst, base, size);
 }
 
 long lmb_free(phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *rgn = &(lmb->reserved);
+	struct lmb_region *rgn;
+	struct alist *lmb_rgn_lst = &lmb_used_mem;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
 
 	rgnbegin = rgnend = 0; /* supress gcc warnings */
-
+	rgn = lmb_rgn_lst->data;
 	/* Find the region where (base, size) belongs to */
-	for (i = 0; i < rgn->cnt; i++) {
-		rgnbegin = rgn->region[i].base;
-		rgnend = rgnbegin + rgn->region[i].size - 1;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		rgnbegin = rgn[i].base;
+		rgnend = rgnbegin + rgn[i].size - 1;
 
 		if ((rgnbegin <= base) && (end <= rgnend))
 			break;
 	}
 
 	/* Didn't find the region */
-	if (i == rgn->cnt)
+	if (i == lmb_rgn_lst->count)
 		return -1;
 
 	/* Check to see if we are removing entire region */
 	if ((rgnbegin == base) && (rgnend == end)) {
-		lmb_remove_region(rgn, i);
+		lmb_remove_region(lmb_rgn_lst, i);
 		return 0;
 	}
 
 	/* Check to see if region is matching at the front */
 	if (rgnbegin == base) {
-		rgn->region[i].base = end + 1;
-		rgn->region[i].size -= size;
+		rgn[i].base = end + 1;
+		rgn[i].size -= size;
 		return 0;
 	}
 
 	/* Check to see if the region is matching at the end */
 	if (rgnend == end) {
-		rgn->region[i].size -= size;
+		rgn[i].size -= size;
 		return 0;
 	}
 
@@ -461,16 +493,16 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 	 * We need to split the entry -  adjust the current one to the
 	 * beginging of the hole and add the region after hole.
 	 */
-	rgn->region[i].size = base - rgn->region[i].base;
-	return lmb_add_region_flags(rgn, end + 1, rgnend - end,
-				    rgn->region[i].flags);
+	rgn[i].size = base - rgn[i].base;
+	return lmb_add_region_flags(lmb_rgn_lst, end + 1, rgnend - end,
+				    rgn[i].flags);
 }
 
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
-	struct lmb_region *_rgn = &(lmb->reserved);
+	struct alist *lmb_rgn_lst = &lmb_used_mem;
 
-	return lmb_add_region_flags(_rgn, base, size, flags);
+	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 }
 
 long lmb_reserve(phys_addr_t base, phys_size_t size)
@@ -478,19 +510,20 @@ long lmb_reserve(phys_addr_t base, phys_size_t size)
 	return lmb_reserve_flags(base, size, LMB_NONE);
 }
 
-static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
+static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 				phys_size_t size)
 {
 	unsigned long i;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 
-	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		phys_addr_t rgnbase = rgn[i].base;
+		phys_size_t rgnsize = rgn[i].size;
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
 			break;
 	}
 
-	return (i < rgn->cnt) ? i : -1;
+	return (i < lmb_rgn_lst->count) ? i : -1;
 }
 
 static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
@@ -504,10 +537,12 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 	long i, rgn;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
+	struct lmb_region *lmb_used = lmb_used_mem.data;
+	struct lmb_region *lmb_memory = lmb_free_mem.data;
 
-	for (i = lmb->memory.cnt - 1; i >= 0; i--) {
-		phys_addr_t lmbbase = lmb->memory.region[i].base;
-		phys_size_t lmbsize = lmb->memory.region[i].size;
+	for (i = lmb_free_mem.count - 1; i >= 0; i--) {
+		phys_addr_t lmbbase = lmb_memory[i].base;
+		phys_size_t lmbsize = lmb_memory[i].size;
 
 		if (lmbsize < size)
 			continue;
@@ -523,15 +558,16 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 			continue;
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb->reserved, base, size);
+			rgn = lmb_overlaps_region(&lmb_used_mem, base, size);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region(&lmb->reserved, base,
-						   size) < 0)
+				if (lmb_add_region_flags(&lmb_used_mem, base,
+						   size, flags) < 0)
 					return 0;
 				return base;
 			}
-			res_base = lmb->reserved.region[rgn].base;
+
+			res_base = lmb_used[rgn].base;
 			if (res_base < size)
 				break;
 			base = lmb_align_down(res_base - size, align);
@@ -562,16 +598,17 @@ static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
 				    enum lmb_flags flags)
 {
 	long rgn;
+	struct lmb_region *lmb_memory = lmb_free_mem.data;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, base, size);
+	rgn = lmb_overlaps_region(&lmb_free_mem, base, size);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
 		 * region we found.
 		 */
-		if (lmb_addrs_overlap(lmb->memory.region[rgn].base,
-				      lmb->memory.region[rgn].size,
+		if (lmb_addrs_overlap(lmb_memory[rgn].base,
+				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
 			if (lmb_reserve_flags(base, size, flags) >= 0)
@@ -596,24 +633,26 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
 	int i;
 	long rgn;
+	struct lmb_region *lmb_used = lmb_used_mem.data;
+	struct lmb_region *lmb_memory = lmb_free_mem.data;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
+	rgn = lmb_overlaps_region(&lmb_free_mem, addr, 1);
 	if (rgn >= 0) {
-		for (i = 0; i < lmb->reserved.cnt; i++) {
-			if (addr < lmb->reserved.region[i].base) {
+		for (i = 0; i < lmb_used_mem.count; i++) {
+			if (addr < lmb_used[i].base) {
 				/* first reserved range > requested address */
-				return lmb->reserved.region[i].base - addr;
+				return lmb_used[i].base - addr;
 			}
-			if (lmb->reserved.region[i].base +
-			    lmb->reserved.region[i].size > addr) {
+			if (lmb_used[i].base +
+			    lmb_used[i].size > addr) {
 				/* requested addr is in this reserved range */
 				return 0;
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb->memory.region[lmb->memory.cnt - 1].base +
-		       lmb->memory.region[lmb->memory.cnt - 1].size - addr;
+		return lmb_memory[lmb_free_mem.count - 1].base +
+		       lmb_memory[lmb_free_mem.count - 1].size - addr;
 	}
 	return 0;
 }
@@ -621,12 +660,13 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 {
 	int i;
+	struct lmb_region *lmb_used = lmb_used_mem.data;
 
-	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.region[i].base +
-			lmb->reserved.region[i].size - 1;
-		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
-			return (lmb->reserved.region[i].flags & flags) == flags;
+	for (i = 0; i < lmb_used_mem.count; i++) {
+		phys_addr_t upper = lmb_used[i].base +
+			lmb_used[i].size - 1;
+		if ((addr >= lmb_used[i].base) && (addr <= upper))
+			return (lmb_used[i].flags & flags) == flags;
 	}
 	return 0;
 }
@@ -640,3 +680,35 @@ __weak void arch_lmb_reserve(void)
 {
 	/* please define platform specific arch_lmb_reserve() */
 }
+
+/**
+ * lmb_mem_regions_init() - Initialise the LMB memory
+ *
+ * Initialise the LMB subsystem related data structures. There are two
+ * alloced lists that are initialised, one for the free memory, and one
+ * for the used memory.
+ *
+ * Initialise the two lists as part of board init.
+ *
+ * Return: 0 if OK, -ve on failure.
+ */
+int lmb_mem_regions_init(void)
+{
+	bool ret;
+
+	ret = alist_init(&lmb_free_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB free memory\n");
+		return -1;
+	}
+
+	ret = alist_init(&lmb_used_mem, sizeof(struct lmb_region),
+			 (uint)LMB_ALIST_INITIAL_SIZE);
+	if (!ret) {
+		log_debug("Unable to initialise the list for LMB used memory\n");
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.34.1

