Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C59C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 19:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DAC98837A;
	Wed,  5 Jun 2024 21:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WNWuelGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E861878F7; Wed,  5 Jun 2024 20:10:51 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68088831D
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eabd22d441so1547661fa.2
 for <u-boot@lists.denx.de>; Wed, 05 Jun 2024 11:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717611048; x=1718215848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDr13/9EiFHs47iVezgYVGddrh3mDfcCJrS7GoZqH5k=;
 b=WNWuelGLrw4Yknx+1UFrj1VSYgDkciMGxYKPLHiXWKPSsbv7s3qCO8PKQiQnjJKN1F
 BQom4Wl0f9iEyXuHpVDkaNSWMaBRpbcDRLO7uWyTz7a/H71VDZfD4WfDCyhRFNiJDiuz
 cfcwU8ghN664UvVh+trOx5jrHG35KHac7mtBwia3oY+1IWr1mQiNoIHBaPJO32Cy89TY
 3Uk4TYJDdYuGM1uqOqDZIHwQlXCBNA/eNmIudK++R0viS7YoSKQdTVhbABRkW/NEBP7c
 8LGW+P95qLqzdnKAyEnnCN9vEszlfO5dA+0A7RhNUZ5+RkK2y8JeAvlPeByEuypAyRcQ
 NGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717611048; x=1718215848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rDr13/9EiFHs47iVezgYVGddrh3mDfcCJrS7GoZqH5k=;
 b=TavPHiebMnDPY7vGN69386g8AWCJy7vcW6CdGVkq/ILNVUto+da4VcdKV0ehmza49f
 4bvdCjXQvczKHQE7UJd2zKI9eub4vnkNtb4RmR0wZwqa9gmYCBFUHMHJFhIPvMixrqvE
 XsoPtouXVmw628jn4fjRKqyuCYMmBmWtwPyy+LesHwfGQntDGZs/O6NVV9kz3enwis4f
 AqUELaEZ2MqeCa+P7AAP/SNmOcOyMgD63PvaNjues3F3tv3/1gq/Ds6D27BHDt79D7gs
 0ESRMAnPpjInxPaVVQbei6en9A5B7XhnMedGK8xlAqQ2nk7wI09kV3teIgocNfpB/+3/
 nq/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFwyNaX3hShISslxp3RqOKrKtuhbp0y5834SIkQaj2Q0amlYO0kpGcxyeCpiatRM0YVQu0RlYxxw3tD6VquA2MYQQIcg==
X-Gm-Message-State: AOJu0YxGyMatilEl0X7qnOHYe66bFMejFiQnZF7Xf0pKTJMIEsTddqwM
 0kGMMYnhfBSon+BRibXTTKZGm1Hs1kdYQwXaF0cHv6eJ4eMGT/nR
X-Google-Smtp-Source: AGHT+IGrT2JW2YojRZ33fTlSLxXt6OtoJA3FF8GPkr0EKRF7rwBOopMk9PP6yJIJM1K4ujUQzT9P+w==
X-Received: by 2002:a2e:6d12:0:b0:2ea:904e:481c with SMTP id
 38308e7fff4ca-2eac7a813famr21852111fa.53.1717611047689; 
 Wed, 05 Jun 2024 11:10:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:e157:757d:63e6:8b22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68a2fc6efesm701399766b.161.2024.06.05.11.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 11:10:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [RFC PATCH] drivers: bootcount: Add support for FAT filesystem
Date: Wed,  5 Jun 2024 20:10:41 +0200
Message-Id: <20240605181041.68317-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240605181041.68317-1-vassilisamir@gmail.com>
References: <20240605181041.68317-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Jun 2024 21:37:35 +0200
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Add support to save boot count variable in a file in a FAT filesystem.

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
---
 doc/README.bootcount              | 12 ++++----
 drivers/bootcount/Kconfig         | 49 +++++++++++++++++++++++--------
 drivers/bootcount/Makefile        |  2 +-
 drivers/bootcount/bootcount_ext.c | 18 ++++++++----
 4 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/doc/README.bootcount b/doc/README.bootcount
index f6c5f82f98..cce66d4d70 100644
--- a/doc/README.bootcount
+++ b/doc/README.bootcount
@@ -23,15 +23,17 @@ It is the responsibility of some application code (typically a Linux
 application) to reset the variable "bootcount" to 0 when the system booted
 successfully, thus allowing for more boot cycles.
 
-CONFIG_BOOTCOUNT_EXT
+CONFIG_BOOTCOUNT_FS
 --------------------
 
-This adds support for maintaining boot count in a file on an EXT filesystem.
+This adds support for maintaining boot count in a file on a filesystem.
+Supported filesystems are FAT and EXT.
+
 The file to use is defined by:
 
-CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
-CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
-CONFIG_SYS_BOOTCOUNT_EXT_NAME
+CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
+CONFIG_SYS_BOOTCOUNT_FS_DEVPART
+CONFIG_SYS_BOOTCOUNT_FS_NAME
 
 The format of the file is:
 
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 3c56253b1e..a39a7556bb 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -25,10 +25,9 @@ config BOOTCOUNT_GENERIC
 	    Set to the address where the bootcount and bootcount magic
 	    will be stored.
 
-config BOOTCOUNT_EXT
-	bool "Boot counter on EXT filesystem"
-	depends on FS_EXT4
-	select EXT4_WRITE
+config BOOTCOUNT_FS
+	bool "Boot counter on filesystem"
+	depends on FS_EXT4 || FS_FAT
 	help
 	  Add support for maintaining boot count in a file on an EXT
 	  filesystem.
