Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB3FC4707C
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 03:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E5E687B13;
	Thu, 11 Jan 2024 04:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="my5BLJyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8300487A80; Thu, 11 Jan 2024 04:09:23 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9E487A82
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 04:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-595ac2b6c59so2707732eaf.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 19:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704942555; x=1705547355; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juKf+qA0cmK3InW8rOb585XZUoQTeXd3cpOaxt5PQ4c=;
 b=my5BLJyot2KjQosRynxeRBKuhBDhjc/UpODf7bTMO7+eserc+6ue6RCycFbHiWjIjy
 PAMEIu1lfv6z9hp5zWXvoaRRBtZ7rlFew/w+XPAyupadbw5lLh7PAZG6fxuysKLVsF1Q
 2thsXn6EdGebOdEMAMTwwO3EQaOF5w783dCT5CIh6FL2yN0iBQltjz7stC1OA90523Na
 BqrvtN1/i/mgJlVFMAU3JOGj0woegu0VE+FiGzqP2OTmB3EQXubIfFUKHcsxoYgsZ59A
 myxa6RFIgNsxyaI8eWheZm6FCVsWe0xnxut8cVWl7fbcNta6ru6P9TC9huQ0MUpnzwiT
 Nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704942555; x=1705547355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=juKf+qA0cmK3InW8rOb585XZUoQTeXd3cpOaxt5PQ4c=;
 b=Ski58EWFVmiFosX6G+lSh8UhOP8Qk/pNjuykgKWwN4umLsF2HX5O60YM3ConXXPL7Q
 igqWQ5fF6iknuxwAMXKnFqE/CCZ+7+XejIBi7MWwvMUFlR2GGybP0g+1kHJ9nlhEcIGm
 O07jz88Y3B2ztmJIS5NIBDdDBSeDp3+hPjenNWTNu/DKWmdm3DLsxuEvW9+1d9699RHC
 aSU99HrZhhuFIU1aHBLE6Q0Ia/scWJW5GDK6VjE2iv2QOhEcuV/27uLuzjBuDFJv0zCw
 FdNvWfCo+dOlkVseGsatuQFCJBy7sEmztfcSqB/Eu8pHvf7u17VVTA97FxFU861VuWJd
 SSQw==
X-Gm-Message-State: AOJu0YxHa0iskz1Hn97qKshgS+LxX7KuvZGqdjbANPqTvpWBc5Gm5npJ
 U5QxO0yhkgIBYIS94rC8n3yCWnE3wcWFNg==
X-Google-Smtp-Source: AGHT+IF92qjIYNPV6nNW4tWlkcixvF6jNV3oQqBEYQYFosac6qaPJGjmTI2EW/b/QYBZq+d3IPcXsw==
X-Received: by 2002:a05:6820:22a0:b0:598:7d2a:ae6b with SMTP id
 ck32-20020a05682022a000b005987d2aae6bmr649532oob.9.1704942555477; 
 Wed, 10 Jan 2024 19:09:15 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 k12-20020a056820016c00b0058ad7b0b1a8sm14048ood.13.2024.01.10.19.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 19:09:14 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Chanho Park <chanho61.park@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH v2 04/13] soc: samsung: Add Exynos USI driver
Date: Wed, 10 Jan 2024 21:09:00 -0600
Message-Id: <20240111030909.27373-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111030909.27373-1-semen.protsenko@linaro.org>
References: <20240111030909.27373-1-semen.protsenko@linaro.org>
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

USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
registers usually reside in the same register map as a particular
underlying protocol it implements, but have some particular offset. E.g.
on Exynos850 the USI_UART has 0x13820000 base address, where UART
registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
offsets. Desired protocol can be chosen via SW_CONF register from System
Register block of the same domain as USI.

Before starting to use a particular protocol, USIv2 must be configured
properly:
  1. Select protocol to be used via System Register
  2. Clear "reset" flag in USI_CON
  3. Configure HWACG behavior (e.g. for UART Rx the HWACG must be
     disabled, so that the IP clock is not gated automatically); this is
     done using USI_OPTION register
  4. Keep both USI clocks (PCLK and IPCLK) running during USI registers
     modification

This driver implements the above behavior. Of course, USIv2 driver
should be probed before UART/I2C/SPI drivers. It can be achieved by
embedding UART/I2C/SPI nodes inside of the USI node (in Device Tree);
driver then walks underlying nodes and instantiates those. Driver also
handles USI configuration on PM resume, as register contents can be lost
during CPU suspend.

This driver is designed with different USI versions in mind. So it
should be relatively easy to add new USI revisions to it later.

Driver's code was copied over from Linux kernel [1] and adapted
correspondingly for U-Boot API. UCLASS_MISC is used, and although no
misc operations are implemented, it makes it easier to probe the driver
this way (as compared to UCLASS_NOP) and keep the code compact.

