Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18004C27C6E
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F2C8848F;
	Fri,  7 Jun 2024 20:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FD888473; Fri,  7 Jun 2024 20:53:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D2326884A7
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF7441480;
 Fri,  7 Jun 2024 11:54:06 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558F83F792;
 Fri,  7 Jun 2024 11:53:39 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 03/31] lmb: make the lmb reservations persistent
Date: Sat,  8 Jun 2024 00:22:12 +0530
Message-Id: <20240607185240.1892031-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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
persistent. With this, memory allocated or reserved will not be
overwritten.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note: @Mark Kettenis, please review the changes made in the apple dart
driver. I have removed the driver-local LMB instance, but I am not
sure if the current logic makes sense. I would think that it would be
possible to simply use memory region allocated by the LMB module(maybe
using the max address argument), instead of adding specific memory
region with lmb_add().

 arch/arm/mach-stm32mp/dram_init.c |  1 -
 board/xilinx/common/board.c       |  1 -
 drivers/iommu/apple_dart.c        |  1 -
 drivers/iommu/sandbox_iommu.c     |  1 -
 include/lmb.h                     | 17 ++----
 lib/lmb.c                         | 91 ++++++++++++++++---------------
 test/lib/lmb.c                    | 18 ------
 7 files changed, 50 insertions(+), 80 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index fb1208fc5d..86d6577b35 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -59,7 +59,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	gd->ram_top = clamp_val(gd->ram_top, 0, SZ_4G - 1);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_init(&lmb);
 	lmb_add(&lmb, gd->ram_base, gd->ram_top - gd->ram_base);
 	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
 	/* add 8M for reserved memory for display, fdt, gd,... */
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index b47d2d23f9..ebe57da7f8 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -685,7 +685,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_init(&lmb);
 	lmb_add(&lmb, gd->ram_base, gd->ram_size);
 	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
 	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 6ecd84303b..ef385d9c9f 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -214,7 +214,6 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
-	lmb_init(&priv->lmb);
 	lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
 
 	/* Disable translations. */
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index 6ceb7fd5ec..31ce91345c 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -55,7 +55,6 @@ static int sandbox_iommu_probe(struct udevice *dev)
 {
 	struct sandbox_iommu_priv *priv = dev_get_priv(dev);
 
-	lmb_init(&priv->lmb);
 	lmb_add(&priv->lmb, 0x89abc000, SZ_16K);
 
 	return 0;
diff --git a/include/lmb.h b/include/lmb.h
index 7b87181b9e..bbe1c5299c 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -49,8 +49,7 @@ struct lmb_property {
  *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
  *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
  *         lmb_region.region is only a pointer to the correct buffer,
- *         initialized in lmb_init(). This configuration is useful to manage
- *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
+ *         initialized with these values.
  */
 
 /**
@@ -73,26 +72,18 @@ struct lmb_region {
 /**
  * struct lmb - Logical memory block handle.
  *
- * Clients provide storage for Logical memory block (lmb) handles.
- * The content of the structure is managed by the lmb library.
- * A lmb struct is  initialized by lmb_init() functions.
- * The lmb struct is passed to all other lmb APIs.
+ * The Logical Memory Block structure which is used to keep track
+ * of available memory which can be used for stuff like loading
+ * images(kernel, initrd, fdt).
  *
  * @memory: Description of memory regions.
  * @reserved: Description of reserved regions.
- * @memory_regions: Array of the memory regions (statically allocated)
- * @reserved_regions: Array of the reserved regions (statically allocated)
  */
 struct lmb {
 	struct lmb_region memory;
 	struct lmb_region reserved;
-#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
-	struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
-#endif
 };
 
-void lmb_init(struct lmb *lmb);
 void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob);
 void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 				phys_size_t size, void *fdt_blob);
diff --git a/lib/lmb.c b/lib/lmb.c
index 4d39c0d1f9..7f34d4a8b0 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -20,6 +20,25 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define LMB_ALLOC_ANYWHERE	0
 
+#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
+struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
+struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
+#endif
+
+struct lmb lmb = {
+#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
+	.memory.max = CONFIG_LMB_MAX_REGIONS,
+	.reserved.max = CONFIG_LMB_MAX_REGIONS,
+#else
+	.memory.max = CONFIG_LMB_MEMORY_REGIONS,
+	.reserved.max = CONFIG_LMB_RESERVED_REGIONS,
+	.memory.region = memory_regions,
+	.reserved.region = reserved_regions,
+#endif
+	.memory.cnt = 0,
+	.reserved.cnt = 0,
+};
+
 static void lmb_dump_region(struct lmb_region *rgn, char *name)
 {
 	unsigned long long base, size, end;
@@ -42,8 +61,8 @@ static void lmb_dump_region(struct lmb_region *rgn, char *name)
 void lmb_dump_all_force(struct lmb *lmb)
 {
 	printf("lmb_dump_all:\n");
-	lmb_dump_region(&lmb->memory, "memory");
-	lmb_dump_region(&lmb->reserved, "reserved");
+	lmb_dump_region(&lmb.memory, "memory");
+	lmb_dump_region(&lmb.reserved, "reserved");
 }
 
 void lmb_dump_all(struct lmb *lmb)
@@ -130,21 +149,6 @@ static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
 	lmb_remove_region(rgn, r2);
 }
 
