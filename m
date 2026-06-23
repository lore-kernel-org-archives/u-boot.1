Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FCBCD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C08849F0;
	Tue, 23 Jun 2026 14:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i9pnJZE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC65B849C5; Tue, 23 Jun 2026 14:55:24 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7078584A4D
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkST55Zcpd9wQ+x8UhFEAx1zB6lMe0J9LxdNcPK+QbOsNuDe7W5pFdNAkUJVa0KtMHmwCVL7bxzYO0py8reKsvWf5ba6c+3ZVHGUvGK3A5Kw5Z6v/Pm5GN39MhCEzgIYxMnqIeqnJyoyQ1ODerMi9eQnhrBRPXWi828afZaT0GzlpOfaay+rJTIaE0N+8fYjP+Wok12tJoswG485lrXD9CN3Gg5ftQeFjep3ag4R140sxZS2pJRfFb0pbrmAHvtuRrkAGsdBoPSwd6SLo/o3cOz5P0hyq/D5XFN0tnX39Tiynp2ctZswLE5BhdQNZm3Y5GrUA3HRRQMZM9X1aNa88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiyc1B20Q3dcd3EdWkhJtnOtfkvuRRFK0EttPmGqYEg=;
 b=lwLs+IlgHYSKLuZQsEa/rWi0K3Da0o23c4EtxKXs4rbZ9SEOjY3pLe6jb4dsRRUX6plzqBElZaAc2g5sFkcXte9QX+S036k7I7Ciksli5uUhWLmsHBIHqzdM2fmij9n5cZyzrK5jouzVOQBJQPvwxvY0uKPbdqDMEoP1mdkGVPZ2hbTCHOj1bu2y+V0/UAp+CyG+TXlh9mx6XsRfM3EYLefflnUrX8d44tb/iOWBtzmQJNAwgCU4EE3MtWEEE1aJmbZAzNDp2JoLxqKagDpKYWXYX1uVnVEryEAdMBRTD9mF/iTA7T1ZyVpJaqpuzZ/fsOeRFxPiZN1/MN4N9qqbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiyc1B20Q3dcd3EdWkhJtnOtfkvuRRFK0EttPmGqYEg=;
 b=i9pnJZE1AWg91cf8TfsRruKYBKrhPc6Rh0EhFuNCKvK0VvOWknuIJh7MzJl2ojGyBBUWX6rtY51DKdudYHTRyxuh5J1MFmMBAXIZgyvARVtEfPjLRn8o/cGYtOOIu8QJcJ+jEoU/IgedX+4xdMH5sEbMDcbWdpQn8Ri1ldYMdTE=
Received: from SN7PR18CA0004.namprd18.prod.outlook.com (2603:10b6:806:f3::13)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 12:55:18 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::9b) by SN7PR18CA0004.outlook.office365.com
 (2603:10b6:806:f3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 12:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:16 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:15 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:14 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/18] arm64: versal-net: Simplify spi_get_bootseq() bootmode
 switch
