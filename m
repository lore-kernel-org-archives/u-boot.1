Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF54DC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F7483FEE;
	Sat, 27 Jun 2026 19:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EEmlcU7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8303A8460E; Sat, 27 Jun 2026 19:31:59 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBCF805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 19:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a1515a629dso569073eaf.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782581516; x=1783186316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EUaPif/6pajK5mk02C+ao4HQeC5S69rXI1a2uclx9sI=;
 b=EEmlcU7NL7KLiI9GTZCJHUveGAtMbmi7nyxDWXXryynD9GMIOeMXPqM2vz3QHVgAB9
 ctdEOi2LBvsCZU1Q56TY2BCleeYJ7mjblzj1NsFXd+XHc9bWsbLQPbop6D/v33ZCG9PT
 PP1xvu15c+pk7/ClhGjeQmITOhpXSiGzqX8ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782581516; x=1783186316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUaPif/6pajK5mk02C+ao4HQeC5S69rXI1a2uclx9sI=;
 b=XKm6Q09+U5X1IzEqGTJDWWI+CbxJ68Jdjva/xQBz4Swuyyxk5A/HdE+FTv+uN1KeNR
 /GDpYs1Cyg976vpeyS/ww9sEW48XgcsZTgp7iY3VVatXT1R9mXuvwqglh+joNBQ4/duO
 j83giYjp/JyMnyupPJB5BC5LMuC5lwvUyQTWjR1HMBjlqV1HPMiZWrwfaGnmtWEGk6Tr
 1uE36yZWCdSKkscY5IDlxol+IhAU5JbpF/w1J1p8EgmlKSLJc4LRIcFeWgmap8SzzfQn
 ExzEahQA3IqmgYVvlwudw5z79t2K3/vyaADK2Et6ycPRvykaYtqTkYrCsTPs/zGY5qDd
 DpUA==
X-Gm-Message-State: AOJu0YyJDPg/njC15z1TeZON3rFhrqd20bKfbyW1sWZ2rveoV5fzwSQX
 ysy9t/skDotI6LiI32Qd3KQbUloFnOExhdBV11NpM6SHKTz2Ocs0vYrmCi8wBZkII2w=
X-Gm-Gg: AfdE7cm46orHC19HgNzBqKmRJTxJRQvWpszqb9VAjXs331pYMwtX5cx4ZqhC+FBNvQn
 tj3NbR+RtkatAuiZbKe2f9KZxvLWl1FiAz3873DiR0M833C1NBKnzIhwNHW/WlYfBreJkOU6ZfL
 SfuFuA4eA1LBPXXEDRPK4cElJOCQP8J9JEQrUF2OKTk7GFtYJXwh7lHrH/r6oxoyO8IDryJqoWA
 uD0ibxEzsKX2g5ZBboxs9qcbATktkkBDlzNq7pp8lvyfaYXCiAxoyVtIqLBjSggpN6Rm9/XLcPh
 kqrdsfhCo5HP2P7dett5DSgb1KmWfzw5d7WUVX1MpF+M25mmV/aM2B/B2lUkIzUTPnx/nmdcrei
 chOby5M3aEBy0O8btZXINkPgEHUb857DIbusC4QcC4xXaVfUsdZ06D8ieomCiUPymd0pDLMJQES
 3fmPlbY9VcCSASUqWIirNNwueaZ3vReN50F2H01uan7nA2gHgfjbSYGc9a6XnCa4xMnUBoBNd89
 L2kdAYAa/fE9t0/vgJ0vZ5eAcw3K62MIYy+ofPq
X-Received: by 2002:a05:6820:c89:b0:69e:b8:ffe4 with SMTP id
 006d021491bc7-6a135224b69mr8128118eaf.32.1782581515970; 
 Sat, 27 Jun 2026 10:31:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a14131d327sm3977647eaf.5.2026.06.27.10.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jun 2026 10:31:54 -0700 (PDT)
Date: Sat, 27 Jun 2026 11:31:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] test: cmd: part: fix integer handling in
 setup_gpt_partitions()
Message-ID: <20260627173152.GC382693@bill-the-cat>
References: <20260626183353.1666667-1-dario.binacchi@amarulasolutions.com>
 <3dfd02eb-fcc1-49d1-aea2-6bd20f052692@cherry.de>
 <20260626215804.GB382693@bill-the-cat>
 <CABGWkvrCJn_ABadB0AmTQ6dp=ufDi1GdSYgSP1fkwCQQM=OL9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kW/tLY77LOIlyas0"
Content-Disposition: inline
In-Reply-To: <CABGWkvrCJn_ABadB0AmTQ6dp=ufDi1GdSYgSP1fkwCQQM=OL9A@mail.gmail.com>
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


--kW/tLY77LOIlyas0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 07:24:24PM +0200, Dario Binacchi wrote:
> On Fri, Jun 26, 2026 at 11:58=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Fri, Jun 26, 2026 at 08:40:36PM +0200, Quentin Schulz wrote:
> > > Hi Dario,
> > >
> > > On 6/26/26 8:33 PM, Dario Binacchi wrote:
> > > > Coverity reports an INTEGER_OVERFLOW issue because ut_asserteq() co=
mpares
> > > > an unsigned int (mmc_dev_num) with ret, which can hold a negative e=
rror
> > > > code.
> > > >
> > >
> > > The trick here is that ut_asserteq() takes two arguments and casts bo=
th as
> > > unsigned int, hence why it complains.
> > >
> > > If Coverity is happy, I'm happy :)
> > >
> > > This looks fine to me, so:
> > >
> > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > Yes, were you able to push this through coverity on your own?
>=20
> No, I haven't.
>=20
> I couldn't find any documentation on how Coverity is run for U-Boot.
> Is there a recommended way to verify Coverity fixes?

There isn't, because AFAICT there's no way to do "test" builds to see if
a change corrects the problem. And I don't have this running via CI
because due to our codebase size, I think we'd be limited to 2 runs per
day, at most.

--=20
Tom

--kW/tLY77LOIlyas0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakAJBQAKCRAr4qD1Cr/k
CpN2AQCOhHPHQ7Xg6eiNxCrL60FVauB1nRjSJkwJ8lyqogROOgD/cE/KmmE35BaK
07Z23LqL+yUTHvNIFLmNzxaYFJ0Bxgs=
=486g
-----END PGP SIGNATURE-----

--kW/tLY77LOIlyas0--
