Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1F606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QLz4yah2;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FL7vwJ8h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A5826070C;
	Sat, 21 Nov 2026 12:35:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIgvZVX_iUGW; Sat, 21 Nov 2026 12:35:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BB116065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264541;
	b=SR6pFu/5rRj1XILbJYNPQkE/xLsBSVasSyRJC2DXcdxatFBvzKDE4gig4TkniC8inlaU
	 o/SzdZbM7m3VgC9QaHGMz2JCbUR7uae7Ua9UrkETeaoYgDMdztSwm9EAFVfZrBi1ga25D
	 jxeJzOUpizvyJDHDmKwAyXni+HPxVIqXrMD50ohuaccb53xoAgba9E8MXUmUzs9+81kRK
	 Ec1dcfAJFo4ss2NeMcyg/dXcdnpbwNCQzO/vQqKkyRpI5GQX2b594mqJzjtWwkvHSIBZ0
	 0K2HFDr/vhZ6GeF/JZacH5PzeGilzO8pqXEs5UzfMjaz5V+O0iqy8bvsYvXKlM9UF3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DbI2HbaWuZlrWnTfQs8avaXVnX3rMkFaIQ2K2bNXixg=;
	b=TGF+bIAOXlqBJbBkAoFA1fLXWDDG1VQ3uNwnkTICFZVxRouNZ08QtQoUaAJ4ILRvVe9T
	 w2Sd5fawFSFfIu0YCNASSFmnX5DtV44yf0+h9GlxgzSTDusYUGiU/nEzUTLQvItLOJLMP
	 qMBPp32biGAKVDhCC1TNGyWzIRCIaB7H1SJTjxyvZnjXTNSpAoTUR+KMbXqSlcUcQLTzr
	 Le/M6sAotrVdKQP6o/j/lNSbuqU8bA44XantNWDAH1rBgdEiomy2p7yVOWYUHiFTEnrfQ
	 06hvJbWxTGQBMkFHPV89+lU2zxuhkAc8yLgantoaNqEdcKIZaR+Xtl/bINHZwLYaGLg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264541;
	bh=DbI2HbaWuZlrWnTfQs8avaXVnX3rMkFaIQ2K2bNXixg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QLz4yah2xCc/qaB69j8lBe6AAPGC/EpXb1a/Z3TxJ/iv4VsLxOiX6OQTLsdinO2qz
	 50bizpvcfbaISR/VUsLeMmT7wDWrbWyqIPZAKS6XmvdYZGOb3xHtqOd2s6BUbHEUHu
	 RMndDtTV5tOwzU2J3ksKCjdlG/EuLVYpW07tMVddpsM1KIiTaLfXrTRZb19ZjrE49p
	 JCD0N4ecngduJAh6o1Ti0KTlvjFw0uz5zrk9jdRSn/3ODEBJE6HXDMXm3CmhSh+zyX
	 OmPDx0bWnJ+1jZ4skkEtu4hdKK+hiU5MhuS6TyR9py1zdmW4uxR2ZKKvznMQqen7W1
	 ARoOpAPEb3TnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6BB116065A;
	Sat, 21 Nov 2026 12:35:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AD7F759
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 80BE080E8C
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PlkxHIqH-2ad for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6A08080E22
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=FL7vwJ8h
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6A08080E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:32 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso973998f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264531; x=1795869331;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbI2HbaWuZlrWnTfQs8avaXVnX3rMkFaIQ2K2bNXixg=;
 b=FL7vwJ8hMssgCYnPDE7T6tGkr8exEUHsMoDnwK5OWpjDHrVNucDc2b55V05KECw80Y
 gkOEiW85u4/E0MtOlhHVcdxvdAhhKElNBSTJCdMJTIWNbdK4pzO3G8exXFUZtxFUjTVN
 /J7I25K+XWpqfxLIWNdlEUb1W7JCsRYP9R98Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264531; x=1795869331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DbI2HbaWuZlrWnTfQs8avaXVnX3rMkFaIQ2K2bNXixg=;
 b=UWUERWAcfe10VUKcFiMrtZ4qFPTMo+Qv072BRSxWU3do2lqav13zy1KqLWNgP7+HeE
 HfY2GycedI1CwzDmlupRDEoMM66dO6C7XHcxDlRwNwN96NpztRfrTOehTasUw1ojitLr
 YXuOusz8KLKss/rTnEUgsTK+0PZDZ0JaUxdR8dDcMEkIg8C7lZOXgx49lt6+9tULinLR
 YhlcKIaHHOECI1eS6ovSRn04cCybhUx+ks39THLf8d/DpQ0fXYuphneoQN9Hxa8njgQ+
 ggjegPwrzi9cJ2u4/RdjyLGrf1nCDj+PX/7DYiU0Ln1Fx99OIBgLe6b+VrdnjpUqlCyd
 wlQg==
