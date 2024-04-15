Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336FFC00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 15:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E22688167;
	Mon, 15 Apr 2024 17:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KpMZvJ2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B66787D55; Mon, 15 Apr 2024 17:03:50 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B88B68786C
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d718ee7344so32786451fa.2
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713193424; x=1713798224; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phiE3Uf7uCQ3Nfz23xgWKVkALYZFNegIdrJA5Svb6VI=;
 b=KpMZvJ2WQsUzXl+EQ1YwbNSzTgAuaNpB6BG7qrG8vLMa/4UyQlPhliZLkkin0JzGYk
 MiAeymZt+vDU8YPsBLRP/uPuBfRmv68rqvVx+z9dnMV5gZjhqyAJkHnCBBYxv689Azlv
 kgHVbr/xLz0ZsY6WpT+1UQdXVnN/aUUIxDr7qN3+lyG/uSv+lN4VII3fcN2E/UV7UCqd
 VyBub/fCQUEvDN+RZEDpzZ3snMnvOHYHsdtmSob9WSqU8FTFhx8ruuoTmT5nw2CSsO1b
 v6lIpal+vu6ad2ZEguMzzP255wJAWF8kFDRcmp4PM3VrO76LDSfhEsE7+Npgc6X4KKjm
 P4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713193424; x=1713798224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phiE3Uf7uCQ3Nfz23xgWKVkALYZFNegIdrJA5Svb6VI=;
 b=e5hD0HtJoGee/QoMeYS3pVv4C2rknswfNAb2kQxkXYjtE5yGrmzecDL7o5FBwmUkS3
 Rk7I8bStntpT1Au2EI19ceWWDIMRN5r8r+5qAO5MfQPGcsumw7us5LlfWsV6t/WSHeKO
 mfSwWgu7pu/9dl3KEbPRuVSdoECEUH1aSVWgBy41VqmbTxW5C9MhsrjYdsasPn2Ax8WP
 ou8u9Axvg+rOAA/R/1XfKP8dFc9ONueQ93sp0hJhwYbmT86Kx9KYBCgq9b32feogISt5
 4IR+190zbCtVhxPISAqMSKfjm4OFiJmOPaAh5tD14pXKXxRzpIVNg5bPxyy4G2uUAd07
 mxPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGzc+3QN6SdNSFGPj+StiboTN7N2ajp+D5gPA/mbqAoyp6pj2lJrpiajb1yw5SqtIx3zEVFI6iSCtuP1bDGVJNyKitlg==
X-Gm-Message-State: AOJu0YxYUf3Cn8vRCy4i4S1K3jLnwiwW4FhPdKLnxSA5uXnZrCaEh7CG
 KW6VXj5XsSoQJ/ctV8gUAQz5N5fRSSPBoPyh0RdgTLyuUzxkBJPzVJfnwnWyIRw=
X-Google-Smtp-Source: AGHT+IHU8KZ24LF5UeStnZFKNdd/MMT5Rm2+t4RKylTyEPq/6xV0EmapiNFk79x0r4cx12GBO79xhQ==
X-Received: by 2002:a05:651c:19a2:b0:2d8:36f3:663f with SMTP id
 bx34-20020a05651c19a200b002d836f3663fmr7736178ljb.31.1713193423842; 
 Mon, 15 Apr 2024 08:03:43 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm9040333wmq.3.2024.04.15.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 08:03:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 16:03:40 +0100
Subject: [PATCH v2 3/3] serial: msm: calculate bit clock divider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v2-3-b7a048adc6a3@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7339;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XTpTsjLTJWrjvqRND9ja48RnvtIjexGDmK5UnoByeAo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZx9OdcXclPtepcK6YkfBjHU/D+tDQpe8/9Cnd1Ok5d
 f/c2XvxHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAibQsZ/il9qLGq0F3QqvAt
 UOu1xDrfzxM9jjK9OTWx0n6h0USVr3cYGZou/i6ITV//RPTUuTizcxw/cl893fU/efqx0C+6UvN
 6txcBAA==
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

