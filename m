Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55310C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 13:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94DD82D43;
	Mon, 26 May 2025 15:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6C982CF8; Mon, 26 May 2025 15:45:40 +0200 (CEST)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D0382D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 15:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parthiban@linumiz.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKR9aTPEqi7vkE3G3ZXEd65rOirq7X4/OS+NdyZ5E9okaqaYtWqGjImucbz8gr069wcHnzbyKfm9yem43/N1BheuOoNsFdmoi3Qk9TMYlNYWbYALhNB6cCWHOLjc6zHoskTinI6ttEio6fTfIBERZHlvtSzB9n4bqcB0dkV8ds2+SyMQ6iVFlKncAQ3t/H2QZTgEneI+OZFHcbfOvoSsmPGh5sPoHdCWlH5liGKIxd1azdkSS/pfAQZPWO7+gZusWTIYD/xI62seDiyktRDjl7GCT10o5uRx6aUdhawOFhaV4MEWL5Y2yy3ns+r83ot6t48p+9ys3W+FzDGFUYDKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au6r/5Mo2vN8kuAh32ssmL6PuHiMRkuAExBCLQ4tPKM=;
 b=O1XQxJ39EZhwp/v1e0xfIKTvTNEDGaxdRIOLzVHSdhbS8IZvCGmTENVMljVJvXPbhMqGy9Lq+PZyqo+8zLycbDFvPal0gw1FuFS0CTkHjvPAJbHrIJM3XstEz5t3t+v+JVTXbe+X7HH/9eO4WC061WXuul9G50FN7H7s4o6wxQ70qo8Mrkrx1+bX7kdr8Nl/xjEfgvj9cfnBfp1LZtrarRjT05OcazP6itdSFSjKTx0RR2PLYQEuRgKM/d+LyMdqw/FYojhRYcJ/Qlr9SE/2GKSgqNggyBdX+5sWMa0fsdSGXi7asUDRNDEN11o3riOq7562GWV66KsTTnpnSmUdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by JH0PR06MB7236.apcprd06.prod.outlook.com (2603:1096:990:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 13:45:31 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::9e42:3253:9a2e:b565]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::9e42:3253:9a2e:b565%7]) with mapi id 15.20.8769.019; Mon, 26 May 2025
 13:45:31 +0000
Message-ID: <af1b17a8-3d2c-4d76-92ea-eb226fe97165@linumiz.com>
Date: Mon, 26 May 2025 19:15:27 +0530
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, u-boot@lists.denx.de,
 Jagan Teki <jagan@amarulasolutions.com>,
 Philippe Simons <simons.philippe@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 1/6] sunxi: A133: add DRAM init code
