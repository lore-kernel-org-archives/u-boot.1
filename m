Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F75C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 10:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAC782F00;
	Sun, 29 Jun 2025 12:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CEmq7faU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2873082E40; Sun, 29 Jun 2025 12:57:46 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A84982E5A
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-32b43c5c04fso45377741fa.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 03:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751194660; x=1751799460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUXqr6lDNUL6ZPrc0liIGmZ+aTkqy5nr0CdV9ryT6eQ=;
 b=CEmq7faUAlbg9HU825C2SPeoE4zxRwysOtD0NL72TWr1O4vynP4F16OpdQj1xQFtYa
 UfUh/msodvQCIfJQSLYKiGph0ByGvrLs6sUXZe9rSHWX4fWJikmKPqPtbKUrtA8J5+i0
 DQQrVtu9kWAzeXir63zOHmaA+moEwYFbpxsvcVx/ZAGyLjNUWbn2tBN5VB9rccEw9Yed
 PZyZC331Q0701Asp2nRKDXqC2xNFhD6LIlXqYV3ErFVycxcaxET+paMpOLCvrn+erF15
 OT/M/mM0540oykPNbT4HIHnd+ZSJnYdSR94NguvUcPVigu7sbEq6uvFIHqVo+oQ62cZ7
 5+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751194660; x=1751799460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUXqr6lDNUL6ZPrc0liIGmZ+aTkqy5nr0CdV9ryT6eQ=;
 b=GNTPiSesxx+T+zn4EzNVxM/czzdrxXiZd7BMEfd3wnENDSVaZ+njuvPCR+0S/bsj6Q
 BZO85uDX5tyXNoQgx/4PtA42jZKI+H5Hf6wceyuzNf+ThF9Xl2bNqF0HC0bxSUhoJNGg
 /k7AAueELtf3F8stk6IXUWLisDPtCZk1PjbsgcDmq5qSuk1t4UlqG9GVTKs0Jf9+iyFw
 e16WW9nPCnohtEMWLRZtM2VtT2SIQwp1yH7lP8wPNGquGtYOXzoyxFnbanWgtP/I61+n
 WEQ+Tf0nn4LWN69jcaQe6eFUGxu7eJaURKT+zTmNo6rolfGjWVahb96iEFovrjKL66J1
 fOEQ==
X-Gm-Message-State: AOJu0Yw4o2aG5M5+XRRS/iwlTwg4r+fWGU1kA07rBZRM9O1bVXn16IWL
 Ok66u+HAUYT+6SVN9xhx6WO8/Qt5nFPJs5r83jQfROldCE6pSyKWDUO4l0Cfq85Y
X-Gm-Gg: ASbGncsQ/gskd89SXuHtlnN+Pa9f4EQmm14uWn+nYiKCRR5C/DTa0SHPNWBRL7x8/rT
 e6dtuenhpR5C8dDoc2A++YRYkT55PzDH/DPOaGGOeumJ0KDgpvyI3fcIPcEdjmQACxbUf6uSwjI
 LA6d6bDelcQNI9AolZkLS8OgPP9LTN0oNaYlj/uyhEB/HAYVKSJct14BIJkoDoUn/fNWjb1ZuRS
 mT1n9QSGdYdb2abktEtOwarIfsxPL7HUISakMmFbarIwsclHZWB6P53Y4lznxK75qvCflvI5wLX
 FO5b1cHruw6xI3wwqnDCUiRmRlThzybvrgXHUHpyipqBPoZI1Iagqw==
X-Google-Smtp-Source: AGHT+IEDpDE9eM8GtEhqDZZRwKtcaJBxXDhREOjIMNxdD+2dpIZCAIuDLhApLbXlhqWhvcYHBDR6lQ==
X-Received: by 2002:a05:6512:158c:b0:554:f72c:8192 with SMTP id
 2adb3069b0e04-5550c2bfce7mr2443586e87.5.1751194659349; 
 Sun, 29 Jun 2025 03:57:39 -0700 (PDT)
