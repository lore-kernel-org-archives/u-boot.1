Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE18CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 06:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC77883642;
	Mon,  3 Nov 2025 07:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bN4nTmnt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2192838AE; Mon,  3 Nov 2025 07:05:40 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF768331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 07:05:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHynO7jBWdIoVXyt7ruS82jy9xg0YqC/SeYAOO5OXincqo7mT1ywLFUNdNNshsc0nv8MvjAZlGiYa+iPDdS43am/ecND4Y4ckm5QbYBS1Yz+ToLjTfFLddWiR19hv4oXOT8Onl/Zu4QOVl95sypfcvROeLf8pYehC9XTBCPsrSTUQ8npgMegPUDWAj/OS5R0LIVWEuWvnI4+kc00lESHd1Anh68lUwyc+DdeYSC+F+XyqJNyiitsJAAJbSUO5uhMbok87CMKEO3nemj66pRZJ/hS9hBVogNtLK4JpkDHkew7nDqLFUdIEIRTyFNKBFrRTOfbfQj1P5WCoDRV7IqpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGpEa0hYWNn7yzDiyZUANUFNNjQ1oFXYwnkqJjHSclE=;
 b=l08IE/KzFn3dddjbfwYIGqhTPUoyR6l21XybixGz46TCoOaeXMeuWIfZ8gD/7sd3WpizgXwnSkrSN/7y0OGL+TNaCWW7kVKInTs6Cb7sn9W9Ou4DqinHkkpZMQOYLTM15zFZvToIMbfRxEPNyxz52IUwkWktWgMoNaoAdaYddBjlKaK4hlY0+H6z6X5q5cuhFRBJkjInXMQBVVCiuxkMp8BKWoj7IhMjxVlSZGrRof9H8Q/Frp5Mp+nlpclSj99ao6EAkcycjdlPqzn5aH/LEqtO4/joIr5S8VFucF4g/xSG71vncjjNqAMdT3BWZqYn6ox12FlMLBsJSW31AmunOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGpEa0hYWNn7yzDiyZUANUFNNjQ1oFXYwnkqJjHSclE=;
 b=bN4nTmnt4b6ufDgOqZ0nAEKTo+KDongQ4e/NIiv/S60ao/PCp47vAU8WZIIL2BQvxHtkfbvWoaHODEL+3lppV3GmbVR7thAwyfxfLAeM0mLw1DPm/6rsDcSM2TwRBTcqeUmPMT82w/dEAu7qiBEkSc1iEf5svx9g686txBl6vL4=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by SJ2PR10MB7858.namprd10.prod.outlook.com (2603:10b6:a03:578::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 06:05:33 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:fc:cafe::ef) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Mon,
 3 Nov 2025 06:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 06:05:31 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 00:05:30 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 00:05:30 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 00:05:30 -0600
Received: from [172.24.234.127] (psdkl-workstation0.dhcp.ti.com
 [172.24.234.127])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A365QXw3596548;
 Mon, 3 Nov 2025 00:05:27 -0600
