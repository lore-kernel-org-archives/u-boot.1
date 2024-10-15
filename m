Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F6ECFC263
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 04:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D578901C;
	Tue, 15 Oct 2024 06:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g8iOCUz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6314F88FF6; Tue, 15 Oct 2024 06:26:52 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED90389259
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e188185365so3798811a91.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728966408; x=1729571208; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hHvoyxoylQIoKFqll3zXe6j0Utq9DX40M8R3uuWrIZU=;
 b=g8iOCUz9Um76d2YR6kcK3VSKpnyPSXEKRKrWNC91kMNcU/6B7IZg9puthkhU08AM2y
 OQZ54rYhRKZhsaeOc/OcPTKbh/4ycwwnF+YU4pxpgx6O5rdPAbSdjjQxGA+SmPSfrB5/
 1uG6VoumnavyNNuBenq+7RahgXkl6mRNgclCq+/4gv2MDwdWrueH6ivUSGwhyIOqkmN1
 eEyUC2jVpVHksfat/sR3JVCeWsf08lNeSXWUjVN2ndzxJmwgZ72mqKV4MJje7lNJlDKw
 L7h5W19RuSDDO5ETDnjMddYaR2cjZlE+i3GkRut1Ui/nw1MejMWQZPkqxV2eWcRBFDdG
 8hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728966408; x=1729571208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHvoyxoylQIoKFqll3zXe6j0Utq9DX40M8R3uuWrIZU=;
 b=Fln0nIs3kb/mFFVcnR6Ccuq9dLYu2maNtvu4GJkYF1ZuOIElNbWKExCfxBnHvp/hvu
 LZtsVQl1U7IUnenXqNaqO+B305n7cCoPRSYBXX9jjyO5/C+4daxqVrGIhKctx35e6yWp
 h6DAjhx5xSlSAAvtg85h9wz88WenA8oAJkGSfMgDJH+QIR6yw1qE6Q/YNIukWpxkNhoT
 msVTwZ2gxzJu8DH3CFLduzsKjY9GmnaY9+erDK87hRjmCKQsUcXEum1CAfQmiHUzSaZs
 P6XotsImBtVrauOxYSS74YbaEEygz+OCOSWgenqggrgYV3/soKSeRCtwsxVCYA34vyve
 5sOA==
X-Gm-Message-State: AOJu0Yw0LEz3L5RNgkgtDaZa8Jul5C8bEAfjX6LxRnmrltLBWcaankWB
 oE09Hh7PSHJgRZEnEfk6dCMZloA5dTL/yiaaQqrA1S/J4PGJiAwZFjc+HJSBNFfp2XpieQA7a4B
 2XseWesJtkRDQFORic2WZYE7Aa0Cn7wVy1rgd8A==
X-Google-Smtp-Source: AGHT+IGb0pUrG1lsYq0CCiafgDD/SWa3vmCQdmugIvIFDpTMuydauuOaBYUzKxj1NoBfMip48JHwfP6wNiPpUEgBZqg=
X-Received: by 2002:a17:90a:df89:b0:2e2:bd10:599d with SMTP id
 98e67ed59e1d1-2e2f0ad2040mr17072753a91.11.1728966408337; Mon, 14 Oct 2024
 21:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-6-sjg@chromium.org>
In-Reply-To: <20241011212126.747741-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Oct 2024 07:26:12 +0300
Message-ID: <CAC_iWj+HQg0itBTF8ZmsVr4qQkWjX+RdZ2snPKvOsVA5pMhXOQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] efi: Keep early allocations to the U-Boot region
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

Hi Simon,

On Sat, 12 Oct 2024 at 00:23, Simon Glass <sjg@chromium.org> wrote:
>
> Adjust EFI_LOADER to use the provided region for early memory
> allocations, to avoid going outside the U-Boot region.
>
> Expand the available memory when efi_init_obj_list() is called.

