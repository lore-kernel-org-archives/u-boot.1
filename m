Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E26C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 07:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF17687963;
	Wed,  3 Jan 2024 08:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RreIXjvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A464387963; Wed,  3 Jan 2024 08:29:51 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B9F18788F
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 08:29:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so7938006a12.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 23:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704266987; x=1704871787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ZwL4i5GkaWkVq5rrf4nGUr9BuSFHc2Ikl+5KhP/tMQ=;
 b=RreIXjvoft4bQCiPR0z23l7XEf9q2lt1oo8602spyfHoGekzYVl1rXOhK+rONIEEvs
 Ii4kAYlpKHIONGn7PnXHKv+5Jj4hscIe17imano1OhBYcpxnTJ5KU0flgOA78p8we0YR
 9vKHm01QYdLCK2q5OvjeAh314yvgQAlWyzunuQiv/WHp0JxL1HTW0sTpmyuydeBv4ypm
 xgTQfps5wjzhOS9rmIRTkJDZj9veUHe16tvQn+MdIxa1MLOZckWCVjHoK4zN7LI5ykNT
 VXsiCQFbCE6x7NdPQqmSLMXxyVptWS1T0SkOjiAdOMfTwbOt8J4J0lpkuWdhR+DlUPoO
 5PCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704266987; x=1704871787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ZwL4i5GkaWkVq5rrf4nGUr9BuSFHc2Ikl+5KhP/tMQ=;
 b=Bli21uN5JAgxAdN3UUgN4BM3w1JbLZsC9jIbczJ2xLiWVAlmrYavNdwydnJYQWM5BR
 ZhNdeWd71UQpVt8uyVghuRN/yVvizmstoTNCzywTFDFxVRQaBPEJWGEHpIpqjyyob9a1
 VpW74v4IqILxBhoKnIgc+XuKVDkZcRC7WjK1a5w294dte4d1KIwZ0SBbfRX1Ku5vB04R
 QmMoNRLD7PBI65gb1hWur9/1ggku4V30HX2mLtCRGyQlnDrYtS4gg/Xbvm9Nrm81VF2n
 +tYAVzQ51+44uQFbAmY76d1b0BmIp7Gr2IJGx/pJ4Tif76lhF8Fa7k8kNK++502tOL+K
 nLPw==
X-Gm-Message-State: AOJu0Yw2wOkBaLRIS8+Gs10mK9BJunaEMocnOluoooXBDqWUefZgkm4c
 voM+REqlIqQpHQEowO3YVLU=
X-Google-Smtp-Source: AGHT+IG4DAx5+imfDAbZf4epHhVosA9yc9IdDWhwkEmTSexZSmcCGTq7vuHUEhHEZMgw4s4Z7pb35g==
X-Received: by 2002:a05:6a20:36a8:b0:195:ad6f:4548 with SMTP id
 s40-20020a056a2036a800b00195ad6f4548mr14689799pze.47.1704266987260; 
 Tue, 02 Jan 2024 23:29:47 -0800 (PST)
Received: from localhost.localdomain ([1.200.155.255])
 by smtp.gmail.com with ESMTPSA id
 gn2-20020a17090ac78200b0028bd9f88576sm879395pjb.26.2024.01.02.23.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 23:29:46 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] reset: npcm: Add support for Nuvoton NPCM BMC family
Date: Wed,  3 Jan 2024 15:29:33 +0800
Message-Id: <20240103072933.1319033-1-JJLIU0@nuvoton.com>
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
Changes for v2:
   - Use probe function to initialize priv struct.
     Set priv->base in the driver probe.
---
 drivers/reset/Kconfig      |   7 ++
 drivers/reset/Makefile     |   1 +
 drivers/reset/reset-npcm.c | 145 +++++++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+)
 create mode 100644 drivers/reset/reset-npcm.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 73bbd30692..e09e625542 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -135,6 +135,13 @@ config RESET_MTMIPS
 	help
 	  Support for reset controller on MediaTek MIPS platform.
 
+config RESET_NPCM
+	bool "Reset controller driver for Nuvoton BMCs"
+	depends on DM_RESET && ARCH_NPCM
+	default y
+	help
+	  Support for reset controller on Nuvotom BMCs.
+
 config RESET_SUNXI
 	bool "RESET support for Allwinner SoCs"
 	depends on DM_RESET && ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index e2239a250a..daa4553cca 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_MEDIATEK) += reset-mediatek.o
 obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
+obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_HISILICON) += reset-hisilicon.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
new file mode 100644
index 0000000000..3bf4514c1b
--- /dev/null
+++ b/drivers/reset/reset-npcm.c
@@ -0,0 +1,145 @@
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
+static int npcm_reset_probe(struct udevice *dev)
+{
+	struct npcm_reset_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_remap_addr(dev);
+	if (!priv->base)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int npcm_reset_bind(struct udevice *dev)
+{
+	void __iomem *reg_base;
+	u32 *rcr_values;
+	int num_fields;
+	u32 reg, val;
+	int ret, i;
+
+	reg_base = dev_remap_addr(dev);
+	if (!reg_base)
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
+		writel(val, reg_base + reg);
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
+	.probe = npcm_reset_probe,
+	.ops = &npcm_reset_ops,
+	.priv_auto = sizeof(struct npcm_reset_priv),
+};
-- 
2.25.1

