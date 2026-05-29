Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5EBCD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF3A805D7;
	Sat, 30 May 2026 00:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mAh+iLMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC87846B4; Sat, 30 May 2026 00:53:35 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5243080087
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-694891f8f62so7629045eaf.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780095212; x=1780700012; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5fWd531HDgG09Z3RSUOSsMrVPQZdgAkyutGRD/ktCMM=;
 b=mAh+iLMp+F9f3APRt3dbditJpN/uLEgNkWklm2j9P01LNur7fiuCsawaqmuXGxUSUd
 J6I/OK+vmgcPN2H9GnrdTh7ZyQP8dSMbMDGezyal2rMH2wjNWbo9lJQQkyaKNHU83pOK
 0qO1wno0NNk9/sAsG2j6HXuS7NShIXVm/60YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780095212; x=1780700012;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fWd531HDgG09Z3RSUOSsMrVPQZdgAkyutGRD/ktCMM=;
 b=oCKQy5V4D/Dsf5K9wffNTMHkSjz+msvS9iBFbc83/K6JYAU5Ne0g8whcvbUmIZP1ze
 zfzhJ8dS5Jic9cBbu2QIdHxC43uqOPMWhhuyIm2ubEAp9+pamDq6mfmD+OOfcRUabCf2
 c39lKCDiMmngbPya2pIMHy5yeW8UIkIJ5RN5zaopXjeyXa/hSYrNnA5WGK0fATHlsjfE
 D/65nxOPuj8U37CULk1cPxO4rAPL+7WA13ZJeZUMbhCTC9RP6yBXKd8QwEC40qT0i1Eh
 EypeEFfHjWsWr9cuJor/44ocddPLBAq8jbD9v5UWroXCzSPy7DkxPk36QjrEAK+8Gc9K
 M65A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Tj/gW5mZoChBPYumZwYqVhUg5CXnLTMw7BUyzBYVJELnfWYFlROXsR7ofgN0/HkrS6/zvhJY=@lists.denx.de
X-Gm-Message-State: AOJu0YzFGVHdoF8XtIn0JX/Qr4Rm9U4lbbF5wTLL/cRQEXYNI4InDZwM
 AiQNmcDHcyD7WqaHJZYgtNt99a8j8D3owwLKc01DU3JoRqFtVXIyKpCoWXBs18nN3Uc=
X-Gm-Gg: Acq92OEVrPxk+i5r1c7FUZGgsZK4+Mj/HSMDOsFn/Ltvh/bFA/wdFeMdzm4TIvC5xm3
 tbKeTiHHsSpQ+eP9p+ivbWk00wd6BdVUX/2xmDWIWE6+73j5Vqx8wTaAY0dQ+AoQAfZy6K8CQxv
 ilnqnw0fH1qFWGQpr/Q9bf9ZT7QCUdwHHtrhMi+eWzFwqTFTgHQPcmCgeA8OJkfOcOulFzVPLHq
 EY/W+ADNEdmdmP354iF34Q/vL4YshRqfyRUA6cw0hgfKBhteOwbb20RpGxCDG0vGOpwYqB+S66D
 uDEQhggun0mT3G0XcajAW6VN32/cigFU5KAQ8nAKraCGldMHm4pxJq2uK1h0aaf/GPTTMZQtG6k
 saWQn3wBwQZbTrRB+EerCMdA9FwB5L9blIU1tlZ/+PAxpU0UlbPrn/spIPwrEHs1oA8+CGbmkf9
 OVzrrzN9JbRWn7jmwTiPEp4+ntJ+FeshudHrJEa4ZhCnF7SS4lGWAGeAR9bqXVDrh9WQPeHNViD
 8mEI2qfXIM3/rgJU22D0wdx8nhWiGm6mjpvsL0lM2TEInuhkpImAqjz
X-Received: by 2002:a05:6820:60b:b0:69d:e0e6:9f10 with SMTP id
 006d021491bc7-69e104153c7mr753950eaf.53.1780095212035; 
 Fri, 29 May 2026 15:53:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e069b55ddsm1957879eaf.13.2026.05.29.15.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:53:31 -0700 (PDT)
Date: Fri, 29 May 2026 16:53:29 -0600
From: Tom Rini <trini@konsulko.com>
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>,
 "NG, BOON KHAI" <boon.khai.ng@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
Message-ID: <20260529225329.GF627328@bill-the-cat>
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
 <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
 <d66ac683-af83-473f-9e75-f6f3a317280b@altera.com>
 <PH7PR03MB69420121B7C50CBB0F30A4CFF7062@PH7PR03MB6942.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J88AS6gdhka+YXHb"
Content-Disposition: inline
In-Reply-To: <PH7PR03MB69420121B7C50CBB0F30A4CFF7062@PH7PR03MB6942.namprd03.prod.outlook.com>
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


--J88AS6gdhka+YXHb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 02:13:34AM +0000, MANIYAM, DINESH wrote:
> Hi Tom Rini, Michael,
>=20
> Any update? Can we merge this custodian branch to the master?
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand=
-07042026?ref_type=3Dheads


