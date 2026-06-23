Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8D5CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DABC84A35;
	Tue, 23 Jun 2026 14:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BbGOwDY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5759C849CE; Tue, 23 Jun 2026 14:55:08 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9113E84A35
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+wYvZqc2WfKinVe0t3usmvCTJLawNMSrOncMd0hUpPv55alH17H3C3E/noI8F9ybIJKdw9km0243a3K18cMAh12yEkxDCe8sBuXTQ/cBQrtbI8fwFVQy6sKmWRYPa4AV/v/+T6A1EcTc1BhVp9WliRlJxJOIaqDIEkzMNh7O92qeCVzQygj3d3Lx11f4Ba7338JOKryIDMalbWGcUkokUPFFAQ7DWJEIdrbPLC1wZDcUHVtsvX/4c9lwLwKSjqqwgzj2ZcekEeq68DQTDBNUPWhnD0yC0zFtIrRDHHy1XwfbPwzD8UcgqcWgrXAPMaeWlWfAlQzElZRa1MM/O2wWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oNRgbTfov295+qF9Y3OM61lL7VqjqNvO30gbP+8Wi4=;
 b=Oa2jv+v7KgZofogAhjkF3y2EQJcDnKJD1WmqiQsmMtvT4MLU1vcquYicCO4mbkCcOa/Tj6Einddsvvv8uo70PbJdaDNTmKJE+olP2LldAmCV2D5vetYY9j1e1GhNEC2NcSfWRBpnT4RRuewYp0SYHdm3LlEsy4s9YbAf1U/43RUL5qlw3z5kwNyZvnnq6dxGNo4Ft6XU3ebJDHhKvMCR6xCeSpP7qoT6oOBX7yohS9MNrXSu+3iyHSHBuhyoJpwTXB8Yfawt5rNyC00GjAY7Z6v5tXApEPMjMPbmXW9io/9/VoHgqiYximmfoyA3PbDnWcZpALWaRdi5jwMqDExpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oNRgbTfov295+qF9Y3OM61lL7VqjqNvO30gbP+8Wi4=;
 b=1BbGOwDYwSDSBhbxgv9uAQKUqM5f/KZ+6moNc8qCgyvEXGclCM+fZ0yn0epxNmPI6+BGH5qUBam1Mv5pXniOBmQxW39WqDjNViqYivmf322MxjfkNYnzjgrYmxZIGZsRp769AgxLzZ90NBldUq++3iaDslOLEuEFYKoIhB7LQe0=
Received: from CY5PR22CA0027.namprd22.prod.outlook.com (2603:10b6:930:16::8)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 23 Jun
 2026 12:54:59 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:930:16:cafe::6a) by CY5PR22CA0027.outlook.office365.com
 (2603:10b6:930:16::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 12:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:54:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:54:57 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:54:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/18] arm64: versal-net: Move SoC detection out of board code
