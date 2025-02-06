Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A80C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 13:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92FD280A09;
	Thu,  6 Feb 2025 14:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LWdnc1tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA81A80A29; Thu,  6 Feb 2025 14:16:39 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE468809A5
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 14:16:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO3YbU0/cmQ0Ifw1IybdScRn+CbgWV6rlTTctiAjVVBpVLKTBK7s2usowhlZVXhMa5/VN9oaMRoPDhgP+5QZ9oF74YUHD0OjdvZfXzl5M9OLUCLjOngAkSbtImSs9YmhxUyGpU0xYxTRk+DV5kJryzXAJCzvVRuut0UuX+QEmYI75RX2R7vp+HJfC8/5y50BXroEaZhWmrxZ7yARXnlPYgFluF9QfKI0nBzCvBiY0WfPE4vOUBph9nrMELmxouuVmNqm3u6IPJKir4j9/B3X8ttCEoLKWKUY44P/L3FlF3QUHFsWk9ZIaabw4yox0DRgB4MmxL4tAZJVkfVKbAvWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFYFJ0pITToliqTgOLV9eI8l8ksMtRTiArl0oCnJA/g=;
 b=yCjI+RxDAQhF7uvmeH3K6vJQwGZ6N0iK39ZT/p7Mrqd9/Oz+kqJ41UMK4w68TMJmQwSupS6qKSTUDbcWF0DplQQXE7mShczHKt8m25dx6QWEyl0+mNJi8uW41+isMJuQm2+p0J0C6rNOnBuCZUER5F8ajW4fO9k5qzQ2KcGGm0+ep5Qs/95Io0MahG6/h7OtDbWjoJuQdHHYrw3kZ3GCSMDvlRB9mT7yJklbqUGfmbKGgEPU/PqnjEFxF26UeLxhA3NtJZIUhI5IhwpL5vvphyo19+yZx+50JJEHTW+IYiTFMS//rI6ZNrgDJZZhGf0ytl9YLzkDYie/UjOdpIfb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFYFJ0pITToliqTgOLV9eI8l8ksMtRTiArl0oCnJA/g=;
 b=LWdnc1txhOCW8pdNYXRz/JQ5TVw5bhKM2TueMDm13S31ms8tZXUTlDcV37h4ia6rKSeBscIegu7VF2Se7HQoYfqmzmqpRV/4DmORc72USrn/q4sxtTyUwkwB3kaZhjvihq74U4CZfFxGkW6YpRrOnuFu6sQkZO7OBCOzIBXvS38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9706.eurprd04.prod.outlook.com (2603:10a6:102:24c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:16:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 13:16:34 +0000
Message-ID: <ee3c12a9-ddb6-4a76-9e5d-5491942d8c79@cherry.de>
Date: Thu, 6 Feb 2025 14:16:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] rockchip: io-domain: Add debug logging for
 regulators during probe
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250205171634.826560-1-justin@tidylabs.net>
 <20250205171634.826560-2-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250205171634.826560-2-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::38) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bad07ef-5a25-4d73-1454-08dd46b07aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWljUmIzS0RySW0vclQyVDh1V2N2Z0xQQVpQbmpUa3ByQlUzSDhsUTd1aHlj?=
 =?utf-8?B?NnJ4aTFJYWdmWXFZbzNNUFdEekNQZjF5MSszK0pybGFBd1Q5UjR3MmlISFVD?=
 =?utf-8?B?bThQdUVxSC9QeGpycVBEMWxKYWZnYlhCbUJvOHpnYThtSEJxZlVndUZZTU5x?=
 =?utf-8?B?eUN1aWp2UmRuakR0ZG53aGFNbmdveFBpQVNsRDRjc1EyOTdBVTluUU5Odmww?=
 =?utf-8?B?UlhWYzIyaE0zSks2QUlvNlBnM1NJQlBmZ0FMQ2hQV2tZNHdHNTdOcFBVMkpi?=
 =?utf-8?B?S2JPdTVUejZOQXBHSzlaY29lT0hxS3Z1bXFwQzlTY3dVajJKOHZJUWxPTW1N?=
 =?utf-8?B?dmg0VzYvQmttWG9hTUdHNHh6djliclU0d1ppWDIrWlZOZkx4T1cyejZ2emt6?=
 =?utf-8?B?QSt1VkpONWpia0VoY0oveHRpdnBoNEZJWXdMNmtQQnR1Y2NBb21RdG0zTUJN?=
 =?utf-8?B?ekFvbG9HUDJwaUlsSTJmdTVUeEpzYTNOV3FSd1Z6dk5xY2ZSZ1VPR2JVRm9Z?=
 =?utf-8?B?UVJoZ0hEcEFjR29rc21xR1Q5M2t5dHZzZUdaakxPYkRtRUZleXBOeW1GNVd1?=
 =?utf-8?B?RjhmaDhzL3phd3FmSXdOZWdSMnVTRFpnanU2a0xZSnBsUTkzVktrY1I4ZElC?=
 =?utf-8?B?S0F6THR4Yk1kQ0Vuc1BwWnl3M2Z3SGh1NXVpUjAxYk5weUYzVUxaZU1BYTVK?=
 =?utf-8?B?V01rd05CbEI1L2RvZlh3b2k3bldZVlZocThxckNtc0ZDbTd0Yk5INjhGN3ZR?=
 =?utf-8?B?QW5RYWJuSExGVFdLUGlVUnovUnl0V2pBL2cyeHd4ZHNkb3g1d2xYRDMwRkdS?=
 =?utf-8?B?QTZBNCtPK2RRSFZBTEpzeTlzYW1wUG9ZZTVOUjBiL0RaMnJHMEgyd1YreDZX?=
 =?utf-8?B?RWlZOXNmRnFRRWNzZC85NSt4bnhRZk5sa21zREt1LzRGbjZPRjdiYnhvY2p2?=
 =?utf-8?B?UmZPQ3B5UlBVeUpFWEZkVDh4OVlSZE1VNGpEMlNLVmVicis0RmdjaHQwQ1VG?=
 =?utf-8?B?RmZ5WElaUm9TaDNEMnBKYzRpT1ZPUTZHTHB2TDVhSStYcHhCamZNQVMvRk1G?=
 =?utf-8?B?YU0xLzl4Q0lSK3FkNm9rQXIrQXFJSi8rNTBpcmcxZFQxayt1RVU4Y3Rpc044?=
 =?utf-8?B?cEl2SWdob3o1UzhnRnhhNytJcUlDbWM5SUErKzlyVmMvNGxremhoL3lzNU4v?=
 =?utf-8?B?Tkx2NVg5aFdEdEtrdFZMUlhlZlUvcFNUM1FsV0VnemNVdC9ZREhPU25VT0w3?=
 =?utf-8?B?UWFoM3FQdzU5NlBuZjNvbTJtd0Vjc2I2NHFrNUVuUmtVT0FGai90RXlid0Ur?=
 =?utf-8?B?NktoNVRyOGoyazVpWUQrbGZGMzY2MEJ1R05PcXlFbDJjdko4alNCOTlaS044?=
 =?utf-8?B?QXlZbjVETHMrUis2bTZWbzJxa3hJZnVhSTVyNWNTYmJQOHBGTm01ZTQySklk?=
 =?utf-8?B?TWxockFUZ0I5NnR3a2ViUVFXQmt3T2hCbTd6WXMyaHN0dUZVVDlUU0trMGlC?=
 =?utf-8?B?MTNTSDhiVVlqY3ZVOTNZSUc2RG5rMERjaVNXVm1scEZXb2lnOHp0Wmx0eHIy?=
 =?utf-8?B?Y09oVytHUS9YelNiY2RYamVXL2tKNG1LNmxvSVlnV2pOSmxKVHVJcTR3aDJZ?=
 =?utf-8?B?NHMvaE9xYmlCYnVkYVVCVUxtL3JCVHhMNnBqOUJOeFBSSE9QY25SeXVOVThN?=
 =?utf-8?B?Q0xWeXdmakJ3RFF0QVpPTjRzNTQyd2FkdUNnaktLWjdXdm85aWtXUUwrUEJZ?=
 =?utf-8?B?Q2R4WER1U3lYQ1ZneUZua1lMOHAyK2RmWWFCTG1oYkY3ZWVIcEViYTdjVnpm?=
 =?utf-8?B?TTF1QWhQOXdSSnRoUXUzNWFNWHFhRFdkTU9tVEIwZmlMOVU2Ynl1RDJteU14?=
 =?utf-8?Q?VmojHRWbEPoht?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUhpVldNMTA4NGk0aVQ3SS93ZDZVM0ZySEllbmtpQTVJa1JMcGUzU21LQXQz?=
 =?utf-8?B?Y1ROTUhJTTFmdFpTOXpnOTFKZWxyNWQxcTEzMGxmZFYxSUlhcDlidzZYSUlU?=
 =?utf-8?B?WnJIc0tyd2FsODVKby9zRFZGZ1NpeWdTMXJJZSsxNmdKd0xGcWJPL3NZclJv?=
 =?utf-8?B?YlB0OUFid0hWT21RWlFhS2c0eG82UURoRzdRNXNjaDlyWWJBdTlMbWNlMlNB?=
 =?utf-8?B?ZGdaTVVNZCtQMjJLMGp1MmlMWDZYN2hsaGFJb3pUWVlxWVR6S2l2Q3Z0UjJO?=
 =?utf-8?B?Rmp5YWtwUGFwODNncWpXZ1kyUGRuYmQ0cW13dlFnam50Y2Z5M1M4aFFaZnZJ?=
 =?utf-8?B?cU4wQTJpZWJjNklqaDBZYzNPYVliZ2hHM1BUano4R2VYZU9FMExWZEhGdmdO?=
 =?utf-8?B?eHl6ZVkvMVVUUW5EVHR6QkdDMGNQSWo0YXlUdjJ5L1FxSjdpVDdEejA1YjVl?=
 =?utf-8?B?cC9ZNUhCWmhHQVBTNEthOURIeElBTE5PTUQyN2R4cnVvRjNBV0hKMSt6cE9R?=
 =?utf-8?B?WFlKTTJKdThTeEtjcU84S242a2tzbjMveG11Ui92SjhEd2d0elhyU3RBVm5Y?=
 =?utf-8?B?ajRvaXF6Z0o2MlhkMWhBVUNNZ3NWUzRLdTVldzAwb1pjK2Y1d2VtRlVPOHJt?=
 =?utf-8?B?QWFiVzBvUTMzc3NxQmV1aEdOYzFOdHRnNjNDSFV3enBncUNBSFhKeUFVdHBQ?=
 =?utf-8?B?R0xUTUIxQ0Z2OFZucGsrY3FveGZ6RHUvWitTRXVsaVJZKzFrWHpwdVVVRnVu?=
 =?utf-8?B?RUVpMlN6a3o0TWJPdGN4RDNDQitOVUlSM2MvT1Rrbm5wVFNsNk1oa3dDUUp1?=
 =?utf-8?B?MllXNDBYTmNzWm1hemMxNHM4VXM3bVE2UjZNVDFBVWdRRTR0MWJvUUlXR1Vw?=
 =?utf-8?B?UU52TjFpMmw4K1hGRDFVbGdNT1IwOGtQOGdPamNhQU5Sd05pU0lCRHlTZ0xB?=
 =?utf-8?B?TTA5dHNkamRJSG9yYjhiOHFBN1h1TzNjZXJtOHZCQndjSU5xMi95M2tQa0xI?=
 =?utf-8?B?YjVqRzRNYUpabHdiZVlndStldW54OWZOamxobU15OUtQaDgyYkJOdzNuTTVB?=
 =?utf-8?B?bk8wdTEvdEFhRG9OZnNvTkRxRlNoNnAwaWdpQ04rNmlONUlVK3NoS3JldHFB?=
 =?utf-8?B?K2xTREttMDVzNi9kSkd5NTI3alNmVCtaYU5Lcm02dm1ac2xVeW9RMVFXcmhF?=
 =?utf-8?B?aEVhNy9DbFdZTys0Mzd6UHZzWStSVHRrWlFsQ1QzdE1pTFFJQVdQK1pSck9X?=
 =?utf-8?B?cit0MzFXMTNjOVhwZGJtMDlyR282OUwzZllGSjdwUG0rSDRVeDZUSzViNFBa?=
 =?utf-8?B?MnlWVzJvMmpQRUU3M3VhRFo5cCs5SDR5TDIxM0k2UmJFc214UTRnSmpWVVdr?=
 =?utf-8?B?cTJMWmlNWk9ZeW5Wa0RQc1AvN2hrcG1lQ2dHTlZOTEE3UmFDRWNCdkpwcVBv?=
 =?utf-8?B?YnZRVDlQTlRGcVlkeVU0eUp1U1NaaDRqcGxMQkdDM1NKZ0F2Y1ArSWpJcWk4?=
 =?utf-8?B?bVZwQi9SVE1ZQmFxMWh2Mkx6NC91RGk1MjZmaFRlSmZldjVtOFo3bnhZOUJo?=
 =?utf-8?B?Ry9kb2JqOURVTlJZcE8zYnVwaVNjS3ZZM21iVVY3TUoyMmM0YzFmMys0V3hP?=
 =?utf-8?B?ZkhodXZzV2MvNytXRHZuaElneGVBdjJMenZJT01Wd1RtelVFaStmd29DSjIz?=
 =?utf-8?B?Z09HWkgrUEVpb2xKczRDUHVmRCtRTXY4VWs2YVp4cWVUY0N4RzFuTkxtdnkr?=
 =?utf-8?B?WHRtZjhpYVk3SmQ0RUFxQkgvWTlpVGJML3k4c1FlVHFrU1FQeXQ2SWFxNHhv?=
 =?utf-8?B?UWhEeVJGaXppcGIyaUNtMDh3WU9mMzNoSlVkYy9IUS92T3hJK0plQm9rckFR?=
 =?utf-8?B?WCtNZjRNeWlPa0lpQnVZRFpLdzFUeVdJL2hRM3RJN1hWV3JHK0s0L2pZQWdw?=
 =?utf-8?B?QmY3bmh4RjVwdzVZUTN2cks5anE3aU0wd3BzdzVlSmlGckg4cThCWlQ2VFlZ?=
 =?utf-8?B?VExIZDdiZlVIbmptYldQbnkwU2JUS29laGM4K0ZCRndldnd0MW9UejAvN21j?=
 =?utf-8?B?MzRkeEVVd2tsczVOMTV0bGlvZzFxNFN6VWE0RU1kcmtZQkEybUN6TXdyYVVM?=
 =?utf-8?B?cy9TTWZtcEM2MzhncHd3NmNDNlg1bUdIamdWd0ZOY0tHN0tLdjN2Rk56SFNr?=
 =?utf-8?Q?4UK9SyHEyGKQdwKDNlUZueA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bad07ef-5a25-4d73-1454-08dd46b07aad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:16:34.4794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3OH3BsmsVd5vDZZ/Z/yonDFQlzGhWE2IZ5/8prtmNjkaORYoxFxgolepwbKtyvs5qt0bIsDW2ujnO6G0hZBW5+BO0ChQaRtYy+DDNTy5hvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9706
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

Hi Justin,

On 2/5/25 6:16 PM, Justin Klaassen wrote:
> Log the value of the regulators during initialization of the IO-domain
> driver to aid in debugging GPIO voltage configuration problems.
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
