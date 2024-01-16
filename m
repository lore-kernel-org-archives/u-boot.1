Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE9C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 04:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E751D87559;
	Tue, 16 Jan 2024 05:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njb3A/Bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D38887708; Tue, 16 Jan 2024 05:50:55 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD533870B4
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 05:50:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxSOMUZpTVaaDG0ZZTsQJcCU8k5Id4BOKcGbQ80SKWSfD09WoLUIPtqnGidH4VD0LA+Icm/XPgjXlxvQVAteBd5gFUHZhxdklojeApcdSnEL7PxyYZeTDEMqSZFTnquph/V5m367mB0oodl1HhgOfvncm5QNgwlrE2lHdgDbfYZSSJF0fvMgNosU9aC03ErR6sMjvdtuartq/SiDXY0CO2GIPi5tF53VdA4IzgMKppQVQcsU9EevilvF8MkBjm23e3HAYMayWZUVX086F6MLBfYjTI3hEgKwyQQYPlT0qOlIE7qeftUJNFk4a1AOxsm5buJGdujuCH3dG19bQSHePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY03mN3LK8mnZrnrleQ07We2hfKd3A4sCYerppahSa0=;
 b=etiapJf5An2zqupFdUzPH9c/mbTRp16PpRjyOcLIuA7P1xGfG7tlhp0YoGo+FMaNvcA4s5j2bOjtADHMApGnrVkjm9KOeVpnOU7IotCu78Iu88yjnlHmRkv+LXJxjsXKFnvKZ71jT0v0mDCnCIZo6e4CVz/X95h/GabBY5hxyZbXLeV65elddn1J71F8bdpqa9oefPzMoaWOuAVYhLV+pX3wQFTlEZzmpxY4peg+v6pBC4BG+PuygooiUzeXg6IDRWrBXMNi9FY6wripVf+8u8WLZlJEFvYtd9muyE6bI3lDWvZu3LFtZSX/fl3wUuJ9xDZHBD1vXZSzHAgEA5CUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY03mN3LK8mnZrnrleQ07We2hfKd3A4sCYerppahSa0=;
 b=njb3A/BbWvnPR74ytL3CApbsW47MFydUizYGPRR/tn3VfOm7VVUVYn80JJTXAtT0xCiPaLBesH2CD1VlCSHbfbuDer+vkmR8z00wZdZkBBDEUSC8rr/QjOE3Hj7qRLKlBBxm1MCf5zB4md33pFylc3CBPMH7309/nsnjqpcHRUc=
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 04:50:48 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::21) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 04:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 04:50:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 15 Jan
 2024 22:50:42 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 15 Jan 2024 22:50:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 0/2] xilinx: Update the kaslr-seed property
Date: Tue, 16 Jan 2024 10:20:21 +0530
Message-ID: <20240116045023.580837-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4cdecc-4b91-4f15-d55d-08dc164eb4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wUCtFYZLdDoLZDAw7324gKLLB64dac5kTbidxqvHWIcDbtF4GEQIcTc1zVwkoS1kM3vvQ2vjcDFTQ6g5xXDR7O6RnGjgIM0cnv6wbd9amHO9r8bHW+mrouaMIG7PmSYZLgN1vTnNk+r+/yuF75QONNtZsAUGVHQUHNIZ0GOOLnzybqDL8vjKl4eD8RyUHfsWI6NTuiq8hb8t0Ck+4hoZ7yBMoclpmiqPK4e2BV1vbpZ8FC1TVqpwICYhcJIrVFm0XiH5eNsaWeXUMcbkM/d6pwX5B5wgyMlS6NNxwkylgqhylk6OEeNkd8l7L+tOWwlf2/ogtmu83Q+iOqvs/i2W8Rwcz5DRLs6E+Glz26okQXw2g/ZKqtF1V5+FBsbk1hhEcd7IWG/wS9m0ECHDrxyKZ89VbYbyqN3wt14co8WV/f9LW6W4ZVuM2RUOUDHmrsfMi9dcG+7kOQp4rodMls8WT/CEj3IACHruxVfIqSKgPWurmKCLQWuxllSQtG43ZRqVS2hix9S9y51poU/I6/i+1B/ROfO8fTVNU6aj801kNIrc25sw099aTREmevBs05xun+Y1l23JP65o/PCYfx2Ls41DnEjsNwu1vyorv4tAk1s+hEEAMwqjPIJs2Yue/IIZiksPLaAhYG4lRg6fLMoEDDs7KTs6JuvQtv8RI/wWFZC+LaguTTrR4AsQMs2vPueYjDaogpO+E2hfntG5Qot0bz5g8F56/yQTZyzk6G9xDczV9epZm4RGaVhkL6vKr3U+sOwMo1q2ATcmXJgG7NJbLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(426003)(26005)(336012)(107886003)(2616005)(1076003)(82740400003)(36860700001)(5660300002)(4326008)(8676002)(8936002)(15650500001)(2906002)(4744005)(478600001)(6666004)(54906003)(70206006)(70586007)(6916009)(316002)(41300700001)(81166007)(356005)(36756003)(86362001)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 04:50:47.8241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4cdecc-4b91-4f15-d55d-08dc164eb4f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

Update the kaslr-seed property and enable the config CONFIG_OF_BOARD_SETUP.

Changes in v2:
- Created macro for size variable.
- Removed malloc and created array for rng buffer.
- Added debug logs for all the apis.

Venkatesh Yadav Abbarapu (2):
  xilinx: board: Update the kaslr-seed property
  configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP

 board/xilinx/common/board.c          | 50 ++++++++++++++++++++++++++++
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 51 insertions(+)

-- 
2.25.1

