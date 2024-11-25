Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE39D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D689A89A0C;
	Mon, 25 Nov 2024 09:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nZQWnqCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FC189656; Mon, 25 Nov 2024 09:34:36 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CBE1899EF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434a10588f3so2444575e9.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523673; x=1733128473; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=03aTthycV3OdJLwgk9FJKu0Kw873OtZC5APpwUnuCII=;
 b=nZQWnqCkTda1xsMMmG/BXUQOCFa+1UAic8a8gwo1LG4VCCzyAGDYKZGpqnoRC6FXg8
 e6FP6AtS/IO8LUEa1gC1Np/12p+heQy2LvkcVYnSP7PtluBBcGPb7Lmv02IRxh8M+ekY
 HomEK9bCiKIiJBeYVq9334Om+uI/hStnvMjhJXdCMlA4DP+ZO7e36GivymXRSmidNtb8
 OjSFArEkqy8nFDjhrcwODfHOuGnZkvBQ3Tt++8zTdT4+J8FwSema94JhdflT+qgqm3Rs
 F/jRqUoZFtlLeBlZW0v7Cf8JUidgTHCBd4hgY39z76olshEeX1jeSXHpFtQNq/gP4c39
 vjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523673; x=1733128473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03aTthycV3OdJLwgk9FJKu0Kw873OtZC5APpwUnuCII=;
 b=fIdHN7fm04MxhREtQGcrw0vqQwV2njk73SEs1J0w1E9pO3F1/CHBI1TVFaQWN0GFv5
 amtClBHSucoDVSAigCN58sHgcSfmZWQnGDMa0I+xdVhBTCMFOhnpsevi2QTzikPvDbQ+
 iuIv30XAkbDiFBC64LI/vy4Ezhqet64Ucd34wkf/J/WPtb0r3XGBJy7w6Sib5z1vFfNa
 nVojJDnnvm9c/OSS9/ol/L27c9D5tSZr/YTCkRRzT53qWVYyR85eru0sImCHMFfq2Acn
 4VRLQv7fmHEMnO0tm+JD/wDXPlPAYifB3P1+h/DPiVFknrE2uQxkkiiE24EmPXhBXklk
 VvmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs4xPCmq+ysfNG6FKf/Duj65EJxhkFTPTRQIdrbsHKYlM2roKhuKGA7qD3PV6GfwPd7Z9ELYo=@lists.denx.de
X-Gm-Message-State: AOJu0Ywle3nGT9+fJpiI0v2KO5jpqpfDgdWEB9UGnqvkpq+TDRApq3dS
 ozXYmmH0s6VXiqZY47t/OKKiFFoU+4DTT7fR9CcyJYLcnZPli9K//tIhGak9MT0=
X-Gm-Gg: ASbGncsdcHDw0bpJNfsopmvuBm61LpbJRXJnKY9a5Sj53kJfAWQ7qCaWRtY8LX5F2bU
 OJEcJs4tUT3C4trSzLEkHoB7OJDJAy168/pqmOMi3dnW6NwlWbOhmH8xiTcSeBQ3SxNGcjX+man
 i38WF75Bj9Y5GLh2QNE7omAv/EDGpbS9Id8/Jw2zcu/sLQan8tzs5d2CMDmazjOifMgUzpkr4Vh
 2KB7Q/XsxF5OpOgm8jr8oIzel+Vus2/1HPuW7djdMbh7bkZ1f4mzRWWaq5+kUQjHpQf0fc=
X-Google-Smtp-Source: AGHT+IFu3jQY8DOOmQcgmW08+z8h1VlS5lD0Q6fez0XD0aAHmvw1hWsYQ96QDwIQZnYCPefM9pouDg==
X-Received: by 2002:a05:6000:280a:b0:37d:45f0:b33 with SMTP id
 ffacd0b85a97d-38260b486aamr6943403f8f.9.1732523672820; 
 Mon, 25 Nov 2024 00:34:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825f98b3a4sm10013421f8f.0.2024.11.25.00.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:34:32 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:34:29 +0100
Subject: [PATCH 4/4] clk: qcom: x1e80100: add support for PCIe clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-clk-v1-4-4315d1e4e164@linaro.org>
References: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
In-Reply-To: <20241125-topic-pcie-clk-v1-0-4315d1e4e164@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=inxIrxV+QhEnyAQS3kecKBNJRShDukKNPdrpi3g86RQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDaUYyA9HHppQtnEywInIyebQXpJvscdFmBLxmRv
 B1XLXu+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q2lAAKCRB33NvayMhJ0QBHEA
 ClCeJOyDk6KwO+vPn5RGU/DCKZxJ7RTkbj5545tzGYTdKSZTOvSgtOubHvnnGiL8g+x7rUKC/DKxsh
 JfgEDXaeQfVHymzFABp9gls/gK60Nx5AZSRwXH1pemW8SxekNYr4Gdzx/OaU1stDFbx7NeDt2R6JNl
 1KdyxsmCQ5kmOCmQV4OuXMkBUL1FitJR4ogV4j/VkV0lPaxQp3sY907wTtqxJUUWboAqRN0NhkUkfH
 wJ0op2PJ/3hUxASkTupsZf0KBK5cQYID+EmDZB/WXjLFOz5hjDfZ6SDozcc7b1VpvJXwk/R9++7JyV
 xJbFPlPHOX4mow/Le1K9Zl2f2kx64Oe20dfBj77U5K+yQz55FDWSHiorUSlN9vL3tju422waw6fRKv
 8osXoggYtLMlPZve8UCS5UVwB1YKK42xKdJVev/nh9RlcwlZYHx8qaxxtymagY4p559jxrcYP8nkdB
 uyOdiyfW77/9I0xxXsoFSE5AE5dsbGgGzJ0m3WSS84/vCKQZW+NWQ2k4fZscdBGg1GdyXUQU0voUQd
 vDiJYVx/mHUwCYwG79Yc8U4xGoD9GfTKhVp9vg2ayOH+gNw4pMYui0HzzfA+5BWt1w36FVVsvXc0BU
 D6xoxm07giJAvjIk5MUtgGd7l2yfuEBorvD1T+LBF102Td2ZXU6+jNYmfKJQ==
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

