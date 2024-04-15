Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D55C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E34587EDD;
	Mon, 15 Apr 2024 13:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1YaHwKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A2587FA3; Mon, 15 Apr 2024 13:35:34 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC0388190
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6rlg+GKZHEFiNpqcS3i1bOuEPe6l2+kNyWHyTrwobiHV7W56NffZ6daIlwkC6IBHmgztfcr5l4ad1zZH56bxG6ZsYYdx8I3JShvIE3B3Cm3tF1ZbQhIMkkYHfYIJ1yePh+KsYuKInfMmY/t7DPrfMQHfceY9z4ptH/QKYdLZTtPq9qx+KlLoT5IEydZUV/V0AXsFO6WH/WcBTbgZOXE8NG7GYQTfyh8lbqwCT7CYRhZiNSzyNG3kIhbHTMxHZOzq1RHUrhlR+IrK3M5kLMTosTYXL7ths5/fapsSsVk0MvYOoxrCMOxemQJviNKDt85Bl1KHzOoN99aW7WB8nbT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySpX7uAljXx5IMTrHKyQc4ftte0x2l+WzV+YGa4dHjU=;
 b=SmOAh67+C/aLsRzY3VvtSeqo1eDXVxoRvggzZ9yMVUUsqaVtfTmbMlzIxu/RB0+bsfvHdHhKNZTknuM8vsQH86jb//wbP+3/k7IouYkKN9wlBd8DzMYCbplP4biFi6SufHSkd9oRztfHOCdml0PtXZc1QVSCBQ3Amytkq1qkhccBuP55XJHQI2gNjaesKmIDhy0b+AHlOgkNkOOeiL0yQ4sxgxZp2o/HXLmbFkjjjIsGVNYss42UcAT9xWICMBhbnUI+N9ihQdl/UQxzgROOQpSeUenWSWhay6YUWcN5TjM7ehtGb2pN1HkQZPn1Iu71eM6YWUSXYYHbTLhCAPK8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySpX7uAljXx5IMTrHKyQc4ftte0x2l+WzV+YGa4dHjU=;
 b=U1YaHwKX3x/bSb48Jr0KplGUPkgIL2foA5FEhVVgiGx4g6aMPkrA6zY1qRMTEF8mW1ldf4JdBLUN0wvFEPu7yKnhd9yIY9uDe++BrKZiZmtbJ6rahEy2b10iVpNSp5SlO7qq1bhnXBggNa2eZNws2+BoKMRcuO/kFpBNUuYWm7k=
