Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C0CC4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE1B877B0;
	Wed, 13 Dec 2023 04:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zrDjC+P7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5145D8781E; Wed, 13 Dec 2023 04:17:01 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6020F8747A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-20311257937so585999fac.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437414; x=1703042214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXVjjJFaOLYOXZSVuL8PoWrTK362TYBBC78fLqoDayc=;
 b=zrDjC+P70zRIIpLWNR5UGdoqIl6h5ODzsY73UbPKP1HTny0jRruhn3km648hLY1fZX
 aQ+yCwpQQwgHJQ8r+F2yS1IcIDjXsRFTUUuwIGGjJWtMFhgwtZVXUU8Sv+9Ns78Mjd9T
 wqoh2eUq8h266zgR2Iq482HAwCkzMIIZFn20nnqQCcclFwnLVsqFBnthNEhlrf4bAvYc
 io7U4pI2vMPxRD3niJ7NP9RNHhKcOZssXiT0WjEMhbpZWyN4kh/R6PVwhIQOHiY5Gz9k
 bgIJFhjUgw0T5EY2aLvibQDXg15Qp3huoU65oZDqtRinlqMWEpMAXosejtbq+QMBIO+Q
 gyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437414; x=1703042214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mXVjjJFaOLYOXZSVuL8PoWrTK362TYBBC78fLqoDayc=;
 b=MOzI0VYymz+ULQ/2S4shkK15dH/TCu4ygUmmg2IiG4VgvwPZBm+kcSOoQxLG+ydDoj
 Y8E97RPOj7cStXHw/ratDkKFbphb0tFAvwcq6YNioLHqf/HdJiGL5HMDsbUQfXYYrS3W
 zVyJOrYbaHxaRzwzd5Z06Q0betXh9I2LduSqVo9erWMN0wQ6VJnUHriU3eyevGogZPX+
 5/fQ+dCPzu+q1nQ88PSxB+FRwTbl2LxdgbEouc5KzvYsBZJcoMBZfHULI9mDDPQgY0wr
 l26WKpjlbDnAn10tJ22uYNnsgObhlocsuNpv1Z3AlYJqHoxch1MU347LkH9xbKZcqUW7
 +QXQ==
X-Gm-Message-State: AOJu0YzxM+1NkbdTKEn9EDEMRguKgfygUcdQJIOFxRvxaMxBjRzsX6nA
 KIvi7pin+QD+Q/k40G6AcMiTVQ==
X-Google-Smtp-Source: AGHT+IGW08ZTSLlxzkVKdF5aJtC6soacCAlSu0bZPEVyXqn5NlLyb91xbhQq+GWYAlkSypbQCbGzcg==
X-Received: by 2002:a05:6870:ac29:b0:1fa:2b7a:9ece with SMTP id
 kw41-20020a056870ac2900b001fa2b7a9ecemr8692900oab.46.1702437413691; 
 Tue, 12 Dec 2023 19:16:53 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 vq8-20020a056871a08800b001fafc32e808sm3706837oab.0.2023.12.12.19.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 07/13] clk: exynos: Add Samsung clock framework
Date: Tue, 12 Dec 2023 21:16:40 -0600
Message-Id: <20231213031646.28828-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213031646.28828-1-semen.protsenko@linaro.org>
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
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

Heavily based on Linux kernel Samsung clock framework, with some changes
to accommodate the differences in U-Boot CCF implementation. It's also
quite minimal as compared to the Linux version.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/Makefile  |   9 +-
 drivers/clk/exynos/clk-pll.c | 167 +++++++++++++++++++++++++
 drivers/clk/exynos/clk-pll.h |  23 ++++
 drivers/clk/exynos/clk.c     | 121 +++++++++++++++++++
 drivers/clk/exynos/clk.h     | 228 +++++++++++++++++++++++++++++++++++
 5 files changed, 546 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/exynos/clk-pll.c
 create mode 100644 drivers/clk/exynos/clk-pll.h
 create mode 100644 drivers/clk/exynos/clk.c
 create mode 100644 drivers/clk/exynos/clk.h

