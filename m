Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732F5CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2972183045;
	Mon,  8 Sep 2025 13:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F83R5SBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2787809A5; Mon,  8 Sep 2025 13:31:49 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3065283071
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62733e779bbso647077a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331106; x=1757935906; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5giRhbRYt++lepoyzIiUO0KYvtbU1tZ9fOFD193nKXI=;
 b=F83R5SBDtTZjxYwB943f0zYfukGOB4T1cHssh1sedwR4Jhqb1gkf7Ffmg650I9AcDl
 z1grflMRJhWod/lLJc4hwSEOBhFYEpf19Y/WSVAAr/U3YbfoAZ7EmxhqC11OYrNm+Orj
 wr6TzBMF/nK7xSwS5oi/MXEU/OItcRwN85wcwEKXz1Mvdmaux+Lpx40Gpych+3J4/jHz
 45uvTxx0k1h1qdPD+xsSz7u2UdWHFpkqPcDyR13QeUR2MBvSmyE3vss/UlD6qqcji96H
 6SpIg+I74gZgjNYzrJdWg7+TkPrdXeVjXXtF4r5LJ7TaLoyhhhCB1YT3IsAjYRq6pSiP
 LDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331106; x=1757935906;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5giRhbRYt++lepoyzIiUO0KYvtbU1tZ9fOFD193nKXI=;
 b=hFdsoKZBED3vtr/8g3CiySQ6GY1hETEXsTOlbD6/21BdB5vfBxelX0/1YnSRr0sgTi
 5FAw7IIW/0laQrtcWYA7GpYdDx+aiQtHfYUaJRAm+w50CRNAO9P0ur+DEnyhXgyXE+XZ
 j7oGcxs4yGlFDgZHNRC47V9T4KK2bCAwzuGCfW3yLDy5+YQ4e3iZ1/oQ1CS5DWsFw7Y8
 /CdcJqNBwOCPxwAXl7xyKV3QXwD/DRvrdhiBRbazOQwTwNZTqGCM+CVZPEw7U07RkIpc
 9BNi/fqGsbjff3qVuAXJTJqjVsqWf5zf16LJPhoV/HQ7le6XhpoHBlV7oCeqoOb08RMU
 n/Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEGvgK22a13tZEfc+If52Q0KhfBafqDE4BPEPLLwLIffmJ7Q1QDUcTNWhAzRLw+Sw1KUjBqiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzP9WaOSbU0Qr7hChtQEs7BEH4tXOk+u/ga8AjuGACGuE8w+rVj
 V3uSqLRqgI+yGOOkbzHwoItzHE+3M66OymoJBPzVHVAkF3FmxxhPHMpMWQfNbg8dfro=
X-Gm-Gg: ASbGncvgDMM1Wkz267M/MorwwrVRzfHgzurh7twI8T+NXvrYsR3Yv9PJt/LNtnzJAO/
 Bk4NLKLe+Kc/9bZuxTac3O8T5CN+fXlhgFekQ6nEmyxABW6eJAdF6jpFX2iIr0jPrTndTfMUThK
 xub5OM50cwiYvBdwaEuomU3R0q+heu20jvuNUv20wvlH3za79YW8YpjTKeGc2H/iOWdDTCWWCUm
 xGyuqPuMUhKdtOVqDOR5Lyu8C1KGDNRyzD4Qn03c3ZI3Pc+Ylb6bFyHIzWYcLDa7QbH7FzUa/Dz
 ytuQo/2mXEg1vl3W8Aw2SClTiVX22Wr9VVuW+Tdn94iPW4894ugl1NZpVinDm0M11pRi/MgFqC2
 wvVPFimHtYbyUlzYIS+J4jPHsyeBlztHYiw==
X-Google-Smtp-Source: AGHT+IEQagq2YvwHLfbwZXRELCPzZ6DVnCTkwo/dIFBtTlQFK4kDwZ+atocBzjKGiXutungAHjIrhQ==
X-Received: by 2002:a05:6402:84e:b0:623:47a9:de2 with SMTP id
 4fb4d7f45d1cf-6237ebc9372mr6868055a12.17.1757331105572; 
 Mon, 08 Sep 2025 04:31:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:45 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 08 Sep 2025 13:31:23 +0200
Subject: [PATCH v2 3/6] serial: msm: Cleanup register naming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-db410c-autoboot-fixes-v2-3-316ed98e0143@linaro.org>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

Some of the register definitions are inconsistently named (likely copied
as-is from Qualcomm's Little Kernel/LK bootloader, which uses the
MSM_BOOT_UART naming scheme). Rename them to be in line with the other
register definitions and move them up to be next to the related register.

No functional change.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index c8df91fca589433e57cd4c25a18d09548715c840..aa4d10e7c5138f919978272e4967ece8293073b3 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -29,7 +29,9 @@
 #define UARTDM_RXFS_BUF_SHIFT   0x7  /* Number of bytes in the packing buffer */
 #define UARTDM_RXFS_BUF_MASK    0x7
 #define UARTDM_MR1				 0x00
+#define UARTDM_MR1_RX_RDY_CTL			 BIT(7)
 #define UARTDM_MR2				 0x04
+#define UARTDM_MR2_8_N_1_MODE			 0x34
 /*
  * This is documented on page 1817 of the apq8016e technical reference manual.
  * section 6.2.5.3.26
@@ -48,6 +50,8 @@
 #define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
 
 #define UARTDM_CR                         0xA8 /* Command register */
+#define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
+#define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
 #define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
 #define UARTDM_CR_CMD_RESET_STALE_INT     (8 << 4) /* Clears stale irq */
 #define UARTDM_CR_CMD_RESET_TX_READY      (3 << 8) /* Clears TX Ready irq*/
@@ -61,11 +65,6 @@
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
 
-#define MSM_BOOT_UART_DM_8_N_1_MODE	0x34
-#define MSM_BOOT_UART_DM_CMD_RESET_RX	0x10
-#define MSM_BOOT_UART_DM_CMD_RESET_TX	0x20
-#define MSM_UART_MR1_RX_RDY_CTL		BIT(7)
-
 DECLARE_GLOBAL_DATA_PTR;
 
 struct msm_serial_data {
@@ -218,10 +217,10 @@ static void uart_dm_init(struct msm_serial_data *priv)
 
 	writel(bitrate, priv->base + UARTDM_CSR);
 	/* Enable RS232 flow control to support RS232 db9 connector */
-	writel(MSM_UART_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
-	writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
-	writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
-	writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
+	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
+	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
+	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
 
 	/* Make sure BAM/single character mode is disabled */
 	writel(0x0, priv->base + UARTDM_DMEN);

-- 
2.50.1

