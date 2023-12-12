Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F81C4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EFF877C4;
	Tue, 12 Dec 2023 14:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lBKVulCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9312877FB; Tue, 12 Dec 2023 14:52:41 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEBB8779D
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c2c65e6aaso58500295e9.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702389158; x=1702993958; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lgttTPxxj3sNBTevPcPB5Exhsg1TJ333UF3Q/QzTEnU=;
 b=lBKVulCgruzMqviug/6h/tyYVl4KuHXAlfFgq/3vStBR0edWfauLhzEcIxFxqjkmsB
 EJzr7h/4DlYSh/zi6n+pL+jdjXFlfh74ydjDnKROl7B4HThnPMwIK2pw5JAiJpgP27wK
 jKdocmgxeCAcUWcZZD8JNlO5LXELN//IcEcHiTqVBd9GCxpRi5wnWu5Do2L7nw531IU4
 qH6bsApbMrJvIL6zXCSYjpeeU08oZF5/PfUrWhVm8MV9bWXp3EClELp41CDpiYFIdSvh
 Ckl80Zc5js2BwDRCmfNj/7mBEiZnH5mVFIGEkcSYWk/MqllhcpQO69kqg7eTGrt5H9Mv
 4htA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389158; x=1702993958;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lgttTPxxj3sNBTevPcPB5Exhsg1TJ333UF3Q/QzTEnU=;
 b=f0UXm2W8Drb5BWD9YvgwTgxnDZdiYZqbqg/pG4RkIu+lkXhSEqHieOnjsWIT+l/QSm
 3x1et23p4ea7c8m1VtGQ3ehQMEcuNAvTpVOs3aJirroNo/FJVuMeGYMQA0COo5BYs8uu
 3pbjjdGRkTnoUWVoT1YFS9s3n+EPHLyEwMqSYe/781GZOuK1EwyMNoh9eFXyzRawCKEF
 ZijGhhvyTIXNIYhqueGUlyx+UCw5By0efGdZpIMOwmSCY3Nt8YYT/D8FnT5QycVKihu6
 lSE8wrM5WRRaP5cqEa9N3DqZSKrd6QnZmUiYr9RWBQMu9PMuA+cqnevhoP93JJZroZoT
 +Igg==
X-Gm-Message-State: AOJu0YyNglX04YOmAFYIs3D7XvvdhgK7KCXYHHFxmrJsrb53ZmhMngyz
 OCuqAjcye1mUAIvm5YjTwfF4CA==
X-Google-Smtp-Source: AGHT+IG2oEl+qLwXqFsxACGpLEmCz4v8gpdi+ka7u7H97fTsXP4ry7T/h1+1ZsXDARWSKY50vdJh/Q==
X-Received: by 2002:a1c:7914:0:b0:40b:3605:acda with SMTP id
 l20-20020a1c7914000000b0040b3605acdamr2927984wme.25.1702389158297; 
 Tue, 12 Dec 2023 05:52:38 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
 by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040b5517ae31sm18910339wmb.6.2023.12.12.05.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 05:52:37 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 12 Dec 2023 14:52:27 +0100
