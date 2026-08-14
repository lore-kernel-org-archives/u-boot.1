Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F66C5CFCF
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 19:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDAEB80EBA;
	Fri, 14 Aug 2026 19:46:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W_4xmUhbgUqh; Fri, 14 Aug 2026 19:46:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C33BF80EBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786736809;
	bh=CmVbXffTTMF1HxNM5HbYUqPfKbygTqjHX7PFYRJO5jI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=obHwI/5FxR053XaYDbKlRTqN6+iErP5Gn5jsE2ZD4ocI3HBi5BFbcyNBOcT3EQUBG
	 vaMvLTdrI+SITGItMYc6N0vE2aaUTBb/MEN9xVvWMx1oTzWohOtifPDjNmUdhUf9G3
	 ry6elNS7PxMqbDgL+Hg+oiLcmO61xy+mP8Zgf2mFfsq+oT0yWw+uX80RTmkN0E5OUx
	 YL0+hOnd6oMepfhegu8WvQWBHOFkEdBlgBxRys0as+rAslHrPTTkufr0N9Leey026K
	 eoHt5mhuF27K7mIF+GPsfIj3dDeBBqj6QkOSjnRQjJ1/lofermxyH+L2T8Pnc8AonU
	 8v7j5tsJpNfTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C33BF80EBB;
	Fri, 14 Aug 2026 19:46:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EAC792B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:46:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E014F80EBB
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:46:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AqyLkGnYCq92 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 19:46:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D9BC280EBA
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9BC280EBA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BfbXQr9H
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9BC280EBA
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 19:46:46 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e9fc3de7ceso728027a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786736805; x=1787341605;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CmVbXffTTMF1HxNM5HbYUqPfKbygTqjHX7PFYRJO5jI=;
 b=BfbXQr9HmDuBvpuFZqGl8Ee4aL3gf0msvrT0OlmqcyPJ/ok5Y9yJM01mMDsfmU1RSp
 evUbT8FZUmNPfIOoDsQeJVYPUnRDhG3wg1bVbh3P95KzvMbBh7moih0Ur/sPlDLWnyJ7
 GNYBl901ROMgcOkb6pfD9ziDSVekmHIiM8fRHuShUwtZcC8ZEoMOUOZtZTih8hfydVcb
 X4FMKGJ49DB34vgGRQ9zqKIqxM0HRERPU+QhzY7HMfD16pgEkl6IEgtpvYtQZdjALVW2
 pvLCvfKBftkF6I9sAXu6WtvNDs67ReK2dr7UYlPqgbcY0AiZLcgpHCIBhP7qYB2uJwmE
 +EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786736805; x=1787341605;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CmVbXffTTMF1HxNM5HbYUqPfKbygTqjHX7PFYRJO5jI=;
 b=VFyljUqhgbd3zDObx2LCk93b89BoUoXsZRtxUbtdV2f5xXRqyYa4CW5zl6nwV/PWgy
 gxM6OkavmyaX+S5YPIHOVINdgp88eaT6hHImwwY+SsIfEeclxs+M32YXcnRsT3FtJq8Z
 wHxtUDHv40Sglb20LmmdvmSVWycMyzkW50xOzRd+dTaoGZGOuGH3rSjdF6I4XOGlmif7
 5xsVnZo4fMUIteaGR/ydke9L+MIaEhrvUIStWO5jhjYoDdG+PN7kDSFwExPFfCEmZUDj
 UdNscvpVqyNdZsrf1KioaGNvue226Ipm/PY9HlozRK4X8/EsXm+lRj+U0KC7jzCHS8J6
 7o9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Roqe50jEKfENDWiXE7Sw/L0KPH2kB0Rc5mPK3B8HJKZ7KIU2ww710ZgeXHw6BcTUK0ftzrIA+k=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwYLOH3K7/OECz9GVRRdHm7PL4RkpXwXeVOjUsSUL1q31Vv/seg
 7e9uGX3WkvNWpkTdVTCUaSP8gXS+Zij/2OyPhAydmcFztUAyTCBlejWOHq5otObo+io=
