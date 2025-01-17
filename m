Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170DDC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 14:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D60E80812;
	Fri, 17 Jan 2025 15:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ljAV6xO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B0F80716; Fri, 17 Jan 2025 12:26:10 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7886080716
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 12:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn9YKLbL6dynDG8xYgJNPYlFAvyT7NX2t6ZdWRRh5MD+W/204fcEKDlO1w/JoqTkbDuaz7K+DAyzjFsOCR6xrrXNHe+stSXuyg/2GV3khqJSGEA1RjSLS/tGOEqqjn75H4bVDtyxSiNubyRhb8H1Mi9pBnjJXlMK4otnkGdzNjj6+K4OgpP0LrfsM1EiNYflXz3QDHmr58ptpjHWOHjxpvX2IKRwZh4eyEZpKjeQJf2JjTDA3nTu4qVrcVSrtgY6ddoUoIXbmsoyGEKA+BtBHyMggP0zFu/dkka68CV7jOvCoDeeiMSTM7GrrPOvo18nNc/Cj8AfBuLBRJApVnaVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=wDEFjGMOTVdIHjmwaJbPw/8RBDX6WOVzuxw0/V28AbpAFXoxn3LOVeqqYKTnltkPUhHaaOZeiD2gDmOnSpBLpMA4vVjKfELkNpWz/VXir0cQwZ5noXMVk1B/S+yKefPjnj9IKe18AfxIY07X+TinFPYGHsSDfSdUjHC3iXW2HaUfKGTYaLmFP9bVcrrV7x8nwbPmFroLVqRgO/nVvGs1KfolURNDaxQ4ziw2Bx10Qfxv9lXKveb+7IYvcXPPXfaaL9z2+uDk/AMY0+pQOTBRkZNpT7hNrzLveE2ioH7kuAoX5L3Ks+s3Y+oHO1+MQigEGpJJc8Z2tf28ghngO4mCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=ljAV6xO/YarpFVnYcSHfeoPRVokdy8XdJ+ey3Dtfa8aCR/WC3oHnsmytPUmDz4HGLfhW3AtrvUZRRBjXgJAYBTa8BFxKCH5+p9yIWcFuSbHfRn4/yg3S7i1pG16FjAHyVf0HkTBLZcBx+cIESJ946BKDMH3yCRB16gFKNqqybyk=
Received: from PH7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:510:339::13)
 by MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 11:26:03 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::27) by PH7PR03CA0016.outlook.office365.com
 (2603:10b6:510:339::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 11:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 11:26:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:26:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 05:26:00 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 17 Jan 2025 05:26:00 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v3 2/4] fpga: improve loads usage information
