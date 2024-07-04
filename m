Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF96C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB2F888A4;
	Thu,  4 Jul 2024 09:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F258881D; Thu,  4 Jul 2024 09:36:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id CBE77888B7
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573FB367;
 Thu,  4 Jul 2024 00:37:13 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33A1F3F762;
 Thu,  4 Jul 2024 00:36:44 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 12/48] lmb: allow for resizing lmb regions
Date: Thu,  4 Jul 2024 13:05:08 +0530
Message-Id: <20240704073544.670249-13-sughosh.ganu@linaro.org>
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
Changes since V1:
* Do the check for the region flags in lmb_resize_regions() and
  lmb_merge_overlap_regions() to decide on merging the overlapping
  regions.

 include/lmb.h |   1 +
 lib/lmb.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 069c6af2a3..99fcf5781f 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -20,6 +20,7 @@
 enum lmb_flags {
 	LMB_NONE		= 0x0,
 	LMB_NOMAP		= 0x4,
+	LMB_NOOVERWRITE		= 0x8,
 };
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 0d01e58a46..80945e3cae 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -230,12 +230,88 @@ void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 	lmb_reserve_common(fdt_blob);
 }
 
+static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
+				   enum lmb_flags flags)
+{
+	return rgn->region[r1].flags == flags;
+}
+
+static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
+				      phys_addr_t base, phys_size_t size,
+				      enum lmb_flags flags)
+{
+	phys_size_t rgnsize;
+	unsigned long rgn_cnt, idx;
+	phys_addr_t rgnbase, rgnend;
+	phys_addr_t mergebase, mergeend;
+
+	rgn_cnt = 0;
+	idx = i;
+	/*
+	 * First thing to do is to identify how many regions does
+	 * the requested region overlap.
+	 * If the flags match, combine all these overlapping
+	 * regions into a single region, and remove the merged
+	 * regions.
+	 */
+	while (idx < rgn->cnt - 1) {
+		rgnbase = rgn->region[idx].base;
+		rgnsize = rgn->region[idx].size;
+
+		if (lmb_addrs_overlap(base, size, rgnbase,
+				      rgnsize)) {
+			if (!lmb_region_flags_match(rgn, idx, flags))
+				return -1;
+			rgn_cnt++;
+			idx++;
+		}
+	}
+
+	/* The merged region's base and size */
+	rgnbase = rgn->region[i].base;
+	mergebase = min(base, rgnbase);
+	rgnend = rgn->region[idx].base + rgn->region[idx].size;
+	mergeend = max(rgnend, (base + size));
+
+	rgn->region[i].base = mergebase;
+	rgn->region[i].size = mergeend - mergebase;
+
+	/* Now remove the merged regions */
+	while (--rgn_cnt)
+		lmb_remove_region(rgn, i + 1);
+
+	return 0;
+}
+
+static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
+			       phys_addr_t base, phys_size_t size,
+			       enum lmb_flags flags)
+{
+	long ret = 0;
+	phys_addr_t rgnend;
+
+	if (i == rgn->cnt - 1 ||
+		base + size < rgn->region[i + 1].base) {
+		if (!lmb_region_flags_match(rgn, i, flags))
+			return -1;
+
+		rgnend = rgn->region[i].base + rgn->region[i].size;
+		rgn->region[i].base = min(base, rgn->region[i].base);
+		rgnend = max(base + size, rgnend);
+		rgn->region[i].size = rgnend - rgn->region[i].base;
+	} else {
+		ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
+	}
+
+	return ret;
+}
+
 /* This routine called with relocation disabled. */
 static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
 {
 	unsigned long coalesced = 0;
-	long adjacent, i;
+	long ret, i;
 
 	if (rgn->cnt == 0) {
 		rgn->region[0].base = base;
@@ -260,23 +336,28 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				return -1; /* regions with new flags */
 		}
 
-		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
-		if (adjacent > 0) {
+		ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
+		if (ret > 0) {
 			if (flags != rgnflags)
 				break;
 			rgn->region[i].base -= size;
 			rgn->region[i].size += size;
 			coalesced++;
 			break;
-		} else if (adjacent < 0) {
+		} else if (ret < 0) {
 			if (flags != rgnflags)
 				break;
 			rgn->region[i].size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			/* regions overlap */
-			return -1;
+			ret = lmb_resize_regions(rgn, i, base, size,
+						 flags);
+			if (ret < 0)
+				return -1;
+
+			coalesced++;
+			break;
 		}
 	}
 
@@ -418,7 +499,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 }
 
 static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
-				    phys_addr_t max_addr)
+				    phys_addr_t max_addr, enum lmb_flags flags)
 {
 	long i, rgn;
 	phys_addr_t base = 0;
@@ -468,7 +549,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
 {
 	phys_addr_t alloc;
 
-	alloc = __lmb_alloc_base(size, align, max_addr);
+	alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
 
 	if (alloc == 0)
 		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
@@ -477,11 +558,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
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
 
@@ -496,13 +574,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
 				      lmb->memory.region[rgn].size,
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

