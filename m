Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01553C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4016880757;
	Fri, 17 Jan 2025 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="drhpmX/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7900D8036F; Fri, 17 Jan 2025 12:26:09 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75B95806D8
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnPZT4pEKrLLYCjbbvomNm9Z2fnxA3vEJh1TVdE49EBYrAbLg2kEzu8fs2RdVseGFD5xgEjxhGJfotdpnLWWc8zhodPcSaSP4xl8Ef1AZSPiz976xV1AzZ5zlAmCqd7w3rYvPteSg95cEt7OvzWmXORsXghkTcL7T+hvoRWbCZtzwzKLxVY4uDJ7Y0SYG1KkRzIuitY60oc5ijnb81xTRFbQv96Co12UJFedrJ89s2JyNuXAT2MeqUApLt8oUMGCSy9qYmILt2kG5yLRmoCv9KOtGcU2qrucutOFsgAxjlEUTq3XGMk2g6del26eTA5tMYX5JmXqsKPrkmXTLpF3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAZu0eBqEss0vdHGBjNsk/3WwvutlkxMhO4+obquR8Y=;
 b=xUozRDcO/u01L3az8BV3uGY5Zop3dMEeXzrD49udxKKGpWpOWDgx+0lh0bDXyGDciL7LfdWNvGBN3Pt/Gr1lZBebtjIfwkBPuhi0Tdo2vvPLASgwtZ5fahLvW6/iqLapH5Ui/ncWTZgohQCXa2TMWXTTsQ79LZ569oxyvUkOoGfNbk9rJSNU1qtj/r1RqWDlITNHp+IQK26pLV0bKLJS5c0TbnP0rQbjmzUDhIydTQfikz6DL+GruqqRTkSMcDmQxBYdSv7n1EEq/1OYpemSIM1mdXjlhkQucMswnfQHTjzdth5pnCqtBKbZQ2gbwRd1sYq0ABJTuzACNlZDQEsfyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAZu0eBqEss0vdHGBjNsk/3WwvutlkxMhO4+obquR8Y=;
 b=drhpmX/Qkzlmz/EyvrmCSrSMjZU4L1BnuXhRfLwK5lV3Q1Ybe9hzZMLALO5Yqgdrnz7y6GaZZ4WNHvnXKMtBFZfugTzFBMNPIeAy5QD1GAGJF8RNvViv5xPkbJDn+8z8/wu4g2f52fv54w0vcgH1us9E5xJIH/YvLJ5/GJsFoaQ=
Received: from PH7PR03CA0023.namprd03.prod.outlook.com (2603:10b6:510:339::23)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Fri, 17 Jan
 2025 11:26:02 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::f1) by PH7PR03CA0023.outlook.office365.com
 (2603:10b6:510:339::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 11:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:26:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:25:59 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 05:25:59 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v3 1/4] fpga: fix alignment on fpga cmd usage info
