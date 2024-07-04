Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5FC3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C9C488972;
	Thu,  4 Jul 2024 09:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431DD88966; Thu,  4 Jul 2024 09:38:38 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E9B3688986
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73129DA7;
 Thu,  4 Jul 2024 00:39:00 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36A6C3F762;
 Thu,  4 Jul 2024 00:38:31 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
Date: Thu,  4 Jul 2024 13:05:37 +0530
Message-Id: <20240704073544.670249-42-sughosh.ganu@linaro.org>
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
Changes since V1:
* Handle the addition of memory to the LMB memory map.
* Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
  based on the type of operation.

 lib/efi_loader/Kconfig      |  1 +
 lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index bdf5732974..2d90bcef2f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -16,6 +16,7 @@ config EFI_LOADER
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
 	select DM_EVENT
+	select EVENT
 	select EVENT_DYNAMIC
 	select LIB_UUID
 	select LMB
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 5691b5da03..bd12504f72 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -45,6 +45,10 @@ static LIST_HEAD(efi_mem);
 void *efi_bounce_buffer;
 #endif
 
+#define MAP_OP_RESERVE		(u8)0x1
+#define MAP_OP_FREE		(u8)0x2
+#define MAP_OP_ADD		(u8)0x3
+
 /**
  * struct efi_pool_allocation - memory block allocated from pool
  *
@@ -928,3 +932,33 @@ int efi_memory_init(void)
 
 	return 0;
 }
+
+#if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
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
+	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
+		log_debug("Invalid map update op received (%d)\n", op);
+		return -1;
+	}
+
+	status = efi_add_memory_map_pg(addr, pages,
+				       op == MAP_OP_RESERVE ?
+				       EFI_BOOT_SERVICES_DATA :
+				       EFI_CONVENTIONAL_MEMORY,
+				       op == MAP_OP_RESERVE ? true : false);
+
+	return status == EFI_SUCCESS ? 0 : -1;
+}
+EVENT_SPY_FULL(EVT_LMB_MAP_UPDATE, lmb_mem_map_update_sync);
+#endif /* MEM_MAP_UPDATE_NOTIFY */
-- 
2.34.1

