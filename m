Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7077FC55162
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 13:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0C2860751;
	Sun,  2 Aug 2026 13:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCKhoioyfd_K; Sun,  2 Aug 2026 13:27:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CBEF6073C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785677272;
	bh=eYu+mARdLAxIoNBk3uSaZPcYXGH+1tPEPG4efPobjJw=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FggDLHV8+LGq2voeWq0p5As5Z5IqrO2Hh8BCVZPLKyXEPWJktGe2xF9603INmnyuQ
	 q+fC1SmS5Ek27bHOvufuHb7QQoUSQHNTyTiYeO8B2CQ6KICO47l/I0uo7G2Rk50TCz
	 N4ccm4mfTbrrPwI68dft2bjAbGklV7PZyP5W2gDUh803T83VFD0n8yCou9FFsign1K
	 /tQoJF+MOk71TpGM71yrvpEizKiCfIqk7NhA9Lk1iJzHPAh75ue2smDOmgTCyjP+Cu
	 b3VLMhxmbEKVSuXo5eMcCyQIirG3ULUowgXXLAjKe/eQEFxMDB8yhP+P4/ql1emrUQ
	 ZceIrPtD/CKCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CBEF6073C;
	Sun,  2 Aug 2026 13:27:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 95EDD3A6
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93EB940650
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dxhD10oMk7K0 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 09:35:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=munzzyy1@proton.me; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 469204067A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 469204067A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 469204067A
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 09:35:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B25D580117; Sun,  2 Aug 2026 11:35:33 +0200 (CEST)
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1036805D7
 for <u-boot@lists.denx.de>; Sun,  2 Aug 2026 11:35:31 +0200 (CEST)
Date: Sun, 02 Aug 2026 09:35:26 +0000
To: u-boot@lists.denx.de
From: Cole Munz <Munzzyy1@proton.me>
Cc: Alexey Charkov <alchark@flipper.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Marek Behun <kabel@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/3] fs: btrfs: deduplicate the inode size lookup
Message-ID: <4536a7a3bb0c0be683366a54703baef4969463c3.1785660029.git.Munzzyy1@proton.me>
In-Reply-To: <cover.1785660029.git.Munzzyy1@proton.me>
References: <c8e57b678bee2394655ea5e7b0678fb300705e2f.1785649258.git.Munzzyy1@proton.me>
 <CAKTNdwGCYjr+2vaBc6kArQokqTF=Gc23mF17B_22Fdcg1O=7hQ@mail.gmail.com>
 <7bcd492f-7e1e-4fd9-970d-857ca5460ddd@gmx.com>
 <hTFbDtB7gXE4tGU0EwriHsWY9lutwDK1ehYABepLafBuF5IDEY1rjTUVvCFq0HOsdgpfpFHvayOonotnzsuHWxs-FnRFFsnKUKmvGSkQAHI=@proton.me>
 <d95529ec-3da5-443b-8c05-776309f06ada@gmx.com>
 <cover.1785660029.git.Munzzyy1@proton.me>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: 76e924409945d80685f15d09fa40642f616233ed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Sun, 02 Aug 2026 13:27:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=proton.me; 
 s=protonmail; t=1785663331; x=1785922531;
 bh=eYu+mARdLAxIoNBk3uSaZPcYXGH+1tPEPG4efPobjJw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FYenVreJAMHAW3Hq8hGi9fVQl2Jbr8oEvUBymy8U1RpNx+ueKtu2LMNCsjPfFpEf2
 sLHPv1VhZZuWWT8ikQayXeIuRzfuzBtP9N6A2MDIV+7Co9AYQMgCNA3xpD9Dadg9SR
 8WiciCacDu7kP0vuT7Vrj4VG7bdNDKHnEA41FMDDZ7lISADmCd2B3BMOoqbdm34wCu
 AVxxFDsjoqK9hc3P+TE9+cAYRNx5xuQwAwjrGhT9endU4F4DJdQSRBXcJKdbSbNYc1
 VdwHO/RFA+8PwtUD44Sff4ZUYOZ0cj6KIYVSgNJRe47A5vz0rEujpAbJfVcu/YZItR
 NzWk5bAZHDRfg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=proton.me
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=FYenVreJ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Munzzyy1@proton.me
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=proton.me header.i=@proton.me header.b="FYenVreJ"; 
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

btrfs_readdir() and btrfs_size() both open code the same search for an
inode item to read its size field. Move it into one helper.

Signed-off-by: Cole Munz <Munzzyy1@proton.me>
---
 fs/btrfs/btrfs.c | 75 +++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index b2856be0662f..f5f6d638ffd3 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -88,14 +88,42 @@ static unsigned int btrfs_dirent_type_to_fs_type(u8 dir=
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
+=09if (ret < 0)
+=09=09return ret;
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
-=09struct btrfs_inode_item *ii;
 =09struct btrfs_root *root;
-=09struct btrfs_path path;
 =09struct btrfs_key location;
 =09struct btrfs_key key;
 =09u8 type;
@@ -127,16 +155,13 @@ int btrfs_readdir(struct fs_dir_stream *fs_dirs, stru=
ct fs_dirent **dentp)
 =09 * layer prints it, so look it up.
 =09 */
 =09if (location.type =3D=3D BTRFS_INODE_ITEM_KEY) {
-=09=09btrfs_init_path(&path);
-=09=09ret =3D btrfs_search_slot(NULL, root, &location, &path, 0, 0);
-=09=09if (ret =3D=3D 0) {
-=09=09=09ii =3D btrfs_item_ptr(path.nodes[0], path.slots[0],
-=09=09=09=09=09    struct btrfs_inode_item);
-=09=09=09dent->size =3D btrfs_inode_size(path.nodes[0], ii);
-=09=09}
-=09=09btrfs_release_path(&path);
-=09=09if (ret < 0)
+=09=09u64 size;
+
+=09=09ret =3D btrfs_get_inode_size(root, location.objectid, &size);
+=09=09if (ret < 0 && ret !=3D -ENOENT)
 =09=09=09return ret;
+=09=09if (!ret)
+=09=09=09dent->size =3D size;
 =09}
=20
 =09*dentp =3D dent;
@@ -173,10 +198,8 @@ int btrfs_exists(const char *file)
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
@@ -191,27 +214,13 @@ int btrfs_size(const char *file, loff_t *size)
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
--=20
2.55.0


