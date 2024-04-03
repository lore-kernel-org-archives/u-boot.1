Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40DECD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E868883A8;
	Wed,  3 Apr 2024 14:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QL4PZfnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEF7882E4; Wed,  3 Apr 2024 14:07:59 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D31E8839A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so7368397a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146076; x=1712750876; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=QL4PZfnbG/ZULb77vB1YzgLdNkPzzlSLr00pPUi+sLDdw2wug3hkPnw3/B8ta+2ncQ
 b5P53bUfvvuPppM75onmHCV+0wLbn9VW5JE32EBYPOWdRz+fq7aTBJMJ+AYBhIv929wT
 JVZ/s2YZzMGewz89COfvkpjulO8DjiHvbj+Xs+bDp2ouFhAIixAR1BcP04Mk+GmHD0Im
 a9+k0VLTgb0teMlQHYGI6tOYeRSOnZ+5RVj97l/mcc28ceaBkHICcs/lYnKU7+0sJe1a
 jkP1b0uyT+ZH2FHKE/zFb8VbAfwODidyM2woshyaeKwJ3zLm1rbjRfBZ/+3fXBjaMctG
 NEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146076; x=1712750876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=DatnOvcBal+iKxyWkpsryFt6lUJjcQftl36I/eZbNVBzdj2V/uNmgswF35S4MB5FO+
 Wui8LxZ0vl2Uyez4QqipFR/jSAXKChfSGd+OqTzFoQbSwXXg7pH/jHwu1ThiaktcKKjA
 SGGIzjLZPIP1bs0o3mGvGcq2uoYLHG2jgYBsnQA1OPP3D9IY+Yqn+1LMyibT4lJkVwgG
 AHBJ5cP+thtI6x1DWia1NO0wjeMEbJZi2TGeMkoDlgEd8ovmF1gIMfppZ/Sd1HTGKM31
 4l5f6/YByKnNUtnskfZVxZzVjA9QqQXcbr5+nX5P1hOgGgjCJQ0MBsTpaF2ns1j3GJcS
 mtvg==
X-Gm-Message-State: AOJu0Yzpl0kUqWCRe51dDZ05/Nhilb+55soD14lL7p7cmO/7c1ZQTvbQ
 oloMk80K2oddlRhPdiOq/e6oiVVkWLi/hB7IFlrDHXWQ5+sxGpNlmuK3FN21png=
X-Google-Smtp-Source: AGHT+IFUG+942kojTTmDOHfNTbIb2TvH1SUWsrC7s15mY8gsBDlN9aoKluHWZvi3e6vlJa6CC+UUFA==
X-Received: by 2002:a17:906:1744:b0:a4e:2d7d:3fd5 with SMTP id
 d4-20020a170906174400b00a4e2d7d3fd5mr11678735eje.1.1712146076611; 
 Wed, 03 Apr 2024 05:07:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:42 +0200
Subject: [PATCH v6 07/16] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-7-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LQeBYALcRlahXsl7p+tCEbXEjlrRYAIfZnvrRJ8uguA=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaQdpMOklPbiCYxOwt2EOYELrByP8i2WG9ed
 Gvn2nE+dZmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkAAKCRAFgzErGV9k
 tjaMD/90afp5tmvx53pAOPulfcBcx9CBMAb5orNwDhm7/UppxBJ0uWNo4bDAsBWAw2KSMReCmLa
 iomFmD4Lf5NQbCFxGxZ2ow+QwSUxRpYZ3swRSOD/ax+Mj9KMiaJKhJITnODNU6t1kUM0EB3CRJc
 kRSvDRX8qMcB4M5mqeHzM0G0fIc1mBaZgxNGTPmA2xZq/N6LksoalGn5FR9FtwQe3KPwVsz9Ynu
 vQmSIEYElqZAQTTXZSAy2qH54w+c1A2khj6/+k4Y8L6bpL1h6StuoksyuuE6ThatYvzvwPK3nJI
 gcqjCpI/RJNgJ26VgO3Amg3bf//xYglRS/RS73lrKTzmTFmLuEI66bFk5tLNyxnJcS1POe8BUFe
 7bAgubauJfLCo0DX+uW3Kjo1SYvnS9vD3HVZKsiAnhDqLKPV3vSO/bWGSRj4hsHPYPSTe3IBiBn
 4Ik/NMaSdTZHd1ho+mYvJHeEp7OZNLIVIB3JFhtG6QLFnJzHX1Umxpn++n0WnEqVU8BnF0OCElF
 oJ//61Jl/5Dqdxbmjn2tyXaxDSUH7vvXXY/9ZjGVDYB8Vonw+JnVdYlC4kmQLlasa3g9+v6Bix6
 IjwH7eARADuUB3QHJ7oflHot8zSSVP2v+cg85uy57Jt0EsXSpwn+N02JUEAbGvg/lPT3nDfNflc
 8zgnIXSX3Em45rQ==
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

Most devices only initialise the USB clocks for us if we boot via
"fastboot boot", add the missing clock configuration to get both USB
ports working regardless of the bootloader state.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sdm845.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index b7154360894a..e9c61eb480de 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -20,8 +20,12 @@
 #include "clock-qcom.h"
 
 #define SE9_UART_APPS_CMD_RCGR	0x18148
 
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
+#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
+
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
 	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
@@ -56,8 +60,10 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 	}
 }
 
 static const struct gate_clk sdm845_clks[] = {
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x05030, 0x00000001),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
@@ -120,8 +126,27 @@ static int sdm845_clk_enable(struct clk *clk)
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 
 	debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
+		/* These numbers are just pulled from the frequency tables in the Linux driver */
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+		break;
+	case GCC_USB30_SEC_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
+
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_CLKREF_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
+		break;
+	}
+
 	qcom_gate_clk_en(priv, clk->id);
 
 	return 0;
 }

-- 
2.44.0