-void lmb_init(struct lmb *lmb)
-{
-#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	lmb->memory.max = CONFIG_LMB_MAX_REGIONS;
-	lmb->reserved.max = CONFIG_LMB_MAX_REGIONS;
-#else
-	lmb->memory.max = CONFIG_LMB_MEMORY_REGIONS;
-	lmb->reserved.max = CONFIG_LMB_RESERVED_REGIONS;
-	lmb->memory.region = lmb->memory_regions;
-	lmb->reserved.region = lmb->reserved_regions;
-#endif
-	lmb->memory.cnt = 0;
-	lmb->reserved.cnt = 0;
-}
-
 void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
 {
 	ulong bank_end;
@@ -231,8 +235,6 @@ void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob)
 {
 	int i;
 
-	lmb_init(lmb);
-
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		if (bd->bi_dram[i].size) {
 			lmb_add(lmb, bd->bi_dram[i].start,
@@ -247,7 +249,6 @@ void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob)
 void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 				phys_size_t size, void *fdt_blob)
 {
-	lmb_init(lmb);
 	lmb_add(lmb, base, size);
 	lmb_reserve_common(lmb, fdt_blob);
 }
@@ -352,14 +353,14 @@ static long lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
 /* This routine may be called with relocation disabled. */
 long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *_rgn = &(lmb->memory);
+	struct lmb_region *_rgn = &lmb.memory;
 
 	return lmb_add_region(_rgn, base, size);
 }
 
 long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
-	struct lmb_region *rgn = &(lmb->reserved);
+	struct lmb_region *rgn = &lmb.reserved;
 	phys_addr_t rgnbegin, rgnend;
 	phys_addr_t end = base + size - 1;
 	int i;
@@ -410,7 +411,7 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
 		       enum lmb_flags flags)
 {
-	struct lmb_region *_rgn = &(lmb->reserved);
+	struct lmb_region *_rgn = &lmb.reserved;
 
 	return lmb_add_region_flags(_rgn, base, size, flags);
 }
@@ -447,9 +448,9 @@ static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 
-	for (i = lmb->memory.cnt - 1; i >= 0; i--) {
-		phys_addr_t lmbbase = lmb->memory.region[i].base;
-		phys_size_t lmbsize = lmb->memory.region[i].size;
+	for (i = lmb.memory.cnt - 1; i >= 0; i--) {
+		phys_addr_t lmbbase = lmb.memory.region[i].base;
+		phys_size_t lmbsize = lmb.memory.region[i].size;
 
 		if (lmbsize < size)
 			continue;
@@ -465,15 +466,15 @@ static phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size,
 			continue;
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb->reserved, base, size);
+			rgn = lmb_overlaps_region(&lmb.reserved, base, size);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region(&lmb->reserved, base,
+				if (lmb_add_region(&lmb.reserved, base,
 						   size) < 0)
 					return 0;
 				return base;
 			}
-			res_base = lmb->reserved.region[rgn].base;
+			res_base = lmb.reserved.region[rgn].base;
 			if (res_base < size)
 				break;
 			base = lmb_align_down(res_base - size, align);
@@ -509,14 +510,14 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	long rgn;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, base, size);
+	rgn = lmb_overlaps_region(&lmb.memory, base, size);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
 		 * region we found.
 		 */
-		if (lmb_addrs_overlap(lmb->memory.region[rgn].base,
-				      lmb->memory.region[rgn].size,
+		if (lmb_addrs_overlap(lmb.memory.region[rgn].base,
+				      lmb.memory.region[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
 			if (lmb_reserve(lmb, base, size) >= 0)
@@ -533,22 +534,22 @@ phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
 	long rgn;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
+	rgn = lmb_overlaps_region(&lmb.memory, addr, 1);
 	if (rgn >= 0) {
-		for (i = 0; i < lmb->reserved.cnt; i++) {
-			if (addr < lmb->reserved.region[i].base) {
+		for (i = 0; i < lmb.reserved.cnt; i++) {
+			if (addr < lmb.reserved.region[i].base) {
 				/* first reserved range > requested address */
-				return lmb->reserved.region[i].base - addr;
+				return lmb.reserved.region[i].base - addr;
 			}
-			if (lmb->reserved.region[i].base +
-			    lmb->reserved.region[i].size > addr) {
+			if (lmb.reserved.region[i].base +
+			    lmb.reserved.region[i].size > addr) {
 				/* requested addr is in this reserved range */
 				return 0;
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb->memory.region[lmb->memory.cnt - 1].base +
-		       lmb->memory.region[lmb->memory.cnt - 1].size - addr;
+		return lmb.memory.region[lmb.memory.cnt - 1].base +
+		       lmb.memory.region[lmb.memory.cnt - 1].size - addr;
 	}
 	return 0;
 }
@@ -557,11 +558,11 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 {
 	int i;
 
-	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.region[i].base +
-			lmb->reserved.region[i].size - 1;
-		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
-			return (lmb->reserved.region[i].flags & flags) == flags;
+	for (i = 0; i < lmb.reserved.cnt; i++) {
+		phys_addr_t upper = lmb.reserved.region[i].base +
+			lmb.reserved.region[i].size - 1;
+		if ((addr >= lmb.reserved.region[i].base) && (addr <= upper))
+			return (lmb.reserved.region[i].flags & flags) == flags;
 	}
 	return 0;
 }
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 7e4368de22..42551b7c6d 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -76,8 +76,6 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
-	lmb_init(&lmb);
-
 	if (ram0_size) {
 		ret = lmb_add(&lmb, ram0, ram0_size);
 		ut_asserteq(ret, 0);
@@ -237,8 +235,6 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -304,8 +300,6 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
@@ -390,8 +384,6 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	long ret;
 	phys_addr_t a, b;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -429,8 +421,6 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -487,8 +477,6 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -614,8 +602,6 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -684,8 +670,6 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 	struct lmb lmb;
 	int ret, i;
 
-	lmb_init(&lmb);
-
 	ut_asserteq(lmb.memory.cnt, 0);
 	ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -745,8 +729,6 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
-- 
2.34.1

