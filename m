Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52117C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 08:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB52F8206E;
	Thu,  3 Jul 2025 10:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FgNFTNQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8CE80194; Thu,  3 Jul 2025 10:53:10 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6238C80194
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 10:53:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e40e3f316so47257127b3.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751532787; x=1752137587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3eNoX+1On01Bc4xUoGthT/AOoU7UPogyOV7/XZk6vjA=;
 b=FgNFTNQ4WgF/AOQ2dKKcamk93MtMgPk/j/Uh/Ldx/65UOYxapCihNfbMfGr19F1c+3
 7TR93sV9O2n/yWWCcKTfeme8lY12pe0Z1GTTNudcUBSYuGEIyFd1YV0oVNm8oJAD0f/q
 JCdHhuzpjrWCS9/s0x2QXxe9HjuTr+Y8eJNV9jrf5x1raVEhVyInhhEXX9WbfN4q6C+X
 yrrIXX9BnuWMHP2FqCZ7SInypcp2+6Irl8r97MSExvhu6RMXdyC6I5BPOWme4JYjp7Nw
 Ir6lsUftDwbSEO7sqbkTJbyK1D0eXub1z75PYH1978HMfVBaDKovLFNG78nZ7qGkihHP
 UxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532787; x=1752137587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3eNoX+1On01Bc4xUoGthT/AOoU7UPogyOV7/XZk6vjA=;
 b=TI6YCZioVs/SmjbBfi52IoWQwI1YpUoI6mjB8H4a5TeyrR//3QPKUbcRjnCzINXAM/
 fD+9IsmFQxf5UOenKFGd1jz+sepzRcUdqIN3tN3qXIqq2c9T4n11gNDPHrNrouxmMYuP
 sh3XWRQ/OAbX9l7mKX0TsjoeWTDE9fvP++y0kPLFKzL/H96AkfEEdyQqpbjAhgJO+J7B
 KLaIiqtEclIj5NQhxlz7benRHi0o6/WgDb6tZvmOy/+mm/zxML4xrN1GRfV+3ro8cxZe
 Womsoj05z+tgFXWHJJlEPo6SjQLmlxRULQag6NuA3IkIxhBerS4IG+y4u2ZDi7wjvsGO
 ElUw==
X-Gm-Message-State: AOJu0YxYQ+GkhA2K2umAbElA1u+O9bvy4A8OW4rrKwaipigM3alS9QlC
 Sk67L6+5sRIE28xD50661qX2q/kjFYyJJnu2EGlKNFbozcMLpf1VENta6/6XVT/a25ZQ57yNQcB
 aJBM6xzRM3XktX+QgZh+qDpPqr+reI1wDncXHbjmlgA==
X-Gm-Gg: ASbGnct/oMYuSr6lBds4FuyCqyfk5Fz8M4nVdZ+1yroausDQuIQ5q24FaKdaBrrF8bK
 ehy0psjkKGqygzyTs+yxUcpMwtw9ldcEOw7XWfpU2OU0wmMm8H1yz1kUkpfnLdnflqeoCF+N0v/
 muvob1TJh+u+KQWvh5LPnfQu/p/d3dVQkh1pasFPh9XExt
X-Google-Smtp-Source: AGHT+IEizmrUYK2gp0kIy80oLQVlYXfGiwP7nlMHKHR1hAoZtB25g1Lj6045U2sqgLTyVIfkanmi/BzArToXGy3GAJ8=
X-Received: by 2002:a05:690c:6186:b0:711:371e:ecbe with SMTP id
 00721157ae682-7164d46af4dmr88502927b3.29.1751532787196; Thu, 03 Jul 2025
 01:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250703062811.72871-1-paulliu@debian.org>
 <20250703062811.72871-5-paulliu@debian.org>
In-Reply-To: <20250703062811.72871-5-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Jul 2025 11:52:31 +0300
X-Gm-Features: Ac12FXz7n_bYYgs-LFsU6VrUtfsKKAYARXKNnzMi8XPkdi7JG7hkEfF-0NgMXis
Message-ID: <CAC_iWj+RbE0fHzoCP7nfm40Tnr0YCYk2ESQcdg2E2+8pEK8d2Q@mail.gmail.com>
Subject: Re: [PATCH v8 4/5] efi: add EFI_DEBUG_IMAGE_INFO for debug
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