@@ -177,6 +176,30 @@ config BOOTCOUNT_BOOTLIMIT
 	  counter being cleared.
 	  If set to 0, do not set a boot limit in the environment.
 
+if BOOTCOUNT_FS
+choice
+	prompt "Filesystem type"
+	default BOOTCOUNT_EXT
+
+config BOOTCOUNT_EXT
+	bool "Boot counter on EXT filesystem"
+	depends on FS_EXT4
+	select EXT4_WRITE
+	help
+	  Add support for maintaining boot count in a file on an EXT
+	  filesystem.
+
+config BOOTCOUNT_FAT
+	bool "Boot counter on FAT filesystem"
+	depends on FS_FAT
+	select FAT_WRITE
+	help
+	  Add support for maintaining boot count in a file on a FAT
+	  filesystem.
+
+endchoice
+endif
+
 config SYS_BOOTCOUNT_SINGLEWORD
 	bool "Use single word to pack boot count and magic value"
 	depends on BOOTCOUNT_GENERIC
@@ -184,26 +207,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
 	  This option enables packing boot count magic value and boot count
 	  into single word (32 bits).
 
-config SYS_BOOTCOUNT_EXT_INTERFACE
+config SYS_BOOTCOUNT_FS_INTERFACE
 	string "Interface on which to find boot counter EXT filesystem"
 	default "mmc"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the interface to use when locating the filesystem to use for the
 	  boot counter.
 
-config SYS_BOOTCOUNT_EXT_DEVPART
+config SYS_BOOTCOUNT_FS_DEVPART
 	string "Partition of the boot counter EXT filesystem"
 	default "0:1"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the partition to use when locating the filesystem to use for the
 	  boot counter.
 
-config SYS_BOOTCOUNT_EXT_NAME
+config SYS_BOOTCOUNT_FS_NAME
 	string "Path and filename of the EXT filesystem based boot counter"
 	default "/boot/failures"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the filename and path of the file used to store the boot counter.
 
@@ -211,18 +234,18 @@ config SYS_BOOTCOUNT_ADDR
 	hex "RAM address used for reading and writing the boot counter"
 	default 0x44E3E000 if BOOTCOUNT_AM33XX || BOOTCOUNT_AM33XX_NVMEM
 	default 0xE0115FF8 if ARCH_LS1043A || ARCH_LS1021A
-	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
+	depends on BOOTCOUNT_AM33XX || BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
 		   BOOTCOUNT_AM33XX_NVMEM
 	help
 	  Set the address used for reading and writing the boot counter.
 
 config SYS_BOOTCOUNT_MAGIC
 	hex "Magic value for the boot counter"
-	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
+	default 0xB001C041 if BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
 			      BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
 			      BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT
 	default 0xB0 if BOOTCOUNT_AM33XX_NVMEM
-	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_EXT || \
+	depends on BOOTCOUNT_GENERIC || BOOTCOUNT_FS || \
 		   BOOTCOUNT_AM33XX || BOOTCOUNT_ENV || \
 		   BOOTCOUNT_RAM || BOOTCOUNT_AT91 || DM_BOOTCOUNT || \
 		   BOOTCOUNT_AM33XX_NVMEM
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index e7771f5b36..c0427434d7 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
 obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
 obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
-obj-$(CONFIG_BOOTCOUNT_EXT)	+= bootcount_ext.o
+obj-$(CONFIG_BOOTCOUNT_FS)	+= bootcount_ext.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)	+= bootcount_nvmem.o
 
 obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_ext.c
index 9639e638e9..660bea2db2 100644
--- a/drivers/bootcount/bootcount_ext.c
+++ b/drivers/bootcount/bootcount_ext.c
@@ -19,14 +19,20 @@ typedef struct {
 
 static u8 upgrade_available = 1;
 
+#ifdef BOOTCOUNT_EXT
+static u8 bootcount_fstype = FS_TYPE_EXT;
+#else
+static u8 bootcount_fstype = FS_TYPE_FAT;
+#endif
+
 void bootcount_store(ulong a)
 {
 	bootcount_ext_t *buf;
 	loff_t len;
 	int ret;
 
-	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
-			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
+	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
+			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
 		puts("Error selecting device\n");
 		return;
 	}
@@ -42,7 +48,7 @@ void bootcount_store(ulong a)
 	buf->upgrade_available = upgrade_available;
 	unmap_sysmem(buf);
 
-	ret = fs_write(CONFIG_SYS_BOOTCOUNT_EXT_NAME,
+	ret = fs_write(CONFIG_SYS_BOOTCOUNT_FS_NAME,
 		       CONFIG_SYS_BOOTCOUNT_ADDR, 0, sizeof(bootcount_ext_t),
 		       &len);
 	if (ret != 0)
@@ -55,13 +61,13 @@ ulong bootcount_load(void)
 	loff_t len_read;
 	int ret;
 
-	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
-			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
+	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
+			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, bootcount_fstype)) {
 		puts("Error selecting device\n");
 		return 0;
 	}
 
-	ret = fs_read(CONFIG_SYS_BOOTCOUNT_EXT_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
+	ret = fs_read(CONFIG_SYS_BOOTCOUNT_FS_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
 		      0, sizeof(bootcount_ext_t), &len_read);
 	if (ret != 0 || len_read != sizeof(bootcount_ext_t)) {
 		puts("Error loading bootcount\n");

base-commit: c0ea27bccfb7d2d37fd36806ac2a2f7389099420
-- 
2.34.1

