Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427D1C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 21:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E552280D32;
	Wed, 26 Aug 2026 21:23:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oy-PVgQxsZCh; Wed, 26 Aug 2026 21:22:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787779379;
	bh=qpwCUy+K7isy5ghdsLwqTizRheH1+esV15dcMgnliZM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O22AbVtLzSkQ1JFnmzFxYxXGF8DY+5xrLQgXE9E6SYZNJ6XPYoaAQ7kH1tpuFly9l
	 UUvzJvYkRnEcD+0qpPgP3QABL2+7Qm5gISQ5dA5PSW2IHmJrYf1WF7Uhavgq7Z9w/1
	 FxSjdOQ35La5ZP8g2bgoyKnO4f+bv1CMU9FbrAKYkvSJOMqgNPqs3mCgvkUTw1bsDz
	 sVMK7cKY5Wrmw5E/3ifHSKhI/+zJWFY/CCXxwkYp5RnPVGOPTD8Vghm0FSL4/nddnc
	 FPJjSuu5uF1cD7ent9Vpj49wThqTjLrlCVDdl1hO89NSD6J97RVrsAY3L3iFApV8d6
	 NPsGYKtj1sEfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B6BD80D07;
	Wed, 26 Aug 2026 21:22:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C73639E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 21:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 625B180D07
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 21:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FOtyQI3f22_r for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 21:22:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=C9R486ul
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D364680D00
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 21:22:55 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ec58fa3e01so1357218a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787779374; x=1788384174;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qpwCUy+K7isy5ghdsLwqTizRheH1+esV15dcMgnliZM=;
 b=C9R486uljSUG75bMpo13QMsDJGLCboc/TcJvcENKUo0s+/ttofEuCofLFboyIhBI+C
 CIuZcqYqi6I7B4wwVtrzF+6cwNfK1kqfIQpCgutJ0ODOeWxKYkifVOJMLWBvAPaMLtSz
 CpG3coOp9SQM3dUvEgiMZMIpbPnYLKlvK8Nwlxex+TFRvHOnpBOEF0U22IbstIOyhaWs
 9fBuwtB6IHhOvjEovm2DN1o16gC3ujbW73gHjImQempS9ycNwO8VGhoDnPSlBWMTx9pz
 JXUdHhAuu4YNh3Qxn87HQp/QVZ89gjMKZW46wrrswDNXbptHZrreQ9bz9CpjlUcJH+ba
 WYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787779374; x=1788384174;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qpwCUy+K7isy5ghdsLwqTizRheH1+esV15dcMgnliZM=;
 b=eQgltXsa/CXIOpdeUJpbDr8Z5yk/fG6yOM8VMGKz/kepXNGE2LYi4csdz3hAbKNTMo
 qLN1QWMSbTKqEV0mUM9OBtbfyl9N7OhwskZlwlRYhvq2cV8eexCvbF5BdUrwzY0/owna
 0nAywF5vOS5wTdJmqabS2zmdE0wwYDuwj9blPdS2vw70KE71txChM53OOsnI5K32xSQq
 IZq8HL8DCa7QAGLcbkpsRTkzWy2Y2voOGh3kzpmH5OnmPGBZ89X5wioLhVMjyhRayFX/
 LkkoqGtBZoqpXu9t8ay1FnOzXxLiP++ZtWVnIC8fs66TZf717V07oxcyuEYm65j39YEq
 2esQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq2Xx1dl+TbzVqfH6N62Q9eY3qh7xLtNpz3Da1ahGMT/XKzoG9TVFhAlWNTv6Rro551e/of+4Q=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lkNp2D4puTQTTwGV5LyTy4W8SK980sczc00jRYaxZh7CjBTMNQ
 0l/Urcbj5WwSOrfD/X4Sms678Cb4S9te15Ob9EV0tWvnlAZ0cCqWXwilh5giPp1LlJ0=
X-Gm-Gg: AR+sD12WUivg5WN4dEx0XqrViJiJtx9YJnAXMbL2x1kjDZ9OZqt3UGInY0kZgILWBsz
 McrCn0F+rQeiC+qckjwLqewbuzPv+XHTUpIqoeO2MW0TS0Nu1Mr4g8zVvqNrzmV4ljh4bGvbpgl
 YUmpHOaC4SUDMKSWldt/Ydp3HUQ7RTTmda615WM3cdCKWomRhonfIfFYhpk75WkB+T45wB9esnR
 9ZVQJgZqJ0/3rJS5z488zbdwm3GWMRhi1hax4XuYqNQ1+7aKGLuWZA896wrJTiVW3HYOAigHHNu
 Mq1pOTIMrnnMtvMtGLMcKdWfPkUMsaie4kdqErr6qVwQCPIBYKpBKSAX9dUPhpbPlYSeCzpSTO2
 rp0BRWYj2k8d+qWbqegyzkgbd4khi3Y9+9TDxBc+SL07ph8CxiLFolKqUUnRJpeo6ycvCM56fIj
 DwX4uDp7nftwlsKP1ALRo3Ud+5Vwbkv6nxUXk2DDhxSrFMiOcIUww/zULwnZWwpzOG8Q==
