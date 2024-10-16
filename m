Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6C1D2069A
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 04:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD21B88AC2;
	Wed, 16 Oct 2024 06:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gg9ZdX3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4822188B16; Wed, 16 Oct 2024 06:44:46 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E880288A4C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4YMwoiXHrnRPQm/3dBdUq5PwRP265g8nX1ln0j8Bf0IoeCAzIJvmHb4HQYkiKfIPEPik/SJhWIyxx2dOfXCevWFdc8EIJmzZycAHvh8AsfqqJs/yMNECgHOF+IDpbM/tD8d4mXgESh1Ghd/orEGCq9t5jQivgEicldb2lw9cottaWzP+X3ads6goDKTKfjYmvjT/1xUyvjpTEeIY0yhXcWjLtaDllGembY+UZNez5TeE+fit3JMVyT0f/tthMFB6wqEwjkRQaBBrNFUhCXW0LhzCsA6ShoTPCSu8JLHcJ0YTW/l82gkkekFSFVmIXK8a3dIWLLLVFgkt684OQLqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FIhUOW06OyYiel377f8jEnHRo64RIdc3ap9y5zuRq0=;
 b=q+vOVZeb5iCna8iqAeYdssuR/1lCFnhtqenVACe7BALHlXo/J3kUTKKJHvhHohrh5VAWzbVI/dvQS26KaHeIn6h/OrnOsiFAK0zGhgLWRidyqlZjDemLJoXa+Regc9b/Nw/p0jUqFp/uZMagh0GI40up6HKgi2RtqRp7QRGrb549g2TjvCfkjlofDk60x9NHxGPYAMRGt0x9zrB2gc/RHfLj40XP9NDVFsEsXj4YxUPZUl17m+TbLBwXa4g0+6iSmJxqZ3+ejeNK5KWQjdk+yxEmKNkPhlbQkyB9EKaYwnSYu+3uRojVdmy2eD96RXQmIf4buNTD6tgH/sqTiVPaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FIhUOW06OyYiel377f8jEnHRo64RIdc3ap9y5zuRq0=;
 b=Gg9ZdX3HvQ3bnZ9+3deo7STv/7Twy0ZJ33XElJlQfE3jsDZLBkFPU5Ja9DGG4RRRp1gR16uz4SExVEi55+jXRklfyLw7UT0YtybxJqxSt9GjuP9sjzjeM+ZkiaYgmUxQTg2VUe6Hd3fKMrdQA/BrHHPvbZbaAweB//7lQ7jjLcY=
