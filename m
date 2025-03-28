Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2DEC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248FB8129B;
	Fri, 28 Mar 2025 13:37:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZAj/kAZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39C681951; Fri, 28 Mar 2025 13:37:40 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 637988070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:37:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e63504bedd0so1525404276.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165457; x=1743770257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jMfp6RihTlxHq3CgLzqsXglI0UQ8lTKVx+K4UpbceB8=;
 b=ZAj/kAZlo2LVI4fxEAgI36M4vFrEHjS3Nq/NiwKkO8bDeFcA9sD59Isc8ZV7ULY2jB
 XgQWGUsvw6XPIhzqfzWAkiTdemU2VnVBh0tVzLUBMbdiUaGUSc+qrOE9Tog820dEQL7d
 XT7WOrw0Munt+GRlsJy5QBaxIoKhRi1T0qvdjAn0abqPXTvUsuamxYNPmMLzeZJa7o+Q
 CuphLG5RUQVHHWqzg69nlhjglZn/Tp+Qi4q2H6TOCeEXV/l4o2l9U9IyAZZHLyP9yYjM
 Ue4z8Ko6gyc1irWXhCIRrTWJ7qt2yY6vz+5QcLVC+LNBB4AM2fZGJdsm9o9+UoXzdeey
 gPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165457; x=1743770257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMfp6RihTlxHq3CgLzqsXglI0UQ8lTKVx+K4UpbceB8=;
 b=n7/DBqKUDjePKIQPlwYOPCKC05qZ2wASQsWJRsbJSRR3tpUqm0Os/aNqzrfm9sXpdQ
 lbH4xaqvWzaJ1+AxYCuB9ig42mZ88r5io6l6aS4sd4TGicuMFB+qRuvZOSuMTU1KeQ23
 bmJm/KPv8o+fUXIjoO8wMqjaOPsELZIM+ZGVeA0IROY5cNa4MmSd+jCbWulYl4bWCFyn
 FHyXpQp0w78hCRF5xY5XqZo9BtAbwnyh/dkLkj7Jn9Co0gSbHttur75e1azOdgvG7os8
 zcvsUxfAl5B/aW/5QdJwuVg/EPI1nfhFDNSvrebSoSIlsjcTX7WeUrdP6GWkv5byCirH
 G+TQ==
X-Gm-Message-State: AOJu0YzpEQZe5K9vxj9BJFumtCCMBY78JlHfo/whsMWnqRiIN5ksbgsb
 Vapm6Y9mrpFGHeV2K//XdzqzuPI4cndluiMVuMjkNQMrHIw8djpTz+FZDzFm8DKoOk9XdsgkrMK
 5XtdBX/vtenB3mthWoznydKjE2oniRVdg/foRlFpZJWdC/tuU
X-Gm-Gg: ASbGncsuDU7H1fGRkcnS5HiLu9tQ7/aDemhxOEj4fAArH+0PnyINjpvnx0npsKghcTA
 46TxtZ1Iuk9RVwd/ByZYETFsXsAF4sHq5lTRX+GF2o6N+ycZQFE0XzodGyYT7DRerKhhXmp0nd/
 iA+WCAqvnvcu9pYCizeD4FPRqs
X-Google-Smtp-Source: AGHT+IEJ5p6JeRXzWGJoOJXx5ZagpRLZFI6tfmX3t3KZMCGbgRNGKMro83cl/lCWwGB0wpK0MWy9NPpYUyV/asVPjpw=
X-Received: by 2002:a05:6902:1b89:b0:e69:18e6:6760 with SMTP id
 3f1490d57ef6-e694377528dmr8971326276.42.1743165457048; Fri, 28 Mar 2025
 05:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
 <20250319144501.32277-2-adriano.cordova@canonical.com>
In-Reply-To: <20250319144501.32277-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:37:01 +0200
X-Gm-Features: AQ5f1JrunYHxXJzt-kYMUquTNTinyPmDvH8mF4P9idDQo5oMcF6C2-cGKcsEueI
Message-ID: <CAC_iWjJg2L_dE24XVBUqb=2zez+E3qBs2HWALr-zgCqhqwsT8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] efi_loader: efi_load_initrd: provide a memory
 mapped initrd
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 19 Mar 2025 at 16:44, Adriano Cordova <adrianox@gmail.com> wrote:
>
> U-Boot can pass an initrd to subsequent boot stages via the
> EFI_LOAD_FILE2_PROTOCOL. The current implementation only supports
> this functionality via the efi boot manager: the initrd is taken
> from the load options of the BootCurrent variable. This commit adds
> support for registering a memory mapped initrd, e.g. loaded from a
> FIT image. For now this new method takes precedence over loading the
> initrd from the BootCurrent variable (if both are present) because
> the BootCurrent variable is not cleared on exiting the boot manager.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>



