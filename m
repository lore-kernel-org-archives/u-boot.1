Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE52AECD980
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 058BE83CE3;
	Thu,  5 Feb 2026 16:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="dYVNo8F/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B02838FA; Thu,  5 Feb 2026 15:13:59 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EAD8341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJS4jWVVu0gxMLaM86Qz+dO//qgwlRlDy21e9Jn+Y212gqAGNaPFuGs5POtLhsFgNuR8l8R9m+4ZPa6nXrBpRB7i90i8d//HisCxR2jiEeLhInzzog8bj/xZp+O1KcZh0AvHijsqCVBUtmXgVrldmwx1tSdq+ZQClbv5/y5ZH3YrCZp5uXnemKg6X6PH+9vulOvh/HET3iV1jE9YwbuTKUstoF/fTNE7PuFRyi6aK25kpqL4GmsqYrc99HXHP0Vqd0s9G3VBuFxLPmuw5kflWhvA5tu14YpZ9C8XQixCr/+U2xPU2NoCrFPsN5nREMaPbG6U2ysg1Pr/gWkpB2TSrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYd3AolPNKg7JRtnbztM1zbmBlTe61fDo1wSAPO6ccM=;
 b=Qutr+Bj+SJiBIKC3eJCrtVp89iTc5F1GCvcxjRAfnUWlU9TVQP6hxJGqzlK40zMrNENjQQei5HCP5pOsM+qJxILcS1uALD938y7LCqHGDwQ3G5cU0rTgvLXmdAnu83sGCk642ABiaKS10dy8hiih/Vla3/A1mnPW/jQmCVSebTYWVUeG4rbqeuVhQOw6suf5+FiLLlJaiTy2fIgN1jic0nEepirpFxyUKDPivJEYZr13s9h/vX2ZdixPqq7wfBBHP61sXU9clvLzXHQz5fPAZ4A6tUmtoxgEb84iF2RRz5OqUzJwEiCsapDp8b6PZaw0X4w0ZExu+uzLkaB+GUeGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYd3AolPNKg7JRtnbztM1zbmBlTe61fDo1wSAPO6ccM=;
 b=dYVNo8F/yZwth++kjGTbFKyoe+n0vC27XQuBi2YT2KYcd27twrfNAIfo2zr+VDJVvVQXelxwbh+TdFYAPI707sP0FdKWrlOd0ppqH1nJUi/8rkv5nSTg06WiFuPbDqq6Pq4Nj2B+yzRQJPraB1NbKHJRPvX11ItdXXg+2T32NPxoL9tn4IdHAxu/WeZOodB3XnlZpOVuw2ft1VL/NXOlGYWFUrmLYlnGgWU/qnlO6Ovkf6cN76Tozr57ggrzmLENWKmaJQQ55uGeWgs5zsJr8JEUkhcZ3khhqdoqYIAMEEhp4j+Ssi82zxXAwGEk4VQL/yo0XXH6jSRITPjmL/ruFA==
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by PH3PPF085E9B5D1.namprd22.prod.outlook.com (2603:10b6:518:1::685)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Thu, 5 Feb
 2026 14:13:47 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::1) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:13:46 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 92C4FDBCE0;
 Thu,  5 Feb 2026 16:13:44 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH 5/5] video: imx: ipuv3: use clock framework