Subject: [PATCH 1/2] net: Add Amlogic GXL MDIO Mux driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-u-boot-gxl-mdio-mux-v1-1-9adaa5cc7afb@linaro.org>
References: <20231212-u-boot-gxl-mdio-mux-v1-0-9adaa5cc7afb@linaro.org>
In-Reply-To: <20231212-u-boot-gxl-mdio-mux-v1-0-9adaa5cc7afb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=N9GWY5nilQIgg5hz2rV1RnuPJCIin7Cv9NiU7FGjHtU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleGWjT1MB99ZfRDHezFvjks4MWVMz3Q7rPXuhf
 bOH8Dux9xWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXhlowAKCRB33NvayMhJ
 0fG9D/9YKR+ODjwcm3cmpEJdjj2rDnqVA+oZOU3uLc5mW5u08xToCakXvHQ5EOIZGYE4U6pDNzE
 xgIIM8n1hMPXTntHcbjIRU8AiHC5PHU0RcqIrHF4Sv6aAswE6/gwT6qNYICHh8ikFxHw3q6NAYT
 BJ0tuH2kR7A7lX0rG5tilKZguLBbj/0XjqLUWGw07EVSWiyX464zk26VW9m6JDnashCFurvPdyi
 TN9uhDvbf1cwrSSu1msmBJNwgI83LRz0JhIEC7nJZ6KupIDjlvfTvq2ZjoZClTaU6Bqb73Bi+/H
 QMQm8MHgLPt6939G3YZ4amwU8WybrDneG3RCVLlm7mha79Hkq37Vh2rNzzxCpkI4esWQPbbGCGD
 uRE1FFpG6Ov2WphLBGMinS1rLhzMsBqNUd4apegon5kjKpSNwiEc1nnC8du2acNIRJAnq+EaOW/
 OZVPx+YcBL9/tl7H//lHESRLHRsT/4rPeU0Br0m2igEDz9Bx3qnIUmxW0AKakt/irVsofVxb3EJ
 +5xjeGK9nO4eFaCJZleR1zz+bxjlkYpFExOP2QNckAg8iAZg/igwEQH4hAVv89uKcdlulj2NJMz
 QLImPKhSg0sNwQh8TspDMrnqSJtSzTA+yxkR75PKAY6Dl7AA04Lf1O5NnSr+6DSJQxG16ATdh0O
 ZratXSuNa8WN/Vg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Port the mdio-mux-meson-gxl.c Linux driver introduced in [1],
and adapt it to U-Boot.

This driver is needed to boot U-Boot with Linux DT since v6.4,
since it switched the MDIO mux from the mmio to a proper GXL driver.

[1] 9a24e1ff4326 ("net: mdio: add amlogic gxl mdio mux support")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/net/Kconfig              |   7 ++
 drivers/net/Makefile             |   1 +
 drivers/net/mdio_mux_meson_gxl.c | 138 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ebab4d9f2e..18ec910d12 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -988,4 +988,11 @@ config MDIO_MUX_MESON_G12A
 	  This driver is used for the MDIO mux found on the Amlogic G12A & compatible
 	  SoCs.
 
+config MDIO_MUX_MESON_GXL
+	bool "MDIO MUX for Amlogic Meson GXL SoCs"
+	depends on DM_MDIO_MUX
+	help
+	  This driver is used for the MDIO mux found on the Amlogic GXL & compatible
+	  SoCs.
+
 endif # NETDEVICES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 1ce6fea323..3794609fd2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MUX_I2CREG) += mdio_mux_i2creg.o
 obj-$(CONFIG_MDIO_MUX_MESON_G12A) += mdio_mux_meson_g12a.o
+obj-$(CONFIG_MDIO_MUX_MESON_GXL) += mdio_mux_meson_gxl.o
 obj-$(CONFIG_MDIO_MUX_MMIOREG) += mdio_mux_mmioreg.o
 obj-$(CONFIG_MDIO_MUX_SANDBOX) += mdio_mux_sandbox.o
 obj-$(CONFIG_MDIO_SANDBOX) += mdio_sandbox.o
