Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722A7C3DA4A
	for <u-boot@archiver.kernel.org>; Sat,  3 Aug 2024 16:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB02A88CE1;
	Sat,  3 Aug 2024 18:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722701719;
	bh=HjETk6XXto53QxaPpTaWZ64d1qzQ0x5evyyS91fYFFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zCK4zYSOHYi/+vmeJEWJWplCgRrCLOrZHcdYricJpgVjS2drwutQWYLt+2q2wd5GL
	 TPfjYZPCyErbqQhFh6exUVvO8onHiHeHBLCjiNu18s+KPpVekODTRde6KqY9MctMHL
	 FLEfecsSQs8Sd9WAKufYT2n7EBcLExxKkfpvupCD7AsRT02mGPXUgRNuwVZ1FhY3Rh
	 h09+ss15itmlinFrIAZlHPAjTt0Nv1TqPJ3KxmUVEonklPb/LYvTe/IeqzFTg5IxN0
	 U/Q/tFTdHkZHhpyEgMH66i1hcl8dubHdY8c5BxoIP4Fcb6gGOoqmeeBqgXmQa2bYeq
	 WInS565vRFaXQ==
Received: from crub.agik.hopto.org (p54833c06.dip0.t-ipconnect.de
 [84.131.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0A83988CA3;
 Sat,  3 Aug 2024 18:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722701716;
 bh=HjETk6XXto53QxaPpTaWZ64d1qzQ0x5evyyS91fYFFI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pFWSMcTP8xlAnAHFIVSC1+cs1FnrrRj5oP//NwvbJyhtpTcUiUI5U8bZcB/TTB6is
 0k+GMAf/vDUgIhT9By958xDHXYlSdH+6sNgBNZm5lDSQD+wdSDJMbvIetKYHF1D3Y5
 OU/dppz+52w0IN9allJxaXJFcOnGtiOw+FYuE7G0s6ndoUTiHQO39UuxCX3lvP6X2e
 w2hPcTsRodiCAkUnSf/c7OP/tZlNwO+1QTnYtcuP9ovC5w4py/Evylaqj9z8uIbexg
 YSb8iefEAnE3u4RSLpQIvyoTzhm8utWBnE1+gk/tObv8l6JFxHZ0Hox/dPC3P3wcBU
 6MnLcMHF2bvIw==
From: Anatolij Gustschin <agust@denx.de>
To: u-boot@lists.denx.de
Cc: Silvio Fricke <open-source@softing.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/11] board: vining_2000: convert to DM_I2C
Date: Sat,  3 Aug 2024 18:15:10 +0200
Message-Id: <20240803161513.486062-8-agust@denx.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240803161513.486062-1-agust@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
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
Cc: Tom Rini <trini@konsulko.com>
---
 board/softing/vining_2000/vining_2000.c | 25 -------------------------
 configs/vining_2000_defconfig           |  4 +---
 2 files changed, 1 insertion(+), 28 deletions(-)

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
index c39597cdf5..45012365e0 100644
--- a/configs/vining_2000_defconfig
+++ b/configs/vining_2000_defconfig
@@ -12,8 +12,6 @@ CONFIG_ENV_OFFSET=0x80000
 CONFIG_MX6SX=y
 CONFIG_MX6_DDRCAL=y
 CONFIG_TARGET_SOFTING_VINING_2000=y
-CONFIG_SYS_I2C_MXC_I2C1=y
-CONFIG_SYS_I2C_MXC_I2C3=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx6sx-softing-vining-2000"
 CONFIG_SPL_TEXT_BASE=0x00908000
@@ -70,7 +68,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
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

