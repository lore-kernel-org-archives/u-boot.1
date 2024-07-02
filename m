Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E784C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 01:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478E88840F;
	Tue,  2 Jul 2024 03:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ap9AA9U6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D0E881E7; Tue,  2 Jul 2024 03:14:54 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDB7881E7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 03:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9pBJmC0vYIDvZAcvdYqqSSBoNDsuPkhptD4c/wv7gQMOh3/7CYyuVYXiVhHquKgo7fpCaT4lqely+h/40u1vdyu2MGhZGG5+9I8xDJrg7t43m2acHuHCsQWtFmfrKe0OJbjLuSt5TNF/LlV1y9T68se+5NX4L/Y5sABiVI8x1HE4hcBtsu0Rw6Q5muDg1+P96SXw5aVWjYvcC9kdQy7LBl163GBhZWVVTaFB9+3AiAe1bkd/kCeinhrsq2vlUM4jGbVocth1QTzvdbZPrZKM+7lV5a9kZkvDkXEqvIvIuFhkx4z4xsKmQqasZg6vW9joGRm128Q03D3otBSFwI+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpFUg079Ws2GFE3BoByjHc7cwcfG2uJSn02ByiR1W+A=;
 b=gTxitg9E+pOkv/qbEGBxjGyyW5RM1zpYttNL6r9HyGReRR9t3wLkUaGw5Qaec7gaC9MEbelIQWzs+glPt3VhUPa3qdh4tvuB+d+T7Tk0iUqueCjiR1oJ2QBCltWNj+qeLnicR2dSZqjYlpKxYRD07vNROcbayDQEPf4bkVL4n9J1+voh/CHOsXod680fXCJ9UapwYxMV0IY7rZNA8puCbkqARmBq8ear3sq63lefNtylBU06/M/RWqDvwhP+fhPTewIG4DiPKB5KrjtfqmSxbsYjGucjWN5Iweu528FGJmVqmzpkXMkBQUqfcMihyWKgZzpcaiouZ2sGvtMgt6AzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpFUg079Ws2GFE3BoByjHc7cwcfG2uJSn02ByiR1W+A=;
 b=ap9AA9U6eOMUR/043orhJdptb11Do+j6o4OYnaOTYJ6WXKOR9t948Ut7kBcAcQihJbw5bA17mq5D4GBJwhVOQ75eMCMLB2ND1jU+7TQep/tYSrbl7Qd8N51TtXa2eFjB5dByEj0K7CikRuGP8/Wemvh/yi+klcSIwP5NTmx0yfQ=
Received: from BN8PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:94::37)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 01:14:49 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:94:cafe::4e) by BN8PR03CA0024.outlook.office365.com
 (2603:10b6:408:94::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 01:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 01:14:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 20:14:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Jul
 2024 20:14:48 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 1 Jul 2024 20:14:48 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC v2 2/2] doc: add missing table of content links
