Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F0AEDF160
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A014783DE0;
	Fri, 13 Feb 2026 14:24:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="QxeRxhOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C211483B9D; Fri, 13 Feb 2026 09:50:14 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3313483C4B
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8RhIPAVQWLDKovpShj4yJZxff9tKfXAG1FGjUMLC/6ZC95Rt1HtkJtp6bXYpFI6XdBnALFdfBCh/FUhhH3wE2PwhAWdtZrUadnjgQ0/5+Z1AwGrrMMv5lRlCEUex587SSpT+5nTshqmhM/BGVf0o/XfvZsw7AHGkbQs5sAlva/khEDb8LQEBOmQBQOZp+ykRzz3TV0fDDD8jvvy0QpD0wog1MVA25G70IGaeNDeFaNmpL/w95ZvsvBeJ4M4TePDvedH7oqhbS2NSuX7bwCChnPERF8veKW8II9u8FyHPpPff80bDalkTc7j8drOq6YLbqIbunHzv/i5OGJgyDit6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyxZswqfwphP94u/PWlCtQkvKEleV5RfpBWZ06Cj0bw=;
 b=mpDi64T76Ae+OU+NpBFm0GgkNQ+ptPNHsE6m/Xx0cnTGa6JEiFtChYskY0uasbhK/8ws8k/445pR0UomZwu2scqAwZ+2Hw6f77s6kfxam518+aE48IGWS4ZeLNZY0Rz5yrh0CQN5VzyoQuz713H5qB7tbQ9GEvdq470SyBS5i5mxvEIClXSzPmKOEyw9evl1Uz+G9Zd2KJERK4wadwiUx1h+kHxk8yJaJ3M95Up8R4Ky5a1JmAcQDexDqSiMRGspPZUCc+4e/h6uyVQrlYfCcXIFEq1MGyp8uhYHTTK1G/HvR7N+emoJ75tLzJi1RpEWp5t5xBLgOqD28iN83YsMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyxZswqfwphP94u/PWlCtQkvKEleV5RfpBWZ06Cj0bw=;
 b=QxeRxhODe6j29QJTBuuiw8nPI1R5xyQQrn0TSHFrf9Vy5WvvHBfupo+cWh0zhAdUh04lQ7t7a5jdK3uvcSOOwEfJ3Ta1PnyJM0t1w3w6nKLQvDxsrJLHrwgB7MwJ8Bjfc/3JJHKjkjNw5n1kVghQPQNP+QVYyiyeaeJAi5B9AR1xa6/HQXuFe8ePPvj8dUdY8XbESw5JXFru+mKTrf/UEgLVJAFhtCbbZ/8VMm4BXt1/NVOLalhO+LHFv2+xLA/ni72xJVDk/aAHB0g4kclfYUbwx3P7h6BbgVc5NG5d5+00uGlp4JQ6re6xdrOqlB71Dk4Hxi8YbSIHPabAPkQLyw==
Received: from CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12)
 by PH7PR22MB5228.namprd22.prod.outlook.com (2603:10b6:510:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 08:50:05 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::2c) by CH2PR19CA0002.outlook.office365.com
 (2603:10b6:610:4d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 08:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:04 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 89A4DFD301;
 Fri, 13 Feb 2026 10:50:02 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH v3 2/6] clk: imx6q: apply clang-format
