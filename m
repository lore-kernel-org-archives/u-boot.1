Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B6AC54E49
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 02:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FE387B77;
	Fri,  8 Mar 2024 03:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qoreWs1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6281487E80; Fri,  8 Mar 2024 03:19:33 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4651887E1B
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c1a1e1e539so1176481b6e.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 18:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709864342; x=1710469142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7a2XTtx7VyDtwXXDux1ON844wny1hz4sCYCvSfoZKc=;
 b=qoreWs1qFy7AlH3e7qRSsscT+oHhek7mWTBUdoxklT025rK3EKkQKoFLMOFMpcDtGW
 qPu/oddxH+rJ2427mvEITD14FcVzSE2dCSuwER0xDtt7wIO2g2X6FOujDD6VaQJnw65P
 08rScX7Soh+WlUmQBKfTyupYv8l7HhT9zfdu7hyoTjixn7ynnjYakQV6ZJqKpqJy0EqH
 n0jpqpcGT1ewE06xbtTaq3+1G/Kq2uR5n1fkgb7Cdwy4gNjy9lG1xAytxIaiDDOKNVxD
 SAUljD3f0bdpeeK7VQXrtH6LieoMiDqa1V68YzpNjLUYHZNrq2KXTWcQk4jAVMua1YW5
 kCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709864342; x=1710469142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7a2XTtx7VyDtwXXDux1ON844wny1hz4sCYCvSfoZKc=;
 b=m2ymAqSr7kqcZ4LP43/naUX91AyBK0X2xxS6KSlKk0B0KOEoWQFrv8eWrutoFYyHIy
 l413bjdr6wDSZNzgKGMteib2oXxVFa6wcKCtuIEK+JGZ9gjbJrlvy7SICzDoj+5UjhhZ
 bXVdt2d2ujCMyaaBnmDFfJyAuNYJE4w/gLKbkKNPzr3dZKdx9+DC8MGF8YoVZcV1+oI9
 TLxmJCvXNW9kNCUg3EToTT45nwRYNDckseqWrqpmYrZyTJnftKu3qkppWh6y5mIKrPCe
 Z5u7NPyn2vhDdFunhzDrFDH9oxvYswFr5JAzXZvah8IqHYfHaAKQj0xQhLQxRJYweXdh
 2Haw==
X-Gm-Message-State: AOJu0Yy6Rw8r+toFWtSzsvKHIeuA3r1yNIWY44X27nIpXqN+Q9r8g1fF
 MQPMNjeTbFPLuowQRbpm9vzggzGY7m5ydOMVJdb1dUXQdQ0jXeplEdPoKYYNdKY=
X-Google-Smtp-Source: AGHT+IFaWBBTJWurm3kEuf6dhnGbLl/CTVRCCGExOhDpsBSonnfUsEiZRSrf4/4lBj9TKLOKt0v+Ww==
X-Received: by 2002:a05:6870:c194:b0:21e:daef:1372 with SMTP id
 h20-20020a056870c19400b0021edaef1372mr1908736oad.28.1709864341848; 
 Thu, 07 Mar 2024 18:19:01 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 z18-20020a0568301db200b006e4409df640sm1672265oti.37.2024.03.07.18.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 18:19:01 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH 3/4] clk: exynos: Fix incorrect clock lookup for non-top CMUs
Date: Thu,  7 Mar 2024 20:18:57 -0600
Message-Id: <20240308021858.28249-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308021858.28249-1-semen.protsenko@linaro.org>
References: <20240308021858.28249-1-semen.protsenko@linaro.org>
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

Samsung clock drivers usually define the clock indices that are unique
per one CMU, but are not unique across all CMUs. That is, clock indices
start from 1 for each CMU, as provided in CMU bindings header. The way
the clock lookup via clk_get_by_index() works at the moment is by using
clk_of_xlate_default(), which returns globally non-unique clock ids for
for clocks registered with Samsung CCF API, which leads to incorrect
clocks being obtained. One way to fix that would be to make all clock
ids defined in the bindings header unique, but it'd make it incompatible
with Linux kernel bindings header. A better way to solve this issue is
to calculate the global clock id and use it when registering a clock
with clk_dm() and when obtaining it, in a custom .of_xlate function.

