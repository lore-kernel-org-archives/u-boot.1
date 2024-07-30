Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E83C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2884B888CF;
	Tue, 30 Jul 2024 16:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EenzTNWx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E2FE8882C; Tue, 30 Jul 2024 16:40:48 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B30888898
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f96ea9ff7so137532639f.3
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 07:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722350445; x=1722955245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYiWOLy/mgyd8fnEEHB4/zYNHL67+Vp5I5TIZZWhVBU=;
 b=EenzTNWxloS9dij6aXzJZm+9MgwlFD5eFXBO+Q0SE2qqUi8ohdWX7vYiO8IvGehZmF
 4G/TBS02+bOvqgCuLzQP37dPOOPA3lgt7AUdIYRf9aZZXxbIujNcvFAxTaJ2d812k+AV
 RLrsSecwYKFl3BkdxV7Nya8d35J5l6rzlAUu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722350445; x=1722955245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYiWOLy/mgyd8fnEEHB4/zYNHL67+Vp5I5TIZZWhVBU=;
 b=fCSubYZ+QzZ5QbP80iWK5GieMS7rgJGVSWZBeiXiF3CyszZ1ZQAYPAeJhxNujh8kAp
 ZunPNLgj4XQyWUvb8SI8c/va4QDgloqa64NNhdWW/xdxB6LnE/rj5B6iOH8lyO8gmEkO
 KU3wOeG58Xkm79c0JQuC2ig+Ng9j/gbWE+SAUiOiuTK5enIzeBakjIGKPaBeGzWYIVOk
 KaD7+EgV78IeWI+QLZ6alOI+sehMxLniSxoDwlQrl0Nh8Mz/qtjsORbJirp37BouI7I3
 IxCL9Ahyn2rXUMyQe7kJCh2OMKGjc7cJE7835c48PxBTZvsZSegf6x4PIAIoKtlzH0At
 moKg==
X-Gm-Message-State: AOJu0Ywr+wsrbbE9ZD8ebbFVys/W0nxl8DtP0QsyDUeUcWKKwgwvH/8u
 +z7N31TE0xkdetaDBHrSVLppgryMqpLdBaBx4Bmtb0rp9mwwTGbVpF76KLEmKa/j6sTb6JmZe7o
 =
X-Google-Smtp-Source: AGHT+IG62LoduAYLDLjsjMGSjV9kMG8zj0ShIDfeUfUUIMPuxqssgAiUWbKeahWLI0492vkg/bac4Q==
X-Received: by 2002:a05:6602:3fd3:b0:804:9972:2f8c with SMTP id
 ca18e2360f4ac-81f95a4fefemr1286381339f.8.1722350444711; 
 Tue, 30 Jul 2024 07:40:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa9338csm2714724173.39.2024.07.30.07.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 07:40:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
	Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH 4/4] lmb: Ensure that tests don't change lmb state
Date: Tue, 30 Jul 2024 08:40:35 -0600
Message-Id: <20240730144035.3992996-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730144035.3992996-1-sjg@chromium.org>
References: <20240730144035.3992996-1-sjg@chromium.org>
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

Tests should not change the lmb state, so provide a way to save and
restore the state.

Note: The _norun tests can now become normal tests.

When tests fail, lmb is broken. This is probably fine. If it causes
problems we could save/restore outside the test, using a UT_TESTF_ flag.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/lmb.h | 32 ++++++++---------------
 lib/lmb.c     | 70 ++++++++++++++++++---------------------------------
 test/lmb_ut.c | 54 +++++++++++++++++++++++++++------------
 3 files changed, 73 insertions(+), 83 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index a2236a419fd..ed943b29234 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -110,35 +110,23 @@ static int lmb_init(void) { return 0; }
 #endif
 
 /**
- * lmb_mem_regions_init() - Initialise the LMB memory
- * @mem_lst: Pointer to store location of free memory list
- * @used_lst: Pointer to store location of used memory list
- * @add_rsv_mem: flag to indicate if memory is to be added and reserved
+ * lmb_push() - Store existing lmb state and set up a new state
  *
- * Initialise the LMB subsystem related data structures. There are two
- * alloced lists that are initialised, one for the free memory, and one
- * for the used memory.
+ * This is only used for testing
  *
- * Initialise the two lists as part of board init during boot. When called
- * from a test, passes the pointers to the two lists to the caller. The
- * caller is then required to call the corresponding function to uninit
- * the lists.
- *
- * Return: 0 if OK, -ve on failure.
+ * @store: Place to store the current lmb state
+ * Return: 0 if OK, -ENOMEM if out of memory
  */
