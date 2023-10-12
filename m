Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A020BCDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70FC286EE7;
	Thu, 12 Oct 2023 04:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ENqIda/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA3186E7D; Thu, 12 Oct 2023 04:00:59 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA8686E96
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77574dec71bso30378885a.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075813; x=1697680613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Av4Cfn4oJRSd9R20EPeAZLmHeXkAICjWWTs4XOs1nQ=;
 b=ENqIda/BFBB1kaJCYY+muGwkh+NqYnPzw92Bqm7b9B9DEw+nNj9iJc64vuH7JOuM7o
 PUTu/1v5evKSjEs/MkwRmrOrgMOR0ZQO3suruROKTTfiPuEyLvjejZyQ+BlGUTNGTrGh
 0Z3mKBIwSlIBPXskBhQWbEVJWxXZUHA/X9sgujWZm3DHUjlW9gaWKehauR5lp4iv/khu
 RlJqqzBIPVsoZ/htVgA70oG8n9N3ibotX7tS12qAUtEeKszN7eXIM2sPX3HRmMNKoDjR
 8IxUtHiXdpoUanw+jQ7JzNMKy+G0yfAEyQcw98KYEk9DoRIUlIOHkSOqJHGWS7HPwb+V
 z9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075813; x=1697680613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Av4Cfn4oJRSd9R20EPeAZLmHeXkAICjWWTs4XOs1nQ=;
 b=wNfOARxkoGtnAEnHuF9Qq+ParLchcBSEge8nVQySS7sAd3tIQmMoElNO3l1Orp+llz
 H+p0pcs4qLIXAiRmf67ZIh8aXjajx9as62HhSRY66d21rTPM5S/hoVPvRuaqrJOb2yXB
 kLD0mgdOT1ohl5aePvuzvf0lEBNShpYaSw3adF+GI54nP97rswAZ0B0uPKB7xWRwggBI
 54a3Y2rb9taDLxQHCPj3nHKtZMxEOP09dGBrTqeYrAJbXMJQr5R7BJfNZlNZ5gUx+6/s
 ZaQmyGCeVSIaqJJkN+YtSdhv+PXr07JGK6JIHq0ny+FdmkeDQd8RRGEYjLuAmIti/uxv
 CIFQ==
X-Gm-Message-State: AOJu0YzTZ9am3zUqmvT9NECGhGiCwKAeH3+EOyGjZL+cdma/kgscnwom
 oPojWglMN0Z3K6I/mZ6kDUpQ0xh2ToRX1Q==
X-Google-Smtp-Source: AGHT+IGYaaO9++aA6XO7YWlqAfW02WgMqgE5tA6EDAgs5rDFEVUZitDH2kZhei5wBmDoKYQL2YiwMQ==
X-Received: by 2002:a05:620a:4103:b0:773:f6b6:4085 with SMTP id
 j3-20020a05620a410300b00773f6b64085mr29097584qko.54.1697075813181; 
 Wed, 11 Oct 2023 18:56:53 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 19-20020a05620a06d300b0076f18be9a64sm5661938qky.81.2023.10.11.18.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:52 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 21/26] test: spl: Add functions to create filesystems
Date: Wed, 11 Oct 2023 21:56:21 -0400
Message-Id: <20231012015626.3487451-22-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

Add some functions for creating fat/ext2 filesystems with a single file and
a test for them. Filesystems require block devices, and it is easiest to
just use MMC for this. To get an MMC, we must also pull in the test device
tree.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 arch/sandbox/cpu/start.c         |   9 +-
 configs/sandbox_noinst_defconfig |   7 +
 include/ext4fs.h                 |   1 +
 include/ext_common.h             |  14 ++
 include/test/spl.h               |   3 +
 test/image/Kconfig               |  11 ++
 test/image/Makefile              |   1 +
 test/image/spl_load.c            |   1 +
 test/image/spl_load_fs.c         | 305 +++++++++++++++++++++++++++++++
 9 files changed, 350 insertions(+), 2 deletions(-)
 create mode 100644 test/image/spl_load_fs.c

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 2c8a72590b5..f5728e6e7ee 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -13,6 +13,7 @@
 #include <log.h>
 #include <os.h>
 #include <sort.h>
