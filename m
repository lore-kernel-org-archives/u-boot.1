Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD15FC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBD987B82;
	Wed, 17 Jan 2024 18:17:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bqBlyLvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B62087B9B; Wed, 17 Jan 2024 18:17:32 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CBB1879F7
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e741123acso13955602e87.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511848; x=1706116648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXOgRnSofkv/Njfu3qoE2KZG7UQG2XPkPVhPpkOxYeU=;
 b=bqBlyLvGD/KbBtzX5u5cO6RIkcamG/jL6ZoVEJSSAEG8N/4volYmroV5v9wl95KO1a
 sP5n5F/TEMFIVT3Ub71Bi6r5AEsv4/s9gdluuJhVzMVZLFGVpescvNzzNTpQyAwma4QO
 +leIqMWZNPDK+swLV9Eqj4TRggN+2xyAcYiH0dFWBqkfce/R+ffhog+c0gQ2RfYSAn4F
 1NKKxMoVXak/Ug+Vf3sScxTK0Db1/T9zxdGwn9BQ4oUgfiJxcK+aT2gBGbbvSnBQJXg7
 CFdiUfppGYZvufMueFH0PDUPQZ1HPz/esK9gnLdctxB7+ePPTM4OfqA9An7WOHlWqSJe
 E2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511848; x=1706116648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXOgRnSofkv/Njfu3qoE2KZG7UQG2XPkPVhPpkOxYeU=;
 b=QcXJhdElp9Bh7AuWhwHhAbFMYVnhV+iq1p3yHLVUy7o4VgSxtkzESS2iJk4Coh4Pai
 EzoLmQELreLxppPeC81Pqmg2vs58a7s6lD7KCo+Dt1BW2W0s9GDPlFDTa6SGPL3wHx41
 lHcd/ylNRx63qukwBZrWcf/qNadrka/4/x/gsR99PAGnK2IuJqscDxj1O1gDTm5aERkt
 RN5Up4toZw6nm80yhJoQ0rAlT+CntrseP/KZKwxemhh8eFZOaEX2G4hNnm4DzZQZtc73
 z35/hO4JKEGtUN9nvbi9GNLtaKIP8N/F/zfeUnuLrs5atc8ZvONQN5z1gYMx0Jzf8Xse
 TxXw==
X-Gm-Message-State: AOJu0YwfGJX7Ua+djDN74CF+/hkrzQzL8IoMa5XWzKURK3/g17PilSli
 41/WxksWsZqDobZfR5FnOBo=
X-Google-Smtp-Source: AGHT+IEJKQm9IMbsQ3FcHc4FjMgss+jT58KqutVfzTfWlE/uzxRCBbN9R2e1mL+Tju3KUJ90wvtyqw==
X-Received: by 2002:a05:6512:1055:b0:50e:7f88:f541 with SMTP id
 c21-20020a056512105500b0050e7f88f541mr5796641lfb.16.1705511848108; 
 Wed, 17 Jan 2024 09:17:28 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 09/13] video: tegra20: add MIPI calibration driver
Date: Wed, 17 Jan 2024 19:16:54 +0200
Message-Id: <20240117171658.22324-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

Dedicated MIPI calibration driver is used on T114 and newer. Before
T114 MIPI calibration registers were part of VI and CSI.

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/Makefile     |   2 +-
 drivers/video/tegra20/tegra-mipi.c | 188 +++++++++++++++++++++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 drivers/video/tegra20/tegra-mipi.c

diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra20/Makefile
index f0b534c579..a75aea2a87 100644
--- a/drivers/video/tegra20/Makefile
+++ b/drivers/video/tegra20/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_VIDEO_TEGRA20) += tegra-dc.o
-obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o mipi-phy.o
+obj-$(CONFIG_VIDEO_DSI_TEGRA30) += tegra-dsi.o tegra-mipi.o mipi-phy.o
 obj-$(CONFIG_TEGRA_BACKLIGHT_PWM) += tegra-pwm-backlight.o
