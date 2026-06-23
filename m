Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B34CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF0C84A48;
	Tue, 23 Jun 2026 14:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5YH1Tnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43FFD84A4A; Tue, 23 Jun 2026 14:55:10 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD6484A48
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X46RtCIqQydB3wrcY4J4TV/BzCQM2GvffpGljTNtnIJ8Yu7MtNgtRtyPISiiYFPGzpSNSoa430eQvxQUd+JXsBscRSltSn7moJfXDjbMOKk7SQCPhKDFRCYQ/h7pGLrud1GF2EOLk9xWoPzNS50yyqbcP9bYfDexxIRl8aVuokkMU5UNlI4iRhPmH75pWBhwJHTPcdl9nMrbmu91jiJEu4Mvu3Rt8EwcSWZafwUrJMFUfEoULHk/0BpCarz/M0d3um1chAhXJg8rd/rT8ad24Y4oQqjIemIB4IMREYSY7Wkazdm4pqkKYbiObYGmfsZeXkRIsbucsorDxRrtiNvkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4yBeCJrTbTSUCamW65CB4Oq7wtaxMk7yazMwoqhnYs=;
 b=udza7PrKyzdoOg/mDPObvYM30wzLucVMy2hRBdfsu3ySx9+6TtGYEeGKBcDBWPWvL0nrXKamdovi+K2OCmTKyHxcg0wqzv47xFROUjb9mit5I5nuSYoVfk7KuZBC4AX4BMvqzrtHjpC9yigT6FlNmOS5NUiiZRXU1OP+aa9kG0/1Jjrw9asbacCXI4Np+UAdhh27gIqLkVWkmDwLRvAWihnhbYSp2MRE7164shsl8dOydrR28gznDIe+ao1gcejneGpGqeOP74DFZQGYO5YR9jISSvUz/QbTynsuoMr497WwCmYis3Dzwtjmv9g86Lnhmd8CIKTBJ+DDtOa/Smqtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4yBeCJrTbTSUCamW65CB4Oq7wtaxMk7yazMwoqhnYs=;
 b=R5YH1TnxTN5WXA/HadtUVdQxQ/KxGW8SwFZD6dxSzODqB39nBlFRqGbFpkM+L62dUA/Fy684U+3+s0frOVaAoo8S85KU97NnCMFW8+UBaNq/camyhAFmbQVxSTMYLG4m952K22olsXPBwHi6A/x++p0BITPWBZRF2sMnmHgORxs=
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:54:56 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::69) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:54 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:54 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Francois Berder <fberder@outlook.fr>, Padmarao Begari
 <padmarao.begari@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>, "Pranav
 Tilak" <pranav.vinaytilak@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH 10/18] arm64: versal2: Move SoC detection out of board code