X-Gm-Message-State: APuU4Z+r5mzDIOLhF0YeV5N57IMBEPX3cChtvFZH0s4A5sKiDeRVYkuG
 iAx4ln4Rc/5OslgujdpAmpfGHCKH6lvrnALqhCYb9IK7CZ1Oh1kLUrD328mW0hlosBVLyvYmwvt
 JrrYH
X-Gm-Gg: AZFdTZcRUm0Pgo3XfkxrWS9Eqp88S4NAgTDMDu0cHtj829UU1xpOL4PGn0Hxw5hDGMp
 c7B7Xa8KsiI4mahbcTs5KRE4xVMJicsYJiUa95tAooWX3KDzUN0JFvnEmd2MgwS1+GXT90aEkzn
 2R86/a0WTwR9u0A3SIlItYs0UYuzDYkGWX/FrCFT/J1ECr2RvH42KbLXmoeD69tf8HW00XwMG8r
 QPk7o60RWOOIJPNgMtg29OeWAIQ3RCRq3gfbNfMy3drZYi3QyOmdMein4XmveQA7UZb7if/bGMQ
 aPs+SQjwERXepOyMdr4SbaCJU0CwBBbILb0wwetb0cGSEUV8MPjJKJMvLsf5nroDFDKEl3zR9nb
 gq5QSJxfMJBxM77MqcQq7t8YZKDsu6QsMcnmqiUHpsQR34Fxrmn9UCSUjz2sOwhs2oMKpoZggi8
 nag8d55ngnN5trStKsrsGty7TcG/WcKno4h/mplLl3lmU9341mnLGV3FMIQG2JN+mpfPmVmCxo8
 7OCI/JQlpYMXPwbzGHMzWRjCSp+jy6VdQzcRsZWk8dBv+nYSGh9OMlsG1lA+zz4OY50NL4nIh/2
 U8R55SN3z87niLsxWH5rveq5JxQV0z7Opvavavt7Ygr3I7deqzTV2rk4l3M9LWvfsQeuQGSaJJb
 oPnpgRLcJnfhEgk4haCaqspKvJ7oINwTP155yXshTCoUF456WhuxUaP+TIeZt3Yvf8//3c2HHYS
 h3bydOWf9UaNC/dMk6z5sPp0SrOw==
X-Received: by 2002:a05:6000:4026:b0:4af:7577:65b2 with SMTP id
 ffacd0b85a97d-4af757766a5mr2640283f8f.52.1795264531201; 
 Sat, 21 Nov 2026 04:35:31 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/25] video: Add Synaptics R63353 panel driver
Date: Sat, 21 Nov 2026 13:34:08 +0100
Message-ID: <20261121123451.2471185-19-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

The LS068B3SX02 panel is based on the Synaptics R63353 Controller.
Add a driver for it.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/Kconfig            |   8 ++
 drivers/video/Makefile           |   1 +
 drivers/video/synaptics-r63353.c | 228 +++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/video/synaptics-r63353.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index cc21afbe8ff5..ed0abb23d751 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -708,6 +708,14 @@ config VIDEO_LCD_SSD2828_RESET
 	  The reset pin of SSD2828 chip. This takes a string in the format
 	  understood by 'sunxi_name_to_gpio' function, e.g. PH1 for pin 1 of port H.
 
+config VIDEO_LCD_SYNAPTICS_R63353
+	tristate "Synaptics R63353-based DSI LCD panels support"
+	select VIDEO_MIPI_DSI
+	default n
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Synaptics R63353 controller.
+
 config VIDEO_LCD_TDO_TL070WSH30
 	bool "TDO TL070WSH30 DSI LCD panel support"
 	select VIDEO_MIPI_DSI
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6e6d1ba29cdb..2955e76bb02e 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02) += samsung-ltl106hl02.o
 obj-$(CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01) += sharp-lq079l1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01) += sharp-lq101r1sx01.o
 obj-$(CONFIG_VIDEO_LCD_SSD2828) += ssd2828.o
+obj-$(CONFIG_VIDEO_LCD_SYNAPTICS_R63353) += synaptics-r63353.o
 obj-$(CONFIG_VIDEO_LCD_TDO_TL070WSH30) += tdo-tl070wsh30.o
 obj-$(CONFIG_VIDEO_LCD_SONY_L4F00430T01) += sony-l4f00430t01.o
 obj-$(CONFIG_VIDEO_LCD_SAMSUNG_S6E63M0) += samsung-s6e63m0.o