Date: Fri, 17 Jan 2025 11:25:48 +0000
Message-ID: <20250117112557.3729416-2-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aa6f06-1dbe-413f-705b-08dd36e9b91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OfrF427TjGnfwFfGgESjENHLkqCBCBN5RF6vUu2dRWA89ZUXfqSVtjfqDBXU?=
 =?us-ascii?Q?BMAAbqUd5XMXjwJGjFzsjJNtah3zloLdKPZq8Ovzo8D326LEKrSp/9OE5OFm?=
 =?us-ascii?Q?tZhWFnP9vnHWF9hMOPaZNNdTKwwrleMGhCOaUP3mC6VyT8IcGTXeA7WnsvcX?=
 =?us-ascii?Q?jP6fW2QyVQAYHDi4zuv/qAWu5Zyytl/y0r73sdFVNQf89bH/2EazSPSEYyIy?=
 =?us-ascii?Q?+Uhmz3ea/i7757WZUiXrcrdzGLtQ5Cz0WcRVO1ZHQ3ZzNlA4BuCgI5aon63v?=
 =?us-ascii?Q?GHlGnAZbJLHOxbnpbG5HL0QmoGOhJH/5Uqz17rQsbkKGhTv55RWsAODhxPpW?=
 =?us-ascii?Q?xN4DqLRAMbrDtjeATBn3AYBT8N9vAwYePs7JIzfkB94i0BaTHnirxqyVHyt/?=
 =?us-ascii?Q?M84XmbESDot1XNkzNQ5rqhD4ENTFIGRoB2acjyzGxmDglMeIV88ot7S0oai1?=
 =?us-ascii?Q?Y9Bx32qIUGna4dqsAC0ylYma2ksoIHDIfo+dKK5aSQ6NOSn5qZYnHliGp8Jy?=
 =?us-ascii?Q?829zK+G7b81eLMhFzIv2Nvm0aPqZnhl0OM+ZMwAE3ur5iqnaySCB38bDPR9m?=
 =?us-ascii?Q?Jn4fMX1RespIiWI+lp+lihbp5BDpIJRwSo5jJ+4NAUS9+GXxoMU5xcE5wJXJ?=
 =?us-ascii?Q?v7FYrnEbDOLqsPk5NPzyBQQpMuB1TyMDSRWWDUicOYvJGhbInzPP7vLT6UWM?=
 =?us-ascii?Q?dfXfjECI5K3B9DlHgxq5bHvmDGw6CV8gibEZ1+GVPfW6nfwSvvJ91k/OcLR0?=
 =?us-ascii?Q?zTSxpX72WasacvjpgjhqRnIM1ipNF8cm7MIPlCLThx7k6hJkpt5glwwx2MaC?=
 =?us-ascii?Q?0T1mcFjqRfy2772v3vymIouWQW6prnk9ClapcCAK7vVseYpZ2jWLD9seMS6a?=
 =?us-ascii?Q?lCrzwv3Dlp+YXM6RpWVU4/SBKvpI6scLIc7lx+8yvnxV6V/pa0jwoXBraUZJ?=
 =?us-ascii?Q?+hMhaRmaX3Oj5meUyWmAqpx/0AvPf+cFzY8EU1tjn8Ayj1lgTt0uMM4YQQA1?=
 =?us-ascii?Q?xsJe09vRk3AGV/lCW2JATw2/98NW8TFKdKtTHZci2DCThtVgwB88dMiwSNHh?=
 =?us-ascii?Q?6V2hnr8AurSwtt8IzXbSZ5/pr6R95UaR06Tn9vPMQVqp+7SZZz4o6zIPhoqQ?=
 =?us-ascii?Q?Fp0wvDBSb+eBerHh39CPgAmXyVPi+TUa+srNcWMnvz/Kny5GFbyNq5CQl3hX?=
 =?us-ascii?Q?vhZoEbVAJbg6ZM8h0/vW50qgGTrnF0vgE8O01xGJ4cq3DR7ef1infuDAXtwX?=
 =?us-ascii?Q?NAVS0WDIG85BUFa5biVHdOeAQHKSAeCcllALnKUS/1PxWG3a2Yec7aI9PPrJ?=
 =?us-ascii?Q?X9SNXBeUXIjVYtTxyGuFvN5OFmuizdDg/t46WVtt7eninf1qPc6V45n2KEfy?=
 =?us-ascii?Q?VzQ5m3D0O2kzcvPYujxut2hkXJjyz9XzcG38rSltzsxuMsmb5FhWU1Uxbesb?=
 =?us-ascii?Q?E+rilUE4LNqb4Jp3cxCEihp+2xAJz027WGVMQl5MmpsaI1N5wqHxVoQzcuhh?=
 =?us-ascii?Q?TTj0Uh5yE5TwHJA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:26:01.5753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aa6f06-1dbe-413f-705b-08dd36e9b91d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

