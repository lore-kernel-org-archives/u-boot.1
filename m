Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE0DF43834
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E3083B99;
	Wed, 15 Apr 2026 17:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WZfW2rLK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DED3841CD; Wed, 15 Apr 2026 17:22:25 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 158AA83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1FGYTpqwMYfALGmackzz7POf0GCTZ+2OlFmZxpc0Ew50HGjGCafd2pcuutBWSbKqrD8vyl3w4hOlewc5DCf3SjaA8XZuR5pAyftZv8klnWiypdWjyi7htxTi+XmNAeCxpWKXrGB/sVmCHHXJXGSQI6j7m5CxaopxJP4VlLPsO4x8VHHsHqhysD+qWMfZZGObZEqUCbBl93ZEOA+pwHFXj2AiBY7DrkLd5RafYtpnKwxfy4SxzPfAdP75wUyy134LJTT0jWgCpojPPDKEF6ASFs4L4moOoen53nO9L/3D/2NGYe8CXSUfpnIh8VxUeQEdtFiRmmrAonPF2XEhIPVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6vNc0VYTbyBLLl8NYQNMlAbaUm+OuS4nxa/nFT1Nzw=;
 b=cpiCxKMLuAA/qLysvrg2Rl44gCrJmkkOYMe4xVh6QbRL/MAodOdBy50NKToD7QHEJpD2a/8+2si2oR786BzdnZ3o3d/a4GPes0/esLsU23ssMR+iYttRoMJ6BlXJO3roUl8Oqfx9BCnDuXx0j7l6d6pdBkzKTCCeyeokfQLw3NpiZhb1z17uxOK6eUg2QcfFhY5RqjIg6Jn3RhwHwsuFo1Ub15JI2YZVKMDisbxF9I8oQ06z/gRPk/fT3BNozno1bRrFtTS6sb3NIrxTydx33fKkzGrydiXy9n76RDaBHNcSnOq6HYHtC2TAIDTGwn2I1/ik5uLLuFK1UTjHDI7LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6vNc0VYTbyBLLl8NYQNMlAbaUm+OuS4nxa/nFT1Nzw=;
 b=WZfW2rLKoCvBQXk93yqH7AAtUsnVNa5sFQ51ZxFPiHuW/29SfNFG8a25la0dWg4A5aarQt1pFFkUXc61aKw0DOkabdz46DoH9SSdwuWGLB+F+62G7DAAPbACdVg381ResHoyOtW0IamJiXPDJppS1U6FC3eZMEcDd6kHW0aL/b0=
Received: from MN2PR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:236::15)
 by PH8PR10MB6454.namprd10.prod.outlook.com (2603:10b6:510:22e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:22:18 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::90) by MN2PR05CA0046.outlook.office365.com
 (2603:10b6:208:236::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Wed,
 15 Apr 2026 15:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:22:18 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:12 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 10:22:12 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FFM0ul2222771;
 Wed, 15 Apr 2026 10:22:09 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <bb@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <gehariprasath@ti.com>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 3/3] arch: mach-k3: j784s4_init: Add workaround for errata
 i2437
