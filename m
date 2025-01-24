Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56127C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B047F80ADA;
	Fri, 24 Jan 2025 15:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730559;
	bh=+gcAivW31wAieJ91YNlPWVB69+p+Y3mrldYOsGdFYP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+6ovyWgz+tBpXG/li08sHsjg9PgNCmkjgmq72JJpaf/vcxAGy1WEX7J9lTbG2TGl
	 S2PTPIzUgXTryZ6tSYaQE0CPQeOUEM0L9fh49yUgxQjmi6CNEkfEuOIDxZEsFO24t3
	 uXIeMfLgs4prvRGVXrnM5YUQvgwNOPsXEnoaJFCCAfx/54kHPqEHQlXcbJyL7VYBvX
	 vaS4o275pTraNsFpdnhUsBCseHdxA8v/MQICLoKcusHYEKuQ5l4Ne6GNk2NSTbaS1u
	 kuXupsOzZjqAgCtcOPkpHEBGTeJMEeJkbPAEuzkHK/yFYDI8V0rClXk71G+eY2+C4T
	 0Pi6JTOnyk/IA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E111280BAB; Fri, 24 Jan 2025 15:55:56 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F278807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BBCltcln"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1243F10A2F870; Fri, 24 Jan 2025 15:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+gcAivW31wAieJ91YNlPWVB69+p+Y3mrldYOsGdFYP4=;
 b=BBCltclnObOv8Lyiyw+H7sFedZXBU9g5Kn+joLfdFc0TRobCJDmXhgfQGtXqekjVahneOE
 pIg7sCYunmWT2wyF/XqmfVJnWx9KQxjLrkMzVsd1Ust/XSzKe9D/TlO5Uutf3It0sMd+T2
 V9KM3v7wvdVpNS7GTCz75Q8wGXEra2G2/Rp3JgX4hFnmtYaopFErwIJ4XXFAq5KaZOcH4o
 OeJKJhFhpR2BhTDSwNnR5h1fUO42aDLTDgyRjUhy3M4idIDNI5/HHGsTpX7GnirQhB5Ekc
 wnJCsF84FZdqyqFhTAGjXuYO9opfZaPSAHeOFdMjicmXYSlLLTWxw7KXgyAUuA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/10] pinctrl: imx: Split imx_pinctrl_set_state_scu() from
 imx_pinctrl_set_state_mmio()
Date: Fri, 24 Jan 2025 15:50:57 +0100
Message-ID: <20250124145520.185414-8-marex@denx.de>
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

Call imx_pinctrl_set_state_common() from imx_pinctrl_scu_conf_pins(),
rename imx_pinctrl_scu_conf_pins() to imx_pinctrl_set_state_scu().
Get rid of the unnecessary ifdeffery in pinctrl-imx.h in the process.
Remove all SCU support from pinctrl-imx.c imx_pinctrl_set_state_mmio()
which makes that function a pure MMIO pinctrl configuration accessor.
Update pinctrl-imx8.c to call imx_pinctrl_set_state_scu directly.

No functional change.

This patch is best viewed with git show -w due to indent change.

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
 drivers/pinctrl/nxp/pinctrl-imx.c  | 212 ++++++++++++++---------------
 drivers/pinctrl/nxp/pinctrl-imx.h  |  12 +-
 drivers/pinctrl/nxp/pinctrl-imx8.c |   2 +-
 drivers/pinctrl/nxp/pinctrl-scu.c  |  13 +-
 4 files changed, 115 insertions(+), 124 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index be68894f749..00637e7f54b 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -65,9 +65,7 @@ int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config)
 	int i, j = 0, ret;
 	u32 *pin_data;
 
-	if (info->flags & IMX8_USE_SCU)
-		pin_size = SHARE_IMX8_PIN_SIZE;
-	else if (info->flags & SHARE_MUX_CONF_REG)
+	if (info->flags & SHARE_MUX_CONF_REG)
 		pin_size = SHARE_FSL_PIN_SIZE;
 	else
 		pin_size = FSL_PIN_SIZE;
@@ -77,127 +75,121 @@ int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config)
 	if (ret)
 		return ret;
 
