Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3DBD12678
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 10:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5D48900E;
	Tue,  5 Nov 2024 11:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xj1hOdEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FD089009; Tue,  5 Nov 2024 11:31:46 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9DBF8900E
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 11:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSi1mYlesSRmxmXw37BTXmxSTF4PKzwXVpDDu6redpjaBbcIxxJZa6mHIQB2FmbUaL3suznltx5jQ3UFtY6yhAxBsiF1sUliEEEMHb7Eey2PpwEvDi45wwTWmZSefVKYN/QftdMJfwAt7Q8ATBFxDqAU3ySpi5+VCnnYuZJ4JDiA0Ce5V2vxnN0Ye8ZWrlc1PxU6JuhF0ZAHxEe95/FpWd2C/t1Y1ES3u/IKNohXB8JjuGyVCbnB84utoFFtSgk5OEe6pDWwP3fLHgtvbFvRT6/bhG64F4DHTNxnzM7sMLI0L1gKeEYMxv/qY+esKmOuKP5eizBbe9lxGrB+MP6A7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72aAeks3TWHzmueQpAhaib9wsXrR7UoYq7KprxNPifQ=;
 b=j9P9LKrMF+3NtqQaBIMUBIhvb9yi7IfhSvQ4LMh1tNsfXhsdsGQ508yYQnhnm1HSsejkAdpuxkfQG+SFwD/16pm93fGFVU1SHs3sUzN/aJQwL+9p4ao5a9YyV7CSTPGdni1DmmBewJRLaE28EZkR/VLf+cLYobhPzO12FAq189LFH96bJh+s57FvsRkcifgX9hXMLL3zSXRYTZc9DAxivCWadGixWn3pojzVSqSVcPA09ZGcOZkxG32wMFZfcq0HCi38AKVVHaWI3KofUH0n6h3oup56LXKkoahqvNJzVjMLcP2xoMV5zHL/5htDnj751g/UNVCJwvM4TtTS3E7Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72aAeks3TWHzmueQpAhaib9wsXrR7UoYq7KprxNPifQ=;
 b=Xj1hOdEenh+8VA995wXwMP/9IqQiIDIkCxX5ogpWGkN2LkYmz7SWnfFYNsyo3vY7XXX+3wLO3sxu5Zi/So+kZQzt1sad8h5ETCRbJPLaE2W+KBS5VB29BfwmbwJ/cygv+DKetCQFT8+vOa59SF6kOUOGyktpnxvsmQFd4wS1D4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 10:31:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.035; Tue, 5 Nov 2024
 10:31:39 +0000
