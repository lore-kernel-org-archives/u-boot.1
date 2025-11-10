Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA872CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 09:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D393839F1;
	Mon, 10 Nov 2025 10:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fwIFAKmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BBC0839DD; Mon, 10 Nov 2025 10:42:03 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F29383968
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 10:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vE7sH7AhwoZdpLWmld8pLCF1yBPSw67e0cvAFj/BPUSl+ENTrG3XCfVVcC7a7GhIwATFWYbAsUF6i7k9bejvywTuuFBApBI2nj8st5BumyMczKgc/c0sTH1vmsN6zNYZ+Je6BVo9KZ9OILYOiXbhhGSkY7Ta0H+QIId+u0tGrNVntpZESXyzsX/ub2PheHpJuj3nbp2fLvkTdmOJzJ3RaboeWH7rjna9bBU2PhM9j7WS9ODQB7Ns1+88KYGAwhEkP7CzqLi1TLx5rNbub1xFhJFOpB5cH9kEoe6c1PiSTgL3L3wCMV1izD+7Dc11u/a1Er6jgqBIAwokUL2tpi7fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ5ynMkOEAQuY36YrCj2oG0XaHcUqQAwB0wvXsYx9Yw=;
 b=IDD8BL9b5UgjVv/+dJmb8CPEBZJmgOsBx8wxH8deAaOmYSBroKw7MoYe/A1YMZ6c96nlTXuLGCpaRFEOXuwv8ki5TpR8nVu6ZoRxSUe4T8szENGJ8G7zyyZ2+8/nXKHO5127G4pgu2qslyI7fqN21sRvbRFAMUdGdbPxTdAfHCyXJyqxslkY594dtPw0ebAdKkcafH4udhG79+p36D+qaZi+BvuOztvE25m21bE4rNypykRByT9Fl+YZxh0vbSgfPEfqAcfYFNAPaWxm1KKKI/fAB/S8dNvZu8dj+roqoek0/td9JpJ6RUQoehbIcjnDlZVAPmtAlB8u9BnG5no7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ5ynMkOEAQuY36YrCj2oG0XaHcUqQAwB0wvXsYx9Yw=;
 b=fwIFAKmP7ETfLNZLWeSpUKZp96wVaT9+MKGjd8CgvTUISjHlh3eiM7OtgJg+9bX4mkQvUXIC7wGYRGFg2PDq9C9Ma4z1Voo+aLHGG4CkihOvUm8zzO3uZ5IKnkVbjctPQ/vs6urG42dmjxhZe8ATDfeSrP9G1I0sJ2uJJvpsaac=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:41:54 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::ec) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 09:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 09:41:54 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:54 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 03:41:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 03:41:53 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AA9fit13156252;
 Mon, 10 Nov 2025 03:41:49 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 1/5] arm: mach-k3: j784s4: Update SoC autogen data to enable
 PCIe boot
