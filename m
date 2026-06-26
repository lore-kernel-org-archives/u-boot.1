Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D51C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 15:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E00D84894;
	Fri, 26 Jun 2026 17:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="3Ep043Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 054DD849C5; Fri, 26 Jun 2026 17:18:57 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFC4C84704
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 17:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46e4764ca48so999287f8f.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782487134; x=1783091934; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qcspnj9HibuTkiq0OfUlH3L2tuWTbycqLmr4pyIENic=;
 b=3Ep043BnSR5B7mldr3QC2GOVIFmblg0S3Bdp0g/90XCPybOIdcgc2wCtIDAtD9LPTj
 dyRqWG7uOskoiaLhoxQCsPVh1DWVHP6zmNd0y/e1WZQj0uHetaNHl48RaDtexiW6/fsQ
 nHnJmx2PWZi7TELUzOrM6divorbo6WFt8GVPczuMCfMgtjmwOamhMhOLMbiFdH3tT/w6
 ojMFDc56lqoTZluuYjHSukpmGIY7cmHG61ZN3fOI519u6qVUL+pfHpVj9fMqsk9Um+7R
 DFOxoVNUABAd7RYa8MNudAGefv7tS4bHbRbH29xyeSI93ousY4d1wRbv4tVsOHD4ORao
 k7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487134; x=1783091934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qcspnj9HibuTkiq0OfUlH3L2tuWTbycqLmr4pyIENic=;
 b=dU4grdm4x7fpNdC/dxBkl6nVbQueorTcO2dlA649iaoNM/Bj58+ET8SLS2+mUxf9C5
 Zzi8EL5lXoxDZ78aSOx9xOtL+w5amYpYNUrx5O3ilIhqn6bU2fy/Et1LSq63u3E/q3Ah
 3Op5DlcGBZG9vReKR9yKYbGKTyNigWn4A/YSrDfIAj9nQt6GaY1RBeR+aC1ZwTjVkjgo
 5CY7l94I2xM/S2DXtWs+4NGJgEBR4wnC0TU/H6bKMu74Mj2ADnIuYZ4y+NensjbZj6gl
 hHfI0l7p8oPfwBhI4OOHdYvQPssb53lWqG4dtbpJKYpkm/lJDZEQ/nQru+/TSvTttvxn
 7qYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XZPXyvUZRdExdTXBKCUgIlQx/KCrqXSrvdts5Ch3/dIsf2ceCN3TScOLoOLlUm4OdPqvdc4A=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+fJ3lEYIJ8Fuhhawn1xBtyvFpr+Mo2+zBNhbU0PK/lyZVCpev
 MOYpmkxGDGLT+mte4F9HGtue1MhHK/9CiUCNGvblq4UGsXS6/QObC7curMmhAwczOBc=
X-Gm-Gg: AfdE7clQZvV6631jL6AmpFOD3RuI+pp7xWqwrquoXqDsKDpOcc/GxcRsaehUhS9EvfD
 uz35sn1KBFAFgr6eo5bo/79JnHFMN0BG2bgMSKM9sA/68LifJ/7s9MFvp7b7Jt/uX/QTv7/J1z0
 JDl+O2TpARiYBzfsSlAeGHaBSRm2MfbWw1ISw4XTpvXT6S8H7W7EQp+DTu/s65IIJdqtHoqNis4
 voEP3QbCT3O8LhHXdTwvdCStXGFYiORLMfExPk8C4wVqBtWNcmdjTmCxM4a2FxTUip51q8egwD0
 KK8HGvmDR8JCndhytwOVw357Wjmt8DPqOuIwaqzS9UHfi65NKJ4FwcV6kt/5vKEp95SOiT7DwhA
 W7yt6GXL6tOlFPeZJD5gM3LjL9QP4E7YqAWs9x3NinQI46BO/44c2WsL6ALl32P8cKIIgmTtu1L
 O8+wgOL3P+SE/1lUYkOsQFEc0HsOXHSQ==
X-Received: by 2002:a05:600c:620d:b0:492:30f2:963a with SMTP id
 5b1f17b1804b1-492667e849fmr108403535e9.0.1782487134121; 
 Fri, 26 Jun 2026 08:18:54 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d998esm24860736f8f.24.2026.06.26.08.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:18:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 26 Jun 2026 19:18:22 +0400
Subject: [PATCH v2 2/2] fs: btrfs: use fs_ls_generic() and drop custom
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-btrfs-readdir-v2-2-7dd43f72d1b4@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8436; i=alchark@flipper.net;
 h=from:subject:message-id; bh=udVAXUrG90NHbIAuqCRY1nW7Y9JtNz8sVz5gLH1i9ug=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZzQh/kcD9ynmtE6fgMf5bgUd99U4WHjnv7ruUU/lAv
 0Qg1+VJHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEy17mOG/yViaR+SGdpUp2bvTg/b971s4+ML69m1lrVlZGf7Wm2czMLIMFfUb9K
 CGFNHhtwPh4pSb79Tm3NTactGF5f7h//12SSt5AQA
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

