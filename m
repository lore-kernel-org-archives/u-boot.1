Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D8C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987818781D;
	Wed, 13 Dec 2023 04:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fYtvemJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 900A787800; Wed, 13 Dec 2023 04:16:57 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B2B0877E5
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so65057147b3.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 19:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702437412; x=1703042212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJKNTzeYWThMcQQrSObBQIb6N2kP9i4dEZLeoiFCyKE=;
 b=fYtvemJYqz7+9aA/5jivEJJUqzxjkvAhyZ+iod2qnTN8N+45AYyd3IdLuAlrykHVzL
 F8dqs/CeYYIIiOsVPmDsWglAbQPcpoVmLmJt9e+QKo1NCycov0f887DJaJmTVQhj7/EW
 GiUBU75xx+PsQ3XNCArIO4WaRt4JGJgiW+wgp2FGzYkEKfV4DN0ghthTy+EOhqoNHZ5G
 3Qm0aNRju1Ty23MNGGMmofGy9vpv7xc5BBbuADWhrcaI+DPHjLLq/cK+d+lhM1aIztCW
 UPN8MVD98vu7uhCJnZ0G9qV72LKZUXL4xXTzjMOrCBYlW3aY5ZQq6LztjF9XQYqznXAs
 Bkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702437412; x=1703042212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sJKNTzeYWThMcQQrSObBQIb6N2kP9i4dEZLeoiFCyKE=;
 b=IrX+nHzHbJbGmdd2TZWElebIO+rY3/vYJzvt4grTlAMqim8JHU4PIkW6gTNwZvwKRX
 TmNuYBYCTAOrK7nyBBCO+YnX1dRfua8Tde+H/lrOzomq7Ur/YDiNlSRTveEDKs+RQf/c
 HZw/GuMPedRiXmMPMW4ZA6eCQkvlrfrTRSTUNZuSP2BDTHMxlcsHv7cXTM7hQjUxylFt
 CwTfRoNcRorr0aVH8/FmbCEHc4qEu6BxOtAXV0d68u86NrJDJ3oOwAYDGByksKpyK0YG
 99lT+kB2EKV5wL98DJkPTV9iLLytgeCL2PuATFikO1xCpv/BE+YuU52e7BJGWHRAUOPl
 25hw==
X-Gm-Message-State: AOJu0YwnJWR94YsICrpp/5UypS1mOJm55Sbrn6ybbBZVUj7xM7KmHtn2
 gRuTL6KA1jLOTaBpdiUB1udcEw==
X-Google-Smtp-Source: AGHT+IGq6mYtfrxJ6GI+qJulpdwjabH07xsQKcIbr0pzLPzWy/X0mP+1tS9FWwEX/knklfA9tSKu4g==
X-Received: by 2002:a81:52c8:0:b0:5e2:7e6d:31c6 with SMTP id
 g191-20020a8152c8000000b005e27e6d31c6mr812776ywb.93.1702437411879; 
 Tue, 12 Dec 2023 19:16:51 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 m18-20020a9d6ad2000000b006d7e23c58b6sm2578842otq.38.2023.12.12.19.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 19:16:51 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
Subject: [PATCH 05/13] soc: samsung: Add Exynos PMU driver
Date: Tue, 12 Dec 2023 21:16:38 -0600
Message-Id: <20231213031646.28828-6-semen.protsenko@linaro.org>
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

Add basic Power Management Unit (PMU) driver for Exynos SoCs. For now
it's only capable of changing UART path in PMU, which is needed for
E850-96 board. The driver's structure resembles the exynos-pmu driver
from Linux kernel, and although it's very basic and slim at the moment,
it can be easily extended in future if the need arises.

UCLASS_NOP is used, as there are no benefits in using more elaborate
classes like UCLASS_MISC in this case. The DM_FLAG_PROBE_AFTER_BIND flag
is added in bind function, as the probe function must be always called
for this driver.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/soc/samsung/Kconfig      |  10 +++
 drivers/soc/samsung/Makefile     |   1 +
 drivers/soc/samsung/exynos-pmu.c | 102 +++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/soc/samsung/exynos-pmu.c

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index ffb87fe79316..737b7ca8cd19 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -5,6 +5,16 @@ menuconfig SOC_SAMSUNG
 
 if SOC_SAMSUNG
 
