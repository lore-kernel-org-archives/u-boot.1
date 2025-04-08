Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D71C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE0EC83429;
	Tue,  8 Apr 2025 16:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FhVmThBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41BA4833E8; Tue,  8 Apr 2025 12:08:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DE9833D1
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 12:08:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gaurav.jain@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAXykL5sA8Jdnx6HoR1Zagu7S9dA0GrUZrktWZ112SR1WeZ8aj7KVcfMT1vqcGlMXGjOP9X+ZQX043ABZ0g7IPn7fx5UP1QsMigD4d7cHi3rGATlx2O8+cRTNelYxyKdEulCAW890p2mSAskxBXeJUbgWKKinkarRCtoNrVLs8acrOsHjAlod0KjaX2taBbuQgUVcb7bOVbzrwa0Y0P2eXOG5wQjZRFJIus+WbjncUxbIf5q2wPnzgStestGeFhT0/Gawr+EfEHzVCoqbRbYQKnx6yy1QhLNQ5PHsf4bQCv8eOd9uIXwVfLAs7BoiGfhF18r3T1t6wbx8ZzlT4OOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqDRkURPAkUkNJBsqvUoSf3N6nWvBEXZCyro75DNQyU=;
 b=GXhTqUyOWMOGtwqglJqgmyozGfG0IyfFD+eUVaRViuIUAuahCvgWQhDsb9M9xHVO9wHhcMGVagsSHOnqRpni0T4y9SD1hVMK5511NGQp9wfXby00oNPsrzhnHS3ptrpliXLskJKzeiFFqJTh3/zykyxtIFvYdCOaWdIUtGuL8myf0cOHH0OpYKs6tb3Dai10NSXZ/LFlQ20bxWKDyjXIGvy8+9hvfOXwNfuw1mRpV6Hqd7Sck5WXlVudAjOVP62J86mgz0UpON6GxlZeWwYzjcjbELSFCzBv7TuftQdfLvMehF2KvYiV4vRihqC2R5y7D1kRW5LCigN4bfNGUHBJzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqDRkURPAkUkNJBsqvUoSf3N6nWvBEXZCyro75DNQyU=;
 b=FhVmThBPnmI3ZsRtJX/EFzyt1Cch1PQOV/O8OH9Sf2Z4BK3Fanb48d8U1iPPA/Fq/HoGtaU9hPyLNMeTfgqUwJIscA6YAGclN5DF53KUvcLIvF2J2BsGb8Se5XWivKdjfKQkSP9pIRgag+FrYzULbnMuKjCrZOxMsIbXiDmjiUrBJm4SfxDohAkNB4gSxaQcCX24mUwII2I5s+3aGBHqlOfO8GAMtkFZEFDm2bB2mzaNj4FyDDxAHRJdQmrIQ0yWzN3QEPYz2nuR00OGQ4J9j3MaWTcabeHVkTyyM1e9E9sBVIV5zdiCJ8896LdNTWiSwfvGhWW/WT78/neFIKOzpQ==
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com (2603:10a6:10:244::6)
 by AS8PR04MB8546.eurprd04.prod.outlook.com (2603:10a6:20b:421::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 10:08:41 +0000
Received: from DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637]) by DB9PR04MB8409.eurprd04.prod.outlook.com
 ([fe80::1436:d8ba:25b8:1637%4]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 10:08:41 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: =?iso-8859-2?Q?Pawe=B3_Kochanowski?= <pkochanowski@sii.pl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, =?iso-8859-2?Q?Pawe=B3_Kochanowski?=
 <pkochanowski@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta
 <horia.geanta@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vaBjTvT2QpjEqnwOdEJdye7rOZjCgw
Date: Tue, 8 Apr 2025 10:08:41 +0000
Message-ID: <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
In-Reply-To: <20250407124714.177059-1-pkochanowski@sii.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8409:EE_|AS8PR04MB8546:EE_
x-ms-office365-filtering-correlation-id: 26d90e74-7e31-4bad-ff82-08dd768556c4
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-2?Q?p/BND+K0WnauDalJCpjo8GdxzAFA/rN2lxub2ccm2D92/UwaTDaONvnJPi?=
 =?iso-8859-2?Q?EvUjPxXXg16spU0f5QjDgp3PU6BrJ00CarNk87FiYxXQGiyFEeaeN0Kkgl?=
 =?iso-8859-2?Q?nboez4HvJbwq9i5bp26kZx7JNAfzZC9rzV8p6KAV2Za2lb6HQKby55Khu/?=
 =?iso-8859-2?Q?wTBw2VxDg9U27qG4qIMg8eLsXnXhy7NK5QB9pOvkQ4A2RecdBAJAetC9Hz?=
 =?iso-8859-2?Q?zpwgATX/kV1enJeDcGvvy4ueDjR/XKsPYyuWuE4/MdfRYK1UMl2WX0o10A?=
 =?iso-8859-2?Q?2zbJnUFmDKN3K6tciWmlmjbhp/u5tbTvaenQ4ilKJcvgQvRpNelNsn1WJC?=
 =?iso-8859-2?Q?BnnsrhHM7PtYrSBYCitM3B47G8pBtpwstQGcoGhQB7ch2cFLA2n+bjGcVW?=
 =?iso-8859-2?Q?nIga0sYn8biGXeTi/gfVJALJVJxvGqYRp36C5KJ7wPvsiQJwbP861OQMLE?=
 =?iso-8859-2?Q?179Ex5/2itRq5+/kls1DWU48DcHKlWl676uerpx6LQe9V5s+FbWmSZliCL?=
 =?iso-8859-2?Q?OWXJfAltcztVBOpLpLBNBBtOomdilNkMXHYhfpoP6lJTHyr3raIluJX4Jr?=
 =?iso-8859-2?Q?8+qodhk2i/iEmpRL1hPs0xCoiJs1Ciayo+40wc7sXUsCgNIPPkquoRhDF2?=
 =?iso-8859-2?Q?uFlaZkcX/ITtU2tJ5HOtMi7bMLtwr09pPWl6OYSc5/7po+WGe5j9qF95Mt?=
 =?iso-8859-2?Q?j4bqV3ih6IEoq8fZ++stDSFgBwnUi2Okb/8R7PnUPsTkLn9srbd05+wIGZ?=
 =?iso-8859-2?Q?LHWnckPK3+a5ysq9eeqBkMjl8Nr7F5M505vkp63SoOvxHpRG1PshCkTE8A?=
 =?iso-8859-2?Q?tg1fsdu+2M8PDyIG08HEKysHKVBB/M7QUyksfD4x+iJSdutUzT0UAOySFC?=
 =?iso-8859-2?Q?SI2PMEdVHuAQt2EQyAhtiheMkjt9aDUx9Qyp0JRixQtZvMS0zQovI05M/3?=
 =?iso-8859-2?Q?2MXClMBeV8GwXNjGEQnX7WcWwuoPM2AnY0S36ynS8IsCN0UaJhLP/wZt8M?=
 =?iso-8859-2?Q?npKfjbP9qlIEIrx7kIBgWqHqn9x6fqLWg7BnO9Z609HRJU6h10Px+xhZMI?=
 =?iso-8859-2?Q?hnpXpELpJlAia1TjnngFXcO4i7QNsks49sgoDlLf3pCn9B3KR3nbfudi1k?=
 =?iso-8859-2?Q?AvIJTmvZTQLWcR2w0ag72k8dxNMtEZWxbcFOrRalZE/lxnRQcyhZ63zM2P?=
 =?iso-8859-2?Q?wLLqFyFpojqKfQWEMpQ7XMgUzNc1CTbgljLXIueNqpwrhH5sqINtGyRNqB?=
 =?iso-8859-2?Q?l2HdJqQV3TEq5qhf84cJ/Nd1r4IbjoqWf4CLckoPtSX+bi9qo7xqTxlyRG?=
 =?iso-8859-2?Q?O8cCQ9jkJSWhopsEdHaJWzzHMb1yCKz4EQgrX5cwj5zEyO7gA+ou/2NKmo?=
 =?iso-8859-2?Q?9OZ9yp0UlPnqPU4OwjlBd0VwWnWRbGd7UNAz4H8ZNiLrmlP7KVbkGbxQ69?=
 =?iso-8859-2?Q?1SrqIC6fuh8l/94W1AzwqO+1QUxVRBNip7ACYNQSkxK2TGfeTir1PgHp7t?=
 =?iso-8859-2?Q?UgZqo8X2Jgjb5QfFgCc2AH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8409.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?RDyi6+90Os+q9/G6svtsrvfacnli9eXEHhEKF+AQpLEiobpW2P2Nq94wqG?=
 =?iso-8859-2?Q?1UNJgoJhy0OZMWQZpKyrYTjmF6J9YpMrDjkMHTcI2Z3gA2pecJWlpmmPts?=
 =?iso-8859-2?Q?bBmn9cgwDPWGKlTjSr0WqOEq0cRhCQzAxBuCNuR6X+4+QbHYte4YDHs039?=
 =?iso-8859-2?Q?LMNlnemL1QWiDQUe4HN1EZT2WvcdWY66jwZRAIul3lkQaFAwqv8Itbqf1K?=
 =?iso-8859-2?Q?vhX8Pu3CPj0HtzMIJxvorphvCBvJnQyPOke/cE9qOjBxCQ6r+heu80cl1S?=
 =?iso-8859-2?Q?VW/OgBmsHm4ljLLxwmbaqcFEt0CdZ7bmYu4tKh188twcck5ldHOdhP+k44?=
 =?iso-8859-2?Q?cNJbDpfR2cXvRuVOxwv/l8jMSr7xbzDsomq0UGivpWsBNk1ZVSKieYH8BJ?=
 =?iso-8859-2?Q?YIySMRwI8DqOH6Ux9EcK8qGqJR03okYqu2EkDEuGN9a2rH/Fo6Yeew5fbb?=
 =?iso-8859-2?Q?hxMgEyQroftxraMuHk1f1u6/tZMXGbTRjq1HRnJ//8SbM31rIKzGORNwYA?=
 =?iso-8859-2?Q?8WzQZjvGYK1lXjF9HY+2Z7l+ZUIxUnFOAsJvkiYoagTQhLI0+KWaHJvD3m?=
 =?iso-8859-2?Q?xxN6OCYL8ggNdi+XprvtEE/tXzTUafM0/TKFkJzJfS1ZxgZ/9tiPd+0q+q?=
 =?iso-8859-2?Q?K179PNpfdCnBe6wpNUzbEqrvGEpRGbKacBD0Cw8RDzG1BUFJydBovenxlw?=
 =?iso-8859-2?Q?/HrQRCbvRkdvjDs2Isgth+pmlirFdz/6+79uL7EYgbSxNX+6a8l/wGztA4?=
 =?iso-8859-2?Q?Xq9hPvlIL9m4JhqSquCpDba7RPvll2+xGWyP1JDp4tWBFC44mXdp88uUfH?=
 =?iso-8859-2?Q?fm3Om0+D61xixwbajfWjfhGjYGZK/Z7xRtuLPtqJVLluYIG2DjXXupj+/2?=
 =?iso-8859-2?Q?6ojlWmGwyCoC+Li+VM3VjPO+FpmmM9PC+bPJGd0QOAkZ+RoabJf3MDTr2P?=
 =?iso-8859-2?Q?PMt5aSAzm5i0yipDVTB4VfVzj6L/LpZRYPHrg6yy6a5GB4fPhFXd4Mjo+o?=
 =?iso-8859-2?Q?c04hcrOqh4DVsp88Q0LAcYjFUW0Xv2gqUrBeVbxKnfe0LduHxto9dyAucg?=
 =?iso-8859-2?Q?9FymrEmemDakervoFXuC7Jib5W/EewBvG5N51EDMu+ygVzpHcP6cYRllVR?=
 =?iso-8859-2?Q?IiPiGP0E/6OdN201xbmZndWcgz1rlUdX1s4qJt775MsV1tGsyJPyk+CBhi?=
 =?iso-8859-2?Q?WsmUcQZXofCjb5IhGXSrtwCh0d3WGtJe1nIIVkLzZP30gAx1c9iQ3Jf2kJ?=
 =?iso-8859-2?Q?ArzxGmlVfGHb3KFjykJMfET6xBvJfjRtIMD5lm9ICW+4JhQZliW0HSlG4Y?=
 =?iso-8859-2?Q?eDD8SO1kUSdzqx92CiD0D72UDvDGGDNM++ZqTBQ75RK2wkkxD4GEKiyR7J?=
 =?iso-8859-2?Q?K30u4rCJHiwka52LxEG+JU7RtAgY6IfB5X6rsRDG0dHRBDX7Mvz9Tdr+vO?=
 =?iso-8859-2?Q?hImj/IQYZ3d+cbWQhJ0KQ5dXN1/Ic/NhTuYyjP3DD0TF0cobVeVl6RD1Ks?=
 =?iso-8859-2?Q?iSw60iYeWuKi57YfXvjg+/eLN5OA1pyN1Pb28xjlso2Prn37M6dReG0+r9?=
 =?iso-8859-2?Q?kIO7MvROfh9ST3FjqQ08PnQLIo4AtMetfloEWU2KqNcumz3PMFxEmCVAtk?=
 =?iso-8859-2?Q?/iF9bzegz6AUJO9LJ/orB4geZEKqV1Lfck?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8409.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d90e74-7e31-4bad-ff82-08dd768556c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 10:08:41.4381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06FKpNfNDN41eTKgsghXjKWfowz4Pwm+1Afy7jBahg5pzZAacWLlLwd2hA331aDRNHRq7BVjSPMWyzjrlLgRPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8546
X-Mailman-Approved-At: Tue, 08 Apr 2025 16:21:49 +0200
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

Can you explain more details about this issue. Where it is being modified i=
n run_descriptor_jr() ?
Regards
Gaurav

> -----Original Message-----
> From: Pawel Kochanowski <pkochanowski@sii.pl>
> Sent: Monday, April 7, 2025 6:17 PM
> To: u-boot@lists.denx.de
> Cc: Priyanka Jain <priyanka.jain@nxp.com>; Gaurav Jain <gaurav.jain@nxp.c=
om>;
> Gabriel Nesteruk <gnesteruk@sii.pl>; Pawe=B3 Kochanowski <pkochanowski@si=
i.pl>
> Subject: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths great=
er than 16
> bytes
>=20
> [You don't often get email from pkochanowski@sii.pl. Learn why this is im=
portant
> at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or opening
> attachments. When in doubt, report the message using the 'Report this ema=
il'
> button
>=20
>=20
> From: Gabriel Nesteruk <gnesteruk@sii.pl>
>=20
> Reinitialize the descriptor for each RNG job, as it may be modified by
> run_descriptor_jr().
> Failing to do so can result in memory corruption when
> dm_rng_read() is called a second time on NXP devices with
> CONFIG_SYS_FSL_SEC_BE enabled.
>=20
> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> ---
>  drivers/crypto/fsl/rng.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c index
> 06364948052..440b26e3c94 100644
> --- a/drivers/crypto/fsl/rng.c
> +++ b/drivers/crypto/fsl/rng.c
> @@ -27,8 +27,14 @@ struct caam_rng_priv {  static int
> caam_rng_read_one(struct caam_rng_priv *priv)  {
>         int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE,
> ARCH_DMA_MINALIGN);
> +       ulong rng_desc_size =3D ALIGN(CAAM_RNG_DESC_LEN,
> + ARCH_DMA_MINALIGN);
>         int ret;
>=20
> +       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> +               CAAM_RNG_MAX_FIFO_STORE_SIZE);
> +       flush_dcache_range((unsigned long)priv->desc,
> +         (unsigned long)priv->desc + rng_desc_size);
> +
>         ret =3D run_descriptor_jr(priv->desc);
>         if (ret < 0)
>                 return -EIO;
> @@ -63,14 +69,6 @@ static int caam_rng_read(struct udevice *dev, void *da=
ta,
> size_t len)
>=20
>  static int caam_rng_probe(struct udevice *dev)  {
> -       struct caam_rng_priv *priv =3D dev_get_priv(dev);
> -       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
> -
> -       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
> -                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
> -       flush_dcache_range((unsigned long)priv->desc,
> -                          (unsigned long)priv->desc + size);
> -
>         return 0;
>  }
>=20
> --
> 2.43.0

