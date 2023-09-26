Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B89E7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2955186DB3;
	Tue, 26 Sep 2023 16:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qPPSOq5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1DC86D86; Tue, 26 Sep 2023 16:19:43 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AB786EB8
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5a1ec43870cso7453307b3.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695737979; x=1696342779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pSeYxPrZxe8VZKFzRoBtxgolM24qZGBrU/9ec+xxBBg=;
 b=qPPSOq5aocEW/SixJToXtEk2fsJ4Y3ONrr+Swc51+8bLNVcmSdVDjSWq1oQkzU/rbC
 jSC7Q6jLJxML1xKfUEC9fp0lgZhhfAcSnd72xlNMqyHwikfV4cYvDONPzV29mRLsf2WW
 GjjDBFjTdoqY1FByQGBU0P7M2uK1fXnE6qzWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737979; x=1696342779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSeYxPrZxe8VZKFzRoBtxgolM24qZGBrU/9ec+xxBBg=;
 b=g5IERc/WaFtgxW+qSt8CV/Mc9vXMrbdDapLU1ovuok4amam2Ber0Di+DFvGBoWwrYd
 C5ym0iecYnY9H7wjlxLW/R1BJ/B3U/o6E3ACMWLGKjBf/V2QMNIEoWBYOnFeqEPg2n04
 IXKmNqgPchqFC+QwJqyHfQp47uIiNev8gxNpKulEALsmL4WXtSHt6B3iWTxAFXQhWtZR
 zwtAKQI4+CGXkMeGGRy+XZrVzQzksuAhAbx7pokU+rIxfUZvZ/Lg6GCNVZZVyT7oROvI
 VQ9GHd4KpVG/O0Uph5lcQFOLhkTPGXzBLqVdC2o9EwH7QhqB9UnG4eoKSTnLKNinP+1G
 6Bnw==
X-Gm-Message-State: AOJu0YzY8QcUOCj47KnjzFrBFHeH0alNgPDpi546T4BeXjXzSjCiyuaf
 TU0uLPVqTHejeKPJBJF07TUBIA==
X-Google-Smtp-Source: AGHT+IHfHakWAXeOnyt4A8tHYiI0CNcwQm7IotyP6ztjNtcjTFJT74xkpCbBdsIi7NI44DA5Rrf5hw==
X-Received: by 2002:a81:6fc2:0:b0:59b:50ed:82ec with SMTP id
 k185-20020a816fc2000000b0059b50ed82ecmr10008641ywc.17.1695737978837; 
 Tue, 26 Sep 2023 07:19:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a080-e51b-f064-cf67.res6.spectrum.com.
 [2603:6081:7b00:6400:a080:e51b:f064:cf67])
 by smtp.gmail.com with ESMTPSA id
 x124-20020a817c82000000b005773ca61111sm3035806ywc.42.2023.09.26.07.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:19:38 -0700 (PDT)
Date: Tue, 26 Sep 2023 10:19:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
Message-ID: <20230926141936.GW305624@bill-the-cat>
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
 <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ku1Fg1LL5cQ6KDDs"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
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


--Ku1Fg1LL5cQ6KDDs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 08:16:35AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
> > > Hi Maxim,
> > >
> > > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org>=
 wrote:
> > > >
> > > > add external lwIP library as a git submodule.
> > > > Use STABLE-2_2_0_RELEASE tag.
> > > >
> > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > > ---
> > > >  .gitmodules            | 3 +++
> > > >  net/lwip/lwip-external | 1 +
> > > >  2 files changed, 4 insertions(+)
> > > >  create mode 100644 .gitmodules
> > > >  create mode 160000 net/lwip/lwip-external
> >
> > Do you have comments on the rest of the series?
>=20
> Not yet, but I should be able to review the rest in a few days. My
> main comments before were minor - return codes, tests, error checking.

OK, thanks.  I don't know how exactly I want to proceed with the core of
lwip itself, but that doesn't block reviewing and testing the rest of it
as we'll move forward with it one way or another.

--=20
Tom

--Ku1Fg1LL5cQ6KDDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUS6HEACgkQFHw5/5Y0
tyx4cgv9Gbb2EWT69QHevQIBiNOPDEtdnvizf9WA04wflRtZ+Cp9PKupGuZlmwm4
5SwLCRhgNgSxMworVsu3p6ULc6L0Dz80F8bhMDSbfCv/1/kx2E3cZa2DR24SOHvp
hnIbGYdk/8aL5fRaHhgdC0StNtvDOHbypcThmevjccAbB63yU/rkXbX1tnVxYOhM
vYnTnPiTTGnv9iXITqc1I1gstavzLyl0XP5d4AykRmhq1VIn4sGeBKnCAX8QNubz
L6VIr3kj08xTqC1qOGQivEYqH80kU6zQF0oDZBlOJJ+ghy1TfZ6/ccAPhTZH1eTl
ttPAXa5ESY4ku12iprJ+4IdBBNcZyCB7vB2Maz2InwdFCcjM+DLG72YpIWncQd/z
IGRxB3oFOVs034wPsAQUh4YO4lkNRy9KE5ycfJGQVpsjKtLQXgYL9cMnhx1GPW7L
vlGZGKJZ6UTcv2IQUqsewBIw2EreVdzAoCxnEInYbORdIKlMOIMjHSabPUmw8d1k
19IgT4l8
=Xd+2
-----END PGP SIGNATURE-----

--Ku1Fg1LL5cQ6KDDs--
