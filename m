Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58066C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68C887DD0;
	Mon, 18 Dec 2023 08:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qsDQFTaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9E687DC5; Mon, 18 Dec 2023 08:25:06 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F2487DC8
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so2767631a12.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884302; x=1703489102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuUQJQ5LVDA4cpetWZiqqwI3Iv8r8ZP4hNH7VPbYyl8=;
 b=qsDQFTaFeSQVTTHEI9dHp+0T1hQG5605POTMJpLmXWQsWKXbBB1Bs/W4ap63HjkdBT
 G5zjkTAhkkFjCqgi5CuOHoaWi/GWSDO7VxFi6Nx0zxBRNHw+AdnokGl2v7/T6hMymtU8
 v7xm0008avdcIBQnSdppFWkZtXCTcBSnDsnvKvrDfJANz4vDiVQttN4fxwWrRk2EX76k
 j6nkkpqSbwcB2PFR2C9K5gILug8KjC0dy3vNX9dKb/QhhhEkXn4rVXxHuigCVAJA6zV9
 zAcjFjNKVJevQ+h6GRpVaiaRmAzLcrxkZZ8eDgVhIoH0qO0gkPYFMQ+iwkbcZk1YtZIx
 GjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884302; x=1703489102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vuUQJQ5LVDA4cpetWZiqqwI3Iv8r8ZP4hNH7VPbYyl8=;
 b=E7QqT529LZhR5U33g+VVdoS70/Z+7dh0+RW9iv9GH5YMr9fzooovjTA7Byg3L2wsDL
 TXVOgu9euvTRba6LwwKneCXrlkaRcT0ncy6t87riFxLWqHmh8V8dLuO93N9rapPmZp1s
 ktTCsGc7MZDPYtVFnvp7dTAiTrb9173VYl+KlY8XDdL1UiopdRV8IdJ8jyCdaVuV5TzM
 ErfZXdCnfnxnVJJ/nIiemW1og1DEvq0XwLyChKgCzZaEdR7lYBSPkF17LqdM5rZazyet
 Jlm98513gYh03qoFr7v1iGSAdF5f/kcsWFSBpGxYgAM+fF/jQIlDXVOUB03roBbYi/fe
 iQLA==
X-Gm-Message-State: AOJu0Yx6fTaQ4FttaI9Nwmohsel55nxJVTcFbM3z/hAQXB69CwoP8XZn
 fwH0YuRr5g+RLYqBOqCe74C+tVAfFltdXZH4tZ4XuA==
X-Google-Smtp-Source: AGHT+IGcKxtETkdLZ0FbmUeixHn8lr9ktWF+FTeSE1U1g5fODS2wKcGJ3hT7QhO7zNlF558VUxCXeg==
X-Received: by 2002:a17:90a:fe97:b0:28b:6279:4069 with SMTP id
 co23-20020a17090afe9700b0028b62794069mr3096813pjb.45.1702884301752; 
 Sun, 17 Dec 2023 23:25:01 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:25:01 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 3/7] serial_msm: Enable RS232 flow control
Date: Mon, 18 Dec 2023 12:54:24 +0530
Message-Id: <20231218072428.1802969-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

SE HMIBSC board debug console requires RS232 flow control, so enable
corresponding support if RS232 gpios are present.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/serial/serial_msm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 43e58595dc2..a38bf229f06 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -35,6 +35,8 @@
 #define UARTDM_MR2				 0x04
 #define UARTDM_CSR				 0xA0
 
+#define MSM_UART_MR1_RX_RDY_CTL		BIT(7)
+
 #define UARTDM_SR                0xA4 /* Status register */
 #define UARTDM_SR_RX_READY       (1 << 0) /* Word is the receiver FIFO */
 #define UARTDM_SR_TX_EMPTY       (1 << 3) /* Transmitter underrun */
@@ -193,13 +195,18 @@ static int msm_uart_clk_init(struct udevice *dev)
 	return 0;
 }
 
-static void uart_dm_init(struct msm_serial_data *priv)
+static void uart_dm_init(struct msm_serial_data *priv, bool is_rs232)
 {
 	/* Delay initialization for a bit to let pins stabilize if necessary */
 	mdelay(5);
 
 	writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
-	writel(0x0, priv->base + UARTDM_MR1);
+
+	if (is_rs232)
+		writel(MSM_UART_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
+	else
+		writel(0x0, priv->base + UARTDM_MR1);
+
 	writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
@@ -212,6 +219,7 @@ static int msm_serial_probe(struct udevice *dev)
 	int ret;
 	struct msm_serial_data *priv = dev_get_priv(dev);
 	struct gpio_desc rs232_0, rs232_1;
+	bool is_rs232 = false;
 
 	/* No need to reinitialize the UART after relocation */
 	if (gd->flags & GD_FLG_RELOC)
@@ -221,13 +229,15 @@ static int msm_serial_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	if (!gpio_request_by_name(dev, "gpios", 0, &rs232_0, GPIOD_IS_OUT))
+	if (!gpio_request_by_name(dev, "gpios", 0, &rs232_0, GPIOD_IS_OUT)) {
 		dm_gpio_set_value(&rs232_0, 1);
+		is_rs232 = true;
+	}
 	if (!gpio_request_by_name(dev, "gpios", 1, &rs232_1, GPIOD_IS_OUT))
 		dm_gpio_set_value(&rs232_1, 0);
 
 	pinctrl_select_state(dev, "uart");
-	uart_dm_init(priv);
+	uart_dm_init(priv, is_rs232);
 
 	return 0;
 }
-- 
2.34.1

