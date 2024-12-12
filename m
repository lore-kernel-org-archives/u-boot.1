Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5691EE7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD80C80212;
	Thu, 12 Dec 2024 23:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gerz.io header.i=@gerz.io header.b="devmGxzn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCB480196; Thu, 12 Dec 2024 23:06:56 +0100 (CET)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A54A801BD
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gerz.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=burak@gerz.io
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4Y8RQQ1gRMz64CS;
 Thu, 12 Dec 2024 23:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerz.io; s=key2;
 t=1734041214; bh=fFjuS/vs5ZTO6f7tJZJj3yo238QRirhBXyL8BX3399w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=devmGxznwiSGtRDXuY8qmRMyjiPKF2bdee3Y+td1IqdyHeE0FjucZFinaDkuPgvLS
 +3L9ao9hO6TmNoM6Hjm8sj4QZvTlLOSKK8UWv+thUSa8ewFExEIt9nvGcnjVf3CDcB
 /vWYt661Xk2+bK+SX4xYJ4TAqUajyWvYMljGqGOgEoyJyqcVwI9UOCQFJbNS8FQ+4w
 cYX9qOvsNtwVJOql8tBcJe+hXnxLW05wTyih7ToCBW2DnglXNhrxhiDBn/Xa+41u0S
 k7GcqAOxslWWbMBxm2pOgpTmB+8rhK9MQzdGMbSg9+wPiJgBAaFArHxPG7bet0XIo4
 dsNj5rr0LxkQw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4Y8RQQ0y1cz4xJB;
 Thu, 12 Dec 2024 23:06:54 +0100 (CET)
Received: from mx2e3f.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4Y8RQP6Gzsz8sWg;
 Thu, 12 Dec 2024 23:06:53 +0100 (CET)
Received: from localhost.localdomain (adsl-84-227-222-208.adslplus.ch
 [84.227.222.208])
 by mx2e3f.netcup.net (Postfix) with ESMTPSA id EC27960134;
 Thu, 12 Dec 2024 23:06:48 +0100 (CET)
Authentication-Results: mx2e3f;
 spf=pass (sender IP is 84.227.222.208) smtp.mailfrom=burak@gerz.io
 smtp.helo=localhost.localdomain
Received-SPF: pass (mx2e3f: connection is authenticated)
From: Burak Gerz <burak@gerz.io>
To: u-boot@lists.denx.de
Cc: Daniel.Venzin@mt.com, eballetb@redhat.com, manut@mecka.net, burak@gerz.io,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] fs: fat: Implement FAT file rename
Date: Thu, 12 Dec 2024 23:06:29 +0100
Message-ID: <20241212220635.25971-3-burak@gerz.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212220635.25971-1-burak@gerz.io>
References: <20241212220635.25971-1-burak@gerz.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <173404120965.21133.13905482751660335505@mx2e3f.netcup.net>
X-Rspamd-Queue-Id: EC27960134
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: klvABu6bt/HCOCHllpp4/iw0Hez/lKQkMAL+Ce4=
X-Mailman-Approved-At: Thu, 12 Dec 2024 23:08:35 +0100
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

Implement a simple FAT file rename.

Signed-off-by: Burak Gerz <burak@gerz.io>

---

 fs/fat/fat_write.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fs.c            | 30 ++++++++++++++
 include/fat.h      |  1 +
 include/fs.h       |  2 +
 4 files changed, 132 insertions(+)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index ea877ee917..acd0e22652 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1813,3 +1813,102 @@ exit:
 	free(dotdent);
 	return ret;
 }
