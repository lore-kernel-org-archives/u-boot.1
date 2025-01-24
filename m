Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAABC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1020580BAE;
	Fri, 24 Jan 2025 15:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730557;
	bh=gu47vcINLODpTTeS0CJDWgtMzQ0NOFtjAp1Ck3j5QTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YoBE0g1JNvQc5JAlD+o7YDuZyvQotNWvoprFIXPcfpncczQA3FPS/6/a5jlweQm30
	 jzrgm4pVoSBybtQwKmCkiMXDtVYun3+FSqzgA0HldfSwZzzSbb6QZf01luhnCU0Cni
	 oM60YGG+d4IEQVac9lDcC/1kc8HyPvf95mADxPTpSJ3QA3PFQXXRGwF+Ox4+lrpzdk
	 bHD4KwsFwwr7dh6Q780nadkcHyyhE7Et32+YgVUWsu9lgeLUPM5a5yAa1VnwHIEAFm
	 irJLRYdMSDipx+2D6auMBVzSNISdm8Sgdanr2mbaL+mRKbPl0POaue0WjFEEdaNyT9
	 yx+xEiVFqoGQg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCF5807FE; Fri, 24 Jan 2025 15:55:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7404180A3E
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MvENLYxh"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5438810A396CE; Fri, 24 Jan 2025 15:55:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gu47vcINLODpTTeS0CJDWgtMzQ0NOFtjAp1Ck3j5QTI=;
 b=MvENLYxhKSS+n6W7Rg4EGItjz+tGBTDcXcUmtAhOifY+rPEIIvUVXFZYdMggWbv5mGdwxa
 hnfPCbDLkmtyYWeNJpygi+ceqvJFBu8nGACHM4HSH2CQ0JjNnNPZJbyPHJ3zd5SEW8nY9J
 wL4OxppaR8fPEiOTBkB5SGcWYcBgqKqG1/vuLTADuOelWFmgH0ZnLRHjMedXTOpQ1Mev0l
 56jboxU8tb2tzjJxi8oZ9ozcTWLohpvR8xZ/IVm2PH9mxOczBMXG1f+44+XAYKY02lQvoL
 wyfJaRWCqWoRzt/WsyC6+gGK5KHRc/ZR73prPvk7EEu1MHUqorsyB71Diomvlg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/10] pinctrl: imx: Rename imx_pinctrl_remove() to
 imx_pinctrl_remove_mmio()
Date: Fri, 24 Jan 2025 15:50:55 +0100
Message-ID: <20250124145520.185414-6-marex@denx.de>
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

The current implementation of imx_pinctrl_remove() is specific
to the MMIO accessor implementation, rename the function to
imx_pinctrl_remove_mmio() to make this obvious. No functional
change.

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
 drivers/pinctrl/nxp/pinctrl-imx.c     | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx.h     | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx5.c    | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx6.c    | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx7.c    | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx8m.c   | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c | 2 +-
 drivers/pinctrl/nxp/pinctrl-imx93.c   | 2 +-
 drivers/pinctrl/nxp/pinctrl-imxrt.c   | 2 +-
 drivers/pinctrl/nxp/pinctrl-vf610.c   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index e65e069ac54..26b990e6efd 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -262,7 +262,7 @@ int imx_pinctrl_probe_mmio(struct udevice *dev)
 	return 0;
 }
 
-int imx_pinctrl_remove(struct udevice *dev)
+int imx_pinctrl_remove_mmio(struct udevice *dev)
 {
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
 	struct imx_pinctrl_soc_info *info = priv->info;
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index b9d50c0542e..e647a135ebd 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -51,7 +51,7 @@ struct imx_pinctrl_priv {
 int imx_pinctrl_probe_common(struct udevice *dev);
 int imx_pinctrl_probe_mmio(struct udevice *dev);
 
-int imx_pinctrl_remove(struct udevice *dev);
+int imx_pinctrl_remove_mmio(struct udevice *dev);
 
 int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config);
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index 814b088bdab..f17fe2d1cc1 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -32,7 +32,7 @@ U_BOOT_DRIVER(imx5_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx5_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx5_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 495b6af79fb..04ce1b49fe9 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -41,7 +41,7 @@ U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx6_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx6_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index e1fa6d76a13..7287c7f4812 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -29,7 +29,7 @@ U_BOOT_DRIVER(imx7_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 9ca8ef2130d..07bcef071ab 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -33,7 +33,7 @@ U_BOOT_DRIVER(imx7ulp_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx7ulp_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx7ulp_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index f69e6d74329..bfc32223034 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -27,7 +27,7 @@ U_BOOT_DRIVER(imx8mq_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8m_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8m_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index fed16b565a5..590aef8e491 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -32,7 +32,7 @@ U_BOOT_DRIVER(imx8ulp_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx8ulp_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto = sizeof(struct imx_pinctrl_priv),
 	.ops = &imx8ulp_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 8a58e586610..8d631b4fb35 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -27,7 +27,7 @@ U_BOOT_DRIVER(imx93_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imx93_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imx93_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index a8db355534c..84ca93cb618 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -28,7 +28,7 @@ U_BOOT_DRIVER(imxrt_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(imxrt_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &imxrt_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index 3c9396cadda..44193ec5021 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -28,7 +28,7 @@ U_BOOT_DRIVER(vf610_pinctrl) = {
 	.id = UCLASS_PINCTRL,
 	.of_match = of_match_ptr(vf610_pinctrl_match),
 	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove,
+	.remove = imx_pinctrl_remove_mmio,
 	.priv_auto	= sizeof(struct imx_pinctrl_priv),
 	.ops = &vf610_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
-- 
2.45.2