Message-ID: <3f01841a-ec0a-4cbe-9197-3d1f19ed2b5b@amd.com>
Date: Tue, 5 Nov 2024 11:31:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241105074917.546887-1-vassilisamir@gmail.com>
 <20241105074917.546887-2-vassilisamir@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241105074917.546887-2-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f6f727-b217-4fed-674a-08dcfd850876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU8vTllveGNTSnN6MUI2REloK0h2WjZQTEFaNVBOV05JQ3I2Tmx3Mk9sODQv?=
 =?utf-8?B?U0JOM3pQMTdsNVo5dmF3MnZNOGFVWHRPOGpSTHdiUjNuV0tBLzUxNkFBdEd5?=
 =?utf-8?B?Y0l0QnFpSG1kZXJwbTlJUnRac29rLzk3NG1sNjJNVUNnUDFoRHVHYlJ2K3lo?=
 =?utf-8?B?bWlNYit5RzJhRTdaWkZrMU9kVytWWExYdU5mWllPNHB4N2thVStxeEZjZ0wx?=
 =?utf-8?B?cktCY3A1aDVZV2tDZUxVTjVqbitTVm1oQVkxazVlUG9veFViODBWanNIQ2VQ?=
 =?utf-8?B?R1M3SEJycUFSRERjRDNSK2gvZ09kazRGUGZCZGV2UUM0OGNFdEYrTG9hNW05?=
 =?utf-8?B?T3FNajlLSlc2Y3hPZlJYdzNka2VPVWpDUzRRdm8wV3dNTElNYXd2c1pLazUy?=
 =?utf-8?B?TDE4T1pWa1hneER1bmhPSFlCWkJHUnY5dFlOOE80emZCRFFCdGgzTHJPYXNt?=
 =?utf-8?B?VjE2eVVscnhzK3VBM0RyOWZnRmpYR1lGUnNGYVIxYkI5aDNsRE42QWZOTHNs?=
 =?utf-8?B?cGU2R2VxRFFpMmVtaWs2QXNKMmxaQi9HMXVuczBYeklhdSthWFlRdStYNjNJ?=
 =?utf-8?B?VlNNc2VEYnFyYUhoRWw2aDZ4SHhxNE9PN3J2dG9PcTBwTjBycG92UWRNZlZX?=
 =?utf-8?B?MUdjNFI0aW9FUlZQVEVXMzE1R01KMXFoQkRLL0dFWHpXWGFveTRLR1hpOWgz?=
 =?utf-8?B?dG82aFFqOUVqUk1xejVCSnY2MmdCRzFhaG9hdjJ3b2hWQUdKZE5tMmJDclU5?=
 =?utf-8?B?MTNGalFVYTI4QkdUNVFTcC9NY210WWwrM1hhQ2U1MGRydkl0bndHd1ZkMUkr?=
 =?utf-8?B?enVaQzJ4TVNaVlFCc0NlbG5qWkFoZ2dqSW84bWljK2dtK1V0T1UwajJPZXN4?=
 =?utf-8?B?V3JrdVhoRGJtSC8xbU9QMkNPV3YvZ0F0T0FSRk55ZFdVSklQeHh2by9pSlI3?=
 =?utf-8?B?blA4SXU2K1ZBNHlNbDFzT2QzTTFwM1B1SEVjbjM3V0NTUG50QXpuQ3ZBUXVG?=
 =?utf-8?B?WXhCbjRyUllucmF2ZFVmTndwTFpaZFR3SStkRWM5cTA0aThvR3hXc2tmM21R?=
 =?utf-8?B?clF1WEljMXJnL3BkSHRTb0VBeHpSVjFWMklpVWZhZlgzVXRGeGlyNjRQMWhs?=
 =?utf-8?B?cFZaUkhwMVFobjBTUlZBRlAzTFpQTm51QWVEN2pLMDhYWDFnMXN4UGMvOFlu?=
 =?utf-8?B?M09RVjJiVmFESVJId0Nxb2todk9jN3VJc3UxNWMySFhTZXhabmwyanhXekN4?=
 =?utf-8?B?N2w2OTRXZGdxeFg4Mk0rNVFTMWRzRUx6ZjlFa3NVYjdUYmVtNVNZc1JYM0M0?=
 =?utf-8?B?SEptSTFGWWxWNVh3SWZLeXNUK09XaUFwYzdYMHlnUnJWa1BxYWJ1VVBrbGY4?=
 =?utf-8?B?bnVYdlNjOCtGTW9mYzBlc1RsU1NKZWRXYXpza1J5Z3FNOUNrQ0ZQcjRSWEtB?=
 =?utf-8?B?akJ5allwUS9wRHllMTYwbjgwYld2ekhZM3ViQlBvS3pIM25tMTZhVkZRMjR5?=
 =?utf-8?B?NGZtTSsvWFFtcTdBeWh2ZnVJT3lBODhGUzhvNEovc3N1ZDNBOGFrNmZ4TlFD?=
 =?utf-8?B?SHF4eVJGN0ovcVlvdDVvYzNqWUd3U2wyeG1FbjNBZTYvVkRhMHRUaDVCZHlW?=
 =?utf-8?B?ak9mNk1uSjdoamFkWHJUamxBbFE4cTNzalBFdTVreVRPM2NVbzQ4U2hzMGR1?=
 =?utf-8?Q?+teh0VOQ0c/T0V4pXagt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdiNnRtM1dBdDI0a0ZhWldWVmZ3Qk40QzI5VDJvMTdHU01ONk04SmMxZVZ2?=
 =?utf-8?B?dFpUdUo5d0pWZm84elJ1S0VDbVdpejlhT0hUTTNDcDUydmhieUc1QzJuQ0Yy?=
 =?utf-8?B?RnFSY1lod2dIdmRkVXVReHVwYUNnUmxqc0NKaVJpWmN6VWJ0OHc1WFptejI4?=
 =?utf-8?B?d0ZUQW9ZdG5ENU01c1kxWjM5RTh5Y1FoMmhKT01lR0RCNDZGK3E0SUtaL1Fy?=
 =?utf-8?B?aFZnWkQxWEd4VW04VTloT3NGN1BOTFhvZmg4QVRlSTE4d25FTXBGY0N4RVNy?=
 =?utf-8?B?UmcySTZ6WloyS3c5VkZNVUpVejdCS1Izd0I4MExQUzlMMGU2Q0lOdk1OMWJK?=
 =?utf-8?B?ZExPVWZkNmo4WUZHMWcyaW1JdUdISmVWKzAxLzJyZ0FsUCtjRFArZXU4Zld0?=
 =?utf-8?B?TWlVQU1LNkRTNHQyaWNzaHZhZGlZUjh3cGlsZkdmMjRFcDgwNFhITWZBR01P?=
 =?utf-8?B?NlZtQXpNU0FReTk1QmNkcW9TM1B3cTF0b0l5aVpkUEZyVnFnRUxVVnJCSVlH?=
 =?utf-8?B?WGJLZ2ozK0IrVjlyaUpzczh3VFNBejFhMWhLMi8xM0xta1V1dmRqR09UWE1F?=
 =?utf-8?B?T3hPRVNKRE5LazAwd25yek1uUUFFRERWQVRwN1k2NEVDbHFMV3B0RDMvRTNE?=
 =?utf-8?B?azA4L1FIamhXc1dIeXZpcVdEUituS043ZW9QL0pKUm9KS3lBb1ozaThaMDJk?=
 =?utf-8?B?SWhkSjZvajVlYXR5YkFhOForeGFvNU5RYjhXbVdNTHpTQm9sb3QvYzJmYllI?=
 =?utf-8?B?MEd6T1FGcUZhWUVMR0ZZZTJuTWFFY2RWU1M2L0Zyemx5M0l3NEQwZ2lpbVhj?=
 =?utf-8?B?aytXMFdYM0pPOXBpTit3V1FrUi9LdXQ3ektBbmErWTcvQWIxR2hwMTlkeHdz?=
 =?utf-8?B?ZmtsbVRmWjU0U3NrbitiMjdVcVZYcSttK3JkWE8xNmRZTnRicW9EYjQ3c0hk?=
 =?utf-8?B?SHlCQU1ubkNRQVkwQ2pvRDBvZFVZcTRrQ1FBcmtPOEoyeVpEU3NXOG1WZDk4?=
 =?utf-8?B?YkJqRzdZb3VuUkdXd0lBcEwyUWlEOGlmZEJKM2dXWnlMUE40ZElodFUrTmxo?=
 =?utf-8?B?UWVDUldnTDh0bDZubkY5eEMvWVJFcDBQaHRmckUzWmg5bm90eEVLeGwyRzJN?=
 =?utf-8?B?eC84bmJ5anNrYVltTTc0alNvTlZBYmUxdG5qZ1oraXNwZ2ovYWEzQm9EQ1dX?=
 =?utf-8?B?Y3J5ZUNKa0EvTDl1NjlRZlFPSWlXWHZvQXVIN0pnZWNLa3IwdHErK2NxRm44?=
 =?utf-8?B?aDNFM2Y1RTIyYU5sVXMwaU90bTIvN2dHOFhaa1d0RmdwRmd2NjFwVG1HRi9a?=
 =?utf-8?B?cnd0eE96UXlVS0hPSDNaSFU4a0t5VnpYTTJWcEIxSTNBdHZCNFhWTE1jbXNE?=
 =?utf-8?B?eTRrTU5zeFROYjZPWnFla2FqWm8wNmVUOXQ4ckFZY2M3OHV1QXFiZENXRHNz?=
 =?utf-8?B?L0FKSlhiK3Z4bVlUL2lRQkozRG92eU9YWm1LMkttTXllbkJUTm8wMnVGdmxv?=
 =?utf-8?B?UHQ3WmxpOW1BYVBJdmhIL1FsUXZRWGNja1p0Q3daTmRBS3MvZ0dJMnFsRC91?=
 =?utf-8?B?YSswcldrNDRRaHVieG1VK3FjWG1jb0hNLzZDeFZyRDhQbDJyTUdnVk1IaWZT?=
 =?utf-8?B?aXVPamhjb3hzK3lrOWlrcWgxcnlSZjJkWXNQSUdjNWhFenVOd2c2RUFXYndS?=
 =?utf-8?B?TVF6S0JKajZKb0lOWVVMTFBUeGpJRG5jYjdidWJVZE5LMWRQWkZuOXNIV1ky?=
 =?utf-8?B?aFNjSUk1S0ZwVDUzVkJPdHROSm9FTHNSRzlCNEZhVDUxbzRNMi9RWmRDVmE3?=
 =?utf-8?B?NndMSmZOTERQb2tCM0JMdmVNaUtjVU5CdHIvZEZxMmxUbHZ0TlVxem4zZTQy?=
 =?utf-8?B?WlpHWHhMWmlTbVllOURoR3Evck5nUmNYUEorVUVlVHJtc0RaSEpIYkEyRWRN?=
 =?utf-8?B?UEp0aFdUUGpuWTEvYk1GMGRWb0hYZ1ZWQ2hUMm1lN3g1dmxPNndZRDBxTHla?=
 =?utf-8?B?cUVhZldFSEtXempMd2VuRzJwZ25lbDByYkNXSEo2UzM0MjJuMThHelpxVHNJ?=
 =?utf-8?B?aUJCaVhGbnB1cE1jYjhGSGwvR2lwckdYelh1UHU3V3F5NE9RVGV6aTJnTEdk?=
 =?utf-8?Q?zwKICcjZXXntyH9v7LLdSZpe0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f6f727-b217-4fed-674a-08dcfd850876
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 10:31:39.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSUwyY4+a3p0ibISN21xYBcAw6V2gvPH6R+oVW3lOvMIGdai6+eAUh0+CsM1qapn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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



