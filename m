Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CEEC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 08:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20115828A2;
	Thu,  8 May 2025 10:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ESQEzBYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F664828B3; Thu,  8 May 2025 10:04:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB0882162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 10:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqe4t9EhGq+liXGgfiQI7g+fcS2zi0L7tNyDfTto8Wdfg8jiCmQZMIQ9uxRRA99B3UYq3jEQEcrKDbkJBzbzmPLeuAB0Pfh/+/4tN7Ui7qrvnnR85bXWoesbncWZ486RP/FQTTAK9en/qRT1oaH3YMRHkJZiLaui9RPl8H93gp/50bAtu/4LkkRASmNQ5MyMIjM2rZ8B/OTmzNt2XUZAJOqFOyiygP5kbRpW4lZDw6DSYowgy7na7VlZjaYGEfL9PawaQdBAEgTbju7fdrg+xbb+xG88lV23qQfLYR/cwTmxuAbD2sQKxc49ek4RmV/N79Mbh7Pae3L8XbRxdBQmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYh/qyC7asCtLY0PbwneNETcda7ysSO73wDFWw8Px5Y=;
 b=ped6Sytw/4eaua6+pG08a6pAzll3XoUrwkeDphScFDZgcHqK53kGfYHXZD9tqnpYdoYi3mILBgNffLT3q5lA5Areg6ekEnkn8lr/oMBacLAVkZXWY7F0thbnk/8l5O3io6MDj7K9ub4yp75wgeQ4rssWDObwgfBdbTjTNclHy0O2rcyC+Am8SXqYBtNC9PjpIpoRVHqBPX0cK6qiDyJ4RlfDgEVam5KNMmjJjVL8dZtqaINy88qrKiSsLR7+LCVxYZMliPF089782TteMRFKOdIPMUTLDZxpDXoNh+qjvprp7btLkxLEMOg4zAqq5sG5loz/l4gzWKgDVJxrJLcFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYh/qyC7asCtLY0PbwneNETcda7ysSO73wDFWw8Px5Y=;
 b=ESQEzBYzgVQ5vO0sjhWPGzAwRat20kD/dv96HyIyGDv6WMj94OLbJdYLiFbHzxm46uVRy6imGy9e43YSujfZpqDZ84wBLysSf+iizWa2//BCUdTJs1rMtIv+3fnIkvOLlBj96p+qlnLNlGuIdfvLojyWH545PqyaIxiyPYHW+/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7820.eurprd04.prod.outlook.com (2603:10a6:10:1ec::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 08:04:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 08:04:38 +0000
Message-ID: <22ceae3b-1d20-4871-930b-593fbd49b87d@cherry.de>
Date: Thu, 8 May 2025 10:04:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Adding Device Tree Overlays for MIPI-CSI2 Camera and libcamera to
 u-boot in a buildroot or Yocto Build
