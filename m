Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63099C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 18:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BDC8648D;
	Mon, 28 Aug 2023 20:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R/QfpQu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0063D8648D; Mon, 28 Aug 2023 20:53:21 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7F086483
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 20:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bd066b0fd4so2409983a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693248797; x=1693853597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r2+YFhtnkdSPdbvBB5qXjkqMPxojVqqvRfkXsqlanu4=;
 b=R/QfpQu8bA2XgsdfZ0BwVbW1q1mn5k5yl9zak//HgQyG+puuPkPoQ4a8XlemkY1cPN
 kHNconqDYPA3awlL+Xkbk9ZPTDxyK/G6DKmbWp1qhXaV36p1MYTrDoR9UVltGXx9LG6U
 IRqHcbJaL5mkZt+4Z1I0Z0HCYYTZBC/LZpPDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248797; x=1693853597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2+YFhtnkdSPdbvBB5qXjkqMPxojVqqvRfkXsqlanu4=;
 b=YaWC1kOnXsXDeHxq+iZmv3Uy3D13s7X1BzzdWNdHoJz0ylHKatP1TK0SiyRbG7x10z
 Na1+2aQhSpBSxTeragHeTPU78za1O8lwMlZEAGzL0+eb5KCSTzXclpTAbqPCuaydbd6y
 bTPzxZOu/373kIQUADaUNdxqoO/SEskO0RLPlEU6quVtQ+arI6tE2MY1nJGbyCfY3gn+
 E1PkFxoyb7GoFFfd3tJH/2KusQsUdZrCjqlrMx4vaw7PQyTu7dnCjCynp7iQdqkTsBrl
 l147FLG1SLc1Nu4+oe52fbkZftWZQCnhffbsYvDX35FFIy480E+Lu3h8kTaFtAoFZz3h
 UsFA==
X-Gm-Message-State: AOJu0Yyy10R0gIsaXDZisxJuG/8ChrNfHm+qN9n2rITF0ldayLb3UNEl
 +g45XXh/G5p+koNdgcT/LTuA7g==
X-Google-Smtp-Source: AGHT+IHN/0TlD9jfk8uwqAUduA/op/Zl6UkXZuSi5rSsVeJwSh+kQmRr9NUwy/wkiClbKMun0ktDtg==
X-Received: by 2002:a05:6358:430b:b0:12b:e47a:8191 with SMTP id
 r11-20020a056358430b00b0012be47a8191mr16158616rwc.16.1693248796703; 
 Mon, 28 Aug 2023 11:53:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 t93-20020a25aae6000000b00d780d87cb73sm1805160ybi.51.2023.08.28.11.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:53:16 -0700 (PDT)
Date: Mon, 28 Aug 2023 14:53:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
Message-ID: <20230828185313.GO3953269@bill-the-cat>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8H9BdoROiTfgy/VL"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
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


--8H9BdoROiTfgy/VL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 11:54:55AM -0600, Simon Glass wrote:
> Hi Alper,
>=20
> On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com>=
 wrote:
> >
> > On 2023-08-24 06:02 +03:00, Simon Glass wrote:
> > > In this early stage of using binman to produce output files, we are m=
ostly
> > > seeing people using common extensions such as '.bin' and '.rom'
> > >
> > > But unusual extensions appear in some places.
> > >
> > > We would like 'buildman -k' to keep the build outputs, but this is ha=
rd if
> > > there is no consistency as to the extension used.
> > >
> > > This series adjusts binman to enforce just 4 extensions for output im=
ages:
> > >
> > >    .bin
> > >    .rom
> > >    .itb
> > >    .img
> > >
> > > Other extensions will produce an error. With this rule observed, buil=
dman
> > > can keep the required files.
> >
> > I dislike this limitation. We know what files we will generate, they are
> > listed in binman dtb, so we can add something like `binman build --ls`
> > to print their names/paths for buildman to preserve them.
>=20
> Yes, it would be good to have that...
>=20
> But why do you dislike the limitation? Do you think extensions provide
> useful information? I suppose one problem is that *.bin might pick up
> private blobs that happen to be in the source directory?

I think all of the complaints thus far have shown the problem with
trying to enforce an arbitrary limit here.

--=20
Tom

--8H9BdoROiTfgy/VL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTs7RMACgkQFHw5/5Y0
tywczwv/W/+2WfWziobicYJaae94xnLvnnop8hRq58wRH6FqJQo61KPwIuFKQ162
f+9WmEAuDs48oNKJsqPQefAvP/AJnEXEjlVlyv++T4BeHusQWnrOa6oWnPo/8uK5
ZLad0G0OCYoja471KfNq0ASkwOu64hmQHkXQO4olZ+Cfc4MrmRDIigMfIZ6vhy1O
0pUtXFyF/JH2srjxeDh9hAvR5SzLVBzgbzMopMacRwcXMgLCz/WoYD7eIyI2UKuO
p0vp8bCa324NE76lH8xB6lKGgLywrk9MpXDHW6XzbIkHVl6CW0GoIsQfeMjAxFgx
tC/vPKh+Kqpw2A3xiRYtgWZmnN1rMnRg7ltn80C6YMcbAEgCBvxLSzjtbbhMpRV5
cvXWDe2N6LxqxJtNgepm0QPFGIzsRyHv4etVSRU8AJp2Fi4VXTEgSwY0wMAdRVT5
Sohn/POxYRGfoClH15aaAV/H+Hv/2NwHZTRO5g0S4G2bxKS20u1jVCD74zRXKIJx
WoI47rEi
=SXTm
-----END PGP SIGNATURE-----

--8H9BdoROiTfgy/VL--
