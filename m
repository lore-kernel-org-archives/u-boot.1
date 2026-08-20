Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68728C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0EB0E6076A;
	Thu, 20 Aug 2026 15:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3nO8ABqmnm3; Thu, 20 Aug 2026 15:05:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238305;
	bh=wfboa9wfCYc5ab5W6EO+b9JVnLuX6067v+piEyDDefA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtmN6YVI9tk+125d0DWMquyGHZZqajhsjzL+3Vz6vvHoG6dzf4UqxRQhYSaA6fUfa
	 f1exv0dxwUL1Y449O+cjuI8EAzvDzTg3y5Cc7nUP5uuWGjH6eLYJFvsQw5Jkj5FBIi
	 TOVESzn1KhrLV00tz94oX6baQx/L8KUyJ+57h1DqmVRNWhAPp/VI5VJwDMtLGWqPsK
	 CQwZ8vnPotPXmcsdc7hLGaFICVz3lE7CDQVb1UmqkGKDqQ41TbMZiaMO3FN9t2o/z5
	 K2PA8JWNKzIMuhImY8iYXhP531szB4Qs1LM7n3RySSak1yGA+325cpdZAV1//dGZdQ
	 JpfqKrXU1am8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DDB8607D5;
	Thu, 20 Aug 2026 15:05:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AD05263
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 611F140329
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycs56YTv8Kfg for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:05:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NEx7aPXP
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 548F24031A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fURhXEJ/z89NoJ8qISYtKR69DAlN7elY5ZlzjLUDS2QPvu3ur3B7eMw1PiPXgvJ/IkbHF8Gusky5ZVYskxSWyVXX18vtVdd5BbKEs2nKbhiSIZL4bl3ZjTBGMpvOTSO6ldDVInzo4VoCFofXCZZhgZAfzFkedIuf5MOwbgDrlyTFiQj0AHywxPyvDk6GpcmBkrz0d2PD1pEXkou3vxamif2UlpPUBm1a2vYMQUGsUTHoW81bIbar4wgvy3qDd0iLEIFErPKYcGff7WoUNjZhyWrISnRfGlw1PT/LydUhmYQkU+J2Q9LmCBwtWAW58GZMiv5uvonLUUOMETrgIkJ/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfboa9wfCYc5ab5W6EO+b9JVnLuX6067v+piEyDDefA=;
 b=Dz5t30oM0m805gtbIfnhm1l/BB189eGzx8fMcYxktqzlUllEZG0M5XxSEL9P4WtcAkdOzlRI7eD4Z8qj3kHGEawBAK98OLxACyAz/H/dINWwHX0uBtmUvjJfjhspUoxPMVN90AtOEZ8VClkndWZiKjWCaRhCCjqUYGfLefDBzOmGSOSoSzHqo9C4zjrTRFsacz2hgc2JDFGdJ2Ff4F9Qs0jwVKdYoriYCOtIYDk2vc663aVu/lSoqwt02BCPNxEF9oSQcJwbYOu4bXKAHDVU6M4UIv34oy0UinPUCko45fAsMb7bOLuPybkFiqyqM/lI8NRBxFV3iegWatdx/aWosA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfboa9wfCYc5ab5W6EO+b9JVnLuX6067v+piEyDDefA=;
 b=NEx7aPXPmCh/co9yx3sXLCgh2B8E2lG/AhGqnp02oAHpyciD/4bKQpKTEqrkqD5c9/IB5YDjixfpl2i16MLgZrfNAlM0m0hwPCmjTobBNAjf2LQQmpvcPoaGWBPJgvwj/keUeAtOqFm2bND6HwpKb7UKWxC2WV61FiLAg1FYyVo=
Received: from DM6PR02CA0163.namprd02.prod.outlook.com (2603:10b6:5:332::30)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 15:04:57 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::6b) by DM6PR02CA0163.outlook.office365.com
 (2603:10b6:5:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 15:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:04:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:04:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:03:11 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:03:09 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] soc: xilinx: decouple chip ID retrieval from direct
 firmware calls
