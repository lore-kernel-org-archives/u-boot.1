Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E297C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 08:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80BE4835B2;
	Fri, 18 Jul 2025 10:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n9oY2HRz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7DF835B0; Fri, 18 Jul 2025 10:12:45 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD2F4835B0
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUQ6CX4Xhasna0seuTd2e2S00DDaX+w6BSu/25l9Z0gQzCWQGRXCc++dOJpQRNGZmupEq2izrRhUCgCSz9xIhiHxbk9CaEGsiAHOIsHooP/f5xMxb7CAWs/8rMwxdk5sYvdchEcf1iUMKZQXjyb40ZlsNvko7ndEGAJTceid7oQRTMOlcNMZiMEDbh4ynyQ0Jk06rcmpSsdzHBiTIbGE+lCdwfoWrib3Ze6R9je+J6U18anMnspsUg2coaqokhK/V4KOFrnRGDbjvoxVOuD6sMbz8MKc95wGKB57xTrbDCysuOP+LLDBJBIGHqvdx8e2lieUMkSN6rbW+DoJ0l9IJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSdGf9rSfCSXV4Jz53iNYhD2OWHh+FKJVGzzf8n2Kfk=;
 b=RhYHXnvzHl4gjNKuzO7/tKKNLUl62SwFupqZ3OlqvnqPsrptM++BVEal1iz1DpOIbrYl46lx+ZvX6O1nr5ZbXn1yxTjnbqEE/w/5cU4IW0K+oKMjAjkOeHg6eNMnBA/QG6hffahEyR2HKeO62Rg9QtyJgs2Zl2rJRiev4Me9GpjqfrbzA+/UprpqFK4DuVNxTX3oaAd3z+7gMDMUe2zvZgsJINYR3VkGiIIwcmenGLr82ITy4hiFYSzyjrscr+IxgbJZ1Di4/Q4OYCXdgUORTTDo7Vc1bVD4TuO53vKUZrq1M9gAzy7WXihb9DSmgXxGAsJrWUyt3aniqyQ+mXWeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSdGf9rSfCSXV4Jz53iNYhD2OWHh+FKJVGzzf8n2Kfk=;
 b=n9oY2HRz1/XECJeqZ742I61loQbLqVKMbC8cYuJIgdnVvU99sZ5lin+kC77IdIiVrUq9e35ZCOA8/4yK5EusZHz2vGKO4eflQ5l+9G+aO2wUzXzujATnvx8dSNqIX5kb+iuPgfOOcncA1yheb8GNStqpByv1crjNiCTGzzdHPSI=
Received: from BYAPR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:40::40)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.24; Fri, 18 Jul
 2025 08:12:40 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:40:cafe::3b) by BYAPR04CA0027.outlook.office365.com
 (2603:10b6:a03:40::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 08:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.1 via Frontend Transport; Fri, 18 Jul 2025 08:12:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 03:12:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Jul
 2025 03:12:38 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 18 Jul 2025 03:12:37 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] firmware: zynqmp: Simplify power-domain driver bind
