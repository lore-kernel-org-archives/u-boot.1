Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E46FD0C5FB
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96E1088FC5;
	Fri, 25 Oct 2024 13:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJhWrrL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7EBE88FC8; Fri, 25 Oct 2024 13:17:53 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F02B88BEF
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7db238d07b3so1293437a12.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729855066; x=1730459866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uKbLOk3sO9/pvgHfQm91fEu1mcHunEyBW5i7gdXI5Zs=;
 b=eJhWrrL+YdbV+Q/PTnb390gtWqwkc8Wu376MtLvL5VWqZvK2m8HFhQlavvlUQvgh79
 8I2qWcOsHbAbZL1NXx4YmpVZGI1wnGJdai/6IPRoMZUMJ0YaBspLG7aFmMTl4CWTq+ML
 MMvRpoPWgY530SVTDc2PSqJIIk11/ryMMUQi0eI+Vcpuyv4M+iHVnZccTK56HLiP5Jfi
 8L6ZslH6d/E/MRRpQh0Hy64s/xS0eDP3EKIGdd57qqDh0cWlDKLEkJNfP1Cg7LLh2VYw
 +N+iNendDUX6QAj90UumJVALISV3yRUZxDxAYy54ocTIkoICeMzleoxoDg57aVvSENox
 QdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729855066; x=1730459866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uKbLOk3sO9/pvgHfQm91fEu1mcHunEyBW5i7gdXI5Zs=;
 b=rRWH4ZK1W4qryJxFuHHUWRi7Ysb8f3xujCiquokEQ50eUlZd8FQxBASO5YAT1pRY0s
 eFLrpsOr9IKpqMxKUcg2N4+uOTDcHP4ni0013ZZv6x71e/K3N06tVZNPDTc5N+guGUCz
 JOj/CSv92xremsd+Iksom1TiQnioMlEsAy5Vk9+Tg85k0eZfg6WsAT6fN8ZLTKva4Zzg
 0p1d5OGeRZCH/OJIMcnIqrOqrQamushVj+CE+CeMv7nVAcqtI+xLfDb83MII3ApRclo4
 WZyPQaJJxoxdaWtES+a3fNkHpzqI1D9dd3O0DuL0YBMAj2YcPsLNUKwRf7J+vc7r1eRc
 P77Q==
X-Gm-Message-State: AOJu0Yy7PhbSFwIHVWoYgNZ7a2W+04YpSimomac46/ZERb/ulqhBFfwl
 A4N8TQfW3Tz9JLLJstb1P4ea6XejOagL7L8wF+tGvLDpvhpJJrKA+XWGoaKgOQov3JCd8h4pP2h
 HN2xba1xHO9+An/5/vdhIO6G9yAJl5v4pXg00BQ==
X-Google-Smtp-Source: AGHT+IETp6oyvUXMlkxQg4GQr2GPkSWP0XDdl5iyxi7o6/0ZiGCP5qgEyOaya+1vCbGht3NmlnUH6MRg5+L2XWk3TR8=
X-Received: by 2002:a05:6300:4043:b0:1d7:ca7:bfce with SMTP id
 adf61e73a8af0-1d989d1dc1cmr7253303637.42.1729855066574; Fri, 25 Oct 2024
 04:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-5-sughosh.ganu@linaro.org>
In-Reply-To: <20241025111411.165904-5-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 25 Oct 2024 14:17:10 +0300
Message-ID: <CAC_iWj+imj1w_VvgQNPDbuN=7oi+vBpLOfg_PJjct+v6BqcMmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] efi: add helper functions to insert pmem node for DT
 fixup
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>
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

+CC Anton

