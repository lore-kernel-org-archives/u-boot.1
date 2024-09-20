Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F27C78838
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC10A89205;
	Fri, 20 Sep 2024 15:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NKA5jz0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E142D8931A; Fri, 20 Sep 2024 15:01:21 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A238919A
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Td8aW0FYaOLH0xLKC6Y8NE93CF58iqNztMW8GhvH2fURlMIdgUwiQuWVhgVJWm26YyUKX9FECcuaEZsi2q+dv985LzTu65hdfl7V64qNPw2NZrHN3HrGPLJsRrSMuXzcrDqP2RAnVY2m+HYbD4Jo0Y6XsZbCwxw8j2rZ1bXkcZdbmzj3wYgPt8MVp7UFWFFhdA022csuabyzLvrC/EpzFQA9pIwc751d+QgRdtvZ4yjkx0n8FGAVTU4aZyqNYmLiRsaVquG7u2Kj0qSx8L68IODUWqw3sQRA/3Iyst+ZEJywHwU/fZwbw7ykx60SmO/Rum+4msk+79pksUclADAWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtXlR138igsXzMUwx4Cy2QcMNg51xrdAgmhKovzLGH8=;
 b=T23E7rzrdjs+fSQEP4+FKg/LuMg9pERQDmyv3l8TS8iahZ319FmIwneEk9n75xJB8OaRiPOxiPch/A6XeOkz2EOO6G5tM0ddxHcyKdLpPS8ONiVkbruO05SABBP1oQQJNZ9cvPXxWkD/kmM4D+VBto0+pNw0iyUY8yjiWL+VITNsLTNsRn5MdOxQGyuet54/2AVSQGU/L8gELfmgerRVz3wIG6vUGJxl6tKpbVYq34RCa6vMfp8HRvBRnI4KWH5T+CGsyLaBn62JBS9SARRA7vwZHP5t9I/KdAmF4cnF8r0zDuKinMkV/NAIg+oDd/tP6EmTPZkHvkMustFNFcCETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtXlR138igsXzMUwx4Cy2QcMNg51xrdAgmhKovzLGH8=;
 b=NKA5jz0yYoz+FDbCKXZIr9VYztKbOkPHc5uuriL/cpLE9qfTpzMP3yofgsCVE0ab1l8dzNbuGrfz5LYAj7uZQXxZMkSa1oG/yhczDWrkcIuFN4gbdr+RFnF10/4V1eRePShELMlVAjT61tR7EZAHnZajnAd9Lhh3+BKnHsozW7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 13:01:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:01:16 +0000
