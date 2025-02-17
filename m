Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6914DC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 05:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25B7D80F92;
	Tue, 18 Feb 2025 06:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="feC8/7IQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B03580843; Mon, 17 Feb 2025 19:31:37 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3379807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 19:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-46fa764aac2so37749611cf.1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739817092; x=1740421892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NcuHhDgu0yUqrQ7oNf2LtvidIrCoxoXN+wFdknSGow=;
 b=feC8/7IQ8MmM3MF9UhX/NtnMYyJINFcGINf2MlSpxq/Bdxkb77maLQc3XaZkqLxTyZ
 +TH++yJz/0oaUjb9bqvcjcPF/MWnoX4yQ097P8KSo/+xNrsdOL8LTKGPEkOKKhWBKIzo
 8nStMWCqKnbLpYPX1mGNRi3T/eFxWSpgbI8y6dKN1vKT30psrD8UxlHfPIfvNu5GP7rK
 g2l8Ee/cLCmO5jSxmXSwbIi7ALqZMlryFQL1BhTRXlTMd+/htIPttl7MP6xVuZ45E7BF
 1Hx+h34dUY+oc60qLN4qB4WkPM3bM4odctaDWFqQt5A9UYPJlElqMV5CmvL5pxn8D5hn
 +2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817092; x=1740421892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NcuHhDgu0yUqrQ7oNf2LtvidIrCoxoXN+wFdknSGow=;
 b=moY6P8pDc4lbZ+k+QPAyw6WxfcrcA0jGR5JyNV1bNlVsOvg4aO0DAgbd7HZBCoXvk2
 NcjlTIcGIKQlN1vWcDAKw+Y2ZyR9RajO9yoEaIfLa+aBmhotYFz70ElfdSfakEht3TiS
 ZXt5Yc8djgWrLiS60mOPwH/aaTbcSdCZ7/p+PANjy5upEzoXbVLA1f0XGe5Px5YKHU6k
 lhRJotP3JR6Llq0UuBlzUxNPFoE8VAzY7Ng2Lp+UpffPELAnBO8XTdLPBr+j96sFHh7+
 F3F0PgFre0Dh5nXLFfiPrSuY4kex1ip0BETnGAe/D+EZZuaZ+zAO2dgN9WejqLdASfuT
 AKtw==
X-Gm-Message-State: AOJu0YxlraOT2lmw/hZ/D9Ci9iznvqM+1mZhthMoJEF3h6p9mhVq+vSW
 Qs9yq8jc7Q/N7GVjgabLuhz/MOMsNx+tILq95DZEwDIT3b+tFwZefyNnxVU4
X-Gm-Gg: ASbGncv8DLDTWew0w2b3+lUueIK6W2Crhl0YSW9mwr9bHvP1Ys+roUL13P5l7VfI4nE
 xejCiOj3OR7FLirFiEW5Wlk/sjSQVrbTydCrbEjjOKTTnh+WsCQPHkt3Th4Ljb/5PMKJR2ZEOpQ
 jvqBAM3oPTrJnS0Nddtq7gAyIrTnNUpwwwoqP6JhryGPyET4Sp9Mz3R2u4C8P4eYVKhoeRjaZ/Z
 b/GsS/Z5yW4LpW5LDNoAxFD5kcb/w9Px14N2rswo+jAIrIjqdLrN35ZY63/R+pq0a+HVVWiPmWn
 qbpkPFyfWWHRj4LwTIS0KU/flSmS5Qrdoy4bSg==
X-Google-Smtp-Source: AGHT+IGY/mAzIsMaoGCCYdArj8kf+j7zJBuue/ignTRnTDWTCJ871eK0n3BcrcROeFzCznJ2rQsuPg==
X-Received: by 2002:a05:622a:8c0e:b0:471:f185:cdce with SMTP id
 d75a77b69052e-471f185cfa4mr62202641cf.18.1739817091352; 
 Mon, 17 Feb 2025 10:31:31 -0800 (PST)
