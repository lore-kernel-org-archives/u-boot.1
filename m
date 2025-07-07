Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D28EC8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 09:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A4D83046;
	Mon,  7 Jul 2025 11:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z5Uneim7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF3D8304D; Mon,  7 Jul 2025 11:43:28 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 973B583043
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 11:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl7lVtQxEtVamedYfdpBsWNVDjIQqSk2KLkpP/cqUskpYBjL1MT84hSoZWU5XqQs6t7La4Pn8swJKTWzNak0PGbCywoWPFo/n7D6IhX2Pcdu0o0USrFJBGKNVz98uJEQhXW5aAswOhbiGyGLfpPl2NlZLWz//FFwLcsAzIU1AK1g73M5F+0CeYQqqVQJYhfnec89OIsAVI3CyuEG2RHERB5KrkfCMmTlEJ6k506TZJeQy5ep0+kR2TGh9P4xd8TMwDcarIC+0iRUQx7+mOP4+eUby+Do4N6dm3htKuDywxGA9bcARUQK1amtGYsLKzto/GgCo5vxbffFN/6Yr6cHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNwRt1zKcUr8/taUJkyZcy3ue0LRBi19NY7mzE66KyU=;
 b=iEZoed0pk0v5A8AylClFjU0dOpBEbnAPKWIkCGx2bYvkvQC7eGhxid+JqN7tt9XT0PsWSRjIZP+WvGAAUdJjDEQj3Xe6Z1O5wKJfcbjpgYfzNQhG9EGnMOwRL++kTT69rJhRt4JTap6rDwGCbNUw4ktoBgvhvBWcy+elcgutCWXH70EaJZ09mhntO2gxRFlnIE1EUVtfg4m9OSgzNuCNYltEF5v5myzo1Fml5dVmHpNszbCTTeG5SjqPY40IRNN8Y+18d8/lyFYmUBB1NGM2jXRamX3WyuFZBRrMWddMVmibOIdNNX6IJPfN9Lrge1/RKVP5/lrcWgL6sugwGFdKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNwRt1zKcUr8/taUJkyZcy3ue0LRBi19NY7mzE66KyU=;
 b=z5Uneim7Z+RhSaxVZKX4ZxD8aK7SytEbcG9ELI/czOlQEDpHRmD8YtqfNtFwc3PYQzTT/ATqGqCQGDfGz7xVDn00FIpoudQcQONdxCXWKXc0OgLJeXG89stqXKCUAfdrmeq8GpAfgVSbUFQkRGJqp3qM20WvtVuzJT/4QfkA6Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 09:43:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.023; Mon, 7 Jul 2025
 09:43:23 +0000
Message-ID: <a2fe2449-494c-48f3-8beb-44012043e404@amd.com>
Date: Mon, 7 Jul 2025 11:43:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] configs: enable FPGA commands and drivers at
 sandbox_defconfig
