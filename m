Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE93FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 09:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B126383C14;
	Mon, 27 Apr 2026 11:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="BMzHGRor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B2483FDB; Mon, 27 Apr 2026 11:56:16 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 659A6839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-671ab90fc1fso18997659a12.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777283774; cv=none;
 d=google.com; s=arc-20240605;
 b=fpGHljwcogM8AseIxaYVX6ZCa8uzTNg+Wvx1kE2KPHkCep3/dpNznhCICQHO0+B/lL
 HzYgUrWkFzMuy2e752jcsLpzrkkosjCvCr5FsWrQMVOQMwP+Q+OKN5W11+7Rq2pW9aZy
 qjiJ83wIOftmg23tU1PtdtnUWA24ZPmEPmk2IS5dK7m80RV6AaL9X4EhYUpxlR4+UzFD
 SlWsH5X8TRaorTrSd0sdUR2sQqIzF/cuvf6hpB3F02aQ+Ftw753XUej+9j0fW8+mva+D
 kAWaOd77Oo3ECTsJ85s9PfTQXxlyrsp9zigQ8se1ixqS/2x0h5BqOybnru1e0/NydI+8
 qF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Hzaq0+54a9LI6F252u/rYEIncLqFw/8tLkqRihjdmw=;
 fh=U/xisq+LNdSzIlkUa1rrp6zC1MMRCmfDhnUm4PYpemg=;
 b=e9dAumLcAaKUYjE1IiLrnsB2eeL6pdfp7BaVr8vQvacO6l+4yQ7h9ErUKdhsK4Mq3c
 HF6GPt7U5l6i/QVuQ0n2ChpsYgx+3HnzzH/mXF1xn1loeOCAXsw9jVx3yDgnE/NlA4Q2
 q4dO6F/fGtEMMpPhOY8Oj8MbO5zYYhuStnU0/oawZR03npcVGYOtGon98lm0w3XaNz0r
 lTZHbLBy3b2jjUM8EOrGwisryTKXyM5Ts6AvgcVm5Jn3AScnDdSEzCYnUtoAwuvWateP
 pXb3d+Z5XlzA7q4LQNLJ5HBCXpnJW4/ew+cR6P3KNH3KDuLdFnyA2O1s/vSrfUkex8Ny
 /j6g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1777283774; x=1777888574; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hzaq0+54a9LI6F252u/rYEIncLqFw/8tLkqRihjdmw=;
 b=BMzHGRorxB6JfecFcoCQE9ZvfspzQEVnj2iT12adWgck++LXcQKx23VDIZijn7n7Ba
 ckPilYS7r+WpsmjXzTyMlskM8gGhLrWMEllhGErADfXDsNVA8ARAlH2HB2+YVrwXSmOo
 66uadne2vnVW2fY9DXD2BYPoNe+aDyYLUAwtIvaQmSP5qQiscJsUe1E9luJbKpzzbs1x
 lQ8fHBRFqxxd2WANObDTaDD8/LeLMwifr+ETkjCRRYQTO2d/TU8E2FTg1kKziCboY06p
 xjZc+e28O/MHaPxHOsfN1l5EPuaGtqk1AA7S/zLzJuOkgAXqoWLJkoTA2oQ0ZqWGNIqi
 /CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777283774; x=1777888574;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Hzaq0+54a9LI6F252u/rYEIncLqFw/8tLkqRihjdmw=;
 b=Dd0JVr7vze1Fd3XCNxQ5pAmWM2n0rbNCbizGET4+IGCpnkRTkn/EP7zaotHXPdkuTq
 s69m5RnjD/OMUmb3fhmxvLa0hw8KRk952433SJdy/oZbZ9QtuwwITD+RUKMiOe/GS21m
 k2aya+YtDoZRho1hDgKZ4zkrAhCzlrvRyexaGwNYIWVTE5MAi4cKj3qh1X9liwlZvFpp
 AkGkl6PXowBkcHgrj+oL5sAyfQb2eGntyDGwSqwIW2MmYvz3lEGydf1YAPpxyxUmBhZb
 S55RmYckIwPNMZNVuHs5Xe2cqgB8+JwdrtAp3niNXHHPuISokSmRJQ5v7JaEeXrhv/Rd
 MJZw==