The driver currently requires the bit clock divider be hardcoded in
devicetree (or use the hardcoded default from apq8016).

The bit clock divider is used to derive the baud rate from the core
clock:

  baudrate = clk_rate / csr_div

clk_rate is the actual programmed core clock rate which is returned by
clk_set_rate(), and this UART driver only supports a baudrate of 115200.
We can therefore determine the appropriate value for UARTDM_CSR by
iterating over the possible values and finding the one where the
equation above holds true for a baudrate of 115200.

Implement this logic and drop the non-standard DT bindings for this
driver.

Tested on dragonboard410c.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Tested-by: Robert Marko <robert.marko@sartura.hr>
---
Cc: Robert Marko <robert.marko@sartura.hr>
---
 doc/device-tree-bindings/serial/msm-serial.txt | 10 ---
 drivers/serial/serial_msm.c                    | 87 +++++++++++++++++++++-----
 2 files changed, 70 insertions(+), 27 deletions(-)

diff --git a/doc/device-tree-bindings/serial/msm-serial.txt b/doc/device-tree-bindings/serial/msm-serial.txt
deleted file mode 100644
index dca995798a90..000000000000
--- a/doc/device-tree-bindings/serial/msm-serial.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-Qualcomm UART (Data Mover mode)
-
-Required properties:
-- compatible: must be "qcom,msm-uartdm-v1.4"
-- reg: start address and size of the registers
-- clock: interface clock (must accept baudrate as a frequency)
-
-Optional properties:
-- bit-rate: Data Mover bit rate register value
-			(If not defined then 0xCC is used as default)
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 8044d38518db..c05dda8bdb97 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -31,8 +31,18 @@
 #define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
 #define UARTDM_RXFS_BUF_MASK    0x7
 #define UARTDM_MR1				 0x00
 #define UARTDM_MR2				 0x04
+/*
+ * This is documented on page 1817 of the apq8016e technical reference manual.
+ * section 6.2.5.3.26
+ *
+ * The upper nybble contains the bit clock divider for the RX pin, the lower
+ * nybble defines the TX pin. In almost all cases these should be the same value.
+ *
+ * The baud rate is the core clock frequency divided by the fixed divider value
+ * programmed into this register (defined in calc_csr_bitrate()).
+ */
 #define UARTDM_CSR				 0xA0
 
 #define UARTDM_SR                0xA4 /* Status register */
 #define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO */
@@ -52,9 +62,8 @@
 
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
 
-#define UART_DM_CLK_RX_TX_BIT_RATE 0xCC
 #define MSM_BOOT_UART_DM_8_N_1_MODE 0x34
 #define MSM_BOOT_UART_DM_CMD_RESET_RX 0x10
 #define MSM_BOOT_UART_DM_CMD_RESET_TX 0x20
 