-	if (info->flags & IMX8_USE_SCU) {
-		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
-	} else {
-		/*
-		 * Refer to linux documentation for details:
-		 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-		 */
-		for (i = 0; i < npins; i++) {
-			mux_reg = pin_data[j++];
-
-			if (!(info->flags & ZERO_OFFSET_VALID) && !mux_reg)
-				mux_reg = -1;
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
 
-			if (info->flags & SHARE_MUX_CONF_REG) {
-				conf_reg = mux_reg;
-			} else {
-				conf_reg = pin_data[j++];
-				if (!(info->flags & ZERO_OFFSET_VALID) &&
-				    !conf_reg)
-					conf_reg = -1;
-			}
+		if ((mux_reg == -1) || (conf_reg == -1)) {
+			dev_err(dev, "Error mux_reg or conf_reg\n");
+			devm_kfree(dev, pin_data);
+			return -EINVAL;
+		}
 
-			if ((mux_reg == -1) || (conf_reg == -1)) {
-				dev_err(dev, "Error mux_reg or conf_reg\n");
-				devm_kfree(dev, pin_data);
-				return -EINVAL;
-			}
+		input_reg = pin_data[j++];
+		mux_mode = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
 
-			input_reg = pin_data[j++];
-			mux_mode = pin_data[j++];
-			input_val = pin_data[j++];
-			config_val = pin_data[j++];
+		dev_dbg(dev, "mux_reg 0x%x, conf_reg 0x%x, input_reg 0x%x, mux_mode 0x%x, input_val 0x%x, config_val 0x%x\n",
+			mux_reg, conf_reg, input_reg, mux_mode,
+			input_val, config_val);
 
-			dev_dbg(dev, "mux_reg 0x%x, conf_reg 0x%x, "
-				"input_reg 0x%x, mux_mode 0x%x, "
-				"input_val 0x%x, config_val 0x%x\n",
-				mux_reg, conf_reg, input_reg, mux_mode,
-				input_val, config_val);
+		if (config_val & IMX_PAD_SION)
+			mux_mode |= IOMUXC_CONFIG_SION;
 
-			if (config_val & IMX_PAD_SION)
-				mux_mode |= IOMUXC_CONFIG_SION;
+		config_val &= ~IMX_PAD_SION;
 
-			config_val &= ~IMX_PAD_SION;
+		/* Set Mux */
+		if (info->flags & SHARE_MUX_CONF_REG) {
+			clrsetbits_le32(info->base + mux_reg,
+					info->mux_mask,
+					mux_mode << mux_shift);
+		} else {
+			writel(mux_mode, info->base + mux_reg);
+		}
 
-			/* Set Mux */
-			if (info->flags & SHARE_MUX_CONF_REG) {
-				clrsetbits_le32(info->base + mux_reg,
-						info->mux_mask,
-						mux_mode << mux_shift);
-			} else {
-				writel(mux_mode, info->base + mux_reg);
-			}
+		dev_dbg(dev, "write mux: offset 0x%x val 0x%x\n",
+			mux_reg, mux_mode);
 
-			dev_dbg(dev, "write mux: offset 0x%x val 0x%x\n",
-				mux_reg, mux_mode);
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
 
+		if (input_val >> 24 == 0xff) {
+			u32 val = input_val;
+			u8 select = val & 0xff;
+			u8 width = (val >> 8) & 0xff;
+			u8 shift = (val >> 16) & 0xff;
+			u32 mask = ((1 << width) - 1) << shift;
 			/*
-			 * Set select input
-			 *
-			 * If the select input value begins with 0xff,
-			 * it's a quirky select input and the value should
-			 * be interpreted as below.
-			 *     31     23      15      7        0
-			 *     | 0xff | shift | width | select |
-			 * It's used to work around the problem that the
-			 * select input for some pin is not implemented in
-			 * the select input register but in some general
-			 * purpose register. We encode the select input
-			 * value, width and shift of the bit field into
-			 * input_val cell of pin function ID in device tree,
-			 * and then decode them here for setting up the select
-			 * input bits in general purpose register.
+			 * The input_reg[i] here is actually some
+			 * IOMUXC general purpose register, not
+			 * regular select input register.
 			 */
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
 
-			if (input_val >> 24 == 0xff) {
-				u32 val = input_val;
-				u8 select = val & 0xff;
-				u8 width = (val >> 8) & 0xff;
-				u8 shift = (val >> 16) & 0xff;
-				u32 mask = ((1 << width) - 1) << shift;
-				/*
-				 * The input_reg[i] here is actually some
-				 * IOMUXC general purpose register, not
-				 * regular select input register.
-				 */
-				val = readl(info->base + input_reg);
-				val &= ~mask;
-				val |= select << shift;
-				writel(val, info->base + input_reg);
-			} else if (input_reg) {
-				/*
-				 * Regular select input register can never be
-				 * at offset 0, and we only print register
-				 * value for regular case.
-				 */
-				if (info->input_sel_base)
-					writel(input_val,
-					       info->input_sel_base +
-					       input_reg);
-				else
-					writel(input_val,
-					       info->base + input_reg);
-
-				dev_dbg(dev, "select_input: offset 0x%x val "
-					"0x%x\n", input_reg, input_val);
+		/* Set config */
+		if (!(config_val & IMX_NO_PAD_CTL)) {
+			if (info->flags & SHARE_MUX_CONF_REG) {
+				clrsetbits_le32(info->base + conf_reg,
+						~info->mux_mask,
+						config_val);
+			} else {
+				writel(config_val,
+				       info->base + conf_reg);
 			}
 
-			/* Set config */
-			if (!(config_val & IMX_NO_PAD_CTL)) {
-				if (info->flags & SHARE_MUX_CONF_REG) {
-					clrsetbits_le32(info->base + conf_reg,
-							~info->mux_mask,
-							config_val);
-				} else {
-					writel(config_val,
-					       info->base + conf_reg);
-				}
-
-				dev_dbg(dev, "write config: offset 0x%x val "
-					"0x%x\n", conf_reg, config_val);
-			}
+			dev_dbg(dev, "write config: offset 0x%x val 0x%x\n",
+				conf_reg, config_val);
 		}
 	}
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index 326d3f720e4..94ecf1ba6b5 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -56,16 +56,6 @@ int imx_pinctrl_remove_mmio(struct udevice *dev);
 int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
 				 int pin_size, u32 **pin_data, int *npins);
 int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config);
-
-#ifdef CONFIG_PINCTRL_IMX_SCU
-int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
-			      u32 *pin_data, int npins);
-#else
-static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
-					    u32 *pin_data, int npins)
-{
-	return 0;
-}
-#endif
+int imx_pinctrl_set_state_scu(struct udevice *dev, struct udevice *config);
 
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index b6acc19ef8b..dcf778d123f 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -22,7 +22,7 @@ static const struct udevice_id imx8_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx8_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state_mmio,
+	.set_state = imx_pinctrl_set_state_scu,
 };
 
 U_BOOT_DRIVER(imx8_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-scu.c b/drivers/pinctrl/nxp/pinctrl-scu.c
index 42d5c96468c..3f47dde7e78 100644
--- a/drivers/pinctrl/nxp/pinctrl-scu.c
+++ b/drivers/pinctrl/nxp/pinctrl-scu.c
@@ -3,6 +3,7 @@
  * Copyright 2018-2019 NXP
  */
 
+#include <dm.h>
 #include <errno.h>
 #include <linux/bitops.h>
 #include <asm/io.h>
@@ -44,13 +45,21 @@ static int imx_pinconf_scu_set(struct imx_pinctrl_soc_info *info, u32 pad,
 	return 0;
 }
 
-int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info, u32 *pin_data,
-			      int npins)
+int imx_pinctrl_set_state_scu(struct udevice *dev, struct udevice *config)
 {
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
 	int pin_id, mux, config_val;
+	u32 *pin_data;
 	int i, j = 0;
+	int npins;
 	int ret;
 
+	ret = imx_pinctrl_set_state_common(dev, config, SHARE_IMX8_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
 	/*
 	 * Refer to linux documentation for details:
 	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-- 
2.45.2

