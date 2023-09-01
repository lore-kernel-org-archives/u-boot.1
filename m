Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEBBCA0FE2
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C982867D6;
	Fri,  1 Sep 2023 03:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oOvdr2g1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFF0867B5; Fri,  1 Sep 2023 03:14:16 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7094886758
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1d0d3d40124so892038fac.3
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530852; x=1694135652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hWz9c6Td1cky8bwyLi+7aU5VKpUJZHbNDRh4xl5yWhU=;
 b=oOvdr2g1/mSKB6JQiaA0WdPHhQzRCqVs/Dsvsv313kgu3NxDKBE083bpZ8mkwoDL+o
 Y5yzFqZ5ESLfgviTMetPTejVwvRAuS2pp9Rk1F+kvF/txNREsaj6i7KXJVCcVr659ZL2
 3zIL84UBz0e72dr+loXg9muO791BQ52azaEcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530852; x=1694135652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hWz9c6Td1cky8bwyLi+7aU5VKpUJZHbNDRh4xl5yWhU=;
 b=TjhU0eEehaAlZZwO24ub20xTExAEAEguuGhFVBnUtInZcAGPWe8XSIsOYNFnmdSP70
 tZS8IM8e2zNqS7L2NtNgv1NllUKrwMpHT0EzfTTGVagrxJEk5d2be2wGpIL9JtwY34XO
 VTXZygnje+6y0zhEXSFlTmpXvRNdtnuqTVZrkDP+dONQTe5CTYF+ZMo+i6OHryq/i9xK
 hSYN/1sNa7zPXghC+4Sd0nK8D7EI1HC+lzBl8DKx34di+F48krGP6hkfT/xjARdUroKd
 wD5UWPgX+3kmPv8q7uqN0Ok/zWUoX+jOGyKnlXLB5xEmoWwmmL2dgNq+qyjqJCriD1oU
 SHjg==
X-Gm-Message-State: AOJu0YwxLJcUH5DVDXjzTZgN+DdUpvsUIFTXSExQhHSKmhTPJz6wa0jv
 1jp/jUJXarrcC1CUsAI4MMCoZIdV6/Wx7Bp/PGU=
X-Google-Smtp-Source: AGHT+IENDv5nEPxhkaiOdNxZM1xZro1Wspo8fgMo7oR5V6ZMUEO4p45E0kv2Z/PItf6MPWEl5TGoZw==
X-Received: by 2002:a05:6870:d607:b0:1be:c87d:c670 with SMTP id
 a7-20020a056870d60700b001bec87dc670mr1323883oaq.47.1693530851879; 
 Thu, 31 Aug 2023 18:14:11 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 03/14] lmb: Rename region array to area
Date: Thu, 31 Aug 2023 19:13:41 -0600
Message-ID: <20230901011357.2482203-4-sjg@chromium.org>
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

