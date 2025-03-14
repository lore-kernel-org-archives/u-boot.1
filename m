Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D277C35FF3
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 15:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47EE81EA2;
	Fri, 14 Mar 2025 16:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xjbf5hfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9364281E64; Fri, 14 Mar 2025 16:31:28 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4445A81E25
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 16:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1985170f8f.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741966286; x=1742571086; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=21x5foQgtcTOyKtLHII1zsKa5bMbZ7sza8nVxOePoCw=;
 b=xjbf5hfR27DzyyfOWN3Fzcxq71KdS8Ww5lTVjcxpI/SWnJzbjU2jazzYj/Z8DY3NcF
 Y/XToBFyowYTINFvyji/Td4KZFBjTYjFbiBA7h8aZx1AGJMwMmtKinsXFErB3nl/VJQq
 JbMdDlK+XOHmxqgxTH5bBCUDec+3PFdLF5Fw8+22o5rOLboAgXPgF51IS6kao4KQgL//
 T4aY3NRjgok5xy6Cs4PByeLO1CA/ryn7epVJmqM/HbnCmmUUQpWnu367StioaLo5jbjP
 Kku3IRocH14ZRZS4yM3Uz7AW6LBhZKcBCYntiLu+w5HDn+2udXPjOWCtOy2t4dzAXwu4
 1tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741966286; x=1742571086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21x5foQgtcTOyKtLHII1zsKa5bMbZ7sza8nVxOePoCw=;
 b=YgtKrcy5RhbkxOTJGl+8sJA1c4kfiSFAw3Jy6mrt4aQIO57iK3zP+YDBV75AQo5pdw
 Zc7pfb6fmGRnXzTZvLoorOBSjvZDhHhqTZHMVSpeiIrzkjevFFit3E+7XjchosYywtxX
 Cr2mDuupbsMBouQUk/biP/dRBjNehiIID7EU/e0X999LSb2gwWkr3y4fb8/1+SmUSa3e
 LXwZKrXSQVBbmkn1eNvbHXQXdICrzh7CPrBOU5No+zLXBH4RCA3mcS4903PwxBvEi+lr
 cNnUZx3qucIjgEZP0qkrOJAOWvny6r5i+UvNX6hYXJLoIUeetowReLEF64LVYvCsFasF
 UwZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVI15wUkWtcuKFtEpbN9TrP66l/6MVp29zmtUAKf3JXplN3hyd6ijBZEvq/o9upbEjFOn9tLg=@lists.denx.de
X-Gm-Message-State: AOJu0YzCYcjjJdxRuPnJBy0ZzOf+VkHaVqJCumIQh7KVStAM3+N+m+ua
 60ls6sI3Ou3mBkkE3PSrj7vgn4bfm+KjaRV0+ehdTy9IqOGhEIce23hFZh20Fsk=
X-Gm-Gg: ASbGncuQak/qfza25+IQl9vzkT9cOcLkzL8Y4P26gqCsE0SQ8khtejO8Q6UhPeWCYEE
 s9bAi0DWrloegMSsUiAbw1fBUksGHI2HowonGkuOKrMGMTpqJ6zbUGERRPeJEh4oIM9IH5aiPnn
 VmgWH4FQe6hkQZKLudflbLGLZdvkBlt/fj8SPIVcObdcK9TIs47DnGgddqyViyP665pzzUcJYHT
 uXsJG61nZZa7aZvAG66GAz1y3E4X7Q29J7EKaz9Qv0z/Kfz2PzGlN/dSKwWL7K+kQWdH7fucRfz
 Ia7Y7hO96KJY/U1MpLjOp+KZlv9PJ1m7m/R3nHgv3Qjw24rT6J+GUTFH0/AkxOC2N2ffJpU=
