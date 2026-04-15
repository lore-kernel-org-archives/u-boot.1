Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8709F4198B
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 12:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DBFC84207;
	Wed, 15 Apr 2026 14:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="WDysM2OO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1065483936; Wed, 15 Apr 2026 14:05:18 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 811B583936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 14:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Y8
 4239WcusOVETQkP2aaviIZ6D2nXxGGjtUZkDjPhdY=; b=WDysM2OOjRL5y4YbtX
 8pAhPE6BXqin5gx9VKOoZC3vqrgpn0cJ4JGKDR1ZoAGegap/747cfOB3WFNzk7R9
 gg7VPDV/qHm2jGhDDxXh6jZxdUf0nWtqpTo9TjyU6naTPu15wgURHQsbxXX7E8V2
 CtDfNcVgfh/ZxjL5vThb4Ssls=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wD3RcLJft9p2XkzFA--.19463S7; 
 Wed, 15 Apr 2026 20:04:47 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com
Cc: Du Huanpeng <u74147@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de (open list)
Subject: [PATCH v7 5/7] mips: loongson: add clk driver
Date: Wed, 15 Apr 2026 20:04:11 +0800
Message-ID: <20260415120425.5792-6-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415120425.5792-1-sgdfkk@163.com>
References: <20260415120425.5792-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3RcLJft9p2XkzFA--.19463S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4DJry7XF4DWr15Ar45trb_yoW7KF4xpa
 nYkFWrKr4Yq3y7G3WfJFyUJFySkF10yFyUurZFga4SkFnxAF4jqFs2ga43tF45CF97X3yY
 q3WqgrWxCFZFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7qXQUUUUU=
X-Originating-IP: [240e:3b0:4805:31e::3001]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCwB8pgGnfft97iwAA3R
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

clk driver loongson mips for embedded SoC ls1c300

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 drivers/clk/Makefile               |   1 +
 drivers/clk/loongson/Makefile      |   3 +
 drivers/clk/loongson/clk-ls1c300.c | 186 +++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 drivers/clk/loongson/Makefile
 create mode 100644 drivers/clk/loongson/clk-ls1c300.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..e19bb17276e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -23,6 +23,7 @@ obj-y += ti/
 obj-$(CONFIG_CLK_THEAD) += thead/
 obj-$(CONFIG_$(PHASE_)CLK_INTEL) += intel/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
+obj-$(CONFIG_ARCH_LSMIPS) += loongson/
 obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/
 obj-$(CONFIG_ARCH_MESON) += meson/
 obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
