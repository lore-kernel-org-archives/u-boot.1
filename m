Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F77FC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149CD80BAD;
	Mon, 28 Apr 2025 07:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nONo6CUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3DA820B7; Mon, 28 Apr 2025 07:37:54 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3C98004F
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2260c91576aso36078215ad.3
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745818670; x=1746423470; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FomW8SnMVtrR7bRW1Vzw9HB/lHUB2ZlILzs5antqtpM=;
 b=nONo6CUJa7KaA4kzIhzICtO16ffWowkji5bRxbbp9HBMTglvzRjDll3olBBSohCPe2
 iJlkxSmYJ2eqzqQlUU/W/IK+XQmALcokxbS8uCCqifFXuQTy/RZJ8UK15sC1oI3mDkbH
 QRVDGV6XCju+lg0o+4KW44uBycHhGZvP1aOlLTFW7qejpsHn3rQsai3vmyMAtKqdb8Mp
 Q6VM+LTJgSI53dLT0TLSmrbga9GzSp7SgVl3D9nD6DU2H9dZ12TIgO2hMsDClHvRAWfF
 bFvf0tINRfSWQEOrzG4a0nCMEqIK+RDEfhO+1RobEfncC9VVGvfByvNfw+z8QCtTYkia
 yBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745818670; x=1746423470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FomW8SnMVtrR7bRW1Vzw9HB/lHUB2ZlILzs5antqtpM=;
 b=LjtmrlTQkbE6XGfRUOZa3Ym9903F34M8yNFn0t8vgY+7Dr08SOy+qIvAIXBou6xTmx
 1rSkL5zOqQ4WD7XBrhBAVVvPmy/fFuGckoKC5TiwY84sJqFdmuNZf1qQUlVfVBN/3lT5
 nj42/OGnwmn4tX8Bae/2o+B5EnLWZaQkD4EzpuxJAhRkPZUcA0bfe6fRJn+hu7iErBNC
 1oxWBC13QkGa5DMPoM5R7DIutbLxA8+RCb2AtwVsdHlOioJEXFeK/3ZL6Xku2A7bUo/6
 i90YSbaOAjrUkNc+YhXwDh0IGaqFNicrsKwgwgRxZwEVHf8kbPgv/WJlRjJ35kE4ETjI
 VRBA==
X-Gm-Message-State: AOJu0Ywoe0sQtRDjSooplbh/ycoZayOEJRDI2q0/Tx7tqR6bx94dKCle
 1Sf9t0DZ8QLkFfesuntEx4MmSZl40oHWWvBT5czc6Lmw1zIfrgc1
X-Gm-Gg: ASbGnctz0oVAOlKnAyViHEcNneI3CSqY4gxjvkiaalnBBQ91pgsrcja2iEqyfC5fBt/
 4GSDieIi3HYlrGUkq60dP5gbpzV5YNOElV9BGpOw86T37SJW0pNzme48myj1p0Dxtr6eLAUY8qd
 /cZ814bRovsBHcLifZSWPcEKjNUfxHnAFlKdUYEKiHKYXEZju62lAC4z/2W27FLBG9DS3+uYBXW
 nCT5NaJkgXHPDcGJRS6eVW9rVcRrbQEJkWTSTYagUss/8n3LdW2AMyYbDih6YCdvvA+zplTp7pA
 5KIAcxBMF0ea1FwrJFZZiSE8m68fNaavXVF2RoJHFsZGAtlQGZ21
X-Google-Smtp-Source: AGHT+IHynJUyV9sxtO7WZXEJGkQO4c75ZfsB+otCQqxExDY5eAoXXmyfrLb4DiQ2BfXQm86eVi9MXw==
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22dc6a0f26dmr111589145ad.26.1745818670211; 
 Sun, 27 Apr 2025 22:37:50 -0700 (PDT)
