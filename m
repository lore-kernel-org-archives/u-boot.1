Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD39ACCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 05:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E228331F;
	Mon,  3 Nov 2025 06:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fjWPQJaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1913D83642; Mon,  3 Nov 2025 06:41:02 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C8982A9E
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 06:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKoEoQ+73bDu570Ky9r8B3Kze78FIkjlINLx52Z2aahRU3KLmtyX6rRu1oLNzOPN6fuRyW74XvEP09omIxRx0nRxcJp4k1zI/NzQOoTvr0/WcGyvP4E1+9gfzkUvM+WutUhAhNaZnLOI+XQkiZiMp8XGN15S+EYAyzAflYu2ByDyuGSKE6Lyb6skmI+jaTbbG+nsA5ZpbyKijmdt+vVOtBRhySa8+BYWOljpkeozlCyel1SOYzXBE7auvYcYgdyFdinN3ssIXQYChl67RP4nTKfZtA9mA9F5M7j/93CUwGvRiw0t3tryjiFfWQQNRMMoyc/Ol2GO/x/eygJntpCZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKL7Vh66cNHSTlm2mY2+uy4EhPN75AMEG33CfkLBABw=;
 b=RbNoUeM49nO/cO0is0l+yemlvIkXqDaetp0a9aag6jf++F8QxIK+5t/9VMzpmtLCuEw2UtssFYxeff+I0R54+YYK9Ao+mUpfxkcOSDRgSpub0IzjUSmsqaZ81P7RraxNAyk88n5Z5249HIcNDXWO1XB9tG9o9Xul9dfrkGGS07eCWE45NlWLKU043L9Y1JFHkcMVOdwFJHXirvXQsSQT4r4rg0VSp52FgnEU5wX8RPLgsCDjOHHu9yuPTvwYBxTXDnmsJCP+jo3bRgGWN3Y2BEmBhYZHGqU4cUyQCCzouOFMWVXwmA58zldoejOlFJL/5wJ3VWysqTY3JgjiCZMObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKL7Vh66cNHSTlm2mY2+uy4EhPN75AMEG33CfkLBABw=;
 b=fjWPQJaHhn3IK8BrMcXEjLkVE+bVMGjGp26Udm8QDA+VDq/5ncK8R9C/mCHXZ6PenlOKnCnmnz4sBof8LurPBJRqlIS8BhhZiHQDoMeDhWd8/Iic2WDE7g86Ed1XGA8ZDpnAPBANmnMLIBVEM1jW5/4wJprBNLxTQ2d+WxiDqdg=
Received: from DM6PR11CA0014.namprd11.prod.outlook.com (2603:10b6:5:190::27)
 by IA3PR10MB8044.namprd10.prod.outlook.com (2603:10b6:208:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 05:40:57 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::3f) by DM6PR11CA0014.outlook.office365.com
 (2603:10b6:5:190::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 05:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 05:40:56 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:40:55 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:40:55 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 23:40:55 -0600
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A35eoYh3607501;
 Sun, 2 Nov 2025 23:40:51 -0600
Message-ID: <ded6f86b-4003-4832-8d49-4a7285dddbb4@ti.com>
Date: Mon, 3 Nov 2025 11:10:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] spl: Add support for Device Firmware Upgrade (DFU)
 over PCIe
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, <trini@konsulko.com>,
 <lukma@denx.de>, <peng.fan@nxp.com>, <marek.vasut+renesas@mailbox.org>,
 <anshuld@ti.com>, <andre.przywara@arm.com>, <xypron.glpk@gmx.de>,
 <ye.li@nxp.com>, <sjg@chromium.org>, <dario.binacchi@amarulasolutions.com>,
 <a-dutta@ti.com>, <dinesh.maniyam@altera.com>
