Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC7CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 12:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E818493A;
	Fri, 12 Jun 2026 14:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GEraDeaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D854683FEC; Fri, 12 Jun 2026 09:55:08 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C458005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piyushthepal@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2bf55c39e16so8354715ad.0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781250904; x=1781855704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aICWzbSor3YglIIcIzDbPDsV8rAey0alh+YDWOMY7mI=;
 b=GEraDeaSB/rSseNLn+ZxzgPhFvswBZjyt33cScyRl2Ow5NIt0OlEQ3PJlvaX6cCm5B
 /k5ETw3akjpsovPjXXwaVO4Td3m3LZirKmRJtVbkfuZP2bD3IOSv6Vktp8olY0SvlreI
 jLC54eiUs16uXAp3iX/ZrBOug5kMldOiyM1LC0N0mWvLhBA8VWN8xaBfwqfcDC01+4HO
 zWm0aob0ppwCPVv9Mm+G7/Z4B2klYUeGt6pWMsqN0HSIwNPAtyMhcbmh1ysesyQtk904
 T49EhSrKMXLPRdCAYymNuDsFgNrQlpoQFxQp3Ua6Mp3tIQDgVhHZlpjiMsbviRHZHpZX
 zvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781250904; x=1781855704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aICWzbSor3YglIIcIzDbPDsV8rAey0alh+YDWOMY7mI=;
 b=TW2V6vwzVugyWJqr7+Zfa7t3ftZ5dDMd2DOZhJY5h4/OeudxPXVvRyZI1f9pALvZqO
 1Z2NxgTr/zuXQB2lDw4tjJ6shinozpY3pvudlJ6NGXvfUoncDBUn7b380llZkpe7vsMv
 6tXRHnuc9vnlFgDsGkH28Z4v9LfkPe/IsRdjFzmo0DLNPHXk4KQqb+vo1xz9A1F8TYzE
 7u3f9LEJVfF3LAZiPRFl0Ke5yGJ4fA9/U6VFu6xKciOAJvsBHfAvV/xkumXSuhM4WmW6
 F3lxWFk/YraCNIuX2Mysxuhfp8YO+eN25SjEMcW2vKU4rIWbpsQcarsd/S0ZvitNLUfR
 dGIg==
X-Gm-Message-State: AOJu0YzriWAQA7bylfEX3dM11Tnh1psU0ywqwxtAXi3XgzVS4ZKFXtHk
 7eiXUWi2BYS6UQXXylFzGQdrgKr5FuX/IpHPx8y0qW6h5C0ni7m3aRWH4cbNU8bd
X-Gm-Gg: Acq92OElOP3PM4Rpqq59BnYU3tr4916fkxzEXcEftRXKfhh31wvyht8ObqqPGscERml
 FLPZka6uW+Z6NuMk+lozADh7K10XYiupvpem5finjMZrzcYnsOZkJlHb7hUfHW9AP5IqbCKtcWH
 Rlrh2v93p6NykSb11ff+IdkKXhhX4qSm2k2iJBN3oEH/OCnzYDhxYyfeEP7+RzGjRlJYyD1eogF
 lFwsWNG7GscmF9kx3XNv32UXR5w1WFIs3o4h6V9FQBkzQiX06tht/+AgU7Dy2kT0cBgQeEBDyS2
 o7DsPt00EybAbK7bHiGqNg0EUNWvmtBQLGamZWeUsIO3UUpSK64BcCFDVof1/JqWZ+nTsenZyYi
 NcDapPQd64qRhGDh3qDbox0InVerLytqtDq/z1HZSsqnR8WEyNnjExBlPp0hE2zIrGcWFFBMUBt
 /Wte+ee8JjuAZi+tfpysOKGPO4+yGBOaWz8SpfUSCr0vJaF879t3avwns=
X-Received: by 2002:a17:903:1208:b0:2bd:73f4:8e4f with SMTP id
 d9443c01a7336-2c429181b81mr14328645ad.0.1781250904384; 
 Fri, 12 Jun 2026 00:55:04 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm11197655ad.62.2026.06.12.00.55.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jun 2026 00:55:04 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, eric.kilmer@trailofbits.com,
 Piyush Paliwal <piyushthepal@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] fs/squashfs: bound the inode table walk in
 sqfs_find_inode()
