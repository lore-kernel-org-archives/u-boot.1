Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A612CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D641D83885;
	Thu, 30 Oct 2025 14:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G/NNqs1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F406B838BB; Thu, 30 Oct 2025 14:03:58 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E314583710
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=voZNMPJS6gsP+3Ur6i4hSqv7QagATyzhZF68EuQzrkSRQ69MKmJwGEBVT0Ss8pG2GfgmleSLLM0BBK942B4SnaZW3a5S8KRXj3F2C1IyLbBUr9HcXXIE5HEv5MIBgzNYJ3P6zmNcu/VkwGS+BRgrWjMA8Ol1uh7oPl4bMQy3T1A5U3fYH7D+Sycv74FfaV7vzY3H3OTotGV039fpEyKyLMx6kjTCSX2mWcof1lUuGhHjliRRVPIR8Zw/2X4wYb7DTFnAnmQOLmKxW4MJOIhe9J+h3UWy6DHmWm/plVEr+tZlcPg56NlsSNQnWZkuVJZkUwWmzP925MgzQ2y5eM5eJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJixyNkvttCGucdlkh8aW8NEtQj7HlBvTAuzrOEeX3o=;
 b=F8/GUynrfuSdnrgnREDp7Lwr/+p6kp8zjYYTCBgPBpACbYgEGeA3S6lCg1bbsG6ryqeZp5YXWEHanF8FfbA7VFe9TT5zOZidn9frZEjlIouMO2uJZs7vm0H/3dySY/i39LH2ce9Lf6Zs9jnoIpHOjonJ5dsPRDAEpoCg4K1+48vr8WcMhSX0f9bGAWQvmHBeA95/x0RrVvh/aa7h/jL0yG8okgGMxKH3gQyFKuYlPYo9JuAki1gRUaL1pU2qTka1df0eGXYyLUVkNZ/lkuCXoZY5HjtqYf9VWMWZHww35kUCVIJnCn4jmGA+rKs1J1Pb1Bub1p6jGeva1U8l6R5P+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJixyNkvttCGucdlkh8aW8NEtQj7HlBvTAuzrOEeX3o=;
 b=G/NNqs1M9tOrxaXLwt2bU2k5EgVBnD2FJFZSaAaHdQuO+N4oW0dAvgBMLSOU5jP2QS3RynnTzS9pOuVMimFOAHREr7cHuBckQfvzv8+iI4fy959SnGJ+auvl5LccD2TnFxatmnQrMcKDDlzrZWjCamOVhPG/oLK6wwDxi2okEgw=
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 13:03:51 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::eb) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:03:49 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:40 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:03:40 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UD3dQx2229473;
 Thu, 30 Oct 2025 08:03:39 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 30 Oct 2025 18:33:20 +0530
