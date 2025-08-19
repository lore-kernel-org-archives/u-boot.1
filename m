Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E49ACA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95503802C1;
	Tue, 19 Aug 2025 09:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="NeFIKjqe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8960A8006D; Tue, 19 Aug 2025 09:14:42 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912978006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFukpCKA8GQG3yuS9PqRwTrOe3Ki0ObYNG5/sZJUPpT6yteFqNFvKqG30XHW3h3LzwGivVQf+MOCFCFB1JyVGTot9OiZSvzEMk7z3Rqjmp4MsPZGl294EVNbRJStjLJmaDAAO5SLsmt2Vv0qtVKJQy+HrmuLOViVxpeRjrBmJVsgR5Pah4AnfKkdPIHmZ7em3w3+yYjHE8RfChzEQi0yXH5USIwwOTJztb3wu+XvXoGYX5cJJJJzG02z7yJ3rerCZL2s+53GqN5bBv2o2JuwY2i3tnopU5B0OFCTSwDy6GsBkr6Qm14N3qu9ZI2AHG2NCbFNnR1aBlP2c1t1Zgcl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mrYT2m9s5GbWjs/NXTb688UuXYxLrUidrUE8+uj51M=;
 b=LNacsKNm71I0Sr/4ByRMXvCjz9SS/GNKoizegwheYpqRESYCJv2+NGTL1pBxW7qmvGQ9tVLMPt7E5E6Z9o60wicKSt6DBanqyYt8jZifTZhEtFqCZ4NxIjBZnnAIOAE7kgXt39YqZ9dxXdbGB2Lna0VUsIen69Fdy4mgODrlWS7HTKXxBynlFrnBZJ0GfOO+CBosVKuXsaYKdlmtSLsgu4CT809fuQ7+lPSps5K/DlxwihZs54gRFe+myQIR15w5hY/dHfN71H5y1hHuKKJiQE3eGG2M1gzV39vwyQBfAEnH1/vJlMomyDuMmle5ycs5rD2I31Gu33f51U45l7tcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mrYT2m9s5GbWjs/NXTb688UuXYxLrUidrUE8+uj51M=;
 b=NeFIKjqeo9ZsTQh3xXbCs7wNdzoyaGEl3Z/VkpqtVMMmA0GYGQJWehEBLvY9ZhSLvBSLY3KCPyHeV1KXWbWkx4/tO6AGUr1tYZ56hP9XK9HU5s2/M0lz0Lt8fJlG8TFm8b3FrIuROcmqyC5SsJc/HW1IqD4aPz1v8hyo7mv4wy7PE9UcRQ39b8OPPu81Uet4WFSK3B1m1DLqir4AhG+n7cTnOuF/TQLm08RQBR8yC2x8cYYM/OMsLfh81ft7R0Aon0RuODfW8S7UZDzXOsd63Hqt4k6eGgGUuh0xyMJcAhFMoQdMpAYp000c1eFW5FgI2aPeITOY6WiGAJt74EWD0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:14:37 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:14:37 +0000
