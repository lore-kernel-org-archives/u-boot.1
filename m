Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97189C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15ACB8746C;
	Wed, 15 Nov 2023 18:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E8C8747E; Wed, 15 Nov 2023 18:40:53 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id CE4D88746A
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,305,1694703600"; d="scan'208";a="186893830"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Nov 2023 02:40:50 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.122])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6A12140342AD;
 Thu, 16 Nov 2023 02:40:48 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH 5/5] sysreset: Support reset via Renesas RAA215300 PMIC
Date: Wed, 15 Nov 2023 17:40:25 +0000
Message-Id: <20231115174025.12974-6-paul.barker.ct@bp.renesas.com>
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

This patch allows us to reset the RZ/G2L board via the RAA215300 PMIC.

Note that the RAA215300 documentation names the available reset types
differently to u-boot:

  - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
    (CPU & GPIOs), so this corresponds to SYSRESET_COLD.

  - A "cold" reset via the RAA215300 PMIC will cycle all power supply
    rails, so this corresponds to SYSRESET_POWER.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 board/renesas/rzg2l/rzg2l.c           |  8 ----
 configs/renesas_rzg2l_smarc_defconfig |  2 +
 drivers/power/pmic/raa215300.c        | 17 ++++++++
 drivers/sysreset/Kconfig              |  6 +++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset_raa215300.c | 58 +++++++++++++++++++++++++++
 6 files changed, 84 insertions(+), 8 deletions(-)
 create mode 100644 drivers/sysreset/sysreset_raa215300.c

diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c
index 73201a8c69e5..0f6d6e7f514f 100644
--- a/board/renesas/rzg2l/rzg2l.c
+++ b/board/renesas/rzg2l/rzg2l.c
@@ -56,11 +56,3 @@ int board_init(void)
 {
 	return 0;
 }
-
-void reset_cpu(void)
-{
-	/*
-	 * TODO: Implement reset support once TrustedFirmware supports
-	 * the appropriate call.
-	 */
-}
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index b62eae4ee0a4..ba96e746df9e 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -55,3 +55,5 @@ CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_RAA215300=y
diff --git a/drivers/power/pmic/raa215300.c b/drivers/power/pmic/raa215300.c
index 9c0b720994b2..7f68f95f25cf 100644
--- a/drivers/power/pmic/raa215300.c
+++ b/drivers/power/pmic/raa215300.c
@@ -27,9 +27,26 @@ static const struct udevice_id raa215300_ids[] = {
 	{ /* sentinel */ }
 };
 
+static int raa215300_bind(struct udevice *dev)
+{
+	struct driver *drv;
+
+	if (IS_ENABLED(CONFIG_SYSRESET_RAA215300)) {
+		drv = lists_driver_lookup_name("raa215300_sysreset");
+		if (!drv)
+			return -ENOENT;
+
+		return device_bind(dev, drv, dev->name, NULL, dev_ofnode(dev),
+				   NULL);
+	}
+
+	return 0;
+}
+
 U_BOOT_DRIVER(raa215300_pmic) = {
 	.name = "raa215300_pmic",
 	.id = UCLASS_PMIC,
 	.of_match = raa215300_ids,
+	.bind = raa215300_bind,
 	.ops = &raa215300_ops,
 };
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 0e52f996283c..49c0787b26d8 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -229,6 +229,12 @@ config SYSRESET_MPC83XX
 	help
 	  Reboot support for NXP MPC83xx SoCs.
 
+config SYSRESET_RAA215300
+	bool "Support sysreset via Renesas RAA215300 PMIC"
+	depends on PMIC_RAA215300
+	help
+	  Add support for the system reboot via the Renesas RAA215300 PMIC.
+
 endif
 
 endmenu
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index c9f1c625aebb..e0e732205df3 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -27,4 +27,5 @@ obj-$(CONFIG_SYSRESET_WATCHDOG) += sysreset_watchdog.o
 obj-$(CONFIG_SYSRESET_RESETCTL) += sysreset_resetctl.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_AT91) += sysreset_at91.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_X86) += sysreset_x86.o
+obj-$(CONFIG_SYSRESET_RAA215300) += sysreset_raa215300.o
 obj-$(CONFIG_TARGET_XTFPGA) += sysreset_xtfpga.o
diff --git a/drivers/sysreset/sysreset_raa215300.c b/drivers/sysreset/sysreset_raa215300.c
new file mode 100644
index 000000000000..32dfcb0aec84
--- /dev/null
+++ b/drivers/sysreset/sysreset_raa215300.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Renesas Electronics Corporation
+ */
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <sysreset.h>
+
+#define RAA215300_REG_SWRESET	0x6D
+#define RAA215300_COLD_RESET	BIT(0)
+#define RAA215300_WARM_RESET	BIT(1)
+
+static int raa215300_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct udevice *pmic = dev_get_parent(dev);
+	int ret;
+	u8 val;
+
+	/*
+	 * The RAA215300 documentation names the available reset types
+	 * differently to u-boot:
+	 *
+	 *   - A "warm" reset via the RAA215300 PMIC will fully reset the SoC
+	 *     (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
+	 *
+	 *   - A "cold" reset via the RAA215300 PMIC will cycle all power supply
+	 *     rails, so this corresponds to SYSRESET_POWER.
+	 */
+	switch (type) {
+	case SYSRESET_COLD:
+		val = RAA215300_WARM_RESET;
+		break;
+
+	case SYSRESET_POWER:
+		val = RAA215300_COLD_RESET;
+		break;
+
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	ret = pmic_reg_write(pmic, RAA215300_REG_SWRESET, val);
+	if (ret)
+		return ret;
+
+	return -EINPROGRESS;
+}
+
+static struct sysreset_ops raa215300_sysreset_ops = {
+	.request = raa215300_sysreset_request,
+};
+
+U_BOOT_DRIVER(raa215300_sysreset) = {
+	.name = "raa215300_sysreset",
+	.id = UCLASS_SYSRESET,
+	.ops = &raa215300_sysreset_ops,
+};
-- 
2.39.2

