Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC713C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 22:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEF0E814B6;
	Thu, 27 Feb 2025 23:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90188166D; Thu, 27 Feb 2025 23:08:49 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 93DDE81426
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: WZ4At+B7QWWTOZH8pvJN3g==
X-CSE-MsgGUID: bviT/k+LQWiL1JpNbz2WgA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 07:08:44 +0900
Received: from [10.226.93.138] (unknown [10.226.93.138])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id BAF0840D6669;
 Fri, 28 Feb 2025 07:08:43 +0900 (JST)
Message-ID: <32fe6253-b228-4223-9916-cdcec5fc6a2c@bp.renesas.com>
Date: Thu, 27 Feb 2025 22:08:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: Introduce CONFIG_WERROR
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250227220031.789695-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-GB
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250227220031.789695-1-paul.barker.ct@bp.renesas.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RncOcKWsALiAqECKym0iBSAW"
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
--------------RncOcKWsALiAqECKym0iBSAW
Content-Type: multipart/mixed; boundary="------------760yPsBnjtZNIj8GlGlrXmfn";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Message-ID: <32fe6253-b228-4223-9916-cdcec5fc6a2c@bp.renesas.com>
Subject: Re: [PATCH] Kconfig: Introduce CONFIG_WERROR
References: <20250227220031.789695-1-paul.barker.ct@bp.renesas.com>
In-Reply-To: <20250227220031.789695-1-paul.barker.ct@bp.renesas.com>

--------------760yPsBnjtZNIj8GlGlrXmfn
Content-Type: multipart/mixed; boundary="------------Kmjk91KT1lSkZRC4XXEmpthG"

--------------Kmjk91KT1lSkZRC4XXEmpthG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/02/2025 22:00, Paul Barker wrote:
> Add a new config option under "General setup" to enable the -Werror fla=
g
> when building U-Boot. This is useful during development to help catch
> mistakes.
>=20
> This is based on a similar config option added to the Linux kernel by
> Linus in 2021 - see Linux commit 3fe617ccafd6 ("Enable '-Werror' by
> default for all kernel builds"). The modification of KBUILD_CFLAGS is
> done in Makefile.extrawarn, matching where it was moved in the kernel b=
y
> Linux commit e88ca24319e4 ("kbuild: consolidate warning flags in
> scripts/Makefile.extrawarn").
>=20
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  Kconfig                    | 11 +++++++++++
>  scripts/Makefile.extrawarn |  3 +++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/Kconfig b/Kconfig
> index 6379a4541664..4fbe65222952 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -27,6 +27,17 @@ config DEPRECATED
>  	  code that relies on deprecated features that will be removed and
>  	  the conversion deadline has passed.
> =20
> +config WERROR
> +	bool "Compile U-Boot with warnings as errors"
> +	help
> +	  A U-Boot build should not cause any compiler warnings, and this
> +	  enables the '-Werror' flag to enforce that rule.
> +
> +	  However, if you have a new (or very old) compiler or linker with od=
d
> +	  and unusual warnings, or you have some architecture with problems,
> +	  you may need to disable this config option in order to
> +	  successfully build the kernel.

I notice as soon as I send this.... s/kernel/U-Boot/ !

> +
>  config LOCALVERSION
>  	string "Local version - append to U-Boot release"
>  	help
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 7d39b27d24a9..f687515fc799 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -13,6 +13,9 @@
> =20
>  KBUILD_CFLAGS +=3D $(call cc-disable-warning, packed-not-aligned)
> =20
> +KBUILD_CPPFLAGS-$(CONFIG_WERROR) +=3D -Werror
> +KBUILD_CPPFLAGS +=3D $(KBUILD_CPPFLAGS-y)
> +
>  ifeq ("$(origin W)", "command line")
>    export KBUILD_ENABLE_EXTRA_GCC_CHECKS :=3D $(W)
>  endif

Thanks,

--=20
Paul Barker

--------------Kmjk91KT1lSkZRC4XXEmpthG
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------Kmjk91KT1lSkZRC4XXEmpthG--

--------------760yPsBnjtZNIj8GlGlrXmfn--

--------------RncOcKWsALiAqECKym0iBSAW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ8DiaQUDAAAAAAAKCRDbaV4Vf/JGvYvm
AQDgdaDUdVl+xyucj11xE1XjGXZ7TRNIeHLBGt7xx6EmKQEAgIXJ3yOAJi9B01yGuEHxA/zUoEPH
7b3rgEHaEOQYhAk=
=YVip
-----END PGP SIGNATURE-----

--------------RncOcKWsALiAqECKym0iBSAW--