Date: Mon, 10 Nov 2025 15:11:40 +0530
Message-ID: <20251110094144.886956-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110094144.886956-1-h-salunke@ti.com>
References: <20251110094144.886956-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MN6PR10MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: b51c0415-8a67-4668-1738-08de203d623b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|921020|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h36uuEZQIWLtNwBdKalysQXgVgBdP3B3jnlwy5S0/tjT3kSFMQwxtVFNcwi/?=
 =?us-ascii?Q?jKmhDJeU9zzYHz7H6eV+Wb9us+yzJSJFd9Xbgkfi29LSc16ECMULZPB9kirX?=
 =?us-ascii?Q?pk1RY0XTcCkGiRe6y4HN6R7q98wXaMwJIz6WMobhzIW2jXP+oAQZl7q3fuW8?=
 =?us-ascii?Q?IT6D5/HByT1j601MhtZqLkBF7prm37etKp71gXJ6SkoG7RGUOIuGaiXqFrH3?=
 =?us-ascii?Q?1QILL+aF8TVM2IQJ3YGFnuLkbTGmU1zZRgqKGRplnfs20iJH/k9P8mkczsE1?=
 =?us-ascii?Q?H4G1M2DKxTYbXLGeK26NFagUGz7LWiy3W2KEznpKghQiaOhd58VqnuW5cvY4?=
 =?us-ascii?Q?wrM+QcsqZAlTw4wMJMilR0qPT2Y2ZBpp/rRqSHLVD2X7vmsPcm9Y2lU4ILjX?=
 =?us-ascii?Q?YPJecgkKZov+PkmlJP8cEy5DevTrNDoM0G/8p5Ey4E/HEc7WAQcPzRg/vw5G?=
 =?us-ascii?Q?lzy0VCToKu9h2gQIhkf2bt1zHgyQTpf1iicCuYVtFTetr9NsjdzUMkxTP2EG?=
 =?us-ascii?Q?vBxDE23am+csMIqQESxh5gwHQJ6zhH5RDrex/f8kjezJd44bUV23X0x+fxlI?=
 =?us-ascii?Q?iLa79Xi+CtlSGf8PAFu/oLwaQLEIY3ns+y0qdqqk/KUqXqXL5qtDnlQc4Uj5?=
 =?us-ascii?Q?V6+OQmhDYlT2J9/wzn7Z+PxQJvvxQp4jOJPsyFxnfnxbNw6zftRROQnpfmCC?=
 =?us-ascii?Q?bD7atLOrxPLLgYHfF6s3EIxHfD4ib1syCoB2X88StP2YMY4hTN0AaAF/Nilm?=
 =?us-ascii?Q?UkBCwNTzR859FGGyc4LxbD0MPGIi7fbIROB3glx9ZpTfgm9Sx3WiD/puPtdu?=
 =?us-ascii?Q?fBWC6h61r/thWEvCiTq+vKTIz2zCbml+ZZmhs38MyPCOPXzLR7GO9Ext24u7?=
 =?us-ascii?Q?nDSZNRSxW7BpllcZhIdVEF1uqgK6TxEXttpSoBfDe0817dLT1B1kuk/yVG09?=
 =?us-ascii?Q?JvDsXwax7VnEKlsX5t2qRmSi4x+fD93Q4i9r0JKzLI6vgWNc5hDmK672vxTG?=
 =?us-ascii?Q?3NifukBT/Mh7Y2+tgz6ve3QuBUBZZAc6XVAOrBC+etcHr85HvBM+F/y2X7bz?=
 =?us-ascii?Q?p/5Sb5vlNDyzx3a6+SEipKBMayjy6I/v7bZAaF0NuRCnNy/wuJRtM4P5ue1p?=
 =?us-ascii?Q?lWQR/NQloBkeTALFYMNtw4k82K7Dujb9ueD9nFfsR1KFJ8BPcsbNoUgudGHM?=
 =?us-ascii?Q?j/twSMX+fuGcDpJ1bL6ZnkOfHmFSBuod1dacXct3F8nKu1pg00/rwD9RY9cG?=
 =?us-ascii?Q?ed++iWmXaQkarucOwKAEn7bD+i0G386+iZ/ijhq0dhATxrE0TIaC86Ahr/C+?=
 =?us-ascii?Q?AAWUXJ5RAVJnTmDmWcB8PmO5S87AvmR/tXxy0qN0Bfo/YfVOW09kWfuFl5zt?=
 =?us-ascii?Q?yDi4IVmcLvyomFWKKq5EMD7aIE1lggrx5Vt9DaUgRPk0Zdkfc5rUjdtK3tdx?=
 =?us-ascii?Q?+3RwSPBmiaYEBSaMsodVdEwTGRqu6R0YLYsXgiHE+M3sJTuGJks8hhdYQbhe?=
 =?us-ascii?Q?B8SVAgw7Gee/fdB22gyDpcy79r7Ww0JvrMTB/UPi4oMlUxy4t3RnzEig1g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:41:54.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51c0415-8a67-4668-1738-08de203d623b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
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

To enable PCIe boot on J784S4 SoC SERDES0 and PCIE1 should be enabled
and configured at r5 stage. Add the required clk-data and dev-data
for SERDES0 and PCIE1.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm/mach-k3/r5/j784s4/clk-data.c | 211 ++++++++++++++++++++++++--
 arch/arm/mach-k3/r5/j784s4/dev-data.c |  45 +++---
 2 files changed, 227 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
index 24780eb6562..7ea67ce38f5 100644
--- a/arch/arm/mach-k3/r5/j784s4/clk-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
@@ -1,11 +1,11 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * J784S4 specific clock platform data
  *
  * This file is auto generated. Please do not hand edit and report any issues
  * to Bryan Brattlof <bb@ti.com>.
  *
- * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2020-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/clk-provider.h>
@@ -64,18 +64,29 @@ static const char * const cpsw2g_cpts_rclk_sel_out0_parents[] = {
 	"board_0_cpts0_rft_clk_out",
 	"board_0_mcu_ext_refclk0_out",
 	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
 	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
 	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
 };
 
