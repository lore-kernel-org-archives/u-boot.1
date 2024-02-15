Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3001C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0272787F2A;
	Thu, 15 Feb 2024 21:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r/DRE+C8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D49C087F25; Thu, 15 Feb 2024 21:53:01 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2722087E56
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41232741dc4so57905e9.3
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030348; x=1708635148; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SsqdANfMWbuVxdecVrYWNUH1yqMAfaRWXbnEFhSzf0Q=;
 b=r/DRE+C87WKXEfrBovfzbUU/y1les4ghcNfsK3Vn8JuwFJKtupeCAUm0b8+Fe5wTeG
 oEPH+oUAFQKw7hRSgPmCRrg1VvH5Dl4vviOJmieo39CtKQ0KBBMSz5asRXxqz+kHjowl
 un1AM+6G0HT042rvb44/mLv60hO1O6XeK6xGiPjB3LJCHC1ChrLcffJ9hRJVtNTFnQTI
 VtCXOAlWe8/ii5sLygfM2KQNSO6fyBCy0LPOvPTyKBYHzawG7TOYRJLbONGpgjJLi5Fs
 es1NY0yxmxBqYI7RIiIvK1u5w9vG6fqWLNW+ltZQK1bezG5UvQzI3IaoD6F5SNgSWMI4
 tAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030348; x=1708635148;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsqdANfMWbuVxdecVrYWNUH1yqMAfaRWXbnEFhSzf0Q=;
 b=bOcXpNIWeICDLccSZN/U+GBHA3MEhkziDJ7iz0tCO8wLtqbCkKg6P4oIbn9FXLwf+b
 MFKZZxY9OBDbRCoPDX3zNODIrafpTjZ8DP3lUoHHuwvjXIb0rGFhYK5PxdeHeUAoZHZk
 4tzVct0r2FXb1GE5aqXCKyCaMDmEYjes2YeMTEcbQKTsbpbnBepuu5Ynl7stQUlqFARf
 S4iXW9nC/nQCP0UmIHz99FDQmpvRq//cz5duRZ+AZcEVTqmctjVLTeh2gXxouuoTQhHY
 tFcV4m2c+HVz1fWo/iPCfJzurKha0u77+ZMxu6s4J6YsxIttkPeccVpniJW4I9cWGSaz
 RCTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJtEz2hnv9FOrujcTV+y+SlGjObTGF/HUoRAkHW1r0QBWqc78hwZIAdJiYHQmW674licPMC0ObiZ2VFBVw50I0jOnrYQ==
X-Gm-Message-State: AOJu0YzNi0q8wFaQmCESt3n53arKpK+xSFbFunecE62QgML46C1leAr2
 b8LgRbYyZQzpP9HSRV0Q6BhGZkGHR8Tq1X5z8AEw+wl/9vAPhZzzQgaZXoky9R1s0XdIJRjix6P
 P
X-Google-Smtp-Source: AGHT+IGyEOM6GSUwQaHoeX28Q6L8TZg95olOSH2bUCgbzRICzLP0ue/Gy0YsoUBhME34Viy5+YxPZQ==
X-Received: by 2002:adf:f488:0:b0:33d:7f4:8ce4 with SMTP id
 l8-20020adff488000000b0033d07f48ce4mr1496336wro.59.1708030348243; 
 Thu, 15 Feb 2024 12:52:28 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:27 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:21 +0000
Subject: [PATCH v4 03/39] mmc: msm_sdhci: use modern clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-3-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=e9xdgw2JqebGrluwSTHSO2hp+eVKBlJB6+PnmFCeF5E=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS2Sj4z3v8nMZDHcf3yjU9j32olP5kqd5FjKxuZjf
 bGrMOlVRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIJXuG/4lLGBLcbyi4T22Z
 pDbhawzPsdiiwgbr6bGWxcKi37ZsdWZk6Hte2CqncS9jXfsMJYeoM7tP/disEFmmxxOw5tJJPeU
 tVwA=
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
 drivers/mmc/msm_sdhci.c | 69 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index fe1e754bfde0..b63538fce20c 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -44,6 +44,7 @@ struct msm_sdhc_plat {
 struct msm_sdhc {
 	struct sdhci_host host;
 	void *base;
+	struct clk_bulk clks;
 };
 
 struct msm_sdhc_variant_info {
@@ -54,35 +55,57 @@ DECLARE_GLOBAL_DATA_PTR;
 
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
+	ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
+	/* If we get a rate of 0 then something has probably gone wrong. */
+	if (ret == 0) {
+		log_warning("Couldn't set core clock rate to %u! Driver returned rate of 0\n", clk_rate);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -187,6 +210,8 @@ static int msm_sdc_remove(struct udevice *dev)
 	if (!var_info->mci_removed)
 		writel(0, priv->base + SDCC_MCI_HC_MODE);
 
+	clk_release_bulk(&priv->clks);
+
 	return 0;
 }
 

-- 
2.43.1

