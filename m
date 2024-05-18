Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68462C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 13:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 976B8886AD;
	Sat, 18 May 2024 15:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="vuzwLTm3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BF4886A4; Sat, 18 May 2024 15:06:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C6A88692
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 15:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-420180b5922so12423345e9.2
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 06:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1716037605; x=1716642405;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7sDUZPUIMA4+K2jCBm6zmg1ziC5zc3TgAW+2fz1osQ=;
 b=vuzwLTm3TlQXkM6V8iIWU2MRxIZFEHhxFF1LqR6Nl027kpx57xNgSvfHo01ERuoTrR
 CsKU+wUwrESrHcjcirNLjCMFBizqFpJkRPJcrCJE0AUqZdyhCbG/EIxjhpdloh3xZ1pF
 yJ0z+A8XvV2lmVkOVjfoE1WRJryUIntX/Ipn0qXM2HBM5w1ko5fBQ+W4UmJ19+bkfuPB
 /+y1rz02z0DDwMTmjZjIjiGejtID7eXRnvN4fibwhoL6CW4SiHxPN+Li8wEx7lgn0AOT
 rCfFEmCtT2Y9jtPnPpAsM/D5Htat/7LbPMursHiyZn2gJLjsN9lvg65w5vegX5mZ4Vno
 uN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716037605; x=1716642405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7sDUZPUIMA4+K2jCBm6zmg1ziC5zc3TgAW+2fz1osQ=;
 b=fgMATfenoJHJzoVtMQQTPKlwIc1FPbICa+3MJ6Mljf5v1ogFCnyBW1/cctemR1h33t
 TCxW1/turDJyVEEGddVV+DklNjZx8R//tvVEwxERomEAHlQqg/J6jaB/JjmIC13tiFcm
 z2IljVui1NqGJxdTNaFQbkkQyZhYB0VZz2zZZGirxdfUyEoJkPQEM4dbXT7QBy7IdXEg
 /TrAnyPYcfrN83t3FqCve8Ii2EWJ3rIK04E/Ty/Q6WoTSd/pzwPIJfGbL3/9W9/UzCtQ
 QRmyjiDkbAVWGK7IJlhYxHuyTSHdeEQvKQXM9CaZorXYIgXj59S/6eCAdI1MF9GQtBvG
 3KUQ==
X-Gm-Message-State: AOJu0YxKKi69ZkWXbn2VuVjAP0GZOwJxNZuNK3AK1Gvr/1kU9BqEbDDR
 Ued+81fppg2FeAiPtF17Aj0e2PZmPRQRtZFRcwsg/RRs406uLlO1jZ6On69kjCKTtBB/NxFlxq0
 P
X-Google-Smtp-Source: AGHT+IFxNWYXu99ZwBju+gtRdgvYkl6bEPnS3kTibYhhuKeeVLCz7WBpzsfb4PBjfdt12RiBsGFeRw==
X-Received: by 2002:a05:600c:1c0e:b0:41c:503:9ae4 with SMTP id
 5b1f17b1804b1-41feac55e4dmr239327995e9.25.1716037605086; 
 Sat, 18 May 2024 06:06:45 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420273cff03sm122048335e9.26.2024.05.18.06.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 06:06:44 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 3/4] omap3: igep0x00: Update for DM SPL support
Date: Sat, 18 May 2024 15:06:14 +0200
Message-ID: <20240518130622.219031-4-javier@dowhile0.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518130622.219031-1-javier@dowhile0.org>
References: <20240518130622.219031-1-javier@dowhile0.org>
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

From: Javier Martinez Canillas <javierm@redhat.com>

This change is heavily based on commit e0cc7df9fdf2 ("omap3_beagle: Update
for DM SPL support"), that did the same update for the OMAP3 Beagle board.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/dts/omap3-igep0020-u-boot.dtsi | 14 ++------------
 board/isee/igep00x0/igep00x0.c          | 12 ------------
 configs/igep00x0_defconfig              | 17 ++++++++---------
 3 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/arch/arm/dts/omap3-igep0020-u-boot.dtsi b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
index 41beaf0900c3..2c03701c896a 100644
--- a/arch/arm/dts/omap3-igep0020-u-boot.dtsi
+++ b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
@@ -5,20 +5,10 @@
  * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
  */
 
+#include "omap3-u-boot.dtsi"
+
 / {
 	chosen {
 		stdout-path = &uart3;
 	};
 };
-
-&uart1 {
-	reg-shift = <2>;
-};
-
-&uart2 {
-	reg-shift = <2>;
-};
-
-&uart3 {
-	reg-shift = <2>;
-};
diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
index 8a3f290f678f..a35a7cd3b1f7 100644
--- a/board/isee/igep00x0/igep00x0.c
+++ b/board/isee/igep00x0/igep00x0.c
@@ -29,18 +29,6 @@
 #include <fdt_support.h>
 #include "igep00x0.h"
 
-static const struct ns16550_plat igep_serial = {
-	.base = OMAP34XX_UART3,
-	.reg_shift = 2,
-	.clock = V_NS16550_CLK,
-	.fcr = UART_FCR_DEFVAL,
-};
-
-U_BOOT_DRVINFO(igep_uart) = {
-	"ns16550_serial",
-	&igep_serial
-};
-
 /*
  * Routine: get_board_revision
  * Description: GPIO_28 and GPIO_129 are used to read board and revision from
diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 6df6c33e25ab..c1b873a17efb 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -1,4 +1,6 @@
 CONFIG_ARM=y
+# CONFIG_SPL_USE_ARCH_MEMCPY is not set
+# CONFIG_SPL_USE_ARCH_MEMSET is not set
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
@@ -40,16 +42,7 @@ CONFIG_SPL_UBI_LEB_START=2048
 CONFIG_SPL_UBI_INFO_ADDR=0x88080000
 CONFIG_SPL_UBI_VOL_IDS=8
 CONFIG_SPL_UBI_LOAD_MONITOR_ID=0
-CONFIG_SPL_UBI_LOAD_KERNEL_ID=3
-CONFIG_SPL_UBI_LOAD_ARGS_ID=4
 CONFIG_SPL_ONENAND_SUPPORT=y
-CONFIG_SPL_OS_BOOT=y
-CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x84000000
-CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
-CONFIG_SPL_FALCON_BOOT_MMCSD=y
-CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
-CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
 CONFIG_CMD_SPL=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_ONENAND=y
@@ -59,7 +52,11 @@ CONFIG_CMD_CACHE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 # CONFIG_CMD_UBIFS is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+CONFIG_SPL_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_UBI=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
@@ -69,6 +66,7 @@ CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_NET is not set
+CONFIG_SPL_DM=y
 CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_MMC_OMAP_HS=y
@@ -81,5 +79,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
 CONFIG_MTD_UBI_FASTMAP=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_CONS_INDEX=3
 CONFIG_BCH=y
-- 
2.45.0

