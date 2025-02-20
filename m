Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F49FC021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC5080F53;
	Thu, 20 Feb 2025 09:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SB4Ws13m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2E180F5C; Thu, 20 Feb 2025 09:31:35 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9913080A46
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e5dad00b2e6so685163276.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740040291; x=1740645091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=172GzwILzao8qhzlzSPgovc/00pKWui2QfhHSLJFK/U=;
 b=SB4Ws13m9S4HVDbmRBeXCxj9QZW+qtYqYLWvWVBYkHWtPQVegmDNCcxRVV4LcGHhk6
 YQ2P6phywlPoQotL5LoRyPcK412JZ0zqINwRQ64wxEldIg06PCcQLRJOmmNR3GDLoGaF
 oIYs4xM2xZyq8tlUMrhonedIiZNM/hR+mM4NnIPOKBJclD2ql7cT/b/CXJlhulFoUHk1
 +1A1DSt6IuE/LJdZngt8T3f63nqfEZ95jaEbBbZvDxcG2LIIR1FqsnqTWjF+Ff3/exw3
 RyOBYJhkdGsI4yuBLGkZg9GOIoJdDTRF87tlCGKjgAgCwaJ2bUgUOjc+0XQoysVgDNhj
 2VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740040291; x=1740645091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=172GzwILzao8qhzlzSPgovc/00pKWui2QfhHSLJFK/U=;
 b=IpgtUsxvonH3vKFSIyrH8oYGBT3qY/Tflce3K+slxdtiOB9GlhpIk1dwkafgGZQR3c
 nLbwVXrkZqM6IS6Gf+4+Y3To7zd0HOCT88f2nurg+ffFaNETO+hByRH3t1c2wihAp2xY
 lMZERg9cmmXgyIlvTUOck+i0UhvZJTvIaCk2/p4kBKudHvGK9iOXuFeNylUvTIM6fCpL
 tLgF7rlA7QczpPLXPvc+0IcL9kkNC+iEUuJ/HGdgIp+ucQbxx/f+zqcAXFJOjIcgpa5B
 j9mAxG1aWPWTH6bqlxjNWloQ9teuM0YtY4xgzCWUNYTZ9QPsRkkGE6F92RgbPaISUvgF
 zLGw==
X-Gm-Message-State: AOJu0YyR2Bo8dJWtw0/yxqP+JtuGvf3KovE67OTfh31VPWm9nATrYXRy
 1XqsagmrAyZ4YfTJ71h3U3KrLNqfN1SntGHu0/DhZkTgv3en4YccEttQ8eyOGqT4nWs6nHkn1wD
 4nClr1J7nEGmnZvC7VNG99bZ5BjilcijwD5D5DVxnb1zWrBTg4k4=
X-Gm-Gg: ASbGncv/k+7K5sXVyF6AOE11rBhsMEJ7YuZQ2hZPglfynQ3CsbUmnlx/SdGnB0msMXx
 yRjzTGoRHfgRqjl1wzRr+/6Dk7v0O69mWS2VSvF2bEDD23mipQPPp9YbfL3+HpletsrB3cuYEVg
 ==
X-Google-Smtp-Source: AGHT+IGyp1xehd5qybva8zuDAKXLtbCcuh2ItA0xDNCz9GZHdDNFLEECZ+/5R2Jv2VncdSKh8SjebY+mTtGj8LIJXo0=
X-Received: by 2002:a05:6902:2081:b0:e5b:34cb:ebb2 with SMTP id
 3f1490d57ef6-e5e1b386f06mr805591276.19.1740040291407; Thu, 20 Feb 2025
 00:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
 <20250217182648.31294-7-gabriel.dalimonte@gmail.com>
 <CAC_iWjLCyOpJHqGCs5ms3zzQQRjK4_WZDpXbm7vt2j5FwkT=WQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLCyOpJHqGCs5ms3zzQQRjK4_WZDpXbm7vt2j5FwkT=WQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 10:30:55 +0200
