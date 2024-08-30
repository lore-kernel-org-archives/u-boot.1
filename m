Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF22ECA1003
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 15:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B6E88C3E;
	Fri, 30 Aug 2024 17:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725031202;
	bh=cTqXdUwDVL5dHzipleo1m8JsGzYT9D7o5quAI2dDVNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E0J8foavNoG68Ui8QvIrOxkUbgHnTq1SGHHGB0P8zOztCQz4S2hnuQ+p8mANe2uLC
	 fB5EewDhnN5cbgT2lhk5I00kSNVCjOw0Ry9113EtGCGQvxmO6laKECazng2vwtlw6V
	 r/diD/1y26iMickKd/qCCCcRvYXHMlhrCcR0IddmZUDXtPqWr6m3PpvOP3T3OrlgYa
	 xCaJrhAwpyHvYUr4ra31kgvNw47XBkSOnCNqP97z4Hr2rIkXn+xWvuxV6yJt0Kw9ZN
	 6sUklFYDWROBCx4EvK/njCjdeNDg6sLSHH3sgYpJGlUHmgI+b5DOSm27tqSK6g0Nz8
	 8HQ0IOcEwk37w==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BA95C88792;
 Fri, 30 Aug 2024 17:20:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725031201;
 bh=cTqXdUwDVL5dHzipleo1m8JsGzYT9D7o5quAI2dDVNE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YJGSFIRpBWVWhe2OxN2W953wpXhkxlIVa8d0ij6/Bo5UTGUWElCwPeJ2TBsqe1fnW
 L5ZjHUS19f6uiptFQa6lN7kLT1KSl7E+SvI3eTI9FHJdKUQC8eyKPy3+BKszhhIUKq
 Hz9c7VpvI5VaDALXJhqGlFARF7Nj2MHylVzZOQ6HlseH2sWuWBw15A8QkCl7+cP3pm
 AdNiTtaPyx6QoeTIR8fM4SR7Xy9N7rqA+takVc1/S9THY+c75DpvGHiSgjttoVq/+7
 2lslgJBH9/43L2E0TRJFR8DaPO2lxG/xTCnyjadiOw7fpPJ2UqC7QUGI8Aguqwlk/S
 577dkHpDrKENw==
Date: Fri, 30 Aug 2024 17:19:59 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Fabio Estevam <festevam@gmail.com>, Teresa Remmet <T.Remmet@phytec.de>,
 Stefano Babic <sbabic@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 Cem Tenruh <C.Tenruh@phytec.de>, "Tom Rini" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Yannic Moog
 <Y.Moog@phytec.de>
Subject: Re: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
Message-ID: <20240830171959.5a85f722@wsk>
In-Reply-To: <dbf9bf5e-b96b-4e34-816c-215e68289526@phytec.de>
References: <20240820145944.3048128-1-lukma@denx.de>
 <CAOMZO5AAfn7zw1+VEGjdS6UAQLv5kTVT97_dy_oxhauntYeHvQ@mail.gmail.com>
 <20240828095520.76f904bc@wsk>
 <dbf9bf5e-b96b-4e34-816c-215e68289526@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uUVyZkl77VM0OpDpSGmmHI9";
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

--Sig_/uUVyZkl77VM0OpDpSGmmHI9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> Hi Lukasz,
>=20
> On 28.08.24 09:55, Lukasz Majewski wrote:
> > Hi Fabio,
> >
> >> Hi Lukasz,
> >>
> >> On Tue, Aug 20, 2024 at 12:00=E2=80=AFPM Lukasz Majewski <lukma@denx.d=
e>
> >> wrote:
> >>> The image offset when booting from SPI-NOR (QSPI, FSPI driver) is
> >>> different than one for SD card / eMMC as extra space (0x1000) is
> >>> consumed by FSPI configuration header (CONFIG_FSPI_CONF_HEADER).
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>> ---
> >>> Changes for v2:
> >>> - Avoid line breaks with defines
> >>  From the other thread, my understanding is that QSPI boot is
> >> still not working with this patch applied.
> >>
> > But this is an orthogonal problem - the problem is with binman image
> > generation.
> >
> > This patch follows the code already present in e.g. imx8mm_beacon*
> > boards.
> >
> >> Please resend this patch when the QSPI boot problem is resolved.
> >>
> > As I've written above - problem is solely with binman code
> > generation - after reverting 3 last commits from imx8mm-u-boot.dtsi
> > the image is correctly generated.
>=20
> I can also see this. When I apply all your patches and revert those 3=20
> commits, SDP boot via uuu and flashing SPI NOR flash with the qspi
> Image works. And then also SPI boot works.
> When I don't revert the 3 commit, it does not work. (SDP boot via uuu=20
> does not work and the Image does not boot when flashed into SPI NOR
> flash).
>=20
> I haven't investigated what the problem is or how it can be fixed=20
> though.=20

The "Hackish" solution is to add:

@@ -85,6 +85,10 @@ void ddr_load_train_firmware(enum fw_type type)
                }
        }
=20
+       imem_start -=3D 0x1000;
+       dmem_start -=3D 0x1000;
+
        pr_from32 =3D imem_start;
        pr_to32 =3D IMEM_OFFSET_ADDR;
        for (i =3D 0x0; i < imem_len; ) {

(The -=3D 0x1000 is the size of QSPI header added to the beginning of the
image.)

Simon, has recently prepared set of binman related patches, so maybe
they provided offset to fix it.

> So I guess further investigation is needed here.
>=20
> Benjamin
>=20
> >
> >> Thanks
> >
> >
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
> > lukma@denx.de
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/uUVyZkl77VM0OpDpSGmmHI9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbR4x8ACgkQAR8vZIA0
zr3SzQgAt9LRlkkHQ7MjQQ2jd5mcsyTZToeOuKLqpyaQvk4hgHaJHER14INNxDY5
7CYDrox9apujGIKyDqcwq4Rc8aTILwgN894WTtoO1WdvuMuvINPpFkr29PJETXe5
4qvzU0p+kWtXW7nZlwiOAju/lVJsrGpJ7aFw5juKZjrT6zmt0SuxeHVXOJ7PMJm2
wWwtH6b2WTvl4AHruK31kMkozwvTlfLv9ygx+6ex/RZNdbwVoma/gfiS4DgVMZEF
spAaMGIRTDmk3Z3gG6yaHxOhpQgPq7nA5yq2SxiPDFqG6tFN9nRKqY+B5cJYRvim
r6ZYsehm+XvTyYdYNHuW2SpRoW6/Hg==
=eMb0
-----END PGP SIGNATURE-----

--Sig_/uUVyZkl77VM0OpDpSGmmHI9--
