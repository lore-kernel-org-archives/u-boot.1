Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BF0C021A6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 12:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FB580FA4;
	Mon, 24 Feb 2025 13:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A10ZBGl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAD280F98; Mon, 24 Feb 2025 13:02:42 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314A7805C4
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 13:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5461f2ca386so3756227e87.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740398559; x=1741003359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5JrxV8P8CLHwYnsHE9Rp6ZZCtZFCQDx2IRhhTb6pW0=;
 b=A10ZBGl+vFKmaPcadrOq2FmbEnvRROe/uOhS74+u3jqqd/0XF/XNeUMlgvjmpeOJi2
 r0q2/Kxo5aUHq+uQKLM0TBGsu55VQnnUWOrjYwZF38fpSuy9y3YuA+z4nmqlkLTDcjkJ
 z7R8my4m1vdSH6o1qiErIvM/uUMKUE9M4T7tWaGSx4cMZFS9Vfci66stRfLSxa+ZlYbz
 NxZeIdQ9Qa9bIAvHom62tHcQmbA0nmV8086H0k14f2jK06VWpLpPk6QyCbYcQq7wzQfb
 /9whJFhKF35hhpNHE/slIB4zF5QQuWQckc0i5Ueavay30pBNUHyGZGiy8kaZBwo31uiJ
 CMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740398559; x=1741003359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5JrxV8P8CLHwYnsHE9Rp6ZZCtZFCQDx2IRhhTb6pW0=;
 b=JfIV0rq0CdHwG5fPdo7hClryY31Sls1CV6CH0dDCuSXz/C+Rt2IVC5SWDY6xkxJBpR
 W4TS2N3/uGFeFENoystie7BHYmJeCdgqgvpv9+0hLXfdzx6QWnWw3TaYFVMJusasvhW0
 AQ3sglZaajTynA5dXgvU3IQTBd66apvOB7psDR+UFERcnhpDDy3rhrdml8UP51lwIfGp
 XnMIHzm3SjcBWXBHOJNqbIWTJN4/OujkHfuVkVKig6Elpy5b1HQVVCFR1oyvzUchvqkL
 1S8IHV8oekvYRecbbOg1103xO9ZPMNpYq2EaRYfViCDnY7WdJ+gyZ4wcsTSMc8533Dpc
 dFcg==
X-Gm-Message-State: AOJu0YzKxAlK6D/IxdcYf1Pwr1e5ggscd1OalbJvFsBLcQ0jMeIEzBr2
 qpnzXQfjUnN+N/WjOsu3899GgHHnmlvUNGL6/NekgzWto89HBChJ
X-Gm-Gg: ASbGnct6v0JmwoMsBFl2Xkfy7aBN/hpeqRAolJc3jw9VoZDs5C/iRCsf3/lVWm+pQIw
 XZgcbgdZ7svfhiqdyPxpizCD4zUwNUXZjc0tCubgnbTVt2ACryuCBU6pgOZiEq7mb2lcRCZPVRF
 qiIPcbisCFusXCUm5JWHh+fQgYyvSARtkhJdlyltDFkf/VoZ916KbuuJi8ZIsK7naNen2LV1tax
 dDlhA9YH0041lIFkSSYIfyxRasUxqgk1yHY1NLwUx7p3ZJtk6bUKRd591vZp2oMWbID9FvTkuLN
 l1eSR4bsfA94JpAU
X-Google-Smtp-Source: AGHT+IG41apeloxpYIEkZW8OYYrZBVu4BMoPHkepqM7q9Bi3NMYK56H4+1sIHgG+jwCXoPFXZEN/+g==
X-Received: by 2002:a05:6512:2212:b0:545:6b4:68c2 with SMTP id
 2adb3069b0e04-54839263441mr4747892e87.47.1740398559136; 
 Mon, 24 Feb 2025 04:02:39 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54838eabfd7sm987159e87.187.2025.02.24.04.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 04:02:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 3/4] video: bridge: add transparent LVDS de/encoder bridge
Date: Mon, 24 Feb 2025 14:02:13 +0200
Message-ID: <20250224120214.147646-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224120214.147646-1-clamor95@gmail.com>
References: <20250224120214.147646-1-clamor95@gmail.com>
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

Add a simple and transparent LVDS de/encoder driver with a powerdown
gpio and a power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/bridge/Kconfig      |   7 ++
 drivers/video/bridge/Makefile     |   1 +
 drivers/video/bridge/lvds-codec.c | 128 ++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/video/bridge/lvds-codec.c

diff --git a/drivers/video/bridge/Kconfig b/drivers/video/bridge/Kconfig
index ab917273720..21c5a043e02 100644
--- a/drivers/video/bridge/Kconfig
+++ b/drivers/video/bridge/Kconfig
@@ -59,3 +59,10 @@ config VIDEO_BRIDGE_TOSHIBA_TC358768
 	help
 	  Toshiba TC358768AXBG/TC358778XBG DSI bridge chip driver.
 	  Found in Asus Transformer Infinity TF700T.
