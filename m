Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A34D73EBA
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 03:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE068418A;
	Fri, 30 Jan 2026 04:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sY+7Bf9z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF14841BE; Fri, 30 Jan 2026 04:43:26 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461988413A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 04:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTO0tHVO3EgeSGaHtw+KDH7AU/ZA01INqdpTftAU2SN/Rmq6c//kNMjliwu5K95Qrpd+tWULBCINpwWT31Ro4RCch1Z7rMX95+GW0VlNmkoUUjdraSmozlGJ7uaJ6z78JldbfsyT2Aaex0sXMQEQgi7MbBL1rlqrKONrtvllOZUTa+OFYpWoY/RC4FyGfeiiiPRc3CrQXpOLQVLzccIZNKuOukS2rdowI/6ui84Hy1nPY2UocfpVRJadEhpOxmD24VoOoU+W+iHDzApbq9DTrBwiuQSLqHbhExGf3pPudJegEHqSbu8GSwX+KxZiiX0Uok43qrB3mswQYDyt/z4JQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6nRYhZIiAPAK/0AfGJEDwketiyzCULQtEXYPOvbKvs=;
 b=ggkwoLvZQqZF2rcmDpdfEBW1KEJDB6U7r5vyB217mLI63v+dPSuKrrKD1dots2gB9yM7ScqVYsMqaQUN7zStbbxbBIO2STTBBNb0x0gYfMhgtldgIdrs2P/M6bPej00isGm7l2EsSx2FYG3E7+AQnvXL/nokfnjoQ+r8ahg4RsZpV2libRB4ON5XSczG/J98kfpRSrE643HPGPBGvF76HOp3VbQP1ArbZFoEYL37mH575d/kk1bSiJyWBNruPn2AsjNCBEG/MJKrcKtGoEST4X8j0QQa4HLB9KrkslSex3tBNyl+lrJIcrHivgteesX2xvJSL4l3nw5x3Poo4Ap0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6nRYhZIiAPAK/0AfGJEDwketiyzCULQtEXYPOvbKvs=;
 b=sY+7Bf9zaq17wWoJdIxJdb/dPUtEkt3fF+6VFLWf7H5yqa4kSMEIekN7a+poEEjR61AtGjw7lpA7NIz0U8xuF998KvKYFtquArZHLUNWsEqt4trkPokc0ip4RW/caeLpaXLAIUhi+6iJqE8xB6KEG+1la4Vz4821BzanlalaTxRdblZEaQinhE/IpmCfwgTpMhri6DaJTi8Ac9pRZGH7SqDcsTvHVrbUS7u0FHDB245jSxTLMZGAuJpZstEQMk33CkgCu/YcE/zP/NttuMpoUajZqzAn/MgZjViG2dTBuVq3shi4jntRSitr0BhZswjvlmHEf82UvQt+z+9295EqHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10901.eurprd04.prod.outlook.com (2603:10a6:800:267::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 03:43:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 03:43:21 +0000
Date: Fri, 30 Jan 2026 11:43:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Vagrant Cascadian <vagrant@debian.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: rk3588 MNT Reform2 fails to boot from SD card
Message-ID: <aXwo28QQQ0IwjIBW@shlinux89>
References: <87ikcjc1oc.fsf@wireframe>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikcjc1oc.fsf@wireframe>
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10901:EE_
X-MS-Office365-Filtering-Correlation-Id: b014fbf3-f642-4a12-c46c-08de5fb1b6cf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b4pKQNgFNfiN/Sh5YddZG2QWwkFOtj+aY3LMgNuiY7jIwY5Oc24TxPbOArSJ?=
 =?us-ascii?Q?yAgYR/bLUu7DIfBRQ4wsfm8bTRGw4h4zX8d5yyYuxdfsZklqP29+x8veosIU?=
 =?us-ascii?Q?T40H9eDDFejgti9w8XlggQ8v9K0g7B/no4awv4X9lpAjOpiwzKgOvzFtzfT7?=
 =?us-ascii?Q?+K44nWFGQFM+HZzDOKnWn77sBhDm+wBe/fD0yuwM7fjzqNoqr8uxWcZVxABg?=
 =?us-ascii?Q?caQPmO8h3VcGG/lzLdvvQvWyDaRcllKboIJA2uWIk402Vo8SboylUetNeL3Q?=
 =?us-ascii?Q?hZf/0LxEBzS+taEsShVPD72gnoFYxd4/dupTEOVVRyhFf5cdkgpDQphR/lYg?=
 =?us-ascii?Q?VfgNFd+yKrclqc2R0gcWIJthFhW4ygU45uuJDxW/oJALe5JwnjUnVZqLRsEF?=
 =?us-ascii?Q?hZoFHtbDtmrj9EwmBJoi8WpXcJTTkrV6AoJlSvh7JyFgaewfAkQWPHJ2/enG?=
 =?us-ascii?Q?P7sTiVSGIt43xnELE2H0Bo5jInf9hJu999J7es4OXIAUjkjcrj3SLodwe2cn?=
 =?us-ascii?Q?Lh4o1cPnRcy9M7v7yS6A+fsx1MVomBi0uwlRhc5Z+rq456hPxcDg7MNzEduH?=
 =?us-ascii?Q?QYZexEySeUim2CqNNjlaoTKotnxgyg923J7aFtUzmiLgwef1Z16CrFfZDoKI?=
 =?us-ascii?Q?FGmTvtlDVlM0dwtQm+Y+rajKKOvvWKou2CoKcu9x2il6w04mXpfbyAKjOVTc?=
 =?us-ascii?Q?R7uCY5tOCvaiygzZuoCo0Wpd6A59gxlG8v1U4vb6Ugtd5G1fgdniNa4i0Qt/?=
 =?us-ascii?Q?GDbnXxVQl/Xs62zbs+aiSufjDnMT8SxsPf/bSGNECIJFvxs4QrHCzZseW7ys?=
 =?us-ascii?Q?nYNJVciz/a7G9jBffBqQDnBMha83EJMba+JJYuc35s5HlAASkpsrpIvzOMhT?=
 =?us-ascii?Q?4l22ujlhyF8+sV4oeay2ymP4o6vczKR4mcHlkHoiYLpdIfGgLhV0kQVGXcDo?=
 =?us-ascii?Q?eWhSUxAgz5idy9o3iFEshnRdJ30v0Ja4aHZ8tJ4KXJb8LHfcBuve2d/nPMx7?=
 =?us-ascii?Q?AmZxVQ3AnpzWPiR0N7i2WPy9OtHNFsBsvDZQcBqnqzT3Ph1+qh9mmLbtcZTX?=
 =?us-ascii?Q?Du0yUN1g8hKEiF9STV26J7haUXVRemXzprBJVu4NGsUKUEI8OfDxOdVaIKwh?=
 =?us-ascii?Q?R0FD0yRZ6HzYKev7pjKUT3ZfSXXYTN7RcEvvK6Z3lGN0UJbQsq8wvnzenh0d?=
 =?us-ascii?Q?FQDnIJXucGqzEbFarydgnPDmK5mu+nbn56HS+tmR5qGiHWkf8zg3l9xOJuL8?=
 =?us-ascii?Q?xgdn34msTGS2BHsga5Q/I9+KYP4pxpAmKuKKIoBZPNA+xlJA/p4mSZupDssM?=
 =?us-ascii?Q?PGqPkX2HzH/4UAKIZPgGLnpd9NSoA+PyJf9jPkoJyLn9yJxIz58DNnPssRdp?=
 =?us-ascii?Q?jG0JEOTjDCzUq8wLima3kwXxzEPtMmmA7NEsxN6SeQUIetwl2b/UsZ6N+jzB?=
 =?us-ascii?Q?T4a3UarMCXEhACOffjN+sJy3dHIAQeFx4N1nOS92LDdLLYBc1zeHS9ZDrPnZ?=
 =?us-ascii?Q?3fHT2lMEnVM4wGBFwNNLgW7sR49B2iKJohsd86GSvbnFQ+xg086MzZwI/tvi?=
 =?us-ascii?Q?glD1N6mn/HJQjQbf/bx5Ee1WDpjLMUsPeSbz/85kXA6wGrvsDFoIFPadO4gE?=
 =?us-ascii?Q?6vEm3V7FoGRwOIhwu7A7Yww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dFEnTSW0rMVTpoFD5HbHZTMW/Gjjc18aOQbgaV6C+FtENHRL4MFov0LLrui7?=
 =?us-ascii?Q?zI19DzXTf6Fq4frJRYaVqEBJyyfqAHuSHIVGmfsjdSmBvbGL/FIqatsOzqT3?=
 =?us-ascii?Q?nkOhfO1+Uzbca2K18Z7SgKPXxwtAOpAS1Vf2dL7WjPV6qKBHTb15KC9i38s1?=
 =?us-ascii?Q?lGfUTUAVKH6Xt0uBKApYlxkfZutlceXTOHv/Te0Mg6KZPgwy0I8oGeF5cPu7?=
 =?us-ascii?Q?WJFbMq1aQ7FmJbAmFnUlTze7CQOAExQoKsS4h90N8a3GHLReAxMfnyz1tHr1?=
 =?us-ascii?Q?oWDCsAfrrRE6LIiojgaGXVpBq4e8bWkzEknDpgK0leX3c0NSjzIbVYtQI3AN?=
 =?us-ascii?Q?FJbK4AyyPoMZEJ5ak4hLaH0QJBdX66TWTKL2mIluZWU1CGOrLpAzmbqw33QU?=
 =?us-ascii?Q?LU3uojwh/SLEb2uBrcyJSvFoukVDJbua4uhR1KGvdCowwGyJ8YMfiFE4yiK7?=
 =?us-ascii?Q?sOAbE8NC47yROeg0BWhqr0f4JfrJuyFsLnFcpTN6VV7XLdEIZp3SXLlnsVkT?=
 =?us-ascii?Q?0q0s39TZv4dmg7uu61gkHBliBAlcFpoGAcLvb1oCMSY0O3nrp5a3wSAqssli?=
 =?us-ascii?Q?bw9yNFxHSRjpqtWUh7W/79V13tJx88AeFrI2RQfTECpBNrnZWYEyq9lNe1f0?=
 =?us-ascii?Q?xfJoM7S5UGmwNNp3f7loQvoPv2wf3FwymHg3ymol/p3uKASg/Nma1kwbD2kl?=
 =?us-ascii?Q?PmCLUk77BlzbuD9IUBDOdosmuTOWimarnbHmEj0TtIRrJo7LCHO42pLkrpSf?=
 =?us-ascii?Q?SEjVSaIKFG0Z9qge2kfMeYKhYDFvoH0tiYYo5nii8vGO5rLYTtzEGYLhheEM?=
 =?us-ascii?Q?aPGPjZTvy/4fzkSwoucuq8V4W2JEoDH3nyoCCHJZt3cPkwppmzD5wgI6nzLJ?=
 =?us-ascii?Q?iNJXQbTjCykPzwEQbLuqH0gfzU3Q6cSjim3oFmL5V6iAvzmffoVkgGWNdbzV?=
 =?us-ascii?Q?5MBg7axT9fXDTAU78BpD1Zcj9lGVOQDEg+0iKCsynOrwsLJY0V9atNknABbv?=
 =?us-ascii?Q?FsqcRcClQtjCme5ZCmKERJcIiE+TmZ/nlY5NtgrAla2kRScBbBzMQkGyn6jP?=
 =?us-ascii?Q?LMSdJi7+inp9jfWa0xnPEcHjLb6g5LhlgJY/Nc83ml49P7idrzQ4u/rFgfy3?=
 =?us-ascii?Q?n4B9XAGSBrgZv/15jSDK3zWsqowIABOA1Slj8FrM1Rt70Ug5QlX1xhNHY6Hb?=
 =?us-ascii?Q?6oVyBaTtsVJ27eV6tfJPmSZO7aM0VWeb5gGedTeTxBsdZj9JqNXIRrYQlugb?=
 =?us-ascii?Q?F65qmZJ0jJFQxX6n0wXp65FPl/7lbIByLwxqGG5mOgXbU8Ay63CftSu4cWVx?=
 =?us-ascii?Q?IpIFZ/nduJQj3fFzJ0Ky7ZXor8cP15r1xJpOu/YscW4yUqevFsDjAa0wqllJ?=
 =?us-ascii?Q?E5rIOairGrkk5S8E3znidNrSVi5vbk6NandImmDh4LyxMNK7Ve2s0JSSGsWh?=
 =?us-ascii?Q?TEPIM+D4mnfZ0M3Z2d8OYenlYxUWdmm8/cQWZlwazqjq7zUUzCCLlmugXT4D?=
 =?us-ascii?Q?jYbViOii0nnz+TiY49YNtAVVHtBkdqmvve8tcSmY/i8P1N5M71cHcAgvSoHo?=
 =?us-ascii?Q?A6XuIkK4sdL7gTPAzHeMFLUtBhsYCBVSAnvE8c2n0WHtMwiIYtmipvCCFIwH?=
 =?us-ascii?Q?tI7Gdp47ME+NkfhHTz/I6/tGQjy4LVD9NwhDjDosA5Nv57DiKqduDHBRT1+j?=
 =?us-ascii?Q?FuSmQNzytBl3/K7QbtHwW7thAZffVSOM1Ia4SrhEjOD2iTwltooXzPkWNx/0?=
 =?us-ascii?Q?T8gOCqpFgA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b014fbf3-f642-4a12-c46c-08de5fb1b6cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 03:43:21.9094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P+p1i5HVVxQQ8bmmXtlzICAKV4KveHfGXFtiV2T/XVSsCok+bdZX9jSvegf0saxKgr1h7vEVuBzhgzqM+sGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10901
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

On Thu, Jan 29, 2026 at 05:46:43PM -0800, Vagrant Cascadian wrote:
>Thanks for adding support for rk3588 MNT Reform2!
>
>I tried using u-boot 2026.01 with the rk3588 MNT Reform2, but it only
>gets as far as SPL, and then fails:
>
>  U-Boot SPL 2026.01 (Jan 01 1970 - 00:00:01 +0000)
>  Trying to boot from MMC1
>  mmc_load_image_raw_sector: mmc block read error
>  Error: -38
>  SPL: Unsupported Boot Device!
>  SPL: failed to boot from all boot devices
>  ### ERROR ### Please RESET the board ###
>
>I *think* MMC1 is eMMC, which I currently have blanked, as recovering
>from a failed install on eMMC is trickier.
>
>The vendor u-boot works fine on either eMMC or SD.
>
>Any suggestions to get it to support booting off SD card?

Please check whether you have this patch in your tree:

commit c4f5b1d4b037beeb538cf6dee0a16cd196539273
Revert "mmc: mmc-uclass: Use max-frequency from device tree with default handling"

This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.

Regards
Peng

>
>live well,
>  vagrant


