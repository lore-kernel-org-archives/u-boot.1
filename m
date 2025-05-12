Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545DC3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 09:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2E2805D7;
	Mon, 12 May 2025 11:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dvd/bzX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0242E8091A; Mon, 12 May 2025 11:03:29 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE3F80050
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 11:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEjlN8I6ITLDjxJHR8uS2sw1fuGk/eBoz6P4YxoB2TrOEKLB86/j/TEiEkzz7kdmDjA3alZTVY669u/dUMf9RpQxlpr4wkJyGtJDwtL1f73HuH7WItuiIKHvFtN+oOBUYfGlsrODoXyRi8mUUT5kG5BOZ0SiD02xiHJRQCTWAV3s8FkTVOOeMuP+gzsdpWXmAe+r9DjlDRFAvtz36xomYlbGD4a6iU12Y+pr9Nd4N/DqfS7sbuc+6MxYqgonYEhcopzYPIXlSlrPKH5KDfrPu2vD/RjuSZw/5kCowd7V4+mtdT7dclVCabotzH1lHcDm01Q1+rUkbO2lkmE0Z2dCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmR6D08GefEGMw+dwA9jTnz9IIeShV5z7qrk+yYXk2s=;
 b=hMZNx9s0GFue2ytlYR9T3ZBGZCFnE29obxMmT8FN+B1rQUJL/BP5iAl+bYwjTPlG5tYWiFhrk0VKDcqo1avtO3CXhGAIGM8CtO0kK73lOdOjeuQKt1Q7bsDhUfF9b0NiyGE8Mu/nAkjSmepje5MTZv8dY1GtoRtRfXJ/xZlsvVWgmyRaexPguLybyIslgFObZYhK0aDHdf059tyDrVlI0f4fHgY9u92f5PbnXS6CQ3UCRAf6wv0rn6MafOZvHp3uQeiUCXzTt1xEvTKaqdVnRqMewTAyaxqAOZkyo4/CYUW14sgHdXj106CVz0J5z8IiJ6pLRhnzxgdbGwp1xhiw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmR6D08GefEGMw+dwA9jTnz9IIeShV5z7qrk+yYXk2s=;
 b=dvd/bzX55g0c96XOScRRZcJ95y3xyAexQNZyN2AUvOOFDJCZJdB7aEVy4tk4rL2hkw3hGVIu2c322i7MhVAMORtYJ5H/T5ZYtRBaMxStFB5tP6jEIqaVipUHyEskSctKn+56BdGRpfQfrq3bICQsIhgdbEp4JA1vqSWljj77YCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7664.eurprd04.prod.outlook.com (2603:10a6:102:f1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:03:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 09:03:23 +0000
Message-ID: <3f0c1dfb-5c28-4160-9a8f-f49ad380bb50@cherry.de>
Date: Mon, 12 May 2025 11:03:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: document test command
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250506205439.415877-1-ravi@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250506205439.415877-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 90da74ea-575e-4eaf-30cf-08dd9133d988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wi9GMzFaUU44eGZhWHdZK3lldXh0eXVsRXlCdnNLakQza2RvVHVmUGsyMi80?=
 =?utf-8?B?U2Vsb3oydFhaMFBGM1hmb05WT3M3cEhRMStoRkNWQlYwK0x6L0hlRURyV3Ez?=
 =?utf-8?B?YUdrQ29kMVpsTitjR0hGTXVkOWV3V1Zsa2J6MHRpYmo0S29PTEFMY1haeWI2?=
 =?utf-8?B?RUxFNVduN3dsZzZncjBqMXFOZ3dsNjV2TWpZdGtUaDVRTktXV0RubUtXY2dx?=
 =?utf-8?B?SUdpdm1vdTNSTzA0S0phNzJSY2MxemliZHpNRTU3ejI1NE8rUjdjN2c3RzFQ?=
 =?utf-8?B?YXZYUW1IUEsyNjJaYjR0Z2xJMUt4ekh5NkFaVWxaWmhRYWh2MVZETHNUanNv?=
 =?utf-8?B?a3ByQ2tpOGZ4UWZOdVlPWTBuRjljVzhVOVlwZ0F0SlppTis2U00yc3B6MEJC?=
 =?utf-8?B?TVlnWkk1aEgzc05IcVJwaTJTVEVNMS9zZWMvZFQ0ZC92U0lKQWZFdFZUdVk5?=
 =?utf-8?B?djl0Y2ZtdWVXQ2RMVHFZUXhibGdHZnFrWFBITEZVanVQT1dYZkVPUFpYeWhD?=
 =?utf-8?B?SzFldEJDWDdqQzN4dDFUUXV2Z0xMRFRvOXhieHBWY0hwcHVxUStaYStPcXhW?=
 =?utf-8?B?L0ZjQ3FZZGhCMzgvOU9KalduWEJZNnhPY29mZTljQzJSUFphcmQ5c3ZnSmRr?=
 =?utf-8?B?cU8rWG0yK1E4VXFVek00VGt3SGlhbjJlRThUcm9qSUt2Y1JRN0RpaFBtOVll?=
 =?utf-8?B?WFZES0tGdFBXWGJnNkkzcWE2QkRzaHI5eE1HSlJWUUNXcFBKdGpuVFNIU3FV?=
 =?utf-8?B?VGlOendpa2h6MTZ6dDRlaUR4eEx2ZFBKQzVaVVZlOTQ2YThuZmZsemRGWkNX?=
 =?utf-8?B?WGtLQy9NM2I2c08xSVZ3c1ZRTVBzQnFJTXppSExpcGlHb0hQeE1JaXJZVUh2?=
 =?utf-8?B?eTFqTHdoY0FSRjh0YVg5TlRlNnhpTmFiVXVEZzBhK3drV1BMb3hQNkF2aUw1?=
 =?utf-8?B?RHZUVFJ3NjdoTXVSUTdPRmJ6eGFINTVoNHc2bExMWUdORGlzTnVHVlpoeU1k?=
 =?utf-8?B?Vm9MOUsyYmlPeVowcm0rVVlQOFZBUkxPMG0ydHRHb3lmWEhxQTFiNFdyYWh1?=
 =?utf-8?B?TGxiZWF1VXhkM0pWakEwUG1QME04b2RoZGRtVmdhL0VBdTJFbm11MjYrKzdN?=
 =?utf-8?B?SVpzV05sVkcvdnp6REZtcTQwLzNmSGM5SmhjOCtDUVNlWjhmbjdtWjJuS3RE?=
 =?utf-8?B?My9QdXVXY01yQm1ObTViZnIwdGRuLytJcUVsMXlTNzgzRGM2Nk9MTThydVAv?=
 =?utf-8?B?VWo1T0JwUEtpMnRpaFpTdE0yTldEdVhqTEVMbGpLaHBWMXU2aElPWXZuUUs1?=
 =?utf-8?B?S1hnakNYL1Z5QjJqMWh5L0duVi8wZzRhcDdrN1IyL05mdzFDc2dzekx1RjFx?=
 =?utf-8?B?Q1A1dU9YaUZWWWczOUNCbDdqVXZ6RmtGdFE0TDczcVA2YnRmQ0IvQ1M3d3B3?=
 =?utf-8?B?VmVWZjBVNFFKd1VHQ0I2UW1CcDU5dDJaamxWTWh3Y2h2SmdDUjJmanRXQlNR?=
 =?utf-8?B?R2daTnVRNGU1OVNPZE54VW5JdzdwNTIrbUFLK21EaGJhTjZubGF3dUZSN0Ez?=
 =?utf-8?B?L2dJR0xvSWhCM2JkT0prekpBMldOdUdiTDJvSnkzS2NqU01EL05pYkNDVG9h?=
 =?utf-8?B?WldtVC9rYlJhaytnNTkrVTU4aUp0Mm9RUDhYUHcvT3Z5NXlXVmdaM1lNTE5o?=
 =?utf-8?B?KzZkM1ArVmxTYkl2RzBUVkliUDBBMXV6SnFzSGpnWkV5bFVZcXVIc3UvVUN4?=
 =?utf-8?B?WEZZZlZzeXdzQWZ4cm5QY1hoemppM2N3MVozcjVjZGk0MzJGcEtkR21IL3l4?=
 =?utf-8?B?ZmxiZFRncmdNSGtuUTlYMnEwNFdmK0o3NjFhRjBCRStreXRqeVlnMDFLNnk2?=
 =?utf-8?B?US9NTnVBTzQvV0FPV1Q1ZURBeFhJejFPbVY3NWdCdmdTTmNUNW5FMG9aWHNC?=
 =?utf-8?Q?RzOyDcKbVUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRsUUJUcTlReU9yS0dGZVJZS0xiYzJxMUpKdnhmYitWUXRyMUh3WWJta1F0?=
 =?utf-8?B?TVgrMmJsRndrS1NaVkxFQ281enZPaSt4TU0wczJWQnNEdnp6ZUZnMFNJenQ5?=
 =?utf-8?B?cUIyb21ibFFCaGcwK01idTRrYldJeWJ6dlBFamJ2RVRxWklSMFFNSE5hUmFD?=
 =?utf-8?B?VmRxclpzYWluNVhFVVFMMCtQL1J4VWE5dzNwYlhQcW9XR1k4YlljVFl2SVNU?=
 =?utf-8?B?cExjVldQZEZlVHlmTGpvNFhQOFAwOGNuM0xIQnlNL2hzcG5sKzE0TjE5WGdk?=
 =?utf-8?B?U1QzQzlOVWV5R2IxVS9HUm9HQ2hzMnBwS0dyT3ZXT1hidXYydnFoY3lGN0dJ?=
 =?utf-8?B?YU9YNi9ubVIxQzcvNXRGdWswN04zUFRMRVhJN21HNW5mc3F6Z3l5azRpN2N2?=
 =?utf-8?B?WkFpNjdDUDA4S0JZOW5lQ24vZDR0ZlpMMlBva1VwZXVQN2l4TldKbDZkV2lC?=
 =?utf-8?B?TXBnY1hhcTIza2p5ajZ2OHhva3JpbXEwWjk1Y01taXNvTTZteEZqN1Nwcmpu?=
 =?utf-8?B?MjdJVFlkd3VNRDI4M1hxS0IyNFBVaHlZZnBZR1NKbzI2LzVSRmR5YVpzckhx?=
 =?utf-8?B?ckNwdjArMjgvVlNvS3dUN1JhK3kzakd0ejhpWG9FR1VGQTJJZE5adTBtcVlk?=
 =?utf-8?B?VlI0cllxTGRyaWFoK1FwbWlaVTVmUXZLeVppK2JXeWdUVEF2U0NmczhodW0w?=
 =?utf-8?B?TnJpNlAwK0tOMkFINkhmdGtCRmZRWDZIS2dvS1ROUS8yNFYzckRpSE8yZ0ZP?=
 =?utf-8?B?akVMV2dlcExsRzJrMUtoUFBuY2pPTFNFd1FuMGQ2TFpEZlEzRUxuajdDMTN5?=
 =?utf-8?B?bWV4TnVNQkpSM3hjaWVmQ3pEM2Z5dXlUT1p0dFl4VmFqbXBzVUs5Y1hmby9Z?=
 =?utf-8?B?L3ZReUo4NU1wUUJkWmNhZy9nZFlrcnhTR3VNY3JxdHZEbnh0MzlzbmdLN2py?=
 =?utf-8?B?Uy9LMWdwRloxTkxjWVdLN3JkOG9ORGVuTjdtbkZjSHFLUGtza3NMdkxUd21o?=
 =?utf-8?B?S3JCMmhQTkVEeVZpbm1XU1BXZTFJTjJHYjdkcSt6NGRtRnUyYml4TXlRZy9W?=
 =?utf-8?B?VGNzN1puamxWdlVvdWM2eHRHU01Gd2ZHZVBCZGM2bmc2RHBubkEvbUtsUXd4?=
 =?utf-8?B?UVN5enB1emhCQndrRGZjTUIxcldMQ21aRldST3VMeVhSWHN3N2J0eEgwMlBF?=
 =?utf-8?B?V21Zb3hyRzc4d1JxN3lYL3NHRjNmWFliajdxZ1pqL3ZXMk8yU04wQ1lGTUxv?=
 =?utf-8?B?ZlE1VHRpK0V1Rnc4Z00xaTErZHJrdG1oZzN6Ri9TbVFtaXN5em5mQnBRdXFh?=
 =?utf-8?B?S2U0bkNiSDFvaU14UEJkV1hoLzhCQVlZejFYU0xmRU5lZGdoMFRSWmRzeFhY?=
 =?utf-8?B?SWxaZGFWQUdiY2huNCs4cWRBcGk3SkYvcjVqOC8rdGVKS3FJNEVJaHhQaGZy?=
 =?utf-8?B?UUd6SUVmQndYdDBxdE5CdklYbTJuV01naklkeThCdkpIQSsrZmVvUS9Fdk4w?=
 =?utf-8?B?VDhBM2R3WHV4c1orQ1lnU0xmZG5iQ1lqNXZSRlMvdXdwbGpubW81a2xBVHpG?=
 =?utf-8?B?TGsvRUR4Z2FjQWIwd0Y3dHlWaFBpeHdhTHpuMHFEcUU5ZnVFTHU5WVVDQVla?=
 =?utf-8?B?OTdUZ0w3aFBrSGVMcSt1T1haemM4aDRPQ1NZQXZLUFZGSDJyTHAxYm95Tlc3?=
 =?utf-8?B?L05IQSs5S09yb2xiYnpoWlFHZlFOZXZnYUlJbWxNRmltMFEwZ0hKZVRadHUv?=
 =?utf-8?B?NzJxSTFQdHp4V3FyMjhiSjhGQ2txTXBGWndsclN5T3A1eHhsb2VvY2dhY1hs?=
 =?utf-8?B?SE1KallZUWpKU3FzMmVrdWlBTWQxREwzaFNILzZ6cnVWeHhoY0V0UWl5VW14?=
 =?utf-8?B?K3B3ay81YzV5aUFQQkJCYUxQWGlZN1hDZWN3Z1BaVGg4VDluRlVQV1BKc2wx?=
 =?utf-8?B?TjQzUkFWeXliUHhaQ01KbnFUSW1qTVRiZFRZTlFhaGJHcmFTcjJlOXFScFYv?=
 =?utf-8?B?aloyeGpXVloyeEV0eVZoY3FhWVdnL3d5Mldsalh6cDFQak5GS1BudGt4ME00?=
 =?utf-8?B?b2hNemQ0eDBaNTZaWk5QbFN5TWhsdzhWcnd3djcwMDRQd090NnZkSWR2YkxN?=
 =?utf-8?B?T2dBbzZhSWpRL21yWU5Ya0t6cVhiZXoxRm5VenZBK1ZhQ2QxakZxMVZDYm4x?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 90da74ea-575e-4eaf-30cf-08dd9133d988
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:03:23.6552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwJA3joo+0hAW1JkSvxX8+HEHc4/ST7JctVekRZSgSFN+RSttr3QB41GrJX7Ukq7hisk3fczYlVuQ5vESAEP61t9WaZ8G6gKDD+sF68CM+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7664
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

Hi Rasmus,

On 5/6/25 10:54 PM, Rasmus Villemoes wrote:
> Add documentation for the test command, including the newly added =~
> operator and some gotchas wrt. the numeric comparisons.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
> 
> This should be considered on top of
> https://lore.kernel.org/u-boot/20250506141035.385756-1-ravi@prevas.dk/
> , but everything other than the regex-related stuff could stand on its
> own.
> 
> My rst-fu is quite weak.
> 
>   doc/usage/cmd/setexpr.rst |  5 ++-
>   doc/usage/cmd/test.rst    | 95 +++++++++++++++++++++++++++++++++++++++
>   doc/usage/index.rst       |  1 +
>   3 files changed, 99 insertions(+), 2 deletions(-)
>   create mode 100644 doc/usage/cmd/test.rst
> 
> diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
> index 593a0ea91e1..5bc37ae50fc 100644
> --- a/doc/usage/cmd/setexpr.rst
> +++ b/doc/usage/cmd/setexpr.rst
> @@ -144,8 +144,9 @@ Configuration
>   
>   * The *setexpr* command is only available if CMD_SETEXPR=y.
>   * The *setexpr fmt* sub-command is only available if CMD_SETEXPR_FMT=y.
> -* The *setexpr gsub* and *setexpr sub* sub-commands are only available if
> -  CONFIG_REGEX=y.
> +* The *setexpr gsub* and *setexpr sub* sub-commands are only available
> +  if CONFIG_REGEX=y. For an overview of the supported regex syntax,
> +  see :doc:`test`.
>   
>   Return value
>   ------------
> diff --git a/doc/usage/cmd/test.rst b/doc/usage/cmd/test.rst
> new file mode 100644
> index 00000000000..74ee4173639
> --- /dev/null
> +++ b/doc/usage/cmd/test.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.. index::
> +   single: test (command)
> +
> +test command
> +============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    test <str-op> <s>
> +    test <s1> <str-cmp> <s2>
> +    test <n1> <num-cmp> <n2>
> +    test ! <expr>
> +    test <expr1> -o <expr2>
> +    test <expr1> -a <expr2>
> +    test -e <interface> <dev[:part]> <path>
> +    test <s> =~ <re>
> +
> +Description
> +-----------
> +
> +The ``test`` command is similar to the ordinary shell built-in by the
> +same name. Unlike in ordinary shells, it cannot be spelled ``[``.
> +
> +Strings
> +~~~~~~~
> +
> +The string tests ``-n`` and ``-z``, and string comparison operators
> +``=``, ``!=``, ``<`` and ``>``, work exactly as in ordinary shells.
> +
> +Numbers
> +~~~~~~~
> +
> +The number comparison operators ``-lt``, ``-le``, ``-gt``, ``-gt``,
> +``-eq`` and ``-ne`` work as in ordinary shells.
> +
> +*Note*, however, that the numbers are parsed with ``simple_strtol(,

Maybe use an admonition here?

Something like

.. note:: Numbers are parsed with ``simple_strtol(,0)`` ...

so it's (hopefully) properly highlighted?

> +0)``, meaning that they are treated as decimal unless there is a 0x

``0x`` ?

> +prefix, any errors in parsing are ignored, and parsing stops as soon
> +as a non-digit (for the selected base) is encountered. And most U-Boot
> +commands that generate "numeric" environment variables store them as
> +hexadecimal *without* a 0x prefix.
> +

``0x`` ?

> +For example, this is not a correct way of testing whether a given file
> +has a size less then 4KiB::
> +

s/then/than/

> +  # Assuming readme.txt exists, sets 'filesize' environment variable
> +  $ size mmc 0:1 readme.txt
> +  $ if test "$filesize" -lt 4096 ; then ...
> +
> +If the file size is actually 8000 (decimal), its hexadecimal
> +representation, and thus the value of ``$filesize``, is ``1f40``, so
> +the comparison that is done ends up being "1 < 4096".
> +

All nicely explained! Can you provide an example on how to do this 
properly though?

I assume something like:

if test "0x$filesize" -lt 4096 ; then ...

maybe?

> +Logic
> +~~~~~
> +
> +The ``!`` operator negates the sense of the test of the expression
> +``<expr>``. The ``-o`` and ``-a`` operators perform logical or and

logical OR and logical AND (and maybe even highlight them with backticks 
like ``OR``?) to make them stand out of the sentence since those are 
typical English words it may make it harder to parse the sentence if 
left looking like all other words?

> +logical and, respectively, of the two expressions.
> +

I would have the second sentence on a newline (with a blank link between 
the first and second sentence so that they make separate paragraphs in rST).

> +File existence
> +~~~~~~~~~~~~~~
> +
> +Like ordinary shells, the ``-e`` operator can be used to test for
> +existence of a file. However, the U-Boot version takes three
> +arguments: The interface and device number (possibly including a
> +partition specification), in addition to the usual path.
> +

This could be a list, e.g.:

arguments:

- the interface (e.g. `mmc`)
- the device number (possibly including a partition specification)
- the typical path to the file

> +Regular expressions
> +~~~~~~~~~~~~~~~~~~~
> +
> +When ``CONFIG_REGEX`` is enabled, an additional operator ``=~`` is
> +available. This is similar to the same operator available with bash's
> +extended test command ``[[ ]]``. The left operand is a string which is
> +matched against the regular expression described by the right operand.
> +
> +The regular expression engine supports these features:
> +
> +- Anchoring ``^`` and ``$``, matching at the beginning/end of the
> +  string.
> +- Matching any single character (including whitespace) using ``.``.
> +- Character classes ``[ ]``, including ranges ``[0-9]`` and negation
> +  ``[^ /.]``.
> +- Grouping ``( )``.
> +- Alternation ``|``.
> +- Postfix qualifiers ``*``, ``+`` and ``?`` and their non-greedy
> +  variants ``*?``, ``+?`` and ``??``
> +
> +For extracting the parts matching a capture group and/or performing
> +substitutions, including back references, see :doc:`setexpr`.

Question: Should we provide an example use case for each test subcommand?

Looking good otherwise!
Cheers,
Quentin
