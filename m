Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F90DC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD8A807B1;
	Wed,  5 Mar 2025 12:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nKBEW5O4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A8AD808B6; Wed,  5 Mar 2025 12:42:59 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BDA08003E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqvUkM4epTguTdtM9yMVSnCKLVEA/lypWhnvsKMwmjM6GDK/OvBd3idDvOxjxGfsuWTus/VpI7NxihcnijDiCziyMIyC24TzZRmIXxZhvcSMnki6cGFoJVbE21tCApnas58WES1WN/kNccTPMDnQ0Vrz0BXvpOBKr5v4hR8Q9GimTqf7iDttcsDT1ne2PWY61YcWlQoqJVJGEJucDP55i4AuAIT1cPo2dQ4P/FpsKQUpRyNtX1/MCcOJVWXYEfc236kP3fKI96oAaP2NHW+0ZM/joQkGBESBUioWG5Jg+8HI71ubSOufPDKAHZwN6ZLNZSVIoiyP9GkZ/qWoyXVa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZkAA14+NeUyOfft/RDQhMayY7wO19FhVXRViOMTET4=;
 b=TbWYUv7iCXU6HAaK3vh7ydfYSAE0LXaWqi0P3m/3IezUEOANYNYks6q5vYmNfB5kCgQyN9hLW0DSMZnj2YppFKMgJ7cTdbxZ99EX0i7vrC1pxpyI8Yep1rE5LjI3JIdaN8l2ExQsnXMUG+9RQ1OF2sir7llevLIe6lLW2eC1So5QHGxb3J3XcV4aDaZ6K9nx3R83svt1jijVRXVfeNEqXXzDI6lHNVwB9Ob7vVVL9fzcHD/FdaauwJWhFzOSArwSCNrRHSCVZE97d7C7Sxhk9qqRj8znrAcKBezp48DXhg9ircl8OsFMPXbN5JEGxo24VPIdMPZyjHs9G6L4T5IOCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZkAA14+NeUyOfft/RDQhMayY7wO19FhVXRViOMTET4=;
 b=nKBEW5O4pNiyhaIhVnqcIFrHFtoEJX4o+78uw4tq2RlDwtqIPJtisYSnjs072kocbSLU2QqqaZi1k1JF7Na3GzC4WeXvWTuXfCi8R/l/FXpm9sSzxfrZgVjvJ79KghcBuYXLd0/PDCUkShbEvP38ZA6V9EZrxEX13pvV5rGYpRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 11:42:51 +0000
