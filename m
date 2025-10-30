Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F74CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7189383893;
	Thu, 30 Oct 2025 14:04:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pHinbV8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6E5838EC; Thu, 30 Oct 2025 14:04:22 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D11E83710
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 14:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysFMQHd1yIktwErbJ34nrY3Ut+5ZTvqPVMpV0H2mHtM6FWqR1g6ka1GI/GLeb0Tfcgvr9nB+s7FwNCaOqSJI6kQGu6VRS/6FEGHeIC+4DoDqeQKI+2/ujfoFs4iI+3Yfa/Q+XrrtOVaN+LsoTERScyJ+TSt15m0IaRt3UyGFAyh1vLJIqxtwujd/uudXmApysp58ChxmFivtgvCnSaZC9rAIPVpoMRmrPP7zifMN5/4TyRIqZezg0iQAWYJTqj3FJo5/IZqNsMD6gw4yBtVKM0vKWjmIi1t7176mIMjmGXHuBylKVqV68XO/jC5Q5vXY1QD2CnRK1q5TVWhqu/fVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAl8mv7kaxrOqDgFn7TFnGvmY4HdStDyvtU8yIyDvlQ=;
 b=PNHKaQxs6nnGCRpT8YRyE1avZwQqH9hJu5WdXdi8LI9sVOnUsxkH7t/FKObpVRA9/uuF/RdG7coKmJHREAa1juEH1z6EnETCg6ifC+Xm/BYHlaqt5jGetDgcuq0vrOVmYAsxvb1TNklID9FDf7A630tsgxKXOgwvQoFF0E1XGelfyhVVKXLVC/NpO6cCjAm/nmREIrPu393bVmU45Ry4g8ca7Jtf+CcOQjxJtdNNU2y+T1e13UtCkJ1QIquKZD9OCYr21JVu/1HFVOGX/Anu6acm+YD78yjAK9imrRDX51DO++99xPoSRuI+j67QMfNbIetUttls0EUl+OL7TgEN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAl8mv7kaxrOqDgFn7TFnGvmY4HdStDyvtU8yIyDvlQ=;
 b=pHinbV8A/sK42PPV7ehM4N4y21z/Y9+j3zRHzna9NM0A4oy+Sbd9gGcWRWRI/CNBYYUhRSRDZOzHpTAZxKLMVtzO1vc6cxo0nmJIHOOPHXAO2hA8GJJ0zFUnrzXUVfYBhDPuLB9NSYvTQthlss3zGe1P0x9C1g3i+D83xfQ34Fs=