Date: Fri, 17 Jan 2025 11:25:49 +0000
Message-ID: <20250117112557.3729416-3-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
References: <20250117112557.3729416-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: e6aa77b7-9670-48ce-a5ee-08dd36e9b994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lTF1OAjVpDggfYGsIzR0i/oO0KVGMxzN0PjA0zErIBPZwC9P7xY+sfLAi+jh?=
 =?us-ascii?Q?9ojvrgo8ewkLmtb0eAO8fx9Wcy1APSB7l7CmwjUlYNXju9nJuV76wkG7QEa2?=
 =?us-ascii?Q?2iGqk4/bNevjSe+WYvAg5LdR9wZJE3VYFASQVnRxwzOQcVqNUg/wmrsASo4q?=
 =?us-ascii?Q?hO6dEUlaiFYMCXw4APcxwj2woI2oKR2P9wv1DXJfbiM7hZ8a4qbZaB7JpNQr?=
 =?us-ascii?Q?CU1/EJIGgJMWMqoW3rrWj26IDI0fepGRMb7Zy954jMTMElFPofmzUC8gjIyW?=
 =?us-ascii?Q?ESOK6v/jajWd9CLgp5TwRNT3vQDTLBHoR7biN7YZUJAKOeHaweRnHkpcgb/I?=
 =?us-ascii?Q?0PDoaqgO6wV/BPfgYzDt6qepH1wqCgxEjVuzIdYIBYss0IsiBRawqmpda8kF?=
 =?us-ascii?Q?5GmOK5FY5q0c3OgJb4ceOn2e4i7lWRtZmU/MYBZm8awQYXfRhEI1rWjf6CXR?=
 =?us-ascii?Q?B62SXDtJJZVATHu54DnsX65F83l8FEq0EFhi1ufyPJcxZdHTTkG41VkVZ8R3?=
 =?us-ascii?Q?HpZAdbwIzz7KxJ1SHghBn8iMCi7FAvwx74sNeumpXhStxV85sTdDKXFfPVkC?=
 =?us-ascii?Q?DZUBxymd7IGUiYfbAGKgzz+W8+tHl7ftSXmwuJfNX5qiFpX4SwtXLNzy5HFL?=
 =?us-ascii?Q?IdujRcxZ5Omby39anbhZb2gPfgQIJPPREdZKaz/H/oJMCWwGiiSjpSgexRe0?=
 =?us-ascii?Q?tU5WQappoz1vU0pNQ71f/bjTy3MdL9GMQ4YUoCB02VSEK2w4qdhNo0IwetEw?=
 =?us-ascii?Q?keovZRus1uf1qAVWzFisgAMTdn9D/Nto+FrgPFx4ysTI58tmyARFfmQegVO8?=
 =?us-ascii?Q?bdppq7XabG3GoOXsSO5VXnSD3w5cUkmfU6yKntLyPovrL0Dz8sRKWdQv0x0h?=
 =?us-ascii?Q?Hoe+OPVMUrAbjowaaSeI368AhwJJNlHxNl1zOy9CR2GJarjL3O1E7AhNBvm9?=
 =?us-ascii?Q?RxilXD5kIyoJVqDW6aGqxBoFL4AlR/TNA8mbPEl2GMqPAGu05Z5jTUOqX37Z?=
 =?us-ascii?Q?HRfs97sYXVhJTnNsrbCqm5klY4iy+uFFS5fRTCU/1SscgslqZzBk5W7z8N0c?=
 =?us-ascii?Q?RdTMZaxLfjDhcs8VNeyoVlAHGmAx0+lvYlM8rWckh4k0hr0mdn1CO2JNJWFR?=
 =?us-ascii?Q?IlUUyZpr2iUAPs0t1a7cQzxaJ+ztJuiXQh5wYdfxmFhIdjvVHvFqhmGSDNO6?=
 =?us-ascii?Q?sAwgOiHhSvBoa2NdrobER3Nb/rMw86O8hlPfOMThUWIzvP0b2zVUWfJ/uPUV?=
 =?us-ascii?Q?lzxPcKgBGRKJS3/jAIKBVWdemd831t/i8EBsPtcxhxo7MVhFCmF+sMJDQp33?=
 =?us-ascii?Q?mNhACQYXIwWLg5K290PHfm2lpTTg032Zd/bVqnTV2PGY+vje7l/ba+Z5hsbg?=
 =?us-ascii?Q?1S+D3yaKpNonSoG89c6rdpERI4clpxcKOP25MUHdvjL5/Bc602DhvC5Gy8lz?=
 =?us-ascii?Q?CZ59Py1LDpBz9RdvbMVOJ8qQYbn+9/596I0rz+fU3g+hhVJzdHHOw0D5to5U?=
 =?us-ascii?Q?1u1Otri5NQfHK5c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 11:26:02.3566 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aa77b7-9670-48ce-a5ee-08dd36e9b994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
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

Current usage information for loads command is too verbose and long for
a command usage prompt. This flag simplifies the text for readability
purposes.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---

(no changes since v1)

 cmd/fpga.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index ae85ff201b8..91ccbee0fef 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -434,18 +434,13 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 #endif
 #endif
 #if defined(CONFIG_CMD_FPGA_LOAD_SECURE)
-	 "fpga loads  <dev> <address> <size> <auth-OCM-0/DDR-1/noauth-2>\n"
-	 "            <enc-devkey(0)/userkey(1)/nenc(2> [Userkey address]\n"
-	 "            Loads the secure bistreams(authenticated/encrypted/both\n"
-	 "            authenticated and encrypted) of [size] from [address]\n"
-	 "            (Xilinx only)\n"
-	 "            -The auth-OCM/DDR flag specifies to perform authentication\n"
-	 "            in OCM or in DDR. 0 for OCM, 1 for DDR, 2 for no authentication\n"
-	 "            -The enc flag specifies which key to be used for decryption\n"
-	 "            0-device key, 1-user key, 2-no encryption.\n"
-	 "            -The optional Userkey address specifies from which address key\n"
-	 "            has to be used for decryption if user key is selected.\n"
-	 "            NOTE: the secure bitstream has to be created using Xilinx\n"
-	 "            bootgen tool only.\n"
+	 "fpga loads  <dev> <address> <size> <authflag> <encflag> [Userkey address]\n"
+	 "            Load device from memory buffer with secure bistream\n"
+	 "            (authenticated/encrypted/both)(Xilinx only)\n"
+	 "            -authflag: 0 for OCM, 1 for DDR, 2 for no authentication\n"
+	 "            (specifies where to perform authentication)\n"
+	 "            -encflag: 0 for device key, 1 for user key, 2 for no encryption\n"
+	 "            -Userkey address: address where user key is stored\n"
+	 "            NOTE: secure bitstream has to be created using Xilinx bootgen tool\n"
 #endif
 );
-- 
2.42.0.325.g3a06386e31

