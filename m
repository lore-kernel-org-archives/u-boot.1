Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A698FC27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09830888F6;
	Fri, 14 Jun 2024 14:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4rZqZIob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63357889DA; Fri, 14 Jun 2024 14:51:31 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42CA7886B9
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESEyVQMO75ByT6Gaxi7bT2RoeMqeVjZfPB3zP5TlA5+eL8RRadFJPNMXJG0uiRKHdmVmLCliRRn8NwOpF4zWE7BA1EfKErpdV/NHrpV34ZM1dLHbW0/KAYgEF1MX1xrgEA14hmqm6ZD0DVoHys0wAwlgjzrxu6ayClmYYvx5a0u5puKlABibEmmyLWf8gUYOrktZya1gqpSOWohiiDKxb+ShxEzPxQO82sRet0qI8m8pzp6gTUKrABQwM/PEuoAi2TMUK5hy0k11LYfH0i7MHdzHT6TvEKWZG9DGflWGRH+ZegQkDHXqh0VM+2LOeNrZ+s/FDQjZ+O9y2t8qN3WtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PCh3O8NNwRqZ/z0b4/q8mJadGrulRi/nI8a032iXvc=;
 b=NZwOj2H06HaNMM8/rmRLa/fvhn/Fx54kbZrIuqL1gXC/MX7C737u6m8vm9zSBc4zcSu58EqEDax9YPbAH3gH8rCdLUgLVcl7fjIQXgZWe2U+SezUjDlWF32h1uTqIWb6Cb9BXrRomvER908aeOwkj+JMgAXSRR7xhvCbo8kXpbIDBipLXDYiON43wMgBvhYcAIrwtFdc3Va9A6vrbI5Ti9qGYQolX1moueOtSTTlQ1SCXTg8wM5B0ZtXRsrtooqcm962c6e7Ez/gXl8GE4I8YhtUih3ZKBxnvVYqLcmllhdarxbwTUcuX3IE3uSMy40beN7NxvxaIGLnT4UqZe7Ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PCh3O8NNwRqZ/z0b4/q8mJadGrulRi/nI8a032iXvc=;
 b=4rZqZIobLPZ8An5iiW0j+r/QAp5rF1qJ1MnI0pwWDgQk9UZNfLV5v5aQNN8ZXZ6VcO4VFX8NbdpV3VSgoqbPXRyTpF8W2xkwXxuc6bbOZJYprgycjUAZpILZOaoBWSCxFk0vBSjWjuViab8ocIaRgz5tNcXQBucmG15i0U8B+Ng=
Received: from PH1PEPF000132E9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::30)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 12:51:26 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::) by PH1PEPF000132E9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.23 via Frontend
 Transport; Fri, 14 Jun 2024 12:51:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 12:51:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 07:51:23 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Jun 2024 07:51:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] xilinx: versal-net: Add env redund offset
