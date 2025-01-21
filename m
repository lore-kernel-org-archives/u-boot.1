Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE71C0218B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 13:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62874807B6;
	Tue, 21 Jan 2025 14:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ocmneQYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D8C380763; Tue, 21 Jan 2025 14:01:54 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF1C8076E
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 14:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thHW2r4LEGibUB8ckgtP/eVt5MxyZSMIvOGlEF5OZI81gAWHhnGnkBoTToK0EQVrr4dChusDA693tQ4MflKcVrSEBEZNF41C7pw3yJlh3j4QDkU9xDETG53r+yUL6jJLCKK3fCTVOxipXp+roTubw5oMR5NCNYZTa0+ThKBSa/R2Q/uDd0/3qmMIv96QhU6hB2e8HiMQ1PXHp3dzO1HkdcncbK/ycXwgKoHBVL487M7FuVY74HF4l0F3rMktzE0AfGZ5Iccbb6voJBRyi7s/9UnOrNlmS7Y+F24vvicv/VandIyO1oQ8IQ8Bhd2+/V6FMc1nEUD/w1U5Jx62NK203Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=lmdEeeE7F7r+LlwCrY9jhAH/yW9Gg7KUh/2KpYfpg7DKuTxFdjfGENREa007cX7lhuOa+FI7GkMAZH31PuvdpyHeFFsLVnd6stvkavH3vLp6+aILbSG11me/WU42/uKJUBX8BEgZCPstblBKX2cygRwBxI3PxdTFZ8hhr3c+hxxSs2rO60LmzefBKp6LIN7sv3EUc034h4ekmzJ64DqSEK+qBrfixxUNXpbSYpToekVav+WNDfXpWyyPfncq6NJ3mJ4wYChbghZpSNMItDAXALvtMMVvihTbX3kYvf4TpNBP4bKnELXzemcHkecn7YYSN8nR8TooaknsK+/wMLTBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MSON9Pm3oAXgOLg8Kxq7AWdv4C2+cGHWwzfWb+0lU0=;
 b=ocmneQYL4q57q/ck7JFEAAsRKQruk8OIAjSxGOPRevmq0EQ0ht5F18YU0tTdoLJ5pz3XM12asfqTahtbafb0TMVt6/Pqh0d72DeCO09ggjeANg3ljS/z+deyCQW9nqR4ir2hkpJOuHX56zBkioTRm7pzF0/rr7YD31DtFpIxAvc=
Received: from SN7PR04CA0199.namprd04.prod.outlook.com (2603:10b6:806:126::24)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 13:01:45 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:126:cafe::a3) by SN7PR04CA0199.outlook.office365.com
 (2603:10b6:806:126::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 13:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 13:01:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Jan
 2025 07:01:43 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 21 Jan 2025 07:01:42 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, <ada@thorsis.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH v5 2/5] fpga: improve loads usage information
