Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60111C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 15:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED8887E2E;
	Wed, 17 Jul 2024 17:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S4fANXO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BA687FEE; Wed, 17 Jul 2024 17:26:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7928086DBD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:26:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ca2Tk2PMg38Kkn98gCkC0EUYObRxxpzdPm7heH2iERIelua3i9zP7kqwdGtLobiRJYzuEtIN4jZmWVJTdmj/YrZNZjfZNNJebPaSmYh1NOQzulvkTh71dmqSedJEoeNs5vrsYCqkXzPi2olSGB/Q6oKschWDUOh8Q66v/Dr43iOz+N6lzJxpNQ8hMYNRO6XgCeq7ivkw+7UvnL1pKGptTeSWuWcWrOoiOevz4rjSllclR6dN1W/IxQk/4Y+EvvseR9fRv79157hz4PourYq6el26l2UpizIqMhegH327S12LMOoi7DY+uSx5/gB7fkZZ5+LqKnW0cV5o/mqRUdIfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg0N410m7k8x3PghKEvp3M1Pn7GA178+PcNZEj3ULnU=;
 b=LcRCRK9znzCTwSpAO6TWiCn5u3Cz9YBKD6sdkFMeD2ONqmRHV1AR36m1ROzsEiJ1GfNjo64b7fAnEeq7r+0tDHesC8WxXSAOkhpFAWlHBvhDWB30qKMDmK00dI4pb4p5IxNOwp46XsF7P4yLKIGHglNuevfkiQDeuk2jnOzEK6ft6KbDJmKsmVJrHV0hRDq7ARoGIrZeWpA+kc829G2kHUoOJDoID/drskt4tqjg3fEMuhVp7GzZNdVxsAi2DyHAV/WAtg+iGeJ+E6Rn4p63lJxuqSonhuzXwnTXJpw15CVfhgWiV38TTp4q7mE9hxrK1y1AwafIAA4L7fk5SwZ7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg0N410m7k8x3PghKEvp3M1Pn7GA178+PcNZEj3ULnU=;
 b=S4fANXO2PGhtkpINwfUgcZHzgeP41XTcLDD0mTVMG5ypKZWnSeVin/TWUfxQXCL5Um25l8PwSWb8vkhrwHG0zIia1Hgo078sZp0gSd05bnEcNzRrEpZL4fJmBTO1UDdU8OVwfIMhXjm9CuazrhZgzZDk7nYbu8GMODQaQSBieho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10430.eurprd04.prod.outlook.com (2603:10a6:150:1e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 15:26:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 15:26:08 +0000
Message-ID: <9caf5b15-971f-43e6-be8a-c6a2f4bd0bb1@cherry.de>
Date: Wed, 17 Jul 2024 17:26:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] b4-config: configure `b4` for U-Boot
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240717-b4-config-v1-1-0bc9e80ef582@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10430:EE_
X-MS-Office365-Filtering-Correlation-Id: c994dcf9-c6cf-4f2e-6ccd-08dca674c847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXI3aGhZQXUxem1xVFlXa3RwT3AwOHBKSHhjejduWGV3Y0IrOEtVa3JMUnBt?=
 =?utf-8?B?SVNMMTg3Q2pva29lS0M2TWRWekcxQUJVbi9jbHVFckovNXVYQ3JQNy9HMmtq?=
 =?utf-8?B?SVp4Yi93K0Z4MU1TUWxjdDhlaW1OV3VQYmhoTGhnU1pJbC9BSE1lVmFHODlt?=
 =?utf-8?B?ZjRlRURWaFdCK3FEMDhGeVVyZnU5WWg4MjF0OHpPM0JkRXlEdkNhc3hzaUtP?=
 =?utf-8?B?OGxZdnpRZHh6UE52blZERkM1ZzZKTHZvbTUwRWxaOUNUaEg2U1BUSVNJVDVM?=
 =?utf-8?B?RkRLSHYwZGxsSFl5czFQOG04QzBoRTkxcEJDa25PNXM2cG11aDIxL2NZS3g3?=
 =?utf-8?B?Q2FXdG5NdGNEQ210dm1tR3NIUXNwczlpb2syUTN4Y3EyRUZzdm84Vk5KaDIy?=
 =?utf-8?B?OCtLVXpJVDdZMStlTDN4WXJvem1FeDExOVBOektpb3l5SlBxNTFSQ0JxZW9G?=
 =?utf-8?B?dGVOQUhtYzI2OTR6SEpEd2JtSFF1RHdONzVUbHN4RVE4azhKZXQ2YW5pZkxo?=
 =?utf-8?B?VUlGK21NekcwWG9ibHR4TEh1bmI1MEV4YUw5UHBFVW1INnVLWmhab1RPNFFU?=
 =?utf-8?B?dldLNFlDUlFPZWl2REFvL1FzcWtReUM1WHlnYnQ4eVlJOHM0dUxWcVhTSGxI?=
 =?utf-8?B?RTQ3d04wazQrOWlPTm9Va1lVY1phYk1ZQVVQZ0NuS1RTemdJaW1qVkZZVmFk?=
 =?utf-8?B?ZmNkVVp5TUFHdkpHa1F6UU40K0hNRFhWUjhaYjhIVmFYeHpCNFJZRTZKS2dY?=
 =?utf-8?B?ZDJrV2U1djJpZitBS0FNNjVORXp6dG1DcHg1QkpvZXJDTXVNUnJ4cmtjM0RK?=
 =?utf-8?B?ZkYvUHpwTXI3MElHSlFRTHZqb3NXcDE3SVJ3bE5YMVkxYXBxbmdleTgrRWRt?=
 =?utf-8?B?SFFyancrdVZRMUh3SGRhR1Jscno2SVdYcFZXcy9TTG5jSXJEeDRzWThPTS9x?=
 =?utf-8?B?Mk94REtTR2tnRWtVWHdCUldoU1JhSW1tMlcwR2ZvbE5kKytpVElsVDZQVUl0?=
 =?utf-8?B?anphV2hVTjNuejVUNGp3T2lxSjQzM2djZWsrMVJhbnpNSVhFbDFVRFBxVEFw?=
 =?utf-8?B?OUMybUJFbnZHWHFHdTlRMnBpUDhZY1pRd0ZjTTdBeUdsU0J3MDBQenJDbmhY?=
 =?utf-8?B?MDBvMWt4YXNJS0hwS2JEOENrdTNFelM5aUV4SzRBSzRxTm00b2JUNkpDaUVB?=
 =?utf-8?B?bjNJeFBGTnEyOWJHQXp3UHRFQnI0OWgyRjdiTmtmWXgwNFMwcHMvSEovMFJR?=
 =?utf-8?B?Y0Uwd2hHeHhwTmVSaFM2ajIzWmY2U01KeHBZTUZ0ZGxxejdmL0xYWTRzK1dq?=
 =?utf-8?B?MGZpbDN1ZVVsQjNxVEpGTlMwOVAvdHEyTnpzcndyUi83aVFRallzbUljWk5P?=
 =?utf-8?B?dkU0M3VvaktDWjM0MGRyUklvTm56R2FqSFY0cEU5S1M3UHJxOVBpWDVqMUdm?=
 =?utf-8?B?NFZDSGVWQW9CNnRJVy9RQ2dCc0N0OHJydUU5NndDWUVQclo0V294QWxNbmRN?=
 =?utf-8?B?T0VQblR6eFJhYUhzMzZLcFZoNm9mUEZvZTZXWmQ3c1VkakRCNjNUTC9mUUt1?=
 =?utf-8?B?dE1NY1lidHFBV3FaMjlVeFZZeUl0NkxsWVd5L1VJNHo2a0NoaVZjeXpQMTNs?=
 =?utf-8?B?azEvOTNSRlVSUTRLL1V6NXBXQmlFQ3NtKzU2ZHZhVkVXa2Y5aElKaVZTR3VS?=
 =?utf-8?B?U1hSdHExV1FyTy9nOGtkM0plcWtMbm1PVk4wSHNaRGJlcHJ3NnpYZDV3ZVB6?=
 =?utf-8?B?QU1KSE9TNytWbWRibVBRanVlMS9YY1dKT3hkTzJjKzNYZnBHbkxoWlM4SnZU?=
 =?utf-8?B?VTNqdTVUc2h4OG9QbGd6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVdzaDZieEtUcDNlN1JxeUZQSCtBb3N6TGROWDBJQlZGOU1QM0pvUE5wLzhh?=
 =?utf-8?B?QStpOGc0T2VxRjZ3TGJNald1VlBnWjlDUGxCbTJVRkxkM0tiV1Y1VStyY0Zo?=
 =?utf-8?B?bmdXS283TDh0bVBSVEpWMEprVE1COE1XVlVaYm9CTENXYU5XNWdrYi9GdzBB?=
 =?utf-8?B?WmZkSnFWVnZCWk1tb2wxYjJxTVdVdlRoeTM5Z0xXNk03ZmRDN3FXOS9hdXNQ?=
 =?utf-8?B?L0hqc2NmUHdKZVdvOHMwSXNtcS9qRHB2OTVxVEM4SmtLeC9IbXo2MnFMc3RO?=
 =?utf-8?B?dWdKYmtCMGl3eHE2NjJCdHUwTTlNTTdLL0ZwZnBVWXhrZThrOGsrOFEyM3Jo?=
 =?utf-8?B?c08wbC9jU0dvQWU3NS9jQnpGUktEOXVpb0lTVXNyZUdWdzRWNDd0S0ovQXo2?=
 =?utf-8?B?RzA3TUs4NkJHZWdjNlpOdElnR2JVczFYcGx4SDJYTThFQXVORzRxbUNWeS9q?=
 =?utf-8?B?bGloY29GRmFpL1lxaVptV2FRblNOcXBhTGZ1bjdCa2FDODFya1prMVVvOFNT?=
 =?utf-8?B?QS9NZkx4b3hXME1lWmhlbDN0K1YrUkIrL29ySW5wbUI0NUU3bWM4TW9pbncr?=
 =?utf-8?B?TTFOeVRVU3R4TnQ3M3hpcTJMRVBQYjBKMm55Q1VpUVVUaUlPS2dZcURmYmY2?=
 =?utf-8?B?cDBjeldGS2g5YlRVS1FtQjkzWFNwR2xVVjdFM3QvVmtuZ0JwNHZUUWFXYVc2?=
 =?utf-8?B?M0dkMEZaQmlzMXY5U0JzWUNBTnUxNDUzNTAyc2YxWlVNS01SZU5UL1VYUVY5?=
 =?utf-8?B?SWxuaFBOVHZVR1cvSkVWQlJCNjdscFNoclQ4clg1Q3dESGNqalpQV1pPNENZ?=
 =?utf-8?B?Z1lJQVdqUGJwNWJhb05sZDRiNVdVUCtyb1V6QUR2c3NBbWs1Z2N6dm8yK0kr?=
 =?utf-8?B?d2xJTkw2a1FWUytHS2dEblNGNFgwczBSWW1XTjZrL1FaWGZIcG03K3pGb3pE?=
 =?utf-8?B?V2w3L1lIY2s0eDRQWVA5UjF0Z3Y1Y2RQT3d0S254NmhQVGU5eHN5VUJOUXV6?=
 =?utf-8?B?UHRzdU00NlMrMEdZTFQrWWlJUEpDRmhaMkxKMENHREVCTVdFZ1VJL1JKRnZ2?=
 =?utf-8?B?b1AvUXduNFVpZkJMc2lBMXpnLzYxbUJsT1RLa3puMjJ6czhnMkxNOElRMTE2?=
 =?utf-8?B?TXNOSU4xR2o0M2ZoSmlIQ0w0c25sN2pLQ3MvSUNSNjBYTjI0bjQvYi94WlZw?=
 =?utf-8?B?cHRvelhKdWE5dU9ZNlk5U1pZRVpUczlGUlAySG9yYVJLMVdQR2U0bnFYa3JU?=
 =?utf-8?B?UElaektpbGowektWR2ZoYXBBa2J4UUNvSDNsaDJJcG4xODE0MjQzVFZQWE9V?=
 =?utf-8?B?U0NZK3RNUEVldU9xZWE0ZUlYaVVkTVpocXJqV1Z0YlB3ZGsxUzc3LzhTY20z?=
 =?utf-8?B?b1V4Z3dLMXczeXh1ditFVDdabGpGd1BUTHhXakhRNXl4S05yWDg2OHZlSm9M?=
 =?utf-8?B?VXdtdHNsTjFTQ1ZmOEhkNmV0cU93QjYrWkM0RmNoWkZ2a05WT2hlQjNFVS9S?=
 =?utf-8?B?QnFsSUpHaUE3Y0JaUHAzaG84WUkvS3lzOG5sc3NzNlhKbU44SkZDT01WR29q?=
 =?utf-8?B?d21pVFgrSGd4a01zdTBIY1dtODFNcWNIemh0Z0tFZDl6WFNhK1lKVzVBZ3hF?=
 =?utf-8?B?ZDFyRThJeXZJaHlIMUx2dXBncjZ5MzlObWFWVEY1QitRckdGYzFWd2U4bXhI?=
 =?utf-8?B?RmpOSmFTdTFDWHJhVmYzVkFyN3d5RTdoNUlrMjQrNUxQcC9qVnpJQUhFTlFB?=
 =?utf-8?B?VVI0Tzh0MVljRWdlTVZzTmZvWDQwQU9JNk44NHhrZnluaFo2VG5wTmQ1WXBy?=
 =?utf-8?B?MGZLNkZ5bjJQSndYdVFJaE5DbUsxTFpnN3R0dUpoaHlZcXI1Vjc1M3l6OFNr?=
 =?utf-8?B?QkIwbjE3K2IzbjFhZVRlZytxM2JveUdzZXpNZzVTaW05cmpXVXBxVUxMM3hr?=
 =?utf-8?B?aHlMMTZCMXhyMXE0YndBT0NRdEZIM0pFVVJFSlU0bS9lUTVXQzZYZVYxSDQ4?=
 =?utf-8?B?bzhxNjhBYit2bHdYVDZ5TWFwZ0xjQnFFR0JhWmcwdloraExGdkxrTGMvc2RL?=
 =?utf-8?B?NE5VL2I3YzJnakxoL2UwcFJpRWdXRjRYV3RCOThza1JidGd3Nlczek44bG9z?=
 =?utf-8?B?ZGJMeXZuNlhFeGRrc2FualVqczFoem5Xckg2a0NJbXpYeERJaGkvSzZNZ0l0?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c994dcf9-c6cf-4f2e-6ccd-08dca674c847
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:26:08.7963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlVefU/85NUxc1CFVjPPc0QWNcPWp/DbYQMEP8u491+ni2dg3Qzpk3GyY3hvYD5mxqnJ1ez+AhDfU7wXwwNPoUvF4n13o9AqOLO7as9rRkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10430
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

Hi Juaxun,

On 7/17/24 5:12 PM, Jiaxun Yang wrote:
> `b4` is a commandline tool to make patch-based development easier[1]
> 
> Provide a .b4-config file to match U-Boot's patch preference so it will
> be easier for people to use b4 with U-Boot development.
> 

I've been using b4 with the default settings for a few months already 
(i.e. without arguments, without .b4-config), is there something 
specific that made you want to override the default values?

Cheers,
Quentin