diff --git a/drivers/video/synaptics-r63353.c b/drivers/video/synaptics-r63353.c
new file mode 100644
index 000000000000..86d2aea346b2
--- /dev/null
+++ b/drivers/video/synaptics-r63353.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synaptics R63353 Controller driver
+ *
+ * Copyright (C) 2020 BSH Hausgerate GmbH
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+
+#define R63353_INSTR(...) { \
+		.len = ARRAY_SIZE(((u8[]) {__VA_ARGS__})), \
+		.data = (const u8 *)&(const u8 []){__VA_ARGS__} \
+	}
+
+struct r63353_instr {
+	size_t len;
+	const u8 * const data;
+};
+
+static const struct r63353_instr init_sequence[] = {
+	R63353_INSTR(0x51, 0xff),
+	R63353_INSTR(0x53, 0x0c),
+	R63353_INSTR(0x55, 0x00),
+	R63353_INSTR(0x84, 0x00),
+	R63353_INSTR(0x29),
+	R63353_INSTR(0x11),
+};
+
+struct r63353_panel_priv {
+	struct udevice *dvdd;
+	struct udevice *avdd;
+	struct udevice *backlight;
+	struct gpio_desc reset_gpio;
+};
+
+static const struct display_timing default_timing = {
+	.pixelclock.typ		= 70000000,
+	.hactive.typ		= 640,
+	.hfront_porch.typ	= 35,
+	.hsync_len.typ		= 2,
+	.hback_porch.typ	= 150,
+	.vactive.typ		= 1280,
+	.vfront_porch.typ	= 2,
+	.vsync_len.typ		= 4,
+	.vback_porch.typ	= 1,
+	.flags = DISPLAY_FLAGS_DE_LOW,
+};
+
+static int r63353_panel_enable_backlight(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int i, ret;
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_soft_reset(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to do Software Reset (%d)\n", ret);
+		goto fail;
+	}
+
+	mdelay(20);
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enter sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(init_sequence); i++) {
+		const struct r63353_instr *instr = &init_sequence[i];
+
+		ret = mipi_dsi_dcs_write_buffer(dsi, instr->data, instr->len);
+		if (ret < 0)
+			goto fail;
+	}
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to exit sleep mode (%d)\n", ret);
+		goto fail;
+	}
+
+	mdelay(10);
+
+	/* This call starts sending the data on the display (LINUX LOGO) */
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set display ON (%d)\n", ret);
+		goto fail;
+	}
+
+	ret = backlight_enable(priv->backlight);
+	if (ret)
+		return ret;
+
+	return 0;
+
+fail:
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+
+	return ret;
+}
+
+static int r63353_panel_get_display_timing(struct udevice *dev,
+					   struct display_timing *timing)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *device = plat->device;
+
+	memcpy(timing, &default_timing, sizeof(*timing));
+
+	/* fill characteristics of DSI data link */
+	if (device) {
+		device->lanes = plat->lanes;
+		device->format = plat->format;
+		device->mode_flags = plat->mode_flags;
+	}
+
+	return 0;
+}
+
+static int r63353_panel_of_to_plat(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "dvdd-supply", &priv->dvdd);
+	if (ret) {
+		dev_err(dev, "failed to get power dvdd supply\n");
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "avdd-supply", &priv->avdd);
+	if (ret) {
+		dev_err(dev, "failed to get power avdd supply\n");
+		return ret;
+	}
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+				   GPIOD_IS_OUT);
+	if (ret) {
+		dev_err(dev, "failed to get RESET GPIO\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int r63353_panel_probe(struct udevice *dev)
+{
+	struct r63353_panel_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	ret = regulator_set_enable(priv->avdd, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable avdd regulator (%d)\n", ret);
+		return ret;
+	}
+
+	mdelay(25);
+
+	ret = regulator_set_enable(priv->dvdd, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable dvdd regulator (%d)\n", ret);
+		regulator_set_enable(priv->avdd, false);
+		return ret;
+	}
+
+	dm_gpio_set_value(&priv->reset_gpio, 0);
+	mdelay(10);
+	dm_gpio_set_value(&priv->reset_gpio, 1);
+	mdelay(120);
+
+	/* fill characteristics of DSI data link */
+	plat->lanes = 2;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM |
+		MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_EOT_PACKET;
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &priv->backlight);
+	if (ret) {
+		dev_err(dev, "%s: Warning: cannot get backlight: ret=%d\n",
+			__func__, ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct panel_ops r63353_panel_ops = {
+	.enable_backlight = r63353_panel_enable_backlight,
+	.get_display_timing = r63353_panel_get_display_timing,
+};
+
+static const struct udevice_id r63353_panel_ids[] = {
+	{ .compatible = "syna,r63353" },
+	{ .compatible = "sharp,ls068b3sx02" },
+	{ } /* sentinel */
+};
+
+U_BOOT_DRIVER(r63353_panel) = {
+	.name = "r63353_panel",
+	.id = UCLASS_PANEL,
+	.of_match = r63353_panel_ids,
+	.ops = &r63353_panel_ops,
+	.of_to_plat = r63353_panel_of_to_plat,
+	.probe = r63353_panel_probe,
+	.plat_auto = sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto = sizeof(struct r63353_panel_priv),
+};
-- 
2.43.0