Adjust this so that the struct member matches its new name. For now, some
of the comments are wrong, but it difficult to do everything at once.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to rename region array to area

 include/lmb.h     |  14 +++---
 lib/lmb.c         | 112 +++++++++++++++++++++++-----------------------
 test/cmd/bdinfo.c |   6 +--
 test/lib/lmb.c    |  62 ++++++++++++-------------
 4 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 4b7664f22c1d..9d4a05670c23 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -23,11 +23,11 @@ enum lmb_flags {
 };
 
 /**
- * struct lmb_area - Description of one region.
+ * struct lmb_area - Description of one area within a region
  *
- * @base:	Base address of the region.
- * @size:	Size of the region
- * @flags:	memory region attributes
+ * @base:	Base address of the area
+ * @size:	Size of the area
+ * @flags:	memory-area attributes
  */
 struct lmb_area {
 	phys_addr_t base;
@@ -58,15 +58,15 @@ struct lmb_area {
  *
  * @cnt: Number of regions.
  * @max: Size of the region array, max value of cnt.
- * @region: Array of the region properties
+ * @area: Array of the areas within the region
  */
 struct lmb_region {
 	unsigned long cnt;
 	unsigned long max;
 #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
-	struct lmb_area region[CONFIG_LMB_MAX_REGIONS];
+	struct lmb_area area[CONFIG_LMB_MAX_REGIONS];
 #else
-	struct lmb_area *region;
+	struct lmb_area *area;
 #endif
 };
 
diff --git a/lib/lmb.c b/lib/lmb.c
index ae1969893f00..9336792df8ba 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -30,10 +30,10 @@ static void lmb_dump_region(struct lmb_region *rgn, char *name)
 	printf(" %s.cnt = 0x%lx / max = 0x%lx\n", name, rgn->cnt, rgn->max);
 
 	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
+		base = rgn->area[i].base;
+		size = rgn->area[i].size;
 		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		flags = rgn->area[i].flags;
 
 		printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
 		       name, i, base, end, size, flags);
@@ -77,10 +77,10 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
 				 unsigned long r2)
 {
-	phys_addr_t base1 = rgn->region[r1].base;
-	phys_size_t size1 = rgn->region[r1].size;
-	phys_addr_t base2 = rgn->region[r2].base;
-	phys_size_t size2 = rgn->region[r2].size;
+	phys_addr_t base1 = rgn->area[r1].base;
+	phys_size_t size1 = rgn->area[r1].size;
+	phys_addr_t base2 = rgn->area[r2].base;
+	phys_size_t size2 = rgn->area[r2].size;
 
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
@@ -90,9 +90,9 @@ static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 	unsigned long i;
 
 	for (i = r; i < rgn->cnt - 1; i++) {
-		rgn->region[i].base = rgn->region[i + 1].base;
-		rgn->region[i].size = rgn->region[i + 1].size;
-		rgn->region[i].flags = rgn->region[i + 1].flags;
+		rgn->area[i].base = rgn->area[i + 1].base;
+		rgn->area[i].size = rgn->area[i + 1].size;
+		rgn->area[i].flags = rgn->area[i + 1].flags;
 	}
 	rgn->cnt--;
 }
@@ -101,7 +101,7 @@ static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
 static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
 				 unsigned long r2)
 {
-	rgn->region[r1].size += rgn->region[r2].size;
+	rgn->area[r1].size += rgn->area[r2].size;
 	lmb_remove_region(rgn, r2);
 }
 
@@ -235,18 +235,18 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	long adjacent, i;
 
 	if (rgn->cnt == 0) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
+		rgn->area[0].base = base;
+		rgn->area[0].size = size;
+		rgn->area[0].flags = flags;
 		rgn->cnt = 1;
 		return 0;
 	}
 
 	/* First try and coalesce this LMB with another. */
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
-		phys_size_t rgnflags = rgn->region[i].flags;
+		phys_addr_t rgnbase = rgn->area[i].base;
+		phys_size_t rgnsize = rgn->area[i].size;
+		phys_size_t rgnflags = rgn->area[i].flags;
 		phys_addr_t end = base + size - 1;
 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
 
