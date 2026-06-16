Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE6CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA13A848A2;
	Tue, 16 Jun 2026 20:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="fB0vBTDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F5C28491C; Tue, 16 Jun 2026 14:52:01 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39070846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3pxBjfmGKBOyb8JUA6nxf72yBbCiI3qw4+q7R9BtK/FQ6U6NgfNWaduA4tFAA+S2cA25eEYqlvFAcmLrW+FUN/xN55WVz1P9N9mz0TJzr68nGwkQvsUcfdk1UL8zcnlvHlIGcdq+p/7T9mrxTquAlmAwRz7AX6ERpkl0qpoC31xuJvTuDgNemNJkwjHbM+Kgc7qndFeOOxrr5SHSsufx6JTMYHz3Y9bl/Jwht0w7LCaEQLHH9qoYmGnpRz4w7KuqkhKe8+EyyxF4mj3Z8g9qclfMFty79D1wzj1d0d4WMoX3AyT7l9LkFaNOCKMKJHWnMGXOjF6sk2Waz1W7imZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Pi3UOnOHSqWfxBHHzf05F2S5resLOHsgEki+icnLNA=;
 b=uuVKLgYnaLkb2vnx8iDM/PKEUMtZyvo+3RsWNk9TG7jDBUzkOrLRPbND9hgLmQjXXgijGXXshCcNvzJi0P0zMagROOCePR65S0+/A7hCJnq30mYDT8vkeki93p4zRUZ9+dhnX3c+g7UO6c1CdAd7p+s2Xi0sXcwoY8pe+z0i60tAijW+K9N5NjyQkIA1pgBQHXnUt8wnQuZtfijNfBqi9v5nUktSMawqfthxT5zn7TW0fG2zJpbk4FrZ6noaenazd1iMOcYGxnlDcMnlbNK9fcbVYSDXjBbdpOo8gLPxqBtNHv2YPEXp8XTxbNnYuQ9X+bzWwsCfTgb9YrcxhErIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Pi3UOnOHSqWfxBHHzf05F2S5resLOHsgEki+icnLNA=;
 b=fB0vBTDyI7TdYad63hSAFUf8U4FxdHf9gfAuC7IDJtB0apDkV33Qn6dHYviCeRwfEbHaFRvdKUCbeND5UcUU531UAWmijzCnba7zldKw5W0cGPWkeo0iK9/fGiPMec/krMlj2YFtBzBMx7EXtDWpVVrqwrSQTwwEmSUqy/Y9lLt9DzI5bD9lO30bBwEbQkYcwwJNfNE9zXXaU6zfXCScq9sI8we+0OpdW8TISyXRfNgu38SLb1oOBBK979nGv7vwBPxGt3U+N4kRIPT+exPRyecIcZz4OmJdCCG3rsz+4ZSBIYo6u3tzdFnojkxPy+HyqyRJSo/JEbLwul3jLH7Q9g==
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by SA3PR22MB4548.namprd22.prod.outlook.com (2603:10b6:806:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:54 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::3c) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:54 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 7B4CE1290F;
 Tue, 16 Jun 2026 15:51:51 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com,
	festevam@gmail.com,
	u-boot@lists.denx.de
