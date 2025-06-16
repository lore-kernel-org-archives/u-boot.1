Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B94C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 09:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87D6782CCF;
	Mon, 16 Jun 2025 11:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gz8Jg7m/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18DF580C93; Mon, 16 Jun 2025 11:45:00 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0D282CBC
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 11:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-450d668c2a1so36074455e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 02:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750067097; x=1750671897; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d1S8f2UxKaB6hnYE+VpXXcL4q4gMpoZRXz4T8RarZJI=;
 b=gz8Jg7m/BkpSmjskAPiARqqWXSezDxyqPxaBi5/9u82vanymoIuUTqaR83CzI9AZLb
 63lMgH0JDrsZ1FKCnMKHCA5TVYnJpiAj+UZ30bWL98C9Ax1FTaSa5YkGEaf23hikFPGC
 4IUo1+3vIfY/AyKbxTmsYNasI3UBaS6iz7d71iAyMuyhtTE1gc3bhLOvsrKdZXaoM0Ty
 pmthFA6f5gaspl+mXKy3lbUHG6UHoxRbKKHz0Fw4tKD2gL6HfQ6L0YkXXHn90A1O0a4F
 AJnxR4zXyBRlPuM+X0xxctElmWRWhs4EWPkToKZLVzY22sGoCDyesatGPrEEFEzhjong
 z+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750067097; x=1750671897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1S8f2UxKaB6hnYE+VpXXcL4q4gMpoZRXz4T8RarZJI=;
 b=psGV9k/PbMuKCZMAGgSl6KX/PvS3gYzKGuYKRDZKMCMB0xgCK0jSldPtDhGzNF90lF
 32hGlJpbICyslt2jernHZe9qgHth+SBmP1jcopV+FvHRIShJEDC/xv/R0Kag1pZ76MM8
 N6mxP7vK0qePfp92q8nd13/QC1MEZodvfpGSjHtXl7oTfzXwQDotpwa345ki1ud9hT75
 NDxdtIMAejjiS6Fd8QMQnxqbzrL3lk7Hqk0dGsizEMM/bXMJBp/DxrDYjJF95SScNNtq
 pG662x2vS4EP0RLtHTNfVqvYsRVHN1DyezEXX9Z5RWOSNFaCT9cXOmKviVPk+a8kFVng
 3GGA==
X-Gm-Message-State: AOJu0Yx+3hSSLRm/W2rq2WOZtd9vUCqjThIoxWP4qS5x+6uzUedp95CU
 B27HBnO2AbKqiStRt0151DHisPQCJJjxX82+TzeQ1IP5WU2gqq8bY8Xc2yoHtYBKV3M=
X-Gm-Gg: ASbGncuXD/qFyzk6kAN6vmAdcLnyGsTqJcolXFNkbsjgcNEIPdP9e19Ijo6wcmLnoec
 gBbMlsbxU+TuVRbgXympm9LHqYUCmG3JgOvTkMfEHdAtB0ETiQRE6YyGIUSDOejCc8Cl/Y+yw0d
 yO2V2hItYrqdTy2LM58lBCB8v6C9YB9mrydpndBUaOjGWMVDnTh3glphOp48tF5hFMRuKFc0Ro0
 avPz6IiqWcUipmBekxVMRzYEBaAGhTYA4R3DNZnWc0qjYPMUxOtjuEoY+jjOqXGWSWBvMAWW8L0
 jdyBvuulk+6u1qZSq5Z+dryaM28AIoWXVFnoa9ZH5JQ0rSFBUqGUEQvvbvG6nxjRa7+Azl/uiCO
 LtrZ8
X-Google-Smtp-Source: AGHT+IFeDT1GNHE3vnl2DTVHqfBqSUceS/d9aSOkSN3SDYdtG1phOh6vwUTuyduutWKnqRqWfYaC5w==
X-Received: by 2002:a05:600c:5492:b0:442:f904:1305 with SMTP id
 5b1f17b1804b1-4533c8dd553mr75754505e9.6.1750067097456; 
 Mon, 16 Jun 2025 02:44:57 -0700 (PDT)
