Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92E3CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 23:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD44183942;
	Sat,  6 Sep 2025 01:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="smCWjyzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38E483956; Sat,  6 Sep 2025 01:09:35 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557D8391E
 for <u-boot@lists.denx.de>; Sat,  6 Sep 2025 01:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-30cceb749d7so1277959fac.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757113772; x=1757718572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SzTB43iOrrPmB7sbuRfCDLsTJpfvQ/SRFesPXXv4ud0=;
 b=smCWjyzoevoU5mObXO/v2rQHt3MxfSGMLdg0VMQKCD3mX5H+WHPXkr5Dsp99SMPdcs
 m/gCRfDbqGAIXe55cDDHsg8Rc+sp3Iq7uwP1Pt+ijrI/bTw2g2Pt3DaHT7pjAhYQQvZM
 iyQ4nT6Wy5K7L/9MlIVKSAVMqS69spViOYmBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757113772; x=1757718572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzTB43iOrrPmB7sbuRfCDLsTJpfvQ/SRFesPXXv4ud0=;
 b=ME7yDHAdxPhvoq5e0Z18O3wRHbvnLGLlaXFM7N+Ns9Zoc8F+tiWR2inb5hrmnc6PUU
 Fm1n7hfwN67vBdgdIktcU/kLzW4f/EgFFbCF1VHT1tN1/GRm5AQ+moofC6mxBoVee+cQ
 wmBuTurQw6Gh93EvAdc4176w0nYAaj1VHIGwz5UWSwtLHNGV2nN+9Dc1BMbatXPdqv2y
 gwd7sIT7ddzTeFV2EE5407yW6XtixFA7VWsBMuuW7VwXXMkHnzhKR16zXbXO9FRCblk6
 BCcPEp6y4Z7tr0uU/ucN3pSnOMLtQI1g2fC8lPY4zQ/cUsL1RG11kUv9+U7klW+KFhLk
 G7QA==
X-Gm-Message-State: AOJu0YzGh1QO0XhYILdbh1EuxUwZenE4G1mWyJ1vya05Z9t7O+R4oGps
 4kj8vABXLpjmJFlsp9hiZNHV3pL8vico2Vw0HRdXo4SQl7kb+WgLzJJ9kdLgTkvzPvg=
X-Gm-Gg: ASbGnctau/tpvoOzmgF2FpD57zRD2h4alxleaQQLqH1H/Jj/wK7l3IiBvWhJt6sJW/J
 ibVjnGBIHn0jcX7NNavnN7gAAS1yIiSNuX8xFxghzH5jQxDprK7PnV20lTPUlsLAe2eypzfik5p
 CZKDgp6Nhco+QsQnSSaWE/VrUog4wOQbKSu/b+q8OgF2GNs60RrjrMbboWHn6E1D2IS9lHeOHCq
 jPsG8im9jy4OGxGd8wuI74gvbzjR/R+ZKAevpP60uC6C9LdRo73dkmDyTv9F0P0X0Z1pY9UmzQR
 EKI2e2T/yfACbjrYuGKwfINv5gfE4i7RetukNw9iPvysjssoWcGpRvg9H/EPyo6nWEHutCRwkuq
 DQcjNsKK30bZE1yQ2bjPLocyCWWjvu0cENJfEdHPh9A/R4HK6V3+xsmr3
X-Google-Smtp-Source: AGHT+IEJpOK0jwlIKBL7OhwqXYG7Iyu9dNLvB9AL4NFVsgS0j+NuSPOQFe3IrcL1PtQSfhI9i5R+pQ==
X-Received: by 2002:a05:6871:341f:b0:315:a12c:f0cf with SMTP id
 586e51a60fabf-3226553626fmr152715fac.50.1757113772390; 
 Fri, 05 Sep 2025 16:09:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-31d69e6e9c8sm3203964fac.1.2025.09.05.16.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 16:09:31 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:09:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
Message-ID: <20250905230929.GN124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
 <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dPFRaoSnEzaiOPyg"
Content-Disposition: inline
In-Reply-To: <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
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


--dPFRaoSnEzaiOPyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 02:24:57AM +0100, Adriano Carvalho wrote:
> On Wed, 3 Sept 2025 at 02:14, Adriano Carvalho
> <adrianocarvalho.pt@gmail.com> wrote:
> > [...]
> > So, in principle, we "only" need to replace all ".. image" with "..
> > kernel-image" (65 occurrences / 17 files). However, I did that, and
> > got:
> >
> > sphinx.errors.ExtensionError: Handler <bound method
> > ImageCollector.process_doc of
> > <sphinx.environment.collectors.asset.ImageCollector object at
> > 0x79380051bbe0>> for event 'doctree-read' threw an exception
> > (exception: 'uri')
> > [...]
>=20
> Actually, the right approach is to use ".. kernel-figure" not "..
> kernel-image". The latter is never used in the kernel.
>=20
> Using ".. kernel-figure" it works fine. The remaining patches are
> still required though.
>=20
> So, if you intend to remain aligned with Linux in the way the
> Documentation is built, instead of this patch a new one is required
> that replaces all instances of ".. image" with ".. kernel-image" (65
> ccurrences / 17 files).
>=20
> Please let me know how you'd like me to proceed.

We should switch to "kernel-image" and update our checkpatch.pl to
complain (and this might be acceptable to the linux kernel too, are
there instances of ".. image" ? I assume they too should be
kernel-image) so that we don't regress in easy to catch ways.

And then yes, getting the correct non-zero SVG for the TI example needs
to be done.

> Moreover, the infrastructure to build the Documentation is a bit
> behind that of Linux. Not a lot but quite a few changes. Should I try
> to issue a patch series to place U-Boot as in sync as possible with
> Linux?

This is a question for Heinrich. Thanks again for digging here!

--=20
Tom

--dPFRaoSnEzaiOPyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLttpgAKCRAr4qD1Cr/k
ChjnAQCFyKuDHb+Sf5wMcinLuYAC4383Se0ac1JKaOFG2Hjz9QD/c28rfr1KYr0Z
BAdIYTcA3Gsu6d9TLaCqD2YqBXcF3Ak=
=E0EJ
-----END PGP SIGNATURE-----

--dPFRaoSnEzaiOPyg--
