Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFA0F43834
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D7D841D6;
	Wed, 15 Apr 2026 17:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ffhAay8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBCA83936; Wed, 15 Apr 2026 17:22:30 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F4A84201
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLXFsxFcWmcUZKi3k6z5Tjiv6gfLg8rym2KNRbC8yf6AE+wq0d0TJF6BGVjjde0E67Qusf6eApo673bZ0p1UK9XDU0nyEfeL1c8YR9GJCb8GvPeXVcXd0H2RwThjcqedgHJqjc+BRZAmvjNtuj/hiIOQ8kxqpHpc+15EnnYoTMZk9pPkkMI7O3s6BWFPZiq3Z5NE1A0PYI8JNvt4mo3/UDc0kX41w8YnOm1hb9MfZ3w3JwVoTyBLIQK5NNtYGMHkqXLgE0hHmJxF04P371bQaVCQJjTVNeztTD+d/vhqLpRBPaHVwL+h6fcqmPRFPgclOeJybflKaW9tvIlbnyH8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBa3pbYxyH6OGWOJH1zxZkWx4uuBMFUAaf4A+kKjrJQ=;
 b=CQ//HuQruw0vQOtJXo5+uV69utasLc4i+vug4xJddT1dimp5XYWutHAHpEiVjy57glNh0fOlohcU1OCQUAGkBwEh0sAfRl1fICtmEeeRuoFgsrHSdsiZP02GHthQdDm+aXvERx8+Dz+CuWtbsoMKmyfZ4spY+/s7ykSD+6gM+RZ8pLvxHqfVyVMWSv2DQK216jT4Vq447yJafWbWLX1f7h4kY4qnCWee+P09eoVKZno5OYnvaD7h9x9hZOqXbTjZ7/JDfyU/mtLfyxwzLytHq8edk8C7fmRIep124BUIaZDCmFVxfd4g+rqSXJFl7wPq9FaVMORhni3vHDOV/8mNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBa3pbYxyH6OGWOJH1zxZkWx4uuBMFUAaf4A+kKjrJQ=;
 b=ffhAay8Um81wExEALBXiXm0aEYWrzyaGwk/Lxwd4NpQwVunDnIyip8K2C+uE1+pn8v2DuJhTbUrBes7ZMXch3RditeoY9sYmNa7tmmWcMRybgtuDBTBxogbdWGRujD5JUuhJvAr9JJztgBBz1K2uKf0eje1XG9nmbAdU4ur0RJw=
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by SA2PR10MB4569.namprd10.prod.outlook.com (2603:10b6:806:111::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:22:24 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::31) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Wed,
 15 Apr 2026 15:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 15:22:23 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:09 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 10:22:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 10:22:09 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.53.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FFM0uk2222771;
 Wed, 15 Apr 2026 10:22:06 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <bb@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <gehariprasath@ti.com>,
 <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 2/3] arch: mach-k3: j721s2_init: Add workaround for errata
 i2437
Date: Wed, 15 Apr 2026 20:51:51 +0530
Message-ID: <20260415152152.3048491-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415152152.3048491-1-u-kumar1@ti.com>
References: <20260415152152.3048491-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SA2PR10MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b80a0fd-b1de-4b4e-cda7-08de9b02cb69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: DntW+N6o7u45qcwHWP6b8A1Z62veccN2ZAgJ/vZMDATjL/vzz9US7LJd4lnQYe1zqqcSfM5uWShfVYM5MF8WAV5Ykg7/Y0AcsXytiZPwzerVngijxPhLuw2KqgElzgoaJOuLpukcB1OliUpYdiTN+uu2cphASVh2M6mzQRJ2NGMj1gMAc/F9kCB3QHQJfd8NLCpuN8lVxogPt/xBD5w4VPKLspOEyPOIWQH9aDCpvkhvskRAoRUkFbxJKmah7GM8qaD9Lg1iBDRNdsWO7Un6rLYUDQktjpjOvL+mv0HqQolWjlGXkTqRvX5p2riwB+z0dHZ8t1yviRC74WqZaYreB+vVLMt+v53wcytbdJC2yxN2RMPGbj2HOWBcI1qVgtvVArvjniAa4ZKeHoVowDmngTA55YhNmJ9B70qY32JphBJT9O98GLmUaphAvFqMWNcVey3T2fqc0dDiVXMc7d2KPcMrAprDn9mnAn+imKl++YzrPpyvxnEZz26uOb7pxHL2JSy/l5zB4tV2agVdjAIy8iYW27ljkjxF640Dd2EBFd5wNngvO3Ix3jFwjJJA2A8L2q9rqint7CpRafkvyNkWC9in0qPzI1n5nhH0gvEau2r4oMd/+jLgIliWbQgTH1YpjbYpscenaDz1KraepYTKi+6198VjjHsac6tx/7RqcGCgKWmmcjfvsq2KE39v2fcJaCOqPc98HA62e6aHX/Hkris0UoE6EOHIVXXIWqvefpM4kJFUk93eIdlh5yXRvA52UU84rKSj3f2SY6bjB6fcsg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ndh0SDCRhfxR3bR9lyrih9INJiYkRrokVtoaLVmclt2SOq8KN/W3KZo3hcDEYbh+R9jEsY1XqObo1djbqwOmmdQv/gmTrEvQ2fsSqaWwH9jBgem+9xWqqjVxXV5xZ6vZVnrbTzDhifxPh2ZwRhb1bFihUY5PWc66qumA6Bklp8s9zXPp9tAq0JdiEsX31vAAtBFhiQ0uF9HQlXapvf6i5xhOOymIA+CpuP2vQe3215XOhSaV2fxfRjE/gXfeL+MJQWRYu+LE4NpGmQ+/NsEFFOMf3cot6PdQqB7VG/eO31MQ68bbAeRadhaQpTwoiRGwf/EE8dIxdLcZYDaA3FwR0NJMRlQl142xUHgbtlJwkRvaxDKjLPasG4sAEHZS7bpIwQxPaBkjVVkxIObwhASVmguydheGSdBxl3Z+BwjRZp/Py+mCNZbHGPW411XjLA+R
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:22:23.6837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b80a0fd-b1de-4b4e-cda7-08de9b02cb69
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4569
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

Add the workaround proposed for J721S2 errata i2437 (link) for SE
clock-gating turning off too early. Without this, a hardware bug present
in C7120 leads to C7120 CPU hanging.

Link: https://www.ti.com/lit/pdf/sprz530
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm/mach-k3/j721s2/j721s2_init.c | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
index b5453d8895d..780d853423f 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
@@ -40,6 +40,15 @@
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
 struct fwl_data cbass_hc_cfg0_fwls[] = {
 	{ "PCIE0_CFG", 2577, 7 },
 	{ "EMMC8SS0_CFG", 2579, 4 },
@@ -346,6 +355,36 @@ void board_init_f(ulong dummy)
 		if (ret)
 			printf("AVS init failed: %d\n", ret);
 	}
+
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Errata ID i2437: SE Clock-Gating Turning Off Too Early
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
+		writel_verify(0x300, RAT_ERRATA_2437_IN_ADDR + 0x200);
+
+		/* Clear RAT mapping */
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x20);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x24);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x28);
+		writel_verify(0, RAT_ERRATA_2437_BASE_REGION0 + 0x2c);
+	}
 }
 #endif
 
-- 
2.34.1

