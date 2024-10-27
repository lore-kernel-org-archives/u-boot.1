Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC6DD13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D909E8841E;
	Sun, 27 Oct 2024 18:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iNB+JU/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B708841E; Sun, 27 Oct 2024 18:16:24 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586698839A
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso7483263a12.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049374; x=1730654174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K4f19ZqLrL8kHQu5vsabyXoNnoSWiuBX5CujEWJyHb0=;
 b=iNB+JU/fSbwbbDAJrAA2H/Dne00bdCL/4+ZyUQzX8d/1v7uhPJUGE0MR1tFAYrzoaw
 2sXTCbJQZJ/Z3vjQsM7H9IfrkUS4y/zrHQvtN9Oh8doQabqSlTHKQIsCR25dGBEz5H2Q
 j83RJTesG0ZIO3MwKdhkeZIWmXpUpS4wGRKmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049374; x=1730654174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4f19ZqLrL8kHQu5vsabyXoNnoSWiuBX5CujEWJyHb0=;
 b=k3vyy7cgs4oNFemBRPVJTt+DDWj/fbZkcE1OH3RoeDcDIJidDdX8ufYxESfz14Qd/J
 o9KJk2HEqMrdb133bi9lKdZ6uQ/cJQeEbExU57iziKQwsw53tP4fKlJGRydqhtMWgzvv
 86yjOZI4WSM76gmNftqzwLG/Gk0/irh02N21USAuRxq5K5hy4dChnScMw7lYfu237Mde
 pHtLnfYjKhBM5tg4ZMSD7y6iemB0aadMmaQVb0Vs342bLlUzVJvj1x1TYl4lNw/gOVHT
 d3UzdeSIh0lrxDw4jDjZ5BFGVBjGIRi9jm28+unbP+zifAI2xibBEDWgdOISWzOp6UXW
 4BSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6RLkEnhvzOr/tud4V5LOz6eTcEzjRQKpu/Jzy2fHVJ9m5ELnmRN8wa8wUBwdEqnporpJ06rc=@lists.denx.de
X-Gm-Message-State: AOJu0YwDxOt1SCx3xSlgsToFkK4kiflxkalf41p16sxECzrx9SIwR4oJ
 C5imHbWvMLcwMMNT1VeWao5F18hRgjqBRkJ/aqetRBwEuqjEXO3NmeQKvondE+AhZNawvR9ui+T
 nXNn+80S9/7/d4tOOSVwRHBzTqEAW/t1e3w5j
X-Google-Smtp-Source: AGHT+IGRcLIRqZmDjHSRuKjVA3S7EUGpo+YC4fxbgcCS/JCXXh4sYKWWWMSgmUobu00/q8qstFMz4YTNuZPpxI6Ya3I=
X-Received: by 2002:a17:907:3e06:b0:a9a:cea7:1294 with SMTP id
 a640c23a62f3a-a9ad1a5e5ecmr1236127766b.21.1730049373691; Sun, 27 Oct 2024
 10:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:02 +0100
Message-ID: <CAFLszTg01kiemtLvcdvpJ+QjS=w66E=mVcF9NO8dy9RFnoQP5A@mail.gmail.com>
Subject: Re: [PATCH 3/5] fs: ext4: implement opendir, readdir, closedir
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sat, 26 Oct 2024 at 08:41, Heinrich Schuchardt
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

with nits/questions below

