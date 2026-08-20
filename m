Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7D4C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D2AB80DD9;
	Thu, 20 Aug 2026 15:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdVLFTGstgZr; Thu, 20 Aug 2026 15:05:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238311;
	bh=TVeSUpAYgr+E2BuWNYm5B1ha6BEHd7qpxKdFlzkMr80=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mxXJQek+y793t8xlsf233T/gRx1s/cklLLlfXFAOgbvRs3L9QLgi+VKjmaofxsZhn
	 NtKFVntlZyCV3yKngEdo7JhSl/OZIhjHa/9dHMrnPD1Kf3NMUtMr8NjPwvf+cmzVpQ
	 mOxXsOLQHJ0qsMAF/PqiEstCd4waiQbGdjd2wFfdI1D7QNBcLcCDEvxupgIh2QqEr6
	 G6v+DCDFLUYDG7QayCqSlZzeoI/OpG9R/Cdv+oegj5lGz1I/OvVM/xE+7sQ4xncwPd
	 ofFhoHNUhKZQknp2pdmrW1HJG2I3TIZ0OPLHCwWFY9/OxLe51Mri21QdCJYxVq5bBP
	 Ii25R/PfbWmYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36ECB80DC9;
	Thu, 20 Aug 2026 15:05:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D768639E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C96D140329
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQBmzN3sbFnb for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:05:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=1XmXufnm
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB8C64031A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMN27+oRMJ//znrQfpGyYcZXfug6BRGWx2gHOoGSeOOHjT+cB6VjKtnHTfHa1h5cmEv9VXrG3RtTMmqDsVEtiIP3r/ezuPOtkq6aN5+7y2saIiCFdgUG/ONOamE+mO7w2CCynn3L95zgLHORE5JzMMSxxxPdodfnc1MSKQA2jwd1NTypiFWDsYGBvq5jAh1vYEuW0HK/zxFwm+f6+V8310TC2vaf9jGYwPESFIv2h08kwDnXRrVjGSBCNRZ2+hV8EUVAiu5vEeVLTyqqLH/0zsX09lSa3R6J12XJ1iNtCkr3C7GA5zLwcMH4JcLjeyuqHQuwv8YrHC45+7mRs+ovrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVeSUpAYgr+E2BuWNYm5B1ha6BEHd7qpxKdFlzkMr80=;
 b=ggC7RXkxmhIludr6uWyT3ikhf1TG1f1laI4TfLfDRKYuGH6nAw82ffM+tQP/fZCnythbOvC5jTRqesMlqFyxmHH97RhXO98j/pgtuMSq5KjWMgsHRziyJ6dRf7NIfXei6UCZh3QqbE2C55wVJ08aOrUrgQz/D/36hYmPgZpCywQUem2o8nwEY344kF0kjmF6heU2MRZImVoZyAKOS7EJ5kkDNbZNHtM/K4Sb86QC7ckobIUBY7Ha2z5qKlxCMLkffaEJABhgZnOaJOnbn4enBfB45C6O+3/PHJ9Hk5IYs+ivB+QQDP/wr0D+n3T7XnU0vqytDojDxXojUGLEqqARxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVeSUpAYgr+E2BuWNYm5B1ha6BEHd7qpxKdFlzkMr80=;
 b=1XmXufnm42BMJQuqXFaP76Ct4SNxjHJoLCDRgIshYQavXLZkayO8+RYScK1/NwxfEu3L0UWfziV196tS3o9oZuEadhTOwfEuMb/uQmnL+8Z4Ch1ghs9Lzkqx3tPnH+brISSwNcL+Yta1+sRdYD2rZi5CFYUVm06R6STD4T4bviQ=
Received: from DS7PR03CA0278.namprd03.prod.outlook.com (2603:10b6:5:3ad::13)
 by SA1PR12MB6972.namprd12.prod.outlook.com (2603:10b6:806:24f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 15:04:59 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3ad:cafe::30) by DS7PR03CA0278.outlook.office365.com
 (2603:10b6:5:3ad::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 15:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:04:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:04:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:03:22 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:03:20 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/3] soc: xilinx: route PMC TAP register access through
 firmware
