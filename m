Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86743CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 07:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54E28206E;
	Mon, 29 Sep 2025 09:28:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2K8piSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC43583071; Mon, 29 Sep 2025 09:28:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5147808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso3306341f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 00:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759130930; x=1759735730; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea9p35L7/dF9QE5UBduJpJZXxyEPrYqAMQfcZ8B+xOw=;
 b=m2K8piShmdvLu90ACZa7MscfJsKqPw9T8oGPgHwlBHw4YzXfG6Dnx/wLH9l67ObEjH
 HpaQEkAqendPIqrFKpiuZlHcuyktDt0h9/qM7mXckSb5maZv0ujyBoVCSdWzuOmDqxYu
 HN5tWypNt8//NoTQcOuhs5KqMPtODcxPWzMd5H46RDoVMGk9setFXpMc/9S9MGnlQNSz
 twvfqiEGSBBw3Y7Pjj2DXwE0CKrADgiBnMBjQ3IarqXmwzfkandiegEpmx6ncudV16CV
 UYhKYtkf3IxEdxCc0Pa+HFy3A3TGZyA+uVFNV5gHjkCtccYehLQ/fnRpWZ4p6vHDDViV
 6nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759130930; x=1759735730;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea9p35L7/dF9QE5UBduJpJZXxyEPrYqAMQfcZ8B+xOw=;
 b=SmnS6JPCnhgcVNeJXZTU5u/Wg3pqgl0j5qtydI4cpKRLeGukRYWtlxZfE2+ajzVuah
 03PRfPDTUgv6tpoY3jpccGJ1YdJICgTj8tZnYsyuSxqumo9QpwD8dJfjX7Uxv731KMGz
 T9KPlnK43zMz8wNWbIpqRisrHy83ser5iT9IsQj8ltr/gF9HBKa5Ur6G8/9FruQDWD9o
 s4m6Ml7tZK/JFYcdNQj99Cj+TKf4ZGw/KoJRjwNksD2fAbR2FQk9uouY+Z4T1gntX74+
 jGQnaZIHs8qI2uL/nLoyCqaXrDcUiBtybudVyWM80VO4wwa+fnGQgnRh0pCWnYLoPUVJ
 rLZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1nQ+h6qoGGFUPSk9eIXMNlVK4U72h2BUseCvfXGuIAKLA05AsBLfmZOEgePVhYNjdFAle948=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn5Hkeilorz4uZleUSY0m0HUIQgWktyhjBbJfn2hADCHImxMtz
 X7Z51rLyr+kU1PlMa7S/2b+Gini9pqV9l70WZ8MYKbav3M9f6uZShMGsYftoDu58Ej/ckSMGOUN
 6N8JtheaTAIMihJo02YuXprMNd0YVKIJ8kLB4
X-Gm-Gg: ASbGncuxvzn0xbsSDAStaTddeqD1VG82JdV4xqiiGXSmUjyBxBPk3kk2f+7QzhzMI63
 E7yqapgnkhhpz6rbM3puqg9BUckLrvyyR85HxRiuSsbxWA9qOZ0C1KVfbo+YZSJFvO/tAIhpPOz
 1MVEnlWRTcsf7w/4k9ENzyZI8s3LKlVgx+X57Mlseg0STWsX+bwZu1/ZnRz/i+UIzyRth+VqJRO
 +v57mD2
X-Google-Smtp-Source: AGHT+IEjNDGy5UK+9GYB9zD63Q+3BYfU4CyPtmv3gV3G5xcjMLx3EEMzpN2LjCV5PCmTnrSYW+R7V3HI8AOY/zHznLE=
X-Received: by 2002:a05:6000:3101:b0:401:ae97:a1ab with SMTP id
 ffacd0b85a97d-40f60fdfc48mr14207079f8f.10.1759130929882; Mon, 29 Sep 2025
 00:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
 <20250929092338.08d6b00a@wsk>
In-Reply-To: <20250929092338.08d6b00a@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 29 Sep 2025 10:28:38 +0300
X-Gm-Features: AS18NWARnDDLnk3yrsJegOH6DZ-ZHQwXe2o_btD2jxikDmMUYydR3k8ulkjgysI
Message-ID: <CAPVz0n3mm=84C25tDXxGaXbe_Dxygc+kSoADtx3NvhZoanX=LQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

=D0=BF=D0=BD, 29 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:23 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:16 =
Lukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > This patch adds support for the .set_flags callback.
> > > For now following flags are supported:
> > > - GPIOD_IS_AF (i.e. "alternate function").
> > > - GPIOD_IS_IN
> > > - GPIOD_IS_OUT
> > >
> > > Currently, the .set_flags in gpio-uclass.c (function
> > > dm_gpio_set_value()) is used before .set_value callback, so
> > > functionally replaces it. As a result the corresponding
> > > tegra_gpio_set_value() can be removed.
> > >
> > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > ---
> > >
> > > Changes for v2:
> > > - Fix the format specifier for flags in debug() function
> > > - Update commit message
> > > - Remove tegra_gpio_set_value() method (as it is functionally
> > > replaced by set_value()
> > > - Prevent from returning errors when flags =3D 0 (problem with e.g.
> > > I2C GPIO support)
> > > ---
> > >  drivers/gpio/tegra_gpio.c | 39
> > > +++++++++++++++++++++++---------------- 1 file changed, 23
> > > insertions(+), 16 deletions(-)
> >
> > Lukasz, thank you for this change I would really like to see it in
> > mainline. ATM I have no capabilities to debug
>
> You mean test if it works?
>
> > this and I will return
> > to it but that may not be soon unfortunately.
>
> This is a bit problematic for me, as:
>
> 1. Some future work depends on it (more details below).
> 2. The "set_flags()" callback seems like being now the one to be
> advised to being implemented and used.
>
>
>
> Can you predict when you will be able to come back to this task? Is
> this the matter of weeks or months?
>

Weeks maybe, I will try to look into this when I have some spare time

> > In case you really need
> > switch GPIO back to SFIO and Linux cannot handle this, you an use
> > dm_gpio_free to release gpios in board_preboot_os in the board as a
> > temporary measure.
>
> Yes, this is a temporary solution - i.e. dm_gpio_free() is supposed to
> "free" the pin. IMHO, the set_flags() shall be used, as I in fact do
> want to set the CFG_SFIO flag, not release the gpio.
>

dm_gpio_free in tegra case calls CFG_SFIO

> >
> > Overall issue you are describing is not u-boot's it is kernels, kernel
> > must reconfigure gpios for proper work regardless of their previous
> > state. If it is not the case, then kernel device configuration is
> > incomplete or wrong.
>
> This is how the pinmux in Linux for Tegra is written. You can setup the
> PAD parameters, but you cannot set the pin's function.
>

WDYM? Tegra30+ has per-pin configuration, this includes FUNCTION,
direction, tristate and pull for all pins

> In other words - you have to do it in bootloader (u-boot in this case).
>
> In my case - customer uses the pin in u-boot as GPIO to check carrier
> board version, then the same pin in Linux is going to be used as
> special function one.
>
> Unfortunately, above "reconfiguration" cannot be done in Linux.
>
> As other "rework" of gpio code depends on it (use dm) - I would like to
> postpone my work until this functionality is available in mainline (and
> hence avoid "temporal solutions").
>
> --
> Best regards,
>
> Lukasz Majewski
>
> --
> Nabla Software Engineering GmbH
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschftsfhrer : Stefano Babic
