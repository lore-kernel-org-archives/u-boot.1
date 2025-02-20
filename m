Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC43C021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C411801DE;
	Thu, 20 Feb 2025 08:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k2HMRgSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A00180C98; Thu, 20 Feb 2025 08:56:05 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 480AA801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e545c1e8a15so739586276.1
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 23:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740038158; x=1740642958; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E6jlCy6VDPEGLPGrRvHH+tzWg4YG5087zfGkgDbXMdk=;
 b=k2HMRgSeYrEfhe8y+Y3+ExhcDZd1UihZWC/2WiT+/P7WhRE10gQD/WG1YFtvrr6z2M
 LXA8/o98KC2IgbMzlr6fJxEtICF9Kmw1YGeJRX/uxHMGJpdCIIb1TNLCVAYpAqi9/GVu
 8gEbfjxAnPBxR5iWq39hGYDwx3Hsdg9tfKZ1Tj2Hx+ZFGRwUzc+aBJytEFvgsL6xThO6
 kv+ojaTT4LEbj2YdehI4w4UbwsKRQRlRkI90ym94Uj7jm01lHnNuCb7QWqOSzz/A+pz6
 d8Ql/Mfzdqcml6GDyR6sa/36DaiIC5ifQYQ4FXe4RsmG3auDcxVJyM+Z6JufMXlTGE4B
 brzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038158; x=1740642958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E6jlCy6VDPEGLPGrRvHH+tzWg4YG5087zfGkgDbXMdk=;
 b=nOMCWJBkEpbE67Uj46pABtoO22splByGXCIFOwKXKqyKBC8Z15ytyKsA7GCVI1PDi0
 lqhketiy6M1tfNbRxAkY9GgFe+o8++tmwjqMwAqKJpqtXaW7yEHxYiGZXASWKaKsxLhN
 igmg/utGr3lYhrpTlk2U1Wsejuvyo5rKeoOmhOcUm0vYvnUx3qM01vsRIDJ+7I5xUEYi
 gvGPkCIZ91ixdVKrOLRG9kXoBo4hbE7iAKIZfcBl9fusEQgxv2U6FrH4NfZzabut1H9k
 eH4gVXKBeMJgojykbQVe1PZUPg2eH/Gdyrr7sAFWjfVAFO7Ckps11Wgha2HM9ZUGIW78
 sdmw==
X-Gm-Message-State: AOJu0YxqomlxOnI5V0M0lLTv/JHVryMUAIT8Vu8UuCO9U3Um8BuU81Ez
 C5WuA0PV0kPtbEJsZe0CTXCi0PWmjyKJTNKDmClcydIcl1DINTh7i0SCiUvKyMTViGVKKlJeLMt
 pEcwv/MrPUIeYuWMyUA5mEZmXHt9I/DGRcULX6w==
X-Gm-Gg: ASbGncvGeLg+7K3K/IW53JtNC92YlmJ1yZHlvayP7ApNJkPC393m0mnAJKoJPznJHFx
 eM79a0RwwRql+YGoBb6Q6XtwoB/i7H1pXA720bjgwL13Lr411tG+GYbfEi5n8SqyRwg0zNrmCpw
 ==
X-Google-Smtp-Source: AGHT+IFlaDbBxuFwF/Rzp4as7bJtXyWH0EE34uiwarXIhRuyf5Jh7lqgJxJl50ZkuimZ4zjFX+xF4QxLL4HOvb9fssM=
X-Received: by 2002:a05:6902:240c:b0:e5e:1034:db93 with SMTP id
 3f1490d57ef6-e5e1034dc6emr3693499276.34.1740038158046; Wed, 19 Feb 2025
 23:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
 <20250217182648.31294-6-gabriel.dalimonte@gmail.com>
In-Reply-To: <20250217182648.31294-6-gabriel.dalimonte@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 09:55:21 +0200
X-Gm-Features: AWEUYZmtU7vdgCxaVgLwGtTmkK7oYSEEkgvpqeR5g_EImodi-RBxTVsVygiUQ2w
Message-ID: <CAC_iWjLnSwKWeTzAR5u5NO94RjPqk4z8ymcRa+LdZ3WFwLXGyA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] efi_loader: move path out of file_handle
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

Hi Gabriel,

On Mon, 17 Feb 2025 at 20:31, Gabriel Dalimonte
<gabriel.dalimonte@gmail.com> wrote:
>
> In order to support renaming via SetInfo(), path must allow for longer
> values than what was originally present when file_handle was allocated.
>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_file.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 201fa5f8f3c..6b15c1f3d27 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -40,7 +40,7 @@ struct file_handle {
>         struct fs_dir_stream *dirs;
>         struct fs_dirent *dent;
>
> -       char path[0];
> +       char *path;
>  };
>  #define to_fh(x) container_of(x, struct file_handle, base)
>
> @@ -178,6 +178,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>                 u64 attributes)
>  {
>         struct file_handle *fh;
> +       char *path;
>         char f0[MAX_UTF8_PER_UTF16] = {0};
>         int plen = 0;
>         int flen = 0;
> @@ -194,11 +195,13 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>                 plen = strlen(parent->path) + 1;
>         }
>
> +       fh = calloc(1, sizeof(*fh));
>         /* +2 is for null and '/' */
> -       fh = calloc(1, sizeof(*fh) + plen + (flen * MAX_UTF8_PER_UTF16) + 2);
> -       if (!fh)
> -               return NULL;
> +       path = calloc(1, plen + (flen * MAX_UTF8_PER_UTF16) + 2);

I assume the new allocation gets freed in patch #6 right?
Is there an easy way to include this change in the current patch?
Otherwise, we'll end up not freeing memory on a specific sha commit.
I can live with it if the change is too tricky though.

> +       if (!fh || !path)
> +               goto error;
>
> +       fh->path = path;
>         fh->open_mode = open_mode;
>         fh->base = efi_file_handle_protocol;
>         fh->fs = fs;
> @@ -245,6 +248,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>         return &fh->base;
>
>  error:
> +       free(fh->path);
>         free(fh);
>         return NULL;
>  }
> @@ -368,6 +372,7 @@ out:
>  static efi_status_t file_close(struct file_handle *fh)
>  {
>         fs_closedir(fh->dirs);
> +       free(fh->path);
>         free(fh);
>         return EFI_SUCCESS;
>  }
> --
> 2.34.1
>

Thanks
/Ilias
