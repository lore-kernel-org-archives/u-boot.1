Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B4C02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 05:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDDA80F53;
	Sun, 26 Jan 2025 06:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hr0QnSSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DB880F58; Sun, 26 Jan 2025 05:34:51 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB2A807E4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 05:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so880068166b.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737866088; x=1738470888; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCWMhfq0DUAVZZQJc9l2Rv6XDIDhkYzCsNVx8Oj/OMU=;
 b=Hr0QnSSt+FcDg2RyaDXC6djs0vVZHHWPBA2x7UqaI51rzNfL3Ih6eNM2udiGrFrCvW
 uaHKjSy9om70dXjIEPrq+eTDeqBuShXuvTt3YQ9dD8fC1rINqZs6atP9smTEQSDSp8TQ
 iqiq+MvOfREcLhDSJbm/xP/7YLAfVaILlFOFjuqyJTlTBqq3MrpO7rQQgVFvwpJgSKWE
 GyGGouCpKeOdksTeCIOvbk6bKDhb/O0rVlg44Y78KRYnZdn1Eii/ez5qWYhxqW0Zf2Us
 T9kIwrMUiQpFRrn4TBp9fLQp23iFOy8PL83xSwKBPun2bOSgKNs1Ax3QPjT6/ltyG89m
 kpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737866088; x=1738470888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCWMhfq0DUAVZZQJc9l2Rv6XDIDhkYzCsNVx8Oj/OMU=;
 b=uKb5UXwEZZ/Bg6bT3oeVWpWTUZ2kXGkXVl/F6EKQ9MoxwjeDWUkpY9yOqqqOxSus1u
 /28tne+NIVFnqmrSOKYCAsRRJZMmiZUuvT8R4sSL0nvorEeAHkA/k5pGlaaX1y7yig0c
 ff0+/+f/r7f/anKBi1eiK5WQB0HffecspI4YISNbg/VSYtStPij718wk9uE5qkgDr9wc
 zuVDsSb8Fc3cT2IBguv4znLVQuGKVx1ouoWjMsT+YCPQmdoYn2dcVP/ApqUxBNaRasaG
 sH8k2rG9ZOkHeK19oa5eJAcyYNnLmr0MsZlVu8uesg1FwzZmag2JICPzNONgxiuRY8aH
 LZQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz7Bx55c4zCBBstgfKFa35lQAav+Ad19A+ueRF14nzLTjDYlYNQEFnbrEelwZlrwFI+LnOpMA=@lists.denx.de
X-Gm-Message-State: AOJu0YwhswTlXQZ0Ib4sUjN/wzsKraUkF3qmk5nNXJ13sFzEHpNxaTMe
 1cLi96gNQRiQoAJhMnNNgpcUJr7jKvwwjZTjLzjGL6+jZYv40xg8OaVJYF5daoPmzKpN3FpSw1z
 qEUgV/3iVeHu8SxtACmyhDofCGCY=
X-Gm-Gg: ASbGnctbFAMg5z7ijG4o0P4iwRoyr1DK7Xbi4K7MpqkN49H9zDI1utzX1gqlE5NuA11
 qZvv0fMLpQn9q5MqB+so3WgKpnGUJ49tThbME68vyygP8bD4trKn9jvrupEGNrQAm1/QU2hgS
X-Google-Smtp-Source: AGHT+IFz8x6xyVWT0+VxhPSyzedjZAWZfJzviIvhpSl6n8iRF5TT9lTND9vwEB/sJ8g6B1vvA4euY4If5H6u7xEFx8o=
X-Received: by 2002:a17:907:7295:b0:aae:e52f:3d2b with SMTP id
 a640c23a62f3a-ab662a3e764mr1276159566b.28.1737866087444; Sat, 25 Jan 2025
 20:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-2-gabriel.dalimonte@gmail.com>
 <5351D72E-5B9F-4161-9005-016A0910FB9D@gmx.de>
In-Reply-To: <5351D72E-5B9F-4161-9005-016A0910FB9D@gmx.de>
From: "Gabriel D'Alimonte" <gabriel.dalimonte@gmail.com>
Date: Sat, 25 Jan 2025 23:34:37 -0500
X-Gm-Features: AWEUYZkNlo5jsc9Us66B0KkTmWCpwLz4Gc2oII-9TprIRMId-DOEPGAEh4MjKRE
Message-ID: <CAHc-7YtjRbSc76mzq5OShdT27wNpE3pN1U7s9PSCoNfhPpUeUA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: fat: factor out dentry link create/delete
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 26 Jan 2025 06:15:16 +0100
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

Hi!

Thank you for the reviews and feedback.

