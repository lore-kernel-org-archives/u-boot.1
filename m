Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84241C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 13:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28C62607C1;
	Wed, 22 Jul 2026 13:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HqVqmBMKemFO; Wed, 22 Jul 2026 13:19:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0ECCE607C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784726352;
	bh=yVo+z5GSTqPftag3aypdiPSLTad4GRf7cA03zJKz6Lw=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oaGS6hfkengw7lLL//cFHXjh5YfGbVbPSQG5XnO1r3/kKGXREiEejlYhoXoPoEX4I
	 Ps9hOM+KsWD4lMCNduRKqSYlrS/+RDLmmXL6snPfeEhayQE49u7WZh/dDJnIYgRFi3
	 d4WMeopyvAgP59nqA5Rs6mH7r8/eHwdL83ZJ9tgWp0TD98FVgi3FUvF8VEtLKtrLvJ
	 ZleJHrXE6CDmPJTJhlIdmDUCE3OnXLn5tHRSJUao3xfGVJ+3ZPuZiT3kKKiBeuYGfN
	 Yg81pohr1zz+FGz4s4h55xMQAt5xlqkvJmBoD6TvvheWiJXV35BBGEQTtOXQeGQkxS
	 yY/S/uzVYBypA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0ECCE607C4;
	Wed, 22 Jul 2026 13:19:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B9C76224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F8F980DAF
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xeh1QhPimowT for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 13:19:09 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=advaitd@mechasystems.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 25E9880EE7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25E9880EE7
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25E9880EE7
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:19:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284F0848BA; Wed, 22 Jul 2026 15:19:07 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B0B803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 15:19:03 +0200 (CEST)
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so10176824a91.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784726341; x=1785331141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yVo+z5GSTqPftag3aypdiPSLTad4GRf7cA03zJKz6Lw=;
 b=klJSec9MTrFgxik9rxc9mSsdNWhB3lICB4e//oYFCDaK++VFq7V8j7BMimWKhjyEgR
 BwHHgFaFgs7cuKOC3MrysFzX44CxCokCDE/BLoBtUpuYcjCozj2gw3qujCPi8uObuWNU
 910kEIKkTrOcrzhK+jeG3rrSLkU3EynzPA43rLGyZbrUwG/iTMexKlqoOUokGyTUE+fm
 9jjfVWwHRFFDhLm381g1NYwiG/unFjH+9xNPB6rQQz+EeaNqJQn685LI7jQpzXKv/+Jy
 pDczUGq5n/aDbCpxir3Uwus9DtpyPk5O3juGAhgPO6IEjS9vknF1fer4o1jxQ3KPD/iy
 dG+w==
X-Gm-Message-State: AOJu0YzM/DNuo97Z1M9NZYUldUdegti/010WBOsU4Ntj9iCZsA9Zcm+6
 yNreD2+rbfy9fLflBuPMhhdBVZoo9QWxVwcTqw/RjH2vynoKtSh5Y2WxeXyLcyXORRWuP4Xp+3e
 sR/H/
X-Gm-Gg: AR+sD10+a0CqWj5khAbxuNs5jDUoAf3SDof7hwHDnXIQ7gKVh0K839j1NfgnkZuDcLS
 azqjvkU88LFRagDBLPvxbvufxjASIxcq8F8RzRDP9j09XSXTe5dZJJWDCxcoJtGOECExM5LfXxv
 7OC2SiFvrfQowhuELIWKze6vK4cYBC3/m4IvsprCzR0EAZh+wsNiRklXSd4OjzqpsevYKiYHsfv
 3XXgbSCii4zjnfC/HG7GGLWk1+3HyURpBuL7dnprmlBJVNY4JWKnO8jabqa/AUM6QSJ6Hgn1B5Q
 +F9MGVybWmTKQdUHkfCpEnV0xfzGe1FtopV+aG41qBwzZzpeDe6h8YMP4/FFt1r++pIteQHkCMH
 Lh04aKKccqee3mYlIMlvEokcjqelyzx3Xq7rOyr1rVhgyoZY9q7XMwPNOIB6pHwdMaHLfqSGGJN
 wjbm+suQMyqtHQqA==
X-Received: by 2002:a17:90b:1b42:b0:38e:5dc:af03 with SMTP id
 98e67ed59e1d1-38e4b5e9631mr21718085a91.40.1784726341307; 
 Wed, 22 Jul 2026 06:19:01 -0700 (PDT)