Received: from BLAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:32b::23)
 by IA0PR12MB8226.namprd12.prod.outlook.com (2603:10b6:208:403::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 11:35:27 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::53) by BLAPR03CA0018.outlook.office365.com
 (2603:10b6:208:32b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Mon, 15 Apr 2024 11:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 11:35:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 06:35:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Sean Anderson <seanga2@gmail.com>, Sumit
 Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>
Subject: [PATCH 1/4] Kconfig: Remove trailing whitespace in its prompt
Date: Mon, 15 Apr 2024 13:35:07 +0200
Message-ID: <b09dd57adc6d328967ffce729107fd30113791a7.1713180904.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713180904.git.michal.simek@amd.com>
References: <cover.1713180904.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2568; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=TcBBHv9MZWTv6/0p+Q1qRBgtL5wqBnsWrbUBR9fJpnI=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjRZgS9JdVxRvSX+m4Pvnde8amiyKkw/MSZ63aWQ/OLSu
 0n30nd3xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgIn4uzHMjwqRPiDWE2Ysomtu
 dPk5v4bMvLMGDPNzEpeHfXzgsbioes1+pqubp7PkneUBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA0PR12MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: b11dd582-7d24-418f-8f9b-08dc5d402576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoOF9VTpPRCmcxPV6JLYgfI5zCW1PawyD1vLIgJ0srqRjVWhv6PZrYLgntD7u3H6el2rlQIhoBNiA8k1+nFOYa5Xrje2SDx62dOUfch3Fo3GltcFQmsUvNWqJ4FR45mJ4NR9qNhguzivF/fMjv31IUvVZ9j8+2cFboDvrudzHdrYuG1QMauXHCYuFWqAO3ZdxSAZE6mdRSAskMZ+UqTRH7lz1m25uzwdr/uIEjbMC2HUw5nUB7gXCiaW7RbZLw5UQ7juMuyIeGh8660EIK2dk8p66Vcm0l/2XvlYbDCgT2oxiWOmWTnfHJoNN08jyw3lUHW2yaiNosMnuSJYTPvbHYV5WrqgBcHx3+T05j+tIeZHZNrl5Jo3e2yZEEAckU0pp+HUNa//zu+Dm7IKrk0A6xgaX+lM80abdj1eBkhzfTTgNzgB3uO6DnO4f4CrPeTzo9YnR3wXzm4Krs/RT5206ikHy+bl6hat7dGE9PJhjj08VbiOgNwUVjD8qXJ5KXg2YSt5dA0UkKfLVMAhWe6TgWQ0bBsqNQWt7qDOuIAwJugx1xBaoueyP6a1pUZV6zcJHwvYoBV7Q0u/XD63Iv4N9E0KdyAqgBINLguEukuiqRIvFX/Y2gVLqJF2WLoW/vjxZnH7wQCnnXPUDVDTCUcpVLxksBISRM0YaaeD9/jqTbcUII0qNV3BXTBphz7aofIu9Xske1iT9zyOfUD9SxGT7VG6aSSZqjRpr7ty/k3XZbumpTyrPbKmsf/WuvenNKyJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(7416005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:35:26.7116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b11dd582-7d24-418f-8f9b-08dc5d402576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8226
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

All errors are generated by ./tools/qconfig.py -b -j8 -i whatever.
Error look like this:
warning: SPL_CLK_CCF (defined at drivers/clk/Kconfig:59) has leading or
trailing whitespace in its prompt

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/clk/Kconfig             | 10 +++++-----
 drivers/ddr/imx/imx8ulp/Kconfig |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 017dd260a544..bda6873be331 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -57,27 +57,27 @@ config CLK_BOSTON
 	  Enable this to support the clocks
 
 config SPL_CLK_CCF
-	bool "SPL Common Clock Framework [CCF] support "
+	bool "SPL Common Clock Framework [CCF] support"
 	depends on SPL
 	help
 	  Enable this option if you want to (re-)use the Linux kernel's Common
 	  Clock Framework [CCF] code in U-Boot's SPL.
 
 config SPL_CLK_COMPOSITE_CCF
-	bool "SPL Common Clock Framework [CCF] composite clk support "
+	bool "SPL Common Clock Framework [CCF] composite clk support"
 	depends on SPL_CLK_CCF
 	help
 	  Enable this option if you want to (re-)use the Linux kernel's Common
 	  Clock Framework [CCF] composite code in U-Boot's SPL.
 
 config CLK_CCF
-	bool "Common Clock Framework [CCF] support "
+	bool "Common Clock Framework [CCF] support"
 	help
 	  Enable this option if you want to (re-)use the Linux kernel's Common
 	  Clock Framework [CCF] code in U-Boot's clock driver.
 
 config CLK_COMPOSITE_CCF
-	bool "Common Clock Framework [CCF] composite clk support "
+	bool "Common Clock Framework [CCF] composite clk support"
 	depends on CLK_CCF
 	help
 	  Enable this option if you want to (re-)use the Linux kernel's Common
@@ -164,7 +164,7 @@ config CLK_OCTEON
 	  Enable this to support the clocks on Octeon MIPS platforms.
 
 config SANDBOX_CLK_CCF
-	bool "Sandbox Common Clock Framework [CCF] support "
+	bool "Sandbox Common Clock Framework [CCF] support"
 	depends on SANDBOX
 	select CLK_CCF
 	help
diff --git a/drivers/ddr/imx/imx8ulp/Kconfig b/drivers/ddr/imx/imx8ulp/Kconfig
index 5448c33838ce..005f581f4baa 100644
--- a/drivers/ddr/imx/imx8ulp/Kconfig
+++ b/drivers/ddr/imx/imx8ulp/Kconfig
@@ -5,7 +5,7 @@ config IMX8ULP_DRAM
 	bool "imx8m dram"
 
 config IMX8ULP_DRAM_PHY_PLL_BYPASS
-	bool "Enable the DDR PHY PLL bypass mode, so PHY clock is from DDR_CLK "
+	bool "Enable the DDR PHY PLL bypass mode, so PHY clock is from DDR_CLK"
 	depends on IMX8ULP_DRAM
 
 config SAVED_DRAM_TIMING_BASE
-- 
2.44.0

