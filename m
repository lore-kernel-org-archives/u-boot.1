Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C569EDF161
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A57A83DFF;
	Fri, 13 Feb 2026 14:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="S2nIq6rt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8EC83B9D; Fri, 13 Feb 2026 09:50:15 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F8D83DBF
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFkPqAEAbC6IoArOZdVMxHfRfnVqunotDQLcDRujn+FQd+JsupB0YZe5/d+B+XbRxOEa+w6Heu1YSe8YElJ5qeMz7KE+uRSvf275/zk1dpJtZjxrdqqLm6YXrDRIxb/WNJWSJBNgYMtpcxNoEFfcbk7u+s/OteyFHPWkAl7SJN3+fsAbxAhT9Pn1UYIuZo0c4whvqF+h0AKSXHNRI9+8QkcQ+9jrMY5MX81QAZ7uQJE58/XAqjN8xJxdlEP/9YQIdzYUQicg6NpedUenf3+W1Zi2wTeYgqATIUxoyiZcS0ON50AcbxE9UJnilN0D+06aa0ZVAQC0Cs4fF1uKr4dcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeC2V1tUC8V0M+FHBFAfVAHZAErdJDCtHCwkiAlBmaA=;
 b=OcCJ4P61tjqW9MbNyfaJBrQavK3Jb6CZPXuArUA/FfVJUmCSu4rytwrYTdH+ej2/aAJsDaxTSpM3ljTPkoWeKDuLKejD5GxjJklWFEf6J7+VhERmusGYF7FmESR+hN5DGP1KflpaVeC2m20qQ5njQc5rjCx9ZeppvGusRs4SiiPY1aXAwePkI8r1qIY+IXxmmas2G/1CvJcRJvJsVFgByXEsk+RujlwJoCjov4XDUn2eFsAu5FuFFzLEreyUhecJyFlBVJ37Wnblwxuo+LXsJK2d64oCb4cRmhcL0J4cZ/FI95OA34m0xCU7UPqV58pViHthPFlYAXiKIXHZd36XkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeC2V1tUC8V0M+FHBFAfVAHZAErdJDCtHCwkiAlBmaA=;
 b=S2nIq6rt8nSFuTPidoq2Pna9/5MclDpUSIA+Ty7QvVmRozYPZ8SLpIwV2yfpi0qxEM+HFMpm5XlaeShwa3KbcsdkSZkwjIKPZrVsZfApkweX5jXPx94F+7j4ENw62j64FYqniLx1F1fb+23JOfSJRJAoXJ9U8B6k4zK1BErLySyjjlKM0MvEaMpEBN9thdd8moYDWhY3XZhc1O5w2rbXR0TZTfN0dEyc6LC8jaBBjiUkvrhgLfiokGpW4VPviGdqh2Ob9wTWRzpbZOl7K7hIPgiDwLGAzvV1dA2K+I9Z3sJQKZLD+al9+A8xMrBThMXs8LQLftghSuIqpY+f2HrYvA==
Received: from CH0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:610:b3::25)
 by PH3PPF44669FFFD.namprd22.prod.outlook.com (2603:10b6:518:1::69c)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Fri, 13 Feb
 2026 08:50:06 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::36) by CH0PR03CA0050.outlook.office365.com
 (2603:10b6:610:b3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Fri,
 13 Feb 2026 08:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:06 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 8717FFD310;
 Fri, 13 Feb 2026 10:50:03 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH v3 3/6] clk: imx6q: add ipu and ldb clocks and dependencies
