Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C703FCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 05:00:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C09AC846D3;
	Thu, 11 Jun 2026 06:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OME7djmg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9861E8466E; Thu, 11 Jun 2026 06:22:01 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9DE839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hemparekh1596@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c0b944f6edso76374695ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 21:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781151718; x=1781756518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CUecKU4ty45IeOUDnOhYdtWP3bipg0FVeDluGRMkH94=;
 b=OME7djmgeBB2zqxlCI1TXwm3rBmhMxl6asIoOMbUL4AycFKRFCL5N2r6HVl5+PuHAy
 KCm59D354oxYcfy2wMTZkAgeHn1iFPKHGeEZQbkR02h0ygUJwMM0cjBCFSKIlUp1RMMd
 MThzTjXu2h+eNrL0nkQlAoBx5n/e7kZfVeIVME71MKUQDUmja4IdJW5Wzo2vDrlya1Z1
 p3PvCbqlJDd8mGZFccJQfUC2Dw83QB3doH6ehZpf6t109HPaZxbQfV9b0VBdxk9o8Xag
 CUtIIjzvGZYfbG5pgeX5Tvwsl2xLWP+QwinkLkNSxgA2IudQKvQNvzwcblMAh61Ev7n/
 RaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781151718; x=1781756518;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUecKU4ty45IeOUDnOhYdtWP3bipg0FVeDluGRMkH94=;
 b=NKgrQrOuZTI94E11l60paW4lBVg1304EntUUbSh6V0n/d31WtVCUXz7qEjuPwJcGQO
 brbvdkQotTgjQG4xOfgmijan8ceON3buvnRpjexuxT7waLbmZpa6bFCSfSB//LU07tbA
 UfC2Nau/SJ5NMnR6FUpdltqmp+W2xnjs7OPCvjlZX+mYTbUXsTje4NAsP284Tv6YDw6v
 RwfAY1SZ7md71zPe5KEFzI+59xYlh6BxW0h3UgpQxPwmUYs83xa8lgHkA3yRzhymUWK6
 cZnPYFHragHBe2VZI+K9d63rGpMx7bT1CxPRuxlOYVFjryRGScxxyD85a6+Gng4N51fZ
 XapQ==
X-Gm-Message-State: AOJu0YxnHnq2x56Oe1lQGFFyeZC7rgeq9lzx9tPZSMphhdAkH6o1T3RL
 0fO2ex0RKFcMwZ/dZoQcNLeENXRWpTlhuvXpUiuz673EisF5n6H1EJwNMwosbx+t
X-Gm-Gg: Acq92OHXBV0Qv2JAgAUcU3idAsy6184ckPXN/jVZSmE5gXVqFyh9b04sjPGFLASTK2l
 fm7cvin32LyFxmfJg6I3OKPjZwFaz0UnF7mlZvedh4EQT1BalZuBhhwYIVmBisJB3ZxEVIIAuxW
 r0ptEf96/IerYP0/rOB7zWy26XIrPsIB7mY0b+bqr3xV8fHH9RakQTpzJ62ZOhkNAcRzEiLkJ6A
 7ZM30VP/qOIktDgoLqxPVZgQgdvjmMfXN7mibFmtEu5Slb22lRKIdMqw5kmx/G8ZD/fAiZ9hLzu
 Hj4E9Zc/+WzFUb97rFP72+HfirKVmnyvCutRfQ8tU/a7pdJNZv950iFg7TkcDwVRXoD1NC/nSja
 nbcyEwo3WN1OToTBPzuh4SJpLWoguW74AvdySyT7LiwVS7wK2UOtXdohBR+eOXwv+25QvUI0gwW
 pti5wAVHjPd6do0NFThZ/IL6kiHFON1WiiF3bhYRmzYuuHcrZTjKi7K70zLM9U+nqCregFeoDKi
 MnV
X-Received: by 2002:a17:902:d2d0:b0:2c2:25d8:d5a3 with SMTP id
 d9443c01a7336-2c2f20aba63mr12602265ad.3.1781151717512; 
 Wed, 10 Jun 2026 21:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:947f:47d0:9d82:a7c8:79c0:6a2d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f8792bsm269695725ad.23.2026.06.10.21.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 21:21:57 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 trini@konsulko.com, eric.kilmer@trailofbits.com,
 Hem Parekh <hemparekh1596@gmail.com>
Subject: [PATCH] fs/squashfs: fix out-of-bounds read while walking the inode
 table
Date: Wed, 10 Jun 2026 21:21:13 -0700
Message-ID: <20260611042151.57535-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 06:59:54 +0200
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

sqfs_find_inode() walks the uncompressed inode table for sblk->inodes
iterations, advancing 'offset' by sqfs_inode_size() each step. Both the
inode count and every per-inode size are taken verbatim from the on-disk
(attacker-controlled) SquashFS image, but the walk was never bounded
against the end of the heap buffer allocated in sqfs_read_inode_table()
(metablks_count * SQFS_METADATA_BLOCK_SIZE bytes). A malformed image can
therefore drive 'base = inode_table + offset' and the field reads in
sqfs_inode_size() past the buffer, an out-of-bounds read reachable from
any path lookup (e.g. 'ls'/'load' of a squashfs filesystem).

The SQFS_LDIR_TYPE branch of sqfs_inode_size() makes this worse: it
loops i_count times reading di->size and advancing 'di' by
sizeof(*di) + size with no bounds check at all, so a single crafted
extended-directory inode walks 'di' arbitrarily far past the buffer.

