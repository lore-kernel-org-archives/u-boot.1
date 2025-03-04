Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EAAC282D0
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 12:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6542C816AF;
	Tue,  4 Mar 2025 13:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X8g5t+HS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5078104B; Tue,  4 Mar 2025 03:30:24 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4797D8059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 03:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gabriel.dalimonte@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abf5e1a6cd3so422368366b.2
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 18:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741055421; x=1741660221; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmZPF/eN0m8KM1DLJeF+udzsQqZrOUGtzNabN3FRf4o=;
 b=X8g5t+HSgmzirNBB3Eq9hV2gFvAMwj3oNeP8M8Wynv68w7oesCJLZhTIq4WwvGm/6/
 e/2YvC+OcK/LTAQREiUyyWtImrmv1m6VTT8DWSttYEwZGOJzfTFQJglLNGUA2GbDsvRc
 oDb625pF2IbaGBNSZyTyLMg/BjYXgwmefabTJFy2d0kqJcv3b0bSdaEetbWy1GmzRrJM
 Cr+74DtK4nwgo9aYOGsGcK8TfKufExIMeKk8kQWhmZ1vhbiHqjeM/WZ9iRPSqydhmYTJ
 ATYtKnsGsL9ncUWHAswsS80lYsxdw74KT/taBer/Mft2QyfCFgs/Xp+oz/sQ0p5E02A8
 QFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741055421; x=1741660221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmZPF/eN0m8KM1DLJeF+udzsQqZrOUGtzNabN3FRf4o=;
 b=uohAXloNgY98ADMCZ0vriYafnjc8mIMCvUh2oK8bURsyjGECQtJQ/M3MDQ/i40bAMJ
 nka3+tJLxul0dxChSdntphXdrdTct2eTdHHZJBtfuvLRVnU0K/wduMiWTkMqb+0MVgM7
 0gI0m/LLJ7NnTBJFXkY9w8FyQtKT5G7PN+Qe/mMH/SraG5xAnkok8KZk2S8jTTkfaM2O
 IUvkISvf0ymxXd/NdwNqY7UqMZyb4ThKjEG7LEQ7r5zCg34ZSE28T9Ck4zcXMVxkVP0E
 BCkrJlHsNP/MVokPV8V/Fj3iI5PubXaqAHCYCuJD0E2Wtsq0/oKLey07vmYhr6ZQT5Pt
 3MtQ==
X-Gm-Message-State: AOJu0Yx12dipRnD7X0wU76jyRGKME4lBGMsmARuJWus/A6zK6I8v8lMA
 rDU5oeJFOd2ko5qIfoccFmXkcLmCahf1pCE6zREtSzR/DZkd3KVrqHFgWUEI/4df643NAipIV4K
 gjkeU5QmrOpCaQn4BKbcB8p+bWsw=
X-Gm-Gg: ASbGncsRnAIro2DUsV4Bci3lh+Y87/pmEByuf6HBUhd3NmvAhejWjDv0I/XQmaCznFu
 K5B7fkM5jk2Wno5SLZpx3FX5Esxv3kPABYVfkzFVrpJ9itPbOOO1ku/Ce4IQJNJiEN0Dzm9BTCl
 aK6AuTSgGvImKD9PEGkgu98oHTfw==
X-Google-Smtp-Source: AGHT+IGavmR32VYUadwmzbERCBGLAIFb2fv4KUnrKE81DqQnB8uSAVdWUMOt3uraPKWaS6llvjuOzixqhdQHqEuEKCg=
X-Received: by 2002:a17:907:7247:b0:abf:78df:343b with SMTP id
 a640c23a62f3a-abf78df3db0mr521815666b.21.1741055421201; Mon, 03 Mar 2025
 18:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
 <20250217182648.31294-6-gabriel.dalimonte@gmail.com>
 <CAC_iWjLnSwKWeTzAR5u5NO94RjPqk4z8ymcRa+LdZ3WFwLXGyA@mail.gmail.com>
