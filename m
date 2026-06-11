Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57ACD98CF
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F175C848B0;
	Thu, 11 Jun 2026 16:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqtzL5VP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6F75848B0; Thu, 11 Jun 2026 16:18:45 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46C1783FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-517760dc3c2so50160361cf.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187522; x=1781792322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnAxNDJojXsytMmgGcQCx+9BYoGH7KwCZW+7a04GghQ=;
 b=kqtzL5VPuI9WxkFTbog8+cjdWK1q7SFS8adhs1+fiRjKv2W81mw66d7PTH67Mtqn16
 ijGSUH0uy+e0YOsGHShy3kVxUoARk3x+bgGDj0hg8Y97F0ZNSSA9J0Sx/27pY4ojzhKi
 wes8ho1Wj+DCLaDqoh0cnzNFTK53DkjTYHaMhC75SIZiIspO/NulEC8RbJvEXsweCa/j
 X3J9KFlaZTOVNxRS8idJgkQyrNeNgyzzZHQIGf6kqt5/5AO8p5WhK0D//iBgQyUt8VQs
 8zemPEmpcDTfoAZxV2gQHS4b1u+ejd0GJZm2suJAaCqjLpnaDJswWPJ8obfRw/k2Gb9c
 aupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187522; x=1781792322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pnAxNDJojXsytMmgGcQCx+9BYoGH7KwCZW+7a04GghQ=;
 b=lPYbH2DtwH/3QTLOS16KWnxT+kXlAzLyt/kK7/QKaNlWKLkwOneuL9aBKssyIx5EA3
 8OllrPB1fksm3ScLkOJfaPcjEWejEZT50siqZWkB8R+kFS1oLJmlC/gWBCplLSvr7AN1
 9lrITWEE0i9yCYk76nIhNBnfQjAskYHbezWyY5l1ORfjH4JZY2/ATJDubol0GFBEPnc6
 olePLd0HPhtrCr4i6y+B4MvAwYwFnHb+oacfzHOiVXSN8jTg5kLxSwZEy70X3BgeUTJ4
 4n9CB1H10FA97y8f5JxzJW7RCKxkA+ArjRIRezL1jW3Ch9qqo9C1s6VOy8hHV/xT0e4Y
 /rpg==
X-Gm-Message-State: AOJu0YzMbgzQkw1f1b0owZADH/xkig7Yii2QnpFatoGQUj+rf/Jzmv1+
 m/TZKiJm4IV6zDwWNRRTK0ymj7X2umr2uqhNpC4mL5+qXB6GtORhq8PabCWOmExX
X-Gm-Gg: Acq92OEuFxwEu8ayv7xowBEzxeDnjydT7Y/+FZC5HKv5c+l7sQygzpuP3FgdWoRxax/
 26ad3ejuyOR3Lws1tX4DR769S/IgdkFLPU6F1LeWZFS8FUeOpHK4qDMp6nMaqR0Fab2dXK3UcSB
 GCQQexHl8SPeOtzX5AhQ3vRYxT3ghWRkMjomfcQFgwgA5oz6gm8wGnlfVHj7++iD5xfYnJvzKex
 2uerPeGDafvluwvOv46rSk2CU3+UqF8dKsc9C5XO7g/XWJoqFYasBf73LxhJc2sgehzRgvvLZJC
 IaqI0L6hSUNxt99DAhU5LwbpEl5ed+lVmcDMTZWaOdgEGWpia//h+mOT/PYIFj9ikqsap1zIUfU
 6Khy9qPLArF82aevUsbGLSGvU3hhGIstlbtUf7rMSvN83+hh7qNnZC1LWxi07HbbjLZNKM4dvNZ
 Iz58uL38kMJRA0Rze3pcckpbE1DHWBQVu731GlxA7WNhdNmLjCexFOlnVrojmLCop7VdPoZFQtv
 SMuhCcmyQN3IlEgsdfebGBvQPEyAg==
X-Received: by 2002:a05:622a:54a:b0:517:76b7:7b3e with SMTP id
 d75a77b69052e-517ee21406emr47284291cf.38.1781187521837; 
 Thu, 11 Jun 2026 07:18:41 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:41 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 6/9] spacemit: k1: Add multiple device tree support
