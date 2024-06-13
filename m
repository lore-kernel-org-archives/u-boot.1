Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03AFC27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065DD88887;
	Thu, 13 Jun 2024 17:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RmL38vsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C055987F51; Thu, 13 Jun 2024 17:32:59 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8B088887
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5b52b0d0dfeso631250eaf.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292776; x=1718897576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XnAWIVX+um9WPMTJaiosnT7T94wsOXebO7QPqsg+NjY=;
 b=RmL38vsyPMI59OmvybPQZ6rJ9gesq001j37K5S3jcuiWPt2kDZNBtArdQVsqz3lyHC
 amh/drWEAaBzwa0KGYx9hf53ToHn7R/xGJELZtnJKOsyGWmlX9beCq6Ib2LcXJ3H7Bdx
 p/twL6vG91Tr0gFOdJZDqnOabr4j5TooH39qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292776; x=1718897576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnAWIVX+um9WPMTJaiosnT7T94wsOXebO7QPqsg+NjY=;
 b=iecEsKn+DhBLlcr3U65BhnVm159hoJ54hwoeNf70V/nW/TySTqwIlqNQugIyPyIAYF
 Pjf/Zpk1R+tIanVEcPp7+Gg/ftjWviiv/BMaFuaxubDArz1rJiKg/agYolldcMTAMtuC
 q5sPiu9YKQIs9m6Qc8nowT1+ZIWCsV0O8kUCOD9MMeuFl3CN+8JBqBEoYHFGsd3JHArL
 6JyGu66BxG6SnjOlyYbkZOjTyKb3k7hHslCODKgNgQ3ToFMY4CiLDnxbLIMH/gOGGslr
 Ppuh/1r/8yBG17ex4WYiqMBcdMl+SxnMoTfRC4zOgzhiFpwFwvwPBKySLcAR4NNxeyvb
 Uq1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDHJGDMBGuvvLl8nN7S21vJ9ZzQLOS2xnd+He4u0JgO+s1JW5KmY1UqTrvWEYTRUI0SaEDmpwbB925LMViObao5nBOiA==
X-Gm-Message-State: AOJu0Yz4XosaNpGu8X3R0V9Hn34jzr0ovB9nx1oGgWwKnwCnEedWAFT2
 AOjrB1evWkWSXwaVKOfJRze2Wdv841iZ6+ikgI95Sbhl4U1Jq8plAjdxV34MlCE=
X-Google-Smtp-Source: AGHT+IGRVIT4QPQhlhBynFwBn0sgsWVKqsu0FICNtJgwDBx6QUY0s+X3UVFFd/ESTWh9Rd1sSMcXFA==
X-Received: by 2002:a05:6820:2295:b0:5bb:1310:5f37 with SMTP id
 006d021491bc7-5bdadbae588mr18085eaf.3.1718292776067; 
 Thu, 13 Jun 2024 08:32:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5f2a183csm200671eaf.36.2024.06.13.08.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:32:55 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:32:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 14/20] CI: GitLab: Split build_world tasks
Message-ID: <20240613153253.GJ68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-14-51472eb70357@flygoat.com>
 <20240612160104.GU68077@bill-the-cat>
 <894fd87b-ece7-48b6-bf20-2c6621e7224e@app.fastmail.com>
 <20240612170742.GE68077@bill-the-cat>
 <CAFLszTjLL6Tc2o8sY9Ki-ZthHcxc2SyNe8fNN+mnU86b_n7=Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A6WKAcDwUR3IBb43"
Content-Disposition: inline
In-Reply-To: <CAFLszTjLL6Tc2o8sY9Ki-ZthHcxc2SyNe8fNN+mnU86b_n7=Kg@mail.gmail.com>
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


--A6WKAcDwUR3IBb43
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 02:24:24PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 12 Jun 2024 at 11:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 05:14:46PM +0100, Jiaxun Yang wrote:
> > >
> > >
> > > =E5=9C=A82024=E5=B9=B46=E6=9C=8812=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=
=8B=E5=8D=885:01=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> > > > On Tue, Jun 11, 2024 at 10:04:13PM +0100, Jiaxun Yang wrote:
> > > >
> > > >> Current build_world task runs for too long on public gitlab
> > > >> runner.
> > > >>
> > > >> Split the job as what we've done to azure pipeline.
> > > >>
> > > >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > >> ---
> > > >>  .gitlab-ci.yml | 103 +++++++++++++++++++++++++++++++++-----------=
-------------
> > > >>  1 file changed, 59 insertions(+), 44 deletions(-)
> > > >
> > > > I don't like this. The list in Azure is because of the time limits =
there
> > > > and in turn we:
> > > > a) Have to tweak it periodically to keep things from running too lo=
ng
> > > > b) Have to tweak it to ensure that we don't miss some new SoC/etc
> > >
> > > Then it will render running CI test on gitlab.com impossible again :-(
> >
> > Yeah, it's not something I'm the happiest with. Looking around a bit, I
> > see a blog post that talks about dealing with dynamic variables, in
> > Azure. So we could, I think, figure out some logic to have each build
> > stage say what platforms it covers. And then have a final step that
> > compares all of the platforms built vs the global list (just
> > tools/buildman/buildman --dry-run -v) to make sure nothing was missed.
> > With something like that, and assuming GitLab can do it too (it probably
> > can), I'm OK with having the world build be broken down to 10 groups
> > (maximum number of parallel jobs in Azure CI for free) since we'll know
> > if we miss something too.
> >
> > So lets set this patch (and the doc update) aside for now, unless you
> > want to look at the above. I'll look at the above soon.
>=20
> Could we hook up one of our machines as a public runner somehow?

It's a pool of free runners, ala Azure. I don't think we can, no, and I
don't want to make all of our runners available on public CI either,
they're a bit over-whelmed as it is I think once custodians start
working.

--=20
Tom

--A6WKAcDwUR3IBb43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrESIACgkQFHw5/5Y0
tyzCWwwAjn/EI/caf7DNQCpslGnbYGWbn52dBd/Pv0PAhnNa4Dkd6g6KkpQEM28K
6fpcVFWU/fW6qOqVT8D3JapqQCMFCheRdXYUhAdQUwjonwzuGbEuYU3/krBUhD2y
KdKK8nE1LN8uHENWYuz2NZttj522viLAl5FP0ZO7BRdf7U0BMiGzSHq8V53sbDwW
ITb2nKeLlXCVhGKjlVC2pOEdOLCcyJvry6IpthYRZuMMD0bJnOdlyjgZ3i1YOFOZ
PrwxMyU7PX90yrsX0lO0dYrjsXSGsankgecdWDBT4/pgHhIDxiW5xUmgnZAxV7MB
QRHahw2lTYVBgcsGyBXL71544z9xU4agmXUHsijXK4ndC74Y8MNI8WU4v63Um+TA
C2HuAtmk7Kel4sHJveeDAYcuOrMRIQwzmatWEPYaWcF3mHvnH6V9Irg815u1s0AT
9gRkKKSk+hUAM1aFK4/4e/raVH+OAm1od7ZpmXkUzbqA95ekQ/vHm+7+8y655AmJ
1Up//MFO
=73EJ
-----END PGP SIGNATURE-----

--A6WKAcDwUR3IBb43--