diff --git a/drivers/clk/loongson/Makefile b/drivers/clk/loongson/Makefile
new file mode 100644
index 00000000000..0a47269cd30
--- /dev/null
+++ b/drivers/clk/loongson/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SOC_LS1C300) += clk-ls1c300.o
diff --git a/drivers/clk/loongson/clk-ls1c300.c b/drivers/clk/loongson/clk-ls1c300.c
new file mode 100644
index 00000000000..0aa7470fe28
--- /dev/null
+++ b/drivers/clk/loongson/clk-ls1c300.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * reference:
+ *   drivers/clk/microchip/mpfs_clk.c
+ *   drivers/clk/clk_octeon.c
+ *
+ * Copyright (C) 2020-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dt-bindings/clock/ls1c300-clk.h>
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+
+/* PLL/SDRAM Frequency Configuration Register */
+#define START_FREQ	0
+#define CLK_DIV_PARAM	4
+
+/* START_FREQ */
+#define	PLL_VALID	BIT(31)
+#define	RESERVED0	GENMASK(30, 24)
+#define	FRAC_N		GENMASK(23, 16)
+#define	M_PLL		GENMASK(15, 8)
+#define	RESERVED1	GENMASK(7, 4)
+#define	RST_TIME	GENMASK(3, 2)
+#define	SDRAM_DIV	GENMASK(1, 0)
+/* CLK_DIV_PARAM */
+#define	PIX_DIV		GENMASK(31, 24)
+#define	CAM_DIV		GENMASK(23, 16)
+#define	CPU_DIV		GENMASK(15, 8)
+#define	RESERVED2	GENMASK(7, 6)
+#define	PIX_DIV_VALID	BIT(5)
+#define	PIX_SEL		BIT(4)
+#define	CAM_DIV_VALID	BIT(3)
+#define	CAM_SEL		BIT(2)
+#define	CPU_DIV_VALID	BIT(1)
+#define	CPU_SEL		BIT(0)
+/* CPU_THROT */
+#define	CPU_THROT	GENMASK(3, 0)
+
+struct ls1c300_clk_priv {
+	struct clk pll;
+	struct clk throt;
+};
+
+static const struct clk_div_table sdram_div_table[] = {
+	{.val = 0, .div = 2},
+	{.val = 1, .div = 4},
+	{.val = 2, .div = 3},
+	{.val = 3, .div = 3},
+};
+
+ulong ls1c300_pll_get_rate(struct clk *clk)
+{
+	unsigned int mult;
+	long long parent_rate;
+	void *base;
+	unsigned int val;
+
+	parent_rate = clk_get_parent_rate(clk);
+	base = (void *)clk->data;
+
+	val = readl(base + START_FREQ);
+	mult = FIELD_GET(FRAC_N, val) + FIELD_GET(M_PLL, val);
+	return (mult * parent_rate) / 4;
+}
+
+static ulong ls1c300_clk_get_rate(struct clk *clk)
+{
+	struct clk *cl;
+	ulong rate;
+	int err;
+
+	err = clk_get_by_id(clk->id, &cl);
+	if (err)
+		return err;
+
+	rate = clk_get_rate(cl);
+	return rate;
+}
+
+static int ls1c300_clk_probe(struct udevice *dev)
+{
+	void __iomem *base;
+	void __iomem *cpu_throt;
+	void __iomem *addr;
+
+	struct ls1c300_clk_priv *priv;
+
+	struct clk *cl, clk;
+	const char *parent_name;
+	int flags;
+	int ret;
+
+	base = dev_remap_addr_index(dev, 0);
+	cpu_throt  = dev_remap_addr_index(dev, 1);
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	ret = clk_get_rate(&clk);
+	parent_name = clk.dev->name;
+
+	priv = dev_get_priv(dev);
+	cl = &priv->pll;
+	cl->data = (unsigned long)base;
+	ret = clk_register(cl, "clk_ls1c300_pll", "pll", parent_name);
+	clk_dm(CLK_PLL, cl);
+
+	addr = base + CLK_DIV_PARAM;
+	flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO;
+	cl = clk_register_divider(NULL, "cpu_div", "pll", 0, addr,  8, 7, flags);
+	clk_dm(CLK_CPU, cl);
+	cl = clk_register_divider(NULL, "cam_div", "pll", 0, addr, 16, 7, flags);
+	clk_dm(CLK_CAMERA, cl);
+	cl = clk_register_divider(NULL, "pix_div", "pll", 0, addr, 24, 7, flags);
+	clk_dm(CLK_PIX, cl);
+
+	cl = &priv->throt;
+	cl->data = (unsigned long)cpu_throt;
+	ret = clk_register(cl, "clk_cpu_throt", "cpu_throt_factor", "cpu_div");
+	clk_dm(CLK_CPU_THROT, cl);
+
+	addr = base + START_FREQ;
+	cl = clk_register_divider(NULL, "sdram_div", "cpu_div", 0, addr, 0, 2, 0);
+	to_clk_divider(cl)->table = sdram_div_table;
+	clk_dm(CLK_APB, cl);
+
+	return 0;
+}
+
+static ulong cpu_throt_get_rate(struct clk *clk)
+{
+	void __iomem *cpu_throt;
+	long long parent_rate;
+	ulong ret;
+
+	parent_rate = clk_get_parent_rate(clk);
+	cpu_throt = (void *)clk->data;
+
+	ret = readl(cpu_throt) + 1;
+	ret = parent_rate * ret / 16;
+	return ret;
+}
+
+static const struct udevice_id ls1c300_clk_ids[] = {
+	{ .compatible = "loongson,ls1c300-clk" },
+	{ }
+};
+
+static const struct clk_ops clk_cpu_throt_ops = {
+	.get_rate = cpu_throt_get_rate,
+};
+
+static const struct clk_ops clk_ls1c300_pll_ops = {
+	.get_rate = ls1c300_pll_get_rate,
+};
+
+static const struct clk_ops ls1c300_clk_ops = {
+	.get_rate = ls1c300_clk_get_rate,
+};
+
+U_BOOT_DRIVER(clk_ls1c300_cpu_throt) = {
+	.name	= "clk_cpu_throt",
+	.id	= UCLASS_CLK,
+	.ops	= &clk_cpu_throt_ops,
+};
+
+U_BOOT_DRIVER(clk_ls1c300_pll) = {
+	.name	= "clk_ls1c300_pll",
+	.id	= UCLASS_CLK,
+	.ops	= &clk_ls1c300_pll_ops,
+};
+
+U_BOOT_DRIVER(ls1c300_clk) = {
+	.name = "clk_ls1c300",
+	.id = UCLASS_CLK,
+	.of_match = ls1c300_clk_ids,
+	.probe = ls1c300_clk_probe,
+	.priv_auto = sizeof(struct ls1c300_clk_priv),
+	.ops = &ls1c300_clk_ops,
+};
-- 
2.43.0