To: vtpieter@gmail.com, u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20250705205710.792370-1-vtpieter@gmail.com>
 <20250705205710.792370-6-vtpieter@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250705205710.792370-6-vtpieter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:802:2::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: de4b414a-b525-4242-4bbb-08ddbd3ab6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUFvR1B4dDNxbXdzYXRXZUcxcThsRS9iaTBNcWxEbmpSaURob2xvaHh2NlFs?=
 =?utf-8?B?RjhaY0I0T3JKaFdRV01JSExJZnhTYmRjK0VoQWJSelk3ZEdRcHkzckdJY3ZI?=
 =?utf-8?B?NVlieE5FV2NqTWVTck5ML2hpSTVMNFg1eXdBRkh6MDg1MUtCVW5JMEYwSGlO?=
 =?utf-8?B?eDIzejd5RFlkVFI5bmdSbXNxc3hqRUtDRnNILzZtV09ZTnpOZC9xT3BDMjRl?=
 =?utf-8?B?aWV5aStUamg2ZzJsZmpjMGZiTC9qWk1zZjcrRUZ0eWpVT0hSd2o0QkFsWXBR?=
 =?utf-8?B?LzEyOWFCUHdRWDhRRFdaU0Era3NJa2txb01CWVM2dXluTFl5eXA5Q1lMSVpY?=
 =?utf-8?B?VlByYjhDS1JLWUVVSWdNKy9EZXFTWkRRMVBIS0pzRGQ0SEc1VjZJbFRsLzFN?=
 =?utf-8?B?WE1MV3ZRNXdQYzJCVnBJcHBJbk51R2grZllVeWFCbHZNa0wyQWg1V0p1V0NO?=
 =?utf-8?B?bFRPcy9yOWZWdEtNcFVMRllpdnc5NGREdTNIdTBCK0p2NmhrTlZsVXZheUhq?=
 =?utf-8?B?UG84L3IvNGNmSnA1bmhvNWVlcitOdkwxOUdadktaU0I5aWJPZkk3YW5GcHBL?=
 =?utf-8?B?L25mQS9ISGZYVk5GYThCUFQ5YW00SnIwUit5SVNob051RE95VG9Oa0ozbktZ?=
 =?utf-8?B?M3BMakFzL2VSQlFyc0VvM2twV1dRaVVPaHZlMGVnNlhaVnd3aURZZDlKc1k0?=
 =?utf-8?B?WkVGY09TZENucEk5NlEyQnNQSDcwUGFOc05FS0FkY0pGNXZvNWJhdnRDKzZG?=
 =?utf-8?B?SEY1Wk1yMXIxTHB1cC80Wk9GRHNwbkltUWtsN2Z2YVhOY3o5RzJaL3Nsb3F6?=
 =?utf-8?B?SGtaM2NZUU1raWdBd0haa0VscGNNOEZDZWZTNS9EUS9DVUFjR3VBSHFWdEVQ?=
 =?utf-8?B?eHpZaFRNMVE2bitydWE4dy9HMXMwTG5PNWF5TEMwWFNaRi9uRFg4SU9qVEFY?=
 =?utf-8?B?aDhJVHgyK0hyeGJISVg2YmRMZk80Qm1EWGpibmNCb0hqc0RhT2xYa1J2Umlo?=
 =?utf-8?B?Y0ZDckZ1ZTVQR2M3c29RV2xrMVZlUnN0S3lndDJROGNXVkhmL0x6MjBkekp3?=
 =?utf-8?B?Vy9HRmc4VmJuams4NVJVTE1sYXN2d3NKdldyMXhFaWg0bU11MWVSbmI2M1Qz?=
 =?utf-8?B?aWg0L2tTUkFRQm42bUI5Sk1QSVJ2N1A5TFYrRG1ONmNYY3RjOUNiSEdRKzAz?=
 =?utf-8?B?Um5PM0Q4Y0VUY0wya2k5MGtPWC9keG5FdnVpS0phUjNENUdIRzZXOFl6Ri9Q?=
 =?utf-8?B?bGdFQ1pmRHpRMVZoU0s0S2k3OVJBemhKbFRvV1dMYWpUeWNmaG9wL1ZHeU45?=
 =?utf-8?B?MXhQdy96ZlVSSlF0UUtKWVZoTVJmSWRkWVJDK0M1bEowNkZFaFhxUWNVUlF5?=
 =?utf-8?B?Rmxjckt3VHc3aEhlL0gwZFl1eWFvcS9HZW9DRUxMTXBOeXRBNkxreW9SaVg5?=
 =?utf-8?B?TndyaUhOTGpoSXpicm0rcDIrbTNNUldvaHV6Q2ZmNnhxb0tRUDVzczVjQVl5?=
 =?utf-8?B?UHJrSVNxZ2pqckV4eEpycXM4M0wxYXU0dVRCeHVWSDl6cXdEZFZQQ3k3ZlR6?=
 =?utf-8?B?S2Nta1Q4MEhqYnpTWUh2bGEvTjBvSTVwakNlRXNUbEVuT0Q2SGhBODdNNjlm?=
 =?utf-8?B?OWg0UHpOWUtYSXBQMlJHeFVZWEtLT0hPYnhmVjNCMW5QKzcvbEdGU2ZzRU9v?=
 =?utf-8?B?T0NCMG0vUTN2ZXIxLzhlVnM0ckI0YldNcCtveDk3dVplUnAwNEU1Vk5zSEJ2?=
 =?utf-8?B?d2t5d2Z6OGxmNVcvQmtJbERqOW9ZMjhtQVJQc290RU05dURLT3Y4M1FHV2JX?=
 =?utf-8?B?T2Ixa0hZUXlaN2NlZ1RRbndXSnhybmRiMU81cmlxSHRlUjZLbUNvMnlqMXg2?=
 =?utf-8?B?R2pqaE5XMms0MzFhcFNvODdoSFpoN1J6VWVyRCtMdTNyYVA2Zm9ybS9wbk1t?=
 =?utf-8?Q?znHMpLbLZrI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T081RmttOUk1TlZPSk9QMFNPUUw4MmkvcDZGVlJhTXIrVkF6UjRlNmxPTkZR?=
 =?utf-8?B?MGc3RU5aVGpIVVhLQjI1ZXhCbnFmem1vWks1S2RMeHFMQVBYN2VFL0ZmT0ph?=
 =?utf-8?B?ZG8yMGtZZ1U0UEtsT0hHZ1JXRDl6M0xXRGRmckpaTEhJM28zWnVxekFhL3Fs?=
 =?utf-8?B?bnorQ1d4dHNpU3VaRmxsOS9ydVAyRXZLNlhuNjFhZm9Xa2N2K3RPTmNIc2lk?=
 =?utf-8?B?NGxUZUVlZ3RXT3EzODJqekZZZlQxRVBWU1V4SVlYblh4SS9ScjBwRUxrd2Fr?=
 =?utf-8?B?cEp0ZVVkZURaVlFEd3h1VnZEMGgvQnVYZWpiNFJndTZFYXltTEJsbWd0K3Jq?=
 =?utf-8?B?ektFQ1prQ2lPZGV3Z2EwMXoxTEFlejEybGU0MGk3Q0pmenhQdkFhYlpxOHJV?=
 =?utf-8?B?RXJhNFo2eE1RRDgraFRaZUpxSnkxc0VZRVJxY1FuV3I4aytLdnVNQmtVRzJs?=
 =?utf-8?B?Ym5vYlMyOVcwL0FxZ1hicVR2Q2lvaVd3UlhwUStSMWtvWVo5WkNLcjR3V2R0?=
 =?utf-8?B?SlZzeXZwZUdubk9JcWVuNStJK2g2c2Y5UFg1UXFMYnR6T2Uzb2Zuayt3MitD?=
 =?utf-8?B?cjhDTDM3cy9lY0xnN0ZOZzYyZzIyTTNQb2tXdndqdFcxQUtvb3lOcktQWER3?=
 =?utf-8?B?MW1YSmMxYTlMMkhnRUJYMUNuS2FmQVUxM0dqSXRrSC9MQ1AxTGxhVER2TGZ4?=
 =?utf-8?B?dHJadmtOTFhKRXorQVFiTHJFYWlMMkd6Yit5bEU1SHhSS2s5ZW12K3lMM1N2?=
 =?utf-8?B?L3FZNEZpMEM4MXZDN3kyTHZpZWNoL0NEQUtzMFhrUlNQUkErNUFsdnpjQWRF?=
 =?utf-8?B?aENyK2x2T29Jc0tab3M4bis2Z2wxTzhFcDdNUWxJdUpRNnZ1SmYvU25kVXVU?=
 =?utf-8?B?SUppZTBxbXExUVFvS3VyTVVJMWpQQ1Jsb3dPQVEyMHdtNmJtSjVjd1IxNUhz?=
 =?utf-8?B?ZGk2eFRNWjNVUVJ0N1VKSzNoNzF3TzNicGp1cmh1bGM1VDNqdDNOL2gwU0xn?=
 =?utf-8?B?L3N6YnBXenpCOTB0TTZQNlZDVlZ4QXJIZllxVGMweFlscUtyNXZnVHF3N2hz?=
 =?utf-8?B?TU9GeEtGaEJHTHFxVTlOLzdIY1NtUWZqdnlQT1lYSi9lRTFUMHFsTm5JT2RL?=
 =?utf-8?B?VUdZSHlZQzUzWEZpenpSMVFhTTd5cjBnSW0xVEpmdEQzRVliYlk1RmFDK0Z5?=
 =?utf-8?B?eTBPWWgrVy9HaStITDBxRGtzT1EyVDFuTG1xQ25KTVR2TmJUTDlIV2tRa1RR?=
 =?utf-8?B?L3VIdm50MDZjTTVjUk8zR1pWVGh5NkxRVndBMHV1VHFkWGEzRWN3eElzZk5K?=
 =?utf-8?B?SWpMUEk2QmtMZjZVcGRNZE5CVVI2TUdjdUFOZzc0SW1qTFNEQXJlMkgwNHVt?=
 =?utf-8?B?U1kwT1diRk96N29pSnVmWEJtZExZL3RQMkVPLzhuUWtYTnQ5SnBZVmtrTVVI?=
 =?utf-8?B?QTIxR0MzTGg2djlzQzBkUUlMbkxnK0VwSlk1WFNQdVJMOENobytCNUFzdmNx?=
 =?utf-8?B?NFZTMEdvVHRmN0l1NHlwRkNmVmEwZlpBU1FtTk90RVJPakQ3dysyN1VBMjRD?=
 =?utf-8?B?VitPRDBDZERJSHRCY2FSdlduNVQ3TTR6RWdQUERRMXc0bEhBMGV1UERlMWQ1?=
 =?utf-8?B?OHBsTG5PRXpRN2dsajk2Wmd6S0NXMk9LNHBvUm9GOEhjNHF3emozdGFMb1pB?=
 =?utf-8?B?MitOam1LUVU1SDVONTRLeHcrN2lHaTU0WXJzc2RSUmsrSzJST3c5UDBMT1Bn?=
 =?utf-8?B?YnlCcTlBZVdUVTJSaFBXUmExSWNzblNaVDM5aldFTE5BajByQk5sYjY4QWV6?=
 =?utf-8?B?WkZnYkFzY1g1bytIVis0QmtRRG9ycTBJekprc1lNRUFObGlia01HdjFJdDBt?=
 =?utf-8?B?N2t6SkpDeVg1YnpiU2NUYkpsaWtBbWtPdys1L0VUWnpsVlRkVTFMamhncG03?=
 =?utf-8?B?Y1poTC9uZlg0aktlZ2hmK0lueE9tTUZFMmYyQTlxSG91TlNLekZ5V3BNSXQ0?=
 =?utf-8?B?MTcrZ1o1bE9QQW1XNklrazEzYjlDRVQ5VDJEVHJuRG5oc3Q5VCtYMXFZbjcr?=
 =?utf-8?B?RUw1TG5GY2luRjNOYWVRUmdLMjl6UW9UTExvdlk1Z2V2RnNwU2ZFdlZGa0lK?=
 =?utf-8?Q?iyyQjpKp5nhx19Tgbs0tFeTFF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4b414a-b525-4242-4bbb-08ddbd3ab6b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:43:23.1190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eltAvMOQoq8/PSTSg0zhRtb4eFR5PmZX27D+i2q8c5wHqp6auJSdFqAgwcNbxK1A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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



