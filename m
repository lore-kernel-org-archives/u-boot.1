Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1545CC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 13:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53487808E6;
	Wed, 22 Jan 2025 14:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VzYFYY2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B820801FB; Wed, 22 Jan 2025 06:33:42 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0EA80137
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 06:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6e9586b82so543786585a.1
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 21:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737524017; x=1738128817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kCy9K3aRrYBcEMub4NYwKERokocXQ9n8RtIa3Vb+2I=;
 b=VzYFYY2J8C87VsBbLmA+XyUiPktfHhkEkO7QrGeAKONLLKpedG+1XN6OKZMCzv2cVr
 xIV+mBJx8CtwLjGsR9ZBVDMJuvjpL7EF418Csp00EHqmsRNWqBGPGfgvnTb+TYTHeXQD
 N8B1qUQV4GRJO7SVF/TVsW9iXwHOIpULKwnsOdog/TAlfVT8jPFOUS/9CvnbKHnu9XJO
 XGuhoMdJJvaRe2WEFeiYOgwgCUDBi8wEJf16TOnP9ivbOz4fpZeJ+DO0jZ848aTVudiU
 sF7J21gF0Vx/rFf0+bDgehva7Z6ozFiXu+hryWyH58Xiz8JL1EBNxJyRrZdo5Iokl+LV
 ipMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737524017; x=1738128817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kCy9K3aRrYBcEMub4NYwKERokocXQ9n8RtIa3Vb+2I=;
 b=XxdNGWr/3TClx/fczxG+X0eBq5A/uc6YrOxdZxDH6LYkX/NNqureK5lVng0YmsvzcN
 xLaRqlAnz2hbX537YIkOdTA/74Tw6U90JrpY6ojycDhGZNVuy4BVboBiOc21Sv7voG/7
 f5fyMNDFBEluwL/LmtKO1Zd+0ImkPdqFZrUZ2aYnEubyZWqRr3o/GoLMLnFtjRNLlOec
 TyHhjkMawDpY8iZBbRp2S7wM9c9Wq5ZCYo0oMK3G+j8K/x2xqHUu3ChXyvG449iVhsXz
 L0iGpvXvlj7whfVIibuLmbVSckdjIg8GN8Kc+9wnhm1npxNBWkRUN++iDOjIkWiATHo4
 vm1g==
X-Gm-Message-State: AOJu0YyFktzDkKkup3YW+B9vbl4FWx1E3h1rsdFYpCPFQfnDw4V2H4Ec
 oFTf0nrGbe0D9NRNcZMgrLNOrwWTF48fUCw9nZVcAgp5anrqwPjS6iiMyWrK+ok=
X-Gm-Gg: ASbGncvOT0hce/8eKp+4CYep/LLf4V1KZSW7tVgaPhdC4RWeKu+BcsTR7CVr2QlfzgD
 fiXwczPRr86tdzKtmqk5BAKG6YkT3T4FCWJ69ptF7QWk/ku/Fh5dj/NtzNl7Rdu4WE6AOYy9gJx
 qLF8vzXI+X6WFD//kDR+LcEKFZdXaG6NHiEp2b1ul/o+XcaxOX7gFJqNQ/89TEFhIfx80Sy2xKr
 n+XjBAXxDdVS2dqmM+MmXAeTDjwfD6yO01PZkTRhtN6xBfOlNzGAe1N81m2nvHNaAcMnneGHRt1
 1LvOPex3jHv839kRmJqk5ehM4XS30dfApAR8RoViReze3iiNhLvLmGjlNYZr2Tnyv7BmW/a/hr3
 9Nx5Q
X-Google-Smtp-Source: AGHT+IF9B3grxmg2838lIhTmKpChLWAeCtoiGWpPNJh6faLvl3d/YfNl6YRRR+0QaKMEplDpCJXtvA==
X-Received: by 2002:a05:620a:318c:b0:7b6:d350:b357 with SMTP id
 af79cd13be357-7be63219907mr3346298485a.9.1737524016913; 
 Tue, 21 Jan 2025 21:33:36 -0800 (PST)
Received: from localhost.localdomain
 (bras-base-btfdon1720w-grc-54-174-88-143-14.dsl.bell.ca. [174.88.143.14])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98b2sm634136785a.76.2025.01.21.21.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 21:33:35 -0800 (PST)
From: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
To: u-boot@lists.denx.de
Cc: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] fs: fat: add rename
Date: Wed, 22 Jan 2025 00:32:28 -0500
Message-Id: <20250122053232.17365-4-gabriel.dalimonte@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Jan 2025 14:22:36 +0100
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
rename(). The ordering of operations attempting to minimize the chance
for data loss in unexpected circumstances.

