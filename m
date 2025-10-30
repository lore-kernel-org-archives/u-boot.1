Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C147CCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 15:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C80583642;
	Thu, 30 Oct 2025 16:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aJVd+2Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C719836D1; Thu, 30 Oct 2025 16:26:11 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC338331F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 16:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0RAhriiiyB00dBEVyZVfGqJWF3i2nHvI5CORNADod9RJHty9C8N2sCUXIvrDltYhpLuPSHRTUTkYrbsHaXp4l6hTTBRiE5J2F2rMROQS2okWcIu9qf0/jUD0hVb/XuOolbvamcU7a657JhfWE21eT7ZmfsO5ApjoMprzKjvQgZN+vG1t0s2Bxd10ETYkjqDbgXp1iJX9d0p9U9eV7chyFD77YwImpIto/bxt4U/4k0i7+Sbo1w/QBV94g7BnqTcnjVcqPBjPhwkDRhQ5slbwGe58qXvI2xrZe9paEbcv4UQ92HJWcpzqdybeSKGors9woVpDEt9aAn2YlwlpKP29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4EXWvUF2MTUpqZNTAB5pysaTnolbtivXNRCFCmexxA=;
 b=oKBlAq8HujQMC3uuV+GP5Ej3AIpb0XN/gjrlY+d//fiCqm6iFIAIkcCoHD9Zsr2PwqvUHg8QD6YsUIgg0I4X8O/hkIuWJUkzgM+dLXbPVp5HaKNvXeMtOQrM0VE6rvb8pE0JachXth6axb6hG34+4uWKfbI/Nzp9iuMjzQYvwszW8GfscPRg7L0EdQkL7GJUlC6p4p+/YegH86ZTENXnoZ7pDwjs1G7L9xqBhaPXRS3+3UfgARAp6tdFsS/JrBFlVjlVV4rVSDNNhgV1+DP1ZMqsFKNAylTW+cgPqoK+bPqUocJR0GymTlauZXTb/Sjpi/iVE3gbJ2M24j2oLB/haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4EXWvUF2MTUpqZNTAB5pysaTnolbtivXNRCFCmexxA=;
 b=aJVd+2Z4/nvbfNAbxjeMKckYqHwnQCnLg1VTW81Ik8uifdvM3feENQkI9VJfBCzo9quwiMryZs7y6wda4C41O8H4QKKEuXJa2r8HgT6sXelc7oI5pnh9kAUAkj+eDp1m+xWzzN6H6BCx45vLHl0QXIFYTvoyLZWgMDLk0WgZX0I=
Received: from BL1PR13CA0433.namprd13.prod.outlook.com (2603:10b6:208:2c3::18)
 by IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 15:26:03 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::78) by BL1PR13CA0433.outlook.office365.com
 (2603:10b6:208:2c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 15:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:26:03 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:25:59 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 10:25:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 10:25:59 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UFPwNe2404270;
 Thu, 30 Oct 2025 10:25:59 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Oct 2025 20:55:58 +0530
Message-ID: <DDVRFKCHCSJB.3HC7YUPKQQVDJ@ti.com>
To: Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>
CC: <b-liu@ti.com>, <bb@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v9 3/8] mach-k3: common: enable falcon mode from R5 SPL
From: Anshul Dalal <anshuld@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251030051937.3659010-1-anshuld@ti.com>
 <20251030051937.3659010-4-anshuld@ti.com>
 <e6791dc8-45b5-458e-afdf-f96778b529af@ti.com>
