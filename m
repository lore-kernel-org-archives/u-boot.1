Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6923DC0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F124807DF;
	Tue, 21 Jan 2025 14:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVhobCax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9FB801F5; Tue, 21 Jan 2025 14:01:55 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694748078B
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTA84iCy+9Zgua335/BER7xsIBsaGSgtrgegjVF0AAuSH3bKwrnK3Gckqr/SGaFRp/qH8ueBEu1FchBJ+0fhhx8Nca5XH6Fjki9Jlvo5oS0q5HFhk4A9u2hJsYa1xjkv5cHwxMVr7n4ZE6a2ztygPpB9sUIXQdh7fcZXu/vepZ4ic9pL5MM67ddhXjcHi5A84RUGol4UwGhX+IH2b19p15fkGu9rYA77j1QBk9+s8+r7xaKRkj7sD/Bd5xP0dBMeJnIZj2D0sURT9eQi+CAHJEDhWlZulGVQQx8743QnTCX6/7bax+oTdDUAlbAJ1Jp2biX5/gXWcwbgXLnSdmb/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wKl9fetnLQH6kfx1BNk1PJf2aZ3S8o9yFk4WkKkY8s=;
 b=rVhDdf4i9h+PB1EKhCgyP2ZDH8FiKk9cy9OPbRXhQUzwNHK2xjxxoS1+V/XCw+TXYvmxf2JyY7ZRNMiL+GvmL8ZbJtPsVcGoldJgYnHSr0nx0HlBNngea9hj2pPrHXejmvgaAXdTndgg/GTbj5Ft0YYFIHdRUNpdO/PWxkODOoEgY2YRqT5x1cIbMF18s2ZYJ4huiQ9PMxS3gty03B+6eQDGyvJS1ZHTkWGci9XGa/7RG25kjBPz9DHEQjoO/tgShzY9bs4OF+ZEz8ZTjf5MhJ7FJ11G7m0rDvm5Yy/tXS4nCpH+S/h0/mlqOrzKMwBBOLFsTJQ8qBsGYQlkqFDLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wKl9fetnLQH6kfx1BNk1PJf2aZ3S8o9yFk4WkKkY8s=;
 b=nVhobCaxTkpKzWdt9ZNn8puBfUHBSrnbDHHMxXcYBOdFpUR+scR12h+XYKiGxrTf600CP4aYCyPWkCHxyxxvCthzjuG4B57NZZg513OUlH/FA5jZP7Svkzr8iW0e3goI1SbPC/Uhmc/7dscxY8pxafeBxlWiuRz0V/NaZA1Z1Yg=
Received: from PH8PR02CA0034.namprd02.prod.outlook.com (2603:10b6:510:2da::13)
 by BL3PR12MB6547.namprd12.prod.outlook.com (2603:10b6:208:38e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:01:47 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::40) by PH8PR02CA0034.outlook.office365.com
 (2603:10b6:510:2da::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 13:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:01:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:44 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:43 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 3/5] fpga: resort fpga commands
