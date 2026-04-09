Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AE2EA3C4E
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516F98416F;
	Thu,  9 Apr 2026 13:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RMVdM9V4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A1584118; Thu,  9 Apr 2026 13:39:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5098283693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpxrYbanJZLoX3AGS6zIW1EDDOacsak3HTVHa9QvpWVRpoNDScP3GACVfmwg9DjBe4tVJdc1QnPLtz3NIZukeaL9g11EVQFvF1UqBswJyfHn5bnMVw3SQX0GS1NZSuszvHDA5g0EcnK83THSzvhPUPpLDCJ46bO1BDvc/A7/ztWzTgOnnqVEKlxMwAVjU0b/QTCGeNL6fP/N9q1fQt1ALXVpQv/k9YHz9cbb79CuDevYijs7ESCKQ4Ssn9/6jJsUDL74XPueJdX4F5QITLIc/zMsFlh4/mwFpzaux0iBM4pFGeUelATJOJnv/xiRV3rUpuebyMO11TY+W++UCFd4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFMF6Qfti09pRUXH7RkLhw5beLUdh6camuxNWKoxbLk=;
 b=F+jkWfaOjHCQpD8qRKAI7aus8RuimR9RjNy+a8DyoiVgcgC+zGXzbdlGs+lzPcM8/3vnmigYGsOIy3oZhJo/vQvwLPOVtm+upwKcuU4N+PNo2cT9pt6blrGdf6+6issFSEMYyKsoudFo/5RWH30RI38GGE8ymmeasjLMgZ0WVRGH3osJCSwOZUXb4et1GC4xm5X/cZEXWvqIarbpAJLLJ0g/h+I26Gkbyf4Y3xDxTJXIB3kKjdjkeOmq2gWsxatjJc+MEZKVEq4SuFn2ROC+Icd/7Abxen3Nwtpn/EilMa7X/Z6gdIxclrmdslB6IGrPSKMXZE+SPkUKoVYFDnxodw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFMF6Qfti09pRUXH7RkLhw5beLUdh6camuxNWKoxbLk=;
 b=RMVdM9V4ir9vCuWRAuFJa+gvVH1hMD0K7fQiP4SUJHaSanPjfyY1KvcsdyfhVRtqyobOweBin1vauxYdRhc9luBdCE5NICJMXlOEogGqx07ilyOs8+EmtGu3cRxkb2o4i6GLAMTSiUDGuO0+TzZ7hRnEcAIWCygdAz4Ep5xvacOEBD/a6wF6wdSQ1ypzdtuZhRE9YmLnNhhZ1MTCnJNG8H1Ux0quUuQi611BFQeC2aVYEyiNaSvdieQ7M6B2a10jR8uxbe9NnAtbMt5ZofnkM38kVMbXSLP8HZ3NR9eiTZKyD1qD8Cg4vnIAz2jndd8I01lKR+GCy7ZDC8IaiY66YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 11:39:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 9 Apr 2026
 11:39:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] drivers: net: fsl-mc: add the nowait option for apply
 dpl
