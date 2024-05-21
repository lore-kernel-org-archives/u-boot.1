Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EB3C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F5788348;
	Tue, 21 May 2024 18:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ljNUarGA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E48488339; Tue, 21 May 2024 18:07:16 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B40888348
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43e1593d633so2089061cf.3
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716307633; x=1716912433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N28+tZ0WL8/KjJBGGA+Gp4mJkxRbj0Dyaip/adkqJ2k=;
 b=ljNUarGAFv1YRniK/pGF7j8ymjyTIzjfPrJ7rfOdvuWekjOqhHla+aAKWnniYKxweM
 dbgBWlhLiXyOg1iR3vuwsgBHrFMpg30Ncv54LGSYdLVFpFfxHRiD+Ma8XbCdw/m+ANaq
 vYOT73ljV+Xk85UjuswXUKNF86CIaCPfNuwGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716307633; x=1716912433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N28+tZ0WL8/KjJBGGA+Gp4mJkxRbj0Dyaip/adkqJ2k=;
 b=MThmmGSn3ubUr9ilC+y/oSLIxwdk9CEP+btJj4QSDSBc7ZFQILARuXcePGiwBOZmub
 R+6Ulw5klNIIK0Iq5pvURs54hFcjUuuF8re6QocVO3iXeNKpvUxbL3T0O5artvnpVcP/
 XXKBeubWZX/1XNNIbqO8QoxDWzytANiy3gVOxKuSMIoaKcX1LC7Z+ID3uJxm5NHZJMnr
 9hPt4p2B1XGJ39jYoVbZpA3dMCs24ZWhw607BQfb701ep0XcRGxWnpNG/vg+lLXpVD+o
 us28ieJR6xtdswDKiO4SfR5Xu/Nd9MIFNyBNV5bCtiir47c9wTVOEaYLlcUxbinv4ZUF
 ZdMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpjag5BJ2OwmAo9dZnb8RAgQ6/TcLB6URpOAJT/Ntw5Sz/b1nWuh2aH7gbK/aVJpts8JY9EqIHq0EpvuWnwWKuWiijgw==
X-Gm-Message-State: AOJu0YzkF0Os3bgVUeOer4CQdr9MUXjNg1ZbyVaChglToQEAY8J9xMYS
 6lyPSThKKHCraE8+nZdTu0qHwigUZAe9mGaDHpDcn2/6EX4E+PbBuWn0FURCC2hhpZKe+cI6gst
 FqjQ=
X-Google-Smtp-Source: AGHT+IGfUunebUQ5kPcqMM74IrIezvuA/Sr4Yh1gumf5QSCYBDzMlMn/P/SG2YUCaBRtf5fRtiuHXg==
X-Received: by 2002:a05:622a:110f:b0:43b:7ac:ac79 with SMTP id
 d75a77b69052e-43dfdb4a264mr354054691cf.21.1716307632476; 
 Tue, 21 May 2024 09:07:12 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2789fdsm1294571185a.20.2024.05.21.09.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:07:11 -0700 (PDT)
Date: Tue, 21 May 2024 10:07:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v4 0/3] cyclic/watchdog patches
Message-ID: <20240521160709.GS2568172@bill-the-cat>
References: <20240521084652.1726460-1-rasmus.villemoes@prevas.dk>
 <ce12ad50-bd54-499e-965c-5693355a4e84@prevas.dk>
 <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6gUJ1HESkYXk/hWh"
Content-Disposition: inline
In-Reply-To: <97ec64c3-7323-4886-9623-77b4bc28dfff@denx.de>
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


--6gUJ1HESkYXk/hWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 01:54:58PM +0200, Stefan Roese wrote:
> On 5/21/24 11:47, Rasmus Villemoes wrote:
> > On 21/05/2024 10.46, Rasmus Villemoes wrote:
> > > A bit of a mixed bag. I've been wanting to submit something like 3/3
> > > for a while. So when I stumbled on Marek's patch
> > > https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+re=
nesas@mailbox.org/
> > > , I got reminded of that plan, and I think that patch could be more
> > > readable if we adopt this model.
> > >=20
> > > While actually doing those mostly mechanical changes, I stumbled on
> > > two separate issues that probably want fixing regardless of the fate
> > > of 3/3.
> > >=20
> > > Mostly just compile-tested, and now also checked that at least the
> > > sandbox test runs succesfully, and that it builds both with and
> > > without CONFIG_CYCLIC.
> >=20
> > So I managed to trigger an azure test by pushing to github and creating
> > a dummy PR: https://github.com/u-boot/u-boot/pull/542
> >=20
> > That fails, and while it involves the cyclic framework, I'm pretty sure
> > these patches are not to blame, since the same error also exists in
> > other pipelines. It's an "expect" failure, because some watchdog
> > callback apparently sometimes takes more than 1ms, so the default 1000us
> > threshold is exceeded, and that prints a warning which breaks the "expe=
ct".
> >=20
> > An example is
> >=20
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8459&view=
=3Dlogs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807=
d-f28f62a1426f&l=3D1055
> > .
> >=20
> > I don't know why it only/mostly seems to happen in clang builds, but I
> > think the fact that these happen quite frequently warrants either
> > bumping the threshold used in the CI builds quite a lot, or adding a
> > config option to suppress that warning/limit altogether for CI builds.
>=20
> I've also seen CI build issues from time to time and restarting the
> build magically solved these issues. I'm all for making this CI
> build more stable, perhaps Tom has some ideas?

In Azure (and not GitLab) we seem to have some tests that fail when (I
speculate..) we get put on busy or slow resources for the job. When I
last looked, retryCountOnTaskFailure was limited to 2 at most. I would
be open to other suggestions / patches (such as yes, increasing the
threshold in a test) to make the pipeline more reliable.

--=20
Tom

--6gUJ1HESkYXk/hWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZMxq0ACgkQFHw5/5Y0
tyyy5Av/bqiQGkYl6muynUzc7+ordSAVi/uOjQVfDGMtuCivlT0rB50hdksqdh1q
3wR1iIXQNAcMoMqoPAHq1hNpMZj+9HTZPQuMxrfECSuIcbl4uvKsBgFtbMvRBWz2
+mvJxO9vHuUabyh8p9v7LFvWrEIKXJ4yj49yX3SC2jg8fMlWvLfMobISGXET5RNQ
FCwO7BJz0UUIaWYxcq8GRLfNcssPX2uS6todTla2F9zTiR8aO3eKKOky9dIRVqPm
wioVTVrO1UGTC+z6LyRRIXVFdbVeSmO8OvK+8cv6PJSZpzlCAD5vlkBSGXWnshWB
2kPOwZbLI9xKdx6q+BgagJqmmU3SkjzzNu+eW3hQz5w+yeVf4AwfuZSXbcbpxncY
kN7DKlGr/kR3n5s0sx2yigYoStOxU0Re6EqSAtQw+g1MEtIUCZkia1UjQh5ECSDI
cXw1gwMP3zGA90bh6bphNxULQXbcOxgYqddtTm7uMWbeDWu52XDZ9yD5XM4vxwiR
/3tAWNzq
=XpMU
-----END PGP SIGNATURE-----

--6gUJ1HESkYXk/hWh--
