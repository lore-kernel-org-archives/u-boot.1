Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19676C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 17:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4EE88262;
	Wed, 12 Jun 2024 19:41:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oJcvNaQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703F6883D3; Wed, 12 Jun 2024 18:03:10 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9698886A
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5b9776123a3so27964eaf.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208186; x=1718812986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BVL0K+4RVRG/L5MOsD20eMVxBw1m0p8/HrcUyfTcVIs=;
 b=oJcvNaQQjqMSHWqo6x839/jYPYaULaZoNU0KiqFZgVJYhgQcQtpRmgvb7A8KBmSkQf
 tuYE6h/XYUAVO1/WLLtQjsHWz/KrImS0Whvu7rHQWmYuc8Rdc36ugHFTfp489AHBXUxk
 ZgroepB5V6rJ6+pqIQZkL/otf61RbzzzrUke0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208186; x=1718812986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVL0K+4RVRG/L5MOsD20eMVxBw1m0p8/HrcUyfTcVIs=;
 b=akkAxrr3owdA6atsVk3n2Z5mxuyCWAmjUouNLyn/9C9C8mZ7zAjGhX/6cqzZrUMB/1
 7btChesWgET+HDUN+H0Lyf0KrA3hS49gRv4eN65eidosWXyT9eIqgcwWdw+hMkJO0qkA
 T/kM81fDw/7odVfSmws8FUiXgihl9tRYvcMOQ0SiEISLyBZ/sBLICbJMrb26vDqgfU8W
 NEMhg4GGFQhmOOG1IygFq7SAE26tFzTTNxvCD8ejs8r5Q/lxBoA4LqCLvHTuKb+HJ6En
 BNSQiRID5BtPHYieOvkyf5M/9un4qUDFsKh/95+YdYGKuC2NmcbX14xlPS9KAHyA19Sx
 OA3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRn3IPlLFyNZDBqGeE3hWncrGS0Z93J0jqfTDaSM2LlgG2Hm9D7rUxTKGH5CR5ElWHlN1UcY2zyuq2KGJL38U+SH+xKw==
X-Gm-Message-State: AOJu0Ywt5CIbIpd4kNM0GvH8vOUioTD/EG4g4DbLDLrF3aBcLkO28J+C
 oExM4NPhfCV/tDzKZwnkIaMN8bES/UNiUc91MYLBJLfaRt9+32raUYiDF+hxDcc=
X-Google-Smtp-Source: AGHT+IEgASZEah86I/fbSifEySJiQWlrzH5jCPpBPAO/K2UieK91RF4s+KwwhDg0yNl1RhHqZN43/w==
X-Received: by 2002:a05:6820:1c88:b0:5ba:e995:3efb with SMTP id
 006d021491bc7-5bb3ba4d347mr2666898eaf.4.1718208185778; 
 Wed, 12 Jun 2024 09:03:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba976bf79fsm2262424eaf.20.2024.06.12.09.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:03:05 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:03:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Allen Martin <amartin@nvidia.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Trevor Woerner <twoerner@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot-amlogic@groups.io
Subject: Re: [PATCH 00/42] labgrid: Provide an integration with Labgrid
Message-ID: <20240612160301.GB68077@bill-the-cat>
References: <20240611200156.2245525-1-sjg@chromium.org>
 <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ORKuiCS28XNzSKnC"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKAaWnphnBUi6YTRMn1EthbX5mZtjh78YXyxWoXqmJcGw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 12 Jun 2024 19:41:46 +0200
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