Date: Thu, 20 Aug 2026 20:24:17 +0530
Message-ID: <20260820145459.246717-2-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820145459.246717-1-akshay.belsare@amd.com>
References: <20260820145459.246717-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: f3929c75-9a24-49da-04d3-08defecc6621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: /EE9YtMISZtn3H53rpayWv018+pV4GpcfG7DDR66jyIsss7/h68Ha3ana5WE4CLZRas0R7bXsyw9BEtP93V/eQ5D5L1apq2j47ZxdC84a421fETjU71UVNi2/wXCCT6i0RHBWce2oZWLbahk2xWVl7D0tMVfx6n7tkkXlo8liNp1Dy9C5V+/nCqOn5DSgvy8CFOYA2KqJ8/sw6g19ATyD5RyMjG7dTuio4YZGD2ddKh2fQIG9cAHsL3ec49atfGnD4gzShd/D4fD3UL1ElAl2P6bTXItLBfgY3Kju8K+RlNOCZvrrKxCgYBJXJ/6TBmV+UPLTDdVtH6BnnIyFPOAtPoBjMvPihxmyuDp8sx9KuSgC0IEipKq7v2mV79TpUjLY+vL7h+bIVLDCBY0TCOI5HvmomnkX/n7m4qKwnMrpKx0CNd4RsiX+9qc42AwPT3mpv1xmAKUpRTmIcm7kC0Dgd5k50PByTFkkhG7X1DVbic4KMggxZ3+1Omgh2/x0q0KWVN+/HfonEmF4SGdbkkZAKYdzVH6Djm7bPXv7Wf3Rz7ePZaDRPiiXOc+ZlsVqfyv07UenRPlunGFTU108sgf0VVla1QRTMZZ2w7vcWG8S3+vmLoQHz0czcQ/3f+/aD1cgVGO8ebAJ1qJ3XpjlItVrHZKgaKJOj3fbJ3nYvmcf+ayWAh6dp6x1eN2pbYHF6c9TT2XVTovF0UPza2In9tIGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d/9RQmTgGGD01sbkzLY+Kv9xmUonMtl6tFAesjWKbH8uEea1HufTA+6hOj5DrFf4HTU1dIONI9sA64xs63CZgh3peCChkT+iTfbeV5/PwkbUXg1zQJ+qP7AtfqeLh9e3aKs5nRXI7SIoA1pbakuU6q41OMnlQf1av4wv+W437FQFQBHtI872wvNym8fBqcSkxnyC4HUoboUdaVaXAF5HhDbYAzXuSmDOYYslmJORZBSyjVE89mHLSETp5gmVjHkvbylt6B+12ovrsfZ8nqfmWcu2z9ITeRNSRO3uRoFprhE/0VcjXJ+fNAnnLOfxE2t0kOmDcJmETgUE80a+aWf4AN7mAvoZQ37NvAc5y0yhqohOZMJ1w/xx/3hFQX9qjMT2J8eMy7jOmWhwoGahKZAqATs9+VD0D+LZ9FqAX8W34WkqqruGZkoRV1+atLUaXQuP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:04:57.2998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3929c75-9a24-49da-04d3-08defecc6621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

All four Xilinx SoC drivers contain identical
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) conditionals to retrieve the
chip ID. Move this logic behind xilinx_pm_get_chipid(), using a
weak default implementation for each platform and a common override
in firmware-zynqmp.c.

As part of this refactoring, move the ZynqMP weak default
implementation to mach-zynqmp/cpu.c to align with the other supported
platforms. Also declare xilinx_pm_get_chipid() in sys_proto.h instead
of zynqmp_firmware.h, as the SoC drivers no longer require direct
dependencies on firmware-specific definitions.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/mach-versal-net/cpu.c                | 13 +++++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  2 ++
 arch/arm/mach-versal/cpu.c                    | 13 +++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  2 ++
 arch/arm/mach-versal2/cpu.c                   | 13 +++++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  2 ++
 arch/arm/mach-zynqmp/cpu.c                    |  8 +++++++
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  2 ++
 drivers/firmware/firmware-zynqmp.c            | 17 ++++++++++++++
 drivers/soc/soc_amd_versal2.c                 | 23 ++++++-------------
 drivers/soc/soc_xilinx_versal.c               | 23 ++++++-------------
 drivers/soc/soc_xilinx_versal_net.c           | 23 ++++++-------------
 drivers/soc/soc_xilinx_zynqmp.c               | 21 ++++++-----------
 13 files changed, 100 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 7df7c49ac71..54d8496a5e8 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -11,6 +11,7 @@
 #include <malloc.h>
 #include <time.h>
 #include <vsprintf.h>
+#include <linux/errno.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -237,6 +238,18 @@ bool soc_detection(void)
 	return true;
 }
 
+__weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	if (idcode)
+		*idcode = 0;
+
+	*version = readl(PMC_TAP_VERSION);
+	if (!*version)
+		return -EINVAL;
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index 4907dae1108..bfe9df76b0b 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -13,3 +13,5 @@ void versal_net_timer_setup(void);
 u8 versal_net_get_bootmode(void);
 /* Direct MMIO read of the bootmode register (EL3 / no-firmware path) */
 u32 versal_net_bootmode_reg(void);
