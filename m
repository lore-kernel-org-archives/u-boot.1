Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F1C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DCA282A27;
	Sun, 13 Apr 2025 10:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534702;
	bh=uwJGlGH24UrGTOm0jbUfOMGhLGcDrKXW3s09Yxf/kAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t0gL6nbSATwlxHB+zomBAYKOYGmyCKPIwUlcfWJroZCE//vszD+qccxAKKQpNHU0X
	 MrC8Rz5iciRueFhw8xINQz6usSg3GZoOGsHESKfBUyjiFxYyiZMwKIbC8/0Na8+Hmn
	 ZDChgsjKgvWhvKZuembptRmZWjynroLA96c8EkY//vT9qYPmCOM+IQdeVb5vw6gB4L
	 NKNhuFVMAIR7ZAuifNI/3lq07uLjXEFLtMqlGTwahrpcZkFqaZvaj3sd6JcdwZh2pP
	 1jdjhBKXVWmDy9ks3ml8tkV9MuAPPguFe4PL3EDJ4EtK2Y+7IqRzLC8/w6oEMLodFM
	 Qe7ilGTsZ1Itw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670AA8295C; Sun, 13 Apr 2025 10:58:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1E78294C
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Si0KjVQj"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2C5D81007B829; 
 Sun, 13 Apr 2025 10:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534696; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=uwJGlGH24UrGTOm0jbUfOMGhLGcDrKXW3s09Yxf/kAs=;
 b=Si0KjVQjKejwilg+MwHIK0JajEsw+xAr37FYnIW3OKVGvEtu9hlFZ0CdNfdYR2y00xOkum
 PK5RwQ3tmwzFYzT4t1AujijmakQweIn1NbGvudiRm9/8QMcoVl5D78X7tHgOMfrLMHZIBT
 89rCZKtDfHHPvk+7rfekJMH+NZdC0MhKfg3mi67QoIImSdQ/0yhl4q7KBR3w2TetE2zMtr
 BSMCcRYzYQj6GkoqV10qp1rEmyhryp7yghb1Jtk8Q4om8x+jjxk3Mbnz4vfwZFnj4FzNc3
 UcFJS6f49S9HBvvEB2m1IK15mYFqL0VZ5oFKewem06W9//w9dACBr6wgUkBWLg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] fs: exfat: Rework exfat_fs_readdir() to behave like
 exfat_fs_ls()
Date: Sun, 13 Apr 2025 10:55:01 +0200
Message-ID: <20250413085740.5953-3-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The exfat_fs_readdir() depends on state created in exfat_fs_opendir(),
but that state may be disrupted by fs_close() called by the FS layer
in fs_opendir(), because exfat porting layer unmounts the filesystem
in ->close() callback.

To avoid this disruption, avoid creating state in exfat_fs_opendir(),
cache only the directory name to list there, and rework exfat_fs_readdir()
to work in a similar way to exfat_fs_ls(). That is, make exfat_fs_readdir()
open the directory, look up specific entry, extract its properties to be
reported to FS layer, and close the directory. This is slow, but avoids
the disruption. The slowness does not affect regular 'ls' command, which
uses exfat_fs_ls() fast path.

Fixes: b86a651b646c ("fs: exfat: Add U-Boot porting layer")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/exfat/io.c | 111 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 44 deletions(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 12498a4a6ec..004ba5d3e45 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -597,15 +597,13 @@ ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
 }
 
 #ifdef __UBOOT__
+#define PATH_MAX FS_DIRENT_NAME_LEN
+
 struct exfat_dir_stream {
+	char dirname[PATH_MAX];
 	struct fs_dir_stream fs_dirs;
 	struct fs_dirent dirent;
-
-	struct exfat_node* node;
-	struct exfat_iterator it;
-	/* State tracker flags for emulated . and .. dirents */
-	bool dot;
-	bool dotdot;
+	int offset;
 };
 
 int exfat_fs_probe(struct blk_desc *fs_dev_desc,
@@ -626,8 +624,6 @@ error:
 	return ret;
 }
 