On Fri, 25 Oct 2024 at 14:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The EFI HTTP boot puts the iso installer image at some location in
> memory which needs to be reserved in the devicetree as persistent
> memory (pmem). Add helper functions which add this pmem node when the
> EFI_DT_FIXUP protocol's fixup callback is invoked.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  boot/image-fdt.c             |  9 +++++++++
>  include/efi_loader.h         | 17 +++++++++++++++++
>  lib/efi_loader/efi_bootmgr.c | 21 +++++++++++++++++++++
>  lib/efi_loader/efi_helper.c  | 12 ++++++++++++
>  4 files changed, 59 insertions(+)
>
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 8eda521693..b39e81ad30 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -11,6 +11,7 @@
>  #include <command.h>
>  #include <fdt_support.h>
>  #include <fdtdec.h>
> +#include <efi_loader.h>
>  #include <env.h>
>  #include <errno.h>
>  #include <image.h>
> @@ -648,6 +649,14 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob, bool lmb)
>         if (!ft_verify_fdt(blob))
>                 goto err;
>
> +       if (CONFIG_IS_ENABLED(EFI_HTTP_BOOT)) {
> +               fdt_ret = fdt_efi_pmem_setup(blob);
> +               if (fdt_ret) {
> +                       printf("ERROR: HTTP boot pmem fixup failed\n");
> +                       goto err;
> +               }
> +       }
> +
>         /* after here we are using a livetree */
>         if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
>                 struct event_ft_fixup fixup;
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index d450e304c6..031de18746 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -748,6 +748,15 @@ bool efi_varname_is_load_option(u16 *var_name16, int *index);
>  efi_status_t efi_next_variable_name(efi_uintn_t *size, u16 **buf,
>                                     efi_guid_t *guid);
>
> +/**
> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> + *
> + * @fdt:       Pointer to the devicetree
> + *
> + * Return:     0 on success, negative on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt);
> +
>  /**
>   * efi_size_in_pages() - convert size in bytes to size in pages
>   *
> @@ -964,6 +973,14 @@ efi_status_t efi_set_load_options(efi_handle_t handle,
>                                   void *load_options);
>  efi_status_t efi_bootmgr_load(efi_handle_t *handle, void **load_options);
>
> +/**
> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> + *
> + * @fdt:       Pointer to the DT blob
> + * Return:     status code
> + */
> +efi_status_t efi_bootmgr_pmem_setup(void *fdt);
> +
>  /**
>   * struct efi_image_regions - A list of memory regions
>   *
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index 16f75555f6..1d9246be61 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -41,6 +41,8 @@ struct uridp_context {
>         efi_handle_t mem_handle;
>  };
>
> +static struct uridp_context *uctx;
> +
>  const efi_guid_t efi_guid_bootmenu_auto_generated =
>                 EFICONFIG_AUTO_GENERATED_ENTRY_GUID;
>
> @@ -423,6 +425,7 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
>
>         efi_free_pool(ctx->loaded_dp);
>         free(ctx);
> +       uctx = NULL;
>
>         return ret == EFI_SUCCESS ? ret2 : ret;
>  }
> @@ -443,6 +446,23 @@ static void EFIAPI efi_bootmgr_http_return(struct efi_event *event,
>         EFI_EXIT(ret);
>  }
>
> +/**
> + * efi_bootmgr_pmem_setup() - Put a pmem node for UEFI HTTP installers
> + *
> + * @fdt:       Pointer to the DT blob
> + * Return:     status code
> + */
> +efi_status_t efi_bootmgr_pmem_setup(void *fdt)
> +{
> +       if (!uctx) {
> +               log_warning("No EFI HTTP boot context found\n");
> +               return EFI_SUCCESS;
> +       }
> +
> +       return !fdt_fixup_pmem_region(fdt, uctx->image_addr, uctx->image_size) ?
> +               EFI_SUCCESS : EFI_INVALID_PARAMETER;
> +}
> +
>  /**
>   * try_load_from_uri_path() - Handle the URI device path
>   *
> @@ -472,6 +492,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>         if (!ctx)
>                 return EFI_OUT_OF_RESOURCES;
>
> +       uctx = ctx;
>         s = env_get("loadaddr");
>         if (!s) {
>                 log_err("Error: loadaddr is not set\n");
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 00167bd2a1..33cd8b9a50 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -242,6 +242,18 @@ int efi_unlink_dev(efi_handle_t handle)
>         return 0;
>  }
>
> +/**
> + * fdt_efi_pmem_setup() - Setup the pmem node in the devicetree
> + *
> + * @fdt:       Pointer to the devicetree
> + *
> + * Return:     0 on success, negative on failure
> + */
> +int fdt_efi_pmem_setup(void *fdt)
> +{
> +       return efi_bootmgr_pmem_setup(fdt) == EFI_SUCCESS ? 0 : -1;
> +}
> +
>  static int u16_tohex(u16 c)
>  {
>         if (c >= '0' && c <= '9')
> --
> 2.34.1
>
