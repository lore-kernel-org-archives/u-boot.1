Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E9C021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 08:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 739EB801CF;
	Thu, 20 Feb 2025 09:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BQdWSRyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE53B80A46; Thu, 20 Feb 2025 09:22:28 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DF4980077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e46ebe19489so560875276.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 00:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740039745; x=1740644545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nL/5rSFNd9W+cuU+uf5bRpFDV0EvIiIXyR90l+erE0M=;
 b=BQdWSRyvivOCteqCQTGCQxh95Fgb+RPnc3roFMWj9T33GgtUfQ4wfDiXut15s1Xzob
 ANhF3V5lDzxmSNsgjmsLR3ZAhJvGUnFh1ODMHmNkxJNu7zZoMn9fIJGBvgQiUNVK0Rs4
 2APHBZnrBXARAc/YwuCbAJtznBoDCgu9fZbQDqXPqeO6KPSUGQPFc0+pufc6k6Buay3w
 7IV08fIPmP4fRu5GtW18MmSP4vrCImEozkBjpO/SR2L5S0GINIg4l5WQ82ZWCuS7b6WG
 AH31FOFcjIt0RFRw6NRzkRMIuzDoKL2OYaE8Tgb3w+YC9VcTjo0Oev7tS0n0JybYRqXd
 6z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740039745; x=1740644545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nL/5rSFNd9W+cuU+uf5bRpFDV0EvIiIXyR90l+erE0M=;
 b=XedTYqMGsMdYXZHZ57A0jv+lEx8HUBh1xycz3z8fPhOJOIicLk9oDCKsBvzWCGCBb9
 J7sTX6pKsvKReHyAmUo86VqVGnHjXI6Nyn4yjFsLyYMjYD/fhSq2DWlZSgVniV5uCf1R
 qsDq1xbXsz1otPbcCMsn+F8ib4ctPeR79nZXDqNJSFjygF4M5oqRiIjDvZZPwgg7smv4
 peKUYqILK58WPysTVlx2XPKE/pJwM00iygcpxCctevdUw2zqgzqSdPzkDeYsBNe736tP
 oLsHrRL2bzSwYJgfxfkbqjDXsc3UVEK0NVlee6hrR8GxZyuJB8GVZ4DayPK5sFq7MQEl
 hGBQ==
X-Gm-Message-State: AOJu0Yx7a09IOsbOk+UMGa1E7v7/GlJfN48Pk8lla/xbooykQqaL7357
 39HslW0fEF9I/MkQMIseNHkVuNE/Wp4vfkXFDho7VfVWVEA9UAHUL3x39pqNixzyu2WvEKTKrad
 MPV8B7O6OoVvy5Zo164P65XNPy9bCNKBBbwTcBA==
X-Gm-Gg: ASbGncuwREmdqYI7P2fTR8KqgdfedzruWr3CkJwME3xGRgRuQ+TUQNzbKc5AZ/oz1Kz
 LyXsQX+SMaJvVOP9wcSpeo/KXvdmO4uBv0879lDKhXKZb5wywR64+7iWpKHaaguTIUhDBwp4AgQ
 ==
X-Google-Smtp-Source: AGHT+IGlN5eTYaWH7hcgR7DnyB2InZSWDZJgiHxDdDDLnmHEkW5NdJolRGaX/OgjMPdk+kiPGlZeckpAfX6r/QbjHBA=
X-Received: by 2002:a05:6902:2787:b0:e5d:bd57:6220 with SMTP id
 3f1490d57ef6-e5e0a1809aamr5365592276.42.1740039745302; Thu, 20 Feb 2025
 00:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20250217182648.31294-1-gabriel.dalimonte@gmail.com>
 <20250217182648.31294-7-gabriel.dalimonte@gmail.com>
In-Reply-To: <20250217182648.31294-7-gabriel.dalimonte@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 20 Feb 2025 10:21:49 +0200
X-Gm-Features: AWEUYZnJA8zIn5Uf4_8wDDgcVSr4FwsgU-JaDJTpHghkGeEskOrC8HjTpRniOBI
Message-ID: <CAC_iWjLCyOpJHqGCs5ms3zzQQRjK4_WZDpXbm7vt2j5FwkT=WQ@mail.gmail.com>
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

Hi Gabriel,

On Mon, 17 Feb 2025 at 20:31, Gabriel Dalimonte
<gabriel.dalimonte@gmail.com> wrote:
>
> Following the UEFI specification. The specification did not seem to
> delineate if file_name was explicitly a file name only, or could
> include paths to move the file to a different directory. The more
> generous interpretation of supporting paths was selected.
>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
>
> ---
>
> Changes in v2:
>  - simplify freeing of new_file_name and new_path
>
>
> ---
>  lib/efi_loader/efi_file.c | 45 +++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 6b15c1f3d27..7d81da8f2d8 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -954,6 +954,7 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
>  {
>         struct file_handle *fh = to_fh(file);
>         efi_status_t ret = EFI_UNSUPPORTED;
> +       char *new_file_name = NULL, *new_path = NULL;
>
>         EFI_ENTRY("%p, %pUs, %zu, %p", file, info_type, buffer_size, buffer);
>
> @@ -983,13 +984,43 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
>                 pos = new_file_name;
>                 utf16_utf8_strcpy(&pos, info->file_name);
>                 if (strcmp(new_file_name, filename)) {
> -                       /* TODO: we do not support renaming */
> -                       EFI_PRINT("Renaming not supported\n");
> -                       free(new_file_name);
> -                       ret = EFI_ACCESS_DENIED;
> -                       goto out;
> +                       int dlen;
> +                       int rv;
> +
> +                       if (set_blk_dev(fh)) {
> +                               ret = EFI_DEVICE_ERROR;
> +                               goto out;
> +                       }
> +                       dlen = filename - fh->path;
> +                       new_path = calloc(1, dlen + strlen(new_file_name) + 1);
> +                       if (!new_path) {
> +                               ret = EFI_OUT_OF_RESOURCES;
> +                               goto out;
> +                       }
> +                       memcpy(new_path, fh->path, dlen);
> +                       strcpy(new_path + dlen, new_file_name);
> +                       sanitize_path(new_path);
> +                       rv = fs_exists(new_path);
> +                       if (rv) {
> +                               ret = EFI_ACCESS_DENIED;
> +                               goto out;
> +                       }
> +                       /* fs_exists() calls fs_close(), so open file system again */
> +                       if (set_blk_dev(fh)) {
> +                               ret = EFI_DEVICE_ERROR;
> +                               goto out;
> +                       }
> +                       rv = fs_rename(fh->path, new_path);
> +                       if (rv) {
> +                               ret = EFI_ACCESS_DENIED;
> +                               goto out;
> +                       }
> +                       free(fh->path);
> +                       fh->path = new_path;
> +                       /* Prevent new_path from being freed on out */
> +                       new_path = NULL;

fh->path is also NULL now. I am not sure where these are used but this
seems wrong.

> +                       ret = EFI_SUCCESS;
>                 }
> -               free(new_file_name);
>                 /* Check for truncation */
>                 if (!fh->isdir) {
>                         ret = efi_get_file_size(fh, &file_size);
> @@ -1012,6 +1043,8 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
>                 ret = EFI_UNSUPPORTED;
>         }
>  out:
> +       free(new_path);
> +       free(new_file_name);
>         return EFI_EXIT(ret);
>  }
>
> --
> 2.34.1
>

Thanks
/Ilias
