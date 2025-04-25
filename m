Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30672C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 19:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60A882A46;
	Fri, 25 Apr 2025 21:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bBXqU4Rh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427A782A4B; Fri, 25 Apr 2025 21:07:15 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A90682A31
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 21:07:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54d65cb6e8aso3296529e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745608032; x=1746212832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vODV86d6+QKHY5NRj+lsbYYHFQVDofhZIjkuG9uGuhE=;
 b=bBXqU4Rh/V6eRS03DRNMg7M3ERlZGTSLu65GAuTeZUNZ+HcYUDIT1ICh6tTuE/dZL0
 aal8NRved2yMh5qgIBfN17IXtfqzoA0IDeOhXtSApo3yVZlG93QEs819vDr18LGag133
 c9c8/Q3IQaQfjDdHskW4l/M7Yp/kM12Dlh68252errEWDIuufXWrXH5KV+UsNRC1xygd
 YwO6o7ZigLbtREA1hKoqqlAuzUDJhvczBQTOYb0VE6X+r/IellbqaR8bKlBgSJ/uw6HS
 qOMGkvMYk/AQ8FRjZxJJBTYwUg3eprlkmcgam4VtCjL6MTG4+4pMRO+yUm/oFszb9JBu
 6Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745608032; x=1746212832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vODV86d6+QKHY5NRj+lsbYYHFQVDofhZIjkuG9uGuhE=;
 b=UdMlY+hJLerLMkJqG1/arEfYXUmzr8Cw8GMI5ElHSYSe5yTNRHcU1995bLKT/BPRkv
 OqagGT6ih85QeNRKcMTOvPMwrItTyZ/4D0HJumKof6Sd3hrXuyR3N3b7ZR8k1Ckykqrp
 dm1NBBhGxk371w+j2LcbgSfyouqOJCopWy++Q4+6vMG6XNQODXZKMyHV2juOXZfnoDBv
 e5gNIn5d1W5Qj99spbuq4AMYTTqZlC8j4/X03Z3X9qP5+H4uFRRbNoXekrzBCwydwpWe
 6BTErylJHa5VSY+hIy2Niso1Us4/MveC3A/KzgjVgaKR/MyBpfFiWF1D5YLBmNRuFu70
 aLdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGf5guNGyaHsI6uRvA2LZIezghZ9Axx7GraW8GoVvVyJ++lUsLdsjpZVk3z59zb52Zue1nQps=@lists.denx.de
X-Gm-Message-State: AOJu0YzqbO/QALovW/T1frHRWJSTMaJQUe4F8G/SClFXPsqpxffkhvHX
 YBYVcdq2Cl75wZntgNEKYFrHHCLAX8jJMatlpAM1tkVI0lflZuJmNBy7j70JgoqabPYEaRryNwe
 gF71ojjzQt3rtW/0dUAuJpo05u5Xb9CqzkPk4Yg==
X-Gm-Gg: ASbGncsYE96rE8LWQ2tSViJSpqa6Cdf/T+UlPyiQT64b0cj81U0xXBlKP3PYyL6SUfP
 dBPLELV0ZO65pdir3ALrhX6y9QchsdLYmNrRhGdok8lO+SlQ6Mbu4I+JP6wtaZaD7nmrpSobn4P
 g3fxjS28wwpqEBsKszHZQd7tep6/MMORz3J+gDa8J9RREGwb8/kHGCghE=
X-Google-Smtp-Source: AGHT+IGF5W7HQXUjIoVjuJJ8hJpDPNTM5eVrV8S+ejqgvlJKcgLAQO9Xh30Q6kXpdVhdWZ+jv0G0QdotLMdW+FOgSnA=
X-Received: by 2002:a05:6512:2356:b0:54a:fa58:a6f4 with SMTP id
 2adb3069b0e04-54e8cbd5ce8mr1249742e87.24.1745608031792; Fri, 25 Apr 2025
 12:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-4-paulliu@debian.org>
 <aded7723-931f-4d17-87ad-dbe788792892@gmx.de>
In-Reply-To: <aded7723-931f-4d17-87ad-dbe788792892@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Fri, 25 Apr 2025 20:07:00 +0100
X-Gm-Features: ATxdqUHon9h8JwexDpu_XYOe7fTSwrLsXLwamVkUOc7D71dZDDdKFCfF1XtDU-w
Message-ID: <CALG-KHzZzGgvXNzPV8gXb2v-96d+n_bG9y0iNL6B5DDGPD6YPg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

Thanks for the review.
All of the issues in this commit will be fixed in the next version.

