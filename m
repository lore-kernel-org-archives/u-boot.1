Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3078C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6611083764;
	Wed,  9 Apr 2025 14:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 054A782982; Wed,  9 Apr 2025 05:01:06 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B625682917
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 05:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQZtDge97XCYXxCHzmHQJryX1M5xcEH8CAVhZqEFZtqyaLioBsM0v39C7Xq/CEyhojZDw76S8Hbdd4CyGkcK1f8uceTqfNoHySPZgG7CQvozpZCt79hVVQcTaPPKzDegzYiINGdYV9VpvW/6rJNtl+s8FXLFxR3ZTs4U1RD8bCgQKwg4qj7UIvPG8GsU4RECMPn698q4nmWcPReXGOHfrm5XmqNTNW77m3H1Mhr+c3HdW9/eaXvWeNpQ++wtjkLfIPe+dAVD8nbjQd9obtqIUPO0rGmviwPRHoDtLGc65TMhcN3PlLoPr8PLguUN/cS3GE+mumRqGw8AC8NXlcUzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvrNaXpsEjSvqYnfMtPZUK9aM0cqFL1ogZuRkKccuvQ=;
 b=M/7qXYu2fpcl2TfD4Z2k0N2bbDgRjwrv0pFSMeD9gHiSgnu5U5CMtBoiC6TdXUS9pOQU0/BYKHkLOkcTwqP2rv42fmbB4t5lchtuvk6Xk69UnlGpGlSDkp6nOmNuAtb93y+Ujw3KNs0WioZlUOj5/t0pIAVub2SwUWMWjY2rMGHdU74hZGWycnM/3NEJ5ncCgUyZ4UKtYYA0CNZORefVdUV7DCyQo7EZ7NzLlT4uPbHHxHG/9VfwaGsUJB3Wcv51GbrTU37Z+QMInePDDSQgBg1JZi2JKEwk15+tGpMwpoRWMHJOIkXIReIfFbt0opFnMoOb9nLLrYUdZWVzbOM5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.49; Wed, 9 Apr
 2025 03:00:54 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8583.047; Wed, 9 Apr 2025
 03:00:54 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Minda Chen
 <minda.chen@starfivetech.com>
CC: E Shattow <e@freeshell.de>, E Shattow <lucent@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Simon Glass <sjg@chromium.org>, Andreas Schwab
 <schwab@suse.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, Quentin
 Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 4/8] board: starfive: spl: support DeepComputing
 FML13V01
Thread-Topic: [PATCH v2 4/8] board: starfive: spl: support DeepComputing
 FML13V01
Thread-Index: AQHbog3yA1v0c+8BfEKcq3WDrJVRJbOaso5g
Date: Wed, 9 Apr 2025 03:00:54 +0000
Message-ID: <ZQ2PR01MB1307AA8DCB20D56883446866E6B42@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250331072410.8662-1-heinrich.schuchardt@canonical.com>
 <20250331072410.8662-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250331072410.8662-5-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
