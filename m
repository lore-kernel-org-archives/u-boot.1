Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC73C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 12:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CCDD88763;
	Tue, 21 May 2024 14:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="FzTllXvy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F1908803A; Tue, 21 May 2024 14:51:42 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A05088765
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 14:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARKhtpg1whcaYA0lEv8hwGbTpFj9do8PgaptHmbQV7cmSk4t/3V62ImW/El99l2u7PoPap0FPH2RgJVlqz4MU/t9jYa0lZtr6PLPxdYAMK30ts2RZWpEk7Uup78i4wI7FhWZPkDNWKK2tulYMFAKf0/IEMsAwv/QVxrrjroidz2SagnDatrYy7Bm0bGECcE8RY5tJ8O5r1wKMy/ut1hRx+HrakLlcCYCvPpMPXPDvTddL5/02MGgXYE69pgJO3uXPHZTvJC8vcDqhaji2KEb/U/nTHF+we8YCMxzFZqu8pvYwpGuSlspkjo4R4PMrRmlk0UuOzfPGT+Zeb3h2Bn+zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DCSMbgKS1ljEYbevN5zDNXmEdYCjKbS3fThyBDI3xI=;
 b=ZKrqIAwzvdaIuMn9lB5gF6sEPdFV0/UddU55WqgYUMpBXKVCayIeElCyI4b9K67PXlT+5S/GTeARZZGZg/cnZsvpgdXfXVBuMJrLjuXz8ws4OYY/PEeTHYOqIl0p8vH2zZtWZmVSlKWNHoA7F3FGWruVaVb79n3QERzbaHfs5Hq4HbqayUbNWq8qVwtYoUIgkMQHwL4iCRlNIHxFMtnevBsSvk6yF/QiriKn6BNasG3PS0qUyIbYIEewT5A5106L/cy8DKSK3J4GQXD7BzIHWkxBzgEaZTWn4KVrmAEOrBEvyi85FkNbQ/Hypn15imJnxavbPjGB14RzxVOwF96h4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DCSMbgKS1ljEYbevN5zDNXmEdYCjKbS3fThyBDI3xI=;
 b=FzTllXvy5cdIoDsWU/DyiPKqaDao3ROcDtQIn9zWkfQLccNOX3JSITLarIqOXtnaMcTLB9xhs+2bYhfnwWkj7Hfhrmw2T2d6oYSO+yWDOLtJr2HOI1rxR+150VKBUwVw6hoPEQjbNMds+jDt0R+8NARXTGGADD/gxwgwdeGyPJE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8246.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:51:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::557f:6fcf:a5a7:981c%6]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 12:51:38 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Philippe Schenker
 <philippe.schenker@toradex.com>, Martyn Welch <martyn.welch@collabora.com>,
 Stefano Babic <sbabic@denx.de>
Subject: RE: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
 MX8Menlo
Thread-Topic: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
 MX8Menlo
