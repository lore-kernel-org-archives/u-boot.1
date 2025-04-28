Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA5DC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 12:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5328182724;
	Mon, 28 Apr 2025 14:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="olxPYdko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881C882724; Mon, 28 Apr 2025 14:14:59 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3367826AD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54b0d638e86so5527872e87.1
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745842496; x=1746447296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b0/yjej0h9cXWVAPIrOhU5N1G/Ab3avJZLevUSN0NCU=;
 b=olxPYdkoiH/K6EMdentX4L91xh1+WqRsO6pi/VoAQEJGyhMx91CCZrGYO/+6Awy/ez
 gCOVxYDrsqLI8i3Hb7dAAL/QuYgIQXZnaHqDinndV+CZMMhRI/JIshOFyXSUuY23C+kE
 KbwPwZRKmgXU1PG0CuXkjwMRQLEKIbH/SWno2PuYuqB45Kb1r2N1Md/d5jTetLzru4aq
 BXonN0TVIDPrbsz6sE6VdVOYLItplB8mgk7xLT5WNDvmDsCXNYlecwMe94NSh/eSt8Tv
 991jm7GOiWbx9w0ZsluxgVCx/a5hqgLgGr24hE0xR5y97z7v2QWLITSVTlixoXbCnJkt
 NF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745842496; x=1746447296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b0/yjej0h9cXWVAPIrOhU5N1G/Ab3avJZLevUSN0NCU=;
 b=eRy+vnzSnIWH1EWX9RBgXGui4qu/TSUmcrE6d1Iw9fJDtN4BtPdwHnf6Gh0o5jA2iN
 lobajyikaZPn+1CqHZkTUHlAGBLrR1YG55ruJTXDQCTUYfl8pKc6FujGWzpqQdSI51L/
 LF3yVpRM0dU84iaVShMD52VyfyjnMPmKhqWGLZgGO0Kd0xxO5SxggKFtbF2EqJ7ygBlS
 rG9vrB5Hq32rpn/uF0HUeGton32A/UPLaybER/w8jATyCFO2LAAHfx/v8TGkLu8GQZ6v
 eTlKWdgFdWH+xcgCMqeI97HbXpzpL4cI9Wp5aQAHLbODamK90Yt6IJVLYFlrJ6y4NnIY
 3PBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXngdhL8jM4ZCa/IQOUHZfRI51D+ziN1YROzP6yhVOsre5GrkOI60D22EcgWRelm0ozHQtBkhA=@lists.denx.de
X-Gm-Message-State: AOJu0YyvUv+GTjiYbmQY8Khy1GNEE40j2MsByIncZakJLKRZdiXL7EjW
 Ss5qkmb722WymvcVI8kgQA7iJkUG8cfvuUIZ1ec3T7OMhducxgPwz5STLK+H9+Y3OiqQr08ss3g
 iFcnisY968cvPQLuPW3Xv8HRkAcKJZXVg54LkHg==
X-Gm-Gg: ASbGncurJ8oLDW7znmnrL0AOmONFYx6oK5NyC+lsI/fNjTKiQ6l5g5obJnCbhFEaM7k
 7jAHsmY4a/wa1cI5vYG4v5kP8fp5GSKRqtaonKaYzdm9JSyI0mpCcot0wr5QyhqI4RdVNzHjrjO
 GILiyGB5ADAbBSXw1tqloU
X-Google-Smtp-Source: AGHT+IEF2PHIMlQEYc1f8Sl9KsmEsvljA2B5yH1k1eINE0o2T435Fc6IjmRO1N/31WTUfGIKLCxcKlofltWhg0EXStM=
X-Received: by 2002:a05:6512:b83:b0:54d:6e19:ba9b with SMTP id
 2adb3069b0e04-54e8ffdba8cmr2335193e87.34.1745842495871; Mon, 28 Apr 2025
 05:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250423213145.1959046-1-paulliu@debian.org>
 <20250423213145.1959046-4-paulliu@debian.org>
 <f9010568-6a52-4486-9c29-794107f2e840@gmx.de>
