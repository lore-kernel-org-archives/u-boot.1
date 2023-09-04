Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB87AC83F3F
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767BE86995;
	Mon,  4 Sep 2023 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gdsre175";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E85C86828; Mon,  4 Sep 2023 05:21:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AEC867B5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9c2vVTo0zw5J7YKOKywmb3kBLDvtgJHe51s/i1fuhFbVCyETcZHvYnX8lKCxWYwqB6yqrK6zrDYViLMWaPSMIXmi/MAYVjXUEfD8yOynPkipTCsojG7zg0v6x/0idpJcFEO/r/v8ilwGTVUC1GrjAKDcVXxOTql5zInR3C+JnFcMathorn+VRMXnB7b1SHhX/OuaQSqAz4c2NKtg4zTS+4fbW6khlVnVLBFjl9Pot+ob2Y6mqhvLMOvVdNPGDM4ZWVfIzIF4e3cIxsdNHcWIqlNccIziteFjaBKrFNxKfRapWAcD4DP8jgphFuulN9illMRALhMT5TTL7dhRhhtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9PaWFcw32FU6yifWsywbF89jPY11/GdhxdtpZNG30I=;
 b=oUdm5nuxw+ydZ+6RQ/5hIWuwCXvogK5e5HaodA4aCkiHhpIRSvdVkQSGQfUkDu2O4LJWwLEe/hOJ/VuQGlSwr2vkDls1rK1tZIEskoBvKj+89z7wMtxa0/EotQvfukKCPZCs+ASZoMaqvSJDJNuq7LBXtZ988iHjUbWOaofIMWE/qM8W18Zx199mjnC4hU/Yad5aXT0LSRW/UmkzkQB8c4qNkMOxZvO1f2PfovNEtWEdZNuN4F0TFiKyz//Sx56HbD9ueeD6uE7D5Vvo0aYdTf95yntY33H2FQC71Ns7nFCSB+8dcJpgpm/lxzwIPuIv+a8oiW74FXmGs8IfoAFMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9PaWFcw32FU6yifWsywbF89jPY11/GdhxdtpZNG30I=;
 b=Gdsre1753uikm7tu1LfErehofaWVzPJMEiDMlSJmUt+dgEWjhhE0+oA267efYvUatteHRzGETeFRkdU6wBMyad73S23MXoBlyZFtM5zEC5EfOU0hc+yw+4eAlW0s3wxSzFC1PBECUFLQUUItoUMNUYjhLY+hSyVZZM2uvrNa9cE=
Received: from BLAPR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:36e::19)
 by CO6PR12MB5393.namprd12.prod.outlook.com (2603:10b6:5:356::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 03:21:11 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:36e:cafe::ae) by BLAPR05CA0010.outlook.office365.com
 (2603:10b6:208:36e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.23 via Frontend
 Transport; Mon, 4 Sep 2023 03:21:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:21:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:21:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:21:08 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:20:49 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 3/3] xilinx: zynqmp: Do not setup boot_targets if driver is
 not enabled
