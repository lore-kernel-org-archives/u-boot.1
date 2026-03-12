Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D46105A592
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3322B841D5;
	Thu, 12 Mar 2026 13:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lrAqV39y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9772841DA; Thu, 12 Mar 2026 13:10:49 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9338B84121
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66325f30570so1676821a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 05:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773317447; cv=none;
 d=google.com; s=arc-20240605;
 b=eB5/6Y4w28JpACIGkHYNPWOdeIugcam9DYjpbNuD4eIRxmbuQI4lVOAPW5d92Cmeiy
 PtF8F+IMX3Gd8aYkpprHADbiycv5PG7EZvscetX9nrCjRWrnpIPcQ2mPlkGYR6aYuP/1
 S2iZFWef5uCeMCyve2cAGRnqnZUKQAPfQ6CXggt7kdm/sGqHvUOSuvml38M3Pm1ip9Dm
 2qsohI9MJhyPAU4oSLjxI5gtbDftiqyscEJ1CYrZQOnpj93nQk9TQJTQ+vkleiMKqOmB
 h0kJboyGXtVbZSioff7p33ozVZo8q1IKUffY6WaIUjFVPxeYJRF7U+vdtWowYkf5EXf0
 j+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lKNIgil9Z6PhvFxIXdncWrZ1IjXwiDAz9ne54hITXFw=;
 fh=lEnt6i2qrjwBbaSCkrdTcOSYGh/b1tw639piUMO096Y=;
 b=HzfMbRBE+/Hgq0O1pdqfqxjoL7R2Hgd91q02J2MzmXTDTkXBpZRTQIU2Vhuf/450xM
 P9lnsYb9EqhFYWHN13aUHx7UVslH3sLTAX0ftNk4JMqOqzg4vgnzZ4Xf1vlYYt5UZ2X9
 mWdhrY1VzJVR8ILbTgvqRNF7tPPQ4/G5sVHCSPskbFQssEu/FL8xJw+i0AeatohX3FCh
 1QtfFE8N62GpNUWNHx18szc1XJkunW8lrRgOQVqf8AWsJd3YFgxrKrcgFCcdPbXeHJ7M
 9EBoonZzddDrfZ6/82pQXB2gtNJsse9x8Jk0qO/aALyy88Gwqw9u1p47bawQwImZl6uv
 U+Ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773317447; x=1773922247; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lKNIgil9Z6PhvFxIXdncWrZ1IjXwiDAz9ne54hITXFw=;
 b=lrAqV39y+8641KolgyVlgid/N6xj8m8R2MWAFKfOSX9koEsRP5+x6Aoppuk1Jdzrlw
 YJWGFjqnX2Y9y4ic6RAWLc4yIVAxqS9NX9bESW806RDnKbo4LxWwK0lb0Fc4M04rkhPk
 GLycnTudaaa6RYkyiaNxMN7X1c3/3At1k8nExU5g6jTqPV/zHjvnFt3LF0yVEiVQV40h
 +NX9pvV2d8buCMPz8/NUSKIswg3ZKv6GMAur7FQVTLL3Hz5G2fg80P18eoun14oeGTBk
 t253oIlCXEpck6OHLq16oCx1RJm8dHLaiCYE+0olQJD2OBaPKGf9NnxyNDHSWuWIbCta
 lK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773317447; x=1773922247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lKNIgil9Z6PhvFxIXdncWrZ1IjXwiDAz9ne54hITXFw=;
 b=MZfhpTi9hRJOkhybJdubxzOZh7MRSR34CbI5uXUUvH9ek3DerOHPu6gt/7l61vs2Bw
 XUI9MaW+93r5i8BvBx2hnh+0r3Q9Bvz7QMYzfxeB93k3kz7bXcT5VfQIvqKbDtRINmal
 bMd8E0XeS1zw25WaPClj1ul3up4WOpYNm5hLC9NyZP3ahZvvR6jsScIDOmYhGCy4O5aJ
 igGxOT4VqsBolcQTtJOC+hz/gsPqXrWpnyD+lM11AdkdWe/GKmsNnAtvGQ0Ze/6VejNI
 88ncEKnbKnBTYXqjSxlXNFHmOKj2qNWvkvEoNbqcLEtg+5EgDncqZpic8n3eHQgkQQkz
 Kdhg==
X-Gm-Message-State: AOJu0YxEY50JEKntDsw4lSh9ELgf8D74gzLACsoqVCgG8CPvo2TuX1RX
 aeG4tI2llqB28djZ45nQFZOQNkbFsHlByGDqGlVW69jxuBxaXlcfzOEYsOQvcKsI5pRZQ8BJZbk
 hVP5Qt1S/OZU0/JvLdA+F17nmctLiYvE=
