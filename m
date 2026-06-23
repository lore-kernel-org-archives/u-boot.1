Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4BECDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D4484A67;
	Tue, 23 Jun 2026 14:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LV9TvGfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3CBF84A57; Tue, 23 Jun 2026 14:55:35 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9865984A67
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhDvYg5U8pLsgdXQh55zIqg5IgUY9dTe3zDiUNWzybsVRe7e05+v9TXj6Nrc0SyZq5M3W2kTnkP8uqMm+Xz/AMWo9zZI1FfflAwEh6MUbadRQJE2COiH5x6MmfLBkC/MyFoAGpLOxEFxUYfQFagB690ZBYoUwtI489tAmzkC5BLhbVWHeD6P46Z93fq4YLzQDoG5dih87JgMr7XQGvdotFUJixjD60AJkJxHYIQTcXZJX4PgD9pCjdXt3ON31FI3jfSiDxpmTm4bdbVS9y8q8GuyhLeps1kv/dGhBBf4A2X2Fd/uQY2cWlJR50lJEtKhEcoZs9kiG1koGKq2QbKJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bzes376RoiE2R8jBJw038n9fXjfo6HWPpzAyzoMIExk=;
 b=wYLwAYaO6yy6chtpyE9kI8XunF9+Z+Fis6etpQB/QGBk78hFQozhitzXtkJbyQ3qV2w6lfbTymH3HUCr7YId9buEQF2YRnYNdVg9Uixyd8k25fLFucqohFBktbYEmruw6VnSffEH+aKaCRs+FcJQcx8N7hbQVHiiVHJ3fr0ewCGf2+gsqxTnVlaMonKlhQWkIfLbE0slnI5dQYjdVh/G/Ay8BZxCdnEuswQstF0W4GoX8eLXseuExNpXw757cFoPa7731gkUzEHYKu6LwwRpAc33huFpWtHSm/nump/m+U+mdjDe4U90qT+9eyKL81TPdx+5gwWj1x6vMAsCU6jsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bzes376RoiE2R8jBJw038n9fXjfo6HWPpzAyzoMIExk=;
 b=LV9TvGfMbzYzxZfrqSRDfsORnlmUsc1DnsrJCHRsb+uj97JHKpsFPahu2tipORrZJqMDiq6+x6gSznPg0HAGHTb4s2ulPCHusxWZkIdeLFLB3QJsL2pjuxXjMfEbq88nX44vZaaiNSyP2ucaH0qMaO5CAEywewDCzPjOFaLFTJQ=
Received: from CH0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:610:b3::28)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:55:22 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a5) by CH0PR03CA0053.outlook.office365.com
 (2603:10b6:610:b3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:12 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:11 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/18] arm64: versal-net: Deduplicate SPI bootmode handling
