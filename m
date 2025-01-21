Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5464C0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A216180763;
	Tue, 21 Jan 2025 14:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyk86OP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AAA98078B; Tue, 21 Jan 2025 14:01:53 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1783B805C5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3K3b5hEPFzbChNX+rsD4ZD3SLnlZuL+UqcIyIGCc5GySpos7G33NKmbEDW4wDQm3bnh0PYC8aKFcCfBENv0tlnaw5zirzrDkmtYoBbC84KG7E6+Kr0oIEpyfafRcde3ltwv1Bi0EKB9UuRFAgyGvSsvJmNfwDsSSPW7sMbgZiLPdLg/B/Kc8Gynsx5RSjzIBKaKqe4g86o3SUF0euX0j18STx54lvowp1ZF+thgretQeOfeonddpbJnf4hVh2Q5D7nqlXxTThrKT6uoIjhCOgL7NUyOksohWgn48ngdrsJcQcSJt1KPWkvMnbDs5zRKi4tL1eoYaw1HE88ks9GERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb7DQd8ysMu71MXi6Ly2z6yxZ4YP23VzejHO6Y+hmzs=;
 b=fkr9ZRNmk5kOrMYrFf8bVlYDT/1/PyHVA8n02H+PCbedYvBYwiWleKCGwSQDaXmlygnEyhPJdhmK0R8PJT7v6XUfnjCHJ+3R0WqI3aSn5de/iU8mlVWeq1KiixeFjK/+ufCyToKcs6vodkwRwTCQ6OtC5HrnqPBcj57XBILrPWNy06OF5ZixC5xotwGdgy8K3oSn7obqD4I9XrcEJD4VeBQ2uWyddgkXBiYK4NIBXKy98GaSk+bgJYGh1O2dwRW326qIAVGOpzpB2wO5BW4lUyOCgsYashPCtFugzDggwwCDtg9Fh92qw8nrdmBV8l8A3h/xlsHsBxJltKVplqdsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb7DQd8ysMu71MXi6Ly2z6yxZ4YP23VzejHO6Y+hmzs=;
 b=qyk86OP0EnAD72rP1FhqhU66VoAxXxwrvCyKDa623lEoK9qZ2owIirwC6WwgqU/IZl28mwkJGahIc/pU/iWHrAHPdhRie/WXHHIJEvF9Gjdi746w35zoijVwn1eUp2zRcFUhkfPNS2UeW9z3VjxSDG4SciKQMlUXhzXR63TURNg=
Received: from PH8PR02CA0049.namprd02.prod.outlook.com (2603:10b6:510:2da::25)
 by SJ0PR12MB8090.namprd12.prod.outlook.com (2603:10b6:a03:4ea::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 13:01:46 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::76) by PH8PR02CA0049.outlook.office365.com
 (2603:10b6:510:2da::25) with Microsoft SMTP Server (version=TLS1_3,
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
 2025 07:01:42 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:42 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:41 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 1/5] fpga: fix alignment on fpga cmd usage info
