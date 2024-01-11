Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FE3C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 11:53:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E409B87887;
	Thu, 11 Jan 2024 12:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704973980;
	bh=e5zJTsoU3bAQ+pMyxaYQ7iiZB2PAqAoBwtqgtQ0vWag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bflD34FSwmDxUI83q/QgA168BZ2mnURR6T3b/IiONZpS3Cz77AmSGRpA9sZRtulJW
	 qfUiIesyLmWrSa0RFd5b+T7eVyYmw76qtBP9XC8HagDlvIvGfE8QynT0PSQf7BSwU5
	 AJNimwz3NUCiRwgWzFxOaCY502NFDqUveiIIer98bN8+kFjBzw1loxjQAz/ZdRJQpC
	 jA+xAIWMg8tYma+9DFUQSM+Ej9N0U3iwbepYOQTyRC3+idik6lrB1w1rUKyfUPEUMg
	 9qpj+gq72PMO6AMMRNgGtpWiPjgM5jqv+5KiuDu7nqTJum793Jdr3Lhn8XH2KO1bk5
	 YfcwAMpzIWo8g==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3BE558786C;
 Thu, 11 Jan 2024 12:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704973979;
 bh=e5zJTsoU3bAQ+pMyxaYQ7iiZB2PAqAoBwtqgtQ0vWag=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eAPAcn00zVQMtME8xxurH7QB4RTqmYw0VCTqU1Fkn+0ToR+KjIYccJ3wvoioEptTC
 8P2MhgWiCuFnI+l6X2QoZdB8M+YsrHDUJDWoLRVvGROgfe51Fn8ZYbek6Uu8ei9hhu
 1wlE+VS7/dvPOi3XcsFfHSdk1iVZmblUwWciE6jv56Y9qzuNcy3RlLsl1IWGEJ35Ti
 gLD16eopu587b8U9SujtFI71PVrH1me80lIbanQBrHZZGr8ovaVnwnFzvJ//uPF/8d
 AUd51vU72oxccdyHriqEBJQFqK/6j4qx+WkE1ebj3c9l03ZTkUBZyrAWxbO7SceKKp
 a+/f5xF60Ob/w==
Date: Thu, 11 Jan 2024 12:52:58 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
Subject: Re: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
Message-ID: <20240111125258.0e617a50@wsk>
In-Reply-To: <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
References: <20240111110611.2051821-1-lukma@denx.de>
 <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uz9.09p7ugP/QmaUUtDkkQ5";
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

--Sig_/Uz9.09p7ugP/QmaUUtDkkQ5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Jan 11, 2024 at 8:06=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>=20
> > +serverip=3D10.8.217.79
> > +nfs_serverip=3D10.8.218.113
> > +gatewayip=3D10.8.209.250 =20
>=20
> These IP addresses should not be hardcoded here.
>=20
> They were not present in xea.h originally. Please remove them.

Those are the IP's for customer's production setup. In that way I could
just point to mainline SHA1 and just use the sources without any further
adjustments.

I can agree, that on "common devel board" (like e.g. beaglebone) it
would be problematic to have it hardcoded, but as this one is customer
specific HW ...

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Uz9.09p7ugP/QmaUUtDkkQ5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWf1poACgkQAR8vZIA0
zr17yAgAnNQf5YZGD7KuGJ7+Q5cJFmOB43DAOFtXbIAtC47xq+EiyMGF972TBQ7J
9tvF6Bt0QhoNK6bYaAmp8yBFYN7iIOGE0a3JHmLFF2KckMPa1cN1J+CGlkhGkRaT
30aTbesE1RFFPaqExRA1mvZw6KFvCJeBKmHQVrI0bHqbeWPvHdkSyqE30GprGvbJ
nQ/kLE9S+jwSMfApIRfGxlAc4fcWsU7S9lEiOeTHhCCpoFY0uQWJgYxZkhZZp5m3
JRSh8nbeSeymUqV/08S8Z/zQRcTJGBL8iB0w07YZy5RVy5olPBN/kbGHgAVp2UB+
PrDSDgwNNQCoMpC/TWv2OB23I6vBNQ==
=yfS5
-----END PGP SIGNATURE-----

--Sig_/Uz9.09p7ugP/QmaUUtDkkQ5--
