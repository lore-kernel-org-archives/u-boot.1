Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D9CCA553C
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 13:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4760C86A09;
	Thu, 14 Sep 2023 15:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UbJy+E4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB29E86A09; Thu, 14 Sep 2023 15:24:21 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65158869BC
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 15:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d7b79a4899bso992107276.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694697858; x=1695302658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gTQo48BoQPOqLsVZr4fGchAKwv4B3ktxYj8WEDS1nUw=;
 b=UbJy+E4FtVEDu7n9xzPKawHHlnG/1XibBO+SDZLvK/FlyxqzmezbggmVCRoOVYMqU/
 oEzxjiaiB4sSRW2AMrOzUdKH7hxgpDBpFqMxd05qayTzsabbSpIi9Ju6+P0sOxztBAWX
 Vsv+htt4h8ziWfUyoWO0p6dnGqQR3q359GHFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697858; x=1695302658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTQo48BoQPOqLsVZr4fGchAKwv4B3ktxYj8WEDS1nUw=;
 b=EYRESvxnTC1o98r5tzs4qd5QZ37l4lStc2k5GN2hYBMNtKZmym4JOfNxCJUJXsBdVL
 huNaVIanFeDV4Zn9p/dj3Sd1EcNOzt3pw0Jly9IaGJ3kW6dkF9JTzEoMm5iXuHoZcsjq
 kWtD/R/dc1ehnYaavI31aDL+VH54S/oTSbaPnF/PHaKeyWI5JTv1h1Pdj83RTaB+7M1C
 YExi0qBM/USqvQgIpiH2FCLwM38I+aSWuXq1yEKwpIHmdNLNChYPiZ9XYlT8V8WagQHG
 qVlT9EsaW5zDwzMUy8cVZ0I2x7rduFNDNGagL7LsrtCmGY5OPnvFU3Zj3otAr0pjp+2P
 6A3Q==
X-Gm-Message-State: AOJu0Yx6WhEXKlab22EJfRwYssEjh05sE3DhgUqHNIPKs1Kw43qMuwf3
 DxvqHOq8ZDahOA/lh9jBYB1VIg==
X-Google-Smtp-Source: AGHT+IHgcFRFYF0R4mlyMs0l1QdKjOllStkgpdvMZT+LYa0KLLN66y5PI5pLY4PXtLp7jME96nTsEw==
X-Received: by 2002:a5b:481:0:b0:d80:23d5:8989 with SMTP id
 n1-20020a5b0481000000b00d8023d58989mr4526018ybp.29.1694697857994; 
 Thu, 14 Sep 2023 06:24:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d1a3-6cda-a8be-914f.res6.spectrum.com.
 [2603:6081:7b00:6400:d1a3:6cda:a8be:914f])
 by smtp.gmail.com with ESMTPSA id
 i186-20020a25d1c3000000b00d818ced8939sm331158ybg.1.2023.09.14.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 06:24:17 -0700 (PDT)
Date: Thu, 14 Sep 2023 09:24:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
Subject: Re: [PATCH 0/8] Add some more EFI capsule tooling support
Message-ID: <20230914132415.GY305624@bill-the-cat>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230913192422.GP305624@bill-the-cat>
 <CADg8p974hyYwip59pTAE8grqOpftx+CzLQU8XefsJpzukW-saA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0Pc4b4lji9KpPpEM"
Content-Disposition: inline
In-Reply-To: <CADg8p974hyYwip59pTAE8grqOpftx+CzLQU8XefsJpzukW-saA@mail.gmail.com>
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


--0Pc4b4lji9KpPpEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 05:42:49PM +0530, Sughosh Ganu wrote:
> hi Tom,
>=20
> On Thu, 14 Sept 2023 at 00:54, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 08, 2023 at 05:29:54PM +0530, Sughosh Ganu wrote:
> >
> > > Recently, a set of patches were merged in next, which were adding
> > > support for generating capsules as part of the U-Boot build. Mid way
> > > through the review of those patches, it was decided to drop the
> > > patches for generating capsules through a config file. That was
> > > primarily due to the use of absolute paths in binman for testing the
> > > capsule genertion through config file. Now that the base set of
> > > patches have been merged, this series is picking up the remaining
> > > patches for review. This series addresses the concern that Simon Glass
> > > had with the use of absolute paths.
> > >
> > > The first set of patches are adding support for generating capsules by
> > > parsing the capsule parameters through a config file, and adding a
> > > binman entry type for this. These are patches 1-5.
> > >
> > > The other set of patches is for generating empty accept and revert
> > > capsules through binman. These capsules are needed for the FWU A/B
> > > update functionality.
> >
> > I think what we really need next is to be able to implement and document
> > how to use the capsule (and FWU!) spec / mechanisms on another platform
> > and I think the Synquacer DeveloperBox would be a good target here as I
> > believe you have access to one and so does Simon to we can deal with
> > feedback on a real platform that both of you have access to.
>=20
> That should be possible. And although I personally don't have access
> to the board, folks in the team do(including Ilias). I will work on
> this once the patches for supporting empty capsules in binman get
> merged.

We need to make this the next task as not being able to put this to use
on a real platform today is blocking understanding of what abstractions
do and don't make real sense.  To tie this to another thread, since it's
not really clear how a real platform would make use of capsules it's not
really clear what sandbox should make every time.

--=20
Tom

--0Pc4b4lji9KpPpEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUDCXgACgkQFHw5/5Y0
tyx8QAv/dIV4xtqcbzph9BisJZvt3Iz6LKBQzHARD+bmhfuiLfjpj/G6WCq58ngo
m8QksJMiSU4ueTDt/VbeqA9CKIzGQX7aTUBhXl/4zPAoZmz2qkQhVEqwxeC0/7iG
MBcGMBoyXkxfSSFmhMWnPvis/BqryboESrI6l/uv9H3xV0A0cJOoPJuqTNQrAxYs
yI3Pn5GvHGZsiYwHerJN2itex8wAdjx+adje8+0TkjE+vVa5b6q/d+8ar73fVqZr
7bZmVQRigXk2JuRoN3/nZzSfnfKAed63yLxmAiAlkxMk5NXjgvwwi6lkJiQDm5Lt
9TjJErbWz16s+vodM1I2b1R/LAb2mQHLLelWrIVSuonDg4qxocfRJ+eeCebz+jRm
U2Y1tehMVBMtdWLGQe0NJ2M8BZTkfhdoxaFa9zyi5kE+oJwVd6VXDFPNrr6kbERj
7iGC60iwoBFn8iR2czNcKT2FH2+prQ2ke4d1zapnOEZt6FcH7fKjpXGz4/CmtKC8
JUf/whui
=KxET
-----END PGP SIGNATURE-----

--0Pc4b4lji9KpPpEM--