Add the PCIe clocks for the x1e80100 GCC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-x1e80100.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/clk/qcom/clock-x1e80100.c b/drivers/clk/qcom/clock-x1e80100.c
index 6bcd705f6c8d40dc477c55fe1f594df70e1187ad..bd9c6ed1c8a0b4ca0b5164d849efa5c0755c1e2e 100644
--- a/drivers/clk/qcom/clock-x1e80100.c
+++ b/drivers/clk/qcom/clock-x1e80100.c
@@ -54,6 +54,16 @@ static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
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
 static ulong x1e80100_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -78,6 +88,24 @@ static ulong x1e80100_set_rate(struct clk *clk, ulong rate)
 	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
 		clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
 		return TCXO_DIV2_RATE;
+	case GCC_PCIE_4_AUX_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_aux_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x6b080,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_4_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, 0x6b064, freq->pre_div, freq->src);
+		return freq->freq;
+	case GCC_PCIE_6A_AUX_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_aux_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x3108c,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_PCIE_6A_PHY_RCHNG_CLK:
+		freq = qcom_find_freq(ftbl_gcc_pcie_0_phy_rchng_clk_src, rate);
+		clk_rcg_set_rate(priv->base, 0x31070, freq->pre_div, freq->src);
+		return freq->freq;
 	default:
 		return 0;
 	}
@@ -86,6 +114,24 @@ static ulong x1e80100_set_rate(struct clk *clk, ulong rate)
 static const struct gate_clk x1e80100_clks[] = {
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x770e4, BIT(0)),
 	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_PCIE_ANOC_SOUTH_AHB_CLK,	0x52000, BIT(20)),
+	GATE_CLK(GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK,	0x52028, BIT(22)),
+	GATE_CLK(GCC_CNOC_PCIE_SOUTH_SF_AXI_CLK,	0x52028, BIT(12)),
+	GATE_CLK(GCC_CNOC_PCIE_NORTH_SF_AXI_CLK,	0x52008, BIT(6)),
+	GATE_CLK(GCC_PCIE_4_AUX_CLK,			0x52008, BIT(3)),
+	GATE_CLK(GCC_PCIE_4_CFG_AHB_CLK,		0x52008, BIT(2)),
+	GATE_CLK(GCC_PCIE_4_MSTR_AXI_CLK,		0x52008, BIT(1)),
+	GATE_CLK(GCC_PCIE_4_PHY_RCHNG_CLK,		0x52000, BIT(22)),
+	GATE_CLK(GCC_PCIE_4_PIPE_CLK,			0x52008, BIT(4)),
+	GATE_CLK(GCC_PCIE_4_SLV_AXI_CLK,		0x52008, BIT(0)),
+	GATE_CLK(GCC_PCIE_4_SLV_Q2A_AXI_CLK,		0x52008, BIT(5)),
+	GATE_CLK(GCC_PCIE_6A_AUX_CLK,			0x52018, BIT(24)),
+	GATE_CLK(GCC_PCIE_6A_CFG_AHB_CLK,		0x52018, BIT(23)),
+	GATE_CLK(GCC_PCIE_6A_MSTR_AXI_CLK,		0x52018, BIT(22)),
+	GATE_CLK(GCC_PCIE_6A_PHY_RCHNG_CLK,		0x52018, BIT(27)),
+	GATE_CLK(GCC_PCIE_6A_PIPE_CLK,			0x52018, BIT(26)),
+	GATE_CLK(GCC_PCIE_6A_SLV_AXI_CLK,		0x52018, BIT(21)),
+	GATE_CLK(GCC_PCIE_6A_SLV_Q2A_AXI_CLK,		0x52018, BIT(20)),
 	GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK,		0x52010, BIT(3)),
 	GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK,		0x52010, BIT(0)),
 	GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK,		0x52010, BIT(4)),
@@ -118,6 +164,14 @@ static int x1e80100_enable(struct clk *clk)
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_PCIE_4_PIPE_CLK:
+		// GCC_PCIE_4_PIPE_CLK_SRC
+		clk_phy_mux_enable(priv->base, 0x6b07c, true);
+		break;
+	case GCC_PCIE_6A_PIPE_CLK:
+		// GCC_PCIE_6A_PIPE_CLK_SRC
+		clk_phy_mux_enable(priv->base, 0x31088, true);
+		break;
 	}
 
 	qcom_gate_clk_en(priv, clk->id);

-- 
2.34.1

