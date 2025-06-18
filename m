Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA9C7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0599482B20;
	Wed, 18 Jun 2025 16:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SxJDYqNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE6182B18; Wed, 18 Jun 2025 16:11:51 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C625482CF4
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-553d52cb80dso604165e87.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750255908; x=1750860708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F0FxH37GdPNunG+WrzfMGgIoC7pY6YvYezmQEvdtRvw=;
 b=SxJDYqNMSBVp5i7fLdczqCvOz0dvVeDqOrgo+xgmc02xmDLvmmuCcgvBYscox8bmbQ
 x5H6f+EeJRhZ9nm3DEl4kYhorBua4vfnt8tM0Iz4u1UXGh2PjgsquAvgqPl81krU1jqt
 q8Kg/9iNPtJo19Z1lyVC1asITJ4qA8ZucouQgADqGFiitByMnIFlX0EyuVgKaTNuUZG9
 DwNZfaof0NVz5i8ak3K0z9pBajESoIRhYeFZEJh7KbdLHp+rHAL1GsQIesF6Vvt3ETnk
 DPgQQubllHP6xW03RyinwEto92+L1pE//Et+rGoK3YgQ6ZzEMtbhZ9D9Z3VtjctX3yKH
 8a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750255908; x=1750860708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0FxH37GdPNunG+WrzfMGgIoC7pY6YvYezmQEvdtRvw=;
 b=pGeI2TeKbdFo5U5LtcTVc3Hi6EDwPYee8gw/iEjCfd408ahFdc4QxyhpIxhB7qePOY
 xCklZUlfJPL9o612nF5pNWj936k1cMCdIxHk2hTpgz6H369uguGA1GnusOm3dkKi5rkK
 OEbRXBcKAxPTQHMrA/Z+o+koQ1+s792j4MMjXJlBE1JClgVu5hzfvdQMMWneK62pQiuy
 lJTEC24tUnDc7x8CvOQYvTuWGGGU8Q72ogFO/p6a6Avy6xpZC5e2WrEVj1XSZVylJnYp
 q/lnEa/IoVtKwzRHiST+s7aOByK+EXm354duBJcOQ+vFjA/up43wpoMyjoyN8Ep7bkq5
 6YBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5fuEJobxiLw0rARl0XRoyDMI+wQTa3mn6SYIaxouWeiXZKhzzgM0V0YhlkQxFgektwQRYxM=@lists.denx.de
X-Gm-Message-State: AOJu0YwaOuTLOmlYXs6GyxVMWel81CwTN95PbjJd3eIJywKOs103U6zu
 wRxjN1PSP60OEkzFjxdvrGEUXLEmNYAubCCqqME9opiXC8gmSVPwmhM7Vc1ZvUNiRo9NHysQtlF
 +FAT1+zWUxUmOq/sMuUoiYUpyb45gTBoS+41YFvjM1A==
X-Gm-Gg: ASbGncsgZQy7fXL0X16SrZiqGwmVvdEmJmKINyS7Itq5/vgTYy3luq+hGpMkVCuk7e8
 4qwMvOfShHGq7LXrrFOAIb105eg9uKRRaNyBCcq1r3Brb9A3T8eH5m2gbaET9/3mWp5TCx8s4dY
 lu28cHOA25B8Vam+6MFgShVUAVp3432ZDx8LgZDpu/2jtmWwGUeZqwR9NLklFcl50K9VnMxQ0vr
 d1c
X-Google-Smtp-Source: AGHT+IHNuXPreXVpa1YEW5o+e4nyFAaRqUqgxRFAs5WGi6hou6lQmV1ylTCg5DVGdSX+JqsQZzkFLSXyL5LZalTsZtM=
X-Received: by 2002:a05:6512:b01:b0:553:510d:f471 with SMTP id
 2adb3069b0e04-553d394f686mr943962e87.24.1750255907711; Wed, 18 Jun 2025
 07:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250617120855.87492-1-paulliu@debian.org>
 <20250617120855.87492-3-paulliu@debian.org>
 <ca021089-b82f-427b-a29a-34d3813afce5@gmx.de>
