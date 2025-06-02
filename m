Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEBBC5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 07:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B000828F8;
	Mon,  2 Jun 2025 09:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oq2zT6Na";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E698294C; Mon,  2 Jun 2025 09:48:14 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54C848212B
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 09:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fnbWe47CNICEvNdqjmYVHt9m935lrie4CTg+DuYivUWa7CAdSlrgNiQIfHj5zrffVlxpc60DBzbnpokU7xN0DhjLxDdp7fvq5RtfZg7P4sWSwLBt177CtHux7VepyU4hoVtnOc/RytaepOaf+tuqosZGQIOSwjkdHPfejB1cZNf162FSZUhwaeVPMkhFhdTOLwKbWLmdJPP3BAE88zDdG10daIvUyK3UmhgvipKAFaHPgJ5ERqVonqxYIOC73BaJaOylAxevjFGbJJTOArCe7p3wu/IW7txL6w/nsTWa9BH3q73qr2L4qGJn0FVawsiVaQculLMni55Uu/UWzvj7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM5cLtI0RkMF3DGO05SMZ5cagSZGPZKEwsYicrLZDPQ=;
 b=UIJ0fjcYjlRGfkn2/aGi2VTjRFZfrXKbHHeyc8WHht8/TEWjaXxbybDgIldh0mOAI6vHWeFtS8H8F4YbiKHjJM1XyslCg/v6oM7uLItWNy29ujFwzhNnKOmyL9lM9H8fyr6Q1kHYhYYOSmsGYkjHmk7IUM3WV3Ko1b0lu1kI3GqloopR1+CHD4RNBVUFPHKOJ85OplJiVb0xG9+e4Fd6Q0rL+ecjG72PEEfGUiQfO+vygxOPb3bgYgGjHoswOZ0/TCPpUeQ1Vmbtc5qk0fGjrDuNz6E8Lx6BrUxNxR74q3HwdA+a0JGLJ37u8CqRPwF5Zgcq3D072FTnJ4CuvwLblQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM5cLtI0RkMF3DGO05SMZ5cagSZGPZKEwsYicrLZDPQ=;
 b=Oq2zT6NaMg6SsVlwyA8HmqODEjgDOweE58rdBdowZuwsIwFVqziODtEtz9bCTY+RigfTYUi0YF0zM1LlAKpPS4DZqta+J/TKUn2CHY6gPEtg09pbfLO7e8Im2mzHTUtK8iKroLj1zsA0WsUC4FeFtpVn4S5OKm+Sr9KTGcDxFts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Mon, 2 Jun
 2025 07:48:09 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 07:48:09 +0000
