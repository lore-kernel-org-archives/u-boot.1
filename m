Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E313ACD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 16:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531878497A;
	Tue,  5 May 2026 18:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B0H7WN+Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D9D8499C; Tue,  5 May 2026 18:39:50 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9998C84974
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 18:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7de46b8e432so5148856a34.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 09:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777999186; x=1778603986; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9I35abbNOA6XCMsZKD+zZ/W+A7PnR+iMwnAOdgU/rsE=;
 b=B0H7WN+Z2+0VuE8ImqORIUJllgblpBqnHruR4ufIydBQa9tm2FDspzq8c/iLmrP3zJ
 J8Y1Q7pYNbjxUvP3r3yNcU4FeNIiSCDZ4BwVoUkok6NihV25kDRA6NGpPuR+SLZOPbkT
 b6gQBCRxh4ednQx951yGExa7kmY+B4orE9z/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777999186; x=1778603986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9I35abbNOA6XCMsZKD+zZ/W+A7PnR+iMwnAOdgU/rsE=;
 b=mMelydsqLiBp3lqC9baznhLsXs4dqfuMTZ1K4qO+KPCY1X9zMFEOzFyGOn0dSUM59Z
 wU1QZ0Nz/n6b0SzSTK6pnTGhkrfynwXKBV/+GwsYpkjxAvzawmiA8wSlRTvwt5FrJ58i
 7zqmigDOjHtUF/tXKV1yFcBWdbPK34ij/EqJUEMhVUXO7G7CunujZwGSUyZmPaA/IMPP
 gIp0Q2EYRx/Z4P8gvfYU7v7AfF4B2NpjaM6SSG9jKt/zH2FUEauJa8zxNjNOuUVB8Z8W
 jT+BiH9rs3HdvuAfu+3FYPGezodVM3CnABB7wTbFeHeSVtNgfV6afAs7uo4zF4BViKhc
 Fikg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0YExImqXTUOTwnbr24LxIR5wCqogYVtwO8X90xNXXTcOtVvkfj/HfmqctdCym45yY2vKiri0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr4qKn8vdBpnzdoUuhxaYtIb2Y1vy8CrtxIJqL8YVTGnUoVmPy
 il7d2by6YaskH7zG7UZ7PgyAlRKoSriV7GzvG8WwRG0SrpjIOtgdNTUekPhXJ6SXsVo=
X-Gm-Gg: AeBDieu31dVllA5Oec5yiwPnw7F2IbQ1zNk8u6dDHMtJYWc8ambT+jlM6v5iO8EemlC
 w6+InBx9sNQtie0BP9OaLfbKvWjXOcZ6SxBX1TAtofps5orZmzT6lUC+/CkaC8ZeU73DYv5jEb8
 /L+5g4+JCW0NYh6oiisBwuNBNlTtZrxaph8gczsbKRNoqlisYEME3pxIHQKYj1jEWewbQ9pTUlI
 V+n+BkQ/JaRCuOJ+m32j0cDnhStkHqUlirj7CXMoH9cBqHMED2YSkirocDuedlgyeNuNDKqOgP0
 5Wjhl8pUjok4mx7BgsGn2S0Z5mnwYyahChT8RmSAAJSrIiGzpon0h4iKXHrlxktIujJOjXbIrq4
 ti/NEtdJsCAzZT+0yzvOC5qLT+hmqQCRBqDQQ8m70tKbWiWz66dWDgrhAdJgEFLy4mGpJLPf6+w
 si5gM0J56pmQoyOa5jL0NrSOsIV1uCKoqo1P3v47a/NV0a8IcCVFIM+U2LLdemBeOAp8CtVlt8S
 iGHb1qoz89eX1pzhUjKQoDe1gmxwD5rVva3sC149ldJ1GbCHiSXg6zykBLo9g==
X-Received: by 2002:a05:6830:6d13:b0:7dd:e032:3cdd with SMTP id
 46e09a7af769-7dee1375ba9mr8769114a34.18.1777999186294; 
 Tue, 05 May 2026 09:39:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac248d1sm10665205a34.15.2026.05.05.09.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 09:39:45 -0700 (PDT)
