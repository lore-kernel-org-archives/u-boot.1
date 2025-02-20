Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD04C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:34:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE65801DE;
	Thu, 20 Feb 2025 08:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d//5pKM8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773B580A46; Thu, 20 Feb 2025 08:34:09 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970E0801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6fb2a6360efso4375597b3.0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740036845; x=1740641645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z381Oan8RlT9f4r0BSPePI+i81WF1LdwG3uIAyNYwGk=;
 b=d//5pKM8XhPsZMFZYtZdI6oL1f5PeFuXHH37zAe3bgSHfgOu+DBF5J1FOjeO53yQQk
 QCir01q8DWxJaH+aDvw6Isgt462VKDMLc8f50vOIczA5L2p1pUE2nHq9pV/lwSKR75cj
 qoAgJrb3aGGyC4qZjQq7LHAqwMfHmExr1/RFdL8bZ5rCxn/Kf6jc81Kd16QIzQBYXRvw
 x/F6R8yOsxnhqPl74QpiItjwRyJaUv53szsBt5H4PYyLZnztd22jKIcE2sh6qoTFdB1Q
 AwoMdHGwZullOzCgjMkg94WBfsJuwzeH8d4OStmt4ZA/s+cBQt9jGOkRKn4a1V0LJ3SJ
 b4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740036845; x=1740641645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z381Oan8RlT9f4r0BSPePI+i81WF1LdwG3uIAyNYwGk=;
 b=lYiN/pSyAR7oYrWKSEQshbG7jfdi6wOxOca443qeJc87FdjbF8raE2ZdbI+oqsew8X
 tymSwHfml2/Jjp/O3VsPC6c5e9qkBz8/GXHBjzAmtPwqXELqYiS1PbONuYePAt4+8lWD
 KDyEEw476sQeJ103NBvpM8+mX1uum7Gxvpdj1eULG01+muCKmKyc4uiz3lw6T7RKFX2a
 jk7fFBOVXNgXCqVsMFIufH2j5+rWReazSwEKZr2xXz2M1T1rMYCIK9mOneU/ycnOMHmN
 wmlvhgKpx3AmK39mnoO3o7mPeAXjW53CEEEiEIRCra61zuB165a2EYKWUTxn1ZiYX6rP
 IfCw==
X-Gm-Message-State: AOJu0YwHp/Xz2SisWCASxnzviVN5eKR1SMPBHnNRmWMV8WKPnWp4leJV
 VX2Us5UWyXU3os+/xAMmA3lQqaALFsMNu55uwkzFYvDHooWjYnWUN1HrXHx65lK/dhhuoAO03bD
 S3Ndwqwo1t+iJAF8UMw25suSMQ7rSvzlSmwoosw==
X-Gm-Gg: ASbGncs+kp9c958/Vcd09I8wJVWpVkfmhnDwYbRiCx0kxu9Qke1qq7QJm29lnhovy43
 exgLDwCzrvOkYzzJCv7kGA7otyHIzxYbZlDStKM6fBWAkeuQThg6jZSWV9ry5ViTB4peYdgYSbQ
 ==
X-Google-Smtp-Source: AGHT+IGaRPFQmUDwBneGMl2+VIZlk+0sbw4X6s0BtLifJ6EfJgEXqHS2XqfkUAoHDB2G47WtGPb5DYtLyUY9MAs1oJg=
X-Received: by 2002:a05:690c:4b87:b0:6f7:5605:c62b with SMTP id
 00721157ae682-6fbbb758ed4mr11268017b3.27.1740036845315; Wed, 19 Feb 2025
 23:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
 <20250217182648.31294-3-gabriel.dalimonte@gmail.com>
In-Reply-To: <20250217182648.31294-3-gabriel.dalimonte@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 09:33:29 +0200
X-Gm-Features: AWEUYZmQtgi-creNO472rxbMXGdVIQ_2TqVz4pvCnlSfbr4ahH1v6o732SlzfNo
Message-ID: <CAC_iWj+J-Wx0fyFjutk9UFGQWVvjvRiGLR=Xf_e=2RUVatsn8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] fs: add rename infrastructure
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Gabriel,

