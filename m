Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B611606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XsH6VcG3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DKIlQDWq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D692F80E5F;
	Wed, 25 Nov 2026 09:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teZlYeEgkzWY; Wed, 25 Nov 2026 09:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9FE8B80C71
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795600544;
	b=RIiX4KXfoIxN0dGoknx72cyPPbR24jjMOPwLgi+wE/y2ceuL+OWNhDyzEon5UDZ28D1g
	 ZZI8xWJy4cMiA7RDFKIvd7mp2mCudQnaeOGWh5ycXzNh0Bdur2L92beduCiq5j2UvxDny
	 Me5noCS3azywvhiW2hC7Vhk2yP7rsrGfTqbTMpQw4SzMY2m4t8VcUwW+9JtP+RvLSK6OR
	 AV26wfFIO9GnzX6OxyBrEHeWdSPJhnv4OwtLwAmdYeVwd/SfRbayIjM2btYdMlhxToujo
	 JG3XcyjN1PLqYW7KmUmRhLQqWUa1Mazc0OQBtZklozde8KJ5vnTcEBV33rnT/tGVZUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795600544;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jLMRwZutY1+vHRGRksj2akuJAJDqxRSu6H1jbqFGckQ=;
	b=oJuti8CsHZR+H1J6KGwL0jVHxQeLYFH5yS9ldCk/o+vsuyZIoOITspZa8DN7x4Pq4gWH
	 GwkX2Sif2SqgCHBt0SrdtGBVUw87mm9T07nGdHsiiDu/gDnzGhbxJkapoVUcyrUQ6rG4B
	 sle/eG+fhT414NcA0zXNpkQ3hN+24JDNlOg66wsYea8d3qNYYGeQ1/hwF1YMg2RlMIHWw
	 2b8p0U77fskQQDtnqoi0YrG+ecXWuU2aLSWe1NxZkArFWUvRzmVUgLTcUaGrwMXprSCl1
	 9HFSkFHt8mwJMp9gcICEzTpfVYuOA+FPkrl1WcXriQ74HoU5xWrgEm2pNVa2pFODIYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795600544;
	bh=jLMRwZutY1+vHRGRksj2akuJAJDqxRSu6H1jbqFGckQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XsH6VcG39GvEwf9s9G29X4+Jsdm9TgoiIJJ/UljlyWKR0PPU4AuW9/qO2kRoVYnDU
	 9XeUdai/rCqcykfDBbTbiTjau8MzvOTdMDTrFC5dtTysjyjiiAVcGxYONYw4eeA8HX
	 WajPaaOf4rSrv2vl4n1I3U8RCI2zQdDbSVHUqXP01PjX+KzkBz+N6qcyTy2qtMt7jG
	 AMfJAELPOvzm7xOBBeucHPpFNaiFQz0CAmpTr6kqc7Z6KvXp6DdXXHBnaGbq5KdMX0
	 N6RJi9v+9CtTWJ/dDF3XLdxZAVFrffOd6GuZGslpX/Z/EFPj5eepo0l4o5ksOovhXS
	 dkCRJzIGw4yUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FE8B80C71;
	Wed, 25 Nov 2026 09:55:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 308B92DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1667540199
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TP2zapm3Yc99 for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 09:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9DD7240180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DKIlQDWq
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DD7240180
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 09:55:41 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so3205522f8f.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795600539; x=1796205339;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jLMRwZutY1+vHRGRksj2akuJAJDqxRSu6H1jbqFGckQ=;
 b=DKIlQDWquhavujvrNTj2KtHdTSDH48eY48mEUIrzi2oToUUoG58JkKsXyqX6cDNdHZ
 nI5qyy12bAr7fPgfHr7so2HUHBVDJ8nsT3NIy8aDzhQ9/id0wwo+BSWxBvz863Kubpcw
 lTRmcQBtsklgqs7hpycdzemObsIKQ+hzhgb7R/FDpWAM9W/Bi4mAL7hskFbIXnFscR89
 xTtVn/fwRHxl8G1Lx7cB7BvSyREx/1ago3ovUhx9p5QMIrIWOfKxHKejGr1vGFC2TvQw
 jTslQSOCdTL8D9FN005xvzt2ye7sjpZyTB74YIk5GI/csQY++jeWXgGN6PIPoaODiT8/
 R04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795600539; x=1796205339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jLMRwZutY1+vHRGRksj2akuJAJDqxRSu6H1jbqFGckQ=;
 b=Dmo3hD9O6fCK+y3CUVKSrnYgT+8U4WWqAeZ73L9MYxolPA55N3qT6JupuCNHuPF2cH
 qZZUDuJKYWjJQkrMXcaTpmEbPPRiVyuyx7n/pqYUFImj70RAwRs0PMpQzX2jqBBSwoLg
 8ro3mAoRAwrS5yj1HXWoXnQ8fkDPZKrr6uSNDjR98P7DlA7QZtEHqat+9VVqjRtrWIL3
 6amm4gJszWOFMCNKfUZaoGqnO9mwDzMGmwqJjEFKjv3Wbhrxeh9lebgxxmP0Ynsev5RC
 y9y+bd7PsYSovU8AarbV4LMC78tmbwRmu2wVPUZ7DibZH5ybACT7Ued8Ps1Zn2uw8tO9
 iMSQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEnmyCJ8Uj0KI4CYnpolMqPOPVjX08QdO+e6Bdl0X4hfvn+Vx7w9ohTVxfwtytHVL5KDRDNLbw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8oLBGXrjub5CHAADaCBKT6OZurZaws2j8zxZUqfDn/ptbw3wve
 rfGbaOyj8wlgFe5Mr6JZygs79e6axAkw8RSTFWoV2zU6HHYNZbCFPkxO