In-Reply-To: <ca021089-b82f-427b-a29a-34d3813afce5@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Wed, 18 Jun 2025 15:11:36 +0100
X-Gm-Features: Ac12FXyZnaz9M7EEmiKv9pNj-arxmz2NVkDm0jW9ct-xm0eCUFdKguZh6SBDyAk
Message-ID: <CALG-KHyiJZWvTYeW3ogZr+3d8mRAvFHkSXqPJKD-zdsMcfJx8A@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Wed, 18 Jun 2025 at 07:39, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 6/17/25 14:08, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> > debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.
> >
> > This feature is described in UEFI Spec version 2.10. Section 18.4.
> > The implementation ensures support for hardware-assisted debugging and
> > provides a standardized mechanism for debuggers to discover and interact
> > with system-level debug resources.
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Peter Robinson <pbrobinson@gmail.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V3: Fix the way of installation of configuration table.
> > V5: move the code into a separate module.
> > ---
> >   include/efi_api.h                  | 53 ++++++++++++++++++++++++++++++
> >   include/efi_loader.h               |  2 ++
> >   lib/efi_loader/efi_debug_support.c |  6 ++++
> >   lib/efi_loader/efi_setup.c         | 12 +++++++
> >   4 files changed, 73 insertions(+)
> >
> > diff --git a/include/efi_api.h b/include/efi_api.h
> > index 6c4c1a0cc7b..8da0a350ce3 100644
> > --- a/include/efi_api.h
> > +++ b/include/efi_api.h
> > @@ -238,6 +238,10 @@ enum efi_reset_type {
> >       EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
> >                0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
> >
> > +#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
> > +     EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
> > +              0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
> > +
> >   struct efi_conformance_profiles_table {
> >       u16 version;
> >       u16 number_of_profiles;
> > @@ -574,6 +578,55 @@ struct efi_loaded_image {
> >       efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
> >   };
> >
> > +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> > +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> > +
> > +/**
> > + * struct efi_debug_image_info_normal - Store Debug Information for
> normal
> > + * image.
> > + * @image_info_type: the type of image info.
> > + * @loaded_image_protocol_instance: the pointer to struct
> efi_loaded_image.
> > + * @image_handle: the EFI handle of the image.
> > + *
> > + * This struct is created by efi_load_image() and store the information
> > + * for debugging an normal image.
> > + */
> > +struct efi_debug_image_info_normal {
> > +     u32 image_info_type;
> > +     struct efi_loaded_image *loaded_image_protocol_instance;
> > +     efi_handle_t image_handle;
> > +};
> > +
> > +/**
> > + * union efi_debug_image_info - The union to store a pointer for EFI
> > + * DEBUG IMAGE INFO.
> > + * @image_info_type: the type of the image_info if it is not a normal
> image.
> > + * @normal_image: The pointer to a normal image.
> > + *
> > + * This union is for a pointer that can point to the struct of
> normal_image.
> > + * Or it points to an image_info_type.
> > + */
> > +union efi_debug_image_info {
> > +     u32 *image_info_type;
> > +     struct efi_debug_image_info_normal *normal_image;
> > +};
> > +
> > +/**
> > + * struct efi_debug_image_info_table_header - store the array of
> > + * struct efi_debug_image_info.
> > + * @update_status: Status to notify this struct is ready to use or not.
> > + * @table_size: The number of elements of efi_debug_image_info_table.
> > + * @efi_debug_image_info_table: The array of efi_debug_image_info.
> > + *
> > + * This struct stores the array of efi_debug_image_info. The
> > + * number of elements is table_size.
> > + */
> > +struct efi_debug_image_info_table_header {
> > +     volatile u32 update_status;
> > +     u32 table_size;
> > +     union efi_debug_image_info *efi_debug_image_info_table;
> > +};
> > +
> >   #define EFI_DEVICE_PATH_PROTOCOL_GUID \
> >       EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
> >                0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> > diff --git a/include/efi_loader.h b/include/efi_loader.h
> > index 8f065244d8e..d0c72d0bc58 100644
> > --- a/include/efi_loader.h
> > +++ b/include/efi_loader.h
> > @@ -315,6 +315,8 @@ extern const struct efi_hii_config_routing_protocol
> efi_hii_config_routing;
> >   extern const struct efi_hii_config_access_protocol
> efi_hii_config_access;
> >   extern const struct efi_hii_database_protocol efi_hii_database;
> >   extern const struct efi_hii_string_protocol efi_hii_string;
> > +/* structure for EFI_DEBUG_SUPPORT_PROTOCOL */
> > +extern struct efi_debug_image_info_table_header
> efi_m_debug_info_table_header;
> >
> >   uint16_t *efi_dp_str(struct efi_device_path *dp);
> >
> > diff --git a/lib/efi_loader/efi_debug_support.c
> b/lib/efi_loader/efi_debug_support.c
> > index 3794b31c4cd..f2dfcc5e6b2 100644
> > --- a/lib/efi_loader/efi_debug_support.c
> > +++ b/lib/efi_loader/efi_debug_support.c
> > @@ -11,6 +11,12 @@
> >
> >   struct efi_system_table_pointer __efi_runtime_data * systab_pointer =
> NULL;
> >
> > +struct efi_debug_image_info_table_header efi_m_debug_info_table_header
> = {
> > +     0,
> > +     0,
> > +     NULL
> > +};
> > +
> >   /**
> >    * efi_initialize_system_table_pointer() - Initialize system table
> pointer
> >    *
> > diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
> > index 6193b9f6d0c..60f3a7e5fbf 100644
> > --- a/lib/efi_loader/efi_setup.c
> > +++ b/lib/efi_loader/efi_setup.c
> > @@ -18,6 +18,9 @@
> >
> >   efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
> >
> > +const efi_guid_t efi_debug_image_info_table_guid =
> > +     EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> > +
> >   /*
> >    * Allow unaligned memory access.
> >    *
> > @@ -280,10 +283,19 @@ efi_status_t efi_init_obj_list(void)
> >
> >       /* Initialize system table pointer */
> >       if (IS_ENABLED(CONFIG_EFI_DEBUG_SUPPORT)) {
> > +             efi_guid_t debug_image_info_table_guid =
>
> This variable shadows the variable defined above.
>
> > +                     efi_debug_image_info_table_guid;
>
> This self assignment provides a random value from the stack and not the
> expected GUID.
>
> Please, provide a test in lib/efi_selftest/ verifying that the table is
> installed with the correct GUID.
>
>
Hi Heinrich,

This is not a self assignment. The new variable is called
"debug_image_info_table_guid". The global one is called
"efi_debug_image_info_table_guid".
I'll implement a selftest anyway to make sure that the GUID is correct.



> > +
> >               ret = efi_initialize_system_table_pointer();
> >               if (ret != EFI_SUCCESS) {
> >                       goto out;
> >               }
> > +
> > +             ret =
> efi_install_configuration_table(&debug_image_info_table_guid,
> > +
>  &efi_m_debug_info_table_header);
> > +             if (ret != EFI_SUCCESS) {
> > +                     goto out;
> > +             }
>
> No braces here. Please, use scripts/checkpatch.pl before resubmitting.
>
>
Do you set some parameters of the scripts/checkpatch.pl ?
I'm using ./scripts/checkpatch.pl -g <COMMIT_ID> --u-boot.
But it only gives me a warning about using the volatile.
And for patch 1/4 it only gives me a warning about adding new file and the
MAINTAINER stuff.
This is weird. I didn't get the warning about the braces at all.

Yours,
Paul