Received: from localhost.localdomain ([174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-471c2af3722sm50499271cf.49.2025.02.17.10.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 10:31:30 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/6] fs: fat: add rename
Date: Mon, 17 Feb 2025 13:26:44 -0500
Message-Id: <20250217182648.31294-4-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Feb 2025 06:35:28 +0100
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

The implementation roughly follows the POSIX specification for
rename() [1]. The ordering of operations attempting to minimize the chance
for data loss in unexpected circumstances.

The 'mv' command was implemented as a front end for the rename operation
as that is what most users are likely familiar with in terms of behavior.

The 'FAT_RENAME' Kconfig option was added to prevent code size increase on
size-oriented builds like SPL.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.html

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>

---

Changes in v2:
 - change fatrename to mv (updating semantics to match mv)
 - add mv command docs
 - add FAT_RENAME Kconfig symbol
 - update rename tests for mv command semantics
 - update rename test docs on whether mv should succeed or fail
 - remove all (fat) prefixes from commands used in rename tests
 - clarify docs in check_path_prefix()
 - stack allocate fat_itr in check_path_prefix()
 - log on observed filesystem corruption in check_path_prefix()
 - change 'break's to 'goto' in check_path_prefix()
 - normalize added logging to use log_debug()
 - correct error code returned when destination directory is not empty


---
 cmd/fs.c                                |  14 +
 doc/usage/cmd/mv.rst                    |  61 ++++
 fs/fat/Kconfig                          |   7 +
 fs/fat/fat_write.c                      | 285 ++++++++++++++++++
 fs/fs.c                                 |  65 ++++-
 include/fat.h                           |   1 +
 include/fs.h                            |   2 +
 lib/efi_loader/Kconfig                  |   1 +
 test/py/tests/test_fs/conftest.py       | 121 ++++++++
 test/py/tests/test_fs/fstest_helpers.py |   2 +
 test/py/tests/test_fs/test_rename.py    | 372 ++++++++++++++++++++++++
 11 files changed, 930 insertions(+), 1 deletion(-)
 create mode 100644 doc/usage/cmd/mv.rst
 create mode 100644 test/py/tests/test_fs/test_rename.py

diff --git a/cmd/fs.c b/cmd/fs.c
index 3d7e06d6f1e..3faf7627447 100644
--- a/cmd/fs.c
+++ b/cmd/fs.c
@@ -110,3 +110,17 @@ U_BOOT_CMD(
 	fstypes, 1, 1, do_fstypes_wrapper,
 	"List supported filesystem types", ""
 );
+
+static int do_mv_wrapper(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	return do_mv(cmdtp, flag, argc, argv, FS_TYPE_ANY);
+}
+
+U_BOOT_CMD(
+	mv,	5,	1,	do_mv_wrapper,
+	"rename/move a file/directory",
+	"<interface> [<dev[:part]>] <old_path> <new_path>\n"
+	"    - renames/moves a file/directory in 'dev' on 'interface' from\n"
+	"      'old_path' to 'new_path'"
+);
diff --git a/doc/usage/cmd/mv.rst b/doc/usage/cmd/mv.rst
new file mode 100644
index 00000000000..99864371038
--- /dev/null
+++ b/doc/usage/cmd/mv.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: mv (command)
+
+mv command
+==========
+
+Synopsis
+--------
+
+::
+
+    mv <interface> [<dev[:part]>] <old_path> <new_path>
+
+Description
+-----------
+
+The mv command renames/moves a file or directory within a filesystem.
+
+interface
+    interface for accessing the block device (mmc, sata, scsi, usb, ....)
+
+dev
+    device number
+
+part
+    partition number, defaults to 0 (whole device)
+
+old_path
+   existing path to file/directory
+
+new_path
+   new path/name for the rename/move
+
+
+Example
+-------
+
+    # Rename file 'foo' in directory 'dir' to 'bar'
+    mv mmc 0:0 dir/foo dir/bar
+
+    # Move file 'f' from directory 'foo' to existing directory 'bar' renaming
+    # 'f' to 'g'
+    mv mmc 0:0 foo/f bar/g
+
+    # Move directory 'abc' in directory 'dir1' into existing directory 'dir2'
+    mv mmc 0:0 dir1/abc dir2
+
+Configuration
+-------------
+
+The mv command is only available if CONFIG_CMD_FS_GENERIC=y.
+
+Return value
+------------
+
+The return value $? is set to 0 (true) if the file was successfully
+renamed/moved.
+
+If an error occurs, the return value $? is set to 1 (false).
diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
index 9bb11eac9f7..19d52238713 100644
--- a/fs/fat/Kconfig
+++ b/fs/fat/Kconfig
@@ -13,6 +13,13 @@ config FAT_WRITE
 	  This provides support for creating and writing new files to an
 	  existing FAT filesystem partition.
 
+config FAT_RENAME
+	bool "Enable filesystem rename support"
+	depends on FAT_WRITE
+	help
+	  This provides support for renaming and moving files within a
+	  FAT filesystem partition.
+
 config FS_FAT_MAX_CLUSTSIZE
 	int "Set maximum possible clustersize"
 	default 65536
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 86366d03853..d4952e259ff 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1215,6 +1215,28 @@ static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
 	memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
 }
 
