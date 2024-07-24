Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D51C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE308896C;
	Wed, 24 Jul 2024 08:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F3E88954; Wed, 24 Jul 2024 08:05:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id AE7F788913
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2CEE106F;
 Tue, 23 Jul 2024 23:06:04 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 908B43F766;
 Tue, 23 Jul 2024 23:05:34 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 34/40] test: lmb: tweak the tests for the persistent lmb
 memory map
Date: Wed, 24 Jul 2024 11:32:18 +0530
Message-Id: <20240724060224.3071065-35-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

The LMB memory maps are now persistent, with alloced lists being used
to keep track of the available and free memory. Make corresponding
changes in the test functions so that the list information can be
accessed by the tests for checking against expected values. Also
introduce functions to initialise and cleanup the lists. These
functions will be invoked from every test to start the memory map from
a clean slate.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since rfc:
* Change the lmb_mem_regions_init() function to have it called from
  the lmb tests as well.

 include/lmb.h  |  24 +++-
 lib/lmb.c      |  38 ++++++-
 test/lib/lmb.c | 294 ++++++++++++++++++++++++++++++-------------------
 3 files changed, 239 insertions(+), 117 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index c90f167eec..25a984e14f 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -13,6 +13,8 @@
  * Copyright (C) 2001 Peter Bergner, IBM Corp.
  */
 
+struct alist;
+
 /**
  * enum lmb_flags - definition of memory region attributes
  * @LMB_NONE: no special request
@@ -90,16 +92,34 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
 
 /**
  * lmb_mem_regions_init() - Initialise the LMB memory
+ * @mem_lst: Pointer to store location of free memory list
+ * @used_lst: Pointer to store location of used memory list
+ * @add_rsv_mem: flag to indicate if memory is to be added and reserved
  *
  * Initialise the LMB subsystem related data structures. There are two
  * alloced lists that are initialised, one for the free memory, and one
  * for the used memory.
  *
- * Initialise the two lists as part of board init.
+ * Initialise the two lists as part of board init during boot. When called
+ * from a test, passes the pointers to the two lists to the caller. The
+ * caller is then required to call the corresponding function to uninit
+ * the lists.
  *
  * Return: 0 if OK, -ve on failure.
  */
-int lmb_mem_regions_init(void);
+int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
+			 bool add_rsv_mem);
+
+/**
+ * lmb_mem_regions_uninit() - Unitialise the lmb lists
+ * @mem_lst: Pointer to store location of free memory list
+ * @used_lst: Pointer to store location of used memory list
+ *
+ * Unitialise the LMB lists for free and used memory that was
+ * initialised as part of the init function. Called when running
+ * lmb test routines.
+ */
+void lmb_mem_regions_uninit(struct alist *mem_lst, struct alist *used_lst);
 
 #endif /* __KERNEL__ */
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 8ca4fd95c6..97ea26b013 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -740,16 +740,23 @@ __weak void arch_lmb_reserve(void)
 
 /**
  * lmb_mem_regions_init() - Initialise the LMB memory
+ * @mem_lst: Pointer to store location of free memory list
+ * @used_lst: Pointer to store location of used memory list
+ * @add_rsv_mem: flag to indicate if memory is to be added and reserved
  *
  * Initialise the LMB subsystem related data structures. There are two
  * alloced lists that are initialised, one for the free memory, and one
  * for the used memory.
  *
- * Initialise the two lists as part of board init.
+ * Initialise the two lists as part of board init during boot. When called
+ * from a test, passes the pointers to the two lists to the caller. The
+ * caller is then required to call the corresponding function to uninit
+ * the lists.
  *
  * Return: 0 if OK, -ve on failure.
  */
-int lmb_mem_regions_init(void)
+int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
+			 bool add_rsv_mem)
 {
 	bool ret;
 
@@ -767,6 +774,15 @@ int lmb_mem_regions_init(void)
 		return -1;
 	}
 
+	if (mem_lst)
+		*mem_lst = &lmb_free_mem;
+
+	if (used_lst)
+		*used_lst = &lmb_used_mem;
+
+	if (!add_rsv_mem)
+		return 0;
+
 	lmb_add_memory();
 
 	/* Reserve the U-Boot image region once U-Boot has relocated */
