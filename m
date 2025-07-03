Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB3BC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 13:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4A9182063;
	Thu,  3 Jul 2025 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cDJJC5N5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ACDC82F7F; Thu,  3 Jul 2025 15:36:26 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9C6382F00
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 15:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 563DaLmO3550471;
 Thu, 3 Jul 2025 08:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751549781;
 bh=tZV4bilyIJZoK1TEWaM0mrpSK+/og5DxafUgMq152sI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=cDJJC5N5IJ+tsHJk7X09OJ3VtMab+uxWsSVdxyWG+XlfNqsSAGCPmwBa/80m/85QS
 SlKv+Zo9HctZKeTifGCg8yQHdDoem1YRWjxXGP/KeehhOkALSp82Vlg/PGVXBUXA7/
 1szmoAePcHbSQH+RQLuY9NeT/jG3dwanIaqtrLMY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 563DaL76777773
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 3 Jul 2025 08:36:21 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 3
 Jul 2025 08:36:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 3 Jul 2025 08:36:21 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 563DaKBV912262;
 Thu, 3 Jul 2025 08:36:20 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <nm@ti.com>, <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 2/4] mach-k3: add runtime configuration of MMU table
Date: Thu, 3 Jul 2025 19:05:27 +0530
Message-ID: <20250703133533.104758-3-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703133533.104758-1-anshuld@ti.com>
References: <20250703133533.104758-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

k3_mem_map is used by u-boot to configure the MMU on k3 devices but
currently it's a static array which does not scale for platforms with
non-standard load addresses for ATF and OP-TEE. Additionally on systems
with limited DRAM, more space is mapped than is available on the device.

Therefore this patch adds a new k3_mem_map_init function which can
be called from dram_init to configure the table at runtime where we
can query the required DDR information and reserved regions from the
device-tree.

A dummy implementation is also added in r5/common.c to allow the build
to pass without masking each call to k3_mem_map_init behind an ifdef
CONFIG_ARM64.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/arm64/arm64-mmu.c     | 133 +++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/k3-ddr.h |   1 +
 arch/arm/mach-k3/r5/common.c           |   5 +
 board/ti/common/k3-ddr.c               |   9 +-
 4 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/arm64/arm64-mmu.c b/arch/arm/mach-k3/arm64/arm64-mmu.c
index 5c29df4fe6f..49dd6fcb23b 100644
--- a/arch/arm/mach-k3/arm64/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64/arm64-mmu.c
@@ -11,6 +11,9 @@
 
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
+#include <mach/k3-ddr.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /* We need extra 5 entries for:
  * SoC peripherals, flash, atf-carveout, tee-carveout and the sentinel value.
@@ -44,3 +47,133 @@ struct mm_region k3_mem_map[K3_MMU_REGIONS_COUNT] = {
 };
 
 struct mm_region *mem_map = k3_mem_map;
