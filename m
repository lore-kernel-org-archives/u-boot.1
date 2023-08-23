Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A6EE49B5
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 13:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EB60864CF;
	Wed, 23 Aug 2023 15:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YaXfBGB/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DDBD86386; Wed, 23 Aug 2023 15:42:27 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19097864C9
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 15:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-34bbb4b580eso17573905ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 06:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692798142; x=1693402942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awxg8TDxqrszaZ0sgBsR7JsCtcQ12SjhUe4NskxTwG4=;
 b=YaXfBGB/d72SXQDVXFo45UsytLtW1zHjTxoOOiHtyXhU3wmyrN9Z/Wd4klCZlIpN6z
 sh2Z+VqYtsJF7OIp+VSz9tRitPJpLw2F61mgNIwLmqRx5JpzvafdS6mFYAqhE2iy7ZQx
 FMHcK0rVUXgsx4bOgtlJ2Un7kz/ZZgEnww1b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692798142; x=1693402942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awxg8TDxqrszaZ0sgBsR7JsCtcQ12SjhUe4NskxTwG4=;
 b=HKRyZ+ebAA45R3jDlJ7FKqSaLJLfjeqgLDaa5w/EvXBJG5MfNqi45DofGrWlrgEIXO
 DZEUre1G+kc58zrtyTkrClJ74yI+O+3oaK7+LRWfJds9Z/1OTxiCh6ypswWzfPbl9k3R
 Ca0w8klHsnlIOmQqxWkmu+xUuvKe7o6uUmbQDty1Fz3V+4jkOqbbKhW0Md5+NrZ9PMh9
 ocL3x6hbDREEGs7PVUpxhdc907l2laKUPFcfm7gPYWBcqxAK/6Y5PNlGI8dvMvcApS4P
 NAaM9qVMNf56GVMOuh2R2LPDv/J52J4+oLMUUcB5jIrUo7Ky6Wxi9AhVPmc+kf1aHKTc
 Wdzg==
X-Gm-Message-State: AOJu0YzhMahhO6gPrG0UvDOoSd2VmJ0z+Rg/+naMT1q7fEIp5XNg8byo
 PNb+0OQY8G53wDTX/YBsbZE466gIU9EooX8/tCE=
X-Google-Smtp-Source: AGHT+IHAmcuENHORzKtLngCLH627f6uRYLegSDRL7wesZH54nCQuhIBNa1uqaQl4H1ejdQBRl2g69Q==
X-Received: by 2002:a05:6e02:dcc:b0:34c:c7c6:d8ed with SMTP id
 l12-20020a056e020dcc00b0034cc7c6d8edmr1184390ilj.13.1692798142582; 
 Wed, 23 Aug 2023 06:42:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a02cdcd000000b0042b4f9ddecasm3800233jap.85.2023.08.23.06.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 06:42:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
Date: Wed, 23 Aug 2023 07:42:03 -0600
Message-ID: <20230823134209.1450567-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823134209.1450567-1-sjg@chromium.org>
References: <20230823134209.1450567-1-sjg@chromium.org>
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

When lmb runs out of space in its internal tables, it gives errors on
every fs load operation. This is horribly confusing, as the poor user
tries different memory regions one at a time.

Use the updated API to check the error code and print a helpful message.
Also, allow the operation to proceed.

Update the tests accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 fs/fs.c        |  7 ++++++-
 include/lmb.h  | 19 ++++++++++++++++++-
 lib/lmb.c      | 20 +++++++++++---------
 test/lib/lmb.c | 42 ++++++++++++++++++++----------------------
 4 files changed, 55 insertions(+), 33 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 2b815b1db0fe..1a84cb410bf9 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -569,8 +569,13 @@ static int fs_read_lmb_check(const char *filename, ulong addr, loff_t offset,
 	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
 	lmb_dump_all(&lmb);
 
-	if (lmb_alloc_addr(&lmb, addr, read_len) == addr)
+	ret = lmb_alloc_addr(&lmb, addr, read_len, NULL);
+	if (!ret)
 		return 0;
+	if (ret == -E2BIG) {
+		log_warning("Reservation tables exhausted: see CONFIG_LMB_USE_MAX_REGIONS\n");
+		return 0;
+	}
 
 	log_err("** Reading file would overwrite reserved memory **\n");
 	return -ENOSPC;
diff --git a/include/lmb.h b/include/lmb.h
index 79a3a12155b4..2060280aff54 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -114,7 +114,24 @@ phys_addr_t lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			   phys_addr_t max_addr);
 phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 			     phys_addr_t max_addr);
-phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
+
+/**
+ * lmb_alloc_addr() - Allocate memory within a region
+ *
+ * Try to allocate a specific address range: must be in defined memory but not
+ * reserved
+ *
+ * @lmb:	the logical memory block struct
+ * @base:	base address of the memory region
+ * @size:	size of the memory region
+ * @addrp:	if non-NULL, returns the allocated address, on success
+ * Return:	0 if OK, -EPERM if the memory is already allocated, -E2BIG if
+ * there is not enough room in the reservation tables, so
+ * CONFIG_LMB_USE_MAX_REGIONS should be increased
+ */
+int lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size,
+		   phys_addr_t *addrp);
+
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 340681961826..6bb8fa3829d3 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -253,7 +253,7 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
  * @size:	size of the memory region to add
  * @flags:	flags for this new memory region
  * Returns: 0 if OK, -EBUSY if an existing enveloping region has different