Date: Fri, 12 Jun 2026 13:24:23 +0530
Message-ID: <20260612075424.83462-2-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
References: <20260612075424.83462-1-piyushthepal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Jun 2026 14:36:02 +0200
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

sqfs_find_inode() walks the decompressed inode table advancing
"offset += sqfs_inode_size(base, ...)" with no check that offset stays
within the table (metablks_count * SQFS_METADATA_BLOCK_SIZE). All sizes
come from the on-disk image, including the unbounded extended-directory
(LDIR) index walk and the regular-file block-list term in
sqfs_inode_size(). A crafted image makes base run off the end of the
buffer -> out-of-bounds read / SEGV, reachable simply by listing the
image (ls/sqfsls) or any operation that resolves a path.

The earlier fix 3fb1df1e5 ("squashfs: Check sqfs_find_inode() return
value") only added NULL checks at the call sites; it did not add the
missing internal bound, so the wild read still occurs before the
function can return. c8e929e5 fixed only the symlink case of
sqfs_inode_size(), leaving the LDIR index walk unbounded.

Thread the inode table size from sqfs_read_inode_table() through the
squashfs_dir_stream to sqfs_find_inode(), and:
 - reject an inode whose base header does not fit in the table;
 - pass the remaining byte count to sqfs_inode_size() and validate every
   variable-length read (LDIR index list, REG/LREG block list, symlink,
   device/ipc inodes) against it, with overflow-checked arithmetic;
 - reject an inode whose computed size leaves the table.

Found by fuzzing the sandbox (CONFIG_ASAN) sqfsls/sqfsload with mutated
images. Before: SEGV in sqfs_find_inode (sqfs_inode.c) and in
sqfs_inode_size() LDIR walk. After: malformed images are rejected
cleanly; 2000 fuzz iterations produce no crash and the valid-image path
is unchanged.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 fs/squashfs/sqfs.c            |  26 +++++----
 fs/squashfs/sqfs_filesystem.h |   6 +-
 fs/squashfs/sqfs_inode.c      | 106 +++++++++++++++++++++++++++++-----
 3 files changed, 110 insertions(+), 28 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0768fc4a7b2..3548b5e07e2 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -486,7 +486,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	dirsp = (struct fs_dir_stream *)dirs;
 
 	/* Start by root inode */
-	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
+	table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+				le32_to_cpu(sblk->inodes),
 				sblk->inodes, sblk->block_size);
 	if (!table)
 		return -EINVAL;
@@ -543,7 +544,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 			dirs->dir_header->inode_number;
 
 		/* Get reference to inode in the inode table */
-		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
+		table = sqfs_find_inode(dirs->inode_table,
+					dirs->inode_table_size, new_inode_number,
 					sblk->inodes, sblk->block_size);
 		if (!table)
 			return -EINVAL;
@@ -719,7 +721,7 @@ static int sqfs_get_metablk_pos(u32 *pos_list, void *table, u32 offset,
 	return ret;
 }
 
-static int sqfs_read_inode_table(unsigned char **inode_table)
+static int sqfs_read_inode_table(unsigned char **inode_table, size_t *out_size)
 {
 	struct squashfs_super_block *sblk = ctxt.sblk;
 	u64 start, n_blks, table_offset, table_size;
@@ -773,6 +775,8 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
 		goto free_itb;
 	}
 
+	*out_size = (size_t)metablks_count * SQFS_METADATA_BLOCK_SIZE;
+
 	src_table = itb + table_offset + SQFS_HEADER_SIZE;
 
 	/* Extract compressed Inode table */
@@ -920,6 +924,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	int j, token_count = 0, ret = 0, metablks_count;
 	struct squashfs_dir_stream *dirs;
 	char **token_list = NULL, *path = NULL;
+	size_t inode_table_size = 0;
 	u32 *pos_list = NULL;
 
 	dirs = calloc(1, sizeof(*dirs));
@@ -933,7 +938,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	dirs->inode_table = NULL;
 	dirs->dir_table = NULL;
 
