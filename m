Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C970D3ABD5
	for <u-boot@archiver.kernel.org>; Sat,  6 Dec 2025 01:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E6D83FA3;
	Sat,  6 Dec 2025 02:17:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BOO6Tt8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9494983FA7; Sat,  6 Dec 2025 02:17:58 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5693A83B4A
 for <u-boot@lists.denx.de>; Sat,  6 Dec 2025 02:17:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHRble4sUTlVor6j0/hhHUFrWJT+//UWhS9p0tQExiQZVUSyE5MbP8f4F1ch/nMw+/pyysnA8MNXmPh6QySsri/hOGp+jOjDcEcqpphUP4X6uedNvsbONnd8RoVx+jGc/Kx7dduoidpbWlwlR3aY9xphrGhnYM9bUI4DgXj5CsbYgAG8busXQIW+Vg7ZnJ+H0hvzDJBEhmBZ7FZR/aI/I9GEOE/YlgxQg6C6OTBSVFQGsMIvawtsDe18RguM4u7qsHdwMs9R5IlOXveMkbXKPGR8w2xoqzFxiul8CSm5fIZCh7q1vxMGr27gQQujn7Kt3pJ7yfHwj5VYVhJ1IZGKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOX0vh1Qc33Rg2tdTsYjlMbZrkSDFD5SrzqFRokLH+g=;
 b=uoo541CStrQw7xSGuamw6By3SGE/CGSAsBtTbUs4CLa5Zd20Ffp8fI+jWTYdgVLvgt/X2alXm5TKuHEakHfyh1op1jTOrym90zcOI4ohZA5ockwGerufcMOOlBllAanARPqfo+V5pGyNeVRs/RlMW1uSnQOlcUTHFF84x7K2CjacaU5Zz18X4phPsA+UTLJr8WW34ZEnPVkAsyabC4lzMMUha080qnmKM0NOvsVUrGwi69Q8u1qwXunFZuqLc/Ns1536ZkVEChsPfmLRrhxnY27ZpIc4+jGN59cT0TZAXPG0MfJKtcoCg9sUvZhAYyDNGLTrBaApCuPbMXA599GjXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOX0vh1Qc33Rg2tdTsYjlMbZrkSDFD5SrzqFRokLH+g=;
 b=BOO6Tt8kIoOUyO75ge15WRHCjrmLDfO93bK7DC57cukvulovp7yCB8K0SGYL5+IgikyYuB7C339NlBxLC2XhZ7NJONowkgRL0JwvmPkcPGSWcwirMfUFFesi6YXfvTDkJ+uFRpAzqXpQPhU9cvg6vOOMWrRev5ogpleDFA2KKq4=
