Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B80CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28027838CE;
	Thu, 30 Oct 2025 14:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HVkkPJqd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6310A83893; Thu, 30 Oct 2025 14:04:03 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45CCF838DD
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwGJsNgqcht17DU+EJC71Po3f+4c5l3eki3i5UCk8dUQA6Q/q9zRJ1SfagoSpNhfnRL9pbIyt5Dr5M2+A1Cyotb3pq3BDojd9Mx1rK3U8DqGz/g7FEMWDp02qOKz+rtzdbRqDho7dQadRikc7h3zsYIHNRYpGqFM+iEy65rMLUumTAGTr+xebugt3OkT5M96bDbzNsSlZAc7zlUtOPl+G7CDQ6IPotqpz4ceygHL+j1wqLYi+3tV+DzGJdIlyBgeCrvZRUFRQHEvFSQptnSiX0Qyshvt+DTo06WxckPjDMBNbCBl4bhLbbtFigMhF0nADxvnrOemy8GoPhWhVPtXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWoZ6sm/pp6eRlD2rq/zFkVKvNVQqNYOfIGGxmwWMhM=;
 b=URNInuQBrdDb7qpxpcxbGJ467VjAxji3O0qDYgOa6SfOEzdB5ZQ345eSzs5NvXVoYJACJGp4sHT2eDIUoMX9AqUtZPBCNEPIRsk6+LpANuse0hzcBmnJw3eiiz635Pl0jEEVNnldkmZCTttKXMPPor5x8Wkhp4xT33r5xeG0+DMtrWPAsFqg5nol4xHGwF+a8cULBibkGXvQ51pc1h5TquC/cgillbjeSHEhFlCONDFNf07Ud/LOLsRYZffspIY49b2vS9QKnJc+vvhuTsjZQPeQPiuzK3bsJUs6LyCECq4M8TBxbKgo8Ek6k3oAEYaehkkJHkjM1yDj+SlwljNMOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWoZ6sm/pp6eRlD2rq/zFkVKvNVQqNYOfIGGxmwWMhM=;
 b=HVkkPJqdQB7i1Mfxd95phOBM0HZ1aCYCajehkcQ7ozi7KcyBL7pQ0ckHVPxnwB4gmdOzFmYYyznRsdonLxOnwI/VXX8VpZeFxchXv4Oko63e1pG97sTLqn5iylyNuwP1YJp1Fq7KTDt1v/2QBC1C/Dt6/CkHJlJm9WB1X4iZHGM=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by CH3PR10MB6857.namprd10.prod.outlook.com (2603:10b6:610:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 13:03:55 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::54) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:03:53 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:42 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:03:42 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UD3fMG2198449;
 Thu, 30 Oct 2025 08:03:41 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 30 Oct 2025 18:33:21 +0530