Propagate the inode-table buffer size from sqfs_read_inode_table() into
the dir stream and on into sqfs_find_inode(), and:
 - reject any base inode whose fixed fields fall outside the table;
 - pass the buffer end to sqfs_inode_size() and bound the LDIR index
   walk against it;
 - reject any computed inode size that pushes 'offset' past the buffer.

Reproduced with a standalone libc + AddressSanitizer harness replicating
the verbatim sqfs_find_inode()/sqfs_inode_size() logic: the unpatched
code faults on an OOB read inside the LDIR loop, the patched code rejects
the malformed inode and returns NULL cleanly.

Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
---
 fs/squashfs/sqfs.c            | 29 +++++++++++++++++------------
 fs/squashfs/sqfs_filesystem.h |  5 +++--
 fs/squashfs/sqfs_inode.c      | 20 ++++++++++++++++----
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0768fc4a7b2..d92f8869284 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -486,8 +486,9 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	dirsp = (struct fs_dir_stream *)dirs;
 
 	/* Start by root inode */
-	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
-				sblk->inodes, sblk->block_size);
+	table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+				le32_to_cpu(sblk->inodes), sblk->inodes,
+				sblk->block_size);
 	if (!table)
 		return -EINVAL;
 
@@ -543,8 +544,9 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 			dirs->dir_header->inode_number;
 
 		/* Get reference to inode in the inode table */
-		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
-					sblk->inodes, sblk->block_size);
+		table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+					new_inode_number, sblk->inodes,
+					sblk->block_size);
 		if (!table)
 			return -EINVAL;
 		dir = (struct squashfs_dir_inode *)table;
@@ -719,7 +721,8 @@ static int sqfs_get_metablk_pos(u32 *pos_list, void *table, u32 offset,
 	return ret;
 }
 
-static int sqfs_read_inode_table(unsigned char **inode_table)
+static int sqfs_read_inode_table(unsigned char **inode_table,
+				 size_t *inode_table_size)
 {
 	struct squashfs_super_block *sblk = ctxt.sblk;
 	u64 start, n_blks, table_offset, table_size;
@@ -773,6 +776,8 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
 		goto free_itb;
 	}
 
+	*inode_table_size = (size_t)metablks_count * SQFS_METADATA_BLOCK_SIZE;
+
 	src_table = itb + table_offset + SQFS_HEADER_SIZE;
 
 	/* Extract compressed Inode table */
@@ -933,7 +938,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	dirs->inode_table = NULL;
 	dirs->dir_table = NULL;
 
-	ret = sqfs_read_inode_table(&inode_table);
+	ret = sqfs_read_inode_table(&inode_table, &dirs->inode_table_size);
 	if (ret) {
 		ret = -EINVAL;
 		goto out;
@@ -1071,8 +1076,8 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos)
 		return -SQFS_STOP_READDIR;
 
@@ -1430,8 +1435,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos) {
 		ret = -EINVAL;
 		goto out;
@@ -1699,8 +1704,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 
 	if (!ipos) {
 		*size = 0;
diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
index be56498a5e3..2e4224ea78a 100644
--- a/fs/squashfs/sqfs_filesystem.h
+++ b/fs/squashfs/sqfs_filesystem.h
@@ -275,6 +275,7 @@ struct squashfs_dir_stream {
 	 * sqfs_opendir() and freed in sqfs_closedir().
 	 */
 	unsigned char *inode_table;
+	size_t inode_table_size;
 	unsigned char *dir_table;
 };
 
@@ -293,8 +294,8 @@ struct squashfs_file_info {
 	bool comp;
 };
 
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size);
+void *sqfs_find_inode(void *inode_table, size_t inode_table_size,
+		      int inode_number, __le32 inode_count, __le32 block_size);
 
 int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count);
 
diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index ce9a8ff8e2a..da347becaff 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -17,7 +17,8 @@
 #include "sqfs_filesystem.h"
 #include "sqfs_utils.h"
 
-int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
+int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size,
+		    const void *end)
 {
 	u16 inode_type = get_unaligned_le16(&inode->inode_type);
 
@@ -53,9 +54,13 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 
 		di = ldir->index;
 		while (l < i_count) {
+			if ((void *)di + sizeof(*di) > end)
+				return -EINVAL;
 			sz = get_unaligned_le32(&di->size) + 1;
 			index_list_size += sz;
 			di = (void *)di + sizeof(*di) + sz;
+			if ((void *)di > end || (void *)di < (void *)ldir)
+				return -EINVAL;
 			l++;
 		}
 
@@ -114,9 +119,10 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
  * Given the uncompressed inode table, the inode to be found and the number of
  * inodes in the table, return inode position in case of success.
  */
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size)
+void *sqfs_find_inode(void *inode_table, size_t inode_table_size,
+		      int inode_number, __le32 inode_count, __le32 block_size)
 {
+	const void *end = inode_table + inode_table_size;
 	struct squashfs_base_inode *base;
 	unsigned int offset = 0, k;
 	int sz;
@@ -128,14 +134,20 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
 
 	for (k = 0; k < le32_to_cpu(inode_count); k++) {
 		base = inode_table + offset;
+		/* Ensure the base inode fields lie within the table */
+		if ((void *)(base + 1) > end)
+			return NULL;
 		if (get_unaligned_le32(&base->inode_number) == inode_number)
 			return inode_table + offset;
 
-		sz = sqfs_inode_size(base, le32_to_cpu(block_size));
+		sz = sqfs_inode_size(base, le32_to_cpu(block_size), end);
 		if (sz < 0)
 			return NULL;
 
 		offset += sz;
+		/* The computed inode must not run past the table buffer */
+		if (offset > inode_table_size)
+			return NULL;
 	}
 
 	printf("Inode not found.\n");
-- 
2.50.1 (Apple Git-155)

