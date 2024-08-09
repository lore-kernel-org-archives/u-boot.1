Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF067C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 17:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0212288BB5;
	Fri,  9 Aug 2024 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="au0VgOrl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5228E887D4; Fri,  9 Aug 2024 19:58:27 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156AF887D4
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fc57d0f15aso1664995ad.2
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723226303; x=1723831103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9M3ga6rR/FCP8odYstDXka/WQuN4I/mlHKJNL/XezVc=;
 b=au0VgOrlbwiiQPUI0PRrIf0o9WtDvenW4i8mBPbRYlcRRM/Pi/4rg0iekWjVt4xJj/
 fXHlQYzvktPDtaOAG1huTFo8jFFmZW3+iQd5vTbl4L3wssIX+qFbuHltN1gcw+kIUDrQ
 jy5yPA01YqxOxtXyuv32imxXzB13JQZ7SP2+vkfgYTWrXkT85KlYd7ZlNnKwSukDuRKY
 Uk5m9+AQVy5AMEGBzBjDjduno+gv6o3Abe2+xVg4rVwded9I99f5oapi/WkM5XCBuUgH
 Ks4S2GHM9uvTCIEGCUQBB9N2C4e4HeVpD/scbnOyOErjbamlm4WcPD4/f1d/XaXVf6WS
 9CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723226303; x=1723831103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9M3ga6rR/FCP8odYstDXka/WQuN4I/mlHKJNL/XezVc=;
 b=jKneQPpM452ABMN1w1Abo/WS7h9N6eUTJDw0m1pP8iAXLrU9FXjf/7oiXFIWMU0Ygr
 R5I/XcseAn6MjyxxHluVAcGFVDvRUYGTfWnRIvhFmG2Uz5jGM9UiYIPQoZSMiRxTQhB2
 XM+LMqUzQYFqSygjVTUmJhYUgKX+IfO60pkgx+CVRqzXSPIZrHFswBe69imW0SC3+7xa
 VFyHhAJINHwGXtZVptn5DvauEGTanwvtis5OofmjhCs84DwHBDwcgmqb9UwZgR451/Tj
 SRjdWEXQqcLxHzXjdskp5Pb9DSbP1hvFxYL3RmDivoQ+vqBymj/UM7gD4yib8wWisRJk
 dP3w==
X-Gm-Message-State: AOJu0YxvD9aBG92lG8dtpRYNYFN4JrJAVcF6HUvpb/s8AAgk4FaRw0dm
 ESgKM3uMArs1Iwaow0lQ8Nn+dCoy60Cr7K/6dtJtn479YLYAeIVoSbLKFQ==
X-Google-Smtp-Source: AGHT+IGqdI9qvX3mnMwcTpnKKLefbYW5S96zNC0f8tHge8wgZOwspqcHsE3F6+C4uCgO/Qc5rsUdHQ==
X-Received: by 2002:a17:902:d50e:b0:1f7:2576:7f88 with SMTP id
 d9443c01a7336-200ae5733f2mr14993165ad.6.1723226303420; 
 Fri, 09 Aug 2024 10:58:23 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c7cd:c377:d374:237c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bb7e8ad2sm467395ad.11.2024.08.09.10.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 10:58:22 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: Markus.Niebel@tq-group.com
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] tqma6: Convert to PMIC and I2C driver model
Date: Fri,  9 Aug 2024 14:58:08 -0300
Message-Id: <20240809175809.612183-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Currently, the power_init_board() function is not executed because
CONFIG_POWER_LEGACY is not selected.

Convert to PMIC driver model, which allows removing board I2C code in
favor of the I2C driver model.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/tq/tqma6/tqma6.c  | 61 +++++++----------------------------------
 include/configs/tqma6.h |  8 ------
 2 files changed, 10 insertions(+), 59 deletions(-)

diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index 92142c10ae5a..02a2022c3c84 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -19,11 +19,9 @@
 #include <linux/errno.h>
 #include <asm/gpio.h>
 #include <asm/io.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/mach-imx/spi.h>
 #include <fsl_esdhc_imx.h>
 #include <linux/libfdt.h>
-#include <i2c.h>
 #include <mmc.h>
 #include <power/pfuze100_pmic.h>
 #include <power/pmic.h>
