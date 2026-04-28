Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DC6FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 130018465C;
	Tue, 28 Apr 2026 14:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="jymVPkUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FB984664; Tue, 28 Apr 2026 10:51:36 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38558466F
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thN7bJXaW4UT02ckbg58kbYIelBvytBsTSRJHpx4Gepj+Jl4FUtAtp6mZUpNmGsuF/wbWnevIri4Z40eJnDghG4hUVYXmKzDlbDPwW0IwMe8ojI9y6RvK/b1yYkDg0ukfqbdvO5oIxkxPdIFLOUhxCH6ZcEKtIJ2PSzOpzewulNNIzVND255Utw2IQxzZqeQiDj73dwThq31SDW6DFZIALsKgfNFvILloP99g0R18qWZmGMtCTZ9YBw86MHzlNzdbAtg/6sey9k59epk1CHZ5W2Qd0QqHiELSuzH0ydouPYT313Ao3mQfoK9H7JiPsQaPWD5VHOfGIZjLEXoDl5IAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glV0maNZAgmGEQ0iE4DmMwKCD2+TEp45OOgdX9j69oY=;
 b=tAf/g0m+/4AI/S4/BpmX4Kx/6wCfYlKy3WeqbApOUwGC9KPwNG5PXnAG1HYrtX8xFFDU+svcm/760hUAQSAGEhZdyws16e4ryaxPbIv8du//pctiE2GqR8SVqne1NnEEbY9DaJ2X8Oqla5eqZg6dyQgzpJuVwuW96mRBoyCrzU78DM+pN+zIdBpWsHhjD9udE6vQx1fXxiD253G8VQgNux9S2yvTZWgJHwzkMDE+g9UjoiyT7yj9Z7mhLCLs8acff1GDt7vcFJW2L9drCjvvBme+N/AFcpnCvu9i3n4y9wKJ2pf/rbiIVuPAAjdvZ9dptkIH/7o+/XEzCCVYXjBk8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glV0maNZAgmGEQ0iE4DmMwKCD2+TEp45OOgdX9j69oY=;
 b=jymVPkUnqvcM30n7dSmzYxDThJ2M2oUX1VSrd8E7evpaYxFRJfp99M3M6oeIgsL1j6Mx025d3vGz54oVnyY4Y87l5k9ksgUiLukJHn5pxDCI4zbHtLcNRy2iCaas2v5xXcb6GvVr4lq1d4wkDJh+lEOlUCixHfZmfWdIqKNiQ+RHe4S9qfPJOdZGlSHw5DtpPKt8SRiNUL5BZ5f1qORvunUSYpvnpQGDOklX9063sprm38/H6me4lKtKqRrwlqgJu4b3W0UAaFmWmXzwoMHQ75cY/DxRVqXhTvZeSrCdE6c5rvT8l1qP6CZKw2zS/0GK8f87TYXk7QH+hmqNl20JkQ==
Received: from BN9PR03CA0693.namprd03.prod.outlook.com (2603:10b6:408:ef::8)
 by IA2PR22MB5586.namprd22.prod.outlook.com (2603:10b6:208:4ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:28 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::e8) by BN9PR03CA0693.outlook.office365.com
 (2603:10b6:408:ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 08:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:51:27 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 9E47E1290B;
 Tue, 28 Apr 2026 11:51:23 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@nabladev.com>,
 "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: brian.ruley@gehealthcare.com,
	lukma@denx.de,
	u-boot@lists.denx.de
Subject: [PATCH v2 3/7] imx6: clock: allow different clock sources for ldb
Date: Tue, 28 Apr 2026 11:51:08 +0300
Message-ID: <20260428085117.402523-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|IA2PR22MB5586:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b4597328-c090-4fbc-6e76-08dea503561a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: zxYv3LfvJ6Ma385/vkZtPfgngeeH58tDDoJnsb6V+JhbNAwp9faUJZOmfXTnQpn1k9yWK2MywaACzPqnmLvIy9SzDGC+rUi8lucB95dCx46ZIY9k3KYyNDf13XnBspp7RZnLygsqg9iIj92Hj224ij7uSL8tYzgIjrUw0/xM+Q1yrdCaiMLMprTr+NK/jzkvC+hNa8XK8fzb6VVmIML9Cm7hSfMDoUYB2czHv6B8U1Y779QlVXf8hSsu8lc84YsDYs7Py/RNQSJw7Myfc/otWNngsf1XuKVnZHGrIE7LdWIAgPtyCGAVj6zqYbXlRhRChTbD7jgPN5XAillrg7mSg9ARGQ2St8fiCPNhdXPx2S7EeRDIEsR2Kd/TasuGOiTqKidYuPb2I8ZrznezrQJqu4vJ1zt5Vh7Zna0LjHthRNDgBQC9h1qj2Pka9AgiU34Hxnf5QwNp5eFlvkaBwyv8BMqqyquoxUst1Bx9wns/4jGdbwHdMz899Ix350WlOCV97PTTui2CS6piDRROJReDrNUhJaf4rZBDG18xtGzAAEGA81+BAMgOnwREOC0vwtqejtAaVLvxhSlyBR3sGI40SfjGm160Aa2cdprey37Pm3J906zsg5v89BczMuLyJrmH84xVmmq46bfGXxSguk1IaYEv/0AUqXi6Q2V6TihvICDvyXCz+Dh3TerntpqApYKjqy6mcoiogfkpWTQky/4bpuWgFZDn44NQuiIzYKqq/xHY6oI0PzgYfgtsHnQMueJrxBOvTM7abvsUfx+4n2dgag==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wHVC67OJiLdRgVkomQpGdnshN8+9szUC5KP6FcBNXczUtWFdVUX8avoVIKYzY+btw/aDAyGsPPgt71y7pgmf5SiySvJB3zwGdv9gbJW9bpjnoxXL3fm5UIVNEB59Lm6GqEFTZZo0Qvh0zY/f/Zk3nlBULtikL/bUAozl0XkI2S58i3RN4IoMQgbO7o6Xrf4M/cdAo9+cjjWbFvl1OumfeDmPEVMJ6s/rh7t003U9d5z+udMsBUHxhzcLGAMIvDGxVzWqwPUCNZzXU6PL8+5hyktjU1ucvWC9wjvGEjQSzXrVOVdoazLaJnX/p5LOz9mx4YlEOAEda05UVBZFYi40hvy51a6+0utoirjHkvECovd7ihhsQ2agOH3OKQ3GTu4MFc/e5NXIuM7R24hPL/6hAJNVgWjKXfXQmlqtgtE+oQFMkvM4U0kMclca/xp8U7tf
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:27.9412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4597328-c090-4fbc-6e76-08dea503561a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5586
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

