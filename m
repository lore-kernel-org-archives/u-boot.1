Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FCAE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03F080241;
	Wed, 18 Dec 2024 16:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="FZd1Tr8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DE6C8022B; Wed, 18 Dec 2024 16:38:07 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213D380241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Us+BfwfwlrimxDzH8SBKPJ5DJD0FHrWhnytNFwxo1wdY/D6aIA4ETa9yXk9sNoBH0PYCsZwsa3QdUeJx4pSMXP5Z0qxmJi5e+opsFl1ZqfM9dG81kArmfBuaxZ9BxT7z5OmKWiHzMpzP+tGxHZus/un2XK5TmbPVWb/LMKtH4EORNS7KYeURA88l37jbM5NesD7hvHQN6UbLSi5FZIUCmxmwkVK2fvzZ0kTYvI8KY3FUpr8rS6uHpgGyanLcSJOQfdOpB/jwTtKPSmFc2DTtPvxG2dsilw+8KHvTsAfNE7JzCelAK8lHGaSCOGRGK1q3R9b/P8aG73Ny2mmjK5b4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKiAgozlfgnDfCiL6o1rVqJtopTveIhNgEInpAqwD0M=;
 b=E4cKpa649uwAkmDe+no4pXIM/8ydM7fxSz4ZKqD0V+viClvAObnNdKPTcFAH2jpo/EaopQ14DkU2z6i05ku99FBY6NAIu35QMNy4B3rbTqj1P3GDIkRs3x6EoLP6QxBgT7UXXzSL153O6LQXuc/6nUmtpib76MJRtbwph4ciRvWVpd9Kwxd2gSXG3do/HMPlehEKSo5bfS8E0fuwWvQ71fCxLo8c/gmyuQEQVT5LdMn/TqrAh3wtEQRxnvW0IfOBOpRCaNXonpxWBJc3gCBgnm9g8keEZJboS1jAMB0IbM07XXXiZnw0YT3UZTuuIeRQcN7tE6mgw20yFGWHO979zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKiAgozlfgnDfCiL6o1rVqJtopTveIhNgEInpAqwD0M=;
 b=FZd1Tr8KvjJlej5mHKHVHf29akp0qtAdShZ0ZAHZaedKAHWo5ltS75I5v8v0EpC465PbAYb4/5MR5JduQxgp3mCYw2dUu2/3uNvfWmTNpQfKzoMkMGyuq8y6pEHSVOsEcrd+LYY8Sh+37fMm6uIq64Ig8Kxm1OEKl6JS2oEjiOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8006.eurprd04.prod.outlook.com (2603:10a6:20b:288::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 15:38:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 15:38:03 +0000
Message-ID: <5ede6d73-3b95-4b18-b7aa-3f0a3ed56acf@cherry.de>
Date: Wed, 18 Dec 2024 16:38:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gitlab: Add samus_tpl to the sjg lab
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241218150802.4064561-1-sjg@chromium.org>
 <20241218150802.4064561-2-sjg@chromium.org>
 <20241218153045.GC1505244@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241218153045.GC1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e99e532-1426-4b8c-d555-08dd1f79f5c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1g4QXl6MnlQWWRmK3RKaTNUN1M1WW9kb05LY1ZzS1llWC8zaUJ4ZHlXNVZv?=
 =?utf-8?B?R0NUWUdoNVBUcUNKQ3hkdWUzbFNoSytvWngrMktSMHdCYkRKdlAvTFN5a0Zm?=
 =?utf-8?B?QjVWTHRlajkwcklJdTRqMWxUTThBcXFya1JIK0Z3Uk1lWkozdmZMMjBwa1lR?=
 =?utf-8?B?MVVPZjMyN0NHZ052M3QzaVJKK0NtR2JzL1o1Y3FNQnRBUkh1NEFCbENONDRB?=
 =?utf-8?B?dWtzS2dyYnRwdHV5UmdaZHp5eVdNVjJid20vZERreEU2WVo3eG9GeUc1Sm14?=
 =?utf-8?B?RWt0WWJFYjA2alhudEZidVRLaXFMKzlubUgyRE9tTGJwSDN0Sk5MOUNkUGND?=
 =?utf-8?B?OGFIdEhuUndMbnVNVHNjbm9WcER4eWdkcmZ2S0NnMVpOOHlzQ3JsWE5POERU?=
 =?utf-8?B?eUF3NFZReFEzeFNiU2lFekhiMExQaHE1Wi9jc3RXSWdwR3VnZTliMXpoUzVI?=
 =?utf-8?B?NkRsc01hdlBPTzVWeUc5b2c1SjRNamREeUFJOG9qcXRXR3hZZUZhQzZvb0lI?=
 =?utf-8?B?UzlQTVlCVDR4NlYvSlg4MFBaQ25ZdjRTUHhQTTRqbnpLWS9IWWxUR3g5ZThx?=
 =?utf-8?B?UElLUjdpd0hXODBKZFByWEVIOWFjSDZhR3p6TFhJUEdVQmlJZ0UwaEN2M1Q4?=
 =?utf-8?B?ajhkR3REdk12SkVxa3VlRi9qLzVVMEpqa0gzdUJQbDdJZEZrWnlTSUdvMjl6?=
 =?utf-8?B?TkVRWkRXM0dyR1cvYzJrUjRWdUtSYVRYT0h6TlVPL1RhRzE2Z01aY1VkOFFn?=
 =?utf-8?B?QzlUWW9Sdi9kRTc0elcvekZFbGl6ZEc5NzI4ekhkenFjY05uZXFESVFyRVR5?=
 =?utf-8?B?ZDFtbWRrNytubG5ZVlltWGhEZ0ZvZExrVE9XYUIxS2ZzVmRibE1BRmFPNkJT?=
 =?utf-8?B?Z0Y3MG4remh2dElwMk1hQ3EwcVd4aFZIM1RmSDRjUU1ENm9IUUE0amY4aWZy?=
 =?utf-8?B?enI5ZEw4OFVHQi8vM29reTBKWUw1dG9uSHB4ZGNwdXpEUDJNQXJESWJseCtV?=
 =?utf-8?B?eURJeWFOUFhxTjZOMUZhKzlIMjJISmQ4NlREZktUQm1GRkc0Yk9mL0g2TnNM?=
 =?utf-8?B?bHlOVlhLbnIvZ1ZpeWpDV05xKzRjMis2Q2hpVlN0OE12Zmo5ZzRpNE9RdFJh?=
 =?utf-8?B?OHVvMGJXK08wU2JsblhqaXp0UVd2K2tXeC81b0NXSTFNUXBjRnl3azRWUDlz?=
 =?utf-8?B?SWkzN3dwUUJpK2xEMXloY2plMmdWbHdsZzZ2ZVFGK0VyZmJJYUJTMDI5QkRK?=
 =?utf-8?B?bk1lUUNyNjBYSW1YdzVZL2RpditONEVNYWhBS0Z3WnA0VEZ5U3NWVTVkL211?=
 =?utf-8?B?ZVkxSFZDUEZrMTcxZ3pjWVhGNFNueEhPT2o3SUVNZjBCNGRoK3g4OVhUeitF?=
 =?utf-8?B?Q0oram9obHZ6L2hFUFpmRlFxaHh0RnJCTFdFaW44MXFPWUhJU25SbURYOVlh?=
 =?utf-8?B?ZHh4ZWYwOEFqSWJjQjc5RENOcTBlZGNIczcvUVBOOFl0NUIzRFl6TjQ1cFNX?=
 =?utf-8?B?S05tWHpyUEFUVnFHenNOU1I2YkpLZGh5emRZbnhnOVJMOTcyQVFzMVVqSWhn?=
 =?utf-8?B?am1NU0Jnbzh0VHRuaURMOXJxbmJKMXV2TTdrQnRzZDhCZnplR2dJQ3hYWE9V?=
 =?utf-8?B?L1pqemtWZXFPUG52djR2TkQ1blV3Y0RlU0x3cXhmYW1xN0VGVGZxM3JSNzlh?=
 =?utf-8?B?Uko3UFJTSW1FNEhlMjY0WVFjNjlKK3c4Zm1lclZ1MC9KZFVKcUVRRTFabktW?=
 =?utf-8?Q?p6jL3aoRP4E9MPKa6gA6GksW/iPwinunugH9IT2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1gvT2dFejRyWUFxbHdzV0NSL1hXQktJTU5nQjRTSGlCVEdKY3hYcUwrZnRV?=
 =?utf-8?B?TXlZdFBiMkFYL0M0dmd6YUpVUDlLQmVwWDJJN2Q0Y1FxZFJFeDVrcXJJcDh6?=
 =?utf-8?B?SmxKbEpsK0dUVDl5bzQwQU5DRVpHYS9VSWsxdnlsb3pDVDFvQk5vb0N6aERF?=
 =?utf-8?B?TnZPSWIxMUptT3lkOGptYitvczFCdDljb29IUWFSRkl2VVhneGsvZUxWQnRT?=
 =?utf-8?B?alh3ZTFYUEsrTXBmVHRxUENsNGhXeTZwZ0FNTTZFU1JpNDdPWW9hZGVjZ3dS?=
 =?utf-8?B?eFNSRjFRV3QvZVZlMkV6NmVKWHFMbWorU2pNbU9GZ05kblg0TWxRQTZleDRJ?=
 =?utf-8?B?eVdLVmZmVy81RVkxeldKaDJtNml4dnpwZ09UNTRTNGtzTUs1SnFMQXBXYjAz?=
 =?utf-8?B?SkVEbjk3MFFGMnhoNnYzSGZuM1RFUGtNNUp1NGdBeldpU1lVeUY2SFZNbnVN?=
 =?utf-8?B?L2w3YllPWWwyUGxTTkV5TzR5dUQzOTlsM1VmVlVZUGZpZThVd2NHUFNMcVVR?=
 =?utf-8?B?MVp1bGpzZTJyV2RmV3hnTk5xZUVwZW1wdVRGSThoaFlHWnpwUVNMTkV3bTJr?=
 =?utf-8?B?eUp6UTFHK2VTbEZVSzdZZTRWSytHKzdmNlRvSHpUbmh4VnNRNXk3Q0NqZUpY?=
 =?utf-8?B?N0dLWCtSY2xkT0JmUWhXS2xoQmNjTUlacGIxems2VFJqTXkrWHZyVVZKc2tB?=
 =?utf-8?B?Mjg3MnEvaGlMREpuNkFubmxiMWl3cFp3cnl3eGJQTnl2YXVRM2UwNVkvRXZC?=
 =?utf-8?B?cjlPb3crNnVxMjZZcXhUays2UWcxTWhzdTZweGVJNmxSVmhJZXlxYnAwMnh1?=
 =?utf-8?B?N0x5NlNWQVFSdVpMYUtsTUlRYzcxVmNKVlZxT0h3UU1mZ05Sbzk4OU5kaFVE?=
 =?utf-8?B?dnBzMjlsMlpaVlgrNjBEMGQzZDM1NDUyZ3FReVg1UkJ3SHlpTTFDTTdxNEl4?=
 =?utf-8?B?RFBXWC9zTVgyQ3FRR1lSSEc1RkNpRjVoSGg5TGVxR1haVitZNHBGSnFXNExW?=
 =?utf-8?B?dHo2c1ZJU1EvZ2Q4VXZLWjZBdHZxajVKTDdQWDVLNllIZGpaTVh4OVlIaUdQ?=
 =?utf-8?B?eFZ4c01rYlhlWEpDYzJRblB2bUFGN2tVcUVFb0cyYWZ5cVdaVlE0R1lpcGZu?=
 =?utf-8?B?Tk1jbG5za3lXU0FiK1JyNU5mek9keXZaUEJjNDFLYnZNY2pveU9ZSFRpS011?=
 =?utf-8?B?MkphSXBpTTc0Zk9WUzA0OVhHKzBvTDl2V0VJQnlMWTUwdmNtSktCRGNrVzVW?=
 =?utf-8?B?bjBKeXorR1JSU3QvQjhORVRsWXczUHlTZTZwNEN5Szg4WC9DTXhCQ09WRmVp?=
 =?utf-8?B?cnVOSDQ4ZmJ0eVNFZTBXL0pYaGx6TUNsekZBS283RXhyUFYwckh3KzhBRnQy?=
 =?utf-8?B?eExKclF5ak1rTmxKZmJGNFpXOUZwR0NFNXpaaUlTMFluN3JBT0FvRWRVVDhH?=
 =?utf-8?B?M1NyK1JKMkxBUnQ3WWpIRmNFbkR0bVBtZEp0WDVjVkNIenNHMGlBZXRjeHZI?=
 =?utf-8?B?Tk9iL1I0QUFzQk15MjJsRjMwdzAvci9jdStudXlxQm9ydWt3a1Vrd2M2K0Q0?=
 =?utf-8?B?QVBwd3VHWUw5QWszOHU0K0lLbG0vdm1BNW1BVHBDSlIvQm1TZlBvazJUdHVQ?=
 =?utf-8?B?enMyNnpDaUZpQVNhd3kyZTdvZlFTdTJYVEVMS0lUQjIvZVVMUE5hVWJyY3pr?=
 =?utf-8?B?T1hNcFphT21pN1VlM2UvQk5tb2NqUU9QTHpVbnl2aTlZS2gram5nSVZKbVp1?=
 =?utf-8?B?Yi9QVS9NVk5NUi82b3Z1VS9YeEkxUDJNMDkrZDNJaGlXVmI2NWs2Q1d0WGFC?=
 =?utf-8?B?TXU0VkhmOWYvOVVySWtBRlJ4UGNQWkpKNlNDS29aNSt1dzFmQVUwOC9Ha25U?=
 =?utf-8?B?T2kxeEVYYjNtZzRNbHArV3ZLS3NxbmtJYVZvS1NGK3pYVDFTU01OczljaGF5?=
 =?utf-8?B?Z0JtN3ZCU2xaRDJZYjRGeXNoaWU0TWFkQStWZ3ZFaWdsMlJCRXJzMmtldmRI?=
 =?utf-8?B?MEhlNlFOa2JSYW1sZy9sSWxiRGpSaXpMRUhXRzcxajk1UjE2TkdwcDZMTW43?=
 =?utf-8?B?VVY2blpXUDFrVHhtQ2s1Tmo0cTNyVWJQSko4TmsxQmhneDhJYWNRZkRqaUlJ?=
 =?utf-8?B?bFp3OUI5TnJiYnZ2NlhWdGZhYmJtdkh2OXZHWkR3dkNhVGt0L2V5Uml5SWJN?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e99e532-1426-4b8c-d555-08dd1f79f5c0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:38:03.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7QWkH5+z/kQP5380/2EMrlLRB626Hb5Fpn7zWWFKTmLvJtfzJIg6pECU4ahOHMMsmBeAp+V7+xT3pptHRO6l+4F3IGgSvpaTfQIU5dlXIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8006
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



On 12/18/24 4:30 PM, Tom Rini wrote:
> On Wed, Dec 18, 2024 at 08:08:02AM -0700, Simon Glass wrote:
>> This board has two variants, one of which boots with tpl. Labgrid gets
>> upset when they both try to claim the same hardware, so we might need to
>> see if we can handle that cleanly, e.g. by making the job wait.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>>   .gitlab-ci.yml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index c620cfd1e34..72959427951 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -593,6 +593,12 @@ samus:
>>       ROLE: samus
>>     <<: *lab_dfn
>>   
>> +# chromebook_samus_tpl
>> +samus_tpl:
> 
> I think you can just add:
> needs: [ "samus" ]
> here and gitlab should get the ordering right, but I didn't pass it
> through the validator.
> 

You probably want to not fetch artifacts from samus job though, so 
disable artifact downloading (if there's any), c.f. 
https://docs.gitlab.com/ee/ci/yaml/#needsartifacts

or use a resource_group, c.f. 
https://docs.gitlab.com/ee/ci/yaml/#resource_group

you could have

resource_group: samus

in both jobs for example. I think this matches more the expectation?

Cheers,
Quentin