On 7/5/25 22:57, vtpieter@gmail.com wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Enable to facilitate compiler checks on most FPGA-related sources.
> 
> Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> ---
>   configs/sandbox_defconfig | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 4f6943d1a4b..a64e208ad89 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -78,6 +78,11 @@ CONFIG_CMD_MX_CYCLIC=y
>   CONFIG_CMD_MEMTEST=y
>   CONFIG_CMD_CLK=y
>   CONFIG_CMD_DEMO=y
> +CONFIG_CMD_FPGA_LOADP=y
> +CONFIG_CMD_FPGA_LOADBP=y
> +CONFIG_CMD_FPGA_LOADFS=y
> +CONFIG_CMD_FPGA_LOADMK=y
> +CONFIG_CMD_FPGA_LOAD_SECURE=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPIO_READ=y
>   CONFIG_CMD_PWM=y
> @@ -196,6 +201,21 @@ CONFIG_SANDBOX_DMA=y
>   CONFIG_FASTBOOT_FLASH=y
>   CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>   CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_FPGA_ALTERA=y
> +CONFIG_FPGA_STRATIX_II=y
> +CONFIG_FPGA_STRATIX_V=y
> +CONFIG_FPGA_ACEX1K=y
> +CONFIG_FPGA_CYCLON2=y
> +CONFIG_FPGA_LATTICE=y

