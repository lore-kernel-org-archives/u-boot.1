Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF0C47DAF
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF4387EED;
	Sat, 20 Jan 2024 17:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LPs3UDUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B1287EFC; Sat, 20 Jan 2024 17:56:26 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAD187E67
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a2cad931c50so183490366b.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769781; x=1706374581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXOgRnSofkv/Njfu3qoE2KZG7UQG2XPkPVhPpkOxYeU=;
 b=LPs3UDUgTLv7RDCXMi0kRYeqZFd8F6kEgk4DcKwm/wpgakBdk4k90g6bMk7J3FCGaN
 jKJb9GGZaP/O6qEs14bxxBjLgbgUu5kz/UdloYLuL3hgJ/V1fRKlMNUS+9IgnFf1VGLc
 pennkIIP+gMsBPbpRakHrJfhZ3X25Z8ShzLMtWDfvorzqtGe+rN7uds6Dad0wvoMsoXZ
 226VWJFjtEQNtCSFRwXWFJHZ4tn41HupYNlng0KrZAw9FmJh5EiRBtpL3VSSqC3seeb1
 CSIGud2zuLaNb/MrAVrf88HfIo+O2cGBTAlSwEhDFQLzb2iT5z4Vwq3iJ7rENshKcIH8
 ngLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769781; x=1706374581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXOgRnSofkv/Njfu3qoE2KZG7UQG2XPkPVhPpkOxYeU=;
 b=PvXsL/+HBT4RlfysIVMB2ZUS3DWU2XpZNMNFPVX4TFAQDccaKqxkM8tEnsRky3hwz/
 fhfBaPSDqOs78DriwJhuMT7nEt2caWwoOfu4xVhgsvqL5oPksIj/v5KDVE2sr0k19u9w
 goUNfnGAX0/kEK3X7bfrgVOf5qJvKBQ1QrQdrk5PIMiBOt8UlFoUYI7daVyZ+Qc20X0N
 bTy9QxRhFcUqbfYDw6Q2+yZHUAHItAzTQU3t+FFjpi9unkHnO7MbFbCs+qFkdRzgVbpT
 KHPmxFRLdXN8OJHz8sTc2Drt7huusg4FS9lBhtk7lF5RPQaah4FkOoHjFjf1FegyVvS0
 TxUQ==
X-Gm-Message-State: AOJu0YzvtlE57W+pgeP66Mge9G6QEQFojLUeIffcu+GU8wSyTEiD4LWt
 C9LrUJcnDDE3Kzs+Yl/qW7xomD9vLzzrxyXtx34Uk2fes8xt+Qvw
X-Google-Smtp-Source: AGHT+IGCbqiJIhRjPas5GMNTMbCTsQIjqAxgaq6XfGVPzfFeDsJsqmug1zia/Vua2UFI7dB6Gzv61w==
X-Received: by 2002:a17:906:bcc7:b0:a2c:2323:34c0 with SMTP id
 lw7-20020a170906bcc700b00a2c232334c0mr763628ejb.32.1705769781080; 
 Sat, 20 Jan 2024 08:56:21 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:20 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 09/13] video: tegra20: add MIPI calibration driver
Date: Sat, 20 Jan 2024 18:55:39 +0200
Message-Id: <20240120165543.10226-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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

