Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353AC27C5F
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2E998850D;
	Fri,  7 Jun 2024 20:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3AC8850B; Fri,  7 Jun 2024 20:54:26 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D130588521
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDB581480;
 Fri,  7 Jun 2024 11:54:48 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943F93F792;
 Fri,  7 Jun 2024 11:54:21 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 16/31] lmb: add an event handler to update memory map
Date: Sat,  8 Jun 2024 00:22:25 +0530
Message-Id: <20240607185240.1892031-17-sughosh.ganu@linaro.org>
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
handler in the LMB module to update it's memory map accordingly when
such changes happen. As a consequence, any subsequent memory request
would honour the updated memory map and allocations would only happen
from available memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/Kconfig |  1 +
 lib/lmb.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 9ea02ae006..9e465a748b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1111,6 +1111,7 @@ config LMB
 	bool "Enable the logical memory blocks library (lmb)"
 	default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
 		     NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || XTENSA
+	select EVENT
 	help
 	  Support the library logical memory blocks.
 
diff --git a/lib/lmb.c b/lib/lmb.c
index 313735dbe3..3059609aea 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -16,6 +16,7 @@
 
 #include <asm/global_data.h>
 #include <asm/sections.h>
+#include <asm-generic/io.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -719,3 +720,36 @@ __weak void arch_lmb_reserve(void)
 {
 	/* please define platform specific arch_lmb_reserve() */
 }
+
+#if CONFIG_IS_ENABLED(MEM_MAP_UPDATE_NOTIFY)
+static long lmb_reserve_nooverwrite(phys_addr_t base, phys_size_t size)
+{
+	struct lmb_region *_rgn = &lmb.reserved;
+
+	return lmb_add_region_flags(_rgn, base, size, LMB_NOOVERWRITE);
+}
+
+static int efi_mem_map_update_sync(void *ctx, struct event *event)
+{
+	u8 op;
+	long ret;
+	phys_addr_t addr;
+	phys_size_t size;
+	struct event_efi_mem_map_update *efi_map = &event->data.efi_mem_map;
+
+	addr = virt_to_phys((void *)(uintptr_t)efi_map->base);
+	size = efi_map->size;
+	op = efi_map->op;
+
+	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE) {
+		log_debug("Invalid map update op received (%d)\n", op);
+		return -1;
+	}
+
+	ret = op == MAP_OP_RESERVE ? lmb_reserve_nooverwrite(addr, size) :
+		__lmb_free(addr, size);
+
+	return !ret ? 0 : -1;
+}
+EVENT_SPY_FULL(EVT_EFI_MEM_MAP_UPDATE, efi_mem_map_update_sync);
+#endif /* MEM_MAP_UPDATE_NOTIFY */
-- 
2.34.1

