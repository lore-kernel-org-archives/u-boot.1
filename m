Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2483CECD980
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 246C283C6C;
	Thu,  5 Feb 2026 16:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="d6H0A0pU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B008341A; Thu,  5 Feb 2026 15:13:55 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F68838FA
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny0fYebdA6LLxwwMJ2vvVpPbTNwY2KzpBsy3x3SyFD4luVqnkP7yZzZglBszhjwE5u5kDKG/8p6nkc2F8lXH7mQ62Ho76dcyQgKXQoWokac5HYx2jeX5gksOvd7jfbsgQg2hoxo2lPCLEyxrsubVPlWJz724A3hfB5akqVgPZYlCn3U9UfzpyVPzAUoI1F7xdQVxRJ5NbMmBnJuTxdwvytjTdP+hMPh3Z0rk52P0ANcrW+ImCkQEivCHbuYKmbE21DXNtd8Fsgjy6x9YjHI+z5o0zT3t0evAlOzl42kxnekAiixEI+E0MDuOM7QCSAk5qsQ8JrfrEIC8ZfVtMjmcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92AV/faOJC/C7+RKQIYqDxpzVr69gX0aedYMo/O8jkU=;
 b=PqM0GUrF52X0eIqtlnONVV2+AKnUzM9KYABp+cElLWI+o+kOpcLRpsUIoUOG+LHW1NuFjLSgSxiDiremgv194lK5k/NC9xdVL65FFTpKUg8uzW7fLPQ1JG3EZDQtzoYnb68cvFqJQNoeMZc59jkRg+8MOm34FVhiwD2TOC9HKXW64wBMJw1knausmA++kFdz5dSL8pL7jvVX9E9tKo2P3tPixXbyQdTJZqAXDwn3h9UbUt3McRINFWvbCxTxRU/cdRGZuVHFwUZZdhVFGMdyQ8pRy149ga91/AiKXGL7HI771ON5dDCbAU0YIQ/PcOwxOhXPlO5HrzJLd7SDYGRLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92AV/faOJC/C7+RKQIYqDxpzVr69gX0aedYMo/O8jkU=;
 b=d6H0A0pUfz3SizJq+/L/9UQA92RCS0ezEzu/f4uE26Vl5m/MHfR09V0Kt3Ie91tEhDc6yHUwdUNERhvj9SYOuZWga9H0MU5mYjiQYvS0Y8P/pXX43ZbuiaRKwJaTHGVJmAI4ni/4h/tiyd/m/e+ePAAqE3z93U4LivFgHgID38BLZkabIkyCqNsFXulayoz1/bJrF74XAIlDzx+GqupMbqWHBxJB7L+B7fMJV/avC1awqgb50wLGHjtLwX+rRothgJOLYdS83bkHtGWi79qzy/Am8V7moibCSCeMRx/MrxYQht4l/CaxhFmJ1eSw7L7Bxxp7RxEKr7Jz5S8NIej2MQ==
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by SJ2PR22MB3846.namprd22.prod.outlook.com (2603:10b6:a03:504::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:13:45 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::5e) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.2 via Frontend Transport; Thu, 5
 Feb 2026 14:13:45 +0000
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
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 14:13:44 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id C73D8E8F47;
 Thu,  5 Feb 2026 16:13:41 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Mark Jonas <mark.jonas@de.bosch.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH 1/5] clk: imx6q: apply clang-format
