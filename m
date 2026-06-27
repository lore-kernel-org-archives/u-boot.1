Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A714C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 05:59:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 733A383FEE;
	Sat, 27 Jun 2026 07:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="5V4Hs4j6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F20108404D; Sat, 27 Jun 2026 07:59:54 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB88480398
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 07:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso1635330a12.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:59:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782539992; cv=none;
 d=google.com; s=arc-20260327;
 b=o0vE8Ngi2bYzcNroAHP1aFeNhqrYtBj7g47xMOaw8ZFyAJTL8aq7OoSDExyOJuky36
 ucUjX2pONPMY4d51slPFb8IDiSuu+WIanXUDZWcib9XFuYzDgiEkgMxz3brgWPgWb2fJ
 8dOmPBgPMlVHcyaKALS624TJqdnlcHLDRkGvYfgmthN+wnmDxZd6PCREiefNXhVymBGQ
 229n0rGL3ICs5m4XgYlhRPuEr4GIW1x+I37XT4c3KvuZM5QUKtZ0C/Rwpt9u2AJJsRsg
 Zb1KdHd/6y6UCTwVSW44QIwXxjY014zdJCbNHObCwpBb9j8AbYj0NxYDUh42EZ817C2d
 R+IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3JKBbDAKFHJRuZaoQJHSoT8GFtNjLpM9oT9HpgPx1tg=;
 fh=mN9KngaQB+x6uwfNsFYGfPEO4fIb1TqzeKFCP3YOBS8=;
 b=eooLSfj7bWm1V45UwXjl7QZOSTE5cLegx94ARzFMD3OHxIJHXkJ6341W/9tymQQJY4
 arkCDkXlkx7U1G//gD1v8raeXRU6rHEUMlRojXT+BICKnAm9tsKNk4F45x8AFNY5Test
 FfSfTFATZkWxNBCYCFMzWq2bzS2tRR2JS9x/pq00QH1Rb0qDglH0lZqtVPqPoziHzsWa
 XftOFo4viWYqYofbOf0cYRPRIvZTbn7quBD7p1kuqVwJO4i8W8QoDWMeIHYvHAC9gx5K
 L0H3Fety4isd08yUQoQUIAVT+WXPN+Xw6hvtNGEGNiITZDGvfjQmTMq6dPm1PdZT+9mV
 v0CQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782539992; x=1783144792; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JKBbDAKFHJRuZaoQJHSoT8GFtNjLpM9oT9HpgPx1tg=;
 b=5V4Hs4j6o+cZDKrjEKzH8XNIyi6ZB/5HHamxLCarviBgUCCU8X7lzrCw3uOzoHQroc
 +uNsFAZ170fMGvm5u5NxZPnwrubhFdIO4/X3p7QKhW45Opr9UNhQKrr3SXWRHki3Hoqt
 SJIkvf1RlNF86zUF8+HLlE69dMVDXNyFHr64evMVq8xBh+YZ62eRCHgM67LAWJ829fOq
 sj0lu2CU7TLlrMOUmAv3yQZ93xiHXJdi+VjagrK1YTIiN3aweNFraX2WkVxFVAmge8Hh
 Brwgc1K0wxEh1UDVhESCSWhaBVNKib0dYvMDVnEHSSwbZ8eRYr694kjAXF6dwzkJI9uX
 5Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782539992; x=1783144792;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3JKBbDAKFHJRuZaoQJHSoT8GFtNjLpM9oT9HpgPx1tg=;
 b=EcqW/VRa37MlYWlQ6vpXTuTppslQMf5nUm0GDBsilRSUWMo1jTvfuX94AWFXOc0XhR
 tfi0LkMCjg21N1b1Q22O8vrEWLceR3PYNQ+ymZrJQwKug+oX9VuaHdVaF2q8UX8mplYu
 qN1e2wX6MWoCdHxOjy3Qr+6QiOhfY89ojzryRQY8yDmZjqhez9DDrwLBZ4UqLGEXG+JI
 0puMpnjSuNAmdcsLkIqvX/IFSGPs+/uN2DZHwnBsBtrR+72kYIbzgMErHZgR1Se/OKlq
 YncHBYxu+52k1SlBZGrvnAnT+sHuwDxiXJDgXVN1AUWPIAiUiqAaXa20FxIbMglxfZNG
 6z/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3CmU3wy+qj3C8L6ywUlxCeNtpXLs7liWjBU66T1EFiU/898vuQ1S1dtZ6xTX3SamNvyM1+Rc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6xwARP9m6q6gaiNMqIzLiTchdtmD0ZYSP4hkodWZLiZKSx6B/
 4sn3un6A+H+xbv0FQ4OSRvz8HZGTfhFFX86M3++DYplSW1dW31K3h9GlMRmocpVi1AYCytY/bCT
 JtuW/5rU/vrvd3Io1tIcSo398fATamAGewfdHieZgMg==