Now that generic callbacks for opendir/readdir/closedir are implemented,
the custom btrfs_ls() implementation is no longer needed, along with the
btrfs_iter_dir() callback iterator.

Use fs_ls_generic() instead.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 fs/btrfs/btrfs.c    | 129 ----------------------------------------------------
 fs/btrfs/ctree.h    |   5 --
 fs/btrfs/dir-item.c |  59 ++----------------------
 fs/fs.c             |   2 +-
 include/btrfs.h     |   1 -
 5 files changed, 4 insertions(+), 192 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 6f034861da90..e663dda12e80 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -17,107 +17,6 @@
 
 struct btrfs_fs_info *current_fs_info;
 
-static int show_dir(struct btrfs_root *root, struct extent_buffer *eb,
-		    struct btrfs_dir_item *di)
-{
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_inode_item ii;
-	struct btrfs_key key;
-	static const char* dir_item_str[] = {
-		[BTRFS_FT_REG_FILE]	= "   ",
-		[BTRFS_FT_DIR]		= "DIR",
-		[BTRFS_FT_CHRDEV]	= "CHR",
-		[BTRFS_FT_BLKDEV]	= "BLK",
-		[BTRFS_FT_FIFO]		= "FIF",
-		[BTRFS_FT_SOCK]		= "SCK",
-		[BTRFS_FT_SYMLINK]	= "SYM",
-	};
-	u8 type = btrfs_dir_type(eb, di);
-	char namebuf[BTRFS_NAME_LEN];
-	char *target = NULL;
-	char filetime[32];
-	time_t mtime;
-	int ret = 0;
-
-	/* skip XATTRs in directory listing */
-	if (type == BTRFS_FT_XATTR)
-		return 0;
-
-	btrfs_dir_item_key_to_cpu(eb, di, &key);
-
-	if (key.type == BTRFS_ROOT_ITEM_KEY) {
-		struct btrfs_root *subvol;
-
-		/* It's a subvolume, get its mtime from root item */
-		subvol = btrfs_read_fs_root(fs_info, &key);
-		if (IS_ERR(subvol)) {
-			ret = PTR_ERR(subvol);
-			error("Can't find root %llu", key.objectid);
-			return ret;
-		}
-		mtime = btrfs_stack_timespec_sec(&subvol->root_item.otime);
-	} else {
-		struct btrfs_path path;
-
-		/* It's regular inode, get its mtime from inode item */
-		btrfs_init_path(&path);
-		ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-		if (ret > 0)
-			ret = -ENOENT;
-		if (ret < 0) {
-			error("Can't find inode %llu", key.objectid);
-			btrfs_release_path(&path);
-			return ret;
-		}
-		read_extent_buffer(path.nodes[0], &ii,
-			btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
-			sizeof(ii));
-		btrfs_release_path(&path);
-		mtime = btrfs_stack_timespec_sec(&ii.mtime);
-	}
-	ctime_r(&mtime, filetime);
-
-	if (type == BTRFS_FT_SYMLINK) {
-		target = malloc(fs_info->sectorsize);
-		if (!target) {
-			error("Can't alloc memory for symlink %llu",
-				key.objectid);
-			return -ENOMEM;
-		}
-		ret = btrfs_readlink(root, key.objectid, target);
-		if (ret < 0) {
-			error("Failed to read symlink %llu", key.objectid);
-			goto out;
-		}
-		target[ret] = '\0';
-	}
-
-	if (type < ARRAY_SIZE(dir_item_str) && dir_item_str[type])
-		printf("<%s> ", dir_item_str[type]);
-	else
-		printf("?%3u? ", type);
-	if (type == BTRFS_FT_CHRDEV || type == BTRFS_FT_BLKDEV) {
-		ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
-		printf("%4llu,%5llu  ", btrfs_stack_inode_rdev(&ii) >> 20,
-				btrfs_stack_inode_rdev(&ii) & 0xfffff);
-	} else {
-		if (key.type == BTRFS_INODE_ITEM_KEY)
-			printf("%10llu  ", btrfs_stack_inode_size(&ii));
-		else
-			printf("%10llu  ", 0ULL);
-	}
-
-	read_extent_buffer(eb, namebuf, (unsigned long)(di + 1),
-			   btrfs_dir_name_len(eb, di));
-	printf("%24.24s  %.*s", filetime, btrfs_dir_name_len(eb, di), namebuf);
-	if (type == BTRFS_FT_SYMLINK)
-		printf(" -> %s", target ? target : "?");
-	printf("\n");
-out:
-	free(target);
-	return ret;
-}
-
 int btrfs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition)
 {
@@ -133,34 +32,6 @@ int btrfs_probe(struct blk_desc *fs_dev_desc,
 	return ret;
 }
 
-int btrfs_ls(const char *path)
-{
-	struct btrfs_fs_info *fs_info = current_fs_info;
-	struct btrfs_root *root = fs_info->fs_root;
-	u64 ino = BTRFS_FIRST_FREE_OBJECTID;
-	u8 type;
-	int ret;
-
-	ASSERT(fs_info);
-	ret = btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJECTID,
-				path, &root, &ino, &type, 40);
-	if (ret < 0) {
-		printf("Cannot lookup path %s\n", path);
-		return ret;
-	}
-
-	if (type != BTRFS_FT_DIR) {
-		error("Not a directory: %s", path);
-		return -ENOENT;
-	}
-	ret = btrfs_iter_dir(root, ino, show_dir);
-	if (ret < 0) {
-		error("An error occurred while listing directory %s", path);
-		return ret;
-	}
-	return 0;
-}
-
 /*
  * The fs layer closes and re-probes btrfs between readdir() calls (see
  * fs_readdir() in fs/fs.c), freeing and reallocating fs_info, so root cannot
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7de35aa7efd5..3fa9a8c9c020 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1220,11 +1220,6 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     struct btrfs_path *path, u64 dir,
 					     const char *name, int name_len,
 					     int mod);
-typedef int (*btrfs_iter_dir_callback_t)(struct btrfs_root *root,
-					 struct extent_buffer *eb,
-					 struct btrfs_dir_item *di);
-int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
-		   btrfs_iter_dir_callback_t callback);
 int btrfs_next_dir_entry(struct btrfs_root *root, u64 ino, u64 *offset,
 			 char *namebuf, int namebuf_len, u8 *ftype);
 /* inode.c */
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index b12298e20c41..c7b87d60d986 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -114,65 +114,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return btrfs_match_dir_item_name(root, path, name, name_len);
 }
 
