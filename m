Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6FAC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 06:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B6E88498;
	Fri,  9 Aug 2024 08:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qj8eZ4RM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F024C88481; Fri,  9 Aug 2024 08:03:49 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1164788481
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 08:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKpLoQTn7OjvV0qzI96X9/KbmUY+6SJoZFpCpxWX9bw6LxvdOY8kGPgp7hVHRUALD8nWCMM7FgVsBLWezG84CSt/UkqKRl97XOwF2pb4wd4p6q7C0uGUspHLUFr5dKj8K5zwWfIxfkuUKLLknQrKOad6a0gBGWLHH8+ekefETsfDaVr4Ju30L8Dar3G9e0LK+5oNe1EI+y5zk8XqTx8z7TiTrlY6XYPczib6bgZnxRBYgpSC0sEWZaskt9Rilq1cdcTmhMFeGT4ZrbVkvdOPx6rNj15NJqNb4aUEvRqx0lATQRnJRf6sNuL1YuPtxq7FQ5XbzwwnslfFcV7OCsdQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4OKxPHtWLw1ZuV7WV/QLYo8xkYQ9/8cvq1SDU+AlHA=;
 b=gqwmH5gSvz+SiyqNNe6WKVohxzFHmCU2vb9Yw5w9qAvvlIaNTXPoYG6mdZc672FN9s6R36v28Ygc+rRsKlh6k7JVUjZP303HexuabjvBlal9b7o1nyslUKfvNJ77jaLEhjvMJnBu151fpIX0Ekje9qen9pnKD051IUpZltl/7ewQ4V9Lq+vJKGB/lhyP27No7zjJV/cHaViRpMCqwB8/aJB1Qs7s4RTfVpB/eKacyqv5i92Mqnsgvor7wXwyA5CNLtRjkbcB5cGraMJ6Sc/Uh4Npyu8FStzO1oNzx9O9mPBwo8ZHrpbhmpsAixYrZw8k1OhhDBtAVCoJLOZex7uq+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4OKxPHtWLw1ZuV7WV/QLYo8xkYQ9/8cvq1SDU+AlHA=;
 b=qj8eZ4RMqb2fTwmvkoSgYQckZO6EfOwNa8ahHvBCwXIRIgTgaJ0SLlZmq1wJxg+fp/YvUBDCqR+2n4fvr1JG4OS2SYPlo2KVJAKQ78YXkpbRnP7np36tG8eivdn9n2aRyLQMpsLCW+SrPO3I+nrBRYyWGQb4qqx2kgxDkwCh1dw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 06:03:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 06:03:42 +0000
