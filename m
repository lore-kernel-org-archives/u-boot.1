Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE59D149CD
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80A1989020;
	Fri, 25 Oct 2024 19:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E5689043; Fri, 25 Oct 2024 19:27:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BD16E88A4C
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB846497;
 Fri, 25 Oct 2024 10:28:11 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D43F71E;
 Fri, 25 Oct 2024 10:27:40 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, love.kumar@amd.com,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 2/2] xilinx: use get_mem_top() to compute ram_top
Date: Fri, 25 Oct 2024 22:57:24 +0530
Message-Id: <20241025172724.195093-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025172724.195093-1-sughosh.ganu@linaro.org>
References: <20241025172724.195093-1-sughosh.ganu@linaro.org>
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

Use the get_mem_top function to compute the value of ram_top. This was
earlier done through LMB API's, which are no longer available till
after relocation. Use get_mem_top() instead to compute the ram_top
value.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
 board/xilinx/common/board.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 38dd80533fa..e14ed2cff00 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -19,6 +19,7 @@
 #include <i2c.h>
 #include <linux/sizes.h>
 #include <malloc.h>
+#include <memtop.h>
 #include <mtd_node.h>
 #include "board.h"
 #include <dm.h>
@@ -676,3 +677,27 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	return 0;
 }
 #endif
+
+#ifndef MMU_SECTION_SIZE
+#define MMU_SECTION_SIZE        (1 * 1024 * 1024)
+#endif
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	phys_size_t size;
+	phys_addr_t reg;
+
+	if (!total_size)
+		return gd->ram_top;
+
+	if (!IS_ALIGNED((ulong)gd->fdt_blob, 0x8))
+		panic("Not 64bit aligned DT location: %p\n", gd->fdt_blob);
+
+	size = ALIGN(CONFIG_SYS_MALLOC_LEN + total_size, MMU_SECTION_SIZE);
+	reg = get_mem_top(gd->ram_base, gd->ram_size, size,
+			  (void *)gd->fdt_blob);
+	if (!reg)
+		reg = gd->ram_top - size;
+
+	return reg + size;
+}
-- 
2.34.1