Received: from toyger.localdomain ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c229sm139308105e9.6.2025.06.16.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 02:44:56 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 16 Jun 2025 11:44:48 +0200
Subject: [PATCH v4 6/9] serial: msm-geni: implement firmware loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-geni-load-fw-v4-6-e7df44205505@linaro.org>
References: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
In-Reply-To: <20250616-geni-load-fw-v4-0-e7df44205505@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4895;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=aruKasiUGY9yf+ZpXSvHhb2LO8n/ScJfqCYKb9Cys6g=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoT+eOLmriNGDz7RSDPSW0MhAtHUibJ03meY58e
 ZekzPbyEteJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaE/njgAKCRAFgzErGV9k
 tsb5D/4vsRB2mxcPIP7x3ceK7t6Hl9Wkr4YuV4We/Fq5p6wjyxkCoMu1yEnfmZ/22QLuPT6W9wm
 3fX28M+Qq5PcE4mRaGanWiYkhcil+Bs0dZarV1yWdCjODjIxiYjHuf8fVM3XiGPRuzZONsnXC7O
 FbAYe7M1L4ANmMnNruTGuL9smoRJlJGIQ/2lyA/A8pxVC4QNHy/csj5VhMBj1giusf3HRxfCfZu
 LEubTIdL4e3b9BQ5dQtrkKSkKw06ai38L4FVg+Z4pelEa1GczK6XgZJFD5jZ4FKI6H9+XGju/Cf
 p5UHNs67W6S32lYxqnyssEXBJeAz4mJ9TfqUhpJp17djP5diRgb3uWQ+VvV1NJa7pb3FP9/LPXq
 QdYE9gwzmN4frUbX0sqOJ2dvJXhkJ2MueypCUD8AeqvZzdJAYcnBbxFMdccdbvr+tHCCqEZ3HQF
 W/U3JQLr1iDEM0/rp+TlVa2q76LGvSy3LkKvWCDAgfzXMWotMvJA3pSD2j7WSOcs1k0FHQFyIln
 kdyqYvp8gr4Zgw04QK3Rw+Nf1p0D33Y70YdP55yv2AvmKp2DXR0bmVhn2RY+gqc0xB5Qs1J/BFe
 tkTWvx2EXHY+DPx096n8A5WxenueFr69g20llc2TFHTsP4hNyaaYrVjv6pTbEGxeJ3SUmVEzaH9
 xeVYc85UN1En2Jg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

Teach the GENI UART driver to load firmware, similar to i2c.

This is primarily intended for non-debug UARTs, but since we don't
support using these as the console we abort probe for now.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 68 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 35e0029144be7948eb5ab0da5a2d1317a08fb0c5..ad8b183edf5763486c9bd30be1458a1b332c2fee 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -9,22 +9,23 @@
 
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <errno.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <misc.h>
 #include <serial.h>
+#include <soc/qcom/qup-fw-load.h>
+#include <soc/qcom/geni-se.h>
 
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT	160
 
 /* Registers*/
 #define GENI_FORCE_DEFAULT_REG	0x20
 #define GENI_SER_M_CLK_CFG	0x48
-#define GENI_SER_S_CLK_CFG	0x4C
-#define SE_HW_PARAM_0	0xE24
 #define SE_GENI_STATUS	0x40
 #define SE_GENI_S_CMD0	0x630
 #define SE_GENI_S_CMD_CTRL_REG	0x634
 #define SE_GENI_S_IRQ_CLEAR	0x648
@@ -38,9 +39,8 @@
 #define SE_GENI_TX_FIFOn	0x700
 #define SE_GENI_RX_FIFOn	0x780
 #define SE_GENI_TX_FIFO_STATUS	0x800
 #define SE_GENI_RX_FIFO_STATUS	0x804
-#define SE_GENI_TX_WATERMARK_REG	0x80C
 #define SE_GENI_TX_PACKING_CFG0	0x260
 #define SE_GENI_TX_PACKING_CFG1	0x264
 #define SE_GENI_RX_PACKING_CFG0	0x284
 #define SE_GENI_RX_PACKING_CFG1	0x288
@@ -53,61 +53,26 @@
 #define SE_UART_TX_PARITY_CFG	0x2a4
 #define SE_UART_RX_TRANS_CFG	0x280
 #define SE_UART_RX_PARITY_CFG	0x2a8
 
-#define M_TX_FIFO_WATERMARK_EN	(BIT(30))
 #define DEF_TX_WM	2
 /* GENI_FORCE_DEFAULT_REG fields */
