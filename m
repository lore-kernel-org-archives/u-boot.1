Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B88CC369B5
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 14:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C1E809A5;
	Tue, 15 Apr 2025 16:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2E382AC4; Tue, 15 Apr 2025 16:31:26 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id CFD6780944
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 16:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: jNctELgmSyamwpwCWKC4gw==
X-CSE-MsgGUID: dFODX7CoRkSatj4KsizD7g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2025 23:31:20 +0900
Received: from [10.226.92.203] (unknown [10.226.92.203])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8BB8540083E6;
 Tue, 15 Apr 2025 23:31:18 +0900 (JST)
Message-ID: <0a403469-e500-4054-a5d7-e0a3bf35cd56@bp.renesas.com>
Date: Tue, 15 Apr 2025 15:31:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
 <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
 <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zXOUD0KmK17RXUCGAhSpH0sX"
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
--------------zXOUD0KmK17RXUCGAhSpH0sX
Content-Type: multipart/mixed; boundary="------------jA80fLENvAKbRNWuRG0zOUvT";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <0a403469-e500-4054-a5d7-e0a3bf35cd56@bp.renesas.com>
Subject: Re: [PATCH v2 3/4] net: ravb: Add RZ/G2L Support
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
 <20250319120401.8297-4-paul.barker.ct@bp.renesas.com>
 <e075602c-3a08-424b-adbc-88dcafb6c1d6@mailbox.org>
 <b812bb48-8534-4164-a5ed-19764c38656c@bp.renesas.com>
 <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>
In-Reply-To: <64d123de-b1b3-4dcf-ba98-91ef5ecb6067@mailbox.org>

--------------jA80fLENvAKbRNWuRG0zOUvT
Content-Type: multipart/mixed; boundary="------------SUpIGM3DMbCTc74ZX1EPfnB0"

--------------SUpIGM3DMbCTc74ZX1EPfnB0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/03/2025 23:05, Marek Vasut wrote:
> On 3/24/25 11:12 AM, Paul Barker wrote:
>> On 24/03/2025 01:11, Marek Vasut wrote:
>>> On 3/19/25 1:03 PM, Paul Barker wrote:
>>>
>>> [...]
>>>
>>>> +++ b/drivers/net/Kconfig
>>>> @@ -864,7 +864,7 @@ config RENESAS_RAVB
>>>>    	select PHY_ETHERNET_ID
>>>>    	help
>>>>    	  This driver implements support for the Ethernet AVB block in
>>>> -	  Renesas M3 and H3 SoCs.
>>>> +	  several Renesas R-Car and RZ SoCs.
>>>
>>> RZ/G instead of RZ , right ?
>>
>> This will also be used for RZ/V2L.
>=20
> Ahh, thank you for clarifying.
>=20
> [...]
>=20
>>>> +static void ravb_mac_init_rzg2l(struct udevice *dev)
>>>> +{
>>>> +	struct ravb_priv *eth =3D dev_get_priv(dev);
>>>> +
>>>> +	setbits_32(eth->iobase + RAVB_REG_ECMR,
>>>> +		   ECMR_PRM | ECMR_RXF | ECMR_TXF | ECMR_RCPT |
>>>> +		   ECMR_TE | ECMR_RE | ECMR_RZPF |
>>>> +		   (eth->phydev->duplex ? ECMR_DM : 0));
>>>
>>> Can you configure the ECMR extras in ravb_config() just before
>>> writel(mask, eth->iobase + RAVB_REG_ECMR); based on some private data=

>>> flag, like '.is_rzg2l' , instead ?
>>
>> ravb_config() has been split into ravb_config_rcar() &
>> ravb_config_rzg2l() by this patch series. So there is no longer a comm=
on
>> write to RAVB_REG_ECMR.
>>
>>>
>>>> +}
>>>> +
>>>>    /* AVB-DMAC init function */
>>>>    static int ravb_dmac_init(struct udevice *dev)
>>>>    {
>>>> @@ -459,6 +481,14 @@ static void ravb_dmac_init_rcar(struct udevice =
*dev)
>>>>    	writel(mode, eth->iobase + RAVB_REG_APSR);
>>>>    }
>>>>   =20
>>>> +static void ravb_dmac_init_rzg2l(struct udevice *dev)
>>>> +{
>>>> +	struct ravb_priv *eth =3D dev_get_priv(dev);
>>>> +
>>>> +	/* Set Max Frame Length (RTC) */
>>>> +	writel(0x7ffc0000 | RFLR_RFL_MIN, eth->iobase + RAVB_REG_RTC);
>>>
>>> I assume this register is actually RZ/G2L specific ?
>>
>> This register also exists on RZ/G2{H,M,N,E}, but in the Linux kernel
>> ravb driver it is only modified for RZ/G2L.
>=20
> Is this deliberate or is that a bug ?

Hi Marek,

The RTC register exists in RZ/G2H family, R-Car Gen3 and R-Car Gen4. It
may also exist in R-Car Gen5, I don't have visibility into the Ethernet
registers for the Gen5 yet.

Given that Ethernet is working on those platforms where the RTC register
is present but is not modified by the driver, I've aimed to avoid any
potential change in behaviour by limiting this register modification to
the RZ/G2L.

Thanks,

--=20
Paul Barker
--------------SUpIGM3DMbCTc74ZX1EPfnB0
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

--------------SUpIGM3DMbCTc74ZX1EPfnB0--

--------------jA80fLENvAKbRNWuRG0zOUvT--

--------------zXOUD0KmK17RXUCGAhSpH0sX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ/5ttAUDAAAAAAAKCRDbaV4Vf/JGvS3p
AP950Gds1P7zhIGlChjfAxaCTCDdD4HmpYByfzT4MUAD4gD9HC3fqLfSRQ61stoHluVcxLNNA3f9
TRn1bdzgHJhAtwM=
=Rsxi
-----END PGP SIGNATURE-----

--------------zXOUD0KmK17RXUCGAhSpH0sX--
