Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A252A8077F;
	Mon, 20 Jan 2025 14:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kxn9jbyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C75805CD; Mon, 20 Jan 2025 13:44:15 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C557B80758
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXY9sPhHNzxL+Sdp5AMNEk4vN/mFM2eeyTTpaZs92Rryv8IGgW9hp3Hz/jVscYIXiYTCVfMLq4t+HACjh4FYPCGhjbhiHT/5+NJW2/HaIpaHHV9pvev9s+KDzs1gWmMkHJiRbWXaYg4rUzyCEOFbcjSUk9D5npIjEpUJMX6MmnlpQ+bJMO1SN77U4SVFgPxsaOUb86LXTYrxxkAL5oa93ovlY3DlNh1Y7Z7a2+KbkwfHHEUpgTnKG6KOCDt1Z0d2lVW/93YPWHglwYr+2xTs02eGaKCao7SwHXXlbnB6qrp/Wt1l+5hnc4e0Cp2lXyHq9aGhoZRYWOVSAcrtOT6pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqn/dmkB0/a0SlahVRpOo5SvCZ9tdzCf+59Z1IdAoEE=;
 b=Std4UWN1SDA41ilR/xKg6QKPhlXTy7T6aptw+EuLqwXcyZ9ViI41QnWZ7QvTKE+VTTRvsJ8EMHblPkWUPQ3Sh1nIQYanwlUTQSpAPOO0/J3UXPi+2EOD4eV7c4X8/G68wG53EMpg5TJVnuVEdq6/kMewv715N1ANLdpTL2mckLGYu8Bi3eGVXZ7jMTa7R+C3snM0/xvGoWBKLPDLgnq2lnEYjBuiXWmC5w7rt1DDI+Fi1V17+6l1bfW8acqk25ILJBnngNxf98U4/0qQFXeQHGhdbaRwz/2wyFarlplRzPzcsAc4Ac82wfu4qNkqg1XkCMowErmMtc1bNIVkMlbhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqn/dmkB0/a0SlahVRpOo5SvCZ9tdzCf+59Z1IdAoEE=;
 b=Kxn9jbyZIAwm+Eup1smlR/RaxH+cI33qu2W00W1mZJm+K5FR0OSuLXUyfA4suzHEUxigXZrNmEaqbiYx4hNyDLEascR4xvc8E5bP91kliFHTMncvuNLe7KxInuEVv9wVszH2yf3pqR01eTAW8/rTEzxRzKULhxeTvGveUWVfAjU=
Received: from CH0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:610:b3::31)
 by MW5PR12MB5681.namprd12.prod.outlook.com (2603:10b6:303:19e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 12:44:06 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::ae) by CH0PR03CA0056.outlook.office365.com
 (2603:10b6:610:b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 12:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:06 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:05 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:05 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 1/5] fpga: fix alignment on fpga cmd usage info
