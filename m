Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1BAC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 08:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4CD88739;
	Tue, 13 Aug 2024 10:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MQVuYADg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C31886E5; Tue, 13 Aug 2024 10:28:49 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE7F68890D
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 10:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3683329f787so2723656f8f.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723537725; x=1724142525;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZLwhXpruZKOKN0CnW/MIO0C0u3Ln7FrbNMe7MvfDFfg=;
 b=MQVuYADgfz86701YDdgv1KrQHm2+KGpADyzAGlJSpv9y1dGt2lGFa5u5GBv7rIHYrl
 XNKc3z9SJ283OOcSyffba343TVqmAflCd2cU/4ISBghyCT/bV+X2rwIyqqdZ1e2hrk5P
 X6DBNdkPHHr+DSgeb1tuiqJFdQMaLixst/IDhedrLpSI67dTPaCEY5ZTeoIOvRgdJ1vy
 1CYNoATB5muT/Oe8R70xm/W17EhUxS2jMAtsf3G+afCzx6LJ3N5/ndSjqQIuMuthwC4W
 r63ThbynDBQFrVewAWq/HcTcT2QOI7rq0POxn3LtxbKVXs8uxif7r8vzhlws+hgiZPps
 zOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723537725; x=1724142525;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLwhXpruZKOKN0CnW/MIO0C0u3Ln7FrbNMe7MvfDFfg=;
 b=cIjrkbVZHy/INHSqerL/p5ejgfR8vMxmedGCmF5/KFwCDQl/vV1VCyM0HczwtSsUFE
 vj4KC9YqRkAc6Z/Lr+UGlnqdctJ82gCbwKOAtWSLo57pMtBau0GnzS0q4HzI2FFRsoUy
 6ovtRHnZOPB0M64xGXgEr9n2V+ZBiu37dVOP/ILAZwIEns+nWlVzEAC6IJOsnpCSDN0L
 EynZ4Sa++ZDfsA6XlnZvgGuO0AfAmt7/lqzZ3EThk5rrxT6fUr1ruX6FSQ4rUtuSXSY2
 +Hzgx6YVqDYE6g1Eb30mEIz6Wbb5ZMl0635kLxABdjPR5v/sFMyOByGFDYlsGVkJo7Z7
 gCcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVitCpUakvsUQDpoK3yBbpGjjyweaeUSS7N3io70GlfL3M5KImPuPOL14+sVHL3xeT9Q30NLHqc+Tp5mdgI0wtfPeSpfA==
X-Gm-Message-State: AOJu0Yy8bp1eQqwMm3+gJk56WbZJhCYWDs3VRx9Ru6N3y6S32FBi4Sjp
 j4SQ+nn+wa6bjUdRXAHIiSqtp74mqr+o1FsygXR0skc2Fkb8WRUFxReRw2QOgd0=
X-Google-Smtp-Source: AGHT+IFQ9n82pFFjmnPPSWcpbLzVALzXrGLhm+AZtsvyALhWOYKsxGPp99nrvOqOHI94PaHY2NEgXg==
X-Received: by 2002:a5d:4342:0:b0:368:d0d:a5d6 with SMTP id
 ffacd0b85a97d-3716cd24cbamr1593049f8f.50.1723537724679; 
 Tue, 13 Aug 2024 01:28:44 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4e51ec1fsm9553781f8f.79.2024.08.13.01.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 01:28:43 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Zixun LI <admin@hifiphile.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Lukasz
 Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>, Stefano
 Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX
 U-Boot Team" <uboot-imx@nxp.com>
Subject: Re: [PATCH] usb: gadget: udc: Fix duplicate uclass name
In-Reply-To: <CA+Gyqeai5OZY96HU7uD0X5tbGVHODo1tOE51RYraMYwcoP2SrA@mail.gmail.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <87frrgolp3.fsf@baylibre.com>
 <CA+Gyqeai5OZY96HU7uD0X5tbGVHODo1tOE51RYraMYwcoP2SrA@mail.gmail.com>
Date: Tue, 13 Aug 2024 10:28:41 +0200
Message-ID: <87h6bosu6e.fsf@baylibre.com>
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

On mer., ao=C3=BBt 07, 2024 at 14:36, Zixun LI <admin@hifiphile.com> wrote:

> Hi Mattijs,
>
> On Wed, Aug 7, 2024 at 9:07=E2=80=AFAM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>>
>> Have you identified boards which use the DT alias that will break
>> with this patch?
>>
>> Maybe we can detail the required fix in the commit message a bit as well?
>> Or, if you know of a board that uses "usb" as DT alias sequence number,
>> we can submit a fix alongside with this one to document the fix.
>
> I did a search and it affects mostly i.MX devices and Nuvoton npcm845 whe=
re
> host and device controller use the same alias.
>
> like imx6qdl.dtsi:
> aliases {
> ...
>     usb0 =3D &usbotg;
>     usb1 =3D &usbh1;
>     usb2 =3D &usbh2;
>     usb3 =3D &usbh3;
> };
>
> nuvoton-npcm845-evb.dts:
> aliases {
> ...
>     usb0 =3D &udc0;
>     usb1 =3D &ehci1;
>     usb2 =3D &ehci2;
> };
>
> But I got lost in EHCI's code, like in ehci_register() when ctrl->init =
=3D=3D
> USB_INIT_DEVICE the function returns without the actual device init ?
> I'm not sure how their gadget mode works and if it's really broken or not.

Thank you for giving some board examples. I am still a bit unclear on
the meaning of:

"""
This breaks the capacity of using "usb" as DT alias sequence numbering
which needs a fix afterwards.
"""

I have added Jagan, Stefano, Fabio and the NXP team in CC. Does anyone
of you have any concerns with this patch ?

If someone could test it, that would be helpful.
