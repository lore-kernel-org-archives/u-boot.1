Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147F8C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 14:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D4B8899C;
	Tue, 13 Aug 2024 16:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="0ugWBr7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19ED388842; Tue, 13 Aug 2024 15:39:51 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D659A889B4
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 15:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ef2d96164aso59788501fa.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1723556388; x=1724161188;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySEvRb6t/tnGlZs0lBaKHXEOdsJU1IT0H18BfIZOGO4=;
 b=0ugWBr7NbORO1C6dHjzbKJmj5ClmqExTSZaJjcIzaXh/YYh6vZrfrI1UDdZw873REE
 4EkUnPxJDTO8deBwhBIiYGEd/f56f79WKi8yDceehIhpnP3mXA0abAdKwGz37RrGb7/J
 HMwRDJQyUpDcJFAGOd0HXFFxMs7s2IeH7dcc/lwIN1eYTu3sN+9Y5k16C9vKOwG6gU4H
 seTV/e70P9yOc6O9rg/FG8XOHoocPxIcZSODMVSLJuTilB1FRnJkn6u3POs2C6Jzc0j9
 7z8z259135Bw1vnpT6Uj5WLyHz4aWLRrK/wnHSlPxb+Ley0XQzOxKV7ig3o17fVHstZH
 g4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723556388; x=1724161188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySEvRb6t/tnGlZs0lBaKHXEOdsJU1IT0H18BfIZOGO4=;
 b=lvrwqeU1K4gWn3NeiSgo4rxEGk20W5P0RrnRHfJ5SX0LK2kOfDFY2yv/EXhnH0etXm
 Lcp2g5syU9dYtZHMrvmZQ0WA/weEYSAtvuanniQzHpw+3IEETrC7HpmYpVss7Yjd9oNi
 9KozJXZWpPjvz89SFuzvR+wX3Fb9C3qxgfGQ3ESB7t2NqyYIv43e2S9LQZJlhleiJm9W
 EFIZyWojM/ry89IEGGutyVOZH1xeXFLmpWjqbSNsnLhpfO1KBE30GWLsNqZ364LyDzpA
 VTMRZhWNWFM5kJDOPM2yDhTLzIoZwY6oNTBYCVDjKfQqP3sC0zuiKyaMelClKUBCesbm
 d+kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYMzqtbSAfwGTjrgkL4657l49Y7ej94CL3pLPvALBtlA9ICDt0hoCtbEcQKMLjZWlKXoWqYTZdT2EyLjlN1IRNlW/O9A==
X-Gm-Message-State: AOJu0Yzjymq7lw+zGhA3rpkmmpXDPrfvKMLWQjpZqwgSzDhkECEl+m4W
 Qmy+NQxUFUKRtEBU71y8f9fh9zatA9lMJ7XOmYufC0NASoX8jiKm88Jj2t2pY/QWKhjDRmZ4xtC
 WX6WRSMDJIpuJ8/bGltbT+queA70bQIldMAbcUQ==
X-Google-Smtp-Source: AGHT+IHwfTnluyHBvVbcFFcIcxVJGc8GSiKmj3HsC2WQmPPhQIS5FTtx9NKWCHjJc7s0Dm798yTOzlKlEu0dSbdebdU=
X-Received: by 2002:a2e:3a03:0:b0:2ef:2f17:9ede with SMTP id
 38308e7fff4ca-2f2b727731cmr24096651fa.49.1723556387765; Tue, 13 Aug 2024
 06:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092820.917450-1-admin@hifiphile.com>
 <87frrgolp3.fsf@baylibre.com>
 <CA+Gyqeai5OZY96HU7uD0X5tbGVHODo1tOE51RYraMYwcoP2SrA@mail.gmail.com>
 <87h6bosu6e.fsf@baylibre.com>
In-Reply-To: <87h6bosu6e.fsf@baylibre.com>
From: Zixun LI <admin@hifiphile.com>
Date: Tue, 13 Aug 2024 15:39:35 +0200
Message-ID: <CA+GyqeZBzMct6nTKQx4k4cyxn8kdoQ69K58WOLdPgtLU_12ciA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, 
 Jagan Teki <jagan@amarulasolutions.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 13 Aug 2024 16:29:28 +0200
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

Hi Mattijs,

On Tue, Aug 13, 2024 at 10:28=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Thank you for giving some board examples. I am still a bit unclear on
> the meaning of:
>
> """
> This breaks the capacity of using "usb" as DT alias sequence numbering
> which needs a fix afterwards.
> """
>
> I have added Jagan, Stefano, Fabio and the NXP team in CC. Does anyone
> of you have any concerns with this patch ?
>
> If someone could test it, that would be helpful.

The device sequence number is affected by uclass_find_next_free_seq() in
uclass.c, in this function uclass name is used to determine the number.

Since the gadget class's name changed to "usb_gadget" from "usb", alias
binding "usb1 =3D &usbotg;" is not effective anymore. As now it searches fo=
r
"usb_gadget1 =3D &usbotg;".

uclass_find_device_by_seq(UCLASS_USB_GADGET_GENERIC,) would fail as sequenc=
e
number is changed.

I made a tentative fix in
https://lore.kernel.org/u-boot/20240731134257.686017-2-admin@hifiphile.com/
But Simon doesn't want to modify uclass_driver structure only for gadget
class.

Regards,
Zixun