Date: Wed, 15 Apr 2026 20:51:52 +0530
Message-ID: <20260415152152.3048491-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415152152.3048491-1-u-kumar1@ti.com>
References: <20260415152152.3048491-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH8PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: f12c58ec-37b6-4b2f-2600-08de9b02c82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Trg0QcIhP0WK4ILY2S/T8zXuChH9u1bYxp9zNMXoTwy3je4pMVyZ5khhmmOLs8NFR+HTw9AlY6BACPFeaeinl74wRY2PfCo4h2lgGOvNGWgYtrEZVHYkSshZuDwkljNRnjelo32ir1sqO34t21OyN9gi7bmYpAsw1rQegChHF5dzp3UgvcfpCrnU6VdQ2mZ7K4eCTB9DGQVEOga+u67rhMVATeK22ctajtVS0EjcFtfhy8/nH/7AKXp7P1NrYMcck9+HACJmO64lY3Ot4hlr/T6IE6e7BJzJAtsobq7qJhatTaMvBRQLka9guEEJCLYjnVh4ObQOCXkeWpvf9oUwQqh/GZll2NVQuj6AOWmPmlCQdegF61qANr7uAT+nDYiTLdQBo8kRac2voWrOF+z210ZEgd0A9ewf5g1HUD/eE3u3RRMdOdlzYifNq1G2UF05W5r5Xcdjh80stNiWIvOpcNzLmGOM7ZRX6eckcMo6FSh2eP+/JlE2SUa01dL1jODsZKjS2TcSsJxHQh1VvQd2/R1fxG3O6u2P088tp3gibzMS5ptBH3TTLrG0yiwELpoHy+5VL2kuPZYEqxuebY0SQOeXfH7oIBDrcaCfXIQLACtCias4fV7qqyXKxf7ZVihGblWrWT+ERyqyiacXp+0jIc+7abpn+R3uXG5aq/bA3QpVam+JNdJKOyVBNgR8nDCLe1GAFS55Wbf8KmbN9cj4MmxaPe72T5NdsDIjrYHWovUnpPrAzRWcfc5Dwo8DEvGbnAj45In9Hc8L16jJ+4GD+w==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q07+9eTUWg/FZK6OUDXkK8eV/i4tpBAL6QiTWtc6EsS9nrtkyBqUZQdyZ9dk101Sd+uCRUC0J8S8Go8qnutecC+zRiBClUG0XCj00YQiO2aigAVA4UCZCjRI97Td5WdRLphPaxKIx6WQRdiL3DAR4CreluA2wbGzcRVHuwPip6ZvYRjElbCY+yH1DQxToewv3J0slOJ1hWd6Aes9m5GvD6bO9OkIuHTOtn/Jyh8lLkpDwXuej8mctN9nbnUqu/ooRi60Z2S8MnkLsq91aMdPk7GNVFsOTeA+Ox+YrIdujtBZ9i8Yh7hOnBj3so5H74ZceZ9V5QttiIoLReX6zPG+3SfFL3+x4cBZxZycxW0EppuWJqLe8NiNOidW1GdOLUW7Di0hrf6DIoYlkypWLaIXbAzAPIzGHCa+h7RKyEjKfFbosh5kEo9ZOWN5B/Ooigf7
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:22:18.2693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12c58ec-37b6-4b2f-2600-08de9b02c82e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6454
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

From: Neha Malcom Francis <n-francis@ti.com>

Add the workaround proposed for J784S4 errata i2437 (link) for SE
clock-gating turning off too early. Without this, a hardware bug present
in C7120 leads to C7120 CPU hanging.

Link: https://www.ti.com/lit/pdf/sprz536
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/j784s4/j784s4_init.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
index 53f152ccd9c..507b7ab685a 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_init.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
@@ -45,6 +45,15 @@
 #define NB_THREADMAP_BIT1				BIT(1)
 #define NB_THREADMAP_BIT2				BIT(2)
 
+/*
+ * RAT mapping for errata ID: i2437
+ */
+#define RAT_ERRATA_2437_BASE_REGION0		0x40f90000
+#define RAT_ERRATA_2437_IN_ADDR			0xc0000000
+#define RAT_ERRATA_2437_OUT_ADDR_U		0x0000004d
+#define RAT_ERRATA_2437_OUT_ADDR_L		0x21000000
+#define RAT_ERRATA_2437_CTRL			0x80000010
+
 struct fwl_data infra_cbass0_fwls[] = {
 	{ "PSC0", 5, 1 },
 	{ "PLL_CTRL0", 6, 1 },
@@ -322,6 +331,36 @@ void board_init_f(ulong dummy)
 		setup_navss_nb();
 
 	setup_qos();
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Errata ID i2437 SE Clock-Gating Turning Off Too Early
+		 *
+		 * A hardware bug is present in the C7120 Streaming Engine top level
+		 * clock gating logic that can lead to the C7120 CPU hanging.
+
+		 * Workaround: The DSP_<COREID>_DEBUG_CLKEN_OVERRIDE fields of the
+		 * COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register (where COREID is the
+		 * name of the specific C7120 core) must be enabled before power-up
+		 * of the C7120 core to override all clock-gating.
+		 */
+
+		/* Setup RAT mapping */
+		debug("Errata i2437: Use RAT for COMPUTE_CLUSTER_CFG_WRAP_0_CC_CNTRL register\n");
+		writel_verify(RAT_ERRATA_2437_IN_ADDR, RAT_ERRATA_2437_BASE_REGION0 + 0x24);
+		writel_verify(RAT_ERRATA_2437_OUT_ADDR_L, RAT_ERRATA_2437_BASE_REGION0 + 0x28);
+		writel_verify(RAT_ERRATA_2437_OUT_ADDR_U, RAT_ERRATA_2437_BASE_REGION0 + 0x2c);
+		writel_verify(RAT_ERRATA_2437_CTRL, RAT_ERRATA_2437_BASE_REGION0 + 0x20);
+
+		/* Enable DSP_X_DEBUG_CLKEN_OVERRIDE for C71x cores */
+		writel_verify(0xF00, RAT_ERRATA_2437_IN_ADDR + 0x200);
+
+		/* Clear RAT mapping */
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x20);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x24);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x28);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x2c);
+	}
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-- 
2.34.1