In-Reply-To: <CAC_iWjLnSwKWeTzAR5u5NO94RjPqk4z8ymcRa+LdZ3WFwLXGyA@mail.gmail.com>
From: "Gabriel D'Alimonte" <gabriel.dalimonte@gmail.com>
Date: Mon, 3 Mar 2025 21:30:11 -0500
X-Gm-Features: AQ5f1JradYOu_nQL0o8R7xRiac8rNlxV3mrJMnpwuiJF7qn-ZZD1ppHN4FkETpM
Message-ID: <CAHc-7YtExsHnkQMtVf_YdqkyZAx2O+0GKvNDWSHcvU2tcQ8s+w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi_loader: move path out of file_handle
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Mar 2025 13:58:09 +0100
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

Hi Ilias,

Thanks for the review!

On Thu, Feb 20, 2025 at 2:55=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Gabriel,
>
> On Mon, 17 Feb 2025 at 20:31, Gabriel Dalimonte
> <gabriel.dalimonte@gmail.com> wrote:
> >
> > In order to support renaming via SetInfo(), path must allow for longer
> > values than what was originally present when file_handle was allocated.
> >
> > Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_file.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> > index 201fa5f8f3c..6b15c1f3d27 100644
> > --- a/lib/efi_loader/efi_file.c
> > +++ b/lib/efi_loader/efi_file.c
> > @@ -40,7 +40,7 @@ struct file_handle {
> >         struct fs_dir_stream *dirs;
> >         struct fs_dirent *dent;
> >
> > -       char path[0];
> > +       char *path;
> >  };
> >  #define to_fh(x) container_of(x, struct file_handle, base)
> >
> > @@ -178,6 +178,7 @@ static struct efi_file_handle *file_open(struct fil=
e_system *fs,
> >                 u64 attributes)
> >  {
> >         struct file_handle *fh;
> > +       char *path;
> >         char f0[MAX_UTF8_PER_UTF16] =3D {0};
> >         int plen =3D 0;
> >         int flen =3D 0;
> > @@ -194,11 +195,13 @@ static struct efi_file_handle *file_open(struct f=
ile_system *fs,
> >                 plen =3D strlen(parent->path) + 1;
> >         }
> >
> > +       fh =3D calloc(1, sizeof(*fh));
> >         /* +2 is for null and '/' */
> > -       fh =3D calloc(1, sizeof(*fh) + plen + (flen * MAX_UTF8_PER_UTF1=
6) + 2);
> > -       if (!fh)
> > -               return NULL;
> > +       path =3D calloc(1, plen + (flen * MAX_UTF8_PER_UTF16) + 2);
>
> I assume the new allocation gets freed in patch #6 right?
> Is there an easy way to include this change in the current patch?
> Otherwise, we'll end up not freeing memory on a specific sha commit.
> I can live with it if the change is too tricky though.

The `path` variable is assigned to `fh->path`

>
> > +       if (!fh || !path)
> > +               goto error;
> >
> > +       fh->path =3D path;

here. I used the intermediate `path` variable to collapse calloc
failure handling
into a single conditional. If it is preferable to split the
conditional and eliminate
`path`, I can make that change.

> >         fh->open_mode =3D open_mode;
> >         fh->base =3D efi_file_handle_protocol;
> >         fh->fs =3D fs;
> > @@ -245,6 +248,7 @@ static struct efi_file_handle *file_open(struct fil=
e_system *fs,
> >         return &fh->base;
> >
> >  error:
> > +       free(fh->path);
> >         free(fh);
> >         return NULL;
> >  }
> > @@ -368,6 +372,7 @@ out:
> >  static efi_status_t file_close(struct file_handle *fh)
> >  {
> >         fs_closedir(fh->dirs);
> > +       free(fh->path);
> >         free(fh);
> >         return EFI_SUCCESS;
> >  }
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias

Thanks,
Gabriel
