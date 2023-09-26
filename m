Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBCCE7D26B
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 08:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC37486DB8;
	Tue, 26 Sep 2023 10:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSel+qip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484C586DCB; Tue, 26 Sep 2023 10:57:13 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E47A86D93
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 10:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5bf7871dcso61828675ad.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695718629; x=1696323429; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iZdGea2pHSNKT6q0ppw04tJr/Wi05NgFxQ6RryeCtA=;
 b=LSel+qipso7ASfix74l4g1dTyuDSfcWUeZ1nzxsV8a1VES5OWVaciwJ5asIBMd6zRH
 PLo0QXGZRHLu/glFZX9ywVWPZO+h6Zsea1tYzvHvXO3jSU9wPc3HsD9BNjaoyjAxfSGa
 tU8qaK2Z9reGcdk9rcLqNXowZxujkuacGqCUlU9ZDyd5cDEDv7nkO5mqjZDqtWIIcH2d
 anm+6b0L8qey/TRDAo43c+5CwEg01XfaTnhKjVvvdNX4dgQSTQYFOtLC73R56/5o6yuQ
 u1mRnFEvj7ExseI3metQQEloprXhaL2muJTQO/atRjpZhu5WP98LfxI+0zwqVazGuWs9
 El/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695718629; x=1696323429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iZdGea2pHSNKT6q0ppw04tJr/Wi05NgFxQ6RryeCtA=;
 b=hYgWBLcsd0nVLEmokApnQoXCsFiOCjv2NJnCCV3LqqpzCdosjVPcSdfd0hQ0gGuZqL
 DYC/I7b5mQbUQVUbJDE1j3WapsRR1T5TVWIaJkxgdiT2/wVc+sdsE8nz4rnhBWNdjq7j
 imBexL9qpNuwCOTkhiTVh/SF96cYAtZE2aCan5YG5sPYVJSVXpg1knfVEbcV2bFZanYA
 XDpGHhY6N0YKKxSErDDAxss2VWgKBA+BuYVLPspH8IX3A/hSXV7yvWALQKIgGPeiJld0
 GX0gzE4jGQek5TaDefcw/koBPIdIIHG3XgdS1qzLNDttymAOGfANJvpWSG+RLB524LuL
 JnNw==
X-Gm-Message-State: AOJu0YyB6tWBtwBuriMSlwhPLsQOptJulPCrJU83LFdzSgmAl+5R+t2m
 AoczE4qLyDcY7WF2br6WxUwEpxmQWeGrQA==
X-Google-Smtp-Source: AGHT+IGj3v/W7aifL+AGnILvDeUxm1iki3gLg7s1JD5FGWCEcRhTsH2QprGC8150TnwKNAcgxCWtdA==
X-Received: by 2002:a17:902:b60b:b0:1c0:cb4d:df7c with SMTP id
 b11-20020a170902b60b00b001c0cb4ddf7cmr5508739pls.1.1695718629433; 
 Tue, 26 Sep 2023 01:57:09 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:c707:b24b:e4c0:3696:f2d7:f673])
 by smtp.gmail.com with ESMTPSA id
 je20-20020a170903265400b001c5fc291f02sm6515863plb.216.2023.09.26.01.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 01:57:09 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/3] arm: NPCM: modify baud rate table and dram setting
Date: Tue, 26 Sep 2023 16:56:49 +0800
Message-Id: <20230926085651.395069-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230926085651.395069-1-JJLIU0@nuvoton.com>
References: <20230926085651.395069-1-JJLIU0@nuvoton.com>
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
 board/nuvoton/arbel_evb/arbel_evb.c | 16 ++++++++--------
 configs/arbel_evb_defconfig         |  1 +
 include/configs/arbel.h             |  4 +++-
 include/configs/poleg.h             |  1 +
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index e52e0a59ab..3fb49a9549 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -16,7 +16,7 @@
 #define DRAM_1GB_SIZE		0x40000000ULL
 #define DRAM_2GB_ECC_SIZE	0x70000000ULL
 #define DRAM_2GB_SIZE		0x80000000ULL
-#define DRAM_4GB_ECC_SIZE	0xE00000000ULL
+#define DRAM_4GB_ECC_SIZE	0xE0000000ULL
 #define DRAM_4GB_SIZE		0x100000000ULL
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -29,7 +29,6 @@ int board_init(void)
 int dram_init(void)
 {
 	struct npcm_gcr *gcr = (struct npcm_gcr *)NPCM_GCR_BA;
-	uint64_t delta = 0ULL;
 
 	/*
 	 * get dram active size value from bootblock.
@@ -62,26 +61,27 @@ int dram_init(void)
 		gd->bd->bi_dram[1].size = 0;
 		break;
 	case DRAM_4GB_ECC_SIZE:
-		gd->bd->bi_dram[0].size = DRAM_2GB_ECC_SIZE;
+		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
-		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
-		delta = DRAM_4GB_SIZE - DRAM_2GB_ECC_SIZE;
+		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE - (DRAM_4GB_SIZE - DRAM_4GB_ECC_SIZE);
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	case DRAM_4GB_SIZE:
 		gd->bd->bi_dram[0].size = DRAM_2GB_SIZE;
 		gd->bd->bi_dram[1].start = DRAM_4GB_SIZE;
 		gd->bd->bi_dram[1].size = DRAM_2GB_SIZE;
-		delta = DRAM_4GB_SIZE - DRAM_2GB_SIZE;
+		/* use bank0 only */
+		gd->ram_size = DRAM_2GB_SIZE;
 		break;
 	default:
 		gd->bd->bi_dram[0].size = DRAM_1GB_SIZE;
 		gd->bd->bi_dram[1].start = 0;
 		gd->bd->bi_dram[1].size = 0;
+		gd->ram_size = DRAM_1GB_SIZE;
 		break;
 	}
 
-	gd->ram_size -= delta;
-
 	return 0;
 }
 
diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index ce7f2355e1..eb6b0c05c4 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -58,6 +58,7 @@ CONFIG_MMC_SDHCI_NPCM=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
diff --git a/include/configs/arbel.h b/include/configs/arbel.h
index 891257bc93..f103f7e452 100644
--- a/include/configs/arbel.h
+++ b/include/configs/arbel.h
@@ -7,10 +7,12 @@
 #define __CONFIG_ARBEL_H
 
 #define CFG_SYS_SDRAM_BASE		0x0
-#define CFG_SYS_BOOTMAPSZ		(30 << 20)
+#define CFG_SYS_BOOTMAPSZ		(128 << 20)
 #define CFG_SYS_BOOTM_LEN		(20 << 20)
 #define CFG_SYS_INIT_RAM_ADDR	CFG_SYS_SDRAM_BASE
 #define CFG_SYS_INIT_RAM_SIZE	0x8000
+#define CFG_SYS_BAUDRATE_TABLE	{ 9600, 14400, 19200, 38400, 57600, 115200, 230400, \
+					  380400, 460800, 921600 }
 
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80400000\0"   \
diff --git a/include/configs/poleg.h b/include/configs/poleg.h
index 1e96e838be..5bea70b8b4 100644
--- a/include/configs/poleg.h
+++ b/include/configs/poleg.h
@@ -12,6 +12,7 @@
 
 #define CFG_SYS_BOOTMAPSZ            (0x30 << 20)
 #define CFG_SYS_SDRAM_BASE           0x0
+#define CFG_SYS_BAUDRATE_TABLE	{ 57600, 115200, 230400, 460800 }
 
 /* Default environemnt variables */
 #define CFG_EXTRA_ENV_SETTINGS   "uimage_flash_addr=80200000\0"   \
-- 
2.25.1

