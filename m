Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F55BD30007
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 13:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD64E88EA3;
	Fri, 18 Oct 2024 15:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T5vqsHEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB7A388E94; Fri, 18 Oct 2024 15:43:35 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8740188E7B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 15:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2e2ed59a35eso1814752a91.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729259012; x=1729863812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2udwzNgr6Xxd0+AnIEKvhYyv0AYjvcyu2OmF0YoYJJc=;
 b=T5vqsHEOK8lb9PHG0ijxmZzh3+4fN4zF4K17w8bcn725gdg4LD78pEBX8Ppyr3dX9+
 IAFOhiUo/BEqnkYK4wxba96jArNAsgZ5pS7jH0noD7fkUBk8b2PNg+xwn38x4EONL5ec
 mgVY95etu6U9IosRtoRrieaUSg44+hpYyQX/H94wpg9RkoZotB5suDWlYEarRj99tieT
 9lfMmTgMn6LtodQ0eNt/GdTRqYX0BYfSGqbh12Z5EvAXwO1f2h56jjIMvvCqo4VONaeq
 FPmACLZLxtzl7ItUtKPC0RworDsSGN5ZZ/tO09RfDaTE5RF5Xg/jbJ9Pg+9unrqYlRxU
 9opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729259012; x=1729863812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2udwzNgr6Xxd0+AnIEKvhYyv0AYjvcyu2OmF0YoYJJc=;
 b=wxSVc0OSdOk1XJVFab9UijXUZskWtajCko3mOY863UrorDVy0puzxXiRShLdDE7LfK
 8lnCcS0KqmIOsCgsbWYcBNK3csF0i+0qJzQww2RzkshQH0tZoxNXih9dnRLm3LTFZDY9
 8EvAzAO3Xjv96YJergl9wKzgHIU56dGMMYGhNTYjYzKROo44Rt8OARNDEGZ49GENG6Jd
 dbwSyy5PzWC2UmLZ1gdzfqmyhnq0jgvMVtifntLULQdYX7cbkME41WQC7jDdGZMta+FF
 u5G/aGNwcMfYM58K87lcEtowG3YOCPQ98xxHdxvTiFYLfomNRtWZ5W6tG9iqc1R83pO+
 g3VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHJE9niCNOu3lMZGDqw6H/VgLaNDx2MsRA6OS4KODX0e/HTrj0SwaQDPg9KNUTq0bzmBAgGYY=@lists.denx.de
X-Gm-Message-State: AOJu0YzCPVkvjdf101+OeOAVpIBpWNxDRbXlSmfSJjSlhRrEiRxV0SMp
 j6W7rQU6GnKtN+NP9JBHZ5vUq/rP1RTwsxsG+F/GQPlSVmva8S0vosIcJbeWXVwEs1emxsAUk58
 bLjhJ286Pr9rrD+7r+RS9oSj4GoeT24/KA53Uuw==
X-Google-Smtp-Source: AGHT+IFZEjR9FXUdrX+yEfyPB+V3OHfiwGPZ0qFMcINrG988/ybz+XLMOTnlQVe9/4tU34KD/f2mKobat9NgA51V4Fs=
X-Received: by 2002:a17:90a:ab0e:b0:2e2:f04d:9f0c with SMTP id
 98e67ed59e1d1-2e5617246edmr3003331a91.13.1729259012028; Fri, 18 Oct 2024
 06:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018011837.126813-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Oct 2024 16:42:54 +0300
Message-ID: <CAC_iWj+N7GviHP0yL2_Pz9_1Ysdx2dV4D4dMRuacs7nk6B+7hA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: reduce noisiness if ESP is missing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Fri, 18 Oct 2024 at 04:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> EFI variables can be stored in a file on the EFI system partition. If that
> partition is missing we are writing two error messages per variable. This
> is too noisy.
>
> Just warn once about the missing ESP.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  lib/efi_loader/efi_var_file.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 413e1794e88..ba0bf33ffbd 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -37,18 +37,16 @@ static efi_status_t __maybe_unused efi_set_blk_dev_to_system_partition(void)
>         char part_str[PART_STR_LEN];
>         int r;
>
> -       if (efi_system_partition.uclass_id == UCLASS_INVALID) {
> -               log_err("No EFI system partition\n");
> +       if (efi_system_partition.uclass_id == UCLASS_INVALID)
>                 return EFI_DEVICE_ERROR;
> -       }
> +
>         snprintf(part_str, PART_STR_LEN, "%x:%x",
>                  efi_system_partition.devnum, efi_system_partition.part);
>         r = fs_set_blk_dev(blk_get_uclass_name(efi_system_partition.uclass_id),
>                            part_str, FS_TYPE_ANY);
> -       if (r) {
> -               log_err("Cannot read EFI system partition\n");
> +       if (r)
>                 return EFI_DEVICE_ERROR;
> -       }
> +
>         return EFI_SUCCESS;
>  }
>
> @@ -67,14 +65,21 @@ efi_status_t efi_var_to_file(void)
>         loff_t len;
>         loff_t actlen;
>         int r;
> +       static bool once;
>
>         ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
>         if (ret != EFI_SUCCESS)
>                 goto error;
>
>         ret = efi_set_blk_dev_to_system_partition();
> -       if (ret != EFI_SUCCESS)
> -               goto error;
> +       if (ret != EFI_SUCCESS) {
> +               if (!once) {
> +                       log_warning("Cannot persist EFI variables without system partition\n");
> +                       once = true;
> +               }
> +               goto out;
> +       }
> +       once = false;
>
>         r = fs_write(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, len, &actlen);
>         if (r || len != actlen)
> @@ -83,6 +88,7 @@ efi_status_t efi_var_to_file(void)
>  error:
>         if (ret != EFI_SUCCESS)
>                 log_err("Failed to persist EFI variables\n");
> +out:
>         free(buf);
>         return ret;
>  #else
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