Received: from BL1PR13CA0388.namprd13.prod.outlook.com (2603:10b6:208:2c0::33)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:04:17 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::c6) by BL1PR13CA0388.outlook.office365.com
 (2603:10b6:208:2c0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 13:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 13:04:14 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:58 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 08:03:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Oct 2025 08:03:44 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59UD3gfe2229520;
 Thu, 30 Oct 2025 08:03:43 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 30 Oct 2025 18:33:22 +0530
Subject: [PATCH 3/3] mach-k3: am62a: add support for speed grades
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251030-ti_speed_grade_fix-v1-3-703e4189640a@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761829417; l=2888;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=Vx+zVVc5Q1gLcN50cFdcBThB0pke54BXOlj0WsO3+AM=;
 b=iS1hjHqbtDKlUYCM73vo3jgneblUpb/Scu7lg40DhHtB7LthbUSBDr0mVcEKdcVJjtYS2VX3L
 h0qrGYN1/+WBj5iRmki4TShAtNWTUNPAnSfZFZsAoe9y6hd/YzSNRq9
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ba4b80-f0bf-4c36-2850-08de17b4d3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|34020700016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnhPTTR4bEYyN3lRRDRHNy9Kb1E1dnU5RzhoWE5LZmpXdloyRlpzNkhJU3Z5?=
 =?utf-8?B?Ym9DTG5ycnNLdDdUNGVWNWx1Lys4TTk3d21FZzV0b2E4Uk5jV21DN1p5d2hs?=
 =?utf-8?B?UExEd084MVh4a1dNakgxQVFlZzVvVHVrenQ4MzgvRGV2Vk51QldSTWpxUDk0?=
 =?utf-8?B?WUpuMWRFVkV2ZmU3R0FzUTB4Qi9Gdi9yeEhrRkdCSEM4UGtkSTZCNmFtY1RC?=
 =?utf-8?B?UDVQL0pGUlBlditzMm9tWjRneldVaWR2aDRnaGErSTJ4THZQU2F0bkZ0bnEz?=
 =?utf-8?B?V1lhVnpxK21ucTVoOFBJUllNRjJ1M2ROOU5hQkp5ZTJhVkJ1RVgwTU9ldHdL?=
 =?utf-8?B?R2M4Zy81cnhkY0loUVZGa3g4bkJReWEwNG9vaFZjYnJWeitRaEFsRFlGcnhG?=
 =?utf-8?B?QUpKZitlZklYVUdoWldHcnRnV1JBQVExajlIY21xQ3hmQ1FvT2tBSTRkMXIy?=
 =?utf-8?B?Z2FtV0c1SlRJc0ZrcStaVnpYaHJ5b3lXYU5PTXZxWlJJb0JMOWJ0ZlZrQi9z?=
 =?utf-8?B?MmxBbkdJM1R3MGVNR3FqNk8rVUJpRGtGck5RS2NoV1RicHBTVGYrTDltcEdQ?=
 =?utf-8?B?OUJaMEtMK3RrVG1OZjBVRXdVa2ZEL1F5WDVGTlNsOTU3TGR5YXlEMzRtYlZC?=
 =?utf-8?B?MTBSeXY5VWtRNC9ZNW9Ia0NacWZsenRwbEtZUlJ1UmttanJDYTFiRXJxaDc1?=
 =?utf-8?B?UVJ1V3BQd09lOGxmRjNHUjNpRzdGb2h6WVBHS2VNcG5WNTN4YzkzYmtTR2Mv?=
 =?utf-8?B?TTMrNEFuWkRNS1NTcklxT0VXd2tVUnpXd01JZjhVQXBlU0JXNWQ1UGJBUnZq?=
 =?utf-8?B?ZXgzc0ZuVytHM2E3aTVGV3JUSGJEWmc4cldsSHEwYVlJTDZVbkU4Rm9PL0JM?=
 =?utf-8?B?WDM1U1NIVkgvbWIyWTErQ1lMenE1VEhpWmt1YTdodkt6RHVWaklCdkVNblo5?=
 =?utf-8?B?aS83ZndDVUxBZWNkRzc2aWFyN0NQcXFoQnQ2RUZETzFmZWY1WUlJZ0t0NGtj?=
 =?utf-8?B?RVFSVzE0cXZJSzZGYWd0ZVVUY0dDQ01Qd3VMNjdzbVY5dUs1aXllcWJRTGJt?=
 =?utf-8?B?UXM4d3dsTWRvZnU0QXpnTXF6Z3d0RC84N1lSSUpEckc2VVdsWUNCUEljTVFu?=
 =?utf-8?B?UnBWMmVGUUhndjQzcEVjN2hzclRXQ2NjT1dHUzBveXcwczZZNE1KcVBOSmZB?=
 =?utf-8?B?M25sM3V0R2lPVEdOVWNRUC9ucTcxQkhqQnNZU0h2anNUeUFkcWp5a2JCRkdv?=
 =?utf-8?B?OVV2UE9XckhnMGdiTWtuYW1JWDBuanJuN3JadXVmanRIcVJtVlpaM1lnSTg1?=
 =?utf-8?B?WVhhK1BMby83YWs3c2lHV0MxQmRnMlo5YWdHcGRiMzVVNW5CTTlSWHQ1V3Bn?=
 =?utf-8?B?OXBwS0tOQ3lxZnJyZUVHY3phYmorU05aYzBxYXpHTld0RkJuaVJjeUhXZ0Vr?=
 =?utf-8?B?NmlBSDMwYTlOd2R0Zno2Q0ZydXIrbk1QaEVvSndXWjFpR0M1eVVPQmNTNmEw?=
 =?utf-8?B?SlV5cHNNMWhzTGh4WHIrd3A3ZGJLV1ZLYjBtQVlzVWMzYW9hLy8wNHZ3MEpP?=
 =?utf-8?B?aGdmeUhDaHdhRlA0WTBTOUc1ME9DZWdkUEgxQ3ZxaWdVMXlUb2dlR1FMOTBV?=
 =?utf-8?B?U0lyVGFyRHI3UnJ2R1REbmdUYzB0UE1RMTJ5SmxUYkE2a1pOMGc4c0k0cUlI?=
 =?utf-8?B?L3RXQjd5akl5b0NYclFKelFtTjFLV09nc3YwWWdiWm84ZHoxL3Z4VnF2YTlU?=
 =?utf-8?B?R2xkV1FMSFgxRThzL0lMV0k0U3hrbFkvcWFzOTExU1dqRnd2dGVuNXcvamI4?=
 =?utf-8?B?M3h4aXF5ZlAxYzNhVTE1NSsvKy92cDhvMjRyNzFkWmp4US9OWENWT0VNWEQv?=
 =?utf-8?B?MnRweVpSRkFTa0t3c0hwKzRscElodXd5RWhKUkVWYjE1T2JCakFBNEg3OEQ5?=
 =?utf-8?B?SzhEajdGMW5XSjRwcHQvMmkzZjZUSXh1TkhvTGtWbGhobkpqTWtmSDVUb2lt?=
 =?utf-8?B?NnBSNGhIZFZYMG5EMEtYaTZoeTlEa29NSmtVSTA5R0hGRDNhOHhXTy9NZ0kv?=
 =?utf-8?Q?YBR81r?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(34020700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:04:14.5806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ba4b80-f0bf-4c36-2850-08de17b4d3c0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
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

Speed grades indicate the maximum operating frequency of any core on the
SoC. This patch adds support for the same to AM62a, this allows the A53
core to be started with the correct frequency by the R5 SPL.

Reference:
  Device Speed Grades (Table 6-1) in AM62a7 Datasheet
  https://www.ti.com/lit/ds/symlink/am62a7.pdf (Page#82)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c          | 39 ++++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62a_hardware.h |  4 +++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 48d578e7d6f180f06b42003313bf643c725eae7e..cf81ca62f5b59912034290979a406c0bc02eca46 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -22,6 +22,44 @@ struct fwl_data cbass_main_fwls[] = {
        { "FSS_DAT_REG3", 7, 8 },
 };
 
+const struct k3_speed_grade_map am62a_map[] = {
+	{'M', 800000000},
+	{'N', 800000000},
+	{'O', 1000000000},
+	{'P', 1000000000},
+	{'Q', 1000000000},
+	{'R', 1000000000},
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
+	char speed_grade = ('A' - 1) + efuse_speed;
+
+	/* Speed grades for AM62a are not sequential */
+	switch (efuse_speed) {
+	case 'T':
+		return 'V';
+	case 'V':
+		return 'T';
+	default:
+		return speed_grade;
+	}
+}
+
+const struct k3_speed_grade_map *k3_get_speed_grade_map(void)
+{
+	return am62a_map;
+}
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -207,6 +245,7 @@ void board_init_f(ulong dummy)
 			printf("Failed to probe am65_cpsw_nuss driver\n");
 	}
 
+	k3_fix_rproc_clock("/a53@0");
 	debug("am62a_init: %s done\n", __func__);
 }
 
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index f3fd736f31b8444d84e95099441003c572843226..21bed6e2c6e3480ba5be4560bc0d61ece655d333 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -19,6 +19,10 @@
 #define MCU_CTRL_MMR0_BASE			0x04500000
 #define WKUP_CTRL_MMR0_BASE			0x43000000
 
+#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
+#define JTAG_DEV_SPEED_SHIFT			6
+
 #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_SHIFT	3

-- 
2.51.0

