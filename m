Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C44C71155
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D6B80C93;
	Mon, 16 Jun 2025 15:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XszhLihy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F402281760; Mon, 16 Jun 2025 15:05:41 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60768070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e5d953c0bso45295377b3.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750079138; x=1750683938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=38sER9srgBiSeF9K81wSOXOOORbi7MxlALoNtPBA7Dc=;
 b=XszhLihyXKq4A/WANnJGZD5trCr+O/g24SZqoBC8e8hPkRekSxoVBCDF6LefGXWXrV
 VBV1+poR9pzhEwt/qUtzNm1RDhjm2Z75jw9MnxrOMq9y+PKh4z6rD0z9fah546PCyVZM
 Cv8yy6WnV5B/6qTq32czEHYtVugNA4ApZ336MURQkBHiNrOBxvqtHatsAeImvwAcfY1k
 lk0bxh4hL5hPWRALSAG4zo/6qepppVUSXHPKT+Js109iNGAEapL1fxfHir3HqKnEcLSG
 TJroAVbu61/zMaFQ+LBZ4jd/n13R4FmhwipiGDXG0c9dupuP0UTjwtyRcNgqaI/gvx5r
 CnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750079138; x=1750683938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38sER9srgBiSeF9K81wSOXOOORbi7MxlALoNtPBA7Dc=;
 b=LLHtpTQT39+qdLLMLiI2c7mNnIlJamo7XH+ajaN24PRWBV3qVBp76B1lMkRWGAZ8LP
 iDS8IJieWFEtzVnqqvUDQc9uIpZqcNbWWpfVFJQxsxR2D3XCZB/2IRdtkNLV/xGmgn7v
 FflpdUxfcpQTOEXjlvwBp7P3ZHOr6aFyzsBdik1l2jfmY6OdBQcYmcDZXxDMhio4vlKG
 7AatnyMZdAhGSnMAk4yyArna/UnU1onEDNs2z4KPURI2ERwnv+WYa71nklD7mJiWtajJ
 fB5iDA+Jx9WKqvT2bgKoBhdDJk/ILDFFGKaMoBL6PvjyMD6NacPWNuZ3KiAuT21h69N2
 Qw3Q==
X-Gm-Message-State: AOJu0YxVTLPNlH8EB0ZQSGpiS7ZgQQfOnklERtA6+rRVYOU2hT+RDbW5
 2gAE7BcqBrioDPA+YQbi09HDk10v01r4h+3nSBMdh48mXwbz6UyJvf0YHMTwzzmQTGtyLIuhIxD
 W0wMb+WH++zEI2Emua29E39f3tiOqenCbPS7F6TBeEg==
X-Gm-Gg: ASbGncu9a4X4O7DGPi7Cq8jygK+8YRQEOOQQ+owyWAjJEoSzDvLyiHz7U7r1PodpvUg
 f38FyAzHKpMTetPXRAscfdfJT1+1EJhBju4Ou5sqFxk/pLHLNisHoNy6NQmMsC2S+1TBk0e++T2
 6ZwAXsjUDqX2GvrBdoU8qc8ooMr2QMr0cipxFySzRdNUva
X-Google-Smtp-Source: AGHT+IHEJO4BmKFCH2Hg6pzfxs2uHZBLc9voFzMR2VnoKaXiOSX51B059O8fg5ebSlyg5jBBzljUW6V4gcNPXtUYktg=
X-Received: by 2002:a05:690c:998d:b0:70c:8f0c:f923 with SMTP id
 00721157ae682-711754df9b9mr133055167b3.18.1750079138251; Mon, 16 Jun 2025
 06:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-3-paulliu@debian.org>
In-Reply-To: <20250611050844.210384-3-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:05:01 +0300
X-Gm-Features: AX0GCFul9hNFxcQxyK4QMHwU3SDQze1A6mdv2NoJ3S4azL6DGVXKF_eK8xlmx6o
Message-ID: <CAC_iWjL=08+FsGL1MYy6cmZ_W4iDfobsbaCufK=XOapopU1dyA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>
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