Received: from ownia-Ubuntu ([217.140.96.52]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db50e75c9sm73417865ad.108.2025.04.27.22.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 22:37:49 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:37:31 +0800
From: Weizhao Ouyang <o451686892@gmail.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH] efi_loader: bootbin: do not load an initrd if none is
 provided
Message-ID: <yilxbx35sq5qpci36mr6znn7qy65nziofmcr3xnnlt2yb2um4y@noyf7mxckkbq>
References: <20250427234527.2076444-1-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427234527.2076444-1-adriano.cordova@canonical.com>
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

On Sun, Apr 27, 2025 at 07:45:26PM -0400, Adriano Cordova wrote:
> Do not try to create an initrd device path nor try to register
> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
> 
> Handle initrd installation in efi_binary_run_dp with
> efi_install_initrd, imitating what is done for the fdt.
> 
> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>

Hi Adriano,

It works well for me.

Tested-by: Weizhao Ouyang <o451686892@gmail.com>

Best Regards,
Weizhao

> ---
>  boot/bootm.c                 |  3 +++
>  include/efi_loader.h         |  2 ++
>  lib/efi_loader/efi_bootbin.c |  9 ++-------
>  lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/boot/bootm.c b/boot/bootm.c
> index f5cbb10f0d1..9693e0d336d 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1008,6 +1008,9 @@ int bootm_run_states(struct bootm_info *bmi, int states)
>  			ret = 0;
>  	}
>  
> +	/* Clear the initrd from a previous boot */
> +	images->initrd_start = 0;
> +
>  	/* Relocate the ramdisk */
>  #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
>  	if (!ret && (states & BOOTM_STATE_RAMDISK)) {
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 144b749278a..84e8cfe320e 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
>  void *efi_get_configuration_table(const efi_guid_t *guid);
>  /* Install device tree */
>  efi_status_t efi_install_fdt(void *fdt);
> +/* Install initrd */
> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
>  /* Execute loaded UEFI image */
>  efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>  /* Run loaded UEFI image with given fdt */
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index d0f7da309ce..94ba7c5589b 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -215,12 +215,11 @@ out:
>   * Return:	status code
>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> -				      void *initrd, size_t initd_sz,
> +				      void *initrd, size_t initrd_sz,
>  				      struct efi_device_path *dp_dev,
>  				      struct efi_device_path *dp_img)
>  {
>  	efi_status_t ret;
> -	struct efi_device_path *dp_initrd;
>  
>  	/* Initialize EFI drivers */
>  	ret = efi_init_obj_list();
> @@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>  	if (ret != EFI_SUCCESS)
>  		return ret;
>  
> -	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> -	if (!dp_initrd)
> -		return EFI_OUT_OF_RESOURCES;
> -
> -	ret = efi_initrd_register(dp_initrd);
> +	ret = efi_install_initrd(initrd, initrd_sz);
>  	if (ret != EFI_SUCCESS)
>  		return ret;
>  
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 3936139ca41..6a863c3556c 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
>  	return EFI_SUCCESS;
>  }
>  
> +/**
> + * efi_install_initrd() - install initrd
> + *
> + * Install the initrd located at @initrd using the EFI_LOAD_FILE2
> + * protocol.
> + *
> + * @initrd:	address of initrd or NULL if none is provided
> + * @initrd_sz:	size of initrd
> + * Return:	status code
> + */
> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
> +{
> +	efi_status_t ret;
> +	struct efi_device_path *dp_initrd;
> +
> +	if (!initrd)
> +		return EFI_SUCCESS;
> +
> +	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> +	if (!dp_initrd)
> +		return EFI_OUT_OF_RESOURCES;
> +
> +	ret = efi_initrd_register(dp_initrd);
> +	if (ret != EFI_SUCCESS)
> +		return ret;
> +
> +	return EFI_SUCCESS;
> +}
> +
>  /**
>   * do_bootefi_exec() - execute EFI binary
>   *
> -- 
> 2.48.1
> 
