Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C8ECA0FF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 13:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB008699B;
	Mon,  4 Sep 2023 15:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ohPSnT6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A4986879; Mon,  4 Sep 2023 05:21:52 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A886867B5
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 05:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkuVJi8/KrWZiFmOuVBu6PHt5M5+NNRDWnQ9JLb+i+U3ZqT8tr/Wbrjfagb0gt/84g377E7p6Osem36x9sqRSURCHT8eJ6pIRB4Fl1M/VvI4eWy9W23/bx84UeuMRgKCchn1VylC/LeZqZ7ZJd1rgkSZnTqQSvq59DFDOzCq9aek18y2nW5goEl2yRMnE+6gKsDhBlzVLIB5UE+kAZhTkSonW5TZko6fg9WOu3FvEeZkEYKo4ZquM77gm4vvSW2Pwk8aoLDAJkgBhsYgjrQefbwGHLQGUH2z5bKSZAEKKiVCwG0TQzcO+e2RDCwAolCIAH82zHsacRj0yzFLilREfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/knzP5tXiuPxkIUMiswJsHaGots66jNuqNzXiY6eQ8=;
 b=k1sjl8O9DB/uk7w+t4n42pcECHU/e/45+rB0b0mV7/6XUxwF8DgrAvUbnUwjVgBEdNnOE6Y+EwIE8GgTR7KmA69I23WLwHC5lZNKYYuncqdXqtJdiXBAMxVHT0bt7HtSWS15Zsjiok/h/WMUI1BaEyjNpKBLR5Wsi/U6cFT6lcUdsEfBkYX7Jy11RTSZkRU6FetimH+EmXKjctEwcCONtQh38yEE9GSHpZFo6gpl/QG6+bMDdCvELn/PKXmtedGfZZ00dC4z6vcGA9kvs9b63X9HBsoDTBspS4cmZMIcYTStSoFmiVtgrN8ixm1EnP+M5/6cwuURrPI/jNfKdkVGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/knzP5tXiuPxkIUMiswJsHaGots66jNuqNzXiY6eQ8=;
 b=ohPSnT6BiZKqbc86NgpR7NksHHLH54mmNIyURSKIai6WzQa1c6zIVzsLhruHu/YdaFL7t1LIqW3FFGz52V25NOEhPhdvG7xl5n2GQnDcbhA5Wk5IZar2Vj7/0dIVTYKI/FUG+yDlvMlpulGSt+DfoSTa4mDSwgGCj22+WglGFP4=
Received: from SN7PR18CA0025.namprd18.prod.outlook.com (2603:10b6:806:f3::29)
 by PH7PR12MB8595.namprd12.prod.outlook.com (2603:10b6:510:1b5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 03:21:43 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::df) by SN7PR18CA0025.outlook.office365.com
 (2603:10b6:806:f3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32 via Frontend
 Transport; Mon, 4 Sep 2023 03:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Mon, 4 Sep 2023 03:21:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:21:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 3 Sep
 2023 22:20:46 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Sun, 3 Sep 2023 22:20:45 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH 2/3] xilinx: versal: Do not setup boot_targets if driver is
 not enabled
Date: Mon, 4 Sep 2023 08:50:34 +0530
Message-ID: <20230904032035.11926-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
References: <20230904032035.11926-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: bd47c1df-3825-4231-be3e-08dbacf60faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OremzvlL+1S/DiiVGTKcin/ZeJAtM9mRJmHDRzbhHZ/g4P9JDC3+7KgkbDCau6n9QoOZFtPOXgfF7oLJuEoDmQMB4oXunN08YE4t9G6QBc93BQvJSAEuKyPY/oj6leGmnnF/bDAfwYki7vnyI/av/g3PmwfQK/3S1JBdUP1T6DQNL9aUEQh1zRG71dJcEM9NwJOLdxXz+fYwK27DDTzX5WA2yP4ctceSaiGe0YjCacE8nc6lojwX8P/MMnxpjFDNkkqXqUQYj7dhigQ1wkEtk2/JHHdbBE8hy0FnT1gzIBFR72fLPscEG9G4qUAN3tFGzGNIpffKGTUNO+4B9i1CHhqt4XC+O4ndM/IZ4oDR4jS0RDeYZYcVNBwo9ff6pjUze94ZNpG7LeCIUvlBIV7weWZ7jdbHxFAZ4HFSjYYE0g6v+C+G+rZWs76u+uuqjA08vxLLUGae1HZta6r9DjnKzcOlYJ5JtpF01TK4ioWVH24SO/W8Xw4HM9Qnt/dYiRzLFgwfQz85fVr2wpUi5eNvbZD4Qn+CdcC8PiBBaNAlO6T2XLZpYgq0jljO10GQAydKK8NCKySA8AFitf5FZN00RQGBEyRDJjcjfSgwPw0V3r20Qg7+PG4ST89LXA/X+sN6vsXkFO6vIRXxjIdjKchYLggBCEQkcSzNTgTzQnSn8EcDUFx1By3YpXEUHvjMvVGZouZOYRtcTJONy2BbRGV+t9RQCA8CUvKuhkgFJ0DopSxtMimzX7xdwVjA2oc7kfFxxEDyrUjefU/s1zfPbNViCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(5660300002)(107886003)(41300700001)(40460700003)(356005)(1076003)(2616005)(26005)(336012)(426003)(2906002)(47076005)(81166007)(82740400003)(86362001)(36756003)(36860700001)(40480700001)(4326008)(8676002)(8936002)(83380400001)(6666004)(478600001)(316002)(6916009)(70206006)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 03:21:42.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd47c1df-3825-4231-be3e-08dbacf60faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8595
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
 board/xilinx/versal/board.c | 67 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 60bf37d3c9..982a8b3779 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -133,7 +133,7 @@ int board_late_init(void)
 	int bootseq = -1;
 	int bootseq_len = 0;
 	int env_targets_len = 0;
-	const char *mode;
+	const char *mode = NULL;
 	char *new_targets;
 	char *env_targets;
 
@@ -175,8 +175,8 @@ int board_late_init(void)
 					      "mmc@f1050000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@f1050000", &dev)) {
-			puts("Boot from EMMC but without SD1 enabled!\n");
-			return -1;
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
 		}
 		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 		mode = "mmc";
@@ -188,8 +188,8 @@ int board_late_init(void)
 					      "mmc@f1040000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@f1040000", &dev)) {
-			puts("Boot from SD0 but without SD0 enabled!\n");
-			return -1;
+			debug("SD0 driver for SD0 device is not present\n");
+			break;
 		}
 		debug("mmc0 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -205,8 +205,8 @@ int board_late_init(void)
 					      "mmc@f1050000", &dev) &&
 		    uclass_get_device_by_name(UCLASS_MMC,
 					      "sdhci@f1050000", &dev)) {
-			puts("Boot from SD1 but without SD1 enabled!\n");
-			return -1;
+			debug("SD1 driver for SD1 device is not present\n");
+			break;
 		}
 		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
 
@@ -214,37 +214,38 @@ int board_late_init(void)
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
+	if (mode) {
+		if (bootseq >= 0) {
+			bootseq_len = snprintf(NULL, 0, "%i", bootseq);
+			debug("Bootseq len: %x\n", bootseq_len);
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