To: Cody Eksal <masterr3c0rd@epochal.quest>,
 Andre Przywara <andre.przywara@arm.com>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-2-andre.przywara@arm.com>
 <20165cde26bb95b5f79d01d37f1f4af2@epochal.quest>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20165cde26bb95b5f79d01d37f1f4af2@epochal.quest>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::12) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|JH0PR06MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: ddada27e-0e6f-45c2-d4fe-08dd9c5b9502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFh5VVlsdUpTQi9tRnE1UitBMGNLd3ZZbkRJZFNrdnMwTVZtMVpJR3pJN0sv?=
 =?utf-8?B?QWlMVG4xZGVaQzhCOWhRYWJuUG9uTUZ1VFIrNXB2WnRiTmczOUY4MXpjYkNo?=
 =?utf-8?B?aWtuc0IvZ0hXWmJDMnpRUnVTS1dmR0hENU00aVR4UGRFMkxIUXdNSG5yTEZ4?=
 =?utf-8?B?K3J0QzFtMmpTaTVZUFlyWmh4c01OKytzZzBvVTJET3lDRFVZN1JWdnljZm1v?=
 =?utf-8?B?eVB2YVJDQXg4ZFJjSDIwTmw0cWIvNjRGUElLaUN5RnF3MFdMSDg1OE5palpq?=
 =?utf-8?B?dStRZkJUY3pEZFFhcU5sZENrS0Mra0hlbVUzNi9pQk1YTDlrMlpNNVc5Q1RK?=
 =?utf-8?B?U2hENmdLMFNaNWYxcCt1U0hsVzkxZ0FIUmljbjRGVEE1WVR6NnZOU3hNcEpR?=
 =?utf-8?B?Y0M4UXI3bjJBaFZMZ1BVSlJESjFWK0JoM2w1YTd0N0dGc1BIOVAyTmE0U0Ns?=
 =?utf-8?B?VGFpSmZLUUNsaVBLbjdxbEJGT2I4WXhrWkJ1U2lKOG14dVF0cnd2ZFBuNy9o?=
 =?utf-8?B?SjRWajZiU1dJWDhiRnpLZHM0ODhBY2gySzJWZzFpaXBDODJ2ZlRRcTkyenZG?=
 =?utf-8?B?aVp2bVV2SVZUVlJQOCtTU1oxdVZFN1BuZUdZWnFISmdGbjcwVERiMzJsT25P?=
 =?utf-8?B?dG1SNlpFQ1N5QTdwREI3ckgvRnlvSjFCeXBwY0pXOERYYm91RkFhOWwzZUJO?=
 =?utf-8?B?WGhhWFljTEF5eVhtZWgyOUxwemNuRGFsU05zNWphTVZzdEhleWlGSWpEWVRa?=
 =?utf-8?B?ZHlZZXpnU3l6MWdWT3hDKzlxZWN3bk5wUExoVjZzS29MWm9Kdno2NmRmYUxN?=
 =?utf-8?B?bW8wSTRGeHN2N1UvRDcyUTE3SDZDVmUwbGdNSUJBN3F6b21BRFliaUUvdXAz?=
 =?utf-8?B?TWFWb1NBK2o4NUpzYXhtSU53cllwc3hWMWZNdUVycmt0WFY5cUU2b2VpT29G?=
 =?utf-8?B?OTVMeWgzNlNXY2tyQ3MxcjZ6bEFOb2k2VlJYR0I2Q2lEN3c5SHFxT2dJeVhX?=
 =?utf-8?B?RStEaTdKc1JzNkV4NnorOUpxekhwTEpZQzhObkFRZk9LbFhZR0lEQzZnMGM4?=
 =?utf-8?B?N1l1VTZGZXdiR1ZXSGVyTFlVZlV4RzNueVY0eVp6bE9wN0hLa3ZsMFppTUhl?=
 =?utf-8?B?RUE0QWphNFNhcy81VVNETGt2Q0xMVWZkQkVTd1RmczM3Z0plcE1hVU9xWkwx?=
 =?utf-8?B?bTUwUThYbXZldTl3eXBkck1jR2R3MGh0NUcrK215elRRc3pnZ0tDWXZQNmdS?=
 =?utf-8?B?ejMrWGRDc2k3K29IYUFOczZUVlpXVE5wdzVoL2pOMXBPYXFTa01TQ0szRUdT?=
 =?utf-8?B?UCszOWlSRzFTOU5FbWlEdHd2Q0RGS0FtcDl5RDV4WlFPdUtOd2xMV0llVnoz?=
 =?utf-8?B?Z2hHUlJuWDRITWhHdFBFVXZVUzlPZlBJOVJEeWVDRE1JWmpZdnA5VnpBZFNU?=
 =?utf-8?B?a2oxblJ1aWR4Ulh2VENZRll2bVBsY1N1N1gvRXB2U0E4MllIdGlFdXh4dXhn?=
 =?utf-8?B?cHVzbjZZeU54dXhVcjhtSU1IdEpvQ0kxakhlQm9lN0N2dXRZVzhOdGd0Z1ZM?=
 =?utf-8?B?bkxEeUVXOTNldncwZU9OS3NhTHkxVzN4dEp3c2lLTjg1cm1PeFAwZTZxNmZo?=
 =?utf-8?B?eFVINVc1YnJMOFBYQU9rQmhEZkpjcDlqd1pZZFRvR3Mwek0zVjlBc1ZqelFB?=
 =?utf-8?B?SS9Pa3k2NnVpbERpSXJDYUFZZzIzRlFXS2g1WGVycEQxVzBQazBEekJrbi9G?=
 =?utf-8?B?Zlh4UksrS0JjWUphS1NNeGFVK1UyaDQyaDc4c0VrdjhmRXlBalZIcUNIRjk4?=
 =?utf-8?B?czdwY2EyUFYzS1BXSVMvZWh2UERFYXd2N0Jrc0xsaHdMTVZvV0FXZFl5clB6?=
 =?utf-8?B?Z1lScmxIWHlFdGdLalA5Q0pIM1ZDNEo2UjNnNDBQMnhUWkhPazB0TjBSa2RK?=
 =?utf-8?Q?44eExhtVyIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9RTk93SktMQ3I3RzlKMGdPMmlQQTRIejhkaUdUTC9XY0ZhVXlYK3VLZHY0?=
 =?utf-8?B?dGNvUmpMUDE0Tk9Ea21Eajcza2Fxa3lySHlqU2VBVHYzNXprbmxyWm5HTVBW?=
 =?utf-8?B?dmFKWmZReE40Qkg2NnFsYXRnZzJnOWtCaWl3M1hjeDdNZGgycU1tR3FGSlFU?=
 =?utf-8?B?U1RDUEJSdVpBOXRUVEtrRTZIQ0F2OHdKNjNKak92SytOVlZHTWp6Q09OTWpt?=
 =?utf-8?B?amhQVU9yTkhucUFQZlZpNkNRa1MrT1pJbHBFc3NSalFTanBob0dWVU1pblRy?=
 =?utf-8?B?WGVMaUNzY3hXeDVYSGkyZ0E3R0grS1poejVqQ2NVM2YvVDZ0M094cTY3V1lO?=
 =?utf-8?B?Z0RxSmFSdjdTQ0RHWS9Ib2tsNENaTXB1ODRaUmJOSzkwVWJ5ZStzQmZ5eVNV?=
 =?utf-8?B?S3hWK211WW8wb3luajFIOEM5RkRUSkNCNHF3MFBEQkZrUlhCNnYyUEdQaWJO?=
 =?utf-8?B?aHZFMS9hUmpVa0x6S1FIdlB6L2NjS2tLbXZZM2RlTXhCRE1KTk5zMnNhUnVz?=
 =?utf-8?B?U2JmQkJnc2J6MDZxdllHVXowSGxNaW1oY3JKVWZuTHBVUGhHN2NZZC9HZzF4?=
 =?utf-8?B?R2w5WENxR2ZZRHAvaU5LcFIyQy9mZUdkVjYxb2lXQlVudlFYbVlMdXA3VSt4?=
 =?utf-8?B?bWpzdm5EWDZZdHNFcnA2VVNSMHpFZUVkNk9NREhVYjY3TlRMTzgzSmtGZTBm?=
 =?utf-8?B?bkdub1J1aWMwcU85R1JTb2cyK2cwTmVMdGoxRWNmaHdTbzEzSjNOS2wrYUpY?=
 =?utf-8?B?VkZHSU9vL2s1TFN3bC9LejdneS9ySHRVaXdDVkdSUjUvYXNVUEowd0lwQWZy?=
 =?utf-8?B?Zk9MTXp3SjBpUUlLekZKeC9jRnFma2trNnBSNkxDWlZjcXBXcnVXMzlWeWlZ?=
 =?utf-8?B?NzJPTEpabUhyUVFzY3JzcWtiZTRWbXJscHEycUljSldsK3FPQUFvRWtNamV2?=
 =?utf-8?B?WnRKTEozZGEyS21FNTJwM3U2cy91SERuTzRsb2xJbW85R3J5YXNqVDZzRWxQ?=
 =?utf-8?B?V3lsSnp3S0xvTHdSQ1dBcEpPR2tUbWNaWisrYkc1a0J4ZHM5T3o0Z3NoV0NT?=
 =?utf-8?B?YXlNbGZZMHZlOC9FTlpvTGUrWUpnakE4dDExSGpvZG5iV2tJUHhaVzFWbWZ3?=
 =?utf-8?B?bEZDNkZHaWR5WnRmcHVsUUQ2YmcyZlBYM0JwcExqNkFqa1pkd3pkTlFrSmNL?=
 =?utf-8?B?QmlrbkxPQWdBdU1ncjRWQWJ6ZmU5UEtKNUFsenBzdkFtSFUvVmFMMVpRMXhs?=
 =?utf-8?B?cjhWZkhNRmtsOEltOHJkZ1hhcmtvQ3BsS1NCSFI2S2ZiZk9xWGxYckg0YlRm?=
 =?utf-8?B?VDFlOHM3YUFGcllvMExiQzNkYTFtTXRHZWp2c0pPdkFDS0xoSVI2QUphR2k3?=
 =?utf-8?B?Z3lUMWpqWTZrWkF5bjd6bFJ6OHFXdVoyeTYwaFlGVHR0RVVpR3FtUnRubWNp?=
 =?utf-8?B?azhkODRCYnFUOTJSQktQTXZtNktvZXhZaGhYZUQwbkFuOGNrajZ5UTE5SE8x?=
 =?utf-8?B?bGt3MFZzcFRNZXpLcTFrL3VKN1BaWmJVLzc3aXVyakNuOTA0cmxWYXJzQ2Zj?=
 =?utf-8?B?NEJpRGJqTGRzUmJwTktlUk1mSmxBMVU4ZHdyYjBjdWZkZkphZHhZNjNUVktQ?=
 =?utf-8?B?Ry8zT0tkVnQwVFBKalVSOERXd0JpQzY2R1JsVmVTS2dHazJwSWJxKy9PemJ1?=
 =?utf-8?B?c3VJRlZ6UlNtQUY3TW1HMytGSG1UYXdLNFluNVpnbFRSZktJb0hnMG9MRnB2?=
 =?utf-8?B?dFg3MVpkT0dsR0pDKzM0SHdJdVpaWTd2S3R6MFRadU9SWVhzNk4vVDBBRzFn?=
 =?utf-8?B?S1Z0UHNTckNyOWcwWm9lS3YzelRBYndnS2hUTE9MN2R0dGtGUUNqWVdwci9o?=
 =?utf-8?B?SDE5MVlWd1d6cWRVM1gzV004UGI3NDJGV3V0RFlTRkgvNGRiU3dvN3JZSk9z?=
 =?utf-8?B?WTlkSThsbk4xNFhkTnlrY3Q0T3FlR09zdWN4d25EcDRjMDdUaFFkd3NoOUQ1?=
 =?utf-8?B?ajJueDZwQXVRdEppaWV5YU5qTlB0cXQzSHVjelVmT1FtUmZ4L2dmdFhYRmsr?=
 =?utf-8?B?dnZ4cDc4Q3MzNVBnWWpWOW5UV295eXp1TndtdHQ5WFUvaFlQMGZFaWZPRUVM?=
 =?utf-8?B?VlRhRUlPZFJmS0Z0NFhzY3NoY2t5UUFTWS9xaDVRL0JaYU9aYXViYmFaRllK?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddada27e-0e6f-45c2-d4fe-08dd9c5b9502
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 13:45:31.4106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JjR7zUrxgJgbuLhjuAjgiaydeER+ELeF9lwEdWCBcURON2p5V5QRtiu04lGeV0zaoDqLzZEvfxv2+1GDZnNU5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7236
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

