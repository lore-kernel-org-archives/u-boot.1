Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0837CC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A07C86989;
	Mon,  4 Sep 2023 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5duyaOJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C4386879; Mon,  4 Sep 2023 05:20:55 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF4586824
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKrbKo+rHPwDTH9S7WV5R1wN6nwovvZmojeHhQsLYmHxiLzFMumNsribxhZKdcTeNDcxMlfFtpZBcZ2jl5x7QEk6MZ8sFDYl5LNAjJv9yMnNsNsxR1KZHSdukR+V8uXP6kIogc9sYo55GAuRRcgOKxCgPyCaWQeKaJTau3NsFNxXFmmagCuqTDQan1TmySAoEHeT+lbWt1UuSY/qVPG9gYrXap9eMHBfksPjjnrdv+g0uVm3XyRlJqE68XnnWlwlBAhbp0dBfVzDCSqnHaXRjhXdQGOvEcRxkDgFkJGrukG234tDiNZxR7QNRtSPw6m12zbg7WpINjGPQXHg8f1nww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gg85BekvNddVeEsFjoWjssOc5RSQicJy+m+IZ310jog=;
 b=mZ85WWFPZlyoaGW/8w90OfTPXTUt6c8LF1Mzpv52ZasdhPpUZNFBwj085RFIeESuDcfcWo8ynPeEx+qJiFXYEZO3uJ71YQ/Hv8yzeOgjNQPbuhNvmv+CjILdHNw3Nv/t4bN4lYFTrcFVG1VUWkMIFPPGABtW1eQGOZwZx7nSGxpYBmf/RHAwqk7YScIyBM+SHo5wDvXLv0Njk62DCVZg2xaZsXw16jXQ76HfT1SNAzSeHQBKlo1f8xZmXZ3x21b+IHF98iy6H2CB121jRWEVaWdHoGT2EBeARn3KqmDIDWJ6CZQeMT5ague4xD3ceNo1Fz7LGjd8cE6jlrfrXoUoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gg85BekvNddVeEsFjoWjssOc5RSQicJy+m+IZ310jog=;
 b=5duyaOJKOPt1HhZOy5ZlolXzZ34Zszb6PmWzIDGlC8LC6q9qfs6t/U0oTuZTKujYW07y69BrLaYwBswSRDZrCygUSjUmjky5Vcs/AE6jmW0y8CTgdxeiYIXIVnjuF2wVIeE7pa+jySVlGL5ysm+jwLKH63vH+rDEJW23Y6/To78=
Received: from BL0PR01CA0035.prod.exchangelabs.com (2603:10b6:208:71::48) by
 MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 03:20:49 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::be) by BL0PR01CA0035.outlook.office365.com
 (2603:10b6:208:71::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.27 via Frontend
 Transport; Mon, 4 Sep 2023 03:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:20:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:20:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:20:45 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:20:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 1/3] xilinx: versal-net: Do not setup boot_targets if driver
 is not enabled
