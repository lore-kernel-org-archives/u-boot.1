Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443A9C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B3D088473;
	Fri,  7 Jun 2024 20:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA7D4884FC; Fri,  7 Jun 2024 20:54:20 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A12DB88485
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709F21480;
 Fri,  7 Jun 2024 11:54:42 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 224203F792;
 Fri,  7 Jun 2024 11:54:14 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 14/31] lmb: notify of any changes to the LMB memory map
Date: Sat,  8 Jun 2024 00:22:23 +0530
Message-Id: <20240607185240.1892031-15-sughosh.ganu@linaro.org>
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

In U-Boot, LMB and EFI are two primary modules who provide memory
allocation and reservation API's. Both these modules operate with the
same regions of memory for allocations. Use the LMB memory map update
event to notify other interested listeners about a change in it's
memory map. This can then be used by the other module to allocate
memory only from available regions, instead of overwriting already
allocated memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/lmb.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 0a4f3d5bcd..313735dbe3 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -7,6 +7,7 @@
  */
 
 #include <efi_loader.h>
+#include <event.h>
 #include <image.h>
 #include <mapmem.h>
 #include <lmb.h>
@@ -18,8 +19,13 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define MAP_OP_RESERVE		(u8)0x1
+#define MAP_OP_FREE		(u8)0x2
+
 #define LMB_ALLOC_ANYWHERE	0
 
+extern bool is_addr_in_ram(uintptr_t addr);
+
 #if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
 struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
 struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
@@ -39,6 +45,19 @@ struct lmb lmb = {
 	.reserved.cnt = 0,
 };
 
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
+
 static void lmb_dump_region(struct lmb_region *rgn, char *name)
 {
 	unsigned long long base, size, end;
@@ -450,7 +469,7 @@ long lmb_add(phys_addr_t base, phys_size_t size)
 	return lmb_add_region(_rgn, base, size);
 }
 
-long lmb_free(phys_addr_t base, phys_size_t size)
+static long __lmb_free(phys_addr_t base, phys_size_t size)
 {
 	struct lmb_region *rgn = &lmb.reserved;
 	phys_addr_t rgnbegin, rgnend;
@@ -500,11 +519,33 @@ long lmb_free(phys_addr_t base, phys_size_t size)
 				    rgn->region[i].flags);
 }
 
+long lmb_free(phys_addr_t base, phys_size_t size)
+{
+	long ret;
+
+	ret = __lmb_free(base, size);
+	if (ret < 0)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+		lmb_map_update_notify(base, size, MAP_OP_FREE);
+
+	return 0;
+}
+
 long lmb_reserve_flags(phys_addr_t base, phys_size_t size, enum lmb_flags flags)
 {
+	long ret = 0;
 	struct lmb_region *_rgn = &lmb.reserved;
 
-	return lmb_add_region_flags(_rgn, base, size, flags);
+	ret = lmb_add_region_flags(_rgn, base, size, flags);
+	if (ret < 0)
+		return -1;
+
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+		lmb_map_update_notify(base, size, MAP_OP_RESERVE);
+
+	return ret;
 }
 
 long lmb_reserve(phys_addr_t base, phys_size_t size)
@@ -563,6 +604,10 @@ static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
 				if (lmb_add_region(&lmb.reserved, base,
 						   size) < 0)
 					return 0;
+
+				if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+					lmb_map_update_notify(base, size,
+							      MAP_OP_RESERVE);
 				return base;
 			}
 			res_base = lmb.reserved.region[rgn].base;
-- 
2.34.1