-	ret = sqfs_read_inode_table(&inode_table);
+	ret = sqfs_read_inode_table(&inode_table, &inode_table_size);
 	if (ret) {
 		ret = -EINVAL;
 		goto out;
@@ -973,6 +978,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	 * a general solution for the malloc size, since 'i' is a union.
 	 */
 	dirs->inode_table = inode_table;
+	dirs->inode_table_size = inode_table_size;
 	dirs->dir_table = dir_table;
 	ret = sqfs_search_dir(dirs, token_list, token_count, pos_list,
 			      metablks_count);
@@ -1071,8 +1077,8 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos)
 		return -SQFS_STOP_READDIR;
 
@@ -1430,8 +1436,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos) {
 		ret = -EINVAL;
 		goto out;
@@ -1699,8 +1705,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 
 	if (!ipos) {
 		*size = 0;
diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
index be56498a5e3..6c97b2c3a9c 100644
--- a/fs/squashfs/sqfs_filesystem.h
+++ b/fs/squashfs/sqfs_filesystem.h
@@ -275,6 +275,8 @@ struct squashfs_dir_stream {
 	 * sqfs_opendir() and freed in sqfs_closedir().
 	 */
 	unsigned char *inode_table;
+	/* Size in bytes of the decompressed inode_table buffer */
+	size_t inode_table_size;
 	unsigned char *dir_table;
 };
 
@@ -293,8 +295,8 @@ struct squashfs_file_info {
 	bool comp;
 };
 
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size);
+void *sqfs_find_inode(void *inode_table, size_t table_size, int inode_number,
+		      __le32 inode_count, __le32 block_size);
 
 int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count);
 
diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index ce9a8ff8e2a..20085f8912b 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -17,65 +17,122 @@
 #include "sqfs_filesystem.h"
 #include "sqfs_utils.h"
 