diff --git a/drivers/clk/exynos/Makefile b/drivers/clk/exynos/Makefile
index 7faf238571ef..04c5b9a39e16 100644
--- a/drivers/clk/exynos/Makefile
+++ b/drivers/clk/exynos/Makefile
@@ -1,6 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # Copyright (C) 2016 Samsung Electronics
-# Thomas Abraham <thomas.ab@samsung.com>
+# Copyright (C) 2023 Linaro Ltd.
+#
+# Authors:
+#   Thomas Abraham <thomas.ab@samsung.com>
+#   Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-$(CONFIG_CLK_EXYNOS7420)	+= clk-exynos7420.o
+obj-$(CONFIG_$(SPL_TPL_)CLK_CCF)	+= clk.o clk-pll.o
+obj-$(CONFIG_CLK_EXYNOS7420)		+= clk-exynos7420.o
diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
new file mode 100644
index 000000000000..9e496ff83aaf
--- /dev/null
+++ b/drivers/clk/exynos/clk-pll.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Samsung Electronics
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Authors:
+ *   Thomas Abraham <thomas.ab@exynos.com>
+ *   Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * This file contains the utility functions to register the pll clocks.
+ */
+
+#include <asm/io.h>
+#include <div64.h>
+#include <malloc.h>
+#include <clk-uclass.h>
+#include <dm/device.h>
+#include <clk.h>
+#include "clk.h"
+
+#define UBOOT_DM_CLK_SAMSUNG_PLL0822X	"samsung_clk_pll0822x"
+#define UBOOT_DM_CLK_SAMSUNG_PLL0831X	"samsung_clk_pll0831x"
+
+struct samsung_clk_pll {
+	struct clk		clk;
+	void __iomem		*con_reg;
+	enum samsung_pll_type	type;
+};
+
+#define to_clk_pll(_clk) container_of(_clk, struct samsung_clk_pll, clk)
+
+/*
+ * PLL0822x Clock Type
+ */
+
+#define PLL0822X_MDIV_MASK		0x3ff
+#define PLL0822X_PDIV_MASK		0x3f
+#define PLL0822X_SDIV_MASK		0x7
+#define PLL0822X_MDIV_SHIFT		16
+#define PLL0822X_PDIV_SHIFT		8
+#define PLL0822X_SDIV_SHIFT		0
+
+static unsigned long samsung_pll0822x_recalc_rate(struct clk *clk)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(clk);
+	u32 mdiv, pdiv, sdiv, pll_con3;
+	u64 fvco = clk_get_parent_rate(clk);
+
+	pll_con3 = readl_relaxed(pll->con_reg);
+	mdiv = (pll_con3 >> PLL0822X_MDIV_SHIFT) & PLL0822X_MDIV_MASK;
+	pdiv = (pll_con3 >> PLL0822X_PDIV_SHIFT) & PLL0822X_PDIV_MASK;
+	sdiv = (pll_con3 >> PLL0822X_SDIV_SHIFT) & PLL0822X_SDIV_MASK;
+
+	fvco *= mdiv;
+	do_div(fvco, (pdiv << sdiv));
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll0822x_clk_min_ops = {
+	.get_rate = samsung_pll0822x_recalc_rate,
+};
+
+/*
+ * PLL0831x Clock Type
+ */
+
+#define PLL0831X_KDIV_MASK		0xffff
+#define PLL0831X_MDIV_MASK		0x1ff
+#define PLL0831X_PDIV_MASK		0x3f
+#define PLL0831X_SDIV_MASK		0x7
+#define PLL0831X_MDIV_SHIFT		16
+#define PLL0831X_PDIV_SHIFT		8
+#define PLL0831X_SDIV_SHIFT		0
+#define PLL0831X_KDIV_SHIFT		0
+
+static unsigned long samsung_pll0831x_recalc_rate(struct clk *clk)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(clk);
+	u32 mdiv, pdiv, sdiv, pll_con3, pll_con5;
+	s16 kdiv;
+	u64 fvco = clk_get_parent_rate(clk);
+
+	pll_con3 = readl_relaxed(pll->con_reg);
+	pll_con5 = readl_relaxed(pll->con_reg + 8);
+	mdiv = (pll_con3 >> PLL0831X_MDIV_SHIFT) & PLL0831X_MDIV_MASK;
+	pdiv = (pll_con3 >> PLL0831X_PDIV_SHIFT) & PLL0831X_PDIV_MASK;
+	sdiv = (pll_con3 >> PLL0831X_SDIV_SHIFT) & PLL0831X_SDIV_MASK;
+	kdiv = (s16)((pll_con5 >> PLL0831X_KDIV_SHIFT) & PLL0831X_KDIV_MASK);
+
+	fvco *= (mdiv << 16) + kdiv;
+	do_div(fvco, (pdiv << sdiv));
+	fvco >>= 16;
+
+	return (unsigned long)fvco;
+}
+
+static const struct clk_ops samsung_pll0831x_clk_min_ops = {
+	.get_rate = samsung_pll0831x_recalc_rate,
+};
+
+static struct clk *_samsung_clk_register_pll(void __iomem *base,
+					const struct samsung_pll_clock *pll_clk)
+{
+	struct samsung_clk_pll *pll;
+	struct clk *clk;
+	const char *drv_name;
+	int ret;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->con_reg = base + pll_clk->con_offset;
+	pll->type = pll_clk->type;
+	clk = &pll->clk;
+	clk->flags = pll_clk->flags;
+
+	switch (pll_clk->type) {
+	case pll_0822x:
+		drv_name = UBOOT_DM_CLK_SAMSUNG_PLL0822X;
+		break;
+	case pll_0831x:
+		drv_name = UBOOT_DM_CLK_SAMSUNG_PLL0831X;
+		break;
+	default:
+		kfree(pll);
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = clk_register(clk, drv_name, pll_clk->name, pll_clk->parent_name);
+	if (ret) {
+		kfree(pll);
+		return ERR_PTR(ret);
+	}
+
+	return clk;
+}
+
+void samsung_clk_register_pll(void __iomem *base,
+			      const struct samsung_pll_clock *clk_list,
+			      unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_pll_clock *pll_clk;
+
+		pll_clk = &clk_list[cnt];
+		clk = _samsung_clk_register_pll(base, pll_clk);
+		clk_dm(pll_clk->id, clk);
+	}
+}
+
+U_BOOT_DRIVER(samsung_pll0822x_clk) = {
+	.name	= UBOOT_DM_CLK_SAMSUNG_PLL0822X,
+	.id	= UCLASS_CLK,
+	.ops	= &samsung_pll0822x_clk_min_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRIVER(samsung_pll0831x_clk) = {
+	.name	= UBOOT_DM_CLK_SAMSUNG_PLL0831X,
+	.id	= UCLASS_CLK,
+	.ops	= &samsung_pll0831x_clk_min_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
new file mode 100644
index 000000000000..3b477369aeb8
--- /dev/null
+++ b/drivers/clk/exynos/clk-pll.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Samsung Electronics
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Authors:
+ *   Thomas Abraham <thomas.ab@exynos.com>
+ *   Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Common Clock Framework support for all PLL's in Samsung platforms.
+ */
+
+#ifndef __EXYNOS_CLK_PLL_H
+#define __EXYNOS_CLK_PLL_H
+
+#include <linux/clk-provider.h>
+
+enum samsung_pll_type {
+	pll_0822x,
+	pll_0831x,
+};
+
+#endif /* __EXYNOS_CLK_PLL_H */
diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
new file mode 100644
index 000000000000..430767f072d8
--- /dev/null
+++ b/drivers/clk/exynos/clk.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * This file includes utility functions to register clocks to common
+ * clock framework for Samsung platforms.
+ */
+
+#include <dm.h>
+#include "clk.h"
+
+void samsung_clk_register_mux(void __iomem *base,
+			      const struct samsung_mux_clock *clk_list,
+			      unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_mux_clock *m;
+
+		m = &clk_list[cnt];
+		clk = clk_register_mux(NULL, m->name, m->parent_names,
+			m->num_parents, m->flags, base + m->offset, m->shift,
+			m->width, m->mux_flags);
+		clk_dm(m->id, clk);
+	}
+}
+
+void samsung_clk_register_div(void __iomem *base,
+			      const struct samsung_div_clock *clk_list,
+			      unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_div_clock *d;
+
+		d = &clk_list[cnt];
+		clk = clk_register_divider(NULL, d->name, d->parent_name,
+			d->flags, base + d->offset, d->shift,
+			d->width, d->div_flags);
+		clk_dm(d->id, clk);
+	}
+}
+
+void samsung_clk_register_gate(void __iomem *base,
+			       const struct samsung_gate_clock *clk_list,
+			       unsigned int nr_clk)
+{
+	unsigned int cnt;
+
+	for (cnt = 0; cnt < nr_clk; cnt++) {
+		struct clk *clk;
+		const struct samsung_gate_clock *g;
+
+		g = &clk_list[cnt];
+		clk = clk_register_gate(NULL, g->name, g->parent_name,
+			g->flags, base + g->offset, g->bit_idx,
+			g->gate_flags, NULL);
+		clk_dm(g->id, clk);
+	}
+}
+
+typedef void (*samsung_clk_register_fn)(void __iomem *base,
+					const void *clk_list,
+					unsigned int nr_clk);
+
+static const samsung_clk_register_fn samsung_clk_register_fns[] = {
+	[S_CLK_MUX]	= (samsung_clk_register_fn)samsung_clk_register_mux,
+	[S_CLK_DIV]	= (samsung_clk_register_fn)samsung_clk_register_div,
+	[S_CLK_GATE]	= (samsung_clk_register_fn)samsung_clk_register_gate,
+	[S_CLK_PLL]	= (samsung_clk_register_fn)samsung_clk_register_pll,
+};
+
+/**
+ * samsung_cmu_register_clocks() - Register provided clock groups
+ * @base: Base address of CMU registers
+ * @clk_groups: list of clock groups
+ * @nr_groups: count of clock groups in @clk_groups
+ *
+ * Having the array of clock groups @clk_groups makes it possible to keep a
+ * correct clocks registration order.
+ */
+void samsung_cmu_register_clocks(void __iomem *base,
+				 const struct samsung_clk_group *clk_groups,
+				 unsigned int nr_groups)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_groups; i++) {
+		const struct samsung_clk_group *g = &clk_groups[i];
+
+		samsung_clk_register_fns[g->type](base, g->clk_list, g->nr_clk);
+	}
+}
+
+/**
+ * samsung_cmu_register_one - Register all CMU clocks
+ * @dev: CMU device
+ * @clk_groups: list of CMU clock groups
+ * @nr_groups: count of CMU clock groups in @clk_groups
+ *
+ * Return: 0 on success or negative value on error.
+ */
+int samsung_cmu_register_one(struct udevice *dev,
+			     const struct samsung_clk_group *clk_groups,
+			     unsigned int nr_groups)
+{
+	void __iomem *base;
+
+	base = dev_read_addr_ptr(dev);
+	if (!base)
+		return -EINVAL;
+
+	samsung_cmu_register_clocks(base, clk_groups, nr_groups);
+
+	return 0;
+}
diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
new file mode 100644
index 000000000000..91a51b877a63
--- /dev/null
+++ b/drivers/clk/exynos/clk.h
@@ -0,0 +1,228 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Common Clock Framework support for all Samsung platforms.
+ */
+
+#ifndef __EXYNOS_CLK_H
+#define __EXYNOS_CLK_H
+
+#include <errno.h>
+#include <linux/clk-provider.h>
+#include "clk-pll.h"
+
+/**
+ * struct samsung_mux_clock - information about mux clock
+ * @id: platform specific id of the clock
+ * @name: name of this mux clock
+ * @parent_names: array of pointer to parent clock names
+ * @num_parents: number of parents listed in @parent_names
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the mux
+ * @shift: starting bit location of the mux control bit-field in @reg
+ * @width: width of the mux control bit-field in @reg
+ * @mux_flags: flags for mux-type clock
+ */
+struct samsung_mux_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		* const *parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			mux_flags;
+};
+
+#define PNAME(x) static const char * const x[]
+
+#define __MUX(_id, cname, pnames, o, s, w, f, mf)			\
+	{								\
+		.id		= _id,					\
+		.name		= cname,				\
+		.parent_names	= pnames,				\
+		.num_parents	= ARRAY_SIZE(pnames),			\
+		.flags		= (f) | CLK_SET_RATE_NO_REPARENT,	\
+		.offset		= o,					\
+		.shift		= s,					\
+		.width		= w,					\
+		.mux_flags	= mf,					\
+	}
+
+#define MUX(_id, cname, pnames, o, s, w)				\
+	__MUX(_id, cname, pnames, o, s, w, 0, 0)
+
+#define MUX_F(_id, cname, pnames, o, s, w, f, mf)			\
+	__MUX(_id, cname, pnames, o, s, w, f, mf)
+
+/**
+ * struct samsung_div_clock - information about div clock
+ * @id: platform specific id of the clock
+ * @name: name of this div clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the div
+ * @shift: starting bit location of the div control bit-field in @reg
+ * @width: width of the bitfield
+ * @div_flags: flags for div-type clock
+ */
+struct samsung_div_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+};
+
+#define __DIV(_id, cname, pname, o, s, w, f, df)	\
+	{						\
+		.id		= _id,			\
+		.name		= cname,		\
+		.parent_name	= pname,		\
+		.flags		= f,			\
+		.offset		= o,			\
+		.shift		= s,			\
+		.width		= w,			\
+		.div_flags	= df,			\
+	}
+
+#define DIV(_id, cname, pname, o, s, w)			\
+	__DIV(_id, cname, pname, o, s, w, 0, 0)
+
+#define DIV_F(_id, cname, pname, o, s, w, f, df)	\
+	__DIV(_id, cname, pname, o, s, w, f, df)
+
+/**
+ * struct samsung_gate_clock - information about gate clock
+ * @id: platform specific id of the clock
+ * @name: name of this gate clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @offset: offset of the register for configuring the gate
+ * @bit_idx: bit index of the gate control bit-field in @reg
+ * @gate_flags: flags for gate-type clock
+ */
+struct samsung_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			bit_idx;
+	u8			gate_flags;
+};
+
+#define __GATE(_id, cname, pname, o, b, f, gf)			\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.offset		= o,				\
+		.bit_idx	= b,				\
+		.gate_flags	= gf,				\
+	}
+
+#define GATE(_id, cname, pname, o, b, f, gf)			\
+	__GATE(_id, cname, pname, o, b, f, gf)
+
+/**
+ * struct samsung_pll_clock - information about pll clock
+ * @id: platform specific id of the clock
+ * @name: name of this pll clock
+ * @parent_name: name of the parent clock
+ * @flags: optional flags for basic clock
+ * @con_offset: offset of the register for configuring the PLL
+ * @type: type of PLL to be registered
+ */
+struct samsung_pll_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	int			con_offset;
+	enum samsung_pll_type	type;
+};
+
+#define PLL(_typ, _id, _name, _pname, _con)		\
+	{						\
+		.id		= _id,			\
+		.name		= _name,		\
+		.parent_name	= _pname,		\
+		.flags		= CLK_GET_RATE_NOCACHE,	\
+		.con_offset	= _con,			\
+		.type		= _typ,			\
+	}
+
+enum samsung_clock_type {
+	S_CLK_MUX,
+	S_CLK_DIV,
+	S_CLK_GATE,
+	S_CLK_PLL,
+};
+
+/**
+ * struct samsung_clock_group - contains a list of clocks of one type
+ * @type: type of clocks this structure contains
+ * @clk_list: list of clocks
+ * @nr_clk: count of clocks in @clk_list
+ */
+struct samsung_clk_group {
+	enum samsung_clock_type type;
+	const void *clk_list;
+	unsigned int nr_clk;
+};
+
+void samsung_clk_register_mux(void __iomem *base,
+			      const struct samsung_mux_clock *clk_list,
+			      unsigned int nr_clk);
+void samsung_clk_register_div(void __iomem *base,
+			      const struct samsung_div_clock *clk_list,
+			      unsigned int nr_clk);
+void samsung_clk_register_gate(void __iomem *base,
+			       const struct samsung_gate_clock *clk_list,
+			       unsigned int nr_clk);
+void samsung_clk_register_pll(void __iomem *base,
+			      const struct samsung_pll_clock *clk_list,
+			      unsigned int nr_clk);
+
+void samsung_cmu_register_clocks(void __iomem *base,
+				 const struct samsung_clk_group *clk_groups,
+				 unsigned int nr_groups);
+int samsung_cmu_register_one(struct udevice *dev,
+			     const struct samsung_clk_group *clk_groups,
+			     unsigned int nr_groups);
+
+/**
+ * samsung_register_cmu - Register CMU clocks ensuring parent CMU is present
+ * @dev: CMU device
+ * @clk_groups: list of CMU clock groups
+ * @parent_drv: name of parent CMU driver
+ *
+ * Register provided CMU clocks, but make sure CMU_TOP driver is instantiated
+ * first.
+ *
+ * Return: 0 on success or negative value on error.
+ */
+#define samsung_register_cmu(dev, clk_groups, parent_drv)		\
+({									\
+	struct udevice *__parent;					\
+	int __ret;							\
+									\
+	__ret = uclass_get_device_by_driver(UCLASS_CLK,			\
+		DM_DRIVER_GET(parent_drv), &__parent);			\
+	if (__ret || !__parent)						\
+		__ret = -ENOENT;					\
+	else								\
+		__ret = samsung_cmu_register_one(dev, clk_groups,	\
+			ARRAY_SIZE(clk_groups));			\
+	__ret;								\
+})
+
+#endif /* __EXYNOS_CLK_H */
-- 
2.39.2

