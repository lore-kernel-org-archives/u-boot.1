Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD189CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2DFF84704;
	Fri, 26 Jun 2026 11:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="m3PdJMSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E31D84894; Fri, 26 Jun 2026 11:21:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47B828460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c08922c23ebso111157966b.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 02:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465690; cv=none;
 d=google.com; s=arc-20260327;
 b=oEvPVJG77a5n3wKXz6rwQpN1GRwt7TuQDb3cz07PoE3fX4y6SdyPGb6eHsnH8gJuvx
 7GfZ7jOV86nIwQlq+w0U9IfSPionTbBb0tuW2lXwPNlCZkyGW2HF9VsOJCDfwQhP1FLq
 dDV56jDav4CuD/ubK9J47RPJeAUyo5uQkQxdmIfOQV9z/wOVhCF4NpY50xJV+MeHEME3
 l2N1e9y83xlAtVmBp4HKiWbaOeHXDk4ALkA8WGXwuzpbc+ehUdW5GwUKbnqSlJeCZ5q1
 hpD2jmLFbe5lb1FOd7flQ6Tj6cn40YPXGDIx99yYbx/wP14VhSdqAkbeNhONeBcExZcx
 4XOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jge6G4TAFPrvXC1QniyTn5PKiUjUotDtBmFXmgksvLI=;
 fh=RZ61JktpC6apeX1S8eRfIZBB7ndWano9uzJZzBSj5Bc=;
 b=lQHQ1VA6msgaJpSHDJk6EhdiV/EnVW9U2aDSRbhHAX8qDJXolwrnzaVGRq+8X4iBl8
 lf0/axdzrctLnPUNkCERQ0yQHailQPvNIdU5PoMx9YrqGLas3Msv+sKFSk/sqfiAxe4h
 nHbnOHVo6RegBRnHnr24usw2y7vkgBMGstaZAx7Cw2pQNbNzGCUIvcWLpWSmn+3lZ4OY
 o92kpceIRxCab+hQtpQnWmuSG8hiGeAU0eJ0u29q3mjrXdnWWBD2LPmPHDGVSjZ73pVR
 179oz5iJIZdPO88BckfVaykLUA4cVuXbjqC4cHjC+mbTmfvrRkFJiDd7qWdNs8fVla40
 Ck3Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782465690; x=1783070490; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jge6G4TAFPrvXC1QniyTn5PKiUjUotDtBmFXmgksvLI=;
 b=m3PdJMSZXu3DDcqwQCiP/BS6SjgOz3bQLQG5FRXGwUhlWAysgvudIOC7N0szYtxOAP
 +vUL3EmhSXXRVSQ3Vn3MWbpVJ7LldDFJvOBg6+4bw7DDg7V6nXAyG3s4/1W6t3/xL4bH
 RgHXIUeE2hl61vsJ8/yiJH8GM3+GdIR+X4y3DDBnEgOLenc7mCBT9IDPEDGmkGRnxB1N
 F5Venn+zKzqc6gi17s7QtBa2vLyZc1nV+vu5Y78GJCRrdkWs8q6vyShW+Q22A78izCil
 KK0Zvq7l3LPReCj5RduYLbjZmvLhhScz7+5Qchj+ubFKkar+yi7QYOPS/Qv25IJVBtE9
 dY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465690; x=1783070490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jge6G4TAFPrvXC1QniyTn5PKiUjUotDtBmFXmgksvLI=;
 b=Pef+/0jDi4e0ITYtyr3FJWg1NRwX+k1jcrSYvDG7MCV++vtdagq0RdVvpg/d2ZGUen
 Lab2js8XM3uBRoXREOjZ8qXRvDSG4Wp0G0geH35hEEjH6MOkv2xkWI59kyVjM78VdQ7f
 jSnH0LgOD3ThUzpYdwpeZ3rS3tuoRIFDuelz9qBIRzrrQo3t1x6z6Mh5PQTwZ0QQpkza
 /f8Z0w0IdkEECnhQtWhRdjlYUwzCML64ler54L4/eZJNOU5sWYWcgNkhQcbetQWtZ5jv
 urKGiLzEPrTQLmULuhisrretV+H5Jm+scuE6tpXR68nEjBYsuCNIVS3p/Hp6YmKPng82
 Il+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RogMiFFvXSesKQlP886cdJyl7rSoScqafJTTGWZrE3cICl0eLUiruamJHTkjy4KeI9Ay1P3Trw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxk5QMPHPMpOlsYwZ9VCYhD4VLHVg0yYOL65LZzDftUuea93m0N
 Bzycf8stlR/Iwb/mA4xoBmKO/sAk9js6WNiARcfERzcGgnERqcJ6ScmeslUIJJowAOX4A7xgZEG
 tot6KulzMtQ32K+dQMRw+q7wQjIGXj7eteoLvvw1T4xIdA5/+xNhAqZ4ZgQ==
