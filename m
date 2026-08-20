Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07480C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9AFE980DD7;
	Thu, 20 Aug 2026 15:05:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lL0aiLjQ7nuc; Thu, 20 Aug 2026 15:05:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787238312;
	bh=UAL4rV9hVmK67rPumqFIJuYz4uAfoLNm0SjxXTago74=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YcGWxVB7lzwDxF7mRWoz5jvDtwaKZre0ffTWGTDK/asOLV2M2ZWj7/EPSAczKatnN
	 BVpzJaJiACvH8mbVc3uiyGHihyzyyc0poZIDDyzU2RL2KCPGUih+KPjwLtjufF7ilT
	 qvML9qaDhotjdsCQChvgmW6UkavogIi+SUNlATM44zxNDJNr5bNNsd38ZQuDsRv7R9
	 F+bfqbbS1Q59XzoukcC0gBjIOTML5lgZf121ROo1ErQGryrhHVmWwQDDaGifuf/a9P
	 r7nzNdXuHFTkiFzgCzgQIUCc4B2WlJngkP+hlAPdTraW8NjrV7l9djZYzG7XMqieGt
	 i1z66B9L8YpLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6263680DE5;
	Thu, 20 Aug 2026 15:05:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 65CC439E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B7B080DB4
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQWxkm6BLvO3 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:05:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cq/Nxu7/
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C35D80D9E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgFtVshPXGxDuC8RQd8e0S6lL8ZDExkQ0h2yCNa92PmdkuNlb3mH+3eGVl3wlMOHWhAduPURDq7QGeB2TUXgJHIttZVOGcda0F9ciHHsOHom0VRYMIR/MTXgSh/02JNU2j2vkQ40oS+SBbqDLKE+mfzk4146MYx9Xu3ZDgwujZFAfvKtDh1EGBBMV+Wij/zp71nHIIJfulmAhgSVaR8OQNF/ge2RWXPoE9vbFFH7/dsYGkLiGdj5LRmliXa6Ot/OddtBGcuK9rE4gGVrsyoAjLcbM0CsvLaknMkMgoc7lnc8XGZRi0xq5ZQ7LKR0Ps0qhJEmlhjd9SWg0GrUjs2oGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAL4rV9hVmK67rPumqFIJuYz4uAfoLNm0SjxXTago74=;
 b=KTFQCjzjdlGFN0AXADtDH/B+ZeEZ1FEgZQQhRoCARRnlT29r48OdLTzNwYb+Vb4UUQ8t0+ODSXpxGIuQl0EGz3sny9jh96i0nN7se+OT8iUstRI8m3WBSdInHPgi5mZ4Fkou69z+5Q7cvBI//W5SeGgEo2hSh4nRlOQus3VzM8iz+x95j2GXhGj07q0h5qhuuYlv7iPWmvGTym051kC6ts0xHY4PXNETzE95o6fXWfpgHlpYW4v38rBjaOcXAD7IFenJY/Hn3LS6sJFjZUzJfstfmOKYPqDZkxIQNgZcP/1J/+GGqWU/uYbBDdMXINJMz9xqeIzGauPqY+XdCGf7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAL4rV9hVmK67rPumqFIJuYz4uAfoLNm0SjxXTago74=;
 b=cq/Nxu7/SxqYEVoNq/8kUTtTJcdGtwgnaeY3+Vg2fR543aazqCDa4zozi21AwdeM6U1vgn5RfNbq4KK50PQh93vktfTpprQjeFpRuDJ/Pkyg1kWeNq1ORWb7DQ2pF6Uovgv1mJfhqcDK9IlM3Y9L2Pc22kXPzXLh5LKr0oUDCyI=
Received: from DS7P221CA0037.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::6) by
 CH3PR12MB9097.namprd12.prod.outlook.com (2603:10b6:610:1a6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 15:05:01 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:8:25e:cafe::8d) by DS7P221CA0037.outlook.office365.com
 (2603:10b6:8:25e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 15:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Thu, 20 Aug 2026 15:05:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:04:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:03:30 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 20 Aug 2026 10:03:28 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/3] board: xilinx: decouple PGGS boot index read from firmware