In-Reply-To: <f9010568-6a52-4486-9c29-794107f2e840@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Mon, 28 Apr 2025 13:14:44 +0100
X-Gm-Features: ATxdqUE3uMdjrWF4RDCPpOyL_0yBBmuwK-OX7fRGCTvzk4n1QDBTkJUFOyzvOnM
Message-ID: <CALG-KHyi4R7q1Qb6OnMmZCGVySA5dg-pD9yNEnf7SQ8VJyobwA@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: add EFI_DEBUG_IMAGE_INFO for debug
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

Yes. I just copied the code from EDK2. Seems this is incorrect. I'll try to
ask some help from EDK2 people.
Actually I'm working on Android (AOSP)'s GBL project. It is an EFI
application, used as a bootloader for loading and booting Android images.
So some people are asking how to debug that EFI application on real
hardwares. And since GBL runs on both U-boot and EDK2, the debug method
should
follow the standard so that the downstream people can have a unified way to
debug the application.

I'll ask EDK2 people for help and then continue working on this patch.

Thanks a lot,
Paul



On Mon, 28 Apr 2025 at 11:40, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 4/23/25 23:31, Ying-Chun Liu (PaulLiu) wrote:
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
> >   include/efi_api.h             |   2 +
> >   include/efi_loader.h          |   5 ++
> >   lib/efi_loader/efi_boottime.c | 136 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 143 insertions(+)
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
> > index e2665459e44..bf37580c06b 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -2130,6 +2130,12 @@ efi_status_t EFIAPI efi_load_image(bool
> boot_policy,
> >               *image_handle = NULL;
> >               free(info);
> >       }
> > +
> > +     if (*image_handle) {
> > +
>  efi_core_new_debug_image_info_entry(EFI_DEBUG_IMAGE_INFO_TYPE_NORMAL,
> > +                                                 info,
> > +                                                 *image_handle);
> > +     }
> >   error:
> >       return EFI_EXIT(ret);
> >   }
> > @@ -3359,6 +3365,7 @@ efi_status_t EFIAPI efi_unload_image(efi_handle_t
> image_handle)
> >               ret = EFI_INVALID_PARAMETER;
> >               goto out;
> >       }
> > +     efi_core_remove_debug_image_info_entry(image_handle);
> >       switch (efiobj->type) {
> >       case EFI_OBJECT_TYPE_STARTED_IMAGE:
> >               /* Call the unload function */
> > @@ -4045,6 +4052,10 @@ efi_m_debug_info_table_header = {
> >       NULL
> >   };
> >
> > +static u32 efi_m_max_table_entries;
> > +
> > +#define EFI_DEBUG_TABLE_ENTRY_SIZE  (sizeof(void *))
> > +
> >   const efi_guid_t efi_debug_image_info_table_guid =
> >       EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> >
> > @@ -4095,3 +4106,128 @@ efi_status_t
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
> > +     if (table[index].normal_image) {
> > +             /* Update the entry. */
> > +             table[index].normal_image->image_info_type =
> image_info_type;
> > +             table[index].normal_image->loaded_image_protocol_instance =
> > +                     loaded_image;
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
>
> It seems that you just copied the logic from EDK II instead of
> programming according to the UEFI specification.
>
> I cannot see that the UEFI specification allows NULL pointers inside the
> array.
>
> > +
> > +                     /* Decrease the number of EFI_DEBUG_IMAGE_INFO
> > +                      * elements and set the
> efi_m_debug_info_table_header
> > +                      * in modified status.
> > +                      */
> > +                     efi_m_debug_info_table_header.table_size--;
>
> According to the UEFI specification the table_size must match the array
> size and not the number of non-NULL elements. If there is a NULL pointer
> in the middle of the table and you decrease the table_size value, the
> last non-NULL element is not accessible anymore.
>
> A correct implementation would move all elements after the deleted one
> one slot to the front.
>
> Best regards
>
> Heinrich
>
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