-#define FORCE_DEFAULT	(BIT(0))
-
-#define S_CMD_ABORT_EN	(BIT(5))
 
 #define UART_START_READ	0x1
 
-/* GENI_M_CMD_CTRL_REG */
-#define M_GENI_CMD_CANCEL	(BIT(2))
-#define M_GENI_CMD_ABORT	(BIT(1))
-#define M_GENI_DISABLE	(BIT(0))
-
-#define M_CMD_ABORT_EN	(BIT(5))
-#define M_CMD_DONE_EN	(BIT(0))
 #define M_CMD_DONE_DISABLE_MASK	(~M_CMD_DONE_EN)
 
-#define S_GENI_CMD_ABORT	(BIT(1))
-
-/* GENI_S_CMD0 fields */
-#define S_OPCODE_MSK	(GENMASK(31, 27))
-#define S_PARAMS_MSK	(GENMASK(26, 0))
-
-/* GENI_STATUS fields */
-#define M_GENI_CMD_ACTIVE	(BIT(0))
-#define S_GENI_CMD_ACTIVE	(BIT(12))
-#define M_CMD_DONE_EN	(BIT(0))
-#define S_CMD_DONE_EN	(BIT(0))
-
 #define M_OPCODE_SHIFT	27
 #define S_OPCODE_SHIFT	27
-#define M_TX_FIFO_WATERMARK_EN	(BIT(30))
 #define UART_START_TX	0x1
 #define UART_CTS_MASK	(BIT(1))
-#define M_SEC_IRQ_EN	(BIT(31))
 #define TX_FIFO_WC_MSK	(GENMASK(27, 0))
-#define RX_FIFO_WC_MSK	(GENMASK(24, 0))
-
-#define S_RX_FIFO_WATERMARK_EN	(BIT(26))
-#define S_RX_FIFO_LAST_EN	(BIT(27))
-#define M_RX_FIFO_WATERMARK_EN	(BIT(26))
-#define M_RX_FIFO_LAST_EN	(BIT(27))
 
 /* GENI_SER_M_CLK_CFG/GENI_SER_S_CLK_CFG */
-#define SER_CLK_EN	(BIT(0))
-#define CLK_DIV_MSK	(GENMASK(15, 4))
 #define CLK_DIV_SHFT	4
 
 /* SE_HW_PARAM_0 fields */
-#define TX_FIFO_WIDTH_MSK	(GENMASK(29, 24))
 #define TX_FIFO_WIDTH_SHFT	24
-#define TX_FIFO_DEPTH_MSK	(GENMASK(21, 16))
 #define TX_FIFO_DEPTH_SHFT	16
 
 /* GENI SE QUP Registers */
 #define QUP_HW_VER_REG		0x4
@@ -548,16 +513,42 @@ static inline void geni_serial_init(struct udevice *dev)
 static int msm_serial_probe(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	int ret;
+	u32 proto;
 	struct clk *clk;
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 	priv->se = clk;
 
+	/* Try enable clock */
 	ret = clk_enable(clk);
+
+	/* Check if firmware loading is needed (BT UART) */
+	proto = readl(priv->base + GENI_FW_REVISION_RO);
+	proto &= FW_REV_PROTOCOL_MSK;
+	proto >>= FW_REV_PROTOCOL_SHFT;
+
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(priv->base, dev);
+		proto = readl(priv->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
+	if (proto != GENI_SE_UART) {
+		dev_err(dev, "Invalid proto %d\n", proto);
+		clk_disable(clk);
+		return -ENXIO;
+	}
+
+	/* Don't actually probe non-debug UARTs */
+	if (ofnode_device_is_compatible(dev_ofnode(dev), "qcom,geni-uart"))
+		return -ENOENT;
+
+	/* Now handle clock enable return value */
 	if (ret)
 		return ret;
 
 	ret = geni_set_oversampling(dev);
@@ -588,8 +579,9 @@ static int msm_serial_ofdata_to_platdata(struct udevice *dev)
 }
 
 static const struct udevice_id msm_serial_ids[] = {
 	{ .compatible = "qcom,geni-debug-uart" },
+	{ .compatible = "qcom,geni-uart" },
 	{ }
 };
 
 U_BOOT_DRIVER(serial_msm_geni) = {

-- 
2.49.0