CC: <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20251023080922.3527052-1-h-salunke@ti.com>
 <87tszf5dj0.fsf@kernel.org>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <87tszf5dj0.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|IA3PR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d15cee-05f6-4daf-446a-08de1a9b8fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|34020700016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJjV3R6K0ZpWGFZL2lCUmtyb041cHppcGZPMTFxZ2s2NVplWEI0NUUvb1RC?=
 =?utf-8?B?SlQvNGZkOUs3TjBWNzBIQzZLOUp3OWtvZHFFalhRb1d6Z1Z5UlBJZDUzV1g2?=
 =?utf-8?B?UUZPbFE2U3lRTEpmTG9rUGpLQnY0VzRBWnljSmN4cDBGTkhZb3EvUjV5V25x?=
 =?utf-8?B?Z1JCSGdDNDJKOXJkRCtNSWlkQUVtUFJkZXpUYnhISlR3QzdyMVJVd0ptOG9Y?=
 =?utf-8?B?WFo0d2I5Rmt1czR1QVFyVm5XdkJ5Q2tYeTl5UEJGQTlhTUdtZ0J5UHJMOGJZ?=
 =?utf-8?B?MzgvcU5Ea3hMRXFiRm0xSDNQRG1Pam1BM1BoeUp2VlhUN1N1U0s4TkNXSCtm?=
 =?utf-8?B?SjlsdDJIMjVkdElZSEQvbUlmVUE4Q2JJUWI5YmwwaHUxdVozL2tSbzBGVkQz?=
 =?utf-8?B?YloyN2JGL3F1enUxZ3RoS3M2WmxzTzFrZUVrRE4xYlNGVXBQbE40dXpuNzhZ?=
 =?utf-8?B?cVBhTEM5Qkg3bmhYNTJXRVc3cEs3L2JBZ3ZrK2lEUVJMSFBpcWJNdzRDS3JX?=
 =?utf-8?B?eDQ2SlpGc0EvWnB4OVR5ajFaaTkrN0pJK0xIVURXZEoyVWpiVXRONGRCZlJJ?=
 =?utf-8?B?czN3SUJMeTZhVFpTeVE2b0pTZk9YcC80VkR6c3N0cEJQSzVxdTV1NzhJc05U?=
 =?utf-8?B?ekJFYjByMlpmNHBoM2RpV1gyUUg0TEtHWWlMNE5XcHlPSGRiQW1RSGdFUVhB?=
 =?utf-8?B?a0tXWk9MSU5JdUNlYVdYZDlvNWU0OTNEYm5nRmNwb28rcXFlV0ZhcEpUcVV1?=
 =?utf-8?B?eWpOQUI4aXNGMjlwWEcxUEV4RjNrSWhtdTVEWkhxYUVMODE4ZllXVlk3MEsr?=
 =?utf-8?B?UHNkWmlna0o2bGtDYkZQamFqR1JaOTdDbktnMlBkVUJlYVJhUXJERDlLcmdS?=
 =?utf-8?B?WHpNcnZmMHlMOC84STI2bFhrcm5XL1pLRTVSajN1UWhSNk1wUXFZTXY5a3ZW?=
 =?utf-8?B?ejlHVENVbENCV3BTQUtJalVzejJkYitKYkRZdEVXelcvdi9NSFVNeVhJSVd5?=
 =?utf-8?B?OGNRbHh6eWJrKzl5WXpjcG9DMFJtTkhJRXAwVUVyU25LdDlaQW1VS2UxUUFr?=
 =?utf-8?B?ME1JZzFDNkNnN0orYm9HZGhLV09MMnAzTDFGSEtVeWxsSDBRTktQUzlXSTBS?=
 =?utf-8?B?UjhKK3lSWFI2YXJLMDNoNE4zeTBVc3Zad1RuaHh3dHV2N2E3SG1YcWJ1YnFq?=
 =?utf-8?B?WTdyUWtpaVpNcDhiWi9LNzhleTc3OFY5Y1ZiUW1UcU9TbG96RXJYdjlzMG1z?=
 =?utf-8?B?dzRFVUJIQTQwMTFieFEzclp6QmpNaTFib3JtcWFHVXpXOUhFMlpnSWovM0tF?=
 =?utf-8?B?Mm11TlQxTFZ4UTVBR0wxc1Y0VktOc0JINHJqWU1zYy83R1QvMzRmMm93Nmlo?=
 =?utf-8?B?VHY5eCtLTFJEZFU5Z3N6MG9RZ2lTSzUwLzJBbjhDWGdaOG83Mi9Tb2l5NC9C?=
 =?utf-8?B?VjFMcjNia3ljdXc0MVRHN3U5dFQxK1FJZkZnamVSaE9QYUF6UXd5S0Q5dlVr?=
 =?utf-8?B?Slk1WHdQN093QVpUcDJjSCs1b1hwN1JrNDhOV2IzclVybVVPU1dtVWMvVFBi?=
 =?utf-8?B?SGtqYkhyd0UzN3pBcHpaOEl2cUdaajZoK2t0TE9GY0FPdlhQNGNHVGJ3UzB4?=
 =?utf-8?B?SzBuUmc4T2NUejlpbFVuT2xEYW9YVEpGb3laQ1dZeTgyMWI2S3U0VW8yMzJJ?=
 =?utf-8?B?bEQzdDhabzY3NnB6NDFYaGFDY0dPZEZzZHJ6eHI2bk9vSmh1bWlaVitGSmdo?=
 =?utf-8?B?RmxZZU5yS2R3M3hoclZNTnNXV0t1ZkJZVW92WVlBTHpkSWRvcm9ydVZqb2hL?=
 =?utf-8?B?S2JSdVYrODBmTFdPcFlkTkRGQ0JEaXlNU2tuV3ROa1lNVWhLM1I5N3l0aDNI?=
 =?utf-8?B?RTRza0ZXdEplckE3Q0RQQUhzOHRtQjJvRjBRT2pleEZabVJidU1xTU1MbS9l?=
 =?utf-8?B?MlR5MTRtRk01czRqd01ndXU5TStQZ1J2QU5iSjI1c0dCdTgvQlpzNTNEV1RY?=
 =?utf-8?B?alNyWWpDUnB0UUtxcXRCM1QxbmZ5UUlCMUhUakdzTmpQTE02dHVRVmZXVk1U?=
 =?utf-8?B?WGhCT05FdEFNUDhyY3NYQ0VpUzRDa2p4Q1JiaWdUcUlsWXFqOHRtMXJHaG5W?=
 =?utf-8?Q?GUNpJTCO0FAdBxel5p7ctwKO9?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(34020700016)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 05:40:56.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d15cee-05f6-4daf-446a-08de1a9b8fd6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8044
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