+/* Overridable chip ID accessor: weak MMIO default, firmware override */
+int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 7521d45bc1a..15b3303bd1c 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -9,6 +9,7 @@
 #include <init.h>
 #include <log.h>
 #include <time.h>
+#include <linux/errno.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -178,6 +179,18 @@ u8 __weak versal_get_bootmode(void)
 	return reg & BOOT_MODES_MASK;
 }
 
+__weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	if (idcode)
+		*idcode = 0;
+
+	*version = readl(VERSAL_PS_PMC_VERSION);
+	if (!*version)
+		return -EINVAL;
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index cb373e6fad9..bff4659eb8f 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -27,5 +27,7 @@ u8 versal_get_bootmode(void);
 u32 versal_bootmode_reg(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal_timer_setup(void);
+/* Overridable chip ID accessor: weak MMIO default, firmware override */
+int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index d72f66f4fba..fc7cdbaaa65 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -12,6 +12,7 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <wait_bit.h>
+#include <linux/errno.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -310,6 +311,18 @@ bool soc_detection(void)
 	return true;
 }
 
+__weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	if (idcode)
+		*idcode = 0;
+
+	*version = readl(PMC_TAP_VERSION);
+	if (!*version)
+		return -EINVAL;
+
+	return 0;
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index d678adf9c26..1a23f8dd425 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -21,6 +21,8 @@ u32 versal2_multi_boot_reg(void);
 u8 versal2_get_bootmode(void);
 /* EL3 clock/timer register setup, called from board_early_init_r() */
 void versal2_timer_setup(void);
+/* Overridable chip ID accessor: weak MMIO default, firmware override */
+int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
 
 int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
 int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 088cc962189..c7328970fe5 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -214,6 +214,14 @@ int __weak zynqmp_mmio_read(const u32 address, u32 *value)
 	return -EINVAL;
 }
 
+__weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	if (idcode)
+		*idcode = 0;
+
+	return zynqmp_mmio_read(ZYNQMP_PS_VERSION, version);
+}
+
 void zynqmp_timer_setup(void)
 {
 	u32 val;
diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
index d2bb10ffcbb..e791c2da74f 100644
--- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
@@ -59,5 +59,7 @@ void zynqmp_timer_setup(void);
 /* Direct MMIO accessors (EL3/SPL or no-firmware path) */
 int zynqmp_mmio_rawread(const u32 address, u32 *value);
 int zynqmp_mmio_rawwrite(const u32 address, const u32 mask, const u32 value);
+/* Overridable chip ID accessor: weak MMIO default, firmware override */
+int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index fae66ccb3d8..ad759849fe4 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -175,6 +175,23 @@ unsigned int zynqmp_firmware_version(void)
 	return pm_api_version;
 };
 