This patch adds an API for such mapping calculation, introducing the
necessary modifications to CMU registering functions in Samsung CCF.
Exynos850 clock driver (the only driver that uses Samsung CCF at the
moment) is modified accordingly, as it uses the changed API. So the
clock lookup with clk-exynos850.c driver is also fixed here.

The global clock id is calculated from CMU id and local clock id in
SAMSUNG_TO_CLK_ID() macro like this:

    clk_id_global = cmu_id * 256 + clk_id_local

leaving a range of up to 256 clocks for each CMU. Then this mapping
macro is used in clk_dm() to register clocks using their global ids, and
in .of_xlate() to lookup the clock by its local id correctly. Because
.of_xlate() operation has a separate function for each CMU, it "knows"
the correct way of finding the correct clk_id_global by provided
clk_id_local.

Fixes: ff3e8b8c6c22 ("clk: exynos: Add Samsung clock framework")
Fixes: a36cc5e3ef4d ("clk: exynos: Add Exynos850 clock driver")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/exynos/clk-exynos850.c | 18 +++++++---
 drivers/clk/exynos/clk-pll.c       |  6 ++--
 drivers/clk/exynos/clk-pll.h       |  2 +-
 drivers/clk/exynos/clk.c           | 43 ++++++++++++++----------
 drivers/clk/exynos/clk.h           | 54 +++++++++++++++++++++++++++---
 5 files changed, 95 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/exynos/clk-exynos850.c b/drivers/clk/exynos/clk-exynos850.c
index de4170cdc2f3..f11c1ff29bdd 100644
--- a/drivers/clk/exynos/clk-exynos850.c
+++ b/drivers/clk/exynos/clk-exynos850.c
@@ -10,6 +10,11 @@
 #include <dt-bindings/clock/exynos850.h>
 #include "clk.h"
 
+enum exynos850_cmu_id {
+	CMU_TOP,
+	CMU_PERI,
+};
+
 /* ---- CMU_TOP ------------------------------------------------------------- */
 
 /* Register Offset definitions for CMU_TOP (0x120e0000) */