X-Gm-Gg: AfdE7cmcTICUJimyVJbfp2MgVIljHOOkOyFRkwEtfDxy4XLh1eXNT42wMckK97j4j++
 c9gZHm0U8HbZz11lyaEpBCDNv9b02ds+4WxRcu6/vMS+jlrDtgn3sQCp/2MZf+x9vHHVG6PZpG8
 UbEM+5VYohXsfZfEiVPZZVIrrjhdQqvEQtDtEhoqSabcK16qMwWWAApqcxDQoR99ZaWdCGD3mPL
 Mgv7mXG6dxBk3V9PFoYMZKvNfp4EXnPeaVRtItIpxIwETb5L78LzlvsV+v1dOCZ7Hcdul8cLMTS
 er7c6CVmuZFRIKe7Nw4Ob80cpRXo
X-Received: by 2002:a17:906:ee84:b0:c10:1c55:8c4e with SMTP id
 a640c23a62f3a-c1205e7896fmr570502766b.18.1782539991980; Fri, 26 Jun 2026
 22:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-btrfs-readdir-v2-0-7dd43f72d1b4@flipper.net>
 <20260626-btrfs-readdir-v2-1-7dd43f72d1b4@flipper.net>
 <09eca73c-1f50-46b2-a307-76eef0408159@gmx.com>
In-Reply-To: <09eca73c-1f50-46b2-a307-76eef0408159@gmx.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Sat, 27 Jun 2026 09:59:41 +0400
X-Gm-Features: AVVi8CcQPm_ZXAylGJpdx1I355VWn0TWOOa-Nt3eytYhyywARLCHf7On_OyDLLw
Message-ID: <CAKTNdwEdonby8W9=iD54Fw1UVH88CBmjf+3L9r-jCUfhZrxzpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fs: btrfs: implement opendir(),
 readdir() and closedir()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jun 27, 2026 at 2:27=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2026/6/27 00:48, Alexey Charkov =E5=86=99=E9=81=93:
