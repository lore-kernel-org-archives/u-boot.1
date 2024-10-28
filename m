Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F296D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 08:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E58BE89079;
	Mon, 28 Oct 2024 09:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DC587CF8; Mon, 28 Oct 2024 09:47:40 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C5DF89083
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,238,1725289200"; 
 d="asc'?scan'208";a="227183390"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2024 17:47:28 +0900
Received: from [10.226.93.33] (unknown [10.226.93.33])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 375CE41AA103;
 Mon, 28 Oct 2024 17:47:25 +0900 (JST)
Message-ID: <9357db88-c9f3-4864-a8e1-61a83954f09b@bp.renesas.com>
Date: Mon, 28 Oct 2024 08:47:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] net: phy: ksz90x1: Handle ksz9131 LED errata
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
 <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yQK0M0fpQXs1Pkockljra9Z6"
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
--------------yQK0M0fpQXs1Pkockljra9Z6
Content-Type: multipart/mixed; boundary="------------gRQi6Jm7z9NQngECnbHyI81N";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
Message-ID: <9357db88-c9f3-4864-a8e1-61a83954f09b@bp.renesas.com>
Subject: Re: [PATCH 06/14] net: phy: ksz90x1: Handle ksz9131 LED errata
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-7-paul.barker.ct@bp.renesas.com>
 <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>
In-Reply-To: <ff3ff3f4-c7b1-4a8b-9a0a-0153404bc56b@mailbox.org>

--------------gRQi6Jm7z9NQngECnbHyI81N
Content-Type: multipart/mixed; boundary="------------vGVNYo73iXNTRT8oAOGSazya"

--------------vGVNYo73iXNTRT8oAOGSazya
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 27/10/2024 16:18, Marek Vasut wrote:
> On 10/24/24 5:24 PM, Paul Barker wrote:
>> Micrel KSZ9131 PHY LED behavior is not correct when configured in
>> Individual Mode, LED1 (Activity LED) is in the ON state when there is
>> no-link.
>>
>> Workaround this by setting bit 9 of register 0x1e after verifying that=

>> the LED configuration is Individual Mode.
>>
>> This issue is described in KSZ9131RNX Silicon Errata DS80000693B [*]
>> and according to that it will not be corrected in a future silicon
>> revision.
>>
>> [*] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9131RNX-Silico=
n-Errata-and-Data-Sheet-Clarification-80000863B.pdf
>>
>> Based on commit 0316c7e66bbd in the Linux kernel.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>>   drivers/net/phy/micrel_ksz90x1.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel=
_ksz90x1.c
>> index c48ae6e88f30..4f99b115a3c7 100644
>> --- a/drivers/net/phy/micrel_ksz90x1.c
>> +++ b/drivers/net/phy/micrel_ksz90x1.c
>> @@ -436,6 +436,26 @@ static int ksz9131_config_rgmii_delay(struct phy_=
device *phydev)
>>   	return ret;
>>   }
>>  =20
>> +/* Silicon Errata DS80000693B
>> + *
>> + * When LEDs are configured in Individual Mode, LED1 is ON in a no-li=
nk
>> + * condition. Workaround is to set register 0x1e, bit 9, this way LED=
1 behaves
>> + * according to the datasheet (off if there is no link).
>> + */
>> +static int ksz9131_led_errata(struct phy_device *phydev)
>> +{
>> +	int reg;
>> +
>> +	reg =3D phy_read_mmd(phydev, KSZ9131RN_MMD_COMMON_CTRL_REG, 0);
>> +	if (reg < 0)
>> +		return reg;
>> +
>> +	if (!(reg & BIT(4)))
> It would be good to have symbolic names for these BIT()s , please add=20
> some #define ... macros .

I can add symbolic names for the values used above
(KSZ9131RN_COMMON_CTRL=3D0 and KSZ9131RN_COMMON_CTRL_LED_MODE=3DBIT(4)).

The arguments used in the following phy_set_bits() call are a bit
trickier - all the errata document says is "Register 0x1E (30d), bit 9
must be set to 1". The Linux kernel commit adding this workaround
doesn't have any symbolic names either.

Thanks,

--=20
Paul Barker
--------------vGVNYo73iXNTRT8oAOGSazya
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------vGVNYo73iXNTRT8oAOGSazya--

--------------gRQi6Jm7z9NQngECnbHyI81N--

--------------yQK0M0fpQXs1Pkockljra9Z6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZx9PnAUDAAAAAAAKCRDbaV4Vf/JGvaPd
AP9ZwOn6U5TGq/bnOWZ0eO/n1VJAFCuka7Gzs7i2kHjCqAD+K7MEe9VRnrHylt+XwS77O481sar+
kywfz2UI6ymB5QA=
=bBDM
-----END PGP SIGNATURE-----

--------------yQK0M0fpQXs1Pkockljra9Z6--