Date: Thu,  5 Feb 2026 16:13:31 +0200
Message-Id: <20260205141332.2515996-6-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
References: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|PH3PPF085E9B5D1:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 41dd718d-2716-424c-1451-08de64c0c6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IsDaXCEMlrUiriXYIqQBoSh4TS/+4sYQcVcc0z8MP8Z6CNdynqOwsHRcgB8X?=
 =?us-ascii?Q?2ModGbRsQjS3J4v7ZsJkmL2RLWb27fZZzNmxfWaSXxF4yxXVivuQHLOteYrG?=
 =?us-ascii?Q?5y/KGIFiz1ovo8MTCmNpKWD+ZICF+xrgRYmvqii621xeZ9GQqi7vMtzVEPX2?=
 =?us-ascii?Q?4QdQchXhuxfo8wc+0S6Ql7mnQ06o0zVbqVx8EU/2VOm0NHkB3Z+9+tBc1FE5?=
 =?us-ascii?Q?DJsaUU0Fgm/zp9Z3VniGYy/htUU+yjlhuDxl/ziYq71BMcCHhImDG81JXWCs?=
 =?us-ascii?Q?v6gVC0DoBCFkJFH+dpfZQse40PHxbhPa4XKzCX3iBhaMN49ArbLReCR3lyN0?=
 =?us-ascii?Q?5J2pSmrETO3MyD9qj0UC5FJb5tw/LLpaZDlOK15Mc9jTL41TF3RwJTq3FF4n?=
 =?us-ascii?Q?V+25FdrBx/HkWfqi35Gx38MGPJM8Uwz9N9gK/KRd7ut+RgQ1QBxSGrc3QiMb?=
 =?us-ascii?Q?ycltqbHEShfyp5YQArr6OB8jy5Lscp6/x3/8SW0FC9v+AQJRbkdiN0FdKIP0?=
 =?us-ascii?Q?xddSCRiu3m6Xdy/0Z4MPGFkth6iKIS2ldgOvkvmqB2V09zinLpa8k1LXqxJE?=
 =?us-ascii?Q?owxDGNYdE5l/XdcpJwV9/25EAme86SPOBLAhgGb2XqmYPRthaZsILRudby0m?=
 =?us-ascii?Q?S7qBSKzJGkb7vi0rB86urs4WRjoPVTTDo9l/R/M0ztaS+x4DeRoTdms4fe2i?=
 =?us-ascii?Q?ibWFKcUDHkKfy5EMnsGEuGtGaxmxBFLS8whM+LUTU5OjprMc+fWJX2kmiHp2?=
 =?us-ascii?Q?PgVDcJKVbgIvQ/ytLIxm9Tl3sKjjf/h1Cpl8KoCvWgtV2xAdVpmQlUtPA6A0?=
 =?us-ascii?Q?krexbRf+EjEXZamQvGIzoIaRKqV8Qw6yQB7Ik55n+QicyOA6i2e5xTQN4oTl?=
 =?us-ascii?Q?IwkUuxN7sANeysJtSD/5zhV0um88O6AgSUNjXl310OX1ACdzK0eSJx4PI+zG?=
 =?us-ascii?Q?esVoKjwjP9CG0RPw41dftVAR8PQMbaUSWEw2V3qUENprGLLofIJW7maAxWB9?=
 =?us-ascii?Q?jhRskfJRG21Kk3XFqX250MRj5IV+kooVWIg3h/fgoAO+TrsWqiCqxhyw4URA?=
 =?us-ascii?Q?A2/WfzURafNTkrV3rfrcV9SL2HLwUHj3ClM0He4yi3g2RIzS3LStgO9ss5o7?=
 =?us-ascii?Q?63ej6Ir5veKs6fI7FdwNNUUr10s4UqVzbq0CQKsRbrMnUJbEW3btQJJGFjiK?=
 =?us-ascii?Q?q5GbP5JDGzComfwYeGWbRpfec2xfr6wKcqsJSwG2ZIFpJT3k2EbMHakjlQCn?=
 =?us-ascii?Q?FSWt9QK21/78AhRJzBbffNZtGNFis0CfIM6Pa4Tbbiz0Fx31rUaQfZ+uCMB8?=
 =?us-ascii?Q?IhLDqe+s9F/8VTVh9TPrlj7rsP/thmERglmLatIv5eQyT84V0zAVii1GzgEW?=
 =?us-ascii?Q?nTGQvjrynra+ms1J8ZFtUmoeHr3Ff9gNuvOJVqhrMj6Jquf9D6JPwV8RdAPO?=
 =?us-ascii?Q?qbX6IfqCqqVjoTdfNB5iPOpBC1rh7YnkWUa9CQVKsCSXPROS5+5Iwr/OGSoy?=
 =?us-ascii?Q?6We+OU3jFqMo2nI186UKxoHekI7r/H6qwGwX0PUIPF/egyM+Se0yLL8coFGk?=
 =?us-ascii?Q?X0KvDnrpUdtMm21j1TgUe0BdQlBfeApoM75Li3kbpM9nKFKPbFrVLuJzhL6m?=
 =?us-ascii?Q?TfCfjaXrnIV6cB0V3ccDRj0BoAwMc75tebWI45mbGOMjSNWO5E5w1zGMT5iM?=
 =?us-ascii?Q?bhOVwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 69g2v9XsEBaQJRkKCcYiDdDUcUXobOb4pb8kXMLq48ANBQF6f4hmtPuqLEkhnARwlGpTnz9OcI1UhhdnWl4q+5hDg1SJ39Bt9eNKDepTXInwDRTyNgO8g/hi8IMlT5lVwg3ZaQZpwPiAuRZW/zhVJvW/q9cZSeG2BIQfslYzOTys2Ntww4MI959EY/t0SK20OOiE87T0HvEYxcXEfcnGuqrS8if6s7zXSOO5BebxjXCxUbKEN7sTS3KT1xfh+q4LwTWisCrsWLNYLUztul38gLHtclbvzq9WG+0icJDWHFn+fK2WiFuW7YWHOw/h1q5Wsiz3xexEO26ItT+x+qlrVJP1JX2aL5GMAMf1REq9s/eqD26fDttbAcwrZYUhIho+Q8dZS+8wyprVDu5gDmqIhth9vN9ZJtGST06f9+ZXrn9seaF8hRMtIYl+rsncAb6k
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:46.4824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dd718d-2716-424c-1451-08de64c0c6eb
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF085E9B5D1
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

