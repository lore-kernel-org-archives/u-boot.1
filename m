Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4382AC3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F4B888D7;
	Mon,  5 Aug 2024 16:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EOGFw14d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B302288908; Mon,  5 Aug 2024 16:04:32 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89510884AC
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFe2OG3++pNuZY+8FT48DqwQyiYJKALFSwzwDO8jX/KY38Oh4/nJftZZ4bGfsqo/htSdB0pF5iKO1qtuVjtKj+wQUFjHTrPek7/i23GZsHJW1U8xkW4Ze79cXxoPNJdZh6ymjx9rkYO4vXA+auGZjSNGozi1AIsDwxZE/8dg4+9f7JReshu45YyTofwaGcaklkktW2YQ/4KcGghyeR9Iye/QUDf04hNtueJbq+23mhGYObEJwhgX86GOx+jicc16TPK7SfufZYcy7cafAfePxNGKTUnohp3rvGX7W7Xg5zHafpIRDOtqI1p3CQfPuP18yJNH2T8AHzAyeD0AYuO4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPj/iKxAqXmaIYLvGglYn8WAmef3X76JF7J8Rm6EEV0=;
 b=rpjZWo1mrKIEn1/asi822jJ05er6wYreq276Yk6y4LZt3wsltVIc1J3fesiowZiStmHdSexo8OaEV5UQ4mtSwD9pSYxUdOJwpuRPcAsKZvATf1AaHbc2914fuVUsecYcOM7fQrdatVJBR5gBzgIaVdAsBbPuqdpajemx05KsU+8Ny4vBnFCWmcsEQXPX/p9vuKijBWpav5BMdg09pzIbYt46joPkZp5IZLh8JhEguOIYG7L+DP8uqzV1czc+mhGSzgSbPKbBOCi9PihW2VjP9SAnq1Xy3OxbjvNdGHyRzqpLeerlOUzvGKiOHCCLVaKhnedHWCceUUGBJKh0PNTLVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPj/iKxAqXmaIYLvGglYn8WAmef3X76JF7J8Rm6EEV0=;
 b=EOGFw14dgL9syJYGIFDb7ad2a+pq0mj7kcEJE325UcMqJcI9t+s3KsNxl2Mqb76+Y7FrTXN8N/Bl4ITqJ6vxpwJRalfuZs6CXC6rHwp0ACVZreePJHSUyesV5WCQpj8k+jCNPIVBxAPhZCYbgAy5PqB7QnCJBYP3s9hu3EuK0glwqyGr5HPtIxEIARm1hb0ZfGO1ihLbYmiztqO/RMw1nvMEzHQJYIn3JjcxcSgTrIMRsfB4/Y1suYU3U11Xg+ILTSkecVwqzJCDZyShY3ygFN6ybnRRic27bU9Rlzs7S55EAbXReUJgZJl8b2PooaWq3PMnbO3gy+TcyKBmdzBOIQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA1PR04MB10294.eurprd04.prod.outlook.com (2603:10a6:102:44d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:04:28 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 14:04:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gary Bisson <bisson.gary@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 2/5] tools: imx8image: add upower image support
