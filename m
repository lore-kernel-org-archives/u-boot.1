Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBABC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C159682A53;
	Mon, 28 Apr 2025 16:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rNlBJl+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3A8982AA4; Mon, 28 Apr 2025 16:32:59 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1C582A33
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6fead317874so40084167b3.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745850776; x=1746455576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtUmAUzmWXtfxryUAcaEivdgdTqCRKKoJqVHCps+BMY=;
 b=rNlBJl+9mZmrsxfbApJqH7ibOqn6avulc9aWbouoi8rSWqgsEOyOAY5O+A4WCig/2J
 XVfHmfuIYKQc/sOwSyWXCui6Umc/QXFBTKLiIJVS2UgRUHQfxwfBXTbrkVTZUW/gdxoj
 1W6NoXa1DYb/+25NFcToIZQ8+xO80jrX43rOwiAR168Edl6fohB/QP9mCRh3zHm6oPRs
 gtYDO5iz/pGElAD3eQa/oEEqSvXcKVsFqdbVTOi1/7cQLdySZfjad7Rexkj67H09c8kd
 bY5BcwoTOTNZOOk74Jspdwm0+OzMiGKb9xODr81U+N96VKphHJKTex2NmEqYTiSyJk1a
 E5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745850776; x=1746455576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtUmAUzmWXtfxryUAcaEivdgdTqCRKKoJqVHCps+BMY=;
 b=nRDBX3tAoSpSsT064yC+/ej8Ws9cs91R11lUqA842hkw1ap/yhx/u/N03CRgZEUD1d
 60FnUoL+Jw020nK7Hl8B8dMoLqIUzSuVZehJWhYHoNeKGdQTTcK1f+ogrAsVEbQJ/ss6
 6cu4S1xJuV2zJ7OyD6xpOY/5KFyMr0rGXDHCv1OW7SZznEC0GamHMuDsDjyYHCQY/bZf
 9/ABBtTuJfoFhzVHC3k8yJoiZaW8Nqf3iktThNEsxn6Oeev2pi1uz5aTadikSisMoj5g
 XmWhhGV21nzVl9hkvJKPWluhneqUJ62+6F/PdbBRkl2N1JZvQ964oUwZgebc9TArksRO
 cNpg==
X-Gm-Message-State: AOJu0YzJRLEcrPcY4dcI6zjvy2ebcAZkBgBnhcgCwA3zfqqZIKjfwvKq
 yu+JFsADc92Go4DpSyilRMcDwOwM0J9gfENJLQTq+8p9dJcmQXpueHBNdGxzEQmKolakJaiWRAb
 lYYu0u1phTbqnmOprvU1AUlmFrOmrOA+otdb62g==
X-Gm-Gg: ASbGncsCe3EolOV9SpBlRZtoxTwJvqIuiTmBWIAnpWPqw5nyhm7wvRsCpHGv4qLIY4f
 WVtfZ3Vj7EOBGogT6QVasjkEPMqmhN+xD8hFQ8Of3d/P8l83+OhDjqCjpZ7c7i8NAMGc842nl3R
 51FhHZVbS+Zn0VQkZibdd7Xbs=
X-Google-Smtp-Source: AGHT+IERfA1xCrcwXunKuoOYtled55ooSUFN+YiZNpS3P5tXs02i076I1ckbcpZ4aBhHMBBcZjNzrBVMJd/6kIwUzK0=
X-Received: by 2002:a05:690c:6ac7:b0:705:a92d:cb7c with SMTP id
 00721157ae682-708541e4f5emr175583137b3.24.1745850775970; Mon, 28 Apr 2025
 07:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250427234527.2076444-1-adriano.cordova@canonical.com>
In-Reply-To: <20250427234527.2076444-1-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 28 Apr 2025 17:32:20 +0300
X-Gm-Features: ATxdqUEIHbbuKB5ErYMKFviAz48qo_lYp6SU7tK-H8be6ugg_ljBNtuPFb0h2iU
Message-ID: <CAC_iWjJ2-mA5URoT8A2CRBXG17zm-CCkSyiW2gN-V2nyv3Pa5g@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: bootbin: do not load an initrd if none is
 provided
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, o451686892@gmail.com, 
 Adriano Cordova <adriano.cordova@canonical.com>
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

Hi Adriano,

On Mon, 28 Apr 2025 at 02:45, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Do not try to create an initrd device path nor try to register
> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
>
> Handle initrd installation in efi_binary_run_dp with
> efi_install_initrd, imitating what is done for the fdt.
>
> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
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
>                         ret = 0;
>         }
>
> +       /* Clear the initrd from a previous boot */
> +       images->initrd_start = 0;
> +
>         /* Relocate the ramdisk */
>  #ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
>         if (!ret && (states & BOOTM_STATE_RAMDISK)) {
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
>   * Return:     status code
>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> -                                     void *initrd, size_t initd_sz,
> +                                     void *initrd, size_t initrd_sz,

This change is unrelated, please split it on a different patch

>                                       struct efi_device_path *dp_dev,
>                                       struct efi_device_path *dp_img)
>  {
>         efi_status_t ret;
> -       struct efi_device_path *dp_initrd;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> -       dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> -       if (!dp_initrd)
> -               return EFI_OUT_OF_RESOURCES;
> -
> -       ret = efi_initrd_register(dp_initrd);
> +       ret = efi_install_initrd(initrd, initrd_sz);
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 3936139ca41..6a863c3556c 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
>         return EFI_SUCCESS;
>  }
>
> +/**
> + * efi_install_initrd() - install initrd
> + *
> + * Install the initrd located at @initrd using the EFI_LOAD_FILE2
> + * protocol.
> + *
> + * @initrd:    address of initrd or NULL if none is provided
> + * @initrd_sz: size of initrd
> + * Return:     status code
> + */
> +efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
> +{
> +       efi_status_t ret;
> +       struct efi_device_path *dp_initrd;
> +
> +       if (!initrd)
> +               return EFI_SUCCESS;
> +
> +       dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> +       if (!dp_initrd)
> +               return EFI_OUT_OF_RESOURCES;
> +
> +       ret = efi_initrd_register(dp_initrd);
> +       if (ret != EFI_SUCCESS)

You have to free the device path here

> +               return ret;
> +
> +       return EFI_SUCCESS;

Get rid of this and just return ret.

> +}
> +
>  /**
>   * do_bootefi_exec() - execute EFI binary
>   *
> --
> 2.48.1
>
Thanks
/Ilias
