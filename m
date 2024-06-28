Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B44C2BD09
	for <u-boot@archiver.kernel.org>; Sat, 29 Jun 2024 01:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5829B885BF;
	Sat, 29 Jun 2024 03:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lTTxkNWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9126D885A8; Fri, 28 Jun 2024 19:35:51 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AEA88570
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 19:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7241b2fe79so99482566b.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719596147; x=1720200947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6+DDq5TOd3SFmSfA7iMyjEZ/u01+t14H7M8U0wGnKA=;
 b=lTTxkNWNlR2iayjgHplJsR/6Dwmp1wU/BDjlxfO2jEacnhl09zfz4Qa8KpbYw6IXZp
 yMNEkG8q6SfPKu+HYTmL7FyV5YdEGLcOeCd6cYsNRgKXd1/ILaK3UVsixP8YzoBrPe5f
 VWrLiUigWo5ic/N/cTvOCiYtKcbtut1tCiWTvV/Z+LWE6Y+0b2pQcnUCEQEmc/1FM99v
 U+QRHBUPFl4REJ06y2MbKEtQ8ulliWOoIURq2eUFbFgDHKfQu6w8wd1RCPFUEl17iK5a
 Uzj77Ojq1aomyw5zH0Ut996WaBzcnH3yn/2R3iT7tg/ha74yFRm7dequ+LS6QDVd+BUA
 vj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719596147; x=1720200947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6+DDq5TOd3SFmSfA7iMyjEZ/u01+t14H7M8U0wGnKA=;
 b=qrJw54mfZm9KVqxn/W/xncEnhzdQ43QIWJ1f/uBcBNKda2IdMQmUKv+bAjrglHIIqb
 B19qIviwZSgg2kXww+EoHGOvDNDxCkwzT5Vx70TCiQclC3N6c5/9ZaETsAcWcPAGELSY
 kD8jkj472hkXH+UbzLROtlu/UQcLM4ydHEEzJoDw3T1K0SzuT4LRHgJJukIUnXJ08D+5
 H9+cUjmDB9XXPIA/PCpo+aFB8g6cqAS/Uq9HWkKYOHPf83GiB+6vc4gMi5tLFpW5LcB2
 HhFqNvz+jQjSG9qaaeyDMmP5i1FfquMfnPxLOs67cJ+SgauVRBeYaEjn0NL7nr0aWfwG
 Qlmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9BTJ0tB0MB+/Rj69nbDaP/8KQiP1VyOY962l2DP38evlIZoIvfvZuftGr5z+AnZf2RXVv8TJagKe8VD2g6hECgw98WQ==
X-Gm-Message-State: AOJu0YzzEs3BMC9/WJkBLlzSM+8MdpipZicantZNIap/Lh6TZIdXBsNM
 kBwd5v4I2ugxJqgE8wdF9qquFYxTChG8ntoP+MCcGCl40rWC+EK7
X-Google-Smtp-Source: AGHT+IHCDnKm9PibO0rhkfQQjcCXGFgQaLXayYpT4f/voc3cengG0amfCk17G1kTRDvxL6rMk9smNg==
X-Received: by 2002:a17:907:160f:b0:a72:8a75:6559 with SMTP id
 a640c23a62f3a-a728a7566afmr779480766b.47.1719596147207; 
 Fri, 28 Jun 2024 10:35:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aafb9e4csm96214666b.95.2024.06.28.10.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:35:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com,
	hs@denx.de,
	pro@denx.de
Cc: vassilisamir@gmail.com, quentin.schulz@cherry.de, u-boot@lists.denx.de,
 Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
Subject: [PATCH v4 1/3] drivers: bootcount: Add support for ANY filesystem
Date: Fri, 28 Jun 2024 19:35:41 +0200
Message-Id: <20240628173543.129207-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628173543.129207-1-vassilisamir@gmail.com>
References: <20240628173543.129207-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 29 Jun 2024 03:11:20 +0200
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
Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
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