Message-ID: <a08723af-5072-4e43-aacd-94d31ed10339@amd.com>
Date: Fri, 20 Sep 2024 15:01:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix status property for m-a2197 boards
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <b5361e26f8bc529b897678d82d948373fa933e3f.1726127782.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <b5361e26f8bc529b897678d82d948373fa933e3f.1726127782.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0055.eurprd09.prod.outlook.com
 (2603:10a6:802:1::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b01dd8-e518-452a-f05d-08dcd974501b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0JkQnR6bExFbGNRcERkSldxT1lIMHJ4RUxmcnBTTTNNdVNNZXlYeFV5Y0ZJ?=
 =?utf-8?B?V2YwTXpySVppa1ZEeTJZQkg2Qkgvc05JWGpaVmpGUUJxL0FnRkZENkg0M2RJ?=
 =?utf-8?B?Sm82S3JGdWNlZldEL0piUDdmbHlIa1h6a2FPNGt3UFZ0d29LMk8xRmh3NGxK?=
 =?utf-8?B?RlNVWnFic1RaT0JweUE2blJhSFJ2YUxxOS9JMFFrM1QvYm4zdVBraEV6S29L?=
 =?utf-8?B?bTZpWkhKK2dsUUVOMzFTQUxwYnZJTXQwdVRqNHl3T3p2QVNGTG4wY3UyYlZS?=
 =?utf-8?B?S21yS2c3MnFkVFgyNFNXS094Nk1EQ3NzSkZBaG1MRGM2L3RMY2VjRkJlZ1Qx?=
 =?utf-8?B?NElTMUdQZUFVZ2t1Z1VZREFPT0Z5NzJidHRpYjduQmxhRk1XWlc3L0t3eFNu?=
 =?utf-8?B?SW84R0hFZ0I0NVM5WHlMZjNSVEN4YU5ZZEgyUDViNFFuaW1Tb1UrUE13cU9p?=
 =?utf-8?B?NThLY0hSYWlVcE5iYVRXdFk1YmJYdTFMRTBVazVOak1UR1FqZ1hPT2tQTGxW?=
 =?utf-8?B?N0ZQQlY0L0o3djJrMHdJZDkvTmlOMU1VbmdGM0ZmaXd5TEVCaG04MGRhTUZI?=
 =?utf-8?B?Y2tVWEUzRVp0UXFhVTVVaElJZHhMcFQ0Z3FUSkdscTNiUkRaK3hhaUZEbi9G?=
 =?utf-8?B?enlGMk5qQlBucHRZMzd1ampqTEszSS90ZkFBRVFSMlVENkVWTGpMc0JCazZq?=
 =?utf-8?B?eEV1MXlEaDNkTk5qUGVoZWdOM2dKZklIVGtkYXBOaTROZnIwWisxYW5Ca2VT?=
 =?utf-8?B?WDhTSDlFc2V1bzhlKzFEVGtEY3IzWjNPeGlGdnVrekxKbEJxbUI5dHY1R00r?=
 =?utf-8?B?QWNIbnpDMHpSQUZ4a3ZRVlgvRnRGUjFtL21QQndaQjVzRGJqeXBZTitoR1Qz?=
 =?utf-8?B?V0NucjIrTnFtUUh6K2lpK29tQzMxMEdYb2JZVGphMGdtZGhML2QvNEhnTzVQ?=
 =?utf-8?B?bVFmanhnak1FZW1NZTY5YzNtNjVBTEdiRkVFSE5xcEtPVU9SVzJjZC9XdnU1?=
 =?utf-8?B?VVd2Y2IxaHJaTGtnQnIvK2d0NE05UDZJcWNGZUd2eUozaFZnZjhkc1Z5Vm1N?=
 =?utf-8?B?MWpmRjJrdDdnc3MwanlVc252aHpRVkYrdmxlSURaeGV1ZG9hMWNyYmErZlRh?=
 =?utf-8?B?NVA3bzFIS1p6NUZTNk9VUXdjTFNvM2t4MWlCb3Z3d3FvM1ZIaFJOajVtakhj?=
 =?utf-8?B?YlhUWFZiV1lZa0swdi8vaW9QNG5wcU1zZVdTYUJOeWg2UlNlSGNoL0VzTUNU?=
 =?utf-8?B?cTkyR3lWZktydWppV2FCVFNvZXlySHRxdmxWZDdocWNmOTFNS09YZk9TNjhE?=
 =?utf-8?B?cDBVOWs4R05xZXBSZEFwSGtGbSsyNGEyNHNJaUNUTldDMHhuTEp5VnM2bWJ3?=
 =?utf-8?B?NW5jd1M3QnpZSG1lcUszZUtTL1Q2RUJxbG1SbStmMXpYaUpsS0pCMGMvRlZO?=
 =?utf-8?B?RzU0RFp6emxRSjMwUytURUoxQjB1RUM0eU5EY0kzWjdvNHQ0ZVp3UkJnYkJJ?=
 =?utf-8?B?UFJZZGNMNE50YTljcExFaysyclN3blJ2aXhPc3d3cUc4SW9qM3VVMjNvMVBa?=
 =?utf-8?B?cm96SldWc2xvYWZzQjJoZm1GbHVsN1NHUzVsS25GL1I1V2ZjYjlNNEUzV0NX?=
 =?utf-8?B?NGpJTTVRVlNudk1HU2dXSmZFWTVpY1ZuZnFNbnFJNmQyZWpMRjl6b3NTY0Z6?=
 =?utf-8?B?Tk8wemZDZ2VUZDY4QUl0OTJQSmpjQWtzTnhCOVJkM2R5TjVWVzZQSHAybjYr?=
 =?utf-8?B?dFVUMjJwaUxIekdyUGdtQWJ2RHlSOXZCdGVwL05JbEFyYmNiWE8rSGZVOEVh?=
 =?utf-8?B?TjZ3ZWNJdWw5MncrUTgzQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukw0Wk10dkx1OVprc1VONW41RjVjbnZ2VG5Tc0VVdmlEQitXNVdTOFByQ2dP?=
 =?utf-8?B?YkhEcFVxbkNOdlpKbmRVTnh1ZitPT2JlanRuL1FDR1pEOU10anpJNGQ4clNp?=
 =?utf-8?B?eWRrWlBBckt3eGZveEl2ME1wOXFDZys4dXV2dURnNHFwdzZNUW9WQ1ZLR2M2?=
 =?utf-8?B?aEVuU0ZJZTlIeitiQ000TnA3ODZnNVMwSGg5YkFvNVA5VXdkdHRlNHMzeGgz?=
 =?utf-8?B?WWR0NzlUbEd0MlkyMFY0QWZFWHQ4WUJkSmFCOE1iOTJiWko5ME5jYldVM0NT?=
 =?utf-8?B?QkNaQ2tTQ2Vwbm5sRTRubHYxMnpmRVh2NkJDcjNuUWxMMXV1Ylp1Y3Y4a2dC?=
 =?utf-8?B?K1QyMElMMmYzQ1lKMzg0S1pXTDEvRTZ5MXFBZlpFdk8ybXptNWZkRGx6U0tV?=
 =?utf-8?B?MkNRanA4MUxueVFIN2svUGc1d29tbnk1T1lUUXhkMWVSSzYzUm9tRFR0ci96?=
 =?utf-8?B?L2dqYmZBRmpiNTJISFpXSFNoOUxBaFphS2pIQ0ZMNEk4ZlQ0SklYbHFPN2U2?=
 =?utf-8?B?bkhkcmtuYTJpN3JYMkhDMmswODJNaHlzTm1BUk0zSUEySk9SU0VmSUxnaVNY?=
 =?utf-8?B?TGsvdzRqZ094ME1NUnpoeVY5S2M2bGVnOTdKUFhiNmU1bWM0elU1emMvU2FJ?=
 =?utf-8?B?ZjQzL3RFZ2FzTG5LRFh4bjl3cmJZdjVLOG1XVXVNUzhjb25leXBQMkgxQzhu?=
 =?utf-8?B?di9Tak9FdnBOa0xqV2NoWXJTYXpjNzRkTTR2cE1BV1ZVKzdaOVJKd3hpQWJ2?=
 =?utf-8?B?YTczdlNFSjhhYnRWSEdiTEpvZ0J1cURrOUV6ZWFlRU1qT2FTTWJodDBXRmVG?=
 =?utf-8?B?MG54Y2N1R2FPNXJKUitWN1JBb24xdDRHMHFLUXBJT1VRV1dqYVdqU0RuZmVR?=
 =?utf-8?B?ak01TjM3cDBXei9QTVBNTStFcy9yaXRxMmRIOUg0c1ZvRjJRUGhiZkp1MCs0?=
 =?utf-8?B?emlDQ0o0cnBXT3FsdE5qWU8rN3pzLzFFZUYveUJPb0FBQUZIK3IvNkNqYjBk?=
 =?utf-8?B?U2M1cUs0eG1HbktDZHl0eDFmQngwY29WNWZJbkRtY1pMUWFuQVFUTFQveFJJ?=
 =?utf-8?B?Tm5MODN0RFRaK25UNFZzc1A1SUVJMTNrTVFPaGphUEdsYzdSTFp0dVcwbUV1?=
 =?utf-8?B?Y3lYNnJTdHpjNFRaR2FlU1oxNnNuYmlIbXE2WXlmeTJKMmZ4eldMUW9EVElV?=
 =?utf-8?B?QXN6MXJ0c2hMQWxCbG95UThQMzFwRlFBamRsZmx4MWYwU1ZPQ001R2hKZjJZ?=
 =?utf-8?B?c1p6dHZLRkRZV1J0eHRTQ3pVOUxDQjVnS3BwUDg5dlFTc0FzVEdKTWtwVFNT?=
 =?utf-8?B?UGdkODg0a01iZVpKSjdrSHdQcVJ0dHA5emZ2OWYrTXNVTGJQd25BeGhFTWxn?=
 =?utf-8?B?VzhDMVIvTlZhbXRVWm5IL1JkKzRJNzV3SEpsdWYxWlZlVDBzUTVqY2NFVGw2?=
 =?utf-8?B?REpUN2IvVmhOd3JudUQ2QmNCNWpZQU5sREMvMEZiWTBBMmwzbkYyNEgycVpo?=
 =?utf-8?B?TGJYek5pQ1M1VnVnZ3pPUGhxTnFXbXJaSzlYOHdjODlvRDE2NlJ3bWY2U0F6?=
 =?utf-8?B?dzg3aWZJQlZ6ZGFzZXRXNFdxRXFVOWZIQmIzeEkzLzM4bVF3bVllSTI0Y0ZK?=
 =?utf-8?B?WllrVFczOXpvK20zQS9LTEQxY2hvNnlxRmw2emFURlp4TU15dkhQTUNrOGd6?=
 =?utf-8?B?SzZhNElxelRjeVIyK3hYUjJLc2VUdWpubGlpeDZZamd4QktvR3VQcVYwb0JR?=
 =?utf-8?B?VnF1QUs4Z1pRQ04ycEdhUHBld0FpTXNXKzU2VUNHamVwVUwvUU1wMCtpK1dn?=
 =?utf-8?B?MVNubG41S0ZqSUJib0lEdGxLN2NiTlpVYTBZTmhjb2cxcUJCcUovemtjT1dk?=
 =?utf-8?B?b3pBa1ZmazRWR3hjY0VIcDBEZFBkYktLOG5hR0xIK094N0dyZ0EwcXdqWGdl?=
 =?utf-8?B?WUF4OEg4dGNpbHladHc1VmNLQmZ5M2xacllaUjRVV3dsMHNDMWFmd3BkYWt5?=
 =?utf-8?B?SFNpQkZiVlcrODVob2F3Y25VR2cyQmNPcS8ydzE2ei9XTnFIOTZBb3ZLUGVr?=
 =?utf-8?B?Q3d3dzBjK3VqUE5MZ0VzbDBzZjBrMkNpc2RVS2k3Vm15eEIvL0h0Z1lsOUJk?=
 =?utf-8?Q?w2JAtLPr4lyZ/tN0OSmYU2d8t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b01dd8-e518-452a-f05d-08dcd974501b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:01:16.5494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDgL6fTtojgorfAd9aUH5ZdCUhfvB8Zd1mxJ1AonVADD0o8C7oYaJuvvv89k4UYx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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



On 9/12/24 09:56, Michal Simek wrote:
> Status property should be missing or okay or disabled but not just disable.
> dt-validate is reporting it too.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts | 2 +-
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
> index 83b8a98d80ca..38be5a0f96f1 100644
> --- a/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
> +++ b/arch/arm/dts/zynqmp-m-a2197-01-revA.dts
> @@ -101,7 +101,7 @@
>   };
>   
>   &sdhci1 { /* sd1 MIO45-51 cd in place */
> -	status = "disable";
> +	status = "disabled";
>   	no-1-8-v;
>   	disable-wp;
>   	xlnx,mio-bank = <1>;
> diff --git a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
> index dd37b726d3dc..3c04da1c5fbe 100644
> --- a/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
> +++ b/arch/arm/dts/zynqmp-m-a2197-02-revA.dts
> @@ -97,7 +97,7 @@
>   };
>   
>   &sdhci1 { /* sd1 MIO45-51 cd in place */
> -	status = "disable";
> +	status = "disabled";
>   	no-1-8-v;
>   	disable-wp;
>   	xlnx,mio-bank = <1>;
> diff --git a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
> index 811cebafe9e6..7439a2f872e5 100644
> --- a/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
> +++ b/arch/arm/dts/zynqmp-m-a2197-03-revA.dts
> @@ -97,7 +97,7 @@
>   };
>   
>   &sdhci1 { /* sd1 MIO45-51 cd in place */
> -	status = "disable";
> +	status = "disabled";
>   	no-1-8-v;
>   	disable-wp;
>   	xlnx,mio-bank = <1>;

Applied.
M