Date: Tue, 21 Jan 2025 13:01:30 +0000
Message-ID: <20250121130138.1999916-2-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ0PR12MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f6aa20-882d-43d8-21f5-08dd3a1bc2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3DbWv3kYjTHbS5TqGSKUeXI1tWZJQtB/OrjXZyZ5/JlYwOTZD3DHFmsVkNzh?=
 =?us-ascii?Q?IqSEQwS2BP7CkAiLalX0iVUP5BPl6uqvzWgBu2jlGebbJ+4uB6PmP/7bl6Zb?=
 =?us-ascii?Q?vsfsaySzuxS/iCCdW34/wgGeMXBHSPMZGyopZeFdC6CmydtjSfoyJQyddeIK?=
 =?us-ascii?Q?Trzzvj9yhZX54Bvgn2RrrsB9Y9uzkTVAuVu89RYnsJ2t3YL5Hd37oAxwFwpZ?=
 =?us-ascii?Q?DMOSNMBmA+7vBtMtWUdHhuPlNOmM1RFKs3YdYPzmHz3L4GlEwJHqJLRxzu5A?=
 =?us-ascii?Q?OMWF1/r+nFMJi3XGUesamEH0JlxNL8qRUze3e3Dbo9jUInkAumL9lFO84YAM?=
 =?us-ascii?Q?4UpiuNcLx98dOAYLbtYKUE/6zRr3Lgz7n+LERQh0tKT11SKvE2m3W+FYa+Pq?=
 =?us-ascii?Q?XCfM/IgbTwdWuHugTXRF61vmuzBQESrcPrOzcEucJy2Xaz8y5ZP6tcC2F+Fp?=
 =?us-ascii?Q?+cNlI25qtE9j2L5jAtMaG27RDtB/S75pXXfVW/E+SNIDAs5QUtV7ptBmV1kN?=
 =?us-ascii?Q?ndsf++0cznGq1ymkkETb/vi4trqrwfnHRRBVo6xVW2kffXlTuAGhdcWKy84h?=
 =?us-ascii?Q?2+5LpFjkM3HPXA+nBcF4kD0B/m7JX7cPIuAZJ6pvokt4bR/NHUapXwr5vxBG?=
 =?us-ascii?Q?HQnx9MgeGQDSrLyBiNxX0C4wNAdJ+5F37qw8r9VtVSXTdOcu1BFrmY7t2r6C?=
 =?us-ascii?Q?wUymTfn7SFkqgo9IhM6K2a1tn9IkjQcyoVfbwBkn0w2MN8qv57VKh2vGZK6w?=
 =?us-ascii?Q?pg163Jq8pyevq4F6OEyYIjF5KHMqjW9y9VX4P04YPdk8f19ebqKO+pVuSdZQ?=
 =?us-ascii?Q?sRtJoR3VVRC8PiePY8KyypbG+Q3p7v0aQGM5XIA0wzphNUL5IotGKxPhIwCu?=
 =?us-ascii?Q?+WsFVYix3SsCT7wLU1e5KqYtzD1/bICmIQkEPfVpEBL3sjJzlsees1xBNY8l?=
 =?us-ascii?Q?oVToY8wRwXBDSq6sazKU9LRhERBf8km7SCbfVR+v0kXOkKLDW/HUXPXxrS5H?=
 =?us-ascii?Q?2DSs6m8brEVZQKyItYpeAbXCHm5kJjlgETphL/2c/IYPV1ZoqwcIf/Shb2Ky?=
 =?us-ascii?Q?6Bd5IzCnpjf0udA7CnJ7XSquWz8V9mB0R5Jy6+PWJcJeHjjXkPtHhrLGOZuc?=
 =?us-ascii?Q?frK8mopUgr34u5K9iHdBeDYbofLwpxBQGeAXVzOyXvYMVCnrPVMh1bb00OgB?=
 =?us-ascii?Q?R5tOiMLnT6LQAI/sUh7JoBNNx2/K4Wq9cFL0Kv23WK7RsxFDE1F5mSpNbL/T?=
 =?us-ascii?Q?xHYKFs86UEfjSUHGW8dJrp4sZ7c1SbBImAFtHUa0RRUh6Kq2sRaCtZv4RgQB?=
 =?us-ascii?Q?xmFKwgH9+t3OiygZw0jTx6i4famD3iLcI9hIj5GqPK93Qw5uKPKGBESQJ5QT?=
 =?us-ascii?Q?jIFS8Jo14krZJQ0o88CB2VCkK2yQZHBejKfBZo+FHi8PDFUxKls1CEdjwKL+?=
 =?us-ascii?Q?kADPgrxxgbjo6unaXvqHQZB5Nxt4WWk+1egceDqFM4iKRsS9Jyyk69lSmtJb?=
 =?us-ascii?Q?IDntlnOKNNbRNEI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:46.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6aa20-882d-43d8-21f5-08dd3a1bc2ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8090
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

The current implementation generates some alignment issues as well as
some overlapping when all the fpga command options are enabled. The fix
is intended to improve readability of the usage info.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Acked-by: Alexander Dahl <ada@thorsis.com>
---

Changes in v5:
- Reorder KConfig to ensure commands are listed in the same order as the
code.
- Clarify the bitstream file type for load/loadb/loadp/loadbp commands

Changes in v4:
- Split 4th patch into two, one for existing symbol dependencies and one
for the new symbol

Changes in v3:
- Split 3rd patch into two, resorting commands and Kconfig changes

