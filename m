Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26312C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 11:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598CB877D6;
	Tue, 12 Dec 2023 12:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLf+YPuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4925D877D8; Tue, 12 Dec 2023 12:29:02 +0100 (CET)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 244EA877D3
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hiagofranco@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d089bc4e1aso1560760b3a.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 03:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702380538; x=1702985338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lDt/kpDpH/jXDX3hBGGN2ssXCs3/CtOaxRpn2kXfuZ8=;
 b=ZLf+YPuVYFxuSnbiG4W5GU6KBGiZFveomRx4x98LtEiVGO1CXONtYY+34SkPlSD3XI
 sq0gVGB9Q8577FsCZH4WMutIEnSR5GCfFEastsBusqgH0EcEzCNslLu9P9+71Ln1jnXn
 7cCf9kYzYcscoNQh/in8CJZvinV+nQ7jZlLXpwgprLkTNvW9H6fHLcQRG6PKZXCvd6NG
 GBRFXcaLi8dyI2fTf6xDLga7u1oMVT+xsUKl4oYmi75K5fZYuOJNtK1q/8I+A8XCM6O6
 nWfY0A7ze5/KlIiSK9D728hWztuiN3LELYcJOXF2rfpo3daUrK7V1Fh1GmwYCn++JQR3
 3JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702380538; x=1702985338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lDt/kpDpH/jXDX3hBGGN2ssXCs3/CtOaxRpn2kXfuZ8=;
 b=sbXaaRvJMr5mDzrwg3vrmmciBW81bR90toIEPHit1t6vOPg/Mj6VNbXxo3Ky3ZafUW
 OgBKIqFqJ882j892XXPC/ArptF1nE0x6O53d/wwNO/lxQszA23LEB18Cjqn6v6EH8+FH
 iYujbVohDBvmQJk0Nwc3zZ7yddjkzlU1s/nRJfX08bzaPS8JOM4tBWowZ1ejdeJ9Di0N
 M77NvTA0+ystSuEFWKMd+jrEee1hPkU/MevXqN0momiTJGDFZ08/43/DgMu8kCVOltzf
 h+xqKxc/SLAjOc50kIYmnWRt6e+f7wAyHbUHmWGMMbPv7NBd4rjngyla08WCnZiWH4eL
 6/MA==
X-Gm-Message-State: AOJu0YxS6mCTdHf17btkUpJoW2AaqQIAKGKpGve4hZsyE3S1lQ6EZfFV
 LscIvVc4s5yjfbUx7W8X1JFsezzzAKTh2guU
X-Google-Smtp-Source: AGHT+IGPqDZdiBws8oT3G4kyuGOsikQh9FPeTk9sXJ2/165aHVwj7FKAKMi4OGxpSRc8CtIw7FWadQ==
X-Received: by 2002:a05:6a00:6518:b0:6ce:f51f:2ea8 with SMTP id
 hc24-20020a056a00651800b006cef51f2ea8mr4383373pfb.21.1702380538317; 
 Tue, 12 Dec 2023 03:28:58 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 kq13-20020a056a004b0d00b006c3069547bfsm7877663pfb.79.2023.12.12.03.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 03:28:57 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: u-boot@lists.denx.de,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1] board: colibri_imx7: fix emmc detection
Date: Tue, 12 Dec 2023 08:28:15 -0300
Message-ID: <20231212112815.7880-1-hiagofranco@gmail.com>
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Later versions of Colibri iMX7D V1.1B modules use a "new" SoC fusing. The
difference lies in whether we enable the boot ROM to use the eMMC reset
signal. Depending on the SoC fuse, the boot ROM configures this pin as a
GPIO output to drive the reset signal. Our eMMC vs NAND detection
currently only sets that signal to a GPIO without explicitly setting any
direction. Previously, by default, it was set as an input. As the boot ROM
now configures it as an output, we receive a value of zero instead of one,
indicating the absence of the pull-up on eMMC modules.

To fix this, set the SION bit, allowing the reading back of the value
even if it is configured as an output by the boot ROM. It's important to
note that with the new SoC fusing, we now read back what the boot ROM
drives rather than the real value caused by the pull-up resistor. However,
if it were ever driven low, the eMMC would permanently be reset.

In addition, remove hard-coded variant in the eMMC build case as since the
commit 0c39564d0281 ("toradex: colibri_imx7: Enable nand/emmc detection
and set boot variant") will anyways always get overridden by the detection
routing in board code.

Fixes: 0c39564d ("toradex: colibri_imx7: Enable nand/emmc detection and set boot variant")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 board/toradex/colibri_imx7/colibri_imx7.c | 6 +++---
 include/configs/colibri_imx7.h            | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index f0356af008..3e7c5d64c3 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -66,7 +66,7 @@ int dram_init(void)
 }
 
 static iomux_v3_cfg_t const flash_detection_pads[] = {
-	MX7D_PAD_SD3_RESET_B__GPIO6_IO11 | MUX_PAD_CTRL(FLASH_DETECTION_CTRL),
+	MX7D_PAD_SD3_RESET_B__GPIO6_IO11 | MUX_PAD_CTRL(FLASH_DETECTION_CTRL) | MUX_MODE_SION,
 };
 
 static iomux_v3_cfg_t const uart1_pads[] = {
@@ -193,9 +193,9 @@ int board_init(void)
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
 	/*
-	 * Enable GPIO on NAND_WE_B/eMMC_RST with 100k pull-down. eMMC_RST
+	 * Enable GPIO SION on NAND_WE_B/eMMC_RST with 100k pull-down. eMMC_RST
 	 * is pulled high with 4.7k for eMMC devices. This allows to reliably
-	 * detect eMMC/NAND flash
+	 * detect eMMC vs NAND flash.
 	 */
 	imx_iomux_v3_setup_multiple_pads(flash_detection_pads, ARRAY_SIZE(flash_detection_pads));
 	gpio_request(FLASH_DET_GPIO, "flash-detection-gpio");
diff --git a/include/configs/colibri_imx7.h b/include/configs/colibri_imx7.h
index 03f8ed1478..7a9f4afe7d 100644
--- a/include/configs/colibri_imx7.h
+++ b/include/configs/colibri_imx7.h
@@ -101,7 +101,6 @@
 	UBI_BOOTCMD
 #elif defined(CONFIG_TARGET_COLIBRI_IMX7_EMMC)
 #define MODULE_EXTRA_ENV_SETTINGS \
-	"variant=-emmc\0" \
 	EMMC_ANDROID_BOOTCMD
 #endif
 
-- 
2.43.0

