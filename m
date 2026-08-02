Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A09C55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC40860717;
	Sun,  2 Aug 2026 13:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrE8urgjGDw8; Sun,  2 Aug 2026 13:27:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 774E9606E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677268;
	bh=iiE4jxXRL+KG1elJ6R1GcvQEYgG7TuXnT9m7BixerGc=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wo7zw7lALGWMQbZeryWWqbUc6JYu6n+FuaPubMRoT7r4pu5LmJ+QIo2lGzgl5rLlw
	 wHFMxp1txmSig7GvNbGrDHkmFk2s4psTNp9fpErcBLlif0Fd2n5pROjh73k7kRpZEx
	 tiCgCLfGgJVFZOWhYeiwp2v5uhA30w7j2cP/A/H01Qo3zqtupvU2lJIapIlIJdkb20
	 VnN4ZvIkatpO6n8mDm9FmdtxZX5Jx92mIsJngI5TMsx0k0OmdLQTeeocI2ulqOHght
	 0MdwuzmNGXO8Qhnw4h3tP2mvgcL5QMp7z+Cm3H1mosaSY3J9oXOQynnbBwSRUwAg4i
	 jvhxqpqtx+PqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 774E9606E5;
	Sun,  2 Aug 2026 13:27:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 342A6282
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2638C80D18
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UcHglC9N-0Nr for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 09:35:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9372880D16
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9372880D16
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9372880D16
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D941B80117; Sun,  2 Aug 2026 11:35:24 +0200 (CEST)
Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch
 [109.224.244.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EF0805D7
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 11:35:22 +0200 (CEST)
Date: Sun, 02 Aug 2026 09:35:19 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/3] fs: btrfs: report file sizes from readdir
Message-ID: <e6fb9594fb330d08b4d1d43a49145fb7e36cd100.1785660029.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1785660029.git.Munzzyy1@proton.me>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
 <cover.1785660029.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 9781fac0d883c350d6102472af020b99481c9d5c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785663321; x=1785922521;
 bh=iiE4jxXRL+KG1elJ6R1GcvQEYgG7TuXnT9m7BixerGc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HxTLKKAZr8YZB0K31uMJckZRW3AiJt6N1cretq3ZZ9S+6ahuFcRciKgiJUlDcXqh/
 XtYjSPrMH/kaTJYaABkLsE9wWee9r8T7JCVCOpj/kCOaAKIvywlRtJSuDvBX9Ju+69
 sbyNB1CSAE4k343Mp0t3fSno5gDFs3Ey5d4LLJZJPMKgJTkUMJSUxcKjbR9pBXPwh6
 HrdvgdiLK90yGV/hWwHC//6Awq0OSFWAcbw2rMbIIlHej8vDuxxu2K3d9opw1Olzfk
 wSFqzNO8YWQONZZHN2wNwJKkAw7ICrcrW9mE6Wo+Mrquorw7w1HP8v+0N7ibtExW7e
 Ye8Hn3EBcUBSA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=HxTLKKAZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="HxTLKKAZ"; 
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