Received: from xeon.. ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b24d32esm1092514e87.69.2025.06.29.03.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 03:57:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mario Six <mario.six@gdsys.cc>, Christian Marangi <ansuelsmth@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ion Agorria <ion@agorria.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wang Jie <dave.wang@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 3/4] cmd: aes: Add support for DM AES drivers
Date: Sun, 29 Jun 2025 13:57:10 +0300
Message-ID: <20250629105711.24687-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250629105711.24687-1-clamor95@gmail.com>
References: <20250629105711.24687-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

This adds new aes subcommands to use interface provided by AES UCLASS which
can be used to expose HW AES engines.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 cmd/aes.c | 275 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 255 insertions(+), 20 deletions(-)

diff --git a/cmd/aes.c b/cmd/aes.c
index 87ad1ab82b9..3fd83013ffe 100644
--- a/cmd/aes.c
+++ b/cmd/aes.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014 Marek Vasut <marex@denx.de>
+ * Copyright (C) 2025 Ion Agorria <ion@agorria.com>
  *
- * Command for en/de-crypting block of memory with AES-[128/192/256]-CBC cipher.
+ * Command for AES-[128/192/256] operations.
  */
 
 #include <command.h>
@@ -12,6 +13,8 @@
 #include <linux/compiler.h>
 #include <mapmem.h>
 #include <vsprintf.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
 
 u32 aes_get_key_len(char *command)
 {
@@ -25,29 +28,30 @@ u32 aes_get_key_len(char *command)
 	return key_len;
 }
 
