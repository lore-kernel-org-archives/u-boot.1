Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4751AC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:37:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B11288B23;
	Fri, 16 Aug 2024 17:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UzBxHC8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF7588B88; Fri, 16 Aug 2024 17:37:24 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9219F889F8
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso14856585e9.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723822627; x=1724427427;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ERAYAHGAkfS6AMs3aeoEVmA0bWiQHS652JC1oB9kNw=;
 b=UzBxHC8zqFSFO69nrCp4Y3pnHhmxru2kTjkn3uWvGQ7dqUFKfSI3duqVBxOcFkLlrt
 BYmuPZk1IReMHyejkHkKpskAKDQkmKoA/ZSlZt6vu7/os+Iy6WOau8F08OOWjqzzRcxP
 MKYZB4ltQva9wxWnD/PncT+hDtW9QShSHglR7qLH9SyuecittB00KOyHxvj8nK/FrZjk
 PS/8QlBDkugbPshUIsXMTBjftOTJqnSi18FNoijv37QLOd0QWqr7jL0mTQjQs0KImZ4r
 fDSvb2gPewcSvTKkBMlzCo8K43Zzn+jvB5WO3EuuRl1lMWfsiYQj+yc7zpxVhc+oRd2S
 Tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723822627; x=1724427427;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ERAYAHGAkfS6AMs3aeoEVmA0bWiQHS652JC1oB9kNw=;
 b=ZhYAZNsSqz/31vEY0PzQufsN3zOdRnKhfqPqb5zsqlzFz0KcW8YFie02b+UXkgnVZe
 jKv2yLV0AZs9Say7SKx+0TVaAY6/sq7q7P8piz+0BSCoivoXXxd9D30Yz0lbqvFhAXLj
 8VDbjBBc9NMtLE8EUbw2R0RnwYPojQkEDKGB0iqEAj5GPi8TYIt8seJvGaS7uEbXMwr6
 kcoyLzH62GS3onQNHzUcuK7qCamMX9DPUrCRND8nVyuGVSFcyx6KGMG2McD2WFeG6xmF
 9V90kl0Bvf/lZDhsdFfMgOyl3/+Ia0OUqfSwEE09VmlIYobMymYs3BWai259aMWvMr6/
 t/Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUthWwNEWPyYEL1b8kLIpRcmPHozu5j78GqU9RPxSiSdptcfcc5hChXaWia/D8sLucGhBKGdUE=@lists.denx.de
X-Gm-Message-State: AOJu0YwpCfO45DEYpgU9ob28KJ5wSRyz52g70AHqxudrNV2bfCz7oriB
 BTKfKbyTv5J194szGfWIA1/PzzAZFa+LmiSpWmEh34TCPOZreA+T1F1gyuSsosI=
X-Google-Smtp-Source: AGHT+IFN+28pR0C5IbvOnCUsfh4fcMB0wjjZmTRwiNn9WbMNVNx1jMV1r+3UGpvpNloY28ZxH4tLng==
X-Received: by 2002:adf:a314:0:b0:371:9121:5643 with SMTP id
 ffacd0b85a97d-37194314ba6mr2529651f8f.12.1723822626559; 
 Fri, 16 Aug 2024 08:37:06 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718989708esm3926363f8f.70.2024.08.16.08.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:37:06 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Stefano
 Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
In-Reply-To: <CA+GyqeZBzMct6nTKQx4k4cyxn8kdoQ69K58WOLdPgtLU_12ciA@mail.gmail.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <87frrgolp3.fsf@baylibre.com>
 <CA+Gyqeai5OZY96HU7uD0X5tbGVHODo1tOE51RYraMYwcoP2SrA@mail.gmail.com>
 <87h6bosu6e.fsf@baylibre.com>
 <CA+GyqeZBzMct6nTKQx4k4cyxn8kdoQ69K58WOLdPgtLU_12ciA@mail.gmail.com>
Date: Fri, 16 Aug 2024 17:37:05 +0200
Message-ID: <87ttfklbry.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Zixun,

On mar., ao=C3=BBt 13, 2024 at 15:39, Zixun LI <admin@hifiphile.com> wrote:

> Hi Mattijs,
>
> On Tue, Aug 13, 2024 at 10:28=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Thank you for giving some board examples. I am still a bit unclear on
>> the meaning of:
>>
>> """
>> This breaks the capacity of using "usb" as DT alias sequence numbering
>> which needs a fix afterwards.
>> """
>>
>> I have added Jagan, Stefano, Fabio and the NXP team in CC. Does anyone
>> of you have any concerns with this patch ?
>>
>> If someone could test it, that would be helpful.
>
> The device sequence number is affected by uclass_find_next_free_seq() in
> uclass.c, in this function uclass name is used to determine the number.
>
> Since the gadget class's name changed to "usb_gadget" from "usb", alias
> binding "usb1 =3D &usbotg;" is not effective anymore. As now it searches =
for
> "usb_gadget1 =3D &usbotg;".
>
> uclass_find_device_by_seq(UCLASS_USB_GADGET_GENERIC,) would fail as seque=
nce
> number is changed.

Thank you for the explanation.
Looking at the code, I don't see anyone calling:
- uclass_find_device_by_seq(UCLASS_USB_GADGET

And one occurrence of:
- uclass_get_device_by_seq(UCLASS_USB_GADGET_GENERIC, index, &dev);

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> I made a tentative fix in
> https://lore.kernel.org/u-boot/20240731134257.686017-2-admin@hifiphile.co=
m/
> But Simon doesn't want to modify uclass_driver structure only for gadget
> class.
>
> Regards,
> Zixun
