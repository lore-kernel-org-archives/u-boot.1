Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5CBC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BB3877F3;
	Tue, 19 Dec 2023 17:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iTn62wJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBB64874F3; Tue, 19 Dec 2023 17:04:30 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E457D876E4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d12b56a38so38480805e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001865; x=1703606665; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DPJhInPprtSGS01+kizPo2arar41qkzyaZzz7lBbaDo=;
 b=iTn62wJekkoM2ztqPGp+wu88mhvkgsEuO8XaVYH4o23G7d0NNBhMOamP6H9IdNc+gE
 nPM3CB2gpdHZFjMF5XWX+VNs1GfW38oiYrK9vJacmp7CUWxQXvAXkVHPZ5uKRUU8AppZ
 CX85ywGkdez9chP7MUmV8mUMbx2pnA1Lc6PHcr6KcwdCw//hufk6u7Oqy9QcNAHxsx9q
 NGE+i3FrqLJL4m95NXMZ7FAY39SgXUD3DVj6kRLHNaM3UnSr/jzP9IgK98czST4r5p06
 7d/2h7g4Fc2LygcNkldrKQ1s19pRpUK1zCaWpTKz6EokT/VfmhNfB7zT/Ic9csDIUSmZ
 +u4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001865; x=1703606665;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPJhInPprtSGS01+kizPo2arar41qkzyaZzz7lBbaDo=;
 b=s6duVIZ8Yz0SDa3pku/Zs2dNIKNdjqYGzJm0ny6F+PeI8vdN+HLTtyEnfQMLv51PU1
 HxO6ljoxpUvu8jJVf5nFlcmpO2t+LRIZcxGzn60d8T4Me48w3grvWTEzCc32RrMPeKrL
 HIAd/aiJul7FetldhiePmBYy7I5Oiprl7imO8Df2zygcY8GpY0tVqZ410yo3rkuO94iM
 +B3q1HhQRDaWgO93dTAZppWe7f79pcWob/zebVjzTZaM50j9y3+iQP5FKfWsi3JhSVrU
 PMDQ4Y33oKlXT/v3Go1wSi3ezcZFt3zoK+8lMlwX72nYtMZk8bceCE4HG8PL46HgxXM1
 1NpQ==
X-Gm-Message-State: AOJu0YxJQjwjs+kYrr/7G9apy5Gyr/ZBxCaXibhtFZGyimnsgUpIcBPG
 OmT45s8c9lTXzEe2DY/vNvJv+w==
X-Google-Smtp-Source: AGHT+IFgF9xg/ISIIsQr0zkHa9aoXQmhRfXc3fZRl4Fi+Kwxxs//en9Jvk7svFoWIoYn4FZ5UnfkpA==
X-Received: by 2002:a05:600c:138e:b0:40c:4b4e:959d with SMTP id
 u14-20020a05600c138e00b0040c4b4e959dmr4271115wmf.167.1703001865376; 
 Tue, 19 Dec 2023 08:04:25 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:24 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:04 +0000
Subject: [PATCH v2 03/32] mmc: msm_sdhci: use modern clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-3-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3016;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Ujb36j4MQVuf19gAZZ2EIB8TJJKZEN52OmMZLBaZVto=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Yz5bT9mvhTbmbb2z9p55TYnDzi9NpnN6P271F6w7
 ZRbJNPMjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRjM0M/5Ntq13e28sdzY/Z
 qX3LV76sUma/ukjvrpCVh7+qibKqyjL89+YPXb5j67u/LVcfny3/nvBogqDutZfPJmY+mSQTeYR
 JzgoA
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
2.42.1

