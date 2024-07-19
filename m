Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88C0C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 09:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 714C788B60;
	Fri, 19 Jul 2024 11:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A6D88B3A; Fri, 19 Jul 2024 11:47:07 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17DD888113
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 11:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD7771A1386;
 Fri, 19 Jul 2024 11:47:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C8B01A046D;
 Fri, 19 Jul 2024 11:47:04 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 DC266183AD14; Fri, 19 Jul 2024 17:47:02 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Yi Zhao <yi.zhao@nxp.com>,
 Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: [PATCHv1 1/2] mp: imx8m: add cpu command support
Date: Fri, 19 Jul 2024 18:07:57 +0800
Message-Id: <20240719100758.1917-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
References: <20240719100758.1917-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Implement the cpu command to kick cpu core to run barematel or RTOS
applications.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Yi Zhao <yi.zhao@nxp.com>
Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Makefile |   3 +-
 arch/arm/mach-imx/imx8m/mp.c     | 100 +++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/imx8m/mp.c

diff --git a/arch/arm/mach-imx/imx8m/Makefile b/arch/arm/mach-imx/imx8m/Makefile
index abd5ddc177..9e4d919159 100644
--- a/arch/arm/mach-imx/imx8m/Makefile
+++ b/arch/arm/mach-imx/imx8m/Makefile
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2017 NXP
+# Copyright 2017, 2024 NXP
 
 obj-y += lowlevel_init.o
 obj-y += clock_slice.o soc.o
+obj-$(CONFIG_MP) += mp.o
 obj-$(CONFIG_ARMV8_PSCI) += psci.o
 obj-$(CONFIG_IMX8MQ) += clock_imx8mq.o
 obj-$(CONFIG_IMX8MM)$(CONFIG_IMX8MN)$(CONFIG_IMX8MP) += clock_imx8mm.o
diff --git a/arch/arm/mach-imx/imx8m/mp.c b/arch/arm/mach-imx/imx8m/mp.c
new file mode 100644
index 0000000000..33b9ccfce2
--- /dev/null
+++ b/arch/arm/mach-imx/imx8m/mp.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <linux/psci.h>
+#include <vsprintf.h>
+
+#ifndef MAX_CPUS
+#define MAX_CPUS 4
+#endif
+
+/* A53 Reset Control Register (SRC_A53RCR0) */
+#define SRC_A53RCR0_CORE_1_RESET_MASK		BIT(5)
+#define SRC_A53RCR0_CORE_2_RESET_MASK		BIT(6)
+#define SRC_A53RCR0_CORE_3_RESET_MASK		BIT(7)
+
+/* A53 Reset Control Register (SRC_A53RCR1) */
+#define SRC_A53RCR1_CORE_1_ENABLE_MASK		BIT(1)
+#define SRC_A53RCR1_CORE_2_ENABLE_MASK		BIT(2)
+#define SRC_A53RCR1_CORE_3_ENABLE_MASK		BIT(3)
+
+static struct src *src = (struct src *)SRC_BASE_ADDR;
+
+static u32 cpu_reset_mask[MAX_CPUS] = {
+	0, /* We don't really want to modify the cpu0 */
+	SRC_A53RCR0_CORE_1_RESET_MASK,
+	SRC_A53RCR0_CORE_2_RESET_MASK,
+	SRC_A53RCR0_CORE_3_RESET_MASK
+};
+
+static u32 cpu_ctrl_mask[MAX_CPUS] = {
+	0, /* We don't really want to modify the cpu0 */
+	SRC_A53RCR1_CORE_1_ENABLE_MASK,
+	SRC_A53RCR1_CORE_2_ENABLE_MASK,
+	SRC_A53RCR1_CORE_3_ENABLE_MASK
+};
+
+int is_core_valid(unsigned int core)
+{
+	if (core < MAX_CPUS)
+		return 1;
+
+	return 0;
+}
+
+int cpu_status(u32 nr)
+{
+	printf("core %d => %d\n", nr, !!(src->a53rcr1 & cpu_ctrl_mask[nr]));
+
+	return 0;
+}
+
+int cpu_reset(u32 nr)
+{
+	/* Software reset of the CPU N */
+	src->a53rcr |= cpu_reset_mask[nr];
+
+	return 0;
+}
+
+int cpu_release(u32 nr, int argc, char *const argv[])
+{
+	struct pt_regs regs;
+	u64 boot_addr;
+
+	if (nr >= MAX_CPUS) {
+		printf("Invalid CPU ID %d\n", nr);
+		return -1;
+	}
+
+	boot_addr = simple_strtoull(argv[0], NULL, 16);
+
+	regs.regs[0] = PSCI_0_2_FN64_CPU_ON;
+	regs.regs[1] = nr;
+	regs.regs[2] = boot_addr;
+	regs.regs[3] = 0;
+
+	smc_call(&regs);
+	if (regs.regs[0])
+		return -1;
+
+	printf("kicked cpu core #%d to address %llx\n", nr, boot_addr);
+
+	return 0;
+}
+
+int cpu_disable(u32 nr)
+{
+	/* Disable the CPU N */
+	src->a53rcr1 &= ~cpu_ctrl_mask[nr];
+
+	return 0;
+}
-- 
2.43.0

