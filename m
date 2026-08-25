Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9557C5DF81
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 04:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DA5F40633;
	Tue, 25 Aug 2026 04:25:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AB-xnFAhJDgb; Tue, 25 Aug 2026 04:25:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787631941;
	bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hm7C+1lVBe0Ma91vshl3jVuezOtNItWl4saDzilUcd3pYzV2Tw0H/f4g+aUH4ZwCS
	 6RQWFkrJnPvxu9FuwY4HsULCEYP8qrVUdwP5dDdU4TthOirJOVmDTmmcRrHd3H0m39
	 hMGjOXO7Hy2aefzrizz7liaz62fxXhgVOjzUVf6DZwpbwXQh/uJTnW/fKo9wQWIydr
	 F7eT8tZNYBxBGZbZl4fjEUSb6Otc2OKeBDtDVRf7G4/KSR8eJCSTaxzbOytrSNl2Z5
	 k0zv+pmeWkiCWMobfoVL9hVHNehESM3bmrlg5RTEVyrzUEQLXbOOyAU1b2zbNT4TYW
	 4Na0DosxpIE4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 788D840619;
	Tue, 25 Aug 2026 04:25:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E980A279
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D717180DE3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z6ffQ6M8t8sN for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 04:25:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RVJetCRZ
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F17980DD4
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 04:25:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E54F60A73;
 Tue, 25 Aug 2026 04:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDA81F00A3A;
 Tue, 25 Aug 2026 04:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787631932;
 bh=Gz25oVKMZ8NjwsKL0KwR4/IhLbSzV16dZkwCidVdjw0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RVJetCRZsuC4DBFI+r9GaioLHuqEavVbwunEnZxL+NS48UJGY3/TthZTcRij6aJvc
 9Nz/YhUIHsvaaRKQXt2zKrGF+1xqsUO5LASVPoWr91mMeou418n2e6xden8Y3ZFZll
 OYXOggOnAoIHnLTXh00bvHENbxCTyN9PR0+dw7g9I0XnXRb5wfG9fxGaF0ad51cDpZ
 6tpCsdEGKbcyJzTyq+iyEEZLAIjVbeMLiICch0YBiG/prDbNlqoB8RiU5iiKy96krP
 SuVZrJU1XRvqawo++le9Uon52r052dlhsxDDw3n3mFoQquEvudRhjHJDZxxaU6hRgE
 9k4oZ2Ttp8X7A==
From: Yixun Lan <dlan@kernel.org>
Date: Tue, 25 Aug 2026 04:24:17 +0000
Subject: [PATCH 7/8] reset: spacemit: Extract common K1 reset code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-01-k3-clock-reset-support-v1-7-c430253e759c@kernel.org>
References: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
In-Reply-To: <20260825-01-k3-clock-reset-support-v1-0-c430253e759c@kernel.org>
To: u-boot@lists.u-boot-project.org
Cc: spacemit@lists.linux.dev, u-boot-spacemit@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Guodong Xu <guodong.xu@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13174; i=dlan@kernel.org;
 h=from:subject:message-id; bh=HRgS40R875GNJ9FSro4CkQuBnRXJL+2KJ8meNXOdHek=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqjRkZLUo/JZywMcErhI2N2doCoasSrr6ATHFt7
 Giew1Xzv32JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCao0ZGRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+29aQ/+Oph33l2RpQdcneFWNYxz4stYGFlvlswk8pmDJAjxXwTtqCrUTSNr5
 1O99pw7QAUgxRspzKw7QO66UYhL2Uqt4p9MgIMSWhAISwGFoKccfBOxvKV83Kvrz8lDyfK6PV2B
 XYpwI0QtQgLlo6djugblpZGelsuOuxG60DTBlqOk0ljgQfdypMnEckpGeKHZJxd9RLjbREFYFZ4
 uFbNfb4Mvt5JGxnJuUU2c4aotNeMN72TkANwW4R8o4q9mzDxDtCXPYAV90LHj6NTEyq9C9YgZry
 Y5LARYiW3HSAyb8n+Zfl9FpqXU/joRUxgzoSMxWdh3E2A6LK108fc3Tc1+QPUCBLh+7qWmqWka/
 HURlu7IJOo3iFHrWmR5A8g/IgMqNxUW9VfCtsEBRiXAMUql0n/7txslva+k0LDdq8FMCxAv8Db6
 PXxQVkttQwdESQ/WU+q7Rz5tctEE2ESUxwO0lfkSGGtcZKsN43PmpWyASdJM7aMQT7tJlzlYKhh
 1PZfuvSpE/7f7iwen9DF9j41FY0Jd4MCqbyqyTdZP2RyXIPY3URsKQ455ysNBWWW42aR29IY63K
 M9qv/avG2iPTJWva7b4q7aQDjibp2QB67sbtiaIcM3IUg6rXWqZ8mDcoVb4QuO5UCImirkCLWhT
 A0uCjufjX1rI9rIqq5IXLHxJslqSsI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  aba86f7bff0b ("reset: spacemit: Extract common K1 reset code")

