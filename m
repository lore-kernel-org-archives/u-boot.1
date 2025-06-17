Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C900C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9F882CCE;
	Tue, 17 Jun 2025 12:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00AB82BCD; Tue, 17 Jun 2025 12:44:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 31C7782C79
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3C61596;
 Tue, 17 Jun 2025 03:43:58 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A1E3F58B;
 Tue, 17 Jun 2025 03:44:16 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 4/7] lmb: use a single function to free up memory
Date: Tue, 17 Jun 2025 16:13:43 +0530
Message-Id: <20250617104346.1379981-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
References: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
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

There is no need to have two separate API's for freeing up memory. Use
a single API lmb_free() to achieve this.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V4: None

 boot/image-fdt.c            |  2 +-
 cmd/load.c                  |  2 +-
 include/lmb.h               |  6 ++---
 lib/efi_loader/efi_memory.c |  6 ++---
 lib/lmb.c                   |  8 +-----
 test/lib/lmb.c              | 49 +++++++++++++++++++------------------
 6 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 2720ce6f6f3..97b6385ab7c 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -690,7 +690,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 
 	/* Delete the old LMB reservation */
 	if (CONFIG_IS_ENABLED(LMB) && lmb)
-		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob));
+		lmb_free(map_to_sysmem(blob), fdt_totalsize(blob), LMB_NONE);
 
 	ret = fdt_shrink_to_minimum(blob, 0);
 	if (ret < 0)
diff --git a/cmd/load.c b/cmd/load.c
index a6e54fc668c..159767aa7f7 100644
--- a/cmd/load.c
+++ b/cmd/load.c
@@ -191,7 +191,7 @@ static ulong load_serial(long offset)
 			dst = map_sysmem(dst_addr, binlen);
 			memcpy(dst, binbuf, binlen);
 			unmap_sysmem(dst);
-			lmb_free(dst_addr, binlen);
+			lmb_free(dst_addr, binlen, LMB_NONE);
 		    }
 		    if ((store_addr) < start_addr)
 			start_addr = store_addr;
diff --git a/include/lmb.h b/include/lmb.h
index aead799d555..5d5f037ccb9 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -142,16 +142,14 @@ phys_size_t lmb_get_free_size(phys_addr_t addr);
 int lmb_is_reserved_flags(phys_addr_t addr, int flags);
 
 /**
- * lmb_free_flags() - Free up a region of memory
+ * lmb_free() - Free up a region of memory
  * @base: Base Address of region to be freed
  * @size: Size of the region to be freed
  * @flags: Memory region attributes
  *
  * Return: 0 on success, negative error code on failure.
  */
-long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
-
-long lmb_free(phys_addr_t base, phys_size_t size);
+long lmb_free(phys_addr_t base, phys_size_t size, u32 flags);
 
 void lmb_dump_all(void);
 void lmb_dump_all_force(void);
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 466f45c98b1..0828a47da61 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -508,7 +508,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 	ret = efi_update_memory_map(efi_addr, pages, memory_type, true, false);
 	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
-		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
+		lmb_free(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
 		unmap_sysmem((void *)(uintptr_t)efi_addr);
 		return  EFI_OUT_OF_RESOURCES;
 	}
@@ -548,8 +548,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	 * been mapped with map_sysmem() from efi_allocate_pages(). Convert
 	 * it back to an address LMB understands
 	 */
-	status = lmb_free_flags(map_to_sysmem((void *)(uintptr_t)memory), len,
-				LMB_NOOVERWRITE);
+	status = lmb_free(map_to_sysmem((void *)(uintptr_t)memory), len,
+			  LMB_NOOVERWRITE);
 	if (status)
 		return EFI_NOT_FOUND;
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 3265fad317d..4af8dae4359 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -655,8 +655,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_map_update_notify(base, size, LMB_MAP_OP_ADD, LMB_NONE);
 }
 