Clocks are now configurable via the common clock framework, however,
users have the option use the legacy clocks if desired. The intent is to
keep the changes minimal for this old SoC.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu_common.c   |  76 ++++++++++++++---
 drivers/video/imx/ipu_disp.c     | 142 +++++++++++++++++++++++++------
 drivers/video/imx/mxc_ipuv3_fb.c |  17 ++++
 3 files changed, 197 insertions(+), 38 deletions(-)

diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index d994053394f..ccd4a58b4b4 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -14,6 +14,7 @@
  *
  * (C) Copyright 2005-2010 Freescale Semiconductor, Inc.
  */
+#define DEBUG
 
 #include "ipu.h"
 #include "ipu_regs.h"
@@ -101,7 +102,18 @@ struct ipu_ch_param {
  */
 static int ipu_clk_init(struct ipu_ctx *ctx)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_clk_init_legacy(ctx);
+#else
+	struct clk *clk;
+
+	clk = devm_clk_get(ctx->dev, "bus");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ctx->ipu_clk = clk;
+	return 0;
+#endif
 }
 
 /*
@@ -113,7 +125,13 @@ static int ipu_clk_init(struct ipu_ctx *ctx)
  */
 static int ipu_ldb_clk_init(struct ipu_ctx *ctx)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_ldb_clk_init_legacy(ctx);
+#else
+	/* Set this in the FB driver where we know the display id */
+	ctx->ldb_clk = NULL;
+	return 0;
+#endif
 }
 
 /* Static functions */
@@ -150,6 +168,29 @@ static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
 #define idma_mask(ch) (idma_is_valid(ch) ? (1UL << (ch & 0x1F)) : 0)
 #define idma_is_set(reg, dma) (__raw_readl(reg(dma)) & idma_mask(dma))
 