Received: from advait-work.lan ([103.93.196.100])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d130f55c6sm11522653c88.15.2026.07.22.06.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:19:00 -0700 (PDT)
To: u-boot@lists.denx.de
Cc: Advait Dhamorikar <advaitd@mechasystems.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4] video: add ChipWealth CH13726A AMOLED panel driver
Date: Wed, 22 Jul 2026 18:46:24 +0530
Message-ID: <20260722131626.77086-1-advaitd@mechasystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems.com; s=google; t=1784726341; x=1785331141; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yVo+z5GSTqPftag3aypdiPSLTad4GRf7cA03zJKz6Lw=;
 b=tFlapnXpzevchBeoqQt7wLQ5wdVmYeWkJo/L/4+7GLN6ioz4S6A4V33xuuQnAQR8Oe
 KU3Th4Ry4Xg+Il7nl611l5FwSL+JcCsaPZoQ9oe4rYwztNDI2hMdhRm46FTQo6unxuJR
 mUjL+u1A6OlOBjC9szIwUi2Ko7ofBtVBbLaYiZfJBaEkoaTHmWrXfQFPDVAudXJHeYwN
 a8G9/cekDgyA/I4bLMlIr9TrbuW9XA7B9gjNSVzrYjf+Zn++HpYqxiHIx4wDKjJptpmD
 5i2vi7iLVWRFEDdOuXLfvwbfz8TLkl5rUuLsDka0Jij10dzBKLbgD3x3q+38xwxOEG41
 qglQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.a=rsa-sha256 header.s=google header.b=tFlapnXp
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=mechasystems.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=advaitd@mechasystems.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=mechasystems.com header.i=@mechasystems.com
 header.b="tFlapnXp"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Advait Dhamorikar via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Advait Dhamorikar <advaitd@mechasystems.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add support for AMOLED panels based on the ChipWealth CH13726A
MIPI DSI display driver IC.

The driver configures the MIPI DSI interface for 4 data lanes in RGB888
video mode, performs the panel reset sequence, sends the vendor-specific
initialization commands required by the controller, and enables the
panel using the standard MIPI DCS Sleep Out and Display On commands.

This driver is based on an earlier implementation by Pratham Malaviya.

Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>
---

v1 -> v2
- Expand CC list based on get_maintainer.pl output.

v2 -> v3
Link to v2: https://lore.kernel.org/all/20260702151325.290749-1-advaitd@mechasystems.com/
- Add regulator support using the U-Boot regulator framework.
- Minor code cleanup.

v3 -> v4
Link to v3: https://lore.kernel.org/all/20260716110318.97757-1-advaitd@mechasystems.com/
- Remove unused struct variables

 drivers/video/Kconfig               |   8 +
 drivers/video/Makefile              |   1 +
 drivers/video/chipwealth-ch13726a.c | 219 ++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/video/chipwealth-ch13726a.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c..a214626f376 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -762,6 +762,14 @@ config VIDEO_LCD_SPI_MISO
 	option takes a string in the format understood by 'sunxi_name_to_gpio'
 	function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_PANEL_CHIPWEALTH_CH13726A
+	bool "ChipWealth CH13726A AMOLED panel support"
+	depends on PANEL && BACKLIGHT
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for AMOLED panels
+	  based on the ChipWealth CH13726A MIPI DSI display driver IC.
+
 source "drivers/video/meson/Kconfig"
 
 config VIDEO_MVEBU
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 082b8967982..efa7e288691 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) += samsung-s6e63m0.o
+obj-$(CONFIG_VIDEO_PANEL_CHIPWEALTH_CH13726A) += chipwealth-ch13726a.o
 obj-$(CONFIG_VIDEO_MCDE_SIMPLE) += mcde_simple.o
 obj-${CONFIG_VIDEO_MESON} += meson/
 obj-${CONFIG_VIDEO_MIPI_DSI} += mipi_dsi.o
