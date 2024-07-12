Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B193C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF7D88780;
	Fri, 12 Jul 2024 10:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D023488765; Fri, 12 Jul 2024 10:24:00 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930AE8874E
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 6FA2A61966A3;
 Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id VaUoQMlWIVJf; Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id EEC6561966A1;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id b6r8ZKpRecmg; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id AD1656195FFC;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/4] squashfs: Fix stack overflow while symlink resolving
Date: Fri, 12 Jul 2024 10:23:44 +0200
Message-Id: <20240712082344.8655-4-richard@nod.at>
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

The squashfs driver blindly follows symlinks, and calls sqfs_size()
recursively. So an attacker can create a crafted filesystem and with
a deep enough nesting level a stack overflow can be achieved.

Fix by limiting the nesting level to 8.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/squashfs/sqfs.c | 74 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index fa99d514f2..3b23c5bc8f 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -25,6 +25,9 @@
 #include "sqfs_utils.h"
=20
 static struct squashfs_ctxt ctxt;
+static int symlinknest;
+
+static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_di=
rent **dentp);
=20
 static int sqfs_disk_read(__u32 block, __u32 nr_blocks, void *buf)
 {
@@ -510,7 +513,7 @@ static int sqfs_search_dir(struct squashfs_dir_stream=
 *dirs, char **token_list,
 			goto out;
 		}
=20
-		while (!sqfs_readdir(dirsp, &dent)) {
+		while (!sqfs_readdir_nest(dirsp, &dent)) {
 			ret =3D strcmp(dent->name, token_list[j]);
 			if (!ret)
 				break;
@@ -537,6 +540,11 @@ static int sqfs_search_dir(struct squashfs_dir_strea=
m *dirs, char **token_list,
=20
 		/* Check for symbolic link and inode type sanity */
 		if (get_unaligned_le16(&dir->inode_type) =3D=3D SQFS_SYMLINK_TYPE) {
+			if (++symlinknest =3D=3D 8) {
+				ret =3D -ELOOP;
+				goto out;
+			}
+
 			sym =3D (struct squashfs_symlink_inode *)table;
 			/* Get first j + 1 tokens */
 			path =3D sqfs_concat_tokens(token_list, j + 1);
@@ -884,7 +892,7 @@ out:
 	return metablks_count;
 }
=20
-int sqfs_opendir(const char *filename, struct fs_dir_stream **dirsp)
+static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream =
**dirsp)
 {
 	unsigned char *inode_table =3D NULL, *dir_table =3D NULL;
 	int j, token_count =3D 0, ret =3D 0, metablks_count;
@@ -979,7 +987,19 @@ out:
 	return ret;
 }
=20
+int sqfs_opendir(const char *filename, struct fs_dir_stream **dirsp)
+{
+	symlinknest =3D 0;
+	return sqfs_opendir_nest(filename, dirsp);
+}
+
 int sqfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp=
)
+{
+	symlinknest =3D 0;
+	return sqfs_readdir_nest(fs_dirs, dentp);
+}
+
+static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_di=
rent **dentp)
 {
 	struct squashfs_super_block *sblk =3D ctxt.sblk;
 	struct squashfs_dir_stream *dirs;
@@ -1325,8 +1345,8 @@ static int sqfs_get_lregfile_info(struct squashfs_l=
reg_inode *lreg,
 	return datablk_count;
 }
=20
-int sqfs_read(const char *filename, void *buf, loff_t offset, loff_t len=
,
-	      loff_t *actread)
+static int sqfs_read_nest(const char *filename, void *buf, loff_t offset=
,
+			  loff_t len, loff_t *actread)
 {
 	char *dir =3D NULL, *fragment_block, *datablock =3D NULL;
 	char *fragment =3D NULL, *file =3D NULL, *resolved, *data;
@@ -1356,11 +1376,11 @@ int sqfs_read(const char *filename, void *buf, lo=
ff_t offset, loff_t len,
 	}
=20
 	/*
-	 * sqfs_opendir will uncompress inode and directory tables, and will
+	 * sqfs_opendir_nest will uncompress inode and directory tables, and wi=
ll
 	 * return a pointer to the directory that contains the requested file.
 	 */
 	sqfs_split_path(&file, &dir, filename);
-	ret =3D sqfs_opendir(dir, &dirsp);
+	ret =3D sqfs_opendir_nest(dir, &dirsp);
 	if (ret) {
 		goto out;
 	}
@@ -1368,7 +1388,7 @@ int sqfs_read(const char *filename, void *buf, loff=
_t offset, loff_t len,
 	dirs =3D (struct squashfs_dir_stream *)dirsp;
=20
 	/* For now, only regular files are able to be loaded */
-	while (!sqfs_readdir(dirsp, &dent)) {
+	while (!sqfs_readdir_nest(dirsp, &dent)) {
 		ret =3D strcmp(dent->name, file);
 		if (!ret)
 			break;
@@ -1421,9 +1441,14 @@ int sqfs_read(const char *filename, void *buf, lof=
f_t offset, loff_t len,
 		break;
 	case SQFS_SYMLINK_TYPE:
 	case SQFS_LSYMLINK_TYPE:
+		if (++symlinknest =3D=3D 8) {
+			ret =3D -ELOOP;
+			goto out;
+		}
+
 		symlink =3D (struct squashfs_symlink_inode *)ipos;
 		resolved =3D sqfs_resolve_symlink(symlink, filename);
-		ret =3D sqfs_read(resolved, buf, offset, len, actread);
+		ret =3D sqfs_read_nest(resolved, buf, offset, len, actread);
 		free(resolved);
 		goto out;
 	case SQFS_BLKDEV_TYPE:
@@ -1594,7 +1619,14 @@ out:
 	return ret;
 }
=20
-int sqfs_size(const char *filename, loff_t *size)
+int sqfs_read(const char *filename, void *buf, loff_t offset, loff_t len=
,
+	      loff_t *actread)
+{
+	symlinknest =3D 0;
+	return sqfs_read_nest(filename, buf, offset, len, actread);
+}
+
+static int sqfs_size_nest(const char *filename, loff_t *size)
 {
 	struct squashfs_super_block *sblk =3D ctxt.sblk;
 	struct squashfs_symlink_inode *symlink;
@@ -1610,10 +1642,10 @@ int sqfs_size(const char *filename, loff_t *size)
=20
 	sqfs_split_path(&file, &dir, filename);
 	/*
-	 * sqfs_opendir will uncompress inode and directory tables, and will
+	 * sqfs_opendir_nest will uncompress inode and directory tables, and wi=
ll
 	 * return a pointer to the directory that contains the requested file.
 	 */
-	ret =3D sqfs_opendir(dir, &dirsp);
+	ret =3D sqfs_opendir_nest(dir, &dirsp);
 	if (ret) {
 		ret =3D -EINVAL;
 		goto free_strings;
@@ -1621,7 +1653,7 @@ int sqfs_size(const char *filename, loff_t *size)
=20
 	dirs =3D (struct squashfs_dir_stream *)dirsp;
=20
-	while (!sqfs_readdir(dirsp, &dent)) {
+	while (!sqfs_readdir_nest(dirsp, &dent)) {
 		ret =3D strcmp(dent->name, file);
 		if (!ret)
 			break;
@@ -1661,6 +1693,11 @@ int sqfs_size(const char *filename, loff_t *size)
 		break;
 	case SQFS_SYMLINK_TYPE:
 	case SQFS_LSYMLINK_TYPE:
+		if (++symlinknest =3D=3D 8) {
+			*size =3D 0;
+			return -ELOOP;
+		}
+
 		symlink =3D (struct squashfs_symlink_inode *)ipos;
 		resolved =3D sqfs_resolve_symlink(symlink, filename);
 		ret =3D sqfs_size(resolved, size);
@@ -1700,10 +1737,11 @@ int sqfs_exists(const char *filename)
=20
 	sqfs_split_path(&file, &dir, filename);
 	/*
-	 * sqfs_opendir will uncompress inode and directory tables, and will
+	 * sqfs_opendir_nest will uncompress inode and directory tables, and wi=
ll
 	 * return a pointer to the directory that contains the requested file.
 	 */
-	ret =3D sqfs_opendir(dir, &dirsp);
+	symlinknest =3D 0;
+	ret =3D sqfs_opendir_nest(dir, &dirsp);
 	if (ret) {
 		ret =3D -EINVAL;
 		goto free_strings;
@@ -1711,7 +1749,7 @@ int sqfs_exists(const char *filename)
=20
 	dirs =3D (struct squashfs_dir_stream *)dirsp;
=20
-	while (!sqfs_readdir(dirsp, &dent)) {
+	while (!sqfs_readdir_nest(dirsp, &dent)) {
 		ret =3D strcmp(dent->name, file);
 		if (!ret)
 			break;
@@ -1728,6 +1766,12 @@ free_strings:
 	return ret =3D=3D 0;
 }
=20
+int sqfs_size(const char *filename, loff_t *size)
+{
+	symlinknest =3D 0;
+	return sqfs_size_nest(filename, size);
+}
+
 void sqfs_close(void)
 {
 	sqfs_decompressor_cleanup(&ctxt);
--=20
2.35.3

