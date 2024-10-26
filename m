Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9E3D10BEC
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 09:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0B788DF1;
	Sat, 26 Oct 2024 11:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fwVbXroM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C0B88F4A; Sat, 26 Oct 2024 11:00:32 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0481E88CD9
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 11:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2d1858cdfso1970095a91.1
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1729933227; x=1730538027;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YM6Z0r9pM2HZVGAzuRGRJYY/6CdhDmzjtnOZbGsR16g=;
 b=fwVbXroMvduBOC3OW3v623vXX7aO0YuOFz0Vwc5I8Gj7Ks/Bzg3p5rCgsfLzaXMCl0
 eZ/NFzXf4STLIY3OPWwhFqWgjciBpNXtNF56q8di1GeMdz1FXUUf1E81lM2WA/k2v2Xl
 HSWs0hxfmtrFg5I+PSx80MbCmi6/gfKf6wYuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729933227; x=1730538027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YM6Z0r9pM2HZVGAzuRGRJYY/6CdhDmzjtnOZbGsR16g=;
 b=Iv8LAOUvFX4Zq7IEbN/SdbJUdcvQ/mwEFHTEE9rGbrwKneaD5C1f+Hf6TLT2pXp2vy
 bI5pUe9KK4aEsrEazhOUs4vnKlyNNgGHrBZZWpoDCmZsbaz3ST9Z46HTdA5QaDqr5va1
 povSLVBnN/BWAH0QrrcBAfulMgUhlxyGFf5EnjQvMi4M+G43ZlRUryHANAHH7+g7zpwS
 E6gpOJh1S8RGLUSo0jqppz+3+QvDbP1gcST3Fb+F6Hc5J660Gt4F9yjNt/MKdQAauCxK
 XAkyxHX14myJBNiYauE9RhXzBzyl/N4SZmeS9wthYEBHKpnjdHZZLh+VonxciH22JyEK
 q6jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI99uIf5ifzIKQevxnez2wx0HjLO/dUEWweONErxUAieBJL6yakkshXMAiATFzhRGexLzipsU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8k3lHhGf4c1ApsNfIrCrtyPTASCI9qL0MGs6scm4IvwA3c89C
 W7I5jqCxjTEzPgobocxB/OB4dzGSTFZhv9POMv6n6HjoWNKo1yL434RZg955v7ff8AO8sCBRgKW
 YpmGiY2ZlcNL+itLGatl0atG12FN3iyWpl0jcuA==
X-Google-Smtp-Source: AGHT+IE0FY7muJD2emXA8dDWhwwIMjS6YWrOG5QAYtEMAixoqEqgv6QamuLEp0dIXTyXP1v31UT6xMTq0VYWiPC5WU0=
X-Received: by 2002:a17:90a:ca83:b0:2e2:ad29:11a4 with SMTP id
 98e67ed59e1d1-2e8f11b894fmr2441806a91.25.1729933227388; Sat, 26 Oct 2024
 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-4-heinrich.schuchardt@canonical.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sat, 26 Oct 2024 11:00:15 +0200
Message-ID: <CAOf5uwkjR0ObAmibd=4PAn+Ux9qi8NKe1PsFHYpzqGZUWrw+Gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] fs: ext4: implement opendir, readdir, closedir
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

Hi