To: u-boot@cairnwater.com, u-boot@lists.denx.de
References: <c0a6f0833fd3e4d887066dfe2ff405a5@cairnwater.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c0a6f0833fd3e4d887066dfe2ff405a5@cairnwater.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 869f7cfc-cef0-4383-545d-08dd8e06fad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVQvVHNMNW1nTEJzbXhoNHpyNkZiRzJhaS9laHhPWkdOb2dJSnlyZ2JUQTho?=
 =?utf-8?B?aEpiWDdtYTU0bndLcGtzcmZOOElWVlBGMGk1WWVzSlBNYjNBM3E1ZXErQUpG?=
 =?utf-8?B?czl0aXgyMlBreE8rTDVDL0ExMFRYeTY3MTVPK3ZTOWZFUTVVRE9tbGJYQk5a?=
 =?utf-8?B?V2ZnbzZ3cW05THF1VkpHT1A0VXJmRW9oTjRjb2VsK0htM1BmYWMyZGt5RldI?=
 =?utf-8?B?YTByMVVEbGMwcHBCZWEyMnMyLzhXVVlDVWJ4SjFjSTYvOTJiK2JZSktkUHlQ?=
 =?utf-8?B?MElpWWdpdHdId0xWc1JKSlBOQjUzMmk5UWZOMnlQSG91dStNekV6YXdqak9m?=
 =?utf-8?B?R3hTQitpRE5WQVZzQ2I3QXd4ZytQSysrVE1ubzh3RFFiZkJSU0M1UlV6T1Zy?=
 =?utf-8?B?MFJQMXhHNVlSR0hGcS9SVW5vTGZ3QzF1N2R5K2l0R0dub29VY1lnS1lJMmRB?=
 =?utf-8?B?bjEzVzd6dUhlYzNwN21Tb1BRWXJyUURMYjdaQm5PZW82cTlBYnpEY3hQeDlP?=
 =?utf-8?B?UXBYUktmc0xyaTEvdjhiZ3ovcUZwU2U5SkdzdnlTdEhLUzhaMnMzTzloSVZ1?=
 =?utf-8?B?Q2NRdHVPV3FrSFhXOE54cG1qNlU2OHR0MWJTMStjMlRYM3JNRkdLSHFIZTdU?=
 =?utf-8?B?Ymt4NmVXWDdrVnI2SFl1OGx0cHV0RExsSzk2QTRkTndPOVFpS3RzcERhVmUx?=
 =?utf-8?B?cjI0dVdqdHp0cWlVWUtSelg3M1RLT3ptNDVkY21JS1NWbjRFTjBrTGJ6N3NB?=
 =?utf-8?B?dm8zTHBzbURHN29FM0NmRGtVMDVDM0Rra25wRDBwQllzN1F1V1YyL0o5Q25Q?=
 =?utf-8?B?VTRXNi9RTE5FYnRYTTFrV2F2MHNEU3pDa0paU2QyK3hXL1BLMUdnNkVZR1lG?=
 =?utf-8?B?REJBelBFbG1LWVFmZTdoN2NRM2ZJcWk3bDJNWW9tRzFXUG5jTXQ3MU8vbnZS?=
 =?utf-8?B?U2RsOU9UeXNBUURObkFvMjZjMEFxN0NXM282NndFZjZVd1IvYUZNdkYxM2Ft?=
 =?utf-8?B?QmMwR0VHN3c5Vmxjdzk2V0tYcGVjUW1idnFKeDROUjNpSG5YMEFnMUZ3MWZ0?=
 =?utf-8?B?WERWZEg1cElZZTRvZ1FXN1hyUDdNbS9NckxVNXpBcW9SNlgrQ1BMeHVadWlq?=
 =?utf-8?B?THpMbHI0UHFISmdzK21jaFhSMXNTN0g3cVZyaTMwTDliZjdtb3ZKNVZQSTMy?=
 =?utf-8?B?STdhdUhlTG5EQjVPUFBSeDJ2cnJLZFJDS3gvOW84Z2tPc0h6cWFHVXNtT0xP?=
 =?utf-8?B?TlFlOHFwbEU2Z1hIN0JjSGhwdFltQmVLOXdvTnE2Ni9NT0ZOb1RNeTM2Ukg0?=
 =?utf-8?B?L1B5MlFzUHBkRnluNm1tSFBvWmh2U1BNODZuWlY5dEYyQWp4c3J5RnVKMEQz?=
 =?utf-8?B?ZHFIeWY2eWNSMnphN0hqZkdNN0JNYytpRFZHSWNaNkZBdEwxRVQ0SkNKUXVl?=
 =?utf-8?B?aFVlOGF2K3M3UWQzemx1dFljcXlveDFsejBnMzJ4ak9MVHFnMXFVUDhTeDdY?=
 =?utf-8?B?UWJhNnRPblBicmtsUTQrcGwzOS9uU0xxZm91bXYwaFdGQ0VnT3F3S291bEM0?=
 =?utf-8?B?UWgvSGxkMnZGVzdXOUFIOHcrWnpENjFYb1BrL3puWlhBWFRhMm5lZDU1RW82?=
 =?utf-8?B?NHJrT2YyRUMwWWl5bVdqUTBEYzJuTCsvVnZUejJoQXlRb2ltVk5pdG04ZmFn?=
 =?utf-8?B?WXdqVWVzZmNzUko5S0hIZTB4Ui9RdmdYRVE0YUg0SE4rZ3BEeHZ4Nkg2NTI3?=
 =?utf-8?B?bzlqeUFVZHZ5R29xVndlb283STF1R1BKbTZSNFREWWtxRTMwSm12Skw2OFpO?=
 =?utf-8?Q?JPFsAEAEPTxICu6AwfiFj7GBViyU5WSCl5W7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW52VWxGUy9Pb05PRkJ3WmVUYTlEVTRGZXJuYmlZZWdZVXU3RkUwMkdMSkNR?=
 =?utf-8?B?U3JudmFzOVN5M3RqMzdjRk53MEpIUGtsY3BVTHY4MVNtOHoybHlJSHh6d0g5?=
 =?utf-8?B?eHptZWh1VXcrVUFXUFZ5dGo0UnFETFNNRnpWZUpuZmlQNjg3ekpQaHV5YnpZ?=
 =?utf-8?B?OEF5QWFPRDJkWnd6R1h2eXFvTUIzUVVtRUFCS01IOHJzT055VEVWNHRkTmsz?=
 =?utf-8?B?aHJ2TVZjUzlCeUVva0RTMG1SZTg0M0dPTEYwMUVsVFB0Q3Q1S0VFSUY0bGFP?=
 =?utf-8?B?bkNIQnljMzVCcHk1QWZmRTRVazhjUjZTSEtjWExTMFQ3aUQ2TFcwWHVHd2VK?=
 =?utf-8?B?bjJYYmRIcXNJcCtva1M4ZWMyWGVMNHJjZDczNEJwdlRRdWthZE8rOVZQMUd1?=
 =?utf-8?B?VndYbDFQaGE2WXk3UmQ5Sm5WaG85MDFZdDloVDRYSVdOdlhKRmU0MFA2d3FF?=
 =?utf-8?B?WlJZanlHL0NRUW5Fb1A3cmYyYjRuTGVJMzF2ZzJ6VWJ3ZCt1TmwycFRVSjRs?=
 =?utf-8?B?ckFlK2lvMGNvQ1lSL0JzaHh3dmFieWJmQ0NLQzAyLzhHQzlkTjFlK3ZFdGZW?=
 =?utf-8?B?MGdIZEhzUUtJZUtERUZWU1pYUFo0cWJCWm9QWWtUZ3JFdFovL3kxRFBHUmls?=
 =?utf-8?B?VVdMbzllZnRwSHd5dkl6ck1IZ3ZIa0xHNUg0YzhCNGZIVFZxM3B2UFhnQXpz?=
 =?utf-8?B?MWdpS3grTkxMdXFjc2c5azZkMmZsbWhpVFpITjdLS0JpK29jRGtaTW1DSXJU?=
 =?utf-8?B?ZEZvcysrT3Frcys5UUw5NmZvU0wvczhiVE9PUFlrMTZDOFRiK0RaVWJoWHlD?=
 =?utf-8?B?QWpJbFZ4YitBS1ZMRDhiemJsQ0JzcFhqaUpSYS96eVBuTTY5WnJ5RUZmQmVl?=
 =?utf-8?B?UDFEbHYwdkEweERXNkRPc3BLOHlMQXJvRyt1LytOYUxReTZmbzVGZjZvTFky?=
 =?utf-8?B?VnQvTHFaQlVXeXd6R0tEcFVKSmwyT0ppa2J2UEZJV3p3TTVYTlA0SnNqOEFs?=
 =?utf-8?B?eGNLdTNXZk1TU2wwNk52b1pyZTRISVcwNFhuS2VNUFZCbWRoa2grcEFsV2ZW?=
 =?utf-8?B?RCtxcWU1Y216eTdzY0owenZsNVcrU1JxU2FOcFNyQ1pacGpBbVFLVXRmN1pS?=
 =?utf-8?B?NVRXZ3BxZlI3OTVXLzdQUFRFSzE2MERRWkRYUXpKdWFzUFNCTCtnWU1VMi9V?=
 =?utf-8?B?N0JaMWR1emxuVm1DYUdqKzd2ek8rS0hjWU9jbnJZQ3p3MXArRjdUc2hjSzNq?=
 =?utf-8?B?SXBuMHV1bEFFS0tlN0pFOU81bVhVNGJBeG9Md1dOTGNsNHZlc2ZPOVJtMld3?=
 =?utf-8?B?U0Qyd000NEpEc0NZRUJoY3BEQWgrS293TzcxYk5WMGoyN0VDUDF6YjIyZ09m?=
 =?utf-8?B?NjQ0Q2RObUUyaG1aenFjUUJLS0I0YjlNdXdSMHhtQkdMQzdVcXZuUmVMREpG?=
 =?utf-8?B?WUxhcFlnNENBU1NCbXNDT0oyV2szZTBNN0VPM2t0bUhDbUpmcDg4L3FSOFlq?=
 =?utf-8?B?akdOYXZhNnlNc0R3d21mODk4VWhmOS9IR0ZCdnpwYm5uUDMyVDBtQ1RBdkVQ?=
 =?utf-8?B?ajNuSFROUW9CSkxDYnU1UWtQd25tMnhsWXZka3FIb0JsTVlJZW1vWmJLOGVE?=
 =?utf-8?B?TDRiSUk0TlBNRElSdlJCL3hmTVdkdWRycVRGRmtuR25xUHhCNHBjOGtzbTEx?=
 =?utf-8?B?NmJaNnhlUzhUMEpRNThHbkNaTWNVd1BITzVDN2NFOCt2bnp5MktSOWJPZmsw?=
 =?utf-8?B?cVQyOTd0WHdaY3dEM3VtT2lGd1U5Qmc1UmNJYk5TZXFtUDVRckU1c1NWUk1D?=
 =?utf-8?B?bWxwYlNIcnllWEdldGwwckRGclo4RXZtaUxqTlZEWXhyR2E4aW5ObE5tcWJD?=
 =?utf-8?B?R2crUGdGakI0OUZaNWNGRVFhL2JUU0FyKzk5dmFvUjJXYWNMb0RKOU4xcGpi?=
 =?utf-8?B?cjNTeDh6WkE1d2FVSE5ldGgxdU4yUHhKbEhXUE85ZkVhd01DQTVQSmg5azdv?=
 =?utf-8?B?SWVaSmZvWWVTb2NKVDFlTUt0SDNrVkxCVnh4UHloTldmVkw3TmNaZmhpd2NL?=
 =?utf-8?B?YkJHY2tBS2RTNW1JTXF2dXQ2TDl5V2cvaENkQXhhMk9HKzZpaGs3NjVTNmsx?=
 =?utf-8?B?WWZXQkJCdnVxcE53aFV1UUZEOWZpandJd201UTQ3dVhmZlM2UzkvNlpqMjBE?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 869f7cfc-cef0-4383-545d-08dd8e06fad0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 08:04:38.7098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raYdhrNbOT1iMk3NlZIafBu6ET8MFLDD4JlHsyxUZg5UUfiMPD8Bry9iXhEkZNhjBJsczBUBx93Y0n+gWvQ4StD/QYQkqQ32KlIlVMmZnc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7820
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

