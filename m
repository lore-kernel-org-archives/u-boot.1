Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C62C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 07:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865A687D6F;
	Tue, 20 Feb 2024 08:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5969587D69; Tue, 20 Feb 2024 08:50:57 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 6AEC287D74
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 08:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,172,1705330800"; 
 d="asc'?scan'208";a="194554937"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 20 Feb 2024 16:50:45 +0900
Received: from [10.226.93.3] (unknown [10.226.93.3])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8C1B941D2F53;
 Tue, 20 Feb 2024 16:50:43 +0900 (JST)
Message-ID: <edaa1b92-da79-4990-a0f6-3d499b408b82@bp.renesas.com>
Date: Tue, 20 Feb 2024 07:50:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] i2c: rzg2l: Add I2C driver for RZ/G2L family
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Heiko Schocher <hs@denx.de>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
 <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
 <20231119204853.bmg4ghuo625c3zkm@GBR-5CG2373LKG.adwin.renesas.com>
 <faee5984-fb92-46f0-a9b7-17f57eddbee5@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Organization: Renesas Electronics Corporation
In-Reply-To: <faee5984-fb92-46f0-a9b7-17f57eddbee5@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AMMhlsxoh2CgEg3rpM9HafSJ"
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
--------------AMMhlsxoh2CgEg3rpM9HafSJ
Content-Type: multipart/mixed; boundary="------------w6Q5A2HROoxkMINqrU0SpXHJ";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Heiko Schocher <hs@denx.de>
Message-ID: <edaa1b92-da79-4990-a0f6-3d499b408b82@bp.renesas.com>
Subject: Re: [PATCH 3/5] i2c: rzg2l: Add I2C driver for RZ/G2L family
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
 <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
 <20231119204853.bmg4ghuo625c3zkm@GBR-5CG2373LKG.adwin.renesas.com>
 <faee5984-fb92-46f0-a9b7-17f57eddbee5@mailbox.org>
In-Reply-To: <faee5984-fb92-46f0-a9b7-17f57eddbee5@mailbox.org>

--------------w6Q5A2HROoxkMINqrU0SpXHJ
Content-Type: multipart/mixed; boundary="------------wjBtPhcM8G6BmwJgD22TsT05"

--------------wjBtPhcM8G6BmwJgD22TsT05
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02/12/2023 18:18, Marek Vasut wrote:
> On 11/19/23 21:48, Paul Barker wrote:
>> On Sun, Nov 19, 2023 at 09:15:36PM +0100, Marek Vasut wrote:
>>> On 11/15/23 18:40, Paul Barker wrote:
>>>> This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044=
)
>>>> SoC, also known as the RIIC module.
>>>>
>>>> This patch is based on both the u-boot driver in the Renesas RZ BSP
>>>> 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.6 driver
>>>> (commit ffc253263a13).
>>>>
>>>> Support for deblocking the I2C bus is included as this may be needed=

>>>> after triggering a reset via the Power Management IC (PMIC) over I2C=

>>>> (the PMIC asserts the reset line before the SoC completes the I2C wr=
ite
>>>> transaction with obvious bus locking effects). If the SDA line is
>>>> observed to be low during initialisation, we automatically attempt t=
o
>>>> deblock.
>>>>
>>>> [1]: https://github.com/renesas-rz/renesas-u-boot-cip
>>>>
>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>
>>> The driver seems very similar to drivers/i2c/rcar_iic.c , can there b=
e some
>>> code reuse ?
>>
>> My initial idea was to extend the R-Car iic driver but I quickly saw
>> that would be very messy. All the registers and bits are in different
>> places, the calculations are different (particularly in regard to
>> setting bus speed) and the read/write process has more edge cases for
>> the RZ/G2L. The bus recovery mechanism we use also doesn't exist on
>> previous R-Car SoCs.
>>
>> The Linux drivers for these modules are also separate, see
>> drivers/i2c/busses/i2c-sh_mobile.c (for R-Car and earlier SoCs) and
>> drivers/i2c/busses/i2c-riic.c (for RZ/G2L) in the Linux kernel.
>=20
> Ah, I thought some of the registers were the same, but indeed the RZG=20
> core is much more extensive.
>=20
> You should either use devm_clk_*() in probe() or implement .remove=20
> callback. With that fixed:
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>=20
> And sorry for the delayed reply.

Here's an even more delayed reply from me! I've been busy on other work
but getting back to u-boot now.

Using devm_clk_get() in the probe function for this driver doesn't seem
to be needed. The `struct clk` is stored in a `struct riic_priv`, this
is allocated and freed automatically for each device as we set
`priv_auto` in the driver definition.

Thanks,

--=20
Paul Barker
--------------wjBtPhcM8G6BmwJgD22TsT05
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

--------------wjBtPhcM8G6BmwJgD22TsT05--

--------------w6Q5A2HROoxkMINqrU0SpXHJ--

--------------AMMhlsxoh2CgEg3rpM9HafSJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZdRZzgUDAAAAAAAKCRDbaV4Vf/JGvYQ8
AP4/hNlpWS1UV1vJCG7ThLno5ocygeqaOR2Y3VQxfXhC2wEArLc2yiJosTfwNUZYzPOEb4qeHhPP
2H+9dAMaC5mhBAM=
=uXHv
-----END PGP SIGNATURE-----

--------------AMMhlsxoh2CgEg3rpM9HafSJ--
