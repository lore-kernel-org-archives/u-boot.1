Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CBC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 19:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A585382FB4;
	Mon,  7 Apr 2025 21:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DmDZIwve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0722E8302D; Mon,  7 Apr 2025 21:00:34 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF0782EAA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 21:00:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so4216270f8f.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744052431; x=1744657231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eoB5acisECwWu4RCkQah2eHQhCK1R2jdCkB+4DF+VcI=;
 b=DmDZIwveBT6atkJKQCATUm12nv3XcnEHeToRSS2N0DMom2g5I7pD9kB/PQItR0MiQf
 zWDgA06K6K953xu+z//U5FkMABp94uTHBxSHahAy+sPSau9JlsaNoZkVA5XuSO3WnRB/
 3IdXP1NWRrmJZdfFHH9sr/kFThk+JWGuxFwSziuaptvHlWLxVuuXdre7BHZwlSwZ1nvL
 NiO2zMlJ3YOJNRXAFFCyKVmIYZXLk0ipd69k/n36eaq0LkRW591HTPI6FsfroWrkWDiE
 ihjI92eJBjXLMSEeKEn8Il6WXWsla6xaxnU9KOU6oznjaDPOaJcZd6eSTXn4KXfLeMQL
 kG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744052431; x=1744657231;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eoB5acisECwWu4RCkQah2eHQhCK1R2jdCkB+4DF+VcI=;
 b=quBYbpEYTLm9Mal1zsAWIZVlGTQeRHoM9VS/fSqWXhXg3tVFOEw4/0vJCOCRWSrGQM
 9yZsuAmnr7/h1YauDMU1BM3opi/zoA+WUIi96zuatn4DvPXWgJhRwa6mdTPdqIA4EcL6
 jelqzckP80eLSqE+hBte9Z4WXX/2/BAuLc/6MdFRDs1FKspRwkln+M/ju0GZnJxApoSd
 ZzjCZGev7Gqndkg72sRdVoIfcl3IPFn5scHiEidTE2FoxCgh8Vf3x+q495vmvZxl9iRN
 A4kJ+uNTcOH3ewCfJmUGAyigVd5FAW/3BZbqld0uegjkmv1aWW2Uw9nR1myzrNXDvOt5
 8Mqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPQLiV/37rBP1MwC0pwPUvW0i1fZpIyRX9EfNGSi1nYVf5ca1Ftxd7X7K28r2HXPw4Sr+Bf9w=@lists.denx.de
X-Gm-Message-State: AOJu0YxO7P5jC9vPbD315gX/NoUd06p2fZ0sIjn+vtoy9UPZhH4bhf6t
 ZR0wIqZ4OAUKWmGa32vxOcAlQL7JBECCWldf8TrZxp8hV7MF+j2U
X-Gm-Gg: ASbGncvbWTpvM9Vtq49lkBvD+A5Mv48W0mnivOcIPFi3VbLHZ3HwdCvhsMfHAs1RxCf
 wac4QqAanCzFei7V8qasKrGRe6Drytwt3x3sWjpRugdJ5EyRZ90eLj6jJ9mHk3eoOguc56UHQv9
 HHrs3IaPkqSHgPftcKqeli5wzAySnu+V1W+ynaimpiBNqN+/WFMDizaktLzce3ksGNhCc5dQFMU
 gDn4g2N2KEA76kDQrpQbMqrGYBUe4ZJUU33cWQmRzi3t3fgNfoEeT2EzzZRg34wxvYd3Ps0EKN9
 JisgZN/eq98hH1Mj9kAQuDAgwvzP50KHg2qipHFiCXMbR7F3rEd3RdgdHIS2aKSAEWgzZeAH8tY
 CJtqx+BgYGF8Qhw==
