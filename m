Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14239CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0FC6849ED;
	Tue, 23 Jun 2026 14:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/Bkobbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C953849F0; Tue, 23 Jun 2026 14:54:32 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E06D8849C5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMq3BJ5w6WqDQ6k3Zz8VPGl3KHdNbPJU2DJnwNrA4LB89VYIO71mrySyc1Uu/N/yEXv7qFPAILF6f/bEliDQ0CbE0IKNMiDmJGV2/8HF3ZncCuvjzqH5JbuFEUBw0kEw3H4SJIS63yFPuY9BzI5yLt7j1lpbG8cqvfrbgkbY75goZmWAmqUx84LapZHixH+Hkjs/sewKG5C7Yp34SZK7227tgY4+NRouX9NKeTODT3fO1mFVCwhRla+JCIZdJ0ym82i+CfDiZK5/vsIEOZPu+PgxuHAh2AQpp9TyaXtFDyBe/v+HX4J6hfZaSeQOnKT7/0qIEYSIai8hQxnU4y2ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoGZdLGwNHz3mXZKXet3Eyj3wiPABZJo77D+WOgKqAM=;
 b=VHHcQNMs/Ons+13GRTqUz2fIKkXR0neUSCkr8mHymrVGEm+i5DUtSnj0YCkW8k0Vo//2t4bISgTa+hsvhaCKqDptqHyvzKl6PZOxiUyHgbMpP1kHaaIeANCArPOgF2H9Pz7eQ94/ejy2OP6U1t1FAAMQQ1Nw0rJ/h/LJVayhJrUYdurTeySXCmu+r8MWw9fvtNAI58U6umBNiIIEPkJcsW8ORJ7/VFVOeCgZXIM7eDk5gzPWa7vZNbUnZZ15xaWvrZg6yuDcTp9O4CDU/Ppc8ajWEqEcaHG0rGqTMmZTpEgoMfgDlZEiRy/M+SdkEnsJlXIcvny9Xk/kEMnQbJ1OKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoGZdLGwNHz3mXZKXet3Eyj3wiPABZJo77D+WOgKqAM=;
 b=f/BkobbqQGu/nN+iRytUyo+5VZUQ0eapj2f0nUnseTDo362BqaUVtGc3DmmIYJb3DEq9M9gxCcV1lvOx6fQiqp1ymKfhp60F2ATvBguOauvWcl5vB1XozILaw0YD5txcgJgTuadu+p9zL1Mc+VJAvPcNDIUEXSBlPY/aaHFXCds=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 12:54:23 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a2) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:21 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/18] arm: xilinx: Guard mach sys_proto.h against multiple
 inclusion
