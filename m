Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C4C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F99288B7C;
	Fri, 19 Jul 2024 13:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDA488B90; Fri, 19 Jul 2024 13:28:00 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D5788B84
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7EA7D1A13CF;
 Fri, 19 Jul 2024 13:27:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 443DF1A13B8;
 Fri, 19 Jul 2024 13:27:57 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 D31821820F77; Fri, 19 Jul 2024 19:27:55 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, sbabic@denx.de, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, peng.fan@nxp.com
Cc: Tao Yang <Tao.Yang1@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv1 1/3] mp: imx9: add cpu command support
Date: Fri, 19 Jul 2024 19:48:48 +0800
Message-Id: <20240719114850.28134-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719114850.28134-1-Zhiqiang.Hou@nxp.com>
References: <20240719114850.28134-1-Zhiqiang.Hou@nxp.com>
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

From: Tao Yang <Tao.Yang1@nxp.com>

Implement the cpu command to kick cpu core to run barematel or RTOS
applications.

Signed-off-by: Tao Yang <Tao.Yang1@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm/mach-imx/imx9/Makefile |  4 +-
 arch/arm/mach-imx/imx9/mp.c     | 81 +++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/imx9/mp.c

diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index e1b09ab534..975b6831cc 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright 2022 NXP
+# Copyright 2022, 2024 NXP
 
 obj-y += lowlevel_init.o
 obj-y += soc.o clock.o clock_root.o trdc.o
@@ -8,3 +8,5 @@ obj-y += soc.o clock.o clock_root.o trdc.o
 #ifndef CONFIG_SPL_BUILD
 obj-y += imx_bootaux.o
 #endif
+
+obj-$(CONFIG_MP) += mp.o
diff --git a/arch/arm/mach-imx/imx9/mp.c b/arch/arm/mach-imx/imx9/mp.c
new file mode 100644
index 0000000000..9ddfc7784b
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/mp.c
@@ -0,0 +1,81 @@
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
+#define MPIDR_MT_BIT		BIT(24)
+#define MPIDR_AFF1_SHFT		(8)
+
+static u64 logical_id_to_hwid(unsigned int core)
+{
+	u64 hwid = core;
+
+	if (read_mpidr() & MPIDR_MT_BIT)
+		hwid = core << MPIDR_AFF1_SHFT;
+
+	return hwid;
+}
+
+int is_core_valid(unsigned int core)
+{
+	if (core < MAX_CPUS)
+		return 1;
+
+	return 0;
+}
+
+int cpu_reset(u32 nr)
+{
+	printf("Feature is not implemented.\n");
+
+	return 0;
+}
+
+int cpu_disable(u32 nr)
+{
+	printf("Feature is not implemented.\n");
+
+	return 0;
+}
+
+int cpu_status(u32 nr)
+{
+	printf("Feature is not implemented.\n");
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
+	regs.regs[1] = logical_id_to_hwid(nr);
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
-- 
2.43.0

