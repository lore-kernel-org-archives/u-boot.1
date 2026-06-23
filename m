Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED26CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BF584A06;
	Tue, 23 Jun 2026 14:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FlqhiP3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3019A849C5; Tue, 23 Jun 2026 14:54:36 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43F6849F0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPhAWm/yUyoycZlPaCTE9NRhpNOAHA0WNNYABpQyfijg6+2A7ZYHo+9pI17hZZ09vuTTPzPBAXZE9DI8ZDVjhT1+/LKwyHd2oSZ2si/kBpsan9O49KjXJVo/N1nXaPRIfIHttvWUPc+i096Ycg4TLxjwMD2ii5pAGuZ7bStidkNOFwUoq06GDMbADMkJSWNFTmZ1fYdx5VHKAVB/7GJ/H5O99jTs2IyDnQ0AVuHyZTrFfJtD/dO3D/WKnEewNeceAf3+7nOck/ss8IKYdNa3pUBcOfvUyGZrRjRjH2Y9/L3k2ZOk3HYLd6s7TCC91eapMnsnauwEDKue36mYHSPVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq4DTrG0OoP8MeuHI5fH5U8cW1amJ4xEvghFvc9zy08=;
 b=sg7vt6s/9raHazpRmET+yDQACTsMcgTHYZDXNCkvUscgLVk0Ctt9J3CJFGSnzNe+gkrepME7xd0WX++mEg8J/Eu62sqSht3gsJDJ80koCJSViZrv5JJHct7bK/Bd1Q+AxIovk2Ck6gMqVWSFDacih32v3/uYv1fYFv+tLqdLzrK+RnFW/kjNqacF72FzlJosq020jzvZYWwVbl/l93oK48bJb5MOtdjoPI8cIgEvOiEoLFk9OiRBtWxex/gmnWypkq1tFVuFoO5K/xge4seDJdwJ+0m+NRQqurL9QMJg41xIydxts707NGz4tL2NqrsupXG1jvtD5ROHoPwefFiXGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq4DTrG0OoP8MeuHI5fH5U8cW1amJ4xEvghFvc9zy08=;
 b=FlqhiP3yIoLtIQQcBlGe3WCkaeYBElEYQuqxu/BiGYMeFRNoYgye57gjAh26aNU6yiNru4AJdR2Nl4TQzq7sxouYSsJS5Y/n+op9Y0sASaHyWiqXPMm4slYAx91zHq06X8LWj7nU1lkLkR8fUjiB87gFqWoPFJEUUUtOi+Vgfg8=
Received: from CY5PR22CA0001.namprd22.prod.outlook.com (2603:10b6:930:16::15)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 12:54:26 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:930:16:cafe::2c) by CY5PR22CA0001.outlook.office365.com
 (2603:10b6:930:16::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Tue,
 23 Jun 2026 12:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 05:54:24 -0700
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Sean Anderson <sean.anderson@linux.dev>, Senthil
 Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 02/18] arm64: versal2: Decouple multiboot register access from
 firmware
Date: Tue, 23 Jun 2026 14:53:27 +0200
Message-ID: <0033a1fa8efb4ae0c3ac6a6f5c5c1b4e0f22f02c.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4652; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4tce7NV6UuZC6HpcMCydNYszT1PmH0n2b72tb+3mQfs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNT7jeMZ174PF8Zd3DhsZPF+glLhn0b01hkXxnnpf1
 P6zeuw36ihlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJnIxn+Ke5c4H0Sc40F/fL
 O5jTfzGX1za4Nh1f80qSTzhyA68f52dGhnuyCzeyHP0322Be283P7Xnn+w6uqXButTczPtYb/Nn
 5EhcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4a3fbb-8385-4b4a-8f72-08ded1268e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|32650700020|1800799024|36860700016|376014|82310400026|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: R1Ht5b2nH28bGIrSZ4gQS+97waZDRLNDMLO8hCymdo9FeP6pKdVJvEbl1jk/MGtA8Qgp/VfS8LYIDveDiDtpVfSNF1eK+CJefC+1xZp7PBg7RjmmctwDDJmLKAZFano3+n9MN1OWtTZy153Xh8t6qFwUcmpLrdv8zihG2cjSZtr3FZLetXBjxwK0RkadzT+uNwUxC7yffPuhJDcLtuFp1GnYIxSnTEVmA+96FZRa4AOPymfIztlugB3/zud3RK9Fvm8BdOPNtH6jL+ZLRNz6UxzPF4OpWhjZNsj90nNl9jnZb2RCcQFhdwlFCpyF448JCiPCA1dQmd18XwkyOiMFpzj/p3TyDIAtznln8uRTAXrpH0Bj1duxIehXV+oq2M33iNW1Upj6NR/4fN1H4PADtVtGN2AvzKwOmnOiAe9FdKgRFz2KwRdvhfASPflN+zc0QcX6wej6gZ4MW9+nVlhDYxJJw99AD3W2g4whtCMiH5LR9i0F06oWdJSVF3yxiHKh09nBXF6NxwShz+SiPGa0OaEkMlY+6y1e/h/wiD04k/1zGtSdmrMzQZJBD6xUFPH7Pt2cCVjeGxhXYNeySvtGbmXoIMh0Y5WezvdXEwV9ixd6vlVBPyJyrpKZdpb0E0sOsjGUBHRaEG82AoyoEAlW9VA8GaCtHiKXsxNTJMIQIPjROXAzWCw2mHsRzPKqlbcPR4G54kBPZwV/7ovNkNeiVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(32650700020)(1800799024)(36860700016)(376014)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0upXRYm+ScizCIR4wQeEqJfNlpQWjX28ZgdqrwgARAcGVlP2Dl610h7BqigJB7xDEjNLkNKG8Wyfg1tA8Hq9X65wwzbcY4SGx2O2jRhndd7ilVV2MxMSWTBKzniWmFseYCJLmj9lmj3rh5Z32gu3jbsw5ZAw4D0MVXUV0JHgwK+CEzBq9kpRmxW12vj/wT4aJUq/j+SPGIeIgYS3uRpljSUlLoWJF1flkXJO7VgiCnUOeeY44MyutNKvumVnyRgd2Cq3/NQApps26XJ4mOp2aebhgPbekEQP+qK1KUIAmFzzPDR+hAVd4KhMS7ZNdxvwYFzPFOF9NFA0iMOmurSbYkFBFxbfre8a3SiJgYrQvn6oSVdlmM5qypIhHXATmXsGPt1RmcR4/ZsBgVGeEcvXN9LXVYvALM8i0QmcBzDeSYYcVRCgcwhSlheL+pYSonYj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:25.6702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4a3fbb-8385-4b4a-8f72-08ded1268e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737
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

