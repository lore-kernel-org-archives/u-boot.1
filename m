Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22E8D2B925
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 13:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49DEB8860B;
	Tue,  5 Nov 2024 14:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="XvwFn1oE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 163E888ED9; Tue,  5 Nov 2024 14:43:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE51B8760C
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 14:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bernhard.messerklinger@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ic2mAW9XcCVSiCut6G1mtP7F64f4JaFJF7sNlH4eRjkg5wYY3ADlAQBKcC4sqIteZlfZvFvpWyMf47nVSybsq96tDBitWzS9Vt/4fsDC4IR6fmK08QyiG3QzEpdq/GxN/vzn6kQxXxwSB8uVUJwEjDdFo7quhh4EKIg2nti5TKpEWrsRgQ7TYy4nu/0orqDFpsYT1SOSbS9y71qTsxjASOuSJH6PRV2l1oMlzaKDbkGDlByzc6nsotTY8hgBxDwL2CSxxvaMtY+h9MW3JCL14QVXD9NxUfQc6fdluibZHnNm8eeeVB5tMxgND4Nr/18/aRu8z/tEyQOkuWRG5DKjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ss1XydG9Sz7+VPRxw7N6YbhCRYZaYwagVskCdLgK6Y=;
 b=yZwhTaBZPo0i867Swy+7iP1s3PsxYVK1qwgmEMbk7/AyW0KPt1DhzSfOx6VTGgEyGs0HcC8wizRqY3VVfMhntPdk0N4t0giLIs9dmgkp7kE4JOKsNV3IG3VmHiD0NGUZ/+6h99YtDRpbw7Qan10PnLHppOU9yhrB3JYnfAllcXSIoRZqpZQ9uXKQxBqJ/g2/tbw3ACQx4IR+EZebKxw4MTJDljt9dhtPRL1QA0PXbIPGdJPOn3+/qoFX3u/swUN/7GGDwUbYXIfC5tq3tnENBer361vI+HbcEw0jdHYBhWi9uCai5DDnsqnMfdF0URCGBfoQm/TMruMqbsDU3o6Fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ss1XydG9Sz7+VPRxw7N6YbhCRYZaYwagVskCdLgK6Y=;
 b=XvwFn1oEHN12bEfJscTlvq0sh0lugqxRktr8YEPj+5MYTznzztMRlw/5TqVGO6TJqcrx9GdNiMagGBVXC6oBypPehfTunbwu825wcJ2zPI1jGYajZPVIbLocv5WdoZW+IfaAu6QPHZzAlwzkz9HwoCUvs3hUV/aCwRiXfMW5ZIqgphQO9kCOm+taArRHBssjQ4oBBjV9m/yVvxOnuAwVQLtGILX5izug4gynLsvrUotndh2EtB3zuWjJnuhdoy6XE/lZhNRsU1Vraze1/cS6Lf1NDtxLgYsUuwvyWyFwhziTh19hICVlMYU5kmiPf9YSV0ml2yGD0HWuDBU8pHAjbw==
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com (2603:10a6:10:369::16)
 by DB9PR06MB7930.eurprd06.prod.outlook.com (2603:10a6:10:29e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 5 Nov
 2024 13:43:37 +0000
Received: from DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652]) by DB9PR06MB8559.eurprd06.prod.outlook.com
 ([fe80::eaeb:257b:4131:652%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 13:43:37 +0000
From: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Wolfgang Wallner
 <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH 2/4] board/BuR/common: add parameter for reset controller
 I2C bus selection
Thread-Topic: [PATCH 2/4] board/BuR/common: add parameter for reset controller
 I2C bus selection
Thread-Index: AQHbKeAtbo8B3dpb+0utaI35brLvGbKd7e4AgArPnrQ=
Date: Tue, 5 Nov 2024 13:43:37 +0000
Message-ID: <DB9PR06MB8559A7C2C4237BD3D05165D0D2522@DB9PR06MB8559.eurprd06.prod.outlook.com>
References: <20241029085258.1740289-1-bernhard.messerklinger@br-automation.com>
 <20241029085258.1740289-3-bernhard.messerklinger@br-automation.com>
 <20241029163728.GD4959@bill-the-cat>
In-Reply-To: <20241029163728.GD4959@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2024-11-05T13:43:36.630Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=0;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8559:EE_|DB9PR06MB7930:EE_
x-ms-office365-filtering-correlation-id: e98e61fa-5f2b-4a72-6a36-08dcfd9fd984
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0LffQz9wWKCy8bWUA8lvmNnakyJ8+sDCUmp8CKc/qMIcZYHSkV6NvE0Vr+?=
 =?iso-8859-1?Q?UMg37DcsaW3MA/zFzq96/nHMdilHqfQUigLAG+YI8ZISRs9R9EF3XNBcW5?=
 =?iso-8859-1?Q?FEMDO0JqaD4oyMefxsWeKfhcS3GLhe9RpWILXa2bvJCSl2iyHrBCr9qnYX?=
 =?iso-8859-1?Q?3ulG80B7g01AbpsIUcE6qfjFyra9IgrrGmttWHdJKK9MV7QXDWScX0vd1j?=
 =?iso-8859-1?Q?awG3QvuVJ8yPZw8l4/qAvOIpj3GsE2BrknSfgPSg3x+z/AjgFKdnIuT78Y?=
 =?iso-8859-1?Q?m5v8650FSoCUQpasZp30ksHGfoLGY6oaaOlBqaAmKwPVHc1ytOA/XOzawW?=
 =?iso-8859-1?Q?3LO8iAvEKryIqJN5zQMejO8NSbA4Ztuez3CLxUdqJ5kk6WXnpooCgv4zNF?=
 =?iso-8859-1?Q?3+gPzhdLM1xxkgH1eTJETCDAU9CY+MepGmaEe0B3P/MN3vzHY5Z32EVDG1?=
 =?iso-8859-1?Q?9NKy55798olzrLj0LpGqLB57TEQq5a/ashXSnIu8mJAeJ9gY7htgJeu5BN?=
 =?iso-8859-1?Q?/f2FxXgX0dJGKSoYTAoNeJ8bsFcoxWu1Wl33v3aGiUose+t+C6uie3jCaE?=
 =?iso-8859-1?Q?5hshECm6htrEkcRi2pbO3jvP/etxCVKjwgces6+93xGLSLd0JcmYb8WJYF?=
 =?iso-8859-1?Q?LROyrfrbYAAaSzIJm+QAonBo9C3Tq6aQ7JX/wqKNQNq9l8fBw9urUkpxA2?=
 =?iso-8859-1?Q?y5wqxVVFDbyEOXvlCGuaTlIOvjh3Tf7dfdVILqpaVAlSKAP2O1jS3YUjFe?=
 =?iso-8859-1?Q?fJxiglqEP2GZBiKGrdVNa+joCJuWNJ/DEVrET0gWS2k9Hw7OkWbC1NAVIq?=
 =?iso-8859-1?Q?MqxC4ztHiWcqiexOAS72MlJeSyvMvP3dpnqx5UdFDEiKD7OmGctV/fqXsr?=
 =?iso-8859-1?Q?eIASkmaaTbnrnNmEIFPljzT9NGxPR2lob7ogsKO8a9EzZxAgFHmV/n9DsE?=
 =?iso-8859-1?Q?wPtTbJl9eDesxXzcu5EaIHdhFClq5kGQKXGPkdEwwVqU+u+7iwgYq6slaC?=
 =?iso-8859-1?Q?FKwEzqUbI/n0eNLdAjw8GgjBdBMvy2y035x6EoOfkyg1UkGaywQaCSIdD3?=
 =?iso-8859-1?Q?o4BMC/N2sc7bQERjbhh+FjUoYsyrc/Tse0C+W0D+aLww6hlSukH1ltdk4N?=
 =?iso-8859-1?Q?AK2/xzkaTc1w3DyjJEkChhptZUR3mdbT1QF18j2EuH46DTKg39mY07Neg6?=
 =?iso-8859-1?Q?xzPsace3Y7rwUWALqgzUACVbUEZhY6iROJmpK665GzIVcQWFkDK1efzxu0?=
 =?iso-8859-1?Q?zeVZtTTway7lJ1EPOnLobWZPhhZMFKLTQhO2M20ELtp3EUQ7ubpeZ9BJSS?=
 =?iso-8859-1?Q?NLm23fmx+qNkG6vYBgMFug2nx0vFe177c04/4dG/JwIIS+r6IztNbf8CeE?=
 =?iso-8859-1?Q?ukg2SmbCVE3f7vRcpPANCYc7p1qSeOwA4IjbHBbt9It2/fqAxxC0Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8559.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VGpvYgV176NnaDE83h9KPNFzrUUkOBGDpKWp8xTQ66MPH13n6YkiMOjO7D?=
 =?iso-8859-1?Q?vQTuC5o0MmzuHHwSWXivuywOj4ALs+9ZLXAIRYJm0e63/mJVxD34lQ3JKD?=
 =?iso-8859-1?Q?Z0/YiWgpoU+7Lm6HSjEzTQT1KHi0PF0MZJHXbOh7XTD4tRsQuwDMNQIJ2A?=
 =?iso-8859-1?Q?4bnoYL+m+pDfVzyM6AKWov/BcjN0zn7y++UV36xFjf2TtnG2mUEziAUhug?=
 =?iso-8859-1?Q?PaLWdV2R0qWfZ+jaFAks5MEuWZR6LDmydtd1jE5LimM1kp0YIeWn8L0III?=
 =?iso-8859-1?Q?nKzGJkJNu84Z75WDbh/m4L2jWhLieesvJrfxlVtXbsMcyOPtCjezAWhYNQ?=
 =?iso-8859-1?Q?3ekScXCyq6j9jQufjTZHp3LPnYLUkz8nGQNH7RIGU+/Wa9Ljyf3OV9QIwG?=
 =?iso-8859-1?Q?LWt7j+CSRvFHmFQuxFBkWLxpD7kv711ai46rAYPxhnP43+vSZ27tR2/gCI?=
 =?iso-8859-1?Q?sTLQAjydtodik5QqNvZ4Sy92whNaFGdneqAusARZQTBBtkevAOd2EMJION?=
 =?iso-8859-1?Q?NisIXWRt8XyoEt6+tRDY4hqp2535hcTTDukQYjVTms5rFkv1RedHWw7nS5?=
 =?iso-8859-1?Q?PYo+zf7QYQGP+5nlzOhboDE+qWaUbLoP7dmYIvHDjWETqR8oAtuptaQJNR?=
 =?iso-8859-1?Q?I/3HZb+eQmOfoGOhUNBGBhEL8n2wEivP+NC2Rle6kPgMEO1Fmh0zKbN48h?=
 =?iso-8859-1?Q?TRFibe0Ho21n7XGlyH0IKAIcDk+rqqT202JJr/KFuO1SyUt2972UiERstv?=
 =?iso-8859-1?Q?FJSR5KUtQroFy58REI4/v2uWgUTHjpKpjcHYhLw2TIgcVJ0W7xGEQvJb/+?=
 =?iso-8859-1?Q?pJ03vuDKyBEQ+g9icpj0VarhbWaqhxf3bVgPm5WNDZFZKlDj9LRkW73wvx?=
 =?iso-8859-1?Q?u3ZZczTJRlGAdfMFEAqNijbGMj/VXzcrOUh/2TVn0QXN1P6Zm72cU11jzv?=
 =?iso-8859-1?Q?b4ra5Wu9sAVpt+olt0vnsnk8W3cw7gs3wLQR4GC17A9W/VwuR8lZ5VvhMt?=
 =?iso-8859-1?Q?0a61Mm/2xuh4meBxsvmepON/mG3azGz9ifjB6HxQJQGzYBBFDy7Fgq4GxR?=
 =?iso-8859-1?Q?tweKq0MlnQ+XXkhr/KcmKRZ/EFFPGvUiT0edyGRW9Jj3PWxKNMQPorVhaT?=
 =?iso-8859-1?Q?cAxNAmP3skmJO/Zx7YcqzvInJA6l/wwTWsE3qXVG67Z0nnYKmd5vuSDSaX?=
 =?iso-8859-1?Q?KZmiGmzyoS6yGZ0TOtJHx3fcoHRTSsnronDyVsYapdEIrhem5J+kXfM0hy?=
 =?iso-8859-1?Q?RyKMCz2VJC4iiX7rJvErzBfJa8BHX9t7f0cEuS/CYKT9SJquw8p8ikazBN?=
 =?iso-8859-1?Q?qoeSEEpxqqLz4FK05DzY5Yk4B2US9SycLgW59nay7T2OajCR6+hZVJIUtm?=
 =?iso-8859-1?Q?N8d1lBVxDmNaxgzoDumKwGKKpZv8zu9avA4+2VDGIl7kZGMKeH1XuKjiUe?=
 =?iso-8859-1?Q?Vox9w0qkVYyurNROfbxFiq9I7IausnqFApnb6qs+IP+wb7HTBnqrmRi0t/?=
 =?iso-8859-1?Q?rQiuPBz5y1fM0FN/BK7uf9fSjvuz2ABP+LsE97JVoRjxChHUVCT9NeG+8U?=
 =?iso-8859-1?Q?vJA+xa+hquwbRyVKaNzDxYzoh6/K/KvSm4yalNfPpVhlfbtUYD5SwYg9c+?=
 =?iso-8859-1?Q?OE9jzqdPaYQmPrHhHwhJjqL6x0/grG+lURUykkUAGqF7X6QT7+Jz0XPGDL?=
 =?iso-8859-1?Q?e6OVFQRia33XX+5wvDOrIC3VSx2rV6+cVx7zPi/qccg4wP6Up6XJyLXJJX?=
 =?iso-8859-1?Q?Oln44bzw6qBxc6I/lK11Cu0IU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8559.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98e61fa-5f2b-4a72-6a36-08dcfd9fd984
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 13:43:37.0414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGHuQY5os+orx3+F/Z+j5+gm4m87VlSqqYGkDpHVbH34/vjGna5e2UKlFM4qa/DxD/twQOWlW6bm9vbDtyS8g5wnt3R86Y1XLNXXSypVkYxwYFFeZMxpFyTtEmRZX/qUMnuGmUt9l3xb/1lSV1X+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7930
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

> From: Tom Rini=0A=
> Sent: Tuesday, October 29, 2024 5:37 PM=0A=
> To: Bernhard Messerklinger=0A=
> Cc: u-boot@lists.denx.de; Wolfgang Wallner=0A=
> Subject: Re: [PATCH 2/4] board/BuR/common: add parameter for reset contro=
ller I2C bus selection=0A=
>=0A=
>> On Tue, Oct 29, 2024 at 09:52:10AM +0100, Bernhard Messerklinger wrote:=
=0A=
>>=0A=
>> Normally B&R reset controllers are located at I2C bus 0. This patch adds=
=0A=
>> the possibility to change this bus number with BR_RESETC_I2CBUS.=0A=
>>=0A=
>> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automat=
ion.com>=0A=
>> ---=0A=
>>=0A=
>> board/BuR/common/br_resetc.c | 9 +++++++--=0A=
>> 1 file changed, 7 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/board/BuR/common/br_resetc.c b/board/BuR/common/br_resetc.c=
=0A=
>> index f5d09fef3d..827ea6ba35 100644=0A=
>> --- a/board/BuR/common/br_resetc.c=0A=
>> +++ b/board/BuR/common/br_resetc.c=0A=
>> @@ -52,10 +52,15 @@ static int resetc_init(void)=0A=
>> {=0A=
>> struct udevice *i2cbus;=0A=
>> int rc;=0A=
>> +#if !defined(BR_RESETC_I2CBUS)=0A=
>> + int busno =3D 0;=0A=
>> +#else=0A=
>> + int busno =3D CONFIG_BR_RESETC_I2CBUS;=0A=
>> +#endif=0A=
>=0A=
> You need to introduce board/BuR/common/Kconfig and add the symbol=0A=
> BR_RESETC_I2CBUS there.=0A=
>=0A=
> --=0A=
> Tom=0A=
=0A=
I will create a v2 of the patch and resend it.=0A=
=0A=
Best Regards,=0A=
Bernhard Messerklinger=