On Thu, 3 Jul 2025 at 09:28, Ying-Chun Liu (PaulLiu) <paulliu@debian.org> wrote:
>
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
>
> This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
> while loading the image.
>
> This feature is described in UEFI Spec 2.10. Section 18.4.3.
> The implementation ensures support for hardware-assisted debugging and
> provides a standardized mechanism for debuggers to discover the load
> address of an EFI application.
>
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> V2: use Kconfig options to turn on/off this feature.
> V3: Use efi_realloc to realloc the tables. Move tables to boot time.
> V4: Use new efi_realloc().
> V5: Fix function comments and move the code into a separate module.
> V6: refine the code. Handling the error of efi_allocate_pool.
> V7: Use memmove instead of memcpy. Fix syntax warnings.
> ---
>  include/efi_api.h                  |   2 +
>  include/efi_loader.h               |   5 ++
>  lib/efi_loader/efi_boottime.c      |   7 ++
>  lib/efi_loader/efi_debug_support.c | 137 +++++++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 8da0a350ce3..77a05f752e5 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -581,6 +581,8 @@ struct efi_loaded_image {
>  #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
>  #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
>
> +#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
> +
>  /**
>   * struct efi_debug_image_info_normal - Store Debug Information for normal
>   * image.
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 13ca2ec9a4e..22440b842e3 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -650,6 +650,11 @@ efi_status_t efi_root_node_register(void);
>  efi_status_t efi_initialize_system_table(void);
>  /* Called by bootefi to initialize debug */
>  efi_status_t efi_initialize_system_table_pointer(void);
> +/* Called by efi_load_image for register debug info */
> +efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
> +                                                struct efi_loaded_image *loaded_image,
> +                                                efi_handle_t image_handle);
> +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
>  /* efi_runtime_detach() - detach unimplemented runtime functions */
>  void efi_runtime_detach(void);
>  /* efi_convert_pointer() - convert pointer to virtual address */
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
> index dbebb37dc04..8c83040ac48 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -2129,6 +2129,11 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
>                 *image_handle = NULL;
>                 free(info);
>         }
> +
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT) && *image_handle)
> +               efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> +                                                   info,
> +                                                   *image_handle);
>  error:
>         return EFI_EXIT(ret);
>  }
> @@ -3359,6 +3364,8 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
>                 ret = EFI_INVALID_PARAMETER;
>                 goto out;
>         }
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT))
> +               efi_core_remove_debug_image_info_entry(image_handle);
>         switch (efiobj->type) {
>         case EFI_OBJECT_TYPE_STARTED_IMAGE:
>                 /* Call the unload function */
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
> index 5401488602e..17f506a70e7 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -17,6 +17,13 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
>         NULL
>  };
>
> +/* efi_m_max_table_entries is the maximum entries allocated for
> + * the efi_m_debug_info_table_header.efi_debug_image_info_table.
> + */
> +static u32 efi_m_max_table_entries;
> +
> +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(union efi_debug_image_info *))
> +
>  /**
>   * efi_initialize_system_table_pointer() - Initialize system table pointer
>   *
> @@ -44,3 +51,133 @@ efi_status_t efi_initialize_system_table_pointer(void)
>
>         return EFI_SUCCESS;
>  }
> +
> +/**
> + * efi_core_new_debug_image_info_entry() - Add a new efi_loaded_image structure to the
> + *                                         efi_debug_image_info table.
> + *
> + * @image_info_type: type of debug image information
> + * @loaded_image:    pointer to the loaded image protocol for the image
> + *                   being loaded
> + * @image_handle:    image handle for the image being loaded
> + *
> + * Re-Allocates the table if it's not large enough to accommodate another
> + * entry.
> + *
> + * Return: status code
> + **/
> +efi_status_t efi_core_new_debug_image_info_entry(u32 image_info_type,
> +                                                struct efi_loaded_image *loaded_image,
> +                                                efi_handle_t image_handle)
> +{
> +       union efi_debug_image_info **table;
> +       u32 index;
> +       u32 table_size;
> +       efi_status_t ret;
> +
> +       /* Set the flag indicating that we're in the process of updating
> +        * the table.
> +        */
> +       efi_m_debug_info_table_header.update_status |=
> +               EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +       table = &efi_m_debug_info_table_header.efi_debug_image_info_table;
> +
> +       if (efi_m_debug_info_table_header.table_size >= efi_m_max_table_entries) {
> +               /* table is full, re-allocate the buffer increasing the size
> +                * by 4 KiB.
> +                */
> +               table_size = efi_m_max_table_entries * EFI_DEBUG_TABLE_ENTRY_SIZE;
> +
> +               ret = efi_realloc((void **)table, table_size + EFI_PAGE_SIZE);
> +
> +               if (ret != EFI_SUCCESS) {
> +                       efi_m_debug_info_table_header.update_status &=
> +                               ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +                       return ret;
> +               }
> +
> +               /* Enlarge the max table entries and set the first empty
> +                * entry index to be the original max table entries.
> +                */
> +               efi_m_max_table_entries +=
> +                       EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
> +       }
> +
> +       /* We always put the next entry at the end of the currently consumed
> +        * table (i.e. first free entry)
> +        */
> +       index = efi_m_debug_info_table_header.table_size;
> +
> +       /* Allocate data for new entry. */
> +       ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +                               sizeof(union efi_debug_image_info),
> +                               (void **)(&(*table)[index].normal_image));
> +       if (ret == EFI_SUCCESS && (*table)[index].normal_image) {
> +               /* Update the entry. */
> +               (*table)[index].normal_image->image_info_type = image_info_type;
> +               (*table)[index].normal_image->loaded_image_protocol_instance =
> +                       loaded_image;
> +               (*table)[index].normal_image->image_handle = image_handle;
> +
> +               /* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
> +                * set the efi_m_debug_info_table_header in modified status.
> +                */
> +               efi_m_debug_info_table_header.table_size++;
> +               efi_m_debug_info_table_header.update_status |=
> +                       EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +       } else {
> +               log_err("Adding new efi_debug_image_info failed\n");
> +               return ret;
> +       }
> +
> +       efi_m_debug_info_table_header.update_status &=
> +               ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +       return EFI_SUCCESS;
> +}
> +
> +/**
> + * efi_core_remove_debug_image_info_entry() - Remove an efi_debug_image_info entry.
> + *
> + * @image_handle:    image handle for the image being removed
> + **/
> +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle)
> +{
> +       union efi_debug_image_info *table;
> +       u32 index;
> +
> +       efi_m_debug_info_table_header.update_status |=
> +               EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +       table = efi_m_debug_info_table_header.efi_debug_image_info_table;
> +
> +       for (index = 0; index < efi_m_max_table_entries; index++) {
> +               if (table[index].normal_image &&
> +                   table[index].normal_image->image_handle == image_handle) {
> +                       /* Found a match. Free up the table entry.
> +                        * Move the tail of the table one slot to the front.
> +                        */
> +                       efi_free_pool(table[index].normal_image);
> +
> +                       memmove(&table[index],
> +                               &table[index + 1],
> +                               (efi_m_debug_info_table_header.table_size -
> +                                index - 1) * EFI_DEBUG_TABLE_ENTRY_SIZE);
> +
> +                       /* Decrease the number of EFI_DEBUG_IMAGE_INFO
> +                        * elements and set the efi_m_debug_info_table_header
> +                        * in modified status.
> +                        */
> +                       efi_m_debug_info_table_header.table_size--;
> +                       table[efi_m_debug_info_table_header.table_size].normal_image =
> +                               NULL;
> +                       efi_m_debug_info_table_header.update_status |=
> +                               EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> +                       break;
> +               }
> +       }
> +
> +       efi_m_debug_info_table_header.update_status &=
> +               ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +}
> --
> 2.39.5
>
