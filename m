Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89264CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 15:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103DD883AC;
	Wed,  3 Apr 2024 17:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jPW8BSlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 341078839F; Wed,  3 Apr 2024 17:37:17 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8B587D1A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 17:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d687da75c4so64815661fa.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712158634; x=1712763434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vDkGwiwwOjfNn9yky1MyWuChCEGYqFZNzeG9l7ShA88=;
 b=jPW8BSlDQcDQ1+c5Eo0pd8rMJlYK+MDYVa9v49be8VY/R8VwnqcpL68+a5WqH7rThO
 6yvqGofEAfZxVBsljxvRDAs5u8yJGGGJuW3+03lNLOnffsih+YMxYo61d/1FIg+DdbtE
 YHt4oRehagno+xN7zlmR9I7QJYomm4IbUzriMKDwq15Jnqq6XX8LU382D4IBaF5Rjbet
 SsHaLkrVoILBJXwO9rrKwAnw4lQ3RMnINecxtOWbG52SSBK95RLNkYBQxAuz8nCvY29b
 mugb5OXrWkKOOyrCxgcrLVM8EekK5AKZ3vLrCjTcgznS+qye7hrf9XDS0UnQHapHX85C
 8KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712158634; x=1712763434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDkGwiwwOjfNn9yky1MyWuChCEGYqFZNzeG9l7ShA88=;
 b=WZPyhpoXKMgC3Qiwdl5rZ40d4YaadansuqYFYyQ4y/1wi5DtY2Pr4G6BiBzOE+maqJ
 kayv5g6xOHx5KTAYggFbiRprH6QEWeSALNbielIcvVXQ92JLqE89KLNthZoWKoL3u/JY
 1MKmu0k1xwCchfIxpMyW4A3cNqgrw0aiSU9OqKcKe49CIGm7APWPjq9/WG31EQbmwaPo
 Ifou1JuHqwFZesTZ8JXCJxYEO1nNUYwLK6M4FaF90rk7ibhCb0mjPwph4AHIlyKsKZNO
 UnYAifvhQQilK231e+c7vInjmrZbS7znj/iGmu0dqCBa/bmvRdJnrBG2lf/5QKZ6bjc3
 b27g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs4Vkw68kCZbEuhNPGybWqU3V9swhGpXdYfWnE4EaJWQFLfY+D7Irf8462vhEZNwjkDq8abqN+LHhbUFsfAnG7m8JSug==
X-Gm-Message-State: AOJu0YzaZFypcB6Syy/zARHVy6Xxz2vxaMq7vtisEbvz3Zmo9Zbv8rIC
 xDHzHMRi2seFb/v6NLBtl53WKRY0jyjs+T3Q62f2SR3XcsQN45ZaX8IVWDRVGusSMT5YOX7wPCR
 nICwRnEBxhU2eruXlfZiER3kxnvF9uR+S8D5wZw==
X-Google-Smtp-Source: AGHT+IFtZ48rfuvxD9OfHdRERJGp6/EejwLduG011M2bYGwYtBdVbZ4sxroJjTPeONDtIP9bLiG/zkFEv4j4ICnfdwM=
X-Received: by 2002:ac2:4253:0:b0:513:ed0f:36c4 with SMTP id
 m19-20020ac24253000000b00513ed0f36c4mr1991294lfl.43.1712158634534; Wed, 03
 Apr 2024 08:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240403153335.96971-1-heinrich.schuchardt@canonical.com>
 <20240403153335.96971-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240403153335.96971-4-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Apr 2024 18:36:38 +0300
Message-ID: <CAC_iWj+3=O1upUNCc7paTZEZyQozUkU-YLYYL_X5obz7cqJxig@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: handle
 EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>, u-boot@lists.denx.de
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

On Wed, 3 Apr 2024 at 18:34, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We don't yet support EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS for file
> based variables, but we should pass it to TEE based variable stores.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi.h                 | 3 ++-
>  lib/efi_loader/efi_variable.c | 8 ++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/efi.h b/include/efi.h
> index 62cfb993d2e..c3c4b93f860 100644
> --- a/include/efi.h
> +++ b/include/efi.h
> @@ -507,7 +507,8 @@ extern char _binary_u_boot_bin_start[], _binary_u_boot_bin_end[];
>                                 EFI_VARIABLE_HARDWARE_ERROR_RECORD | \
>                                 EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS | \
>                                 EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS | \
> -                               EFI_VARIABLE_APPEND_WRITE)
> +                               EFI_VARIABLE_APPEND_WRITE | \
> +                               EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS)
>
>  /**
>   * efi_get_priv() - Get access to the EFI-private information
> diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
> index 48ad813d79b..e09a5e7ccb2 100644
> --- a/lib/efi_loader/efi_variable.c
> +++ b/lib/efi_loader/efi_variable.c
> @@ -235,8 +235,12 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         if (data_size && !data)
>                 return EFI_INVALID_PARAMETER;
>
> -       /* EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated */
> -       if (attributes & EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS)
> +       /*
> +        * EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS is deprecated.
> +        * We don't support EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS.
> +        */
> +       if (attributes & (EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS | \
> +                         EFI_VARIABLE_ENHANCED_AUTHENTICATED_ACCESS))
>                 return EFI_UNSUPPORTED;
>
>         /* Make sure if runtime bit is set, boot service bit is set also */
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
