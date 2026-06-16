Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28D4CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8DD84962;
	Tue, 16 Jun 2026 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ZIkNEj2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6468F84704; Tue, 16 Jun 2026 14:52:05 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26D4E848D1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5leS/IucdRcFcypUk6DiCZ22oY6FFOBZ+lnCwTClhY3weHpnuBNZMjFjncTSoa+qTtSVLsDu5RD3sQBBSYwmZxs3+458kNwucO27cLNEbZlhy0DL/mtqCukWnMTYcpAu/OgYLotqFuBEQmk0Kc+nuk/RSzWn6Xp8IcfmdjFUgciSvU59o42Rrgt8Saxsgzfz5vkeFdUpchG7x9zqRXrfVgDIqpqBHbY002MVFAhQPxP6WETBvP9gt0oi+X+qLwgcTLD5vG1ZeHaenHw2/GV5/AVJToEKr7LbrR9XhNfNEPzUCzsWxVosrM9lTBQf1l/zBhHMOeoQo7rRUPKaJ6QCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd2Rq92bxbjEuaWit5hD3AA4cDj+sABoT3WQdePXjtY=;
 b=OPmLil1RRvCkLaujV8ZVfoHFswjsn358CavrHh7mtaLHdN6Tfjw67g1m7s6vkMa7gKmsVvp3ofr/rm6xnv8de96iwK2cu5aIxQeNlN7r5eryO/PlbijpvHbSvvPRkAbMzGSnQ2LvQ4EEJkvhvUK4VW1iLckBUNwOXxF/Um+0xyc08nEJetshUV5WbZfsGbjTjiVclgBlDWpZFakdJ4SsdiR4yBD21hZUjW0IlG3YrBhKP+qgKUu/HhHPDQ/L4RQFg8bo/ltBKkdomM/Lj9xKOMO7uNacXNjKC9P0jG/txP+mP/pg+5DWDa0hXB9kokNCS5mc7y1d5VzFdbiN3P1ETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd2Rq92bxbjEuaWit5hD3AA4cDj+sABoT3WQdePXjtY=;
 b=ZIkNEj2rHk4Ypv0SH1wFn63A+UdteCnYDXvOiKvO5/uTWbjW166rFkVIe7BXa7+KHUm3CrG4K2DLAD6GPOx6uT+V/YqT2eXDymjcKz9fM/E/Re4LhZ/Kh+3ht66sWnHc+WGdBfMZ1Zv1TMThAadMMUWNZhNDqCVq5t+7u8ElIdwwii4ofRGhjyr0KJJ8ulKcSCFyjOkuH1c4Gmgv210iNcWGPctuJWQeS6kwuKZgJS+Wuj9qCtBxp8mvT77IXAKhtHaGhNAC8DTqEfWP/ZyffozG25qOGa2GoH4tGwUvlkjBAVgETIdEZ+zLomsxLJF7awqkAx5J+SXgp9t027ks1Q==
