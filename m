Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DFDC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 05:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A166980F7B;
	Sun, 26 Jan 2025 06:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EvHb/ji+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFDA580F58; Sun, 26 Jan 2025 05:38:15 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7425F807E4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 05:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaec111762bso697077966b.2
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 20:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737866293; x=1738471093; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=874q4/v9gWdZ+JM3KX7PgRxR8VV6tkasMVi0ZLNSa+U=;
 b=EvHb/ji+yzea1ucvM3wasHpLfgL0vNqyAJ4u3roWV0rrZ/KtA7mEF40kCF59RQBdP2
 Zo/0AvwuCq8V1tkiJPhFXjAvp5OOsNkfapcdMrSt/JQtmNleEqRWa0/k55WVYeNP/3Ih
 1+XYihqwVek9KAoRUH2Z3a/Uov/HjJI7f4HH4z+7D6oZBA3XsUgTrA58K0r+TINzrfkB
 /dl3fXsf3ifViDlDazfhbQWUhJw57uSwrV4JjHCn/m1TDC50C4BL+kWY6evA6KL3qwLS
 AvImgrLqY7bMCjpWhHjN3M7byR2dr5F5sreYC6Dec5UOgR7te+wJksWLRLwNn/biHWDX
 qTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737866293; x=1738471093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=874q4/v9gWdZ+JM3KX7PgRxR8VV6tkasMVi0ZLNSa+U=;
 b=KhXPjl0iV66CPz1pOPcGqe0Uk4UaJ+Rw8MlIUDsGvIYhk/4IARhps2z9hrcluCmPcn
 Ce31SbOJwuMEaNEz7QjaRK6hIl2dFMYcjHi+lqXDe5mn51hB3dBa5fcfLrxsjuRrxeDD
 fLPQQyEMxVnqFt6JCjGlnNl8OBhBHSBK9IGuaojqYBbw41fN7Alv2P0wa0R6VsWMz7Io
 cwM7zVTAAt2GqhxK8CoOprWT/oRcr6HvMU91ZuAiwwXVmNIqtwZ9Fm1CYoUT+r/wvXNA
 5bOMzs79n6nw9/w6yU7unWsr8xUhAKFyANBGsQmDCbVCWjlgeXMlihImVgfyVIl/VGZw
 ryCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgV7QbnZZyZwKrokc1TEHKF59GVM7rU23bAEEJzDQdj9ZXFHR2V2mjt/T1S8TdJ/HfewzWp0M=@lists.denx.de
X-Gm-Message-State: AOJu0YxyKYQdLKfrX3bH84TOU0sVkjmQ6cv9KZIMygRZzvgwIL8uIJh4
 pbbtwraGWeF7kR2ClFejHvkvNO8SBPzOZqhjS7Pkjjl73y98Y4YCZ/D+DVqW90oOD0Zc9vsT/yc
 OFA3T+m294ckGliHRUG0M2751fyg=
X-Gm-Gg: ASbGncvGIQgkXHq1y31VpCDAwaAPhjmMbAuMgKCGA0etG+thpxRXkTHamfjP6tRc2uG
 gSdOFwvoZjdMVuxRTSboRYDvGwK2VKF8rrQNxa0acVut/yvC6JTlnh/uLXG6DQA==
X-Google-Smtp-Source: AGHT+IFP1wuwnSpvroWWOu4sEgZe9wuZntrlXHhFjXymX7+8V6s0NpI37ULyKHN3MZgiE52YeNKKe2nIee1oh+8DbsA=
X-Received: by 2002:a17:907:97cb:b0:aaf:c259:7f6 with SMTP id
 a640c23a62f3a-ab38b36bcf0mr3195905566b.45.1737866292679; Sat, 25 Jan 2025
 20:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-3-gabriel.dalimonte@gmail.com>
 <4a2a96b2-dc0e-4cd2-96c5-399d96f2b5fb@gmx.de>
 <648d934e-17fc-4f6d-9cb7-574e0144af8f@gmx.de>
