Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0737EFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B36384663;
	Tue, 28 Apr 2026 14:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="q3Hjmnvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF59484659; Tue, 28 Apr 2026 10:51:36 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ABA484676
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ki5C/gCD8fgLBl4hnJ1ghC4i0WlD33/W5xqkj3mFRvdMGZBU0XKEMf0wbN7KKv1YQbmeP11tS021B3nm3cQ9KyegjRzQqctTrMgQXqDWIVYJ8/e7cUluFUfMr1k9FW3FPHP2rhgUb1yzg0wNqiwJhDXurLGsU5gID8sf7K0Ld536ncTh7QfpYbEPjSG1TJqlru/XuVGu40j7Pcm45WoyW0qp/PfMODNNieBljHrTDdDSoSJm/NdV/QB0T+9/Y1cKoB16vkXIoOnvnuAbuDFo/bDNYxey06ez/lyhHuvfUqqOyb7Rw2ACL4+zu7TmMug8hnOAjnl4W5rrepT32AEXyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=Dj33KFlQ3fDCHELkT4qea1tz6F4b7QixClbwo5OjYlytxnTK99A21uVRHZYBzw1P1NOH9KKKNvjMmE2aaoSKZE74QaJkxiMZxVZbQSqLHdib1YB5g+FhdwyNqLU0fvQeVmSWcjwgPuMVjMDlLX18orNNg8p0KlBUddFw9oVRLFsGGizH/foh6KLVcxaIk0Zo9njcTVFInYSrnlQaAIv8YUFxNOuK56vh0YfwMK+ZbwP7yBYtM3EFGdyzUMgIOgiX7UzzSgvrw7uYqsdrwuwbYuJu8Rh9bQwnEczyHqlpjPB/I3vnUZkCc+ds9YMNG2JPTYdBPbq//VdCeFgTnRrKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJyG8EWy5dtHdF20NmYGRPeDQ185wQfPiiwenqv01E8=;
 b=q3HjmnvvtSOE/B+aV2AkuSb/woOGQdY8IhdBSje3nbEkneBvy+dl4YUztJxrJwwxTHXZPUXYaxHsCvopZOwH6tTDx7gnHzSe9bh/L+W//IGafHGhxbSZD4+Rbr1FZvOX63u5SOtS2E/+DSEvFzsvXcFmGr+seuZSP23nBmEKFpUWeRjkgbkARYMAPaSWAZ+Tk6bpRqvcDtM3V3bVv9rfoCXVrYtS/6ZE4ToAKdUtU0tYRtTm5QBFE9boIdFgr3ixTjDzlvrJfeJm3WSv6PnZ7R5mdgUuIi+lODlmlsylrAmASI6JNLLRDOZZKQ/i/UP+5/1qsV/cPPc6OAJNxYaa5g==
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by EA2PR22MB5054.namprd22.prod.outlook.com (2603:10b6:303:25f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 08:51:28 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::b9) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_3,
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
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 08:51:28 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id F29CF1290A;
 Tue, 28 Apr 2026 11:51:24 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: brian.ruley@gehealthcare.com,
	lukma@denx.de,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/7] video: imx: ipuv3: enable ipu clk before writing
 registers in CCF
Date: Tue, 28 Apr 2026 11:51:10 +0300
Message-ID: <20260428085117.402523-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
References: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|EA2PR22MB5054:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17bd8524-9c52-4339-77af-08dea5035629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18096099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dw9NBSHdo5OZn8jspoIiXCKorTD1korLa9FsA8+zfWmh+JG4JZeiJHqZ5nzfEruE8raXSPtLmNNjRtFcJLupyiYRgnlsZE2t0oDCj0SbmIAXQFt8rguBd42S+S4r3sGjP4P2ZcfKWzjoGx52R4iIGO7NbfNDa+OwnSPsH/JsatHp4J2HUCZFVaDBu3S0FcSBupyrjIhYAi8b+MUaboXLqz7Ggzf/AMqRNRgE4QNLTe5o5LlStZpBrvG4fWjiqpyTqLjwydIm39JbrzKYsV0QgdjY7/cMiBRMjQdpVsBCGVUUwEU3AYafCvlzzEnxlDVa0NCHtq7O6zxV2yFYvu7N5uVxcu2RBkmLgJdaq/2fyWG9Lw6a7cfvUrGrZAZz2CMV0ksh+HQVGszvsOr/+KAgSfx8lWitqAjNm0CFh9e2i16/n3qZ4pi00P6cnOM4UuG1kKATNISBg74VdcaNd12kancmD5TBwtA5NG7dkuC2V77M8juT7yV7CnKAOesqI3qZGrMAXNLTbfgMMtL+bJRTOgA2H4pwws4WSjt12IYR8oDIYY2invRQhXVoSVOMABvDLxOkV4JyaNnGydUGDw5sjkcqCl2xlV7L06NpXklcNuFG8wn6HNIVwmZGJqrd2XsTNmjseXPU6CB4b9VmC0TYuntcmwGDNbeS5GV3IsTh4Fofc1qutYUQEs+mr9UVJVkmGG+kZEJX6RqZx3OLBp8zsbJx6nuqkQjw+TPG8sMWE04O/BYP0JzTjhO/tKh4STqeulMZroVi4KuI0+6dXaRQPA==
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18096099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wJnswR450TujBGUsWC6IXQbb147gZvAk7z7Bid0DS7ug16ztW/Ly+VLbb+q6qpEd2t+JifBBZ0qy7YeIUGX40WUWyJ1veeEpqG+F7rWvhRR1Eq5ZqWYkf/lbdumfR7h9HRJ2wGiH5fepyTMAD+dHETJXSrHBNfCgfqvmmv3/OnsigAMnLBq3GgQT8A+39lqceSo2DIx7rbpJz79t55lwUNjpAquq6ofubs68lPlX4AaSk74nilrgpuqcDJ/tc4gDl7eX25tn6UWitxelvkGMCQOwBYD2k71MNAzC6LCi168IMqJWgg01Jy/tWVF3pdJsZE5kLEr732L7Wphm/37vQrt8/R5kgbwVKCO4SZtTTb0KyvhP7wQJZj0uKTnY0jqFQN9O72o6idXuf+xNydfYoRxxZNYEadLrQ5riGyLwbn7V+ZwtBFL4N03u6A07Fg7e
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:28.0520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bd8524-9c52-4339-77af-08dea5035629
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5054
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

