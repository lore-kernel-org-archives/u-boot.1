Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9FCC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15053876AB;
	Sat,  9 Dec 2023 16:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ph9DFmZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527A6876AC; Sat,  9 Dec 2023 16:56:38 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C034876A6
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso28977917b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 07:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137395; x=1702742195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iZEiyQl4wAbjOPiG2iMAaEJlq29n8ZQsmiRDeQcDy6M=;
 b=Ph9DFmZv8VS9FgA+4DyEwmOO7TYGMY9lN2Rj6RBoPi5vj1GaVnvOndubUuj4tsqgIL
 upp2nRyOKBMjxEMaheetPQFQDhNjfshynS8FWaTsYRdThRq6pTDWdbgnvs4eOBAHWDYq
 XJ4X6YOaJuZJOfCnw7ByO+HuWyP6rbV79ZRtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137395; x=1702742195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZEiyQl4wAbjOPiG2iMAaEJlq29n8ZQsmiRDeQcDy6M=;
 b=gq6wMp2tCleMZFZUxsVQCHH+UTpYkscHvWk4So9MKQwfQRdhDD4A4gswqkJLjrGEvS
 7CaxoFsnRXPK/saJOIdzx1VVbZLAVduZLtEtnirAHVGB53+1lZFA1f3Wj3sVb0a8en/C
 CGZZF08u5/mI/zDMm4JNV2YXTk5icoNZHMoF1nb7EGNMedej6BPbGGLGUjVJ8wMYdHOU
 pOVpmwFkkPfLYWJJfQYNifyFRHfs7fH1A60botGKUmz47dqSit51W4qobZTyqAQVyYgA
 1ZNIEcnn9YfyuetLCcFlpRvHexPQ/CqyYMfj4B3tCbSqPJ3Cu7LgW5qRJqZQ87vl9bX+
 JPaQ==
X-Gm-Message-State: AOJu0YzpOsd3gqNMmJ89OSzG7hfZfggrJBtQrFkw/ig/6XpdtT7wikMS
 R2o3oTt4NQ7wpflp3EuciJig66HBLuEij1rZpo/2bQ==
X-Google-Smtp-Source: AGHT+IE4C3ifWsyoOtktfRb8QNOdBC/JxKChRfuEVrbv1xIc4ysPoLijpTkoEEPKpjTn7kUB0lOTgg==
X-Received: by 2002:a81:838d:0:b0:5d8:2322:a284 with SMTP id
 t135-20020a81838d000000b005d82322a284mr1315755ywf.40.1702137394787; 
 Sat, 09 Dec 2023 07:56:34 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 r190-20020a0de8c7000000b005d33b03acd1sm1554631ywe.39.2023.12.09.07.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 07:56:34 -0800 (PST)
Date: Sat, 9 Dec 2023 10:56:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 marek.vasut+renesas@mailbox.org, sean.anderson@seco.com,
 Martin Husemann <martin@netbsd.org>
Subject: Re: [PATCH 01/18] bootm: netbds: Drop passing of arguments
Message-ID: <20231209155632.GN2513409@bill-the-cat>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-2-sjg@chromium.org>
 <87edg2b5vy.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ05y__ReH0giGGsLaScfz+4=x1pZOy8LT35-X5EJUJtnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IWUR+FMz5vZ2TDvk"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ05y__ReH0giGGsLaScfz+4=x1pZOy8LT35-X5EJUJtnA@mail.gmail.com>
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


--IWUR+FMz5vZ2TDvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 08:53:58PM -0700, Simon Glass wrote:
> Hi,
>=20
> I am replying to this email since it still has the context below.
>=20
> On Mon, 4 Dec 2023 at 03:48, Mark Kettenis <mark.kettenis@xs4all.nl> wrot=
e:
> >
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Sun,  3 Dec 2023 17:26:17 -0700
> >
> > Hi Simon,
> >
> > There is a typo in first line of the commit message: s/netbds/netbsd/.
> >
> > > It isn't clear how useful it is to pass the arguments of bootm to the
> > > OS. For example, if "bootm 1000 2000 3000" is used, the three argumen=
ts
> > > at the end are passed to the OS. This seems like a strange approach,
> > > since the argument have already been parsed by U-Boot and processed.
> > >
> > > Rely instead on the "bootargs" mechanism, which is the standard
> > > approach.
> >
> > It is a very Linuxy approach though.
> >
> > I suspect this feature was added to pass kernel arguments for
> > "one-off" boots.  For example
> >
> >     bootm -s
>=20
> Martin says that this is used with NetBSD. So do we rely on U-Boot
> parsing the '-s' as 0 and then using loadaddr as the default?
>=20
> I wonder if we could come up with another mechanism? Perhaps 'bootm --
> args go here' ? Or define that if the first arg starts with '-' then
> the args are not parsed?
>=20
> Martin, would it be possible to send a patch to doc/ describing how to
> boot NetBSD?

A patch describing how booting is done today, especially including some
of the potentially less common but still valid usages would be much
appreciated. We can go from there to decide what changes if any to make
to what's exposed to the user in this case as I am loathe to change
things like this which amount of an ABI.

--=20
Tom

--IWUR+FMz5vZ2TDvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0jjAACgkQFHw5/5Y0
tyyr9wv+NWTz9Xcn1yDyzdwFwAqUUbt6zDAynV0cujNuURKlO+wrM/xN3vxf6oGu
ECkpqDFiPKcwc6c1mSow3g4QT9hsHiGHS71eFKjvntf9+6AG8i9xLwxMsYTcnKqI
N4kDqDX/lyfi5KcADBHsj6h0PWR/4UrmbEAvAd4RR8GBF2Npo2rx5ApF2Q78c3Xz
nvCRohQDze/h3UshoW9zfR+MUV2nTq+svf9SYBJHDcjSKoOIb8vSnHyoDvKlmZTu
ANzKNLJ7Fi68nWlrWc49ouLIlzRJw4po0do7PjatJMmFciUgwI4jckKPgqokk13e
0ICihZiXjgrDqKrFF2EQSZxWwtwXzVzgVzrsXCLIUqz3RcgFqDc5bdABhLH79+of
+zEBbwbhAZOPi1wxyJzAyL+4DeRDig8MW3l1KNGbttsTM7qij35LPJqCYGkXBCRl
YpyYzsTol4mDZ7F7UgrewIss4XeWofrim0K0R85RUlyH6Dy98AoKYDXuY2NgEqF3
xpF3MVRO
=Cfdk
-----END PGP SIGNATURE-----

--IWUR+FMz5vZ2TDvk--
