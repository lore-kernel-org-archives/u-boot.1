Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7312E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F6680328;
	Thu, 19 Dec 2024 16:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VjMEniV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE738021A; Thu, 19 Dec 2024 16:07:55 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE5F8034E
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxIkupVpTm4JqmR08lidZMrju9JVpEU9Ln9t9blrT0x+Ia5jxZ+RvQEDS8egC8gGjLQI8BJhv7qO5IVznuuHJi0vFcSnppVPWJ8YM08j4q+XmF4TyC34p4xdPXLvJ/04QDJAynMbRE0tYvLxlnayoiFea0oo+xi15j9eMWST4ldPL/hgLHLZ9q/TXim6bSiP6f0+gcJxYfFbxX8rb5y+kGCSpKVnrgPMnrg+785upAYvczQ13WfQK8qr/RCPLyiGEQQKIYUZGEqzCc3xxNcjV9JoxxO8FfOyCg+CTgYL4KB2VrBA5eSfzyZEHdUZEodSXDfeT/U5yw/gjU3nd9o1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80MvQjyhbYJzuHUtd4uUSFzx9XU/WbQQR4IH0SoBSRw=;
 b=vGDjcSVJ2dpr5FTJFi6wFVcoMUAGzQ3ThPF2eNfvYXg4a9BwT2YBudoFBY4HxWn6Da0BZarA/gJcuQHFh4PknJX3TyjWV9mfGmdaEVeW72VccKlNfappE9rTzOc5GSGbmVoVkU80RN7nxHecHKlEc3AKnENxewFYppI+CQT2TQCoT0URqDDBNcKBd48oGrYxTesGblCd86SHZWBRGEboGevu74hTZyhsePKQTmTnypXNIHjKtK7peHAHxHlKcPTwHwKtJ9Y6ONhm3y2osrF8fO5CXSmc1yEZL5MzJiA02WUfGyB0u68fOGgWoC32eFMK++7u1+kIKPWE4SwPm6fdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80MvQjyhbYJzuHUtd4uUSFzx9XU/WbQQR4IH0SoBSRw=;
 b=VjMEniV3iDOEW/NkAFqWUF55JEacHADad0znDLUqAM0ejJqAzZlpcsH6juMg7TwZstt4AfVc7xVHzSxw+wGiRiSrR3THdSq79fHxqepM6TfEMWHpHdoR5RDDttn7WQOy5jFZ6zBD6hW2Y933bh0ohvXC1wyL5nd8gyFkG6i8oDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Thu, 19 Dec
 2024 15:07:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 15:07:48 +0000
