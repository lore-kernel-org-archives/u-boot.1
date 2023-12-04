Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF8C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262B4870A0;
	Mon,  4 Dec 2023 09:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JywCEGrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17EEA878C6; Mon,  4 Dec 2023 09:02:53 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C79870A0
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50bc21821a1so5569876e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701676969; x=1702281769; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L89b+plYZJcUhRZWPJD4O7j9IlivpvwUocRgpIseF6U=;
 b=JywCEGrIdaOsxAyQbCxd900elfF6Zpw74LSMTK24NBnwUQRHYXfcm+2zZbI1Ebuage
 HpWsM3sQvCRN/rfyeRINUU8amq+CQ34m7p99CzB3ZR9q+pTOf/B/9/1XtgL6dxSEmf6F
 1AQ+c4lOArRElp6V/sg/FSr+IEVCQnyPQiqDhbXrr/lS8wJytOkKgi50/u//uJ2f6G6q
 6ve2i3v0VleRxbD9k1xSR66PeS1PRi+3Jcui+PusWbPBP6Hua+yv6QkRJcffA3/NovqC
 g/h72ZiFmd+uA1I9UFGHcF4glZL+H5Qut5L42xCKhy7NnQiAAv3HOB8IeFqKQ+XdvpaM
 UT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701676969; x=1702281769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L89b+plYZJcUhRZWPJD4O7j9IlivpvwUocRgpIseF6U=;
 b=AlvfTlxvT635EZNpfm8F00VK/LKaHYDO+UyQT+pKTXLPu2xlBD6WUqKfFmaqLWzXHu
 FR4hwVk+0iGeEoN73pP/sNwAdVg93BHZXyIe2ohY5kam3eQDkaGt7dHJV+mBkqn6ZmZ5
 o67DbrmV9GJm/gkMGtY82ZUlM264qDplJHE8QbOebP0AeGoZ7WcMNVM2uP7/hLdmhDge
 pl91JSW4K8cHWeqpgH8Xc4pTT/hds1L581bpv3qnt1Bz57W8UmbpTkcU7+DF+8ctLyQf
 jJ1d9RqO4gO1ou/Pfh+MffLodOfViLPUBBgjiGY0eVK3HGQ7q903AdVoyHUtWjHB35jw
 sMSA==
X-Gm-Message-State: AOJu0YyAvoTLGN6O0zNMxCkSvGGFvLPMQvjSdGpHEcukhu+NykSOvlMn
 lCrOrWr9kUt5KXkc8Nvr3AirpCFXTWI=
X-Google-Smtp-Source: AGHT+IEiTnyfUZJiKgn1Wc4JzJRuAp+tPC/MYwSdEaeu//uZkfokU0XQZ3guwtI3QsbasPaTpGmHeQ==
X-Received: by 2002:a05:6512:3119:b0:50b:f168:976d with SMTP id
 n25-20020a056512311900b0050bf168976dmr700173lfb.37.1701676968950; 
 Mon, 04 Dec 2023 00:02:48 -0800 (PST)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 v6-20020ac25606000000b0050572fcf1a2sm1183048lfd.283.2023.12.04.00.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:02:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] video: tegra20: add MIPI calibration driver
Date: Mon,  4 Dec 2023 10:02:30 +0200
Message-Id: <20231204080231.4316-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204080231.4316-1-clamor95@gmail.com>
References: <20231204080231.4316-1-clamor95@gmail.com>
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

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/Makefile     |   2 +-
 drivers/video/tegra20/tegra-mipi.c | 185 +++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)
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
index 0000000000..52e5ea0ff6
--- /dev/null
+++ b/drivers/video/tegra20/tegra-mipi.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2013 NVIDIA Corporation
+ * Copyright (c) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <misc.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include <asm/io.h>
+#include <asm/arch/clock.h>
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
+	struct mipi_ctlr *mipi;
+	int mipi_clk;
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
+	clock_enable(priv->mipi_clk);
+	udelay(2);
+	reset_set_enable(priv->mipi_clk, 0);
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
+		log_err("no MIPI controller address\n");
+		return -EINVAL;
+	}
+
+	priv->mipi_clk = clock_decode_periph_id(dev);
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

