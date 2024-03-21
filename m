Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0B0C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8466387F4A;
	Thu, 21 Mar 2024 15:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dwSSoI58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C214787F4A; Thu, 21 Mar 2024 15:55:38 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B50880E4
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso16758785ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032933; x=1711637733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZszhapRfBhAfiLoppFEm0qvoUGpo25SESb5dIarLvs=;
 b=dwSSoI584FFQt/+Y0SKof0CGiz920RK+Pil51DbZA1fU1W9hqNLSOvYs/dzNl9ovID
 CnMJwcYSQ5whG6oRISHa2zFZBhrBzhldwA/Trhvfd3MnzZI6+gKmqVxBHhr9qAl8qifK
 4brXjnLa/ug77llbBjmVMRDEpOoA+NfUJpNk0DaiD6cjz7NTSy3+mY8ERCfm3e9zqnPG
 lyq3mwOU8//6oZa3sRB/XSBECCZ3NkI71H5T21mf8ksfXKFQiGF/fZxMsPAIBIyeFcwV
 1sN7KoNlVhD0ixxGCNWEzB7igQvan1zgf5Ti2qydn7gf8VbRt39e4mVzLberYAq03bjF
 s45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032933; x=1711637733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZszhapRfBhAfiLoppFEm0qvoUGpo25SESb5dIarLvs=;
 b=pm34qQ1xAetjAwxHfTL8eHMd99MB9S//cSVX6kWnTOkZnhDF7/kbn1Avli/dMpWt/4
 h4fjDmjBpeYkdfxtDdFlkhITCE3clPOLa6qh5SpNQQcgmvnjlm0jek7JBH+5cjWBbryT
 0A/tV3ha3fCfMM87GhzIJAyxoYVR131fRUD4FE+uPxQIF3t3c9cZWzjyRCp+2P6luriP
 60c9d6R2ge5f6zl3tfDPXTXaF/+kaKxM6eUMEZ4M3P2bRPUXohin4n2JxLRJF6GGOIi1
 e1+aanCamy46ZJCXfpmemUXNAwatw/kHezGEbhRcTwGHzugSnjYsyx3SJjOKPJoDwDTQ
 tn2w==
X-Gm-Message-State: AOJu0YwkmilquOwZmfmWeBUSQz0hkv/XCCtRjndosh9Oibl3VesNbMtl
 itD39pjCeP4iyc09TlJO0q1oerbx3Rdm8zMlUUJzrPl3pKMoQcBmoD0A6waVY13s2kUjz53Myn9
 w
X-Google-Smtp-Source: AGHT+IEpECogRsSS6wizBtve0aJjnpNp4UVT57N+zw10oEY6uwdoPBskDZBS9GvR/GoQW/O7Onawvg==
X-Received: by 2002:a17:902:e750:b0:1dd:8daf:99d7 with SMTP id
 p16-20020a170902e75000b001dd8daf99d7mr4488079plf.32.1711032933574; 
 Thu, 21 Mar 2024 07:55:33 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:55:33 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 02/11] reset: imx: Refactor driver to simplify function
 names
Date: Thu, 21 Mar 2024 20:24:58 +0530
Message-Id: <20240321145507.619448-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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

imx7_reset_{deassert/assert}_imx* are a bit more confusing when compared
with imx*_reset_{deassert/assert}. So refactor driver to use function
names easier to understand. This shouldn't affect the functionality
though.

Suggested-by: Marek Vasut <marex@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/reset/reset-imx7.c | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index eaef2cc2cdf..ca703466605 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -14,7 +14,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
-struct imx7_reset_priv {
+struct imx_reset_priv {
 	void __iomem *base;
 	struct reset_ops ops;
 };
@@ -64,9 +64,9 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
-static int imx7_reset_deassert_imx7(struct reset_ctl *rst)
+static int imx7_reset_deassert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx7_src_signals;
 	u32 val;
 
@@ -95,9 +95,9 @@ static int imx7_reset_deassert_imx7(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert_imx7(struct reset_ctl *rst)
+static int imx7_reset_assert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx7_src_signals;
 	u32 val;
 
@@ -185,9 +185,9 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_DDRC2_PRST]		= { SRC_DDRC2_RCR, BIT(2) },
 };
 
-static int imx7_reset_deassert_imx8mq(struct reset_ctl *rst)
+static int imx8mq_reset_deassert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx8mq_src_signals;
 	u32 val;
 
@@ -223,9 +223,9 @@ static int imx7_reset_deassert_imx8mq(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
+static int imx8mq_reset_assert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx8mq_src_signals;
 	u32 val;
 
@@ -252,21 +252,21 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert(struct reset_ctl *rst)
+static int imx_reset_assert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	return priv->ops.rst_assert(rst);
 }
 
-static int imx7_reset_deassert(struct reset_ctl *rst)
+static int imx_reset_deassert(struct reset_ctl *rst)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
+	struct imx_reset_priv *priv = dev_get_priv(rst->dev);
 	return priv->ops.rst_deassert(rst);
 }
 
 static const struct reset_ops imx7_reset_reset_ops = {
-	.rst_assert = imx7_reset_assert,
-	.rst_deassert = imx7_reset_deassert,
+	.rst_assert = imx_reset_assert,
+	.rst_deassert = imx_reset_deassert,
 };
 
 static const struct udevice_id imx7_reset_ids[] = {
@@ -277,18 +277,18 @@ static const struct udevice_id imx7_reset_ids[] = {
 
 static int imx7_reset_probe(struct udevice *dev)
 {
-	struct imx7_reset_priv *priv = dev_get_priv(dev);
+	struct imx_reset_priv *priv = dev_get_priv(dev);
 
 	priv->base = dev_remap_addr(dev);
 	if (!priv->base)
 		return -ENOMEM;
 
 	if (device_is_compatible(dev, "fsl,imx8mq-src")) {
-		priv->ops.rst_assert = imx7_reset_assert_imx8mq;
-		priv->ops.rst_deassert = imx7_reset_deassert_imx8mq;
+		priv->ops.rst_assert = imx8mq_reset_assert;
+		priv->ops.rst_deassert = imx8mq_reset_deassert;
 	} else if (device_is_compatible(dev, "fsl,imx7d-src")) {
-		priv->ops.rst_assert = imx7_reset_assert_imx7;
-		priv->ops.rst_deassert = imx7_reset_deassert_imx7;
+		priv->ops.rst_assert = imx7_reset_assert;
+		priv->ops.rst_deassert = imx7_reset_deassert;
 	}
 
 	return 0;
@@ -300,5 +300,5 @@ U_BOOT_DRIVER(imx7_reset) = {
 	.of_match = imx7_reset_ids,
 	.ops = &imx7_reset_reset_ops,
 	.probe = imx7_reset_probe,
-	.priv_auto	= sizeof(struct imx7_reset_priv),
+	.priv_auto = sizeof(struct imx_reset_priv),
 };
-- 
2.34.1