Date: Mon, 4 Sep 2023 08:50:33 +0530
Message-ID: <20230904032035.11926-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6004a9ad-d882-47c4-ca75-08dbacf5ee1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8nJ8tVuWAkG34HCHHU2nvClRCBKi7274VEnNwCkxaSPnFf6pYay2cxqm1YshQuxhiOdhiqvIvBpKMuh11XWbS/RhNjLy0MEiMgpAZgyK9KkzOd/ZcDgErljXJPFkudFxMHdFCnEsSwDwxHRk7admkDMDQGKWH/k2DF92oiEbLlUE2aJDZoT/SX0VHj/SquOen5S5/v1N6T1M5ftLBK0dayXlRb+nfR4pYSBPcXQ+wM3aujjhcYeQNFJQpkfYYWQAAOGcYU/lwNuk8CFAZQQDi887QSj6KR76PdCWa6DRgeel6C8N/3+8nP2lPW6G7GgKdmFEMalfF4lEKlMIditFHBvycJkMRU0dEWpuCmcNlzziFuJGCfBDsXqO/iggbBFq/X4NuX4LWOTLaXNzMetV0tglTziVxQ5PR7G1ybzbPVhOd0xGM6wLZS371iXQD1LfwiIVZFagWp8nIknDeTFbHI4lmJ5+eqdvmKoxHvOyXYEcXRf8pjL2HgQcgToTv3xoNIzbWmisFpkK4s01XtfDA9uWBwaIRMNxuDRAhDrIFDcHrtveXd8oeE5KbJ+7rmVl7T6VpjqnZTtgEJj9rYZuEHX39sOCH9MK37cohntJlVyUsEs1egiij4QhSMdXtZUSbtDZdEdf/6ZFFhlcnDCgjf+ybxdum2cN3qOFYcMzlN8AlqwzId7fe8/zZG+TwHbSUCtjQXSLhwTttbzqWr1FzAU+gPWQjR/tlgg6KlOWDJ6sIiMjTKH1S7i7yWwDJ5iNte0tkgXMqffnVKpJ4Hybw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(356005)(81166007)(82740400003)(6666004)(86362001)(478600001)(2616005)(83380400001)(47076005)(336012)(426003)(26005)(107886003)(1076003)(36860700001)(40480700001)(70586007)(70206006)(54906003)(2906002)(36756003)(6916009)(316002)(8936002)(8676002)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:20:46.3505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6004a9ad-d882-47c4-ca75-08dbacf5ee1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
Boot mode detection and logic around is present to setup priority
on boot devices that SOC boot device is likely also used for booting OS.
Change logic to detect this case with showing message about it but don't
fail in boot process and don't prioritize boot device in this case.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/versal-net/board.c | 76 ++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index f0d2224b33..7ad299f3a2 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -201,7 +201,7 @@ int board_late_init(void)
 	int bootseq = -1;
 	int bootseq_len = 0;
 	int env_targets_len = 0;
-	const char *mode;
+	const char *mode = NULL;
 	char *new_targets;
 	char *env_targets;
 
@@ -229,8 +229,8 @@ int board_late_init(void)
 		puts("QSPI_MODE_24\n");
 		if (uclass_get_device_by_name(UCLASS_SPI,
 					      "spi@f1030000", &dev)) {
-			puts("Boot from QSPI but without QSPI enabled!\n");
-			return -1;
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
 		}
 		mode = "xspi";
 		bootseq = dev_seq(dev);
@@ -239,8 +239,8 @@ int board_late_init(void)
 		puts("QSPI_MODE_32\n");
 		if (uclass_get_device_by_name(UCLASS_SPI,
 					      "spi@f1030000", &dev)) {
-			puts("Boot from QSPI but without QSPI enabled!\n");
-			return -1;
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
 		}
 		mode = "xspi";
 		bootseq = dev_seq(dev);
@@ -249,8 +249,8 @@ int board_late_init(void)
 		puts("OSPI_MODE\n");
 		if (uclass_get_device_by_name(UCLASS_SPI,
 					      "spi@f1010000", &dev)) {
-			puts("Boot from OSPI but without OSPI enabled!\n");
-			return -1;
+			debug("OSPI driver for OSPI device is not present\n");
+			break;
 		}
 		mode = "xspi";
 		bootseq = dev_seq(dev);
@@ -264,8 +264,8 @@ int board_late_init(void)
 		puts("SD_MODE\n");
 		if (uclass_get_device_by_name(UCLASS_MMC,
 					      "mmc@f1040000", &dev)) {
-			puts("Boot from SD0 but without SD0 enabled!\n");
-			return -1;
+			debug("SD0 driver for SD0 device is not present\n");
+			break;
 		}
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -279,8 +279,8 @@ int board_late_init(void)
 		puts("SD_MODE1\n");
 		if (uclass_get_device_by_name(UCLASS_MMC,
 					      "mmc@f1050000", &dev)) {
-			puts("Boot from SD1 but without SD1 enabled!\n");
-			return -1;
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
 		}
 		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -288,38 +288,38 @@ int board_late_init(void)
 		bootseq = dev_seq(dev);
 		break;
 	default:
-		mode = "";
 		printf("Invalid Boot Mode:0x%x\n", bootmode);
 		break;
 	}
 
-	if (bootseq >= 0) {
-		bootseq_len = snprintf(NULL, 0, "%i", bootseq);
-		debug("Bootseq len: %x\n", bootseq_len);
-	}
-
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
+	if (mode) {
+		if (bootseq >= 0) {
+			bootseq_len = snprintf(NULL, 0, "%i", bootseq);
+			debug("Bootseq len: %x\n", bootseq_len);
+		}
 
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
+	}
 	return board_late_init_xilinx();
 }
 
-- 
2.17.1

