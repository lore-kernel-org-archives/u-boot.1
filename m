Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C52CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C302F8777C;
	Tue, 12 Dec 2023 00:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CrSo9Da9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE47D877DE; Tue, 12 Dec 2023 00:21:50 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D74877BC
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b9e2a5e8faso2058546b6e.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336894; x=1702941694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5MmLTyPSaXbpcUIGw5nJR17KHdoAWQ54YJDEvdfcRo=;
 b=CrSo9Da91Q4/1TNmcj4VPC+udt9yTY1//+fcFwL1XVWA8EQKgvaXvBM4qN4ehqLm0t
 gR/lgvx9Jao6HHJ5g7qvUM+S1KA2W4swh6IvuYl2tFzIhiczJkusty+b6OVJ1751AHt0
 xwVigauah7xbBGbvVK+Mvgbr6WqrGKjfp92AGmIVRkThKkSBqA/m7UOIwprVR+UaUfX2
 GjUbakRakJGcB7TBP8axw7BysENub7+4JAS1TuAQqwcxWDeS57DYIwGMOHY72SShTICz
 A5d35yBfyvwqQdeqiO74IyAN/ikBDimkM0qCpaelNZNN9l0O/VrNsGgOdJqjbk+lTdhY
 SmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336894; x=1702941694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5MmLTyPSaXbpcUIGw5nJR17KHdoAWQ54YJDEvdfcRo=;
 b=Ohw09FAjDtdKHpgjqnk68cNV6w8xqRnidzHAubP1cfW2gVQTg22tL86d9G3ADZ8cj9
 Hsi29PMBbkAcjJbpyjY/+KNMdfchtrEmEh8bMBwsRqUDR57gYCyFtViRkn4QoGroL3BH
 7xxKBZiGAF9QGd2SOdVv4lZ5VaG1yQdti7+LOFCenFoSIeMrGxqac1z6Cczx8CWYMA9T
 szgcFbANEV418M+cOdHYjWMxQqdykm+KQ/LUU5aiJpZY6bmdGwDdbyMoD3ezKBx0uX2I
 5eXGj6jsQM6ZrfaEeiiIjrBQcv6oUtklE5XMkc+avBDJkUBl0yE3of+qkdIEQ82dgzI+
 Swdg==
X-Gm-Message-State: AOJu0YwbFkxBVoLhBKfHRxFwnqfYQuXVx8sc6Yi0MRb7Wqv0BwPFKqqs
 cZ0YkAZY152bpikg/uGFZeqT4TOWeGk=
X-Google-Smtp-Source: AGHT+IH8mjQAvEFQjQt/rItiHCe8E3M+xbUhOzoPfI7ysT79pUCLrS+Bb4v7ehv6O264IZ27h19sNw==
X-Received: by 2002:a05:6808:111:b0:3b8:b06b:97f0 with SMTP id
 b17-20020a056808011100b003b8b06b97f0mr2520079oie.32.1702336894233; 
 Mon, 11 Dec 2023 15:21:34 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:33 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 4/7] board: rockchip: Add Recovery Button for Anbernic RGxx3
Date: Mon, 11 Dec 2023 17:21:22 -0600
Message-Id: <20231211232125.171438-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Add support for users to enter recovery mode by holding the function
button when they power up the device.

Since the device has soldered eMMC and sometimes does not expose a clk
pin on the mainboard there is a small chance that a user who flashes a
bad bootloader may not be able to recover if the headers themselves
are valid. As a result this check is done during spl_early_init() to
ensure that it runs as early as possible, and it does so by directly
manipulating the ADC hardware in lieu of loading the ADC driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 11 +++++++++++
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c     |  6 +++++-
 configs/anbernic-rgxx3-rk3566_defconfig        | 16 ++++++++++++----
 include/configs/anbernic-rgxx3-rk3566.h        |  2 ++
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index f986e1941e..e3ab196d22 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -76,6 +76,12 @@
 	/delete-property/ clock-names;
 };
 
+&saradc {
+	bootph-all;
+	vref-supply = <&vcc_sys>;
+	status = "okay";
+};
+
 &sdhci {
 	pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
 		    <&emmc_datastrobe>, <&emmc_rstnout>;
@@ -94,3 +100,8 @@
 	bootph-all;
 	status = "okay";
 };
+
+&vcc_sys {
+	bootph-all;
+	status = "okay";
+};
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 3d0c614623..45854709f5 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -5,6 +5,7 @@
 
 #include <abuf.h>
 #include <adc.h>
+#include <asm/arch-rockchip/boot_mode.h>
 #include <asm/io.h>
 #include <display.h>
 #include <dm.h>
@@ -119,11 +120,14 @@ static const struct rg353_panel rg353_panel_details[] = {
 };
 
 /*
- * Start LED very early so user knows device is on. Set color
+ * Check if rockchip_dnl button is pressed and reboot into rockusb if
+ * true. Start LED very early so user knows device is on. Set color
  * to red.
  */
 void spl_board_init(void)
 {
+	setup_boot_mode();
+
 	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
 	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index ed6643d9d4..4e72f75815 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -3,6 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
@@ -24,7 +25,9 @@ CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
@@ -32,7 +35,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
-CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x4000000
@@ -41,6 +44,8 @@ CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_STACK_R=y
+CONFIG_SPL_ADC=y
+CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
@@ -50,8 +55,10 @@ CONFIG_CMD_MMC=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 # CONFIG_NET is not set
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -67,13 +74,13 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_FAN53555=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
-CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
-CONFIG_DM_REGULATOR_SCMI=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
@@ -89,5 +96,6 @@ CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
 CONFIG_VIDEO_BRIDGE=y
 CONFIG_REGEX=y
+# CONFIG_RSA is not set
 CONFIG_ERRNO_STR=y
 # CONFIG_EFI_LOADER is not set
diff --git a/include/configs/anbernic-rgxx3-rk3566.h b/include/configs/anbernic-rgxx3-rk3566.h
index 3c4ea4e7d8..2aaac55c06 100644
--- a/include/configs/anbernic-rgxx3-rk3566.h
+++ b/include/configs/anbernic-rgxx3-rk3566.h
@@ -9,4 +9,6 @@
 			"stdout=serial,vidconsole\0" \
 			"stderr=serial,vidconsole\0"
 
+#define RK_DNL_ADC_CHAN		0
+
 #endif
-- 
2.34.1

