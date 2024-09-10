Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969E6ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B29688FD0;
	Tue, 10 Sep 2024 11:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49CB688F63; Tue, 10 Sep 2024 11:39:33 +0200 (CEST)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F230788F48
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 10 Sep
 2024 17:39:21 +0800
Received: from mail.aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 10 Sep 2024 17:39:21 +0800
From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <ryan_chen@aspeedtech.com>, <joel@jms.id.au>, <u-boot@lists.denx.de>
Subject: [PATCH v2 5/8] timer: Add AST2700 IBEX timer support
Date: Tue, 10 Sep 2024 17:39:17 +0800
Message-ID: <20240910093920.1142455-6-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
References: <20240910093920.1142455-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Add the driver for the AST2700 Ibex timer, which uses CPU
cycles as the timer count running at 200MHz.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 drivers/timer/Kconfig          |  6 +++++
 drivers/timer/Makefile         |  1 +
 drivers/timer/ast_ibex_timer.c | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/timer/ast_ibex_timer.c

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 6b1de82ae38..cb6fc0e7fda 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -106,6 +106,12 @@ config AST_TIMER
 	  This is mostly because they all share several registers which
 	  makes it difficult to completely separate them.
 
+config AST_IBEX_TIMER
+	bool "Aspeed ast2700 Ibex timer"
+	depends on TIMER
+	help
+	  Select this to enable a timer support for the Ibex RV32-based MCUs in AST2700.
+
 config ATCPIT100_TIMER
 	bool "ATCPIT100 timer support"
 	depends on TIMER
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index fb95c8899e3..fec4af392e6 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_$(SPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
 obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
 obj-$(CONFIG_ARM_TWD_TIMER)	+= arm_twd_timer.o
 obj-$(CONFIG_AST_TIMER)	+= ast_timer.o
+obj-$(CONFIG_AST_IBEX_TIMER)	+= ast_ibex_timer.o
 obj-$(CONFIG_ATCPIT100_TIMER) += atcpit100_timer.o
 obj-$(CONFIG_$(SPL_)ATMEL_PIT_TIMER) += atmel_pit_timer.o
 obj-$(CONFIG_$(SPL_)ATMEL_TCB_TIMER) += atmel_tcb_timer.o
diff --git a/drivers/timer/ast_ibex_timer.c b/drivers/timer/ast_ibex_timer.c
new file mode 100644
index 00000000000..261839661e9
--- /dev/null
+++ b/drivers/timer/ast_ibex_timer.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Aspeed Technology Inc.
+ */
+
+#include <asm/csr.h>
+#include <asm/io.h>
+#include <dm.h>
+#include <errno.h>
+#include <timer.h>
+
+#define CSR_MCYCLE	0xb00
+#define CSR_MCYCLEH	0xb80
+
+static u64 ast_ibex_timer_get_count(struct udevice *dev)
+{
+	uint32_t cnt_l, cnt_h;
+
+	cnt_l = csr_read(CSR_MCYCLE);
+	cnt_h = csr_read(CSR_MCYCLEH);
+
+	return ((uint64_t)cnt_h << 32) | cnt_l;
+}
+
+static int ast_ibex_timer_probe(struct udevice *dev)
+{
+	return 0;
+}
+
+static const struct timer_ops ast_ibex_timer_ops = {
+	.get_count = ast_ibex_timer_get_count,
+};
+
+static const struct udevice_id ast_ibex_timer_ids[] = {
+	{ .compatible = "aspeed,ast2700-ibex-timer" },
+	{ }
+};
+
+U_BOOT_DRIVER(ast_ibex_timer) = {
+	.name = "ast_ibex_timer",
+	.id = UCLASS_TIMER,
+	.of_match = ast_ibex_timer_ids,
+	.probe = ast_ibex_timer_probe,
+	.ops = &ast_ibex_timer_ops,
+};
-- 
2.25.1

