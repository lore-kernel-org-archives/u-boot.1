Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A99C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 11:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD50A87C92;
	Wed,  6 Mar 2024 12:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rypjdgtF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554C387CBA; Wed,  6 Mar 2024 12:24:57 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2A887916
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 12:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nX3BhfM7hs6F4MaYLg15GEF+98bwGgA3AkrZAB0rr09abAErSt4HByIjtrzjpXjYgByMxGxqk+WrnHupn15Fpltwp3lrMMXsYZqvz5IOIRaQvsxC3ctZs6t4WpWBkervIwhsc1LdAk1JrqMf4imudcokdMG0gxHq9Ha5gxXBXiuVRtkLD5xZmSNdRLJqLdqH3jeI3X5i4jb6T+Sc9227hVKCwEqh7sdD/5JHn3zo3FCdHxq9bGIADC2O/CrpsfO6hVHjE5zRJgm/h4l95yo3xEwLZZO5yT0G1UTU1mEWcyN5qJAWgpcH9U4EHn6+Y5g2XQejHI4KvcR3UXsVQJeZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZlgjJcWyuVfRREb/5HVM/tRyL4xx5ST9XgOKQMh9H4=;
 b=JvKxEmMJJMZiBGxkKGxBhODzARNFv2uOe9i2CHflDLgeB7Vk8eB4gIi4FIKbHuSAIrpVRTJ9S/RaPP+XpfAPevkgnWOSM/iP5rEF3NmOLVf9zy2+eyLEgZmJpIsn+6BFR0VoH37RTgFnggff4Usl+RkshQ+rYHWtTQM0jPyHNvwlAyf23bNmPUuKgrBo2RjRm2u5zPuNII7nTcKsd3L5eFQcPfVPJyM8Fz2YNAsBzbCfi3A+FYYfCeeG1m0hXf+/vBRFxOS7DfJEjCx5pflcHtpk4EykRBK9xFlhfT9fCK07dEUrkCppxUyae9c4hOgy2OO1bc1zd084szDwJj6R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZlgjJcWyuVfRREb/5HVM/tRyL4xx5ST9XgOKQMh9H4=;
 b=rypjdgtFZPWsGBa5Jts+uvGb0pK3NjIJYysZJ3CeZS5z0CbrzZ1thuLnHHzpBhn4uA+91WUp8G1WfLdnbfIgjUrClf/tnxCkKP8LBiDVbqq1dHY2E+AnbWZU2g4PPIirflJeKWDt6SofB1WTRXq6ZKRy4YdX8BoTzHIAKKwOgow=
