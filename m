Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1789FC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F18381253;
	Mon,  3 Mar 2025 14:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4372581249; Mon,  3 Mar 2025 14:32:59 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E0108811B2
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DBB6106F;
 Mon,  3 Mar 2025 05:33:10 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B5A3F673;
 Mon,  3 Mar 2025 05:32:53 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 1/6] lmb: check if a region can be reserved by lmb_reserve()
Date: Mon,  3 Mar 2025 19:02:26 +0530
Message-Id: <20250303133231.405279-2-sughosh.ganu@linaro.org>
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

The logic used in lmb_alloc() takes into consideration the existing
reserved regions, and ensures that the allocated region does not
overlap with any existing allocated regions. The lmb_reserve()
function is not doing any such checks -- the requested region might
overlap with an existing region. This also shows up with
lmb_alloc_addr() as this function ends up calling lmb_reserve().

Add a function which checks if the region requested is overlapping
with an existing reserved region, and allow for the reservation to
happen only if both the regions have LMB_NONE flag, which allows
re-requesting of the region. In any other scenario of an overlap, have
lmb_reserve() return -EEXIST, implying that the requested region is
already reserved.

Add corresponding test cases which check for overlapping reservation
requests made through lmb_reserve() and lmb_alloc_addr(). And while
here, fix some of the comments in the test function being touched.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Changes since V2: None

 lib/lmb.c      |  36 ++++++++++++++++
 test/lib/lmb.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 146 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 93fc1bea07c..32c787f8adf 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -561,6 +561,39 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	}
 }
 
+/**
+ * lmb_can_reserve_region() - check if the region can be reserved
+ * @base: base address of region to be reserved
+ * @size: size of region to be reserved
+ * @flags: flag of the region to be reserved
+ *
+ * Go through all the reserved regions and ensure that the requested
+ * region does not overlap with any existing regions. An overlap is
+ * allowed only when the flag of the request region and the existing
+ * region is LMB_NONE.
+ *
+ * Return: true if region can be reserved, false otherwise
+ */
+static bool lmb_can_reserve_region(phys_addr_t base, phys_size_t size,
+				   u32 flags)
+{
+	uint i;
+	struct lmb_region *lmb_reserved = lmb.used_mem.data;
+
+	for (i = 0; i < lmb.used_mem.count; i++) {
+		u32 rgnflags = lmb_reserved[i].flags;
+		phys_addr_t rgnbase = lmb_reserved[i].base;
+		phys_size_t rgnsize = lmb_reserved[i].size;
+
+		if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
+			if (flags != LMB_NONE || flags != rgnflags)
+				return false;
+		}
+	}
+
+	return true;
+}
+
 void lmb_add_memory(void)
 {
 	int i;
@@ -633,6 +666,9 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, u32 flags)
 	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
+	if (!lmb_can_reserve_region(base, size, flags))
+		return -EEXIST;
+
 	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
 	if (ret)
 		return ret;
diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index fcb5f1af532..24416e83491 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -471,17 +471,17 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-	/* allocate overlapping region should return the coalesced count */
+	/* allocate overlapping region */
 	ret = lmb_reserve(0x40011000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x11000,
 		   0, 0, 0, 0);
-	/* allocate 3nd region */
+	/* allocate 2nd region */
 	ret = lmb_reserve(0x40030000, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40010000, 0x11000,
 		   0x40030000, 0x10000, 0, 0);
-	/* allocate 2nd region , This should coalesced all region into one */
+	/* allocate 3rd region , This should coalesce all regions into one */
 	ret = lmb_reserve(0x40020000, 0x10000, LMB_NONE);
 	ut_assert(ret >= 0);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x30000,
@@ -499,6 +499,41 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40000000, 0x40000,
 		   0, 0, 0, 0);
 
