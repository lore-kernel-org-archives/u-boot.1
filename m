Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8302CD5BB8
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 23:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6438F8488D;
	Sun, 24 May 2026 01:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JRgVzphe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345D3848A4; Sat, 23 May 2026 16:49:07 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FF284874
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 16:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso62250275e9.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779547745; x=1780152545; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UVJdfPyWC4GkBH5D034VuG9Zos5ENXzssct6gcBx4c=;
 b=JRgVzphe7MmYpQuRoifXVvmMfd1Ijqk8ZGrQNVNEwrsScexYXPnPPzpYngNFB3P5kJ
 HMZAQFSk40D4BNJgtpLB8gIInJ1hAm2Ed2QaoqgBf8ngeVkY9qhwC5wQ34+5/XSsOOXr
 seT5qgwX6euswogZGQoCKftFpHxXIAMZfNra5klKEE8DHhephTAH4dEbT3a6gfOJLuOY
 d4nDHYDzuhGQlCWd0lFxJH9ua18388RC90U24Tembo5RZXYI7F68mTE6XkqMsjnXvIzw
 tKygoHFsEP2MmbsUaXitZNaZ1tfhHIgLsXJ2mjyoV+ZwjnrVV+Ti4JNqdJlm3o+fqq0m
 cbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779547745; x=1780152545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4UVJdfPyWC4GkBH5D034VuG9Zos5ENXzssct6gcBx4c=;
 b=LW53PjdDV2V93TUrfW73KqvrhmCnmIcy28ooWQ5Nu89XCDo/X2wHxSpVYB07PziQog
 Al2pesXiRsAhwBnEXtEDWznfXQSOL6t04MZ4MhNSO1r1F86CPH381mtpNVHWYd7ZlkJe
 lD3nPbuUGpu3OlPcbvegIrnB9NKp9jwIt6IgCvr5MMkXKEjjKe8VfXimWb0jeeVjxEv9
 CAeiM+jajNWj2Y76NG2EGG2fDHTaP6MOzSwMfvBGK5dJ9RQRL+G5To9Qo4PRsDD0h8vQ
 cAuIY7JDb/jCBTSV+9EhYfkWRPzpEuUNuxKo4hDA6OyA3GQf8EVMrtbmEhEqKTSLbnEW
 fL3g==
X-Gm-Message-State: AOJu0YxldowCMAJeLFa8bZujEx70YhHz1LHY7T4Ia20zdO1dswqrnGj7
 iLjdWq0icjAwAQfPby1H/xjOAbVD6RYRgCWx5JtjFJsTmBne7ve8wa8q5vybrta1
X-Gm-Gg: Acq92OFtXRhmEIaNATWuNvBIkeI4NZLz614nCU8EFHwuDX1TJHtW7GB43wkOeyd6Ofd
 JnMBhrBWBFB/ZPFWbRI5RxAQ9JXtSlipLgXXf5MydhZBu0L1xnuC2s2Ew4NgknieNbwTXLwDkzs
 k+pVtc0y7hKoLlnioMwIqc6CTlHqNh3IjqymYhb+EDV8V6qrxbDfUK8PSKEdu2ia0n3g0QEpUQl
 dWIPmclNi8wJ1wB5H8MlAXuZxf9DJwwA7GVmKg0qscVp5HP19VtR1bDW+c1/s8KfU5siWr9r4S3
 6iooDKQowbhntkK8SALCf+yGrLghfBiIfyGjwU8tr9BP6XQ8hXqnzaBOwuSGmJtvB5x2m1OZpdN
 61YLX0UgcvkLLOPVK3A3pohlq672nDZlYcDbQo7Lh33KyggIBtf9I7tsFpHQHNaNWj1UAlrC51p
 8v3NboBUu1K91VBljcQcRmk540Xtk857EwEj1Eang6lsu/Y6yr+LmJFrNj+W37MaLZrixS1ILGo
 n9DIAYbsiUVND5kWyEuk6HHISwjQ/oAbNsqgG4ruEaHhpf+vL4OoV55UiscT7NOIJreWG8KA3NK
 KGN+CLAzx9DHIYE=
X-Received: by 2002:a05:600d:4448:10b0:48f:f7cc:f6f5 with SMTP id
 5b1f17b1804b1-490428e9154mr91220045e9.31.1779547744454; 
 Sat, 23 May 2026 07:49:04 -0700 (PDT)
