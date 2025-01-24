Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E54C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620B9807E4;
	Fri, 24 Jan 2025 15:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730559;
	bh=XRMwRLtTE+kyVNKBaTbKYMP2CbYDn5HlI0d+ClskJj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qYGy9MY2z5MivNnRXna8VTCqQRPdh/yC2SU5ICnX/3THQ2PsQMlSaCa9hR6X6n4Zi
	 LWMkJMYt3Kf3V7903S4lmJVk5epF0I3hUXxQBU7Gou3ZZsPPzVpDDln5mgjljxJfDD
	 ouuBwJ6JLTWiE/LNlpQbWn2aZmJILW5XtjVSc5jb6jzA7kiPPWb8BH+ThBjr3+QHk5
	 +yU3l1XMCeYCAaQfcb71GIe9mW/dq0K0MrKS96Jd5FGPSfEwwWqRVnQxIEpEmA8vXK
	 o/lsJbRMo17rkAm5ViiTdFK/CSaETbpHCCtGM2sWb61/WEQhdfzZBHmBNe1Ig3I/ND
	 ERhgh5KDEkMyg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7432C80A3E; Fri, 24 Jan 2025 15:55:55 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483D380A30
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="bQCDnFsk"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 25C6310234FA6; Fri, 24 Jan 2025 15:55:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XRMwRLtTE+kyVNKBaTbKYMP2CbYDn5HlI0d+ClskJj8=;
 b=bQCDnFskjVZsry7W0RMVKps71xsZMuCG/cJdrhjg9h6mp+KLAlLdelCiHih4/a/sHm8lU/
 zOQlaJYDK4LfU81Or2FmTtTvZliu/CUn5E2d9sIqXGIIPa+8eoB05hp1P3gw1vA8fKXr5K
 Pv5MkuAKKAPty8p/2nT5H7SF7hWVtaibxckuT5dx/tUwpwsviASuI2g1zWaT/AtjolzsnF
 rPHpRF7uskWLSs29xdgljoH/IhPfymppg16CLMBFNP7HvIaGVGwj7bW4qy/a5oyQ88nsa3
 b4EqP0Yu46cqLVrPJ/HOR2dFWbvL4lT9/esqQT6x3vesHsYIEn+OV1kg52rMjQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/10] pinctrl: imx: Split imx_pinctrl_set_state() into common
 and mmio parts
Date: Fri, 24 Jan 2025 15:50:56 +0100
Message-ID: <20250124145520.185414-7-marex@denx.de>
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

Split imx_pinctrl_set_state() into imx_pinctrl_set_state_common() and
imx_pinctrl_set_state_mmio(). The former does the common configuration
parsing, the later does call imx_pinctrl_set_state_common() and then
does pin configuration using either SCU or MMIO accesses. The SCU part
is going to be moved out in follow up patches.

This is a preparatory patch for follow up pinctrl drivers which
do not use the MMIO accessors, but some other means, like SCU or
otherwise. Those will call the common imx_pinctrl_set_state_common()
function wrapped into some other imx_pinctrl_set_state_*() function,
in a way similar to imx_pinctrl_set_state_mmio() does so for MMIO
accesses.

Update all imx_pinctrl_set_state_mmio() call sites to call
imx_pinctrl_set_state_mmio() instead.

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
 drivers/pinctrl/nxp/pinctrl-imx.c     | 56 ++++++++++++++++-----------
 drivers/pinctrl/nxp/pinctrl-imx.h     |  4 +-
 drivers/pinctrl/nxp/pinctrl-imx5.c    |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx6.c    |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx7.c    |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx8.c    |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx8m.c   |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx93.c   |  2 +-
 drivers/pinctrl/nxp/pinctrl-imxrt.c   |  2 +-
 drivers/pinctrl/nxp/pinctrl-vf610.c   |  2 +-
 12 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 26b990e6efd..be68894f749 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -18,28 +18,15 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
