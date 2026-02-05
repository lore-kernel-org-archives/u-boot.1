Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEB4ECD983
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAD783CB1;
	Thu,  5 Feb 2026 16:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="IGO22qXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E96F58341A; Thu,  5 Feb 2026 15:13:55 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9C983AA4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUKHpZWFRA5o7/ZIzUVQsjM5Hjx7DwVMUTVFnsPPJOoxidBzZUJkuzAEIHY8gHwAovnPniU/83CrBlZnbae6U1fFnXyAnaZxbj7aCe0kuWuKbbgywdp2VP6fT2Cegu/nOKf26jELodflEXEaCKWJOkB/oTM0Cw7kIXKoWTvFGjurszGVq6nEzTp83JVEoL0PLybzSIl520Kb2Xt/mvLcsg3/5VLeihBPuXOtoQS0pwkvL5dc8zVVaPIe8OBm18HCRKPW1jSj6yCangdKXTEInWgvXk79ZV+1Ktaalx0//yqc3fAHsyIbaOj0YIcRYeFT7obgOoa6J8QRLJxKSaixPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYtExfVOE840Ta+rhONLpy9bGztOUQeH8RxTaZbtWz0=;
 b=ycvFz9EKPAlSFcGjB+U+fQ8EmQTSpq+BeIlM+j72S6ziYZfRbGOvvg58raFapCqBtRlhVo30G+iHQLqV0bH+XTB+Lp/yTEhw6WXl942wa+eSBFnJ1Uoner3B8wgOpRmt9dNLK9T5YVkZb120hZ8RcqDPm/LD0om9TQo4+16BdDB2R6LB6T+IFp1DhAYkd3hbuvC53NhzAt+5Lee6xai5COtCXHuqSJPAH0/W7qdm8mAZLowa68Akkt8mY4RDGVVrFAETndS1PNoih6UxIKGRqeqfFkvcklI/ZhmZAIB5AD69GrU/QM0KTB0gRs++YfoaCdz1BY2Yy4yigCpkfBgrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYtExfVOE840Ta+rhONLpy9bGztOUQeH8RxTaZbtWz0=;
 b=IGO22qXABQEyj0ZYTs4nlGJ995wUn99pPPQ3pny16vM/UNyu7DGfZbtGGPdtgj7LhAxDnTk8miDqn5YNP/DRA0obryCXYisr1lHQ+AgArhRClAgbQydf6sWiXWrjPOQAnKKOtPBbIZjWzX9KuYfIYr1+wkWwsj9ySmQOfpXn4wooqpv/Wkz7PDT9APxsrYQIWVKXhB1CSeOGm58QfBmzi+5kJXwQUEqTyboQApvbD0LlMQzSTxJ+SrCTXXia9l5pjGH3Cj6IteUUQ43DWJKh0bRuiy+QV1jANnFQJJX2dCxZa/w2OMG+DZxu/CJ4ESLMI0p65uSDr2PAVsHok1kl4g==
Received: from PH8PR21CA0022.namprd21.prod.outlook.com (2603:10b6:510:2ce::7)
 by SJ2PR22MB4832.namprd22.prod.outlook.com (2603:10b6:a03:594::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 14:13:46 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5a) by PH8PR21CA0022.outlook.office365.com
 (2603:10b6:510:2ce::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 14:13:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 14:13:45 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 7A640F884C;
 Thu,  5 Feb 2026 16:13:42 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Mark Jonas <mark.jonas@de.bosch.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH 2/5] clk: imx6q: add ipu and ldb clocks and dependencies