X-Google-Smtp-Source: AGHT+IF0FT1zm7z9L2vRfAwAcispjKbIKXUC35u2rL6KKcSpNPNha/d4xH7OyXoMZs6HIz9PaHQGRQ==
X-Received: by 2002:a05:6000:2285:b0:39c:dfa:c92a with SMTP id
 ffacd0b85a97d-39d6fd1924cmr8017688f8f.36.1744052430701; 
 Mon, 07 Apr 2025 12:00:30 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39d7c6d838bsm2736553f8f.69.2025.04.07.12.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 12:00:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] env: Introduce support for MTD
Date: Mon,  7 Apr 2025 20:59:51 +0200
Message-ID: <20250407185958.15479-1-ansuelsmth@gmail.com>
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

Introduce support for env in generic MTD. Currently we only support SPI
flash based on the lagacy sf cmd that assume SPI flash are always NOR.
This is not the case as to SPI controller also NAND can be attached.

To support also these flash scenario, add support for storing and
reading ENV from generic MTD device by adding an env driver that
base entirely on the MTD api.

Introduce a new kconfig CONFIG_ENV_IS_IN_MTD and
CONFIG_ENV_MTD_DEV to define the name of the MTD device as exposed
by mtd list.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 env/Kconfig            |  33 +++-
 env/Makefile           |   1 +
 env/env.c              |   3 +
 env/mtd.c              | 338 +++++++++++++++++++++++++++++++++++++++++
 include/env_internal.h |   1 +
 5 files changed, 372 insertions(+), 4 deletions(-)
 create mode 100644 env/mtd.c

diff --git a/env/Kconfig b/env/Kconfig
index 4438f0b392c..74678c43334 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -74,7 +74,7 @@ config ENV_IS_DEFAULT
 		     !ENV_IS_IN_MMC && !ENV_IS_IN_NAND && \
 		     !ENV_IS_IN_NVRAM && !ENV_IS_IN_ONENAND && \
 		     !ENV_IS_IN_REMOTE && !ENV_IS_IN_SPI_FLASH && \
-		     !ENV_IS_IN_UBI
+		     !ENV_IS_IN_UBI && !ENV_IS_IN_MTD
 	select ENV_IS_NOWHERE
 
 config ENV_IS_NOWHERE
@@ -387,6 +387,25 @@ config ENV_IS_IN_SPI_FLASH
 	  during a "saveenv" operation. CONFIG_ENV_OFFSET_REDUND must be
 	  aligned to an erase sector boundary.
 
+config ENV_IS_IN_MTD
+	bool "Environment is in MTD flash"
+	depends on !CHAIN_OF_TRUST && (SPI_FLASH || DM_SPI_FLASH)
+	default y if ARCH_AIROHA
+	help
+	  Define this if you have a MTD Flash memory device which you
+	  want to use for the environment.
+
+	  - CONFIG_ENV_MTD_DEV:
+
+	  Specifies which SPI NAND device the environment is stored in.
+
+	  - CONFIG_ENV_OFFSET:
+	  - CONFIG_ENV_SIZE:
+
+	  These two #defines specify the offset and size of the
+	  environment area within the MTD Flash.
+	  CONFIG_ENV_OFFSET must be aligned to an erase sector boundary.
+
 config ENV_SECT_SIZE_AUTO
 	bool "Use automatically detected sector size"
 	depends on ENV_IS_IN_SPI_FLASH
@@ -562,8 +581,8 @@ config ENV_EXT4_FILE
 config ENV_ADDR
 	hex "Environment address"
 	depends on ENV_IS_IN_FLASH || ENV_IS_IN_NVRAM || ENV_IS_IN_ONENAND || \
-		     ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH
-	default 0x0 if ENV_IS_IN_SPI_FLASH
+		     ENV_IS_IN_REMOTE || ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
+	default 0x0 if ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
 	help
 	  Offset from the start of the device (or partition)
 
@@ -577,7 +596,7 @@ config ENV_ADDR_REDUND
 config ENV_OFFSET
 	hex "Environment offset"
 	depends on ENV_IS_IN_EEPROM || ENV_IS_IN_MMC || ENV_IS_IN_NAND || \