Date: Tue, 23 Jun 2026 14:53:35 +0200
Message-ID: <c332ab27f66f1c808f32a4bcb453d9e8da543331.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5469; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=31hI8zQhHz2RaTfTlANVupomCdTPRJo29tCM87KHCIs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb65+jylOZY/LfT6m6t372646/NAIVR45RUFPefTL
 07xFca1d5SyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEXE8w/E8sE7v86fjhntUL
 NHpj63+rnbxTMe/WZe3zSl8UVlRoW7Uz/I+6e4Lvpr9QwAvG5PmNLK4zedbrL/pQdI+BY5LQWfG
 /uvwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1d60a6-f7af-47b0-b0e2-08ded126a017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|32650700020|23010399003|376014|82310400026|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: EtTxFidBd5JJE5inzNE9plfRn+dzbQHvbzsOgsIqTfDM7H6SGt579IXYOHfYm5OUzG8AN4f2HLfKAtPJm6DZ7gByj2UR4PG7zJrHZgCbbimwI3wCrDgbT8Ts7iLUaWDrPIWngFzSDlAlcOa8XX4PkeiWkDsnt1NqjePfph0wrUvgybjmbqWyiZmMiryFFUgc+ZrvtGL4+eo/8rYyF0Geltp/8QVbfFDa3Emxj/m/Whr7Y1CG2yNH/T5/9qwYOXfF5AkjOK0YzciTUtfcwI04uzqBSBqQvD2FM0TwJzAWAb+l+1/qvx/JIZMpbJaaJJu4nj1z3xW10zgX95lT6qotQwPxiQhwuJN/0RjHUFQtcCb36Xhd8yphRjKcMch4fO88CkMNbg8CtffN/o5iruvGxoQVSS5ONn2KTzq0RYqKaZD0//+JyDCsTPJ5Eww3iX61PSoGnrciIgFayyPSS+jHbAbYQH6xbJ4AzgBKkR32kLRHpRBJz7cjxxxR+o7gAjp48b7nPQRHxn9nIGXdp/dALn+9gf9iJ1LJf+rWfS03lFQKcCP0+yA+Tki6dTz9MMDjq65UL+yrI68DR2VhL1uzB/11pImBGUSG3xUkrrxNp74F9uO+WkZX9pGfsmbGkRDqcAOamPygb/de1igknHzUfRnOtcyMKTrEHVZqaESTfAEv2pPF85a+zt0EaqTfQ2P8WtkN/fkOJYRbVTKEh+jEMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(32650700020)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mCYfLPYtZiTHR3ZvaTprneRYP+ocakLpDkbfnjKRvh8YK4XyXJKFlk3oZL8vwrVILJ7Dcix0M8hGWMdSJD6uQI1/lJD/7QJuUmWmQH1tjwaBPLoY8cry4fgxGz/y+jyt9I3iOVivzKXD8Ltb8s6F1sg16ceyN7Isg4XOafcb8JlCPT5cO21PvU9IHjPdjcradKbNejadXJQGKSGQ36CQJRWcTTFy7iHI42V0+wR35cZP0Jf26UgFiflWiBlP25u/CjzcmJpWYAk5R7k2HGUer9Vb7fbmsKUiPXk5PD+8jmJderrbm3DxrB5F3WAqeWYDDG+6F/5z8s4rTyuIxJ+2NrXatp6xxCIkgydOfhs4kjNOJtrDsmUSlcOI38/9n6Zgnzhn0h/2IV1l68K8R5PQvWAxfi8oW7RLZfUZle6P5z/8C4PAcM3YnDJGgw43EUAb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:55.7677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1d60a6-f7af-47b0-b0e2-08ded126a017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

soc_detection() and soc_name_decode() read the PMC_TAP version/idcode
registers and decode the platform. This is SoC information rather than
board policy, and a firmware interface could provide it instead, so it
does not belong in board code.

Move both functions, together with the shared platform_id and
platform_version state, into arch/arm/mach-versal2 where they still
override the weak stubs in the Xilinx common board code. The board file
drops the now unused linux/bitfield.h include.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/cpu.c | 75 +++++++++++++++++++++++++++++++++++++
 board/amd/versal2/board.c   | 71 -----------------------------------
 2 files changed, 75 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
index d28c0e131711..f5db0660ad54 100644
--- a/arch/arm/mach-versal2/cpu.c
+++ b/arch/arm/mach-versal2/cpu.c
@@ -8,15 +8,21 @@
 
 #include <init.h>
 #include <log.h>
+#include <malloc.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
+#include <asm/system.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/cache.h>
 #include <dm/platdata.h>
+#include <linux/bitfield.h>
+#include <linux/string.h>
+#include "../../../board/xilinx/common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -196,6 +202,75 @@ void versal2_timer_setup(void)
 	debug("timer 0x%llx\n", get_ticks());
 }
 
