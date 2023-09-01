Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D754CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0DC868D7;
	Fri,  1 Sep 2023 03:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2ax4kzC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FC1C80750; Fri,  1 Sep 2023 03:14:26 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C58586776
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-794e0e8b588so54241139f.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530861; x=1694135661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bc4Uzn3BMOtxZspgYcOiJ0NswVdA95+gRnuKpkhbEgQ=;
 b=g2ax4kzC+G2CZMdFh4poW9zN+X/3bHUJxkOvnuiqHGYGD/dAPMyLxoO4jA2iJ7GSQB
 Um6OHbe0fqvx0e6Mm1isnU1B7pTzV7KJpqnonSDbUI3lnGBbXJBuDFoNJYjmkqNmjc8g
 HdiMArkgEkIoh7v9S4CDrO6Vc9N12LPgi/SHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530861; x=1694135661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bc4Uzn3BMOtxZspgYcOiJ0NswVdA95+gRnuKpkhbEgQ=;
 b=LNMQTFQ8/vDie8c3OgQJGee/ysS+AAQdcH9XZPYju9cIFx0P/ybjZzeuVhT8424dc7
 zlLWG/WG1t+x5CQ1uSqIYClBYjbOSl4I4FLKdYUjISBCmZFIXYP9aub/sFa8yB58pexL
 ZG7tOpSzYQhhamJf/3cMVvxmwI0DTMYo9SqrxrbLdQZ/YcLh52emyG0rbZ3Pl7sdfwyV
 aYB6XJLwLgoaEk0F99ZzlTMGZR0ictkq7gswPGqw3tqtS1jy0m3AFlMVBilRZ2Is+7rd
 2AYXihpaeifkDqQr47rMMVzE/RWzlr7KmR4wcU8bZK/+FTVhEQWEb4iLhxEDmg3QQ4kk
 Ovzw==
X-Gm-Message-State: AOJu0Yxw1XF60hj47OdZ4GG4U0QTyES1NKvxK9SQeNqo/BRfselwp/s0
 5vJxipP2f3B00aGvObkvAITvvQys8GMqUtyjV2c=
X-Google-Smtp-Source: AGHT+IHwXZ/3bvspBcxpQPW9j9IcZcW8udouU+86UVIfW91hCcYzaLkYKexKFtOD4SpL7xnuL/OvXw==
X-Received: by 2002:a5e:da03:0:b0:794:e96f:b87d with SMTP id
 x3-20020a5eda03000000b00794e96fb87dmr1159379ioj.0.1693530861711; 
 Thu, 31 Aug 2023 18:14:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dk8-20020a0566384bc800b0042b279bb086sm712101jab.66.2023.08.31.18.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 18:14:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sjoerd Simons <sjoerd@collabora.com>
Subject: [PATCH v2 14/14] fs: Fix a confusing error about overlapping regions
Date: Thu, 31 Aug 2023 19:13:52 -0600
Message-ID: <20230901011357.2482203-15-sjg@chromium.org>
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

When lmb runs out of space in its internal tables, it gives errors on
every fs load operation. This is horribly confusing, as the poor user
tries different memory regions one at a time.

Use the updated API to check the error code and print a helpful message.
Also, allow the operation to proceed.

Update the tests accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
index c81716b3f1d1..f28a872c78d0 100644
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
index fd6326cbf7fe..c3d14db07e45 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -252,7 +252,7 @@ void lmb_init_and_reserve_range(struct lmb *lmb, phys_addr_t base,
  * @size:	size of the memory region to add
  * @flags:	flags for this new memory region
  * Returns: 0 if OK, -EBUSY if an existing enveloping region has different
- * flags, -EPERM if there is an existing non-adjacent region, -ENOSPC if there
+ * flags, -EPERM if there is an existing non-adjacent region, -E2BIG if there
  * is no more room in the list of regions, ekse region number that was coalesced
  * with this one
  **/
@@ -318,7 +318,7 @@ static int lmb_add_area_flags(struct lmb_region *rgn, phys_addr_t base,
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
 	int area;
 
@@ -529,9 +526,14 @@ phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size)
 		if (lmb_addrs_overlap(lmb->memory.area[area].base,
 				      lmb->memory.area[area].size,
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
index b665d8dcdeb4..c8dbdb3b73eb 100644
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
@@ -699,8 +699,7 @@ static int lib_test_LMB_MAX_AREAS(struct unit_test_state *uts)
 
 	/*  error for the (CONFIG_LMB_MAX_AREAS + 1) memory regions */
 	offset = ram + 2 * (CONFIG_LMB_MAX_AREAS + 1) * ram_size;
-	ret = lmb_add(&lmb, offset, ram_size);
-	ut_asserteq(ret, -1);
+	ut_asserteq(-E2BIG, lmb_add(&lmb, offset, ram_size));
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_AREAS);
 	ut_asserteq(lmb.reserved.cnt, 0);
@@ -717,8 +716,7 @@ static int lib_test_LMB_MAX_AREAS(struct unit_test_state *uts)
 
 	/*  error for the 9th reserved blocks */
 	offset = ram + 2 * (CONFIG_LMB_MAX_AREAS + 1) * blk_size;
-	ret = lmb_reserve(&lmb, offset, blk_size);
-	ut_asserteq(ret, -1);
+	ut_asserteq(-E2BIG, lmb_reserve(&lmb, offset, blk_size));
 
 	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_AREAS);
 	ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_AREAS);
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
2.42.0.283.g2d96d420d3-goog

