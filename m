Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4F1C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:18:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A96D8193A;
	Wed, 19 Mar 2025 13:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FtiPA0dB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D6F81A04; Wed, 19 Mar 2025 13:18:54 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007DF815D1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:18:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e53c9035003so5164922276.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742386731; x=1742991531; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SE9fPwScjdbQN+Dsf39vlztAjMvJA9XVgMWHjMQW6yc=;
 b=FtiPA0dBSUrjYKV/NtYaEvHNiccieZd1HqeY/U6xG209LWRMUW7VzFUQRRb1Fw9BeR
 q2z7pwq2RXs8fy7DL34FaPGfxI9HHXFGrdRpgzQ4x1KOjb54If5tUfVA0rXXUJ2NTeD1
 BmL1vjNT4MsexzZ7Ko6JAKo9e9Fu5L2KqGLSh7u/zyldw+tpV0diXHMa2feP7mCaYxzT
 t2iAwLJZpsb7d7nk7ESf8R5qh2U5m0FUmVW/oFYY6QmB2jNQjxdAvDGT/JHHDighA9vT
 ggQQWqbdMDjrXeg7E1frVLNzfmbew2Q+SWp9Sk0O1c51G7AEo+mRao4owogO2j6+3WdO
 SydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742386731; x=1742991531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SE9fPwScjdbQN+Dsf39vlztAjMvJA9XVgMWHjMQW6yc=;
 b=w68wdCfCPGIJNaabGpOCMPVPclzmZhAZusYdZ0J1MNFQTAxhrE/BA3c15zTSSal4eS
 oDWhfW00leNRQfeD7b0v55sFMl1Rl7JyK8UtzcH5SQqdKYg77y94GiXrnGy1pNfpsFSK
 zCwvIOoAfcoqB/TcUg3AtyqzJqB2YaerRonpfIBt1Ic3YR6qknhnTnF2w3kU+byJZRlE
 nzhwqGqN6Zcf3Dox4xTfTw40YzT6b3wCCBMsJU8BOvcPhJqnMz7rEbA4Sde7wvKqMbmT
 z1oAn1Fq0/fdRLaEQsRfP9M70sjiyY/Xadz96KbWY64pWW6OqSLIbXsMbxMMcoBe2MRS
 fP8g==
X-Gm-Message-State: AOJu0YzZAUTRSUxxP9MMN6Vl0prN+46EyRlgkqJHOv6iEF5DQvL2hWwb
 dvT9BCwJyU31fKtlqClMbmurJ00Iw1IXJzP33A8y0RC8vep2Ksv0RVz79IsJp9UYmqtHNz0ER27
 f0riO/1rcnogxnV9XqgmpFqf2/ytw4CxNr/Ho+w==
X-Gm-Gg: ASbGncsC1tZ745Q3v/D8oAT8YMlqzzrZbacvDxZvAS0YoeJNfDadD0RpBn5fIXvBKzN
 dMPcNz6kXoyMyJ0keoPE+vXovAlPMk5s8AcSPFPrtCeGgMmlf6bXvAv2nvfM7Gwd3y3eD+4CFHK
 L8qqoNgu9UtR4802qwo0dm4FgfxP4=
X-Google-Smtp-Source: AGHT+IFnXWmOsS0uhDYZ8DAmGLhy0r+RHrwE8E8Ck5bwRmzg7tAiW65tjh3EK8CsW2ZAD1F7Fd3GBVJBZ9PlXxLqdtI=
X-Received: by 2002:a05:6902:843:b0:e60:9dd3:38c9 with SMTP id
 3f1490d57ef6-e667b3a4751mr3008816276.7.1742386730836; Wed, 19 Mar 2025
 05:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <CAC_iWjJgS2oudWw7DTDW4uPtaGvw8MSdzo1VyswX8CLYD9dL0g@mail.gmail.com>
 <CAMGU2hW4Axz3vkqcDFFNYMxW2JQxNRoNxvAZ2mrMrQGC78NQYw@mail.gmail.com>
In-Reply-To: <CAMGU2hW4Axz3vkqcDFFNYMxW2JQxNRoNxvAZ2mrMrQGC78NQYw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 14:18:14 +0200
X-Gm-Features: AQ5f1JrvyXm0GUIkSegF7ypclFSdkyX9irGJa-iB2_aOhpjetL7TOAlPIN5Q6s8
Message-ID: <CAC_iWjK4+tqogut0YQ7KZOVwMKawzfC3D+79iLZ=sxSGw7Piig@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add initrd support to bootm EFI payloads
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

On Wed, 19 Mar 2025 at 14:12, Adriano C=C3=B3rdova <adrianox@gmail.com> wro=
te:
>
>
>
> El mi=C3=A9, 19 mar 2025 a las 5:48, Ilias Apalodimas (<ilias.apalodimas@=
linaro.org>) escribi=C3=B3:
>>
>> Hi Adriano,
>>
>> On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote=
:
>> >
>> > Next boot stages can acces an initrd via a handle with a specific devi=
ce
>> > path and an EFI_LOAD_FILE2_PROTOCOL installed on it. In U-Boot, this f=
unctionality
>> > is currently only implemented when booting with the EFI boot manager. =
This series
>> > implements this functionality also for the bootm command when the os i=
s of EFI type,
>> > e.g. when booting FIT images with an EFI kernel.
>>
>> I'll have a look at the patches shortly. I have a question about the
>> entire series though.
>>
>> The initrd was plugged into the efi boot manager because it's easy to
>> configure entries of
>> kernel-initrd-dtb. The initrd can also be loaded by passing a kernel
>> command line parameter.
>>
>> That parameter can either be initrd=3D<file> with the limitation that
>> the initrd needs to be on the same filesystem as the kernel image.
>> On newer kernels you can also pass initrd=3D<device path>. I am not sure
>> what's the best option when loading the initrd for a FIT image.
>>
>> Thanks
>> /Ilias
>
>
> Currently the initrd in FIT images with EFI os is completely ignored. It =
can't be passed as initrd=3D<file>
> because it is not a file, it is just memory mapped, and I am not sure if =
it can be passed as initrd=3D<device path>
> as I am not sure if the kernel expects a file system device path or if a =
memory device path would be picked
> up.
> In this series the functionality is added following what bootmgr already =
does, which also works for passing
> the initrd to a boot stage that understands EFI but not command line, but=
 investigating the other way is also an option.

Yea, I don't know if loading it from a memory-backed device path is an
option either. I am fine with the current idea, I was just wondering
if we specifically want EFI LOAD2 or just find a way to load it.

Thanks
/Ilias
>
> Thanks,
> Adriano
>>
>>
>>
>> >
>> > Adriano Cordova (3):
>> >   efi_loader: efi_load_initrd: provide a memory mapped initrd
>> >   efi_loader: binary_run: register an initrd
>> >   bootm: add support for initrd in do_bootm_efi
>> >
>> >  boot/bootm_os.c                  |  4 +-
>> >  cmd/bootefi.c                    |  2 +-
>> >  include/efi_loader.h             |  4 +-
>> >  lib/efi_loader/efi_bootbin.c     | 20 +++++++--
>> >  lib/efi_loader/efi_bootmgr.c     |  2 +-
>> >  lib/efi_loader/efi_load_initrd.c | 71 +++++++++++++++++++++++++++----=
-
>> >  6 files changed, 84 insertions(+), 19 deletions(-)
>> >
>> > --
>> > 2.48.1
>> >