+/*
+ * Function to initialize the display clocks
+ *
+ * @param   ctx	    The ipu context for which the function is called
+ *
+ * Return:  Returns 0 on success or negative error code on error
+ */
+static int ipu_di_clk_init(struct ipu_ctx *ctx, int id)
+{
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	ctx->di_clk[id] = NULL;
+	return 0;
+#else
+	struct clk *clk;
+
+	clk = devm_clk_get(ctx->dev, id ? "di1" : "di0");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ctx->di_clk[id] = clk;
+	return 0;
+#endif
+}
 /*
  * Function to initialize the pixel clock
  *
@@ -159,7 +200,12 @@ static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
  */
 static int ipu_pixel_clk_init(struct ipu_ctx *ctx, int id)
 {
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	return ipu_pixel_clk_init_legacy(ctx, id);
+#else
+	ctx->pixel_clk[id] = ctx->ipu_clk;
+	return 0;
+#endif
 }
 
 /*
@@ -230,33 +276,39 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 	ipu_cpmem_base = (u32 *)(ipu_base + IPU_CPMEM_REG_BASE);
 	ipu_dc_tmpl_reg = (u32 *)(ipu_base + IPU_DC_TMPL_REG_BASE);
 
-	ret = ipu_pixel_clk_init(ctx, 0);
-	if (ret)
-		goto err;
-
-	ret = ipu_pixel_clk_init(ctx, 1);
-	if (ret)
-		goto err;
+	for (int i = 0; i <= 1; i++) {
+		ret = ipu_pixel_clk_init(ctx, i);
+		if (ret)
+			goto err;
+	}
 
 	ret = ipu_clk_init(ctx);
 	if (ret)
 		goto err;
 
-	debug("ipu_clk = %u\n", clk_get_rate(ctx->ipu_clk));
+	debug("ipu_clk = %lu\n", (ulong)clk_get_rate(ctx->ipu_clk));
 
 	ret = ipu_ldb_clk_init(ctx);
 	if (ret)
 		goto err;
 
-	debug("ldb_clk = %u\n", clk_get_rate(ctx->ldb_clk));
+	if (ctx->ldb_clk)
+		debug("ldb_clk = %lu\n", (ulong)clk_get_rate(ctx->ldb_clk));
+
 	ipu_reset();
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_set_parent(ctx->pixel_clk[0], ctx->ipu_clk);
 	clk_set_parent(ctx->pixel_clk[1], ctx->ipu_clk);
+
 	clk_enable(ctx->ipu_clk);
+#endif
 
-	ctx->di_clk[0] = NULL;
-	ctx->di_clk[1] = NULL;
+	for (int i = 0; i <= 1; i++) {
+		ret = ipu_di_clk_init(ctx, i);
+		if (ret)
+			goto err;
+	}
 
 	__raw_writel(0x807FFFFF, IPU_MEM_RST);
 	while (__raw_readl(IPU_MEM_RST) & 0x80000000)
@@ -278,7 +330,9 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 	/* Set MCU_T to divide MCU access window into 2 */
 	__raw_writel(0x00400000L | (IPU_MCU_T_DEFAULT << 18), IPU_DISP_GEN);
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_disable(ctx->ipu_clk);
+#endif
 
 	return ctx;
 err:
diff --git a/drivers/video/imx/ipu_disp.c b/drivers/video/imx/ipu_disp.c
index 6a337b13af6..5e78574da9b 100644
--- a/drivers/video/imx/ipu_disp.c
+++ b/drivers/video/imx/ipu_disp.c
@@ -612,6 +612,11 @@ void ipu_dp_dc_enable(struct ipu_ctx *ctx, ipu_channel_t channel)
 	__raw_writel(reg, DC_WR_CH_CONF(dc_chan));
 
 	clk_enable(ctx->pixel_clk[di]);
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	reg = __raw_readl(IPU_DISP_GEN);
+	reg |= di ? DI1_COUNTER_RELEASE : DI0_COUNTER_RELEASE;
+	__raw_writel(reg, IPU_DISP_GEN);
+#endif
 }
 
 static unsigned char dc_swap;
