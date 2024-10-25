Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E33D149EE
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 20:15:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C603D89048;
	Fri, 25 Oct 2024 22:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1488902F; Fri, 25 Oct 2024 19:18:48 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 128A389024
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=leo.yan@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34EE9497;
 Fri, 25 Oct 2024 10:19:10 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DBA33F71E;
 Fri, 25 Oct 2024 10:18:39 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Tom Rini <trini@konsulko.com>, Usama Arif <usama.arif@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Jackson Cooper-Driver <jackson.cooper-driver@arm.com>, u-boot@lists.denx.de
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/8] arm: total_compute: depend on TF-A for hardware
 description
Date: Fri, 25 Oct 2024 18:18:14 +0100
Message-Id: <20241025171821.624702-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025171821.624702-1-leo.yan@arm.com>
References: <20241025171821.624702-1-leo.yan@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Oct 2024 22:14:52 +0200
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

From: Boyan Karatotev <boyan.karatotev@arm.com>

On Total Compute, TF-A passes the info via DT binding for the hardware
description - includes the serial, memory, and arm_ffa nodes.

This commit initializes the fdt base address based on the passed the
register x1.

The similar implementation has already been done for the raspberry pi,
so borrow a lot of it.

Co-developed-by: Jackson Cooper-Driver <jackson.cooper-driver@arm.com>
Signed-off-by: Jackson Cooper-Driver <jackson.cooper-driver@arm.com>
Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 arch/arm/Kconfig                           |  1 +
 board/armltd/total_compute/Makefile        |  1 +
 board/armltd/total_compute/lowlevel_init.S | 12 +++++++
 board/armltd/total_compute/total_compute.c | 41 +++++++++++-----------
 include/configs/total_compute.h            | 18 ----------
 5 files changed, 35 insertions(+), 38 deletions(-)
 create mode 100644 board/armltd/total_compute/lowlevel_init.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 060636e9e2..d0127418ee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1390,6 +1390,7 @@ config TARGET_TOTAL_COMPUTE
 	select DM_SERIAL
 	select DM_MMC
 	select DM_GPIO
+	imply OF_HAS_PRIOR_STAGE
 
 config TARGET_LS2080A_EMU
 	bool "Support ls2080a_emu"
diff --git a/board/armltd/total_compute/Makefile b/board/armltd/total_compute/Makefile
index 8b10458431..f1ef5a0c39 100644
--- a/board/armltd/total_compute/Makefile
+++ b/board/armltd/total_compute/Makefile
@@ -4,3 +4,4 @@
 # Usama Arif <usama.arif@arm.com>
 
 obj-y	:= total_compute.o
+obj-y	+= lowlevel_init.o
diff --git a/board/armltd/total_compute/lowlevel_init.S b/board/armltd/total_compute/lowlevel_init.S
new file mode 100644
index 0000000000..3c06937966
--- /dev/null
+++ b/board/armltd/total_compute/lowlevel_init.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2024 Arm Limited
+ */
+
+.global save_boot_params
+save_boot_params:
+	/* The firmware provided FDT address via x1 */
+	adr	x8, fw_dtb_pointer
+	str	x1, [x8]
+
+	b	save_boot_params_ret
diff --git a/board/armltd/total_compute/total_compute.c b/board/armltd/total_compute/total_compute.c
index e1b4f49d04..571a075145 100644
--- a/board/armltd/total_compute/total_compute.c
+++ b/board/armltd/total_compute/total_compute.c
@@ -7,19 +7,10 @@
 #include <config.h>
 #include <dm.h>
 #include <dm/platform_data/serial_pl01x.h>
+#include <env.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
-
-static const struct pl01x_serial_plat serial_plat = {
-	.base = UART0_BASE,
-	.type = TYPE_PL011,
-	.clock = CFG_PL011_CLOCK,
-};
-
-U_BOOT_DRVINFO(total_compute_serials) = {
-	.name = "serial_pl01x",
-	.plat = &serial_plat,
-};
+#include <asm/system.h>
 
 static struct mm_region total_compute_mem_map[] = {
 	{
@@ -43,6 +34,23 @@ static struct mm_region total_compute_mem_map[] = {
 
 struct mm_region *mem_map = total_compute_mem_map;
 
+/*
+ * Push the variable into the .data section so that it
+ * does not get cleared later.
+ */
+unsigned long __section(".data") fw_dtb_pointer;
+
+void *board_fdt_blob_setup(int *err)
+{
+	*err = 0;
+	if (fdt_magic(fw_dtb_pointer) != FDT_MAGIC) {
+		*err = -ENXIO;
+		return NULL;
+	}
+
+	return (void *)fw_dtb_pointer;
+}
+
 int board_init(void)
 {
 	return 0;
@@ -50,19 +58,12 @@ int board_init(void)
 
 int dram_init(void)
 {
-	gd->ram_size = PHYS_SDRAM_1_SIZE;
-	return 0;
+	return fdtdec_setup_mem_size_base();
 }
 
 int dram_init_banksize(void)
 {
-	gd->bd->bi_dram[0].start = PHYS_SDRAM_1;
-	gd->bd->bi_dram[0].size = PHYS_SDRAM_1_SIZE;
-
-	gd->bd->bi_dram[1].start = PHYS_SDRAM_2;
-	gd->bd->bi_dram[1].size = PHYS_SDRAM_2_SIZE;
-
-	return 0;
+	return fdtdec_setup_memory_banksize();
 }
 
 /* Nothing to be done here as handled by PSCI interface */
diff --git a/include/configs/total_compute.h b/include/configs/total_compute.h
index a8bd8e259c..205e6a6278 100644
--- a/include/configs/total_compute.h
+++ b/include/configs/total_compute.h
@@ -11,24 +11,6 @@
 
 /* Link Definitions */
 
-/* AP non-secure UART base address */
-#define UART0_BASE		0x2A400000
-
-/* PL011 Serial Configuration */
-#define CFG_PL011_CLOCK	7372800
-
-/* Miscellaneous configurable options */
-
-/* Physical Memory Map */
-#define PHYS_SDRAM_1		0x80000000
-/* Top 48MB reserved for secure world use */
-#define DRAM_SEC_SIZE		0x03000000
-#define PHYS_SDRAM_1_SIZE	0x80000000 - DRAM_SEC_SIZE
-#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM_1
-
-#define PHYS_SDRAM_2		0x8080000000
-#define PHYS_SDRAM_2_SIZE	0x180000000
-
 #define CFG_EXTRA_ENV_SETTINGS	\
 				"bootm_size=0x20000000\0"	\
 				"load_addr=0xa0000000\0"	\
-- 
2.34.1