Date: Tue, 23 Jun 2026 14:53:26 +0200
Message-ID: <1bf5b1d49abb271c2c5e7135837b740179b95553.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gOVxPDMMRB/WIIMn8mV1tjPylnJzW4DF9/oiMF1Bifo=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNT7dfe3QVs0qoX0LF6RyFLcUPrDXWyPWG9/z0/4pb
 5KQz41jHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRXRaMDFekSl7uMtTaLZI9
 7+nO7G9fTxyPYz5yWy34T0z1mgIbZ2aG/0Ebdfv27v9Svv7H3qty3idC2237XyrFN87IO33FTu3
 bWUYA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d1270f-9e0e-42b5-45ed-08ded1268c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bhbJk3J+S8GoxV/cxggQ2ASugGM/NwJxYRe84SyAkCF9mywrAQ8hWQfgnc6PsvWZ/1BSxI7EXrgj1r1f34FdJw0jh2aiJLRzeab9bZVLS4saBKO0Um0UKXz45gfRVgkpEj4xYRlSnjtE3DaHWMNYfOo9PGldyktLNJAISWvQXpMIb2rhxuD9IZd6S05TZ0qnekPVbFMy6MH/BD1+FDNgRXNLem0oiS++OMyFgMUG3GXeZC3LwByO+WJMGBLi1SMRV9CVvToQZ6otNiPv40Ttf7oCNMqnjKd2EiPjCdU/Ct1SlURjYSCwrtYlEKrKN57hkbPv3k2NYglRmDgnf6gDUx2N1nvJnPFOQP+Gg8jH5KBk8Og9mfYIN0psihXc0Kipur3KQknDwSbk4Xq7TYbgGGyBaLTzupdxp5CNs3LAeIwT9MNQpMoytvGmWcW0WGvBo0tvhtEhbjSPz/3CGCK2jyAyZjzX/tF0cMPPS9u3ktGPKmuAYB1xgJ9wnE9kUwsf5XVMQTOsNxH82uJP7QWLrpW5YLm331TmemgcjdODSNw0DqqSCiNyCbsEAHFSsHpz7JB2J6Z6WZKPYDiYwgcnPkX6C1xbEoy+U4WLTRxt8fVbEHqe87mSPGULmV/IWGW99X9OHGgR9NY2wAIhSfoRB8sxkkpUgmNuN/GAF9yax7xW8NkeL6qEBxA8VFK+B46TNhVjHPIYf3X4W9pjvIDG3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tw5y6W1URCu1fawEO2d6+Klbs/kgKqUYgNRAGNDgPZ5rwi81xPOEwjrkgQq4IerAVVCKItwZAyJtcNGVBTD/AhU6ztbQ74A0IdzP+3maBmXcJAwxhUan7sBT7PFGM9nCL5LsPmi2ymul3WBP+9ebUSEXBMELF5rRNzeBggFEQCPUCZknm3Ma5x5sQ+b1IGvtydpds+10y6D3WcZ4UB0dssMGMm8Co8Dptmu9FaazjcMM9cdvW3yw9uaf4YyTK4o1Z/cS33KoAWJKLRf3+IkaMdvpkd2E6o5nHyFcOR+aF2E87W9lye4sp+1mf0u0Ss24wQmc+iUA3R1R2Rzx9mxcgCchXWSuirVo7Yaz5dr8ZwICC3Ar8o7/Wh+VG/x0YQrtYwsxrsYyrXXtzAhFmn1Pk7kAPa0hDDWQ9exg6Gu3CS3irI9lX/S+r7uGFhCV1HTV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:22.4687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1270f-9e0e-42b5-45ed-08ded1268c43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222
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

The Versal and Versal Gen 2 mach sys_proto.h headers lacked an include
guard. mach-versal/sys_proto.h additionally defines enum tcm_mode, so
including it twice in one translation unit fails to build with a
redeclaration error.

This is about to happen in firmware-zynqmp.c, which needs the SoC
prototypes unconditionally for the upcoming weak/strong multiboot and
bootmode accessors. Add the standard _ASM_ARCH_SYS_PROTO_H guard, as
already used by mach-zynqmp, so the header can be included more than once.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal/include/mach/sys_proto.h  | 5 +++++
 arch/arm/mach-versal2/include/mach/sys_proto.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index a6dfa556966d..b53e616e47be 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -3,6 +3,9 @@
  * Copyright 2016 - 2018 Xilinx, Inc.
  */
 
+#ifndef _ASM_ARCH_SYS_PROTO_H
+#define _ASM_ARCH_SYS_PROTO_H
+
 #include <linux/build_bug.h>
 
 enum tcm_mode {
@@ -13,3 +16,5 @@ enum tcm_mode {
 void initialize_tcm(enum tcm_mode mode);
 void tcm_init(enum tcm_mode mode);
 void mem_map_fill(void);
+
+#endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index cee134886208..3ed0b25be802 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -4,8 +4,13 @@
  * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
  */
 
+#ifndef _ASM_ARCH_SYS_PROTO_H
+#define _ASM_ARCH_SYS_PROTO_H
+
 #include <linux/build_bug.h>
 #include <asm/armv8/mmu.h>
 
 void mem_map_fill(struct mm_region *bank_info, u32 num_banks);
 void fill_bd_mem_info(void);
+
+#endif /* _ASM_ARCH_SYS_PROTO_H */
-- 
2.43.0