Date: Thu, 20 Aug 2026 20:24:19 +0530
Message-ID: <20260820145459.246717-4-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820145459.246717-1-akshay.belsare@amd.com>
References: <20260820145459.246717-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|CH3PR12MB9097:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d64d92-df47-492f-ee83-08defecc680e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: JfXCbB/BWUAwAZdPApVRM5Jmz+kpYXlMcO6XbMZR2rhW5pNPGuqmG4GUKEkjP5RQ0HNg3kgfCvhS3AJokWWjwcNXGkTRaw4nPwj2O/ED4gTDp8VeLj0Y8GOn8E2Wm/yFeWc+EFcoZZibKlBHwM1d/CPEh77eIIpOG8/tca0cWPovXCc0OWYIWq6wKmUgC2ypboFDX8wOJYtkK4ekaAzgoQvG5DV8T7HhZowcj6rEwU8rhHfI5VNYDPb8ul8cnP0fsTHmAtsYv0+SDemiaNE3/67ToN1PWjKQb8sTJvzEZplcaXs2l/vLrx06pfnlptGi5RbfjypZCTszhYgLTFxlBXEwEi4IqTQmNGWr4owaUgr4jMsDj8Usyi3xwew9xK8DCavy09pxt40OCRHvNn/OAcc206EcIDj8Q2vOAw0tjvsmwlwghcW9ELLveEXSq0rSCznslPD5cBFkujUdwSVJ2BtDQZkwt+3axQtTCZ8qg3eWbQOzW8ycjZ++DKDpSViasOr1+EXCHZmOShh8zvTUTcTqoWgPN2qh8W3CvI9XThV4EhMXWhY8ucQJGEu2ZdZnx3WH8tPj4SmaEuvKxfOu8if89AG6edvAO2iYvJh7Afe9udlnQHU9lRkgZsrTEQfIr8jwB0uBMUmKrH0rbrtNwR9auWyjPtSDwU2apbdhSINaUZl5ykwIbcpyPDsiMipMHJ4WQpGhk0DCUBejKh1Z3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GYK71ulaNFoHoMYp4qWeZakTjwf4fkIU3TL8vvmbDyFPBng82Kcstw3Doeej/gJ5KFPc2LSPPmJ405uWml7Dt1aHuYmmKKBIuA5havPytgl1tDgIRvdTwsb8D3nr9/kQbnkq6ksgiR68yX0xcGTrZXjOC0UVL4slq8DfxwANH2oBLuZYaK27ek5aw3Iu/HEawPG3pamTrp+aRNbw6TUX6vEdqvVKpQy8ivaDlWTwtJLTi2c6hfVRv93a1YGCZIJVw9eLRgHxYeeFplDCwgnbGfSlVlE24LuRRg6IY3YCmSIuBmkuB8azAOtQhjFGtHcI5R0OAlz7+rzNSN3qUaWddXfrgMTwVqlT+3CdCsYqSQzC8WGPrinFp1VaTMAbpKM0k2WXZoYKzoKDXVbXmL1f/50n5+P+crWT5l3WoTvs74rz8qZ3i6jPuf3iaE6tEabX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:05:00.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d64d92-df47-492f-ee83-08defecc680e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9097
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

Move PGGS boot index retrieval behind a platform-specific helper
instead of selecting between firmware and direct register access in
plat_get_boot_index().
 
Add weak default implementations for Versal and Versal Gen 2, and cast
the register address to (ulong) before readl() to ensure correct
handling on 64-bit targets.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 arch/arm/mach-versal/cpu.c                     | 5 +++++
 arch/arm/mach-versal/include/mach/sys_proto.h  | 2 ++
 arch/arm/mach-versal2/cpu.c                    | 5 +++++
 arch/arm/mach-versal2/include/mach/sys_proto.h | 2 ++
 board/xilinx/common/board.c                    | 6 ++----
 include/zynqmp_firmware.h                      | 1 -
 6 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 15b3303bd1c..a4ee51ef0d6 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -191,6 +191,11 @@ __weak int xilinx_pm_get_chipid(u32 *idcode, u32 *version)
 	return 0;
 }
 
+__weak u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr)
+{
+	return readl((ulong)reg_addr);
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal) = {
 	.name = "soc_xilinx_versal",
 };
diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
index bff4659eb8f..771b8cd8cbc 100644
--- a/arch/arm/mach-versal/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal/include/mach/sys_proto.h
@@ -29,5 +29,7 @@ u32 versal_bootmode_reg(void);
 void versal_timer_setup(void);
 /* Overridable chip ID accessor: weak MMIO default, firmware override */
 int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
+/* Overridable PMC GLOBAL PGGS register accessor: weak MMIO default, firmware override */
+u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index 24a02c38462..404250f2d44 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -338,6 +338,11 @@ __weak u32 zynqmp_pm_get_pmc_tap_usercode(void)
 	return readl(PMC_TAP_USERCODE);
 }
 
+__weak u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr)
+{
+	return readl((ulong)reg_addr);
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index fcc2e75c89a..64626bac24e 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -27,6 +27,8 @@ int xilinx_pm_get_chipid(u32 *idcode, u32 *version);
 u32 zynqmp_pm_get_pmc_tap_idcode(void);
 u32 zynqmp_pm_get_pmc_tap_version(void);
 u32 zynqmp_pm_get_pmc_tap_usercode(void);
+/* Overridable PMC GLOBAL PGGS register accessor: weak MMIO default, firmware override */
+u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
 int zynqmp_pm_wait_mphy_tx_rx_config_ready(u32 timeout_us);
 int zynqmp_pm_wait_sram_init_done(u32 timeout_us);
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index f45b879736e..ac309ae7336 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 #endif
 #include <dm/uclass.h>
 #include <i2c.h>
@@ -752,10 +753,7 @@ static int plat_get_boot_index(void)
 {
 	u32 val;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
-		val = zynqmp_pm_get_pmc_global_pggs_reg(PMC_GLOBAL_PGGS4_REG);
-	else
-		val = readl(PMC_GLOBAL_PGGS4_REG);
+	val = zynqmp_pm_get_pmc_global_pggs_reg(PMC_GLOBAL_PGGS4_REG);
 
 	if (FIELD_GET(MAGIC_MASK, val) != MAGIC_NUM) {
 		log_err("FWU requires PMC magic number 0x%x\n", MAGIC_NUM);
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 0293bd15a2e..a60d33b02ab 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -466,7 +466,6 @@ int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
 int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
-u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
-- 
2.34.1