Date: Thu,  5 Feb 2026 16:13:28 +0200
Message-Id: <20260205141332.2515996-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
References: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SJ2PR22MB4832:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7b03fb85-5861-488e-6508-08de64c0c660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Biv+tOErvShHlZy/icBhbbwxAi7b1hKs6kcEZi48DUhOpjpUgS3tARRGoGPl?=
 =?us-ascii?Q?vOLA0Yp2vZIvFuWT7Cvr/gkYPCWMVza2lmMN26KF9nOeKYHiPnHa0eqeA+ae?=
 =?us-ascii?Q?KddLcTWibKm6DavufevQKxvFkqza1v1pQme3Exne5MC6b+hPXTANR8ekOJSx?=
 =?us-ascii?Q?/5hR2oSl5vh4UzN1buQT8YGoxZwtg8q1CeHn+MmvRGKuKHatqVisLNR6R9H4?=
 =?us-ascii?Q?rdzkw0M9Hf5+77v7PEXZtpLaLCU3hMkKEWWXhjmOANVwjwvhmk+hiNEtJVwM?=
 =?us-ascii?Q?ySXd6EYdiEqaHIIrI6WSuPlN1qW2dJgN90VK9AyqOPHnmsjHUsnXTEVliGTp?=
 =?us-ascii?Q?7YhroAyigK1Zbe1TCbzYjxjIw8N5UaDo5J1ZWd/JPpXEgFEfV/7J6RPlrd9Q?=
 =?us-ascii?Q?5RmPmvndqZRzGBPsa9dKW0C5xVgrVfSE/MkuGdnozBBXauI0DNMklDg4An5w?=
 =?us-ascii?Q?Fs/kuYZb4dIahiFlL1BkPynTdpc4YA9nv8sqbfR5VibCqm54gNhZEECx2Oub?=
 =?us-ascii?Q?U+bO3FfCSAF08KLwFo92QyJZJ2xro+BWBN3ykCN++TVCJK8haG3u3e+K/jh0?=
 =?us-ascii?Q?sWiN3mEf1oEptpV5ZYjUyJaVQwMYuAOT+QEICgwynfiyjhHIBAvShw7FjoxH?=
 =?us-ascii?Q?p1bQjgVOsiznxSX+bEngZqnHE5Ew9AlytgPM2qV8XN9PNtPNc8OTExjTJdT3?=
 =?us-ascii?Q?LQWkLEP6QmVuCQe4wzVcEZUzZuLvIqLzp1vXgZP1+qPrb76+WzovYSfTnE10?=
 =?us-ascii?Q?/Z8oO6g5k39da2uQVsNIBNiG0U6BQ6rQ41WkS+y55ZkIbeQi+PyDn62I3Zmw?=
 =?us-ascii?Q?vR6ien/aelL7bH9DIMf8hakIq+0tdXLaGK2RYxd1kGA9rLZCvvLk1MyFD1vL?=
 =?us-ascii?Q?6qu9b1eW7TwuUj22vY6+UN3VIeRktcZA9v6yPzjKUTko7401wUaRUXgvCKgn?=
 =?us-ascii?Q?FH05n7fOQa9d74MfM45laXdMN2PHBLEj58uL8nFYtNQnycxsCIJPfoTYe6wP?=
 =?us-ascii?Q?AMTyfjZ2XvJB0Mhe97lF1FQWJm2z8bOtHjJNI6TdCUrjwgQT6i5G1fpqxeV0?=
 =?us-ascii?Q?IO6mKQXfHQOPpYsOC+/zl41zYDU7EVREvoeC6nHBTcjQQBSR+p7+jpysEP1B?=
 =?us-ascii?Q?cXYp3t0PR/9lefZJFDbA+5KvP8hN2h9F3tSy+jdl6aU6zNxQXbUqfzHnlUSu?=
 =?us-ascii?Q?jB6y5dO358jeAzDV0soB3EnnVT7hdT5clXrho9cW48SiiLEhT+v9PPP+nobN?=
 =?us-ascii?Q?3ZuRhtG0/XfTQ4t9+RHGjMM5o9mynXrDPuFhQKvUSt32CDNluQp/7uZZC72r?=
 =?us-ascii?Q?UDdR6UDchNfLjhfQLFjOj79sF6438LS4QtanoYLjDKBV0lvfH9m3YZ5JuLYg?=
 =?us-ascii?Q?6CMuBIkXzjeCtBZX2CiYHgDMtcJ18K5FcY0ddoy7/Qh/YrrGCR0ywC77bXWk?=
 =?us-ascii?Q?hnxtKF+Yh4NXlG9NWi2MF0S1uEXSi2Ny3Lq8DDzKOW3FyzNbo4HfqQGKDoXr?=
 =?us-ascii?Q?PpWiU7lymcKd18BIBepUcZTf5+P1ca3kIi0yRK3DcqecDBug3KCATHGqwvc8?=
 =?us-ascii?Q?zyGEbc/lKh1P0Mb4kOgCS9bNTubKoaQ8iLddTJZfQ3nmIypLX6kg0yCknMM4?=
 =?us-ascii?Q?5eOeNXr9YEUowC8JqNqTHkMamJnV+COwFDngXiuEX4NhpG/pvXm0DwKpwCfX?=
 =?us-ascii?Q?5blvJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 95nPZMal/zHzN3gNAss8SeGbpKvM+6W3WQxW//nHP95mBbuc6gr8fC0MBBEm0X7sHDeA0jFFoq6P2eC8a0NWyes+nx7B7UwRLLT+FsC38sXqHPKxj/B54xiG3iJdnQa1RER00PrkmMIK+to8yDclEmfDlx+5RtT1FYi2VjzBSlm66vwHl22huGizlx1KOICJZIB+dF69cxlLf2WJWhXH8cb9ErdW7Xftg4MINKQ8oJjPyPC3QMufBcY4EU5n6yk2lmsY2BIXQVOETiR7Hnj58PhSyXd1qaMk1FG/chGZ9v4DT3vFtxpg56FhSXo43t+pFX21WCQWdvHPQo/yLPQAMSkJ7HBwan94H7wsJLN4sMd3to9vqg7W66EdHlgXXj1bw9H4IlCG86tE+lGPtSVXHcSqW7KYaSBMc2pORBPxNJFuKAB4/dQA+3+NpP72zDVF
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:45.5677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b03fb85-5861-488e-6508-08de64c0c660
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4832
X-Mailman-Approved-At: Thu, 05 Feb 2026 16:34:48 +0100
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

