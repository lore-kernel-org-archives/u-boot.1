Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BE8C71157
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 05:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6A382B20;
	Tue, 24 Jun 2025 07:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ocZqUpMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8D582BCD; Tue, 24 Jun 2025 07:49:46 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9695581F66
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 07:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqtZQPVX8cOMV41895BAHQDPyVfSXkVZWfko48fPYobhFLaSJjM9RQ4S0gIOKF/qci+8xNDMdZSMg1xk6avN/eS8PysUAs+tchUftl6RCKZVMae4+7d5v9UPnHZsJw4r/avbVTCKj+zzfkpV6QIXVnpm3hgqn7P0zJQfNCTvmqhxMoerf4QHH4jVVWbi619dEr59jDzY0mk4HXKtiuzPhuswGr83NNE1l2Oh4QqIX6uU3wpg7Z0dzUpz05RrILhTgdPIskMG7zTwDc8Kt9A7RT6034ZD689PAuZAPmCGK6O16k79bjdRILWekEofH+JQpQa1moXrNWG1f67753ZR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G0FuzWwW9QIZ4QiMSUs7oiEHt/2KDJyBPVV9MJ277Y=;
 b=GCcbyBFWpgboqGN6kTUI2cHFeR1Brj0pTCOt5ZdI7ZOAg+AUN+iP8avqXiaylN9w0tekrxQ2eNWH5exagEAo7KXD3WjJKMDUJNjC9+Nl22pmnzD1V/5uk9IzJcw7RPd3AktjY2vZ18GQ/+L2Qyt6aPcqXzhgtA2NLWNqsbDsoP40zIFxWpDBKv2pfocQP9NRxmNeLCniHy+3CUrekVApkcI2iWIKqSq47iIuD03JV2gzEnocab3PuGJPuMxQ7tduVab6ucD5f8iCjntyWIQGMCQGjX9M2YRdGC1xLt11FPFBpgxWeY+1sNhQOqDMcfDDNnnVyS9Shkc/l4WHodoZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G0FuzWwW9QIZ4QiMSUs7oiEHt/2KDJyBPVV9MJ277Y=;
 b=ocZqUpMUXgFJH+MRZgkoJ8c9+ZUnAkgtH6w2C7lAVulbcIIFMrp6/N5cHJH7o6QmalfhrtAShbt4d0YmwqCO+dOuD8FulHwnSeCvP3XFX1FBeXjQ93m1Rn3ceRAeEMXJYXRmEqMrdOusKDV+Dz90I/QMLbBkAIf5Emj0CS8H8hPf2JS6QpNR7a2SaqJklcMWUf/+Nm/hAKqGiziBRivk+CbZ8QgoO5HJ7ycccGwYGSQUSX1DVF07eUtQ620mw0+7ywfR8Fr5XgunHwNutwjmRLpmBukW5GdFKY5vZj+y1XhsWHDttNnb59R5FMP9jLRJFoLbQoU/hom+XvDQcYvbIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB9950.eurprd08.prod.outlook.com (2603:10a6:150:b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 05:49:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 05:49:43 +0000
Message-ID: <b37751d9-5a00-4adc-8f18-70076f3476f8@iopsys.eu>
Date: Tue, 24 Jun 2025 08:49:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] drivers/spi/airoha_snfi_spi: dual/quad wires
 modes, dma
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250611151043.1259441-1-mikhail.kshevetskiy@iopsys.eu>
 <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20250619235448.2414587-1-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 70909c6a-c9c3-4b6e-d47e-08ddb2e2eae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzQ0OUFoVy84OTg2clBLZ2VubXN1dXZ6RlFwUFJIZitNaHNtZFZlc2dVU0hu?=
 =?utf-8?B?Ynd0VEdzNXNXaTBjcmdjZ1RnRkpvU053ZDQ0SGUvV01sWjRGVUpuY3lqL1lm?=
 =?utf-8?B?R0tIOEpxeTJCQmk3SDJ2K2N5YnlHV0lMbFRrR3lvdjFjdU04TDI0QlhzZDFB?=
 =?utf-8?B?dytHUHQyVHh6M0NCa3JiZ1lDZ2dPSUdnQ3phaGhGRUl4aEplaWkwWlcvcUVQ?=
 =?utf-8?B?bHBNemJTUmdPTjZOd2hsZTRNMzArSGsxSFlvVDZFY29mNkxOaTJFS3pVSUxT?=
 =?utf-8?B?L01BMzNpMjJNbEdYQ1BWVk1ERVVqRDRxT3hFNndPNnk5U2xzOFZmT0pCdGEy?=
 =?utf-8?B?Nnk1Z2xuS3BmQlFObFlFcFlMYU1RMlVPVlhIemxHZ3ZXb2JIS3FuL251SEls?=
 =?utf-8?B?YmhWL0ZUKzdONHU0a0tyZkwzZkllRHdNZnFERXpyNyttZGdvN2dBVnJ2Kzln?=
 =?utf-8?B?SzBJV3JoQzFzU2NJRGVqdVF4N3BCaTFlOG5XU2FtQzJZYytqYllOWjd5WmYz?=
 =?utf-8?B?c3FpRDRXcnN3dXEraTNiRk1jK1VqVXlUM3BZalpEWURSNG9lQWhZa2Fsa2M4?=
 =?utf-8?B?bW5MR0VzeWJPc1Z6WG1ha09EQmtwaEc5QkxmL1dVTlRRRVVNd0xOTlhaY1Mw?=
 =?utf-8?B?aThHRmpQcVQreDR4dC82NzdCbGJlUUcycEdlMWxMVzhiU09tMUFGVG5XbGw0?=
 =?utf-8?B?Mlo3cEsvdjZpd0kzM1Y5cjlYR1N1OUNLTEhFM244WTZ5M1RsbmQvT3Z5SWl0?=
 =?utf-8?B?MUtUQnNYZlphZlNVeTFONTdRaTV0U0x3VlRINGR3RVJwUGJXK015MHZRZll5?=
 =?utf-8?B?Q0FDMGJxZzdTYWpXVGFzMDc4S2JCd2VsR3UxNHNpVDNNbC9vMUI1eVk2Y2xI?=
 =?utf-8?B?SmIrMDJyTmVxemsxMEhCVUFibWtLUTNnQytMUVlWR1ZZb3ZHdEhvbnkxakN5?=
 =?utf-8?B?aUdMUnF5dHpBRmxpYm94QktQeVhaOERNZDc0MTVDcEhvNjJpNzIxMG80cFNW?=
 =?utf-8?B?aWlUQVJ5UnpmeldRdTdUN0dpQzAzQ3BxMTQ3RnVSc2l1MlhFcG03bGt5Rmpq?=
 =?utf-8?B?L3RJSlduZE9ZMENabXN1cm80S1RnWEo2amZhMXRrc1J6cjEzZEZNakRkOWZX?=
 =?utf-8?B?SEN1dlJjalkvV3BqVlc2czlJSEtnbjhGQk9FbVdiWERWdUhRdkM3ajdjNC9X?=
 =?utf-8?B?bnYwSnhGVWdZZUlBMk93N1JaQXhaZFJZeWhvditYamI2S2ZVWmQyOVQ3STJj?=
 =?utf-8?B?OWtoWFlCQmtrOTluZTY3WTUxa1NBcXJOcEV0ZENzMnp2RTgwa2pYU0JkZHRp?=
 =?utf-8?B?MFlHajIweWZEallLKy9iTDBTWmJnV3EyZEVWN3VSQVlTZ0ppKzdQaGtoZVhD?=
 =?utf-8?B?dWpYNG9lSmxxTlFJd0FXL3VkeHpJNGh3RE93S29hOUk0YUJsbWlGR05rM2U2?=
 =?utf-8?B?MVZJVUJCQitwalZSWWZMQi9CbWJTMzJzV0VHNFZWS0dmemI2b0hZVUpkMitC?=
 =?utf-8?B?QXpZMnNkNVVidXRyN3NvR2NvYkVnWm1HcDJGbTUweFlwWXM5L2JCeWhENXFJ?=
 =?utf-8?B?bWk4NmJtcTYvKzAyMDBaSG5WZ2cyWVlaL0VpeStEV0NXbUt2WHRtRDZ0SjBJ?=
 =?utf-8?B?L0VJRXU5TERsNFhGeUY0eUx5ckZMMGgySzZsY1ZJeDNUc0RuMWp2WnAzaSta?=
 =?utf-8?B?M0d1M2Z1OUMrYjFsdXV0Ykd0bHo0V2hQdkJ3SEsyMUZvZThnL3laY0g4NVEv?=
 =?utf-8?B?b3ZJbmtiZW81TjRzWmdXQWZVOHRMOVNuVVVLNzQvdEJjZGRQYUtvQUNTSkhj?=
 =?utf-8?B?YmZVMjBkZTdhSnl3WVNnSzNzRTluSFI2djMzZzhKc3BiTzhrMUY3azBadmhV?=
 =?utf-8?B?aUhCeVJKYlZOR0x5bkJHMVpoVVNnK0xYaUlZcW9pRUlKL0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUs0TFUrZkp1TkJ1R0JwcmcwNHNyakZNTUZtckF3c1NaOXJmWGxDMzM4cVI0?=
 =?utf-8?B?bkhKc2M0cktaaDlQbnJLdVNYcFBTWUloczZEazZoaDBBb3hZSmxtd2FKL1Uz?=
 =?utf-8?B?YXNncWxGaFZON2hqbDFnMUNGUmpmLzRxa21QR1dyQTJNNlg5dWxoQUxGUVFO?=
 =?utf-8?B?Slp0WDZwK2pGODJLdVJ3QjdWeEpxbzk4cVRlZ2NmbnRXazkzRVk0bHNMRXBX?=
 =?utf-8?B?OWxZVzhwRm1uaXRaWjV5bkttV3NVbUhQdmRaZFplUVhnRlJZVTlBOFZZUTI2?=
 =?utf-8?B?UFRMaFRUdE05S1FKOWlkV05HdjBiWW9Za2xjL0oxRTBxdG9sL3pmVVcxOGhC?=
 =?utf-8?B?RHM0a1BaTTdiUW1aRVNlTmpWZmdVaHVacjFIdEZ4V2lGdFB4WGZmYk84eVkz?=
 =?utf-8?B?aWczOVAwblVBL1RPelR1YitMbC9NTlZ0UXp4a3ZML3dLNDBlMk51QXpEdDVt?=
 =?utf-8?B?TkdwSnhXa0o4YWV6K1RvYU84OEZab0FlOFRRMDZ3aVFqNGtkcld1VFRpaVJv?=
 =?utf-8?B?WlV2aTkyZmtmaCtDWWxnaGljSzVVWkloYTY2c1lKY01LaDBpOUpsMTZxbjZH?=
 =?utf-8?B?QUN4Q1Zta0pSZnNlRjhlUXZQK0NHbmtXWVB4QVJ1NGd6OWhMc2wwV1FCcUJK?=
 =?utf-8?B?aXduYTZCY0IzMFBuK1V3R2kvb3FrTmI2TFVIVys0d0wrMm5iQ25ZNnhkSTZD?=
 =?utf-8?B?MXhTaGFUNzJieTVDTXFSTzVMWjZ4L2ZMakdLcW03N0FyUDN0MWVTYXlOZCsz?=
 =?utf-8?B?WTJsNGRTQmh3dnhKK1hVL05DdGFFTTRSS08xakxOcGZRQjJBa1J4MUFLbU5N?=
 =?utf-8?B?aXQ1SHNsOHRNNVRqYmN0TE1vVHVoMXFabFlQTnNXUFVUZmFrbFdoUlJob2Zm?=
 =?utf-8?B?b3BxUTdMZDk3eUh4N3BRMlVhVG1jVGxHeEVEQ3VITjRUeWdHaFpvWDRubjND?=
 =?utf-8?B?Q2taRFFER0VJdmtCS25LYTk3cUFmdXBXb1dUdjFvdVJ1ckpUc2FSekM0aVdl?=
 =?utf-8?B?VGM3Y0NEY2N5VUMvTXhQWEpkK3FQY1JlbHdoOHVxSEg0V0FzaVowVUFkM3Y1?=
 =?utf-8?B?a0RRaDlUSGJzcjU0alkxSFhIaDc0UFZlem0xT1lGcEh5cEtkQWVkWUxXWG9G?=
 =?utf-8?B?aVpOQnBLeGFldTVBSjB6dkFpekRZTnY0NzV6U3czZnljSk1SOEZQSWV3NHZn?=
 =?utf-8?B?aC9GZlJlcHptYSt2OGFFbHhxZ04zQnBWNC9OWTlKUmpEQjZDendVNlJuV1hM?=
 =?utf-8?B?dUI0ZHg3T0NrZWNpUlRUNzd4cUxqMUlVbTE0TTJmK1NKSW9NQ2g4QUp2L1NB?=
 =?utf-8?B?SUdIR2VmdnVnV095VC80SFJjUEdXMFdoR3R3MWM0elBISVF5RXdWRERvU1lQ?=
 =?utf-8?B?VGEzS0pTcTlvQXN5eUhreU94bE9mMkJ6N282dWxjdHBjRVlZTTBTeHg0SDlh?=
 =?utf-8?B?enYydVZUOHp5K2E3d1JwL3JUT2RQL0VHRVhKNFdVNXQyM1NxcVYxWm9aZmF0?=
 =?utf-8?B?OGR3SjhadDJFalRUVW8yeWZ5a05NYkkyN201aTBNS0RYL0JxUkxoQ0RjK1Ux?=
 =?utf-8?B?eUVtQ1VIN2N4d0M1eERPSGhzMWFQb3lRdTk3M2dqdEdyVTR6am9xdFhnbi94?=
 =?utf-8?B?b29Na3RENWo2MkZJbjUvbDV6SmtFZytjd3FHcUpLaHh4ZWNiZXAvUGVYc2Nx?=
 =?utf-8?B?cTNzWnhQVGJjUXJud0JjZnlyODVuWFVCaEthRWxFL2tCcEwyOW9pRCtJR3hV?=
 =?utf-8?B?L0ZOVFFrRGhjNXh4RjQzZE1uVGtmRWdLK1owc28zVjNmVmx1WDNnNUtyeEU0?=
 =?utf-8?B?bVZRd1ptRWZKeFl2VkVaZkhTdWZBUEp2VmhrYzIzSFlVVTVHN1VSUDFRYUQx?=
 =?utf-8?B?YnN2aDdPTk14VGh2UVlNSjdyMlp3ejNHNzd1OHVtZTJXYXRUZHdMTUljVGpk?=
 =?utf-8?B?ZGVpRUMrY0tLVXlSMDl4bHdET0NsNDlCVWc4STNpdGJLOFAwamZGczRuT3RW?=
 =?utf-8?B?THI3d2s1SEl2OE40VXlrOEZVdVE1RzF5YnNEWGQzVGFJa2pVN1ZyVkY0YTM4?=
 =?utf-8?B?QnZ5WXFCdDhwaGd2d0tUMDZBNlkzQ0x0aU1pQmJWak9nNGtveUw4WStzQXRr?=
 =?utf-8?B?RUpWZkN4TjJuUFo5VkpUVjBFRW1IK2NYUEpERmVBS1R5SkNlK3pnclI5eEdv?=
 =?utf-8?Q?IXmWzYDcC35+8PkFkgbaeeM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 70909c6a-c9c3-4b6e-d47e-08ddb2e2eae7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 05:49:43.1805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sYLbUIYf/mzsx94g/YgLZL5QirPpizsOhKi1C3j1iKg2+/8x9nFTZ7m/SxR2INqjOxYDeKRTEqmAjZRNKmuWpLEGYvKi45Coh18e1mtOfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9950
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

