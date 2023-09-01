Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB45ECA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:15:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA72786759;
	Fri,  1 Sep 2023 03:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BwwIFyy4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77174867C3; Fri,  1 Sep 2023 03:14:22 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBF486828
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34dea77cbe6so4385905ab.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530856; x=1694135656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YelQpbFRlcfXmtzfBfCs7079y14zizLqjBoM2IqmMA0=;
 b=BwwIFyy4XkBSRZEr23u/dnIkEfLA3qdawY4TMi2Qf4PjY7kNR7eInbubBZBvSaMny9
 qSaIu1F6uvByn5qo4m0uSCG6h9WWC+Xk0IyfZRe9H9jB1CL70XPYvNTCYAiWrmBEuUPL
 RroizhNYBrDIvdCHGE22rMvuRX0FBczFK5C/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530856; x=1694135656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YelQpbFRlcfXmtzfBfCs7079y14zizLqjBoM2IqmMA0=;
 b=dQsIbYiGbtJZibBECuVKKwWk6K96Jd+7x5NkO45Zlm8mN5t7hCzCRChcad3c0RwUDp
 OCg+jZ5WGDVEvSQ7pcDXA58fi+WeszUBASa0YdoqItWR1Xw9TGRySUegeVOWhvxzLSI7
 4uU62/n5Ex0FDeJ9Rk1veGUg3PX1NuNTPuAalOdyUH3I03qxcf4nckh3dp3KdX8sY/1M
 9HG9r6R5f1uRbY3wM9v004goQzrpkn4TIcxqC+nqha8cQeBY7R7AmbkEvkZML5/HhSY6
 K1fEIeme+Wu+ZdbyxGsDPBZ5PcCJIPLVXKAjubQv4jS/V/U+LmZ5QzLP+lzernRdE4dq
 +sHg==
X-Gm-Message-State: AOJu0YwriER/9kdKV2s23EjyK4PUUGKgTDcWpikSCL0pIgEWzDwmYBKr
 RRYaWel3+6h8dOCVCN2Ilgvhtlb6Ay1OcAYVtvI=
X-Google-Smtp-Source: AGHT+IGEhgIte5Bt4QbEyVwVUjYdmWiJo9E1B/JXBZrRuohST3hHlkmN1ioiJs+fflpn1Jh1QUOY/Q==
X-Received: by 2002:a05:6e02:d42:b0:349:8811:fc51 with SMTP id
 h2-20020a056e020d4200b003498811fc51mr1143612ilj.20.1693530856572; 
 Thu, 31 Aug 2023 18:14:16 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 08/14] lmb: Update use of region in the C file
Date: Thu, 31 Aug 2023 19:13:46 -0600
Message-ID: <20230901011357.2482203-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230901011357.2482203-1-sjg@chromium.org>
References: <20230901011357.2482203-1-sjg@chromium.org>
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

Change places that should say area to do so. Change the name of the 'rgn'
variable to 'area' in places where it refers to an area number.

Fix the 'beginging' typo while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to update use of region in the C file

 lib/lmb.c | 126 +++++++++++++++++++++++++++---------------------------
 1 file changed, 62 insertions(+), 64 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 6061c6f361c6..0b03cc4d1c23 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -74,22 +74,21 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