@@ -778,6 +794,22 @@ int lmb_mem_regions_init(void)
 	return 0;
 }
 
+/**
+ * lmb_mem_regions_uninit() - Unitialise the lmb lists
+ * @mem_lst: Pointer to store location of free memory list
+ * @used_lst: Pointer to store location of used memory list
+ *
+ * Unitialise the LMB lists for free and used memory that was
+ * initialised as part of the init function. Called when running
+ * lmb test routines.
+ */
+void __maybe_unused lmb_mem_regions_uninit(struct alist *mem_lst,
+					   struct alist *used_lst)
+{
+	alist_uninit(mem_lst);
+	alist_uninit(used_lst);
+}
+
 /**
  * initr_lmb() - Initialise the LMB lists
  *
@@ -791,7 +823,7 @@ int initr_lmb(void)
 {
 	int ret;
 
-	ret = lmb_mem_regions_init();
+	ret = lmb_mem_regions_init(NULL, NULL, true);
 	if (ret)
 		printf("Unable to initialise the LMB data structures\n");
 
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 3f99156cf3..aea84e7b1c 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -3,6 +3,7 @@
  * (C) Copyright 2018 Simon Goldschmidt
  */
 
+#include <alist.h>
 #include <dm.h>
 #include <lmb.h>
 #include <log.h>
@@ -12,52 +13,51 @@
 #include <test/test.h>
 #include <test/ut.h>
 
-extern struct lmb lmb;
-
-static inline bool lmb_is_nomap(struct lmb_property *m)
+static inline bool lmb_is_nomap(struct lmb_region *m)
 {
 	return m->flags & LMB_NOMAP;
 }
 
-static int check_lmb(struct unit_test_state *uts, struct lmb *lmb,
-		     phys_addr_t ram_base, phys_size_t ram_size,
-		     unsigned long num_reserved,
+static int check_lmb(struct unit_test_state *uts, struct alist *mem_lst,
+		     struct alist *used_lst, phys_addr_t ram_base,
+		     phys_size_t ram_size, unsigned long num_reserved,
 		     phys_addr_t base1, phys_size_t size1,
 		     phys_addr_t base2, phys_size_t size2,
 		     phys_addr_t base3, phys_size_t size3)
 {
+	struct lmb_region *mem, *used;
+
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	if (ram_size) {
-		ut_asserteq(lmb->memory.cnt, 1);
-		ut_asserteq(lmb->memory.region[0].base, ram_base);
-		ut_asserteq(lmb->memory.region[0].size, ram_size);
+		ut_asserteq(mem_lst->count, 1);
+		ut_asserteq(mem[0].base, ram_base);
+		ut_asserteq(mem[0].size, ram_size);
 	}
 
-	ut_asserteq(lmb->reserved.cnt, num_reserved);
+	ut_asserteq(used_lst->count, num_reserved);
 	if (num_reserved > 0) {
-		ut_asserteq(lmb->reserved.region[0].base, base1);
-		ut_asserteq(lmb->reserved.region[0].size, size1);
+		ut_asserteq(used[0].base, base1);
+		ut_asserteq(used[0].size, size1);
 	}
 	if (num_reserved > 1) {
-		ut_asserteq(lmb->reserved.region[1].base, base2);
-		ut_asserteq(lmb->reserved.region[1].size, size2);
+		ut_asserteq(used[1].base, base2);
+		ut_asserteq(used[1].size, size2);
 	}
 	if (num_reserved > 2) {
-		ut_asserteq(lmb->reserved.region[2].base, base3);
-		ut_asserteq(lmb->reserved.region[2].size, size3);
+		ut_asserteq(used[2].base, base3);
+		ut_asserteq(used[2].size, size3);
 	}
 	return 0;
 }
 
-#define ASSERT_LMB(lmb, ram_base, ram_size, num_reserved, base1, size1, \
+#define ASSERT_LMB(mem_lst, used_lst, ram_base, ram_size, num_reserved, base1, size1, \
 		   base2, size2, base3, size3) \
