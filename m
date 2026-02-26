Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576EAFD460A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 03:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E426883E63;
	Thu, 26 Feb 2026 04:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GTtxOqPD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE65E83AA9; Thu, 26 Feb 2026 04:10:34 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE7DF83D1A
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 04:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+NwObL57OC0Z5w63CY/oSUFl5Ezj8UXXg8bcr2kJHRs1l1gmlNSfxjLYll+rxNgEnYPri6MNyPFUjBMv4hRU7scQUJJWOVHTc/X4LiBg2H+SD14/BHiOm1df7eVDivxXUzdrqjLHvOBSx3x515hJXmVrt6puvN0tgSJpNnBeaC8syXxdLnCElMt1a6jrCr8SxSdfglKps1mgBNYXH0dgCbPVho53tJ7hKZsLeplh1aej5Z4e/0Vw5lKt2ar7y69j5Qu3XtTQhZlbQS+6X7itj4t5ItqqLd30sEawftcgvkBKd2ZuLIghk0I678KHPmbwK1R/ny5Isqq9wQgxXKmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5+lytKuL82tqYIAjD7IUbgObMUh54hhA+qPMOJ7fgQ=;
 b=mz5jOIzD3TJbiTDIqLo8Qo9kM5TOEFsXv8fVe/lONtE+wI7dkS3VJVunnG/Ono13PdZFyrypcxCGmrb+5oSYo9H3NXTd+u3wQ9onIHqhcnTRAVV2ScDw68M7dT0mPWbCNoOeOlly8q6PBga0Id2J1fjcV6+I2uTCnpaA9Jl9uky+TenPfnv/q1nMcRAvU2IE7DwvqcbbD4qKDfXhPIHVqGbRheDMNwNTOmMCXYHNeVO2k3AhUQEsWNuGZbIOjB4mTKJANWP75gtpP1BwIKY0x5PXQVb5fTryIKgX4jSRcdYfdG//fIo+cuB+l9FUtOsEqWno8ozpeLi0mlm24yqSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5+lytKuL82tqYIAjD7IUbgObMUh54hhA+qPMOJ7fgQ=;
 b=GTtxOqPDzJ3egaJo5kY9cN/XYUUzLH94OoJuCEpFlsGOv4IaL5oRUIWCSrBNFfpWJfC3HU79voLEhhjYAiwxvtoYVEGzrjoeGyHwEMkycnE9OM1zAZJinKU03a8aeC4yap9Vev3p9r7hsDwsPQTf9/3UtO5AouQBa1hnaeBLLikwqfyS4FJTlQI6xYfTGwCtnw1+DOoHUVjGP9wJaDi3KKNPVlvnpF4tWA3DRBGyIgiHoFF8xHUvHZ5lTbtFJqmmr3cpAxTos7UmQLr4TLflQFoDvX48/+6ejYBPsmu1S/UNdluK6rCHAy+s3XB4ZBEQbCmq20peM7AUw4y6p5P8yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11013.eurprd04.prod.outlook.com (2603:10a6:150:20a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 03:10:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:10:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: Re: [PATCH 0/4] power: pmic: MediaTek PMIC wrapper and regulators
Date: Thu, 26 Feb 2026 12:25:26 +0800
Message-ID: <177207977390.1460793.5028391397229049342.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
References: <20260220-mtk-pmic-pwrap-support-v1-0-a345ea3b4294@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11013:EE_
X-MS-Office365-Filtering-Correlation-Id: 6019096a-28f6-42b6-ae60-08de74e495fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|52116014|1800799024|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 6FXRb7ZUlxXBkbg4/M5qZydpVGVHwhAXvO6mN3jwFEYxakmw/Y50OGSo3R2//maxUHyf6ZDFiuTSL6VWE5OZwMf2HYpLBJxQ4fmySz7PRlxDhz+j9Uca7K2zzF01J2qrvFtCOKY+jzH/v4EL98tvwBlZdjyfLsrBXSr7UDI43pvPQIp+FvDjW0UNVeMUSWcRC/wTYLkNU7BofSW2CaTlDqEopPAEffprHSjdz/jnAsT7EcntpATRq0zCQcIJa7d/auv6Ja7dIVazr52yTV53gN31UA8+EvEZKBQ1etgC8jPZuvvib9s5UA+vX2nhDx/AQWYUZg811a5sOa0e6CzUSf8mBgC34FrQaPKQBtJQ1jfCj8RMeaiSXJNHkXuLEUMAQ7UqHwNsKaLLF8hkANrQAcH1YelTYZrg/xO0Eo5/fipUVIInJQKyyQmoP+N/44tqgpUUGeawvIzM00G1pItoR/vBQye+GzfoYSsEhlQriyAFZ+jnRqK97Ihx1E6Bc2GcCbNZNnkpq9iO9iZP9f5ATIT7D4crJcW8ZnYoPJJSwx/N06WKkjYpWEpKOXhSHFtxrDuZ1URexp+sTrFup4ofnNfrhBXMLZrKEzc+mNTt5rw1lKPVtSx9WqdGjiqzAi7fnIdVAKZcbowacmZQISZthBAFklK0GFACrNUTgRsgZUclB6VAxpXJnGVkoeC58/e8lblRs18u4x1TlNA5zDGfJ5Lp4iCKNHgaDnzL+gMfuFf4iKQgnIejBQxdZ5VM6eGobYParZEGPi6I5NEqccEimjGRrawdYWR3LvlTrObaiRZXZnUjpRUYXvdtMaCWgmen
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE5nUCtWUVc3Sk1hOFoyckZDa1V3dlRhRkRFcHZuaVpRK1RiSE0xUlNyVGtI?=
 =?utf-8?B?V2Q3TGlSVTJaUXEweGc2QUNFTmZsSThybDRUV3RZYmVKWTcveFJiajg5c2w4?=
 =?utf-8?B?dHZqTXl4dDA5cUtCbFY2Y283VHFnL2N5YVdscjRDQ1NzR0s5QlZPbVRsU0Vs?=
 =?utf-8?B?anRmaGx0V2dFQlNGdDVrcnZOREV3WStFeXpEMlRKQXF0akZBNWZBSmw3ODZ1?=
 =?utf-8?B?NS9IYXJMQ1hhc1UxSG9wa1ZleTFETEZKSmE0aGhOc2poU2Z2K21NZ0RBUnBW?=
 =?utf-8?B?OWZOMHYvMHU2ZnF2SXpleHJyYjU5VG91RDBibGhQTTQwck1CdEVCc1FzVWJk?=
 =?utf-8?B?Y1laYmE2WWdMU0xqZEI5dTZNZGhGZkVnWmFZNkhpZ09FZUtTYW0zY2JWUXZH?=
 =?utf-8?B?WU8wdU04aGdTOTdraVVITkNOSnJyTHM0Q0NoZDNZSXFHR0pxcnQrYUlRS0w4?=
 =?utf-8?B?bTY4RmFCOFZZWUxQOFByWTZyZ2I4VjU1bFZrWDYzTExpYm9xQXlGTS9pMEhB?=
 =?utf-8?B?eERXandOd1lLQjN0ZDYxR0tmdytTY3g3WnNtWUlVNU1MNm9BdmlGUUwzNVk1?=
 =?utf-8?B?dFJ0TnlLQWlGZHJzWjF0MXppaFZRUEVSc1RJK2R3TmtYdzNCb2d2Q1pnVURZ?=
 =?utf-8?B?dTN4Rmw3T2NqeUtYNlczNnNCUysySkZGdGRqSjFOc2R6S3BFWTI2TE1KWmxS?=
 =?utf-8?B?VGtFZFBYZU9xVzl5QVpEODZMeUI3QW1zRjg2QWFPUWtvRVQ2Sm4xVjdTd3lO?=
 =?utf-8?B?WGZyNXFNYis1VGZBbzE3Uk9uSGllcUkxVVFOTllTVHlyYXhpaW5wNExRSEdJ?=
 =?utf-8?B?WG9rUm5zVElBaXE1WGpHNzN0bjBiYm1hMDlPbzhMS1hMUDQvSlo2WDNuTG5r?=
 =?utf-8?B?ZnBESmRRZWtDZUlNY3VWbHkrSGxRZHNYRHU5VkMrTEZPYS9FQjB5RXM0aTln?=
 =?utf-8?B?bWx3Y3VoTTUwNW9Pc1E0Z3hXUUhjaVRRKzZnREZqWVhsaU5CZm16TzJsWWJu?=
 =?utf-8?B?M1VJZ0NnWFlldENza0lOb1VUT3B6STdqRGJHb0FCWDdvR2hqWmtXYmpvQ0Jl?=
 =?utf-8?B?djh3QnRDTFU1aTZTancxWGMyUEJpWkliSlNYV3hVOW9BRjJOQXJqUzk5U1JZ?=
 =?utf-8?B?dHR4NnMzb2M4ZDlzZHpzTks4bElhOEV3Z3B4TFBsQ1gwdTlQci9KN0hqRG9i?=
 =?utf-8?B?c3VCQ3VyUkdpSnJqNFp2NDdyc2NJcEZiUkN3cUcrNytjNmVLMnpnUHVYc3pB?=
 =?utf-8?B?YXk1SjdwWDhXOXBzSlJ0N0ZtdVA3ZVRKdytkaGl1Ylc2ZE9WOEIyckRJbjVL?=
 =?utf-8?B?ZFpLUXdCYit0R2UzWkhoQzVIUlg4NUdMc0FSang1V2t3STYwTHRmWlFKc0xC?=
 =?utf-8?B?SzFhWm11WGN5RWFsNzM0cTU5bWk1dWthMDc0Z1BVQXU4cEYzWGwxVEVXa25M?=
 =?utf-8?B?bHgycGVrbzdoL0kvVUJPNDdIR3BUaGZJb1dFcCtUb1NZcXJJcldZWWlhbzFz?=
 =?utf-8?B?WWRlM3VIY1BwSUx1MlQ0YkZMamF1L1JVNmR5ZDFReVVzcm1QbVdWZjhYYlpT?=
 =?utf-8?B?dk9DWGRNZmxLbUlnVE96bmo0Y0Y1YjJCbGxHUGpUTEZCSzM3cnZYdUhwbG1w?=
 =?utf-8?B?Vml3ZTd5WU9FeUdSVTJUYmxXWmlKMjdxNGIwdjNDYmZxaTAyTG0wNjF3cFpw?=
 =?utf-8?B?OGZPSzRtNTBaQyszMnN2N3MxZUlkU0FObEV3TnFjK1pxazZ2ZjVMRFhuQVlY?=
 =?utf-8?B?NnNkbW5TditPNVRPUkFLc0Q4bGZucXYrd1VwWjJDOE9oZHFqajRaMi9IUjBS?=
 =?utf-8?B?MmNGZG1sTTEwK1hHcEhIMWo1NjFXeUp3MkJCTG9JT09vMVFBeXJBZWNOVTBR?=
 =?utf-8?B?R1Y4TUxZeE42aHRWLzJPZ1laTmh3cExMZkltaFNYNUVPc0ljcko2UHpLMy9I?=
 =?utf-8?B?Vnk2NHBmNmNqR3k5M1dhWjVZQS9oUkdmcmVSS3J6N2xsTUFDN1c1bEU0R3Bh?=
 =?utf-8?B?QU44MU9YSzdVM2VZUmtZNVltdkpXRnBoZnFqT0wvVnhmdy9UQTlZQnhNMWVy?=
 =?utf-8?B?YjQ4eDVyWkc3bWFlRGtYNHh4Yko0dnVFclFFZjhJNU0yUEFTYWt5M3ZWYUU0?=
 =?utf-8?B?dEVlTWd3R1ZldjM0VXBRalUyS1R4V3lOY3RUalFFZEYzcW1VMU1VdVZsbEl3?=
 =?utf-8?B?UExGZTVUU3BxeVdrU2NDZ2JJSGJ4NGxLWGFBd0hta3hjNkNDdGFONWk0Y3FL?=
 =?utf-8?B?YTNDK0pRQUFZK2FrdlgwUXIwWllyY1BzNHpiWHFmdVBINGRFT3J0ZUlsYWRL?=
 =?utf-8?B?T3BDLysvd0Jvb0k2bDRSQzJGT0JRbE5GcXlOYUozZWdhR3pKZktQZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6019096a-28f6-42b6-ae60-08de74e495fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 03:10:25.5568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+1xPxCV2DqSY+fJ5E0k6I8j3SbV27AdPxVVIUaogTFzmolw8Cd6aGnwazVPGd3uTi2KKjze0zvZj72OO1vjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11013
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


On Fri, 20 Feb 2026 13:33:02 -0600, David Lechner wrote:
> This series is adding support for some regulators that U-Boot needs to
> turn on for a few peripherals. The regulators are part of a PMIC and
> the PMIC connects to a special PMIC wrapper IP block on the SoCs.
> 
> The regulator drivers are added first in the series to avoid compile
> error in the PMIC driver when it is added.
> 
> [...]

Applied to mmc-next-2026-02-26, thanks!

[1/4] power: regulator: add MediaTek MT6357 driver
      commit: 4267b414dca17ba0ec842072fd0f2fb21e35319f
[2/4] power: regulator: mt6359: add driver for MT6359P
      commit: 5419cf43cf085ff7541f299cf4db764d1adec021
[3/4] power: pmic: mtk-pwrap: add MediaTek PMIC Wrapper driver
      commit: 219c05f3f68ef1989a55e9ddf3876dd3ee2132d5
[4/4] configs: mt8365_evk_defconfig: enable PMIC and regulators
      commit: 93016370cf431b789e13a81cd3a7a94c73b82c2c

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