Message-ID: <393726c8-18d3-4510-82f2-fe99c0d55d44@amd.com>
Date: Fri, 9 Aug 2024 08:03:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: add a fetch utility
To: Caleb Connolly <caleb.connolly@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Anand Moon
 <linux.amoon@gmail.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240808163153.2069650-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: bcacd978-dd66-4f30-63f5-08dcb8390554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTZxQ2FnSUZzelVlcW9ZUEo5ejhjZEdzWmY2S0pNUWk4NGE4K1Y5UjFzaW56?=
 =?utf-8?B?ZVQxRFJtZDVMWk5KcU1SYTRHbSs5YU85UzkxSy8xSEhHdFQzMHlOY2tZNUg0?=
 =?utf-8?B?R3RKUGdtSUo5aHJKZ1o2RVpNdzNFblY5MTVEN2p5cENpcHV0eUtTUXdFVzlz?=
 =?utf-8?B?YlY3ZENxNStIeTRER0lOSE5ZeVhKSmZHMXViKzJ2TnlyempNNmoxYVlnZWg2?=
 =?utf-8?B?RFdDclpZTkdNUlJqN25FSGVoaUFCYm5QbWlDL0hlSGsrSEhTT0p3TUVsdjVq?=
 =?utf-8?B?Y2pQeGQwOXM5cnI3eHJXVDRwb25ESXR2ejJHM2F4cVpCZ3BobjFKQkVCK1Fm?=
 =?utf-8?B?MlNWZnVGLzJpWGJCWEg3NTZjVVNic2hqaUJsVDBNdG1aSi96dGpYZkZZYUlT?=
 =?utf-8?B?TEY0TCtzMmJ1bWdkaGFhNk1VTU04ODh2cjhzRDdnREsrcm9tTzlTandDaXM3?=
 =?utf-8?B?K0U1dGRMeE9WYkR3ckx2OHNFQk9oTnFOMHVXWWVpbWZtejU4QVl5ZG1VS0dR?=
 =?utf-8?B?N2Vvb2J4d1dPTUhRNWg3NHdQcm1XZWRKYk5lRGRvYllRUFo2RWpyT0hRQzZJ?=
 =?utf-8?B?N2RaYUFuTEdISjVhaWhSUUhJVDBseUIxdkJQQXpESE0wUGRLc09oekdCalZp?=
 =?utf-8?B?ZFl5Q2h2OC93RXdDdzdSd1hZR2NtN3RMUTA1QlNvUmJoRjAwV2tVWjVoTjVv?=
 =?utf-8?B?S2w3VGpqZXhEMkw0NkxzWWJJZDJhWUk0eTcxWXpJZS80bVErRWUxODZzNzlX?=
 =?utf-8?B?TUY3MzhBQzJVcGFNaEhWaGcxcE85eWF5Y0txWnRLRVRMOVVud1hPTEFDaUZu?=
 =?utf-8?B?ek1wT3A5VFFhdndZOEh0MklWdktwaFJtZyt3akFMQUZmRzBZOG9WazFCNDF2?=
 =?utf-8?B?c0hrN1cxRDhGdjFndWNZQThZdnJqQkRGR2sxQm5iclcwN09YQ3pEbWxnUFBs?=
 =?utf-8?B?NGtXSXVwK1BUcGxQMkl6MlZFSjRLZnQ0Zm1sUXZiVEIvcjNTWXJoNTFYT25x?=
 =?utf-8?B?dEEyOFdFVy9KT0lnNkdla1BCZHo0MUZZQVR4THhRNENiTjNHZE9sUTZiU1FW?=
 =?utf-8?B?N09WVHhUSUNCREZMc3ZJVHd6YkFFZmFLV1BtWmJPMUFtaVdlQTNFdFl6VGR4?=
 =?utf-8?B?SXFKWjV2NFhnUUoyd3Y5Y2kzd0YvWTRpSDFoWUZkMkxpR3Jpc2RTbFRGTTdI?=
 =?utf-8?B?SHZVSG42emRqZ21nQ2ZzekorTWREREd3R2xwQzNQYjU4YUhVMFNGWVlLd1N0?=
 =?utf-8?B?UE9MblJPUlo4UUVodUl1cjJ6Y1Yzd0hMOS9xWERoK2YzMVNZdWsvblh6MjFH?=
 =?utf-8?B?dHk1R0hCYmc2SE0vcVQwaVlJY3RtQ1VySGJDcUh1NXRYbXppNVZZT1ROUEZF?=
 =?utf-8?B?YTFXeTg1c21YSUIxVUtSUE1RU2VCYVI2L3ZnbXppZVU5VXpSeVB4eUhkNmto?=
 =?utf-8?B?UENleE1EandYNGlMcDdoZXRFR1FKeGVDV1lvUkVXYlAraGZpMUxGSUo1aDF3?=
 =?utf-8?B?bEQwd1ZIcVR3RjR2MHFOUmN1eGh6eWxubHJwMWhZYUtZdEdMWGRQMUVKY1pp?=
 =?utf-8?B?L09IMzRST1FKb1cxTklvL1pmbFJWS05Ydis5eVM2SlpxM1J4aVFzamxia1dI?=
 =?utf-8?B?TmMwcWZha2RCU09uZmcxMWxSRWVUdGh0ZjVzTTVFekUybnVLMjBqNzhQcHJS?=
 =?utf-8?B?NGhXUVBHUENnYjRqcXhORlVuZ1VlUENzeGtlSGpiTkNYOW9ZVHFkQmxqZ3hF?=
 =?utf-8?Q?JPc5y7JzIuHwMvkW7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVd3NHhzeExBdXB3QkhFWmJwWmF5ODFaeVBRcVRtQTgxbDZOZk1XUm9sK05R?=
 =?utf-8?B?ZERjYWtpN2hYS3dod25pNjhMQWxpaGVCSEE5d1ArSGpycHhrWTNDM1JhbTN6?=
 =?utf-8?B?eUpwUFZGUDNyYWpLQXoxQjV6MU5PRVZiVnF0K0QzRlRWRHIrbjBvU1U4cUdo?=
 =?utf-8?B?Y0tzb3IyQ3U3c0Z2dUI4YmNQdE5Mc3VDaXE4R1RDOUZaaE5RTzRUb0piYXRK?=
 =?utf-8?B?M0IzVUE4RmlxTmxoNlp5Y0ozTWZjL25OSkZsTnM3UzRXbWo0VjZ3dTNvaVlh?=
 =?utf-8?B?dFIxR1gwM0F4N3U4RlNmZkxrVHFZOC9objlCOGtOMVZCYzd1dTRYQ0tEN2tS?=
 =?utf-8?B?SW5mUjVTa0hwWUFEblViQzJnb2xIdGkwTjNWK2ZCZkFxWWJjY1lUYW5NQ1l0?=
 =?utf-8?B?bDdmSGpCR3N0eDRXbWVSS05XUTNZVjVQaWl6MWpla1c3cjN5TXZaYTcxd1g0?=
 =?utf-8?B?aGVpUmRZbUVQK08rd1pkM0RCM1h0M1pQMUFWUmcxRFRsckhkWE9ZNEs3V29G?=
 =?utf-8?B?Q0FIbTVyMk1oYTN2aG50eE1UWjY5KzVEUFhwa3JGam9XSUdscmlCSlN1emN3?=
 =?utf-8?B?dHpNWnpmdVBQcmNyYmFqWU91SjZOcjJKYU5UbE9XWEw3VFNJMlgrbXhFblNL?=
 =?utf-8?B?c0FFUkhWWkFadys3TUtQaHBFY1JkbG1ON1pDa0lCTjhsWDkxSDFFRytlMlRn?=
 =?utf-8?B?RlZYaHVsRlRLMStiNVMvcFNmMTNYSVJ1cE5jd09xT1BiZlNVclVLWUxXS0Jr?=
 =?utf-8?B?bUZWU3pCakJCVGFITmhpcFo0SldPc2d4a24xL2gvc3N4VnVva0lRdUdyQWxC?=
 =?utf-8?B?VFE1ZW1TdmtDcWNjZk9zbCtzanZwY2lsVGNMRzhMVHp5N1ByZ3pmYWZWTURs?=
 =?utf-8?B?WWV6ejVCaytHNEoybmNBS2tEQTJlbHVLRzZhb29lNVVEdzZNUGI0YVdqZlJL?=
 =?utf-8?B?K1VLeGk2YWxCWmtHOEEwWXBMVzRYN2ZKVEwvalhncEMzNGFpSnBWcFpqV0VU?=
 =?utf-8?B?SFcvd2FScG5RYm1rR1JNRWQrVDBnS0RWRmNjbGZmc241bXV5RmlJMElDMXlU?=
 =?utf-8?B?Mm1rNnZZaXRSRXAyL3dtWXdWZ3VZTWpabjBZQVpacE9SY1lEOWx5Vm5uRnNS?=
 =?utf-8?B?SjV0VitGYVZ3YlB5dWdwV2MwM05lTS91cUNFU2RMQTJFeGlLNVdCUXNJbG9z?=
 =?utf-8?B?QUhMVW1SdTNxZUw5K2ZXRDBYU2ZGYVNLaEFEbm5WSEhJdDNzckNzRHJBTVNi?=
 =?utf-8?B?S2RCZmRuZkppQ25ZT3ZJb3NkOEtLdXgxRUorSkxlWGNQS1NOcWJWRXo1U1JQ?=
 =?utf-8?B?clM3aU9DK0FNUjVUczNpMnAxOTBRMGFYNk5DeWpqZXFMOElKaWhvVmZHclFE?=
 =?utf-8?B?TERlZktqLzc2eXJISlErVHZEcWJzOVA2cmFJQ2pUaVB0L1JpVVViWC9Ndi82?=
 =?utf-8?B?RGRIK2ZvUEd5YlBlbXZWNjFBQmRrSGZ3OFJsU29uQ21ZeUZWT2p5dm9vTkJh?=
 =?utf-8?B?U2h0NFEwRHRhQjNRY0tXaEZ6clJvd3lBVDhCZis5aHlEMDI2TFBEUWlSbmRI?=
 =?utf-8?B?ZVlUOGkydnZyWkdPcnZ1YUxCOUZHZUV6RWYxRXcrbTdLREZRVk1DTFdvOVNI?=
 =?utf-8?B?K2NwdlU0N3NoVENpR0drYlpSU3E1NE14M3ByUmprT1crM0RPL3JrdXdrbDNT?=
 =?utf-8?B?SmRZQUdRVnVzYk1zUUdkejVBelBJdFovNmRKblRITExMZVUyZEtqNDdkWlpW?=
 =?utf-8?B?VUZoWENxNTR6MWx6bVVDdUFrYjRySGlPQVQwbk00b29xaUxZSnEwQkUrWjUy?=
 =?utf-8?B?VjBCZmdSWGRWd0R3allnamZQZmFLV3l3UU5qQjFtYW5pbThYd2hsOVk3R2N4?=
 =?utf-8?B?bEJLMS9vTDhudkc3Yml0aFducU9nc1NpSnNtcG5VQTZJcnFoVUFaQ1k3RTJp?=
 =?utf-8?B?blJackdZM3lGYlhsVW8zNGxCd2wxSnZrQUQzNDcrMEhjQ0FmbmU5aEp2TWQ5?=
 =?utf-8?B?U2h4OXVOdDlYUUZxdzBhT1VHMWVBYmdmSFVIeGhqNW5RQ1Y2YXNSc0RFZ09W?=
 =?utf-8?B?YW9CMFlVRU1YYmhYWm8vZ1htMWluWEdlQm00ODJEcjBncU1zN1JINkZTYjBO?=
 =?utf-8?Q?+5YDr0e+0H1/0OXyOoTARSVmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcacd978-dd66-4f30-63f5-08dcb8390554
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:03:42.2629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08SXnXHDVKNDGCEMZD5gS1tzOUzmzym6xcpGqmlVGHxz3asjxMieRB7HQoVIef1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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



