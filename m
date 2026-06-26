Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B6DC43327
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A9E84979;
	Fri, 26 Jun 2026 17:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="ZmIMA2Gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C69384979; Fri, 26 Jun 2026 17:18:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0D084704
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46fe472da0dso138898f8f.1
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782487132; x=1783091932; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35V2vQTLQLhmqsePEl2RESRQ9L4/O/tEro/g7K/1jlQ=;
 b=ZmIMA2Gztl994JWDDqUPNnI1KNM4e7PY9K533PSXYDNl9/P+x45o2iCQxxAwES5th5
 y6A678SWpmBy4/GOI2nO4UJnanoTfl+7PuUOaoASBlDqDQWJzr6LUKCI84BzPTeSnPgA
 nEWpRT0njR8Je3uww86HwFt1PoQ5xXvqH16ro/8j1+EH1q6l/D226N2MrlDSCjO9tXhg
 Wi++kP0gIAc4Jz9br/yiUQruHeCzCu/Gl2XerYxN+jQbUePU9B4tNYSRQTD3p+iQZF20
 ENsbLbSJgUczcEpMGaY0NuOB5suyGCAulTbMnl6AuEo3EFiyWFCP0gakHFyRWYCV9oOu
 ZhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487132; x=1783091932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=35V2vQTLQLhmqsePEl2RESRQ9L4/O/tEro/g7K/1jlQ=;
 b=T0Ir99C8A8mKRFbgjw+uVydz8Iwp1EGMAt7rBEeG4ZMPra0yU+PZjZA9Ke8DFQIZG3
 HsiJ+9I6SzzEXZGfPMJhT1Zo8MYkaYtgOhtWBhv1XXYFUlde92jTv8UCAWSmANsRYrbi
 I4YHNviRTTat7leKfxXuGOPqH5h9z6ZLlUh9cLG1iJBDXzI8hMZY+mXm6Y818gdVbx8j
 LyrpRSnlGj7hJP4B3/d8HdEgSMwvHHBBjMIc1N3ip2CALW00n3B204baq/P9JbbcAfnO
 OGW0IMm3FWJJ2FLA924QcDs5O0i16MNvCvuKnmm3xy8bqnq4Qg/d+XPxvw4ZGiLnlDQ4
 6cFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYnThbRxzpOQ7ZgT96+NzrQKO7fWaGo72GprFhdzriIoOOn/iBoR/qjhAlsIJs+2Fu6uJ2VN4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz0+E9rqosfnQHstbGxC/rkRqN781azLRFI7B5eyPdcSYFYN7ci
 yDIobti57WjROSgKq0AGzMRLEHDtMvKxJoHnhyEw8GBi0BHajxOJNUz+FdcP6IyNXMs=
X-Gm-Gg: AfdE7clWLajzxRZ8Q3RpA5UdAN/R+Ow8FAOxd9xpoTlqi/VRDglZ1mehb7JA940KcoC
 1uWW66Dh0pjQ2XTgQXnk3v9rev0Dncn9+jRHGFf6z+3qGeAPV8LBoCW9YYmfIxHzRdzSRIw1Kuk
 YpO33rjA8xCoGUKJeoRNS+cox77M1Ln4A27YojCx4al4gcGhXPMM2rqNBGtA7xf2ubRqECpmOB4
 yLHn8kKoghJBWxzWyzoVPpkI+l4bdyxczxbYKzdT+XhIRm6+iUDR6k6ZXYjBShFeLu5BubcATB7
 t28KiSnD88nWwVVdNDukNnhr7WarSwxfoiK7s3LW8KyJxDbGHBL7JjBTT30x+mn92lhM/z790wF
 eN1z2OQtsWGzOtEj63onkH3LwGe671XLeBW49tVtB/aTNW+LUoTC4ztZ6NT05frWccMOUwO5OVS
 oJhC5+yR5XoNb6lI1yeLsYen+EqX4lUA==
X-Received: by 2002:a05:6000:4698:b0:46f:a0f1:c33f with SMTP id
 ffacd0b85a97d-46fa0f1c3e4mr1591478f8f.32.1782487131738; 
 Fri, 26 Jun 2026 08:18:51 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d998esm24860736f8f.24.2026.06.26.08.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:18:51 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 26 Jun 2026 19:18:21 +0400
Subject: [PATCH v2 1/2] fs: btrfs: implement opendir(), readdir() and
 closedir()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-btrfs-readdir-v2-1-7dd43f72d1b4@flipper.net>
