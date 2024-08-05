Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79987C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 14:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D844488960;
	Mon,  5 Aug 2024 16:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="e7wKk5N2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72D9688971; Mon,  5 Aug 2024 16:10:44 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8222E885BF
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 16:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8Tzad1d+AXDmelY/YWHB8y5Cb6Quaeg7n9yvUO3sD0y7e3QOxSYN62EcL89g9ZYbAJyraLcPVMRIbQPPY1gdHVJLcExFrhFKHiM2b0L6TdaSYH3YULrQsFOKEb3C/U7hhazgLYi8CmAfSWZj9ZabAOM/qiE9JbDOstQKXJhoynEakh3Tn1VssYdY3KhFD3f3ZS/ukkRAIet1zYaDFKQsyw94sCFHMo7GHxIN0t6IJGvA8UoEYLwX4vSeMZjTxvylLep/i5RG9JVywvJUyMpQkABjR9cCmtbbObYF4G3aIDL9A6nOUtrJ34hFBrnJsgmmZvQX9lz8XdWusHn6MSpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGfgsfc1PtqeS5iqLsSLBSL0FTI0cM3AoCBjvX0X8EQ=;
 b=gKmhl0B6fe/kwQ/Rl5RWFOL8oGLz24b7bhsXe1RB4VcWtL3Aa6bRGx0BYJnde1SH6BT8iHCMVJsFjLj1vbJDuZYZT0wgmj1+WLd4thvFjJ9zOM7CvyrnP5ytxS7jzSrkNR0omeAa5kvo53hVCXfZ63JuMzTsAU/uH1PNzzUw7lblmc+Rxb25LxF7mvCTUL1qeghN7ZV0KM+lzmV/GA6p1h1DUtmuEqqpNfmd+T71/ow/wIW/shfVknX5ODbtBvbvqbVihcLYmeHBNBpA/6JaMbcH3J4VVvEKIswVLiJDugs4CYxZ4s9PXmVFyenKZz3KoI32pCgzo7CPpG5/o5Rx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGfgsfc1PtqeS5iqLsSLBSL0FTI0cM3AoCBjvX0X8EQ=;
 b=e7wKk5N2EQcely8vaqHN1IqDfjwuc3kN/2Ur+nlhq/WJUd1FaHFom4H2yDZQ85lAKCli8JsedKnvhPUoQjRRP4ntKaRfpdmvUzfxoyd4hmsnt9usuqDL/Grj1Z3rThDjAQdUJkTphT0jDcDiXNPNgeFVig5zi1nEJQ4wBHfG3/HxaSpipgujOghG02wr49o6R57je2juVfedkpt6LOIqL62oWQYXYkVKgNVIdlvxmYI/6i2wlH4OvN0afHu2Dft8oBYB634fpeCT8TyoBqYkO8WzXHbw37/sRxhQTR0sp4CU7ry9PQ4sbvgLHTqzphJf+L/S2nihIj8IAC9wteKORg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM7PR04MB6822.eurprd04.prod.outlook.com (2603:10a6:20b:108::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 14:10:40 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Mon, 5 Aug 2024
 14:10:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Gary Bisson <bisson.gary@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH 5/5] imx8ulp_evk: enable binman support
Thread-Topic: [PATCH 5/5] imx8ulp_evk: enable binman support
Thread-Index: AQHa5zUZvpMrquAsSUCuiyTVkbuEK7IYsu3A
Date: Mon, 5 Aug 2024 14:10:39 +0000
Message-ID: <DB9PR04MB8461942DA2EBDD3CBCA199DD88BE2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240805124326.544310-1-bisson.gary@gmail.com>
 <20240805124326.544310-6-bisson.gary@gmail.com>
