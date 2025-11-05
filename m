Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC1BCCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 19:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F2C83AEC;
	Wed,  5 Nov 2025 20:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="igbY8oBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2304A83AEF; Wed,  5 Nov 2025 20:33:13 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDCE983A1B
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 20:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6d2ec149eso146460a34.1
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 11:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762371189; x=1762975989; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LZGoHBW6IFo+crsNQNshOEDuKbx+aOplNT/GpD1NJiY=;
 b=igbY8oBkK0aPh8Q4eMconsNe+FDHgqXOqHM0QIiOS3FvHi+BJDYub0VLHBvgsYjKHA
 QygNwlJAjKcA6hAtIuUtMlxtVobWnGshs2PX4TS5ixhCuMohK/wTESLF4loQR7qrpRr7
 2anUzjQs9AjJ7dlAj59fcNljZ+sD+MQbBZMPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762371189; x=1762975989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZGoHBW6IFo+crsNQNshOEDuKbx+aOplNT/GpD1NJiY=;
 b=IlpQ2ziVvoW5qIMGtbTmZ8XE+/0cgT/Pat/Rq5b3wSyAASAS7Q/UU2BQDUH2Vfo/Pg
 1JaDnGSC1dkh99XRN4uLdjkHbBiPvjsOBC4LrZfRp0trCn4yxNuP7DKLdGNKuUxJPXhI
 LD5/8aRaJqU98RtNzo/9Lo0XITEWSrbhBf0m5P0IWv+YkcmtN7Oipf+AGObOuQy2fz5m
 QE06+ROwagGHB40CJWTksR4/HxAP37MeHaLnjG8V3nI0tF5ietF9Dvfc92peneiZnsc1
 FieMqNzXKOC+Y7Lj7D/wRCPcgoFfqGjgGOXWio29Ih1lfblWpRSC73OLnJeYsyILXhrI
 n9Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQfjViNwI7BqKdXB9zH7Bf686T9Vd07WesZc9fLlMN/O4w95cJVyGWN5zdoXjp7Q4c5okYhq4=@lists.denx.de
X-Gm-Message-State: AOJu0YyyKjvTgRO48Hi/Ni8WdoMH8amF1bCQfotqlz/8pYUPfiytJP2A
 eN2xOjPtNMaQqDetYWPBZ+WbhiBz0nl6cHSbgmhg+owiDF1Jc4PzmWDCPKipxvs/SLI=
X-Gm-Gg: ASbGncterm5cyG31p+53C6O06vKFc19Qj9fs33csMW7WI7GxIzWGESJSl1Bsz6YarwS
 cjivDApfh+wSw+tSCM+ndJe2tPk2ACQHScp5pdxgO6Dui3kiSHN/J0HvNuqq1lSx228H+PsEOgz
 x3um503RT5yqVJHzyBbGR5NFfWTzYZcns6fLfoLq2QO7QPOZ6nI9gSBwn6whH7FcTNJISTgEauz
 zg2DUreQvf/7BAiuDORyGjr50nX4aBUijS5GRrYCv/i5W7Z73AgpjSA6Ho4xg3qHneXUZtPDqzw
 m0RQ2u7UhBiN8rtMIkA/M40N6Q5pvU5oNayKttXsLxfqVROX89V3nOyS+ewVqJlK0cTv4NKsPpr
 GZ4FeT2iqB+oY6unDUcPWwhqNs5Hf60Z2X3n1JuG7G2ma7O+lhIqXx24IB9H9SRZV0c7f/ZBZV8
 QKjfq4jY12MCccbWjGsIlG3AVLr1nP1vEEoAroue0=
X-Google-Smtp-Source: AGHT+IFtgScnbKJ+j4/+/q2Hm6nuX9Tj/2dJxbf088VJ3nLG46OiF2QYCUHR8sqMDA7c4m4Rh6VGpw==
X-Received: by 2002:a05:6830:3109:b0:746:d8cc:4ba with SMTP id
 46e09a7af769-7c6e1393255mr474508a34.11.1762371189625; 
 Wed, 05 Nov 2025 11:33:09 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6e31f9002sm8591a34.14.2025.11.05.11.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 11:33:09 -0800 (PST)
Date: Wed, 5 Nov 2025 13:33:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
Message-ID: <20251105193307.GU6688@bill-the-cat>
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Eld5PMmGyeQljcsg"
Content-Disposition: inline
In-Reply-To: <20251105192601.GT6688@bill-the-cat>
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


--Eld5PMmGyeQljcsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
> On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt wrote:
> > ARM and RISC-V do not have memory at 0x0.
> > On X86 interrupt vectors are stored at 0x0.
> >=20
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  test/cmd/fdt.c      | 4 ++++
> >  test/common/print.c | 8 ++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > index 96a8488e172..6b07999c88f 100644
> > --- a/test/cmd/fdt.c
> > +++ b/test/cmd/fdt.c
> > @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_test_state *u=
ts)
> >  	uint32_t ts;
> >  	void *buf;
> > =20
> > +	/* This test requires low writable memory */
> > +	if (!IS_ENABLED(CONFIG_SANDBOX))
> > +		return -EAGAIN;
> > +
> >  	/* Original source DT */
> >  	ut_assertok(make_test_fdt(uts, fdt, size, &addr));
> >  	ts =3D fdt_totalsize(fdt);
>=20
> In one of those "what is even going on?" moments, just out of context we
> set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loooking at
> my logs for am62x_beagleplay_a53 where memory is not at 0x0, this test
> is currently running and passing. I'm going to fire the platform up and
> poke now.
>=20
> > diff --git a/test/common/print.c b/test/common/print.c
> > index 76ee851fe6a..389d6bf4069 100644
> > --- a/test/common/print.c
> > +++ b/test/common/print.c
>=20
> These tests are also running and passing on am62x_beagleplay_a53 I see
> in that same log.

I'm poking TI folks about this in that it seems like memory is really at
0x0 here.

But with respect to this patch, NAK, we need to figure out how to change
these tests to run elsewhere rather than disable them on all of the
platforms they currently run on.

--=20
Tom

--Eld5PMmGyeQljcsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQumcgAKCRAr4qD1Cr/k
Ctx+AQDGSbIs/QJ9qh4MHLYmja7VpftuZB33Nd7bCNyI5JHFUQEAgpIhlEtJICOB
6VDxdjpO0JHloKS86GnfsTwoanA0ag4=
=bX+x
-----END PGP SIGNATURE-----

--Eld5PMmGyeQljcsg--
