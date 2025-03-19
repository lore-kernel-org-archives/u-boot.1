Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9EDC36000
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE9F81951;
	Wed, 19 Mar 2025 13:07:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMA09Sxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986A481A04; Wed, 19 Mar 2025 13:07:50 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D63C81101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so7411886a91.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742386066; x=1742990866; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ebwMd9GByAWbpOPRdXis0UqqwgeOtCNHWr3p40yBC7M=;
 b=YMA09SxhiHnSu/eeEGHV/MJBRk/IWp3lqkBHYn9ncIHDYEUnN8C4k0h+6R2giknVHK
 p5HqdUK3cFIVD2rZPUSDHaukN36THo49BzxSZen8kUpB0OWeUEU52ymXjGoQfO0GA1ke
 Uwr9msbZDxm80yJzD7kG/T+Vd1D77RnuK4qFhv2TN4yCIPifUJ/1aAxMdnK+EdbCfo8s
 aoq7OeT2jCMe+o2/LsPx7M3NM0sxV7NUNl0w3mvRhEhPdo1IiDKQS5VQJpAKGb3QpfuY
 infgGOmhCzy0A4CK0grqzrp0tUid+c99bD0tUCexdDCOr9gR7wAfOlVKhqnpdwMV8T7u
 lT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742386066; x=1742990866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ebwMd9GByAWbpOPRdXis0UqqwgeOtCNHWr3p40yBC7M=;
 b=RRxJ0zeyiNNyMNBWi/jUEiSGtP/WYF10opmCsUxXKrqh82zrpPRd47wo+FcSTMiVrv
 rblDueE379FCi87/C4k84BEQUDvHe9SVCVlzRZu55d9P/4g+fcCAP9i7eb2Zi7AhBi0W
 G0GraS9SOL7xc6p8LUJQ7/qG9GC5kM/ngWGgbr9ZJz7vdRUjtFuXpv5gBOnOWUiU9mp6
 xzRcOKPDT+1Ql9no9NStuFX9yRNAm7Me2g+EvxUAVUHXAPq2mJa2RFWiUQo2CP0WLYZo
 tsEWrvaMjn5JJH/v8wZrRYF4Fy1UdJzD5buHpBeppUbxUvkXfUICzVnEdvsIWRAPVuek
 c23Q==
X-Gm-Message-State: AOJu0YxTcRuue3TM+10CgWyBEWCEjPlkTYs4XJ2fL8OFg2UeYxxoVkkY
 YOqbQW0KeQ3RKRaC1Ut0A/yMgawWpkFBVrTMYnekJkh2eG/aGeNHaK0UF2xxWS/YlVaPUhOh+59
 QSfLDf4YjFylQPStml/pI3jh7GdQ=
X-Gm-Gg: ASbGncs6Cg+52sjfAB/EkUlASkHNGHe7qnu8jgSogi9j/Gfr6waAeHNTG1ZIkoDInfl
 n2NEiwqK5C3pSgCEROc0XJo/e+QAN2LeboyEZzvchoyOgXxfv8V4lhD1UouGcByKgDdMTUj31hl
 XPaUJAWiAhEO9hXezep0muxOEuF30=
X-Google-Smtp-Source: AGHT+IGBJUvlaf4zVLEybSmFv6oebVi5AvjOhxsogJYHDuMWmD0xPWdcS+dmjjUe0AV96gqrI8Q0OA2DgjL1BHWEq2A=
X-Received: by 2002:a17:90b:5288:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-301be21ff45mr4296287a91.35.1742386066352; Wed, 19 Mar 2025
 05:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
 <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Wed, 19 Mar 2025 09:07:57 -0300
X-Gm-Features: AQ5f1JovUeJ42TCxm96wVO9yte03lygfsmhvbHq72OtXzR_-BlgTOu1sLClwlWk
Message-ID: <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ilias,

El mi=C3=A9, 19 mar 2025 a las 6:32, Ilias Apalodimas (<
ilias.apalodimas@linaro.org>) escribi=C3=B3:

> Hi Adriano,
>
> [...]
>
> >   */
> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, void
> *fdt,
> > +                                     void *initrd, size_t initd_sz,
> >                                       struct efi_device_path *dp_dev,
> >                                       struct efi_device_path *dp_img)
> >  {
> >         efi_status_t ret;
> > +       struct efi_device_path *dp_initrd;
> >
> >         /* Initialize EFI drivers */
> >         ret =3D efi_init_obj_list();
> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image,
> size_t size, void *fdt,
> >         if (ret !=3D EFI_SUCCESS)
> >                 return ret;
> >
> > +       dp_initrd =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE,
> (uintptr_t)initrd, initd_sz);
>
> Why do we need reserved memory? What the EFI stub does, is allocate a
> new memory buffer which you later copy the initrd to.
> I think Boot Services Data is enough.
>

dp_initrd is freed when the efi application returns in
efi_initrd_deregister. Do you suggest to change it to
Boot Sevices Data and when the efi application returns just assume that it
is freed? I took the usage from:
https://github.com/u-boot/u-boot/blob/8bc3542384e3a1219e5ffb62b79d16dddc1b1=
fb9/lib/efi_loader/efi_bootmgr.c#L514


>
> [...]
>
> Thanks
> /Ilias
>
