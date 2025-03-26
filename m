Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5892EC36012
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECDE381EC5;
	Thu, 27 Mar 2025 05:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n/EW8GXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514E981CAF; Wed, 26 Mar 2025 16:01:41 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB6E81CFD
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BCD844428F;
 Wed, 26 Mar 2025 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZcZSzJh2l8LIapNhzFD35TlEI/vKwAorHjxoaRGfWA=;
 b=n/EW8GXJtV0Qh8+7Eirn7cYkOeRD0vnOCUqEJyuEJt8AaOME2yE8QPjAyJJIbFg8el8B9Z
 9elYy9AUkayZbWFWRzmaPFtYID8ems5g2Gt7ikq2DTqOJWIFxSGMNz3BUbLzM0umrvDqWZ
 yOG7BtmRyQuQOs/a5UvioqJZavGj2q6+7zdbjfSn0e0yPZzDrbcriYRptWUkSqOwGB37xH
 FnMQeAXYATPkSHggncibHjJK2M9MYrtTbb51hkHR8z64i20jV4hXhfqfjiTZ5ucVaXlAYE
 Z2S/Ea9wwlmM5esIjVDAPm9JXwi6iHvNscBdQFFAg74YMuTpvLmJG5OM6D4QXQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 16:00:53 +0100
Subject: [PATCH v5 09/12] imx: power-domain: Add support for the MEDIAMIX
 control block
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ge-mainline-display-support-v5-9-ea4bc3fc9bca@bootlin.com>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhto
 hepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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

This block delivers power and clocks to the whole display and rendering
pipeline.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/Kconfig           |   7 ++
 drivers/power/domain/Makefile          |   1 +
 drivers/power/domain/imx8mp-mediamix.c | 208 +++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index bd82d2f7044b3c3f8c88dea27c39193efedb4c84..5f5218bd8b5f4bed8283e91da61ac7c8c3eb97ae 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -47,6 +47,13 @@ config IMX8MP_HSIOMIX_BLKCTRL
 	help
 	  Enable support for manipulating NXP i.MX8MP on-SoC HSIOMIX block controller.
 
+config IMX8MP_MEDIAMIX_BLKCTRL
+	bool "Enable i.MX8MP MEDIAMIX domain driver"
+	depends on POWER_DOMAIN && IMX8MP
+	select CLK
+	help
+	  Enable support for manipulating NXP i.MX8MP on-SoC MEDIAMIX block controller.
+
 config MTK_POWER_DOMAIN
 	bool "Enable the MediaTek power domain driver"
 	depends on POWER_DOMAIN && ARCH_MEDIATEK
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 110646c503ab97941a2bb86caf53f94542008219..356ec07163fd299f00e81a629ffc06c663a26c25 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
+obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
 obj-$(CONFIG_MTK_POWER_DOMAIN) += mtk-power-domain.o
 obj-$(CONFIG_MESON_GX_VPU_POWER_DOMAIN) += meson-gx-pwrc-vpu.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