-		   ut_assert(!check_lmb(uts, lmb, ram_base, ram_size, \
+		   ut_assert(!check_lmb(uts, mem_lst, used_lst, ram_base, ram_size, \
 			     num_reserved, base1, size1, base2, size2, base3, \
 			     size3))
 
-/*
- * Test helper function that reserves 64 KiB somewhere in the simulated RAM and
- * then does some alloc + free tests.
- */
 static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 			    const phys_size_t ram_size, const phys_addr_t ram0,
 			    const phys_size_t ram0_size,
@@ -67,6 +67,8 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	const phys_addr_t alloc_64k_end = alloc_64k_addr + 0x10000;
 
 	long ret;
+	struct alist *mem_lst, *used_lst;
+	struct lmb_region *mem, *used;
 	phys_addr_t a, a2, b, b2, c, d;
 
 	/* check for overflow */
@@ -76,6 +78,10 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	if (ram0_size) {
 		ret = lmb_add(ram0, ram0_size, LMB_NONE);
 		ut_asserteq(ret, 0);
@@ -85,95 +91,97 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(ret, 0);
 
 	if (ram0_size) {
-		ut_asserteq(lmb.memory.cnt, 2);
-		ut_asserteq(lmb.memory.region[0].base, ram0);
-		ut_asserteq(lmb.memory.region[0].size, ram0_size);
-		ut_asserteq(lmb.memory.region[1].base, ram);
-		ut_asserteq(lmb.memory.region[1].size, ram_size);
+		ut_asserteq(mem_lst->count, 2);
+		ut_asserteq(mem[0].base, ram0);
+		ut_asserteq(mem[0].size, ram0_size);
+		ut_asserteq(mem[1].base, ram);
+		ut_asserteq(mem[1].size, ram_size);
 	} else {
-		ut_asserteq(lmb.memory.cnt, 1);
-		ut_asserteq(lmb.memory.region[0].base, ram);
-		ut_asserteq(lmb.memory.region[0].size, ram_size);
+		ut_asserteq(mem_lst->count, 1);
+		ut_asserteq(mem[0].base, ram);
+		ut_asserteq(mem[0].size, ram_size);
 	}
 
 	/* reserve 64KiB somewhere */
 	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate somewhere, should be at the end of RAM */
 	a = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(a, ram_end - 4);
-	ASSERT_LMB(&lmb, 0, 0, 2, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2, alloc_64k_addr, 0x10000,
 		   ram_end - 4, 4, 0, 0);
 	/* alloc below end of reserved region -> below reserved region */
 	b = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, alloc_64k_addr - 4);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 4, 4, 0, 0);
 
 	/* 2nd time */
 	c = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(c, ram_end - 8);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 4, 0x10000 + 4, ram_end - 8, 8, 0, 0);
 	d = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(d, alloc_64k_addr - 8);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
 
 	ret = lmb_free(a, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 	/* allocate again to ensure we get the same address */
 	a2 = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(a, a2);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 8, 0, 0);
 	ret = lmb_free(a2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 
 	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 3,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 	/* allocate again to ensure we get the same address */
 	b2 = lmb_alloc_base(4, 1, alloc_64k_end, LMB_NONE);
 	ut_asserteq(b, b2);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 0x10000 + 8, ram_end - 8, 4, 0, 0);
 	ret = lmb_free(b2, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 3,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 3,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000,
 		   ram_end - 8, 4);
 
 	ret = lmb_free(c, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 2,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 2,
 		   alloc_64k_addr - 8, 4, alloc_64k_addr, 0x10000, 0, 0);
 	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, 0, 0, 1, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, 0, 0, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	if (ram0_size) {
-		ut_asserteq(lmb.memory.cnt, 2);
-		ut_asserteq(lmb.memory.region[0].base, ram0);
-		ut_asserteq(lmb.memory.region[0].size, ram0_size);
-		ut_asserteq(lmb.memory.region[1].base, ram);
-		ut_asserteq(lmb.memory.region[1].size, ram_size);
+		ut_asserteq(mem_lst->count, 2);
+		ut_asserteq(mem[0].base, ram0);
+		ut_asserteq(mem[0].size, ram0_size);
+		ut_asserteq(mem[1].base, ram);
+		ut_asserteq(mem[1].size, ram_size);
 	} else {
-		ut_asserteq(lmb.memory.cnt, 1);
-		ut_asserteq(lmb.memory.region[0].base, ram);
-		ut_asserteq(lmb.memory.region[0].size, ram_size);
+		ut_asserteq(mem_lst->count, 1);
+		ut_asserteq(mem[0].base, ram);
+		ut_asserteq(mem[0].size, ram_size);
 	}
 