On 31/10/25 20:22, Mattijs Korpershoek wrote:
> Hi Hrushikesh,
> 
> Thank you for the patch.
> 
> v4 is in good shape already. I have a couple of small remarks below.
> Please have a look.
> 
> On Thu, Oct 23, 2025 at 13:39, Hrushikesh Salunke <h-salunke@ti.com> wrote:
> 
>> Introduces support for Device Firmware Upgrade (DFU) over PCIe in
>> U-Boot. Traditionally, the DFU protocol is used over USB, where a

[...]

>>   
>> +#ifdef CONFIG_SPL_PCI_DFU
>> +	if (spl_boot_device() == BOOT_DEVICE_PCIE)
>> +		return dfu_over_pcie();
>> +#endif
>> +
>>   	/* set default environment */
>>   	env_set_default(NULL, 0);
>>   	str_env = env_get(dfu_alt_info);
>> diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
>> index 71b7a8374bb..0c501cf02f2 100644
>> --- a/common/spl/spl_ram.c
>> +++ b/common/spl/spl_ram.c
>> @@ -27,6 +27,11 @@ static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>>   		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>>   				      CONFIG_SPL_LOAD_FIT_ADDRESS);
>> +
>> +#ifdef	CONFIG_SPL_PCI_DFU
>> +		if (spl_boot_device() == BOOT_DEVICE_PCIE)
>> +			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>> +#endif
> 
> Can't we rewrite this using IF_ENABLED_INT() similarly to what has been
> done for CONFIG_SPL_LOAD_FIT_ADDRESS ?
> 
> This should allow us to get rid of the #ifdef CONFIG_SPL_PCI_DFU part.
> 
>>   	}
>>   	addr += sector;
>>   	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
>> @@ -47,6 +52,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
>>   		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
>>   				      CONFIG_SPL_LOAD_FIT_ADDRESS);
>> +
>> +#ifdef CONFIG_SPL_PCI_DFU
>> +		if (spl_boot_device() == BOOT_DEVICE_PCIE)
>> +			addr = CONFIG_SPL_PCI_DFU_SPL_LOAD_FIT_ADDRESS;
>> +#endif
> 
> Same here
> 
>>   	}
>>   
>>   	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
>> @@ -64,6 +74,11 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
>>   		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>>   #endif
>>   
>> +#if CONFIG_IS_ENABLED(PCI_DFU)
>> +	if (bootdev->boot_device == BOOT_DEVICE_PCIE)
>> +		spl_dfu_cmd(0, "dfu_alt_info_ram", "ram", "0");
>> +#endif
>> +
> 
> Same here. Please rewrite using if (IS_ENABLED(CONFIG_SPL_PCI_DFU)).
> This way we are consistent with the rest of the file.
> 


