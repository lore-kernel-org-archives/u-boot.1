Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D350C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD7F807E9;
	Fri, 17 Jan 2025 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UtF7dpsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22A5806D8; Fri, 17 Jan 2025 10:28:31 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5F680737
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9ID6YT2cTHy/7IYDBopLN/06bBjdCLVdQRJQcPAJv/0K04SAUh6795+AQfDbMiixqdqGL6XtER7RuWaQRPi6VWvCDOrSSJuvNLwNmVq4uN8+xpZg8H4TCmWQGEjLXk+clAm4l91a/O5q0nS6lVls4sFkxrlmAgyd1V2XiaQcUcxBRdnSr9j3iOE/jSrsNs0vDsrSNibSBzCQxlT1//69/6LTt9T007PkCveqx7WvADuDbeupX5ld1cPYvrbzqaZ6wMPtoKoclNM2e4grqeIo1S505qxb5XOF3EAHlhecKk2F4RgMNLJZPEd81O4PdES4Afiy9GvrUyR69i6CnN8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/REpDkTEzWfnL4wd/h9YbU3X+TI7kukkhY99ewQu70=;
 b=bJ09hWPFssnMNi1xTPBCSgmju1pmacm9N4nxAkxMlVFNzAcizL5Gy6YlZM6+Y3FxOiZi8lmK6FyoO4Z3Q0byICrLWSIxd0FJjPWGLkR+izz7m447DpjS2r9PJ2mshqBtjoA4xN3PMuarDY//gMfs6vrJqIwFQov/8sOZH3QUPTfMoLFyKyRq62Uh891U4tLvOhEdrf+7Wv86rwAEjgWwGqtYyg2omsaf0hA0L84LkLxITWzD2jKD9w1kFd1kVprRUFa292riNdh+YDbDWRiSGHcSOgRz2KpijxdwSZUCPvWX1lb51RAdx/wN1NuhDihbZodOJQS8Nw0zteRFerrSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/REpDkTEzWfnL4wd/h9YbU3X+TI7kukkhY99ewQu70=;
 b=UtF7dpsrAbcO+53mXaW8RzWfoM2XBifRNFAsKO7CjYwVGxeDN73jKQDjeywLlbEYFkl7kFwIx+7JAOVApT+gVKE/xOZnaWkn9RB4tJUNny9KpWFBD8wL4Gst+M81Gk2LyL3vutz9GdXPccCuaZX6jE2wD0bc8xdrXOEBbOW+2/8=
Received: from SA0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:130::32)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 09:28:24 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::d2) by SA0PR13CA0027.outlook.office365.com
 (2603:10b6:806:130::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.6 via Frontend Transport; Fri,
 17 Jan 2025 09:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 09:28:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 03:28:22 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 03:28:21 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v2 3/3] fpga: xilinx exclusive commands info