[1] drivers/soc/samsung/exynos-usi.c

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
  - Removed unnecessary 'mode' param in exynos_usi_set_sw_conf()
  - Removed usi->dev and used priv data instead
  - Used .of_plat_data callback for dts parsing
  - Added R-b tags

 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/samsung/Kconfig      |  23 ++++
 drivers/soc/samsung/Makefile     |   3 +
 drivers/soc/samsung/exynos-usi.c | 208 +++++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-usi.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 85dac9de78a4..03433bc0e6d2 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -40,6 +40,7 @@ config SOC_XILINX_VERSAL_NET
 	  This allows other drivers to verify the SoC familiy & revision using
 	  matching SoC attributes.
 
+source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/ti/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 84385650d46d..610bf816d40a 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the U-Boot SOC specific device drivers.
 
+obj-$(CONFIG_SOC_SAMSUNG) += samsung/
 obj-$(CONFIG_SOC_TI) += ti/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
 obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
new file mode 100644
index 000000000000..ffb87fe79316
--- /dev/null
+++ b/drivers/soc/samsung/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+menuconfig SOC_SAMSUNG
+	bool "Samsung SoC drivers support"
+
+if SOC_SAMSUNG
+
+config EXYNOS_USI
+	bool "Exynos USI (Universal Serial Interface) driver"
+	depends on ARCH_EXYNOS
+	select MISC
+	select REGMAP
+	select SYSCON
+	help
+	  Enable support for USI block. USI (Universal Serial Interface) is an
+	  IP-core found in modern Samsung Exynos SoCs, like Exynos850 and
+	  ExynosAutoV9. USI block can be configured to provide one of the
+	  following serial protocols: UART, SPI or High Speed I2C.
+
+	  This driver allows one to configure USI for desired protocol, which
+	  is usually done in USI node in Device Tree.
+
+endif
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
new file mode 100644
index 000000000000..833ac073fbfa
--- /dev/null
+++ b/drivers/soc/samsung/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-$(CONFIG_EXYNOS_USI)	+= exynos-usi.o
diff --git a/drivers/soc/samsung/exynos-usi.c b/drivers/soc/samsung/exynos-usi.c
new file mode 100644
index 000000000000..b746a7838e1f
--- /dev/null
+++ b/drivers/soc/samsung/exynos-usi.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Samsung Exynos USI driver (Universal Serial Interface).
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+#include <dt-bindings/soc/samsung,exynos-usi.h>
+
+/* USIv2: System Register: SW_CONF register bits */
+#define USI_V2_SW_CONF_NONE	0x0
+#define USI_V2_SW_CONF_UART	BIT(0)
+#define USI_V2_SW_CONF_SPI	BIT(1)
+#define USI_V2_SW_CONF_I2C	BIT(2)
+#define USI_V2_SW_CONF_MASK	(USI_V2_SW_CONF_UART | USI_V2_SW_CONF_SPI | \
+				 USI_V2_SW_CONF_I2C)
+
+/* USIv2: USI register offsets */
+#define USI_CON			0x04
+#define USI_OPTION		0x08
+
+/* USIv2: USI register bits */
+#define USI_CON_RESET		BIT(0)
+#define USI_OPTION_CLKREQ_ON	BIT(1)
+#define USI_OPTION_CLKSTOP_ON	BIT(2)
+
+enum exynos_usi_ver {
+	USI_VER2 = 2,
+};
+
+struct exynos_usi_variant {
+	enum exynos_usi_ver ver;	/* USI IP-core version */
+	unsigned int sw_conf_mask;	/* SW_CONF mask for all protocols */
+	size_t min_mode;		/* first index in exynos_usi_modes[] */
+	size_t max_mode;		/* last index in exynos_usi_modes[] */
+};
+
+struct exynos_usi {
+	void __iomem *regs;		/* USI register map */
+
+	size_t mode;			/* current USI SW_CONF mode index */
+	bool clkreq_on;			/* always provide clock to IP */
+
+	/* System Register */
+	struct regmap *sysreg;		/* System Register map */
+	unsigned int sw_conf;		/* SW_CONF register offset in sysreg */
+
+	const struct exynos_usi_variant *data;
+};
+
+struct exynos_usi_mode {
+	const char *name;		/* mode name */
+	unsigned int val;		/* mode register value */
+};
+
+static const struct exynos_usi_mode exynos_usi_modes[] = {
+	[USI_V2_NONE] =	{ .name = "none", .val = USI_V2_SW_CONF_NONE },
+	[USI_V2_UART] =	{ .name = "uart", .val = USI_V2_SW_CONF_UART },
+	[USI_V2_SPI] =	{ .name = "spi",  .val = USI_V2_SW_CONF_SPI },
+	[USI_V2_I2C] =	{ .name = "i2c",  .val = USI_V2_SW_CONF_I2C },
+};
+
+static const struct exynos_usi_variant exynos850_usi_data = {
+	.ver		= USI_VER2,
+	.sw_conf_mask	= USI_V2_SW_CONF_MASK,
+	.min_mode	= USI_V2_NONE,
+	.max_mode	= USI_V2_I2C,
+};
+
+static const struct udevice_id exynos_usi_ids[] = {
+	{
+		.compatible = "samsung,exynos850-usi",
+		.data = (ulong)&exynos850_usi_data,
+	},
+	{ } /* sentinel */
+};
+
+/**
+ * exynos_usi_set_sw_conf - Set USI block configuration mode
+ * @dev: Driver object
+ *
+ * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core as specified
+ * in @usi.mode.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int exynos_usi_set_sw_conf(struct udevice *dev)
+{
+	struct exynos_usi *usi = dev_get_priv(dev);
+	size_t mode = usi->mode;
+	unsigned int val;
+	int ret;
+
+	if (mode < usi->data->min_mode || mode > usi->data->max_mode)
+		return -EINVAL;
+
+	val = exynos_usi_modes[mode].val;
+	ret = regmap_update_bits(usi->sysreg, usi->sw_conf,
+				 usi->data->sw_conf_mask, val);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "protocol: %s\n", exynos_usi_modes[mode].name);
+
+	return 0;
+}
+
+/**
+ * exynos_usi_enable - Initialize USI block
+ * @usi: USI driver object
+ *
+ * USI IP-core start state is "reset" (on startup and after CPU resume). This
+ * routine enables the USI block by clearing the reset flag. It also configures
+ * HWACG behavior (needed e.g. for UART Rx). It should be performed before
+ * underlying protocol becomes functional.
+ */
+static void exynos_usi_enable(const struct exynos_usi *usi)
+{
+	u32 val;
+
+	/* Enable USI block */
+	val = readl(usi->regs + USI_CON);
+	val &= ~USI_CON_RESET;
+	writel(val, usi->regs + USI_CON);
+	udelay(1);
+
+	/* Continuously provide the clock to USI IP w/o gating */
+	if (usi->clkreq_on) {
+		val = readl(usi->regs + USI_OPTION);
+		val &= ~USI_OPTION_CLKSTOP_ON;
+		val |= USI_OPTION_CLKREQ_ON;
+		writel(val, usi->regs + USI_OPTION);
+	}
+}
+
+static int exynos_usi_configure(struct udevice *dev)
+{
+	struct exynos_usi *usi = dev_get_priv(dev);
+	int ret;
+
+	ret = exynos_usi_set_sw_conf(dev);
+	if (ret)
+		return ret;
+
+	if (usi->data->ver == USI_VER2)
+		exynos_usi_enable(usi);
+
+	return 0;
+}
+
+static int exynos_usi_of_to_plat(struct udevice *dev)
+{
+	struct exynos_usi *usi = dev_get_priv(dev);
+	ofnode node = dev_ofnode(dev);
+	int ret;
+	u32 mode;
+
+	usi->data = (struct exynos_usi_variant *)dev_get_driver_data(dev);
+	if (usi->data->ver == USI_VER2) {
+		usi->regs = dev_read_addr_ptr(dev);
+		if (!usi->regs)
+			return -ENODEV;
+	}
+
+	ret = ofnode_read_u32(node, "samsung,mode", &mode);
+	if (ret)
+		return ret;
+	if (mode < usi->data->min_mode || mode > usi->data->max_mode)
+		return -EINVAL;
+	usi->mode = mode;
+
+	usi->sysreg = syscon_regmap_lookup_by_phandle(dev, "samsung,sysreg");
+	if (IS_ERR(usi->sysreg))
+		return PTR_ERR(usi->sysreg);
+
+	ret = ofnode_read_u32_index(node, "samsung,sysreg", 1, &usi->sw_conf);
+	if (ret)
+		return ret;
+
+	usi->clkreq_on = ofnode_read_bool(node, "samsung,clkreq-on");
+
+	return 0;
+}
+
+static int exynos_usi_probe(struct udevice *dev)
+{
+	return exynos_usi_configure(dev);
+}
+
+U_BOOT_DRIVER(exynos_usi) = {
+	.name		= "exynos-usi",
+	.id		= UCLASS_MISC,
+	.of_match	= exynos_usi_ids,
+	.of_to_plat	= exynos_usi_of_to_plat,
+	.probe		= exynos_usi_probe,
+	.priv_auto	= sizeof(struct exynos_usi),
+};
-- 
2.39.2

