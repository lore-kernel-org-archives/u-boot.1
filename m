Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C064BC5472D
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B39C88A75;
	Wed, 28 Aug 2024 09:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724831722;
	bh=tNUzVa3nCpXcQEIemC8mIbDGkTHVT+CJvaT0Mjkq7kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fl4CYDYFrp2Orp6D0lWqLqIRPfMRJw9vlFxjxy51+vW2JgU4xmpc9040rPKcoOKvH
	 DOdAzI3YDW4qm1uMYACsEgMY28snDsMtpVFDLs5C4bSIXb4LIkrhJnGhyYkdGAwonv
	 1coVKK0v7ZrUm5RW9mW47k3x6kdgwR0mA1IRARPDZvyTEIdgFJ+O+e2Oo58zrXWzJS
	 weOFQhf1mYpnjEmNlC4vMg/Pihn4sAFlnIwVapvgNGum1b2zIH1WD4VF9l8pb79mDj
	 eFMhRet5o42KLBfFUxuqze1V/fgo2IFw4zQrPZ0nAng69Ba0hE/vtXuPhG7hi3o7qs
	 asaJUc7OS4EKg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 43006888C1;
 Wed, 28 Aug 2024 09:55:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724831721;
 bh=tNUzVa3nCpXcQEIemC8mIbDGkTHVT+CJvaT0Mjkq7kw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=A6wK2iU2Gcjs0QOGeTsHwOHMk5f5vPbQ9v33InqSWiFrcglKjNQz12bflYYvs/oxZ
 hAH/l+/sSEpWvG6S3MEJvoMMDGsJVGh2fJshRvd+6+0pCJAVTCMRNcC46zeSdFFjuB
 PviZRsqpuDlPNKHSH1lyK+oYGPpr9i/caPO0+L1A9OSUlFIZL/69bLiBhERx/BPsBK
 lz3R3LaVdC1x203y//0C8WL6Q9jz6xksEEIKd/l8FubUpXsbD6aAheTeYIrmb+MEbD
 Ok51AEtGqAvl5ojvcJLVOE3PkY8uNZ4KtYsNiVRTTDSkdZj/DUZvdAMzSMDHAoeSHS
 ND6JQettfVXXQ==
Date: Wed, 28 Aug 2024 09:55:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com, Cem Tenruh <c.tenruh@phytec.de>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de, Yannic Moog <y.moog@phytec.de>,
 Benjamin Hahn <B.Hahn@phytec.de>
Subject: Re: [PATCH v2] config: imx: Define CFG_SYS_UBOOT_BASE for Phytec's
 imx8mm SoM QSPI boot
Message-ID: <20240828095520.76f904bc@wsk>
In-Reply-To: <CAOMZO5AAfn7zw1+VEGjdS6UAQLv5kTVT97_dy_oxhauntYeHvQ@mail.gmail.com>
References: <20240820145944.3048128-1-lukma@denx.de>
 <CAOMZO5AAfn7zw1+VEGjdS6UAQLv5kTVT97_dy_oxhauntYeHvQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c/mMK8Iv2l8MJ9tWZoCllNb";
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

--Sig_/c/mMK8Iv2l8MJ9tWZoCllNb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Tue, Aug 20, 2024 at 12:00=E2=80=AFPM Lukasz Majewski <lukma@denx.de>
> wrote:
> >
> > The image offset when booting from SPI-NOR (QSPI, FSPI driver) is
> > different than one for SD card / eMMC as extra space (0x1000) is
> > consumed by FSPI configuration header (CONFIG_FSPI_CONF_HEADER).
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Avoid line breaks with defines =20
>=20
> From the other thread, my understanding is that QSPI boot is still not
> working with this patch applied.
>=20

But this is an orthogonal problem - the problem is with binman image
generation.

This patch follows the code already present in e.g. imx8mm_beacon*
boards.

> Please resend this patch when the QSPI boot problem is resolved.
>=20

As I've written above - problem is solely with binman code generation -
after reverting 3 last commits from imx8mm-u-boot.dtsi the image is
correctly generated.

> Thanks




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/c/mMK8Iv2l8MJ9tWZoCllNb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmbO1+gACgkQAR8vZIA0
zr3n9Qf/e+P5m/KYRHK4XVqIiyVhQdACWJeboJ2+tz4bbiTrA20TBEnpGEiCYDC9
3SGvoYOoLvn8VM/Ta5v9MUpF6rblP9LAz5m+h/H02z5Hu3t/jrWkOCeKpS/Qd3P1
DLQ3zDyDwiNXD6W2AGE5HKjY6WZm/IIqAYKVNpGzLKwyn0nzPZKG70JMPnw+UNTB
rMpIyQ/AnivA/3ZvpsU7+jpDzBYtX/6RJHHmeHoJtFhucZv/zumM8tpkSRduPp4j
i7yS26YrXmyFqGQfRJXRTNHR5ppG5C5Dw5eT6BNHDaj9uuwnMMObI6BXkDMYE/NF
7cP0YYn0oGN6TTlWrof08RuSJltfmw==
=sqfO
-----END PGP SIGNATURE-----

--Sig_/c/mMK8Iv2l8MJ9tWZoCllNb--
