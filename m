Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B853BC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 18:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D270388806;
	Sat, 20 Jul 2024 20:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M8g7htRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660DC88845; Sat, 20 Jul 2024 20:09:17 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 045AD887F3
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 20:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robertcnelson@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b797fb1c4aso23135936d6.2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721498953; x=1722103753; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fa7lZ39fuVer2u/ihTs8y91PsO8zaiFlL1KsKVAFg/o=;
 b=M8g7htREsazENHjhAHcc7xoaNAglO8FoQ5tP2fSrKRU70m+X9zccwd1BNUVJAvPSnj
 IeN9KXfPbdshw/Mtnb+MYiexOMFolQ37d2zu+LFbDskuoZCed7zxJ7nVpcMQWW5C3w65
 v7E82n2o4ec/hrgL6KAKDTc/efd1LGIxopr1xVmKcd0MW+mxjUx7v85FUDRHA1uqZYbn
 +xq4onz4bRKihDzbD3PSexUdSspOteUidZDjKQf9Ge5TsM2CMlsGudqzyH3t0By5mmaZ
 3jP/v9UM/JfaGnQVxLLwOiqxk29H5D9J/Hv5mw/5f51f8Mkjh/uOuPji8/q5YxR/Ldvx
 DHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721498953; x=1722103753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fa7lZ39fuVer2u/ihTs8y91PsO8zaiFlL1KsKVAFg/o=;
 b=lqwkRfjcnX3/uSZ4BAbmvAfIxKdf9QI9PivqHlCMqGrPg77FpZjkvRl7CWMjLTvuik
 t0BI1oJWZIhffa2NvYY6GmJMYcK16cy+OD4gRMv3psIMSKy0aLrJQsXqqyw7V6pDEQOn
 etiSZm3mKdDyYls49MkiR5JZUgpjAQX2s0zLT6FEnSqTA1n5iJYxp4yWP9GwZfnhsN0s
 O2YxldDPFYRFLe8Gt/4b/mO85v/U0jhO2teeiVeHtea5OArYYXMV02qjJlGFfnHFXW7k
 ycmOIKirKIsP8IlSWcICPrlZH2cqZ6veMFNHY8Fbf4/ypPMqVwiqg+IPGutQ+hsBriPM
 7eWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu8jaVw4ZLkzYBYJyCkEYAT56lgRRdh6KGL1Kgva04noTeVM6kYXGrs486d+uVPI5R0czW6tL9QESEQbG1Gz4XPr9MYA==
X-Gm-Message-State: AOJu0YwWnbtUPIc2+HWdygomTKgPWZiW32+Qfdn6WpbVzj6Ukx/W935P
 QgF20DSqn521eKzpLJxB3B9Qc1+kAN2yWsnwAbuurkPb2aUKSm95b0zMecDr9gwZ97ZcsSv/6ZP
 5QhHk/eOar1CIs9MgvEW8MAxjWJI=
X-Google-Smtp-Source: AGHT+IH66L078JmcWn9Kcevdq1x1yvEDUR8RACtYGukrCQ/J06Rqjx9kVemu4IYrAh4VMg9/a2VWYRojlF1gxWm7EoQ=
X-Received: by 2002:a05:6214:f02:b0:6b7:9d3b:b5e9 with SMTP id
 6a1803df08f44-6b94f02ff22mr51718486d6.20.1721498952958; Sat, 20 Jul 2024
 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240719215123.3358410-1-agust@denx.de>
 <CAFLszTjjgvFePwsMO-u-bKRjaCREXy1PCpOCmfH=Atvm2ThAqg@mail.gmail.com>
 <20240720150934.40349259@crub>
In-Reply-To: <20240720150934.40349259@crub>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Sat, 20 Jul 2024 13:08:46 -0500
Message-ID: <CAOCHtYj0fEqUjsw2CwTPS8VUyeEF15P3FJqEU8ser0z-DYm3jg@mail.gmail.com>
Subject: Re: [PATCH] board: beagle: convert to CONFIG_DM_I2C
To: Anatolij Gustschin <agust@denx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

Thank you Anatolij, I'm really glad someone was interested in making
this board work properly in mainline u-boot!

On Sat, Jul 20, 2024 at 8:09=E2=80=AFAM Anatolij Gustschin <agust@denx.de> =
wrote:
>
> Hi Simon,
>
> On Sat, 20 Jul 2024 13:36:04 +0100
> Simon Glass sjg@chromium.org wrote:
> ...
> > > -       /* return BEAGLE_NO_EEPROM if eeprom doesn't respond */
> > > -       if (i2c_probe(EXPANSION_EEPROM_I2C_ADDRESS) =3D=3D 1) {
> > > -               i2c_set_bus_num(TWL4030_I2C_BUS);
> > > +       ret =3D i2c_get_chip_for_busnum(EXPANSION_EEPROM_I2C_BUS,
> > > +                                     EXPANSION_EEPROM_I2C_ADDRESS, 1=
, &eeprom);
> > > +       if (ret)
> > >                 return BEAGLE_NO_EEPROM;
> >
> > Isn't this in the devicetree? It should be possible to use
> > i2c_eeprom_read(). See for example sysinfo_rcar_probe().
>
> No, it isn't in the devicetree. This EEPROM is on an optional
> expansion board.

Oh this expansion eeprom never really supported that many devices:
https://elinux.org/Category:BeagleBoard_Expansion_Boards

With the older pre-device tree kernel days we would pass a boot arg to
the kernel to re-pinmux the proper device configuration..

We could either just drop this part, or convert to the u-boot
expansion framework, which would use u-boot overlays..

Regards,

--
Robert Nelson
https://rcn-ee.com/