Received: from SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29)
 by IA0PPF9600556B0.namprd22.prod.outlook.com
 (2603:10b6:20f:fc04::d3b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:58 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::c) by SJ0PR05CA0114.outlook.office365.com
 (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:57 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id EA6C31290D;
 Tue, 16 Jun 2026 15:51:52 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@nabladev.com>,
 "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: shofiqtest@gmail.com,
	lukma@denx.de,
	u-boot@lists.denx.de
Subject: [PATCH v3 4/8] imx6: clock: allow different clock sources for ldb
Date: Tue, 16 Jun 2026 15:51:37 +0300
Message-ID: <20260616125147.3710024-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|IA0PPF9600556B0:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1c0b0fe9-1cd8-4f50-20b5-08decba60ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|4143699003|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zntWmQzOvAQKvYQOUNdSen913thtMdcJQpTblv4G7m04HpyfxekoZkip8J+wNil2q+YXA3xWYLQaEeyYGASfYbc2jzkh3Bhujdn2cR2oPbTYa42SpDPEqeZ9wFlG2w3fBihIu4nyqufMb9rcT17kUNd2ybXLGtIepq/1xGP4n+zqmccJ6xjC9SA495qbaYOqPoQyfCEhOnptx0NsgjBDaAscKHOcTg3Z/siEHkHjY2h8KjD6fpAFKkR+ey/OuiCNlup1CO92BQsklQ42fyljvrQ7l8bq6Dr/A1UF+op/VJIygyGQI98D3mqIX+jSU8h1OhMsBmi4PU2nrdUgOsnzT4teTmfLCQyts0m+2XlOuFDAGdGuJOkdG/tpBJONd+eMB+RXpRr8651WJi4L8B9FpGk5JZ3mItBCShZGC5/nMx1eGxMSrZVyNvjjNmp3NPZ4Z9ciEz6mQwbEax2aDm+K9MUr3SnEvslTOLpwMbxrkCN891n+6OjIXEsgZ++49iMAEchN6R7Dok40zXmtfJuAIR6MEaCd6GfOKxK5ME5so04KSgtP6dNW/M4pXag/xJDDbQP+GIQTk0ahSqafHhPA+ZrpwZa+1I0WzB2iDO3WifQximjyPjT6hhu+J9FQjnmjutx+35J1d+yDwlTv2Y4N5m9JtHIzAutlx2C3o4gdHOuY2DSbUg7n7gFBotKUiBGjLJ5am5g6IzadE8Ojjtl83xpE05eThwLWNPrCsanAQnM=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(4143699003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M9STjA1ds3HVpKpg7dsSelurgmL+1iqEpdf5U250y1Bb0g3nkUCoPIRBV1df1QbOV0V8H4gmj8uiBs+D1hjUn5fYr82bDQsERk5MwSL04aCiRuZgXElEYPKFVixsG4MIl+xG//g3+Eow4goyE9vA9vAewgiYomRf+Fgz2FHMQRGETy0cSXFbncku09nEkUMeFFCFNDVQiVcHhPJWuszsGuE8gCgEOOMcBiqv7RN3W3AM3ITHzEgFoKk6W0Fa0rDV12S0AwK3GSTAEeuluh28atiuEl2ryHbWaICaxcNTeXD3ooBFwUv+FkFE+/B5Zn/g1OwQgrG/5cN59igcn2rm/DX/DCC5fXaAdxLX/qt6zB0iK8WGWn7fvpVFRBDWAb8Fq6BSmufL45AlFtBCNYwBiRZdsbwE1Jcnm2VAF60jsPTNI6fUT15X/AazAQQzBoKR
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:57.1973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0b0fe9-1cd8-4f50-20b5-08decba60ce3
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9600556B0
X-Mailman-Approved-At: Tue, 16 Jun 2026 20:53:56 +0200
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

The LDB clock sources don't have to be the same, so allow DI1 clock to
be configured separately.

Unlikely to be significant, but the reason will become apparent in the
following commit.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v3:
 - Fix confusing mapping of clock parameters to display interfaces, i.e.,
   clk0 -> DI1, clk1 -> DI0.
---
 arch/arm/include/asm/arch-mx6/clock.h | 2 +-
 arch/arm/mach-imx/mx6/clock.c         | 6 +++---
 board/aristainetos/aristainetos.c     | 2 +-
 board/ge/b1x5v2/b1x5v2.c              | 2 +-
 board/ge/bx50v3/bx50v3.c              | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-mx6/clock.h b/arch/arm/include/asm/arch-mx6/clock.h
index 81af89c631f..9c5f3090bd8 100644
--- a/arch/arm/include/asm/arch-mx6/clock.h
+++ b/arch/arm/include/asm/arch-mx6/clock.h
@@ -82,7 +82,7 @@ int enable_lcdif_clock(u32 base_addr, bool enable);
 void enable_qspi_clk(int qspi_num);
 void enable_thermal_clk(void);
 void mxs_set_lcdclk(u32 base_addr, u32 freq);
-void select_ldb_di_clock_source(enum ldb_di_clock clk);
+void select_ldb_di_clock_source(enum ldb_di_clock clk0, enum ldb_di_clock clk1);
 void enable_eim_clk(unsigned char enable);
 int do_mx6_showclocks(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
diff --git a/arch/arm/mach-imx/mx6/clock.c b/arch/arm/mach-imx/mx6/clock.c
index b5aa606b8d0..d366180e788 100644
--- a/arch/arm/mach-imx/mx6/clock.c
+++ b/arch/arm/mach-imx/mx6/clock.c
@@ -1452,7 +1452,7 @@ static void enable_ldb_di_clock_sources(void)
  * Try call this function as early in the boot process as possible since the
  * function temporarily disables PLL2 PFD's, PLL3 PFD's and PLL5.
  */
-void select_ldb_di_clock_source(enum ldb_di_clock clk)
+void select_ldb_di_clock_source(enum ldb_di_clock clk0, enum ldb_di_clock clk1)
 {
 	struct mxc_ccm_reg *mxc_ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
 	int reg;
@@ -1525,8 +1525,8 @@ void select_ldb_di_clock_source(enum ldb_di_clock clk)
 	reg = readl(&mxc_ccm->cs2cdr);
 	reg &= ~(MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_MASK
 	      | MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_MASK);
-	reg |= ((clk << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
-	      | (clk << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
+	reg |= ((clk0 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET)
+	      | (clk1 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET));
 	writel(reg, &mxc_ccm->cs2cdr);
 
 	/* Unbypass pll3_sw_clk */
diff --git a/board/aristainetos/aristainetos.c b/board/aristainetos/aristainetos.c
index 8cfac9fbb34..4a2349e165b 100644
--- a/board/aristainetos/aristainetos.c
+++ b/board/aristainetos/aristainetos.c
@@ -218,7 +218,7 @@ static void set_gpr_register(void)
 
 int board_early_init_f(void)
 {
-	select_ldb_di_clock_source(MXC_PLL5_CLK);
+	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
 	set_gpr_register();
 
 	/*
diff --git a/board/ge/b1x5v2/b1x5v2.c b/board/ge/b1x5v2/b1x5v2.c
index ddb7304d493..f7751fd6fb1 100644
--- a/board/ge/b1x5v2/b1x5v2.c
+++ b/board/ge/b1x5v2/b1x5v2.c
@@ -320,7 +320,7 @@ int overwrite_console(void)
 
 int board_early_init_f(void)
 {
-	select_ldb_di_clock_source(MXC_PLL5_CLK);
+	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
 
 	return 0;
 }
diff --git a/board/ge/bx50v3/bx50v3.c b/board/ge/bx50v3/bx50v3.c
index e1d08475e94..9fc5f604a49 100644
--- a/board/ge/bx50v3/bx50v3.c
+++ b/board/ge/bx50v3/bx50v3.c
@@ -383,7 +383,7 @@ int board_early_init_f(void)
 
 #if defined(CONFIG_VIDEO_IPUV3)
 	/* Set LDB clock to Video PLL */
-	select_ldb_di_clock_source(MXC_PLL5_CLK);
+	select_ldb_di_clock_source(MXC_PLL5_CLK, MXC_PLL5_CLK);
 #endif
 	return 0;
 }
-- 
2.47.3