On 5/12/25 8:42 PM, Cody Eksal wrote:
> On 2025/05/10 10:09 pm, Andre Przywara wrote:
>> From: Cody Eksal <masterr3c0rd@epochal.quest>
>>
>> This adds preliminary support for the DRAM controller in the Allwinner
>> A100/A133 SoCs.
>> This is work in progress, and has rough edges, but works on at least
>> three different boards. It contains support for DDR4 and LPDDR4.
>>
>> [Andre: formatting fixes, adapt to mainline, drop unused parameters,
>>     remove struct struct sunxi_mctl_com_reg, hardcode MR registers,
>>     switch to mctl_check_pattern(), remove simple DRAM check]
> 
> Thank you Andre for cleaning up my patches. Life has a nasty way of
> getting in the way when it's least convenient.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Thanks Andre and Cody for the cleanup and work here. I tried booting
this on my A133 helper board with 1GB RAM and it worked fine. I have
a custom PCB with 4GB which fails to boot fully. I have added the
log and defconfig below.

I have added additional debug in the u-boot booting, i.e SPL booted
and u-boot as well (after BL31), but failed to resume from the relocated
address.

Previous version i.e 2024.10.x tree from Cody boots fine, but when I
was able to work only upto 1GB address, accessing beyond that crashes
in the kernel boot flow.

