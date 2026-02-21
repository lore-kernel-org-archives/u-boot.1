Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1EDC61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C69983C5E;
	Sat, 21 Feb 2026 18:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F1Jmmlkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68A0883CF5; Sat, 21 Feb 2026 18:45:34 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93BB83936
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 18:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48069a48629so30612495e9.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771695931; x=1772300731;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9cpV3DIcd19kD2nJcXVa6BJN4zJzeh/R35+wd31ub9c=;
 b=F1JmmlkjuJK8227n/8PxkSk5Z7Owsq9o4o+xX/90wbPqFPRgdCj2inQhE9yiq0AnlE
 xj57myIvXg7TCQ9kTppzFTcVpctrN8hZmVIF3+Co8yDlBizc7/0AZCEmW5a5aYdGxW0O
 J+E507aoOnDMKWOTcf3eSibYXHQfS8cSVisWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771695931; x=1772300731;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cpV3DIcd19kD2nJcXVa6BJN4zJzeh/R35+wd31ub9c=;
 b=ozwhcRqX1usO/6+bgM1j2P/v6UtaFzHPsbrBnvBG7W+SX5GqmPeM/qIdgbnDj7qKNR
 3sO9rF0kqv2rUKTBTw04xYXjCW5thti5r43How/5UCD+kNBHcjlTzx1ekavsQZANN36k
 ZjFDhsYEOs26Qx6oLZ3CO6KiDZaBVUlY/fyZEvt+bdGI6/ZXKxNtRI8xODEGXIooDejP
 a40wunP6NDHi36wR0b/9DcsB1yKkpG+BVyLU/5OUKUIsc8Ce2CAtofh1n5ZKN01DNbZ4
 5OqQ0/V/mh10fpiv7EhA9rY/+zaPvrxqr69RgBwNK5QBb0TDN3lu/aY8px841oZSbU7f
 19kQ==
X-Gm-Message-State: AOJu0YwtbdFj0CFZU75cyD1rAo7goHpI59ke7Etmt6Mh/bhjqzSCCVL5
 BMuzX/JeTv5bZTishIOivG3Dge3z0v3Egt7GAVRbViE7F03PR70mp8WAauOLoxzKyYgITYwM5S0
 xDbww
X-Gm-Gg: AZuq6aK5Yyp6JbNXveURhnF+8iWVhzTwlFxnrpill9opvn4bAes3eTVbPFoen9b3gAm
 QpNdEYxs/O9RH1tWIcvf9URdoHuC2Ie35cHI//e2MBVEVYM5dv+7euHGaAAJ/B55Z5iJkqDilvN
 iKpZVBobAT5270oWzEPbw6f6orHuaI+fnTHdEfEdm6lO/EE7tWkYubj0jVp4t9WkRF4RgEEy/Bu
 t5JKj8GAQ/c1BPEYX9Sq9ovNT05Rs72cDtzIgcSm+K82l6vVpzVnzIilF7Tke5ZXeKOtVh5pNwN
 bXosPs8rAL3k4ICUdKz66lhR6CSXzPmZxfHC/YCorESrKsgbAzdl0pgTMUEe8wDEiCHDKJIehIe
 pgmo9VM+coNoW9CTPwDYulvUqmPi/a4XgmZySmGGswQR3f0J3gf19K5J2xCm/GT3SvlJiIAuxxc
 HXnfXyK8EbWXRWkgb7iF0AI+/j22yTtwuG/o1Zn8YpA+zn8/eIBeBzQ1+efh6WaO7l4zbctOydO
 lIgGx+akvOq/rePjVEoA12JzXGOsCjFw5F+te8nfIVS8ZVIdc7SL9IM1NXK8mHobp9W9+fQfQ3j
 R92xO2Vce3ofp7sNilCeydc3