Date: Mon, 4 Sep 2023 08:50:35 +0530
Message-ID: <20230904032035.11926-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CO6PR12MB5393:EE_
X-MS-Office365-Filtering-Correlation-Id: 049f0149-56d6-4c26-7386-08dbacf5fbea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eu2pnmTFelOi6Ljy/F7pG7G3EcWNO5QpJKHhmUikuTf4m3yNCAHLLu+J6/k3+fYGQTa5P1rIyWvq/PYfHhQWHrsqpYxwY10x00Au7ZLg2+6jKXYReLial0xAZYX37976+wVmsEXWuencPRm9JCU+XScuIA06Vv8z8qtHiR9NVXefJeqV1r3XlJs95pSBHp4YmxBeFcNm4Qa1ckwa+jFLWd5Mk0DnjBgTAJUp2N+2n8VZXtbKZrVvFpgHTfIdGdKM02vKVDiggXfj4i8QH7Hib4pA4VOwnvIm9AOPaC8zcIg18NnX8lw/Sy+jorhGXVooIP53IcTRi+wrIH0XB5HvvzGRD9Ho9J4DuL7xhibbYgFS3IlWZaP9wlhwNnGltAJn2dDe8Yg3EVgso8OENeo3gSqIa5SHkRpcYSadzvqKhDkfsfMAyWrC+BJPsTsb0Z57tSR+6O7gCOZig1lPgBNLRfCm3zE3vH2oPoiiSs78NsAn7J+N1C3VBKRqYJAZopzPHr/bw2LpFrl3F70LsSAwi9xFcUhPGu/HMhhMkZ0zz3k+0sFgzuKm0cP6O+ZgNNbgU2rnvbB6/naXRQHsBSEh9kF5F4VxtMg7K8RHv1cYZoplKp53xyjoa/M2HY7S46kq1sFaQ+DtvsvLpsXCT+hrH61OM7M7mFot5P0sOhHLWzyWPyL/mVRT/ssp91vp3YAlNKJkI95oso4TOxSE8nDeizzPnC2mk0hdLL1uqM6uJ11T7TuT2e1Lr2kBTFYJ8gjplGl4DVFfbdwZSbQZH3a0tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(41300700001)(356005)(81166007)(82740400003)(6666004)(86362001)(478600001)(2616005)(83380400001)(47076005)(426003)(336012)(26005)(107886003)(1076003)(36860700001)(40480700001)(70586007)(70206006)(54906003)(2906002)(36756003)(6916009)(316002)(8676002)(8936002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:21:09.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f0149-56d6-4c26-7386-08dbacf5fbea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5393
X-Mailman-Approved-At: Mon, 04 Sep 2023 15:58:13 +0200
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

SOC can boot in the device which is not accessible from APU and running
this is detected as error which ends up in stopping boot process.
Boot mode detection and logic around is present to setup priority on boot
devices that SOC boot device is likely also used for booting OS.
Change logic to detect this case with showing message about it but don't fail
in boot process and don't prioritize boot device in this case.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 71 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 309f24a5f4..0b6d4e5707 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -391,7 +391,7 @@ int board_late_init(void)
 	int bootseq = -1;
 	int bootseq_len = 0;
 	int env_targets_len = 0;
-	const char *mode;
+	const char *mode = NULL;
 	char *new_targets;
 	char *env_targets;
 	int ret, multiboot;
@@ -442,8 +442,8 @@ int board_late_init(void)
 					      "mmc@ff160000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@ff160000", &dev)) {
-			puts("Boot from EMMC but without SD0 enabled!\n");
-			return -1;
+			debug("SD0 driver for SD0 device is not present\n");
+			break;
 		}
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -457,8 +457,8 @@ int board_late_init(void)
 					      "mmc@ff160000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@ff160000", &dev)) {
-			puts("Boot from SD0 but without SD0 enabled!\n");
-			return -1;
+			debug("SD0 driver for SD0 device is not present\n");
+			break;
 		}
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -475,8 +475,8 @@ int board_late_init(void)
 					      "mmc@ff170000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@ff170000", &dev)) {
-			puts("Boot from SD1 but without SD1 enabled!\n");
-			return -1;
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
 		}
 		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -490,39 +490,40 @@ int board_late_init(void)
 		env_set("modeboot", "nandboot");
 		break;
 	default:
-		mode = "";
 		printf("Invalid Boot Mode:0x%x\n", bootmode);
 		break;
 	}
 
-	if (bootseq >= 0) {
-		bootseq_len = snprintf(NULL, 0, "%i", bootseq);
-		debug("Bootseq len: %x\n", bootseq_len);
-		env_set_hex("bootseq", bootseq);
-	}
+	if (mode) {
+		if (bootseq >= 0) {
+			bootseq_len = snprintf(NULL, 0, "%i", bootseq);
+			debug("Bootseq len: %x\n", bootseq_len);
+			env_set_hex("bootseq", bootseq);
+		}
 
-	/*
-	 * One terminating char + one byte for space between mode
-	 * and default boot_targets
-	 */
-	env_targets = env_get("boot_targets");
-	if (env_targets)
-		env_targets_len = strlen(env_targets);
-
-	new_targets = calloc(1, strlen(mode) + env_targets_len + 2 +
-			     bootseq_len);
-	if (!new_targets)
-		return -ENOMEM;
-
-	if (bootseq >= 0)
-		sprintf(new_targets, "%s%x %s", mode, bootseq,
-			env_targets ? env_targets : "");
-	else
-		sprintf(new_targets, "%s %s", mode,
-			env_targets ? env_targets : "");
-
-	env_set("boot_targets", new_targets);
-	free(new_targets);
+		/*
+		 * One terminating char + one byte for space between mode
+		 * and default boot_targets
+		 */
+		env_targets = env_get("boot_targets");
+		if (env_targets)
+			env_targets_len = strlen(env_targets);
+
+		new_targets = calloc(1, strlen(mode) + env_targets_len + 2 +
+				     bootseq_len);
+		if (!new_targets)
+			return -ENOMEM;
+
+		if (bootseq >= 0)
+			sprintf(new_targets, "%s%x %s", mode, bootseq,
+				env_targets ? env_targets : "");
+		else
+			sprintf(new_targets, "%s %s", mode,
+				env_targets ? env_targets : "");
+
+		env_set("boot_targets", new_targets);
+		free(new_targets);
+	}
 
 	reset_reason();
 
-- 
2.17.1