Message-ID: <2b32ca21-37fa-4226-99ea-5c141376c2a0@amd.com>
Date: Mon, 2 Jun 2025 09:47:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: zynq: Read using DATA register when direction is
 output
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com,
 Mike Looijmans <mike.looijmans@topic.nl>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Heiko Schocher <hs@denx.de>, Nam Ian <ian.nam@amd.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <8067946288c687c323403857aff01e3074bcaeca.1744273514.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: a216db63-b77c-4e13-d0e0-08dda1a9d12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1NTSVpGZEdEbXZ4NzFabi8zV1I4ZmYvUnRCQzV1R3JocVFUN2pzdUpqRUc0?=
 =?utf-8?B?Nks2UmxNZVB5M2EwOGJxUFhFMUYxTmNYOGhLWDlHTXFIR2kwQU8zYlBzbUJm?=
 =?utf-8?B?YnlmRnVvT1AySFZ6bmErNHNJbVZMdzNiVUthRm96VzZqNTlGUkxJOW13WDF1?=
 =?utf-8?B?R1N3ejZkd1NSOUNZcFp0ZFlyVEZPQzcvQWRjRE9naDE1YzdjcG1tNkVQK0xD?=
 =?utf-8?B?emVEd0UyYTJxbHZDMmZSbmUvenFDSXJwUEZCSDE5cmRkWXdYai9scGpFbVl6?=
 =?utf-8?B?UnpzL3VLQkptcTIwVDhRQUc2d2V1dHZ6TFFGYitJS2YwUUlZTzdSTk9KT3hV?=
 =?utf-8?B?cXJyb2dieDhyNVhNeC9vNEtwZHk0V0xiQ21Bc3g3UUQ5dGM1T1FmcG9CVU5X?=
 =?utf-8?B?b2oxTnl1dDdKdFFsQWhPRGFZSnc3ZGRXM2h3cHViVmpKaFl0eUZ3SG9WVk1i?=
 =?utf-8?B?M1o2U3UraXN5OHM0Sy93aFQzcm9QdEV2ZVpUUTJyeldwNzY0STBBc3VsK3ZS?=
 =?utf-8?B?UVU0bkx5Qm4rVUg5Q0JWN3lQbUdTSUtVRGliV0N4eUpRYk5xQVdqdUpsbitJ?=
 =?utf-8?B?TmdwanN0ZWlaSUkra2JnSWIwcTNkbm1YcnFoZERySG1IRE9jcHVEZWdXaGsz?=
 =?utf-8?B?V3RPa2tmMkJMMzltUG00MVlXYnk2Ni8vSXdBVUtnYXplWjR0THFkZnZMTXYy?=
 =?utf-8?B?NjRCQlJsL2ZRVUZPRkY3WjdVSm4wT3J6VUNBeGgxYWJkQkpHMVpJeFFNdUN1?=
 =?utf-8?B?eWJaUlZieXdudW9PVFFWUG1uMmlodjY3UDNNUFhRVVhiUE1CRnNPMGpRb3JK?=
 =?utf-8?B?VnpGQTdnOXg2eVpDQ2ZkY2o5WlhvbXcwVWpabngrWjg5YXQ3Umdkc3pzYStt?=
 =?utf-8?B?amtDSjFRc1JMbDlrRUNkSDE1dHQ5Mk15VmJkRVdnTzRmNzJtMjkrS0c5NHdS?=
 =?utf-8?B?YlZoNTZ5T3FzeTRDNXV0dkUwYTdjZGtjNzEzSWUxK25QaDFEYjYxRWJXM0tB?=
 =?utf-8?B?WlNqNjNnYmFvVytHeEhUVUE5T0d6cEU2NHJYUnlaSm0xSEdOT3JBUmpySWNi?=
 =?utf-8?B?d2lBV21RVXpxbURtUVVTdHFOTTRYUnBoZ2ZpTDQrTUc2Z2xOY21SVEM5SGRo?=
 =?utf-8?B?YUI3M2UvWW4zaitJTHlZN29SRFVzMTN4OW14djVIZ3dibWw5cGhob3hUd1Ns?=
 =?utf-8?B?SGUxblpTYzdRdVdpaG5CNW9OaDVPVW1tcFBOUUhJcDFZRzdDTE1TRFd2alVo?=
 =?utf-8?B?ZkI4S0RTaE1LdGpGQUYyVnVxVlR3SWNHcnFVVTRWOU5HZnFneGNHcCs5Y0wy?=
 =?utf-8?B?RnMwaFdwRGkvRUIwKzJRK09VOGxMWkpRdkNVak81ZG1Cd3RZb1Nxc2V5dFhv?=
 =?utf-8?B?RVdIVXdyMEVyUThicityZEEwNnJvb0RoQUdDMEw3WksxUEl2aVRCRlhHWEUy?=
 =?utf-8?B?VE5oTlBvZHc0R1F4VGU3RWZHdWkvWnBoNlNWQXd4YS95LzBNakFJZjFKamVL?=
 =?utf-8?B?QklIVE9sZjUxYURsZ3FtT3NVZm1QSW1EM1BCRkhaYllxSThOTEtqcmJ6bGdE?=
 =?utf-8?B?ak1HRjdBZytjRzdkbFZzK3ZJMldxRU9Dc1BSVFAzOFF2SUswcWRUYVQvbmZh?=
 =?utf-8?B?aVNnNlloNCtGN1c4TFNoRHluL1VnYTU0SERFYlBJdGEzalRMV0pGVWtxdzRl?=
 =?utf-8?B?V2IvUHUxVTY1OHVvZWFpb2FqSHNpRlZON3V5TEFnR0RLNjY5Uk1qbUp5YnBk?=
 =?utf-8?B?alpvamdzQmJ5ZmEyMWhiK0FDN01zRjZHclV4UkxaUXhXYW9icVdWbVU3L2Fh?=
 =?utf-8?B?Ykk3K2hUR0dtcWpNbWpMbEZJbSsveTVnaUI1V1F1dmVWTzBJSW11WklRdXZ4?=
 =?utf-8?B?RDFLQjhMR05EZW43bFRHMVY1NTYzUFltV2dzUkdQaHY5RGhCQWVtbUNLaDZx?=
 =?utf-8?Q?nlYgIW/J4x0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0F2dmVoOXQzVUtBZEdrY3dlOXBISHRidVJ0T0xMMVBVaE5ZMTJmUzRuQjFC?=
 =?utf-8?B?c0lVWEM5U1FoY2NNY2VQQjJkRUlXcFMwcmFtZFFPaDJDN0doNVpNZXVodVFD?=
 =?utf-8?B?OXN5cVZXSnR3bzdQY2RJMlcwQVRLRXNtM1grMUZqVzNvNHd3dnpDdTJySlhs?=
 =?utf-8?B?MXhqUXZFSFkvRXR2Z3BZZDFrQlpQcGcwQno3dTdaNFlZcWIxOEZFOE9sdEdK?=
 =?utf-8?B?WTFSUnRmL21HSUJydjZxdHFlU2VVNklIVDh0dXZkTXoxNGRMSnlIWHRZbnEz?=
 =?utf-8?B?VUpXT2trM3g0QVRmbXZhczhialNSc1lwOWlVSVNwN1l2S2xyaVlHY0kxenI3?=
 =?utf-8?B?NkFGT0YwZU11d095UFg1NXN4cWVYS2g1YWowbGo1cVVIZUkzWHN0WjFRaytI?=
 =?utf-8?B?TjZkNHk4bWlWQS9uYzE4V0dZOWFRVXBOVUtaSzlXaFFkaDZmNGV0cStSTW9a?=
 =?utf-8?B?b21CUEU3aTRYbXRyZ29FQ29HQXhtTDBMZjc5aWZUZHdaRXlvdG1hZWZHU0lE?=
 =?utf-8?B?NkFzSUVHaUcwQnZSNmExRGgwSXF0Z0txK0dNeENiR01obTFFVTFndEhoeXVY?=
 =?utf-8?B?UEhFWGpYZlpZdlBCNmZWZ3pZRitTQmljb1JRZ0I0WFEvQm1OMXg4Z2NoSmpp?=
 =?utf-8?B?djlDMkYwNE5oWGwvOVdCOEdscS8rRXVpY2ZtT21xUmNBMk5zTTJMVjUxUHBh?=
 =?utf-8?B?Q1cvS0djWkRtMi9YbHp4Vm5zMTRubmNReGk2bEhVVUd1bkxWek84RkFDS2w4?=
 =?utf-8?B?Q1k4dzVlVEJKUmFsN29KRzVIdlNtZTJLYnR1ZGdrUjRKbExGUkhKd1V5WGdN?=
 =?utf-8?B?SXBzVER6YitEUVpjSi9Ca3NmWlQyOUlMdDBhTnVlOTEzYlRQSVV6NWdVYU1s?=
 =?utf-8?B?bURpeTVQZmU4T1I2Z0V4ZnRRNUN1clhhNzcvZSs2cXRmb2hmclVzTHdDN3Vp?=
 =?utf-8?B?cThRa1ZqQ2lsMmtTdUQ2bDRHejIxSU9JKy9vSThsVU1UczNzY2RZUjFFTkFQ?=
 =?utf-8?B?eVAvWUpWTklEL0FRR2M5ZVFTdXl1Q3dSYmNSclZtTGl2c3AwTUQyS281eU84?=
 =?utf-8?B?V1pjSjlvQzVLYWtucnQ1Z0dieGlRWlM2QTZoK3Y2VXg4TUJOQjJyQUdwU3Nm?=
 =?utf-8?B?ZE5lUUJuSFJQWnRQeHIzditNaUdJMVZoUXNPanpnMDd4bjIwUjhlRHE2dzhT?=
 =?utf-8?B?dC9tNCs0VVdlMFRyTTZNREFOdlhpYWVsTEZ2SStTMzBpL0VyZjF1VU5CTU5L?=
 =?utf-8?B?UCt0ZFV1QlViajgvbnZDK3RoZXhPWWJ4ZzZyMFJ4eFNwZzBQMlg1U2FIeVhD?=
 =?utf-8?B?b2ZwcTdYU0JRSlBMamx5b2E3OFlPK2hxL3pna3FCTGRjL2UyeG0wZlRxdUk0?=
 =?utf-8?B?SlJjelVWdjN6amplektZaURXcEVURjlHVlNvV3U5YldLNmF2dHJRejNEZ01K?=
 =?utf-8?B?WHcwNWdhbUJuTjIxRGRWakRGYUpsbDFmZEZ4VWk4SlQ0WE5iSTExL0N3NndI?=
 =?utf-8?B?aGhaUDJNVVl3L1U5RXYxaFMxdm9vUTBiS0gzVGZUcW00Y3RnY09hU05uOFkz?=
 =?utf-8?B?MzdUb1pBWW9qSzRlYTZlcC9LVEl4MjBacTZxQkFqZDEyQjZ3TWl5eERmNXlT?=
 =?utf-8?B?SUdJUjFWWkVSR0drVU9zbXpRa3k5MFZ2WC95ZVN1MFRCTWlFQ3FXaHlmMU0z?=
 =?utf-8?B?aWJwS2M3TjVFNGRpOERiRFRFbmJCVmFacXRPOHlINWNMeFNDZzRHbGZSUExs?=
 =?utf-8?B?RUF0bUo2RXVUUlhTdlZSbHl5NGxYa2w3RU13eE0zN3ErVm9RMnlDUkloWWhO?=
 =?utf-8?B?eC8zRVVMM2EzamEzRHEwM0EySmYrV0p0aHlFaHpGbjJwVW5TYWVRbTR5MGxV?=
 =?utf-8?B?WERNeWZxTVRCek9rK0RvdnFwdUdzUnZUR0Z6ZUpXTzFqelM4eXJoSWJiWVFm?=
 =?utf-8?B?ckVmMnpvWGJEUWhJa0hZQ1hhNzdyaXdOTzlSUXZxaXdLb1Z5a2RUaWJGdTVk?=
 =?utf-8?B?dFhWZUIybmNBK1V2eTlKcjRMWGpHVTFBRVFPMk15bVFoMkFYbGt2enc2R1hE?=
 =?utf-8?B?SC9hYnQ1YWkrSDI2RzdnYUhBVWIvZmREUVhKanVqVVFSeWNhK0ZRNGUvenF4?=
 =?utf-8?Q?NLbLFmJQwSQj9mjTTAXEMPfPx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a216db63-b77c-4e13-d0e0-08dda1a9d12a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 07:48:09.0096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86Un3wg1uvLAo6vdBBXNOyPrEe4modbnaxtn2QyF5sbcBfw788onafFsefpupHkU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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



