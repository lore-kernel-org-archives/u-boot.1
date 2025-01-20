Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A4EC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1D480716;
	Mon, 20 Jan 2025 14:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DoMEtyXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BC9880077; Mon, 20 Jan 2025 13:44:13 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0214805CD
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmpebfqOTn1Ld0uhtJbDV89rRJOOKZSjTDjYhulzCEYxiqxRtrapbvPI/ieV4RCcTzgZQNE4nZsBid9aq6h9EHE2AHUmqFoyhN9XxQuCZopzUVN6idnHLXsuc26XTUExQqmBOYpZyxJbHV2MQBi/Re22IHE135lEysq5IbKqQ+/MTEAFNoEexMo9AkoKJKdsEOJto2mCr4N2KnwGDti73u2ASCBM8MwggjbS6TwsnbauQ0f0pa+DTuk7QskmPrpvQGhl33UNnV+zn2odyxR7nvp/ohE2PrTGD+W57ZO2lbI51Z0iv86Kpw+wkvlNihXqHNrZfC8izH6E/QeGgMwQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=SDF9SNnv48ZxjMYpYOGtgQIXMkZ4PQmtn6iN6HR0B5nqNu08vH6BVc5o3O22MaTp+G2QBSgj2CrPXOJ0mQYZC/ZWpeaQlKB8Q919zVGj4yvhkRPWWtPCv69v9alWotQcY3nSldNnaxCVIYtqn6JhnGGFg43N7Ora/uL+jX09Sd1YgmZtuetY2Y0XHw4kblGukFuB7dtCVWcBHBiu+Ef7ffxOPbbox1ZqRHwBLc2hHbrsXh43Qzm9DXX7KXmq2vvxiENIxceJGGz6W+sP4OcB7T3v7Ejn1jR+bstFLHFq1bkhl8elACnRpd28bdUGmhnJX9k33pV9A8r5mWN2dQW6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=DoMEtyXktWAO568bUTSwiDiXK6LtCtbWp+DW0l+nHllRlwGTD4zcrh2T4EiRYoDr6f5k7khR/3q9myjpGDS/YMo9BSqlhGJ6TrEjustZ6bzrQrY6ga3bS5iYuRER54bL9CnQqI2Al2QP11vX4J/y22lyjzU8gRAzp5ZB/rwEJGk=
Received: from CH0PR03CA0281.namprd03.prod.outlook.com (2603:10b6:610:e6::16)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 12:44:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com (2603:10b6:610:e6::4)
 by CH0PR03CA0281.outlook.office365.com (2603:10b6:610:e6::16) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21
 via Frontend Transport; Mon, 20 Jan 2025 12:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 12:44:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 06:44:06 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 20 Jan 2025 06:44:06 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: <ada@thorsis.com>, Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v4 2/5] fpga: improve loads usage information
Date: Mon, 20 Jan 2025 12:43:51 +0000
Message-ID: <20250120124402.1501320-3-ibai.erkiaga-elorza@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b26818-04da-4362-c29a-08dd3950214c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ACfFRilO+9NDgLvzKUEOCDCTpmIrUY5S6tAvMvp/acOHBpZWPtv46vmxbnIx?=
 =?us-ascii?Q?PN9w9mWHaypKBkopNahrJljTDAfTZNHCz+Wl8buaoeN8l6blqOF2rQnMjafn?=
 =?us-ascii?Q?6qHSU5mbFL5bm1OnA/Lc70/6L9F8x7Ab2x+U+7E6CoMSy6HNpxj1HEUzRE81?=
 =?us-ascii?Q?/IACpyKhJTAmf/2IHHWF/ol5WWMzLQY5kjUtKRbGjyAFb8lReTGKySitq29c?=
 =?us-ascii?Q?ppplJWz+w4CoDp1gKahUwKF+/X473yJr9ntt9bPd6lVHqBAmT0TsHGLNaSpS?=
 =?us-ascii?Q?sIvpGIK1ZSBsBm2mQsceRPnGfRGxXUuc3ytxprFbUOKu98ojyEhV4Mbd3eYA?=
 =?us-ascii?Q?TuzLCWOA3iPDfdSMViOzWZFs1sPtmF/NHlYVNbxzBloAHS59PuOEp8qWGCBd?=
 =?us-ascii?Q?vzplCUGd9Z9+hN21jETONXMLdYx/kcoaW972Ob3R+apQ0wyXI1CbSZId0qdC?=
 =?us-ascii?Q?zoaldcwE0iwVDUHiGucjQW27KCbXf9YG1VSDSsRApjbc8TnmG32c4l5kxU1F?=
 =?us-ascii?Q?Ztd/IkioHbmNKD6VfFAjOXTJL5mzrPIWgHd6kVzSOZWnbbxYsmuv/SzOqBah?=
 =?us-ascii?Q?zMMYdLaUtURa28lkoTI1b/IBMhDtrdeecwOXG/x+bV2xpOh17SMPQxJZSX9U?=
 =?us-ascii?Q?4rU0ePL8VkqQKpKZI3hLFqW6lZOHLetsB7kpNLxlD/QXnGOcip6qSHzQ6jkj?=
 =?us-ascii?Q?+b0xjLSKhCffC3Fditi0p3QcZk4XB5y/zMwgMLUmTj0+YMmiD8ufb5tAI3ke?=
 =?us-ascii?Q?Ki7PqfZXSSpQmpFFFtIAVcsMAm72spDrvJou263o7nqkHiBCNVtODTqMYuJh?=
 =?us-ascii?Q?I8yIQR0tmXBmPtOCvz2YycFbLZEsUJXpbb/offoxAwNbflP70jKxWPjYFvjv?=
 =?us-ascii?Q?zZyhiybVGSQcM4B4CTU8kxh+ExsWs5j7aH/FHyUjEB6Jl+g+dcZ4KpPeFO5x?=
 =?us-ascii?Q?kvZrsQlA8osAHxdsh8+tJYzHCOHQFoSxoiWtKDeJlMMaLQ/7UNn0Fvn/xr1f?=
 =?us-ascii?Q?lrbTd9We0u2sBVpwFMVdpuJC4fa42I9h7oKcAy4UcpvJ5AlQllSHVrq/yU/o?=
 =?us-ascii?Q?aNG4vbUqu4NUM5H95g2uTZPmYIeG1+eZUa0f3VWelIHQjkdBhbExoEPi726o?=
 =?us-ascii?Q?0NZjgSE0tkdf6eTZbTpgDaQlcfE+e2FUXku/Ht9iWFzDiJWGehsj5nm2i/Ei?=
 =?us-ascii?Q?q0omGajVoC9uj+wGNiNTesy+ipqpMnzViOdpOJ4P/5Yrp+P+oDbXd8fE/0xe?=
 =?us-ascii?Q?/gqZwU0H+sl9hoaPnxvXHpnk4vaxNPM/zbS/z0IxHjLsNmjbMo+WyivvXqs5?=
 =?us-ascii?Q?Z+5X5As2XxoOHyUE8rK+vYfVtlkjoOgzWQwTrlDCGRMuKKRssW9ZbNyxzpum?=
 =?us-ascii?Q?2ZE3Zz+sUqi18yUq7l0jT4zAjcwngyx9PMw6hPvzlYnAys5nxN52wU03/pNu?=
 =?us-ascii?Q?R5x6HEZKItIUFaSXnQSVvB/uE55W26ToTrWqCwf/ea5KxWP3kudiA+NJ2sUo?=
 =?us-ascii?Q?rZYBgqFGaajSQgU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:44:07.4386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b26818-04da-4362-c29a-08dd3950214c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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