On Wed, Jan 22, 2025 at 2:08=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> Am 22. Januar 2025 06:32:26 MEZ schrieb Gabriel Dalimonte <gabriel.dalimo=
nte@gmail.com>:
> >Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
>
> Hello Gabriel,
>
>  Thank you for implementing this.
>
> Please, add a commit message to each patch.
>
>
> >---
> >
> > fs/fat/fat_write.c | 122 ++++++++++++++++++++++++---------------------
> > 1 file changed, 66 insertions(+), 56 deletions(-)
> >
> >diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> >index ea877ee917..b86e78abc0 100644
> >--- a/fs/fat/fat_write.c
> >+++ b/fs/fat/fat_write.c
> >@@ -1215,6 +1215,44 @@ static void fill_dentry(fsdata *mydata, dir_entry=
 *dentptr,
> >       memcpy(&dentptr->nameext, shortname, SHORT_NAME_SIZE);
> > }
> >
> >+/**
> >+ * create_link() - inserts a directory entry for a cluster
>
> ... for a file or directory
>
> >+ *
> >+ * @itr:      directory iterator
> >+ * @basename: name of the new entry
>
> @basename: file name
>
> >+ * @clust:    cluster number the new directory entry should point to
>
> ... point to. Use 0 if no cluster is assigned yet.
>
> >+ * @size:     file size
> >+ * @attr:     file attributes
>
> Do we need to keep the creation timestamp when moving files? And only upd=
ate the change timestamp?
>
> Should the archive flag be set when moving files?
>
> What does EDK II or Linux in these cases?
>

On Linux (6.12) [1] it looks like the following happens with respect
to timestamps:
1. If new_path is not overwriting an existing file, the parent
directory of new_path has its modification time updated. (via
`vfat_add_entry` [2] )
2. old_path's parent directory has access, and modification time
updated via `vfat_remove_entries` [3] and `vfat_update_dir_metadata`
[4].
3. The moved file maintains its timestamps and does not update them.

EDK II (branch edk2-stable202411) [5] updates the last modification
and last access times on the parent directories (via
`FatRemoveDirEnt`/`FatCreateDirEnt` [9] -> `FatStoreDirEnt` [9] ->
`FatAccessEntry` [9] -> `FatAccessOFile` [8] -- marking the files
dirty). It updates the last modification and last access times (via
FatOFileFlush [6] -- called on line 469 in [5]) while preserving the
creation time on the moved file (via FatCloneDirEnt [7]). The
implementation of `FatOFileFlush` results in timestamps being updated
up the file tree to the root as `FatOFileFlush` calls `FatStoreDirEnt`
marking the subsequent parent directories as dirty.

Linux appears to not touch the ATTR_ARCH attribute on file moves and
treats ATTR_ARCH and ATTR_DIR as mutually exclusive [10]. On the other
hand, EDK II directly sets the archive bit on the file. The flush
operation [6] will set it on each directory up to the root, from my
understanding.

Is there a preference on either implementation? Or are there
constraints in U-Boot that make either of these timestamp and archive
attribute implementations unsuitable to match?

Thanks,
Gabriel

[1] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/namei_vfat.c#L95=
9-L996
[2] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/namei_vfat.c#L68=
2
[3] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/dir.c#L1083
[4] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/namei_vfat.c#L92=
4
[5] https://github.com/tianocore/edk2/blob/0f3867fa6ef0553e26c42f7d71ff6bdb=
98429742/FatPkg/EnhancedFatDxe/Info.c#L389-L442
[6] https://github.com/tianocore/edk2/blob/0f3867fa6ef0553e26c42f7d71ff6bdb=
98429742/FatPkg/EnhancedFatDxe/Flush.c#L245-L249
[7] https://github.com/tianocore/edk2/blob/0f3867fa6ef0553e26c42f7d71ff6bdb=
98429742/FatPkg/EnhancedFatDxe/DirectoryManage.c#L196-L220
[8] https://github.com/tianocore/edk2/blob/0f3867fa6ef0553e26c42f7d71ff6bdb=
98429742/FatPkg/EnhancedFatDxe/ReadWrite.c#L507-L510
[9] https://github.com/tianocore/edk2/blob/0f3867fa6ef0553e26c42f7d71ff6bdb=
98429742/FatPkg/EnhancedFatDxe/DirectoryManage.c
[10] https://elixir.bootlin.com/linux/v6.12.6/source/fs/fat/namei_vfat.c#L6=
43

> Maybe you could describe these design considerations in the commit messag=
e.
>
> Please, document which fields and flags are implicitly set in the functio=
n description.
>
> >+ * Return:    0 for success
> >+ */
> >+static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32=
 size,
