Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573B0C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D1E81E8C;
	Wed, 19 Mar 2025 16:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m/2oY95+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD9981ECD; Wed, 19 Mar 2025 16:30:52 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0FA8141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e64405b3b9aso2083435276.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742398249; x=1743003049; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5y9q0IP03jqB32XunbPtc/B8Q99xYVZulCORJmMwGf4=;
 b=m/2oY95+jzBt12cRDADx82OZL6BlvracFZ8DPuSdlsl1njapMzOPD4w1qcocs45NFw
 WxVCRHsOkoW7tm9hrPXCm3z4V6mbIWjMvMUnEZikRokHUe8dgy6Cq/r75R8tMkv/6y1x
 gH3WGwH4TvHQKSwsc/m+TffRkX3Lz3W8rAspZtiNjXhe7AjAw+2bG6dkvhmLxUSolWld
 mHovT67z9Joh4pJpkhgsjGw5A64elCBXcGzM3j4TWao5hUE82Z2EvULmMkXvIBWQrBUX
 NbyQczkskMymKugdec9EFKCp/+Famiy66GoLb317iXFk7SH8iKzYVRtIbifWoglzQ+Re
 ouHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398249; x=1743003049;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5y9q0IP03jqB32XunbPtc/B8Q99xYVZulCORJmMwGf4=;
 b=plmw/eovh3QrCs/Frf6w3ZnaiRxoOvwcBVlqjxNmpTiLfBWK5Qs6GcDJUGSnTtqAJU
 YV3gBGH5QDyHHEb+0q7NB3EKJymx60rlo1DXZkdyJH1YrsRrgzeq1t5sXvBQWq6yh+e0
 IV8eiDBJ+Cj233U8cRA8pr4Xn0v46KTX34NId37NMFDGoxl6ySKVcXqt2QnHUf47Y095
 wO2qUxF+t6YHDWXCuedSeq9zm9mxpFxvwtHZ/Rw5YutBZJOAlFZwBN08QvZOiqDxpXH3
 Xn9s4JPAa6z/ZswMdoqaeoQYLu9SyiVymvdIpwtboh7Lv+P06c6vW/3ztsEGzBvQeqrU
 TIpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaHAMbCN1pRmi5TkdHujZ67ukSw/+9bX2MyPl1GmSjXUkzRpAAP9TZOyZg2gLA8RSdDo+xF0k=@lists.denx.de
X-Gm-Message-State: AOJu0YzLutfqzlRiFU/qsV23hfUSzTkLHoz7mSBD2QmyUbUBw97vpG0k
 zAH75cc7KYOgnTtbOzQy0KJpd7hTPTNezBkqy4sXvHApcM9SLr/Gisq6hD9rrF6JkjrLUKJa1i9
 0E//oOeW1BYls9lUlJ12oHze92f9xOTjdr83Gvg==
X-Gm-Gg: ASbGnct2hQZC/f/oCBBMeXgjoyYs9+br8x8wUKD/rCo3GNqyfthJ9d5h26ZG6LJhMGi
 gyhRD4XV+S6aWWpdaoXGDZJZEvW29tJo7qjbWBJ4czqUqOT4mO0a3S/XAft10/xJ3ke+ZitwfMz
 2cgI9mOLKiRjPmMkfqLbdyx4durok=
X-Google-Smtp-Source: AGHT+IFPOQqbrxzKCq0MnJz4HfXED1Y9wBZ01uU3Q0OiydM2MyUb9YSEj4pu2jXhOtl9LbExetJt4uyoA3ah5lAKoXU=
X-Received: by 2002:a05:6902:1209:b0:e61:10ff:f0a9 with SMTP id
 3f1490d57ef6-e667b3e3c8fmr3315321276.24.1742398248970; Wed, 19 Mar 2025
 08:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
 <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
 <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
 <CAC_iWjJUjpDR_jAKVBg0We9=s=2hvxp7f6Yh8C+KVWs099AL=Q@mail.gmail.com>
 <CAMGU2hUV1Ats4H56Tzqd0+RhOzB1i2BRLh5oCx8CNZrjbGRnSQ@mail.gmail.com>
