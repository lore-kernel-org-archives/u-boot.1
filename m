Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F51C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 13:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A4380C93;
	Mon, 16 Jun 2025 15:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DZCymuad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9992C81760; Mon, 16 Jun 2025 15:21:02 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5563E8070C
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70e6bddc30aso37731767b3.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750080059; x=1750684859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hjhWoI2MQakcb2HwKb3A6fT7/TVH+4C5vcuUad9ch5w=;
 b=DZCymuadZklSjQ1GPUQZhjnzIZpXgSxsqlHOuc7eDJ0Nl2mIP/xm6zM0fewDKzsEZ2
 i+5hrYRvZA8hFA3xNrqsXxs4h4kkO7iCj6M1XKI89ZWZSXmSsokDJNqP7WtQlR29WQEw
 dF7y5ItnLUYRxwS9Oe9yMzUVLBkOR2RN+YkEDksvMbnEoBNoUbKS8S+9rrFxG6A6ib9v
 XOAWEsRz2O+to8/jIY+7aHhM+lPGhJsnUrPGpTyS6IEbje2/hqtXVIh2yMrM6tFFusO6
 mD7gpRtoBYF9HQgcnF7pdrTFYxBmQG8KXXXp6yau5tihBDG6JOML5eB9ey6MmPd41gWy
 Rrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750080059; x=1750684859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hjhWoI2MQakcb2HwKb3A6fT7/TVH+4C5vcuUad9ch5w=;
 b=CPM12p9WhDnILxCM9vYzPIcW63QmJToiTqeKk+5eKwRRxWHBq7HY7rLlmdLR6QlOqR
 hski3qnY0I9rWd6hS8EgujOwSmzg9sVctR7Z4t/WnVjG2q5rY9I0Bq9ewfGAhYu8DzNO
 32GeaNpUiSokKwFtHIhfNUM7tvmTacBCmZf1sgSR2IQ5aHPVkenTkfWR2JETOuWXd7WU
 TA+OMQLmZve2sAE5OE7hYKDuyyNPyg6SzcXEgls2Iq2qPtEFkd9CETv+IaBcue3QX1v4
 5eOZ041j2hzxHMWCVINGdULTTw9xNGlniaY2fL5l7kunM9kycDq6eHgMkDw/GcHmTykX
 EWlA==
X-Gm-Message-State: AOJu0YzefJgObIwiM0kdd51cxKT3CvS6uODbBr3w6BfD5JWgz5Nera8X
 idqka3Zyh3OP0hGumcieCchB/cKks3670QY9DK1aLuEZ85hWG01K2r5jDD4cY+j1/UOCjvT8AGE
 J4WFfU8YxOgFleCzxlpA291dWQ7WUbP9ENZdQYE1Yqw==
X-Gm-Gg: ASbGncsZTmpS299X8xk1/uU9Ht8LJskdenqZhW7hSMwd0jSxNHHfqTR7JE+McKDLVX5
 G6XNFz3ajiIHhkklToLwvkDB8TMabOWpUMJoJU8o8Yi53K2Sjog5oqXy0lwnJ20Q3debJmX1uqX
 ALVvbWYPYzTKFQSgceOKI9SKjGrIKMB7LU7eJjtpD68E8q
X-Google-Smtp-Source: AGHT+IGk3Hqhsti2lF1rtke2NSTFPP3Ho4zi1jcstjnAmh/0ND24A/hTUV2DiZfrcmorjbve6lYUkMV++XXMBg4HTNk=
X-Received: by 2002:a05:690c:60c1:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-7117544c86cmr124874487b3.25.1750080059017; Mon, 16 Jun 2025
 06:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250611050844.210384-1-paulliu@debian.org>
 <20250611050844.210384-5-paulliu@debian.org>
In-Reply-To: <20250611050844.210384-5-paulliu@debian.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 16 Jun 2025 16:20:20 +0300
X-Gm-Features: AX0GCFtVbPwm9ThpMS0vMRrYHCI3gys-Oo9HzQfnAztnZImzxotG_pthvh-8O1A
Message-ID: <CAC_iWjJ3bcgeebGLFpQejStYy-BL49b77TZvYg+w31yzM--A9w@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] efi: add EFI_DEBUG_IMAGE_INFO for debug
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

[...]


>         }
> +
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +               if (*image_handle) {

Can you fold this in a single line if?

> +                       efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> +                                                           info,
> +                                                           *image_handle);
> +               }
> +       }
>  error:
>         return EFI_EXIT(ret);
>  }
> @@ -3359,6 +3367,9 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t image_handle)
>                 ret = EFI_INVALID_PARAMETER;
>                 goto out;
>         }
> +       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> +               efi_core_remove_debug_image_info_entry(image_handle);
> +       }

Drop the {}

>         switch (efiobj->type) {
>         case EFI_OBJECT_TYPE_STARTED_IMAGE:
>                 /* Call the unload function */
> diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/efi_debug_support.c
> index a6a672bc0e4..468e9e1cc83 100644
> --- a/lib/efi_loader/efi_debug_support.c
> +++ b/lib/efi_loader/efi_debug_support.c
> @@ -16,6 +16,13 @@ struct efi_debug_image_info_table_header efi_m_debug_info_table_header = {
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
> @@ -50,3 +57,125 @@ efi_status_t efi_initialize_system_table_pointer(void)
>
>         return EFI_SUCCESS;
>  }
> +
> +/**
> + * efi_core_new_debug_image_info_entry() - Add a new efi_loaded_image structure to the
> + *                                         efi_debug_image_info Table.
> + *
> + * @image_info_type: type of debug image information
> + * @loaded_image:    pointer to the loaded image protocol for the image
> + *                   being loaded
> + * @image_handle:    image handle for the image being loaded
> + *
> + * Re-Allocates the table if it's not large enough to accomidate another

s/accomidate/accomodate

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
> +       efi_allocate_pool(EFI_BOOT_SERVICES_DATA,
> +                         sizeof(union efi_debug_image_info),
> +                         (void **)(&(*table)[index].normal_image));
> +       if ((*table)[index].normal_image) {
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
> +       }

Since it's a debug protocol I am ok with not unwinding all the
reallocations here, but don't you at least have to somehow warn the
consumer that updating the entry failed?

> +
> +       efi_m_debug_info_table_header.update_status &=
> +               ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> +
> +       return EFI_SUCCESS;
> +}
> +

[...]

Thanks
/Ilias
