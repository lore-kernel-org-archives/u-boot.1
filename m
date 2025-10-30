Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A3CCCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 18:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58221836D1;
	Thu, 30 Oct 2025 19:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xgc8Vjwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB14836F0; Thu, 30 Oct 2025 19:19:56 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C573383677
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 19:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TECJqheBTfOQrT/bkUUIO9J9FiXEv2FERoAwmwttGztUAORWziYQgdb1P0eOF3WRbkP+MTNYz0fHlroGtFfPL3SAvf1lJxOn3d2gQ5qMiwXM8y9czLJ00VqsQjDOp+7iD+PbZ3WpCzYy5anf77SIT7UwRJoeL0wHn4oUoor5BDt6OUR0Y3sGGI0v0vLebeP6AWgsZCxKRpUBQhnnqwWz20RXPC9YkUExvB+R2Hbz0sxPEeKAbSGaqa46Xe/ieyt1S48xbmn1Lr1fmgl8xR4+NsVbhHz5QWiP5i1Q8RCNBLJEGaAedOC+k8I/IojaN/46PXoxvXz8yR67jaS7cptuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDE5A2HV9mNirN8EhiQm+98YzEQa+PVUWsBGDp9rE/c=;
 b=MLWuD4L2hGMg+3S5buPLSh2THAHCQy/jn4h9fliPuGNMefe+9vYG3TDNLL3kI74NJDtn+3100o4ZED3JD0Q3QnQuRdfHosEIbPIf7bQfHGI/vEP6re8IM2De5shQPCSj6uxEq+N55VKpQpmevev8iQSu9qxsvJvfu8uhfkthuhZscDXVnt1a1KXUc9voH5ms7lqHhZMgGSNwrQJiS6WA2OIZZgGexrvTrnm16lcOXsm0C/Zz0Kqjkd9VmXTqLf+t2dhO9TwphzkK086kGPz4wtdfXGsqFZe1HPhdCWzhCLIbqIuI7r28S3qb2WRX9degaCXJFIIkAJs8afI4fEUWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDE5A2HV9mNirN8EhiQm+98YzEQa+PVUWsBGDp9rE/c=;
 b=xgc8VjwnlrOpxnTJZvfmqjyIC920x+kZsKXwm5mgffcIRXmcO/MAnpzCMwHYSiJFA2rDqW0K3eh06880k6tKYPwOYQjlP5v7GTN2BaatIwKES0cIhYWKJxl0m5Jl322JsUshn2NuHM4tV6c9Sp0sjLa5vh5LiY72REV4awR3Ozg=
