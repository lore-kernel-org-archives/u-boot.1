Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482B6C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 06:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995FA88288;
	Tue, 16 Apr 2024 08:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JSaTQ25Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542C0882AB; Tue, 16 Apr 2024 08:55:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B99C87F01
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 08:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzuMDqH0WnkgqdVMkClgVrgaaoM+ex3P0HPbhZcwLWnXZf0c2dbpFgJHAvFM3Oz3V42fZA+emzHt3QxDy81g0xEKkE2IT7Jx2ARg/OlaxvTiYAEfHdh5xo9/JoPUBkf0fBDoG7UJZ1IuJWfUfSiNhbQcbk9wqFZeKT+FM4udVNGmjmMMBNn/VZKoE6pPhzB+0xvl3PeP82lpNH4T6bOg0RJjHBBoBvjgNnNu75mYKMJmPi1TUibA/sVcdPxk97EfdrdPJ6OF53FkY6vkcEbqiYuLDizeGJeR5jh+Fcv1jTQmdZryR4E7AcQ3f3Vu0sc68GUPPEoIsnFe1wq4ddMuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sFmYfXnbaghU8Quctz3AmrywXm6mdKIVMiDplIpVGp4=;
 b=dzIJ55/bq5G1LC1YVGk1mZaXuRHBgwK9qi+LHjF0iAlbZ6ZcO+JYlPkQhcXliJLN5sD/sY9f+TB+53PVf+rkvKN4S907jZosVAV6aBCfC3GWnAiNYDJxPoP02dl4hx5IAIiLHe5pIG8J+5MHztAEEgTPRONJpuou9xQwffpQvCiSQ5rwTB2BRPmI5kQbbJfUta3BGeHmLKcE1mm8JYEi+nHzEx85egIo2yrifziT9WfK8h5xC8CLG3kEBQb844AhUj9aFRtqHP2gOJwCzFhZ+FT9UJhm1WmQjm9VTciej0jUX4gMfvVW5DbjJ7hH/3YI5xJttbpimLRFVP2cS3AphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFmYfXnbaghU8Quctz3AmrywXm6mdKIVMiDplIpVGp4=;
 b=JSaTQ25Q39p1/iRSghd9c6OyJNpv9bO5qVy0AOPN3+ySVwlr5aJMvBPDeCk1fdaKuVN+X9jOZKjegBXYr3kZ6aUnK4LyPkCjPusciDTGXgQ8RJKVevbJTVi7ftuLD//7I4GxgamZNpWrSsbDhXd3YYgEzdD/xOa0EZa7Fp+ephs=
Received: from BY5PR17CA0019.namprd17.prod.outlook.com (2603:10b6:a03:1b8::32)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:55:33 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::da) by BY5PR17CA0019.outlook.office365.com
 (2603:10b6:a03:1b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 06:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:55:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:55:29 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH v2 1/5] Kconfig: Remove trailing whitespace in its prompt
Date: Tue, 16 Apr 2024 08:55:15 +0200
Message-ID: <b09dd57adc6d328967ffce729107fd30113791a7.1713250508.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713250508.git.michal.simek@amd.com>
References: <cover.1713250508.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2593; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fW2V2quAbjKUuwFPO6lQPM4pxZGQdc/RoUpKwWVM0Es=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQ5hRvrSsTUrIyefnR4yLNzidGl0jmVuR5rNJ9v/ihtt
 z49pa6vI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzkty/D/Mj1DeaxYvPLvrfE
 B3cyfzjz/LdrF8NcobWzMsyL36gYvTld/+R7VP73hhcCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b26f153-fe04-4e3d-0c75-08dc5de2356d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnwNZzfwti3w3YVVxswkqM+5QTvhmE8lJAjdDhdgm/jr80E0I2zYgzNHha0yOwIsyYqTbYNHvImYlbb+bPb/lrqAq8w/nUpqWzxiCLtxIrwyVK1jbEJprWN5yoTy+zjF7ZnrH47QIDEkL91qx8wsRVXCzUwnDC4jx775Rq9qYHUfULVKp5pNYxG5qG60PbkxhVRuqOmuiSC8nEB9DqgJHiJIOF32N5bIhZF6hMHEMNxVZb4ooLmXb2O0hH4rMCwFayzlh3Vqk1LOftkMo0Jdf05bWSzcnjKXEoIjeUGVl0xk2NZh/ZRIiTpwDBESHsa2ItEFYLsu1JZybVWnpqTcfTjOSFVP7wpAIq8sa2Xk5QKSgbiZK1YMhIOYXZUKjsE/OYJTb2d9ghUMIYGb9eiipGwTsm0e5loEv2COr+DgI5uaYt6txTwXPjlF9YIFfos7+4p1VcQxq15+ej14uJvDOEIzZkoZKcG0SspFJu8C07p3O/uYwZRRum1nXmeEAjg78aEDdYhZccSG4AUYZ65xyGlGRRx4VNAjzXC0ZIkyqwRHFpOiIsss1889kEPThBhHGHOuk5NtIH7fcV7R1XGxDf/ygquoMvmXF4SH6IurHPVidusYWzGTP7l3Q7Y0DGx+dd2/YvyTdq2q+7Fg9HPYYpg0RVlsGfB2SkeZzu0QpGFTZwaahQYBQt2XPDo9jzShp9X1D03elW5P2Kz+zGAK2BXVYDdOJBAMn8tzihX+tHkvUuWPShlqbLeF/MKRhycx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:55:31.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b26f153-fe04-4e3d-0c75-08dc5de2356d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
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

(no changes since v1)

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