+#include <spl.h>
 #include <asm/getopt.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -202,10 +203,14 @@ static int sandbox_cmdline_cb_test_fdt(struct sandbox_state *state,
 {
 	char buf[256];
 	char *fname;
+	char *relname;
 	int len;
 
-	len = state_get_rel_filename("arch/sandbox/dts/test.dtb", buf,
-				     sizeof(buf));
+	if (spl_phase() < PHASE_BOARD_F)
+		relname = "../arch/sandbox/dts/test.dtb";
+	else
+		relname = "arch/sandbox/dts/test.dtb";
+	len = state_get_rel_filename(relname, buf, sizeof(buf));
 	if (len < 0)
 		return len;
 
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 908155be8a3..0a542cfb6aa 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -6,10 +6,12 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="sandbox"
 CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL=y
+CONFIG_SPL_FS_FAT=y
 CONFIG_SYS_LOAD_ADDR=0x0
 CONFIG_PCI=y
 CONFIG_SANDBOX_SPL=y
@@ -39,7 +41,9 @@ CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
 CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
+CONFIG_SPL_MMC_WRITE=y
 CONFIG_SPL_RTC=y
 CONFIG_CMD_CPU=y
 CONFIG_CMD_LICENSE=y
@@ -97,6 +101,7 @@ CONFIG_AMIGA_PARTITION=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_OF_PLATDATA=y
+CONFIG_SPL_OF_REAL=y
 CONFIG_ENV_IS_NOWHERE=y
 CONFIG_ENV_IS_IN_EXT4=y
 CONFIG_ENV_EXT4_INTERFACE="host"
@@ -159,6 +164,7 @@ CONFIG_CROS_EC_SPI=y
 CONFIG_P2SB=y
 CONFIG_PWRSEQ=y
 CONFIG_SPL_PWRSEQ=y
+CONFIG_FS_LOADER=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_SPI_FLASH_SANDBOX=y
 CONFIG_SPI_FLASH_ATMEL=y
@@ -220,6 +226,7 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_DM_THERMAL=y
 CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
diff --git a/include/ext4fs.h b/include/ext4fs.h
index cb5d9cc0a5c..dd66d27f776 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -31,6 +31,7 @@
 struct disk_partition;
 
 #define EXT4_INDEX_FL		0x00001000 /* Inode uses hash tree index */
+#define EXT4_TOPDIR_FL		0x00020000 /* Top of directory hierarchies*/
 #define EXT4_EXTENTS_FL		0x00080000 /* Inode uses extents */
 #define EXT4_EXT_MAGIC			0xf30a
 #define EXT4_FEATURE_RO_COMPAT_GDT_CSUM	0x0010
diff --git a/include/ext_common.h b/include/ext_common.h
index 30a0c248414..b09bbde116a 100644
--- a/include/ext_common.h
+++ b/include/ext_common.h
@@ -35,6 +35,16 @@ struct cmd_tbl;
 #define EXT2_PATH_MAX				4096
 /* Maximum nesting of symlinks, used to prevent a loop.  */
 #define	EXT2_MAX_SYMLINKCNT		8
+/* Maximum file name length */
+#define EXT2_NAME_LEN 255
+
+/*
+ * Revision levels
+ */
+#define EXT2_GOOD_OLD_REV	0	/* The good old (original) format */
+#define EXT2_DYNAMIC_REV	1	/* V2 format w/ dynamic inode sizes */
+
+#define EXT2_GOOD_OLD_INODE_SIZE 128
 
 /* Filetype used in directory entry.  */
 #define	FILETYPE_UNKNOWN		0
@@ -48,6 +58,10 @@ struct cmd_tbl;
 #define FILETYPE_INO_DIRECTORY		0040000
 #define FILETYPE_INO_SYMLINK		0120000
 #define EXT2_ROOT_INO			2 /* Root inode */
+#define EXT2_BOOT_LOADER_INO		5 /* Boot loader inode */
+
+/* First non-reserved inode for old ext2 filesystems */
+#define EXT2_GOOD_OLD_FIRST_INO	11
 
 /* The size of an ext2 block in bytes.  */
 #define EXT2_BLOCK_SIZE(data)	   (1 << LOG2_BLOCK_SIZE(data))
diff --git a/include/test/spl.h b/include/test/spl.h
index a2f8d77b88f..7ae32a1020b 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -114,4 +114,7 @@ SPL_TEST(func##_##type, flags)
 /* More than a couple blocks, and will not be aligned to anything */
 #define SPL_TEST_DATA_SIZE	4099
 
+/* Flags necessary for accessing DM devices */
+#define DM_FLAGS (UT_TESTF_DM | UT_TESTF_SCAN_FDT)
+
 #endif /* TEST_SPL_H */
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 70ffe0ff276..963c86cc290 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -10,6 +10,17 @@ config SPL_UT_LOAD
 
 if SPL_UT_LOAD
 
+config SPL_UT_LOAD_FS
+	bool "Unit tests for filesystems"
+	depends on SANDBOX && SPL_OF_REAL
+	depends on FS_LOADER
+	depends on SPL_FS_FAT
+	depends on SPL_FS_EXT4
+	depends on SPL_MMC_WRITE
+	default y
+	help
+	  Test filesystems in SPL.
+
 config SPL_UT_LOAD_OS
 	bool "Test loading from the host OS"
 	depends on SANDBOX && SPL_LOAD_FIT
diff --git a/test/image/Makefile b/test/image/Makefile
index 1f62d54453c..9427e69bd3b 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -3,4 +3,5 @@
 # Copyright 2021 Google LLC
 
 obj-$(CONFIG_SPL_UT_LOAD) += spl_load.o
+obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_OS) += spl_load_os.o
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index ca3777cab37..4338da417ce 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -4,6 +4,7 @@
  */
 
 #include <common.h>
+#include <dm.h>
 #include <image.h>
 #include <imx_container.h>
 #include <mapmem.h>
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
new file mode 100644
index 00000000000..8cd90b73518
--- /dev/null
+++ b/test/image/spl_load_fs.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#include <common.h>
+#include <blk.h>
+#include <ext_common.h>
+#include <ext4fs.h>
+#include <fat.h>
+#include <fs.h>
+#include <memalign.h>
+#include <asm/io.h>
+#include <linux/stat.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+/**
+ * create_ext2() - Create an "ext2" filesystem with a single file
+ * @dst: The location of the new filesystem; MUST be zeroed
+ * @size: The size of the file
+ * @filename: The name of the file
+ * @data_offset: Filled with the offset of the file data from @dst
+ *
+ * Budget mke2fs. We use 1k blocks (to reduce overhead) with a single block
+ * group, which limits us to 8M of data. Almost every feature which increases
+ * complexity (checksums, hash tree directories, etc.) is disabled. We do cheat
+ * a little and use extents from ext4 to save having to deal with indirects, but
+ * U-Boot doesn't care.
+ *
+ * If @dst is %NULL, nothing is copied.
+ *
+ * Return: The size of the filesystem in bytes
+ */
+static size_t create_ext2(void *dst, size_t size, const char *filename,
+			  size_t *data_offset)
+{
+	u32 super_block = 1;
+	u32 group_block = 2;
+	u32 block_bitmap_block = 3;
+	u32 inode_bitmap_block = 4;
+	u32 inode_table_block = 5;
+	u32 root_block = 6;
+	u32 file_block = 7;
+
+	u32 root_ino = EXT2_ROOT_INO;
+	u32 file_ino = EXT2_BOOT_LOADER_INO;
+
+	u32 block_size = EXT2_MIN_BLOCK_SIZE;
+	u32 inode_size = sizeof(struct ext2_inode);
+
+	u32 file_blocks = (size + block_size - 1) / block_size;
+	u32 blocks = file_block + file_blocks;
+	u32 inodes = block_size / inode_size;
+	u32 filename_len = strlen(filename);
+	u32 dirent_len = ALIGN(filename_len, sizeof(struct ext2_dirent)) +
+			    sizeof(struct ext2_dirent);
+
+	struct ext2_sblock *sblock = dst + super_block * block_size;
+	struct ext2_block_group *bg = dst + group_block * block_size;
+	struct ext2_inode *inode_table = dst + inode_table_block * block_size;
+	struct ext2_inode *root_inode = &inode_table[root_ino - 1];
+	struct ext2_inode *file_inode = &inode_table[file_ino - 1];
+	struct ext4_extent_header *ext_block = (void *)&file_inode->b;
+	struct ext4_extent *extent = (void *)(ext_block + 1);
+	struct ext2_dirent *dot = dst + root_block * block_size;
+	struct ext2_dirent *dotdot = dot + 2;
+	struct ext2_dirent *dirent = dotdot + 2;
+	struct ext2_dirent *last = ((void *)dirent) + dirent_len;
+
+	/* Make sure we fit in one block group */
+	if (blocks > block_size * 8)
+		return 0;
+
+	if (filename_len > EXT2_NAME_LEN)
+		return 0;
+
+	if (data_offset)
+		*data_offset = file_block * block_size;
+
+	if (!dst)
+		goto out;
+
+	sblock->total_inodes = cpu_to_le32(inodes);
+	sblock->total_blocks = cpu_to_le32(blocks);
+	sblock->first_data_block = cpu_to_le32(super_block);
+	sblock->blocks_per_group = cpu_to_le32(blocks);
+	sblock->fragments_per_group = cpu_to_le32(blocks);
+	sblock->inodes_per_group = cpu_to_le32(inodes);
+	sblock->magic = cpu_to_le16(EXT2_MAGIC);
+	/* Done mostly so we can pretend to be (in)compatible */
+	sblock->revision_level = cpu_to_le32(EXT2_DYNAMIC_REV);
+	/* Not really accurate but it doesn't matter */
+	sblock->first_inode = cpu_to_le32(EXT2_GOOD_OLD_FIRST_INO);
+	sblock->inode_size = cpu_to_le32(inode_size);
+	sblock->feature_incompat = cpu_to_le32(EXT4_FEATURE_INCOMPAT_EXTENTS);
+
+	bg->block_id = cpu_to_le32(block_bitmap_block);
+	bg->inode_id = cpu_to_le32(inode_bitmap_block);
+	bg->inode_table_id = cpu_to_le32(inode_table_block);
+
+	/*
+	 * All blocks/inodes are in-use. I don't want to have to deal with
+	 * endianness, so just fill everything in.
+	 */
+	memset(dst + block_bitmap_block * block_size, 0xff, block_size * 2);
+
+	root_inode->mode = cpu_to_le16(S_IFDIR | 0755);
+	root_inode->size = cpu_to_le32(block_size);
+	root_inode->nlinks = cpu_to_le16(3);
+	root_inode->blockcnt = cpu_to_le32(1);
+	root_inode->flags = cpu_to_le32(EXT4_TOPDIR_FL);
+	root_inode->b.blocks.dir_blocks[0] = root_block;
+
+	file_inode->mode = cpu_to_le16(S_IFREG | 0644);
+	file_inode->size = cpu_to_le32(size);
+	file_inode->nlinks = cpu_to_le16(1);
+	file_inode->blockcnt = cpu_to_le32(file_blocks);
+	file_inode->flags = cpu_to_le32(EXT4_EXTENTS_FL);
+	ext_block->eh_magic = cpu_to_le16(EXT4_EXT_MAGIC);
+	ext_block->eh_entries = cpu_to_le16(1);
+	ext_block->eh_max = cpu_to_le16(sizeof(file_inode->b) /
+					sizeof(*ext_block) - 1);
+	extent->ee_len = cpu_to_le16(file_blocks);
+	extent->ee_start_lo = cpu_to_le16(file_block);
+
+	/* I'm not sure we need these, but it can't hurt */
+	dot->inode = cpu_to_le32(root_ino);
+	dot->direntlen = cpu_to_le16(2 * sizeof(*dot));
+	dot->namelen = 1;
+	dot->filetype = FILETYPE_DIRECTORY;
+	memcpy(dot + 1, ".", dot->namelen);
+
+	dotdot->inode = cpu_to_le32(root_ino);
+	dotdot->direntlen = cpu_to_le16(2 * sizeof(*dotdot));
+	dotdot->namelen = 2;
+	dotdot->filetype = FILETYPE_DIRECTORY;
+	memcpy(dotdot + 1, "..", dotdot->namelen);
+
+	dirent->inode = cpu_to_le32(file_ino);
+	dirent->direntlen = cpu_to_le16(dirent_len);
+	dirent->namelen = filename_len;
+	dirent->filetype = FILETYPE_REG;
+	memcpy(dirent + 1, filename, filename_len);
+
+	last->direntlen = block_size - dirent_len;
+
+out:
+	return (size_t)blocks * block_size;
+}
+
+/**
+ * create_fat() - Create a FAT32 filesystem with a single file
+ * @dst: The location of the new filesystem; MUST be zeroed
+ * @size: The size of the file
+ * @filename: The name of the file
+ * @data_offset: Filled with the offset of the file data from @dst
+ *
+ * Budget mkfs.fat. We use FAT32 (so I don't have to deal with FAT12) with no
+ * info sector, and a single one-sector FAT. This limits us to 64k of data
+ * (enough for anyone). The filename must fit in 8.3.
+ *
+ * If @dst is %NULL, nothing is copied.
+ *
+ * Return: The size of the filesystem in bytes
+ */
+static size_t create_fat(void *dst, size_t size, const char *filename,
+			 size_t *data_offset)
+{
+	u16 boot_sector = 0;
+	u16 fat_sector = 1;
+	u32 root_sector = 2;
+	u32 file_sector = 3;
+
+	u16 sector_size = 512;
+	u32 file_sectors = (size + sector_size - 1) / sector_size;
+	u32 sectors = file_sector + file_sectors;
+
+	char *ext;
+	size_t filename_len, ext_len;
+	int i;
+
+	struct boot_sector *bs = dst + boot_sector * sector_size;
+	struct volume_info *vi = (void *)(bs + 1);
+	__le32 *fat = dst + fat_sector * sector_size;
+	struct dir_entry *dirent = dst + root_sector * sector_size;
+
+	/* Make sure we fit in the FAT */
+	if (sectors > sector_size / sizeof(u32))
+		return 0;
+
+	ext = strchr(filename, '.');
+	if (ext) {
+		filename_len = ext - filename;
+		ext++;
+		ext_len = strlen(ext);
+	} else {
+		filename_len = strlen(filename);
+		ext_len = 0;
+	}
+
+	if (filename_len > 8 || ext_len > 3)
+		return 0;
+
+	if (data_offset)
+		*data_offset = file_sector * sector_size;
+
+	if (!dst)
+		goto out;
+
+	bs->sector_size[0] = sector_size & 0xff;
+	bs->sector_size[1] = sector_size >> 8;
+	bs->cluster_size = 1;
+	bs->reserved = cpu_to_le16(fat_sector);
+	bs->fats = 1;
+	bs->media = 0xf8;
+	bs->total_sect = cpu_to_le32(sectors);
+	bs->fat32_length = cpu_to_le32(1);
+	bs->root_cluster = cpu_to_le32(root_sector);
+
+	vi->ext_boot_sign = 0x29;
+	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
+
+	memcpy(dst + 0x1fe, "\x55\xAA", 2);
+
+	fat[0] = cpu_to_le32(0x0ffffff8);
+	fat[1] = cpu_to_le32(0x0fffffff);
+	fat[2] = cpu_to_le32(0x0ffffff8);
+	for (i = file_sector; file_sectors > 1; file_sectors--, i++)
+		fat[i] = cpu_to_le32(i + 1);
+	fat[i] = cpu_to_le32(0x0ffffff8);
+
+	for (i = 0; i < sizeof(dirent->nameext.name); i++) {
+		if (i < filename_len)
+			dirent->nameext.name[i] = toupper(filename[i]);
+		else
+			dirent->nameext.name[i] = ' ';
+	}
+
+	for (i = 0; i < sizeof(dirent->nameext.ext); i++) {
+		if (i < ext_len)
+			dirent->nameext.ext[i] = toupper(ext[i]);
+		else
+			dirent->nameext.ext[i] = ' ';
+	}
+
+	dirent->start = cpu_to_le16(file_sector);
+	dirent->size = cpu_to_le32(size);
+
+out:
+	return sectors * sector_size;
+}
+
+typedef size_t (*create_fs_t)(void *, size_t, const char *, size_t *);
+
+static int spl_test_fs(struct unit_test_state *uts, const char *test_name,
+		       create_fs_t create)
+{
+	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
+	struct blk_desc *dev_desc;
+	char *data_write, *data_read;
+	void *fs;
+	size_t fs_size, fs_data, fs_blocks, data_size = SPL_TEST_DATA_SIZE;
+	loff_t actread;
+
+	fs_size = create(NULL, data_size, filename, &fs_data);
+	ut_assert(fs_size);
+	fs = calloc(fs_size, 1);
+	ut_assertnonnull(fs);
+
+	data_write = fs + fs_data;
+	generate_data(data_write, data_size, test_name);
+	ut_asserteq(fs_size, create(fs, data_size, filename, NULL));
+
+	dev_desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	ut_assertnonnull(dev_desc);
+	ut_asserteq(512, dev_desc->blksz);
+	fs_blocks = fs_size / dev_desc->blksz;
+	ut_asserteq(fs_blocks, blk_dwrite(dev_desc, 0, fs_blocks, fs));
+
+	/* We have to use malloc so we can call virt_to_phys */
+	data_read = malloc_cache_aligned(data_size);
+	ut_assertnonnull(data_read);
+	ut_assertok(fs_set_blk_dev_with_part(dev_desc, 0));
+	ut_assertok(fs_read("/" CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+			    virt_to_phys(data_read), 0, data_size, &actread));
+	ut_asserteq(data_size, actread);
+	ut_asserteq_mem(data_write, data_read, data_size);
+
+	free(data_read);
+	free(fs);
+	return 0;
+}
+
+static int spl_test_ext(struct unit_test_state *uts)
+{
+	return spl_test_fs(uts, __func__, create_ext2);
+}
+SPL_TEST(spl_test_ext, DM_FLAGS);
+
+static int spl_test_fat(struct unit_test_state *uts)
+{
+	return spl_test_fs(uts, __func__, create_fat);
+}
+SPL_TEST(spl_test_fat, DM_FLAGS);
-- 
2.37.1