Reviewed-by: Simon Glass <sjg@chromium.org>

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
> +       struct ext2fs_node *dir = NULL;
> +       int ret;
> +
> +       *dirsp = NULL;
> +
> +       dirs = calloc(1, sizeof(struct ext4_dir_stream));
> +       if (!dirs)
> +               return -ENOMEM;
> +       dirs->dirname = strdup(dirname);
> +       if (!dirs) {
> +               free(dirs);
> +               return -ENOMEM;
> +       }
> +
> +       ret = ext4fs_find_file(dirname, &ext4fs_root->diropen, &dir,
> +                              FILETYPE_DIRECTORY);
> +       if (ret == 1) {
> +               ret = 0;
> +               *dirsp = (struct fs_dir_stream *)dirs;
> +       } else {
> +               ret = -ENOENT;
> +       }
> +
> +       if (dir)
> +               ext4fs_free_node(dir, &ext4fs_root->diropen);
> +
> +       return ret;
> +}
> +
> +int ext4fs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
> +{
> +       struct ext4_dir_stream *dirs = (struct ext4_dir_stream *)fs_dirs;
> +       struct fs_dirent *dent = &dirs->dirent;
> +       struct ext2fs_node *dir = NULL;
> +       int ret;
> +       loff_t actread;
> +       struct ext2fs_node fdiro;
> +       int len;
> +       struct ext2_dirent dirent;
> +
> +       *dentp = NULL;
> +
> +       ret = ext4fs_find_file(dirs->dirname, &ext4fs_root->diropen, &dir,
> +                              FILETYPE_DIRECTORY);
> +       if (ret != 1) {
> +               ret = -ENOENT;
> +               goto out;
> +       }
> +       if (!dir->inode_read) {
> +               ret = ext4fs_read_inode(dir->data, dir->ino, &dir->inode);
> +               if (!ret) {
> +                       ret = -EIO;
> +                       goto out;
> +               }
> +       }
> +
> +       if (dirs->fpos >= le32_to_cpu(dir->inode.size))
> +               return -ENOENT;
> +
> +       memset(dent, 0, sizeof(struct fs_dirent));
> +
> +       while (dirs->fpos < le32_to_cpu(dir->inode.size)) {
> +               ret = ext4fs_read_file(dir, dirs->fpos,
> +                                      sizeof(struct ext2_dirent),
> +                                      (char *)&dirent, &actread);
> +               if (ret < 0)
> +                       return -ret;
> +
> +               if (!dirent.direntlen)
> +                       return -EIO;

Should this (and the return immediately above) free call ext4fs_free_node() ?

> +
> +               if (dirent.namelen)
> +                       break;
> +
> +               dirs->fpos += le16_to_cpu(dirent.direntlen);
> +       }
> +
> +       len = min(FS_DIRENT_NAME_LEN - 1, (int)dirent.namelen);
> +
> +       ret = ext4fs_read_file(dir, dirs->fpos + sizeof(struct ext2_dirent),
> +                              len, dent->name, &actread);
> +       if (ret < 0)
> +               goto out;
> +       dent->name[len] = '\0';
> +
> +       fdiro.data = dir->data;
> +       fdiro.ino = le32_to_cpu(dirent.inode);
> +
> +       ret = ext4fs_read_inode(dir->data, fdiro.ino, &fdiro.inode);
> +       if (!ret) {
> +               ret = -EIO;
> +               goto out;
> +       }
> +
> +       switch (le16_to_cpu(fdiro.inode.mode) & FILETYPE_INO_MASK) {
> +       case FILETYPE_INO_DIRECTORY:
> +               dent->type = FS_DT_DIR;
> +               break;
> +       case FILETYPE_INO_SYMLINK:
> +               dent->type = FS_DT_LNK;
> +               break;
> +       case FILETYPE_INO_REG:
> +               dent->type = FS_DT_REG;
> +               break;
> +       default:
> +               dent->type = FILETYPE_UNKNOWN;
> +       }
> +
> +       rtc_to_tm(fdiro.inode.atime, &dent->access_time);
> +       rtc_to_tm(fdiro.inode.ctime, &dent->create_time);
> +       rtc_to_tm(fdiro.inode.mtime, &dent->change_time);
> +
> +       dirs->fpos += le16_to_cpu(dirent.direntlen);
> +       dent->size = fdiro.inode.size;
> +       *dentp = dent;
> +       ret = 0;
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
> +       struct ext4_dir_stream *dirs = (struct ext4_dir_stream *)fs_dirs;
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
>         struct ext2fs_node *dirnode = NULL;
> diff --git a/fs/fs.c b/fs/fs.c
> index e2915e7cf79..a515905c4c9 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -232,7 +232,9 @@ static struct fstype_info fstypes[] = {
>                 .ln = fs_ln_unsupported,
>  #endif
>                 .uuid = ext4fs_uuid,
> -               .opendir = fs_opendir_unsupported,
> +               .opendir = ext4fs_opendir,
> +               .readdir = ext4fs_readdir,
> +               .closedir = ext4fs_closedir,
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
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
>  int ext_cache_read(struct ext_block_cache *cache, lbaint_t block, int size);
> +int ext4fs_opendir(const char *dirname, struct fs_dir_stream **dirsp);
> +int ext4fs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
> +void ext4fs_closedir(struct fs_dir_stream *dirs);

Please add function comments

>  #endif
> --
> 2.45.2
>

Regards,
Simon
