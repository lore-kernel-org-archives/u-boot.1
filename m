Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8872FD0BB7A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 09:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E9F89341;
	Thu, 24 Oct 2024 11:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Pmyo4lKP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003FF8806A; Thu, 24 Oct 2024 11:15:37 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC7489313
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 11:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.CtrlMice (43-114-103-145.static.glaslokaal.nl
 [145.103.114.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 46E0042343; 
 Thu, 24 Oct 2024 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729761332;
 bh=/qE7LnKNSJ1ZKqOycsMXnA9uPC0LRqrKL3Jp41kUZcE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Pmyo4lKPCXSEVkPLBWdthavtRrmPLtMzrd3OibzDo7z53g3GIoxocAqISsEOOR/yC
 KTTrH48ZmgFFFdy/RM+NfLY9Gysz7j1dTctwbzSuW9VwnhvhtB7GEzze5ooX+ZF16B
 sbnW9LSfrrW3+M9VjX05U+VJDyZYR5zv37/5uOlkVT//ueEdlASsrxtilUIMCSYFf/
 sg6ZRXycPoeqsTbrsx8DDKVhUul5ppXbvgmh6jb/vfoYQ9stUBFvnKAj5N/P9/+xSz
 AdquByUa+TvqkEeEiKc/QDOJdAFA8yG9O7GnFPqGkvlgpltKzb9v0NalKJC0GxXzDN
 1ej4CjOKmgF3g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Rob Clark <robdclark@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] fs: improve API documentation
Date: Thu, 24 Oct 2024 11:15:28 +0200
Message-ID: <20241024091529.31136-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024091529.31136-1-heinrich.schuchardt@canonical.com>
References: <20241024091529.31136-1-heinrich.schuchardt@canonical.com>
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

* Describe the fields of struct fs_dir_stream.
* Update fs_readdir() and fs_opendir() description.
* Fix Sphinx errors.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/fs.h | 66 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/include/fs.h b/include/fs.h
index ef540e7c23d..63727567ccc 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -25,7 +25,7 @@ struct blk_desc;
  * do_fat_fsload - Run the fatload command
  *
  * @cmdtp: Command information for fatload
- * @flag: Command flags (CMD_FLAG_...)
+ * @flag: Command flags (CMD_FLAG\_...)
  * @argc: Number of arguments
  * @argv: List of arguments
  * Return: result (see enum command_ret_t)
@@ -37,7 +37,7 @@ int do_fat_fsload(struct cmd_tbl *cmdtp, int flag, int argc,
  * do_ext2load - Run the ext2load command
  *
  * @cmdtp: Command information for ext2load
- * @flag: Command flags (CMD_FLAG_...)
+ * @flag: Command flags (CMD_FLAG\_...)
  * @argc: Number of arguments
  * @argv: List of arguments
  * Return: result (see enum command_ret_t)
@@ -145,7 +145,7 @@ int fs_size(const char *filename, loff_t *size);
  * @offset:	offset in the file from where to start reading
  * @len:	the number of bytes to read. Use 0 to read entire file.
  * @actread:	returns the actual number of bytes read
- * Return:	0 if OK with valid *actread, -1 on error conditions
+ * Return:	0 if OK with valid @actread, -1 on error conditions
  */
 int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
 	    loff_t *actread);
@@ -160,7 +160,7 @@ int fs_read(const char *filename, ulong addr, loff_t offset, loff_t len,
  * @offset:	offset in the file from where to start writing
  * @len:	the number of bytes to write
  * @actwrite:	returns the actual number of bytes written
- * Return:	0 if OK with valid *actwrite, -1 on error conditions
+ * Return:	0 if OK with valid @actwrite, -1 on error conditions
  */
 int fs_write(const char *filename, ulong addr, loff_t offset, loff_t len,
 	     loff_t *actwrite);
@@ -186,57 +186,73 @@ struct fs_dirent {
 	unsigned int type;
 	/** @size:		file size */
 	loff_t size;
-	/** @flags:		attribute flags (FS_ATTR_*) */
+	/** @attr:		attribute flags (FS_ATTR_*) */
 	u32 attr;
-	/** create_time:	time of creation */
+	/** @create_time:	time of creation */
 	struct rtc_time create_time;
-	/** access_time:	time of last access */
+	/** @access_time:	time of last access */
 	struct rtc_time access_time;
-	/** change_time:	time of last modification */
+	/** @change_time:	time of last modification */
 	struct rtc_time change_time;
-	/** name:		file name */
+	/** @name:		file name */
 	char name[FS_DIRENT_NAME_LEN];
 };
 
-/* Note: fs_dir_stream should be treated as opaque to the user of fs layer */
+/**
+ * struct fs_dir_stream - Structure representing an opened directory
+ *
+ * Struct fs_dir_stream should be treated opaque to the user of fs layer.
+ * The fields @desc and @part are used by the fs layer.
+ * File system drivers pass additional private fields with the pointers
+ * to this structure.
+ *
+ * @desc:	block device descriptor
+ * @part:	partition number
+ */
 struct fs_dir_stream {
-	/* private to fs. layer: */
 	struct blk_desc *desc;
 	int part;
 };
 
-/*
+/**
  * fs_opendir - Open a directory
  *
- * @filename: the path to directory to open
- * Return: a pointer to the directory stream or NULL on error and errno
- *    set appropriately
+ * .. note::
+ *    The returned struct fs_dir_stream should be treated opaque to the
+ *    user of the fs layer.
+ *
+ * @filename: path to the directory to open
+ * Return:
+ * A pointer to the directory stream or NULL on error and errno set
+ * appropriately
  */
 struct fs_dir_stream *fs_opendir(const char *filename);
 
-/*
+/**
  * fs_readdir - Read the next directory entry in the directory stream.
  *
- * Works in an analogous way to posix readdir().  The previously returned
- * directory entry is no longer valid after calling fs_readdir() again.
+ * fs_readir works in an analogous way to posix readdir().
+ * The previously returned directory entry is no longer valid after calling
+ * fs_readdir() again.
  * After fs_closedir() is called, the returned directory entry is no
  * longer valid.
  *
  * @dirs: the directory stream
- * Return: the next directory entry (only valid until next fs_readdir() or
- *    fs_closedir() call, do not attempt to free()) or NULL if the end of
- *    the directory is reached.
+ * Return:
+ * the next directory entry (only valid until next fs_readdir() or
+ * fs_closedir() call, do not attempt to free()) or NULL if the end of
+ * the directory is reached.
  */
 struct fs_dirent *fs_readdir(struct fs_dir_stream *dirs);
 
-/*
+/**
  * fs_closedir - close a directory stream
  *
  * @dirs: the directory stream
  */
 void fs_closedir(struct fs_dir_stream *dirs);
 
-/*
+/**
  * fs_unlink - delete a file or directory
  *
  * If a given name is a directory, it will be deleted only if it's empty
@@ -246,7 +262,7 @@ void fs_closedir(struct fs_dir_stream *dirs);
  */
 int fs_unlink(const char *filename);
 
-/*
+/**
  * fs_mkdir - Create a directory
  *
  * @filename: Name of directory to create
@@ -292,7 +308,7 @@ int do_fs_type(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
  * do_fs_types - List supported filesystems.
  *
  * @cmdtp: Command information for fstypes
- * @flag: Command flags (CMD_FLAG_...)
+ * @flag: Command flags (CMD_FLAG\_...)
  * @argc: Number of arguments
  * @argv: List of arguments
  * Return: result (see enum command_ret_t)
-- 
2.45.2

