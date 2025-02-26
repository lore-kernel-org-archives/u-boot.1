Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655E4C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:44:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36AD80FF4;
	Wed, 26 Feb 2025 12:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HLVjdIYe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F9280FBC; Wed, 26 Feb 2025 12:44:09 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA20280F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abb90f68f8cso1277785366b.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570246; x=1741175046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5DPTaS8BPF17VeoQ/Wj8XA3JlA45mBjpdFXzb80wZ8=;
 b=HLVjdIYeNvoMEdGCnBy47LMgD5NmXRf2EKryxeMknzjSguSrLxt90Expnua47dzM+2
 4E/zqIXP3msskmsvP8tN0Nb8d4ohkbLEvW17zSL7f876FkzYVAHdbLJ9kXaOCkttGjaW
 1UuZZiN83ylHxF897egFMwECxKfyu42kqNvoL/j9EWWWvtWasqDbOo7ACIk9f7WlftGW
 S+BzuYJXD9+/pw8/9DSLM7gT0/4c74oFL9Wa+fJUtHXqfzS0+xRY73vSDPvurdihpr7Z
 dT678FOoeg/hoK6VlK6XuaLsMCwS+OnDfipfB6Uu/tmhoM5MMXsebrT7VvcWnH8y4Im9
 zqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570246; x=1741175046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5DPTaS8BPF17VeoQ/Wj8XA3JlA45mBjpdFXzb80wZ8=;
 b=BGki40HdmmuoWHI5JTByAD4TfJ1DhGpprVocawnoro2eQU0bqdOSd5uxRq/bzRkAfg
 hip9F0XQtkDcos85wnRtOQH2ib2KHtnpevDlupk0GTqEoxF+kMlVXP6CWaWlXyprlsZf
 3HD0O/fwfI1oOFw2Y8PmrMkD59ytePx2Mr30FFwoRwi1vXUgsF+Ifv607Y7azc2xU7Pp
 RPaJt4esIhNoEjmkhgyf4zIAUG2sKGv0+0Xxkdci1sGst+OWN8xLqxqkWFR+mcn3CE8J
 2fews7nwjbcfgiko3f1crFjnbk01AdvtKRTsHZlpGGEWAbHZawnrlGQ8Gv/CRdR38j/c
 x6HQ==
X-Gm-Message-State: AOJu0YxIDWHyZ+Rd45O4OvZjIECswNLh/NlSxaDx2OKl7vmyKEAyV/dr
 AIkEzbcP6UijSc6/4ktKepZfK3FfihNqN5UxQlsS2DEtY1L3G2ty
X-Gm-Gg: ASbGncuv6EOUmjwA+cMU1AKNduOD4jZiDWeUxrUfiqtnLbmJK4+7nvzCWnx+3Pq3UVL
 3OAD4oKmd9WynBczySTuqH2wPqm3h3lfJyuAhyCJBfR2h8P6blXr8wCIL0vnpTFKZ+VQDG9SXjg
 N++9hlh1oH6mxW+xbCwiRNGN1hLJIzzBB9YZM2MzIE16fP/biGCsuwFN6qYcHIkrxYUvm6kvzfm
 JPLRdViXskkIcYHa0h1ZYoJk7nHGj+M2W/gqM6fEvO3dyX/EOrXF8RXvAuSZw4l93IBQGB5pGQL
 zug4i4pre/EIxKZUOg==
X-Google-Smtp-Source: AGHT+IFpJXGgHi/3XG68o+74g+sUSzo1sFyV4MsXf7US2Nh2T3u7nPO9UzvsXqNBMnXUGRVQPG3sGQ==
X-Received: by 2002:a17:907:9686:b0:abb:b092:dad9 with SMTP id
 a640c23a62f3a-abed1017a14mr816442466b.37.1740570245842; 
 Wed, 26 Feb 2025 03:44:05 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed20b5cc5sm309513066b.168.2025.02.26.03.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:44:05 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/7] video: tegra20: mipi: add Tegra K1 support
Date: Wed, 26 Feb 2025 13:43:36 +0200
Message-ID: <20250226114340.42191-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226114340.42191-1-clamor95@gmail.com>
References: <20250226114340.42191-1-clamor95@gmail.com>
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

Re-design MIPI calibration driver to fit T124.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c  |  11 ++-
 drivers/video/tegra20/tegra-mipi.c | 134 ++++++++++++++++++++++++++---
 2 files changed, 130 insertions(+), 15 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 25cd4db0061..9f39ac7589b 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -53,6 +53,7 @@ struct tegra_dsi_priv {
 	int video_fifo_depth;
 	int host_fifo_depth;
 
+	u32 calibration_pads;
 	u32 version;
 
 	/* for ganged-mode support */
@@ -549,7 +550,7 @@ static void tegra_dsi_mipi_calibrate(struct udevice *dev)
 		DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
 	writel(value, &pad->pad_ctrl_3);
 
-	ret = misc_write(priv->mipi, 0, NULL, 0);
+	ret = misc_write(priv->mipi, priv->calibration_pads, NULL, 0);
 	if (ret)
 		log_debug("%s: MIPI calibration failed %d\n", __func__, ret);
 
@@ -1078,6 +1079,14 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 			log_debug("%s: cannot get MIPI: error %d\n", __func__, ret);
 			return ret;
 		}
