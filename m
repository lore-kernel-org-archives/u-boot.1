Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825EAC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5348880BA6;
	Fri, 24 Jan 2025 15:56:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730562;
	bh=A+KGo7bakI6orRYTFHT1Lf9D9dapXMlKuKj1m8MJhQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHryNXh3CxJTXAJCxmF5MNA4VL5Pr7airBp4i6dsD1SFL9LPwwj1frMYW9mqhdk6q
	 sxYYSCYGMUsAF36RcgxK4r84I7qoKTo/4EjMOeOaYkzejD+ZoYVkC47j+Xw9qmYcAD
	 m38Q7dA0ctxlPrCVjUXHX8VRbdKfRu0iLdXpTlivtQ3mTstackIJPO4OVGOWb1bVhI
	 M/pZYhsfKJ11vrhMnfxzC5HBkbtKZmwLEOpclFmndgD0NXcJQ5WAlgjiu5ulkfyRap
	 5Q2pilBtEhnlP3rhEATHoMgDnG5vtLz0XWbFGyWWmBllLQEjM3vJB/BUgeT0vqXasl
	 NfK43AUITa5hw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464FB807E4; Fri, 24 Jan 2025 15:55:59 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358A480AE5
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VPdiE2Gy"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 26CA810A396CE; Fri, 24 Jan 2025 15:55:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+KGo7bakI6orRYTFHT1Lf9D9dapXMlKuKj1m8MJhQ0=;
 b=VPdiE2Gy/AmKd6SE0N2gkzUC8aWWIoztOWsTpGgIXwaD9mOiCziDjXqq2nW5UKMm4k7ked
 utmAd7gTcJ4FA10mEuEWrK66cb3SPS2y21FAfU6asPGp2UZyb3bUjUHOZPL2pILUDnmBif
 D49D/pYMxzdn3i190oDNa0u4kKvQqijAyxDMEB6MHPmofp7iXw0Nd7vzr4HWIj2eLbsiX7
 bANDPWTlheH+/ROLENu66HgeZKHN10uq+Yx3W42RhNNxSoUGd35McHwh6iGJIiuEJZP5bp
 u2x+HuXPfzNJPH26dypSvblQvA6L4ykBsSIN09M3RDvdkOUR4WmKHBdzO6Axmg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] pinctrl: imx: Split MMIO accessors into
 pinctrl-imx-mmio.c
Date: Fri, 24 Jan 2025 15:50:59 +0100
Message-ID: <20250124145520.185414-10-marex@denx.de>
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

Split MMIO accessors into pinctrl-imx-mmio.c and build this
file only if Kconfig symbol PINCTRL_IMX_MMIO is selected.
Select PINCTRL_IMX_MMIO Kconfig symbol for all but pinctrl-imx8.c
driver, which does not use the MMIO accessors. This reduces the
amount of code compiled on platforms which do not use the code.

No functional change.

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
 drivers/pinctrl/nxp/Kconfig            |  22 ++-
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-mmio.c | 228 +++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx.c      | 208 ----------------------
 4 files changed, 242 insertions(+), 217 deletions(-)
 create mode 100644 drivers/pinctrl/nxp/pinctrl-imx-mmio.c

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index e2fc121ae75..d13c5f2a6d5 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,11 +1,15 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_MMIO
+	bool
+	select PINCTRL_IMX
+
 config PINCTRL_IMX5
 	bool "IMX5 pinctrl driver"
 	depends on ARCH_MX5 && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx5 pinctrl driver
 
@@ -19,7 +23,7 @@ config PINCTRL_IMX6
 	bool "IMX6 pinctrl driver"
 	depends on ARCH_MX6 && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx6 pinctrl driver
 
@@ -33,7 +37,7 @@ config PINCTRL_IMX7
 	bool "IMX7 pinctrl driver"
 	depends on ARCH_MX7 && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx7 pinctrl driver
 
@@ -47,7 +51,7 @@ config PINCTRL_IMX7ULP
 	bool "IMX7ULP pinctrl driver"
 	depends on ARCH_MX7ULP && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx7ulp pinctrl driver
 
@@ -61,7 +65,7 @@ config PINCTRL_IMX8ULP
 	bool "IMX8ULP pinctrl driver"
 	depends on ARCH_IMX8ULP && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx8ulp pinctrl driver
 
@@ -88,7 +92,7 @@ config PINCTRL_IMX8
 config PINCTRL_IMX8M
 	bool "IMX8M pinctrl driver"
 	depends on ARCH_IMX8M && PINCTRL_FULL
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx8m pinctrl driver
 
@@ -101,7 +105,7 @@ config PINCTRL_IMX8M
 config PINCTRL_IMX93
 	bool "IMX8M pinctrl driver"
 	depends on ARCH_IMX9 && PINCTRL_FULL
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imx8m pinctrl driver
 
