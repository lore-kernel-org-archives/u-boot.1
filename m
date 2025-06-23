Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB99C77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 17:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4986282E08;
	Mon, 23 Jun 2025 19:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXibJsoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDEE82E08; Mon, 23 Jun 2025 19:40:26 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096B282D60
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 19:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so2741953b3a.1
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700422; x=1751305222; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n6sz4dtkB1gwMMEu1sWCutstGQQvVdlQqkmMBEjHEkM=;
 b=lXibJsoeM3bb49Utc6BngOCHIf89NUNOltqwFyTSal0X0abF/BTDrysHNqOLLnabkv
 pEEbmui/N0ZSoum+ac/AHeiuHEM00LzwEgD9z70HRo5f7ZVshIhdvYbTBE/KezUmwiHp
 /O5E7iOqOKPY/9cTZYdj96G9m1xol/nK/pMcT79jp0QMtDMryTOJqhu1BfGiTUMlrGL7
 KklROum4kD6f+hhHo1IAvPfWD1LqYeUC82tImOIcWKol3yKZRw3z3QEPgopw96o1+Sm4
 e31Y7sxYosbPPRA5Wl8cjG0QG4MokHMOF3UqQytsm84FGDhlwmeVn43EJ0I3vu93qO9z
 1C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700422; x=1751305222;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6sz4dtkB1gwMMEu1sWCutstGQQvVdlQqkmMBEjHEkM=;
 b=oTd6fsf8gxIf3Zn+M1r8z+SEKgT7O777TTya80ZPyCB2od4YOSc9UA6LffCW4pKDEo
 062yKC9C+S+scBwhHtaZnbGhd3TM1DK/Zp7rpHJH7SaKo1Z1BJz6P10JNUkc136TJatt
 c/MKGW6Y9aRutU4Lze9356f1tIbsYSQblLvYkWCoM12hBJcWTY/pt8T13vQuOFlw+49o
 s4jNUPK3/6PdSwS3tL56FCqXk2pUyoD8+hc1/PL4cRWuSfX4wiZkJzh4fmZLVKzq2ST9
 a6IH+q4tCfUWBtYKlv5kaSXGgMiSawwqESsNoXkzVVii//6YQ3PKnzuB2TMb/tRbV5Yk
 wKiQ==
X-Gm-Message-State: AOJu0YwFQ+qvhts7bRPKuNHZT1tK0Gm4mFWvFKgkEyNuwhGrHS/ZwqWJ
 +RSGF76KRVBqL4LDsqJxetjmqe8OYIsVI1fcZrUoh+tTUrAAFzmgz5yt
X-Gm-Gg: ASbGncuv5b2l6tpSxycTSk4nd7PdifjTWtpFqSCErRkyrGmBSXbb++ZVD6Cr561JNCp
 7AXrtao1CrtgocZx6e4huX/WIwjLkehO+I4dU8ndBLJccUgZ2fj/dWfLtgQSaAyECDdwux1iwer
 HMt1SzAbIdX4+je15Ej/cP86I2hDxFrEQlrO5qqmHupKbCLWwtbsSIiNtHJDJhxxbJdQGe0ZAPd
 r4UhQT5ZhtREessRwv203njQvy0cs3xnV/qU6bhgDxWXqRiQbFD//sbmbOj9TDD6Hx8UO2gZQD0
 syrP1892PlkvfmRwBt51DIlaoJD97ZBTUL86LYsHTczsY7hVHfHsI/VvAtVGugJ0AWJw47DV7fN
 Y+xPeb9ZsX1F2XW8=
X-Google-Smtp-Source: AGHT+IExqZB1UVH5ksoxS0Hgq+H5nUxGetEvLpDTRFijG66xgtiEgdOFfhiAV8rPPV3FVA4HPFfkmA==
X-Received: by 2002:a17:90a:f94f:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-3159d8dab59mr21506005a91.28.1750700422413; 
 Mon, 23 Jun 2025 10:40:22 -0700 (PDT)
Received: from [10.22.1.180] ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8354bsm9465088a91.18.2025.06.23.10.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:40:21 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 23 Jun 2025 14:39:54 -0300
Subject: [PATCH 1/4] boot: Make ft_board_setup_ex() generic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-am62p-fdt-fixup-trip-points-v1-1-12355eb6a72f@toradex.com>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

In some use cases, board-specific device tree changes must not be
overwritten by system fixups. Although U-Boot provides
ft_board_setup_ex() for this purpose, it is currently only used on TI
Keystone. Make ft_board_setup_ex() to be a generic option, allowing its
use by other architectures/boards. To maintain backward compatibility,
enable it by default on TI Keystone.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm/Kconfig      |  1 +
 boot/Kconfig          | 10 ++++++++++
 boot/image-fdt.c      | 27 +++++++++++++--------------
 cmd/fdt.c             |  6 +++---
 include/fdt_support.h | 15 ++++++++++-----
 5 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9a22c7f6ceaae9796b130a038c01617d87ad258c..da67f20675a5d5a56ed524e1e6f8154f28b27f8f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -810,6 +810,7 @@ config ARCH_KEYSTONE
 	imply CMD_SAVES
 	imply DM_I2C
 	imply FIT