X-Received: by 2002:a05:6830:829a:b0:7dc:db3c:1d82 with SMTP id
 46e09a7af769-7f4c52670aamr11304558a34.10.1787779374169; 
 Wed, 26 Aug 2026 14:22:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:162c:81fd:da88:2ea6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c83d375csm2511736a34.15.2026.08.26.14.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 14:22:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 26 Aug 2026 16:22:41 -0500
Subject: [PATCH v2] video: panel-startek-kd070fhfid078: new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-mtk-video-panel-startek-078-v2-1-c56342b77835@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42Qy26DMBBFfwV53Wl546Cq6n9UEbLxECbBmNgOT
 RTx7zXQTXddHunqnjvzZA4toWN19GQWZ3JkxgDpS8TaXownBFKBWRqnZcyTHLS/wEwKDUxixAG
 cF9bjBeKKQyIOQmYc+aGrWGiYLHZ039q/jju7mzxj69fK34TF6y1o/R5jGp0Tm7aO3ndrXIJQq
 tE0UaMcNd82pBuH16bHYULbaNFa42BOIIZSFllWca5i0X5K8RhIWnxtjf5YfVI4hACafB0ZSyc
 a30a8e7bO68l5Yx/bL+ZkW/Ovs4M3gaLjuSiqNM/lXy87LsvyA4T4LBZoAQAA
X-Change-ID: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
To: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13225;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=mGs3zBIiPIEi//lkujz5AGBLcqCesO8b3NwVngoxwhQ=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqj1kjSFw5LckTNLc7ARsOVV7IZ4Okj94T+wqle
 ZT2FjbogdaJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCao9ZIxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A1lkIAKDzKDzkpbeQZKVMRgEBCvvw5IgaDz7/on98duO
 vAiJyCfKTuc1UB6oB3qYYTl920h/GI4aMmzzjNrlUNSmRmuhGouKN/p5A4lb2hH/bqTKZ/cGha4
 5dBKeJM7E4A01tCwGlEpjuJWYmm0VGjaW99HgWY9yAZhAvao0MkTcZRor1XiOQ/kGGLLKU9ZfFY
 /s32LJvABI4jLIBXCsblksr1O0rqNRS/2vufnT/+1CioO2pQJda2Uk3ifSfV1y0hrXqJCirTHLN
 Oty9CgPssUK950NiM2R44UXCS+9sKkam/ZS+D6Pr3Idi00tLAZcxpuuJkBNY48LAyyFxiy6oV8P
 TWQM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
used on the MediaTek Genio 360 EVK board.

The display mode and DSI mode flags follow the upstream Linux driver
panel-himax-hx8279.c, which is what the "himax,hx8279" fallback
compatible in the device tree binds to.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Add a driver for the Startek KD070FHFID078 7" DSI panel.

This depends on the mipi_dsi {generic,dcs}_write_seq helper macros series
for mipi_dsi_generic_write_seq().

Note: no defconfig enables this driver yet, since there is no MediaTek DSI
host driver in U-Boot at this point. It will be enabled together with the
display pipeline support.
---
Changes in v2:
- Added missing BACKLIGHT and DM_REGULATOR Kconfig dependencies.
- Use the display mode and MIPI_DSI_CLOCK_NON_CONTINUOUS flag from the
  upstream Linux panel-himax-hx8279.c driver instead of the MediaTek
  downstream driver.
- enable-gpios is now optional, matching the binding.
- A missing backlight is now an error instead of a warning.
- Do not request reset/enable GPIOs as active, so they are not asserted
  before the regulators are enabled.
- Use mipi_dsi_dcs_exit_sleep_mode()/mipi_dsi_dcs_set_display_on() instead
  of raw DCS opcodes and check their return values.
