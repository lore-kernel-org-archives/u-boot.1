Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EBBC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 18:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092A3886AA;
	Mon, 10 Jun 2024 20:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gwTPSLbe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBA08858D; Mon, 10 Jun 2024 20:51:27 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42164885E7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 20:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52c82101407so3482295e87.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718045482; x=1718650282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAZ4GXGHW7DqoBYGylWcnfhhGOH36lJLU7W9VkP5qMw=;
 b=gwTPSLbeGJbr1wWfYlofi8nCPoN2VpCdIX3MPgiAvLcxu+P7mo6ESwQHC59eeJsK6e
 94XMihT9vaYUSS9Voi4jT4oHSykXdByTtnKYMyjfirNK10fswBgEQOJyPZcIbZlxxVDs
 7w1XshiXdbz400hIWoOY80EFbQd51J2YqPX7kRmZZAsCynELfjPbRqOyqNNMmAdPSrlB
 UOOYhpay79nDN7O3BTbKkQP99wbSdJ19CFb0FoJkbndgoauHg4P+FFluDl6npkiiKIY8
 0K3A3huGyaR1hg7DdNA2E4bpxgpnFnBgV2af7NHOGlRhmXdrXQdy/y0y4EBx9id9zyuB
 5e3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718045482; x=1718650282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAZ4GXGHW7DqoBYGylWcnfhhGOH36lJLU7W9VkP5qMw=;
 b=EvN8vjl/0JjLhvTvbAqJ7C2nAkekIFxkunMXmrzr15kXL/vVe6/qCQmLbJLIt79cjA
 j72/GkV7yNH0fv73jjHj5uvsSMbZVcfaHwfLXFNncJSu+m20Na/n2MMpNJKbwVfTki48
 o5KAGoV2Q3R1Q105LD+DowFyK9m/pkjD5OyBzj//6NsNAaF1vJzJ8JsaiaoeSxZ4aX42
 vfxCXBakLlIB0CmlNWEMo4kTEa4PI5ak1CvGf5mWLdW1zI1lntSuVe9/pSqCKvLye+xQ
 IFHYfQ3aUZgASXWfm0D8gh67E/9oCG7MiSOy66sTdpQCzACBLtCv5TogZ2z4p/yAmgc/
 +SPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDb3V9Q2dFPxJ9YqX6StoSip4ypeJiwoudcTCrrrBnVaWShBXq8SsZQVFlmva3BWniSbpRrM5Wa7xRAbORUr8s8uFNNw==
X-Gm-Message-State: AOJu0Yz83v6dHjWet9QkyQVqXu8nfwE9+NZWYXCeb3PKj1lO+CeiSnEO
 qz5dhh65i1RvVCmIOBMRHWlkQ2Gk5CcCwOUesJIorvGtPCZMEBei
X-Google-Smtp-Source: AGHT+IHP+f2jhU7hZkA3yJrfyX7Y+3TP2hz+0crvWYz79N2KjQt2kaQ5O3JjgO6Fws4FNU+xVQL/uw==
X-Received: by 2002:ac2:4571:0:b0:52c:8075:4f3 with SMTP id
 2adb3069b0e04-52c807511d4mr4173575e87.36.1718045482235; 
 Mon, 10 Jun 2024 11:51:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ed15:c026:8826:cce0])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1245ff6esm281964166b.58.2024.06.10.11.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:51:21 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vasileios.amoiridis@cern.ch, quentin.schulz@cherry.de,
 u-boot@lists.denx.de, Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 1/1] drivers: bootcount: Add support for FAT filesystem
Date: Mon, 10 Jun 2024 20:51:16 +0200
Message-Id: <20240610185116.353604-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240610185116.353604-1-vassilisamir@gmail.com>
References: <20240610185116.353604-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Jun 2024 20:54:07 +0200
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

Add support to save boot count variable in a file in a FAT filesystem.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 doc/README.bootcount                          | 12 ++---
 drivers/bootcount/Kconfig                     | 53 +++++++++++++------
 drivers/bootcount/Makefile                    |  2 +-
 .../{bootcount_ext.c => bootcount_fs.c}       | 12 ++---
 4 files changed, 50 insertions(+), 29 deletions(-)
 rename drivers/bootcount/{bootcount_ext.c => bootcount_fs.c} (81%)

diff --git a/doc/README.bootcount b/doc/README.bootcount
index f6c5f82f..0f4ffb68 100644
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
index 3c56253b..d3679eb5 100644
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
+	bool "Boot counter on a filesystem"
+	depends on FS_EXT4 || FS_FAT
 	help
 	  Add support for maintaining boot count in a file on an EXT
 	  filesystem.
@@ -184,26 +183,48 @@ config SYS_BOOTCOUNT_SINGLEWORD
 	  This option enables packing boot count magic value and boot count
 	  into single word (32 bits).
 
-config SYS_BOOTCOUNT_EXT_INTERFACE
-	string "Interface on which to find boot counter EXT filesystem"
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
+	  Add support for maintaing boot counter in a file on EXT filesystem"
+
+config BOOTCOUNT_FAT
+	bool "Boot counter on FAT filesystem"
+	depends on FS_FAT
+	select FAT_WRITE
+	help
+	  Add support for maintaing boot counter in a file on FAT filesystem"
+
+endchoice
+endif
+
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
 
@@ -211,18 +232,18 @@ config SYS_BOOTCOUNT_ADDR
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
index e7771f5b..245f8796 100644
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
index 9639e638..569592d8 100644
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

