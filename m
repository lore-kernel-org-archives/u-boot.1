Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB57EE9905D
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 09:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2638841CD;
	Fri, 10 Apr 2026 11:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wRt+2xuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0027984199; Fri, 10 Apr 2026 11:30:56 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FCC88412A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdZyPgiRMl7nnsizC/YQtLZLrsxPYrMkeIhvUptGb6D3lbsbbwQc0Go48nUWAG4rpSISq58Hb/LBZMNNvyx3XbDXnxcBerLEv1z/nyN5LQZH+DQbrbIf+pQ93N3Bl3fDwrBqfM0G+0/ckUrSFzwfVgDvLvqx90fRChDqV9bm2rr1cbqN0VO+ZOVNsHM6pWPw3X9QHk9ht0OY4AM4Z/2uzHDd+nZ0TYNpmXsmQkqNxigekpYWQGe5bpCI8mZ/AbUtPtB+M4WAewNbKmiXpfiLYoYxk7OavYlDTajks8ONAQP9TN45nDAoiS/tPUV0qFnQadT6eQk+qLbpnHSU2zRHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhSK5sBu4prht0qWZmBKS9bWhDeI3CRK1YVorwLx2tY=;
 b=xP/cD0IuL0AqaG0tbl83rAMHfNIZDex7teBV2As7sDgewwSzd6qaUh5oD/stBRw9wPLJO5Xf20HUDB3X5llo7/rxCtV2hWh9SMjPtLxCG1l+BYJV1qmJBVeBjuVQcz6v2w9MENMR64++fKjC3/mYam+uoURAbmw90HTCLrKQKaSDMZKsc6aU47NGi5O7SZYDqVD2bBQZFvDoK9O/+qDY3Q/uJ3ZMKiZrrpPbjmckmF+VRXPQ/OF3SlN9fY8TriyLWBiszVRt+i0VXfzCinbuRjEqWfG0GqG0eYaKfj2LmcKy9FcY320PPKZUfilUsiDhRkpqek2n1UWHrHZUS+SENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhSK5sBu4prht0qWZmBKS9bWhDeI3CRK1YVorwLx2tY=;
 b=wRt+2xuJZLe4oUIK+VWsNOdneSh1hHcvZ6kRYdAdQGfJnPqHitsHmgGJgCYNJqsGuRPe7kLMNakp0Og/19oMcIw70G4siGy3ecBtQZHvTnYUBLM5aNmjPXVcbHlBt+eQSjUOwqBDjwtygD2g3c4ywz23gv6+RqDzF6L0XuSZquc=
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.33; Fri, 10 Apr
 2026 09:30:46 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::27) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Fri,
 10 Apr 2026 09:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 09:30:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Apr
 2026 04:30:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Apr
 2026 04:30:29 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 10 Apr 2026 04:30:28 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH 1/3] net: zynq_gem: add SPEED_10000 case in clock rate
 selection
Date: Fri, 10 Apr 2026 15:00:16 +0530
Message-ID: <20260410093018.1461732-2-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
References: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 382c36c3-c928-4e44-7428-08de96e3d847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XXAoKr6nC9gKhLFTGWbNOfkJvHHkHUNzZfaLysy0kWS1qqUh+FU/9lwHmIh1MfPtHmZfDEfssiQ4Sv1RPxUHOHDgQBRacQkIsF1YJIsrNyfmtk2dhf6ZhmBYtnSJ/uiNvkdhx6+keJ/Tev1NAJjyeMhDzuKiO033lDaRwtS6o2hRXIvexP+P4r8x9kr8K4WYniIWtWI2a1m7qHflB+IU1OiNV+Ptf7dzDHuPu9zXw7UoOzRBYZ2Gzli8e3GhpSCGqA3NZp2CN2rW7ceKgb4EFFpzLJzfHapdm/0xeXAIQLwpEAw4XwasM+1BvlkicIG5OzxFpyt5blqcjb1Dz7OqB6BBUDiVqSeghu/L6dQMyYql3epI6jU86ZSiKtK6E+QfLzkI976i3ExAbS7O4GrzKEXYzrsCHUvvf3mFvFCt0Q2+BW0qAE7UzSnitFzUfOF+wkCFAa5JvTlx8H3XYgxDaLjqAtEtAoj5ts1KRE7bUdwChicM+xQQmkqAcBNlQxIh92mlFpyx9XotO3T5+OEOjBowHWICMoSzJdXZt0ifSyZoqxQquFbGKf5oMM1xpfygNHnGH1uPeVAbr9VnWSfEl7QLcz/d91OWPntOZLkcwa79ceDs18VM59FZsYc68SaGeVUqsNBh3vQq3Qlb7ie+e9hUOWDlXkqkSfzY5fNHWDT2TResdtAf5GVP/aw07z/SF1jwkeoEhIhO5YxdTWB6M5rvpNeJTWDbrLonpbl1d9cv5BAh3di7z33QpotfjbhFZ5zgtramUStuNPHSuxUNIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: a7bdrZyFSpfrn+cprZAxuivMePCJpugh7CgjupLlHGgLlfI2PLbi54UHKRyk4kd6ZIw1jU2zKWMxtd515rUO4VswIp8j0I5Dg/LKotH2ccxGXoPbXE0zu5oV7LV175XMPb069lDtY/lK9buuPdzRQaREmfLl4bHoR3X3rM73ds6wS8KDxTwU9etz51wrPwr+SQ7h/U1P3ulMnu+7xq3kfovfl6gwJ02JWvC6s48Ld7SdD2C+vMg8O63uHQHhvZ5VuCIAXf3nM9xK1XTOYWErY8azSGctNHm1egM/K3IvcnSzBPf+WFfwr0wor/knJ3OjfxdhBTkxsm8orJt726WnJrEFv0wHuYmngmVbC7wYr5EXZyMYwNHgGeK/Y1AwoT0yZ5Sl12V4YMrtoiVXPMq0C5Y9Art4/m1z55Tf9p0mnza8U6SgfAd+NfrkT0f++SQX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:30:46.3080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382c36c3-c928-4e44-7428-08de96e3d847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
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

Add SPEED_10000 case in the speed switch with the fixed 150 MHz
tx_clk rate. Without this, clk_rate stays 0 for 10000 Mbps and
clk_set_rate(0) on a fixed clock aborts initialization.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/zynq_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index a50d5aee03f..c06d114af68 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -134,6 +134,7 @@
 #define ZYNQ_GEM_FREQUENCY_10	2500000UL
 #define ZYNQ_GEM_FREQUENCY_100	25000000UL
 #define ZYNQ_GEM_FREQUENCY_1000	125000000UL
+#define ZYNQ_GEM_FREQUENCY_10000	150000000UL
 
 #define RXCLK_EN		BIT(0)
 
@@ -602,6 +603,9 @@ static int zynq_gem_init(struct udevice *dev)
 	}
 
 	switch (priv->phydev->speed) {
+	case SPEED_10000:
+		clk_rate = ZYNQ_GEM_FREQUENCY_10000;
+		break;
 	case SPEED_1000:
 		nwconfig |= ZYNQ_GEM_NWCFG_SPEED1000;
 		clk_rate = ZYNQ_GEM_FREQUENCY_1000;
-- 
2.43.0

