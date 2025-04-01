Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D92C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C9881703;
	Tue,  1 Apr 2025 19:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Hj7ALviH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BDB981DE3; Tue,  1 Apr 2025 19:13:51 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF0480FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:13:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ff0df81fdbso1411401b6e.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743527628; x=1744132428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HMR5/rfTH+CPGkmuaaFQkYYVeKwv+B0pplZYOxaDYPg=;
 b=Hj7ALviHUtbIZT0CjyJ0/XfTvpXd0at8cpv8+pKZgPVLkdoVwGDpPvvQRPnlw6Vq1Z
 NjFHjEvZVx2wLjnA7zWzafL9vIhSPY6aG4zCIxkJQ/SIfEIfBrw6qz6EftIMENQmvRzw
 p4n/rGok6xFH+71pV1KUdJ/AtbRq1cF7DSxLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743527628; x=1744132428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HMR5/rfTH+CPGkmuaaFQkYYVeKwv+B0pplZYOxaDYPg=;
 b=kvMlSboQWYcshLxsv7btBmPvyHCvzyFaek58BnWqEmaquZLaO8WxC/4YVwJELTbL3l
 9xH6t8s/tiUdURYHL7fDfhqHWHt3meG3265omeC7OCgMzrCSUS9nMvrEMuqWkKC72nJe
 /Thyp6NQk6rdvyGLU6Z6niuIKjSegcyyBfZoEtdj/vA8EGCLyUcHrGqWXR2mi0KlEUdN
 AFuBxNfHAp9t4rzFN5i+FXPGXD43YtqfZQRpXRYV7hFcAOa0E8QMKcQq/staTR2WQK/l
 DaIACePmf4qToWsZ4Mu1Nfy4wvyBTacHSTi54b7IeogSwpUvsSSGbvfoDSXAklpqEhod
 d01A==
X-Gm-Message-State: AOJu0Yw5a+6GCZA1QAdFz0Db+0u+T0cyLFD5jmezSsu1dMKI/c1MYIHi
 vcOXX52U0Fkqz7dTEzkQlwDxFL8jv79kZwBlT1SNmnXSuQSBlEWDPWGrM0Iyvdk=
X-Gm-Gg: ASbGnctoNJoy4VDxgFgd/W22ucDi7W4euk/gwGFh7cunFFB4QHTaH2SAUDG2UBIxilf
 floqY61Jgqq+zcXmh06Y4q8S5/y/rstgDPz8TT+aANSeRZGJMoLvXd4YHwn1RM6SVOhZPCuc954
 dbSKiJXBOzYGlf0uds4so9Am0fKoggiY2j3TT9C/941qG9zqqLBwt6h/cgYkXDsJ3+lwfpUKmts
 +oU1Ji/pS/1/EaPHoCjzebB/gOGMkkP/CuRRwSjZ1hQ4Nd0byA/47s0joVasnekEsTlgGD4592B
 LWmaUapogD1/6lHRSkiJm5vXA/RLZPo9t3dKqYppXbVyjPIXTAl0DaM4uXSw999RLme0FSBUADR
 cT2MWTA==
X-Google-Smtp-Source: AGHT+IEyY4aFMaZg3F9HH8i5xSJLmPoRdDN8kLd7MRcZ28GPnCIDS6tYCiZQaZe5ic77u0OmEJjJfA==
X-Received: by 2002:a05:6808:d4e:b0:3fa:82f6:f768 with SMTP id
 5614622812f47-3ff0f5b43b9mr7676298b6e.27.1743527627826; 
 Tue, 01 Apr 2025 10:13:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6028461b46csm1902174eaf.34.2025.04.01.10.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:13:47 -0700 (PDT)
Date: Tue, 1 Apr 2025 11:13:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 00/56] expo: Various features and improvements
Message-ID: <20250401171344.GL5495@bill-the-cat>
References: <20250328130713.2612648-1-sjg@chromium.org>
 <20250330144709.GR93000@bill-the-cat>
 <CAFLszTiykZ4EaLz2oBmUduLm_OsdDxamANf0cbBFaOvzyMwmMg@mail.gmail.com>
 <20250331134239.GS93000@bill-the-cat>
 <CAFLszTgnEkN18sD7oKZpriiWqUNLgQ5_j2_2WpNDtvZo6Pyc1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kfUhPf0M5KiGpS4t"