Did I miss some configuration?

vendor u-boot DRAM related snippet from console:
[759]dram_para[0]:0x318
[761]dram_para[1]:0x8
[763]dram_para[2]:0x7070707
[766]dram_para[3]:0xd0d0d0d
[769]dram_para[4]:0xe0e
[771]dram_para[5]:0xd0a050c
[774]dram_para[6]:0x310a
[777]dram_para[7]:0x10001000
[779]dram_para[8]:0x0
[782]dram_para[9]:0x34
[784]dram_para[10]:0x1b
[786]dram_para[11]:0x33
[789]dram_para[12]:0x3
[791]dram_para[13]:0x0
[793]dram_para[14]:0x0
[795]dram_para[15]:0x4
[798]dram_para[16]:0x72
[800]dram_para[17]:0x0
[802]dram_para[18]:0x7
[805]dram_para[19]:0x0
[807]dram_para[20]:0x0
[809]dram_para[21]:0x26
[812]dram_para[22]:0x6060606
[815]dram_para[23]:0x84040404
[818]dram_para[24]:0x0
[820]dram_para[25]:0x0
[822]dram_para[26]:0x48010101
[825]dram_para[27]:0x273333
[828]dram_para[28]:0x1e19131c
[831]dram_para[29]:0x14141312
[834]dram_para[30]:0x7521
[836]dram_para[31]:0x2023211f
[844]DRAM BOOT DRIVE INFO: V0.69
[863]DRAM_VCC set to 1100 mv
[866]DRAM CLK =792 MHZ
[868]DRAM Type =8 (3:DDR3,4:DDR4,7:LPDDR3,8:LPDDR4)
[878]DRAM SIZE =4096 MBytes, para1 = 310a, para2 = 10001000, tpr13 = 7521
[890]DRAM simple test OK.
[893]dram size =4096