x-ms-office365-filtering-correlation-id: cc9fa6be-360b-4dd5-d5a9-08dd7712bea5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|41320700013|366016|38070700018; 
x-microsoft-antispam-message-info: c3nh+8vYJE857N2vlogxLvw6PlMaD/IcqUnEeFypJ09uj9d/bY+mnlKKU28DrQ4fjEvYwMjNkZyNwMqC6UPVxNjq2OIYN4olMJgkAJOMeCUva3gQS/FW8YiUSn4LI6ePb0c1IfNlnbKxSBHczUQNW07208c9dzeDAESOTKon3dXjE7vDC+8I2w7Ed0hxmqBAxhJOZj4ePaELJ8Fp6DtA/ehV6k4p6hYJO2kBpHS+8QajlJBYEVL+5x3A4LNJSOdN0AtiGzI1NgQB36Gl6C8zm6J89EB+aRkzBPZrqGsADlOEwEOwArGURcA3zhRZl67aguaRbRt15xqL6wcRzz0MH5xJNWam2SojiekzGoZnfpp0x0iNdVsVj+WulD+9kw6dWYQXhGa/S98XsnezvH0Z49R8zVANfnQNBk+/dOYt0H1qQhJmrX2JbjF35IZ4ECjd0uqeKYPrPow7NCNwTHrXHAu12B0mZsmABFrMoT6mooZ7OoWlcbIA6yFkl2smm6NDcmW/Xil8ZV6rn99KImL5b04RNMfH0fe08+3p1CnTk/gHf9eFdFoltfU4BnaAzt0YWNb8HOb76JKDjkbxK4u7Agz53Tiaira2QnXadsj71pE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(41320700013)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5TuB5HYptVoUai4bP5VMuyNMBx9h5wSIGoLu6dc1jAjg4zUunn2yKQhJXYCw?=
 =?us-ascii?Q?qZHSz7DTE7Y8xfIksZ2Jf6RPCiHxAF7AtiCtWaYlxep9U035dluz6JEXlHAd?=
 =?us-ascii?Q?1WU2qYCTLRy0Gl6/rLlijVy+UM7AGO5bpvvVmJdhm4bFD6FW/sI/MkcZtiMM?=
 =?us-ascii?Q?LzzZiH4yP1JFHURAf4FXU7W8uQWWrUHAxKPq7pqT3ibUjep9y/msmjQL4Y9q?=
 =?us-ascii?Q?2Eg9YSSg/zMJn7k+Q1EdCpIz6ZYuwmprsoX2YVtzZnt8LsBykpf3Alo/yFw3?=
 =?us-ascii?Q?5jHWd4Z4wySC961fk5LOm92kk/bpgT4/XvCyTugWRo4ooMk7kux2hnW4JQm5?=
 =?us-ascii?Q?kvLQEGRuX22okIV8SJvGuvs776UeNe1GkIszCagthv6EjnHsf+mt2ojWRxbk?=
 =?us-ascii?Q?jh/h2hJpYUPhc6xklJEE4QLiK8BoaA+2T4zlkRbXrKXJDjYpEkd9ug6g6Mrg?=
 =?us-ascii?Q?QyFurM+6+P2cq+m/kPEpwFPpQ0EyqSOecuX7TckX7T+4RMcSkuOVsUuhw1QZ?=
 =?us-ascii?Q?KzC0zAhmigcwQ//g4zfKlMbJxJHEQiJEqvSMyAsqCDqAF0FunMbkD+mSMs4B?=
 =?us-ascii?Q?xCgUXwLYE/dELt95YaZv7s8S+RjrNUKVPLXkm3ZeKEiHptKef1vse6iFxaCU?=
 =?us-ascii?Q?/k23xBew8HFKzTwMQNzFWKIJQeNk9riWVErlqc0/sykwuxC4qg63WussDy5U?=
 =?us-ascii?Q?LzfMfAwKzP39yiPQdThYRSlhnPgoPC/UBZEbOacSV3pebjbOF3+LbXcxcJcP?=
 =?us-ascii?Q?lVbNnV95NyiLaFLhOkkHCjz7OHJKixBM6VniL9ILbv920lu2iRFhxlsfl6WS?=
 =?us-ascii?Q?xtfnK8ubmvAXD/GR/VL+wd92B73nU2LGzVRWCo3lCzGVExiEZI/Ur8Y9mPE2?=
 =?us-ascii?Q?bkS0uTAgdIe0Aqbo6o9/cW77vw91HGGx0vH2ABHKP5ik9YrMqQCpZ19evv6/?=
 =?us-ascii?Q?xCVLeEJUUMb1R5LIc4a8CKq4en0K6XqUXrcmgykiV8wPVmbSCpDj4jQ08HLV?=
 =?us-ascii?Q?OyIFyydGvKW0DrdeIgY1DnAQeb+zExJY3O39DXdV7Dnho4n7aZsaoaATVrGL?=
 =?us-ascii?Q?ArxE9CINezAx6SVr/3FTB92cnI6TxWsgcyUh5frjiYQEnfhG4CN6s3bweM28?=
 =?us-ascii?Q?HvLb1zdU2dnqXLI4op6qdLcChdgoZNAhA7A0jrh6g5JN4Vf8hsauUAMM0+XZ?=
 =?us-ascii?Q?F9ZiHbgRzZPE8Jp61xtY5kNG4V8Ik45YV/MU8D1roQdOxFo73kwJasjedjhH?=
 =?us-ascii?Q?S2sV9rroubuYfzfKsATuOYlTFCcA+M2cowzqCiP5TcMvAMmFR1FjoKbCNx86?=
 =?us-ascii?Q?L1n36rr0vYg9eohL1zdG6nWgZuDksU7eS9BlLSS9ZY9JihEiCMW9MxHFLqOI?=
 =?us-ascii?Q?5b1iS8C/H3TpJqS+nIWaZ2k1ryhF7qSTyjCcWcFLy3OBY1/NlXscMMfi6p2E?=
 =?us-ascii?Q?F12IyJReX+cJMpvREqct+lHJe4CjWlMf7QR88pLKC2uwQf9+lq0AyIVj5ZXY?=
 =?us-ascii?Q?iUJ/9g/erqHZjWs1jPRS8yydsFKo7ew4ZVyyLdloUBr5w5cO8m/G1v+vz6lY?=
 =?us-ascii?Q?bHIOyo9xBEmpKaUT2eh1D6mlYhVPgLhrZZP1TK4WBNvilqnHriP7Io5DGWmO?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fa6be-360b-4dd5-d5a9-08dd7712bea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 03:00:54.8084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SVgKSfIViYShzuMmlm3iypFu3fb+yoJNAK/hGP0rKVE3o+9Ud/Xnixgq+mQ74supj2XeHN1WjTtW9gKDk3neI3JT3RCnp/jOaLSXnjoUJ5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
X-Mailman-Approved-At: Wed, 09 Apr 2025 14:41:40 +0200
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

> On 31.03.25 15:24, Heinrich Schuchardt wrote:
>=20
> On the DeepComputing Framework motherboard (FML13V01) choose the
> matching FIT configuration.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	rebased
> ---
>  board/starfive/visionfive2/spl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 13a48939c8f..52f75471de5 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -125,7 +125,10 @@ int board_fit_config_name_match(const char
> *name)
>  	if (strncmp(name, "starfive/", 9))
>  		return -EINVAL;
>  	name +=3D 9;
> -	if (!strncmp(product_id, "VF7110", 6)) {
> +	if (!strncmp(product_id, "FML13V01", 8) &&
> +	    !strcmp(name, "jh7110-deepcomputing-fml13v01")) {
> +		return 0;
> +	} else if (!strncmp(product_id, "VF7110", 6)) {
>  		version =3D get_pcb_revision_from_eeprom();
>  		if ((version =3D=3D 'b' || version =3D=3D 'B') &&
>  		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
