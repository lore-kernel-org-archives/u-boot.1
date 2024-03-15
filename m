Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18A3C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6346987FF7;
	Fri, 15 Mar 2024 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LpfuP/LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0FF88053; Fri, 15 Mar 2024 16:10:40 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBA238802E
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e9def4a6dso1461210f8f.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515436; x=1711120236; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wsmj05dPfs1rjcVH8tp3Vc80gcGSrf4xjJcLkyvDdHQ=;
 b=LpfuP/LLP7VA8ChWuZn7isNoC502K5LDFiB1vAf+ni2UFpj29PY20T/2Qiw1nv2WC0
 FZp7W2ilYmRF8UC0nqFNxH/lNlg8GFOcUjzodRGjomCpO1Gm5Asje7rkVZl1gowdBOtn
 6Fe8a1YX06wZ+IV7KixYhenioEyR/NgkEhpyw8ivncebJ2M4SqOeUyOrMnCCp55fxEvc
 GQ6jO3K+AKZmTfLkvAYYlzj8/DxAJpfVyJK+FJu0vgK48VHiX02XOYtWuxX3pVnZMi0M
 5z8QXDu47Pt86ngSml1ROlvllncU/82ldC/fYJAbXGHw4vhhdkTAZfyF6cq6NCJF5fCv
 C03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515436; x=1711120236;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wsmj05dPfs1rjcVH8tp3Vc80gcGSrf4xjJcLkyvDdHQ=;
 b=GorS3fjeEKeNKtStQdiLH7yiriW/13v+697MsPJJPiG9mrjaNey4fOj5Y7LNnlIDie
 ucFx9DzGC7JgEk4aYr0ey3KwffUqWQYf5kYf7SG/zOGJ7gdwvFgMUTXRd+a2hGMSCOgT
 iT3UQpmf26ZjxH55kcKLQe/Ci397Sm4dlH17kYIFhwIaNDWQSFXL3ysT8JbZGUt7pRMa
 qIfMnoMv7h8K93eqja41K6BotZOTdyOPgq58WUzjHGXLxfkuWIxRhp3Q2lsUS3brF9vO
 fkd4qurpKwJAkGByJ9bDAJtB287DOqqremlacGE6kQZoDOoRgiMhr/iW9e0j+9zT9eX9
 qu0g==
X-Gm-Message-State: AOJu0Yx597GgUokF9x6n81QvkGT4C/R2YIs2O+ftT5STNA01aMwooSV2
 AVdlNOEx9iewBnBhRherIF4tFQ8rNd5/+OP5r9TolUNA1j3CGgN/+5GAaDO5+7BPmQoGOHuE8w/
 c
X-Google-Smtp-Source: AGHT+IFVWP/Hj0DpuU0gC3RP9iWj47b7b63przmlkRZnHbJKwE7XhTKxOZ8eLV1h4lLLHtXWJBy65g==
X-Received: by 2002:adf:edc9:0:b0:33d:a944:54c0 with SMTP id
 v9-20020adfedc9000000b0033da94454c0mr2586891wro.22.1710515436184; 
 Fri, 15 Mar 2024 08:10:36 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:16 +0000
Subject: [PATCH v2 07/14] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-7-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY99nimsap/j8FlCzk1yrdbbdRZmW182PTNwjH195
 yPPppWbOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEfi1j+Gf2LCSz0P+B0QkX
 b7YvJTtzzy2VuDOVRe3pxUvbGs/OCeFhZJh6S7vAuuY368qy/t3+U6wLRVOmBSbcXSWvbxKz5kq
 echQA
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

