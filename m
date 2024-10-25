Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7AED0C614
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB15488FED;
	Fri, 25 Oct 2024 16:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xag9S1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C67B87CF8; Fri, 25 Oct 2024 16:20:25 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B33288FFB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ajabyd8YN1NTBvun805hCVd+X6F7rukA/bv3Shw2T1dLe81ZhH7VYjp7RPPHxrmL/pcptB38xnAlG8qy12zHbG9h2mtMGfifC9Mo+fPAWRLzRkF8uyZrWU4bt7EORiei+MxrlQgM7f5JjpZh4oGGv3AlHDp9cN/GsYRl70GGX7I0a2z2oOUHsWxUMqx+Qih76nlPf3MSp0VsGNeGPTdAkL3RRkfvHZ5bzfti4y2GolDxnVyzvQXWQnnM8aJxSGwmfMbi6k0sV9sq4y3Pv/ksUAglodjXHzbD1je0JhmeMVHRRkhOnqXcMzS2c/5wxXh+omWbz7r7pP72LHVcJlmjGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiAq+x7S1muQuZyjqDRTvwa8WnmpsP5xa9vWNyP9cZA=;
 b=txU8Pw+z1UKMx6WEZ0OOc7wfyPBVOBi5OFhD7wTKDJlvkOuX2u4RvjXNvBooJ2K+ZbP4QbRqaciTJWSM+5+9d8AI1xW9Q/aOXlWdqYXLLw8sPrLCb7JK5D4zSpo5yC2FJCDmZob5qFxQU4x4YNklc8rmRIFzcg+ituiRn0dSZJDNzVb46ijO7CuCeF8tLVzlWbJcmfoIIyiEvlIu8uRMenyBQrLtOBGW5ZEwJtybZFs7RLwb6VujEWmAvyLgI+LCYQXEeWm2D5KS05biRg3HcLAp1bi4SHmqzaB4Yj5gA+xnmboEDAR+ilsdm8m+qWPTiqnfpXBM1sFayMnyr9f8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiAq+x7S1muQuZyjqDRTvwa8WnmpsP5xa9vWNyP9cZA=;
 b=1xag9S1Je+tvxOdLk8rreoqv05/OYrswwljcsh9QPH7FFPdkxs3qLfJn3709791+D+0D/jPKjAaV6e7ulEFJdF+5J2QCSr7tWmcZE3nMl2SDo6BsFfTjL+m9I7oBKGi/pctDZYS+TLmReTudf4n2O6w8XFywSgQ7HX/xtnI8wZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 14:20:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:20:12 +0000
Message-ID: <8932a3a2-7b66-4159-a583-8bfa76107c74@amd.com>
Date: Fri, 25 Oct 2024 16:20:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: zynq_qspi: Add missing prototype for update_stripe
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, trini@konsulko.com, vigneshr@ti.com,
 git@amd.com
