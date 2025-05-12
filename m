Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21457C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 14:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE41828BC;
	Mon, 12 May 2025 16:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mip1Fs1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F12EA805D7; Mon, 12 May 2025 16:19:41 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CF26805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 16:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2d060c62b61so4536814fac.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747059578; x=1747664378; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EGo5ojqT2H/50ZyRpWik93iE6RYOOAI3qMyPJjp7qNQ=;
 b=Mip1Fs1aiWM8qddVSihxAleLYUBGO+NMEf1fyTX8i/WlPpCwa/gXujP+0tXFUJM0Mx
 26to2NbVkCTbjKoJxKWkzR4Voe9ffHsqVYX/np+6JFFNIT6uJQd6EmglIz++IfZfxfuU
 qdNgEQc1RalmsK2ZBbni9T0gW48JXZnoP5iyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059578; x=1747664378;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGo5ojqT2H/50ZyRpWik93iE6RYOOAI3qMyPJjp7qNQ=;
 b=swhyeRNBtWBU4p+J1B2ExcgiIqmkjvZtf2Z6U153bhDeoLTsngkgLhHPBHs92Gen8R
 bA+WcoFwOYLPvTuqj/tRMABrcNggjB77nfkYIkKR3yuzPP/Lb2zGhMtLtGrcoBOBpHAn
 wU7lAKoijotVnOGZ6ehSHDXy7Kj5cPa/E60gOaDHX7KbZbGNrl5nJ7fHhXSApbtquvHI
 tQgyMCa6C/H2X17OefMFo5Z/yVaxwq6PP1Uz58mokHRWHX5HnqNnEdW7lnR06hJ4E6/P
 wtG9EtaavX+OBbi8Hgn1MqtMhTT19uoCJ7gs72On7NlvhNNzmt1Pdw5REMdJm9Q1P5+S
 EwOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz7JxerUxovwu6U9JNNbKuHUMO/Lda2hbT8Htoo1/qIuz1XfayUfbAmtO/59kYD3GUmwF+VI0=@lists.denx.de
X-Gm-Message-State: AOJu0YxsRlbEaYFGLDrAvqqgFP2KgRv7zS9FwROSw+ocKGiube0siZeQ
 v1IvmrEksR28WEZCDBxu01uS629t/Vj+3QRUCN5YDphN9TT6MNEwF2ZasXfn/2A=
X-Gm-Gg: ASbGncvYQxTA0FmamnVvt6Qd09jo4/SQubkT5sOmT40dLdk7gEH645oiO1CwvybMTos
 x8i53iB32xeRro0+RZgfYQZfOKnKjw9aTfS8ahIb+haWY5JeiCZDNOKqSXOdgWEM4aGvnC+fx3w
 uyODwwVYAh3mYqRHuJN/LWaV1sFvzb0r0UfmiU8IZAXLRH+eTqPVC/6tcguV4z3mAUbCWsopG7E
 TPg8/X44WW0wIxyX2h+xrnoB8JfDxHL/KaQRyO3Qzu14FDB1fhgM3Bf1q9KlqnoTzR6otIF0fjZ
 jAaDd25uBbKGYY2RdgrUZm7gA5ww8l1Z7eHvYkSLKWMmkElr4BIxUsx+pxP/yUH/E07IUqF31WQ
 hybnkHzwF02bW
X-Google-Smtp-Source: AGHT+IG3HsXbfILG4x/vPbdMPHeWtrV6NSs/m06SN/pdQYKVUu32fWAGycnpXFpvGO/W5QmF3WiHcw==
X-Received: by 2002:a05:6870:238c:b0:2d4:c19a:94e5 with SMTP id
 586e51a60fabf-2dba454accbmr7373882fac.39.1747059578102; 
 Mon, 12 May 2025 07:19:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b7a1d5sm1819101fac.42.2025.05.12.07.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:19:37 -0700 (PDT)
Date: Mon, 12 May 2025 08:19:34 -0600
From: Tom Rini <trini@konsulko.com>
To: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Gaurav Jain <gaurav.jain@nxp.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [External] Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on
 startup
