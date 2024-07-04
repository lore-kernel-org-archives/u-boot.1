Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6137CC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2D68881D;
	Thu,  4 Jul 2024 09:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED661888F5; Thu,  4 Jul 2024 09:37:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BC2188890F
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49381367;
 Thu,  4 Jul 2024 00:37:24 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251703F762;
 Thu,  4 Jul 2024 00:36:55 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 15/48] test: lmb: remove the test for max regions
Date: Thu,  4 Jul 2024 13:05:11 +0530
Message-Id: <20240704073544.670249-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

The LMB memory map is now persistent and global, and the
CONFIG_LMB_USE_MAX_REGIONS config symbol has now been removed. Remove
the corresponding lmb test case.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 test/lib/lmb.c | 67 --------------------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/test/lib/lmb.c b/test/lib/lmb.c
index 9f6b5633a7..a3a7ad904c 100644
--- a/test/lib/lmb.c
+++ b/test/lib/lmb.c
@@ -648,73 +648,6 @@ static int lib_test_lmb_get_free_size(struct unit_test_state *uts)
 }
 LIB_TEST(lib_test_lmb_get_free_size, 0);
 
-#ifdef CONFIG_LMB_USE_MAX_REGIONS
-static int lib_test_lmb_max_regions(struct unit_test_state *uts)
-{
-	const phys_addr_t ram = 0x00000000;
-	/*
-	 * All of 32bit memory space will contain regions for this test, so
-	 * we need to scale ram_size (which in this case is the size of the lmb
-	 * region) to match.
-	 */
-	const phys_size_t ram_size = ((0xFFFFFFFF >> CONFIG_LMB_MAX_REGIONS)
-			+ 1) * CONFIG_LMB_MAX_REGIONS;
-	const phys_size_t blk_size = 0x10000;
-	phys_addr_t offset;
-	int ret, i;
-
-	ut_asserteq(lmb.memory.cnt, 0);
-	ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS);
-	ut_asserteq(lmb.reserved.cnt, 0);
-	ut_asserteq(lmb.reserved.max, CONFIG_LMB_MAX_REGIONS);
-
-	/*  Add CONFIG_LMB_MAX_REGIONS memory regions */
-	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
-		offset = ram + 2 * i * ram_size;
-		ret = lmb_add(offset, ram_size);
-		ut_asserteq(ret, 0);
-	}
-	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
-	ut_asserteq(lmb.reserved.cnt, 0);
-
-	/*  error for the (CONFIG_LMB_MAX_REGIONS + 1) memory regions */
-	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * ram_size;
-	ret = lmb_add(offset, ram_size);
-	ut_asserteq(ret, -1);
-
-	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
-	ut_asserteq(lmb.reserved.cnt, 0);
-
-	/*  reserve CONFIG_LMB_MAX_REGIONS regions */
-	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++) {
-		offset = ram + 2 * i * blk_size;
-		ret = lmb_reserve(offset, blk_size);
-		ut_asserteq(ret, 0);
-	}
-
-	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
-	ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_REGIONS);
-
-	/*  error for the 9th reserved blocks */
-	offset = ram + 2 * (CONFIG_LMB_MAX_REGIONS + 1) * blk_size;
-	ret = lmb_reserve(offset, blk_size);
-	ut_asserteq(ret, -1);
-
-	ut_asserteq(lmb.memory.cnt, CONFIG_LMB_MAX_REGIONS);
-	ut_asserteq(lmb.reserved.cnt, CONFIG_LMB_MAX_REGIONS);
-
-	/*  check each regions */
-	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
-		ut_asserteq(lmb.memory.region[i].base, ram + 2 * i * ram_size);
-
-	for (i = 0; i < CONFIG_LMB_MAX_REGIONS; i++)
-		ut_asserteq(lmb.reserved.region[i].base, ram + 2 * i * blk_size);
-
-	return 0;
-}
-LIB_TEST(lib_test_lmb_max_regions, 0);
-#endif
-
 static int lib_test_lmb_flags(struct unit_test_state *uts)
 {
 	const phys_addr_t ram = 0x40000000;
-- 
2.34.1