+
+		ret = dev_read_u32_index(dev, "nvidia,mipi-calibrate", 1,
+					 &priv->calibration_pads);
+		if (ret) {
+			log_debug("%s: cannot get calibration pads: error %d\n",
+				  __func__, ret);
+			return ret;
+		}
 	}
 
 	panel_get_display_timing(priv->panel, &priv->timing);
diff --git a/drivers/video/tegra20/tegra-mipi.c b/drivers/video/tegra20/tegra-mipi.c
index 2df3c1a9942..a4f4343d008 100644
--- a/drivers/video/tegra20/tegra-mipi.c
+++ b/drivers/video/tegra20/tegra-mipi.c
@@ -10,9 +10,10 @@
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 
+#include <asm/arch/clock.h>
 #include <asm/io.h>
 
-/* MIPI control registers 0x00 ~ 0x60 */
+/* MIPI control registers 0x00 ~ 0x74 */
 struct mipi_ctlr {
 	uint mipi_cal_ctrl;
 	uint mipi_cal_autocal_ctrl;
@@ -38,8 +39,17 @@ struct mipi_ctlr {
 	uint mipi_cal_bias_pad_cfg0;
 	uint mipi_cal_bias_pad_cfg1;
 	uint mipi_cal_bias_pad_cfg2;
+
+	uint mipi_cal_dsia_config_2;
+	uint mipi_cal_dsib_config_2;
+	uint mipi_cal_cilc_config_2;
+	uint mipi_cal_cild_config_2;
+	uint mipi_cal_csie_config_2;
 };
 
+#define MIPI_DSIA_PADS			0x60
+#define MIPI_DSIB_PADS			0x180
+
 #define MIPI_CAL_CTRL_NOISE_FILTER(x)	(((x) & 0xf) << 26)
 #define MIPI_CAL_CTRL_PRESCALE(x)	(((x) & 0x3) << 24)
 #define MIPI_CAL_CTRL_CLKEN_OVR		BIT(4)
@@ -64,26 +74,25 @@ struct mipi_ctlr {
 #define MIPI_CAL_BIAS_PAD_VAUXP(x)	(((x) & 0x7) << 4)
 #define MIPI_CAL_BIAS_PAD_PDVREG	BIT(1)
 
+#define MIPI_CAL_HSCLKPDOSDSI(x)	(((x) & 0x1f) << 8)
+#define MIPI_CAL_HSCLKPUOSDSI(x)	(((x) & 0x1f) << 0)
+
 struct tegra_mipi_priv {
 	struct mipi_ctlr	*mipi;
 	struct clk		*mipi_cal;
+	u32 version;
 };
 
-static int tegra_mipi_calibrate(struct udevice *dev, int offset, const void *buf,
-				int size)
+enum {
+	T114,
+	T124,
+};
+
+static void tegra114_mipi_pads_cal(struct tegra_mipi_priv *priv,
+				   int calibration_pads)
 {
-	struct tegra_mipi_priv *priv = dev_get_priv(dev);
 	u32 value;
 
-	value = MIPI_CAL_BIAS_PAD_DRV_DN_REF(0x2) |
-		MIPI_CAL_BIAS_PAD_DRV_UP_REF(0x0);
-	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg1);
-
-	value = readl(&priv->mipi->mipi_cal_bias_pad_cfg2);
-	value &= ~MIPI_CAL_BIAS_PAD_VCLAMP(0x7);
-	value &= ~MIPI_CAL_BIAS_PAD_VAUXP(0x7);
-	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg2);
-
 	value = MIPI_CAL_OVERIDE(0x0) | MIPI_CAL_SEL(0x1) |
 		MIPI_CAL_HSPDOS(0x0) | MIPI_CAL_HSPUOS(0x4) |
 		MIPI_CAL_TERMOS(0x5);
@@ -99,6 +108,95 @@ static int tegra_mipi_calibrate(struct udevice *dev, int offset, const void *buf
 	value = readl(&priv->mipi->mipi_cal_config_dsid);
 	value &= ~(MIPI_CAL_SEL(0x1));
 	writel(value, &priv->mipi->mipi_cal_config_dsid);
+}
+
+static void tegra124_mipi_pads_cal(struct tegra_mipi_priv *priv,
+				   int calibration_pads)
+{
+	u32 value;
+
+	/* Calibrate DSI-A */
+	if (calibration_pads == MIPI_DSIA_PADS) {
+		printf("Calibrating DSI-A pads\n");
+
+		value = MIPI_CAL_OVERIDE(0x0) | MIPI_CAL_SEL(0x1) |
+			MIPI_CAL_HSPDOS(0x0) | MIPI_CAL_HSPUOS(0x0) |
+			MIPI_CAL_TERMOS(0x0);
+		writel(value, &priv->mipi->mipi_cal_config_dsia);
+		writel(value, &priv->mipi->mipi_cal_config_dsib);
+
+		value = MIPI_CAL_SEL(0x1) |
+			MIPI_CAL_HSCLKPDOSDSI(0x1) |
+			MIPI_CAL_HSCLKPUOSDSI(0x2);
+		writel(value, &priv->mipi->mipi_cal_dsia_config_2);
+		writel(value, &priv->mipi->mipi_cal_dsib_config_2);
+
+		/* Deselect PAD C */
+		value = readl(&priv->mipi->mipi_cal_cilc_config_2);
+		value &= ~(MIPI_CAL_SEL(0x1));
+		writel(value, &priv->mipi->mipi_cal_cilc_config_2);
+
+		/* Deselect PAD D */
+		value = readl(&priv->mipi->mipi_cal_cild_config_2);
+		value &= ~(MIPI_CAL_SEL(0x1));
+		writel(value, &priv->mipi->mipi_cal_cild_config_2);
+	}
+
+	/* Calibrate DSI-B */
+	if (calibration_pads == MIPI_DSIB_PADS) {
+		printf("Calibrating DSI-B pads\n");
+
+		value = MIPI_CAL_OVERIDE(0x0) | MIPI_CAL_SEL(0x1) |
+			MIPI_CAL_HSPDOS(0x0) | MIPI_CAL_HSPUOS(0x0) |
+			MIPI_CAL_TERMOS(0x0);
+		writel(value, &priv->mipi->mipi_cal_config_csic);
+		writel(value, &priv->mipi->mipi_cal_config_csid);
+
+		value = MIPI_CAL_SEL(0x1) |
+			MIPI_CAL_HSCLKPDOSDSI(0x1) |
+			MIPI_CAL_HSCLKPUOSDSI(0x2);
+		writel(value, &priv->mipi->mipi_cal_cilc_config_2);
+		writel(value, &priv->mipi->mipi_cal_cild_config_2);
+
+		/* Deselect PAD A */
+		value = readl(&priv->mipi->mipi_cal_dsia_config_2);
+		value &= ~(MIPI_CAL_SEL(0x1));
+		writel(value, &priv->mipi->mipi_cal_dsia_config_2);
+
+		/* Deselect PAD B */
+		value = readl(&priv->mipi->mipi_cal_dsib_config_2);
+		value &= ~(MIPI_CAL_SEL(0x1));
+		writel(value, &priv->mipi->mipi_cal_dsib_config_2);
+	}
+}
+
+static int tegra_mipi_calibrate(struct udevice *dev, int offset, const void *buf,
+				int size)
+{
+	struct tegra_mipi_priv *priv = dev_get_priv(dev);
+	u32 value;
+
+	value = MIPI_CAL_BIAS_PAD_DRV_DN_REF(0x2) |
+		MIPI_CAL_BIAS_PAD_DRV_UP_REF(0x0);
+	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg1);
+
+	value = readl(&priv->mipi->mipi_cal_bias_pad_cfg2);
+	value &= ~MIPI_CAL_BIAS_PAD_VCLAMP(0x7);
+	value &= ~MIPI_CAL_BIAS_PAD_VAUXP(0x7);
+	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg2);
+
+	switch (priv->version) {
+	case T114:
+		tegra114_mipi_pads_cal(priv, offset);
+		break;
+
+	case T124:
+		tegra124_mipi_pads_cal(priv, offset);
+		break;
+
+	default:
+		return -EINVAL;
+	}
 
 	value = readl(&priv->mipi->mipi_cal_ctrl);
 	value &= ~MIPI_CAL_CTRL_NOISE_FILTER(0xf);
