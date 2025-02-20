Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C7C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EC8680F53;
	Thu, 20 Feb 2025 18:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FuNDoERN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 966E980F92; Thu, 20 Feb 2025 18:06:59 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77D9480F53
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-543e4bbcd86so1355307e87.1
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740071217; x=1740676017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5JrxV8P8CLHwYnsHE9Rp6ZZCtZFCQDx2IRhhTb6pW0=;
 b=FuNDoERNUBam2r6WRDIGfvYY0VCNhB0bHs95w7Blbi5ItnqVkzbqaha3x4EfzEOQ8G
 4TxWmNuRglCJndDo3mrp92JBIRE17Elyy+tY0HwNHLVGy1FGZidO5WDpG5XreCOifuhN
 uXvS05YsiG0eosj2Gp6nAxPKpWrwK5tc+tVlfb5OudirWqfpmGAk1IeX/NGIXn620/ph
 v7ij33RWZMp510rc/7UiSL2hzgGp9uZ59Ele8Lzteduw+w99EiiAQ/S3hWPhCEMOItsA
 paDwXfO739tQOf20s+0wqve2XzCjZlgWHPxKKG25bNA1XqYBkwlcwFGxaXkRLi+uX9dl
 sv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071217; x=1740676017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5JrxV8P8CLHwYnsHE9Rp6ZZCtZFCQDx2IRhhTb6pW0=;
 b=juA/5c/B5n4iQsYqgjoPD+mTNun178QYeMUZ3RGsQOhHVYhtsWLuJ+cEx6yEflOU4K
 2PvpCwcer2WY3UWE6Lb+CMIgfm2Dzzv+uTYvk43p9L3dX+ZhMp8dm18o3zxZ7ouXQf3/
 /Ya/L9FOpc+WYYVvXK7nCxvsqFsKODrd40sJZfEQMHK9wgaN7EbIEKxhL0SnXS0TDkPZ
 +3OxY2/Tekx7nfWY8OQyx4Ma3l7aNiPKncskYvGuHYxB0osHWqBsvc1wIeyuTnxDrVzr
 UfAUqm8s1rlpfN58XvFsjeyyXZeN5OxUp1W83xY/eFpKRVSblPdBzVxZmCMvv/XZW90f
 2dFw==
X-Gm-Message-State: AOJu0Yyp+7bfE1OR4zWe6RBjS4hH9FJH5lXUZ72/VEkqCClKjLwt4eu1
 cmgFh0XxWFwsQFniscfmJNcwD0qrzVmeGAVyBv4voQnrjGhYh3hz
X-Gm-Gg: ASbGncucR6fcfSRPeD4NyZrlNvvgQb/oa2OQOHJwuK5JL/qFpAPsmkmeh5ciNLljaI4
 bRye3RQSDSjo13PSgB33HEcrOLSjbdQGEWB+jQUhEojYC6YcZASsBRk8HpP+Wyzx78IXA42G+Sy
 A7NHoE0Ucwguy+RzNII45nsTHwMGLfa4VruMdzfnWtKjvHgfvOm4zLnpL3XqSLKP1eAo0VIyoeS
 z+m2iaeW/9ywThSdBONSKIcJ8zItmcAtbHC1yrdo3LtgdTrBSSRbDZEnYWyRT8iAYZgTV4rxpvx
 0caXs24=
X-Google-Smtp-Source: AGHT+IGM2YrKWnreSkrRQpWZ+FXMtBbhzS2p+kK+BqUypPbIE7ybj9J9x/ILy9qfmaswzVUn8TSxFg==
X-Received: by 2002:a05:6512:e94:b0:545:d54:2ec6 with SMTP id
 2adb3069b0e04-5462eedb519mr3177840e87.2.1740071216394; 
 Thu, 20 Feb 2025 09:06:56 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-547df6106f6sm81828e87.204.2025.02.20.09.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:06:55 -0800 (PST)
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
Subject: [PATCH v2 2/3] video: bridge: add transparent LVDS de/encoder bridge
Date: Thu, 20 Feb 2025 19:06:28 +0200
Message-ID: <20250220170629.228485-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220170629.228485-1-clamor95@gmail.com>
References: <20250220170629.228485-1-clamor95@gmail.com>
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

