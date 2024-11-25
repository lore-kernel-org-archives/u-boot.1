Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69B5D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36392899DF;
	Mon, 25 Nov 2024 09:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hRg8YQ9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE1D8965C; Mon, 25 Nov 2024 09:34:35 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BB7899D4
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38241435528so2684140f8f.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523671; x=1733128471; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AEMFBLDOfj1lrbfwaS3o11j6YNe04Vv2+BAtjKZcbao=;
 b=hRg8YQ9lay2DCAgbUXOL9LyBoMtbQGPVI2wmPFyItnacgXhIgIO9qCskMpkjmOXGJ2
 h9jKGikjx1pGC2XVC2Idc+CLoyQzt77mwl3raUEwN64Fx29xw9BS+fBDz6rBEKr5RWLW
 BTkMqx0Rz/ZCb6voafTHtA1PBZiZSN8xngphHzJ6lt2TM+fUWjxr7NwrSYWqt5PkwMje
 OgFg7n5UsEk6rHNUhx/kcw4jJn0Sp+RBPVrFaO52iicjlI9M0sDZoo1MprIAuOuZSFey
 /zSEtCC2uftRveQxQ/tykoHfrMWGn9ro0xoNiHHjm9+E5jMPJvk3Ssh9dedRVRHUJbDx
 5cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523671; x=1733128471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEMFBLDOfj1lrbfwaS3o11j6YNe04Vv2+BAtjKZcbao=;
 b=JnqHfcREHx/tPN/ldKfEUyaIA8eEq+A2icp25uS4fvJ/FaHYCw6BA297zfD3X2Blsg
 Cx70W+Kh2kB/Y9GtD8aONQR65wjWXwFgMLqXBG57c4ohtW9LPv2550j/HiNnEeC8/rOt
 wpkX+B7XIVO5/bDQ0sg0kHBFCnV2Cc3nUoz9JvSWnqYGtwa4EoAjEKLVitwj2GOqkDOZ
 WDHbn4gpHni+2cTCdf6UqbBIQuDZwXPHBntWLs6vhI0Tt3YxJJyI9wa2bDSdulmHmL4C
 sHb6siFwS8WrS5EHaY1G4kA6qZYhv5Mv98dd4qR8cywHQmvtwm9Do7sVeGGupQEQVZ2c
 yDnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYU3b4f0k4wUgbY+mI8Dkc9sg6gbUV8HsXnez2WDEeiWWEf1k9hJoJ+g3SyDisNRhnAXUXBOM=@lists.denx.de
X-Gm-Message-State: AOJu0YyOfR2Pz7ZnRNRswUDJ7BDbKa0wJug7zOvrMvIFEwb1DDki5umj
 FggVnyTO+ZeRB7za1S5h+hI2OfSfAdwgqtjMiYv4EcE4cWlXz8tzcR/bTrQw08E=
X-Gm-Gg: ASbGncvFrtvTmf2HyAX7yTTE2qHB3U1/e19hRyhnqBXrF5JzcIrjNEVnEPJwJiBokId
 +pYeKBZKDkR5BWB4FeXzKBAKUmWM9N0QGQGjr2K7YzGrfFt45U/w424fuZ7qHR9/+wHO4mKqHdn
 jVXUUao9/hom+/Z562E47+3wjZ5BwzqoDpRu4+9Dcft9sPiibMWE4SGfRzr6G3VsfzmDr+T0VaT
 4d9mipMyNIhb9uYSMxS5YEJmhvkOW0B9xHR6Sd+GIi5X2M+0aRZO1DfMvaMudWSu+tjFeg=
X-Google-Smtp-Source: AGHT+IHUbRQHTMgzhvBTVIME+NyYloNmu2/gZxvuHCTXgQMhuWN2+gIObozUWjrEZJthR7gHLSqpTQ==
X-Received: by 2002:a5d:5f89:0:b0:382:43ab:7d68 with SMTP id
 ffacd0b85a97d-38260b46e1fmr9618802f8f.12.1732523671221; 
 Mon, 25 Nov 2024 00:34:31 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825f98b3a4sm10013421f8f.0.2024.11.25.00.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:34:30 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:34:27 +0100