References: <20241016044402.18052-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241016044402.18052-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 2366ffac-706c-4f68-76fe-08dcf5002328
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnRQRHgxUzFPM01pR01DQTZWQ294SHZqNGcxdHg4NXNSN1RDMlFuUmJpQ1VD?=
 =?utf-8?B?cnh6WmlqNEVyWEJGVk1ya1JNY1hTNVpJZHlBQkdmYXlTQTNtdXlHSmVtbjdF?=
 =?utf-8?B?ZEtEMC8wTm1ZcmRYTkMrNXBHZWJPTllFekRqb1luYjR6d0ZwY0N0dlA4TnBH?=
 =?utf-8?B?SStjQmpXMFVycHFhUk1keEFYeUplbDFmalo1RVZoNldUYXA5S3Z0cm85RDQx?=
 =?utf-8?B?MG1XMWczUnJxaU5NbVpaaTV2Ymg3Mm1jT2o4RmxDdlRHYXpXL0JnWVBISVNY?=
 =?utf-8?B?RUFDS01BVHo3T2loNVozN3ViMmFzMVQyZ3JaOU8xUHgydHF6UGFaYWQvWHNT?=
 =?utf-8?B?Zi8wa3J3dW0wK3ZvMFVJZTljaU0vQjdCa2JIR2l2dnRWazhGWmQ1aFFndjFp?=
 =?utf-8?B?ZEpwd3VxTWtrYmpuNHppQUh3M0kvcmlKSXJpS1NyR0hBYzZzK250RzN3ZXZh?=
 =?utf-8?B?cXdXSXZOb2lDcXhWVVlFcVVrekgyMStNWGtvdzNyVmVyMUlVaDNvN3l0Y1E1?=
 =?utf-8?B?SGdWbVByNXpSL3NtcDNYV2l2K01ua2tsU1BFS2JLK3VwV0pMQ0pqQk52OW1a?=
 =?utf-8?B?N2JkZ2d0b0pRTjNPb3pYVEFnMWRHdnIyWldkSmRoVm96VmxpTHM1aUJpNktE?=
 =?utf-8?B?d3B3by9VWmJvd21Kb1FjRjdMWDFUS1I2ZlhhY3ZsSTM2eXUrKzkzVlY3WHhS?=
 =?utf-8?B?QmNPR0pyemNZdHVaSUVzbVhqazFyb0ZUNm4rZ0FKb0NQN1h3M3BmNldHZUVh?=
 =?utf-8?B?ZjVBMU1pdmdzbE5oa3QvSEhxU3h0ZnBVMzF5NnA2b2dzOFRzTFBNMDhaSUs5?=
 =?utf-8?B?cG05ZDF1WVVaSDZ4ZHhyREJLM0k5dUQ2cGgvcGdoN2lkVGI4NDBoVlMreWIy?=
 =?utf-8?B?d2tzVDdMbEE2by9NdHI3NVc3azZyN3lxcEtaREFITnNkR1h2MUUwOGRsK2p6?=
 =?utf-8?B?djhkZlFkNlkxaW52SFZwZXpndHczZ0dxb0c5a3RiaU5seU9qSWFzU1lZZnZO?=
 =?utf-8?B?MEJwWGVDR3N5RGEzR25Wb3RRMmREb1pDeW01dDFZZjJvNjB2OTRuS0d6Mi9X?=
 =?utf-8?B?N3Y0L1l1R0FhT0FrZ0t0YkRCcm9ES3E5NzJtL2xlQnIxU05yWW5HVHp3QWVu?=
 =?utf-8?B?VDNwWUtwV1FwQnZmRGNqc2FxdWtDL21MaHhOd0dqTXh6eDJYdlhzOWtEV1o3?=
 =?utf-8?B?czR6RXU2K1dvMzhhVjhybmszQnA4N29hTzhyaXVYVUdkQUNEUmE5UlBGT3Yy?=
 =?utf-8?B?U0xIOE1Odm9QaXN3OURJNnJyWjQ1UEhEcWx2dlB6cXgydGxUVnkxTmJBZS9l?=
 =?utf-8?B?QnBUT1FiUEd1RzZWR2c4MWhHbEdWUDEvL0VzSmJ4S1VTWS90cTNMaUFoakQx?=
 =?utf-8?B?TnQ5YjNkeGV5M2VJTEZIZ0xvK25lMmdJcmErWEU3NHZqZExnRnhBQWFNMVFj?=
 =?utf-8?B?SmIxamtwVXdlL09FcTFaUXoxRVRldFZjWEU1WGhmblJ1dVNVMk1PUFRzZlhm?=
 =?utf-8?B?UE9kRWpWSE80Y1M4NGpqUnppNDRmY0NQR1EzVW1OalZHVkd0MUQzWUpZWnJV?=
 =?utf-8?B?dTZYNU9ieGJPTlBmT3A4eFNWK0xSbFJ5SDA2UVRHU3BpdmxaU1pERllKMGY5?=
 =?utf-8?B?eFVtVEVqZ0NPQkh2TnVoUm1rZjdNeURVM29idENyVmFaODJqaTg4d1dtUWxr?=
 =?utf-8?B?K0pKS2VIZlppZDFZYndyQ01yQ1dlR3N2NngzdVRkNDFQK0xsTE1HQzFaNzhv?=
 =?utf-8?Q?IxqaI8FFhSi9b8DZ6Mw0e69SKlUTyQNXQYfJ/Tc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtYUHdpaHpyeG9TTE5qaHoybzRSSTZ3Rlo3alF4V2wyd1hWMlVRNkhrVSsv?=
 =?utf-8?B?UUpCdExhVS82d3lWWnVMQnZMeUVGWXVhT081UCt1NmVhVThjdHRmR3VnQ3RO?=
 =?utf-8?B?UTdhby92ZW0xTHhVTy9Xbnp5TjNTdm9ReWNIWEZtbjU0S1IzcjVwbEtuWWNW?=
 =?utf-8?B?Zit5Sm1UZEUyZ25XZ3MxSXNJSWhzQzJDaFhkYnZYV0c4ZkdmUERxTXZmUURh?=
 =?utf-8?B?aERZUFd4aDZjREd6ZDBGTmZLa3k0RDBnUzFHaGJ3YUJjRVN5Sm1BY1VoWmVD?=
 =?utf-8?B?Nm9LS0tFbnFXUm15UWpLbCtBNDYxeEo2czhLTnlTS2ZvclZGYXc4K3pXblVJ?=
 =?utf-8?B?OE9ha1duWnNWZjliWkhvY29EYTNDaiszbGZadDJOTkRLRi9yVkx4M3RxSDNV?=
 =?utf-8?B?OXUyb29rcVVMTjJvTjY5Z1M5L2hBZDNqT0VreHhGeHdjMHd5M3ZuV1orVTJU?=
 =?utf-8?B?TVRJNTNrMHlOY1diRld6SEVXY3JMcUpESnUramhjbFFpeUhqRUtaUk94UzR2?=
 =?utf-8?B?ekZUbi9kd2RjZ2lyZEZEbGFVMnh3MUxoYmxGQzVzQXBlZkNzZmpNTEVWNitE?=
 =?utf-8?B?RkhpdmtVZytLVFk2OFhRSytWUmpqK2xjQ3BzNDVhc1ZMSENqU210K0hNSUpI?=
 =?utf-8?B?YmVQTXpxOGZQa1VyR2NlWXl5RnVEZGw0NlppMzVkTzhIZnlGZHhYSEQwaWhE?=
 =?utf-8?B?NVQyb0p2SlduK0ptT0xwakFwTXdrMmxoQWFyUytCSzZ5VzBTVnRkL3pNNFJM?=
 =?utf-8?B?em5vQ0lEZFNnK0s5aENYYWY5ck5FdWhuRHh2aXVoOTBEVkRrSFluKzBnV3Z1?=
 =?utf-8?B?M29PNC90UlN4V3puTkpuTE5UeGpnRVhnMStHdXhUWWY3UmJ3Tnp6eGswblZq?=
 =?utf-8?B?OFcxY1p2M2w0Rm5DY0dPM3Y1UmtTMEFsT3JsMGZ0V2g0Rkl1QzAvQWNRLzJO?=
 =?utf-8?B?dzdVWlFXNHVEbnVmNlA3OXUweTZWNjcwRW9SQVlicGxEWWlNNkgxWHR1bEEy?=
 =?utf-8?B?alVLUC9tYUZRdDZsVXlDUDNsWldQTEpiUUE5SGpaMG50bVpFeWdTUWE0V1Yy?=
 =?utf-8?B?VzhMMXkwTS9VZEhscDM0enBRVzVZVThPc083YkJ3b0xyUlpMdVdsZm9qYnJZ?=
 =?utf-8?B?QUZ4M1JGTFZuSWt2WnZOYTVRVkJrRi9QWEVvNnowbTNORmY3dW43aHV1Umpn?=
 =?utf-8?B?YnpsYUlhUjcxUDZ1QllCNlpUQWk0ZXlXZHNoYm5EYVRpQlU0WTBMUGF4U25n?=
 =?utf-8?B?NGl5SXJ4cUhXVlV6MCt0TkJPdmYzYUNsZWhralB4Mk9sMWEvVWFpRmUvdzBv?=
 =?utf-8?B?MDM1eVUyZWhVNlgwcEd3WisrSkE0MHVHc2w0RjJHeExSL2w5T2JTUnB6MVYy?=
 =?utf-8?B?UCtrQmo1OUVLZmRra3d6eTZNSGQ2dUFCTmV6ckZYWXhXeDdBeE55eGdtUW8r?=
 =?utf-8?B?ZGRyN3hySlZjaGM3ZWE1M084YWJRYlJuZnRDYngvQ3BFcE5kZTByL1gyMDVh?=
 =?utf-8?B?VWRhY3A5U3hja3lNNWxHQm1RN2RCMGRkRGluTnhOV1VJWFdydTluTElHQVdT?=
 =?utf-8?B?My9OM1RIV0RmbHh3V3EzemM4QXVtV1hYWmh6RWIwM2NWQ1VOY1l4TWErUHZR?=
 =?utf-8?B?Z0RWRDRPRVVqa3k1d2ljNzF0VHhubDNoZ3A5dkF1d1lLcUNUTWphVWtjZkEx?=
 =?utf-8?B?b2NLWHVQQXhoUFl6M1JxdFd1cUgvMWtkWmxaclBQWXpmeElNTkg0RXpIU2hj?=
 =?utf-8?B?VDdpQko2TldWVWNWM2M2SXpEeEp4WkVzOUNVYlJZQjY1VzdVQXNVNmxKditO?=
 =?utf-8?B?ZjZIWHdMVVU2cG5mdTk3YTZOVk9tVnZBUUxlMU5CM3hvN1F3SUZDQnRWV1JM?=
 =?utf-8?B?MkpTNXg2WDNGeksvTkZjZTZkOGhNT1dqVHlLMGlTVVh4R2ZaRG94Q0lTaFVh?=
 =?utf-8?B?YjRMb2lNU3pzSDI0MElsZkFseExicUVPeXc4aWhHMGFuN0FwQzVkQlB1dmVP?=
 =?utf-8?B?OWxkVGpMMExWWlRjRXdJb05BcGJXZC93NjV2eEMvUkZSeTI5enBqZUh3V0lG?=
 =?utf-8?B?bWIvSU0yYjQxWUZjVVhpQ0hzSTAxbFNmRlpubjNHT3ZYaTV3Y1YrMUJtRm44?=
 =?utf-8?Q?amicLXGwPvrFAKxmEmAz43Tri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2366ffac-706c-4f68-76fe-08dcf5002328
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:20:12.1008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg0HZU0SY/Hurbtj7XvAjpmye88VMwI/yN8BTNlIhtVsDDl2omK9AYY0urW44wvj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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



On 10/16/24 06:44, Venkatesh Yadav Abbarapu wrote:
> Add missing prototype to fix the sparse warning,
> warning: no previous prototype for 'update_stripe'
> [-Wmissing-prototypes].
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/zynq_qspi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
> index f5b3fb5c125..4aad3248d9e 100644
> --- a/drivers/spi/zynq_qspi.c
> +++ b/drivers/spi/zynq_qspi.c
> @@ -734,7 +734,7 @@ static int zynq_qspi_set_mode(struct udevice *bus, uint mode)
>   	return 0;
>   }
>   
> -bool update_stripe(const struct spi_mem_op *op)
> +static bool update_stripe(const struct spi_mem_op *op)
>   {
>   	if (op->cmd.opcode == SPINOR_OP_BE_4K ||
>   	    op->cmd.opcode == SPINOR_OP_CHIP_ERASE ||

Applied.
M
