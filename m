Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82889CCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 21:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE09883C91;
	Mon,  6 Oct 2025 23:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tcu6iRm5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C3483CD2; Mon,  6 Oct 2025 23:44:42 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C821883C91
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 23:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7a7d79839b2so4367996a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759787079; x=1760391879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rqcjjiqwTOQlMPDNDwtepzlWZ5HzqRC2RsUeaM3UJBA=;
 b=tcu6iRm5yIGjL1eNJ8n5KXijQbamoNTbP3YOt4Wu4h6MMR6Rk3RosjIEAq2rKXjiM4
 /fqXGEqapjGaHTftAEy+aJOoDfRliDZ4bhP3CO6Mio7+65xbxEEp+RvvkbZv9NhcdTfO
 k82gKwqOlSuq5yINRDZY1wwtdLsBaL4WecN/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787079; x=1760391879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqcjjiqwTOQlMPDNDwtepzlWZ5HzqRC2RsUeaM3UJBA=;
 b=r3kiFOVKcFDDFMs9K0odIrSmjQHwrxwkY/buUEOqKjH8KQHR/X6rJUKbJcraR0CeNJ
 2O9jCl07AHDpnXH07q3xC0iRVA93gnJeT0AyZtXciHa01FMPHDd0L/oLLNI/jUGRxbRd
 K3tX9faDBG/81dk1Ygy5T1jwUIH25gaqFv84Y8Oh7ISFyT32tTXGZ8GiC88gjq4CO1cp
 TUu+pEvLnWTOFBwiGt7J+H4G5NGtZXow+R6r8KTjsvlNdQCc3dmepHZWZymRKf6sMtqY
 ta1gsROINah73FLvfYF14W4glXz6AE+SS53X437BtBwk5JPz1exJfOr/kl7pCXxss5We
 e08g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVneZrEYViz28tCXN6LwZUASqRoPulIn9vhiHg1V92FJitww7OD39zo946xm7WJplOZgu2+JfI=@lists.denx.de
X-Gm-Message-State: AOJu0YwUseZ+wu0C5ugohfqIHuWFvvNMCQ2hgMnQKdanli1sBnFnJyAc
 3lUrbjJD8HMhOrYJyvx2L3xO9BwJngcJri1DtuPzDO3RycwgOYeYXrT0OI5jQ9a3enU=
X-Gm-Gg: ASbGncvQsxsW49Ee9ESRGdOFA/854HYqfV7jjfuUziPvCDFaktp0I8WWMS8HMHLvean
 jOKXnxTIJI3WhTcHVl0KHtlMsr+9UGLDfFo7fVYsvcBB1LGyQSljJ5vt0/SbkoccwdigvVz2fb5
 jsX+D5vhUJaHv4zktVG9nCUsXpceIvrzLiyc0lgiaUoK4Ga/KihWQCieijs9nWY2YbUhcFItcu1
 hXOwgaOEHq7eXlE4zn5RebqVqRuYKOLinRKJ3s4Q3nY47Y8FewuHYSr/EuHXplQuC9nIJny2ulV
 UttpHQM+zlikvM0rJXxFnEvwUAzLmDyr3Q2GuwmCaR3MTXZJrgek4nFxIZPlnZddt/MBU37OTA+
 BJkSFqYqfrPbBD9RUfiPVrOZ1mXYifTPa+ic0ozUHOVfuKpo8yBLsTPY7UzoMiylZbuuXSGUt/X
 j6Vwv/FAEEeQ==
X-Google-Smtp-Source: AGHT+IGdI2qhXdNKPFWkDPapxKD9sjP2ETqq0Y7TnGKzbU2/E5DRpZpPoemx1zN44p7zCzmvE7xnUg==
X-Received: by 2002:a05:6808:1818:b0:43f:7287:a5cb with SMTP id
 5614622812f47-43fc17dce90mr6311253b6e.21.1759787079576; 
 Mon, 06 Oct 2025 14:44:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e188f3dd9sm2793461eaf.3.2025.10.06.14.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 14:44:38 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:44:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
Message-ID: <20251006214436.GE298503@bill-the-cat>
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
 <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Grb792DNTJSp+LDm"
Content-Disposition: inline
In-Reply-To: <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
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


--Grb792DNTJSp+LDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 02:38:10PM -0600, Simon Glass wrote:
> Hi Kory,
>=20
> On Mon, 6 Oct 2025 at 10:45, Kory Maincent <kory.maincent@bootlin.com> wr=
ote:
> >
> > expo and cedit tests depend on the host having the SDL library.
> > Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  test/boot/Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
>=20
> Reviewed-by: Simon Glass <sjg@chromium.org>
>=20
> We should be careful that a future CI change doesn't cause these tests
> to stop running.

Given how HOST_HAS_SDL is defined, CI will be fine.

--=20
Tom

--Grb792DNTJSp+LDm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOQ4RAAKCRAr4qD1Cr/k
CtSPAQDLOnjjNz5rUEhQxtpHTz0WtnVULX76UBgzKhAZD0qVugEA5KyYmL143eyQ
odaNVVK/ruhxs3rYynL2+jka90hrTwI=
=VNX9
-----END PGP SIGNATURE-----

--Grb792DNTJSp+LDm--
