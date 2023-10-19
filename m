Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED42AC41513
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 08:18:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFDA871AA;
	Thu, 19 Oct 2023 10:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697703502;
	bh=KQrUYG17if4nMC+DPHU4BGenimPv+PfRXlgQ/LHGiE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OSVV8rUWU2rCXnjaql2IWSGF/gfU9AVRZRJn8Gs/UbbkUfbUEVPIWZ7/CaUnD1WxG
	 VATFB13HfStBdLSWudvn6C/0YOgCwrWAI9zeAcNgU5EffKWcegl8M2XTvW1Nhs00mF
	 59NebSr+1djJ9BMF3YBFOIFFc3bnZcE7bdmcddR9XV/rhSTCIl9j5MID4J41P8HRAh
	 rngf0Hf5yDiJpZywAkM2JJjC5898g+wbtYM0UaqTgcn0unLue4Nn2O0Bxu41zv/MdC
	 KRyd9ts4Zq9U8JNMChfRqfen6yWoMlBM0Jfy21q6ORXGRmeRMnSfOs0Qy9hn7jAFel
	 kfmGXVDZUcT6w==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2F6EB871A5;
 Thu, 19 Oct 2023 10:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697703501;
 bh=KQrUYG17if4nMC+DPHU4BGenimPv+PfRXlgQ/LHGiE4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=tg25x56CEhdG7N27RywLDszCeZftXGP+ft/0Y1bssNKn35vg5qjWOkZR/o8MaKqgI
 HU4rPYHjHR1z1SdvIlnKSDiiTjfJPsEWBIMcB80gm1CbEWYxrHZ1WnkdcF0qXfwIXQ
 Fwjah5zDOLdbLjut7CWVwRlnwnIjjRZP7hPQNyn22PDvi6KWbha3HJUUWdNZwcYgDr
 XbffepsgCtr9ewE67zomcA0B6o6jyyYL8QoawIE04QwMy19BXsWEwwEwgaa59UoQUE
 t6VjcOGzKkc4wN+cblFe/EmjnCiOt3PnJZAj22hjNrMJGLE3WrT2FFcGtqIWtkY86/
 wUaYNsdrEbw6g==
Date: Thu, 19 Oct 2023 10:18:12 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] MAINTAINERS: Add Mattijs to USB/fastboot maintainers
Message-ID: <20231019101812.2782fa2c@wsk>
In-Reply-To: <87h6mnnjpm.fsf@baylibre.com>
References: <20231005-mattijs-usb-v1-0-7e79ab31ca49@baylibre.com>
 <20231018125220.4b08c62c@wsk> <87h6mnnjpm.fsf@baylibre.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ECnjNios/E8.nBQsN_rJUYI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/ECnjNios/E8.nBQsN_rJUYI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Oct 2023 09:40:37 +0200
Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Lukasz, Marek,
>=20
> On mer., oct. 18, 2023 at 12:52, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > Hi Mattijs,
> > =20
> >> From discussions with Marek at Kernel Recipes, it seems that the
> >> USB subsystem in U-boot need some help.
> >>=20
> >> Since I've been asked and I'm willing to help, I've added myself to
> >> the maintainers entry.
> >>=20
> >> I have also added myself for fastboot since I'm interested in
> >> keeping that functional as well.
> >>=20
> >> Note that I have no previous (open-source) maintainer experience
> >> so I will do my best to learn.
> >>  =20
> >
> > Thanks for willing to help with maintaining the code. If you need
> > any help - then just ask :-)
> >
> > Acked-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> Thank you for acknowledging. I'm both very happy and a bit nervous to
> start :)
>=20
> Do we still use the following custodian tree:
> https://source.denx.de/u-boot/custodians/u-boot-dfu ?
>=20

Yes.

> If yes, I imagine I would need write access to it.
>=20

I think that Tom shall have credentials to add you.

>=20
> > =20
> >> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >> ---
> >> Mattijs Korpershoek (2):
> >>       MAINTAINERS: usb gadget: add Mattijs
> >>       MAINTAINERS: fastboot: add Mattijs
> >>=20
> >>  MAINTAINERS | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >> ---
> >> base-commit: 65b9b3462bec2966911658836983819ab4e4823e
> >> change-id: 20231005-mattijs-usb-6b83dde256f0
> >>=20
> >> Best regards, =20
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ECnjNios/E8.nBQsN_rJUYI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUw5kQACgkQAR8vZIA0
zr2IrwgAlHi8w80v5uJupmkWlxeeFF7wNKAsJkbYd4bUFJPG8T+1UyVSAk30TvJc
tU1gIJNjbZJrH6j+L12RlGV7zrbSnOfSaQtnbw46rl71uxsjaaYYky6YNQ5QYP7B
f9xyjRTjw+Ml+hoA8zHcjbFQNGNG1m1iNj3PEf3gYxm5LLhEh+ohNtlR3Hcvf2zo
4NXW7nz867eLK+T62ew6CvweUWuQqxT46pAvsf2tT42SHAoVJLaPa3N2nbFJjib7
XQRGLCEfyYCI9ewg+Z3/FSOhQ8NwPGZvQbDu3BLdeMZt9OroxthHHvvQadNgHiL5
W5dsisVDZPf+kh1Cc8sdPXBDfnArFA==
=mQng
-----END PGP SIGNATURE-----

--Sig_/ECnjNios/E8.nBQsN_rJUYI--