> > Add support for generic directory iteration with opendir(), readdir() a=
nd
> > closedir() in the btrfs filesystem driver.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   fs/btrfs/btrfs.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   fs/btrfs/ctree.h    |  2 ++
> >   fs/btrfs/dir-item.c | 73 +++++++++++++++++++++++++++++++++++++++
> >   fs/fs.c             |  4 ++-
> >   include/btrfs.h     |  5 +++
> >   5 files changed, 181 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> > index f3087f690fa4..6f034861da90 100644
> > --- a/fs/btrfs/btrfs.c
> > +++ b/fs/btrfs/btrfs.c
> > @@ -8,7 +8,9 @@
> >   #include <config.h>
> >   #include <malloc.h>
> >   #include <u-boot/uuid.h>
> > +#include <linux/kernel.h>
> >   #include <linux/time.h>
> > +#include <fs.h>
> >   #include "btrfs.h"
> >   #include "crypto/hash.h"
> >   #include "disk-io.h"
> > @@ -159,6 +161,102 @@ int btrfs_ls(const char *path)
> >       return 0;
> >   }
> >
> > +/*
> > + * The fs layer closes and re-probes btrfs between readdir() calls (se=
e
> > + * fs_readdir() in fs/fs.c), freeing and reallocating fs_info, so root=
 cannot
> > + * be stored directly. The subvolume id and inode number are stable th=
ough, so
> > + * re-resolve the root from the current fs_info by subvolume id, which=
 avoids
> > + * a full path walk and is much faster.
> > + */
> > +struct btrfs_dir_stream {
> > +     struct fs_dir_stream parent;
> > +     struct fs_dirent dirent;
> > +     u64 subvolid;
> > +     u64 ino;
> > +     u64 offset;
> > +};
> > +
> > +int btrfs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
> > +{
> > +     struct btrfs_fs_info *fs_info =3D current_fs_info;
> > +     struct btrfs_dir_stream *dirs;
> > +     struct btrfs_root *root;
> > +     u64 ino;
> > +     u8 type;
> > +     int ret;
> > +
> > +     *dirsp =3D NULL;
> > +     ASSERT(fs_info);
> > +
> > +     ret =3D btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJE=
CTID,
> > +                             dirname, &root, &ino, &type, 40);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (type !=3D BTRFS_FT_DIR)
> > +             return -ENOTDIR;
> > +
> > +     dirs =3D calloc(1, sizeof(*dirs));
> > +     if (!dirs)
> > +             return -ENOMEM;
> > +     dirs->subvolid =3D root->root_key.objectid;
> > +     dirs->ino =3D ino;
> > +
> > +     *dirsp =3D &dirs->parent;
> > +     return 0;
> > +}
> > +
> > +static unsigned int btrfs_dirent_type_to_fs_type(u8 dirent_type)
> > +{
> > +     switch (dirent_type) {
> > +     case BTRFS_FT_DIR:
> > +             return FS_DT_DIR;
> > +     case BTRFS_FT_SYMLINK:
> > +             return FS_DT_LNK;
> > +     default:
> > +             return FS_DT_REG;
> > +     }
> > +}
> > +
> > +int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **de=
ntp)
> > +{
> > +     struct btrfs_dir_stream *dirs =3D container_of(fs_dirs, struct bt=
rfs_dir_stream, parent);
> > +     struct btrfs_fs_info *fs_info =3D current_fs_info;
> > +     struct fs_dirent *dent =3D &dirs->dirent;
> > +     struct btrfs_root *root;
> > +     struct btrfs_key key;
> > +     u8 type;
> > +     int ret;
> > +
> > +     *dentp =3D NULL;
> > +     ASSERT(fs_info);
> > +
> > +     key.objectid =3D dirs->subvolid;
> > +     key.type =3D BTRFS_ROOT_ITEM_KEY;
> > +     key.offset =3D (u64)-1;
> > +     root =3D btrfs_read_fs_root(fs_info, &key);
>
> You can save the root pointer into btrfs_dir_stream, so we can avoid
> subvolume root lookup for each dentry.

That was in fact the first thing I tried, but turns out that it
doesn't work because a root pointer created with one fs_info structure
stops working once fs_close at the end of the generic fs opendir
caller closes the fs and deallocates the fs_info structure, due to it
referencing trees allocated for that instance of fs_info. The result
is a synchronous abort.

Hence the comment above the btrfs_dir_stream definition and this
second-best solution.

Please let me know if I've missed a more elegant option!

Closing and reopening the fs at every call which the FS layer does
sounds like a huge overhead, but I must assume it was unavoidable when
the interface was designed.

> You do not need to bother the lifespan of subvolume roots either, they
> are properly released during the close of the fs.
>
> Otherwise looks good to me, except an unrelated question just lines below=
.
>
> > +     if (IS_ERR(root))
> > +             return PTR_ERR(root);
> > +
> > +     memset(dent, 0, sizeof(*dent));
> > +     ret =3D btrfs_next_dir_entry(root, dirs->ino, &dirs->offset, dent=
->name,
> > +                                sizeof(dent->name), &type);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (ret > 0)
> > +             return -ENOENT;
>
> I'm not sure what is the proper/preferred/sane handling of end of directo=
ry.
>
> Ext4/fat returns -ENOENT, squashfs returned -1, erofs return 1, exfat
> returns 0 but without populating @dentp.
>
> Personally I found the exfat behavior more sane, but considering the
> caller fs_ls_generic() doesn't really bother the return value but only
> cares if @dent is populated, it should be fine either way.
>
> But still, returning -ENOENT will populate errno, which may be confusing
> for debugging.
>
> Anyway it's an unrelated nitpick.

Happy to switch to exfat-like behavior. I was only looking at ext4
implementation as that is likely the most widely used and tested in
various corner cases, but it sounds like either way should work.

Thanks a lot,
Alexey
