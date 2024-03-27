Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107D6C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563EC88089;
	Thu, 28 Mar 2024 00:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="UrBXQxX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505BE88096; Thu, 28 Mar 2024 00:41:49 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA8587F1C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlkptsUF59MkmE9OYEHR1pZaEYl9izflqSYMKyKQxBLO/0u4AHoNcKZv4Gy7GLpwxAZ8Q+JQifAI9QuNadtJP8+6L3iM9OTBmuBFjIn+CvHVSiRZDonj9B8qYo0n7rv/5oFqHynx4hTmqKmWjhRlSS3sFU343SE674RKko4bNLDzu/iSr5QElVzTh7VX+d5KEaRHQgBSwbxW9DsN/0kUUbj5TSp/82Wzdc+MoY5MgG1W/hcHoFtWOdqC95o+lLzCeJrUUAYjIuhjaARX/7YrADVBEHlxWWmvXxH6G3waEJeT0Hdw5B8f4S3g0StofMaGyS24RdC0HlHBfbPnlHHiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k31rMVcIUm93g8Vykmlp2Y7BjfFdnexEo7AeuD/1ZNM=;
 b=d86rNH9pk+oWQXuFcrVL2/5a6K/QBSuMF5OlVDrT9WdmBMjEUSJZ3jWWT8u2KTUOnaW+KWDa3iMwZkXmGeH05GAXs2XzMOAhvNc188l25EEv81Xvtp3pR+LZTcG7LOSf+Pb/xJ7DpLvk6OJMGt4McdoCgwWvQoeAAerEErkMdsSUDYUO6GyDGp5cpyfA6uRzu2O866cBcvutlOX69oBwIL1+Tk2SI+nuUZ20WHsn5VH3z5UsBljaIEfEwteRmBFK/ShjeaJdXJCUj7yfi2zTivK26yisYg3FY2vwcODWrsqxF2wMEh4lnhjWyiajjgXdu1DtpzL3yQWJNA/T0/IMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k31rMVcIUm93g8Vykmlp2Y7BjfFdnexEo7AeuD/1ZNM=;
 b=UrBXQxX0fLoT/SSHdu81476pPot7VVWjMOmFEO9SQ7jwIOK4kgyVUTikIYK214R0zLiy1xDjBrdhq7w++qH+64Ot8bcMz5/GbXm4OMoomHkKCs5E0xf3LcBI/R/joY33Qs41iuYw/2pfTiIkAcnWiGL7eXVHyI3YKZzLjUYZ8BQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 23:41:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:41:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>
