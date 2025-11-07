Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B87CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 09:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF96683C94;
	Fri,  7 Nov 2025 10:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yx9uWPD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F79D83C96; Fri,  7 Nov 2025 10:09:32 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C3D83C60
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 10:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESZQokIP+VX+HyLgQyi7IR79hLhW5zGw2O6WoQbeynKZ8/M77lqKaWNa7ZEhVxUSt8X3U1iRhiZwcN82WbWQlfAyuCI4xa5XGVGnVblMJNrcc9VR0Ppy3dm+ytLQ2vOrWefq+/SPgpXccXdnqAet/NaUPT/zIqxW1KoRrpx1fnYG30n1/580AbLRNfg/iS4zXvg8XjCLBRqAsPNqLlbq+d9KABiLgQ9eTV6uZwIwt1HE7U1q/hL3p4PJns2mHUMA5BRUMLvNkoH1lVhUnqopdc5zBGGFp2008UTfNnm/AWVYeuwTygRz7qIHdlTnKw5LJovMP+s4p6KP52q/hkQ7Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTsfSzheXT2CCz4DqpTtr4MTFZy8RJlc75JEM2qnoYg=;
 b=B8L/J6Gi+3xYmMpM9l0hexS8p8GSj/2nP+sN5J7oWsR/JAgpc8r3dzP8RA4oIRP4ydmixNSUbAZSW/1bDJ8bADHHLy8U8LDkx8gTrs9xKAvFEAP6QmuLImm+xXYWfSZ3DZPyXTj8vpYi04clD0vifXbDpCmBPA7e8cHLoYzPTUrbr/DWzNs4IEGC4mrbiza/2wHsuYMVcq+ctQEE+u9tjTCTVwEA8cTNxggXwiodrQaXeJDAGGyVM8znC9a+OGVF5yIYdCTcQTr/XS8HsVcbmRk7oBlDCjzQOSOiuwIlqNjUJDFzzBDxyZVP9jQUEhFGaZ4Csl0JgGr61gzXaao58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTsfSzheXT2CCz4DqpTtr4MTFZy8RJlc75JEM2qnoYg=;
 b=yx9uWPD1QcFnDC+xQZTFc5NIFFJPNkJbWdOM/ot9Sv1ki3hXQsBN5eR2+vCVFyhk+6BgU8+vffCw4AoJPmtu0tFflnLU9tH2CvPo7ogFgpBvdfydWlx8AaQfWc3Zp21vb5rS2mKcoK4UViaFuIWtNTLJMj5jet6mnsRI7rht4Kk=
Received: from DM6PR11CA0018.namprd11.prod.outlook.com (2603:10b6:5:190::31)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 7 Nov
 2025 09:09:26 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::11) by DM6PR11CA0018.outlook.office365.com
 (2603:10b6:5:190::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Fri,
 7 Nov 2025 09:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 09:09:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 01:09:22 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 01:09:21 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 01:09:21 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] i2c: muxes: i2c_mux_select/deselect() should be static
