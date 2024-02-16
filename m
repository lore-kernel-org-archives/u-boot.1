Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15153C48BEB
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 10:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE8B87D66;
	Fri, 16 Feb 2024 11:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 725D187D66; Fri, 16 Feb 2024 11:10:43 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 79ABD87C5D
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 11:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705330800"; 
 d="asc'?scan'208";a="198083126"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Feb 2024 19:10:22 +0900
Received: from [10.226.93.96] (unknown [10.226.93.96])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6D2EE4209FB8;
 Fri, 16 Feb 2024 19:10:21 +0900 (JST)
Message-ID: <626503f4-8109-44d1-b3c7-8e32e7b33f30@bp.renesas.com>
Date: Fri, 16 Feb 2024 10:10:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
Content-Language: en-GB
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <20240215211025.690964-2-trini@konsulko.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jWmkL4iT0XFaoqxlbrPkwnsF"
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
--------------jWmkL4iT0XFaoqxlbrPkwnsF
Content-Type: multipart/mixed; boundary="------------5DdZbvRO2lBQAdfgNvblcDLP";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Message-ID: <626503f4-8109-44d1-b3c7-8e32e7b33f30@bp.renesas.com>
Subject: Re: [PATCH 2/2] doc: Rework the gcc section to reflect general build
 instructions
References: <20240215211025.690964-1-trini@konsulko.com>
 <20240215211025.690964-2-trini@konsulko.com>
In-Reply-To: <20240215211025.690964-2-trini@konsulko.com>

--------------5DdZbvRO2lBQAdfgNvblcDLP
Content-Type: multipart/mixed; boundary="------------uBN2TP9b5ykSaDPSiXvI0vti"

--------------uBN2TP9b5ykSaDPSiXvI0vti
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 15/02/2024 21:10, Tom Rini wrote:
> The first big issue is that the "gcc" file talked a lot about the
> general build requirements as well, but was titled in a gcc-centric
> manner. Solve this by renaming the file to compile.rst and more fully
> reflecting that it is general build instructions. Next, add a section
> about the prebuilt toolchains that are recommended (as they are the one=
s
> we use in CI), and update a few places to reference these vendor-neutra=
l
> tools.
>=20
> Next, we can include the reproducible builds section directly in the
> compile instructions rather than as a small standalone file.
>=20
> Finally, we update the sandbox document to reflect both the name change=

> as well as what is specifically required to build sandbox.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  doc/arch/sandbox/sandbox.rst       |  5 ++-
>  doc/build/{gcc.rst =3D> compile.rst} | 64 ++++++++++++++++++++++++++--=
--
>  doc/build/index.rst                |  3 +-
>  doc/build/reproducible.rst         | 27 -------------
>  4 files changed, 61 insertions(+), 38 deletions(-)
>  rename doc/build/{gcc.rst =3D> compile.rst} (73%)
>  delete mode 100644 doc/build/reproducible.rst
>=20
> diff --git a/doc/arch/sandbox/sandbox.rst b/doc/arch/sandbox/sandbox.rs=
t
> index 5f8db126657f..f2ed5a25c115 100644
> --- a/doc/arch/sandbox/sandbox.rst
> +++ b/doc/arch/sandbox/sandbox.rst
> @@ -39,11 +39,12 @@ integers can only be built on 64-bit hosts.
> =20
>  Note that standalone/API support is not available at present.
> =20
> -
>  Prerequisites
>  -------------
> =20
> -Install the dependencies noted in :doc:`../../build/gcc`.
> +In addition to the normal dependencies shows in the :doc:`general buil=
d
> +instructions <../../build/compile>` to enable display support SDL2 lib=
raries
> +need to be available.

I find this a little unclear. Perhaps:

To enable display support, SDL2 libraries need to be available in
addition to the normal dependencies shown in the :doc:`general build
instructions <../../build/compile>`.

> =20
> =20
>  Basic Operation
> diff --git a/doc/build/gcc.rst b/doc/build/compile.rst
> similarity index 73%
> rename from doc/build/gcc.rst
> rename to doc/build/compile.rst
> index 3c6465772729..ef9c8545835a 100644
> --- a/doc/build/gcc.rst
> +++ b/doc/build/compile.rst
> @@ -1,11 +1,19 @@
> -Building with GCC
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Building U-Boot
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  Dependencies
>  ------------
> =20
> -For building U-Boot you need a GCC compiler for your host platform. If=
 you
> -are not building on the target platform you further need  a GCC cross =
compiler.
> +For building U-Boot you need the general build tools such as `make` an=
d a C
> +compiler for your host platform. Next, if you are not building on the =
same
> +architecture as the target platform you further need a C cross compile=
r.
> +Furthermore, some target platforms require additional host tools to be=
 present
> +and their package names may vary slightly dependinng on the naming sch=
eme used

s/dependinng/depending/

Thanks,

--=20
Paul Barker
--------------uBN2TP9b5ykSaDPSiXvI0vti
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------uBN2TP9b5ykSaDPSiXvI0vti--

--------------5DdZbvRO2lBQAdfgNvblcDLP--

--------------jWmkL4iT0XFaoqxlbrPkwnsF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZc80jAUDAAAAAAAKCRDbaV4Vf/JGvVwj
AQCMXPUmBixDsnttGtBlncMSdVvkUssQC2KfbA9yfg2uNwEA7w+hLBsuKQcVkPkh0ZpqeXjfjg2U
iBJnaMVc8PeTcQc=
=hK2R
-----END PGP SIGNATURE-----

--------------jWmkL4iT0XFaoqxlbrPkwnsF--
