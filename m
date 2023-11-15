Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFC3C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30E787474;
	Wed, 15 Nov 2023 18:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8DA8746F; Wed, 15 Nov 2023 18:40:50 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 4C4948746A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,305,1694703600"; d="scan'208";a="186893825"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Nov 2023 02:40:47 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.122])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF48040342AD;
 Thu, 16 Nov 2023 02:40:45 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 4/5] pmic: Add Renesas RAA215300 PMIC driver
Date: Wed, 15 Nov 2023 17:40:24 +0000
Message-Id: <20231115174025.12974-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
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

The RZ/G2L SMARC module is powered via a Renesas RAA215300 PMIC which
provides several voltage converters, a real time clock (RTC) and reset
control. A basic driver is implemented for this device so that we can
read, write and dump the PMIC registers.

Additional features of this PMIC (such as reset control) may be
supported by future patches.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 configs/renesas_rzg2l_smarc_defconfig |  3 +++
 drivers/power/pmic/Kconfig            |  9 +++++++
 drivers/power/pmic/Makefile           |  1 +
 drivers/power/pmic/raa215300.c        | 35 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 drivers/power/pmic/raa215300.c

diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index acf9e6a9f4f5..b62eae4ee0a4 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -49,6 +50,8 @@ CONFIG_DM_I2C=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 454a6e0cf87a..9b61b18e11fd 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -404,6 +404,15 @@ config PMIC_TPS65219
 	help
 	The TPS65219 is a PMIC containing a bunch of SMPS & LDOs.
 	This driver binds the pmic children.
+
+config PMIC_RAA215300
+	bool "Renesas RAA215300 PMIC driver"
+	depends on DM_PMIC
+	help
+	  The Renesas RAA215300 PMIC driver includes RTC support, system reset
+	  support and several voltage regulators. For now, this driver simply
+	  allows register access and will bind the sysreset driver
+	  (CONFIG_SYSRESET_RAA215300) if it is enabled.
 endif
 
 config PMIC_TPS65217
diff --git a/drivers/power/pmic/Makefile b/drivers/power/pmic/Makefile
index 55ee614364be..a2d59deeed8b 100644
--- a/drivers/power/pmic/Makefile
+++ b/drivers/power/pmic/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 obj-$(CONFIG_PMIC_TPS65217) += pmic_tps65217.o
 obj-$(CONFIG_PMIC_TPS65219) += tps65219.o
 obj-$(CONFIG_PMIC_TPS65941) += tps65941.o
+obj-$(CONFIG_PMIC_RAA215300) += raa215300.o
 obj-$(CONFIG_POWER_TPS65218) += pmic_tps65218.o
 
 ifeq ($(CONFIG_$(SPL_)POWER_LEGACY),y)
diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
new file mode 100644
index 000000000000..9c0b720994b2
--- /dev/null
+++ b/drivers/power/pmic/raa215300.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <i2c.h>
+#include <power/pmic.h>
+
+#define RAA215300_REG_COUNT 0x80
+
+static int raa215300_reg_count(struct udevice *dev)
+{
+	return RAA215300_REG_COUNT;
+}
+
+static struct dm_pmic_ops raa215300_ops = {
+	.reg_count = raa215300_reg_count,
+	.read = dm_i2c_read,
+	.write = dm_i2c_write,
+};
+
+static const struct udevice_id raa215300_ids[] = {
+	{ .compatible = "renesas,raa215300" },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(raa215300_pmic) = {
+	.name = "raa215300_pmic",
+	.id = UCLASS_PMIC,
+	.of_match = raa215300_ids,
+	.ops = &raa215300_ops,
+};
-- 
2.39.2

