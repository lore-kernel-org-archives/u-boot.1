Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58EEC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39A287782;
	Wed, 29 Nov 2023 18:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IdFRVG4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE608761F; Wed, 29 Nov 2023 17:30:04 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E473A87008
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andy.shevchenko@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d81fc0ad6eso2519525a34.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701275398; x=1701880198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT5676cA2DX/LCu0ushW+z08psx2OtpvhOnd3AGnYIM=;
 b=IdFRVG4all/uOEEiw/jfQBpPPMbSH6GRTfbsCgPeAmaBvL9xe0hBceXVEAmw8l97I+
 hUod8CsU1IuFnPLEC426EkEM/b/BxoMsQ7ShPbFCo3Ej2xUaLZr+hVjKizlfcGZyIpj3
 kxQXStky0AWqjBOFkYJJGJHuHfgPH0PMGFpeAsgRtOoM1x5FxnaJ2pdBUN5/YCQ4hvsx
 RirsYWvQVbYDUNe4glpE7NsKylrgHk2j/RJgvstRrpkjqqHUqjMgswfVmXzTYHNbDE+2
 l0NxvcYqqGFrAjipih4QqkaS6xJfE1j5O4wu0c4zzRy7byUYBTNmxf1sEFv3SZN1YBCp
 9GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701275398; x=1701880198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT5676cA2DX/LCu0ushW+z08psx2OtpvhOnd3AGnYIM=;
 b=kqhwuoaofyS+EVSm35S0NfoYeWAPaZwxzQVT9QpyrhMbYJucLAM1Bvwla682DfRwBz
 As8jJQioEJDSiVSrCC3iLde/0yKdVgzKNZyj2FJBJQdB7a19vFbD2y33Gilu/l8mqx8W
 brUeeZI/2mzZAW2AeDr59nzOmutQonyXui2Bz68IOvotBO2XL8+2uXCJQWbKo3eTvgQF
 hG4XMqUzjdVD9s+lsDuVVP7tqR3F8xHOc9zpo5rwdTRaTYI80GxRnU72fI2+MPEJTlvA
 2yYUq6E4gyYOojXb5YVx7iaTaqrifaX6kD/Mbizt+KouiiOMDZ8LaFAxdVCImZ7zRJjM
 7HFg==
X-Gm-Message-State: AOJu0YxT62rQgotpazrWXtHwm7ln3gZ3UdMYA5fM+EL5777gk3wLMKGS
 AMLEBqs0eopoAJGsQbiFd5N0jjK2li2kCHXv9cA=
X-Google-Smtp-Source: AGHT+IEnJy6geyrLFtL5YoUdApIy3kUjuxehQ163XzEYEpdfAsXsbV10uvQbyA0KOgLBu19FptIx4yKEKpZWLEhgeck=
X-Received: by 2002:a05:6358:998a:b0:16d:e923:573 with SMTP id
 j10-20020a056358998a00b0016de9230573mr19444984rwb.15.1701275398319; Wed, 29
 Nov 2023 08:29:58 -0800 (PST)
MIME-Version: 1.0
References: <CAK9R8u_QmcHLv6KbNm8+8EDvnmgehFZfoPNVCVn8n5P17ArErw@mail.gmail.com>
 <CAHp75VeD9pE85aU5MMROJvbPiboOaoeWnLE752=0YXxS9-jnRw@mail.gmail.com>
In-Reply-To: <CAHp75VeD9pE85aU5MMROJvbPiboOaoeWnLE752=0YXxS9-jnRw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 29 Nov 2023 18:29:22 +0200
Message-ID: <CAHp75VdwJJPNoNfvC9muSPxCCXno_9PppXkp4RPqYP_eOVp2AQ@mail.gmail.com>
Subject: Re: Setting up boot chain ACPI on ARM with STM32MPU
To: Ba Gia Bao Phan <phanbagiabao2001@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Nov 2023 18:00:17 +0100
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

On Wed, Nov 29, 2023 at 6:25=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Nov 29, 2023 at 5:29=E2=80=AFPM Ba Gia Bao Phan
> <phanbagiabao2001@gmail.com> wrote:
> >
> > Hello everyone,
> >
> > I am a trainee at STMicroelectronics France. I am working on a project =
"Setting up a boot chain ACPI" for STM32MPU, which is based on ARM Cortex-A=
 . The objective of my project is to add a way of booting (with ACPI) besid=
es Device Tree available on STM32MPU.
> >
> > I found that ACPI was enabled on some x86 platforms
>
> I believe you meant here the niche of the (x86) platforms that are not
> ACPI-enabled. By default 99% of the x86 platforms are ACPI enabled
> with the exceptions:
> - Intel MID (2010-2015, SFI based, enabled in U-Boot)

For the sake of completeness it was started in 2007 according to the
list https://en.wikipedia.org/wiki/Mobile_Internet_device.
And
- Intel SoFIA (2015)
is missing and I don't even know what is used there for platform descriptio=
n.

> - Tunnel Creek (2010, DT based)
> - A few SpreadTrum SoCs (2017, DT based)
>
> > but I don't know whether it was set up on ARM or not. I found a PATCH t=
hat discussed Enabling ACPI booting on ARM with Raspberry Pi 4 but I don't =
know if it functioned or not. Did anyone here succeed in setting up ACPI on=
 ARM by U-boot?
> >
> > What are the differences between x86 and ARM platforms when enabling AC=
PI? The architecture of my board STM32PMU is ARM so can I apply the techniq=
ue used on platform x86 for my board?


--=20
With Best Regards,
Andy Shevchenko
