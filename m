Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C89CD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 09:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61163884E5;
	Fri,  5 Apr 2024 11:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WRqq6OCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E230F884CA; Fri,  5 Apr 2024 11:08:44 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 461F9882B4
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 11:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e034607879so17199205ad.0
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 02:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712308119; x=1712912919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJGPMVDQs/+70lwOsKxB+VSM+QwlHnt8HABufnH5vsU=;
 b=WRqq6OCKnSoQgIjdyllvXw9mj79iKpxFWxjzOYo/e1AvgWvSGmGStPjHkyL/fRah8L
 Jed9HO64q5CVeFZEjiDesDJjy505S2F+w5+aKstGspRiA/0J1Jt4nOpLO8YlXdBhAUbK
 CU5rp8BDDicFr1RB6nxHO6v+ncAkm/9FxgxPl9ccHJLs8qBpxLmyavXKkC6dA0tJONL1
 gpj1zmzuznq+i1jCJT5kS1EVTRHG5o9Tl7ICec3BEqLvCHITvKDFde6sIXDTC8J6EAk7
 g23+D/AJXIVZ+i+tm+HZsAKgG0FpfhJv7qO0Ftg3qXhSL6pUdeH/UxVdTdZ85SG3YsIV
 tjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712308119; x=1712912919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJGPMVDQs/+70lwOsKxB+VSM+QwlHnt8HABufnH5vsU=;
 b=LE/QSIXL9YrdQVddjQjn4sO8haoXABHQ2+qPcHsPjOtexPI5luhkyCALuU9yDw4LqE
 UKQ4y6hziGcEfYZkXOjJseJ246sS3v3zDTnAAiOr3xg1/dZGMUd4OyAaBRtHJZCNoSq2
 cLnImfEvXgxkhSjNkzovrZ3+Ccrwuw/dPxiOzeN2OhGPY4Q0y4gKnbUkUVBuUWcJHlU6
 PHEp/uYnBhOBOtG63NYpqgPb95ORU7hHBk/cLuYJZ/TAj3BQa+tUyVPRPYt+IxrYfjUX
 f3hlOynegyd7WACiTQHOz6EwY5DX4GMGKoqpIY70X5dlkdwFev+BvgrxXoSPlQbfmszY
 34rg==
X-Gm-Message-State: AOJu0YzfHQoT7BOKbFL7mE5P+wK61rkckpdRHrXo7H7/Rl6IJ47Gcokw
 ARkwilnG6YOJu0Kmli2fyoi2IrDgrI6ZdqIyQLfL2jf+Vb8NXzxC6ZlHbK0uaRLXZXuvAbS6QnM
 T
X-Google-Smtp-Source: AGHT+IFktOORFfO7nR9gOiR86UU9iPxi96Kr4rPfwXIo9HtlaYHPYBrxr+2uf1XfQBJZvVChzGoTtA==
X-Received: by 2002:a17:902:f688:b0:1e0:e85b:3389 with SMTP id
 l8-20020a170902f68800b001e0e85b3389mr911587plg.3.1712308119598; 
 Fri, 05 Apr 2024 02:08:39 -0700 (PDT)
Received: from sumit-X1.. ([223.178.208.62]) by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001e2c0b77b53sm1055959plk.255.2024.04.05.02.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 02:08:39 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 3/6] serial_msm: Enable RS232 flow control
Date: Fri,  5 Apr 2024 14:37:39 +0530
Message-Id: <20240405090742.4148304-4-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405090742.4148304-1-sumit.garg@linaro.org>
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
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

