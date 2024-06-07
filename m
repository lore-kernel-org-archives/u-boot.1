Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF6C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973BA8851E;
	Fri,  7 Jun 2024 20:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC2A88464; Fri,  7 Jun 2024 20:54:23 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9BFFC8850B
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81AEB15A1;
 Fri,  7 Jun 2024 11:54:45 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B9B93F792;
 Fri,  7 Jun 2024 11:54:18 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 15/31] efi_memory: add an event handler to update memory
 map
Date: Sat,  8 Jun 2024 00:22:24 +0530
Message-Id: <20240607185240.1892031-16-sughosh.ganu@linaro.org>
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

There are events that would be used to notify other interested modules
of any changes in available and occupied memory. This would happen
when a module allocates or reserves memory, or frees up memory. These
changes in memory map should be notified to other interested modules
so that the allocated memory does not get overwritten. Add an event
handler in the EFI memory module to update the EFI memory map
accordingly when such changes happen. As a consequence, any subsequent
memory request would honour the updated memory map and only available
memory would be allocated from.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_memory.c | 70 ++++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 435e580fb3..93244161b0 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -73,6 +73,10 @@ struct efi_pool_allocation {
 #if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
 extern bool is_addr_in_ram(uintptr_t addr);
 
+static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
+					    int memory_type,
+					    bool overlap_only_ram);
+
 static void efi_map_update_notify(u64 addr, u64 size, u8 op)
 {
 	struct event_efi_mem_map_update efi_map = {0};
@@ -84,6 +88,34 @@ static void efi_map_update_notify(u64 addr, u64 size, u8 op)
 	if (is_addr_in_ram((uintptr_t)addr))
 		event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
 }
+
+static int lmb_mem_map_update_sync(void *ctx, struct event *event)
+{
+	u8 op;
+	u64 addr;
+	u64 pages;
+	efi_status_t status;
+	struct event_lmb_map_update *lmb_map = &event->data.lmb_map;
+
+	addr = (uintptr_t)map_sysmem(lmb_map->base, 0);
+	pages = efi_size_in_pages(lmb_map->size + (addr & EFI_PAGE_MASK));
+	op = lmb_map->op;
+	addr &= ~EFI_PAGE_MASK;
+
+	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
+		log_debug("Invalid map update op received (%d)\n", op);
+		return -1;
+	}
+
+	status = __efi_add_memory_map_pg(addr, pages,
+					 op == MAP_OP_FREE ?
+					 EFI_CONVENTIONAL_MEMORY :
+					 EFI_BOOT_SERVICES_DATA,
+					 true);
+
+	return status == EFI_SUCCESS ? 0 : -1;
+}
+EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
 #endif /* MEM_MAP_UPDATE_NOTIFY */
 
 /**
@@ -275,18 +307,9 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 	return EFI_CARVE_LOOP_AGAIN;
 }
 
-/**
- * efi_add_memory_map_pg() - add pages to the memory map
- *
- * @start:		start address, must be a multiple of EFI_PAGE_SIZE
- * @pages:		number of pages to add
- * @memory_type:	type of memory added
- * @overlap_only_ram:	region may only overlap RAM
- * Return:		status code
- */
-static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-					  int memory_type,
-					  bool overlap_only_ram)
+static efi_status_t __efi_add_memory_map_pg(u64 start, u64 pages,
+					    int memory_type,
+					    bool overlap_only_ram)
 {
 	struct list_head *lhandle;
 	struct efi_mem_list *newlist;
@@ -395,6 +418,29 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 		}
 	}
 
+	return EFI_SUCCESS;
+}
+
+/**
+ * efi_add_memory_map_pg() - add pages to the memory map
+ *
+ * @start:		start address, must be a multiple of EFI_PAGE_SIZE
+ * @pages:		number of pages to add
+ * @memory_type:	type of memory added
+ * @overlap_only_ram:	region may only overlap RAM
+ * Return:		status code
+ */
+static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
+					  int memory_type,
+					  bool overlap_only_ram)
+{
+	efi_status_t status;
+
+	status = __efi_add_memory_map_pg(start, pages, memory_type,
+					 overlap_only_ram);
+	if (status != EFI_SUCCESS)
+		return status;
+
 	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
 		efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
 				      memory_type == EFI_CONVENTIONAL_MEMORY ?
-- 
2.34.1

