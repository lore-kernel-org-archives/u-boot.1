Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97B9C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F5182F00;
	Tue, 24 Jun 2025 10:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NgWMZ0E5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6048982E8C; Tue, 24 Jun 2025 10:45:41 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D0482D21
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453647147c6so1732505e9.2
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754739; x=1751359539; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5WWrUKMDq5MkCbRCPhXa0wC/YFnEdcx7EIwLctZu8Z8=;
 b=NgWMZ0E5fflhddI/zDTPqTq3QOAWv/j4HsxPeGmVMvQVtWffXN0rniNApp1hLD296m
 U+ZxUiBl0BKKdmfwFCGDa4XYVGcnaY5K5nPxiI9/ImyUGIBFTkFjr9EBDDbOTBXW0jWm
 C8zcOQ02LowUt7I1G6zZMjJdySWSQlNZFECyVOn/DlbiWlPWuyq9Sv1AtfoL6lHbT1pZ
 8DQHeslPVpPu7vOh+aeryHZhTLOgqQ3W+XCXNrJJZ7UQ8Tq0LdSkx4v5hp5e0khB7MPI
 YF/l8/SBwjLQV09lvtY7vdRH7Ch6PtsqnzImjBomZVbyJ02hQFh3Fd/qbPmI7W0mNTEh
 JDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754739; x=1751359539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5WWrUKMDq5MkCbRCPhXa0wC/YFnEdcx7EIwLctZu8Z8=;
 b=fNVF03mzPNqlEbjx7SDQ2LLMyJHTkgp2yUaI/S4KRnxevQKKHenjoF4zqcYjrUmnIv
 UCoi2q1su7fT3/5RXT/gCKdmBxUm9VComxd1GfAGqaDavtscerx8RxyhDuGFLbghpe4b
 84UKCgy3bwxWpZvEEV/iY7Pef7XdU6aWcyoqgn8WWHOjqZZFlbjJFGghMSZXGFijPzfJ
 xv4IGpygS+ypJzT4dH1r00gKX3QjcXRmrosF7UglHjGKIsIMTp4RdwIdX0HWq/rcVh//
 4dUB9ZYDSR53owNp+x7F5Jl9S54ZVA2ej+7g9pMHo7DPoKDHZ9r1tUnNBZnDB+CdcQaB
 eXZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVO2v4L7zQ36RMOeu//L0bhDQ8gISS/c9DxzrFdIOU8WqNPAq0KQA+HRsTrhbFVI8vPq/2eHM=@lists.denx.de
X-Gm-Message-State: AOJu0YzNv1iezpKaiR9ZI6w1PF3WpN7L8R0AlGWA9tAd+7HYEozltdmi
 2E5U1L5oLUw1aaqEKrUmuBVGFLVOhx1GAhKOaIkxOA/V0UWNufwjeQTLhoP/mc1vM64=
X-Gm-Gg: ASbGncugPmVBSioaMgIxGKXFL00gheP7dNLbVjJS40GESACZ1bdUcd8a2dJRxo7TaEq
 HuYjFc5lLbWn2vQMLopn9mEk//WUNvF5KCecElKTxgNRZlKFOLqsjJ6LqdSj5eBg1VoFN4atC2F
 WpoO3Rcv+KWe5FfgT6mpswJPo5Lrag7mBi7KidVcDhGHdd5Ni0npBrhI/qGjkkX5JDaF4ZRR6aM
 b/RQbdfDU2Tsh5v3LDhQy92pBZ+ZUvgUeRLaNSC6ZOy6qh0DKKJv0X/bxY1woaWfWS9FfN+DnvM
 wNbNzp5ycPn3k3tN2zojZHWcudOzdWYJ1bnLxjS6GcG1znMG1sV2+UAMW9LtbJwuc5+OciNWOMA
 =
X-Google-Smtp-Source: AGHT+IFUa4QQeKfnSTTom1DruT7NQV+50KFRmEfUALGvYGh9O9tURL9yDuBVSxowOsoQ1oA6P3WEBw==
X-Received: by 2002:a05:600c:45cd:b0:453:6150:de2f with SMTP id
 5b1f17b1804b1-453653cc978mr133557765e9.1.1750754738806; 
 Tue, 24 Jun 2025 01:45:38 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:38 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 24 Jun 2025 10:45:22 +0200
Subject: [PATCH 09/10] serial: msm: Re-enable after resetting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-db410c-autoboot-fixes-v1-9-d96c97ae41d1@linaro.org>
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

The documentation for the UART controller in the APQ8016E specifies that
both RESET and ENABLE commands must be issued to set up the receiver and
transmitter, but at the moment we only issue RESET. This doesn't seem to
cause issues in practice (looks like the reset already re-enables the
receiver/transmitter), but let's add the two writes to RX_ENABLE/TX_ENABLE
to better match the recommendations in the documentation.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/serial/serial_msm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 5523ec4afe17f242d61bc2ec4b4534b5b974434c..2c08a84b02773663f3c3a11eddaaa7a8bab2b4a1 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -50,6 +50,8 @@
 #define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
 
 #define UARTDM_CR                         0xA8 /* Command register */
+#define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
+#define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
 #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
 #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
 #define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
@@ -225,6 +227,8 @@ static void uart_dm_init(struct msm_serial_data *priv)
 
 	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
 	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_RX_ENABLE, priv->base + UARTDM_CR);
+	writel(UARTDM_CR_TX_ENABLE, priv->base + UARTDM_CR);
 }
 static int msm_serial_probe(struct udevice *dev)
 {

-- 
2.49.0