Date: Fri, 13 Feb 2026 10:49:51 +0200
Message-Id: <20260213084956.1031000-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
 <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|PH7PR22MB5228:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cff76d07-c16c-444c-9ec2-08de6adce20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hrb0VNFv589hWKQnaWYmukhJM500DjeCx691I777U3cauuuv6Yyqjs7CHsoA?=
 =?us-ascii?Q?BFRdhf8dd74JALPY2vYbvIMq7VryhHkwS5difYfBMIi5XAxSsgjedV0OOsoz?=
 =?us-ascii?Q?tXHUHWvEX8UTvlK1654bn4A+qtu3ZiDpn2dPiYH1vzVl2AVJ1+fyQKFkmJOP?=
 =?us-ascii?Q?JSe3QIBPT/R9DSmyE1l151V/ONsyeFuxzEuTr/VU7D1oiwFlSZDTZYU6txVQ?=
 =?us-ascii?Q?7IXy26oTpGKaXD9XyDgTLw1gWCo3oIKBw3lftscbXyPVsAExxbvzHEm+vbll?=
 =?us-ascii?Q?I5bqub67FY1n/CNT+nv1KTMAvONELQvt7mKv0KtOPy9PdkbeFcwRBLVCISN5?=
 =?us-ascii?Q?ef+Gph376qmfZATrxCV0tg6Nir2yi4Aqfs2MrZ/GXuWfBXT4j/avRCQjIALe?=
 =?us-ascii?Q?TF4dwvzmiPJQe13yCjj8ZJLAD6BpPf5nTlZmpcBiGx2D4uXpUzm6azMvl4hn?=
 =?us-ascii?Q?gOl1Wr3/inRqMPQFEGYJSeFwRBC9uPwY5zDAHYjsmtSfbM5EKpGWPWLviewh?=
 =?us-ascii?Q?oyv2ZX2TpIZ0WBazwYWf5tiqt5XyqvZWWYSAV+rn247KzYI8XV3TVHJ7AtoX?=
 =?us-ascii?Q?mdRZCLVuQmMiKe2ImKk4+DQU5DzsqNySncBAS7+mjdQpU/BFh1ecB0QEsRdj?=
 =?us-ascii?Q?rOR6718lzT/1bg1QE7pQe6sdNVbSerZAr+XeKKSid10BDGKdbIXJJ0nURAjD?=
 =?us-ascii?Q?jQe5sVSf84PTQSGT0x3brXpyNfdV38w5Se8AREiFkDKllfK20V8Py9f9nwMd?=
 =?us-ascii?Q?aqDtb7fzkif6fz8VIhGrA8OsxIGaCLnkU1pTmEyDzOLWgDP2i2Yy5SuOcSK4?=
 =?us-ascii?Q?XRBYUGYkjERp+4KjiU8f4co5T/jBuCFG+Xts7Vi4GBF5noIH8E7UwGF2OxZj?=
 =?us-ascii?Q?CNJ97ONTFTr7vEVcmWCDqZ7Z5wEEZuOgngwmKkOsPccqUa1uAhU0QuSIHPGJ?=
 =?us-ascii?Q?k1t98GKfNoP72ykJFxmYecqqYCp0BEQbRPS++rr9yIwetkNVZEazkjmssZkH?=
 =?us-ascii?Q?mU5kCz6K9Ua+E/QUTAX2D2kfb+wRaLZhcW5kyg2MfVFG1FEHMOabScDF26PA?=
 =?us-ascii?Q?WaMU4LRvG/9554ZFVan5yS2kn14vqTNv0tX+6hmc/C6lrVqW3nH78SfQr4Ay?=
 =?us-ascii?Q?51uoeSHQralVWKkCpw7hrKfYuDj8R318/7APoERvY1QBEY3F65NS+Y6JtOhf?=
 =?us-ascii?Q?MgQKdB5gECwqY23uYqMy6S7xD48Er1KdT1SnsS7tRC1EWSrYBJvMnH69mLAW?=
 =?us-ascii?Q?mKlBYCGel3A8zdpYzO26gNYPwv3PbW02ZgKe8rso7lxBw43wh9p8KEA8V7pJ?=
 =?us-ascii?Q?4cAexdeDjzWIQlE0oCpZQ462C6IerWTrApkzFF38turRySu+vF+moEXw2QmN?=
 =?us-ascii?Q?dfLmkqsO/BLjpR5VGwfb9BjocNSb9cgYBxJdj2yR6tkROTRdCGjgz/AbnFXa?=
 =?us-ascii?Q?pM3WTBbi1pHvFpv6Y9O81w5Ilhj7XjnE4IMYSaKL8fwj49dZgYmf+ZFcYMVt?=
 =?us-ascii?Q?vj2WnKbDXqZD34jH5ign+mPsFoX16AUfjKAId/HHnLfQC4cKGiywC0i3q+uI?=
 =?us-ascii?Q?QmdpLOp8QdhHnw7wB4Ls1UBC8vISFZYdFkRzgr4ttmmrHxDEP31tBKBaOazX?=
 =?us-ascii?Q?PYfnVHrxO6R/rdb9oPO9IBN5X1Z1B7oo/PXkwSEvJtLFnLHjvWCL3bWXA4Lk?=
 =?us-ascii?Q?ROj2CA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nixx36ZVPgPOaVeaA3cdsgzNr0VmMeDHXT3qf2vBMeHPWCoCKNUWcEhEMMinfnLwWmN4o7uKmBnmAXn+Kz/AEdtwehW0kzICqGChVDcioo2Vnq7+rnnVypcfkbxo+ffGmHUATBKgmYmpmrz/kQJjoykUho6kPeL3HtJDPQCTDGc2nLtTDcq7qEZAb1P3pyFpmCiDL1/or9JNE/io/6DO80eUS81y/pm5ofKKa8nVEwH5wml3VZNPLNrnmee/WAFX9OQ826i391kwobXJoccPqwf9NFU6+m4NlSqTDSL39BEs1PGfnUuw96qhne8nrGXqGhRpWa/p6d7pS9vvEwZ5OVECArh4NeIARhUc0atXurMYiWg4k+NPksAQh8LeHkqy7oIaOhbD8rGA7pfUq4IttjSqg0tsEmSD3VOjZAj9xfZ/lKr/G1s1nai5ugwbFp5V
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:04.9053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff76d07-c16c-444c-9ec2-08de6adce20b
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB5228
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:08 +0100
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

Reduces the number of checkpatch warnings in the following commits.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

Changes in v3:
- Fix commit message

 drivers/clk/imx/clk-imx6q.c | 102 ++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b69355cefc7..f11f9045abb 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -31,12 +31,28 @@ static struct clk_ops imx6q_clk_ops = {
 	.disable = ccf_clk_disable,
 };
 
