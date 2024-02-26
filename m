Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC52C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F30187F91;
	Mon, 26 Feb 2024 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LsgZS5bB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E836887F85; Mon, 26 Feb 2024 18:26:34 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EFD387F23
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d6fe64a9bso2643252f8f.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968388; x=1709573188; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IPC/7S3FE0TL++yPkLkVnL3GlOOYKaK7mUzqm0pkkkI=;
 b=LsgZS5bBCkPw0eIawmImo0AOpHSOY8Mgblfu1KYc/7n7PiwTgu/OI3WtydyzBTZlSW
 iFEgT5etfgzuoX7OQ+geQRoUQT3kWo1v3A17wmyzSbG/818rmbQXA/zynw4q8Z2UfdhE
 0FgFMybun9I082dy1Yd9IJJf8hwLJXQ5ixOLPuwHvgArEINa2XKurkmDXIjs5/ALjMoj
 qudv4VtfZTXnLyzOIcPki17E60JM+1CGsio/pDq8GjJgrCcHT7jokhrFkj0loq4f8CgN
 Wk+Icp74+60eKFDMvT8jLNxReM7ddmYP0Cgb6PNysz4X3oZqfxf7QjFuJTLlC6Dz0DyJ
 /g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968388; x=1709573188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPC/7S3FE0TL++yPkLkVnL3GlOOYKaK7mUzqm0pkkkI=;
 b=khst8/SULb7TOwJv2trK1XNC9w9b5yKWZWKyMNDYn6hkSAMSxUqCUs7S3upgqO6oHI
 +U6FAx1m8i1VZh1d+Byc7IUcALLoqLPZyzslYsyChFgbvaiGLaRo7X5KDb8rwuJBnF6O
 863zv3xO2JpRPWp0iePq9iAkx4ndcKLMHjjU2iKo95zPQBWbQEPT/Q2Y3qst3DQ4qwb8
 QUrBaNzclFI7YVY9hDYTLz0SaJvDtK1nQuvOTlWoI2ru88Kk4dPsAtxvHLyRiAm8IQdu
 w9zEycHbUNdbpIzO3szbUjWmDORJmoPMS3BimU73cEpX+sW+tNcoMXbUN5NR48yOX4e2
 nDtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2C/4sxKznpgIDzYcAHgqHi3Jem8Oc8SYcLUSzA0VlmbTEG3T4wBmYxraJgdA8mqtNzUPA5jI/RbiDwxEMGIUEYBSWrw==
X-Gm-Message-State: AOJu0YzzSV+l3yi9Py63VYq2k0W25MCv4Wizh4oX30Q7J0jtyk8rqOaT
 MiIjvI2wqBKULRM6HiS053mI4jV8PSZaWL5Er1ucfGtUAB6xku3b0c1dvOjWnfI=
X-Google-Smtp-Source: AGHT+IH8mayc8leI0AbfqAuCnQI54vwfvOjBXhueN+jHW6mDyOrpDRQykpi8Jbup7vkjTURe0ufXlA==
X-Received: by 2002:adf:f78d:0:b0:33d:1656:21fa with SMTP id
 q13-20020adff78d000000b0033d165621famr6419132wrp.24.1708968387939; 
 Mon, 26 Feb 2024 09:26:27 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:27 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:10 +0000
Subject: [PATCH v5 06/39] clock/qcom: qcs404: fix clk_set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-6-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2816;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=T09SWNq7zmrZW/dvXhLpaVLY4zl1q1d3kGQjbkThN9M=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3fOSTn/ZWeEdsvHptnZK//NDTafU9E472ww07HYi
 PL+jmPrOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEplxn+CvTv3gy57X6zUZB
 M2aFHt410eprcMl93ti/7UU6f+fN3HKL4Z/topWrijqrOi4FnjV5OcuBn5mnISXZ5q7wbk4Nt83
 rNu4BAA==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcs404.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index f5b352803927..958312b88842 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -192,26 +192,20 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
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
 					     CFG_CLK_SRC_GPLL1, 8);
@@ -223,13 +217,17 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 					     CFG_CLK_SRC_GPLL1, 8);
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
 
 static int qcs404_clk_enable(struct clk *clk)
@@ -304,8 +302,11 @@ static int qcs404_clk_enable(struct clk *clk)
 		clk_enable_cbc(priv->base + BLSP1_QUP4_I2C_APPS_CBCR);
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

