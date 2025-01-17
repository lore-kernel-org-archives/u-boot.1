Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA49EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C3148081E;
	Fri, 17 Jan 2025 15:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pp4akfG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14EC80716; Fri, 17 Jan 2025 12:26:10 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88AB080737
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/J663pAQs0sMoo3MfLDn4u4sWuZ1S4lLKsf3rIJcgGb0RLQZv3w5dUImLI3E8R3z3/B9jsnt7GYPMfMnIBrEX2ULYzjVcAM/7auDvOg8wXHvaGumClwUwN+h0xL9T5AGnNWcpAL4UVV1Mcj/+3WxXfl90PZPvI/q8K7BMvA+lGKos8etjprWZuCKhiqEa5Sofhq9BaL7eBmdVC4cnoliGkrQ+ixNFU/9XcFiER5EWvKPJ84CQ++4FLY0wM4TttGRs6XLWPoioWXlgTwwZ6wVdtz9IXnI/99RYdAYqJjsDoF45tpWpklnj3zKaY5aLBTlW7k0mw5MVWsFzXG5SoDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsGrCZh6kZYjRD7Myt6EdPDMsENgzokwYjfc6WP6xqg=;
 b=A0qfXpCZV166/FAGUY1ow59k+Mw2Nj9fD2oMzlKAklzZ4QBi+DlY0F/B0NwEpmXicCW9DW47nUq+1OcQVUop45zsrVqfDlcuiRMzaViRji2025WwFxGe8CACodfzT72oC6Q1iHhfzB0nGU2R2EUod9FY+MgY1gPXukhpb0qLQwiHas0rRrlN7zj7s2j22kkRvO+a8Y76sWnbgRV3dN8MjIKoghQsjQp2GO/BhQcab9Y+TfffFDI+314YST46UPu6I08yZ/OUkKOloNE6S3+NL4qMYczDGFcpuQPHWgwn7Xf5fb1kK/GJFg0rs9/XEkfgLEnoIOenrq7VqvVdbB2k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsGrCZh6kZYjRD7Myt6EdPDMsENgzokwYjfc6WP6xqg=;
 b=Pp4akfG0jOvwuA/ZJ7GSj7iJcUaup4QRTUcruxdOUDh88bCQjLVY+AEyalJxb/RNYJh73VwFM+3/klmOAiHgLu7OrcSj1mpcoW1tfHcY67dHgARSCOHtImRAlVacMusaAz90XIzit+witYTgQs2xgESw84TeX//p+t4hg/7y4NU=
Received: from MW4PR03CA0331.namprd03.prod.outlook.com (2603:10b6:303:dc::6)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 11:26:03 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::14) by MW4PR03CA0331.outlook.office365.com
 (2603:10b6:303:dc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 11:26:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:26:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:26:01 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 05:26:01 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v3 3/4] fpga: resort fpga commands