Subject: [PATCH 2/3] mach-k3: refactor A53 speed grade clock-rate fixup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251030-ti_speed_grade_fix-v1-2-703e4189640a@ti.com>
References: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
In-Reply-To: <20251030-ti_speed_grade_fix-v1-0-703e4189640a@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Aparna Patra <a-patra@ti.com>, "Bryan
 Brattlof" <bb@ti.com>, Udit Kumar <u-kumar1@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Judith Mendez <jm@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Andrew Davis <afd@ti.com>, Aniket Limaye <a-limaye@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761829417; l=14534;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=hhOw4WdV19oTlelrEeRFx7sCB3vRhuBPgpnzDV5XYvk=;
 b=nZx+VDDEYh37ieu0frOgn2cyG1TuVIrRYiE44KgifVVlzOdOoMt4MoHr5zIDKxFrSwvEeWwV9
 Q2hugN7kI9ECGxYLOMm6FFpodBJ5PMwFNVbMbgFHjuRsNofeHRQiRK4
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR10MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e96b0f-8ee9-4fb7-f92c-08de17b4c6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|34020700016|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmZwdUJKVTNZQVRmU2tSb3ByQllnVXkzMGorSks5aFo5RmRYdnpDK3BHZEov?=
 =?utf-8?B?RDRLUWtFSUZISWlyUjhyZnJxblB4SWpUNVdqR1V5YnpWcHQzSmVuV2t5MjFW?=
 =?utf-8?B?aC9hR21TbVRYZmFhVzloQVJZZlRKemJHbVdHMzEzKzVHandocDJPS2k4REVa?=
 =?utf-8?B?UlBkSEF6dWxLUy9UaW00TDZuTzBMTXp4dWNENFA1a2cvMC80QjRiQVZSTlRK?=
 =?utf-8?B?NU1zNVBvYytWNU13Vk5uQ3ZwNWJBNEtIVjc5RExkU081bTJrZlpjd0NyNjRY?=
 =?utf-8?B?TmdPK1loMkVNQmkrUFdOSk9DRDM2OElMeDdiOEhuWGN5T04xQTlpbnlnVTRl?=
 =?utf-8?B?SVV2YUpseDN6NzM4UDczQlpzbnR0VXB4empvTHgyK0w3V3JBaGdLQ0hLbWg2?=
 =?utf-8?B?ZUhUc3I2NU9EVzZUSzJZclRyTmtmY2JHc29IcmJOam1uU2g0aGt6ZUM2WVZ3?=
 =?utf-8?B?VnNaOXJseDQ5ZzBZNzlDN2YzbzZ0YzhCcjB6WCtiOXVldXBKUHBnb1hXN3h6?=
 =?utf-8?B?cjJUMlNiNDBia2hyQjlGM0cvYzRjay82TVBubkx6MVhtR2E4cE1rK2JxYXkv?=
 =?utf-8?B?Tk5aa0FrRlNUSC9hWUd2dzc0M0lkemVhRG1QclRRWnBCSUIwU1FQekV5TS9S?=
 =?utf-8?B?K2prQlUzWG5YNVk1b1o0VnpFOEV0Q1paaVRjL21CaWlxK3VnQUo4VVBrazRq?=
 =?utf-8?B?c2NHclRITXlXWU50dTNoc0U2VlFkM054ZVYrQ0VvQUY2VzUrRDB0UFVOcyts?=
 =?utf-8?B?VmsraG5rdDFwVVlzR1FGNGp6VzdpeGp5SWR4dC9HRDN1dmp0bE5Fbk9EUkV1?=
 =?utf-8?B?bWp6dnM1b3F1bWFmWS9BbnI3aS9sUkZreDVSWmR6UGovOHNMelNCU0RhSmlo?=
 =?utf-8?B?YXVJMkg4MXIweHJzREFjaStLU20ycElpcHN3Y0RBcytNRGtMMWFaWlVid2VE?=
 =?utf-8?B?aEVkVkkvNklEL0NMTG9BZndHbkY5QUM4cktvVmU5a1ZlK3RUeEMzMUZRQXZp?=
 =?utf-8?B?OFZaMzNBRlp1alJVK2FBMkJPbGYrT0Vhb0I4WmNmWksrL2JyQkJXYkUxcDRq?=
 =?utf-8?B?V3BvWkNRcWd6b1hDc0xUeTNuL2Y0TFdjRUo3MDRkSVJ4RTNIeFhSbDhMUHpq?=
 =?utf-8?B?QkF2U0l5Y0tuRi9FVlpHTEo2ZFBpcEt3bkdTdXVKcDdsVTdkVjdtWS9RMFFS?=
 =?utf-8?B?RGxuT2lxb1V5a3c2VTZGSVhwbmMra2t1TGJwak4xTERENEhTRFpqOENzZ2o4?=
 =?utf-8?B?V3luZ0xYZzBXTEUxNDBhOEdQajQzS0RJVXU3ek1RS2t3UmM3NzNFYjB0Slh2?=
 =?utf-8?B?MHlzQ2FIbUlPMUxBeTRVNzczT2R5b0ozOUdTN085YkRBR2ZYZDVWUTFkMC95?=
 =?utf-8?B?R2wyTElhTGx5QjV6WDVwTXp3K0F2TDN0VDV4a09nSkpwY3ZlMjdMVFhMekRH?=
 =?utf-8?B?cmRhdXFVeVhiNGtpaVptWlhLOWJGQ09ZaUd1UVZBcG0vNHBWSUlIVjBsdGlY?=
 =?utf-8?B?YTlYK3dEcW9BdmJBNXlkWVRPTDZ2ODFPR3h5N09PcmFzbHRFbGxIMEsyU2dH?=
 =?utf-8?B?N2F2V0FIUm1Wd3EyYWhnREh2OTZLQUxUcmc0eGV4eStHaHlENjhKZ3BSMGlx?=
 =?utf-8?B?Q2dpTWdocWFHejNtOHFXMjNyTlJJcy8xVk5nem1YWXlmYmlpM1NHTVltZk9J?=
 =?utf-8?B?RUIvbWhHRHNPb1NNbE1wRXJmVzBFT2p5ZGFmSW4xekhZRGM5NGlhR04zVXRE?=
 =?utf-8?B?UEtRcWhtUHo0RHFiT0YxaEZqb0RETFVQdzlPbVZlRFRhSTFHczJpbXZhdWRW?=
 =?utf-8?B?UlFqUHZ4eldHTnFaM0FSeVc1STZKQjNWdGpySW50TkRYM3J1b01NOHZKMFha?=
 =?utf-8?B?SnY1OWRJaENlVzRydElNSGx5MEUwSS9hTWR1dDZyU1hIME9aK2kwaEZxWTA5?=
 =?utf-8?B?Y2plUGVVcU52Y3dtTnJqRmR0b2NONE9VZzR6TWRqZzJMdlBFZVBCRGdrWm9U?=
 =?utf-8?B?Rkc1OVhiWkVnelpsRjRhMytOcTdzWlpWbEFrQ2ppeFl0d2F1aUFMdmMvYXM1?=
 =?utf-8?B?Nk1zVkpKbTErNTg5d3AramVKZEpQOHJYYXZEdklrTHJrS1d3MjQ4QnVZY0hn?=
 =?utf-8?Q?Pcbg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(34020700016)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:03:53.0337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e96b0f-8ee9-4fb7-f92c-08de17b4c6dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6857
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