Upstream defconfig used:
CONFIG_DRAM_SUNXI_DX_ODT=0x7070707
CONFIG_DRAM_SUNXI_DX_DRI=0xd0d0d0d
CONFIG_DRAM_SUNXI_CA_DRI=0xe0e
CONFIG_DRAM_SUNXI_PARA0=0xd0a050c
CONFIG_DRAM_SUNXI_MR11=0x4
CONFIG_DRAM_SUNXI_MR12=0x72
CONFIG_DRAM_SUNXI_MR14=0x7
CONFIG_DRAM_SUNXI_TPR1=0x26
CONFIG_DRAM_SUNXI_TPR2=0x6060606
CONFIG_DRAM_SUNXI_TPR3=0x84040404
CONFIG_DRAM_SUNXI_TPR6=0x48010101
CONFIG_DRAM_SUNXI_TPR10=0x273333
CONFIG_DRAM_SUNXI_TPR11=0x1e19131c
CONFIG_DRAM_SUNXI_TPR12=0x14141312
CONFIG_DRAM_SUNXI_TPR13=0x7521
CONFIG_DRAM_SUNXI_TPR14=0x2023211f
CONFIG_MACH_SUN50I_A133=y
CONFIG_SUNXI_DRAM_A133_LPDDR4=y
CONFIG_DRAM_CLK=792

