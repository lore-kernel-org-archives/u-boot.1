Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E69FCD37AC
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 03:13:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B243284671;
	Fri, 15 May 2026 05:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BIz+5jXx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C510884683; Fri, 15 May 2026 05:13:10 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2FAE8464D
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 05:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeQs2V9vIag6tWMX16mfQlC/Zerz/Nc7oohoqQXfGwoThI5YgAnnaRhRkYZUiZ5qgG9mekMVBRQG8CUjLuvg3T8RKWjSVq3iRVGoA3wRjgFiNpPSYX5gPPyiVjq2h40gScVSgTlRHRzT71SaZUv/04Ts6eNVXQbMSX2e3SPNA252e0ao3bo6lOXjAzTojqBOohkZPXk1N00a+iO6i3J/PbxbNuIAyRh7enrEBKsI38PxYT3Uf2hpWQnhvcAnqeYxyRPZmh+ZbrKHFkJ0ZdIOqryVj2Sk0xvia4iX+nkbLasi5NtdLb7NVlySM27l1Z4cxGXRqxEcvKwzDBjAC9gfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfAEddiQHazlJvtfT2jLBqMfaIT/7Qjhig+TzcFTRS8=;
 b=jt5SkjwpM0lq5bc/x7r+oYcgT1F3gtwNfAPXDdeHWhla50uHOQU1Qhgj66haOfkjz7rKQ+P85Uob09dYbe3pmf0ffg3hIU5Zu0x51vX9RrnYm7meqtQyCU3mufXoyqv7Tb8gCR5Y+vxqSwCkaxllEd78V/Lb4bbE8qvWeEB+iJxihVygyJyb7DMjnguwqJn74IeHszG7NeNZX36/1kBqHGQ41XM9VTBTaFmUYwr2KvfSp4xBngdqrkfrDnuW+sI6o2te+M6IUrNOctpMMk5vLHWqW7YRjB9UzAFAxw9t6ebG72Jek2RDaMhYX0YPMUovp6CIwbDvgaTDvJg3Y0M4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfAEddiQHazlJvtfT2jLBqMfaIT/7Qjhig+TzcFTRS8=;
 b=BIz+5jXx1odNYegbONOaLRfFA/TLi1Uf/JWdbuK0/GBtKJX/PezlONeHTjcVyomzI+oaR72sjx3B4wSQzdGWMMhkm0fjj8UHJQB8x0WL4z9xwX9IvSj+2mdJ60XEcosyw5JSFOOdcnrfrlr08BhQa66E/IMlMPuGLSr2kQIsNXrhSA9C6Pu3wIRocCQQ8tf/kR5BQRPke1WfGoysmF4JLHOcxEvKYC1lkWW5h6Lc9BdtClBKm4GfZHBNjiTKLf51ftlqu3dYNtazZGfv7BnrvGvjTS5jdKGVGvyyvtSMZJQ2lcnRlMfYX7SwH9IXbY/mZ/xTgA6suGAv5t3BoIrzKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB11484.eurprd04.prod.outlook.com (2603:10a6:800:2c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 03:13:02 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 03:13:02 +0000
Date: Fri, 15 May 2026 12:30:03 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Marek Beh??n <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>, Vladimir Oltean <olteanv@gmail.com>,
 Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/11] Generic powerpc fixes and NXP board cleanup
