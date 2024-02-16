Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D97CC48BEB
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 10:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FD087E32;
	Fri, 16 Feb 2024 11:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7AF087E3E; Fri, 16 Feb 2024 11:06:11 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 1C0A587C5D
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 11:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705330800"; 
 d="asc'?scan'208";a="194160559"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 16 Feb 2024 19:06:05 +0900
Received: from [10.226.93.96] (unknown [10.226.93.96])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8A82040062DC;
 Fri, 16 Feb 2024 19:06:04 +0900 (JST)
Message-ID: <016b8379-08aa-4e72-bcde-33b17c5a2d35@bp.renesas.com>
Date: Fri, 16 Feb 2024 10:06:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Update our clang documentation to reflect
 current status
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>
References: <20240215211025.690964-1-trini@konsulko.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240215211025.690964-1-trini@konsulko.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RKv9AQU2ZxfSmvdvnxd6Gfyw"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RKv9AQU2ZxfSmvdvnxd6Gfyw
Content-Type: multipart/mixed; boundary="------------gMQUbwgygAPY1hF0lLjaiHdO";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>
Message-ID: <016b8379-08aa-4e72-bcde-33b17c5a2d35@bp.renesas.com>
Subject: Re: [PATCH 1/2] doc: Update our clang documentation to reflect
 current status
References: <20240215211025.690964-1-trini@konsulko.com>
In-Reply-To: <20240215211025.690964-1-trini@konsulko.com>

--------------gMQUbwgygAPY1hF0lLjaiHdO
Content-Type: multipart/mixed; boundary="------------BUGTS3HiHT2LdAoOLl4OKFcY"

--------------BUGTS3HiHT2LdAoOLl4OKFcY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/02/2024 21:10, Tom Rini wrote:
> First, since this document was written the biggest challenges at the
> time are simply not applicable anymore. Second, we need to list the
> challenges which are preventing more platforms from being able to be
> built with Clang today.  Next, we update the general wording to be host=

> distribution agnostic. Finally, the section about xenguest_arm64 issues=

> is not present anymore.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Mark Kettenis <kettenis@openbsd.org>
> This does leave the FreeBSD section unchanged and should likely be
> looked at again by someone with a BSD build machine available.
> ---
>  doc/build/clang.rst | 85 +++++++++++----------------------------------=

>  1 file changed, 21 insertions(+), 64 deletions(-)
>=20
> diff --git a/doc/build/clang.rst b/doc/build/clang.rst
> index 09bb988e9236..d8c554982567 100644
> --- a/doc/build/clang.rst
> +++ b/doc/build/clang.rst
> @@ -1,34 +1,27 @@
>  Building with Clang
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The biggest problem when trying to compile U-Boot with Clang is that a=
lmost all
> -archs rely on storing gd in a global register and the Clang 3.5 user m=
anual
> -states: "Clang does not support global register variables; this is unl=
ikely to
> -be implemented soon because it requires additional LLVM backend suppor=
t."
> -
> -The ARM backend can be instructed not to use the r9 and x18 registers =
using
> --ffixed-r9 or -ffixed-x18 respectively. As global registers themselves=
 are not
> -supported inline assembly is needed to get and set the r9 or x18 value=
=2E This
> -leads to larger code then strictly necessary, but at least works.
> -
> -Debian based
> -------------
> -
> -Required packages can be installed via apt, e.g.
> -
> -.. code-block:: bash
> -
> -    sudo apt-get install clang
> -
> -We make use of the CROSS_COMPILE variable to derive the build target w=
hich is
> -passed as the --target parameter to clang.
> -
> -The CROSS_COMPILE variable further determines the paths to other build=

> -tools. As assembler we use the binary pointed to by '$(CROSS_COMPILE)a=
s'
> -instead of the LLVM integrated assembler (IAS).
> -
> -Here is an example demonstrating building U-Boot for the Raspberry Pi =
2
> -using clang:
> +In general terms, U-Boot support building with Clang as the C compiler=
 and

s/support/supports/

> +building and booting our "sandbox" target is part of CI.

Are you saying that building the sandbox target with Clang then booting
it is part of CI? I think this sentence needs re-wording to make it a
little clearer.

Thanks,

--=20
Paul Barker
--------------BUGTS3HiHT2LdAoOLl4OKFcY
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------BUGTS3HiHT2LdAoOLl4OKFcY--

--------------gMQUbwgygAPY1hF0lLjaiHdO--

--------------RKv9AQU2ZxfSmvdvnxd6Gfyw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZc8ziwUDAAAAAAAKCRDbaV4Vf/JGvYO5
AQDuZ/ytkgpsVBBP4+duNBcz4/QXFJMG7SKcFdcx9eZCQQEA+44Fm9h6oFDyexX0BgQXzYyWobpe
so47EAEgaZeqVwM=
=KFiZ
-----END PGP SIGNATURE-----

--------------RKv9AQU2ZxfSmvdvnxd6Gfyw--