+
+config VIDEO_BRIDGE_LVDS_CODEC
+	bool "Transparent LVDS encoders and decoders support"
+	depends on VIDEO_BRIDGE && PANEL && DM_GPIO
+	help
+	  Support for transparent LVDS encoders and decoders that don't
+	  require any configuration.
diff --git a/drivers/video/bridge/Makefile b/drivers/video/bridge/Makefile
index 58697e3cbe9..63dc6e62c49 100644
--- a/drivers/video/bridge/Makefile
+++ b/drivers/video/bridge/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_VIDEO_BRIDGE_NXP_PTN3460) += ptn3460.o
 obj-$(CONFIG_VIDEO_BRIDGE_ANALOGIX_ANX6345) += anx6345.o
 obj-$(CONFIG_VIDEO_BRIDGE_SOLOMON_SSD2825) += ssd2825.o
 obj-$(CONFIG_VIDEO_BRIDGE_TOSHIBA_TC358768) += tc358768.o
+obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += lvds-codec.o
diff --git a/drivers/video/bridge/lvds-codec.c b/drivers/video/bridge/lvds-codec.c
new file mode 100644
index 00000000000..6cd8368a39e
--- /dev/null
+++ b/drivers/video/bridge/lvds-codec.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ * Loosely based on Linux lvds-codec.c driver
+ */
+
+#include <dm.h>
+#include <dm/ofnode_graph.h>
+#include <log.h>
+#include <panel.h>
+#include <video_bridge.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+struct lvds_codec_priv {
+	struct udevice *panel;
+	struct display_timing timing;
+
+	struct gpio_desc powerdown_gpio;
+	struct udevice *power;
+};
+
+static int lvds_codec_attach(struct udevice *dev)
+{
+	struct lvds_codec_priv *priv = dev_get_priv(dev);
+
+	regulator_set_enable_if_allowed(priv->power, 1);
+	dm_gpio_set_value(&priv->powerdown_gpio, 0);
+
+	return panel_enable_backlight(priv->panel);
+}
+
+static int lvds_codec_set_panel(struct udevice *dev, int percent)
+{
+	struct lvds_codec_priv *priv = dev_get_priv(dev);
+
+	return panel_set_backlight(priv->panel, percent);
+}
+
+static int lvds_codec_panel_timings(struct udevice *dev,
+				    struct display_timing *timing)
+{
+	struct lvds_codec_priv *priv = dev_get_priv(dev);
+
+	memcpy(timing, &priv->timing, sizeof(*timing));
+
+	return 0;
+}
+
+/* Function is purely for sandbox testing */
+static int lvds_codec_read_edid(struct udevice *dev, u8 *buf, int buf_size)
+{
+	return 0;
+}
+
+static int lvds_codec_get_panel(struct udevice *dev)
+{
+	struct lvds_codec_priv *priv = dev_get_priv(dev);
+	int i, ret;
+
+	u32 num = ofnode_graph_get_port_count(dev_ofnode(dev));
+
+	for (i = 0; i < num; i++) {
+		ofnode remote = ofnode_graph_get_remote_node(dev_ofnode(dev), i, -1);
+
+		ret = uclass_get_device_by_of_offset(UCLASS_PANEL,
+						     ofnode_to_offset(remote),
+						     &priv->panel);
+		if (!ret)
+			return 0;
+	}
+
+	/* If this point is reached, no panels were found */
+	return -ENODEV;
+}
+
+static int lvds_codec_probe(struct udevice *dev)
+{
+	struct lvds_codec_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = lvds_codec_get_panel(dev);
+	if (ret) {
+		log_debug("%s: cannot get panel: ret=%d\n", __func__, ret);
+		return log_ret(ret);
+	}
+
+	panel_get_display_timing(priv->panel, &priv->timing);
+
+	ret = gpio_request_by_name(dev, "powerdown-gpios", 0,
+				   &priv->powerdown_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not get powerdown-gpios (%d)\n", __func__, ret);
+		if (ret != -ENOENT)
+			return log_ret(ret);
+	}
+
+	ret = device_get_supply_regulator(dev, "power-supply", &priv->power);
+	if (ret) {
+		log_debug("%s: power regulator error: %d\n", __func__, ret);
+		if (ret != -ENOENT)
+			return log_ret(ret);
+	}
+
+	return 0;
+}
+
+static const struct video_bridge_ops lvds_codec_ops = {
+	.attach			= lvds_codec_attach,
+	.set_backlight		= lvds_codec_set_panel,
+	.get_display_timing	= lvds_codec_panel_timings,
+	.read_edid		= lvds_codec_read_edid,
+};
+
+static const struct udevice_id lvds_codec_ids[] = {
+	{ .compatible = "lvds-decoder" },
+	{ .compatible = "lvds-encoder" },
+	{ }
+};
+
+U_BOOT_DRIVER(lvds_codec) = {
+	.name		= "lvds_codec",
+	.id		= UCLASS_VIDEO_BRIDGE,
+	.of_match	= lvds_codec_ids,
+	.ops		= &lvds_codec_ops,
+	.probe		= lvds_codec_probe,
+	.priv_auto	= sizeof(struct lvds_codec_priv),
+};
-- 
2.43.0