X-Gm-Gg: AZFdTZf87fwRyBjxLlaFteXnJsdybQDYOgjkIgboOq19RDuFElz6DVybKsndcMtZDMZ
 OWo6/d+EF++SIYC28fbo6wBZ/AYARLJ4qwkFYr9IDIUhaPTKgLYKheIOpMTnqEA6f1qEMf+XFcu
 KtkzjNYsQ96Wyx5qgJItpucnNGYEHSEmSw02lLh3kWAXLKSSmvGDv28xGisavJBqbya2YAhC4m7
 L6VG4hiMiSSQe9yGsMzRejfp29OA/Uw3nY2E9c/oqe8sqhZTlqW/MxBZXwqSl2vmDI8e7ljDadp
 SyEy7UFdgX1Y3USqvmNFb9e+xmPIdWzJo1cxz00OoS/1WOdhu3GKmy2aNDr17sxF1k8VV4DueaJ
 DC18gqy19l/G/Ue6Ao31E7iGhE5JnQlAWdwsgmLrK3Ny1KzvEZWgHFH2ZTIetI5B4oF6e8iLHtP
 Lnsmn7eiycUZOCp/la03tw62CO0XFvPAcPXjNWX4icW8N6Z/7z9TclBrn/I1EoKgse4irvRPC4K
 Y6uwBd7qTNUmvK2a7wpXIPUCvDOsAi30c8MqNscB7W8cRRw/jhN2LyzYfBDiPmuWQWyfZxc/qwp
 4jmygW3QZlgIeJsBOOeaW0pd1rqQhzuSvpfy/8OtClfbZBwsX5NTNWRjEJnY4jAOvPgxZqXzvWA
 vfS+m0PofnGfdKz8TCWZprZHGAowDydl1NjiIfOOLe+PbSlQVvHRf4qpLW0mWscqDq+nA5tjyU7
 Q9UD2n0yVL3eoZu5N7tMO+yK6Z+bnqtvwqlXo1AychAUbv2Z11xwnBU+u0cGaoo2HhsJK+UtUpG
 FQ=
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4bb88827db0mr368386665e9.30.1795600539001; 
 Wed, 25 Nov 2026 01:55:39 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-c5bc-f938-520e-21e2.ipv6.o2.cz.
 [2a00:1028:8388:a84e:c5bc:f938:520e:21e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm32235573f8f.30.2026.11.25.01.55.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 01:55:38 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] fs/squashfs: Fix reading on big-endian systems