The fatrename command is added mostly for the purpose of testing
through the sandbox build.

Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
---

 cmd/fat.c                               |  14 +
 fs/fat/fat_write.c                      | 284 ++++++++++++++++++
 fs/fs.c                                 |   3 +-
 include/fat.h                           |   1 +
 test/py/tests/test_fs/conftest.py       | 121 ++++++++
 test/py/tests/test_fs/fstest_helpers.py |   2 +
 test/py/tests/test_fs/test_rename.py    | 366 ++++++++++++++++++++++++
 7 files changed, 790 insertions(+), 1 deletion(-)
 create mode 100644 test/py/tests/test_fs/test_rename.py

diff --git a/cmd/fat.c b/cmd/fat.c
index 5b7484dc1a..56e6bd0f89 100644
--- a/cmd/fat.c
+++ b/cmd/fat.c
@@ -132,4 +132,18 @@ U_BOOT_CMD(
 	"<interface> [<dev[:part]>] <directory>\n"
 	"    - create a directory in 'dev' on 'interface'"
 );
+
+static int do_fat_rename(struct cmd_tbl *cmdtp, int flag, int argc,
+			 char *const argv[])
+{
+	return do_rename(cmdtp, flag, argc, argv, FS_TYPE_FAT);
+}
+
+U_BOOT_CMD(
+	fatrename,	5,	1,	do_fat_rename,
+	"rename a file/directory",
+	"<interface> [<dev[:part]>] <old_path> <new_path>\n"
+	"    - renames a file/directory in 'dev' on 'interface' from 'old_path'\n"
+	"      to 'new_path'"
+);
 #endif
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index b86e78abc0..f9f7051e30 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1823,3 +1823,287 @@ exit:
 	free(dotdent);
 	return ret;
 }
