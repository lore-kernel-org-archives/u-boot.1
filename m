Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64361109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618D28410C;
	Wed, 25 Mar 2026 20:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sIGDE/Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DABF840F1; Wed, 25 Mar 2026 20:00:46 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12840840AE
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67df51b26ddso178820eaf.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465243; x=1775070043; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=93pYzFTv+8s6gIrmWKnb1epf4il6egfUZ3e0tpF4Nr4=;
 b=sIGDE/NhREheUdkkVqdIGMFcUONSsmiOTgqwsf16erzpNKYzq7m0j4boIMdgrZh7oV
 9ZYQYTiSqNguSxQCsWktnex+VORBLjXmx/IBZDxkyWFZkllx0NloN9CuUlFNOWPgxoXJ
 AwDJd0fIREecxpqwtpIEKxKl7OoVmTsbg539w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465243; x=1775070043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93pYzFTv+8s6gIrmWKnb1epf4il6egfUZ3e0tpF4Nr4=;
 b=bGlW8kT8D9iG4s5wQ2YqkBuzbmoUqdt3PCGt7JczJvjFnlVp8S4g32OPx7+EeowEbh
 QeuME6OUhKPaOgV40exOO5pXcKp/EdvhxmU8w8tYiEQRdMfuf7yAP6JlZ1jbkNqNf4I3
 KW/WUhHlOe+giAzbWTwJOS1hTM4WzsOwZMczpRZM52Qgla20FQZONjt59QGwMXxmsJ6w
 llds6g2o0RsMNLFDs/n5k2NDMAuR8Y1RxiMyHgdCGPb5NKO/M9J/Tw8VwRh6zdrJJtOl
 FOiYqPgT1HUpNNas2wZ2W9pD6HLCKA1nRIVLudmVnpADxN+sERzXyrQWggCy0MnSclbO
 OLGQ==
X-Gm-Message-State: AOJu0YzskeM/zBzj41zavKP7nskh2Q87/nl5+T3dsh1MKLSYPbFYutGc
 yl/abSJc0RqJaj3wfmohRnqnh8gPd+zFhIUw8B7nV3LFAqPjY4g3NHNwuU+C7LOt16I5YQdk5dx
 UEmnPlkY=
X-Gm-Gg: ATEYQzxSViFF9CDfECNH/zmYTJnO+XWacpBTXQy5v2xjJ9YoMISUQcBthczKgJQ3ZLZ
 SrGgLe2r54hFwYLSlJCscSRXjC3yelEe3Lc5lGLIXDn9OrWKPMaQgSLJUYn/i5yYqtqLCsvo9Fx
 fODoFluXcED4cJngJ6u1923vsuZEnw/80b5XLCux1Swc0u83e7BswhEHCkPvguhmXfn6CVSLErU
 ystufLHif8ln3zprFQ9vesHXG8OxXgxs6xdL1aW0HUMUkrMD310C4bpbMFYGjxjzW+LbphQnYFV
 dUi8B8fsv8kuT9EYgFMzf5XXsiPM+3heYOPMPCMTg4CLOAFWlXRr+1wtzehdPD30WxxbqDsnrJT
 hScOEpOxgSyYzZHulCRSyd66guOzrijiXRd8WMSpXtiWL9tR2K7rBljMNwO7MO8AAR08gUYYD25
 pCHtuPqyW06yhrKGd/VX6B7KDk0O2jlMTmSbHGbQsQhdr4DDoOd9sXRT8LSS2HqUtWb9pDO7J6/
 0GKZ8DfGYiLzdYup2EWenJ/RvyEIIRIGKICmeqMhrBMXJ716X4=
X-Received: by 2002:a05:6820:210b:b0:67c:27a7:8c4e with SMTP id
 006d021491bc7-67dff43e3a1mr2616325eaf.30.1774465241303; 
 Wed, 25 Mar 2026 12:00:41 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e0ab274c7sm443420eaf.13.2026.03.25.12.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mx6sllevk: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:39 -0600
Message-ID: <20260325190039.3428728-1-trini@konsulko.com>
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 board/nxp/mx6sllevk/mx6sllevk.c    | 5 -----
 configs/mx6sllevk_defconfig        | 1 -
 configs/mx6sllevk_plugin_defconfig | 1 -
 3 files changed, 7 deletions(-)

diff --git a/board/nxp/mx6sllevk/mx6sllevk.c b/board/nxp/mx6sllevk/mx6sllevk.c
index 9e39e39ac903..3d2397c52c12 100644
--- a/board/nxp/mx6sllevk/mx6sllevk.c
+++ b/board/nxp/mx6sllevk/mx6sllevk.c
@@ -76,11 +76,6 @@ int power_init_board(void)
 }
 #endif
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 int board_init(void)
 {
 	/* Address of boot parameters */
diff --git a/configs/mx6sllevk_defconfig b/configs/mx6sllevk_defconfig
index f126c6e1e796..06474cb94e87 100644
--- a/configs/mx6sllevk_defconfig
+++ b/configs/mx6sllevk_defconfig
@@ -16,7 +16,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
diff --git a/configs/mx6sllevk_plugin_defconfig b/configs/mx6sllevk_plugin_defconfig
index 134475d24d80..b340d9c9f957 100644
--- a/configs/mx6sllevk_plugin_defconfig
+++ b/configs/mx6sllevk_plugin_defconfig
@@ -17,7 +17,6 @@ CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else run netboot; fi"
 CONFIG_SYS_PBSIZE=532
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
-- 
2.43.0

