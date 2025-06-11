Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6804AC678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 14:10:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD98882B63;
	Wed, 11 Jun 2025 16:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nhhrPS0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E58082B63; Wed, 11 Jun 2025 16:10:46 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE5BC82B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 16:10:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPeK+Sn41As5EJs/zxJF+lm1Lg03PiFTIkQWJZGDgcoF0MuY9HX/4L18CFhqjo7dL/bojZHqlq8jRBa+xcAAMxOyOADVvdPhGbc39OzrkGEhl7g/WjrIjUdxcPurvNfYrxOpYXoDSV1i0pLZiDbObE+YAU9m8fP9EBxCxCzgCz1n9x1AhxZv7VnmDTglC2qkWSbMWHZtmDXrFp8HpdmKETuoMgy+7fY7smQ+1I/E/anTHQ7+Ol99gPDOuTDSUIveBu3xAlnjTCeJk+4gu26Xj5RP1uVc7zWz4CSKcerN3gDa+JTtcIvd1lbBhjOq2LeijQjzqYnugjBFUHok/2ZpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1mv7FSArqxvWWVxbY4p5uGyxd+wAMp8HeZzqqXUFzE=;
 b=WdIGtx21NdIEASAnp+T0MEHqOUddeffV4pwUIGldnS4wMndLsrQ+9jtCWJVA528q28DmstaSlD2XxtGB3uPkiAcRy2NSnidkSfssoxN61OTse3npXGQPw6Rzl/PtX/brOxej+bF3KiJvdXvIJnCywrn8ec5RmuC9jhvVKcxdMpfbWy2ktHmUpx7ETxWvK3jmtiSYjv8Zw5IU8x8t5zefYKGyQ2BrQtpU6D5NvBsMTPlrY5von1ZqkbzfEqan0ggTF/B0eAwqK3LTEiQ9Rp6Ci1ffmVlwyaAvAh7UInJJ0lTaKLbgorjxNVHRYQkdYpW7raW147ZSmH1Kggfz9uB3NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1mv7FSArqxvWWVxbY4p5uGyxd+wAMp8HeZzqqXUFzE=;
 b=nhhrPS0mP85Az+5WOGb+e9hfGslSpaC1fpkGEet4pLueXnVX7y71Ff9Lg+Bs/MU4CP/mKJuZe5eiv2yCH9q1+JC4XvUimlZFvZGPpF3jdocVVARbl/oU1XW4M+zwv4plFPbYtHHc0g04YS5GZDCeGet3OzJlnc8qSMgTM3l7DUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10866.eurprd04.prod.outlook.com (2603:10a6:102:488::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Wed, 11 Jun
 2025 14:10:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 14:10:39 +0000
Message-ID: <ef436682-108a-4b3d-8017-531f81776877@cherry.de>
Date: Wed, 11 Jun 2025 16:10:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: add "config" command dependency on gzip
To: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
References: <20250611130211.24352-2-m95d+git@psihoexpert.ro>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250611130211.24352-2-m95d+git@psihoexpert.ro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0145.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ce::16)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10866:EE_
X-MS-Office365-Filtering-Correlation-Id: d71035d0-61d9-4b87-d854-08dda8f1be69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXk2RzFwdVgzbnhCbDRXQXRaOUR1NlZpcmpqU1FBNlZYM0tpZjFmUWFHMU8x?=
 =?utf-8?B?VjNZdmhENnlmSTF2MllJUlRWQ0ZUU2Jwbmw4UlNMVWNJeExPcFRpMzh3MGtH?=
 =?utf-8?B?VU83Ulhab3V1MGU0UTJXNXoyY29zUXZXckR0aE8veDNaeXc5bCt0Q1E0M2xS?=
 =?utf-8?B?VzlJZjJ1OUNMcTI1cnhJaUMzbmFrSkpNc2hSRnYxZWh4NDhsSElMRFozT0wx?=
 =?utf-8?B?ODNSTGI4aS8xR002Z1Rhd21jeTF6Z2Q4QUFPSkNqV3ZUamwyR0llWFNVbjBG?=
 =?utf-8?B?UUVGQUxHY29UZ1NBMks5VzBBdTAwOGlFSDVXcDVNWHcyRWRKNzRwa1pLRFFY?=
 =?utf-8?B?KzMxamJ2YTlhU0JsT04rK1EyRHROaFVQK1U2bzN3SW4rdGF1dTYvOU5aTjQw?=
 =?utf-8?B?VTlFNTRCWTFVcnFmWUdZSllLL1hiR0NTbzdmOHExZW1JSzZyNFlzWmhLR0Np?=
 =?utf-8?B?OW80NjR5QXY0bFBlY1FHZnFVTWxTY0tmUk5BU0VMRmlSK0F4d1FMR0l1Qmxq?=
 =?utf-8?B?UWtNdW1zeEFqdzJDT253MkJTY1JySUhoM2FUY09wNmxTWk1ZaXNZd25DdjF5?=
 =?utf-8?B?bVFaQ0N1emVzdDhJOGYzemZYL2JIZ040VlRBNjVuNVF4N25zR2pCRDlUNVJy?=
 =?utf-8?B?b2lFYm15SXAzNE5kMWdqc1luSUtnZS9nWklsNmI3MFNzVWJDMVdQbEdFTi9K?=
 =?utf-8?B?N3VhU0FpRm1HUG9tcnJPKy8vazRNNDFIbE1CQnI2TEdMNHUvanhxdUF3Mlhq?=
 =?utf-8?B?dFVOVE1vVGZBS3dhcU5jNXpMaGlqWE0xUEtOTElvRmdyZDlMWDJYRFIrUEVK?=
 =?utf-8?B?RWU0WHVIVHU0YzhhS2JELzdJT08vTTlJV2NFNHhlTFVWK1RUeERVZEI1K0Q1?=
 =?utf-8?B?ZWZaU2tvUW1TQXZ4TWpQQUNvQ1ZmUmVicXBOb25FU25pN0p1Uk1pdWpZZTdz?=
 =?utf-8?B?cThKVEp6aVZrRFpXQlBaTUJoR2lSRkhyWEM4a3o0cFZpZ2xrSnJwZWduVG5r?=
 =?utf-8?B?cXFqQk5RckdEVW5mTmgwcmtLeTVSUE1PSGQzOG16eXAwVDQ4cmtQQ1dMZ0Ru?=
 =?utf-8?B?RmV3aE9YTHl5emxCWGIyTmtOekxiOG1GVkFFZWlCc0YyNFhGNXpCMHo3SGlD?=
 =?utf-8?B?QkNBZHRsL3ZFOUlNeHhsQXNsYjJpK2tZK3BKOTk1b01mTmZiRzFVd25RNUp1?=
 =?utf-8?B?UE93TnRZbzF4aEJycXN4b1B2UWlRL0FaRDZkWTl1VURHU0ZPY3dnZGc2YzI0?=
 =?utf-8?B?WUxnZWtFb25xMFBIeUp4aEgwL2VaWDR3WmhwSXIxK0xVTllwV250U2tOb1N6?=
 =?utf-8?B?SThBQk5NM0ZvOWRma0t5cnJjS0YrRWpiNUF6RFNvUEpUZmd1NDdEbkNsajY1?=
 =?utf-8?B?bU5zdHkvRmF1ZC91em1aUTJmOHJpSkdITVNCWDNpbVlBUlN3OFFVeGxBTVhV?=
 =?utf-8?B?NGhEL2dsWXkvc0pubFVCK0NQVCtrTTc1RXZDVE5pVkRXdGFHUGNaRnA5eDJC?=
 =?utf-8?B?U09MSXkvcnBNQW1LeEE1dWpXYzJvbEx4N2dUOHAyOW5kdWlzYW9kYmFwc0pC?=
 =?utf-8?B?UnhJZFkrUVBEN1JWbEdNNzQrMFVrTHlmdU1EVTFlRFcrQlYyQWFBZllaNGZz?=
 =?utf-8?B?QUM0V2xqQmJrZDdpdDl2cG51SXlBN1h2aVdQS0ZQUFozZWtHWFV0VFJWSzZk?=
 =?utf-8?B?YkpPZ25zdHY1L3daSVc2YTVOQ2dNdzIrLzVXTjBQazdrSjRSMzRGOFd4MnE0?=
 =?utf-8?B?Rkx4dGg3ZkwzM2VOeFNMQ2pkK1NOSTBjWEFXK3ZpOU93U0pWSG14WHZ1Qmhv?=
 =?utf-8?B?c0duY1RCMXpCNC9MQ1VnNUxrSWduUzhJZ1ZSZ2pvMlE2M25sYVkyd1F0Unpo?=
 =?utf-8?B?bk1uWHpDS1pYSlpNRW8yWFRlQkVjTGF1azh4eXVyTS9PdXpCRVNRT3dOdFNX?=
 =?utf-8?Q?KEbmkorzu8A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lIOGdXeitwUFJIV1pSbGpHcEltQ2QrVE1lQ1JjdDFnTmdkTTJxMWpFckN5?=
 =?utf-8?B?MXlCMzc1NTZPcmgzOFYrWjBIeFdqWUVBSDIxbUdJVE1rRDIyWk9rY2t2MnJC?=
 =?utf-8?B?SDNFc2dPcE9CVFhreDNjd2xwek9QYStueE4rbEdhVnV2bnZTMGFYdGZjNHZI?=
 =?utf-8?B?alVvWnRSdDhxZmZwdlllZ3FHdGxjcHZkb2dXZHRLOFNON09xWFgwazJZU2Uw?=
 =?utf-8?B?TUdHMFdodXJORktGTzM2eWNsRzBRZDVkYlZqL3lmRWRuUm5lUDd5MjhTRXVm?=
 =?utf-8?B?YVgzMExab2RwdUJ2QUNjR1NqM3FKUm43U0tlWmREaXZibDQ3T1dBTGpCT3R6?=
 =?utf-8?B?UURpTitOUTQyR1hmN0ZzSDVlRkFPVlU0eFRsb2M5TnRoT3RaZDN1b1pzL0xY?=
 =?utf-8?B?TVppWXdMeXNzbXhtaXF6ek9VOFcyWmFXNFlVdnV4eFBTUEh6L2x3bXRIaUJs?=
 =?utf-8?B?Q3p0djcyWFpLRnBWcm9KNWpxYXpwNkFJczJYUWpaWGE0b2V4N3RIWEZVR3JH?=
 =?utf-8?B?UndGMDhKNjd0R3IvMHp4WEtrdjNIc2lmV1VrSnduWEMvMEJGcmJUeDlyaE95?=
 =?utf-8?B?ODdpaHB6NFk0R3hkYmMyeUNyeW96dTd6Zko1MDJySjB5aEh1Y2JDVkkyalhQ?=
 =?utf-8?B?UmlnMkNEL3gxL1ErdXJPLzNNcGtncWcyRjRlWjhnSmVlM0dmZkp1YUdGUmhs?=
 =?utf-8?B?dHo2K29xazBqclV5a2EwTmU4bXl0bXBxN3lTK0FneU9kYi9PZjdUa01jMFoz?=
 =?utf-8?B?T1NpOFkzL0JDZFRJUTA1YllDbDkrTzNhM3p5N0EveFNCbGIyUTdGR3lYbndL?=
 =?utf-8?B?Z0NaQ285N1BKY1kxZ1RzTDJuUmtTSXc4UU4xamlDS2tMZWJqUGg1L0F6SE1r?=
 =?utf-8?B?Z0M1THRKNE1YeERMbytVTmcvRGFHdXZoU0JuWnJQYnhzb0IyVndsZnAxb2h2?=
 =?utf-8?B?aVFyYS9zMWs3Z3RTMmlNbkJ4MFJNUng3WFVySjFoZng3czJhTzB4NHo5NUJN?=
 =?utf-8?B?cGtyOTVpd0RaSWIwdzFUY2FTcWFFcmVHblZmeTZabUQyYy9VSHN2QmRFdCtD?=
 =?utf-8?B?bjlwb3UyUFhWQWJFZ1RrNTNPR01OdjNkaWVRWDJtcHdvY2VlNnRteFBkM3Bm?=
 =?utf-8?B?QnJ5cksydk10QjJxNWNqSkE5YjhlOS9mTC9KVUJITTNRZHZHVlpmYm9sd0tO?=
 =?utf-8?B?V00yUTRJQzcxeHdTcWpSL0lSZzFRTzlST1BwUlBNa2F3Tk1pZUNPcC9ON3dl?=
 =?utf-8?B?b2REYm1RTlp4cnJobDRDbzZtMkVBR0NINEZyU2dqZTdCdmVUQ1ZOemZVeHM4?=
 =?utf-8?B?LzVseE95czliUVFERGJNNHRkVWRGdC9Oa0tKSTIxbUY0cklkTmQwbVBYNnNi?=
 =?utf-8?B?TXdxZk1TYm16S1FOdXFDK3RYbG9YQ0VSODRidnJwWGNXTU5HQ0d4alNtQ1hM?=
 =?utf-8?B?bS9peTVSY3NKRTdWYjE4d0FVYnVnZ1VmOUZoNXdMVVJsOFI1OTVEVVdxbzBp?=
 =?utf-8?B?Nmk4ZkVtOGtpVWpPeXRwTStiZHJOT0R0WTV3TW9WVFlXZEVlWXlnb3NOeWlW?=
 =?utf-8?B?QmU3SlA5NDJYWWJYaXZ2Si80THNkZFBlVDRCZUVwZDhaNUYwdC90eXFuTGdy?=
 =?utf-8?B?aUJ2N3BVWHZVdkVMcDZtaUJnMStpL0Q1emZpU0dJZFk2WWNpa0tDN0xLUWFT?=
 =?utf-8?B?Y0Y1WmN0Z2ZEMEl3UlRlbjdQTXo2ZnZBVjRKSjRqejZtMTNMZEVMdFR1K1ZL?=
 =?utf-8?B?S25DZ0NIZEFnM2pDOWM0Zis3SlYzYkUxekpKaEJ3bVBuYkVxZmU3Vk53eHNQ?=
 =?utf-8?B?WForbjRsZ0dYQkVvNnFBeFhpME42dlNIMzB4ejgvZjBES3c0QU1jT3hRY25p?=
 =?utf-8?B?dnBUaDRHN00ySEtRSHBtZ3c5K2RHV25vTzJWVVpINmxaTitSdi9KMWlBRWJr?=
 =?utf-8?B?cjNPZlM1Y1JoWGU2clEzeitvTWxjY0xiRW5SQzk0cTF3dTc2L003K09aNFJ2?=
 =?utf-8?B?QVNYcTBsT3NsbnZpVkh5Z2FTcjlab1REdGRkWDFLS05EOWtvdXQ2WGFUS2N5?=
 =?utf-8?B?VTZIWE4yYnpnSFJHVVdjOWh6bXJtbjB4OTBCbXBWbjc1bDExempuNDNnUDc3?=
 =?utf-8?B?aVo5SDdHdXdhYStGRy9ObWVpalJINkhpZnZLYktBN3RzMHpJTnN6dTNZa1FF?=
 =?utf-8?B?YWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d71035d0-61d9-4b87-d854-08dda8f1be69
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:10:39.8602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqh3o2ihen2OFpaZDhIHrJM7iTLDqWDs6lLff4OnD/+vktv5HJXJZOu7qUE8bSZWLbz738S82fXTdbkWWoPOaS6S6QASQs0PAFl+5MZv+pU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10866
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

Hi Marius,

On 6/11/25 3:02 PM, Marius Dinu wrote:
> [You don't often get email from m95d+git@psihoexpert.ro. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> gunzip is used in cmd/config.c
> 

Indeed.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