diff --git a/drivers/video/tegra20/tegra-mipi.c b/drivers/video/tegra20/tegra-mipi.c
new file mode 100644
index 0000000000..2df3c1a994
--- /dev/null
+++ b/drivers/video/tegra20/tegra-mipi.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (c) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <clk.h>
+#include <misc.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include <asm/io.h>
+
+/* MIPI control registers 0x00 ~ 0x60 */
+struct mipi_ctlr {
+	uint mipi_cal_ctrl;
+	uint mipi_cal_autocal_ctrl;
+	uint mipi_cal_status;
+
+	uint unused1[2];
+
+	uint mipi_cal_config_csia;
+	uint mipi_cal_config_csib;
+	uint mipi_cal_config_csic;
+	uint mipi_cal_config_csid;
+	uint mipi_cal_config_csie;
+
+	uint unused2[4];
+
+	uint mipi_cal_config_dsia;
+	uint mipi_cal_config_dsib;
+	uint mipi_cal_config_dsic;
+	uint mipi_cal_config_dsid;
+
+	uint unused3[4];
+
+	uint mipi_cal_bias_pad_cfg0;
+	uint mipi_cal_bias_pad_cfg1;
+	uint mipi_cal_bias_pad_cfg2;
+};
+
+#define MIPI_CAL_CTRL_NOISE_FILTER(x)	(((x) & 0xf) << 26)
+#define MIPI_CAL_CTRL_PRESCALE(x)	(((x) & 0x3) << 24)
+#define MIPI_CAL_CTRL_CLKEN_OVR		BIT(4)
+#define MIPI_CAL_CTRL_START		BIT(0)
+
+#define MIPI_CAL_STATUS_DONE		BIT(16)
+#define MIPI_CAL_STATUS_ACTIVE		BIT(0)
+
+#define MIPI_CAL_OVERIDE(x)		(((x) & 0x1) << 30)
+#define MIPI_CAL_SEL(x)			(((x) & 0x1) << 21)
+#define MIPI_CAL_HSPDOS(x)		(((x) & 0x1f) << 16)
+#define MIPI_CAL_HSPUOS(x)		(((x) & 0x1f) << 8)
+#define MIPI_CAL_TERMOS(x)		(((x) & 0x1f) << 0)
+
+#define MIPI_CAL_BIAS_PAD_PDVCLAMP	BIT(1)
+#define MIPI_CAL_BIAS_PAD_E_VCLAMP_REF	BIT(0)
+
+#define MIPI_CAL_BIAS_PAD_DRV_DN_REF(x) (((x) & 0x7) << 16)
+#define MIPI_CAL_BIAS_PAD_DRV_UP_REF(x) (((x) & 0x7) << 8)
+
+#define MIPI_CAL_BIAS_PAD_VCLAMP(x)	(((x) & 0x7) << 16)
+#define MIPI_CAL_BIAS_PAD_VAUXP(x)	(((x) & 0x7) << 4)
+#define MIPI_CAL_BIAS_PAD_PDVREG	BIT(1)
+
+struct tegra_mipi_priv {
+	struct mipi_ctlr	*mipi;
+	struct clk		*mipi_cal;
+};
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
+	value = MIPI_CAL_OVERIDE(0x0) | MIPI_CAL_SEL(0x1) |
+		MIPI_CAL_HSPDOS(0x0) | MIPI_CAL_HSPUOS(0x4) |
+		MIPI_CAL_TERMOS(0x5);
+	writel(value, &priv->mipi->mipi_cal_config_dsia);
+	writel(value, &priv->mipi->mipi_cal_config_dsib);
+
+	/* Deselect PAD C */
+	value = readl(&priv->mipi->mipi_cal_config_dsic);
+	value &= ~(MIPI_CAL_SEL(0x1));
+	writel(value, &priv->mipi->mipi_cal_config_dsic);
+
+	/* Deselect PAD D */
+	value = readl(&priv->mipi->mipi_cal_config_dsid);
+	value &= ~(MIPI_CAL_SEL(0x1));
+	writel(value, &priv->mipi->mipi_cal_config_dsid);
+
+	value = readl(&priv->mipi->mipi_cal_ctrl);
+	value &= ~MIPI_CAL_CTRL_NOISE_FILTER(0xf);
+	value &= ~MIPI_CAL_CTRL_PRESCALE(0x3);
+	value |= MIPI_CAL_CTRL_NOISE_FILTER(0xa) |
+		 MIPI_CAL_CTRL_PRESCALE(0x2) |
+		 MIPI_CAL_CTRL_CLKEN_OVR;
+	writel(value, &priv->mipi->mipi_cal_ctrl);
+
+	/* clear any pending status bits */
+	value = readl(&priv->mipi->mipi_cal_status);
+	writel(value, &priv->mipi->mipi_cal_status);
+
+	value = readl(&priv->mipi->mipi_cal_ctrl);
+	value |= MIPI_CAL_CTRL_START;
+	writel(value, &priv->mipi->mipi_cal_ctrl);
+
+	/*
+	 * Wait for min 72uS to let calibration logic finish calibration
+	 * sequence codes before waiting for pads idle state to apply the
+	 * results.
+	 */
+	udelay(80);
+
+	return readl_poll_sleep_timeout(&priv->mipi->mipi_cal_status, value,
+					!(value & MIPI_CAL_STATUS_ACTIVE) &&
+					(value & MIPI_CAL_STATUS_DONE), 100,
+					250000);
+}
+
+static int tegra_mipi_enable(struct udevice *dev, bool val)
+{
+	struct tegra_mipi_priv *priv = dev_get_priv(dev);
+	u32 value;
+
+	clk_enable(priv->mipi_cal);
+
+	value = readl(&priv->mipi->mipi_cal_bias_pad_cfg0);
+	value &= ~MIPI_CAL_BIAS_PAD_PDVCLAMP;
+	value |= MIPI_CAL_BIAS_PAD_E_VCLAMP_REF;
+	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg0);
+
+	value = readl(&priv->mipi->mipi_cal_bias_pad_cfg2);
+	value &= ~MIPI_CAL_BIAS_PAD_PDVREG;
+	writel(value, &priv->mipi->mipi_cal_bias_pad_cfg2);
+
+	return 0;
+}
+
+static const struct misc_ops tegra_mipi_ops = {
+	.write = tegra_mipi_calibrate,
+	.set_enabled = tegra_mipi_enable,
+};
+
+static int tegra_mipi_probe(struct udevice *dev)
+{
+	struct tegra_mipi_priv *priv = dev_get_priv(dev);
+
+	priv->mipi = (struct mipi_ctlr *)dev_read_addr_ptr(dev);
+	if (!priv->mipi) {
+		log_debug("%s: no MIPI controller address\n", __func__);
+		return -EINVAL;
+	}
+
+	priv->mipi_cal = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->mipi_cal)) {
+		log_debug("%s: Could not get MIPI clock: %ld\n",
+			  __func__, PTR_ERR(priv->mipi_cal));
+		return PTR_ERR(priv->mipi_cal);
+	}
+
+	return 0;
+}
+
+static const struct udevice_id tegra_mipi_ids[] = {
+	{ .compatible = "nvidia,tegra114-mipi" },
+	{ }
+};
+
+U_BOOT_DRIVER(tegra_mipi) = {
+	.name           = "tegra_mipi",
+	.id             = UCLASS_MISC,
+	.ops		= &tegra_mipi_ops,
+	.of_match       = tegra_mipi_ids,
+	.probe          = tegra_mipi_probe,
+	.priv_auto	= sizeof(struct tegra_mipi_priv),
+};
-- 
2.40.1

