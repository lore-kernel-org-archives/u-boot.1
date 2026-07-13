Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3D3C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 08:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965CD84A49;
	Mon, 13 Jul 2026 10:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KHz1WNWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A4B84A4C; Mon, 13 Jul 2026 10:39:25 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B49284A48
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 10:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwxoMsP8LQxYqfFp20V5lPWiPSD786CXId64N5OZ23u6B4dlKlPXiFhiIFKtFBBePR+n5spLBQnR2mKfmYG6SCef2jnGGsLTRkos1wWxdcm976H5Ey6seFhWX+BWsFmvBDxYO15ORzSJHJKbofA2DbRNvWqbatDUF/p8A7OwJLNwBnRXGUpxU41Vcqg/vMeX3IMUUZ/qUCwY5OnEqmQHA658jmLJTh2ITsNhL6v79tPfEo7635j60g99A9V+2c15+Ml+FIq932i8J4Sfv2N4EHW4oH/jUGzONmIF+ha1DiLkkzelOClaZ7bMA+AfNGqmIOcKtCRw1DCUodgWbgPuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aWQPAWJU2SuTm3DqDiRkebtSLyTRp3fN2YKS4pMgmw=;
 b=WjbNttSD2PgwWebnicXe481LfN2ZMxEUugRaLjwYvU/CqkV72NS0U/hnC/TmndrXZXIT3VB5lvKQXDkoSkI63H4YTboqyAc6q3Z8N7ZxJO4ZZ5Opissh/So3LbPngRD6LqlK+ocmb7JANGc4w/jEoHIfCygNahpX/+8KlW0xk109UuAmBhJKJw+eeBeXh8NNHHJl0+7HkISXav53i3XvsFH27fct2ggQHsl0bQm3nOwP7M9uUB+0QUT3syE71r1KOwyW1ix6e9wi88bnd9wevRMNqyjFoHrJaCd6zNgYbOczRux98vhCmudj24sWtfc7Q7Q9G2/EnzKZP+70HgnhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aWQPAWJU2SuTm3DqDiRkebtSLyTRp3fN2YKS4pMgmw=;
 b=KHz1WNWV0wUHYNNaKm0Mgk/C2eA51/kPrILYzTYqcIGdfJUba2Qp8S1/YO4SjEtmeAOeNuw7BdIJQD+muPSh592oor/VR2nKvlNCQHQhqBb6GI1cjVRAJCFHA4eGZjuzhtyKyQz7r1fYEcNp2ZntwmH6dVTSMhxGpIAhcm9HfnqkkA4pFCjrSlhSnS2AjMiRBRxUEmbyjNVaQPBASb6FjKS3dkXvtG/w01P3WR2ASYNykbojM2Vd5GIbcAkpQyQ196EcPvoB7QkLz9fIMwnvWdF1VXfgGTkniwcAu+bQuq1b77bwMm68oZXmvTfhxNCi1fJp5KFOWnPVyfn+BRn0MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB12166.eurprd04.prod.outlook.com (2603:10a6:150:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:39:20 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 08:39:20 +0000
Date: Mon, 13 Jul 2026 16:42:52 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>,
 Eran Moshe <emoshe@gsitechnology.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/5] mmc: sdhci: fix align_buffer memory leak on
 re-initialization
Message-ID: <alSlDBuE1fMQwZ1g@shlinux89>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
 <20260712-mmc-fix-v1-3-99a1136bbe54@nxp.com>
 <b86a6dff-b055-490c-88c0-bb320b97fddb@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b86a6dff-b055-490c-88c0-bb320b97fddb@altera.com>