Date: Fri, 7 Nov 2025 10:09:12 +0100
Message-ID: <28bba1e65f25ef25586916d6069261efb6b26242.1762506549.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PBixUw/rcc7S2gTid/hugF0WOF8p2f5AQdetPQvRWKM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTybrfKOPTsFb9p8zbje916MxU8jm7LD0iarnXIqeqTx
 qWnl/8LdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBEppxh+Kexfmpuv7DF2rCE
 rJdMS+5PtCx3YFV93ZnTmMGQmeyYeoPhv88eMTUrnoMGsrN3LNgY8vTYWpH4xO5DXBHzQx68/2D
 SwAwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 8525548e-50ac-4418-649a-08de1ddd593e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oJz+8iWRrysfBUuU1ZDYFLzTG+KL+gCaPNkDcTIKyP5IBzccMj4aDcTfAVZ7?=
 =?us-ascii?Q?PRRgNmxNQliEdg6ZXul/Q8j8l2QEXi77wiHIl2H8u2mrO7axFZb/uaS8Q3DC?=
 =?us-ascii?Q?H7SmTMkdK4YLF1Ke1069JJH5GuRNSIJl1CqHu1l3cBxWtrBxzTpcXgX98YcU?=
 =?us-ascii?Q?8OcgI0Co88s34yswobic7FeNdQVuXAmYWrlf2/gGkechtDu2BoU6An6jxgkM?=
 =?us-ascii?Q?t1HZviDak0/4RPHnT1MMLIRnOxtmzz8qdaXo/cj+zQiEnjxJgrZBNt0wQnfs?=
 =?us-ascii?Q?DDhzt7byRmzB3IBkAvDMeAGvG8fbG1yhrfrPNqDrkmMAcMGE5z356RXmwSXS?=
 =?us-ascii?Q?m95yoGyBsN2WLj53+hMftmKITFXDl2GjxuTn1UO6W1DpitI+nY7F/FqlCqme?=
 =?us-ascii?Q?NG54Yu1EJCVk0+XoKpqTkhjSkO3HDLuBNlVZwDE5XqaFdoOAMMZAj2Q3Y96I?=
 =?us-ascii?Q?NYZpHCkiACGOp5dIFg1SzPbmFv50hSKb0Md51z9XQh++r79/Gq4uuDuEsZPG?=
 =?us-ascii?Q?mnsAc4uFtJQoptx3QNcDiVMeBMkVtTlDmfAfYXdxXGVNS0ZwDAAhrIfhQoHM?=
 =?us-ascii?Q?A6YZovAoBrowGJ4VoZT5/lA64YisTETaqVXUxVgReJQRCUL/U4VsOTHjEkNj?=
 =?us-ascii?Q?g6uFas1MlcyfX5PQ/xS6OG5hYbG26ljgS7WsTeSMQDmJT83GbBiADs06X127?=
 =?us-ascii?Q?apTDqPQeNwi75go8DPrFgLlre1BoI+fdglVhXl8WWX7MlenXaVLqlMZ7eC5i?=
 =?us-ascii?Q?1N6ws4M7+obNhvHbvJy4hEybget3NnlmBepFdYDRqpm7B0h86Y+4PKzYH5JN?=
 =?us-ascii?Q?1NwG0N3ShCrsuQbgQ/yf0QW+cJnNiQLfAtwWRJHFUZjvk9B9i8QwGNUBpdeO?=
 =?us-ascii?Q?mKuLKMpBhPNrN0qiFI+u9R9ZkuTx+qJXbYXMmEdHs9ZwM9FCE5DxfbSNk6KS?=
 =?us-ascii?Q?sIW3Gl6e/umkVsyHIo3k8HuT7ZmC+t8S+qkDLKAKzwRuTEdFVtuRShLOPYfV?=
 =?us-ascii?Q?NVol4SbTRBqVznp05QxqzAkyevLHlM4p4VzgkkpWDa3rqpmzsRlbg2d/Vf84?=
 =?us-ascii?Q?ui9TT00XS4MYopvbZo1zajcHRp2UVz8LxVRnobFq/fK+PfGfhSfLTl9jYGTB?=
 =?us-ascii?Q?tIzPbZ2BTDE0/qb0uKQ7YqX7rMdh4wPV/zTI3B/i9qwKnUpiUv6cNxvIh6IG?=
 =?us-ascii?Q?j3RDXvwZkhPkwjJlgLYOsJdl/WT0cZ4ccEs+pnAYNuJev/64M+zWKif9nPCn?=
 =?us-ascii?Q?huV5bgU2l9BRHaKUFlt3bGc4IQREtGsQeRHaGOZQb00odxNIX+Bk1wRyBsWp?=
 =?us-ascii?Q?lxI7Qzvc/+gfFV1DRTIReOTdVz0/E9CIUd7raIY0/HgMB3KJr6LljK3BbZB+?=
 =?us-ascii?Q?U5V8UXbnsKLWeQKfvNPzz/GK9BqijWULpvCS6Rz3qEiftBZgKQsP25CRwm9w?=
 =?us-ascii?Q?k2+TO828nd02O+0/DZSdoUNbisGsg9NdvUmaOIFVLGoPfnsY9OiYYmkDnqIf?=
 =?us-ascii?Q?Bifm2QGLtRLYQavqtnMrQ23bqRPHTnpVM0xCoiQ9PIHlzotUjAw72+804CHU?=
 =?us-ascii?Q?/THtR2qJULjVWE0/u4Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:09:25.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8525548e-50ac-4418-649a-08de1ddd593e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

i2c_mux_select/deselect() are not called out of i2c-mux-uclass.c that's why
they should be static.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/i2c/muxes/i2c-mux-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-uclass.c b/drivers/i2c/muxes/i2c-mux-uclass.c
index 012881de05bf..7f4eb914af2e 100644
--- a/drivers/i2c/muxes/i2c-mux-uclass.c
+++ b/drivers/i2c/muxes/i2c-mux-uclass.c
@@ -130,7 +130,7 @@ static int i2c_mux_post_probe(struct udevice *mux)
 	return 0;
 }
 
-int i2c_mux_select(struct udevice *dev)
+static int i2c_mux_select(struct udevice *dev)
 {
 	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
 	struct udevice *mux = dev->parent;
@@ -142,7 +142,7 @@ int i2c_mux_select(struct udevice *dev)
 	return ops->select(mux, dev, plat->channel);
 }
 
-int i2c_mux_deselect(struct udevice *dev)
+static int i2c_mux_deselect(struct udevice *dev)
 {
 	struct i2c_mux_bus *plat = dev_get_parent_plat(dev);
 	struct udevice *mux = dev->parent;
-- 
2.43.0

base-commit: 665508d2c55273842f368c497a1bf5e9d32e1f51
branch: debian-sent3