+	lmb_mem_regions_uninit(mem_lst, used_lst);
+
 	return 0;
 }
 
@@ -228,45 +236,53 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	const phys_size_t big_block_size = 0x10000000;
 	const phys_addr_t ram_end = ram + ram_size;
 	const phys_addr_t alloc_64k_addr = ram + 0x10000000;
+	struct alist *mem_lst, *used_lst;
+	struct lmb_region *mem, *used;
 	long ret;
 	phys_addr_t a, b;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* reserve 64KiB in the middle of RAM */
 	ret = lmb_reserve(alloc_64k_addr, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate a big block, should be below reserved */
 	a = lmb_alloc(big_block_size, 1, LMB_NONE);
 	ut_asserteq(a, ram);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 	/* allocate 2nd big block */
 	/* This should fail, printing an error */
 	b = lmb_alloc(big_block_size, 1, LMB_NONE);
 	ut_asserteq(b, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, a,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a,
 		   big_block_size + 0x10000, 0, 0, 0, 0);
 
 	ret = lmb_free(a, big_block_size, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
 	/* allocate too big block */
 	/* This should fail, printing an error */
 	a = lmb_alloc(ram_size, 1, LMB_NONE);
 	ut_asserteq(a, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, alloc_64k_addr, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
+	lmb_mem_regions_uninit(mem_lst, used_lst);
+
 	return 0;
 }
 
@@ -292,51 +308,62 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	const phys_addr_t ram_end = ram + ram_size;
 	long ret;
 	phys_addr_t a, b;
+	struct alist *mem_lst, *used_lst;
+	struct lmb_region *mem, *used;
 	const phys_addr_t alloc_size_aligned = (alloc_size + align - 1) &
 		~(align - 1);
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block */
 	a = lmb_alloc(alloc_size, align, LMB_NONE);
 	ut_assert(a != 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
-		   alloc_size, 0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
+		   ram + ram_size - alloc_size_aligned, alloc_size, 0, 0, 0, 0);
+
 	/* allocate another block */
 	b = lmb_alloc(alloc_size, align, LMB_NONE);
 	ut_assert(b != 0);
 	if (alloc_size == alloc_size_aligned) {
-		ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size -
+		ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + ram_size -
 			   (alloc_size_aligned * 2), alloc_size * 2, 0, 0, 0,
 			   0);
 	} else {
-		ASSERT_LMB(&lmb, ram, ram_size, 2, ram + ram_size -
+		ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram + ram_size -
 			   (alloc_size_aligned * 2), alloc_size, ram + ram_size
 			   - alloc_size_aligned, alloc_size, 0, 0);
 	}
 	/* and free them */
 	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
+		   ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	ret = lmb_free(a, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
 	/* allocate a block with base*/
 	b = lmb_alloc_base(alloc_size, align, ram_end, LMB_NONE);
 	ut_assert(a == b);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + ram_size - alloc_size_aligned,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1,
+		   ram + ram_size - alloc_size_aligned,
 		   alloc_size, 0, 0, 0, 0);
 	/* and free it */
 	ret = lmb_free(b, alloc_size, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+
+	lmb_mem_regions_uninit(mem_lst, used_lst);
 
 	return 0;
 }
@@ -378,33 +405,41 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0;
 	const phys_size_t ram_size = 0x20000000;
+	struct alist *mem_lst, *used_lst;
+	struct lmb_region *mem, *used;
 	long ret;
 	phys_addr_t a, b;
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* allocate nearly everything */
 	a = lmb_alloc(ram_size - 4, 1, LMB_NONE);
 	ut_asserteq(a, ram + 4);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* allocate the rest */
 	/* This should fail as the allocated address would be 0 */
 	b = lmb_alloc(4, 1, LMB_NONE);
 	ut_asserteq(b, 0);
 	/* check that this was an error by checking lmb */
-	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 	/* check that this was an error by freeing b */
 	ret = lmb_free(b, 4, LMB_NONE);
 	ut_asserteq(ret, -1);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, a, ram_size - 4,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, ram_size - 4,
 		   0, 0, 0, 0);
 
 	ret = lmb_free(a, ram_size - 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
+
+	lmb_mem_regions_uninit(mem_lst, used_lst);
 
 	return 0;
 }
