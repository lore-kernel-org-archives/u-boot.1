Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FE2C7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911DA89431;
	Fri, 20 Sep 2024 15:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5lSd+sQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB84889434; Fri, 20 Sep 2024 15:33:30 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE32B8942A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLmVM4eAgHRCUIW0F05iRYTVlrRhQls7zW7qBy5UlFmCRDaZc8SI/i0mLrKTqfKvXz8FqgtligyJXsVaGzKkWF8XdnGkOzXPQv7rz41RGARjL2xCjcbZe2hPvesqtAZ22o3LOHeAP+cPvuRpjk65DeNjSzaMUM7lV/xR500HPZQoVIqh+C6rSWpBTMVTwj2h0w9cBsnm89uZoinhUv6XMLb2kflpKHTdm+wVnQH6ACuXYb9By+nymIeoboWTdMA20VKjE7rGoxJjOo/8orzP9BgOPHFHRYeAmhw18rP/jCp19Yxk/LlY6zyt5hMtSiS6KW6EAUfOzZkU07m+cyh4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iryOGM1bH1H0Vsaug/6tU/17iU/C44SqDGDm4Idm6e0=;
 b=JNLjWnE3HGbhytTedcGHuvSBBU/KEshXMD9Tb9vwBGecWayDcHKTayQvREHYve/cIWpkuFVIuBEAMVIXQHmlzyFhSTxGFpQs8SFlvkAwpS0Vu9ilVtu7BgR8A1FJhxYqQkApSYSo2coQ90Ry3rTTQOeP1Yym1rAfTwrzgyl4BrdqcL7Neh4uQBPIym3niEh6sgPnwlLMP60+hnnwoqfRDKWTqibzm78LnvgPt16UPzu3BWjE8rEDUbmzIy7sQcSziwHoZietCQ0Eq19AdJr3jhCGmqMunWpeG0TPrYnckbpfOQNBgH31wA44umWVrjBt/M1OsV/i5kLd77/p1Ho52g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iryOGM1bH1H0Vsaug/6tU/17iU/C44SqDGDm4Idm6e0=;
 b=5lSd+sQQByrr8yjaWnt7Z07VDX/1UrP4fATbiUKz2zrQdzkbTieBouMKfLAQHB/MBq+qfS1xyRQQyXrWqX4uxklyLGvP+GNa1kJlYsp2sRm9+gXg7FF4xCMrCmvW7n+XXF7OrUdxdw7GkBa5eiQmK6tGPmbfbHTWUozvSLkTwJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 13:33:24 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:33:24 +0000
