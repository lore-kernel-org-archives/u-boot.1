Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4478BC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 08:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D831486EF6;
	Mon,  6 Nov 2023 09:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CIMNdJjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C13286FA5; Mon,  6 Nov 2023 09:33:07 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DAA86BEC
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 09:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9dd3f4a0f5aso373206366b.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 00:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699259574; x=1699864374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI2/iGKpqT9UTNxCnFvtFoxczlE6xvWHQ5enQvnZNlc=;
 b=CIMNdJjd+6EkDCs5hQd0HO7h4bL3Hm7CjSZfrj0SQGyuWa5+AEOuc776gA6TLng5eg
 bOX9rn32eIR8MAwsWrIjoOHp19O/4lPA9NThw4O9FXGJGuIYP+b5/lFQvD+cllgoXRwj
 sUVuyU2cMWscJGxsFteBMvSN3Vw0rlIxAgUzKypEzbYYT2erTPwNtNUHPnwmlt5uLywi
 cm72NC/LF6w7Tj0PPNYEJXHsJ6bV6WTJ+9hENQ0ba4QOaaN710Kws0CQgFORsY0usUql
 mB+45peeEc/KDKF9Jz9nR/1ib3j+2SfYdyoEfmHJlD5VOHkErGGvcc0X1jPoCpHbM8Gj
 Sdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699259574; x=1699864374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aI2/iGKpqT9UTNxCnFvtFoxczlE6xvWHQ5enQvnZNlc=;
 b=Y12ij6blQD5gCPMT25rfXC0O54JYUqTupV6HXD2gXDGUkeFZL3y2hNBnWpBaAJt1q7
 58CpwJvW6G3r9DYmsab2bWsqQpo7N4TFVrXudGCiBLyuXvlsS2MROAiHiXho/IHJPmu3
 05K7YgrgSVJxKwULNX7/hq8iHoOg6GabhXpfA6N+I9bYHZaC70Jnaibj62OQSMbUyvVh
 rZ0ObsfWGY1dgW0icc1HJYI0ydZiUNC3ec9ccpPyiGaHaQBwAMeD82WrLIOBRTI/SDJP
 ktPnWv9V/nunHvDsJJsWyjTlUSw8cqsUirP7QFlyhtPg9Ux6Hx01shUT3oX5AMTtKPVa
 Lulw==
X-Gm-Message-State: AOJu0YzId7f0razKwUf8bsn9oWC+mgH/L0pLN0KEhiqKaw/oj7Kc+Hrk
 764c588lMRyv5KcuOLfdlLM=
X-Google-Smtp-Source: AGHT+IGWJOf1dmie7WwNB3c9/zISbu0DpCT4eaStPdLQu+XOKMJy+KaRbdr4ib6rowYKmJ4db2vmfg==
X-Received: by 2002:a17:907:7291:b0:9c7:fd91:4309 with SMTP id
 dt17-20020a170907729100b009c7fd914309mr12719430ejc.0.1699259574356; 
 Mon, 06 Nov 2023 00:32:54 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 t21-20020a170906269500b009a1a653770bsm3799715ejc.87.2023.11.06.00.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 00:32:53 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/5] board: endeavoru: convert HTC One X to use DM PMIC
Date: Mon,  6 Nov 2023 10:32:26 +0200
Message-Id: <20231106083229.256322-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231106083229.256322-1-clamor95@gmail.com>
References: <20231106083229.256322-1-clamor95@gmail.com>
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

Since required drivers were merged, we can safely clean up the
board and switch to DM based driver with device tree support.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/dts/tegra30-htc-endeavoru.dts |  1 +
 board/htc/endeavoru/endeavoru-spl.c    |  2 +-
 board/htc/endeavoru/endeavoru.c        | 72 +++-----------------------
 configs/endeavoru_defconfig            |  4 ++
 4 files changed, 12 insertions(+), 67 deletions(-)

diff --git a/arch/arm/dts/tegra30-htc-endeavoru.dts b/arch/arm/dts/tegra30-htc-endeavoru.dts
index 5c7b2deae5..22320de708 100644
--- a/arch/arm/dts/tegra30-htc-endeavoru.dts
+++ b/arch/arm/dts/tegra30-htc-endeavoru.dts
@@ -81,6 +81,7 @@
 					regulator-name = "avdd_dsi_csi";
 					regulator-min-microvolt = <1200000>;
 					regulator-max-microvolt = <1200000>;