-#define PATH_MAX FS_DIRENT_NAME_LEN
-
 /* Adapted from uclibc 1.0.35 */
 static char *exfat_realpath(const char *path, char got_path[])
 {
@@ -721,31 +717,31 @@ int exfat_lookup_realpath(struct exfat* ef, struct exfat_node** node,
 int exfat_fs_opendir(const char *filename, struct fs_dir_stream **dirsp)
 {
 	struct exfat_dir_stream *dirs;
+	struct exfat_node *dnode;
 	int err;
 
-	dirs = calloc(1, sizeof(*dirs));
-	if (!dirs)
-		return -ENOMEM;
-
-	err = exfat_lookup_realpath(&ctxt.ef, &dirs->node, filename);
+	err = exfat_lookup_realpath(&ctxt.ef, &dnode, filename);
 	if (err)
-		goto err_out;
+		return err;
 
-	if (!(dirs->node->attrib & EXFAT_ATTRIB_DIR)) {
+	if (!(dnode->attrib & EXFAT_ATTRIB_DIR))
 		err = -ENOTDIR;
-		goto err_out;
-	}
 
-	err = exfat_opendir(&ctxt.ef, dirs->node, &dirs->it);
+	exfat_put_node(&ctxt.ef, dnode);
+
 	if (err)
-		goto err_out;
+		return err;
+
+	dirs = calloc(1, sizeof(*dirs));
+	if (!dirs)
+		return -ENOMEM;
+
+	strcpy(dirs->dirname, filename);
+	dirs->offset = -1;
 
 	*dirsp = &dirs->fs_dirs;
 
 	return 0;
-err_out:
-	free(dirs);
-	return err;
 }
 
 int exfat_fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
@@ -753,50 +749,77 @@ int exfat_fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 	struct exfat_dir_stream *dirs =
 		container_of(fs_dirs, struct exfat_dir_stream, fs_dirs);
 	struct fs_dirent *dent = &dirs->dirent;
-	struct exfat_node* node;
+	struct exfat_node *dnode, *node;
+	struct exfat_iterator it;
+	int offset = 0;
+	int err;
+
+	err = exfat_lookup_realpath(&ctxt.ef, &dnode, dirs->dirname);
+	if (err)
+		return err;
+
+	if (!(dnode->attrib & EXFAT_ATTRIB_DIR)) {
+		err = -ENOTDIR;
+		goto err_out;
+	}
 
 	/* Emulate current directory ./ */
-	if (!dirs->dot) {
-		dirs->dot = true;
+	if (dirs->offset == -1) {
+		dirs->offset++;
 		snprintf(dent->name, FS_DIRENT_NAME_LEN, ".");
 		dent->type = FS_DT_DIR;
 		*dentp = dent;
-		return 0;
+		goto err_out;
 	}
 
 	/* Emulate parent directory ../ */
-	if (!dirs->dotdot) {
-		dirs->dotdot = true;
+	if (dirs->offset == 0) {
+		dirs->offset++;
 		snprintf(dent->name, FS_DIRENT_NAME_LEN, "..");
 		dent->type = FS_DT_DIR;
 		*dentp = dent;
-		return 0;
+		goto err_out;
 	}
 
+	err = exfat_opendir(&ctxt.ef, dnode, &it);
+	if (err)
+		goto err_out;
+
+	*dentp = NULL;
+
 	/* Read actual directory content */
-	node = exfat_readdir(&dirs->it);
-	if (!node) {	/* No more content, reset . and .. emulation */
-		dirs->dot = false;
-		dirs->dotdot = false;
-		return 1;
-	}
+	while ((node = exfat_readdir(&it))) {
+		if (dirs->offset != ++offset) {
+			exfat_put_node(&ctxt.ef, node);
+			continue;
+		}
 
-	exfat_get_name(node, dent->name);
-	if (node->attrib & EXFAT_ATTRIB_DIR) {
-		dent->type = FS_DT_DIR;
-	} else {
-		dent->type = FS_DT_REG;
-		dent->size = node->size;
+		exfat_get_name(node, dent->name);
+		if (node->attrib & EXFAT_ATTRIB_DIR) {
+			dent->type = FS_DT_DIR;
+		} else {
+			dent->type = FS_DT_REG;
+			dent->size = node->size;
+		}
+		exfat_put_node(&ctxt.ef, node);
+		*dentp = dent;
+		dirs->offset++;
+		break;
 	}
 
-	*dentp = dent;
+	exfat_closedir(&ctxt.ef, &it);
 
-	return 0;
+err_out:
+	exfat_put_node(&ctxt.ef, dnode);
+	return err;
 }
 
 void exfat_fs_closedir(struct fs_dir_stream *fs_dirs)
 {
-	free(fs_dirs);
+	struct exfat_dir_stream *dirs =
+		container_of(fs_dirs, struct exfat_dir_stream, fs_dirs);
+
+	free(dirs);
 }
 
 int exfat_fs_ls(const char *dirname)
-- 
2.47.2

