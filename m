Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7ED15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC9288F6B;
	Mon, 21 Oct 2024 17:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oQatQ6pF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95C0B88F3D; Mon, 21 Oct 2024 17:13:44 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6153488F47
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:13:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id B5AE6FF806;
 Mon, 21 Oct 2024 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1729523622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JD73HEskjgHiSD6i2xNtFANXAx6hqgdyMwpvFvgQ+Y=;
 b=oQatQ6pF2TKFbSjryUvjhe7/gsVbaxP0x6d2ZbP+hey9OzsGaWUjy0DqEdCMaH6PECNySc
 YVigfiWxhRf9d+SpNdcg5hA6Rxx9fy92/+ViEzza5pCAUdotX22sRdnBrshU51BX7jUe68
 zG8lE9leI+UflVkHzvO65aT7Ct5a/2TgDM61nJxe/G3KriorRTJk/vmzT2sw+1PIn9Lw5W
 tnH2LOP0tkDzXrYxT3BdPO4w1ipzYg4Mpm0PW+FOtsWjVUN1LqQntFhEJ/R0lLcljHBymr
 DDFyZa0BHHk5jrZx6NqLgnXxrdxh9+YjzZOJNKp0UaqFsKE6P8zvyI7Y0kjJAg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Tom Rini <trini@konsulko.com>,
	Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Christopher Cordahi <christophercordahi@nanometrics.ca>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 5/6] memory: ti-aemif: Add DM support
Date: Mon, 21 Oct 2024 17:13:29 +0200
Message-ID: <20241021151330.1860929-6-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
References: <20241021151330.1860929-1-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com
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

The AEMIF's bindings in the Linux tree have a node for the AEMIF
controller and then a node for each AEMIF's chip select. This CS node
doesn't have a compatible property but describes the timing parameters
used by a given chip select.
The U-Boot DM framework expects every node to have a 'compatible'
property. If no 'compatible' is present in a node, its children won't be
parsed by u-boot.

Add DM support to the ti-aemif driver.
Add a new ti-aemif-cs driver to comply with the Linux bindings and the
U-Boot's DM philosophy. This driver handles the timing parameters
of an AEMIF's chip select so move aemif_cs_configure() from ti-aemif.c
to ti-aemif-cs.c.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/memory/Makefile      |  2 +-
 drivers/memory/ti-aemif-cs.c | 61 ++++++++++++++++++++++++++++++++++++
 drivers/memory/ti-aemif-cs.h |  4 +++
 drivers/memory/ti-aemif.c    | 53 ++++++++-----------------------
 4 files changed, 79 insertions(+), 41 deletions(-)
 create mode 100644 drivers/memory/ti-aemif-cs.c
 create mode 100644 drivers/memory/ti-aemif-cs.h

diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 1cabf8ac9c..fdc83e4e1c 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_MEMORY) += memory-uclass.o
 obj-$(CONFIG_SANDBOX_MEMORY) += memory-sandbox.o
 obj-$(CONFIG_STM32_FMC2_EBI) += stm32-fmc2-ebi.o
 obj-$(CONFIG_ATMEL_EBI) += atmel_ebi.o
-obj-$(CONFIG_TI_AEMIF) += ti-aemif.o
+obj-$(CONFIG_TI_AEMIF) += ti-aemif.o ti-aemif-cs.o
 obj-$(CONFIG_TI_GPMC) += ti-gpmc.o