Date: Fri, 13 Feb 2026 10:49:52 +0200
Message-Id: <20260213084956.1031000-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
 <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|PH3PPF44669FFFD:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 57068064-f743-42be-2e92-08de6adce2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PdHPaI+5v0Y6bf7i3ZYA38Rqbx80ABIJEXM3cXoR6dGezi5pBmrvqzyvsyS1?=
 =?us-ascii?Q?fwxksWbs9hDIFdoU2AKGr2syG9vO0RUz80uZsmxbARnmYCpc8R77A9LNLmNh?=
 =?us-ascii?Q?pZoaifZbR/8Y9MHI+1koINdE8+rkY+vFvwpYt0XnotYNCzvEjwVA99PS+3tP?=
 =?us-ascii?Q?jK75w/TEsoIxqXmfeMjSCpe5n3WUZnBy9jLjYzFaVNWbVr2syTjtF2vzJxK1?=
 =?us-ascii?Q?pAtMUnpn5+nwG30CgijodtuXja2Q5t+dKRif2OGM+tf/US7yYBcF7fsHjOjz?=
 =?us-ascii?Q?KyrsV8o1/QFju6rNICY5ev5xrb3IodMOCszamxnL0lqG3ezfi/Qfm3QerHXM?=
 =?us-ascii?Q?z1ZPWOdoxkGrPjCIHSsNPxNtE2ruI9tsmqLLyUNgTBTi7cbSezBCjqgp99Tb?=
 =?us-ascii?Q?hsplfcntMCB3F9MmGjuHjf5PrTOS3nSH+wfvCyxt+emEYsp8LfqwUdYZCjzV?=
 =?us-ascii?Q?5FZODQFGcCZYmbHDcORIkrenwi2FzgdzDFYcDLz7azMlIYXMweOFfBzRMvml?=
 =?us-ascii?Q?tPNpmcK5l8BRAbFEHkKJr/wAnjc2dn0bB+QLSAJLT1Gz71b2SZ1pGOjT7voA?=
 =?us-ascii?Q?C1CEOs/vqTxRTUfPi91TtX1S0ee4FwEYYgTTa6NEHuCHAJ2blEv9BiRxfTE9?=
 =?us-ascii?Q?bUMueaZcaP5Uqe/Xz+82y7qNK70LTvgGiRYFkSCPUoY0g4t4DWQiEcUEjNNn?=
 =?us-ascii?Q?hCmHL+r++/1KG5qbU2zP1H5K/qUJCbsPeBy86AlWT7aF7H+8zx9DkS3Da7eX?=
 =?us-ascii?Q?2M7A6XZ4eci8Yb4iQnBiPupTYG87Q0pBW5u5ZxiuC/vomT1FAapjopAtCSCy?=
 =?us-ascii?Q?qk0A6rETHrYufP8ezu+htbr7hLOB35LF69Xq3NY7818YB1cmgEt4v907jWrG?=
 =?us-ascii?Q?uW+MDYyHeu3Qy0iVI2ydwQVYHx8gX7r/2RXdxxSrPXH9hlLjrh2Fx75gmBn8?=
 =?us-ascii?Q?Xq5epp2a74/Y8wijj4RZJI9IZyjB9dUTLVGEnV1KxcC6UXEXOIOIKUGiu4jA?=
 =?us-ascii?Q?1MtGZn1GNKFtkaJzcpgqXxf7FmL65QLbELxR8/HE5oo6wMnG/qyU829no/Kr?=
 =?us-ascii?Q?jbhGdyVcBsbDKNCEh2Abw983OpUALybB567vVQBUGPbldvMgZd0xqrVrzyjY?=
 =?us-ascii?Q?yeIOJMpr22NuO36zWXTEXxcEaUdsz7U3nGenGFD8+4sONUexcRBJkLH/qskX?=
 =?us-ascii?Q?II0K+A6T4XTPHRgGPuQ0w4dSZGBEcxYLFj6C8f/BGbUYIsRSQcyD+iT4KH10?=
 =?us-ascii?Q?MnU4z7U3Wmf6rEHPbHj4k5PUMBLxh60x3bhi7Fi9lmQX93dhcZfjf5U04Hi7?=
 =?us-ascii?Q?vtJCyQ28MtRGXGaC4wMRJiyD5lLpBNSnYzcsJO3OOmXDYtjWgTGkgWelb7l6?=
 =?us-ascii?Q?5h1te2S0rrcOTtPc5Gy913O2dgR1VxMcedpxTOwv0fAy9a1IFfM277dvnQFQ?=
 =?us-ascii?Q?Qpcw51k1IqTOLEcAG+06il42DOBi4IYsoFaDaf07v/8Y/2g2Hd6+wNG7U8yz?=
 =?us-ascii?Q?2EMmgVM5ACojXlun0vrY+HJfYnLBntgMQRzL0LuqIF1Qq/mgYt86BZ53oMMQ?=
 =?us-ascii?Q?ffWOxnFJZMItyPhJX12CQeaz/+IRNGg7RF78WFm4eBzktANA6XukIDxZC/CV?=
 =?us-ascii?Q?DLS2AkgGudqoqY2IjVGDKWfrIlSCxlVvA73xj9G2U+m0KnoLFbP1UpFm2S01?=
 =?us-ascii?Q?iOf9Ng=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MxEZgLNAJ6BntE3EE7DjjfUgtQ7SURXjyozY8IsqzusKexodHgKGynd/dOKnyDirJMYhpPI7v6f6dATM7v+scughr7x1lZi9IFX1kymjny6Lb7LYY5otoWZ2MEFAIs7orUvvW01Rs14pVgZP40OI67M5VEx2+9ofPA3uA6Vk0bmguIEHks3Mr5a3OHkeTz4kHcJ5liCbenAqbMA5t4E/k+8W47LTblZqw45PIflKOR2ySNiKE7BsHyTG9sRlBaDsqI/MEacJz1RN5pzuYpukdpRui0Ux9wCuVrAMb8sZkvkWJ6Eu9PgiHwr2UaA0nZ30+/eo6xJlEwBLJ6Y6ujmJ5uIIYb5mjvbljJbWBoSeFMbf5mJEF2t088ndBk8s5aUrh4e9FRpujLzRnhG5ENeNWFtqQ1UWvFyijpdNzRS0P20X2e79UspWTSr42vtzevdk
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:06.1739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57068064-f743-42be-2e92-08de6adce2c2
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF44669FFFD
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

