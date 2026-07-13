Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3476EC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 10:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2DF84A92;
	Mon, 13 Jul 2026 12:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NlHoNodN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B48FD84A95; Mon, 13 Jul 2026 12:21:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D3E84A91
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 12:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukiSJ8WbeVm/G/t6YBYaF1rA491SMraNUdN4yH5y7FZ/droCcTzodpoIzOjMT99nkSYSxOlhi+Rd2v1yNp5j8OxzMbxjJ33TD/TsRevw32ruMsOcS93f7MPdnf3bjUtFi8pQsxPAyJoPy1+GqtOLT4EnebjJmho4BIyazYXv/K80EiFTHEIorFvlduhtV2LwCR9byjMCB4HaNtKwIpmAnThrFtOl2fDYnlRyTWE41ANgv/NOuFpXUfXh3FB6V0zjuN7Gg0+6c8CNis4MAfsuCD9chOOo7OhZWqFiggJ+oSpGtVPtUJmEPIjc5X6/z78xuwn7kH/KeU4gGddXQIQ2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izF8aE88MpLcuBNX5WwzjJjfPsA1YC+zuuycb1PCtY8=;
 b=fkCLbALDwQyPNdznRMB3wsG/K7Hwwf7TLAImpn7fP55tp9O96AAKsgQAaxyhWq4TY2S2gILKlBR3B9PQ9Z58CFSghjAztfRQwI+auXzdDjXyiq9FaqQvedhxWRi5PW02RPEL+TE8XYGxnRbJdGAFoVA0Lali3yTe68h89h/l7dDh7KGtTvIkCtfpFGm2Q8Fkz7UanMlOOg0lKa8lncSHD8HZwCwMzIw6NQb6SJliXwGGXKmOzTTZyKjiKT1P4R+0smBkS7jC4kp2oX1DspaqDFGAQOTu6sxjnKAQoHpQyM10LQ74v6bnRpzq17bX2+lcoIripW0Etj+lZRD4JyTtlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izF8aE88MpLcuBNX5WwzjJjfPsA1YC+zuuycb1PCtY8=;
 b=NlHoNodNaSDstrtKaIB9fdVurKznm8/HXyW4iwQ4lTNV/vB768xjMHwLANopJhzIDRKL2Lf50K01c9W70TKGZ1mfXR76B+or0AR6vt3B3IYSK2DFFBedvEPWfWiolJah4Mfnp+gojhqywc5PruH+AdeKjqishM4WY/1AcWdc7ys/Huo7VgIXacMfqOkT/ZB9yaEDn9Rkx1t9mhOgW0AOPvLaE2i5yU7WgHQ6fShjOLjogVmv5XlsvJ3sBfeCrPmnFXMfHonDUk0mL5mfh1aoDvlxyA05mjxApmI4RAdUOk2aZEnE5X1kltyItefo58TgYywF3BuQ49yK2fo2HUfGXA==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM0PR04MB7060.eurprd04.prod.outlook.com (2603:10a6:208:196::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 10:21:52 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:21:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, Judith Mendez
 <jm@ti.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "marex@denx.de" <marex@denx.de>, "tien.fong.chee@altera.com"
 <tien.fong.chee@altera.com>
Subject: RE: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
Thread-Topic: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
Thread-Index: AQHcQsupCkyVJUWKgEqUQ22vAKSmG7YRq5mAgAAhe4CAEgyngIACv8oAgA+VNICANqRRgIAACd/A
Date: Mon, 13 Jul 2026 10:21:52 +0000
Message-ID: <MRWPR04MB12330469B22D00DACBD1546EE88FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
 <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
 <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
 <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
 <2571b1a0-9395-40e7-a85e-4204c7543d39@ti.com>
 <ec10eda7-a33d-44ab-b89e-46380fa289d7@altera.com>
In-Reply-To: <ec10eda7-a33d-44ab-b89e-46380fa289d7@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|AM0PR04MB7060:EE_
x-ms-office365-filtering-correlation-id: ae38903d-383f-4998-bdcf-08dee0c88ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|376014|23010399003|366016|1800799024|38070700021|56012099006|4143699003|11063799006|5023799004|22082099003|18002099003;
x-microsoft-antispam-message-info: dVqtDu65h01EpAzPimlwTrr9Oznm9dHc6dxYDRcnoI+7TN9bRlCL/cyEsnL3UuxBtn+lzG/lnyqkTZZtag0Zncy0I9WYcjsxTAlNUtHardL11HDPCBAjycsemZMWK/+yOrDNbs/gBONFhatdy1sio9doQ3Y3MyXDMA3EvmBBA8/5OxMPoppupzDr92bhtJMybz0D0S8aY8al6YLcxXVH6x2dlc9C9EdCW9ktX99NJ6C8yVkvJyzmODnsCCWcKmwyl+0HlOHHb2YrS20oA7wkHJY/surk+tFElcPOjfgU+zViCXcS5jDBa4OzyuguKwPuJCoufmWhFe5QOVw7oI52Cu1iyO4egFGluC7gEyrUWNpxfPoR7XhzeJwasJo1mv6Bj8pyyNJlLwH5p7p773VRK9M8d/90Q3NdjogV5ZIkVQsj5o3WuPKVkEaCJRStFEaFJiX5TLAQVx3pGG0GQL2hyiAkRBDhqJo0qVBHo78bemG47Yvwz4JxT3Mf8xhndIHzIOCSmzSF2+Yx3yeEje93I1m7SyGePXgVqA4+bTJrzVY3rFuI360MGB/QrXug7rtYKxV7mFRh9VASxVeA2eixNZtT5ff9G+0zL7vr77hE/xNf5z1jLF6Lyns5BxksE+YKt/A+lkSeIkvsvtNLhKjpCjAnSPr5cfDsRQKZ8R9L3LGWxWDvcCuSnew1xY8NZBV+ayk2fxVHWVf6x7rI++v8uF0kQhZ+vgqfbItOZPFQ4ek=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2fi4xhainsFeXQxrxSuBsZr25NQJ5gAJEbX+DtDiYxyrNrLc6jtRI8nZOHn?=
 =?us-ascii?Q?8GdV0hR82fl1e/LbSlJV8+Bf4l9UtofwiX5utkng5obajSVWIgTZbjllxW+B?=
 =?us-ascii?Q?yKHIAL1svWd1GFq6TZAbW7sha69xVaaxqjLqnVoxalrMBlKhdxNgJCt6q7ns?=
 =?us-ascii?Q?q5kbgQeIGsd1s3MVsR+WxaVpl6eh1pDvEvg1G5MSGbwxPr19Emus6Ed3CwpY?=
 =?us-ascii?Q?cesqOjds5WrBdbMQZwFN+Lw47U8SI0UfSXpmiiwsoRpyrm/lyVi47HkOV8z/?=
 =?us-ascii?Q?LKfxzDJtZmuW2Q/zB4zzVooT48OS1z2+Gr6bqi+PdAAqPEPNkO/xYT0nu2J6?=
 =?us-ascii?Q?yg/ujKk7QddnIQVHPlve5317Ke5s3jJZSRD6MD85Xll+J9+nGRiiOnR9C6Sr?=
 =?us-ascii?Q?GUAIeEA/9cW0a6mquV4yHv952gnGo00m0yKS9LQjO7gt4jx8mNZZH5DN62+S?=
 =?us-ascii?Q?aStqAxKWwfMhvI2RRRpqhFnlGkp+l91A9KDf+oLZm560nEDKvfdX/oZIU1Xa?=
 =?us-ascii?Q?2/mYIdyIACc/Ojz/q5j/ux+uVPOnMtfmEmsowRuwIAlatMhWnDdZ7Awrx6b3?=
 =?us-ascii?Q?N52t9VopsLgt7ey+7dZGZAipEEwrb3Yh51cEWW4Yxa8YDgYNbPFdIOqLst73?=
 =?us-ascii?Q?cWOKqtInW0J3YqK77QWekh7vdOa/UWwfJgSw4q2ioXBqZOCtgJh6ZBFxVbjG?=
 =?us-ascii?Q?8hAcDNFAL2NFr9QUKXN1SluL/rQfKX6X6ZFS2qDWc+tu5BEZu1gP9NVpFsOc?=
 =?us-ascii?Q?nT4sXYAe9DgomT+cclGzbYBZ2LoVDTStNPN4kwfmEYX/jIpO+UbZZcDD8iJQ?=
 =?us-ascii?Q?REWg3amJ8esomi0x/vIqdUUclkcOkG7G1Sez9+51owpUYxjbBOw/v7ZqIuM4?=
 =?us-ascii?Q?ifsp8HCySGkt1zHwg+vhCwJXcCoQGGDY8Zhi3S34tnAdxzRvPPRm0ofR8mqp?=
 =?us-ascii?Q?BJHFUVif2JucYIn92RyC9jDlGZl/xgJoG9v0i+FiCUIjStjuUQlsUEseIz0o?=
 =?us-ascii?Q?EdGXjQ4PDgPiiywbDOj+uFbR9NTiIcNBiy+7vOvwlKwfechmuIFgv7ZR5Ri3?=
 =?us-ascii?Q?iALRjnUWHK+ytc44pnkA/vNbQdklV1IwUO3qqONckVuc1CKzOzZMBYjSjqVy?=
 =?us-ascii?Q?yodOmGPtlDJoCufxsfWfNV3WHyqmzy8duhCSL26zzTKQUao1NVaGrfXWO8mu?=
 =?us-ascii?Q?Ia9rK481+deXJASG3GTkZG1V2bGXeQKRG+3VzQh839NTMmgiQTS6PA2sxbGZ?=
 =?us-ascii?Q?PN/8gNOnV/VkwfJShmyCcr8YYTDgbszTf990pe6L4ti7oNBrVwKAqs2TB00/?=
 =?us-ascii?Q?1J9d7Qam/Zv0BUGm39sON9WZOLwQw8wuSlXcPtoxxx15r4sxehoPxcn95iu2?=
 =?us-ascii?Q?io7p5cV5DK6NBu7XJROAGJXD5wtlHlA25cxt3ha8+lvFMm1dR7nfZDIor2a5?=
 =?us-ascii?Q?ssPQ6UyzINZrBIscjtRGfFurSE8k7mt7uEI8EXUTkJ+A4BRtOIUFp+YJr6/v?=
 =?us-ascii?Q?8UaVS7YnDJ56qjJjN/KHDLwd8M2VrNwxr0QpHq0iFcORAf/0uUtSopn3hItP?=
 =?us-ascii?Q?dwf3y+rZvkv67lSjXcCanfwlnZByGUkMRVPAfJqNsEYkIJQx2OW27iALRQPB?=
 =?us-ascii?Q?zufNqycR9yxGn+7jDL3LqrdUeym7QGBzHw5kNZ7pVBa1/1XCC16NSzlxjXQH?=
 =?us-ascii?Q?Gtbit4ymkGAVK+TtM3/0qu32Fge8RgRDL6K1um06gRv4bfcYcQat2aG0x7SW?=
 =?us-ascii?Q?en5AZqFzekRrLgvIGm5GkdpHXOA2MPN1gvbw3AhK4zie7dPrw57b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae38903d-383f-4998-bdcf-08dee0c88ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 10:21:52.6925 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ycrskeg/S1d+8BvJUDdTugz9SCAkDhNSymFLopCfptrL6/22WJ2bd1vUDXzIlxeYWJK4rnfy+jodZo+Kd6c32g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7060
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

Hi Tanmay,

> Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without
> power cycle
>=20
....
>=20
> I worked with Judith Mendez to get to the bottom of this - she shared
> logs from the AM65 IDK board and we went back and forth analyzing
> them, which pointed to a board-level power sequencing problem on
> AM65x rather than an issue with this patch. In her words:
> "So it is truly a power issue, I have a patch to fix the issue on am65x.
> There is nothing wrong with your patch, coincidentally my power issue
> caused am65x to fall into a weird state and your commit caught that.
> So actually, thanks. I can now send my proper fix to the u-boot mailing
> list."
>=20
> So this patch did not introduce a regression - it actually helped uncover
> a latent power-sequencing issue on the AM65x board that was
> independent of this change. Judith will be sending a separate fix for the
> AM65x board issue.

Thanks for the updating.

Thanks,
Peng

>=20
> I'd consider this matter closed with respect to this patch. Thanks Judith
> for digging into this and confirming the root cause.
>=20
> Regards,
> Tanmay

