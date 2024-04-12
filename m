Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59D8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 363BC881C9;
	Fri, 12 Apr 2024 11:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FmbUnk6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066B888005; Fri, 12 Apr 2024 11:55:09 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0C3881C9
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ed04c91c46so779570b3a.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915703; x=1713520503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJGPMVDQs/+70lwOsKxB+VSM+QwlHnt8HABufnH5vsU=;
 b=FmbUnk6fqiEP0eN/9ZoA1nuE+aQKg6W0GDMz8UscOpRTf6yUav3efkE3WSmOQlcV95
 Tys5UxPREt5/LpkEN48nhf5pWYiC4TUJUziw8CxbLdlv82t6vFlXNQ1OHSTccUBPzaXU
 Co2pRuIADIT+xwevHOPEJ6pTGOMW6leHdnG/A6cBpvFiu8XR1gn4teqB8eGGnRBCV28W
 mntEh3+Rhqi2W0+6XSiWh+gFYn+FrTjmOu1jUBxIPI4a5puhi9srVxZnQsaoje40uJQz
 pSAc340KMdoDlsAdpsFnhyqHmhpaHQ0QPT8rnlhpiUVrZptWowsO0C463jZKJwpXiPnK
 Jnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915703; x=1713520503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJGPMVDQs/+70lwOsKxB+VSM+QwlHnt8HABufnH5vsU=;
 b=wxsXDt5GZzD6zB4MidCL2O2LV1bvL+/3BaBaFIQnEmdbczryz4QGMxtgkZZvG7VDLY
 KwGzntjjTCeEjdAi+2WFyfAPnyEf1Qst1awpZgcHPPp6+fWwRI3iS3NuLVdPxvKbrvPE
 iJ/IxLC6AlYh8guj+PsHEF1vzpyM2H1LgaYZl7zIw1TFkZTvVQEnW/EMi65axPYNr6r6
 yxYk4PmfFxNtGGwLtlcCk5WwtUQkHnXIY3MwAvLYkGFwHmLHSRu0VlVqzIHs0+Tmg9DB
 zmhrw0qI9Q2pZlutQwektHXdTkXgqM/6m18/wX+syGv4KZM54dhjoZ9QUCnNnwN7blaV
 Cf/g==
X-Gm-Message-State: AOJu0Yx5Z1eh0/fdFfakcD3PhEkGM5Wuc/q+6hxmo8kKyLxMdFCO1yq/
 slwjaCpggJhF2fJGj0814W3YU3H4emeche7ASdVAwpvALdC2YQVUVF1d1gg5NeaQJo+PwSIyQWQ
 d
X-Google-Smtp-Source: AGHT+IGGsY67kR3X0cDEbZtk3GmTy+/dsbwVnrC3sW5q/OByJrP2S+FZHSTk6pOpa/AwfgQ5ASmLGw==
X-Received: by 2002:a05:6a00:114c:b0:6ed:e1c:102e with SMTP id
 b12-20020a056a00114c00b006ed0e1c102emr2337305pfm.24.1712915703401; 
 Fri, 12 Apr 2024 02:55:03 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:55:03 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 3/7] serial_msm: Enable RS232 flow control
Date: Fri, 12 Apr 2024 15:24:34 +0530
Message-Id: <20240412095438.410570-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/serial/serial_msm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 4de10e75191..3142ecf7362 100644
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

