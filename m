Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20AF2C369D5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 02:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780A482145;
	Tue, 29 Apr 2025 04:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iBQcp1mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFF8082153; Tue, 29 Apr 2025 04:13:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A5782132
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 04:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmJ7C5gkWT8wH+kspZk/ksrbT2+BOAC+vBV35IPCVEvBfxv+wPCBUnqXON2GXx/cUC2+1zPDV7BLmnjLieBbDZ7TQKw4vIZI6A3d0VAaa8+EWnnlDvdDHg8fw1Bg19Izjq6b/ZVRg23Cu5Uq54yyrvjoo7yabrkA22hT9ENSJjs8C1Thv/3qWlLOL/oWOQA5wKC3Ja2U2Xztg/8UdmVa3FgmieMkbB0J0pDr58DQpDj7+29OftpVzQIKrr60Xiu+Fp3BJBGxq62Zjn+J9lmV243rnWS6S3QOJyH2KAD6r2Qr1EyJ/C9/qPmobyuKGXKKLoC3l/Ipd8iAmDigMMWk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqBtkQCyGA89siRXyHZLo2drdD/Ov4BbJqz8fhzOkHE=;
 b=tkvMP0Gj5yP8mFJO/EZx231whch24QhopEo3HwafcW77CssnPPxAMaDqY7sbPJ7FyGeMVQ/IFJuvfAAIX1r46o7KTBk8oliwuTqrsWN7UsxbeCFdn5IVbwYrsT4Im4xP23nfoCggzcKZXq3yeHSWzuLLi4cNHzKaEmc3GLnJpxsqMcK+eM0AUxJLsWc3pGzPXKF40p8TSiyqD31qUCsnMzyweiluqC2bq/G+9ZqQvgB4yT5DwMctli4aigoE/kFHYIwiWYUzepMMRTKnVBRJ7MGjfvyaux0znx0Speud0z8moMLx6/6AyG+37w4WrrE1ly1g7bWcgobfeRVOqpCKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqBtkQCyGA89siRXyHZLo2drdD/Ov4BbJqz8fhzOkHE=;
 b=iBQcp1mETV8uYyY9WVtCmLzgsAK/G7D/gKFCNl+pzwJ81bajDDVITkw697XEPAzblCDla41M+o/IBfgKlWE8Qjo0ugwsUUlt99kaeFmi4LQsQd87IP4aOg64o81l5gyuyy1LJP2afzIpqaSJqgPlpL6PUXpOWKUYAxgg0PEpv/+mz2wSgGkMKxaq67V6H2e6aYWCSZ7GQqsW7RxqwCDVQhIKyLWE8vv7pkrG5BdTWRdMMBjtBLAd9JiP5V+BGa66eLpYDU68FPxrDB83jpvj4upmqkhwH/rfdgrTpyX9LHJTAO2GgDyNsVckmkvneLwY2bUe9H1zO/sE7AS78Byg7A==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BLAPR03MB5377.namprd03.prod.outlook.com (2603:10b6:208:285::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 02:13:13 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8678.027; Tue, 29 Apr 2025
 02:13:12 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] drivers: spi: Fix data loss issue in QSPI
