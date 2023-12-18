Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE25C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0414387800;
	Mon, 18 Dec 2023 14:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QekAg8Q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11ED87DFD; Mon, 18 Dec 2023 14:08:48 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89AB4877D4
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie3DIcMGpUp+x9EbS0XQ4Stxj9c69SiDX2NFYq/NK09vjAD/eB2nkvSfoA4kT/BTVJtM2Sc+ZYVW2TW15U560IQP8KF7R8/fybFeA6fY5VsTIn9VrHOy96TFDW7JDzNr6iF4W1X1g6qy4ub0Kfv3EQYWWDlSgAV0nw1VNYrElnCLJ3reH9M6jDpCpQEPA0K7cGT1TN8JnraQPhI4m59crXRMuDyOCZ/arUobo/x4ZebM2vRln1DQbLCwXfL9CyQndZzudhYkrXIUjWgIqCwo0D/LkFbN+/hTDAXKVUEmYjBwfpz77srdnwygknOrWOqFGa8Gb2Wh+Gids/XnZLEJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsDx/Po0ZzpGqJyGV7JLr5jmP28PEnyaJ9lhYmbD2zI=;
 b=CWOJtCAw0sqvwB3avOJI8lo0GxqiG/05KuMBt4rczF4QtXbU9PvTesNNsBPfimuBkSFJfbrh+YEiIh58rsX0nHi0Owj7scUAGK+7BQMFBuPJqHHOJqfQdrkFOk4EKWXkB8T/cJ6ZTDd+QIhLzaDT8PZ7zx8O9qB6WRl3+Wd8nWBvKaH+hq9WsnnWEe4jeYRsZvPSbmQMrCo4oVRLJcmgtQf0rFAoQLIzuWEWeu5gadAtpjsQwPw+QCm1PJykSPCEk6Tg6tbsNt7F3LfpI7HUe6jYTh2aB8jsl7u+9QCDzUBQm8llJb7LB0+wOOlUQTipOnLvsMeYJkczrHcka7C+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsDx/Po0ZzpGqJyGV7JLr5jmP28PEnyaJ9lhYmbD2zI=;
 b=QekAg8Q3/vTeOWDSzMRu78gAdq7nUcinUbTFJv9amPFxHv+uP/M9Q/DPlHQInaMRb1yApeCcRHpPz5sYB51CJfWOZYXY/SXDKVnmsB0wPsvmKBvm9o2nAFyuPMat0XqPpjaBDNdZUYNtXkdC8/2H4p2+FuUtfJAwA5LxFwqkn64=
Received: from BLAPR03CA0086.namprd03.prod.outlook.com (2603:10b6:208:329::31)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 13:08:41 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::f5) by BLAPR03CA0086.outlook.office365.com
 (2603:10b6:208:329::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Mon, 18 Dec 2023 13:08:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Mon, 18 Dec 2023 13:08:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 07:08:38 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Fix i2c bus for kd240
Date: Mon, 18 Dec 2023 14:08:36 +0100
Message-ID: <cf07682a611de9895271d629ee00fb2809d99d0e.1702904913.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1231; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=sqGaEr5/zAQWORSWqlRouKhJ54L6WH3GtYcG4fXOfx0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQGl6B79aa1IV8m5SoWb+L8tq2K6y5PZ1n2jCOrkq6XX
 ppfUv+uI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykroNhfrBjzCk9625bH309
 ic/bg1o85WKeMMzhU2Rl/HTwsBHbBFPRWpNNIo1rHs4DAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f00d21a-7de3-42ec-1c79-08dbffca7495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btViWJcd0+mLklVL3L0neHoTU9lQcsmj7jr9OHNmn/uqhhhUYm1EmAxtczGC7/1hpdxtyTkm8jS+2IMiO8s7C2ZmtOlZGMTkLlkcaoptUPLz8Y9WamV2FT+XlmShZoy61eInpKeJSvyLFOSK8LY/+WNMwGYS8wgkE5IMmehWA6DsRSEEUEbpoZa1hO5jmmBBtdqnYoxXOq2cThBF3uxPXqp+zZlee4Lmm+nwKqQUKeCz95VSMPV/+QU0XERBt8zeraOnFt85hVqzffmsW6I3Ap10uiATrsyeMwR62sWufPelMqsUDc769dvKETIIZf5HCsz5K3hzedpwC1fqzB4MtnrQQlmwxF++Tuf6YzooUb8kvtixeGXEM8riLEJasUxGb1ibYTrvnhHXypbM6E/K2PL0WHDZ3/DNA65I5ymwP4UKPXZTtIsfvtyvIF0s/ncKXyIajo60cxLcOp08OU380/We2UP8GIkWk6jB/c1M3JTLS48vZMwBUfvOsg+thcfrGSRqdfIGOdnsICUdvo0i86wCExzciw346A0kutsHw5tZPTt78BUw5R5I/y+yQRWzOvXG/IyBz4NpADcu88d8bnhXzpDe4ChmBuGT114Ivs6SQ119FfERDWdwjF7EvqwHRyjjVyvDAkgrLTuO/TwKF+Bymf+G4M49cLq95ejdj+MOJYhqLh0Q/qqJUxF0GvPJ+Wz6yRvQaNRTFVESjmHf4xYWiz+1yYDqOZ1MrD7lvyPyZyaJ3ops23Uabobbt15nbwIN64DGGSWeoNZhuTIP4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(70206006)(82740400003)(81166007)(356005)(36756003)(86362001)(36860700001)(26005)(83380400001)(336012)(426003)(16526019)(2616005)(2906002)(316002)(110136005)(8676002)(8936002)(478600001)(47076005)(5660300002)(44832011)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 13:08:40.6994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f00d21a-7de3-42ec-1c79-08dbffca7495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

i2c1 is having all chips on it that's why use it instead of 0.

You can see this error when you boot system.
eth0: ethernet@ff0c0000
Setting bus to 0
Failure changing bus number (-19)
Enable permission for node ID 33
Enable permission for node ID 47
Hit any key to stop autoboot:  0

It also get USB to work.

Fixes: dd4a82201694 ("arm64: zynqmp: Introduce kria SOM defconfig")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 70384538ab1d..36182f1b0d85 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -58,7 +58,7 @@ kv260_setup=i2c dev 1 && run usb_hub_init
 # usb hub init
 kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
 # usb hub init with enabling PM nodes for ...
-kd240_setup=i2c dev 0 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
+kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
 
 board_setup=\
 if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
-- 
2.36.1