@@ -125,7 +129,7 @@ config PINCTRL_IMXRT
 	bool "IMXRT pinctrl driver"
 	depends on ARCH_IMXRT && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the imxrt pinctrl driver
 
@@ -139,7 +143,7 @@ config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
 	select DEVRES
-	select PINCTRL_IMX
+	select PINCTRL_IMX_MMIO
 	help
 	  Say Y here to enable the Vybrid (vf610) pinctrl driver
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index c82275a2e93..44e37c631e5 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PINCTRL_IMX)		+= pinctrl-imx.o
+obj-$(CONFIG_PINCTRL_IMX_MMIO)		+= pinctrl-imx-mmio.o
 obj-$(CONFIG_PINCTRL_IMX5)		+= pinctrl-imx5.o
 obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-mmio.c b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
new file mode 100644
index 00000000000..6ee108a0120
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-mmio.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ */
+
+#include <malloc.h>
+#include <mapmem.h>
+#include <asm/global_data.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <dm.h>
+#include <dm/pinctrl.h>
+
+#include "pinctrl-imx.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
+	u32 mux_shift = info->mux_mask ? ffs(info->mux_mask) - 1 : 0;
+	u32 input_val, mux_mode, config_val;
+	int mux_reg, conf_reg, input_reg;
+	int npins, pin_size;
+	int i, j = 0, ret;
+	u32 *pin_data;
+
+	if (info->flags & SHARE_MUX_CONF_REG)
+		pin_size = SHARE_FSL_PIN_SIZE;
+	else
+		pin_size = FSL_PIN_SIZE;
+
+	ret = imx_pinctrl_set_state_common(dev, config, pin_size,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_reg = pin_data[j++];
+
+		if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
+			mux_reg = -1;
+
+		if (info->flags & SHARE_MUX_CONF_REG) {
+			conf_reg = mux_reg;
+		} else {
+			conf_reg = pin_data[j++];
+			if (!(info->flags & ZERO_OFFSET_VALID) &&
+			    !conf_reg)
+				conf_reg = -1;
+		}
+
+		if ((mux_reg == -1) || (conf_reg == -1)) {
+			dev_err(dev, "Error mux_reg or conf_reg\n");
+			devm_kfree(dev, pin_data);
+			return -EINVAL;
+		}
+
+		input_reg = pin_data[j++];
+		mux_mode = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		dev_dbg(dev, "mux_reg 0x%x, conf_reg 0x%x, input_reg 0x%x, mux_mode 0x%x, input_val 0x%x, config_val 0x%x\n",
+			mux_reg, conf_reg, input_reg, mux_mode,
+			input_val, config_val);
+
+		if (config_val & IMX_PAD_SION)
+			mux_mode |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		/* Set Mux */
+		if (info->flags & SHARE_MUX_CONF_REG) {
+			clrsetbits_le32(info->base + mux_reg,
+					info->mux_mask,
+					mux_mode << mux_shift);
+		} else {
+			writel(mux_mode, info->base + mux_reg);
+		}
+
+		dev_dbg(dev, "write mux: offset 0x%x val 0x%x\n",
+			mux_reg, mux_mode);
+
+		/*
+		 * Set select input
+		 *
+		 * If the select input value begins with 0xff,
+		 * it's a quirky select input and the value should
+		 * be interpreted as below.
+		 *     31     23      15      7        0
+		 *     | 0xff | shift | width | select |
+		 * It's used to work around the problem that the
+		 * select input for some pin is not implemented in
+		 * the select input register but in some general
+		 * purpose register. We encode the select input
+		 * value, width and shift of the bit field into
+		 * input_val cell of pin function ID in device tree,
+		 * and then decode them here for setting up the select
+		 * input bits in general purpose register.
+		 */
+
+		if (input_val >> 24 == 0xff) {
+			u32 val = input_val;
+			u8 select = val & 0xff;
+			u8 width = (val >> 8) & 0xff;
+			u8 shift = (val >> 16) & 0xff;
+			u32 mask = ((1 << width) - 1) << shift;
+			/*
+			 * The input_reg[i] here is actually some
+			 * IOMUXC general purpose register, not
+			 * regular select input register.
+			 */
+			val = readl(info->base + input_reg);
+			val &= ~mask;
+			val |= select << shift;
+			writel(val, info->base + input_reg);
+		} else if (input_reg) {
+			/*
+			 * Regular select input register can never be
+			 * at offset 0, and we only print register
+			 * value for regular case.
+			 */
+			if (info->input_sel_base)
+				writel(input_val,
+				       info->input_sel_base +
+				       input_reg);
+			else
+				writel(input_val,
+				       info->base + input_reg);
+
+			dev_dbg(dev, "select_input: offset 0x%x val 0x%x\n",
+				input_reg, input_val);
+		}
+
+		/* Set config */
+		if (!(config_val & IMX_NO_PAD_CTL)) {
+			if (info->flags & SHARE_MUX_CONF_REG) {
+				clrsetbits_le32(info->base + conf_reg,
+						~info->mux_mask,
+						config_val);
+			} else {
+				writel(config_val,
+				       info->base + conf_reg);
+			}
+
+			dev_dbg(dev, "write config: offset 0x%x val 0x%x\n",
+				conf_reg, config_val);
+		}
+	}
+
+	devm_kfree(dev, pin_data);
+
+	return 0;
+}
+
+
+int imx_pinctrl_probe_mmio(struct udevice *dev)
+{
+	struct imx_pinctrl_soc_info *info =
+		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct ofnode_phandle_args arg;
+	ofnode node = dev_ofnode(dev);
+	fdt_addr_t addr;
+	fdt_size_t size;
+	int ret;
+
+	ret = imx_pinctrl_probe_common(dev);
+	if (ret)
+		return ret;
+
+	addr = ofnode_get_addr_size_index(node, 0, &size);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	info->base = map_sysmem(addr, size);
+	if (!info->base)
+		return -ENOMEM;
+	priv->info = info;
+
+	info->mux_mask = ofnode_read_u32_default(node, "fsl,mux_mask", 0);
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
+	 */
+	if (ofnode_read_bool(node, "fsl,input-sel")) {
+		ret = ofnode_parse_phandle_with_args(node, "fsl,input-sel",
+						     NULL, 0, 0, &arg);
+		if (ret) {
+			dev_err(dev, "iomuxc fsl,input-sel property not found\n");
+			return -EINVAL;
+		}
+
+		addr = ofnode_get_addr_size(arg.node, "reg", &size);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		info->input_sel_base = map_sysmem(addr, size);
+		if (!info->input_sel_base)
+			return -ENOMEM;
+	}
+
+	dev_dbg(dev, "initialized IMX pinctrl driver\n");
+
+	return 0;
+}
+
+int imx_pinctrl_remove_mmio(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
+
+	if (info->input_sel_base)
+		unmap_sysmem(info->input_sel_base);
+	if (info->base)
+		unmap_sysmem(info->base);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 00637e7f54b..7d91ccfb26f 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -54,150 +54,6 @@ int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
 	return 0;
 }
 