+	/* try to allocate overlapping region with a different flag, should fail */
+	ret = lmb_reserve(0x40008000, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(ret, -EEXIST);
+
+	/* allocate another region at 0x40050000 with a different flag */
+	ret = lmb_reserve(0x40050000, 0x10000, LMB_NOOVERWRITE);
+	ut_asserteq(ret, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x40000,
+		   0x40050000, 0x10000, 0, 0);
+
+	/*
+	 * try to reserve a region adjacent to region 1 overlapping the 2nd region,
+	 * should fail
+	 */
+	ret = lmb_reserve(0x40040000, 0x20000, LMB_NONE);
+	ut_asserteq(ret, -EEXIST);
+
+	/*
+	 * try to reserve a region between the two regions, but without an overlap,
+	 * should succeed. this added region coalesces with the region 1
+	 */
+	ret = lmb_reserve(0x40040000, 0x10000, LMB_NONE);
+	ut_asserteq(ret, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
+		   0x40050000, 0x10000, 0, 0);
+
+	/*
+	 * try to reserve a region which overlaps with both the regions,
+	 * should fail as the flags do not match
+	 */
+	ret = lmb_reserve(0x40020000, 0x80000, LMB_NONE);
+	ut_asserteq(ret, -EEXIST);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, 0x40000000, 0x50000,
+		   0x40050000, 0x10000, 0, 0);
+
 	lmb_pop(&store);
 
 	return 0;
@@ -549,6 +584,77 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	ret = lmb_free(alloc_addr_a, 0x1000);
 	ut_asserteq(ret, 0);
 
+	/*
+	 * Add two regions with different flags, region1 and region2 with
+	 * a gap between them.
+	 * Try adding another region, adjacent to region 1 and overlapping
+	 * region 2. Should fail.
+	 */
+	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(a, alloc_addr_a);
+
+	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, alloc_addr_a + 0x4000);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
+		   b, 0x1000, 0, 0);
+
+	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
+	ut_asserteq(c, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
+		   b, 0x1000, 0, 0);
+
+	ret = lmb_free(a, 0x1000);
+	ut_asserteq(ret, 0);
+	ret = lmb_free(b, 0x1000);
+	ut_asserteq(ret, 0);
+
+	/*
+	 * Add two regions with same flags(LMB_NONE), region1 and region2
+	 * with a gap between them.
+	 * Try adding another region, adjacent to region 1 and overlapping
+	 * region 2. Should succeed. All regions should coalesce into a
+	 * single region.
+	 */
+	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NONE);
+	ut_asserteq(a, alloc_addr_a);
+
+	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NONE);
+	ut_asserteq(b, alloc_addr_a + 0x4000);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
+		   b, 0x1000, 0, 0);
+
+	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NONE);
+	ut_asserteq(c, alloc_addr_a + 0x1000);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, a, 0x6000,
+		   0, 0, 0, 0);
+
+	ret = lmb_free(a, 0x6000);
+	ut_asserteq(ret, 0);
+
+	/*
+	 * Add two regions with same flags(LMB_NOOVERWRITE), region1 and
+	 * region2 with a gap between them.
+	 * Try adding another region, adjacent to region 1 and overlapping
+	 * region 2. Should fail.
+	 */
+	a = lmb_alloc_addr(alloc_addr_a, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(a, alloc_addr_a);
+
+	b = lmb_alloc_addr(alloc_addr_a + 0x4000, 0x1000, LMB_NOOVERWRITE);
+	ut_asserteq(b, alloc_addr_a + 0x4000);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
+		   b, 0x1000, 0, 0);
+
+	c = lmb_alloc_addr(alloc_addr_a + 0x1000, 0x5000, LMB_NOOVERWRITE);
+	ut_asserteq(c, 0);
+	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 2, a, 0x1000,
+		   b, 0x1000, 0, 0);
+
+	ret = lmb_free(a, 0x1000);
+	ut_asserteq(ret, 0);
+	ret = lmb_free(b, 0x1000);
+	ut_asserteq(ret, 0);
+
 	/*  reserve 3 blocks */
 	ret = lmb_reserve(alloc_addr_a, 0x10000, LMB_NONE);
 	ut_asserteq(ret, 0);
@@ -760,7 +866,7 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	/* reserve again, new flag */
 	ret = lmb_reserve(0x40010000, 0x10000, LMB_NONE);
-	ut_asserteq(ret, -1);
+	ut_asserteq(ret, -EEXIST);
 	ASSERT_LMB(mem_lst, used_lst, ram, ram_size, 1, 0x40010000, 0x10000,
 		   0, 0, 0, 0);
 
-- 
2.34.1

