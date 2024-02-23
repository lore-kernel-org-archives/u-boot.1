Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E507C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 16:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AC1087653;
	Fri, 23 Feb 2024 17:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NmK2bblU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D4B875FC; Fri, 23 Feb 2024 17:18:34 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E7F87653
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 17:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjYjhKvW23UpwwYjnm6NZm18xd0r420VzUTG1Ho8YKuk2nOMnbNL6M53vuJPvkf7bzhadU4BxwtFEt0jdflQsFG7AgOPDTOvS352FguoXIfsChvtRnK225xD+0l0Md/0qkS+nuuzoM8xtw7b4aH8EM2SfjtSEJ27+ZP65e/FlKoeX0LiQN5yPWZdDsTboaY/z5JJ/4f8Bfu9Owd3+dAJ69WD5/Yfh8WpuZemg+fx5wdvfnc40x9+arUNnK9UGDGue+Wz5cvf1kS79/thBjToAcEwOOJNVD+lMwHN0+WIeHwXUr94hfnwzb5BiHGVTBYfR8Ipy5jtGFjA3yOiUaMVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qCYgdg5YVkvqjNUwr6gm3VSkZxqnK+C+9RAgBOiqZc=;
 b=dOZXN5yZXaOuxGL/8i8C5WjgKEl1F3n1eCFVvWvKAivatpMlUmtF92qb4f5S+qptuqkj3HBtoxhyKPRfsmP6l7beN3AgPL3G3yYYG4N4ymX9Z+o9tdTFMvrGbwbtXkotZy4uG8JMDfp1iVwoQMbGsrO9M1UIkumFjMTsK8kk7ipgJvf3FnyYzGhzpzahDboVA6To9dgHRH7ZiOHoSF+madPCSj4s3PCm+ITBHi/36tb60M5Q9QsoRZnlfTgOq2THTroq/bMzXITpPhv3xy0I8GmwJKLek7Yi0Ph0FlEGi0CSXPMnNE7AWsXuEmDa+BvcPfv0Jpfa8uy4cfdl+CoEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qCYgdg5YVkvqjNUwr6gm3VSkZxqnK+C+9RAgBOiqZc=;
 b=NmK2bblU16LulVgxtVR1S19ezr1uA7ML4CC/esZxANQVxZ1y5YUDJrRaBO1daV6qn0t+a/juJc3RQMlgqIgjDdTnYMijuoM9ZZ3prmOVDazDi08iEjm2InnJH3tIJw22CqUJvyKbrzZYhJAY8hwtnDnuFhg0QVYx7BiVwldBaeA=
Received: from CY5PR19CA0118.namprd19.prod.outlook.com (2603:10b6:930:64::22)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 16:18:21 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::26) by CY5PR19CA0118.outlook.office365.com
 (2603:10b6:930:64::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 16:18:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 16:18:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 10:18:18 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <ilias.apalodimas@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Add MTD partition handling for dfu_alt_info
 generation
Date: Fri, 23 Feb 2024 17:18:16 +0100
Message-ID: <c0d35e3b51064a31d2f1b6a0233976624826f1d2.1708705093.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=n9PaMGGPTiatRjgpODbJRJIKvP3Vqg1+Gm3eSxkgk+8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQbR91urJZ6pfzgm3ZyeYmux5mL+XvWHDrMP0833Kvi8
 +mXoU13O2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEJLYzzOEX/9+R1bvh1Ufx
 dcIzJ2TncnR8XcEw35PpSbShWo5ObhqbvtQNtw13li39BAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: aa11e6a6-8513-4ea7-3c8d-08dc348b0da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrL4kCOHShVXCCXa0HeLDMRPMh/MIa4u5BLx0c/NehLTCl49Bl82NfXqWiQ8u3Blb/Aa8nAwS6JMWy2FKHZgarHCNbC2clcOzoW2nLU+oD67LliKD6ZDxcrcU8C/ulptqbwTv3bxil3gXsAHr8xm1hfAojJZLajA7AQJqBg/hYHbk8f+dt1qHs8a9zVoKN0ZMGiWmgX47+Uhja5ct88uFaBfM95W3Dc1spgl4F9wXwYlNuGQk2wQQbopZ4OaXW3yNqY49SBSjVy9BUJabEyBHPwSqM47F71mq96mcEyqGiKWhmkEa/KwqrDzcOYCaokrsBxuosVdY9knfMBddtHVFe/V5vMO/4x6csEqJJ5Pv3GcFMVcITBNV2L/jlXLOzwinZpuiFgqvfljOdbUB7fHBqKj6B2yD7UhWAUPwkWHX46XtIMS/LqnpdqZQqcu3pOodyfN4ggfvNYm4E63crbn3DCB5gBqlbip9nIv7+lFF5OW/RbysNlks/HdGa3T1Uv58wdx/O9PxshxPm96yelEC47AU+2HydIlydw+U1KQ/Xjtiuv0AFd/0x/svveCUVUevGlmLzd6F+X+0RQ8gqKuIaK2Eci+kkPCiT0g0z8doLQelba4TO/2EQgeVQnm9MuJcAATjNu3wKo+ep6PDrWhxM9twQSv0j0mOhtqyhWDcYY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:18:20.8693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa11e6a6-8513-4ea7-3c8d-08dc348b0da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

Generate dfu_alt_info generation based on information from MTD partitions.
mtd_found_part() is trying to identify MTD partition which code is running
from. If partitions are not defined and location is not found it is going
to previous behavior.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp.c | 52 +++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index ba49eb7be229..eee89284de9d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -626,6 +626,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
 
 #define DFU_ALT_BUF_LEN		SZ_1K
 
+static void mtd_found_part(u32 *base, u32 *size)
+{
+	struct mtd_info *part, *mtd;
+
+	mtd_probe_devices();
+
+	mtd = get_mtd_device_nm("nor0");
+	if (!IS_ERR_OR_NULL(mtd)) {
+		list_for_each_entry(part, &mtd->partitions, node) {
+			debug("0x%012llx-0x%012llx : \"%s\"\n",
+			      part->offset, part->offset + part->size,
+			      part->name);
+
+			if (*base >= part->offset &&
+			    *base < part->offset + part->size) {
+				debug("Found my partition: %d/%s\n",
+				      part->index, part->name);
+				*base = part->offset;
+				*size = part->size;
+				break;
+			}
+		}
+	}
+}
+
 void set_dfu_alt_info(char *interface, char *devstr)
 {
 	int multiboot, bootseq = 0, len = 0;
@@ -667,15 +692,28 @@ void set_dfu_alt_info(char *interface, char *devstr)
 		break;
 	case QSPI_MODE_24BIT:
 	case QSPI_MODE_32BIT:
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-			       "sf 0:0=boot.bin raw %x 0x1500000",
-			       multiboot * SZ_32K);
+		{
+			u32 base = multiboot * SZ_32K;
+			u32 size = 0x1500000;
+			u32 limit = size;
+
+			mtd_found_part(&base, &limit);
+
+#if defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
+			size = limit;
+			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
+#endif
+
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					"sf 0:0=boot.bin raw 0x%x 0x%x",
+					base, limit);
 #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
-			       ";%s raw 0x%x 0x500000",
-			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
-			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+					";%s raw 0x%x 0x%x",
+					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
+					base + limit, size - limit);
 #endif
+		}
 		break;
 	default:
 		return;
-- 
2.36.1