+
+int file_fat_rename(const char *path, const char *new_filename)
+{
+	char *dirname, *basename;
+	char path_copy[VFAT_MAXLEN_BYTES];
+	char new_path[VFAT_MAXLEN_BYTES];
+	dir_entry *dentry_src, *dentry_dst;
+	fsdata src_datablock = { .fatbuf = NULL };
+	fsdata dst_datablock = { .fatbuf = NULL };
+	fat_itr *src_itr = NULL;
+	fat_itr *dst_itr = NULL;
+	loff_t actwrite;
+	int ret;
+	void *buffer = &actwrite;
+
+	if (strlen(new_filename) > VFAT_MAXLEN_BYTES)
+		return -EINVAL;
+	strcpy(path_copy, path);
+	split_filename(path_copy, &dirname, &basename);
+	strcpy(new_path, dirname);
+	strcat(new_path, "/");
+	strcat(new_path, new_filename);
+	src_itr = malloc_cache_aligned(sizeof(*src_itr));
+		if (!src_itr)
+			goto exit;
+	dst_itr = malloc_cache_aligned(sizeof(*dst_itr));
+		if (!dst_itr)
+			goto exit;
+	ret = fat_itr_root(src_itr, &src_datablock);
+	if (ret)
+		goto exit;
+	ret = fat_itr_root(dst_itr, &dst_datablock);
+	if (ret)
+		goto exit;
+	ret = fat_itr_resolve(src_itr, dirname, TYPE_DIR);
+	if (ret)
+		goto exit;
+	dentry_src = find_directory_entry(src_itr, (char *)basename);
+	if (!dentry_src)
+		goto exit;
+
+	dst_datablock.fatbuf = NULL;
+	fat_itr_root(dst_itr, &dst_datablock);
+	ret = fat_itr_resolve(dst_itr, dirname, TYPE_DIR);
+	if (ret)
+		goto exit;
+	dentry_dst = find_directory_entry(dst_itr, (char *)new_filename);
+	if (dentry_dst)
+		goto exit;
+	ret = file_fat_write(new_path, buffer, 0, 0, &actwrite);
+	if (ret)
+		goto exit;
+	dst_datablock.fatbuf = NULL;
+	fat_itr_root(dst_itr, &dst_datablock);
+	ret = fat_itr_resolve(dst_itr, dirname, TYPE_DIR);
+	if (ret)
+		goto exit;
+	dentry_dst = find_directory_entry(dst_itr, (char *)new_filename);
+	if (!dentry_dst)
+		goto exit;
+	dentry_dst->starthi = dentry_src->starthi;
+	dentry_dst->start = dentry_src->start;
+	dentry_dst->size = dentry_src->size;
+	ret = flush_dir(dst_itr);
+	if (ret)
+		return -1;
+	src_datablock.fatbuf = NULL;
+	ret = fat_itr_root(src_itr, &src_datablock);
+	if (ret)
+		goto exit;
+	ret = fat_itr_resolve(src_itr, dirname, TYPE_DIR);
+	if (ret)
+		goto exit;
+	dentry_src = find_directory_entry(src_itr, (char *)basename);
+	if (!dentry_src)
+		goto exit;
+	dir_entry *dent = src_itr->dent;
+
+	if (src_itr->clust != src_itr->dent_clust) {
+		ret = fat_move_to_cluster(src_itr, src_itr->dent_clust);
+		if (ret)
+			goto exit;
+	}
+	src_itr->dent = src_itr->dent_start;
+	src_itr->remaining = src_itr->dent_rem;
+	dent = src_itr->dent_start;
+	if ((dent->attr & ATTR_VFAT) == ATTR_VFAT &&
+	    (dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
+		ret = delete_long_name(src_itr);
+		if (ret)
+			goto exit;
+	}
+	delete_single_dentry(src_itr);
+	ret = flush_dir(src_itr);
+exit:
+	free(src_itr);
+	free(dst_itr);
+	return ret;
+}
diff --git a/fs/fs.c b/fs/fs.c
index 21a23efd93..3024bd2cec 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -118,6 +118,11 @@ static inline int fs_ln_unsupported(const char *filename, const char *target)
 	return -1;
 }
 
+static inline int fs_rename_unsupported(const char *filename, const char *target)
+{
+	return -1;
+}
+
 static inline void fs_close_unsupported(void)
 {
 }
