Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE0C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F87E87F56;
	Mon, 11 Mar 2024 12:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VYkW7mPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B437987DD3; Mon, 11 Mar 2024 12:11:10 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA65887F3D
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso16983505ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710155465; x=1710760265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQCzaxyfvxWVRk6l9sHN4/qxiFxDj4x1Wn4me1NrObM=;
 b=VYkW7mPQlHTYGY0y13XPXIUCVrUPxJTHB+gTh2hFsm6e3eJB3Cgpi7EHFFmUvMHBQt
 YGtB+6/R+l0isaDZ9UgroBDGUkSe54yyghBngwSVmU1R3Qgot3h3WaxOaDIpR5iTOTf3
 /v3+icR1y0JH8+fSE+tdcbFltiIg531aS/h4A9EvhTUS+wT2zASYUXsJe/f+Q5lHCruY
 YeP0sWjmimMEe1UnoSTXd6o+G7Ht3UZTPDwYoJDkc1/JQHNiAlPvGT0lDyF7kxsnZWSP
 eYM96k1twKRJ0Ni69q1MQM9ZhtLKSHlkztM1xVFjDGHvz+wm6PAPYV2X8UAG2Zr+y5TD
 dg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710155465; x=1710760265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQCzaxyfvxWVRk6l9sHN4/qxiFxDj4x1Wn4me1NrObM=;
 b=shI6mkXGU3KhLEj2eNg3CGvGuh1+pgcdOtyPy7MY5rZ3oqGrpgox5HSzcZ7Kf/YRuz
 /bw0+Hz6/bZA973/XEmgr/J3qGwmoPDFpPRZJ4bumqMdFecEs3xqP07Ei2uVcB+gwIKk
 eggV/P6+Zbf5+4Mq2WisspyAkP7Guesd/2mkhWQUFJrwQojtmDmriaULnUgNur65ZCwc
 OSQ44WrNoZhZi1Vd+hi+uaXrfAiugU3XnXsVMZUGolAK7oZlA2bkQUPgFDPY0JFuh7LM
 y21eJrMKulfUF7CYvN/EUja3At5RBjPvCQpgUsHzBT8JYbGaUXqvppXJt5lToBAyCVhf
 kmtg==
X-Gm-Message-State: AOJu0YwF8S8sOBJ82DQywyi2/sPp8KlZfZ7L1Nys7Ot6wKbZA5QDbrl/
 TMl9tK66xegrJx/dQ6Hm6qQ2RGloj/ht+5n8fEcKfaqg8r1mYjlHLblG57zkOpQn3w4Xk2sLxGn
 d
X-Google-Smtp-Source: AGHT+IG3+CzAT8jGJGZNqLk4rJbs91Z6+cBO/SnHWjjcSfvNha/r+MSoOMAtyfY9z/3oAHfbJM+FMg==
X-Received: by 2002:a17:903:230e:b0:1dd:7de6:1bb4 with SMTP id
 d14-20020a170903230e00b001dd7de61bb4mr6292712plh.13.1710155464864; 
 Mon, 11 Mar 2024 04:11:04 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.249]) by smtp.gmail.com with ESMTPSA id
 o13-20020a170902d4cd00b001dd8ce888aasm2877895plg.74.2024.03.11.04.11.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 04:11:04 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 3/5] serial_msm: Enable RS232 flow control
Date: Mon, 11 Mar 2024 16:40:24 +0530
Message-Id: <20240311111027.44577-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311111027.44577-1-sumit.garg@linaro.org>
References: <20240311111027.44577-1-sumit.garg@linaro.org>
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
 drivers/serial/serial_msm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index eaf024a55b0..7b2a3fdb2c1 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -53,10 +53,11 @@
 #define UARTDM_TF               0x100 /* UART Transmit FIFO register */
 #define UARTDM_RF               0x140 /* UART Receive FIFO register */
 
-#define UART_DM_CLK_RX_TX_BIT_RATE 0xCC
-#define MSM_BOOT_UART_DM_8_N_1_MODE 0x34
-#define MSM_BOOT_UART_DM_CMD_RESET_RX 0x10
-#define MSM_BOOT_UART_DM_CMD_RESET_TX 0x20
+#define UART_DM_CLK_RX_TX_BIT_RATE	0xCC
+#define MSM_BOOT_UART_DM_8_N_1_MODE	0x34
+#define MSM_BOOT_UART_DM_CMD_RESET_RX	0x10
+#define MSM_BOOT_UART_DM_CMD_RESET_TX	0x20
+#define MSM_UART_MR1_RX_RDY_CTL		BIT(7)
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -182,7 +183,9 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	mdelay(5);
 
 	writel(priv->clk_bit_rate, priv->base + UARTDM_CSR);
-	writel(0x0, priv->base + UARTDM_MR1);
+
+	/* Enable RS232 flow control to support RS232 db9 connector */
+	writel(MSM_UART_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 	writel(MSM_BOOT_UART_DM_8_N_1_MODE, priv->base + UARTDM_MR2);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(MSM_BOOT_UART_DM_CMD_RESET_TX, priv->base + UARTDM_CR);
-- 
2.34.1

