Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21BDC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 692AB87DD6;
	Tue, 23 Jan 2024 18:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZsM8f3/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AA2687D74; Tue, 23 Jan 2024 18:17:24 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5429287DA6
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5100b424f8fso722062e87.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030233; x=1706635033; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9uiM+f8RKrxQ/0ieFSa44XbomZ7UzfBcTrhX4SYOWg=;
 b=ZsM8f3/BjnUcxMIqzWqqFAS78Np0hufzxqNo0ejh/sA+BN+fHN6i7ZcGHnVBsl4ILJ
 5IUx5cmTDVozFNwKlzrmbU/pmAT8+GYRw0KmVhCem+Ors3/uYk7UDSMUT/fl3LAvRnQh
 PZuNwltWUZSxajZG8wHv3jdigMm6Er3eRqorkRhqLwxqhkJeMZ5GBTRyNTNjzZpZ3pvs
 GzQTNDVMqYfQupvbZb1r4GhZAnFarFVtus+fvvzskhX0GwUNbY2tt8h5JXEd+eKhL6WD
 0A70K2kgkYxBeW2Cc+Fm4nsvA+0R83TCsIERNYlDSprh6ieV/JCj3DypmL/JnuDXoho1
 kFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030233; x=1706635033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9uiM+f8RKrxQ/0ieFSa44XbomZ7UzfBcTrhX4SYOWg=;
 b=wUMB6nztW5pps6PmRzacRUmJvrKmX/yDeIAWT+OxQBm7R1UMX7zsZfVyKOa1SalW9j
 jfWgKioFjjA/vrv4tEILRleeIG+7GoY/MwwmHLp1mP812gv0aU/qzgbOx2duYjl3F+wE
 5U4vwnl3TO+tic2xC8bYAzsECV9OP1mHR2ixiyyCOK56W0gGxQ4TkFS8y4rctvp1ti1a
 06LubYKTD06nqHDXGa39yLaFDs5NOyvqfN/Ffh2NlS5KrqQ3xSUDOp0Hw91EpIMWbkbm
 d4zTfxjkoeaTFKaUqkT21Hekpplj6QN9NA7hpRn3zdNOlAF1p6k6PpKYnCgRTm4CqyBI
 7S1A==
X-Gm-Message-State: AOJu0YyJQNg7Dan6fYxl038SauubJrva+LEuJ58H0m4FYOwIb4U3Zfe3
 9RIi7NCBdY7tzFuMgQ9GgyZnuN/C9lA8dzmJ7rMn6N3oYrnLyFn8rzOHjObRGwljpA==
X-Google-Smtp-Source: AGHT+IHOKYZYHnASHON9uypdEF/vyjauF4l8Az/h+qOQ3yE9AT3MwB9//S+zhIdhvBh9eHD64toxxQ==
X-Received: by 2002:a05:6512:3a8a:b0:50e:6beb:7b15 with SMTP id
 q10-20020a0565123a8a00b0050e6beb7b15mr2935390lfu.1.1706030233535; 
 Tue, 23 Jan 2024 09:17:13 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 14/18] video: tegra20: dsi: add T114 support
Date: Tue, 23 Jan 2024 19:16:29 +0200
Message-Id: <20240123171633.246057-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

Existing Tegra DSI driver mostly fits T114 apart MIPI calibration
which on T114 has dedicated driver. To resolve this MIPI calibration
logic was split for pre-T114 and T114+ devices.

Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c             | 78 ++++++++++++++++++-
 .../video/tegra20/tegra-dsi.h                 | 24 +++++-
 2 files changed, 96 insertions(+), 6 deletions(-)
 rename arch/arm/include/asm/arch-tegra30/dsi.h => drivers/video/tegra20/tegra-dsi.h (90%)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index de225ed376..25a629535e 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -20,17 +20,24 @@
 #include <asm/gpio.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
-#include <asm/arch-tegra30/dsi.h>
 
 #include "tegra-dc.h"
+#include "tegra-dsi.h"
 #include "mipi-phy.h"
 
