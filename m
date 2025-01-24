Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89E2C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0841E80AE6;
	Fri, 24 Jan 2025 15:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730560;
	bh=C6f/to6nvdr22CLI5lh1ERn19CHQI6u1AUmUrWRCvPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLZ/CxRF+BqtWbRRRAHdctfYXabuRFvj2zrschDC9QF7T22fAaPlTw/Ov0ldUJwJ7
	 F65Soe4vQzj9mhCpZFPkEO3h0OiZgB7px7w1neRxGyzpywZU3FmOn8hiRGvkVi2D1V
	 mVXlIbeFcQ72Ad+aT9YAH4zGOAflPFS09ctiRiRyYLxGZR29IrBOseeRgV+6YJoppQ
	 TwsxWUhgYVeCHcPhIu9C7ZPboVLOFTu2Be9eqtJiUvZlCRJeDNNTa2uvkS6Jnz/BUw
	 DAAUQRGR0Dmz6CaPgVGAUYegTdiw9YUG4qHJq8E/qjQ2EX6B0JZ9jIau7esi8FDPG5
	 AZrK7jTVzoY0w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FB680C58; Fri, 24 Jan 2025 15:55:57 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F01F80817
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fvpnrx6a"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 57E9810234FA6; Fri, 24 Jan 2025 15:55:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C6f/to6nvdr22CLI5lh1ERn19CHQI6u1AUmUrWRCvPc=;
 b=fvpnrx6ajt3nhdrPue+8KNO4YDyHgyJ44K52uzMwM++U6QODPQ/feFJKY4aEMhjlmwNWM9
 jh/w6UkGMqY95ZX8F0Xe4gZ6RXOz6SEFZTJPh/xk6toruXKyeAWGVJQyNTe94sfsHEiz5K
 Y6VSkLW7FOhGR6zbf6AN+H7PFQ4CeYmuogtUGOuZhtX0xvhhrNJIrWnFkeC4lIj6R2hbMs
 6YWafQSNvPn81HVYi4cP15uBzHg6A+mKl3J4urAFyUxUv2QqHeQptUbeJ3PATCLTyIRmGQ
 b+H0BBBW6b4iTU14TJWM7NGUrBD5pdWeKPA3dTkd1z3eLU/d5ygco7AuxX67lw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/10] pinctrl: imx: Fold imx_pinctrl_set_state_scu() from
 pinctrl-imx8.c
Date: Fri, 24 Jan 2025 15:50:58 +0100
Message-ID: <20250124145520.185414-9-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250124145520.185414-1-marex@denx.de>
References: <20250124145520.185414-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The only user of the SCU pinctrl code is pinctrl-imx8.c , fold
the entire pinctrl-scu.c code into pinctrl-imx8.c and remove the
matching Kconfig symbols and Makefile entries. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Jesse Taube <mr.bossman075@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pinctrl/nxp/Kconfig        |  4 --
 drivers/pinctrl/nxp/Makefile       |  1 -
 drivers/pinctrl/nxp/pinctrl-imx.h  |  1 -
 drivers/pinctrl/nxp/pinctrl-imx8.c | 71 +++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-scu.c  | 79 ------------------------------
 5 files changed, 71 insertions(+), 85 deletions(-)
 delete mode 100644 drivers/pinctrl/nxp/pinctrl-scu.c

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f6..e2fc121ae75 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,9 +1,6 @@
 config PINCTRL_IMX
 	bool
 
-config PINCTRL_IMX_SCU
-	bool
-
 config PINCTRL_IMX5
 	bool "IMX5 pinctrl driver"
 	depends on ARCH_MX5 && PINCTRL_FULL
@@ -79,7 +76,6 @@ config PINCTRL_IMX8
 	depends on ARCH_IMX8 && PINCTRL_FULL
 	select DEVRES
 	select PINCTRL_IMX
-	select PINCTRL_IMX_SCU
 	help
 	  Say Y here to enable the imx8 pinctrl driver
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef188..c82275a2e93 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
-obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
 obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index 94ecf1ba6b5..9adf999d3bb 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -56,6 +56,5 @@ int imx_pinctrl_remove_mmio(struct udevice *dev);
 int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
 				 int pin_size, u32 **pin_data, int *npins);
 int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config);
-int imx_pinctrl_set_state_scu(struct udevice *dev, struct udevice *config);
 
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index dcf778d123f..9b3b5aec07a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -3,6 +3,12 @@
  * Copyright 2018 NXP
  */
 
+#include <dm.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <asm/io.h>
+#include <firmware/imx/sci/sci.h>
+#include <misc.h>
 #include <asm/global_data.h>
 #include <dm/device.h>
 #include <dm/pinctrl.h>
