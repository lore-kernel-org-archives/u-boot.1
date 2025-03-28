Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2C9C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 307B681951;
	Fri, 28 Mar 2025 13:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zLJfJEmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 448A381D6C; Fri, 28 Mar 2025 13:42:40 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54ED8129B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e6405b5cd9bso1679925276.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165757; x=1743770557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qFLubCTsDjLBAgNOQV61uRsm/1vOD3u4fnjh+YVFwP8=;
 b=zLJfJEmYTAT1VZ8Yv1gmWI71GB+heOp5mpi1XtQNEcfarq5W1k65IqYJ3/07nRMS8E
 YLiXljr2Ne+DwNmPiXFHF0nvSpiv2SMJinGnxDoNzqAJeByweQkC04xiLC0djMaHD8Ko
 DZbNENGvCcwFKJ6DQKb+kajO8sUuhkJALtkB3l2+Z7slpxRIHn8EXIUqbxFvQTtD8Fdu
 0ZRNzzR+c/vrw106UqzStfaKlXXBUBk8iLOUmtnOluy82WlBUPonS+UnlKmYRvF3n3sL
 l3akUVvQhZleUw72bUlB60DTS26ZSML+Yq7BpuN+6syZ4UcqTH3hu6A9k/5xnB+MzTva
 imQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165757; x=1743770557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qFLubCTsDjLBAgNOQV61uRsm/1vOD3u4fnjh+YVFwP8=;
 b=C7BQZi4014gaaKwrvdJqtB/IB5VoNBnYtZBHKfzPN4KeuYsNIrjLbkDehPpx3so+nx
 62Uime8HzfFXT/gR8pDzl/hOwR8W5xWJp2sl+5dAzKYp6XN+7jEldrj1syCoqpYe3Avu
 hhR63vwRN1cnUESbzu/yTml0Jy+KaZa7CGXA50sxd3MApJamLe0z+EvP2cKek3x9P2kH
 Fj3h4yJyPbgAtSJu7tcju/fn9KOANddXLN+wqnTTHJOpLlVQQLibp/Q6VVtOYkBoWcX1
 ahzaJOlz8lDt7YJoS+lQZdTbs+rsFSLNduaO4lxLKJjydij2D+ldew7/cYUPyKeYlJL/
 2tig==
X-Gm-Message-State: AOJu0YwIHG9kc2IVwA4hpkbZUDKtrSyIiZggCTEmKL3C9wqmheJbQiHr
 +6X7WLfuBsRGaU7iSP5IehXyk/XhdKIWMpArtY705T8MxrFTQJ5H6itu6wldrdiSZvIucb1oHYr
 /j70osJmtD6LadgTQCLGp+QAjxkdsmtboS5jQGQ==
X-Gm-Gg: ASbGnctjTrd53RaoaByBRis81dO9Gv62FCeMydf3oarSLNZdhoCVnTunix1MV4vMynd
 dDr+auIVMbUC49qvO9+wrZ4kUr0quoMlHSL8U7mYt/c7AK2FXzl9YrhbdyMkQ8alg/skNNMWUKx
 CGXVXe1C91pfHV4EY0kFYvSbmA
X-Google-Smtp-Source: AGHT+IEP5JEWBlHMLAazYA2xcEAgexF+c0h2sqIce3NuS+Pd0DWn0iTmW+d+h1clM8bfq+mj3g9EDGRM652y36/Mx/E=
X-Received: by 2002:a05:6902:1085:b0:e60:8b26:8c34 with SMTP id
 3f1490d57ef6-e6b737331a5mr3376433276.22.1743165756545; Fri, 28 Mar 2025
 05:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250319144501.32277-1-adriano.cordova@canonical.com>
 <20250319144501.32277-3-adriano.cordova@canonical.com>