In-Reply-To: <648d934e-17fc-4f6d-9cb7-574e0144af8f@gmx.de>
From: "Gabriel D'Alimonte" <gabriel.dalimonte@gmail.com>
Date: Sat, 25 Jan 2025 23:38:02 -0500
X-Gm-Features: AWEUYZm3S3a54zTmk01BqHq81e11g3fQ7zZTEQ4niZUpsGHbfjgG7g-JPQP07ik
Message-ID: <CAHc-7Yt5sK1R-9GEsE1CJLR-3+oWpFzBt5U4NC4mv35uaaHrCA@mail.gmail.com>
Subject: Re: [PATCH 2/6] fs: add rename infrastructure
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, Jan 22, 2025 at 4:18=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 22.01.25 09:10, Heinrich Schuchardt wrote:
> > On 22.01.25 06:32, Gabriel Dalimonte wrote:
> >> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> >> ---
> >
> > Please, add a commit message.
> >
> >>
> >>   fs/fs.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> >>   include/fs.h | 13 +++++++++++++
> >>   2 files changed, 60 insertions(+)
> >>
> >> diff --git a/fs/fs.c b/fs/fs.c
> >> index 99ddcc5e37..160a43c957 100644
> >> --- a/fs/fs.c
> >> +++ b/fs/fs.c
> >> @@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char
> >> *dirname)
> >>       return -1;
> >>   }
> >>
> >> +static inline int fs_rename_unsupported(const char *old_path,
> >> +                    const char *new_path)
> >> +{
> >> +    return -1;
> >> +}
> >> +
> >>   struct fstype_info {
> >>       int fstype;
> >>       char *name;
> >> @@ -183,6 +189,7 @@ struct fstype_info {
> >>       int (*unlink)(const char *filename);
> >>       int (*mkdir)(const char *dirname);
> >>       int (*ln)(const char *filename, const char *target);
> >> +    int (*rename)(const char *old_path, const char *new_path);
> >>   };
> >>
> >>   static struct fstype_info fstypes[] =3D {
> >> @@ -206,6 +213,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>   #endif
> >> +        .rename =3D fs_rename_unsupported,
> >>           .uuid =3D fat_uuid,
> >>           .opendir =3D fat_opendir,
> >>           .readdir =3D fat_readdir,
> >> @@ -238,6 +246,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .closedir =3D ext4fs_closedir,
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
> >> @@ -257,6 +266,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>           .ln =3D fs_ln_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #if CONFIG_IS_ENABLED(SEMIHOSTING)
> >> @@ -276,6 +286,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>           .ln =3D fs_ln_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #ifndef CONFIG_XPL_BUILD
> >> @@ -296,6 +307,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>           .ln =3D fs_ln_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #endif
> >> @@ -317,6 +329,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>           .ln =3D fs_ln_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #endif
> >> @@ -339,6 +352,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .ln =3D fs_ln_unsupported,
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>   #if IS_ENABLED(CONFIG_FS_EROFS)
> >> @@ -360,6 +374,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .ln =3D fs_ln_unsupported,
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   #endif
> >>       {
> >> @@ -378,6 +393,7 @@ static struct fstype_info fstypes[] =3D {
> >>           .unlink =3D fs_unlink_unsupported,
> >>           .mkdir =3D fs_mkdir_unsupported,
> >>           .ln =3D fs_ln_unsupported,
> >> +        .rename =3D fs_rename_unsupported,
> >>       },
> >>   };
> >>
> >> @@ -713,6 +729,22 @@ int fs_ln(const char *fname, const char *target)
> >>       return ret;
> >>   }
> >>
> >> +int fs_rename(const char *old_path, const char *new_path)
> >> +{
> >> +    struct fstype_info *info =3D fs_get_info(fs_type);
> >> +    int ret;
> >> +
> >> +    ret =3D info->rename(old_path, new_path);
> >> +
> >> +    if (ret < 0) {
> >> +        log_err("** Unable to rename %s -> %s **\n", old_path,
> >> new_path);
> >
> > We should not write messages by default. This will may lead to output
> > layout in EFI applications looking wrong.
> >
> > log_debug() would be adequate.
> >
> > We don't need the "** " first characters.
> >
> > Otherwise the patch looks good to me.
> >
> > Best regards
> >
> > Heinrich
> >
> >> +        ret =3D -1;
> >> +    }
> >> +    fs_close();
> >> +
> >> +    return ret;
> >> +}
> >> +
> >>   int do_size(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >> argv[],
> >>           int fstype)
> >>   {
> >> @@ -975,6 +1007,21 @@ int do_ln(struct cmd_tbl *cmdtp, int flag, int
> >> argc, char *const argv[],
> >>       return 0;
> >>   }
> >>
> >> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >> argv[],
> >> +          int fstype)
> >> +{
> >> +    if (argc !=3D 5)
> >> +        return CMD_RET_USAGE;
> >> +
> >> +    if (fs_set_blk_dev(argv[1], argv[2], fstype))
> >> +        return 1;
> >> +
> >> +    if (fs_rename(argv[3], argv[4]))
> >> +        return 1;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   int do_fs_types(struct cmd_tbl *cmdtp, int flag, int argc, char *
> >> const argv[])
> >>   {
> >>       struct fstype_info *drv =3D fstypes;
> >> diff --git a/include/fs.h b/include/fs.h
> >> index 2474880385..24b121f55d 100644
> >> --- a/include/fs.h
> >> +++ b/include/fs.h
> >> @@ -270,6 +270,17 @@ int fs_unlink(const char *filename);
> >>    */
> >>   int fs_mkdir(const char *filename);
> >>
> >> +/**
> >> + * fs_rename - rename a file or directory
>
> Shouldn't this function be called fs_move() and allow moving a file from
> one directory to another?

I went with fs_rename() since the implementation mirrors the POSIX
specification. [1]

>
> >> + *
> >> + * @old_path: existing path of the file/directory to rename
> >> + * @new_path: new path of the file/directory. If this points to an
> >> existing
> >> + * file or empty directory, the existing file/directory will be
> >> unlinked.
>
> What happens if the directory is non-empty?

As per [1], the function aborts the rename (without making any
changes). Answering this question made me realize I'm erroneously
returning EINVAL in this condition instead of the correct EEXIST or
ENOTEMPTY. Thanks. :)

>
> I would prefer a real move function that copies the old file to the
> pre-existing target directory.

To clarify: Is this for changing fs_rename() to fs_move() (or adding
fs_move() in addition to fs_rename()) or changing the command
(fat)rename to mv?

Thanks,
Gabriel

[1] https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.html

>
> Best regards
>
> Heinrich
>
> >> + *
> >> + * Return: 0 on success, -1 on error conditions
> >> + */
> >> +int fs_rename(const char *old_path, const char *new_path);
> >> +
> >>   /*
> >>    * Common implementation for various filesystem commands, optionally
> >> limited
> >>    * to a specific filesystem type via the fstype parameter.
> >> @@ -290,6 +301,8 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int
> >> argc, char *const argv[],
> >>            int fstype);
> >>   int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >> argv[],
> >>         int fstype);
> >> +int do_rename(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >> argv[],
> >> +          int fstype);
> >>
> >>   /*
> >>    * Determine the UUID of the specified filesystem and print it.
> >> Optionally it is
> >
>