Date: Tue, 23 Jun 2026 14:53:36 +0200
Message-ID: <8757111cb254543d61541fb030d51f62c3c555a8.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6467; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+2vz6EpG3B1ajNnVKWIdBiOGSRBPpj2T9wKJD+UnZic=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb6t1DV9F3rk5bptqnfNJgV5Fz9OuLuM/4WNX2/mo
 TA7+6yJHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjAR+wCG//mJl93kw5k27buW
 6+ovqtrGduvGS7UW5lfum7c8Zt0p8oORYVU3/+O1WS/ttgnZarfEa6dO1X9nsyLo6BNnLvfnC92
 UuAE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b82d31e-b7d6-4af0-95fb-08ded126a225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: clBur9vAW8wM+GESEuqR0N0ZNIGWFHyyJa51mxAFNcGs1tOcxjM19+RWRNNHDCwCOeTW/l7w+VR5NX08T4WE1VGH3ipZL+MFBfDOWDN5sWtzntqji1Dck7z0cONaeV3fBbvcWS6qnwACpaiHzyqnpT+9UZ8tj6+6gCDKIw99K+gOLHdtXYp2tovOuMYEg285/ADhXIYgH2HILAVuZFTzGM2GI2IlLwL8yrTw1zFo8IpLrtxT/vfSIDS817ZZfOjJH+zla84/sC13bUmu7+wC5aAg/jZmkIQKAiVJUAkQh42ucWtlRhguXWuEQNX40wL/TzBl2AmK10hFBaNage7uD2VlYCaJv4AlNDyzFw5FTFmw4dbCqYTEhGsU5d9kKMmywPrej7Lql1aJ7rvDHf71g0CURJ3GjSul1ydebMy/zmTF/QRYMI/woEKQ/pI8Y/xVMIscOp5THZ9K8LtcbNHmBmRsoNqDTQ9ftnvaOjLz5zrK42Uo1esZlcgkPpZ3OVqwXLlBGt652dZdUnm/Nwg/BJ+DCN+gLCkAGA1XaHQmXUi+Z1bjI28x4AbYMaPDy7g8vXVAigm5tvqHLaPooavVSpEzSeHnMwZmffpH+DM+xtzp/Ox5M1ZGmjVQhfjwgim5qo+JyZHbvpWlvLIvfWQRKdpx6wLGoZ6jXMs2Y2H/pv2Nq6DY2O/+64g9XOHokxlVAByshorUnvVLn7il1Up4HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IHKlNy6EYp3XQ8Vdyz2zY4RRe153671zduMuko5+o2qBqjx811OTbZb8jF5pIEAerWp6Ad/TSD8za5p4kr1c/6Cc9Itb9EkfPkqBE5AL3Yw6VHv/wddur+QCcoi74C2x94N9koCYE12NgRO7Q7QUMkAdLaNm+jcPFxOUjkg7DK46vS3Sh95LWzgIlGOmoTh+PvlCYsb8MMWMuF/Ppr6RqXX7prt+G/0Kb/xaemH/kqsYm20zfxNX7z+M2wH1KK3L5E18nRVj0XqLrNEWxv1Cei9OKxddRKen3BrZHfGQzJ2VvfTHO0tw7/PRUgluKKBWKo/QBnx6wDvdpmGQNmR3GD/XgWFUKcHswLO4ZEOkLiuUYLOvq965gRhATuQrIyn6X44nQuhGkq4Ht775CP30Z4aN9CWWDI7vaib5Se18FSf/aY5RJEkjaVMEtVE9dDqp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:54:59.1980 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b82d31e-b7d6-4af0-95fb-08ded126a225
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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
platform_version state, into arch/arm/mach-versal-net where they still
override the weak stubs in the Xilinx common board code. The board file
drops the now unused linux/bitfield.h include.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal-net/cpu.c  | 91 +++++++++++++++++++++++++++++++++
 board/xilinx/versal-net/board.c | 87 -------------------------------
 2 files changed, 91 insertions(+), 87 deletions(-)

diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 5e7c1bebf2cc..4cbcb119ccb8 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -8,7 +8,9 @@
 
 #include <init.h>
 #include <log.h>
+#include <malloc.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -17,6 +19,9 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/cache.h>
 #include <dm/platdata.h>
+#include <linux/bitfield.h>
+#include <linux/string.h>
+#include "../../../board/xilinx/common/board.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -131,6 +136,92 @@ void versal_net_timer_setup(void)
 	debug("timer 0x%llx\n", get_ticks());
 }
 
