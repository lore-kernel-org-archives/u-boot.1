Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7BCC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3968078B;
	Tue, 21 Jan 2025 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDGGBEda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381A1807B1; Tue, 21 Jan 2025 14:01:54 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D52E80763
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0SVJqj4Gb4EuqDug2tO4xQJ2SETMESnLdWPeSmIFHoKic9w/IkwRh+5FkOZIGOjTJ3LaBhzzOPkWnYYypSMcdVQ82ktdz/beJF5q8BZf6zsBfcxE5IhpTPtcOn6iXko1wgy82MnCo7Qi6i6JoZ1rWSgCiVqbfEPS+YSYHfMhvyiAcIrPgVVJ66X/EnjBGjZijjII6BbauVYHsUzQOzowjV4TO/iSf8B6HBKmrIj50oInnehP4b/i2XsCkdpfJeox7kNwLa7lYJUpvm3Mv5/BjaZVkHSXdNgLugIRzrlhH5zHh32dmiuzbWmNOexReD6pYma2MlNnNaPGlo9X0LRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2Jmo3ihiU++j2tJK2AJwV6Too0ViKR9sWDeXhbheKo=;
 b=SLVjymUHetQw4SfKeknA6FGC5R0P1bd4k8MzZg9rA3RH/+HkoclW6WYyXC5ViPn6nNFV4uDmAsdfBZ9qaXJRWUtz9oMWTL7AT+x9eic6peGohKN5cP70/M7Y3kFjmc/UXAqCgBBTL0u8mLs51+EK1evukO6X2v8uidHBm7gMGmqfoRRNg29OTjpQZ6Zb9LM79++EmHg3QfbM5l+x1yUqJy/k7xkrUJscNwDwdCW9Pxqh92RPxXpnkfXQ8cCUN4uvJK0iU8S7zKSdAOxZS/gUDNiPwa3YV7fIOQ7+rold7Evw49QUhF5CrboN20GeK6KJMpbARi1YQRkKvTx5Pw9/eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2Jmo3ihiU++j2tJK2AJwV6Too0ViKR9sWDeXhbheKo=;
 b=lDGGBEdaKvpjeHT3+eortXSmm9qVMHgoacYa20/iQARuHYzrzXUABApDvKU2U0ynYqYx0EQ/TOZNRrF2atTyh63eFM0ZrB6jEzWC7wBymR4hZsJUdDgHIG18L8Eu47PagSre7jiCRRKNJM+ygSb1bUFLP/Znwq1H4h0L6kudxH4=
Received: from SN7P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::20)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:01:46 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::50) by SN7P220CA0015.outlook.office365.com
 (2603:10b6:806:123::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 13:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:01:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:45 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:45 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:44 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 4/5] fpga: xilinx exclusive commands
