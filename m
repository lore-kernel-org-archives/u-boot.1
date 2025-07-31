Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A134C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ADC8395B;
	Thu, 31 Jul 2025 23:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="ijtAbipY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E20A583857; Thu, 31 Jul 2025 20:15:56 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C8083900
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 20:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b78d729bb8so24342f8f.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1753985754; x=1754590554; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MSnNoTi2fTws3wgOUhvZ6vtr0v4rugOmaln/CynCSbQ=;
 b=ijtAbipYe7kWluTxrd0aomZjwQc7KrfPKdCG+N0AtwJlqh+Lm1ag9ZJq3GZlxLDMj0
 reE+Jsm74XnSi6P/ySvxeKgpUehucgf5InNMqAJHT1f/5PusfMdAmN5/wlMdN+vu79tG
 5KcbBwuYY+a2KHtGKlbpO+taDh0qk8LkC+kDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753985754; x=1754590554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSnNoTi2fTws3wgOUhvZ6vtr0v4rugOmaln/CynCSbQ=;
 b=iwKwAjVOhTv6wbDTrh+rQZ/XjBxNrJ4sNQ42QGGHVNey9Itu/sZIWH+QtoKpQjnXrQ
 FVUqjpdlDtgHjiT+7B381ibjoU0mMBLkLFk+hCP0UbeQbBJNzWTRLs/d3odp3GwRF07h
 TN+GqJsPYEGmfZpUwNI6EKe4xlrD+A/XPQi6eJ8JwVSJ918WVxHGBLi3vBUKeleLro17
 oJPlvqI4cVDFgRbGTr9N1O9+lvpVQcRE/Zo5cO7R7s7RLgXou1kCjHSoY+vUBPge2tiO
 bf0E310uE7GR2RhiaU2GtiOsg6aXjbqXKWE0jE4b+NU0TzdtIk7M3Es0pFt6LqWF5KvH
 WwFw==
X-Gm-Message-State: AOJu0Ywr9aGt2vRF1jNsSsXhMdDVfaigRy+8AYUEB9TLFdy4ci/xgeZn
 hpEMavtDqcSRtd95WhMmH2Osjibn8+8qTrCwKvnXwEbNS6tRNhe4ya+jl10HU40e4JDH7VPCfjJ
 rTZe+70lSMQ==
X-Gm-Gg: ASbGnctxsJYhx4LjyDGbPlPTOfZ7sCPj8kQYL/js9PKFamHsLth8wVZtAxMZugJpm7b
 UQH8x0b9a9bruqxtPBld3PLAwQXUIpT54Rsed108FZu0Ez4zmAAIMzWcx2L/DEITBl2VZuiM930
 E76XIjuJLEuLKQZAyUbY0SC0FLrSBqCMAD+jMgM3xTtCAEqb5NJUQ8sh8qp+ccbvItTUrGMsRWG
 W4Hj3RDDuPAH7Abkeg4bBk/RT69tYdwEE+mJ23srLYCNmEuhIEC0IywFqsjt4bGJ21zDFvN+9K6
 5H81DruBJQZkyOlplcaBQA//9t9SynEBNQkqxU5a9AfNZtPjqfJsfJcZAO3DfGXeMFkH/wMkMQS
 OBHBhYMuHYjsAcOU1Rpc+arB1Ho2/iOmsKAOaJNqaI1AgSKzWuW4ZFTOjMhqkUTggn3KXEw==
X-Google-Smtp-Source: AGHT+IGGWo6+FYsTQ3haTM0NYY+kpB2kfuHW2wChMNPLa0w75mUfdmseRCAYZ+KaO7MkkE8GGJUvwQ==
X-Received: by 2002:a05:6000:2008:b0:3b7:9350:d372 with SMTP id
 ffacd0b85a97d-3b794fde45dmr6845117f8f.24.1753985754270; 
 Thu, 31 Jul 2025 11:15:54 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abedesm3236129f8f.3.2025.07.31.11.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 11:15:53 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 1/2] spl: Add A/B sector mode for mmc raw mode
Date: Thu, 31 Jul 2025 18:15:32 +0000
Message-ID: <20250731181533.1872390-2-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731181533.1872390-1-andri@yngvason.is>
References: <20250731181533.1872390-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

This makes it possible to select between 2 raw sectors from which
to boot U-Boot Proper by writing to one pre-defined sector.

If the first byte of the sector contains the value 1, SPL will load
U-Boot Proper. The second byte, if set to 1 or 2, instructs SPL to try
loading only once from A or B, respectively.

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 common/spl/Kconfig   | 28 +++++++++++++++++--
 common/spl/spl_mmc.c | 66 ++++++++++++++++++++++++++++++++++++++++++--
 include/spl.h        |  1 +
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index ab05536bd02..706f7db1225 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -565,6 +565,14 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 	  Use sector number for specifying U-Boot location on MMC/SD in
 	  raw mode.
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
+	bool "MMC raw mode: by sector with A/B selection"
+	select SPL_LOAD_BLOCK
+	select SPL_MMC_WRITE
+	help
+	  Use sector numbers for specifying U-Boot location on MMC/SD in
+	  raw mode. Allows selecting between two sectors.
+
 config SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 	bool "MMC raw mode: by partition"
 	select SPL_LOAD_BLOCK
