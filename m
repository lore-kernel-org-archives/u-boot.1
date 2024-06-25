Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA10C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 15:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158B28848D;
	Tue, 25 Jun 2024 17:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fm7sDYLV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CAD88356; Tue, 25 Jun 2024 17:19:36 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1A288496
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 17:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d55cfebcc5so248633b6e.2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719328772; x=1719933572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mzIrPkMVkZXxLDK7sWwf2qUKQfkZWKwCbULIXQmD7VM=;
 b=fm7sDYLV5E8xI7/FH5wWFjKJIM2E/T05n68pD+QbjUKw2QllHJZMQFvkU1Hm7/558i
 1WKc1LdEwaSIMxtQv/oVzc7hWkIBMqUbZijrGItaFPJtRIboZgbuLbKfhQHZpkghrUTq
 3TiTIiQdHMd8IEWtMPaZ+oxFusyJ1zeqOgwC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719328772; x=1719933572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzIrPkMVkZXxLDK7sWwf2qUKQfkZWKwCbULIXQmD7VM=;
 b=MLf08plBlhy/BKGPL/+0ctlbI7hBbRtEcQHEa5BUf283Hr1gd2MtFx3Bu2GnSfHyqB
 MhB0grwXHQhiDhs5YOed4QJrMEz/PkvQWT/tVJEbgQR+WxzyoN8yKdCq41nDdOip42IQ
 SUPObzfGlDADQ1b/GDYK9dwqhnrMX9qcAz/c1c1gmgv+1/T5GEFFzZYHx/FpT88JJXX7
 ChjUNjT6qen2HS+jZw+iDqreW/atDamJgKpEFHTdG8s4cM7KKIq0aJEU40EKpGblKShK
 P8ryROVgiZvR/fxpOktUDFnY4nv2HDLn9hsw+O7I729+90Dgxv44wWtk8v9/0gA8uFG7
 GHVA==
X-Gm-Message-State: AOJu0Yy0r8kM547X6V6/6gy/6wsXb/Nog7Igc2gTP5iyLwFTcS3C4HKz
 yKTMvTuZ7/YExrU4i3mE/W/7ssxVYcSh/rajwQlWp7jmIrj1tIjkmqdi5aPY37c=
X-Google-Smtp-Source: AGHT+IGTw/Il4vsWFgK9YJjcKWxvD4Q9zZMziVr68IxiW+ee61xvYPWdSyXW8zOR6DbUOs+LjUWXDQ==
X-Received: by 2002:a05:6808:1b0d:b0:3d2:1da4:af63 with SMTP id
 5614622812f47-3d545a5449dmr8831451b6e.45.1719328772322; 
 Tue, 25 Jun 2024 08:19:32 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d5344fa546sm1936874b6e.16.2024.06.25.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 08:19:31 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:19:29 -0600
From: Tom Rini <trini@konsulko.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 "u-boot-board-maintainers@lists.denx.de"
 <u-boot-board-maintainers@lists.denx.de>
Subject: Re: [ANN] U-Boot v2024.07-rc5 released
Message-ID: <20240625151929.GS38804@bill-the-cat>
References: <20240624193035.GK38804@bill-the-cat>
 <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SYbx/QuEhDBIdZQm"
Content-Disposition: inline
In-Reply-To: <e396268c-e106-4bb8-a40d-e0582e556c6b@cs-soprasteria.com>
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


--SYbx/QuEhDBIdZQm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 03:12:38PM +0000, LEROY Christophe wrote:
> Hi All,
>=20
> Le 24/06/2024 =E0 21:30, Tom Rini a =E9crit=A0:
> > Hey all,
> >=20
> > Well, once again I need to check my calender reminders since, whoops,
> > I'm a week late. That said, looking at the list of changes in this
> > slightly elongated period, I think it's OK. At this point we're a week
> > out from the release, so it's time for clear and obvious regression
> > fixes. Ideally ones introduced this release cycle so there's less
> > chances of unintended side-effects.
> >=20
> > In terms of a changelog,
> > git log --merges v2024.07-rc4..v2024.07-rc5
> > contains what I've pulled but as always, better PR messages and tags
> > will provide better results here.
> >=20
> > With that, the final release is planned for Monday, July 1st, 2024.
> > Thanks all!
> >=20
>=20
> For your information, I have started testing v2024.07 on my powerpc=20
> boards in operational condition and I have a major problem : U-boot=20
> doesn't get the Linux kernel started before the watchdog fires. I have=20
> to disable watchdog to get it running.
>=20
> This problem doesn't occur with v2024.04.
>=20
> I bisected it to commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841=
=20
> to U-Boot") and I also confirm that v2024.07-rc5 works well with that=20
> commit reverted on top of it.
>=20
> Any idea of what is going wrong with that commit ?

Are you able to check the zlib performance before/after that commit?

--=20
Tom

--SYbx/QuEhDBIdZQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ63/0ACgkQFHw5/5Y0
tyxcjAv/WmP7s2IPwpqc1NC2OOKKL6lzISYFCeU2PKYQSvaySym8c9PtpZEg4c8/
mXK5BWvhXMxddZCTxv3AbNuaW8daKPsYj0xygBr3DXXJIbZrMbaPAuGPB0R6JXBg
6NFFOYXkKsV6mpur5eNG5jTxm0Wo3hUkScSMkCQpst66joPVe3XMUhAKlvKWkbJX
5kz57ibtE4HwOlS+vHxRW2MHq09KyhUIvVsb4C5G9RTphHDiG3Qq1ZwsWzcchQnM
u9wQcTCrtItShmVymZcdsZoA32xN3X9UkK88xDeJ3H+y4uAlP1+FxNcsEQvkww+X
yMReigm0PdBWUpiaS7/ltXYorjB7W6IxB2BSvJgiaUxfL+V0/fl1RBG2nXsN0Wu5
lp/k+XLmu2B3pbhyi99ZhnMKisKk3M0jjz7Hsnaz7Lto3Cis7Q3/6MFwMUvfVdBj
GHScvq4nbojvZCI4lRjGWBDJx+Yq3hYiEuVzMvV+0GTAhv+ZBDAPbyxj4VvNc+lT
XhUyqeYu
=zIEJ
-----END PGP SIGNATURE-----

--SYbx/QuEhDBIdZQm--
