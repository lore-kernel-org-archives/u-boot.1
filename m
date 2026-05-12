Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB62BCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 07:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155A080398;
	Tue, 12 May 2026 09:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dRKfNgKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63F88803C6; Tue, 12 May 2026 09:54:18 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75ECD801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 09:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so87627065e9.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1778572456; x=1779177256;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DL8PbuZ0UBX8hfxbAGo5l/6wcE6Im140K4F7tIm9894=;
 b=dRKfNgKJGN7sEt+D3EiZyrSlTol937HpHx8pl4cd559LJZ01dVlPbqdtTUQaf9Ij9t
 KmBGwuY+WKKn2KEhmrQQYYepoujrbrf246z398ON2ylUD5lLyhlSClDxKj38l8qpJnge
 d3TKQP9KfRgwo0YlFsNrlM1NrZEGK+2tOcYKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778572456; x=1779177256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DL8PbuZ0UBX8hfxbAGo5l/6wcE6Im140K4F7tIm9894=;
 b=bQxI81b6PVmUuiRwYcgnB7yCpucLGLAKeOK2c9RyZu49FEc25VpP8zcFxTYZi/LE97
 egmlC5XxAAYTBxZ2LKK4dq76lZNj3BLQKZmjOriy+7Ww8sFfwFn/e023ZM26nAuYlY5n
 6z1yDBKo3cK2hU/3rVl/FZmUxZRpPSJAs0RQweAg2yJm5Uv4y0lvZk0ypZiKmNQSV00i
 qXsKvZaspmBp8ABSZmK+1RLUHQVxCUhCm6pCY1CplDOXFa2qXIJxtsus70PHM88ypwDr
 PLNntoF504y9vre4ztZ/qsZLI21v6dejk5NOrtKwX1pd0PYmluovT1Ft2oioYAdmbbJe
 pYmw==
X-Gm-Message-State: AOJu0Yx1n5WOnx/ELZO1+i9NBCvqKe+M/ujdCLwoKq5h+QSTJuX+0ZO6
 0ceLHpjICFktrE1XtZQDLcx9Hfgod4otuOF4dYRDGgfdr+A0xXLm7usS6G9g7r6600f6KrScOEF
 1/ZUq
X-Gm-Gg: Acq92OG0x/JZpaRHeQVszAUyWsOTRG59X3m98skWhKPAOLomkp3qzE3dYd+I31w1wlT
 yDKtwQHBYxkWuUPC+qfNAGFsvOsCkLnWGPDIojyjFcAq5ZDB3dp1IdCmlJAIc5ZPAg76o/QzKS0
 GKkec1fM1nlTcgeForu+7akiRB7gZLuuJWV0PaPhkOFsUHDtXNf6eNBAmZ8ZVUx1wUSTgkRH9Na
 KyEF9DoLB4r+i0XcDYX/2031JadLJ33AT9dPzpC0d7W4rABQ9f4JpXuC/ibQlt3OKJZYTxvdwOF
 /4TXHyY4OXi9OIwG13+z/goe29Q+yqVxRhjN1g1gt7yKjHUxPSZzVrFbn24FyZahrQnmBFeMvdI
 o+YjBquvjvn3zg2h6OPqjAI4uFIUzzmIszwYwZMogpA5cfy3X9aApt7wgt3dqS846lRRC04ZQS3
 SDIQtuRTtnorcDSkf88viKdSX1/oait77rbPrBk/iuYCI+tYT5qlWf4wqsxv8ZPwvScrgJLOM8h
 sjfVSo3H2/M0AVCDHnp8SvqA9zGazuJh413Hcn1NIR0DnI=
X-Received: by 2002:a05:600c:a307:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48e51f4111fmr333820855e9.19.1778572455061; 
 Tue, 12 May 2026 00:54:15 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e908cb403sm26760855e9.9.2026.05.12.00.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 00:54:14 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RESEND PATCH v2] video: kconfig: replace tristate with bool for LCD
 panel drivers