+static u32 platform_id, platform_version;
+
+char *soc_name_decode(void)
+{
+	char *name, *platform_name;
+
+	switch (platform_id) {
+	case VERSAL2_SPP:
+		platform_name = "spp";
+		break;
+	case VERSAL2_EMU:
+		platform_name = "emu";
+		break;
+	case VERSAL2_SPP_MMD:
+		platform_name = "spp-mmd";
+		break;
+	case VERSAL2_EMU_MMD:
+		platform_name = "emu-mmd";
+		break;
+	case VERSAL2_QEMU:
+		platform_name = "qemu";
+		break;
+	default:
+		return NULL;
+	}
+
+	/*
+	 * --rev.-el are 9 chars
+	 * max platform name is emu-mmd which is 7 chars
+	 * platform version number are 1+1
+	 * el is 1 char
+	 * Plus 1 char for NULL byte
+	 */
+	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 20);
+	if (!name)
+		return NULL;
+
+	sprintf(name, "%s-%s-rev%d.%d-el%d", CONFIG_SYS_BOARD,
+		platform_name, platform_version / 10,
+		platform_version % 10, current_el());
+
+	return name;
+}
+
+bool soc_detection(void)
+{
+	u32 version, ps_version;
+
+	version = readl(PMC_TAP_VERSION);
+	platform_id = FIELD_GET(PLATFORM_MASK, version);
+	ps_version = FIELD_GET(PS_VERSION_MASK, version);
+
+	debug("idcode %x, version %x, usercode %x\n",
+	      readl(PMC_TAP_IDCODE), version,
+	      readl(PMC_TAP_USERCODE));
+
+	debug("pmc_ver %lx, ps version %x, rtl version %lx\n",
+	      FIELD_GET(PMC_VERSION_MASK, version),
+	      ps_version,
+	      FIELD_GET(RTL_VERSION_MASK, version));
+
+	platform_version = FIELD_GET(PLATFORM_VERSION_MASK, version);
+
+	debug("Platform id: %d version: %d.%d\n", platform_id,
+	      platform_version / 10, platform_version % 10);
+
+	return true;
+}
+
 U_BOOT_DRVINFO(soc_amd_versal2) = {
 	.name = "soc_amd_versal2",
 };
diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 7f2fb4c1ec63..2afd283b8ddd 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -31,8 +31,6 @@
 #include <versalpl.h>
 #include "../../xilinx/common/board.h"
 
-#include <linux/bitfield.h>
-#include <linux/sizes.h>
 #include <debug_uart.h>
 #include <generated/dt.h>
 #include <linux/ioport.h>
@@ -61,75 +59,6 @@ int board_init(void)
 	return 0;
 }
 
-static u32 platform_id, platform_version;
-
-char *soc_name_decode(void)
-{
-	char *name, *platform_name;
-
-	switch (platform_id) {
-	case VERSAL2_SPP:
-		platform_name = "spp";
-		break;
-	case VERSAL2_EMU:
-		platform_name = "emu";
-		break;
-	case VERSAL2_SPP_MMD:
-		platform_name = "spp-mmd";
-		break;
-	case VERSAL2_EMU_MMD:
-		platform_name = "emu-mmd";
-		break;
-	case VERSAL2_QEMU:
-		platform_name = "qemu";
-		break;
-	default:
-		return NULL;
-	}
-
-	/*
-	 * --rev.-el are 9 chars
-	 * max platform name is emu-mmd which is 7 chars
-	 * platform version number are 1+1
-	 * el is 1 char
-	 * Plus 1 char for NULL byte
-	 */
-	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 20);
-	if (!name)
-		return NULL;
-
-	sprintf(name, "%s-%s-rev%d.%d-el%d", CONFIG_SYS_BOARD,
-		platform_name, platform_version / 10,
-		platform_version % 10, current_el());
-
-	return name;
-}
-
-bool soc_detection(void)
-{
-	u32 version, ps_version;
-
-	version = readl(PMC_TAP_VERSION);
-	platform_id = FIELD_GET(PLATFORM_MASK, version);
-	ps_version = FIELD_GET(PS_VERSION_MASK, version);
-
-	debug("idcode %x, version %x, usercode %x\n",
-	      readl(PMC_TAP_IDCODE), version,
-	      readl(PMC_TAP_USERCODE));
-
-	debug("pmc_ver %lx, ps version %x, rtl version %lx\n",
-	      FIELD_GET(PMC_VERSION_MASK, version),
-	      ps_version,
-	      FIELD_GET(RTL_VERSION_MASK, version));
-
-	platform_version = FIELD_GET(PLATFORM_VERSION_MASK, version);
-
-	debug("Platform id: %d version: %d.%d\n", platform_id,
-	      platform_version / 10, platform_version % 10);
-
-	return true;
-}
-
 int board_early_init_r(void)
 {
 	if (current_el() != 3)
-- 
2.43.0

