Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C9BC5474A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 07:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ABDD88A2E;
	Wed, 28 Aug 2024 09:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="GzMR1ylT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8342C889D3; Wed, 28 Aug 2024 09:07:51 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AAD888A75
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dy1NKK+EuXB6RFWGdqoqe/W+egQ9Z26FJUkYNad3poBz5TPeMX3xc5n2Sa1rsAyh4RvdTV5PGxrNDcLZfd/9Xau9HhMFvh1BWyQYT/vOLCXpN8RkbE8MlsCwNitp2ns7hK5JducUYzBi8MVw3JEE1WLE8y/SktDWtdYCv4JlnUrM6zlpCVdKzTziIymXYE0DJM0CLUvgi6SFJAVJF+Deiz/diqu54xAFO89hX/lGpONzU6Mb9VkK4rsZermmDPqHeACFEgaWFSu7hjSjNOLdelzJuBkxtXigfS8QeH550UBbTaX6WjpEAXaQxjDjVTeohXu21DTX3FcbV8uKwLMUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nzMFSYpXXTJ7dK0NBI1baaxOKRW9wjpaEhWwGlUP+8=;
 b=ZbD9l3VYyERJJl+y4HmSf56j9gukfPra4g956yWc5ikPqnNSUkkcVRh6uNmxyzuqBj0xl/ADuCOR6eealBKiUibI4T+cVybl8AeMyAKC+h0YH/xuMMx//F5z1kjW3vFEywCBWZ7+oFCUmuso/gYIEyAsR82fh2PkIxIrUH8T9hDZAqO92NV4FW8jhL6AinkPseIQTfS6GFVUqkXJNXzDOQQsMtumP20xbkGvqk0vRKlnwYPLJVfa2N5TEnGh4o6VwvEam7i3DAJx0R3aotM1ZdjkF5A8Vn1BKFVcgvz3D0WZ2rcmrJTkqgvxWkLQpEaTWmmiD4191ZfPlu4o8guNYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nzMFSYpXXTJ7dK0NBI1baaxOKRW9wjpaEhWwGlUP+8=;
 b=GzMR1ylTSqj4gJDmtoRLmmaMEAIntihgtm4LHQjEIiCKGNXXmCbT0yEabubil+fJ5cigKLBT5zu3JPwm4DzlLocccoWVz9310+uH+TqCBp3aFl88t+eYz4+BvQzrDVmFF6TXA8wVVwIKnEijUHPn0cXToNjqEvyPk3En8NSfmJGx/cYL1iIubUYYlisSKs5Ts53eTd75nSWGhyfys1gKqjdgZ9d/yJEtUJ8yIUlugWp7ECVcFBgl1L0tjafpdIrjdyfo0S2SNVNK8vMhLaZNyuOK4guVmQdQPlsIqm/4nHqxIz9mUZMzfbok7efFMnvSHZ3XXxOETIQnU9sm1uNeRg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9884.eurprd04.prod.outlook.com (2603:10a6:800:1d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 07:07:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 07:07:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tomas Paukrt <tomaspaukrt@email.cz>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "marex@denx.de" <marex@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>, "trini@konsulko.com" <trini@konsulko.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>, "aford173@gmail.com" <aford173@gmail.com>, Ye Li
 <ye.li@nxp.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>
Subject: RE: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode 
Thread-Topic: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
 output mode 
Thread-Index: AQHa+Q9dmcHORVT0b0OJlvrywhMoX7I8PhkQ
Date: Wed, 28 Aug 2024 07:07:46 +0000
Message-ID: <PAXPR04MB84594F2939AE13CFEAD7E97688952@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
In-Reply-To: <Q9.ZbwV.3d4YBfwRcrs.1cphoJ@seznam.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB9884:EE_
x-ms-office365-filtering-correlation-id: 2992e646-0f21-48e6-4eb3-08dcc7301e67
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Gr4osZZqZO033gCiaaID72wg0Pk1Eh35luwSNnk/h0k4KvvSFfgO8+LUMcoM?=
 =?us-ascii?Q?fSu8Vv30Kwe5ACOH+SZRKt6F0lG2ThI7JI5QpjD5aoQxtVmdOv6FQNoduDj/?=
 =?us-ascii?Q?TUHTTZe3DoHeHS7MAX6eV+7u6igEKuRSNZG0C0aQJLV/lZp4bwgC5Sj5EVil?=
 =?us-ascii?Q?8rvLpLnHgTW8VbSkq2NoId4KVezz2/I6tlUGmDiM5do86K3Nkzo3TZN+EOdO?=
 =?us-ascii?Q?inFDiYl6RFkaUoy65lm6s/+vDB2YIotOIAmKFi00SENaq6DI1L4YeacXlI8I?=
 =?us-ascii?Q?NIrSgKTQmojJCIF9e4YboLtNhj1nlkzoooxnVepva7m5DA3wTi958Ezi1OQM?=
 =?us-ascii?Q?2kMRL/HGhTkR7V2UfTDRHeUMjGHF64RquCMI5obeGstnpIfFc3/+jZ4u9G4n?=
 =?us-ascii?Q?W/9YgedgIxxC5+1Lvz6A1gjm6GxzvoFUIr4YDerNPe3LV+0lEP/cpLsrnkd7?=
 =?us-ascii?Q?FbmzGK340kZxdneoqE/HGzQcpfB8ff/E8NzmiuRodUNsZlEWOWVZyBW0cGNr?=
 =?us-ascii?Q?ri6Dzn1yvLQ513/kgfM0bCxuLEyCEVQe4Mh5SeDzg6GwwCESe7GOGv6hrKtf?=
 =?us-ascii?Q?sex/ipXtPSk99A78TBKyoVcqiTvcBY/tx74+sYbwyhJJ+VmfRCafBZ5jrqaP?=
 =?us-ascii?Q?dIbqIzzN0Z58PO5sx1D1ae0p/mUOTnyhxRm++HLduYoHoczY1pckt+U1DqKm?=
 =?us-ascii?Q?weN4SN3+rsOxwRpk3MI07QXZFfm2+O77pt0SeeXSGfRtyTRqMxyapx3z/eEw?=
 =?us-ascii?Q?rHkrLacGtAyWvA8CzlkmTF/I8+mkMuBSTaPPS5o3q8NagP9rE9aq+9QnVkTQ?=
 =?us-ascii?Q?vz2Yb27/6ZGgXogJZ+q0VDAnixeaWqenKPVVmrV8+S020tLdD8gWAEnVtXSR?=
 =?us-ascii?Q?Bisq4z5pZPb16ym2JCojAKDQfVT2RFKiAicMbgOUcWAUsEpku5/6CrlZcOFE?=
 =?us-ascii?Q?xRg9ToNF35/OVpy9R/ktFIoVdzTaDOcVwGBxVd6aQ7+1poeQ9v/E2kFQR1Pg?=
 =?us-ascii?Q?8tIRqhQjqraAxMeeB/iPVZYlgt8Y6jbqSmA8D6FpKWPjIMPla0wkmb4eqtsw?=
 =?us-ascii?Q?HnTHJYeWe7/u0pMf0hnfIjxdrd9SyQWTRk6sNCX+YtSV3yBuTBrv/OmjTycM?=
 =?us-ascii?Q?+NECgUB7umWumFp9RcIMSIYfEBqqpTR0+Pyrqa3h9KUN0MtfsMkmf+1XlRUf?=
 =?us-ascii?Q?RwyaZJM3xhPwLmkr5zhRQvTa0UYjd7Q2L0NwLvhjK1VtiH13ichInM4mQ8bV?=
 =?us-ascii?Q?O29mRklSRbQTqQpUxytuyChRyWoWNB7Wfv66sEMW27ZIZXMkW7PDVsT1t5O4?=
 =?us-ascii?Q?NBH3i1qdNlb5CDJ3dxzRtdK99KkO4DyJCTNPprOCg1f0eM/w3DGj6gMJfikH?=
 =?us-ascii?Q?GS9oMQVgvSQQ/rfUWYYUIZgRY5WHubB9f01LqxConIbvKJnaqA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jq4VGYblKoYWQEYh43UJB/MwoCZtet7+4Xlb9Ol9Zcbgk6y6p3owB4kG07Zf?=
 =?us-ascii?Q?fuU0Iv1vUlLxZom7nXsk/vjRZzB8HAJ4Fcq1CHlGeGN4WVIF1AcCnxG8I715?=
 =?us-ascii?Q?Y8vLdfWzLKSwpQifrSH7nz4ZjnClljFMPMBBK0KVAgL+ptvlXAASfPSvATmF?=
 =?us-ascii?Q?cwnUxH/LUlaQUjsn6sKXGTaJvMhRtjVWleLjzLsEHF7BgYurkX3d6QHcpi4V?=
 =?us-ascii?Q?tJGdHrjDR1IFnskQdMvipa8kq36xEp6PjyNFcEfJPxRs/zSWaOHaS3gDA6vs?=
 =?us-ascii?Q?NMRx4YO1qyyjYnizpvzxu76xkKPhyqny2XqAvRc0LLWA9bcxn9wNLcqFss2x?=
 =?us-ascii?Q?Gh+P70IpzcjRuny6EvG3nORNI4fUFc56WjxPismFP7AL3xTH7N+olyQ5GVTe?=
 =?us-ascii?Q?sLzL4eAChJqy/SvllTHA7W5CXZUs5A33sZL6KyuRdnr/viFHmS+/aSQ77eJx?=
 =?us-ascii?Q?wwRM7tejJp1rDQYRtwxEl7+cwQJcAxmsGJrY71nSwU2FILEsyOVuEzyWwTVG?=
 =?us-ascii?Q?ImZpyMIZPM2uTIO/MRUBxI2IOxJ0UDD5+CdY3OiAJt11UndKU49cZvJS+040?=
 =?us-ascii?Q?v3F0EQ+7fhqX6L897IRkw+AWyyKJeIgll7KjwHP9P580FbVO0eDnhkzp7Ioe?=
 =?us-ascii?Q?T9mjBiEUwW9vdPQMvXSMgPV7WcxOqgU0tm4KrtLPhkw2PHeWTlsIkiAAYKEt?=
 =?us-ascii?Q?j/otSiOXv4cLJT3ZUVRaMdoVxo1fRyfn+c/zXvZB0SrDE48c49l89XrNtznb?=
 =?us-ascii?Q?j4o65Elk5nBqhDEIQDyvP1Qywq9l5YoKssidHQhCnP1/ha9maieY3N2ltyNo?=
 =?us-ascii?Q?0N8fv6O12sT+WjDxnp27GLCDroqoo2oGNfDMUcFBDci7zuz13rnjwWu41QVW?=
 =?us-ascii?Q?h6iK+bZnnGPEsAXXeRMCCTPgQ/EelFsUMzjfJy1jmfe018mJDt7R35GJ+M6Q?=
 =?us-ascii?Q?BXHFWq/GchszyXSEsByYhuGs+1iZrPK9RkJ7aK+mKfBaTOpaEjclOvs3tvie?=
 =?us-ascii?Q?44I3VWivoy5AhLsnw+nRYxWYj1LTT+S7/DYVltjmjt+UN0M/SrkGcLSIEU80?=
 =?us-ascii?Q?Mdbs/U9WjQdco35QmCIcdawKDvq7g0KXXUZY/95qCseOUG9v0Mb7v+S/lbSO?=
 =?us-ascii?Q?TV0w6sQSpDrj+OEZr6woAIwV86dXNWSDGwO2IzBt5Xn7mIDy+o1G9Of/6qYE?=
 =?us-ascii?Q?odCNaLDyI+LmC0tkhXvO8c1Pzh0aLf/f+5HcjBhmZorsXJ1tlnLAhRxPwDmv?=
 =?us-ascii?Q?V8R2+JDsMODKFlloYK7j5apgXx7rnZB5vNbYBe+vdU+dli8vSy58mI+eIOh3?=
 =?us-ascii?Q?2o0JdesLv0vG7z2sE8Cs3pFDygsPU6s2uXnUshrd9ixt1bkiHU57QuEMbLPy?=
 =?us-ascii?Q?VURHXFfgzt2P6j7zu4IhkTN8mtQ6kMxPi1TgK3EGNFb9b0sw8MT2Afht9RCN?=
 =?us-ascii?Q?ExCXmJEEUOcxvXvC5eSoHPQ73NjcS6LYeAfV2CSkVr7zknR0czQC7Y4dteMI?=
 =?us-ascii?Q?wl1HvKacpDCNN3D9LlyYjh9DhjeEVJiQ/YlfXQipEo91VXucynaAX3PQUxoF?=
 =?us-ascii?Q?FZggjc7oeidARICBGkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2992e646-0f21-48e6-4eb3-08dcc7301e67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:07:46.1780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kWUOcETX5UTAq+2wU+oeYZTG+HL7jKJwDIafcZEKm9jcR83g4riayrQgz75N8/SROxcDHH3F2/ebYNnpeTbNrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9884
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

> Subject: [PATCH v3] gpio: mxc_gpio: fix reading state of GPIO pins in
> output mode

You may give a look to this

https://lore.kernel.org/u-boot/57015C5F.3080209@denx.de/

Regards,
Peng.

>=20
> The PSR register works correctly for GPIO pins in input mode, but
> always returns 0 for GPIO pins in output mode unless the SION bit is
> set.
>=20
> The DR register should be used for GPIO pins in output mode to allow
> correct getting of previously set output value.
>=20
> Please note that the Linux gpio-mxc driver already uses the DR register
> for all GPIO pins in output mode:
>=20
>=20
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
> ---
>  drivers/gpio/mxc_gpio.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/mxc_gpio.c b/drivers/gpio/mxc_gpio.c index
> cac6b32..190c70e 100644
> --- a/drivers/gpio/mxc_gpio.c
> +++ b/drivers/gpio/mxc_gpio.c
> @@ -133,7 +133,10 @@ int gpio_get_value(unsigned gpio)
>=20
>  	regs =3D (struct gpio_regs *)gpio_ports[port];
>=20
> -	val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
> +	if ((readl(&regs->gpio_dir) >> offset) & 0x01)
> +		val =3D (readl(&regs->gpio_dr) >> gpio) & 0x01;
> +	else
> +		val =3D (readl(&regs->gpio_psr) >> gpio) & 0x01;
>=20
>  	return val;
>  }
> @@ -210,7 +213,10 @@ static void mxc_gpio_bank_set_value(struct
> gpio_regs *regs, int offset,
>=20
>  static int mxc_gpio_bank_get_value(struct gpio_regs *regs, int offset)
> {
> -	return (readl(&regs->gpio_psr) >> offset) & 0x01;
> +	if ((readl(&regs->gpio_dir) >> offset) & 0x01)
> +		return (readl(&regs->gpio_dr) >> offset) & 0x01;
> +	else
> +		return (readl(&regs->gpio_psr) >> offset) & 0x01;
>  }
>=20
>  /* set GPIO pin 'gpio' as an input */
> --
> 2.7.4
>=20
