Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13340C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4038880E1;
	Wed, 20 Mar 2024 15:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pcMdtS/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D33E4880EA; Wed, 20 Mar 2024 15:57:19 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E643B880D9
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4147018a4c9so63575e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946637; x=1711551437; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=pcMdtS/B0bE31Jkoy1xFmjMw3VVPZEb/OTq4axjFYoW6fLZUN9Fo43EebDt5vlnD+y
 nwBdeQ9Gb6x5a/W8qotFW6fWdGALQrFqud7KPFCKlYfPGcs3mnJ6elfHdZMPh6iWPXhK
 Uck5cKYCBEZVbqZxSuwQSJXBFzOksPGNRqawwNJn/ISiGyku22m84MExtfTSL2rmOfmw
 VyrZD5jdY0ezWtfxCG0jLIZBYA1pJkfXyh0/F6jk/Loi2pZfy5IosvZ2A6Gf4sp9nya7
 AyztsCgRRmC7eOF6xmEDvIK8GmbOLZzfab4kzeBJjuWCiIQGa6NgW6EfOQnn2w9kT+v4
 6AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946637; x=1711551437;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GewhX1AhomHs5Aohn6YwaTX+GkXafQtxsWjEwPDqGAk=;
 b=sj5HzMzLmf/iB+R+bdEhQLCoiLq9Mb0QqUroswVvbGS6UxOywsNtcAdCE/pfwSh+YM
 6wmXFKRLRh66pWthxQTQBWJNJzvfusqMzy5jgYg+crebAZnHSHgAz22QJVzki2tz0jJP
 +YWGnaNQlit1534zU10e97yCR8dJ/kbxc4aG+XYoA7533YS0V0ImTyb+WaleEAyBReE0
 cOxHwuitboD1v6t/YHhUesQbHufboza3XBWEhD6y40hFSWZFZAvhJCdc9O954zmhhNOa
 Q9U0iMRZYBXSC+v+nC7PAOJE+xueG0BZEJZ43QcDKoyCPuBAoQMp3KznGPkl06RrsIrd
 AsNw==
X-Gm-Message-State: AOJu0Yx4ozURVk0zOJW7NXOzEn1kHz3GBHnE4ve5Ar0K/azgHZ+r3p8u
 f8+KH5i3JUSYw5xMoruzuxONWUzse6b72n1cTTfn1IaA5Mihc9RHnHtlTvJGkFY=
X-Google-Smtp-Source: AGHT+IGtUTPrrkwfeBrISHbAcQaO1znPnLVBlEbvOUSrYcusP7ls6lSCWLNpbyHLRORwi0qrhLZhHg==
X-Received: by 2002:a7b:c418:0:b0:414:a8d:ca39 with SMTP id
 k24-20020a7bc418000000b004140a8dca39mr8163914wmi.6.1710946637563; 
 Wed, 20 Mar 2024 07:57:17 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:16 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:10 +0000
Subject: [PATCH v4 07/14] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-7-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx3jMy/tupsWeYq/Xneb/PFLJW9/xKw6/l3s77/Ig
 Km1HUfNO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEruYy/OEwCNxdtNtiiV1I
 SIONqMPTXTpLLyfeLzC+8V1hx4scFn5Ghs1XkueqHdO/ox1tbLZxt0LXtPTJbf+V/f1WXLTf/Hf
 6odMA
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