This is required for the IPUv3 driver to migrate to CCF, changes are
largely based on the Linux kernel equivalent.

Add new gate2_flags function (also present in the Linux code) to set
required flags.

Add usboh clock to get rid of error.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

Changes in v3:
- Added HDMI clocks

 drivers/clk/imx/clk-imx6q.c | 334 +++++++++++++++++++++++++++++++++---
 drivers/clk/imx/clk.h       |   9 +
 2 files changed, 322 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index f11f9045abb..f57ac79f8ca 100644
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
@@ -53,6 +72,46 @@ static const char *const ecspi_sels[] = {
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
+
+static unsigned int share_count_mipi_core_cfg;
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -69,15 +128,37 @@ static int imx6q_clk_probe(struct udevice *dev)
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
+	clk_dm(IMX6QDL_CLK_VIDEO_27M,
+	       imx_clk_fixed_factor(dev, "video_27m", "pll3_pfd1_540m", 1,
+				    20));
+
 	/* CCM clocks */
 	base = dev_read_addr_ptr(dev);
 	if (!base)
@@ -105,6 +186,19 @@ static int imx6q_clk_probe(struct udevice *dev)
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
@@ -134,6 +228,192 @@ static int imx6q_clk_probe(struct udevice *dev)
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
@@ -142,11 +422,11 @@ static int imx6q_clk_probe(struct udevice *dev)
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
@@ -155,20 +435,6 @@ static int imx6q_clk_probe(struct udevice *dev)
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
@@ -183,11 +449,37 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "pwm3", "ipg_per", base + 0x78, 20));
 	clk_dm(IMX6QDL_CLK_PWM4,
 	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
-
 	clk_dm(IMX6QDL_CLK_ENET,
 	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
+	clk_dm(IMX6QDL_CLK_MIPI_CORE_CFG,
+	       imx_clk_gate2_shared(dev, "mipi_core_cfg", "video_27m",
+				    base + 0x74, 16,
+				    &share_count_mipi_core_cfg));
+	clk_dm(IMX6QDL_CLK_HDMI_IAHB,
+	       imx_clk_gate2(dev, "hdmi_iahb", "ahb", base + 0x70, 0));
+	clk_dm(IMX6QDL_CLK_HDMI_ISFR,
+	       imx_clk_gate2(dev, "hdmi_isfr", "mipi_core_cfg", base + 0x70,
+			     4));
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

