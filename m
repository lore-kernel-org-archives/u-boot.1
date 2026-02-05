Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544B4EC1EB3
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 13:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41C583A64;
	Thu,  5 Feb 2026 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QVIXZzZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF038382A; Thu,  5 Feb 2026 13:16:00 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678EE83015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 13:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FE+mz5/UCbH64s+04vArZiZ26g1txAUSO/LCbWJWXbB43Djg8akmMK4QqNXXGlSH4PMrANWC5gny0Rij2/XAeAdY618+IhCbF5it9IWBuBdATgMEltQLLOIFyIrX5NNvFEe/eProfls1JurzBVMavMiTdcynoodXTMWIQTlksP8VX3hIekrOio0LY3RQfRKnOeutPfmV8vjmW5lN9UyS5hk6xwpKedLlcJyd+vGHIoGv2fS/w6VYDI7/KBhxATooAKEoB9CMyuWzoFDzEivODNmHHZoKa0Shyp8R34Y4wNto+b8x9SBEK7IigyPiH/jAUmHEjJan2GRm5D9bXCu3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4io6iBJW0VmorEjUxSV8OJrzpgQ5XgTyMcq5RHTNkQ=;
 b=AJ9e4opoWyMyPiGFIe0BMXzwMNgxxIAqdiSmYlPk0iJqJjGlZ7V2GcQUNJt0jbhIkTkZSdb3jeyk5clN582EEn1MOBL82g+r+2gTJgLL7zW/lc2drrdCCk7cMym7umI3kasV12v7drnReMrMJV02ttpIRybeny9aet9AOf4xXoxvMJCsa+N6XTZHkg4aTayztrv+is3czdrgINoHnhIIztRxzQw4iI6DxjKTWjkrS0zyqHz+nOYhLqhvpO9V10DuS+rMt4c9+VT3vcQg1UurwclqXWloMUSLnwWv/3D6jg7ezHeTyQWZAXQpf9Zopl1kL4evXgPSg34rNMcFJjx2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4io6iBJW0VmorEjUxSV8OJrzpgQ5XgTyMcq5RHTNkQ=;
 b=QVIXZzZ3DRqkaRyzxJQS0/q4aHtZSzci+uV2AODS9T5CQckC44O3Cv6ZXg+jUIzGfVZWACQNVIDbjwLucYA2XGeVO/XluSdvzJNabnw5Qkrqa3UlSQ/Ipyf/+ehGQu4s/CrYka+CMDbX0BGQ+OonYO08qCewzjv4z41dAdMvCcs=
