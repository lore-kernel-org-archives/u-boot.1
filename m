Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2535C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 14:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F95680977;
	Fri, 24 Jan 2025 15:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737730552;
	bh=b6bgBHyCfASWcHh4piqu1s2LZseRVLaPGu49Uchrp98=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qfkba1jryr3ukuCmTcV/EyxFHGgao6IzUtgaVLY55ttbRaJqH0xQQm4nM3BGxTT/Y
	 aTcIIAiqlxatryrQRvxxxSWZZAHIZL4Kuqe8sHq1BaY1tM0IsLAKtxerdXma1/4jZP
	 ocM30odMuCXpEiuErN1UKoh5ZD1CQdMDs83WoJcV8oDw2tsjzWelUzG8b6Yb7wDcQX
	 DN3AVE+/fsuNySyG51lbXx5tp2EIEaO7H67CJc1Fpk/IpHs1GrlbmQJ3+LJIf8Oyxz
	 ZyRQ58awUs0+/3HgwLE4mtFKfipkDUXMbc1rnnX+rrSlohAscSgsnQwiCy9gz0lLXB
	 TNUFT61vn9IhA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D1180A3E; Fri, 24 Jan 2025 15:55:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D6F807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 15:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dXe90rBB"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9361410234FA6; Fri, 24 Jan 2025 15:55:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737730546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=b6bgBHyCfASWcHh4piqu1s2LZseRVLaPGu49Uchrp98=;
 b=dXe90rBBxvbD5v6O62HI+UxBfC3L4rk/fQr5QU6yanzRvgqqH58t0q6XMHKpM8ykv73Hi4
 dy7gLJu7X1oAumAhzT3u04bWmhvllhvQOulWZjfi85OkJgy2lhWyIy0T1am2Fn/QY5KoEM
 fBg4hb/qpX0PPN1FcZ4sB+KxiElbHXzJugza+nwSFn73btSvQU9qKKYWHaxIO+0ymrZMcm
 siElckP3v1l9Y/xncwgfzhXf5AMmMkhJi7NGOzM292/S7esXuFcLR6WQMZ7D8Yd1tf32pc
 Y4r6oe3uwLJ7Enahw2Zv1/2fFR4eA5CZ34TfIRtWowPob9ZxS6pXn52SA6K4CA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Alice Guo <alice.guo@nxp.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/10] pinctrl: imx: Push imx_pinctrl_ops into drivers and
 staticize
Date: Fri, 24 Jan 2025 15:50:50 +0100
Message-ID: <20250124145520.185414-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Move imx_pinctrl_ops into drivers and staticize. This is preparatory
patch for follow up pinctrl drivers which will not use this variant
of imx_pinctrl_ops content. This should not change size, as most of
the deployments compiled in one pinctrl driver anyway. No functional
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
 drivers/pinctrl/nxp/pinctrl-imx.c     | 6 +-----
 drivers/pinctrl/nxp/pinctrl-imx.h     | 4 ++--
 drivers/pinctrl/nxp/pinctrl-imx5.c    | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx6.c    | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx7.c    | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx7ulp.c | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx8.c    | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx8m.c   | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx8ulp.c | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imx93.c   | 4 ++++
 drivers/pinctrl/nxp/pinctrl-imxrt.c   | 4 ++++
 drivers/pinctrl/nxp/pinctrl-vf610.c   | 4 ++++
 12 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index 54cec37327c..3f055321c73 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -18,7 +18,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
+int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
 	struct imx_pinctrl_soc_info *info = priv->info;
@@ -194,10 +194,6 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	return 0;
 }
 
-const struct pinctrl_ops imx_pinctrl_ops  = {
-	.set_state = imx_pinctrl_set_state,
-};
-
 int imx_pinctrl_probe(struct udevice *dev,
 		      struct imx_pinctrl_soc_info *info)
 {
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2fc..02f05fdf20e 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -28,8 +28,6 @@ struct imx_pinctrl_priv {
 	struct imx_pinctrl_soc_info *info;
 };
 
-extern const struct pinctrl_ops imx_pinctrl_ops;
-
 #define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
 #define IMX_PAD_SION	0x40000000	/* set SION */
 
@@ -54,6 +52,8 @@ int imx_pinctrl_probe(struct udevice *dev, struct imx_pinctrl_soc_info *info);
 
 int imx_pinctrl_remove(struct udevice *dev);
 
+int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config);
+
 #ifdef CONFIG_PINCTRL_IMX_SCU
 int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 			      u32 *pin_data, int npins);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx5.c b/drivers/pinctrl/nxp/pinctrl-imx5.c
index 6b690fdce8f..c17d396d2b2 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx5.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx5.c
@@ -31,6 +31,10 @@ static const struct udevice_id imx5_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx5_pinctrl) = {
 	.name = "imx5-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx6.c b/drivers/pinctrl/nxp/pinctrl-imx6.c
index 322eec87ff5..2d3d4ceaa2b 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx6.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx6.c
@@ -40,6 +40,10 @@ static const struct udevice_id imx6_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(fsl_imx6q_iomuxc) = {
 	.name = "fsl_imx6q_iomuxc",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7.c b/drivers/pinctrl/nxp/pinctrl-imx7.c
index a8275e26456..2505f5df4a4 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7.c
@@ -28,6 +28,10 @@ static const struct udevice_id imx7_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx7_pinctrl) = {
 	.name = "imx7-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
index 7ea2dbe7d36..7d732f5a505 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx7ulp.c
@@ -32,6 +32,10 @@ static const struct udevice_id imx7ulp_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx7ulp_pinctrl) = {
 	.name = "imx7ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8.c b/drivers/pinctrl/nxp/pinctrl-imx8.c
index 4e9a9ea6808..930de19075a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8.c
@@ -29,6 +29,10 @@ static const struct udevice_id imx8_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx8_pinctrl) = {
 	.name = "imx8_pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index 6ea66a080b2..d30a6eef351 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -26,6 +26,10 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx8mq_pinctrl) = {
 	.name = "imx8mq-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
index 73d3c009d5b..0fb116a9893 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8ulp.c
@@ -31,6 +31,10 @@ static const struct udevice_id imx8ulp_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx8ulp_pinctrl) = {
 	.name = "imx8ulp-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
index 8d8ffec6d9a..2d027cd844e 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx93.c
@@ -26,6 +26,10 @@ static const struct udevice_id imx93_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imx93_pinctrl) = {
 	.name = "imx93-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-imxrt.c b/drivers/pinctrl/nxp/pinctrl-imxrt.c
index 23f07f8d1e0..fdb3cbe8190 100644
--- a/drivers/pinctrl/nxp/pinctrl-imxrt.c
+++ b/drivers/pinctrl/nxp/pinctrl-imxrt.c
@@ -27,6 +27,10 @@ static const struct udevice_id imxrt_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(imxrt_pinctrl) = {
 	.name = "imxrt-pinctrl",
 	.id = UCLASS_PINCTRL,
diff --git a/drivers/pinctrl/nxp/pinctrl-vf610.c b/drivers/pinctrl/nxp/pinctrl-vf610.c
index adf3073f1be..86514ebdb20 100644
--- a/drivers/pinctrl/nxp/pinctrl-vf610.c
+++ b/drivers/pinctrl/nxp/pinctrl-vf610.c
@@ -27,6 +27,10 @@ static const struct udevice_id vf610_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+static const struct pinctrl_ops imx_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state,
+};
+
 U_BOOT_DRIVER(vf610_pinctrl) = {
 	.name = "vf610-pinctrl",
 	.id = UCLASS_PINCTRL,
-- 
2.45.2