- Dropped stale InforceComputing/Linaro copyright and author lines.
- Dropped the unused dev field and the unreachable mode check.
- Link to v1: https://patch.msgid.link/20260814-mtk-video-panel-startek-078-v1-1-5f84a57244bc@baylibre.com
---
 MAINTAINERS                                 |   6 +
 drivers/video/Kconfig                       |  10 +
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid078.c | 283 ++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fabcb8b2968..b3bf5b1f8c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1723,6 +1723,12 @@ R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
 S:	Maintained
 F:	drivers/video/panel-startek-kd070fhfid015.c
 
+STARTEK KD070FHFID078 PANEL
+M:	David Lechner <dlechner@baylibre.com>
+R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
+S:	Maintained
+F:	drivers/video/panel-startek-kd070fhfid078.c
+
 TARGET_BCMNS3
 M:	Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
 S:	Maintained
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 37ab17f0ab2..495e4382a22 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -330,6 +330,16 @@ config PANEL_STARTEK_KD070FHFID015
 	  1200 x 1920 pixels. It provides a MIPI DSI interface to the host, a
 	  built-in LED backlight and touch controller.
 
+config PANEL_STARTEK_KD070FHFID078
+	bool "STARTEK KD070FHFID078 panel"
+	depends on PANEL && BACKLIGHT && DM_GPIO && DM_REGULATOR
+	select VIDEO_MIPI_DSI
+	help
+	  Say Y here if you want to enable support for STARTEK KD070FHFID078 DSI panel.
+	  The panel is a 7-inch TFT LCD display with a resolution of 1200 x 1920
+	  pixels. It provides a MIPI DSI interface to the host, a built-in LED
+	  backlight and touch controller.
+
 config VIDEO_BOCHS
 	bool "Enable Bochs video emulation for QEMU"
 	help
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 7a54f1f290d..7a7b54e6b53 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
 obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
 obj-$(CONFIG_PANEL_STARTEK_KD070FHFID015) += panel-startek-kd070fhfid015.o
+obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) += panel-startek-kd070fhfid078.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
new file mode 100644
index 00000000000..dd5cac46267
--- /dev/null
+++ b/drivers/video/panel-startek-kd070fhfid078.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ *
+ * Authors:
+ * - Guillaume La Roque <glaroque@baylibre.com>
+ * - Jitao Shi <jitao.shi@mediatek.com>
+ * - David Lechner <dlechner@baylibre.com>
+ */
+
+#include <asm-generic/gpio.h>
+#include <backlight.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/delay.h>
+#include <mipi_dsi.h>
+#include <panel.h>
+#include <power/regulator.h>
+
+struct stk078_panel {
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct mipi_dsi_device *dsi;
+	struct udevice *iovcc;
+	struct udevice *vdd;
+	struct udevice *backlight;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock = 156458,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 50,
+	.hsync_end = 1200 + 50 + 24,
+	.htotal = 1200 + 50 + 24 + 66,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 14,
+	.vsync_end = 1920 + 14 + 2,
+	.vtotal = 1920 + 14 + 2 + 10,
+};
+
+static int stk078_panel_init(struct stk078_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
+	int ret;
+
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xB3, 0x52);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x7F);
+	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x20);
+	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x7F);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xC1, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xC3, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xC5, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xC6, 0x0A);
+	mipi_dsi_generic_write_seq(dsi, 0xC7, 0x0A);
+	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x0C);
+	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x0C);
+	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xCB, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xCC, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xCD, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xCE, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xCF, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xD0, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0xD1, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x0D);
+	mipi_dsi_generic_write_seq(dsi, 0xD6, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD7, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD8, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xD9, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xDA, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xDB, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xDC, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, 0xDD, 0x0B);
+	mipi_dsi_generic_write_seq(dsi, 0xDE, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xDF, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xE0, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xE1, 0x0E);
+	mipi_dsi_generic_write_seq(dsi, 0xE2, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xE3, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xE4, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xE6, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xE7, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xBA, 0xF0);
+	mipi_dsi_generic_write_seq(dsi, 0xC8, 0x07);
+	mipi_dsi_generic_write_seq(dsi, 0xC9, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xCA, 0x41);
+	mipi_dsi_generic_write_seq(dsi, 0xD2, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xD3, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD4, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x8A);
+	mipi_dsi_generic_write_seq(dsi, 0xE4, 0xC0);
+	mipi_dsi_generic_write_seq(dsi, 0xE5, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xBF, 0x1F);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x12);
+	mipi_dsi_generic_write_seq(dsi, 0xC2, 0x1E);
+	mipi_dsi_generic_write_seq(dsi, 0xC4, 0x1E);
+	mipi_dsi_generic_write_seq(dsi, 0xB0, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0xA5);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0xA5);
+	mipi_dsi_generic_write_seq(dsi, 0xBC, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xD5, 0x48);
+	mipi_dsi_generic_write_seq(dsi, 0xB8, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xC0, 0x00);
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	mdelay(120);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret < 0)
+		return ret;
+
+	mdelay(20);
+
+	return 0;
+}
+
+static int stk078_panel_enable_backlight(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	struct mipi_dsi_device *dsi = plat->device;
+	int ret;
+
+	stk->dsi = dsi;
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
+		return ret;
+	}
+
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+	mdelay(10);
+
+	ret = regulator_enable(stk->vdd);
+	if (ret < 0) {
+		dev_err(dev, "enable vdd failed: %d\n", ret);
+		goto out_gpio;
+	}
+
+	ret = regulator_enable(stk->iovcc);
+	if (ret < 0) {
+		dev_err(dev, "enable iovcc failed: %d\n", ret);
+		goto out_vdd;
+	}
+
+	mdelay(15);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 1);
+	mdelay(10);
+	dm_gpio_set_value(stk->reset_gpio, 1);
+	mdelay(140);
+
+	ret = stk078_panel_init(stk);
+	if (ret < 0) {
+		dev_err(dev, "panel init sequence failed: %d\n", ret);
+		goto out_power;
+	}
+
+	ret = backlight_enable(stk->backlight);
+	if (ret < 0) {
+		dev_err(dev, "enable backlight failed: %d\n", ret);
+		goto out_power;
+	}
+
+	return 0;
+
+out_power:
+	regulator_disable(stk->iovcc);
+out_vdd:
+	regulator_disable(stk->vdd);
+out_gpio:
+	dm_gpio_set_value(stk->reset_gpio, 0);
+	if (stk->enable_gpio)
+		dm_gpio_set_value(stk->enable_gpio, 0);
+
+	return ret;
+}
+
+static int stk078_panel_add(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	int ret;
+
+	ret = device_get_supply_regulator(dev, "iovcc-supply", &stk->iovcc);
+	if (ret) {
+		dev_err(dev, "Failed to get iovcc regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdd-supply", &stk->vdd);
+	if (ret) {
+		dev_err(dev, "Failed to get vdd regulator: %d\n", ret);
+		return ret;
+	}
+
+	stk->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_IS_OUT);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_IS_OUT);
+	if (IS_ERR(stk->enable_gpio)) {
+		ret = PTR_ERR(stk->enable_gpio);
+		dev_err(dev, "cannot get enable-gpios %d\n", ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &stk->backlight);
+	if (ret) {
+		dev_err(dev, "failed to get backlight: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int stk078_panel_probe(struct udevice *dev)
+{
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_MODE_LPM |
+			   MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
+	ret = stk078_panel_add(dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int stk078_panel_get_modes(struct udevice *dev,
+				  const struct drm_display_mode **modes)
+{
+	*modes = &default_mode;
+
+	return 1;
+}
+
+static const struct panel_ops stk078_panel_ops = {
+	.enable_backlight = stk078_panel_enable_backlight,
+	.get_modes = stk078_panel_get_modes,
+};
+
+static const struct udevice_id stk078_of_match[] = {
+	{ .compatible = "startek,kd070fhfid078" },
+	{ }
+};
+
+U_BOOT_DRIVER(stk078_panel_driver) = {
+	.name		= "panel-startek-kd070fhfid078",
+	.id		= UCLASS_PANEL,
+	.of_match	= stk078_of_match,
+	.ops		= &stk078_panel_ops,
+	.probe		= stk078_panel_probe,
+	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
+	.priv_auto	= sizeof(struct stk078_panel),
+};

---
base-commit: f252d228be2b2d180737ad0a851f91749273cbd9
change-id: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
prerequisite-message-id: <20260806-add_mipi_dsi_write_seq_helper_macros-v1-0-6b533788d0ac@baylibre.com>
prerequisite-patch-id: cf35ac4802976971af68bd0ce1dc0ab872fdb661
prerequisite-patch-id: 9f6aca2bfde84a5d84329b77b3b9af8898b18e4a
prerequisite-patch-id: e7bb7ee54b88b6d6e00f74fe84b1c81d00957051
prerequisite-patch-id: d4a530120b1a93d68e4b17c6e1fcf2878e784454
prerequisite-patch-id: 18b1bbeab6808decceaf5117b3e999baf4495e1d
prerequisite-patch-id: d50e7e28a399c303226ff08c78e60749930a7243

Best regards,
--  
David Lechner <dlechner@baylibre.com>

