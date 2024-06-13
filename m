Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C70C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 22:04:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2981688955;
	Fri, 14 Jun 2024 00:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hU7t+wpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AD9588969; Fri, 14 Jun 2024 00:02:21 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FEC78896B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 00:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2e95a75a90eso15803321fa.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 15:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718316137; x=1718920937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7KSKTA1GBk7s0+l+6JuwfUekhm/M9tj6TZ9rqRe87g0=;
 b=hU7t+wpg/o2B88HRXQAJprWXy5PcjURj8Y9ecVLU9TdQxGJTKKtyWOferVi5kpw9yR
 vKOE/JV2bnHG59BOjwoyLebPbhplezeZ3kySUdjj2LzvyJGd2Qf/u7S1RueW1ayF3wyp
 Ip1AXs1Tv+7voPJz1J85aR0DekME8cHMfWmaUXJvoiTBiHJ2WRIi8SFL0eeFzkgQAruZ
 Db7g09arSDM1nvFCnYJSJy25fGumtdVp28QztQW8MDkngXrU/f/oUpWzzoGKeTXVq9kC
 CoKbpFQCOSPgbdOKQQCsFmNrUof5B9MarHZdGJTU7+ggQcoDG67964USW5hP/5ZM2mmm
 BHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718316137; x=1718920937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KSKTA1GBk7s0+l+6JuwfUekhm/M9tj6TZ9rqRe87g0=;
 b=EuCTswW5Sg7L82rsE4wF7LKLFV+cUSKE79We25S5fjIII07wLutbENTG5+8IStUUlO
 3TOZoP9ns6MOuf7zBTIRE4lvQkhyVJf0qGopmCXFskJ/dRLsnaLYjzrEnxxKduZKK1EB
 KKBJVP3LuyByYiwVQC6LZIyg2gSFYH6rQF3hUIv0vE+LRaiKcfCWusS1bUPQACuFPlkd
 BABbqamUUr79QXoSvYKSC3RtFPfLKkb6tQiOk3/xgUcOrJ8hwxkLZIQYqykdEM4T+mWv
 shOQ5+aXM7lLwvn4EHFusVh55XdX9Inj/JuQpTAJrqTnDgWi6tIasfzI2XGl0P4TE7fd
 Qkyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0c+NCREtf+RBZJDl9zX2AiYhNNbQc3mcXIDYPU7Sq13XhmBzd75l7mIaMGB6Vg17xOVwlCmSkQRXmvB2zZT5wvXxZ3w==
X-Gm-Message-State: AOJu0YwX9/ZIMmQKjdxooj/WTVL1uSPSWUPYUxyKznWE4I0g+8LR3Kfs
 ofuQ43jPuU/KXBM/V6FbboqoxvCeykQi4ZHC4Qt4DkiEjDFSyERw
X-Google-Smtp-Source: AGHT+IEsggA0kF0tbaKaRwazxk36lzbq25Gv9zJadjbhsHSzp809mNsUdgLOUxc3K6tD7QCzFhKk3Q==
X-Received: by 2002:a2e:a307:0:b0:2eb:d86e:dbb8 with SMTP id
 38308e7fff4ca-2ec0e60cf8fmr6161521fa.51.1718316137362; 
 Thu, 13 Jun 2024 15:02:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:c633:5ca4:b5e1:26ba])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdffcsm1412473a12.6.2024.06.13.15.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 15:02:16 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 1/2] drivers: bootcount: Add support for ANY filesystem
Date: Fri, 14 Jun 2024 00:02:11 +0200
Message-Id: <20240613220212.37078-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613220212.37078-1-vassilisamir@gmail.com>
References: <20240613220212.37078-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Jun 2024 00:04:20 +0200
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

Add support to save boot count variable in ANY filesystem. Tested with
FAT and EXT.

Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Philip Oberfichtner <pro@denx.de>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 doc/README.bootcount                          | 12 +++----
 drivers/bootcount/Kconfig                     | 36 +++++++++----------
 drivers/bootcount/Makefile                    |  2 +-
 .../{bootcount_ext.c => bootcount_fs.c}       | 12 +++----
 4 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)

diff --git a/doc/README.bootcount b/doc/README.bootcount
index f6c5f82f98..0f4ffb6828 100644
--- a/doc/README.bootcount
+++ b/doc/README.bootcount
@@ -23,15 +23,15 @@ It is the responsibility of some application code (typically a Linux
 application) to reset the variable "bootcount" to 0 when the system booted
 successfully, thus allowing for more boot cycles.
 
-CONFIG_BOOTCOUNT_EXT
+CONFIG_BOOTCOUNT_FS
 --------------------
 
-This adds support for maintaining boot count in a file on an EXT filesystem.
-The file to use is defined by:
+This adds support for maintaining boot count in a file on a filesystem.
+Supported filesystems are FAT and EXT. The file to use is defined by:
 
-CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE
-CONFIG_SYS_BOOTCOUNT_EXT_DEVPART
-CONFIG_SYS_BOOTCOUNT_EXT_NAME
+CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
+CONFIG_SYS_BOOTCOUNT_FS_DEVPART
+CONFIG_SYS_BOOTCOUNT_FS_NAME
 
 The format of the file is:
 
diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 3c56253b1e..fbf3c56b41 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -25,13 +25,13 @@ config BOOTCOUNT_GENERIC
 	    Set to the address where the bootcount and bootcount magic
 	    will be stored.
 
-config BOOTCOUNT_EXT
-	bool "Boot counter on EXT filesystem"
-	depends on FS_EXT4
-	select EXT4_WRITE
+config BOOTCOUNT_FS
+	bool "Boot counter on a filesystem"
 	help
-	  Add support for maintaining boot count in a file on an EXT
-	  filesystem.
+	  Add support for maintaining boot count in a file on a filesystem.
+	  This requires that you have enabled write support for the filesystem
+	  that you will be used by the partition that you configure this feature
+	  for.
 
 config BOOTCOUNT_AM33XX
 	bool "Boot counter in AM33XX RTC IP block"
@@ -184,26 +184,26 @@ config SYS_BOOTCOUNT_SINGLEWORD
 	  This option enables packing boot count magic value and boot count
 	  into single word (32 bits).
 
-config SYS_BOOTCOUNT_EXT_INTERFACE
-	string "Interface on which to find boot counter EXT filesystem"
+config SYS_BOOTCOUNT_FS_INTERFACE
+	string "Interface on which to find boot counter filesystem"
 	default "mmc"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the interface to use when locating the filesystem to use for the
 	  boot counter.
 
-config SYS_BOOTCOUNT_EXT_DEVPART
-	string "Partition of the boot counter EXT filesystem"
+config SYS_BOOTCOUNT_FS_DEVPART
+	string "Partition of the boot counter filesystem"
 	default "0:1"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the partition to use when locating the filesystem to use for the
 	  boot counter.
 
-config SYS_BOOTCOUNT_EXT_NAME
-	string "Path and filename of the EXT filesystem based boot counter"
+config SYS_BOOTCOUNT_FS_NAME
+	string "Path and filename of the FS filesystem based boot counter"
 	default "/boot/failures"
-	depends on BOOTCOUNT_EXT
+	depends on BOOTCOUNT_FS
 	help
 	  Set the filename and path of the file used to store the boot counter.
 
@@ -211,18 +211,18 @@ config SYS_BOOTCOUNT_ADDR
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
index e7771f5b36..245f879633 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
 obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
 obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
-obj-$(CONFIG_BOOTCOUNT_EXT)	+= bootcount_ext.o
+obj-$(CONFIG_BOOTCOUNT_FS)	+= bootcount_fs.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX_NVMEM)	+= bootcount_nvmem.o
 
 obj-$(CONFIG_DM_BOOTCOUNT)      += bootcount-uclass.o
diff --git a/drivers/bootcount/bootcount_ext.c b/drivers/bootcount/bootcount_fs.c
similarity index 81%
rename from drivers/bootcount/bootcount_ext.c
rename to drivers/bootcount/bootcount_fs.c
index 9639e638e9..569592d8aa 100644
--- a/drivers/bootcount/bootcount_ext.c
+++ b/drivers/bootcount/bootcount_fs.c
@@ -25,8 +25,8 @@ void bootcount_store(ulong a)
 	loff_t len;
 	int ret;
 
-	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
-			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
+	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
+			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, FS_TYPE_ANY)) {
 		puts("Error selecting device\n");
 		return;
 	}
@@ -42,7 +42,7 @@ void bootcount_store(ulong a)
 	buf->upgrade_available = upgrade_available;
 	unmap_sysmem(buf);
 
-	ret = fs_write(CONFIG_SYS_BOOTCOUNT_EXT_NAME,
+	ret = fs_write(CONFIG_SYS_BOOTCOUNT_FS_NAME,
 		       CONFIG_SYS_BOOTCOUNT_ADDR, 0, sizeof(bootcount_ext_t),
 		       &len);
 	if (ret != 0)
@@ -55,13 +55,13 @@ ulong bootcount_load(void)
 	loff_t len_read;
 	int ret;
 
-	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_EXT_INTERFACE,
-			   CONFIG_SYS_BOOTCOUNT_EXT_DEVPART, FS_TYPE_EXT)) {
+	if (fs_set_blk_dev(CONFIG_SYS_BOOTCOUNT_FS_INTERFACE,
+			   CONFIG_SYS_BOOTCOUNT_FS_DEVPART, FS_TYPE_ANY)) {
 		puts("Error selecting device\n");
 		return 0;
 	}
 
-	ret = fs_read(CONFIG_SYS_BOOTCOUNT_EXT_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
+	ret = fs_read(CONFIG_SYS_BOOTCOUNT_FS_NAME, CONFIG_SYS_BOOTCOUNT_ADDR,
 		      0, sizeof(bootcount_ext_t), &len_read);
 	if (ret != 0 || len_read != sizeof(bootcount_ext_t)) {
 		puts("Error loading bootcount\n");
-- 
2.25.1

