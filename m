Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15176C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 06:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49536874D5;
	Thu, 28 Dec 2023 07:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00JpZEt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA2F3874D9; Thu, 28 Dec 2023 07:34:37 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655F786DEE
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM/eiiMOhMxYlmgRVJsN+6DG+Towo3HfhX/3hK8yLbNMvI+RsfHf+O6lQb6+kbGCmMsAroNGAyek7O2Gog52e0CSUgN3R7ZnuTUfjPjpLjLP1xuJkT6r7/oDQ34kMveZdzcuyPi8ACPEtF+hu1B9ZxDIOkC6RC3XL1GWUik275EU/lkO82V85YOL9r6tZS7ysRfyepJzW2GUoYHy6cYv7zAGMczAoJnSf9RWCXcqXWNu7Un3ClinAJ5aq1QZudQSvM8BBATIriobF4KwdYxMeFpyBCOkc3RIixxD6UpkuENkhyC0ck4dfta9MUH7fuM+cgHjskC8c8n4nWLuUzqafg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZgRtO5XMMxpbQp9JqFKsIXoY17eWlULzY9FNAQAmjA=;
 b=ai5Dk1diESij3TIGxRPwYMCxq4CdFAIGoiynEAYUW6ExgQNIN/PneZTjlMJFpygrKiJ2KALR3SCjBLe0M8lsKORtwbAG7VBeP39O78jeVeOS0SB9WZkMxLst7EDNG8Hmc4l3mElnfu/xugxn14mAXnXYlqhDLP3hXGVf6YlpOZyzw+rly3yo5HHuSa2VpihpYJMlyQwxcPRfH6P1Wt4iRjckA5UULJwriCGSexJ2e99lEe05VkXmTuDaNbMuRTluY44qc82mAqzDKdRaI7mLcElFrttMvKJse3vJ+oA1hGf/xkOlgpw9G3+LN3InAGAgPzUy9TdN+46XAfwsmKbhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZgRtO5XMMxpbQp9JqFKsIXoY17eWlULzY9FNAQAmjA=;
 b=00JpZEt7r8lvwDcPSQUGGdDSOfZr2bpsy864iL0ZSqNT9eGeJSYtdPYwaJWx56Q/W8zjcp2bwbm1KATP+gNQUqygJ/s5xTSuuMJtkoZLRSaXtNmF512TJa49hb97nFWtuQjAdkgn2CCX718XqezDh35ny+lFhWG4iFlly3BptJI=
Received: from BYAPR05CA0086.namprd05.prod.outlook.com (2603:10b6:a03:e0::27)
 by CH0PR12MB5202.namprd12.prod.outlook.com (2603:10b6:610:b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Thu, 28 Dec
 2023 06:34:32 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::db) by BYAPR05CA0086.outlook.office365.com
 (2603:10b6:a03:e0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7 via Frontend
 Transport; Thu, 28 Dec 2023 06:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Thu, 28 Dec 2023 06:34:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 28 Dec
 2023 00:34:30 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 28 Dec
 2023 00:34:21 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 28 Dec 2023 00:34:19 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <sjg@chromium.org>, <bmeng.cn@gmail.com>, <michal.simek@amd.com>,
 <git@xilinx.com>
Subject: [PATCH] cmd: net: nfs: Enable the NFS command by default
Date: Thu, 28 Dec 2023 12:04:12 +0530
Message-ID: <20231228063412.1370372-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|CH0PR12MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: c28f418e-7a22-4869-b35e-08dc076f0ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRJcTMZNvb1drRQf5Qj3ruXHlBdngO+7IYoNvko05HPOEEg5xohq5l456FrCOmGdLVgJuo8cKc2tv3TYV+WU72W8LySY+MS4O514//pNK/VK1V4/z3gKE7jxQkmp/SW84YaVFtD0bIBv+eCtiWghjt4af+ic1JFdRCvSRQi+4IVwc04dsvWbMA+1HusN7MifQ/xeotTS6YzP/cyuzJuU44cmXEix2/lINvHMs0+7/UQMiPYF/twdpDdcpKh1/A66XtAKnUi25TmqvB3oMzVmCvk3rBgabcBey/U7D5/FXzeVfqoz/XlKbluW/fTqHe7qLgGvX9Qi7GhpbUvYXQDSpUyeakbjnAyNPV1vb3oGvmD+opUmZQjqDnfjqSO7Z7GnrMus2Zp9PhRZXFRTn77E2LkBsWpzYaHzneYolDoijDny+InqQ9uJWYWpk2LjsesKvOWsPZOCJzXLxGKYY969eTCCejboQ/ZCAjmys032GFsQFjHmySBQqOPZ/XlmV+GWE7FJehfzBQFZq2HBuDaPBegHqRiWWapW8LhGp/2tlQm8z5HwLVQASFdk+aCsAr27eM1n3OnEtiAWO09fNwhnB+bwI7nbvJw8uq01nHTdGN25Pq52UCTQ3LokeNkpOSYKit4CeTZpYEZwiAYOtLEHOeL6yuCdvbkVuyCFZobWPTGY+ly8/CDbYnMDS22O50om7r3V/EY85/2RWfT4BQ+Rr91+aPf0d9i9OZmppmh/qGCO19TDNjt1D920LalRo1NkJbZi0plQVmG9hVcUD7UhtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(2616005)(8936002)(41300700001)(5660300002)(316002)(81166007)(356005)(82740400003)(1076003)(47076005)(107886003)(26005)(36860700001)(4744005)(8676002)(336012)(54906003)(4326008)(478600001)(2906002)(426003)(6666004)(70206006)(70586007)(86362001)(6916009)(103116003)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 06:34:31.3755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c28f418e-7a22-4869-b35e-08dc076f0ca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5202
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

Activated the default use of NFS command for booting
images via network using the NFS protocol.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index df6d71c103..a51b2d532f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1905,6 +1905,7 @@ config CMD_RARP
 
 config CMD_NFS
 	bool "nfs"
+	default y
 	help
 	  Boot image via network using NFS protocol.
 
-- 
2.27.0

