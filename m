Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8A3C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD6CA87F72;
	Mon, 26 Feb 2024 18:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fw4KnhKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0223687F5C; Mon, 26 Feb 2024 18:26:32 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03A587F20
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d23114b19dso48282781fa.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968385; x=1709573185; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gy7lo9VP4riRrfHUOnDNTzH8uP+qiNahh5QUhwy9/OA=;
 b=Fw4KnhKOyojnU6Hqrdsu7kuDQYg7wKg3hJjFIK8tROBQK0lDPjlvxTIj9teRKEZnow
 avL5WYMGytv83eGaqDfmjzh53G9Eqn3Lfuh2UDOFJh+FGvtnkFWznquTbNzHVMFgw1Ah
 +xwPTTxSrKShWc5Y3UKiBHJVTKXdtjsm60ArIFNaSRoLNR8/Cz7KcJpzwBqt9xunTDMH
 iiGwwjfJdmm4cW9x61Q3p+Q3ytNLHUaQaxOFz+OXDCz27IG7ysumiRSuQyA0OVaDd9WM
 yt6cSZxLReCGtqku5MfDPTW1dkKniMmZ8JP0bmsmhemidEVd9DecjvnF/lwep6mZEk89
 O9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968385; x=1709573185;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gy7lo9VP4riRrfHUOnDNTzH8uP+qiNahh5QUhwy9/OA=;
 b=IvNK4bW+7VnJLQpIU6AJEugeYSiJCs7YtoJOPjMjR+I+LjwFHvzfLd1EMCZV8E2Erz
 gfM8DHTbgqdRUTRMl8UxLU0t8E2wPc+Silra3Jsl4cstkVVn7DaZ5bKfe0z829FVw3F8
 eUfonOvumFbiptr6h4CINks8LIxcToFno9MyjWdiPttsSxgi9Bt+j92fvPPIbde4W/NP
 vp1FWCsbKnlScpCiCLdZjmFr8L95cOSpuZw63tBSwq7A+b8gkExx1W2aRpJ8RPCCZLDq
 mW8V0OufzNrYxy3FpYnQxtIz/rnvUTvFLBF6wBZcSp8NH1+c0732Mtb7j9bRfNf13RZs
 jm4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTlZvoEKQlmFa4RgmjE9e3d0HA9APjMcc99FDeeNVmMRHpBYBMdzSvzDWcJ/l+gUCQDXzBe7OFl05jxtTTAplIULMYzw==
X-Gm-Message-State: AOJu0YzjbTilCYOnS4qFEHzs19mOUcX/zssWsEKJ36Fg4jnEdxecMVq7
 9lu7u2ryC+xYWkcRaJ9DvxiTKNaOXvhvZGhaTgOQnJydSklPJGiQXhfi911k0Us=
X-Google-Smtp-Source: AGHT+IGn8ri/r+dfGxfa4zUhMJR9WVOqj9n94ma/LhjcKK9v7jVHf0/nDiasaBDav4bLwXeQG9cXkA==
X-Received: by 2002:a05:651c:224:b0:2d2:5123:4d03 with SMTP id
 z4-20020a05651c022400b002d251234d03mr5068468ljn.22.1708968385325; 
 Mon, 26 Feb 2024 09:26:25 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:24 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:07 +0000
Subject: [PATCH v5 03/39] mmc: msm_sdhci: use modern clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-3-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3504;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WbAiHiP+Ske4PP+2WCzE8n7QvlRlw7OUnKXu/sGU8CU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3eylsf1rr66qqGKI/7g3vSLjcoWVqtWdmzadMz1r
 qXuhXceHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi83IZ/hnJBU75Fm11480P
 azHld0zXA+8o6bIoeBm83v9yWVUD70FGhjnh8g37HzlNSdCWmL7kkpVAd6jl0z2Rvk9qfvqrPWq
 5qgYA
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 69 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index fe1e754bfde0..059cb3da77c5 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -43,8 +43,9 @@ struct msm_sdhc_plat {
 
 struct msm_sdhc {
 	struct sdhci_host host;
 	void *base;
+	struct clk_bulk clks;
 };
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
@@ -53,37 +54,59 @@ struct msm_sdhc_variant_info {
 DECLARE_GLOBAL_DATA_PTR;
 
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
+	ulong clk_rate;
+	int ret, i = 0, n_clks;
+	const char *clk_name;
 
-	ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
+	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
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
+		log_warning("Couldn't get mmc clocks: %d\n", ret);
 		return ret;
+	}
 
-	clk.id = clkd[1];
-	ret = clk_request(clk_dev, &clk);
-	if (ret < 0)
+	ret = clk_enable_bulk(&prv->clks);
+	if (ret) {
+		log_warning("Couldn't enable mmc clocks: %d\n", ret);
 		return ret;
+	}
 
-	ret = clk_set_rate(&clk, clk_rate);
-	if (ret < 0)
-		return ret;
+	/* If clock-names is unspecified, then the first clock is the core clock */
+	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
+		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
+			log_warning("Couldn't set core clock rate: %d\n", ret);
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
+		log_warning("Couldn't find core clock (index %d but only have %d clocks)\n", i,
+		       prv->clks.count);
+		return -EINVAL;
+	}
+
+	/* The clock is already enabled by the clk_bulk above */
+	clk_rate = clk_set_rate(&prv->clks.clks[i], clk_rate);
+	/* If we get a rate of 0 then something has probably gone wrong. */
+	if (clk_rate == 0 || IS_ERR((void *)clk_rate)) {
+		log_warning("Couldn't set MMC core clock rate: %dE\n", clk_rate ? (int)PTR_ERR((void *)clk_rate) : 0);
+		return -EINVAL;
+	}
 
 	return 0;
 }
 
@@ -186,8 +209,10 @@ static int msm_sdc_remove(struct udevice *dev)
 	/* Disable host-controller mode */
 	if (!var_info->mci_removed)
 		writel(0, priv->base + SDCC_MCI_HC_MODE);
 
+	clk_release_bulk(&priv->clks);
+
 	return 0;
 }
 
 static int msm_of_to_plat(struct udevice *dev)

-- 
2.43.1

