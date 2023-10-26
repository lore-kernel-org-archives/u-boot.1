Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E71AC25B67
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 16:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E776875C8;
	Thu, 26 Oct 2023 18:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GoDdICVz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8142875CC; Thu, 26 Oct 2023 18:07:07 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43956875BD
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 18:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cc7379b23so7494211cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698336421; x=1698941221; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gBpUlpv+ddEgG5mprJaMQY21+wtMfPWtHNUt+um0g/M=;
 b=GoDdICVzrb0wVfU42kV7uGw+bYAi3/k8/t55iZUcE+tcS52QOnB9oF0EjL4PqFURyj
 cj0I02VMoSRkXBNA6Dv2ri/YcpJ2aAClqdbSfRCd2h1qwQ5ZZcjv+1nIUF52KLWlsIb+
 RpHkn1rrXp+7TfHJs+KfFVZAfKD21iVwqY4BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698336421; x=1698941221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBpUlpv+ddEgG5mprJaMQY21+wtMfPWtHNUt+um0g/M=;
 b=UeUToQmnJLRSOzgVxD/c8XZN3DwPbfSdr/zul2LkCdSuUj/372UzaZUGCdeIDra38e
 vhHck0j0oJSrvA/67SoHs7Wn/VG1oiXyRgLwQqti8waMDpuFXLO8P/HDoK+mqXoexM2Z
 rWd3B6ewbB4/ZM0dspiPv6LCzjKEo0i7dDfLnMN1GH00jilHSeDaf20QoOy9crA3GlAh
 uM7R4dsCSxWnV0edlL20zyFuH+AMYUD2y16CPKsvpWlXqYxcHdVj5YquG9EAiTd/PW6q
 Uomk1giZ5C+tVSgrA3+b1PXIG17Iya0gfi27UJiUbohHSeQRorKIc1q5D/dKmQ3ixD9D
 KcIA==
X-Gm-Message-State: AOJu0YyPZenmIccZ8rrlPupSYgP2tIzRGc7dcH/TsjM6NUd2+YZrl3Wo
 E7sgFA8ViCz7TAw1S529ZIFEYw==
X-Google-Smtp-Source: AGHT+IGyR7ft/tIQ0knw00FpliHQS6BRUUnriHv9BhBFDkfebkXyDItLsW481BV7iqRbGbfBiUNM1g==
X-Received: by 2002:a05:622a:15d3:b0:41c:d8b6:27ef with SMTP id
 d19-20020a05622a15d300b0041cd8b627efmr22409894qty.65.1698336421223; 
 Thu, 26 Oct 2023 09:07:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-7a1b-75c0-d849-e3ce.res6.spectrum.com.
 [2603:6081:7b00:6400:7a1b:75c0:d849:e3ce])
 by smtp.gmail.com with ESMTPSA id
 9-20020ac85949000000b0041cf5ec8b75sm3903836qtz.96.2023.10.26.09.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 09:07:00 -0700 (PDT)
Date: Thu, 26 Oct 2023 12:06:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v8 3/8] power: pmic: add the base MAX77663 PMIC support
Message-ID: <20231026160658.GJ496310@bill-the-cat>
References: <20231024074110.199623-1-clamor95@gmail.com>
 <20231024074110.199623-4-clamor95@gmail.com>
 <20231024191757.GG496310@bill-the-cat>
 <CAPVz0n3b4eH0q3sPGD7UkjVo56r__6AzoJsuwKy+XVPPCQX+xA@mail.gmail.com>
 <20231025133712.GL496310@bill-the-cat>
 <B68639B5-C9EB-4300-B745-0265604BAFE6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J3DneV1H/NxDB5aU"
Content-Disposition: inline
In-Reply-To: <B68639B5-C9EB-4300-B745-0265604BAFE6@gmail.com>
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


--J3DneV1H/NxDB5aU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:49:01PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 25 =D0=B6=D0=BE=D0=B2=D1=82=D0=BD=D1=8F 2023 =D1=80. 16:37:12 GMT+03:00, =
Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Wed, Oct 25, 2023 at 09:10:12AM +0300, Svyatoslav Ryhel wrote:
> >> =D0=B2=D1=82, 24 =D0=B6=D0=BE=D0=B2=D1=82. 2023=E2=80=AF=D1=80. =D0=BE=
 22:18 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >> >
> >> > On Tue, Oct 24, 2023 at 10:41:05AM +0300, Svyatoslav Ryhel wrote:
> >> >
> >> > > Add support to bind the regulators/child nodes with the pmic.
> >> > > Also adds the pmic i2c based read/write functions to access pmic
> >> > > registers.
> >> > >
> >> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >> > [snip]
> >> > > diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/ma=
x77663.c
> >> > > new file mode 100644
> >> > > index 0000000000..4070235d3c
> >> > > --- /dev/null
> >> > > +++ b/drivers/power/pmic/max77663.c
> >> > > @@ -0,0 +1,86 @@
> >> > > +// SPDX-License-Identifier: GPL-2.0+
> >> > > +/*
> >> > > + *  Copyright(C) 2023 Svyatoslav Ryhel <clamor95@gmail.com>
> >> > > + */
> >> > > +
> >> > > +#include <common.h>
> >> >
> >> > Should have noted sooner, sorry. Please don't use <common.h> in new
> >> > code, and audit the include list you have as well (this one looks
> >> > reasonable I suspect, all the same, so general advice).
> >>=20
> >> Each and every driver in pmic dir has common.h so it was an obvious
> >> move to include it as well. I haven't seen that this header is depreca=
ted,
> >> if so, sure, I will not include it further.
> >>=20
> >> About auditing inclusions, I never include unnecessary headers and alm=
ost
> >> all the time run tests to determine the least amount of inclusions pos=
sible for
> >> correct build and work.
> >
> >Yes, it's more recently formally deprecated, and just removing it fro
> >existing drivers is on the TODO list.
> >
>=20
> Should I reload patchset with requested changes?

Yes please.

--=20
Tom

--J3DneV1H/NxDB5aU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU6jpwACgkQFHw5/5Y0
tyz1DAwAoPdiyIRfcyRO4DONeYkkkcpCz4rtQoL27eXZ8ZadpRiEk7Atxz04oXP2
f4D4WSS+ZMzlmR/0mNEEYkM2DMfvsyY9+VDCTAO3SraSPp0sfIEY+rlM/Dl2uzfn
/dhSBVm7PD8yLP83qJfhSLN1HoFjfY5pknIv70f88PclRCXlibFmgWqIFlGHrkiT
YzJZNpN+HTBihuXb9IzAJZknaRdU2B5EoZZxcQq9rw4cs8uLg82BnnxicQBBWz0S
m7g/V9nUl1Qe/0umyDp3oBRPQU2EYXOnccB2frZFdK3N/5zhKSuih57xMZSNYujz
HpISA9SmezYXGyfrJ2V0eStXKWqcYuIOYmQ3TAXd7Gq5xheSHF+tWR5ujUGG+Ipj
boFNTld56VGSLxSNKr1Wj47/W4KUAi3ySEjf65hQk74FXcHesoKZXSDFVyNZ/tbF
+RuwyA1n9ET0piKddPk+W/xi+7CrC6W1SwfkAaexGzHddFd6NseuSLqgwQusCz8N
uuqBk4r3
=LPlj
-----END PGP SIGNATURE-----

--J3DneV1H/NxDB5aU--
