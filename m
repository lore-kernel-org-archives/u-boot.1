Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C69DC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 12:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35891800B3;
	Tue,  4 Feb 2025 13:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AyplWBqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6C7800CF; Tue,  4 Feb 2025 13:54:36 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C8180040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 13:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5b107c4346so1120420276.2
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 04:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673673; x=1739278473; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NgYw7S+biaUIXi0Fj4dbsliIc6BCM4oqwZ6N8dPfbIg=;
 b=AyplWBqGYRlGJcOloIo7kYLcHDUKh9s1YZtjyrFr7zj638lKOPjYWCWrIEKiu7tDac
 wkUErX/kWsXj+a87pps3BcG/uc5tWfl36Ta5YDfMkr5hhsTZbdKIySVbH+CVzK/s9cob
 FH3rQtLl3vFiFq1dWO4RzFWyXifmBQdZqV2bRv6IZEMtk8hyZacCl31+l6OkO5mW5tEo
 TUYo3kMrDMj2opyq+q1PZVY9Cd7iNmryTe7i5ez2iyPUSVw3E/Bi3qJndSimps+Wr4v+
 bMh1fe7n72ySRjoO+RTZy5+9QcqPnnmotXTPXZGQt7XLxqaOmYL9kS9w351uw2WMshe4
 VZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673673; x=1739278473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NgYw7S+biaUIXi0Fj4dbsliIc6BCM4oqwZ6N8dPfbIg=;
 b=bU30tiyrh97J42t3d7P5kPnUySf1ssbeROoZy+h2I62SXpgTD+iDfL7pezJHwBcpHz
 CaHzUIvVw4POlH1iBnmI/NwdxI69gcWQd3+Xu6M3sD36IoRVADhawe5pDrXI4yvGZlLO
 3NGMjtf5uLBBiMPSNGGQom6OdTyLsWvJMwCOcdCNdWRtIx6ukA1fDIrqlQhTEwOs+19Q
 qQHaD6OEoscKDKH7V60eRoMGHA5WPqBoGsaXs7PM/qOxW20mHTBefSUI90xij4AFaXwC
 9LBrMPwFSjv9ntl1dqqQkdujl0H24fHlZXIqPZ8VUcCQTZBqKgzhQoZtFFfEJHWNx5ZV
 w9+A==
X-Gm-Message-State: AOJu0YzJI8i55pge4PDeRiJA0uNqM04EZAwn237r/58CJktPJRu99QZi
 P9PlHMmF/VbizcEFLc/Ryh/oP+affK6/9XMBedQe5SsnOEopVNvv8+vR2F7TuiEFn7uDYqMnu+s
 3CWh6SPiom22vhcplX8UaP/YLfEdMavGSF9Lnog==
X-Gm-Gg: ASbGncvSy8IEeaDtvg9UkqlFFAS/v6A/iwnVkutD3eDbQ6yOHYIwIruFPvThqmgOxoD
 Ec20k4zKTtJQCFB8tfgfb5eNzjG1NQ5wfSrmHx1dremnitAM0J834kaLAERLM6hRIaZqqSNEF
X-Google-Smtp-Source: AGHT+IHwkaG0Gj838W3ILw02TaZcdlkG0EvBrj5WahKEH97sGC/RmwrFZeqrgRCv1dZU9QuLUk2zYylrT5Vv78DPHaI=
X-Received: by 2002:a05:6902:18c9:b0:e57:f8cd:f0a4 with SMTP id
 3f1490d57ef6-e58a4bcc1demr18185031276.34.1738673673055; Tue, 04 Feb 2025
 04:54:33 -0800 (PST)
MIME-Version: 1.0
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-7-gabriel.dalimonte@gmail.com>
In-Reply-To: <20250122053232.17365-7-gabriel.dalimonte@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 4 Feb 2025 14:53:57 +0200
X-Gm-Features: AWEUYZky2b_giW89HU4Um-7b1YxmVIeIHppFDoG1rvPiKu20Lgi0H7GOI5iyF-g
Message-ID: <CAC_iWjKGpcHWCXkEN1_CpEr+dtA_qEftCqB8LseF_p-Aqdo6ig@mail.gmail.com>
Subject: Re: [PATCH 6/6] efi_loader: support file rename in SetInfo()
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

Hi Gabriel

On Wed, 22 Jan 2025 at 07:34, Gabriel Dalimonte
<gabriel.dalimonte@gmail.com> wrote:
>
> Following the UEFI specification. The specification did not seem to
> delineate if file_name was explicitly a file name only, or could
> include paths to move the file to a different directory. The more
> generous interpretation of supporting paths was selected.
>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> ---
>
>  lib/efi_loader/efi_file.c | 48 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index e72bc36aca..f3d643a057 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -981,11 +981,49 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
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
> +                       char *new_path;
> +
> +                       if (set_blk_dev(fh)) {
> +                               free(new_file_name);
> +                               ret = EFI_DEVICE_ERROR;
> +                               goto out;
> +                       }
> +                       dlen = filename - fh->path;
> +                       new_path = calloc(1, dlen + strlen(new_file_name) + 1);
> +                       if (!new_path) {
> +                               free(new_file_name);
> +                               ret = EFI_OUT_OF_RESOURCES;
> +                               goto out;

It's not too clear from the patch context but, instead of keeping
track of new_file_name/new_path can you move it to 'out' and init
those variables to NULL?

> +                       }
> +                       memcpy(new_path, fh->path, dlen);
> +                       strcpy(new_path + dlen, new_file_name);
> +                       sanitize_path(new_path);
> +                       rv = fs_exists(new_path);
> +                       if (rv) {
> +                               free(new_path);
> +                               free(new_file_name);

I think we should add some kind of an error message here and in the fails below.

Otherwise looks good.
Thanks
/Ilias

> +                               ret = EFI_ACCESS_DENIED;
> +                               goto out;
> +                       }
> +                       /* fs_exists() calls fs_close(), so open file system again */
> +                       if (set_blk_dev(fh)) {
> +                               free(new_path);
> +                               free(new_file_name);
> +                               ret = EFI_DEVICE_ERROR;
> +                               goto out;
> +                       }
> +                       rv = fs_rename(fh->path, new_path);
> +                       if (rv) {
> +                               free(new_path);
> +                               free(new_file_name);
> +                               ret = EFI_ACCESS_DENIED;
> +                               goto out;
> +                       }
> +                       free(fh->path);
> +                       fh->path = new_path;
> +                       ret = EFI_SUCCESS;
>                 }
>                 free(new_file_name);
>                 /* Check for truncation */
> --
> 2.34.1
>