Date: Fri, 18 Jul 2025 10:12:34 +0200
Message-ID: <c75627e92eeaffedf0f7e682edd4f6f39f0b5706.1752826352.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qDOeOV2pjwzxN0twAzBnXiqlf52sI0SFWU0jgPTxUuk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRUMX6eaKsQY6zBxOEc33Bo2ayJJ0sSDriELDx4ZWboZ
 9nTz1TTO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiJYUMf7hzezsV0q51SEnH
 h+YHHuErMCizu7v+/52ftXcYJb7/38Xwh6dFdGHT7G7d54ZZk4PjbJhn7vi7euWRz2cSV/BvM8p
 +yQwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: a7da1c72-d123-42ff-5c24-08ddc5d2dd9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M1gMfyyFknsqdqezFIE0Qlew5XcGjD29uJe2Og3AalHqWyfcGwatqAuOgrEG?=
 =?us-ascii?Q?kqj4RenW5vOVb7jqTBHibCDqb6KCPsVj+3VOQKrdAcrfxG3HOE9mLNufPKDm?=
 =?us-ascii?Q?auwKWdletFdJ6MhK7lnEOgf/p9mv3qCHEUvpJxz0HvmH9iTNHAn+vbWi+rzZ?=
 =?us-ascii?Q?jPqLnYRdZTnUf6l0Jx/r9aVmrc54cebFa1eMbVGf++FZD7JFCh3MdPR6V7U9?=
 =?us-ascii?Q?9Xp0lezahA6L5ocJuXlpPm7Mlv7p5dPTMFjGNQ8Rghv/ntj7f74gNz27KBIQ?=
 =?us-ascii?Q?bb5kuLtTln9R6ze3FQ73bohyEIe/cTNbDi2ee7oqf6mQg2Amnn1G8DK2Y6s5?=
 =?us-ascii?Q?i9qN1zP5Z14IYPR3iJt+Yd4pUYIy+ySrVbQ22bIj2rP0AHmrQmyalD3JhyvF?=
 =?us-ascii?Q?h3g9X9aF86OSVXSSJwGgi+cfCjAu0K9CVTsUsge/qGljmqQmpsvn7VNkJm/M?=
 =?us-ascii?Q?qC7nq/eA4kNp6G2HM6y953c9aYB1SlAbj91D41+0Qp0pC3RdFQg28IjPBX47?=
 =?us-ascii?Q?DSaSFIcpSRzAIKk6IU5JQVeptyhVSyYIkHlg0Dilx18Ztb+9b3nk9khDPukd?=
 =?us-ascii?Q?GLrw+YluVzsqdeWczRhaJfEqzn8w7Mkt63Gkwl9Fu2F14gnkIAATLVz78/YB?=
 =?us-ascii?Q?krw3LjO0J0+8Zo+MKtzhFi7WUYXmyOgU9LyIPv1jXwH4YTC0alCLvh5Ao0gY?=
 =?us-ascii?Q?OeAc9tSpHQw12DImBvLVnBl7BLhX2riIbdo6k+5FOIVMez6UfRsFOZTP4ibD?=
 =?us-ascii?Q?06uxR2JbLMg4q4r16bQrwePFZc/xS9Aq6jVj//WoNLFQndoSRHGsizGxreOc?=
 =?us-ascii?Q?7zMw48vl1gK0yE6+ZXzFoKdM8jAAPsezkrkCgaKQQTau4wIWOAGgRwu3y9JD?=
 =?us-ascii?Q?36pwDl3FCQG6GMkrl8Xc8A0rumdfdcVEwGTl8rlayl8yoXIFnjUOo7frCg64?=
 =?us-ascii?Q?N+F4IYxEZEkk4Sn5dxrYIiu3SY2KyRZqo/KEs1Qf4zVa+uVlCPodcK/QhEOd?=
 =?us-ascii?Q?2PPSPtQlnLhAbcouijvYUQgivB81GFIUrertt6VTc5sjwS3fqOUPf0opj16a?=
 =?us-ascii?Q?GoNJecyHkWv2wL/iKUY7u9z5vNfhSGF52MDIyTxCzYP8yUTFhbeLzNcrJayK?=
 =?us-ascii?Q?3jCdj5CxnSH5f9UeZkCXkzK6nwEvCpH1B5E0W3P74+ewSOhLFxJ2OzWbK/U0?=
 =?us-ascii?Q?bQk2rzy1F1iRSrndkwOJWoUBCDkoNddpBci2NJSjDcBqGQ0JV5vpsxSYpZ/z?=
 =?us-ascii?Q?rt+4+CcQw/LTCQ8kN2x9+Z0nFdo4Fd+FoXzx11vM9SITSGO/D5kRLXiDveG4?=
 =?us-ascii?Q?PswT+9ssTvygRpf3J7oAlhGyOHcY4l+7nWHPegmtW6o2Rmj9vSJQythXrMkm?=
 =?us-ascii?Q?Q3pEbeCuXBm5A56KOHV29U0K2mHvZGzxQfWZIY5b0YCmEPBbX1RNS2Nj2z0d?=
 =?us-ascii?Q?Bw21BRaXCG1A9OkTP9OgZqZ3MY7LkCNd/vSrDR1AutHJHfcSyyXUs7tX8kcv?=
 =?us-ascii?Q?UbnFCJMTViY46PSMHkWgYKQ0fIMPb5wGDLe0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 08:12:40.6808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7da1c72-d123-42ff-5c24-08ddc5d2dd9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

CONFIG_IS_ENABLED macro is covering CONFIG_POWER_DOMAIN or
CONFIG_SPL_POWER_DOMAIN Kconfig symbols based on build target which
simplify logic around binding power domain driver.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/firmware/firmware-zynqmp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index d18ae523b6bc..e07ec3929b29 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -500,11 +500,8 @@ static int zynqmp_firmware_bind(struct udevice *dev)
 	if (!smc_call_handler)
 		return -EINVAL;
 
-	if ((IS_ENABLED(CONFIG_XPL_BUILD) &&
-	     IS_ENABLED(CONFIG_SPL_POWER_DOMAIN) &&
-	     IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) ||
-	     (!IS_ENABLED(CONFIG_XPL_BUILD) &&
-	      IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN))) {
+	if (CONFIG_IS_ENABLED(POWER_DOMAIN) &&
+	    IS_ENABLED(CONFIG_ZYNQMP_POWER_DOMAIN)) {
 		ret = device_bind_driver_to_node(dev, "zynqmp_power_domain",
 						 "zynqmp_power_domain",
 						 dev_ofnode(dev), &child);
-- 
2.43.0

base-commit: 1a9414936322f0983fb4318505c6697b77e5d358