@@ -702,6 +707,12 @@ void ipu_dp_dc_disable(struct ipu_ctx *ctx, ipu_channel_t channel,
 
 		/* Clock is already off because it must be done quickly, but
 		   we need to fix the ref count */
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+		reg = __raw_readl(IPU_DISP_GEN);
+		reg &= ctx->dc_di_assignment[dc_chan] ? ~DI1_COUNTER_RELEASE :
+							~DI0_COUNTER_RELEASE;
+		__raw_writel(reg, IPU_DISP_GEN);
+#endif
 		clk_disable(ctx->pixel_clk[ctx->dc_di_assignment[dc_chan]]);
 	}
 }
@@ -765,40 +776,21 @@ static int ipu_pixfmt_to_map(u32 fmt)
  *
  * @param	sig	Bitfield of signal polarities for LCD interface.
  *
- * Return:	This function returns 0 on success or negative error code on
- *		fail.
+ * Return:	The integer portion of the divider set for the pixel clock.
  */
-
-int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
+static u32 ipu_di_clk_config(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
 {
 	struct ipu_ctx *ctx = di->ctx;
 	int disp = di->disp;
-	u32 reg;
-	u32 di_gen, vsync_cnt;
-	u32 div, rounded_pixel_clk;
-	u32 h_total, v_total;
-	int map;
-	struct clk *di_parent;
-
-	debug("panel size = %d x %d\n", di->width, di->height);
-
-	if ((di->v_sync_width == 0) || (di->h_sync_width == 0))
-		return -EINVAL;
-
-	/* adapt panel to ipu restricitions */
-	if (di->v_end_width < 2) {
-		di->v_end_width = 2;
-		puts("WARNING: v_end_width (lower_margin) must be >= 2, adjusted\n");
-	}
-
-	h_total = di->width + di->h_sync_width + di->h_start_width +
-		  di->h_end_width;
-	v_total = di->height + di->v_sync_width + di->v_start_width +
-		  di->v_end_width;
+	u32 div;
 
 	/* Init clocking */
 	debug("pixel clk = %dHz\n", di->pixel_clk_rate);
 
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	u32 rounded_pixel_clk;
+	struct clk *di_parent;
+
 	if (sig.ext_clk) {
 		if (!(g_di1_tvout && (disp == 1))) { /*not round div for tvout*/
 			/*
@@ -830,13 +822,109 @@ int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
 		if (clk_get_usecount(ctx->pixel_clk[disp]) != 0)
 			clk_set_parent(ctx->pixel_clk[disp], ctx->ipu_clk);
 	}
+
 	rounded_pixel_clk =
 		clk_round_rate(ctx->pixel_clk[disp], di->pixel_clk_rate);
 	clk_set_rate(ctx->pixel_clk[disp], rounded_pixel_clk);
-	udelay(5000);
+
 	/* Get integer portion of divider */
 	div = clk_get_rate(clk_get_parent(ctx->pixel_clk[disp])) /
 	      rounded_pixel_clk;
+#else
+	struct clk *clk;
+	u32 clkgen0, di_gen;
+	ulong id;
+
+	if (sig.ext_clk) {
+		/*
+		 * Bypass the divider, assuming synchronous mode
+		 */
+		clk = ctx->di_clk[disp];
+		div = 1;
+	} else {
+
+		ulong clk_rate = clk_get_rate(ctx->ipu_clk);
+		u32 error;
+
+		div = DIV_ROUND_CLOSEST(clk_rate, di->pixel_clk_rate);
+		div = clamp(div, 1U, 255U);
+
+		error = (clk_rate / div) / (di->pixel_clk_rate / 1000);
+
+		/*
+                 * Select IPU if the rate is within 1% of requested pixel
+                 * clock, otherwise, use the DI clock
+                 */
+		if (990 <= error && error < 1010) {
+			clk = ctx->ipu_clk;
+		} else {
+			clk = ctx->di_clk[disp];
+
+			clk_set_rate(clk, di->pixel_clk_rate);
+			div = DIV_ROUND_CLOSEST(clk_get_rate(clk),
+						di->pixel_clk_rate);
+			div = clamp(div, 1U, 255U);
+		}
+	}
+
+	clkgen0 = div << 4;
+
+	ctx->pixel_clk[disp] = clk;
+	debug("new pixel rate: %lu Hz\n", clk_get_rate(clk));
+
+	id = clk_get_id(clk);
+	__raw_writel(clkgen0, DI_BS_CLKGEN0(id));
+	__raw_writel((clkgen0 & 0xFFF0) << 12, DI_BS_CLKGEN1(id));
+
+	di_gen = __raw_readl(DI_GENERAL(id)) & ~DI_GEN_DI_CLK_EXT;
+	if (clk == ctx->di_clk[disp])
+		di_gen |= DI_GEN_DI_CLK_EXT;
+
+	__raw_writel(di_gen, DI_GENERAL(id));
+#endif
+
+	udelay(5000);
+	return div;
+}
+
+/*
+ * This function is called to initialize a synchronous LCD panel.
+ *
+ * @param	di	Pointer to display data.
+ *
+ * @param	sig	Bitfield of signal polarities for LCD interface.
+ *
+ * Return:	This function returns 0 on success or negative error code on
+ *		fail.
+ */
+int32_t ipu_init_sync_panel(struct ipu_di_config *di, ipu_di_signal_cfg_t sig)
+{
+	int disp = di->disp;
+	u32 reg;
+	u32 di_gen, vsync_cnt;
+	u32 div;
+	u32 h_total, v_total;
+	int map;
+
+	debug("panel size = %d x %d\n", di->width, di->height);
+
+	if ((di->v_sync_width == 0) || (di->h_sync_width == 0))
+		return -EINVAL;
+
+	/* adapt panel to ipu restricitions */
+	if (di->v_end_width < 2) {
+		di->v_end_width = 2;
+		puts("WARNING: v_end_width (lower_margin) must be >= 2, adjusted\n");
+	}
+
+	h_total = di->width + di->h_sync_width + di->h_start_width +
+		  di->h_end_width;
+	v_total = di->height + di->v_sync_width + di->v_start_width +
+		  di->v_end_width;
+
+	div = ipu_di_clk_config(di, sig);
+	if (div < 0)
+		return div;
 
 	ipu_di_data_wave_config(disp, SYNC_WAVE, div - 1, div - 1);
 	ipu_di_data_pin_config(disp, SYNC_WAVE, DI_PIN15, 3, 0, div * 2);
diff --git a/drivers/video/imx/mxc_ipuv3_fb.c b/drivers/video/imx/mxc_ipuv3_fb.c
index ab416fdd33c..cfc34972ad1 100644
--- a/drivers/video/imx/mxc_ipuv3_fb.c
+++ b/drivers/video/imx/mxc_ipuv3_fb.c
@@ -36,6 +36,7 @@
 #include <dm.h>
 #include <dm/devres.h>
 #include <video.h>
+#include <dt-bindings/clock/imx6qdl-clock.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -602,6 +603,22 @@ static int ipuv3_video_probe(struct udevice *dev)
 	if (ret < 0)
 		return ret;
 
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	if (of_machine_is_compatible("fsl,imx6qp"))
+		ret = clk_get_by_id(gdisp ? IMX6QDL_CLK_LDB_DI1_PODF :
+					    IMX6QDL_CLK_LDB_DI0_PODF,
+				    &ctx->ldb_clk);
+	else
+		ret = clk_get_by_id(gdisp ? IMX6QDL_CLK_LDB_DI1 :
+					    IMX6QDL_CLK_LDB_DI0,
+				    &ctx->ldb_clk);
+
+	if (ret < 0)
+		return ret;
+
+	debug("ldb_clk = %lu\n", clk_get_rate(ctx->ldb_clk));
+#endif
+
 	ret = mxcfb_probe(dev, gpixfmt, gdisp, gmode);
 	if (ret < 0)
 		return ret;
-- 
2.39.5