References: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
In-Reply-To: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7680; i=alchark@flipper.net;
 h=from:subject:message-id; bh=9vAmWS9ZXq+LRpD282fup88uVT5fQflHpn5EzE0P40U=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZzQjPjv8ks26JkZ5bxS+jab+NT32dIO2ZoLbH+JDAf
 e7NE+emdUxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVbHcZGd7JLBPlc9TkfNP5hWX/wR0au6dmlx+8mrLwSsyJapF1nW8YGVaFBoi
 9PKzV5F9/+GWCj0JIOTvfg+j/EZeunlbr28kQxQMA
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
closedir() in the btrfs filesystem driver.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 fs/btrfs/btrfs.c    | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h    |  2 ++
 fs/btrfs/dir-item.c | 73 +++++++++++++++++++++++++++++++++++++++
 fs/fs.c             |  4 ++-
 include/btrfs.h     |  5 +++
 5 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index f3087f690fa4..6f034861da90 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -8,7 +8,9 @@
 #include <config.h>
 #include <malloc.h>
 #include <u-boot/uuid.h>
+#include <linux/kernel.h>
 #include <linux/time.h>
+#include <fs.h>
 #include "btrfs.h"
 #include "crypto/hash.h"
 #include "disk-io.h"
@@ -159,6 +161,102 @@ int btrfs_ls(const char *path)
 	return 0;
 }
 
+/*
+ * The fs layer closes and re-probes btrfs between readdir() calls (see
+ * fs_readdir() in fs/fs.c), freeing and reallocating fs_info, so root cannot
+ * be stored directly. The subvolume id and inode number are stable though, so
+ * re-resolve the root from the current fs_info by subvolume id, which avoids
+ * a full path walk and is much faster.
+ */
+struct btrfs_dir_stream {
+	struct fs_dir_stream parent;
+	struct fs_dirent dirent;
+	u64 subvolid;
+	u64 ino;
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
+	dirs->subvolid = root->root_key.objectid;
+	dirs->ino = ino;
+
+	*dirsp = &dirs->parent;
+	return 0;
+}
+
+static unsigned int btrfs_dirent_type_to_fs_type(u8 dirent_type)
+{
+	switch (dirent_type) {
+	case BTRFS_FT_DIR:
+		return FS_DT_DIR;
+	case BTRFS_FT_SYMLINK:
+		return FS_DT_LNK;
+	default:
+		return FS_DT_REG;
+	}
+}
+
+int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
+{
+	struct btrfs_dir_stream *dirs = container_of(fs_dirs, struct btrfs_dir_stream, parent);
+	struct btrfs_fs_info *fs_info = current_fs_info;
+	struct fs_dirent *dent = &dirs->dirent;
+	struct btrfs_root *root;
+	struct btrfs_key key;
+	u8 type;
+	int ret;
+
+	*dentp = NULL;
+	ASSERT(fs_info);
+
+	key.objectid = dirs->subvolid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	memset(dent, 0, sizeof(*dent));
+	ret = btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, dent->name,
+				   sizeof(dent->name), &type);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return -ENOENT;
+
+	dent->type = btrfs_dirent_type_to_fs_type(type);
+	*dentp = dent;
+	return 0;
+}
+
+void btrfs_closedir(struct fs_dir_stream *fs_dirs)
+{
+	struct btrfs_dir_stream *dirs = container_of(fs_dirs, struct btrfs_dir_stream, parent);
+
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
index 5f81d6414f06..b12298e20c41 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -166,3 +166,76 @@ out:
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
+	struct btrfs_dir_item *di;
+	int name_len;
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
+	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+		ret = btrfs_next_leaf(root, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {		/* end of tree */
+			ret = 1;
+			goto out;
+		}
+	}
+
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	if (key.objectid != ino || key.type != BTRFS_DIR_INDEX_KEY) {
+		ret = 1;		/* no more entries for this dir */
+		goto out;
+	}
+
+	di = btrfs_item_ptr(path.nodes[0], path.slots[0],
+			    struct btrfs_dir_item);
+	if (verify_dir_item(root, path.nodes[0], di)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	*offset = key.offset + 1;
+
+	name_len = btrfs_dir_name_len(path.nodes[0], di);
+	if (name_len > namebuf_len - 1)
+		name_len = namebuf_len - 1;
+	read_extent_buffer(path.nodes[0], namebuf,
+			   (unsigned long)(di + 1), name_len);
+	namebuf[name_len] = '\0';
+	*ftype = btrfs_dir_type(path.nodes[0], di);
+	ret = 0;
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