CI is reporting issues with clang.

make sandbox_defconfig
make -j HOSTCC=clang CC=clang


   CC      drivers/fpga/lattice.o
   AR      drivers/usb/eth/built-in.o
drivers/fpga/ivm_core.c:593:23: error: a function declaration without a 
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   593 | long int ispVMDataSize()
       |                       ^
       |                        void
drivers/fpga/ivm_core.c:618:22: error: a function declaration without a 
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
   618 | signed char ispVM  CC      drivers/i2c/i2c-gpio.o
Code()
       |                      ^
       |                       void
drivers/fpga/ivm_core.c:1117:26: error: a function declaration without a 
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
  1117 | signed char ispVMDataCode()
       |                          ^
       |                           void
   CC      drivers/gpio/qcom_pmic_gpio.o
drivers/fpga/ivm_core.c:2479:16: error: a function declaration without a 
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
  2479 | void ispVMStart()
       |                ^
       |                 void
drivers/fpga/ivm_core.c:2508:14: error: a function declaration without a 
prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
  2508 | void ispVMEnd()
       |              ^
       |               void
   CC      cmd/iotrace.o
5 errors generated.
make[3]: *** [scripts/Makefile.build:249: drivers/fpga/ivm_core.o] Error 1
make[3]: *** Waiting for unfinished jobs....
   CC      cmd/hash.o

M
