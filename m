Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCC5F9EDC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 12:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D107842B7;
	Wed, 22 Apr 2026 14:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="d5hqJxpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAD58426E; Wed, 22 Apr 2026 11:47:07 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C1C8423E
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:47:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+GzMfBP7vcxaF2dI42g5/eFjx9Y6srjQR14T7xFkzQ0+nzCjEO/rPftdfo2EdOCReHFbBBr5plopYFG8YZ0jSWVyX5OlU0s3sTBaFy2J2/yCQm/Dqh7E5x6aCojZPmxjf83L3JeTo3GHCZAkA1Hw+trNIVNVL/G/ZYn/3wRJnrPHmzJROiEUsr6qF/L1Z+iRmQXF4G/mFbePWNOohL8Y8vMkbAWg+jUP1lc6U5bJIiByClWz9ClU36J+nLtjeRU5PuMzypEzQPM8lvoqxiSAbv+XV37bUBGLWBIbAhqtje9vgi1yt4OxYLXeBz08gX+MY6eED2eAxrdKZCL0nrtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glV0maNZAgmGEQ0iE4DmMwKCD2+TEp45OOgdX9j69oY=;
 b=W2cLGyTJJl4X0rCnTTwuHgVV36w5dUHqEvKavlnvjfUnhd4Aq2+MdwAJUQUn2P74lYxdcHnzR7dmxfr+KzriTUp9VUH7vfGK2BApMrBBZ5E0V1HC/3EL4Con05s7Ge8KupOjN/9xcz5m7CSKAmmu/vqnimP/YMG08XLv/1/IuEno9yXzu6JLZSLeE5WTs96Geq8Wv9gEe4llmx+rt+qZ9W2PZQmJwW53BfJRvc0Yr9S8m/qDijwb8sIPjkY9BRo5946gEIEUKYikR6zNlhea0k+gBCrzEOgPZ+gCpx7y9BFncaHZ/+rwbXlaogXMIus31Vb+xCWL5Q00d058MUdjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glV0maNZAgmGEQ0iE4DmMwKCD2+TEp45OOgdX9j69oY=;
 b=d5hqJxpC/5LLhtZHxuFldRsC+pl/JH05hFDTblvp/y+bGgkQXL/9GeZbXY/YdAVmgSWIcsW8RLzyvRTFjoHLk7UTLpsKaVbpW/2NeWypTyZW9XxVVFd0bJwbPe1QQaF5K9CdGRvghX57imeKMgv3iT470CIx+WnAsuJAwgn72TtOJo9tuudN7K3TAlM5rJ32WDUWLNR9aYyWIwarkU5+KuFDS2ihbRdbe7TK0ldddZB1+45fJbFjOLnpKEKmD1dX8MUHCC/wUIgP4jnNB4RNzZhPv0j3w6ntExHxiNtm++FfWUggIglauLDal9a2zrDeOY8a7uKTfy2K3GnfQeGQ7g==
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by LV8PR22MB5700.namprd22.prod.outlook.com (2603:10b6:408:266::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:47:00 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::b9) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 09:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 09:47:00 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id CFB611290A;
 Wed, 22 Apr 2026 12:46:57 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@nabladev.com>,
 "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
	u-boot@lists.denx.de
Subject: [PATCH 3/5] imx6: clock: allow different clock sources for ldb
Date: Wed, 22 Apr 2026 12:46:41 +0300
Message-ID: <20260422094649.57611-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
References: <20260422094649.57611-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV8PR22MB5700:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 97785d64-2b65-49ab-f4ea-08dea05419b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: RQaC7Ie5PLJKBBNXq47EHUY24+MNatOGQK7Sl4mLidyCBWNv5HwwVYTJzOaPBvf6EiJqUoTJ54lBQUPIudvgk3rP0n0ZDE/N+t+ZwMMm78m7uHasPtgCWUtOlAeD7m1u4ibrvloH9U/zwdNVm0y3uvczIlp0pBS9qwiH/3p9TN2oTBnweoRBugbsAqmkKBi/jbS3eSjrB2xgDlVt1q2jnT8bWPLTzzeMxYwpgSYophavJ5pOXLF+eK7Q6zfTmjQXcs9ZPNLHFDeSreOsLEXGgaiAL+sB205sn3z1QyEfp7acZaTr8xRvI2sYe8NKWfbE6uQ8CpyIvZS/auuI5xiF5UQ3XUQTYSVNR38HiXNpx5mhS5+CHmaohwgXEXB2srz3r0rbOZfvR2YxXNDwJovOobivMSt4jvTflRGF7mzKo9MdbnFdEFhvj+ATB5BKD0inZ/Ws2e18MiAMyAO4P+PGr28qRNhuMT44PxDfR8/fxSGee3WHyShQkOUutKzF5s0ygqiujFKzEuEVFwAtBXuCVKt7TFvEY+1dmsAUJButUnCGxKni4LS9kC56BgdJEAMDbMxqkcTxZzmchsK5zgNnFWnfr8J3n379kYb/dCKMcIFtItZfIIob85yM+1goQew+R3ZgAUbdCIOssVaNH/x/YhGlF430kIXnUctpFG8eIL8iZ9wYo6XrpjDoJH3HgJHncrWO2xizSuz/75UdSX8lnw8+dprADEaZ0H+hjCZa9BPqTo1j8iY4mHAUhDdgF5WAgtBIOwfWTk1FymEW8mu1Vw==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nWJYPx4UsaQqq1cZToSKvXMjwQwNKshAwQK5cJs6B5S533pnqjrjY+tQ20vIRcjpMVTjlLNTnWir97mi9r6jbYu2WONRKU5LAsEwCytHRoofRHoQZcgY2+fLj62+S9xGIWCzFd3OJCo6WDc+bWs2QS3Sto3bjQeq3eY4n721DGDFFBEld6T1r3Is764Khg33DZOs/pOd+EpyWf1iPV8ENHsMPj1DUCsup/pk/TGsvJJ7smujD6tsU8MWp4WcijYTVJ6+z4TR281fzMCn4Re6QvieWy6W/4FXNPdDz/qX+D7g91FXW3l9qFkpj7VATZ0ssSx38EnF2b/lK08TkziBZmxorOygnpMhotZVk+9YyS0EoG83Sqjd8imomY+8r67bbRZ3iU0sYMQSEbGiV7yasrNaMIulevBcBlHwNVgrMF5AD/wc6WNn1Ys2Y32UHyLf
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:47:00.0393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97785d64-2b65-49ab-f4ea-08dea05419b2
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5700
X-Mailman-Approved-At: Wed, 22 Apr 2026 14:34:21 +0200
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
index b5aa606b8d0..828a101ba05 100644
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
+	reg |= ((clk0 << MXC_CCM_CS2CDR_LDB_DI1_CLK_SEL_OFFSET)
+	      | (clk1 << MXC_CCM_CS2CDR_LDB_DI0_CLK_SEL_OFFSET));
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