Thanks a lot.

Yours,
Paul


On Thu, 24 Apr 2025 at 23:34, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > This commit adds the functionality of generate EFI_DEBUG_IMAGE_INFO
> > while loading the image.
> >
> > This feature is described in UEFI Spec 2.10. Section 18.4.3.
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > V2: use Kconfig options to turn on/off this feature.
> > ---
> >   include/efi_api.h             |   2 +
> >   include/efi_loader.h          |   5 ++
> >   lib/efi_loader/efi_boottime.c | 140 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 147 insertions(+)
> >
> > diff --git a/include/efi_api.h b/include/efi_api.h
> > index 0f4245091f1..ba87af17c1f 100644
> > --- a/include/efi_api.h
> > +++ b/include/efi_api.h
> > @@ -571,6 +571,8 @@ struct efi_loaded_image {
> >   #define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> >   #define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> >
> > +#define EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL  0x01
> > +
> >   struct efi_debug_image_info_normal {
> >       u32 image_info_type;
> >       struct efi_loaded_image *loaded_image_protocol_instance;
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 370bc042f70..babe23a8a83 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -617,6 +617,11 @@ efi_status_t efi_root_node_register(void);
> >   efi_status_t efi_initialize_system_table(void);
> >   /* Called by bootefi to initialize debug */
> >   efi_status_t efi_initialize_system_table_pointer(void);
> > +/* Called by efi_load_image for register debug info */
> > +void efi_core_new_debug_image_info_entry(u32 image_info_type,
> > +                                      struct efi_loaded_image
> *loaded_image,
> > +                                      efi_handle_t image_handle);
> > +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle);
> >   /* efi_runtime_detach() - detach unimplemented runtime functions */
> >   void efi_runtime_detach(void);
> >   /* efi_convert_pointer() - convert pointer to virtual address */
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index e2665459e44..0d4df5ee6ae 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -2130,6 +2130,14 @@ efi_status_t EFIAPI efi_load_image(bool
> boot_policy,
> >               *image_handle = NULL;
> >               free(info);
> >       }
> > +
> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> > +             if (*image_handle) {
> > +
>  efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> > +                                                         info,
> > +                                                         *image_handle);
> > +             }
> > +     }
> >   error:
> >       return EFI_EXIT(ret);
> >   }
> > @@ -3359,6 +3367,9 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t
> image_handle)
> >               ret = EFI_INVALID_PARAMETER;
> >               goto out;
> >       }
> > +     if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT_TABLE)) {
> > +             efi_core_remove_debug_image_info_entry(image_handle);
> > +     }
> >       switch (efiobj->type) {
> >       case EFI_OBJECT_TYPE_STARTED_IMAGE:
> >               /* Call the unload function */
> > @@ -4045,6 +4056,10 @@ efi_m_debug_info_table_header = {
> >       NULL
> >   };
> >
>
> Please, describe this field.
>
> > +static u32 efi_m_max_table_entries;
> > +
>
> > +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))
>
> Wouldn't it be more readable to use sizeof(union efi_debug_image_info *)
> instead of this constant?
>
> > +
> >   const efi_guid_t efi_debug_image_info_table_guid =
> >       EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> >
> > @@ -4095,3 +4110,128 @@ efi_status_t
> efi_initialize_system_table_pointer(void)
> >
> >       return ret;
> >   }
> > +
> > +/**
> > + * Add a new efi_loaded_image structure to the efi_debug_image_info
> Table.
> > + * Re-Allocates the table if it's not large enough to accomidate another
> > + * entry.
> > + *
> > + * @param image_info_type  type of debug image information
> > + * @param loaded_image     pointer to the loaded image protocol for the
> image
> > + *                         being loaded
> > + * @param image_handle     image handle for the image being loaded
> > + **/
> > +void efi_core_new_debug_image_info_entry(u32 image_info_type,
> > +                                      struct efi_loaded_image
> *loaded_image,
> > +                                      efi_handle_t image_handle)
>
> Reallocation can fail. The return value type void seems not to be adequate.
>
> > +{
> > +     union efi_debug_image_info *table;
> > +     union efi_debug_image_info *new_table;
> > +     u32 index;
> > +     u32 table_size;
> > +
> > +     /* Set the flag indicating that we're in the process of updating
> > +      * the table.
> > +      */
> > +     efi_m_debug_info_table_header.update_status |=
> > +             EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> > +
> > +     table = efi_m_debug_info_table_header.efi_debug_image_info_table;
> > +
> > +     if (efi_m_debug_info_table_header.table_size <
> efi_m_max_table_entries) {
> > +             /* We still have empty entries in the Table, find the first
> > +              * empty entry.
> > +              */
> > +             index = 0;
> > +             while (table[index].normal_image)
> > +                     index++;
> > +     } else {
> > +             /* table is full, re-allocate another page for a larger
>
> "Re-allocate the buffer increasing the size by 4 KiB" would be clearer.
>
> > +              * table.
> > +              */
> > +             table_size = efi_m_max_table_entries *
> EFI_DEBUG_TABLE_ENTRY_SIZE;
> > +             efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
> > +                               table_size + EFI_PAGE_SIZE,
> > +                               (void **)&new_table);
> > +
> > +             if (!new_table) {
> > +                     efi_m_debug_info_table_header.update_status &=
> > +                             ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> > +                     return;
> > +             }
> > +
> > +             memset(new_table, 0, table_size + EFI_PAGE_SIZE);
>
> Please, carve out an efi_realloc() function and place it in
> lib/efi_loader/efi_memory.c beside efi_alloc().
>
> > +
> > +             /* Copy the old table into the new one. */
> > +             memcpy(new_table, table, table_size);
> > +             /* Free the old table. */
> > +             efi_free_pool(table);
> > +             /* Update the table header. */
> > +             table = new_table;
> > +             efi_m_debug_info_table_header.efi_debug_image_info_table =
> > +                     new_table;
> > +
> > +             /* Enlarge the max table entries and set the first empty
> > +              * entry index to be the original max table entries.
> > +              */
> > +             index = efi_m_max_table_entries;
> > +             efi_m_max_table_entries +=
> > +                     EFI_PAGE_SIZE / EFI_DEBUG_TABLE_ENTRY_SIZE;
> > +     }
> > +
> > +     /* Allocate data for new entry. */
> > +     efi_allocate_pool(EFI_RUNTIME_SERVICES_DATA,
> > +                       sizeof(struct efi_debug_image_info_normal),
> > +                       (void **)(&table[index].normal_image));
>
> efi_allocate_pool() will consume a whole page. Shouldn't we have an
> array of consecutive structures and use realloc_pool() to enlarge it if
> we load too many images?
>
> > +     if (table[index].normal_image) {
> > +             /* Update the entry. */
> > +             table[index].normal_image->image_info_type =
> image_info_type;
> > +             table[index].normal_image->loaded_image_protocol_instance =
> > +                     loaded_image;
>
> All protocols become invalid after ExitBootServices(). Why would you use
> EFI_RUNTIME_SERVICES_DATA to store references to something that does not
> exist at runtime?
>
> EDK II uses AllocateZeroPool() which does not use EfiRuntimeServicesData.
>
> Best regards
>
> Heinrich
>
> > +             table[index].normal_image->image_handle = image_handle;
> > +
> > +             /* Increase the number of EFI_DEBUG_IMAGE_INFO elements and
> > +              * set the efi_m_debug_info_table_header in modified
> status.
> > +              */
> > +             efi_m_debug_info_table_header.table_size++;
> > +             efi_m_debug_info_table_header.update_status |=
> > +                     EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> > +     }
> > +
> > +     efi_m_debug_info_table_header.update_status &=
> > +             ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> > +}
> > +
> > +void efi_core_remove_debug_image_info_entry(efi_handle_t image_handle)
> > +{
> > +     union efi_debug_image_info *table;
> > +     u32 index;
> > +
> > +     efi_m_debug_info_table_header.update_status |=
> > +             EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> > +
> > +     table = efi_m_debug_info_table_header.efi_debug_image_info_table;
> > +
> > +     for (index = 0; index < efi_m_max_table_entries; index++) {
> > +             if (table[index].normal_image &&
> > +                 table[index].normal_image->image_handle ==
> image_handle) {
> > +                     /* Found a match. Free up the record, then NULL the
> > +                      * pointer to indicate the slot is free.
> > +                      */
> > +                     efi_free_pool(table[index].normal_image);
> > +                     table[index].normal_image = NULL;
> > +
> > +                     /* Decrease the number of EFI_DEBUG_IMAGE_INFO
> > +                      * elements and set the
> efi_m_debug_info_table_header
> > +                      * in modified status.
> > +                      */
> > +                     efi_m_debug_info_table_header.table_size--;
> > +                     efi_m_debug_info_table_header.update_status |=
> > +                             EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED;
> > +                     break;
> > +             }
> > +     }
> > +
> > +     efi_m_debug_info_table_header.update_status &=
> > +             ~EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS;
> > +}
>
>
