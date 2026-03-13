Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EB3105F7A8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DE384315;
	Fri, 13 Mar 2026 14:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nS7N8VwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF42884307; Fri, 13 Mar 2026 14:59:30 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 943708430F
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ozy7Ckj0+Bt/P/Ni2het0oeH9O3Zb7yVhU+LYW0Wv5sU8tc6ijIVpT8rvQNl1qJKIB66tz7hzcYdnYZaGaoUkUcIpvMWFBTmX4tR1ZksCcA79UZUOJ+WolJKRANkerEyCLpOTqw0wiHqsW9Zd3N8IDJ/R8xhuSI+3NsOfUGfbxBbMEOlh7UQ8snw4Y/+dV2mAQ3/sUKyvfmayujul7e4QeUDQlSM7solSDGng3fwQXDWq1kauvBbIXwNf37Y/kHqh4iytdK5n7Ii9xkmG/Osa0OBH892TD/A8xvFvuHu1hXQ6UwdHNsiuyaO/JtuoyzPNkIKBSV3YPiEDHgG0eGFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMzWfyvEEsze2KrbVPAKG0BUclavDKK3tPt0X0qllQE=;
 b=MsQyY8IC+p95o1j2X1Jj1ifTur/wBfuswyJTjSQsS9XBe5fbBRQNneP6+A5Igm5LcbIZ4AFPVtRcYF+KXCFy7CeWdNBtFCyRO1FqCjHFNGMAr0iAfX5U6KCDQpm0Hk4802/I9jAbvtdirSS7L/1oIjKhGhj8o6UiOQ3sTT4fBWKGddNdkpeTAIMLOexiMmkwHKbjJx0syLqRZXFCze7B1eS/uI2/NYG1OwIl3BHHHAEeGxTtlwJq1AuoesPUZamUwyBtyN0d7GsjH4ASKaz3SeaDkNmRmwasOh/d7PBHf0K2VrZ2zB8WF38RDcrIFTYNv/QoghnYJkC//Z2S0nxkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMzWfyvEEsze2KrbVPAKG0BUclavDKK3tPt0X0qllQE=;
 b=nS7N8VwWOMuh3E/SL9IjAVw4J2Q8HJkVwhvt8jfDIYVBVC5HZ+wCMRoRLo/6IogDRQWFeGBMGvg1o7mxGkcB3dX6htIkdzM9mmhWKOhBC7tn77fichCjkD7dmmrPgWqvlR4p0OTh1sMia11K3uQ8x10EAQ6MWVzeVn4xd/2SJjs=
Received: from BN9PR03CA0974.namprd03.prod.outlook.com (2603:10b6:408:109::19)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Fri, 13 Mar
 2026 13:59:25 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::97) by BN9PR03CA0974.outlook.office365.com
 (2603:10b6:408:109::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17 via Frontend Transport; Fri,
 13 Mar 2026 13:59:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:24 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:23 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:23 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jc638000;
 Fri, 13 Mar 2026 08:59:21 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 06/19] board: ti: j721e: Add resume detection for J7200