Date: Thu, 11 Jun 2026 10:18:08 -0400
Message-Id: <20260611141811.68904-7-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

Enable multiple DTB support in the FIT image for the Spacemit K1 SoC,
allowing a single U-Boot binary to support different board variants.

The SPL reads the board type from EEPROM and selects the corresponding
device tree at runtime via board_fit_config_name_match(), ensuring the
correct hardware description is passed to U-Boot proper.

Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- Reworked.  Drop the v1 approach (new local k1-muse-pi-pro.dts,
  enlarge SYS_MALLOC_F_LEN, MMODE switch).
- Use binman --fit-multi-config so u-boot.itb packs multiple board
  DTs from the upstream tree.
Changes in v3:
- Append CONFIG_SPL_BOARD_INIT. Move the operation on product name
  in board_init_r stage.

 board/spacemit/k1/spl.c       | 64 +++++++++++++++++++++++++++++------
 configs/spacemit_k1_defconfig |  3 ++
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index da4169fbc8c..0db362130e4 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -55,6 +55,8 @@ struct ddr_cfg {
 binman_sym_declare(ulong, ddr_fw, image_pos);
 binman_sym_declare(ulong, ddr_fw, size);
 
+char product_name[I2C_BUF_SIZE] = "k1";
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -104,6 +106,37 @@ int read_product_name(char *name, int size)
 	return -ENOENT;
 }
 
+static const struct {
+	const char *eeprom_name;
+	const char *fit_name;
+} k1_board_map[] = {
+	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
+	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
+	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+};
+
+static void fixup_product_name(void)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	memset(fdt_name, 0, I2C_BUF_SIZE);
+	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
+		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
+			     strlen(k1_board_map[i].eeprom_name))) {
+			snprintf(fdt_name, I2C_BUF_SIZE, "%s",
+				 k1_board_map[i].fit_name);
+			break;
+		}
+	}
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, CONFIG_DEFAULT_DEVICE_TREE);
+	}
+	memset(product_name, 0, I2C_BUF_SIZE);
+	memcpy(product_name, fdt_name, I2C_BUF_SIZE);
+}
+
 static void clk_early_init(void)
 {
 	struct udevice *dev;
@@ -322,14 +355,8 @@ void nor_early_init(void)
 	udelay(10);
 }
 
-void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
-{
-	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
-}
-
 void board_init_f(ulong dummy)
 {
-	u8 i2c_buf[I2C_BUF_SIZE] = { 0 };
 	int ret;
 
 	ret = spl_early_init();
@@ -344,11 +371,6 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 
 	i2c_early_init();
-	ret = read_product_name(i2c_buf, I2C_BUF_SIZE);
-	if (ret)
-		log_info("Fail to detect board:%d\n", ret);
-	else
-		log_info("Get board name:%s\n", (char *)i2c_buf);
 	pmic_init();
 
 	ddr_early_init();
@@ -362,4 +384,24 @@ u32 spl_boot_device(void)
 
 void spl_board_init(void)
 {
+	int ret;
+
+	ret = read_product_name(product_name, I2C_BUF_SIZE);
+	if (ret)
+		log_info("Fail to detect board:%d\n", ret);
+	else
+		log_info("Get board name:%s\n", product_name);
+	fixup_product_name();
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	if (!strcmp(name, product_name))
+		return 0;
+	return -ENOENT;
+}
+
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	return (void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
 }
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 64c724c62a5..ee47c05d923 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -5,6 +5,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-musepi-pro"
+CONFIG_OF_LIST="spacemit/k1-bananapi-f3 spacemit/k1-musepi-pro spacemit/k1-milkv-jupiter"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x4000
 CONFIG_SPL_STACK=0xc083fb00
 CONFIG_SPL_TEXT_BASE=0xc0801000
@@ -27,6 +28,7 @@ CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
 CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
 CONFIG_SUPPORT_RAW_INITRD=y
@@ -85,3 +87,4 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_BOARD_INIT=y
-- 
2.25.1