-static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
-				 unsigned long r2)
+static long lmb_areas_adjacent(struct lmb_region *rgn, ulong a1, ulong a2)
 {
-	phys_addr_t base1 = rgn->area[r1].base;
-	phys_size_t size1 = rgn->area[r1].size;
-	phys_addr_t base2 = rgn->area[r2].base;
-	phys_size_t size2 = rgn->area[r2].size;
+	phys_addr_t base1 = rgn->area[a1].base;
+	phys_size_t size1 = rgn->area[a1].size;
+	phys_addr_t base2 = rgn->area[a2].base;
+	phys_size_t size2 = rgn->area[a2].size;
 
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
-static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
+static void lmb_remove_area(struct lmb_region *rgn, unsigned long area)
 {
 	unsigned long i;
 
-	for (i = r; i < rgn->cnt - 1; i++) {
+	for (i = area; i < rgn->cnt - 1; i++) {
 		rgn->area[i].base = rgn->area[i + 1].base;
 		rgn->area[i].size = rgn->area[i + 1].size;
 		rgn->area[i].flags = rgn->area[i + 1].flags;
@@ -97,12 +96,11 @@ static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 	rgn->cnt--;
 }
 
-/* Assumption: base addr of region 1 < base addr of region 2 */
-static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
-				 unsigned long r2)
+/* Assumption: base addr of area 1 < base addr of area 2 */
+static void lmb_coalesce_areas(struct lmb_region *rgn, uint a1, uint a2)
 {
-	rgn->area[r1].size += rgn->area[r2].size;
-	lmb_remove_region(rgn, r2);
+	rgn->area[a1].size += rgn->area[a2].size;
+	lmb_remove_area(rgn, a2);
 }
 
 void lmb_init(struct lmb *lmb)
@@ -228,8 +226,8 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
 }
 
 /* This routine called with relocation disabled. */
-static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
-				 phys_size_t size, enum lmb_flags flags)
+static long lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
+			       phys_size_t size, enum lmb_flags flags)
 {
 	unsigned long coalesced = 0;
 	long adjacent, i;
@@ -244,43 +242,43 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 
 	/* First try and coalesce this LMB with another. */
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->area[i].base;
-		phys_size_t rgnsize = rgn->area[i].size;
-		phys_size_t rgnflags = rgn->area[i].flags;
+		phys_addr_t abase = rgn->area[i].base;
+		phys_size_t asize = rgn->area[i].size;
+		phys_size_t aflags = rgn->area[i].flags;
 		phys_addr_t end = base + size - 1;
-		phys_addr_t rgnend = rgnbase + rgnsize - 1;
+		phys_addr_t rgnend = abase + asize - 1;
 
-		if (rgnbase <= base && end <= rgnend) {
-			if (flags == rgnflags)
-				/* Already have this region, so we're done */
+		if (abase <= base && end <= rgnend) {
+			if (flags == aflags)
+				/* Already have this area, so we're done */
 				return 0;
 			else
-				return -1; /* regions with new flags */
+				return -1; /* areas with new flags */
 		}
 
-		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
+		adjacent = lmb_addrs_adjacent(base, size, abase, asize);
 		if (adjacent > 0) {
-			if (flags != rgnflags)
+			if (flags != aflags)
 				break;
 			rgn->area[i].base -= size;
 			rgn->area[i].size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
-			if (flags != rgnflags)
+			if (flags != aflags)
 				break;
 			rgn->area[i].size += size;
 			coalesced++;
 			break;
-		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			/* regions overlap */
+		} else if (lmb_addrs_overlap(base, size, abase, asize)) {
+			/* areas overlap */
 			return -1;
 		}
 	}
 
-	if (i < rgn->cnt - 1 && lmb_regions_adjacent(rgn, i, i + 1)) {
+	if (i < rgn->cnt - 1 && lmb_areas_adjacent(rgn, i, i + 1)) {
 		if (rgn->area[i].flags == rgn->area[i + 1].flags) {
-			lmb_coalesce_regions(rgn, i, i + 1);
+			lmb_coalesce_areas(rgn, i, i + 1);
 			coalesced++;
 		}
 	}
@@ -315,10 +313,10 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	return 0;
 }
 
-static long lmb_add_region(struct lmb_region *rgn, phys_addr_t base,
-			   phys_size_t size)
+static long lmb_add_area(struct lmb_region *rgn, phys_addr_t base,
+			 phys_size_t size)
 {
-	return lmb_add_region_flags(rgn, base, size, LMB_NONE);
+	return lmb_add_area_flags(rgn, base, size, LMB_NONE);
 }
 
 /* This routine may be called with relocation disabled. */
@@ -326,7 +324,7 @@ long lmb_add(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *_rgn = &(lmb->memory);
 
-	return lmb_add_region(_rgn, base, size);
+	return lmb_add_area(_rgn, base, size);
 }
 
 long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
@@ -338,7 +336,7 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 
 	rgnbegin = rgnend = 0; /* supress gcc warnings */
 
-	/* Find the region where (base, size) belongs to */
+	/* Find the area where (base, size) belongs to */
 	for (i = 0; i < rgn->cnt; i++) {
 		rgnbegin = rgn->area[i].base;
 		rgnend = rgnbegin + rgn->area[i].size - 1;
@@ -347,24 +345,24 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 			break;
 	}
 
-	/* Didn't find the region */
+	/* Didn't find the area */
 	if (i == rgn->cnt)
 		return -1;
 
-	/* Check to see if we are removing entire region */
+	/* Check to see if we are removing entire area */
 	if ((rgnbegin == base) && (rgnend == end)) {
-		lmb_remove_region(rgn, i);
+		lmb_remove_area(rgn, i);
 		return 0;
 	}
 
-	/* Check to see if region is matching at the front */
+	/* Check to see if areaz is matching at the front */
 	if (rgnbegin == base) {
 		rgn->area[i].base = end + 1;
 		rgn->area[i].size -= size;
 		return 0;
 	}
 
-	/* Check to see if the region is matching at the end */
+	/* Check to see if the area is matching at the end */
 	if (rgnend == end) {
 		rgn->area[i].size -= size;
 		return 0;
@@ -372,11 +370,11 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 
 	/*
 	 * We need to split the entry -  adjust the current one to the
-	 * beginging of the hole and add the region after hole.
+	 * beginning of the hole and add the area after hole.
 	 */
 	rgn->area[i].size = base - rgn->area[i].base;
 
-	return lmb_add_region_flags(rgn, end + 1, rgnend - end,
+	return lmb_add_area_flags(rgn, end + 1, rgnend - end,
 				    rgn->area[i].flags);
 }
 
@@ -385,7 +383,7 @@ long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
 {
 	struct lmb_region *_rgn = &(lmb->reserved);
 
-	return lmb_add_region_flags(_rgn, base, size, flags);
+	return lmb_add_area_flags(_rgn, base, size, flags);
 }
 
 long lmb_reserve(struct lmb *lmb, phys_addr_t base, phys_size_t size)
@@ -399,9 +397,10 @@ static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 	unsigned long i;
 
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->area[i].base;
-		phys_size_t rgnsize = rgn->area[i].size;
-		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
+		phys_addr_t abase = rgn->area[i].base;
+		phys_size_t asize = rgn->area[i].size;
+
+		if (lmb_addrs_overlap(base, size, abase, asize))
 			break;
 	}
 
@@ -435,7 +434,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
 phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			     phys_addr_t max_addr)
 {
-	long i, rgn;
+	long i, area;
 	phys_addr_t base = 0;
 	phys_addr_t res_base;
 
@@ -457,15 +456,15 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			continue;
 
 		while (base && lmbbase <= base) {
-			rgn = lmb_overlaps_region(&lmb->reserved, base, size);
-			if (rgn < 0) {
+			area = lmb_overlaps_region(&lmb->reserved, base, size);
+			if (area < 0) {
 				/* This area isn't reserved, take it */
-				if (lmb_add_region(&lmb->reserved, base,
-						   size) < 0)
+				if (lmb_add_area(&lmb->reserved, base, size)
+				    < 0)
 					return 0;
 				return base;
 			}
-			res_base = lmb->reserved.area[rgn].base;
+			res_base = lmb->reserved.area[area].base;
 			if (res_base < size)
 				break;
 			base = lmb_align_down(res_base - size, align);
@@ -481,17 +480,17 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
  */
 phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 {
-	long rgn;
+	int area;
 
-	/* Check if the requested address is in one of the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, base, size);
-	if (rgn >= 0) {
+	/* Check if the requested address is in one of the memory areas */
+	area = lmb_overlaps_region(&lmb->memory, base, size);
+	if (area >= 0) {
 		/*
 		 * Check if the requested end address is in the same memory
-		 * region we found.
+		 * area we found.
 		 */
-		if (lmb_addrs_overlap(lmb->memory.area[rgn].base,
-				      lmb->memory.area[rgn].size,
+		if (lmb_addrs_overlap(lmb->memory.area[area].base,
+				      lmb->memory.area[area].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
 			if (lmb_reserve(lmb, base, size) >= 0)
@@ -505,12 +504,11 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 /* Return number of bytes from a given address that are free */
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
 {
-	int i;
-	long rgn;
+	int i, area;
 
-	/* check if the requested address is in the memory regions */
-	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
-	if (rgn >= 0) {
+	/* check if the requested address is in the memory areas */
+	area = lmb_overlaps_region(&lmb->memory, addr, 1);
+	if (area >= 0) {
 		for (i = 0; i < lmb->reserved.cnt; i++) {
 			if (addr < lmb->reserved.area[i].base) {
 				/* first reserved range > requested address */
-- 
2.42.0.283.g2d96d420d3-goog