+/**
+ * fat_itr_parent() - modifies the iterator to the parent directory of the
+ * current iterator.
+ *
+ * @itr:	iterator positioned anywhere in a directory
+ * @Return:	0 if the iterator is in the parent directory, -errno otherwise
+ */
+static int fat_itr_parent(fat_itr *itr)
+{
+	int ret;
+
+	if (itr->is_root)
+		return -EIO;
+
+	/* ensure iterator is at the first directory entry */
+	ret = fat_move_to_cluster(itr, itr->start_clust);
+	if (ret)
+		return ret;
+
+	return fat_itr_resolve(itr, "..", TYPE_DIR);
+}
+
 /**
  * create_link() - inserts a directory entry for a file or directory
  *
@@ -1822,3 +1844,266 @@ exit:
 	free(dotdent);
 	return ret;
 }
+
+/**
+ * check_path_prefix() - ensures one path does not contains another path as a
+ * prefix.
+ *
+ * for example: path foo/bar/baz/qux contains the path prefix foo/bar/baz
+ *
+ * note: the iterator may be pointing to any directory entry in the directory
+ *
+ * @prefix_clust:	start cluster of the final directory in the prefix path
+ * (the start cluster of 'baz' in the above example)
+ * @path_itr:	iterator of the path to check (an iterator pointing to any
+ * direntry in 'qux' in the above example)
+ * Return:	-errno on error, 0 if path_itr does not have the directory
+ * at prefix_clust as an ancestor.
+ */
+static int check_path_prefix(loff_t prefix_clust, fat_itr *path_itr)
+{
+	fat_itr itr;
+	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	int ret;
+
+	/* duplicate fsdata */
+	itr = *path_itr;
+	fsdata = *itr.fsdata;
+
+	/* allocate local fat buffer */
+	fsdata.fatbuf = malloc_cache_aligned(FATBUFSIZE);
+	if (!fsdata.fatbuf) {
+		log_debug("Error: allocating memory\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	fsdata.fatbufnum = -1;
+	itr.fsdata = &fsdata;
+
+	/* ensure iterator is at the first directory entry */
+	ret = fat_move_to_cluster(&itr, itr.start_clust);
+	if (ret)
+		goto exit;
+
+	while (1) {
+		if (prefix_clust == itr.start_clust) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		if (itr.is_root) {
+			ret = 0;
+			goto exit;
+		}
+
+		/* Should not occur in a well-formed FAT filesystem besides the root */
+		if (fat_itr_parent(&itr)) {
+			log_debug("FAT filesystem corrupt!\n");
+			log_debug("dir @ clust %u has no parent direntry\n",
+				  itr.start_clust);
+			ret = -EIO;
+			goto exit;
+		}
+	}
+
+exit:
+	free(fsdata.fatbuf);
+	return ret;
+}
+
+/**
+ * fat_rename - rename/move a file or directory
+ *
+ * @old_path:	path to the existing file/directory
+ * @new_path:	new path/name for the rename/move
+ * Return:	0 on success, -errno otherwise
+ */
+int fat_rename(const char *old_path, const char *new_path)
+{
+	fat_itr *old_itr = NULL, *new_itr = NULL;
+	fsdata old_datablock = { .fatbuf = NULL, };
+	fsdata new_datablock = { .fatbuf = NULL, };
+	/* used for START macro */
+	fsdata *mydata = &old_datablock;
+	int ret = -EIO, is_old_dir;
+	char *old_path_copy, *old_dirname, *old_basename;
+	char *new_path_copy, *new_dirname, *new_basename;
+	char l_new_basename[VFAT_MAXLEN_BYTES];
+	__u32 old_clust;
+	dir_entry *found_existing;
+	/* only set if found_existing != NULL */
+	__u32 new_clust;
+
+	old_path_copy = strdup(old_path);
+	new_path_copy = strdup(new_path);
+	old_itr = malloc_cache_aligned(sizeof(fat_itr));
+	new_itr = malloc_cache_aligned(sizeof(fat_itr));
+	if (!old_path_copy || !new_path_copy || !old_itr || !new_itr) {
+		log_debug("Error: out of memory\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+	split_filename(old_path_copy, &old_dirname, &old_basename);
+	split_filename(new_path_copy, &new_dirname, &new_basename);
+
+	if (normalize_longname(l_new_basename, new_basename)) {
+		log_debug("FAT: illegal filename (%s)\n", new_basename);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (!strcmp(old_basename, ".") || !strcmp(old_basename, "..") ||
+	    !strcmp(old_basename, "") || !strcmp(l_new_basename, ".") ||
+	    !strcmp(l_new_basename, "..") || !strcmp(l_new_basename, "")) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	/* checking for old_path == new_path is deferred until they're resolved */
+
+	/* resolve old_path */
+	ret = fat_itr_root(old_itr, &old_datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(old_itr, old_dirname, TYPE_DIR);
+	if (ret) {
+		log_debug("%s doesn't exist (%d)\n", old_dirname, ret);
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (!find_directory_entry(old_itr, old_basename)) {
+		log_debug("%s doesn't exist (%d)\n", old_basename, -ENOENT);
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	/* store clust old_path points to, to relink later */
+	total_sector = old_datablock.total_sect;
+	old_clust = START(old_itr->dent);
+	is_old_dir = fat_itr_isdir(old_itr);
+
+	/* resolve new_path*/
+	ret = fat_itr_root(new_itr, &new_datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(new_itr, new_dirname, TYPE_DIR);
+	if (ret) {
+		log_debug("%s doesn't exist (%d)\n", new_dirname, ret);
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	found_existing = find_directory_entry(new_itr, l_new_basename);
+
+	if (found_existing) {
+		/* store cluster of new_path since it may need to be deleted */
+		new_clust = START(new_itr->dent);
+
+		/* old_path is new_path, noop */
+		if (old_clust == new_clust) {
+			ret = 0;
+			goto exit;
+		}
+
+		if (fat_itr_isdir(new_itr) != is_old_dir) {
+			if (is_old_dir)
+				ret = -ENOTDIR;
+			else
+				ret = -EISDIR;
+			goto exit;
+		}
+	}
+
+	if (is_old_dir) {
+		ret = check_path_prefix(old_clust, new_itr);
+		if (ret)
+			goto exit;
+	}
+
+	/* create/update dentry to point to old_path's data cluster */
+	if (found_existing) {
+		struct nameext new_name = new_itr->dent->nameext;
+		__u8 lcase = new_itr->dent->lcase;
+
+		if (is_old_dir) {
+			int n_entries = fat_dir_entries(new_itr);
+
+			if (n_entries < 0) {
+				ret = n_entries;
+				goto exit;
+			}
+			if (n_entries > 2) {
+				log_debug("Error: directory is not empty: %d\n",
+					  n_entries);
+				ret = -ENOTEMPTY;
+				goto exit;
+			}
+		}
+
+		*new_itr->dent = *old_itr->dent;
+		new_itr->dent->nameext = new_name;
+		new_itr->dent->lcase = lcase;
+	} else {
+		/* reset iterator to the start of the directory */
+		ret = fat_move_to_cluster(new_itr, new_itr->start_clust);
+		if (ret)
+			goto exit;
+
+		ret = create_link(new_itr, l_new_basename, old_clust,
+				  old_itr->dent->size,
+				  old_itr->dent->attr | ATTR_ARCH);
+		if (ret)
+			goto exit;
+	}
+
+	ret = flush_dir(new_itr);
+	if (ret)
+		goto exit;
+
+	/* with new_path data cluster unreferenced, clear it */
+	if (found_existing) {
+		ret = clear_fatent(&new_datablock, new_clust);
+		if (ret)
+			goto exit;
+	}
+
+	/* update moved directory so the parent is new_path */
+	if (is_old_dir) {
+		__u32 clust = new_itr->start_clust;
+		dir_entry *dent;
+
+		fat_itr_child(new_itr, new_itr);
+		dent = find_directory_entry(new_itr, "..");
+		if (!dent) {
+			log_debug("FAT filesystem corrupt!\n");
+			log_debug("dir %s has no parent direntry\n",
+				  l_new_basename);
+			ret = -EIO;
+			goto exit;
+		}
+		set_start_cluster(&new_datablock, dent, clust);
+		ret = flush_dir(new_itr);
+		if (ret)
+			goto exit;
+	}
+
+	/* refresh old in case write happened to the same block. */
+	ret = fat_move_to_cluster(old_itr, old_itr->dent_clust);
+	if (ret)
+		goto exit;
+
+	ret = delete_dentry_link(old_itr);
+exit:
+	free(new_datablock.fatbuf);
+	free(old_datablock.fatbuf);
+	free(new_itr);
+	free(old_itr);
+	free(new_path_copy);
+	free(old_path_copy);
+
+	return ret;
+}
diff --git a/fs/fs.c b/fs/fs.c
index fdff83719b1..30a8e5010f2 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -213,12 +213,16 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 #endif
-		.rename = fs_rename_unsupported,
 		.uuid = fat_uuid,
 		.opendir = fat_opendir,
 		.readdir = fat_readdir,
 		.closedir = fat_closedir,
 		.ln = fs_ln_unsupported,
+#if CONFIG_IS_ENABLED(FAT_RENAME) && !IS_ENABLED(CONFIG_XPL_BUILD)
+		.rename = fat_rename,
+#else
+		.rename = fs_rename_unsupported,
+#endif
 	},
 #endif
 
@@ -1007,6 +1011,65 @@ int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	return 0;
 }
 
+int do_mv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	  int fstype)
+{
+	struct fs_dir_stream *dirs;
+	char *src = argv[3];
+	char *dst = argv[4];
+	char *new_dst = NULL;
+	int ret = 1;
+
+	if (argc != 5) {
+		ret = CMD_RET_USAGE;
+		goto exit;
+	}
+
+	if (fs_set_blk_dev(argv[1], argv[2], fstype))
+		goto exit;
+
+	dirs = fs_opendir(dst);
+	/* dirs being valid means dst points to an existing directory.
+	 * mv should copy the file/dir (keeping the same name) into the
+	 * directory
+	 */
+	if (dirs) {
+		char *src_name = strrchr(src, '/');
+		int dst_len;
+
+		if (src_name)
+			src_name += 1;
+		else
+			src_name = src;
+
+		dst_len = strlen(dst);
+		new_dst = calloc(1, dst_len + strlen(src_name) + 2);
+		strcpy(new_dst, dst);
+
+		/* If there is already a trailing slash, don't add another */
+		if (new_dst[dst_len - 1] != '/') {
+			new_dst[dst_len] = '/';
+			dst_len += 1;
+		}
+
+		strcpy(new_dst + dst_len, src_name);
+		dst = new_dst;
+	}
+	fs_closedir(dirs);
+
+	if (fs_set_blk_dev(argv[1], argv[2], fstype))
+		goto exit;
+
+	if (fs_rename(src, dst))
+		goto exit;
+
+	ret = 0;
+
+exit:
+	free(new_dst);
+	return ret;
+}
+
 int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	struct fstype_info *drv = fstypes;
diff --git a/include/fat.h b/include/fat.h
index 3dce99a23cf..ca97880de12 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -206,6 +206,7 @@ int fat_opendir(const char *filename, struct fs_dir_stream **dirsp);
 int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
 void fat_closedir(struct fs_dir_stream *dirs);
 int fat_unlink(const char *filename);
+int fat_rename(const char *old_path, const char *new_path);
 int fat_mkdir(const char *dirname);
 void fat_close(void);
 void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
diff --git a/include/fs.h b/include/fs.h
index 5b272eb9f5e..54449faf2e5 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -302,6 +302,8 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	     int fstype);
 int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	  int fstype);
+int do_mv(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	  int fstype);
 
 /*
  * Determine the UUID of the specified filesystem and print it. Optionally it is
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d4f6b56afaa..6130af14337 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -27,6 +27,7 @@ config EFI_LOADER
 	select REGEX
 	imply FAT
 	imply FAT_WRITE
+	imply FAT_RENAME
 	imply USB_KEYBOARD_FN_KEYS
 	imply VIDEO_ANSI
 	help
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index af2adaf1645..7bfcf41ed6f 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -18,6 +18,7 @@ supported_fs_fat = ['fat12', 'fat16']
 supported_fs_mkdir = ['fat12', 'fat16', 'fat32']
 supported_fs_unlink = ['fat12', 'fat16', 'fat32']
 supported_fs_symlink = ['ext4']
+supported_fs_rename = ['fat12', 'fat16', 'fat32']
 
 #
 # Filesystem test specific setup
@@ -55,6 +56,7 @@ def pytest_configure(config):
     global supported_fs_mkdir
     global supported_fs_unlink
     global supported_fs_symlink
+    global supported_fs_rename
 
     def intersect(listA, listB):
         return  [x for x in listA if x in listB]
@@ -68,6 +70,7 @@ def pytest_configure(config):
         supported_fs_mkdir =  intersect(supported_fs, supported_fs_mkdir)
         supported_fs_unlink =  intersect(supported_fs, supported_fs_unlink)
         supported_fs_symlink =  intersect(supported_fs, supported_fs_symlink)
+        supported_fs_rename =  intersect(supported_fs, supported_fs_rename)
 
 def pytest_generate_tests(metafunc):
     """Parametrize fixtures, fs_obj_xxx
@@ -99,6 +102,9 @@ def pytest_generate_tests(metafunc):
     if 'fs_obj_symlink' in metafunc.fixturenames:
         metafunc.parametrize('fs_obj_symlink', supported_fs_symlink,
             indirect=True, scope='module')
+    if 'fs_obj_rename' in metafunc.fixturenames:
+        metafunc.parametrize('fs_obj_rename', supported_fs_rename,
+            indirect=True, scope='module')
 
 #
 # Helper functions
@@ -527,6 +533,121 @@ def fs_obj_symlink(request, u_boot_config):
         call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
+#
+# Fixture for rename test
+#
+@pytest.fixture()
+def fs_obj_rename(request, u_boot_config):
+    """Set up a file system to be used in rename tests.
+
+    Args:
+        request: Pytest request object.
+        u_boot_config: U-Boot configuration.
+
+    Return:
+        A fixture for rename tests, i.e. a triplet of file system type,
+        volume file name, and dictionary of test identifier and md5val.
+    """
+    def new_rand_file(path):
+        check_call('dd if=/dev/urandom of=%s bs=1K count=1' % path, shell=True)
+
+    def file_hash(path):
+        out = check_output(
+            'dd if=%s bs=1K skip=0 count=1 2> /dev/null | md5sum' % path,
+            shell=True
+        )
+        return out.decode().split()[0]
+
+    fs_type = request.param
+    fs_img = ''
+
+    fs_ubtype = fstype_to_ubname(fs_type)
+    check_ubconfig(u_boot_config, fs_ubtype)
+
+    mount_dir = u_boot_config.persistent_data_dir + '/scratch'
+
+    try:
+        check_call('mkdir -p %s' % mount_dir, shell=True)
+    except CalledProcessError as err:
+        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
+        call('rm -f %s' % fs_img, shell=True)
+        return
+
+    try:
+        md5val = {}
+        # Test Case 1
+        check_call('mkdir %s/test1' % mount_dir, shell=True)
+        new_rand_file('%s/test1/file1' % mount_dir)
+        md5val['test1'] = file_hash('%s/test1/file1' % mount_dir)
+
+        # Test Case 2
+        check_call('mkdir %s/test2' % mount_dir, shell=True)
+        new_rand_file('%s/test2/file1' % mount_dir)
+        new_rand_file('%s/test2/file_exist' % mount_dir)
+        md5val['test2'] = file_hash('%s/test2/file1' % mount_dir)
+
+        # Test Case 3
+        check_call('mkdir -p %s/test3/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test3/dir1/file1' % mount_dir)
+        md5val['test3'] = file_hash('%s/test3/dir1/file1' % mount_dir)
+
+        # Test Case 4
+        check_call('mkdir -p %s/test4/dir1' % mount_dir, shell=True)
+        check_call('mkdir -p %s/test4/dir2/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test4/dir1/file1' % mount_dir)
+        md5val['test4'] = file_hash('%s/test4/dir1/file1' % mount_dir)
+
+        # Test Case 5
+        check_call('mkdir -p %s/test5/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test5/file2' % mount_dir)
+        md5val['test5'] = file_hash('%s/test5/file2' % mount_dir)
+
+        # Test Case 6
+        check_call('mkdir -p %s/test6/dir2/existing' % mount_dir, shell=True)
+        new_rand_file('%s/test6/existing' % mount_dir)
+        md5val['test6'] = file_hash('%s/test6/existing' % mount_dir)
+
+        # Test Case 7
+        check_call('mkdir -p %s/test7/dir1' % mount_dir, shell=True)
+        check_call('mkdir -p %s/test7/dir2/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test7/dir2/dir1/file1' % mount_dir)
+        md5val['test7'] = file_hash('%s/test7/dir2/dir1/file1' % mount_dir)
+
+        # Test Case 8
+        check_call('mkdir -p %s/test8/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test8/dir1/file1' % mount_dir)
+        md5val['test8'] = file_hash('%s/test8/dir1/file1' % mount_dir)
+
+        # Test Case 9
+        check_call('mkdir -p %s/test9/dir1/nested/inner' % mount_dir, shell=True)
+        new_rand_file('%s/test9/dir1/nested/inner/file1' % mount_dir)
+
+        # Test Case 10
+        check_call('mkdir -p %s/test10' % mount_dir, shell=True)
+        new_rand_file('%s/test10/file1' % mount_dir)
+        md5val['test10'] = file_hash('%s/test10/file1' % mount_dir)
+
+        # Test Case 11
+        check_call('mkdir -p %s/test11/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test11/dir1/file1' % mount_dir)
+        md5val['test11'] = file_hash('%s/test11/dir1/file1' % mount_dir)
+
+        try:
+            # 128MiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
+    except CalledProcessError:
+        pytest.skip('Setup failed for filesystem: ' + fs_type)
+        return
+    else:
+        yield [fs_ubtype, fs_img, md5val]
+    finally:
+        call('rm -rf %s' % mount_dir, shell=True)
+        call('rm -f %s' % fs_img, shell=True)
+
 #
 # Fixture for fat test
 #
diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
index faec2982489..c1447b4d43e 100644
--- a/test/py/tests/test_fs/fstest_helpers.py
+++ b/test/py/tests/test_fs/fstest_helpers.py
@@ -9,5 +9,7 @@ def assert_fs_integrity(fs_type, fs_img):
     try:
         if fs_type == 'ext4':
             check_call('fsck.ext4 -n -f %s' % fs_img, shell=True)
+        elif fs_type in ['fat12', 'fat16', 'fat32']:
+            check_call('fsck.fat -n %s' % fs_img, shell=True)
     except CalledProcessError:
         raise
diff --git a/test/py/tests/test_fs/test_rename.py b/test/py/tests/test_fs/test_rename.py
new file mode 100644
index 00000000000..df2b2fd2945
--- /dev/null
+++ b/test/py/tests/test_fs/test_rename.py
@@ -0,0 +1,372 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright 2025 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
+#
+# U-Boot File System:rename Test
+
+
+import pytest
+
+from fstest_defs import *
+from fstest_helpers import assert_fs_integrity
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.slow
+class TestRename(object):
+    def test_rename1(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 1 - rename a file (successful mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 1 - rename a file'):
+            d = 'test1'
+            src = '%s/file1' % d
+            dst = '%s/file2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('file1' not in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test1'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename2(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 2 - rename a file to an existing file (successful mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 2 - rename a file to an existing file'):
+            d = 'test2'
+            src = '%s/file1' % d
+            dst = '%s/file_exist' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('file1' not in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test2'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename3(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 3 - rename a directory (successful mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 3 - rename a directory'):
+            d = 'test3'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s/file1' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' not in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test3'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename4(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 4 - rename a directory to an existing directory (successful
+        mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 4 - rename a directory to an existing directory'):
+            d = 'test4'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s/dir1/file1' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' not in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test4'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename5(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 5 - rename a directory to an existing file (failed mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 5 - rename a directory to an existing file'):
+            d = 'test5'
+            src = '%s/dir1' % d
+            dst = '%s/file2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' in ''.join(output))
+            assert('file2' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test5'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename6(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 6 - rename a file to an existing empty directory (failed mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 6 - rename a file to an existing empty directory'):
+            d = 'test6'
+            src = '%s/existing' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s' % (ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir2' in ''.join(output))
+            assert('existing' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test6'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename7(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 7 - rename a directory to a non-empty directory (failed mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 7 - rename a directory to a non-empty directory'):
+            d = 'test7'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s/dir1/file1' % (ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' in ''.join(output))
+            assert('dir2' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test7'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename8(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 8 - rename a directory inside itself (failed mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 8 - rename a directory inside itself'):
+            d = 'test8'
+            src = '%s/dir1' % d
+            dst = '%s/dir1/dir1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s/file1' % (ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (src),
+            ])
+            assert('file1' in ''.join(output))
+            assert('dir1' not in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test8'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename9(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 9 - rename a directory inside itself with backtracks (failed
+        mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 9 - rename a directory inside itself with backtracks'):
+            d = 'test9'
+            src = '%s/dir1/nested' % d
+            dst = '%s/dir1/nested/inner/./../../../dir1/nested/inner/another' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s/dir1' % (d),
+            ])
+            assert('nested' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (src),
+            ])
+            assert('inner' in ''.join(output))
+            assert('nested' not in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename10(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 10 - rename a file to itself (successful mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 10 - rename a file to itself'):
+            d = 'test10'
+            src = '%s/file1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, src),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s' % (ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('file1' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test10'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename11(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 11 - rename a directory to itself (successful mv)
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 11 - rename a directory to itself'):
+            # / at the end here is intentional. Ensures trailing / doesn't
+            # affect mv producing an updated dst path for fs_rename
+            d = 'test11/'
+            src = '%sdir1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                'mv host 0:0 %s %s' % (src, d),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'load host 0:0 %x /%s/file1' % (ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                'ls host 0:0 %s' % (d),
+            ])
+            assert('dir1' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test11'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
-- 
2.34.1