Message-ID: <788da073-2760-4b64-a82b-8172ddb5f833@ti.com>
Date: Mon, 3 Nov 2025 11:35:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mach-k3: refactor A53 speed grade clock-rate fixup
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Nishanth
 Menon" <nm@ti.com>
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
 <20251030-ti_speed_grade_fix-v1-2-703e4189640a@ti.com>
 <5f1d8353-bb04-4f43-847d-9f66761b574d@ti.com>
 <DDYT5EH4CX1N.UP6UHCIGTL78@ti.com>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <DDYT5EH4CX1N.UP6UHCIGTL78@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SJ2PR10MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dddc69-343f-4113-558e-08de1a9efee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHNGQzc2ZnpPN1hCd09jeExYclRkOUhzZkZEKzRGNE9rY2ROWmF5VlBhY1Bz?=
 =?utf-8?B?U240d2hBZDBZNWN1RWpBK29KWDY2SWZ3ZUdUaitWTVBWWE1UOGtIaEZvZ25x?=
 =?utf-8?B?S212Yy9ET2owMXJWRGVmRXVqMm1yRXhJL0hNWkN4ZnFVRGk4VjZrUDBvajd3?=
 =?utf-8?B?TEY3ZisyODRoNzBjclNka3AyaVRnK1hZckNqYzRmdUxLQWJIOGsyZFl3bHh1?=
 =?utf-8?B?ZlNKdS9GZ0FhblVRcTFQZ1pMQmRGMURSRE9HLzhLUytTbUZ1SE9QSlhVcXd3?=
 =?utf-8?B?SXprQ3ZIUkw1M0JtaFVXMGFRMFBpNFBVN1pJSjRkcVlWdVJwR2IvSnZGQUhI?=
 =?utf-8?B?Y2ZpZm1zTGhWRkpsbVdVUFJ4eHA1RzY1TWRzeUJHQmVBdkFrRnRYem9wZVlO?=
 =?utf-8?B?WjZGeGM1WkhCc2F0cFltNjJtdVlFemxaVnN0ZmF2N3Y5RllnbGRBS1NsWm4z?=
 =?utf-8?B?WGlDY0lObmRkRERwUFp5VjlCM01BdVQ2MEFiK2pSdVRndmdWVnIrWGhxSS95?=
 =?utf-8?B?VThxalVtb1dXbUtnL2ZJWFZuRGthWWErWkZsemJoeTVxekNyQVZWdG83TE1p?=
 =?utf-8?B?dXZmMG5IQnlEWEd5b3llMXJ4R2ZQNGFWclUyQ1AwTFludGlrUXV2RFhHd3Fz?=
 =?utf-8?B?MExOYW1paTdYcmFtTUpYdWtzYXpRQVVUaXArRStlK3o2V3hFL2hDZ0JHeDM4?=
 =?utf-8?B?V0FNdFhxQlZYUkJkeXF6aHpxc24wMFRTVU9HSmdMM1d2R1FFL1BYak9HbUpx?=
 =?utf-8?B?Vzg3OXQ5TFlvdGFPK2JTVWJVeEdCVU5CSXg5ZWFxdEF2Y0pocEU5bVErZzhj?=
 =?utf-8?B?czRGZHBFeWw5UnI2V0xNb25EdkxLbG00NVVkOVB2TWFMSEJMQVplTDZxWjlh?=
 =?utf-8?B?bEdHdU5jU2o2MTZWWWVvZlhnZ21GbDZtcFdKNHdRcUZxdmdONFJqSWxnWG9U?=
 =?utf-8?B?RitlZFV2MlozN216VUtsVG9SamRDWUdNbDhud3I1QWlzbXRyTjFQRzIzcmg0?=
 =?utf-8?B?VWF3ZEZYWE5VMWNNU1UvSmRmY0VEMXFEYTF3azJ0MDdrcll4VEV1aTZaN2NL?=
 =?utf-8?B?akZzMk1ZR25TZFhITUk3TWRoRDB4WFVDYjI5dHZYNDMrTU5KWFN4ZUg0TUlX?=
 =?utf-8?B?TzBwZWxMVkpCbThlSWNXZHRiVm1XdWtYc3dJV2hQbXB4cGxIOWdYSmt0TmV0?=
 =?utf-8?B?Q2VjTkpwOUNPUG1hajNmdUNXdVRmdzZTNzFOaXVKNC92am9zNm9EaDhtdHFK?=
 =?utf-8?B?SzhQbFdoek8zY0QrdFhITU50aWowaE43cDJzVTF3ZEtZeUQvU28yS2RQWjlH?=
 =?utf-8?B?Sks5bE9DUkZNV0ZUSDllM1pXRHV4RXBEWWpWWHV1bVpKVVg1WlBtOUlJRFhJ?=
 =?utf-8?B?ZVN6a05RVW5USElSL3FGZ3ozNmtJS3hHRE5GRjRwNmNsN0Q2UEZNelVScUVL?=
 =?utf-8?B?TE1Da2tSV2N5N2JrbWs5aFpVaXVMakVSdHJ3RGR6cHR4T0NRSkxqZU1ublNm?=
 =?utf-8?B?Vms0V0RXc0FLQmM4aVZ5VHpmN0RCU3l2MVV0dUlaUFhBMUdCdVZ6ZWNudy9L?=
 =?utf-8?B?VWRINDd0SHFmOUxCeFppRTlkODhybzk1TVJLbFl5b245OE1CdkFISGJRNHhM?=
 =?utf-8?B?OEpON3NLNVF3V0dneUZpU2RjZGVwM1k3SXpNcWs4ZjdzWDJDRDM4TGRwdG9j?=
 =?utf-8?B?N1BVRXdhRDNoMmVuenpEQ2x0andMcW1IQ1ZuSnZwRnU4K09sWnc5cjV5SS96?=
 =?utf-8?B?U2NvaXQ3VUJKbUxkV0twODZBN3F1bmNibU1xV2RqM2JmVXIrUWIraTU5N0t5?=
 =?utf-8?B?VW5DRjRLaUg2NFo5Zm56TGw4QjBwZWMydVFNcTlDZGpaUU5la1hIbzlsbGdV?=
 =?utf-8?B?S3R2VE5YR3N1ZU5jQmUweHVqZ1pjc0RxNmlCdXp0TjhBUDFlZVhaVWRoVCtk?=
 =?utf-8?B?YVBlMG1BMWw3WWMwalphVlhESldJU1RPUXVnZk1BRzFaSmNSVi9NZ1dRMDVX?=
 =?utf-8?B?SUUyL2puZUZjakpRb3kzeWQwajlVSnpJWDZBUmRuRDJIZ0svK1M2M0prNkVu?=
 =?utf-8?B?WWkvRWZRTDJ0VG43aWl5emdkRUhEcVE1YlZCWnByR2hRR2xIT0V6QVY4RzVX?=
 =?utf-8?Q?jhlQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 06:05:31.5868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dddc69-343f-4113-558e-08de1a9efee8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7858
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

