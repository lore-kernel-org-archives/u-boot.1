Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D6AC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 925178815A;
	Thu, 28 Mar 2024 13:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711630355;
	bh=ZiUEDbdFS+lbP2cstZLVYkCErUSrI1NJ6My2I5qdbFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmlW91YEDNIjqeJ0rprpYfAP/RnXZAF7Y7qGh0zZtvHEZyEHmDMDVTzS7dhVuoFpD
	 dDInEG8VyRTttSz4kdnNWqhK9O41e2ED44OYZBiYte8gOhd6RSBlVbik3381l6c9l5
	 SrykYCzNEJYf/5BX/A9et0m/y8qBb8jegWdcUmXFrfSojY8IrIQlnfML1bDQGTywcS
	 FJeeoS1kvH4pcGXehjQws61fUh0+pQDTONIRVlcULi5MCvQsDUAGTtOy4QamBC6Nty
	 jrH/1p4Dja8VDDaDltjrwNIupd7121g6P85U7g1abmrVs0X0wfoT4qtXrALnq2Sp4i
	 CIbJetCWLwkZQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DF18C87ED7;
 Thu, 28 Mar 2024 13:52:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711630355;
 bh=ZiUEDbdFS+lbP2cstZLVYkCErUSrI1NJ6My2I5qdbFs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=t5iGT69JZtLCDVFHDEd8TJ8ttR8uh6tlYAODpp+nv7r8AT3DEEiDVDtpsPA+iT7/b
 V7SSNU7BtthYViGr2DVUy/bLM9ZfXFZJRzMmqaxiheM+gEAQiafzAmWODB/789AytM
 IL23xeIVq2VWnItgFBmnbUd5CaC140HLoNjuk/PfALNoHoOAz5qCMfeouhBEUY8PUk
 +xQNSOMrRYnELbNjTj3T/wBiFtQK41GFq/Fg8vxycacXT5HBDTsm7uawyCiFPuAUIs
 GAMIwh2yDRSrKwwoa5eMJMl2RLMNrDyP/uBHYcUK+4cAKZtbLfwv6mYEugUox4CpgI
 +E2lNDW+9FPEw==
Date: Thu, 28 Mar 2024 13:52:28 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Marek Vasut <marex@denx.de>, Stefano Babic
 <sbabic@denx.de>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328135228.000c1e0d@wsk>
In-Reply-To: <CAOMZO5CKc_CGgzu3Xhba-FKN1svJt9V2if6yv3_sP7cjA-rPHg@mail.gmail.com>
References: <20240328102049.10108d5b@wsk>
 <CAOMZO5CKc_CGgzu3Xhba-FKN1svJt9V2if6yv3_sP7cjA-rPHg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FfbUPr/YVShKCGYM_hv6dXT";
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

--Sig_/FfbUPr/YVShKCGYM_hv6dXT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Mar 28, 2024 at 6:20=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
> >
> > Dear Community,
> >
> > I'd like to share with you some thoughts about growth of u-boot's
> > binary size for SPL and u-boot proper.
> >
> > Board: XEA
> > SoC  : imx287 (still in active production)
> > Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).
> >          Board design constraints u-boot proper size to less than
> > ~448 KiB
> >
> >
> > When XEA was added (2019.07):
> >         - u-boot.sb (SPL): 37 KiB
> >         - u-boot.img     : 401 KiB
> >
> > Now (2024.04):
> >         - u-boot.sb (SPL): 40 KiB
> >         - u-boot.img     : 427 KiB
> >
> > (With a _lot_ of effort put to reduce the size)
> >
> > Hence, the question - would it be possible to take more concern
> > about the binary size growth?
> >
> > Maybe CI could catch patches, which enable by default some features
> > and the size is unintentionally increased?
> >
> > I'm open for any feedback and thoughts on "stopping" the binary size
> > increase. =20
>=20
> In addition to adding CONFIG_BOARD_SIZE_LIMIT and
> CONFIG_SPL_SIZE_LIMIT checks, could you try the change below?
>=20
> diff --git a/arch/arm/mach-imx/mxs/Kconfig
> b/arch/arm/mach-imx/mxs/Kconfig index d2e4205c5ce5..ee8c23d0e04f
> 100644 --- a/arch/arm/mach-imx/mxs/Kconfig
> +++ b/arch/arm/mach-imx/mxs/Kconfig
> @@ -32,6 +32,7 @@ if ARCH_MX28
>=20
>  config MX28
>         bool
> +       select LTO
>         default y
>=20
> I did a quick imx28_xea_defconfig build test here:
>=20
> U-Boot mainline
> ---------------
>=20
> $ ls -al u-boot.img
> -rw-rw-r-- 1 fabio fabio 444128 mar 28 09:11 u-boot.img
>=20
> $ ls -al spl/u-boot-spl.bin
> -rwxrwxr-x 1 fabio fabio 39800 mar 28 09:12 spl/u-boot-spl.bin
>=20
>=20
> U-Boot mainline + LTO
> ---------------------
>=20
> $ ls -al u-boot.img
> -rw-rw-r-- 1 fabio fabio 424144 mar 28 09:14 u-boot.img
>=20
> $ ls -al spl/u-boot-spl.bin
> -rw-rw-r-- 1 fabio fabio 37664 mar 28 09:14 spl/u-boot-spl.bin

Thanks for the tip - I will check if enabling LTO is not causing any
regressions.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/FfbUPr/YVShKCGYM_hv6dXT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFaAwACgkQAR8vZIA0
zr3vwwf/RTNveF/Qy4GhpBmMKU2S35R4fElyrP0qLBPD6PYnivKvY2iOcNr6DW2s
iBvJKnbEPoda3O+fH1tajqq716uat02WcmsxVGFkg60dMu7Wub4lHM0j3+Pinm47
hEAagHypP9MH+O/DPbIauTD1zbkdcs4CT5/cpDFJwuQd1KfYz/BgSQq0QEbZZz4u
CX7Orfj8xGa1Ox2KrSR3gIuZOREcdgZ1DSXscnLPymhtGEoZm+YVC+EVC77wYSCT
MvYCrsA8nyY7OeZnGx0vEpKSuI3UUlxvJrxgVx5vZLxpM4iNr4+fZFYyRkaY6IEU
Zxle8wXgGz+jqlNMBLNwQyJ2SAEtSQ==
=shc4
-----END PGP SIGNATURE-----

--Sig_/FfbUPr/YVShKCGYM_hv6dXT--