Received: from thinkpad-t15g-g2 ([2a01:e0a:905:5c10:e95d:babe:59ca:c99e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045282201sm132080165e9.8.2026.05.23.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 07:49:02 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: richard.genoud@bootlin.com, jmcosta944@gmail.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, Allan ELKAIM <allan.elkaim@gmail.com>
Subject: [PATCH v2] fs/squashfs: fix missing error checks causing Synchronous
 Abort
Date: Sat, 23 May 2026 16:48:09 +0200
Message-ID: <20260523144809.2271703-1-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
References: <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 24 May 2026 01:01:46 +0200
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

sqfs_find_inode() returns NULL on failure, and sqfs_dir_offset()
returns -EINVAL on failure. At 8 call sites in sqfs.c neither return
value was validated before the result was cast to a struct pointer or
used as an array index.

On squashfs images with large inode/directory tables (e.g. containing
the tzdata timezone database), sqfs_dir_offset() fails to locate a
start_block in the metadata-block position list and returns -EINVAL.
The caller then computes &dir_table[-22], producing a faulting address
of 0xffffffffffffffea and a Synchronous Abort on ARM64:

  "Synchronous Abort" handler, esr 0x96000004, far 0xffffffffffffffea

The "Error: invalid inode reference to directory table." message
printed just before the abort confirms the sqfs_dir_offset() path.
Additionally, sqfs_find_inode() can return NULL when the inode table
scan encounters an unknown or malformed inode type, after which any
dereference of the cast pointer crashes.

Add NULL guards after every sqfs_find_inode() call and negative-value
guards after every sqfs_dir_offset() call so that any lookup failure
propagates as -EINVAL rather than crashing.

Signed-off-by: Allan Elkaim <allan.elkaim@gmail.com>
---
 fs/squashfs/sqfs.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 1430e671..da8fbb5a 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -472,12 +472,16 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	/* Start by root inode */
 	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
 				sblk->inodes, sblk->block_size);
+	if (!table)
+		return -EINVAL;
 
 	dir = (struct squashfs_dir_inode *)table;
 	ldir = (struct squashfs_ldir_inode *)table;
 
 	/* get directory offset in directory table */
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0)
+		return offset;
 	dirs->table = &dirs->dir_table[offset];
 
 	/* Setup directory header */
@@ -527,6 +531,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		/* Get reference to inode in the inode table */
 		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
 					sblk->inodes, sblk->block_size);
+		if (!table) {
+			free(dirs->entry);
+			dirs->entry = NULL;
+			ret = -EINVAL;
+			goto out;
+		}
 		dir = (struct squashfs_dir_inode *)table;
 
 		/* Check for symbolic link and inode type sanity */
@@ -599,6 +609,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 		/* Get dir. offset into the directory table */
 		offset = sqfs_dir_offset(table, m_list, m_count);
+		if (offset < 0) {
+			free(dirs->entry);
+			dirs->entry = NULL;
+			ret = offset;
+			goto out;
+		}
 		dirs->table = &dirs->dir_table[offset];
 
 		/* Copy directory header */
@@ -623,6 +639,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	}
 
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0) {
+		free(dirs->entry);
+		dirs->entry = NULL;
+		ret = offset;
+		goto out;
+	}
 	dirs->table = &dirs->dir_table[offset];
 
 	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)
@@ -1023,6 +1045,8 @@ int sqfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
 	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
 			       sblk->block_size);
+	if (!ipos)
+		return -SQFS_STOP_READDIR;
 
 	base = (struct squashfs_base_inode *)ipos;
 
@@ -1379,6 +1403,10 @@ int sqfs_read(const char *filename, void *buf, loff_t offset, loff_t len,
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
 	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
 			       sblk->block_size);
+	if (!ipos) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	base = (struct squashfs_base_inode *)ipos;
 	switch (get_unaligned_le16(&base->inode_type)) {
@@ -1629,6 +1657,11 @@ int sqfs_size(const char *filename, loff_t *size)
 			       sblk->block_size);
 	free(dirs->entry);
 	dirs->entry = NULL;
+	if (!ipos) {
+		*size = 0;
+		ret = -EINVAL;
+		goto free_strings;
+	}
 
 	base = (struct squashfs_base_inode *)ipos;
 	switch (get_unaligned_le16(&base->inode_type)) {
-- 
2.53.0