On 4/10/25 10:25, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Gpio status command reads the DATA_RO register rather than
> DATA registers even when the direction is "output", fix this
> by reading from DATA register when direction is "output".
> 
> Signed-off-by: Nam Ian <ian.nam@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/gpio/zynq_gpio.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
> index 7db58c70663e..4fdce39d91b6 100644
> --- a/drivers/gpio/zynq_gpio.c
> +++ b/drivers/gpio/zynq_gpio.c
> @@ -64,6 +64,7 @@
>   /* MSW Mask & Data -WO */
>   #define ZYNQ_GPIO_DATA_MSW_OFFSET(BANK)	(0x004 + (8 * BANK))
>   /* Data Register-RW */
> +#define ZYNQ_GPIO_DATA_OFFSET(BANK)	(0x040 + (4 * BANK))
>   #define ZYNQ_GPIO_DATA_RO_OFFSET(BANK)	(0x060 + (4 * BANK))
>   /* Direction mode reg-RW */
>   #define ZYNQ_GPIO_DIRM_OFFSET(BANK)	(0x204 + (0x40 * BANK))
> @@ -230,7 +231,7 @@ static int check_gpio(unsigned gpio, struct udevice *dev)
>   
>   static int zynq_gpio_get_value(struct udevice *dev, unsigned gpio)
>   {
> -	u32 data;
> +	u32 data, reg;
>   	unsigned int bank_num, bank_pin_num;
>   	struct zynq_gpio_plat *plat = dev_get_plat(dev);
>   
> @@ -239,9 +240,15 @@ static int zynq_gpio_get_value(struct udevice *dev, unsigned gpio)
>   
>   	zynq_gpio_get_bank_pin(gpio, &bank_num, &bank_pin_num, dev);
>   
> -	data = readl(plat->base +
> -			     ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
> -
> +	reg = readl(plat->base + ZYNQ_GPIO_DIRM_OFFSET(bank_num));
> +	reg &= BIT(bank_pin_num);
> +	if (reg != GPIOF_INPUT) {
> +		data = readl(plat->base +
> +					ZYNQ_GPIO_DATA_OFFSET(bank_num));
> +	} else {
> +		data = readl(plat->base +
> +					ZYNQ_GPIO_DATA_RO_OFFSET(bank_num));
> +	}
>   	return (data >> bank_pin_num) & 1;
>   }
>   

I have looked at Linux kernel and there is different logic. It should be syncup.
Second. I agree with Mike that what we need is to read actual value not really 
value which has been written.

Thanks,
Michal