-int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
+int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size, size_t max)
 {
-	u16 inode_type = get_unaligned_le16(&inode->inode_type);
+	u16 inode_type;
+
+	/* The smallest possible inode must fit in the remaining bytes */
+	if (max < sizeof(struct squashfs_base_inode))
+		return -EINVAL;
+
+	inode_type = get_unaligned_le16(&inode->inode_type);
 
 	switch (inode_type) {
 	case SQFS_DIR_TYPE:
+		if (max < sizeof(struct squashfs_dir_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_dir_inode);
 
 	case SQFS_REG_TYPE: {
 		struct squashfs_reg_inode *reg =
 			(struct squashfs_reg_inode *)inode;
-		u32 fragment = get_unaligned_le32(&reg->fragment);
-		u32 file_size = get_unaligned_le32(&reg->file_size);
+		u32 fragment, file_size;
 		unsigned int blk_list_size;
+		int size;
+
+		if (max < sizeof(*reg))
+			return -EINVAL;
+
+		fragment = get_unaligned_le32(&reg->fragment);
+		file_size = get_unaligned_le32(&reg->file_size);
+
+		if (!blk_size)
+			return -EINVAL;
 
 		if (SQFS_IS_FRAGMENTED(fragment))
 			blk_list_size = file_size / blk_size;
 		else
 			blk_list_size = DIV_ROUND_UP(file_size, blk_size);
 
-		return sizeof(*reg) + blk_list_size * sizeof(u32);
+		if (__builtin_mul_overflow(blk_list_size, (unsigned int)sizeof(u32),
+					   &blk_list_size) ||
+		    __builtin_add_overflow((int)sizeof(*reg), (int)blk_list_size,
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_LDIR_TYPE: {
 		struct squashfs_ldir_inode *ldir =
 			(struct squashfs_ldir_inode *)inode;
-		u16 i_count = get_unaligned_le16(&ldir->i_count);
+		u16 i_count;
 		unsigned int index_list_size = 0, l = 0;
 		struct squashfs_directory_index *di;
+		size_t consumed;
 		u32 sz;
+		int size;
 
+		if (max < sizeof(*ldir))
+			return -EINVAL;
+
+		i_count = get_unaligned_le16(&ldir->i_count);
 		if (i_count == 0)
 			return sizeof(*ldir);
 
 		di = ldir->index;
+		consumed = sizeof(*ldir);
 		while (l < i_count) {
+			/* The directory index header must stay in bounds */
+			if (consumed + sizeof(*di) > max)
+				return -EINVAL;
 			sz = get_unaligned_le32(&di->size) + 1;
+			if (__builtin_add_overflow(consumed, sizeof(*di) + sz,
+						   &consumed) ||
+			    consumed > max)
+				return -EINVAL;
 			index_list_size += sz;
 			di = (void *)di + sizeof(*di) + sz;
 			l++;
 		}
 
-		return sizeof(*ldir) + index_list_size +
-			i_count * SQFS_DIR_INDEX_BASE_LENGTH;
+		if (__builtin_add_overflow((int)(sizeof(*ldir) + index_list_size),
+					   (int)(i_count * SQFS_DIR_INDEX_BASE_LENGTH),
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_LREG_TYPE: {
 		struct squashfs_lreg_inode *lreg =
 			(struct squashfs_lreg_inode *)inode;
-		u32 fragment = get_unaligned_le32(&lreg->fragment);
-		u64 file_size = get_unaligned_le64(&lreg->file_size);
+		u32 fragment;
+		u64 file_size;
 		unsigned int blk_list_size;
+		int size;
+
+		if (max < sizeof(*lreg))
+			return -EINVAL;
+
+		fragment = get_unaligned_le32(&lreg->fragment);
+		file_size = get_unaligned_le64(&lreg->file_size);
+
+		if (!blk_size)
+			return -EINVAL;
 
 		if (fragment == 0xFFFFFFFF)
 			blk_list_size = DIV_ROUND_UP(file_size, blk_size);
 		else
 			blk_list_size = file_size / blk_size;
 
-		return sizeof(*lreg) + blk_list_size * sizeof(u32);
+		if (__builtin_mul_overflow(blk_list_size, (unsigned int)sizeof(u32),
+					   &blk_list_size) ||
+		    __builtin_add_overflow((int)sizeof(*lreg), (int)blk_list_size,
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_SYMLINK_TYPE:
@@ -85,6 +142,9 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 		struct squashfs_symlink_inode *symlink =
 			(struct squashfs_symlink_inode *)inode;
 
+		if (max < sizeof(*symlink))
+			return -EINVAL;
+
 		if (__builtin_add_overflow(sizeof(*symlink),
 		    get_unaligned_le32(&symlink->symlink_size), &size))
 			return -EINVAL;
@@ -94,15 +154,23 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 
 	case SQFS_BLKDEV_TYPE:
 	case SQFS_CHRDEV_TYPE:
+		if (max < sizeof(struct squashfs_dev_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_dev_inode);
 	case SQFS_LBLKDEV_TYPE:
 	case SQFS_LCHRDEV_TYPE:
+		if (max < sizeof(struct squashfs_ldev_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_ldev_inode);
 	case SQFS_FIFO_TYPE:
 	case SQFS_SOCKET_TYPE:
+		if (max < sizeof(struct squashfs_ipc_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_ipc_inode);
 	case SQFS_LFIFO_TYPE:
 	case SQFS_LSOCKET_TYPE:
+		if (max < sizeof(struct squashfs_lipc_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_lipc_inode);
 	default:
 		printf("Error while searching inode: unknown type.\n");
@@ -114,11 +182,12 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
  * Given the uncompressed inode table, the inode to be found and the number of
  * inodes in the table, return inode position in case of success.
  */
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size)
+void *sqfs_find_inode(void *inode_table, size_t table_size, int inode_number,
+		      __le32 inode_count, __le32 block_size)
 {
 	struct squashfs_base_inode *base;
-	unsigned int offset = 0, k;
+	size_t offset = 0;
+	unsigned int k;
 	int sz;
 
 	if (!inode_table) {
@@ -127,12 +196,17 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
 	}
 
 	for (k = 0; k < le32_to_cpu(inode_count); k++) {
+		/* The base inode header must lie within the inode table */
+		if (offset + sizeof(struct squashfs_base_inode) > table_size)
+			return NULL;
+
 		base = inode_table + offset;
 		if (get_unaligned_le32(&base->inode_number) == inode_number)
 			return inode_table + offset;
 
-		sz = sqfs_inode_size(base, le32_to_cpu(block_size));
-		if (sz < 0)
+		sz = sqfs_inode_size(base, le32_to_cpu(block_size),
+				     table_size - offset);
+		if (sz <= 0 || (size_t)sz > table_size - offset)
 			return NULL;
 
 		offset += sz;
-- 
2.41.0