- * flags, -EPERM if there is an existing non-adjacent region, -ENOSPC if there
+ * flags, -EPERM if there is an existing non-adjacent region, -E2BIG if there
  * is no more room in the list of regions, ekse region number that was coalesced
  * with this one
  **/
@@ -319,7 +319,7 @@ static int lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 	if (coalesced)
 		return coalesced;
 	if (rgn->cnt >= rgn->max)
-		return -ENOSPC;
+		return -E2BIG;
 
 	/* Couldn't coalesce the LMB, so add it to the sorted table. */
 	for (i = rgn->cnt-1; i >= 0; i--) {
@@ -511,11 +511,8 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 	return 0;
 }
 
-/*
- * Try to allocate a specific address range: must be in defined memory but not
- * reserved
- */
-phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
+int lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size,
+		   phys_addr_t *addrp)
 {
 	long rgn;
 
@@ -529,9 +526,14 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 		if (lmb_addrs_overlap(lmb->memory.region[rgn].base,
 				      lmb->memory.region[rgn].size,
 				      base + size - 1, 1)) {
+			int ret;
+
 			/* ok, reserve the memory */
-			if (lmb_reserve(lmb, base, size) >= 0)
-				return base;
+			ret = lmb_reserve(lmb, base, size);
+			if (ret < 0)
+				return ret;
+			if (addrp)
+				*addrp = base;
 		}
 	}
 
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 162887503588..9ab5fe593ebd 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -497,22 +497,22 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
-	a = lmb_alloc_addr(&lmb, ram, alloc_addr_a - ram);
+	ut_assertok(lmb_alloc_addr(&lmb, ram, alloc_addr_a - ram, &a));
 	ut_asserteq(a, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
-	b = lmb_alloc_addr(&lmb, alloc_addr_a + 0x10000,
-			   alloc_addr_b - alloc_addr_a - 0x10000);
+	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_a + 0x10000,
+				   alloc_addr_b - alloc_addr_a - 0x10000, &b));
 	ut_asserteq(b, alloc_addr_a + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
-	c = lmb_alloc_addr(&lmb, alloc_addr_b + 0x10000,
-			   alloc_addr_c - alloc_addr_b - 0x10000);
+	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_b + 0x10000,
+				   alloc_addr_c - alloc_addr_b - 0x10000, &c));
 	ut_asserteq(c, alloc_addr_b + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000,
-			   ram_end - alloc_addr_c - 0x10000);
+	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000,
+				   ram_end - alloc_addr_c - 0x10000, &d));
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
@@ -528,7 +528,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	/* allocate at 3 points in free range */
 
-	d = lmb_alloc_addr(&lmb, ram_end - 4, 4);
+	ut_assertok(lmb_alloc_addr(&lmb, ram_end - 4, 4, &d));
 	ut_asserteq(d, ram_end - 4);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -537,7 +537,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(&lmb, ram_end - 128, 4);
+	ut_assertok(lmb_alloc_addr(&lmb, ram_end - 128, 4, &d));
 	ut_asserteq(d, ram_end - 128);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
@@ -546,7 +546,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
-	d = lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000, 4);
+	ut_assertok(lmb_alloc_addr(&lmb, alloc_addr_c + 0x10000, 4, &d));
 	ut_asserteq(d, alloc_addr_c + 0x10000);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
@@ -560,19 +560,19 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + 0x8000000, 0x10010000,
 		   0, 0, 0, 0);
-	d = lmb_alloc_addr(&lmb, ram, 4);
+	ut_assertok(lmb_alloc_addr(&lmb, ram, 4, &d));
 	ut_asserteq(d, ram);
 	ASSERT_LMB(&lmb, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
 	if (ram_end != 0) {
-		ret = lmb_alloc_addr(&lmb, ram_end, 1);
-		ut_asserteq(ret, 0);
+		ut_assertok(lmb_alloc_addr(&lmb, ram_end, 1, &a));
+		ut_asserteq(0x40000000, a);
 	}
 	if (ram != 0) {
-		ret = lmb_alloc_addr(&lmb, ram - 1, 1);
-		ut_asserteq(ret, 0);
+		ut_assertok(lmb_alloc_addr(&lmb, ram - 1, 1, &a));
+		ut_asserteq(ram, a);
 	}
 
 	return 0;
@@ -588,7 +588,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
 		return ret;
 
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
-	return test_alloc_addr(uts, 0xE0000000);
+	return test_alloc_addr(uts, 0xe0000000);
 }
 
 DM_TEST(lib_test_lmb_alloc_addr, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
@@ -699,8 +699,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	/*  error for the (CONFIG_LMB_MAX_REGIONS + 1) memory regions */
 	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * ram_size;
-	ret = lmb_add(&lmb, offset, ram_size);
-	ut_asserteq(ret, -1);
+	ut_asserteq(-E2BIG, lmb_add(&lmb, offset, ram_size));
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -717,8 +716,7 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	/*  error for the 9th reserved blocks */
 	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * blk_size;
-	ret = lmb_reserve(&lmb, offset, blk_size);
-	ut_asserteq(ret, -1);
+	ut_asserteq(-E2BIG, lmb_reserve(&lmb, offset, blk_size));
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
 	ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_REGIONS);
@@ -762,8 +760,8 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 		   0, 0, 0, 0);
 
 	/* reserve again, new flag */
-	ret = lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NONE);
-	ut_asserteq(ret, -1);
+	ut_asserteq(-EBUSY,
+		    lmb_reserve_flags(&lmb, 0x40010000, 0x10000, LMB_NONE));
 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-- 
2.42.0.rc1.204.g551eb34607-goog