X-Gm-Gg: ATEYQzyMaCQBvDDcPWQv6yX4EgpcVaBv70YEI1mUYx2qmdG/EGnscZkBVuRSyhdG1DA
 wcmKbxbXmqPYKM/tnRan1wMllR9z3NXgk4mkbWLoaGozFxIZ9qbKzKqA5AZwYE7xeVNWEXZI7zJ
 2mdaI4Yfw6TBYCDN3Otn/cQgohiYd3AGDbUC8QFkMno4gkRJrvCJdnN43HMTbp0/ZfxmXs6FdhY
 pkzyvX2zcNTcUPIKMokfH4GMKjzXjZElemFuY+Evoc+BKz3QQpUv1ylxhTkfOhyn4cfQwVGdVQq
 bi9w5d3+VMILAmk8OGEVzR+tArAX0kfPpgkkqnBq5E7V5UnAwDhJFXs7hm2XuQmgoat8JKthlE9
 wAsgICA8qfQxV9g4clJZJ7zneiNvMz3FIY+wACAlca/GA3WKsfW6KKSYkhsAbZVPmb1z45dfeEA
 K3
X-Received: by 2002:a05:6402:21dc:b0:65f:71ec:2326 with SMTP id
 4fb4d7f45d1cf-6634fecc0e2mr1654357a12.11.1773317446870; Thu, 12 Mar 2026
 05:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
 <CALeDE9MTfGaVt3p9h2oTt2KkJ8JDjauNT7oA4bnsHbP8C8aB7Q@mail.gmail.com>
In-Reply-To: <CALeDE9MTfGaVt3p9h2oTt2KkJ8JDjauNT7oA4bnsHbP8C8aB7Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 12 Mar 2026 12:10:35 +0000
X-Gm-Features: AaiRm52mO1LMU9HN0EyXX8fsIPiDNnUe32TRUV7vtoqFQqkFPUJzj3PuLjrcoPM
Message-ID: <CALeDE9M1cYq8Rk_rVEtzTQdUQreaJ=o70z+iWaipsN9-LgwnfA@mail.gmail.com>
Subject: Re: [PATCH 0/2] board/raspberry: add FDT for bcm2712d0
To: =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com
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

On Wed, 18 Feb 2026 at 11:12, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> Hey Filip,
>
> > This series adds the FDT for the d0 stepping of the BCM2712 SoC. The v1=
.1
> > revision of the Raspberry Pi 5 board can't boot Linux properly without
> > additional changes specific to the d0 stepping.
> >
> > The d0 specific changes can be seen here:
> > https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/dt=
s/broadcom/bcm2712d0-rpi-5-b.dts
> >
> > To do that, this series introduces support for multiple FDT entries for=
 a single
> > device type (bits 4-11 from the new-style revision code).
>
> I started to look at that last week to see what was needed so this is
> good timing.
>
> > The rpi_model struct is modified by:
> > * changing fdtfile to fdtfiles (const char * const *)
> > * adding fdtcount (size_t)
> >
> > Adding fdtcount is motivated by wanting to keep FDT selection O(1), and=
 avoid
> > relying on NULL terminating fdtfiles array.
> >
> > A new FDTFILES macro is added to initialize fdtfile and fdtcount.
> >
> > In case only a single FDT is provided, or the board revision code doesn=
't match,
> > the selected FDT defaults to the first entry in fdtfiles.
>
> I tested this very briefly on my RPi5s and the good news is it
> continues to boot.
>
> The problem was I see no output from U-Boot on the serial console at
> all, I get the early RPi FW output and then I get the Linux kernel.

FYI This was an issue with downstream breaking the pl022 uart
compatible in their DT :-/

> I think there may well be more details we need to deal with here,
> there's at least some difference in the console serial port [1] and I
> suspect we might need to deal with other pinmux nuances possibly
> around the sdhci interfaces.
>
> Can you also provide details of which revisions of rpi devices you
> tested this on?
>
> I have an 8gb v1.0, and I thought I had a v1.1 2Gb but looking closer
> it looks like that's the old c1 SoC rev (I read their original
> announcement for the 2Gb variant as they were all 1.1, it appears
> not). I have ordered the new 1Gb variant so I have a revD I can test
> against.

I've now tested this on both a revC and revD.

I suspect we'll need to tweak this further when the d0 DTs land
upstream but it works with the downstream options.

> Peter
>
> [1] https://github.com/raspberrypi/linux/blob/rpi-6.12.y/arch/arm64/boot/=
dts/broadcom/bcm2712d0-rpi-5-b.dts#L93
>
> > Filip Kokosi=C5=84ski (2):
> >   board/raspberrypi: add multi-FDT support
> >   board/raspberrypi: add bcm2712d0-rpi-5-b for Raspberry Pi 5
> >
> >  board/raspberrypi/rpi/rpi.c | 96 +++++++++++++++++++++----------------
> >  1 file changed, 55 insertions(+), 41 deletions(-)
> >
> > --
> > 2.51.2
> >
