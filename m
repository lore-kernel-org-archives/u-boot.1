Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982A2C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB0383989;
	Wed, 31 Jul 2024 12:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A07B8897A; Wed, 31 Jul 2024 12:01:44 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id 514E18890F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from chris by delta.arachsys.com with local (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sZ69D-00070a-DV; Wed, 31 Jul 2024 11:01:31 +0100
Date: Wed, 31 Jul 2024 11:01:31 +0100
From: Chris Webb <chris@arachsys.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] pinctrl: mediatek: Bind gpio while binding pinctrl
Message-ID: <6ef2583e85eea60560d7776377d662779e7c44e5.1722419839.git.chris@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Mediatek pinctrl drivers call mtk_gpiochip_register() to bind the child
gpio controller as part of mtk_pinctrl_common_probe(). This breaks
gpiohog support because the gpio controller is bound too late for
DM_FLAG_PROBE_AFTER_BIND (set while binding hogs) to work.

Move the mtk_gpiochip_register() to mtk_pinctrl_common_bind() and call
this as the .bind method of each of the mediatek pinctrl drivers.

Signed-off-by: Chris Webb <chris@arachsys.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7623.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7629.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7981.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7986.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt7988.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8512.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mt8518.c     |  1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 18 +++++++++++-------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  1 +
 11 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 114f2602..46a5b663 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -749,6 +749,7 @@ U_BOOT_DRIVER(mt7622_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7622_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7622_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7623.c b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
index 2703e6f7..55e49a79 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7623.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7623.c
@@ -1410,6 +1410,7 @@ U_BOOT_DRIVER(mt7623_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7623_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7623_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7629.c b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
index 45d4def3..3b82423c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7629.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7629.c
@@ -413,6 +413,7 @@ U_BOOT_DRIVER(mt7629_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7629_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7629_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 4bc4abe6..047e37bc 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -1048,6 +1048,7 @@ U_BOOT_DRIVER(mt7981_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7981_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7981_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7986.c b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
index 819d6448..bf8cd037 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7986.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7986.c
@@ -773,6 +773,7 @@ U_BOOT_DRIVER(mt7986_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7986_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7986_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7988.c b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
index 03a38e83..1f384e86 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7988.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7988.c
@@ -1269,6 +1269,7 @@ U_BOOT_DRIVER(mt7988_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt7988_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt7988_probe,
 	.priv_auto = sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8512.c b/drivers/pinctrl/mediatek/pinctrl-mt8512.c
index bc5fb83a..5a8dd4dd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8512.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8512.c
@@ -382,6 +382,7 @@ U_BOOT_DRIVER(mt8512_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8512_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8512_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8516.c b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
index 7487d6f0..9c25066f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8516.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8516.c
@@ -388,6 +388,7 @@ U_BOOT_DRIVER(mt8516_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8516_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8516_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8518.c b/drivers/pinctrl/mediatek/pinctrl-mt8518.c
index 66fcfdff..333184a6 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8518.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8518.c
@@ -408,6 +408,7 @@ U_BOOT_DRIVER(mt8518_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = mt8518_pctrl_match,
 	.ops = &mtk_pinctrl_ops,
+	.bind = mtk_pinctrl_common_bind,
 	.probe = mtk_pinctrl_mt8518_probe,
 	.priv_auto	= sizeof(struct mtk_pinctrl_priv),
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ede3959c..a3662d46 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -791,11 +791,20 @@ bind:
 }
 #endif
 
+int mtk_pinctrl_common_bind(struct udevice *dev)
+{
+#if CONFIG_IS_ENABLED(DM_GPIO) || \
+    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
+	return mtk_gpiochip_register(dev);
+#else
+	return 0;
+#endif
+}
+
 int mtk_pinctrl_common_probe(struct udevice *dev,
 			     const struct mtk_pinctrl_soc *soc)
 {
 	struct mtk_pinctrl_priv *priv = dev_get_priv(dev);
-	int ret = 0;
 	u32 i = 0;
 	fdt_addr_t addr;
 	u32 base_calc = soc->base_calc;
@@ -813,10 +822,5 @@ int mtk_pinctrl_common_probe(struct udevice *dev,
 		priv->base[i] = (void __iomem *)addr;
 	}
 
-#if CONFIG_IS_ENABLED(DM_GPIO) || \
-    (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_GPIO))
-	ret = mtk_gpiochip_register(dev);
-#endif
-
-	return ret;
+	return 0;
 }
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index c948b808..15ab3c1b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -241,6 +241,7 @@ extern const struct pinctrl_ops mtk_pinctrl_ops;
 /* A common read-modify-write helper for MediaTek chips */
 void mtk_rmw(struct udevice *dev, u32 reg, u32 mask, u32 set);
 void mtk_i_rmw(struct udevice *dev, u8 i, u32 reg, u32 mask, u32 set);
+int mtk_pinctrl_common_bind(struct udevice *dev);
 int mtk_pinctrl_common_probe(struct udevice *dev,
 			     const struct mtk_pinctrl_soc *soc);
 

