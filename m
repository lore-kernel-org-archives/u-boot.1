Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76246CAC599
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 14:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA6FF832F0;
	Tue, 16 Sep 2025 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mHu1ux0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B66832BC; Tue, 16 Sep 2025 16:30:17 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A2E800D7
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 16:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7459fa1ef2aso5480739a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758033013; x=1758637813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cZk7Ebxo19kBJ2a8IPPe5TnrVMaLhkY7ATIAbD0LwTE=;
 b=mHu1ux0k8SKT/NkT0nbymDymdfZQAD5rKMebi2OCqN1xGkKTSM7fC7Qrg9A+eHDQDj
 QGOX2JAfxTD4cThh+WtDBheGBEJF67pACUjeJHcZlWpT8EEgaMsSyzQFv+L8qgLXyJeD
 9fi76C4KiqAcgcKS8b42+8Z+XlBZPMMhoafIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758033013; x=1758637813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZk7Ebxo19kBJ2a8IPPe5TnrVMaLhkY7ATIAbD0LwTE=;
 b=cbY7+OmJYHkKNS4YH3SRwKdLMr0aCaNXg+Vb1Wt+4m3/uXnQjWf5JQjq5Bag9r2Uo+
 hPr5dD9efKQnHW62bSVApe6xHqfKAyfBv+NsGOq9EbVpAtkZzHdwxVhv+b5jZ09+8Pq/
 l65hP+9OaWeMWRbosJzpb7/pnHKPG7s56RATSFa2FwnjxsoZsJTZ/TFdK66czIV05cZy
 a0MOle2SWWNbwTfyl5Ug4OSA8PRH+5ySPk8QBW6r/1f6pW0EHUA2FGqA8L8mofbi/+mn
 ofrn/4GPOy3Uf81oWLCVc0eKpnLvmGgeav68gxN6/dS3HFJqwcLyo1dOlmq53GFPnCpP
 wVsw==
X-Gm-Message-State: AOJu0Yy7H5LFF4fiQyBDkZ5pqgs0kcInjo6K/sSCKx1D/nQ5bZExNA8+
 bUdroY1I03qPkYYCKQtlgBXkaIdz8ArUeRfybamGCFW35W0GfbDJcYm/3Y/wipjO3gM=
X-Gm-Gg: ASbGncuTNa9aXNFUM+rnCj00jezEYTWHL6zKtF7zKVSyMJz1OyOygJVSGHAef551sv5
 WUfBAoATJgmP+D7x+vL8c7Svyg18j6JSo5L4zjrITW/FI4m+AaEfcLeznMXZAux+qElfyyDhpyx
 sO7HtLO1LCuUFKl3uhLj395Pn6nN4pQFQqtWL55N7dcKlE0AE7vrwcWX8EvPYMWZdp41JoiXsJ4
 A/KF0WM6ekaXjVspLXKYP7dRcgdYoiOc7VzQNYQUH90OzSxgQ2nRrxWVO0fgFTk/Etm2M4at0gx
 P3anUQzhvarWoDKCDFxVHAy2r0X+Z/szdRmYniryfZFNirSPvE5h5vO/DyJfy7FdDXvK093/Kq5
 9/Fa7BELaZk1dySEZ11dlfAf5M5F0bc5uZfDo0hUdy0yGR+4ecxVQPuYEjLA7/54lbSc=
X-Google-Smtp-Source: AGHT+IGX8qQLxifdbLuC/OVKRI7Lnj1w5iL3YZjOyQvje+Xx+MFjZHqo45UguuCX1EHSG7bjY4p6RQ==
X-Received: by 2002:a05:6830:630d:b0:745:53ad:e25d with SMTP id
 46e09a7af769-753550e035amr9431161a34.21.1758033013615; 
 Tue, 16 Sep 2025 07:30:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7576393e95csm2330679a34.22.2025.09.16.07.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:30:12 -0700 (PDT)
Date: Tue, 16 Sep 2025 08:30:10 -0600
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
Message-ID: <20250916143010.GS124814@bill-the-cat>
References: <20250915203827.GN124814@bill-the-cat>
 <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6FeMMwsRrUb3CEy7"
Content-Disposition: inline
In-Reply-To: <CAPVz0n2tpEVrZ=1k9BPyg8h3Fa_P_J8VKoQFn0MZU0rOwVbstg@mail.gmail.com>
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


--6FeMMwsRrUb3CEy7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 12:05:58PM +0300, Svyatoslav Ryhel wrote:
> =D0=BF=D0=BD, 15 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 23:38 To=
m Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > As part of working on cleaning up documentation, I ended up seeing just
> > how few boards still enable support for ATAGS-based OS booting. In fact,
> > the list is:
> > brcp150 brcp170 brcp1_1r brcp1_1r_switch brcp1_2r brsmarc2 chagall
> > dockstar dreamplug ds109 ds116 ds414 endeavoru goflexhome grouper
> > icnova-a20-swac iconnect ideapad-yoga-11 lschlv2 lsxhl mocha mot n1
> > n2350 nsa310s nsa325 openrd_base openrd_client openrd_ultimate ouya
> > picasso pogo_e02 pogo_v4 qc750 sheevaplug star stemmy surface-2
> > surface-rt tegratab tf701t transformer_t20 transformer_t30 x3_t30
> >
> > And my question is, for you board maintainers, do you still need to
> > actively support booting such old Linux kernels? Or can we disable this
> > support and then possibly be able to remove the underlying code as well.
> > Thanks!
> >
> > --
> > Tom
>=20
> Hello Tom!
>=20
> Maintainers of some boards in interest have agreed that support for
> ATAGS-based OS booting can/should be removed from the boards in the
> following list:
> chagall endeavoru grouper ideapad-yoga-11 mocha mot n1 ouya picasso
> qc750 star surface-2 surface-rt tegratab tf701t transformer_t20
> transformer_t30 x3_t30
>=20
> Thank you for your support! Have a nice day.

That's good. Are you going to submit a patch for the defconfigs or
should I?

--=20
Tom

--6FeMMwsRrUb3CEy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMl0cQAKCRAr4qD1Cr/k
CmIEAP4t39MZV+kBXS46GRud04m2/ICtQnX/abhjY11RqGg37AEAt0u92F66kWXF
MOtmI1WK12Z8PO6Na1oBOtZchw40TAk=
=IEIB
-----END PGP SIGNATURE-----

--6FeMMwsRrUb3CEy7--