Thread-Topic: [PATCH] drivers: spi: Fix data loss issue in QSPI
Thread-Index: AQHbj0THXUI6J/VMfU20Kg4HUeFwYLO6OcVw
Date: Tue, 29 Apr 2025 02:13:12 +0000
Message-ID: <LV8PR03MB81377F9CA3F2967DADDEFA74A7802@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250307093826.10882-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250307093826.10882-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|BLAPR03MB5377:EE_
x-ms-office365-filtering-correlation-id: d395d9bf-ab89-43e3-d753-08dd86c364e7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kSZnBpe4/XuPypuzux5eKWNFXbTIcaHjaOC2YhZSOyFM5Xsa7DQVu/NG8m4z?=
 =?us-ascii?Q?82lePRbe9xpfRuv49ddCJ2+jkmTdkMB3wwh8M7PgWMwJ9aHmdeyye/Ftlbpz?=
 =?us-ascii?Q?7+kIrZfiWUoAFGk7aqHsHB7r+P+TydVS2JbH7GGtKxeoPjmAKBz24p89BV6b?=
 =?us-ascii?Q?I1tbU2anY3rfbL+0Lzl/3a/9chDOm6EfgfCAuihI1Gi0LMavpQmq2si8kHa8?=
 =?us-ascii?Q?DpEp0vSlf3APsQ97X7GnYcAWoKFW4ajfyMPjKBUY4F0Vznjier8B/lQFZjC8?=
 =?us-ascii?Q?bimf8jE54CYo2arll/zUzFfcR+tHAcnThmpr9X+ZMn+zfIdXb8F6Yuj+32qS?=
 =?us-ascii?Q?P5czwQJfrqNSo2FkgLRui0LKhwepNeCd+RvjqQG1CziVES3yRwRMYrTu49Yn?=
 =?us-ascii?Q?zjaD5YbcwsPpti2R4ZSeTkiKHlzXIfuJCZFA7Duki4ibKWfr8WOlttNx/5/v?=
 =?us-ascii?Q?xgbg0H9vPAwMPMYiaQ34MqPDDr5gNriTivTMrtP1v+EIMf7Lykx/aSyREFnj?=
 =?us-ascii?Q?0hZZb9ZkOhNBo3krac5ir1tG6HCvde4JrVIuYsiKsfH7r3IvBv7Vcz1dkVGb?=
 =?us-ascii?Q?fv10syK+TLfXZRYtFkudZ1Po9WDB87RZ1tIr+BgWuAXDrlSpw73Tz74lXvY1?=
 =?us-ascii?Q?IudQaEp+GMQzgvoyAFLjoxUvLhB7Y+azcTNSK7akxKduXsJL//MZi4JRN44E?=
 =?us-ascii?Q?M4ES9SFYCen2hcssXGT13+a7IjMCRzI3AV6rLIsPf8ZsRHgGSF9BItMUzI0F?=
 =?us-ascii?Q?pLb538p8rJCBx5pGtAsCZlREk/UzafdTd2lRUTnwI6IXcEVj2EZIMjZP1VyX?=
 =?us-ascii?Q?96CyMNt8+jtx40O3OMYc66Da8S5svD0y0fHPpAVj75F3LSMrB+nU5QtZrGcK?=
 =?us-ascii?Q?UyBnyEYh2hCjVNqdWYw56p6L3tGl1+MiLoLrvIAsB9yi+dRpJQsmVRuF79IX?=
 =?us-ascii?Q?kg9A5qakQjgoyScRVFTF9nM261LA93vXH7ue5HgjWYVn1PY+wDwbFaaR5vob?=
 =?us-ascii?Q?dc7JNGQ9qgJMvH0aZjhAHMCjQPr7TNwiZ0fiqCkfXO/x7Q/lwCwcrDheSGT9?=
 =?us-ascii?Q?1WnW+Y46V31T69/VEznFza2xl+6eeiZxoQZQS19LivyhoJiEqtj4S5xiJ2OJ?=
 =?us-ascii?Q?ixVok4UgOb8+npqJpvRgoFJqEWKdhnNBUOyB44kFFVEo+d3VmmKK8Gj5sE79?=
 =?us-ascii?Q?tfgWq0g5JR7rnyEjo+/9PlxspPDop84XI/ohnqUxjChW7qkzWiyHGtTHHz2v?=
 =?us-ascii?Q?uJ4IS+5trTVBLfR9IfWjLMXJQqyBqiZi6tq6cRLKKvbwK8WQR6xFJZm9a0N7?=
 =?us-ascii?Q?Kbhwho6c10W5Wyin98IXQGaWQNF8lM3GP0dQiaKv6P7dK+mMaCz6UH3SMthr?=
 =?us-ascii?Q?scH6TZM/bh03ac//tK/hvtocLXJGgfvvXEdxvOTcceXFa9klBRwTrn/9SfuM?=
 =?us-ascii?Q?6o63/HlA6EG0IQRpb7iGtVPHPjc/xp+NXyIUImP0n06e+BVYmfdK+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jxL3JmL0j/42cFMBBuGAlpmjWOrFryhaCFEmSHZ/B1lffT3V1J/8KtK8ym6v?=
 =?us-ascii?Q?1xQ2GIO+pzU6q3Uf9D3rr+XUhfTx19a/t++MpFekXEOKKRnXKOGx1b72+6WM?=
 =?us-ascii?Q?oShOpwOLkdJmoaj2f/X7r95hH5tOubBKBYbCs7bQUn8531fL4vuuevy1bkDy?=
 =?us-ascii?Q?KyMqHhislR/TAzhJyUZViOpOnEc9UWX2bwRAOLzmffRhg5ee4I9I48quAB+Z?=
 =?us-ascii?Q?QscjLFzudE2qBkvI8R3VstNTUYMUX3yfsRD6SBowqG1fY4/OEi6zhRf+3fw5?=
 =?us-ascii?Q?10JoJV98PTO+RTw//tS9IQh2sqhtLY92chMK3ci6DvkBJbQkDsEBcK1fZ2O5?=
 =?us-ascii?Q?/fypBNV5HZxilc143xKqKGUgMZM5ZhTt5FOj0Aify1h8gOduUBYuMTG1o7k8?=
 =?us-ascii?Q?kRMzuG+O2gd5Ia5mcipNlG4hy50WwRcO/4ZJRVVAs4y2dXQFF342N73qTUfH?=
 =?us-ascii?Q?8fytoiJFdDa8YcvzlTVg5okUqO192+A8/gQ0yG7IarQdhAWwiSj4TUslCB9q?=
 =?us-ascii?Q?1PvT4XZplplVfaga+wUKcB6PVkm+VdtHLbrRH/ZydNZ8yRbpNv+K++8QwdzX?=
 =?us-ascii?Q?H2QP6af4isthmM9vsFqUxMnRsue14VTTg8yJoU63uFdDrxAyXw6mL2Dy1BWs?=
 =?us-ascii?Q?WxrBU9F+sRQ4V1ktiiHI5KaA3k2BfjCwUv+2wwlrxtsoMD+yP+NJvrAo7mA0?=
 =?us-ascii?Q?XVCb288u2I7Sjc127qxq6wjOpPA8JK4dbybjqzwo1iv7PnUvcY8wdvu0y7vW?=
 =?us-ascii?Q?CbllkQ6et6qBfQLe4spBb4Rf8p/SYfML5Sca3T6l6qlVa+ivXPgQFetR5w2i?=
 =?us-ascii?Q?kTNJ0djRGtLIdWgVvn5cTW4YpcJCx44PygOSSdsBNRDl4GvOK7KNwxeeIEfP?=
 =?us-ascii?Q?3XsQYM5yyPtK6ALCW0HtGcBZCCH/KjDAiFo+lQ0J4Ovle+zMQ8l51jYbTjH2?=
 =?us-ascii?Q?pcndqcS7BtZ+sHoS6W+nsTC46w0SOq8FHj2wtG1wtF6S2O1kPF499Jx2qFSU?=
 =?us-ascii?Q?vbeOoYS1/1kDR9dfx7T5/cTCrFrRpZ91qSnKNn/19nx+f+aDrx2ANVXeioDn?=
 =?us-ascii?Q?yBdpsJMuViXgb2uQTDV0Re3TOOwsffZTauW2gUazB4zEeMlKEjfoqexROBHi?=
 =?us-ascii?Q?0MoO56nanLgq7E9gsQuiJYcqmmAikgnPNP0SdNMK7Q5GiwzcJtqChC9ZcPWC?=
 =?us-ascii?Q?e6fjeYSfz2T3ksSfUJ/eIyy878XmVYOjiFlkZB612bDfgXNpkEzJupnRpW9J?=
 =?us-ascii?Q?H5JiyvAw1yHsZOH0v174G/STGMhE93KXWXtWWLz2A+NBNUqUuypjB0Fec1ft?=
 =?us-ascii?Q?ijWRLWWOYZxWobUJcpBpSb5ssFrpCkseLnpHqJxsg6e/0aY1a9KU/90GTto8?=
 =?us-ascii?Q?oNZrjm+iwH66rI3A1Uf6iI6HLSZ+Wmi2bZwIKXtcMTW8+4SgN3D9ENlqLrmp?=
 =?us-ascii?Q?EdKq6E+gMn8+mQBCAqCi23ANpplfI7NWCXpjZDyxoSIXpdLuC/wCZSsMRvpO?=
 =?us-ascii?Q?IOMLHL43c8CSCzCJ9CD/npneGYnDg3d2kSu5Jj1kz8WSGjOcyblFwtPcQpcg?=
 =?us-ascii?Q?gL5wfii6OKlv9pE4LnfDN7oOIwqvFm/XiWXDtK4L?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d395d9bf-ab89-43e3-d753-08dd86c364e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 02:13:12.5983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaUfVUD/3Jjy3fsQH65kosXoOLv4+zTCQA00Rz1Gk/bJ8HTooLC/+qH36jVHQrpQsPtQ+XeHGfkQECNt/wigCShDSvg10MfbH+Vmk6dKvGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5377
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



> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Friday, March 7, 2025 5:38 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Jagan Teki <jagan@amarulasolutions.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] drivers: spi: Fix data loss issue in QSPI
>=20
> QSPI driver performs chip select operation before every read/write access=
.
> During this operation, driver needs to enable and disable the QSPI contro=
ller.
> This may cause data loss if there is inadvertent halting of any ongoing
> read/write operation. To avoid this scenario, waiting for the QSPI status=
 to be
> idle before next read/write operation is implemented.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/spi/cadence_qspi_apb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/spi/cadence_qspi_apb.c
> b/drivers/spi/cadence_qspi_apb.c index f2f69cf9f1..b579699d2e 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -747,6 +747,10 @@ cadence_qspi_apb_indirect_read_execute(struct
> cadence_spi_priv *priv,
>  		goto failrd;
>  	}
>=20
> +	/* Wait til QSPI is idle */
> +	if (!cadence_qspi_wait_idle(priv->regbase))
> +		return -EIO;
> +
>  	return 0;
>=20
>  failrd:
> @@ -914,6 +918,11 @@ cadence_qspi_apb_indirect_write_execute(struct
> cadence_spi_priv *priv,
>=20
>  	if (bounce_buf)
>  		free(bounce_buf);
> +
> +	/* Wait til QSPI is idle */
> +	if (!cadence_qspi_wait_idle(priv->regbase))
> +		return -EIO;
> +
>  	return 0;
>=20
>  failwr:
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>

Best regards,
Tien Fong

