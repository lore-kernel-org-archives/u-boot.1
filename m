Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D47C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 11:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D835B88DDD;
	Wed, 21 Aug 2024 13:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6541388113; Wed, 21 Aug 2024 13:00:37 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3A42988DDD
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 13:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8CF4FEC;
 Wed, 21 Aug 2024 04:01:00 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56D8B3F73B;
 Wed, 21 Aug 2024 04:00:31 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 25/27] stm32mp: allow calling optee_get_reserved_memory()
 from U-Boot
Date: Wed, 21 Aug 2024 16:28:37 +0530
Message-Id: <20240821105839.2870293-26-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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

The optee_get_reserved_memory() function returns the OP-TEE base
address and size. The function gets these values from the
FDT. Currently, this function is defined only to be called in the SPL
phase. Move this function to a place where it can be invoked from the
main U-Boot phase, where it will be used to compute the ram_top
address.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: None

 arch/arm/mach-stm32mp/dram_init.c            | 17 +++++++++++++++++
 arch/arm/mach-stm32mp/include/mach/stm32mp.h | 11 +++++++++++
 arch/arm/mach-stm32mp/stm32mp1/spl.c         | 17 +----------------
 3 files changed, 29 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/include/mach/stm32mp.h

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index e8b0a38be1..b3dbd521b7 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -14,9 +14,26 @@
 #include <ram.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
+#include <mach/stm32mp.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
+int optee_get_reserved_memory(uint32_t *start, uint32_t *size)
+{
+	fdt_addr_t fdt_mem_size;
+	fdt_addr_t fdt_start;
+	ofnode node;
+
+	node = ofnode_path("/reserved-memory/optee");
+	if (!ofnode_valid(node))
+		return -ENOENT;
+
+	fdt_start = ofnode_get_addr_size(node, "reg", &fdt_mem_size);
+	*start = fdt_start;
+	*size = fdt_mem_size;
+	return (fdt_start < 0) ? fdt_start : 0;
+}
+
 int dram_init(void)
 {
 	struct ram_info ram;
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32mp.h b/arch/arm/mach-stm32mp/include/mach/stm32mp.h
new file mode 100644
index 0000000000..afc03c9ba8
--- /dev/null
+++ b/arch/arm/mach-stm32mp/include/mach/stm32mp.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
+ */
+
+#ifndef __MACH_STM32MP_H_
+#define __MACH_STM32MP_H_
+
+int optee_get_reserved_memory(uint32_t *start, uint32_t *size);
+
+#endif
diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index 6eae5c2f55..9c4fafbf47 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <mach/tzc.h>
+#include <mach/stm32mp.h>
 #include <linux/libfdt.h>
 
 u32 spl_boot_device(void)
@@ -110,22 +111,6 @@ uint32_t stm32mp_get_dram_size(void)
 	return ram.size;
 }
 
-static int optee_get_reserved_memory(uint32_t *start, uint32_t *size)
-{
-	fdt_addr_t fdt_mem_size;
-	fdt_addr_t fdt_start;
-	ofnode node;
-
-	node = ofnode_path("/reserved-memory/optee");
-	if (!ofnode_valid(node))
-		return -ENOENT;
-
-	fdt_start = ofnode_get_addr_size(node, "reg", &fdt_mem_size);
-	*start = fdt_start;
-	*size = fdt_mem_size;
-	return (fdt_start < 0) ? fdt_start : 0;
-}
-
 #define CFG_SHMEM_SIZE			0x200000
 #define STM32_TZC_NSID_ALL		0xffff
 #define STM32_TZC_FILTER_ALL		3
-- 
2.34.1

