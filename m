Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F93C282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3BAB811B3;
	Mon,  3 Mar 2025 14:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C80281276; Mon,  3 Mar 2025 14:33:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0A520811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85258106F;
 Mon,  3 Mar 2025 05:33:13 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E152D3F673;
 Mon,  3 Mar 2025 05:32:56 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 2/6] lmb: handle scenario of encompassing overlap
Date: Mon,  3 Mar 2025 19:02:27 +0530
Message-Id: <20250303133231.405279-3-sughosh.ganu@linaro.org>
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

The lmb_fix_over_lap_regions() function is called if the added region
overlaps with an existing region. The function then fixes the overlap
and removes the redundant region. However, it makes certain
assumptions. One assumption is that the overlap would not encompass
the existing region. Another assumption is that the overlap only
occurs between two regions -- the scenario of the added region
overlapping multiple existing regions is not being handled. Handle
these cases by instead calling lmb_resize_regions(). Also remove the
now superfluous lmb_fix_over_lap_regions().

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Changes since V2: None

 lib/lmb.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 32c787f8adf..26d9cafef41 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -96,25 +96,6 @@ static void lmb_coalesce_regions(struct alist *lmb_rgn_lst, unsigned long r1,
 	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
-/*Assumption : base addr of region 1 < base addr of region 2*/
-static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
-				     unsigned long r1, unsigned long r2)
-{
-	struct lmb_region *rgn = lmb_rgn_lst->data;
-
-	phys_addr_t base1 = rgn[r1].base;
-	phys_size_t size1 = rgn[r1].size;
-	phys_addr_t base2 = rgn[r2].base;
-	phys_size_t size2 = rgn[r2].size;
-
-	if (base1 + size1 > base2 + size2) {
-		printf("This will not be a case any time\n");
-		return;
-	}
-	rgn[r1].size = base2 + size2 - base1;
-	lmb_remove_region(lmb_rgn_lst, r2);
-}
-
 static long lmb_resize_regions(struct alist *lmb_rgn_lst,
 			       unsigned long idx_start,
 			       phys_addr_t base, phys_size_t size)
@@ -235,8 +216,15 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 				lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
 				coalesced++;
 			} else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
-				/* fix overlapping area */
-				lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
+				/* fix overlapping areas */
+				phys_addr_t rgnbase = rgn[i].base;
+				phys_size_t rgnsize = rgn[i].size;
+
+				ret = lmb_resize_regions(lmb_rgn_lst, i,
+							 rgnbase, rgnsize);
+				if (ret < 0)
+					return -1;
+
 				coalesced++;
 			}
 		}
-- 
2.34.1