X-Google-Smtp-Source: AGHT+IEq6kqDBnx0nTveYAzEoXaMIsq8RossxrqYHYhSyt7Xuuf4lj4bsYkZ0mdlE4iAJ12Mh09bLA==
X-Received: by 2002:a5d:5f93:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-3971cd57af9mr4781355f8f.2.1741966285619; 
 Fri, 14 Mar 2025 08:31:25 -0700 (PDT)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:2b81:563b:c694:c380])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318af0sm5907399f8f.73.2025.03.14.08.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 08:31:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 14 Mar 2025 15:31:21 +0000
Subject: [PATCH 3/3] clk/qcom: sc7280: add GENI, PCIe, and more USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sc7280-more-clocks-v1-3-ead54487c38e@linaro.org>
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
In-Reply-To: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6890;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vYcCN1yZmZoxXDUTn0lAtMlt9Y5wC01HF2q5MEF/6Vc=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn1EvIbrXKIjHOSWBOrfOWv566Cj5n1AyatJpHU
 /3moI2H19+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ9RLyAAKCRAFgzErGV9k
 tusREACT3QBehpuUA4OjaURcYujxPJ+ck8KZ8gA4XOKh9Jc7vRFssqMWNW5Lg2406XEK2mxZTKb
 DpQxdJFuTdqpRKVOulmG3Ez+WSkfDPHijs/cNc0b8lngOxVztWc3lxUHWJQLQ9jt0ObIIJRVv+Q
 ohdfyr8gZ78Oj7Re6fwep3WgyxaMb0WWdEKsCwDtI72txTRRkPtL+WFCFRBXa/o6W6V6jCwE1JW
 9cbJ0yULCSqzMe5lwVxFrYzQWh2A0iSysDfYkcZ72DLC4NFn1R5c+spIcgyLf8b4YlYXB+olq60
 qrQZyhFOQmfN6EtwsXlwI1tWPpDlJscDPTZuB4EQ007dYEv16FZgvFngIpPEhVZnuOA+z8YP4pj
 T9sYCId1OttsASeWqCSqCNhn1/ljKcS4/GdB6IMOrP1TCFbrdAVQr0xZ91OVpkTGP2o93Qo3hHe
 psdmP4Sfd+cXiCd1YwUibMrKOUc7sE0Mh17FeGG6uIBd7V6Kre1UxOo/fDQ6z7cVJVzHkpJerbT
 aSmmGltxII7yach0uVYTRlMXCCgd45ZuBMgZ9brt5JYhYTWsAamGhEyOuhngL7WjMCCkMD+gQoP
 OSw73a9kFNjV0A1uYmF+qepCc5K2p1tIGmKpvqwneblSbGUIwBUu58CV8xvfcCkT8DycuMqNypj
 OFfaAu+GdfBuvLg==
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

Add support for a bunch of new clocks, including PCIe, GENI (for all
peripherals used on the RB3 Gen 2), and some missing USB clocks.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 104 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 2cbc01b6e0a4f1db0e4a894cd869b532d6b3fa45..8691f08109b39639d8a5defe75161049399bf682 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -15,31 +15,66 @@
 #include <dt-bindings/clock/qcom,gcc-sc7280.h>
 
 #include "clock-qcom.h"
 
-#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
+#define USB30_SEC_MASTER_CLK_CMD_RCGR 0x9e020
+#define USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR 0x9e038
+#define PCIE_1_AUX_CLK_CMD_RCGR 0x8d058
+#define PCIE1_PHY_RCHNG_CMD_RCGR 0x8d03c
+#define PCIE_1_PIPE_CLK_PHY_MUX 0x8d054
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0_ODD, 1, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_sec_master_clk_src[] = {
+	F(60000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 0, 0),
+	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
+	{ }
+};
 
 static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
 
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
 
 	switch (clk->id) {
-	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
-		WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
-		clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
-		return rate;
 	case GCC_USB30_PRIM_MASTER_CLK:
-		WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
-				     1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
-		clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
-		return rate;
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_USB30_SEC_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_sec_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, USB30_SEC_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_SEC_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, USB30_SEC_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_USB3_SEC_PHY_AUX_CLK_SRC:
+		clk_rcg_set_rate(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR, 1, 0);
+		return 19200000;
+	case GCC_PCIE1_PHY_RCHNG_CLK:
+		clk_rcg_set_rate(priv->base, PCIE1_PHY_RCHNG_CMD_RCGR, 5, CFG_CLK_SRC_GPLL0_EVEN);
+		return 100000000;
 	default:
-		return 0;
+		return rate;
 	}
 }
 
 static const struct gate_clk sc7280_clks[] = {
@@ -49,15 +84,37 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
 	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
 	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x9e07c, 1),