+int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, 0, 0, ret_payload);
+	if (ret)
+		return ret;
+
+	if (idcode)
+		*idcode = ret_payload[1];
+	if (version)
+		*version = ret_payload[2];
+
+	return 0;
+}
+
 #if defined(CONFIG_ARCH_VERSAL2)
 /*
  * Poll the M-PHY TX/RX config-ready status until it settles or @timeout_us
diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
index 7f06c1e70bc..d31c6deec45 100644
--- a/drivers/soc/soc_amd_versal2.c
+++ b/drivers/soc/soc_amd_versal2.c
@@ -7,9 +7,8 @@
 
 #include <dm.h>
 #include <soc.h>
-#include <zynqmp_firmware.h>
-#include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 
 #include <linux/bitfield.h>
 
@@ -48,23 +47,15 @@ static const struct soc_ops soc_amd_versal2_ops = {
 static int soc_amd_versal2_probe(struct udevice *dev)
 {
 	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 version;
 	int ret;
 
-	priv->family = versal2_family;
-
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					0, 0, ret_payload);
-		if (ret)
-			return ret;
-	} else {
-		ret_payload[2] = readl(PMC_TAP_VERSION);
-		if (!ret_payload[2])
-			return -EINVAL;
-	}
+	ret = xilinx_pm_get_chipid(NULL, &version);
+	if (ret)
+		return ret;
 
-	priv->revision = FIELD_GET(PS_VERSION_MASK, ret_payload[2]);
+	priv->family = versal2_family;
+	priv->revision = FIELD_GET(PS_VERSION_MASK, version);
 
 	return 0;
 }
diff --git a/drivers/soc/soc_xilinx_versal.c b/drivers/soc/soc_xilinx_versal.c
index c43a80df1fc..ff6eb873d8a 100644
--- a/drivers/soc/soc_xilinx_versal.c
+++ b/drivers/soc/soc_xilinx_versal.c
@@ -7,9 +7,8 @@
 
 #include <dm.h>
 #include <soc.h>
-#include <zynqmp_firmware.h>
-#include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 
 /*
  * v1 -> 0x10 - ES1
@@ -44,23 +43,15 @@ static const struct soc_ops soc_xilinx_versal_ops = {
 static int soc_xilinx_versal_probe(struct udevice *dev)
 {
 	struct soc_xilinx_versal_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 version;
 	int ret;
 
-	priv->family = versal_family;
-
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					0, 0, ret_payload);
-		if (ret)
-			return ret;
-	} else {
-		ret_payload[2] = readl(VERSAL_PS_PMC_VERSION);
-		if (!ret_payload[2])
-			return -EINVAL;
-	}
+	ret = xilinx_pm_get_chipid(NULL, &version);
+	if (ret)
+		return ret;
 
-	priv->revision = ret_payload[2] >> VERSAL_PS_VER_SHIFT;
+	priv->family = versal_family;
+	priv->revision = version >> VERSAL_PS_VER_SHIFT;
 
 	return 0;
 }
diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
index 210f9f8f8fd..3218cc416f7 100644
--- a/drivers/soc/soc_xilinx_versal_net.c
+++ b/drivers/soc/soc_xilinx_versal_net.c
@@ -7,9 +7,8 @@
 
 #include <dm.h>
 #include <soc.h>
-#include <zynqmp_firmware.h>
-#include <asm/io.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 
 #include <linux/bitfield.h>
 
@@ -46,23 +45,15 @@ static const struct soc_ops soc_xilinx_versal_net_ops = {
 static int soc_xilinx_versal_net_probe(struct udevice *dev)
 {
 	struct soc_xilinx_versal_net_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 version;
 	int ret;
 
-	priv->family = versal_family;
-
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					0, 0, ret_payload);
-		if (ret)
-			return ret;
-	} else {
-		ret_payload[2] = readl(PMC_TAP_VERSION);
-		if (!ret_payload[2])
-			return -EINVAL;
-	}
+	ret = xilinx_pm_get_chipid(NULL, &version);
+	if (ret)
+		return ret;
 
-	priv->revision = FIELD_GET(PS_VERSION_MASK, ret_payload[2]);
+	priv->family = versal_family;
+	priv->revision = FIELD_GET(PS_VERSION_MASK, version);
 
 	return 0;
 }
diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index 0e13e230914..1dc0b05a1a3 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -13,7 +13,6 @@
 #include <dm/device_compat.h>
 #include <asm/cache.h>
 #include <soc.h>
-#include <zynqmp_firmware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 
@@ -400,22 +399,17 @@ static const struct soc_ops soc_xilinx_zynqmp_ops = {
 static int soc_xilinx_zynqmp_probe(struct udevice *dev)
 {
 	struct soc_xilinx_zynqmp_priv *priv = dev_get_priv(dev);
-	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 idcode = 0, version;
 	int ret;
 
-	priv->family = zynqmp_family;
-
-	if (!IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
-		ret = zynqmp_mmio_read(ZYNQMP_PS_VERSION, &ret_payload[2]);
-	else
-		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
-					0, 0, ret_payload);
+	ret = xilinx_pm_get_chipid(&idcode, &version);
 	if (ret < 0)
 		return ret;
 
-	priv->revision = ret_payload[2] & ZYNQMP_PS_VER_MASK;
+	priv->family = zynqmp_family;
+	priv->revision = version & ZYNQMP_PS_VER_MASK;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
+	if (idcode) {
 		/*
 		 * Firmware returns:
 		 * payload[0][31:0] = status of the operation
@@ -424,9 +418,8 @@ static int soc_xilinx_zynqmp_probe(struct udevice *dev)
 		 * payload[2][28:20] = EXTENDED_IDCODE
 		 * payload[2][29] = PL_INIT
 		 */
-		u32 idcode = ret_payload[1];
-		u32 idcode2 = ret_payload[2] >>
-				   ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
+		u32 idcode2 = version >> ZYNQMP_CSU_VERSION_EMPTY_SHIFT;
+
 		dev_dbg(dev, "IDCODE: 0x%0x, IDCODE2: 0x%0x\n", idcode,
 			idcode2);
 
-- 
2.34.1