On Mon, 17 Feb 2025 at 20:31, Gabriel Dalimonte
<gabriel.dalimonte@gmail.com> wrote:
>
> The selection for *rename as the name for the rename/move operation
> derives from the POSIX specification where they name the function
> rename/renameat. [1] This aligns with Linux where the syscalls for
> renaming/moving also use the rename/renameat naming.
>
> [1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.html
>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
>
> ---
>
> Changes in v2:
>  - cleanup log message and verbosity in fs_rename()
>  - update fs_close() docstring with reference to fs_rename()
>  - clarify fs_rename() behaviour in docstring
>
>
> ---
>  fs/fs.c      | 32 ++++++++++++++++++++++++++++++++
>  include/fs.h | 14 +++++++++++++-
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index 99ddcc5e37b..fdff83719b1 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char *dirname)
>         return -1;
>  }
>
> +static inline int fs_rename_unsupported(const char *old_path,
> +                                       const char *new_path)
> +{
> +       return -1;
> +}
> +
>  struct fstype_info {
>         int fstype;
>         char *name;
> @@ -183,6 +189,7 @@ struct fstype_info {
>         int (*unlink)(const char *filename);
>         int (*mkdir)(const char *dirname);
>         int (*ln)(const char *filename, const char *target);
> +       int (*rename)(const char *old_path, const char *new_path);
>  };
>
>  static struct fstype_info fstypes[] = {
> @@ -206,6 +213,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>  #endif
> +               .rename = fs_rename_unsupported,
>                 .uuid = fat_uuid,
>                 .opendir = fat_opendir,
>                 .readdir = fat_readdir,
> @@ -238,6 +246,7 @@ static struct fstype_info fstypes[] = {
>                 .closedir = ext4fs_closedir,
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
> @@ -257,6 +266,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>                 .ln = fs_ln_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #if CONFIG_IS_ENABLED(SEMIHOSTING)
> @@ -276,6 +286,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>                 .ln = fs_ln_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #ifndef CONFIG_XPL_BUILD
> @@ -296,6 +307,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>                 .ln = fs_ln_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #endif
> @@ -317,6 +329,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>                 .ln = fs_ln_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #endif
> @@ -339,6 +352,7 @@ static struct fstype_info fstypes[] = {
>                 .ln = fs_ln_unsupported,
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>  #if IS_ENABLED(CONFIG_FS_EROFS)
> @@ -360,6 +374,7 @@ static struct fstype_info fstypes[] = {
>                 .ln = fs_ln_unsupported,
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  #endif
>         {
> @@ -378,6 +393,7 @@ static struct fstype_info fstypes[] = {
>                 .unlink = fs_unlink_unsupported,
>                 .mkdir = fs_mkdir_unsupported,
>                 .ln = fs_ln_unsupported,
> +               .rename = fs_rename_unsupported,
>         },
>  };
>
> @@ -713,6 +729,22 @@ int fs_ln(const char *fname, const char *target)
>         return ret;
>  }
>
> +int fs_rename(const char *old_path, const char *new_path)
> +{
> +       struct fstype_info *info = fs_get_info(fs_type);
> +       int ret;
> +
> +       ret = info->rename(old_path, new_path);
> +
> +       if (ret < 0) {
> +               log_debug("Unable to rename %s -> %s\n", old_path, new_path);
> +               ret = -1;
> +       }
> +       fs_close();
> +
> +       return ret;
> +}
> +
>  int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
>             int fstype)
>  {
> diff --git a/include/fs.h b/include/fs.h
> index 2474880385d..5b272eb9f5e 100644
> --- a/include/fs.h
> +++ b/include/fs.h
> @@ -86,7 +86,7 @@ int fs_set_blk_dev_with_part(struct blk_desc *desc, int part);
>   *
>   * Many file functions implicitly call fs_close(), e.g. fs_closedir(),
>   * fs_exist(), fs_ln(), fs_ls(), fs_mkdir(), fs_read(), fs_size(), fs_write(),
> - * fs_unlink().
> + * fs_unlink(), fs_rename().
>   */
>  void fs_close(void);
>
> @@ -270,6 +270,18 @@ int fs_unlink(const char *filename);
>   */
>  int fs_mkdir(const char *filename);
>
> +/**
> + * fs_rename - rename/move a file or directory
> + *
> + * @old_path: existing path of the file/directory to rename
> + * @new_path: new path of the file/directory. If this points to an existing
> + * file or empty directory, the existing file/directory will be unlinked.
> + * If this points to a non-empty directory, the rename will fail.
> + *
> + * Return: 0 on success, -1 on error conditions
> + */
> +int fs_rename(const char *old_path, const char *new_path);
> +
>  /*
>   * Common implementation for various filesystem commands, optionally limited
>   * to a specific filesystem type via the fstype parameter.
> --
> 2.34.1
>

I am by no means an expert on our FS support but this looks reasonable
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
