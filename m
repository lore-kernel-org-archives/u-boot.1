Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69805106289F
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799C58404D;
	Wed, 11 Mar 2026 14:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="fDCOo7j4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0797A83FB6; Wed, 11 Mar 2026 09:41:47 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B65B83FEC
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xI
 WpXOdK9gn/p+VZDiY3i5CJVXd5YyrSaoSvShe9KaM=; b=fDCOo7j4zyHSaCfGFy
 TEgLUQPgKX/SFPqlKt4AcJLmGoETZYxBLjByVYQMtlqcCObmujzlG5SZi7tNqApE
 loHC3G7fHwSuNIMODxIz3KS9Ah7tG6SFjcvrZnZVhlrMX0ttKDZw2mm3BcyMR+lU
 uRCXaO9rMZnU46rxAWjADPKeA=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S8; 
 Wed, 11 Mar 2026 16:41:34 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 6/7] mips: loongson: add watchdog driver
Date: Wed, 11 Mar 2026 16:41:28 +0800
Message-ID: <20260311084129.12809-7-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw17AFWkKr1DtrW7Wr1kGrg_yoWrtw4fpF
 4Sy34FgrW7tr47WrZ3JayDXFs8C3yY9Fy3tFyxGw1rurnxAFn8X395KFy2qa97Zry3JrW5
 Zay8KFy8Ga15CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0oGQUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbC5x6A12mxKr65wQAA3a
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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

From: Du Huanpeng <u74147@gmail.com>

supports watchdog in loongson mips embedded SoCs

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 drivers/watchdog/Kconfig        |   8 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/loongson_wdt.c | 127 ++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/watchdog/loongson_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 35ae7d106b1..63bf0e04c80 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -213,6 +213,14 @@ config SPL_WDT_GPIO
 	help
 	  Support for external watchdog fed by toggling a gpio in SPL.
 
+config WDT_LOONGSON
+	bool "Loongson MIPS watchdog timer support"
+	depends on WDT
+	help
+	  Select this to enable watchdog timer for Loongson SoCs.
+	  The watchdog timer is stopped when initialized.
+	  It performs full SoC reset.
+
 config WDT_MAX6370
 	bool "MAX6370 watchdog timer support"
 	depends on WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 02e2674f8af..e9ffb417050 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_WDT_DA9063) += da9063-wdt.o
 obj-$(CONFIG_WDT_DAVINCI) += davinci_wdt.o
 obj-$(CONFIG_WDT_FTWDT010) += ftwdt010_wdt.o
 obj-$(CONFIG_$(SPL_TPL_)WDT_GPIO) += gpio_wdt.o
+obj-$(CONFIG_WDT_LOONGSON) += loongson_wdt.o
 obj-$(CONFIG_WDT_MAX6370) += max6370_wdt.o
 obj-$(CONFIG_WDT_MCF) += mcf_wdt.o
 obj-$(CONFIG_WDT_MESON_GXBB) += meson_gxbb_wdt.o
diff --git a/drivers/watchdog/loongson_wdt.c b/drivers/watchdog/loongson_wdt.c
new file mode 100644
index 00000000000..4d34d70296e
--- /dev/null
+++ b/drivers/watchdog/loongson_wdt.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Watchdog driver for MediaTek SoCs
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *
+ * based on: drivers/watchdog/mtk_wdt.c
+ * Copyright (C) 2020-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <dm.h>
+#include <hang.h>
+#include <wdt.h>
+#include <asm/io.h>
+#include <clk.h>
+#include <dm/device_compat.h>
+#include <linux/time.h>
+
+struct loongson_wdt_priv {
+	void __iomem *base;
+#define WDT_EN		0
+#define WDT_TIMER	4
+#define WDT_SET		8
+	ulong clock;
+	unsigned long timeout;
+};
+
+static int loongson_wdt_reset(struct udevice *dev)
+{
+	struct loongson_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(priv->timeout, priv->base + WDT_TIMER);
+	writel(1, priv->base + WDT_SET);
+
+	return 0;
+}
+
+static int loongson_wdt_stop(struct udevice *dev)
+{
+	struct loongson_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(0, priv->base + WDT_EN);
+	return 0;
+}
+
+static int loongson_wdt_expire_now(struct udevice *dev, ulong flags)
+{
+	struct loongson_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(1, priv->base + WDT_EN);
+	writel(1, priv->base + WDT_TIMER);
+	writel(1, priv->base + WDT_SET);
+
+	hang();
+	return 0;
+}
+
+static int loongson_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct loongson_wdt_priv *priv = dev_get_priv(dev);
+	unsigned int timeout;
+
+	timeout = U32_MAX / (priv->clock / MSEC_PER_SEC);
+
+	if (timeout < timeout_ms)
+		timeout = U32_MAX;
+	else
+		timeout = timeout_ms * (priv->clock / MSEC_PER_SEC);
+
+	debug("WDT: reload  = %08x\n", timeout);
+
+	writel(1, priv->base + WDT_EN);
+	writel(timeout, priv->base + WDT_TIMER);
+	writel(1, priv->base + WDT_SET);
+
+	priv->timeout = timeout;
+
+	return 0;
+}
+
+static int loongson_wdt_probe(struct udevice *dev)
+{
+	struct loongson_wdt_priv *priv = dev_get_priv(dev);
+	struct clk cl;
+	ulong clock;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -ENOENT;
+
+	if (clk_get_by_index(dev, 0, &cl) == 0)
+		clock = clk_get_rate(&cl);
+
+	debug("WDT: clock = %ld\n", clock);
+
+	if (IS_ERR_VALUE(clock)) {
+		dev_err(dev, "failed to get rate\n");
+		return clock;
+	}
+
+	priv->clock = clock;
+	writel(0, priv->base + WDT_EN);
+	return 0;
+}
+
+static const struct wdt_ops loongson_wdt_ops = {
+	.start = loongson_wdt_start,
+	.reset = loongson_wdt_reset,
+	.stop = loongson_wdt_stop,
+	.expire_now = loongson_wdt_expire_now,
+};
+
+static const struct udevice_id loongson_wdt_ids[] = {
+	{ .compatible = "loongson,ls1c300-wdt"},
+	{}
+};
+
+U_BOOT_DRIVER(loongson_wdt) = {
+	.name = "loongson_wdt",
+	.id = UCLASS_WDT,
+	.of_match = loongson_wdt_ids,
+	.priv_auto = sizeof(struct loongson_wdt_priv),
+	.probe = loongson_wdt_probe,
+	.ops = &loongson_wdt_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.43.0

