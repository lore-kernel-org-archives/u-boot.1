Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40338C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C886588245;
	Mon,  3 Jun 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tJZYM7lO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D956A88245; Mon,  3 Jun 2024 14:49:24 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBFD387FC1
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a69024f2433so138234966b.2
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418962; x=1718023762; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77CYVgJKcDJpsI1Ed1gMNCRl5Q4qcCYKv+bhM8jtCsI=;
 b=tJZYM7lO5H3Ka0GU8Rnau/T0B5k3psvDm8P8wjQq2rjtZUkSdduzttH/7eYiQ5B5Rf
 ZOMxEfl+Unt7zq6/cOU0lbjaduz9jul7yIJeKvMWYTrwTCo1z9vRmOP/H76Jjh4ksKVe
 1dkaqM6kYtp8E6AaDPL4bTBcm0zGjP24FjVLBWZnVBnh18URNGtSE8kfBkZsKOO38ksh
 qpPN7LJz0p+UJ/2VTOiWNU+xX9VIR4wPtt4sISHKQnER/4iGD3TgIj1Z+RdkVcGo5ElI
 bPLhzQZqTVSv27vk0hRXuS98Z85RKZdJJAp90QTeBbtD/qona+2x/106MpQVyIpTxg02
 wMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418962; x=1718023762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77CYVgJKcDJpsI1Ed1gMNCRl5Q4qcCYKv+bhM8jtCsI=;
 b=ARhWrd1nUFi5NiVrRP78rvNIzghrIUAl4Poyfff72p6d39sL2pTC5qCjFlq12V6GpL
 j7sGhXfXzPat4ydlS2yzcWNAwzz2HQq155Vhm3ZbWByTuUXKm3XRnBlon9ASktu2xzTq
 k8xGxELOtuCBUB7HMkIUTgKbIFgC1wGnoYWWbEJLR0SN5UFwAwVze01gKj4UXzRIm+ww
 UyeUPp8YkuFooGs2QbuOp5k+JgZqG9WTuQNr2JD2b86MQVCH4J7YyHLviE24BssOCPIR
 STflaieXFjL2/Hm6W8gnz3+Zur7Mc+kCUaDOrK3X/xMD+312Ttq/putE8nf/DAjyGtJU
 msOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/igxrp6VdNAc38BkteKyCe5UlNhCfQ2OyqCYs7QKSoeUens7nlpFq3zOC7pbkKK91sfLX2iFbVWksgtP2jKA92kVj2Q==
X-Gm-Message-State: AOJu0YzzFQGt9G8pRY1L17uPDHYw9JqiXRvGSEDQa103338zEntJgHU4
 +BX2lC4LzogPHBFwvUvYb0IGB7KtSagZXtBLSF7gEGuox5BkM2arbyoIzmiFbMU=
X-Google-Smtp-Source: AGHT+IGxi69N4mIvM8hx6xlLGnEG6/ZX2W4XHkcz8eR5DCNdod61wK2tcmrrV4tJ2+ItStqfgVqVJw==
X-Received: by 2002:a17:906:cd10:b0:a59:a356:3f6d with SMTP id
 a640c23a62f3a-a6822049b1dmr527124366b.54.1717418962412; 
 Mon, 03 Jun 2024 05:49:22 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:18 +0200
Subject: [PATCH v3 3/8] mmc: msm_sdhci: work around a bug when writing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-3-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xiqItTSGGlbEaRHj7FGeYLvraoWKv5JTGiseJ0yRN2M=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvNZbkd7s/eLfMaDiDxTG6X3AL3iDrBHdBHK
 ZmY2qfEyGuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 tn0PD/9lkjImSKNN6fnnulQy542jwypvIUXnslWxFew54cHKd41dad2RxdXn/JuMiRjGBjIk70I
 cPsiA587D+CfJvtZmoXiDkjEbVC9ut3Iocgb+ob6CHFLlauO54ahDHgDNjhoKuvLtIVfSh0/KS/
 EB5DCgW+CghwqCF8J1Lsx2/RJtt6LG+0zRSwMnBtashYkvBNDDz5Rl6djS4xprtHgwNC5nPTZ/J
 UdFJYUyA3UlgEXri4JrtduzdHRsPz+jjUkTqNm6XkITuAJi1fpdOXWgDDBq0Eb/CbScU0iTtJXp
 uP1AKea4k+NhwJq3UnTJrqX1FgSR+Kh6wlnSXFLo7Tv10uwNXqOiPTvRHzu38HtFgLa7+9eAiIV
 jG5sNd16kBZzsQRJ+vQRqIvvf5twVtrkpnVYVDNBJSo27SEq98A7atLJLcwPj0F4fMYroXREjKu
 ttihnm1cn3SFnsqvmXjXfbieNzEbn7PhOlq/oHV1FprZifF4OLuC0l7aSHpp2JKyggN7PB1oeJv
 C9fZ0NxQoVMo/aHuVas8rLdkKRLNSBhW8q3VQwmJ2G807lwWT2Kc6uVilDw1cY1Q900z2UQUTN1
 pP5rwIIqfii3JuHduxaN4a6twAyoGDwwAJ/9FuhBTqVXW38O9s3QMyZrrA0/SDMpra5rAaCGzsM
 i3q/VvVUAMHM7nQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

For some unknown reason, writes of larger than 1 block always fail with
a checksum error on Qualcomm v5 controllers.

Until this is resolved, work around the issue by setting b_max to 1 for
these controllers.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 4ce0de6c47d8..fc3e8d101b6e 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -195,8 +195,15 @@ static int msm_sdc_probe(struct udevice *dev)
 		return ret;
 	host->mmc->priv = &prv->host;
 	upriv->mmc = host->mmc;
 
+	/*
+	 * FIXME: v5 controllers have a bug in U-Boot that causes all writes
+	 * greater than 1 block to fail. Work around this by setting b_max to 1.
+	 */
+	if (var_info->mci_removed)
+		plat->cfg.b_max = 1;
+
 	return sdhci_probe(dev);
 }
 
 static int msm_sdc_remove(struct udevice *dev)

-- 
2.45.0