Received: from PH7PR12MB8108.namprd12.prod.outlook.com
 ([fe80::1387:5f9b:616:dabc]) by PH7PR12MB8108.namprd12.prod.outlook.com
 ([fe80::1387:5f9b:616:dabc%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 11:42:51 +0000
Message-ID: <cbaed2ab-5340-4a03-8783-eaf231776110@amd.com>
Date: Wed, 5 Mar 2025 12:42:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: Remove tftp block size 4096
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250304043030.2344536-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250304043030.2344536-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To PH7PR12MB8108.namprd12.prod.outlook.com
 (2603:10b6:510:2bc::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB8108:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d533335-3ee0-4da5-a4ad-08dd5bdadc12
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YSsyeGpNYVZKbUJ1ZWhBODhncW9zeDBTb3RrZVk1M1J4ekpGczgxeTJ1cWFz?=
 =?utf-8?B?Z1pweTBVV0kzSmpSaFpJeFNMV3Q0V3ZTS1VjSjl0L2VDdnVLMTdWSjFWTVkw?=
 =?utf-8?B?L2VIaDI4ZThBQXloQzlFMWh0ZWxzM2VUWnlTYXp3Z1N1OGJ4Nkd1L3QxMG5i?=
 =?utf-8?B?Y1hBaU5pdm05M0VTUEtFZ0JpWmI5ZTQrTkVMQ1RQbERscjRlNmc0QXQrTkxF?=
 =?utf-8?B?bHp2T24vcGlkaWttaDVvYVlqU3lWbTU4UWlTRVZ4U09XekFSZEZEMTlMMTZW?=
 =?utf-8?B?ZFBDVVN5V3RPRndZZnQ0bVJwZGl5OEZjZVZIak5rc1lRUlFnRk1teVQ1eG16?=
 =?utf-8?B?cUtZNmNFb3Q2dmdIN1VjWmtDVkdSQlAyM2UvM05uS0ZHN0N0TEdFajBuYWRQ?=
 =?utf-8?B?R0kzNFJ0VEI5WXRXd2FjWEd0Q3Nwa1ZKYXhBSHJ1eEErbXJZSmNiRXZQdERj?=
 =?utf-8?B?SnZVTUtjZWQ0M0dVNzFqcDZnTjNOSkp0R1B4NVR0ZDUwaFF6Nk5oUjB4b1pD?=
 =?utf-8?B?SDlwUzZVT2dEWUJES3gyUFBzWWQ4NURMWXJwM1JmQzJCWHRYMkpoaXRwTi95?=
 =?utf-8?B?SnpFNUllOUc1cjAzeCs3ZVM5MGZVM2lWQTVZV1JUUUVGQXVhMVR0a2ZjNDc0?=
 =?utf-8?B?ejNrQUZuSy9pRzZyeGNwQ2hFWHhFME1jb2k5ZjJIM3VKWXQyd0dtK2xnalo2?=
 =?utf-8?B?NHlHeUg0dmcwdkpzeTc5YTFmeEJ2UHo2SjRLVE9xNnJrcWlNMnR0TkpDWEIv?=
 =?utf-8?B?N0JEU2JvZ20wWXc2bnBCRUdxZjhyYW5Cb1J4TUJWcFgrZGZIcDFoKzNwcjFq?=
 =?utf-8?B?TnE2dHovcXJFd2NlYVNZZmxUVzc5Ym50SGNRQmNlQWxYaG95OXVsK0VNdkI2?=
 =?utf-8?B?ek83WFFWRHd5N1VQWTlIMS9ORFF4Tk1SUDFraFkyenhMVnFHeWVpUkowNFVy?=
 =?utf-8?B?MWdxT05ZUlJxMFJ4T0V3ZUJYU1RsSGo0bVkwMWdZQzAyMWdiWU1wUHRia21p?=
 =?utf-8?B?WHMvS3djUytWU1I5d1QyaFU0YUo4eXNQZFQvRWhQQU5hZUtPQndleXoyMGNw?=
 =?utf-8?B?MGR0aWM0a3lYOGx1K1Q0SEFGR0o5RW9lMThqakZuVmRENlZ1bEZ2Zi9OVmZ2?=
 =?utf-8?B?SkdzbEhlMkJDUmRIbDc3bFpKenh2bm44NDI5MDVOa3piYnZSbFh2dVdHc0Q1?=
 =?utf-8?B?RklyV1o2S250dk51Sm1GeEt5anVMVVM3UFRMSjJDZWtwR3djbytTVWJidHJW?=
 =?utf-8?B?YXh0QU5JdkV0ZVlGb3lwOExjZk5mdXMvMkRoV29zUFVoLzlzUWE0YUtRVkkz?=
 =?utf-8?B?elU2ekw4RFdMZHlMYWNOOThWU1ZCWmtQdHBIV0laWXR2SkZHUTIxYnRMcmxt?=
 =?utf-8?B?RnFHVlRhTmpRN1JOZHNkcDgwWWs1VEtRTHl0aVFCZWhXUWV3SEt2ckdpNklx?=
 =?utf-8?B?blZWbFNaeWdYN2pmTWVFOTg3b29nbjRuYlJ4d2dhVG5KNENvcnRiZkxqbHUy?=
 =?utf-8?B?T21OczVCVzRGZU1lRjk4RnQvNmxCTXI0ckJBOExIV0MxcEF1NTBTck1NTXQw?=
 =?utf-8?B?T3RpOFYxTTk3bTN2SGN6OS9XWVBNcnkzanNQdVRhWXFsUXNYVUJhWUF4cThB?=
 =?utf-8?B?WXpwaElFS282TWg0MEZiL0VrRmExaVR5WlUrempsWDdZV3JUb21YWFlJUFIr?=
 =?utf-8?B?RmQ4QnA1aW1jYTFNb0ZVMzIwWjNJK0dGR1JsTmFtWUQyejloSVB2bTNSOVFU?=
 =?utf-8?B?UjVXRnJWazVPWmI4UDNHbGhrcmFCb3lVaWZwc28xTjFOd2JGUUhGVkhxdEto?=
 =?utf-8?B?Q2p5ZWNLMGRwL0htMXlnZjZVeFJwZjFPVGVkTVJ1MTFUaFlOQ2dVL2NpdFJn?=
 =?utf-8?Q?iHO472H+YdEal?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8108.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhqQ1dMaFJNcGRGQ1RIYTNrMDZrMHJUcCthUlZ2dnVSbktqZUttQWVHUEFx?=
 =?utf-8?B?NTR2SGRHdk5ZK1FkVlNYUWpYV3lNRjFYMGNMaTBpUVJBYnQ2aG1hWGpqMFJZ?=
 =?utf-8?B?cGYwSlMyTUhPdmxDU2JTV1VnTkVlRXlGMVV5QWU0UkN0S2d4S0twUXBlYVBo?=
 =?utf-8?B?Z1ROM1ZrQlNtZnZuUnlYQm14cVZCQTBNWkcrYWZxQUlDRzdtUVc3K3B4ZDA5?=
 =?utf-8?B?TGl3WmpiT05ZWGVYb3ZwSjZacVROQmN6Rm5hYldDNnRBS01NOEpQdEdtdE9j?=
 =?utf-8?B?dTBucXNQN3F6czFYRmlEaW9HR2pTa01pb3pzZFdYMDJ2OTFTeENHQk9oT1Qy?=
 =?utf-8?B?a1RwWkxIOUZkSmNrbjJBVVl0SURidTNobkRJUXFBeU9xZDVqbDAxb2ZmV3Mv?=
 =?utf-8?B?NGNVbjA1Z0lCbllqM3NUbGlmSTFZTEJTRUcxVVpqSUNGUWZ6bSttTUw0V29J?=
 =?utf-8?B?QVJ1OUNITHlWN2NNaExUcUJ6VFBNOFZQcTRiNENvYUtHTkVHYmw1SkRKNnkw?=
 =?utf-8?B?cTg2N09XSmxBMDBUNmF1TlJWaWh0OExDV3BHSFNKbTAyc2o3WDRheGZ4V3NS?=
 =?utf-8?B?d0pCTTNQeXhlZGdxNFlucHN5bEQ5NWI1Q0lSUW5Nc0FUNE0rWEgwclVMOHBn?=
 =?utf-8?B?d1NEakU4dmRvcklEdXhQa1pBenVsaS95M2s3QUUrZ2F6RkU4WUI1Z2tXRzRM?=
 =?utf-8?B?bFRUNmQrVWZLQTNQUHpiZkQxaC93ejNtK0dkR2JscHY4OGxlNTJYOG11WFhY?=
 =?utf-8?B?QjhrMElDU3o0SDRvNnJEOXFqekwxSXhmNUNsM3RtTmUzN0RpRXllWWRQZFNG?=
 =?utf-8?B?eTJxVm9wVkhLbENMRHpUeW54bmx0U3hOVk9pblhJMUZxczIvdUFwS1RIU2Q5?=
 =?utf-8?B?S20ram8wN24yaE1ZTmhrMWJ2QjVzVEkvWXhQSkhkSXdvaEJJOVBBY3BlNjRk?=
 =?utf-8?B?K2VQTnZSYmttcXBiV2JvRk5LWjliWU1rMnNhdkZtZUVwZzNYdnc1UjFTNElF?=
 =?utf-8?B?eDVuazVZSUNUbGt1dHFESGg2NEJrTVE1c0NHL2tCUmZyUXZWUmIwaWVJQTJF?=
 =?utf-8?B?MHYwL2ZMTWtOek9WMGo0SkM4TG5OVlA2cU1uYTlGUGc1NVh6ajhRNHpZcHN4?=
 =?utf-8?B?MTZYZC9lVHBqUUpjTW5lSHNHU0dTZzI0Q2xGazVJcExHSmlVOXMrd2tDVzNn?=
 =?utf-8?B?ZHQvWXptTVU1d0dNOXp4WlB0UHlJTkw5ZGZ4NGh6bjlHd1V6dUxBRlRtbGY5?=
 =?utf-8?B?WXRWRXgwclNsQzVjV1NlTlhXMjM4bEhCSThUeVB1YnZoSHRBZ3Vyb0MxQXJ2?=
 =?utf-8?B?eks1VjNUdUFLWmcwRE1hU3NmM2tYalpXdGRNWlhMMm13b1FpRmRQV09ERDJU?=
 =?utf-8?B?VlJnUmRPbXlQSGZRdUFyVngxUjlNTVBiYisxOXRsMXN3Q1RrdnBkUkw4OUFK?=
 =?utf-8?B?bTJHcWM4bnhhTDBOZzk4OVdzbG5SdlkrUE9CaDNmckV6UDgrM2JjSGxPamFS?=
 =?utf-8?B?cUorNC9FbTRqSmw2dmZVSWRTNmRzSmphYllrSGtQY3oxcGN2NzhiMHduVVkr?=
 =?utf-8?B?eVRlWjh3NnpHeW9kR0p5blRZdEhuMFNGSTdBRnYxd1hjT21rZnVjOXZXK003?=
 =?utf-8?B?U2ZoYTV3N290MTJzMzA4VG0raWFXQkhiMjVOMUFTM0c0NmhIN2VSYms4RlFE?=
 =?utf-8?B?TzRONlZHM0FkL3c1Y0ZDcVpCaVE0U3AxV0hjYXgyeFUzUEhkQ1lZMi9ycmRn?=
 =?utf-8?B?ZitkelYwaXA0NnNjZm55NG53czFORVRlZFBWVkVOY0dvVG9MTUNRYlN0SEZ2?=
 =?utf-8?B?SGJ1cVFkdXBhcmJoaW1GbGx3MERSMGY4YzhzWHhJR3VvV3FxcnpROEF5dG5X?=
 =?utf-8?B?amNGVFhzZmFlQitOVm45VGxzUVJRTnpuMVF0WkZ5V3RiZlFqK292S01zTWQ4?=
 =?utf-8?B?QjQxcE9FS2xmbHVmbW1KbTNzZ00raGxyWUNhZ21seDZPaldjbG5sY0gxQmV3?=
 =?utf-8?B?bHFZcXV1S09yNkRZd0dlZWh1OGNIa1NiczhpaXhSVXpZVUc0Z2c2VVE3aDVi?=
 =?utf-8?B?dHpUandMaDlmY2FpbXpGZ04zRzNLeDFzYnB5bS8yNVpYNXRUbzNyOWE0cUdO?=
 =?utf-8?Q?H8cuK09pqqw2GIf2ofxjphbnu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d533335-3ee0-4da5-a4ad-08dd5bdadc12
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 11:42:51.3000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/0TMK+4jNQD2MzrMIViVTOx5XTUAUbJVy1fwpptACxPn7YSbzWeqYhnK35O5u0n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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



On 3/4/25 05:30, Padmarao Begari wrote:
> The zynqmp gem driver support max MTU size 1536, so remove tftp
> block size 4096 from defconfig and use default tftp block size.
> 
> Fixes: a33b4b96b3cf ("xilinx: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v2:
> - Add fixes in commit message
> - Remove tftp block size for versal2
> ---
>   configs/amd_versal2_virt_defconfig       | 1 -
>   configs/xilinx_versal_net_virt_defconfig | 1 -
>   configs/xilinx_versal_virt_defconfig     | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 8bee002777..9911caa0e4 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_CCF=y
>   CONFIG_CLK_SCMI=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 5ef5fd44fd..1604b5915d 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index f228eef7c9..baa4b8e412 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -74,7 +74,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NET_LWIP=y
>   CONFIG_NET_RANDOM_ETHADDR=y
> -CONFIG_TFTP_BLOCKSIZE=4096
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_TIMEOUT=y

Applied.
M