On Wed, 11 Jun 2025 at 08:08, Ying-Chun Liu (PaulLiu)
<paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.
>
> This feature is described in UEFI Spec version 2.10. Section 18.4.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover and interact
> with system-level debug resources.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> V3: Fix the way of installation of configuration table.
> V5: move the code into a separate module.
> ---
>  include/efi_api.h                  | 53 ++++++++++++++++++++++++++++++
>  include/efi_loader.h               |  2 ++
>  lib/efi_loader/efi_debug_support.c |  6 ++++
>  lib/efi_loader/efi_setup.c         | 12 +++++++
>  4 files changed, 73 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 6c4c1a0cc7b..8da0a350ce3 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -238,6 +238,10 @@ enum efi_reset_type {
>         EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
>                  0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
>
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
> +       EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
> +                0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> +
>  struct efi_conformance_profiles_table {
>         u16 version;
>         u16 number_of_profiles;
> @@ -574,6 +578,55 @@ struct efi_loaded_image {
>         efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
>  };
>
> +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> +
> +/**
> + * struct efi_debug_image_info_normal - Store Debug Information for normal
> + * image.
> + * @image_info_type: the type of image info.
> + * @loaded_image_protocol_instance: the pointer to struct efi_loaded_image.
> + * @image_handle: the EFI handle of the image.
> + *
> + * This struct is created by efi_load_image() and store the information
> + * for debugging an normal image.
> + */
> +struct efi_debug_image_info_normal {
> +       u32 image_info_type;
> +       struct efi_loaded_image *loaded_image_protocol_instance;
> +       efi_handle_t image_handle;
> +};
> +
> +/**
> + * union efi_debug_image_info - The union to store a pointer for EFI
> + * DEBUG IMAGE INFO.
> + * @image_info_type: the type of the image_info if it is not a normal image.
> + * @normal_image: The pointer to a normal image.
> + *
> + * This union is for a pointer that can point to the struct of normal_image.
> + * Or it points to an image_info_type.
> + */
> +union efi_debug_image_info {
> +       u32 *image_info_type;
> +       struct efi_debug_image_info_normal *normal_image;
> +};
> +
> +/**
> + * struct efi_debug_image_info_table_header - store the array of
> + * struct efi_debug_image_info.
> + * @update_status: Status to notify this struct is ready to use or not.
> + * @table_size: The number of elements of efi_debug_image_info_table.
> + * @efi_debug_image_info_table: The array of efi_debug_image_info.
> + *
> + * This struct stores the array of efi_debug_image_info. The
> + * number of elements is table_size.
> + */
> +struct efi_debug_image_info_table_header {
> +       volatile u32 update_status;
> +       u32 table_size;
> +       union efi_debug_image_info *efi_debug_image_info_table;
> +};
> +
>  #define EFI_DEVICE_PATH_PROTOCOL_GUID \
>         EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
>                  0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 8f065244d8e..d0c72d0bc58 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -315,6 +315,8 @@ extern const struct efi_hii_config_routing_protocol efi_hii_config_routing;
>  extern const struct efi_hii_config_access_protocol efi_hii_config_access;
>  extern const struct efi_hii_database_protocol efi_hii_database;
>  extern const struct efi_hii_string_protocol efi_hii_string;
> +/* structure for EFI_DEBUG_SUPPORT_PROTOCOL */
> +extern struct efi_debug_image_info_table_header efi_m_debug_info_table_header;
>
>  uint16_t *efi_dp_str(struct efi_device_path *dp);
>
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
> index a0f7506779d..a6a672bc0e4 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -10,6 +10,12 @@
>
>  struct efi_system_table_pointer __efi_runtime_data * systab_pointer = NULL;
>
> +struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
> +       0,
> +       0,
> +       NULL
> +};
> +
>  /**
>   * efi_initialize_system_table_pointer() - Initialize system table pointer
>   *
> diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> index 6193b9f6d0c..60f3a7e5fbf 100644
> --- a/lib/efi_loader/efi_setup.c
> +++ b/lib/efi_loader/efi_setup.c
> @@ -18,6 +18,9 @@
>
>  efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
>
> +const efi_guid_t efi_debug_image_info_table_guid =
> +       EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> +
>  /*
>   * Allow unaligned memory access.
>   *
> @@ -280,10 +283,19 @@ efi_status_t efi_init_obj_list(void)
>
>         /* Initialize system table pointer */
>         if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +               efi_guid_t debug_image_info_table_guid =
> +                       efi_debug_image_info_table_guid;
> +
>                 ret = efi_initialize_system_table_pointer();
>                 if (ret != EFI_SUCCESS) {
>                         goto out;
>                 }
> +
> +               ret = efi_install_configuration_table(&debug_image_info_table_guid,
> +                                                     &efi_m_debug_info_table_header);
> +               if (ret != EFI_SUCCESS) {
> +                       goto out;
> +               }
>         }
>
>         if (IS_ENABLED(CONFIG_EFI_ECPT)) {
> --
> 2.39.5
>
