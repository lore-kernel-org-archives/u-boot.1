Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE73105F7AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65ACC8432F;
	Fri, 13 Mar 2026 14:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TDM6RFCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB2FD84347; Fri, 13 Mar 2026 14:59:40 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDDEE84332
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnh2GPBp2A5f0bNxzhZ6GJ+B0wRbqJO1wjaHho4iAQguzfY/5YgQ3WKYbVlfIXA3ihw9AqcBE8uoixAtaJviVBbF+yHoWTJ9sqH734S/HKy+/t46bHcok7rmeoJ5Dyi6To0ZWcKkZCkRQG3FMzuSMzflJRI/C6/S4HICt9uhEJOi0TyRAumPphvY4wMBog3IAhpSlQdBDrTMTHyNJZKd1e9CBv6NBYOHfMCEIQUGK0Rj4XcTzpG8F3GUb2W59mOZ0b/h2c86VrpYfh1FCfK2T2ujnxPlrD7ZRNnDn2Y7EDSqQloVzWSogWJBS8zj/P+NR2QBi0rRNaDFUcs6tLYZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb3eB00Eu3ZgrnKfXSJ9cZ3kbfPl5anqExlPRaAG4Pw=;
 b=G2Y+hkZotCyJwBKOcYTpAXjp4XfrMMxyvTMQaYJgaY5eO2Ev0/Z0KZDrZRnTOy7lLIjPJvx4+1iFXUcGSBiWAC9gxhGqumS7M8gxCOsHCwB4mGOHQs0hVBmcScEHVE6KRUKTQOf1gTrDrsQhfUnB9XyDKlYVNbOlV9ab4TSqbYLbZOW7zU26xOL+LrlYxOHyL+YS7xPfi5NDmfJXxnAeo1bapFlpnZ6VvhS4HyEjeFwdq27FkEK86vNf6tWriyTr3M8aYbrro2v0KxAlWHOZH27ItVCrb5CRFyI2mZoK2CNH7V4sWTp8kBHr1LSx6hhuLivZcHP3x584/NzLUWl1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb3eB00Eu3ZgrnKfXSJ9cZ3kbfPl5anqExlPRaAG4Pw=;
 b=TDM6RFCrUeyAdsajlmMSCvyV/MFJNmJvd0fHVBcoFK8akrEF+hDZUlP/ggtJuDz/TSWNlSZPsBvooy3gsN/LDktojvPRAGSYPNitGbvysSDtQ95OCASprc1v64tjDoG/A6pASX8cR7VvdMbN+0wdv1aNuSf3z8DZMKeLvJ8hkuE=
Received: from PH7PR17CA0038.namprd17.prod.outlook.com (2603:10b6:510:323::17)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 13:59:34 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::5c) by PH7PR17CA0038.outlook.office365.com
 (2603:10b6:510:323::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 13:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:31 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:30 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:30 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jf638000;
 Fri, 13 Mar 2026 08:59:28 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 09/19] board: ti: j784s4: Add exit retention for k3-ddrss
 (J784s4)