Thread-Topic: [PATCH 2/5] tools: imx8image: add upower image support
Thread-Index: AQHa5zUXwsaShrb0j0GRRBp13Aq1w7IYsj7A
Date: Mon, 5 Aug 2024 14:04:28 +0000
Message-ID: <DB9PR04MB8461E0A6AC79589BE1D5DD9088BE2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-3-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-3-bisson.gary@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA1PR04MB10294:EE_
x-ms-office365-filtering-correlation-id: 4c9be59f-a81c-4718-f26b-08dcb557859d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NMxJtgBKxV5GYrf9uK+p7UgjUmd329ymucWJOC/P8vAVl4VkSXpdVMxBDgrU?=
 =?us-ascii?Q?c86RIam4V/VUAzSXaDx1bEPVHFwE4gqlG8RMhnCdNeVgGmJg8amElRYnq7fg?=
 =?us-ascii?Q?OnFpZlBJFR/7BAo4xkYzNQKGL+xVZbM7KIQkKtMZ5W5gDf+NbUvgs5jGn21b?=
 =?us-ascii?Q?KFKGny/Zeihv3OclGBBFl3jn+TkAfOZLXPc9O/Y4zgPsZi/EWG+36tdT9mha?=
 =?us-ascii?Q?XeCWTQvGu/RU5Nz9VFLG0D6x7Yg2Sk/ai/FOWQijh912F0Xk9ZxvP8X9mIlZ?=
 =?us-ascii?Q?7Ic+pxUxu1508S+aouDTefiume5DmPyx+WmHdH5LrlEI16c7vIAAF7fRZMhj?=
 =?us-ascii?Q?vHNuhNCuxznNWE08m3n7cGe15IVfkqyvT4k2sKoOgBRQNWJQAk7I3giltA77?=
 =?us-ascii?Q?moElvrjdBWBtRcvfVEjBG+S42qqllZMpYi43idPTlYP5aVa0+0/7HFqo/MKa?=
 =?us-ascii?Q?fUUvHUC/t15M0Mnzq0oVPG+N2vo9B1Lyh77srIj5PZbzR5DnmVHK1FKuYkHI?=
 =?us-ascii?Q?GWQ5rfjmwakzEGsh4L78jaoS++okqKsVldHyWKkWaxXK46BQS4+EuHPu4dTA?=
 =?us-ascii?Q?Y8sitSR89APjoECXt6a0m4EmI593+B5MuKMXbflVPKIM7wE+SkOOr2Y/zF3C?=
 =?us-ascii?Q?R8XOQZ8LKh/vSy555Ef+X7dfRciYNPl/9j7HxNFX+qEEnkwqwSXivV/BrcI5?=
 =?us-ascii?Q?yD12kGwiFz7FLaqpClWnWCsQ3h6BCPOsJF2LZ4/uG/GiPZrzEoII1Zd8RQOX?=
 =?us-ascii?Q?r5Z/Job+6Epv1dyMLafT0WILgn76JA6px/SVPXL0EI74GRKuBEQ+JBe4BVUJ?=
 =?us-ascii?Q?lHVhNHqk4SzpkPV0iqikSG0CwcvjGxLdNE8bfv7rCEbHPC0PgZsVQ+WUB8hw?=
 =?us-ascii?Q?A+s2v0ziEuBZC8cpFkbwTM4bGkJJwCGhFqQVLdnKolf5ZUmhvqKgFaIlRVUE?=
 =?us-ascii?Q?o1tccwiwYnrn4ppY4W7ry4xOm3/F0gt7xEOBRKbP4kjXxVW6k7XqBR9QnOGH?=
 =?us-ascii?Q?GQjOYUfX+7GFb/a8eFXEyO/+NPH6oSKkPdrvIRiNTFcRcv+WaGMOorIdrM8/?=
 =?us-ascii?Q?yqXhPyHDlUHTjSLUvSJwR0hqnWWJy7vqzcInbqQEz9IkU8UBJvaZtg5qeXIv?=
 =?us-ascii?Q?lRbU/ye68034gc78NXVZJbusv39vBXcKoreKj5OYsl9cfkvJL9MdM02x3OzJ?=
 =?us-ascii?Q?P4Cy5DKjFAgqTUlwugr8WTeuMkVGBANgZ6RDovFiVc8WYVSBU/H7NqXickcU?=
 =?us-ascii?Q?wKlzYRUMfpdaoMivqHAQKCs45OU/DeRQBzPwkUMlIMf0Wb55uTS8NV8l5qo9?=
 =?us-ascii?Q?/aYBM/9WVHpldKm89INSvgKfVb8U/IKrWrPySUX1PY2zewwC4K+vPzF6czYA?=
 =?us-ascii?Q?SIOyNZ16k+Xs3fM3iIUDm7fuxiEgXArkJirzXfATzsPv8XG7Vw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ryPac/BwAOq+yJfudw0qmCpwzF386oTmJdKwqLMCch7EW56a9QrZ3WmTTzEC?=
 =?us-ascii?Q?CiZNlWBQ1ZYSYdMh+A84zYbv7L3ApeudTLenp6QyaSrA8DweEuF+VaO0bwCG?=
 =?us-ascii?Q?LgnyJ3bUhTD5AyBlOxZcTpd1YwZ9kVRLQwLYCw8TWJOuRF8OdD94oTxPyIaW?=
 =?us-ascii?Q?bSYt0Y+eb4yBKHSR2NGxE9nYSiFaC8mTazCvRy/WXD8Qy7kKshJR9+vSE9n/?=
 =?us-ascii?Q?GdDoO36O/qn7GRXbmrDTcma2Rnr7YHuC2q3Sk6ciCxCSVV2tpEf8w288cIpy?=
 =?us-ascii?Q?QzIsUqv0eNvAYZo2BCoEs/fzcMNamMwi9fZE6q/NZo8HXbERZ1TKF6M+AuJ9?=
 =?us-ascii?Q?jDkCxSdg/8GA10kXRaz+QF9UJqTmdUO283V5/O6nfwODuHyaozbDqVdqbpwR?=
 =?us-ascii?Q?RX2AhF1u4OK/P6bIyYs1ouY8mHdB7iIge7T50LWLWsNbVqCPs8hJg0+bJ3OS?=
 =?us-ascii?Q?iJH77teadrjJugDSXu5J96W8RhH5bSDhj/Iy0Vu0zailsxj1wCJSlZ6ECO7d?=
 =?us-ascii?Q?mcxplj433uvc4Tn9HpC6AYQZ5qId/jmhY2bUrlXoCgy5bvKtD2hl0yL12bD7?=
 =?us-ascii?Q?I7QnHTBdHp3RGS3yGIQWM9D4AdaDngXMGEI7CqOC4zlVeaOIERfgsu9rjdWV?=
 =?us-ascii?Q?sg76MgPjiNnOaVTdG+DIsKDiW4iJ5ocUEst0MqHdTHLe9bCsmJxTJkLs9Bmh?=
 =?us-ascii?Q?PYduDqzvj1TPj68VIoqhPe261IZqvO/GZxkyaZQpl07NWRRdOwjukmJU9pOE?=
 =?us-ascii?Q?G2MMegE737qdUywYqI4p1D8yYGkZ2q671zy/sL4TFCOHGWB2///BHdZraqFi?=
 =?us-ascii?Q?fMrnmsEgHyHf/ekNzw0d9y2xqea31ziVuPe1lz1fiKJfRn+4AZMNO9g5wzdi?=
 =?us-ascii?Q?P4TwlVkAViBwTysbVaA1gA5NYHZKDGEYsN30lNEK+NY2yMBCj15ew7GVr2Ic?=
 =?us-ascii?Q?o8VmzU8GhRfj/8gMLNcwr0CunbADAEFxqQTDZhTiSF0kE/f2vn/yzPoO/b2u?=
 =?us-ascii?Q?vRRtb7lksSew9kUahUqxuOVquEG14nKYFqraxcN4kp8zacAgxh8u9k2wahJM?=
 =?us-ascii?Q?+DtFDa1yBnbe8/P2FncgwKbv7KZ+As8TRtcfCs0NCgdJSxC7KYbePOfKm8jJ?=
 =?us-ascii?Q?qDkbr72aBvbWGoAIhBc4G/QilVxIJmwKVtiCqS5qLdL2v3T5gvMq4fs+JaDO?=
 =?us-ascii?Q?lHr79oNfUhRfehuY/rxvwfkziVi0cNHPn0LSUs7By7D8vFiUHQtmMH7zB3mo?=
 =?us-ascii?Q?pR/jTy/3+CD/gWfD/jwO+Gzy46JUDsSP2cJHDUBSbmGgGSj3aPCYZSewtCa5?=
 =?us-ascii?Q?szlHGjI1IfD7TfuNiypB7OyKF31dT/RQO7ZrykLrfA3vKWpQ3QqiaPnqxAjx?=
 =?us-ascii?Q?J/8SL5TY+AhvKo2uB5qRTJleW2FqnRR5BgOebxtm88MANb5mR6bA9tOgAZx2?=
 =?us-ascii?Q?YBorwS1Bcl8R8PBbOF3G3Weq/Rj0/GCPOHntj1U+u6uivZqtgAvFYZ1mnguv?=
 =?us-ascii?Q?BOxiGK7sRkbGxsi+mpDc1akAm4sfkup/Uy7PvXiLc8WcX+bhxE+Mzzi0QSgV?=
 =?us-ascii?Q?0pBgZGuj8DxZkcrkC1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9be59f-a81c-4718-f26b-08dcb557859d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:04:28.7733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQuwe6r6ljxannf16UIZHHUZCdV8tIbZkGXSYrH3hKlyUnp30bGT98frwI26qEm60zHbL4jg1JMgWkcI5tqrjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10294
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

> Subject: [PATCH 2/5] tools: imx8image: add upower image support
>=20
> Part of the upower management was included in a previous commit [1].
> This patch only adds the bits required to properly parse a config file
> that would include the binary as follows:
> IMAGE PWR upower.bin
>=20
> [1] 6ec65c8558f (tools: image: support i.MX93)
>=20
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