+
+static void k3_mmu_add_cachable_entry(u64 start, u64 end, unsigned int *map_idx)
+{
+	if (start >= end)
+		return;
+
+	k3_mem_map[*map_idx].virt = start,
+	k3_mem_map[*map_idx].phys = start,
+	k3_mem_map[*map_idx].size = end - start,
+	k3_mem_map[*map_idx].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+				     PTE_BLOCK_INNER_SHARE;
+	(*map_idx)++;
+}
+
+/* It is assumed that if ATF and OPTEE are loaded in DDR, they are loaded to
+ * first bank only
+ */
+static int k3_setup_first_mem_bank(unsigned int *map_idx)
+{
+	struct fdt_resource mem, atf, tee, rsvd1, rsvd2;
+	void *fdt = (void *)gd->fdt_blob;
+	fdt_size_t size;
+	int ret = 0;
+
+	mem.start = gd->ram_base;
+	mem.end = mem.start + gd->ram_size;
+
+	atf.start = CONFIG_K3_ATF_LOAD_ADDR;
+	ret = fdt_path_offset(fdt, "/reserved-memory/tfa");
+	if (ret < 0)
+		return ret;
+	fdtdec_get_addr_size(fdt, ret, "reg", &size);
+	atf.end = atf.start + size;
+
+	tee.start = CONFIG_K3_OPTEE_LOAD_ADDR;
+	ret = fdt_path_offset(fdt, "/reserved-memory/optee");
+	if (ret < 0)
+		return ret;
+	fdtdec_get_addr_size(fdt, ret, "reg", &size);
+	tee.end = tee.start + size;
+
+	/* set reserved region lower in ddr as rsvd1 and other as rsvd2 */
+	if (atf.start < tee.start)
+		rsvd1 = atf, rsvd2 = tee;
+	else
+		rsvd1 = tee, rsvd2 = atf;
+
+	if (rsvd2.start < mem.start) {
+		/* both reserved regions lie outside DDR */
+		k3_mmu_add_cachable_entry(mem.start, mem.end, map_idx);
+		return 0;
+	}
+
+	if (rsvd1.start >= mem.start) {
+		k3_mmu_add_cachable_entry(mem.start, rsvd1.start, map_idx);
+		k3_mmu_add_cachable_entry(rsvd1.end, rsvd2.start, map_idx);
+	} else {
+		k3_mmu_add_cachable_entry(mem.start, rsvd2.start, map_idx);
+	}
+
+	k3_mmu_add_cachable_entry(rsvd2.end, mem.end, map_idx);
+
+	return 0;
+}
+
+static int k3_setup_extra_mem_banks(unsigned int *map_idx)
+{
+	unsigned int bank;
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+
+	for (bank = 1; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		k3_mmu_add_cachable_entry(gd->bd->bi_dram[bank].start,
+					  gd->bd->bi_dram[bank].start +
+						  gd->bd->bi_dram[bank].size,
+					  map_idx);
+	}
+
+	return 0;
+}
+
+static int k3_uboot_mem_map_init(unsigned int *map_idx)
+{
+	int ret;
+
+	/* Overwrite the 128MiB SPL entry */
+	(*map_idx)--;
+
+	ret = k3_setup_first_mem_bank(map_idx);
+	if (ret)
+		return ret;
+
+	if (CONFIG_NR_DRAM_BANKS > 1)
+		ret = k3_setup_extra_mem_banks(map_idx);
+
+	return ret;
+}
+
+int k3_mem_map_init(void)
+{
+	int ret = 0;
+	unsigned int map_idx, i;
+
+	for (i = 0; i < K3_MMU_REGIONS_COUNT; i++)
+		if (k3_mem_map[i].virt == CONFIG_SPL_TEXT_BASE)
+			map_idx = i;
+
+	map_idx++;
+
+	ret = k3_uboot_mem_map_init(&map_idx);
+	if (ret)
+		return ret;
+
+	k3_mem_map[map_idx] = (const struct mm_region){ 0 };
+
+	debug("%s: MMU Table configured as:\n", __func__);
+	debug("   |virt start\t\t|virt end\t|phys\t\t|size\t\t|attrs:\n");
+	for (i = 0; i < map_idx; i++) {
+		debug("%2d: 0x%-12llx\t0x%-12llx\t0x%-12llx\t0x%-12llx\t0x%llx\n",
+		      i, k3_mem_map[i].virt,
+		      k3_mem_map[i].virt + k3_mem_map[i].size,
+		      k3_mem_map[i].phys, k3_mem_map[i].size,
+		      k3_mem_map[i].attrs);
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 39e6725bb9b..b3ca6adb6c7 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -13,5 +13,6 @@ int dram_init_banksize(void);
 
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
+int k3_mem_map_init(void);
 
 #endif /* _K3_DDR_H_ */
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 0b6604039f3..2d9849efb46 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -136,6 +136,11 @@ void release_resources_for_core_shutdown(void)
 	}
 }
 
+__weak int k3_mem_map_init(void)
+{
+	return 0;
+}
+
 void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	typedef void __noreturn (*image_entry_noargs_t)(void);
diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
index a8425da8de5..54242734ac9 100644
--- a/board/ti/common/k3-ddr.c
+++ b/board/ti/common/k3-ddr.c
@@ -7,6 +7,7 @@
 #include <dm/uclass.h>
 #include <k3-ddrss.h>
 #include <spl.h>
+#include <mach/k3-ddr.h>
 
 #include "k3-ddr.h"
 
@@ -15,8 +16,14 @@ int dram_init(void)
 	s32 ret;
 
 	ret = fdtdec_setup_mem_size_base_lowest();
-	if (ret)
+	if (ret) {
 		printf("Error setting up mem size and base. %d\n", ret);
+		return ret;
+	}
+
+	ret = k3_mem_map_init();
+	if (ret)
+		printf("Error setting up MMU table. %d\n", ret);
 
 	return ret;
 }
-- 
2.49.0

