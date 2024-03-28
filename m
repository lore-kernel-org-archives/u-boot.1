Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1E3CD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500CB881D9;
	Thu, 28 Mar 2024 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="btPev3XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68773881F3; Thu, 28 Mar 2024 18:59:51 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4823A881BF
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3417a3151c4so1110679f8f.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648789; x=1712253589; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=btPev3XJR/mwJ9z1CGnbYPRELGLC806TP92Im0bWbwyecPXC2+9sFYaTOIHK3A4BE7
 p/nxqsiWkukCYCdPoGq7yjKtqbs46appfkRrTdKXc1MYnpWD9Y0RjDYA11LRfsr8lZLz
 LiOnglFd+S2wEdAg6Wsvl6neZaQd3sPR8NcsRvxjmJJy66FzeS27Z/mHELc7W4W/3a81
 IpFmDr4vQ/7mNI0DBGXhr4MwWfjB/8cvYMqiUxQ2WU1aRWHYxLRm97lnC7kQ8cEoorwF
 Fu23SDTiUQO3YbrJOqtz8CfTICP7U+ibiyeX02PWZSCqe7VQPRpgid4M8TTNPm+43zJi
 uiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648789; x=1712253589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=G7G/uZzz2nKuALsehU17IHMOE1Eq2x1Uqj30VIwe0w04BVDOpYmEEdJJTzeLuovvhU
 6mCwaqWng/xYnyYzrwNv3oEim7QzuqydNqTRRbgL0pAfkC7zl5Q2LMHV5tj2hkNfV+IV
 DyTe54EiOHAKfLtGcVy2r+CLRI8ggqsGTtIzH8l1dhzfnOYugcNPclPkrKzAbMcV0p+r
 gUmCKn502/ww58j/V6nnO9SndW02RtkRO0Kw0FTHPrCcLf5x+R0BIaDgnWsvkQI8wpiA
 Os5VFJlReh9vpolx4R7UAIojUUk/75BFw3CtuLn73PMi/pE4H1FwTMudaMwe3D0c2T5C
 3KMA==
X-Gm-Message-State: AOJu0Yys1UITBHhtzQRKt7A0vIJ3ms7qgJWHqtHfx7BdEWPPOQm9so7I
 +4Wgg/owam2aBUrBcgOPvYP9DNmQURVPGx1S9867GaNVDzLdLKvz6Eut/NaQrWs=
X-Google-Smtp-Source: AGHT+IGR7ROTfD96+aBt0e88qXZjl7AiM+6olPxZJbAOrSZOiyk8dLF2Y8+sFwyO1PhI+A/YtyNXtA==
X-Received: by 2002:adf:fcc6:0:b0:33e:7a1c:788e with SMTP id
 f6-20020adffcc6000000b0033e7a1c788emr3434450wrs.6.1711648788830; 
 Thu, 28 Mar 2024 10:59:48 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:48 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:13 +0000
Subject: [PATCH v5 07/16] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-7-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=LQeBYALcRlahXsl7p+tCEbXEjlrRYAIfZnvrRJ8uguA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZybL17bMu3Q56w5iy/N39H363ar4/8dRX/qctjun
 jvYtTx6bUcxC4MgB4OsmCKL+Illlk1rL9trbF9wAWYOKxPIEAYuTgGYiCEnI0NzN8tRd907d9Ye
 5+qLkZRgChLNvbn7VQYv8xW7OTdUDt5geB/w1XtHdGO1tar37223Hzp3Tn+94tPuvHsx5f/EJ7+
 dAwA=
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

