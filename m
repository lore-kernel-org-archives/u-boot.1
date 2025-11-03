Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1340BCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 05:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C9298331F;
	Mon,  3 Nov 2025 06:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z/MCAsgl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CAC083700; Mon,  3 Nov 2025 06:24:55 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3618B80050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 06:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qhhosppjryz/LxJZRHpXds5+bv+gzyMJmjp9btCHuV13tpqdGMbuJfVCWmXpAXqJCXByboFaLymgIxa4TW2ox36vUqJHVnlQYv35gX8v6f9vxWQd6hO8f7LyeNrdXDyRDLNJ7LTuN3tD7eegFSirckltEAfIlEtLj6uQH6y53bzV/oc2gtzQA2o/2dU1rwPOwBhzlHnViKUklyanmGmWrQVXZi2pKuG2BcywU93We02Z/QgydTwHTZr5Qqr/SlTt2BPJbbULcCX8jxUCycsbyC9lBJ/TCDXPF09vVEPUVC9yiH5kBg165vyLbMhfwUwwYgLhgxpsveRkkS8xtfpQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caL1MLwvt9h7pllVROkroECSSEIqxvfin9zMwxIU7cQ=;
 b=yHtGlfSTqySh+b505ifyQOiR1/SS8RETjAmju3wfn+sX7aw09PabuGvzgUMxKNTD7qCbW+tPrQVQXR+WaOXl6VFhwS/uTECKGWzVrBKuHYKKAuDuaPx6lpGoQfD7Xhavg8K6PiiL2JvpsSXUgkUCl92yhL/rkyoVtqSa+k6TJFz6mxbhMwHMfU3qb2dEP5asRH2P8WQRmTRAIVqxkUPDeWZMwT4GP7IeXx2oSnS3tppWZRTAHw5jgRGGGWjJh66q4GA/Wt3ITJ7xXm2KNVBeK+MifGjbd6W+P3GTc6rG8h+3IDgUyqjBm/yGAtUaWCCYpT/ilbixVza3n1fZ4n1ftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caL1MLwvt9h7pllVROkroECSSEIqxvfin9zMwxIU7cQ=;
 b=Z/MCAsglCan/VWGwf4lJ3QeBSkovKHgvXN6JWDSVk0KoI7DJKIYvR5EoF66FdmZB2Dpixhp0DEHKLzgSDl2VYoBEvK9IkdiFQ242AKMrNFiK3pITlABoE/caYEhTadSFKIBR4KcDlssPl2OmSzTDScj2Gp6JoV0sl7JYV1Nm66o=
