Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D39C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87F4060673;
	Sun,  2 Aug 2026 13:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wyPIb62ySWLv; Sun,  2 Aug 2026 13:27:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4CA4D60678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677261;
	bh=SrDUEAfdG/kkkwSJKhdVinrzRTGBLdVXJgWGpK+VneA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PgL+S9PiH2Vdg3+Lc4fxrB7sQ0ev88gHWQzbSwo+k97cltgSdCPwQSGG5LdsaZANh
	 gUjPloXa9RkqLigF+m9eWt5dJXaJSKeFPCLnIMBv8kiTSoQjKTxk+YpOkbPlltbYJl
	 3ZNyQkrj9fqBTV+AXgymnBevcxLllRUrOwgtFcHQzSd/p+71mD9tGIVove9c1eDyV4
	 +trMqnQGZdxE3jyA+BDxFE+CmsA2aclDuV0dRhtCutYDcU7dvyUW0mbChFBIpPfp0Z
	 qrQ5+mN8drtQIgwmCtIf3zakzyBdGUPMZWsyhQDdXaAPfx0Ly8n12Ubvq+eY3PaMb2
	 Ybrty7XA9ufmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CA4D60678;
	Sun,  2 Aug 2026 13:27:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F315423F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E5068406A3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:44:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6kVTSiNpqLR for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 06:44:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F07C3406A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F07C3406A2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F07C3406A2
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 06:44:46 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0B9844F6; Sun,  2 Aug 2026 08:44:44 +0200 (CEST)
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6146880117
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 08:44:41 +0200 (CEST)
Date: Sun, 02 Aug 2026 06:44:38 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] fs: btrfs: report file sizes from readdir
Message-ID: <17aef0820b5121f0e80e7bb85748d502d3833ee6.1785653018.git.Munzzyy1@proton.me>
In-Reply-To: <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 3c43910e51949b354022595d9b5a8fc3f9c6c503
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785653080; x=1785912280;
 bh=SrDUEAfdG/kkkwSJKhdVinrzRTGBLdVXJgWGpK+VneA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TEsMWZk6WiQ6AaG926Sg1y/P+6PxOLVIXjNjD9q4/+aopZ4RuziTQ1ATywaGZ95hK
 p1BQ/gRKStSCO6PPsuQIlZfcVVyW84o9JswrHnLo/EhG/2GCB3oLT4C7fh6L0onZoz
 yJLTL99Xu3vgvfH/sEjjNW/c2BFk0PcsP5DrbhSX1Pa6quJIMh+ibe2uRLgp1Ma4ZP
 jh/EzqrsAQ8SDVuxUUOWb1uoBjj/R9ELrNA3ob4HyrPcrOZRd7KtZaSUGo1UrY4RrV
 aWDynvv5A52mxIv6vkK0JoKf0J6MTcbuMyoJo1X8wOY5K3y/B68oyHyOZRnfBlmn74
 VH8J5NV0gjoEg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=TEsMWZk6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="TEsMWZk6"; 
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
key it points at while we are there and hand it back to the caller.
The inode item is a separate key, so reaching it still takes a second
search, but btrfs_size() already open-codes that exact search, so pull
it into a helper both callers share. That also closes a path leak in
btrfs_size(), which returned without releasing on a search error. A
subvolume entry points at a root item instead and has no size of its
own, so leave that one at 0.

  =3D> ls host 0 /
     196608   f_192k.bin
       3000   small_3k.bin

Fixes: 31cf3f177823 ("fs: btrfs: use fs_ls_generic() and drop custom implem=
entation")
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
The second search itself cannot go away, since the dir index item and
the inode item it points at are separate keys, and the old custom
lister did the same two lookups per entry. What can go away is the
open-coded machinery: btrfs_size() carries an identical search, so v2
moves it into one helper both callers use. That also fixes btrfs_size()
returning without releasing the path when the search errors out.

Changes in v2:
- pull the inode item search into a helper shared with btrfs_size()
  instead of open-coding a second copy (Alexey)

Still passes the btrfs suite from the pending test series on top of
this patch plus the readdir series: 5 passed.
 fs/btrfs/btrfs.c    | 75 +++++++++++++++++++++++++++++++--------------
 fs/btrfs/ctree.h    |  3 +-
 fs/btrfs/dir-item.c |  7 ++++-
 3 files changed, 60 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index e663dda12e80..dea155bd150e 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -88,12 +88,41 @@ static unsigned int btrfs_dirent_type_to_fs_type(u8 dir=
ent_type)
 =09}
 }
