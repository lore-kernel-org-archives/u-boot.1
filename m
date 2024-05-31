Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A73AC27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 06:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9587988757;
	Fri, 31 May 2024 08:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9cL9y9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7DC88768; Fri, 31 May 2024 08:06:49 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4580088757
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 08:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aM+4/DD49Zms2zfemWJdnuTByxuBSgsJVnxnr2Q94WdLbCwFIclx49FA/yHnyLDgGRjISNmSBCTLCBpfJOofxxHZifFLBcd5dtl8b9wF1DZAJ9DjCURsuDYf6e5SgelUdNyn9oEz8MM/1eRAwprIrWTfP5T4/RSYgA/pVMhz5k0UgGqnxZjCbCp8LSwBXIwV7zOW0/+1HKPtRMm1rpLdbYbhXJpzUQ41dEfmiyMpEerXiQ/YdyryNxD9Uk3x0+nFtYsKd5RNY44mS6gWx6VxUDhuEU3nPdZvG4YhN9m4tuvnEj4FdYL/Ui0ZT2qSozXMQz8Jz+CdpplP1MaUT4zgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJjYfJ9mqAEV0SQEZhHn4yf07fi6wwCDh5GnXBgIAgM=;
 b=g/Wl1ANgCQJsUqojrrnzuUc03P5R3TDkZZR5pMGNebr/1BuG67onTIDTKt+mCLZpXfKZnxoQ4fGxsBqEvaDlIjMNRqTBsAgSl9Deeuldjjb3Ff7HEBh2FY7rfvEK5Q8hoG6t46y9sRIZbkS6jstqAvn0r00kfkw/UAcHDVc8IUXURIwmc5ioLiqUSN6a1fQ/LxKm3A/xaEAEdMPKHTvTXsHW5H/+tGJwtYRwp+d20w1Jpm7TtNtNq4+wFWVPOc19hS54zGEW0GIkE/ljApgbD2YwBgQGYA9oL7BqrMpbRMHYmqTUg4/MN5Ys9A/z5A+tziHnPTCoS2mvcGMt0/iGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJjYfJ9mqAEV0SQEZhHn4yf07fi6wwCDh5GnXBgIAgM=;
 b=N9cL9y9MquCdBJ9DPoZ/vom+hjhuXExOTmzsFOL0gylTLj3W2fSECmPaH5WOpP3IId+u2rNkhjVcp1dcYJhNMfcfIwIY35RYqpf4J4oxDBgM8KgItsDvkbFkHj3wHlQ8DNA1pICG6ZINqWd90haMfTXByUbdK6MPJM8NS6I66+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 06:06:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 31 May 2024
 06:06:42 +0000
