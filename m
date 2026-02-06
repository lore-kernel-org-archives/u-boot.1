Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1242ECD9AA
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F992831AC;
	Fri,  6 Feb 2026 01:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NPIFjRei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4956B83B0B; Fri,  6 Feb 2026 01:37:23 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C3783015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNs6dwOOXat0Iud3fbRxyu/G1qaXalWd1FjjCg24m2PkgIxPFvTU0U0qBAlWOPJXobj72vqgo3e4nsl8HXkRtuyhONk0+8ZvBS4QHJRwAlkmmTKcuWLX0v4AKMiXidAJiCFHSjKl5kqGM+wrL1CC5ShjESyAnlUdkQqR6eJhoQIzO9TidSrbb7AAU6mriW/Cb/93FTaVruE/LLH0ADG0ffoGze+t8EIJ1x4dsn25fZIpwis49InNYmFfCF5TkTYOMbbZtymod1kKOjugx44YL91vrjyNs94wW3kEQLrSBa6RetRbCastO0UaW6sMDQWlwlIgGMx5iRDoZ7a8DK7LBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smHEdNecA9ZqpKdN+RjHJYVQJgAbL9Ywo/Z/PpNuhWU=;
 b=w5vjo4tLSAx1aV+FnjfcPxM7juI301HXt9JsY/9LxSiV1c/JjjHrkBxIMcY3T98TUXPe4q7/p96h42jXzAin+vJ9PHqmfse5exJ8rBg90H/RZolgl5lulAeK69jGl8vlqKqI2AEGICEDGSRoO09NHDKJggqYoz5OnD+rNMFVUki+v/RKTm+/YTRZVHExcJkNTDfNH1GNzV06FgFDnqb0Anfbj7wmdkQrCOd38OJ+z5xoQULG7KOkpUE0rrK9raeCp/aPXq3n13gFIZsrWvtrmkGrT8UEFQgXERNwfZeVAZNiv3VFKOdWgRm0E+fHsDGQrflSrHTayysJWm1+z8BhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smHEdNecA9ZqpKdN+RjHJYVQJgAbL9Ywo/Z/PpNuhWU=;
 b=NPIFjReiwo+vOE+RHdp1WK7kIiuNcYqO9XE+x4jJZxTcQix9KLFy2scEPn9MEKWMV0lDhE2mX7SHAkxCUv0Pu2WvCRWbA4vGisunpnK68iTAMFZ79k/etIOMuIf6IkSGIIfkdMf4KMNVbWZPbxgjQKPh57jKMeToCH488dMJW/pUk1JL5hGd9j5lfr6iD4TxjBzgyYlRm4oCQiwqGVVHtuOYYhvXwrUD70RsYV1/pjSYAK7InE02PXQ097LLcZWvQQ6c/5o+MC6TnyvYy5IUrNyq6O2qpcyyn1CHpQZQSXqyiarly1zr97Ics63ST8UcAqKJR7QCiBK7W3yUkY/d4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10925.eurprd04.prod.outlook.com (2603:10a6:800:25b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:37:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:37:01 +0000
Date: Fri, 6 Feb 2026 08:38:37 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 05/12] imx: ele_ahab: Add i.MX952 support to
 display_life_cycle()
Message-ID: <aYU4DYIm0k0gY65e@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-5-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-5-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SG2PR06CA0216.apcprd06.prod.outlook.com
 (2603:1096:4:68::24) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10925:EE_