Message-ID: <20250512141934.GP603748@bill-the-cat>
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
 <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <20250509150126.GI603748@bill-the-cat>
 <BE1P281MB22924D99EB000FDBDF295A85E197A@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Rsmn1HG2LHj0lOJP"
Content-Disposition: inline
In-Reply-To: <BE1P281MB22924D99EB000FDBDF295A85E197A@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
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


--Rsmn1HG2LHj0lOJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 05:39:30AM +0000, Baehring, Olaf wrote:

> Internal
>=20
> Hi Tom,
>=20
> sorry,  this has been added by our mail system. Next time I will post fro=
m my home PC.
> Of course, as this code is open source, this fix should also be published=
 to the open source community.
> So, let my confirm this.

Thanks for clarifying!

>=20
> Best regards,
> Olaf
>=20
>=20
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Friday, May 9, 2025 5:01 PM
> To: Baehring, Olaf <Olaf.Baehring@draeger.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>; Gaurav Jain <gaurav.jain@nx=
p.com>; Marek Vasut <marex@denx.de>; Peng Fan <peng.fan@nxp.com>; Simon Gla=
ss <sjg@chromium.org>; u-boot@lists.denx.de
> Subject: [External] Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on st=
artup
>=20
> On Fri, May 09, 2025 at 09:40:44AM +0000, Baehring, Olaf wrote:
>=20
> > Internal
> >
> > In rare cases U-Boot returns an error message when intantiating the
> > RNG of the CAAM device:
> > =E2=80=9CSEC0:  RNG4 SH0 instantiation failed with error 0xffffffff=E2=
=80=9D
> > This  means, that even when the CAAM device reports a finished
> > descriptor, none is found in the output ring.
> > This might be caused by a missing cache invalidation before reading
> > the memory of the output ring This patch moves the cache invalidation
> > of the output ring from start of the job to immediately after the
> > notification from hardware where the output ring will be read.
> >
> > Signed-off-by: Baehring, Olaf <olaf.baehring@draeger.com>
> > ---
> >
> >  drivers/crypto/fsl/jr.c | 30 +++++++++++++++++-------------
> > drivers/crypto/fsl/jr.h |  4 ----
> >  2 files changed, 17 insertions(+), 17 deletions(-)
>=20
> You're starting the email by saying "Internal" and then there's:
> [snip]
> > ---
> > This communication contains confidential information. If you are not th=
e intended recipient please return this email to the sender and delete it f=
rom your records.
> >
> > Diese Nachricht enthaelt vertrauliche Informationen. Sollten Sie nicht =
der beabsichtigte Empfaenger dieser E-mail sein, senden Sie bitte diese an =
den Absender zurueck und loeschen Sie die E-mail aus Ihrem System.
>=20
> So please confirm if you are intending to publish this fix to the open so=
urce community, or not. Thanks.
>=20
> --
> Tom

--=20
Tom

--Rsmn1HG2LHj0lOJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgiA3MACgkQFHw5/5Y0
tyxqHAv+MxAFZ0Hxi+sZpHsgUK31X1ZXxNe+2yexznr2MDTliUTGFHG5Kegbft95
93UuFsywcGHgUzcpJezoBpjGO8MOHcyKslwa+ZeD/TcQR57jdhTQrrcz7GJCq/B2
cNDe2P6t5lX32LZ00XfvxVW+HuHRdoSrnDUcoJHUfjsUkXqvISAK9klE0JNWsEq+
Wj2fYD6eaoXLi0JZjqXonc/G4w746YYVRm8333VcWYIt/Nj+CP6UpdZ5Tn3WZk0v
3451uUBVjiuZeZbb6P+0uPNCLrKaW1VylhVaopwHjm4Rele+e5kOZtQzSPlF+kH5
jupV8ddPN8pQVAUDDi24JhHlf21m5UL6Q4+dwa+CPkgnMTyuhRps+u9Tc5387mIG
g9tctxvdACsSdvCjbsQWnCLkCD7yHi9Le+rVMCD7dUkCRFws44Og7XL3ipiivGDl
r2a73P+LJKUDfvMDKw2JCW2ecxNKexO0BpYOkogzqo1hDScofLA5oldScDXClX+H
Kmp+jXQR
=eYqb
-----END PGP SIGNATURE-----

--Rsmn1HG2LHj0lOJP--