Content-Disposition: inline
In-Reply-To: <CAFLszTgnEkN18sD7oKZpriiWqUNLgQ5_j2_2WpNDtvZo6Pyc1w@mail.gmail.com>
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


--kfUhPf0M5KiGpS4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 02, 2025 at 04:43:22AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 1 Apr 2025 at 02:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Mar 31, 2025 at 01:18:25AM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 31 Mar 2025 at 03:47, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Mar 28, 2025 at 07:05:47AM -0600, Simon Glass wrote:
> > > >
> > > > > This series collects together some new features for expo to make =
it more
> > > > > useful for boot menus:
> > > > >
> > > > > - measurement and display of multi-line text objects
> > > > > - internal alignment for objects (e.g. centred text)
> > > > > - editable strings in text fields
> > > > > - new 'box' object to draw a rectangle
> > > > > - highlighting of menu items, rather than just relying on a point=
er
> > > > >
> > > > > Expo's boot menu is restructured so that it is possible to iterate
> > > > > through various bootdevs and update the menu as new ones are foun=
d. This
> > > > > is more in keeping with how bootstd works.
> > > > >
> > > > > A new textedit object is added, intended to provide a simple text
> > > > > editor. Future work will complete this.
> > > > >
> > > > > With this series the boot menu has a better layout and appearance.
> > > >
> > > > Did I already say this for v2 and forget? It looks like you forgot,
> > > > again, to split the expo stuff out from everything else, which othe=
rs
> > > > might review.
> > >
> > > This series is all expo stuff. Can you please explain your objection
> > > more clearly? I still don't really understand.
> >
> > All of those patches that don't start with "expo:" aren't expo changes,
> > they're changes to other parts of the codebase.
>=20
> Oh I see, you are talking about the video patches at the start. Yes I
> will send them separately.
>=20
> >
> > > > [snip]
> > > > > base-commit: 37ef92a972663c6de1b81d24d2ca5cfd664fc6df
> > > > > branch: schd2
> > > >
> > > > Of course, not being on top of mainline, no one should spend much t=
ime
> > > > on this anyhow.
> > >
> > > As I thought we agreed, it is helpful to review patches so we can keep
> > > the trees in sync so far as possible. I take your point that few will
> > > be interested in expo and there may not be many comments, but sending
> > > it makes it available for review and potentially sending a PR for your
> > > tree at some point.
> >
> > Yes, said at some point we should try it. And it's been a failure, so
> > I'm saying to stop. If it's not based on top of one of the mainline
> > branches, don't post it. Enough other contributors have expressed their
> > unhappiness at reviewing non-mainline code.
>=20
> If you would like me to send patches against your tree, please
> consider applying the various series you have rejected.

They've been rejected for reasons that have been explained seemingly
countless times. Please drop them, or just move on from the project.

--=20
Tom

--kfUhPf0M5KiGpS4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfsHsgACgkQFHw5/5Y0
tyySFwwAoIEvw1+vHwme6vycf/Wp1z9x+ZiXGvs5Eu3urPpwyY0ynpCDLmIP8Zrk
8jcgQnZuEFxjq7j1DJZKq9uwuJQ12kZYEcv0KK4FokHR5OgtSiP6BBYg24Ia8FSp
n0AEz2ycNWt8Di656It2y/SuW58OOTX12zh0UoEq5GM3cWXbVkj7FEZ7PsBHPmAc
2LLLaygmIJlMVMkfofd+FEuz/sl65oKhgPWbK/rRzv3Ctf7hzNii00x4/oC2gX/o
WbjAx8AtuZiTtegItn8hgicTt69HiVwHLhKdIThT6s6wieUHHW8O58bfq5o33O2x
C33GfiQu81quge3G/MX6GCT5cjbJ2VBua8cvZJUdVLm54vb6PseXSiuipPwxygXX
PTiplGIJvtTddhLTl//jOsVOFPZ8KU1bjdJW/q5dimYFVdycC09THCTS1iHiEdH6
sRlbY0gTxvJP+neS8JVW6JPOVoECIaZcMvM2mJcxaml3l5L7opKMe8WHRzCFJoZd
oarJBeNe
=bW+D
-----END PGP SIGNATURE-----

--kfUhPf0M5KiGpS4t--
