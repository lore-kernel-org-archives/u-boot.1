Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBF8C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 17:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F22A388739;
	Fri, 26 Jul 2024 19:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90E2288718; Fri, 26 Jul 2024 19:30:34 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8888884C5
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 19:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 825161A0B69;
 Fri, 26 Jul 2024 19:30:31 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D1501A0B6E;
 Fri, 26 Jul 2024 19:30:31 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 4729A183ACAC; Sat, 27 Jul 2024 01:30:30 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 07/12] cpu: imx: implement release_core callback
Date: Sat, 27 Jul 2024 01:51:03 +0800
Message-Id: <20240726175108.34704-8-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
References: <20240726175108.34704-1-Zhiqiang.Hou@nxp.com>
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

Release the secondary cores through the PSCI request.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V3:
 - No change.

 drivers/cpu/imx8_cpu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index c1315cc32dd..8525eba37c6 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <thermal.h>
 #include <asm/global_data.h>
+#include <asm/ptrace.h>
 #include <asm/system.h>
 #include <firmware/imx/sci/sci.h>
 #include <asm/arch/sys_proto.h>
@@ -15,6 +16,7 @@
 #include <imx_thermal.h>
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
+#include <linux/psci.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -242,12 +244,34 @@ static int cpu_imx_is_current(struct udevice *dev)
 	return 0;
 }
 
+static int cpu_imx_release_core(const struct udevice *dev, phys_addr_t addr)
+{
+	struct cpu_imx_plat *plat = dev_get_plat(dev);
+	struct pt_regs regs;
+
+	regs.regs[0] = PSCI_0_2_FN64_CPU_ON;
+	regs.regs[1] = plat->mpidr;
+	regs.regs[2] = addr;
+	regs.regs[3] = 0;
+
+	smc_call(&regs);
+	if (regs.regs[0]) {
+		printf("Failed to release CPU core (mpidr: 0x%x)\n", plat->mpidr);
+		return -1;
+	}
+
+	printf("Released CPU core (mpidr: 0x%x) to address 0x%llx\n", plat->mpidr, addr);
+
+	return 0;
+}
+
 static const struct cpu_ops cpu_imx_ops = {
 	.get_desc	= cpu_imx_get_desc,
 	.get_info	= cpu_imx_get_info,
 	.get_count	= cpu_imx_get_count,
 	.get_vendor	= cpu_imx_get_vendor,
 	.is_current	= cpu_imx_is_current,
+	.release_core	= cpu_imx_release_core,
 };
 
 static const struct udevice_id cpu_imx_ids[] = {
-- 
2.43.0