Date: Wed, 25 Nov 2026 10:55:37 +0100
Message-ID: <20261125095537.37979-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Squashfs stores its metadata in little-endian byte order. U-Boot reads
the headers of the inode and directory table blocks, the directory
headers and entries, the fragment table entries and the data block
sizes in host byte order, so on a big-endian system it cannot list a
directory or read a file.

Convert them to host byte order where they are used, as is already done
for the super block and the inodes, and mark the on-disk fields as
little-endian.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Tested on qemu-ppce500 and qemu_arm with a gzip and an uncompressed
image holding a directory of 600 entries, small files in a fragment
block, a sparse file, a hard link and a symlink. ls, size and load now
match the host on both. Before, they all failed on qemu-ppce500. On
qemu_arm the code generated for fs/squashfs does not change.

 fs/squashfs/sqfs.c            | 53 ++++++++++++++++++++---------------
 fs/squashfs/sqfs_filesystem.h | 28 +++++++++---------
 fs/squashfs/sqfs_inode.c      |  2 +-
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 2092e3c1c71..49430f7edfb 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -249,7 +249,7 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	}
 
 	*e = entries[offset];
-	ret = SQFS_COMPRESSED_BLOCK(e->size);
+	ret = SQFS_COMPRESSED_BLOCK(le32_to_cpu(e->size));
 
 out:
 	free(entries);
@@ -557,7 +557,7 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	/* Initialize squashfs_dir_stream members */
 	dirs->table += SQFS_DIR_HEADER_SIZE;
 	dirs->size = get_unaligned_le16(&dir->file_size) - SQFS_DIR_HEADER_SIZE;
-	dirs->entry_count = dirs->dir_header->count + 1;
+	dirs->entry_count = le32_to_cpu(dirs->dir_header->count) + 1;
 
 	/* No path given -> root directory */
 	if (!strcmp(token_list[0], "/")) {
@@ -588,8 +588,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		}
 
 		/* Redefine inode as the found token */
-		new_inode_number = dirs->entry->inode_offset +
-			dirs->dir_header->inode_number;
+		new_inode_number = (s16)le16_to_cpu(dirs->entry->inode_offset) +
+			le32_to_cpu(dirs->dir_header->inode_number);
 
 		/* Get reference to inode in the inode table */
 		table = sqfs_find_inode(dirs->inode_table,
@@ -696,7 +696,7 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 		dirs->table += SQFS_DIR_HEADER_SIZE;
 		dirs->size = get_unaligned_le16(&dir->file_size);
-		dirs->entry_count = dirs->dir_header->count + 1;
+		dirs->entry_count = le32_to_cpu(dirs->dir_header->count) + 1;
 		dirs->size -= SQFS_DIR_HEADER_SIZE;
 		free(dirs->entry);
 		dirs->entry = NULL;
@@ -1065,7 +1065,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 
 	/* Setup directory header */
 	memcpy(dirs->dir_header, dirs->table, SQFS_DIR_HEADER_SIZE);
-	dirs->entry_count = dirs->dir_header->count + 1;
+	dirs->entry_count = le32_to_cpu(dirs->dir_header->count) + 1;
 	dirs->size -= SQFS_DIR_HEADER_SIZE;
 
 	/* Setup entry */
@@ -1135,7 +1135,7 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 			/* Read follow-up (emitted) dir. header */
 			memcpy(dirs->dir_header, dirs->table,
 			       SQFS_DIR_HEADER_SIZE);
-			dirs->entry_count = dirs->dir_header->count + 1;
+			dirs->entry_count = le32_to_cpu(dirs->dir_header->count) + 1;
 			ret = sqfs_read_entry(&dirs->entry, dirs->table +
 					      SQFS_DIR_HEADER_SIZE);
 			if (ret)
@@ -1149,7 +1149,8 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 			return -SQFS_STOP_READDIR;
 	}
 
