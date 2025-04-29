Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860E2C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 06:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E340080BAD;
	Tue, 29 Apr 2025 08:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qIjlpHmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF79780EFB; Tue, 29 Apr 2025 08:25:35 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654D08091A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 08:25:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6ff37565154so48172877b3.3
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745907932; x=1746512732; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UuWkCD2LWXL2rLDvSGhUTs0pn9tsaD8V43uUtNF16Jk=;
 b=qIjlpHmoGUuNdRZcShKPCyds2I27zGuboF9uKtB5T4XjYA9eX04i5QTKLRHIva2/pD
 Sinws8YSqXUfCuYBdxmCyf4yooU4R+KgYkrXTtzCvCzv7g/QF9wto5+bDziLwBc4pKNG
 mrbsRYxMp4EPg3DOM2Lelgxdd6CYr3GlMue5rHdYM6+9paQ5RC70hDpseFIndc8S8qV7
 omlfXudBnyLCJaYgUKUc7Vyse6juqA4pIZNkadGwMwvXurVMZGnkP8u/Hk8FYIvvCGap
 IR7UTqVf9BjN+lmdb3xwpm4NvdJHQI/jbGvXPG6tqN2LJs63pX2i1ZqB6j0PN2kySJ1O
 PpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745907932; x=1746512732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UuWkCD2LWXL2rLDvSGhUTs0pn9tsaD8V43uUtNF16Jk=;
 b=VoCuDHRjdD6WqC5vR6p4hrBg3aoPV/JGzqfFP1ZOP/mVE6gdWr+dy2gfcFMTy3xrQt
 NPipnCFSgk0CJO9/O2QMoSV9cSUA9jGOXqMRpip52ZS59M2AYGvGECLPeWDoBFPLlSEV
 7DuM/o+7+/8DNP7BSdj8X4uar1C3P1NOTO9kvN6izq66MUdwpCmqL6vaOWxsAHYjob/f
 BcHomS2YW+dbZCMu7OPrOTF5GwO3KWHJ3vwV77+4GIZK/CXJZIl91j8oDQza+yIXsVKF
 7IjHC/hz7ZKVM0kvWrDHP78f3EJIIqxY5wRin0HI751vDKVXTOncUE16iRYOjhkPOoAZ
 WaMg==
X-Gm-Message-State: AOJu0YxAwsNqXNI0152j8FxXn5j8IOfgf/SCuttW5x9QxqdHb7sWg0C0
 EF3WfUrjA10Wnn9g/WjAy8eA/7vM9PgD/EdXqrW4eOo1GTehqryO4+1N8wCl39w8F8w9jziNi2u
 JToBks+o6bpOq1xEjepUef/H45pOeFd3r7rDFOA==
X-Gm-Gg: ASbGncstV1KIcC4tvPSnxX3Ia89LVuMHDa0470iUW7QubFOs+4536k7cH/U+ymlYGRj
 +z284xDVWwryehxNyPxgka7OXIGdax8cdqxzcxtnMt7kvuCJ0uXFbpdbvB/o+5uJrbLtOQjIkEG
 EaDOutszk/C5bxS4UeAl2rE6c=
X-Google-Smtp-Source: AGHT+IG6KmAwnebn98ZbZkgKwIH6xA6j/rFdSMYJEUXCU5c14T/WyjSktrWr4u+Ya+girR32yOh0XvlKflgKXD1ZQRc=
X-Received: by 2002:a05:690c:6c84:b0:6fb:5498:70fa with SMTP id
 00721157ae682-7089b2093d4mr24964727b3.18.1745907932106; Mon, 28 Apr 2025
 23:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250428145341.2091400-1-adriano.cordova@canonical.com>
 <20250428145341.2091400-2-adriano.cordova@canonical.com>
In-Reply-To: <20250428145341.2091400-2-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 29 Apr 2025 09:24:56 +0300
X-Gm-Features: ATxdqUGQbab-2BmCZEnTHPaIy7dMOdTWdk8_bIFeBXM8jgvJKWCNBOMH_grsCts
Message-ID: <CAC_iWjKvcVOTx+1GiGwzfNGsciAa+jeAtvkLteaV01GWNAzWkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
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

On Mon, 28 Apr 2025 at 17:53, Adriano Cordova <adrianox@gmail.com> wrote:
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
>  lib/efi_loader/efi_bootbin.c |  7 +------
>  lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
>  4 files changed, 35 insertions(+), 6 deletions(-)
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
> index d0f7da309ce..6a189c31ffa 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
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
> +       ret = efi_install_initrd(initrd, initd_sz);
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 3936139ca41..19fb5d03fec 100644
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
> +               efi_free_pool(dp_initrd);
> +
> +       return ret;
> +}
> +
>  /**
>   * do_bootefi_exec() - execute EFI binary
>   *
> --
> 2.48.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
