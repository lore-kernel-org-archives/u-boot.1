Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90382C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB59787DA2;
	Wed, 31 Jan 2024 16:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q1SBf+1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B920987DA2; Wed, 31 Jan 2024 16:17:12 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C834687C39
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so55905315e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706714227; x=1707319027; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TUjVm8ChAuEE7poMndSbEEcqjlSiD7o3DI2Vmypvbys=;
 b=Q1SBf+1OKzffjWH3q0MYFe20CuC0DgRpWzkwwXbF0EmcBRga/SnDL2Kl50ZyIrt86D
 qyFClK0r8S21z/HjJ2ay0zRm1o6HTLFnuCZyi+ErcbnAuOvhdTE0+O7WICLThyjyMPLQ
 GfeaURjGHXfL4Yx2jnq5E1CKUbPC+3AT+V+zt3YsDyvemeVK0PcXJjebXWS/4lUaba4Y
 PTa7Nt5M9QW/N6DxGOWRF4QAyVUJ9TRG2atHtsdMvw75rin9SO1sZSe1GKAy89Le7IXs
 CpmlmuldVWn0iOqXB1mQ+jNbCE8zrj1LGdB14NFkMGmxP7CSeMAy2lWWDFeDBUN6AEW/
 zYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714227; x=1707319027;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUjVm8ChAuEE7poMndSbEEcqjlSiD7o3DI2Vmypvbys=;
 b=LOmoO2fTKZfKskRVmCBQPwefdE1VRa6K6IdAsJ3iQcjm38pcTgvb2eRmFrT7LDHsxM
 unLzMSBSTdlnLVamNFZ566VTVmHI9QAtLot88IvMlqEokUvdpCGYT1vzKvc4Z0RwWZpE
 B1NWcbc8V6WxgkZX81B5J9RF3LMT7SSfn0s/ifPSxbKtYeplsCv+xdb2Kmi1PWodOLGE
 2QoDpwU+WMPRxn/grQY7xZNn6wn0aOfHGej3nINWzBmtmKtiscrqVSm19PB+XRTU/IXb
 X2NrM648L5FtfUrqDwmbrVMeGVZm36FFGMSmWsZ6bcdhn4F1ZEXorKhZWtgb0/9VBgzj
 2mcQ==
X-Gm-Message-State: AOJu0YzJ6O01VmqB/6rzMy8EGUTGSQBdu767hpt4v1GfMmdTkajjQnnL
 95VGtvs32QPQJaaPlSN82fjRmO8At8zKCfnOhJ0+tVOce5e06nzZ1bopiaN1X4GzZubGvpafIkP
 0
X-Google-Smtp-Source: AGHT+IEXf3Q1b9rXf7YdZHeR4NLcIsa70Uan3uRXcQ082kdhDNpx5gf4HpzLee8WBb0uKcgH/lXUUA==
X-Received: by 2002:adf:a3cc:0:b0:33a:fce9:47ff with SMTP id
 m12-20020adfa3cc000000b0033afce947ffmr1509250wrb.4.1706714227071; 
 Wed, 31 Jan 2024 07:17:07 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 en6-20020a056000420600b0033ae5b637d4sm11109031wrb.35.2024.01.31.07.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:17:06 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 15:16:58 +0000
Subject: [PATCH 06/13] clk/qcom: sdm845: add USB clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-livetree-v1-6-4071c0787db0@linaro.org>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
In-Reply-To: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SePkLo8cAWQlkal5yGvvBWm4sTdv1wMRoUK+7UJ5xnA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRdKTlLDdyF059EPLrmImJ8bU7OfyZ/i0vHdd+dj+13P
 HFYzNO/o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExk5wKG/2XTuY7K77zcJn7L
 3m/RQYm6L/wZZn2SwZo77CoXacYvrGT4p/3uv2+FfcUu6ysJ1y7o8LXPddYUSvwjMCffXrOKMYz
 vPgA=
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
 drivers/clk/qcom/clock-sdm845.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 5d6c0cdaeee5..e5033cacb216 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -21,6 +21,13 @@
 
 #define SE9_UART_APPS_CMD_RCGR	0x18148
 
+#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
+#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
+#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
+
+#define USB30_PRIM_GDSCR 0xf004
+#define USB30_SEC_GDSCR 0x10004
+
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
 	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
@@ -57,6 +64,8 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 }
 
 static const struct gate_clk sdm845_clks[] = {
+	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,		0x05030, 0x00000001),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
 	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
@@ -121,6 +130,26 @@ static int sdm845_clk_enable(struct clk *clk)
 
 	debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		gdsc_enable(priv->base + USB30_PRIM_GDSCR);
+		qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
+		/* These numbers are just pulled from the frequency tables in the Linux driver */
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+	case GCC_USB30_SEC_MASTER_CLK:
+		gdsc_enable(priv->base + USB30_SEC_GDSCR);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
+
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_CLKREF_CLK);
+		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
+		break;
+	}
+
 	qcom_gate_clk_en(priv, clk->id);
 
 	return 0;

-- 
2.43.0