The K3 ARM64 rproc driver uses the "assigned-clock-rates" value in the
respective "/a53@0" node to properly configure the clocks for the A53
core.

Although the clock value in the DT node might need to be fixed based on
SoC's speed grade at runtime. Certain SoCs such as AM62p and AM62x
already had this implemented, this patch moves the common code to
common.c to avoid duplication and simplify speed grade handling.

The logic to detect the correct entry in the "assigned-clock-rates"
property has also changed. Where we earlier relied on per SoC specific
device and clock IDs for the A53 core, we now use the "clock-names"
property which is device agnostic.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c          |  87 ++++++--------------
 arch/arm/mach-k3/am62x/am625_init.c            |  84 ++++++-------------
 arch/arm/mach-k3/common.c                      | 108 +++++++++++++++++++++++++
 arch/arm/mach-k3/common.h                      |  11 ++-
 arch/arm/mach-k3/include/mach/am62_hardware.h  |  24 ------
 arch/arm/mach-k3/include/mach/am62p_hardware.h |  17 ----
 6 files changed, 165 insertions(+), 166 deletions(-)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index aebd5200b0db9959805d04408b34d283e21b6e2c..eeb054d575ad94040370817f648c5319850fe7f8 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -11,14 +11,10 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
-#include <dm/ofnode.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
 
-/* TISCI DEV ID for A53 Clock */
-#define AM62PX_DEV_A53SS0_CORE_0_DEV_ID 135
-
 #define CTRLMMR_MCU_RST_CTRL             0x04518170
 #define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK 0xFFFDFFFF
 
@@ -26,6 +22,29 @@ struct fwl_data cbass_main_fwls[] = {
 	{ "FSS_DAT_REG3", 7, 8 },
 };
 