+/* List of supported DSI bridges */
+enum {
+	DSI_V0,
+	DSI_V1,
+};
+
 struct tegra_dsi_priv {
 	struct mipi_dsi_host host;
 	struct mipi_dsi_device device;
 	struct mipi_dphy_timing dphy_timing;
 
 	struct udevice *panel;
+	struct udevice *mipi;
 	struct display_timing timing;
 
 	struct dsi_ctlr *dsi;
@@ -41,6 +48,8 @@ struct tegra_dsi_priv {
 	int dsi_clk;
 	int video_fifo_depth;
 	int host_fifo_depth;
+
+	u32 version;
 };
 
 static void tegra_dc_enable_controller(struct udevice *dev)
@@ -501,6 +510,41 @@ static void tegra_dsi_pad_calibrate(struct dsi_pad_ctrl_reg *pad)
 	writel(value, TEGRA_VI_BASE + (CSI_CIL_PAD_CONFIG << 2));
 }
 
+static void tegra_dsi_mipi_calibrate(struct tegra_dsi_priv *priv)
+{
+	struct dsi_pad_ctrl_reg *pad = &priv->dsi->pad;
+	u32 value;
+	int ret;
+
+	ret = misc_set_enabled(priv->mipi, true);
+	if (ret)
+		log_debug("%s: failed to enable MIPI calibration: %d\n",
+			  __func__, ret);
+
+	writel(0, &pad->pad_ctrl);
+	writel(0, &pad->pad_ctrl_1);
+	writel(0, &pad->pad_ctrl_2);
+	writel(0, &pad->pad_ctrl_3);
+	writel(0, &pad->pad_ctrl_4);
+
+	/* DSI pad enable */
+	value = DSI_PAD_CONTROL_VS1_PULLDN(0) | DSI_PAD_CONTROL_VS1_PDIO(0);
+	writel(value, &pad->pad_ctrl);
+
+	value = DSI_PAD_SLEW_UP(0x7) | DSI_PAD_SLEW_DN(0x7) |
+		DSI_PAD_LP_UP(0x1) | DSI_PAD_LP_DN(0x1) |
+		DSI_PAD_OUT_CLK(0x0);
+	writel(value, &pad->pad_ctrl_2);
+
+	value = DSI_PAD_PREEMP_PD_CLK(0x3) | DSI_PAD_PREEMP_PU_CLK(0x3) |
+		DSI_PAD_PREEMP_PD(0x03) | DSI_PAD_PREEMP_PU(0x3);
+	writel(value, &pad->pad_ctrl_3);
+
+	ret = misc_write(priv->mipi, 0, NULL, 0);
+	if (ret)
+		log_debug("%s: MIPI calibration failed %d\n", __func__, ret);
+}
+
 static void tegra_dsi_set_timeout(struct dsi_timeout_reg *rtimeout,
 				  unsigned long bclk,
 				  unsigned int vrefresh)
@@ -664,10 +708,25 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	u32 value;
 	int ret;
 
+	/* If for some reasone DSI is enabled then it needs to
+	 * be disabled in order for the panel initialization
+	 * commands to be properly sent.
+	 */
+	value = readl(&misc->dsi_pwr_ctrl);
+
+	if (value & DSI_POWER_CONTROL_ENABLE) {
+		value = readl(&misc->dsi_pwr_ctrl);
+		value &= ~DSI_POWER_CONTROL_ENABLE;
+		writel(value, &misc->dsi_pwr_ctrl);
+	}
+
 	/* Disable interrupt */
 	writel(0, &misc->int_enable);
 
-	tegra_dsi_pad_calibrate(&priv->dsi->pad);
+	if (priv->version)
+		tegra_dsi_mipi_calibrate(priv);
+	else
+		tegra_dsi_pad_calibrate(&priv->dsi->pad);
 
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
 
@@ -806,6 +865,8 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 	struct mipi_dsi_panel_plat *mipi_plat;
 	int ret;
 
+	priv->version = dev_get_driver_data(dev);
+
 	priv->dsi = (struct dsi_ctlr *)dev_read_addr_ptr(dev);
 	if (!priv->dsi) {
 		printf("%s: No display controller address\n", __func__);
@@ -828,6 +889,16 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return log_ret(ret);
 	}
 