Subject: [PATCH 2/4] clk: qcom: sm8550: add support for PCIe clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-clk-v1-2-4315d1e4e164@linaro.org>
References: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
In-Reply-To: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7v8yHf1Xr5hvCGhLH17xt8vT38yWqbNI8HP3CAE9U9s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDaT79p41vv0Q7UbtpW/HMcQHMSnX+rk+SWMwYoH
 4Brfb8+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q2kwAKCRB33NvayMhJ0U87D/
 0Vwm1pLfmG8Rs9lQ+eat4NAA3FC9TeRMEfWn5K4tBKW0P4wSYKhzj1AG6WmGVoZf0ri6YC04+bO195
 PTJtzNljmwfFhiIy6T8tThGF6K1InLS82Xmnip8yzMJZpb37c4s9z/CBHVtheG+iSGjmZbExSVSdZP
 KCXXJrgbBo5QStnLiqXvfDehquJ33iDSnBTZu5TjMeGsPTW+d+C87pqOIxAe/DiPerPOhNHOGPnq92
 RKfXkay5oNdU7OFDBW8tMkC9LwFT3ZyvpEgsoZQaR7uErrlETRfcIluZJZy6TmZ2pGUj4jOyzDtGEf
 EbMrzyrBJ6ZiEDY5J4zno0BiCpbO3fl6Eoa2c6vGAfjZyqMg+PZjamVi5kHD/Onn4Zv4XEf2GB69r1
 EmKxcrcLWiCS6VQrxuno+zmCPdyWrwWuFQ/JKs45kQbP5lZmT0Z6PGJaet9pC5x8s08SGw7GRfi2Ku
 e0JYvqxrbkZHobJl9pSbzEYiVGbfu4qkDZo3bJ6Sqj5d5ighxbG09J+YI86CymkjPZcB+pW0fceI22
 SuXxeUrRu3MBAoqjBquaSOKsAzfmDXoNlrf2h1SGgZYgS9BausvUZqUrAPKp+Jm62LlV5bzEXZiD1i
 IBKy1Nmtdz8Whvq4S09GqNnGWzynC8YxAMhYqR/xtwnroV+TYNanHecX67Ww==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add the PCIe clocks for the SM8550 GCC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-sm8550.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
index c0249925cc7eb165faefea35ef29c5ff59faf07f..62b5a409e8e08243ad53a0bc58af1c7754a3d950 100644
--- a/drivers/clk/qcom/clock-sm8550.c
+++ b/drivers/clk/qcom/clock-sm8550.c
@@ -57,6 +57,16 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	{ }
+};
+
 static ulong sm8550_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -84,6 +94,24 @@ static ulong sm8550_set_rate(struct clk *clk, ulong rate)
 	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
 		clk_rcg_set_rate(priv->base, 0x39070, 0, 0);
 		return TCXO_DIV2_RATE;
+	case GCC_PCIE_0_AUX_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_aux_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x6b074,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_1_AUX_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_aux_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x8d07c,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_0_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, 0x6b058, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PCIE_1_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, 0x8d060, freq->pre_div, freq->src);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -182,6 +210,14 @@ static int sm8550_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_PCIE_0_PIPE_CLK:
+		// GCC_PCIE_0_PIPE_CLK_SRC
+		clk_phy_mux_enable(priv->base, 0x6b070, true);
+		break;
+	case GCC_PCIE_1_PIPE_CLK:
+		// GCC_PCIE_1_PIPE_CLK_SRC
+		clk_phy_mux_enable(priv->base, 0x8d078, true);
+		break;
 	}
 
 	qcom_gate_clk_en(priv, clk->id);

-- 
2.34.1