@@ -415,42 +450,52 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
+	struct alist *mem_lst, *used_lst;
+	struct lmb_region *mem, *used;
 	long ret;
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
-	/* allocate overlapping region should fail */
+
+	/* allocate overlapping region should return the coalesced count */
 	ret = lmb_reserve(0x40011000, 0x10000, LMB_NONE);
-	ut_asserteq(ret, -1);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
+	ut_asserteq(ret, 1);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
 		   0, 0, 0, 0);
 	/* allocate 3nd region */
 	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40010000, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40010000, 0x11000,
 		   0x40030000, 0x10000, 0, 0);
 	/* allocate 2nd region , This should coalesced all region into one */
 	ret = lmb_reserve(0x40020000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x30000,
 		   0, 0, 0, 0);
 
 	/* allocate 2nd region, which should be added as first region */
 	ret = lmb_reserve(0x40000000, 0x8000, LMB_NONE);
 	ut_assert(ret >= 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x8000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x8000,
 		   0x40010000, 0x30000, 0, 0);
 
 	/* allocate 3rd region, coalesce with first and overlap with second */
 	ret = lmb_reserve(0x40008000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x40000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
+
+	lmb_mem_regions_uninit(mem_lst, used_lst);
+
 	return 0;
 }
 LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
@@ -461,6 +506,8 @@ LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
  */
 static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 {
+	struct lmb_region *mem, *used;
+	struct alist *mem_lst, *used_lst;
 	const phys_size_t ram_size = 0x20000000;
 	const phys_addr_t ram_end = ram + ram_size;
 	const phys_size_t alloc_addr_a = ram + 0x8000000;
@@ -472,6 +519,10 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
@@ -482,34 +533,34 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ut_asserteq(ret, 0);
 	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* allocate blocks */
 	a = lmb_alloc_addr(ram, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(a, ram);
-	ASSERT_LMB(&lmb, ram, ram_size, 3, ram, 0x8010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, ram, 0x8010000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 	b = lmb_alloc_addr(alloc_addr_a + 0x10000,
 			   alloc_addr_b - alloc_addr_a - 0x10000, LMB_NONE);
 	ut_asserteq(b, alloc_addr_a + 0x10000);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x10010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x10010000,
 		   alloc_addr_c, 0x10000, 0, 0);
 	c = lmb_alloc_addr(alloc_addr_b + 0x10000,
 			   alloc_addr_c - alloc_addr_b - 0x10000, LMB_NONE);
 	ut_asserteq(c, alloc_addr_b + 0x10000);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000,
 			   ram_end - alloc_addr_c - 0x10000, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
 	/* allocating anything else should fail */
 	e = lmb_alloc(1, 1, LMB_NONE);
 	ut_asserteq(e, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, ram_size,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, ram_size,
 		   0, 0, 0, 0);
 
 	ret = lmb_free(d, ram_end - alloc_addr_c - 0x10000, LMB_NONE);
@@ -519,39 +570,40 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 
 	d = lmb_alloc_addr(ram_end - 4, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 4);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
 	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	d = lmb_alloc_addr(ram_end - 128, 4, LMB_NONE);
 	ut_asserteq(d, ram_end - 128);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, ram, 0x18010000,
 		   d, 4, 0, 0);
 	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	d = lmb_alloc_addr(alloc_addr_c + 0x10000, 4, LMB_NONE);
 	ut_asserteq(d, alloc_addr_c + 0x10000);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010004,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010004,
 		   0, 0, 0, 0);
 	ret = lmb_free(d, 4, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram, 0x18010000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram, 0x18010000,
 		   0, 0, 0, 0);
 
 	/* allocate at the bottom */
 	ret = lmb_free(a, alloc_addr_a - ram, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, ram + 0x8000000, 0x10010000,
-		   0, 0, 0, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, ram + 0x8000000,
+		   0x10010000, 0, 0, 0, 0);
+
 	d = lmb_alloc_addr(ram, 4, LMB_NONE);
 	ut_asserteq(d, ram);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, d, 4,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, d, 4,
 		   ram + 0x8000000, 0x10010000, 0, 0);
 
 	/* check that allocating outside memory fails */