+int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
+				 int pin_size, u32 **pin_data, int *npins)
 {
-	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct imx_pinctrl_soc_info *info = priv->info;
 	ofnode node = dev_ofnode(config);
 	const struct fdt_property *prop;
-	u32 *pin_data;
-	int npins, size, pin_size;
-	int mux_reg, conf_reg, input_reg;
-	u32 input_val, mux_mode, config_val;
-	u32 mux_shift = info->mux_mask ? ffs(info->mux_mask) - 1 : 0;
-	int i, j = 0;
+	int size;
 
 	dev_dbg(dev, "%s: %s\n", __func__, config->name);
 
-	if (info->flags & IMX8_USE_SCU)
-		pin_size = SHARE_IMX8_PIN_SIZE;
-	else if (info->flags & SHARE_MUX_CONF_REG)
-		pin_size = SHARE_FSL_PIN_SIZE;
-	else
-		pin_size = FSL_PIN_SIZE;
-
 	prop = ofnode_get_property(node, "fsl,pins", &size);
 	if (!prop) {
 		dev_err(dev, "No fsl,pins property in node %s\n", config->name);
@@ -52,18 +39,43 @@ int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		return -EINVAL;
 	}
 
-	pin_data = devm_kzalloc(dev, size, 0);
-	if (!pin_data)
+	*pin_data = devm_kzalloc(dev, size, 0);
+	if (!*pin_data)
 		return -ENOMEM;
 
-	if (ofnode_read_u32_array(node, "fsl,pins",
-				  pin_data, size >> 2)) {
+	if (ofnode_read_u32_array(node, "fsl,pins", *pin_data, size >> 2)) {
 		dev_err(dev, "Error reading pin data.\n");
-		devm_kfree(dev, pin_data);
+		devm_kfree(dev, *pin_data);
 		return -EINVAL;
 	}
 
-	npins = size / pin_size;
+	*npins = size / pin_size;
+
+	return 0;
+}
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
+	if (info->flags & IMX8_USE_SCU)
+		pin_size = SHARE_IMX8_PIN_SIZE;
+	else if (info->flags & SHARE_MUX_CONF_REG)
+		pin_size = SHARE_FSL_PIN_SIZE;
+	else
+		pin_size = FSL_PIN_SIZE;
+
+	ret = imx_pinctrl_set_state_common(dev, config, pin_size,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
 
 	if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index e647a135ebd..326d3f720e4 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -53,7 +53,9 @@ int imx_pinctrl_probe_mmio(struct udevice *dev);
 
 int imx_pinctrl_remove_mmio(struct udevice *dev);
 
-int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config);
+int imx_pinctrl_set_state_common(struct udevice *dev, struct udevice *config,
+				 int pin_size, u32 **pin_data, int *npins);
+int imx_pinctrl_set_state_mmio(struct udevice *dev, struct udevice *config);
 
 #ifdef CONFIG_PINCTRL_IMX_SCU
 int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index f17fe2d1cc1..af853bea180 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -24,7 +24,7 @@ static const struct udevice_id imx5_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx5_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx5_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 04ce1b49fe9..5c6aac56eb7 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -33,7 +33,7 @@ static const struct udevice_id imx6_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx6_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index 7287c7f4812..14c3d4d4e77 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -21,7 +21,7 @@ static const struct udevice_id imx7_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx7_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx7_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 07bcef071ab..400e1266822 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -25,7 +25,7 @@ static const struct udevice_id imx7ulp_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx7ulp_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx7ulp_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index a48e1b56df1..b6acc19ef8b 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -22,7 +22,7 @@ static const struct udevice_id imx8_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx8_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx8_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index bfc32223034..d9c63b3aca6 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -19,7 +19,7 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx8m_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx8mq_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 590aef8e491..2df63625191 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -24,7 +24,7 @@ static const struct udevice_id imx8ulp_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx8ulp_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx8ulp_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 8d631b4fb35..5d250db1081 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -19,7 +19,7 @@ static const struct udevice_id imx93_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imx93_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imx93_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index 84ca93cb618..39000ceb923 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -20,7 +20,7 @@ static const struct udevice_id imxrt_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops imxrt_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(imxrt_pinctrl) = {
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index 44193ec5021..cbff8dcefd8 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -20,7 +20,7 @@ static const struct udevice_id vf610_pinctrl_match[] = {
 };
 
 static const struct pinctrl_ops vf610_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state,
+	.set_state = imx_pinctrl_set_state_mmio,
 };
 
 U_BOOT_DRIVER(vf610_pinctrl) = {
-- 
2.45.2