new file mode 100644
index 0000000000000000000000000000000000000000..78c32ca3d3a87febdefd5d128d39d817674b8d32
--- /dev/null
+++ b/drivers/power/domain/imx8mp-mediamix.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * i.MX8 MEDIAMIX control block driver
+ * Copyright (C) 2024 Miquel Raynal <miquel.raynal@bootlin.com>
+ * Inspired from Marek Vasut <marex@denx.de> work on the hsiomix driver.
+ */
+
+#include <asm/io.h>
+#include <clk.h>
+#include <dm.h>
+#include <power-domain-uclass.h>
+#include <linux/delay.h>
+
+#include <dt-bindings/power/imx8mp-power.h>
+
+#define BLK_SFT_RSTN		0x0
+#define BLK_CLK_EN		0x4
+
+struct imx8mp_mediamix_priv {
+	void __iomem *base;
+	struct clk clk_apb;
+	struct clk clk_axi;
+	struct clk clk_disp2;
+	struct power_domain pd_bus;
+	struct power_domain pd_lcdif2;
+};
+
+static int imx8mp_mediamix_on(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	struct power_domain *domain;
+	struct clk *clk;
+	u32 reset;
+	int ret;
+
+	switch (power_domain->id) {
+	case IMX8MP_MEDIABLK_PD_LCDIF_2:
+		domain = &priv->pd_lcdif2;
+		clk = &priv->clk_disp2;
+		reset = BIT(11) | BIT(12) | BIT(24);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Make sure bus domain is awake */
+	ret = power_domain_on(&priv->pd_bus);
+	if (ret)
+		return ret;
+
+	/* Put devices into reset */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
+
+	/* Enable upstream clocks */
+	ret = clk_enable(&priv->clk_apb);
+	if (ret)
+		goto dis_bus_pd;
+
+	ret = clk_enable(&priv->clk_axi);
+	if (ret)
+		goto dis_apb_clk;
+
+	/* Enable blk-ctrl clock to allow reset to propagate */
+	ret = clk_enable(clk);
+	if (ret)
+		goto dis_axi_clk;
+	setbits_le32(priv->base + BLK_CLK_EN, reset);
+
+	/* Power up upstream GPC domain */
+	ret = power_domain_on(domain);
+	if (ret)
+		goto dis_lcdif_clk;
+
+	/* Wait for reset to propagate */
+	udelay(5);
+
+	/* Release reset */
+	setbits_le32(priv->base + BLK_SFT_RSTN, reset);
+
+	return 0;
+
+dis_lcdif_clk:
+	clk_disable(clk);
+dis_axi_clk:
+	clk_disable(&priv->clk_axi);
+dis_apb_clk:
+	clk_disable(&priv->clk_apb);
+dis_bus_pd:
+	power_domain_off(&priv->pd_bus);
+
+	return ret;
+}
+
+static int imx8mp_mediamix_off(struct power_domain *power_domain)
+{
+	struct udevice *dev = power_domain->dev;
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	struct power_domain *domain;
+	struct clk *clk;
+	u32 reset;
+
+	switch (power_domain->id) {
+	case IMX8MP_MEDIABLK_PD_LCDIF_2:
+		domain = &priv->pd_lcdif2;
+		clk = &priv->clk_disp2;
+		reset = BIT(11) | BIT(12) | BIT(24);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Put devices into reset and disable clocks */
+	clrbits_le32(priv->base + BLK_SFT_RSTN, reset);
+	clrbits_le32(priv->base + BLK_CLK_EN, reset);
+
+	/* Power down upstream GPC domain */
+	power_domain_off(domain);
+
+	clk_disable(clk);
+	clk_disable(&priv->clk_axi);
+	clk_disable(&priv->clk_apb);
+
+	/* Allow bus domain to suspend */
+	power_domain_off(&priv->pd_bus);
+
+	return 0;
+}
+
+static int imx8mp_mediamix_of_xlate(struct power_domain *power_domain,
+				    struct ofnode_phandle_args *args)
+{
+	power_domain->id = args->args[0];
+
+	return 0;
+}
+
+static int imx8mp_mediamix_bind(struct udevice *dev)
+{
+	/* Bind child lcdif */
+	return dm_scan_fdt_dev(dev);
+}
+
+static int imx8mp_mediamix_probe(struct udevice *dev)
+{
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_read_addr_ptr(dev);
+
+	ret = clk_get_by_name(dev, "apb", &priv->clk_apb);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_get_by_name(dev, "axi", &priv->clk_axi);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_get_by_name(dev, "disp2", &priv->clk_disp2);
+	if (ret < 0)
+		return ret;
+
+	ret = power_domain_get_by_name(dev, &priv->pd_bus, "bus");
+	if (ret < 0)
+		return ret;
+
+	ret = power_domain_get_by_name(dev, &priv->pd_lcdif2, "lcdif2");
+	if (ret < 0)
+		goto free_bus_pd;
+
+	return 0;
+
+free_bus_pd:
+	power_domain_free(&priv->pd_bus);
+	return ret;
+}
+
+static int imx8mp_mediamix_remove(struct udevice *dev)
+{
+	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
+
+	power_domain_free(&priv->pd_lcdif2);
+	power_domain_free(&priv->pd_bus);
+
+	return 0;
+}
+
+static const struct udevice_id imx8mp_mediamix_ids[] = {
+	{ .compatible = "fsl,imx8mp-media-blk-ctrl" },
+	{ }
+};
+
+struct power_domain_ops imx8mp_mediamix_ops = {
+	.on = imx8mp_mediamix_on,
+	.off = imx8mp_mediamix_off,
+	.of_xlate = imx8mp_mediamix_of_xlate,
+};
+
+U_BOOT_DRIVER(imx8mp_mediamix) = {
+	.name		= "imx8mp_mediamix",
+	.id		= UCLASS_POWER_DOMAIN,
+	.of_match	= imx8mp_mediamix_ids,
+	.bind		= imx8mp_mediamix_bind,
+	.probe		= imx8mp_mediamix_probe,
+	.remove		= imx8mp_mediamix_remove,
+	.priv_auto	= sizeof(struct imx8mp_mediamix_priv),
+	.ops		= &imx8mp_mediamix_ops,
+};

-- 
2.48.1