Hi Anshul,

On 03/11/25 10:54, Anshul Dalal wrote:
> Hi Aniket,
> 
> On Sat Nov 1, 2025 at 9:30 AM IST, Aniket Limaye wrote:
>> On 30/10/25 18:33, Anshul Dalal wrote:
>>> The K3 ARM64 rproc driver uses the "assigned-clock-rates" value in the
>>> respective "/a53@0" node to properly configure the clocks for the A53
>>> core.
>>>
>>> Although the clock value in the DT node might need to be fixed based on
>>> SoC's speed grade at runtime. Certain SoCs such as AM62p and AM62x
>>> already had this implemented, this patch moves the common code to
>>> common.c to avoid duplication and simplify speed grade handling.
>>>
>>> The logic to detect the correct entry in the "assigned-clock-rates"
>>> property has also changed. Where we earlier relied on per SoC specific
>>> device and clock IDs for the A53 core, we now use the "clock-names"
>>> property which is device agnostic.
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>>    arch/arm/mach-k3/am62px/am62p5_init.c          |  87 ++++++--------------
>>>    arch/arm/mach-k3/am62x/am625_init.c            |  84 ++++++-------------
>>>    arch/arm/mach-k3/common.c                      | 108 +++++++++++++++++++++++++
>>>    arch/arm/mach-k3/common.h                      |  11 ++-
>>>    arch/arm/mach-k3/include/mach/am62_hardware.h  |  24 ------
>>>    arch/arm/mach-k3/include/mach/am62p_hardware.h |  17 ----
>>>    6 files changed, 165 insertions(+), 166 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
>>> index aebd5200b0db9959805d04408b34d283e21b6e2c..eeb054d575ad94040370817f648c5319850fe7f8 100644
>>> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
>>> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
>>> @@ -11,14 +11,10 @@
>>>    #include <dm.h>
>>>    #include <dm/uclass-internal.h>
>>>    #include <dm/pinctrl.h>
>>> -#include <dm/ofnode.h>
>>>    
>>>    #include "../sysfw-loader.h"
>>>    #include "../common.h"
>>>    
>>> -/* TISCI DEV ID for A53 Clock */
>>> -#define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
>>> -
>>>    #define CTRLMMR_MCU_RST_CTRL             0x04518170
>>>    #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
>>>    
>>> @@ -26,6 +22,29 @@ struct fwl_data cbass_main_fwls[] = {
>>>    	{ "FSS_DAT_REG3", 7, 8 },
>>>    };
>>>    
>>> +const struct k3_speed_grade_map am62p_map[] = {
>>> +	{'O', 1000000000},
>>> +	{'S', 1250000000},
>>> +	{'T', 1250000000},
>>> +	{'U', 1250000000},
>>> +	{'V', 1250000000},
>>> +	{/* List Terminator */ },
>>> +};
>>> +
>>> +char k3_get_speed_grade(void)
>>> +{
>>> +	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>>> +	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
>>> +			  JTAG_DEV_SPEED_SHIFT;
>>> +
>>> +	return ('A' - 1) + efuse_speed;
>>> +}
>>> +
>>> +const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
>>> +{
>>> +	return am62p_map;
>>> +}
>>> +
>>>    /*
>>>     * This uninitialized global variable would normal end up in the .bss section,
>>>     * but the .bss is cleared between writing and reading this variable, so move
>>> @@ -74,62 +93,6 @@ static void ctrl_mmr_unlock(void)
>>>    	mmr_unlock(PADCFG_MMR1_BASE, 1);
>>>    }
>>>    
>>> -#if CONFIG_IS_ENABLED(OF_CONTROL)
>>> -static int get_a53_cpu_clock_index(ofnode node)
>>> -{
>>> -	int count, i;
>>> -	struct ofnode_phandle_args *args;
>>> -	ofnode clknode;
>>> -
>>> -	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
>>> -	if (!ofnode_valid(clknode))
>>> -		return -1;
>>> -
>>> -	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
>>> -
>>> -	for (i  = 0; i < count; i++) {
>>> -		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
>>> -						    "#clock-cells", 0, i, args)) {
>>> -			if (ofnode_equal(clknode, args->node) &&
>>> -			    args->args[0] == AM62PX_DEV_A53SS0_CORE_0_DEV_ID)
>>> -				return i;
>>> -		}
>>> -	}
>>> -
>>> -	return -1;
>>> -}
>>> -
>>> -static void fixup_a53_cpu_freq_by_speed_grade(void)
>>> -{
>>> -	int index, size;
>>> -	u32 *rates;
>>> -	ofnode node;
>>> -
>>> -	node =  ofnode_path("/a53@0");
>>> -	if (!ofnode_valid(node))
>>> -		return;
>>> -
>>> -	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
>>> -			      "assigned-clock-rates", &size);
>>> -
>>> -	index = get_a53_cpu_clock_index(node);
>>> -
>>> -	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
>>> -		printf("Wrong A53 assigned-clocks configuration\n");
>>> -		return;
>>> -	}
>>> -
>>> -	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
>>> -
>>> -	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
>>> -	       k3_get_a53_max_frequency(), k3_get_speed_grade());
>>> -}
>>> -#else
>>> -static void fixup_a53_cpu_freq_by_speed_grade(void)
>>> -{
>>> -}
>>> -#endif
>>
>> The original function here was implemented behind #if
>> CONFIG_IS_ENABLED(OF_CONTROL). (With an empty function in the else case)
>>
>> While the new common implementation does not have such the config check.
>> Is this intentional?
>>
>>
> 
> Yes, this was intentional since there are currently no K3 platforms
> without OF_CONTROL as per qconfig:
> 
> 	$ tools/qconfig.py -f  CONFIG_ARCH_K3 '~CONFIG_SPL_OF_CONTROL'
> 	0 matches

Alright, makes sense.
Reviewed-by: Aniket Limaye <a-limaye@ti.com>

> 
> Regards,
> Anshul

