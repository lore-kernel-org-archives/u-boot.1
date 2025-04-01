Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2433C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 537DC81E6C;
	Wed,  2 Apr 2025 00:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCxNqMw6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B5B81F0D; Wed,  2 Apr 2025 00:58:36 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA3980584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so32243315e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743548313; x=1744153113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=McPBqlPbWprX1/71E2Kg2CABvmND7TCi1FnfQ7v2w38=;
 b=SCxNqMw60uO6F2sHpXnEWQ3BsASVGOmZPlPNBNtZEPUSox0OyWMuX3QOXP8RDh3PUi
 xEUW4xsjyaeHGhEYJ7UXtihAu5BoLhSkKzAEMwiZYpFsrOPakT+kSdgQnTM6IhAkA5NM
 MIMSBPZ5bb4LC4xIHFySPIQciBL+L4Aqr5Yl5ha8QC0qomcnkKtqZmTyH97jYygw4A/v
 0tX32SEnG84GXjAfwFTwcpyKmvegqiWxT7tIMwjIpdqUyK8engPYe/HCXbm1BRakmEKP
 XhiFVQl0Yys/pNIezLjmBmFdsI1m50w7XtsTVsL884cMV6DfC2OZy0fU5T+C6rDK7fvo
 oJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743548313; x=1744153113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McPBqlPbWprX1/71E2Kg2CABvmND7TCi1FnfQ7v2w38=;
 b=vwX0ZgYgpaW/7sky8+nMRzszJYGTh1lVENN6C6d/z6fAiQzr6a+HuPmmKfc8EjfE9W
 3oZZwFY6kTTPSLx/Js65L1WKmuJXjT47/2IjD+diFKB2vzxgNAmxNfA44rNRuJbB+NTw
 rzgF398Oo1G/Tm2WOCLKm7ibDOyaLrSikE1tDQQ/V4wnIJQedha8pxjJ7HZ7I6ccjHXH
 0+Fxg6koPY+VjS++wI1BpIGOEd11BUUw6BIdWeTQWjZi+6Ki64e4FvYjrUOw/EEfTdNs
 q1HmjMI9vbVfpHJ/DIpT8u/yLDul6xyZeDNo1ryn9obi/Nm3W1ooQ98PJpoMStTyyXIx
 ggUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV67R9S4uRl9aNuxheyue3j+dsTtzGuHMhlmOmUTKyeqgiA5iAIP0U2/gcbG5p4fVB/Ii/FlqM=@lists.denx.de
X-Gm-Message-State: AOJu0YydxV3YkWVhf9zIl4vkl4ZPFeeQHu8ftZHDWk9S8rjtIwC5MNNP
 McGcEEFwn2kK6wOqmSCveaUKNskHB6WUeS7W8jWUI861AI46bqUS
X-Gm-Gg: ASbGncvW7SDfTXROiap+bWVQ6lrGq8SQ6YvZJbnyi3hCkCCbzefR3eiYQ29ZlRWV4hF
 SPxm9CdST0i7yp/Hx423wTybGzjUy13Wx79p23/EjBtb+Nwx0vRYYkgTOkTu3PA6dCBLaLu6ZRY
 RUqzvtV/Sd4aWbkYKpdtGlFa/i2xc2coctMTu3ZQiIKcB3ooGOqjAXOSV9zQrw01gSYL6fmgU+a
 EnVpA7YfahzaVQteX6+EYIDXg9qp8YK9Z7Qt0m4okdd8OZ34IlKfzVPMpbKTa08fNk2LgW08bg1
 MXcqJcqsP1JyAh4w//+ndVn3LOvWIB5ZWyaeeM51F/R/WANCd/ee19n7KSl+oxLZTra/Bw8yNKz
 UzqUXdxIZ4S/KZA==
X-Google-Smtp-Source: AGHT+IEZABvklIRJ+KV8hO3NMnHq5j0yNuNZlNz1doXaIM4SpeYUulzBRgMKAx8WT7T1JTrLqZAuAw==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43db6228049mr114403025e9.12.1743548313475; 
 Tue, 01 Apr 2025 15:58:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662850sm15101408f8f.26.2025.04.01.15.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:58:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] env: Introduce support for SPI NAND flash
Date: Wed,  2 Apr 2025 00:57:57 +0200
Message-ID: <20250401225803.27519-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
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

Introduce support for SPI NAND flash. Currently we only support SPI
flash based on the lagacy sf cmd that assume SPI flash are always NOR.
This is not the case as to SPI controller also NAND can be attached. Add
support for it by adding an env driver that base entirely on the MTD
api.