On Sat, Oct 26, 2024 at 8:41=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For accessing directories from the EFI sub-system a file system must
> implement opendir, readdir, closedir. Provide the missing implementation.
>
> With this patch the eficonfig command can be used to define load options
> for the ext4 file system.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4fs.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/fs.c          |   4 +-
>  include/ext4fs.h |   4 ++
>  3 files changed, 166 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index 21714149ef5..32693198aeb 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -21,17 +21,36 @@
>   */
>
>  #include <blk.h>
> +#include <div64.h>
> +#include <errno.h>
>  #include <ext_common.h>
>  #include <ext4fs.h>
> -#include "ext4_common.h"
> -#include <div64.h>
>  #include <malloc.h>
>  #include <part.h>
>  #include <u-boot/uuid.h>
> +#include "ext4_common.h"
>
>  int ext4fs_symlinknest;
>  struct ext_filesystem ext_fs;
>
> +/**
> + * struct ext4_dir_stream - ext4 directory stream
> + *
> + * @parent: partition data used by fs layer.
> + * This field must be at the beginning of the structure.
> + * All other fields are private to the ext4 driver.
> + * @root:      root directory node
> + * @dir:       directory node
> + * @dirent:    directory stream entry
> + * @fpos:      file position in directory
> + */
> +struct ext4_dir_stream {
> +       struct fs_dir_stream parent;
> +       char *dirname;
> +       struct fs_dirent dirent;
> +       unsigned int fpos;
> +};
> +
>  struct ext_filesystem *get_fs(void)
>  {
>         return &ext_fs;
> @@ -205,6 +224,144 @@ int ext4fs_ls(const char *dirname)
>         return 0;
>  }
>
> +int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp)
> +{
> +       struct ext4_dir_stream *dirs;
> +       struct ext2fs_node *dir =3D NULL;
> +       int ret;
> +
> +       *dirsp =3D NULL;
> +
> +       dirs =3D calloc(1, sizeof(struct ext4_dir_stream));
> +       if (!dirs)
> +               return -ENOMEM;
> +       dirs->dirname =3D strdup(dirname);
> +       if (!dirs) {
> +               free(dirs);
> +               return -ENOMEM;
> +       }
> +

You can move it after find_file

> +       ret =3D ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> +                              FILETYPE_DIRECTORY);
> +       if (ret =3D=3D 1) {
> +               ret =3D 0;
> +               *dirsp =3D (struct fs_dir_stream *)dirs;
> +       } else {
> +               ret =3D -ENOENT;

You should free dirs here if you did not find anything

Michael

> +       }
> +
> +       if (dir)
> +               ext4fs_free_node(dir, &ext4fs_root->diropen);
> +
> +       return ret;
> +}
> +
> +int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **den=
tp)
> +{
> +       struct ext4_dir_stream *dirs =3D (struct ext4_dir_stream *)fs_dir=
s;
> +       struct fs_dirent *dent =3D &dirs->dirent;
> +       struct ext2fs_node *dir =3D NULL;
> +       int ret;
> +       loff_t actread;
> +       struct ext2fs_node fdiro;
> +       int len;
> +       struct ext2_dirent dirent;
> +
> +       *dentp =3D NULL;
> +
> +       ret =3D ext4fs_find_file(dirs->dirname, &ext4fs_root->diropen, &d=
ir,
> +                              FILETYPE_DIRECTORY);
> +       if (ret !=3D 1) {
> +               ret =3D -ENOENT;
> +               goto out;
> +       }
> +       if (!dir->inode_read) {
> +               ret =3D ext4fs_read_inode(dir->data, dir->ino, &dir->inod=
e);
> +               if (!ret) {
> +                       ret =3D -EIO;
> +                       goto out;
> +               }
> +       }
> +
> +       if (dirs->fpos >=3D le32_to_cpu(dir->inode.size))
> +               return -ENOENT;
> +
> +       memset(dent, 0, sizeof(struct fs_dirent));
> +
> +       while (dirs->fpos < le32_to_cpu(dir->inode.size)) {
> +               ret =3D ext4fs_read_file(dir, dirs->fpos,
> +                                      sizeof(struct ext2_dirent),
> +                                      (char *)&dirent, &actread);
> +               if (ret < 0)
> +                       return -ret;
> +
> +               if (!dirent.direntlen)
> +                       return -EIO;
> +
> +               if (dirent.namelen)
> +                       break;
> +
> +               dirs->fpos +=3D le16_to_cpu(dirent.direntlen);
> +       }
> +
> +       len =3D min(FS_DIRENT_NAME_LEN - 1, (int)dirent.namelen);
> +
> +       ret =3D ext4fs_read_file(dir, dirs->fpos + sizeof(struct ext2_dir=
ent),
> +                              len, dent->name, &actread);
> +       if (ret < 0)
> +               goto out;
> +       dent->name[len] =3D '\0';
> +
> +       fdiro.data =3D dir->data;
> +       fdiro.ino =3D le32_to_cpu(dirent.inode);
> +
> +       ret =3D ext4fs_read_inode(dir->data, fdiro.ino, &fdiro.inode);
> +       if (!ret) {
> +               ret =3D -EIO;
> +               goto out;
> +       }
> +
> +       switch (le16_to_cpu(fdiro.inode.mode) & FILETYPE_INO_MASK) {
> +       case FILETYPE_INO_DIRECTORY:
> +               dent->type =3D FS_DT_DIR;
> +               break;
> +       case FILETYPE_INO_SYMLINK:
> +               dent->type =3D FS_DT_LNK;
> +               break;
> +       case FILETYPE_INO_REG:
> +               dent->type =3D FS_DT_REG;
> +               break;
> +       default:
> +               dent->type =3D FILETYPE_UNKNOWN;
> +       }
> +
> +       rtc_to_tm(fdiro.inode.atime, &dent->access_time);
> +       rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
> +       rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
> +
> +       dirs->fpos +=3D le16_to_cpu(dirent.direntlen);
> +       dent->size =3D fdiro.inode.size;
> +       *dentp =3D dent;
> +       ret =3D 0;
> +
> +out:
> +       if (dir)
> +               ext4fs_free_node(dir, &ext4fs_root->diropen);
> +
> +       return ret;
> +}
> +
> +void ext4fs_closedir(struct fs_dir_stream *fs_dirs)
> +{
> +       struct ext4_dir_stream *dirs =3D (struct ext4_dir_stream *)fs_dir=
s;
> +
> +       if (!dirs)
> +               return;
> +
> +       free(dirs->dirname);
> +       free(dirs);
> +}
> +
>  int ext4fs_exists(const char *filename)
>  {
>         struct ext2fs_node *dirnode =3D NULL;
> diff --git a/fs/fs.c b/fs/fs.c
> index e2915e7cf79..a515905c4c9 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -232,7 +232,9 @@ static struct fstype_info fstypes[] =3D {
>                 .ln =3D fs_ln_unsupported,
>  #endif
>                 .uuid =3D ext4fs_uuid,
> -               .opendir =3D fs_opendir_unsupported,
> +               .opendir =3D ext4fs_opendir,
> +               .readdir =3D ext4fs_readdir,
> +               .closedir =3D ext4fs_closedir,
>                 .unlink =3D fs_unlink_unsupported,
>                 .mkdir =3D fs_mkdir_unsupported,
>         },
> diff --git a/include/ext4fs.h b/include/ext4fs.h
> index 41f9eb8bd33..fe3fb301ec8 100644
> --- a/include/ext4fs.h
> +++ b/include/ext4fs.h
> @@ -27,6 +27,7 @@
>  #ifndef __EXT4__
>  #define __EXT4__
>  #include <ext_common.h>
> +#include <fs.h>
>
>  struct disk_partition;
>
> @@ -218,4 +219,7 @@ int ext4fs_uuid(char *uuid_str);
>  void ext_cache_init(struct ext_block_cache *cache);
>  void ext_cache_fini(struct ext_block_cache *cache);
>  int ext_cache_read(struct ext_block_cache *cache, lbaint_t block, int si=
ze);
> +int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp);
> +int ext4fs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)=
;
> +void ext4fs_closedir(struct fs_dir_stream *dirs);
>  #endif
> --
> 2.45.2
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
