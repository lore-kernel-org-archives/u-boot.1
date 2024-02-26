Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD7EC54E41
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 15:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86AFE87F1F;
	Mon, 26 Feb 2024 16:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC38487F20; Mon, 26 Feb 2024 16:06:01 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 69A1B87F26
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 16:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,185,1705330800"; d="scan'208";a="195362611"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2024 00:05:59 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.126])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 522B1400C739;
 Tue, 27 Feb 2024 00:05:57 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/7] sysreset: Support reset via Renesas RAA215300 PMIC
Date: Mon, 26 Feb 2024 15:05:34 +0000
Message-Id: <20240226150536.1690-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
References: <20240226150536.1690-1-paul.barker.ct@bp.renesas.com>
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

This patch adds support for resetting a board via the RAA215300 PMIC.

Note that the RAA215300 documentation names the available reset types
differently to u-boot:

  * A "warm" reset via the RAA215300 PMIC will fully reset the SoC
    (CPU & GPIOs), so this corresponds to SYSRESET_COLD.
  
  * A "cold" reset via the RAA215300 PMIC will cycle all power supply
    rails, so this corresponds to SYSRESET_POWER.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/sysreset/Kconfig              |  6 +++
 drivers/sysreset/Makefile             |  1 +
 drivers/sysreset/sysreset_raa215300.c | 58 +++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/sysreset/sysreset_raa215300.c

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
2.43.2