Date: Tue, 21 Jan 2025 13:01:33 +0000
Message-ID: <20250121130138.1999916-5-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 94001a37-03a1-4645-bc26-08dd3a1bc2c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yGUYWe1HvlKnc0fnhZLxTI7gsu4tFIHqRhLzQ1zXZU8fYq9gyeR02657zoXN?=
 =?us-ascii?Q?TlRdmZwpgWh9p1LK2qLxg967H1el7FLIFDmOUr47UUjrnls+3PBoEhyTsBrQ?=
 =?us-ascii?Q?KuF7WJOReWxXVbKHlOZaPIkxr4l8Me783qGKRDaxRmSut7Jhz7ch5/mdrzJ5?=
 =?us-ascii?Q?rQHl5E4VEYCoVHS9D8kEO1dHr67V/XQ7oeq5oVmbY+daYIM6GZHCceYZi/o3?=
 =?us-ascii?Q?ZvaCqD3ul9zJzJr9GcmMNiRRrQ4rnL9F+Nne7yhB7hebPDoDInYfsUamItp8?=
 =?us-ascii?Q?f1pDYSrl2vEmtn7qL8DCvB4f6VKafTUlCAdjABLOMyfGFSejv/VqX+rQ/dnO?=
 =?us-ascii?Q?FCq5PQLWnSW4Cx40LWOIf0h5a65p1XFI2n+n687iU9B6Te6NFr05W/0dQgZo?=
 =?us-ascii?Q?q8j5LoLy84F1cAQeBFaumk0nT/aSxSGu0c+Un6BtVwyAYlxtSBrXmB4koeKN?=
 =?us-ascii?Q?ExZGd+acDPQX+/X7OToM26zNnR3E06WQYbEzoOyFzy7NlZfq9C37cZKR68zE?=
 =?us-ascii?Q?qmZfOSOqlcpeUmX1z72/bCzbsxVbU63qZLV0kacZNdprtZbvvKH9FQ16DxS9?=
 =?us-ascii?Q?10opa1fye6jonIc5ZmhME8CKsEwaa8Hr4BQNmQewi5dw3ezhZI4XDxzF1KKr?=
 =?us-ascii?Q?MIDFuKpEm/KOkL3AgrBoDPisObyGSErbCbf7oHxefunCInf+RDTw1ok3U4Kk?=
 =?us-ascii?Q?yGhaFd4kjqLxWawd4ie9q2Rl9vaoXeP5/zSoaqjnaht51fm48b6XQ0Ur8UfC?=
 =?us-ascii?Q?lCFfureeiGrV1kcXCi9JPWqzK4i80CS9bOi3vkEXszRDUN1+V+9Cm9n9jZT1?=
 =?us-ascii?Q?fsD2u3wk4MSstAp/mQewOmlgkIjPC6r3QHHrOQL7kLMR7+F4CmcRSyPd0XCi?=
 =?us-ascii?Q?VZP6To2aDow8K/Z/Dcexlhq+SiPEQN7xtvvUPVVSfHY5HKh0411c02hc/BR+?=
 =?us-ascii?Q?K/EB3cGLuNFg3Ov5LrJ6eI5D6opSM6hbcCVx+IJb4NhFKvm7I61kyvu/lzU0?=
 =?us-ascii?Q?JDoUJzUFqviAlL4pSypV9LT8i+BGP4lF+NzSqCAcyztfe/4AYr9keb9essvt?=
 =?us-ascii?Q?RotvhGEEeiXLUDcHepGpOrqalb+xMSKLsILyOKZWQF0QuWx7/kKYi3LaeZsH?=
 =?us-ascii?Q?QHOHNc30Duo4vgvBggrT2ynhY5C5jGxqtebzWEc8D4Vch9lpPhm571FWpz20?=
 =?us-ascii?Q?0K/+RuEcWtdvxCAb4jTpDJUQTA3tFL1isGwcIoXG0Gn2GiEtiFw6ynm1gQ+i?=
 =?us-ascii?Q?JXDVAcC+vQ8FxAmjr1n2DbhDABcDhyvSA5N+WFJ8kUZ0umrMVJtIJVK7XY5o?=
 =?us-ascii?Q?2HeQEGxZ5cP3I+DuhzThsMQ7ajheBpjl6H1smeBPIz1cuiNDkb7GXBPbMNzR?=
 =?us-ascii?Q?AbKC+z1Z4FkYc5llj2HCCNKrM7OjhFlTy6J3StozZY4boyVyGKrOQnjispyL?=
 =?us-ascii?Q?uyX8rBhuPLawT9J5FcJmoTy3RiQEYFJJ3n7bJKrMKfVzRbc5in8DVv0QEowe?=
 =?us-ascii?Q?3OaI8MSMG5Wru8U=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:46.2069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94001a37-03a1-4645-bc26-08dd3a1bc2c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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

Ensure all Xilinx exclusive fpga commands have a KConfig symbol and
dependency to FPGA_XILINX listed. Remove (Xilinx only) text from the
help command.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 10 +++++-----
 cmd/fpga.c  |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index b362595af83..c9600498787 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1187,15 +1187,15 @@ config CMD_FPGA_LOADP
 	  a partial bitstream.
 
 config CMD_FPGA_LOADBP
-	bool "fpga loadbp - load partial bitstream (Xilinx only)"
-	depends on CMD_FPGA
+	bool "fpga loadbp - load partial bitstream"
+	depends on CMD_FPGA && FPGA_XILINX
 	help
 	  Supports loading an FPGA device from a bitstream buffer containing
 	  a partial bitstream.
 
 config CMD_FPGA_LOADFS
-	bool "fpga loadfs - load bitstream from FAT filesystem (Xilinx only)"
-	depends on CMD_FPGA
+	bool "fpga loadfs - load bitstream from FAT filesystem"
+	depends on CMD_FPGA && FPGA_XILINX
 	help
 	  Supports loading an FPGA device from a FAT filesystem.
 
@@ -1207,7 +1207,7 @@ config CMD_FPGA_LOADMK
 
 config CMD_FPGA_LOAD_SECURE
 	bool "fpga loads - loads secure bitstreams"
-	depends on CMD_FPGA
+	depends on CMD_FPGA && FPGA_XILINX
 	select FPGA_LOAD_SECURE
 	help
 	  Enables the fpga loads command which is used to load secure
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 13aabc95abc..75d2f824998 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -420,11 +420,11 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADBP)
 	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
-	 "             with partial bitstream (Xilinx only)\n"
+	 "             with partial bitstream\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADFS)
 	 "fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>\n"
-	 "            Load device from filesystem (FAT by default) (Xilinx only)\n"
+	 "            Load device from filesystem (FAT by default)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADMK)
 	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
@@ -436,7 +436,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
 	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
 	 "            Load device from memory buffer with secure bistream\n"
-	 "            (authenticated/encrypted/both)(Xilinx only)\n"
+	 "            (authenticated/encrypted/both)\n"
 	 "            -authflag: 0 for OCM, 1 for DDR, 2 for no authentication\n"
 	 "            (specifies where to perform authentication)\n"
 	 "            -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
-- 
2.42.0.325.g3a06386e31