Extract the common reset controller code from the K1 driver into
separate reset-spacemit-common.{c,h} files to prepare for additional
SpacemiT SoCs that share the same reset controller architecture.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/clk/spacemit/Kconfig                   |   1 +
 drivers/reset/Kconfig                          |   1 +
 drivers/reset/Makefile                         |   2 +-
 drivers/reset/spacemit/Kconfig                 |  15 +++
 drivers/reset/spacemit/Makefile                |   3 +-
 drivers/reset/spacemit/reset-spacemit-common.c |  93 ++++++++++++++++++
 drivers/reset/spacemit/reset-spacemit-common.h |  40 ++++++++
 drivers/reset/spacemit/reset-spacemit-k1.c     | 128 ++-----------------------
 8 files changed, 163 insertions(+), 120 deletions(-)

diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
index b22f65f2547..c305f433871 100644
--- a/drivers/clk/spacemit/Kconfig
+++ b/drivers/clk/spacemit/Kconfig
@@ -16,6 +16,7 @@ if CLK_SPACEMIT
 config CLK_SPACEMIT_K1
 	bool "SpacemiT K1 clock support"
 	select CLK_CCF
+	select RESET_SPACEMIT_K1
 	help
 	  This enables support clock driver for Spacemit K1 SoC.
 	  It's based on Common Clock Framework.
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index db764ed5ace..ad61ebf344a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -280,4 +280,5 @@ config RESET_RZG2L_USBPHY_CTRL
 	  SoC.
 
 source "drivers/reset/stm32/Kconfig"
+source "drivers/reset/spacemit/Kconfig"
 endmenu
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 384f4336331..959aafe4d70 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_RESET_DRA7) += reset-dra7.o
 obj-$(CONFIG_RESET_AT91) += reset-at91.o
 obj-$(CONFIG_$(PHASE_)RESET_JH7110) += reset-jh7110.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
-obj-$(CONFIG_CLK_SPACEMIT_K1) += spacemit/
+obj-$(CONFIG_RESET_SPACEMIT_COMMON) += spacemit/
 
 obj-$(CONFIG_ARCH_STM32) += stm32/
 obj-$(CONFIG_ARCH_STM32MP) += stm32/
diff --git a/drivers/reset/spacemit/Kconfig b/drivers/reset/spacemit/Kconfig
new file mode 100644
index 00000000000..20e4cc6e4d8
--- /dev/null
+++ b/drivers/reset/spacemit/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RESET_SPACEMIT_COMMON
+	bool
+	select DM_RESET
+	help
+	  Common reset controller infrastructure for SpacemiT SoCs.
+	  Shared by the K1 and K3 reset drivers.
+
+config RESET_SPACEMIT_K1
+	bool "SpacemiT K1 reset support"
+	select RESET_SPACEMIT_COMMON
+	help
+	  Reset controller for SpacemiT K1 (MPMU/APBC/APMU/APBC2).
+	  Bound from the K1 CCU/syscon devices.
diff --git a/drivers/reset/spacemit/Makefile b/drivers/reset/spacemit/Makefile
index 16722c68954..56f9fd1ab20 100644
--- a/drivers/reset/spacemit/Makefile
+++ b/drivers/reset/spacemit/Makefile
@@ -2,4 +2,5 @@
 #
 # SpacemiT reset drivers
 