Subject: RE: [PATCH] warp7: Convert to watchdog driver model
Thread-Topic: [PATCH] warp7: Convert to watchdog driver model
Thread-Index: AQHagE09sDjGJ3zx/Uign8+65zhpbLFMP/GQ
Date: Wed, 27 Mar 2024 23:41:45 +0000
Message-ID: <DU0PR04MB9417CFF92CBC183C71B9831788342@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240327134651.2113527-1-festevam@gmail.com>
In-Reply-To: <20240327134651.2113527-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS4PR04MB9576:EE_
x-ms-office365-filtering-correlation-id: aebd70e3-97dd-4394-55c7-08dc4eb776ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hu7zoJ84Jl8/11KLpgTL/BLua4lVNiEjRCMiiZjlsXpBsrK0qieSW43uA8MJejuqQSiyFtwrmwLuqcqK4hcFH4lH7pNo6+C8Q3nQ9R7V5cc/Bx7yua2CRIo7IRpvJ2iDBwyph5GxIZk1SaGE4GZW/Ie2MzVpYJZtvtBW39sEjHAXxf3f59veu39GjozP/QjUmLTUh+Hwkel/ug7OuJ7KlKs992AlJvGdVC92Y2Ex0JT6s9Aa+dFH44sERL91ALA9SuTzaFsTXHDuTIZsZpyDmUdwE6t7ayyEhjwmIYsn1RxRcJ3GlE9aVn0I1d298o/LE0N94DTEfw7zDng2BeTaC+OdmG0+mdlxeUdUTTBexO19hn5eykuubGXD+A/Jf0/6BRTmprhhHPj/6IkuP26eU5WLGphYHdnGudJvOFOxlUA1cISXSPiXNTLT6PK00sAfwxiKAWzKzJ620wO4lcNrVFnJGjOjaZUuQ5MTOyof6Y+XVPL/KYmXuPdjxN9E6yo1hTyX65v6u21QNUU0SEMSFQLn56Mp5MOPSVz//2Vl/yLOogV851k78endaMgaOqINHxWq149I3s8TtZ30vnVt5mAPM3EFHHz9OVuVhaC+Zd1TOAMwONBHGByYI6tHBkOnGWitzHieL2bIoyB8ezrQ5L/l8sq7U3pwMh436whE/9RTnexHlfPUkq9yYPGr64g+skQwv9Jp3CECSUkTc0oDr775R8FYj0ZKylAuTx8j3yM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSOhoJsAmeYFtvdY+QL8YAr5LD3BhcGCB055VUyK+Htdcr0YFEpsJcv9HfE2?=
 =?us-ascii?Q?NG34GxXwKKGxMbs/ujmc0TDqmmrZhMMwNsGFSnmuAH5bfDbaIEGABJTV/DXn?=
 =?us-ascii?Q?WiPKENQnmzeNShuU2et482Vo7yjqR2Xu0/PS2uQwgOBP7+JmMzPCVRwC5hMC?=
 =?us-ascii?Q?4d7HlhzpC9TU/WH/qBw/jsffBsdPRHVF7tVw/6fykd/PHt+iEnt+5tS+LSxf?=
 =?us-ascii?Q?SPJbURtaWUW+/ulilaPgnqNr6lZZfoYDW/UVjiXz8JDXq420MoLlHe0IAZRh?=
 =?us-ascii?Q?o6UzUfrhmhDCBfgGQsA8BiPZdKssAaHnNsSZxPm7wA0JzlgEEXSNc8bA1Nre?=
 =?us-ascii?Q?+OeOuhkLxvFxegD5kVXZyLq0xl41HAASsDXal91Xe9/0Ex469kLqV8PpuQV+?=
 =?us-ascii?Q?bJ0DBQJ1m4vDzh9XcN1eP3sVygHXgnPwOaGbO4mB7HUL0SAHqcxay2xxk0iB?=
 =?us-ascii?Q?4ELeBj0gcl54ymiBIBewjAfEAGixAHJDPSxUJLC8uWQtkPrR1zy8lTwpMZVR?=
 =?us-ascii?Q?EvxvF9Rf+t4Uej+kUf+ucubEZXS15cJ2fexxZGyJIwgvDplBIDqmET8q3BFY?=
 =?us-ascii?Q?bwj8NT/LjmRxzBIkMzbe+JOl4IJaWuNFSg/420ZIb/ttBaMRfvOi4xWQk0ES?=
 =?us-ascii?Q?7/I/HyxkFYkMD3MXaE8o4P7iMeXNF5O9YMIyqXhDnj9c3y/+Ol8zYYRwAMI+?=
 =?us-ascii?Q?LDB9kzvWcAlGAAgllf8PSjIlDU7K+7GVRRlaLCQM84+1Rg1GirC7Awa4t1EP?=
 =?us-ascii?Q?u95eZDXMfl9b6NaLhHs+/TNH47tQcUoRmz5GUCVMUQgCMuQ731f9qIoPgJ08?=
 =?us-ascii?Q?9p7QVNL+3FIFsCZ7Xo1Cs5K7mMug3Tk3o1OMSPEPKOVc3hku5ReevfE9ToOO?=
 =?us-ascii?Q?PUaDoQbYdG79YUhinG1E2G/2s/XUTc5gm1tN8kMcN37Orw2lOAPKrZ7m6xy2?=
 =?us-ascii?Q?ZbL5ZXYI1+d6QqsJZ9Yy4fz/fjT76z06tvqYqe9yY4XH3ijpaZ+ZiExVbqzd?=
 =?us-ascii?Q?puV/04EgeGyHE7hatFkUQuZQysu6GMGW+eJ1wmkTe8Uhqah6XU0Hqu6ODDi8?=
 =?us-ascii?Q?met1skRt0HpEaPAc+U2xB2xaY90a7QhZGNnqMlR+QR1iZYJm6eHKkDr9qY4S?=
 =?us-ascii?Q?b1iyQhlCusfou/rqP2m8Z6miC3LD2kshxNWP8jOz3+vYtCrcwU3gaN7aSm4n?=
 =?us-ascii?Q?RWjJVQ6NlZSvbXoQ/jtERZRNnkLNJTJIwjcbyHbElcqjdC0dJV2oi3dc0EIE?=
 =?us-ascii?Q?IOJh1IOqp+pR+ySWtfFiOqTmYzcaqp3sGjxXCDZS2v1L0U/SgxFKy+g7lfRM?=
 =?us-ascii?Q?s3ctI1hrK7OZM+T+7lxBdKJTtAPKY3T8NmI6rwZ9r+6woaMJmm/8AFc4aXhx?=
 =?us-ascii?Q?ZPBCpwusfG4hDup2JQuHxVwBkKSfo68EXPa+IYPC9XfJNbKoduW5eZomiPNu?=
 =?us-ascii?Q?LDUO0P5C6mJx2waRF+mmiv1yYHMq5M3YfG0bHo5n1MO63l5bcIqsXD7a2Cb7?=
 =?us-ascii?Q?KR4moiSK50gVtx2PCIw/asKnW57Llp4sF95472yWOW7qH0OHooGjz1qQWiRl?=
 =?us-ascii?Q?UzVUWJ5F0v6NSA8SZVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebd70e3-97dd-4394-55c7-08dc4eb776ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 23:41:45.6444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZdUjudwEDajDvt8+quHxj9rD+8+jqoCdW/os5mi0r0fWx5IAP34c/zcoR6el0fMJQRDiIp4SjWrJLFSsY1RsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9576
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