-int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
-			 bool add_rsv_mem);
+int lmb_push(struct lmb *store);
 
 /**
- * lmb_mem_regions_uninit() - Unitialise the lmb lists
- * @mem_lst: Pointer to store location of free memory list
- * @used_lst: Pointer to store location of used memory list
+ * lmb_pop() - Restore an old lmb state
+ *
+ * This is only used for testing
  *
- * Unitialise the LMB lists for free and used memory that was
- * initialised as part of the init function. Called when running
- * lmb test routines.
+ * @store: lmb state to restore
  */
-void lmb_mem_regions_uninit(struct alist *mem_lst, struct alist *used_lst);
+void lmb_pop(struct lmb *store);
 
 struct lmb *lmb_get(void);
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 34cbaeaafd5..ce1526f11bc 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -739,31 +739,8 @@ static int lmb_setup(struct lmb *lmb)
 	return 0;
 }
 
-int lmb_init(void)
-{
-	bool ret;
-
-	ret = lmb_setup(&lmb);
-	if (ret) {
-		log_debug("Unable to init LMB\n");
-		return ret;
-	}
-	lmb_add_memory();
-
-	/* Reserve the U-Boot image region once U-Boot has relocated */
-	if (spl_phase() == PHASE_SPL)
-		lmb_reserve_common_spl();
-	else if (spl_phase() == PHASE_BOARD_R)
-		lmb_reserve_common((void *)gd->fdt_blob);
-
-	return 0;
-}
-
 /**
  * lmb_mem_regions_init() - Initialise the LMB memory
- * @mem_lst: Pointer to store location of free memory list
- * @used_lst: Pointer to store location of used memory list
- * @add_rsv_mem: flag to indicate if memory is to be added and reserved
  *
  * Initialise the LMB subsystem related data structures. There are two
  * alloced lists that are initialised, one for the free memory, and one
@@ -776,8 +753,7 @@ int lmb_init(void)
  *
  * Return: 0 if OK, -ve on failure.
  */
-int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
-			 bool add_rsv_mem)
+int lmb_init(void)
 {
 	bool ret;
 
@@ -786,33 +762,37 @@ int lmb_mem_regions_init(struct alist **mem_lst, struct alist **used_lst,
 		log_debug("Unable to init LMB\n");
 		return ret;
 	}
+	lmb_add_memory();
 
-	if (mem_lst)
-		*mem_lst = &lmb.free_mem;
-
-	if (used_lst)
-		*used_lst = &lmb.used_mem;
+	/* Reserve the U-Boot image region once U-Boot has relocated */
+	if (spl_phase() == PHASE_SPL)
+		lmb_reserve_common_spl();
+	else if (spl_phase() == PHASE_BOARD_R)
+		lmb_reserve_common((void *)gd->fdt_blob);
 
 	return 0;
 }
 
-/**
- * lmb_mem_regions_uninit() - Unitialise the lmb lists
- * @mem_lst: Pointer to store location of free memory list
- * @used_lst: Pointer to store location of used memory list
- *
- * Unitialise the LMB lists for free and used memory that was
- * initialised as part of the init function. Called when running
- * lmb test routines.
- */
-void __maybe_unused lmb_mem_regions_uninit(struct alist *mem_lst,
-					   struct alist *used_lst)
+struct lmb *lmb_get(void)
+{
+	return &lmb;
+}
+
+int lmb_push(struct lmb *store)
 {
-	alist_uninit(mem_lst);
-	alist_uninit(used_lst);
+	int ret;
+
+	*store = lmb;
+	ret = lmb_setup(&lmb);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
-struct lmb *lmb_get(void)
+void lmb_pop(struct lmb *store)
 {
-	return &lmb;
+	alist_uninit(&lmb.free_mem);
+	alist_uninit(&lmb.used_mem);
+	lmb = *store;
 }
diff --git a/test/lmb_ut.c b/test/lmb_ut.c
index 49f75e55d2b..dfdc7687321 100644
--- a/test/lmb_ut.c
+++ b/test/lmb_ut.c
@@ -61,6 +61,19 @@ static int check_lmb(struct unit_test_state *uts, struct alist *mem_lst,
 			     num_reserved, base1, size1, base2, size2, base3, \
 			     size3))
 