+config EXYNOS_PMU
+	bool "Exynos PMU controller driver"
+	depends on ARCH_EXYNOS
+	select REGMAP
+	select SYSCON
+	help
+	  Enable support for system controller configuration driver. It allows
+	  one to configure system controller registers (e.g. some register in
+	  PMU syscon) by providing register's offset, mask and value.
+
 config EXYNOS_USI
 	bool "Exynos USI (Universal Serial Interface) driver"
 	depends on ARCH_EXYNOS
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index 833ac073fbfa..0eb3ed8353b0 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 obj-$(CONFIG_EXYNOS_USI)	+= exynos-usi.o
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
new file mode 100644
index 000000000000..233ad4a908f5
--- /dev/null
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Exynos PMU (Power Management Unit) driver.
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+
+#define EXYNOS850_UART_IO_SHARE_CTRL	0x0760
+#define SEL_RXD_AP_UART_SHIFT		16
+#define SEL_RXD_AP_UART_MASK		GENMASK(17, 16)
+#define SEL_TXD_GPIO_1_SHIFT		20
+#define SEL_TXD_GPIO_1_MASK		GENMASK(21, 20)
+#define RXD_GPIO_1			0x3
+#define TXD_AP_UART			0x0
+
+struct exynos_pmu {
+	struct udevice *dev;
+	const struct exynos_pmu_data *pmu_data;
+	struct regmap *regmap;
+};
+
+struct exynos_pmu_data {
+	int (*pmu_init)(struct exynos_pmu *priv);
+};
+
+static int exynos850_pmu_init(struct exynos_pmu *priv)
+{
+	ofnode node;
+	bool uart_debug_1;
+	unsigned int offset, mask, value;
+
+	node = dev_ofnode(priv->dev);
+	uart_debug_1 = ofnode_read_bool(node, "samsung,uart-debug-1");
+	if (!uart_debug_1)
+		return 0;
+
+	/*
+	 * If uart1_pins are used for serial, AP UART lines have to be muxed
+	 * in PMU block to UART_DEBUG_1 path (GPIO_1). By default (reset value)
+	 * UART_DEBUG_0 path (uart0_pins) is connected to AP UART lines.
+	 */
+	offset = EXYNOS850_UART_IO_SHARE_CTRL;
+	mask = SEL_RXD_AP_UART_MASK | SEL_TXD_GPIO_1_MASK;
+	value = RXD_GPIO_1 << SEL_RXD_AP_UART_SHIFT |
+		TXD_AP_UART << SEL_TXD_GPIO_1_SHIFT;
+	return regmap_update_bits(priv->regmap, offset, mask, value);
+}
+
+static const struct exynos_pmu_data exynos850_pmu_data = {
+	.pmu_init = exynos850_pmu_init,
+};
+
+static int exynos_pmu_bind(struct udevice *dev)
+{
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+	return 0;
+}
+
+static int exynos_pmu_probe(struct udevice *dev)
+{
+	ofnode node;
+	struct exynos_pmu *priv;
+
+	priv = dev_get_priv(dev);
+	priv->dev = dev;
+
+	node = dev_ofnode(dev);
+	priv->regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->pmu_data = (struct exynos_pmu_data *)dev_get_driver_data(dev);
+	if (priv->pmu_data && priv->pmu_data->pmu_init)
+		return priv->pmu_data->pmu_init(priv);
+
+	return 0;
+}
+
+static const struct udevice_id exynos_pmu_ids[] = {
+	{
+		.compatible = "samsung,exynos850-pmu",
+		.data = (ulong)&exynos850_pmu_data
+	},
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(exynos_pmu) = {
+	.name		= "exynos-pmu",
+	.id		= UCLASS_NOP,
+	.of_match	= exynos_pmu_ids,
+	.bind		= exynos_pmu_bind,
+	.probe		= exynos_pmu_probe,
+	.priv_auto	= sizeof(struct exynos_pmu),
+};
-- 
2.39.2

