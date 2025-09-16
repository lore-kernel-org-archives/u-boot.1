Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E079CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8EE80325;
	Tue, 16 Sep 2025 16:30:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nIdQxiKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D279800D7; Tue, 16 Sep 2025 16:30:02 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 665FB800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-750e52fb2deso4602568a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758032999; x=1758637799; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=seIhR4kl7bs5AIXOO0T9pjc6mdWpccKg0l72iApG4dE=;
 b=nIdQxiKDN6ptamAfuKLFYit9hClkWmAUTR6fVrEtAlS29HW0FFh34nOneJFPuZRW6Y
 kTEc3sr23wns7eTAKPE4th2V/9BZIx+HKkLgfOBLlQOVN6yRFQ3XKJuKsFCSHp8iHFo/
 lC4iNbIqGafvMKz3zIv15r5v4fkgKXHlp8ovY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032999; x=1758637799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seIhR4kl7bs5AIXOO0T9pjc6mdWpccKg0l72iApG4dE=;
 b=ulKpHNQB0hbC2dDXquHOobHHznHL1HZRVAhXRREA9ooN1blRL0RE/7D8vSxaRU42vk
 kZJsl5MmP/9XxXbUUquPPOvkFkKhyVFm4P8tjpsH/feDW56pi1dtXTkHf3BDbXThKfJ5
 vIiZbOHEqh/z9Ah5EvC+RZlgjMXBxwN50e1rdkBAO0NqJTJ8B1UqUgMe1IYrzXNInetF
 h8ixy639izivEJgK6A8nYr5IyD83dT9Tb5WH32d808N+SpyeJ1TWzD4q3qYo2D8QXNcD
 ZyVcNn5ur7FwenVSRbS6N/9uXNjT+BS0+DySDZN2zBmuWrgOPw0zojX37esDseSzQX5g
 9f2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV4hMCQD2DRsY+xeczTvTc7Dpr+IYdjYcPa82L0Jq2yM0g/+AJkjXqzQZFjyhLg4oq1nrUNm0=@lists.denx.de
X-Gm-Message-State: AOJu0YxFHLojVorGecdb0VOKzWCg5vtqyB10hBU/fLpmgZSjjczRH/5i
 lVDvpAN0bZ4zlmzkGeEVyWmTYaBanhSexy8AkKSxcf7p+QrO9MtUl9+aoee1ugvGnAxYSr6dh8b
 guFMhsLk=
X-Gm-Gg: ASbGncueA64Y4nHliLgc4O6Os7IkcfU5OgSXdOSmvZglma5mRlzHagG6nKkUWG8hAT6
 Pv72A5ITI9XPcopjySO8kvtvJd4KZIbJWlloyPppiPuoWljF0UVpqJ0zvi5e/XpxW668m0cTSQy
 6Dv99EVMCKHZOYbIQYuI57tq36Q/r517167PEOTbbe8ksxiXERPX3jj5k6ZAG7TkpzFgmYxIZOK
 KUgMCiayYczbSDniv5OqdIFdz03oJh/CAnP63F3hwaYcEcfSwtnOkif7W4oq55S8z5/+emjS1gC
 f969okXx4Lr2E09IAJi1S7rCf6DMTWbzOu+6UiIz95QuWZklC7g0cvs+NA6kTwzxKP3VunPPqHz
 SGgRjelMdqLxDPktCyIjUgR/7samCY74O3DSyjWph5OYV9KhcV61f541/YtMgpiJJUV0=
X-Google-Smtp-Source: AGHT+IHtok/wcfn6VeCCquCw6mbQNOfhUIixuITFzcIn0xa2GAS2sk2IkeNHYv+G5DGT05u13WrJUQ==
X-Received: by 2002:a05:6808:f09:b0:439:b1eb:3026 with SMTP id
 5614622812f47-43b8da12099mr6636957b6e.29.1758032998960; 
 Tue, 16 Sep 2025 07:29:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-75249298352sm4023425a34.1.2025.09.16.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:29:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:29:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dave Purdy <david.c.purdy@gmail.com>, Ion Agorria <ion@agorria.com>,
 Jason Cooper <u-boot@lakedaemon.net>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>,
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Subject: Re: Continued need for ATAGS-based booting?
Message-ID: <20250916142955.GQ124814@bill-the-cat>
References: <20250915203827.GN124814@bill-the-cat>
 <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
 <DB9PR06MB85127E0FB3A0BF108EEAF0D4CB14A@DB9PR06MB8512.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eh00xjsr7VMfp9NJ"
Content-Disposition: inline
In-Reply-To: <DB9PR06MB85127E0FB3A0BF108EEAF0D4CB14A@DB9PR06MB8512.eurprd06.prod.outlook.com>
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


--eh00xjsr7VMfp9NJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:49:06AM +0000, Wolfgang Wallner wrote:
>=20
>=20
> > =D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:38 =
Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > As part of working on cleaning up documentation, I ended up seeing=20
> > > just how few boards still enable support for ATAGS-based OS booting.=
=20
> > > In fact, the list is:
> > > brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall=20
> > > dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper=20
> > > icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> > > n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya=
=20
> > > picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2=20
> > > surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
> > >
> > > And my question is, for you board maintainers, do you still need to=
=20
> > > actively support booting such old Linux kernels? Or can we disable=20
> > > this support and then possibly be able to remove the underlying code =
as well.
> > > Thanks!
> > >
> > > --
> > > Tom
> >
> > Hello Tom!
> >
> > Maintainers of some boards in interest have agreed that support for ATA=
GS-based OS booting can/should be removed from the boards in the following =
list:
> > chagall endeavoru grouper ideapad-yoga-11 mocha mot n1 ouya picasso
> > qc750 star surface-2 surface-rt tegratab tf701t transformer_t20
> > transformer_t30 x3_t30
>=20
>=20
> We can also remove it for:
> brcp150
> brcp170
> brcp1_1r
> brcp1_1r_switch
> brcp1_2r brsmarc2
>=20
> I can follow up with a patch series.

Please do, thanks!

--=20
Tom

--eh00xjsr7VMfp9NJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMl0YAAKCRAr4qD1Cr/k
Ch7uAQCUTT7fba/H06Te5H5FzDDPqhNODlcvunExyGAqLMRUjQD/fhj0B6+7e+zD
emtM5QOicKeN5KicdXRrvQpVNcp43Ac=
=l5XV
-----END PGP SIGNATURE-----

--eh00xjsr7VMfp9NJ--