In-Reply-To: <20240805124326.544310-6-bisson.gary@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM7PR04MB6822:EE_
x-ms-office365-filtering-correlation-id: fc8934e2-4bd7-4d70-e6f5-08dcb55862cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mfc9oC+eTgk3BW1B1jcwQr3Nq4nMCf2FfCzwT4nipF7U0guAe/InZFYdoNQF?=
 =?us-ascii?Q?siCQr9p/3T3nxpkEFUn5GO4hny9g6HZwaJ+0rycSLBZJgb0+pxGAPXYZmDBN?=
 =?us-ascii?Q?BvGWDpl+V6wKnG4pWFG4JNPvtIKRyOQGK46qSsrpDKhFubd00b7QUOzUZME4?=
 =?us-ascii?Q?FwefcJNaBi35I8WoQO4fAjKTRUXNVQ7NZxRFfaEBUIL8tAAMoUi7K8aUBUyl?=
 =?us-ascii?Q?HsBaKxSBk+429Y02Fb7CWB6+Uqmz27juUrrR4VrZXDCdDQrIyWcQ6SXrUN3Y?=
 =?us-ascii?Q?9PifRaacGDWVsUqy3q/4JypblMQIV8sCt4bxlOQon95YDa+2A7B6/38rlo5W?=
 =?us-ascii?Q?Fn2CYfOxtNJwMv4QnOIvmrExooyT9KaORPlfKdYAm/TLmhbVjhX9JNkuOO0R?=
 =?us-ascii?Q?LUPAzx6Wfl6DmUSdDSciK4Y4O30C/7bPN9E3k0i9uK9n3/4unNyCZthJpNtu?=
 =?us-ascii?Q?mZ7J0vvRdO//RTLdoRLpZdcXIXvwR89fbj7noxf+HhLUb+PvI79ojIREmMTx?=
 =?us-ascii?Q?/8vsHlJOv1akVrbntJVZaTTxzhjHF/lvb0kmVoUdcH7AiPSbpk9TpEdolUvf?=
 =?us-ascii?Q?la99wiFSXrT1fx5toEeA0iu4HMHmaOS0cjLE8+cjcLWNUhq/fUzwt22UyGHE?=
 =?us-ascii?Q?zL27ihPuxlIPq0F1uHQEzLeAsv5C5eCUtGNAmef5EgsPYa3D05sRmF7rbFA9?=
 =?us-ascii?Q?ASRp1PHWZBwmL+sNe1sMv7z8NyBuRIZd6B9dzvYgFK1WzZMk7qxNsEL2f3C2?=
 =?us-ascii?Q?YdnFksJ6BLznDPCBmH6Q6TlPPjX22urm3yS92zv5tPoD5/e3E/Q0ktq+Ttw7?=
 =?us-ascii?Q?rQ96Xe7gnTzP4HE5Ytk/yHrdTD/00L+I6v9g3+91fROdWeIwn3iAANNdOiQv?=
 =?us-ascii?Q?lrTabqfm3kAlh2Bux4k1IGMt258jbz9I2/jEmQa13D2G62m1CEKcU+Y2MbQO?=
 =?us-ascii?Q?4B7C4amuqJHvr11BKcuw/ssdyb4QJBX6Yoks42ytHa8++sPBgMSQmMkOzinU?=
 =?us-ascii?Q?yvbrR8tuPU6aioMCHgGhXAwngj1D5RNhlwa6+/5/GDuPRDhGP54qpPIIS6WR?=
 =?us-ascii?Q?YGMyVzg6buYRKvIPxFahCzB9jtJK8poKBYLYh4ZxDAm6MBiETLjYAhlAXta1?=
 =?us-ascii?Q?iaSZrPZbGN5ftSSKvZYur4lpp6eZ+R3G10Stq/EbayIQ5f56fr0O+oyjP+HO?=
 =?us-ascii?Q?bFvd2nC3eRwpF5SqD0DaO2kJpEkBXjETG5WLHzhFLykKOhomgrG6YXaefdUA?=
 =?us-ascii?Q?yWhNhfPUO8PFD67ItdbEt8wlHky9obMj08lyu05nnKqBf0vCcfaXN1fILckq?=
 =?us-ascii?Q?LIqp+qoiFPzb2hI3hVjfhs28N/aija/i8N+yPEQddgSpfxkli7jjfK505LDJ?=
 =?us-ascii?Q?vu+Cc/eTwsaBzU5CUAWXrWQOLCIcn6rOtg1yFQ3dXZ4159JKCQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xV2SzGipyyuaAyEOrGJMWDtlAAPwUi9WC4Y84iEDk2ohUMN++3mPo7ncnSME?=
 =?us-ascii?Q?13LACGMVoGyQAFvbeJzHdg2E91y9qARyrxd3yAl4YNt93GCgM06lC4hm+6ja?=
 =?us-ascii?Q?5wdmzgt8XUerNe51ctMlHDPuNKVYfXi2O8yiPAi3c78inJvUj8QaeohDGMGS?=
 =?us-ascii?Q?imJsz+S4+ZFbqJ81P8Ba9IYAnQi5Jcdzfm1CEXfBNCETS1/AhVEAHdmCOYUy?=
 =?us-ascii?Q?b+fZSNfzuBUtryWnmi879HEiwrEWIWJZ+MxmX/OstQflFIXB+PIAQwjimUiQ?=
 =?us-ascii?Q?Q2rIhg9/SOMsamVj3616DrziZy4gQx6dtaTAxeW9jQ+TcgpLk4E0tQWS7wxc?=
 =?us-ascii?Q?huBveaeY0tK5yb2zPyljY2MLImNeZ7a5cnrRzD0B5ZZrbW2GQip99KFWGOqN?=
 =?us-ascii?Q?0303dO5RF2JNxgpL3VfC/vcJB+tQutYZW5yJlxuDwuD+x4BxUJQeGq+/Kcn/?=
 =?us-ascii?Q?+pc7o0JMep84MZke3p6ZsEgMrF7KMdg5pSExI9g/gjwYKi16tmfWZa1Zw327?=
 =?us-ascii?Q?sBftKXNspbehEZSfLDpHpU4Ax4vB8DuVaTAFG/RxpNl+AnWSZ97MtDi0ePIM?=
 =?us-ascii?Q?IrfpfW6gu4NzOdA7FVmRjSJ6sweWC0Uagg8YE3NyTMjTqoH5vUXXNQogDNYH?=
 =?us-ascii?Q?pLQARHzs/+PIcjKAcjnRMgvAR3HxSNA/JaeAV9AfU4Q0fQFpN4NpDT4AaxwB?=
 =?us-ascii?Q?yJT9l1VkvfNcqsSYsmGR2y6Nftsc1YyaOk/GOJHo1RJD2AmmRWzEXotu3mz1?=
 =?us-ascii?Q?IQnVPq6jFe6mBSDj9jBDOG/yg2ctsPf4jpY9xxODAwFoSdzp6nTouXqLLzru?=
 =?us-ascii?Q?jJhjkxywrIxaMRtIZC2vbismeTd7t7xikN7UkX4OO9vLbp6Yc2f7yt06xJU8?=
 =?us-ascii?Q?TEklpXJFDU0wleXAPMFhHRbW2kctWO4sc5jLFDxVdMQim1dDOeurHqanA+IE?=
 =?us-ascii?Q?9VgxqpaD35rS69iUlI/+IYVxKOlDWeDU4S+OjtjTkDA76Njd7IwFbDIrTMOO?=
 =?us-ascii?Q?hx6daimQbBXOLwb+pPEIV2LBEKjx9e0V/cxYkyM8vZYcKp2qRt7QyCHXXMb0?=
 =?us-ascii?Q?B+zrAUkFGe31MEeEqlrTF8nx+UpKHRDUeObgS208/ZBJYk505NAuueZR/OTf?=
 =?us-ascii?Q?7zyZQEAkXDfzmXiUWLilKRRtzVWkfK3EAeYm7uCFgZqzwrf3RG04d0kXh5i+?=
 =?us-ascii?Q?L491vUpF7A8PtjcPQNmb+Ka4H2QtD2Y+zWiJC9//xz9YSHDaAq0/0UtYeUH0?=
 =?us-ascii?Q?P/g3t5YWzrmds9Bk70T50q/bMB6L54NFyvkJPGzFpHTP8DNfOiC+itPBP3x8?=
 =?us-ascii?Q?fm1P3KRGNzroyFO3QhTeE7B2GqmSEZZRcF+DpZ4uXUFgV71J0/P2xebWE9m+?=
 =?us-ascii?Q?L4ws+Jo1GAhApOkj99iBPNUIT1GQW+x4HiEgctcfBtR7EUKOzLeG4Jc5m+VG?=
 =?us-ascii?Q?wdrEnrYUuYp+CN9tbtkPSkbTo29Xws4khSma6rj+pB8RGon3GeSF3jZbe0IW?=
 =?us-ascii?Q?ko/fRcmYZ+TMnhQFYglJeTiva4aYYVlvQsNNwG4L+PLhRRoEitEVmQovx58E?=
 =?us-ascii?Q?H0Cvfwkw8LXK1kqM1/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8934e2-4bd7-4d70-e6f5-08dcb55862cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 14:10:39.8595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjQ1uXN692U7/0EcYHDkFme05dtKYPHnnwvLY+rVd7mPHmHVUc4Qh1TIo9Xm5GjXQtNyuao8nszF2W47hiFXMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6822
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

> Subject: [PATCH 5/5] imx8ulp_evk: enable binman support
>=20
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>
> ---
>  arch/arm/dts/imx8ulp-evk-u-boot.dtsi | 2 ++
>  arch/arm/mach-imx/imx8ulp/Kconfig    | 1 +
>  configs/imx8ulp_evk_defconfig        | 3 ++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
> b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
> index 608bde3a2a3..f67fe166d31 100644
> --- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
> @@ -3,6 +3,8 @@
>   * Copyright 2021 NXP
>   */
>=20
> +#include "imx8ulp-u-boot.dtsi"
> +
>  / {
>  	mu@27020000 {
>  		compatible =3D "fsl,imx8ulp-mu";
> diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-
> imx/imx8ulp/Kconfig
> index 49ea25250a3..6ce6039faf9 100644
> --- a/arch/arm/mach-imx/imx8ulp/Kconfig
> +++ b/arch/arm/mach-imx/imx8ulp/Kconfig
> @@ -23,6 +23,7 @@ choice
>=20
>  config TARGET_IMX8ULP_EVK
>  	bool "imx8ulp_evk"
> +        select BINMAN

Tab, no space.

Regards,
Peng.