Introduce a new kconfig ENV_IS_IN_SPI_NAND_FLASH and
CONFIG_SYS_SNAND_ENV_DEV to define the name of the SPI nand as exposed
by mtd list.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 env/Kconfig            |  41 ++++-
 env/Makefile           |   1 +
 env/env.c              |   3 +
 env/snand.c            | 338 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |   1 +
 5 files changed, 380 insertions(+), 4 deletions(-)
 create mode 100644 env/snand.c

diff --git a/env/Kconfig b/env/Kconfig
index 4438f0b392c..484786b5bd8 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
 		     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
 		     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
 		     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
-		     !ENV_IS_IN_UBI
+		     !ENV_IS_IN_UBI && !ENV_IS_IN_SPI_NAND_FLASH
 	select ENV_IS_NOWHERE
 
 config ENV_IS_NOWHERE
@@ -387,6 +387,33 @@ config ENV_IS_IN_SPI_FLASH
 	  during a "saveenv" operation. CONFIG_ENV_OFFSET_REDUND must be
 	  aligned to an erase sector boundary.
 
+config ENV_IS_IN_SPI_NAND_FLASH
+	bool "Environment is in SPI NAND flash"
+	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
+	default y if ARMADA_XP
+	default y if INTEL_BAYTRAIL
+	default y if INTEL_BRASWELL
+	default y if INTEL_BROADWELL
+	default y if NORTHBRIDGE_INTEL_IVYBRIDGE
+	default y if INTEL_QUARK
+	default y if INTEL_QUEENSBAY
+	default y if ARCH_SUNXI
+	default y if ARCH_AIROHA
+	help
+	  Define this if you have a SPI NAND Flash memory device which you
+	  want to use for the environment.
+
+	  - CONFIG_SYS_SNAND_ENV_DEV:
+
+	  Specifies which SPI NAND device the environment is stored in.
+
+	  - CONFIG_ENV_OFFSET:
+	  - CONFIG_ENV_SIZE:
+
+	  These two #defines specify the offset and size of the
+	  environment area within the SPI NAND Flash.
+	  CONFIG_ENV_OFFSET must be aligned to an erase sector boundary.
+
 config ENV_SECT_SIZE_AUTO
 	bool "Use automatically detected sector size"
 	depends on ENV_IS_IN_SPI_FLASH
@@ -562,8 +589,8 @@ config ENV_EXT4_FILE
 config ENV_ADDR
 	hex "Environment address"
 	depends on ENV_IS_IN_FLASH || ENV_IS_IN_NVRAM || ENV_IS_IN_ONENAND || \
-		     ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH
-	default 0x0 if ENV_IS_IN_SPI_FLASH
+		     ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH || ENV_IS_IN_SPI_NAND_FLASH
+	default 0x0 if ENV_IS_IN_SPI_FLASH || ENV_IS_IN_SPI_NAND_FLASH
 	help
 	  Offset from the start of the device (or partition)
 
@@ -577,7 +604,7 @@ config ENV_ADDR_REDUND
 config ENV_OFFSET
 	hex "Environment offset"
 	depends on ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
-		    ENV_IS_IN_SPI_FLASH
+		    ENV_IS_IN_SPI_FLASH || ENV_IS_IN_SPI_NAND_FLASH
 	default 0x3f8000 if ARCH_ROCKCHIP && ENV_IS_IN_MMC
 	default 0x140000 if ARCH_ROCKCHIP && ENV_IS_IN_SPI_FLASH
 	default 0xF0000 if ARCH_SUNXI
@@ -666,6 +693,12 @@ config SYS_RELOC_GD_ENV_ADDR
 	  Relocate the early env_addr pointer so we know it is not inside
 	  the binary. Some systems need this and for the rest, it doesn't hurt.
 
+config SYS_SNAND_ENV_DEV
+	string "spi nand device name"
+	depends on ENV_IS_IN_SPI_NAND_FLASH
+	help
+	  SPI NAND device name on the platform where the environment is stored.
+
 config SYS_MMC_ENV_DEV
 	int "mmc device number"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || ENV_IS_IN_EXT4 || \
