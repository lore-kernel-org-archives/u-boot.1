Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B736CC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 10:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A438E88C52;
	Wed, 21 Aug 2024 12:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C35F88B4C; Wed, 21 Aug 2024 12:59:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BC75A88D96
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 12:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ECA5DA7;
 Wed, 21 Aug 2024 03:59:47 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E24433F73B;
 Wed, 21 Aug 2024 03:59:17 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 06/27] lmb: allow for resizing lmb regions
Date: Wed, 21 Aug 2024 16:28:18 +0530
Message-Id: <20240821105839.2870293-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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

Allow for resizing of LMB regions if the region attributes match. The
current code returns a failure status on detecting an overlapping
address. This worked up until now since the LMB calls were not
persistent and global -- the LMB memory map was specific and private
to a given caller of the LMB API's.

With the change in the LMB code to make the LMB reservations
persistent, there needs to be a check on whether the memory region can
be resized, and then do it if so. To distinguish between memory that
cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
of memory with this attribute would indicate that the region cannot be
resized.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 include/lmb.h |  1 +
 lib/lmb.c     | 98 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 16 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index d352fe9afb..d0f1b65fb6 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -22,6 +22,7 @@
 enum lmb_flags {
 	LMB_NONE		= 0,
 	LMB_NOMAP		= BIT(1),
+	LMB_NOOVERWRITE		= BIT(2),
 };
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 531d151b28..e85ee0a90b 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -246,6 +246,56 @@ void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 	lmb_reserve_common(fdt_blob);
 }
 
+static long lmb_resize_regions(struct alist *lmb_rgn_lst,
+			       unsigned long idx_start,
+			       phys_addr_t base, phys_size_t size)
+{
+	phys_size_t rgnsize;
+	unsigned long rgn_cnt, idx, idx_end;
+	phys_addr_t rgnbase, rgnend;
+	phys_addr_t mergebase, mergeend;
+	struct lmb_region *rgn = lmb_rgn_lst->data;
+
+	rgn_cnt = 0;
+	idx = idx_end = idx_start;
+
+	/*
+	 * First thing to do is to identify how many regions
+	 * the requested region overlaps.
+	 * If the flags match, combine all these overlapping
+	 * regions into a single region, and remove the merged
+	 * regions.
+	 */
+	while (idx <= lmb_rgn_lst->count - 1) {
+		rgnbase = rgn[idx].base;
+		rgnsize = rgn[idx].size;
+
+		if (lmb_addrs_overlap(base, size, rgnbase,
+				      rgnsize)) {
+			if (rgn[idx].flags != LMB_NONE)
+				return -1;
+			rgn_cnt++;
+			idx_end = idx;
+		}
+		idx++;
+	}
+
+	/* The merged region's base and size */
+	rgnbase = rgn[idx_start].base;
+	mergebase = min(base, rgnbase);
+	rgnend = rgn[idx_end].base + rgn[idx_end].size;
+	mergeend = max(rgnend, (base + size));
+
+	rgn[idx_start].base = mergebase;
+	rgn[idx_start].size = mergeend - mergebase;
+
+	/* Now remove the merged regions */
+	while (--rgn_cnt)
+		lmb_remove_region(lmb_rgn_lst, idx_start + 1);
+
+	return 0;
+}
+
 /**
  * lmb_add_region_flags() - Add an lmb region to the given list
  * @lmb_rgn_lst: LMB list to which region is to be added(free/used)
@@ -265,7 +315,7 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
 {
 	unsigned long coalesced = 0;
-	long adjacent, i;
+	long ret, i;
 	struct lmb_region *rgn = lmb_rgn_lst->data;
 
 	if (alist_err(lmb_rgn_lst))
@@ -286,23 +336,32 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				return -1; /* regions with new flags */
 		}
 
-		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
-		if (adjacent > 0) {
+		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
+		if (ret > 0) {
 			if (flags != rgnflags)
 				break;
 			rgn[i].base -= size;
 			rgn[i].size += size;
 			coalesced++;
 			break;
-		} else if (adjacent < 0) {
+		} else if (ret < 0) {
 			if (flags != rgnflags)
 				break;
 			rgn[i].size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			/* regions overlap */
-			return -1;
+			if (flags == LMB_NONE) {
+				ret = lmb_resize_regions(lmb_rgn_lst, i, base,
+							 size);
+				if (ret < 0)
+					return -1;
+
+				coalesced++;
+				break;
+			} else {
+				return -1;
+			}
 		}
 	}
 
@@ -444,7 +503,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 }
 
 static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
-				    phys_addr_t max_addr)
+				    phys_addr_t max_addr, enum lmb_flags flags)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
@@ -473,8 +532,8 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 			rgn = lmb_overlaps_region(&lmb.used_mem, base, size);
 			if (rgn < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region(&lmb.used_mem, base,
-						   size) < 0)
+				if (lmb_add_region_flags(&lmb.used_mem, base,
+							 size, flags) < 0)
 					return 0;
 				return base;
 			}
@@ -497,7 +556,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(size, align, max_addr);
+	alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -506,11 +565,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 	return alloc;
 }
 
-/*
- * Try to allocate a specific address range: must be in defined memory but not
- * reserved
- */
-phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
+static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
+				    enum lmb_flags flags)
 {
 	long rgn;
 	struct lmb_region *lmb_memory = lmb.free_mem.data;
@@ -526,13 +582,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 				      lmb_memory[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
-			if (lmb_reserve(base, size) >= 0)
+			if (lmb_reserve_flags(base, size, flags) >= 0)
 				return base;
 		}
 	}
+
 	return 0;
 }
 
+/*
+ * Try to allocate a specific address range: must be in defined memory but not
+ * reserved
+ */
+phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
+{
+	return __lmb_alloc_addr(base, size, LMB_NONE);
+}
+
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(phys_addr_t addr)
 {
-- 
2.34.1

