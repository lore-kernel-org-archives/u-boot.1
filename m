Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43709C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC8C87F64;
	Thu, 15 Feb 2024 21:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mR34xaK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE38687ED5; Thu, 15 Feb 2024 21:53:29 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D663187ED1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-411ef179d2eso65065e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030351; x=1708635151; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BIuXyHba/TECDb73i0kWFoA2ClBm3iBV7wEds+RtuqE=;
 b=mR34xaK4fkRmJf2uHdtGUmdvLnuhI7b580aZWLbyES+wWcaNTBQmJO290uz9V+xKMw
 4Etcs0lTCHm5NVfojNLSbFscuulcyytF4XCPxDdyv1BONvbgOJSaUbGluvIJsUy7C5Is
 wB8JmzMgHMtG3LUasszbHMGm4k4obtbTaEl/AYRsiSqf0YIn5F9xF1jNml6lmsaBqzdh
 n+hS7NcRFkqmGyZjgBYI5W+bERp8C8QVmRkALwxOxLGoZ7MdV5RG+dSWKnwRodj5CDZJ
 UuVeoGlklXyeyLFKcJFQNybhAp4LdxGdtm3u41GzV6wkpggvQH2poYQIUqvnh8DoiQsL
 gkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030351; x=1708635151;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIuXyHba/TECDb73i0kWFoA2ClBm3iBV7wEds+RtuqE=;
 b=ZuMunb6cKjUBva4EihzfbzaHNDCiJ96bpdqfeTbF34DGR4EJmz/yk6jMhv/IYG58lX
 aGW1k5QFWE+ZXmxm6PqCw+RVs6YMOitiP510nvDXcaB/YzZpQfnI+4sOZ4wQWNFyyXYi
 kl8pNKk7yc4qIhVnUY1fMZ6pNmgeZkvILHwiZCJ6G4op+F4022+3xqeovJDOSGyX/XLI
 fPnXHzlH8dkPjYaaOXWwEFK6eNd5jck+Msb6SECZDFaHJAPFJGDEyZQ8hEFCraeGRJn5
 xmw3xxio+sYm8ZZqOvU/Rl3K526gVs7Yt0+EFdBqm2mv5Oq6Ul9Ipn+OcCNiqDDWbBk2
 bQwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3F5S8JiuULgesLJU/RXCQ/FhVBtXg3BAo6so0sjtkejaIW98MgfPvv38SmNGjpSSitaI/KHUKnw0qMTf3lOUgFBhy+w==
X-Gm-Message-State: AOJu0YzjohPtwhb+J3sMvlKQDGCZ82e/d6oDRyZABiGCMAP+Z/RlzSHh
 fjIda4brtjTP4CTm9hhFQtJtSNdUCpegw0Q456/H3u1d7Gz4QftxL5VDIPq1GslZ8BHHvx5sCkq
 x
X-Google-Smtp-Source: AGHT+IHdmgceee9eO6yGcGZUbq2fEwVEuv8Df2SFcESiefgqjWqjIpTWc8BfrkSPIlMLpEOsehVdkA==
X-Received: by 2002:adf:ef46:0:b0:33a:edaf:13ec with SMTP id
 c6-20020adfef46000000b0033aedaf13ecmr2098188wrp.14.1708030351118; 
 Thu, 15 Feb 2024 12:52:31 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:30 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:24 +0000
Subject: [PATCH v4 06/39] clock/qcom: qcs404: fix clk_set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-6-ed06355c634a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2419;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ar0lMezuSb4HK1JVZdDWZA2XsUzJ0i0dyyeTMLBN20g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlS0TO28x3fqW0R3ZFlVn4VUioXdrv0LOxCOFnCoPr
 e/H1M/pKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABOZY83wv37mTd169+YyW7uv
 OdvOrmBRjODY+WieRUx8fPSv39Pc6hgZppSH8iSeYmX40fx2699TlUW9xoHedZtDb/LqVq77yL9
 4EwA=
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

We should be returning the rate that we set the clock to, drivers like
MMC rely on this. So fix it.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcs404.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index f5b352803927..958312b88842 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -193,24 +193,18 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 
 	switch (clk->id) {
 	case GCC_BLSP1_UART2_APPS_CLK:
-		/* UART: 115200 */
+		/* UART: 1843200Hz for a fixed 115200 baudrate (19200000 * (12/125)) */
 		clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
 				     CFG_CLK_SRC_CXO, 16);
 		clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
-		break;
-	case GCC_BLSP1_AHB_CLK:
-		clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
-		break;
+		return 1843200;
 	case GCC_SDCC1_APPS_CLK:
 		/* SDCC1: 200MHz */
 		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
 				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
-		break;
-	case GCC_SDCC1_AHB_CLK:
-		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
-		break;
+		return rate;
 	case GCC_ETH_RGMII_CLK:
 		if (rate == 250000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
@@ -224,11 +218,15 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 		else if (rate == 5000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
 					     CFG_CLK_SRC_GPLL1, 8);
-		break;
-	default:
-		return 0;
+		return rate;
 	}
 
+	/* There is a bug only seeming to affect this board where the MMC driver somehow calls
+	 * clk_set_rate() on a clock with id 0 which is associated with the qcom_clk device.
+	 * The only clock with ID 0 is the xo_board clock which should not be associated with
+	 * this device...
+	 */
+	log_debug("Unknown clock id %ld\n", clk->id);
 	return 0;
 }
 
@@ -305,6 +303,9 @@ static int qcs404_clk_enable(struct clk *clk)
 		clk_rcg_set_rate(priv->base, &blsp1_qup4_i2c_apps_regs, 0,
 				 CFG_CLK_SRC_CXO);
 		break;
+	case GCC_SDCC1_AHB_CLK:
+		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
+		break;
 	default:
 		return 0;
 	}

-- 
2.43.1

