Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CDBC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 17:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F16806FE;
	Tue, 11 Feb 2025 18:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="W7h1RMP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E490E80077; Tue, 11 Feb 2025 18:02:56 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01D5809D0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 18:02:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXRjVlsbL6R4+zqwUQwXIqZlLE9b10n2dJ420m7kb0qjGa5dzCtKykxRtEylir1BjFXDdt/BUip2IOb9oGv6/ZZENl1EO8ZX+igUxTYX64FkT49Iu8KapdWuTsgQAVMlDau3oU3jCUef9rqHeE9kN401O19cde2AZruRPv1z1Q++5h7ZS/KvZkIgFkfQbyqhxo1GPbZs1v+jDMhLT/OzyaMaeLe8b7jKOxXhc8Hrs/5ULwtndJbkyeWlG7+sDew01v0hpkmOZQRD91arufHCVDpAgjIzIN1SgSwZ4YvuFM2AsG/i2eFgiqwlAWp0oDluMNDJvE1oKGq4KPllxpGTGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjLnA993P2M4UJbtpQrpipLMM6jVZMIQdRd23fiJRQg=;
 b=QTZO8rI4r0SZqiv4d5yCUWO8QRCGRK4uqQJlpbm+z1XI2pIBFDUKaFPY/vEzNqN0ffdzgBeRZAFGL0TW1LLcEslkm8mguZGEbUt0/zOyZFpFBVgDFK+s1nSLE140Jt3eSr0316U2Kqoj0CxP3v89fCgY6ApBbLyaYgM1vk+tdt/sNpKUM364WbmVqBzr1mJ//h29ROvb5qjprqI8qqa6WirO+O7AxvEXIM1zyfaHtqAFnWGrhhC0ZSvjoVBIoqY5oeEh+SxjrSU9/7QurpIvaQXjocnisYxZQztCWcrNYFW7MZyl1m0ZUdRSMVu1Ql8Sr3V0dOfloDZCXZvXZ8EF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjLnA993P2M4UJbtpQrpipLMM6jVZMIQdRd23fiJRQg=;
 b=W7h1RMP0wW1sfZsRwqYYJ7n+Df4kqZWUFCZE+GQjYGuJf0il1KSQRncKDQm6PoJj1dul09iNvgUDQwEKudA1dM9KteOg7owyz4Ydl0wbMzZjTExo6xWy86GND9SIoPvnPxG7E+BBFkdITA8/tetzO7iZrOHT8NfASE+kKdriIgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Tue, 11 Feb
 2025 17:02:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 17:02:52 +0000
