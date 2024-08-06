Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0EE6C52D6D
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 08:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D92A2889EE;
	Tue,  6 Aug 2024 10:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722931687;
	bh=7K6aGWqsiroKafNTkZVrDv5RrgsxtaioyrpFbjGxzcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBuZ9zrud/pPG2qvFEcSowgScCvW8gYCB4SHvU+AaAX/d9aVBQK7tM2zZNouYk1a7
	 hXTVjR3aPXbKvrcz7HCJvWmkWn9N7AS5DbhWBv0BltsJriYLIOxAr/XZ1OYMIAQoyj
	 RrNvGoeL8IOwMeYcZN5NITsNAE3QxUmtDBPvmUnPw6nJDDLSYf0nhERBCpdtUEMkSL
	 a91vjyqYSLCsr+PdLnJ1sIDAbEscl86/HUnITigtWRY+P8adEXNeBEQer4Lhm/tiS1
	 N2FI1LU+J2rVcNwIyT9RpYLIeErHEKUYwcYP5pV5jyP45qVDEgS/hPCM0EWydpWOvX
	 HVm2BNOPqGEew==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AB04D8811A;
 Tue,  6 Aug 2024 10:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722931687;
 bh=7K6aGWqsiroKafNTkZVrDv5RrgsxtaioyrpFbjGxzcM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gjdCMj0kt2cB90mYq2Wwkea6NS0ZAJxdehF6M8IdghsYywys9WM601xhKM698s8lq
 h87LjETM2tDlrSJzdEn19r27jzL/UR+0i4TJb5L8JrEjw13+ltNH2f9JldBLC15vv8
 YHO/nmq6AowHuw/orgsAEfXH+Y4dQin3Gh6WdgnlaktWGx/zOD50ujYGR8Cy9ZKXya
 Z/sPonhDyaYB/PM5J5czIOJidNR5VmHZwIb9ayveE8QCCldhHiqs5wqzNwDOecu+Sx
 /dvfMpzXsNdjITBEmXLFsBUobMWfxxqoScyA3ozkrqzWvM3n6gZdW13PS02SjR2/bk
 yw+s8r8I0v3wg==
Date: Tue, 6 Aug 2024 10:08:05 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, u-boot@lists.denx.de, Tom Rini
 <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Cem Tenruh
 <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>, Simon
 Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Message-ID: <20240806100805.38f61c38@wsk>
In-Reply-To: <CAOMZO5B6F3LZcs=eYpZwOmDGctRqrnJDby2hH_343vczpk_uJQ@mail.gmail.com>
References: <20240805084202.3530203-1-lukma@denx.de>
 <CAOMZO5B6F3LZcs=eYpZwOmDGctRqrnJDby2hH_343vczpk_uJQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qzqaFRieY9QjEitjFk+ZgD1";
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

--Sig_/qzqaFRieY9QjEitjFk+ZgD1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Aug 5, 2024 at 5:42=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>=20
> > +       "update_offset=3D0x42\0" \
> > +       "update_filename=3Dflash.bin\0" \
> > +       "hostname=3D/srv/tftp/\0" \
> > +       "update_bootimg=3D"
> >     \
> > +               "mmc dev ${mmcdev} ; "          \
> > +               "if dhcp ${loadaddr} ${hostname}/${update_filename}
> > ; then "    \
> > +               "setexpr fw_sz ${filesize} / 0x200 ; "  /* SD block
> > size */ \
> > +               "setexpr fw_sz ${fw_sz} + 1 ; " =20
>=20
> As Benjamin pointed out earlier this increment by one is not
> necessary.
>=20
> All other i.MX8M docs don't have this increment.

So apparently the BSP build scripts in OE/Yocto take always care to
have 0x200 aligned binaries (imx-boot and flash.bin).

OK, I will remove it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/qzqaFRieY9QjEitjFk+ZgD1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmax2eUACgkQAR8vZIA0
zr0NHAf/Rqpj1KD9s+YVi47IFM5YXLB2Orz7372ZFCR7tsUSDzN81wT8/YldAeFm
GDYAB/yztjcg9K7VXHGnr5AM07IFf7l9Lqg46OWx4gVbzjtnJi5sga6wrEfG2rjj
77BO46NyA0CYm5V+Qw0RT9qpDkdI0IceLcD8q4Y4pP/CTxsTnRImjMBykBFI8z+n
mx1GHh+tzOUqv+UhhAVFEzNwPNJj63zEadUM/MxjwYHqPu1fTMgqm5z8xQfAwreJ
tZ0XwCF1CbpBexK5QInqT/qDgyRENopXjB1+AEeCPgOwxSDhIhBoSQ/xiSX+Keq4
jt29S6drLc3TvuL2Ep6dE5lsQbRuLw==
=C7cx
-----END PGP SIGNATURE-----

--Sig_/qzqaFRieY9QjEitjFk+ZgD1--
