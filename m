Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93148E67816
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25F3A890D9;
	Sun,  3 Nov 2024 01:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4Oeu9Lh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75839890FE; Sun,  3 Nov 2024 01:34:47 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3089F89109
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2114214c63eso1569595ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730594082; x=1731198882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAn85OAkLGDECvFRGhP/lDR01d13zdnILV570yMhkzo=;
 b=P4Oeu9Lh7Tk3fabcz3BnKTXNn7+QuQmWjnzaxVBX4silwtqijGxzUZO+Sk4Dc3DvxP
 ALpwQFKon9ldeUPTH59V547hWJMVUNIVPZc4DbQaE3Ig8brDPlGWYB2sb7GAFX6qBUKg
 bxfwJljwv6Xj+BLTItIVlyuX1boWmd27AuR0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730594082; x=1731198882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lAn85OAkLGDECvFRGhP/lDR01d13zdnILV570yMhkzo=;
 b=byjYa3eRmHO/mrZaaKZfDj3dtkF59Ab8dgmr4RrHlXzwpbmVP2GZxBZrlxkSOvyXfs
 TBZ1iinsqpUgjr/xhNdVcjdvOVIjEQl6eWShjAlfi0H9VIn1iYAIiFUJUSJSt0y1czjA
 XyslTGsv+ON7yeWoegVRDXZPJne1E0G1eUMOXg7WN9926OUXPdnpAClC4GBlW191kqYT
 Uow1OX7Ts2gV7Rzki/D2vdFY7pMmv4oiSrSE/+MMOJJf7GPgkr4tI+nrjHhIrCTrYddP
 nsxcSJaYOYCPKh+Yu/UbgwIVAvRPabsAtrpPhj9KcgqqaaTcYz0n/zK5TwFXHpqRPvE8
 y4Nw==
X-Gm-Message-State: AOJu0Yzci61QEUlEW6VnHeS0+7SQdBGaSzfElhUj1LUHJzLrkxGVJFj6
 XDuWiw0OZFvgqiUHX4ziujeoelqGTt7jfKnIJMcLTWeRAcoKgbKQT8NTHNoqHLmbGiEWbtB7EzV
 PEQ==
X-Google-Smtp-Source: AGHT+IF+5mFR5ioUz9bX9gpxDNY2BoVMXM00gjGw8FKdDa462o8CPCR1DPdB0yYLp/NokxOYlYMGLA==
X-Received: by 2002:a17:903:234c:b0:20c:6f6f:afe5 with SMTP id
 d9443c01a7336-210c6c5ce4dmr339786485ad.50.1730594081909; 
 Sat, 02 Nov 2024 17:34:41 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a63f2sm38987995ad.168.2024.11.02.17.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:34:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v3 02/25] vining_fpga: Drop status-LED code and use LED
Date: Sat,  2 Nov 2024 18:32:54 -0600
Message-ID: <20241103003322.626036-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103003322.626036-1-sjg@chromium.org>
References: <20241103003322.626036-1-sjg@chromium.org>
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