Subject: [PATCH 1/3] mach-k3: am62px: remove fdt_fixup_cpu_freq_nodes_am62p
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251030-ti_speed_grade_fix-v1-1-703e4189640a@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761829417; l=1809;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ZPGqVsZL5tsObtVKanGAs5SO091mdQ/ap0W6o8qIqoQ=;
 b=x+q72Z1smMvV9GgkLbsg13GWWWuEVy7sb2hgTkyXBkI7eJz7rbaQ38uhIyfiR9tzipvKIXkNM
 CjrkcvI9dItCXAoufgHqU/IA/vmuYy86MdYbHpo79v2is9UFhFt2s4C
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fc32e8-684e-4855-36ee-08de17b4c4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFRGMTBFNW14Ykd3Z1dKQ2hpTHJJZFphUjVteWJFeHFlWlZSQjVCcE05eGpZ?=
 =?utf-8?B?THJsUXM2MWdPM1NKSTVRSDdOUGNZMmp0R3U3UG9FMEJJMHdubXRwZnl0OUhk?=
 =?utf-8?B?bXBkd2tnSlJyTzNvaWJ1YzlPdnBhNGJBa2dXVllwazBoeWNvelNvRUdid2lC?=
 =?utf-8?B?a1ZmWEl1TTRkS3JkRDZGaFZGU0JaMGprcVA5ZDdMOUVtcjdwUzFvaTM1M1Nu?=
 =?utf-8?B?VnRhajdNWEhBT290VDQ4YjhPRGY0WUI1ZUNwbzc2SDB6RnVjM0lyUHhUTU5E?=
 =?utf-8?B?aENVaXJIL3R1MGhoeHdRcTErWG5MbmN1QUxxRXZScS9LZSttNXFhd1ZLZnpO?=
 =?utf-8?B?RzNlZzRXQ3lmYUh1eENheWY1bktzcE5Vb1JHekxpWHE4TVRmWmFJZkZWaERW?=
 =?utf-8?B?LzVGMUtzblVNTEVtQkNnSk1zNXp5MjgwYlFNelNEQldEWjVrMEh6NlVEeHJX?=
 =?utf-8?B?WDdmdHQ4SGsyZStIQ2ZYbmxvdTlMZTFVazFmRHB1ZlRISUw3ckRuZmVZOC9L?=
 =?utf-8?B?c0hCZU0xdTBoUi9vVkxtM0NMOGUxV3NNbE1ta25naVVXdzgzcTNvSUJQWUFP?=
 =?utf-8?B?eFlwN24yT2d6dXNTQ21PdGo2K1BKZURXNmhMdEtQczBEenZEcXdTSWh2dXo3?=
 =?utf-8?B?d3pYVU8vU3NISjRTcEpYYUVUVHh4S3J6SFNaVU90R3lkck8vb21nOENmWFdy?=
 =?utf-8?B?cENFd3VCYzdiYzYweEEzaVJDMEg3VzREOEFuZXJNaGxpZUFYQkZ3eEZJRWNo?=
 =?utf-8?B?OUIxL2dISkZXUVYwNXFWSjZWcjZzL2N0a2pJN2lkLzIxd2pmS1RmZVpIS21z?=
 =?utf-8?B?L0ltTHIrL3BxWVFvTTlJTWNUSkFzUDk4aFZHQitMRVp3L2RQdVNBVThTNU5j?=
 =?utf-8?B?ZEQ3YkhrcFc1WTBqdUdMOGxYSVhta2VHdWkrVnM2SmJPTDJnRTA1dHJMd2VH?=
 =?utf-8?B?eXlpZklUdlFlY0Z4YVVKbUt2VCtpeGJQWURBNGVQdWZscTEwZkw3a0puV25K?=
 =?utf-8?B?eVdLWWE3b1dIeUVWOSs4S3VzQVp6Y0RHdlZSdGt2eFFUbVR6R3hIQVV1eEN1?=
 =?utf-8?B?RU5FTDZNWlh0bmRzcDVOZDRTVlU3NUErUTh1RTJGcUVESmxwenpSVVJLdnds?=
 =?utf-8?B?Y3JETXJjaEUrMGFkU05IZ0Jpbk9xUzEyc0Q4cGhteVpud2szOXl5bFVVZUps?=
 =?utf-8?B?ZXFUWWxaZmk1cUhZRFFMcVZwZlRxQ2F1Y08wRHVjSzNMS1lWRHJMaWlWWjhD?=
 =?utf-8?B?QTV6Y1l3Qmd3eHZ0T3pralJZNS9FUGZjU2oveDdTMzJ4VXk3dEdNWmI0bGRV?=
 =?utf-8?B?c1BaaFRPdUovNVB2aFY5Q3NGRVdkdWhUcEdIME9Vakw0b3FReSs5Qit5MjRP?=
 =?utf-8?B?VGx0ejFxK01TbTJkenBxbkd0UjNmOUM0czdsdEowR0t2NU5vQ1pldXk2U1lF?=
 =?utf-8?B?NDF4cEFWSTc5Vng0SXZiVmJzN01Rdk9xMVVOMnhNZThjRGxZZXVVeTBoQk9i?=
 =?utf-8?B?UzYvanQ4NjYvbXV0V1Exc3ZuUEpvcDRmdlJ0WEtGVjBxcThVSjU5TVFqS1NC?=
 =?utf-8?B?VUkvaTljV0tSSjgyeGNDTGRsL1psa1NEQmkzZVFuZGZBb0w4cU9DRm14Qjdi?=
 =?utf-8?B?dVZ0SDh6aVVTOStJc09nSU0ydm5Gdjc5VEdXOWVjS3BmVXRzUlliRkF2alVo?=
 =?utf-8?B?UGQ0bFVUbjRsNm0reGNsRlFaeEZMMStPeFhLMEJNSUJDVzNva1pDOEhCYjlR?=
 =?utf-8?B?VDZvQUoybzJDaEtMdWJaeGJtMUU3QlYvWGdBYitWV2l0WldzbGZxMEk0eVB0?=
 =?utf-8?B?c3NaRSs4Y3ByYVZqemM5amkrN05scWNKZUlYK0ZqK2RVeTlXRGhHYXNMc1Nt?=
 =?utf-8?B?a1owSFRDUDd5OWh2U2MwZVVnMzgvaDVjT3VRSU5VVHltdUhneUNmVmRTMFFM?=
 =?utf-8?B?VzVldlVjaGhUUVF4bm9SaDJQRnRoY0lxQjMvZFhieUY2SnRTM3A3THNWWkpu?=
 =?utf-8?B?T2VxVWE2VVdSTzBjYXExdGlqSmtLU29ZMktyTnVoS3kzckZ1ckMybGpma2Zq?=
 =?utf-8?B?S2xPZm1Od0pDY1doR2ZUcVc4aExZZy9xOE81K0lKN0J3dzkrbUhmcnZvclQr?=
 =?utf-8?Q?1pwA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:03:49.6429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fc32e8-684e-4855-36ee-08de17b4c4d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
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

fdt_fixup_cpu_freq_nodes_am62p is used to delete unsupported opp table
entries at runtime based on the SoC's speed grade.

However, the ti-cpufreq driver in kernel already has support for
rejecting unsupported entries. Therefore this fdt fixup is not necessary
and can be dropped.

Fixes: 8d05cbef73ae ("arm: mach-k3: am62p: Fixup a53 max cpu frequency by speed-grade")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_fdt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 4a5ff594df66878368777cd7aa79b3adf0a094e1..03f56cfd9fc404a114b444a482706b579cd1878e 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -39,17 +39,6 @@ static void fdt_fixup_canfd_nodes_am62p(void *blob, bool has_canfd)
 	}
 }
 
-static void fdt_fixup_cpu_freq_nodes_am62p(void *blob, int max_freq)
-{
-	if (max_freq >= 1250000000)
-		return;
-
-	if (max_freq <= 1000000000) {
-		fdt_del_node_path(blob, "/opp-table/opp-1250000000");
-		fdt_del_node_path(blob, "/opp-table/opp-1400000000");
-	}
-}
-
 static void fdt_fixup_thermal_cooling_device_cpus_am62p(void *blob, int core_nr)
 {
 	static const char * const thermal_path[] = {
@@ -92,7 +81,6 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
 	fdt_fixup_thermal_cooling_device_cpus_am62p(blob, k3_get_core_nr());
-	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 

-- 
2.51.0

