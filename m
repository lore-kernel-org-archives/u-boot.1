Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46BF428C2
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D94484178;
	Wed, 15 Apr 2026 20:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NXoF34Q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E51841C2; Wed, 15 Apr 2026 20:44:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF6338412A
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso57510385e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776278645; x=1776883445;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aov5/nf800okoXJV5pCy5R3UvC8qdg0XwUrnncuuqLU=;
 b=NXoF34Q4xAIIFOYyhAp6EY3/XkgtBbE9lTnb4yHCpcbI6TRhcSNkSu5xrkgSNC03gV
 4wZCU67P4VJhu2I0u5l4upNOML+Wuj3Z9EFyqTp1bjZlKkbGHajLtuRZdMhGTUuqfvim
 JkVSGFWMN0Ci6wUt4RvtYk3tOkvr2Ps0YxdRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776278645; x=1776883445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aov5/nf800okoXJV5pCy5R3UvC8qdg0XwUrnncuuqLU=;
 b=K7TPqbl3R2D3G9ninbStfo288Fd6hHHLl+Mg6ditEPzBJ+CYu97bxkWdqML8F+ygDe
 jmCkIJT+n3gOgJTj+4Ph2U/uaIqZVvZSe3P6ZRBcto2RN4MLbMz8kCQAPu3SWBnJZIXA
 eiSxgT8NfcXl1K1DwgG6t6lGyGOtH82s5Qc1GXm7aNcbTTPBM/CnqKxRyC3gSdSpdhfR
 WlD8BT2yX41//4gHRTZwknprJGYL4djaXnIaewBIIb99Ni/lZw96r41fR9IxLyeJIamF
 DNkQGF7Nw3UoPDzzAXM6yKpfAGEeIWhc2qHslWckADfOXkyFiKHFesR+A8LPi7eWiI/z
 zvWQ==
X-Gm-Message-State: AOJu0YyBBddnagA6y3NnRw/IT2sjL1RLUs/KuA7PfIevS3ALefjIdN2N
 y7x9b7SOItjv3BHeD5DAqJBO7Sz35Xr4a7RMeEjH3/lt0HuisynfRhkTEeWoM1czhGnrJYwECg4
 9cgJ4
X-Gm-Gg: AeBDieteZgMC0AOacnKT2bPIX0JN/N/psAryHiJAujMK6rctalP6aeL64NPcJBRoGs4
 j9QidcDAm6k3046Rdw/8imeKFO6yM/ZmF7by0zalsMhLdCxCQQYsdQBtOwyRzALTy+nkRTOEePQ
 K4T/1hsqJUykqfs/fno78WrR6Kr3NSI2xEkWe6Zxji+Pc3p6SJGErLXkLZ1uGULzwzrDwTLzlZF
 Yl/AnWrHv50Jm9Qu58e+vj3O0E2CYbxJnHSQUHK0oEKpcVX8+GIclGnqvZU+pMA5keBqXmGcqo7
 LdVqnGMek0Cqp7zJ0mRwdNBLoi67t2hAwqevYM/RCNTPLkTDnMh4KkGYtB01rw1w7Jr0rekH6Qz
 Hb/RIwdo0I13N+sOb3Vh1DMyO71fdmAs/10IATH3vsdLE8NSMtVLkfDHRbLSXYqPC+kJAnEY7Pk
 XWD41kMygRViMhjOOrHrXYblEIO9i4DD3uLLxfsjaxYF4SzLvrXehjsvtR6nGH9PmEAOXLrLmzZ
 n6CHarlrNuD7dmyt9NLC3Gvpzn7ZqPUq1RWnUMstKQFWZV6+TRIfQhY+Q==
X-Received: by 2002:a05:600c:64cf:b0:485:b6dd:5066 with SMTP id
 5b1f17b1804b1-488d67ce664mr306058475e9.7.1776278644596; 
 Wed, 15 Apr 2026 11:44:04 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3564d8sm8166906f8f.10.2026.04.15.11.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:44:03 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: [PATCH v2] video: kconfig: replace tristate with bool for LCD panel
 drivers
Date: Wed, 15 Apr 2026 20:43:52 +0200
Message-ID: <20260415184359.3033043-1-dario.binacchi@amarulasolutions.com>
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

base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
branch: video-fix-tristate-kconfig