versal2_multi_boot() in board code selected between the firmware call
zynqmp_pm_get_pmc_multi_boot_reg() and a direct readl() based on an
IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) check. Generic board code should not
carry firmware-specific ifdefs, and this becomes harder to maintain once
SCMI introduces yet another access method.

Introduce an overridable accessor versal2_pmc_multi_boot(). The weak
default lives in arch/arm/mach-versal2 and performs the plain MMIO read
(used at EL3 and when no firmware is present). When CONFIG_ZYNQMP_FIRMWARE
is enabled, firmware-zynqmp.c provides a strong definition that issues the
firmware call, falling back to the direct read at EL3 where the SMC path
to firmware is unavailable. The shared MMIO read is factored into
versal2_multi_boot_reg() so the firmware override does not duplicate it.

versal2_multi_boot() keeps the generic JTAG/QEMU workaround and simply
calls the accessor, so board code no longer references the firmware
interface and the now unused zynqmp_firmware.h include is dropped. The
firmware-vs-MMIO decision is selected at link time, and adding SCMI later
only requires a third strong definition with no board-code changes.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c                    | 10 ++++++++++
 arch/arm/mach-versal2/include/mach/sys_proto.h |  5 +++++
 board/amd/versal2/board.c                      |  9 +--------
 drivers/firmware/firmware-zynqmp.c             | 13 +++++++++++++
 4 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index e264ef0f2924..0c7a5040cffb 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -128,6 +128,16 @@ u64 get_page_table_size(void)
 }
 #endif
 
+u32 versal2_multi_boot_reg(void)
+{
+	return readl(PMC_MULTI_BOOT_REG) & PMC_MULTI_BOOT_MASK;
+}
+
+u32 __weak versal2_pmc_multi_boot(void)
+{
+	return versal2_multi_boot_reg();
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
index 3ed0b25be802..e0576754836a 100644
--- a/arch/arm/mach-versal2/include/mach/sys_proto.h
+++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
@@ -13,4 +13,9 @@
 void mem_map_fill(struct mm_region *bank_info, u32 num_banks);
 void fill_bd_mem_info(void);
 
+/* Overridable PMC multiboot accessor: weak MMIO default, firmware override */
+u32 versal2_pmc_multi_boot(void);
+/* Direct MMIO read of the multiboot register (EL3 / no-firmware path) */
+u32 versal2_multi_boot_reg(void);
+
 #endif /* _ASM_ARCH_SYS_PROTO_H */
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 6e4f0c6e9b8f..06d144db4f02 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -29,7 +29,6 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <versalpl.h>
-#include <zynqmp_firmware.h>
 #include "../../xilinx/common/board.h"
 
 #include <linux/bitfield.h>
@@ -195,18 +194,12 @@ static u8 versal2_get_bootmode(void)
 static u32 versal2_multi_boot(void)
 {
 	u8 bootmode = versal2_get_bootmode();
-	u32 reg = 0;
 
 	/* Mostly workaround for QEMU CI pipeline */
 	if (bootmode == JTAG_MODE)
 		return 0;
 
-	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
-		reg = zynqmp_pm_get_pmc_multi_boot_reg();
-	else
-		reg = readl(PMC_MULTI_BOOT_REG);
-
-	return reg & PMC_MULTI_BOOT_MASK;
+	return versal2_pmc_multi_boot();
 }
 
 static int boot_targets_setup(void)
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index ea14ed4ef950..70d205ff3ef9 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -7,6 +7,7 @@
  */
 
 #include <asm/arch/hardware.h>
+#include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <cpu_func.h>
 #include <dm.h>
@@ -16,6 +17,7 @@
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
 #include <asm/ptrace.h>
+#include <asm/system.h>
 #include <linux/bitfield.h>
 
 #if defined(CONFIG_ZYNQMP_IPI)
@@ -326,6 +328,17 @@ u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
 }
 #endif
 
+#if defined(CONFIG_ARCH_VERSAL2)
+u32 versal2_pmc_multi_boot(void)
+{
+	/* At EL3 the SMC path to firmware is unavailable, read directly */
+	if (current_el() == 3)
+		return versal2_multi_boot_reg();
+
+	return zynqmp_pm_get_pmc_multi_boot_reg() & PMC_MULTI_BOOT_MASK;
+}
+#endif
+
 int zynqmp_pm_feature(const u32 api_id)
 {
 	int ret;
-- 
2.43.0

