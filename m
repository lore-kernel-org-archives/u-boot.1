Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A117BCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B462F8496E;
	Thu, 25 Jun 2026 19:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="scjjvr3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CBC88460E; Thu, 25 Jun 2026 19:24:55 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3418084942
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so1161625e9.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782408291; x=1783013091; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=piTTZmamm86ppzEnntpYmsBy+AEInqXutL5xRyLtkBk=;
 b=scjjvr3UuwKzsJRdSPoemMv8+fIOAUK22eFDtgGgUgDOhuhoV57ZEqoOaPdc902AbD
 A2vwcAAOlMkbg+E3rC0Df0LqNnTV2Te/NREunyDRZ+CHNXbsUG54GQo1Z8pJPEneZTaj
 M5i8LsK4lYdGij44Hu9e5z+vD6PLK4waRxHJu1E9itteCHTMRKsUNdr1N2RA/njkT3ff
 qp33Y8JDE9h6po+76kZ1bOpC01WXFGjHqj17dyZXChalnY8E3x4SORpJS9bU09Fn1bhI
 YuuXicY5XjwAQmTe5myHdB3dOxX/szqg6AumeE9zySeUsyI4OJU2BPALawaMOhKaziyR
 fY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408291; x=1783013091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=piTTZmamm86ppzEnntpYmsBy+AEInqXutL5xRyLtkBk=;
 b=fJsaJuCB3NejMKOBquukO9QjHKTg3fA5siYaVoO2Qe4fZ3XQj4/9FPKvXCtdPEJZjp
 cTzae3H1n0aDWFF9kh9l8VyeO80RqmqkbJnPpEqXpbFdoO/hIOsk6jC8q6oJ5QrYjhl4
 zeVHi+YynxBaUhNa51LEFscb0ZQrvUNnQtnFgX/X08b8f9to2B+ahKpp5EsYFxSyiRfx
 taKsBclsrbZJA61vqtFbRBgjlisQN3CumefDGvsHDYCXwHKI8s/KCoLHnhXyPMVnMm5s
 IcN4g6Bh/gGYep0IP1FJoqdFXWHLpRnIWPhp+sTNuaDpJTleDkGaDiC1o+5aFp/bso6R
 nbsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zd52S/WNjGhKzRg2/RVxddMgopANpKQ/k45FhimZyUDtoFZxOPVhOQsdBSew84CD8EEv5Xbo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5WzRv5lyMc8RGuzdg5fr4tQOKeSOUvjmeeQVVD3mmpbfyABIK
 BykVzQToRrUtO0Nq1oCCX6dzhzylTDME2hNixnY2ZW8PTYQMxgKekm1jBJ4dj8W+HTY=
X-Gm-Gg: AfdE7cnLazNA2W+gFN4Ic8FN5XvbZB443EzwsNJGe8knmz7aI6UO+mThVCplDUyBZLP
 +BcqmRqvqkpT/LfBDBbAIwW5o6E+jxCMhUEptLnbtG3BFxIsWsbgzz4KUydgHB2Ta7zF1bZJUF9
 SCM1dARPt1QI+F9O2D+1tnUxz6aV34+NogaTrQP71SQpGja80NTpklKm/6XkXAi7ixH8pc6k+9+
 i9QZ7Revde01PFjxMWNtcvqRfJNrdWZrq51IweYZCitGvIv15ynrY8DMk9NK0nQW3jFtqgZ+NPJ
 zUTgriTbyXQDdS/OJ4e2EGekaKS773VaDCAi9wvP/WCZaIagYEx6Y99hR2lcjZnpVdn9fkO1fTx
 +AYriHQ6nU43qYFlWV6GAFrGrHX9A1GulEIYvXNSXhKI4MH6fU2whXnYW/ll+uS9xBjglY7I24G
 v9WikueeLql5dzxuK6CjDabsbrl/xyzCq9sf92Lqpe
X-Received: by 2002:a05:600c:a403:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-4926689fab5mr40578555e9.25.1782408290529; 
 Thu, 25 Jun 2026 10:24:50 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492697ba453sm2585755e9.0.2026.06.25.10.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 25 Jun 2026 21:24:21 +0400