+	imply OF_BOARD_SETUP_EXTENDED
 	imply SOC_TI
 	imply TI_KEYSTONE_SERDES
 
diff --git a/boot/Kconfig b/boot/Kconfig
index 1f5ecb60c77d56b36840eb4449d9ea71b4c402cd..b0548358e8b9c21ac8054c4c574718219f77b8c4 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1839,6 +1839,16 @@ config OF_BOARD_SETUP
 	  board-specific information in the device tree for use by the OS.
 	  The device tree is then passed to the OS.
 
+config OF_BOARD_SETUP_EXTENDED
+	bool "Set up latest board-specific details in device tree before boot"
+	imply OF_BOARD_SETUP
+	help
+	  This causes U-Boot to call ft_board_setup_ex() before booting into
+	  the Operating System. Similar function as ft_board_setup(). However,
+	  its modifications are not overwritten by other system changes and are
+	  applied to the device tree as the very last step before boot.
+	  The device tree is then passed to the OS.
+
 config OF_SYSTEM_SETUP
 	bool "Set up system-specific details in device tree before boot"
 	help
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8f718ad29f6b7af9cb1d0cedc8e4c038eb3020fc..1c5d9426b869ca4ad5babf8398d41abe0f02437d 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -571,6 +571,7 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 {
 	ulong *initrd_start = &images->initrd_start;
 	ulong *initrd_end = &images->initrd_end;
+	bool skip_board_fixup = false;
 	int ret, fdt_ret, of_size;
 
 	if (IS_ENABLED(CONFIG_OF_ENV_SETUP)) {
@@ -621,18 +622,18 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	fdt_fixup_pstore(blob);
 #endif
 	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP)) {
-		const char *skip_board_fixup;
+		skip_board_fixup = (env_get_ulong("skip_board_fixup", 10, 0) == 1);
 
-		skip_board_fixup = env_get("skip_board_fixup");
-		if (skip_board_fixup && ((int)simple_strtol(skip_board_fixup, NULL, 10) == 1)) {
-			printf("skip board fdt fixup\n");
-		} else {
-			fdt_ret = ft_board_setup(blob, gd->bd);
-			if (fdt_ret) {
-				printf("ERROR: board-specific fdt fixup failed: %s\n",
-				       fdt_strerror(fdt_ret));
-				goto err;
-			}
+		if (skip_board_fixup)
+			printf("skip all board fdt fixup\n");
+	}
+
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP) && !skip_board_fixup) {
+		fdt_ret = ft_board_setup(blob, gd->bd);
+		if (fdt_ret) {
+			printf("ERROR: board-specific fdt fixup failed: %s\n",
+			       fdt_strerror(fdt_ret));
+			goto err;
 		}
 	}
 	if (IS_ENABLED(CONFIG_OF_SYSTEM_SETUP)) {
@@ -685,10 +686,8 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
 	if (CONFIG_IS_ENABLED(LMB) && lmb)
 		lmb_reserve(map_to_sysmem(blob), of_size, LMB_NONE);
 
-#if defined(CONFIG_ARCH_KEYSTONE)
-	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP))
+	if (IS_ENABLED(CONFIG_OF_BOARD_SETUP_EXTENDED) && !skip_board_fixup)
 		ft_board_setup_ex(blob, gd->bd);
-#endif
 
 	return 0;
 err:
diff --git a/cmd/fdt.c b/cmd/fdt.c
index d16b141ce32d2173b08e64a8084b7b2b0f5a5192..a67c30b21d55dced7dba72e8ccdfbe3466ed820c 100644
--- a/cmd/fdt.c
+++ b/cmd/fdt.c
@@ -691,9 +691,9 @@ static int do_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			       fdt_strerror(err));
 			return CMD_RET_FAILURE;
 		}
-#ifdef CONFIG_ARCH_KEYSTONE
-		ft_board_setup_ex(working_fdt, gd->bd);
-#endif
+
+		if (IS_ENABLED(CONFIG_OF_BOARD_SETUP_EXTENDED))
+			ft_board_setup_ex(working_fdt, gd->bd);
 	}
 #endif
 	/* Create a chosen node */
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 049190cf3d701db1f63d82c9a0223417ac9edc75..47b8b63d13dc515add480d1805c5e97998ecfc2b 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -240,11 +240,16 @@ int board_rng_seed(struct abuf *buf);
  */
 const char *board_fdt_chosen_bootargs(const struct fdt_property *fdt_ba);
 
-/*
- * The keystone2 SOC requires all 32 bit aliased addresses to be converted
- * to their 36 physical format. This has to happen after all fdt nodes
- * are added or modified by the image_setup_libfdt(). The ft_board_setup_ex()
- * called at the end of the image_setup_libfdt() is to do that convertion.
+/**
+ * ft_board_setup_ex() - Latest board-specific FDT changes
+ *
+ * @blob: FDT blob to update
+ * @bd:   Pointer to board data
+ *
+ * Execute board-specific device tree modifications that must be the latest FDT
+ * changes and cannot be overwritten by other system fixups.
+ *
+ * This function is called if CONFIG_OF_BOARD_SETUP_EXTENDED is defined.
  */
 void ft_board_setup_ex(void *blob, struct bd_info *bd);
 

-- 
2.43.0