In-Reply-To: <20250319144501.32277-3-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:42:00 +0200
X-Gm-Features: AQ5f1JrgsmEWiTgG9MCTeCYBJygOgbYaVg0qLvx3R9F0OZBtCslirQab7QjeC_A
Message-ID: <CAC_iWj+CJ_3cYWPboH6oQKUAcDVca0UE7jKKu3Kjyf+S07wtLg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi_loader: binary_run: register an initrd
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
> Add support to install an initrd when running an EFI binary
> with efi_binary_run
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>
> Changes in v2:
> - Change EFI_RESERVED_MEMORY_TYPE for EFI_LOADER_DATA for dp_initrd
>
>  boot/bootm_os.c              |  3 ++-
>  cmd/bootefi.c                |  2 +-
>  include/efi_loader.h         |  2 +-
>  lib/efi_loader/efi_bootbin.c | 20 +++++++++++++++++---
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index e9522cd3299..f403f352be1 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -507,7 +507,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>
>         ret = efi_binary_run(image_buf, images->os.image_len,
>                              images->ft_len
> -                            ? images->ft_addr : EFI_FDT_USE_INTERNAL);
> +                            ? images->ft_addr : EFI_FDT_USE_INTERNAL,
> +                                NULL, 0);
>
>         return ret;
>  }
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index c1454ffb948..dce8285b047 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -211,7 +211,7 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int flag, int argc,
>                 }
>         }
>
> -       ret = efi_binary_run(image_buf, size, fdt);
> +       ret = efi_binary_run(image_buf, size, fdt, NULL, 0);
>
>         if (ret != EFI_SUCCESS)
>                 return CMD_RET_FAILURE;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index cc732dc4807..ad60805ae4f 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -600,7 +600,7 @@ efi_status_t efi_install_fdt(void *fdt);
>  /* Execute loaded UEFI image */
>  efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
>  /* Run loaded UEFI image with given fdt */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt);
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz);
>
>  /**
>   * efi_bootflow_run() - Run a bootflow containing an EFI application
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index deafb2ce1c2..2cf972343a4 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -204,6 +204,8 @@ out:
>   * @image:     memory address of the UEFI image
>   * @size:      size of the UEFI image
>   * @fdt:       device-tree
> + * @initrd:    initrd
> + * @initrd_sz: initrd size
>   * @dp_dev:    EFI device-path
>   * @dp_img:    EFI image-path
>   *
> @@ -213,10 +215,12 @@ out:
>   * Return:     status code
>   */
>  static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
> +                                     void *initrd, size_t initd_sz,
>                                       struct efi_device_path *dp_dev,
>                                       struct efi_device_path *dp_img)
>  {
>         efi_status_t ret;
> +       struct efi_device_path *dp_initrd;
>
>         /* Initialize EFI drivers */
>         ret = efi_init_obj_list();
> @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>         if (ret != EFI_SUCCESS)
>                 return ret;
>
> +       dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
> +       if (!dp_initrd)
> +               return EFI_OUT_OF_RESOURCES;
> +
> +       ret = efi_initrd_register(dp_initrd);
> +       if (ret != EFI_SUCCESS)
> +               return ret;
> +
>         return efi_run_image(image, size, dp_dev, dp_img);
>  }
>
> @@ -239,13 +251,15 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
>   * @image:     memory address of the UEFI image
>   * @size:      size of the UEFI image
>   * @fdt:       device-tree
> + * @initrd:    initrd
> + * @initrd_sz: initrd size
>   *
>   * Execute an EFI binary image loaded at @image.
>   * @size may be zero if the binary is loaded with U-Boot load command.
>   *
>   * Return:     status code
>   */
> -efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
> +efi_status_t efi_binary_run(void *image, size_t size, void *fdt, void *initrd, size_t initrd_sz)
>  {
>         efi_handle_t mem_handle = NULL;
>         struct efi_device_path *file_path = NULL;
> @@ -273,7 +287,7 @@ efi_status_t efi_binary_run(void *image, size_t size, void *fdt)
>                 log_debug("Loaded from disk\n");
>         }
>
> -       ret = efi_binary_run_dp(image, size, fdt, bootefi_device_path,
> +       ret = efi_binary_run_dp(image, size, fdt, initrd, initrd_sz, bootefi_device_path,
>                                 bootefi_image_path);
>  out:
>         if (mem_handle) {
> @@ -355,7 +369,7 @@ efi_status_t efi_bootflow_run(struct bootflow *bflow)
>                 log_debug("Booting with external fdt\n");
>                 fdt = map_sysmem(bflow->fdt_addr, 0);
>         }
> -       ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, device, image);
> +       ret = efi_binary_run_dp(bflow->buf, bflow->size, fdt, NULL, 0, device, image);
>
>         return ret;
>  }
> --
> 2.48.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