Date: Fri, 17 Jan 2025 09:28:04 +0000
Message-ID: <20250117092815.2986832-4-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
References: <20250117092815.2986832-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: f66cc760-62a2-4c6e-2d53-08dd36d94a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZMqxLHeWeK7t/qOfwW8mmpiVzuIyVNt904e9dK7r3Mupxx9B782BxpngrbLn?=
 =?us-ascii?Q?9EyuDP1GGj6eQG3kJRbGtv4zyKY4Zbkkjhjf846BLSSprA1a9/XcfbnbBwYz?=
 =?us-ascii?Q?En3znhe17Iret9zrzpTUAi0Hb6s9TZeUcNycR04yHg9JHXbL9EEWtgvDzVY1?=
 =?us-ascii?Q?nC7VFqlSssZtxJgrZn7GhPyW4Nf696WWu+kUv3wkqA2iHQ8CzPCJkJvOgQyq?=
 =?us-ascii?Q?k2DejuV60hpqpiGTXv16EQhRnZXIzgjYGMhVL+FyJCK030x4JLUEC4ICDNYW?=
 =?us-ascii?Q?65R5euXb1LfE1Ws03KTy+bFv/56SuSFmDnJ9AYxq3T2jZEmLRYCc2b8pQs4H?=
 =?us-ascii?Q?vgWAiL30G2/Xy7VfrDMJgyTZUSeQbrssfj/Ag0QVTMJuikaigR2ki6+b3JOY?=
 =?us-ascii?Q?3JXAYIXvceQ7IeMx4zI5zbya5eM3F+0QAJgicUhZzW69pv7WxmiQ0exAFIzp?=
 =?us-ascii?Q?e/NYmBJXEDQljn3t0vh0QkhKHQbvP1W7d4Ev0xHnXABKgyJoUKyZvWwTwJbN?=
 =?us-ascii?Q?+ounbp9GOcUUWl6cNDCxUmG+PSVROgYJk0JpmYd59rCIDLGLqfDohDYfOatW?=
 =?us-ascii?Q?GJpNBJoBr5PIAX2zcvQwMy9VFsYqTviTx6gMnaF62b/EHogWFZpj6yMOK9FY?=
 =?us-ascii?Q?ybyzD4JbS0NZbkv10A/zuCmtDPVurRkctrN/Aj9rrptM3LktVUJPyYqbfgjA?=
 =?us-ascii?Q?RD/I9i0rZsJ5QYSrk2Po6UltdxBPP7YAcSyy8WhJ2XNeWQuxqKITCFaxEVtQ?=
 =?us-ascii?Q?1pQKuY3FXUGyLj8Zhk00/4+Arce+gLjM4U3Z1eRMr8IoWToXDlhbbKqpdOUW?=
 =?us-ascii?Q?z+vOwNIlgQJ65ygRFKoNYIskxxIyrH4gPdYVRK8ZVq54bPZmOYSuBhqX1ijR?=
 =?us-ascii?Q?JZ+/Ky0f0Zd4pbbg3Vq/aeDfUgDdgurNLL4C0NogVNLhuOfV0XN8osvf8T7Y?=
 =?us-ascii?Q?tMuoF3Ty2TF6yhoxXp0Oj3h1U6meeQhAEZcjYeFH/q9IuKIF5ZyAeZmud/Yv?=
 =?us-ascii?Q?nfOoumnXoUAZcAhEaQnwh96Gmj0zpqJdDUTFg0dQ4MskPiJHyoKP0QgQ+z6H?=
 =?us-ascii?Q?qkE/RS06Fp1bl5IG0DPZeT3HcAqXncpOQQyWZYqRonObEvp5t2Nm2DVGE6DK?=
 =?us-ascii?Q?JrliU34zAbH5khDASPpegw2JZw/Hiwonslz3/N9rIN182JwJY6ilkjlNB1jT?=
 =?us-ascii?Q?ttzHnoZIbMUxmWY4ac8lS1fxZuDeCzU+smWcDBdLo2Vc/zWRT2GM5jP7HVgD?=
 =?us-ascii?Q?6NI8QMnN/a+CPV9hXCEO1iXWIGKQGxQNAvPVR57YOz7yOh4XQii4PcuS6pga?=
 =?us-ascii?Q?em6PCwIZxtmrxkprB3JIjE4rhHdaPF7syDCcGspRKb+ydXgvIMHyvcz+P5qR?=
 =?us-ascii?Q?VSQ9ZsRXGlQG2SG92ROvm7151MuG7fNv/L6QlhwQV2Q0VKgvnz1uTH1VEu0T?=
 =?us-ascii?Q?JuT5V0okWECQRg+Hkf438LZgi8+WPiVMryKrKAuXJfSD4AuCu85kxW1XWmCl?=
 =?us-ascii?Q?uxz85NlrC0TSUBc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:28:24.2266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66cc760-62a2-4c6e-2d53-08dd36d94a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

Remove statements of Xilinx Only from the fpga command information and
ensure Kconfig dependencies to FPGA_XILINX are implemented instead.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

Due to an issue with patman I had to add an empty line on the
CONFIG_FPGA_LOADB description
---

---
 cmd/Kconfig | 32 ++++++++++++++++++++------------
 cmd/fpga.c  |  9 ++++-----
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 1d7ddb4ed36..31f1df2a67d 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1163,16 +1163,31 @@ config CMD_FPGA
 	help
 	  FPGA support.
 
-config CMD_FPGA_LOADBP
-	bool "fpga loadbp - load partial bitstream (Xilinx only)"
+config CMD_FPGA_LOADB
+	bool "fpga loadb - load bitstream"
+	depends on CMD_FPGA && FPGA_XILINX
+	help
+          Supports loading an FPGA device from a bitstream buffer
+          .
+
+
+config CMD_FPGA_LOADP
+	bool "fpga loadp - load partial bitstream"
 	depends on CMD_FPGA
 	help
 	  Supports loading an FPGA device from a bitstream buffer containing
 	  a partial bitstream.
 
+config CMD_FPGA_LOADBP
+	bool "fpga loadbp - load partial bitstream"
+	depends on CMD_FPGA && FPGA_XILINX
+	help
+	  Supports loading an FPGA device from a bitstream buffer containing
+	  a partial bitstream.
+
 config CMD_FPGA_LOADFS
-	bool "fpga loadfs - load bitstream from FAT filesystem (Xilinx only)"
-	depends on CMD_FPGA
+	bool "fpga loadfs - load bitstream from FAT filesystem"
+	depends on CMD_FPGA && FPGA_XILINX
 	help
 	  Supports loading an FPGA device from a FAT filesystem.
 
@@ -1182,16 +1197,9 @@ config CMD_FPGA_LOADMK
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
-	depends on CMD_FPGA
+	depends on CMD_FPGA && FPGA_XILINX
 	select FPGA_LOAD_SECURE
 	help
 	  Enables the fpga loads command which is used to load secure
diff --git a/cmd/fpga.c b/cmd/fpga.c
index 91ccbee0fef..f46ca040d28 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -412,19 +412,18 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
+	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
 #if defined(CONFIG_CMD_FPGA_LOADP)
 	 "fpga loadp  <dev> <address> <size> Load device from memory buffer\n"
 	 "            with partial bitstream\n"
 #endif
-	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
-	 "            (Xilinx only)\n"
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
@@ -436,7 +435,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
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