efi_init_obj_list() is not called when an EFI app is called. It's
called when the EFI subsystem comes up.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v4:
> - Use a different technique to keep the memory-usage in place
> - Drop changes to pool allocation
> - Reorder the patches
> - Rewrite the cover letter
> - Make it a debug message for now
>
> Changes in v2:
> - Drop patch 'Show more information in efi index'
> - Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
> - Add the word 'warning', use log_warning() and show the end address
>
>  include/efi_loader.h        | 13 +++++++++++++
>  lib/efi_loader/efi_memory.c | 24 ++++++++++++++++++++++--
>  lib/efi_loader/efi_setup.c  |  5 +++++
>  3 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 08e27e61b06..aa464e9d754 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -805,6 +805,19 @@ int efi_disk_probe(void *ctx, struct event *event);
>  int efi_disk_remove(void *ctx, struct event *event);
>  /* Called by board init to initialize the EFI memory map */
>  int efi_memory_init(void);
> +
> +/**
> + * efi_memory_coop() - Allow EFI to use all available memory
> + *
> + * Up until this function is called, only a small portion of memory is available
> + * for use by the EFI memory-allocator. This function is called at the
> + * 'point of cooperation', before jumping into an EFI app, which needs to be
> + * able to make use of all the memory in the machine

As above, this is called when the EFI subsystem comes up. Not when an
application is called. For example doing a 'printenv -e' to print EFI
variables would trigger this.
The funtion call you are removing just adds all memory all memory as
EFI_CONVENTIONAL_MEMORY, which basically means free memory. I can't
understand what this patch is supposed to fix

> + *
> + * Return: efi_status_t (EFI_SUCCESS on success)
> + */
> +int efi_memory_coop(void);
> +
>  /* Adds new or overrides configuration table entry to the system table */
>  efi_status_t efi_install_configuration_table(const efi_guid_t *guid, void *table);
>  /* Sets up a loaded image */
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index 9cc33397371..2cd0b00e9eb 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -30,6 +30,9 @@ DECLARE_GLOBAL_DATA_PTR;
>   */
>  #define EFI_EARLY_REGION_SIZE  SZ_256K
>
> +/* Set when all memory has been added for use by EFI */
> +static bool efi_full_memory;
> +
>  efi_uintn_t efi_memory_map_key;
>
>  struct efi_mem_list {
> @@ -932,8 +935,25 @@ static void add_u_boot_and_runtime(void)
>
>  int efi_memory_init(void)
>  {
> -       efi_add_known_memory();
> +       efi_status_t ret;
> +
> +       /* restrict EFI to its own region until efi_memory_coop() is called */
> +       ret = efi_add_memory_map_pg((ulong)map_sysmem(gd->efi_region, 0),
> +                                   EFI_EARLY_REGION_SIZE >> EFI_PAGE_SHIFT,
> +                                   EFI_CONVENTIONAL_MEMORY, false);
> +
> +       return ret;
> +}
>
> +int efi_memory_coop(void)
> +{
> +       if (efi_full_memory)
> +               return 0;
> +       log_debug("Enabling coop memory\n");
> +
> +       efi_full_memory = true;
> +
> +       efi_add_known_memory();
>         add_u_boot_and_runtime();
>
>  #ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> @@ -943,7 +963,7 @@ int efi_memory_init(void)
>         if (efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS, EFI_BOOT_SERVICES_DATA,
>                                (64 * 1024 * 1024) >> EFI_PAGE_SHIFT,
>                                &efi_bounce_buffer_addr) != EFI_SUCCESS)
> -               return -1;
> +               return -ENOMEM;
>
>         efi_bounce_buffer = (void*)(uintptr_t)efi_bounce_buffer_addr;
>  #endif
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index a610e032d2f..40e23ca104c 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -228,6 +228,11 @@ efi_status_t efi_init_obj_list(void)
>         if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
>                 return efi_obj_list_initialized;
>
> +       /* Allow EFI to use all memory */
> +       ret = efi_memory_coop();
> +       if (ret != EFI_SUCCESS)
> +               goto out;
> +
>         /* Set up console modes */
>         efi_setup_console_size();
>
> --
> 2.34.1
>

Thanks
/Ilias
