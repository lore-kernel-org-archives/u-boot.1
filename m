Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B39C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B504183055;
	Mon, 14 Jul 2025 15:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D0SXQIyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 995688305C; Mon, 14 Jul 2025 15:13:28 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2B083082
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2303107f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498806; x=1753103606; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xM91JdRgJe4ay2wkh3o/qEuPEaarsEMqmhbVMxp0ljs=;
 b=D0SXQIyOl1ENhtRxiEiOvjk7oVuergByk9fmRMEyKYjHHJdkmxVqWHQd/icqWjF+Iu
 rPjoz2dgskGCRQ6/2WL+GTe1sYso+B3ARMYPG13JDP8AmRJnZqRR9CxUKh8ZJPSmyztN
 sWLReDpVbeVgNcuKV5n7ri0mBMRk9cptRE/AJsbWZMp2A5k2wuc/iK4A3BXJezZ1OEFi
 RczAwCFvtXHJSjG6O81vQ/jAsvyRmwAPq93mCvl5TE2BZH40ttlYsCyhu+8djcuyQiZh
 KCbLTgqAr9YMr84gcsGsE/HLggxYnOLbtchZnQpxIuLTGfq7U0lwHeCrYOP/EZYujXiY
 PUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498806; x=1753103606;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xM91JdRgJe4ay2wkh3o/qEuPEaarsEMqmhbVMxp0ljs=;
 b=LEME6ycc37Zh9Zn6jbEc6YjBD4pjdw0JUmYjGcFpvTZB2oyvCeJxEiEguiOk7vpTGg
 Vew5WGTxA8t0QRF2fDDxh3YjF/ImPhS2fSe2rV9XGhILK7OUljsVeFbDdoLuW76BJIXX
 OSddCbW5zsoDoeCIxPSUtMVd4ph/efU+G4aJJU3t/eCbeP60/Fbl5ISryHS42oCoEh09
 VkJ4UGkRiielYZzl0WldfZE/jWeDq422ZJKeG8ip1hw18ELicflMi3a41f+1LKkjQiby
 6VAR/PLGfRad8Y9D2ARei6rbzGzx4ojPYhS8osZ5p7pGWsFUi2eSGAsrW/iJX5N/VEme
 rIjw==
X-Gm-Message-State: AOJu0YyKsW4inFdo9XEcmc5hC6wI5Mp3zZgCyQcheZ1aqaarLFDK8yjN
 ukGkF1ZTmFvmkIweB87owC4pTc+h469Go/+q2TosfejkMCmK39dcDYvmKmvNYlI54Ik=
X-Gm-Gg: ASbGncvWKOlqiePJzFuVOtK0nHPd+091KMbZo+RpOTcilfpvN0lwCFJuG18KKOFeGu7
 nOdZ+76AwBH2gozL8YjK81U9UtSwHd/ngKSCSOrnFQdyS49RXhxi/nyf/HmDuwsr9NvTtSU7TJ3
 DD3VC1RDVO7dhbvnKYY/2EPeLzgIr85F1j9hMb7/nQ3nfqnGekl/Ug04mJECd/jCr1SwLc788L7
 QP/EyXO0NiYr+PEfPgwaX94xx9gyJ/Wc9tWDPKFcUqwP4hOEknzX8sTj3JoFHTZueLmvYDwAjOW
 OSAFMpLYfs0dlMInd4LZoZhxwWFVqQV7z0N3HxxJajD792jDr46pIW3PucAw/Hn3KdNmvjuc8MG
 yqPn6u5XpcZfhQMmOKs1NA7FGnpeGjAuG4gx7RWLHNbcRbDpzDV8lOgVR6z2LRwuG0rOYcw==
X-Google-Smtp-Source: AGHT+IEn0fO8T3XSLwS43vNDU7fLL7h7JPfkFg0UU37uxT/utUYKuxr99VlKO17JWzezOJggFaQz0g==
X-Received: by 2002:a05:6000:1447:b0:3a6:d6e4:dffd with SMTP id
 ffacd0b85a97d-3b5f2dc2234mr10320484f8f.14.1752498805599; 
 Mon, 14 Jul 2025 06:13:25 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:24 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:18 +0200
Subject: [PATCH v5 7/8] serial: msm-geni: implement firmware loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-7-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4971;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=u0DeoFLTaVILRMAcuPoKIbAqDdwTGn1SUmoICfD0C9k=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJrP32DmJP37VSkHhYAFsbzt3lKKrQ81JIyc
 CqqycatrtuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCawAKCRAFgzErGV9k
 tk0/EACX3u6bmm1fHvSssuTrkSt+Taezo4xyxYUtvRbq81jJBszRyUXoozGPDOTeleZnlF5OJrF
 qGV6liCp0164d8uCvG/kf8Nn1HJGsTQsNyJZYdqB+pxeJYFPkRJKSoTKDaP7NwFvDb1Iu7ybn4L
 r/tNy7FSeqbVl71iU97P+CljKCb88+9PmbPJt0m1pdjBcomwZln/HEyFJHdU49ocDfA1ZZfg828
 7o9WREZkoz6O5QdpvRGpG7W45mCV2IbkDQ9hMI+chHSOyhcXMir3RnFehTmkZ4Nlk8wPJ+rOvFp
 co2Soumgi+sYYHhkVscWr9lu1/u0pmwHSV5vPpNwv+cmI84+iISUauHkBSpYYen23dvVUDMMUeX
 eh05g0OKjGmKfngJbJ4ZUFK7+jnKFpBb9jKWi25RjaQ4sLU4kOG/Vf/yiSiOIq2hvOyh2tSzc6P
 LsJt3FRKlj/rtHHkThxXZQ04G+0zBI7yEieNAVDv/SO/HfYgKOguOWjMoZI+MLHLe1IxnuJ6LwT
 OOWwoMxNLg1emhNNCovwact6t80+w7tjwI5gIhl4lMMCD6LsINU8azdOsY/lkqNPxnnV2YAR8Dv
 /I2ZFhbbxsLBCVVwbx8kK38AoU6fWHBTgpjMk5LWsj4/3L3h/Mr7/nJ7hhpNBFOYTgLx5PW//P4
 3tp0rL2fpuN2ylg==
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

Remove duplicated register macros that are in the common geni-se header.

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
2.50.0