@@ -583,7 +591,8 @@ endchoice
 
 config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	hex "Address on the MMC to load U-Boot from"
-	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR || \
+		   SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
 	default 0x40 if ARCH_SUNXI
 	default 0x75 if ARCH_DAVINCI
 	default 0x8a if ARCH_MX6 || ARCH_MX7
@@ -598,9 +607,24 @@ config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR
 	  Address on the MMC to load U-Boot from, when the MMC is being used
 	  in raw mode. Units: MMC sectors (1 sector = 512 bytes).
 
+config SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_B
+	hex "Secondary address on the MMC to load U-Boot from"
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
+	help
+	  Address on the MMC to load secondary U-Boot from, when the MMC is
+	  being used in raw mode. Units: MMC sectors (1 sector = 512 bytes).
+
+config SYS_MMCSD_RAW_MODE_U_BOOT_AB_CONTROL_SECTOR
+	hex "Raw MMC A/B boot control sector"
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
+	help
+	  Location of A/B bool control sector on the MMC. The contents of this
+	  sector control from which sector U-Boot is loaded.
+
 config SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
 	hex "U-Boot main hardware partition image offset"
-	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR || \
+		   SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
 	default 0x10 if ARCH_SUNXI
 	default 0x0
 	help
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d06f9f0dee6..f4a1a3425b5 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -29,7 +29,8 @@ static ulong h_spl_load_read(struct spl_load_info *load, ulong off,
 
 static __maybe_unused unsigned long spl_mmc_raw_uboot_offset(int part)
 {
-#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR)
+#if IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+	IS_ENABLED(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB)
 	if (part == 0)
 		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET;
 #endif
@@ -137,7 +138,8 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 		return ret;
 	}
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB)
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
 #else
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
@@ -270,6 +272,8 @@ u32 __weak spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	return MMCSD_MODE_FS;
 #elif defined(CONFIG_SUPPORT_EMMC_BOOT)
 	return MMCSD_MODE_EMMCBOOT;
+#elif defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB)
+	return MMCSD_MODE_RAW_AB;
 #else
 	return MMCSD_MODE_RAW;
 #endif
@@ -323,6 +327,53 @@ int __weak spl_mmc_emmc_boot_partition(struct mmc *mmc)
 	return default_spl_mmc_emmc_boot_partition(mmc);
 }
 
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
+unsigned long spl_mmc_get_raw_ab_sector(struct mmc *mmc, unsigned long raw_sect)
+{
+	u8 buf[512];
+	int ret = blk_dread(mmc_get_blk_desc(mmc),
+			CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_AB_CONTROL_SECTOR,
+			1, buf);
+	if (ret < 0) {
+		puts("Failed to read mmc a/b control sector\n");
+		log_debug("(error=%d)\n", ret);
+		goto out;
+	}
+
+	switch (buf[1]) {
+	case 1:
+		raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
+		puts("Trying to boot from mmc raw sector A\n");
+		break;
+	case 2:
+		raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_B;
+		puts("Trying to boot from mmc raw sector B\n");
+		break;
+	default:
+		if (buf[0] != 1) {
+			raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR;
+			puts("Selected mmc raw sector A\n");
+		} else {
+			raw_sect = CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR_B;
+			puts("Selected mmc raw sector B\n");
+		}
+		return raw_sect;
+	}
+
+	buf[1] = 0xff;
+	ret = blk_dwrite(mmc_get_blk_desc(mmc),
+			 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_AB_CONTROL_SECTOR,
+			 1, buf);
+	if (ret < 0) {
+		puts("Failed to update mmc a/b control sector\n");
+		log_debug("(error=%d)\n", ret);
+	}
+
+out:
+	return raw_sect;
+}
+#endif
+
 static int spl_mmc_get_mmc_devnum(struct mmc *mmc)
 {
 	struct blk_desc *block_dev;
@@ -385,6 +436,14 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 			return ret;
 		}
 		/* Fall through */
+#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB
+	case MMCSD_MODE_RAW_AB:
+		debug("spl: mmc boot mode: raw a/b\n");
+
+		raw_sect = spl_mmc_get_raw_ab_sector(mmc, raw_sect);
+
+		fallthrough;
+#endif
 	case MMCSD_MODE_RAW:
 		debug("spl: mmc boot mode: raw\n");
 
@@ -403,7 +462,8 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 		if (!ret)
 			return 0;
 #endif
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
+#if defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR) || \
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR_AB)
 		ret = mmc_load_image_raw_sector(spl_image, bootdev, mmc,
 						raw_sect +
 						spl_mmc_raw_uboot_offset(part));
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..7736b00c474 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -28,6 +28,7 @@ struct legacy_img_hdr;
 #define MMCSD_MODE_RAW		1
 #define MMCSD_MODE_FS		2
 #define MMCSD_MODE_EMMCBOOT	3
+#define MMCSD_MODE_RAW_AB	4
 
 struct blk_desc;
 struct legacy_img_hdr;
-- 
2.50.0

