Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0984C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21289807E0;
	Fri, 17 Jan 2025 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C32JSfEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70F1806D8; Fri, 17 Jan 2025 10:28:29 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959F68069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZs26uAJ4eKf0cWe0uefVFhlAieMZWZ5yHrnrl79TDEt4TTwYdkIjDsQJX2QjXUNJpGdLO8ETVaZR037QBC5fEikOGDJaBkkP586lNbhfH747WKztgYDDqCbPGsCIhrE+dQ0vTBJ7XAyMfcKOar4K/Kf0el2m9I9TuLihwWDoLFStMhuY92Lt4Z/1UMDYW5xWLunrMHQUnR5WbT7khDYczpeapAHCbBLfhau9431eCJQFEd9QpI/6RQqaVE8yNohLtO/7WCvUZ4Q2OJHqOhJCCKtLw+ukKAHpRuAKkNT/VUJrw/c2KkJN9T/WwE3pGB0RK8lNzZ59pjhiAXwUyz0qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP69jb8HVMMbKjMKk1CvMORhOSeTcbfdbt9oDFcSPzc=;
 b=ujeEHx90tI4I45p0/kNGpgOAH2VhB9xAiQiNAgYL60mACoxwsr0nMijG/2sXkvpPv3/oblH5CyxkqZfsdqwXII/26Q1dxu2DWe81N0PyoMqtiLqQGQTc78y2NiLUWUdO3GnIl2laAimh/m7QCuFpWb1V9/tXIKRcIu8YSQgWA0/1R2DKYTB1hfhPNCajVvM8lHTRdrFO+eUN3rjQDPInj4hyxuhvcsceR1KoRRUsbGCpaN93F6TlpG0ncCr7d8ULZV7enUil1xiVvc7UgDcDzgC1pwNSNzlNrYch92m4asdietK7Vvck+lT1OrBK8w9mqK6Fvuv7ZsD2bN7hbAVL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP69jb8HVMMbKjMKk1CvMORhOSeTcbfdbt9oDFcSPzc=;
 b=C32JSfEt0ep+9Go0yDSw0gQunR14tdFdRPq67kHvkF5B0EcM9UdS3hpjZcP18EROGiOcGz0bgMFDCHqOElo9s97LIo1Qg268tkmhCJ2/DyWIlW03E8GczM2Pwb210OaGYzjio2o6oeE7zGg2kYjo+P/jv+tYE0yjMDPhVRAHojk=
Received: from CH0PR03CA0096.namprd03.prod.outlook.com (2603:10b6:610:cd::11)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 09:28:21 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::1b) by CH0PR03CA0096.outlook.office365.com
 (2603:10b6:610:cd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 09:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 09:28:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 03:28:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 03:28:20 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 03:28:19 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v2 1/3] fpga: fix alignment on fpga cmd usage info