Michael, Dario, do you have time to pick this and other patches up for
at least the next branch soon? Thanks!

>=20
> Regards
> Dinesh
>=20
>=20
> ________________________________
> From: MANIYAM, DINESH
> Sent: Tuesday, 28 April 2026 11:44 am
> To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Ma=
rek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.c=
om>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <=
richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Mi=
quel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@al=
tera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.k=
hai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NA=
ND dependencies
>=20
> Hi Michael,
>=20
> On 7/4/2026 3:15 pm, Michael Nazzareno Trimarchi wrote:
> > [CAUTION: This email is from outside your organization. Unless you trus=
t the sender, do not click on links or open attachments as it may be a frau=
dulent email attempting to steal your information and/or compromise your co=
mputer.]
> >
> > Hi DINESH
> >
> > Your series is here, I will have time this week.
> >
> > https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/na=
nd-07042026
> >
> > I need to take care of other patches too. I have some Easter stops to
> > address, and I also have other patches from Bootlin to finish
> > reviewing and others to queue this week
> >
> > Michael
> >
> > On Tue, Apr 7, 2026 at 8:41=E2=80=AFAM MANIYAM, DINESH
> > <dinesh.maniyam@altera.com> wrote:
> >> Hi Michael,
> >>
> >>> Hi
> >>>
> >>> Yes I have two series on my queue, I I will work on them this week.
> >>>
> >>> Michael
> >>>
> >>> Michael Nazzareno Trimarchi
> >>> Co-Founder & Chief Executive Officer
> >>> M. +39 347 913 2170
> >>> michael@amarulasolutions.com
> >>> __________________________________
> >>>
> >>> Amarula Solutions BV
> >>> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> >>> T. +31 (0)85 111 9172
> >>> info@amarulasolutions.com
> >>> www.amarulasolutions.com<http://www.amarulasolutions.com>
> >> Any update on these 2 series?
> >>
> >> Regards,
> >> Dinesh
> >> ________________________________
> >> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> >> Sent: Thursday, 26 March 2026 1:57 pm
> >> To: MANIYAM, DINESH <dinesh.maniyam@altera.com>
> >> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>;=
 Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmai=
l.com>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genou=
d <richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>;=
 Miquel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee=
@altera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boo=
n.khai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.c=
om>
> >> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence=
 NAND dependencies
> >>
> >>
> >> [CAUTION: This email is from outside your organization. Unless you tru=
st the sender, do not click on links or open attachments as it may be a fra=
udulent email attempting to steal your information and/or compromise your c=
omputer.]
> >>
> >> Hi
> >>
> >> Yes I have two series on my queue, I I will work on them this week.
> >>
> >> Michael
> >>
> >> Michael Nazzareno Trimarchi
> >> Co-Founder & Chief Executive Officer
> >> M. +39 347 913 2170
> >> michael@amarulasolutions.com
> >> __________________________________
> >>
> >> Amarula Solutions BV
> >> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> >> T. +31 (0)85 111 9172
> >> info@amarulasolutions.com
> >> www.amarulasolutions.com<http://www.amarulasolutions.com>
> >>
> >> Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com> =
ha scritto:
> >>
> >> Hi Michael,
> >>
> >>
> >> ________________________________
> >> From: Tom Rini
> >> Sent: Wednesday, March 4, 2026 10:39 PM
> >> To: MANIYAM, DINESH
> >> Cc: u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario Binacc=
hi; Michael Trimarchi; Richard Genoud; James Hilliard; Miquel Raynal; Chee,=
 Tien Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
> >> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence=
 NAND dependencies
> >>
> >> On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wr=
ote:
> >>
> >>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >>>
> >>> Fix and align Kconfig dependencies for Cadence NAND in SPL.
> >>> Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> >>> non-SPL NAND_CADENCE option. This avoids incorrect symbol selection a=
nd
> >>> keeps SPL Cadence NAND support self-contained.
> >>>
> >>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >> Reviewed-by: Tom Rini <trini@konsulko.com>
> >>
> >> --
> >> Tom
> >>
> >> This patch has been reviewed by Tom Rini.
> >> When you have a chance, could you please take a look?
> >> If there are no further concerns, I=E2=80=99d appreciate your consider=
ation for merging.
> >> Thanks for your time.
> >>
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com<http://www.amarulasolutions.com>
> >
> > Any update on these patches, do you able to merge it?
> >
> > Regards
> > Dinesh

--=20
Tom

--J88AS6gdhka+YXHb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahoY6AAKCRAr4qD1Cr/k
CvKKAQCH9wOauMRyeUyOF3LWlVpUi92AwJrF/G/dZSYiHVsW7QEAuCD4rxLxSBcF
kQdFZGFWIMUt/KByVf8egCQSdkWk9AI=
=jyqx
-----END PGP SIGNATURE-----

--J88AS6gdhka+YXHb--
