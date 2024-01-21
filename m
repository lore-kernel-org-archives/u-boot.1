Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA301C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 20:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C95E877EC;
	Sun, 21 Jan 2024 21:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF168785C; Sun, 21 Jan 2024 21:54:33 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 2B62F87705
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 21:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.05,210,1701097200"; 
 d="asc'?scan'208";a="195104576"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Jan 2024 05:54:29 +0900
Received: from [10.226.92.38] (unknown [10.226.92.38])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7E8AA4012D35;
 Mon, 22 Jan 2024 05:54:28 +0900 (JST)
Message-ID: <2f2f40cb-4c04-41de-ad72-01c651b268f9@bp.renesas.com>
Date: Sun, 21 Jan 2024 20:54:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] ARM: renesas: Add R8A779H0 V4M Kconfig entry and
 PRR ID
Content-Language: en-GB
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-7-marek.vasut+renesas@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20240121174340.279465-7-marek.vasut+renesas@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OgRpCVI05GIa4Qvsbj0foQJq"
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
--------------OgRpCVI05GIa4Qvsbj0foQJq
Content-Type: multipart/mixed; boundary="------------aPeFFYJDXW8gfGAkFnQitrGT";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>
Message-ID: <2f2f40cb-4c04-41de-ad72-01c651b268f9@bp.renesas.com>
Subject: Re: [PATCH 07/11] ARM: renesas: Add R8A779H0 V4M Kconfig entry and
 PRR ID
References: <20240121174340.279465-1-marek.vasut+renesas@mailbox.org>
 <20240121174340.279465-7-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240121174340.279465-7-marek.vasut+renesas@mailbox.org>

--------------aPeFFYJDXW8gfGAkFnQitrGT
Content-Type: multipart/mixed; boundary="------------tIubTh4BUkOTKRFlK0vkQPDJ"