Date: Fri, 13 Mar 2026 19:28:50 +0530
Message-ID: <20260313135900.3430264-10-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 91502c3a-3128-4a0e-920c-08de8108c007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: OJq5Q5SWJMr/zN5kxIhgaXoTfTa0WZtjWvSUR712OyXtkJZk501clL92x2xObTt1CqFL7bd99SuAlbtehgjnMBHggYDE2/LyKYeQkT+mXEdNcC6QZOGies7y8stmV13fJ6AN1BYitZu5CGRcD/6kFyIWVMeo8jZ+u/CmXEaumG+YvY6r78wK93QpTj/JLnfgmCeeG98YSa3zO/kp/mYcHkqcBWtVe1I62hIvcXBPWf+Y36fEiWvyt24D9gv4224zzUce7BEvvY44w03HAn6XAJ8sSOxD2JlCLZNPPBLW4jDjAcsKMfNkdrt8bMgKhFRY8tG+D/Njx3EkawnioM4gX6wWYpUfaAqbRbDYcfDUmL2Ddi+nL1r4GQU6Ae9Phsk/uEdA0Ec3aitJWkOiXjfeCtLp+VR1kG6vGsnIgwOACOwW/SjD5G9tMHryCPsybw2cTFzdwnT9c4fcEXV0UaOXJLWg62GNF9Ff/Yy+M29c33Hcn+hL1P0+VMmilKTjWSi7ugnAWYUOoOMIdaUSLdxuwLEAgAKu/jXveW9AZvE+Bsx5IO4RQg1OOoAbi1rVtNYWfejS1GgONabGkDr3L6/JC9ZBoMKQFNsElp2tTFGKQGg3CSIatHe/RXi4Un/P1012r4IGO99V/7OyjvZ04jDyU4MUAFHvhcdYtN4rPRZDPUXN2HwCkZwYPU2Nrt5oznIdOjOAlBqi9vuDNJ3Nr3HCX+kqniqyNm8J4D5MsjixZ+O/jJtiy9cQVfhSM34lsvwsx2HUlpWROX/kK8e1hnDQtw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gi7FFEaMDp480vI/TZF7lvtPvduTo9fczXFwgTP8vwXtAR6Tx3Up6jXUfmyClqFyJoegue7X+uuMuXSdajN1YGSPeyWK0CNQKIYMjHj7suDl0iqHn3gC5KKf51/1+le+ksb+HZUpazpJHRMrbg9UpSkEGn8G+MK5eYYQ5eOcDj7AO/SbZsFVPnU8g8OhUO5r5q3IXu/U5W7DjdUtnxzwU8NDbG0RPZp0JSFd4pIIhd/KyF/AUHQKRhnwoQ3yK9O50VKUISibLX57+7mPppKApjyOj+EDRPt10zsWPU0pvx7+zfFAaU/AHeGNwGWfD5mGAxXGGR3zwMQ+SCbU5UTtsIyHR7wjLdPbO2gep9/i7XJ8uUqNh8sdYmU+VE2AWfOzjBOWjV09LU6/76RcZ9lyLYycf1EQ8+WLQ0R7nfhnTBc06szokjYe+3QcQu4wLUkj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:31.3601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91502c3a-3128-4a0e-920c-08de8108c007
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
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

From: Richard Genoud <richard.genoud@bootlin.com>

Add the board specific part of the exit retention sequence for k3-ddrss
Following the DDR resume sequence,
   - exit DDR from retention
   - de-assert the DDR_RET pin
   - restore DDR max frequency
   - exit DDR from low power

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 161c68e474f..f039eb3f752 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -18,6 +18,8 @@
 #include <mmc.h>
 #include <remoteproc.h>
 #include <k3_bist.h>
+#include <power/pmic.h>
+#include <mach/k3-ddr.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -264,15 +266,44 @@ void k3_spl_init(void)
 		k3_dm_print_ver();
 }
 
+#define DDR_RET_VAL BIT(5)
+#define GPIO_OUT_1 0x3D
+#define PMIC_NSLEEP_REG 0x86
+
+static void k3_deassert_DDR_RET(void)
+{
+	struct udevice *pmic;
+	int regval;
+	int err;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmic);
+	if (err) {
+		printf("Getting PMIC init failed: %d\n", err);
+		return;
+	}
+
+	/* Set DDR_RET Signal Low on PMIC B */
+	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~DDR_RET_VAL;
+
+	pmic_reg_write(pmic, GPIO_OUT_1, regval);
+	pmic_reg_write(pmic, PMIC_NSLEEP_REG, 0x3);
+}
+
 void k3_mem_init(void)
 {
 	struct udevice *dev;
 	int ret, ctrl = 0;
 
 	if (IS_ENABLED(CONFIG_K3_J721E_DDRSS)) {
+		struct udevice *devs[J784S4_MAX_DDR_CONTROLLERS];
+		struct k3_ddrss_regs regs[J784S4_MAX_DDR_CONTROLLERS];
+
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret)
 			panic("DRAM 0 init failed: %d\n", ret);
+
+		devs[0] = dev;
 		ctrl++;
 
 		while (ctrl < J784S4_MAX_DDR_CONTROLLERS) {
@@ -282,8 +313,30 @@ void k3_mem_init(void)
 
 			if (ret)
 				panic("DRAM %d init failed: %d\n", ctrl, ret);
+			devs[ctrl] = dev;
 			ctrl++;
 		}
+
+		if (board_is_resuming()) {
+			/* exit DDRs from retention */
+			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_retention(devs[ctrl],
+							       &regs[ctrl]);
+			}
+
+			/* de-assert DDR_RET pin */
+			k3_deassert_DDR_RET();
+
+			/* restore DDR max frequency */
+			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++)
+				k3_ddrss_lpddr4_change_freq(devs[ctrl]);
+
+			/* exit DDR from low power */
+			for (ctrl = 0; ctrl < J784S4_MAX_DDR_CONTROLLERS; ctrl++) {
+				k3_ddrss_lpddr4_exit_low_power(devs[ctrl],
+							       &regs[ctrl]);
+			}
+		}
 		printf("Initialized %d DRAM controllers\n", ctrl);
 	}
 
-- 
2.34.1