In-Reply-To: <e6791dc8-45b5-458e-afdf-f96778b529af@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|IA3PR10MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 499461d5-7551-4d42-334c-08de17c8a385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHRzVDQyT1JDNGFoQXJvYSszM0FnSXo2b0FudU8yekVPU1M2N21VQkdlZnZx?=
 =?utf-8?B?VWlYbzYySG1yZEYrUTByalI5U1lRdHRPczg2MkpNcnhxUlltUjhiRXB6QVJa?=
 =?utf-8?B?dHlGOUFpcnk2RUVxUVVjUDVHMCtTVEpxQ2ZRb2xNQlczemdKNkNibmg0RzFJ?=
 =?utf-8?B?djBCQTB2dHJGYkRKR3BPZG1yWEpMR1lzcXRMWDVNcUNxcldFZzRlbEt2QlVJ?=
 =?utf-8?B?d05SRnJMbUlwdkNnVGEvTFRNeEVSS3RyOHlTeFhBd05oN0EyRm0rTGxXamtR?=
 =?utf-8?B?N1F5V3A1QXM0OU1rRnF5ZnVWWHFLRS8zK0VIWXcrYytGR3B5djN1YnlURnlq?=
 =?utf-8?B?eHhlakY4QStRcmx2UmE0MUU1bHVpdndkN0hLR2RXUzFzSkxaS1Y3UGtIelBP?=
 =?utf-8?B?em44Y0prWlJ4RFpjbG15eVlIenpJZ3hUelNqM0NXbC9yY1U1RVJjbURnTExP?=
 =?utf-8?B?UHFyZ09qVjJhcmNaYU5jaXRjMURGWDFrSkhGMm5ObkZIWVQ5dFdyaUs2Ym11?=
 =?utf-8?B?KzNScENPWWM0NEoveWM0MnZKZm1BY05Cdi9RUm9mMGhtZkFBMTVRdkdnWC9H?=
 =?utf-8?B?K21vRkpuc2F4citaQ01sOWZDVXU4clVWWE5uK1Jkdlk4VWtKV21lMHJISy9j?=
 =?utf-8?B?RmVrNmV4Vkh0YkEzSDhkRDlNRVNxN0xyZ1dpd056WnIvZ2RabEthYk83aDBi?=
 =?utf-8?B?UG1CbGdYZzVWSks3Qk4xTDc2QmN6RXlYN0plczZ4Ty9uVm45RndTbzlkR1FG?=
 =?utf-8?B?cm1VS3k1UnlLdUs1NXEvQlZhOHhReDY1VTZ6TDErMXo1dlF5a2h0Z21EWlNS?=
 =?utf-8?B?ZjJ0M1VtVGtKMDIycVFNUzV2Zk5ZZkU0ZTErc0hLaTVJdG1xSnBvVUt4d0JE?=
 =?utf-8?B?Qm44T2JZT1Q3YXdGb1lhS2lKeVBqZm9VSThhcGUrYkpLTUZXMkNkeitzRUN3?=
 =?utf-8?B?b2dpR3BZNnBVbjRJdG5zV1JWQjlIQTY3aTh4d0tod0VDK3RhUnBjRmRTTVdu?=
 =?utf-8?B?cGdGaUFmRTh6Nkx6ZGxabTM3OXpuWUV6QlkwZnV1YktwYWlHQXhJNTVBamR1?=
 =?utf-8?B?TFZ6ODMzaStDWjZxMUU3bEJ4TUVmd0tiNHYxdk4zUTJMNEpUbUZxOTVhQUlk?=
 =?utf-8?B?ZkNWQ205L3VZc1VvTUlyQ3lSL1MzZlg5MlQwTTY3M1dUMVVlY0RuY3pEOWdp?=
 =?utf-8?B?NnVqNC9IQmE4NmdaekVIZVE4aFFaL1Zoa1VacklBOVdzdmkwV00vTGlReHRh?=
 =?utf-8?B?T1JVd0lrTERlc3pGS1crNzJZMFJYMU5IUVg0OWszVGt1N3Q5WnoraE50RzJY?=
 =?utf-8?B?aFhMVlh5ZVkrQ2JOMXZ3R1dRRmhaUTRQbzRmS1lIdEgyeUttQ2s5VjU4ZEph?=
 =?utf-8?B?RkFDaG8yQ290QlR3TUdHWVNwQkJFUXpsamFtcWoxZ0N2SjY1Zkh2RnlOclBt?=
 =?utf-8?B?S2ZydUtadHAraEsvOHpLQTA3alBmMHZLTFZ1cVV3a1kxS3MvTzg1aVFlTUMw?=
 =?utf-8?B?RkxOTGxnbzQxeDJWN21TTDJyQnJwMmhzdHJ0V21FSlVKMFN0eE91M21zanVV?=
 =?utf-8?B?K1NnNGV2WEtpVGh2ZXRXN3l5STVydm5wRllaMW9UWkp4UTF5WmlqdVhGT283?=
 =?utf-8?B?NCtMOXBBQzkwaDkxUjlqSkpiZmE4V1UxbnZjeTB4cXE2YllpRW9qZHdNVndM?=
 =?utf-8?B?QzQvRDYwV3UyOTFDUXRrWnNnQ2djTWZ2SnJVbmRXckNuYU5STEZzSHNxd2NK?=
 =?utf-8?B?NVF0YjRWNzJ1ZnpXTUNmRmNaTUxEWXlIU0k4VkF6S1pEYTBsUnpsV09kNEVH?=
 =?utf-8?B?NXlGQTZDWGVNemtTaXNMcXovcjE2eURJTjJBN0VvMlYvVERoR3JpcU5ncGRy?=
 =?utf-8?B?cWwrWkNRcC9Cb3RNdlVNY0p4ckxBd0lyS2VydlhSKzhrbUJPcE1MNWNRNGpk?=
 =?utf-8?B?ZUVkaFRST2VzUVFkSzJGdkdOMlJkSG8xSW95OGpHWC9CYVROREZtQmZIUmFs?=
 =?utf-8?B?UVpKWkRWZGFRUkJmOEh6UkhRVUh0OUtDWVVRSTg0U2lTOU8zMGN6RERZOE1N?=
 =?utf-8?B?RVhmQlBMTUM1Rm9nc01nTmtCSExBTmpRUzEveENBUVFiMUZybklweGtlS3pr?=
 =?utf-8?Q?7rYQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:26:03.6855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499461d5-7551-4d42-334c-08de17c8a385
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
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

