Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEE7CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:33:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C288399D;
	Mon,  1 Sep 2025 08:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nUatqmD/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A70478399C; Mon,  1 Sep 2025 08:33:31 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B427483965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:33:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEyWQrKv6h7MHW2Te7bhkWM1xLMJ/rWeJdWQYhGWAVe00LzuuAppNUbMIQirYoD3zRA1nLmNUhjkWg1onue8ijNlZI41uC/6K7RLxFxk97FQaiXXQvxh0CRjkLmnBhd5aczfpEDBW8s4yO6+l1ANrc2nnL/ITcIW9lc2hlMLULx5uYFfWguU9vMI2hcBFkUGC2zxbFkNf76ZLZ5nWcwAYY9cxJ0j1KZebDjHfjGNBFtF80+8HNFC3HUPkfVIW0FQFcxHU/Ftj9r5kmUc3z5Z9rK9oNs1ZVpviyseC3Gp8A3OMbWKXYpv4P4ZFqRmHYj917+81TH7bQs1bdaBzpOPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F4VPZjb3MVsGk96nTDm2J2wnqEAKdwnF7joEHmSVEk=;
 b=pHJW0aKObFLJqKirvtKRPMl7LTvfLjOYNAImmMdfxY9vyLpCq9vC+dXquLFL7+8T+HSJKxGNhujg+tETgVDBu7nm3XT+SKZE42Er6J+6kuCw8UBuKhEbJI3H2Ew6t6jipVShkKOFYAGfePAFDWV0FlzpOIIlTIhXeLA7PWzIKYyiNFE0/81r2kCE62v+WJJnWQGDYZJHdi/G+3apbzbu9GtybQYgwJBJzrbGe7M7Noy+kESNDE4zejQ7ct/Wy4fxCveYHzWk6i2eyVus4obgyIpLErLaLDCMd0TIi/T9Cw7j9avhocv27ISBMaZpgTBeAoz4HeLgUT+vs9xoB477Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F4VPZjb3MVsGk96nTDm2J2wnqEAKdwnF7joEHmSVEk=;
 b=nUatqmD/c9+QYzuDpp+X8zlDT3CDOeeRW4Vkz8f4vCt6T3me8JzR22cLBy8u2DVhQwczK6yXzLowyvR1L2d+0KWjpPUaOb9vPjWsSlZtWaVZMqJ29CXmQWPwQc30bKF8PqQuJpweuLOMl0CIDvhbxqV3dxQJ8Q3GBeFkqDcSe55kIyg5Gzgmi1Qcn6xm3TngSdTztZFBZg12HS2S1YhpqPs8qV7We1qOdTFZbIDTsdJ6MKP6cNQsEBe2HZ9pc79OtCZCCwfHNUzz2NiSiHBckWZpqfgOtI9VxnWU3MWQaIFFrUDUmLcsgcLBavkZv0TOm5hqfHpRXEbl7akTaGxa6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:33:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:33:26 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, peng.fan@oss.nxp.com,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Primoz Fiser <primoz.fiser@norik.com>
Cc: Peng Fan <peng.fan@nxp.com>, paul.geurts@prodrive-technologies.com,
 upstream@lists.phytec.de