Message-ID: <5c25b688-40df-446b-ab68-7de35ddd4a2e@cherry.de>
Date: Tue, 11 Feb 2025 18:02:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: dwc_eth_qos_rockchip: Fix disable of RX/TX delay
 for RK356x
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250209232801.3185681-1-jonas@kwiboo.se>
 <20250209232801.3185681-2-jonas@kwiboo.se>
 <0eb7b5d1-692f-4fc8-a3b5-6eeb5c56f90e@cherry.de>
 <a9eae65c-d125-47ed-97fa-08d815217605@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a9eae65c-d125-47ed-97fa-08d815217605@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 21663a18-049b-4909-2db6-08dd4abdeb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHc0SVRueWdFSlptNXVtQkt5S1JsUXI1dFlIN2lJbVFGNEtHcXp4dXhSUWFt?=
 =?utf-8?B?anJVVVQxaU1va3FSN1BWMlJZbWQzVyttS0UrbzNmbm1yRHJqYmw4NFlTRWxn?=
 =?utf-8?B?bFliLzVWRTY0Y2s2cjJYL3B4Sk42Z3BWNGR4MUtpQ2kxc0lKNzN4ZjVFM1pX?=
 =?utf-8?B?V09BYkNodUw2U3RXMkNUd0s2bG5ZdWJrL2o0L1hHL0VCZ0ZZUld6Y3dGeENI?=
 =?utf-8?B?cTRYQTYrNjVGZHdKYXM2Q0RKSEJzVXZ2TlpOR2hPYlpRU2Ezd3VLeStzcGR5?=
 =?utf-8?B?R05oV3o0MFlnZkhJbmI2dy9wTkczd0c2Uzh1UzdsUWNQMitTZWRaQTdwRm9I?=
 =?utf-8?B?RUhvZmRRT2VDK0I0WTBOUS9iLzU5WHhwVUE0NlVMNmhyam9FYTJSRUl3ZDZk?=
 =?utf-8?B?MVJvMWxHY2xuQUtlT3JGREV4aHJzZ0dUaUdzejJxanlKK1daUm81T2RialpN?=
 =?utf-8?B?T3p3c1NoOW96akdBM3Nidkd6K3NJVmNPUHJvTVdVb3lBZ3lEY2E1U3BVamxO?=
 =?utf-8?B?MU1BcEo1Wk9leXFxMEs2Y0lLRy9MSlBPTnFGVG91bmVIc3hwMG9sTElUVzlj?=
 =?utf-8?B?NkpKbkxjOE52QXpNSTF3bndGTld5a1ZIWVV4Y0NBOTY3czVCYk5CcjczTlc4?=
 =?utf-8?B?OG5nUUcwQXQ1WjVMdy9RL083aUUxOFBGYko3K3YzTWxzRW80M3NvK25IV09X?=
 =?utf-8?B?QmRieG1QOE9LYStYWnRjOW1mOWh3YXpycFI1eVVaTTlWOEtLazRJbXQ0K2lt?=
 =?utf-8?B?dTVlc0NNajNlZVBqZXJ2V3E4TE5OWUdrZ09FQ2xScWVpOEY4OE1RUTExa1hM?=
 =?utf-8?B?TldOazc0c1ViN2NkNEwxL3ROQms3SUozR3hmMTEvQWhkdHNkeU5KRmgxRk4y?=
 =?utf-8?B?S1JJek8rNnRNdWxxYnE0VXgwYlhmT1BuS25FSVVhRm5hQVloRGhrQmFmV3lX?=
 =?utf-8?B?S1lOaFJRS0JGVU5idHBPdEZJWDd2RHdNTnIrWnFlaXNtRWJIVUQ3SXkwb3Vn?=
 =?utf-8?B?eURqaTBHbVpZK0RyZkpoY3BRWjR2U0pCcWhiMFRkU1RYVXFpRDJadmtqY2VR?=
 =?utf-8?B?ZmNzTlFvR05UdmcvZUJLOTNpaEo2WjVTY2U2L3ZGQktsRjVOTjMzUlJIMWdP?=
 =?utf-8?B?OFh6cHdZaXpUbkdxb1BuQjJZUlR3MC9KRmV5NmNqMzJNM2ExY01TbGVwd3FK?=
 =?utf-8?B?THdKMVEyc1Z4RUNULzFFd0c1azZLWG1QdDY0MmJWeGI5L2l3ZmtGS3YwZGRu?=
 =?utf-8?B?SXMvN3gxYSttcnhVMTMyUkNTVFZYcWY4WnBqMFpoUms2cFBpcTVBU2YwVFJ1?=
 =?utf-8?B?Y0RZNTJPY2VuanIvZWdUWlVxeE9STEl0KzgwYTU3ditlSVMvNW1ma2tEMW9X?=
 =?utf-8?B?czZHWllaelU2UFlLcms3aFkxVU83cEorUFlnUTBUT3dPMlFHOHhadUJQSjBQ?=
 =?utf-8?B?RXBxNTlWTzBtYW5Ld1FzRTNINVZVTlgxUG4vNzZNTS90aVVtVCtuQVE3QlBw?=
 =?utf-8?B?MndiMXg0Wml2UlB6LzZCQjZsU3Q5dmVzcys3MXhLL0VQbFE1TlNlRWtNY1J5?=
 =?utf-8?B?RW9jRTFIeFM5SHVjajVaWXp1MXljbXhJMmFhNmxteDd6dkRFTEx4cTFiajNa?=
 =?utf-8?B?Wk9EZXNrdlZhTGl0WFZ2T2tzc0hDRTF5NFZQTS9sNVNyTWpPMXh4SFNFVXhY?=
 =?utf-8?B?Zk45Y2lqRFNGZDR1cCtCSWxaWTJTLzhHVzlnWWJQL1FkeHBZbXlZZkJKN1dh?=
 =?utf-8?B?dWxvTHFYUDJrbWJ2NTVvdHVSWXk4K0ZpVDM2U3Y5MjhuN2Z2SzlFZCtxUlF5?=
 =?utf-8?B?L1ZOSW80U0E4NEdtNEdHeDk4c0tsTTlVREFKS1dvdmtMUUNwOTBhUUp6cjcr?=
 =?utf-8?Q?cd5l8ijxV+HVS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWxWaVVXTXFKNktnTG1DMDRnU1FyR3Q2a0FHeGt4Tm9GWGo5QWdkUkk0VVdH?=
 =?utf-8?B?SnFYYkluY2pnclQ2U1Vuc2thcjBlNE1NL3Z4RXJSYkVtUkRqSTdnQk1zUDZq?=
 =?utf-8?B?UTJLVTFuVW43N0ZhOERkanpCU2hNRExnSSs0Q2tYUWVFbkNoWFRDeER2K3Ji?=
 =?utf-8?B?d1ZKMWYwa0UwQXZZVUpBWGswN0hzTDF5VUlLNTRUaGtSZjN6NkZsUWVBRzFY?=
 =?utf-8?B?NGVCTlBFZlk2MGx0dVFaTDAxbWNadUpMMVVhL1l2aUtoQk4ybjJRYURoWTFk?=
 =?utf-8?B?NUlDNm1vdkNoZ3V4c3k0bXFKUEd5VGp4T0VDbmZJbndzcE5PeXEwd1Evbmtl?=
 =?utf-8?B?NGduVmI2ZXl1ZFZ1ODNUZWorN0pFaExkSjBPT3AzNnd1UHJxUUZYMlFEU2Rj?=
 =?utf-8?B?YlQzd1R2STRmbGRYUHZmZ21SQU4xYit4UGtyWkh4eUlHdWNzUlRBV0p5MVpk?=
 =?utf-8?B?K2VTOS9LRzhqeEEwTVVpV0NSWlhVMHZUVTR1VXc3Unk0dnczSXd5ZkZsSVpi?=
 =?utf-8?B?RFNsMlg5dDBpQVJ1dk5kT3pnVUJnS3lGV0xTaFM2TWhZT2VlamIySUFUbXd2?=
 =?utf-8?B?bGRyT2ZYR3dZbEdSQU1GdDU3MW1pUWlOeDlIT0hCbCt6REFPa2xtYVdSN1Mz?=
 =?utf-8?B?RG05UHNndWdCUkZWc1hZNmw5TlJDaGVicXZrdUhrbDlaUkh2SFJYa1p3QkN1?=
 =?utf-8?B?U21FQ1RzWmNCSVRLMlJkZjRzSSszTVoza09vbVpzQmN4cjB6YlQrWFdOUy9n?=
 =?utf-8?B?VU41dE5IdTlFSXF6UllLemFtT1hOOFRRaEhQYjJFQW1YOGRUU0ErSHdrUVVI?=
 =?utf-8?B?WmdtUFRlV0RleDNGNFF5ZXVxd3dXZHIvUStoMDJjcFVWUnRqRndJamhrOXZp?=
 =?utf-8?B?bXA1Q3BaVFM1cXJna2xuelJ3cXJkSlhoZ1pVUFYyNC8zSVZxdTN4a0NHV3d6?=
 =?utf-8?B?bHZUMTJxN1dkdVB6VzZvZGUwZjJKemFMTkdKVFBOQWxXK1VYMnZkTUJHSVo4?=
 =?utf-8?B?eS9ib20wYmFiVkxJWkhuQWw2cUo5RTFHOEpQM0tSUmFLRkIyelJFcWRLZlJ3?=
 =?utf-8?B?TExtKzRWUy9RZ2lYeHNUMFp0dmRHNjd4WGl1djJzVUNOWXRoTUlVMEx1TitT?=
 =?utf-8?B?cWpCN1pzNkpvZFYvc0ZmNG9idWY5Q0g5b0tLZHR0dE1QbGJaVzRXRGpMQ3lS?=
 =?utf-8?B?L3ZXaWMrOTJkYVVVNU5sT1hjbHVkNG9COFRKM3ZycmNjQ1ZrTHQyZ3FZRzhS?=
 =?utf-8?B?bVV1VVZ1TGJxMVQ4bjFZaVhrS1RvYjd2MjZNdy9hV1loUjlWZWhlKzlmbmRT?=
 =?utf-8?B?ZHVOV1lJTmRoMTI2YUl6bEpsSVQ5SUZIbUlJcVpUdXNqbzRZNkRFVkVHZldy?=
 =?utf-8?B?bzdUL1JMcUxKZFNsdFNRbzMxcmhzTkdjZi9HdnFXWjFocFQ2R1Z6djJUVmR1?=
 =?utf-8?B?UWFjU0dtYXpUeWc1bjhSekdFczcxVjUrakMvQ2tlUWp6RkNVc2hiNzVIbU04?=
 =?utf-8?B?REhZOGhPa2l2Nll3emVhRk9sSkJRLy9wc3oyeXJXc0hhc0VCWXZlNWR0b3pI?=
 =?utf-8?B?UGNJQng2Q000UW5OKzZubXA2bU82MGh5RVcxaVhpcTd4UEhuVy9jMExwOEVp?=
 =?utf-8?B?Z3NxdTU0RDhBb2x4cjNWandFYm5PNHdLY0FBRVNmZXlIZU85WFZaK0kyVWI2?=
 =?utf-8?B?RVhPSTdMem1PL1dqSXpVVGorZDEwSUx6SVNXRUdjWlNzeDdDTi92M2k4ZEwv?=
 =?utf-8?B?b2ZtSWF3aHpJS0tPc2FWQ3p6WjBPM0VZYitHUWJaek9qTEl0L1d4Z2NqSm9h?=
 =?utf-8?B?YjFzY1RxU0FJK1VmOXRlZXZFY0ZqVEczUVZLa1cxUFpjMkx5a3MyeTFBMEYy?=
 =?utf-8?B?TXRVc2oyYm1hSnZqekpUVzNPeU04MldDVmRXcHBxeE5tS216WVp1b2Z4Um9o?=
 =?utf-8?B?MVdTT3dObm9yVDNlc2tuZ1VMQnBRSVJESDhscng4L2UrcmNkRGZtaUc0Slcz?=
 =?utf-8?B?N045eGRqNUJQOStyZXBwNzc4a2U4Ykk1dTJ2KzhleGZRd1NWbzlYaUtZSUc3?=
 =?utf-8?B?QTRIWmdQOGJZb1I5dHZJbEcveTVNUDRrMnM4Umc0SnB0WW9HeHpwckNjRk1x?=
 =?utf-8?B?UjhZT2RjaDVoRVhXQzBTU0J1bEd1MitNazNac21zbTJEdGZqUHQ3MzhMbXF3?=
 =?utf-8?Q?Pri9hhLDL151y6jkZV0Uloc=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21663a18-049b-4909-2db6-08dd4abdeb12
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 17:02:52.6384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v18c3QX5C3Yyorf8NrQyy9PZA0/4PSTi4+oQb0OhVGc0ZNmUSe2w9wD1l4gNxV7YDqpIL/zeYkzzZoa79O8vrFij84B7reZ2Mewp5aG+Ys0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806
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

