Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD36FC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3805E8824C;
	Mon, 15 Apr 2024 14:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qKzySZTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFFE88241; Mon, 15 Apr 2024 14:44:38 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1649881E7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34388753650so1374439f8f.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185074; x=1713789874; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KKToaQHgyHh55DwkywJHtqMYEmkaeGoRmi5Lqi5pt+A=;
 b=qKzySZTa6GOCDoLPZFr4tx596qfCTf6mDRPq6pCw38pJl0zLUoTuRriCYjFhf73N2Q
 U+uLPknZR7/Qu/P07aLso578j+svWDfOG4b7YhKNTqGqnPnRW9w4GWxDqwuo4Idx0+0I
 9lot+rUemLbWtZLh66oy+T0xrrrREBl+glUWesMgC0nd8xziW5yFSJwQfHlDYqe5wFoq
 YNov3gZ+xg681CZFkRbv4e6Dz7AHvXFA5zYlRTW6CgHRzg4nsNzuuJjMBh06we4upg2G
 l1sK6IHR8OPgAVVytraDSRI+iJrO33nuX8pdI/a6FTF0E8xpVxruKttQwXTwv3uYrAas
 Jzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185074; x=1713789874;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKToaQHgyHh55DwkywJHtqMYEmkaeGoRmi5Lqi5pt+A=;
 b=EbQ215oNFbt1OUseCW8qGZ4khEvI4uLbYXEaXOAmHppJ6MdWedJ586Pt156WRGDSlz
 wnxbU+3xEdth+Ci3ki/geeBPKKnA/Ef+z4/krDQW6nHlNhWHyn53fpSIlteYuQpWPFah
 du8VDkCpL+xOEcoWQmrapiVljg4BhgIxqbLfHy6rpWJYLLoraH+7LBuJCnQtjH7mgW1Y
 QFGeqTg3QrbMvOCPutR02Qh/uMlpvQsIYmKR6dMmq8Fewvas3d+4xsB8v3Opyq4lqOnV
 kE8aDoM3fg8aTabuLVrL4XhiIaLT/uQvU91DAsAFgIxf+RJ7UlO40GuRvzY79f9yPUZd
 490Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+p0B895qvCYBnTK0yk4ENfg0cQFjjH6qsBiRLyssj5EQWBJ5ulab+AZNxIW1Vs3gGU3quZh+VCuOpKUDHU7ajt5wPCA==
X-Gm-Message-State: AOJu0Yz6+rq0zny0hY2kw4B6eLRlN0BfN1j3VRNPBJliImhRBvQbHUwS
 MPKDjf31HAtEdgbOkH0Jj0z6YOu2KMlcAD8Q7KcEls4zikeuXZ5/EtFk02AfRy0=
X-Google-Smtp-Source: AGHT+IHX5FLopbP9Xgjp/lUdHUIUdlcX/0v/KneGcRoqt10gUeVOdqtRX+nX3RExbNnfm5pDdMt+Rw==
X-Received: by 2002:a5d:47c2:0:b0:343:6b0c:7553 with SMTP id
 o2-20020a5d47c2000000b003436b0c7553mr8020895wrc.55.1713185074486; 
 Mon, 15 Apr 2024 05:44:34 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d488d000000b00347321735a6sm7931517wrq.66.2024.04.15.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 05:44:34 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Apr 2024 13:44:22 +0100
Subject: [PATCH 3/3] serial: msm: calculate bit clock divider
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-b4-msm-serial-bitrate-v1-3-5a89f84fd9e7@linaro.org>
References: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
In-Reply-To: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7267;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KjPPA7P49WyT2oc9h6P0tIcvUxSXbvhrv6AJT0MLtXg=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZRf0cneqnr2U0r0wwuyS0I9l9oYzZJ+e/pzN3bNA63
 DVpzV7ejlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRS/8Z/gq1+aczeX1uUUud
 oFA8ofjwtm3tpooS+muj9l/LaGD41crwP0z4i/W0JRG+Xk+1Ot77y4rtO3Fgvmgiz305xQ6eUz7
 /PgEA
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
index 8044d38518db..e461929b4338 100644
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
+	.clk_rate = 7372800,
 };
 
 #include <debug_uart.h>
 

-- 
2.44.0