Message-ID: <9d8c3fef-02c2-40ee-bf70-c0ca76ead74d@amd.com>
Date: Thu, 19 Dec 2024 16:07:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: memtop: Fix the return type for find_ram_top
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: sughosh.ganu@linaro.org, git@amd.com
References: <20241219145051.1735676-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241219145051.1735676-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: bb89c48d-cbad-4b21-b666-08dd203ee691
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2xJQlVEQ3ZWcjU4MDd3RFlLY0wrcDdOTHdVWWxrZ2FOK0pjY2QrcXF0dFpm?=
 =?utf-8?B?K2lIOFh2TFVvbHRXQUVhdmNkd2V5cWJlR1lsSjd6RkRVMThHOHZRUVZZTHZa?=
 =?utf-8?B?NXpZQVhJeXFnM250RUZEbmw4S1d1L2FoWHhQRkNNSGFjQWU3bEFncitPUEIv?=
 =?utf-8?B?N0lyeFV6MUNTaTRNcXNpN0VUSlg4RG9tMzM4TEsyOG50T3RpTkNkVFg5V2V2?=
 =?utf-8?B?SjI0M3g5UFNYMlYzZ2tVZXZMUUFEazg3MzM2d3BCWHJpdHlNemN3b1RZQVda?=
 =?utf-8?B?WGl6U3Y1NkNoc29DN25yS3NlTGZSR0xHc3V6QjFQa3hHSDIzdWIzTFVsLzZp?=
 =?utf-8?B?Wk5VM2hmc3dDUDNLdHFhUGNIVzgyMmdTN01LcWZBOEE2dW9BaWt3bHQ2dWU3?=
 =?utf-8?B?U0o2WHVxZmkrTnFUbC9Ialh4ZGYxdWYxK29OM0ZDS1BNek9OS0pGbjlSRW5B?=
 =?utf-8?B?SWZkZ1BIaG1hS2NCVWRZZ3JkbGpUcEhUYjhmdHl5WVFYbVRPZjY5YXphN1BG?=
 =?utf-8?B?Zlg0SEtsdEFWVjVINVJDeWsxOG8yakVYa0lkSDBMd0pvWjVUcEJpQmVlTzZD?=
 =?utf-8?B?M1BzNGtwRjVGdE12SDJrL0lIR3hxN1Q0MXEyaE0xQ05oQlpNNHQzY2V6aGxv?=
 =?utf-8?B?RkY1Mks4ejFQNFBNT2E0L3lSQmtubFhpY0pWWjk0OFNWb0dXSXZqQk9sNzJj?=
 =?utf-8?B?M2ZUc1BUUW1OTzVUaVMyaG5ydlArdE9QL1U1dUZhMXlIWnVIZ1V6cXJ4UG5J?=
 =?utf-8?B?dGtBbk1ZRUQxLzhUWm1OcENhakJ3eWRaQmVqVVBXTlhjL1ZObFBabWNCSUJu?=
 =?utf-8?B?ZUtyYWxJQVZxU3E4bkNhd295VUFmOENKVWtNTVZSbEtiLzlNWkZ4cnU3VmFk?=
 =?utf-8?B?TWpJMWVCQUJXK2tPS2FTYS96dVFXU2p3SnlGSzhOQkpYNTJBRGtJcWMvNmkr?=
 =?utf-8?B?Nk5hWHVBWnR6dDNVdkQ2eExuc09nem5JSEdaUElIeE9tQjBEN1VjZkFLeFBv?=
 =?utf-8?B?Qk5hVkY1TDc2aHh5bXdyb2dGVGJ5WFRiSXNxZlBWdXNNY3RmV29KTFUwMWJt?=
 =?utf-8?B?MW9iZTBaYVVJeUZsSXFPVktNb0xBa2NQcU9IQ0JQa2NoMEN1bFBHVzJURXQ0?=
 =?utf-8?B?VEJhMnlaN0ZLd21tK1gyM0NBWCt1RUQ5NjhrRDNrL1ZJRHZ1cmd2OVg3VGM3?=
 =?utf-8?B?V1dXV1hDeDh3YU1qWUpFWk1GN3c2cytHYWNaY0lEdktGakhueC9EM3VvWEZn?=
 =?utf-8?B?QjBmR1JMeVA5VW9TbU5zaDZDcHpQYWkrQkNnSWRFN3ZrWnNEWXBMK050amdt?=
 =?utf-8?B?cVpmdWF6UTV4TUtzNUNQS0FMTktLd2VVWlNuRUFNRENVb3dTVEk0cUZ5cUNw?=
 =?utf-8?B?KzdyMmlBdEkyVzBFdGprTVZWSzRzem5FTjFrV05pZzk4QkRzSURUeVVDVUFw?=
 =?utf-8?B?YkQ2ZlJBVFpQZk96YmJ1UTNjeXEvWEttY3JGSS9VSTBrVitmZmZFeVYrQmhm?=
 =?utf-8?B?c2VLTVc2YnZPZ3AxTzNpUU10OEdiaUhIWDhseFlkd004N3hNVHVPcmdkWlRz?=
 =?utf-8?B?SzVxVE5vWTVQbWxwcUlaMWgrQVdrSHhCZzFDeG1ORldkcWplU0szY0NTYzd3?=
 =?utf-8?B?aFZoeGMrZ3pJUmR0UXJ5Zjltam5qQVkyWTR4enRnYytzbGVLWVhLcDNaT09k?=
 =?utf-8?B?aGR0SzVEcUpHaDBrOWlBWmxHQmZQNS9tU00vWGprSFdCd2pDd3JuNmVWTitr?=
 =?utf-8?B?SVYrQ1pVQkorbnJSVktSQUltWGN4b3BrS0dCcEV1VXVBbU8xRjVRd0lJekZT?=
 =?utf-8?B?bTFlVThMbFdBTG5uZ3RPV21WNWlaYmIvNXdXdUNXM2xvK0hWdmF1bHlhWE5o?=
 =?utf-8?Q?PDzNcwfuhp6e5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUdFeFdsTmhzYlkzS3FwbmpvY3VnNVMzSGRVTDhWRGw5NUVaanNraEY5QkVo?=
 =?utf-8?B?U1l0OUFJeE5QUWcrakp6bitGQnNRZU9QWjNlUXdJWlNRYWZZYzIzN0pHUnd4?=
 =?utf-8?B?MXJPSk1mL1RQaGk4cVB0NVJkZDRhb3hkcHhhK1ZyWkEvZjFyS0gyWDNzSyto?=
 =?utf-8?B?MWVxNG9jZmRVVnEvMm5yRUhTckpPOEhWeklEWlJPdXVvaUhuUHMwSUpBb25s?=
 =?utf-8?B?SXQ5ZUUxMFMvd1l6Uy84ckVtZ1FqYllqbGI5Uk1YRUwxeXBVVTFIR1UvMkc4?=
 =?utf-8?B?WThHUmFIU01LbEIwZzJlendsTUVuS0NrSXRhcS95SkpmY2hWa3FYSURPajJZ?=
 =?utf-8?B?OXc4MWdXYXY0TlBzdUtYcU1PS09TRWlyUkFaV2tlbldlNWZRZERjZ2toMVZR?=
 =?utf-8?B?bWZpWE5lSGo1WncyY3JyZ1RCaG04U1dBbWU1Vkc1dklac1JTWmZ0N0x1bC9i?=
 =?utf-8?B?U1lTZ0x6d3c0ZkFNOStJWWRYOSs0UVZjTW90RVZSUkdydHoxNGR6MU9MeTR4?=
 =?utf-8?B?UHJLRzFJSHpUMC84YXF3Rk9LaTZKY0FZQTR2NEFHdjZuaUIwS2c4aFY2NWsv?=
 =?utf-8?B?eUpabm9Yd1ViZ2Z2YWJ0bEVxVVVhYi9hNGhhQk9IYThodGpoZUhBK1c4Ky84?=
 =?utf-8?B?Y1JNTmNNL0NEdVZXU0s3eGxzMzZ6RDkvVm5vQjNRaVBaKzhuRXBYV21jTDBP?=
 =?utf-8?B?aXZ0RXNkNjBrYmFNZzJwNlZnVVRYb09Yd09yaGh4SWVWV0FOekVqbFBjdFBH?=
 =?utf-8?B?OHZCZkpHUzdETGl5bFVXUmErTnZvWTdDSThPQThPdHJzcU03dTE1eEl5VEtK?=
 =?utf-8?B?UFdzYTFWUDBaZUJnQXczQXhJZjgzR2hjcHhBMU1rUnBrS3F6Z2ZDbTVMZlB2?=
 =?utf-8?B?SXViZURybVdWajR0SDJkTThxd3RSQ3B6d1Q5VjRKcmFtK0Q0NEorM3lYd252?=
 =?utf-8?B?amoxSE1nZTQydG5ycGREaG45K3Uya0JTOU8wU2dBQUlOR2RiK1Bta0NOOW1G?=
 =?utf-8?B?REp3L05SUkJOMVp3U1FpVVJ6UFlzN1orcXV1UXIvdTQ0QjB1bFBHb0sxVGFh?=
 =?utf-8?B?YXdZeEpEM3Q1bm5MdjQxTUQwRmJvMEhPOS91dHorZkUzQjhxN0JlblZiYWJw?=
 =?utf-8?B?cWZQQlRDY2FMQzhkTFlRT2dMV3UzSmJMS0RQQU5qcCtlUTF2bks3VVBVM0Vk?=
 =?utf-8?B?VWM2TEcwbUR0NUpVNk00eis5M2I1NDhrYWx0LzFLWGVNU0U5bHJ4MFhSaWpW?=
 =?utf-8?B?cEtmY3RZMVpCMThCSHlHYTA1K3FqVVl1aUNXSnZYMzlEVWFRSks2TkxYK2NK?=
 =?utf-8?B?Q1RaeVB5VXZVMjQzMVFWZ2hEcGdrRjU4VDVFcFVMdElZeVcyMzh3anV2elJ6?=
 =?utf-8?B?Ykp5VytmdlphOTVwYjA4d25MN2M3c1dnNEdmRXIzbUFBRGxWNU5UNE5oeGhs?=
 =?utf-8?B?L0oxb1NaSFVIWWZQVmduU0xWQ2ZSUGwwdUVvRjdSQjJBdmRFWmszd002bStn?=
 =?utf-8?B?SlBMaTdBbmMvLzFkcjI1TXhrcFRhUzEyclhtaDRzWkw2VklLR1pLcm5RcVdj?=
 =?utf-8?B?SEpzSGhTb3VaYVZZTzlxbC9aWGRERUJjUU1acG9NSE5QVmVtR0VBUnJTNjdo?=
 =?utf-8?B?VkkzQTFUVkVxbE5BVi9YVmxXY01PUlE4K1kvMGRCMUZ1eEt3LzJ4UllrSkM1?=
 =?utf-8?B?YmdDNzVFRlRtbExucUVodk9Hc0hwZlN3MlR1YTdJME9MZFFMOVJTQUtWNllU?=
 =?utf-8?B?ZW1hdHdvQUIzV25FSU1wOHZCbEs1RERvU0E5dXkvUUFLL24xMzNKMFo5eVFk?=
 =?utf-8?B?TlNNb2Njb0owUmFyeDVVWnUweEt2V2VIdER1SUoxbDFnZ3hDR2lMTTNXNTJW?=
 =?utf-8?B?TFVQZGNMUndHTHNLU0VLSkR1YkJBR1dabWg1aVVrUTh1N0Mwc2ZKd1JPS0Z5?=
 =?utf-8?B?cW5zem5JSk5mdnMrblpVRm9obHhMOU03U3BUNWlmM1ZNQWtSY2dxL1RJbWYr?=
 =?utf-8?B?cU1hdERLMWFGeU1GM3dUVTNicm1wc3NKUUx1b2FyVWNFUlJpWC9ZQWFuWi9i?=
 =?utf-8?B?dDdOVDJZV01ucFczRjU0SXhZcnFJSGE2dUlYbUxxQ0Z5Y0lCemdRY3ExOUdW?=
 =?utf-8?Q?SXZxOKftddGNudqDMK62PsVfu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb89c48d-cbad-4b21-b666-08dd203ee691
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 15:07:48.7143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ccNJYfCGksJd9u8n+2gD9EJFVDqREhPcW7bhZZX5aDNaZ4rB7SSDyJIJ0ORDX2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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



On 12/19/24 15:50, Venkatesh Yadav Abbarapu wrote:
> As the return type is "int" for find_ram_top() function and
> returning the "base" which is of phys_addr_t is breaking when the
> "base" address is 64-bit. So fix this by updating the return type as
> phys_addr_t.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   common/memtop.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/memtop.c b/common/memtop.c
> index 841d89e0799..114ba64067d 100644
> --- a/common/memtop.c
> +++ b/common/memtop.c
> @@ -121,7 +121,7 @@ static long region_overlap_check(struct mem_region *mem_rgn, phys_addr_t base,
>   	return (i < mem_rgn->count) ? i : -1;
>   }
>   
> -static int find_ram_top(struct mem_region *free_mem,
> +static phys_addr_t find_ram_top(struct mem_region *free_mem,
>   			struct mem_region *reserved_mem, phys_size_t size)

You should actually align this line too to match (.

With that fixed feel free to add

Reviewed-by: Michal Simek <michal.simek@amd.com>

and I like to get this to 2025.01 version.

Thanks,
Michal