-long lmb_free_flags(phys_addr_t base, phys_size_t size,
-		    uint flags)
+long lmb_free(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long ret;
 
@@ -667,11 +666,6 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size,
 	return lmb_map_update_notify(base, size, LMB_MAP_OP_FREE, flags);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
-{
-	return lmb_free_flags(base, size, LMB_NONE);
-}
-
 static int _lmb_alloc_base(phys_size_t size, ulong align,
 			   phys_addr_t *addr, u32 flags)
 {
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index d8eab96527a..b6259bef442 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -182,7 +182,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
 
-	ret = lmb_free(a, 4);
+	ret = lmb_free(a, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
@@ -191,12 +191,12 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(a, a2);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
-	ret = lmb_free(a2, 4);
+	ret = lmb_free(a2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 
-	ret = lmb_free(b, 4);
+	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
@@ -206,17 +206,17 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(b, b2);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
-	ret = lmb_free(b2, 4);
+	ret = lmb_free(b2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 
-	ret = lmb_free(c, 4);
+	ret = lmb_free(c, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000, 0, 0);
-	ret = lmb_free(d, 4);
+	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -320,7 +320,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 
-	ret = lmb_free(a, big_block_size);
+	ret = lmb_free(a, big_block_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
@@ -392,12 +392,12 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 			   - alloc_size_aligned, alloc_size, 0, 0);
 	}
 	/* and free them */
-	ret = lmb_free(b, alloc_size);
+	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
 		   ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
-	ret = lmb_free(a, alloc_size);
+	ret = lmb_free(a, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -408,7 +408,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 		   ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* and free it */
-	ret = lmb_free(b, alloc_size);
+	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -476,12 +476,12 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* check that this was an error by freeing b */
-	ret = lmb_free(b, 4);
+	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, -1);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(a, ram_size - 4);
+	ret = lmb_free(a, ram_size - 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
@@ -612,7 +612,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(b, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x2000, LMB_NONE);
 	ut_asserteq(b, 0);
-	ret = lmb_free(alloc_addr_a, 0x2000);
+	ret = lmb_free(alloc_addr_a, 0x2000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, 0);
@@ -620,7 +620,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(b, -EEXIST);
 	b = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(b, -EEXIST);
-	ret = lmb_free(alloc_addr_a, 0x1000);
+	ret = lmb_free(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/*
@@ -642,9 +642,9 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
-	ret = lmb_free(alloc_addr_a, 0x1000);
+	ret = lmb_free(alloc_addr_a, 0x1000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000);
+	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(ret, 0);
 
 	/*
@@ -667,7 +667,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_addr_a, 0x6000,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(alloc_addr_a, 0x6000);
+	ret = lmb_free(alloc_addr_a, 0x6000, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/*
@@ -689,9 +689,9 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
 		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
-	ret = lmb_free(alloc_addr_a, 0x1000);
+	ret = lmb_free(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(ret, 0);
-	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000);
+	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
@@ -732,7 +732,8 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   0, 0, 0, 0);
 
 	/* free thge allocation from d */
-	ret = lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x10000);
+	ret = lmb_free(alloc_addr_c + 0x10000, ram_end - alloc_addr_c - 0x10000,
+		       LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* allocate at 3 points in free range */
@@ -741,7 +742,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   ram_end - 4, 4, 0, 0);
-	ret = lmb_free(ram_end - 4, 4);
+	ret = lmb_free(ram_end - 4, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
@@ -750,7 +751,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   ram_end - 128, 4, 0, 0);
-	ret = lmb_free(ram_end - 128, 4);
+	ret = lmb_free(ram_end - 128, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
@@ -759,13 +760,13 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(d, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
-	ret = lmb_free(alloc_addr_c + 0x10000, 4);
+	ret = lmb_free(alloc_addr_c + 0x10000, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	/* allocate at the bottom a was assigned to ram at the top */
-	ret = lmb_free(ram, alloc_addr_a - ram);
+	ret = lmb_free(ram, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
 		   0x10010000, 0, 0, 0, 0);
-- 
2.34.1