+	if (priv->version) {
+		ret = uclass_get_device_by_phandle(UCLASS_MISC, dev,
+						   "nvidia,mipi-calibrate",
+						   &priv->mipi);
+		if (ret) {
+			log_debug("%s: cannot get MIPI: error %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
 	panel_get_display_timing(priv->panel, &priv->timing);
 
 	mipi_plat = dev_get_plat(priv->panel);
@@ -859,7 +930,8 @@ static const struct panel_ops tegra_dsi_bridge_ops = {
 };
 
 static const struct udevice_id tegra_dsi_bridge_ids[] = {
-	{ .compatible = "nvidia,tegra30-dsi" },
+	{ .compatible = "nvidia,tegra30-dsi", .data = DSI_V0 },
+	{ .compatible = "nvidia,tegra114-dsi", .data = DSI_V1 },
 	{ }
 };
 
diff --git a/arch/arm/include/asm/arch-tegra30/dsi.h b/drivers/video/tegra20/tegra-dsi.h
similarity index 90%
rename from arch/arm/include/asm/arch-tegra30/dsi.h
rename to drivers/video/tegra20/tegra-dsi.h
index 7ade132613..69dac4bd1b 100644
--- a/arch/arm/include/asm/arch-tegra30/dsi.h
+++ b/drivers/video/tegra20/tegra-dsi.h
@@ -4,8 +4,8 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#ifndef __ASM_ARCH_TEGRA_DSI_H
-#define __ASM_ARCH_TEGRA_DSI_H
+#ifndef _TEGRA_DSI_H
+#define _TEGRA_DSI_H
 
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
@@ -105,6 +105,10 @@ struct dsi_pad_ctrl_reg {
 	uint pad_ctrl_cd;		/* _PAD_CONTROL_CD_0 */
 	uint pad_cd_status;		/* _PAD_CD_STATUS_0 */
 	uint dsi_vid_mode_control;	/* _DSI_VID_MODE_CONTROL_0 */
+	uint pad_ctrl_1;		/* _PAD_CONTROL_1 */
+	uint pad_ctrl_2;		/* _PAD_CONTROL_2 */
+	uint pad_ctrl_3;		/* _PAD_CONTROL_3 */
+	uint pad_ctrl_4;		/* _PAD_CONTROL_4 */
 };
 
 /* Display Serial Interface (DSI_) regs */
@@ -184,6 +188,20 @@ struct dsi_ctlr {
 #define DSI_PAD_CONTROL_PAD_LPUPADJ(x)		(((x) & 0x3) << 14)
 #define DSI_PAD_CONTROL_PAD_LPDNADJ(x)		(((x) & 0x3) << 12)
 
+#define DSI_PAD_CONTROL_VS1_PDIO(x)	(((x) & 0xf) <<  0)
+#define DSI_PAD_CONTROL_VS1_PULLDN(x)	(((x) & 0xf) << 16)
+
+#define DSI_PAD_OUT_CLK(x)		(((x) & 0x7) <<  0)
+#define DSI_PAD_LP_DN(x)		(((x) & 0x7) <<  4)
+#define DSI_PAD_LP_UP(x)		(((x) & 0x7) <<  8)
+#define DSI_PAD_SLEW_DN(x)		(((x) & 0x7) << 12)
+#define DSI_PAD_SLEW_UP(x)		(((x) & 0x7) << 16)
+
+#define DSI_PAD_PREEMP_PD_CLK(x)	(((x) & 0x3) << 12)
+#define DSI_PAD_PREEMP_PU_CLK(x)	(((x) & 0x3) << 8)
+#define DSI_PAD_PREEMP_PD(x)		(((x) & 0x3) << 4)
+#define DSI_PAD_PREEMP_PU(x)		(((x) & 0x3) << 0)
+
 /*
  * pixel format as used in the DSI_CONTROL_FORMAT field
  */
@@ -214,4 +232,4 @@ enum tegra_dsi_format {
 #define  PAD_DRIV_DN_REF(x)		(((x) & 0x7) << 16)
 #define  PAD_DRIV_UP_REF(x)		(((x) & 0x7) << 8)
 
-#endif /* __ASM_ARCH_TEGRA_DSI_H */
+#endif /* _TEGRA_DSI_H */
-- 
2.40.1

