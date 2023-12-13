Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA078C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 699638781E;
	Wed, 13 Dec 2023 04:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p5vq/A2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5FB187800; Wed, 13 Dec 2023 04:16:57 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F002877D9
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6da2e360861so406499a34.1
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437411; x=1703042211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wk59+TN90fJbRR49fR9U3D09KijFo45EdoQQ86RZ6d8=;
 b=p5vq/A2P1LXei9zPYJWxRaLoMzYzP4FLfB3Crt9Pd4SG7CCKcBJ9pPw3xuXa5EruYs
 WRHIhl+5o9iYsDC78LMuA4kOnShOKz631f0lcVPIhVnWttBfobTJijcq751P9Fexnd7l
 2koUBVqugAPDMlTQvXry57IsfYRZoBhn4P0qlCNdXN8C2hSCOH+bp0RBM3WSKQpCSTii
 VBrZzWwsfT1odN7FDQFUzPCadmCWf3A7R2JuZoDOGz07aCp6QNazVUT/xX9UbaFhv4rb
 C39MDCNCWbWBouyE/EZNoWMXpyjCup1C9iGO71eB40jp4YcbPakM5a356aSiq6C1CIWD
 S1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437411; x=1703042211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wk59+TN90fJbRR49fR9U3D09KijFo45EdoQQ86RZ6d8=;
 b=wFCnwcnNcI5PWPGLn7MA4DC1uDkDdA/zE9UQ68KN4jSwAtX6Z2ogLdQ5859ygCaBYX
 4FaQCqtkznS8hhUCGCsjmosKA3A09TQ6V9hFZeSgKpo1jlsPNrTd4yuSrts4WTyJoyFf
 3HpcCiFs0PBVDVn0WBSy1Dm1BvJd8JtIyP7DogvOPBMU5l7OmFqkn88LJusldQD9Ov90
 rCjTsaC4N9rJvpbcGtyC+vN0UFUBYe0Ig/nwEc2p8KnLr2iM/gH+9rCw6KyvhwSyzDSZ
 Q3fAULHJuxn/lLYjzkvIkBC16UYlJ+YVi09mHfXDHMAcBCNngr1e0tkdrXKzapt9BWO8
 h7rA==
X-Gm-Message-State: AOJu0Yzk2wm5jgJT84hlB8lS9cV/7lOhLv5JbuoxVVRjM84vSnzlVNjW
 LzIz1CVEaP+/4FTwn50z5N3jmA==
X-Google-Smtp-Source: AGHT+IHogwYsgIn7A4TijCSCMsaMZY1dkJh4bNjib6JWqEHN3IY2J/07+zaitawC5s12Gqj/dF4s8w==
X-Received: by 2002:a05:6808:4498:b0:3b9:e7f5:e3a4 with SMTP id
 eq24-20020a056808449800b003b9e7f5e3a4mr3956958oib.22.1702437410848; 
 Tue, 12 Dec 2023 19:16:50 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 n16-20020aca2410000000b003b8b893b4easm2753325oic.8.2023.12.12.19.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:50 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 04/13] soc: samsung: Add Exynos USI driver
Date: Tue, 12 Dec 2023 21:16:37 -0600
Message-Id: <20231213031646.28828-5-semen.protsenko@linaro.org>
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
---
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/samsung/Kconfig      |  23 ++++
 drivers/soc/samsung/Makefile     |   3 +
 drivers/soc/samsung/exynos-usi.c | 218 +++++++++++++++++++++++++++++++
 5 files changed, 246 insertions(+)
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
index 000000000000..23255177e6e3
--- /dev/null
+++ b/drivers/soc/samsung/exynos-usi.c
@@ -0,0 +1,218 @@
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
+	struct udevice *dev;
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
+ * @usi: USI driver object
+ * @mode: Mode index
+ *
+ * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core.
+ *
+ * Return: 0 on success, or negative error code on failure.
+ */
+static int exynos_usi_set_sw_conf(struct exynos_usi *usi, size_t mode)
+{
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
+	usi->mode = mode;
+	dev_dbg(usi->dev, "protocol: %s\n", exynos_usi_modes[usi->mode].name);
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
+static int exynos_usi_configure(struct exynos_usi *usi)
+{
+	int ret;
+
+	ret = exynos_usi_set_sw_conf(usi, usi->mode);
+	if (ret)
+		return ret;
+
+	if (usi->data->ver == USI_VER2)
+		exynos_usi_enable(usi);
+
+	return 0;
+}
+
+static int exynos_usi_parse_dt(struct exynos_usi *usi)
+{
+	struct udevice *dev = usi->dev;
+	ofnode node;
+	int ret;
+	u32 mode;
+
+	node = dev_ofnode(dev);
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
+	struct exynos_usi *usi;
+	int ret;
+
+	usi = dev_get_priv(dev);
+	usi->dev = dev;
+	usi->data = (struct exynos_usi_variant *)dev_get_driver_data(dev);
+
+	ret = exynos_usi_parse_dt(usi);
+	if (ret)
+		return ret;
+
+	if (usi->data->ver == USI_VER2) {
+		usi->regs = dev_read_addr_ptr(dev);
+		if (!usi->regs)
+			return -ENODEV;
+	}
+
+	return exynos_usi_configure(usi);
+}
+
+U_BOOT_DRIVER(exynos_usi) = {
+	.name		= "exynos-usi",
+	.id		= UCLASS_MISC,
+	.of_match	= exynos_usi_ids,
+	.probe		= exynos_usi_probe,
+	.priv_auto	= sizeof(struct exynos_usi),
+};
-- 
2.39.2

