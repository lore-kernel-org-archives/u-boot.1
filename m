Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B739CCD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 04:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3628680433;
	Thu, 11 Jun 2026 06:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J0gZn1wQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258F484704; Thu, 11 Jun 2026 06:11:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB8880086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tupHRXgqcjQMAdvFr6RD61sr0BzNbwaLi6NRktwHMZR/RXrgfKpxDRgXM45HiKEJMB9JPFAQpQrTSr5A++Ao93SZW7pt3cCekvIYcwDuRPYRP8+KLxYb2gcrrp+CLO4UDJYZOEkKB0mFNBdEy1VId7suA5179wOowdCIqeFh/8r4MK88xnhcFCWFOyzblmwgW044rhp73iGTTZ5DPXMlqMx6Qjg91oDz3A4bSE/gMbuLVQjxzMQEheLXOHEQ5LCu+EAZPA0csXhDGWnlO7bJsFWCT354votAOr7CGzyi5pToqIefLU/AKJCQFdZ43AI2lT0nviDGow3r+VhX88M82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dF8Ruw3mNh1106ZRhE142swwu0j6CjRTYSuvTiM2GM=;
 b=RYCr7cPDimxClLAr6K4syLjA6idV02dKd8j+078UA9cVeDAzsv8rqJTnjjfIu6dpYHM6uj2OZXM+IfvF5D5YiRAzLNehKs0klYcilFt8w3hqZ+gNgWBni2zJHSC8Xdka3Ziw6snBo1w1+IUcJBVrmlGzlMFnaIKMUfJLtR8doYH8O1UuM7csTn1GgWYiQGf59sP0JDvxuKCuz7fL6oKCeNw3260OM9qWG/rrpZBKspJXFr3Tjutp64IDzZUtEfepFMAdkhXwSm/TS7f8jd9oPmXlJsT7J0jSD6sxPT3taAUeJbKdwoi3hAz1hkdWTztsODH468k1d4tFN7o6vEXLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dF8Ruw3mNh1106ZRhE142swwu0j6CjRTYSuvTiM2GM=;
 b=J0gZn1wQnIKt5bjYp/hTPFE44GPOhbOBBVf9M2+9oNQdCxCYGJIlQPP3gKZoQHikuxLHKwQZNaSu2tmSwxB6SDzo8Ln9d3n2puk4SQWHPYDcDx1lKuf4fOAkxJTnLbQH/G2+sLnjB644dvYcqYZDe4XqemPwX6UMOd6sLNGYQlT9YgKc/xqzco4t1sTjx6HsW6xGqX1U9vXEoBcZairUnedhcFi8IOb02c+nSyhSnq8K0Vp1s6lY4y3CixbEwMCISKbfneSLLADsJ0GA1ncD1hwLxtuuAN0SizvnInpcGQhjlSljlOHidulSXnuzfid2AK31b81o1RD47X0eX6wVXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 04:11:42 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 04:11:42 +0000
