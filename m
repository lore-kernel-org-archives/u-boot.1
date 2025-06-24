Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8DBC7EE2A
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A94082C84;
	Tue, 24 Jun 2025 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cnnlWbqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5E382E05; Tue, 24 Jun 2025 10:45:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9ADA82C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4536b8c183cso15736755e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754737; x=1751359537; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N5fL94hT1b9/9n+DvmOx0+/7LfOjkuFTGE0Jxw5BHuM=;
 b=cnnlWbqyEFQ41pfR6weViPm+8pB58ulTSwJDvf0WEHOMilhGu2PI/vpbB8bwg+QPed
 osH6SaIoybeHPTUHj0BtvYe/by62AW3y8Fktt/CoA8hgjrEYu6XvllCovJUQCqfH0dSv
 XPC1xG39s5ugvtKcB1xa/fslSb6GFj9XBKfh4cUnwUQ3QF2zC7xubNd/7pKcb71ChA+G
 NJvmQgo1OOfaVR2I2cMs2aXSpO9zyPxDyBgAH0o0bcgiacqc1KOLDCQZ16poY9LL4mU1
 YxIOPRdtIfe9LIk4kw8lpu3E8Luy3V5LxeZV0WIjXtysrNswuB6o2IGIezkc5G2McviW
 UIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754737; x=1751359537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5fL94hT1b9/9n+DvmOx0+/7LfOjkuFTGE0Jxw5BHuM=;
 b=E5kgA1lcwxAhnt4pSzweW3drluvEprbCcpuxgqWPtE3mB2mhhD+gGsjXJzePOQKT9I
 cdh5XfyhCyCvbBGq9kwOESDJ35YBanz1iA4EHdKa0KHdkWleLS/EP20ykGXSkQMyp5Aa
 HahBbrpzpGjPOKNPEMWNybeVjex5ZQrwF+eD6RQEj95yv1jnxsjKFvhVL5qSLtomRwgS
 xndgAuk1MaKJ+1SevynLRZg8fxcArJLPGoNWNuB7UYVNOGQTABV+znT5qych7mmbmeTn
 acX5KX6+sL/ZY3/l4Xaq7jN7co11XfCaAnWK8tMgO2AX+rM9K7gO7h0ynD53K4YlQSai
 ZyyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULnNrBNOm4J4sEfgu/qy42xvwtGV1h3gJh5k54njJSPbGV2TVVGGEgAoZYTfkoBSLunN0i/IQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwectMkWoiSidyER66jLHQ79M1CeXlzM/bq53jx4GtcHCMyjSmI
 ipeo+Tke2bDL17OTHKIX+akwWYPA/NgiRoTpURO1JTDOs7Q/stcx5CrPohgeHVbFqdA=
X-Gm-Gg: ASbGncu4Ctwr9NVA5ItH7khxhcSbkgsnByy5qAsTJp5Ihj98BxyhxCIVcUK/HuekT8E
 JFPI3LbW6B0a4tray7Ekp6WwsOqsVWba9Kbb+Z9EIhWTEiFK0tHkx/VuzA04Xy4dXeiPTOPdV0Q
 DrJ18UhVrtdi52Imzej6fyCAWdPBjN5k72+nzmTOS0ZVsaxALDUZY4Akulsj/ksblDRoA1gteBO
 waMb+WdMeA6jKcpOGlQlYYOu1gTLDd0bzHsD3s6I9pqXNK5Z4soCxKQjg2yR+3t+p0a40QviuI7
 9qGiUagFVKkbVdMY/Ud0LuoJlJ4EeCchs3HnfPrcEttnEcNU9m218KKkqnV/JZhTvW/KEsPF7UQ
 =
X-Google-Smtp-Source: AGHT+IHqPYfNxZkTU5HFztcU+liWk5fgqTzrtRRCRIgMcbTL9bCfGlcD7BR4m/mAV/pOyvDlBeOfKQ==
X-Received: by 2002:a05:600c:8b85:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-4537c87be7bmr16999125e9.3.1750754737222; 
 Tue, 24 Jun 2025 01:45:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:36 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:20 +0200
Subject: [PATCH 07/10] serial: msm: Cleanup register naming
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-7-d96c97ae41d1@linaro.org>
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
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
2.49.0

