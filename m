Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC96C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 586DC60684;
	Sun,  2 Aug 2026 13:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 64bNmAuEOpo2; Sun,  2 Aug 2026 13:27:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CD6B6065E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677260;
	bh=dEEGRsS1EGHzBJziloFbvh+7JZpBgQB8zZ7PC833kdE=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k4LotYCCyF5EMOgTb+zx85wscrscdY+Er0OWUUmbRGcZdoJtgayhxyB/0tO9bPXnF
	 s1pqOvr/SgKcUBZ+OhT+DRWDFjytzLJZoUzv8ZcK0Xd1oRoGChO7nn+wHA9wm0q9sL
	 mZo06kxwnmfDBgFFA3lmW6BDixFW4UWc1n8WBY1BWbcwN3cX1fzByQjVkL1H8AxOCR
	 lHz6A3bf5X6I9CeLvE7SlSwpXXwwGwHTU3iaBRDBjtTo7XJFjB2OkVau4R9YkFKgzq
	 gq9VlZ5vgFat1rcEOYtQ4XMowh8L7ttUM3MOUuJwIJdXRGH3icqNJd1gTCQnjSix4w
	 zvcs2vj3NSsLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CD6B6065E;
	Sun,  2 Aug 2026 13:27:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B2F226C
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 05:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2892C40696
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 05:42:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJ4tZ4hbgKTH for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 05:42:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 77E1340694
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 77E1340694
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77E1340694
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 05:42:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1DB844F6; Sun,  2 Aug 2026 07:42:25 +0200 (CEST)
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F044D80117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 07:42:22 +0200 (CEST)
Date: Sun, 02 Aug 2026 05:42:19 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs: btrfs: report file sizes from readdir
Message-ID: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 961291d65832f568a5e8e7de1f66f047fdf09051
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785649341; x=1785908541;
 bh=dEEGRsS1EGHzBJziloFbvh+7JZpBgQB8zZ7PC833kdE=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Jl25jriOGaRZnlMQqs5cb9PEwvQRtIlo5aKRNJmZu33VxFP784iWC1v8nNrRHkBxd
 rkG8eRCcW0MuupVidAiFsjrf27zghcvAyKsX4TXco7+VV0WaaIy/y2uiS1JDVeWH+n
 yCy9S7cs/jiCgSVw0fxEiKnjYL4dOUGjueB38B6feGcH4aff8PZSxdUFRydvF3thKu
 uOT3JqcdwMCDe9rmVrf3/z2iH/zugr8Bnnrc0D83uEeZysErFnYc+RjMQdl4K8Ts4P
 0zxBBCpa+lCr3xff228zSVYmBg1wRx7hm9rA2r7dum+NgNeYNi4T2CGU9H1RWCs9Hl
 noC8Fc7MWDrwA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=Jl25jriO
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="Jl25jriO"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

btrfs_readdir() zeroes the dirent and fills in only the name and the
type, so dent->size stays 0 and every file is listed as zero bytes:

  =3D> ls host 0 /
          0   f_192k.bin
          0   small_3k.bin

Reads themselves are fine, since btrfs_read() takes the size from
btrfs_size(), which does its own inode item lookup. It affects EFI
too: dir_read() in lib/efi_loader/efi_file.c copies dent->size into
both file_size and physical_size, so an EFI application enumerating a
directory on btrfs sees every file as empty, which is the generic-code
path Alexey's readdir series moves btrfs onto.

The custom listing that fs_ls_generic() replaced looked the inode item
up and printed the real size, and every other filesystem in the tree
fills dent->size in its own readdir: ext4fs.c:327, exfat io.c:805,
erofs fs.c:186, squashfs sqfs.c:1095 and fat.c:1555.

btrfs_next_dir_entry() already has the dir item mapped, so read the
key it points at while we are there and hand it back to the caller,
and use that to reach the inode item. A subvolume entry points at a
root item instead and has no size of its own, so leave that one at 0.

  =3D> ls host 0 /
     196608   f_192k.bin
       3000   small_3k.bin

Fixes: 31cf3f177823 ("fs: btrfs: use fs_ls_generic() and drop custom implem=
entation")
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
The Fixes: commit is in Tom's tree, applied 2026-07-10 (b4-ty
178372904690.2905849.8798963092987519032.b4-ty@konsulko.com); it has not
reached master yet, so that SHA will not resolve on a public clone today.