+static u32 platform_id, platform_version;
+
+char *soc_name_decode(void)
+{
+	char *name, *platform_name;
+
+	switch (platform_id) {
+	case VERSAL_NET_SPP:
+		platform_name = "ipp";
+		break;
+	case VERSAL_NET_EMU:
+		platform_name = "emu";
+		break;
+	case VERSAL_NET_QEMU:
+		platform_name = "qemu";
+		break;
+	default:
+		return NULL;
+	}
+
+	/*
+	 * --rev. are 6 chars
+	 * max platform name is qemu which is 4 chars
+	 * platform version number are 1+1
+	 * Plus 1 char for \n
+	 */
+	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 13);
+	if (!name)
+		return NULL;
+
+	sprintf(name, "%s-%s-rev%d.%d", CONFIG_SYS_BOARD,
+		platform_name, platform_version / 10,
+		platform_version % 10);
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
+	if (platform_id == VERSAL_NET_SPP ||
+	    platform_id == VERSAL_NET_EMU) {
+		if (ps_version == PS_VERSION_PRODUCTION) {
+			/*
+			 * ES1 version ends at 1.9 version where there was +9
+			 * used because of IPP/SPP conversion. Production
+			 * version have platform_version started from 0 again
+			 * that's why adding +20 to continue with the same line.
+			 * It means the last ES1 version ends at 1.9 version and
+			 * new PRODUCTION line starts at 2.0.
+			 */
+			platform_version += 20;
+		} else {
+			/*
+			 * 9 is diff for
+			 * 0 means 0.9 version
+			 * 1 means 1.0 version
+			 * 2 means 1.1 version
+			 * etc,
+			 */
+			platform_version += 9;
+		}
+	}
+
+	debug("Platform id: %d version: %d.%d\n", platform_id,
+	      platform_version / 10, platform_version % 10);
+
+	return true;
+}
+
 U_BOOT_DRVINFO(soc_xilinx_versal_net) = {
 	.name = "soc_xilinx_versal_net",
 };
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index a40039a1dc8e..3c69edc22606 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -25,7 +25,6 @@
 #include <versalpl.h>
 #include "../common/board.h"
 
-#include <linux/bitfield.h>
 #include <debug_uart.h>
 #include <generated/dt.h>
 
@@ -49,92 +48,6 @@ int board_init(void)
 	return 0;
 }
 
-static u32 platform_id, platform_version;
-
-char *soc_name_decode(void)
-{
-	char *name, *platform_name;
-
-	switch (platform_id) {
-	case VERSAL_NET_SPP:
-		platform_name = "ipp";
-		break;
-	case VERSAL_NET_EMU:
-		platform_name = "emu";
-		break;
-	case VERSAL_NET_QEMU:
-		platform_name = "qemu";
-		break;
-	default:
-		return NULL;
-	}
-
-	/*
-	 * --rev. are 6 chars
-	 * max platform name is qemu which is 4 chars
-	 * platform version number are 1+1
-	 * Plus 1 char for \n
-	 */
-	name = calloc(1, strlen(CONFIG_SYS_BOARD) + 13);
-	if (!name)
-		return NULL;
-
-	sprintf(name, "%s-%s-rev%d.%d", CONFIG_SYS_BOARD,
-		platform_name, platform_version / 10,
-		platform_version % 10);
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
-	if (platform_id == VERSAL_NET_SPP ||
-	    platform_id == VERSAL_NET_EMU) {
-		if (ps_version == PS_VERSION_PRODUCTION) {
-			/*
-			 * ES1 version ends at 1.9 version where there was +9
-			 * used because of IPP/SPP conversion. Production
-			 * version have platform_version started from 0 again
-			 * that's why adding +20 to continue with the same line.
-			 * It means the last ES1 version ends at 1.9 version and
-			 * new PRODUCTION line starts at 2.0.
-			 */
-			platform_version += 20;
-		} else {
-			/*
-			 * 9 is diff for
-			 * 0 means 0.9 version
-			 * 1 means 1.0 version
-			 * 2 means 1.1 version
-			 * etc,
-			 */
-			platform_version += 9;
-		}
-	}
-
-	debug("Platform id: %d version: %d.%d\n", platform_id,
-	      platform_version / 10, platform_version % 10);
-
-	return true;
-}
-
 int board_early_init_f(void)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_UART)) {
-- 
2.43.0

