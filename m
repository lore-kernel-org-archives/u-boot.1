Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE28D711D1
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 18:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A4C89327;
	Wed, 20 Nov 2024 19:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOD9o1cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6524B891E8; Wed, 20 Nov 2024 19:10:38 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EEAD89327
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 19:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d410b5a94eso525816d6.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732126235; x=1732731035; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/oBH4xjqqpdHe6tW8ODgTBA/hgJJ5q4TjHwdF9xe+oQ=;
 b=QOD9o1cMRIGfot8lHdm+W2gHaWKUKmiJOCtFMdqHA5ZcmsAEdFyJppyJ5Dh628q6yb
 v/+UeyOuYy3MpTKYO80EMtEtQGk4XGj3WMTo+K6dpeUc/EY74YlrXAtInGSc4yxw3e1i
 d6bqcYx85RCOlTcfMxbrNg1U9wcf1GeXnVdnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732126235; x=1732731035;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oBH4xjqqpdHe6tW8ODgTBA/hgJJ5q4TjHwdF9xe+oQ=;
 b=lBLnuq+IMZ6XnJSw+rgQT7iUkir6NNwUbVbF+jeB3SNZ2Texo2NQQ4Sam1agxD1Jon
 TllNfXaRaGtfMjIn4jnSef/D6a0YzHflOaMZO9XuKg90jJ2nI4XrQOxsbQ6BM1Bzte9V
 2GvMmeQ7AmlNje4WVxFo2dh/Ii4Yl5OSpzilX8g87FPG1FNmFKXqB0i+6QQO/aFIwrb6
 rnrMccqXtr0xIKb31/vTss2OMhzhtejxDPSHQrBrXfNJdG9zsKdR7QwYUFGZqM35eDMc
 Zy1nMOWFwd5GPIoQHOeTLiaRK4AqH8sJHCAIknWivwwWJwXTRXOmtHQPUpAXqrCaA2Rj
 +97w==
X-Gm-Message-State: AOJu0Yye9B21SnsVwe+IPpwGoafBl3CK/elxOFcXBDghLhNZdCXCm/yc
 35ThencDY0OYsXNQl0zIxp21GRB0SluC69lb8qLPxQ7YLGmPQwfzamqd1fkaBm8=
X-Gm-Gg: ASbGncvzwp+0eJcDnH966IJoHLDrrB9GxHpfV8UuXxDbQj8HGF9VncoxtMXhax0K++6
 6KNyR2lA5qhZiyYvivDqPD+Nj1j3JbuLuYBSpT0eTZo+yUdEElWh/PLwRX6Ke5j8zSi1Rq/PjSV
 HIfVPyDPvNscNOMYCrtUHeGG2lcfATTMPJqrhC24hGAXN7QKuxw16PpHnL3UMFvOl7fzRBdGVbL
 FEm8uuAQL6Ny0/zarKdyT737IaLql16yyz/eMqRqy9lJV7RzA==
X-Google-Smtp-Source: AGHT+IEXdcpYkwXkTQ+3WghcJ8Z3nigHmHIkSUT/mYQ7wS6TOYagzo7gDBEx9fAhucLYM3JlvJhYOQ==
X-Received: by 2002:ad4:5cce:0:b0:6d3:f956:e2f with SMTP id
 6a1803df08f44-6d4377af825mr57173536d6.2.1732126235081; 
 Wed, 20 Nov 2024 10:10:35 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d43812b010sm13456366d6.79.2024.11.20.10.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 10:10:34 -0800 (PST)
Date: Wed, 20 Nov 2024 12:10:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v3 0/3] serial: Support a disabled serial port
Message-ID: <20241120181031.GF3600562@bill-the-cat>
References: <20241120153554.860710-1-sjg@chromium.org>
 <3ff334f3-b8e3-4359-9c02-a35e9a66c432@linaro.org>
 <CAFLszTgi5uoAYgMNO_72XjU1zrTf=eAJF21a7rZpwQ=Ht+K9mw@mail.gmail.com>
 <7d13e591-11bd-4ee4-a3a7-96c59a2f7b22@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="29h70y9/W6sgK4TI"
Content-Disposition: inline
In-Reply-To: <7d13e591-11bd-4ee4-a3a7-96c59a2f7b22@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--29h70y9/W6sgK4TI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 05:37:35PM +0100, Caleb Connolly wrote:
>=20
>=20
> On 20/11/2024 17:03, Simon Glass wrote:
> > Hi Caleb,
> >=20
> > On Wed, 20 Nov 2024 at 08:56, Caleb Connolly <caleb.connolly@linaro.org=
> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 20/11/2024 16:35, Simon Glass wrote:
> >>> This series provides a way to tell a serial UART that it can't actual=
ly
> >>> work, at runtime. The main motivation is to deal with a coreboot feat=
ure
> >>> where it does not provide UART details in the sysinfo structure unless
> >>> the UART is also enabled in coreboot.
> >>
> >> Why is the UART driver probed if coreboot doesn't provide the necessary
> >> info for it?
> >=20
> > U-Boot doesn't do well without some sort of serial device. That could
> > perhaps be improved. But the point here is that we need a single
> > U-Boot build which can start from coreboot, regardless of what
> > coreboot decides to do.
>=20
> Right, I'm suggesting that at runtime you notice that coreboot didn't
> provide a serial port definition (or gave you a bogus address or
> something) and skip probing the serial port in that case.
> >=20
> >>
> >> Couldn't you disable CONFIG_REQUIRE_SERIAL_CONSOLE and skip probing it?
> >=20
> > No, because I want it to work if the serial info is available.
>=20
> This option doesn't disable the serial port, it just makes U-Boot not
> panic if it can't find one. For example I enable this when building
> U-Boot for the upstream supported Qualcomm phones since many don't
> enable the serial port in their DTS.

Yes, this feels like an oddly coreboot specific solution to a generic
problem that we should be able to handle already I thought? Like a Pi
can have or not have a serial port enabled and still have video and we
use that. We might well need something specific to know the port is
disabled since I gather we aren't getting a devicetree that says status
=3D disabled in it. But this ought to be a common enough general case?

--=20
Tom

--29h70y9/W6sgK4TI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc+JhcACgkQFHw5/5Y0
tyx2OwwAhYsaNzXQ5pj1dcAuPwfAMeYcJ5A3wMcaC+lRRuCmUnULbaR4KUabAVNa
Drplf2OLWNFz2OhA4kvZEaso3UO1D0Z899ortnTD+MmYDkNWZhv8wXx1OWxVgNcQ
ly/SysYYZyZ7oCbgUBr1kBYaybT6ppMEp1qyCM3KZ9BDG2bOVg9vK4iCit4Ucf6c
7L78zZRGsx2MlGHM7wEYhkyBbeAbLWvstwWAwaY3o4quJJFT6bjbEMbEoFSLHWZK
C5Nx9icmw8gjTuW44vNoKiVSNYlq+CVSj3XdoJWfRgiSAqq7fKuUaoWkcDNIdlH4
rs5zuQaWM8PmHQ6F29g1d7jtWtvJqhSadQxKrLzW7OUhQCMyGHtbylEDtnEvrbAC
rJyuD2oHGL4FavOMAXK/KOcdvhsJTLgrfvGRjdME6BtsBNQqBGhO74wA35cFZDQ3
E8oUDqOqfLQaI6/4kwYArZXkrbGLvQcduuVEMWlBdYcvLLeXWspG4VvWXE0XSbFR
+bvqOcGL
=ieFT
-----END PGP SIGNATURE-----

--29h70y9/W6sgK4TI--