Found by a btrfs test suite I am preparing for test/py; I will send that
separately once the pending zstd inline extent fix is applied, since it
depends on it.
 fs/btrfs/btrfs.c    | 24 +++++++++++++++++++++++-
 fs/btrfs/ctree.h    |  3 ++-
 fs/btrfs/dir-item.c |  7 ++++++-
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index e663dda12e80..b2856be0662f 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -93,7 +93,10 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct =
fs_dirent **dentp)
 =09struct btrfs_dir_stream *dirs =3D container_of(fs_dirs, struct btrfs_di=
r_stream, parent);
 =09struct btrfs_fs_info *fs_info =3D current_fs_info;
 =09struct fs_dirent *dent =3D &dirs->dirent;
+=09struct btrfs_inode_item *ii;
 =09struct btrfs_root *root;
+=09struct btrfs_path path;
+=09struct btrfs_key location;
 =09struct btrfs_key key;
 =09u8 type;
 =09int ret;
@@ -110,13 +113,32 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, stru=
ct fs_dirent **dentp)
=20
 =09memset(dent, 0, sizeof(*dent));
 =09ret =3D btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, dent->name=
,
-=09=09=09=09   sizeof(dent->name), &type);
+=09=09=09=09   sizeof(dent->name), &type, &location);
 =09if (ret < 0)
 =09=09return ret;
 =09if (ret > 0)
 =09=09return -ENOENT;
=20
 =09dent->type =3D btrfs_dirent_type_to_fs_type(type);
+
+=09/*
+=09 * A subvolume entry points at a root item rather than an inode, and
+=09 * has no size of its own.  Everything else carries one, and the fs
+=09 * layer prints it, so look it up.
+=09 */
+=09if (location.type =3D=3D BTRFS_INODE_ITEM_KEY) {
+=09=09btrfs_init_path(&path);
+=09=09ret =3D btrfs_search_slot(NULL, root, &location, &path, 0, 0);
+=09=09if (ret =3D=3D 0) {
+=09=09=09ii =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
+=09=09=09=09=09    struct btrfs_inode_item);
+=09=09=09dent->size =3D btrfs_inode_size(path.nodes[0], ii);
+=09=09}
+=09=09btrfs_release_path(&path);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09}
+
 =09*dentp =3D dent;
 =09return 0;
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3fa9a8c9c020..cd3fd669f9ae 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1221,7 +1221,8 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct b=
trfs_trans_handle *trans,
 =09=09=09=09=09     const char *name, int name_len,
 =09=09=09=09=09     int mod);
 int btrfs_next_dir_entry(struct btrfs_root *root, u64 ino, u64 *offset,
-=09=09=09 char *namebuf, int namebuf_len, u8 *ftype);
+=09=09=09 char *namebuf, int namebuf_len, u8 *ftype,
+=09=09=09 struct btrfs_key *location);
 /* inode.c */
 int btrfs_lookup_path(struct btrfs_root *root, u64 ino, const char *filena=
me,
 =09=09=09struct btrfs_root **root_ret, u64 *ino_ret,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index c7b87d60d986..6edda34818b8 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -126,12 +126,16 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct b=
trfs_trans_handle *trans,
  * @namebuf:=09=09caller buffer that receives the NUL-terminated name
  * @namebuf_len:=09size of @namebuf in bytes
  * @ftype:=09=09receives the BTRFS_FT_* type of the entry
+ * @location:=09=09receives the key the entry points at, so the caller can
+ *=09=09=09reach the inode item without searching for the name
+ *=09=09=09again
  *
  * Return: 0 if an entry was returned, 1 when the directory is exhausted,
  *=09   -ve on error.
  */
 int btrfs_next_dir_entry(struct btrfs_root *root, u64 ino, u64 *offset,
-=09=09=09 char *namebuf, int namebuf_len, u8 *ftype)
+=09=09=09 char *namebuf, int namebuf_len, u8 *ftype,
+=09=09=09 struct btrfs_key *location)
 {
 =09struct btrfs_path path;
 =09struct btrfs_key key;
@@ -180,6 +184,7 @@ int btrfs_next_dir_entry(struct btrfs_root *root, u64 i=
no, u64 *offset,
 =09=09=09   (unsigned long)(di + 1), name_len);
 =09namebuf[name_len] =3D '\0';
 =09*ftype =3D btrfs_dir_type(path.nodes[0], di);
+=09btrfs_dir_item_key_to_cpu(path.nodes[0], di, location);
 =09ret =3D 0;
=20
 out:
--=20
2.55.0