This is required for the IPUv3 driver to migrate to CCF, changes are
largely based on the Linux kernel equivalent.

Add new gate2_flags function (also present in the Linux code) to set
required flags.

Add usboh clock to get rid of error.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/clk/imx/clk-imx6q.c | 320 +++++++++++++++++++++++++++++++++---
 drivers/clk/imx/clk.h       |   9 +
 2 files changed, 308 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index f11f9045abb..55c0426d5b8 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -13,6 +13,21 @@
 
 #include "clk.h"
 
+#define SET_CLK_RATE(id, rate)           \
+	do {                             \
+		struct clk *clk;         \
+		clk_get_by_id(id, &clk); \
+		clk_set_rate(clk, rate); \
+	} while (0)
+
+#define SET_CLK_PARENT(child_id, parent_id)            \
+	do {                                           \
+		struct clk *clk, *clk_parent;          \
+		clk_get_by_id(parent_id, &clk_parent); \
+		clk_get_by_id(child_id, &clk);         \
+		clk_set_parent(clk, clk_parent);       \
+	} while (0)
+
 static int imx6q_clk_request(struct clk *clk)
 {
 	if (clk->id < IMX6QDL_CLK_DUMMY || clk->id >= IMX6QDL_CLK_END) {
@@ -39,6 +54,10 @@ static const char *const periph_sels[] = {
 	"periph_pre",
 	"periph_clk2",
 };
+static const char *periph2_sels[] = {
+	"periph2_pre",
+	"periph2_clk2",
+};
 static const char *const periph_pre_sels[] = {
 	"pll2_bus",
 	"pll2_pfd2_396m",
@@ -53,6 +72,44 @@ static const char *const ecspi_sels[] = {
 	"pll3_60m",
 	"osc",
 };
+static const char *const ipu_sels[] = {
+	"mmdc_ch0_axi",
+	"pll2_pfd2_396m",
+	"pll3_120m",
+	"pll3_pfd1_540m",
+};
+static const char *const ldb_di_sels[] = {
+	"pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m",
+	"mmdc_ch1_axi",	  "pll3_usb_otg",
+};
+static const char *const ipu_di_pre_sels[] = {
+	"mmdc_ch0_axi",	  "pll3_usb_otg",   "pll5_video_div",
+	"pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m",
+};
+static const char *const ipu1_di0_sels[] = {
+	"ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu1_di1_sels[] = {
+	"ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu2_di0_sels[] = {
+	"ipu2_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *const ipu2_di1_sels[] = {
+	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1",
+};
+static const char *ipu1_di0_sels_2[] = {
+	"ipu1_di0_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu1_di1_sels_2[] = {
+	"ipu1_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu2_di0_sels_2[] = {
+	"ipu2_di0_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
+static const char *ipu2_di1_sels_2[] = {
+	"ipu2_di1_pre", "dummy", "dummy", "ldb_di0_podf", "ldb_di1_podf",
+};
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -69,15 +126,34 @@ static int imx6q_clk_probe(struct udevice *dev)
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
-	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
-	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
-	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
-	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
+	clk_dm(IMX6QDL_CLK_PLL3_80M,
+	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
+	clk_dm(IMX6QDL_CLK_PLL3_120M,
+	       imx_clk_fixed_factor(dev, "pll3_120m", "pll3_usb_otg", 1, 4));
+	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
+					       base + 0xa0, 0x7f));
+	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
+	       imx_clk_gate(dev, "pll5_video", "pll5", base + 0xa0, 13));
 	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
 					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
+	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
+	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
+	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
+	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
+	clk_dm(IMX6QDL_CLK_PLL3_PFD1_540M,
+	       imx_clk_pfd("pll3_pfd1_540m", "pll3_usb_otg", base + 0xf0, 1));
+
+	clk_dm(IMX6QDL_CLK_PLL2_198M,
+	       imx_clk_fixed_factor(dev, "pll2_198m", "pll2_pfd2_396m", 1, 2));
+	clk_dm(IMX6QDL_CLK_PLL5_POST_DIV,
+	       imx_clk_fixed_factor(dev, "pll5_post_div", "pll5_video", 1, 1));
+	clk_dm(IMX6QDL_CLK_PLL5_VIDEO_DIV,
+	       imx_clk_fixed_factor(dev, "pll5_video_div", "pll5_post_div", 1,
+				    1));
+
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
 	if (!base)
@@ -105,6 +181,19 @@ static int imx6q_clk_probe(struct udevice *dev)
 				   ecspi_sels, ARRAY_SIZE(ecspi_sels)));
 	}
 
