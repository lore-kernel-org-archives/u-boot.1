Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12728CD98F2
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 12:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6275884A76;
	Tue, 23 Jun 2026 14:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzWt6Ffv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFFF84A57; Tue, 23 Jun 2026 14:55:36 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 085B0849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVcKdLKYmy/ZAqGsS0iXFb7y1yLc2VUi0BGvHrXJEyNYtkUJ5oGCbb3m/zZ85v0EE8qAGX8te3x1paqwW7Khnv71fWhNrAWAyu7CtV8hr3G4rwgLdN2plOLJ2ESzNDYFn3Y7ZjU8tHw3wy3iSK0fSsQNrIwN7OwMwdBJAKTX6IibTmDEohGScgOqowbKTpAezNP/eTw3T+dktXeh3HGiRHZ1pKvNSEcie+tXP2zt9leC+VqVoSwAN02XuVr6gFotWCoyPMJ9AeSBZMl5U6Xn7b2Ha+gH6NHTCdlYAmhGtyhJHtmThcgbCJVlTPm0LKMBhMMieycbestGfRNZjlYxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLW3RrVQ64tHzvkE/XlGMK+t+JjS9XNSn8GoXhTyOHY=;
 b=uHEVMcYypyXEYEor8asOkcgE9DQpCPJ02Mhj7KqMS9czfPds8zugjue1bs2ogWaI6zymcOhV7PWl4xxSAV/r7AatR62dl1ZRVgQoE0caliu6g1ItWkpTQRpgaGd0yoWztJVYwKHOzQb3EWti7pH72TXpL5uAbRu0VKtLTLLsoU6h5QyrRl/+4b30nvck17Qnv4M/btPuMIhN+fD7dcd4Lms2pCMya6RRVmUXHD4kGUJvhLxlMdQ4ypMKTzpUyYkiPMLxAmBHrC0glGxtgh6mc+nHRkQqBG3JOYhbUSgU1k2OYbNOX22oWeD70AhHmWQ6elUF9UNzNqNcGbc1ER7WKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLW3RrVQ64tHzvkE/XlGMK+t+JjS9XNSn8GoXhTyOHY=;
 b=VzWt6Ffv4gsQVUh163XmrFW1bEppSRApjAm4xR1AlKsIXulg+RQHVX74Wz0RkS3fIIUS8gDRGS7rjLRAHcQbvEZjg5sYQkOVyZBjVkiPzT85oI9NYOutZg4KWDZiIssqsiMBHZOZn1buAqvifIOppw+EyJWcxII13OE7OpMYiOM=
Received: from SA9PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:21::17)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 12:55:27 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::25) by SA9PR13CA0012.outlook.office365.com
 (2603:10b6:806:21::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 12:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 12:55:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 07:55:24 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 07:55:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/18] arm64: versal-net: Add mmc_get_env_dev() and
 deduplicate MMC handling
Date: Tue, 23 Jun 2026 14:53:43 +0200
Message-ID: <7750a79c17146c66adeb83ad6d1bfa78b22ec8fa.1782219202.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782219202.git.michal.simek@amd.com>
References: <cover.1782219202.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3669; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FuAXIW28EbDBFnPAI6x+1X2QE1o0Sn+v3T3zem4Yt9I=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRZNX6621+7dRqLiE1Bt2ne1LjLL/b0HPr4/cDRupbOb
 qsb/cVRHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRylsMf/jdUy8q+m84msoZ
 4Xlc8OZS9Wk5bRVXegI3R7/uDtn+Worhv+PX4w9n/Y4v8D3x8GPNbJfLknaZvGGv/myteZRonVB
 3kAUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: d34396ab-2c70-4f24-2bf5-08ded126b29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wzve0kL1wILrt3AZPeWAXVbB3A3AvM/Encvz2cf8u2PSxrsgE1u+dwbeAZ5IsmXxVg8fvmWkjw1ktyRrKe9E0RhipMtjw/5KTOaVPuToUBZV2MstuAPUZ+6wxMeTb6eFeX5p2KpJhJV43uLdQtak0pfBcnhLzA6Ku9dYskWTzjJZmRXq7kjn+/Lq/6smoTSqZHhC0u/U8YRDgCOh0comU/XxwP8dw9HeAD5urlCFulw+jSmLJ7Yi/wNlr+uKEbaUZ4sfLSeEg3LPIrTeTAPq/ZA4IGZ1uMSJbPC/Zo6DgQWPtkNkgF66c4BkJtcOan+25ePYQP2qOjkiBx/Pk6yFytF4MhDSD5jTWE44cCftnO35vT38chYcE2XXmPB/LVmHrgY+R22Z0Xlq9JDYlHTAMP/2AQ3di4CjTxxR6GLTDLuWjqFKYyJCBH4BTEvb/awDJEmaBugE3Wt9I983j7OvFpmA0YgzkLayW7CJJmc/LGefRnNubQmTZuQYUs7D3NH7OD0sEOrkv4sdbGKM86SpeMlOJXGvHFVZt/81mohDpdo7U+QoDo1D184cTZnR5dEcnDs8ft4BoqZ1BkGWWnIxTktVz9w5u9oze3lH4KQ9y5KblWs2hGbwTlNJfE9sgaDqSKDFboS0aLA1DvyacN80d89ZcPA5xOh+gGGYz4ZDEYmwHk/lsO6BCPj5eD8oq1PRH+s40L5tDY9dcy3pBrcQzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N5lNYKPXYzG8s3cvy+xDQcpTJLOUx1TBPpoa0fmE6v0ELpgSyUPSvtZ/u+URbnfnfnKEwS6488cov3pkSNihLvQFmKDqeykEdMke1xDKwxpBoLs/Zc11hqhj1BQ385grOgozAJNDuaYJjD+FS0ypPzTs+1rhhgyGvYhMzfd7wZge5091X28DtFYiKa2El31F3YKZQORafORmQ2McWNOL52EZv6ohfjtCB/3HKvG1LhCnOCOVVmhQugNo6Fzbe8Ri4PCrVKhAzOAXyoy4S05ZiPAvkEg5vOaXKbxqSV9Re3p+X/GmNNEDJQRquXdYhJB5N5lA/HxXyOtsDxWQK9iIqVFf8C67M1CExrrxyJj8e7sSZ4CoHfLo5Q6cCnAbMurTffG62Vsw1aEp+Su3ri41sYbv6sr8juPHRz8Qld2PvoBxDXXoJWmCyYTP3g2cUgSV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 12:55:26.8314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34396ab-2c70-4f24-2bf5-08ded126b29f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
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

