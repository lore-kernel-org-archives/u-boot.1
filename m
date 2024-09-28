Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5243DCF6491
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 16:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E5E588A1E;
	Sat, 28 Sep 2024 18:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iRjzB9X4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C99188A9D; Sat, 28 Sep 2024 18:03:22 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252DF889C5
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 18:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7acdd65fbceso253384085a.3
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727539399; x=1728144199; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a01vi7Ie+VauFbA5UAOnoxTvp0W8lVY9ExUGZyqUJ7Y=;
 b=iRjzB9X4R4Zca4QbbHb/FxfIGg8+AC6LUTS1g6wZ+j/Wr1YEowGXZh7m+TWR+oss9S
 AllYsQnkSgjwtOih/dSyWJDCHcL0VAaxH7GhwnKcJ9lzzHPVj7N5t2XIFX7SB5xIIM3G
 SNJZRPOwyVm1H1HS2FHYM4ocpvQfJDcE8WYmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727539399; x=1728144199;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a01vi7Ie+VauFbA5UAOnoxTvp0W8lVY9ExUGZyqUJ7Y=;
 b=pq08vmdSrBvLtRhdA5IvS/mQXV7QJZzhIPM7rnr3Pk+ENRbwSakHu33fTAOb4VtSIF
 INVcVBefDKlqtU9vJE7HqIG4SIqafKGbz9DlgemL3POr3esRFPQyGBTgZrmE0m1VIp+K
 4ObM7vQF2yLQJPYWB+gAdUyH3d8pM+k5Bf4PLecP+gw+yxtMrj1d119bxXYt21mBPwWF
 sy0Riy1sgx8psxz2rXUXyoTBd7rz+pQ9TtwBQENO1LFEKI1l3c8qglMlkp0OFGJUYBQR
 LEnvnZqHe6GLRIrls/ytwOJmBAuvWX9b3Nez0XldN2rX8y+sGx8dvQk9x0O/YqUslY/6
 ZtqQ==
X-Gm-Message-State: AOJu0Yxc0cHlAp1L6TgsmOnV+F+SZKt9ufTzaB5qF+ieBG1T657ig0IF
 dI277dnhSnYe9FMG5VUjyHmg7RUXer7Kkdq7pRiuC17SLSQMcXvqSMHlh6ANGGw=
X-Google-Smtp-Source: AGHT+IHSDHxRIrlkX0XyR1Z3JKTRcfk5sSsMLuPzrT59I3XEcdJyFPUh3KukhtqYyBrJQpMBhkOTZQ==
X-Received: by 2002:a05:620a:2496:b0:79d:6276:927a with SMTP id
 af79cd13be357-7ae378384ccmr1064420785a.22.1727539398908; 
 Sat, 28 Sep 2024 09:03:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377ed56esm211473985a.59.2024.09.28.09.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2024 09:03:17 -0700 (PDT)
Date: Sat, 28 Sep 2024 10:03:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>,
 Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: Re: [PATCH 00/27] led: Remove old status-LED code
Message-ID: <20240928160311.GX4252@bill-the-cat>
References: <20240926223009.1270197-1-sjg@chromium.org>
 <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
 <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
 <CALeDE9M=AY=oeLywm46Eym91NwFjrJgysiuucd1EMejCnCNC3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D/FWOMu7mTp2OsEM"
Content-Disposition: inline
In-Reply-To: <CALeDE9M=AY=oeLywm46Eym91NwFjrJgysiuucd1EMejCnCNC3Q@mail.gmail.com>
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


--D/FWOMu7mTp2OsEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 04:14:00PM +0100, Peter Robinson wrote:
> Hi Simon,
>=20
> > > > There has been an LED framework in U-Boot which uses driver model f=
or
> > > > about 9 years now. Recent work is underway to improve it and provide
> > > > more features. It is probably a good time to drop the old code, whi=
ch
> > > > is only used by 5 boards:
> > > >
> > > >    ./tools/qconfig.py -f LED_STATUS
> > > >    5 matches
> > > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > > >    socfpga_vining_fpga
> > >
> > > Why aren't these boards being migrated to what ever the new frame work
> > > is rather than dropping quite useful functionality on these devices?
> >
> > I don't have any of those boards, but perhaps their maintainers might
> > like to weigh in?
>=20
> So? I mean I can test the pinephone at least if you convert it, but I
> don't think the functionality should be just dropped.

As Marek noted on the mx23_olinuxino one, the conversion is to turn on
the new options. This will either (a) work or (b) gracefully fail as the
DT is missing information but an update by the maintainer to OF_UPSTREAM
will fix that. So yes, this is just like other blind conversions we've
done in the past, please do and we'll see if anyone else can test on the
relevant platforms.

--=20
Tom

--D/FWOMu7mTp2OsEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb4KLwACgkQFHw5/5Y0
tywShgwApvlYVXN1s7KaOmuJ++P27OWAs9UD3xZuWCxOMXRhdV/xlvDHZQOsSpkH
Aekv6Eul0VIYdbPg7or8OzkzbQSgZNQOfhIpg68elLdoFCmLKXSEqkMrFTgIlNaP
A1m++35zIcrVgJnm5cbkKIVlyTPv/ulwE5ivgRbHGd+OadliSX/Lx/FTk4iPf+6e
/2ED8wK8LPAuyheGmiHmmjgcbB85McYXInnjLiEFY4Mo5OzKUtaS2Bqo1PSE0eI+
GAOAa78trQIeMAkMTfLiNY99amwgP9D3BF7KGn1UY1TSyAWCt9qDMRqwuKP3gqYP
eVsvhH3symS3wqvZSpXpIzyN9Hxh5Tt82AluaBfNKxIO5N5Q4q+CkzfU4fLjFd0p
Mo2Mx+4j3CpHHyLz1rn/Pe3F8yAJ2+eZ0MqzJCcBz4yWD7z2BKqbqoAtpv+hPaoe
VZPaz9OIIditiOJ4KxXZlOo/H+gW9YtiGln24dIQFcBk68oDTjpijlHq5bICPb62
fcc/90+U
=6b0k
-----END PGP SIGNATURE-----

--D/FWOMu7mTp2OsEM--
