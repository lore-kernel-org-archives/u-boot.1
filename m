Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E4BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 12:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE18284852;
	Tue,  7 Jul 2026 14:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yfyonceB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFAC484852; Tue,  7 Jul 2026 14:17:02 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FC6846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 14:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgghlU4XahpyzHJM4XIzHWieojq25mZrEJI99IqviSsGFHnpHd5P/0Df/6vJ2gDYqFYXwRRcE4tP/rywqENH/oQTnPz4iGsVSQ00KqZtAdAnelZX1c0JEoXI6qDfhsKkU29ADHLRuQ9HOYVQIyGfebgNIBPgyVi+gSesNNQ0QrNnXvbjwrZI28vI/u6W6yF8kd3PtwyHGGyS3hSqoaBPayms18mL79+xOsioNRd1LKPXht20SU9gQwWL5LUolmt1ff5PCN4wOXOCvaWWZr6TFaolVWecvObDkzuaR9zVFAS7paGPk60mdHIJtU9++6vYJarFoCgdKPhxBDnC+tSYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSGrFgRQsYteZ2my1jEq3HiYpOa0fX18Z8FJStdijDA=;
 b=nS2eB+SWtxbXb4+e4cgpBO1fAeHY5Sc/boegWXGTZGpwo60sdE9P6M6NiPvAT+OixuVlc2els0spX1BHQYfLbODPLnrQFPZbtk3ot6gcRGzzLM2mHFm032JFcjIVyH16Hzg0zPrTNjBlDFp/KQsyDlYAA9o2hoswqM2guals2JvGnOejDieLRwu5Tmm95y1FsS6FXy0k1G1nORrAR1RvoW3YotrsvUMZoy8f4YW06yh+jXcscl2YQBlBamC3//r0nCpYxm6MYSOqT1DLYUPlcrk+XuSgUjE7MAomtpdN1cVDVos0Omj/UNuAyW2snPOj2SIp/jAez3mgiZrdfu3DlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSGrFgRQsYteZ2my1jEq3HiYpOa0fX18Z8FJStdijDA=;
 b=yfyonceBN+4j1tWIYmvdxbGnurDrLSWUn58EC5/z2Wpq4SfP1cTdIfzvT/XbD2uc5Fxe60FamHD+dHVb/XLEmwrmYOrEKKDkSDmUvIbwNFpr49cpjPgf/xt03fz0YIDbf5qzUNhdMUqajgrUT7Qlu/XpTSI/Rk6XORux0mRuOOU=
Received: from SJ0PR05CA0187.namprd05.prod.outlook.com (2603:10b6:a03:330::12)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.12; Tue, 7 Jul
 2026 12:16:55 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::88) by SJ0PR05CA0187.outlook.office365.com
 (2603:10b6:a03:330::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 12:16:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 12:16:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 07:16:36 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 07:16:35 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Simon Glass" <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH v2] fwu: Make boottime check failures visible
Date: Tue, 7 Jul 2026 14:16:23 +0200
Message-ID: <fb1ccca20dc7ad495fcfad16c7e146500b120981.1783426581.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=qj3z/Pe+h/VDD3xV9CWBeMzshXhtj9uCARE51kNrkJk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT5vJNYtcru68Q7Dx/HpS0rm/vs1gdPsY9zT0j6OOjkc
 JtN+np0WUcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMRPEOI8OpwOP2Z6ZsFbTI
 elm04rSr6vJLtj67XGvnen4qPjD/7csChl9Mz59bPLPw+a5roNfcxXo8dfLZhOD/h17+FK00mXF
 F0ZEFAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c1d7d4-abe0-407c-bfea-08dedc21a240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: pymEHnlEpXTMleG5qQPjfqijCqqHHRbdsPciYMhXg7SszPTfEYupgfNaUXvetdVoOIi1vuQivP5bMbt1r9HPpLh18NG9+Zyjy5kPMgZILssAmzxrRzCCAnJVqvH2JgG5Y7MkCZt1QLMDMpDKsfBnodJ547A1sFsymxUrbsnhZ4dITOygnhGMDyLIDP3upGTteNiaffcUpovXMtjwvP48iIKFW3MJNU6mzNUvo7rBJ4oQ+I2Db+HGokXGBqMJ2pK9+OpvkNA8Yb14l8PpcerZcOkLa6xAM3mtIQDnd0HoGRNMrqDpHx7quBN+HVIY60VGIRNd/LbWjAwv+dOXMcXgcL5UvP8T3UwVxwFakO9VQYhETUcG4NOcz0MwzOZ44sXAcoDlFSQnhGQQSQwPGVYw3/X6yxtD6QmwKQBT3pE2Bf8urc8tSa5RP6VPIiJNKZ1drXGDeGKqLobxqHzTCV4Lc+9Tl3VRBZRNBtRv5IcxMDLPfzasQynoCbmGCvVk8bZvjxZvw57ccUnIew7S/C6MCtZFvHONFzcMQ4U3AljKOezYieKn2jlq7WgeYi4HrX/hqKZWOFaELAJcjR6cnklAyTQSd1pYulgVAxtopV3bwZ724oj3VtaP2EZpZGIZdINzkx5J5tYG6ndUeBCVMwdJ+LR1Rtp+greV9V/Ma831t0fSXoN6igVUjog3EIFUaKqLav+hHTOht138NgZvfXw8Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: btDprbp38+DUf2ktrnBD0qCw7f4S/FX5aF45h9D6aM2oQSaXvU2alttf3QfVpXCKg9LnC/nhYTNkfiZGjcf7kw/PGynpDoGWMfX/gPljLP5SzsGUXpaLJQMKjfm9qq1mugh7tMPGcTD5fhr2ImEcfpxvYYfIf57zHSzVo6ytPnFt5ZKKdKB1S0BtUJ8jd9yuzlYsNaYUP8WUdWl/MhCxKfeZcyBnPeQAO/QPPh8jEDFPsqEtA2K/ehGyZce6F8n+6lVQesnQ7JOG/0I2DUQrAAI7R4o6DzQ3lXXhzpiGqm9wo5Nx6ks/ABViCstw8aSscjW5awVoSN/CAfT99IJfzdZYSt8I34pDFg91hWOZkTu59B7YZWWC+/TWLUYLjjMc8x8e1sRBDhZ7uA8AZae1FST/EOJZ8Fl0IDHTKfVSCkDnZsU4E1TxK7KNfsVx930u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 12:16:54.5476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c1d7d4-abe0-407c-bfea-08dedc21a240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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

On systems with FWU enabled but without the required DT changes the
boottime checks fail. The failures are only reported via log_debug()
which is compiled out by default, so the user has no idea what is going
on.

Use log_err() to make these failures visible.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v2:
- drop fwu: Gracefully handle missing FWU metadata device

 lib/fwu_updates/fwu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 2b11e5da061d..e9bb1b4fc656 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -759,7 +759,7 @@ static int fwu_boottime_checks(void)
 
 	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &g_dev);
 	if (ret) {
-		log_debug("Cannot find fwu device\n");
+		log_err("Cannot find fwu device\n");
 		return ret;
 	}
 
@@ -771,7 +771,7 @@ static int fwu_boottime_checks(void)
 
 	ret = fwu_init();
 	if (ret) {
-		log_debug("fwu_init() failed\n");
+		log_err("fwu_init() failed\n");
 		return ret;
 	}
 
---
base-commit: 313a1a7bb065319dd3d57e9ab6559422771aebae
branch: debian-sent3

-- 
2.43.0