Received: from BN9PR03CA0120.namprd03.prod.outlook.com (2603:10b6:408:fd::35)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 01:17:52 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::5c) by BN9PR03CA0120.outlook.office365.com
 (2603:10b6:408:fd::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Sat,
 6 Dec 2025 01:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 01:17:50 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 19:17:45 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Dec
 2025 19:17:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Dec 2025 19:17:44 -0600
Received: from [10.250.148.210] ([10.250.148.210])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B61HfNj4177453;
 Fri, 5 Dec 2025 19:17:42 -0600
Message-ID: <44f5a89e-e62a-410c-a2a4-aaeaba0f091c@ti.com>
Date: Sat, 6 Dec 2025 06:47:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: board: ti: Add J742S2 support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>, <anshuld@ti.com>
References: <20251205043602.845730-1-u-kumar1@ti.com>
 <87pl8trq6c.fsf@kernel.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <87pl8trq6c.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 92809dd1-99f3-4c3f-3f05-08de3465466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjJKMG1vT21RRWcxS1FZZGNLSUMxeEhNYnNDVFllU201Q1Q0RWluQWFrejFG?=
 =?utf-8?B?bzY0TU45NVFGK1g4RkdVMGhuN0NtY0lUd1FkSEwzb2hDQUpzWXpEYWdPM213?=
 =?utf-8?B?SGpISmxDZkVoZmZWb2VaV3hES3dHRFh6Qkg2bFVWM01RdmxRY1FDTDA1RzJW?=
 =?utf-8?B?dmlwUEkwd1hNdE9TM2RaSFg0dTJQZnFxWWJUeGNFdThMNmZXTkgwY3NTL2RI?=
 =?utf-8?B?ZlEybjNla3hkZ09JeFVXbW5tTkkxbG51RW9hQW41aUsya2NlUXZpMUlWQkRF?=
 =?utf-8?B?c2srbklLVU1majdobVRTb3krZEdGSGJUMnJnaDUvRFEvb3p1UXBqR0EzbWpF?=
 =?utf-8?B?Y3hYd0trTHBPTjhuZHFuVUY0Q1pYcFRjTVd6RktFQWVJWW9aaXRxMGxlOGVK?=
 =?utf-8?B?Yk9HOWFXbUZSY3dPR0ptWkZLd3AvV24rYmJYTDhNYUZNeGVRTlh4bXovcDAz?=
 =?utf-8?B?ZnBRSHZLeXJURmpJNHBNRVVJSi9QRXY4YzZvaVErKzJia0g0Zk94Z1BldGNm?=
 =?utf-8?B?K1Z2dXdtUG1pQXRKVm85Z1EyaXMxaGIzOVM2ajhnNnRyWHIyTkFXY2xLNGww?=
 =?utf-8?B?dWNqR0YySE1jOUtKRkdJU0ZuTGhSSWI4SmVQcGJCT3FnZTMvTHdZd0NRQTlC?=
 =?utf-8?B?SWF3Y1BwVys5OXRiRklqa3FLSEI3NkJqR0JWQlRSUTVtZHN2SnRhSWxib1JM?=
 =?utf-8?B?YjZpdm52ZHp0Y3ozUk4zVXVUSHNkZDBRTnUvSmtQMFI1RllVOE1neW01bHg0?=
 =?utf-8?B?dVdVVWZQV3JBbGZJRVZQNlZ4ZDIvQVFRTVhROWtaQ2czSDJJR3JHQmk1bTFj?=
 =?utf-8?B?WHl3U2FFSDNSN3FxRjJjd05nMWlUZVBtcmh4ekNyWEc3K0x1TTY4S0FlTmhG?=
 =?utf-8?B?cnlJU215SU94SWViMlgzUXNDR1BuZGZ3QlBSbm9vWk80VGQzMjNadGhMdEtM?=
 =?utf-8?B?OUN3KzdWVUdZTG52WGY3VlNHcVVOeUJFaWtxTTFzWmlwaWw3dE1xVWFEMDBS?=
 =?utf-8?B?VHhIajdJd0VFR1dUeDAxcThWcGhzd3FnelVSREM3NnBxSEpTQzI4QjNSRmRy?=
 =?utf-8?B?d2ZwSHBQRTJKamx0a3VLWHpmVC8vRUZwYUdqR3JCdForczlNa2pJelNZa0k2?=
 =?utf-8?B?TFFHTlRKTkRNVGFrKzEzQ0hOSWd4aHJhc0xpdTd1c1FwMmlaYmtGRG9LTlk3?=
 =?utf-8?B?czNOZkpRemZHZUhubkJmcVJaQ1BPR2todE5KN3haZ0RPOE5OcXA1bS9EU0RF?=
 =?utf-8?B?Ri9ZSllZcm5ta29MVkNvRFNEYUlFRjdyRXludWYrRTRPSmkyWEdoVU50TTlt?=
 =?utf-8?B?YnI5NFpwU0h3cGlzMEhaUGhkNDlYUTdCaHhRN2txclMrN3dMT1A2M3R4Vko4?=
 =?utf-8?B?ZnRtUFhCakVWQWI0VkZWQ0p3eUZLQUhUVXY4V3NESWJ0SFAwZTJtVCt2VjBM?=
 =?utf-8?B?UHU1TXpJdFlvTUZYUTc5bjB1RkkwbVVaT29uQVhaNW8xd0E1RkkyNkdwQzVq?=
 =?utf-8?B?cVA3Z0ZzZmV3U3R4VFFqU1A1MUNGK0JGdy9FMm83bmJka2tDa1pFRHE2Q2dL?=
 =?utf-8?B?VVlnRkttNERzaDB0RGN4VFJxTG5KbmNqbTg2aVNTeUIzdVI5WWJLQzYwU2FI?=
 =?utf-8?B?NlpWMlNGUkJ3eklvMEYzVzFPdUJEdGF5c2lIY3N0NjZhdmg1MGEzdVZaQTIr?=
 =?utf-8?B?SEoxYUdnemJjKzdsc2gvaCtNODVJaDJ5a2JrajVWdEU3TzVFSmdXMHVWaEtM?=
 =?utf-8?B?RExNVEVOU1lkbzNDWHFzam5zVG4rNGx3MklWOUszVmltaWp6OXViVUdZTko4?=
 =?utf-8?B?ZG9oRlZBMnEvMWtRaTNCRlhESWNwS2NmL2Jmemo4cmNYdjhjRlNpbEdNQmRR?=
 =?utf-8?B?TER4TkZQOVhLL3JiM1gyOTUvN1RiZEc5RTlyaHdWdGZabmZDQUFlTHVVTVZC?=
 =?utf-8?B?b1RrKzBDcnRHeGh0ZjZOU08yeXJIZnZEQ21UVDg0bVlNckJtZ2o2a011VC94?=
 =?utf-8?B?SWlOblRVL0lFcFpnZWY0Z3ZLcGMxOUtiSmd4L1M1RVFqM3V0Z2IzNDVIbW10?=
 =?utf-8?Q?DTmdy3?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 01:17:50.9807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92809dd1-99f3-4c3f-3f05-08de3465466c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
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

Thanks Mattijs

On 12/5/2025 7:22 PM, Mattijs Korpershoek wrote:
> Hi Udit,
>
> Thank you for the patch.
>
> On Fri, Dec 05, 2025 at 10:06, Udit Kumar <u-kumar1@ti.com> wrote:
>
>> J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
>> to build u-boot for J742S2 EVM board.
>>
>> Add guide users on how to build for that board.
>>
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>> ---
>> Test logs
>> https://gist.github.com/uditkumarti/b2e23151728628805a680b6eab528e7c
>>
>> Changelog:
>> Changes in v2:
>> - Removed extra =
>> - link to v1:
>> https://lore.kernel.org/all/20251204142451.834404-1-u-kumar1@ti.com/
>>
>>   doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
>> index 22442874110..69deeee1076 100644
>> --- a/doc/board/ti/j784s4_evm.rst
>> +++ b/doc/board/ti/j784s4_evm.rst
>> @@ -1,8 +1,8 @@
>>   .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>>   .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
>>   
>> -J784S4 and AM69 Platforms
>> -=========================
>> +J742S2, J784S4 and AM69 Platforms
>> +=================================
>>   
>>   Introduction
>>   ------------
>> @@ -37,6 +37,11 @@ Platform information:
>>   * https://www.ti.com/tool/J784S4XEVM
>>   * https://www.ti.com/tool/SK-AM69
>>   
>> +J742S2 is derivative of J784S24 SOC, More info can be found in
>> +
>> +* TRM : https://www.ti.com/lit/ug/spruje3/spruje3.pdf
>> +* Platform Information : https://www.ti.com/tool/J742S2XH01EVM
>> +
>>   Boot Flow
>>   ---------
>>   Below is the pictorial representation of boot flow:
>> @@ -99,6 +104,15 @@ Set the variables corresponding to this platform:
>>         export UBOOT_CFG_CORTEXR=am69_sk_r5_defconfig
>>         export UBOOT_CFG_CORTEXA=am69_sk_a72_defconfig
>>   
>> +.. note::
>> +
>> +   For J742S2-EVM, use the following U_BOOT_CFG instead:
>> +
>> +   .. prompt:: bash
>> +
>> +      export UBOOT_CFG_CORTEXR=j742s2_evm_r5_defconfig
>> +      export UBOOT_CFG_CORTEXA=j742s2_evm_a72_defconfig
>> +
> nitpick: Can't this be grouped in the same .. note:: block as for AM69
> defconfigs ?
>
> I tend to dislike multiple notes blocks one after another.
> It is fine if you don't want to change this as it's a "personal preference".

Sure, will merge alone with AM69 section


>
>>   .. j784s4_evm_rst_include_start_build_steps
>>   
>>   1. Trusted Firmware-A
>> @@ -146,13 +160,19 @@ variant (GP, HS-FS, HS-SE) requires a different source for these files.
>>    - HS-FS
>>   
>>       * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>> +    * tiboot3-j742s2-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>>       * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
>>   
>>    - HS-SE
>>   
>>       * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>> +    * tiboot3-j742s2-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
>>       * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
>>   
>> +.. note::
>> +
>> +   For J742S2, GP variant is not available.
>> +
> Can't this note be in the - GP section?
> Just after:
> """
>      * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
> """
>
> In my opinion, it would make more sense than at the end of the
> Target Images section.


Sure, will do this change in v3


>
>>   Image formats
>>   -------------
>>   
>> -- 
>> 2.34.1