Date: Fri, 14 Jun 2024 18:21:10 +0530
Message-ID: <20240614125110.23058-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ2PR12MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a3742c-d53e-4e37-9a21-08dc8c70b39b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e9SzMULAYPRxm0QCLcs5vBIW8/FaUGH2gHcozA0gjIHkOVJUVsBqR8qj5L8/?=
 =?us-ascii?Q?REnHn5TL0V7P5VdY6WVwIN4FISdR/YZdltBb9V4eYpTOFWMpFSGUmYXI5Rxd?=
 =?us-ascii?Q?Qk8Qm6vx+8zNYEy4ljrVtH1d6ZnMQDead9wwAAqle7qnUyoMR/5bVGek55Xa?=
 =?us-ascii?Q?p+D94/hdwuZdoyYkkvlZlxTlQOKpvbwgXnzCKSKklR0VGxTxq0ZeG5jsBIIQ?=
 =?us-ascii?Q?aO8VCrmlDm9ox2srAuGW7jBZiUvy9ych3STCuyU3EahV7MUiB7A0ciIS5BiJ?=
 =?us-ascii?Q?jIp5+a1HBcUsahsgpcDS0EPar31XqIp7dtgC6nz6SH64HKtt+Ib4d+OzE2F/?=
 =?us-ascii?Q?pKyv8Hu2gJkDYP1QV8wC20Pz86bRUwVOfyo008nNqU2DXf60IVdQ4wzxaSWB?=
 =?us-ascii?Q?pTPZrG20tL118zpjTsTwKmnSjlAljxkd+vwznD6K1rCRSyP+Y7YBoP81Q8iE?=
 =?us-ascii?Q?koE0CI8ZxmcpfOMU8woUBfzYyYFYizXUpei1gf1d0uwiqeQUDm0UzFOvNCxH?=
 =?us-ascii?Q?JycSk2Dq9mBrIScgsLfWrBGPopuPQdbpKRTjtWj3egI/4roNCFGWoeOwX0gZ?=
 =?us-ascii?Q?GDI+Rm+ShpnGkRDxwWheuuftutJwW8EHMT+IO66vtj/cixS9uHfx1UHN/fZ8?=
 =?us-ascii?Q?3GF+7/FEQn5TudZIq7QYGSwby0oOrLiyQpTTw6uvEtEXg1EK9Gup2vH/Ah+Y?=
 =?us-ascii?Q?2O8CoujntthwoYEA28R6kNDFFOkPtaaskBxvTEAGu7bhjeBDBlO45ZsCSgAP?=
 =?us-ascii?Q?JtfY9OtcNFVSfLc4ztyEzgSd7B9OMhn3YY5y57gccDP5PsbHOaGPVqmCW3rM?=
 =?us-ascii?Q?6CkxrCe0EbADuC5hWiXTJfguw23DazZEYDddD/gjKnd9fiz5M4vLXgy/MAIM?=
 =?us-ascii?Q?65hansplun9/PGb/0h/z2Th4uUxbvjHWqk425s69uZhaFLkfNDqN8jaiqDQh?=
 =?us-ascii?Q?NWCnog4suXVBggNSnjt8iU/PCEvl98KUJSOWUDZMV+AE23ACWCDi07QBSB+D?=
 =?us-ascii?Q?uDXW76/+r9wDhsx4IQol69GV01uGlaNTe/Q8idHXIEY7OUC+cwuwO2x5bsM3?=
 =?us-ascii?Q?CsAYCehQ5PPb3hfrJZaJeKdouKM4k3I2xJZJGY+UfvYMuQbmrA44dS8ruYZh?=
 =?us-ascii?Q?VNEQb60D6MP8E+DrTpZZuJRIo56kjJC1uBF66zS3qxOyQA+oykdR1Ogl4Flf?=
 =?us-ascii?Q?B24oezI7wpzAhRS2vGf3Fq61LU/M+YSba7K8n7e1wPQcJ0x7mHevPdcMzL6n?=
 =?us-ascii?Q?SXfOd7S+ahyq51jWpTdPqsIKyVHGTkXhe60kj63YH5s+/lN9nnyMCAQe5/hm?=
 =?us-ascii?Q?kjpQG+7v8/938Yw1SxNXLmLn4Y4E/w6c7yZrkzJtdiONOY8tE1bYX14csM83?=
 =?us-ascii?Q?7NS80jCNHYywPVtIZjYafNEA2dP4mKMWR9qh5811gW66Hb5tKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 12:51:25.3719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a3742c-d53e-4e37-9a21-08dc8c70b39b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

ENV_OFFSET_REDUND config is by default set to 0 for flashes.
Saving the env variables is overwriting data at 0 offset,
which is wrong. So add default redund env offset
ENV_OFFSET_REDUND at 0x7F00000 for Versal NET platform.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/xilinx_versal_net_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
index 40c6a29a16..289f27cdea 100644
--- a/configs/xilinx_versal_net_virt_defconfig
+++ b/configs/xilinx_versal_net_virt_defconfig
@@ -8,6 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x100000
 CONFIG_DEFAULT_DEVICE_TREE="xilinx-versal-net-virt"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
+CONFIG_ENV_OFFSET_REDUND=0x7F00000
 CONFIG_CMD_FRU=y
 CONFIG_SYS_LOAD_ADDR=0x8000000
 CONFIG_SYS_MEMTEST_START=0x00000000
-- 
2.17.1