Message-ID: <14b6cbc7-9f1d-4105-8df9-605b657c286e@amd.com>
Date: Fri, 31 May 2024 08:06:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Update rproc node
To: Tanmay Shah <tanmay.shah@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <d8247a46f486a612f85767de9b832ad33fa980fe.1717065556.git.michal.simek@amd.com>
 <abadef65-e76d-4954-af91-952da6785608@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <abadef65-e76d-4954-af91-952da6785608@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0138.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9ce25f-ba71-447c-779e-08dc8137d7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFdmelgzRlYrZGpnblhodVJRY1AyUDYyeFhoV0RqR0ZhU2FEUGEwRlNjNmNM?=
 =?utf-8?B?bGZ6d0hVUVJpZlBlUS9GU0F4N0haVU5kb2gweVpSWHRSTFozWUY1S3p4a1oz?=
 =?utf-8?B?U2dFWExONmdtMmZkZVBXRjNmTVBLaFJTTm5tWFQ2eHZaVU9YQ2RzTjFWbWd5?=
 =?utf-8?B?RWw1TlVXSEFtWi9Kc3JERnB2MDF2Z2xRWmhxVmpCTmt3bk5yb2pqVk40QTE1?=
 =?utf-8?B?S0J0MEdPZWtzbGE2bU9RVUV6cWRPblorQm9xbmdEVHRxKzN6TE5rcWh1SGFS?=
 =?utf-8?B?YUJ6TVo0SmJmNGRVK3V4OGhrY041T0t6Ym55MnRxMlNvT2txaUp0WGxZREh0?=
 =?utf-8?B?bDFISzBlQ3duTUpkS1VjYUdOMGc3NXc3L2M0c0NKT0hBVVhIT1Awa3dHNHlD?=
 =?utf-8?B?bEM0S2NLc2h3bllkOG9GWk5LV2lYNkY2TWcxT2RsTFVpajI5WlNndjNZQjJO?=
 =?utf-8?B?TlpOZE1oM2s5Yktydjd5WGxPVUpnZVRlVDhrVGEzRXFwakI3NWQ3c204NEtV?=
 =?utf-8?B?WlR1cmJ4NzhtTDN0WWRZdHpidGx3QjZsZWlWZ1JVc0Y3RGxSVmNoK2E3NGlz?=
 =?utf-8?B?NWc5bUhnVjZWYU5rTU4xclcxeVJWc0ZkNDlCYjFUZUdZZnFMUnpIT2NQMXc3?=
 =?utf-8?B?OFBSTit6UGkvcGNnQzBwVm5VMnlwYXF6MDgrRUYyb3FadFJodUxRbndFRzc0?=
 =?utf-8?B?M1g1WFdBZGYxempWa3NLaCtWVzR3bE94RGdyeWlmRUhkbWZaeHZsZEZiQURy?=
 =?utf-8?B?UmVjL3gzL2dWeHRPV3VzMDlyN25jRlUvMHpGQmZqZ0cyNVpIVkp3RWJoT29O?=
 =?utf-8?B?Z2VvOStXSWJ6eG5vblFGL2Z6QTk1WG5uSUtCUkptYzdid0FydWRMdzZYeUUw?=
 =?utf-8?B?M0dvaENYWlY5eHdMdEhveDNWNHFKNy9Id2tPdlJrU1hrc3ZSdEhVQjg1c0kv?=
 =?utf-8?B?bHJXcEJtQjdYMy9jZ085anlYSWR1QnZodW41NnU4c3lSUzdSM1lLR2FDYTQ3?=
 =?utf-8?B?Q0IrREc0UitoMVNJcklBc2NFZk53OFlETGhIVHZaMk01MmlrRWMvYlRxY0tF?=
 =?utf-8?B?U1F2K1ZibFpNYmF4RTRNVGVmZXFjUWtJRG15WXdrSlpvVHk0KzJpb1dxYklN?=
 =?utf-8?B?Mm5rM3BGQ05iY0NYRVFoRFVhbHFRS1ErdEFzQXIxYTRNTzlIVWgvUThMejhD?=
 =?utf-8?B?MGdGcnArNUtYc3VlR1ozTEFNa0U0bkpkdnZ0cHgxZWExVng4ak13cENSK1ll?=
 =?utf-8?B?cTRjWkROMGNCdlJ4dmRyQ2NCZVlCdkI3aDEycnJzdDNwOHVwWHJScFRnL01C?=
 =?utf-8?B?MExRbnR2TGdWNXNtY3VWc0NWM1hIK2xpWDNnaHIxVGhSbm53UHNVM29VdzBs?=
 =?utf-8?B?aDdnUzhmVFVOQmVmQTBhMDhRRlMxYS91N1paMzI0VlkzSkxQa0wvZXp4Yk5y?=
 =?utf-8?B?UWZRU1RlVmlLeWRQaUpDSHBNQ3M5eFZJbkFtbGQ0RktOMktzRTRVN3RrbXl0?=
 =?utf-8?B?N0VvYmxPUWR0QXpSY0NtbHZDNTFyRjJyY2pwTHYwR0JaUTJCN3RFUzh5aUxI?=
 =?utf-8?B?Nk41ZEpLNlNKSSsyOUZVS2hPMXFJZ2FoQkQ0MUlZem5rK1RpQUVpOHpEUFZi?=
 =?utf-8?B?MzFiZ2ZmU3B0bVNacWQxaTBLalNLcmZScUNwN3ZGMEtkY2Q3RmlCdU13bEVM?=
 =?utf-8?B?cFFMeVE5T0NLODZqaHhFSDl1R3R6emFxUE1EYVg5N0R4VFRoeEs3dDh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFTYUZXQmZnNG90ZGtSRDB5a2xocVFGZTdmSGF3RXUyaW80ZTdZazRKUlBV?=
 =?utf-8?B?WSsyOUtabmVjWTBuTCtmc01vVkk5R3JZbzRPM1BhMkV5TFM5RGpnYXdaY1ps?=
 =?utf-8?B?VGxWdWtocHhkbjZQb05FY055L0traDJEeFlOWXJ2b083VGVETWpLYlBGQ0Ft?=
 =?utf-8?B?eHkvUGZMZWpVOTBRZkl4b2pHdmJoVUQ4K3B6dng0K2l6bEJtSVNsajRZUkVF?=
 =?utf-8?B?bmFHNGpYMTBCT1JSRUdxZVNoRG4wekNsQk0yaGxzVW9neFlTNCtobzgzREIx?=
 =?utf-8?B?bVFQN3VRcmduaXdlUnFwOExFMUZiQmlVYUlXSTgwZ1lzRXQrb3VUVnpwaEpl?=
 =?utf-8?B?QW94QnBJTzhOamFrQWlyd2FFMTg0SDF2ZGZ6bHVEVEdxcTdEakg0UUcrN0s3?=
 =?utf-8?B?TFpPOFVCU1RBZVh4eDBweFMrYnhRcFAyd3JFU1JWc0xNM2xSaUtiOVZCQitx?=
 =?utf-8?B?bGp6SzlzSGtJbjIvVDVGSVQxTFliOGszaldRWVg0cUdrc2RSKytRdEpjZDNp?=
 =?utf-8?B?Q013bFNlT25aV2NaS3BzTDU5YUdTSjNHbXRJNVE0VW5VUEZUdWpkMVVUK3ZM?=
 =?utf-8?B?TFM0d3hUU25NQU1yTmNLUGRYZzY4dmt6VmlmTlB1SmFTMENmL1lCUTlZamgz?=
 =?utf-8?B?eHk3NGcxMS80SU1jN010VTNMU0lMdFc2QzFVMTFPcXVPZU92UGhsdUFNb1Vv?=
 =?utf-8?B?YjFESUMwSnBka05WaXVacU5wVmJEeUk5TXZpOVZXV2t4NkRiZUx3SGNvOENC?=
 =?utf-8?B?NW1XdEJhdnFhNTBQTWNtZGFjY3RKaDJ2QTJRbkJZVDRLNmVzU3prZTl2VlhR?=
 =?utf-8?B?TTZCU0s1N1NwN2F2MlhwV05LcklRM0lKOXYrS255TUg0djhNSjB0SG5TNXVp?=
 =?utf-8?B?aVhBczRtbGFNNC9KQUhEZXlDbjFCMnBUb0pYS1FpM1FyM3ZhMjNwZXhHZ0Vx?=
 =?utf-8?B?alp6WURtaERBeks0VzFWUWxFbFQxQW45RmRFVGx4SkZxRU9yelNCVFpweDhD?=
 =?utf-8?B?MDdQSjB6Z2EzMHdUUUp5N3ROck1tNHo2alJpcU90dGhBcXNlOTFKbUlLY0Ew?=
 =?utf-8?B?QUV0THNTUU55Y0swbzVZNjNhcU1HUSt1UUttbnRiN0dGSldMUGllbHBBbTEz?=
 =?utf-8?B?WDlHbHp2RlptUjlDeE5sc3dPL0h0NDUxT29FcTlRbUE4eS9rWGl1SE40dlRD?=
 =?utf-8?B?cy9FUzdHOFArbjBZK3d6WUxSWnNxWWpUTmhMdis5UnROQ2RlNEVIV3lhcnpw?=
 =?utf-8?B?dUxkUUtoZmp3SUs3MjFXN3pKVEFxL2Jsd2JxdFVKOUdBbTRNTE10MExNL2V0?=
 =?utf-8?B?SFpTcUUrdEFZQlJMS1FaV0k0YnRoeHlrU3Rnb1MyNnJWektUYUVuZHVsQUxW?=
 =?utf-8?B?M3JtclI4aVFVVVdnMGdvejAxZkVSaldobit5d0pJSm9LajVKbjlpS0tGSnhE?=
 =?utf-8?B?RlVSMjkyeS94aHVUTzBZcEptdjFGL3ZvR3RERzZhTEdpVWhuTFRISmhtWXFO?=
 =?utf-8?B?Q1hPcnRKVnY3eVpETVcrQ2hIcXJndDZLK2VuR0F4U3p6ZkwyNmFVOXR4dldk?=
 =?utf-8?B?bXpMYndkT2JocHBBdXNEU2VYd0g0R3VtODQzWnd5SC9LWERycmlETEI3OEZn?=
 =?utf-8?B?czRLVFVhWVh0OGFFSWFkZFZmZGlLSGk2Z3NsMWdtbnVPZ3g3UHhpRzF6Si9I?=
 =?utf-8?B?VDBlNkF4bWxiTUhxQUx1WEh2Z0Z2VGNGZDNFU1pUa3ppYUJxZlNpaGQxZURU?=
 =?utf-8?B?VzQ1RHAreXFpR0J1OENVaU9meVhoZk1QNlNmL0JzcmVyQlVmWUp0YS9HSDBp?=
 =?utf-8?B?cy83aFM5ZStoN0diY043YUROMmxubm1Zd1VuZkN1QWRJbmxRM1FtQUlESDZY?=
 =?utf-8?B?T0d2bitVYlRRNW5hQ240V1dPT2tKRktlbHdwaGthRTFJWWNNNDRDNVNiZ2Zz?=
 =?utf-8?B?Nmp4MTlLMHpoT3MxNUhmM1N2Qmo5b25OZkJnYmloMTc3ZDYwWW9xcWRxY2dE?=
 =?utf-8?B?REU2R3RheHdNT2hhTG5OYk9DMmlvNDhFczVVUWRITG5XbkFYWmtVSURibmcz?=
 =?utf-8?B?eUkwd1RpU3RXeGpNRmtRbVpsTVU3R2l4QlFqZll1M0NvZ0llQVBEWURheGVL?=
 =?utf-8?Q?gcibu4hqnwV+DNUqxoeB9VoEV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9ce25f-ba71-447c-779e-08dc8137d7e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:06:42.7599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmKmUPJ+SrBGI/Ih+milvM0bFkyY2nSEabnOwrPhB1//g38Dd4nplgb0G7Ak9DcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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