--------------tIubTh4BUkOTKRFlK0vkQPDJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 21/01/2024 17:41, Marek Vasut wrote:
> From: Hai Pham <hai.pham.ud@renesas.com>
>=20
> Add Kconfig entry and PRR ID to support R8A779H0 V4M SoC.
>=20
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> ---
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  arch/arm/mach-rmobile/Kconfig.rcar4          | 6 ++++++
>  arch/arm/mach-rmobile/cpu_info.c             | 1 +
>  arch/arm/mach-rmobile/include/mach/rmobile.h | 1 +
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/arch/arm/mach-rmobile/Kconfig.rcar4 b/arch/arm/mach-rmobil=
e/Kconfig.rcar4
> index d4f93c89cac..3c8d683974c 100644
> --- a/arch/arm/mach-rmobile/Kconfig.rcar4
> +++ b/arch/arm/mach-rmobile/Kconfig.rcar4
> @@ -20,6 +20,12 @@ config R8A779G0
>  	imply CLK_R8A779G0
>  	imply PINCTRL_PFC_R8A779G0
> =20
> +config R8A779H0
> +	bool "Renesas SoC R8A779H0"
> +	select GICV3
> +	imply CLK_R8A779H0
> +	imply PINCTRL_PFC_R8A779H0
> +
>  endmenu
> =20
>  choice
> diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/c=
pu_info.c
> index 895c0f5336b..3d5d5ba79a9 100644
> --- a/arch/arm/mach-rmobile/cpu_info.c
> +++ b/arch/arm/mach-rmobile/cpu_info.c
> @@ -78,6 +78,7 @@ static const struct {
>  	{ RMOBILE_CPU_TYPE_R8A779A0, "R8A779A0" },
>  	{ RMOBILE_CPU_TYPE_R8A779F0, "R8A779F0" },
>  	{ RMOBILE_CPU_TYPE_R8A779G0, "R8A779G0" },
> +	{ RMOBILE_CPU_TYPE_R8A779H0, "R8A779H0" },
>  	{ 0x0, "CPU" },
>  };
> =20
> diff --git a/arch/arm/mach-rmobile/include/mach/rmobile.h b/arch/arm/ma=
ch-rmobile/include/mach/rmobile.h
> index 88b8b78671b..f0216210ba9 100644
> --- a/arch/arm/mach-rmobile/include/mach/rmobile.h
> +++ b/arch/arm/mach-rmobile/include/mach/rmobile.h
> @@ -43,6 +43,7 @@
>  #define RMOBILE_CPU_TYPE_R8A779A0	0x59
>  #define RMOBILE_CPU_TYPE_R8A779F0	0x5A
>  #define RMOBILE_CPU_TYPE_R8A779G0	0x5C
> +#define RMOBILE_CPU_TYPE_R8A779H0	0x5D
>  #define RMOBILE_CPU_TYPE_R9A07G044L	0x9A070440
> =20
>  #ifndef __ASSEMBLY__

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
--------------tIubTh4BUkOTKRFlK0vkQPDJ
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBGS4BNsBEADEc28TO+aryCgRIuhxWAviuJl+f2TcZ1JeeaMzRLgSXKuXzkiI
g6JIVfNvThjwJaBmb7+/5+D7kDLJuutu9MFfOzTS0QOQWppwIPgbfktvMvwwsq3m
7e9Qb+S1LVeV0/ldZfuzgzAzHFDwmzryfIyt2JEbsBsGTq/QE+7hvLAe8R9xofIn
z6/IndiiTYhNCNf06nFPR4Y5ZDZPGb9aw5Jisqh+OSxtc0BFHDSV8/35yWM/JLQ1
Ja8AOHw1kP9KO+iE9rHMt0+7lH3mN1GBabxH26EdgFfPShsi14qmziLOuUlGLuwO
ApIYqvdtCs+zlMA8PsiJIMuxizZ6qCLur3r2b+/YXoJjuFDcax9M+Pr0D7rZX0Hk
6PW3dtvDQHfspwLY0FIlXbbtCfCqGLe47VaS7lvG0XeMlo3dUEsf707Q2h0+G1tm
wyeuWSPEzZQq/KI7JIFlxr3N/3VCdGa9qVf/40QF0BXPfJdcwTEzmPlYetRgA11W
bglw8DxWBv24a2gWeUkwBWFScR3QV4FAwVjmlCqrkw9dy/JtrFf4pwDoqSFUcofB
95u6qlz/PC+ho9uvUo5uIwJyz3J5BIgfkMAPYcHNZZ5QrpI3mdwf66im1TOKKTuf
3Sz/GKc14qAIQhxuUWrgAKTexBJYJmzDT0Mj4ISjlr9K6VXrQwTuj2zC4QARAQAB
zStQYXVsIEJhcmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+wsGU
BBMBCgA+FiEE9KKf333+FIzPGaxOJ/SzRZ8AIlcFAmS4BNsCGwEFCQPCZwAFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AACgkQJ/SzRZ8AIlfxaQ/8CM36qjfad7eBfwja
cI1LlH1NwbSJ239rE0X7hU/5yra72egr3T5AUuYTt9ECNQ8Ld03BYhbC6hPki5rb
OlFM2hEPUQYeohcJ4Na5iIFpTxoIuC49Hp2ce6ikvt9Hc4O2FAntabg+9hE8WA4f
QWW+Qo5ve5OJ0sGylzu0mRZ2I3mTaDsxuDkXOICF5ggSdjT+rcd/pRVOugImjpZv
/jzSgUfKV2wcZ8vVK0616K21tyPiRjYtDQjJAKff8gBY6ZvP5REPl+fYNvZm1y4l
hsVupGHL3aV+BKooMsKRZIMTiKJCIy6YFKHOcgWFG62cuRrFDf4r54MJuUGzyeoF
1XNFzbe1ySoRfU/HrEuBNqC+1CEBiduumh89BitfDNh6ecWVLw24fjsF1Ke6vYpU
lK9/yGLV26lXYEN4uEJ9i6PjgJ+Q8fubizCVXVDPxmWSZIoJg8EspZ+Max03Lk3e
flWQ0E3l6/VHmsFgkvqhjNlzFRrj/k86IKdOi0FOd0xtKh1p34rQ8S/4uUN9XCVj
KtmyLfQgqPVEC6MKv7yFbextPoDUrFAzEgi4OBdqDJjPbdU9wUjONxuWJRrzRFcr
nTIG7oC4dae0p1rs5uTlaSIKpB2yulaJLKjnNstAj9G9Evf4SE2PKH4l4Jlo/Hu1
wOUqmCLRo3vFbn7xvfr1u0Z+oMTOOARkuAhwEgorBgEEAZdVAQUBAQdAcuNbK3VT
WrRYypisnnzLAguqvKX3Vc1OpNE4f8pOcgMDAQgHwsF2BBgBCgAgFiEE9KKf333+
FIzPGaxOJ/SzRZ8AIlcFAmS4CHACGwwACgkQJ/SzRZ8AIlc90BAAr0hmx8XU9KCj
g4nJqfavlmKUZetoX5RB9g3hkpDlvjdQZX6lenw3yUzPj53eoiDKzsM03Tak/KFU
FXGeq7UtPOfXMyIh5UZVdHQRxC4sIBMLKumBfC7LM6XeSegtaGEX8vSzjQICIbaI
roF2qVUOTMGal2mvcYEvmObC08bUZuMd4nxLnHGiej2t85+9F3Y7GAKsA25EXbbm
ziUg8IVXw3TojPNrNoQ3if2Z9NfKBhv0/s7x/3WhhIzOht+rAyZaaW+31btDrX4+
Y1XLAzg9DAfuqkL6knHDMd9tEuK6m2xCOAeZazXaNeOTjQ/XqCHmZ+691VhmAHCI
7Z7EBPh++TjEqn4ZH+4KPn6XD52+ruWXGbJP29zc+3bwQ+ZADfUaL3ADj69ySxzm
bO24USHBAg+BhZAZMBkbkygbTen/umT6tBxG91krqbKlDdc8mhGonBN6i+nz8qv1
6MdC5P1rDbo834rxNLvoFMSLCcpjoafiprl9qk0wQLq48WGphs9DX7V75ZAU5Lt6
yA+je8i799EZJsVlB933Gpj688H4csaZqEMBjq7vMvI+a5MnLCGcjwRhsUfogpRb
AWTx9ddVau4MJgEHzB7UU/VFyP2vku7XPj6mgSfSHyNVf2hqxwISQ8eZLoyxauOD
Y61QMX6YFL170ylToSFjH627h6TzlUDOMwRkuAiAFgkrBgEEAdpHDwEBB0Bibkmu
Sf7yECzrkBmjD6VGWNVxTdiqb2RuAfGFY9RjRsLB7QQYAQoAIBYhBPSin999/hSM
zxmsTif0s0WfACJXBQJkuAiAAhsCAIEJECf0s0WfACJXdiAEGRYIAB0WIQSiu8gv
1Xr0fIw/aoLbaV4Vf/JGvQUCZLgIgAAKCRDbaV4Vf/JGvZP9AQCwV06n3DZvuce3
/BtzG5zqUuf6Kp2Esgr2FrD4fKVbogD/ZHpXfi9ELdH/JTSVyujaTqhuxQ5B7UzV
CUIb1qbg1APIEA/+IaLJIBySehy8dHDZQXit/XQYeROQLTT9PvyM35rZVMGH6VG8
Zb23BPCJ3N0ISOtVdG402lSP0ilP/zSyQAbJN6F0o2tiPd558lPerFd/KpbCIp8N
kYaLlHWIDiN2AE3c6sfCiCPMtXOR7HCeQapGQBS/IMh1qYHffuzuEy7tbrMvjdra
VN9Rqtp7PSuRTbO3jAhm0Oe4lDCAK4zyZfjwiZGxnj9s1dyEbxYB2GhTOgkiX/96
Nw+m/ShaKqTM7o3pNUEs9J3oHeGZFCCaZBv97ctqrYhnNB4kzCxAaZ6K9HAAmcKe
WT2q4JdYzwB6vEeHnvxl7M0Dj9pUTMujW77Qh5IkUQLYZ2XQYnKAV2WI90B0R1p9
bXP+jqqkaNCrxKHV1tYOB6037CziGcZmiDneiTlM765MTLJLlHNqlXxDCzRwEazU
y9dNzITjVT0qhc6th8/vqN9dqvQaAGa13u86Gbv4XPYdE+5MXPM/fTgkKaPBYcIV
QMvLfoZxyaTk4nzNbBxwwEEHrvTcWDdWxGNtkWRZw0+U5JpXCOi9kBCtFrJ701UG
UFs56zWndQUS/2xDyGk8GObGBSRLCwsXsKsF6hSX5aKXHyrAAxEUEscRaAmzd6O3
ZyZGVsEsOuGCLkekUMF/5dwOhEDXrY42VR/ZxdDTY99dznQkwTt4o7FOmkY=3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------tIubTh4BUkOTKRFlK0vkQPDJ--

--------------aPeFFYJDXW8gfGAkFnQitrGT--

--------------OgRpCVI05GIa4Qvsbj0foQJq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZa2EgwUDAAAAAAAKCRDbaV4Vf/JGvTy6
AQDHeqXdlcWy2mJ42TwvGIhyWMJvpQPqywhVJh2STCvVuQEA/+HcoGI8TXJdEjIM6bit2TtNPojx
4E4KDQlox2N5FwU=
=BK8J
-----END PGP SIGNATURE-----

--------------OgRpCVI05GIa4Qvsbj0foQJq--