Message-ID: <5cbf2c3a-18a9-499a-86c9-d8b518c9f045@kontron.de>
Date: Tue, 19 Aug 2025 09:14:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/21] mtd: spinand: Introduce a way to avoid raw access
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-15-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-15-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3648:EE_
X-MS-Office365-Filtering-Correlation-Id: e823a168-573a-45e9-314a-08dddef00e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmdkQnZwRzhlOFJQUi9EQmlEalc0NkEzd3FEYVJXUncxK1lvZ0xNZjRMcFhU?=
 =?utf-8?B?dkt1Z0xEV0g2bnNLL0lPUlVlQ0pDVG9FMlhsaFQ3dGhnMDc2Y2VpdHpSWHNY?=
 =?utf-8?B?bnF1Rk9Jd1RhLzEya1ZHRGhhdjJicVpjTGhJcG1ET1JDRTM0ekJteGEwSmNv?=
 =?utf-8?B?aW5LcVcyVlcrSDZiQlNkV2VGNytBelNWd0wzY0tBZmlPems5dTBVKzRkdXVK?=
 =?utf-8?B?VzVzcHl0cTJXTTFXcDZOR0hjbmRGZE5wT2dZZkFvcDlNMTJFbi9ZWmdHT0Y2?=
 =?utf-8?B?R0k3YVNoUjBaRFRRYVRGNGE5aENlT3c4UFVBTk9wMk95UjFMYnBJdDZNdDhC?=
 =?utf-8?B?NWc0aFNqLy9Ga1dMWW1kcTF4ajQ4Qm93TWh3KzBlUHlmbE04K3greXJSZ3ZG?=
 =?utf-8?B?elZhRHM2c3VNN3BPMU5ZM2t4N3Ava2xXRWJOS0hiK2VlajJQbzhKeHpaeVF6?=
 =?utf-8?B?YkZxeHUxSURJaGpSVHBsVklnQVduT1VtbS91dzlHdWZVRXhSc21pZTJERHJx?=
 =?utf-8?B?QW9MUFRjaGl3b0tJcHNqOExqOWVWaUVaaTBwV0dBRXEzYUZhb1JMYUNETStt?=
 =?utf-8?B?Z3JMOWIvVU5MREFiWjNZY0hJUEovZUMrc1A0TmYvVE5ZcktsR0JMMjBLdmJi?=
 =?utf-8?B?TTRIc1RZSmVSRmhnTUJucFRXM2tHRnh4OW0zQXNWZzZZQllQYWZ2ZHlxeXlv?=
 =?utf-8?B?RC96NGxvcXppU2dKYTRyQURhWUNKMSswSXF3ZmhqN0MxbmI4alV4VjkveHRr?=
 =?utf-8?B?THI1L1V6bTVyRkNvWmVNa1JGelRBY3czMzRDaHNNSmVhbmtkWHFpd2lWMlAw?=
 =?utf-8?B?bEZRR3NVRWdaZXFtUURkNWRIMEhhVVVVeEgwTGhXUEs0Wms4b3ovU3ZsUTRE?=
 =?utf-8?B?S0N0YlNybU9vUW9TbVA4TlpvbVJJenlTNFhvTUMwckpLa1Q5TGFKcWMydmtX?=
 =?utf-8?B?Z2NUYWg3blFDTGFkOExNMnlhVXdMc24rWXNxOFBpSE9BeHVkcmFkOVZjUG01?=
 =?utf-8?B?YzNXMGNCTnc0ajBYeFhRRlZCSzZxQmpxRktqMGxBbWR0K24rVTdxREQrRDAv?=
 =?utf-8?B?cnFXTVFDR09jRS9oODZObWo2dUhDN1VBVmJqSHJRamNDN1JUSnJHTVh6eDZl?=
 =?utf-8?B?blVPT0FjYzVIc1VYRWRqdEtmeFVWeCszMW5JbzNXaFZXclhNRDJZTjJncEtt?=
 =?utf-8?B?THhVS1pia20wTGdKN0NOYzZWVVd2cytKVW5zem53dXFRbU1OL1RFKzkvUDBQ?=
 =?utf-8?B?TUYwbUxvRnpqbUdicTJVQ09uT0djcHhwWEJBVmhlQ0kvZ2Z0TWU1VEI2TVA0?=
 =?utf-8?B?NWYyVGVYVjRBZEhIYmQ5WFRiaFFUajNHWHlhWEdoVlNMWk41UnFaMW94NW95?=
 =?utf-8?B?MmVRd2hjY3BhNjE4VnBDd1J2MXphQUxMZzNPVFR0SmZPdWpsaHNNS3V3cWM0?=
 =?utf-8?B?ZHBOcXhuSE1SbHNNbG1QMHZyMW52Ulg3UjFsL25yMHcvQnAxMG1aTmE3bVNj?=
 =?utf-8?B?a0N4WDBQSGRnbzJCcGpvZkExajgzOE1wQitVRUs2QVEvVU9LUzEwOTJ1U2k4?=
 =?utf-8?B?UVZrUFdNc0p6dVhwVWIwSDZha2huekN0S3poWENRQnhmb3Z5RFhQaTZCK1VS?=
 =?utf-8?B?NjdmaWtOYXRPeWJZMmZ5Rlg1UHR5U29vRTYwVUtJV2J6WjVSK2xoU1ZpSGRy?=
 =?utf-8?B?MTNlVDJQa255TVhJVktxTERZL1MvaE9Qb2xKbHg4RVdDaW8wQzgyUzZVTkw4?=
 =?utf-8?B?MnpKSGg3d3RocHA4eGVJSzVkdC9nUkk1N2FoNE5GekZsM0VwcXg5aWIwR09T?=
 =?utf-8?B?Rm1McHd3cHdSTVZZckpnTy9IMnRuNXRCcEVhcWFlcW5uMTNBbmE1WUZkMmN3?=
 =?utf-8?B?NXNJT0lGRldKK0t4NmxYRjFod0xQLzQ4WVB5M1FERmMwYlJNM0pzSTZMR0lS?=
 =?utf-8?B?WFBic0t1YmUzU0hQQlFGOGRjbUdxSVppemtPZHljTEg2ZXRJYWNYK0NWYWYw?=
 =?utf-8?B?dVhsbFI5RmJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGkvRHhzWXRLa3NkRytKdmxBaGdtQ2xTaHJjZ2J6NGd1NXNZbDZ2UGtKTGdY?=
 =?utf-8?B?Y29vRG8xSXNoRlk4eFFlODhZTGh2cHVYU1ZCS1czVW9wTTFRbDVXQlJjTkov?=
 =?utf-8?B?UzNHNG9RdEdqYTY5WHg5d01FN3JlOVQ4MC9IZ3VBajZ2QnQzNkxTd0NtcTJh?=
 =?utf-8?B?Sjdhd1JLcHQ4ZE9YSDhGOXNmQTJpbWt2azhaS1d6Vzg3UUxxNWlVaGRDc0VM?=
 =?utf-8?B?Uzh1WXBIZWxpV1VKbWlNdlJ0Y3dlTFVxK0M4K294bWNYVmNDRnNlVjU2Y29h?=
 =?utf-8?B?WXJ6eVNnUGJ0bTBsVWdHUXFySHA1L1dNSWVoWEFHQ3dHY2JBYzhBRHd4UEhK?=
 =?utf-8?B?MmwwblNweHN0WlIxREh0WWhMNDR2SHJGOTZjNDV5QzNNSWF0YUowcjhPT1dl?=
 =?utf-8?B?ODc5ZFBlQktiSVlBczcxR1J3a3dlK09WVEt6NldCaWh1OEwyRGdDVDhwRm9H?=
 =?utf-8?B?bEYwTWt5b1E3bXFGaTFJcE9BUVZsS2dmczVObGRGMFh5dis5ODJWc2hrRU5y?=
 =?utf-8?B?S3gzZm5pb2phSlJqNkpFak1wR2I4MWlnVlFJbXMzcVJRMmNCQ0tZY1IzREl1?=
 =?utf-8?B?UHN4UFJ1TWVmcm5ZdTlMcU45NXpWV1crZWRTUjYxaDVqbXVCUnN2ek1qeTJK?=
 =?utf-8?B?M0IwU3JCOHhkckF2emh1NFZBbkVqZTlRL0FTUTJ0N2FTMTZUVzZSUkVSNytY?=
 =?utf-8?B?dlh0ZzRoY3RtWEdpanJoUmgwV0dYT0lNZ0JHeWNFS09lZm1hQlphVTluN1Vl?=
 =?utf-8?B?WjNES1JqaENFWklBbHQxbFpDYjAxSWRxOG1CN1VKRWM5TGFZVDczaXFBVDds?=
 =?utf-8?B?M1kxMlJOUDhDanc2ZVM2VGhERis3cmhPS0hLS28rK1BLcXloK1BiUmJqbko2?=
 =?utf-8?B?UzhZY0xMWU91Z1BYajJ3OXl5cTIzb0lSdy9ESTFaR2xEZjhoRlc4ZldQNlFQ?=
 =?utf-8?B?bWZWdU4rSVNRVTBEVFowL2RhcTllVjRtTWVteHl6K3JOT1pKTjlLemU1bkt1?=
 =?utf-8?B?R3pzYlpiUmhLTFE0RWxkL0ltVWU2R0JVcDJLRm5wTWt5U3p1cCt4bDZtN0Nl?=
 =?utf-8?B?d3FmYzRBR3pPR3RmZUFEQUpDRUVqT3hKamg5cHNaVEQrMFc3ZHZBRjNKNEVt?=
 =?utf-8?B?b2xpVm1oRlF2MFcyaTFBclFPTEloMUxaZWN5ZjlNSDdFT3NPaGV4VktHczFr?=
 =?utf-8?B?ZTBGSXVkZkpPcm5ma0p0R2xJSFBmTnBHaHJjWnNweTlPaHlram9qWmd4S2hn?=
 =?utf-8?B?alZDay9yOWM1b3JlY012M2FUL3VuOTNnTG1Md3k5UStRbFhZWDVtOWt0ZkpZ?=
 =?utf-8?B?ZHUybDEwa0thblRTY0s3UWc3NmV5MVBkVS8zbU1YLzAzN3hxMmtrNVpiS2pL?=
 =?utf-8?B?N3NGYmNYVU1CZG1BSnFKV2tacDdYUEdDVEpYZUZoYzlXU0FXUk11RFp3c3pV?=
 =?utf-8?B?V08zWUxLU1BoYVFldEs2NUNFd0NQYnE5dS9yTGRIWWpUQjRDV2hBN3hrSFlk?=
 =?utf-8?B?OEVyYlR6L0VJRk05aTdzMjlCS2xhemowdmpEY2xXc1pvQlRiTmdmNWZEdjdz?=
 =?utf-8?B?VFg4TVNzODIwdU5GM3lDUWFWbEJGVGpWcDg2MldRQzFYY0VUUmc1NHZyQmFE?=
 =?utf-8?B?YXN1OHArbCsyanZsb2lZRmNHMVZMTitpS1BKU1d6a2EvQ05XSmFBUzJnTmtO?=
 =?utf-8?B?TmNySk00KzE1TURZdmN3bFVyWTkwSlJwY2Y1MkszdW5WcmE5T0JPN2JBN2JE?=
 =?utf-8?B?SUtBODUxTEkyVERobmJCMzRrS0dSa3EyVTJTaTg2MlBvZHhqZFYvZ2Q1RWVn?=
 =?utf-8?B?S3NvVlgrNzY5SkpZWm5uUkVOUFdCOGQvcFdQQUg2ZnJCa0FqZHNwK2lhYWxk?=
 =?utf-8?B?Y05id3h0dCtIRGhUTU9mQUdveXI1REwweC9pZXp0OU85dkNpWGtXNWw5QTE4?=
 =?utf-8?B?eGYySWJKZGs1VGt6cFZsZzF6V1FTVTE4Q1ZWS3h3UFYwUUoxQkwvWWRKS2I1?=
 =?utf-8?B?UlVPbEQ0SnFLd1YzaW9maUV0RUhYM0NQUTRndmk2L3FCQ3lNNFY1NnBkNmNm?=
 =?utf-8?B?N0pVblJudW10b0U3VnlEaktLcGtqeE83T2hHczR0R3RKUHlWTUtHbFgzUHl5?=
 =?utf-8?B?QnBBcmtJOWpiSzlwVW5MeHpMS1ExbGpJdms4TkZhaENtZ1BQUnJldEVrczk0?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e823a168-573a-45e9-314a-08dddef00e73
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:14:37.4750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rVClzTxF5RMrnbb3G4D2HxhbWx2alOQyS70kJDN9UFp592zOjKMw9AwNFZCG1jEhNFa7veiiN8MKqD32aG5jUoSEUFZi1fmNeXe5ccokTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3648
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> SkyHigh spinand device has ECC enable bit in configuration register but
> it must be always enabled. If ECC is disabled, read and write ops
> results in undetermined state. For such devices, a way to avoid raw
> access is needed.
> 
> Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
> support raw access. In such devices, the on-die ECC engine ops returns
> error to I/O request in raw mode.
> 
> Checking and marking BBM need to be cared as special case, by adding
> fallback mechanism that tries read/write OOB with ECC enabled.
> 
> This is a port of linux commit
> 6d9d6ab3a82a (mtd: spinand: Introduce a way to avoid raw access)
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