X-Received: by 2002:a05:600c:4452:b0:477:63b5:7148 with SMTP id
 5b1f17b1804b1-483a95a859dmr54650315e9.6.1771695930736; 
 Sat, 21 Feb 2026 09:45:30 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31c0779sm237401845e9.6.2026.02.21.09.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 09:45:30 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: kconfig: replace tristate with bool for LCD panel
 drivers
Date: Sat, 21 Feb 2026 18:45:10 +0100
Message-ID: <20260221174522.3106292-1-dario.binacchi@amarulasolutions.com>
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
---

 drivers/video/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 08c9b0207884..8f45c229f5c8 100644
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
@@ -553,7 +553,7 @@ config VIDEO_LCD_HIMAX_HX8394
 	dsi 4dl panel.
 
 config VIDEO_LCD_MOT
-	tristate "Atrix 4G and Droid X2 540x960 DSI video mode panel"
+	bool "Atrix 4G and Droid X2 540x960 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -600,7 +600,7 @@ config VIDEO_LCD_RAYDIUM_RM68200
 	720x1280 DSI video mode panel.
 
 config VIDEO_LCD_RENESAS_R61307
-	tristate "Renesas R61307 DSI video mode panel"
+	bool "Renesas R61307 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -609,7 +609,7 @@ config VIDEO_LCD_RENESAS_R61307
 	  resolution and uses 24 bit RGB per pixel.
 
 config VIDEO_LCD_RENESAS_R69328
-	tristate "Renesas R69328 720x1280 DSI video mode panel"
+	bool "Renesas R69328 720x1280 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -618,7 +618,7 @@ config VIDEO_LCD_RENESAS_R69328
 	  resolution and uses 24 bit RGB per pixel.
 
 config VIDEO_LCD_SAMSUNG_LTL106HL02
-	tristate "Samsung LTL106HL02 1920x1080 DSI video mode panel"
+	bool "Samsung LTL106HL02 1920x1080 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -627,7 +627,7 @@ config VIDEO_LCD_SAMSUNG_LTL106HL02
 	  resolution (1920x1080).
 
 config VIDEO_LCD_SHARP_LQ079L1SX01
-	tristate "Sharp LQ079L1SX01 1536x2048 DSI video mode panel"
+	bool "Sharp LQ079L1SX01 1536x2048 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -636,7 +636,7 @@ config VIDEO_LCD_SHARP_LQ079L1SX01
 	  resolution (1536x2048).
 
 config VIDEO_LCD_SHARP_LQ101R1SX01
-	tristate "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
+	bool "Sharp LQ101R1SX01 2560x1600 DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -680,7 +680,7 @@ config VIDEO_LCD_TDO_TL070WSH30
 	1024x600 DSI video mode panel.
 
 config VIDEO_LCD_HITACHI_TX10D07VM0BAA
-	tristate "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
+	bool "Hitachi TX10D07VM0BAA 480x800 MIPI DSI video mode panel"
 	depends on PANEL && BACKLIGHT
 	select VIDEO_MIPI_DSI
 	help
@@ -695,7 +695,7 @@ config VIDEO_LCD_HITACHI_TX18D42VM
 	done they work like a regular LVDS panel.
 
 config VIDEO_LCD_SONY_L4F00430T01
-	tristate "Sony L4F00430T01 480x800 LCD panel support"
+	bool "Sony L4F00430T01 480x800 LCD panel support"
 	depends on PANEL
 	help
 	  Say Y here if you want to enable support for Sony L4F00430T01
@@ -704,7 +704,7 @@ config VIDEO_LCD_SONY_L4F00430T01
 	  data comes from RGB.
 
 config VIDEO_LCD_SAMSUNG_S6E63M0
-	tristate "Samsung S6E63M0 controller based panel support"
+	bool "Samsung S6E63M0 controller based panel support"
 	depends on PANEL && BACKLIGHT
 	help
 	  Say Y here if you want to enable support for Samsung S6E63M0
-- 
2.43.0

base-commit: 30b8c03d8c8f500b3e4cc51f7b7abf573180ea51
branch: video-fix-tristate-kconfig