On 5/31/24 00:16, Tanmay Shah wrote:
> 
> 
> On 5/30/24 5:39 AM, Michal Simek wrote:
>> remoteproc node should be updated to be aligned with the latest dt-schema.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> Once we push all dts to Linux we can change to OF_UPSTREAM but till that
>> time we need to keep DTSes in sync.
>> ---
>>   arch/arm/dts/zynqmp.dtsi                      | 67 +++++++++++++++++--
>>   include/dt-bindings/power/xlnx-zynqmp-power.h | 17 ++---
>>   2 files changed, 68 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
>> index 53a606c340a4..34f592c1a85f 100644
>> --- a/arch/arm/dts/zynqmp.dtsi
>> +++ b/arch/arm/dts/zynqmp.dtsi
>> @@ -314,19 +314,76 @@
>>   		ranges;
>>   	};
>>   
>> -	remoteproc {
>> +	rproc_lockstep: remoteproc@ffe00000 {
>>   		compatible = "xlnx,zynqmp-r5fss";
>>   		xlnx,cluster-mode = <1>;
>> +		xlnx,tcm-mode = <1>;
>>   
>> -		r5f-0 {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +
>> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
>> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
>> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
>> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
>> +
>> +		r5f@0 {
>> +			compatible = "xlnx,zynqmp-r5f";
>> +			reg = <0x0 0x0 0x0 0x10000>,
>> +			      <0x0 0x20000 0x0 0x10000>,
>> +			      <0x0 0x10000 0x0 0x10000>,
>> +			      <0x0 0x30000 0x0 0x10000>;
>> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
>> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
>> +					<&zynqmp_firmware PD_R5_0_ATCM>,
>> +					<&zynqmp_firmware PD_R5_0_BTCM>,
>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>> +			memory-region = <&rproc_0_fw_image>;
>> +		};
>> +
>> +		r5f@1 {
>> +			compatible = "xlnx,zynqmp-r5f";
>> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
>> +			reg-names = "atcm0", "btcm0";
>> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>> +			memory-region = <&rproc_1_fw_image>;
>> +		};
>> +	};
>> +
>> +	rproc_split: remoteproc-split@ffe00000 {
>> +		status = "disabled";
>> +		compatible = "xlnx,zynqmp-r5fss";
>> +		xlnx,cluster-mode = <0>;
>> +		xlnx,tcm-mode = <0>;
>> +
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +
>> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
>> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
>> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
>> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
>> +
>> +		r5f@0 {
>>   			compatible = "xlnx,zynqmp-r5f";
>> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
>> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
>> +			reg-names = "atcm0", "btcm0";
>> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
>> +					<&zynqmp_firmware PD_R5_0_ATCM>,
>> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>>   			memory-region = <&rproc_0_fw_image>;
>>   		};
>>   
>> -		r5f-1 {
>> +		r5f@1 {
>>   			compatible = "xlnx,zynqmp-r5f";
>> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
>> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
>> +			reg-names = "atcm0", "btcm0";
>> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
>> +					<&zynqmp_firmware PD_R5_1_ATCM>,
>> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>>   			memory-region = <&rproc_1_fw_image>;
>>   		};
>>   	};
>> diff --git a/include/dt-bindings/power/xlnx-zynqmp-power.h b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> index e7eb0960480a..618024cbb20d 100644
>> --- a/include/dt-bindings/power/xlnx-zynqmp-power.h
>> +++ b/include/dt-bindings/power/xlnx-zynqmp-power.h
>> @@ -6,16 +6,12 @@
>>   #ifndef _DT_BINDINGS_ZYNQMP_POWER_H
>>   #define _DT_BINDINGS_ZYNQMP_POWER_H
>>   
>> -#define		PD_RPU_0	6
>> -#define		PD_RPU_1	7
>> -#define		PD_OCM_BANK_0	11
>> -#define		PD_OCM_BANK_1	12
>> -#define		PD_OCM_BANK_2	13
>> -#define		PD_OCM_BANK_3	14
>> -#define		PD_TCM_BANK_0	15
>> -#define		PD_TCM_BANK_1	16
>> -#define		PD_TCM_BANK_2	17
>> -#define		PD_TCM_BANK_3	18
>> +#define		PD_RPU_0	7
>> +#define		PD_RPU_1	8
>> +#define		PD_R5_0_ATCM	15
>> +#define		PD_R5_0_BTCM	16
>> +#define		PD_R5_1_ATCM	17
>> +#define		PD_R5_1_BTCM	18
>>   #define		PD_USB_0	22
>>   #define		PD_USB_1	23
>>   #define		PD_TTC_0	24
>> @@ -45,6 +41,5 @@
>>   #define		PD_CAN_1	48
>>   #define		PD_GPU		58
>>   #define		PD_PCIE		59
>> -#define		PD_PL		69
> 
> This last change looks unrelated. Other than that looks good to me.

You are using new PD_R5_1_ATCM, etc that's why also this part is needed.

That removing PD_PL is unrelated. I can split it but not sure if it is worth of 
separate patch but can be done for sure.

Thanks,
Michal