In-Reply-To: <CAMGU2hUV1Ats4H56Tzqd0+RhOzB1i2BRLh5oCx8CNZrjbGRnSQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 17:30:13 +0200
X-Gm-Features: AQ5f1Joh-9S84bAhEzznBbNpMovbnY5Aa8FT00gJfRVOdPQOGcO8LtCGEnpV52Y
Message-ID: <CAC_iWjJyj8pqCwzf0UOOYwoYmgrErmNyidqXtegDXrchdFgPBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 19 Mar 2025 at 15:02, Adriano C=C3=B3rdova <adrianox@gmail.com> wro=
te:
>
> Hi Ilias,
>
> Ok, I will change that in a v2.

Ok i'll have a look at that

> As a question: in here it is a U-Boot routine the one that is doing the m=
emcpy of the initrd, the one implemented in the load_file2 protocol, the OS=
 never knows about this dp explicitly, could we technically use reserved da=
ta in here then?

Technically yes, but what are you trying to achieve with the reserved memor=
y?
The loadfile2 design from the kernel does not include a device path to
the initrd. The basically kernel tells the firmware "Can you give me
my initrd now in this buffer which  I allocated" and the firmware is
supposed to know what to copy in that buffer.

Cheers
/Ilias
>
> Il mer 19 mar 2025, 09:37 Ilias Apalodimas <ilias.apalodimas@linaro.org> =
ha scritto:
>>
>> On Wed, 19 Mar 2025 at 14:07, Adriano C=C3=B3rdova <adrianox@gmail.com> =
wrote:
>> >
>> > Hi Ilias,
>> >
>> > El mi=C3=A9, 19 mar 2025 a las 6:32, Ilias Apalodimas (<ilias.apalodim=
as@linaro.org>) escribi=C3=B3:
>> >>
>> >> Hi Adriano,
>> >>
>> >> [...]
>> >>
>> >> >   */
>> >> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, vo=
id *fdt,
>> >> > +                                     void *initrd, size_t initd_sz=
,
>> >> >                                       struct efi_device_path *dp_de=
v,
>> >> >                                       struct efi_device_path *dp_im=
g)
>> >> >  {
>> >> >         efi_status_t ret;
>> >> > +       struct efi_device_path *dp_initrd;
>> >> >
>> >> >         /* Initialize EFI drivers */
>> >> >         ret =3D efi_init_obj_list();
>> >> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *im=
age, size_t size, void *fdt,
>> >> >         if (ret !=3D EFI_SUCCESS)
>> >> >                 return ret;
>> >> >
>> >> > +       dp_initrd =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, (ui=
ntptr_t)initrd, initd_sz);
>> >>
>> >> Why do we need reserved memory? What the EFI stub does, is allocate a
>> >> new memory buffer which you later copy the initrd to.
>> >> I think Boot Services Data is enough.
>>
>> I meant to write loader data*
>>
>> >
>> >
>> > dp_initrd is freed when the efi application returns in efi_initrd_dere=
gister. Do you suggest to change it to
>> > Boot Sevices Data and when the efi application returns just assume tha=
t it is freed?
>>
>> You will still have to free it on failures which is what
>> efi_initrd_deregister() will do once we return from efi boot manager.
>> But if you define it as reserved memory, it won't be usable by the OS.
>> Since linux will eventually copy that memory in a buffer it allocated,
>> you don't have to preserve it. So you can just define it as
>> EFI_LOADER_DATA
>>
>> >  I took the usage from:
>> > https://github.com/u-boot/u-boot/blob/8bc3542384e3a1219e5ffb62b79d16dd=
dc1b1fb9/lib/efi_loader/efi_bootmgr.c#L514
>>
>> This is a different use-case. In this we download and run an EFI
>> application from memory and I guess the assumption is that the EFI
>> application will return so the type doesn't matter that much as it
>> will eventually be freed. This obviously is not the case if the EFI
>> application is a kernel.
>> That being said, I think we can switch this to LOADER_CODE as well.
>> Heinrich any ideas?
>>
>> Thanks
>> /Ilias
>>
>> >
>> >>
>> >>
>> >> [...]
>> >>
>> >> Thanks
>> >> /Ilias