+const struct k3_speed_grade_map am62p_map[] = {
+	{'O', 1000000000},
+	{'S', 1250000000},
+	{'T', 1250000000},
+	{'U', 1250000000},
+	{'V', 1250000000},
+	{/* List Terminator */ },
+};
+
+char k3_get_speed_grade(void)
+{
+	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
+			  JTAG_DEV_SPEED_SHIFT;
+
+	return ('A' - 1) + efuse_speed;
+}
+
+const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
+{
+	return am62p_map;
+}
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -74,62 +93,6 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-static int get_a53_cpu_clock_index(ofnode node)
-{
-	int count, i;
-	struct ofnode_phandle_args *args;
-	ofnode clknode;
-
-	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
-	if (!ofnode_valid(clknode))
-		return -1;
-
-	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
-
-	for (i  = 0; i < count; i++) {
-		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
-						    "#clock-cells", 0, i, args)) {
-			if (ofnode_equal(clknode, args->node) &&
-			    args->args[0] == AM62PX_DEV_A53SS0_CORE_0_DEV_ID)
-				return i;
-		}
-	}
-
-	return -1;
-}
-
-static void fixup_a53_cpu_freq_by_speed_grade(void)
-{
-	int index, size;
-	u32 *rates;
-	ofnode node;
-
-	node =  ofnode_path("/a53@0");
-	if (!ofnode_valid(node))
-		return;
-
-	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
-			      "assigned-clock-rates", &size);
-
-	index = get_a53_cpu_clock_index(node);
-
-	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
-		printf("Wrong A53 assigned-clocks configuration\n");
-		return;
-	}
-
-	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
-
-	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
-	       k3_get_a53_max_frequency(), k3_get_speed_grade());
-}
-#else
-static void fixup_a53_cpu_freq_by_speed_grade(void)
-{
-}
-#endif
-
 static __maybe_unused void enable_mcu_esm_reset(void)
 {
 	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
@@ -251,9 +214,7 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
-	debug("am62px_init: %s done\n", __func__);
-
-	fixup_a53_cpu_freq_by_speed_grade();
+	k3_fix_rproc_clock("/a53@0");
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 14f93ac998f7d11997b753550c0ea38926e35e64..9f7f2d8c084654b1b55a23a6fa889161cd1c8cb2 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -12,7 +12,6 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
-#include <dm/ofnode.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -26,15 +25,34 @@
 #define K3RTC_KICK0_UNLOCK_VALUE	0x83e70b13
 #define K3RTC_KICK1_UNLOCK_VALUE	0x95a4f1e0
 
-/* TISCI DEV ID for A53 Clock */
-#define AM62X_DEV_A53SS0_CORE_0_DEV_ID 135
-
 struct fwl_data rom_fwls[] = {
 	{ "SOC_DEVGRP_MAIN", 641, 1 },
 	{ "SOC_DEVGRP_MAIN", 642, 1 },
 	{ "SOC_DEVGRP_MAIN", 642, 2 },
 };
 
+const struct k3_speed_grade_map am62x_map[] = {
+	{'G', 300000000},
+	{'K', 800000000},
+	{'S', 1000000000},
+	{'T', 1250000000},
+	{/* List Terminator */ },
+};
+
+char k3_get_speed_grade(void)
+{
+	u32 efuse_val = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 efuse_speed = (efuse_val & JTAG_DEV_SPEED_MASK) >>
+			  JTAG_DEV_SPEED_SHIFT;
+
+	return ('A' - 1) + efuse_speed;
+}
+
+const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
+{
+	return am62x_map;
+}
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -123,62 +141,6 @@ static __maybe_unused void rtc_erratumi2327_init(void)
 	writel(K3RTC_KICK1_UNLOCK_VALUE, REG_K3RTC_KICK1);
 }
 