-		    ENV_IS_IN_SPI_FLASH
+		    ENV_IS_IN_SPI_FLASH || ENV_IS_IN_MTD
 	default 0x3f8000 if ARCH_ROCKCHIP && ENV_IS_IN_MMC
 	default 0x140000 if ARCH_ROCKCHIP && ENV_IS_IN_SPI_FLASH
 	default 0xF0000 if ARCH_SUNXI
@@ -666,6 +685,12 @@ config SYS_RELOC_GD_ENV_ADDR
 	  Relocate the early env_addr pointer so we know it is not inside
 	  the binary. Some systems need this and for the rest, it doesn't hurt.
 
+config ENV_MTD_DEV
+	string "mtd device name"
+	depends on ENV_IS_IN_MTD
+	help
+	  MTD device name on the platform where the environment is stored.
+
 config SYS_MMC_ENV_DEV
 	int "mmc device number"
 	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || ENV_IS_IN_EXT4 || \
diff --git a/env/Makefile b/env/Makefile
index a54e924d419..3b9c71d5681 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FAT) += fat.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_EXT4) += ext4.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_NAND) += nand.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_SPI_FLASH) += sf.o
+obj-$(CONFIG_$(PHASE_)ENV_IS_IN_MTD) += mtd.o
 obj-$(CONFIG_$(PHASE_)ENV_IS_IN_FLASH) += flash.o
 
 CFLAGS_embedded.o := -Wa,--no-warn -DENV_CRC=$(shell tools/envcrc 2>/dev/null)
diff --git a/env/env.c b/env/env.c
index bcc189e14db..dbaeedc3c3b 100644
--- a/env/env.c
+++ b/env/env.c
@@ -58,6 +58,9 @@ static enum env_location env_locations[] = {
 #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	ENVL_SPI_FLASH,
 #endif
+#ifdef CONFIG_ENV_IS_IN_MTD
+	ENVL_MTD,
+#endif
 #ifdef CONFIG_ENV_IS_IN_UBI
 	ENVL_UBI,
 #endif
diff --git a/env/mtd.c b/env/mtd.c
new file mode 100644
index 00000000000..721faebd8f2
--- /dev/null
+++ b/env/mtd.c
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
+	mtd = get_mtd_device_nm(CONFIG_ENV_MTD_DEV);
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
+static int env_mtd_save(void)
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
+	puts("Erasing MTD...");
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
+	puts("Writing to MTD...");
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
+static int env_mtd_load(void)
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
+		env_set_default("memalign() failed", 0);
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
+static int env_mtd_erase(void)
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
+__weak void *env_mtd_get_env_addr(void)
+{
+	return (void *)CONFIG_ENV_ADDR;
+}
+
+/*
+ * Check if Environment on CONFIG_ENV_ADDR is valid.
+ */
+static int env_mtd_init_addr(void)
+{
+	env_t *env_ptr = (env_t *)env_mtd_get_env_addr();
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
+static int env_mtd_init(void)
+{
+	int ret;
+
+	ret = env_mtd_init_addr();
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
+U_BOOT_ENV_LOCATION(mtd) = {
+	.location	= ENVL_MTD,
+	ENV_NAME("MTD")
+	.load		= env_mtd_load,
+	.save		= ENV_SAVE_PTR(env_mtd_save),
+	.erase		= ENV_ERASE_PTR(env_mtd_erase),
+	.init		= env_mtd_init,
+};
diff --git a/include/env_internal.h b/include/env_internal.h
index c1c0727e4d0..ee939ba4293 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -113,6 +113,7 @@ enum env_location {
 	ENVL_ONENAND,
 	ENVL_REMOTE,
 	ENVL_SPI_FLASH,
+	ENVL_MTD,
 	ENVL_UBI,
 	ENVL_NOWHERE,
 
-- 
2.48.1