Changes in v2:
- Tabs replaced by spaces
- fpga command added on each option similar to other commands like sf
- Dependencies to Xilinx only commands added in Kconfig

 cmd/fpga.c | 61 +++++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index 93f14098ccb..ae85ff201b8 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -408,49 +408,44 @@ U_BOOT_CMD(fpga, 9, 1, do_fpga_wrapper,
 #else
 U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
-	   "loadable FPGA image support",
-	   "[operation type] [device number] [image address] [image size]\n"
-	   "fpga operations:\n"
-	   "  dump\t[dev] [address] [size]\tLoad device to memory buffer\n"
-	   "  info\t[dev]\t\t\tlist known device information\n"
-	   "  load\t[dev] [address] [size]\tLoad device from memory buffer\n"
+	 "loadable FPGA image support",
+	 "info   [dev]                  List known device information\n"
+	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
+	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
 #if defined(CONFIG_CMD_FPGA_LOADP)
-	   "  loadp\t[dev] [address] [size]\t"
-	   "Load device from memory buffer with partial bitstream\n"
+	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
+	 "            with partial bitstream\n"
 #endif
-	   "  loadb\t[dev] [address] [size]\t"
-	   "Load device from bitstream buffer (Xilinx only)\n"
+	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
+	 "            (Xilinx only)\n"
 #if defined(CONFIG_CMD_FPGA_LOADBP)
-	   "  loadbp\t[dev] [address] [size]\t"
-	   "Load device from bitstream buffer with partial bitstream"
-	   "(Xilinx only)\n"
+	 "fpga loadbp <dev> <address> <size> Load device from bitstream buffer\n"
+	 "             with partial bitstream (Xilinx only)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADFS)
-	   "Load device from filesystem (FAT by default) (Xilinx only)\n"
-	   "  loadfs [dev] [address] [image size] [blocksize] <interface>\n"
-	   "        [<dev[:part]>] <filename>\n"
+	 "fpga loadfs <dev> <address> <size> <blocksize> <interface> [<dev[:part]>] <filename>\n"
+	 "            Load device from filesystem (FAT by default) (Xilinx only)\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADMK)
-	   "  loadmk [dev] [address]\tLoad device generated with mkimage"
+	 "fpga loadmk <dev> <address>        Load device generated with mkimage\n"
 #if defined(CONFIG_FIT)
-	   "\n"
-	   "\tFor loadmk operating on FIT format uImage address must include\n"
-	   "\tsubimage unit name in the form of addr:<subimg_uname>"
+	 "            NOTE: loadmk operating on FIT must include subimage unit\n"
+	 "            name in the form of addr:<subimg_uname>\n"
 #endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-	   "Load encrypted bitstream (Xilinx only)\n"
-	   "  loads [dev] [address] [size] [auth-OCM-0/DDR-1/noauth-2]\n"
-	   "        [enc-devkey(0)/userkey(1)/nenc(2) [Userkey address]\n"
-	   "Loads the secure bistreams(authenticated/encrypted/both\n"
-	   "authenticated and encrypted) of [size] from [address].\n"
-	   "The auth-OCM/DDR flag specifies to perform authentication\n"
-	   "in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication.\n"
-	   "The enc flag specifies which key to be used for decryption\n"
-	   "0-device key, 1-user key, 2-no encryption.\n"
-	   "The optional Userkey address specifies from which address key\n"
-	   "has to be used for decryption if user key is selected.\n"
-	   "NOTE: the secure bitstream has to be created using Xilinx\n"
-	   "bootgen tool only.\n"
+	 "fpga loads  <dev> <address> <size> <auth-OCM-0/DDR-1/noauth-2>\n"
+	 "            <enc-devkey(0)/userkey(1)/nenc(2> [Userkey address]\n"
+	 "            Loads the secure bistreams(authenticated/encrypted/both\n"
+	 "            authenticated and encrypted) of [size] from [address]\n"
+	 "            (Xilinx only)\n"
+	 "            -The auth-OCM/DDR flag specifies to perform authentication\n"
+	 "            in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication\n"
+	 "            -The enc flag specifies which key to be used for decryption\n"
+	 "            0-device key, 1-user key, 2-no encryption.\n"
+	 "            -The optional Userkey address specifies from which address key\n"
+	 "            has to be used for decryption if user key is selected.\n"
+	 "            NOTE: the secure bitstream has to be created using Xilinx\n"
+	 "            bootgen tool only.\n"
 #endif
 );
-- 
2.42.0.325.g3a06386e31