-static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
-static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
-static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
-					       "pll2_pfd0_352m", "pll2_198m", };
-static const char *const uart_sels[] = { "pll3_80m", "osc", };
-static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
+static const char *const usdhc_sels[] = {
+	"pll2_pfd2_396m",
+	"pll2_pfd0_352m",
+};
+static const char *const periph_sels[] = {
+	"periph_pre",
+	"periph_clk2",
+};
+static const char *const periph_pre_sels[] = {
+	"pll2_bus",
+	"pll2_pfd2_396m",
+	"pll2_pfd0_352m",
+	"pll2_198m",
+};
+static const char *const uart_sels[] = {
+	"pll3_80m",
+	"osc",
+};
+static const char *const ecspi_sels[] = {
+	"pll3_60m",
+	"osc",
+};
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -52,13 +68,13 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
-	       imx_clk_fixed_factor(dev, "pll3_60m",  "pll3_usb_otg",   1, 8));
+	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
 	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
-	clk_dm(IMX6QDL_CLK_PLL6,
-	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
+	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
+					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
@@ -68,50 +84,54 @@ static int imx6q_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX6QDL_CLK_USDHC1_SEL,
-	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC2_SEL,
-	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC3_SEL,
-	       imx_clk_mux(dev, "usdhc3_sel", base + 0x1c, 18, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC4_SEL,
-	       imx_clk_mux(dev, "usdhc4_sel", base + 0x1c, 19, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc4_sel", base + 0x1c, 19, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 
 	if (of_machine_is_compatible("fsl,imx6qp")) {
 		clk_dm(IMX6QDL_CLK_UART_SEL,
-		       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1, uart_sels,
-				   ARRAY_SIZE(uart_sels)));
+		       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1,
+				   uart_sels, ARRAY_SIZE(uart_sels)));
 		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
-		       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1, ecspi_sels,
-				   ARRAY_SIZE(ecspi_sels)));
+		       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1,
+				   ecspi_sels, ARRAY_SIZE(ecspi_sels)));
 	}
 
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
-	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel",
-			       base + 0x24, 11, 3));
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
+			       11, 3));
 	clk_dm(IMX6QDL_CLK_USDHC2_PODF,
-	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel",
-			       base + 0x24, 16, 3));
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel", base + 0x24,
+			       16, 3));
 	clk_dm(IMX6QDL_CLK_USDHC3_PODF,
-	       imx_clk_divider(dev, "usdhc3_podf", "usdhc3_sel",
-			       base + 0x24, 19, 3));
+	       imx_clk_divider(dev, "usdhc3_podf", "usdhc3_sel", base + 0x24,
+			       19, 3));
 	clk_dm(IMX6QDL_CLK_USDHC4_PODF,
-	       imx_clk_divider(dev, "usdhc4_podf", "usdhc4_sel",
-			       base + 0x24, 22, 3));
+	       imx_clk_divider(dev, "usdhc4_podf", "usdhc4_sel", base + 0x24,
+			       22, 3));
 
 	if (of_machine_is_compatible("fsl,imx6qp")) {
 		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
-		       imx_clk_divider(dev, "uart_serial_podf", "uart_sel", base + 0x24, 0, 6));
+		       imx_clk_divider(dev, "uart_serial_podf", "uart_sel",
+				       base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-		       imx_clk_divider(dev, "ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
+		       imx_clk_divider(dev, "ecspi_root", "ecspi_sel",
+				       base + 0x38, 19, 6));
 	} else {
 		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
-		       imx_clk_divider(dev, "uart_serial_podf", "pll3_80m", base + 0x24, 0, 6));
+		       imx_clk_divider(dev, "uart_serial_podf", "pll3_80m",
+				       base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-		       imx_clk_divider(dev, "ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+		       imx_clk_divider(dev, "ecspi_root", "pll3_60m",
+				       base + 0x38, 19, 6));
 	}
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
@@ -125,7 +145,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_UART_IPG,
 	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
 	clk_dm(IMX6QDL_CLK_UART_SERIAL,
-	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",  base + 0x7c, 26));
+	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",
+			     base + 0x7c, 26));
 	clk_dm(IMX6QDL_CLK_USDHC1,
 	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
@@ -136,11 +157,11 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "usdhc4", "usdhc4_podf", base + 0x80, 8));
 
 	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
-	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2, periph_pre_sels,
-			   ARRAY_SIZE(periph_pre_sels)));
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
 	clk_dm(IMX6QDL_CLK_PERIPH,
-	       imx_clk_busy_mux(dev, "periph",  base + 0x14, 25, 1, base + 0x48,
-				5, periph_sels,  ARRAY_SIZE(periph_sels)));
+	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
+				5, periph_sels, ARRAY_SIZE(periph_sels)));
 	clk_dm(IMX6QDL_CLK_AHB,
 	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
 				    base + 0x48, 1));
@@ -163,7 +184,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PWM4,
 	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
 
-	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
+	clk_dm(IMX6QDL_CLK_ENET,
+	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
 
@@ -172,7 +194,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 
 static const struct udevice_id imx6q_clk_ids[] = {
 	{ .compatible = "fsl,imx6q-ccm" },
-	{ },
+	{},
 };
 
 U_BOOT_DRIVER(imx6q_clk) = {
-- 
2.39.5