Upstream boot log:
U-Boot SPL 2025.07-rc2-00008-g9dab0d385a9d (May 26 2025 - 19:06:29 +0530)                                                                                                                                  [1/37737]
DRAM: 4096 MiB                                                                                                                                                                                                      
Trying to boot from FEL
NOTICE:  BL31: v2.12.0(debug):v2.13-rc1-3-g35e7dd0a6-dirty
NOTICE:  BL31: Built : 20:27:56, May 22 2025
NOTICE:  BL31: Detected Allwinner A100/A133 SoC (1855)
NOTICE:  BL31: Found U-Boot DTB at 0xa0a2e80, model: MEC electronics A133 DM2
INFO:    ARM GICv2 driver initialized
INFO:    Configuring SPC Controller
INFO:    Probing for PMIC on I2C
INFO:    PMIC: found AXP717
INFO:    BL31: Platform setup done
INFO:    BL31: Initializing runtime services
INFO:    BL31: cortex_a53: CPU workaround for erratum 855873 was applied
INFO:    BL31: cortex_a53: CPU workaround for erratum 1530924 was applied
INFO:    PSCI: Suspend is unavailable
INFO:    BL31: Preparing for EL3 exit to normal world 
INFO:    Entry point address = 0x4a000000
INFO:    SPSR = 0x3c9
initcall_run_f 899


U-Boot 2025.07-rc2-00008-g9dab0d385a9d (May 26 2025 - 19:06:29 +0530) Allwinner Technology

U-Boot code: 4A000000 -> 4A094C48  BSS: -> 4A09EE70
CPU:   Allwinner A133 (SUN50I)
Model: MEC electronics A133 DM2
initcall_run_f 960
DRAM:  initcall_run_f 963
initcall_run_f 968
Monitor len: 0009ee70
Ram size: 100000000
Ram top: 100000000
initcall_run_f 990
initcall_run_f 998
Reserving 635k for U-Boot at: fff51000
initcall_run_f 1005
Reserving 65664k for malloc() at: fbf31000
Reserving 120 Bytes for Board Info at: fbf30f80
Reserving 368 Bytes for Global Data at: fbf30e10
Reserving 19968 Bytes for FDT at: fbf2c010
initcall_run_f 1015
initcall_run_f 1020
initcall_run_f 1022

RAM Configuration:
Bank #0: 40000000 4 GiB

DRAM:  4 GiB
initcall_run_f 1024
initcall_run_f 1026
New Stack Pointer is: fbf2c000
Relocation Offset is: b5f51000
Relocating to fff51000, new gd at fbf30e10, sp at fbf2c000
initcall_run_f 1055

Thanks,
Parthiban

> 
> - Cody
> 
>> ---
>>  .../include/asm/arch-sunxi/cpu_sun50i_h6.h    |    4 +
>>  arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
>>  .../include/asm/arch-sunxi/dram_sun50i_a133.h |  230 ++++
>>  arch/arm/mach-sunxi/Kconfig                   |  104 +-
>>  arch/arm/mach-sunxi/Makefile                  |    2 +
>>  arch/arm/mach-sunxi/dram_sun50i_a133.c        | 1204 +++++++++++++++++
>>  arch/arm/mach-sunxi/dram_timings/Makefile     |    2 +
>>  arch/arm/mach-sunxi/dram_timings/a133_ddr4.c  |   80 ++
>>  .../arm/mach-sunxi/dram_timings/a133_lpddr4.c |  102 ++
>>  9 files changed, 1722 insertions(+), 8 deletions(-)
>>  create mode 100644 arch/arm/include/asm/arch-sunxi/dram_sun50i_a133.h
>>  create mode 100644 arch/arm/mach-sunxi/dram_sun50i_a133.c
>>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_ddr4.c
>>  create mode 100644 arch/arm/mach-sunxi/dram_timings/a133_lpddr4.c
>>
> 