Received: from BN9PR03CA0689.namprd03.prod.outlook.com (2603:10b6:408:10e::34)
 by MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Thu, 30 Oct
 2025 18:19:47 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10e:cafe::2e) by BN9PR03CA0689.outlook.office365.com
 (2603:10b6:408:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 18:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 18:19:45 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 13:19:27 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 13:19:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 13:19:27 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UIJRBp2617852;
 Thu, 30 Oct 2025 13:19:27 -0500
Message-ID: <abc45fa3-bdaf-4ce1-b92d-9f6a4bbd5f77@ti.com>
Date: Thu, 30 Oct 2025 13:19:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/8] mach-k3: common: enable falcon mode from R5 SPL
To: Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-4-anshuld@ti.com>
 <e6791dc8-45b5-458e-afdf-f96778b529af@ti.com>
 <DDVRFKCHCSJB.3HC7YUPKQQVDJ@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <DDVRFKCHCSJB.3HC7YUPKQQVDJ@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MW6PR10MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5645ae8c-28bc-4a05-edc4-08de17e0e7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3BHeEE0VWM5TUl4UTN0R2hIcm8yOHdJcXQvL2FkMEpHNXBMcFFWbWNrZnc4?=
 =?utf-8?B?RFhUOGpVdFdPakE1OFNvNFdwVlEzTTBXZzNIVnhwSmFadlZCRU4xV1ZRZ2lx?=
 =?utf-8?B?TWFORGduNXhsS1BTUlI0V3BzMmZNcmFzYVpPQk9MdnhQNWwyUUN0YkhLK1ZW?=
 =?utf-8?B?RzRHWSt0NmxlMFFSem5xM2w5WDdkQWpHNm5ycXBoZ2c0YXE0WmY0YWppY1ll?=
 =?utf-8?B?UzJSdC9JRnI5dENJbnh1N2dFdmgxT3llYzMvaTJjL011bkZYZGlKUjFMTFhP?=
 =?utf-8?B?UkxNV3Y4ZkFhUUVEbVRGUFBzeEtpRG81dWRMNUdVNTV5NzBNLzZRWWR2VEZO?=
 =?utf-8?B?bGNnd2wyZUZyZUpzcU1zaXR1dmxjU1ZMb1FnQzlvdzlNZHh3eEtKMmhkdnNK?=
 =?utf-8?B?WEdROUJQLzFJM2U1dmExNUZTelhjNm1ldU9ja0YvdFdXaVovMHgwL05QNm03?=
 =?utf-8?B?RVZoTk5RYy92UkNLSXNOR2ZDT1lzcEtKVk5YNEVPMmw4cWhJWkVFWDc0UUQ0?=
 =?utf-8?B?UmtYdVRaaitnMlpYZ2pRTzNNYS9CKzRkVkdNcWNTdVIxU2pNUWNZYTFiOWVH?=
 =?utf-8?B?alZUZkF4cTM2THBoeXQrQzRMRXZPZVo4L0s4WGVHM081aHFWZ0tmRmt2a2ls?=
 =?utf-8?B?ZFZ3c2dKbTF3QlBqa1F2MFVkZ3R1bGFxY1FVc2cyamlkRklpNFVnMDhKZ29q?=
 =?utf-8?B?ZU5uYnRuK2NVUzZCbTZhTWpWTVJxd1RIZjNKMWsveS9rSkxaOXMxeWp6b1Vz?=
 =?utf-8?B?b2JzL2RkbGZiNnZtM1FaemlnVFF3UUVuKzEydFg3NHh3N2xsR1k4QXZvNnJR?=
 =?utf-8?B?RW5saUtjd2dFSWdMcmkzdEM4bTNtTCtyRlpOUHhLT2pLQWt2UERabzluU1Jm?=
 =?utf-8?B?VWhTaklYdEdIMnpVcUF3KzM4anlTYTg5UUxVbW5BaTd0dGI4Vk5BUVIwTEY2?=
 =?utf-8?B?Y2RZSkY2SXFKT09pdFl5U2xrNUp6UTlUWlc2b0plUmZtY2hMRkloRmEwUlcx?=
 =?utf-8?B?K1ZTYUkzeG5PdCtjM1cwQ2hPK216QU5JclZLVGFEd2pXQUtMVTA4SVRORFBl?=
 =?utf-8?B?cG85N3FRRXNTM0xyWDhMbEJIZDg0eDBaM3hLcHZrQ0Iwb3cvU0E0cnFCSS9W?=
 =?utf-8?B?SXdIVlZ0Ym9JUEtyWTN5UHBRWjZKWjhFYzNRNFZqKzRJRXNGc2hkV0pzV0xt?=
 =?utf-8?B?dGpycC85YlJZemplYk5NMkQza1VDVitRWTZQSjlMQU9OcFNBL1NNTCtrYjRO?=
 =?utf-8?B?bEFNL08vdXU5SEtFN0ZJWTJ0ZEV1UlBZWGU5bnBmT2FuK3pobi9SOWVqdFdY?=
 =?utf-8?B?Z2VoMDdYWDQxNk5ucEVmam5NUjFvY3Y5VEl1TTR6Tk5XbVZnekhFdDM2dXNk?=
 =?utf-8?B?NUQycHBOWnNnWEtPc2w5Qk1IUWZnTjhWNys2VzcwLzdlRng1T2RVbEsxMDR1?=
 =?utf-8?B?UFVmRjkyU1RFbkF0bEZxY2N3UG1RNkNTQU12dExZcEVRaTNUbU5vR1gvSWZk?=
 =?utf-8?B?VmpucHQ0NXpOUnNTZWFrVFJEOUt4bklDaE1ZTmpvNnJLMGJOTDNSMVNVVWU0?=
 =?utf-8?B?VXd2QWZyc25iY0J1UzVqVEhOeFp3WEhPZmd3L3N5Zmh3K09ERzF6M29aOXQz?=
 =?utf-8?B?ZTVOZTlFYUF1UGVmUXRudEI1TlpOQnJFYU4zcTZxZWduaWNYNHRQWHlnWDd5?=
 =?utf-8?B?L2lhYnRvRVpEMHFsVmFqSTROY1pSZkhxQmZIK1ZaNGc1dmFZVUpYMGZ1WXBQ?=
 =?utf-8?B?ZGlPaFI2enl1K1RCQzhtNDVTVjNkSXdHZjJxT1NkaVFZUWdjdGhMT3NaZ2s3?=
 =?utf-8?B?TCs4Z0dpM3hBbWtONmdRZjUxblI5QWZjQi9jdlJjSXU5VHlZdStPb1R3K05M?=
 =?utf-8?B?NFJkYjBjcVcyV0NWcGs4L08yYVNOaVgxQ1h4WmNpSVpNOEtnQklyb1dCUkRP?=
 =?utf-8?B?ZmV3MTlnQUFIRUZMUDNZREw1WGttYzJTM24ra1RYaGRubzV6eHRoOEovWFRG?=
 =?utf-8?B?T3poWTdvTmpBT0ovd0lkTWplYk9ybm9Rek9CeERJZ0FBTSsybW40QnNoWlor?=
 =?utf-8?B?NXA5YVp5Z0FrQlBscGpTTUhCOHA4OHJPU3d6U3ROSzRZRVdBQVRmTVJDYUNY?=
 =?utf-8?Q?eXFw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 18:19:45.9260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5645ae8c-28bc-4a05-edc4-08de17e0e7af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7640
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