-#if CONFIG_IS_ENABLED(OF_CONTROL)
-static int get_a53_cpu_clock_index(ofnode node)
-{
-	int count, i;
-	struct ofnode_phandle_args *args;
-	ofnode clknode;
-
-	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
-	if (!ofnode_valid(clknode))
-		return -1;
-
-	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
-
-	for (i  = 0; i < count; i++) {
-		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
-						    "#clock-cells", 0, i, args)) {
-			if (ofnode_equal(clknode, args->node) &&
-			    args->args[0] == AM62X_DEV_A53SS0_CORE_0_DEV_ID)
-				return i;
-		}
-	}
-
-	return -1;
-}
-
-static void fixup_a53_cpu_freq_by_speed_grade(void)
-{
-	int index, size;
-	u32 *rates;
-	ofnode node;
-
-	node =  ofnode_path("/a53@0");
-	if (!ofnode_valid(node))
-		return;
-
-	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
-			      "assigned-clock-rates", &size);
-
-	index = get_a53_cpu_clock_index(node);
-
-	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
-		printf("Wrong A53 assigned-clocks configuration\n");
-		return;
-	}
-
-	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
-
-	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
-	       k3_get_a53_max_frequency(), k3_get_speed_grade());
-}
-#else
-static void fixup_a53_cpu_freq_by_speed_grade(void)
-{
-}
-#endif
-
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -294,7 +256,7 @@ void board_init_f(ulong dummy)
 	}
 	spl_enable_cache();
 
-	fixup_a53_cpu_freq_by_speed_grade();
+	k3_fix_rproc_clock("/a53@0");
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 7c06764af8256b7fd27f8e7f208a597b1b91652b..3a97b70259e965c6ab400d5fbebd8b46f0a55173 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -304,6 +304,114 @@ void enable_caches(void)
 }
 #endif
 