diff --git a/drivers/net/mdio_mux_meson_gxl.c b/drivers/net/mdio_mux_meson_gxl.c
new file mode 100644
index 0000000000..82e8b4af5f
--- /dev/null
+++ b/drivers/net/mdio_mux_meson_gxl.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Baylibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ * Copyright (C) Copyright 2023 Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <log.h>
+#include <miiphy.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+
+#define ETH_REG2		0x0
+#define  REG2_PHYID		GENMASK(21, 0)
+#define   EPHY_GXL_ID		0x110181
+#define  REG2_LEDACT		GENMASK(23, 22)
+#define  REG2_LEDLINK		GENMASK(25, 24)
+#define  REG2_DIV4SEL		BIT(27)
+#define  REG2_ADCBYPASS		BIT(30)
+#define  REG2_CLKINSEL		BIT(31)
+#define ETH_REG3		0x4
+#define  REG3_ENH		BIT(3)
+#define  REG3_CFGMODE		GENMASK(6, 4)
+#define  REG3_AUTOMDIX		BIT(7)
+#define  REG3_PHYADDR		GENMASK(12, 8)
+#define  REG3_PWRUPRST		BIT(21)
+#define  REG3_PWRDOWN		BIT(22)
+#define  REG3_LEDPOL		BIT(23)
+#define  REG3_PHYMDI		BIT(26)
+#define  REG3_CLKINEN		BIT(29)
+#define  REG3_PHYIP		BIT(30)
+#define  REG3_PHYEN		BIT(31)
+#define ETH_REG4		0x8
+#define  REG4_PWRUPRSTSIG	BIT(0)
+
+#define MESON_GXL_MDIO_EXTERNAL_ID 0
+#define MESON_GXL_MDIO_INTERNAL_ID 1
+
+struct mdio_mux_meson_gxl_priv {
+	phys_addr_t regs;
+};
+
+static int meson_gxl_enable_internal_mdio(struct mdio_mux_meson_gxl_priv *priv)
+{
+	u32 val;
+
+	/* Setup the internal phy */
+	val = (REG3_ENH |
+	       FIELD_PREP(REG3_CFGMODE, 0x7) |
+	       REG3_AUTOMDIX |
+	       FIELD_PREP(REG3_PHYADDR, 8) |
+	       REG3_LEDPOL |
+	       REG3_PHYMDI |
+	       REG3_CLKINEN |
+	       REG3_PHYIP);
+
+	writel(REG4_PWRUPRSTSIG, priv->regs + ETH_REG4);
+	writel(val, priv->regs + ETH_REG3);
+	mdelay(10);
+
+	/* NOTE: The HW kept the phy id configurable at runtime.
+	 * The id below is arbitrary. It is the one used in the vendor code.
+	 * The only constraint is that it must match the one in
+	 * drivers/net/phy/meson-gxl.c to properly match the PHY.
+	 */
+	writel(FIELD_PREP(REG2_PHYID, EPHY_GXL_ID),
+	       priv->regs + ETH_REG2);
+
+	/* Enable the internal phy */
+	val |= REG3_PHYEN;
+	writel(val, priv->regs + ETH_REG3);
+	writel(0, priv->regs + ETH_REG4);
+
+	/* The phy needs a bit of time to power up */
+	mdelay(10);
+
+	return 0;
+}
+
+static int meson_gxl_enable_external_mdio(struct mdio_mux_meson_gxl_priv *priv)
+{
+	/* Reset the mdio bus mux to the external phy */
+	writel(0, priv->regs + ETH_REG3);
+
+	return 0;
+}
+
+static int mdio_mux_meson_gxl_select(struct udevice *mux, int cur, int sel)
+{
+	struct mdio_mux_meson_gxl_priv *priv = dev_get_priv(mux);
+
+	debug("%s: %x -> %x\n", __func__, (u32)cur, (u32)sel);
+
+	/* if last selection didn't change we're good to go */
+	if (cur == sel)
+		return 0;
+
+	switch (sel) {
+	case MESON_GXL_MDIO_EXTERNAL_ID:
+		return meson_gxl_enable_external_mdio(priv);
+	case MESON_GXL_MDIO_INTERNAL_ID:
+		return meson_gxl_enable_internal_mdio(priv);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct mdio_mux_ops mdio_mux_meson_gxl_ops = {
+	.select = mdio_mux_meson_gxl_select,
+};
+
+static int mdio_mux_meson_gxl_probe(struct udevice *dev)
+{
+	struct mdio_mux_meson_gxl_priv *priv = dev_get_priv(dev);
+
+	priv->regs = dev_read_addr(dev);
+
+	return 0;
+}
+
+static const struct udevice_id mdio_mux_meson_gxl_ids[] = {
+	{ .compatible = "amlogic,gxl-mdio-mux" },
+	{ }
+};
+
+U_BOOT_DRIVER(mdio_mux_meson_gxl) = {
+	.name		= "mdio_mux_meson_gxl",
+	.id		= UCLASS_MDIO_MUX,
+	.of_match	= mdio_mux_meson_gxl_ids,
+	.probe		= mdio_mux_meson_gxl_probe,
+	.ops		= &mdio_mux_meson_gxl_ops,
+	.priv_auto	= sizeof(struct mdio_mux_meson_gxl_priv),
+};

-- 
2.34.1

