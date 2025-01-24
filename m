Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FB5C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A9FA80BA0;
	Fri, 24 Jan 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730556;
	bh=HzA4mGwXT4r6dY4wlOkPJVf+h8j8VZaULm8SQ8gDmt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f64xzl0pMC68XyS6/SdZ29jln1u6t7fzm2JcBKZUg0GRNKg2quVij7h1cYd+20b3s
	 cFUDMt2hQ0BxZzuUkEFMyBmYQqS8LHzlWxRUqSTpAnWfkn4haZV2Z9PpXCte9E21k4
	 NwOyWp1s8P3M0ojE28ynCjYsdDz365fQCpOZarwLw65NLE5WZ1lwXsfCNPoaQc5htP
	 llgOtmLItNfNhIG6j0Kg3PYNpl7TIAEjauPt4F37W9EZu4qqTjfOUFNnf2k2IbJirc
	 oTYYfHBDLexOAvw0iC0VxSF5MvheAI4v6jIe31NRt+NIGLEHoENDX294dKzqzQr16D
	 N2fwRgGOawbEw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 303F180A30; Fri, 24 Jan 2025 15:55:53 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC9DF80A35
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="M8BHbmI6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFC0210234FA6; Fri, 24 Jan 2025 15:55:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HzA4mGwXT4r6dY4wlOkPJVf+h8j8VZaULm8SQ8gDmt8=;
 b=M8BHbmI6fRgODot3FDDCK6EvTZGWkz242U5qxIFmpArRhESUKKhDpXdnp4rEPPg1VMC/Uh
 cFAroDq+MWyOeoVJQQDf5cuda9yGCMZJQGwqP3HUdcFcrAIPbbGqaTtKYLuil5wQv962Xj
 oKewH6HSUiNLmzmjCcQk1UPzS4ZBFlKXTrh9DEgnNolZ157e01dYtMrrPxVO9s8GOq2XIE
 nbX3ovzfNyyUEb9RHDRJImYJhnF9IUqv1zdlk4IIWzD5IKHklqUuabBYmgi+rMGZIJI/nj
 sLTudOyHOz1S0lcmF8KfTve0gky6xhVKg+MJ1v0LNElQcK47na9uvgDsHAtg1A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] pinctrl: imx: Inline struct imx_pinctrl_soc_info access
 into probe
Date: Fri, 24 Jan 2025 15:50:53 +0100
Message-ID: <20250124145520.185414-4-marex@denx.de>
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

The probe function is identical across all the pinctrl drivers.
Inline the imx_pinctrl_soc_info access into imx_pinctrl_probe()
and drop all the duplicate probe functions. No functional change.

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
 drivers/pinctrl/nxp/pinctrl-imx.c     |  5 +++--
 drivers/pinctrl/nxp/pinctrl-imx.h     |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx5.c    | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx6.c    | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx7.c    | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx8.c    | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx8m.c   | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imx93.c   | 10 +---------
 drivers/pinctrl/nxp/pinctrl-imxrt.c   | 10 +---------
 drivers/pinctrl/nxp/pinctrl-vf610.c   | 10 +---------
 12 files changed, 14 insertions(+), 93 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 3443cf459db..2d142c3a8a9 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -194,9 +194,10 @@ int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	return 0;
 }
 