Date: Thu, 20 Aug 2026 20:24:18 +0530
Message-ID: <20260820145459.246717-3-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820145459.246717-1-akshay.belsare@amd.com>
References: <20260820145459.246717-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SA1PR12MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 8694af77-acd6-4961-400c-08defecc6751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|3023799007|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: k3YzDESTSrIOpDS6qCeDo+SndrQG2mSYqKiSmjZ16bWHs5TEBlgVIPH4RjZhTwnqEPWLqN0eQg7Gsw/C1rKyUwSwkaFnqojhPKSZnYr9YR6VeV1vnUrJ6cAU/mzVKR8MVqd5Ub1GUXbaHtx/kzXxWHq+SfoO84ruErDmN5Fo18VcCnV9nNYge0On/lOosxENoXlTZKJOBwFsSxwr9eF5PM+k/z8G4qLJB143/4G/tgA6ehSBIFlN04oy7WzYDUb94nIxpK/8MjeYDCGtGiC3k1StUJbedNSj63jWopFAfGCWRPqn1RcWpFAw0siqvz1r7m5jTm/8VzRmMNduSzTouGSY96zLrey8W7bt08BcZNkfQrupvoDHnkegi+mvR7XIViOkwnc1LKUaryhhSaP9SIYTCvF0IwntvuyF9oa1ALj+LzfhEJ5UjFL2QoBM1y9GFn1IWeld5j4AZfn5LgWLvh4cR0/RjVIif5bihHil2rvB9U/cykomYgdbjywjfew/M3tF7ee5Mui3o/Iz2gryWDn74cY4/FFyvzqJ625cj8Adl/VLIAw1YxgSCxoY+pvAqJxVgpxiOStzhTGwP1peWhlCZYAG7KdxJuseAYRElR2WCm4qurGogcDGuY0qRTWuB6epvhrmeFzhMGaGjbdChS8gO/YdD3a0htd9yc6m2VNCc01Dy6QcbfxASdYX5VCk7JS3H1o6P69QuaWpV/Ve1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(10067099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AO8dgcPO36psvNKEA3msIubJ8ZG/gn/2W3pFT/oVRgke6KoRxCBDYsrFkLfzisA3ZxjzvsS1Mc5A0NjwvHAljri2VmxhYLvV53Q7xdIc0JP5Zh4tOJp+EoN2GsSOK574A6oJafoBSwgF/d7PKRBiQuluVOWbpDw9b6msrRa6f502kEjz0XwI9FIwhYjPxBFABDt/+ZkBBPVCBO+xc8k2lW6y8GSTfx5IRfZDKawVWI5wLmQpN7F0Yp3mtVCAkM6nlfNYdHIiaakboEYTdsAZ8CXS51Pg9MTYGQdZfnk8HyyVSD6VVcbx6a+sfT132G8TTl4bXSkg+i6ONt/0FYnCpLUBLsUAv8op5kOn92I6rqADqC0DXEK/8urxU2OrhPOUH7+ac1DvzPjjEBwbXI5zk1NG/wM8xlcV9ed18wRBGi4IarkUHEE78LXeObQSrmgI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:04:59.2925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8694af77-acd6-4961-400c-08defecc6751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6972
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

The Versal Net and Versal Gen 2 implementations of soc_detection()
currently access the PMC TAP IDCODE, VERSION, and USERCODE registers
directly without any firmware abstraction.
 
Introduce dedicated helpers for each register access:
zynqmp_pm_get_pmc_tap_idcode(),
zynqmp_pm_get_pmc_tap_version(), and
zynqmp_pm_get_pmc_tap_usercode().
 
Implement these helpers as weak platform defaults, with a common
firmware-backed override in firmware-zynqmp.c. The firmware
implementation accesses the registers through IOCTL_READ_REG using the
new PM_REGNODE_PMC_TAP register node, following the same mechanism used
by zynqmp_pm_get_pmc_multi_boot_reg() for PMC_GLOBAL register access.
 
This change removes direct PMC TAP register accesses from the SoC
detection path and provides a consistent firmware abstraction across
supported platforms.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/mach-versal-net/cpu.c                | 21 ++++++++--
 .../mach-versal-net/include/mach/sys_proto.h  |  4 ++
 arch/arm/mach-versal2/cpu.c                   | 21 ++++++++--
 .../arm/mach-versal2/include/mach/sys_proto.h |  4 ++
 drivers/firmware/firmware-zynqmp.c            | 40 +++++++++++++++++++
 include/zynqmp_firmware.h                     |  4 ++
 6 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 54d8496a5e8..5ba2295e4f8 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -193,13 +193,13 @@ bool soc_detection(void)
 {
 	u32 version, ps_version;
 
-	version = readl(PMC_TAP_VERSION);
+	version = zynqmp_pm_get_pmc_tap_version();
 	platform_id = FIELD_GET(PLATFORM_MASK, version);
 	ps_version = FIELD_GET(PS_VERSION_MASK, version);
 
 	debug("idcode %x, version %x, usercode %x\n",
-	      readl(PMC_TAP_IDCODE), version,
-	      readl(PMC_TAP_USERCODE));
+	      zynqmp_pm_get_pmc_tap_idcode(), version,
+	      zynqmp_pm_get_pmc_tap_usercode());
 
 	debug("pmc_ver %lx, ps version %x, rtl version %lx\n",
 	      FIELD_GET(PMC_VERSION_MASK, version),
@@ -250,6 +250,21 @@ __weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
 	return 0;
 }
 
+__weak u32 zynqmp_pm_get_pmc_tap_idcode(void)
+{
+	return readl(PMC_TAP_IDCODE);
+}
+
+__weak u32 zynqmp_pm_get_pmc_tap_version(void)
+{
+	return readl(PMC_TAP_VERSION);
+}
+
+__weak u32 zynqmp_pm_get_pmc_tap_usercode(void)
+{
+	return readl(PMC_TAP_USERCODE);
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/arch/arm/mach-versal-net/include/mach/sys_proto.h b/arch/arm/mach-versal-net/include/mach/sys_proto.h
index bfe9df76b0b..877a7e6a0c3 100644
--- a/arch/arm/mach-versal-net/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal-net/include/mach/sys_proto.h
@@ -15,3 +15,7 @@ u8 versal_net_get_bootmode(void);
 u32 versal_net_bootmode_reg(void);
 /* Overridable chip ID accessor: weak MMIO default, firmware override */
 int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
+/* Overridable PMC TAP register accessors: weak MMIO default, firmware override */
+u32 zynqmp_pm_get_pmc_tap_idcode(void);
+u32 zynqmp_pm_get_pmc_tap_version(void);
+u32 zynqmp_pm_get_pmc_tap_usercode(void);
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index fc7cdbaaa65..24a02c38462 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -290,13 +290,13 @@ bool soc_detection(void)
 {
 	u32 version, ps_version;
 
-	version = readl(PMC_TAP_VERSION);
+	version = zynqmp_pm_get_pmc_tap_version();
 	platform_id = FIELD_GET(PLATFORM_MASK, version);
 	ps_version = FIELD_GET(PS_VERSION_MASK, version);
 
 	debug("idcode %x, version %x, usercode %x\n",
-	      readl(PMC_TAP_IDCODE), version,
-	      readl(PMC_TAP_USERCODE));
+	      zynqmp_pm_get_pmc_tap_idcode(), version,
+	      zynqmp_pm_get_pmc_tap_usercode());
 
 	debug("pmc_ver %lx, ps version %x, rtl version %lx\n",
 	      FIELD_GET(PMC_VERSION_MASK, version),
@@ -323,6 +323,21 @@ __weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
 	return 0;
 }
 
+__weak u32 zynqmp_pm_get_pmc_tap_idcode(void)
+{
+	return readl(PMC_TAP_IDCODE);
+}
+
+__weak u32 zynqmp_pm_get_pmc_tap_version(void)
+{
+	return readl(PMC_TAP_VERSION);
+}
+
+__weak u32 zynqmp_pm_get_pmc_tap_usercode(void)
+{
+	return readl(PMC_TAP_USERCODE);
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index 1a23f8dd425..fcc2e75c89a 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -23,6 +23,10 @@ u8 versal2_get_bootmode(void);
 void versal2_timer_setup(void);
 /* Overridable chip ID accessor: weak MMIO default, firmware override */
 int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
+/* Overridable PMC TAP register accessors: weak MMIO default, firmware override */
+u32 zynqmp_pm_get_pmc_tap_idcode(void);
+u32 zynqmp_pm_get_pmc_tap_version(void);
+u32 zynqmp_pm_get_pmc_tap_usercode(void);
 
 int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
 int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index ad759849fe4..7a922fe544b 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -510,6 +510,46 @@ u32 versal2_pmc_multi_boot(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_VERSAL_NET) || defined(CONFIG_ARCH_VERSAL2)
+static u32 zynqmp_pm_get_pmc_tap_reg(u32 offset)
+{
+	int ret;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
+	if (ret) {
+		printf("%s: IOCTL_READ_REG is not supported failed with error code: %d\n"
+		       , __func__, ret);
+		return 0;
+	}
+
+	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_TAP, IOCTL_READ_REG,
+				offset, 0, 0, 0, ret_payload);
+	if (ret) {
+		printf("%s: node 0x%x: pmc_tap offset 0x%x failed\n",
+		       __func__, PM_REGNODE_PMC_TAP, offset);
+		return 0;
+	}
+
+	return ret_payload[1];
+}
+
+u32 zynqmp_pm_get_pmc_tap_idcode(void)
+{
+	return zynqmp_pm_get_pmc_tap_reg(PMC_TAP_IDCODE_OFFSET);
+}
+
+u32 zynqmp_pm_get_pmc_tap_version(void)
+{
+	return zynqmp_pm_get_pmc_tap_reg(PMC_TAP_VERSION_OFFSET);
+}
+
+u32 zynqmp_pm_get_pmc_tap_usercode(void)
+{
+	return zynqmp_pm_get_pmc_tap_reg(PMC_TAP_USERCODE_OFFSET);
+}
+#endif
+
 int zynqmp_pm_feature(const u32 api_id)
 {
 	int ret;
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f753a67ac27..0293bd15a2e 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -533,11 +533,15 @@ extern smc_call_handler_t __data smc_call_handler;
 
 #define PM_REGNODE_PMC_IOU_SLCR		0x30000002
 #define PM_REGNODE_EFUSE_CACHE		0x30000003
+#define PM_REGNODE_PMC_TAP		0x30000005
 #define PM_REG_PGGS3			0x30004003
 
 #define SRAM_CSR_OFFSET			0x104C
 #define TXRX_CFGRDY_OFFSET		0x1054
 #define UFS_CAL_1_OFFSET		0xBE8
+#define PMC_TAP_IDCODE_OFFSET		0x0
+#define PMC_TAP_VERSION_OFFSET		0x4
+#define PMC_TAP_USERCODE_OFFSET	0x8
 
 #define PMC_GLOBAL_PGGS3_REG_NODE	0x1824C005
 
-- 
2.34.1