Thread-Index: AQHaq2MjeL4w6toOZ0Wuzwaco1qW6bGhpE+Q
Date: Tue, 21 May 2024 12:51:38 +0000
Message-ID: <DU0PR04MB9417FE9BF37399FB344F525088EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240521094146.8886-1-marex@denx.de>
In-Reply-To: <20240521094146.8886-1-marex@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB8246:EE_
x-ms-office365-filtering-correlation-id: 25636fbf-b943-43d3-3cf8-08dc7994c18e
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?JiQdpOdAB1FmLimK15RgTkzIYvRnKkw367YDDo6smWWed/knhgdluuyZ7pX5?=
 =?us-ascii?Q?yx0rLGiN9+RdoUqE1yGlSj2+ZT2T0nnVxc5W2RPbuHZm7Yf5WZXO0h6I6lXT?=
 =?us-ascii?Q?+Bgj47BGMQde5K9CXvcABq1iQzSFp47jqleQ+iBp5bss7ihOvjXI8RlYr41z?=
 =?us-ascii?Q?dUWu01YbCMR5q1y3Q6xtm47rItSepfR/FOxNtHUwQhrTeZuXJccmv+Apwg8j?=
 =?us-ascii?Q?n2GMOd2MgDa3W1yWMXylGE8n17nPY8IgPYvyGL4r+IHgMCEqT4xs7pU/h7rs?=
 =?us-ascii?Q?J5WdpmS5U9wCBrCwO/9OsYwS8e7RBG8YpnndyXx8y1ey1MPDoneq1H1GxFHn?=
 =?us-ascii?Q?LDZXnQ19f5jyJVg2KvUuN75llPKcMwdLqwxfXWxhCIEMimDdt5fkLRHqyplJ?=
 =?us-ascii?Q?b9ULstHJJllT4UHwEzjJqIwuL3bdfTV70qNwcAb3x/eYIYrv4WCMXGchPCfY?=
 =?us-ascii?Q?bYJeqNf/4aKGdGC5LT5LFDEvCqdBjtlSGTJ5BDizyndD9nMpLjfQQdSOz3tY?=
 =?us-ascii?Q?rOJdOnNENrMgDxO1PZ8r920+iWOu4wd7GnqbMPmMdISg1mdrwUWHQnaP62cW?=
 =?us-ascii?Q?dunt6PvwrX5TYasN3sEHfFs9F5lIV9CwKRcOJ3rTrWVqCIGxgCPPMrP6LusA?=
 =?us-ascii?Q?IiexZJngelValVK0/yKTs0owyZ9fX9OHduDL7MWIcnOtQ5xU2zcjqN6rWhfu?=
 =?us-ascii?Q?opRo0OwRtlA1MGcEiaTa4inaseLUY9qtCwmw/BfzjBm9f2QRk8Z3CV8BQliv?=
 =?us-ascii?Q?bDiuKau95mNn3UGZ+mZqMobgd4ag3KbdBBYntkTe/GOQiMxavK9erpv2tQrm?=
 =?us-ascii?Q?vDxw7yI62Z8tHwiU3kDMvsC8x1XB66Kx6LoXlkmIgem8HFhxu3rD+1RC1fhH?=
 =?us-ascii?Q?FVRH5BZ3bRBr5x8jGEN+yfNMIwHPH0vQzrD70SPevPOttUYSBXeDdCe7Novi?=
 =?us-ascii?Q?5vScKe1pBGzWR9i76wG8l3EGsVdPsPa0cIuei4kuNAP2Fy0LLrmTq9WX3ydV?=
 =?us-ascii?Q?LeER2O3CyrtfA85Rpm4hfgcilqjahPc+4UrZWAHdQZJt1HnaqHk4D532NfJw?=
 =?us-ascii?Q?aqqJ2MKTyKrQGOPZdQNaqZf8gkLP3uRb03Iht571EIf9yVDEZrxt51BQKGwf?=
 =?us-ascii?Q?fnhvy7fnoqGKmrDehU68Ghk2J1ccKOMOKH6NdKSDKos2Os1Wddj3bH/k2mlP?=
 =?us-ascii?Q?7cmY9YUxtJCvPiFdZk9P5roMu5MTmFsbQ1FZartkCGeefu4mjsH3pdaDUePI?=
 =?us-ascii?Q?gqdH6x1sJQAoWZ+0cchTtvI9YGPC1+uhA8l+D2maCpje4Yt1oVXnR99oIipb?=
 =?us-ascii?Q?FB8SySTKgPIw+kBodhgjegyLUOeRWM8IixXLW8Zmo+26oQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BRfdspHrfu/QzDh+Nfkdpm5bNrWb+rR0nwLCc0fR4JErJlEFnkBJJwwPBhwA?=
 =?us-ascii?Q?5N8C4btzzSIfcfKnv7DDj9o/tsj7KWFIgPx9VlfaQpv005XST6MSW+/pln6a?=
 =?us-ascii?Q?3iSr43kKpoBkAT0MPUmLYcygHyP+IuqlznPu/hQOvdma7sOMigSxo8++iQEM?=
 =?us-ascii?Q?1647vxB6/s7pENE6OAoQinhwXsza31VjlNoxV5okdg3hJpfObSaEjlxoi1K+?=
 =?us-ascii?Q?ad5pZiorzrToBPkd8wA4vumpMEVrgUldCDQXYpQJdpZlWSfpyyF96Mcy2Oif?=
 =?us-ascii?Q?4aZcK93AmjmKDTZvfCvEoHkejVUzvViU10vmjdoZVzTPQq1ApTscEA62v0HN?=
 =?us-ascii?Q?6QZz8StRt7/CAyONmSUjT8CwTjZFNp4ENNh73EZ5JmMltcQ00Jd41igfKOFX?=
 =?us-ascii?Q?u4mOFre400hAl6Q/6nvhk1jKnQD9+zk2PqDUaIorj8Ds+xxZcyHWglG/sJ6U?=
 =?us-ascii?Q?rARRD8buuv3MmC7f1hhozrUI1R6HGItJS0I9SAlHfRwEqfbTMYMQlxqEpnIM?=
 =?us-ascii?Q?3COtGsGWoJt8uu58gpkqWySXVfy83eogcYOB3ZIYqHJJwaTCmEKo65v5fw58?=
 =?us-ascii?Q?0PHrL301/GixwVff4vKBfchuD8uASGVtA/Sl1YNPAhPL8SvaY69gMPomg55l?=
 =?us-ascii?Q?7FThM6/TaBGn6hsMqwsK2rxFoI4qrs1Ik2azyz0AcKnVTksmiTtyQalfJlXL?=
 =?us-ascii?Q?tytYobX+R+D+5MLJkpfmp30iPhmCw/jhwi4ga2csEGvIVOU+IR+3AaX2vi4l?=
 =?us-ascii?Q?eNBsf64LoODTESm4gCo5KWDmHxSAlh5XFkaTtbSyTGCB6Axezf302c4N+px3?=
 =?us-ascii?Q?0RjY+5bGyw1w0gi8JdDblo3OG74xNAdLc0cTbxhSp7ZQXYkRJKI2JZiIKE+2?=
 =?us-ascii?Q?iZeaOs9DvQ6s8SYprjdMFio/kZyiO1XEvs7Wzgq21qM1pTDxoCdzNc3pUvkd?=
 =?us-ascii?Q?8snmAA8Y1aVofYwZk82xd+A71EmBRF2glUFMiwanIvZ7y5fuMUqdKl2v1tPH?=
 =?us-ascii?Q?Qs7tVsAqax8tNSoJGTVd18Sf5hwoh6iDhiwb9FnQnRogt6bDF8E5EDzfgyxw?=
 =?us-ascii?Q?p2+rc24VPA2shZujn7LNd3bTyqNZzX7aK4SWctzKPEFBvZSPR/iJcnW1annP?=
 =?us-ascii?Q?7VuRa5u8FvcitUa1i0ofAuBl7vIjOX/N7Z/atVIqooXhNV+U87MZhVYHfdyc?=
 =?us-ascii?Q?9Si6wBvyPxLmAjwkuExc58WssWFakhoQWyAjzbzD4g1xicix3n5QnieiZL5J?=
 =?us-ascii?Q?57BcuJQDQD0o0SzbkbFZ0oHsADk+Ya62Qr69vo5DeDCK/6z9+XgTUMp54Hd/?=
 =?us-ascii?Q?E+j061IonRKtZf9yiOfF344HP/uufLVeAQnJ+b4sNIuus6TgcBcmw/lDhTVE?=
 =?us-ascii?Q?oqAUp7QVB/YSsXr6QFV6z+X4/WUWc050wdhxoMt8uWTiAtM/GRIEd067NpVS?=
 =?us-ascii?Q?GdRAih/jYGdum09VIfVa9yin82sL37LWdntqLgty1GqXphy6V1Yg5LVO0wAX?=
 =?us-ascii?Q?UMKy5Xr+2MJyYCKFfc1QhhK/yr7zRCLsT7fVb8/cxmQh1h3U/9bJm5M28vY8?=
 =?us-ascii?Q?aikt/+3fvfc1NeOmLZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25636fbf-b943-43d3-3cf8-08dc7994c18e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 12:51:38.9102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTR9ZlKUperzJwSDCcbiFk9+zuxJSf9g/U9tbC2cdRWXiM1AoztW8s5UGaZnGy5lD1A3HgzHoctIWcXRimlO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8246
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