Received: from SJ0PR03CA0040.namprd03.prod.outlook.com (2603:10b6:a03:33e::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Thu, 5 Feb
 2026 12:15:55 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::8d) by SJ0PR03CA0040.outlook.office365.com
 (2603:10b6:a03:33e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 12:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 12:15:55 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:15:54 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:15:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:15:54 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615CFrdS2965766;
 Thu, 5 Feb 2026 06:15:53 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Udit Kumar <u-kumar1@ti.com>, Chintan Vankar <c-vankar@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <bb@ti.com>, <s-vadapalli@ti.com>, <p-mantena@ti.com>, <a-kumar2@ti.com>, 
 <richard.genoud@bootlin.com>, <u-boot@lists.denx.de>
Subject: [PATCH] arm: mach-k3: j722s: Update SoC data to add wake-up I2C device
Date: Thu, 5 Feb 2026 17:45:51 +0530
Message-ID: <20260205121551.3619582-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e7ffda-8a09-4707-de7e-08de64b0500f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KGQE+bAf40xMEf12diida2M4Ofdogi2lTi6RxrvryRWHibcmsAvOoiSpI1L6?=
 =?us-ascii?Q?3QkVDzOtU7Y28Crkdh82Hc+sVUrIgpiF9T3pJqewatAk0ieUCjBKvWvLOAIV?=
 =?us-ascii?Q?vSBMCi/q0MeACZ7hXBZY536BRV/pcGKTqESgGWWibeeIjRRd9ffvyocNjf+x?=
 =?us-ascii?Q?kznPaYelrX8UimgllhP0gwNx5H2AI4eG0XTxkiF0loe1GlNhfWYpeiV6YlJd?=
 =?us-ascii?Q?Fo3DAFYkSgX743xzOPdwg9BQ+d+bLJgr46eyKEK58Sx6ie6eqpGp9X6fskIo?=
 =?us-ascii?Q?5GC8OWBRN5B34ooFf96dyzSDGYrKE4KtsSPGF4aFMllsYFmYwBHF/voLPk6W?=
 =?us-ascii?Q?d+5GPF0waQqyQV/u3+h+XFRv/oMw/5jHdM71dWgVNcy2OztGv5zfjJ8zYI4h?=
 =?us-ascii?Q?6mtJLQlyML5RJvS3qmw1o5zZ9ewXVVJwT42ucUJCsJHM0DDJ6sNeLKVbHnJ8?=
 =?us-ascii?Q?zfSGzh/pE3WlFuB1waqh9Q+fYiSWIN+zIhU1dBmVCNc8wGDuSOc3oN8NxQ0g?=
 =?us-ascii?Q?/pdfVvex3hN/X3uJf+gR/6pCuyEHpoULtlQb7v1l5M0ZKyvVR4w74eWVmkLl?=
 =?us-ascii?Q?lAzN7S00D7AVao82jGG7/74v28rmFas11xlkI7pJuw1mGJ6KBDoG5c5EbqUF?=
 =?us-ascii?Q?33bYrGQTivvudAbBF03NlzywEdVxfXAuyCE/zLRR+LB1+ACW8NpKcQAFrHJo?=
 =?us-ascii?Q?Pryp4SMpPAi4IZ5x1kATzeippKogL3rn4gXT2duMm0bxBnwXoxT/CzEa/jxV?=
 =?us-ascii?Q?78GMV2BY32kjbG6AgO9FKzCkbLwpYZrrF57n8kck1X2pWN3UyqnhchbpGGws?=
 =?us-ascii?Q?kgQfCDW9c4GAFLqNWVSz2FI0W/ZShoT3U+I9k30Tp0Mwqi24DMzt51TWVTbu?=
 =?us-ascii?Q?F/ings3KbSka/2UyN/z+HUuxolY5UET2avAg0exV5PadMfPUkxlqb0deOX1P?=
 =?us-ascii?Q?MxEzg4l9+lZhLKoO2kppCSjF9XzNmYPDN7Qvm68RM/1cIeU2LZMtolo56prc?=
 =?us-ascii?Q?fOpMEYVDDQ4fcv+8ETbfyJy5ORX8PMV8vLYneTi2TY2WL7SQOUawp8NT7G5b?=
 =?us-ascii?Q?y5wZ5iDPqxLodO2CD3tI7IVkqCLsfbls0oTSgW40cu4gazqED1Esn8j+b+EV?=
 =?us-ascii?Q?hRrX2PcVz/g/NSP83P40iVju0NqNh9vezZ6KBpfLtiayY5A4wSK/EBA9JfOk?=
 =?us-ascii?Q?2UIPHU9MEVuaSU38vnTstw/WY5j0GOzkhNnH78fmtrGHunGygQwOgvUW4lTq?=
 =?us-ascii?Q?+M16Jv3sULq+inVMzCE+J4/p8z8HUcTEqsLmh0G8AVIf4zsiPP444PiNO7oR?=
 =?us-ascii?Q?yHhMcMwVnZcJo6LW42mYEEIiaL18V6eKqDTQeATfLDNeiRGAaA6JvSV2rWOM?=
 =?us-ascii?Q?abglAvyte7KaFtPPZvSzhwdATDEyTUKZuEY8Ta+RvMa3eeiTDV6cExOymIkk?=
 =?us-ascii?Q?e17JVqVAPKcfbTAi3hZfn7hsYou43ZEOUNQeir0AhjbbDCjzu1yfME9Hhnbs?=
 =?us-ascii?Q?b+8iqYfC3lmjMVAdHHjBJHe4yg0QbzEukBFkwMqsdAM189nQqjeeOlb6vv8u?=
 =?us-ascii?Q?7zrZmebYMLmhj2BFdqUoOvsjIEti0Wk7gqWFEkirewhqkkSUAvWd8aQhXCZR?=
 =?us-ascii?Q?FQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jHivbK/Dl8tjeP7+Ib4n8iFUC34IcObL1+wTSBTaKUQZNwi31wIsV6QsnjXZBXmA+3NInsguklZbBomFkTrIfMt5iBz7E7fTZKsAeNyGQUr9TCgHlB9k5uCTLgfZxVUISnTpHYJVaX+h2iYamYU0iAAO+tCzqZwBDTzPLHDI+a4YFDPk0ClI2sYxFNHxKXTyKAeqOQLJNUsMlmjk5plyg81MG0RnajrSNG1Q5k+RyoCHSpwo4mgdAx4cTsG0ef2s4Dop3VFkzDcTMIWARtr2hmu05NFwBoUlcFDmb6sUhigYJ7kGM1CZ/X94wzYLsueF4pblxk97kVB4eRlAeuRkki3piQC+N4cel5AxRghwLjmBrEBqXFZuwJKgR4wKSKpCHaFXane4O2GHG6CK3OGoJzkLcl8GGY6inyjqliptIXB8cbbQcdBy756awo+Nw+Ff
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 12:15:55.2031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e7ffda-8a09-4707-de7e-08de64b0500f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:05:49 +0100
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

Update dev-data and clk-data to include wake-up I2C device for J722s.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is based on commit 'b5213bbfdcb1' of origin/master branch of
U-Boot.

 arch/arm/mach-k3/r5/j722s/clk-data.c | 10 +++++++++-
 arch/arm/mach-k3/r5/j722s/dev-data.c |  3 ++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j722s/clk-data.c b/arch/arm/mach-k3/r5/j722s/clk-data.c
index cb3d864c5a3..de8c43314c7 100644
--- a/arch/arm/mach-k3/r5/j722s/clk-data.c
+++ b/arch/arm/mach-k3/r5/j722s/clk-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -159,6 +159,7 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_rmii1_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_rmii2_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
+	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
 	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf0", 0, 0),
 	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_cpts_genf1", 0, 0),
 	CLK_FIXED_RATE("cpsw_3guss_am67_main_0_mdio_mdclk_o", 0, 0),
@@ -223,6 +224,8 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("wkup_clkout_sel_io_out0", wkup_clkout_sel_io_out0_parents, 2, 0x43008020, 24, 1, 0),
 	CLK_MUX("wkup_clksel_out0", wkup_clksel_out0_parents, 2, 0x43008010, 0, 1, 0),
 	CLK_MUX("main_usart0_fclk_sel_out0", main_usart0_fclk_sel_out0_parents, 2, 0x108280, 0, 1, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_0_hsdivout1_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x4040084, 0, 7, 0, 0),
+	CLK_FIXED_RATE("mshsi2c_wkup_0_porscl", 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_main_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_main_0_sysclkout_clk", 0x41011c, 0, 5, 0, 0),
 	CLK_DIV("sam62_pll_ctrl_wrap_mcu_0_chip_div24_clk_clk", "sam62_pll_ctrl_wrap_mcu_0_sysclkout_clk", 0x402011c, 0, 5, 0, 0),
 };
@@ -307,6 +310,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(102, 0, "sam62_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(102, 1, "board_0_i2c0_scl_out"),
 	DEV_CLK(102, 2, "hsdiv4_16fft_main_1_hsdivout0_clk"),
+	DEV_CLK(107, 0, "wkup_clksel_out0"),
+	DEV_CLK(107, 1, "hsdiv3_16fft_main_15_hsdivout0_clk"),
+	DEV_CLK(107, 2, "hsdiv4_16fft_mcu_0_hsdivout0_clk"),
+	DEV_CLK(107, 3, "board_0_wkup_i2c0_scl_out"),
+	DEV_CLK(107, 4, "hsdiv4_16fft_mcu_0_hsdivout1_clk"),
 	DEV_CLK(135, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
 	DEV_CLK(146, 0, "main_usart0_fclk_sel_out0"),
 	DEV_CLK(146, 1, "usart_programmable_clock_divider_out0"),
diff --git a/arch/arm/mach-k3/r5/j722s/dev-data.c b/arch/arm/mach-k3/r5/j722s/dev-data.c
index 5f7e2a44fed..0ffef09a1d5 100644
--- a/arch/arm/mach-k3/r5/j722s/dev-data.c
+++ b/arch/arm/mach-k3/r5/j722s/dev-data.c
@@ -5,7 +5,7 @@
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2026 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include "k3-dev.h"
@@ -42,6 +42,7 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(16, &soc_lpsc_list[0]),
 	PSC_DEV(77, &soc_lpsc_list[0]),
 	PSC_DEV(61, &soc_lpsc_list[0]),
+	PSC_DEV(107, &soc_lpsc_list[0]),
 	PSC_DEV(178, &soc_lpsc_list[1]),
 	PSC_DEV(179, &soc_lpsc_list[2]),
 	PSC_DEV(57, &soc_lpsc_list[3]),
-- 
2.34.1