+	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH2_PRE,
+	       imx_clk_mux(dev, "periph2_pre", base + 0x18, 21, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH,
+	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
+				5, periph_sels, ARRAY_SIZE(periph_sels)));
+	clk_dm(IMX6QDL_CLK_PERIPH2,
+	       imx_clk_busy_mux(dev, "periph2", base + 0x14, 26, 1, base + 0x48,
+				3, periph2_sels, ARRAY_SIZE(periph2_sels)));
+
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
 	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
 			       11, 3));
@@ -134,6 +223,192 @@ static int imx6q_clk_probe(struct udevice *dev)
 				       base + 0x38, 19, 6));
 	}
 
+	clk_dm(IMX6QDL_CLK_AHB,
+	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
+				    base + 0x48, 1));
+	clk_dm(IMX6QDL_CLK_IPG,
+	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
+	clk_dm(IMX6QDL_CLK_IPG_PER,
+	       imx_clk_divider(dev, "ipg_per", "ipg", base + 0x1c, 0, 6));
+	clk_dm(IMX6QDL_CLK_UART_IPG,
+	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_CG,
+		       imx_clk_gate2(dev, "mmdc_ch1_axi_cg", "periph2",
+				     base + 0x4, 18));
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_PODF,
+		       imx_clk_busy_divider(dev, "mmdc_ch1_axi_podf",
+					    "mmdc_ch1_axi_cg", base + 0x14, 3,
+					    3, base + 0x48, 2));
+	} else {
+		clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI_PODF,
+		       imx_clk_busy_divider(dev, "mmdc_ch1_axi_podf", "periph2",
+					    base + 0x14, 3, 3, base + 0x48, 2));
+	}
+
+	clk_dm(IMX6QDL_CLK_MMDC_CH0_AXI_PODF,
+	       imx_clk_busy_divider(dev, "mmdc_ch0_axi_podf", "periph",
+				    base + 0x14, 19, 3, base + 0x48, 4));
+
+	clk_dm(IMX6QDL_CLK_MMDC_CH0_AXI,
+	       imx_clk_gate2_flags(dev, "mmdc_ch0_axi", "mmdc_ch0_axi_podf",
+				   base + 0x74, 20, CLK_IS_CRITICAL));
+	clk_dm(IMX6QDL_CLK_MMDC_CH1_AXI,
+	       imx_clk_gate2(dev, "mmdc_ch1_axi", "mmdc_ch1_axi_podf",
+			     base + 0x74, 22));
+
+	clk_dm(IMX6QDL_CLK_IPU1_SEL,
+	       imx_clk_mux(dev, "ipu1_sel", base + 0x3c, 9, 2, ipu_sels,
+			   ARRAY_SIZE(ipu_sels)));
+	clk_dm(IMX6QDL_CLK_IPU2_SEL,
+	       imx_clk_mux(dev, "ipu2_sel", base + 0x3c, 14, 2, ipu_sels,
+			   ARRAY_SIZE(ipu_sels)));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
+		       imx_clk_mux(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
+				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_SEL,
+		       imx_clk_mux(dev, "ldb_di1_sel", base + 0x2c, 12, 3,
+				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
+	} else {
+		/*
+                 * Need to set these as read-only due to a hardware bug.
+                 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+                 */
+		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
+					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
+					 CLK_SET_RATE_PARENT |
+						 CLK_MUX_READ_ONLY));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ldb_di1_sel", base + 0x2c, 12, 3,
+					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
+					 CLK_SET_RATE_PARENT |
+						 CLK_MUX_READ_ONLY));
+	}
+
+	clk_dm(IMX6QDL_CLK_IPU1_DI0_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu1_di0_pre_sel", base + 0x34, 6, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu1_di1_pre_sel", base + 0x34, 15, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu2_di0_pre_sel", base + 0x38, 6, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1_PRE_SEL,
+	       imx_clk_mux_flags(dev, "ipu2_di1_pre_sel", base + 0x38, 15, 3,
+				 ipu_di_pre_sels, ARRAY_SIZE(ipu_di_pre_sels),
+				 CLK_SET_RATE_PARENT));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_LDB_DI0,
+		       imx_clk_gate2(dev, "ldb_di0", "ldb_di0_sel", base + 0x74,
+				     12));
+		clk_dm(IMX6QDL_CLK_LDB_DI1,
+		       imx_clk_gate2(dev, "ldb_di1", "ldb_di1_sel", base + 0x74,
+				     14));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di0_div_3_5", "ldb_di0",
+					    2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di1_div_3_5", "ldb_di1",
+					    2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_PODF,
+		       imx_clk_divider(dev, "ldb_di0_podf", "ldb_di0_div_3_5",
+				       base + 0x20, 10, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_PODF,
+		       imx_clk_divider(dev, "ldb_di1_podf", "ldb_di1_div_3_5",
+				       base + 0x20, 11, 1));
+	} else {
+		clk_dm(IMX6QDL_CLK_LDB_DI0_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di0_div_3_5",
+					    "ldb_di0_sel", 2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_DIV_3_5,
+		       imx_clk_fixed_factor(dev, "ldb_di1_div_3_5",
+					    "ldb_di1_sel", 2, 7));
+		clk_dm(IMX6QDL_CLK_LDB_DI0_PODF,
+		       imx_clk_divider(dev, "ldb_di0_podf", "ldb_di0_div_3_5",
+				       base + 0x20, 10, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI1_PODF,
+		       imx_clk_divider(dev, "ldb_di1_podf", "ldb_di1_div_3_5",
+				       base + 0x20, 11, 1));
+		clk_dm(IMX6QDL_CLK_LDB_DI0,
+		       imx_clk_gate2(dev, "ldb_di0", "ldb_di0_podf",
+				     base + 0x74, 12));
+		clk_dm(IMX6QDL_CLK_LDB_DI1,
+		       imx_clk_gate2(dev, "ldb_di1", "ldb_di1_podf",
+				     base + 0x74, 14));
+	}
+
+	clk_dm(IMX6QDL_CLK_IPU1_PODF,
+	       imx_clk_divider(dev, "ipu1_podf", "ipu1_sel", base + 0x3c, 11,
+			       3));
+	clk_dm(IMX6QDL_CLK_IPU2_PODF,
+	       imx_clk_divider(dev, "ipu2_podf", "ipu2_sel", base + 0x3c, 16,
+			       3));
+	clk_dm(IMX6QDL_CLK_IPU1_DI0_PRE,
+	       imx_clk_divider(dev, "ipu1_di0_pre", "ipu1_di0_pre_sel",
+			       base + 0x34, 3, 3));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1_PRE,
+	       imx_clk_divider(dev, "ipu1_di1_pre", "ipu1_di1_pre_sel",
+			       base + 0x34, 12, 3));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0_PRE,
+	       imx_clk_divider(dev, "ipu2_di0_pre", "ipu2_di0_pre_sel",
+			       base + 0x38, 3, 3));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1_PRE,
+	       imx_clk_divider(dev, "ipu2_di1_pre", "ipu2_di1_pre_sel",
+			       base + 0x38, 12, 3));
+
+	if (of_machine_is_compatible("fsl,imx6qp")) {
+		clk_dm(IMX6QDL_CLK_IPU1_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di0_sel", base + 0x34, 0, 3,
+					 ipu1_di0_sels_2,
+					 ARRAY_SIZE(ipu1_di0_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU1_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di1_sel", base + 0x34, 9, 3,
+					 ipu1_di1_sels_2,
+					 ARRAY_SIZE(ipu1_di1_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di0_sel", base + 0x38, 0, 3,
+					 ipu2_di0_sels_2,
+					 ARRAY_SIZE(ipu2_di0_sels_2),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di1_sel", base + 0x38, 9, 3,
+					 ipu2_di1_sels_2,
+					 ARRAY_SIZE(ipu2_di1_sels_2),
+					 CLK_SET_RATE_PARENT));
+	} else {
+		clk_dm(IMX6QDL_CLK_IPU1_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di0_sel", base + 0x34, 0, 3,
+					 ipu1_di0_sels,
+					 ARRAY_SIZE(ipu1_di0_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU1_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu1_di1_sel", base + 0x34, 9, 3,
+					 ipu1_di1_sels,
+					 ARRAY_SIZE(ipu1_di1_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI0_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di0_sel", base + 0x38, 0, 3,
+					 ipu2_di0_sels,
+					 ARRAY_SIZE(ipu2_di0_sels),
+					 CLK_SET_RATE_PARENT));
+		clk_dm(IMX6QDL_CLK_IPU2_DI1_SEL,
+		       imx_clk_mux_flags(dev, "ipu2_di1_sel", base + 0x38, 9, 3,
+					 ipu2_di1_sels,
+					 ARRAY_SIZE(ipu2_di1_sels),
+					 CLK_SET_RATE_PARENT));
+	}
+
 	clk_dm(IMX6QDL_CLK_ECSPI1,
 	       imx_clk_gate2(dev, "ecspi1", "ecspi_root", base + 0x6c, 0));
 	clk_dm(IMX6QDL_CLK_ECSPI2,
@@ -142,11 +417,11 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "ecspi3", "ecspi_root", base + 0x6c, 4));
 	clk_dm(IMX6QDL_CLK_ECSPI4,
 	       imx_clk_gate2(dev, "ecspi4", "ecspi_root", base + 0x6c, 6));
-	clk_dm(IMX6QDL_CLK_UART_IPG,
-	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
 	clk_dm(IMX6QDL_CLK_UART_SERIAL,
 	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",
 			     base + 0x7c, 26));
+	clk_dm(IMX6QDL_CLK_USBOH3,
+	       imx_clk_gate2(dev, "usboh3", "ipg", base + 0x80, 0));
 	clk_dm(IMX6QDL_CLK_USDHC1,
 	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
@@ -155,20 +430,6 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "usdhc3", "usdhc3_podf", base + 0x80, 6));
 	clk_dm(IMX6QDL_CLK_USDHC4,
 	       imx_clk_gate2(dev, "usdhc4", "usdhc4_podf", base + 0x80, 8));