> ---
>
> (no changes since v1)
>
>  include/efi_loader.h             |  2 +-
>  lib/efi_loader/efi_bootmgr.c     |  2 +-
>  lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++-----
>  3 files changed, 62 insertions(+), 13 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index e9c10819ba2..cc732dc4807 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -667,7 +667,7 @@ efi_status_t efi_http_register(const efi_handle_t handle,
>                                struct efi_service_binding_protocol *http_service_binding);
>  /* Called by bootefi to make the watchdog available */
>  efi_status_t efi_watchdog_register(void);
> -efi_status_t efi_initrd_register(void);
> +efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd);
>  efi_status_t efi_initrd_deregister(void);
>  /* Called by bootefi to make SMBIOS tables available */
>  /**
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c6124c590d9..6e66cf3793c 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -670,7 +670,7 @@ static efi_status_t try_load_entry(u16 n, efi_handle_t *handle,
>
>         /* try to register load file2 for initrd's */
>         if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
> -               ret = efi_initrd_register();
> +               ret = efi_initrd_register(NULL);
>                 if (ret != EFI_SUCCESS)
>                         goto error;
>         }
> diff --git a/lib/efi_loader/efi_load_initrd.c b/lib/efi_loader/efi_load_initrd.c
> index fb8cc7bcbe3..74b92f8bd66 100644
> --- a/lib/efi_loader/efi_load_initrd.c
> +++ b/lib/efi_loader/efi_load_initrd.c
> @@ -42,6 +42,7 @@ static const struct efi_lo_dp_prefix dp_lf2_handle = {
>  };
>
>  static efi_handle_t efi_initrd_handle;
> +static struct efi_device_path *efi_initrd_dp;
>
>  /**
>   * get_initrd_fp() - Get initrd device path from a FilePathList device path
> @@ -72,6 +73,41 @@ static efi_status_t get_initrd_fp(struct efi_device_path **initrd_fp)
>         return EFI_SUCCESS;
>  }
>
> +/**
> + * efi_initrd_from_mem() - load initial RAM disk from memory
> + *
> + * This function copies the initrd from the memory mapped device
> + * path pointed to by efi_initrd_dp
> + *
> + * @buffer_size:               size of allocated buffer
> + * @buffer:                    buffer to load the file
> + *
> + * Return:                     status code
> + */
> +static efi_status_t efi_initrd_from_mem(efi_uintn_t *buffer_size, void *buffer)
> +{
> +       efi_status_t ret = EFI_NOT_FOUND;
> +       efi_uintn_t bs;
> +       struct efi_device_path_memory *mdp;
> +
> +       mdp = (struct efi_device_path_memory *)efi_initrd_dp;
> +       if (!mdp)
> +               return ret;
> +
> +       bs = mdp->end_address - mdp->start_address;
> +
> +       if (!buffer || *buffer_size < bs) {
> +               ret = EFI_BUFFER_TOO_SMALL;
> +               *buffer_size = bs;
> +       } else {
> +               memcpy(buffer, (void *)mdp->start_address, bs);
> +               *buffer_size = bs;
> +               ret = EFI_SUCCESS;
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * efi_load_file2_initrd() - load initial RAM disk
>   *
> @@ -118,6 +154,9 @@ efi_load_file2_initrd(struct efi_load_file_protocol *this,
>                 goto out;
>         }
>
> +       if (efi_initrd_dp)
> +               return EFI_EXIT(efi_initrd_from_mem(buffer_size, buffer));
> +
>         ret = get_initrd_fp(&initrd_fp);
>         if (ret != EFI_SUCCESS)
>                 goto out;
> @@ -209,6 +248,9 @@ efi_status_t efi_initrd_deregister(void)
>                                                          NULL);
>         efi_initrd_handle = NULL;
>
> +       efi_free_pool(efi_initrd_dp);
> +       efi_initrd_dp = NULL;
> +
>         return ret;
>  }
>
> @@ -234,24 +276,31 @@ static void EFIAPI efi_initrd_return_notify(struct efi_event *event,
>   * This function creates a new handle and installs a Linux specific vendor
>   * device path and an EFI_LOAD_FILE2_PROTOCOL. Linux uses the device path
>   * to identify the handle and then calls the LoadFile service of the
> - * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk.
> + * EFI_LOAD_FILE2_PROTOCOL to read the initial RAM disk. If dp_initrd is
> + * not provided, the initrd will be taken from the BootCurrent variable
> + *
> + * @dp_initrd: optional device path containing an initrd
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_initrd_register(void)
> +efi_status_t efi_initrd_register(struct efi_device_path *dp_initrd)
>  {
>         efi_status_t ret;
>         struct efi_event *event;
>
> -       /*
> -        * Allow the user to continue if Boot#### file path is not set for
> -        * an initrd
> -        */
> -       ret = check_initrd();
> -       if (ret == EFI_INVALID_PARAMETER)
> -               return EFI_SUCCESS;
> -       if (ret != EFI_SUCCESS)
> -               return ret;
> +       if (dp_initrd) {
> +               efi_initrd_dp = dp_initrd;
> +       } else {
> +               /*
> +               * Allow the user to continue if Boot#### file path is not set for
> +               * an initrd
> +               */
> +               ret = check_initrd();
> +               if (ret == EFI_INVALID_PARAMETER)
> +                       return EFI_SUCCESS;
> +               if (ret != EFI_SUCCESS)
> +                       return ret;
> +       }
>
>         ret = efi_install_multiple_protocol_interfaces(&efi_initrd_handle,
>                                                        /* initramfs */
> --
> 2.48.1
>
