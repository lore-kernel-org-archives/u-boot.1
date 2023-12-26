Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE7FC3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 02:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB4087835;
	Tue, 26 Dec 2023 03:04:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYvfD4k1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FAE87841; Tue, 26 Dec 2023 03:04:29 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F1687687
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 03:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6dbca115636so1845381a34.2
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 18:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703556262; x=1704161062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w3W/cPTE0FZKnbduvCT4ewNQk9xXjKjMQll5u0z9LTc=;
 b=mYvfD4k1ay+zaFqK7ATRITTbnMTfTeawYEQb9sijh9zIq1dfLJL6Muqo1yoVWSoUBO
 fi4ECux5q2VfufITh8iuYQl9gp7F98ITzZqjl6mR9+emsxcRC7aBAzrUkYXyWCwn68f2
 UNhbr9r6FLf15HsoWCobptLTdV67u+zEmmx3JtATpEH1Oj0R6BrSixa4MO8sg6rgYrlX
 830OPVw4tJBYFrIuxIF+l7fkU4CusN6HH7Sie3eLhy3NZjyuhEIFN6gJPpvjb/KAc0r0
 a6dvO5P5n705u20BsrEYk+v/U3MUwpivGQrOe0vGQEcp03e3R6rR9e7xrLE+nFYACuGg
 UJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703556262; x=1704161062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w3W/cPTE0FZKnbduvCT4ewNQk9xXjKjMQll5u0z9LTc=;
 b=NMW5TbKE3ePKu5Lg6ggT+otb4H3zAWCPDOCzR+hNFIaqpHUK4/k9YY0O7w571/lt1w
 J98InelljkVUka/A5RV3bLPMMgVqpUILtSLiwcU9lt3+CMjoOMwni4lL5CpElPpT8g3S
 AoO1+iSi64bN6ibnsM4kPSIrmiUpa+za6o6zeCYpNgWWpOoN6TBnhisoAIEs9eVJbJ9Y
 eI5mtq06bAjjE2fHpOinsfa8mq11nuJUq+g6hYnx5f1dMxUX/26O3RJ6glbNna6JdAw6
 jf95FOCkzZrMqCVaKPErYnlM9dbwLWJ4dm3fLTBe8XBCmuN025uUId0mr5kLag+hD7aY
 zHMQ==
X-Gm-Message-State: AOJu0YwI4yxNPnSuJfJHumB+4lMZqzkWhasc+0OAQzxuUTNGd7F6O939
 GkvQTMLBZa1pZK4UwO7j28A=
X-Google-Smtp-Source: AGHT+IF6oXLzZZjiLZDUGDsNUWNI8FdGzH9H4GbgbKcy6j2YI95jEneW+lnobOBWkUObmfS8AmKTWQ==
X-Received: by 2002:a05:6830:110b:b0:6db:e2e1:8562 with SMTP id
 w11-20020a056830110b00b006dbe2e18562mr2032603otq.58.1703556262390; 
 Mon, 25 Dec 2023 18:04:22 -0800 (PST)
Received: from localhost.localdomain ([1.200.140.173])
 by smtp.gmail.com with ESMTPSA id
 fn2-20020a056a002fc200b006d99f930607sm5002176pfb.140.2023.12.25.18.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 18:04:22 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1] reset: npcm: Add support for Nuvoton NPCM BMC family
Date: Tue, 26 Dec 2023 10:03:45 +0800
Message-Id: <20231226020345.1052861-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Add reset controller driver for Nuvoton BMCs.
The npcm reset driver not only supports reset each module reset
but setting initial value of reset Control Registers.

And The driver support each module reset.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 drivers/reset/Kconfig      |   7 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-npcm.c | 133 +++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/reset/reset-npcm.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 73bbd30692..ccd4182682 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -114,6 +114,13 @@ config RESET_MESON
 	help
 	  Support for reset controller on Amlogic Meson SoC.
 