-int imx_pinctrl_probe(struct udevice *dev,
-		      struct imx_pinctrl_soc_info *info)
+int imx_pinctrl_probe(struct udevice *dev)
 {
+	struct imx_pinctrl_soc_info *info =
+		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
 	struct ofnode_phandle_args arg;
 	ofnode node = dev_ofnode(dev);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index 02f05fdf20e..b25f7988f46 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -48,7 +48,7 @@ struct imx_pinctrl_priv {
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
-int imx_pinctrl_probe(struct udevice *dev, struct imx_pinctrl_soc_info *info);
+int imx_pinctrl_probe(struct udevice *dev);
 
 int imx_pinctrl_remove(struct udevice *dev);
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index 56f0e174888..544c5093336 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -11,14 +11,6 @@
 
 static struct imx_pinctrl_soc_info imx5_pinctrl_soc_info __section(".data");
 
-static int imx5_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx5_pinctrl_match[] = {
 	{
 		.compatible = "fsl,imx53-iomuxc",
@@ -39,7 +31,7 @@ U_BOOT_DRIVER(imx5_pinctrl) = {
 	.name = "imx5-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx5_pinctrl_match),
-	.probe = imx5_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx5_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 23b5566d358..ae16ce73755 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -20,14 +20,6 @@ static struct imx_pinctrl_soc_info imx6_snvs_pinctrl_soc_info = {
 	.flags = ZERO_OFFSET_VALID,
 };
 
-static int imx6_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx6_pinctrl_match[] = {
 	{ .compatible = "fsl,imx6q-iomuxc", .data = (ulong)&imx6_pinctrl_soc_info },
 	{ .compatible = "fsl,imx6dl-iomuxc", .data = (ulong)&imx6_pinctrl_soc_info },
@@ -48,7 +40,7 @@ U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
 	.name = "fsl_imx6q_iomuxc",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx6_pinctrl_match),
-	.probe = imx6_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx6_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index faccd2ef8aa..87a35835566 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -14,14 +14,6 @@ static struct imx_pinctrl_soc_info imx7_lpsr_pinctrl_soc_info = {
 	.flags = ZERO_OFFSET_VALID,
 };
 
-static int imx7_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx7_pinctrl_match[] = {
 	{ .compatible = "fsl,imx7d-iomuxc", .data = (ulong)&imx7_pinctrl_soc_info },
 	{ .compatible = "fsl,imx7d-iomuxc-lpsr", .data = (ulong)&imx7_lpsr_pinctrl_soc_info },
@@ -36,7 +28,7 @@ U_BOOT_DRIVER(imx7_pinctrl) = {
 	.name = "imx7-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7_pinctrl_match),
-	.probe = imx7_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 3288926ad9e..1f4fce455d6 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -18,14 +18,6 @@ static struct imx_pinctrl_soc_info imx7ulp_pinctrl_soc_info1 = {
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG | CFG_IBE_OBE,
 };
 
-static int imx7ulp_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx7ulp_pinctrl_match[] = {
 	{ .compatible = "fsl,imx7ulp-iomuxc-0", .data = (ulong)&imx7ulp_pinctrl_soc_info0 },
 	{ .compatible = "fsl,imx7ulp-iomuxc-1", .data = (ulong)&imx7ulp_pinctrl_soc_info1 },
@@ -40,7 +32,7 @@ U_BOOT_DRIVER(imx7ulp_pinctrl) = {
 	.name = "imx7ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7ulp_pinctrl_match),
-	.probe = imx7ulp_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7ulp_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 85e5e5f5237..40976a9b588 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -15,14 +15,6 @@ static struct imx_pinctrl_soc_info imx8_pinctrl_soc_info = {
 	.flags = IMX8_USE_SCU,
 };
 
-static int imx8_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx8_pinctrl_match[] = {
 	{ .compatible = "fsl,imx8qxp-iomuxc", .data = (ulong)&imx8_pinctrl_soc_info },
 	{ .compatible = "fsl,imx8qm-iomuxc", .data = (ulong)&imx8_pinctrl_soc_info },
@@ -37,7 +29,7 @@ U_BOOT_DRIVER(imx8_pinctrl) = {
 	.name = "imx8_pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8_pinctrl_match),
-	.probe = imx8_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index 661e08cd1b7..b1dabaaae7a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -10,14 +10,6 @@
 
 static struct imx_pinctrl_soc_info imx8mq_pinctrl_soc_info __section(".data");
 
-static int imx8mq_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx8m_pinctrl_match[] = {
 	{ .compatible = "fsl,imx8mq-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
 	{ .compatible = "fsl,imx8mm-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
@@ -34,7 +26,7 @@ U_BOOT_DRIVER(imx8mq_pinctrl) = {
 	.name = "imx8mq-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8m_pinctrl_match),
-	.probe = imx8mq_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8m_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 40901f31752..e482ad5536d 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -17,14 +17,6 @@ static struct imx_pinctrl_soc_info imx8ulp_pinctrl_soc_info1 = {
 	.flags = ZERO_OFFSET_VALID | SHARE_MUX_CONF_REG | CFG_IBE_OBE,
 };
 
-static int imx8ulp_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx8ulp_pinctrl_match[] = {
 	{ .compatible = "fsl,imx8ulp-iomuxc0", .data = (ulong)&imx8ulp_pinctrl_soc_info0 },
 	{ .compatible = "fsl,imx8ulp-iomuxc1", .data = (ulong)&imx8ulp_pinctrl_soc_info1 },
@@ -39,7 +31,7 @@ U_BOOT_DRIVER(imx8ulp_pinctrl) = {
 	.name = "imx8ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8ulp_pinctrl_match),
-	.probe = imx8ulp_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto = sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8ulp_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 4db224d32a4..d5736e21067 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -12,14 +12,6 @@ static struct imx_pinctrl_soc_info imx93_pinctrl_soc_info __section(".data") = {
 	.flags = ZERO_OFFSET_VALID,
 };
 
-static int imx93_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imx93_pinctrl_match[] = {
 	{ .compatible = "fsl,imx93-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
 	{ .compatible = "fsl,imx91-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
@@ -34,7 +26,7 @@ U_BOOT_DRIVER(imx93_pinctrl) = {
 	.name = "imx93-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx93_pinctrl_match),
-	.probe = imx93_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx93_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index 4383015fb33..db523a9005a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -13,14 +13,6 @@ static struct imx_pinctrl_soc_info imxrt_pinctrl_soc_info = {
 	.flags = ZERO_OFFSET_VALID,
 };
 
-static int imxrt_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id imxrt_pinctrl_match[] = {
 	{ .compatible = "fsl,imxrt-iomuxc",
 	  .data = (ulong)&imxrt_pinctrl_soc_info },
@@ -35,7 +27,7 @@ U_BOOT_DRIVER(imxrt_pinctrl) = {
 	.name = "imxrt-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imxrt_pinctrl_match),
-	.probe = imxrt_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imxrt_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index 0e17b8c9ff9..e56df6dde56 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -13,14 +13,6 @@ static struct imx_pinctrl_soc_info vf610_pinctrl_soc_info = {
 	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
 };
 
-static int vf610_pinctrl_probe(struct udevice *dev)
-{
-	struct imx_pinctrl_soc_info *info =
-		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return imx_pinctrl_probe(dev, info);
-}
-
 static const struct udevice_id vf610_pinctrl_match[] = {
 	{ .compatible = "fsl,vf610-iomuxc",
 	  .data = (ulong)&vf610_pinctrl_soc_info },
@@ -35,7 +27,7 @@ U_BOOT_DRIVER(vf610_pinctrl) = {
 	.name = "vf610-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(vf610_pinctrl_match),
-	.probe = vf610_pinctrl_probe,
+	.probe = imx_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &vf610_pinctrl_ops,
-- 
2.45.2

