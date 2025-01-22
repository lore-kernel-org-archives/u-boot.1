Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E0EC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C768680805;
	Wed, 22 Jan 2025 16:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vbf1e9HD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F6180817; Wed, 22 Jan 2025 16:59:08 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30F9807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:59:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkpu4FSZpe1ClEZE/Tz7gnjeyAu3ingKNmrBH6fxX9CrXIsgkapH4NnFV7ONl9exZO8rhushVieQIZrdxPpNLhnQthx7DdnQWWVaI9dCiNi4dhVNthJjG/ovamGLm9eh9ecttNQTPeFNb1TWEQ8G14hX5IFqv5GzxREdrEZ3jVWtQ1X9fwLY1tAIE/9rHHba2bx/yG2Kw8dWJnfB9ceiPMaB8lul6zVNmmUGSrY70N03yYgz1dYDNcaNAsJy22FUPpEBtSinc//VAolR64etfZAqFwR7pW/WvF/c+QC/2Z9A1mZCULfE5mCGp+bT2kQ0BTUnAvCo6/w/7aZzIQQnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TkXJ1/CsR25eBr2KAxtqT/GLCD0d4ONymkCaali418=;
 b=Vf1bI9t2hgqc+XL2FJqsRixEGnULbE6ddpouq/ipjVWZdk7re3sp/4RgGIm+PRo/pDgTImBfPFmsZogpx0o+2/6JEyxGeo3lum80cQbTeqETW5Ey8Bgr4e/5uIdWYnwEH9geiBM5XBF1pjHruQcv37VYpj61aWOepoiEyLwx5P2HlygNfvbpcdJ0L+i6gcJ4odyTJcUNXTMrE9WenwyRMXxUQWoTjibBXrrj/PZuLzqum3454JFn6BZozQQKcPfADFx6jggbXbjyb0lhbbwjz3KptTPk3AIaIkO5hcb9Kz0TOLDizkpp7hXEHheh76rgUOZLfcY8CL4E/iFDhpKDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TkXJ1/CsR25eBr2KAxtqT/GLCD0d4ONymkCaali418=;
 b=Vbf1e9HDZwYTem1lczhrFfd5V9ChJ8bOtgxYd8n/94tWo1WQmDIFZA6E78UP0qa+EuhFjSfK1nqPdy+c8N+Rm5kFKr+IdQKBJkGVm6zqLWnnl6Yc9CmaTLpLBcez8RE+kY3Y5tZPGe8HKfCBGscKLTwOnmALX5dOXGv4yqCZ3XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 15:59:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:59:01 +0000