Subject: [PATCH 1/2] fs: btrfs: implement opendir(), readdir() and closedir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-btrfs-readdir-v1-1-dd781a2b3965@flipper.net>
References: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
In-Reply-To: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7680; i=alchark@flipper.net;
 h=from:subject:message-id; bh=kXI5wiaoSnj2hlwt4noRC7VoHXl2gfLiESdOeQRQl5o=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZpsQt57KZ1vNr/W5P3vkW02xdk0Pr94mo9xTd/z/9y
 V9VMZ71HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEw15zlGhp4L4bmWG3c2aO4qt0zOsc1K/mpUFBp4Jfp7dvRrnuB3Vxj+CrodWfl
 xxmWZb2e+1el5T3jSeP4FX6b1KpU1Vy494/w9kw8A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Add support for generic directory iteration with opendir(), readdir() and
closedir() in the btrfs filesystem driver, following the ext4fs
implementation for opendir()/closedir() and the btrfs_iter_dir() function
for readdir().

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 fs/btrfs/btrfs.c    | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h    |  2 ++
 fs/btrfs/dir-item.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/fs.c             |  4 ++-
 include/btrfs.h     |  5 +++
 5 files changed, 193 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index f3087f690fa4..c647c8dedf4e 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -9,6 +9,7 @@
 #include <malloc.h>
 #include <u-boot/uuid.h>
 #include <linux/time.h>
+#include <fs.h>
 #include "btrfs.h"
 #include "crypto/hash.h"
 #include "disk-io.h"
@@ -159,6 +160,97 @@ int btrfs_ls(const char *path)
 	return 0;
 }
 
+struct btrfs_dir_stream {
+	struct fs_dir_stream parent;
+	struct fs_dirent dirent;
+	char *dirname;
+	u64 offset;
+};
+
+int btrfs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
+{
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct btrfs_dir_stream *dirs;
+	struct btrfs_root *root;
+	u64 ino;
+	u8 type;
+	int ret;
+
+	*dirsp = NULL;
+	ASSERT(fs_info);
+
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				dirname, &root, &ino, &type, 40);
+	if (ret < 0)
+		return ret;
+	if (type != BTRFS_FT_DIR)
+		return -ENOTDIR;
+
+	dirs = calloc(1, sizeof(*dirs));
+	if (!dirs)
+		return -ENOMEM;
+	dirs->dirname = strdup(dirname);
+	if (!dirs->dirname) {
+		free(dirs);
+		return -ENOMEM;
+	}
+
+	*dirsp = (struct fs_dir_stream *)dirs;
+	return 0;
+}
+
+int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
+{
+	struct btrfs_dir_stream *dirs = (struct btrfs_dir_stream *)fs_dirs;
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct fs_dirent *dent = &dirs->dirent;
+	struct btrfs_root *root;
+	u64 ino;
+	u8 type;
+	int ret;
+
+	*dentp = NULL;
+	ASSERT(fs_info);
+
+	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
+				dirs->dirname, &root, &ino, &type, 40);
+	if (ret < 0)
+		return ret;
+	if (type != BTRFS_FT_DIR)
+		return -ENOTDIR;
+
+	memset(dent, 0, sizeof(*dent));
+	ret = btrfs_next_dir_entry(root, ino, &dirs->offset, dent->name,
+				   sizeof(dent->name), &type);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return -ENOENT;
+
+	switch (type) {
+	case BTRFS_FT_DIR:
+		dent->type = FS_DT_DIR;
+		break;
+	case BTRFS_FT_SYMLINK:
+		dent->type = FS_DT_LNK;
+		break;
+	default:
+		dent->type = FS_DT_REG;
+		break;
+	}
+
+	*dentp = dent;
+	return 0;
+}
+
+void btrfs_closedir(struct fs_dir_stream *fs_dirs)
+{
+	struct btrfs_dir_stream *dirs = (struct btrfs_dir_stream *)fs_dirs;
+
+	free(dirs->dirname);
+	free(dirs);
+}
+
 int btrfs_exists(const char *file)
 {
 	struct btrfs_fs_info *fs_info = current_fs_info;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b7be09d5df83..7de35aa7efd5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1225,6 +1225,8 @@ typedef int (*btrfs_iter_dir_callback_t)(struct btrfs_root *root,
 					 struct btrfs_dir_item *di);
 int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
 		   btrfs_iter_dir_callback_t callback);