+static const char * const mcu_timer_clksel_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk",
+	"hsdiv4_16fft_mcu_2_hsdivout2_clk",
+	"board_0_mcu_ext_refclk0_out",
+	"gluelogic_lpxosc_clkout",
+	"cpsw_2guss_mcu_0_cpts_genf0",
+	"j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk",
+};
+
 static const char * const mcu_usart_clksel_out0_parents[] = {
 	"hsdiv4_16fft_mcu_1_hsdivout3_clk",
 	"postdiv3_16fft_main_1_hsdivout5_clk",
@@ -166,6 +177,31 @@ static const char * const emmcsd1_lb_clksel_out0_parents[] = {
 	"board_0_mmc1_clk_out",
 };
 
+static const char * const usb0_serdes_refclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_refclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_rxclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_rxclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_rxfclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_rxfclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_txfclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_txfclk",
+	NULL,
+};
+
+static const char * const usb0_serdes_txmclk_mux_out0_parents[] = {
+	"wiz16b8m4ct3_main_0_ip3_ln3_txmclk",
+	NULL,
+};
+
 static const char * const k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents[] = {
 	"main_pll_hfosc_sel_out0",
 	"hsdiv4_16fft_main_0_hsdivout0_clk",
@@ -197,18 +233,44 @@ static const char * const gtc_clk_mux_out0_parents[] = {
 	"board_0_cpts0_rft_clk_out",
 	"board_0_mcu_ext_refclk0_out",
 	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
+	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
+	"k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
+};
+
+static const char * const pcien_cpts_rclk_mux_out1_parents[] = {
+	"hsdiv4_16fft_main_3_hsdivout1_clk",
+	"postdiv3_16fft_main_0_hsdivout6_clk",
+	"board_0_mcu_cpts0_rft_clk_out",
+	"board_0_cpts0_rft_clk_out",
+	"board_0_mcu_ext_refclk0_out",
+	"board_0_ext_refclk1_out",
+	"wiz16b8m4ct3_main_0_ip2_ln0_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln1_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln2_txmclk",
+	"wiz16b8m4ct3_main_0_ip2_ln3_txmclk",
 	NULL,
 	NULL,
-	NULL,
-	NULL,
+	"wiz16b8m4ct3_main_0_ip1_ln2_txmclk",
 	NULL,
 	"hsdiv4_16fft_mcu_2_hsdivout1_clk",
 	"k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk",
 };
 
+static const char * const serdes0_core_refclk_out0_parents[] = {
+	"gluelogic_hfosc0_clkout",
+	"board_0_hfosc1_clk_out",
+	"hsdiv4_16fft_main_3_hsdivout4_clk",
+	"hsdiv4_16fft_main_2_hsdivout4_clk",
+};
+
 static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_27_mhz", 27000000, 0),
 	CLK_FIXED_RATE("osc_26_mhz", 26000000, 0),
@@ -217,12 +279,14 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("osc_20_mhz", 20000000, 0),
 	CLK_FIXED_RATE("osc_19_2_mhz", 19200000, 0),
 	CLK_MUX("gluelogic_hfosc0_clkout", gluelogic_hfosc0_clkout_parents, 6, 0x43000030, 0, 3, 0),
+	CLK_FIXED_RATE("gluelogic_lpxosc_clkout", 32768, 0),
 	CLK_FIXED_RATE("board_0_hfosc1_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_ospi0_dqs_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_ospi1_dqs_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_rgmii1_rxc_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mcu_rmii1_ref_clk_out", 0, 0),
 	CLK_FIXED_RATE("board_0_wkup_i2c0_scl_out", 0, 0),
+	CLK_FIXED_RATE("cpsw_2guss_mcu_0_cpts_genf0", 0, 0),
 	CLK_FIXED_RATE("cpsw_2guss_mcu_0_mdio_mdclk_o", 0, 0),
 	CLK_FIXED_RATE("cpsw_2guss_mcu_0_rgmii1_txc_o", 0, 0),
 	CLK_FIXED_RATE("fss_mcu_0_hyperbus1p0_0_hpb_out_clk_n", 0, 0),
@@ -241,6 +305,7 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("hsdiv1_16fft_mcu_0_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_0_foutvcop_clk", 0x40d00080, 0, 7, 0, 0),
 	CLK_DIV_DEFFREQ("hsdiv4_16fft_mcu_1_hsdivout3_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d0108c, 0, 7, 0, 0, 96000000),
 	CLK_DIV("hsdiv4_16fft_mcu_1_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_1_foutvcop_clk", 0x40d01090, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02088, 0, 7, 0, 0),
 	CLK_DIV_DEFFREQ("hsdiv4_16fft_mcu_2_hsdivout4_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02090, 0, 7, 0, 0, 166666666),
 	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", k3_pll_ctrl_wrap_wkup_0_sysclkout_clk_parents, 2, 0x42010000, 0),
 	CLK_DIV("k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_wkup_0_sysclkout_clk", 0x42010118, 0, 5, 0, 0),
@@ -248,6 +313,7 @@ static const struct clk_data clk_list[] = {
 	CLK_MUX("mcu_ospi_ref_clk_sel_out1", mcu_ospi_ref_clk_sel_out1_parents, 2, 0x40f08034, 0, 1, 0),
 	CLK_MUX("wkup_gpio0_clksel_out0", wkup_gpio0_clksel_out0_parents, 4, 0x43008070, 0, 2, 0),
 	CLK_MUX("cpsw2g_cpts_rclk_sel_out0", cpsw2g_cpts_rclk_sel_out0_parents, 16, 0x40f08050, 8, 4, 0),
+	CLK_MUX("mcu_timer_clksel_out0", mcu_timer_clksel_out0_parents, 8, 0x40f08100, 0, 3, 0),
 	CLK_MUX("mcu_usart_clksel_out0", mcu_usart_clksel_out0_parents, 2, 0x40f081c0, 0, 1, 0),
 	CLK_MUX("wkup_i2c_mcupll_bypass_out0", wkup_i2c_mcupll_bypass_out0_parents, 2, 0x43008060, 0, 1, 0),
 	CLK_MUX("wkup_usart_clksel_out0", wkup_usart_clksel_out0_parents, 2, 0x43008064, 0, 1, 0),
@@ -270,11 +336,17 @@ static const struct clk_data clk_list[] = {
 	CLK_FIXED_RATE("board_0_mcu_ext_refclk0_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mmc1_clklb_out", 0, 0),
 	CLK_FIXED_RATE("board_0_mmc1_clk_out", 0, 0),
+	CLK_FIXED_RATE("board_0_serdes0_refclk_n_out", 0, 0),
+	CLK_FIXED_RATE("board_0_serdes0_refclk_p_out", 0, 0),
 	CLK_FIXED_RATE("board_0_tck_out", 0, 0),
 	CLK_FIXED_RATE("board_0_vout0_extpclkin_out", 0, 0),
 	CLK_FIXED_RATE("emmcsd4ss_main_0_emmcsdss_io_clk_o", 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout0_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_mcu_2_hsdivout1_clk", "pllfracf2_ssmod_16fft_mcu_2_foutvcop_clk", 0x40d02084, 0, 7, 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane0_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane1_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane2_txclk", 0, 0),
+	CLK_FIXED_RATE("pcie_g3x4_128_main_1_pcie_lane3_txclk", 0, 0),
 	CLK_PLL_DEFFREQ("pllfracf2_ssmod_16fft_main_0_foutvcop_clk", "main_pll_hfosc_sel_out0", 0x680000, 0, 2000000000),
 	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", "pllfracf2_ssmod_16fft_main_0_foutvcop_clk", 0x680038, 16, 3, 0, CLK_DIVIDER_ONE_BASED),
 	CLK_DIV("pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk_subdiv", 0x680038, 24, 3, 0, CLK_DIVIDER_ONE_BASED),
@@ -294,8 +366,42 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV("postdiv3_16fft_main_0_hsdivout8_clk", "pllfracf2_ssmod_16fft_main_0_foutpostdiv_clk", 0x6800a0, 0, 7, 0, 0),
 	CLK_DIV("postdiv3_16fft_main_1_hsdivout5_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x681094, 0, 7, 0, 0),
 	CLK_DIV("postdiv3_16fft_main_1_hsdivout7_clk", "pllfracf2_ssmod_16fft_main_1_foutpostdiv_clk", 0x68109c, 0, 7, 0, 0),
+	CLK_FIXED_RATE("usb3p0ss_16ffc_main_0_pipe_txclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_cmn_refclk_m", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_cmn_refclk_p", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip1_ln2_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln0_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln1_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln2_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip2_ln3_txmclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_refclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_rxclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_rxfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_txfclk", 0, 0),
+	CLK_FIXED_RATE("wiz16b8m4ct3_main_0_ip3_ln3_txmclk", 0, 0),
 	CLK_MUX("emmcsd1_lb_clksel_out0", emmcsd1_lb_clksel_out0_parents, 2, 0x1080b4, 16, 1, 0),
 	CLK_MUX("mcu_clkout_mux_out0", mcu_clkout_mux_out0_parents, 2, 0x40f08010, 0, 1, 0),
+	CLK_MUX("usb0_serdes_refclk_mux_out0", usb0_serdes_refclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_rxclk_mux_out0", usb0_serdes_rxclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_rxfclk_mux_out0", usb0_serdes_rxfclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_txfclk_mux_out0", usb0_serdes_txfclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
+	CLK_MUX("usb0_serdes_txmclk_mux_out0", usb0_serdes_txmclk_mux_out0_parents, 2, 0x104000, 27, 1, 0),
 	CLK_DIV("hsdiv0_16fft_main_12_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_12_foutvcop_clk", 0x68c080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv0_16fft_main_26_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_26_foutvcop_clk", 0x69a080, 0, 7, 0, 0),
 	CLK_DIV("hsdiv0_16fft_main_27_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_27_foutvcop_clk", 0x69b080, 0, 7, 0, 0),
@@ -310,14 +416,18 @@ static const struct clk_data clk_list[] = {
 	CLK_DIV_DEFFREQ("hsdiv4_16fft_main_1_hsdivout0_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681080, 0, 7, 0, 0, 192000000),
 	CLK_DIV("hsdiv4_16fft_main_1_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_1_foutvcop_clk", 0x681088, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_2_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_2_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_2_foutvcop_clk", 0x682090, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_3_hsdivout1_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683084, 0, 7, 0, 0),
 	CLK_DIV("hsdiv4_16fft_main_3_hsdivout2_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683088, 0, 7, 0, 0),
+	CLK_DIV("hsdiv4_16fft_main_3_hsdivout4_clk", "pllfracf2_ssmod_16fft_main_3_foutvcop_clk", 0x683090, 0, 7, 0, 0),
 	CLK_MUX_PLLCTRL("k3_pll_ctrl_wrap_main_0_sysclkout_clk", k3_pll_ctrl_wrap_main_0_sysclkout_clk_parents, 2, 0x410000, 0),
 	CLK_DIV("k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk", "k3_pll_ctrl_wrap_main_0_sysclkout_clk", 0x410118, 0, 5, 0, 0),
 	CLK_MUX("dpi0_ext_clksel_out0", dpi0_ext_clksel_out0_parents, 2, 0x108300, 0, 1, 0),
 	CLK_MUX("emmcsd_refclk_sel_out0", emmcsd_refclk_sel_out0_parents, 4, 0x1080b0, 0, 2, 0),
 	CLK_MUX("emmcsd_refclk_sel_out1", emmcsd_refclk_sel_out1_parents, 4, 0x1080b4, 0, 2, 0),
 	CLK_MUX("gtc_clk_mux_out0", gtc_clk_mux_out0_parents, 16, 0x108030, 0, 4, 0),
+	CLK_MUX("pcien_cpts_rclk_mux_out1", pcien_cpts_rclk_mux_out1_parents, 16, 0x108084, 0, 4, 0),
+	CLK_MUX("serdes0_core_refclk_out0", serdes0_core_refclk_out0_parents, 4, 0x108400, 0, 2, 0),
 	CLK_DIV_DEFFREQ("usart_programmable_clock_divider_out0", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081c0, 0, 2, 0, 0, 48000000),
 	CLK_DIV("usart_programmable_clock_divider_out5", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081d4, 0, 2, 0, 0),
 	CLK_DIV("usart_programmable_clock_divider_out8", "hsdiv4_16fft_main_1_hsdivout0_clk", 0x1081e0, 0, 2, 0, 0),
@@ -331,6 +441,16 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(198, 4, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(202, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
 	DEV_CLK(203, 0, "hsdiv0_16fft_main_8_hsdivout0_clk"),
+	DEV_CLK(35, 0, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(35, 2, "mcu_timer_clksel_out0"),
+	DEV_CLK(35, 3, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(35, 4, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
+	DEV_CLK(35, 5, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
+	DEV_CLK(35, 6, "hsdiv4_16fft_mcu_2_hsdivout2_clk"),
+	DEV_CLK(35, 7, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(35, 8, "gluelogic_lpxosc_clkout"),
+	DEV_CLK(35, 9, "cpsw_2guss_mcu_0_cpts_genf0"),
+	DEV_CLK(35, 10, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_32k_clk"),
 	DEV_CLK(61, 0, "gtc_clk_mux_out0"),
 	DEV_CLK(61, 1, "hsdiv4_16fft_main_3_hsdivout1_clk"),
 	DEV_CLK(61, 2, "postdiv3_16fft_main_0_hsdivout6_clk"),
@@ -338,6 +458,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(61, 4, "board_0_cpts0_rft_clk_out"),
 	DEV_CLK(61, 5, "board_0_mcu_ext_refclk0_out"),
 	DEV_CLK(61, 6, "board_0_ext_refclk1_out"),
+	DEV_CLK(61, 7, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(61, 8, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(61, 9, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(61, 10, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(61, 13, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
 	DEV_CLK(61, 15, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(61, 16, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(61, 17, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
@@ -349,6 +474,11 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(63, 7, "board_0_cpts0_rft_clk_out"),
 	DEV_CLK(63, 8, "board_0_mcu_ext_refclk0_out"),
 	DEV_CLK(63, 9, "board_0_ext_refclk1_out"),
+	DEV_CLK(63, 10, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(63, 11, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(63, 12, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(63, 13, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(63, 16, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
 	DEV_CLK(63, 18, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
 	DEV_CLK(63, 19, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(63, 20, "hsdiv4_16fft_mcu_2_hsdivout0_clk"),
@@ -404,6 +534,8 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(157, 239, "k3_pll_ctrl_wrap_wkup_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 243, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
 	DEV_CLK(157, 245, "emmcsd4ss_main_0_emmcsdss_io_clk_o"),
+	DEV_CLK(157, 324, "wiz16b8m4ct3_main_0_cmn_refclk_m"),
+	DEV_CLK(157, 326, "wiz16b8m4ct3_main_0_cmn_refclk_p"),
 	DEV_CLK(157, 354, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(157, 359, "dpi0_ext_clksel_out0"),
 	DEV_CLK(157, 360, "mshsi2c_wkup_0_porscl"),
@@ -461,6 +593,42 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(279, 2, "wkup_i2c_mcupll_bypass_out0"),
 	DEV_CLK(279, 3, "hsdiv4_16fft_mcu_1_hsdivout3_clk"),
 	DEV_CLK(279, 4, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(333, 0, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(333, 2, "pcien_cpts_rclk_mux_out1"),
+	DEV_CLK(333, 3, "hsdiv4_16fft_main_3_hsdivout1_clk"),
+	DEV_CLK(333, 4, "postdiv3_16fft_main_0_hsdivout6_clk"),
+	DEV_CLK(333, 5, "board_0_mcu_cpts0_rft_clk_out"),
+	DEV_CLK(333, 6, "board_0_cpts0_rft_clk_out"),
+	DEV_CLK(333, 7, "board_0_mcu_ext_refclk0_out"),
+	DEV_CLK(333, 8, "board_0_ext_refclk1_out"),
+	DEV_CLK(333, 9, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(333, 10, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(333, 11, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(333, 12, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(333, 15, "wiz16b8m4ct3_main_0_ip1_ln2_txmclk"),
+	DEV_CLK(333, 17, "hsdiv4_16fft_mcu_2_hsdivout1_clk"),
+	DEV_CLK(333, 18, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(333, 19, "wiz16b8m4ct3_main_0_ip2_ln0_refclk"),
+	DEV_CLK(333, 20, "wiz16b8m4ct3_main_0_ip2_ln0_rxclk"),
+	DEV_CLK(333, 21, "wiz16b8m4ct3_main_0_ip2_ln0_rxfclk"),
+	DEV_CLK(333, 23, "wiz16b8m4ct3_main_0_ip2_ln0_txfclk"),
+	DEV_CLK(333, 24, "wiz16b8m4ct3_main_0_ip2_ln0_txmclk"),
+	DEV_CLK(333, 25, "wiz16b8m4ct3_main_0_ip2_ln1_refclk"),
+	DEV_CLK(333, 26, "wiz16b8m4ct3_main_0_ip2_ln1_rxclk"),
+	DEV_CLK(333, 27, "wiz16b8m4ct3_main_0_ip2_ln1_rxfclk"),
+	DEV_CLK(333, 29, "wiz16b8m4ct3_main_0_ip2_ln1_txfclk"),
+	DEV_CLK(333, 30, "wiz16b8m4ct3_main_0_ip2_ln1_txmclk"),
+	DEV_CLK(333, 31, "wiz16b8m4ct3_main_0_ip2_ln2_refclk"),
+	DEV_CLK(333, 32, "wiz16b8m4ct3_main_0_ip2_ln2_rxclk"),
+	DEV_CLK(333, 33, "wiz16b8m4ct3_main_0_ip2_ln2_rxfclk"),
+	DEV_CLK(333, 35, "wiz16b8m4ct3_main_0_ip2_ln2_txfclk"),
+	DEV_CLK(333, 36, "wiz16b8m4ct3_main_0_ip2_ln2_txmclk"),
+	DEV_CLK(333, 37, "wiz16b8m4ct3_main_0_ip2_ln3_refclk"),
+	DEV_CLK(333, 38, "wiz16b8m4ct3_main_0_ip2_ln3_rxclk"),
+	DEV_CLK(333, 39, "wiz16b8m4ct3_main_0_ip2_ln3_rxfclk"),
+	DEV_CLK(333, 41, "wiz16b8m4ct3_main_0_ip2_ln3_txfclk"),
+	DEV_CLK(333, 42, "wiz16b8m4ct3_main_0_ip2_ln3_txmclk"),
+	DEV_CLK(333, 43, "j7am_wakeup_16ff_wkup_0_wkup_rcosc_12p5m_clk"),
 	DEV_CLK(392, 0, "usart_programmable_clock_divider_out5"),
 	DEV_CLK(392, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(395, 0, "usart_programmable_clock_divider_out8"),
@@ -473,11 +641,36 @@ static const struct dev_clk soc_dev_clk_data[] = {
 	DEV_CLK(398, 1, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 2, "postdiv3_16fft_main_1_hsdivout7_clk"),
 	DEV_CLK(398, 3, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(398, 4, "usb0_serdes_refclk_mux_out0"),
+	DEV_CLK(398, 5, "wiz16b8m4ct3_main_0_ip3_ln3_refclk"),
+	DEV_CLK(398, 7, "usb0_serdes_rxclk_mux_out0"),
+	DEV_CLK(398, 8, "wiz16b8m4ct3_main_0_ip3_ln3_rxclk"),
+	DEV_CLK(398, 10, "usb0_serdes_rxfclk_mux_out0"),
+	DEV_CLK(398, 11, "wiz16b8m4ct3_main_0_ip3_ln3_rxfclk"),
+	DEV_CLK(398, 14, "usb0_serdes_txfclk_mux_out0"),
+	DEV_CLK(398, 15, "wiz16b8m4ct3_main_0_ip3_ln3_txfclk"),
+	DEV_CLK(398, 17, "usb0_serdes_txmclk_mux_out0"),
+	DEV_CLK(398, 18, "wiz16b8m4ct3_main_0_ip3_ln3_txmclk"),
 	DEV_CLK(398, 20, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
 	DEV_CLK(398, 21, "usb0_refclk_sel_out0"),
 	DEV_CLK(398, 22, "gluelogic_hfosc0_clkout"),
 	DEV_CLK(398, 23, "board_0_hfosc1_clk_out"),
 	DEV_CLK(398, 28, "board_0_tck_out"),
+	DEV_CLK(404, 2, "k3_pll_ctrl_wrap_main_0_chip_div1_clk_clk"),
+	DEV_CLK(404, 3, "board_0_serdes0_refclk_n_out"),
+	DEV_CLK(404, 4, "board_0_serdes0_refclk_p_out"),
+	DEV_CLK(404, 5, "hsdiv4_16fft_main_3_hsdivout4_clk"),
+	DEV_CLK(404, 6, "serdes0_core_refclk_out0"),
+	DEV_CLK(404, 7, "gluelogic_hfosc0_clkout"),
+	DEV_CLK(404, 8, "board_0_hfosc1_clk_out"),
+	DEV_CLK(404, 9, "hsdiv4_16fft_main_3_hsdivout4_clk"),
+	DEV_CLK(404, 10, "hsdiv4_16fft_main_2_hsdivout4_clk"),
+	DEV_CLK(404, 39, "pcie_g3x4_128_main_1_pcie_lane0_txclk"),
+	DEV_CLK(404, 45, "pcie_g3x4_128_main_1_pcie_lane1_txclk"),
+	DEV_CLK(404, 51, "pcie_g3x4_128_main_1_pcie_lane2_txclk"),
+	DEV_CLK(404, 57, "pcie_g3x4_128_main_1_pcie_lane3_txclk"),
+	DEV_CLK(404, 81, "usb3p0ss_16ffc_main_0_pipe_txclk"),
+	DEV_CLK(404, 129, "board_0_tck_out"),
 };
 
 const struct ti_k3_clk_platdata j784s4_clk_platdata = {
diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
index 19901821225..e141a8b8047 100644
--- a/arch/arm/mach-k3/r5/j784s4/dev-data.c
+++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * J784S4 specific device platform data
  *
@@ -21,10 +21,11 @@ static struct ti_pd soc_pd_list[] = {
 	[1] = PSC_PD(3, &soc_psc_list[1], NULL),
 	[2] = PSC_PD(0, &soc_psc_list[2], NULL),
 	[3] = PSC_PD(1, &soc_psc_list[2], &soc_pd_list[2]),
-	[4] = PSC_PD(14, &soc_psc_list[2], NULL),
-	[5] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[4]),
-	[6] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[4]),
-	[7] = PSC_PD(38, &soc_psc_list[2], NULL),
+	[4] = PSC_PD(5, &soc_psc_list[2], NULL),
+	[5] = PSC_PD(14, &soc_psc_list[2], NULL),
+	[6] = PSC_PD(15, &soc_psc_list[2], &soc_pd_list[5]),
+	[7] = PSC_PD(16, &soc_psc_list[2], &soc_pd_list[5]),
+	[8] = PSC_PD(38, &soc_psc_list[2], NULL),
 };
 
 static struct ti_lpsc soc_lpsc_list[] = {
@@ -44,13 +45,15 @@ static struct ti_lpsc soc_lpsc_list[] = {
 	[13] = PSC_LPSC(20, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[14] = PSC_LPSC(23, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
 	[15] = PSC_LPSC(25, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
-	[16] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[17] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
-	[18] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[4], NULL),
-	[19] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[5], &soc_lpsc_list[18]),
-	[20] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[18]),
-	[21] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[22]),
-	[22] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[7], NULL),
+	[16] = PSC_LPSC(29, &soc_psc_list[2], &soc_pd_list[2], &soc_lpsc_list[5]),
+	[17] = PSC_LPSC(43, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[18] = PSC_LPSC(45, &soc_psc_list[2], &soc_pd_list[3], NULL),
+	[19] = PSC_LPSC(64, &soc_psc_list[2], &soc_pd_list[4], NULL),
+	[20] = PSC_LPSC(78, &soc_psc_list[2], &soc_pd_list[5], NULL),
+	[21] = PSC_LPSC(80, &soc_psc_list[2], &soc_pd_list[6], &soc_lpsc_list[20]),
+	[22] = PSC_LPSC(81, &soc_psc_list[2], &soc_pd_list[7], &soc_lpsc_list[20]),
+	[23] = PSC_LPSC(120, &soc_psc_list[2], &soc_pd_list[8], &soc_lpsc_list[24]),
+	[24] = PSC_LPSC(121, &soc_psc_list[2], &soc_pd_list[8], NULL),
 };
 
 static struct ti_dev soc_dev_list[] = {
@@ -78,14 +81,16 @@ static struct ti_dev soc_dev_list[] = {
 	PSC_DEV(398, &soc_lpsc_list[13]),
 	PSC_DEV(141, &soc_lpsc_list[14]),
 	PSC_DEV(140, &soc_lpsc_list[15]),
-	PSC_DEV(146, &soc_lpsc_list[16]),
-	PSC_DEV(392, &soc_lpsc_list[17]),
-	PSC_DEV(395, &soc_lpsc_list[17]),
-	PSC_DEV(198, &soc_lpsc_list[18]),
-	PSC_DEV(202, &soc_lpsc_list[19]),
-	PSC_DEV(203, &soc_lpsc_list[20]),
-	PSC_DEV(133, &soc_lpsc_list[21]),
-	PSC_DEV(193, &soc_lpsc_list[22]),
+	PSC_DEV(333, &soc_lpsc_list[16]),
+	PSC_DEV(146, &soc_lpsc_list[17]),
+	PSC_DEV(392, &soc_lpsc_list[18]),
+	PSC_DEV(395, &soc_lpsc_list[18]),
+	PSC_DEV(404, &soc_lpsc_list[19]),
+	PSC_DEV(198, &soc_lpsc_list[20]),
+	PSC_DEV(202, &soc_lpsc_list[21]),
+	PSC_DEV(203, &soc_lpsc_list[22]),
+	PSC_DEV(133, &soc_lpsc_list[23]),
+	PSC_DEV(193, &soc_lpsc_list[24]),
 };
 
 const struct ti_k3_pd_platdata j784s4_pd_platdata = {
-- 
2.34.1