+					regulator-boot-on;
 				};
 			};
 		};
diff --git a/board/htc/endeavoru/endeavoru-spl.c b/board/htc/endeavoru/endeavoru-spl.c
index 7921ff1a73..2525b50d3e 100644
--- a/board/htc/endeavoru/endeavoru-spl.c
+++ b/board/htc/endeavoru/endeavoru-spl.c
@@ -9,7 +9,7 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
+#include <asm/arch/tegra.h>
 #include <asm/arch-tegra/tegra_i2c.h>
 #include <linux/delay.h>
 
diff --git a/board/htc/endeavoru/endeavoru.c b/board/htc/endeavoru/endeavoru.c
index e1a0b242e2..6835b1ee70 100644
--- a/board/htc/endeavoru/endeavoru.c
+++ b/board/htc/endeavoru/endeavoru.c
@@ -7,48 +7,12 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdt_support.h>
-#include <i2c.h>
-#include <log.h>
 #include <asm/arch/pinmux.h>
-#include <asm/arch/gp_padctrl.h>
-#include <asm/arch/gpio.h>
-#include <asm/gpio.h>
-#include <linux/delay.h>
-#include "pinmux-config-endeavoru.h"
-
-#define TPS80032_CTL1_I2C_ADDR		0x48
-#define TPS80032_PHOENIX_DEV_ON		0x25
-#define   DEVOFF			BIT(0)
-#define TPS80032_LDO1_CFG_STATE		0x9E
-#define TPS80032_LDO1_CFG_VOLTAGE	0x9F
-
-#ifdef CONFIG_CMD_POWEROFF
-int do_poweroff(struct cmd_tbl *cmdtp, int flag,
-		int argc, char *const argv[])
-{
-	struct udevice *dev;
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, TPS80032_CTL1_I2C_ADDR, 1, &dev);
-	if (ret) {
-		log_debug("cannot find PMIC I2C chip\n");
-		return 0;
-	}
+#include <power/regulator.h>
 
-	ret = dm_i2c_reg_write(dev, TPS80032_PHOENIX_DEV_ON, DEVOFF);
-	if (ret)
-		return ret;
-
-	// wait some time and then print error
-	mdelay(5000);
-
-	printf("Failed to power off!!!\n");
-	return 1;
-}
-#endif
+#include "pinmux-config-endeavoru.h"
 
 /*
  * Routine: pinmux_init
@@ -60,37 +24,13 @@ void pinmux_init(void)
 		ARRAY_SIZE(endeavoru_pinmux_common));
 }
 
-#ifdef CONFIG_MMC_SDHCI_TEGRA
-static void tps80032_voltage_init(void)
+int nvidia_board_init(void)
 {
-	struct udevice *dev;
-	int ret;
-
-	ret = i2c_get_chip_for_busnum(0, TPS80032_CTL1_I2C_ADDR, 1, &dev);
-	if (ret)
-		log_debug("cannot find PMIC I2C chip\n");
-
-	/* TPS80032: LDO1_REG = 1.2v to DSI */
-	ret = dm_i2c_reg_write(dev, TPS80032_LDO1_CFG_VOLTAGE, 0x03);
-	if (ret)
-		log_debug("avdd_dsi_csi voltage set failed: %d\n", ret);
-
-	/* TPS80032: LDO1_REG enable */
-	ret = dm_i2c_reg_write(dev, TPS80032_LDO1_CFG_STATE, 0x01);
-	if (ret)
-		log_debug("avdd_dsi_csi enable failed: %d\n", ret);
-}
+	/* Set up boot-on regulators */
+	regulators_enable_boot_on(true);
 
-/*
- * Routine: pin_mux_mmc
- * Description: setup the MMC muxes, power rails, etc.
- */
-void pin_mux_mmc(void)
-{
-	/* Bring up DSI power */
-	tps80032_voltage_init();
+	return 0;
 }
-#endif	/* MMC */
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index d605acdfc8..7212675546 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_UMS_ABORT_KEYED=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PAUSE=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
@@ -61,10 +62,13 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_SYS_I2C_TEGRA=y
 CONFIG_BUTTON_KEYBOARD=y
 CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_TPS80031=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_TPS80031=y
 CONFIG_PWM_TEGRA=y
 CONFIG_SYS_NS16550=y
+CONFIG_SYSRESET_TPS80031=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_TEGRA=y
-- 
2.40.1