Received: from SN6PR16CA0064.namprd16.prod.outlook.com (2603:10b6:805:ca::41)
 by CH3PR10MB7162.namprd10.prod.outlook.com (2603:10b6:610:122::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 05:24:50 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::52) by SN6PR16CA0064.outlook.office365.com
 (2603:10b6:805:ca::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 05:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 05:24:47 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:24:45 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 23:24:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 23:24:45 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A35OiDh3545840;
 Sun, 2 Nov 2025 23:24:44 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 3 Nov 2025 10:54:43 +0530
Message-ID: <DDYT5EH4CX1N.UP6UHCIGTL78@ti.com>
CC: Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Nishanth
 Menon" <nm@ti.com>
Subject: Re: [PATCH 2/3] mach-k3: refactor A53 speed grade clock-rate fixup
From: Anshul Dalal <anshuld@ti.com>
To: Aniket Limaye <a-limaye@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
 <20251030-ti_speed_grade_fix-v1-2-703e4189640a@ti.com>
 <5f1d8353-bb04-4f43-847d-9f66761b574d@ti.com>
In-Reply-To: <5f1d8353-bb04-4f43-847d-9f66761b574d@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH3PR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea06864-cd8d-4f01-8fd8-08de1a994e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmViREo0RmIvUm93L0JrRko4K3kvbGNvQ3BXZFN5bnRWL1JPMnJKemxzbFRW?=
 =?utf-8?B?Q1ptMU1YS2dCbm1uL21jUUY3aFJkRzhIaDlSMjFLRTNXdk1qS01nK2toMklZ?=
 =?utf-8?B?UXZ2NVBrb044WndpYk9FaU82STBlZjZ3VURrbFdIK0hpS2VncWk4clBsSlcv?=
 =?utf-8?B?NThBTWc2b3dMRkxtV1YrQmR2RVU3RHZQcjE3UmNRNUtxMHVLMWxVZnRuVTMx?=
 =?utf-8?B?OS9sa0hoZmRxYStjNGc4ckQ2c1FReDBob1JWUHBDdUlKYVRmVmtiMTF1UTha?=
 =?utf-8?B?MzBJMDUxc0NESXFzOXQ4Q3VzSmM5aWRLcXc5cXFEVEZrbTVkM1RZc0FzcEdN?=
 =?utf-8?B?TWFCUDFLTi9Ia3hCV1VqYzhueW91MUxIN05qTTFTdXkwRSt3T1NMTlVIV2Np?=
 =?utf-8?B?MzhsKzA4OElsNzhGK3d6Q28zTWxyUytOTXVEVG9XaytQM3dqNnE5TXNXSG0z?=
 =?utf-8?B?d3phdDE3ellXOW9qNFFlb3BUcDBNcGJTaGpLOWxzR3BPV2p1ZkFpTURmcHls?=
 =?utf-8?B?SW1oYXRJZGJrRGZESzRvbmtxeENyT0JFcHpsZnBYVTFRN1ZLbm4zS3NiWjBQ?=
 =?utf-8?B?VGtoR0JEai94cktmS3Fhck9WZTJMRGMwTWJ2c0NZYTA4ZU83aDBmazlVcmo3?=
 =?utf-8?B?Q2Nva0NubjRCeG05UlRGdkNnNUI2WTlhc1UvY2RRRHk2K0RVMElrK29GbDNw?=
 =?utf-8?B?L0dSTERkbHpJOEdWbE53MHRLNy82T3BjQm41bndNK3ZCRmxKcDYveFpPVmlE?=
 =?utf-8?B?aXBnb0hMRFFyNjV0SktMUE1vWWltdU11MHZVakI4YysvZWZzNXhWKzlYZFIy?=
 =?utf-8?B?Z1VWQ0hQaXljRVpqbGpVSDlIaVBoT2phdHNYbUpGd29HTE1ORUpGMWRVb0s4?=
 =?utf-8?B?V1JkZy91YXFabXc2RWQ0clpCR003MFJac2V4UEJ4bW50MkVzN00xM3g5WVRX?=
 =?utf-8?B?TDhyaGFuOUN5NkFlU3p2cSsvVUp0TEcwYzcwOTJjOVZmbStnQ0dKWnVlWXNs?=
 =?utf-8?B?TnBjbmpwRU5sb2d3Ny9pZmhKSXJlTGFVVVl1TEVKckxLOSsxWEkxSE1lOGF4?=
 =?utf-8?B?SVExUW9UMVRvbUpYN2V5NXRBZVIzb2F6NXd6WGVkSjd3bjZ3SklHRm1weTQz?=
 =?utf-8?B?anBwcU5iNzhuTmdOSnprT0syYjg0L0RYS1czRUlWOXIxamtxVzV4cDFHS2cv?=
 =?utf-8?B?ZEdMWERQWG44RDlaZ2tiZjJuSCt4NGVDSS8yWG5rYm43Zm9Jd3drbzQxbHpi?=
 =?utf-8?B?QWdGdHpRNVBoRHhFRGY0UW84QTZzc0xIbXFONG9mc01lT1FxamRMd1d6eTFB?=
 =?utf-8?B?RWtZR2ZDUEpJREV1dW92SUcwR3ZFYkk4N1BpbnZBeG1BZEthOUFvYnhkMXNu?=
 =?utf-8?B?QXhzZnB3TVIrcGJOK0J5K2xnSUt4NlVXMzFBT1IwMkxIV2pOcDYwdFJOQVFD?=
 =?utf-8?B?QXIyWWVhZVVCWGNyMi9hZUo3UzBacGFmWTR2UVVrU0piMUpqYVhqbzdSQlBr?=
 =?utf-8?B?bC9kcEFmRW1TMk1LQ1R3UjVESFo5dUNxbmFMaVQwL2lOanR6V21oenJmbm9r?=
 =?utf-8?B?OFZhcXNiL1czZUtYUWxBbmlLMUE2NXRYV3NYcXVONXk4a3hnMStSRUJTRG5I?=
 =?utf-8?B?SUEySElnNnMrV2RaTEd6aHpLcitXTWRKWExwTlZPMkxoT2VxdDJHbHZ3OHVB?=
 =?utf-8?B?Mk10RklDRDAwYURXVTRzY2FEZTFVNTdMUjkwZHVlYmhoMjI1cEkyTDN2UUFC?=
 =?utf-8?B?MkN5aUZWSVFnaXo5dGMwN3Zvai9XaXZ6U1hycERjK1BEMEs0UVJJanM2cm52?=
 =?utf-8?B?VkZxcVhxQjVxNUdDd01TOGtvNGNoZy91Q2M4ZmMvMjJ1VUhCOC8rQlJIcWE1?=
 =?utf-8?B?Y1ZmdUNXSlFOVDRBaU93VHdTU1dYYnNkQ3QwMmJRN21DeVN6SCtFZUJKd0xV?=
 =?utf-8?B?OUhBSE9KK1llSlRXTzRJZnRvQnZhbUdOYmFqWUNwNjN5NEMrRVExVWhjMUN0?=
 =?utf-8?B?MmFiTDFQcWlPYnlzS1hjVHloaWk1S1JRbU92MjR3SFRFZGNpT0lLM1NwblFP?=
 =?utf-8?B?MkM5VTc5OVdYTEpzdXdPNVVWdm1oOWdBOVl0aUZxVlkwWEdWamNwOUc0bXUz?=
 =?utf-8?Q?Jrzs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 05:24:47.9558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea06864-cd8d-4f01-8fd8-08de1a994e57
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7162
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

Hi Aniket,

On Sat Nov 1, 2025 at 9:30 AM IST, Aniket Limaye wrote:
> On 30/10/25 18:33, Anshul Dalal wrote:
>> The K3 ARM64 rproc driver uses the "assigned-clock-rates" value in the
>> respective "/a53@0" node to properly configure the clocks for the A53
>> core.
>>=20
>> Although the clock value in the DT node might need to be fixed based on
>> SoC's speed grade at runtime. Certain SoCs such as AM62p and AM62x
>> already had this implemented, this patch moves the common code to
>> common.c to avoid duplication and simplify speed grade handling.
>>=20
>> The logic to detect the correct entry in the "assigned-clock-rates"
>> property has also changed. Where we earlier relied on per SoC specific
>> device and clock IDs for the A53 core, we now use the "clock-names"
>> property which is device agnostic.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>   arch/arm/mach-k3/am62px/am62p5_init.c          |  87 ++++++-----------=
---
>>   arch/arm/mach-k3/am62x/am625_init.c            |  84 ++++++-----------=
--
>>   arch/arm/mach-k3/common.c                      | 108 +++++++++++++++++=
++++++++
>>   arch/arm/mach-k3/common.h                      |  11 ++-
>>   arch/arm/mach-k3/include/mach/am62_hardware.h  |  24 ------
>>   arch/arm/mach-k3/include/mach/am62p_hardware.h |  17 ----
>>   6 files changed, 165 insertions(+), 166 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am=
62px/am62p5_init.c
>> index aebd5200b0db9959805d04408b34d283e21b6e2c..eeb054d575ad94040370817f=
648c5319850fe7f8 100644
>> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
>> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
>> @@ -11,14 +11,10 @@
>>   #include <dm.h>
>>   #include <dm/uclass-internal.h>
>>   #include <dm/pinctrl.h>
>> -#include <dm/ofnode.h>
>>  =20
>>   #include "../sysfw-loader.h"
>>   #include "../common.h"
>>  =20
>> -/* TISCI DEV ID for A53 Clock */
>> -#define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
>> -
>>   #define CTRLMMR_MCU_RST_CTRL             0x04518170
>>   #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
>>  =20
>> @@ -26,6 +22,29 @@ struct fwl_data cbass_main_fwls[] =3D {
>>   	{ "FSS_DAT_REG3", 7, 8 },
>>   };
>>  =20
>> +const struct k3_speed_grade_map am62p_map[] =3D {
>> +	{'O', 1000000000},
>> +	{'S', 1250000000},
>> +	{'T', 1250000000},
>> +	{'U', 1250000000},
>> +	{'V', 1250000000},
>> +	{/* List Terminator */ },
>> +};
>> +
>> +char k3_get_speed_grade(void)
>> +{
>> +	u32 efuse_val =3D readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
>> +	u32 efuse_speed =3D (efuse_val & JTAG_DEV_SPEED_MASK) >>
>> +			  JTAG_DEV_SPEED_SHIFT;
>> +
>> +	return ('A' - 1) + efuse_speed;
>> +}
>> +
>> +const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
>> +{
>> +	return am62p_map;
>> +}
>> +
>>   /*
>>    * This uninitialized global variable would normal end up in the .bss =
section,
>>    * but the .bss is cleared between writing and reading this variable, =
so move
>> @@ -74,62 +93,6 @@ static void ctrl_mmr_unlock(void)
>>   	mmr_unlock(PADCFG_MMR1_BASE, 1);
>>   }
>>  =20
>> -#if CONFIG_IS_ENABLED(OF_CONTROL)
>> -static int get_a53_cpu_clock_index(ofnode node)
>> -{
>> -	int count, i;
>> -	struct ofnode_phandle_args *args;
>> -	ofnode clknode;
>> -
>> -	clknode =3D ofnode_path("/bus@f0000/system-controller@44043000/clock-c=
ontroller");
>> -	if (!ofnode_valid(clknode))
>> -		return -1;
>> -
>> -	count =3D ofnode_count_phandle_with_args(node,  "assigned-clocks", "#c=
lock-cells", 0);
>> -
>> -	for (i  =3D 0; i < count; i++) {
>> -		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
>> -						    "#clock-cells", 0, i, args)) {
>> -			if (ofnode_equal(clknode, args->node) &&
>> -			    args->args[0] =3D=3D AM62PX_DEV_A53SS0_CORE_0_DEV_ID)
>> -				return i;
>> -		}
>> -	}
>> -
>> -	return -1;
>> -}
>> -
>> -static void fixup_a53_cpu_freq_by_speed_grade(void)
>> -{
>> -	int index, size;
>> -	u32 *rates;
>> -	ofnode node;
>> -
>> -	node =3D  ofnode_path("/a53@0");
>> -	if (!ofnode_valid(node))
>> -		return;
>> -
>> -	rates =3D fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
>> -			      "assigned-clock-rates", &size);
>> -
>> -	index =3D get_a53_cpu_clock_index(node);
>> -
>> -	if (!rates || index < 0 || index >=3D (size / sizeof(u32))) {
>> -		printf("Wrong A53 assigned-clocks configuration\n");
>> -		return;
>> -	}
>> -
>> -	rates[index] =3D cpu_to_fdt32(k3_get_a53_max_frequency());
>> -
>> -	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
>> -	       k3_get_a53_max_frequency(), k3_get_speed_grade());
>> -}
>> -#else
>> -static void fixup_a53_cpu_freq_by_speed_grade(void)
>> -{
>> -}
>> -#endif
>
> The original function here was implemented behind #if=20
> CONFIG_IS_ENABLED(OF_CONTROL). (With an empty function in the else case)
>
> While the new common implementation does not have such the config check.
> Is this intentional?
>
>

Yes, this was intentional since there are currently no K3 platforms
without OF_CONTROL as per qconfig:

	$ tools/qconfig.py -f  CONFIG_ARCH_K3 '~CONFIG_SPL_OF_CONTROL'
	0 matches

Regards,
Anshul
