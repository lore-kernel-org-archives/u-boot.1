Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD16C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 20:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72A388BC7;
	Fri, 19 Jul 2024 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFNu8wy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9706E882FA; Fri, 19 Jul 2024 22:33:21 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D8388BC4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 22:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c968fa1d4fso272757a91.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721421198; x=1722025998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6pfGgNFidDRmgjDdlA0Iv1gQZJ34ZY5c+xYMxSgOPuY=;
 b=cFNu8wy1fmdF9hzJIbkZ6poswYlTltWJNVDMyUhkQzSd3uNO9+kKlK2qmVHYeLt/m5
 OlH1B3kupIGx4SqFGC3zmVytv16Ik4BrDYYVcO0xAix4vYmBRaGNBVv48vq0sjga2dGo
 Yw6gHdcOc52+urEDaOXIw1HUEtjBQ3+3q/6tePauQuWkujgTycE37ud0eauYFBSEQagP
 +0vb3ihIGW3nsNCcuRrzKRWPoFIskchquOWUBfGc2J+lgcBsB/71pvPoag9HGHQYA4jq
 3sOFa8WpZVUGD5Wh8qOUht0Q2iq+fB8Nuu8Lx6bESfRyEaahupgiuc1Hz8UDll0F0Zz2
 xTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721421198; x=1722025998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6pfGgNFidDRmgjDdlA0Iv1gQZJ34ZY5c+xYMxSgOPuY=;
 b=bWxF1AOV/xlz+opWA4A0lrJnayWRZRQTN2yeKZxy1K3ILrsbCmv/1EA1izBjM842qy
 WKwwRUSDGL9auycWtEMct7QY+Qij0BTghESQKNRe4vc6YBe7EmcIcEZIo5RJ0l3d5gLg
 oqje+PTzyCSBTtrCPKf0sKDj6T8GQn+FSr+YouG3upYW7UjhA5Iylb+Fj3nxWyOtXj/f
 jZNDrYzamPse+u3Z0Z9UUgyplq0T6P4VhvdXfCmVplvIkybm8Xeh2mO868rp0oFuYFbO
 SYUAgWO6Za5SUpklk9RSJKYvrdux8EXSLYA4utX5CetJPy0kLz7NYEMyqULQynFsMGBZ
 Nufg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVABhcOEoE3XRo/1xB0t2MEWLFCBMmNg0uuyETflHUa5BIcbUxddevD7AKIyXqsrxjmiBdYesHGHwGvUMaUIcqjB7NAw==
X-Gm-Message-State: AOJu0YzLa+a5yE0SK8g/Uv1kAl66XjHGGe+BY94JPWkxRTM4jPObrSBh
 Tz19qN10eB4mKcrSz9iI8eCwJu15vCIypQmvk5GOIizKBSNX5CNQ
X-Google-Smtp-Source: AGHT+IG1pwNMeho5LKBd6MGLW+usG+rJbjWm1cEelGTcvSLSil/2BQq2wqbByHU66m+DSI/oEP5qnw==
X-Received: by 2002:a17:90a:d806:b0:2c9:7a37:62ab with SMTP id
 98e67ed59e1d1-2cd16058647mr762839a91.4.1721421197746; 
 Fri, 19 Jul 2024 13:33:17 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:27e4:cf37:80d4:17f5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf8092da9sm2138230a91.37.2024.07.19.13.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 13:33:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: breno.lima@nxp.com
Cc: francesco.montefoschi@udoo.org, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/4] udoo_neo: Convert to watchdog driver model
Date: Fri, 19 Jul 2024 17:33:08 -0300
Message-Id: <20240719203311.1695523-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

With the watchdog driver model in place, it is no longer needed
to have board code to initialize the watchdog, so remove
its related board code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Remove board wdog board code.

 arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi | 12 ++++++++++++
 board/udoo/neo/neo.c                           | 16 ----------------
 configs/udoo_neo_defconfig                     |  3 +++
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi b/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
index b5e1f2b9a16f..7f5a6424bac8 100644
--- a/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
+++ b/arch/arm/dts/imx6sx-udoo-neo-basic-u-boot.dtsi
@@ -1,5 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+/ {
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
+};
+
 &soc {
 	bootph-all;
 };
@@ -15,3 +23,7 @@
 &uart1 {
 	bootph-all;
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index b435b721e53c..1a0aaecc3328 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -57,9 +57,6 @@ enum {
 #define ENET_RX_PAD_CTRL  (PAD_CTL_PKE | PAD_CTL_PUE |          \
 	PAD_CTL_SPEED_MED   | PAD_CTL_SRE_FAST)
 
-#define WDOG_PAD_CTRL (PAD_CTL_PUE | PAD_CTL_PKE | PAD_CTL_SPEED_MED |	\
-	PAD_CTL_DSE_40ohm)
-
 #define BOARD_DETECT_PAD_CTRL (PAD_CTL_PKE | PAD_CTL_PUE |		\
 	PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED |		\
 	PAD_CTL_DSE_34ohm | PAD_CTL_HYS | PAD_CTL_SRE_FAST)
@@ -113,10 +110,6 @@ static iomux_v3_cfg_t const phy_control_pads[] = {
 	MUX_PAD_CTRL(ENET_CLK_PAD_CTRL),
 };
 
-static iomux_v3_cfg_t const wdog_b_pad = {
-	MX6_PAD_GPIO1_IO13__GPIO1_IO_13 | MUX_PAD_CTRL(WDOG_PAD_CTRL),
-};
-
 static iomux_v3_cfg_t const peri_3v3_pads[] = {
 	MX6_PAD_QSPI1A_DATA0__GPIO4_IO_16 | MUX_PAD_CTRL(NO_PAD_CTRL),
 };
@@ -148,15 +141,6 @@ int board_init(void)
 	/* Address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
-	/*
-	 * Because kernel set WDOG_B mux before pad with the commone pinctrl
-	 * framwork now and wdog reset will be triggered once set WDOG_B mux
-	 * with default pad setting, we set pad setting here to workaround this.
-	 * Since imx_iomux_v3_setup_pad also set mux before pad setting, we set
-	 * as GPIO mux firstly here to workaround it.
-	 */
-	imx_iomux_v3_setup_pad(wdog_b_pad);
-
 	/* Enable PERI_3V3, which is used by SD2, ENET, LVDS, BT */
 	imx_iomux_v3_setup_multiple_pads(peri_3v3_pads,
 					 ARRAY_SIZE(peri_3v3_pads));
diff --git a/configs/udoo_neo_defconfig b/configs/udoo_neo_defconfig
index 4986b4c26260..9f9ad0ad5ec7 100644
--- a/configs/udoo_neo_defconfig
+++ b/configs/udoo_neo_defconfig
@@ -61,5 +61,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_ANATOP=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