-obj-y += reset-spacemit-k1.o
+obj-$(CONFIG_RESET_SPACEMIT_COMMON)	+= reset-spacemit-common.o
+obj-$(CONFIG_RESET_SPACEMIT_K1)		+= reset-spacemit-k1.o
diff --git a/drivers/reset/spacemit/reset-spacemit-common.c b/drivers/reset/spacemit/reset-spacemit-common.c
new file mode 100644
index 00000000000..34ed0862b9c
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-common.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SpacemiT reset controller — common implementation (U-Boot)
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <malloc.h>
+#include <reset-uclass.h>
+
+#include "reset-spacemit-common.h"
+
+static int spacemit_reset_xfer(struct reset_ctl *rst, bool assert)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(rst->dev);
+	const struct spacemit_reset_data *e;
+	u32 v;
+
+	if (rst->id >= priv->table_size)
+		return -EINVAL;
+
+	e = &priv->table[rst->id];
+	if (e->assert_mask == 0 && e->deassert_mask == 0)
+		return -EINVAL;
+
+	v = readl(priv->base + e->offset);
+	v &= ~(e->assert_mask | e->deassert_mask);
+	v |= assert ? e->assert_mask : e->deassert_mask;
+	writel(v, priv->base + e->offset);
+
+	return 0;
+}
+
+static int spacemit_reset_assert(struct reset_ctl *rst)
+{
+	return spacemit_reset_xfer(rst, true);
+}
+
+static int spacemit_reset_deassert(struct reset_ctl *rst)
+{
+	return spacemit_reset_xfer(rst, false);
+}
+
+static int spacemit_reset_request(struct reset_ctl *rst)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(rst->dev);
+
+	return rst->id < priv->table_size ? 0 : -EINVAL;
+}
+
+const struct reset_ops spacemit_reset_ops = {
+	.request	= spacemit_reset_request,
+	.rst_assert	= spacemit_reset_assert,
+	.rst_deassert	= spacemit_reset_deassert,
+};
+
+int spacemit_reset_probe(struct udevice *dev)
+{
+	struct spacemit_reset_priv *priv = dev_get_priv(dev);
+
+	priv->base = (void __iomem *)dev_remap_addr(dev);
+	if (!priv->base)
+		return -ENODEV;
+
+	return 0;
+}
+
+int spacemit_reset_bind(struct udevice *parent, const char *drv_name,
+			const struct spacemit_reset_data *table,
+			size_t table_size)
+{
+	struct spacemit_reset_priv *priv;
+	struct udevice *rst_dev;
+	int ret;
+
+	ret = device_bind_driver_to_node(parent, drv_name, "reset",
+					 dev_ofnode(parent), &rst_dev);
+	if (ret)
+		return ret;
+
+	priv = malloc(sizeof(*priv));
+	if (!priv) {
+		device_unbind(rst_dev);
+		return -ENOMEM;
+	}
+	priv->table = table;
+	priv->table_size = table_size;
+	dev_set_priv(rst_dev, priv);
+
+	return 0;
+}
diff --git a/drivers/reset/spacemit/reset-spacemit-common.h b/drivers/reset/spacemit/reset-spacemit-common.h
new file mode 100644
index 00000000000..cde52b3fc1d
--- /dev/null
+++ b/drivers/reset/spacemit/reset-spacemit-common.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * SpacemiT reset controller — common definitions (U-Boot)
+ */
+
+#ifndef _RESET_SPACEMIT_COMMON_H_
+#define _RESET_SPACEMIT_COMMON_H_
+
+#include <linux/types.h>
+
+struct udevice;
+struct reset_ops;
+
+struct spacemit_reset_data {
+	u32 offset;
+	u32 assert_mask;
+	u32 deassert_mask;
+};
+
+struct spacemit_reset_priv {
+	void *base;
+	const struct spacemit_reset_data *table;
+	size_t table_size;
+};
+
+#define RESET_DATA(_offset, _assert_mask, _deassert_mask)	\
+	{							\
+		.offset		= (_offset),			\
+		.assert_mask	= (_assert_mask),		\
+		.deassert_mask	= (_deassert_mask),		\
+	}
+
+extern const struct reset_ops spacemit_reset_ops;
+
+int spacemit_reset_probe(struct udevice *dev);
+int spacemit_reset_bind(struct udevice *parent, const char *drv_name,
+			const struct spacemit_reset_data *table,
+			size_t table_size);
+
+#endif /* _RESET_SPACEMIT_COMMON_H_ */
diff --git a/drivers/reset/spacemit/reset-spacemit-k1.c b/drivers/reset/spacemit/reset-spacemit-k1.c
index 129e1cc96f1..75000ff64e0 100644
--- a/drivers/reset/spacemit/reset-spacemit-k1.c
+++ b/drivers/reset/spacemit/reset-spacemit-k1.c
@@ -7,46 +7,19 @@
  * Copyright (C) 2026 RISCstar Ltd.
  */
 
