Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B33C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 10:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE3C988811;
	Wed,  3 Jul 2024 12:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="xD2DYAsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72DF8880C; Wed,  3 Jul 2024 12:13:09 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9F988805
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 12:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 49E08148A648; Wed,  3 Jul 2024 12:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1720001585; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=pmUsb6P7kswX+kfzCcMBvixF7e5y7ynxBYoWPC3mNIs=;
 b=xD2DYAsS6NUg9dnK+L2INaJ1QPNHhYeKndJWI6rqgyI43XbOgCIV0uOMv10HisSkE+6hq6
 hwGq7v0weT1A0DX4JyCnxJJoXFROGThwTEm4q9P9jnRmGeIA7DR9WvDa4WeX9z4yXbTNrF
 spMlb051q/2ncff4NHvQQZPOeMPcZAHgRQCt4vho+gknY7oh01y+Y34m2WkCzgC3iAEj17
 9lq6dLSErKrkzIjkQK3kOR2FeJehNQZSNdhwVHRaLrIxGXHMHQr6UBVig9RBIfy96k0MAw
 q19T+08BjMNzM+ysLqqL+uiKAHCUUDRDjoIPmug3zo6M/CtHxW3RSSz6P+gVzA==
From: Alexander Dahl <ada@thorsis.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Heiko Schocher <hs@denx.de>,
 Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] fs: ubifs: Fix memleak and double free in u-boot wrapper
 functions
Date: Wed,  3 Jul 2024 12:12:55 +0200
Message-Id: <20240703101258.1670825-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703101258.1670825-1-ada@thorsis.com>
References: <20240703101258.1670825-1-ada@thorsis.com>
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

When mounting ubifs e.g. through command 'ubifsmount' one global static
superblock 'ubifs_sb' is used _and_ the requested volume is opened (like
in Linux).  The pointer returned by 'ubifs_open_volume()' is stored in
that superblock struct and freed later on cmd 'ubifsumount' or another
call to 'ubifsmount' with a different volume, through ubifs_umount() and
ubi_close_volume().

In ubifs_ls(), ubifs_exists(), ubifs_size(), and ubifs_read() the volume
was opened again, which is technically no problem with regard to
refcounting, but here the still valid pointer in sb was overwritten,
leading to a memory leak.  Even worse, when using one of those
functions and calling ubifsumount later, ubi_close_volume() was called
again but now on an already freed pointer, leading to a double free.
This actually crashed with different invalid memory accesses on a board
using the old distro boot and a rather long script handling RAUC
updates.

Example:

    > ubi part UBI
    > ubifsmount ubi0:boot
    > test -e ubi ubi0:boot /boot.scr.uimg
    > ubifsumount

The ubifs specific commands 'ubifsls' and 'ubifsload' check for a
mounted volume by themselves, for the generic fs variants 'ls', 'load',
(and 'size', and 'test -e') this is covered by special ubifs handling in
fs_set_blk_dev() and deeper down blk_get_device_part_str() then.  So for
ubifs_ls(), ubifs_exists(), ubifs_size(), and ubifs_read() we can be
sure the volume is opened and the necessary struct pointer in sb is
valid, so it is not needed to open volume again.

Fixes: 9eefe2a2b37 ("UBIFS: Implement read-only UBIFS support in U-Boot")
Fixes: 29cc5bcadfc ("ubifs: Add functions for generic fs use")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 fs/ubifs/ubifs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index 75de01e95f7..58b3f3659c1 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -566,7 +566,6 @@ int ubifs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
 
 int ubifs_ls(const char *filename)
 {
-	struct ubifs_info *c = ubifs_sb->s_fs_info;
 	struct file *file;
 	struct dentry *dentry;
 	struct inode *dir;
@@ -574,7 +573,6 @@ int ubifs_ls(const char *filename)
 	unsigned long inum;
 	int ret = 0;
 
-	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
 	if (!inum) {
 		ret = -1;
@@ -608,31 +606,24 @@ out_mem:
 		free(dir);
 
 out:
-	ubi_close_volume(c->ubi);
 	return ret;
 }
 
 int ubifs_exists(const char *filename)
 {
-	struct ubifs_info *c = ubifs_sb->s_fs_info;
 	unsigned long inum;
 
-	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
-	ubi_close_volume(c->ubi);
 
 	return inum != 0;
 }
 
 int ubifs_size(const char *filename, loff_t *size)
 {
-	struct ubifs_info *c = ubifs_sb->s_fs_info;
 	unsigned long inum;
 	struct inode *inode;
 	int err = 0;
 
-	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
-
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
 	if (!inum) {
 		err = -1;
@@ -650,7 +641,6 @@ int ubifs_size(const char *filename, loff_t *size)
 
 	ubifs_iput(inode);
 out:
-	ubi_close_volume(c->ubi);
 	return err;
 }
 
@@ -845,7 +835,6 @@ int ubifs_read(const char *filename, void *buf, loff_t offset,
 		return -1;
 	}
 
-	c->ubi = ubi_open_volume(c->vi.ubi_num, c->vi.vol_id, UBI_READONLY);
 	/* ubifs_findfile will resolve symlinks, so we know that we get
 	 * the real file here */
 	inum = ubifs_findfile(ubifs_sb, (char *)filename);
@@ -909,7 +898,6 @@ put_inode:
 	ubifs_iput(inode);
 
 out:
-	ubi_close_volume(c->ubi);
 	return err;
 }
 
-- 
2.39.2

