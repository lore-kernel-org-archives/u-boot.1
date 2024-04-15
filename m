Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD7AC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02E28821D;
	Mon, 15 Apr 2024 08:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9AD8820A; Mon, 15 Apr 2024 08:08:15 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5955F88169
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYT12Ytz9t2k;
 Mon, 15 Apr 2024 08:08:13 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b5w6vd9Duwci; Mon, 15 Apr 2024 08:08:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYK35SZz9t5L;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 64FBC8B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cdJTL0yRM3KG; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 41F918B764;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 08/17] thermal: Add support for TI LM74
Date: Mon, 15 Apr 2024 08:07:21 +0200
Message-ID: <e2240984726e028aed5d9c75c16f4b6b45eb1aeb.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

LM74 is a SPI temperature sensor.

Implement a driver to read temperature from it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/thermal/Kconfig   |  6 +++++
 drivers/thermal/Makefile  |  1 +
 drivers/thermal/ti-lm74.c | 52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 drivers/thermal/ti-lm74.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 681b621760..440eb64a56 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -41,4 +41,10 @@ config TI_DRA7_THERMAL
 	 Enable thermal support for for the Texas Instruments DRA752 SoC family.
 	 The driver supports reading CPU temperature.
 
+config TI_LM74_THERMAL
+        bool "Temperature sensor driver for TI LM74 chip"
+        help
+	 Enable thermal support for the Texas Instruments LM74 chip.
+	 The driver supports reading CPU temperature.
+
 endif # if DM_THERMAL
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 8acc7d20cb..b5ab0fc221 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_IMX_THERMAL) += imx_thermal.o
 obj-$(CONFIG_IMX_SCU_THERMAL) += imx_scu_thermal.o
 obj-$(CONFIG_TI_DRA7_THERMAL) += ti-bandgap.o
 obj-$(CONFIG_IMX_TMU) += imx_tmu.o
+obj-$(CONFIG_TI_LM74_THERMAL) += ti-lm74.o
diff --git a/drivers/thermal/ti-lm74.c b/drivers/thermal/ti-lm74.c
new file mode 100644
index 0000000000..7d56f75df0
--- /dev/null
+++ b/drivers/thermal/ti-lm74.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TI LM74 temperature sensor driver
+ *
+ * Copyright (C) 2024 CS GROUP France
+ *
+ */
+
+#include <dm.h>
+#include <thermal.h>
+#include <spi.h>
+
+static int ti_lm74_get_temp(struct udevice *dev, int *temp)
+{
+	char buf[2];
+	s16 raw;
+	int ret;
+
+	ret = dm_spi_claim_bus(dev);
+	if (ret)
+		return ret;
+
+	ret = dm_spi_xfer(dev, 16, NULL, buf, SPI_XFER_BEGIN | SPI_XFER_END);
+
+	dm_spi_release_bus(dev);
+	if (ret)
+		return ret;
+
+	raw = ((buf[0] << 8) + buf[1]) >> 3;
+
+	*temp = (((int)raw * 125) + 1000) / 2000;
+
+	return 0;
+}
+
+static struct dm_thermal_ops ti_lm74_ops = {
+	.get_temp	= ti_lm74_get_temp,
+};
+
+static const struct udevice_id of_ti_lm74_match[] = {
+	{
+		.compatible = "ti,lm74",
+	},
+	{},
+};
+
+U_BOOT_DRIVER(ti_bandgap_thermal) = {
+	.name	= "ti_lm74_thermal",
+	.id	= UCLASS_THERMAL,
+	.ops	= &ti_lm74_ops,
+	.of_match = of_ti_lm74_match,
+};
-- 
2.43.0

