Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A3CDE007
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 12:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DAA846F4;
	Thu, 25 Jun 2026 14:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qo2qkzp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC3B846F4; Thu, 25 Jun 2026 14:02:26 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAAF8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCPs3BFrqEKuSZBtV0aDuXFR12C0tDCOBQIEHJ8aobnO5S8TzLuIPxOCVjNFHsSLK7saR3J9upRmmS5PKqK3D1A9L0BtiMMBI7LiXDOA/R0oSsYTI6jOiv1MXislBT+8St5+GyvqmqaA0tXCtE3Prqegl2wXxkUmSdOuy4OLl5lJ8NCP48FG309g7Jdq8WH4nGmSFMHxkzgfhdqpH3WZmzhfKmiGrr2bpktvbtfjezelFTgUdFRZcwkJRTzxbIpkJHBa7CZoAIgnWMaL/M+VrjacmoX701VnuMia1OgBX+xa6eDZXyS15yfrJcynRBx7Fi7/byHarEo0D8vwCf25eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV51g+KC/vvaLeDBGxZP9/yTfCk7n4JeTVFy/BkKrbs=;
 b=WLUV5U5L0VT9nqrUiWdpwPKUfNcA+kV+izEF5KycMNMxhKupS678UUyR0MB9cQEv7R4xhngz4MnUt9Nvh4mgryueP+/0Y4mI+AB56COldyZZyv8v6OEMWMsd7uZT+lWtr3w6k29W7MnyxNtI7Bl7gAWMxZc1pksAhjXPvJXc+A+kHnYfxHPHI6N1WbiqMZscutt9vRAS4haK9a+EzC4vF2BVRH44RjiHHtdQUg9zDKHjqkVD3vg7CHGR/dTjnh3sbmixpogBcD+yODKZHLxgE+v28QM/cXNdEEXaf3/4BJ4ZDd9yrwmXfxhlToRLb/2h5I0ZG/5WZdF0WTmBK7O3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV51g+KC/vvaLeDBGxZP9/yTfCk7n4JeTVFy/BkKrbs=;
 b=qo2qkzp2+1amo+z1GEAUsJNnmT2XJLMffVGqf+7ra3V9/bZUd/0A7BXc/AT0MerbyuL8S9eDsl2oXmwLVWWGaAv0VB4GXc39D9EhrJbNEhvlzlZUO+QyDePqrdnohz8GWDdIoxmiyMk89JkWJCHrcxFou6WMWIj+fZUFkp2tH2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SAWPR12MB999142.namprd12.prod.outlook.com (2603:10b6:806:4e1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 12:02:14 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 12:02:13 +0000
Message-ID: <73b81cb5-ccaf-439b-a327-54b4e15acb12@amd.com>
Date: Thu, 25 Jun 2026 14:02:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: expand disk device names with drive details
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260420072935.3024696-1-padmarao.begari@amd.com>
 <3443228d-66d6-4908-a619-d57f590b8880@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <3443228d-66d6-4908-a619-d57f590b8880@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0039.namprd07.prod.outlook.com
 (2603:10b6:610:5b::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SAWPR12MB999142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce990b2-2b19-47ec-c9ea-08ded2b1982c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ihM/9GDIujNoTP32N5Z7gIQ7C28E1gDdd8fQh4xlVKn0nSfG3ZVFMXyeY6AJx1AaAgWTFxoH54FbPHaJcm6wPVzFMpqkj+NVJd7rB4b4n26KUHMRz4hhfSS5hcUcK5DoValIbG0ZMgqkegJDhsoewxdGRxtjZ5vwyqnwIf0bROfxY/IxUZXDGGG32juVjAUNwbvN3E+f6OfHJ9Hc4kGzgiVHCxCNnOjPSUh81oQs1RpVO8Zr3W22xJLCNGYm47r3PcSFpaR5yS7tEl9MVDZN/U89tECxGHbCCv2/n8axK7tLhlak3v1n93dvpLx3gdzFv3bsqWU8xzGfYMrSXQUdy5bAygimJK+JG4sZmTHavZMv/F1ADuRuSK6XEWOUHJ1loL/6VYi0go/Rpix8Efu9qKfgT6K38X0wPppqY53+kbNGiZ45jgMBURZVaPy3CLVIJIrb5ZwGPsDHAWVbrI0dNHDZvHD4hXwGOypkCVy7dPnU87aYZmRhf4DcaVyVnheHqQlEAdb6qgCw24DuwJgSBjQ/wuGIfFm73AQ4+LYejqS3lVCfuthhRRiXa+QMBbM7ZXBE8wpuGg7n15iumLC1lbchAr5duAZ5gUDJdw/0A0+DDQYyg8xTlVKtkoK7xbM5cTknLaVc8c6u5IkgiJ5TtYt9jF5tcQVYDwbVFrCLpEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hQM05oRDAvZXZDWmxYcjBkcUlwOXoxQ3F6L25STjlSZFNzWDZxSU1abll3?=
 =?utf-8?B?T2ljeEdZOU80UURFbi9BdVlRaXZoK0tBMjRYRTk1ckpDSlVuTFhYV2Rld0VO?=
 =?utf-8?B?aWJUTUdjU05QVlBiUlYyTGduRUFKS05jQ0N6KzliWFRtR3dKN09Ib2UrS0hv?=
 =?utf-8?B?QWxLMG9DOHVyWm5nYlQ1MjU1WnBzbTdiVFlpNi8rOHE4TC9SZWJLVTRSaFEv?=
 =?utf-8?B?WXMrL1cyWUtMTVlIcE16dEVGUkRhY3dubDZ5TWxCREIySjhwSDI5OEhlb1dS?=
 =?utf-8?B?U0RmRW9zaGlFYU83QTlXSGZnZklycjRleFN3N1NNeXdVcElNdUlOWXNwNWRy?=
 =?utf-8?B?d2JkQTh6WkU0bVpReGc2OFVFNTNFMEtIb1ZGV08yMDg5NDdXeGJnc2R1czl5?=
 =?utf-8?B?eWhPOTFZSXBVVnhDcEU5WG9YbjQwM29ZRDgvNzMrQU15eTZLc1NDTTUzVzZI?=
 =?utf-8?B?dHo2MFdNNFcwVHlUY2xJMjUvaS9KcmVkaHJjT24rUVh3T1BDamExSVFydjZF?=
 =?utf-8?B?UStEVUI1RUgzMTVsWDlIM1RtQWRtajE0Yk9sRUpUdys5VUlTUXd2MkxNQUpV?=
 =?utf-8?B?aUpnZm9XMjRGVjhmYlhVb0xlS1paZkVrNTZjQmxRV1h4aU9Zc0R5akIrMlhq?=
 =?utf-8?B?Q0gvQUxaWDVpb3B0cmN6eVVUU0pPQ0dwSThwTThyQmhLSUhHZXJYMlQwd3M0?=
 =?utf-8?B?ZUplZUVvbTNqNk5DWjk0a1R1UndLNU5uS2s4K3cweklkeGJrSnY2RDBTalVS?=
 =?utf-8?B?VXQ2eld6cWRpWWhzWHBNS1JoTVlTbzA3YVhMWm1OTDZqeUw4UkJIcUVXdW1r?=
 =?utf-8?B?N1BIcGVpNGY0bzZ1aEtoLzJKclJDbS9qVG03V2tmWnc2MDZ4a0VQemY4U3kz?=
 =?utf-8?B?RnhveG5uUzNIWUtXeU0vZGh6dWg5eVgwTzJOZko5OTRQakg1V3dpTjVJYm55?=
 =?utf-8?B?UGNDQ0c5Z01yQjhqQ1A2RDZVRnNlWlZ2dnJKZzN2MjhKWEpIMEJsTTlad0pB?=
 =?utf-8?B?OU55cWhlNm1BSFd6SXlCTzZhVTl0YTVqR3lZQUY4NEkxQk5xbVYxcXh1Ykd0?=
 =?utf-8?B?SGRwK0JGMTNzNVRwdC9nT3FlZzByVGxxTjVBWmxTTXNabFJvN2FRUFo4T3Za?=
 =?utf-8?B?RFE2NElqYlRyMjdlMDRoUVRna2JEdXJKVXgxSEVKYWdKd0JRbGk1blhTdEtk?=
 =?utf-8?B?ZEhvMnJaQStVR3JKeWxZTEdaLzRvdVdvYUYvaXB3WDZSNkM1aGJQM1U4cmIz?=
 =?utf-8?B?N0lCaHZPSjdhOUhRSFg4TUZQVTY1UzBpYlRRWUxCd2NIQ2dnU0h0Z09GU2tM?=
 =?utf-8?B?bUJaVXNkdE8wMzFEaWdPa0F0ZTlxZk5HRXNoZy9qcnVNQzNFN3krZVcwcnlS?=
 =?utf-8?B?ZDltZTJrY0pJa1NRbUM2ZTl6M1IyWVZpYkNCUy9IWnhicUFjeVVoRlRGRFBE?=
 =?utf-8?B?cU8xS3p3WE9xZUx0K01Da2NNWGU3d09zYTdvVEV0RHkrR21EeWdMUFE5SEVL?=
 =?utf-8?B?ZDZ4TzVxaHhpbGtrRGhhdnZIMVJnWDNZOWZqZnlUYUdVNERnZ1NFMVNVRjVW?=
 =?utf-8?B?MXk2Z1gxZHBkS0poMlFVdm9CajljSFhvSUNqclNDZmNOaEVoMHBCKzdORU5Y?=
 =?utf-8?B?RWpOc1d5bE53bVBibTR1cUNJdEliZUZ4R2s0WUEvRVBOUTcwQXloQnQzQ1g4?=
 =?utf-8?B?YlQ5cXpvYzV6ejM4VTBkTnVucll0bjZtcFJEZlJhUGNnRzBkTUFlK1pvVm9T?=
 =?utf-8?B?U2tXemY4eDkveGYvTkFqd2xvT3BkUmJTNjMwRS9iUytDdnBQWCtIUEtaSHVE?=
 =?utf-8?B?RjN3T2g1Y211a2x5eFV4T1ZvY0NjbTJjQkZUVVhYbzFTVnlTeHY4cUo3RkVJ?=
 =?utf-8?B?Y09KZzdKeWtwVjVNUFZkNUwycHdVK2ZWb2FlN0NmaU5ReHl5ZWt3clFlazJH?=
 =?utf-8?B?ZUZxVE9nbnY0d0lXRFBLelY5WjAwWlA1bmhMRG05SWlOZXdMejM4Vm9kemEr?=
 =?utf-8?B?d0I4MDdLYWhISXEybUF2NVY1UTNOR2FNOW94ckllL256VDgyRmxXOGlRRjdU?=
 =?utf-8?B?T01WL285ZzdlNWprTnlCQnQ1Yzc2UU0vdFFEWWJMQTQ3NGQxNWlldzc2dTNK?=
 =?utf-8?B?YVNJNXVOckdsMTE0Tk04V3ZxZzJ2UUZFS0RySjlsQzRWZU9HZ1E3cXpxUFRZ?=
 =?utf-8?B?WE5NNGhOSTJ0dW5ISm1BUUwwZVZmYXk0Y2lJa1ZMcEJqMmdHQ2pkZkwrY0xL?=
 =?utf-8?B?Rmp4UDlacWlXQ0hGbXBSRHRycG1aNWtxT3FQS1ZNSFhUdXFyaytOOU5WVWp5?=
 =?utf-8?B?U3o3R05RaHE3RHZzaFh4dzBCaURJS3BBLzZLOTY1elpuTlNhOTJJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce990b2-2b19-47ec-c9ea-08ded2b1982c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:02:13.8373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xgOqw9ZMwhs2l5/GO1SbzdijL6MBa6DSN4C4bDoHe7tYuycB8tY3ITGPToaj5gJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999142
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



On 5/1/26 10:23, Heinrich Schuchardt wrote:
> On 4/20/26 09:28, Padmarao Begari wrote:
>> Increase the boot menu device name buffer so we can append extra
>> metadata. Append the disk capacity and trimmed vendor/product strings
>> to the device name so users can differentiate drives in the EFI boot
>> menu. Also tighten the parameter validation and pull in linux/string.h
>> for strl* helpers.
>>
>> For example, the U-Boot boot menu now shows entries such as:
>>
>>      usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
>>      usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
>>      scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)
> 
> Adding a descriptive text looks like a good idea to me. I am just not sure if 
> with the patch we are showing the relevant information.
> 
> nvme 0 (953 GiB, SKHynix_HFS001TEM4X169N)
> nvme 1 (953 GiB, SKHynix_HFS001TEM4X169N)
> nvme 2 (953 GiB, SKHynix_HFS001TEM4X169N)
> 
> I would not know if these are 3 namespaces on the same drive or different drives.

yes that's limitation of this patch but more information could be added on the 
top to differentiate the same devices.

Thanks,
Michal
