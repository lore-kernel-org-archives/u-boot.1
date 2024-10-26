Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC179D10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0D489057;
	Sat, 26 Oct 2024 08:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="J3qjHpXg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421C789034; Sat, 26 Oct 2024 08:41:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E0488F68
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7B3CE426DB; 
 Sat, 26 Oct 2024 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924861;
 bh=HWtwDQODoNODld2dmmjtx0CwAEzZieRMGiDBcEeR7gc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=J3qjHpXgkvTXOxe3wiGiWUPymRdIy4RJ1tZJZYQRXzyKbvgdRbkzQyHXHzOr/VvFi
 RAI+n24ioe0fTY5cwRjjGnbQ6Yrn19JinnEg3LwwxAQNhFPN0tXVpO7NWA70onz+cY
 DetA43fWZ6bWY+DTAlGDzp8y9c7CoeZNZPxxJFmsQnCK69G2d+WdksrumqRc7mpUgB
 2Vp2uUxilKIs4x9CCfgL1YgGK2WOq3kopyQwap+xxV4CZi2o6LgbV4JnhDNS5jX9mg
 SjhGZ8VxptdhC1uglEv8iPkJqdHQKHq+/1u0gyQqgYs3hEEXgbaYlqwHztcnvJQHam
 cWHeeseRfVumg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/5] fs: ext4: implement opendir, readdir, closedir
Date: Sat, 26 Oct 2024 08:40:46 +0200
Message-ID: <20241026064048.370062-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For accessing directories from the EFI sub-system a file system must
implement opendir, readdir, closedir. Provide the missing implementation.

With this patch the eficonfig command can be used to define load options
for the ext4 file system.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/ext4/ext4fs.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++-
 fs/fs.c          |   4 +-
 include/ext4fs.h |   4 ++
 3 files changed, 166 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 21714149ef5..32693198aeb 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -21,17 +21,36 @@
  */
 
 #include <blk.h>
+#include <div64.h>
+#include <errno.h>
 #include <ext_common.h>
 #include <ext4fs.h>
-#include "ext4_common.h"
-#include <div64.h>
 #include <malloc.h>
 #include <part.h>
 #include <u-boot/uuid.h>
+#include "ext4_common.h"
 
 int ext4fs_symlinknest;
 struct ext_filesystem ext_fs;
 
+/**
+ * struct ext4_dir_stream - ext4 directory stream
+ *
+ * @parent: partition data used by fs layer.
+ * This field must be at the beginning of the structure.
+ * All other fields are private to the ext4 driver.
+ * @root:	root directory node
+ * @dir:	directory node
+ * @dirent:	directory stream entry
+ * @fpos:	file position in directory
+ */
+struct ext4_dir_stream {
+	struct fs_dir_stream parent;
+	char *dirname;
+	struct fs_dirent dirent;
+	unsigned int fpos;
+};
+
 struct ext_filesystem *get_fs(void)
 {
 	return &ext_fs;
@@ -205,6 +224,144 @@ int ext4fs_ls(const char *dirname)
 	return 0;
 }
 
