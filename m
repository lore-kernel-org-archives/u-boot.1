Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B852C47DDF
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761BF87E06;
	Tue, 30 Jan 2024 15:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z7GSM3JX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA0987D07; Tue, 30 Jan 2024 15:05:16 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8CE87DE1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e80046246so22046705e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623511; x=1707228311; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YCbczh+S/0uTkS7Xs99qN/musVJ9rNVRlw7fke5WCiE=;
 b=Z7GSM3JX2QAC6ydP8CHwQRW8e1eZF4jcTkz1oqa+GW9G508AZWdjHK9ZcVnltBInsO
 UWbrTr0s2AnoMx+UPbVo6sAANFNHafXAHYvhVClbp6dGeXT1+A+NzNentXt18U2el6eG
 z1eW9Y92rYCHpFPLZnIA9N9rREU98W3hCk4M7CpgFEsWwWR4NUVmQ+GU469iWK62uapi
 +djj6iQyjVXu1LvRli0pC4D3LmN6xNDgLY7qkjUOOuZq+BXUTLQKXmi+B9Okm9vm8bc7
 eAqY1fL2KMyC132LFGOHYVyAkw/ZpIrWfF4H8ZY3yUADCYImVXBqtnSVbOucuKK6+mIb
 DiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623511; x=1707228311;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCbczh+S/0uTkS7Xs99qN/musVJ9rNVRlw7fke5WCiE=;
 b=lfOOgXbJL7KdUyQbBO1f7hA7pk4xJyVHQqOnP5ah9+kKMBiXaIyb0vKbkmUJktAolw
 nH6b/0zFIcGQQ2i/BnT7kHvM0vkLaxoz65d0+7GlRPrT2eJZPU1CJocaecqF8mFjgfjd
 UkOM4klxoVO+eW8Wyq33fLHaS2wqwE4ioTWuQhpuQi3ST1DnxE7mZowwEQX52RV3ALg4
 HqkMxXcH5sE886VN2Hc+OtxS8eo5lwXrsv07Nbmc3r9avQ97Jeo3VEzyR/1VuTFyBEi5
 gZyp5BeKUC3BySmiJcSKKxrmE6cMYCWtYk0dUCUkpfLT+uATKwAh7GSrim6W7fLJEDVQ
 KzNw==
X-Gm-Message-State: AOJu0Yx/Q+f+VfSblTSGqg4I8jsGQOjo/PzQnnJBTruarDr4iJF4+J0x
 eCBC/ewUe+AtXOUkZhz5yNdZelcdIb85y8pmjlaefU93Sq0U+/rHQ4sxIQThEnM=
X-Google-Smtp-Source: AGHT+IGRzwWkwm+Qy/uP1mtci3Rt0Q6bl/gxp8S4WLsFp5/WUX5wQujNPH9cmjgggA3CgfvHMnaG7g==
X-Received: by 2002:a05:600c:c06:b0:40d:62c4:3ea with SMTP id
 fm6-20020a05600c0c0600b0040d62c403eamr1487241wmb.6.1706623511623; 
 Tue, 30 Jan 2024 06:05:11 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:11 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:51 +0000
Subject: [PATCH v3 03/36] mmc: msm_sdhci: use modern clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-3-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=3073;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=tkm/wjUoJ0IpQr4Ntu4ct010SrYOmJSwPUMHVECBDq4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTPyJ6xfsEHctL5qswXShOvur0Yxeh7uRHz/kdH/5v
 Oz8DZ0fHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiRY2MDLvWl+888jtDfpeV
 y0GuNS0vK3PWhWotKjwi0/PrQ4nrBSGGf0pNiUttAr4fZLUWk+2XeGYY4u3Fqntz7qTIyV9PVzN
 u2QcA
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

Use the clk_* helper functions and the correct property name for clocks.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 69 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 604f9c3ff99c..863e6007a905 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -44,6 +44,7 @@ struct msm_sdhc_plat {
 struct msm_sdhc {
 	struct sdhci_host host;
 	void *base;
+	struct clk_bulk clks;
 };
 
 struct msm_sdhc_variant_info {
@@ -54,36 +55,56 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static int msm_sdc_clk_init(struct udevice *dev)
 {
-	int node = dev_of_offset(dev);
-	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, node, "clock-frequency",
-					400000);
-	uint clkd[2]; /* clk_id and clk_no */
-	int clk_offset;
-	struct udevice *clk_dev;
-	struct clk clk;
-	int ret;
+	struct msm_sdhc *prv = dev_get_priv(dev);
+	ofnode node = dev_ofnode(dev);
+	uint clk_rate;
+	int ret, i = 0, n_clks;
+	const char *clk_name;
 
-	ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
+	ret = ofnode_read_u32(node, "clock-frequency", &clk_rate);
 	if (ret)
-		return ret;
+		clk_rate = 400000;
 
-	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
-	if (clk_offset < 0)
-		return clk_offset;
-
-	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
-	if (ret)
+	ret = clk_get_bulk(dev, &prv->clks);
+	if (ret) {
+		debug("Couldn't get mmc clocks: %d\n", ret);
 		return ret;
+	}
 
-	clk.id = clkd[1];
-	ret = clk_request(clk_dev, &clk);
-	if (ret < 0)
+	ret = clk_enable_bulk(&prv->clks);
+	if (ret) {
+		debug("Couldn't enable mmc clocks: %d\n", ret);
 		return ret;
+	}
 
-	ret = clk_set_rate(&clk, clk_rate);
-	clk_free(&clk);
-	if (ret < 0)
-		return ret;
+	/* If clock-names is unspecified, then the first clock is the core clock */
+	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
+		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
+			printf("Couldn't set core clock rate: %d\n", ret);
+			return -EINVAL;
+		}
+	}
+
+	/* Find the index of the "core" clock */
+	while (i < n_clks) {
+		ofnode_read_string_index(node, "clock-names", i, &clk_name);
+		if (!strcmp(clk_name, "core"))
+			break;
+		i++;
+	}
+
+	if (i >= prv->clks.count) {
+		printf("Couldn't find core clock (index %d but only have %d clocks)\n", i,
+		       prv->clks.count);
+		return -EINVAL;
+	}
+
+	/* The clock is already enabled by the clk_bulk above */
+	ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
+	if (!ret) {
+		printf("Couldn't set core clock rate: %d\n", ret);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -188,6 +209,8 @@ static int msm_sdc_remove(struct udevice *dev)
 	if (!var_info->mci_removed)
 		writel(0, priv->base + SDCC_MCI_HC_MODE);
 
+	clk_release_bulk(&priv->clks);
+
 	return 0;
 }
 

-- 
2.43.0