@@ -564,6 +616,8 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		ut_asserteq(ret, 0);
 	}
 
+	lmb_mem_regions_uninit(mem_lst, used_lst);
+
 	return 0;
 }
 
@@ -585,6 +639,8 @@ LIB_TEST(lib_test_lmb_alloc_addr, 0);
 static int test_get_unreserved_size(struct unit_test_state *uts,
 				    const phys_addr_t ram)
 {
+	struct lmb_region *mem, *used;
+	struct alist *mem_lst, *used_lst;
 	const phys_size_t ram_size = 0x20000000;
 	const phys_addr_t ram_end = ram + ram_size;
 	const phys_size_t alloc_addr_a = ram + 0x8000000;
@@ -596,6 +652,10 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
@@ -606,7 +666,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	ut_asserteq(ret, 0);
 	ret = lmb_reserve(alloc_addr_c, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 3, alloc_addr_a, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, alloc_addr_a, 0x10000,
 		   alloc_addr_b, 0x10000, alloc_addr_c, 0x10000);
 
 	/* check addresses in between blocks */
@@ -631,6 +691,8 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	s = lmb_get_free_size(ram_end - 4);
 	ut_asserteq(s, 4);
 
+	lmb_mem_regions_uninit(mem_lst, used_lst);
+
 	return 0;
 }
 
@@ -650,83 +712,91 @@ LIB_TEST(lib_test_lmb_get_free_size, 0);
 
 static int lib_test_lmb_flags(struct unit_test_state *uts)
 {
+	struct lmb_region *mem, *used;
+	struct alist *mem_lst, *used_lst;
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
 	long ret;
 
+	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	mem = mem_lst->data;
+	used = used_lst->data;
+
 	ret = lmb_add(ram, ram_size, LMB_NONE);
 	ut_asserteq(ret, 0);
 
 	/* reserve, same flag */
 	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, same flag */
 	ret = lmb_reserve(0x40010000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
 	/* reserve again, new flag */
 	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, -1);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
+	ut_asserteq(lmb_is_nomap(&used[0]), 1);
 
 	/* merge after */
 	ret = lmb_reserve(0x40020000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x20000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x20000,
 		   0, 0, 0, 0);
 
 	/* merge before */
 	ret = lmb_reserve(0x40000000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 1);
-	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x30000,
 		   0, 0, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
+	ut_asserteq(lmb_is_nomap(&used[0]), 1);
 
 	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x10000, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
+	ut_asserteq(lmb_is_nomap(&used[0]), 1);
+	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 
 	/* test that old API use LMB_NONE */
 	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 1);
-	ASSERT_LMB(&lmb, ram, ram_size, 2, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0, 0);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
+	ut_asserteq(lmb_is_nomap(&used[0]), 1);
+	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 
 	ret = lmb_reserve(0x40070000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40070000, 0x10000);
 
 	ret = lmb_reserve(0x40050000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 0);
-	ASSERT_LMB(&lmb, ram, ram_size, 4, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 4, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x10000);
 
 	/* merge with 2 adjacent regions */
 	ret = lmb_reserve(0x40060000, 0x10000, LMB_NOMAP);
 	ut_asserteq(ret, 2);
-	ASSERT_LMB(&lmb, ram, ram_size, 3, 0x40000000, 0x30000,
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 3, 0x40000000, 0x30000,
 		   0x40030000, 0x20000, 0x40050000, 0x30000);
 
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[0]), 1);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[1]), 0);
-	ut_asserteq(lmb_is_nomap(&lmb.reserved.region[2]), 1);
+	ut_asserteq(lmb_is_nomap(&used[0]), 1);
+	ut_asserteq(lmb_is_nomap(&used[1]), 0);
+	ut_asserteq(lmb_is_nomap(&used[2]), 1);
+
+	lmb_mem_regions_uninit(mem_lst, used_lst);
 
 	return 0;
 }
-- 
2.34.1