Message-ID: <agahS5cswY7_NXJb@nxa18884-linux.ap.freescale.net>
References: <20260506123507.2081751-1-mwalle@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB11484:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d77cc1-0826-4d5a-e7ae-08deb22fdf1d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|52116014|1800799024|11063799003|22082099003|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ff9SqCxqrQg+qKBIUzq2MlM1cbaY0HyedyYtzG56iNtNBPgG4svhtFFB9DGOEQlm/cKzJk6hDoDM0CVq9Vcdk5W7MVuMuOIO1ik/9eBg50/iAEiYliQ3Bc+ZCObn6grPjkfLio4cmPOcxRkyFn1HHwZxmrMP2/7bAH2zTNv3tPu/je3FqNbAIMo/tLoeFc9Si53vej6JbFnr68C5PY3vdWG/+UHT/AroEXLEnH7GopgFVTvn4qcZBRNLJWdPa3KLUy9qhYtO2Tl5C88XswX4Z0ijrGDm0SPQpoeXG61S7nM8jyVcs8pLx878vSA/NHaLtJ2wMMFE8Byu1u2I0sHHwv23tpJ+lUMzHcAlKv9vdRzPXQzs1HVV3wzzZULLmG7YL6R1VRM+hWetGK/NrM2Z3JEb9JowJAUkPVBYMuw6LU7LAwhATxCX5xo34zNRqFKJVB1+4+1jRq+UzgnloEo8AU89N9VkXFD5nF4AZ9E1MnAli4dzFaqqicLihqHdpIpW3JFkA8xVht8cNdRV8/k4xZ8pIhDTsYrfDM05yigVJh/qbi9RsDHI+OIONuC5oCKgJIYF5AjmqskFR3x+Vv4mS6pWIrNh5ksZipn8Tn7Mj3H5eWtP/YfCYx8263ZWMZNItXJjLxpLO5lk63FALKtPuS1pMQL9T3uvHUFWN9lYeymn2bivgzet2kYzapx32HBfnRAIBFgLqQRO2PGUO1SMB4SDqKdEvhXsiEuD/UscNWTK1lUOBUuoalRktwxq7Qdo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(52116014)(1800799024)(11063799003)(22082099003)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VP74a6osKZ7p5/YcDAnV7wRUvZeck1+CNpTyQaIFbVKxAezkFtNOCwYMYN+y?=
 =?us-ascii?Q?JS4gmB57m5/1SGT+bx+rJeN62wfHKhVOUjL6dNs5dahPpqqA+F0Ui5ZIPPgt?=
 =?us-ascii?Q?EcTAxDv7Jz46xIZ1ne71Mo9/oosbAhPC3k3Mk4Q5FMQyoFy4vMQcTTWKILoh?=
 =?us-ascii?Q?tUwPmc/s1uqqdyGJNaKpL2OfJzUM0iZOYcolFcKegTT2kRzDcTxIucV47LoP?=
 =?us-ascii?Q?3vLoHQfQV4qVk9PMmdpJcz/TUGJhbe5pQzE1YqogHXGusZPwIP/WSd+hUGN2?=
 =?us-ascii?Q?5z8CubichjzjPq+Xj23vN6Ohm+K6wwXV1C4kWqaguF9Peo8SjIvWKRbyGz0q?=
 =?us-ascii?Q?ShdjqymG5k0PoOxSm6jkUhjRshwbPcFdekO60ME4Snl1WbA5eHtNa3Gv2P99?=
 =?us-ascii?Q?wJACBvttIdLUfjDv5cD0pfgJ/82AaLf1PCRODwsJpu84eoKOiBaRPcR5dM3n?=
 =?us-ascii?Q?rhzmO14FqxfN+4jzWzcDqDl+HJ5TYiZyK1akmdEifEyyTuijJ5TXS+K+58fy?=
 =?us-ascii?Q?XfY2y0Fr1rJzBw87O35Rfb+UplFkwIs+qOqIGQ7eIsCuEa+q0eUl2b6TkBpJ?=
 =?us-ascii?Q?Zexq+gP7EzcQecjwbzb0Hw8zvoBTTZezWLAbUC/v8TZEIHwWM9uTIKxNlHIG?=
 =?us-ascii?Q?PTrt6rSQHiDp+pX50Run0QMSlq1lHdNB4Qwyn9H6S2GSlVUmhmCCtVgnGZYN?=
 =?us-ascii?Q?U55TMXTlEyM/uOGhZ/PxYM0ZGET0aWLTEViXBtPKiWd4o+w5NPptdaEanN+P?=
 =?us-ascii?Q?u0XQ5EgI3cBnNZd2nghujF25zZbFsBshdqGd1538yyRm3VsIIbEImIxF8dm6?=
 =?us-ascii?Q?vVesXaEbRiPr6rU4eVQWnDIDxdP6nBZu4sAbDl0Pi2Vn3b4ypdTFQlcnvowF?=
 =?us-ascii?Q?w9pQSraQHgXYT2CulmwWln0OQX32H7rWRx3rzk64upGelsomW8e4ufN0o/NG?=
 =?us-ascii?Q?WjgeC9EGrf4VkdV/L2gUWYkaOEr2MwUUbrNKvZBbpMENpgIYx4pvfW5gHw9d?=
 =?us-ascii?Q?rfl2FeFaupLDcXDZE4cLnAI+eX3yWYBxZUbcvvCtVMRvZCnVhUtkp/6L33AR?=
 =?us-ascii?Q?/E1pQTxbCBlmQCV8KaRqGR2JfLCtGivR0CFpGLKs6sYzcmdTNcdSURmWBWK7?=
 =?us-ascii?Q?s4RghdPry90zFANuU+2LNiM9CJa0u4u+AEDKrBB/ZaFqd+oBlMvxCRBxzVNv?=
 =?us-ascii?Q?bRq8caD50Un3lFCsWrl3/kn5GJ8x4L+otRnvcshZGby389vVcVJCmcrrq04i?=
 =?us-ascii?Q?NtRJeqTrzUJrtJPrlgVE3f4yqPe2WLvEz7XW383IMNTU63GhSuuOfrnP6VFl?=
 =?us-ascii?Q?Hat499CBLoG4zlQ6dk1EXKAUlRIntN5IvnEviMLsLPQ2Epws62ae2tJlFzx+?=
 =?us-ascii?Q?kUm1ObmT0baM0qynMGbX8/7SP2PK/e7dGQjSOVcNSGWziWnwZVU+PSzEu0pI?=
 =?us-ascii?Q?C4+C4TljNsJ/ujhWwxo/vbtInaNYtf3osgy5wOEmrohb/YthENxrp3BdoRPV?=
 =?us-ascii?Q?bYSbu0RLTghz78R0nxkHdRUksTD35sOBpbOqO+L3V3YxExbKxfXjnAUgfNoR?=
 =?us-ascii?Q?sCHCn2FJub+QP7saM3N3HGHnSQoazLWDrcnDXIQW9RNh1BAdYdroRp5OpTn6?=
 =?us-ascii?Q?bGfE+33A85BYI6Ow3rnmfrSGVGTbPjb+J/shnOKoqWAzNDaQk0Kt5Z3vLZw/?=
 =?us-ascii?Q?kM0Hcmk8mA9SJKFYaxBsg3Xm5SAeM8x0bsjq+7X+2JLJj1s1l/AQiEqG7KI3?=
 =?us-ascii?Q?ABzve0t4Hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d77cc1-0826-4d5a-e7ae-08deb22fdf1d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 03:13:02.0692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w41pEDsisuZFhZg6rR1zctPy0cNXb1XwjL89u//KQu7K+ZRRD51wWeItkbcDLYXAqiv2BB4rIQGaR/eHV23lSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11484
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

Hi Michael,

On Wed, May 06, 2026 at 02:34:09PM +0200, Michael Walle wrote:
>While working on an ancient P2041 based board, I've encountered
>several issues.
>
>
>Michael Walle (11):
>  powerpc: fix call to cpu_init_r
>  caam: don't write memory at 0 on PPC
>  spi: fsl_espi: fix read transactions
>  boards: remove dead fman code
>  boards/nxp: remove board_eth_init()
>  boards/nxp: remove empty fdt_fixup_board_enet()
>  p2041rdb: use the upstream device tree
>  p2041rdb: support SDcard boot
>  p2041rdb: update README and fix typos
>  p2041rdb: remove NAND defconfig
>  p2041rdb: convert README to rst

I applied this patchset. There are some conflicts that I fixed,
it would be good if base-commit could be added in the patchset.

For the last patch, you could use a follow up patch to move the rst
to doc.

Regards
Peng