X-Gm-Gg: AfdE7cnJuOgvh4wSpRuOUiU3eI/bXvP5Bd9BGucCkK+czn9RddeembGQImsEALFuKSQ
 m8PzrIVkdUZ4XZT+bEp25j2E9GiO1GkVMvVFFHhOcf7UxNh//GRklrLHPXSQxQIwqRZnGPWsRSU
 7eNnxhT86XA47hhIXpORUczWa+sy9Qg+G+GBCL4rWpr4jNg1O/aY6yc0qpjFivTIl+ECkw54tvH
 JZi6VM5W2TdOBQ+XOtOI0W4uLQg8ln0qCdHF7HRQQF1sboXwDY94i36b8JPTkECxWP36UhZj/L0
 ar7EoG2mvnWcUMIddtbOovJKjzi8fQ==
X-Received: by 2002:a17:907:c445:b0:c09:2c22:16ac with SMTP id
 a640c23a62f3a-c1205f20228mr418020266b.48.1782465689600; Fri, 26 Jun 2026
 02:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
 <20260625-btrfs-readdir-v1-1-dd781a2b3965@flipper.net>
 <bbeac2f6-685d-4ace-b689-10d64c4e3ce5@suse.com>
In-Reply-To: <bbeac2f6-685d-4ace-b689-10d64c4e3ce5@suse.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 26 Jun 2026 13:21:21 +0400
X-Gm-Features: AVVi8Cfjpor4kVmvFDmltWs24y4yW5kbH4YQTBWs_yPanPJDk7g3J_iinR_jcyk
Message-ID: <CAKTNdwGH2OCWJ1A=jQWiLYQmxG8UFTBGwGh0Qno7OkUfxs4dtw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: btrfs: implement opendir(),
 readdir() and closedir()
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, u-boot@lists.denx.de, 
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