Christian,
Is there any comments?

On 20.06.2025 02:54, Mikhail Kshevetskiy wrote:
> This patch series adds
>  * Support of 2-wire and 4-wire spi modes. It speeds up flash read/write
>    by 2 (or 4) times on the corresponding hardware.
>  * Support of DMA for spi-nand cache reading/writing/updating. It speeds
>    up flash read/write very much.
>
> Only 2-wire mode has been tested so far. It works fine with en7523/an7581
> chips.
>
> UBI attaching
> -------------
> before: 17 sec
> after:  2.5 sec
>
> reading of 0x1000000 bytes
> --------------------------
> before: 17 sec
> after: 2 sec
>
> Changes v2:
>  * dma support was added
>
> Changes v3:
>  * fix clearmask in some calls of regmap_update_bits()
>
> Mikhail Kshevetskiy (3):
>   drivers/spi/airoha_snfi_spi: remove unnecessary operation
>     adjust_op_size
>   drivers/spi/airoha_snfi_spi: add support of dual/quad wires spi modes
>   drivers/spi/airoha_snfi_spi: add dma support
>
>  drivers/spi/airoha_snfi_spi.c | 641 ++++++++++++++++++++++++++++++++--
>  1 file changed, 603 insertions(+), 38 deletions(-)
>
