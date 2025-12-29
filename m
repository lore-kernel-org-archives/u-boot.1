Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC14E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B25683DFA;
	Mon, 29 Dec 2025 13:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="BeAOpVpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D27B83DAE; Mon, 29 Dec 2025 11:49:00 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D967A83DBF
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCBia17ySjaPx6wXoU8u6C91fQsZXzzpayy+ov40YlYTTrHZsF6SeAo6kyvdPvLfFaYOl2ohD0EMB2pRwUjRRbm+7fjGnIvD0fZbKiS3HxSNWHqVvtCMSb9jZaqF7IauuC65LevNE/BFvjIhDTHID2v7OhEs8aKdeFQXQOvFpVsAj/CZLfa1iVtjDoboWK7dTOl3k7iKq0PrlANh9VazAShwjCgdSWCZa8FUXPbcYrnD5qxKB1RQyi5nwG3Gw9QrquWAewduvWAAJw9At44yZC9eB55GnXEj/htxIrGQV1o/8W/UCbPJdHHhhb3zp7DXqsMrjXMABlgiWIcHgv3wPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDiVT/HKi+WyYoTFEfc9djQdzBMzs8Z8GFO8mFakGRk=;
 b=uLI7eR1ZkWH15WCQg7hA42X2RoJHXBMNuxu82sWcJCPLog6YdNgdLnB/mofHalaGEsCEKN2tv0dfd0q7M2PhzJQdKd6WFSsp9Al/fVp5aZ1Gdz2bhE5GhDHcZU7wMYmX19La+7QMIE0C+jrZ5opt3Uyd1gyU7qivnOFy2A+eoRjYE4e2R/HVW6dWEISevSlzZQ1+t9yNs1ovdKyeM24mOV8n2EOXfVy2IUjDzdD3wHOS2Xkm+rAU0icnx3QvVZUbRTzn6Rcokeyh+wR18I3X28Oo2nfeMJ80dXx8Zn+oCNcPjJeVwPqAliAryvLnWncx67ydTEeWUJp9ecN1VvQsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDiVT/HKi+WyYoTFEfc9djQdzBMzs8Z8GFO8mFakGRk=;
 b=BeAOpVpB+ekDmcYgshBkAgVxPDumSGOQXryZuHJbSq3qrahHd4Q2jjKdY3W5A9YieWmeiDJ3Iw53QPFdI2V/hNIZCB1mrycljiRH9FxSjLllNMk8kwR0YuqZNvLWQbHiyta6/1i6DToiHYt2rwKg9dWjjfA8YWSOV4OsDW28e87vH63MnaAXm+NsX/B3faxrN89L0QVO7X2EojQbLjTHTFozdWyYO41Ikh4C5s+T4RecdQEowD0dDcHHn46TQ8ZhhCYW0Mt7imofV5tlv7f28xv0ehjsSg2n+r6dwO/vsiZxmQF/XjtQEW8HxUbNCMd3ziNn0AybTygbczb+Hzvoyg==
Received: from PH7P220CA0161.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::20)
 by LV8PR22MB5947.namprd22.prod.outlook.com (2603:10b6:408:266::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 10:48:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::be) by PH7P220CA0161.outlook.office365.com
 (2603:10b6:510:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 10:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:52 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 9F288F2E5C;
 Mon, 29 Dec 2025 12:48:50 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v2 6/7] video: imx: ipuv3: use CONFIG_IS_ENABLED