Date: Tue, 23 Jun 2026 14:53:40 +0200
Message-ID: <191f0f583e2d02c184ea2a2a2fe0ef473ca9fe61.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=eSwsH/PgI4OzuRTIsqIZbwd6O6Ak+teUNTdKd9A2TO8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNX6IPpSQ8GjmxoNZqyX9IraYa0ZeStM41iS8hPFbS
 WmJW2lmRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzkgiHD/zSG1u85OYszl39b
 /t17A1+T3e6VtsyX37vaTk49qftUYRvDf78NW3ZoRBVUr5K/0vIvrN899I9SHsf3Nd/WCs5Q4vm
 hwAQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: d0df116c-9e98-4401-af7b-08ded126ad3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: uHwLI92KFhZ7J/Z1vmTa28oSjHfjOA3Z4IGFxV6X6fmXdrxRdOVNmCp1ZqoRUr8355q4bSOVOGc62idUCudkmkCgqhqiYOVm6e9R6hDpf5sRbHFpsfZTk6urBxjYUs1aWmuW/bDmK1UVT3ifgxtQ1anyl7nIVixyVp0BSZbj3Fpd7dC9DEVGlibEfsutE7LklXLdP964cpfFnH2nkL0AMr1+BaXffYO2f3wSvz7A8tNmyOG+cG3soUHFdxvufttPWb5XQLu9xxz94c9+KxzhxRGjFmt2PgL/23PFQhezHsrYvqFghZrvhxCHvpher5h9DROpBIoFPeMrmumO6xSf7eHVPTUkr80f5K+rf2SxPTKNwo08ZhIYiiIPX8HERBi07/UcpRQszhF7vdzkGmtCmWoHvooSE7sufSXg+PIYuuFuqprteia6J1g2kRwsv32FnWlab/KVE/rocQXldyxcqSAfHlDAWmIC4RTLaAh+lQhXZQ3TwywG2BQ8oUx8DbIjvH0tPB31jZIUd56VyMp+fDhCkNMRO0DDyE6ogceP1RI9VWqn1j8yKF1yMsgz4nMYoBUPQUs+r8pgh8Paw/BghsNnMG/Z1peAwNHQdSETkM+vi73laexdZyMgfva4zKmwwsT+931lrW12nA2hvNeRS07AYlOXqFwvY0d/EMwijFguYhmG9ca5NyZ0AGDp9ESIvJfemcxyDjfmCGbeVnAZ8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b6T18ZYsOYZI4qw0PxGc5/JLM7/oglm81RVZQeRtbS7wxz/wFEogb7j6+9suT6550v95RJV86t0ctfS5b5MoKKBeNDCPuGxpmNtTg+DnRRUTElg/Wuj8NLzPSqJf6DLa0v8CJZim+7h4m91SmoQgC2C8MHsheubm+X8DMvoEhUMnI+QC8QF+lXFoM4aPkNDBQPknqczDhg+fKBfka0l6NP/1hJyLCOKmIoqQet5tJl2BB1xWFez1xrRuF/15wOh2p4SApx8lg79zfQlug1HBwGxzh1ht2vnkzLXMKpWLaIF14FjV4jdKCzUx/BLaQXfrapaO8Dwj/HNyHp6VjT1VGJPsWSzsXZfsDP0uw3kYcjSkID2Io23aRmMy5ewltyC9gNq1G1Z2Wmd4mA6MP2flN7PeHJbBKaymGiZ1FLtuGnNPr7x6n9DUnBfPspMx7UcS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:17.8081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0df116c-9e98-4401-af7b-08ded126ad3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

The QSPI and OSPI cases only differ in the SPI device name. Pick the name
in the switch and perform a single uclass_get_device_by_name() lookup
afterwards, instead of repeating the lookup and dev_seq() in every case.

No functional change.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 5ad8c8d6426a..50dd49927be2 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -71,41 +71,34 @@ int board_early_init_r(void)
 static int spi_get_bootseq(u8 bootmode)
 {
 	struct udevice *dev;
-	int bootseq = -1;
+	const char *name;
+	int bootseq;
 
 	switch (bootmode) {
 	case QSPI_MODE_24BIT:
 		puts("QSPI_MODE_24\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1030000", &dev)) {
-			debug("QSPI driver for QSPI device is not present\n");
-			break;
-		}
-		bootseq = dev_seq(dev);
+		name = "spi@f1030000";
 		break;
 	case QSPI_MODE_32BIT:
 		puts("QSPI_MODE_32\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1030000", &dev)) {
-			debug("QSPI driver for QSPI device is not present\n");
-			break;
-		}
-		bootseq = dev_seq(dev);
+		name = "spi@f1030000";
 		break;
 	case OSPI_MODE:
 		puts("OSPI_MODE\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1010000", &dev)) {
-			debug("OSPI driver for OSPI device is not present\n");
-			break;
-		}
-		bootseq = dev_seq(dev);
+		name = "spi@f1010000";
 		break;
 	default:
-		break;
+		return -1;
 	}
 
+	if (uclass_get_device_by_name(UCLASS_SPI, name, &dev)) {
+		debug("SPI driver for %s is not present\n", name);
+		return -1;
+	}
+
+	bootseq = dev_seq(dev);
 	debug("bootseq %d\n", bootseq);
+
 	return bootseq;
 }
 
-- 
2.43.0