X-Gm-Message-State: AOJu0YwJXOCn227HhDdq4BFnZsa4gx7JQ9SsNHTGEWR53BtFo96jieuz
 o4mOIImoDDHGuT2SuFo7xlGhw2wB0KOD+VymDMTG205HuqAuw5KzvQOFdFPcXyFiTYT4UpaVxnE
 F2lreMABwXbyTOtYhJbtQmFTNmCvTCp3N1L5c9rLgDQ==
X-Gm-Gg: AeBDievdfHQYNwXziEjLcvzlGs+Wkh0oEjjpE7kHpigOfXPoauCwYLIr7sSxj+f7xym
 d8aFf9bapoNaZURSNokBAMdqp8YRSULKMfwPw8V9TjBjKCDL2ehQvj4cjcYfartuTJ8g0F7Sb1q
 lxjM/eJlzf6rGt27fNKvtIZr2c91pcsxkSmmI1NQ4dTz7dtTKyRlMg2pRoHDyMOmsdRo/3ww7JG
 y3fEUdLo0y5m1gXuWKOC6TL3S5QMbLRWe0R8kDEKoVJCKclJ/Ul/HeShISvg0VkxVTx+vnCk4Uy
 4tUIrwva0hGVsEQr9IBYv0wFdrehyfW1iHHglqDdtio6grCfLGZItn6ABMm73ZsFwvfgX9480O8
 =
X-Received: by 2002:a17:907:6188:b0:b9d:2fce:308b with SMTP id
 a640c23a62f3a-ba41afe9d42mr1335741066b.30.1777283773461; Mon, 27 Apr 2026
 02:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260326112830.313874-1-robert.marko@sartura.hr>
 <3d5c0942-93a4-4a0d-a272-932ff86d2da2@kernel.org>
In-Reply-To: <3d5c0942-93a4-4a0d-a272-932ff86d2da2@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 27 Apr 2026 11:56:02 +0200
X-Gm-Features: AVHnY4JJBCpGdIL5fLz8GU2e2QcVml4MQJrJGeV1XK_szRNrfukjzpLcNPHruyM
Message-ID: <CA+HBbNErDg5-_xX8qg0JES1bxVmgxOA81JDqRwQwAN-M+odAdA@mail.gmail.com>
Subject: Re: [PATCH 01/14] serial: atmel-usart: allow selecting from
 ARCH_MICROCHIPSW
To: Eugen Hristev <ehristev@kernel.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, lukma@denx.de, hs@nabladev.com, 
 peng.fan@nxp.com, jh80.chung@samsung.com, gregory.clement@bootlin.com, 
 lars.povlsen@microchip.com, horatiu.vultur@microchip.com, 
 jerome.forissier@arm.com, marex@denx.de, daniel.machon@microchip.com, 
 luka.perkov@sartura.hr
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

On Sat, Apr 25, 2026 at 3:35=E2=80=AFPM Eugen Hristev <ehristev@kernel.org>=
 wrote:
>
> On 3/26/26 13:26, Robert Marko wrote:
> > USART driver is reused by a lot of Microchip platforms, in this case we
> > need it for LAN969x so allow selecting it when ARCH_MICROCHIPSW is used=
.
>
> Hello Robert,
>
> I apologize for not replying to this sooner, but my old email address
> was bouncing.
>
> I did not find any information(or cover letter), about this series,
> because it looks like you are sending this on top of something else,
> which is not merged yet.
> I am not familiar with ARCH_MICROCHIPSW which is not in Uboot.
> Can you please clarify ?

Hi Eugen,
ARCH_MICROCHIPSW is not yet in U-Boot, but its being added via the
same series patch series.

Its the new arch that will hold LAN969x for start, but other Microchip
switch SoC-s in future as well.

Regards,
Robert
>
> Sorry again,
> Eugen
>
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > ---
> >  drivers/serial/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> > index b84cb9ec781..3848c3ca20e 100644
> > --- a/drivers/serial/Kconfig
> > +++ b/drivers/serial/Kconfig
> > @@ -665,7 +665,7 @@ config ARM_DCC
> >
> >  config ATMEL_USART
> >       bool "Atmel USART support"
> > -     depends on ARCH_AT91
> > +     depends on ARCH_AT91 || ARCH_MICROCHIPSW
> >       help
> >         Select this to enable USART support for Atmel SoCs. It can be
> >         configured in the device tree, and input clock frequency can
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