On 10/30/25 10:25 AM, Anshul Dalal wrote:
> On Thu Oct 30, 2025 at 7:16 PM IST, Andrew Davis wrote:
>> On 10/30/25 12:19 AM, Anshul Dalal wrote:
>>> We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
>>> which is ran after tispl is loaded but before jump_to_image.
>>>
>>> In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
>>> just as standard secure falcon mode (since spl_start_uboot returns 0
>>> now). Once the kernel and args are loaded.
>>>
>>> Now when the flow goes to jump_to_image, we do the regular pre-jump
>>> procedure and jump to TFA which jumps to the kernel directly since we
>>> have already loaded the kernel and dtb at their respective addresses
>>> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>    arch/arm/mach-k3/common.c    |  8 +++++++
>>>    arch/arm/mach-k3/common.h    |  4 ++++
>>>    arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
>>>    3 files changed, 57 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>>> index 04a0f232d84..c446d1c47fd 100644
>>> --- a/arch/arm/mach-k3/common.c
>>> +++ b/arch/arm/mach-k3/common.c
>>> @@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
>>>    
>>>    void spl_board_prepare_for_boot(void)
>>>    {
>>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>>> +	int ret;
>>> +
>>> +	ret = k3_r5_falcon_prep();
>>> +	if (ret)
>>> +		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
>>> +#endif /* falcon mode on R5 SPL */
>>> +
>>>    #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>>>    	dcache_disable();
>>>    #endif
>>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>>> index 52d3faaab5c..5807d358464 100644
>>> --- a/arch/arm/mach-k3/common.h
>>> +++ b/arch/arm/mach-k3/common.h
>>> @@ -52,6 +52,10 @@ void do_board_detect(void);
>>>    void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>>>    int shutdown_mcu_r5_core1(void);
>>>    
>>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>>> +int k3_r5_falcon_bootmode(void);
>>> +#endif
>>> +
>>>    #if (IS_ENABLED(CONFIG_K3_QOS))
>>>    void setup_qos(void);
>>>    #else
>>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>>> index 6269b33f66b..439dd92ef54 100644
>>> --- a/arch/arm/mach-k3/r5/common.c
>>> +++ b/arch/arm/mach-k3/r5/common.c
>>> @@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
>>>    	}
>>>    }
>>>    #endif
>>> +
>>> +#ifdef CONFIG_SPL_OS_BOOT_SECURE
>>> +
>>> +static bool tifalcon_loaded;
>>
>> Not strictly needed as statics will default to 0, assigning false
>> here makes it more clear what the starting value should be,
>>
>> static bool tifalcon_loaded = false;
>>
>>> +
>>> +int spl_start_uboot(void)
>>> +{
>>> +	/* If tifalcon.bin is not loaded, proceed to regular boot */
>>> +	if (!tifalcon_loaded)
>>> +		return 1;
>>> +
>>> +	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
>>> +		return 0;
>>
>> Extra indent tab here.
>>
>>> +}
>>> +
>>> +int k3_r5_falcon_prep(void)
>>> +{
>>> +	struct spl_image_loader *loader, *drv;
>>> +	struct spl_image_info kernel_image;
>>> +	struct spl_boot_device bootdev;
>>> +	int ret = -ENXIO, n_ents;
>>> +
>>> +	tifalcon_loaded = true;
>>
>> Should this be set down after we make sure loading doesn't fail?
>>
> 
> That wouldn't work actually, tifalcon_loaded is used to detect if
> tifalcon.bin has been loaded or not. We then in-turn use this
> information in our two step boot process to decide whether or not to do
> falcon boot.
> 
> The call to load_image below will internally calls spl_start_uboot to
> check for falcon mode status, which will return 0 now allowing us to
> load fitImage.
> 
> So, the overall boot flow looks as follows:
> 
> 	board_init_r
> 	|-> boot_from_devices
> 	|   +-> load_image (we load tifalcon.bin here since spl_start_uboot returns 1)
> 	|
> 	+-> spl_prepare_for_boot
> 	|   +-> k3_falcon_prep
> 	|       +-> load_image (we load fitImage here since spl_start_uboot returns 0 now)
> 	|
> 	+-> jump_to_image
> 

Okay, makes sense, thanks for explaining this out :)

>>> +	memset(&kernel_image, '\0', sizeof(kernel_image));
>>> +	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
>>> +	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
>>> +	bootdev.boot_device = spl_boot_device();
>>> +
>>> +	for (loader = drv; loader != drv + n_ents; loader++) {
>>> +		if (bootdev.boot_device != loader->boot_device)
>>> +			continue;
>>> +		if (loader) {
>>
>> If loader is NULL, the if above containing loader->boot_device would have
>> already null pointer deref crashed. You might want to move this check up
>> into the if check above.
> 
> You're right, this needs to be fixed. I was following a similar
> structure to boot_from_devices (common/spl/spl.c) which also seems to
> have the same issue.
> 

Looks like someone else found that also and just fixed it in spl.c:

https://github.com/u-boot/u-boot/commit/ae409a84e7bffb0c5a0d420d72806ac7b854f619

Andrew

> Regards,
> Anshul
> 
>>
>> Andrew
>>
>>> +			printf("Loading falcon payload from %s\n",
>>> +			       spl_loader_name(loader));
>>> +			ret = loader->load_image(&kernel_image, &bootdev);
>>> +			if (ret)
>>> +				continue;
>>> +
>>> +			return 0;
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +#endif
> 