+__weak char k3_get_speed_grade(void)
+{
+	return K3_SPEED_GRADE_UNKNOWN;
+}
+
+__weak const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
+{
+	return NULL;
+}
+
+static int k3_fdt_set_assigned_clk_rate(const char *path, const char *clk_name,
+					unsigned int new_clk_rate)
+{
+	int size, clk_name_index, phandle_count;
+	struct ofnode_phandle_args phandle_args;
+	unsigned int dev_id, clock_id, i;
+	ofnode node = ofnode_path(path);
+	u32 *clk_rates;
+	int ret;
+
+	debug("%s: Setting clock '%s' frequency of '%s' to %u\n", __func__,
+	      path, clk_name, new_clk_rate);
+
+	clk_name_index =
+		ofnode_stringlist_search(node, "clock-names", clk_name);
+	if (clk_name_index < 0)
+		return clk_name_index;
+
+	ret = ofnode_parse_phandle_with_args(node, "clocks", "#clock-cells", 0,
+					     clk_name_index, &phandle_args);
+
+	if (ret || phandle_args.args_count != 2)
+		return -EINVAL;
+
+	dev_id = phandle_args.args[0];
+	clock_id = phandle_args.args[1];
+
+	debug("%s: Found dev_id: %u, clock_id: %u\n", __func__, dev_id,
+	      clock_id);
+
+	phandle_count = ofnode_count_phandle_with_args(node, "assigned-clocks",
+						       "#clock-cells", 0);
+
+	for (i = 0; i < phandle_count; i++) {
+		ret = ofnode_parse_phandle_with_args(node, "assigned-clocks",
+						     "#clock-cells", 0, i,
+						     &phandle_args);
+
+		if (ret || phandle_args.args_count != 2)
+			continue;
+
+		if (phandle_args.args[0] == dev_id &&
+		    phandle_args.args[1] == clock_id) {
+			clk_rates = (u32 *)ofnode_read_prop(node,
+				"assigned-clock-rates", &size);
+
+			if (i >= (size / sizeof(u32)))
+				return -EOVERFLOW;
+
+			clk_rates[i] = cpu_to_fdt32(new_clk_rate);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static u32 k3_get_a_core_frequency(char speed_grade)
+{
+	const struct k3_speed_grade_map *map = k3_get_speed_grade_map();
+	unsigned int i;
+
+	if (!map)
+		return 0;
+
+	for (i = 0; map[i].speed_grade != 0; i++) {
+		if (map[i].speed_grade == speed_grade)
+			return map[i].a_core_frequency;
+	}
+
+	return 0;
+}
+
+void k3_fix_rproc_clock(const char *path)
+{
+	u32 a_core_frequency;
+	char speed_grade;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ARM64))
+		return;
+
+	speed_grade = k3_get_speed_grade();
+	a_core_frequency = k3_get_a_core_frequency(speed_grade);
+
+	if (!a_core_frequency) {
+		printf("%s: Failed to get speed grade frequency\n", __func__);
+		return;
+	}
+
+	ret = k3_fdt_set_assigned_clk_rate(path, "core", a_core_frequency);
+	if (ret)
+		printf("Failed to set clock rates for '%s': %d\n", path, ret);
+	else
+		printf("Set clock rates for '%s', CPU: %dMHz at Speed Grade '%c'\n",
+		       path, a_core_frequency / 1000000, speed_grade);
+}
+
 void spl_enable_cache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 52d3faaab5c94578cf4f7e288cbf840500d490a1..6452188bd1949da83be20dcff6e59a282c3ff51e 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -13,7 +13,8 @@
 /* keep ram_top in the 32-bit address space */
 #define CFG_MAX_MEM_MAPPED		0x100000000
 
-#define K3_FIREWALL_BACKGROUND_BIT (8)
+#define K3_FIREWALL_BACKGROUND_BIT	(8)
+#define K3_SPEED_GRADE_UNKNOWN		'\0'
 
 struct fwl_data {
 	const char *name;
@@ -21,6 +22,11 @@ struct fwl_data {
 	u16 regions;
 };
 
+struct k3_speed_grade_map {
+	char speed_grade;
+	u32 a_core_frequency;
+};
+
 enum k3_firewall_region_type {
 	K3_FIREWALL_REGION_FOREGROUND,
 	K3_FIREWALL_REGION_BACKGROUND
@@ -44,6 +50,9 @@ int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
 void k3_dm_print_ver(void);
 void spl_enable_cache(void);
+char k3_get_speed_grade(void);
+const struct k3_speed_grade_map *k3_get_speed_grade_map(void);
+void k3_fix_rproc_clock(const char *path);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
 enum k3_device_type get_device_type(void);
diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
index 2f5655bf24ac64cb807e282650712c36ebca0f36..9b8fd6276f112375828acd0e2c3d14fd38dc6940 100644
--- a/arch/arm/mach-k3/include/mach/am62_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
@@ -113,15 +113,6 @@ static inline int k3_get_core_nr(void)
 	return (full_devid & JTAG_DEV_CORE_NR_MASK) >> JTAG_DEV_CORE_NR_SHIFT;
 }
 
-static inline char k3_get_speed_grade(void)
-{
-	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-	u32 speed_grade = (full_devid & JTAG_DEV_SPEED_MASK) >>
-			   JTAG_DEV_SPEED_SHIFT;
-
-	return 'A' - 1 + speed_grade;
-}
-
 static inline int k3_get_temp_grade(void)
 {
 	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
@@ -142,21 +133,6 @@ static inline int k3_get_max_temp(void)
 	}
 }
 
-static inline int k3_get_a53_max_frequency(void)
-{
-	switch (k3_get_speed_grade()) {
-	case 'K':
-		return 800000000;
-	case 'S':
-		return 1000000000;
-	case 'T':
-		return 1250000000;
-	case 'G':
-	default:
-		return 300000000;
-	}
-}
-
 static inline int k3_has_pru(void)
 {
 	u32 full_devid = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
index a310b52b45dc5cb76c215c598deee287a2e8e3c6..3c8fbb6b4211153b34fd156ca87b484c5ac9322e 100644
--- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -120,23 +120,6 @@ static inline int k3_get_max_temp(void)
 		return JTAG_DEV_TEMP_EXTENDED_VALUE;
 }
 
-static inline char k3_get_speed_grade(void)
-{
-	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
-	u32 speed_grade = (dev_id & JTAG_DEV_SPEED_MASK) >>
-			   JTAG_DEV_SPEED_SHIFT;
-
-	return 'A' - 1 + speed_grade;
-}
-
-static inline int k3_get_a53_max_frequency(void)
-{
-	if (k3_get_speed_grade() == 'O')
-		return 1000000000;
-	else
-		return 1250000000;
-}
-
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};

-- 
2.51.0

