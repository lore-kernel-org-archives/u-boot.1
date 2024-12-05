Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72629E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E985894FD;
	Thu,  5 Dec 2024 20:00:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B2508950D; Thu,  5 Dec 2024 20:00:28 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 105D48952A
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:00:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: uVjAIXNfSkaJEaTOoZP+xw==
X-CSE-MsgGUID: LJEaNO8BTE21iT9srE25pg==
X-IronPort-AV: E=Sophos;i="6.12,211,1728918000"; 
 d="asc'?scan'208";a="227032931"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 04:00:23 +0900
Received: from [10.226.92.29] (unknown [10.226.92.29])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 69C614062E03;
 Fri,  6 Dec 2024 04:00:04 +0900 (JST)
Message-ID: <810d3a9d-f5ed-4b60-a5a9-1ea95ce3c6be@bp.renesas.com>
Date: Thu, 5 Dec 2024 19:00:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] pinctrl: rzg2l: Support Ethernet TXC output enable
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
 <20241120094830.71-2-paul.barker.ct@bp.renesas.com>
 <8dd0b366-6e6b-4e6a-87d2-5a8d204c7732@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <8dd0b366-6e6b-4e6a-87d2-5a8d204c7732@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dcfXCDvaH0xNRzj68rb6giXF"
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
--------------dcfXCDvaH0xNRzj68rb6giXF
Content-Type: multipart/mixed; boundary="------------s00QrMViwaJ7dqoVuklJI89j";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Message-ID: <810d3a9d-f5ed-4b60-a5a9-1ea95ce3c6be@bp.renesas.com>
Subject: Re: [PATCH v2 2/3] pinctrl: rzg2l: Support Ethernet TXC output enable
References: <20241120094830.71-1-paul.barker.ct@bp.renesas.com>
 <20241120094830.71-2-paul.barker.ct@bp.renesas.com>
 <8dd0b366-6e6b-4e6a-87d2-5a8d204c7732@mailbox.org>
In-Reply-To: <8dd0b366-6e6b-4e6a-87d2-5a8d204c7732@mailbox.org>

--------------s00QrMViwaJ7dqoVuklJI89j
Content-Type: multipart/mixed; boundary="------------wywGFkwIU0ms3cZI4EvwRdD1"