diff --git a/drivers/memory/ti-aemif-cs.c b/drivers/memory/ti-aemif-cs.c
new file mode 100644
index 0000000000..80166e3e6a
--- /dev/null
+++ b/drivers/memory/ti-aemif-cs.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DaVinci / Keystone2 : AEMIF's chip select configuration
+ *
+ */
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include "ti-aemif-cs.h"
+
+#define AEMIF_CONFIG(cs)		(0x10 + ((cs) * 4))
+
+#define AEMIF_CFG_SELECT_STROBE(v)	((v) ? 1 << 31 : 0)
+#define AEMIF_CFG_EXTEND_WAIT(v)	((v) ? 1 << 30 : 0)
+#define AEMIF_CFG_WR_SETUP(v)		(((v) & 0x0f) << 26)
+#define AEMIF_CFG_WR_STROBE(v)		(((v) & 0x3f) << 20)
+#define AEMIF_CFG_WR_HOLD(v)		(((v) & 0x07) << 17)
+#define AEMIF_CFG_RD_SETUP(v)		(((v) & 0x0f) << 13)
+#define AEMIF_CFG_RD_STROBE(v)		(((v) & 0x3f) << 7)
+#define AEMIF_CFG_RD_HOLD(v)		(((v) & 0x07) << 4)
+#define AEMIF_CFG_TURN_AROUND(v)	(((v) & 0x03) << 2)
+#define AEMIF_CFG_WIDTH(v)		(((v) & 0x03) << 0)
+
+#define set_config_field(reg, field, val)				\
+	do {								\
+		if ((val) != -1) {					\
+			(reg) &= ~AEMIF_CFG_##field(0xffffffff);	\
+			(reg) |=	AEMIF_CFG_##field((val));	\
+		}							\
+	} while (0)
+
+void aemif_cs_configure(int cs, struct aemif_config *cfg)
+{
+	unsigned long tmp;
+
+	tmp = __raw_readl(cfg->base + AEMIF_CONFIG(cs));
+
+	set_config_field(tmp, SELECT_STROBE,	cfg->select_strobe);
+	set_config_field(tmp, EXTEND_WAIT,	cfg->extend_wait);
+	set_config_field(tmp, WR_SETUP,		cfg->wr_setup);
+	set_config_field(tmp, WR_STROBE,	cfg->wr_strobe);
+	set_config_field(tmp, WR_HOLD,		cfg->wr_hold);
+	set_config_field(tmp, RD_SETUP,		cfg->rd_setup);
+	set_config_field(tmp, RD_STROBE,	cfg->rd_strobe);
+	set_config_field(tmp, RD_HOLD,		cfg->rd_hold);
+	set_config_field(tmp, TURN_AROUND,	cfg->turn_around);
+	set_config_field(tmp, WIDTH,		cfg->width);
+
+	__raw_writel(tmp, cfg->base + AEMIF_CONFIG(cs));
+}
+
+static const struct udevice_id aemif_cs_ids[] = {
+	{ .compatible = "ti,da850-aemif-cs", },
+	{},
+};
+
+U_BOOT_DRIVER(ti_aemif_cs) = {
+	.name = "ti_aemif_cs",
+	.id = UCLASS_MEMORY,
+	.of_match = aemif_cs_ids,
+};
diff --git a/drivers/memory/ti-aemif-cs.h b/drivers/memory/ti-aemif-cs.h
new file mode 100644
index 0000000000..62e6c6ed1a
--- /dev/null
+++ b/drivers/memory/ti-aemif-cs.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#include <asm/ti-common/ti-aemif.h>
+
+void aemif_cs_configure(int cs, struct aemif_config *cfg);
diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index 5e9514713f..b26423c457 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -9,50 +9,12 @@
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <asm/ti-common/ti-aemif.h>
+#include <dm.h>
+#include "ti-aemif-cs.h"
 
 #define AEMIF_WAITCYCLE_CONFIG		(0x4)
 #define AEMIF_NAND_CONTROL		(0x60)
 #define AEMIF_ONENAND_CONTROL		(0x5c)
-#define AEMIF_CONFIG(cs)		(0x10 + ((cs) * 4))
-
-#define AEMIF_CFG_SELECT_STROBE(v)	((v) ? 1 << 31 : 0)
-#define AEMIF_CFG_EXTEND_WAIT(v)	((v) ? 1 << 30 : 0)
-#define AEMIF_CFG_WR_SETUP(v)		(((v) & 0x0f) << 26)
-#define AEMIF_CFG_WR_STROBE(v)		(((v) & 0x3f) << 20)
-#define AEMIF_CFG_WR_HOLD(v)		(((v) & 0x07) << 17)
-#define AEMIF_CFG_RD_SETUP(v)		(((v) & 0x0f) << 13)
-#define AEMIF_CFG_RD_STROBE(v)		(((v) & 0x3f) << 7)
-#define AEMIF_CFG_RD_HOLD(v)		(((v) & 0x07) << 4)
-#define AEMIF_CFG_TURN_AROUND(v)	(((v) & 0x03) << 2)
-#define AEMIF_CFG_WIDTH(v)		(((v) & 0x03) << 0)
-
-#define set_config_field(reg, field, val)			\
-	do {							\
-		if (val != -1) {				\
-			reg &= ~AEMIF_CFG_##field(0xffffffff);	\
-			reg |=	AEMIF_CFG_##field(val);		\
-		}						\
-	} while (0)
-
-static void aemif_cs_configure(int cs, struct aemif_config *cfg)
-{
-	unsigned long tmp;
-
-	tmp = __raw_readl(cfg->base + AEMIF_CONFIG(cs));
-
-	set_config_field(tmp, SELECT_STROBE,	cfg->select_strobe);
-	set_config_field(tmp, EXTEND_WAIT,	cfg->extend_wait);
-	set_config_field(tmp, WR_SETUP,		cfg->wr_setup);
-	set_config_field(tmp, WR_STROBE,	cfg->wr_strobe);
-	set_config_field(tmp, WR_HOLD,		cfg->wr_hold);
-	set_config_field(tmp, RD_SETUP,		cfg->rd_setup);
-	set_config_field(tmp, RD_STROBE,	cfg->rd_strobe);
-	set_config_field(tmp, RD_HOLD,		cfg->rd_hold);
-	set_config_field(tmp, TURN_AROUND,	cfg->turn_around);
-	set_config_field(tmp, WIDTH,		cfg->width);
-
-	__raw_writel(tmp, cfg->base + AEMIF_CONFIG(cs));
-}
 
 static void aemif_configure(int cs, struct aemif_config *cfg)
 {
@@ -84,3 +46,14 @@ void aemif_init(int num_cs, struct aemif_config *config)
 	for (cs = 0; cs < num_cs; cs++)
 		aemif_configure(cs, config + cs);
 }
+
+static const struct udevice_id aemif_ids[] = {
+	{ .compatible = "ti,da850-aemif", },
+	{},
+};
+
+U_BOOT_DRIVER(ti_aemif) = {
+	.name = "ti_aemif",
+	.id = UCLASS_MEMORY,
+	.of_match = aemif_ids,
+};
-- 
2.47.0