Date: Thu, 11 Jun 2026 12:14:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v1 1/3] mx7ulp_evk: Move environment variables to .env file
Message-ID: <aio2PpOhMfhEyzBl@shlinux89>
References: <20260610133336.15999-1-aristo.chen@canonical.com>
 <20260610133336.15999-2-aristo.chen@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610133336.15999-2-aristo.chen@canonical.com>
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b1666a-655d-4240-67a4-08dec76f8b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|19092799006|4143699003|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: QytS3axD9Xig2sSLm6Qis3s/k+cmV/voqPnfMCs4IvpDeI7bTfsuTRIMApIgD1SB8kBL1Dsi6RQSiSEKqEaijrnb5Th9Rmk9DwfzjeULVErpkFu/6wz7zH8yc/IhHbFB3yvN4DfqG4Ldf+Q8bzL35rhmCvgKBj65rkbd+6wsGy38/hSZ9QSeTahE0Xda5e11T8APheDkjxNgOPVAq0PaSJiFFjRTKOpK5bW9yo5k5yuJ38u5J0qxnsTcrQDiu7XIysEw4KFx59eH4eeS0zFlk/BlKRlAWwgBIRfLOiUqA9nDGKVz/YWTRRGVfuQzJ1Kgq4/4BCjH+tZdexFygDu0+O4eHx26hUHmoC4xBYPv5QC8pp9F9CTcUSrp/lsuvzLnUAW8k8RQmP5IiHR4u/CrFRwMHDB7fhTFWTYuODFseZ1xYbgmiZd82xXEbR22gXDGXB8BkkOmO5IeMzUbkDN6KF1pyb0zVte78aen0UZmY28cIX+IzqrztE68yLdYGMtNtiC5NRbv7Prkivu5DW0DCiq8z/p/KhnD38B/3cdMMXDjBa+JC/f/RyNL/dsQbOfoLfrfjt8Z6/xJBx141HNARMr4FUHBM0QruZfFaTrwtevbFwoKAsZ+4K4bjFOENHu1aAFkMx5Hu/apAJXtvmMG1VcvfNzNb5iZ/fnVCLjnENqxpUSt7hu3RP5rwM+YVDKW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(19092799006)(4143699003)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPp2pYDd+a4LBfv9NptNmNIGDDPBIDsQBlr8fg8dIaa44mf/EztUls/VMBhP?=
 =?us-ascii?Q?ECNj7td8hEbVTpVX6TwvFbrrARTTL9YMbLysfjZ3cr9Jjz1Y1Zn/OUlWzJ9w?=
 =?us-ascii?Q?idHprWSB8tNSX4xAIgeHRAz9e2ILEHS8pkTjvcKQg8VP+dKhco5nv3ascb4L?=
 =?us-ascii?Q?ixGIkOo3ZJe7e8JbwEV9MXLJt12E0GwGJZVErEa24dlmr115JsNIKeEp4G6X?=
 =?us-ascii?Q?vjKySvplWeehp0fKetCVh1V2AqKPiAW0+02RMtApIpJ4KJhFwxrMRewchpOp?=
 =?us-ascii?Q?0ilEDUn1mMg0Zxl5QSBn6DYyMzxEdVFUHHrPDGlwi2F0ol0eEIfaYEkMOWe1?=
 =?us-ascii?Q?OGtPQ4Xe67QR+8+9NiQiMwMWkX1uviBl0ueGkrP6yn0LPe6g8MNDlZgDampb?=
 =?us-ascii?Q?OSWYjPvVWmo5uYUVvRVpGNyEvjaTYo40NC1/H5jhS8omyd+btmtBvudH8Yx4?=
 =?us-ascii?Q?nuy86NoDpOeDod5kZ+Klgo0UJIwvldOZEdvOQEDmtzRfcaGpdv/pxYA+7e96?=
 =?us-ascii?Q?z/bKHlX896i7tq1q61CJUSEjmayzA7CyoGnmK3LL1K/vGfFvi+YpdH//6laW?=
 =?us-ascii?Q?vdNuNYhJ4xmagrMIEVug+U/uajJOZVG3dXH9+HBJ9M4dcMuI9KJd9/OAayJp?=
 =?us-ascii?Q?qRp18V6eKt6wtDcFOxtXvsuoZjEY843+cndynaXl/HLxsS3nJufxwYgpawj9?=
 =?us-ascii?Q?zO17bE6Bg9FbokiSLzy9/xzlDNSfIe5L5vybB0kRcQvofDfbz15ElnuaX8Ol?=
 =?us-ascii?Q?bSOa100zH/fg+rXUo+PjLScOkTosHKGJU3SgfHJy8i5yNYt5KofwMtvPz1Q9?=
 =?us-ascii?Q?IeCGf0KNHcB4//FnMRUJvyTU0KssjjmQRy2PbnPWMbTFaFdaxELg50q9gvYq?=
 =?us-ascii?Q?9lP0jjRKdLK7BFHDOrm+uouXfE2hGcGwEBX57y4DW1UQOWdLAKVaBVias6T0?=
 =?us-ascii?Q?qSSXDZH6zsv+ar/cgNrNCR0Go5DusGtpzk0jgsNhr1xbJPhcSuJDWGmmcS03?=
 =?us-ascii?Q?so1xtYeI/xrylnk3G6d/72ZFrgklAvfJbkYSOjbCQm10S9HuFqKq3s3HoEaN?=
 =?us-ascii?Q?450YuYavXh485PUrrDAH9pUBXnbiqLDGDXRdoTLm4JUT03IzFF3e8KpFqmPx?=
 =?us-ascii?Q?JKcj1jbz7AXJB6/seeeQCRqHqiQ8W6sz1ECPe2rUn3K87oGuF/GzPhIEsIwO?=
 =?us-ascii?Q?jelZ/WdGzQKOAGAcLEaIXUPuMQrg+yPwPPhify+gMn/jg2a/2gI/tyQtheLN?=
 =?us-ascii?Q?y9/gP5brfRWiGCPrEDa/GyJUQCsHGbzm82JiN65AyEUkVsLIkT/wi6DVS8Tp?=
 =?us-ascii?Q?Jo29rYG+ot5yC9/ow+T4WF/N6xiwRktJudQw2mZuLzShK3fDjcdJPcUXKpLH?=
 =?us-ascii?Q?6OIoI1Y5GMhm7VG1ARurGXNo4jUm2qDrOOfCRw9mX51qYsebBuN3vNWlP7G6?=
 =?us-ascii?Q?lFPeGSR/8NWk4bDJiPthLq+9SG30lgwpe2hCrljG4Cf15ayY4RboBQYDTXyO?=
 =?us-ascii?Q?IgvL0n+UH0rf3Ytb8T08OY1plX9jhX33i1q0iJnoewq9lL6kBoZeZ2nmJm1O?=
 =?us-ascii?Q?gWE9SvdYV89Bj51u78uDjauxW7eKEynhDfJiT/YwPAthZXk2/J4uL1+g9XUj?=
 =?us-ascii?Q?B+rj0xggLx9Cj1ghJdLgG2+pvaYUdZBtErq7TvpOMpN7HfjgHzsDt3s3r39b?=
 =?us-ascii?Q?5eV74YJc/a0Ch9lb1HN6mMWf//USFZ+Fj7mrtgISa5w4HkSIr2lvcEuRYlcv?=
 =?us-ascii?Q?hehDMYE5AWHR34WyKAiW/VOv9HbYSivMCrV5s9ep0wFIaS5xHl0l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b1666a-655d-4240-67a4-08dec76f8b53
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 04:11:42.7021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyI5e2gjMQBd2k/qQAf4Zu6dnAYiYcwfbDcKcGecU/W5BdDbHAetj2gKbZdD+9B5ROKsZYX3oe4IexRI0hkbo9urq803Uw8atPhbLT9Urs/CpmRM2xl/G0KRuaomwIQ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
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

On Wed, Jun 10, 2026 at 01:24:22PM +0000, Aristo Chen wrote:
>Move the board environment from CFG_EXTRA_ENV_SETTINGS in the config
>header to board/nxp/mx7ulp_evk/mx7ulp_evk.env for better
>maintainability. The file is named after CONFIG_SYS_BOARD so it is
>selected automatically without setting CONFIG_ENV_SOURCE_FILE.
>
>The generated default environment is unchanged. This was verified by
>comparing the output of scripts/get_default_envs.sh before and after the
>change, which produced identical results.
>
>Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
