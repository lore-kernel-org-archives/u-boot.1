Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3293FC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 16:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC0E883A0;
	Tue, 28 May 2024 18:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dKVFGmtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 390F1884DC; Tue, 28 May 2024 18:00:36 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC65F87128
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 18:00:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f47eb2354bso7165565ad.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912032; x=1717516832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TSCzf9Yy5AIgfAa9U7b9c3p88xBZMX8wc6BXiHLXnT0=;
 b=dKVFGmtjFZux5XObFgNgFmsOgFrJLuOPOQ2bsh27/6ZkiigbtYWIswoKG9/xPNOxzP
 SwKuwKIln/I4g2UDydyPupYFl9zhOxboDd9DvK8Ev+tmd06J1KmsxL9vKpQVxARtUgeW
 qMwm90BkqFG70CEpjK5AivJSnfQ2RacJIJbru2YwNkKNSIB5tvUACs1K+mMzhxdsozRl
 mtmLEIeq5pn1f26BXp9lVHX6tCg9okPnHNo3S8/xIu34zCh2elgWTjP72XSHVzQ0R9xA
 CKFioyp9OHGtzrj7UNX1aZMSMoZ9biGsrnEscYHDqpW34LmqhDsDO/NXegPsTR6e/c7A
 5I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912032; x=1717516832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TSCzf9Yy5AIgfAa9U7b9c3p88xBZMX8wc6BXiHLXnT0=;
 b=b62YFlh1LUTkd+wTUMY6njK7KKa1qJ6L/uc5xhjRAzCkN5BEQV/Aah0bifoTJ7zVS9
 E9l5Z2OGZdL2I7uw9b/Op6zdENAgDxDbJmxZcsv+NECtB2BKgUFTV5KFI+dKJFNjDvrr
 /yl+RU5+RgwOTXVjLaaXeTHuNlze3uxD+4MBUEq5RBRKH/9uAyi52BtfkS+6FKHv8am9
 TWDD/OzcyoxM6g/WYThy6tmRr6JfoStRM2n7jI5FC3bOE+4eJ4NYwR3M1tRBb8AnRO9d
 yC+zrYW9qOaDw3RIITOLpYsw+lE+LHkH44O0Q5COV9r6dUZV3hEM2KVy4LleMox7h/ks
 KQVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHYA+eqiXT4pJKlgkZbOC0U6PWNcO3eZXZHBI6yEzU//N+bDuxQiQ7/WbiQxyQb8ow4C3dlIz51umS+ptfR+t9Q1TlAg==
X-Gm-Message-State: AOJu0YzKhOZ4xA0jsxz/dpjA6q5dLAbGivyIJAtzZlva98Q+1O7+Btv1
 a6Na8ZfKXcYYqq2yxsIFv/VwWfr/RH51aFxJWSvq+8fUDUuynDqxShgX/MwRl4oPmk7G7JPp6nv
 LgLKbwPGejsqWQN1pFSrbaswhiLBNc+NFIxUGcA==
X-Google-Smtp-Source: AGHT+IH1WjAabkVD2m/i+v6ZurWS3N1yTVEu8ZieV7f5LXrtycRkuyPOwUgzGcZIsNosAvLqLqxXMdbBlsx/5LNcyhs=
X-Received: by 2002:a17:902:ec83:b0:1f4:b34e:21cd with SMTP id
 d9443c01a7336-1f4b34e2479mr48075795ad.26.1716912032125; Tue, 28 May 2024
 09:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240528144252.179247-1-heinrich.schuchardt@canonical.com>
 <20240528144252.179247-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240528144252.179247-9-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 18:59:53 +0300
Message-ID: <CAC_iWjKh2iKVJBAh++dcE9LFTN6-3WZkD-rP7Kgy05sicZpzNg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] efi_loader: load distro dtb in bootmgr
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Tue, 28 May 2024 at 17:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> If no device-tree is specified, try to load a device-tree from the boot
> device use the $fdtfile concatenated to either of the paths '/dtb/', '/',
> '/dtb/current/'.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  include/efi_loader.h         |  2 ++
>  lib/efi_loader/efi_bootmgr.c | 13 +++++++++--
>  lib/efi_loader/efi_fdt.c     | 44 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index ab7bed22971..6c993e1a694 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1205,4 +1205,6 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
>
>  int efi_get_distro_fdt_name(char *fname, int size, int seq);
>
> +void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size);
> +
>  #endif /* _EFI_LOADER_H */
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index b08d6e97ea3..68440542a37 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1249,7 +1249,8 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         efi_handle_t handle;
>         void *load_options;
>         efi_status_t ret;
> -       void *fdt_lo;
> +       void *fdt_lo, *fdt_distro = NULL;
> +       efi_uintn_t fdt_size;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -1269,6 +1270,10 @@ efi_status_t efi_bootmgr_run(void *fdt)
>                         return ret;
>                 if (fdt_lo)
>                         fdt = fdt_lo;
> +               if (!fdt) {
> +                       efi_load_distro_fdt(&fdt_distro, &fdt_size);
> +                       fdt = fdt_distro;
> +               }
>         }
>
>         /*
> @@ -1277,8 +1282,12 @@ efi_status_t efi_bootmgr_run(void *fdt)
>          */
>         ret = efi_install_fdt(fdt);
>
> -       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
> +       if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE)) {
>                 free(fdt_lo);
> +               if (fdt_distro)
> +                       efi_free_pages((uintptr_t)fdt_distro,
> +                                      efi_size_in_pages(fdt_size));
> +       }
>
>         if (ret != EFI_SUCCESS) {
>                 if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
> diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
> index 0edf0c1e2fc..86ba00c2bdd 100644
> --- a/lib/efi_loader/efi_fdt.c
> +++ b/lib/efi_loader/efi_fdt.c
> @@ -71,3 +71,47 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
>
>         return 0;
>  }
> +
> +/**
> + * efi_load_distro_fdt() - load distro device-tree
> + *
> + * @fdt:       on return device-tree, must be freed via efi_free_pages()
> + * @fdt_size:  buffer size
> + */
> +void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size)
> +{
> +       struct efi_device_path *rem, *dp;
> +       efi_status_t  ret;
> +       efi_handle_t device;
> +
> +       *fdt = NULL;
> +
> +       dp = efi_get_dp_from_boot(NULL);
> +       if (!dp)
> +               return;
> +       device = efi_dp_find_obj(dp, NULL, &rem);
> +       ret = efi_search_protocol(device, &efi_simple_file_system_protocol_guid,
> +                                 NULL);
> +       if (ret != EFI_SUCCESS)
> +               goto err;
> +       memcpy(rem, &END, sizeof(END));
> +
> +       /* try the various available names */
> +       for (int seq = 0; ; ++seq) {
> +               struct efi_device_path *file;
> +               char buf[255];
> +
> +               if (efi_get_distro_fdt_name(buf, sizeof(buf), seq))
> +                       break;
> +               file = efi_dp_from_file(dp, buf);
> +               if (!file)
> +                       break;
> +               ret = efi_load_image_from_path(true, file, fdt, fdt_size);
> +               efi_free_pool(file);
> +               if (ret == EFI_SUCCESS)
> +                       break;
> +       }
> +
> +err:
> +       efi_free_pool(dp);
> +}
> --
> 2.43.0
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