Date: Fri, 17 Jan 2025 09:28:02 +0000
Message-ID: <20250117092815.2986832-2-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
References: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: c7261e9e-5228-4f6c-1119-08dd36d948d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KV+YDYPoVekZXmX/nMdSoXLb8DZYW8SuyvUoPnIXjnZjNXisj8ON0/TMKSDs?=
 =?us-ascii?Q?cklfQWIRcF6qpALmL9cwtTJ0BfSpgUvxCprKb1e0mOTl8QoXMBxaOlp/XVQL?=
 =?us-ascii?Q?q8sn/siSJr0gEdAYhwOtzpzuSipt30s4cothgtxESefNQqt8pB20ix/GG+aC?=
 =?us-ascii?Q?IVKZ6txPmlXPlsk/vy7Dmh29ED0gBaKl2t2cy+1FzscylaLl7hgs8RnKYmOf?=
 =?us-ascii?Q?gZt9RzTRgkrbrTtHavHgpksB1kbTFQ7f9nnss7EfmL+6MNIMpDa+qwDk9Z0F?=
 =?us-ascii?Q?7LzbHW06h1btD+g1akXMi7bB9244g6Jk45elvRsAr4nVyX/sOQlwWGgncMwL?=
 =?us-ascii?Q?zUb/XuofhPXBZnHYIcrcIoSmBwTB7gU9UflsAfphnopjtiLRz0PXTY2jZBRa?=
 =?us-ascii?Q?beY+oUrSV/2fNKB1ZRIcQz4uLQUBkNOpYU+Trf7P3xLa9bhTaDdq0vC48bxQ?=
 =?us-ascii?Q?ejs6/t1eeepHH75vm00ZqkRS+7CPX2Cy0mBwjW9zVCicwytZobRN9akGXSE+?=
 =?us-ascii?Q?edG+K0h5n9kmO2KumY1Ilm4jzcca0u9M+JXcfzmml97D45KsCfyh1vDo5psC?=
 =?us-ascii?Q?KH7P/AOdedRQD/HPbWWy3tC10c5m74Wy3EeoyQ87KTBjuDOoetYA6b+0g3AB?=
 =?us-ascii?Q?nP8ZDRNOJrgCmn2paa4lOMUYI5TkyDYzzJ+dq+X2hxOi2X2wnOxjZ4hIPlh4?=
 =?us-ascii?Q?OMHbx8DQj+Xc7TowalcQCiIwWA6oXp08DFkg5XRkWX04WRbLk6vEri/WnnM9?=
 =?us-ascii?Q?gK7hmv0jK5+zj6YMaipo2jL1CDGrI0zPYGA/F1wwssi1kIETxhvvlABg+YsT?=
 =?us-ascii?Q?4zdlon0lhwaghVOFWg3AGm09/KJhVhtItchXwR6UMOyPD0auqFpTutRfTNeE?=
 =?us-ascii?Q?yKAxCftUQPqE9StxxVSEFMbkXdft8xjvSnQpxudNvJy/FUjcX0//Roq28fp9?=
 =?us-ascii?Q?ezoGDlTH5lNQbi968wqwpY1den2C+laTdjOfSqpsmuodVuJwE4/x8upsE3Qb?=
 =?us-ascii?Q?VK7ERuBECsBgoRc68E1UppovcK+0e52dr8cHLaXKVBm/fIy/j5hX3bIUnufi?=
 =?us-ascii?Q?v0CvXoSXi3CpH+83PtIdWRCPHKkbzGPpw8PWY/4IgEDhzQCsydG25jXiaJBP?=
 =?us-ascii?Q?60rCXs2XO/4JybTsl4JAbzm/LYmy0jmEVAktnPH5w8bIzWgLUAiIx1rMTKEk?=
 =?us-ascii?Q?wEeDZfsGga8uZFjVtsJYePJ8wcgs3sYMR12sjNpIJ9cUBj8AbuuoEYp2OF7j?=
 =?us-ascii?Q?Dd5ZD25mL+SoDl5wqNpWRd7mnWVtl3VpTXHaPxDB72t0Np6Ep3byxrBC5ktb?=
 =?us-ascii?Q?JHn5o2U6O6s/96dGea2/IhtwXTBOlIOYy3h2ukwb5n3IH93yrllTnU6QqYmJ?=
 =?us-ascii?Q?eXBFhOUOzaR8l5ArnMVCRmHFZkjjEZMHmpJaaVVwEQn8avpNUW1pLcOZ0vWZ?=
 =?us-ascii?Q?HVFAM36H6cuFdx9S9Wr9ZFWsMR0WPtEceOuuujNW8QOqT52A3Lpu+gQG3LLQ?=
 =?us-ascii?Q?lPRmP4QsmAXQ3bM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:28:21.3242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7261e9e-5228-4f6c-1119-08dd36d948d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
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

The current implementation generates some alignment issues as well as
some overlapping when all the fpga command options are enabled. The fix
is intended to improve readability of the usage info.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

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