Date: Mon, 1 Jul 2024 19:14:40 -0600
Message-ID: <20240702011440.2888308-3-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702011440.2888308-1-sam.povilus@amd.com>
References: <20240702011440.2888308-1-sam.povilus@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 17663ab2-88b9-4596-d78b-08dc9a345e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wD2KrkN12opl26D4oEodXfFp6xGp/O1TY61GZF/WQl/cqtX6eDSFt0VaG0t/?=
 =?us-ascii?Q?09x2FR34EFP/ph3ic7ldXA3pGAR5Klk49QZvP6uks6EwaimdRP5rh7KB0A58?=
 =?us-ascii?Q?VlRMhd9ssdCxOV1N44ekWHXGswmmaTLuW1pVz2j0PNoMTg8NNuJr/ifMAgGu?=
 =?us-ascii?Q?rRfznlivpNDLuQo4RFqkSaJ6fxvHAC1ru4xGRWYaFIvOd8btoU0nRej/wu6c?=
 =?us-ascii?Q?zYIx9KoTDN93mTfeQP/BIdJmJMPhaBW46MLJAfv4Pjnr/7kzNrfLVw0QDlF3?=
 =?us-ascii?Q?M7D3qeXSWF/M/uCaeqp1+2wdauM75tdqV1baqViqtRRSx8tg5usivK65vj5S?=
 =?us-ascii?Q?48zY4ClT+w+PES4iTxsDSaCGWRD8LW+zbcmghnP0KCC3Cwk9c3+gjbSu29Pr?=
 =?us-ascii?Q?TPZYXAp6OGPH0ipUvY6PLk/PRGpofRrnzNjFfKN+2bSEUVObEZgQhnTyMD2+?=
 =?us-ascii?Q?p4Uuny3zISFpfbs7g7gaGtUryyz6AKMn4iQ/xdRPdYYw/Dj+j33QyJAywj8W?=
 =?us-ascii?Q?p3MYFIf4pbbtReXIwIcrwYk9pmfl0U7Oml3HuSmfjU9fSWjK/pi4RmvjlALT?=
 =?us-ascii?Q?HzL4SS/AvpVtwoyJP4Oz83EZQlnb7CQPd4sXa5MmVdercUKD9N03B4Dp8F/y?=
 =?us-ascii?Q?YkBbcU5fnUdhd4nDWl+ThPWnUqwq0K4aAJ4inprV8Yna7wbQeCh0mjtRk/aU?=
 =?us-ascii?Q?cJoWlgOTWLWnnAb1+QjUkJ9qbsEftey2SnQ2Xr2qAH6FobmuNd6JdaIp1mom?=
 =?us-ascii?Q?PhMaeNLKrGIYwF1oGsguY40+ZsrwJXJc43M3P+vg/AXOIzNfVC/30IUe3nmy?=
 =?us-ascii?Q?37t84FLHAeLaEeAAkwAbOw3pzohEFz8vn9d4u0wGLupYYRpYfKm9Kgxk1QW7?=
 =?us-ascii?Q?04KD5csC2fE5cFbsa/kz9JEKdRb/4LzeJS+QEiz0hh9TNtZPq3St9qvODPKQ?=
 =?us-ascii?Q?zLB8XY6J9CnLbTWQ1MzS4iMYUaCQ1rQhKdVrwblOHZldDeEK42lxykGerSp+?=
 =?us-ascii?Q?f09nbl3vSSyxPebsTGDnVMez8cvFxsuMtNP/PEis/JFtATQUA0okWwizlgp/?=
 =?us-ascii?Q?IFKOCrL/m0GGE+VhYUht1RQAZ428mI7v9uQ3vDuidcEJx1CZD6gELn9oqMSn?=
 =?us-ascii?Q?lJFWd8yOSunovREA4i9cHvRXAG7r3m4+0e0ZQWWAnJxVPvZEgh1WHx88ycII?=
 =?us-ascii?Q?wL/498e8s3nFKWGhEhrIV4/dV2qkVXa1acwretNlkDk/50XhguvSaeayGeCl?=
 =?us-ascii?Q?hbfkBzHi2P+FsE7HMI6PwrfMXQNp4hmnAp2WtwcGxsRJ1JGb66QRYwVteRGQ?=
 =?us-ascii?Q?tuVbGS+TWGaXvd09Vvnq3R4Bt8Bf2NE2+zHFHRCjzWzwAUIR+Oprhlw3oaFW?=
 =?us-ascii?Q?Ts6Eyc0ZyhqE9d+TxnOM00o/acPVM/9iMqvobxSD0hHRtbwb269sFwKNw1RV?=
 =?us-ascii?Q?lGhD6fFc/aouftqH8lc0QcMWWAIlTueT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 01:14:49.1499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17663ab2-88b9-4596-d78b-08dc9a345e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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

Signed-off-by: Sam Povilus <sam.povilus@amd.com>
---
 doc/usage/fit/index.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/usage/fit/index.rst b/doc/usage/fit/index.rst
index af2e481212..904f1593cb 100644
--- a/doc/usage/fit/index.rst
+++ b/doc/usage/fit/index.rst
@@ -16,3 +16,23 @@ images that it it reads and boots. Documentation about FIT is available in
     verified-boot
     beaglebone_vboot
     overlay-fdt-boot
+    beaglebone_vboot
+    howto
+    kernel_fdt
+    kernel_fdts_compressed
+    kernel
+    multi
+    multi_spl
+    multi-with-fpga
+    multi-with-loadables
+    overlay-fdt-boot
+    sec_firmware_ppa
+    signature
+    sign-configs
+    sign-images
+    uefi
+    update3
+    update_uboot
+    verified-boot
+    x86-fit-boot
+
-- 
2.34.1

