Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C8BE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1182E80241;
	Wed, 18 Dec 2024 16:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IErrJAr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0013280269; Wed, 18 Dec 2024 16:42:49 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B668022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46783d44db0so68569171cf.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734536566; x=1735141366; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WRyCYrvU/IJN81CavGGrmnO5hFig+D32tYUuwtN1Jv0=;
 b=IErrJAr/aQ34DaCRgTdTL5SpsPpvYqh9lLOMOAuyVEyi43WAdtcyQVghiBW+KzzEF2
 MIpkG3Y9v9BzfNsv+OhS+w0xiupGpFdO2XY4gomxxbOQxW/aKPyFFmKfeDl9Ltqw/sob
 NpSy0zrHY3ZwFFAwQt11iqRzaISG5GFGoCIzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734536566; x=1735141366;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRyCYrvU/IJN81CavGGrmnO5hFig+D32tYUuwtN1Jv0=;
 b=fO0QR5mvhL/vz2N5GX9bORJHTe/vZWgcs28YyQg+oNnAOhV9xDzdaqnTGGNDjjey2n
 1NcMHxRQ5b4jc+DXF0S5bWGE6DzaNOP+I8IIiHP/nOKEzx6dJGBPaLUaYw3NSKWPxkxC
 19Hj0WHhFtlPkI0++fYWQc+rriI0wVWx6SIhfpo9dMR2MiLthXAcWOX30T4FQ0XIA50+
 tuq+mC5dbsDWX5H2MjfFbDCenwJ83DgNDNibJPxK+PjBPwycXhbBuEXCh5/WQYOZhslS
 Q0ju1+42vWuBLLETtdm3ok8QOnE76pgOtRbSQ8MHJxY5PGs8omUSZjz6vpTKlVakB0dl
 bT4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU24Gydxrh9nQAWamzGl7NURetsjm/EaWGCavMprUc6ZZcFuvbfRhw1zYUxnDDtQap8eAuubFo=@lists.denx.de
X-Gm-Message-State: AOJu0YxYlC/W+kzLb/FpSyrEJtBlqvpLXtaThDYGD2m1WuZDQrqvS2RU
 wwoc9EYchmLntcHwnr8PjyA/wsf0YUMVwBHeg1vTKGGO37iMkJIVgIhg4KZMEx7eVk3HDZ2vi1F
 I
X-Gm-Gg: ASbGnctaUPPIBo1J0SYQduHGBIcegUFDCwKxT5CFfw5yrSaH+Pe6AQX1KF4WPecFZVH
 DI00mwTOwWOMRiwt55lP5iwzl4vFlKoHa2do7locsfDTwfbWTKh5jR2VQv8/6IpWj80iJcoDhWV
 KWzSiLUpsOhEdvlzeg1JaRcTtLgvon7ywCALN/PCcdJopzN+6OAwKK8nXv1rDbvYNelSKolfZLG
 d5R4iadrAHCJ+IQtbgf8/olD+4/34viiq/Q8cScnSlDpbna5PpjFRS8
X-Google-Smtp-Source: AGHT+IEJzQIU+FSUfHbpB/Zx1z6IHjRr0jdLchhHnWa6XCfNACdKa89WDrg3JwLL7UevT6WHD2Vz7g==
X-Received: by 2002:a05:622a:308:b0:466:a091:aa3f with SMTP id
 d75a77b69052e-46908ed20f0mr50699551cf.51.1734536566273; 
 Wed, 18 Dec 2024 07:42:46 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2ca0a76sm52050401cf.25.2024.12.18.07.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:42:45 -0800 (PST)
Date: Wed, 18 Dec 2024 09:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] gitlab: Add samus_tpl to the sjg lab
Message-ID: <20241218154242.GD1505244@bill-the-cat>
References: <20241218150802.4064561-1-sjg@chromium.org>
 <20241218150802.4064561-2-sjg@chromium.org>
 <20241218153045.GC1505244@bill-the-cat>
 <5ede6d73-3b95-4b18-b7aa-3f0a3ed56acf@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="evqjXwpxitr64KqX"
Content-Disposition: inline
In-Reply-To: <5ede6d73-3b95-4b18-b7aa-3f0a3ed56acf@cherry.de>
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


--evqjXwpxitr64KqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 04:38:02PM +0100, Quentin Schulz wrote:
>=20
>=20
> On 12/18/24 4:30 PM, Tom Rini wrote:
> > On Wed, Dec 18, 2024 at 08:08:02AM -0700, Simon Glass wrote:
> > > This board has two variants, one of which boots with tpl. Labgrid gets
> > > upset when they both try to claim the same hardware, so we might need=
 to
> > > see if we can handle that cleanly, e.g. by making the job wait.
> > >=20
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >=20
> > >   .gitlab-ci.yml | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > index c620cfd1e34..72959427951 100644
> > > --- a/.gitlab-ci.yml
> > > +++ b/.gitlab-ci.yml
> > > @@ -593,6 +593,12 @@ samus:
> > >       ROLE: samus
> > >     <<: *lab_dfn
> > > +# chromebook_samus_tpl
> > > +samus_tpl:
> >=20
> > I think you can just add:
> > needs: [ "samus" ]
> > here and gitlab should get the ordering right, but I didn't pass it
> > through the validator.
> >=20
>=20
> You probably want to not fetch artifacts from samus job though, so disable
> artifact downloading (if there's any), c.f.
> https://docs.gitlab.com/ee/ci/yaml/#needsartifacts
>=20
> or use a resource_group, c.f.
> https://docs.gitlab.com/ee/ci/yaml/#resource_group
>=20
> you could have
>=20
> resource_group: samus
>=20
> in both jobs for example. I think this matches more the expectation?

Yup, that looks right, thanks!

--=20
Tom

--evqjXwpxitr64KqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi7WsACgkQFHw5/5Y0
tyy+jAv9H5tFKBS2GdJNAuPpw2qQRx6DXch8qz5pGe5PPvJq0dJ2oBV1hdaU2JOw
zw/JkDtuDkUOd11SB9q2rV1rj/kS74HNZAHRoFtZLeOnKM59/CldeWYEeIGUN2fh
eBlleS4lcj46zpP4B7ESX6GefM6g85/DduYQF0760M0FyJ2PmApVjcTLQPLD8/6M
pAI/2EJvM78e4ez9x016csjo98LjtBV6VdaODqD+0v9HroNyPgRiitrKrjIJO4VY
+dj9EOd+F44qt82XAVT/DXLghwIrt5k0si5Y5nPSF6B7cmv0fTr8Qygj49VX/scI
7GQ815ffhUYi6q5eJsZsvSB6/g+IJMTzZ2dHFh9ic45ZNc6xQKt5mV7lKzX63Gny
iEcFKCDC5ikhmuFcbCq4/YMyO0TIGs8j5sGijppCtCbose9Thi/vVS6253ndhPzi
h4j7gaJD+Rj+2xnQ0xiuuxNhhYEaBFz1bsEASXNIosDB0ylWgrmIVpKN58sLGQfT
dk/bCqSZ
=UXEa
-----END PGP SIGNATURE-----

--evqjXwpxitr64KqX--