@@ -48,10 +46,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define SPI_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
 	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
 
-#define I2C_PAD_CTRL	(PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
-	PAD_CTL_DSE_80ohm | PAD_CTL_HYS |			\
-	PAD_CTL_ODE | PAD_CTL_SRE_FAST)
-
 int dram_init(void)
 {
 	gd->ram_size = imx_ddr_size();
@@ -170,38 +164,6 @@ int board_spi_cs_gpio(unsigned bus, unsigned cs)
 #endif
 #endif
 
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-static struct i2c_pads_info tqma6_i2c3_pads = {
-	/* I2C3: on board LM75, M24C64,  */
-	.scl = {
-		.i2c_mode = NEW_PAD_CTRL(MX6_PAD_GPIO_5__I2C3_SCL,
-					 I2C_PAD_CTRL),
-		.gpio_mode = NEW_PAD_CTRL(MX6_PAD_GPIO_5__GPIO1_IO05,
-					  I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(1, 5)
-	},
-	.sda = {
-		.i2c_mode = NEW_PAD_CTRL(MX6_PAD_GPIO_6__I2C3_SDA,
-					 I2C_PAD_CTRL),
-		.gpio_mode = NEW_PAD_CTRL(MX6_PAD_GPIO_6__GPIO1_IO06,
-					  I2C_PAD_CTRL),
-		.gp = IMX_GPIO_NR(1, 6)
-	}
-};
-
-static void tqma6_setup_i2c(void)
-{
-	int ret;
-	/*
-	 * use logical index for bus, e.g. I2C1 -> 0
-	 * warn on error
-	 */
-	ret = setup_i2c(2, CONFIG_SYS_I2C_SPEED, 0x7f, &tqma6_i2c3_pads);
-	if (ret)
-		printf("setup I2C3 failed: %d\n", ret);
-}
-#endif
-
 int board_early_init_f(void)
 {
 	return tqma6_bb_board_early_init_f();
@@ -215,10 +177,6 @@ int board_init(void)
 #ifndef CONFIG_DM_SPI
 	tqma6_iomuxc_spi();
 #endif
-#if CONFIG_IS_ENABLED(SYS_I2C_LEGACY)
-	tqma6_setup_i2c();
-#endif
-
 	tqma6_bb_board_init();
 
 	return 0;
@@ -246,21 +204,22 @@ static const char *tqma6_get_boardname(void)
 	};
 }
 
-#if CONFIG_IS_ENABLED(POWER_LEGACY)
+#if CONFIG_IS_ENABLED(DM_PMIC)
 /* setup board specific PMIC */
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	u32 reg, rev;
+	int ret;
 
-	power_pfuze100_init(TQMA6_PFUZE100_I2C_BUS);
-	p = pmic_get("PFUZE100");
-	if (p && !pmic_probe(p)) {
-		pmic_reg_read(p, PFUZE100_DEVICEID, &reg);
-		pmic_reg_read(p, PFUZE100_REVID, &rev);
-		printf("PMIC: PFUZE100 ID=0x%02x REV=0x%02x\n", reg, rev);
-	}
+	ret = pmic_get("pmic@8", &dev);
+	if (ret < 0)
+		return 0;
+
+	reg = pmic_reg_read(dev, PFUZE100_DEVICEID);
+	rev = pmic_reg_read(dev, PFUZE100_REVID);
 
+	printf("PMIC:  PFUZE100 ID=0x%02x REV=0x%02x\n", reg, rev);
 	return 0;
 }
 #endif
diff --git a/include/configs/tqma6.h b/include/configs/tqma6.h
index 2da76f154313..b4a06a75c538 100644
--- a/include/configs/tqma6.h
+++ b/include/configs/tqma6.h
@@ -26,14 +26,6 @@
 
 #define TQMA6_SPI_FLASH_SECTOR_SIZE	SZ_64K
 
-/* I2C Configs */
-#define CFG_I2C_MULTI_BUS
-
-#if !defined(CONFIG_DM_PMIC)
-#define CFG_POWER_PFUZE100_I2C_ADDR	0x08
-#define TQMA6_PFUZE100_I2C_BUS		2
-#endif
-
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-- 
2.34.1

