Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BBDC71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5983E82BCD;
	Tue, 17 Jun 2025 12:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409AB82C79; Tue, 17 Jun 2025 12:44:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 04DD882BCD
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614D91596;
 Tue, 17 Jun 2025 03:44:02 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 373B93F58B;
 Tue, 17 Jun 2025 03:44:19 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 5/7] lmb: use a single function to check for allocation and
 reservation requests
Date: Tue, 17 Jun 2025 16:13:44 +0530
Message-Id: <20250617104346.1379981-6-sughosh.ganu@linaro.org>
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

The functions that handle allocation requests check if a region of
memory overlaps with a used region. This is done through
lmb_overlaps_region(). Similar checks are done for reservation
requests made to the LMB module, where the caller asks specifically
for a particular region of memory. These checks are being done through
lmb_can_reserve_region().

There are subtle differences in the checking needed for allocation
requests, as against reservation requests. In the former, it is only
needed to be checked if a region is overlapping with an existing
used region, and return as soon as an overlap is found. For
reservation request checks, because U-Boot allows for re-use of in-use
regions with a particular memory attribute, this check has to iterate
through all the regions that might overlap with the requested region,
and then check that the necessary conditions are met to allow for the
overlap.

Combine these two checks in a single function, lmb_overlap_checks() as
both lmb_overlaps_region() and lmb_can_reserve_region() are pretty
similar otherwise.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V4: None

 lib/lmb.c | 84 +++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 4af8dae4359..45b26512a5b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -317,8 +317,34 @@ static long _lmb_free(struct alist *lmb_rgn_lst, phys_addr_t base,
 				    rgn[i].flags);
 }
 
-static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
-				phys_size_t size)
+/**
+ * lmb_overlap_checks() - perform checks to see if region can be allocated or reserved
+ * @lmb_rgn_lst: list of LMB regions
+ * @base: base address of region to be checked
+ * @size: size of region to be checked
+ * @flags: flag of the region to be checked (only for reservation requests)
+ * @alloc: if checks are to be done for allocation or reservation request
+ *
+ * Check if the region passed to the function overlaps with any one of
+ * the regions of the passed lmb region list.
+ *
+ * If the @alloc flag is set to true, this check stops as soon an
+ * overlapping region is found. The function can also be called to
+ * check if a reservation request can be satisfied, by setting
+ * @alloc to false. In that case, the function then iterates through
+ * all the regions in the list passed to ensure that the requested
+ * region does not overlap with any existing regions. An overlap is
+ * allowed only when the flag of the requested region and the existing
+ * region is LMB_NONE.
+ *
+ * Return: index of the overlapping region, -1 if no overlap is found
+ *
+ * When the function is called for a reservation request check, -1 will
+ * also be returned when there is an allowed overlap, i.e. requested
+ * region and existing regions have flags as LMB_NONE.
+ */
+static long lmb_overlap_checks(struct alist *lmb_rgn_lst, phys_addr_t base,
+			       phys_size_t size, u32 flags, bool alloc)
 {
 	unsigned long i;
 	struct lmb_region *rgn = lmb_rgn_lst->data;
@@ -326,9 +352,12 @@ static long lmb_overlaps_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 	for (i = 0; i < lmb_rgn_lst->count; i++) {
 		phys_addr_t rgnbase = rgn[i].base;
 		phys_size_t rgnsize = rgn[i].size;
+		u32 rgnflags = rgn[i].flags;
 
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
-			break;
+		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
+			if (alloc || flags != LMB_NONE || flags != rgnflags)
+				break;
+		}
 	}
 
 	return (i < lmb_rgn_lst->count) ? i : -1;
@@ -390,7 +419,8 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong align)
 		base = ALIGN_DOWN(lmbbase + lmbsize - size, align);
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&io_lmb->used_mem, base, size);
+			rgn = lmb_overlap_checks(&io_lmb->used_mem, base, size,
+						 LMB_NOOVERWRITE, true);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
 				if (lmb_add_region_flags(&io_lmb->used_mem, base,
@@ -488,45 +518,12 @@ void lmb_dump_all(void)
 #endif
 }
 
-/**
- * lmb_can_reserve_region() - check if the region can be reserved
- * @base: base address of region to be reserved
- * @size: size of region to be reserved
- * @flags: flag of the region to be reserved
- *
- * Go through all the reserved regions and ensure that the requested
- * region does not overlap with any existing regions. An overlap is
- * allowed only when the flag of the request region and the existing
- * region is LMB_NONE.
- *
- * Return: true if region can be reserved, false otherwise
- */
-static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
-				   u32 flags)
-{
-	uint i;
-	struct lmb_region *lmb_reserved = lmb.used_mem.data;
-
-	for (i = 0; i < lmb.used_mem.count; i++) {
-		u32 rgnflags = lmb_reserved[i].flags;
-		phys_addr_t rgnbase = lmb_reserved[i].base;
-		phys_size_t rgnsize = lmb_reserved[i].size;
-
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			if (flags != LMB_NONE || flags != rgnflags)
-				return false;
-		}
-	}
-
-	return true;
-}
-
 static long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 {
 	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
-	if (!lmb_can_reserve_region(base, size, flags))
+	if (lmb_overlap_checks(lmb_rgn_lst, base, size, flags, false) != -1)
 		return -EEXIST;
 
 	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
@@ -698,7 +695,8 @@ static int _lmb_alloc_base(phys_size_t size, ulong align,
 		}
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
+			rgn = lmb_overlap_checks(&lmb.used_mem, base, size,
+						 LMB_NOOVERWRITE, true);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
 				if (lmb_add_region_flags(&lmb.used_mem, base,
@@ -733,7 +731,8 @@ static int _lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
 	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb.available_mem, base, size);
+	rgn = lmb_overlap_checks(&lmb.available_mem, base, size,
+				 LMB_NOOVERWRITE, true);
 	if (rgn >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
@@ -786,7 +785,8 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 	struct lmb_region *lmb_memory = lmb.available_mem.data;
 
 	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb.available_mem, addr, 1);
+	rgn = lmb_overlap_checks(&lmb.available_mem, addr, 1, LMB_NOOVERWRITE,
+				 true);
 	if (rgn >= 0) {
 		for (i = 0; i < lmb.used_mem.count; i++) {
 			if (addr < lmb_used[i].base) {
-- 
2.34.1

