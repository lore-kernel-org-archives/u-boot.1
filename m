Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084F1C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 18:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119FD805D7;
	Mon, 10 Feb 2025 19:16:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fwMds5rK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E5980759; Mon, 10 Feb 2025 19:16:12 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C6D78043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 19:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPCwLvK92j8TKsD91T6Rk+vZuS5BdwKrQ0rmym8x1gFvMHsjvDMk41B0ATJh/oTB7OVYqS8sBE/oHB7/DiOLpd+e1i68H2C0UKXKRP2fhRElsx9V1bPnlgTAT94zSez4ROJKqpsh7exdI7W858cFxHWb8A0LYgt7HvdG+4YCqTvwcXScqYyFHyluDQSIMi9ipytK2s420v8FkMrZu0MmPLQqGeQxNbJjEg/mIdnXIdUgLKoaE5YaoHGOjmlYnt9Wa8G36TzWBLC3kqivxbOq0Jc2e6AUcauM0gzpgHiRXeN9tE50eeUomCOWtlS5Wc+kU36LT8HxdAR97QWnN4jl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTD2d/3DXtIkCSkZLCtxlr77yHyrBLuu7Av/Bh0US8s=;
 b=eiQx5QxNYd/3BkHuz+q8kEzBx68V+ybkk42qtunWvjp97J7nlGfatYZyZo5lPpg0MiIHaH55eFaPmRaSIr/0D/VqxNhAV6MAzHxOILC0KQTGeyoR2BjU+JOMytn6IGUeNxvO1AoJsBXjWOXd0ucS0VmVmx/4LVFyHS/hEFzcXfuvqGLGfspaDLnaZPMzrWRwSocIE+RfCPzSkDOBtYJU7drISi2qC5O+XvnAlj75HelUdLtZ8iXMgcsNQqaD9qTDUt4BpXFS/An8NXDi/NcEvWXnr5goiPbqYeUOMI5Q3OOVMS4oHA3TZDO1DgEwIRlBAdAiQHtvSP4omuNSPSSO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTD2d/3DXtIkCSkZLCtxlr77yHyrBLuu7Av/Bh0US8s=;
 b=fwMds5rKovtgyQsi2LMYaM3e9+HY2l7rlLdpk9lbdBUhUDeV+ZXucT64BXniwPTB4DjkxSL60DKMtejojn7hUhU5SSeBiOmy4fNKqyYpd6udF8/cV9w2Wp5IjEKp975vm3dyu/ESFDy4SU/YiPY7CDR97pBMXELcjoqYrDUjcJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VE1PR04MB7278.eurprd04.prod.outlook.com (2603:10a6:800:1b1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 18:16:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Mon, 10 Feb 2025
 18:16:02 +0000
Message-ID: <b64339c5-b27e-4fb2-8864-1998f21e0adc@cherry.de>
Date: Mon, 10 Feb 2025 19:16:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arch/arm/dts/rk3399-roc-pc-u-boot.dtsi: Prepare for
 SPL DFU
To: Arnaud Patard <arnaud.patard@collabora.com>, u-boot@lists.denx.de
Cc: Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
 <01020194f07b6837-f36ee1ff-c1e8-4b2b-8b11-76cf02467b15-000000@eu-west-1.amazonses.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <01020194f07b6837-f36ee1ff-c1e8-4b2b-8b11-76cf02467b15-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VE1PR04MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a289548-e5ef-4487-627f-08dd49fefa61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUMwSktpRnBEUWxNOGRBdE52TlF5NytOTjZIYU1yYlBDUHZWbVp1U0x0dUtN?=
 =?utf-8?B?cXNFNkVGWEw5MTQxYTFaU2kvSVJYZ0t4ZGRoQk9kcnIwTHcrWWRVd09XRnY4?=
 =?utf-8?B?NTBUakZMMXYrMGs4MUwwQ3pRSWt6bTBPRzQyOWJJL3RUMmljVUtLZllpWU9U?=
 =?utf-8?B?akJkMm1LcnZFdjM4WVRXOWg4RE1iaXdGY3FDaTBOelJ4azlMUENUQ3FDTysy?=
 =?utf-8?B?ZE9jMzlCbnZZZ0toT1hSV2VmS2hTaXdKcVdGKzdGVzEyN0N2cWpJR2F4ZmxD?=
 =?utf-8?B?UjNUQ2hVUkpiL1h3a1FtNHMzd3dROCtJU09mL2swbHorYmtQbUpPWmQ1WHJv?=
 =?utf-8?B?M3hkZHNxamF1OWk4NnRqUWIrS1UzTzNVMlM0dnRIZDdKbEZHYXlleVdzdTJT?=
 =?utf-8?B?RXNhNDhMY1U0V1ZOQVF6b1U4NUY5MUZPZHhKbFljcXVoYVJ2enNoWnVkMUVv?=
 =?utf-8?B?Z2o0cUxKTkNuZFZiRHlrUVVFek9NdXlrbUhYVk1LR2VMMUF4dm9HaVFnbW9V?=
 =?utf-8?B?OHJEbDlnZVA5VVBST1c2emFvZENueWVrTWVVTnByVVZVS1R5ajlGV1pqTS9O?=
 =?utf-8?B?ZlpJblF2aXgzeW5XUEZqZUxGQ3JLV05ndlRKVC9lYjRvRHRzRFJwWnZwR2gx?=
 =?utf-8?B?ZE43UCtpSjJDZHpsbFgrSWxsQmJpd0Nmbi9RcWZLVjRhZnJSN2tGMnpPZzlJ?=
 =?utf-8?B?dERiYmJVTzJYVE5Nd2JLZDV4bnFjV0dVeDlmMjdwOWY4UGJrYTJSdFZvdEZz?=
 =?utf-8?B?NzBrWXZud3JhM2VwaTI2cUNPUHVjNThWRUlTc3F2UUpEUnhUMmt1aVJkU3da?=
 =?utf-8?B?ODMrdU1UbmJTeHZ1cHhKbFdpUE9LNFIvbnExUm9tN1M0V0JuVjgxTDNXMHVD?=
 =?utf-8?B?SmN0UGlPVGc3WUIxNHoxT2hGRkxWMGkzc0RhbkdkVnJKVDJvN3BRTVc2SFVi?=
 =?utf-8?B?RmJrdG9VL3hPMVdsVUdMbWZUWW9IeEkxYUZ5U1BvQlkwL1ovVERidGJEa1Iz?=
 =?utf-8?B?cHpQR2ZMbThzMWpvamhlcnkwMDNWUTExUFRhYTc3UXJDN0xuYW9FbkgxdjI4?=
 =?utf-8?B?SU8xMEV3Sk1iRXRXaFI4bGNFOU5neU1lYWhFa0ozaWdpWjZQUkdIR2p6ekRE?=
 =?utf-8?B?dzV1dEM0QUZUcHBJdFpTOGtWeUtQWm85RmxhZTA4TUJMeDMvWHlrRlhrcG8r?=
 =?utf-8?B?dHVUTjFpWWlobWdpRzBLL3ZUU3hISk5CMUFodGF4QlNXRGNiMm1tR1lYU0ty?=
 =?utf-8?B?dUtseFlTV05MUE01SkZ1dmV0TUdnMkxVNXU5eXB4UjBlRnpuYW5IOFJMVDhL?=
 =?utf-8?B?RERSOHBueFh3d25CQTFLNndEY1JNR2VvSlRKWmNDT0xaR2x2L05rWFludjdq?=
 =?utf-8?B?K3ArMkgxSFVyY3B4VFkzd2VlcFhDckdyOUxxWk94cE5KaVVJRy9XaWVVRWts?=
 =?utf-8?B?M1h3bDBjck5TckZUaFpkVjNxY1V2RkFUYUhBY2Y0dDVlVXEzUWtWNjBKQ2Zx?=
 =?utf-8?B?Rm1RaUNCUFFLbEdOd0FTeVJmQmlaQlR3TWl0cUlLWjBnQjAvRzY2a3ROazRz?=
 =?utf-8?B?WGE1aE04UWFUNDR2aHk1ZUZBRVc1RGcyNmJ6MFFOb0ZBWDNrbFZrVHg5eHJ4?=
 =?utf-8?B?ZS9BQVc4Q1EvdEhLR2NSQmVGQTQ4elJaUzdBRjk0MzlURXFncENVanNmTHpz?=
 =?utf-8?B?dDNjV25pb0JpSXQ5MThURU5uSUdKQ1lweTdTV1pHZmJTYlVobmlGYUJQaXdK?=
 =?utf-8?B?VW9qSFUzYk9WNFlWNTNPdXFhSm9Lbm9OSVpwRXE5bkpFdUlIWDdHemN2Uk03?=
 =?utf-8?B?b29BRHVOWGtFTEIvY3JmQnBDcjVpTXN0b1lFcStrdGRleU5XRm5UVUduNEFz?=
 =?utf-8?Q?oZD2s6K7cd1Sl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlkU0N3MjNsQ0xlaG5kckNnM3NkK2hQbVU5M2Fyb2orMXZ4Wm1zS2VHTk5Y?=
 =?utf-8?B?TzhSWGJtUm1rRmVEQUZJR29xcEVQTUUrUHpwTHNPNGtVeVdJaStNZlBCcGM1?=
 =?utf-8?B?SzFRN0ZucHZhYml3bGdXYjdQbURSU2VUdHJzVGFFK2RZUUZhdWdFYnA2SEJR?=
 =?utf-8?B?Q1M4a2xudXlpdUJiMFUrdi9JYk0zZHhOem1lamJyZVIxUElFS0FPL3ZmbldC?=
 =?utf-8?B?UTFUaWRLVFNKb2VWRXVaQWdjRUl2cWxQdUJwM2N2TGNUVEw2ako3R1JYdG5a?=
 =?utf-8?B?cDlwZHdocXZNNXY5ZSszZTRvcVdSYkhNeGpUSDgrOGttWnh4cm1kTjM5VXFl?=
 =?utf-8?B?OUdGbFhPdFo2andKRWd2T3pRb0lTQjFiVjEvaURtU1p2ek5hNnVqTkFWdFBK?=
 =?utf-8?B?bnZnOWVsN3NIUk05bVc5ZllXemw0WFlLWjdCYm9CR3R3TnlEQlpUdUphTkV0?=
 =?utf-8?B?SmlqWlpvR2FRc2xqNDlybG14MklUK1A4aGM1VnJzQWVITnhuRjRhaHVxM3hw?=
 =?utf-8?B?TDEyU0ttU25Qa3F1OUVhVWNWMlZycHVpcG5ScUIzZWllWjJkQnJkZ0oxNHFV?=
 =?utf-8?B?aHM3UGRQWW1sY2pqOW9aL1A5ajRHeHhsWjJYVFRvS0I4ci82YTlsKzZlUmxX?=
 =?utf-8?B?RDRBS0ZTRmJYK0R3ZUFWUzlBbHR4ZUcwdDFKeXVLeFFkWGZqK1hLZWp5R0xm?=
 =?utf-8?B?UlkrdVQ2cnNHK0FQOEVycWJOY2FsRUozRU1WV3RKdEFxcGttRE5QYmJwMjRv?=
 =?utf-8?B?MnI0ZEtHb1Q3UVRpMDFEQTcyUGRLclRIZno4M2F0eHRJcEtUVE5LeTlhRXdr?=
 =?utf-8?B?V2dXOTB5ZjA2OVJVTXpsZmVHTW8vYjhrQk1aZ3FQNHNBQXI3UkUxWDU2ZjlD?=
 =?utf-8?B?QTdVUjE4L2Q2MWNHYldmRm5IbDdKRGQ5QThGY0R4RmZaN1M3ZytoRTIxSmd3?=
 =?utf-8?B?bjVyUGdxeGJyZVNXNjVmNi9kcWIrbUpZYkxTYkhtUXJuQlZZSW9ucHBXTzdy?=
 =?utf-8?B?VFdTcTQ3cWRUVTRzOWlON0FXUmd3VENQWXdVOS9hOVYwcWlseDB0QlB2OU9x?=
 =?utf-8?B?Y3hQbWxleEJ4L1pMcEUwWmFqcVZ6TDVzTTNSRkhDNzdMNjNpM3c3NGJsYnVo?=
 =?utf-8?B?bjNtdXNCdEJOSEo0M1NoOTJFRGIxd2JuK25JNnRWMGxRdVV6LzJQQzZyYWJz?=
 =?utf-8?B?M3M0Mmt2ZTMrc2UxdE1CVVB0R2psYVZGZ0hNdEdGMjkwd2NyeXN4T0RETHRq?=
 =?utf-8?B?K09KWEp4ODB3R3l0SytxMDM5M3hMa0tiNDBYVklFazNXWmNqNHA4cjVNbUc3?=
 =?utf-8?B?WW1nNzcydGlDTTlMUEhVMjFNZCt2b2NEUlZ5WDBEOGtGYTNleGtuNVBGZGJ6?=
 =?utf-8?B?T0pxYlcrb0RNUVhvb3VtR2wrRlR0dFQ1REs4OXdFMFl5VW9GUjRmTzZ0VlBt?=
 =?utf-8?B?SUhseUYwa253TlBkWmxFTHhpRGxGQUN4UVJJWVZBQmNVUndRek1JeEgwdlZi?=
 =?utf-8?B?U1NoOHJNdURTeVdLR3dvbXVpU0VhekdXdmpCUjZ4eEJBMEVwelpOaHFsc1pQ?=
 =?utf-8?B?bkgxTVdGN1l1VnNVUFE2M0RmZER1SFVkeElMSlVGVDQ5aHBtWmxreitYZ1I3?=
 =?utf-8?B?TkFOdDNsUURibWNzSTU1NExTTUZGUERVa0tpV2ZLNWtQeXREcnJIVk42YXZ1?=
 =?utf-8?B?S1BCMy9SaVJRSEo3M1JqNkZxVU1RaXd4Q1pjMXRvQ2doYTFLWlFQcGZiMjlu?=
 =?utf-8?B?YU9xbXRudGFPOEdrMVczTVVjRm9oVVIvZHpYU0ZyMk5vVCtaSmlFd2IvN3Rr?=
 =?utf-8?B?elNMbmU4YVZhQ0ZBU1F2OVBjdytTMWJ5M2xOajRpTHFZbnV2bnlxWnNnZDZz?=
 =?utf-8?B?ZG1meS9NQkthTUlyUVNqM20vRnB1ODBsN2QyTEIrYWFreDBXQVlpN3dtN3Rz?=
 =?utf-8?B?cHlMTWozSlczY2I3OHdaVWJTYzBEZGc3emFoQlFtT0JlVlhRRkZZOTgvYWVK?=
 =?utf-8?B?Yi8rRU1Kck5obVFMR1lsRndWRllTUGs3ZHRob0lDTVVHUjhIK1JVVndwcXVa?=
 =?utf-8?B?aFY0eHpvcUFJM0xua1lHQjc3ZUV0dGh1aXIzbmlDZ3g2bW81WVMxQ1llK3Iz?=
 =?utf-8?B?dXA5b085YXpkNldFenR2ZDI1OTBoZnZ6bnhPTGtGOGg4RnF2QzBISDUyaFd1?=
 =?utf-8?Q?dc/vJMaYQlrS2Jy0WYtEMKk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a289548-e5ef-4487-627f-08dd49fefa61
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:16:02.9088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuDxyzHY0UU80yuP5pTe9shs7wSsjhe3W9B1OZa4l/ToKbpb5hLP7q54qxGOZaZ61oAUnI6h9/VvrpburDFlC3fuoU7c710S+ZebCPmI+X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7278
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

Hi Arnaud,

On 2/10/25 4:30 PM, Arnaud Patard wrote:
> [You don't often get email from arnaud.patard@collabora.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> For SPL DFU booting, define u-boot,spl-boot-order and
> configure usb nodes for enabling the gadget in SPL.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
> ---
>   arch/arm/dts/rk3399-roc-pc-u-boot.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> index 883d399a06a..e1502f30039 100644
> --- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
> @@ -11,6 +11,10 @@
>                  sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
>          };
> 
> +        chosen {
> +                u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
> +        };
> +

This is already the default for all RK3399 boards, c.f.

arch/arm/dts/rk3399-u-boot.dtsi

>          vcc_hub_en: vcc_hub_en-regulator {
>                  compatible = "regulator-fixed";
>                  enable-active-high;
> @@ -75,3 +79,22 @@
>          regulator-min-microvolt = <430000>;
>          regulator-init-microvolt = <950000>;
>   };
> +
> +&u2phy0 {
> +       bootph-all;
> +        status = "okay";
> +
> +        u2phy0_otg: otg-port {
> +               bootph-all;
> +                status = "okay";
> +        };
> +};
> +&usbdrd3_0 {
> +       bootph-all;
> +        status = "okay";
> +};
> +
> +&usbdrd_dwc3_0 {
> +       bootph-all;
> +        status = "okay";
> +};

For all the above, status = "okay" is already the default, it comes from 
dts/upstream/src/arm64/rockchip/rk3399-roc-pc.dtsi I believe since 
OF_UPSTREAM symbol is enabled (implied) by default.

u2phy0_otg label already exists, so you don't need to define it inside 
u2phy0, you can simply do:

&u2phy0_otg {
     bootph-all;
};

Although... I'm not entirely sure this is appropriate. I think you 
should rather have bootph-pre-ram instead, which is for the SPL. 
Finally, if I'm not mistaken every parent of a node with bootph- 
property is interpreted as having that property as well (but it is NOT 
written to their node), so you wouldn't need &u2phy0 nor &usbdrd3_0.

Cheers,
Quentin
