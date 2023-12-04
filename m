Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383AFC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 08:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFA78755D;
	Mon,  4 Dec 2023 09:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egrYEIPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D384B8755D; Mon,  4 Dec 2023 09:45:32 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8C68791A
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 09:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQZcdnSuULuXOr/jzAIi2EF+hT6Rh8EkMPpL4/U4D2sobWUYIa2zCCQdfcKAg2UNCQ90Fe0KQYu2ohyp1pQxL395NUtF9/D2zWfRZDKlDZdPKuPaaMIA7666IrSKCKAuHK6qPeRvqJ1CXSoU6xBUavNPGPqZnnKBg6/0bSrXofCFODOrqQU5grObqZIXISOwzxbZngXDNyjEQ1hdOzwm6NEdgr2a/uk7O212VfXsEl6OAHX0y0g80mwsIG1rNX9VRE4Z+m/clktS3WcMM2G9l63pS99iHHzM6wW0oD5fDiwifedt1n4dtfbnsCBqelRlZSeEru1Pm1Jxz2mxEfQt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3+BcbUD0Mgobd2ez7J6oBRNlTnHQkTnz1BDl/aLcF8=;
 b=F0cKWZrmB5MSJ3XOaMYK/IzGBaMT1MJeEbY/OakKy3HvW0CBS6xA0PrBku9PnLwytqO/PzGZngAwqDnYTF5r4dEMqH/szEoJ4WDa436ub6Azc+WV7sEyyT/wIJnIZYKWOI65MCrFw5I/jLZbSsNCq72ahn4GrGys6HCvnTzoV4EHtP4JS9ToKZ3MU+Bj+cC34fbO+OQ0wABVc9+cj0KnVATFlcSTyF1q1+DUHIOnBeuBI+N69D6CDSYGwqI7SSCJ4uHQJnkMpr07wx2fYlhFALK5ZoS47jb0IWXkZNb1K+8tVDPl1FNsaIP8VRrS4sxmmUQfLC+5teiaM3gkk20emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3+BcbUD0Mgobd2ez7J6oBRNlTnHQkTnz1BDl/aLcF8=;
 b=egrYEIPA8SIL2DLiu5m7Ei78X2Bg/6poOVNAS74eN0KQLF3Lf2qsV7bOpeOWtQWfCNxnrd+HUVRS1ewKD8Lcc93wkZScGNcxDIL4VbwR/5UlkK6lrQPE5m63u0rw4V5vRnwirdMqsH7BNMQ2mvkDfhIFA8XqcdY/1LoI4doBezQ=
Received: from DM6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:5:190::18)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 08:45:24 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::14) by DM6PR11CA0005.outlook.office365.com
 (2603:10b6:5:190::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.30 via Frontend
 Transport; Mon, 4 Dec 2023 08:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 08:45:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 02:45:24 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 02:45:23 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 4 Dec 2023 02:45:21 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <git@xilinx.com>, Sreekanth Sunnam <sreekanth.sunnam@amd.com>
Subject: [PATCH v2] clk: zynqmp: enable topsw_lsbus clock
Date: Mon, 4 Dec 2023 14:15:15 +0530
Message-ID: <20231204084515.9488-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f55b230-7fe6-480f-eba8-08dbf4a55b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVlXnvB40iAP9vdSUNcBq1eFQXLPaLGbFOpOYyUakhPnHDkfSaLL6iKjDSnj8riwRQVpbUeC+ImRfyC+nzrxhqeB182wRJ9ADbAI2ApbHgT6GCaQlkcLEunO8kPCpJy3R8cFEV9T3xlaW47hNoj9q0lwd+weO11YxiVMY/ODsKnhjbOZBTsemi/QWTLqOphtYR/tTRRs8Wg62d3/mEJ5+bTfYzIfRgCm07pTV/jMrG9wv4g+oOdC8mkfFj3WRp04HrNVJGiINUEgTJJPbsczAwS+V+y30AoFFff3jLfe8tm1GnMx+V/i+dnvBZZ0p+xZVK0oAxbGxfrtd/Ir5hz0S7g621+0iiRN4w3jLxUC5iQuSZqV1S4l+YTArPIerJY8YHut45QIxgQF//xbUjy+cZg/xhfO0k50OqEFsYTEqZFt4TJaA1y5WtvvuYgOlMPJxn3S99+PU+RMdoJdT5sM6jL6QieX3fBQnSJhUaRmaZVrQKXIbpCXorbJrZYVceUVCqRgXncPRyBDbYhWxx76sElN7HWuV5sYoaH3CmA4wkCa66YD24b+KwB7nuXTAEAqeH582xRbO5E7Js9vhQ9qxGDaAzRCfd23as6e60N2OL/T1H5kCfw7+m9Qu42SUfrqyeOQSBWeBvRZV3BHJKf9/GYbsJqa1CygljZ6+HrgLxPaOxyW23pdz3xKIYPI2Z1a5I0oc4y1BR3YeCvM3f1hXQj10slPIDz8TIkTXh4r2b/ZlAkaCnJYFiIhitQGWVCR84r4xKTJ+MkMBvFTPO9ZFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(478600001)(26005)(83380400001)(336012)(47076005)(6666004)(356005)(81166007)(1076003)(40480700001)(82740400003)(426003)(36756003)(2616005)(316002)(6916009)(54906003)(70206006)(70586007)(36860700001)(5660300002)(4326008)(86362001)(2906002)(8936002)(8676002)(40460700003)(4744005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 08:45:24.6002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f55b230-7fe6-480f-eba8-08dbf4a55b9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

Display port is using topsw_lsbus clock, it is failing
while enabling the clock, so enable the topsw_lsbus clock.

Signed-off-by: Sreekanth Sunnam <sreekanth.sunnam@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Fixed the name to Sreekanth Sunnam.
---
 drivers/clk/clk_zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
index 1cfe0e25b1..c059b9e8e6 100644
--- a/drivers/clk/clk_zynqmp.c
+++ b/drivers/clk/clk_zynqmp.c
@@ -844,6 +844,7 @@ static int zynqmp_clk_enable(struct clk *clk)
 		break;
 	case qspi_ref ... can1_ref:
 	case lpd_lsbus:
+	case topsw_lsbus:
 		clkact_shift = 24;
 		mask = 0x1;
 		break;
-- 
2.17.1