Received: from DM6PR01CA0012.prod.exchangelabs.com (2603:10b6:5:296::17) by
 DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Wed, 16 Oct 2024 04:44:39 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::8) by DM6PR01CA0012.outlook.office365.com
 (2603:10b6:5:296::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Wed, 16 Oct 2024 04:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 04:44:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 23:44:37 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 23:44:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <git@amd.com>
Subject: [PATCH] spi: zynq_qspi: Add missing prototype for update_stripe
Date: Wed, 16 Oct 2024 10:14:02 +0530
Message-ID: <20241016044402.18052-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: c64303ab-e63e-438e-6980-08dced9d3e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t8LejchgdjWqW5KhWFHY2gmU34VjEFx0wZSHHZeX+rKASWFxr0fa5V4aa//z?=
 =?us-ascii?Q?+s+hsrwpQ6L5ouBdeNKN/acmpJ/lsvcTWlaRNTdNEai+SQAb/+86v3EJKr2W?=
 =?us-ascii?Q?FsIf3r1C0XbqitmEUf662jhAx98696980g0hhmymJqsl9+vfvZtJ27RFxGLp?=
 =?us-ascii?Q?ZZ6lhIFilF942SiJPWLgBmco47j9U27vxXXvxwagq9LWMuz+ic6FD3wwU/iM?=
 =?us-ascii?Q?ZHIzDVS/NE8pNrjK4FfJ6ZRhotQPLVqq6UUyzC0/RtzNMaWmdPKoeVMnRw9/?=
 =?us-ascii?Q?avnjq5d/s31bOlUoIDBZzGOLs63JX+eH026Tl5SNYmNVtD+wgW2jMaK0V/lx?=
 =?us-ascii?Q?PIzZEpjgVAsWRcDwGKFAOCtEK/meX828jTMLwocKMmpIq1nQGEReoZkn6MmD?=
 =?us-ascii?Q?mh9W+xu2RNv2bJvqaMQc9VmK6LstHVFK9Cf3jv8ccrjIVqbb6BQaW1PqZwF1?=
 =?us-ascii?Q?GRONneUTffVE7Q/CKNXjmhIXirT1YEKuZGVKIKDfDLCaaJHRI3R0H6VXet+Y?=
 =?us-ascii?Q?qGTP5QH7Gir0OPsdfeGMcpyrIqxm9iv/leUGDLQrMsVhpvUBiHK6/LKS3vTR?=
 =?us-ascii?Q?0gXvKXc8rxiaPdb1dwlwe9rWrhAb588S/eRomMY20VV1Oio0PnuzrZjOjVQ1?=
 =?us-ascii?Q?SRZ4JhjV3s0fAuiewYtjNmtInVPiwd35dDpZ0kuuhWAik5EG7ladsnGi7AOM?=
 =?us-ascii?Q?UFROqFLT8hD0HEVjd3KV2CACoqZ8y643ifubpbcvsqkO+Lh5OTpL9h18+pbo?=
 =?us-ascii?Q?QZFKBJ/vYkNqV1y/z1dZ6GIt05SgW4Y8u1sKSmV2AKAYL1BBAvlrbz2gFmMd?=
 =?us-ascii?Q?ufyXtCkWiJkyDlfyvXpw4CToaGqLiPgFSF4iQ8ZjLKWzZGJVrVfTniALvIIm?=
 =?us-ascii?Q?vHsEJxhfJg8qP4ukxB5RbXrM/PMILPKMoVyRDzQa0accJmj3Wh+HmIO2WaE3?=
 =?us-ascii?Q?3LPCC3m+LUicDCX9u013227Yin0N6JLTXRB6g1/tbtqf9qnb8rAnDdPYoHQU?=
 =?us-ascii?Q?KhzZhY1oweZtyOWEszCeNKeJ2JMFrCFkcVjU25fWuzdpOS6enbBBhPKFX+Aq?=
 =?us-ascii?Q?eHJLOGhX+oZJSAO6Wk6OU61ViQgVNE9M+ugbloluRnGnb+SNPC5D7W3edrqO?=
 =?us-ascii?Q?5rv77msGsBoQ89eitQb/ArkJceykT4SnH/0GCrTsThVE26U1YBKXPUgyUfGP?=
 =?us-ascii?Q?W+TA6cG7CINB1vgH13rUa701W0ln5VACjrgV325NislhEkf3x8cn/685dKph?=
 =?us-ascii?Q?cD1WrLTFO/0l1IGgyFKkvPX/6WNbfPQeeqsLDu5wvXnRZrJpkDzRaNIKn7Bf?=
 =?us-ascii?Q?LhywXhUt3LLpf7sSx5kFdKtptJT/yxStditmtM7cECGfMY2HPuJ2a1TaxdMY?=
 =?us-ascii?Q?CVJ7jRzvkDE6h4rLiQQnKS4Ikic5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 04:44:38.8993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64303ab-e63e-438e-6980-08dced9d3e44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

Add missing prototype to fix the sparse warning,
warning: no previous prototype for 'update_stripe'
[-Wmissing-prototypes].

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynq_qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index f5b3fb5c125..4aad3248d9e 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -734,7 +734,7 @@ static int zynq_qspi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
-bool update_stripe(const struct spi_mem_op *op)
+static bool update_stripe(const struct spi_mem_op *op)
 {
 	if (op->cmd.opcode == SPINOR_OP_BE_4K ||
 	    op->cmd.opcode == SPINOR_OP_CHIP_ERASE ||
-- 
2.17.1