-int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
-		   btrfs_iter_dir_callback_t callback)
-{
-	struct btrfs_path path;
-	struct btrfs_key key;
-	int ret;
-
-	btrfs_init_path(&path);
-	key.objectid = ino;
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret < 0)
-		return ret;
-	/* Should not happen */
-	if (ret == 0) {
-		ret = -EUCLEAN;
-		goto out;
-	}
-	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-		ret = btrfs_next_leaf(root, &path);
-		if (ret < 0)
-			goto out;
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-	}
-	do {
-		struct btrfs_dir_item *di;
-
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid != ino || key.type != BTRFS_DIR_INDEX_KEY)
-			break;
-		di = btrfs_item_ptr(path.nodes[0], path.slots[0],
-				    struct btrfs_dir_item);
-		if (verify_dir_item(root, path.nodes[0], di)) {
-			ret = -EUCLEAN;
-			goto out;
-		}
-		ret = callback(root, path.nodes[0], di);
-		if (ret < 0)
-			goto out;
-	} while (!(ret = btrfs_next_item(root, &path)));
-
-	if (ret > 0)
-		ret = 0;
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
-
 /*
  * btrfs_next_dir_entry() - read one directory entry at or after a cursor
  *
- * Streaming counterpart to btrfs_iter_dir() for the fs-layer readdir, which
- * is re-entered once per entry: returns the first real entry whose
- * BTRFS_DIR_INDEX_KEY offset is >= *offset and advances *offset past it.
+ * Iterator for the fs-layer readdir, which is re-entered once per entry:
+ * returns the first real entry whose BTRFS_DIR_INDEX_KEY offset is
+ * >= *offset and advances *offset past it.
  *
  * @root, @ino:		directory to read
  * @offset:		in/out cursor; DIR_INDEX offset to resume from
diff --git a/fs/fs.c b/fs/fs.c
index 4694a88f776b..1ebda6f4ee2a 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -320,7 +320,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = false,
 		.probe = btrfs_probe,
 		.close = btrfs_close,
-		.ls = btrfs_ls,
+		.ls = fs_ls_generic,
 		.exists = btrfs_exists,
 		.size = btrfs_size,
 		.read = btrfs_read,
diff --git a/include/btrfs.h b/include/btrfs.h
index 6fff45a497ee..3878b7817ea6 100644
--- a/include/btrfs.h
+++ b/include/btrfs.h
@@ -15,7 +15,6 @@ struct fs_dirent;
 
 int btrfs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition);
-int btrfs_ls(const char *);
 int btrfs_exists(const char *);
 int btrfs_size(const char *, loff_t *);
 int btrfs_read(const char *, void *, loff_t, loff_t, loff_t *);

-- 
2.53.0