Received: from SA9PR13CA0155.namprd13.prod.outlook.com (2603:10b6:806:28::10)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 11:24:51 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::e1) by SA9PR13CA0155.outlook.office365.com
 (2603:10b6:806:28::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Wed, 6 Mar 2024 11:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 11:24:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 05:24:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 03:24:49 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 05:24:48 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <git@amd.com>
Subject: [PATCH] arm64: gic: Add power up sequence for GIC-600
Date: Wed, 6 Mar 2024 16:54:41 +0530
Message-ID: <20240306112441.1606878-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: a8db2f65-90b5-440b-924a-08dc3dd009f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beHANG9YvhF62G0roHSLUOAuAUZNDqwhQbhoW6jGIvTr/DXO+lwp4V/wKMzsjfs88tK/RM2Hb3BELty613GN4n3kBUXvjg6g+zrLET8y5evWjYsCeFI2rjQvl90RsCSOh36J5+7XaXzhGyUz21GrN4hvW7N0NSjFG5EkZZL6i1Mp8lmFvvIXSWaXTRZhfjVDlwHQq1BlI5h4GG21pthtCUb4Lspp0VCldFvMeh6U05SrtEakfBj+1I/Q686C94peP6MuQq79ArLj6VL4raJiXE6JBqwb+OBPNPNOMopR8B/yI9hC322v1hYi9vZCYkgen82lCGEKlh7p3pwHiUC/GxaXSaYeT3HCZlQq7Hu2jA4SvleS0BLCrpgK3eKkWQdxq0e8PXptsmiuWOQXOxMi5OFuSVkCqlLFQai0/nap29rJXxTnUoXsn5dgeN6cvxupF7lPc2Wf0wHhwDCf6arnHf8FV4dKUi/OH43ROLesk669Eych06tRql5R/zzVcX9J8E0wwTAiMsURyGI4/ELsb0ak6YpW/H9c0xi0gTRiHlFqH3OgvPFaTX6EQg3JQ4P4rLSTCTqPcdkA7Y9gUNzI2qWL+VZ+T3tvDSmViBLMNMlMqnHVBnYqu43fqE1tftqLn377z9jz2EwupRQBpv0e4DQhggp2LCkiS/1z/ru3vRu/HGBVZzfEeRrBFeRrEUb3IJgzW/43M7NwE3NJBYKJSlXOvQhi5t4f2f12aKfAtvHjJ5ivyi0W/iZRsoo7vLBm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 11:24:50.8395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db2f65-90b5-440b-924a-08dc3dd009f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

Arm's GIC-600 features a Power Register (GICR_PWRR),
which needs to be programmed to enable redistributor
operation. Power on the redistributor and  wait until
the power on state is reflected by checking the bit
GICR_PWRR.RDPD == 0. While running U-Boot in EL3
without enabling this register, GICR_WAKER.ChildrenAsleep
bit is not getting cleared and loops infinitely.
This register(GICR_PWRR) must be programmed to mark the frame
as powered on, before accessing other registers in the frame.
Rest of initialization sequence remains the same.

ARM GIC-600 IP complies with ARM GICv3 architecture.
Enable this config if GIC-600 IP present.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/Kconfig                 |  9 +++++++++
 arch/arm/include/asm/gic.h       |  1 +
 arch/arm/lib/gic_64.S            | 10 +++++++++-
 arch/arm/mach-versal-net/Kconfig |  3 +++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 01d6556c42..8374cb7acc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -122,6 +122,15 @@ config GIC_V3_ITS
 	  ARM GICV3 has limitation, once the LPI table is enabled, LPI
 	  configuration table can not be re-programmed, unless GICV3 reset.
 
+config GICV3_SUPPORT_GIC600
+	bool "ARM GICV3 GIC600 SUPPORT"
+	help
+	  ARM GIC-600 IP complies with ARM GICv3 architecture, but among others,
+	  implements a power control register in the Redistributor frame.This
+	  register must be programmed to mark the frame as powered on, before
+	  accessing other registers in the frame. Rest of initialization sequence
+	  remains the same.
+
 config STATIC_RELA
 	bool
 	default y if ARM64
diff --git a/arch/arm/include/asm/gic.h b/arch/arm/include/asm/gic.h
index bd3a80cdf7..fb64ba076d 100644
--- a/arch/arm/include/asm/gic.h
+++ b/arch/arm/include/asm/gic.h
@@ -57,6 +57,7 @@
 #define GICR_TYPER		0x0008
 #define GICR_STATUSR		0x0010
 #define GICR_WAKER		0x0014
+#define GICR_PWRR              0x0024
 #define GICR_SETLPIR		0x0040
 #define GICR_CLRLPIR		0x0048
 #define GICR_SEIR		0x0068
diff --git a/arch/arm/lib/gic_64.S b/arch/arm/lib/gic_64.S
index 86cd882fc7..7fa48648d9 100644
--- a/arch/arm/lib/gic_64.S
+++ b/arch/arm/lib/gic_64.S
@@ -92,8 +92,16 @@ ENTRY(gic_init_secure_percpu)
 	add	x9, x9, #(2 << 16)
 	b	1b
 
+2:
+#if defined(CONFIG_GICV3_SUPPORT_GIC600)
+        mov     w10, #0x0               /* Power on redistributor */
+        str     w10, [x9, GICR_PWRR]
+5:      ldr     w10, [x9, GICR_PWRR]    /* Wait until the power on state is reflected */
+        tbnz    w10, #1, 5b             /* If RDPD == 0 then powered on */
+#endif
+
 	/* x9: ReDistributor Base Address of Current CPU */
-2:	mov	w10, #~0x2
+	mov	w10, #~0x2
 	ldr	w11, [x9, GICR_WAKER]
 	and	w11, w11, w10		/* Clear ProcessorSleep */
 	str	w11, [x9, GICR_WAKER]
diff --git a/arch/arm/mach-versal-net/Kconfig b/arch/arm/mach-versal-net/Kconfig
index edff5b039e..31d6443e9f 100644
--- a/arch/arm/mach-versal-net/Kconfig
+++ b/arch/arm/mach-versal-net/Kconfig
@@ -43,6 +43,9 @@ config SYS_MEM_RSVD_FOR_MMU
 config GICV3
 	def_bool y
 
+config GICV3_SUPPORT_GIC600
+	def_bool y
+
 config SYS_MALLOC_LEN
 	default 0x2000000
 
-- 
2.25.1