> Subject: [PATCH] warp7: Convert to watchdog driver model
>=20
> Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
> the 'reset' command in U-Boot to not cause a board reset.
>=20
> Fix it by switching to the watchdog driver model via sysreset, which is t=
he
> preferred method for implementing the watchdog reset.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm/dts/imx7s-warp-u-boot.dtsi | 10 ++++++++++
>  configs/warp7_defconfig             |  3 +++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/arch/arm/dts/imx7s-warp-u-boot.dtsi b/arch/arm/dts/imx7s-war=
p-
> u-boot.dtsi
> index 4f44598c9a27..98784fd7a2ef 100644
> --- a/arch/arm/dts/imx7s-warp-u-boot.dtsi
> +++ b/arch/arm/dts/imx7s-warp-u-boot.dtsi
> @@ -7,6 +7,12 @@
>  	chosen {
>  		stdout-path =3D &uart1;
>  	};
> +
> +	wdt-reboot {
> +		compatible =3D "wdt-reboot";
> +		wdt =3D <&wdog1>;
> +		bootph-pre-ram;
> +	};
>  };
>=20
>  &aips3 {
> @@ -24,3 +30,7 @@
>  &uart1 {
>  	bootph-all;
>  };
> +
> +&wdog1 {
> +	bootph-pre-ram;
> +};
> diff --git a/configs/warp7_defconfig b/configs/warp7_defconfig index
> 9b518a121be6..48042b702c22 100644
> --- a/configs/warp7_defconfig
> +++ b/configs/warp7_defconfig
> @@ -67,6 +67,8 @@ CONFIG_DM_REGULATOR_GPIO=3Dy
> CONFIG_SPECIFY_CONSOLE_INDEX=3Dy  CONFIG_DM_SERIAL=3Dy
> CONFIG_MXC_UART=3Dy
> +CONFIG_SYSRESET=3Dy
> +CONFIG_SYSRESET_WATCHDOG=3Dy
>  CONFIG_IMX_THERMAL=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_EHCI_HCD=3Dy
> @@ -80,5 +82,6 @@ CONFIG_USB_GADGET_DOWNLOAD=3Dy
> CONFIG_USB_ETHER=3Dy  CONFIG_USB_ETH_CDC=3Dy
> CONFIG_USBNET_HOST_ADDR=3D"de:ad:be:af:00:00"
> +CONFIG_IMX_WATCHDOG=3Dy
>  CONFIG_OPTEE_TZDRAM_SIZE=3D0x3000000
>  CONFIG_BOOTM_OPTEE=3Dy
> --
> 2.34.1