> Subject: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
> MX8Menlo
>=20
> Enable CPLD_Dn pull down resistor instead of pull up to avoid intefering =
with
> CPLD power off functionality.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/dts/imx8mm-mx8menlo.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>=20
> diff --git a/arch/arm/dts/imx8mm-mx8menlo.dts b/arch/arm/dts/imx8mm-
> mx8menlo.dts
> index 0b123a84018..c226285c6ea 100644
> --- a/arch/arm/dts/imx8mm-mx8menlo.dts
> +++ b/arch/arm/dts/imx8mm-mx8menlo.dts
> @@ -290,6 +290,28 @@
>  	>;
>  };
>=20
> +&pinctrl_gpio_hog1 {

Should these be in xx-u-boot.dtsi?

Regards,
Peng.
> +	fsl,pins =3D <
> +		MX8MM_IOMUXC_SAI1_MCLK_GPIO4_IO20
> 	0x1c4	/* SODIMM 88 */
> +		MX8MM_IOMUXC_SAI1_RXC_GPIO4_IO1
> 	0x1c4	/* CPLD_int */
> +		MX8MM_IOMUXC_SAI1_RXD0_GPIO4_IO2
> 	0x1c4	/* CPLD_reset */
> +		MX8MM_IOMUXC_SAI1_RXD1_GPIO4_IO3
> 	0x1c4	/* SODIMM 94 */
> +		MX8MM_IOMUXC_SAI1_RXD2_GPIO4_IO4
> 	0x1c4	/* SODIMM 96 */
> +		MX8MM_IOMUXC_SAI1_RXD3_GPIO4_IO5
> 	0x184	/* CPLD_D[7] */
> +		MX8MM_IOMUXC_SAI1_RXFS_GPIO4_IO0
> 	0x184	/* CPLD_D[6] */
> +		MX8MM_IOMUXC_SAI1_TXC_GPIO4_IO11
> 	0x184	/* CPLD_D[5] */
> +		MX8MM_IOMUXC_SAI1_TXD0_GPIO4_IO12
> 	0x184	/* CPLD_D[4] */
> +		MX8MM_IOMUXC_SAI1_TXD1_GPIO4_IO13
> 	0x184	/* CPLD_D[3] */
> +		MX8MM_IOMUXC_SAI1_TXD2_GPIO4_IO14
> 	0x184	/* CPLD_D[2] */
> +		MX8MM_IOMUXC_SAI1_TXD3_GPIO4_IO15
> 	0x184	/* CPLD_D[1] */
> +		MX8MM_IOMUXC_SAI1_TXD4_GPIO4_IO16
> 	0x184	/* CPLD_D[0] */
> +		MX8MM_IOMUXC_SAI2_MCLK_GPIO4_IO27
> 	0x1c4	/* KBD_intK */
> +		MX8MM_IOMUXC_SAI5_RXD1_GPIO3_IO22
> 	0x1c4	/* DISP_reset */
> +		MX8MM_IOMUXC_SAI5_RXD2_GPIO3_IO23
> 	0x1c4	/* KBD_intI */
> +		MX8MM_IOMUXC_SAI5_RXD3_GPIO3_IO24
> 	0x1c4
> +	>;
> +};
> +
>  &reg_usb_otg1_vbus {
>  	/delete-property/ enable-active-high;
>  	gpio =3D <&gpio1 12 GPIO_ACTIVE_LOW>;
> --
> 2.43.0

