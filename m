Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CC6E67814
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031F28910A;
	Sat,  2 Nov 2024 23:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mrEgy0Z3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C68389080; Sat,  2 Nov 2024 23:20:19 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DE8892A2
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:20:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20cf3e36a76so32594135ad.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 15:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730586015; x=1731190815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAn85OAkLGDECvFRGhP/lDR01d13zdnILV570yMhkzo=;
 b=mrEgy0Z3sTLHlYWACwVGNrKLF35QImwfa/2XZB+iJjiPAW3repugbF0lybgz4oCFTg
 gBKEvDB1xgXD9yOZw8xoa+BcoCGX9KXvUZNzNdjDOkIDsr47NBQ9tn9rm6IaLbz2SAOy
 XsyFCmlrIQQVzCFksQeJJoPzwUZicfmn8hPcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730586015; x=1731190815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAn85OAkLGDECvFRGhP/lDR01d13zdnILV570yMhkzo=;
 b=tyB/ftITm/hLrgtqhhwV4Xw69LTKRarrwyn9TkVp2u9HNYhyUJG9jJt2TY0gs8cRFJ
 SI0LDEz0TsA6bMkB1pB49N84lCFrahRaF3dutuykRrJQ9P72guKxuWkSEeHfEl/BECZn
 /ffhi7E/xenpWGg+9I+AtG9Ulk7vKyqymWSD+S9CMoTEa261PQDm3ADEeq12iFUCv26f
 zP7fGZsFubxaN/+uCfDkp/StVdnWK/4ftrCejy6wtdIV7jgpxBoP9rOkvbK0hdXpgEju
 eHaIqPG4pto65pLB7fAeKUCeORbYV/Thls/5MIMK6+CwKaYC4ZweshtQIYNr/KW30P5H
 uTIw==
X-Gm-Message-State: AOJu0Yxbw/c5wP20YQ1Hwolr971UONInjyAOx2oQGPLBryWUOAVfUsr7
 UaICf2KeDvvkOD6y9rrUorAwA9tjQZguB5cmQfU8O49pczpTNlMSCLW+JRg2z8jRQ3gUHR/apb+
 mqA==
X-Google-Smtp-Source: AGHT+IHrO0QRoVvq3d6aQARsT4ZjRVfMxN1F4aqULrHE/FtAMIdiwj5UMAJgPs14MdfQHjmafBFw9w==
X-Received: by 2002:a17:902:cf4c:b0:20b:7be8:8eb9 with SMTP id
 d9443c01a7336-21103c971c0mr136338635ad.54.1730586014662; 
 Sat, 02 Nov 2024 15:20:14 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm4386286a12.59.2024.11.02.15.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 15:20:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 02/25] vining_fpga: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 16:17:00 -0600
Message-ID: <20241102221737.547938-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102221737.547938-1-sjg@chromium.org>
References: <20241102221737.547938-1-sjg@chromium.org>
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

This is not used anymore, so drop it.

Enable LED and LED_BOOT instead, since this is the new way to access the
LED functionality.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Combine removal and enable patches

 board/softing/vining_fpga/socfpga.c   |  4 ----
 configs/socfpga_vining_fpga_defconfig | 13 ++-----------
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/board/softing/vining_fpga/socfpga.c b/board/softing/vining_fpga/socfpga.c
index ec2c7ea3631..700184cc575 100644
--- a/board/softing/vining_fpga/socfpga.c
+++ b/board/softing/vining_fpga/socfpga.c
@@ -8,7 +8,6 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
-#include <status_led.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -26,9 +25,6 @@ int board_late_init(void)
 	const unsigned int usb_nrst_gpio = 35;
 	int ret;
 
-	status_led_set(1, CONFIG_LED_STATUS_ON);
-	status_led_set(2, CONFIG_LED_STATUS_ON);
-
 	/* Address of boot parameters for ATAG (if ATAG is used) */
 	gd->bd->bi_boot_params = CFG_SYS_SDRAM_BASE + 0x100;
 
diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
index 094e9186fca..94018752b40 100644
--- a/configs/socfpga_vining_fpga_defconfig
+++ b/configs/socfpga_vining_fpga_defconfig
@@ -77,17 +77,8 @@ CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-CONFIG_LED_STATUS=y
-CONFIG_LED_STATUS_GPIO=y
-CONFIG_LED_STATUS0=y
-CONFIG_LED_STATUS_BIT=48
-CONFIG_LED_STATUS1=y
-CONFIG_LED_STATUS_BIT1=53
-CONFIG_LED_STATUS2=y
-CONFIG_LED_STATUS_BIT2=54
-CONFIG_LED_STATUS3=y
-CONFIG_LED_STATUS_BIT3=65
-CONFIG_LED_STATUS_CMD=y
+CONFIG_LED=y
+CONFIG_LED_BOOT=y
 CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
-- 
2.43.0