X-Gm-Gg: AR+sD12MPjJU26FnJXT4Nwk/Lcx3vwPR4am4pqE80nDMrbXA5WG/rZLdb8J1Cguj2F1
 LdKlI/m5NWfbunj1zNlxTmtp+XjbAgIedJKrSlLRtXAVxTs9hqo/mCoCwlaG0cSRdc2HrTA2QWk
 MknZHTTpWosLZz6FY/1BXstzlHr0Tpwru3CYWxCx21j8zLLklVFpAPe0pnwLaSmVKbXOxNZgvYm
 qZNB7P94DcIA1mS2aTZ0jnzPFTvEWjB/rtBh534v8jnnvpCWfNu7BadyeNU/G4fbtV9mlz+dy1t
 y/NBAs2Q/f9tPuhyBsLGHpjPrueTlvyYDIQfUHywXQqW7xbx3w5cou3jfdj0EWPc0G93hRhw9L0
 pNSE9K67b5OqD0I/H9fU838vEBt0EjQltYtSWUYxVGK3BnbuYTzKbkDKdqtCWcDmpYDOaCdoFB1
 IjF5Lc6rrJFyL498XpQlbuH3FkWavvJEKkNYG7YJMnx5o22BbREDu5AX9Xg5MScTIORg==
X-Received: by 2002:a05:6830:349e:b0:7e9:cce4:803b with SMTP id
 46e09a7af769-7f3de49bb3amr7364406a34.8.1786736805339; 
 Fri, 14 Aug 2026 12:46:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7124:5000:3b37:b131])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f3e86282fesm1575007a34.14.2026.08.14.12.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 12:46:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 14 Aug 2026 14:46:35 -0500
Subject: [PATCH] video: panel-startek-kd070fhfid078: new driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mtk-video-panel-startek-078-v1-1-5f84a57244bc@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQW7CMBAAvxL53G0d0iYmqqr+AyFrHS+wJU6C1
 wQqxN9rSI8jjWZuSigyiWqLm4o0s/A4ZChfCtUdcNgTsM+sVnpVa1O+Q0hHmNnTCBMO1IMkjIm
 OoBsDJa7RVYbMeteoXJgi7fj6rG+2C8vZ/VCXHsl/I9LpnLdp0VQgEXxu2+Jzueoa0HsbeGLrh
 e0lZtsKneyB+omiDdjFUWAuQUPtPqqqMcZr7L4d/vbsIr12Y/h6/BwKQYbAqS3GyHse3ga6JrW
 93/8Aa+QStwwBAAA=
X-Change-ID: 20260814-mtk-video-panel-startek-078-1a9ab38e89f7
To: Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12000;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=hZXoBMA1542IOea1hO+MsNDyNRXVgcjomAs9EgRm0q0=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqf3CcbxOuakx+9444VJoWGxI0ac8e1e64YkrSn
 U55KHLoCaCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCan9wnBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACG0H/j/yoyBQ+zJIzajEQKIhQQdqSRlvaETCVBEbU+v
 D9WR9Th1p3C69uIcJufMvfKvJbNqF7nXFzvi816tcU6lMrL50d5eFg+oe9WiKWNrLn8vNnhvCoy
 CzpS8EqZ5Ja3VRHaRguENQ9d8YOIFfGIt1InUhJBJW5sWTOaahpbANPJ1JPQW+98XJ2D0QxgNpV
 mGgpnBY5rMPzxdim94WOMciLdY77XsDJTiXWzHZcCfTmonTg2vXjQYsaItFvdZtCe3J2gxu/GDV
 qom2wNu7SZsBXIVoKqG0dC4zLs+dzB/P8eOq1f3a//3B8tuSLadj17BR8g8a3sLAMPH6TmWhDzS
 +Y8s=
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a driver for the Startek KD070FHFID078 7" DSI panel. This panel is
used on the MediaTek Genio 360 EVK board.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS                                 |   6 +
 drivers/video/Kconfig                       |  10 +
 drivers/video/Makefile                      |   1 +
 drivers/video/panel-startek-kd070fhfid078.c | 288 ++++++++++++++++++++++++++++
 4 files changed, 305 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index acaba95ed03..faef7b0aa2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1750,6 +1750,12 @@ F:	common/stackprot.c
 F:	cmd/stackprot_test.c
 F:	test/py/tests/test_stackprotector.py
 
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
index 15000e21840..64921155a54 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -320,6 +320,16 @@ config PANEL_HX8238D
 	  It can drive a maximum 960x240 dot graphics on a-TFT panel
 	  displays in 16M colors with dithering.
 