On Thu Oct 30, 2025 at 7:16 PM IST, Andrew Davis wrote:
> On 10/30/25 12:19 AM, Anshul Dalal wrote:
>> We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
>> which is ran after tispl is loaded but before jump_to_image.
>>=20
>> In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
>> just as standard secure falcon mode (since spl_start_uboot returns 0
>> now). Once the kernel and args are loaded.
>>=20
>> Now when the flow goes to jump_to_image, we do the regular pre-jump
>> procedure and jump to TFA which jumps to the kernel directly since we
>> have already loaded the kernel and dtb at their respective addresses
>> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   arch/arm/mach-k3/common.c    |  8 +++++++
>>   arch/arm/mach-k3/common.h    |  4 ++++
>>   arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 57 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 04a0f232d84..c446d1c47fd 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info =
*spl_image)
>>  =20
>>   void spl_board_prepare_for_boot(void)
>>   {
>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>> +	int ret;
>> +
>> +	ret =3D k3_r5_falcon_prep();
>> +	if (ret)
>> +		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
>> +#endif /* falcon mode on R5 SPL */
>> +
>>   #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF)=
)
>>   	dcache_disable();
>>   #endif
>> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
>> index 52d3faaab5c..5807d358464 100644
>> --- a/arch/arm/mach-k3/common.h
>> +++ b/arch/arm/mach-k3/common.h
>> @@ -52,6 +52,10 @@ void do_board_detect(void);
>>   void ti_secure_image_check_binary(void **p_image, size_t *p_size);
>>   int shutdown_mcu_r5_core1(void);
>>  =20
>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
>> +int k3_r5_falcon_bootmode(void);
>> +#endif
>> +
>>   #if (IS_ENABLED(CONFIG_K3_QOS))
>>   void setup_qos(void);
>>   #else
>> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
>> index 6269b33f66b..439dd92ef54 100644
>> --- a/arch/arm/mach-k3/r5/common.c
>> +++ b/arch/arm/mach-k3/r5/common.c
>> @@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, =
int node, void **p_image,
>>   	}
>>   }
>>   #endif
>> +
>> +#ifdef CONFIG_SPL_OS_BOOT_SECURE
>> +
>> +static bool tifalcon_loaded;
>
> Not strictly needed as statics will default to 0, assigning false
> here makes it more clear what the starting value should be,
>
> static bool tifalcon_loaded =3D false;
>
>> +
>> +int spl_start_uboot(void)
>> +{
>> +	/* If tifalcon.bin is not loaded, proceed to regular boot */
>> +	if (!tifalcon_loaded)
>> +		return 1;
>> +
>> +	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
>> +		return 0;
>
> Extra indent tab here.
>
>> +}
>> +
>> +int k3_r5_falcon_prep(void)
>> +{
>> +	struct spl_image_loader *loader, *drv;
>> +	struct spl_image_info kernel_image;
>> +	struct spl_boot_device bootdev;
>> +	int ret =3D -ENXIO, n_ents;
>> +
>> +	tifalcon_loaded =3D true;
>
> Should this be set down after we make sure loading doesn't fail?
>

That wouldn't work actually, tifalcon_loaded is used to detect if
tifalcon.bin has been loaded or not. We then in-turn use this
information in our two step boot process to decide whether or not to do
falcon boot.

The call to load_image below will internally calls spl_start_uboot to
check for falcon mode status, which will return 0 now allowing us to
load fitImage.

So, the overall boot flow looks as follows:

	board_init_r
	|-> boot_from_devices
	|   +-> load_image (we load tifalcon.bin here since spl_start_uboot return=
s 1)
	|
	+-> spl_prepare_for_boot
	|   +-> k3_falcon_prep
	|       +-> load_image (we load fitImage here since spl_start_uboot return=
s 0 now)
	|
	+-> jump_to_image

>> +	memset(&kernel_image, '\0', sizeof(kernel_image));
>> +	drv =3D ll_entry_start(struct spl_image_loader, spl_image_loader);
>> +	n_ents =3D ll_entry_count(struct spl_image_loader, spl_image_loader);
>> +	bootdev.boot_device =3D spl_boot_device();
>> +
>> +	for (loader =3D drv; loader !=3D drv + n_ents; loader++) {
>> +		if (bootdev.boot_device !=3D loader->boot_device)
>> +			continue;
>> +		if (loader) {
>
> If loader is NULL, the if above containing loader->boot_device would have
> already null pointer deref crashed. You might want to move this check up
> into the if check above.

You're right, this needs to be fixed. I was following a similar
structure to boot_from_devices (common/spl/spl.c) which also seems to
have the same issue.

Regards,
Anshul

>
> Andrew
>
>> +			printf("Loading falcon payload from %s\n",
>> +			       spl_loader_name(loader));
>> +			ret =3D loader->load_image(&kernel_image, &bootdev);
>> +			if (ret)
>> +				continue;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +#endif

