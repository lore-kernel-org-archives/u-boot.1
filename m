Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5B3C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DBFA87DA0;
	Tue, 23 Jan 2024 18:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FKPX5H+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC7787DEC; Tue, 23 Jan 2024 18:40:32 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF2A87BBC
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a30b2f032b1so188252266b.0
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706031628; x=1706636428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGR8ictgxW5r/D8M2esRO7fnajcFEX/FnUfXIR2EzDo=;
 b=FKPX5H+O+zu4eHP8xrI3Yv4TnEkHBBk4BpdXhGUWUQT++ARNjRj9kFT/ZoS3jHqsMK
 sHiyQF0QyBljW89LkUpL5NyuROORUrG/8Sp8f6Xc5k0zD96qqNr5CVswY1XZehCqAyqe
 K5MdL43E8YNYIxo+JnHITe4ORcC3IHOqqk7EoAoQOiOYEPBWzqS1sdXIhLCN6CvqbE+G
 6Q0zFXinVtjqefB/1NZOz3uBSpvNJriprIbSw8Clq4BYGp9wDp7KWztwvrhRh2JriS7c
 g1tKIRBVcClOKuPT97jQOqXrcLuK4On2B//8c7kor2LKC6YrwZ5t66R3/4Xbi6gs8uSc
 1gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706031628; x=1706636428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGR8ictgxW5r/D8M2esRO7fnajcFEX/FnUfXIR2EzDo=;
 b=HrI0hYHtKBxyj9DMsoVjqTqcI11OmwyZ3zPd48oGmIgMJMUHkS6T3RFx++BiL34TO3
 NC4ysgP9AFrQJuLQMzCc0ZeiEQd0utGECVcFZXVcx6RASZz4qC6JgVW6hW1DqM6cV6Ai
 3T/G+oaRC6aB++yfx4dB0upq//FIGQQqfgr4mtJNDwG4+VvAfSE/OgPh/u3A6j79jTpT
 juNoXYzAm+CyRlM8hb8ILs0MkccYFyqWrdr4WovPqodt03ZVqERE59ntQjRryflga/bX
 yr0fuuLR0/Ekrb+YyQpUKrLQY2p0XOOMj7QNyWoqB5rfMooUDuhGX7am/zeX0zENAd/J
 DZFg==
X-Gm-Message-State: AOJu0YxqtRbjQRtNLdTWZoVoF7JLpmyA1jSJR31YTBhiCyZtc1zQNOM5
 sERUg1LNnDFPB81pH9/ORM/eFFbZU42Wfo9lC0ak72j235Bc6Ye4jqV3GTgtVqLK0Q==
X-Google-Smtp-Source: AGHT+IHt9JK4xO5AF3S69W/wNfaKKB8+cSERjsyozy2EgfeOgiPx2LDqWemjAj2Om5mTD6jG80Yhow==
X-Received: by 2002:a17:907:781a:b0:a2f:163c:5d54 with SMTP id
 la26-20020a170907781a00b00a2f163c5d54mr176656ejc.1.1706031628130; 
 Tue, 23 Jan 2024 09:40:28 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 q25-20020a056402041900b0055c104274e7sm3526286edv.78.2024.01.23.09.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:40:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anton Bambura <jenneron@protonmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] video: panel: add Samsung LTL106HL02 MIPI DSI panel
 driver
Date: Tue, 23 Jan 2024 19:40:06 +0200
Message-Id: <20240123174009.247414-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123174009.247414-1-clamor95@gmail.com>
References: <20240123174009.247414-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Anton Bambura <jenneron@protonmail.com>

LTL106HL02 is a color active matrix TFT (Thin Film Transistor)
liquid crystal display (LCD) that uses amorphous silicon TFT as
switching devices. This model is composed of a TFT LCD panel, a
driver circuit and a backlight unit. The resolution of a 10.6"
contains 1920 x 1080 pixels and can display up to 16,8M color
with wide viewing angle.

Co-developed-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Anton Bambura <jenneron@protonmail.com>
---
 drivers/video/Kconfig              |   9 ++
 drivers/video/Makefile             |   1 +
 drivers/video/samsung-ltl106hl02.c | 157 +++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/video/samsung-ltl106hl02.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 05567a0095..52b515197d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -555,6 +555,15 @@ config VIDEO_LCD_RENESAS_R69328
 	  IPS-LCD module with Renesas R69328 IC. The panel has a 720x1280
 	  resolution and uses 24 bit RGB per pixel.
 