@@ -183,6 +188,7 @@ struct fstype_info {
 	int (*unlink)(const char *filename);
 	int (*mkdir)(const char *dirname);
 	int (*ln)(const char *filename, const char *target);
+	int (*rename)(const char *old_filename_path, const char *new_filename);
 };
 
 static struct fstype_info fstypes[] = {
@@ -201,6 +207,7 @@ static struct fstype_info fstypes[] = {
 		.write = file_fat_write,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
+		.rename = file_fat_rename,
 #else
 		.write = fs_write_unsupported,
 		.unlink = fs_unlink_unsupported,
@@ -222,6 +229,7 @@ static struct fstype_info fstypes[] = {
 		.probe = ext4fs_probe,
 		.close = ext4fs_close,
 		.ls = fs_ls_generic,
+		.rename = fs_rename_unsupported,
 		.exists = ext4fs_exists,
 		.size = ext4fs_size,
 		.read = ext4_read_file,
@@ -247,6 +255,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = true,
 		.probe = sandbox_fs_set_blk_dev,
 		.close = sandbox_fs_close,
+		.rename = fs_rename_unsupported,
 		.ls = sandbox_fs_ls,
 		.exists = sandbox_fs_exists,
 		.size = sandbox_fs_size,
@@ -266,6 +275,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = true,
 		.probe = smh_fs_set_blk_dev,
 		.close = fs_close_unsupported,
+		.rename = fs_rename_unsupported,
 		.ls = fs_ls_unsupported,
 		.exists = fs_exists_unsupported,
 		.size = smh_fs_size,
@@ -284,6 +294,7 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_UBIFS,
 		.name = "ubifs",
 		.null_dev_desc_ok = true,
+		.rename = fs_rename_unsupported,
 		.probe = ubifs_set_blk_dev,
 		.close = ubifs_close,
 		.ls = ubifs_ls,
@@ -305,6 +316,7 @@ static struct fstype_info fstypes[] = {
 		.fstype = FS_TYPE_BTRFS,
 		.name = "btrfs",
 		.null_dev_desc_ok = false,
+		.rename = fs_rename_unsupported,
 		.probe = btrfs_probe,
 		.close = btrfs_close,
 		.ls = btrfs_ls,
@@ -327,6 +339,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = false,
 		.probe = sqfs_probe,
 		.opendir = sqfs_opendir,
+		.rename = fs_rename_unsupported,
 		.readdir = sqfs_readdir,
 		.ls = fs_ls_generic,
 		.read = sqfs_read,
@@ -348,6 +361,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = false,
 		.probe = erofs_probe,
 		.opendir = erofs_opendir,
+		.rename = fs_rename_unsupported,
 		.readdir = erofs_readdir,
 		.ls = fs_ls_generic,
 		.read = erofs_read,
@@ -369,6 +383,7 @@ static struct fstype_info fstypes[] = {
 		.probe = fs_probe_unsupported,
 		.close = fs_close_unsupported,
 		.ls = fs_ls_unsupported,
+		.rename = fs_rename_unsupported,
 		.exists = fs_exists_unsupported,
 		.size = fs_size_unsupported,
 		.read = fs_read_unsupported,
@@ -697,6 +712,21 @@ int fs_mkdir(const char *dirname)
 	return ret;
 }
 
+int fs_rename(const char *path, const char *new_filename)
+{
+	struct fstype_info *info = fs_get_info(fs_type);
+	int ret;
+
+	ret = info->rename(path, new_filename);
+	if (ret < 0) {
+		log_err("** Unable to rename from %s to %s **\n", path, new_filename);
+	    ret = -1;
+	}
+	fs_close();
+
+	return ret;
+}
+
 int fs_ln(const char *fname, const char *target)
 {
 	struct fstype_info *info = fs_get_info(fs_type);
diff --git a/include/fat.h b/include/fat.h
index 3dce99a23c..1155e59c68 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -208,6 +208,7 @@ void fat_closedir(struct fs_dir_stream *dirs);
 int fat_unlink(const char *filename);
 int fat_mkdir(const char *dirname);
 void fat_close(void);
+int file_fat_rename(const char *filename, const char *buffer);
 void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
 
 /**
diff --git a/include/fs.h b/include/fs.h
index 2474880385..c8d0eb41c9 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -165,6 +165,8 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 	     loff_t *actwrite);
 
+int fs_rename(const char *path, const char *filename);
+
 /*
  * Directory entry types, matches the subset of DT_x in posix readdir()
  * which apply to u-boot.
-- 
2.45.2

