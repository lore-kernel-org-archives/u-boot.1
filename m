Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFCAEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837CA864CB;
	Tue, 22 Aug 2023 13:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ox0Huhqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FBCD864BC; Tue, 22 Aug 2023 13:22:50 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DEB1864AD
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff91f2d7e2so6166612e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703367; x=1693308167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpBKOJnyExK5FUhPY8qHpFnuQEKA7o+eM49Y7TW9504=;
 b=ox0HuhqjDU5rYJZfXzQESybCm4k3xiCmfKoIigeEqQrGntw6y+TOLvWJHua23ivfQY
 +n063ZVOEWTWOB/Nyo1g7OSV75Olq0Qn4v4gJrr1j4uokyr9FDZGvG5bKpAfqaDaOCBA
 Hn0U6iAlOIUFRBMSD/E/IPpdV02ArEWnLy3PM54OlEsUA5H0+NVxZafPIhUioP7HBofG
 YdpMk59nxDIrAh10HriF2NVbLfjXVkLkQfFo8fKRPxyuLg67bt8UirdwSPJVp6PtzcCh
 Qse+rBGxXREx4F5oh+ha0O2JavWC41Z3wFQCixXsg3sWtAH+ibWfDPb+R9fbID8dtPMB
 fu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703367; x=1693308167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpBKOJnyExK5FUhPY8qHpFnuQEKA7o+eM49Y7TW9504=;
 b=DZnZON6uqKUeQeg9/BtskK56h7S1/Kfb32M8YnGemDgWUP1hpxjeMF2dmv24lm3eVa
 uW7b6MgLER5Xk2q8vJCly+FvqDn5BaFK7Xppdyb6SAbQk3MyCNCcAb7sebNxBHFQrMyW
 1JCu/7M97rF65AaYffoKI8FmPSQ/8o6oEsvHqzM9RZgWNgoSgjCNmgf+AS1zFkB5Ty6Q
 jJGHsb//2cYYQGyw2JNHb+Z32DGS1gC8v/Mj3YiDgUypfUXAUYiEycZ+9uS4E4iOVvs8
 MeqAHzThb/zz3K2U/jPlAv3Pl4rVwyL/rf4ObWZ9FI/EW2mFuQJAgaio3eQrdy1lttfN
 gBFw==
X-Gm-Message-State: AOJu0YywcoI0t0DuLVvU+wI/uYa3ABX22XXUoTWM3xOBeBA3hE6Cb9vO
 ITFK/F84sd1iguNdY8qYOpbeqtTBvwDFCw==
X-Google-Smtp-Source: AGHT+IHYBGYkz5v5Y02W6sBWwkDPwkJxc5rGl2hhgky+mQYHGkxZly6a/TXeb06iO6cBYvrhBOhx9Q==
X-Received: by 2002:a05:6512:224e:b0:4fb:9469:d659 with SMTP id
 i14-20020a056512224e00b004fb9469d659mr7871683lfu.23.1692703366363; 
 Tue, 22 Aug 2023 04:22:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 06/19] configs: transformer_t30: convert bootmenu option
Date: Tue, 22 Aug 2023 14:22:04 +0300
Message-Id: <20230822112217.4646-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