+config RESET_NPCM
+	bool "Reset controller driver for Nuvoton BMCs"
+	depends on DM_RESET && ARCH_NPCM
+	default y
+	help
+	  Support for reset controller on Nuvotom BMCs.
+
 config RESET_SOCFPGA
 	bool "Reset controller driver for SoCFPGA"
 	depends on DM_RESET && ARCH_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index e2239a250a..8cc947fc34 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_RESET_AST2500) += reset-ast2500.o
 obj-$(CONFIG_RESET_AST2600) += reset-ast2600.o
 obj-$(CONFIG_RESET_ROCKCHIP) += reset-rockchip.o rst-rk3588.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
+obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
 obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
new file mode 100644
index 0000000000..d8d629b28e
--- /dev/null
+++ b/drivers/reset/reset-npcm.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Nuvoton Technology Corp.
+ */
+
+#include <dm.h>
+#include <reset-uclass.h>
+#include <asm/io.h>
+#include <dm/device_compat.h>
+
+struct npcm_reset_priv {
+	void __iomem *base;
+};
+
+static int npcm_reset_request(struct reset_ctl *rst)
+{
+	return 0;
+}
+
+static int npcm_reset_free(struct reset_ctl *rst)
+{
+	return 0;
+}
+
+static int npcm_reset_assert(struct reset_ctl *rst)
+{
+	struct npcm_reset_priv *priv = dev_get_priv(rst->dev);
+	u32 val;
+
+	debug("%s: id 0x%lx, data %ld\n", __func__, rst->id, rst->data);
+	val = readl(priv->base + rst->id);
+	val |= BIT(rst->data);
+	writel(val, priv->base + rst->id);
+
+	return 0;
+}
+
+static int npcm_reset_deassert(struct reset_ctl *rst)
+{
+	struct npcm_reset_priv *priv = dev_get_priv(rst->dev);
+	u32 val;
+
+	debug("%s: id 0x%lx, data %ld\n", __func__, rst->id, rst->data);
+	val = readl(priv->base + rst->id);
+	val &= ~BIT(rst->data);
+	writel(val, priv->base + rst->id);
+
+	return 0;
+}
+
+static int npcm_reset_xlate(struct reset_ctl *rst,
+			    struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 2) {
+		dev_err(rst->dev, "Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	/* Use id field as register offset and data field as reset bit positiion */
+	rst->id = args->args[0];
+	rst->data = args->args[1];
+
+	return 0;
+}
+
+static int npcm_reset_bind(struct udevice *dev)
+{
+	struct npcm_reset_priv *priv = dev_get_priv(dev);
+	u32 *rcr_values;
+	int num_fields;
+	u32 reg, val;
+	int ret, i;
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	/*
+	 * Set RCR initial value
+	 * The rcr-initial-values cell is <reg_offset val>
+	 */
+	num_fields = dev_read_size(dev, "rcr-initial-values");
+	if (num_fields < 2)
+		return 0;
+
+	num_fields /= sizeof(u32);
+	if (num_fields % 2)
+		return -EINVAL;
+
+	num_fields = num_fields / 2;
+	rcr_values = malloc(num_fields * 2 * sizeof(u32));
+	if (!rcr_values)
+		return -ENOMEM;
+
+	ret = dev_read_u32_array(dev, "rcr-initial-values", rcr_values,
+				 num_fields * 2);
+	if (ret < 0) {
+		free(rcr_values);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_fields; i++) {
+		reg = rcr_values[2 * i];
+		val = rcr_values[2 * i + 1];
+		writel(val, priv->base + reg);
+	}
+	free(rcr_values);
+
+	return 0;
+}
+
+static const struct udevice_id npcm_reset_ids[] = {
+	{ .compatible = "nuvoton,npcm845-reset" },
+	{ .compatible = "nuvoton,npcm750-reset" },
+	{ }
+};
+
+struct reset_ops npcm_reset_ops = {
+	.request = npcm_reset_request,
+	.rfree = npcm_reset_free,
+	.rst_assert = npcm_reset_assert,
+	.rst_deassert = npcm_reset_deassert,
+	.of_xlate = npcm_reset_xlate,
+};
+
+U_BOOT_DRIVER(npcm_reset) = {
+	.name = "npcm_reset",
+	.id = UCLASS_RESET,
+	.of_match = npcm_reset_ids,
+	.bind = npcm_reset_bind,
+	.ops = &npcm_reset_ops,
+	.priv_auto = sizeof(struct npcm_reset_priv),
+};
-- 
2.25.1

