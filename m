Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADABC52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 11:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393EF88A79;
	Wed, 14 Aug 2024 13:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFFA088815; Wed, 14 Aug 2024 13:03:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3A88888A82
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 13:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86894DA7;
 Wed, 14 Aug 2024 04:03:24 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131BC3F58B;
 Wed, 14 Aug 2024 04:02:53 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 29/32] test: bdinfo: dump the global LMB memory map
Date: Wed, 14 Aug 2024 16:30:06 +0530
Message-Id: <20240814110009.45310-30-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814110009.45310-1-sughosh.ganu@linaro.org>
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
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

The LMB code has been changed to make the memory reservations
persistent and global. Make corresponding change the the
lmb_test_dump_all() function to print the global LMB available and
used memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Get the alloced lists through the lmb_get() function.

 test/cmd/bdinfo.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 1cd81a195b..7dd3f7ca5b 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -5,6 +5,7 @@
  * Copyright 2023 Marek Vasut <marek.vasut+renesas@mailbox.org>
  */
 
+#include <alist.h>
 #include <console.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
@@ -21,6 +22,7 @@
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <display_options.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -99,19 +101,20 @@ static int test_video_info(struct unit_test_state *uts)
 }
 
 static int lmb_test_dump_region(struct unit_test_state *uts,
-				struct lmb_region *rgn, char *name)
+				struct alist *lmb_rgn_lst, char *name)
 {
+	struct lmb_region *rgn = lmb_rgn_lst->data;
 	unsigned long long base, size, end;
 	enum lmb_flags flags;
 	int i;
 
-	ut_assert_nextline(" %s.cnt = 0x%lx / max = 0x%lx", name, rgn->cnt, rgn->max);
+	ut_assert_nextline(" %s.count = 0x%hx", name, lmb_rgn_lst->count);
 
-	for (i = 0; i < rgn->cnt; i++) {
-		base = rgn->region[i].base;
-		size = rgn->region[i].size;
+	for (i = 0; i < lmb_rgn_lst->count; i++) {
+		base = rgn[i].base;
+		size = rgn[i].size;
 		end = base + size - 1;
-		flags = rgn->region[i].flags;
+		flags = rgn[i].flags;
 
 		if (!IS_ENABLED(CONFIG_SANDBOX) && i == 3) {
 			ut_assert_nextlinen(" %s[%d]\t[", name, i);
@@ -124,11 +127,13 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 	return 0;
 }
 
-static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
+static int lmb_test_dump_all(struct unit_test_state *uts)
 {
+	struct lmb *lmb = lmb_get();
+
 	ut_assert_nextline("lmb_dump_all:");
-	ut_assertok(lmb_test_dump_region(uts, &lmb->memory, "memory"));
-	ut_assertok(lmb_test_dump_region(uts, &lmb->reserved, "reserved"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->free_mem, "memory"));
+	ut_assertok(lmb_test_dump_region(uts, &lmb->used_mem, "reserved"));
 
 	return 0;
 }
@@ -190,9 +195,7 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 #endif
 
 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
-		struct lmb lmb;
-
-		ut_assertok(lmb_test_dump_all(uts, &lmb));
+		ut_assertok(lmb_test_dump_all(uts));
 		if (IS_ENABLED(CONFIG_OF_REAL))
 			ut_assert_nextline("devicetree  = %s", fdtdec_get_srcname());
 	}
-- 
2.34.1

