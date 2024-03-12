Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FD7C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 07:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C750B87F13;
	Tue, 12 Mar 2024 08:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a5XoAbS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DF987DE3; Tue, 12 Mar 2024 08:04:11 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3071E87F30
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd955753edso17573225ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710227045; x=1710831845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI4UFwHoj79+SKk/1lyA+GGHiTINxrwVYaSuYMteEQg=;
 b=a5XoAbS3QDrh/NV7B97qn2WNb3M9pcIwjYmc6iJpxy5dy851fzWiMxXTS2MFs1gBTc
 /2wy/Sm0ZySwTgTEGN4Xq/o95+9QegNmbPIYJxn8RXhGFWXMqkw2KUxakdpIlQ91XM+T
 yiyLfxpWaAjxAJ8ZvqqR2Q8nD6ObauSDIxAIKJxFqWNDDLbhsUcuSrWlJ/mt2ZP/xjOS
 R7JG9uNMHPtaiW13T5nybdUfKc6GqcW3cgPyLpAB5MLvBdFkpoFg+p6415u6f5kS9tCL
 ZQ96i2zoNgMkU7J7lsaEP7oIzXbuUZ4/d+rZcHnbX95jjLr+LHw8iUlJ8trfN2O8i1Mp
 z1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710227045; x=1710831845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZI4UFwHoj79+SKk/1lyA+GGHiTINxrwVYaSuYMteEQg=;
 b=P5XyP4VQooz0S2wfRuuMM9zGhXR5QZf2V3sAAyoVrti3Oe377GWl/UGhKxtjqEeaWe
 kxxlXp9RCQrdRXnEdcYpK4j2aOlE3kNbL6wkwhvwT3c0yj7H6g3F+gnZ773OSxJ3Y80v
 y5myryhZUA45IQrPRQRX8fSLQbq7KrHjnJX4SYPik0LByiUbFDWTCVFQ7REOJTZLlp/7
 YdiFpzg2ru8POl69rtk5EhQS1czBialWtW8/6gmNqpX7H6CmMlObBwMck+902LAW2neA
 OtO047oqWDXckfv8Nn8fRyk+MGfo+g3RD/VgcyoQiJdA4zD7vtwT3suDIx1cUYSRPE/L
 TUGA==
X-Gm-Message-State: AOJu0Yyo9H77+YLM9iIhrJc7AAyTSpZ8Rhk61UyT33/WatFXKcxPABcW
 l1giWGKYdCcrQs5suC+zjgpgI71jpehBCzAjxoUwCVGnQlk1009d1N25SskiIWt4VGErpBzDxWs
 d
X-Google-Smtp-Source: AGHT+IG7HAFHxeEh277Os9kohl+yY6jL32UhXytmQgwF1Egw/bp+mqX4r4a7IreewcCsEpHTklgUDw==
X-Received: by 2002:a17:903:8c4:b0:1dc:cee2:5ffc with SMTP id
 lk4-20020a17090308c400b001dccee25ffcmr8115226plb.6.1710227045263; 
 Tue, 12 Mar 2024 00:04:05 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 e13-20020a170902784d00b001dd0d0d26a4sm6045401pln.147.2024.03.12.00.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 00:04:04 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 02/11] reset: imx: Refactor driver to simplify function
 names
Date: Tue, 12 Mar 2024 12:33:29 +0530
Message-Id: <20240312070338.86127-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312070338.86127-1-sumit.garg@linaro.org>
References: <20240312070338.86127-1-sumit.garg@linaro.org>
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
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/reset/reset-imx7.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index eaef2cc2cdf..4c7fa19d495 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -64,7 +64,7 @@ static const struct imx7_src_signal imx7_src_signals[IMX7_RESET_NUM] = {
 	[IMX7_RESET_DDRC_CORE_RST]	= { SRC_DDRC_RCR, BIT(1) },
 };
 
-static int imx7_reset_deassert_imx7(struct reset_ctl *rst)
+static int imx7_reset_deassert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx7_src_signals;
@@ -95,7 +95,7 @@ static int imx7_reset_deassert_imx7(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert_imx7(struct reset_ctl *rst)
+static int imx7_reset_assert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx7_src_signals;
@@ -185,7 +185,7 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_DDRC2_PRST]		= { SRC_DDRC2_RCR, BIT(2) },
 };
 
-static int imx7_reset_deassert_imx8mq(struct reset_ctl *rst)
+static int imx8mq_reset_deassert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx8mq_src_signals;
@@ -223,7 +223,7 @@ static int imx7_reset_deassert_imx8mq(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
+static int imx8mq_reset_assert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	const struct imx7_src_signal *sig = imx8mq_src_signals;
@@ -252,21 +252,21 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
 	return 0;
 }
 
-static int imx7_reset_assert(struct reset_ctl *rst)
+static int imx_reset_assert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	return priv->ops.rst_assert(rst);
 }
 
-static int imx7_reset_deassert(struct reset_ctl *rst)
+static int imx_reset_deassert(struct reset_ctl *rst)
 {
 	struct imx7_reset_priv *priv = dev_get_priv(rst->dev);
 	return priv->ops.rst_deassert(rst);
 }
 
 static const struct reset_ops imx7_reset_reset_ops = {
-	.rst_assert = imx7_reset_assert,
-	.rst_deassert = imx7_reset_deassert,
+	.rst_assert = imx_reset_assert,
+	.rst_deassert = imx_reset_deassert,
 };
 
 static const struct udevice_id imx7_reset_ids[] = {
@@ -284,11 +284,11 @@ static int imx7_reset_probe(struct udevice *dev)
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
-- 
2.34.1

