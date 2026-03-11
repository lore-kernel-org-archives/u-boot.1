Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91A41062897
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4014E84082;
	Wed, 11 Mar 2026 14:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="dNowW41p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB64C83FB6; Wed, 11 Mar 2026 09:41:46 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0EF683FDE
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=t+
 k2DFfv+zqNHcqhn36s/mMzCmY9o5cRWygkj12oTYg=; b=dNowW41pMUkz2UaEY5
 jzSytKcvg0lcUM/gbxz4D++ueAgoC0Kpb/CEFy5iiGLAh5irA/P2XjuBXFrWXUBN
 87jaYmAW/Xl6/6YgppkQWEpdQj2iJy5qkmgFjLkgitmjjzm32+TKxDlBPFYY6qRX
 4l0K3oXwGOuMDTy4WMVBtYsqo=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S7; 
 Wed, 11 Mar 2026 16:41:33 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 5/7] mips: loongson: add clk driver
Date: Wed, 11 Mar 2026 16:41:27 +0800
Message-ID: <20260311084129.12809-6-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4DJry7WrWftw1DWrWUXFb_yoW7tw1xpa
 nYkFWrtr4Yq3y7G3WfJFyUJFySvF1FkFyUZrZFga4S9FnxAF1jqFs2ga43tF45CF97X3yY
 q3WqgrWxCFZFvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0oGQUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbC6B2A12mxKr24LQAA34
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

clk driver loongson mips for embedded SoC ls1c300

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 drivers/clk/Makefile               |   1 +
 drivers/clk/loongson/Makefile      |   3 +
 drivers/clk/loongson/clk-ls1c300.c | 179 +++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
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
index 00000000000..acca92cd657
--- /dev/null
+++ b/drivers/clk/loongson/clk-ls1c300.c
@@ -0,0 +1,179 @@
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
+	struct clk *cl, clk;
+	const char *parent_name;
+	int flags;
+	int ret;
+
+	base = (void *)dev_remap_addr_index(dev, 0);
+	cpu_throt  = (void *)dev_remap_addr_index(dev, 1);
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	ret = clk_get_rate(&clk);
+
+	parent_name = clk.dev->name;
+
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
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
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
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
+	.priv_auto = sizeof(struct clk),
+	.ops = &ls1c300_clk_ops,
+};
-- 
2.43.0