+config PANEL_STARTEK_KD070FHFID078
+	bool "STARTEK KD070FHFID078 panel"
+	depends on PANEL && DM_GPIO
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
index 082b8967982..bbde29a1cb0 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_$(PHASE_)VIDEO) += video-uclass.o vidconsole-uclass.o
 obj-$(CONFIG_$(PHASE_)VIDEO) += video_bmp.o
 obj-$(CONFIG_$(PHASE_)PANEL) += panel-uclass.o
 obj-$(CONFIG_PANEL_HX8238D) += hx8238d.o
+obj-$(CONFIG_PANEL_STARTEK_KD070FHFID078) += panel-startek-kd070fhfid078.o
 obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.bmp.o
diff --git a/drivers/video/panel-startek-kd070fhfid078.c b/drivers/video/panel-startek-kd070fhfid078.c
new file mode 100644
index 00000000000..8b96fe727bd
--- /dev/null
+++ b/drivers/video/panel-startek-kd070fhfid078.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016 InforceComputing
+ * Copyright (C) 2016 Linaro Ltd
+ * Copyright (C) 2025 MediaTek Inc.
+ * Copyright (C) 2026 BayLibre, SAS
+ *
+ * Authors:
+ * - Vinay Simha BN <simhavcs@gmail.com>
+ * - Sumit Semwal <sumit.semwal@linaro.org>
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
+	const struct drm_display_mode *mode;
+	struct udevice *dev;
+	struct gpio_desc *enable_gpio;
+	struct gpio_desc *reset_gpio;
+	struct mipi_dsi_device *dsi;
+	struct udevice *iovcc;
+	struct udevice *vdd;
+	struct udevice *backlight;
+};
+
+static const struct drm_display_mode default_mode = {
+	.clock = 157126,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 50,
+	.hsync_end = 1200 + 50 + 10,
+	.htotal = 1200 + 50 + 10 + 70,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 25,
+	.vsync_end = 1920 + 25 + 4,
+	.vtotal = 1920 + 25 + 4 + 20,
+};
+
+static int stk078_panel_init(struct stk078_panel *stk)
+{
+	struct mipi_dsi_device *dsi = stk->dsi;
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
+	mipi_dsi_dcs_write_seq(dsi, 0x11);
+	mdelay(120);
+	mipi_dsi_dcs_write_seq(dsi, 0x29);
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
+	dm_gpio_set_value(stk->enable_gpio, 0);
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
+	dm_gpio_set_value(stk->enable_gpio, 1);
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
+	if (stk->backlight) {
+		ret = backlight_enable(stk->backlight);
+		if (ret < 0) {
+			dev_err(dev, "enable backlight failed: %d\n", ret);
+			goto out_power;
+		}
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
+	dm_gpio_set_value(stk->enable_gpio, 0);
+
+	return ret;
+}
+
+static int stk078_panel_add(struct stk078_panel *stk)
+{
+	struct udevice *dev = stk->dev;
+	int ret;
+
+	stk->mode = &default_mode;
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
+	stk->reset_gpio = devm_gpiod_get(dev, "reset",
+					 GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (IS_ERR(stk->reset_gpio)) {
+		ret = PTR_ERR(stk->reset_gpio);
+		dev_err(dev, "cannot get reset-gpios %d\n", ret);
+		return ret;
+	}
+
+	stk->enable_gpio = devm_gpiod_get(dev, "enable",
+					  GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
+	if (IS_ERR(stk->enable_gpio)) {
+		ret = PTR_ERR(stk->enable_gpio);
+		dev_err(dev, "cannot get enable-gpio %d\n", ret);
+		return ret;
+	}
+
+	ret = uclass_get_device_by_phandle(UCLASS_PANEL_BACKLIGHT, dev,
+					   "backlight", &stk->backlight);
+	if (ret)
+		dev_warn(dev, "failed to get backlight: %d\n", ret);
+
+	return 0;
+}
+
+static int stk078_panel_probe(struct udevice *dev)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
+	int ret;
+
+	stk->dev = dev;
+
+	plat->lanes = 4;
+	plat->format = MIPI_DSI_FMT_RGB888;
+	plat->mode_flags = MIPI_DSI_MODE_VIDEO |
+			   MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			   MIPI_DSI_MODE_LPM;
+
+	ret = stk078_panel_add(stk);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int stk078_panel_get_modes(struct udevice *dev,
+				  const struct drm_display_mode **modes)
+{
+	struct stk078_panel *stk = dev_get_priv(dev);
+
+	if (!stk->mode)
+		return -ENODEV;
+
+	*modes = stk->mode;
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
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
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

