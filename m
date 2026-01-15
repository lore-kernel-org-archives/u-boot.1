Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02FDD41178
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 12:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4114B82BF2;
	Thu, 15 Jan 2026 13:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i2qrNJJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4BC83015; Thu, 15 Jan 2026 13:25:00 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37DC80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXnt54fhKAqVl3F1HbQzxspt5uYMPjfKEvVH+Jas2Hm+yRNesz53D1U6XMcigIz35t3QRW+pyU6oEJg8+LAxWdP+Ta+gXPnEqrpgRHVz0E1Twyhts1FnlTNByudq9o6/Ca5EmVCPyXaUCW/Owofx/mZoGFdjyls8UEKhuezsjjC2lWQ6FvqX6dKHJQ7lblc5au5eRzwG8KcXkrkoqLdlwW/+7cG/1p4izFHvQ7HaORpZb3K/HMcY/8LY138fVIkw3ItVo8OgdtpISceunwD5GWq4gNj2WveKbULucSjULdcRflL45nsmWKMxmf4JmpHALy8UXXUTK4jhRxdMQ5LRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFgN9Ok6SvRRBHvU7yupEXtSXSR/QL6EmcO1T5wF3gc=;
 b=Z9m++a5ySA6RFVURDKvYeYvu8SSdHSxgS12HW7lmE7pnlEwdmV/Zu3EClF6jHD7JudceJ3Ch8LTs+GcCnG1T2iK3YVuYrt+dTbMJ9z9KNC7y2VzrpPVtljfRiZJM+Fg9uE2rsveksKZDuL0wAZnkR8acM+OzLVIBIxQHxEOTDNtDtCh18kslZaonV/02J/SzskzX3AdhwE5PN+AxbAnX4dlQG/LSMaXey9clI4qBK69K8mtHNvgEu8LBBn/A2t04Oul6GRt17KjS3HT9NPpppMDzle+DEuIA1ezl78NLB9FoeYvZuLeQRi+Tvy0DqG3esQzBrswMABAVQoooOrXofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFgN9Ok6SvRRBHvU7yupEXtSXSR/QL6EmcO1T5wF3gc=;
 b=i2qrNJJIXGoa3+JGG7tpszBl2Sp3WQ2+yTzyfFD2zdvjwxB/kDfipBVJ8pHcKB+duqaqPooDkGZMUBUAVaj8gPbH3ieH7if7Q2+tUSPSGq3PDblGVRzgUvI1PcaKzfQDjqEiciqdjLlU37z7Y0ZLWIBFbPeZJg71o0pI2hhVPsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8089.eurprd04.prod.outlook.com (2603:10a6:10:247::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 12:24:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:24:55 +0000
Message-ID: <af311e0b-e9df-47b0-9313-93186ca0c14e@cherry.de>
Date: Thu, 15 Jan 2026 13:24:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add FriendlyElec NanoPi Zero2
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20260110205337.1242457-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260110205337.1242457-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 070a92b8-f523-4a6e-dd41-08de54311753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R29UUC9DcVE2Zzd0Z05sTkZZNnF4T0Z6WGd0K0tMZE9KMERoWUlJV2c2SEVq?=
 =?utf-8?B?OGtUNXkvQ3JhTW1HR1dZUFQ1UDFzTFN6S21Vdy82clc5aHJKcDVRalhNRE1L?=
 =?utf-8?B?QjlvZm93R1JKckNqQ0Npbnh0RGZGeTJZUERYVXVYZmE2Q0NQL3Fub090alM0?=
 =?utf-8?B?WVhwRElyeSs1L0FnM25rODJ1b0hvUm8vcHpEaUtuRE9kaXhVaSt2a1luMXRj?=
 =?utf-8?B?K0Y3Q2FqQlZ0SHhZSnUxRjJrRW5NOTZmZmMyMS9FblJuQ0syQmlYRTdtVVRJ?=
 =?utf-8?B?L2JMM3crRmxxak5ObGl5Mi8wNVZ0Nk1NdGpxdm1rdXA2Tmhmay9nV1pieHBV?=
 =?utf-8?B?eG5sTTZjVXcrV2ZiSHhxcFRudFU1dHlJR2JZakRhQ2RFbmd0RWpkNDNMM05p?=
 =?utf-8?B?RWoyb1prdjczU0VKSWVkMmswUE5sbk9FOTJhUmRLMlJCSC90S0xyRFBLdXRu?=
 =?utf-8?B?ZE50UzRyNmkxWGtxU0NFSzZ0bEtYOG82SlhrZHFvOXBrVVFMZklDTERwTWdn?=
 =?utf-8?B?T3NqNHgxMXorRXI0RjQxN0dwcjd2eUFnNndJcnVSZ1h0TmhaVDc5UWoyVTFj?=
 =?utf-8?B?cDMvMExUZS9NK0svMG13Nm5UUldhYldjbUx5aDB0c0xXc24vUmx5c1ZBMkZh?=
 =?utf-8?B?NnNBWUd0S0xuYm5Oa0V1ZWM0Q051cGFtclNIQ0tKYlAyMHBWTzQzcEt6anQy?=
 =?utf-8?B?SzBBditMM0ZDZllNUEFhNjVGRTRaZjhNb3FMRlJIOEVkUGFwSUdaY0RvcjJI?=
 =?utf-8?B?R3YvSlEyVlZyTFQ4MCtJU1JNbTE2eWVXY29yL2c4cEhXdWtDUHJFTkxvTENF?=
 =?utf-8?B?WEtqUzMvVDVueEhlczZrZzJyRVljdTVVNUdFOGtWWmRCV2FRQVV3UDNhMmo5?=
 =?utf-8?B?WGs0aEFZaStMRi9ZTllWZVl6U3FYWUIvUGQ3OTdyUWIwajVpY3V2bGpYc0Z2?=
 =?utf-8?B?L1d1QzJHdFFueG4wdW1ObW9kanYyakw5S0JoY0pqREg3VVovRndhWUZyTk1h?=
 =?utf-8?B?dHZJNTloSE9Db0oyQ3JiRkVVSXd3bFEyYjQrQm0xUmtKTHR1dlRYK1FSZjFC?=
 =?utf-8?B?b1BXcGZaQVd1TFE1VEY4VDFOd2cxQk5jZklUR3lqV1hZY21ZdTI1VVFwV1pZ?=
 =?utf-8?B?V2JZcnhna2k2eU1wZGxCS29BbldiVzFsWWJxQXpHM2pBTjUvWnNPd1NDT25R?=
 =?utf-8?B?U1VnbXFvTStjOURWMmprZVFxM3o3RjVaUFovMXlySERxZCs3Tks5RXVkMGN5?=
 =?utf-8?B?UXBRdEQ3RGo4RjA5QUR3S0ZGNGZEM05ZOGpBaENGWGhqNnVQS2ZaNHBFNlRD?=
 =?utf-8?B?c09UV09MY3IxZ2E1YlZEdENieDFzcFlnZTVNQnBiYjhnd0Z4eG00RDE4RDk3?=
 =?utf-8?B?eVpaNkhYTTFsRmcwdWVaLzlWQi9JQ0dIT0VKdjd0SHJUU3ZKSGQwNmtDTzVN?=
 =?utf-8?B?WEpDRjhucWphTEtpdER0bVJyK3daRzZPdUJiWnJJOGpLbUdUcXhNQS9zaklT?=
 =?utf-8?B?SXNWenIrRGRuZm8rb25WNzZRQVV5NVZuRjVsWTRDS2s5RXJqQ0hQRmpjMzRT?=
 =?utf-8?B?S0kzN09qVWMyT2hLdDdjUEVwUTZBUjkyOEIvWmxOUFJKVUJVVjFZVDJXYXRl?=
 =?utf-8?B?RnlzcmY0eDFCVGllTmdYcVZXZ09OOStTemVxQmNNUzk1aDB2KzN4VVBzQ3VV?=
 =?utf-8?B?SVVMWGwwYmZCcHorUEREVTJUWHRZM0ZHVVFBVDJUVG9nNTBpRjREQ0taOEdm?=
 =?utf-8?B?b2FKOVVhNGc1VWJOU1ZWWXFVNkZOWjlxSFpnSVllOFhRQUV6aU5oc3FQM0lx?=
 =?utf-8?B?L2NWUWpaalZzQXcyc1dpa29KWGxxekJmWnpjQmF0bG1RYU5tNnR6Y1lMVU5C?=
 =?utf-8?B?djhmMnFXOG0vbnZja2hOZ1NmaEJDanFPNGl6QU84eTBjSFBJRTVXRXRSRXhj?=
 =?utf-8?B?SVo3SUgvMEhrSnk4WVgyVXo2aXh6S1RvUzVjU3VDTmpWdkhjdnRLenMxNTRq?=
 =?utf-8?B?NzFWS2NTYlNzRXpyK0t6ZXpzcjBUbnBkTWZiRDVGRjIzbkRldTZXNmJxOC9U?=
 =?utf-8?B?RDRCbkQyL0JxSDRMbXlpKy9RWkplblBkaDNEeC9VRGNHU3lBZkxteThHa1Ux?=
 =?utf-8?Q?2VKU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aExqbDJZTUVWNXg4ZUJ4dU1RUEhaYTVKL29iWXlRT3Z2R01lWk1mVUpPbHUr?=
 =?utf-8?B?WjhJMFBTcmpQNU45Zjh5ZFhjeW9qU1lpM2RHT0Q0R0VwWGYyNnF4cktrMEFF?=
 =?utf-8?B?WGo0OXA5YjRmK2tYMnB1bE1iOStmc2U2VzM1NC9EMSttL2JJeDFmYm14dXpN?=
 =?utf-8?B?dVJCdDNjMHlNckdhSXdSNjkyMEhFTVZKTzl3SkVjQy9SU2pNcUwrWkJnc2o3?=
 =?utf-8?B?c2JQajY0cHpzVlJzVk1wcVhxY1NKR2VYN0RzTmRDdm5jdk9qdTA2bUZza2Q4?=
 =?utf-8?B?ZWhJRHNnQmpqTzdHRmNtdHN5aG1yVnVNVzZhSUNla2RmSmpwNGJ3Y094M3Ez?=
 =?utf-8?B?VHU1K0gyV1dlQm01SHBlRjdZbEVxT2taM2lzbzAzd0RRd3NoMVJ0dWNrOHN0?=
 =?utf-8?B?NHhqRUNTUk9BcmtsQ2tpNE5Qa3RiOTcvOE5VbG1sUEF1SlNqWmZVQWtuZEtO?=
 =?utf-8?B?K3E5anR6eDgxeGRyYU9rcUxhcStORktlOVZHamJYSXVFdlpCNStYZ01ndDRj?=
 =?utf-8?B?UzE2UlZVam55cTlaUWpqYjFwOVpFWjI0OU5XVVYrYmtoY09oelVFditOYzU5?=
 =?utf-8?B?RVhrK2t2aVZidStpeUdQRHdURGl3NEROc29Xc3I3dTNRRy9LY3hESXZWSWFR?=
 =?utf-8?B?aDJ3NjFYMlh6bUJkOWtxZ3NLYzRUaHY3TncxdUVqcmRUeHB6MHpxK1YzNExK?=
 =?utf-8?B?OWJnaFJXam1lM3djMWtUNFFoUFFxdlVqcEs0TWIwY1BHcG8vSlZ0ZUdKaGZR?=
 =?utf-8?B?WXdjSFE5OUNFcUVCeWtEK1ZiQmQ2bHdIWXp4eVVJdEZJQThCMnJIakJod0lB?=
 =?utf-8?B?eno3WnNpc2x6dWwvWTBQeFZtcVozNXVVZFpSYmhyVDdydW9Tc2xjYnFLNjJP?=
 =?utf-8?B?QTgxcUtySUJJQUY1UjEzdEpYS2VmMDRGTFAyODMwbDR1SWxoc1l6ZFlJanNP?=
 =?utf-8?B?N1h5SUlzbDJvVGNKN3pvQ05xMExNQVBaaXZJd1lIaW5ybDFreDN5R0VBQVk0?=
 =?utf-8?B?NEJkS29NK084ZHhMdHEzbmtBakZnNE9PMENXdkh0U0w5WVVmQ3F0YjBjenlG?=
 =?utf-8?B?V3lHeG00WjVMeEp3NVJET3ZCdCtYdi9DMmd2enBEeEx5WExyR1hUdG81YUpH?=
 =?utf-8?B?VmUxOTQ2MUNOTFNnSHNxMDlGc09TZ2MyNWJXOGhWSkt2NzlxSmh3R1hGYnZT?=
 =?utf-8?B?YmRvSTJ3bnRRSUMvWnIrak9XYVl1WFpuTG9waDlDRDNsQzgxTElyOWVjZFBQ?=
 =?utf-8?B?VkN6SnFrR3BndlZPS3lpR1BrdE1HVllYR1R1M0xTRWY5RFpDSjdBZStEMWo5?=
 =?utf-8?B?dGhqZ3A3NmlMcEVlN0M3dGtqcjJRaWhHS0s0T1hEcUd1MHhGM2dRZ1pEQ0NF?=
 =?utf-8?B?aTMvUDJEQ20rbCtUK2hPc0VmMmYwb2dHaGh2M1VvdjY1Z3pyWmptK0JueFRi?=
 =?utf-8?B?UDJ1K3ZxV05venJOVWx2MzcrSlY3TjVBbGc5ZThDc213RWE2eFEwcUZ2UWVP?=
 =?utf-8?B?Z0FTR2F4R3l6TFZZTmJ3RWREZWp2U2FBZnVYM2srRkJZZXZxQXNURkdGYjgv?=
 =?utf-8?B?MEhrNVFxTDczL1FnQ21xNjlGZGlvV2Q2M3pnb3V1ZXY2bUtBN3VuVFlRZ1dW?=
 =?utf-8?B?aGJwWEJMZjkveTNOR0N6QVNiTWQ1SURYKzVnd1BGOXdBSUhQdHY0UXRuRkEw?=
 =?utf-8?B?OFpBTGdTQmlDVVZXblpIRFRYZUQ3L1owZDdvbkFkRGh1QkY0TlgrN0xOOUFp?=
 =?utf-8?B?QXR1OUc0cUpNRWc1c1RkeVN0Y3VGTlRjOTkvZWNhUEw2NnhHekFuTVY4eEJr?=
 =?utf-8?B?UmNxNFRFM1BPWjlYdnlBSVBXMWtRYzJkTVRxV0hnUk41TzdDdWRaUGcxNGIw?=
 =?utf-8?B?bGlWOXUxakhWK0VlTjlJZXpYRFRPemlDN2lDUnQ4elA2bXo2b3Fzamg3SlFF?=
 =?utf-8?B?UFFCZzJDVmZNaVB1a3NxeTRsNktURm83VStoNVZUMXllZHVmc2tEWkZQZUt0?=
 =?utf-8?B?S3JVbGVQVGs5WGx3eWRrbWlLL0ErYmlVMng3eFhTZytDUXBnZnhGYVl0VlQ1?=
 =?utf-8?B?cmN0UE5xaXlQVzM4bE9XTkxMeXlSbWVmLzF5TitwK2dJRlBiZDhKQ0VMNmpx?=
 =?utf-8?B?SWl0cEpkUC82VTNZc2JBOHZoL1o2RUp0Vk9qUkppdkdZeHB5NW5Tc2VHZ2Nv?=
 =?utf-8?B?eWdiR2VzZ3VLbmFER2hXWlFOKzBqaXhOWnExZ3dvZHYvU2s1aGdnK1h6Rkdt?=
 =?utf-8?B?ZVVTZlAzeE5zZURyVUhzYXVIZ080dE5QbTRkV2tza0QwNGRFZDc4MzEvWEFq?=
 =?utf-8?B?ell0cHZXL0FSYmhTREczck1JWFk4dmFsY2hBQWtUZElkUmp4RUx2QT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 070a92b8-f523-4a6e-dd41-08de54311753
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:24:55.5684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqSsQZ3aRLl2nuysObq68tFcqJDzrG8WDXDfgRLAeoRxdYuZdhUpY27644dSaac+k+yYm7bvW8KG6WFKDuSmaFmQnzAQ8hBsJJCjKe0HHEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8089
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

Hi Jonas,

On 1/10/26 9:53 PM, Jonas Karlman wrote:
> The NanoPi Zero2 is a small single board computer developed by
> FriendlyElec, based on the Rockchip RK3528A SoC.
> 
> Add support for the FriendlyElec NanoPi Zero2 board.
> 
> Features tested on a FriendlyElec NanoPi Zero2 2407:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - USB host
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 ++++
>   arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
>   configs/nanopi-zero2-rk3528_defconfig        | 64 ++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst              |  1 +
>   4 files changed, 82 insertions(+)
>   create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
>   create mode 100644 configs/nanopi-zero2-rk3528_defconfig
> 
> diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> new file mode 100644
> index 000000000000..3e2fbd81da17
> --- /dev/null
> +++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3528-u-boot.dtsi"
> +
> +&vdd_arm {
> +	regulator-init-microvolt = <953000>;
> +};
> +
> +&vdd_logic {
> +	regulator-init-microvolt = <900000>;
> +};

Why? We need an explanation here to know if and when we can get rid of 
those additions. Why aren't those in the Linux kernel tree?

OK to me otherwise.

Cheers,
Quentin