Date: Tue, 5 May 2026 10:39:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Paul Barker <paul.barker@sancloud.com>,
 "Andrew F. Davis" <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Anshul Dalal <anshuld@ti.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Andre Przywara <andre.przywara@arm.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Ion Agorria <ion@agorria.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 13/14] arm: dts: am335x: Remove unused uboot devicetrees
Message-ID: <20260505163941.GA2508910@bill-the-cat>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
 <20260427-topic-am33-evm-oftree-v2026-01-v7-13-7e6cd1a805a1@baylibre.com>
 <20260428104133.5b437e99@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="673zfA9CLYugaxI5"
Content-Disposition: inline
In-Reply-To: <20260428104133.5b437e99@kmaincent-XPS-13-7390>
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


--673zfA9CLYugaxI5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:41:33AM +0200, Kory Maincent wrote:
> On Mon, 27 Apr 2026 11:01:29 +0200
> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>=20
> > These devicetrees are not used anymore because the boards are using
> > upstream devicetrees now.
> >=20
> > Acked-by: Andrew Davis <afd@ti.com>
> > Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> > ---
> >  arch/arm/dts/Makefile                              |  11 -
> >  arch/arm/dts/am335x-bone.dts                       |  23 -
> >  arch/arm/dts/am335x-boneblack.dts                  | 174 -----
> >  arch/arm/dts/am335x-bonegreen-eco.dts              |  53 --
> >  arch/arm/dts/am335x-bonegreen.dts                  |  14 -
> >  arch/arm/dts/am335x-evm.dts                        | 767
> > --------------------- arch/arm/dts/am335x-evmsk.dts                    =
  |
> > 730 -------------------- arch/arm/dts/am335x-icev2.dts                 =
     |
> > 486 ------------- arch/arm/dts/am335x-pocketbeagle.dts               | =
237
> > ------- arch/arm/dts/am335x-sancloud-bbe-common.dtsi       |  67 --
> >  arch/arm/dts/am335x-sancloud-bbe-extended-wifi.dts | 113 ---
> >  arch/arm/dts/am335x-sancloud-bbe-lite.dts          |  50 --
> >  arch/arm/dts/am335x-sancloud-bbe.dts               |  53 --
> >  13 files changed, 2778 deletions(-)
> >=20
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index
> > d90e02ca4e5c73534ce4c5f41173c897780bc6fe..35145d7e01176e320ebbf5e4004a4=
6540f8933f1
> > 100644 --- a/arch/arm/dts/Makefile +++ b/arch/arm/dts/Makefile
> > @@ -403,26 +403,15 @@ dtb-$(CONFIG_ARCH_ZYNQMP_R5) +=3D \
> >  	zynqmp-r5.dtb
> >  dtb-$(CONFIG_AM33XX) +=3D \
> >  	am335x-baltos.dtb \
> > -	am335x-bone.dtb \
> > -	am335x-boneblack.dtb \
> >  	am335x-boneblack-wireless.dtb \
> >  	am335x-boneblue.dtb \
>=20
> I think you can also remove these ones.
> IMHO all of the devicetree described here
> https://elixir.bootlin.com/u-boot/v2026.04/source/include/configs/am335x_=
evm.h#L117
> could be removed. Even if they are missing from CONFIG_OF_LIST, which cou=
ld also
> be corrected.

I'm OK with that being a follow-up since there's been no other changes
requested / problems reported at this point.

--=20
Tom

--673zfA9CLYugaxI5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafodTQAKCRAr4qD1Cr/k
CocEAP9VOu1uhxW6Jp5U7F+NbJt0qP5lxVDuXGKAgtR/qPiKwQD/ayZHsRuhBOcB
ll0WoalNMcNctXXe0d9PV0HmjyQurQ4=
=WUG7
-----END PGP SIGNATURE-----

--673zfA9CLYugaxI5--