--ORKuiCS28XNzSKnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 09:08:32AM +0300, Ilias Apalodimas wrote:
> Hi Simon
>=20
> On Tue, 11 Jun 2024 at 23:02, Simon Glass <sjg@chromium.org> wrote:
> >
> > Labgrid provides access to a hardware lab in an automated way. It is
> > possible to boot U-Boot on boards in the lab without physically touching
> > them. It relies on relays, USB UARTs and SD muxes, among other things.
> >
> > By way of background, about 4 years ago I wrong a thing called Labman[1]
> > which allowed my lab of about 30 devices to be operated remotely, using
> > tbot for the console and build integration. While it worked OK and I
> > used it for many bisects, I didn't take it any further.
> >
> > It turns out that there was already an existing program, called Labgrid,
> > which I did not know about at time (thank you Tom for telling me). It is
> > more rounded than Labman and has a number of advantages:
> >
> > - does not need udev rules, mostly
> > - has several existing users who rely on it
> > - supports multiple machines exporting their devices
> >
> > It lacks a 'lab check' feature and a few other things, but these can be
> > remedied.
> >
> > On and off over the past several weeks I have been experimenting with
> > Labgrid. I have managed to create an initial U-Boot integration (this
> > series) by adding various features to Labgrid[2] and the U-Boot test
> > hooks.
> >
> > I hope that this might inspire others to set up boards and run tests
> > automatically, rather than relying on infrequent, manual test. Perhaps
> > it may even be possible to have a number of labs available.
> >
> > Included in the integration are a number of simple scripts which make it
> > easy to connect to boards and run tests:
> >
> > ub-int <target>
> >     Build and boot on a target, starting an interactive session
> >
> > ub-cli <target>
> >     Build and boot on a target, ensure U-Boot starts and provide an int=
eractive
> >     session from there
> >
> > ub-smoke <target>
> >     Smoke test U-Boot to check that it boots to a prompt on a target
> >
> > ub-bisect
> >     Bisect a git tree to locate a failure on a particular target
> >
> > ub-pyt <target> <testspec>
> >     Run U-Boot pytests on a target
> >
> > Some of these help to provide the same tbot[4] workflow which I have
> > relied on for several years, albeit much simpler versions.
> >
> > The goal here is to create some sort of script which can collect
> > patches from the mailing list, apply them and test them on a selection
> > of boards. I suspect that script already exists, so please let me know
> > what you suggest.
> >
> > I hope you find this interesting and take a look!
>=20
> Thanks this is interesting!
> I only got cc'ed on the cover letter and I'll slowly have a look on
> the rest. A naive question -- I saw you did integrate this on gitlab
> with your internal lab. How secure is this? Could we schedule weekly
> builds that run on various remote labs and get results on actual
> hardware? Or do we have to rely on users for that ?

That's where this certainly gets a little tricky. Ideally, and part of
why I've been hoping to get Labgrid going with our pytest suite, since
it's good enough for kernelci (and people to be reasonably confident
about allowing not-exactly-random-user-access), it should be good enough
for us too. So my long term hope is that we can:
- Have Labgrid based labs + something know to monitor trees+branches at
  X location (like I know today some people poll and test my WIP
  branches).
- Have it be reasonably clear that if you maintain a lab for kernelci,
  you can add testing U-Boot in too.

In the medium term, I am hopeful we can at least expose this to all
custodian trees on source.denx.de. And I'm saying "we" here as I have
two much smaller labs also going, one with Labgrid, and both a much
smaller set of targets currently.

--=20
Tom

--ORKuiCS28XNzSKnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxrUACgkQFHw5/5Y0
tyz0JQv7BuRanyt/in37dCMi8s0RE69nlJaj9j+Y8mABNRlBVBO9Jae4RjkYBWK8
gOaxu6bN3AQ0TkEb/MGI9froWlSNnNWMzoodGwXUm3HUEIl3ykIRaQmtRQkNA9r5
0UXDQloITORfJh+7kCPHgmcRaCJE+IaOt08upsAWZnUS/kdxxgnmTGBacJWhicp7
Uek30F73/dl/K4ajtdvm8lwocR83pbGSWyBiYUYvwPks5/LpQMhxMqi11vdpXF5j
rWLwRiRx7qg5eZ8JsBowvb5No5d/aG+MVYi3U9bnubBVnu4aByKbGD6SK/HNMJFX
/OKmHX2aEqKW11Ik1JUU/+aUxRmhlAp3o0ErVaS4hbYbhjAHL7lUwsKsxlwjm36w
cvEfJpwL8D8+wLUjUbuIzDDidc1GhE6GWSSkI91H48wPSWfh2pdfAcV5d1OonQcz
FHLHpUpDW+1QJhQ+f+HJZ55a63m4+W0bMpBgFHC24PsiPcje07GkZWTrWjkoBw4s
oaN/Lt40
=R7Yr
-----END PGP SIGNATURE-----

--ORKuiCS28XNzSKnC--