--------------wywGFkwIU0ms3cZI4EvwRdD1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2024 18:50, Marek Vasut wrote:
> On 11/20/24 10:48 AM, Paul Barker wrote:
>> On the RZ/G2L SoC family, the direction of the Ethernet TXC/TX_CLK
>> signal is selectable to support an Ethernet PHY operating in either MI=
I
>> or RGMII mode. By default, the signal is configured as an input and MI=
I
>> mode is supported. The ETH_MODE register can be modified to configure
>> this signal as an output to support RGMII mode.
>>
>> As this signal is be default an input, and can optionally be switched =
to
>> an output, it maps neatly onto an `output-enable` property in the devi=
ce
>> tree.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> ---
>> Changes v1->v2:
>>    - Split out of series adding RZ/G2L Ethernet support [1]
>>
>> [1]: https://lore.kernel.org/all/20241024152448.102-1-paul.barker.ct@b=
p.renesas.com/
>>
>>   drivers/pinctrl/renesas/rzg2l-pfc.c | 31 +++++++++++++++++++++++++++=
--
>>   include/renesas/rzg2l-pfc.h         |  2 ++
>>   2 files changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/renesas/rzg2l-pfc.c b/drivers/pinctrl/ren=
esas/rzg2l-pfc.c
>> index 0098e2d52d57..af371bd0ff1e 100644
>> --- a/drivers/pinctrl/renesas/rzg2l-pfc.c
>> +++ b/drivers/pinctrl/renesas/rzg2l-pfc.c
>> @@ -180,7 +180,7 @@ static const u32 r9a07g044_gpio_configs[] =3D {
>>   	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
>> -	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_V=
MC_ETH0)),
>> +	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_V=
MC_ETH0) | PIN_CFG_OEN),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>> @@ -189,7 +189,7 @@ static const u32 r9a07g044_gpio_configs[] =3D {
>>   	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH0)),
>> -	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_V=
MC_ETH1)),
>> +	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_V=
MC_ETH1) | PIN_CFG_OEN),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH1)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH1)),
>>   	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_=
VMC_ETH1)),
>> @@ -449,6 +449,32 @@ static int rzg2l_pinconf_set(struct udevice *dev,=
 unsigned int pin_selector,
>>   		break;
>>   	}
>>  =20
>> +	case PIN_CONFIG_OUTPUT_ENABLE: {
>> +		u8 ch;
>> +
>> +		if (!(cfg & PIN_CFG_OEN)) {
>> +			dev_err(dev, "pin does not support OEN\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		/*
>> +		 * We can determine which Ethernet interface we're dealing with fro=
m
>> +		 * the caps.
>> +		 */
>> +		if (cfg & PIN_CFG_IO_VMC_ETH0)
>> +			ch =3D 0;
>> +		else /* PIN_CFG_IO_VMC_ETH1 */
>> +			ch =3D 1;
>> +
>> +		dev_dbg(dev, "set ETH%u TXC OEN=3D%u\n", ch, argument);
>> +		if (argument)
>> +			clrbits_8(data->base + ETH_MODE, BIT(ch));
>> +		else
>> +			setbits_8(data->base + ETH_MODE, BIT(ch));
>> +
>> +		break;
>> +	}
>> +
>>   	default:
>>   		dev_err(dev, "Invalid pinconf parameter\n");
>>   		return -EOPNOTSUPP;
>> @@ -542,6 +568,7 @@ static int rzg2l_get_pin_muxing(struct udevice *de=
v, unsigned int selector,
>>  =20
>>   static const struct pinconf_param rzg2l_pinconf_params[] =3D {
>>   	{ "input-enable",	PIN_CONFIG_INPUT_ENABLE,	1 },
>> +	{ "output-enable",	PIN_CONFIG_OUTPUT_ENABLE,	1 },
>>   	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	3300 /* mV */ },
>>   };
>>  =20
>> diff --git a/include/renesas/rzg2l-pfc.h b/include/renesas/rzg2l-pfc.h=

>> index d1015b1d2ac1..36fa8da8e2e4 100644
>> --- a/include/renesas/rzg2l-pfc.h
>> +++ b/include/renesas/rzg2l-pfc.h
>> @@ -22,6 +22,7 @@
>>   #define PIN_CFG_FILONOFF		BIT(10)
>>   #define PIN_CFG_FILNUM			BIT(11)
>>   #define PIN_CFG_FILCLKSEL		BIT(12)
>> +#define PIN_CFG_OEN			BIT(13)
>>  =20
>>   #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
>>   					 PIN_CFG_SR | \
>> @@ -79,6 +80,7 @@
>>   #define SD_CH(n)		(0x3000 + (n) * 4)
>>   #define ETH_POC(ch)		(0x300c + (ch) * 4)
>>   #define QSPI			0x3008
>> +#define ETH_MODE		(0x3018)
> Parenthesis unnecessary around the 0x3018 , I can fix it while applying=
?

Thanks for fixing this up!

--=20
Paul Barker

--------------wywGFkwIU0ms3cZI4EvwRdD1
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------wywGFkwIU0ms3cZI4EvwRdD1--

--------------s00QrMViwaJ7dqoVuklJI89j--

--------------dcfXCDvaH0xNRzj68rb6giXF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ1H4MwUDAAAAAAAKCRDbaV4Vf/JGvXkQ
AP0Uirv2szUjxWArmMgSfVEnAwjlYPLPezYhgfSTwu824AEAkm6KkKZ6ZQ4fXg4DlA2Ro4uQ0nzm
MkEiFPhihBvNDw8=
=5sG3
-----END PGP SIGNATURE-----

--------------dcfXCDvaH0xNRzj68rb6giXF--