-int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config)
-{
-	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct imx_pinctrl_soc_info *info = priv->info;
-	u32 mux_shift = info->mux_mask ? ffs(info->mux_mask) - 1 : 0;
-	u32 input_val, mux_mode, config_val;
-	int mux_reg, conf_reg, input_reg;
-	int npins, pin_size;
-	int i, j = 0, ret;
-	u32 *pin_data;
-
-	if (info->flags & SHARE_MUX_CONF_REG)
-		pin_size = SHARE_FSL_PIN_SIZE;
-	else
-		pin_size = FSL_PIN_SIZE;
-
-	ret = imx_pinctrl_set_state_common(dev, config, pin_size,
-					   &pin_data, &npins);
-	if (ret)
-		return ret;
-
-	/*
-	 * Refer to linux documentation for details:
-	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-	 */
-	for (i = 0; i < npins; i++) {
-		mux_reg = pin_data[j++];
-
-		if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
-			mux_reg = -1;
-
-		if (info->flags & SHARE_MUX_CONF_REG) {
-			conf_reg = mux_reg;
-		} else {
-			conf_reg = pin_data[j++];
-			if (!(info->flags & ZERO_OFFSET_VALID) &&
-			    !conf_reg)
-				conf_reg = -1;
-		}
-
-		if ((mux_reg == -1) || (conf_reg == -1)) {
-			dev_err(dev, "Error mux_reg or conf_reg\n");
-			devm_kfree(dev, pin_data);
-			return -EINVAL;
-		}
-
-		input_reg = pin_data[j++];
-		mux_mode = pin_data[j++];
-		input_val = pin_data[j++];
-		config_val = pin_data[j++];
-
-		dev_dbg(dev, "mux_reg 0x%x, conf_reg 0x%x, input_reg 0x%x, mux_mode 0x%x, input_val 0x%x, config_val 0x%x\n",
-			mux_reg, conf_reg, input_reg, mux_mode,
-			input_val, config_val);
-
-		if (config_val & IMX_PAD_SION)
-			mux_mode |= IOMUXC_CONFIG_SION;
-
-		config_val &= ~IMX_PAD_SION;
-
-		/* Set Mux */
-		if (info->flags & SHARE_MUX_CONF_REG) {
-			clrsetbits_le32(info->base + mux_reg,
-					info->mux_mask,
-					mux_mode << mux_shift);
-		} else {
-			writel(mux_mode, info->base + mux_reg);
-		}
-
-		dev_dbg(dev, "write mux: offset 0x%x val 0x%x\n",
-			mux_reg, mux_mode);
-
-		/*
-		 * Set select input
-		 *
-		 * If the select input value begins with 0xff,
-		 * it's a quirky select input and the value should
-		 * be interpreted as below.
-		 *     31     23      15      7        0
-		 *     | 0xff | shift | width | select |
-		 * It's used to work around the problem that the
-		 * select input for some pin is not implemented in
-		 * the select input register but in some general
-		 * purpose register. We encode the select input
-		 * value, width and shift of the bit field into
-		 * input_val cell of pin function ID in device tree,
-		 * and then decode them here for setting up the select
-		 * input bits in general purpose register.
-		 */
-
-		if (input_val >> 24 == 0xff) {
-			u32 val = input_val;
-			u8 select = val & 0xff;
-			u8 width = (val >> 8) & 0xff;
-			u8 shift = (val >> 16) & 0xff;
-			u32 mask = ((1 << width) - 1) << shift;
-			/*
-			 * The input_reg[i] here is actually some
-			 * IOMUXC general purpose register, not
-			 * regular select input register.
-			 */
-			val = readl(info->base + input_reg);
-			val &= ~mask;
-			val |= select << shift;
-			writel(val, info->base + input_reg);
-		} else if (input_reg) {
-			/*
-			 * Regular select input register can never be
-			 * at offset 0, and we only print register
-			 * value for regular case.
-			 */
-			if (info->input_sel_base)
-				writel(input_val,
-				       info->input_sel_base +
-				       input_reg);
-			else
-				writel(input_val,
-				       info->base + input_reg);
-
-			dev_dbg(dev, "select_input: offset 0x%x val 0x%x\n",
-				input_reg, input_val);
-		}
-
-		/* Set config */
-		if (!(config_val & IMX_NO_PAD_CTL)) {
-			if (info->flags & SHARE_MUX_CONF_REG) {
-				clrsetbits_le32(info->base + conf_reg,
-						~info->mux_mask,
-						config_val);
-			} else {
-				writel(config_val,
-				       info->base + conf_reg);
-			}
-
-			dev_dbg(dev, "write config: offset 0x%x val 0x%x\n",
-				conf_reg, config_val);
-		}
-	}
-
-	devm_kfree(dev, pin_data);
-
-	return 0;
-}
-
 int imx_pinctrl_probe_common(struct udevice *dev)
 {
 	struct imx_pinctrl_soc_info *info =
@@ -214,67 +70,3 @@ int imx_pinctrl_probe_common(struct udevice *dev)
 
 	return 0;
 }