+	GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x9e010, 1),
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x9e080, 1),
+	GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x9e018, 1),
+	GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x9e01c, 1),
+	GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x9e054, 1),
+	GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x9e058, 1),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0x8c004, 1),
+	GATE_CLK(GCC_PCIE_1_PIPE_CLK, 0x52000, BIT(30)),
+	GATE_CLK(GCC_PCIE_1_AUX_CLK, 0x52000, BIT(29)),
+	GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK, 0x52000, BIT(28)),
+	GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK, 0x52000, BIT(27)),
+	GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK, 0x52000, BIT(26)),
+	GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK, 0x52000, BIT(25)),
+	GATE_CLK(GCC_PCIE1_PHY_RCHNG_CLK, 0x52000, BIT(23)),
+	GATE_CLK(GCC_DDRSS_PCIE_SF_CLK, 0x52000, BIT(19)),
+	GATE_CLK(GCC_AGGRE_NOC_PCIE_TBU_CLK, 0x52000, BIT(18)),
+	GATE_CLK(GCC_AGGRE_NOC_PCIE_1_AXI_CLK, 0x52000, BIT(11)),
+	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
 };
 
 static int sc7280_enable(struct clk *clk)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
-	if (priv->data->num_clks < clk->id) {
+	if (priv->data->num_clks <= clk->id) {
 		debug("%s: unknown clk id %lu\n", __func__, clk->id);
 		return 0;
 	}
 
@@ -70,8 +127,31 @@ static int sc7280_enable(struct clk *clk)
 	case GCC_USB30_PRIM_MASTER_CLK:
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
 		qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
 		break;
+	case GCC_AGGRE_USB3_SEC_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_SEC_MASTER_CLK);
+		fallthrough;
+	case GCC_USB30_SEC_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
+		break;
+	case GCC_PCIE_1_PIPE_CLK:
+		clk_phy_mux_enable(priv->base, PCIE_1_PIPE_CLK_PHY_MUX, true);
+		break;
+	case GCC_PCIE_1_AUX_CLK:
+		clk_rcg_set_rate_mnd(priv->base, PCIE_1_AUX_CLK_CMD_RCGR, 1, 0, 0,
+				     CFG_CLK_SRC_CXO, 16);
+		break;
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		clk_rcg_set_rate_mnd(priv->base, 0x17010, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
+		break;
+	case GCC_QUPV3_WRAP0_S1_CLK:
+		clk_rcg_set_rate_mnd(priv->base, 0x17140, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
+		break;
+	case GCC_QUPV3_WRAP0_S3_CLK:
+		clk_rcg_set_rate_mnd(priv->base, 0x173a0, 1, 0, 0, CFG_CLK_SRC_CXO, 16);
+		break;
 	}
 
 	return qcom_gate_clk_en(priv, clk->id);
 }
@@ -97,8 +177,10 @@ static const struct qcom_reset_map sc7280_gcc_resets[] = {
 
 static const struct qcom_power_map sc7280_gdscs[] = {
 	[GCC_UFS_PHY_GDSC] = { 0x77004 },
 	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
+	[GCC_USB30_SEC_GDSC] = { 0x9e004 },
+	[GCC_PCIE_1_GDSC] = { 0x8d004 },
 };
 
 static const phys_addr_t sc7280_rcg_addrs[] = {
 	0x10f020, // USB30_PRIM_MASTER_CLK_CMD_RCGR

-- 
2.48.1

