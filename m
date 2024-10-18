Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C87D3F295
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 20:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE95C88D5B;
	Fri, 18 Oct 2024 22:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hvMfNO+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5020F88DA0; Fri, 18 Oct 2024 22:37:05 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9B888BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 22:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cc1b20ce54so19100866d6.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729283822; x=1729888622; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2HCHfC1ihe2eeBXzab4ZZReDlIvYpkiiRU3rIELt8bM=;
 b=hvMfNO+cxvaJF6f85okkIcPcOUFa8AvpQQ/jHzKaZrs//+nHoENOgIGQNcDgv/AdA5
 GGJatCRxS8Vu2B2805JWsntEhtBbN0dmUOQB2R7FjEqn7RjRVTWTlFIN9hug5TzrZjHK
 oeeCOYqVooA9F5yI5fVkhjsdxrKao7Y55bmCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729283822; x=1729888622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HCHfC1ihe2eeBXzab4ZZReDlIvYpkiiRU3rIELt8bM=;
 b=YGLZCBTaUF0SzGPDDKIBHmSlL8+6Sg9+dMh6r0GlMEjnxp5wckm+zoHAKFBqE44mdq
 NFNiVRIBn1Zn2LLr/oDHmoTcspuWxi6J4gKTv0ZuA8tpNqzA+okyGkzul832CWcx3NuM
 M+5yCQKsJIfupgcOR3AFPW+eGD/azcNRZ5hTSNrguw+wELyw9h4zMLcgk+vz/Uu7Lmgs
 CScebwIzhJ2E8DnF1J7FOllgbdanKr2dBPB2h4UIKPIuJbG9eOC81+MSiKtEd03VZ8IU
 DxEJ2Cq22RR3pSDH+0xGqU0wmgSTWN+YSVx4rE3DFqhJs7KadTr6cEqpopkF+eGZHUG3
 zy0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlEdhttJFAz7NPOUH/s+FTNi2vCz3ISiDWPWig5Xb9tiRKkbwGBTA41Op/XtOuxzCqNuf7jXw=@lists.denx.de
X-Gm-Message-State: AOJu0YyLXsTZQPAcadapBjuzWEBn+0GoiZiJ3jCedw5evIlUl5pApcS8
 aoAs7D3a8Dqu1abfZ4xpxBb+AmsjNt5y2R6aPsfW5+8RdazfIMdkh1Tijr5ImMI=
X-Google-Smtp-Source: AGHT+IFsL6TUImaYtJ7iB23j5ZhCvM+uAXIJJM/uB72tV7NRXanTJ4Hozyouwb4Am+VbLfqXxvMYyg==
X-Received: by 2002:a05:6214:5543:b0:6cb:ecb1:e6c1 with SMTP id
 6a1803df08f44-6cde1508007mr51053426d6.17.1729283821890; 
 Fri, 18 Oct 2024 13:37:01 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366582sm10393016d6.117.2024.10.18.13.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 13:37:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 14:36:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] sandbox: add bootmethod EFI boot-manager
Message-ID: <20241018203657.GJ4959@bill-the-cat>
References: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
 <20241018011837.126813-3-heinrich.schuchardt@canonical.com>
 <CAFLszTjjF1r4f6NjrYSFz36DK_X6v6rYMwDCUqiSLOPysGRC7g@mail.gmail.com>
 <ee96c1c0-c1d5-4f18-a1eb-f6460e859683@canonical.com>
 <CAFLszThZ-s1Kwhv0DBoEG2uKE=MFdb_CmOY5hn0O5dVuFUP=Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qPSCwz5UxeJ33ePA"
Content-Disposition: inline
In-Reply-To: <CAFLszThZ-s1Kwhv0DBoEG2uKE=MFdb_CmOY5hn0O5dVuFUP=Vw@mail.gmail.com>
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


--qPSCwz5UxeJ33ePA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 02:17:36PM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Fri, 18 Oct 2024 at 11:26, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 10/18/24 19:21, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Thu, 17 Oct 2024 at 19:18, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> The EFI boot-manager is the default method to boot EFI binaries.
> > >> We should be able to use it on the Sandbox.
> > >>
> > >> * Enable EFI boot-manager bootmethod on the sandbox.
> > >> * Adjust unit tests to reflect the additional boot method.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m>
> > >> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > >> ---
> > >> v2:
> > >>          no changes
> > >> ---
> > >>   arch/sandbox/dts/test.dts |  4 ++++
> > >>   test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
> > >>   2 files changed, 21 insertions(+), 11 deletions(-)
> > >
> > > This is better, but I still see this.
> > >
> > > =3D> bootflow scan
> > >       efi_var_to_file() Cannot persist EFI variables without system p=
artition
> > >
> > > Please find a way to get rid of it. I can give some suggestions if yo=
u like.
> > >
> >
> > Would you, please, mind providing a rationale why you want this correct
> > message not to be written.
> >
> > I expect the sandbox to behave as any other board and provide warnings
> > when they are adequate.
>=20
> Well, what I am supposed to do to fix this warning? I just don't want
> unactionable messages coming up in bootstd.
>=20
> If it happens all the time and cannot be fixed, you could add an
> option to the driver to ignore it, which can be controlled from the
> devicetree node.

So, you're scanning a disk image to boot from, and it lacks a system
partition. Can you describe how you're creating this disk image? And are
you testing something EFI related, or not? And then Heinrich, can we be
checking for variables any later than we do today?

--=20
Tom

--qPSCwz5UxeJ33ePA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSxuUACgkQFHw5/5Y0
tyw9Swv/fRf82NME4YlkiFee3JXi36X77W0cQ7L5aA7PRzjNSzGVs9wi5tWIAFiI
/gRHVaQwjh1XbGyuIUcy5QRF4Esx7JpW40JQ+tiorHLh+bl4a/cWYFSFZyvRbA5B
yy/veFjwhTdz+iBDoHYMpHIGW0HnY/PvBjM1uceBkJR5vbXG4f3AdkUqrL6Qt/79
/LavSxTV2pxle9Prnc+egmxlycW7BKz1I7pKenB/fBO5cm2nB//ua93CA+X7Uqwn
dPThWm7sjoSvGtIeF+fikbkDMuLYRsbpMnMO51zOczTU5jo66UX3ku0EL/kJ0fFs
bi7w6XNaqbOHji0J4KAdh5Vg91kSm9trudR1eDdyLr5n8y1rz6eZewxYX7irnR/V
7zopV6ctPpU5syLvMCo5iOcuRFvsUqk3VMLupXOMy4lfc+Qt2/2w99yKjyapaBmG
zkLvFn7sy9fVCYHI+09i0rotbBbc75egd+Iw0P8bEpaEtJt1jI/vrE3UfESm0knA
e6zO7S9R
=mxBy
-----END PGP SIGNATURE-----

--qPSCwz5UxeJ33ePA--