On Fri, Jun 26, 2026 at 10:38=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2026/6/26 02:54, Alexey Charkov =E5=86=99=E9=81=93:
> > Add support for generic directory iteration with opendir(), readdir() a=
nd
> > closedir() in the btrfs filesystem driver, following the ext4fs
> > implementation for opendir()/closedir() and the btrfs_iter_dir() functi=
on
> > for readdir().
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   fs/btrfs/btrfs.c    | 92 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   fs/btrfs/ctree.h    |  2 ++
> >   fs/btrfs/dir-item.c | 91 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >   fs/fs.c             |  4 ++-
> >   include/btrfs.h     |  5 +++
> >   5 files changed, 193 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
> > index f3087f690fa4..c647c8dedf4e 100644
> > --- a/fs/btrfs/btrfs.c
> > +++ b/fs/btrfs/btrfs.c
> > @@ -9,6 +9,7 @@
> >   #include <malloc.h>
> >   #include <u-boot/uuid.h>
> >   #include <linux/time.h>
> > +#include <fs.h>
> >   #include "btrfs.h"
> >   #include "crypto/hash.h"
> >   #include "disk-io.h"
> > @@ -159,6 +160,97 @@ int btrfs_ls(const char *path)
> >       return 0;
> >   }
> >
> > +struct btrfs_dir_stream {
> > +     struct fs_dir_stream parent;
> > +     struct fs_dirent dirent;
> > +     char *dirname;
> > +     u64 offset;
>
> This doesn't look correct to me, for an opened dir, we should have at
> least the root id or pointer, and an inode number.
>
> Not just an @dirname and re-do the path resolution again and again.
>
> In fact, I do not even think we should save @dirname here.

Thanks Qu, let me reshuffle these. I'm not a huge FS guru, so I was
just parroting what other existing U-Boot code does (ext4 in this
case). That might well not be the best approach here, even though it
worked for my use case.

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
>
> You just discard the most important @root and @ino.
>
> So what is the point here?

Thanks for the pointer, I will switch from repeated lookups to a
stored ino reference.

> > +     if (ret < 0)
> > +             return ret;
> > +     if (type !=3D BTRFS_FT_DIR)
> > +             return -ENOTDIR;
> > +
> > +     dirs =3D calloc(1, sizeof(*dirs));
> > +     if (!dirs)
> > +             return -ENOMEM;
> > +     dirs->dirname =3D strdup(dirname);
> > +     if (!dirs->dirname) {
> > +             free(dirs);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     *dirsp =3D (struct fs_dir_stream *)dirs;
> > +     return 0;
> > +}
> > +
> > +int btrfs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **de=
ntp)
> > +{
> > +     struct btrfs_dir_stream *dirs =3D (struct btrfs_dir_stream *)fs_d=
irs;
> > +     struct btrfs_fs_info *fs_info =3D current_fs_info;
> > +     struct fs_dirent *dent =3D &dirs->dirent;
> > +     struct btrfs_root *root;
> > +     u64 ino;
> > +     u8 type;
> > +     int ret;
> > +
> > +     *dentp =3D NULL;
> > +     ASSERT(fs_info);
> > +
> > +     ret =3D btrfs_lookup_path(fs_info->fs_root, BTRFS_FIRST_FREE_OBJE=
CTID,
> > +                             dirs->dirname, &root, &ino, &type, 40);
>
> No, doing the same path resolution again and again is not sane.

Ack

> > +     if (ret < 0)
> > +             return ret;
> > +     if (type !=3D BTRFS_FT_DIR)
> > +             return -ENOTDIR;
> > +
> > +     memset(dent, 0, sizeof(*dent));
> > +     ret =3D btrfs_next_dir_entry(root, ino, &dirs->offset, dent->name=
,
> > +                                sizeof(dent->name), &type);
> > +     if (ret < 0)
> > +             return ret;
> > +     if (ret > 0)
> > +             return -ENOENT;
> > +
> > +     switch (type) {
> > +     case BTRFS_FT_DIR:
> > +             dent->type =3D FS_DT_DIR;
> > +             break;
> > +     case BTRFS_FT_SYMLINK:
> > +             dent->type =3D FS_DT_LNK;
> > +             break;
> > +     default:
> > +             dent->type =3D FS_DT_REG;
> > +             break;
>
> So it looks like u-boot only supports the above 3 types, and unlike
> linux kernel the values doesn't match the btrfs internal ones.
>
> In that case, I'd still prefer a proper convertor function.

Hmm, but the convertor function would still be the same switch
statement, and it's only used in this single place. Would factoring it
out actually improve readability?

> [...]
> > +
> > +             *offset =3D key.offset + 1;
> > +             type =3D btrfs_dir_type(path.nodes[0], di);
> > +
> > +             /* XATTRs share the key space but are not directory entri=
es. */
> > +             if (type =3D=3D BTRFS_FT_XATTR) {
>
> This doesn't looks correct again.
>
> XATTR has their own keys, they should not show up among DIR_INDEX keys.

Let me double check and adjust accordingly.

Thanks a lot for your review!

Best regards,
Alexey