-
-int imx_pinctrl_probe_mmio(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct ofnode_phandle_args arg;
-	ofnode node = dev_ofnode(dev);
-	fdt_addr_t addr;
-	fdt_size_t size;
-	int ret;
-
-	ret = imx_pinctrl_probe_common(dev);
-	if (ret)
-		return ret;
-
-	addr = ofnode_get_addr_size_index(node, 0, &size);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
-
-	info->base = map_sysmem(addr, size);
-	if (!info->base)
-		return -ENOMEM;
-	priv->info = info;
-
-	info->mux_mask = ofnode_read_u32_default(node, "fsl,mux_mask", 0);
-	/*
-	 * Refer to linux documentation for details:
-	 * Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
-	 */
-	if (ofnode_read_bool(node, "fsl,input-sel")) {
-		ret = ofnode_parse_phandle_with_args(node, "fsl,input-sel",
-						     NULL, 0, 0, &arg);
-		if (ret) {
-			dev_err(dev, "iomuxc fsl,input-sel property not found\n");
-			return -EINVAL;
-		}
-
-		addr = ofnode_get_addr_size(arg.node, "reg", &size);
-		if (addr == FDT_ADDR_T_NONE)
-			return -EINVAL;
-
-		info->input_sel_base = map_sysmem(addr, size);
-		if (!info->input_sel_base)
-			return -ENOMEM;
-	}
-
-	dev_dbg(dev, "initialized IMX pinctrl driver\n");
-
-	return 0;
-}
-
-int imx_pinctrl_remove_mmio(struct udevice *dev)
-{
-	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct imx_pinctrl_soc_info *info = priv->info;
-
-	if (info->input_sel_base)
-		unmap_sysmem(info->input_sel_base);
-	if (info->base)
-		unmap_sysmem(info->base);
-
-	return 0;
-}
-- 
2.45.2

