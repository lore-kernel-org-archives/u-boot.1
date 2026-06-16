Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28820CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 18:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49D5184949;
	Tue, 16 Jun 2026 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="njBp+/mM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57543848D8; Tue, 16 Jun 2026 14:52:04 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854E5846A4
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYFsQHfWFDNgdsY7dNtW1ohLaRkE/4lKzBuFoMjKjGmRVslbYjajYRdY/YEgWuy9rwu1JVPCPrrY1r2CBzbxbA+dlOw+JwUUbDEOqpulGendNumkC9H6CaFvM7cfGlqHdvi/U1bjRebgkp5+MHbHR+tp+pefLxY0AlOOdNB+e4UfVhq5jvE7vecdNNDN5sogBBICvWSlofo9XDoSgjUbkNFONlsqY/Db7V83//5w4N5v0xYXlmFZDEOqy9mD+xFMpI5NndxwIpuViSzzp90nKrscoTmkLvxi+WV/K40kmz3YSI/SgI5v8+DwLryAo4T8aq6tfLK9HFYYCbN9wMpk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=BsCF2Op8JqxLx/nw/64xTDGtGj/uA/3fJrLmGQfnHtfEVRyES9CH0E8eZAjDpJHJhPkY9hT827PgEHu2Jp/VrIIqy55MJ3BBYTcKzHT2QkLbcmMnsAIxe0FtaeqZEGijJayG/Amni7WK5ddmfDfx1YvAojFMIsQ4ktwooWuhgpZ423/jPQvRwvzED5PArpIq2DHQOZwX6bJMP7K8wZCwDdolXB6RJkeb4Hx8wFJ6b+zK73XvDAgIfRz3TekItV5b3Cx7P3vyye4HH6+bDm+MaUJRZQcrvHQ3zsMLTXYhDew0l5bGkmwhg+NAZM5/Tmiq7em4xdS8fTm1nKdRI/Xpbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=njBp+/mMh8W66wkoOFYngFsLv9j6A6ms+fbhXSeJvM6gvg1gRDb9jTqBumPiTB/Ja8xFMvE1W+N1bjTSPNeApTmwADoVUPBHexDyVx9Us1HV9h1Vrbcr/Vx1bM8SPxruXHF6MUOZWbzW52MABl4v8JhYinMzPSXT4qNRCteLAOTGOI2VXz7YV6sXqA90Nnlpsds4i3LSJ6OnhBodeQ8gYUuoPoDnb0UBQ7AeGjIzWKGgl/BiHf7kVG2dIYBmZ/YQqxNZguA+WEr7S5AI9+gfUS62dnfSPe7wn7M9+Qq84cb8QSwoMNNaPNXOdIGct3k6X44qzQ05J76M4Z7Q3nurYQ==
Received: from DS1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::6) by
 SABPR22MB996954.namprd22.prod.outlook.com (2603:10b6:806:50e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:51:57 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:451:cafe::6d) by DS1P221CA0001.outlook.office365.com
 (2603:10b6:8:451::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:51:57 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 3ED1E12910;
 Tue, 16 Jun 2026 15:51:54 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: brian.ruley@gehealthcare.com, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: shofiqtest@gmail.com, festevam@gmail.com, lukma@denx.de,
 u-boot@lists.denx.de
Subject: [PATCH v3 6/8] video: imx: ipuv3: enable ipu clk before writing
 registers in CCF
Date: Tue, 16 Jun 2026 15:51:39 +0300
Message-ID: <20260616125147.3710024-6-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
 <20260616125147.3710024-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SABPR22MB996954:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 46beab8d-30b9-4b76-629a-08decba60ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|4143699003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: EkUpgsr3FUw2RP78TBqPjr8LuCRyw5bqoUM2NdXwVQjTIhffaPMFBETQwX1ohiQ8C6dggbfMKHXl4xX4vY+FiCzVQBqWQ4F1GG22Ja0G9gY3itAffLZxzevmf+lqRx4YT4f42n8VeDq0PW5amfytuLOTpD9vG3EE325aN7X+5Pz2iIS6eh7ZvJAIQg6VkDAs13loQAzhSIb0qflwV15S2LQmK0vaBpNI94xHHG+a93V2BMINAZmuiFJtcQ9F40WUL3j3wdAv0zEfDnWInuPU0VboiH1/5iCL4E3I/4cTbGsDhINmBTEYk2wjee15Hhw70ICsGqwK0Zqm2hbo1bH7jCdUk/fN8kWFVry2cJb4onEaAWT8V/OY0ZJz2Ep3c9AoNv1tCYKtQoyv/hipJZiZo30etxYjsWt/D7FceG2mCKnBzSUpLlINFocB4Rc/RbIytXkYN4Y1qCCVAGANhbGz6mNdZWEdC1hYWE04tkovoB83qPjcRGYqlYACLI6NC0Mjv5njnqFqQk4PdDTKas3sp4sDcqQiCDH7SREmJcMv9NO3gGEMHpo8MhpABQ7xZRFyVd56YrlfRmcIiI7StZ1DyOrGh4VW5Tsz8dkwjUaNtiSf4IRlQdCjM5m0sCq0l11RKNP9j2gBiL0MmqkAwJTe1D1aOFEC6XbpVwyecLn77lOTDX6MMzehvtfmxdbowuV8ZQbePxXWFD66hYAzU4Tw03dFuRzvDP+Tf4Z3wCm/KNs=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w+9V+pwkGjyP23xxwXvGPJUGY/+1XtksJTaob9dWXVGuIQ43b1r+Lw0VMJvYstpF9clPDv5RZPKoaPzNVXPCMjlXbInGxmC41rhbgNICG5yQp3+PChGosZCEbvkVGYirQsrdAtcjX4MgR7ZoZsOyoALl8ozXrhicYrx/WfwebSOqkLO4K0s+QD2lY5TdzMx8C74E4bereUO1FOOAWfFrODO8MG4oP2KVBLJe8S9Gy5EaKh9A/GgVoLVD90Z287Wrm7pfw0tIIbF0/GSZZE8q33G/QGTV7JhOvJTI3pRrPpCw4+HDEhRvUX+uJPsQm/e8H8XHwVpd1Dx/+C0tvhJTzmLdwwcwesQLIW1xZnQg8sm2lqFXGVA1vxDigDIYiodYpaYKzadBmjoF+FoBwyyWfZEqaT3AljkUU/XNrQ8ZWWzlXOZV9NKrIqFzXuJ+hDni
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:51:57.1947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46beab8d-30b9-4b76-629a-08decba60ce4
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR22MB996954
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

Obviously, the clock has to be enabled if writing to it's registers.
This was missed because the board I tested on had enabled the clocks in
early init.

Also, remove the completely useless "ipu_clk_enabled" struct member and
use the accurate usecount / enabled_count instead.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
 drivers/video/imx/ipu.h        |  1 -
 drivers/video/imx/ipu_common.c | 13 +++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index ae40e20bc28..aecb6adffce 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -136,7 +136,6 @@ struct ipu_ctx {
 
 	struct clk *ipu_clk;
 	struct clk *ldb_clk;
-	unsigned char ipu_clk_enabled;
 	struct clk *di_clk[2];
 	struct clk *pixel_clk[2];
 
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 8630374a055..d3b52605731 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -299,9 +299,9 @@ struct ipu_ctx *ipu_probe(struct udevice *dev)
 #if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 	clk_set_parent(ctx->pixel_clk[0], ctx->ipu_clk);
 	clk_set_parent(ctx->pixel_clk[1], ctx->ipu_clk);
+#endif
 
 	clk_enable(ctx->ipu_clk);
-#endif
 
 	for (int i = 0; i <= 1; i++) {
 		ret = ipu_di_clk_init(ctx, i);
@@ -384,10 +384,8 @@ int32_t ipu_init_channel(struct ipu_ctx *ctx, ipu_channel_t channel,
 
 	debug("init channel = %d\n", IPU_CHAN_ID(channel));
 
-	if (ctx->ipu_clk_enabled == 0) {
-		ctx->ipu_clk_enabled = 1;
+	if (!ipu_clk_enabled(ctx))
 		clk_enable(ipu_clk);
-	}
 
 	if (*channel_init_mask & (1L << IPU_CHAN_ID(channel))) {
 		printf("Warning: channel already initialized %d\n",
@@ -543,7 +541,6 @@ void ipu_uninit_channel(struct ipu_ctx *ctx, ipu_channel_t channel)
 
 	if (ipu_conf == 0) {
 		clk_disable(ctx->ipu_clk);
-		ctx->ipu_clk_enabled = 0;
 	}
 }
 
@@ -1045,5 +1042,9 @@ ipu_color_space_t format_to_colorspace(u32 fmt)
 
 bool ipu_clk_enabled(struct ipu_ctx *ctx)
 {
-	return ctx->ipu_clk_enabled;
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+	return clk_get_usecount(ctx->ipu_clk);
+#else
+	return ctx->ipu_clk->enable_count;
+#endif
 }
-- 
2.47.3

