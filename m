Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DDC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8B3C8809D;
	Tue, 19 Mar 2024 13:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XlaKaEr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F9487F8E; Tue, 19 Mar 2024 13:22:47 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF96E8806F
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33e570ef661so2513501f8f.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850963; x=1711455763; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wsmj05dPfs1rjcVH8tp3Vc80gcGSrf4xjJcLkyvDdHQ=;
 b=XlaKaEr1CMmfPNaOVBap5OvlnZQ7GB0v82LjH4uQ8SwH/Z6U/JvPr05S1QpcM+azeE
 cNOXUJo000xLU/99qT2ABOWTfw5+PM60Yh3w8Ql22TojTDNNTNs5YGJGEQfm0RWcnICt
 oItpaCRY25q/Muwc0RAFZ1FE1ejDEkCrTvx4p+QRf6CiursYMNLbJi7wm8hsdAgmtcv9
 pbz5eieltOev0I0pkCy4YpXd+45qsviiutjGwhvJ6QbNPtYpIYdPpFj0zyOZcsGRUzTZ
 /D8emtBnjHVvLnIfwBuqUKGfCyQXKCwLKN/geLhaZyzjbWxDG1cl0RQxd3tyTMoCnbeQ
 B9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850963; x=1711455763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wsmj05dPfs1rjcVH8tp3Vc80gcGSrf4xjJcLkyvDdHQ=;
 b=bsVqd9l8nD//Jm8st8oDta/NMO+A5bBRepCOOnTAYvN1E60HoS1jWV+UPniyCs4GJI
 Q7yJKe2pkbqkRxRrMaWxx22SaE2VVt3icFqC8z/nEd0djG8/pQU+e9HVXzB0qBIbwvJJ
 ejLI3HJodyUjO4F3Rfl0PX+bRzohymF1jfFJ7VCN9sSnNb/UjP2xaS82JCgG0nJawOFs
 Ul5GAy2SlONJSXiY2vTjfXDs+wSsTweWTVm/F4I3HS4dlYOLYrvobuLMRmX+aA2xTv0f
 NPQVD5RmHo1txFVKFSid/yyynQUzgIdGr7J/599c/dcF+pgwSGGCN0XGesczhwdk0VZs
 qijA==
X-Gm-Message-State: AOJu0YyBpLy8i23CpfRtMAHFCLmiElXwiQYncdSiVdhfsuq/3PYV55Gh
 rWxLL76CP8hl+pUnhA59yIyPEtC2DDbjLgyFuKZkL9yEbv6m9m47egu3TgrHo0PjPZKu+Mhiqz3
 B
X-Google-Smtp-Source: AGHT+IFoasWflDQUB2xDB+pm1LzxFYojKR/Fh+6a6uK6CCRA0T365nbWzKBseYG6Oy+Y3KyEHO4/Ug==
X-Received: by 2002:adf:f303:0:b0:33e:c677:3278 with SMTP id
 i3-20020adff303000000b0033ec6773278mr10974586wro.49.1710850963203; 
 Tue, 19 Mar 2024 05:22:43 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:06 +0000
Subject: [PATCH v3 07/14] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-7-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=TPWXmjwONpVmkU2OdupRcZGhS+g7ubUhkmPEYsCZwuM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzZ238u0vas9rP3MmjzdCdZfbAd6MUzUJjo+qfaI9c
 xzlMvI6SlgYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwETWpDIyzA4qlb6aYb0jfp3T
 vWrzU7N8et9dY2Xp13168MaCbfP/FzJ8s1pWxcMmlxzQUxvYMY+vd9r00hjFvfty/y9qb3ssFHE
 bAA==
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