Date: Fri, 13 Mar 2026 19:28:47 +0530
Message-ID: <20260313135900.3430264-7-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 396665a5-df86-4386-b874-08de8108bbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YhtVjiCmB8bAh4oBGQow/qFfu1WQCtUpefX/jyqABSb2+AvuxE5K97F3E8k14+L6X1OCfltECFpBnVVcqqRQ4+doA//N/WBy3hgoIS/bW3Kl0x7huZ9Omegd/DjeGI6vWDRbHuJiTR6RcvDALzVSEnp3QWqDYtlolzn89fv/WUaw32Ili4L7L/4E2jPkSYV23E3uEOyF5UsQNHTHcnZQrwD6V5bCAy1EJ3CLBPalmF8RZXOTQa2eTFEBOU82a2OdJZ+FKfnffxvjg+wXgkH6s7PZTbBAAHrx31O2GfvywXYpg/K4fM6wzEuC2dktTgulHVzx3t+iLJgDWZQ6rE1rsCZKT3GMYi50c2osMc6wz6k/JqO004CeXV6BD5VYjo6xItoJ8hNQF4nSNE2C+pXBDuIMynhlc5LcgrD2/azV2dAw/KLN8m1Yfxg+Rlrbyi2SudeaHr8t9PjNBCCBDWU17CO9cfZCb9dAC5j/CfSv3Sdc+lJKl/KPAO6lcJDxD/rCT8O+4qbUxcX7UmJ8rwyO0C+021+MDMAZVqRn46VTkiVA2/GFFgHGRPcDP/n4do+pd/kQBW9gFXaegvwOzwqSYigF0qALVXF0eAugTPrUu5IBQ/XPHcMVpb7pKzWv+ObJ3IWj+VUjnXDKdvK3PRw13K2VrdPKhVRag2RoRmMsGYJjujWRmE+0VNejPWGgrfLZ05S4tOjaFIF96kiTj8sMKcwGzDIZA6hsVwXhNlwENTvVJ9eXyqrXcv9kHdZVjN+2IYWSEXWuBi3qGoEYrSOJ8g==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0MCZqkEtWYuVv1UpjGX/wSDQwi6Cf9qm3RpR1XFEWvee7UmMMAP3NJr7S1I8SwZWFj0AS/b7CYL+WCzTj/2NMAVDnwPZIykG9+cXFxdWLHRywXLP9vEiiwScJQR8eNnPDqjKDSesImZG6DJ/9Qh9Nx99LL8oAvNISxNoPbtHCdquV7TIosA6nylCMuKwxbAJfzaI0BDRwkDbJmOMQQT1redS1eUIIxtbcIrtGmzUbgdr4le3OmKdrwrRXcjcT24iGsTOiGkAwnqD5MsrfpM0IbL1jMD+/XejlQRoJlm//PDYnhIuMoajg07dgte/5Rk+mxfwN3c1M3OELDNGIuK8iIG9+vrHkknios/Lf5q0uHOxJDZUdjCq9vcR9xqHhPzlr6d6SeIgdKDbByqJ2an/kbeCPSlK7qVQJWYgtNoIjxZ12Zj7X3z3yOdgRdj/j5U6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:24.0283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 396665a5-df86-4386-b874-08de8108bbaa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
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

From: Thomas Richard <thomas.richard@bootlin.com>

Add the capability to detect a resume. This overrides the weak
function board_is_resuming(void).
To detect the resume, SPL searches a magic value (0xBA) in a register
of PMICA.
This value is set by DM-Firmware during the suspend sequence.

Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/j721e/j721e_init.c |  4 +++
 board/ti/j721e/evm.c                | 49 +++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/mach-k3/j721e/j721e_init.c b/arch/arm/mach-k3/j721e/j721e_init.c
index f9af0288cf6..f325597a70b 100644
--- a/arch/arm/mach-k3/j721e/j721e_init.c
+++ b/arch/arm/mach-k3/j721e/j721e_init.c
@@ -300,6 +300,10 @@ void board_init_f(ulong dummy)
 #if defined(CONFIG_K3_J721E_DDRSS) || defined(CONFIG_K3_LOAD_SYSFW)
 	struct udevice *dev;
 #endif
+
+	/* init resume flag */
+	gd_set_k3_resuming(-1);
+
 	/*
 	 * Cannot delay this further as there is a chance that
 	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 881392bd963..20c77ff804f 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,6 +17,7 @@
 #include <spl.h>
 #include <dm.h>
 #include <asm/arch/k3-ddr.h>
+#include <power/pmic.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -469,6 +470,54 @@ err_free_gpio:
 	}
 }
 
+#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
+
+#define SCRATCH_PAD_REG_3 0xCB
+
+#define MAGIC_SUSPEND 0xBA
+
+int board_is_resuming(void)
+{
+	struct udevice *pmica;
+	struct udevice *pmicb;
+	int ret;
+
+	if (gd_k3_resuming() >= 0)
+		goto end;
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@48", &pmica);
+	if (ret) {
+		printf("Getting PMICA init failed: %d\n", ret);
+		goto end;
+	}
+	debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
+
+	ret = uclass_get_device_by_name(UCLASS_PMIC,
+					"pmic@4c", &pmicb);
+	if (ret) {
+		printf("Getting PMICB init failed: %d\n", ret);
+		goto end;
+	}
+	debug("%s: PMICB is detected (%s)\n", __func__, pmicb->name);
+
+	if (pmic_reg_read(pmica, SCRATCH_PAD_REG_3) == MAGIC_SUSPEND) {
+		debug("%s: board is resuming\n", __func__);
+		gd_set_k3_resuming(1);
+
+		/* clean magic suspend */
+		if (pmic_reg_write(pmica, SCRATCH_PAD_REG_3, 0))
+			printf("Failed to clean magic value for suspend detection in PMICA\n");
+	} else {
+		debug("%s: board is booting (no resume detected)\n", __func__);
+		gd_set_k3_resuming(0);
+	}
+end:
+	return gd_k3_resuming();
+}
+
+#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
+
 void spl_board_init(void)
 {
 	struct udevice *dev;
-- 
2.34.1

