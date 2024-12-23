Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE162E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 07:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C45806EB;
	Mon, 23 Dec 2024 08:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QO2x05DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC75A806D6; Mon, 23 Dec 2024 08:07:18 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DA2806D6
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 08:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d414b8af7bso7207549a12.0
 for <u-boot@lists.denx.de>; Sun, 22 Dec 2024 23:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734937636; x=1735542436; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4byK952j992+MVew8CBNuRf6o7zZlBJVQ/Hc48Ubgt4=;
 b=QO2x05DVEA2a39g0Vb2U2ujlivYw8K99mGbmljBDyeCvm3Pf715oQ/4XMEuFWd5V2S
 3CYQt6BYEDNXKGJ0CaiTFL6iakWnZippBEq+ogHQErBbzalJNeMCAF94HRWYIRoURMUh
 bLkpw95B66NnRzhG59M824FBdo/E04RD6sEzPl8eok/rIaDa7YfiKORHUfqIZr6RYPoL
 /2Nd18tvwd2JIeOY2zL3uJ8NmdCiiZkNJRCezdemjK11PR4Ncm9ujHCBSiPotd/7f6KI
 OodeUnBk7qtDaTUZoOqj77f2KBvnrrAPYhrtWijY4iFajYJeyexwvKNoGwFcR76IBpvS
 sx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734937636; x=1735542436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4byK952j992+MVew8CBNuRf6o7zZlBJVQ/Hc48Ubgt4=;
 b=JO4LWpjfWAnjUDrlYHMjJMO6Gh/efMiNKRgZSdZIE36XEZawcz+NBF5TIT4XicMMT6
 k9g8Ytkt0ibidc7yaWUcAeHKY2xvP5T5V/vJ0G8JZNixTeFk81puX+W4l0E2/fOBHGXO
 srS9mDWgGkMfg4AB6UVseSdmomx3XeCPp8dQKkr/kIKjc/iteaBAdX+pXL3/FQ5I0WU+
 DhKGRTWPJXIicmD2wuWTDFYtfMICy2SghMJSYWc4yXB+B38K2HA3Y3N3yB0trtODfRVK
 rFgKgIuvMw+ukVAicEy2ezodV90wxKDgeQp4KhXBZeOoKLptFXj+IUvZFTVepODyR+MA
 dizg==
X-Gm-Message-State: AOJu0YxybH75fq0QXX1hyun+oaaNs1Q/FIQek94LnWguwDqb2feI3BCD
 3NQ/FDxMqJ+eKlXoJgdSz4e5NX/p2PgMY1uHMJXm9Wf57Sp86LG4
X-Gm-Gg: ASbGncsRqRCYp6dNBp+2eloyKL91IIwhqNC6ZVgUefJsb8nPk0DLNDppRGQMdZDbHu4
 cpYDRrHKNcTIN2zQCtgax0r5x//WRzzbQHTeNHnSi9AefCo68wqV9VaiSxe/GVV3HjbjQBoW0zc
 4+GhiRunHizEr48IZGIzz/UC28IDn7Ol250IUdqKeyaoegmvhTNa2Zx9XbkSh7QvIv3boxa32pd
 B0KrZXFF3EdH3Zd9FYBovNoX/lnnmVRDrV+qcY7gSfC4EKD
X-Google-Smtp-Source: AGHT+IF7bMLnLhQVsNhol0rS578C/ekSgZVabIjh7YroLUGIJ7x3OKJHDuxReAkDbC89Bs8NkEo0jg==
X-Received: by 2002:a05:6402:2794:b0:5d3:d8bb:3c5c with SMTP id
 4fb4d7f45d1cf-5d81ddf3bd5mr10660982a12.12.1734937635794; 
 Sun, 22 Dec 2024 23:07:15 -0800 (PST)
Received: from xeon.. ([188.163.112.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80678c8dbsm4511895a12.40.2024.12.22.23.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 23:07:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/7] video: tegra20: mipi: add Tegra K1 support
Date: Mon, 23 Dec 2024 09:06:34 +0200
Message-ID: <20241223070638.35748-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241223070638.35748-1-clamor95@gmail.com>
References: <20241223070638.35748-1-clamor95@gmail.com>
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
index b57df6b82bf..d066ffc8b9d 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -53,6 +53,7 @@ struct tegra_dsi_priv {
 	int video_fifo_depth;
 	int host_fifo_depth;
 
+	u32 calibration_pads;
 	u32 version;
 
 	/* for ganged-mode support */
@@ -550,7 +551,7 @@ static void tegra_dsi_mipi_calibrate(struct tegra_dsi_priv *priv)
 		DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
 	writel(value, &pad->pad_ctrl_3);
 
-	ret = misc_write(priv->mipi, 0, NULL, 0);
+	ret = misc_write(priv->mipi, priv->calibration_pads, NULL, 0);
 	if (ret)
 		log_debug("%s: MIPI calibration failed %d\n", __func__, ret);
 }
@@ -1033,6 +1034,14 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
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

