Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A6C52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D8188440;
	Thu,  8 Aug 2024 00:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723070084;
	bh=OVxijjZ5wr5NeKhwQhqwDZqxQ60HEd3WGe6wtOOhyj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pUC8lrL97SUtHKpew8PdcAMMwRYCgpnaEYtR23RF+1d0rK2FsF46C+GOD9iUPgwIe
	 cHJgJxnLzxXGsFibh8WBNON1JnAAv/dWsE09xwNUBeYhl2dSBMBW82gwqHAb8xq8uj
	 t+wFhkzF3Zyq49VtIBFjA8PUf6UHaJMmtYssLP5uDc2/yFXbNGd1/T3nRyL7p/24eV
	 EEafsjhz5xDdV4NhCO0IaOuSUjTkd5nc0nq7jiZEo6jjRE5j6xuzIMKRSSMiYUHmGV
	 qaQNKAAGX5CQp1iNzdjT7++7wdUmQgD0RW5rDWhJki0YsvJisVU2zSRCQRKjacA5wb
	 vaejAojrHweaw==
Received: from crub.agik.hopto.org (p508b6395.dip0.t-ipconnect.de
 [80.139.99.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8CE0F87F8D;
 Thu,  8 Aug 2024 00:34:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723070082;
 bh=OVxijjZ5wr5NeKhwQhqwDZqxQ60HEd3WGe6wtOOhyj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G+AE3ZlES4l+yhxlQ/u3CnD586DNXJaRDRod/uq//6YwFFAMqgf3P+tCgFXkRFxTr
 TMyir1S1BqTYwtLqUlbexHzdBQvNdj7P7RcAM6cfeM8xPspnRBn7niyPysbscHG+VN
 gsLdtCogG2zY3utgqGKkqK3rP2/qi5xOjjvAg6n3cPFIzySfi9WxWQKZ9ALkj5LIzW
 XCcqaNmVnuGO+5zvEUXSPKpBNwwSLe829Rtxgo//wJFAu7DoIXjD7F6LhsPGpPCtYR
 YicP5Ykjxac5B4qqPDKn++RyYbxuvse63tULysH8DZiDS06NZAXf0VL6eZHcMUGn4x
 W3dgXZpmRyYMw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Silvio Fricke <open-source@softing.de>, Fabio Estevam <festevam@denx.de>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] board: vining_2000: convert to DM_I2C
Date: Thu,  8 Aug 2024 00:34:38 +0200
Message-Id: <20240807223438.903160-1-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-8-agust@denx.de>
References: <20240803161513.486062-8-agust@denx.de>
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

Conversion to DM_I2C is mandatory, enable DM_I2C
to disable board removal warning.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
Cc: Silvio Fricke <open-source@softing.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
Changes in v2:
  do not remove CONFIG_SYS_I2C_MXC_I2C* to fix build warnings/errors

 board/softing/vining_2000/vining_2000.c | 25 -------------------------
 configs/vining_2000_defconfig           |  2 +-
 2 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/board/softing/vining_2000/vining_2000.c b/board/softing/vining_2000/vining_2000.c
index a0dbf97524..bd430cfaa7 100644
--- a/board/softing/vining_2000/vining_2000.c
+++ b/board/softing/vining_2000/vining_2000.c
@@ -18,7 +18,6 @@
 #include <asm/gpio.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/io.h>
-#include <asm/mach-imx/mxc_i2c.h>
 #include <asm/sections.h>
 #include <env.h>
 #include <linux/bitops.h>
@@ -27,7 +26,6 @@
 #include <config.h>
 #include <fsl_esdhc_imx.h>
 #include <mmc.h>
-#include <i2c.h>
 #include <miiphy.h>
 #include <netdev.h>
 #include <power/pmic.h>
@@ -53,10 +51,6 @@ DECLARE_GLOBAL_DATA_PTR;
 	PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_HIGH |		\
 	PAD_CTL_SRE_FAST)
 
-#define I2C_PAD_CTRL  (PAD_CTL_HYS | PAD_CTL_PUS_100K_UP |	\
-	PAD_CTL_PKE | PAD_CTL_ODE | PAD_CTL_SPEED_MED |		\
-	PAD_CTL_DSE_40ohm)
-
 #define USDHC_CLK_PAD_CTRL  (PAD_CTL_HYS | PAD_CTL_SPEED_MED |	\
 	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST)
 
@@ -120,21 +114,6 @@ eth_fail:
 	return ret;
 }
 
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-/* I2C1 for PMIC */
-static struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX6_PAD_GPIO1_IO00__I2C1_SCL | PC,
-		.gpio_mode = MX6_PAD_GPIO1_IO00__GPIO1_IO_0 | PC,
-		.gp = IMX_GPIO_NR(1, 0),
-	},
-	.sda = {
-		.i2c_mode = MX6_PAD_GPIO1_IO01__I2C1_SDA | PC,
-		.gpio_mode = MX6_PAD_GPIO1_IO01__GPIO1_IO_1 | PC,
-		.gp = IMX_GPIO_NR(1, 1),
-	},
-};
-
 static struct pmic *pfuze_init(unsigned char i2cbus)
 {
 	struct pmic *p;
@@ -400,10 +379,6 @@ int board_init(void)
 	/* Address of boot parameters */
 	gd->bd->bi_boot_params = PHYS_SDRAM + 0x100;
 
-#ifdef CONFIG_SYS_I2C_MXC
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-#endif
-
 	return board_net_init();
 }
 
diff --git a/configs/vining_2000_defconfig b/configs/vining_2000_defconfig
index c39597cdf5..e5c9c2861e 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -70,7 +70,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="FEC"
 CONFIG_BOUNCE_BUFFER=y
-CONFIG_SYS_I2C_LEGACY=y
+CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_RPMB=y
-- 
2.25.1

