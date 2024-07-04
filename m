Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA2EC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90635888A0;
	Thu,  4 Jul 2024 09:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8E38889D; Thu,  4 Jul 2024 09:37:46 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0DC5C8892C
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84DF3367;
 Thu,  4 Jul 2024 00:38:08 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 616E03F762;
 Thu,  4 Jul 2024 00:37:40 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 27/48] zynq: lmb: do not add to lmb map before
 relocation
Date: Thu,  4 Jul 2024 13:05:23 +0530
Message-Id: <20240704073544.670249-28-sughosh.ganu@linaro.org>
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

The LMB memory is typically not needed very early in the platform's
boot. Do not add memory to the LMB map before relocation. Reservation
of common areas and adding of memory is done after relocation.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: None

 board/xilinx/common/board.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f04c92a70f..3440402ab4 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -12,7 +12,6 @@
 #include <image.h>
 #include <init.h>
 #include <jffs2/load_kernel.h>
-#include <lmb.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/sections.h>
@@ -665,36 +664,6 @@ int embedded_dtb_select(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_LMB)
-
-#ifndef MMU_SECTION_SIZE
-#define MMU_SECTION_SIZE        (1 * 1024 * 1024)
-#endif
-
-phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
-{
-	phys_size_t size;
-	phys_addr_t reg;
-
-	if (!total_size)
-		return gd->ram_top;
-
-	if (!IS_ALIGNED((ulong)gd->fdt_blob, 0x8))
-		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
-
-	/* found enough not-reserved memory to relocated U-Boot */
-	lmb_add(gd->ram_base, gd->ram_size);
-	boot_fdt_add_mem_rsv_regions((void *)gd->fdt_blob);
-	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
-	reg = lmb_alloc(size, MMU_SECTION_SIZE);
-
-	if (!reg)
-		reg = gd->ram_top - size;
-
-	return reg + size;
-}
-#endif
-
 #ifdef CONFIG_OF_BOARD_SETUP
 #define MAX_RAND_SIZE 8
 int ft_board_setup(void *blob, struct bd_info *bd)
-- 
2.34.1

