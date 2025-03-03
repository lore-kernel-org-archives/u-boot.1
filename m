Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE94C282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B977811B3;
	Mon,  3 Mar 2025 14:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTMfwgk6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D83D1811B3; Mon,  3 Mar 2025 14:28:32 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518C2801CF
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQp8F95nPKi8+H20n6SspksSMTYYmlXd+L7q+IhPJ7UZ24s6eP4L2Tb67M6rGxKNa3AlSYlr65vt8/5/qY93Pjx+DGCvGhdf9HHZGUx7ofXucWFY1pGds2HEqzryosa3QomYlFNuUZrtwbgAuYC9EAbEbDL8Bxi8vqsWFjSwzuHdVMGb0YYoRKtAKXxrcPgeG61OTSKbngCY5SwwgjIzsQAhRzKS5/qfP8DZB7bb5T5c5UdlcxpbTa7Lm2YkjSp1FBRN4+ZhOyKnsj9QUEr29oFwes5juFqBBrjCph5wuO4TfN9GZ6+pkcNRlqPfJdIycX6aRzz9x3IHZSiIJKMtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIq5fZQpO6JRPyY1YFeV8nNvmPTDIoOgzqCDpjZZHvk=;
 b=ipee7DEBRtszyq0ChCRS+ESKJZmvTtsFVBTQYirKCiKBwVd2NDC+FPvx4XMgzoHvshPDaJXXcbllvXVJK/wEMxEaX5MbFEy/pUqKC8cZmdySZ1Z6emH/Rp+GPPzM+YOzWxyAAAoF9jt/uvh+upo/h/Ik9bWmW/tjUwAOj4Pif/jzSqNAC4wS6LMtIUQWBcdq1yhLF0V/tnznKQZGc/NAHI3yZYJwTks0TQv87KUpNnKw3G4VYGwJQaqbXTj3QMeBzzNRcXk+vONAyrLCcB9KBgQ7bkDS1EX4VKoTmkUVhI2ycXVRSsP0c5mtf4SNRnWUJXbp69kxUa2QjHZr0GO45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIq5fZQpO6JRPyY1YFeV8nNvmPTDIoOgzqCDpjZZHvk=;
 b=oTMfwgk64AUdLrKO4RpGMWHa/ZH3PDPq7ZSt9eeoyykXEK8/LOaEQrU5ZEYO+OCA+VHqqQFwwm0DpAFcNEQ/ZdU2RNgoaEXJA3nt8s0pDljKhLpyK0/XIF1GTiAmKs6BSfsXhWPNAscKgK4Yr0dvlxLe+qaCDRKzTt5klpvBzsA=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 13:28:26 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:ec:cafe::ee) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 13:28:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 13:28:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 07:28:24 -0600
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 3 Mar 2025 07:28:23 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Remove tftp block size 4096
Date: Mon, 3 Mar 2025 18:58:16 +0530
Message-ID: <20250303132816.2327057-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: cac33f53-07c9-4433-509d-08dd5a57477b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wyo9CMgGte23Y0jQfj573t0fbKVaLELowwg5Sav/Akb+a4Pr+Ap2XxJhem7r?=
 =?us-ascii?Q?vCvWgTPTQOz70kNQCXnX5ri8wr/xIYcmy0313JVQqn14QhcaqpD3iJU8TCLq?=
 =?us-ascii?Q?cLI4Ny4AGl1Rwr6NsyOG82ZL413X6nVI4+76g+g6JwTokJ3knsI8WpvXaj0U?=
 =?us-ascii?Q?xov7hKB3kj0QaD1w0+x80CwMgkxkKG2It+Noqdsccdg0ddQwl2/Qsx1ur2qz?=
 =?us-ascii?Q?mhfge4slQJoyz9hZBH/obgZiige2XleuRawJkeWU3T5904+v9PBOq0pOWfpl?=
 =?us-ascii?Q?3IKajH+3qG5H0K73nwi1cneby5DlnxufLTVz1SLKj7niw86SQ6ZP8rs3GyND?=
 =?us-ascii?Q?ixzrI3KQM/phcMvOP85UVDm7E51xGxdwRbV7gAYpkckpUInIFoTd7ALgC9M+?=
 =?us-ascii?Q?oPoIVVt/bipxrUpiZ0BVlaR4G4bdJ4ykDW5ciJSYicbsjVV5/7U9HHkZxjW3?=
 =?us-ascii?Q?YgGMnY2z0Rom66s6Ae1qlp3ZQQCRWMTp1VcFgfv+jjg48PYsYRb4ilkDCbuM?=
 =?us-ascii?Q?NGATBeJpDg6R6t2YDGQGH//3mAwVz5pjEUxJ88y+nlenX5hQRN1b9DarVBC5?=
 =?us-ascii?Q?5vP6IlH/hwL9o/yBy2SgO6FgVsGLjv3xWVSwOUhyCUoaj+TnNFnEABqxxG2V?=
 =?us-ascii?Q?n5cy6J4Qg1P2NxnYIP2+k/fInTpkB0B470gBOfDRRkAS8Unfv6g8wfY6YgRe?=
 =?us-ascii?Q?Jas8vmJVvz4sNBFGXGBJr6XHuf9EauxgRaNQuXpAF+9nOYST4LtZampi7Lq0?=
 =?us-ascii?Q?Rqy3teL4TaQDrcKHsL1RLHinKy+lPnRoTXmhIvIJU5wgxwQO2Cvz8vv3Ki4Y?=
 =?us-ascii?Q?B+5s546Qp7bJktHJIb6S/QyvEmC+6D8gGGe2wNyypZuDi3wLA9QFIpjPRjuR?=
 =?us-ascii?Q?PgkjM+osMQgGHEGkcRuPwWR/qiFctsyOEE+j1bN/4e4nyE77zAjrnfKvZRkG?=
 =?us-ascii?Q?B+7ehGAWpnNrXiMm7zjAQtATRXHUJK4o6Rdrm6xzHvtX1UdxaM055EKpS/0o?=
 =?us-ascii?Q?Fla3KJ4RQiTqBALZqClt9axJJ6GZnRaOnduRvODQOLIPsAHzluNcEzNA7DB2?=
 =?us-ascii?Q?JrVvfgV0BK+lC7oAttIU6SIV1sUoKa9zHiQQhjf2gT+oTW+8t+Eoh96V9kb2?=
 =?us-ascii?Q?pfWu8Tq/t7oJf9RTw5cseEWsFyIMFt4UtgL8oK2+TUBE4MaZ7GzKKp7hqPmH?=
 =?us-ascii?Q?1X5cJ6Z5xUbexL10UIZdJI4jN4Akxr85xHju/xjiuFnHiPVNdL8Gs6MtIqA+?=
 =?us-ascii?Q?Lbg9XD8bPQf4R2oxUbuNfWV/iYqNeAAJu5oZIocrrKHQ6kYpxpbfwC7gijEP?=
 =?us-ascii?Q?N+akbjeoapcXnTkpfWgnRr81ZmSSdVycbm9aEmwXE2CL9nVZXjrxsJ4+SGEm?=
 =?us-ascii?Q?80M7z3oPBQXQcmr1Jd0j/BAQBVpAskzKsZ8CaemWMRTQEKqfx+bJabbeZDJy?=
 =?us-ascii?Q?j4WdWEtDjOhixOvoV+vJrWKVdgx5szT4XPHY5pQXNBJzhpW7h4bp5KTgrqMf?=
 =?us-ascii?Q?bqUUv9w6dS6EZvM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 13:28:26.3771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac33f53-07c9-4433-509d-08dd5a57477b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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

The zynqmp gem driver support max MTU size 1536, so remove tftp
block size 4096 from defconfig and use default tftp block size.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 -
 configs/xilinx_versal_virt_defconfig     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 5ef5fd44fd..1604b5915d 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -70,7 +70,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_RAM=y
diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
index f228eef7c9..baa4b8e412 100644
--- a/configs/xilinx_versal_virt_defconfig
+++ b/configs/xilinx_versal_virt_defconfig
@@ -74,7 +74,6 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
 CONFIG_NET_RANDOM_ETHADDR=y
-CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_CLK_VERSAL=y
 CONFIG_DFU_TIMEOUT=y
-- 
2.25.1