Subject: [PATCH v3 2/8] clk: imx6q: guard video clocks behind config
Date: Tue, 16 Jun 2026 15:51:35 +0300
Message-ID: <20260616125147.3710024-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|SA3PR22MB4548:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c9a180a3-73ad-459e-1a2b-08decba60afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: URe3A4Qx9KKZNsYvZol2d39ffmOny7TC6S1UhFvzpT0xLE62oLo8vylmj+teMqEFrjtzMK2V21maoSyNwfFV0hMBr9FlHfYcKdFVjgAH97S36KOITx+AOjstdF6G0juNKrWXBsCBwM2WE0DciMs0VC2sj5h8sZ5JBVaA5LashEOfqhKx25jhIQm6qGe0TgcKdibZ3RSOhlRLvlak7+WXnV7+cllN1iVF+K19jqCdzKCYHCWm/AjhM33Ro9CwxiXrh6nJuIohrk4npkjPleuEj4rN1NCIhNiMWo5lkYZ4QwI5pbKXgr1dBTnAtm8fcGaeE32+MBB8VRh2sbr52FgkmIpSXDYo3xV1jOSL7R2e8SCsjI0+X9Nw8LFsqJMNkgB0l95SQZeaeONeCIFDHm4zgTnR1hI9h/d2CZr4tA2SMDt4Lyg6SY730bxxDh2Krv1xG5Z/HGHKJ4kpw3aPvSVYzxWLkpnpIZ8FWLrq1mwo6oQe+lD0ISfsRjcZXg6dmKSvFGaSPyIPz5vXacKbREvazlG1I//HRvP01xstVevSwo1DVGCp/hNMCHJ4BY1GOjN+UVhVfKpqc1uJmCR91eStCHfEzyFPbxupv+jQQJ4FBq12DNnoGbANUKJ6d3lx4h9Nhbjy+NG8a72kdEQ7RsWPgbICe7voiWBROyU8tNxJKRmw3UGRT/XoRGqzpeHpSO3sGlp1QJwzEfgY8ddjfSe8N0KobPu9JF0aRGPirVDmdeM=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X0K7UC9gbd/8pX9qRVO68dl7BGHKdT4PR39gn2QA+CWczC/kRZPiEwdNubn114WZd5wlVFJfEYevIo//4BoQYvCdQoBMD03fxOxRykinH79Oaded/PnaF4++trfvwLHk0EnCpyvWlI2YJybiArYVcwzzouLi8RObJYsydk035vecl98hzjOIhxP06VfgnpNoYFKROwxeXRFUPPDlw7O0wGMwwaIlzCRRN0/eFWTh9zracqi72D/SStIyizIL931HLvSJ8xkag2pMVkxVMhxxi5OH505pPB3/Fn0kqJERzmGlwGkLHMw4NXWDyWQYqbVZUAzZCjUD6603izZAhiLBvfTRvXzeb9Xly9UN0lUIl6EOujb5O1jfZaf6IbWYjysPJwFc+ETifYxkXcBoVoQbh0r7U7ls1qaK3plswz8LesE8JTV5rl3GRtkcAXZCkKq0
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:54.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a180a3-73ad-459e-1a2b-08decba60afc
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR22MB4548
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

Do not touch the video clocks unless explicitly required by the
configuration. This avoids the issue of the binary size increase on SPL
builds that do not enable video. For those that do, they should increase
the size limit to fit the new code and data.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
Changes for v3:
 - New
---
 drivers/clk/imx/clk-imx6q.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index cd06d211e8d..67c0261091d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -72,6 +72,8 @@ static const char *const ecspi_sels[] = {
 	"pll3_60m",
 	"osc",
 };
+
+#if CONFIG_IS_ENABLED(VIDEO)
 static const char *const ipu_sels[] = {
 	"mmdc_ch0_axi",
 	"pll2_pfd2_396m",
@@ -112,6 +114,7 @@ static const char *ipu2_di1_sels_2[] = {
 };
 
 static unsigned int share_count_mipi_core_cfg;
+#endif /* CONFIG_IS_ENABLED(VIDEO) */
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -264,6 +267,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "mmdc_ch1_axi", "mmdc_ch1_axi_podf",
 			     base + 0x74, 22));
 
+#if CONFIG_IS_ENABLED(VIDEO)
 	clk_dm(IMX6QDL_CLK_IPU1_SEL,
 	       imx_clk_mux(dev, "ipu1_sel", base + 0x3c, 9, 2, ipu_sels,
 			   ARRAY_SIZE(ipu_sels)));
@@ -414,6 +418,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 					 ARRAY_SIZE(ipu2_di1_sels),
 					 CLK_SET_RATE_PARENT));
 	}
+#endif /* CONFIG_IS_ENABLED(VIDEO) */
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2(dev, "ecspi1", "ecspi_root", base + 0x6c, 0));
@@ -454,6 +459,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+
+#if CONFIG_IS_ENABLED(VIDEO)
 	clk_dm(IMX6QDL_CLK_MIPI_CORE_CFG,
 	       imx_clk_gate2_shared(dev, "mipi_core_cfg", "video_27m",
 				    base + 0x74, 16,
@@ -481,6 +488,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 		SET_CLK_PARENT(IMX6QDL_CLK_IPU1_SEL,
 			       IMX6QDL_CLK_PLL3_PFD1_540M);
 	}
+#endif /* CONFIG_IS_ENABLED(VIDEO) */
 
 	return 0;
 }
-- 
2.47.3

