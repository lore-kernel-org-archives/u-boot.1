Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B799FED2F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C331841E3;
	Thu, 12 Mar 2026 11:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fZcAO6os";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 708B6841C2; Thu, 12 Mar 2026 11:10:24 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9192F84198
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zUUyQzrwqfqEQP/m7QbKvp0+ImyupFYvCtQgugCs5CA=; b=fZcAO6osaqVBRm9zSKhaWE/W75
 JcQNJRn3X5KLkd10lT1IY4qJZVYmUpLgdXZXDtyusXW21K7rtQJOdnsD39DyYKgKdCLLHuT1wsdaS
 03i2upfTbVggv90chCIj2X858DI9kY/LTkVI9xfpQlubJk2V4j8S5XilBbgBqF7Ob9pv2XFrRpSIX
 dLbmaAio4BdYY24nXF+52dfqbuconSL/QH6WZiYXPOCfSfP5XhEUdPboOZ9rEW3rV1uq9mu266Yma
 Mcwvx4/p8eOf6hiUKyVLpH3KqvV2q4/dHEHouyMkaujFQWeqYPaTCeGPGNwU/+esF7FLZJHhbGjMY
 tjEdB5ew==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0czm-000AfJ-1C; Thu, 12 Mar 2026 11:10:22 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-000Fyo-1J; Thu, 12 Mar 2026 10:57:38 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 10/13] board/tq: Add common mmc API
Date: Thu, 12 Mar 2026 10:57:06 +0100
Message-ID: <20260312095711.3219756-11-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
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

The default implementation reduces code duplication.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/common/Kconfig    |  3 +++
 board/tq/common/Makefile   |  1 +
 board/tq/common/tq_sdmmc.c | 46 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 board/tq/common/tq_sdmmc.c

diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
index a4a1d17bb9c..a1896929ea3 100644
--- a/board/tq/common/Kconfig
+++ b/board/tq/common/Kconfig
@@ -8,3 +8,6 @@
 config TQ_COMMON_BB
 	bool
 	default y
+
+config TQ_COMMON_SDMMC
+	bool
diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
index b643321fcb0..ac564a713fd 100644
--- a/board/tq/common/Makefile
+++ b/board/tq/common/Makefile
@@ -6,3 +6,4 @@
 #
 
 obj-$(CONFIG_TQ_COMMON_BB) += tq_bb.o
+obj-$(CONFIG_TQ_COMMON_SDMMC) += tq_sdmmc.o
diff --git a/board/tq/common/tq_sdmmc.c b/board/tq/common/tq_sdmmc.c
new file mode 100644
index 00000000000..b7336faa0c7
--- /dev/null
+++ b/board/tq/common/tq_sdmmc.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright (C) 2018-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ */
+
+#include <command.h>
+#include <env.h>
+#include <mmc.h>
+#include <stdbool.h>
+#include <vsprintf.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+
+#include "tq_bb.h"
+
+static int check_mmc_autodetect(void)
+{
+	/* NO or unset: 0 / YES: 1 */
+	return (env_get_yesno("mmcautodetect") > 0);
+}
+
+/* This should be defined for each board */
+__weak int mmc_map_to_kernel_blk(int dev_no)
+{
+	return dev_no;
+}
+
+void board_late_mmc_env_init(void)
+{
+	char cmd[32];
+	u32 dev_no;
+
+	dev_no = mmc_get_env_dev();
+
+	if (!check_mmc_autodetect())
+		return;
+
+	env_set_ulong("mmcdev", dev_no);
+	env_set_ulong("mmcblkdev", mmc_map_to_kernel_blk(dev_no));
+
+	snprintf(cmd, ARRAY_SIZE(cmd), "mmc dev %d", dev_no);
+	run_command(cmd, 0);
+}
-- 
2.43.0

