Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A21C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51089819B1;
	Wed, 19 Mar 2025 13:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nHuAkqWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40EED81A04; Wed, 19 Mar 2025 13:37:51 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8C38193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e63c3a53a4cso5621380276.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742387867; x=1742992667; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pRGLJsc++VpjnwME7Q3HmGipqLkHlUdD6APJm/FcNk=;
 b=nHuAkqWVHuFgxOhSLCbnui0FlBrggvuXNpPm5yZQuCUEMbaKr6BAD/v5GTwnGfDtcu
 B3boIXMp+BnB4Jzldo6z/91P7O1o2reRca/KPg5uy6WyJdlgpDVTdjgJtgmKPMBAARcs
 z0VeZvmEKlIIsarJ7dBvdkAoLCYz9nv+TXXJAHF6ZVzbszDl/hb/nJaxgecYNL/mEE97
 1sNSMgF9t+648g66ZixbL/ATvXmAqHPqpLM5xc2l5Hb9ne+McleUWHXBRIcEDBmFPPgl
 QgyyJ49JpnvIPaCRJ5tiN3Vwan5Kp/Pkn2ncnrkaNBbFhOuy/BN1IaS66MpbioHFoBFD
 SL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742387867; x=1742992667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pRGLJsc++VpjnwME7Q3HmGipqLkHlUdD6APJm/FcNk=;
 b=JgA38NypThbzUhxnT61pPrY3zD+RF5jXH7S7zAfFuSifhAFyE8bzcaGztabkZ+JoWr
 12slHCGgfi5p7nY0AhfwDXkCYdLcy8lLYRbxF3GZtFOE203Q66dIbonyJt8fkAm9BC/r
 eUrupWX6WKFZyTOOcIy3HIEoT5W29OYXs4/hTn47QBcULKIiTolxrmC5DWm+lAsPEGwq
 sv2ohJw2c8zd/49h6244xBtznfNJO2sTOi6isCLU2cPsmiMTJlVvBaKG5T5nMnRnxNyL
 l112It9W3EwEh9TQVQt2p6f3UZBbV0ewAb98Tb1iHtUcoClyjvmE/pU5dNg0nhJghEKq
 BOmg==
X-Gm-Message-State: AOJu0Yzi/8kJVq54jU6weZkZkE+ShB1MJYLZ/AntVllCUJAp6ZBdi5/L
 6woHQ+zu+UxEqpE3xfowGFJ/EbSoRMpzSofdXG3bDPj2WaqwgtFejysUx+CBj67nToVbuVRCT8+
 vv2XK7szL3j+N/gz1HY1+sDH+jaGz7Fp+4mj60ubvoJrlGk9bHl0=
X-Gm-Gg: ASbGnctA5uAKKx7pWJLO3z3YkPo6KJ++i6koF00kHZEAFMAW/YwYnPsUP3yZwfPd04L
 MpvyfdvumBnPo1QnX/c6uSbHpFGL1plB17yHyQyNLEqnUnpf/73rWeb7imquHodefLFUOx1bul1
 WTHLz2GIcFdiygu4TcfcwIFp2nn5g=
X-Google-Smtp-Source: AGHT+IFjGxeYu6xvp3CQJTIorBc+rCsSA4CxYO8TnQohhHpIx2WMDXvfrtHAZiIrsV9ULtEdge7drVKJILwibVbMmYA=
X-Received: by 2002:a05:6902:2310:b0:e63:f29c:d5a2 with SMTP id
 3f1490d57ef6-e667b44909emr2950895276.41.1742387867400; Wed, 19 Mar 2025
 05:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-3-adriano.cordova@canonical.com>
 <CAC_iWjKA8tzKdcRSUPWVdDkRNf2GEiz6dzbM6J6A+f788QqyJQ@mail.gmail.com>
 <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
In-Reply-To: <CAMGU2hXE2gzQs7iibLMB66jJAL5qXm9CGpx5cvJ7AGP5vg8nFw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 14:37:11 +0200
X-Gm-Features: AQ5f1JpAxZUk0E-ROGmBq2dqIrIM8qZTM3IIxydroKCJPWrLK9x6c0uAKIMWhRk
Message-ID: <CAC_iWjJUjpDR_jAKVBg0We9=s=2hvxp7f6Yh8C+KVWs099AL=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_loader: binary_run: register an initrd
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>, xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com, 
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

On Wed, 19 Mar 2025 at 14:07, Adriano C=C3=B3rdova <adrianox@gmail.com> wro=
te:
>
> Hi Ilias,
>
> El mi=C3=A9, 19 mar 2025 a las 6:32, Ilias Apalodimas (<ilias.apalodimas@=
linaro.org>) escribi=C3=B3:
>>
>> Hi Adriano,
>>
>> [...]
>>
>> >   */
>> >  static efi_status_t efi_binary_run_dp(void *image, size_t size, void =
*fdt,
>> > +                                     void *initrd, size_t initd_sz,
>> >                                       struct efi_device_path *dp_dev,
>> >                                       struct efi_device_path *dp_img)
>> >  {
>> >         efi_status_t ret;
>> > +       struct efi_device_path *dp_initrd;
>> >
>> >         /* Initialize EFI drivers */
>> >         ret =3D efi_init_obj_list();
>> > @@ -230,6 +234,14 @@ static efi_status_t efi_binary_run_dp(void *image=
, size_t size, void *fdt,
>> >         if (ret !=3D EFI_SUCCESS)
>> >                 return ret;
>> >
>> > +       dp_initrd =3D efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, (uintp=
tr_t)initrd, initd_sz);
>>
>> Why do we need reserved memory? What the EFI stub does, is allocate a
>> new memory buffer which you later copy the initrd to.
>> I think Boot Services Data is enough.

I meant to write loader data*

>
>
> dp_initrd is freed when the efi application returns in efi_initrd_deregis=
ter. Do you suggest to change it to
> Boot Sevices Data and when the efi application returns just assume that i=
t is freed?

You will still have to free it on failures which is what
efi_initrd_deregister() will do once we return from efi boot manager.
But if you define it as reserved memory, it won't be usable by the OS.
Since linux will eventually copy that memory in a buffer it allocated,
you don't have to preserve it. So you can just define it as
EFI_LOADER_DATA

>  I took the usage from:
> https://github.com/u-boot/u-boot/blob/8bc3542384e3a1219e5ffb62b79d16dddc1=
b1fb9/lib/efi_loader/efi_bootmgr.c#L514

This is a different use-case. In this we download and run an EFI
application from memory and I guess the assumption is that the EFI
application will return so the type doesn't matter that much as it
will eventually be freed. This obviously is not the case if the EFI
application is a kernel.
That being said, I think we can switch this to LOADER_CODE as well.
Heinrich any ideas?

Thanks
/Ilias

>
>>
>>
>> [...]
>>
>> Thanks
>> /Ilias
