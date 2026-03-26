Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A0C10A88DF
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 15:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1DC81E18;
	Thu, 26 Mar 2026 16:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NZzWHy06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A38383CF5; Thu, 26 Mar 2026 16:47:23 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A823280517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 16:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1872504cbso973060a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774540039; x=1775144839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FHsIdh6YOKGz7c4BCc9dgq3+rOKQ6PbcVbZBcrIivok=;
 b=NZzWHy06x4N4axFfIhxC5sLERR4LfQYLnaGX96cQiy+09912Og2uHwTehsrhPG7Id5
 DDjrKrJibF3fi3bpILGQcQoxn76H4YtGxZ98uA1K7qVY7GJkbQ3B7SdzbSGz5fWCu3rG
 +k7+OYTVViEupNKj7DMw9j6FGc0BauRpG9JqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540039; x=1775144839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHsIdh6YOKGz7c4BCc9dgq3+rOKQ6PbcVbZBcrIivok=;
 b=UYYJvsUMKEfISDxCyBXcOA/70ksHGWO0e9VjwzAbgKoMYHBfqeVp3hkpyvtNuWEu6t
 TgAwInNc2CY/gV3vMWtSrh88mNPTsY8aCyH9Pzfavbim/ZV2zrNTaqQtrOMIWCN79IKl
 IhDcat5s0R5PhDiPs+qg8ZJ4MasfBwKFCkXb4e7zF9NdQ+ZXMsGK5oNVgI7XKcmFZPyy
 u+1sM0U5Ff8gIyPtaFPGTWVGootTgae0qDn9irBdSvK8GuI3sVbzGFhocBve62ZgMngM
 gJjv/9B/FeOdsWGYS03qtLyLORJNvKLIEki5qU3A0VOnM8arD5B0IBFXOYGgEycLleYI
 g1Ng==
X-Gm-Message-State: AOJu0YylTYxlBVaO1ZITae4jueGLECgbG1bDyahWluUr3W/b49UtOtE3
 XL1wtHNkp/uIn7W21D+e1dYk5aKQGYeG+7e3NGofyx5tmD0QHiXqOu/2brx8fXj70fE=
X-Gm-Gg: ATEYQzzG/sEL3OKm9g9ulmofgnBQlRsAd5tpjZn1Jg9xx0iRwodFD7CXEdP6piGVa5m
 6Dc1UGWTB1dRzDMdaDQG8eUYWmnndb2KNWOvUdUbIouD+F4fGvOJ4pmBSQPfwrRMtzMrE5TnbTb
 hyZzXpJuY+PXD7Q8ivBM17/m5XeYwXoWNOpoU/YFwwOuiaRQ/xd9/yc0BzMeKHK9/25pkMlecq2
 8w0S4Yu77nZWImOoFGRn4i19nPrh5vzH2GieUMamJ9ir2nCDBQD/zQ7CjE0kre19xlJSqQYSuji
 v67SRd2qhii4MmoobAOjSVVQhovYQI20S+gRHEQ1Zd3qAgVsCkLMHOAFTJwwBuRXtTzqnMshwzn
 2Xgzl43Jr2fi/NSxf1JmRGRhVxVebQBKEnyr9mQXnrDhe12UCyZfFypuvYVJ+C1uB3y5IM8sD+d
 tZ8nDJNTEbYPkBTDe87razhdogHEr+IJzzyNpZLs79DkJdanH3bjw9b42ROn1OIM3z5lpChK6vV
 Vluk/d3/EvuUXo9YmHDcEFp3Caegrt2YMw3WVAjJ4n87+Bw
X-Received: by 2002:a05:6830:368a:b0:7d7:fd71:f2d4 with SMTP id
 46e09a7af769-7d9ee150982mr914674a34.3.1774540039276; 
 Thu, 26 Mar 2026 08:47:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e7276daasm2436964a34.25.2026.03.26.08.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 08:47:18 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:47:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
Message-ID: <20260326154716.GA502704@bill-the-cat>
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U4eKs/GO0hf1Objk"
Content-Disposition: inline
In-Reply-To: <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
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


--U4eKs/GO0hf1Objk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> >
> > > Various updates:
> > > - c4 lack signing so does not currently build
> > > - samus hardware is non-functional
> > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > ---
> > > A sample run is here:
> > >
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> > >
> > > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > > broken on -next
> > >
> > > The ff3399 board needs some investigation.
> > >
> > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 36 insertions(+), 10 deletions(-)
> >
> > I have two sets of problems with this patch.
> >
> > One, it doesn't do, but perhaps I wasn't clear enough when bringing it
> > up, change it so that failure to pass is a job failure (it's currently a
> > warning). This in turn means people can't tell expected failure from new
> > failure.
>=20
> It looks the same as sage...can you post a snippet of what the rules shou=
ld
> be? It shows failure for me, when the lab fails.

https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunch of
warning for failed boards.

> > Two, when you had previously gone about adding at least colibrimx8 I
> > noted that this extended how you were having labgrid build U-Boot in an
> > even further non-upstreamable manner. As the sage lab yaml shows, we can
> > bring in external binaries for buildman (and binman) to find and use.
> > We'll need to extend that logic a bit, to be sure, but it's a solvable
> > problem with the baseline already there.
>=20
> Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (via a
> U-Boot 'provider' class), with some pre-built Intel binaries for x86, plus
> BL31, etc. put in as environment variables. My design approach is differe=
nt
> from Sage, in that I often connect to boards interactively, send U-Boot
> over USB in some cases (so different files are needed depending on the
> board) and at the moment I have all boards connected to a single server.
>=20
> Labgrid has 90 open PRs, including my terminal one
> <https://github.com/labgrid-project/labgrid/pull/1571> from over a year
> ago. There definitely are PRs getting in though (20 so far this year). In
> terms of upstreaming, my approach has been to break things down into
> smaller PRs, but four of them are still outstanding after 18 months. I did
> ask on irc a few times but didn't get a response.

Yes, your approach requires changes to upstream labgrid, while the
approach I suggested before, and was able to finally get done a while
ago, does not, and still allows for using boards interactively. labgrid
even supports python well so whatever tooling you wanted around labgrid
and building u-boot and anything else could be written in that, instead
of shell, for example.

--=20
Tom

--U4eKs/GO0hf1Objk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacVVAAAKCRAr4qD1Cr/k
CghNAQCbe21Pqzf42wVbuX135+T9v5LmhR8SLfea9ihCoXSltwD/dWnT0jGFU8FN
g/mt04jErV46RXdUmpfAyokmc42SMAU=
=Xsqr
-----END PGP SIGNATURE-----

--U4eKs/GO0hf1Objk--
