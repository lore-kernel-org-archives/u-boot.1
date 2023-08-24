Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6FEC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BBA86961;
	Thu, 24 Aug 2023 21:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q+bjz95V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3F186961; Thu, 24 Aug 2023 21:26:57 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2D68675B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52a1132b685so341716a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692905214; x=1693510014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpBKOJnyExK5FUhPY8qHpFnuQEKA7o+eM49Y7TW9504=;
 b=q+bjz95VIsbqy6nmYXqUhkZ/X0qcgVwHjNJZYtrMngmATk7EblmYSb08Evv4bRo9Lz
 pGQIo8G1nZrfAKcPabJbKlC5WJLQs43RAUMRJF77/1Y4CAl3crobY1BLeZ4x3EgsUySw
 /qLlE230tWJ5KOBrJhPIxouon/ITzrIYle1OxTGmZO8cMIiApE+8QyT4tvKDwG27mTKh
 4z7L1DyOXuoctoq9zDR0tEF1Eh8XhTKflL+mTHUTQDx+RTKy3kzbntcBZu5lZIRvb66n
 vkBFLDyYFzLqTihnPmb20O+ICIO58/yD4X5rCm//Ud/gNszt/tcPLNkYQ5vskhCyyuEG
 1nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692905214; x=1693510014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpBKOJnyExK5FUhPY8qHpFnuQEKA7o+eM49Y7TW9504=;
 b=A9vfoB2YpO4NePvxqL/lR3FhJyy2FXnwbFvOltbvAfJ6vmpu17a0wIyZ++80FrzSQs
 Rxzp9j+nROV5mOTC/v4GkBmzUQU2Zq29Q/qgvlNi1fPRjRxBXgA1yEGW6j+OUgVSqNo0
 q5zNtwNeiU+/CP1yZF9PvZdtTN/tMxrZvOTcNk/ukJVKZpC5cHTfHP6sGNjbucgsMTCt
 o3KFPySZovTiK3IrQgCg24ahHPlmjhhnOA/y7iFBmNk/PYnp48LETi8b20hw8lVl4Fyx
 vMCmL9TiWQtka2T9U+/nsvNwrUiXq9KMS62loJgFA+Ygg1L+0kInw/PtDI0q3dB99NxA
 URFA==
X-Gm-Message-State: AOJu0YxwpMTxjySsXuarDCKh/gXuWnRqy7f7laKfQCPZgYtFGiMvL0OF
 ewFd4vgw7lWvEQRMEk0Yc4c=
X-Google-Smtp-Source: AGHT+IGM1xghCKm4SlEVt2a2pZiRyzzRXEfYNOe5wyUg4OuagKEQuVU2eBKJTa68Tz6HS9WcrsN+CQ==
X-Received: by 2002:aa7:cd50:0:b0:523:b121:4228 with SMTP id
 v16-20020aa7cd50000000b00523b1214228mr10734586edw.41.1692905214089; 
 Thu, 24 Aug 2023 12:26:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 be20-20020a0564021a3400b0052a1d98618bsm96033edb.54.2023.08.24.12.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:26:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 06/16] configs: transformer_t30: convert bootmenu option
Date: Thu, 24 Aug 2023 22:25:53 +0300
Message-Id: <20230824192603.240104-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192603.240104-1-clamor95@gmail.com>
References: <20230824192603.240104-1-clamor95@gmail.com>
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

Convert refresh USB to enter console. Transformers have full size
USB and a dock keyboard so access to U-Boot console would be handy.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/transformer_t30_defconfig    | 2 +-
 include/configs/transformer-common.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index 840431ff38..802dcb1786 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff;"
+CONFIG_BOOTCOMMAND="setenv skip_boot 0; setenv gpio_button 150; if run check_button; then poweroff; fi; setenv gpio_button 131; if run check_button; then bootmenu; fi; if test ${skip_boot} -eq 1; then; else run bootcmd_usb0; run bootcmd_mmc1; run bootcmd_mmc0; poweroff; fi"
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/include/configs/transformer-common.h b/include/configs/transformer-common.h
index dcdda1ec5b..3b7db0ab14 100644
--- a/include/configs/transformer-common.h
+++ b/include/configs/transformer-common.h
@@ -64,19 +64,14 @@
 		"else echo SPI flash backup FAILED! Aborting ...;" \
 			"poweroff; fi\0"
 
-#define TRANSFORMER_REFRESH_USB \
-	"refresh_usb=usb start; usb reset; usb tree; usb info;" \
-		"pause 'Press ANY key to return to bootmenu...'; bootmenu\0"
-
 #define TRANSFORMER_BOOTMENU \
 	TRANSFORMER_FLASH_UBOOT \
 	TRANSFORMER_FLASH_SPI \
-	TRANSFORMER_REFRESH_USB \
 	"bootmenu_0=mount internal storage=usb start && ums 0 mmc 0; bootmenu\0" \
 	"bootmenu_1=mount external storage=usb start && ums 0 mmc 1; bootmenu\0" \
 	"bootmenu_2=fastboot=echo Starting Fastboot protocol ...; fastboot usb 0; bootmenu\0" \
 	"bootmenu_3=update bootloader=run flash_uboot\0" \
-	"bootmenu_4=refresh USB=run refresh_usb\0" \
+	"bootmenu_4=enter console=usb start; setenv skip_boot 1; exit\0" \
 	"bootmenu_5=reboot RCM=enterrcm\0" \
 	"bootmenu_6=reboot=reset\0" \
 	"bootmenu_7=power off=poweroff\0" \
-- 
2.39.2