+
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
+/**
+ * check_path_prefix() - errors if a proposed path contains another path
+ *
+ * note: the iterator may be pointing to any directory entry in the directory
+ *
+ * @prefix_clust:	start cluster of the final directory in the prefix path
+ * @path_itr:	iterator of the path to check.
+ * Return:	-errno on error, 0 on success
+ */
+static int check_path_prefix(loff_t prefix_clust, fat_itr *path_itr)
+{
+	fat_itr *itr = NULL;
+	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	int ret;
+
+	itr = malloc_cache_aligned(sizeof(fat_itr));
+	if (!itr) {
+		debug("Error: allocating memory\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	/* duplicate fsdata */
+	*itr = *path_itr;
+	fsdata = *itr->fsdata;
+
+	/* allocate local fat buffer */
+	fsdata.fatbuf = malloc_cache_aligned(FATBUFSIZE);
+	if (!fsdata.fatbuf) {
+		debug("Error: allocating memory\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	fsdata.fatbufnum = -1;
+	itr->fsdata = &fsdata;
+
+	/* ensure iterator is at the first directory entry */
+	ret = fat_move_to_cluster(itr, itr->start_clust);
+	if (ret)
+		goto exit;
+
+	while (1) {
+		if (prefix_clust == itr->start_clust) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (itr->is_root) {
+			ret = 0;
+			break;
+		}
+
+		/* Should not occur in a well-formed FAT filesystem besides the root */
+		if (fat_itr_parent(itr)) {
+			ret = -EIO;
+			break;
+		}
+	}
+
+exit:
+	free(fsdata.fatbuf);
+	free(itr);
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
+		printf("Error: out of memory\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+	split_filename(old_path_copy, &old_dirname, &old_basename);
+	split_filename(new_path_copy, &new_dirname, &new_basename);
+
+	if (normalize_longname(l_new_basename, new_basename)) {
+		printf("FAT: illegal filename (%s)\n", new_basename);
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
+		printf("%s: doesn't exist (%d)\n", old_dirname, ret);
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (!find_directory_entry(old_itr, old_basename)) {
+		log_err("%s: doesn't exist (%d)\n", old_basename, -ENOENT);
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
+		printf("%s: doesn't exist (%d)\n", new_dirname, ret);
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
+				printf("Error: directory is not empty: %d\n",
+				       n_entries);
+				ret = -EINVAL;
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
+				  old_itr->dent->size, old_itr->dent->attr);
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
+			printf("Error: Directory missing parent entry (..)\n");
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
+	if (ret)
+		goto exit;
+
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
index 160a43c957..424adfbbfb 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -208,12 +208,13 @@ static struct fstype_info fstypes[] = {
 		.write = file_fat_write,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
+		.rename = fat_rename,
 #else
 		.write = fs_write_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
-#endif
 		.rename = fs_rename_unsupported,
+#endif
 		.uuid = fat_uuid,
 		.opendir = fat_opendir,
 		.readdir = fat_readdir,
diff --git a/include/fat.h b/include/fat.h
index 3dce99a23c..ca97880de1 100644
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
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index af2adaf164..9e188f2228 100644
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
+        check_call('mkdir %s/test4/dir2' % mount_dir, shell=True)
+        new_rand_file('%s/test4/dir1/file1' % mount_dir)
+        md5val['test4'] = file_hash('%s/test4/dir1/file1' % mount_dir)
+
+        # Test Case 5
+        check_call('mkdir -p %s/test5/dir1' % mount_dir, shell=True)
+        new_rand_file('%s/test5/file2' % mount_dir)
+        md5val['test5'] = file_hash('%s/test5/file2' % mount_dir)
+
+        # Test Case 6
+        check_call('mkdir -p %s/test6/dir2' % mount_dir, shell=True)
+        new_rand_file('%s/test6/file1' % mount_dir)
+        md5val['test6'] = file_hash('%s/test6/file1' % mount_dir)
+
+        # Test Case 7
+        check_call('mkdir -p %s/test7/dir1' % mount_dir, shell=True)
+        check_call('mkdir -p %s/test7/dir2' % mount_dir, shell=True)
+        new_rand_file('%s/test7/dir2/file1' % mount_dir)
+        md5val['test7'] = file_hash('%s/test7/dir2/file1' % mount_dir)
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
index faec298248..c1447b4d43 100644
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
index 0000000000..1a849da910
--- /dev/null
+++ b/test/py/tests/test_fs/test_rename.py
@@ -0,0 +1,366 @@
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
+        Test Case 1 - rename a file
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 1 - rename a file'):
+            d = 'test1'
+            src = '%s/file1' % d
+            dst = '%s/file2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 2 - rename a file to an existing file
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 2 - rename a file to an existing file'):
+            d = 'test2'
+            src = '%s/file1' % d
+            dst = '%s/file_exist' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 3 - rename a directory
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 3 - rename a directory'):
+            d = 'test3'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 4 - rename a directory to an existing directory
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 4 - rename a directory to an existing directory'):
+            d = 'test4'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 5 - rename a directory to an existing file
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 5 - rename a directory to an existing file'):
+            d = 'test5'
+            src = '%s/dir1' % d
+            dst = '%s/file2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            #assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
+            ])
+            assert('dir1' in ''.join(output))
+            assert('file2' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s' % (fs_type, ADDR, dst),
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
+        Test Case 6 - rename a file to an existing empty directory
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 6 - rename a file to an existing empty directory'):
+            d = 'test6'
+            src = '%s/file1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            #assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s' % (fs_type, ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
+            ])
+            assert('dir2' in ''.join(output))
+            assert('file1' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                'md5sum %x $filesize' % ADDR,
+                'setenv filesize'])
+            assert(md5val['test6'] in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename7(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 7 - rename a directory to a non-empty directory should fail
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 7 - rename a directory to a non-empty directory should fail'):
+            d = 'test7'
+            src = '%s/dir1' % d
+            dst = '%s/dir2' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+            assert('directory is not empty' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, dst),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 8 - rename a directory inside itself
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 8 - rename a directory inside itself'):
+            d = 'test8'
+            src = '%s/dir1' % d
+            dst = '%s/dir1/dir1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
+            ])
+            assert('dir1' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, src),
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
+        Test Case 9 - rename a directory inside itself with backtracks
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 9 - rename a directory inside itself with backtracks'):
+            d = 'test9'
+            src = '%s/dir1/nested' % d
+            dst = '%s/dir1/nested/inner/./../../../dir1/nested/inner/another' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, dst),
+            ])
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s/dir1' % (fs_type, d),
+            ])
+            assert('nested' in ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, src),
+            ])
+            assert('inner' in ''.join(output))
+            assert('nested' not in ''.join(output))
+            assert_fs_integrity(fs_type, fs_img)
+
+    def test_rename10(self, u_boot_console, fs_obj_rename):
+        """
+        Test Case 10 - rename a file to itself
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 10 - rename a file to itself'):
+            d = 'test10'
+            src = '%s/file1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, src),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s' % (fs_type, ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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
+        Test Case 11 - rename a directory to itself
+        """
+        fs_type, fs_img, md5val = fs_obj_rename
+        with u_boot_console.log.section('Test Case 11 - rename a directory to itself'):
+            d = 'test11'
+            src = '%s/dir1' % d
+            output = u_boot_console.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'setenv filesize',
+                '%srename host 0:0 %s %s ' % (fs_type, src, src),
+            ])
+            assert('' == ''.join(output))
+
+            output = u_boot_console.run_command_list([
+                '%sload host 0:0 %x /%s/file1' % (fs_type, ADDR, src),
+                'printenv filesize'])
+            assert('filesize=400' in output)
+
+            output = u_boot_console.run_command_list([
+                '%sls host 0:0 %s' % (fs_type, d),
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

