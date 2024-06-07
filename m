Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B557BC27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0930884C7;
	Fri,  7 Jun 2024 20:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A608848F; Fri,  7 Jun 2024 20:54:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2038B88568
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F89C1480;
 Fri,  7 Jun 2024 11:55:21 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20373F792;
 Fri,  7 Jun 2024 11:54:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 26/31] test: lmb: run lmb tests only manually
Date: Sat,  8 Jun 2024 00:22:35 +0530
Message-Id: <20240607185240.1892031-27-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

The LMB code has been changed so that the memory reservations and
allocations are now persistent and global. With this change, the
design of the LMB tests needs to be changed accordingly. For now, mark
the LMB tests to be run only manually. The tests won't be run as part
of the unit test suite, and thus would not interfere with the running
of the rest of the tests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 test/lib/lmb.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 67a6be5bc3..813f7e3100 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -195,7 +195,7 @@ static int test_multi_alloc_512mb_x2(struct unit_test_state *uts,
 }
 
 /* Create a memory region with one reserved region and allocate */
-static int lib_test_lmb_simple(struct unit_test_state *uts)
+static int lib_test_lmb_simple_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -207,10 +207,10 @@ static int lib_test_lmb_simple(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_multi_alloc_512mb(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_simple, 0);
+LIB_TEST(lib_test_lmb_simple_norun, UT_TESTF_MANUAL);
 
 /* Create two memory regions with one reserved region and allocate */
-static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
+static int lib_test_lmb_simple_x2_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -222,7 +222,7 @@ static int lib_test_lmb_simple_x2(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 3.5GiB and 1 GiB */
 	return test_multi_alloc_512mb_x2(uts, 0xE0000000, 0x40000000);
 }
-LIB_TEST(lib_test_lmb_simple_x2, 0);
+LIB_TEST(lib_test_lmb_simple_x2_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, allocate some blocks that fit/don't fit */
 static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
@@ -275,7 +275,7 @@ static int test_bigblock(struct unit_test_state *uts, const phys_addr_t ram)
 	return 0;
 }
 
-static int lib_test_lmb_big(struct unit_test_state *uts)
+static int lib_test_lmb_big_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -287,7 +287,7 @@ static int lib_test_lmb_big(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_bigblock(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_big, 0);
+LIB_TEST(lib_test_lmb_big_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, allocate a block without previous reservation */
 static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
@@ -348,7 +348,7 @@ static int test_noreserved(struct unit_test_state *uts, const phys_addr_t ram,
 	return 0;
 }
 
-static int lib_test_lmb_noreserved(struct unit_test_state *uts)
+static int lib_test_lmb_noreserved_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -360,10 +360,9 @@ static int lib_test_lmb_noreserved(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 4, 1);
 }
+LIB_TEST(lib_test_lmb_noreserved_norun, UT_TESTF_MANUAL);
 
-LIB_TEST(lib_test_lmb_noreserved, 0);
-
-static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
+static int lib_test_lmb_unaligned_size_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -375,13 +374,13 @@ static int lib_test_lmb_unaligned_size(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_noreserved(uts, 0xE0000000, 5, 8);
 }
-LIB_TEST(lib_test_lmb_unaligned_size, 0);
+LIB_TEST(lib_test_lmb_unaligned_size_norun, UT_TESTF_MANUAL);
 
 /*
  * Simulate a RAM that starts at 0 and allocate down to address 0, which must
  * fail as '0' means failure for the lmb_alloc functions.
  */
-static int lib_test_lmb_at_0(struct unit_test_state *uts)
+static int lib_test_lmb_at_0_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0;
 	const phys_size_t ram_size = 0x20000000;
@@ -417,9 +416,9 @@ static int lib_test_lmb_at_0(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_at_0, 0);
+LIB_TEST(lib_test_lmb_at_0_norun, UT_TESTF_MANUAL);
 
-static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
+static int lib_test_lmb_overlapping_add_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
@@ -433,10 +432,10 @@ static int lib_test_lmb_overlapping_add(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_overlapping_add, 0);
+LIB_TEST(lib_test_lmb_overlapping_add_norun, UT_TESTF_MANUAL);
 
 /* Check that calling lmb_reserve with overlapping regions fails. */
-static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
+static int lib_test_lmb_overlapping_reserve_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
@@ -480,7 +479,7 @@ static int lib_test_lmb_overlapping_reserve(struct unit_test_state *uts)
 		   0, 0, 0, 0);
 	return 0;
 }
-LIB_TEST(lib_test_lmb_overlapping_reserve, 0);
+LIB_TEST(lib_test_lmb_overlapping_reserve_norun, UT_TESTF_MANUAL);
 
 /*
  * Simulate 512 MiB RAM, reserve 3 blocks, allocate addresses in between.
@@ -596,7 +595,7 @@ static int test_alloc_addr(struct unit_test_state *uts, const phys_addr_t ram)
 	return 0;
 }
 
-static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
+static int lib_test_lmb_alloc_addr_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -608,7 +607,7 @@ static int lib_test_lmb_alloc_addr(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_alloc_addr(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_alloc_addr, 0);
+LIB_TEST(lib_test_lmb_alloc_addr_norun, UT_TESTF_MANUAL);
 
 /* Simulate 512 MiB RAM, reserve 3 blocks, check addresses in between */
 static int test_get_unreserved_size(struct unit_test_state *uts,
@@ -665,7 +664,7 @@ static int test_get_unreserved_size(struct unit_test_state *uts,
 	return 0;
 }
 
-static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
+static int lib_test_lmb_get_free_size_norun(struct unit_test_state *uts)
 {
 	int ret;
 
@@ -677,10 +676,10 @@ static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
 	/* simulate 512 MiB RAM beginning at 1.5GiB */
 	return test_get_unreserved_size(uts, 0xE0000000);
 }
-LIB_TEST(lib_test_lmb_get_free_size, 0);
+LIB_TEST(lib_test_lmb_get_free_size_norun, UT_TESTF_MANUAL);
 
 #ifdef CONFIG_LMB_USE_MAX_REGIONS
-static int lib_test_lmb_max_regions(struct unit_test_state *uts)
+static int lib_test_lmb_max_regions_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x00000000;
 	/*
@@ -745,10 +744,10 @@ static int lib_test_lmb_max_regions(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_max_regions, 0);
+LIB_TEST(lib_test_lmb_max_regions_norun, UT_TESTF_MANUAL);
 #endif
 
-static int lib_test_lmb_flags(struct unit_test_state *uts)
+static int lib_test_lmb_flags_norun(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
 	const phys_size_t ram_size = 0x20000000;
@@ -832,4 +831,4 @@ static int lib_test_lmb_flags(struct unit_test_state *uts)
 
 	return 0;
 }
-LIB_TEST(lib_test_lmb_flags, 0);
+LIB_TEST(lib_test_lmb_flags_norun, UT_TESTF_MANUAL);
-- 
2.34.1