+int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
+{
+	struct ext4_dir_stream *dirs;
+	struct ext2fs_node *dir = NULL;
+	int ret;
+
+	*dirsp = NULL;
+
+	dirs = calloc(1, sizeof(struct ext4_dir_stream));
+	if (!dirs)
+		return -ENOMEM;
+	dirs->dirname = strdup(dirname);
+	if (!dirs) {
+		free(dirs);
+		return -ENOMEM;
+	}
+
+	ret = ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
+			       FILETYPE_DIRECTORY);
+	if (ret == 1) {
+		ret = 0;
+		*dirsp = (struct fs_dir_stream *)dirs;
+	} else {
+		ret = -ENOENT;
+	}
+
+	if (dir)
+		ext4fs_free_node(dir, &ext4fs_root->diropen);
+
+	return ret;
+}
+
+int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
+{
+	struct ext4_dir_stream *dirs = (struct ext4_dir_stream *)fs_dirs;
+	struct fs_dirent *dent = &dirs->dirent;
+	struct ext2fs_node *dir = NULL;
+	int ret;
+	loff_t actread;
+	struct ext2fs_node fdiro;
+	int len;
+	struct ext2_dirent dirent;
+
+	*dentp = NULL;
+
+	ret = ext4fs_find_file(dirs->dirname, &ext4fs_root->diropen, &dir,
+			       FILETYPE_DIRECTORY);
+	if (ret != 1) {
+		ret = -ENOENT;
+		goto out;
+	}
+	if (!dir->inode_read) {
+		ret = ext4fs_read_inode(dir->data, dir->ino, &dir->inode);
+		if (!ret) {
+			ret = -EIO;
+			goto out;
+		}
+	}
+
+	if (dirs->fpos >= le32_to_cpu(dir->inode.size))
+		return -ENOENT;
+
+	memset(dent, 0, sizeof(struct fs_dirent));
+
+	while (dirs->fpos < le32_to_cpu(dir->inode.size)) {
+		ret = ext4fs_read_file(dir, dirs->fpos,
+				       sizeof(struct ext2_dirent),
+				       (char *)&dirent, &actread);
+		if (ret < 0)
+			return -ret;
+
+		if (!dirent.direntlen)
+			return -EIO;
+
+		if (dirent.namelen)
+			break;
+
+		dirs->fpos += le16_to_cpu(dirent.direntlen);
+	}
+
+	len = min(FS_DIRENT_NAME_LEN - 1, (int)dirent.namelen);
+
+	ret = ext4fs_read_file(dir, dirs->fpos + sizeof(struct ext2_dirent),
+			       len, dent->name, &actread);
+	if (ret < 0)
+		goto out;
+	dent->name[len] = '\0';
+
+	fdiro.data = dir->data;
+	fdiro.ino = le32_to_cpu(dirent.inode);
+
+	ret = ext4fs_read_inode(dir->data, fdiro.ino, &fdiro.inode);
+	if (!ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	switch (le16_to_cpu(fdiro.inode.mode) & FILETYPE_INO_MASK) {
+	case FILETYPE_INO_DIRECTORY:
+		dent->type = FS_DT_DIR;
+		break;
+	case FILETYPE_INO_SYMLINK:
+		dent->type = FS_DT_LNK;
+		break;
+	case FILETYPE_INO_REG:
+		dent->type = FS_DT_REG;
+		break;
+	default:
+		dent->type = FILETYPE_UNKNOWN;
+	}
+
+	rtc_to_tm(fdiro.inode.atime, &dent->access_time);
+	rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
+	rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
+
+	dirs->fpos += le16_to_cpu(dirent.direntlen);
+	dent->size = fdiro.inode.size;
+	*dentp = dent;
+	ret = 0;
+
+out:
+	if (dir)
+		ext4fs_free_node(dir, &ext4fs_root->diropen);
+
+	return ret;
+}
+
+void ext4fs_closedir(struct fs_dir_stream *fs_dirs)
+{
+	struct ext4_dir_stream *dirs = (struct ext4_dir_stream *)fs_dirs;
+
+	if (!dirs)
+		return;
+
+	free(dirs->dirname);
+	free(dirs);
+}
+
 int ext4fs_exists(const char *filename)
 {
 	struct ext2fs_node *dirnode = NULL;
diff --git a/fs/fs.c b/fs/fs.c
index e2915e7cf79..a515905c4c9 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -232,7 +232,9 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 #endif
 		.uuid = ext4fs_uuid,
-		.opendir = fs_opendir_unsupported,
+		.opendir = ext4fs_opendir,
+		.readdir = ext4fs_readdir,
+		.closedir = ext4fs_closedir,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 	},
diff --git a/include/ext4fs.h b/include/ext4fs.h
index 41f9eb8bd33..fe3fb301ec8 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -27,6 +27,7 @@
 #ifndef __EXT4__
 #define __EXT4__
 #include <ext_common.h>
+#include <fs.h>
 
 struct disk_partition;
 
@@ -218,4 +219,7 @@ int ext4fs_uuid(char *uuid_str);
 void ext_cache_init(struct ext_block_cache *cache);
 void ext_cache_fini(struct ext_block_cache *cache);
 int ext_cache_read(struct ext_block_cache *cache, lbaint_t block, int size);
+int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp);
+int ext4fs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+void ext4fs_closedir(struct fs_dir_stream *dirs);
 #endif
-- 
2.45.2

