Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC1C27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18A5884AA;
	Fri,  7 Jun 2024 20:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 178C788506; Fri,  7 Jun 2024 20:54:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 216A0884EE
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8601480;
 Fri,  7 Jun 2024 11:54:39 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4AF3F792;
 Fri,  7 Jun 2024 11:54:11 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 13/31] efi_memory: notify of any changes to the EFI memory
 map
Date: Sat,  8 Jun 2024 00:22:22 +0530
Message-Id: <20240607185240.1892031-14-sughosh.ganu@linaro.org>
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
same regions of memory for allocations. Use the EFI memory map update
event to notify other interested listeners about a change in the EFI
memory map. This can then be used by the other module to allocate
memory only from available regions, instead of overwriting already
allocated memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/efi_loader/efi_memory.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 12cf23fa3f..435e580fb3 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -8,6 +8,7 @@
 #define LOG_CATEGORY LOGC_EFI
 
 #include <efi_loader.h>
+#include <event.h>
 #include <init.h>
 #include <log.h>
 #include <malloc.h>
@@ -36,6 +37,9 @@ struct efi_mem_list {
 #define EFI_CARVE_OVERLAPS_NONRAM	-3
 #define EFI_CARVE_OUT_OF_RESOURCES	-4
 
+#define MAP_OP_RESERVE		(u8)0x1
+#define MAP_OP_FREE		(u8)0x2
+
 /* This list contains all memory map items */
 static LIST_HEAD(efi_mem);
 
@@ -66,6 +70,22 @@ struct efi_pool_allocation {
 	char data[] __aligned(ARCH_DMA_MINALIGN);
 };
 
+#if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
+extern bool is_addr_in_ram(uintptr_t addr);
+
+static void efi_map_update_notify(u64 addr, u64 size, u8 op)
+{
+	struct event_efi_mem_map_update efi_map = {0};
+
+	efi_map.base = addr;
+	efi_map.size = size;
+	efi_map.op = op;
+
+	if (is_addr_in_ram((uintptr_t)addr))
+		event_notify(EVT_EFI_MEM_MAP_UPDATE, &efi_map, sizeof(efi_map));
+}
+#endif /* MEM_MAP_UPDATE_NOTIFY */
+
 /**
  * checksum() - calculate checksum for memory allocated from pool
  *
@@ -375,6 +395,11 @@ static efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY))
+		efi_map_update_notify(start, pages << EFI_PAGE_SHIFT,
+				      memory_type == EFI_CONVENTIONAL_MEMORY ?
+				      MAP_OP_FREE : MAP_OP_RESERVE);
+
 	return EFI_SUCCESS;
 }
 
-- 
2.34.1