=20
+/*
+ * Read the size stored in an inode item.  A missing item is -ENOENT and
+ * leaves *size untouched.
+ */
+static int btrfs_get_inode_size(struct btrfs_root *root, u64 ino, u64 *siz=
e)
+{
+=09struct btrfs_inode_item *ii;
+=09struct btrfs_path path;
+=09struct btrfs_key key;
+=09int ret;
+
+=09key.objectid =3D ino;
+=09key.type =3D BTRFS_INODE_ITEM_KEY;
+=09key.offset =3D 0;
+
+=09btrfs_init_path(&path);
+=09ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+=09if (ret > 0)
+=09=09ret =3D -ENOENT;
+=09if (!ret) {
+=09=09ii =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
+=09=09=09=09    struct btrfs_inode_item);
+=09=09*size =3D btrfs_inode_size(path.nodes[0], ii);
+=09}
+=09btrfs_release_path(&path);
+=09return ret;
+}
+
 int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
 {
 =09struct btrfs_dir_stream *dirs =3D container_of(fs_dirs, struct btrfs_di=
r_stream, parent);
 =09struct btrfs_fs_info *fs_info =3D current_fs_info;
 =09struct fs_dirent *dent =3D &dirs->dirent;
 =09struct btrfs_root *root;
+=09struct btrfs_key location;
 =09struct btrfs_key key;
 =09u8 type;
 =09int ret;
@@ -110,13 +139,29 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, stru=
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
+=09=09u64 size;
+
+=09=09ret =3D btrfs_get_inode_size(root, location.objectid, &size);
+=09=09if (ret < 0 && ret !=3D -ENOENT)
+=09=09=09return ret;
+=09=09if (!ret)
+=09=09=09dent->size =3D size;
+=09}
+
 =09*dentp =3D dent;
 =09return 0;
 }
@@ -151,10 +196,8 @@ int btrfs_exists(const char *file)
 int btrfs_size(const char *file, loff_t *size)
 {
 =09struct btrfs_fs_info *fs_info =3D current_fs_info;
-=09struct btrfs_inode_item *ii;
 =09struct btrfs_root *root;
-=09struct btrfs_path path;
-=09struct btrfs_key key;
+=09u64 isize;
 =09u64 ino;
 =09u8 type;
 =09int ret;
@@ -169,27 +212,13 @@ int btrfs_size(const char *file, loff_t *size)
 =09=09printf("Not a regular file: %s\n", file);
 =09=09return -ENOENT;
 =09}
-=09btrfs_init_path(&path);
-=09key.objectid =3D ino;
-=09key.type =3D BTRFS_INODE_ITEM_KEY;
-=09key.offset =3D 0;
-
-=09ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-=09if (ret < 0) {
-=09=09printf("Cannot lookup ino %llu\n", ino);
+=09ret =3D btrfs_get_inode_size(root, ino, &isize);
+=09if (ret) {
+=09=09printf("Cannot read size of ino %llu\n", ino);
 =09=09return ret;
 =09}
-=09if (ret > 0) {
-=09=09printf("Ino %llu does not exist\n", ino);
-=09=09ret =3D -ENOENT;
-=09=09goto out;
-=09}
-=09ii =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
-=09=09=09    struct btrfs_inode_item);
-=09*size =3D btrfs_inode_size(path.nodes[0], ii);
-out:
-=09btrfs_release_path(&path);
-=09return ret;
+=09*size =3D isize;
+=09return 0;
 }
=20
 int btrfs_read(const char *file, void *buf, loff_t offset, loff_t len,
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


