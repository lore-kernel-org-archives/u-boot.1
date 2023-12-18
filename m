Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF74CC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816CB87DC0;
	Mon, 18 Dec 2023 08:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X034XsfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C94187DCF; Mon, 18 Dec 2023 08:24:56 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F8987DC0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28b9460a9easo118533a91.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884292; x=1703489092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hX3wvo41BzA4Rk5pCxl7hribnvLUVmmj6qPqd/8HJc=;
 b=X034XsfXb8ttycKOApn920uc3Deu4l9op4YLBeGZYWrvjRSsel9HwFv/aNLaXlnojI
 dGqCHMkNf9DJVMuZekVIptz8ni32s2x7c128JTFCfc69GaS2zjUERLFDxmguAF+5t0KH
 jbsT9YzVGU8nBxJclSq0A3Osjl9OL7qOvjn2sHlHo85uAW27EpgBUpEo5P0Khl3r0ZD7
 Rh+x60Hpsicheg9FNYL5QK0ktKHNlSk8yM6VDMiEC86FBcc/v28SMQyq+iOQ24j6bMnV
 K1rnRFjgRb5PqK2wJGwBeyj8bcHw4PGHBPdcC4pG3joEroAroIve8AiOlTXeizZTLlgn
 u3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884292; x=1703489092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9hX3wvo41BzA4Rk5pCxl7hribnvLUVmmj6qPqd/8HJc=;
 b=wBjRn9dwvZdDc+kgnOo+OER2O/+DqaRQy0Q7oSNrrjmsSXFXTUunhBRUDxhWuXLg62
 wT/wP1GY+FCmLSwC0+I8NYX4fEB+9ZA3pBKOKBBMQMIog9sGu7j45N0FEES0Jj/R91bG
 aql6RvGIZDokKF31ZTbcqVeAHy62RievMOyALP1CrbkgaS2fsRycvyip/ZK8UfIi7LeL
 SDBtsJ1ZiuUhEgVb7n6+qsAaFcqbKckLf5erWghJxd4tBHD51iUtWhjTHbUeC5CdEcIX
 BiSOSnKcbmCt+uLlxQxHHhlcaTb3MNUtlPrmuwXvm6cqwlPISK2Xup6b14IQFLb3sVcI
 pcgA==
X-Gm-Message-State: AOJu0YzpEePpHymdlp3ewhJwXBK1Zqw38+GlxT1JdIkSI3CwVTmmWqZ7
 Gv5OjfJL2qchJ/doO3sykQOi2pi2QNWXZaboU7kSnA==
X-Google-Smtp-Source: AGHT+IHimaGEjWioxZpjp6GD41cvw4TzXHqBa2a1HM08gKlIHUW8ZuItFuhiuW7N3VnlSUuqBHYp8g==
X-Received: by 2002:a17:90a:c254:b0:28b:35a4:1945 with SMTP id
 d20-20020a17090ac25400b0028b35a41945mr1247776pjx.26.1702884292200; 
 Sun, 17 Dec 2023 23:24:52 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:24:51 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/7] clk: apq8016: Add support for UART1 clocks
Date: Mon, 18 Dec 2023 12:54:22 +0530
Message-Id: <20231218072428.1802969-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

SE HMIBSC board uses UART1 as the main debug console, so add
corresponding clocks support.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 44 ++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index c0ce570edc7..fb663d2e92e 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -42,6 +42,14 @@
 #define BLSP1_UART2_APPS_N		(0x3040)
 #define BLSP1_UART2_APPS_D		(0x3044)
 
+#define BLSP1_UART1_BCR			(0x2038)
+#define BLSP1_UART1_APPS_CBCR		(0x203C)
+#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
+#define BLSP1_UART1_APPS_CFG_RCGR	(0x2048)
+#define BLSP1_UART1_APPS_M		(0x204C)
+#define BLSP1_UART1_APPS_N		(0x2050)
+#define BLSP1_UART1_APPS_D		(0x2054)
+
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
 
@@ -93,6 +101,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
 	return rate;
 }
 
+static const struct bcr_regs uart1_regs = {
+	.cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
+	.cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
+	.M = BLSP1_UART1_APPS_M,
+	.N = BLSP1_UART1_APPS_N,
+	.D = BLSP1_UART1_APPS_D,
+};
+
+/* UART: 115200 */
+static int clk_init_uart1(struct msm_clk_priv *priv)
+{
+	/* Enable AHB clock */
+	clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
+
+	/* 7372800 uart block clock @ GPLL0 */
+	clk_rcg_set_rate_mnd(priv->base, &uart1_regs, 1, 144, 15625,
+			     CFG_CLK_SRC_GPLL0, 16);
+
+	/* Vote for gpll0 clock */
+	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
+
+	/* Enable core clk */
+	clk_enable_cbc(priv->base + BLSP1_UART1_APPS_CBCR);
+
+	return 0;
+}
+
 static const struct bcr_regs uart2_regs = {
 	.cfg_rcgr = BLSP1_UART2_APPS_CFG_RCGR,
 	.cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR,
@@ -102,7 +137,7 @@ static const struct bcr_regs uart2_regs = {
 };
 
 /* UART: 115200 */
-static int clk_init_uart(struct msm_clk_priv *priv)
+static int clk_init_uart2(struct msm_clk_priv *priv)
 {
 	/* Enable AHB clock */
 	clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
@@ -127,13 +162,12 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 	switch (clk->id) {
 	case 0: /* SDC1 */
 		return clk_init_sdc(priv, 0, rate);
-		break;
 	case 1: /* SDC2 */
 		return clk_init_sdc(priv, 1, rate);
-		break;
 	case 4: /* UART2 */
-		return clk_init_uart(priv);
-		break;
+		return clk_init_uart2(priv);
+	case 5: /* UART1 */
+		return clk_init_uart1(priv);
 	default:
 		return 0;
 	}
-- 
2.34.1