-#include <asm/io.h>
 #include <dm.h>
-#include <dm/device-internal.h>
-#include <dm/lists.h>
 #include <dt-bindings/clock/spacemit,k1-syscon.h>
 #include <linux/bitops.h>
-#include <malloc.h>
-#include <reset-uclass.h>
 #include <soc/spacemit/k1-reset.h>
 #include <soc/spacemit/k1-syscon.h>
 
-/* ===================================================================
- * Per-syscon reset signal tables.
- *
- * Indexed by the kernel-side per-syscon-local IDs from
- * <dt-bindings/clock/spacemit,k1-syscon.h>. Each entry is
- * (offset, assert_mask, deassert_mask): bits in assert_mask are set
- * when the reset line is asserted; bits in deassert_mask are set when
- * deasserted; the union (assert_mask | deassert_mask) is the set of
- * bits the controller will overwrite on each transition.
- *
- * Layout mirrors the kernel-side K1 reset driver.
- * ===================================================================
- */
-
-struct spacemit_k1_reset_data {
-	u32 offset;
-	u32 assert_mask;
-	u32 deassert_mask;
-};
+#include "reset-spacemit-common.h"
 
-#define RESET_DATA(o, a, d) {					\
-	.offset = (o), .assert_mask = (a), .deassert_mask = (d)	\
-}
-
-static const struct spacemit_k1_reset_data k1_mpmu_resets[] = {
+static const struct spacemit_reset_data k1_mpmu_resets[] = {
 	[RESET_WDT]	= RESET_DATA(MPMU_WDTPCR,		BIT(2), 0),
 };
 
-static const struct spacemit_k1_reset_data k1_apbc_resets[] = {
+static const struct spacemit_reset_data k1_apbc_resets[] = {
 	[RESET_UART0]	= RESET_DATA(APBC_UART1_CLK_RST,	BIT(2), 0),
 	[RESET_UART2]	= RESET_DATA(APBC_UART2_CLK_RST,	BIT(2), 0),
 	[RESET_UART3]	= RESET_DATA(APBC_UART3_CLK_RST,	BIT(2), 0),
@@ -100,7 +73,7 @@ static const struct spacemit_k1_reset_data k1_apbc_resets[] = {
 	[RESET_CAN0]	= RESET_DATA(APBC_CAN0_CLK_RST,		BIT(2), 0),
 };
 
-static const struct spacemit_k1_reset_data k1_apmu_resets[] = {
+static const struct spacemit_reset_data k1_apmu_resets[] = {
 	[RESET_CCIC_4X]		= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(1)),
 	[RESET_CCIC1_PHY]	= RESET_DATA(APMU_CCIC_CLK_RES_CTRL,	0, BIT(2)),
 	[RESET_SDH_AXI]		= RESET_DATA(APMU_SDH0_CLK_RES_CTRL,	0, BIT(0)),
@@ -156,7 +129,7 @@ static const struct spacemit_k1_reset_data k1_apmu_resets[] = {
 	[RESET_MC]		= RESET_DATA(APMU_PMUA_MC_CTRL,		0, BIT(0)),
 };
 
-static const struct spacemit_k1_reset_data k1_apbc2_resets[] = {
+static const struct spacemit_reset_data k1_apbc2_resets[] = {
 	[RESET_APBC2_UART1]	= RESET_DATA(APBC2_UART1_CLK_RST,	BIT(2), 0),
 	[RESET_APBC2_SSP2]	= RESET_DATA(APBC2_SSP2_CLK_RST,	BIT(2), 0),
 	[RESET_APBC2_TWSI3]	= RESET_DATA(APBC2_TWSI3_CLK_RST,	BIT(2), 0),
@@ -166,89 +139,22 @@ static const struct spacemit_k1_reset_data k1_apbc2_resets[] = {
 	[RESET_APBC2_GPIO]	= RESET_DATA(APBC2_GPIO_CLK_RST,	BIT(2), 0),
 };
 
-/* ===================================================================
- * Driver
- * ===================================================================
- */
-
-struct spacemit_k1_reset_priv {
-	void __iomem *base;
-	const struct spacemit_k1_reset_data *table;
-	size_t table_size;
-};
-
-static int spacemit_k1_reset_xfer(struct reset_ctl *rst, bool assert)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
-	const struct spacemit_k1_reset_data *e;
-	u32 v;
-
-	if (rst->id >= priv->table_size)
-		return -EINVAL;
-
-	e = &priv->table[rst->id];
-	if (e->assert_mask == 0 && e->deassert_mask == 0)
-		return -EINVAL;	/* not owned by this syscon */
-
-	v = readl(priv->base + e->offset);
-	v &= ~(e->assert_mask | e->deassert_mask);
-	v |= assert ? e->assert_mask : e->deassert_mask;
-	writel(v, priv->base + e->offset);
-
-	return 0;
-}
-
-static int spacemit_k1_reset_assert(struct reset_ctl *rst)
-{
-	return spacemit_k1_reset_xfer(rst, true);
-}
-
-static int spacemit_k1_reset_deassert(struct reset_ctl *rst)
-{
-	return spacemit_k1_reset_xfer(rst, false);
-}
-
-static int spacemit_k1_reset_request(struct reset_ctl *rst)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(rst->dev);
-
-	return rst->id < priv->table_size ? 0 : -EINVAL;
-}
-
-static const struct reset_ops spacemit_k1_reset_ops = {
-	.request	= spacemit_k1_reset_request,
-	.rst_assert	= spacemit_k1_reset_assert,
-	.rst_deassert	= spacemit_k1_reset_deassert,
-};
-
-static int spacemit_k1_reset_probe(struct udevice *dev)
-{
-	struct spacemit_k1_reset_priv *priv = dev_get_priv(dev);
 
-	priv->base = (void __iomem *)dev_remap_addr(dev);
-	if (!priv->base)
-		return -ENODEV;
-
-	return 0;
-}
 
 U_BOOT_DRIVER(spacemit_k1_reset) = {
 	.name		= "spacemit_k1_reset",
 	.id		= UCLASS_RESET,
-	.ops		= &spacemit_k1_reset_ops,
-	.probe		= spacemit_k1_reset_probe,
-	.priv_auto	= sizeof(struct spacemit_k1_reset_priv),
+	.ops		= &spacemit_reset_ops,
+	.probe		= spacemit_reset_probe,
+	.priv_auto	= sizeof(struct spacemit_reset_priv),
 	.flags		= DM_FLAG_PRE_RELOC,
 };
 
 int spacemit_k1_reset_bind(struct udevice *parent,
 			   enum spacemit_k1_reset_syscon syscon)
 {
-	struct spacemit_k1_reset_priv *priv;
-	struct udevice *rst_dev;
-	const struct spacemit_k1_reset_data *table;
+	const struct spacemit_reset_data *table;
 	size_t table_size;
-	int ret;
 
 	switch (syscon) {
 	case SPACEMIT_K1_RESET_MPMU:
@@ -271,19 +177,5 @@ int spacemit_k1_reset_bind(struct udevice *parent,
 		return -EINVAL;
 	}
 
-	ret = device_bind_driver_to_node(parent, "spacemit_k1_reset", "reset",
-					 dev_ofnode(parent), &rst_dev);
-	if (ret)
-		return ret;
-
-	priv = malloc(sizeof(*priv));
-	if (!priv) {
-		device_unbind(rst_dev);
-		return -ENOMEM;
-	}
-	priv->table = table;
-	priv->table_size = table_size;
-	dev_set_priv(rst_dev, priv);
-
-	return 0;
+	return spacemit_reset_bind(parent, "spacemit_k1_reset", table, table_size);
 }

-- 
2.55.0

