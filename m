Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEE0C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 10:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3F181CF0;
	Thu,  3 Apr 2025 12:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BfI9WrSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DA381FDE; Thu,  3 Apr 2025 12:57:40 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C306780194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 12:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c592764e54so90055485a.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1743677856; x=1744282656; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GHreZ6K1tVv5cSe2Qw9VwYQHS2gPIlvK+MUMez+BuxU=;
 b=BfI9WrSKTMn68Bv4U5jVMEXHdcxUP29szprF+5YKwxswAF31cDb7eYLytl1BSHFFdS
 c6+1vg04hpzLH+yKdrraSf0flLtgNpBKCrF0N7xEUSLXP1cJCQSWiC7TLdkWePGxdrtF
 oiBTMpcafA0fcrgDaIX1Rhl0z/Bi+FSCtPuYIHnRXaIWEjX7GGCg9tNLGgod62HLK6KC
 Bi839rj3rkuzF4/wF3g6e7grHTTHqapWz1XX8alQFgzbV+5QeFQlxoPuRFNjOlS41kmP
 pYeBTqu6+u+3bBkXfBBGUDu2D/A/OSzlj8zjohl8zEivBDOwScxXIEEw5b0UMOs5UKlw
 142A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743677856; x=1744282656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GHreZ6K1tVv5cSe2Qw9VwYQHS2gPIlvK+MUMez+BuxU=;
 b=wgUy6lu/bYC4oit+3JyuNNN3RbT9rpYJpp6xo06r6p+7HZ58uItcUt0z0bT6uMQCch
 yZzqjloYhQxqEteBmBL1sEiAKeYnCfHKjv1zTC2uqIE5r7ywMV7VdtiHKutWM9cslZ4Q
 s7esF9b/0wkzdPgkpHy4nM+EA6A5LmXIag6B+fhzXyPuz/po+JjP0FU20EwbRqVADsun
 OeLzBrKVA7FDHhH8J6MBZo6+K2xvYRC+dX3QPU6JvtGJVw30Ngl/15v7XFT1nAu1hNyS
 IFnwDaMM/HEE0CYsnqvzqtqNmc78eUJK4Ay0ewZX/vfrxcplG+qgEavWkYtptOFi85mc
 Tz3w==
X-Gm-Message-State: AOJu0YzBFZbPXD7fMxgPC9+03wWF8q8sVwWofbwVB4nqFIBqEmYmmIxy
 UAu3PVyqt+FVgnzT77yJjL0PyK8AxwJuNW4VwHV3vswvP4fenJUsrbDTdYWw8NUkYQRy6iq46Wj
 aJFt+i1mvjA0CqhwkhFjB4KKCix6IWBEUSOZ1kw==
X-Gm-Gg: ASbGncs2YFNmcRrbUAUYUl0hGjkIC6Ot7A7eXEIodsX5V+U5mKtLQ2qx5omnS+3ZbBt
 lsQenFZyK88fkIVZtATGSOPM44CfNM6TWAG1w+27LoXy5Wav2MMD+kG5L+2TLzdq14W0ubFCTjR
 7KQH6zwEPoi+VFCACaOKYH92pVbFE=
X-Google-Smtp-Source: AGHT+IHV6d//9SSg4Yx3g1O/xgU592Q/1abQLIZSkRth7ZRyTQhUnLIFUqgTY+7Luq8VtfXuRNrSoScOZAKZgduK1VQ=
X-Received: by 2002:a05:622a:1a02:b0:476:6a3d:de2f with SMTP id
 d75a77b69052e-477ed7283f9mr239099911cf.42.1743677856694; Thu, 03 Apr 2025
 03:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250311133506.124914-1-mchitale@ventanamicro.com>
 <20250311133506.124914-2-mchitale@ventanamicro.com>
 <CALUeBeDZFnKHT14FwrpmhqzFDOO3vCzqJA8XRTzAEdCwOSApRQ@mail.gmail.com>
In-Reply-To: <CALUeBeDZFnKHT14FwrpmhqzFDOO3vCzqJA8XRTzAEdCwOSApRQ@mail.gmail.com>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Thu, 3 Apr 2025 16:26:59 +0530
X-Gm-Features: AQ5f1JrtfWeSC7vx2BgrnKt3i1PPs708A5w8nAHL_wIQOPgAnt6zCxdmvfZu2z4
Message-ID: <CAN37VV5fSHBKHpdg4kf-DPsF=VFAR=dnE+4OiWwmPZP6EvH3Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] riscv: image: Add new image type for RV64
To: =?UTF-8?B?0JzQsNC60YHQuNC8INCc0L7RgdC60LDQu9C10YY=?= <maximmosk4@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Wed, Mar 12, 2025 at 5:21=E2=80=AFPM =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=
=BC =D0=9C=D0=BE=D1=81=D0=BA=D0=B0=D0=BB=D0=B5=D1=86 <maximmosk4@gmail.com>=
 wrote:
>
>
>
> =D0=B2=D1=82, 11 =D0=BC=D0=B0=D1=80. 2025=E2=80=AF=D0=B3. =D0=B2 16:35, M=
ayuresh Chitale <mchitale@ventanamicro.com>:
>>
>> Similar to ARM and X86, introduce a new image type which allows u-boot
>> to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
>>
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> ---
>>  boot/image.c    | 3 ++-
>>  include/image.h | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/image.c b/boot/image.c
>> index abac254e026..03d5e59b634 100644
>> --- a/boot/image.c
>> +++ b/boot/image.c
>> @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D {
>>         {       IH_ARCH_ARC,            "arc",          "ARC",          =
},
>>         {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_64",   =
},
>>         {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",       =
},
>> -       {       IH_ARCH_RISCV,          "riscv",        "RISC-V",       =
},
>> +       {       IH_ARCH_RISCV,          "riscv",        "RISC-V 32 Bit",=
},
>> +       {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 64 Bit",=
},
>>         {       -1,                     "",             "",             =
},
>>  };
>>
>> diff --git a/include/image.h b/include/image.h
>> index 8a9f779d3ff..12b31166e86 100644
>> --- a/include/image.h
>> +++ b/include/image.h
>> @@ -139,6 +139,7 @@ enum {
>>         IH_ARCH_X86_64,                 /* AMD x86_64, Intel and Via */
>>         IH_ARCH_XTENSA,                 /* Xtensa       */
>>         IH_ARCH_RISCV,                  /* RISC-V */
>
>
> I believe s/RISC-V/RISC-V 32 bit/ is more explicit.
> Looks good.
>
> Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
Thanks. I will update the patch.
>
>>
>> +       IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
>>
>>         IH_ARCH_COUNT,
>>  };
>> --
>> 2.43.0
>>