Date: Tue, 12 May 2026 09:54:01 +0200
Message-ID: <20260512075410.567751-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
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

U-Boot does not support loadable modules, therefore using 'tristate'
in Kconfig is incorrect since the 'm' option cannot be selected.

Replace tristate with bool for the affected LCD panel drivers to
reflect the U-Boot build model and avoid misleading configuration
options.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

---

Changes in v2:
- Review-by tag of Tom Rini and Svyatoslav Ryhel

 drivers/video/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index c2acc13139c0..747c68e12cce 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -534,7 +534,7 @@ config VIDEO_BCM2835
 	  that U-Boot can access it with full colour depth.
 
 config VIDEO_LCD_ENDEAVORU
-	tristate "Endeavoru 720x1280 DSI video mode panel"
+	bool "Endeavoru 720x1280 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -561,7 +561,7 @@ config VIDEO_LCD_ILITEK_ILI9806E
 	  is implemented.
 
 config VIDEO_LCD_MOT
-	tristate "Atrix 4G and Droid X2 540x960 DSI video mode panel"
+	bool "Atrix 4G and Droid X2 540x960 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -608,7 +608,7 @@ config VIDEO_LCD_RAYDIUM_RM68200
 	720x1280 DSI video mode panel.
 
 config VIDEO_LCD_RENESAS_R61307
-	tristate "Renesas R61307 DSI video mode panel"
+	bool "Renesas R61307 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -617,7 +617,7 @@ config VIDEO_LCD_RENESAS_R61307
 	  resolution and uses 24 bit RGB per pixel.
 
 config VIDEO_LCD_RENESAS_R69328
-	tristate "Renesas R69328 720x1280 DSI video mode panel"
+	bool "Renesas R69328 720x1280 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -626,7 +626,7 @@ config VIDEO_LCD_RENESAS_R69328
 	  resolution and uses 24 bit RGB per pixel.
 
 config VIDEO_LCD_SAMSUNG_LTL106HL02
-	tristate "Samsung LTL106HL02 1920x1080 DSI video mode panel"
+	bool "Samsung LTL106HL02 1920x1080 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -635,7 +635,7 @@ config VIDEO_LCD_SAMSUNG_LTL106HL02
 	  resolution (1920x1080).
 
 config VIDEO_LCD_SHARP_LQ079L1SX01
-	tristate "Sharp LQ079L1SX01 1536x2048 DSI video mode panel"
+	bool "Sharp LQ079L1SX01 1536x2048 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -644,7 +644,7 @@ config VIDEO_LCD_SHARP_LQ079L1SX01
 	  resolution (1536x2048).
 
 config VIDEO_LCD_SHARP_LQ101R1SX01
-	tristate "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
+	bool "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -688,7 +688,7 @@ config VIDEO_LCD_TDO_TL070WSH30
 	1024x600 DSI video mode panel.
 
 config VIDEO_LCD_HITACHI_TX10D07VM0BAA
-	tristate "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
+	bool "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -703,7 +703,7 @@ config VIDEO_LCD_HITACHI_TX18D42VM
 	done they work like a regular LVDS panel.
 
 config VIDEO_LCD_SONY_L4F00430T01
-	tristate "Sony L4F00430T01 480x800 LCD panel support"
+	bool "Sony L4F00430T01 480x800 LCD panel support"
 	depends on PANEL
 	help
 	  Say Y here if you want to enable support for Sony L4F00430T01
@@ -712,7 +712,7 @@ config VIDEO_LCD_SONY_L4F00430T01
 	  data comes from RGB.
 
 config VIDEO_LCD_SAMSUNG_S6E63M0
-	tristate "Samsung S6E63M0 controller based panel support"
+	bool "Samsung S6E63M0 controller based panel support"
 	depends on PANEL && BACKLIGHT
 	help
 	  Say Y here if you want to enable support for Samsung S6E63M0
-- 
2.43.0

base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
branch: video-fix-tristate-kconfig