Date: Thu,  5 Feb 2026 16:13:27 +0200
Message-Id: <20260205141332.2515996-2-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
References: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SJ2PR22MB3846:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3a8a35a8-353b-4cb1-1c11-08de64c0c5d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?weOPBc8ljqUL3ot0FCz/i/HOJ40Kq/WauDbRvEEzUBd8Wm9Khveo9UiYq7DX?=
 =?us-ascii?Q?2ookd7+WQPUOXq5e7OfaUJcFVFyXdBzgePFb9k1gJ6djcCD+NdTlrWwQPPLI?=
 =?us-ascii?Q?isQbC0m8vTe5NXFS02n8qKRt8AJVlgwc4OSIdOWrfpNIQRhakkev9boqXjBG?=
 =?us-ascii?Q?YLift5UmrdfkYQMForYERf6OY7kxUjdKkcKWxAV0/XgNze+SBf2P2qztTuRn?=
 =?us-ascii?Q?wp1tyVVjxrooALeIHH10jaViy3SY2+dZMGJxJkeiCtJCIUX+xRB265O3Tssv?=
 =?us-ascii?Q?+E2UiF945zaas8eVqKHtvJnByOpT+RgeE2d8LimDge9pfIYcEwjARL39uV42?=
 =?us-ascii?Q?Ey2dbVk1APBeTJFtEnLJ5tuMf8I0frqbY2Ki/bQxK7MWUuVE5HQ2ehO9M9Nr?=
 =?us-ascii?Q?xNpt4+Rw51E8eDfKzKrFiZNyjKFHbAHJuUp5DRwO832poKXGmrBoCVbm+FLS?=
 =?us-ascii?Q?uU0anU+mQ9pDkyzwaXBwWD+IJUGfJUwCqIDlQ8zK1JEh1sWTeGpsubz7jObj?=
 =?us-ascii?Q?hXb1yz8BXL7rtTfyeRZGVQhocl8VOxgpFjpIwL42J40hdpTmfDpr/8dD8Ujk?=
 =?us-ascii?Q?LzMC0Dy+VoGSap41WLoWBLecJxldhcteDzg+YaVYqreoy8fABzgGEZgAsL5h?=
 =?us-ascii?Q?KFwR1H2KjFVAKReAd9BCyieFWGzbHQFygoDHnRpk3zPutMSK92Pg//E9I1Qq?=
 =?us-ascii?Q?4lWTMos1k+ycV1edgqsIeGZaE2+K71p9mYxVJtRH/9lYIQc4B/TM5kYxYyNX?=
 =?us-ascii?Q?LF9c+qAPptVPsWFv8yMyd2OeQVk1qpjc00xW9v5IDNdLKZjKbHSigCetnwaN?=
 =?us-ascii?Q?wdVdV7Yq86EoBXGwr9odbAYMYR22uRWW35QvhXid1tOLQdTCfwr1nm4BPQgC?=
 =?us-ascii?Q?dFfoMsrC4qBsKYvEIZUItMuVR73fN49DEL6sLGgzu9Vj3L/5D/F2ZWj3y16D?=
 =?us-ascii?Q?28o0XhLTyKQ9sADVFxqhe5IBTF3SWXLszL+VpCXSRRtiCK2luo5qgfJ20FuH?=
 =?us-ascii?Q?I7z1AMUj/dxf7BfMO4HtP32N2ELdKuwuDeLDllBSCVHRw7p9xSxqKfbfSJn7?=
 =?us-ascii?Q?8BvtxDdsV30ajKcIsXHQZMGVDPzKOHeBJ6q2LtmMvhFgNJiisdpjytFTYJ5V?=
 =?us-ascii?Q?/LMYzWJQrDqgIm9+u7+bQwzMQeH28c8gKcII8kZIakF6UM2dXjCIjuKda4vO?=
 =?us-ascii?Q?czvPt/S3EjEpu8SEp/71PIqhd8fKFrozXjEGy/x6zvewRYDZW1ZStehz+B8O?=
 =?us-ascii?Q?8TFROEKrE8edjmLlAwN3TWLgcPFKcIzEvLHscFWMiGSagPLEN6CE/3Bdtbqx?=
 =?us-ascii?Q?PhDGPuWWtHUifM+DBUiGt2Qhv7trWdL6uyURUZbwrsLERowFgVKaN0fBjL44?=
 =?us-ascii?Q?tGYq8iV089GGhlG31H3SvhI/Z3HDDneD+2Tc9v9TF1TMryIeZgvViLs8AOp2?=
 =?us-ascii?Q?iQZyTxOIGolmfGPL9mE/qOGMLE/b4PzFb/2cknV6fi1mmtc+Sj7oljh1Tffg?=
 =?us-ascii?Q?41E9O84LEEqrpJRNzMX963ohfRsrQAhZwYKtyYeK2E1Psx1pf6HWrujrVzZr?=
 =?us-ascii?Q?eI5e/SYEF4WB2mi/n2bOiCbH9JrYnrqTriVzCv61M3rVp5o1myc+6oJvSWR6?=
 =?us-ascii?Q?Hrr9PBhvMKPebOKyTUcX+2g/GZKJ/lkTNAu06pUBJ/3hJ04TgOQtjkCjN4HP?=
 =?us-ascii?Q?DWUqxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2tIckvxA1G8Edg+St510GvpwWGCvnX+hiXLwz7bsPobVS6mWx/uCBzsXKxJcycybicdxSFOMcHRbORdQaR3wiPUY2lKjRuq3dHJqS7c/BuCf17uD/vYy2S4jrDpP1SBkM+vtfF02TQZCKq9uvi1ZkJ0RONL29sGIDdrnlWkVBqmyUMMLbHNw2TCr0n9pS9WqnVo1jo17Ht9VEKcrVQLVeOKFSC/g3ylof9Vtzx5v41H5oMBQUWsxWhXP4TIRvW2kzflRlwLBrB8Vtrmw5no67MqHhSPM629aLgyXRNMtJ7f7s43qO8a7JsJ16eVivz1xeZVwt9WmA218Tvhxs7Jq+yf52D7vdUkh/5lTpl/OE90Pe5d0/Qt48pfJUBm1biP0T5yHYGTojQRyyfs8WnW/MSw3CO1VZWUiAvxFNwSvlqDvfAVPsH9aGf0mWWEpo/Od
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:44.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8a35a8-353b-4cb1-1c11-08de64c0c5d4
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB3846
X-Mailman-Approved-At: Thu, 05 Feb 2026 16:34:47 +0100
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

Conform with U-boot guidelines.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

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