X-MS-Office365-Filtering-Correlation-Id: 437685a8-041e-4ec0-28a2-08de6517d77f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IN6FQ0Tx6+VHkOVd7+7Qi7g085fPq8z+s+XXvHonuC84GhtFQPYmFCicJvCK?=
 =?us-ascii?Q?bnB5hmxSFnlCWVf4orLn2QSebsnOkMmUVtm3M1NKmnvldseFAmRfr9I74X8P?=
 =?us-ascii?Q?OXOgDDJC5NhN2Ij3DXjq+bv6xDFC6KN2q2S+Fp9lht/uVobevO6KCcwtCuvS?=
 =?us-ascii?Q?ShXwM7lCUwIybwAqhoMqJB6nmRiiQYKUdKh3m1EGGfluR++c7da5H5CTdhhk?=
 =?us-ascii?Q?e9hSMxfrkqA1gGHMBPGqyN2Pe6GL1VlHfbGgdrfn4S+DmW92vc0vl4WWsu6X?=
 =?us-ascii?Q?jggR5+xEB1vO0irENIrovexXJRVvJ/MOQ6+OrDBY72z5BuHpC84yi/12gyWP?=
 =?us-ascii?Q?rDwPIQRhebSlxko7N8zaWxfDYRGIs2GfN2WHvoAuMnBTBb5d4FbSSn+z2m3u?=
 =?us-ascii?Q?EnQ/CXsc8VBkQlWotqbPuk0W4gTxtFY0KHtBYBJcc6TwslfcRwA+9xbSfV5X?=
 =?us-ascii?Q?vsE9SZR8NxmZfDWda2Xim7XOktj9Z4U35TDPHcg475iKIF49D4KKcYRLFT2X?=
 =?us-ascii?Q?whDif/OoAGnRBEg+E2kC8FZ3izBsAqv8dB0Srzmgx2dN6DdBPAuYILlZeFBP?=
 =?us-ascii?Q?Ob1cwNl6KC+NcPm771VkcivCBbRMs/MVx41x1vg+ebLGs5aqe2RSQ9YJ2vWg?=
 =?us-ascii?Q?OxBFGEMLbPNrAL1g618jJbvIkhuQle7VQAq1u6CeiT5GBU/JhFzkgWGLBCuB?=
 =?us-ascii?Q?8NhFLWwOh1XzR2KCO+LUkdLxhgJnxv6nyBI39nXtAWtll9zTlqpNH38OVebS?=
 =?us-ascii?Q?BCgBHjlbC5pnCIpdg1oy5sS/0Lm+7TuZVp/6vq+K4ZW+Mk/3w5mCUT+r6EbB?=
 =?us-ascii?Q?m6sifprhrA/AGNXc3/wzpvV4o7BOMMY6NL1uLIMAdynG2IXRc+Gjov9vLncS?=
 =?us-ascii?Q?N5HDhza28Wogip8l0NUSt3MfGqloAngeYAIFWpw3xviAoOob10Y2hxbeLkjR?=
 =?us-ascii?Q?eTnq8TGv+rwal2UPkFseG492CaIaAPUnOI5G82+fARePcPOEw8JbRasBecTG?=
 =?us-ascii?Q?ieeLgERgVNRLbA1zfGLgbFHTIb0lsPaeQSr7JetCj7o6wNFSU4Bkg/sxFzWc?=
 =?us-ascii?Q?tpeylAB03uEx0HgqYbdGs6BoHxQvF0AR2BjkMD3DKSPPMm+ytonN+ZbJg3MT?=
 =?us-ascii?Q?mWyvUtHEGt2PMyBIPy7pCC9IZ5nlhI5YJMloD4MKcbbjd90iB4T33n1YTQ3l?=
 =?us-ascii?Q?dp76Dwe6FZtWvrZ+32VGz/9zjsCfOctV3mtG1pByeUlqRYECHKUy+iNAlXW1?=
 =?us-ascii?Q?JEfL8T/nN6xapK9v9w4QGa4dgrONb2ivDxSXLoW/ij8vFqhcIFuBgd4FvTJP?=
 =?us-ascii?Q?xNHs2Jif3q5xiA3yKieenEa/xLJPz3qlqfJ6Eu4Lj5j7PFUEVXciVTdjpy6E?=
 =?us-ascii?Q?EaSqKMiazbu11Da5xwGveL1TIuwxNW02p5V90vxgY4KhozI7joLDm5RpdyCn?=
 =?us-ascii?Q?aduBxnkowFjAvaVTNnoMKZRaYXL6YgxgDuZFExDjt80HK4lvuAvJUj3dKshQ?=
 =?us-ascii?Q?cYY6q32rvrcubDu5lXp/euIfemOR7EsKu45jGtOSp4irpR2WvcGJ3lOz8bkI?=
 =?us-ascii?Q?LTBYfsbPBIq+zNZLnnTWtwdS8PViTof1uKzTONBod5ZLdDZOqPAsPr4bg9e6?=
 =?us-ascii?Q?hsCsUYZvQ13w/9hiRLT9an4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nk1gb76YkbOWyta1PQWDHNXWIeW6L+aB/KZxKTyZqksNq8rHaiCG9jg9CAtE?=
 =?us-ascii?Q?53yS6vESZl5tgmKKd6BvvtR4hiGWJrKihcQ3I0fo2lR4AeL9m3NGvHzQtdQN?=
 =?us-ascii?Q?OH3uyQqVfijlZxOJkXCRDBpbfKYXrtU1STfm8B8MTRf3pHJ1ucDj47jC2lr2?=
 =?us-ascii?Q?LPg9BF4PKKsWpzwcnaKOt2M3SRiXnIAX1CpG1Pi+u8nIQ4a8mpuZRvhND2b5?=
 =?us-ascii?Q?2blYudR7ZFXRBitHe3YHalYOVIfotlZmcGlbmK1MPcOVvolfuUDse78V4JZh?=
 =?us-ascii?Q?7tXWHJaPhRDy2WUJ1CS99BvzKTIfbooUjglLpk0KD9LsiixNIIsLp0SVKfbv?=
 =?us-ascii?Q?kJoW/bKnrFklFttqPxCJAMoLLsiXrlJAGNXDf6hWPtRhfGIexHSEPRmdqtc3?=
 =?us-ascii?Q?bx/0Og2tfDC7cG056YoY8TrYXdcPa+51dKpwYesfP/r08Rkb7nWsItaQB/wy?=
 =?us-ascii?Q?bG1KOYMoeeR3BpPMWCCs0tJoExCfytPLKIBZGL0Ye00gqSxb3JwIHMQoJ7wP?=
 =?us-ascii?Q?6KywURSM3nOsAkWLoz5iAncYnnyzEUnUQJUW2TQNk0/Qw5KOV3n0JXGGvgRF?=
 =?us-ascii?Q?xx7ESJHxvIigaPlh1krVIxR49Rd0+6y9p17aTs80skU+IlS0TXeODreVsBtV?=
 =?us-ascii?Q?wSEkB8VZXXPuN7DZyuwmrDlt0hkRkHqTkbMlGd3yRfC1ke5tukFbyq9JpE8z?=
 =?us-ascii?Q?MKOgBHJESsvQHypVEgNm0UywV//G05ioZeqIUujn8GntzRbY7Hy8SIDRqS+d?=
 =?us-ascii?Q?FAPfKgIHSDfkxNqtjL4DMUTFGGGqVnb9ZKysGb3SuDymPW71iSDtYpuYNlDI?=
 =?us-ascii?Q?Q5NnnCvEqd31p+Hlp6+Svzf/ZIaiE1kYYEjNDFB5Z0RgZ9XA8Y9yyftYBq3T?=
 =?us-ascii?Q?Szyk8RXupJuNJEEWci5TmIu6QULucqE/Y5J+JRuLqG42ZOSRXAEEyTfljIDQ?=
 =?us-ascii?Q?j7ietTP7wljyxOK9Y/onqTaf/WhTxnds4pRLOlGG0e0Efj5xN7TGgAoORr8H?=
 =?us-ascii?Q?tkgicXW+9g1sK8OypqWZdzpMgyZqSSxppHmoqsBF6fZHwhd5Sfl10n7O8dLh?=
 =?us-ascii?Q?Uk8yUnsN9UMOJ4dlQDR+RrJkQ/Po8XAPzkIZg4KWYTYnZ0zaNUA6ZWKAUOmh?=
 =?us-ascii?Q?ecJev9iyYsatBTyuo4X3aK1BRw+mFGFoc9UgLDG+gKUWE3szNvWctJLFrHKY?=
 =?us-ascii?Q?J40R6fgD4ELsIyruJdV8ItmQ3/z68R7LbvM3L0v+aCrpUmIoAU0fpQsiuSAv?=
 =?us-ascii?Q?VTJFmnJAQA7d03CKihW4PwuPp+DhywxMXas5JR3jK3ZCZYBmp2/ywH+W89GL?=
 =?us-ascii?Q?QQZFkXn5gFDxCFBGE7pzK6iO/WhcXUQ8mU+TJJ6BxztY8qSzu6rpbFJtCdvW?=
 =?us-ascii?Q?TiMQCM0pDL8B1qEYh0q8df/lm1bq2em/RIJkrIk0YnXzqGiJhFGoldNnLpeu?=
 =?us-ascii?Q?W15yKsHP4tgMmUTr+qVl5P/iK2Wyjo3IPGSRgW/j6zvMbX959hrscAKHkB1+?=
 =?us-ascii?Q?HVbrmUMGoauwSU1e/Y5FWx3MIWCKczAX3bANjhOMUCTBNg4AvwlOwbkIOCl2?=
 =?us-ascii?Q?UihMlDJ8C8NyRhTxSUvHEc6R1j1oDMT5Q8CFe/chGswcgT09xt84LN4d0wFK?=
 =?us-ascii?Q?WUt+wdW44xVloc+Sw+N4hXvQdiBy0y3ygub9AAXHE7dCX+T80nDIbDvnwcAk?=
 =?us-ascii?Q?bIRcxKztdUk7FPKEdSJIU3Ja8rIecfPoQ0dvyAYGnbjEr22B+M9kJ5AHJl/c?=
 =?us-ascii?Q?wfEZRyZh7g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437685a8-041e-4ec0-28a2-08de6517d77f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:37:01.0155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IECp934MS5Q330gCBz+m40EHOoX6uZYOmt1GWesfU32fatYV12QCU5VpKk2MspyY6RRTocnQsWoRmcamRO9jTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10925
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

On Thu, Feb 05, 2026 at 09:55:11PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Extend display_life_cycle() to support i.MX952.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
