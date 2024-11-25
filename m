Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A70ED3B7EF
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82ECC899F7;
	Mon, 25 Nov 2024 09:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k5O5tje6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE53A899D3; Mon, 25 Nov 2024 09:34:35 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944FC899E7
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3823f1ed492so2794027f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732523672; x=1733128472; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKHBUoi7i9sL4zy2D4QZgFc+IVVVdBZyPOxJkJtUxdo=;
 b=k5O5tje6sgWquAOHnZZrjW/Xj39qKaNjSQjQW5Ss6+aCl9Wg67pQha+r2em1xMhrlc
 iXwxWNVmEz5ke4axnAbMrOZMtKSr4sUs/Q2acMVb4g+jBnsocVeiCPdX3o0lvDFHJz9C
 3TIfFMJAAcRkC04bwdx+WPV5sNKW9jqJ9SerhG/wpFOQOXyEkSm5EPyy7N/wlSUfo4FT
 2DykSnY/oDyboEKjfnqF6RXdgASlGzENzuxvXi8f/QGuAvfc6cNRctuLJcNwAQmLR75o
 MshQcHHNzXNOdaWKvWVoaushCC/VcG6L+gB+WeKwIp7Qkb0GjduO4VSL3wataSrb5Wap
 kPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732523672; x=1733128472;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKHBUoi7i9sL4zy2D4QZgFc+IVVVdBZyPOxJkJtUxdo=;
 b=QLOUdgDLc8EXFXJhqctwSNo5gi5RHIhw/Hw3I2nzPjYapoZZWyJ5awIA5TFbIpGGTu
 Hqi8parUB7Bkj108gAiPi/yr4BYePRdDdwTDaHDZgrSq3Rk8y3DbqtPhVwYtAjlnyW8i
 7S5EqRtPcIatzLNRiP68cYItklS8vfSo/1VOp3208gYAOcCWthDtH4447eW7Z6rEnr2F
 ihinNorxD+czRmxPUKy2sQXnndhZ9r8oNo4O+ZbKlQ2V1funieOecisiP0mNaOaaYKo0
 XumGb+GCv8GzdqZUSe0V26y8UjT3/RrLGr1TES3x5EdDFWHi+cELrmfErLTutP+c5qUz
 Y5FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPSdlf+CdH4VqU0wTqh/M0NvFcGKa8G6oxrfrE32bExrs/VtgRt+ybgVhyvXus3o0aLV8tkgo=@lists.denx.de
X-Gm-Message-State: AOJu0YzbCSeRYcj/ngwl9BcMLMVMm5/M68X4EC2CN0YpwaJD+rOMFl1Z
 /oF8W4RVJIu0mOvVUDYRwlo8/Q0rFakmA/lNwkT+jhhwYyX+hZ+K8Mexfvn/TFE=
X-Gm-Gg: ASbGncviMUb1qL8P4DqUVND56p9nJYN46rFt3dwBOO9hbYJ4W/d254ug5AcMqYCEGZj
 hBDLbyGQsnHvURFmk/PZbKAnAygWYqzI/RYFlnsm8QL9YCPoKZC01m7SgbSHJxKij855qd3fUML
 lzg1CGokgbqZyL837K23bP02zq+0pndp6QpixWXOMVIJs4cjEKXZY5GosuN9di4XhbRoa5+Vg3H
 z85WjkMqJgLH/BV6kJvhyLtZWqSYetbrm3jvqB/9BVV/AOnl/3l4dBs935dtWj/1t4+RmE=
X-Google-Smtp-Source: AGHT+IHK43dmNAghKzrYFK1Hhk1FSQlhQME/g5cz1Ti2zn7bJmNQ3RRjSp3hN1dkw4WdPIrYwFeLag==
X-Received: by 2002:a5d:64ce:0:b0:37d:34e7:6d24 with SMTP id
 ffacd0b85a97d-38259d2b848mr12516811f8f.18.1732523672071; 
 Mon, 25 Nov 2024 00:34:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825f98b3a4sm10013421f8f.0.2024.11.25.00.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 00:34:31 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 25 Nov 2024 09:34:28 +0100
Subject: [PATCH 3/4] clk: qcom: sm8650: add support for PCIe clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-topic-pcie-clk-v1-3-4315d1e4e164@linaro.org>
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
 bh=Bdz2SeZUb5BmZho1bLFOZ+RD51DphnJ1Z9qxkJ4pego=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRDaUCjLpP9/ummMwNfnKEJorMPql122ewa75t2JU
 7MHp9kyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0Q2lAAKCRB33NvayMhJ0aeVD/
 4yCAhRkY5XhYUIRbLZ/U6rGGSlitKGScU23jULlxXmwUPJ+SNsHNoiExJiT0VePwV0Tqa6jmlAvJxD
 CdWZZDCfpOiWvQu8IgvZffc0yaeDyhAdlmhumS5Zb0mYHsXvYez3o6KICIa8TrWNubT/SRHaHsWKLm
 SXOBNSISQSvth6x8SmmWJK1/m0oOFLC5LQc+D3rcvcI+U8y+ESYd5qcBWd7iBoCiojN5Mqcd1Zc56v
 UcFYjjiW0r88XB3CQxbyO95xKzDEFZjnsvYdXWI+c08sq5oYwd1fwtPyfIoK9mNZZj+oPejjdPtB7W
 2hK29LNf+Vb6Epnj/t3ieuVoR2XqdQ86MlK9fl3aGv7Bunt4QXWYbi3nzH2TmP/0kAN6ty5bPtWDgk
 CJ4ooleLRPbjYBx0eOgq7Rs4XSTC0oMJACD++ZI4dOep9L181MrbsXUlaPOxcePfHCW+zSmPt+KmWZ
 hU7YjlncocuxDiWANMF3y57ScVyLdtXJoLBQHRqG/fTW4f4m82B9mC17QpQ1DtJcMSYyKfxLxonhm2
 vHgdN4M14VyGZ3Z24KDC3hOwqvFdjWvTyDNixRUgJFlSFc/iLb7zyo6S/Ag7G5QRJEPKk+lTTM3v2C
 A2wLgXkpdSltDOX2AFi9HuH3VSbwPcnhwZj5PAtY5uK4NpzawbUmTdow9mpg==
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

Add the PCIe clocks for the SM8650 GCC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/qcom/clock-sm8650.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
index 0ce83e9b24375820016397c3c5491dd9d44edb4b..9baaecb571f6c575c0e7c48d66214c1331b6642f 100644
--- a/drivers/clk/qcom/clock-sm8650.c
+++ b/drivers/clk/qcom/clock-sm8650.c
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
 static ulong sm8650_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -81,6 +91,24 @@ static ulong sm8650_set_rate(struct clk *clk, ulong rate)
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
@@ -179,6 +207,14 @@ static int sm8650_enable(struct clk *clk)
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