Hi Will,

On 5/7/25 6:30 PM, u-boot@cairnwater.com wrote:
> [You don't often get email from u-boot@cairnwater.com. Learn why this is 
> important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> Does anyone have any advice on how to add DTOs needed by libcamera to a
> u-boot in a buildroot or Yocto build or on whether it's more appropriate
> to add them as part of u-boot or as another part of the build?
> 

If we're talking solely about cameras, I'm not sure it's important to 
have the overlay applied for use within U-Boot so I would suggest to 
focus on generating a FIT image for the kernel which has the base device 
tree and one or more device tree overlays that will automatically be 
applied by U-Boot based on the fdt property in a configuration node.

This however means that the DTB used in U-Boot will be different from 
the one by the kernel. There's some effort for some 
architectures/vendors to pass the DTB along stages (multiple U-Boot 
stages, TF-A, OP-TEE, followed by the kernel) instead of loading 
different ones. I believe this would be bloblist or the upcoming (?) 
passage standard. I have no experience with those as all my boards use a 
different DTB in U-Boot stages and kernel.

> We'd like to add Kieran's DTOs
> 
> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgit.uk.ideasonboard.com%2Fcamera%2Fdt- 
> overlays%2Fsrc%2Fbranch%2Fmain%2Farch%2Farm64%2Fboot%2Fdts%2Ffreescale&data=05%7C02%7Cquentin.schulz%40cherry.de%7Ca8e0b5c29f524a517d7f08dd8d8d899e%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638822361226841805%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8OQ%2BjZjI9Fi1qd9qTwDRiD1wvX6llMGZINDL%2BiPm%2B6o%3D&reserved=0
> 
> to the buildroot default configuration for Debix Model A SBC
> 

The easiest is to upstream those to the Linux kernel or have a forked 
kernel with those in-tree and then use 
BR2_LINUX_KERNEL_INTREE_DTSO_NAMES to specify which device tree overlays 
to build and add.

Buildroot also seems to have support for out-of-tree DTSO but those 
likely need to be within the Buildroot main tree to be discoverable?

I have no clue how to generate a FIT image for the kernel with Buildroot 
though.

Don't forget to select BR2_LINUX_KERNEL_INTREE_DTSO_NAMES otherwise you 
won't be able to apply the overlay on top of the base dtb as symbols 
would be missing.

> https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Fgithub.com%2Fbuildroot%2Fbuildroot%2Fblob%2Fmaster%2Fconfigs%2Fpolyhex_debix_model_a_defconfig&data=05%7C02%7Cquentin.schulz%40cherry.de%7Ca8e0b5c29f524a517d7f08dd8d8d899e%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638822361226862151%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=UTJeVWJcHnslwSkLjGFVyXIwGnGJuf%2FinrOD%2F%2F1RV5s%3D&reserved=0
> 
> Ideally we'd also like to add the overlays for the Sony IMX 708 Image
> Sensor used in the RPi V3 camera but these aren't mainline:
> 

Then upstream them or use a forked kernel.

[...]

For Yocto, I believe you could have a recipe only for the overlays for 
the debix model a hosted on Kieran's gitea which would inherit the 
kernel-devicetree.bbclass (or is it devicetree.bbclass?)? How to make 
those out-of-tree device tree overlays part of the kernel FIT image, no 
clue. Probably kernel-fitimage.bbclass inherit in a recipe and some 
custom callbacks? I seem to recall Yocto isn't fully ready for overlays 
right now so there may be additional work required.

Another option could be to use extlinux.conf with FDTOVERLAYS. This is 
available in uboot-extlinux-config.bbclass, but only since Walnascar 
(5.2) released 3 hours ago. I tested it myself back when I contributed 
it, so it should reasonably work :) Don't forget to compile your in-tree 
kernel base dtb with -@ (for symbols).

I'm not sure the u-boot mailing list is the appropriate place to discuss 
those though as there doesn't seem to be much required in U-Boot aside 
from the usual (FIT and/or extlinux.conf support), Buildroot and Yocto 
mailing lists could probably be better places.

Cheers,
Quentin