@@ -124,7 +129,7 @@ static const struct samsung_clk_group top_cmu_clks[] = {
 
 static int exynos850_cmu_top_probe(struct udevice *dev)
 {
-	return samsung_cmu_register_one(dev, top_cmu_clks,
+	return samsung_cmu_register_one(dev, CMU_TOP, top_cmu_clks,
 					ARRAY_SIZE(top_cmu_clks));
 }
 
@@ -133,11 +138,13 @@ static const struct udevice_id exynos850_cmu_top_ids[] = {
 	{ }
 };
 
+SAMSUNG_CLK_OPS(exynos850_cmu_top, CMU_TOP);
+
 U_BOOT_DRIVER(exynos850_cmu_top) = {
 	.name		= "exynos850-cmu-top",
 	.id		= UCLASS_CLK,
 	.of_match	= exynos850_cmu_top_ids,
-	.ops		= &ccf_clk_ops,
+	.ops		= &exynos850_cmu_top_clk_ops,
 	.probe		= exynos850_cmu_top_probe,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
@@ -175,7 +182,8 @@ static const struct samsung_clk_group peri_cmu_clks[] = {
 
 static int exynos850_cmu_peri_probe(struct udevice *dev)
 {
-	return samsung_register_cmu(dev, peri_cmu_clks, exynos850_cmu_top);
+	return samsung_register_cmu(dev, CMU_PERI, peri_cmu_clks,
+				    exynos850_cmu_top);
 }
 
 static const struct udevice_id exynos850_cmu_peri_ids[] = {
@@ -183,11 +191,13 @@ static const struct udevice_id exynos850_cmu_peri_ids[] = {
 	{ }
 };
 
+SAMSUNG_CLK_OPS(exynos850_cmu_peri, CMU_PERI);
+
 U_BOOT_DRIVER(exynos850_cmu_peri) = {
 	.name		= "exynos850-cmu-peri",
 	.id		= UCLASS_CLK,
 	.of_match	= exynos850_cmu_peri_ids,
-	.ops		= &ccf_clk_ops,
+	.ops		= &exynos850_cmu_peri_clk_ops,
 	.probe		= exynos850_cmu_peri_probe,
 	.flags		= DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/exynos/clk-pll.c b/drivers/clk/exynos/clk-pll.c
index 4aacbc26b25d..542d577eaa6f 100644
--- a/drivers/clk/exynos/clk-pll.c
+++ b/drivers/clk/exynos/clk-pll.c
@@ -136,7 +136,7 @@ static struct clk *_samsung_clk_register_pll(void __iomem *base,
 	return clk;
 }
 
-void samsung_clk_register_pll(void __iomem *base,
+void samsung_clk_register_pll(void __iomem *base, unsigned int cmu_id,
 			      const struct samsung_pll_clock *clk_list,
 			      unsigned int nr_clk)
 {
@@ -145,10 +145,12 @@ void samsung_clk_register_pll(void __iomem *base,
 	for (cnt = 0; cnt < nr_clk; cnt++) {
 		struct clk *clk;
 		const struct samsung_pll_clock *pll_clk;
+		unsigned long clk_id;
 
 		pll_clk = &clk_list[cnt];
 		clk = _samsung_clk_register_pll(base, pll_clk);
-		clk_dm(pll_clk->id, clk);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, pll_clk->id);
+		clk_dm(clk_id, clk);
 	}
 }
 
diff --git a/drivers/clk/exynos/clk-pll.h b/drivers/clk/exynos/clk-pll.h
index 00c750687072..bdc94e7624d2 100644
--- a/drivers/clk/exynos/clk-pll.h
+++ b/drivers/clk/exynos/clk-pll.h
@@ -22,7 +22,7 @@ enum samsung_pll_type {
 	pll_0831x,
 };
 
-void samsung_clk_register_pll(void __iomem *base,
+void samsung_clk_register_pll(void __iomem *base, unsigned int cmu_id,
 			      const struct samsung_pll_clock *clk_list,
 			      unsigned int nr_clk);
 
diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index 14ccd2cba374..943e8bd01892 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -10,61 +10,67 @@
 #include <dm.h>
 #include "clk.h"
 
-static void samsung_clk_register_mux(void __iomem *base,
-			      const struct samsung_mux_clock *clk_list,
-			      unsigned int nr_clk)
+static void samsung_clk_register_mux(void __iomem *base, unsigned int cmu_id,
+				     const struct samsung_mux_clock *clk_list,
+				     unsigned int nr_clk)
 {
 	unsigned int cnt;
 
 	for (cnt = 0; cnt < nr_clk; cnt++) {
 		struct clk *clk;
 		const struct samsung_mux_clock *m;
+		unsigned long clk_id;
 
 		m = &clk_list[cnt];
 		clk = clk_register_mux(NULL, m->name, m->parent_names,
 			m->num_parents, m->flags, base + m->offset, m->shift,
 			m->width, m->mux_flags);
-		clk_dm(m->id, clk);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, m->id);
+		clk_dm(clk_id, clk);
 	}
 }
 
-static void samsung_clk_register_div(void __iomem *base,
-			      const struct samsung_div_clock *clk_list,
-			      unsigned int nr_clk)
+static void samsung_clk_register_div(void __iomem *base, unsigned int cmu_id,
+				     const struct samsung_div_clock *clk_list,
+				     unsigned int nr_clk)
 {
 	unsigned int cnt;
 
 	for (cnt = 0; cnt < nr_clk; cnt++) {
 		struct clk *clk;
 		const struct samsung_div_clock *d;
+		unsigned long clk_id;
 
 		d = &clk_list[cnt];
 		clk = clk_register_divider(NULL, d->name, d->parent_name,
 			d->flags, base + d->offset, d->shift,
 			d->width, d->div_flags);
-		clk_dm(d->id, clk);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, d->id);
+		clk_dm(clk_id, clk);
 	}
 }
 
-static void samsung_clk_register_gate(void __iomem *base,
-			       const struct samsung_gate_clock *clk_list,
-			       unsigned int nr_clk)
+static void samsung_clk_register_gate(void __iomem *base, unsigned int cmu_id,
+				      const struct samsung_gate_clock *clk_list,
+				      unsigned int nr_clk)
 {
 	unsigned int cnt;
 
 	for (cnt = 0; cnt < nr_clk; cnt++) {
 		struct clk *clk;
 		const struct samsung_gate_clock *g;
+		unsigned long clk_id;
 
 		g = &clk_list[cnt];
 		clk = clk_register_gate(NULL, g->name, g->parent_name,
 			g->flags, base + g->offset, g->bit_idx,
 			g->gate_flags, NULL);
-		clk_dm(g->id, clk);
+		clk_id = SAMSUNG_TO_CLK_ID(cmu_id, g->id);
+		clk_dm(clk_id, clk);
 	}
 }
 
-typedef void (*samsung_clk_register_fn)(void __iomem *base,
+typedef void (*samsung_clk_register_fn)(void __iomem *base, unsigned int cmu_id,
 					const void *clk_list,
 					unsigned int nr_clk);
 
@@ -78,13 +84,14 @@ static const samsung_clk_register_fn samsung_clk_register_fns[] = {
 /**
  * samsung_cmu_register_clocks() - Register provided clock groups
  * @base: Base address of CMU registers
+ * @cmu_id: CMU index number
  * @clk_groups: list of clock groups
  * @nr_groups: count of clock groups in @clk_groups
  *
  * Having the array of clock groups @clk_groups makes it possible to keep a
  * correct clocks registration order.
  */
-static void samsung_cmu_register_clocks(void __iomem *base,
+static void samsung_cmu_register_clocks(void __iomem *base, unsigned int cmu_id,
 				const struct samsung_clk_group *clk_groups,
 				unsigned int nr_groups)
 {
@@ -93,19 +100,21 @@ static void samsung_cmu_register_clocks(void __iomem *base,
 	for (i = 0; i < nr_groups; i++) {
 		const struct samsung_clk_group *g = &clk_groups[i];
 
-		samsung_clk_register_fns[g->type](base, g->clk_list, g->nr_clk);
+		samsung_clk_register_fns[g->type](base, cmu_id,
+						  g->clk_list, g->nr_clk);
 	}
 }
 
 /**
  * samsung_cmu_register_one - Register all CMU clocks
  * @dev: CMU device
+ * @cmu_id: CMU index number
  * @clk_groups: list of CMU clock groups
  * @nr_groups: count of CMU clock groups in @clk_groups
  *
  * Return: 0 on success or negative value on error.
  */
-int samsung_cmu_register_one(struct udevice *dev,
+int samsung_cmu_register_one(struct udevice *dev, unsigned int cmu_id,
 			     const struct samsung_clk_group *clk_groups,
 			     unsigned int nr_groups)
 {
@@ -115,7 +124,7 @@ int samsung_cmu_register_one(struct udevice *dev,
 	if (!base)
 		return -EINVAL;
 
-	samsung_cmu_register_clocks(base, clk_groups, nr_groups);
+	samsung_cmu_register_clocks(base, cmu_id, clk_groups, nr_groups);
 
 	return 0;
 }
diff --git a/drivers/clk/exynos/clk.h b/drivers/clk/exynos/clk.h
index 14e06b2030fb..ed0a395f0f63 100644
--- a/drivers/clk/exynos/clk.h
+++ b/drivers/clk/exynos/clk.h
@@ -13,6 +13,51 @@
 #include <linux/clk-provider.h>
 #include "clk-pll.h"
 
+#define _SAMSUNG_CLK_OPS(_name, _cmu)					\
+static int _name##_of_xlate(struct clk *clk,				\
+			    struct ofnode_phandle_args *args)		\
+{									\
+	if (args->args_count > 1) {					\
+		debug("Invalid args_count: %d\n", args->args_count);	\
+		return -EINVAL;						\
+	}								\
+									\
+	if (args->args_count)						\
+		clk->id = SAMSUNG_TO_CLK_ID(_cmu, args->args[0]);	\
+	else								\
+		clk->id = 0;						\
+									\
+	return 0;							\
+}									\
+									\
+static const struct clk_ops _name##_clk_ops = {				\
+	.set_rate = ccf_clk_set_rate,					\
+	.get_rate = ccf_clk_get_rate,					\
+	.set_parent = ccf_clk_set_parent,				\
+	.enable = ccf_clk_enable,					\
+	.disable = ccf_clk_disable,					\
+	.of_xlate = _name##_of_xlate,					\
+}
+
+/**
+ * SAMSUNG_CLK_OPS - Define clock operations structure for specified CMU.
+ * @name: name of generated structure
+ * @cmu: CMU index
+ *
+ * Like ccf_clk_ops, but with custom .of_xlate callback.
+ */
+#define SAMSUNG_CLK_OPS(name, cmu) _SAMSUNG_CLK_OPS(name, cmu)
+
+/**
+ * SAMSUNG_TO_CLK_ID - Calculate a global clock index.
+ * @_cmu: CMU index
+ * @_id: local clock index (unique across @_cmu)
+ *
+ * Return: A global clock index unique across all CMUs.
+ * Keeps a range of 256 available clocks for every CMU.
+ */
+#define SAMSUNG_TO_CLK_ID(_cmu, _id)	(((_cmu) << 8) | ((_id) & 0xff))
+
 /**
  * struct samsung_mux_clock - information about mux clock
  * @id: platform specific id of the clock
@@ -179,13 +224,14 @@ struct samsung_clk_group {
 	unsigned int nr_clk;
 };
 
-int samsung_cmu_register_one(struct udevice *dev,
+int samsung_cmu_register_one(struct udevice *dev, unsigned int cmu_id,
 			     const struct samsung_clk_group *clk_groups,
 			     unsigned int nr_groups);
 
 /**
  * samsung_register_cmu - Register CMU clocks ensuring parent CMU is present
  * @dev: CMU device
+ * @cmu_id: CMU index number
  * @clk_groups: list of CMU clock groups
  * @parent_drv: name of parent CMU driver
  *
@@ -194,7 +240,7 @@ int samsung_cmu_register_one(struct udevice *dev,
  *
  * Return: 0 on success or negative value on error.
  */
-#define samsung_register_cmu(dev, clk_groups, parent_drv)		\
+#define samsung_register_cmu(dev, cmu_id, clk_groups, parent_drv)	\
 ({									\
 	struct udevice *__parent;					\
 	int __ret;							\
@@ -204,8 +250,8 @@ int samsung_cmu_register_one(struct udevice *dev,
 	if (__ret || !__parent)						\
 		__ret = -ENOENT;					\
 	else								\
-		__ret = samsung_cmu_register_one(dev, clk_groups,	\
-			ARRAY_SIZE(clk_groups));			\
+		__ret = samsung_cmu_register_one(dev, cmu_id,		\
+			clk_groups, ARRAY_SIZE(clk_groups));		\
 	__ret;								\
 })
 
-- 
2.39.2