Thank you for the feedback. However, using IS_ENABLED() instead of
#ifdef in these locations causes compilation errors on platforms where
BOOT_DEVICE_PCIE is not defined. The BOOT_DEVICE_PCIE macro is only
defined in platform-specific headers, and is not available universally
across all architectures. With IS_ENABLED(CONFIG_SPL_PCI_DFU), the code
inside the conditional is still visible to the compiler even when the
config is disabled. This means the compiler will try to evaluate
BOOT_DEVICE_PCIE on platforms where it doesn't exist, resulting in a
compilation error like:

error: 'BOOT_DEVICE_PCIE' undeclared

The #ifdef CONFIG_SPL_PCI_DFU approach ensures that the code referencing
BOOT_DEVICE_PCIE is completely removed during preprocessing on platforms
that don't support PCIe DFU, preventing the compilation error. This is
similar to how other boot device checks are handled in U-Boot when the
boot device macro may not be universally defined across all platforms.

Regards,
Hrushikesh.



>>   	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
>>   	    image_get_magic(header) == FDT_MAGIC) {
>>   		struct spl_load_info load;
>> @@ -102,3 +117,6 @@ SPL_LOAD_IMAGE_METHOD("RAM", 0, BOOT_DEVICE_RAM, spl_ram_load_image);
>>   #if CONFIG_IS_ENABLED(DFU)
>>   SPL_LOAD_IMAGE_METHOD("DFU", 0, BOOT_DEVICE_DFU, spl_ram_load_image);
>>   #endif
>> +#if CONFIG_IS_ENABLED(PCI_DFU)
>> +SPL_LOAD_IMAGE_METHOD("PCIE", 0, BOOT_DEVICE_PCIE, spl_ram_load_image);
>> +#endif
>> diff --git a/drivers/Makefile b/drivers/Makefile
>> index 7560008a842..77fc66eb8ba 100644
>> --- a/drivers/Makefile
>> +++ b/drivers/Makefile
>> @@ -26,6 +26,7 @@ obj-$(CONFIG_MULTIPLEXER) += mux/
>>   obj-$(CONFIG_$(PHASE_)ETH) += net/
>>   obj-$(CONFIG_$(PHASE_)PCH) += pch/
>>   obj-$(CONFIG_$(PHASE_)PCI) += pci/
>> +obj-$(CONFIG_$(PHASE_)PCI_ENDPOINT) += pci_endpoint/
>>   obj-$(CONFIG_$(PHASE_)PHY) += phy/
>>   obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
>>   obj-$(CONFIG_$(PHASE_)POWER) += power/
>> -- 
>> 2.34.1