Date: Mon, 29 Dec 2025 12:48:06 +0200
Message-Id: <20251229104807.3104-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
 <20251229104807.3104-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|LV8PR22MB5947:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8470c5c9-973c-448c-fc50-08de46c7db7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nYRs7s5+ULRyfoFsazGKK8xNi/bkkj5/EfBRzuDLO9cYYLmbzTuh5ghcwds?=
 =?us-ascii?Q?oFDkzXF8Si7/DBcQKKE/yYo0aMhLzdGf3ZuRQXBMunqGFmZEbsC+U5BTZK/B?=
 =?us-ascii?Q?zhFEPY27EFcMUMlyOCempqcMeHCBGIo1kbGBoZlsma2s1B08wY9GhWvuygvP?=
 =?us-ascii?Q?G6+EKxpZk7Q7yDnrsB2VXpNvHJH4y+kFnxjFZg2RCUXnem5aqwVgL5K/JjUk?=
 =?us-ascii?Q?fL9Ojuxx3hxHcSOCxp/UehFzd4mjcn3m1U7nBaqALp9/oRMyUkFN8epmV1kg?=
 =?us-ascii?Q?FcXBEc39QCq3smc6NORmbcb4ImzWd2TKVU01Cw7XI2kBFTJdxlyjU5rPkRA8?=
 =?us-ascii?Q?E69STOeqgdPsYgx5OqNZyiModP0l5oGAeThLdSiVmovC4uDV4y3OEdXV7iM9?=
 =?us-ascii?Q?bPHts2Qr1JZGjy23EdWbkiAzeD3Om2iSC7yHFnLZp4xYO/Fe2TZVymwEqLk3?=
 =?us-ascii?Q?VScnvD0Ecu+OqAz5nbgBiGDD1QypKX+1cVP5CAHbilSswTNRL5i4O8KqCVDw?=
 =?us-ascii?Q?++UyWx5CVGie5v8Fkr07D4mIPLXrV4TXhXZz0TO5R1OgcEPdHRlvPrx5Y21p?=
 =?us-ascii?Q?5BRfoXNrnzE4ErOVooaQZmzCJCOr2iXKouVhHWVmsZ90T9yZ+DtBihuAb8Xe?=
 =?us-ascii?Q?bd3UfUJQexYsB+c2k/dHCdmOI3libqNki0sVKCqq7zcanpnvMeZqTCx2Pugh?=
 =?us-ascii?Q?GoUFXuf4WO7EATZSd3v7PFHsDDwpYT39X/7AF4T0u0LqVqCQWmJVCbD8Sm/e?=
 =?us-ascii?Q?u7k1WGyCeEJ4yO2H2J2y62BO6bMvCb8jYlygNZBTC6MuPRwRciWRZpw5kiiw?=
 =?us-ascii?Q?MNNr7IupFTBGT/2iFrIyxthttI9lJPG0WsJ3iNQO5mzIwioBvGL87xK/7vHS?=
 =?us-ascii?Q?stNiS91BRw6NHa/zbQV84MVwReVIdoGgZlj9mSt906F3MN+9EU8flqNVQgsm?=
 =?us-ascii?Q?0SqE1uhFQ/9jLdTjbHxqNIJ0DrVJvzKHlp1JB8HtZWNtSvxEz4bWSs4Vivpj?=
 =?us-ascii?Q?JgXPXrBxMUY9bAXDXI58TUHUSKpOa2xDdyMSxORygjCnfQjlqANV0ZTJmXuW?=
 =?us-ascii?Q?B6XxmlIGwAAtpiCOX8WgASY5dqD9LHaLl1yVagX7Pem/ioCfXwzrBYPgE0LP?=
 =?us-ascii?Q?gm8dmaSpMV0vSiFnj1GIuxkCF4JPtHvTyWJ4mPKoivm5pQMBvv80DhYa7cNM?=
 =?us-ascii?Q?YZQLQrTWEarvLBvb2HtrSiZd+7tXi9xgSvwYwZ0A8QVEMhliEUjqJ3S8uGiP?=
 =?us-ascii?Q?UtBmtP4Ztco4tJ8KeHYWKZ+TTQI+MhP4qYGh8NNkOmSZOJiuHa1k3KelSOoF?=
 =?us-ascii?Q?HcFHshHjGU6jtHyi6Oy2/7JV274LeZB/Y81sOMpB7VhOnNFGPrXxCSqfu2gc?=
 =?us-ascii?Q?f/p20VdD28UyykLQN+SbHr5uTanLzWcaBt9uKQ6WXeSErRPQ/K0VaCp9nkF4?=
 =?us-ascii?Q?OyN5kF6XZuc/KkNB8CvCUPQSTA3RF/JlsuX3npu8ETSUuhQXTrpsRdXyxV3f?=
 =?us-ascii?Q?9+zeg7xF3DGe4vSFBqxduzZemGBWSjJwXuS5KArOVcvTyhgwxhZ1ud9PuKKA?=
 =?us-ascii?Q?PWsmIhLePIBhfFQFrx0=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:52.6140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8470c5c9-973c-448c-fc50-08de46c7db7a
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5947
X-Mailman-Approved-At: Mon, 29 Dec 2025 13:40:49 +0100
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