Subject: Re: [PATCH v3 1/2] power: pmic: pca9450: Add support for system reset
Date: Mon,  1 Sep 2025 15:44:09 +0800
Message-Id: <175671244826.14594.10281371134605786472.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250828112405.3994748-1-primoz.fiser@norik.com>
References: <20250828112405.3994748-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: 74f7d529-fc83-4612-ef3a-08dde9216e39
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFM0KzJKOExpTnh1NGR6S0dLKzFZQ0oyL0JoMGE4Z2lCU3M0MFhVTjVKYnMx?=
 =?utf-8?B?cnRNait2cVBzaGhtZm80ZHZZcW9rMGl5Zm1UZEFjeWtvOFF1UUVaanpWb0FX?=
 =?utf-8?B?WDg2UzFLUHdzTEtZMUNvTDJUTnhUVmp4VGZsOFdEYnJUR28xeS9vWldXMXFL?=
 =?utf-8?B?eGljSkVzUmVKTTR5VFl5L0tXckZ2bFpVWVdES3pCV3k2UDJiclF4dGl1RWtK?=
 =?utf-8?B?a2x4ejhPNzR4YStHaEdzNGN5ZWFHaS84TG5iQlB2VkxGR0Q0b0JraVJEdmxl?=
 =?utf-8?B?aXlQK1dUak5vR2o5VHROaTFqNFFKTXhISVJrVU03TGtDOG9Md1phNHFjSDY5?=
 =?utf-8?B?Ry9adVJ0NDk2N3I1WE1rMmljVmxPMHRDa2pHTU9rdnc2cXdpanlMaGxmTzlP?=
 =?utf-8?B?b25tb05Qd3h5ZFhWNVBTRlVLQzZCTjVsblBtT1NGbHUxTFlCeHlXNzFncnd3?=
 =?utf-8?B?UVptdWlrK1VUUFJCMytGeS9ETThEaDc0QXJjY1hXZUlMUlAwS2hIWElOUUFq?=
 =?utf-8?B?VHJ1Yi9DK2FaRnhpbXk5elB2cW9YeVRFN2hHUFhvR2liR2lrMlovQ1R0YUY5?=
 =?utf-8?B?NTF1cjBLblk5T01LNk1qaVNOTitMSzRVdGxNOUVaS1p3K2d2MnJyOXBqTDN0?=
 =?utf-8?B?Ri9RTU5nWFU4aTFDR1FiWVpZR2F6Q1RjLzQzMXAzSVh4R1k1aFVncFdPa1Jx?=
 =?utf-8?B?SXhqdmJtZnpkbkZpbWpEQ1h6aUxDVUdiVmZNRUxNaG55a3A0eFJnWDhOMGxl?=
 =?utf-8?B?ZThrUGxteG00RDdEOEFtMmtCU0Fkc2FYVTZOSlBBaVBtaEZrd1MvYld5OWlx?=
 =?utf-8?B?cWxma1hERWx5Yko1anNsR1dGNDVuT1lrN0lwMWhWL09hck9NUm9leTVvQjRN?=
 =?utf-8?B?ZXF1QlZrUnVYU0ZGaE5DY3BURS9NNHRrZW1sRTdNUjNEUmJ3MWowR29MblQ0?=
 =?utf-8?B?L3pyTHAzOS91OHJpcHMzUk01aG4vU2I4LzVHdW9CbHEvRnB6RFgxRUdTSUZL?=
 =?utf-8?B?RzY4eWVrSWhXY2c3d3BXUnVTYlQwbmZNdTJ2T3laRW9WOXFQYXJBeHpXZUhP?=
 =?utf-8?B?c205QXNXN0pnM0FyWU9uMHZFZ255NzJwcWlXNFNBVVNjSTl6cDZpSXlieUEz?=
 =?utf-8?B?UGtZZWN0UzJJM29ldmNvYllXalFDbEZPU0NJMmdRNElwMTlzMC9kdWlKaXdO?=
 =?utf-8?B?WXZaTFNLeEJWYVBFUlB1eUtSUkxrZTc2bWdDaloxQ0VYSGdpK3JYVUM3SEtR?=
 =?utf-8?B?cXQ5SXBSZ2VwVWRYZEsxeGt5RFl5cXVtL0VBdUY4MXhUT1ZlazN6VkYvUmFK?=
 =?utf-8?B?SnFFRE5iaHV2VUtidDlBWkFBbzFua1lWNU1VK0dDVmE3TW9sQXV1b1N0d3kz?=
 =?utf-8?B?QkduMndJYnFBTkFrWWMxSHE4NG93K3RQdHRmaS9FbzM0dzZLTTdpOUNtTWxW?=
 =?utf-8?B?enJtZ2o1VGRFN29FRUpUV3JIVE1Ib0dJZFd0YkUrU0VlSEpxcjVnNldXYmdl?=
 =?utf-8?B?Slh5aGFvS1QvU1JJRWpkSHBvdWxJV3dHMUdyTFpNdnI5QlNUbjc5dDIvZm5x?=
 =?utf-8?B?TmVDeXdiVkcwdVZTeXVYemthTk5KOWFHVDNCcndQL1B4NkI4Nk4zbUIxWGZM?=
 =?utf-8?B?aVd4d0ZnbEFZTllFYzBGNU40dTV5ZnVBRDJEREhTdmhQbFlEdGxSOGREd09x?=
 =?utf-8?B?c0FHYXRHc1BhcVFpbXlBMGtkWFZmNnR4UmJneWtwdXRYNWViUGpyZjZBNHF5?=
 =?utf-8?B?QVRKSnVBQzVCc2RVQUVBYkt1bTdRaVA0Ny81MXhiWGxtaFp6QUY3emhaM0Qy?=
 =?utf-8?B?WjZkdGpFaGZueGtQMk1vVjRSU2M4M1VkWEdTWmtaMWNnTjY3a3R3Z01YWEdl?=
 =?utf-8?B?RnlHSlZUclRFOEVjRzZpTlc5dDNhRU5qeXcyN1A0cXg2aGxhUWJtU2pLSkt2?=
 =?utf-8?B?cjhnYi8yWUFUWVUweGw3OXc5OXYzQ09UTDJuMmJlQy9RVE02Zm9jQXhZTkdD?=
 =?utf-8?B?WHZBQUtaQlRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRTNnVjQTZTS25DY0tkcHpVcExwTWZhVDI3WUxNL0ZBZVFtSVJHOXQ2R3ho?=
 =?utf-8?B?dHB4bURaWEo5WVFxVkJpaDhGWVd2Z2RUWkJrSkV4bjFuSkRnZ1l0SE5QRGtC?=
 =?utf-8?B?QjU1NWxiN2lzS1BXY0xBR2tRWTM2T3Q2bVFveW1ZbEdPUEd0WkI4dXBzS3pW?=
 =?utf-8?B?cDREWnB2WlA2RTVCeEpmWkxIQjJBOVBUQnNYeUxxWVNnRjVDVW16dlA5eklX?=
 =?utf-8?B?ajM5b0JVSG5kTHUvWEc0Q3VrMFhHQVRSVHRqK2txUXduYWVWdTNjOVc0eVRR?=
 =?utf-8?B?MkVZNTdxdmVNR2NoQTVES2ZZRGYzY3JrMllPQkFVakx5VWFLK0JzYlZTVDhi?=
 =?utf-8?B?c0crK3RrVWgvamV6ZG52MHpWQVdrOERQdWV2Q0RIZzY5NlBJdnhRUGlWYkNE?=
 =?utf-8?B?ZVRYbzBzam1tN2R6U0pwTzJFY1FJa0JFZk5BcytKNHdHbFlYRVdidlJkRk1J?=
 =?utf-8?B?TStTZG1PQnAyVGZzc0t1MFdKUkcvRC9EOUhtV2p5cFRKMmgybk96NTBsTSt1?=
 =?utf-8?B?NXhQVTB4MXpXWHQ3aTJiZ0llRlZ4VVppTTZ2QUIyaWhUT3pWY1ZIZXpzRWxK?=
 =?utf-8?B?NDFUdGNsQTJhQ1NzaEpBQU1WVk9MMjhnY2xoWUZtL0dpSXdRTUpSV0ZtamFO?=
 =?utf-8?B?cStBa3pTSDUrNWxUNmpZanU3RVBwNVpwZUN4dExGc0FNS0lZb21NaTl4RWRa?=
 =?utf-8?B?VzhObTgvWkxmN0ZZNkJremFSby9sZDZETGFVRldsY1F4OFVYT1ZHNCtvRDJv?=
 =?utf-8?B?dkJIUCtXbzVzeWQvam5HbUdya0dkbDZPSU42b3Bza3VpQVRGOWhIR3I4YW5F?=
 =?utf-8?B?bXdQZi9YQ0lhY2M4bFl3NTZwdDRRckJGRXJLcGJ3VEdNNCs4aWZ1Q1hzVlk2?=
 =?utf-8?B?dWVFVDdjWklIQkNDRHNEQXJ4d28rYVJ2ZmpDL0V1UUJxTzdUd0V6V0k1cCtZ?=
 =?utf-8?B?M3YxWDdQVWc2UDhCM05Ja2QycUloTXNkbWswNjhielpSb0pWL3luM3NUZHJR?=
 =?utf-8?B?MWtScTRaY0gvUHNHSzBCYzdBOFFOdFBXbnFUTmtrUUQ1bWNXdFFzblQvR3dX?=
 =?utf-8?B?Rkc4NWZQQU1rSmFwZlF1UFJ2ZmFOaVJBeTlmbUgwd2tsTTFORm5sbllqaDg2?=
 =?utf-8?B?ZUlYcWxxa3pKSkdOcmZUNUw4bkxXb0lkeWIxM0t2TmcybDlOYUJNREJGYTJu?=
 =?utf-8?B?ZnZsMTNjRkkyRW9vVlJqSllPR2c1R3dEb0JCejJBa1lBQTBubE5nY1poR1U3?=
 =?utf-8?B?ZENiRWsvK29hY1dtTzRpNitaQks1d1ZSM2YxK3hSRDRzNVk2QVY5cXlHVWg1?=
 =?utf-8?B?bEVCdkdOeHRucWFNWlhZSDFySkUwWk8veFNLRUlLekxXeXhZakxSeERLVlJt?=
 =?utf-8?B?UU41SndIdGtDeURNVXB0aGxtbFZubFBDZ1p2K0s2VnVoYURQSitJWVVKL2sy?=
 =?utf-8?B?ZXpXSlNqZ21FbFlFNGR1M3RQYUxDQnpwTFRLeHFUNElrelNiK1JKc21Ea3Iw?=
 =?utf-8?B?SUg5LzJYNHVXNTJvbzZXVml2NzdHb0lkYnVrdVhJaFhFZW9vUzIyZXYxc1Bp?=
 =?utf-8?B?QWlwbC9ndWQyVElEMlhKSFBEM2NXRzRFOWhUZE9haDRnYlBYZUU4d3kwMlNZ?=
 =?utf-8?B?eVlGTTNCVWV2MUprT1d4M1Z0eWlPRnU4akpYc3l5M3ZFbVlOajNrSlpIVDZ5?=
 =?utf-8?B?SjJUMzdOM3d4T0N3U085em1Mc3JzalBaSnlFMUxtUDRCQjN4S29rOVptczMz?=
 =?utf-8?B?YVE4Z2xtK0VBNk83Z3IybGpoblRWUTBqWmhzTUVIdHdxcmorcVc2cnREaTFF?=
 =?utf-8?B?TTFtb1pHQnFOa01LOTF4eXRuTmJBMEpnL2Z0SXk2V3BVTUxaR3VQU2h4WktP?=
 =?utf-8?B?N25ncFBJeXFxK1FVNjFVYkxvWFdCRUVBTERsc3J0Ym1SSkEwMVJJRTFtaFpL?=
 =?utf-8?B?Rk0rajcrcVZIckdtTUl6dE5tSjZIeXY5SWtOY01qaXVhb3JNeEJpWndmenBt?=
 =?utf-8?B?YTVaZTRGdnM1ek9KMXgyK2dhejBaZDd3bjRHSU1qbFRBY2RMd0swUEt4eTZx?=
 =?utf-8?B?WjhIdHhsVUw5MTZ0SG5jME1ydEhGRnhNbm0rcHE0N0U5UjNUS0psKzBpbEpx?=
 =?utf-8?Q?j8exwF7YwDdlndYSDgdBm6uon?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f7d529-fc83-4612-ef3a-08dde9216e39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:33:15.3822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzcowzCVvKvBIxW57bnDbwI8w1HjqUzoWZxt50Y4kTGHa65dUp3K2xRsjy+uTlgvwTherkhUckda90vKjmuQXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
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


On Thu, 28 Aug 2025 13:24:04 +0200, Primoz Fiser wrote:
> The family of PCA9450 PMICs have the ability to perform system resets.
> Restarting via PMIC is preferred method of restarting the system as all
> the peripherals are brought to a know state after a power-cycle. The
> PCA9450 features a cold restart procedure which is initiated by an I2C
> command 0x14 to the SW_RST register.
> 
> Support in Linux for restarting via PCA9450 PMIC has been added by
> Linux commit 6157e62b07d9 ("regulator: pca9450: Add restart handler").
> 
> [...]

Applied, thanks!

[1/2] power: pmic: pca9450: Add support for system reset
      commit: 9065b87f35018a4e993e7dfb8a8ec29474785f76
[2/2] power: pmic: pca9450: Add support for reset status
      commit: ad197b31b3f88d53c349995d8bbaeba4b18b8f2b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
