Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE76C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4409812BB;
	Mon,  3 Mar 2025 14:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9642481280; Mon,  3 Mar 2025 14:33:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 51B67811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC730106F;
 Mon,  3 Mar 2025 05:33:22 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3412B3F673;
 Mon,  3 Mar 2025 05:33:05 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 5/6] lmb: use a common function to check if regions overlap
 or are adjacent
Date: Mon,  3 Mar 2025 19:02:30 +0530
Message-Id: <20250303133231.405279-6-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303133231.405279-1-sughosh.ganu@linaro.org>
References: <20250303133231.405279-1-sughosh.ganu@linaro.org>
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

The functions to check if the two said regions are adjacent or overlap
are pretty similar in nature. Club the functionality into a single
function lmb_regions_check() and return the appropriate return value
to signify this aspect.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 lib/lmb.c | 71 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 9af942c6b42..b42a512f6c0 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -23,6 +23,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define LMB_RGN_OVERLAP		1
+#define LMB_RGN_ADJACENT	2
+
 /*
  * The following low level LMB functions must not access the global LMB memory
  * map since they are also used to manage IOVA memory maps in iommu drivers like
@@ -49,8 +52,22 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
-				unsigned long r2)
+/**
+ * lmb_regions_check() - Check if the regions overlap, or are adjacent
+ * @lmb_rgn_lst: List of LMB regions
+ * @r1: First region to check
+ * @r2: Second region to check
+ *
+ * Check if the two regions with matching flags, r1 and r2 are
+ * adjacent to each other, or if they overlap.
+ *
+ * Return:
+ * * %LMB_RGN_OVERLAP	- Regions overlap
+ * * %LMB_RGN_ADJACENT	- Regions adjacent to each other
+ * * 0			- Neither of the above, or flags mismatch
+ */
+static long lmb_regions_check(struct alist *lmb_rgn_lst, unsigned long r1,
+			      unsigned long r2)
 {
 	struct lmb_region *rgn = lmb_rgn_lst->data;
 	phys_addr_t base1 = rgn[r1].base;
@@ -58,19 +75,15 @@ static long lmb_regions_overlap(struct alist *lmb_rgn_lst, unsigned long r1,
 	phys_addr_t base2 = rgn[r2].base;
 	phys_size_t size2 = rgn[r2].size;
 
-	return lmb_addrs_overlap(base1, size1, base2, size2);
-}
+	if (rgn[r1].flags != rgn[r2].flags)
+		return 0;
 
-static long lmb_regions_adjacent(struct alist *lmb_rgn_lst, unsigned long r1,
-				 unsigned long r2)
-{
-	struct lmb_region *rgn = lmb_rgn_lst->data;
-	phys_addr_t base1 = rgn[r1].base;
-	phys_size_t size1 = rgn[r1].size;
-	phys_addr_t base2 = rgn[r2].base;
-	phys_size_t size2 = rgn[r2].size;
+	if (lmb_addrs_overlap(base1, size1, base2, size2))
+		return LMB_RGN_OVERLAP;
+	else if (lmb_addrs_adjacent(base1, size1, base2, size2))
+		return LMB_RGN_ADJACENT;
 
-	return lmb_addrs_adjacent(base1, size1, base2, size2);
+	return 0;
 }
 
 static void lmb_remove_region(struct alist *lmb_rgn_lst, unsigned long r)
@@ -207,23 +220,21 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 	}
 
 	if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
-		rgn = lmb_rgn_lst->data;
-		if (rgn[i].flags == rgn[i + 1].flags) {
-			if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
-				lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
-				coalesced++;
-			} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
-				/* fix overlapping areas */
-				phys_addr_t rgnbase = rgn[i].base;
-				phys_size_t rgnsize = rgn[i].size;
-
-				ret = lmb_resize_regions(lmb_rgn_lst, i,
-							 rgnbase, rgnsize);
-				if (ret < 0)
-					return -1;
-
-				coalesced++;
-			}
+		ret = lmb_regions_check(lmb_rgn_lst, i, i + 1);
+		if (ret == LMB_RGN_ADJACENT) {
+			lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
+			coalesced++;
+		} else if (ret == LMB_RGN_OVERLAP) {
+			/* fix overlapping areas */
+			phys_addr_t rgnbase = rgn[i].base;
+			phys_size_t rgnsize = rgn[i].size;
+
+			ret = lmb_resize_regions(lmb_rgn_lst, i,
+						 rgnbase, rgnsize);
+			if (ret < 0)
+				return -1;
+
+			coalesced++;
 		}
 	}
 
-- 
2.34.1