Date: Tue, 23 Jun 2026 14:53:39 +0200
Message-ID: <f98037220a20c441f0ea964f94647948bc035997.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=D6Z1jr2Ui+NglUc57FWl3d0dmksxApDGGFl9z0mYQmI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNb4/NZMt64d8lfaF/MN7juQYvDgz+ewvxlk9CzoUp
 q9ctWmJTkcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBMxFGOkaHpurfp/Y2/r79n
 rz/vkG+usTO+0PJLyPvM0JlLpbwv/dvK8L/kis3sv02z+qKsJHZFqi4o3/W6OIzvIXPoj5TfaxQ
 V1bkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: e3053c40-2772-4398-ca22-08ded126b045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: /huO8fnlMdwx2Lv9Z2KYOjnLb/OBTmQ6kNMYh8p7BQ5YlUGHOjP/vnF+kxteL0k8pgMLwNlzH6OdXnUP9r1ht07ObLzsFdkcGl0OxAKcAfzhoNdBTX4BL3Vdo4tJDZOFqjFl3GWXWolB9NG6nh/CD34l4aU28cQidYSQL/sOs6adq6ETkGkiV9dTMwY+5LxcLcbMO/NbctR8ulTXKhPR6dgmgI8OV2wm3Pi6IdEVopXEuRZhvmdHPnDKMnJUqkrTGWi2SeLwzrf4QY9PpH9w7StcMtpAP3X6WhEcdpLqkOQLUUAvBMuOm6lMKIjYPdIDGBdv/Q0dZ+t+hH7tBrqhEv+Ux/cOXnZkmKZjfggXUB7i7lYHJpSVNF37X9IKqK7u5XiKSWCnSuS4uw48Jb6ja0jKBweq3XZk0ZmLbTWBUrzFIUOdhttvgn8DgyqH5lcB6Ndw722tch7e54Wpst5WOfVvLmcItcft2Fei7iA7aq6j9omjw9mekkMgUwHBsula2s8UUlk9zE0s3fQR2lJt4za98kxJpsX2kR+cMRzrfchOE71ORzSSyX/VFJm/SoHCEOO4QGshnODE2srbHF7ooWtANFGDEC0WWpRJ0A5u5s1QFzrZ1uVpup1o770ZUgx3TTsaEh2x72jo+wde3KaUA1keAS8tyY3RSTnVDlpv+IGYGEbOykMS0xeqHZ2bH8q5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4l9fFUJemqaX1aQ16Hkouv1YqqejGcl0OIw/6Z0yPGvTJL5mCFqEvPVgmqfd67hPJt8MEPOb9DiGoKl/kD6esxnJkhEQiLu2YYLJhYKuDQHOh2IHbF/8JWCJHboJ/04w+UaGePRRY3awQ/C4KfyLLjHWG53MGx49TB2a1VXasKba0QxCLnpcipskp/EjdYL6t+Y3/9WHHpnrjO2MlA9PTqUjTcXEmxlMu5PEi3z1GtqXmQVOTIsMu0FvMhZlmwbttxpahHVhpJ4GQvES5ecNFHfjz7kgg+nYjwuS6k5tAt8rUrojUWHxDyWUHTjDAg+tCNftDoxwhcJk9uu8cU552clOibapZ1RDHb8s+6Kqu52BUBfQdUF8TX6jKBUk+bcZWixfacOUsaOgTLmjRGhUmGp6BwfMhWVaR3f1/wroaxCzxzqO2oNePs2cv5OcdjDZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:22.8985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3053c40-2772-4398-ca22-08ded126b045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
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

spi_get_env_dev() and boot_targets_setup() both decoded the QSPI/OSPI
boot modes into a SPI device sequence number with identical
uclass_get_device_by_name() lookups.

Factor that logic into a single spi_get_bootseq() helper that takes the
bootmode and returns the device sequence. spi_get_env_dev() becomes a
thin wrapper around it, and boot_targets_setup() calls it for the
QSPI/OSPI cases instead of open-coding the lookups. Passing the bootmode
in avoids reading the bootmode register twice in boot_targets_setup().

No functional change.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 38 +++++++++------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index bb099c1e7ca5..5ad8c8d6426a 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -68,12 +68,12 @@ int board_early_init_r(void)
 	return 0;
 }
 
-int spi_get_env_dev(void)
+static int spi_get_bootseq(u8 bootmode)
 {
 	struct udevice *dev;
 	int bootseq = -1;
 
-	switch (versal_net_get_bootmode()) {
+	switch (bootmode) {
 	case QSPI_MODE_24BIT:
 		puts("QSPI_MODE_24\n");
 		if (uclass_get_device_by_name(UCLASS_SPI,
@@ -109,6 +109,11 @@ int spi_get_env_dev(void)
 	return bootseq;
 }
 
+int spi_get_env_dev(void)
+{
+	return spi_get_bootseq(versal_net_get_bootmode());
+}
+
 static int boot_targets_setup(void)
 {
 	u8 bootmode;
@@ -133,34 +138,11 @@ static int boot_targets_setup(void)
 		mode = "jtag pxe dhcp";
 		break;
 	case QSPI_MODE_24BIT:
-		puts("QSPI_MODE_24\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1030000", &dev)) {
-			debug("QSPI driver for QSPI device is not present\n");
-			break;
-		}
-		mode = "xspi";
-		bootseq = dev_seq(dev);
-		break;
 	case QSPI_MODE_32BIT:
-		puts("QSPI_MODE_32\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1030000", &dev)) {
-			debug("QSPI driver for QSPI device is not present\n");
-			break;
-		}
-		mode = "xspi";
-		bootseq = dev_seq(dev);
-		break;
 	case OSPI_MODE:
-		puts("OSPI_MODE\n");
-		if (uclass_get_device_by_name(UCLASS_SPI,
-					      "spi@f1010000", &dev)) {
-			debug("OSPI driver for OSPI device is not present\n");
-			break;
-		}
-		mode = "xspi";
-		bootseq = dev_seq(dev);
+		bootseq = spi_get_bootseq(bootmode);
+		if (bootseq >= 0)
+			mode = "xspi";
 		break;
 	case EMMC_MODE:
 		puts("EMMC_MODE\n");
-- 
2.43.0