X-ClientProxiedBy: MA5PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB12166:EE_
X-MS-Office365-Filtering-Correlation-Id: 262df272-7c83-4e46-02d6-08dee0ba3b91
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|19092799006|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nDr56suCjvG3p3rgTHGlOehIOAl5nuQPL4XKhHOPlPc+0eLmYHGLEt2y8ndT8e9HNPagMwYSk+Ae61sCTGC/kDlL0Ru742lTjBzK8y7vErlmCqWSeZZP7EaGPcoWqvbTI+1Z9uG12rNXz0KXwoaFyxSst1VTLtwQgscOsO4qK5Wm//KQZ2LfoFAtxbskYWGYPqwaMrY00WNt3PsC1S2aos2Lcx5ob1lwMMt3OTGnx2L8m2oGQK7ya5AmuyefCqc20aThBcDGPJV22WzXUizStnynMoOjHiCC+6JegFKDvn88Ict6qRd+M4+QRa/bvT3LwYs5LWE3uiW8Pv/ZqIThRCt2lFrYzNDW3InXUYAXlsNjzTeMg7c+BbUlYuxjCdHFLr1FyraHBPaCXSeageANPCoNUVKcbXdZ+I2Hj+0AUERNb3soIlOGKN3pGuRqNsZhkkLL18Ihhjs5aIlh1hru0LZ1Z3i4Mbw9h0s2Un96Dif0AMt4myvWHiK0LeKR/+uQSWJsZ2lnAAUgQW4paJ+TtdyQ3ijLptWSUAQw8EzmTUbLcsvAI7bfOS/40QYqdW4d3suFLbxHDQ0p4P2SD9wxxMevX954v13JuniEez8Ngfmbhr50DwGR76TEla3MQ02A9ySD864C8HPWcSaB25m1KUx+lOsA154ouaRTnBdqzuQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(19092799006)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Us7TKJHEnn5xtco3ohuJb8LjUggIJaSAcfqMbaijbsqlVPkBFxhnJ90xfVe1?=
 =?us-ascii?Q?C88RPzzYTPCs3bRduiCya2RyxeuG0EIb10HIJiV3DRp1tBEClt/PaRxicqTK?=
 =?us-ascii?Q?FQCGY1bpy0AujD/ZGvZUs+UhZbTir12Z+fIc32+WJi/j5yva0Wcym9MWFa2s?=
 =?us-ascii?Q?ZfyO+MEx3GFm2xaPAlVbwfalpSfP3MOtHtPdR6lYRPs1k/ix26PNMjUGhkHy?=
 =?us-ascii?Q?wJeMnnWKmMVUGsOnhIqm4/vjcd/yu5ZICN0RiS6/aHco6xPGek/DwYJ54Rm4?=
 =?us-ascii?Q?+Czq6k0vn8tzEDbhujvnvCai7/Ir7lIleDkRtQzGhL8afod/STvDUcOop6tp?=
 =?us-ascii?Q?LY3iCe/Tyo4shr+SlVlzKdSb6XKyThb5KHDlkgizXqi+eZc9wwKyyvluo4n7?=
 =?us-ascii?Q?WrSAerz/nv4V4uUX1nA2MscDzL7itXyMV3ocXhFYEiCikOAI/orm3W72+iDH?=
 =?us-ascii?Q?r8vl7miK9ehEXQAzME3IK3duAEwi/lXvfYDA84ggDiQqZnmILN1hsHEQ2bMc?=
 =?us-ascii?Q?CpGTjL9xUoq4pyJvcT4zRvx5FkIGt0NvrQxxMT+YlaoAeGv5gUB+YPOPs4/q?=
 =?us-ascii?Q?3/nKu8GbO/abxyp+Ee5GJWj/EIf6542a1cuZBPxntcBjlgHbyUJ+26HERFKM?=
 =?us-ascii?Q?yar+f8RT4yI7EZk22/KiK44Af2jJXM4hKS0rO71c545zXKuEuuDXtMaM5Nl6?=
 =?us-ascii?Q?uXlqfgfFosmrt97zrxd15igop+gxzeWQNoRX2CmWzv5J3y1N7PuMftB8r95l?=
 =?us-ascii?Q?4zQzaif94tQOoqGfYE5fi7X0QP9YZYvS2Bkx0t1Y8lkju4LF/FGc/WTtsxqb?=
 =?us-ascii?Q?L7uOQvuL9Qe2CMMoEd081rK2+Z8+AuE3tH6Lzns64vZKgJ3qpXmOjI8H+oKy?=
 =?us-ascii?Q?TFCeMtg8Lsxbi192jS5KiacIk628vbuEWsehad4B7hstlq0IDcEMTtqIwiPt?=
 =?us-ascii?Q?ncCxck29eH66OfBG5ljipPhjeOkLcKWnb/hAurT0MAbRqbIuLPtZ5Vpy8UfT?=
 =?us-ascii?Q?bYLnzzhweiydTOFyz/g/Ke4fEgNexS3qp6Cdql9fMud6bPjts1mACL4RC42J?=
 =?us-ascii?Q?02tS3ymBm5zDYEhE+/6wp5KSPDEC9AksSXwlh8gKNqQNiGyDhR/qvJNONXw+?=
 =?us-ascii?Q?d+oBPY0nTh5Gcea/On2+zw+y7zAd6sCe96n6YAKULMa7dSZa7uDdWYEITIGB?=
 =?us-ascii?Q?N3LymbyWb9jGooVskHGv2vEJUHOS/6if/pQ6rLCHLQ3L+x5PksFCtmX9mjmF?=
 =?us-ascii?Q?F6k4RZ/QBB8KwGl/iZxLGPHb7z/voazmN6veRbGpHuknn3TNGtGOtmtwzaRR?=
 =?us-ascii?Q?H0rrqaTK6k2NgJ5RL+/SEpuqsM/XJv343Ahcr1fy0/+K0pn29Fz0nP34JBPX?=
 =?us-ascii?Q?XfoAFj+ca1lY0R1J79FRyqfVurcTEpM4uHkrp6xGwwHhW/6SU/5s1Vq5Wsmj?=
 =?us-ascii?Q?IAtWhgpyk5JGptGht8LMhOKHktKDMvZW3n82fctxI3SnhISsgd+5KHrD4bzP?=
 =?us-ascii?Q?F8nBmAJ1BfUQ/TdFXMa8ON4WamXp84wzZuQzE8sS8RggrFcSNszuJ4jIlZuJ?=
 =?us-ascii?Q?/qeI6afCx9A4eFaUsQ71D92ThRj+T546RMbMM0AjN7nm7EhNm3UPaxKYLY+i?=
 =?us-ascii?Q?Hl3O0n27K/p4Jd+xSv3Ynw1xrG6p5zE911YFlwn09AaYF2pDvkJtmwe+W38S?=
 =?us-ascii?Q?1Zhf5VHDxZE8nJnR2Sx+qU/g5nJ8GBfrIlo4Bw78o2E3RQe24sBA/TzklnG+?=
 =?us-ascii?Q?MhLU8OtBE/0puOz4dhKx0JECey29dz7Sv9VWGsUPOclj8+OFGLtV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262df272-7c83-4e46-02d6-08dee0ba3b91
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:39:20.3887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krOT1BdHswRGy+HJv9k8XiF7hREl841ibIUOsxepbZrq7nvJdyAAQZgYowM5q1TXVhcQJ155AJS7eakcRL21WUL/eVasyvPtB+FD5CDFU7jdEkncDso74uSrwFlpPv0s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12166
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

On Mon, Jul 13, 2026 at 12:20:10AM +0530, Kathpalia, Tanmay wrote:
>
>On 7/12/2026 6:37 PM, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> sdhci_init() allocates a 512KB aligned bounce buffer for controllers
>> with SDHCI_QUIRK_32BIT_DMA_ADDR. In the non-DM code path, sdhci_init()
>> is registered as ops->init and called on every mmc_init(). Each call
>> allocates a new buffer without checking or freeing the previous one,
>> leaking 512KB per re-initialization.
>> 
>> Fix by guarding the allocation with !host->align_buffer so it only
>> allocates on the first call.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

This should be R-b or A-b. I will use R-b if no objections.

Thanks
Peng

>
>> 
