Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D13C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0332B87642;
	Tue,  7 Nov 2023 23:03:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a2qB6ZsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29F487652; Tue,  7 Nov 2023 23:03:11 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E6286E96
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 23:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6705379b835so40396036d6.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699394588; x=1699999388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kTTy85E51eavh9Tw30/HUzGjnVuedag/NWhYfYpnl+E=;
 b=a2qB6ZsLD4xQf4YO3Ya0zahVC+CTBgB3TD+qWuMbYx67qbHkyUfG45EqBYniOgxID0
 FfzqtKo8PoiFaIR7FxqMpZdcQMnM0o5pnC0ytBMrA3cdjlRH+EWFJ68mcDo5StmueWoH
 XCRp4xQmfNUV4Leuj6BM5L7512ep25cKz0Q9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699394588; x=1699999388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTTy85E51eavh9Tw30/HUzGjnVuedag/NWhYfYpnl+E=;
 b=ESA2HodlvCU9Yqalwc2IiK2QzjUX8piL5+wdnLLVYCbTOWAbwNhi92szgyORDwBxXm
 3qDNzQYFGoZ4ihNIBZMgXZdFhOECvedf0HI1PFZsMZrLYJQebzWwFqAHCvM+Q5IsFTrg
 jcANrOZA7M2h8mvk4oqXAe/rfZdaRqHAppJqbYWQwA07AeUy8ExyEc66eYPFoZkT+7UN
 msMeDpRu1HTKdbYf5S8QG5vgiDhVk3nwTupWRKq5SCmNptaesiqR4l0W3gqbjMrF971B
 WW6K24rJnILVw9GeCLckE9f8XqRoNWbr+unP63zxPPE15oz0bhFWYzvJst0/I7Z8eR+R
 nz8g==
X-Gm-Message-State: AOJu0YyylqOnxZUIj54f2YTaoProjTjOwQiAYyjmn8Yp77MtsAAeeAT1
 4uS2z1lO/TrLUxS9vH/QZgSb2Q==
X-Google-Smtp-Source: AGHT+IHdI4HhG2re1WrXC4P8Xa2CBBTnyrQtTrr82lBYMn7ZS6T0ZO/zJD3gYT8c2kunO9Obp557gw==
X-Received: by 2002:ad4:5c4f:0:b0:66d:775:d1af with SMTP id
 a15-20020ad45c4f000000b0066d0775d1afmr54562qva.59.1699394588492; 
 Tue, 07 Nov 2023 14:03:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2fee-489d-8907-1a68.res6.spectrum.com.
 [2603:6081:7b00:6400:2fee:489d:8907:1a68])
 by smtp.gmail.com with ESMTPSA id
 ml21-20020a056214585500b00655d711180dsm344188qvb.17.2023.11.07.14.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 14:03:07 -0800 (PST)
Date: Tue, 7 Nov 2023 17:03:04 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107220304.GR6601@bill-the-cat>
References: <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106215331.0d770df8@slackpad.lan>
 <CAPnjgZ2GY8o_UR-rqYOimYe1t_NV+6eAa8rZY3Eaak6vp7Vciw@mail.gmail.com>
 <20231107112708.4030f2e1@donnerap.manchester.arm.com>
 <CAPnjgZ1eMxbJGhxSGF1NgCELz+MOoPK0k3hsB-hzEXTo0=3szQ@mail.gmail.com>
 <20231107151248.0c6247c4@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OwQiMMf20jl0LH76"
Content-Disposition: inline
In-Reply-To: <20231107151248.0c6247c4@donnerap.manchester.arm.com>
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


--OwQiMMf20jl0LH76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 03:12:48PM +0000, Andre Przywara wrote:
> On Tue, 7 Nov 2023 05:22:58 -0700
> Simon Glass <sjg@chromium.org> wrote:
[snip]
> > We already have a perfectly good way of selecting between multiple
> > devices. It is used all over U-Boot. We should not be inventing a
> > hard-coded hack just because we are confused about whether something
> > is a device. Just make it a device.
>=20
> And this is exactly what my ARM RNDR driver was doing: using a
> UCLASS_RNG driver interface to expose entropy. I just don't understand why
> we desperately need a DT node for that? I understand that U_BOOT_DRVINFO
> should not be used, and this is fine.

I think part of the problem is that U_BOOT_DRVINFO probably is the right
answer for more things than it might have been intended for at first.
Because yes, looking at the driver right now, whatever semantic-wise was
mentioned earlier in the thread is applicable, but it otherwise looks
like the easy path to "one device has many functions" without us having
to develop some special case bus to put things on.

--=20
Tom

--OwQiMMf20jl0LH76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKtBgACgkQFHw5/5Y0
tyx9fwv+JezuKNFbqdrcgFLHVB50310yq1xDo0STRq3x68j6CiPDso8Zr4j3dH5h
aUmW7Hnin/7wdZMjJCt+iaHq0BlETrui1Wi2zA9eW290xq4bU/H+8ls/IuW/HXEs
nHO+Fkydl1fEb09/b9666zeGSlDuQD8KPE7p0z5AO/EBheQ7GtLeF1dI5ydIORey
oGmasuwx41W8qKHmjz3a7aoj+MZXRfridEpodA8x/zIifh+/cfHqeZ++d45ARIbv
Syc1LeDKuSiT3G+Q7xmFzZJbTBOJCbRUmYD4/ieEj/Xe7ZoxGMyw64LT4RwnJYQH
9IJwBfyRqPuTUV3P5xhiJYBiioTZ61Lyo3JWolbY8avPnlttvs9ennL0pTeX4sfB
AmhNjzVPscDXYGEZUcKBtfUo3I3pWHvTP16RmwosSF7pn4bjswUgAY9omT6NUUUG
y1OpytncuJXWM1er8ruygKlhT1vgIXuy7lCEZTERnWRZRgdFuyWZTL+JICVaAEjG
PKF6qaeN
=hGdT
-----END PGP SIGNATURE-----

--OwQiMMf20jl0LH76--
