Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC9FC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 18:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6309B805E7;
	Tue,  4 Feb 2025 19:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E84807A8; Tue,  4 Feb 2025 19:33:15 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 5715D805A1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 19:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: s6kQ0cunS16a1C5h8GzazQ==
X-CSE-MsgGUID: r9pW3mp7R9KL+U4fbZi5fA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 05 Feb 2025 03:33:10 +0900
Received: from [10.24.1.103] (unknown [10.24.1.103])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id A4A17400D0C0;
 Wed,  5 Feb 2025 03:33:06 +0900 (JST)
Message-ID: <ef351602-0f6e-4400-ba33-1785c37915e0@bp.renesas.com>
Date: Tue, 4 Feb 2025 18:33:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: miiphybb: Convert ifdef DEBUG to debug()
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250118061629.125005-1-marek.vasut+renesas@mailbox.org>
 <c150ffbb-57a6-4aae-bfb0-1c680f13e816@bp.renesas.com>
 <8aa0fab5-5dea-4c08-9bd7-8f2f248ae4e0@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <8aa0fab5-5dea-4c08-9bd7-8f2f248ae4e0@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MJg5oA2NjOdT5iZbLpL9oj40"
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
--------------MJg5oA2NjOdT5iZbLpL9oj40
Content-Type: multipart/mixed; boundary="------------wzPpswR7eAkGQdu6Bh0vHKaQ";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Message-ID: <ef351602-0f6e-4400-ba33-1785c37915e0@bp.renesas.com>
Subject: Re: [PATCH] net: miiphybb: Convert ifdef DEBUG to debug()
References: <20250118061629.125005-1-marek.vasut+renesas@mailbox.org>
 <c150ffbb-57a6-4aae-bfb0-1c680f13e816@bp.renesas.com>
 <8aa0fab5-5dea-4c08-9bd7-8f2f248ae4e0@mailbox.org>
In-Reply-To: <8aa0fab5-5dea-4c08-9bd7-8f2f248ae4e0@mailbox.org>

--------------wzPpswR7eAkGQdu6Bh0vHKaQ
Content-Type: multipart/mixed; boundary="------------k0duLHZCyi97Upz26vooAcqp"

--------------k0duLHZCyi97Upz26vooAcqp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25/01/2025 12:30, Marek Vasut wrote:
> On 1/21/25 1:03 PM, Paul Barker wrote:
>> On 18/01/2025 06:16, Marek Vasut wrote:
>>> Replace ifdeffery with plain debug() function call. No functional cha=
nge.
>>>
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>> ---
>>> Cc: Adam Ford <aford173@gmail.com>
>>> Cc: Hai Pham <hai.pham.ud@renesas.com>
>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>> Cc: Jerome Forissier <jerome.forissier@linaro.org>
>>> Cc: Joe Hershberger <joe.hershberger@ni.com>
>>> Cc: Mario Six <mario.six@gdsys.cc>
>>> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>>> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>> Cc: Ramon Fried <rfried.dev@gmail.com>
>>> Cc: Sumit Garg <sumit.garg@linaro.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>   drivers/net/phy/miiphybb.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
>>> index 171c1719b5b..5497b838225 100644
>>> --- a/drivers/net/phy/miiphybb.c
>>> +++ b/drivers/net/phy/miiphybb.c
>>> @@ -183,9 +183,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int ad=
dr, int devad, int reg)
>>>   	bus->set_mdc(bus, 1);
>>>   	bus->delay(bus);
>>>  =20
>>> -#ifdef DEBUG
>>> -	printf("miiphy_read(0x%x) @ 0x%x =3D 0x%04x\n", reg, addr, rdreg);
>>> -#endif
>>> +	debug("miiphy_read(0x%x) @ 0x%x =3D 0x%04x\n", reg, addr, rdreg);
>>>  =20
>>>   	return rdreg;
>>>   }
>>
>> While we're here, can we include the bus name in the output to avoid
>> confusion when we have multiple buses? Maybe something like:
>>
>>      debug("miiphy_read(0x%x) @ %s:0x%x =3D 0x%04x\n", reg, bus->name,=
 addr, rdreg);
> No, not in this patch, but please test:
>=20
> [PATCH] net: miiphybb: Update debug() print
>=20
> Is it OK with you if I pick this patch for upcoming release ?

Yes please.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>

--=20
Paul Barker
--------------k0duLHZCyi97Upz26vooAcqp
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------k0duLHZCyi97Upz26vooAcqp--

--------------wzPpswR7eAkGQdu6Bh0vHKaQ--

--------------MJg5oA2NjOdT5iZbLpL9oj40
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ6JdYQUDAAAAAAAKCRDbaV4Vf/JGvQgb
AP9LoFr9W7WBPhCSsCYPqrB6y7JknVhJUA6uu2X29BdVPwD9GXxPhHZgbVIAs1TIRl2T/kHzRkXN
m5q1h9n/a1ENBwk=
=YKAW
-----END PGP SIGNATURE-----

--------------MJg5oA2NjOdT5iZbLpL9oj40--
