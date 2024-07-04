Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B5C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4590888DE;
	Thu,  4 Jul 2024 09:36:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF6E888B7; Thu,  4 Jul 2024 09:36:40 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9850C8888D
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25905367;
 Thu,  4 Jul 2024 00:37:02 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B5A3F762;
 Thu,  4 Jul 2024 00:36:33 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 09/48] lmb: remove call to lmb_init()
Date: Thu,  4 Jul 2024 13:05:05 +0530
Message-Id: <20240704073544.670249-10-sughosh.ganu@linaro.org>
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

The LMB module will be changed to have persistent and global memory
maps of available and used memory. With this change, there won't be
any need to explicitly initialise the LMB memory maps. Remove the call
to the lmb_init() function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 arch/arm/mach-stm32mp/dram_init.c |  1 -
 board/xilinx/common/board.c       |  1 -
 drivers/iommu/apple_dart.c        |  1 -
 drivers/iommu/sandbox_iommu.c     |  1 -
 include/lmb.h                     |  1 -
 lib/lmb.c                         | 18 ------------------
 test/lib/lmb.c                    | 18 ------------------
 7 files changed, 41 deletions(-)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index 6024959b97..a5437e4e55 100644
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
index 0b43407b9e..61dc37964d 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -684,7 +684,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
 
 	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_init(&lmb);
 	lmb_add(&lmb, gd->ram_base, gd->ram_size);
 	boot_fdt_add_mem_rsv_regions(&lmb, (void *)gd->fdt_blob);
 	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
diff --git a/drivers/iommu/apple_dart.c b/drivers/iommu/apple_dart.c
index 9327dea1e3..3e59490973 100644
--- a/drivers/iommu/apple_dart.c
+++ b/drivers/iommu/apple_dart.c
@@ -213,7 +213,6 @@ static int apple_dart_probe(struct udevice *dev)
 	priv->dvabase = DART_PAGE_SIZE;
 	priv->dvaend = SZ_4G - DART_PAGE_SIZE;
 
-	lmb_init(&priv->lmb);
 	lmb_add(&priv->lmb, priv->dvabase, priv->dvaend - priv->dvabase);
 
 	/* Disable translations. */
diff --git a/drivers/iommu/sandbox_iommu.c b/drivers/iommu/sandbox_iommu.c
index e37976f86f..3184b3a64e 100644
--- a/drivers/iommu/sandbox_iommu.c
+++ b/drivers/iommu/sandbox_iommu.c
@@ -54,7 +54,6 @@ static int sandbox_iommu_probe(struct udevice *dev)
 {
 	struct sandbox_iommu_priv *priv = dev_get_priv(dev);
 
-	lmb_init(&priv->lmb);
 	lmb_add(&priv->lmb, 0x89abc000, SZ_16K);
 
 	return 0;
diff --git a/include/lmb.h b/include/lmb.h
index 7b87181b9e..20d6feebf5 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -92,7 +92,6 @@ struct lmb {
 #endif
 };
 
-void lmb_init(struct lmb *lmb);
 void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob);
 void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 				phys_size_t size, void *fdt_blob);
diff --git a/lib/lmb.c b/lib/lmb.c
index 4d39c0d1f9..0141da9766 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -130,21 +130,6 @@ static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
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
@@ -231,8 +216,6 @@ void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob)
 {
 	int i;
 
-	lmb_init(lmb);
-
 	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
 		if (bd->bi_dram[i].size) {
 			lmb_add(lmb, bd->bi_dram[i].start,
@@ -247,7 +230,6 @@ void lmb_init_and_reserve(struct lmb *lmb, struct bd_info *bd, void *fdt_blob)
 void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 				phys_size_t size, void *fdt_blob)
 {
-	lmb_init(lmb);
 	lmb_add(lmb, base, size);
 	lmb_reserve_common(lmb, fdt_blob);
 }
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 4b5b6e5e20..74e74501cf 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -75,8 +75,6 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
-	lmb_init(&lmb);
-
 	if (ram0_size) {
 		ret = lmb_add(&lmb, ram0, ram0_size);
 		ut_asserteq(ret, 0);
@@ -236,8 +234,6 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -303,8 +299,6 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
@@ -389,8 +383,6 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	long ret;
 	phys_addr_t a, b;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -428,8 +420,6 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -486,8 +476,6 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -613,8 +601,6 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
@@ -683,8 +669,6 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 	struct lmb lmb;
 	int ret, i;
 
-	lmb_init(&lmb);
-
 	ut_asserteq(lmb.memory.cnt, 0);
 	ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -744,8 +728,6 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	struct lmb lmb;
 	long ret;
 
-	lmb_init(&lmb);
-
 	ret = lmb_add(&lmb, ram, ram_size);
 	ut_asserteq(ret, 0);
 
-- 
2.34.1