The SD and eMMC cases in boot_targets_setup() duplicated the MMC device
lookup, and versal-net relied on the weak mmc_get_env_dev() default
instead of selecting the device matching the boot mode (unlike versal and
zynqmp).

Factor the lookup into mmc_get_bootseq(), mirroring spi_get_bootseq():
it maps the boot mode to the MMC node and returns the device sequence,
optionally handing back the mode banner so only boot_targets_setup()
prints it. mmc_get_env_dev() is now provided as a thin wrapper, and the
SD/eMMC cases call the helper instead of open-coding the lookups. The
local udevice pointer in boot_targets_setup() is no longer needed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/versal-net/board.c | 80 +++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 9c0490cba980..ddac92660dfa 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -12,6 +12,7 @@
 #include <env_internal.h>
 #include <log.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <spi.h>
 #include <time.h>
 #include <asm/cache.h>
@@ -110,10 +111,48 @@ int spi_get_env_dev(void)
 	return spi_get_bootseq(versal_net_get_bootmode(), NULL);
 }
 
+static int mmc_get_bootseq(u8 bootmode, const char **modename)
+{
+	struct udevice *dev;
+	const char *name;
+
+	switch (bootmode) {
+	case SD_MODE:
+		if (modename)
+			*modename = "SD_MODE\n";
+		name = "mmc@f1040000";
+		break;
+	case EMMC_MODE:
+		if (modename)
+			*modename = "EMMC_MODE\n";
+		name = "mmc@f1050000";
+		break;
+	case SD_MODE1:
+	case SD1_LSHFT_MODE:
+		if (modename)
+			*modename = "SD_MODE1\n";
+		name = "mmc@f1050000";
+		break;
+	default:
+		return -1;
+	}
+
+	if (uclass_get_device_by_name(UCLASS_MMC, name, &dev)) {
+		debug("MMC driver for %s is not present\n", name);
+		return -1;
+	}
+
+	return dev_seq(dev);
+}
+
+int mmc_get_env_dev(void)
+{
+	return mmc_get_bootseq(versal_net_get_bootmode(), NULL);
+}
+
 static int boot_targets_setup(void)
 {
 	u8 bootmode;
-	struct udevice *dev;
 	int bootseq = -1;
 	int bootseq_len = 0;
 	int env_targets_len = 0;
@@ -143,45 +182,20 @@ static int boot_targets_setup(void)
 		if (bootseq >= 0)
 			mode = "xspi";
 		break;
-	case EMMC_MODE:
-		puts("EMMC_MODE\n");
-		if (uclass_get_device_by_name(UCLASS_MMC,
-					      "mmc@f1050000", &dev)) {
-			debug("eMMC driver for eMMC device is not present\n");
-			break;
-		}
-		mode = "mmc";
-		bootseq = dev_seq(dev);
-		break;
 	case SELECTMAP_MODE:
 		puts("SELECTMAP_MODE\n");
 		break;
-	case SD_MODE:
-		puts("SD_MODE\n");
-		if (uclass_get_device_by_name(UCLASS_MMC,
-					      "mmc@f1040000", &dev)) {
-			debug("SD0 driver for SD0 device is not present\n");
-			break;
-		}
-		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
-
-		mode = "mmc";
-		bootseq = dev_seq(dev);
-		break;
 	case SD1_LSHFT_MODE:
 		puts("LVL_SHFT_");
 		fallthrough;
+	case SD_MODE:
+	case EMMC_MODE:
 	case SD_MODE1:
-		puts("SD_MODE1\n");
-		if (uclass_get_device_by_name(UCLASS_MMC,
-					      "mmc@f1050000", &dev)) {
-			debug("SD1 driver for SD1 device is not present\n");
-			break;
-		}
-		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
-
-		mode = "mmc";
-		bootseq = dev_seq(dev);
+		bootseq = mmc_get_bootseq(bootmode, &modename);
+		if (modename)
+			puts(modename);
+		if (bootseq >= 0)
+			mode = "mmc";
 		break;
 	default:
 		printf("Invalid Boot Mode:0x%x\n", bootmode);
-- 
2.43.0