@@ -63,9 +72,9 @@ DECLARE_GLOBAL_DATA_PTR;
 struct msm_serial_data {
 	phys_addr_t base;
 	unsigned chars_cnt; /* number of buffered chars */
 	uint32_t chars_buf; /* buffered chars */
-	uint32_t clk_bit_rate; /* data mover mode bit rate register value */
+	uint32_t clk_rate; /* core clock rate */
 };
 
 static int msm_serial_fetch(struct udevice *dev)
 {
@@ -155,34 +164,63 @@ static const struct dm_serial_ops msm_serial_ops = {
 	.pending = msm_serial_pending,
 	.getc = msm_serial_getc,
 };
 
-static int msm_uart_clk_init(struct udevice *dev)
+static long msm_uart_clk_init(struct udevice *dev)
 {
-	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
-					"clock-frequency", 115200);
+	struct msm_serial_data *priv = dev_get_priv(dev);
 	struct clk clk;
 	int ret;
+	long rate;
 
 	ret = clk_get_by_name(dev, "core", &clk);
 	if (ret < 0) {
 		pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
-		return ret;
+		return 0;
 	}
 
-	ret = clk_set_rate(&clk, clk_rate);
-	if (ret < 0)
-		return ret;
+	rate = clk_set_rate(&clk, priv->clk_rate);
 
-	return 0;
+	return rate;
+}
+
+static int calc_csr_bitrate(struct msm_serial_data *priv)
+{
+	/* This table is from the TRE. See the definition of UARTDM_CSR */
+	unsigned int csr_div_table[] = {24576, 12288, 6144, 3072, 1536, 768, 512, 384,
+					256,   192,   128,  96,   64,   48,  32,  16};
+	int i = ARRAY_SIZE(csr_div_table) - 1;
+	/* Currently we only support one baudrate */
+	int baud = 115200;
+
+	for (; i >= 0; i--) {
+		int x = priv->clk_rate / csr_div_table[i];
+
+		if (x == baud)
+			/* Duplicate the configuration for RX
+			 * as the lower nybble only configures TX
+			 */
+			return i + (i << 4);
+	}
+
+	return -EINVAL;
 }
 
 static void uart_dm_init(struct msm_serial_data *priv)
 {
 	/* Delay initialization for a bit to let pins stabilize if necessary */
 	mdelay(5);
+	int bitrate = calc_csr_bitrate(priv);
+	if (bitrate < 0) {
+		log_warning("Couldn't calculate bit clock divider! Using default\n");
+		/* This happens to be the value used on MSM8916 for the hardcoded clockrate
+		 * in clock-apq8016. It's at least a better guess than a value we *know*
+		 * is wrong...
+		 */
+		bitrate = 0xCC;
+	}
 
-	writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
+	writel(bitrate, priv->base + UARTDM_CSR);
 	writel(0x0, priv->base + UARTDM_MR1);
 	writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
@@ -191,18 +229,27 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	writel(0x0, priv->base + UARTDM_DMEN);
 }
 static int msm_serial_probe(struct udevice *dev)
 {
-	int ret;
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	long rate;
 
 	/* No need to reinitialize the UART after relocation */
 	if (gd->flags & GD_FLG_RELOC)
 		return 0;
 
-	ret = msm_uart_clk_init(dev);
-	if (ret)
-		return ret;
+	rate = msm_uart_clk_init(dev);
+	if (rate < 0)
+		return rate;
+	if (!rate) {
+		log_err("Got core clock rate of 0... Please fix your clock driver\n");
+		return -EINVAL;
+	}
+
+	/* Update the clock rate to the actual programmed rate returned by the
+	 * clock driver
+	 */
+	priv->clk_rate = rate;
 
 	uart_dm_init(priv);
 
 	return 0;
@@ -210,15 +257,20 @@ static int msm_serial_probe(struct udevice *dev)
 
 static int msm_serial_of_to_plat(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	int ret;
 
 	priv->base = dev_read_addr(dev);
 	if (priv->base == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	priv->clk_bit_rate = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
-							"bit-rate", UART_DM_CLK_RX_TX_BIT_RATE);
+	ret = dev_read_u32(dev, "clock-frequency", &priv->clk_rate);
+	if (ret < 0) {
+		log_debug("No clock frequency specified, using default rate\n");
+		/* Default for APQ8016 */
+		priv->clk_rate = 7372800;
+	}
 
 	return 0;
 }
 
@@ -241,8 +293,9 @@ U_BOOT_DRIVER(serial_msm) = {
 #ifdef CONFIG_DEBUG_UART_MSM
 
 static struct msm_serial_data init_serial_data = {
 	.base = CONFIG_VAL(DEBUG_UART_BASE),
+	.clk_rate = CONFIG_VAL(DEBUG_UART_CLOCK),
 };
 
 #include <debug_uart.h>
 

-- 
2.44.0