Message-ID: <910a6dec-c683-41a5-973b-afc94066739f@amd.com>
Date: Fri, 20 Sep 2024 15:33:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Add bootmenu support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6193d95a9c0f3ae319a900b46d6212f7ab16aba4.1726041851.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0113.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b70361-34a1-4ba2-c6ca-08dcd978cd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEFJSmtTRjBPdzNLdnE4Q3Y1YURidzFzWTBGeURYL3JjdU91bTRkeW03M01r?=
 =?utf-8?B?WjFBaFA4ZnREdFhHc213dnorRzBzS2VRY1RQSFpqVnlqelhHUGpLQ0ZmV2xT?=
 =?utf-8?B?azRZSXpiWElwOERCS2tiMWU5UEgrTWx1QzdPdkx0ck5UT0VYL3pvWjdaS3g2?=
 =?utf-8?B?VEhKd0lvTW5NOFBvd1NLOEVlT2FIWG4rNjl4SXFXUmU0YzBydExjNDhDMDRp?=
 =?utf-8?B?RkRqVTFpajNQaitCL0IwQ1J1aWVLNUM4N1hSSHhySXBOb2J5TlRJamtEdy9h?=
 =?utf-8?B?KzMxb0EzQm8vSWJCZmZDRDg1SnRYaytyOE1YektrRldJNFZ2MmdWbDd6enpO?=
 =?utf-8?B?Z2tNTm1sMVBMamdHc2o1M1pRd0hQZlRraldxMUpBaXQxKzRaMm5ZM2lINytF?=
 =?utf-8?B?ZUtnZmFHc0cxd1RDdHdhSU5kbGdMRkF3alRBNXlZRXlZSkEzV09nUFZWTVQw?=
 =?utf-8?B?K0tpR2ZrWGlBTExYZzk0MHI5RXNPYkFGbDRjQmRuRlFNbThVVnM5dW9DZ3lT?=
 =?utf-8?B?Y2xoZFg3cWJ6a212TFZFNzNTb3NON2N5TUdWdjBzbHQ5TGtZck8zNEN1cEo5?=
 =?utf-8?B?YklKMFEwY3JXT1RFMUJjVkRGYlBYUjJDM3BHNU1UVVg2dHlrN0cwQmQzYlBy?=
 =?utf-8?B?YnVtRUtlVW15QVJtelBIdTBrYUJMT2tJbjdmcmdzVnZXQldVM1QxdXFIVXdI?=
 =?utf-8?B?SDJ0Z3piLzV2cVYwYWlOWHlhU1VtbzBYbFk3K1pXNzEyZnVsREZ6TVNISW03?=
 =?utf-8?B?aUFwZEJ4TlA2NnZiNnMzRmFkMjFvS1IwQkI5bk5NeFB2WXNlRUZZL1NrT1dj?=
 =?utf-8?B?SjFoSVpJeUs2NXpZR0tsNkZ6TkdaZG9ESmx0WU1ERmZ6ZTlMZlNzTGNBL210?=
 =?utf-8?B?LzR3OEZpS08xMExyYWtqenNrVGJyV2dTSWhsMENaRVFTRWFRMmNlNVVIbGpI?=
 =?utf-8?B?bEo4Tkk4NElkZ0FLSVRmY2NaZjZWUFVnLzJPSFFHWmgrQUJEamFsbE8zOHRN?=
 =?utf-8?B?cWpES2pub282Mlg4bUNYQlNMVkx2QituMEtpUjF3cmdDanBiNkVKcVJrd1R4?=
 =?utf-8?B?YWduMm1ISEtVV3l0SkQrZnAzeW5sZDNzZTJQV0h6UjJzOEZTQjVLK1pZN1cw?=
 =?utf-8?B?VEdnczBPTlZjTUFYZ2xqQW0zTkJ3OXYzVUljNU00bXhHbG1WdnQzYzV4SDdX?=
 =?utf-8?B?UndLZnNXc2VRL0plTHdFU0hUTVlkU2VaR1VnaE5ZY2p3OXFCczdDdTFqcDR4?=
 =?utf-8?B?eHFyMGRFcFMyRkljSzVkR0dGYlF1eGVPNysyVTNoSEtsbFNMQk9hMFAwWHIz?=
 =?utf-8?B?YVowdStmLzk2QU9WbC9OdWxJbzU4T1ZHeGdQOGFaZHlXMUpvbGdWTzJjY1FH?=
 =?utf-8?B?RWZaREpBcEtDYjJaK3N5bmJxaVhyTXByZXlxaGlmMG9VSUJqZ29WYTZzRk9t?=
 =?utf-8?B?RVJJcjZKOFJkd2RPa3ZjQjg2dG1iUkt4Tzg2b2dJQmliZXdXbXM3SUo5SUZn?=
 =?utf-8?B?enhqVVpXSnJ6aTR5eUg2OHJFVTFrUXlFVjJLcDZXbkh4L2U4Zm80aXZsNzRj?=
 =?utf-8?B?UHFJRWJiYUZrT3J1VVNrcExMeFFKczhFbkFtZjlBYWZtd1VnSE5GT0J6MTA0?=
 =?utf-8?B?QlUwU2lJVE8zcWxLeVh0WmtlaTRZZzMzbzBDK3NsY2hkWjZNOFlaYUsyVWd5?=
 =?utf-8?B?YnZOTFlrWE00dC9IS0hnM0NKSUdmSDRHK3RweUV4YUlUd1NSK2FybWVlNHhX?=
 =?utf-8?B?d29LY0kyVHFXN0xCYWtjMyswMldId1BvbWR3dURzNkQvNUUyRVJ1R3JFOVVm?=
 =?utf-8?B?UGhkRFJMaGFEUzEwemNXdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUIxWnRWdmVWRXF6UE05TTkzSmdsVXdRZXRPZEhVSS9OWU9mMytyWlhNdFF6?=
 =?utf-8?B?ZEY4Q3ZjQ0NtY2I1OE16S1A1UkxSRDhwTVBmLzZ3Y24xWmZmRCtnY0pqb05M?=
 =?utf-8?B?QjFUWkh4RjliSzRVcnNLSkc3ZGQwV1JxckJ3aDNCelBSdmFSUnp1ODNyaU42?=
 =?utf-8?B?OFpJTzJ5UWc0RUV0eHVFK3FMcS9OTDVkeFFGdFRFRm1iNWYwVUM0Zy9PM04r?=
 =?utf-8?B?eWxYY2Ewd2FXMDlueU11ZTR1d01ubklUOElYQVRjdlNZeVBwUVFNUzFTbTNV?=
 =?utf-8?B?YTFpR3NrNHhVQng5OSs4d2NQUzdOUkV3dmZGRlUvcXJ2RmR2cE9QdXRCWWh1?=
 =?utf-8?B?UUpvbndBZlVBM0svM3RrQVlLci9aTGZqczhKU3B5OHpiUzl4K1pZaS9BaVJl?=
 =?utf-8?B?Z2VWVFBrcVUyTFJRNlNDbXM2T0dic05RVFdqTnNPWmM2M2M3eWtydjZJK2oz?=
 =?utf-8?B?cklnbW5penVoT3RKQnhVbHBWSytob0xjUVNnWnRETTg0L1ZFdmUxbFZnKzJS?=
 =?utf-8?B?OEpVcDRwUGJ5cW5TK2llNDJkVkpjeUo2NUZxclJhY1NmWllWSzNnd2l4ZGpO?=
 =?utf-8?B?b3RWeWUwNnZnQU13RWZnN0ZlUnUzNERVS0FrWWNvZ09SOUdRMnAxc0ppNWxs?=
 =?utf-8?B?S0l1K3B0SDAyOStsdHEySmZUUWZZSUVDU3pEYmwvbkwrVGdoWjFhR3ovOW1a?=
 =?utf-8?B?Ti84UWEzTUlMc2p6S29EeHB0Z2ZzaGhxVXova3dMZE9zMUNTb0E3VDF3SjdV?=
 =?utf-8?B?dk0zWktnazV3MTJhY3RvS3lidWdaRWdiT3RaN3EvdHBGTW15S1Fzak1od3d6?=
 =?utf-8?B?MHRTaTF6dEZ2amMydit2MUZJU3ptc0VmNlorT3A0bDFpd09hTS9Sc013WFZk?=
 =?utf-8?B?SUNTV2xPRTV6U1gwN2JrQnVHNU1OUEltdXFBMTk0YzRobE92S2NrR2RyNnlK?=
 =?utf-8?B?d1dtc0ZRaWdoZXdCZDI1bnVRdm5HbjY2YWsyN1RkRDhxMTEwMDB1cWM2Sms1?=
 =?utf-8?B?T2JxNE1ZQWhoWHJ6YzMvd1UvWFdWcDl6cjBKM0k4OXltem02RWxuU3BubU5Z?=
 =?utf-8?B?Rlk2OEZHK3F5bDFMUTVLZXdkWDBYeEQ3em1BTi9yd3Jkd2I2cHlXRnUrL01h?=
 =?utf-8?B?MytEUUd6Z0IrUmdFMFM5MC9OTGZINnB2UEZpUG95UndTZlR5WndjRWZuWFpS?=
 =?utf-8?B?clAxbjl6ZTQ3eHN2K2o1UENycktLZjBjWXFGa3ltKzF1MXY4cDRJWlo1a0Nh?=
 =?utf-8?B?VXMrSE9lRUwwNmdLaW1meStlMFZMSVBYV0g1bXppZGV2ZVZKa0kwRHNScGdi?=
 =?utf-8?B?a25zSC8rTnVHWENsWHQ0WFE0TW1VMnQxdk5EMVBFUjF2a1E5M0phczRiVXAw?=
 =?utf-8?B?TitINVBNeStyd0xhYTF3clY5eURXT0tCNnlQUlF0aHE3bWVsWk5jSFRUVDdZ?=
 =?utf-8?B?c0pFenhaK1ByMzgydlRYQ1FOWVh3R0kwd1lYVlpvT2pzRndScndSWFpJd3FM?=
 =?utf-8?B?TnljWGRLbmhLN1BiUTBvWTU2M2ZOTnQvL0kvNmhXTy9wRm5sYzNMWVFuOEJH?=
 =?utf-8?B?K2o3WXZvNFNvQWRTNFBpSGR0bE1hVjRsY2JCSUZpQ21VeWg5MjVqUVQwczBx?=
 =?utf-8?B?RktaMVZERVVHaWJyTS96Y2wwRXNhVTYrcDZ4ZHk0a3FtYS9zK2trUFlSNzBC?=
 =?utf-8?B?cDBVb2l5WXJBaEpQL2VHTDJ6TDYxOERrKzhDaDNQazQwOHdCL2JuT0F5RUlk?=
 =?utf-8?B?a1RqKzFmVWt6cTlpWkhjY1VEcWRlZ1AwaWVYZXkvdldxZzdlZG55cVNmdDFL?=
 =?utf-8?B?ODVKN1RldHJQUS9QcXNicjcyalZ5Ry9pcS9XMHU1QmRpRHRUbXUxZVNoYW1I?=
 =?utf-8?B?b05GS2wyT1lrU1RrQXVwTXdtS241VXQ4bFY2eStpb1dhOHhYMnp3NzJvNGNG?=
 =?utf-8?B?aXJQb3RkRy8xdlREdlBUTEpaTVRuZDNZTEVraFpoYkFXODEwbGdHL2dUamxU?=
 =?utf-8?B?dlRmRnFiYWYxdnh3dFRRZnB4Rmd5RkZZTXNzTnVEZHVMS0J4ZDg3RnMxcG5P?=
 =?utf-8?B?b2taWHNRdEswZ2hvL1lBb2hEeHdSK1dJaFNUT1ZvMGhYOEkvMUJEblMyU1pC?=
 =?utf-8?Q?s1xfEJiFUpB7V4RoC1VodFPWA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b70361-34a1-4ba2-c6ca-08dcd978cd32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:33:24.4313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2Jk6xcML7R0KSuNgqAqgFLC5GyY/Fohh3Hm5ydECoy8fO2SMnWiZvlvug9kckyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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