@@ -134,6 +232,11 @@ static int tegra_mipi_enable(struct udevice *dev, bool val)
 	struct tegra_mipi_priv *priv = dev_get_priv(dev);
 	u32 value;
 
+	reset_set_enable(priv->mipi_cal->id, 1);
+	mdelay(100);
+	reset_set_enable(priv->mipi_cal->id, 0);
+	mdelay(1);
+
 	clk_enable(priv->mipi_cal);
 
 	value = readl(&priv->mipi->mipi_cal_bias_pad_cfg0);
@@ -157,6 +260,8 @@ static int tegra_mipi_probe(struct udevice *dev)
 {
 	struct tegra_mipi_priv *priv = dev_get_priv(dev);
 
+	priv->version = dev_get_driver_data(dev);
+
 	priv->mipi = (struct mipi_ctlr *)dev_read_addr_ptr(dev);
 	if (!priv->mipi) {
 		log_debug("%s: no MIPI controller address\n", __func__);
@@ -174,7 +279,8 @@ static int tegra_mipi_probe(struct udevice *dev)
 }
 
 static const struct udevice_id tegra_mipi_ids[] = {
-	{ .compatible = "nvidia,tegra114-mipi" },
+	{ .compatible = "nvidia,tegra114-mipi", .data = T114 },
+	{ .compatible = "nvidia,tegra124-mipi", .data = T124 },
 	{ }
 };
 
-- 
2.43.0