Date: Thu,  9 Apr 2026 20:55:46 +0800
Message-ID: <177573926838.4193161.3779851899378619525.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
References: <20260401150445.3070308-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 333bb260-dd3a-44d4-ef2e-08de962cb820
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|18002099003|22082099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: gSon7XqoeUET2y5KGguUDAeLpjDSfblXakBUimsiKYdEzfMLGneBcH1YrIdD1YOo0oKJ8M3vrwaMpEhA4dW1Z5an3ygHLDGZJjLMpDUn//8XR791HXuvcYD2VU5kNK6U/WESMiGR699NYLhKOX0mT+H7fjOgGxzWOTndNQI+vbEmWDvDLIW7CLQloyR7u2hzeGmO3ei9S9vlZUJDYXwcjWZNXjksTn5Sa1R5yTyBf8zFIn7fA+xtJjjkaPg/4OCq/AzvqXBgjkSkvuIJOqeCEMSJXTSuMJypKkQj80SwMq4jK9oplEbCAycTqWNY4u4Pvbjg1BZ3uZWPLnhSpt7dH0AbXLb+WDUlzAJU8DExrSAsX+vSvDP582BtD2Tdx8Obw2KxrISK+Qjw1TQCVLGVEDsE+LLtwRDq1UIbhTx6TSuy59xs84MAD39h2h6wQ+ANNAt+BcFL6uwsxQP1siTtAnLDcs26hvGWhNr3uYy13ycO905SJD5n9dPynlCH3FxsDh8Dfbt971UNYBwevRh6C9NEn0O8iw5WBBLZE0a/biiw0R3an0e8VAhKfyz9W2ZpzNjrHdMo4+sg3JeJ3PTmzTigPXZXSseiEGkvnvEycpehGvxisf2J/AKQudUvynCKEAZRfsPNgxgjZV+w2kNk73boUuK3vfFzXJ1jPxB6OjhBOc8ZA5ONRR4pDrLSF5kxoVImJmnTFVBzioPfLcyTujq2v7lIzWDg06zqZmvHWXyLd79yLEGVEcVuedLammc5NdR9aKYdx7HyzzG1M4Xg5LT65iKX+3VoqdNAQnUyHPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtycmZiUG1HaUNPbEV1Nm8vUTZjdlNTOHZUV01Cb09Eb3drWEs1Q1ZHOWVU?=
 =?utf-8?B?UlgvVHZ4SGdOdDY0YUJCMEVFRFBGaVczcW9FYU1wd1F6YXQ4OHlyemhrZG5Q?=
 =?utf-8?B?cnVQSmoyblA4RjljRzUwcDA0T1ZiZFIvQnQ4VVRpTzl1SDJkSlhUYjV5M3Nr?=
 =?utf-8?B?VkxCZU0xTTFCN3hlSmpOZzUvSnZDdjRjUjcvZmsydFltNjhBRkpBZ3pVVFdP?=
 =?utf-8?B?cFpJYzF0dEttWDd2OCtKOVBuak15eHZFUWNRR2p6L3prS2hKaGJxa1FNeGpO?=
 =?utf-8?B?bDdpQWNQeEFXUXZjL1VhNnlXc20ybTJWOHU4N201YlNqa3dBMG92SHJIZjZE?=
 =?utf-8?B?MWI4SlR6L3JkUkdxcmFaZTVPNW9EMzJnR2lmQTVSaXh2ZmNxZUROZVREekRI?=
 =?utf-8?B?LzlzemxaVzVXeDVzQXZkdDhMc3l1K012SHd6d0Q4ZUduMEI0SWhnaittMjVU?=
 =?utf-8?B?d3JMbUxPUmV5THVvQ21KYkdsRWcyTkNOeGZENzdmQlpJcHQyWmFUbEFQRFBy?=
 =?utf-8?B?MkpXTDNadE9lMGdSS2o1QTRhRnBpNms1U1FhMDdwaXllTFN5TG1sNGpsWVFy?=
 =?utf-8?B?OTZxWERjVmlLd250YUFDcjZndHEvYld6RytMR2w4SWNlRjhQWGtxZGxpaVNE?=
 =?utf-8?B?TWpCYnlkeG9qdm0vREUyT1lvczV6UkREQjlsT3RnL2dpY3Bhc05lZ2ZaMDV6?=
 =?utf-8?B?SDlSYkhzaEFlKzBMRFVycVJTT09STGNXbFlIZGRhc0M3b3lBWTdnNGxEbjd3?=
 =?utf-8?B?dXNBTExDN0krRnpEa1NKdGhvMWxYSzZnUTBaN2hoazdRVWplNUcwUDdWMHlk?=
 =?utf-8?B?VTRnbFAxMHlQQ0FFa2R4NzI0c1lrei9WRGJNWFN0aTVla3Q3akQxaWNBQUR1?=
 =?utf-8?B?ZG04U0xldHBvUUp2Ym83T3kxMUNxVXcrWktLbUFxWXV4RmlubXd2dllEMzdP?=
 =?utf-8?B?NUZtR3lnRDJzWHFWVkZ5Y2JrOFk0UkN6REpZM0c4aXdPWmlhcmJPcVlDbEwv?=
 =?utf-8?B?QXk4KzRiYkxaVTJ2UHFZcW12ZC9ZL3ZJdWZTbTh3Vmd0VWZ6NkFWZlpRVlc4?=
 =?utf-8?B?b2tiTWpiY0dMaENRdmppUWNRL2VhblVXdkEzWXRHeUk0RGZ3dGRmajdoM09R?=
 =?utf-8?B?empndHNnR3paK3BxT0RPSFhucGhlSHNKazJQRVN1UTJ4K1g3cHhnT08yNzVP?=
 =?utf-8?B?Rk1JSjhKWGlnb0dtUFJkL1BId1d6WVBXQ2FhMlJiSUgvZUxaQi8rclFBSmpP?=
 =?utf-8?B?bTZ0MCtTb0ducFRJN1JMWEQ5aHRmalVNN3dKMm96OHhWMXlxM2JuaHh4SGRZ?=
 =?utf-8?B?bXJvbDV6L2o2eXUzYmdlL3hpeHo4WTNYQ3Voei9NYWh0VEo1WkJjbk1nczk1?=
 =?utf-8?B?OEplazRQM0M0VlhkbUJyN2QyRnFpU3c3MlZpMC9yeit1NThPWUh4RmVxS3lK?=
 =?utf-8?B?S2N4b3J3dmZhSVA4cnBrbmtQM1YzajZYdTgrSFFKSW4rNTloZDNEZjMwSGtZ?=
 =?utf-8?B?TnF1K003OXdUWGlsa1RlRU9KQmpyWmJ3ZlcwYVA4eDFZK0UwVEttUGYzNVE0?=
 =?utf-8?B?dW9iTlpZbUxqbUxjT2dyWTV2Tkc3V3ZtSE82eUVvZzhoZzMvd0M5K215K2xI?=
 =?utf-8?B?VitzWDBzNFA3WHVhZmVYZ0hKcjdUS2tzOTNSZFIvcmZ2OE5CYUIxVEh6UjRS?=
 =?utf-8?B?YU5hZzh2ZG5Pa2R6WHFqY1Y5cTY0bmptN3o2VDJTZ0MzdnhMY3lMOFB1VjRE?=
 =?utf-8?B?U04xNE1XUDNXUnN6MmZTVkt5akJTd2lscXlIYmlpUTV4cUVwMUZHdnQ1eGhF?=
 =?utf-8?B?ZXoxL0w4TGw4bGVVTnJGaEpiWXc0c242SjkyZGVnV2xEVVZpanZSVTZUUy9V?=
 =?utf-8?B?ZGxCdzZVZVBLQURva0VPZ3gxclphQ0FaLzRveVllR2lOdWh6THRhQ0lGbEJY?=
 =?utf-8?B?OFVNTnNSbmRkMVNEYWRJZUVQaUNsUndIUFBkVHgwQzlnSCtmeEJFUFY1MDkz?=
 =?utf-8?B?Nkc2THNXUVEvdzRoUEJtdHVLelcrMGgvYnVyZmxPMU9UbldGeDNHSjRpc2wz?=
 =?utf-8?B?QTRiSXhkV2ZkUWNoSERGVEI3eGVyb2F3K2pDY0t6QktXMHFYMnVsekF3bGRx?=
 =?utf-8?B?N0paRUlZK1VwN2xKc0hGNWRxaVNndHZJakwrUE5Pb3V6UXJ6N1ZodndtZklU?=
 =?utf-8?B?UFlOaUNzbWcwNEVTYW5Wd016bS9UaEszeE9DY3p2MDNrK2J5MENXUStna3Jn?=
 =?utf-8?B?R0xtblpDOUxDazlkZ01GN1hZK1hRaWdxbUswY0l2WEljTzQvVW1rdThaVXJh?=
 =?utf-8?B?VWpKYktZNnFLUWZNNE9SSWRCN0NlaGJLWVVKV3NRb2Ezc3FiM1VFZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333bb260-dd3a-44d4-ef2e-08de962cb820
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:39:54.7909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWnKE9BPsAJYnhA2wrSpHsMiwCsHbYNVJodC2qyzjawLDphji33TKso/CsXL2iHeapziogIK68Tm/dNaoD6JrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144
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

From: Peng Fan <peng.fan@nxp.com>


On Wed, 01 Apr 2026 18:04:42 +0300, Ioana Ciornei wrote:
> The process through which the MC firmware parses the DPL and initializes
> all the requested DPAA2 objects is a complex one which can take quite a
> bit of time. For the those circumstances in which a fast boot is
> required on DPAA2 based SoCs, add the 'nowait' optional parameter for
> the fsl_mc [lazy]apply dpl command.
> 
> The first patch cleans up the wait_for_mc() function by removing an
> unused parameter while the second patch makes some subtle changes in the
> help text of the fsl_mc command so that it's clear that all the current
> parameters are mandatory.
> 
> [...]

Applied to fsl-qoriq-for-2026.07-rc1, thanks!

[1/3] drivers: net: fsl-mc: remove unused parameter from the wait_for_mc() function
      commit: ffcdbd31355474060285500339acbfa9f16c3f00
[2/3] drivers: net: fsl-mc: cleanup the fsl_mc command help text
      commit: 405d82905c4978b3f32f31d0b77d9a1e220db9a9
[3/3] drivers: net: fsl-mc: add the nowait option when applying the DPL
      commit: 5d1b2cb863dfa779607a3e195049471c70f4374e

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
