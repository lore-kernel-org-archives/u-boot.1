Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983D4CD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4082888CA8;
	Thu,  5 Sep 2024 10:28:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 769D388C91; Thu,  5 Sep 2024 10:28:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0917A88CA3
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1546EFEC;
 Thu,  5 Sep 2024 01:29:21 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224B33F66E;
 Thu,  5 Sep 2024 01:28:51 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 07/16] lmb: notify of any changes to the LMB memory map
Date: Thu,  5 Sep 2024 13:58:02 +0530
Message-Id: <20240905082811.1585467-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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

In U-Boot, LMB and EFI are two primary modules who provide memory
allocation and reservation API's. Both these modules operate with the
same regions of memory for allocations. Use the LMB memory map update
event to notify other interested listeners about a change in it's
memory map. This can then be used by the other module to keep track of
available and used memory.

There is no need to send these notifications when the LMB module is
being unit-tested. Add a flag to the lmb structure to indicate if the
memory map is being used for tests, and suppress sending any
notifications when running these unit tests.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h |  2 ++
 lib/lmb.c     | 74 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index ffba7e2889..f711b8fac8 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -44,10 +44,12 @@ struct lmb_region {
  *
  * @free_mem:	List of free memory regions
  * @used_mem:	List of used/reserved memory regions
+ * @test:	Is structure being used for LMB tests
  */
 struct lmb {
 	struct alist free_mem;
 	struct alist used_mem;
+	bool test;
 };
 
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 419b31a651..aff2830cb9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -8,6 +8,7 @@
 
 #include <alist.h>
 #include <efi_loader.h>
+#include <event.h>
 #include <image.h>
 #include <mapmem.h>
 #include <lmb.h>
@@ -22,10 +23,33 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define MAP_OP_RESERVE		(u8)0x1
+#define MAP_OP_FREE		(u8)0x2
+#define MAP_OP_ADD		(u8)0x3
+
 #define LMB_ALLOC_ANYWHERE	0
 #define LMB_ALIST_INITIAL_SIZE	4
 
 static struct lmb lmb;
+extern bool is_addr_in_ram(uintptr_t addr);
+
+static bool lmb_notify(enum lmb_flags flags)
+{
+	return !lmb.test && !(flags & LMB_NONOTIFY);
+}
+
+static void lmb_map_update_notify(phys_addr_t addr, phys_size_t size,
+				  u8 op)
+{
+	struct event_lmb_map_update lmb_map = {0};
+
+	lmb_map.base = addr;
+	lmb_map.size = size;
+	lmb_map.op = op;
+
+	if (is_addr_in_ram((uintptr_t)addr))
+		event_notify(EVT_LMB_MAP_UPDATE, &lmb_map, sizeof(lmb_map));
+}
 
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
@@ -474,9 +498,17 @@ static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
 /* This routine may be called with relocation disabled. */
 long lmb_add(phys_addr_t base, phys_size_t size)
 {
+	long ret;
 	struct alist *lmb_rgn_lst = &lmb.free_mem;
 
-	return lmb_add_region(lmb_rgn_lst, base, size);
+	ret = lmb_add_region(lmb_rgn_lst, base, size);
+	if (ret)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+		lmb_map_update_notify(base, size, MAP_OP_ADD);
+
+	return 0;
 }
 
 static long __lmb_free(phys_addr_t base, phys_size_t size)
@@ -530,22 +562,39 @@ static long __lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn[i].flags);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
+long lmb_free_flags(phys_addr_t base, phys_size_t size,
+		    uint flags)
 {
-	return __lmb_free(base, size);
+	long ret;
+
+	ret = __lmb_free(base, size);
+	if (ret < 0)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
+		lmb_map_update_notify(base, size, MAP_OP_FREE);
+
+	return ret;
 }
 
-long lmb_free_flags(phys_addr_t base, phys_size_t size,
-		    __always_unused uint flags)
+long lmb_free(phys_addr_t base, phys_size_t size)
 {
 	return __lmb_free(base, size);
 }
 
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
+	long ret = 0;
 	struct alist *lmb_rgn_lst = &lmb.used_mem;
 
-	return lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
+	ret = lmb_add_region_flags(lmb_rgn_lst, base, size, flags);
+	if (ret < 0)
+		return -1;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) && lmb_notify(flags))
+		lmb_map_update_notify(base, size, MAP_OP_RESERVE);
+
+	return ret;
 }
 
 long lmb_reserve(phys_addr_t base, phys_size_t size)
@@ -607,6 +656,11 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 				if (lmb_add_region_flags(&lmb.used_mem, base,
 							 size, flags) < 0)
 					return 0;
+
+				if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY) &&
+				    lmb_notify(flags))
+					lmb_map_update_notify(base, size,
+							      MAP_OP_RESERVE);
 				return base;
 			}
 
@@ -740,7 +794,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 	return 0;
 }
 
-static int lmb_setup(void)
+static int lmb_setup(bool test)
 {
 	bool ret;
 
@@ -758,6 +812,8 @@ static int lmb_setup(void)
 		return -ENOMEM;
 	}
 
+	lmb.test = test;
+
 	return 0;
 }
 
@@ -777,7 +833,7 @@ int lmb_init(void)
 {
 	int ret;
 
-	ret = lmb_setup();
+	ret = lmb_setup(false);
 	if (ret) {
 		log_info("Unable to init LMB\n");
 		return ret;
@@ -805,7 +861,7 @@ int lmb_push(struct lmb *store)
 	int ret;
 
 	*store = lmb;
-	ret = lmb_setup();
+	ret = lmb_setup(true);
 	if (ret)
 		return ret;
 
-- 
2.34.1