Date: Tue, 21 Jan 2025 13:01:31 +0000
Message-ID: <20250121130138.1999916-3-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
In-Reply-To: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
References: <20250121130138.1999916-1-ibai.erkiaga-elorza@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: b324f1f1-0a64-4994-37d1-08dd3a1bc1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHjYibGRSM7ihVYPgPQ0ozwxR/3g3Ur1dlOQfsbC+5yE6p5hvW9GzPN9dd6u?=
 =?us-ascii?Q?b5PwjxcU6GJivYdCjnEtaqC0DecvJi7MDiGWcGPnXfqpS5H2EKNfyywCiVTc?=
 =?us-ascii?Q?1DRMV86HAK8Yz1Hhrcgpp6Rk54j4CwFtdPzBfVcmnuUkgWGmUdoDIE2KleFE?=
 =?us-ascii?Q?xNKQy6P0I988bJRxm3K7Sj59DZjKtzjD2uJesw/39WdR5tVWQH95gn7qjCIu?=
 =?us-ascii?Q?0w3Qe4lbyyJxWFGooJ5lmRaEbsxqs+tvEOGBYhn8uHc6M6T4l3gvgNhen8P0?=
 =?us-ascii?Q?cv5Bnfw4kWxM2gbdnEglFyeL7DWSITIWPh2DAWBG5k3UL+SC/SfU4BQjTHE2?=
 =?us-ascii?Q?peWItfvv2gyDPsqFSdldjY/2PQDXcZ/a3ScXrHzMCCXme151yjYcxZ8pSEbR?=
 =?us-ascii?Q?n9XNqjDbi3eJl2TEeElb/zChSqKAVnaLfEy9IFNSV8ZtPTcotgVnUP5441kv?=
 =?us-ascii?Q?M+xSY8HJDtSq0w/xX1vQg0OPedLPheQJ/c8WfPWfJZ7qCyZ23NNXV7X+Q9gF?=
 =?us-ascii?Q?YUKJSOMGSRCVVggQ2KaInhsF4IkctZ+DH/0o7xdO9RdJSVXBfMhFW+ZcVHsQ?=
 =?us-ascii?Q?6bxbUIGyP9cCAPaZTXVEe0ivWcdvOjRGKfV9qKk2D2tY0DtN/r1EB/QW3esB?=
 =?us-ascii?Q?Tb7skSNFO9xd9fDSBhpZHvzcGxXkCJ9BYfMyTk3Ixi4TXOIpRSjdmkvuCltK?=
 =?us-ascii?Q?/RvBav2maC/ea/saxygms1NZFCOI0lSmpW7DOxjwkOgrdlsvYOtvyrgX7Oy+?=
 =?us-ascii?Q?XYBKnD2mAXezLtOvaocs5zNb6RHEvc91Wl7Q3HPgJumLdPjauGClmfYblbeD?=
 =?us-ascii?Q?MYpkHw+y6VbLS/vvV/eQB1JHinFX8ljAyxfFHFXBRO6MskNpuqp1dNtw6lx/?=
 =?us-ascii?Q?fstw4L5Lm2A6qCteSZxkHxCixA31BGcX8QT5BHg+L6JOLQ77khRyacSxQ2wO?=
 =?us-ascii?Q?+D1yIOOyZr375slwW98d1AiYMHa5rDx7myGpYL8dZqOsez+UStfyhF9DLZbw?=
 =?us-ascii?Q?XNtuXY2/9Lvyh2IMjoilkZsxhNq8j689kO+uOxyq2EMZK8JEoSdczLVWiyZi?=
 =?us-ascii?Q?NSfo8H1KuH96AI/HnoDqSwKn3hCGgIwIW9KZRr/G4mNt7EBx//eZKVPqybng?=
 =?us-ascii?Q?930f+oQer4dumTNjLcxgkoJgM5sJnf7+zelNQdklMOg81u8fCg36IXI7CwhH?=
 =?us-ascii?Q?WMO4r+1X6N7K7Nn0xFIcl4kdIi5E3WIGcrG0Yd8m5tRBoi01Sr3j8KMj6y4T?=
 =?us-ascii?Q?2lDYlUTSsxZVAUthJ0dFfCCNiK715/rvQrQrRo13wtCImBjLS9d7a+9SZFwV?=
 =?us-ascii?Q?U7/SWv8dZgvA30V5RqXDt9rFuP0mNjR2wGuX52su5A8RZp4xRE3pRFioMrwt?=
 =?us-ascii?Q?bzkZ5Q277evHDn/874/HkKUHR7xYUft9ZPU8AC7lonyBQUu0jlDwVxbw7cLH?=
 =?us-ascii?Q?k5adw3EiE0QDnMbDiC4ecoRKKYpuMEaD0cfFJmAXC3cSCv+WM/T4dUhWbTXv?=
 =?us-ascii?Q?7dBj+/z3PnAia48=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 13:01:44.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b324f1f1-0a64-4994-37d1-08dd3a1bc1a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