-
-	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
-	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
-			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
-	clk_dm(IMX6QDL_CLK_PERIPH,
-	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
-				5, periph_sels, ARRAY_SIZE(periph_sels)));
-	clk_dm(IMX6QDL_CLK_AHB,
-	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
-				    base + 0x48, 1));
-	clk_dm(IMX6QDL_CLK_IPG,
-	       imx_clk_divider(dev, "ipg", "ahb", base + 0x14, 8, 2));
-	clk_dm(IMX6QDL_CLK_IPG_PER,
-	       imx_clk_divider(dev, "ipg_per", "ipg", base + 0x1c, 0, 6));
 	clk_dm(IMX6QDL_CLK_I2C1,
 	       imx_clk_gate2(dev, "i2c1", "ipg_per", base + 0x70, 6));
 	clk_dm(IMX6QDL_CLK_I2C2,
@@ -183,11 +444,28 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "pwm3", "ipg_per", base + 0x78, 20));
 	clk_dm(IMX6QDL_CLK_PWM4,
 	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
-
 	clk_dm(IMX6QDL_CLK_ENET,
 	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+	clk_dm(IMX6QDL_CLK_IPU1,
+	       imx_clk_gate2(dev, "ipu1", "ipu1_podf", base + 0x74, 0));
+	clk_dm(IMX6QDL_CLK_IPU2,
+	       imx_clk_gate2(dev, "ipu2", "ipu2_podf", base + 0x74, 6));
+	clk_dm(IMX6QDL_CLK_IPU1_DI0,
+	       imx_clk_gate2(dev, "ipu1_di0", "ipu1_di0_sel", base + 0x74, 2));
+	clk_dm(IMX6QDL_CLK_IPU1_DI1,
+	       imx_clk_gate2(dev, "ipu1_di1", "ipu1_di1_sel", base + 0x74, 4));
+	clk_dm(IMX6QDL_CLK_IPU2_DI0,
+	       imx_clk_gate2(dev, "ipu2_di0", "ipu2_di0_sel", base + 0x74, 8));
+	clk_dm(IMX6QDL_CLK_IPU2_DI1,
+	       imx_clk_gate2(dev, "ipu2_di1", "ipu2_di1_sel", base + 0x74, 10));
+
+	if (of_machine_is_compatible("fsl,imx6dl")) {
+		SET_CLK_RATE(IMX6QDL_CLK_PLL3_PFD1_540M, 540000000UL);
+		SET_CLK_PARENT(IMX6QDL_CLK_IPU1_SEL,
+			       IMX6QDL_CLK_PLL3_PFD1_540M);
+	}
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d14dbc395f..b53f35df84f 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -95,6 +95,15 @@ static inline struct clk *imx_clk_gate2(struct udevice *dev, const char *name,
 			shift, 0x3, 0, NULL);
 }
 
+static inline struct clk *
+imx_clk_gate2_flags(struct udevice *dev, const char *name, const char *parent,
+		    void __iomem *reg, u8 shift, unsigned long flags)
+{
+	return clk_register_gate2(dev, name, parent,
+				  flags | CLK_SET_RATE_PARENT, reg, shift, 0x3,
+				  0, NULL);
+}
+
 static inline struct clk *imx_clk_gate2_shared(struct udevice *dev, const char *name,
 					       const char *parent,
 					       void __iomem *reg, u8 shift,
-- 
2.39.5

