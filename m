Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FCAC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 19:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B87884B2;
	Tue, 16 Jul 2024 21:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZiI6pUUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C27884C6; Tue, 16 Jul 2024 21:07:19 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EDB88246
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 21:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-25e15406855so3371731fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721156835; x=1721761635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0LHevZ9Tb4YN17UkN4Ifw5qKxfJ0DF38DRqOZ+/iob8=;
 b=ZiI6pUUgHgFHq1E+yB+n/PzXJvOoXwZPGO40/ewXUYTsjNVMGWjZQRCz8HKcgXHjU1
 uG5nhShr+BsB5plouj30jLQuWBN4CB/LGGVwREij+NGS1dC1tIeHW/eMbX1b8qfBjR8Y
 EN5f2Nf0eI1JQUEk+glsIYBUa4k/6y603ILx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721156835; x=1721761635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LHevZ9Tb4YN17UkN4Ifw5qKxfJ0DF38DRqOZ+/iob8=;
 b=G02XmzsKL9k0bya4ps8WtHo8PAOJ4+gHk9x5X7OVC7ikxGC0GuzH26RjG+FuZkVTJw
 QWlf2lMvx6p/I+3hlft2ybAh4fnP3+/x2TnKvOzp9hXVUXWCRHqjF72LEVj/lqLsVUtw
 N0qD0mYrsZ8Se6oCCLzLCe+ko3fIN2Zcnf5GUmOx02FE8d7ke/28wRXCmesMZawB6JYe
 FyvtRgJiV97T8yFxSl5Ezu0mPn6ecXLAoBWa0/i2k60XRik8bOWJgHFSomokUqBBT2UV
 EbKXp9Ten+yQSTF6YaDk/vpy8G7sso/Hs1fIv5kJllzQYlMnc5uFpmGF1Zd3ww/6+Ba3
 8FeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmKieFtJOYoNnd0jbLwm9xw8LuzPjqGzvnqDKNl//uuSu+irKuWLd6JmXwnVBwtoqKeiJvKl+DanVix7pkLU/w9TlYQ==
X-Gm-Message-State: AOJu0Yy7X57Dkg6Id/pBJKb+fkLdb3xPxjwWONnMapVeqpJmfXUae+oG
 l54yg6ShNZGwM1/Fi5PsuBfoYvR0LReXr0TmPcLHWrBKqGBYKBSd4TWjWjnonx0=
X-Google-Smtp-Source: AGHT+IFS9w3MgWJt7fibviumD/ZY06ULpslB/jR/AqyiEtdDAjJoy/ZkZOSRMf8fsz24GwCj0dRxKQ==
X-Received: by 2002:a05:6870:ac23:b0:25e:1976:37c0 with SMTP id
 586e51a60fabf-260ba4cfb64mr2999702fac.6.1721156835413; 
 Tue, 16 Jul 2024 12:07:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260751354fcsm1442550fac.13.2024.07.16.12.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 12:07:14 -0700 (PDT)
Date: Tue, 16 Jul 2024 13:07:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: enable ReadTheDocs addon management
Message-ID: <20240716190712.GJ561963@bill-the-cat>
References: <20240716190423.12063-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IjMKLVy6k9ozZ2Os"
Content-Disposition: inline
In-Reply-To: <20240716190423.12063-1-heinrich.schuchardt@canonical.com>
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


--IjMKLVy6k9ozZ2Os
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 09:04:23PM +0200, Heinrich Schuchardt wrote:

> Up to now ReadTheDocs has been injecting code when building on their
> platform. This includes for instance improvements for the search function.
>=20
> To maintain the current output ReadTheDocs requires setting html_baseurl
> and html_context in conf.py.
>=20
> See: https://about.readthedocs.com/blog/2024/07/addons-by-default/
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/conf.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/doc/conf.py b/doc/conf.py
> index c9138a5a5d4..e79134cc3d7 100644
> --- a/doc/conf.py
> +++ b/doc/conf.py
> @@ -21,6 +21,12 @@ from subprocess import check_output
>  # Get Sphinx version
>  major, minor, patch =3D sphinx.version_info[:3]
> =20
> +# Set canonical URL from the Read the Docs Domain
> +html_baseurl =3D os.environ.get("READTHEDOCS_CANONICAL_URL", "")
> +
> +# Tell Jinja2 templates the build is running on Read the Docs
> +if os.environ.get("READTHEDOCS", "") =3D=3D "True":
> +    html_context["READTHEDOCS"] =3D True
> =20
>  # If extensions (or modules to document with autodoc) are in another dir=
ectory,
>  # add these directories to sys.path here. If the directory is relative t=
o the

Thanks for taking care of this!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--IjMKLVy6k9ozZ2Os
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWxN0ACgkQFHw5/5Y0
tyyTvgwAkypSKpJx9aW0/AfRtz5ESynqwfK762rZ5RYlM9wG95TLEz5S/YZ0M0Tz
Fz2VejvqM7F512OiwIZUC3AaxSEGg4oGosXV1RvhEe8MxenyfSbfW0IyGGhwmduF
i3t5GsiA07+Aw7N8RSwj25KR75GwxXbvaXLhrO2cne7HicLYm+HK4qFSLBJjWihn
fIY5w2l+T++Jn/1z8R7DGPPQD0jGc4zDOYHKgvyjKHxX++nQMjb+7C8sGpZvL6Mn
jVbbipGa070bCIfsuZ/uR8TMZdvyvfFSUbVne/t1J2VsBn8fqSbvqVHFjUPBhT9E
k9thkf38G8g97Al9ZoIEwHoVcwLKR5STTeUbVD6iguNMlxZuyJkZyvhixhBWyMyW
iFfJHF/sPBVLyGOOfHP+9Wlz44Q9ErK1XMJgneZOoZq6VPX7QIzhYf7a3JmGyjeI
vHrBsynRkPJIFABa2qcrFJi5Gwslb+yMEibj1xC/g9+kfEfihPNhGU7h4ajzrArU
/Uk5qnW0
=BC8l
-----END PGP SIGNATURE-----

--IjMKLVy6k9ozZ2Os--
