Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03302C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 19:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43E3282A31;
	Fri, 25 Apr 2025 21:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HcDbgn9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F29E82A33; Fri, 25 Apr 2025 21:05:33 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7243282A25
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 21:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.liu@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54ac9b3ddf6so2360152e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745607930; x=1746212730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSwMBs9ZC/JkZS4Q4TdqbpkA86+SqFeRKJ7HHTsJeUo=;
 b=HcDbgn9IPIwI5EFcBhbsUPtPD3bsrCEMjxOCUoxj34mbg7gumx//tT+kTSm++2IBf1
 +xjld84iehjFF+nV7tgYQcSYPSb3noPBzWINYb58n1oBiIddjCRoKnKhcooL3uAB3DPM
 TZwDaLF5g8ZV5kzsW4WWpcRIqx4jNAjhhnADiCySpeASWZySs2ComO8UN2Y2I6oF/SKp
 M/as7Clyf/enAfX3aDJqKVmq9AHw9omca4q9p6LMyE/blK/OYLHhw4/YnvsN2BTM/JcZ
 shYbJjHzr1jjgjGLssGhZbKAxMV/y8L/MS/E7YCaqpAfllJfIwospxPkkUXa4vE0oH/1
 YMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745607930; x=1746212730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSwMBs9ZC/JkZS4Q4TdqbpkA86+SqFeRKJ7HHTsJeUo=;
 b=fRTiVCWOgC5NbUFXRNUM8MW9wGp06g2xR5TcKyndSqKvGOFRXWOrpnENDeYNmsp27H
 pFDjSqvtRD7D8bwBHn9aNVhHHxlZ4arKSSCp563VXzq/eAw5+Ng0pZdMRbfOiRY11bwv
 b/es+l64TnXXGpYBUonRvXAMClhDBD1/gzlx4igMMi1mfi3jYNM588uKDWPp80FWRZPE
 CTvWwmWySN31CwGH/IeVLpMvNEVWXi5zlZDrCOoQ7Yhs/QxW6Jf7ICdHN3961LVB2aVi
 sFZRlqKjwE9Bq0hm2fz8g6KWOCOnBAdk1KwHAgdpyTTZwKcCmATnXhPs/FNyNzizZkKk
 m0gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPHFXJPXK9dVxdEVv8fGTvfXbJStWGbtfOTLmXehRdYQ1glrNapxEZ6e1TyUPWDaTkVyNlg5Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6lb0dtbiwExuzOjkg37Jygc/cSOsnfsrObDLlO96C5qvTuzJC
 VAxrkOp8h4e90KOeANUfDU7RZ+PJDVZF5kLI3L4MDQVqlHOM6sD61EvfCox3hJGsI9nL4pxq7ja
 dHBJRyiHk8PzLPdlYrXr0u/ZnIQgLrI16ay+ZwQ==
X-Gm-Gg: ASbGncvzjZmuDXJiPIB54PDQlF50xzm130ULNtj9f/8l1lRPfvIGPUxH/X77Lqv8Lmn
 7zDuxb1jtnFPnf+cFUF9BGUPLSrj5X95r9J0jpMTjqdgORaz3XJCj+scgAQDoeCoem2mja0rBav
 Y83evxRtC6aypfFojp+HedugIsKjKDtrxl0YuAKFOWDrPBPA22JbWtdis=
X-Google-Smtp-Source: AGHT+IFaijbuTeuw3c0bJn2qUrnA+DnT8tqbpzTg1XB9/2BY53V5itkp1kt6teE7+Z+c2fFIHdYSCwsa8+hZLRvlbjg=
X-Received: by 2002:a05:6512:3088:b0:549:8d60:ca76 with SMTP id
 2adb3069b0e04-54e8cc0bcd1mr1108764e87.38.1745607929522; Fri, 25 Apr 2025
 12:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250424201927.2027257-1-paulliu@debian.org>
 <20250424201927.2027257-3-paulliu@debian.org>
 <5b1181bf-1398-409c-b710-dc07e4eaa9d7@gmx.de>
In-Reply-To: <5b1181bf-1398-409c-b710-dc07e4eaa9d7@gmx.de>
From: Paul Liu <paul.liu@linaro.org>
Date: Fri, 25 Apr 2025 20:05:17 +0100
X-Gm-Features: ATxdqUH1lhIFYl8JeigcOj7zplBcQQ_G1FbGDvgVHa_TVjptvYyYe6un5TsyQvw
Message-ID: <CALG-KHz+spRA68RyzCUhWM4m_D2VoVLmiKJz85thuUbKyu6gOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
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