Bring driver up-to-date with U-Boot conventions, but also takes into
account SPL and TPL, let compiler optimize while keeping code more
readable.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

Changes in v2:
- Fix unintended spelling error in comment

 drivers/video/imx/ipu_common.c | 11 ++++++-----
 drivers/video/imx/ipu_regs.h   |  4 ++--
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 6ce44e42349..560ee89f0f7 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -168,7 +168,7 @@ static int clk_ipu_enable(struct clk *clk)
 	reg |= MXC_CCM_CCGR_CG_MASK << clk->enable_shift;
 	__raw_writel(reg, clk->enable_reg);
 
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	/* Handshake with IPU when certain clock rates are changed. */
 	reg = __raw_readl(&mxc_ccm->ccdr);
 	reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
@@ -190,7 +190,7 @@ static void clk_ipu_disable(struct clk *clk)
 	reg &= ~(MXC_CCM_CCGR_CG_MASK << clk->enable_shift);
 	__raw_writel(reg, clk->enable_reg);
 
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	/*
 	 * No handshake with IPU whe dividers are changed
 	 * as its not enabled.
@@ -208,7 +208,7 @@ static void clk_ipu_disable(struct clk *clk)
 
 static struct clk ipu_clk = {
 	.name = "ipu_clk",
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	.enable_reg =
 		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5)),
 	.enable_shift = MXC_CCM_CCGR5_IPU_OFFSET,
@@ -485,13 +485,14 @@ int ipu_probe(void)
 	g_pixel_clk[1] = &pixel_clk[1];
 
 	g_ipu_clk = &ipu_clk;
-#if defined(CONFIG_MX51)
+#if CONFIG_IS_ENABLED(MX51)
 	g_ipu_clk->rate = IPUV3_CLK_MX51;
-#elif defined(CONFIG_MX53)
+#elif CONFIG_IS_ENABLED(MX53)
 	g_ipu_clk->rate = IPUV3_CLK_MX53;
 #else
 	g_ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
 #endif
+
 	debug("ipu_clk = %u\n", clk_get_rate(g_ipu_clk));
 	g_ldb_clk = &ldb_clk;
 	debug("ldb_clk = %u\n", clk_get_rate(g_ldb_clk));
diff --git a/drivers/video/imx/ipu_regs.h b/drivers/video/imx/ipu_regs.h
index 8e57a2add69..21bdff9363c 100644
--- a/drivers/video/imx/ipu_regs.h
+++ b/drivers/video/imx/ipu_regs.h
@@ -33,14 +33,14 @@
 #define IPU_DC_REG_BASE 0x00058000
 #define IPU_DMFC_REG_BASE 0x00060000
 #define IPU_VDI_REG_BASE 0x00680000
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 #define IPU_CPMEM_REG_BASE 0x01000000
 #define IPU_LUT_REG_BASE 0x01020000
 #define IPU_SRM_REG_BASE 0x01040000
 #define IPU_TPM_REG_BASE 0x01060000
 #define IPU_DC_TMPL_REG_BASE 0x01080000
 #define IPU_ISP_TBPR_REG_BASE 0x010C0000
-#elif defined(CONFIG_MX6)
+#elif CONFIG_IS_ENABLED(MX6)
 #define IPU_CPMEM_REG_BASE 0x00100000
 #define IPU_LUT_REG_BASE 0x00120000
 #define IPU_SRM_REG_BASE 0x00140000
-- 
2.39.5

