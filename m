Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3BEC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 12:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD70080374;
	Sat, 26 Aug 2023 14:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1962980295; Sat, 26 Aug 2023 14:03:54 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 5C427869CD
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 14:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.02,203,1688396400"; 
 d="asc'?scan'208";a="174036335"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 26 Aug 2023 21:03:43 +0900
Received: from [10.226.92.28] (unknown [10.226.92.28])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id AFF0B4008C74;
 Sat, 26 Aug 2023 21:03:41 +0900 (JST)
Message-ID: <66e5acee-fc2e-c169-ce26-8792d47d5626@bp.renesas.com>
Date: Sat, 26 Aug 2023 13:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF
 support
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
 <e6fc0067-b5bf-bbd0-57de-0f71d20d2e63@mailbox.org>
 <3aef873f-4ae7-edcc-c4a7-8a795a77802b@bp.renesas.com>
 <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UKQWuqjbZYfeXt1uBYEGUEMr"
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
--------------UKQWuqjbZYfeXt1uBYEGUEMr
Content-Type: multipart/mixed; boundary="------------HLZsvDpMZDkEyLAN2BmtS1Qn";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
Message-ID: <66e5acee-fc2e-c169-ce26-8792d47d5626@bp.renesas.com>
Subject: Re: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF
 support
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
 <e6fc0067-b5bf-bbd0-57de-0f71d20d2e63@mailbox.org>
 <3aef873f-4ae7-edcc-c4a7-8a795a77802b@bp.renesas.com>
 <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>
In-Reply-To: <0e1bbf84-eb5f-c462-7372-d813c3b1f813@mailbox.org>

--------------HLZsvDpMZDkEyLAN2BmtS1Qn
Content-Type: multipart/mixed; boundary="------------0XuMyJFeYx5qkC1R6Nr4q6u0"

--------------0XuMyJFeYx5qkC1R6Nr4q6u0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/08/2023 12:22, Marek Vasut wrote:
> On 8/23/23 08:25, Paul Barker wrote:
>> On 22/08/2023 22:38, Marek Vasut wrote:
>>> On 8/22/23 20:10, Paul Barker wrote:
>>>> If we attempt to compile serial_sh.c for a system which lacks HSCIF
>>>> support (e.g. R8A7740), we see the following compilation error:
>>>>
>>>>       In file included from drivers/serial/serial_sh.c:20:
>>>>       drivers/serial/serial_sh.c: In function =E2=80=98sh_serial_ini=
t_generic=E2=80=99:
>>>>       drivers/serial/serial_sh.h:429:35: warning: implicit declarati=
on of function =E2=80=98sci_HSSRR_out=E2=80=99; did you mean =E2=80=98sci=
_SCSCR_out=E2=80=99? [-Wimplicit-function-declaration]
>>>>         429 | #define sci_out(port, reg, value) sci_##reg##_out(port=
, value)
>>>>             |                                   ^~~~
>>>>       drivers/serial/serial_sh.c:62:17: note: in expansion of macro =
=E2=80=98sci_out=E2=80=99
>>>>          62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR=
_SRCYC8);
>>>>             |                 ^~~~~~~
>>>>
>>>> To fix this, only try to support access to the HSSRR register for So=
Cs
>>>> where it actually exists.
>>>>
>>>> Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
>>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>>>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> ---
>>>>    drivers/serial/serial_sh.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c=

>>>> index 20cda5dbe272..cd9bcf4f0a25 100644
>>>> --- a/drivers/serial/serial_sh.c
>>>> +++ b/drivers/serial/serial_sh.c
>>>> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_po=
rt *port)
>>>>    	sci_out(port, SCSPTR, 0x0003);
>>>>    #endif
>>>>   =20
>>>> +#if defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_GEN3) || defin=
ed(CONFIG_RCAR_GEN4)
>>>
>>> You can use CONFIG_RCAR_64 instead of GEN3+GEN4 test.
>>
>> I'm going to be sending patches for the RZ/G2L shortly which enables
>> CONFIG_RCAR_64 but lacks HSCIF support. Testing for RCAR gen3/gen4 now=

>> will avoid the need to make another change here.
>=20
> The G2L has no HSCIF ?

No, it has SCIF and SCI interfaces but no HSCIF.

Thanks,
Paul
--------------0XuMyJFeYx5qkC1R6Nr4q6u0
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------0XuMyJFeYx5qkC1R6Nr4q6u0--

--------------HLZsvDpMZDkEyLAN2BmtS1Qn--

--------------UKQWuqjbZYfeXt1uBYEGUEMr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZOnqHAUDAAAAAAAKCRDbaV4Vf/JGvY3H
AQDR3HR3T9JWQ3BgueGdn4/1u1JCnjy/A2mCkZgtt4yqvQD+LWkaW58gkQNlIa2csnw+krj5Jfjn
pgOi+AqKo4TDNQU=
=RoRA
-----END PGP SIGNATURE-----

--------------UKQWuqjbZYfeXt1uBYEGUEMr--