@@ -262,14 +262,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		if (adjacent > 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].base -= size;
-			rgn->region[i].size += size;
+			rgn->area[i].base -= size;
+			rgn->area[i].size += size;
 			coalesced++;
 			break;
 		} else if (adjacent < 0) {
 			if (flags != rgnflags)
 				break;
-			rgn->region[i].size += size;
+			rgn->area[i].size += size;
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
@@ -279,7 +279,7 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	}
 
 	if (i < rgn->cnt - 1 && lmb_regions_adjacent(rgn, i, i + 1)) {
-		if (rgn->region[i].flags == rgn->region[i + 1].flags) {
+		if (rgn->area[i].flags == rgn->area[i + 1].flags) {
 			lmb_coalesce_regions(rgn, i, i + 1);
 			coalesced++;
 		}
@@ -292,22 +292,22 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
-		if (base < rgn->region[i].base) {
-			rgn->region[i + 1].base = rgn->region[i].base;
-			rgn->region[i + 1].size = rgn->region[i].size;
-			rgn->region[i + 1].flags = rgn->region[i].flags;
+		if (base < rgn->area[i].base) {
+			rgn->area[i + 1].base = rgn->area[i].base;
+			rgn->area[i + 1].size = rgn->area[i].size;
+			rgn->area[i + 1].flags = rgn->area[i].flags;
 		} else {
-			rgn->region[i + 1].base = base;
-			rgn->region[i + 1].size = size;
-			rgn->region[i + 1].flags = flags;
+			rgn->area[i + 1].base = base;
+			rgn->area[i + 1].size = size;
+			rgn->area[i + 1].flags = flags;
 			break;
 		}
 	}
 
-	if (base < rgn->region[0].base) {
-		rgn->region[0].base = base;
-		rgn->region[0].size = size;
-		rgn->region[0].flags = flags;
+	if (base < rgn->area[0].base) {
+		rgn->area[0].base = base;
+		rgn->area[0].size = size;
+		rgn->area[0].flags = flags;
 	}
 
 	rgn->cnt++;
@@ -340,8 +340,8 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 
 	/* Find the region where (base, size) belongs to */
 	for (i = 0; i < rgn->cnt; i++) {
-		rgnbegin = rgn->region[i].base;
-		rgnend = rgnbegin + rgn->region[i].size - 1;
+		rgnbegin = rgn->area[i].base;
+		rgnend = rgnbegin + rgn->area[i].size - 1;
 
 		if ((rgnbegin <= base) && (end <= rgnend))
 			break;
@@ -359,14 +359,14 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 
 	/* Check to see if region is matching at the front */
 	if (rgnbegin == base) {
-		rgn->region[i].base = end + 1;
-		rgn->region[i].size -= size;
+		rgn->area[i].base = end + 1;
+		rgn->area[i].size -= size;
 		return 0;
 	}
 
 	/* Check to see if the region is matching at the end */
 	if (rgnend == end) {
-		rgn->region[i].size -= size;
+		rgn->area[i].size -= size;
 		return 0;
 	}
 
@@ -374,10 +374,10 @@ long lmb_free(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 	 * We need to split the entry -  adjust the current one to the
 	 * beginging of the hole and add the region after hole.
 	 */
-	rgn->region[i].size = base - rgn->region[i].base;
+	rgn->area[i].size = base - rgn->area[i].base;
 
 	return lmb_add_region_flags(rgn, end + 1, rgnend - end,
-				    rgn->region[i].flags);
+				    rgn->area[i].flags);
 }
 
 long lmb_reserve_flags(struct lmb *lmb, phys_addr_t base, phys_size_t size,
@@ -399,8 +399,8 @@ static long lmb_overlaps_region(struct lmb_region *rgn, phys_addr_t base,
 	unsigned long i;
 
 	for (i = 0; i < rgn->cnt; i++) {
-		phys_addr_t rgnbase = rgn->region[i].base;
-		phys_size_t rgnsize = rgn->region[i].size;
+		phys_addr_t rgnbase = rgn->area[i].base;
+		phys_size_t rgnsize = rgn->area[i].size;
 		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize))
 			break;
 	}
@@ -440,8 +440,8 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 	phys_addr_t res_base;
 
 	for (i = lmb->memory.cnt - 1; i >= 0; i--) {
-		phys_addr_t lmbbase = lmb->memory.region[i].base;
-		phys_size_t lmbsize = lmb->memory.region[i].size;
+		phys_addr_t lmbbase = lmb->memory.area[i].base;
+		phys_size_t lmbsize = lmb->memory.area[i].size;
 
 		if (lmbsize < size)
 			continue;
@@ -465,7 +465,7 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 					return 0;
 				return base;
 			}
-			res_base = lmb->reserved.region[rgn].base;
+			res_base = lmb->reserved.area[rgn].base;
 			if (res_base < size)
 				break;
 			base = lmb_align_down(res_base - size, align);
@@ -490,8 +490,8 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 		 * Check if the requested end address is in the same memory
 		 * region we found.
 		 */
-		if (lmb_addrs_overlap(lmb->memory.region[rgn].base,
-				      lmb->memory.region[rgn].size,
+		if (lmb_addrs_overlap(lmb->memory.area[rgn].base,
+				      lmb->memory.area[rgn].size,
 				      base + size - 1, 1)) {
 			/* ok, reserve the memory */
 			if (lmb_reserve(lmb, base, size) >= 0)
@@ -512,19 +512,19 @@ phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr)
 	rgn = lmb_overlaps_region(&lmb->memory, addr, 1);
 	if (rgn >= 0) {
 		for (i = 0; i < lmb->reserved.cnt; i++) {
-			if (addr < lmb->reserved.region[i].base) {
+			if (addr < lmb->reserved.area[i].base) {
 				/* first reserved range > requested address */
-				return lmb->reserved.region[i].base - addr;
+				return lmb->reserved.area[i].base - addr;
 			}
-			if (lmb->reserved.region[i].base +
-			    lmb->reserved.region[i].size > addr) {
+			if (lmb->reserved.area[i].base +
+			    lmb->reserved.area[i].size > addr) {
 				/* requested addr is in this reserved range */
 				return 0;
 			}
 		}
 		/* if we come here: no reserved ranges above requested addr */
-		return lmb->memory.region[lmb->memory.cnt - 1].base +
-		       lmb->memory.region[lmb->memory.cnt - 1].size - addr;
+		return lmb->memory.area[lmb->memory.cnt - 1].base +
+		       lmb->memory.area[lmb->memory.cnt - 1].size - addr;
 	}
 
 	return 0;
@@ -535,10 +535,10 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 	int i;
 
 	for (i = 0; i < lmb->reserved.cnt; i++) {
-		phys_addr_t upper = lmb->reserved.region[i].base +
-			lmb->reserved.region[i].size - 1;
-		if ((addr >= lmb->reserved.region[i].base) && (addr <= upper))
-			return (lmb->reserved.region[i].flags & flags) == flags;
+		phys_addr_t upper = lmb->reserved.area[i].base +
+			lmb->reserved.area[i].size - 1;
+		if (addr >= lmb->reserved.area[i].base && addr <= upper)
+			return (lmb->reserved.area[i].flags & flags) == flags;
 	}
 
 	return 0;
diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 8c09281cac0d..b895a244f815 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -109,10 +109,10 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 	ut_assert_nextline(" %s.cnt = 0x%lx / max = 0x%lx", name, rgn->cnt, rgn->max);
 
 	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
+		base = rgn->area[i].base;
+		size = rgn->area[i].size;
 		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		flags = rgn->area[i].flags;
 
 		ut_assert_nextline(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x",
 				   name, i, base, end, size, flags);
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 59b140fde4ce..a5c96993f7f9 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -26,22 +26,22 @@ static int check_lmb(struct unit_test_state *uts, struct lmb *lmb,
 {
 	if (ram_size) {
 		ut_asserteq(lmb->memory.cnt, 1);
-		ut_asserteq(lmb->memory.region[0].base, ram_base);
-		ut_asserteq(lmb->memory.region[0].size, ram_size);
+		ut_asserteq(lmb->memory.area[0].base, ram_base);
+		ut_asserteq(lmb->memory.area[0].size, ram_size);
 	}
 
 	ut_asserteq(lmb->reserved.cnt, num_reserved);
 	if (num_reserved > 0) {
-		ut_asserteq(lmb->reserved.region[0].base, base1);
-		ut_asserteq(lmb->reserved.region[0].size, size1);
+		ut_asserteq(lmb->reserved.area[0].base, base1);
+		ut_asserteq(lmb->reserved.area[0].size, size1);
 	}
 	if (num_reserved > 1) {
-		ut_asserteq(lmb->reserved.region[1].base, base2);
-		ut_asserteq(lmb->reserved.region[1].size, size2);
+		ut_asserteq(lmb->reserved.area[1].base, base2);
+		ut_asserteq(lmb->reserved.area[1].size, size2);
 	}
 	if (num_reserved > 2) {
-		ut_asserteq(lmb->reserved.region[2].base, base3);
-		ut_asserteq(lmb->reserved.region[2].size, size3);
+		ut_asserteq(lmb->reserved.area[2].base, base3);
+		ut_asserteq(lmb->reserved.area[2].size, size3);
 	}
 	return 0;
 }
@@ -87,14 +87,14 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 
 	if (ram0_size) {
 		ut_asserteq(lmb.memory.cnt, 2);
-		ut_asserteq(lmb.memory.region[0].base, ram0);
-		ut_asserteq(lmb.memory.region[0].size, ram0_size);
-		ut_asserteq(lmb.memory.region[1].base, ram);
-		ut_asserteq(lmb.memory.region[1].size, ram_size);
+		ut_asserteq(lmb.memory.area[0].base, ram0);
+		ut_asserteq(lmb.memory.area[0].size, ram0_size);
+		ut_asserteq(lmb.memory.area[1].base, ram);
+		ut_asserteq(lmb.memory.area[1].size, ram_size);
 	} else {
 		ut_asserteq(lmb.memory.cnt, 1);
-		ut_asserteq(lmb.memory.region[0].base, ram);
-		ut_asserteq(lmb.memory.region[0].size, ram_size);
+		ut_asserteq(lmb.memory.area[0].base, ram);
+		ut_asserteq(lmb.memory.area[0].size, ram_size);
 	}
 
 	/* reserve 64KiB somewhere */
@@ -165,14 +165,14 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 
 	if (ram0_size) {
 		ut_asserteq(lmb.memory.cnt, 2);
-		ut_asserteq(lmb.memory.region[0].base, ram0);
-		ut_asserteq(lmb.memory.region[0].size, ram0_size);
-		ut_asserteq(lmb.memory.region[1].base, ram);
-		ut_asserteq(lmb.memory.region[1].size, ram_size);
+		ut_asserteq(lmb.memory.area[0].base, ram0);
+		ut_asserteq(lmb.memory.area[0].size, ram0_size);
+		ut_asserteq(lmb.memory.area[1].base, ram);
+		ut_asserteq(lmb.memory.area[1].size, ram_size);
 	} else {
 		ut_asserteq(lmb.memory.cnt, 1);
-		ut_asserteq(lmb.memory.region[0].base, ram);
-		ut_asserteq(lmb.memory.region[0].size, ram_size);
+		ut_asserteq(lmb.memory.area[0].base, ram);
+		ut_asserteq(lmb.memory.area[0].size, ram_size);
 	}
 
 	return 0;
@@ -725,10 +725,10 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	/*  check each regions */
 	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
-		ut_asserteq(lmb.memory.region[i].base, ram + 2 * i * ram_size);
+		ut_asserteq(lmb.memory.area[i].base, ram + 2 * i * ram_size);
 
 	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
-		ut_asserteq(lmb.reserved.region[i].base, ram + 2 * i * blk_size);
+		ut_asserteq(lmb.reserved.area[i].base, ram + 2 * i * blk_size);
 
 	return 0;
 }
@@ -767,7 +767,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[0]), 1);
 
 	/* merge after */
 	ret = lmb_reserve_flags(&lmb, 0x40020000, 0x10000, LMB_NOMAP);
@@ -781,15 +781,15 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[0]), 1);
 
 	ret = lmb_reserve_flags(&lmb, 0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x10000, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[0]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[1]), 0);
 
 	/* test that old API use LMB_NONE */
 	ret = lmb_reserve(&lmb, 0x40040000, 0x10000);
@@ -797,8 +797,8 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[0]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[1]), 0);
 
 	ret = lmb_reserve_flags(&lmb, 0x40070000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
@@ -816,9 +816,9 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[2]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[0]), 1);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[1]), 0);
+	ut_asserteq(lmb_is_nomap(&lmb.reserved.area[2]), 1);
 
 	return 0;
 }
-- 
2.42.0.283.g2d96d420d3-goog