+static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
+			  struct alist **mem_lstp, struct alist **used_lstp)
+{
+	struct lmb *lmb;
+
+	ut_assertok(lmb_push(store));
+	lmb = lmb_get();
+	*mem_lstp = &lmb->free_mem;
+	*used_lstp = &lmb->used_mem;
+
+	return 0;
+}
+
 static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 			    const phys_size_t ram_size, const phys_addr_t ram0,
 			    const phys_size_t ram0_size,
@@ -73,6 +86,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	struct alist *mem_lst, *used_lst;
 	struct lmb_region *mem, *used;
 	phys_addr_t a, a2, b, b2, c, d;
+	struct lmb store;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
@@ -81,7 +95,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_assert(alloc_64k_addr >= ram + 8);
 	ut_assert(alloc_64k_end <= ram_end - 8);
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -183,7 +197,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 		ut_asserteq(mem[0].size, ram_size);
 	}
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -243,11 +257,12 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	struct lmb_region *mem, *used;
 	long ret;
 	phys_addr_t a, b;
+	struct lmb store;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -284,7 +299,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -315,11 +330,12 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	struct lmb_region *mem, *used;
 	const phys_addr_t alloc_size_aligned = (alloc_size + align - 1) &
 		~(align - 1);
+	struct lmb store;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -366,7 +382,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -411,8 +427,9 @@ static int lmb_test_lmb_at_0_norun(struct unit_test_state *uts)
 	struct lmb_region *mem, *used;
 	long ret;
 	phys_addr_t a, b;
+	struct lmb store;
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -441,7 +458,7 @@ static int lmb_test_lmb_at_0_norun(struct unit_test_state *uts)
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -455,8 +472,9 @@ static int lmb_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
 	struct alist *mem_lst, *used_lst;
 	struct lmb_region *mem, *used;
 	long ret;
+	struct lmb store;
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -496,7 +514,7 @@ static int lmb_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -517,11 +535,12 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	const phys_size_t alloc_addr_c = ram + 0x8000000 * 3;
 	long ret;
 	phys_addr_t a, b, c, d, e;
+	struct lmb store;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -618,7 +637,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		ut_asserteq(ret, 0);
 	}
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -648,13 +667,15 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	const phys_size_t alloc_addr_a = ram + 0x8000000;
 	const phys_size_t alloc_addr_b = ram + 0x8000000 * 2;
 	const phys_size_t alloc_addr_c = ram + 0x8000000 * 3;
+	struct lmb store;
 	long ret;
 	phys_size_t s;
 
 	/* check for overflow */
 	ut_assert(ram_end == 0 || ram_end > ram);
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
+
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -693,7 +714,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	s = lmb_get_free_size(ram_end - 4);
 	ut_asserteq(s, 4);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
@@ -718,9 +739,10 @@ static int lmb_test_lmb_flags_norun(struct unit_test_state *uts)
 	struct alist *mem_lst, *used_lst;
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
+	struct lmb store;
 	long ret;
 
-	ut_asserteq(lmb_mem_regions_init(&mem_lst, &used_lst, false), 0);
+	ut_assertok(setup_lmb_test(uts, &store, &mem_lst, &used_lst));
 	mem = mem_lst->data;
 	used = used_lst->data;
 
@@ -798,7 +820,7 @@ static int lmb_test_lmb_flags_norun(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 	ut_asserteq(lmb_is_nomap(&used[2]), 1);
 
-	lmb_mem_regions_uninit(mem_lst, used_lst);
+	lmb_pop(&store);
 
 	return 0;
 }
-- 
2.34.1