On 9/11/24 10:04, Michal Simek wrote:
> From: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
> 
> Popup the bootmenu for 5 sec with default boot options to CC on AMD CCs and
> default to SOM on others.
> Users can anytime disable the bootmenu by setting the variable
> enable_bootmenu=0 in zynqmp_kria.env or setup it up at run time and save
> variables to NV memory.
> 
> The patch is also fixing issue created by commit 4c7363068651 ("cmd:
> setexpr: fix no matching string in gsub return empty value") which has
> changed return value from setexpr command (Before this commit when
> matching string wasn't found command return 1 that's why was possible to
> use with if).
> 
> Signed-off-by: John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 49ef3e7d7532..d0e431ebb46f 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -49,9 +49,19 @@ usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
>   som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; fi;"
>   som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
>   
> +# To disable bootmenu set enable_bootmenu=0
> +enable_bootmenu=1
> +check_cc_for_default_boot=if test ${card1_name} = SCK-KV-G || test ${card1_name} = SCK-KR-G || test ${card1_name} = SCK-KD-G; then setenv bootmenu_default 1; else setenv bootmenu_default 0; fi
> +som_bootmenu=if test ${enable_bootmenu} = 1; then run check_cc_for_default_boot; bootmenu; else run som_mmc_boot; fi
> +
>   k26_starter=SMK-K26-XCL2G
>   k24_starter=SMK-K24-XCL2G
> -bootcmd=setenv model $board_name && if setexpr model gsub .*$k24_starter* $k24_starter || setexpr model gsub .*$k26_starter* $k26_starter; then run som_cc_boot; else run som_mmc_boot; run som_cc_boot; fi
> +bootcmd=setenv model $board_name; setexpr model gsub ".*${k24_starter}.*" starter; setexpr model gsub ".*${k26_starter}.*" starter; if test ${model} = "starter"; then run som_cc_boot; else run som_bootmenu; fi
> +
> +# Boot menu
> +bootmenu_0=eMMC Boot=run som_mmc_boot
> +bootmenu_1=SD Boot=run som_cc_boot
> +bootmenu_delay=5
>   
>   usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
>   

Applied.
M
