Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC0C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 693748764C;
	Tue, 21 Nov 2023 18:09:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nE894wEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FA98762E; Tue, 21 Nov 2023 18:09:37 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8165875A7
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5094cb3a036so8341770e87.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586573; x=1701191373; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DPJhInPprtSGS01+kizPo2arar41qkzyaZzz7lBbaDo=;
 b=nE894wElzEjB5aPq2l1lR7PQnHMeCCnHnHfmW2vlmZETYor+wdTV5RMoNhVEXoFs90
 TppOq3B5vBdc71Sa0gdnXemmEwBSRWx7oQIz6tdj/rqkDOqThCRtTk7JHfEbOq4YXvqp
 fd7G+nfIsEX5zBQKQ1WOUqD7zxdxanNLhYREMJub1jR+sDZPQN5oEO3YvHHwjMaz15ey
 IhAMJ0rBx+Wn5XGTNQTIbvOB4hwX1DuWHVx0Nzk2dryecP0/R1ZQjowtf0QAhIltTrQs
 PKgewVTdGaRkXU3srvSwtp2Qln5GlZJCDM2JpxgeABwvsFmM5xxqXVPHUYVcTNZ2KPvY
 N+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586573; x=1701191373;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPJhInPprtSGS01+kizPo2arar41qkzyaZzz7lBbaDo=;
 b=wKXmodKgyb9z0PK6MiefF98oZcL62SBOkOnAh1a7Jzv4neXBank+4/9yWFvAeWsB8s
 WadBw3yXW0hgIdT99426Y70bx9ZjExXQkUkKLvI/jeE0Eb/mb1vm69oz6jih6Uj5Qi82
 rOptDuuFI3FiHKyymnjfF+sPc4QVF2thDyMVWWHFpXt/XNfHGqAhmBwM//+5JoaChnaY
 smhcXKZB01g6gDcgPecqOCyyXG6ywL7md8ZuCmuWhMzkmJF6Rq+UgGUtKw2wUFXMA2F5
 CwFzTaW2m2KxUFLf9EqqDyf3O88ZklJfPyY18jUkM5WOj8kAGplzbOg2pQ6fXjwH+IKz
 zo3g==
X-Gm-Message-State: AOJu0YzJMa6KtJUjqmPq5m2jUhSen10m9WZ6RnXmP0WYRnKhDjA+J1ag
 oI2OLfKbikXVsARxFjnqgvQj/aRRGUQ8080sWaEGWA==
X-Google-Smtp-Source: AGHT+IGwqy28mSm8E2fHssL8zOuigJnoMcADVHTzkQN00y7aWX8FacDNR9JkUn7nCRy0yQNF56MdhQ==
X-Received: by 2002:ac2:4951:0:b0:503:3808:389a with SMTP id
 o17-20020ac24951000000b005033808389amr8337891lfi.11.1700586572999; 
 Tue, 21 Nov 2023 09:09:32 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:32 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:27 +0000
Subject: [PATCH 04/21] mmc: msm_sdhci: use modern clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-4-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ65afCt5L4ZcP+9ZWztj6seu5RUd3+vsj4urRJild
 DR6v7DsKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNxu8fIsGGX5h9n07uzFkZM
 CInbKXk/RXTGNa7HakZ6kqa+p36zHmT4H2N2QfhiuXDND/eT3udDdRdw/vrb16q+p1n0UvD8J6Z
 FZwE=
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