On Thu, 24 Apr 2025 at 23:02, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:

> On 24.04.25 22:19, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
> > debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.
> >
> > This feature is described in UEFI Spec version 2.10. Section 18.4.
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   include/efi_api.h             | 24 ++++++++++++++++++++++++
> >   lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
> >   2 files changed, 40 insertions(+)
> >
> > diff --git a/include/efi_api.h b/include/efi_api.h
> > index 5017d9037cd..0f4245091f1 100644
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
> > @@ -564,6 +568,26 @@ struct efi_loaded_image {
> >       efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
> >   };
> >
> > +#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
> > +#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
> > +
>
> All structures and unions and their elements should be describe according
> to
>
> https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation
>
> > +struct efi_debug_image_info_normal {
> > +     u32 image_info_type;
> > +     struct efi_loaded_image *loaded_image_protocol_instance;
> > +     efi_handle_t image_handle;
> > +};
>
> What are the assumptions about alignment?
> Should this structure be marked as packed like most UEFI structures?
>
>
Not aligned. This structure in EDK2 is not aligned, not packed. And it is
really not packed because the size of this structure is larger. 4 bytes are
padded in the 64-bit environment I think.


> > +
> > +union efi_debug_image_info {
>
> Why do we need the union? The first field of struct
> efi_debug_image_info_normal is image_info_type.
>
>
I just copied it from the EDK2. But we can remove it. I think edk2 wants to
support not only normal images. However, currently there is only a normal
image.
So it looks redundant.
I will remove this union in the next version.


> > +     u32 *image_info_type;
> > +     struct efi_debug_image_info_normal *normal_image;
> > +};
> > +
> > +struct efi_debug_image_info_table_header {
> > +     volatile u32 update_status;
>
> Why is volatile needed here?
>
>
The volatile is needed because we like the status to be updated immediately
to the memory.
If we are using a hardware jtag. And it stops the code at random places at
the beginning. It might have paused just inside these logics.
So this update_status is to tell the gdb python extensions to not
referencing EFI tables because it is not ready yet.
Thus this value cannot be optimized for updating later. And thus the
volatile is needed.



> Best regards
>
> Heinrich
>
> > +     u32 table_size;
> > +     union efi_debug_image_info *efi_debug_image_info_table;
> > +};
> > +
> >   #define EFI_DEVICE_PATH_PROTOCOL_GUID \
> >       EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
> >                0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> > diff --git a/lib/efi_loader/efi_boottime.c
> b/lib/efi_loader/efi_boottime.c
> > index 366bc0d2b1d..e2665459e44 100644
> > --- a/lib/efi_loader/efi_boottime.c
> > +++ b/lib/efi_loader/efi_boottime.c
> > @@ -4038,6 +4038,16 @@ efi_status_t efi_initialize_system_table(void)
> >       return ret;
> >   }
> >
>
>
>
> > +struct efi_debug_image_info_table_header __efi_runtime_data
>
>
>
> > +efi_m_debug_info_table_header = {
> > +     0,
> > +     0,
> > +     NULL
> > +};
> > +
> > +const efi_guid_t efi_debug_image_info_table_guid =
> > +     EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
> > +
> >   /**
> >    * efi_initialize_system_table() - Initialize system table
> >    *
> > @@ -4053,6 +4063,8 @@ efi_status_t
> efi_initialize_system_table_pointer(void)
> >       u64 addr;
> >       u64 aligned_addr;
> >       u32 crc32_value;
> > +     efi_guid_t debug_image_info_table_guid =
> > +             efi_debug_image_info_table_guid;
> >
> >       /* Allocate configuration table array */
> >       ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > @@ -4077,5 +4089,9 @@ efi_status_t
> efi_initialize_system_table_pointer(void)
> >                           (const unsigned char *)systab_pointer,
> >                           sizeof(struct efi_system_table_pointer));
> >       systab_pointer->crc32 = crc32_value;
> > +
> > +     ret = efi_install_configuration_table(&debug_image_info_table_guid,
> > +
>  &efi_m_debug_info_table_header);
> > +
> >       return ret;
> >   }
>
>
