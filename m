Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304E0C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B775180BA8;
	Fri, 24 Jan 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730556;
	bh=W4BwsmDShFHmGqDp1F6BePXj5eyeh46zLPFKGiMVLZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JEjCNP4VK3mx53uqNin2LIN9tocH0Wm133aK6Lt/HHS7RGMSjnjecFUNiNotBwC2e
	 CI7Qq+k+NajFtxcdAXUoK5TsexCwtPabBsn12rQxwzByEhzG6YlG7sQR8DesxcRi8R
	 /+VHFjZdRfU5RYXHeMG2JEbHhVPL2W65j8r1FneLO7maIeTCoekaY3Ybm3g7fkSWkP
	 f0M61ArX3TuWNiRrvErECwxj1mR9wNj5iTuFj4xw2RfxOs/Lik+A3DjnvJpcOw/+rd
	 a0T4BnbWMM52CIF9AZas5OlOHwZj6RPcOJHgbOyFnBbbwNslGnFvFtGswYgWmC/tA4
	 xpFoOosKHXMJQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C591B80A38; Fri, 24 Jan 2025 15:55:53 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BF65807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="DyMnnWyP"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 853D910A2F870; Fri, 24 Jan 2025 15:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4BwsmDShFHmGqDp1F6BePXj5eyeh46zLPFKGiMVLZ8=;
 b=DyMnnWyPQTfzyFgQ4kAS+rx/3SN+t9DMCCSIS0WzFD1gU/miyaLZcyNTv9tO7MRQFlu1Hx
 9KXO+AHS0ed81x7rnK+I4tl3flwtEVAId4CHjgDqsiNDP5NmgwtouNg0UO3hjJHTukgYhK
 IrecCkJY+wyXxLrmesi01xUQGcgXuo1D3H51gJG7JPuy/IY20hD/GESq13cTitvdNy8tdZ
 HooYTaLkUNnYXHB4UoMVDeG6RfW36GODkmgwf2mVTTkIcIL599ppoGQDVarpbRJqr/tDHJ
 ww24wLM8UWbhJzwsXTc+lCv7qT3IM8U1t0OG76ebsLK8uQVvChZAuggYtqLT7Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] pinctrl: imx: Split imx_pinctrl_probe() into common and
 mmio parts
Date: Fri, 24 Jan 2025 15:50:54 +0100
Message-ID: <20250124145520.185414-5-marex@denx.de>
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

Split imx_pinctrl_probe() into imx_pinctrl_probe_common() and
imx_pinctrl_probe_mmio(). The former does the common setup, the
later does the common setup and MMIO access configuration. The
common setup can be used as-is for SCU based systems, update
the pinctrl-imx8 to call only the common setup, update all the
other pinctrl drivers to call imx_pinctrl_probe_mmio().

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
 drivers/pinctrl/nxp/pinctrl-imx.c     | 26 ++++++++++++++++++--------
 drivers/pinctrl/nxp/pinctrl-imx.h     |  3 ++-
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
 12 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 2d142c3a8a9..e65e069ac54 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -194,16 +194,11 @@ int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	return 0;
 }
 
-int imx_pinctrl_probe(struct udevice *dev)
+int imx_pinctrl_probe_common(struct udevice *dev)
 {
 	struct imx_pinctrl_soc_info *info =
 		(struct imx_pinctrl_soc_info *)dev_get_driver_data(dev);
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
-	struct ofnode_phandle_args arg;
-	ofnode node = dev_ofnode(dev);
-	fdt_addr_t addr;
-	fdt_size_t size;
-	int ret;
 
 	if (!info) {
 		dev_err(dev, "wrong pinctrl info\n");
@@ -213,8 +208,23 @@ int imx_pinctrl_probe(struct udevice *dev)
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
-		return 0;
+	return 0;
+}
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
 
 	addr = ofnode_get_addr_size_index(node, 0, &size);
 	if (addr == FDT_ADDR_T_NONE)
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index b25f7988f46..b9d50c0542e 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -48,7 +48,8 @@ struct imx_pinctrl_priv {
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
-int imx_pinctrl_probe(struct udevice *dev);
+int imx_pinctrl_probe_common(struct udevice *dev);
+int imx_pinctrl_probe_mmio(struct udevice *dev);
 
 int imx_pinctrl_remove(struct udevice *dev);
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index 544c5093336..814b088bdab 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -31,7 +31,7 @@ U_BOOT_DRIVER(imx5_pinctrl) = {
 	.name = "imx5-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx5_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx5_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index ae16ce73755..495b6af79fb 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -40,7 +40,7 @@ U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
 	.name = "fsl_imx6q_iomuxc",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx6_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx6_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index 87a35835566..e1fa6d76a13 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -28,7 +28,7 @@ U_BOOT_DRIVER(imx7_pinctrl) = {
 	.name = "imx7-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 1f4fce455d6..9ca8ef2130d 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -32,7 +32,7 @@ U_BOOT_DRIVER(imx7ulp_pinctrl) = {
 	.name = "imx7ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7ulp_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7ulp_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 40976a9b588..a48e1b56df1 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -29,7 +29,7 @@ U_BOOT_DRIVER(imx8_pinctrl) = {
 	.name = "imx8_pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_common,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index b1dabaaae7a..f69e6d74329 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -26,7 +26,7 @@ U_BOOT_DRIVER(imx8mq_pinctrl) = {
 	.name = "imx8mq-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8m_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8m_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index e482ad5536d..fed16b565a5 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -31,7 +31,7 @@ U_BOOT_DRIVER(imx8ulp_pinctrl) = {
 	.name = "imx8ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8ulp_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto = sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8ulp_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index d5736e21067..8a58e586610 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -26,7 +26,7 @@ U_BOOT_DRIVER(imx93_pinctrl) = {
 	.name = "imx93-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx93_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx93_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index db523a9005a..a8db355534c 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -27,7 +27,7 @@ U_BOOT_DRIVER(imxrt_pinctrl) = {
 	.name = "imxrt-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imxrt_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imxrt_pinctrl_ops,
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index e56df6dde56..3c9396cadda 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -27,7 +27,7 @@ U_BOOT_DRIVER(vf610_pinctrl) = {
 	.name = "vf610-pinctrl",
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(vf610_pinctrl_match),
-	.probe = imx_pinctrl_probe,
+	.probe = imx_pinctrl_probe_mmio,
 	.remove = imx_pinctrl_remove,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &vf610_pinctrl_ops,
-- 
2.45.2

