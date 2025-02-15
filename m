Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7465C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 18:12:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7225980756;
	Sat, 15 Feb 2025 19:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BmAibfs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BBB80EEB; Sat, 15 Feb 2025 19:12:34 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9560180077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 19:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-220d39a5627so45791435ad.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739643151; x=1740247951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L5CmEZIMJLJLAuJ+s+yBgzYCyLerFPISqeVgCKV8ceI=;
 b=BmAibfs1FCWMHRiMg+SJCQ/2Vq0I4Ka4K/Y4aFSWuKQNia+/iPik+8P+/DmckJt6ZC
 QiDdKTuUHYkpDNmo8EfvmnlSTMZs7xJlNMHDqihFVA6SPOvrzNa5s+aC3Ty8r2lqSxrO
 FQK7dogXS92MLeqM1/UWNV+fiE4BF5pbw+RXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739643151; x=1740247951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5CmEZIMJLJLAuJ+s+yBgzYCyLerFPISqeVgCKV8ceI=;
 b=Ecbj9wtoluNh7r0EQpzZLyz7Bun9HMOcd9y11hSuzkGdXEP4KvjxuSR9eX0wXRvPxb
 SAvzYO3V58yIeRtFUU1ZtcqRzbbS60/HM7HUhJoNCoTiOyv8FIb365SplZbE2lj6p7mf
 xVHkTkXu/98MAyvUW+hHzC+uIdADzyIfcg01DOgIgAO4vNheGbCqsJCqJXUynQtq56uq
 rXVtPK4hyhQ30S2Wgc5tZQbCqdPXlJyO1yOBl89YX6bIhhIhAHgjbBJm0QqqKumOoayf
 W49A46eAXFy3Q7hix0JINnEO7zJgeTelvI8wh5fNE00Kugu7SIL0UsofrSwglU1S04gx
 tb1A==
X-Gm-Message-State: AOJu0Yw0XGAPr+uQIIfPMygVA4DFH8wAWr54q7cjlS/LvL+bGnG+j9So
 DcqyEhL4oZMtV0tTEFx3WknNZT/4cpjCeB/MhVwOU4jmoxtS7bou9pOs1OSTyP92R4dq3x1zVq6
 F
X-Gm-Gg: ASbGncvlI31HwqC4gbPKcQYomozTO7q3FqwARB2yZpEjP58aBq5icdhkl27FXcrzhIt
 b4c5o7waYqbE/DKZmby/1j8fFmrb5HGX33LMEIiwbmW0crZRZzs0STL022Hz4tdJTDtUOTkRqxf
 Kg/YUwT4cCKA2SoV3FMZ5Y29oBmouAq2eXW1j9mwy7+rx3n37sERAmKMIW6gMqa1+PO7mK0lE5i
 EPyN8KEONEbK9bR0eac/3yk5KIDltRdmqs2fNZbS3WLXB2as58WOT6gNpetfob4X6cQ1LRnmiOS
 Ieo0cAkVWz6N8g==
X-Google-Smtp-Source: AGHT+IGBJucwS06yGFNY6FjQjyIi2Teb2pi1U6hQizmeDwEEAux0VYQn6FkXTbd6EfNjcPIePZuiTw==
X-Received: by 2002:a17:903:2c6:b0:220:e63c:5b10 with SMTP id
 d9443c01a7336-221040a8faamr57940555ad.34.1739643151070; 
 Sat, 15 Feb 2025 10:12:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536b052sm47062665ad.100.2025.02.15.10.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 10:12:30 -0800 (PST)
Date: Sat, 15 Feb 2025 12:12:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
Message-ID: <20250215181227.GT1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BsLAIaXXS8Q28eyO"
Content-Disposition: inline
In-Reply-To: <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
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


--BsLAIaXXS8Q28eyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > >
> > > > > This is a global default, so put it under 'default' like the tags.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >
> > > > Please make v4 include the way you redid the second patch and be on=
 top
> > > > of mainline, thanks.
> > >
> > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > It probably doesn't affect your tree as not as much is done in
> > > parallel.
> >
> > I am disappointed.
>=20
> I'm sorry to disappoint you.
>=20
> The background is that I looked at the difference between our trees
> and the gitlab files are quite different. My CI runs take about 35
> mins and it seems that yours is around 90 mins. I would like to reduce
> / remove the delta (for time and patch diff), but I'm not sure how.
>=20
> My goal is to get CI runs to below 20 minutes, best case.

I'm sure CI could be quicker still with a number of faster runners. But
if you can't be bothered to make changes against mainline, what is the
point?

--=20
Tom

--BsLAIaXXS8Q28eyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmew2QgACgkQFHw5/5Y0
tywsVQv6A5pf7ceTdeVqqmPdAYnhhn2gVeRNwldQe/lhehq/D74wmDPM3IV/wnU9
aE5ZjFHNjGfNdZ4KmcHGkdcbs+cGOsIkbHoc9VQLsUCa5//txpPfeylhoiSabRrE
2LERqpbXfg+agCRO0rsZ56L+IJIBgff+jiW82k6ykLeMa+6U38WKZDjSDLF+RB7j
yw2VSdbNoT26cgFL2KhCKqervovz/HiSZVzgv+GivIV4x0ux7ic22FE+l6KY8MHH
pfdR68rkxXECStR39I5cDer0OSdA605jZeQAg8Q/SSruRyr5viNaDgaUPqaZxbVl
nPDmgesPbmpK6HXGIu4YZU9M0bhtjUnoAOwUSUFUGFC7tKo6SdFqyGLsI4ZeT+6U
HSk9J8zzU4FgrEOswwxJi5dod2fMAb9YrwXIvsYbAF1M2YhJannlhOg14rBz7L07
QAem4LcQAcQigEsh2gUbwNRUF0qUy1GIU3pyHk+rQW3btMiaZkc9b8zB2DaC1uBV
iM9xyYnQ
=gT22
-----END PGP SIGNATURE-----

--BsLAIaXXS8Q28eyO--
