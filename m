Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10114C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3318874F;
	Fri, 12 Jul 2024 10:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F1288765; Fri, 12 Jul 2024 10:24:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 623328871F
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 3A80B61966A5;
 Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ud07MbS9DpOs; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id C7B7861966A3;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 03ZMVlycBD0C; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 72D6F6195FC4;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/4] squashfs: Check sqfs_find_inode() return value
Date: Fri, 12 Jul 2024 10:23:43 +0200
Message-Id: <20240712082344.8655-3-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240712082344.8655-1-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

The function can fail and return NULL.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/squashfs/sqfs.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 16a07c0622..fa99d514f2 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -474,6 +474,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream=
 *dirs, char **token_list,
 	/* Start by root inode */
 	table =3D sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
 				sblk->inodes, sblk->block_size);
+	if (!table)
+		return -EINVAL;
=20
 	dir =3D (struct squashfs_dir_inode *)table;
 	ldir =3D (struct squashfs_ldir_inode *)table;
@@ -529,6 +531,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream=
 *dirs, char **token_list,
 		/* Get reference to inode in the inode table */
 		table =3D sqfs_find_inode(dirs->inode_table, new_inode_number,
 					sblk->inodes, sblk->block_size);
+		if (!table)
+			return -EINVAL;
 		dir =3D (struct squashfs_dir_inode *)table;
=20
 		/* Check for symbolic link and inode type sanity */
@@ -1025,6 +1029,8 @@ int sqfs_readdir(struct fs_dir_stream *fs_dirs, str=
uct fs_dirent **dentp)
 	i_number =3D dirs->dir_header->inode_number + dirs->entry->inode_offset=
;
 	ipos =3D sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
 			       sblk->block_size);
+	if (!ipos)
+		return -SQFS_STOP_READDIR;
=20
 	base =3D (struct squashfs_base_inode *)ipos;
=20
@@ -1381,6 +1387,10 @@ int sqfs_read(const char *filename, void *buf, lof=
f_t offset, loff_t len,
 	i_number =3D dirs->dir_header->inode_number + dirs->entry->inode_offset=
;
 	ipos =3D sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
 			       sblk->block_size);
+	if (!ipos) {
+		ret =3D -EINVAL;
+		goto out;
+	}
=20
 	base =3D (struct squashfs_base_inode *)ipos;
 	switch (get_unaligned_le16(&base->inode_type)) {
@@ -1629,6 +1639,13 @@ int sqfs_size(const char *filename, loff_t *size)
 	i_number =3D dirs->dir_header->inode_number + dirs->entry->inode_offset=
;
 	ipos =3D sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
 			       sblk->block_size);
+
+	if (!ipos) {
+		*size =3D 0;
+		ret =3D -EINVAL;
+		goto free_strings;
+	}
+
 	free(dirs->entry);
 	dirs->entry =3D NULL;
=20
--=20
2.35.3