> >+                     __u8 attr)
> >+{
> >+      char shortname[SHORT_NAME_SIZE];
> >+      int ndent;
> >+      int ret;
> >+
> >+      /* Check if long name is needed */
> >+      ndent =3D set_name(itr, basename, shortname);
> >+      if (ndent < 0)
> >+              return ndent;
> >+      ret =3D fat_find_empty_dentries(itr, ndent);
> >+      if (ret)
> >+              return ret;
> >+      if (ndent > 1) {
> >+              /* Set long name entries */
> >+              ret =3D fill_dir_slot(itr, basename, shortname);
> >+              if (ret)
> >+                      return ret;
> >+      }
> >+
> >+      /* Add attribute as archive */
>
> Could this be changed to
> "Add archive attribute"?.
>
> >+      fill_dentry(itr->fsdata, itr->dent, shortname, clust, size,
> >+                  attr | ATTR_ARCH);
> >+
> >+      return 0;
> >+}
> >+
> > /**
> >  * find_directory_entry() - find a directory entry by filename
> >  *
> >@@ -1420,35 +1458,15 @@ int file_fat_write_at(const char *filename, loff=
_t pos, void *buffer,
> >               /* Update change date */
> >               dentry_set_time(retdent);
> >       } else {
> >-              /* Create a new file */
> >-              char shortname[SHORT_NAME_SIZE];
> >-              int ndent;
> >-
> >               if (pos) {
> >                       /* No hole allowed */
>
> This is another deficiency of our FAT driver worth looking into in future=
.
>
> Best regards
>
> Heinrich
>
> >                       ret =3D -EINVAL;
> >                       goto exit;
> >               }
> >
> >-              /* Check if long name is needed */
> >-              ndent =3D set_name(itr, basename, shortname);
> >-              if (ndent < 0) {
> >-                      ret =3D ndent;
> >-                      goto exit;
> >-              }
> >-              ret =3D fat_find_empty_dentries(itr, ndent);
> >+              ret =3D create_link(itr, basename, 0, size, 0);
> >               if (ret)
> >                       goto exit;
> >-              if (ndent > 1) {
> >-                      /* Set long name entries */
> >-                      ret =3D fill_dir_slot(itr, basename, shortname);
> >-                      if (ret)
> >-                              goto exit;
> >-              }
> >-
> >-              /* Set short name entry */
> >-              fill_dentry(itr->fsdata, itr->dent, shortname, 0, size,
> >-                          ATTR_ARCH);
> >
> >               retdent =3D itr->dent;
> >       }
> >@@ -1564,6 +1582,31 @@ static int delete_long_name(fat_itr *itr)
> >       return 0;
> > }
> >
> >+/**
> >+ * delete_dentry_link() - deletes a directory entry, but not the cluste=
r chain
> >+ * it points to
> >+ *
> >+ * @itr:      the first directory entry (if a longname) to remove
> >+ * Return:    0 for success
> >+ */
> >+static int delete_dentry_link(fat_itr *itr)
> >+{
> >+      itr->dent =3D itr->dent_start;
> >+      itr->remaining =3D itr->dent_rem;
> >+      /* Delete long name */
> >+      if ((itr->dent->attr & ATTR_VFAT) =3D=3D ATTR_VFAT &&
> >+          (itr->dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
> >+              int ret;
> >+
> >+              ret =3D delete_long_name(itr);
> >+              if (ret)
> >+                      return ret;
> >+      }
> >+      /* Delete short name */
> >+      delete_single_dentry(itr);
> >+      return flush_dir(itr);
> >+}
> >+
> > /**
> >  * delete_dentry_long() - remove directory entry
> >  *
> >@@ -1589,21 +1632,7 @@ static int delete_dentry_long(fat_itr *itr)
> >               if (ret)
> >                       return ret;
> >       }
> >-      itr->dent =3D itr->dent_start;
> >-      itr->remaining =3D itr->dent_rem;
> >-      dent =3D itr->dent_start;
> >-      /* Delete long name */
> >-      if ((dent->attr & ATTR_VFAT) =3D=3D ATTR_VFAT &&
> >-          (dent->nameext.name[0] & LAST_LONG_ENTRY_MASK)) {
> >-              int ret;
> >-
> >-              ret =3D delete_long_name(itr);
> >-              if (ret)
> >-                      return ret;
> >-      }
> >-      /* Delete short name */
> >-      delete_single_dentry(itr);
> >-      return flush_dir(itr);
> >+      return delete_dentry_link(itr);
> > }
> >
> > int fat_unlink(const char *filename)
> >@@ -1725,9 +1754,6 @@ int fat_mkdir(const char *dirname)
> >               ret =3D -EEXIST;
> >               goto exit;
> >       } else {
> >-              char shortname[SHORT_NAME_SIZE];
> >-              int ndent;
> >-
> >               if (itr->is_root) {
> >                       /* root dir cannot have "." or ".." */
> >                       if (!strcmp(l_dirname, ".") ||
> >@@ -1737,25 +1763,9 @@ int fat_mkdir(const char *dirname)
> >                       }
> >               }
> >
> >-              /* Check if long name is needed */
> >-              ndent =3D set_name(itr, basename, shortname);
> >-              if (ndent < 0) {
> >-                      ret =3D ndent;
> >-                      goto exit;
> >-              }
> >-              ret =3D fat_find_empty_dentries(itr, ndent);
> >+              ret =3D create_link(itr, basename, 0, 0, ATTR_DIR);
> >               if (ret)
> >                       goto exit;
> >-              if (ndent > 1) {
> >-                      /* Set long name entries */
> >-                      ret =3D fill_dir_slot(itr, basename, shortname);
> >-                      if (ret)
> >-                              goto exit;
> >-              }
> >-
> >-              /* Set attribute as archive for regular file */
> >-              fill_dentry(itr->fsdata, itr->dent, shortname, 0, 0,
> >-                          ATTR_DIR | ATTR_ARCH);
> >
> >               retdent =3D itr->dent;
> >       }
>