diff --git a/env/Makefile b/env/Makefile
index a54e924d419..14295a5fd4a 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FAT) += fat.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_EXT4) += ext4.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_NAND_FLASH) += snand.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
diff --git a/env/env.c b/env/env.c
index bcc189e14db..b795cf24625 100644
--- a/env/env.c
+++ b/env/env.c
@@ -58,6 +58,9 @@ static enum env_location env_locations[] = {
 #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	ENVL_SPI_FLASH,
 #endif
+#ifdef CONFIG_ENV_IS_IN_SPI_NAND_FLASH
+	ENVL_SPI_NAND_FLASH,
+#endif
 #ifdef CONFIG_ENV_IS_IN_UBI
 	ENVL_UBI,
 #endif
diff --git a/env/snand.c b/env/snand.c
new file mode 100644
index 00000000000..67388201bd3
--- /dev/null
+++ b/env/snand.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+#include <env_internal.h>
+#include <errno.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <linux/mtd/mtd.h>
+#include <u-boot/crc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static int setup_mtd_device(struct mtd_info **mtd_env)
+{
+	struct mtd_info *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm(CONFIG_SYS_SNAND_ENV_DEV);
+	if (IS_ERR_OR_NULL(mtd)) {
+		env_set_default("get_mtd_device_nm() failed", 0);
+		return mtd ? PTR_ERR(mtd) : -EINVAL;
+	}
+
+	*mtd_env = mtd;
+
+	return 0;
+}
+
+static int env_snand_save(void)
+{
+	char *saved_buf, *write_buf, *tmp;
+	struct erase_info ei = { };
+	struct mtd_info *mtd_env;
+	u32 sect_size, sect_num;
+	size_t ret_len = 0;
+	u32 write_size;
+	env_t env_new;
+	int remaining;
+	u32 offset;
+	int ret;
+
+	ret = setup_mtd_device(&mtd_env);
+	if (ret)
+		return ret;
+
+	sect_size = mtd_env->erasesize;
+
+	/* Is the sector larger than the env (i.e. embedded) */
+	if (sect_size > CONFIG_ENV_SIZE) {
+		saved_buf = malloc(sect_size);
+		if (!saved_buf) {
+			ret = -ENOMEM;
+			goto done;
+		}
+
+		offset = CONFIG_ENV_OFFSET;
+		remaining = sect_size;
+		tmp = saved_buf;
+
+		while (remaining) {
+			/* Skip the block if it is bad */
+			if (!(offset % sect_size) &&
+			    mtd_block_isbad(mtd_env, offset)) {
+				offset += sect_size;
+				continue;
+			}
+
+			ret = mtd_read(mtd_env, offset, mtd_env->writesize,
+				       &ret_len, tmp);
+			if (ret)
+				goto done;
+
+			tmp += ret_len;
+			offset += ret_len;
+			remaining -= ret_len;
+		}
+	}
+
+	ret = env_export(&env_new);
+	if (ret)
+		goto done;
+
+	sect_num = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
+
+	ei.mtd = mtd_env;
+	ei.addr = CONFIG_ENV_OFFSET;
+	ei.len = sect_num * sect_size;
+
+	puts("Erasing SPI NAND flash...");
+	ret = mtd_erase(mtd_env, &ei);
+	if (ret)
+		goto done;
+
+	if (sect_size > CONFIG_ENV_SIZE) {
+		memcpy(saved_buf, &env_new, CONFIG_ENV_SIZE);
+		write_size = sect_size;
+		write_buf = saved_buf;
+	} else {
+		write_size = sect_num * sect_size;
+		write_buf = (char *)&env_new;
+	}
+
+	offset = CONFIG_ENV_OFFSET;
+	remaining = sect_size;
+	tmp = write_buf;
+
+	puts("Writing to SPI NAND flash...");
+	while (remaining) {
+		/* Skip the block if it is bad */
+		if (!(offset % sect_size) &&
+		    mtd_block_isbad(mtd_env, offset)) {
+			offset += sect_size;
+			continue;
+		}
+
+		ret = mtd_write(mtd_env, offset, mtd_env->writesize,
+				&ret_len, tmp);
+		if (ret)
+			goto done;
+
+		offset += mtd_env->writesize;
+		remaining -= ret_len;
+		tmp += ret_len;
+	}
+
+	ret = 0;
+	puts("done\n");
+
+done:
+	if (saved_buf)
+		free(saved_buf);
+
+	return ret;
+}
+
+static int env_snand_load(void)
+{
+	struct mtd_info *mtd_env;
+	char *buf, *tmp;
+	size_t ret_len;
+	int remaining;
+	u32 sect_size;
+	u32 offset;
+	int ret;
+
+	buf = (char *)memalign(ARCH_DMA_MINALIGN, CONFIG_ENV_SIZE);
+	if (!buf) {
+		env_set_default("malloc() failed", 0);
+		return -EIO;
+	}
+
+	ret = setup_mtd_device(&mtd_env);
+	if (ret)
+		goto out;
+
+	sect_size = mtd_env->erasesize;
+
+	offset = CONFIG_ENV_OFFSET;
+	remaining = CONFIG_ENV_SIZE;
+	tmp = buf;
+
+	while (remaining) {
+		/* Skip the block if it is bad */
+		if (!(offset % sect_size) &&
+		    mtd_block_isbad(mtd_env, offset)) {
+			offset += sect_size;
+			continue;
+		}
+
+		ret = mtd_read(mtd_env, offset, mtd_env->writesize,
+			       &ret_len, tmp);
+		if (ret) {
+			env_set_default("mtd_read() failed", 1);
+			goto out;
+		}
+
+		tmp += ret_len;
+		offset += ret_len;
+		remaining -= ret_len;
+	}
+
+	ret = env_import(buf, 1, H_EXTERNAL);
+	if (!ret)
+		gd->env_valid = ENV_VALID;
+
+out:
+	free(buf);
+
+	return ret;
+}
+
+static int env_snand_erase(void)
+{
+	struct mtd_info *mtd_env;
+	u32 sect_size, sect_num;
+	char *saved_buf, *tmp;
+	struct erase_info ei;
+	size_t ret_len;
+	int remaining;
+	u32 offset;
+	int ret;
+
+	ret = setup_mtd_device(&mtd_env);
+	if (ret)
+		return ret;
+
+	sect_size = mtd_env->erasesize;
+
+	/* Is the sector larger than the env (i.e. embedded) */
+	if (sect_size > CONFIG_ENV_SIZE) {
+		saved_buf = malloc(sect_size);
+		if (!saved_buf) {
+			ret = -ENOMEM;
+			goto done;
+		}
+
+		offset = CONFIG_ENV_OFFSET;
+		remaining = sect_size;
+		tmp = saved_buf;
+
+		while (remaining) {
+			/* Skip the block if it is bad */
+			if (!(offset % sect_size) &&
+			    mtd_block_isbad(mtd_env, offset)) {
+				offset += sect_size;
+				continue;
+			}
+
+			ret = mtd_read(mtd_env, offset, mtd_env->writesize,
+				       &ret_len, tmp);
+			if (ret)
+				goto done;
+
+			tmp += ret_len;
+			offset += ret_len;
+			remaining -= ret_len;
+		}
+	}
+
+	sect_num = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
+
+	ei.mtd = mtd_env;
+	ei.addr = CONFIG_ENV_OFFSET;
+	ei.len = sect_num * sect_size;
+
+	ret = mtd_erase(mtd_env, &ei);
+	if (ret)
+		goto done;
+
+	if (sect_size > CONFIG_ENV_SIZE) {
+		memset(saved_buf, 0, CONFIG_ENV_SIZE);
+
+		offset = CONFIG_ENV_OFFSET;
+		remaining = sect_size;
+		tmp = saved_buf;
+
+		while (remaining) {
+			/* Skip the block if it is bad */
+			if (!(offset % sect_size) &&
+			    mtd_block_isbad(mtd_env, offset)) {
+				offset += sect_size;
+				continue;
+			}
+
+			ret = mtd_write(mtd_env, offset, mtd_env->writesize,
+					&ret_len, tmp);
+			if (ret)
+				goto done;
+
+			offset += mtd_env->writesize;
+			remaining -= ret_len;
+			tmp += ret_len;
+		}
+	}
+
+	ret = 0;
+
+done:
+	if (saved_buf)
+		free(saved_buf);
+
+	return ret;
+}
+
+__weak void *env_snand_get_env_addr(void)
+{
+	return (void *)CONFIG_ENV_ADDR;
+}
+
+/*
+ * check if Environment on CONFIG_ENV_ADDR is valid.
+ */
+static int env_snand_init_addr(void)
+{
+	env_t *env_ptr = (env_t *)env_snand_get_env_addr();
+
+	if (!env_ptr)
+		return -ENOENT;
+
+	if (crc32(0, env_ptr->data, ENV_SIZE) == env_ptr->crc) {
+		gd->env_addr = (ulong)&env_ptr->data;
+		gd->env_valid = ENV_VALID;
+	} else {
+		gd->env_valid = ENV_INVALID;
+	}
+
+	return 0;
+}
+
+static int env_snand_init(void)
+{
+	int ret;
+
+	ret = env_snand_init_addr();
+	if (ret != -ENOENT)
+		return ret;
+
+	/*
+	 * return here -ENOENT, so env_init()
+	 * can set the init bit and later if no
+	 * other Environment storage is defined
+	 * can set the default environment
+	 */
+	return -ENOENT;
+}
+
+U_BOOT_ENV_LOCATION(snand) = {
+	.location	= ENVL_SPI_NAND_FLASH,
+	ENV_NAME("SNANDFlash")
+	.load		= env_snand_load,
+	.save		= ENV_SAVE_PTR(env_snand_save),
+	.erase		= ENV_ERASE_PTR(env_snand_erase),
+	.init		= env_snand_init,
+};
diff --git a/include/env_internal.h b/include/env_internal.h
index c1c0727e4d0..eabe480b70c 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -113,6 +113,7 @@ enum env_location {
 	ENVL_ONENAND,
 	ENVL_REMOTE,
 	ENVL_SPI_FLASH,
+	ENVL_SPI_NAND_FLASH,
 	ENVL_UBI,
 	ENVL_NOWHERE,
 
-- 
2.48.1