-/**
- * do_aes() - Handle the "aes" command-line command
- * @cmdtp:	Command data struct pointer
- * @flag:	Command flag
- * @argc:	Command-line argument count
- * @argv:	Array of command-line arguments
- *
- * Returns zero on success, CMD_RET_USAGE in case of misuse and negative
- * on error.
- */
-static int do_aes(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+int aes_get_driver(struct udevice **dev)
+{
+	int ret;
+
+	ret = uclass_get_device(UCLASS_AES, 0, dev);
+	if (ret) {
+		printf("Failed to get AES driver: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int cmd_aes_cbc_simple(int argc, char *const argv[], u32 key_len)
 {
 	uint32_t key_addr, iv_addr, src_addr, dst_addr, len;
 	uint8_t *key_ptr, *iv_ptr, *src_ptr, *dst_ptr;
 	u8 key_exp[AES256_EXPAND_KEY_LENGTH];
-	u32 aes_blocks, key_len;
+	u32 aes_blocks;
 	int enc;
 
 	if (argc != 7)
 		return CMD_RET_USAGE;
 
-	key_len = aes_get_key_len(argv[0]);
-
 	if (!strncmp(argv[1], "enc", 3))
 		enc = 1;
 	else if (!strncmp(argv[1], "dec", 3))
@@ -84,26 +88,257 @@ static int do_aes(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	unmap_sysmem(src_ptr);
 	unmap_sysmem(dst_ptr);
 
-	return 0;
+	return CMD_RET_SUCCESS;
+}
+
+int cmd_aes_get_slots(void)
+{
+	struct udevice *dev;
+	u8 slots;
+	int ret;
+
+	ret = aes_get_driver(&dev);
+	if (ret)
+		return ret;
+
+	slots = dm_aes_get_available_key_slots(dev);
+	printf("Available slots: %d\n", slots);
+
+	return CMD_RET_SUCCESS;
+}
+
+int cmd_aes_set_key(int argc, char *const argv[], u32 key_len)
+{
+	struct udevice *dev;
+	u32 key_addr, slot;
+	u8 *key_ptr;
+	int ret;
+
+	if (argc != 4)
+		return CMD_RET_USAGE;
+
+	ret = aes_get_driver(&dev);
+	if (ret)
+		return ret;
+
+	key_addr = hextoul(argv[2], NULL);
+	slot = hextoul(argv[3], NULL);
+
+	key_ptr = (uint8_t *)map_sysmem(key_addr, key_len);
+
+	ret = dm_aes_set_key_for_key_slot(dev, key_len * 8, key_ptr, slot);
+	unmap_sysmem(key_ptr);
+	if (ret) {
+		printf("Unable to set key at slot: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+int cmd_aes_select_slot(int argc, char *const argv[], u32 key_len)
+{
+	struct udevice *dev;
+	u32 slot;
+	int ret;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	ret = aes_get_driver(&dev);
+	if (ret)
+		return ret;
+
+	slot = hextoul(argv[2], NULL);
+
+	ret = dm_aes_select_key_slot(dev, key_len * 8, slot);
+	if (ret) {
+		printf("Unable to select key slot: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+int cmd_aes_ecb(int argc, char *const argv[], u32 key_len)
+{
+	struct udevice *dev;
+	u32 src_addr, dst_addr, len;
+	u8 *src_ptr, *dst_ptr;
+	u32 aes_blocks;
+	int enc, ret;
+
+	if (argc != 6)
+		return CMD_RET_USAGE;
+
+	ret = aes_get_driver(&dev);
+	if (ret)
+		return ret;
+
+	if (!strncmp(argv[1], "enc", 3))
+		enc = 1;
+	else if (!strncmp(argv[1], "dec", 3))
+		enc = 0;
+	else
+		return CMD_RET_USAGE;
+
+	src_addr = hextoul(argv[3], NULL);
+	dst_addr = hextoul(argv[4], NULL);
+	len = hextoul(argv[5], NULL);
+
+	src_ptr = (uint8_t *)map_sysmem(src_addr, len);
+	dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
+
+	/* Calculate the number of AES blocks to encrypt. */
+	aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
+
+	if (enc)
+		ret = dm_aes_ecb_encrypt(dev, src_ptr, dst_ptr, aes_blocks);
+	else
+		ret = dm_aes_ecb_decrypt(dev, src_ptr, dst_ptr, aes_blocks);
+
+	unmap_sysmem(src_ptr);
+	unmap_sysmem(dst_ptr);
+
+	if (ret) {
+		printf("Unable to do ecb operation: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+int cmd_aes_cbc(int argc, char *const argv[], u32 key_len)
+{
+	struct udevice *dev;
+	u32 iv_addr, src_addr, dst_addr, len;
+	u8 *iv_ptr, *src_ptr, *dst_ptr;
+	u32 aes_blocks;
+	int enc, ret;
+
+	if (argc != 7)
+		return CMD_RET_USAGE;
+
+	ret = aes_get_driver(&dev);
+	if (ret)
+		return ret;
+
+	if (!strncmp(argv[1], "enc", 3))
+		enc = 1;
+	else if (!strncmp(argv[1], "dec", 3))
+		enc = 0;
+	else
+		return CMD_RET_USAGE;
+
+	iv_addr = hextoul(argv[3], NULL);
+	src_addr = hextoul(argv[4], NULL);
+	dst_addr = hextoul(argv[5], NULL);
+	len = hextoul(argv[6], NULL);
+
+	iv_ptr = (uint8_t *)map_sysmem(iv_addr, AES_BLOCK_LENGTH);
+	src_ptr = (uint8_t *)map_sysmem(src_addr, len);
+	dst_ptr = (uint8_t *)map_sysmem(dst_addr, len);
+
+	/* Calculate the number of AES blocks to encrypt. */
+	aes_blocks = DIV_ROUND_UP(len, AES_BLOCK_LENGTH);
+
+	if (enc)
+		ret = dm_aes_cbc_encrypt(dev, iv_ptr, src_ptr, dst_ptr, aes_blocks);
+	else
+		ret = dm_aes_cbc_decrypt(dev, iv_ptr, src_ptr, dst_ptr, aes_blocks);
+
+	unmap_sysmem(iv_ptr);
+	unmap_sysmem(src_ptr);
+	unmap_sysmem(dst_ptr);
+
+	if (ret) {
+		printf("Unable to do cbc operation: %d\n", ret);
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+/**
+ * do_aes() - Handle the "aes" command-line command
+ * @cmdtp:	Command data struct pointer
+ * @flag:	Command flag
+ * @argc:	Command-line argument count
+ * @argv:	Array of command-line arguments
+ *
+ * Returns zero on success, CMD_RET_USAGE in case of misuse and negative
+ * on error.
+ */
+static int do_aes(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	u32 key_len;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	key_len = aes_get_key_len(argv[0]);
+
+	if (!strncmp(argv[1], "enc", 3) || !strncmp(argv[1], "dec", 3))
+		return cmd_aes_cbc_simple(argc, argv, key_len);
+	else if (CONFIG_IS_ENABLED(DM_AES) && !strncmp(argv[1], "get_slots", 9))
+		return cmd_aes_get_slots();
+	else if (CONFIG_IS_ENABLED(DM_AES) && !strncmp(argv[1], "set_key", 7))
+		return cmd_aes_set_key(argc, argv, key_len);
+	else if (CONFIG_IS_ENABLED(DM_AES) && !strncmp(argv[1], "select_slot", 11))
+		return cmd_aes_select_slot(argc, argv, key_len);
+	else if (CONFIG_IS_ENABLED(DM_AES) && !strncmp(argv[1], "ecb", 3))
+		return cmd_aes_ecb(argc, argv, key_len);
+	else if (CONFIG_IS_ENABLED(DM_AES) && !strncmp(argv[1], "cbc", 3))
+		return cmd_aes_cbc(argc, argv, key_len);
+	else
+		return CMD_RET_USAGE;
 }
 
 /***************************************************/
 U_BOOT_LONGHELP(aes,
-	"[.128,.192,.256] enc key iv src dst len - Encrypt block of data $len bytes long\n"
+	"[.128,.192,.256] enc key iv src dst len - CBC encrypt block of data $len bytes long\n"
 	"                             at address $src using a key at address\n"
 	"                             $key with initialization vector at address\n"
 	"                             $iv. Store the result at address $dst.\n"
 	"                             The $len size must be multiple of 16 bytes.\n"
 	"                             The $key and $iv must be 16 bytes long.\n"
-	"aes [.128,.192,.256] dec key iv src dst len - Decrypt block of data $len bytes long\n"
+	"aes [.128,.192,.256] dec key iv src dst len - CBC decrypt block of data $len bytes long\n"
 	"                             at address $src using a key at address\n"
 	"                             $key with initialization vector at address\n"
 	"                             $iv. Store the result at address $dst.\n"
 	"                             The $len size must be multiple of 16 bytes.\n"
-	"                             The $key and $iv must be 16 bytes long.");
+	"                             The $key and $iv must be 16 bytes long."
+
+#if CONFIG_IS_ENABLED(DM_AES)
+	"\n"
+	"aes get_slots - Gives number of available key slots\n"
+	"aes [.128,.192,.256] set_key key slot - Load key at address $key into the slot $slot\n"
+	"aes [.128,.192,.256] select_slot slot - Select current active key slot\n"
+	"aes [.128,.192,.256] ecb enc src dst len - ECB encrypt block of data $len bytes long\n"
+	"                             at address $src using a key at current\n"
+	"                             slot. Store the result at address $dst.\n"
+	"                             The $len size must be multiple of 16 bytes.\n"
+	"aes [.128,.192,.256] ecb dec src dst len - ECB decrypt block of data $len bytes long\n"
+	"                             at address $src using a key at current\n"
+	"                             slot. Store the result at address $dst.\n"
+	"                             The $len size must be multiple of 16 bytes.\n"
+	"aes [.128,.192,.256] cbc enc iv src dst len - CBC encrypt block of data $len bytes long\n"
+	"                             at address $src using a key at current\n"
+	"                             slot with initialization vector at address\n"
+	"                             $iv. Store the result at address $dst.\n"
+	"                             The $len size must be multiple of 16 bytes.\n"
+	"                             The $iv must be 16 bytes long.\n"
+	"aes [.128,.192,.256] cbc dec iv src dst len - CBC decrypt block of data $len bytes long\n"
+	"                             at address $src using a key at current\n"
+	"                             slot with initialization vector at address\n"
+	"                             $iv. Store the result at address $dst.\n"
+	"                             The $len size must be multiple of 16 bytes.\n"
+	"                             The $iv must be 16 bytes long."
+#endif
+);
 
 U_BOOT_CMD(
 	aes, 7, 1, do_aes,
-	"AES 128/192/256 CBC encryption",
+	"AES 128/192/256 operations",
 	aes_help_text
 );
-- 
2.48.1