Date: Fri, 17 Jan 2025 11:25:50 +0000
Message-ID: <20250117112557.3729416-4-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: bf834072-2124-482a-adb8-08dd36e9b9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4oHkT/sh7TtxDaWsdAuAFLltbmEJMwnqCaatWuMzuUw8+rIKZ7H6tKpTviz7?=
 =?us-ascii?Q?DPHFpRVumtHNPtVbNDAYZJtTQgAag72x0h3d6an/JLyRNY6/McapLdOuth8R?=
 =?us-ascii?Q?hd1Yd83E8lsSAt9Mo1aQy1xum1MxX0TeMEn1hHBzzgDzgjNqqQ346nenDT/Q?=
 =?us-ascii?Q?S1P0cd9+m00mh7oyleQVIc9htQ5bx5IZYMLoO+4QKAxDh//u5We0Ubu0LKJ2?=
 =?us-ascii?Q?SkGUcOJ5dIqgb7v+sIgrzEV6UKloNHwyr58Q1+2iSy1q7SXQH93rBXKTxsIL?=
 =?us-ascii?Q?xesc+sju4IDaeQc3mHzSGTBOlU45pjnxLj8kQ2tAGELsdod2ChZRhnvVIF1T?=
 =?us-ascii?Q?WFSJQzBc7NNH1bYHrfMnlxZjgeCltlkImGzrrZnJW2yWxF51KOvfgif13R13?=
 =?us-ascii?Q?m+3GzG3SVcuLMPZLnKkOwvz5o1U71UioaaKVJ4MZN9ypV8Rgm8+/qKveZLLN?=
 =?us-ascii?Q?g8Q08yKUxmOvV4OHkfKC5/bmpml1vtacrh+m9KOxJLHQNnyvP+FILGyR6JcT?=
 =?us-ascii?Q?8N6BDdIv32ajVsm1/vUVSHkV1lUi9XynIY0uyP0EB59DdkdSk01s96wfw8TN?=
 =?us-ascii?Q?tQ3m8kmT3mmd5hzjSPP6KI88igrgN2PWLjAizaAcHPzruwzcdaRiXKcvkxYg?=
 =?us-ascii?Q?2nXhqXxSvbXnrL5SlEbSB8hIcsW11zLH5CqyCvOdrw7lbjOO2d7HSf2EG1+S?=
 =?us-ascii?Q?Fidt81rx3JEne7QNXL8w7eWoFzPkdgeUhQXOsBcdNvOQ0ks+Zf7CoM7kbo1i?=
 =?us-ascii?Q?FPe+WG8IOf2aHGeKu4E9j6t+PkonA0wtXVjsO3/spd2gxv8xdVIJaXHe4zTX?=
 =?us-ascii?Q?NUaoXL5LxHXsl3Tadzdxf5QLZfg3yO0LjKncAMPcpn37ZRPeZpk7AFSHL/M5?=
 =?us-ascii?Q?KsQXkY6VIC6GSJgqLjHV0qS3Rj8IfjEAgUM/gZtlOmfo+WqYFK8F2kHyeycx?=
 =?us-ascii?Q?zJS71DLNw+cOhAbfeqCUh0oMllAiZK8s7wgJ09Kt1WPj/SGwR15HLDMXxbCf?=
 =?us-ascii?Q?NAtz6GWNL2D2/ZMtJUR/gIPTMzN6facTJOnI6D+p1lAmapG3OW0433AAbrbZ?=
 =?us-ascii?Q?Pgea0hqECzkjrAAQ2iNBR9M5DWQN3cw0hSQwhMawGhabQ1HlH0KSozRe4uc9?=
 =?us-ascii?Q?enZd6tIIzxyRlD7b1HgfPBNRSsTJT3VFiEZAH3aEiiCMkPXt7scUin70ExxU?=
 =?us-ascii?Q?mimXiAd/m7XAWVQDWv23ezs9Q928XhTw/5Ya7IEYbkiQMhveg2yAuPz7+08y?=
 =?us-ascii?Q?uItkX9stRfcN5jcFihhPuR9ifqpsAFuJP4IpnQa5sJ/329yJMWavzb9MOqw6?=
 =?us-ascii?Q?PH1r5OlLjdoEkjC1IbFtBjuyjVBAAv9V/IU/a8WkZHr+Zus124RbsZepGyK7?=
 =?us-ascii?Q?CBb8QZaVFfD0tuXek/KCoAhKha62G89z2wfP3sJi2s34lm56l/T8OR7HR6ni?=
 =?us-ascii?Q?G5y3EmFIDOb+5RqAAQtvrV3nSRsgSZON4K+JPz9L3XpzPltfjgTdhxyh1Ssl?=
 =?us-ascii?Q?a2Bw+uECI1+3v4k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:26:02.7263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf834072-2124-482a-adb8-08dd36e9b9ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
X-Mailman-Approved-At: Fri, 17 Jan 2025 15:10:41 +0100
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

Resort the fpga commands both in the Kconfig and in the source code to
list

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/Kconfig | 14 +++++++-------
 cmd/fpga.c  |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1d7ddb4ed36..f3ba230db42 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1163,6 +1163,13 @@ config CMD_FPGA
 	help
 	  FPGA support.
 
+config CMD_FPGA_LOADP
+	bool "fpga loadp - load partial bitstream"
+	depends on CMD_FPGA
+	help
+	  Supports loading an FPGA device from a bitstream buffer containing
+	  a partial bitstream.
+
 config CMD_FPGA_LOADBP
 	bool "fpga loadbp - load partial bitstream (Xilinx only)"
 	depends on CMD_FPGA
@@ -1182,13 +1189,6 @@ config CMD_FPGA_LOADMK
 	help
 	  Supports loading an FPGA device from a image generated by mkimage.
 
-config CMD_FPGA_LOADP
-	bool "fpga loadp - load partial bitstream"
-	depends on CMD_FPGA
-	help
-	  Supports loading an FPGA device from a bitstream buffer containing
-	  a partial bitstream.
-
 config CMD_FPGA_LOAD_SECURE
 	bool "fpga loads - loads secure bitstreams"
 	depends on CMD_FPGA
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 91ccbee0fef..13aabc95abc 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -412,12 +412,12 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
+	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
+	 "            (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
 	 "            with partial bitstream\n"
 #endif
-	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
-	 "            (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADBP)
 	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
 	 "             with partial bitstream (Xilinx only)\n"
-- 
2.42.0.325.g3a06386e31