Date: Tue, 21 Jan 2025 13:01:32 +0000
Message-ID: <20250121130138.1999916-4-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|BL3PR12MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1940ebac-e9e0-4e69-949c-08dd3a1bc30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E3ufnXxCJLw0/oihXrNCRIMjM/o0QZh2exiAVrcdeExrcIBVikvGRI2rUEkF?=
 =?us-ascii?Q?hc6mXVmLZnluHESPy8PWJjBsT3huayHSm25AXSlvFWvMRzzurqc6Xt1oJZSr?=
 =?us-ascii?Q?9Ttbr/nYeM1jVg+W/UPqbmwsWkMejIeOCjwBOSQsgZ2fjBxRHMtYwrUSAfna?=
 =?us-ascii?Q?zD/xopt3zQMjUxkxbKGYPaiAgDD10aYDh37FLfyaWTZ72wKs6d4gnpvwFzij?=
 =?us-ascii?Q?H4CMZFTGub//x8UhjcB3m4h/PbCyvKzyioH5rlrIFQ4zus3GFSS8DWCtep2F?=
 =?us-ascii?Q?aAcJinmjmBUMFNDFO7Ih91J6rtODZRHFr5KaRQqVPDa86DlmVs7OqqgYzw3x?=
 =?us-ascii?Q?xNFCpkMOHJPcM323qqsTH3E52fn0XGNemPUNN5zGECdY9/BEQ+Q6rLxRaDn4?=
 =?us-ascii?Q?UkWTX12DPPCUsBWiZgp4f4R0qHM5B61Kgw2lJvrA1EXVaVRM9QHupp7C/MCr?=
 =?us-ascii?Q?kgoCS2l2cx3gYhc1e/gplvcgUqslkNUOygUA8Boo9AdQuBz05++o7+Cm+tTj?=
 =?us-ascii?Q?tLp75sconjNdMP3BT5WihsJ9C0QTi1DhPMWv37a58OH+WAY4GeJGvPbbXhsH?=
 =?us-ascii?Q?Exb9nW51/hzg95isdDDFM7SEQX8WU7OAbLjMWvj2tdbomxP4mWWHYGQYcj9M?=
 =?us-ascii?Q?9Xgpr8jKsrwUWs4XcWW28QVl9TIedOAZpIycD2fuwHIIdQ1HA5ReOy/d9TdN?=
 =?us-ascii?Q?hgktwX6QeF1ApLshIbAn3X4y1OE+YvsuiTRrWbDBSiDV8v4O46aY4xrGNGAn?=
 =?us-ascii?Q?rfIHtf/XnYwa6zHf10iqBcQicBnvpHNs3N4ZX0pWSEXjhKVb4RNKS5XhHxJj?=
 =?us-ascii?Q?6/aUY7zUjKESlLbJrJJdKCZY/WgjWDf8Sqldp+rJtnizE7NdkuQlDDpvYzYd?=
 =?us-ascii?Q?sxMRbIIQaqXXT8HKTVlPgd509mne2xt13bYVUrSyjMwGeZldMbFEHI8I4i/L?=
 =?us-ascii?Q?54i9D24XKqeorSPlJ5W+X95fJ8glJiA+eSE8b0E1bgy7JExx9WPSzHSVsQm0?=
 =?us-ascii?Q?BdoNtcfP3/EYY0Yt8gQxXhWXVlEADSAeBRD/kgU+EcXOXCXK7k2M6+inWYhm?=
 =?us-ascii?Q?pAnV5CB//uO0z5fajgDlRV+0GkPXqgstkVKUx55M5xjrivAiXXsI9uxoBE5W?=
 =?us-ascii?Q?WzVlw+m5C5F2DCvJwt7WdWqZLZKGr9s223rarvSbJRC6qW3rAQBwm+6AMcmW?=
 =?us-ascii?Q?6H2x0I53DnIVOkXNz91lTX9QjmzJR2KPkSwQqXPa4j86jLGAaLA0dwS5N8VJ?=
 =?us-ascii?Q?w+7tIAdfZ/EdiHMn54qdEGLK2wL9r2kVRvuIPshXkyqsUc658fiuWSt56zgQ?=
 =?us-ascii?Q?GndbGSW0fWcUkFEJNQZ6q6+Fb5c1EDa8/UuxwKIfxGRaoDFENTynSe010wBO?=
 =?us-ascii?Q?dYUgFxQzHDx8FaxgT8bMydpZgttpxI6V7iP9iaNMZCnXYpa9i+M43KiZnAgx?=
 =?us-ascii?Q?s9yNPC2tG2/8mQ8r9ZIkmG8WDLyTDUyi25UmEb6F1R+2YZ5rqlT4cgKj7X6B?=
 =?us-ascii?Q?LW+jqbTZqoi1qv8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:46.6672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1940ebac-e9e0-4e69-949c-08dd3a1bc30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6547
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
index 1a0985ca479..b362595af83 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1179,6 +1179,13 @@ config CMD_FPGA
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
@@ -1198,13 +1205,6 @@ config CMD_FPGA_LOADMK
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