+config VIDEO_LCD_SAMSUNG_LTL106HL02
+	tristate "Samsung LTL106HL02 1920x1080 DSI video mode panel"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for Samsung LTL106HL02
+	  LCD module found in Microsoft Surface 2. The panel has a FullHD
+	  resolution (1920x1080).
+
 config VIDEO_LCD_SSD2828
 	bool "SSD2828 bridge chip"
 	---help---
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index bb6d9b74b9..f3f70cd04a 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_VIDEO_LCD_ORISETECH_OTM8009A) += orisetech_otm8009a.o
 obj-$(CONFIG_VIDEO_LCD_RAYDIUM_RM68200) += raydium-rm68200.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R61307) += renesas-r61307.o
 obj-$(CONFIG_VIDEO_LCD_RENESAS_R69328) += renesas-r69328.o
+obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
diff --git a/drivers/video/samsung-ltl106hl02.c b/drivers/video/samsung-ltl106hl02.c
new file mode 100644
index 0000000000..5e6c11c4be
--- /dev/null
+++ b/drivers/video/samsung-ltl106hl02.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Samsung LTL106HL02-001 DSI panel driver
+ *
+ * Copyright (c) 2020 Anton Bambura <jenneron@protonmail.com>
+ * Copyright (c) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
+ * Copyright (c) 2024 Jonas Schwöbel <jonasschwoebel@yahoo.de>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <log.h>
+#include <mipi_dsi.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+struct samsung_ltl106hl02_priv {
+	struct udevice *vdd;
+	struct udevice *backlight;
+
+	struct gpio_desc reset_gpio;
+};
+
+static struct display_timing default_timing = {
+	.pixelclock.typ		= 137000000,
+	.hactive.typ		= 1920,
+	.hfront_porch.typ	= 32,
+	.hback_porch.typ	= 64,
+	.hsync_len.typ		= 32,
+	.vactive.typ		= 1080,
+	.vfront_porch.typ	= 2,
+	.vback_porch.typ	= 26,
+	.vsync_len.typ		= 3,
+};
+
+static int samsung_ltl106hl02_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to exit sleep mode: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(70);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		log_debug("%s: failed to enable display: %d\n",
+			  __func__, ret);
+		return ret;
+	}
+	mdelay(5);
+
+	return 0;
+}
+
+static int samsung_ltl106hl02_set_backlight(struct udevice *dev, int percent)
+{
+	struct samsung_ltl106hl02_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return backlight_set_brightness(priv->backlight, percent);
+}
+
+static int samsung_ltl106hl02_timings(struct udevice *dev,
+				      struct display_timing *timing)
+{
+	memcpy(timing, &default_timing, sizeof(*timing));
+	return 0;
+}
+
+static int samsung_ltl106hl02_of_to_plat(struct udevice *dev)
+{
+	struct samsung_ltl106hl02_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		log_debug("%s: cannot get backlight: ret = %d\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_REGULATOR, dev,
+					   "vdd-supply", &priv->vdd);
+	if (ret)
+		log_debug("%s: cannot get vdd-supply: error %d\n",
+			  __func__, ret);
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio, GPIOD_IS_OUT);
+	if (ret)
+		log_debug("%s: cannot get reset-gpios: error %d\n",
+			  __func__, ret);
+
+	return 0;
+}
+
+static int samsung_ltl106hl02_hw_init(struct udevice *dev)
+{
+	struct samsung_ltl106hl02_priv *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->reset_gpio, 1);
+	regulator_set_enable_if_allowed(priv->vdd, 1);
+
+	/* Dataheets states at least 8.5 msec for vdd stabilization */
+	mdelay(10);
+
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+
+	return 0;
+}
+
+static int samsung_ltl106hl02_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO;
+
+	return samsung_ltl106hl02_hw_init(dev);
+}
+
+static const struct panel_ops samsung_ltl106hl02_ops = {
+	.enable_backlight	= samsung_ltl106hl02_enable_backlight,
+	.set_backlight		= samsung_ltl106hl02_set_backlight,
+	.get_display_timing	= samsung_ltl106hl02_timings,
+};
+
+static const struct udevice_id samsung_ltl106hl02_ids[] = {
+	{ .compatible = "samsung,ltl106hl02-001" },
+	{ }
+};
+
+U_BOOT_DRIVER(samsung_ltl106hl02) = {
+	.name		= "samsung_ltl106hl02",
+	.id		= UCLASS_PANEL,
+	.of_match	= samsung_ltl106hl02_ids,
+	.ops		= &samsung_ltl106hl02_ops,
+	.of_to_plat	= samsung_ltl106hl02_of_to_plat,
+	.probe		= samsung_ltl106hl02_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct samsung_ltl106hl02_priv),
+};
-- 
2.40.1

