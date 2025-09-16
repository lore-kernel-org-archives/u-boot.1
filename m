Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E13CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 15:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8652480325;
	Tue, 16 Sep 2025 17:08:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="An8qFxQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84B1803CC; Tue, 16 Sep 2025 17:08:46 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8710F800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 17:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-74a61973bedso5009024a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758035323; x=1758640123; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yOrMXaFeWdA+6uylhkyGN3bVkykWditd5Sk7kd10XVg=;
 b=An8qFxQeNQ4zdvLvw8bSjx3nOxINmZP8xChcWIO7uJ9wRViSWEE1sZf8CJd8FuXkD8
 tR5DbBJ9BbdWNGInXzP5vsJqtOCFpZRzcpsP7xanwuducZ74rL7YDc6yPOHgeGu6sWXQ
 PMMpBc8b8GtMHO6YE4CohquUJdQch1o7i313k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758035323; x=1758640123;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOrMXaFeWdA+6uylhkyGN3bVkykWditd5Sk7kd10XVg=;
 b=aBy5cau7R71UmGXB0Stxu1EZg/wmE4vwbec0qa5v8O8R6v1R/yEKvl1jN/C0dvy+h9
 ZuDEr6J8XdsVFovqlkH+6G/hCH1PIaRc2vruaXIOWqCzJI0lSu7uPGcg9OkX2W27mqzk
 BFI+M51qunmrQFoJYkHMvlPaOPKJqxlpBXYIeJaIeBk26wASHTMOwyTJqJq7ScmDSvsB
 FPG1A4H9zzoM4xneYf23vuGjiXtSAa1bsyrsed6UFQjoCHlKWX6wzyYHHu8t/HKIXtJe
 CO1jF12BBovBS5QfpYMlF117cKl/0KY2Z2TPBFRAOUG3bXnTcBLKkyswdclBugD1sJPo
 2rrQ==
X-Gm-Message-State: AOJu0YwXSlgzTtyvp6HqbaL6KKLBRQEjoNEhoqziaQ3OXJdADTkCCgKI
 mEfYva0SCHCMZjlIY0Zls2nV5QQG2gjJaznPxclYLU1U3o/3Uc2jK4aB2RbXSDQWPUQ=
X-Gm-Gg: ASbGnct98GOFXceZdkolgj7a+PgxGj40Du1SrK0D8WeayH73gaFApf7TMnVIuURIhLg
 5owe66ktI2lpBTgf0q3z2uNg/qCZmtVPSaQ9EYhZNEpVwaa+QEmRDiQOyOzJKLvkoyHJCt60Aiy
 NjSxyRzm2VnPR2uQu7tVD0UaWEs09sLnDooecC16mQFt+q8G65Qz5LLe2xbeUL7Ufi9EOUwBB3Q
 9v7GLyLAvUfWmh3dp3aTSEOYIQNcIyL2IhGiGKP2jwJvWDkPRlvpRoCvj2VpJ3Cl0zpa1Sihl8f
 E79XJd/+Ybz7jcnkSj5viUJXsA+6xsJlx/DbTc4yrcmzteLZzQWfFFQvxSfHzrKZKrY5fQ39Rki
 llmP9VPLaNcLNx8oGUyTkehfOVb7tutGSzfUeePu5GCfzA4VBy0E/EuGE5sTiGfBpQi0=
X-Google-Smtp-Source: AGHT+IERtGO84IL+7AJJCSWo8CDJXgyytP+VXg1Ob4USZwH4rOv26wkpONwgashPyrjmA8F9TMGpfQ==
X-Received: by 2002:a05:6808:e8e:b0:438:1c5f:dbf5 with SMTP id
 5614622812f47-43b8da215aemr8828611b6e.35.1758035323101; 
 Tue, 16 Sep 2025 08:08:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3216251b6e.20.2025.09.16.08.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 08:08:42 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:08:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>,
 Ion Agorria <ion@agorria.com>, Jason Cooper <u-boot@lakedaemon.net>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Luka Perkov <luka@openwrt.org>, Luka Perkov <luka.perkov@sartura.hr>,
 Michael Walle <michael@walle.cc>, Peter Geis <pgwipeout@gmail.com>,
 Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Stephan Gerhold <stephan@gerhold.net>, Tony Dinh <mibodhi@gmail.com>,
 Walter Schweizer <swwa@users.sourceforge.net>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: Continued need for ATAGS-based booting?
Message-ID: <20250916150839.GT124814@bill-the-cat>
References: <20250915203827.GN124814@bill-the-cat>
 <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
 <20250916143010.GS124814@bill-the-cat>
 <CAPVz0n26poXVYQHHCUMnAJC2iexygxXaOO_yLhc_UaVwOE1M5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AmREiGK1blVUwRzR"
Content-Disposition: inline
In-Reply-To: <CAPVz0n26poXVYQHHCUMnAJC2iexygxXaOO_yLhc_UaVwOE1M5A@mail.gmail.com>
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


--AmREiGK1blVUwRzR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 05:37:47PM +0300, Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 16 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:30 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tue, Sep 16, 2025 at 12:05:58PM +0300, Svyatoslav Ryhel wrote:
> > > =D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:3=
8 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > As part of working on cleaning up documentation, I ended up seeing =
just
> > > > how few boards still enable support for ATAGS-based OS booting. In =
fact,
> > > > the list is:
> > > > brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
> > > > dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
> > > > icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> > > > n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
> > > > picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
> > > > surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
> > > >
> > > > And my question is, for you board maintainers, do you still need to
> > > > actively support booting such old Linux kernels? Or can we disable =
this
> > > > support and then possibly be able to remove the underlying code as =
well.
> > > > Thanks!
> > > >
> > > > --
> > > > Tom
> > >
> > > Hello Tom!
> > >
> > > Maintainers of some boards in interest have agreed that support for
> > > ATAGS-based OS booting can/should be removed from the boards in the
> > > following list:
> > > chagall endeavoru grouper ideapad-yoga-11 mocha mot n1 ouya picasso
> > > qc750 star surface-2 surface-rt tegratab tf701t transformer_t20
> > > transformer_t30 x3_t30
> > >
> > > Thank you for your support! Have a nice day.
> >
> > That's good. Are you going to submit a patch for the defconfigs or
> > should I?
> >
>=20
> I can submit but that will not be too soon since I am quite occupied
> with Linux kernel stuff right now. I'll try to cut some time for this
> till the end of the week. Since there are still boards relying on
> ATAGS I assume this change is not urgent.

Yes, it's not an urgent need, I just hope to be able to turn this off
for more platforms with the v2026.01 release, given the confirmation
that some platforms *will* need to continue to use it.

--=20
Tom

--AmREiGK1blVUwRzR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMl9dAAKCRAr4qD1Cr/k
Cn2WAP9SlO7dZQW1yuKHMSyri/v7B8PO8rZX7xJNwNRb8YMXKwEAss95oI3VkOg0
c2PlIuY91/6Jy6N0fD8F+5TdRiEWDw8=
=5vB8
-----END PGP SIGNATURE-----

--AmREiGK1blVUwRzR--
