Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DFEC77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83EAF82EA5;
	Tue, 24 Jun 2025 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x7F01j+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F59E82E50; Tue, 24 Jun 2025 10:45:40 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9627682C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so124874f8f.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754738; x=1751359538; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gNYi0Drht0MPCKCYD8H2U8fxc6p6ZTI4rQv2wXoD67A=;
 b=x7F01j+bkrNsenI47nKBqUi5H+YlOpN5Hn/vIN4SBidWJuh4Su9cLGgPq5HmWzh++2
 vnXBhQD4dw0UF02WeW9dKzVS/CuyGH8rLvtL1qf+W2k0fwGPWVoS3fbL01LwcFiRmIp+
 Y/3eJ4XLDLmJtVNynl4kl71TrmPg09GfkYAJJGwywkNuhSxNk4SNSzknxOosu98mYAgU
 sgnlEmLXyKFYUT0ig2eig69QbtEF1mSseEh9UKq+VxGxtOEjwxY3gFDJmh8XUv60erMc
 IL2KYinhbDMf26RXoQPwW3PttIGRqmpg2IPT2YEs3BsJvxHMBawpbMPeNnEgAXoDYE3m
 Kq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754738; x=1751359538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNYi0Drht0MPCKCYD8H2U8fxc6p6ZTI4rQv2wXoD67A=;
 b=lY7H3QuRi8lungV9AOLFqr8HR7FN4huPAID8uAeMB0mQ9Nt5IJoOxj+0tkTZEW8E49
 dS3IgD0NeKbRl6BxKhgHGNS3bhaZDelCXn27KEAjyVW6+pHEy1lq1nrbgCyoy5LTXh2h
 u6F/rgGtxw68MsYaORIEJlHSWNP20owUDuuJMLzsZk4GMFgF6ee/fvZjH/agL1HOH/0P
 IdA/DTJ0YIe3T9X5QfTlsYOLYOzLY/nUjFuuyF18ktLYNwIE/0SELsAaFwbfUmIvw5+K
 YaBFf4QK3BWp+4cFd8rpI6aChn8+Y0Mi4CLgZkolcm1kLDVztzgj0xsxOZ1eaHoJXnT9
 I64g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW40jZvcCIF6rmjZKMqaLpseSBBROPLT0S0c3lHgjby8/XqocrMFjf+7SKKjthFt6rUj4PFWtw=@lists.denx.de
X-Gm-Message-State: AOJu0YwB6Ndncmbf3NuCgi9p7pvQGE3hPlxbZTcsztXh3HjKSgQI8BMt
 boRVR7kJoFtOzTCpPaxQeULdAJ3cB5pH6YidJb09tQFEZvvEyOmCRUBuOZ3Krq05bYI=
X-Gm-Gg: ASbGncvL/6E3W6Nioa9oROydX7SqbfAdjVwMaoE3sKzkUXOrNLxizpFIfBodFiG5l4y
 I89iUyoo7ACnmVe/99suwZ90EV5ImPJAkW/yh0bVGq8ZB/jUC7g2f/4wyOJPZJutdILnMizMjIW
 wzR8KlZ46HJySLtMDKaePbwVKbpeR2nSLpHeTHYTw6+lhIu6rPqU1DVbPOfmDT5nNmW56aMwtVo
 NCsTqO8JZCwPa6PJQr35y6sk1CL6/mdptAxk1mUrkEaRJkq8Y+xeJaDXAt35dl4JStdUcLpWfzp
 bFNe/6aNoclocXFNm8ys+w8Jo8jfRrCtNi29mbT6CyN3kvrIwPZ3y8f31g4kWghcHDAymuYlG7s
 =
X-Google-Smtp-Source: AGHT+IGgCFmyn4YYeK17KeJWEvHDzDgB2fAyzbQ1f7a+99S09R0GRb+N3lifgs5qs3fCCvX7fl0gLw==
X-Received: by 2002:a05:6000:2b05:b0:3a5:34d9:63aa with SMTP id
 ffacd0b85a97d-3a6d12fa6f9mr8579653f8f.59.1750754738009; 
 Tue, 24 Jun 2025 01:45:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:37 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:21 +0200
Subject: [PATCH 08/10] serial: msm: Reset after writing to DMEN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-8-d96c97ae41d1@linaro.org>
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

According to the documentation of the UART controller in the APQ8016E TRM,
clearing bits inside UARTDM_DMEN requires resetting the transmitter and/or
receiver. We do reset inside uart_dm_init(), but before writing to
UARTDM_DMEN. This doesn't seem to cause problems in practice, but let's
move the reset to the end of uart_dm_init() to better match the
recommendations in the documentation.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index aa4d10e7c5138f919978272e4967ece8293073b3..5523ec4afe17f242d61bc2ec4b4534b5b974434c 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -219,11 +219,12 @@ static void uart_dm_init(struct msm_serial_data *priv)
 	/* Enable RS232 flow control to support RS232 db9 connector */
 	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
 	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
-	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
-	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
 
 	/* Make sure BAM/single character mode is disabled */
 	writel(0x0, priv->base + UARTDM_DMEN);
+
+	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
 }
 static int msm_serial_probe(struct udevice *dev)
 {

-- 
2.49.0