diff --git a/drivers/video/chipwealth-ch13726a.c b/drivers/video/chipwealth-ch13726a.c
new file mode 100644
index 00000000000..4427585a02d
--- /dev/null
+++ b/drivers/video/chipwealth-ch13726a.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ChipWealth CH13726A DSI panel driver
+ *
+ * Copyright (C) 2026 Mecha Systems
+ * Author(s):
+ *   Advait Dhamorikar <advaitd@mechasystems.com>
+ *   Pratham Malaviya  <prathamm@mechasystems.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <log.h>
+
+struct ch13726a_panel_priv {
+	struct udevice *vdd;
+	struct udevice *vddio;
+	struct udevice *vdd1v2;
+	struct udevice *avdd;
+	struct gpio_desc reset;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ			=	59832000,
+	.hactive.typ			=	1080,
+	.hfront_porch.typ		=	12,
+	.hback_porch.typ		=	12,
+	.hsync_len.typ			=	28,
+	.vactive.typ			=	1240,
+	.vfront_porch.typ		=	2,
+	.vback_porch.typ		=	2,
+	.vsync_len.typ			=	2,
+};
+
+#define dcs_write_seq(dev, cmd, seq...)				\
+({								\
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);	\
+	const u8 d[] = { cmd, seq };				\
+	int ret;						\
+								\
+	ret = mipi_dsi_dcs_write_buffer(plat->device,		\
+					d, ARRAY_SIZE(d));	\
+	if (ret < 0)						\
+		log_err("failed to write dcs sequence: %d\n", ret);\
+	ret;							\
+})
+
+static int ch13726a_hw_init(struct udevice *dev)
+{
+	int ret;
+
+	ret = dcs_write_seq(dev, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	ret = dcs_write_seq(dev, MIPI_DSI_V_SYNC_END, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	mdelay(120);
+
+	ret = dcs_write_seq(dev, MIPI_DSI_GENERIC_LONG_WRITE, 0x00);
+	if (ret < 0) {
+		log_debug("%s: Init command failed (%d)\n",
+			  __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void ch13726a_reset(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+
+	dm_gpio_set_value(&priv->reset, true);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, false);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset, true);
+	mdelay(5);
+}
+
+static int ch13726a_set_backlight(struct udevice *dev, int percent)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	u8 brightness;
+
+	if (percent < 0)
+		percent = 0;
+	else if (percent > 100)
+		percent = 100;
+
+	brightness = (percent * 255) / 100;
+
+	return mipi_dsi_dcs_set_display_brightness(device, brightness);
+}
+
+static int ch13726a_panel_enable_backlight(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+	int ret;
+
+	ret = mipi_dsi_attach(device);
+	if (ret < 0)
+		return ret;
+
+	ch13726a_reset(dev);
+
+	ret = ch13726a_hw_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(device);
+	if (ret)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ch13726a_panel_get_display_timing(struct udevice *dev,
+					     struct display_timing *timings)
+{
+	memcpy(timings, &default_timing, sizeof(*timings));
+	return 0;
+}
+
+static int ch13726a_panel_of_to_plat(struct udevice *dev)
+{
+	struct ch13726a_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vdd-supply",
+						  &priv->vdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vddio-supply",
+						  &priv->vddio);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "vdd1v2-supply",
+						  &priv->vdd1v2);
+		if (ret && ret != -ENOENT)
+			return ret;
+
+		ret = device_get_supply_regulator(dev, "avdd-supply",
+						  &priv->avdd);
+		if (ret && ret != -ENOENT)
+			return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		log_err("%s: cannot get reset GPIO (%d)\n",
+			__func__, ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ch13726a_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			MIPI_DSI_MODE_VIDEO_BURST |
+			MIPI_DSI_MODE_LPM;
+
+	return 0;
+}
+
+static const struct panel_ops ch13726a_panel_ops = {
+	.enable_backlight	=	ch13726a_panel_enable_backlight,
+	.set_backlight		=	ch13726a_set_backlight,
+	.get_display_timing	=	ch13726a_panel_get_display_timing,
+};
+
+static const struct udevice_id ch13726a_panel_ids[] = {
+	{ .compatible	=	"chipwealth,ch13726a" },
+	{ }
+};
+
+U_BOOT_DRIVER(ch13726a_panel) = {
+	.name		=	"ch13726a_panel",
+	.id			=	UCLASS_PANEL,
+	.of_match	=	ch13726a_panel_ids,
+	.ops		=	&ch13726a_panel_ops,
+	.of_to_plat	=	ch13726a_panel_of_to_plat,
+	.probe		=	ch13726a_panel_probe,
+	.plat_auto	=	sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	=	sizeof(struct ch13726a_panel_priv),
+};
-- 
2.43.0

