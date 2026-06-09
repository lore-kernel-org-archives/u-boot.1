Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68483CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:12:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB1468466E;
	Tue,  9 Jun 2026 12:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="C0XTFYJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2288D8467E; Tue,  9 Jun 2026 12:12:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4355883FF5
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yipTlXWqhGCn5+QYDNz8YJCb+JbvGSZKDxKROnsPcCxH8lYT+/2EO05iL9l3lh59MQkbrQmhZDbuFq4mV8XcDIwxP14NRskvtp6R2u09YpjasNirmxs6Hi+4uplAh+QeXhvFqjLaCvUGWLtPjq2iddZ8Ucv7gMqGlumTjSAgYp7OqSc28yym422reQ+uhPzdRz6WMFeaqT5ey0qOwgUHoXGOyVi9mccb/JqjssHpXEQWbgK9Han/PuGHjMp8Qk5q2fx3lOh4F/EgvmzouYXpUExUjEsBhTdLMhDSDJwcxnw9SEgLpGFmhdTSrnvC+jD19s40vFfOE4/vY4lxAGCUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hTwLLOyYX2OUeTYSGcsuBbHUtZIFNEam6+x80eOTQA=;
 b=YRwVd6hj6u6Y4bZh1ER0+I46J8nuKqYRh4BxaVKBl36efF4q/5I3TB2wF5zcKeQYGxXQN3fphRTd0MLvyePTAB/u5o5kHnX8EbICQZLCYBuTnxaw6kwSV3THbd5JbSMk1HlC1aIgAjTofi3Ggus6AW+SL1UYcwNW4mri1oXG7STNUaqNi9u5XwXluAl2eyVTPQJKf4AedMURJz/ReEa3JMByrvYRxud506pCDn4AZnx/WtRuZ5k11Qf3T3NeU0yy6LOFAQGYhZTV9NQoecs6woohrD9FY+gx0EVICCYhnMLrUtyzdLMHy5MvvIootatBsF/AcEsN7Rl/4spQODV3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hTwLLOyYX2OUeTYSGcsuBbHUtZIFNEam6+x80eOTQA=;
 b=C0XTFYJFquHEWzOjGjxr9X1quVbdIgeMUQh+auz9mFoCHc4QgNb+lnvlAdo1pM6RfUBGQ3zu/06E5LUPqgR/1LEZwRN1fLBwj4dDEc4zdhpmDJnR2Ft7sAfomspg8wpt8U5jnPuszijP54x3+DTRqfaScTe63jYKjdHY3XmrmGNzmpPva+RXYZ+MsmjXuptiUcUoOw/0SMO7ORqkbno2aAXOa806Mv1QtxLc6wKm4C/DOYrb9gpYt//n5/nrOamns3fuBoNeYDT7KeWtbaaV8JMDteYy+As7FaEabwsqqVHHpeKdJMQxYXHMbs9m3qSVG9SAgg/BAdRCrLD1OM8sdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com (2603:10a6:150:2d1::6)
 by GV2PR04MB12270.eurprd04.prod.outlook.com (2603:10a6:150:321::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 10:12:34 +0000
Received: from GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6]) by GV2PR04MB11760.eurprd04.prod.outlook.com
 ([fe80::4960:3035:f3de:c0d6%6]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 10:12:34 +0000
Message-ID: <25db2dd8-e381-4b4f-a90e-7a76a7b31c59@oss.nxp.com>
Date: Tue, 9 Jun 2026 18:12:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: TZASC misconfiguration on i.mx8m
To: Richard Weinberger <richard@sigma-star.at>, sahil.malhotra@nxp.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, alice.guo@nxp.com,
 peng.fan@nxp.com, upstream+uboot@sigma-star.at, ye.li@nxp.com
References: <3208216.Ym5mLc6kNg@nailgun> <4466851.5hrfCrGMcO@nailgun>
 <6774aac4-5c63-4fd4-a90e-4e8c4f3e2b85@oss.nxp.com>
 <3228430.DofJx8uAJo@nailgun>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <3228430.DofJx8uAJo@nailgun>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To GV2PR04MB11760.eurprd04.prod.outlook.com
 (2603:10a6:150:2d1::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11760:EE_|GV2PR04MB12270:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd9e6a0-3562-4b83-8694-08dec60f9fc0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|366016|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: Cp3woH1OMXFNz9Bd8n6sLyQbLrjE4vvOowV/pn/Jq+vkMhba5yH5pIjeuHvL/xTcXZi6YN/tUotJdnmQ2q1hfDomqDKvT9q/lpezzhZfXldAkrAwcljF2bVU7M5jgsp43ZYI/dIUjBwIF0iX4Zg/mAoa5AIKQ4xTZGjdO3SlYyi7W5v2XGcFHQcp0HfXlpERSPkpsPzJvGFuBAIliEY3zYSJeLgw1KFULesGaLxabFzmtcXpws1ZlJmOPPZSH14E5ibQdIkW/L4niqABNhzAABCF7aYawi+wM4sYEuiDFPW7MOelz4WYhGwuzJCCLEd0WDY27RmFBVLsSOVViqmexiwrJEiQjU8p7+JPH3G5iPl1TJo76I/8E6GRxxb6igMBDTZwB+2vuH8rBYWM+NbS+4OFzLtsiU159UYedNgrZQYCvoB/vgbcEI+140ikDDf9q99/jEdCTOoWl3CuOT1cqXATE9wmPwkF22uwTgn7uDHyCrzQve1cU6UURaatlkD5LOv3XrQED83G0j2I5uGScpROdxlQrV5Jrsn/U24iAhXPMR0LYG6KR/oGVwaAnFZTlXHGZQDlsZXPsg22n9uoiWBZCe/ezPVj/SmkwqXmHlVYtsz+bfamZk0iMsH0pUbirE2SMevqbewdp00VInRyo4egEMVAZtDokhzDrxuvzAMxqaeBFvNOLRBWGk9RUBJ5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR04MB11760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVRsbWNGSHNHTXBJc0tBdVlYV25xVG00QUM5ck9XQ1ZvaE8wd1g4cnA5b0I3?=
 =?utf-8?B?Z1dzMjZQN0R5NzB1SUhzU2FEcjFhNmNrSmlVOGtUc1RncDI5SXJZTE9kQ05K?=
 =?utf-8?B?WHV6Ym1HbEpOOE9JbmpJKzNtam1VUVI1OW9FMU1RZHlPeW9mdjFLY0ZuSFIy?=
 =?utf-8?B?WmdUY05xRUV0NjV0ZVBVV09yKzNLU3hkK3N6YUtqVDBSZUJuWm1zblVvb204?=
 =?utf-8?B?Nk1rRlFvSkpHaGM3VTRsMDU2dTNhc3BtZzhvckNRVS80WUlqTHlLeUZCNmVt?=
 =?utf-8?B?d2k1dGxnZ0N0bmtpN3FqSWR2S0c4NGJiYS9abENhNjNXdkFXeHBXcTlFVWJv?=
 =?utf-8?B?L0dLakhBTy9JRC9yakdNN09HWWV4OFRCdWJGenFMa3FVVzRQMlMyVEtoaGow?=
 =?utf-8?B?NVhiUnhpREtVN1drMW1RZFJFc3UvcVVHL2xZVkpNdDUwYzB2UGJFMEwwY1Uv?=
 =?utf-8?B?RUpaeWNlbHIxcExEVTBla1dyUXBvaDEra0JFOEtDaVFqbU11TzRtV0tSd25Z?=
 =?utf-8?B?TEZMbU5Dbzd3SzRpSVdtY044bVZCZ2NvQzNjeWtHN3NWQWlScEJlbEVTQ1R1?=
 =?utf-8?B?Wm5MekdtTCswQjFMamNlS2d2NSthTzZBakdjalN5bUVCVEo3cUZBMW00Zk5h?=
 =?utf-8?B?dGJBdzAxSjd3Z25BS25aZDNNTno1SWgvWW5MYVdnSXZ3c1gyNmZtTzdTZmI0?=
 =?utf-8?B?RzI0K3oxWkxzYkQzWnY2eDloZXdnZ1VwY25oaEpFRjFTcHNxbFN2UHZ3amVi?=
 =?utf-8?B?K0dxTmxQdGR3ejN6MXFjN0NnV1VONXBvZVN0V0RySjNUSGN4cUVHU1lUbER1?=
 =?utf-8?B?K1JYSUx3c3VoTHJoVkNpYjFxU2dmTlpMZ0wwb0d3WU15K2pqR1BWK0RhbEdB?=
 =?utf-8?B?WDBkZDVQSEc0RURYTHF0L2JSbXduUDlKOEk3RGwrQ2hsSzhGTDRUaE8zcStL?=
 =?utf-8?B?R1lCWG9yS2N3ZzBWWlNUQ0RscjMxMTJzdVBMejlYWkRvTEdEbzRIdmtMK2lp?=
 =?utf-8?B?M2hKYklmNFdnajVVWlowc3ZjQ2I3bm01YkM2Q2dmbHVWOUI2N1RjWU9PdmNI?=
 =?utf-8?B?N2s4VWxiVU5XZy8yTmxxNUJpcXZDS0twMGY3aWdNMW1xYlFsTDM3M3d0ZERz?=
 =?utf-8?B?Q2JKdnhqQ0JuNU44ZGFNTEdtOEhhTXJQeHVuVUpaclRaMFVzUU1lcERxbi9W?=
 =?utf-8?B?TmlnUnNnY0E5ZEJSV2hCTmJOU2s1cUdBbGRSd3NpaWNxSkZuQXFuZ0ZZY1Ji?=
 =?utf-8?B?VEd1eUlZcXFCWFZ0THYrbmR1eFpoZk9XR3FUR1hleDJsT2xkYk5sc09WNG81?=
 =?utf-8?B?ZmdzOVJOaU9CYXRWRFdsS1VBOVRaQW9FWnJ6eVJ0WEFaaU03dmtMQUdPZm5E?=
 =?utf-8?B?TklMSDhWZkNsWFVWYnRpSEN4MWpicUprNjMxanFnYmFqZmx2bDZVUWpCRmo3?=
 =?utf-8?B?V1lwSFBxTDl6aWpWSms3U1NMc045eUUzdjlSQjVzZjgveEJxZGVSbVNsd21P?=
 =?utf-8?B?TmNjWjFUMW1qNEw4ZzByaUU3dll5OVRnR2lrZmVZcSsxQ1IvU0xPait5Um4v?=
 =?utf-8?B?OGU2YWZ1T3ZKc2tsUDZERnVPbGJqbE9ta05iRG1RSDVnN1BkdXdCaDhEZzNB?=
 =?utf-8?B?Z0piOGd5cUR4djM5OFZnSGgrWVJPd1dmM3FlSDlXTTh6V1VQVEhOT3RpdUVU?=
 =?utf-8?B?SWFpNm8zZFBleUp5d29MaGF3SThYbCtVaEMyUnJIYlUwSXFNcSswVkdHQS93?=
 =?utf-8?B?OHNwU2V2NDlOT1piYW5ZS054MXZlNFlNb2orazd4NmZOWVhLazZTOG9iek02?=
 =?utf-8?B?TU1zTy92aGkyMVZ2WXBReGxjRndDb21mWGRPRDlOTFdrU2hxQTNUNVhkVlZD?=
 =?utf-8?B?bGFtc2p1ZXpGZzA4Ym45S01SUjBMTnkwMjE0Tkoyc1JLSHh4YXlRd3RTR21j?=
 =?utf-8?B?c2RISzkwSUhQV1RVWUlmU3RJbzlVU0ZVcnV2N1p4ZjE5RzgvUXlPLzd4STdD?=
 =?utf-8?B?eVVQYkZIcDVCQ3JHYmlFTVNWUEF0em5PS0xGK0c3ZkYxZHp4UFR2SkdhVER3?=
 =?utf-8?B?cGFZYVQ1c28vMnBiaUVDUURySVNENSsxRVFKRnRHdG9UdTR4OXIzS2FuaTlH?=
 =?utf-8?B?T2ZDdElFY0lBSjdsVVE2WXREckxyNk44Zkx6MG00THgzVmNHc2xuM09FQ29V?=
 =?utf-8?B?VzV6Yzg2Y1NaQ0xaSDhZaXRHc1ovQ3pnbWlNcDFMUlNnQ0JnVDkvQThHaUFR?=
 =?utf-8?B?Y3I4bUdKcGVldTFndVV2VlAzV09Lcm9vUXdjdVh0ZmRtT2pvWXlMTExRQVIy?=
 =?utf-8?Q?Znb455bsiZdeuCZcKR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd9e6a0-3562-4b83-8694-08dec60f9fc0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 10:12:34.4104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNMEKd2DOo0mVpPV59KHbZi5IOit4zWpUbbiNOUtXtDUg+2DuuwB166aGUpnJpSm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12270
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



On 6/9/2026 5:58 PM, Richard Weinberger wrote:
> On Dienstag, 9. Juni 2026 11:56 Ye Li wrote:
>> Why can't this optee patch apply to optee upstream? It is optee using
>> secure memory, then it should be optee's responsibility to configure
>> trustzone correctly. Optee can't depends on default value of trustzone,
>> since trustzone is not enabled by optee.
> 
> Sorry for the harsh words, but that's *your* job at NXP to sort out.
> You seem to ignore upstream.
> 
I'm not working in optee. As I mentioned early, NXP has decided to fix 
it in optee. That's what you find the patch in NXP downstream tree. I 
think Sahil will try to upstream it later.

Best regards,
Ye Li
> Thanks,
> //richard
> 