On 8/8/24 18:24, Caleb Connolly wrote:
> While U-Boot does a pretty good job at printing information at startup
> about what hardware it's running on, it can be hard to take pretty
> pictures of this to show off on the internet (by far the most
> important aspect of porting a device in 2024!).
> 
> Add a small utility "ufetch" for displaying some information about U-Boot and
> the hardware it's running on in a similar fashion to the popular neofetch tool
> for *nix's [1].
> 
> While the output is meant to be useful, it should also be pleasing to look at
> and look good in screenshots. The ufetch command brings this to U-Boot,
> featuring a colorful ASCII art version of the U-Boot logo and a fancy layout.
> 
> Finally, tireless device porters can properly show off their hard work and get
> the internet points they so deserve!
> 
> Not everything is fully supported yet, but this seemed good enough for initial
> inclusion. Only one MMC device is detected, and other than SCSI other storage
> devices aren't supported.
> 
> [1]: https://en.wikipedia.org/wiki/Neofetch
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Ephemeral demo image: https://0x0.st/XVUa.png
> ---
>   cmd/Kconfig  |   7 ++
>   cmd/Makefile |   1 +
>   cmd/ufetch.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 209 insertions(+)
>   create mode 100644 cmd/ufetch.c
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda426..70acb5727b04 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -175,8 +175,15 @@ config CMD_CPU
>   	  number of CPUs, type (e.g. manufacturer, architecture, product or
>   	  internal name) and clock frequency. Other information may be
>   	  available depending on the CPU driver.
>   
> +config CMD_UFETCH
> +	bool "U-Boot fetch"
> +	depends on BLK
> +	help
> +	  Fetch utility for U-Boot (akin to neofetch). Prints information
> +	  about U-Boot and the board it is running on in a pleasing format.
> +
>   config CMD_FWU_METADATA
>   	bool "fwu metadata read"
>   	depends on FWU_MULTI_BANK_UPDATE
>   	help
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 87133cc27a8a..ffb04c8f2e0a 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -53,8 +53,9 @@ obj-$(CONFIG_CMD_CONSOLE) += console.o
>   obj-$(CONFIG_CMD_CPU) += cpu.o
>   obj-$(CONFIG_CMD_DATE) += date.o
>   obj-$(CONFIG_CMD_DEMO) += demo.o
>   obj-$(CONFIG_CMD_DM) += dm.o
> +obj-$(CONFIG_CMD_UFETCH) += ufetch.o
>   obj-$(CONFIG_CMD_SOUND) += sound.o
>   ifdef CONFIG_POST
>   obj-$(CONFIG_CMD_DIAG) += diag.o
>   endif
> diff --git a/cmd/ufetch.c b/cmd/ufetch.c
> new file mode 100644
> index 000000000000..f7374eb2e364
> --- /dev/null
> +++ b/cmd/ufetch.c
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Small "fetch" utility for U-Boot */
> +
> +#include <mmc.h>
> +#include <time.h>
> +#include <asm/global_data.h>
> +#include <cli.h>
> +#include <command.h>
> +#include <dm/ofnode.h>
> +#include <env.h>
> +#include <rand.h>
> +#include <vsprintf.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <version.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define LINE_WIDTH 40
> +#define BLUE "\033[38;5;4m"
> +#define YELLOW "\033[38;5;11m"
> +#define BOLD "\033[1m"
> +#define RESET "\033[0m"
> +static const char *logo_lines[] = {
> +	BLUE BOLD "                  ......::......                   ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "        .::::.:::::::::::::::...::::.::::.         ",
> +	BLUE BOLD "      .::::::::::::::::::::..::::::::::::::.       ",
> +	BLUE BOLD "    .::.:::::::::::::::::::" YELLOW "=*%#*" BLUE "::::::::::.::.     ",
> +	BLUE BOLD "   .:::::::::::::::::....." YELLOW "*%%*-" BLUE ":....::::::::::.    ",
> +	BLUE BOLD "  .:.:::...:::::::::.:-" YELLOW "===##*---==-" BLUE "::::::::::.:.   ",
> +	BLUE BOLD " .::::..::::........" YELLOW "-***#****###****-" BLUE "...::::::.:.  ",
> +	BLUE BOLD " ::.:.-" YELLOW "+***+=" BLUE "::-" YELLOW "=+**#%%%%%%%%%%%%###*= " BLUE "-::...::::. ",
> +	BLUE BOLD ".:.::-" YELLOW "*****###%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE ":..:::: ",
> +	BLUE BOLD ".::" YELLOW "##" BLUE ":" YELLOW "***#%%%%%%#####%%%%%%%####%%%%%####%%%*" BLUE "-.::. ",
> +	BLUE BOLD ":.:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%#*****##%%%#*****##%%##*****#%%+" BLUE ".::.",
> +	BLUE BOLD ".::" YELLOW "**==#%%%%%%%##****#%%%%##****#%%%%#****###%%" BLUE ":.. ",
> +	BLUE BOLD "..:" YELLOW "#%" BLUE "::" YELLOW "*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#%%%%%+ " BLUE ".:.",
> +	BLUE BOLD " ::" YELLOW "##" BLUE ":" YELLOW "+**#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%* " BLUE "-.:: ",
> +	BLUE BOLD " ..::-" YELLOW "#****#%#%%%%%%%%%%%%%%%%%%%%%%%%%%#*=" BLUE "-..::.  ",
> +	BLUE BOLD "  ...:=" YELLOW "*****=" BLUE "::-\033[38;5;7m=+**###%%%%%%%%###**+=  " BLUE "--:...:::  ",
> +	BLUE BOLD "   .::.::--:........::::::--::::::......::::::.    ",
> +	BLUE BOLD "    .::.....::::::::::...........:::::::::.::.     ",
> +	BLUE BOLD "      .::::::::::::::::::::::::::::::::::::.       ",
> +	BLUE BOLD "        .::::.::::::::::::::::::::::.::::.         ",
> +	BLUE BOLD "          ..::::::::::::::::::::::::::..           ",
> +	BLUE BOLD "             ...::::::::::::::::::...              ",
> +	BLUE BOLD "                  ......::......                   ",
> +};
> +
> +enum output_lines {
> +	FIRST,
> +	SECOND,
> +	KERNEL,
> +	SYSINFO,
> +	HOST,
> +	UPTIME,
> +	IP,
> +	CMDS,
> +	CONSOLES,
> +	DEVICES,
> +	FEATURES,
> +	RELOCATION,
> +	CORES,
> +	MEMORY,
> +	STORAGE,
> +
> +	/* Up to 10 storage devices... Should be enough for anyone right? */
> +	_LAST_LINE = (STORAGE + 10),
> +#define LAST_LINE (_LAST_LINE - 1UL)
> +};
> +
> +static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
> +		     char *const argv[])
> +{
> +	int num_lines = max(LAST_LINE + 1, ARRAY_SIZE(logo_lines));
> +	const char *model, *compatible;
> +	char *ipaddr;
> +	int n_cmds, n_cpus = 0, ret, compatlen;
> +	ofnode np;
> +	struct mmc *mmc;
> +	struct blk_desc *scsi_desc;
> +	bool skip_ascii = false;
> +
> +	if (argc > 1 && strcmp(argv[1], "-n") == 0) {
> +		skip_ascii = true;
> +		num_lines = LAST_LINE;
> +	}
> +
> +	for (int i = 0; i < num_lines; i++) {
> +		if (!skip_ascii) {
> +			if (i < ARRAY_SIZE(logo_lines))
> +				printf("%s ", logo_lines[i]);
> +			else
> +				printf("%*c ", LINE_WIDTH, ' ');
> +		}
> +		switch (i) {
> +		case FIRST:
> +			compatible = ofnode_read_string(ofnode_root(), "compatible");
> +			if (!compatible)
> +				compatible = "unknown";
> +			printf(RESET "%s\n", compatible);
> +			compatlen = strlen(compatible);
> +			break;
> +		case SECOND:
> +			for (int j = 0; j < compatlen; j++)
> +				putc('-');
> +			putc('\n');
> +			break;
> +		case KERNEL:
> +			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
> +			break;
> +		case SYSINFO:
> +			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
> +			break;
> +		case HOST:
> +			model = ofnode_read_string(ofnode_root(), "model");
> +			if (model)
> +				printf("Host:" RESET " %s\n", model);
> +			break;
> +		case UPTIME:
> +			printf("Uptime:" RESET " %ld seconds\n", get_timer(0) / 1000);
> +			break;
> +		case IP:
> +			ipaddr = env_get("ipvaddr");


ipaddr here.

> +			if (!ipaddr)
> +				ipaddr = "none";
> +			printf("IP Address:" RESET " %s", ipaddr);
> +			ipaddr = env_get("ipv6addr");
> +			if (ipaddr)
> +				printf(", %s\n", ipaddr);
> +			else
> +				putc('\n');
> +			break;
> +		case CMDS:
> +			n_cmds = ll_entry_count(struct cmd_tbl, cmd);
> +			printf("Commands:" RESET " %d (help)\n", n_cmds);
> +			break;
> +		case CONSOLES:
> +			printf("Consoles:" RESET " %s (%d baud)\n", env_get("stdout"),
> +			       gd->baudrate);
> +			break;
> +		case DEVICES:
> +			printf("Devices:" RESET " ");
> +			/* TODO: walk the DM tree */
> +			printf("Uncountable!\n");
> +			break;
> +		case FEATURES:
> +			printf("Features:" RESET " ");
> +			if (IS_ENABLED(CONFIG_NET))
> +				printf("Net");
> +			if (IS_ENABLED(CONFIG_EFI_LOADER))
> +				printf(", EFI");
> +			printf("\n");
> +			break;
> +		case RELOCATION:
> +			if (gd->flags & GD_FLG_SKIP_RELOC)
> +				printf("Relocated:" RESET " no\n");
> +			else
> +				printf("Relocated:" RESET " to %#09lx\n", gd->relocaddr);
> +			break;
> +		case CORES:
> +			ofnode_for_each_subnode(np, ofnode_path("/cpus")) {
> +				if (ofnode_name_eq(np, "cpu"))
> +					n_cpus++;
> +			}
> +			printf("CPU:" RESET " %d (1 in use)\n", n_cpus);
> +			break;
> +		case MEMORY:
> +			printf("Memory:" RESET " %lu MB\n", (ulong)gd->ram_size >> 20);

This is kind of shortcut (and nothing wrong on it)

In my case I see 2GB here but board has 4GB which is properly shown via
show_dram_config() as

DRAM:  2 GiB (effective 4 GiB)

Maybe you can simply call this function to get the same information.
Also I see that there is board_add_ram_info() called which can provide more 
information.

Thanks,
Michal
