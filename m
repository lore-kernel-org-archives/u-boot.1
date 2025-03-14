Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563A0C28B30
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB8381B42;
	Fri, 14 Mar 2025 14:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DmvCi+JQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67EAC81CF0; Fri, 14 Mar 2025 14:57:45 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2144681DE3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=f-akthar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvcvG2179013
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 08:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741960658;
 bh=HfFkYiUtLRjAfd6MOOC32VKEoI7HW7MLhxcc9fCvdLo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DmvCi+JQgkeJ/S6ac8BNSrGlM9bWVWTYcJGBNffUvXMWqULMvN7U43rLCbs/51Szl
 xn5dCHLTYyjL9fGPLe6T+itRwoIRM5XnN6E9sPWrdgZkVRbn985McDOmg8vfmCSNKM
 nmPfuIxaAXnAtnLnG1mHM3005Nz50PhNs5+nmkTQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52EDvcSO072098
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 08:57:38 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 08:57:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 08:57:38 -0500
Received: from localhost (fayaz-hp-z2-tower-g4-workstation.dhcp.ti.com
 [172.24.227.181] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52EDvb0r129080;
 Fri, 14 Mar 2025 08:57:37 -0500
From: Harsha Vardhan V M <h-vm@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>
Subject: [RFC PATCH v2 4/5] drivers: k3_fuse: Add fuse sub-system func calls
Date: Fri, 14 Mar 2025 19:27:05 +0530
Message-ID: <20250314135706.184807-5-h-vm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314135706.184807-1-h-vm@ti.com>
References: <20250314135706.184807-1-h-vm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add K3_FUSE config option to add and enable fuse sub-system
implementation function calls.

Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 drivers/misc/Kconfig   |  7 ++++
 drivers/misc/Makefile  |  1 +
 drivers/misc/k3_fuse.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/misc/k3_fuse.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index da84b35e804..834e0285097 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -468,6 +468,13 @@ config STM32MP_FUSE
 	  for STM32MP architecture.
 	  This API is needed for CMD_FUSE.
 
+config K3_FUSE
+	bool "Enable TI K3 fuse wrapper providing the fuse API"
+	depends on MISC && CMD_FUSE && CMD_FUSE_WRITEBUFF
+	help
+	  If you say Y here, you will get support for the fuse API (OTP)
+	  for TI K3 architecture.
+
 config STM32_RCC
 	bool "Enable RCC driver for the STM32 SoC's family"
 	depends on (ARCH_STM32 || ARCH_STM32MP) && MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index dac805e4cdd..0b81ba2604f 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_$(XPL_)I2C_EEPROM) += i2c_eeprom.o
 obj-$(CONFIG_IHS_FPGA) += ihs_fpga.o
 obj-$(CONFIG_IMX8) += imx8/
 obj-$(CONFIG_IMX_ELE) += imx_ele/
+obj-$(CONFIG_K3_FUSE) += k3_fuse.o
 obj-$(CONFIG_LED_STATUS) += status_led.o
 obj-$(CONFIG_LED_STATUS_GPIO) += gpio_led.o
 obj-$(CONFIG_MPC83XX_SERDES) += mpc83xx_serdes.o
diff --git a/drivers/misc/k3_fuse.c b/drivers/misc/k3_fuse.c
new file mode 100644
index 00000000000..4a8ff1f2523
--- /dev/null
+++ b/drivers/misc/k3_fuse.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated, <www.ti.com>
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <fuse.h>
+#include <linux/arm-smccc.h>
+#include <string.h>
+
+#define K3_SIP_OTP_WRITEBUFF 0xC2000000
+#define K3_SIP_OTP_WRITE 0xC2000001
+#define K3_SIP_OTP_READ 0xC2000002
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	struct arm_smccc_res res;
+
+	if (bank != 0U) {
+		printf("Invalid bank argument, ONLY bank 0 is supported\n");
+		return -EINVAL;
+	}
+
+	/* Make SiP SMC call and send the word in the parameter register */
+	arm_smccc_smc(K3_SIP_OTP_READ, word,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	*val = res.a1;
+	if (res.a0 != 0)
+		printf("SMC call failed: Error code %lu\n", res.a0);
+
+	return res.a0;
+}
+
+int fuse_sense(u32 bank, u32 word, u32 *val)
+{
+	return -EPERM;
+}
+
+int fuse_prog(u32 bank, u32 word, u32 val)
+{
+	struct arm_smccc_res res;
+	u32 mask = val;
+
+	if (bank != 0U) {
+		printf("Invalid bank argument, ONLY bank 0 is supported\n");
+		return -EINVAL;
+	}
+
+	/* Make SiP SMC call and send the word, val and mask in the parameter register */
+	arm_smccc_smc(K3_SIP_OTP_WRITE, word,
+		      val, mask, 0, 0, 0, 0, &res);
+
+	if (res.a0 != 0)
+		printf("SMC call failed: Error code %lu\n", res.a0);
+
+	return res.a0;
+}
+
+int fuse_override(u32 bank, u32 word, u32 val)
+{
+	return -EPERM;
+}
+
+int fuse_writebuff(ulong addr)
+{
+	struct arm_smccc_res res;
+
+	/* Make SiP SMC call and send the addr in the parameter register */
+	arm_smccc_smc(K3_SIP_OTP_WRITEBUFF, (unsigned long)addr,
+		      0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != 0)
+		printf("SMC call failed: Error code %lu\n", res.a0);
+
+	return res.a0;
+}
-- 
2.34.1