-	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
+	i_number = le32_to_cpu(dirs->dir_header->inode_number) +
+		(s16)le16_to_cpu(dirs->entry->inode_offset);
 	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
 			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos)
@@ -1158,7 +1159,7 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 	base = (struct squashfs_base_inode *)ipos;
 
 	/* Set entry type and size */
-	switch (dirs->entry->type) {
+	switch (le16_to_cpu(dirs->entry->type)) {
 	case SQFS_DIR_TYPE:
 	case SQFS_LDIR_TYPE:
 		dent->type = FS_DT_DIR;
@@ -1198,11 +1199,12 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 	}
 
 	/* Set entry name (capped at FS_DIRENT_NAME_LEN which is a U-Boot limitation) */
-	name_size = min_t(u16, dirs->entry->name_size + 1, FS_DIRENT_NAME_LEN - 1);
+	name_size = min_t(u16, le16_to_cpu(dirs->entry->name_size) + 1,
+			  FS_DIRENT_NAME_LEN - 1);
 	strncpy(dent->name, dirs->entry->name, name_size);
 	dent->name[name_size] = '\0';
 
-	offset = dirs->entry->name_size + 1 + SQFS_ENTRY_BASE_LENGTH;
+	offset = le16_to_cpu(dirs->entry->name_size) + 1 + SQFS_ENTRY_BASE_LENGTH;
 	dirs->entry_count--;
 
 	/* Decrement size to be read */
@@ -1401,7 +1403,8 @@ static int sqfs_get_regfile_info(struct squashfs_reg_inode *reg,
 		if (ret < 0)
 			return -EINVAL;
 		finfo->comp = ret;
-		if (fentry->size < 1 || fentry->start == 0x7FFFFFFF)
+		if (le32_to_cpu(fentry->size) < 1 ||
+		    le64_to_cpu(fentry->start) == 0x7FFFFFFF)
 			return -EINVAL;
 	} else {
 		datablk_count = DIV_ROUND_UP(finfo->size, le32_to_cpu(blksz));
@@ -1439,7 +1442,8 @@ static int sqfs_get_lregfile_info(struct squashfs_lreg_inode *lreg,
 		if (ret < 0)
 			return -EINVAL;
 		finfo->comp = ret;
-		if (fentry->size < 1 || fentry->start == 0x7FFFFFFF)
+		if (le32_to_cpu(fentry->size) < 1 ||
+		    le64_to_cpu(fentry->start) == 0x7FFFFFFF)
 			return -EINVAL;
 	} else {
 		datablk_count = DIV_ROUND_UP(finfo->size, le32_to_cpu(blksz));
@@ -1512,7 +1516,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		goto out;
 	}
 
-	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
+	i_number = le32_to_cpu(dirs->dir_header->inode_number) +
+		(s16)le16_to_cpu(dirs->entry->inode_offset);
 	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
 			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos) {
@@ -1609,13 +1614,13 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		char *data_buffer;
 
 		start = lldiv(data_offset, ctxt.cur_dev->blksz);
-		table_size = SQFS_BLOCK_SIZE(finfo.blk_sizes[j]);
+		table_size = SQFS_BLOCK_SIZE(le32_to_cpu(finfo.blk_sizes[j]));
 		table_offset = data_offset - (start * ctxt.cur_dev->blksz);
 		n_blks = DIV_ROUND_UP(table_size + table_offset,
 				      ctxt.cur_dev->blksz);
 
 		/* Don't load any data for sparse blocks */
-		if (finfo.blk_sizes[j] == 0) {
+		if (le32_to_cpu(finfo.blk_sizes[j]) == 0) {
 			n_blks = 0;
 			table_offset = 0;
 			data_buffer = NULL;
@@ -1643,14 +1648,14 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		}
 
 		/* Load the data */
-		if (finfo.blk_sizes[j] == 0) {
+		if (le32_to_cpu(finfo.blk_sizes[j]) == 0) {
 			/* This is a sparse block */
 			sparse_size = get_unaligned_le32(&sblk->block_size);
 			if ((*actread + sparse_size) > len)
 				sparse_size = len - *actread;
 			memset(buf + *actread, 0, sparse_size);
 			*actread += sparse_size;
-		} else if (SQFS_COMPRESSED_BLOCK(finfo.blk_sizes[j])) {
+		} else if (SQFS_COMPRESSED_BLOCK(le32_to_cpu(finfo.blk_sizes[j]))) {
 			dest_len = get_unaligned_le32(&sblk->block_size);
 			ret = sqfs_decompress(&ctxt, datablock, &dest_len,
 					      data, table_size);
@@ -1682,9 +1687,10 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		goto out;
 	}
 
-	start = lldiv(frag_entry.start, ctxt.cur_dev->blksz);
-	table_size = SQFS_BLOCK_SIZE(frag_entry.size);
-	table_offset = frag_entry.start - (start * ctxt.cur_dev->blksz);
+	start = lldiv(le64_to_cpu(frag_entry.start), ctxt.cur_dev->blksz);
+	table_size = SQFS_BLOCK_SIZE(le32_to_cpu(frag_entry.size));
+	table_offset = le64_to_cpu(frag_entry.start) -
+		(start * ctxt.cur_dev->blksz);
 	n_blks = DIV_ROUND_UP(table_size + table_offset, ctxt.cur_dev->blksz);
 
 	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size)) {
@@ -1714,7 +1720,7 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 
 		ret = sqfs_decompress(&ctxt, fragment_block, &dest_len,
 				      (void *)fragment  + table_offset,
-				      frag_entry.size);
+				      le32_to_cpu(frag_entry.size));
 		if (ret) {
 			free(fragment_block);
 			goto out;
@@ -1818,7 +1824,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 		goto free_strings;
 	}
 
-	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
+	i_number = le32_to_cpu(dirs->dir_header->inode_number) +
+		(s16)le16_to_cpu(dirs->entry->inode_offset);
 	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
 			       i_number, sblk->inodes, sblk->block_size);
 
diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
index 6c97b2c3a9c..1f9960f5abd 100644
--- a/fs/squashfs/sqfs_filesystem.h
+++ b/fs/squashfs/sqfs_filesystem.h
@@ -81,9 +81,9 @@ struct squashfs_ctxt {
 };
 
 struct squashfs_directory_index {
-	u32 index;
-	u32 start;
-	u32 size;
+	__le32 index;
+	__le32 start;
+	__le32 size;
 	char name[0];
 };
 
@@ -228,23 +228,23 @@ union squashfs_inode {
 };
 
 struct squashfs_directory_entry {
-	u16 offset;
-	s16 inode_offset;
-	u16 type;
-	u16 name_size;
+	__le16 offset;
+	__le16 inode_offset;
+	__le16 type;
+	__le16 name_size;
 	char name[0];
 };
 
 struct squashfs_directory_header {
-	u32 count;
-	u32 start;
-	u32 inode_number;
+	__le32 count;
+	__le32 start;
+	__le32 inode_number;
 };
 
 struct squashfs_fragment_block_entry {
-	u64 start;
-	u32 size;
-	u32 _unused;
+	__le64 start;
+	__le32 size;
+	__le32 _unused;
 };
 
 struct squashfs_dir_stream {
@@ -284,7 +284,7 @@ struct squashfs_file_info {
 	/* File size in bytes (uncompressed) */
 	size_t size;
 	/* Reference to list of data blocks's sizes */
-	u32 *blk_sizes;
+	__le32 *blk_sizes;
 	/* Offset into the fragment block */
 	u32 offset;
 	/* Offset in which the data blocks begin */
diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index 20085f8912b..4cb9205efb5 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -227,7 +227,7 @@ int sqfs_read_metablock(unsigned char *file_mapping, int offset,
 		return -EFAULT;
 	data = file_mapping + offset;
 
-	header = get_unaligned((u16 *)data);
+	header = get_unaligned_le16(data);
 	if (!header)
 		return -EINVAL;
 
-- 
2.54.0 (Apple Git-157)