@@ -11,6 +17,71 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define PADRING_IFMUX_EN_SHIFT		31
+#define PADRING_IFMUX_EN_MASK		BIT(31)
+#define PADRING_GP_EN_SHIFT		30
+#define PADRING_GP_EN_MASK		BIT(30)
+#define PADRING_IFMUX_SHIFT		27
+#define PADRING_IFMUX_MASK		GENMASK(29, 27)
+
+static int imx_pinconf_scu_set(struct imx_pinctrl_soc_info *info, u32 pad,
+			       u32 mux, u32 val)
+{
+	int ret;
+
+	/*
+	 * Mux should be done in pmx set, but we do not have a good api
+	 * to handle that in scfw, so config it in pad conf func
+	 */
+
+	if (!sc_rm_is_pad_owned(-1, pad)) {
+		debug("Pad[%u] is not owned by curr partition\n", pad);
+		return -EPERM;
+	}
+
+	val |= PADRING_IFMUX_EN_MASK;
+	val |= PADRING_GP_EN_MASK;
+	val |= (mux << PADRING_IFMUX_SHIFT) & PADRING_IFMUX_MASK;
+
+	ret = sc_pad_set(-1, pad, val);
+	if (ret)
+		printf("%s %d\n", __func__, ret);
+
+	return 0;
+}
+
+int imx_pinctrl_set_state_scu(struct udevice *dev, struct udevice *config)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
+	int pin_id, mux, config_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, SHARE_IMX8_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		pin_id = pin_data[j++];
+		mux = pin_data[j++];
+		config_val = pin_data[j++];
+
+		ret = imx_pinconf_scu_set(info, pin_id, mux, config_val);
+		if (ret && ret != -EPERM)
+			printf("Set pin %d, mux %d, val %d, error\n", pin_id,
+			       mux, config_val);
+	}
+
+	return 0;
+}
 static struct imx_pinctrl_soc_info imx8_pinctrl_soc_info = {
 	.flags = IMX8_USE_SCU,
 };
diff --git a/drivers/pinctrl/nxp/pinctrl-scu.c b/drivers/pinctrl/nxp/pinctrl-scu.c
deleted file mode 100644
index 3f47dde7e78..00000000000
--- a/drivers/pinctrl/nxp/pinctrl-scu.c
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2018-2019 NXP
- */
-
-#include <dm.h>
-#include <errno.h>
-#include <linux/bitops.h>
-#include <asm/io.h>
-#include <firmware/imx/sci/sci.h>
-#include <misc.h>
-
-#include "pinctrl-imx.h"
-
-#define PADRING_IFMUX_EN_SHIFT		31
-#define PADRING_IFMUX_EN_MASK		BIT(31)
-#define PADRING_GP_EN_SHIFT		30
-#define PADRING_GP_EN_MASK		BIT(30)
-#define PADRING_IFMUX_SHIFT		27
-#define PADRING_IFMUX_MASK		GENMASK(29, 27)
-
-static int imx_pinconf_scu_set(struct imx_pinctrl_soc_info *info, u32 pad,
-			       u32 mux, u32 val)
-{
-	int ret;
-
-	/*
-	 * Mux should be done in pmx set, but we do not have a good api
-	 * to handle that in scfw, so config it in pad conf func
-	 */
-
-	if (!sc_rm_is_pad_owned(-1, pad)) {
-		debug("Pad[%u] is not owned by curr partition\n", pad);
-		return -EPERM;
-	}
-
-	val |= PADRING_IFMUX_EN_MASK;
-	val |= PADRING_GP_EN_MASK;
-	val |= (mux << PADRING_IFMUX_SHIFT) & PADRING_IFMUX_MASK;
-
-	ret = sc_pad_set(-1, pad, val);
-	if (ret)
-		printf("%s %d\n", __func__, ret);
-
-	return 0;
-}
-
-int imx_pinctrl_set_state_scu(struct udevice *dev, struct udevice *config)
-{
-	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct imx_pinctrl_soc_info *info = priv->info;
-	int pin_id, mux, config_val;
-	u32 *pin_data;
-	int i, j = 0;
-	int npins;
-	int ret;
-
-	ret = imx_pinctrl_set_state_common(dev, config, SHARE_IMX8_PIN_SIZE,
-					   &pin_data, &npins);
-	if (ret)
-		return ret;
-
-	/*
-	 * Refer to linux documentation for details:
-	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-	 */
-	for (i = 0; i < npins; i++) {
-		pin_id = pin_data[j++];
-		mux = pin_data[j++];
-		config_val = pin_data[j++];
-
-		ret = imx_pinconf_scu_set(info, pin_id, mux, config_val);
-		if (ret && ret != -EPERM)
-			printf("Set pin %d, mux %d, val %d, error\n", pin_id,
-			       mux, config_val);
-	}
-
-	return 0;
-}
-- 
2.45.2

