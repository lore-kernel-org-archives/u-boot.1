Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA63C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 06:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAE6388852;
	Wed, 24 Jul 2024 08:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1604A887CE; Wed, 24 Jul 2024 08:04:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C3BA188907
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B6F106F;
 Tue, 23 Jul 2024 23:04:46 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90A653F766;
 Tue, 23 Jul 2024 23:04:16 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 19/40] lmb: reserve common areas during board init
Date: Wed, 24 Jul 2024 11:32:03 +0530
Message-Id: <20240724060224.3071065-20-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
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

The LMB module provides API's for allocating and reserving chunks of
memory which is then typically used for things like loading images for
booting. Reserve the portion of memory that is occupied by the U-Boot
image itself, and other parts of memory that might have been marked as
reserved in the board's DTB. When executing in SPL, reserve the
sections that get relocated to the ram memory, the stack and
the global data structure and also the bss.

Mark these regions of memory with the LMB_NOOVERWRITE flag to indicate
that these regions cannot be re-requested or overwritten.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since rfc:
* Add a function for reserving common areas in SPL,
  lmb_reserve_common_spl()

 lib/lmb.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index f1142033ef..ce1b0204c9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -13,6 +13,7 @@
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
+#include <spl.h>
 
 #include <asm/global_data.h>
 #include <asm/sections.h>
@@ -173,10 +174,11 @@ void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align)
 		if (bank_end > end)
 			bank_end = end - 1;
 
-		lmb_reserve(sp, bank_end - sp + 1);
+		lmb_reserve_flags(sp, bank_end - sp + 1, LMB_NOOVERWRITE);
 
 		if (gd->flags & GD_FLG_SKIP_RELOC)
-			lmb_reserve((phys_addr_t)(uintptr_t)_start, gd->mon_len);
+			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
+				    gd->mon_len, LMB_NOOVERWRITE);
 
 		break;
 	}
@@ -226,6 +228,30 @@ static void lmb_reserve_common(void *fdt_blob)
 		efi_lmb_reserve();
 }
 
+static __maybe_unused void lmb_reserve_common_spl(void)
+{
+	phys_addr_t rsv_start;
+	phys_size_t rsv_size;
+
+	/*
+	 * Assume a SPL stack of 16KB. This must be
+	 * more than enough for the SPL stage.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_STACK_R_ADDR)) {
+		rsv_start = gd->start_addr_sp - 16384;
+		rsv_size = 16384;
+		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)) {
+		/* Reserve the bss region */
+		rsv_start = (phys_addr_t)(uintptr_t)__bss_start;
+		rsv_size = (phys_addr_t)(uintptr_t)__bss_end -
+			(phys_addr_t)(uintptr_t)__bss_start;
+		lmb_reserve_flags(rsv_start, rsv_size, LMB_NOOVERWRITE);
+	}
+}
+
 /**
  * lmb_add_memory() - Add memory range for LMB allocations
  *
@@ -757,5 +783,11 @@ int lmb_mem_regions_init(void)
 
 	lmb_add_memory();
 
+	/* Reserve the U-Boot image region once U-Boot has relocated */
+	if (spl_phase() == PHASE_SPL)
+		lmb_reserve_common_spl();
+	else if (spl_phase() == PHASE_BOARD_R)
+		lmb_reserve_common((void *)gd->fdt_blob);
+
 	return 0;
 }
-- 
2.34.1

