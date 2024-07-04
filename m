Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC70CC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2C9588915;
	Thu,  4 Jul 2024 09:37:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DDE08892C; Thu,  4 Jul 2024 09:37:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7D04788910
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04CB6367;
 Thu,  4 Jul 2024 00:37:43 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4F233F762;
 Thu,  4 Jul 2024 00:37:14 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 20/48] lmb: reserve common areas during board init
Date: Thu,  4 Jul 2024 13:05:16 +0530
Message-Id: <20240704073544.670249-21-sughosh.ganu@linaro.org>
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

The LMB module provides API's for allocating and reserving chunks of
memory which is then typically used for things like loading images for
booting. Reserve the portion of memory that is occupied by the U-Boot
image itself, and other parts of memory that might have been marked as
reserved in the board's DTB.

Mark these regions of memory with the LMB_NOOVERWRITE flag to indicate
that these regions cannot be re-requested or overwritten.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Mark the reserved regions as LMB_NOOVERWRITE.
* Call the lmb_reserve_common() function in U-Boot proper after
  relocation.

 lib/lmb.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index e1dde14a3c..456b64c00a 100644
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
@@ -739,5 +741,9 @@ int lmb_mem_regions_init(void)
 
 	lmb_add_memory();
 
+	/* Reserve the U-Boot image region once U-Boot has relocated */
+	if (spl_phase() == PHASE_BOARD_R)
+		lmb_reserve_common((void *)gd->fdt_blob);
+
 	return 0;
 }
-- 
2.34.1

