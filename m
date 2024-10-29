Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B220D13590
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 07:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8DC8910C;
	Tue, 29 Oct 2024 08:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83B378915B; Tue, 29 Oct 2024 08:19:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 626768914D
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 08:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EF9113D5;
 Tue, 29 Oct 2024 00:19:30 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACD783F66E;
 Tue, 29 Oct 2024 00:18:58 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Janne Grunau <janne@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 1/2] lmb: refactor lmb push and pop functions
Date: Tue, 29 Oct 2024 12:48:45 +0530
Message-Id: <20241029071846.514559-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029071846.514559-1-sughosh.ganu@linaro.org>
References: <20241029071846.514559-1-sughosh.ganu@linaro.org>
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

The LMB module uses a separate instance of the lmb structure when
running tests. Setting up the correct instance is done using the
lmb_push() and lmb_pop() functions. In addition to pushing and popping
the lmb instances, these functions are also doing some test specific
operations. Move these operations to lmb_test_push() and
lmb_test_pop() functions, so that lmb_push() and lmb_pop() can be
called from elsewhere.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h  |  4 +++-
 lib/lmb.c      | 20 ++++++++++++++++----
 test/lib/lmb.c | 18 +++++++++---------
 3 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index e46abf400c6..72d7093023a 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -171,8 +171,10 @@ void lmb_dump_all_force(void);
 void lmb_arch_add_memory(void);
 
 struct lmb *lmb_get(void);
-int lmb_push(struct lmb *store);
+void lmb_push(struct lmb *store);
 void lmb_pop(struct lmb *store);
+int lmb_test_push(struct lmb *store);
+void lmb_test_pop(struct lmb *store);
 
 static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
 {
diff --git a/lib/lmb.c b/lib/lmb.c
index eec99c185ee..2960c05abfc 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -892,12 +892,23 @@ struct lmb *lmb_get(void)
 	return &lmb;
 }
 
+void lmb_push(struct lmb *store)
+{
+	*store = lmb;
+}
+
+void lmb_pop(struct lmb *store)
+{
+	lmb = *store;
+}
+
 #if CONFIG_IS_ENABLED(UNIT_TEST)
-int lmb_push(struct lmb *store)
+int lmb_test_push(struct lmb *store)
 {
 	int ret;
 
-	*store = lmb;
+	lmb_push(store);
+
 	ret = lmb_setup(true);
 	if (ret)
 		return ret;
@@ -905,10 +916,11 @@ int lmb_push(struct lmb *store)
 	return 0;
 }
 
-void lmb_pop(struct lmb *store)
+void lmb_test_pop(struct lmb *store)
 {
 	alist_uninit(&lmb.free_mem);
 	alist_uninit(&lmb.used_mem);
-	lmb = *store;
+
+	lmb_pop(store);
 }
 #endif /* UNIT_TEST */
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index b2c54fb4bcb..64e619eff22 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -63,7 +63,7 @@ static int setup_lmb_test(struct unit_test_state *uts, struct lmb *store,
 {
 	struct lmb *lmb;
 
-	ut_assertok(lmb_push(store));
+	ut_assertok(lmb_test_push(store));
 	lmb = lmb_get();
 	*mem_lstp = &lmb->free_mem;
 	*used_lstp = &lmb->used_mem;
@@ -194,7 +194,7 @@ static int test_multi_alloc(struct unit_test_state *uts, const phys_addr_t ram,
 		ut_asserteq(mem[0].size, ram_size);
 	}
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -293,7 +293,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_64k_addr, 0x10000,
 		   0, 0, 0, 0);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -373,7 +373,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -446,7 +446,7 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 0, 0, 0, 0, 0, 0, 0);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -499,7 +499,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -619,7 +619,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 		ut_asserteq(ret, 0);
 	}
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -691,7 +691,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	s = lmb_get_free_size(ram_end - 4);
 	ut_asserteq(s, 4);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
@@ -797,7 +797,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 	ut_asserteq(lmb_is_nomap(&used[1]), 0);
 	ut_asserteq(lmb_is_nomap(&used[2]), 1);
 
-	lmb_pop(&store);
+	lmb_test_pop(&store);
 
 	return 0;
 }
-- 
2.34.1