X-Gm-Features: AWEUYZlZArXJl8MsyyKvhn3FM9OUds70vSHoOn_giVfqtm7A9N1JeMeo91KORxE
Message-ID: <CAC_iWjLyRrQ6mwO2KZHJVDof-nztd2qRNz2QJJE3Z7hx6i1LNw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] efi_loader: support file rename in SetInfo()
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Thu, 20 Feb 2025 at 10:21, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Gabriel,
>
> On Mon, 17 Feb 2025 at 20:31, Gabriel Dalimonte
> <gabriel.dalimonte@gmail.com> wrote:
> >
> > Following the UEFI specification. The specification did not seem to
> > delineate if file_name was explicitly a file name only, or could
> > include paths to move the file to a different directory. The more
> > generous interpretation of supporting paths was selected.
> >
> > Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> >
> > ---
> >
> > Changes in v2:
> >  - simplify freeing of new_file_name and new_path
> >
> >
> > ---
> >  lib/efi_loader/efi_file.c | 45 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> > index 6b15c1f3d27..7d81da8f2d8 100644
> > --- a/lib/efi_loader/efi_file.c
> > +++ b/lib/efi_loader/efi_file.c
> > @@ -954,6 +954,7 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
> >  {
> >         struct file_handle *fh = to_fh(file);
> >         efi_status_t ret = EFI_UNSUPPORTED;
> > +       char *new_file_name = NULL, *new_path = NULL;
> >
> >         EFI_ENTRY("%p, %pUs, %zu, %p", file, info_type, buffer_size, buffer);
> >
> > @@ -983,13 +984,43 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
> >                 pos = new_file_name;
> >                 utf16_utf8_strcpy(&pos, info->file_name);
> >                 if (strcmp(new_file_name, filename)) {
> > -                       /* TODO: we do not support renaming */
> > -                       EFI_PRINT("Renaming not supported\n");
> > -                       free(new_file_name);
> > -                       ret = EFI_ACCESS_DENIED;
> > -                       goto out;
> > +                       int dlen;
> > +                       int rv;
> > +
> > +                       if (set_blk_dev(fh)) {
> > +                               ret = EFI_DEVICE_ERROR;
> > +                               goto out;
> > +                       }
> > +                       dlen = filename - fh->path;
> > +                       new_path = calloc(1, dlen + strlen(new_file_name) + 1);
> > +                       if (!new_path) {
> > +                               ret = EFI_OUT_OF_RESOURCES;
> > +                               goto out;
> > +                       }
> > +                       memcpy(new_path, fh->path, dlen);
> > +                       strcpy(new_path + dlen, new_file_name);
> > +                       sanitize_path(new_path);
> > +                       rv = fs_exists(new_path);
> > +                       if (rv) {
> > +                               ret = EFI_ACCESS_DENIED;
> > +                               goto out;
> > +                       }
> > +                       /* fs_exists() calls fs_close(), so open file system again */
> > +                       if (set_blk_dev(fh)) {
> > +                               ret = EFI_DEVICE_ERROR;
> > +                               goto out;
> > +                       }
> > +                       rv = fs_rename(fh->path, new_path);
> > +                       if (rv) {
> > +                               ret = EFI_ACCESS_DENIED;
> > +                               goto out;
> > +                       }
> > +                       free(fh->path);
> > +                       fh->path = new_path;
> > +                       /* Prevent new_path from being freed on out */
> > +                       new_path = NULL;
>
> fh->path is also NULL now. I am not sure where these are used but this
> seems wrong.

Right ignore me, this is comment is obviously wrong and the patch is fine

>
> > +                       ret = EFI_SUCCESS;
> >                 }
> > -               free(new_file_name);
> >                 /* Check for truncation */
> >                 if (!fh->isdir) {
> >                         ret = efi_get_file_size(fh, &file_size);
> > @@ -1012,6 +1043,8 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
> >                 ret = EFI_UNSUPPORTED;
> >         }
> >  out:
> > +       free(new_path);
> > +       free(new_file_name);
> >         return EFI_EXIT(ret);
> >  }
> >
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
