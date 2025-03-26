Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35393C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 16:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9917F81253;
	Wed, 26 Mar 2025 17:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0A1381C84; Wed, 26 Mar 2025 17:53:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 95183810E8
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504241424;
 Wed, 26 Mar 2025 09:53:59 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 529593F58B;
 Wed, 26 Mar 2025 09:53:52 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] test: lmb: fix the lmb_alloc_addr() based test cases
Date: Wed, 26 Mar 2025 22:23:36 +0530
Message-Id: <20250326165336.547689-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Commit 56f186a68b3 ("lmb: check if a region can be reserved by
lmb_reserve()") fixed the lmb_reserve() and lmb_alloc_addr() API's for
some corner case scenarios, and also added corresonding test cases for
these corner cases. These tests were checking, among other things, the
lmb_alloc_addr() API. The above commit was applied to the next branch.

Subsequently, there was commit 67be24906fe
("lmb: change the return code on lmb_alloc_addr()") which was first
applied on the master branch, and subsequently got merged to next as
part of the rebase. The second commit changes the return value of the
lmb_alloc_addr() API, which now results in some of the tests added as
part of the first commit to fail. Fix those test cases.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Note: To be applied on next

 test/lib/lmb.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index ad916740d90..3bf558f7f4f 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -591,21 +591,21 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	 * region 2. Should fail.
 	 */
 	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
-	ut_asserteq(a, alloc_addr_a);
+	ut_asserteq(a, 0);
 
 	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, alloc_addr_a + 0x4000);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
-		   b, 0x1000, 0, 0);
+	ut_asserteq(b, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
+		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
 	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
-	ut_asserteq(c, 0);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
-		   b, 0x1000, 0, 0);
+	ut_asserteq(c, -1);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
+		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
-	ret = lmb_free(a, 0x1000);
+	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
-	ret = lmb_free(b, 0x1000);
+	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000);
 	ut_asserteq(ret, 0);
 
 	/*
@@ -616,19 +616,19 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	 * single region.
 	 */
 	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
-	ut_asserteq(a, alloc_addr_a);
+	ut_asserteq(a, 0);
 
 	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NONE);
-	ut_asserteq(b, alloc_addr_a + 0x4000);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
-		   b, 0x1000, 0, 0);
+	ut_asserteq(b, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
+		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
 	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
-	ut_asserteq(c, alloc_addr_a + 0x1000);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, 0x6000,
+	ut_asserteq(c, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, alloc_addr_a, 0x6000,
 		   0, 0, 0, 0);
 
-	ret = lmb_free(a, 0x6000);
+	ret = lmb_free(alloc_addr_a, 0x6000);
 	ut_asserteq(ret, 0);
 
 	/*
@@ -638,21 +638,21 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	 * region 2. Should fail.
 	 */
 	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(a, alloc_addr_a);
+	ut_asserteq(a, 0);
 
 	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
-	ut_asserteq(b, alloc_addr_a + 0x4000);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
-		   b, 0x1000, 0, 0);
+	ut_asserteq(b, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
+		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
 	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NOOVERWRITE);
-	ut_asserteq(c, 0);
-	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
-		   b, 0x1000, 0, 0);
+	ut_asserteq(c, -1);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, alloc_addr_a, 0x1000,
+		   alloc_addr_a + 0x4000, 0x1000, 0, 0);
 
-	ret = lmb_free(a, 0x1000);
+	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
-	ret = lmb_free(b, 0x1000);
+	ret = lmb_free(alloc_addr_a + 0x4000, 0x1000);
 	ut_asserteq(ret, 0);
 
 	/*  reserve 3 blocks */
-- 
2.34.1