Date: Mon, 20 Jan 2025 12:43:50 +0000
Message-ID: <20250120124402.1501320-2-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|MW5PR12MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d0f1ea-bbcd-4c27-8648-08dd395020b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JNHe92w+jFGLZIhYNuCbu2d2cKH1KB0RiledBGjx6/T1FDVl2iyMXoWvIqFI?=
 =?us-ascii?Q?SIflhKqFr9NKZkUeIuzlkjQb7TLEiKcYdXTC24KtbQ4A+Nm0IN+mPMgUU5Qe?=
 =?us-ascii?Q?SwNSqidTZL8dKHBIsEfCLYKxPAI6kjDXqb10wh9ZdUCpBRjb2+Gehi5/VakI?=
 =?us-ascii?Q?Sw+up8RN2ICgv0PSla1FeW7HziwsrTNLdBkN4zsH5R6ttrvFYp6Srn7PosK5?=
 =?us-ascii?Q?6bFkC1z0Sp3shY1bxHVf/DpVwx7cEn3SZu0pCnB7nN/epObZjupouRqQ8dsz?=
 =?us-ascii?Q?94Px5bC9oUMub12kP1KbTnLZbB2pQ/bpQnMkXr7/Cjhc5NiyMQ8TCRJFkSh9?=
 =?us-ascii?Q?iomCJMhm4DvPb/KgIEKhDakn6v5rhJmzdlPJTOWwW88xm9zIgvVMdZ+XkMMq?=
 =?us-ascii?Q?0z/X7ZGS+18fX3W4xpwn52HIplRuyRDv24NNZzs/FclAYNgH11KJ//MTPJ1x?=
 =?us-ascii?Q?P6etwfOeTkKbvox+HSudM/V4Rioe21ra7A78KG9AkXsxa4JAvWLhVgkvA8NT?=
 =?us-ascii?Q?qKVquAow+rnby6T757WTnIZlZJfXmO6ZjEJTM2E8YfyXIMQgf4HIgKSCg+2t?=
 =?us-ascii?Q?gZQyDyarN58NZhbZdGKK17tKjtzxVkYOpWyBr4MV8cvjKuMXfmUETDFAlP03?=
 =?us-ascii?Q?GT9GNNvODWIqcHo/zBxdKdxix4KYpBe12L8TdQQTOP+FaWQOKPe/Mik///eE?=
 =?us-ascii?Q?SlKzdOp3wrtgJHngZQmJ2L38RlM1zy/K6BQadT3tdSE/+nhXTcbw2mcbODIx?=
 =?us-ascii?Q?T15lXALWWoFEfM7PhUOdgpoFJWask48A3M3msFqG31QWhDfrGxLIUurFGVqY?=
 =?us-ascii?Q?O12IFY1dQ/PL64AZVzAiZgiag0VnxAqfi0G/L5T6sNA/VgHLLSfx/NY2HS/2?=
 =?us-ascii?Q?5sm/kWZteLj8Gqwp75EU/j2rwbDI/k0h+blliFKzE8HT8acHrGaIZob7/gYR?=
 =?us-ascii?Q?BZJxawHIYgqtVHTDCOALd7rNJkksM7NluvmetTCxjpC2xPh06+Uaex5r/a5E?=
 =?us-ascii?Q?mE+jiqUlA/J2QcLjDFqjqxcjbJtYHiWTdPigaM2OO66khQRgAEK9CU6izBh5?=
 =?us-ascii?Q?jgZNBhd8W9fY8ELq8yRpbxPcaVoDnSUob0+C+r1CXYLWu63FvJmP1VsqkijA?=
 =?us-ascii?Q?O66JND0CG87DCfT6xjTLKKmHw/2G6YveGl7TMQevOzRKScRWTFNazeWFnxSf?=
 =?us-ascii?Q?ZAMP4b/Cu7ai6eAbMtaGNC4ezeWnmSMxdBdtxRYiWgEUGtc3yXTffoI1srZ9?=
 =?us-ascii?Q?jAeid7pnOmvYY9cCcAUKMqAUAWSGZkFSUtFKeLQX1XPC6EUkuNhbjt97PSWP?=
 =?us-ascii?Q?DrO90RBHna0TnVcPvzvfgoY1aX6kZvelu/mZVb4Q+G6qXjiHDSCiBK9s8h7n?=
 =?us-ascii?Q?YChvd8eMc+/pWBWVoqIoBfCnIN5OBfnwFTqXDwPi+WgzLL3pQq+kf8jSjebR?=
 =?us-ascii?Q?egiMgZHqxUQmE2LaNHuo4UOS26GXzJGpSYWn87msSHZnuPbNFS6SUq+apgJW?=
 =?us-ascii?Q?OOk77XZR4mJF9RI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:06.4893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d0f1ea-bbcd-4c27-8648-08dd395020b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5681
X-Mailman-Approved-At: Mon, 20 Jan 2025 14:08:43 +0100
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