Message-ID: <7cc4bb17-389c-482d-9bbc-dbdc563a1627@amd.com>
Date: Wed, 22 Jan 2025 16:58:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: Add missing prototype for
 cadence_qspi_flash_reset
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, git@amd.com
References: <20250122135334.1201562-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250122135334.1201562-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0132.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: f983197e-9038-4c4b-ce53-08dd3afdb06b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0R1RHQydzFmTVBzN2hDU3p2L0doSEtIWGE1NFBLdGs2QzVXYW10K2xKRWtH?=
 =?utf-8?B?VktjM3BZazIrU1ZVZVcvcHY0dHNnVHlqM2l3LzBiemRZRllZVDBWNW9JQVNx?=
 =?utf-8?B?SDlFVXJYdXBlNGVRWEZlNVp1aXZxYUVBUHNDSTRQRTVMT3NRc3hXd2tMWGsv?=
 =?utf-8?B?Qi9pVlJmb1h1VFRFNFRSbU0rMXgvdUNXRmxnb2xpWENjS2ZJcVY0QWhtbmQw?=
 =?utf-8?B?b3hDSEs3M2ZLeDBvb1d5RGU2ajNCWWFsM1FteXhaakVZcUt1Mnp6ZzlqUkw2?=
 =?utf-8?B?dlR3TW5TcC91WmRYc2hKUXlDU3A4Z3pZbHd2MlJyRkdLK0l4MGZ4RDRhaVds?=
 =?utf-8?B?a0FjeFFPdXViUkRyY0R6WElsZmQ1QjFDblc2cndFK0NDQWtid1lmWS9mNXlh?=
 =?utf-8?B?MVorakpNRWdsQ3NrRTFYM09CSEdxMlBLVDJ0WklVWU4yclhxVjZBckw4WU1s?=
 =?utf-8?B?K0dmcmJ6T1VLZ1hDaklHM3RsRGZtODIyakZiVmg4c1J3QnJCdzYwYTRFM3Rs?=
 =?utf-8?B?cXR2MHYxTnQzVVNtb0g1aDJIZ09xZ3VjMnBFc0VXWU9JTGJlb1hVdEVXUSsx?=
 =?utf-8?B?aWpMdTI3NTZvVkI2Vml3amVSc3BPWmRsenZ0Z0FTZGJRN054M3V1bDJ1b2lh?=
 =?utf-8?B?dmpDbEJEdi9lN0NvbHYza0E5bCsvYUtqUjJKbUljOWlLVUg1TUovMlo2RUJT?=
 =?utf-8?B?TWY3SGxUL29aMndsWS9YUjVhMjRaOGNkOUtUZ1orMTNKVXMzNnoyTVA1ZlRv?=
 =?utf-8?B?eDNHNytiRUczcUFINklUbHhHK1doRzd1Wjl0dW9PNzVGa2FCRlJLbk5PNzBl?=
 =?utf-8?B?M3R2TVMzZTRuNlNzMEZIanQwYVN6K0x0U1hnWnU0MWpYWTZjUEEySmRYZTlp?=
 =?utf-8?B?c3lvK29aVGtUMzlyd2tKdHliWVpFM1lTdzZWR1g0dHVtcVdKUUpuSkI5TVJR?=
 =?utf-8?B?Sy9jcE5xU3BldG1GWWRWNk1oV1d4QVNjZVhoU3k2cEphanAwVXBTYUNoQXU5?=
 =?utf-8?B?U09lVXlSSFNxbzFFQWdIeVhCcEdwRkhWZXlMbnEwekwybXowekR6U25SUDFo?=
 =?utf-8?B?ZVZ0V0k4aTRjOExUSmFhTGl1ZDBjcm13bDdrelMxM1pZMEhZVTMzcloxSGVF?=
 =?utf-8?B?YlYwYXZ5WEFIWHZZUWpKT2k0WHhFSlFSR3ZjYlZPYVQ1YzJyeVRFK0dLVU5h?=
 =?utf-8?B?U0JYSzNFTk9IdStBZ3d1KzJhQnFmdmJHWDF1NDdlQXl6Q3J6Z242UTArMEhz?=
 =?utf-8?B?RkQwZ01ZL0tOOVZTNHVQOXR2dU01MHJ2SVgxUTNFd24zNzBjay8xNFJZQzZn?=
 =?utf-8?B?UTgvdHVqei9zU1BXN2JUZjIrRGtlQVlkUEJ0RW1Wc1R5MnZQeEIweXZhY3F1?=
 =?utf-8?B?cTVYY3NpMTR6Q2VFVHR4djhxeTBtMFFhMkpmQ2szRHJyZ3Z4bjc4SGMvaHlk?=
 =?utf-8?B?S3lVRmt2TkdwYkV1a1RxUnVZTXUxMGJ1ZGFWcU05Q2R2aW93Z0paSzd0SWxv?=
 =?utf-8?B?MHBYK1lyWnMxZHNkYSt2WjVjWk5STG4vWmpTOVg0ZDVzMXRqdkJiVzh2ZlJT?=
 =?utf-8?B?cUY5TzBaWVdVU3FuT3RWUzhWdXhOSkN2K21QbllRUkpHaHo4SEJZaEJjSG1O?=
 =?utf-8?B?eFMwL2NLNnJCUjlTVzRQeU5CeGlubUMyalJ4NzJYMDNUckdKZGdIRnZJbXJE?=
 =?utf-8?B?a1ZFM1pwL09Gbkxobk8rMW9DWERsdUUvNzl2YVhwRGlZalVnbHFDSnFaZ3U1?=
 =?utf-8?B?dUpHcmRPLzA0bzJ6dlJ4OS9DMHhDeEUrUytXTzdpcENKTzluS1pNZTRscnAx?=
 =?utf-8?B?R3ZBZzVhMmFRWFZ2THB1eFFpRDgvaUUyME91QXFwMVZYSnEyVVdMZGx0RFNZ?=
 =?utf-8?Q?fF9F5HBZPCkTU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUI2VERzMW43THdSTzFXbWJSSnhhV1BrWW5ZdC93QlB2ZlVXZVF4b2NRUkt5?=
 =?utf-8?B?aDY1S2hmd24zRVo4U1VaQ0VBTlFaaW5VazZ1cTk2ekhVWHRneHlLbnJOd3Z5?=
 =?utf-8?B?NnV1STNtc2pyc1Y5RU5aVEZ1SzV1WVRvWTJ2NWVwcVJ1MFMyeVhFMFFBNklE?=
 =?utf-8?B?ZFgxUFZqQkdhRlFKaVR6NnVSeFRGcW9FTGIvcFRSYk9HYkJTdkRlTS8ya2Ns?=
 =?utf-8?B?a1VmakpuOVQyS3lVZ1MzMWk3eHNZSlRPN1hnUGJBR3A5WkloOGlHMGVJYjRP?=
 =?utf-8?B?eTZXdGxWMWpnd0c0WG43M1JsQU5EZG5IT2hXNzVXM0xCc0Mya3hkaGh2WkJT?=
 =?utf-8?B?U1N6ZXRtSFRvVjlTbDdPS1NyNldaWVV6UnhMS0ZuT1FTcU1GTmsxQ3VhVEx5?=
 =?utf-8?B?MXlFbHVCN01sQjU0UG9lQnEzcmtSM1FNUm1FUXpZVHY2VnVFdVZ2L3d0SS9M?=
 =?utf-8?B?U3Y2M3pvdThTdWdkeHFtSXgvbXhjR0hsQnFRYlkyckE3akxrNDJOaWg4b05C?=
 =?utf-8?B?MDE5cldsU2xwYURESUNrYnNQOTlsc2hCbE9UOVljUVFkZDB4NjAzbkRBTTMv?=
 =?utf-8?B?ZElXb1YyMUw0dFFDNXpOS0h4UW83L2tsL3pOWkhFbUNpR2gwY3pmeTk5TXVi?=
 =?utf-8?B?TlJjdmhZNFVyNWhYUGpwZXBSbkFwUGFzOG52VTc2a0pLdzVLMmUxU012Z0xJ?=
 =?utf-8?B?VTZXOGgrU2dWSUFlOWovQjdxQ2lSbm1RaEpMNkVlTUVGTlNSMmoyZFlwbVpI?=
 =?utf-8?B?N0hLeHFWWmFJTHNLNC9iZ1FMeWZkd3R6SmZRRkR4YlRSendrNkE5bmRmR2w4?=
 =?utf-8?B?RzZBWlhyeHFtSk1OMzRSR0o1R3J1OUVlTWFqa2Z4c1ZsU2tTV1laSmR6UlQ3?=
 =?utf-8?B?UjcvYW5OSTBNdmJIWmg4WkRiMjJHaVo2YTZEeTJtZ3hxOFhlNU03YnhSL3pq?=
 =?utf-8?B?b3g2ckI2eVhyVmZCZENkWWwwL1RwdmRRblFydUZMV2J3bFRMeHlKUnVQdjVh?=
 =?utf-8?B?TkxSczJCcXNpaVpwNlpzdVlLZ1grWWVyYWpQNUJ5RytESUxzUHM4eDV4VUIw?=
 =?utf-8?B?LzFlb3R1V3VHcEZ5Mkg3ajdtLy83anYrT25rbG5yZTVZTUZaQjFGek1mYTNH?=
 =?utf-8?B?NEdjV3dTRTdnUGs2amRsbE9zRUkrREEzRUNTOG1OR1VFRzdXSTk5Nk5QL3N4?=
 =?utf-8?B?UlB3L0xCL1JDTEJNc1BqRFcvTFlPNS8vZDFBaFcrNXNKbUhTTkY1ajhEcGhh?=
 =?utf-8?B?c1A0OExidXB1K1owcVB6bXBMelZqMHN5bHR5WDRZODlXSjlvbFV1NXh1UkZ4?=
 =?utf-8?B?MXhNODM1akExb3N2RVVpR3ZLTzZwZlRtQkpSL3RIUlRTS1ZOZWkrUWFNL1ll?=
 =?utf-8?B?akpNZWo4QlZCSkVTSEVaYTh2TWRyVWRtTzVaWXhmeDJSWGVDZkpIdjRqdHhR?=
 =?utf-8?B?SlhJQzVMcUxaR2tvR3J0UUtYRWthWkdZNTd5Q1h1MnA0MGxrd25GMWZJdTIw?=
 =?utf-8?B?ei9YVzc0MUZYSWdMY3plN1RuTnpQdlRBdWRDQld2VVI3MGFjcVh3UnlQY2Vk?=
 =?utf-8?B?Qk9qYnlkTlFleVB3NmMzNVp1NlNYM2FTWXVPTWVOSlVhTGtLeHhwbHc4d1hk?=
 =?utf-8?B?eHIrOFhVazh5U2JtajdwMG8vTDcwV3hGQ2lnNmtIaUJEY1U2ZXQ0RFJyRjJk?=
 =?utf-8?B?VEk5TytPbkw1VElrd1NVcFpDNGZUaFZsc1BCT2JJVGQ4ZTRVOFRFQ2ZjMUh4?=
 =?utf-8?B?alQwUkF2NHRibnQ1TlBmZHZ6Z2lXRG0xc1FtYk16THNtZXBOMWhSeCtEMnpQ?=
 =?utf-8?B?bFlMMHRwT3djNm9BRVZZeXUxSHBMTHFWREd0VWpZSnROeUsyNW9hTXdibXc4?=
 =?utf-8?B?WTB5NUdpWDhITVRkbWorWlNVVEJkYzFVdlM5TG8zbUhNSDAwL3lVTnQvYits?=
 =?utf-8?B?M2NjWDVVOXhhbnJ6YzMzNityeDZyT0NITG91ajJBaXBadlZWODdwTTRHQW5R?=
 =?utf-8?B?NFlCN1RBVVd6VnY3TGNEYzVKc2xZODFzZjFMZTRCdFdOSEQrNTlyU21iclhr?=
 =?utf-8?B?WWdzdFRsd1BmWGY3ZFJCb0U5SGRzWlM2QzRvaXU3c3lUcm5LUS9oSjJSckJC?=
 =?utf-8?Q?AqpRujIIRPjCH2KNzXHPwbnFn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f983197e-9038-4c4b-ce53-08dd3afdb06b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:59:01.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYBvK/sFBUJm9m8rP//7n9DRfMbiZDc28lZKPbYsmoCeqsunHI187XnXsWXk3+6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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



On 1/22/25 14:53, Venkatesh Yadav Abbarapu wrote:
> Add missing prototype to fix the sparse warning,
> warning: no previous prototype for 'cadence_qspi_flash_reset'
> [-Wmissing-prototypes].
> 
> Fixes: 6d234a79e9 ("cadence_qspi: Refactor the flash reset functionality")
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_qspi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 693474a2871..1f9125cd239 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -307,7 +307,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   			      const struct spi_mem_op *op);
>   int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
>   int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
> -int cadence_qspi_versal_flash_reset(struct udevice *dev);
> +int cadence_qspi_flash_reset(struct udevice *dev);
>   ofnode cadence_qspi_get_subnode(struct udevice *dev);
>   void cadence_qspi_apb_enable_linear_mode(bool enable);
>   

Applied.
M