On 11/5/24 08:49, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Add native support of the bootcount mechanism in the ZynqMP by
> utilising internal PMU registers. The Persistent Global Storage
> Registers of the Platform Management Unit can keep their value
> during reboot cycles unless there is a POR reset, making them
> appropriate for the bootcount mechanism.
> 
> Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> ---
>   MAINTAINERS                                  |  1 +
>   arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
>   drivers/bootcount/Kconfig                    |  6 +++
>   drivers/bootcount/Makefile                   |  1 +
>   drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
>   5 files changed, 57 insertions(+)
>   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0399ed1dbf..bc27a514e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -860,6 +860,7 @@ M:	Michal Simek <michal.simek@amd.com>
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-microblaze.git
>   F:	arch/arm/mach-zynqmp/
> +F:	drivers/bootcount/bootcount_zynqmp.c
>   F:	drivers/clk/clk_zynqmp.c
>   F:	driver/firmware/firmware-zynqmp.c
>   F:	drivers/fpga/zynqpl.c
> diff --git a/arch/arm/mach-zynqmp/include/mach/hardware.h b/arch/arm/mach-zynqmp/include/mach/hardware.h
> index 49e449ebd6..3c372bd6dc 100644
> --- a/arch/arm/mach-zynqmp/include/mach/hardware.h
> +++ b/arch/arm/mach-zynqmp/include/mach/hardware.h
> @@ -188,6 +188,8 @@ struct pmu_regs {
>   	u32 gen_storage4; /* 0x40 */
>   	u32 reserved1[1];
>   	u32 gen_storage6; /* 0x48 */
> +	u32 reserved2[3];
> +	u32 pers_gen_storage2; /* 0x58 */
>   };
>   
>   #define pmu_base ((struct pmu_regs *)ZYNQMP_PMU_BASEADDR)
> diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
> index fa6d8e7128..f91074d5b4 100644
> --- a/drivers/bootcount/Kconfig
> +++ b/drivers/bootcount/Kconfig
> @@ -164,6 +164,12 @@ config DM_BOOTCOUNT_SYSCON
>   
>   	  Accessing the backend is done using the regmap interface.
>   
> +config DM_BOOTCOUNT_ZYNQMP
> +	bool "Support ZynqMP PMUFW as a backing store for bootcount"

depends on ARCH_ZYNQMP


> +	help
> +	  Enable support for the bootcount API by utilising the Persistent
> +	  Global General Storage Register 2 of the PMU.
> +
>   endmenu
>   
>   endif
> diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
> index 245f879633..0cf79e428d 100644
> --- a/drivers/bootcount/Makefile
> +++ b/drivers/bootcount/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_DM_BOOTCOUNT_I2C_EEPROM)	+= i2c-eeprom.o
>   obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
>   obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
>   obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
> +obj-$(CONFIG_DM_BOOTCOUNT_ZYNQMP)	+= bootcount_zynqmp.o
> diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
> new file mode 100644
> index 0000000000..060bbdbae9
> --- /dev/null
> +++ b/drivers/bootcount/bootcount_zynqmp.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-FileCopyrightText: 2024 CERN (home.cern)
> +
> +#include <asm/arch/hardware.h>
> +#include <bootcount.h>
> +#include <dm.h>
> +#include <dm/platdata.h>
> +#include <stdio.h>
> +#include <zynqmp_firmware.h>

Please read this.
https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

M