On 2/11/25 5:46 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-11 13:20, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/10/25 12:27 AM, Jonas Karlman wrote:
>>> When rgmii-rxid/txid/id phy-mode is used the MAC should not add RX
>>> and/or TX delay. Currently RX/TX delay is configured as enabled using
>>> zero as delay value for the rgmii-rxid/txid/id modes.
>>>
>>> Change to disable RX and/or TX delay and using zero as delay value.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    drivers/net/dwc_eth_qos_rockchip.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
>>> index 9fc8c686b889..3e10e07403c1 100644
>>> --- a/drivers/net/dwc_eth_qos_rockchip.c
>>> +++ b/drivers/net/dwc_eth_qos_rockchip.c
>>> @@ -46,6 +46,10 @@ struct rockchip_platform_data {
>>>    #define GRF_BIT(nr)	(BIT(nr) | BIT((nr) + 16))
>>>    #define GRF_CLR_BIT(nr)	(BIT((nr) + 16))
>>>    
>>> +#define DELAY_ENABLE(soc, tx, rx) \
>>> +	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
>>> +	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
>>> +
>>
>> Considering this won't be used for RK3588 in the next patch and that I
>> found it obfuscating the constants that are used, can't we simply do...
>>
>>>    #define RK3568_GRF_GMAC0_CON0		0x0380
>>>    #define RK3568_GRF_GMAC0_CON1		0x0384
>>>    #define RK3568_GRF_GMAC1_CON0		0x0388
>>> @@ -85,8 +89,7 @@ static int rk3568_set_to_rgmii(struct udevice *dev,
>>>    
>>>    	regmap_write(data->grf, con1,
>>>    		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
>>> -		     RK3568_GMAC_RXCLK_DLY_ENABLE |
>>> -		     RK3568_GMAC_TXCLK_DLY_ENABLE);
>>> +		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
>>
>> (tx_delay ? RK3568_GMAC_TXCLK_DLY_ENABLE : RK3568_GMAC_TXCLK_DLY_DISABLE) |
>> (rx_delay ? RK3568_GMAC_RXCLK_DLY_ENABLE : RK3568_GMAC_RXCLK_DLY_DISABLE));
>>
>> instead?
> 
> Sorry for not being clear in the cover letter or in commit message. The
> DELAY_ENABLE macro match a similar macro in gmac_rockchip.c and in the
> mainline Linux driver and will/should be used by pending RK3528 and
> RK3576 support.
> 

Ah, this is what I was missing :)

The commit in Linux seems to be eaf70ad14cbb ("net: stmmac: dwmac-rk: 
Add handling for RGMII_ID/RXID/TXID"). Maybe add this to the commit log?

>>
>> Also, if tx_delay or rx_delay is 0, does it actually make sense to write
>> the delay config in there? (so the regmap_write before this one).
> 
> It seem to be what is done for the other SoCs GMAC in both mainline and
> vendor U-Boot. Not sure we should deviate too much from what seem to be
> working.
> 

Didn't know there was a reference, thanks for the pointer.

>>
>> Note that the config is set before the enable on rk3568, but the
>> opposite on rk3588 which I find quite odd, you usually want to configure
>> something before it's enabled?
> 
> I also think this look a bit strange, however it is what is also done
> for the other SoCs GMAC in both mainline and vendor U-Boot. Hopefully
> the reg write order does not matter for the hw.
> 

/me shrugs.

Maybe update the commit log to point at the change from the Linux kernel 
as reference in a v2 if you don't mind?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