+int btrfs_next_dir_entry(struct btrfs_root *root, u64 ino, u64 *offset,
+			 char *namebuf, int namebuf_len, u8 *ftype);
 /* inode.c */
 int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filename,
 			struct btrfs_root **root_ret, u64 *ino_ret,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 5f81d6414f06..8cf5be3790e7 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -166,3 +166,94 @@ out:
 	btrfs_release_path(&path);
 	return ret;
 }
+
+/*
+ * btrfs_next_dir_entry() - read one directory entry at or after a cursor
+ *
+ * Streaming counterpart to btrfs_iter_dir() for the fs-layer readdir, which
+ * is re-entered once per entry: returns the first real entry whose
+ * BTRFS_DIR_INDEX_KEY offset is >= *offset and advances *offset past it.
+ *
+ * @root, @ino:		directory to read
+ * @offset:		in/out cursor; DIR_INDEX offset to resume from
+ * @namebuf:		caller buffer that receives the NUL-terminated name
+ * @namebuf_len:	size of @namebuf in bytes
+ * @ftype:		receives the BTRFS_FT_* type of the entry
+ *
+ * Return: 0 if an entry was returned, 1 when the directory is exhausted,
+ *	   -ve on error.
+ */
+int btrfs_next_dir_entry(struct btrfs_root *root, u64 ino, u64 *offset,
+			 char *namebuf, int namebuf_len, u8 *ftype)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = ino;
+	key.type = BTRFS_DIR_INDEX_KEY;
+	key.offset = *offset;
+
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	while (1) {
+		struct btrfs_dir_item *di;
+		int name_len;
+		u8 type;
+
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+			ret = btrfs_next_leaf(root, &path);
+			if (ret < 0)
+				goto out;
+			if (ret > 0) {		/* end of tree */
+				ret = 1;
+				goto out;
+			}
+		}
+
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.objectid != ino || key.type != BTRFS_DIR_INDEX_KEY) {
+			ret = 1;		/* no more entries for this dir */
+			goto out;
+		}
+
+		di = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_dir_item);
+		if (verify_dir_item(root, path.nodes[0], di)) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+
+		*offset = key.offset + 1;
+		type = btrfs_dir_type(path.nodes[0], di);
+
+		/* XATTRs share the key space but are not directory entries. */
+		if (type == BTRFS_FT_XATTR) {
+			ret = btrfs_next_item(root, &path);
+			if (ret < 0)
+				goto out;
+			if (ret > 0) {
+				ret = 1;
+				goto out;
+			}
+			continue;
+		}
+
+		name_len = btrfs_dir_name_len(path.nodes[0], di);
+		if (name_len > namebuf_len - 1)
+			name_len = namebuf_len - 1;
+		read_extent_buffer(path.nodes[0], namebuf,
+				   (unsigned long)(di + 1), name_len);
+		namebuf[name_len] = '\0';
+		*ftype = type;
+		ret = 0;
+		goto out;
+	}
+
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
diff --git a/fs/fs.c b/fs/fs.c
index 8ea50a6c13c4..4694a88f776b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -326,7 +326,9 @@ static struct fstype_info fstypes[] = {
 		.read = btrfs_read,
 		.write = fs_write_unsupported,
 		.uuid = btrfs_uuid,
-		.opendir = fs_opendir_unsupported,
+		.opendir = btrfs_opendir,
+		.readdir = btrfs_readdir,
+		.closedir = btrfs_closedir,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 		.ln = fs_ln_unsupported,
diff --git a/include/btrfs.h b/include/btrfs.h
index 2d73add18e09..6fff45a497ee 100644
--- a/include/btrfs.h
+++ b/include/btrfs.h
@@ -10,6 +10,8 @@
 
 struct blk_desc;
 struct disk_partition;
+struct fs_dir_stream;
+struct fs_dirent;
 
 int btrfs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition);
@@ -20,5 +22,8 @@ int btrfs_read(const char *, void *, loff_t, loff_t, loff_t *);
 void btrfs_close(void);
 int btrfs_uuid(char *);
 void btrfs_list_subvols(void);
+int btrfs_opendir(const char *filename, struct fs_dir_stream **dirsp);
+int btrfs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+void btrfs_closedir(struct fs_dir_stream *dirs);
 
 #endif /* __U_BOOT_BTRFS_H__ */

-- 
2.53.0

