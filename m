Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C19CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 17:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6084E83253;
	Mon, 11 Aug 2025 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGKrbP6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E68802C1; Mon, 11 Aug 2025 19:03:44 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BF683249
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 19:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458b885d6eeso29513655e9.3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931822; x=1755536622; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4fiyLyHBTKkTT0APTmpJKaVbc2Ebd4DDYk57OZ2r9Q0=;
 b=dGKrbP6ju4II24GgeyCbZ3uyRudRxNpoos/NBmYCeEhSpNwFlAx0llfg034Gf9BuHs
 y/qmHLrq+9/yR3cU8oGZ8ARw0hkpnhmy6HoFzmeeR0/fxU8ziccIY5wZ60mSMg/s42Jq
 ujQeZ8QMRAudRr8Cvu2jINJcuinlciMvW8R80NCn4piOri89e5pvOwufZOZUe2NzfI/M
 r5YodheZvTH6LPVJTt/ihazk9yybYUdEjbde8NYbZl42dg2CHZ7CdNJNkQpsMH36O0ne
 CpbHGru9EZDg4HGBNdpCJv2MljbNZ3+5qpaUlJmWrvaRi6GssXCPg+Go0kpp4/Cil/0N
 wBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931822; x=1755536622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4fiyLyHBTKkTT0APTmpJKaVbc2Ebd4DDYk57OZ2r9Q0=;
 b=XEKm4U1OLc0rrgS+J+l/QOzuIf/XCUQlKx4eAxCb4HCNmHqi+kMdBS1jxSgPDHiNbP
 hBluoWiZ+0Pf9cayOUuD7oco20SpMfjNXxCxK9Lt+cgBejETQQrH/X4JD4AdEU9Fs3np
 Y8z2NJrsy+1VGuoiHyEpApz3RhVanp8RWdWR+OCfvPJ6uKCZuyc0SYysXK3mrAPIzZ6v
 mHTiGEEFKfnHUp5sIlZwDG9sQ0D39Qdro+qs6vADp9xnhbp3aQbUwM4R0E3IzkFQtmUE
 tcYUdEB2GmrHMVhV0nLk8bJeOsFnUFTbNKCEFV3l+BEcKRw9TOj3KphMdKFY1gOgYfrg
 8qzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPzjfgjnQVIS6ihJsrp6c1X7Lyqo4csAFexlGOoaqvAU2RcIeRN2Zaff5ce6XS70jn+T46oEI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7jfZtU7X2c6K+ioNXzsZyb3OyIfgJX9GC9Pbx3vUcUxC7oZMk
 7B3fk9IeTPcXo/ntK929JlAB34aWEJuPxU6rtgu/mpXLMMsPpMG0nCVzMltd3xOik3U=
X-Gm-Gg: ASbGncuc+SJsPiZ8aM7kQFwPhakhDlV2JxoH6qlBIHeM5keUKzjhbhVFBZuHl0GzyLR
 9dlmiGfhzGFVAAzKnc4YI5ACnrTz4afJ7Bmm8/5IwAWfAMWqc6Mo7ZNaNdP6IqDwIFXPs1MmhUx
 4s3NHDga5iY0TVgiiRX338e/s98x/wFEcyICAHbzp7zD9uTdDWTa7lIuoY5chTKl97aWS7owbti
 nBjf5blJ0oFraVaLq0FARm+s0IUU1LzVJCpou6zh7Po+51sDx8FeUFh5AILBotKzx/CAlY8QYI0
 wgB3gTEVmbDtb3wPU+QoImy6i9ze1UPRu2dzM3BOIfAiCk+4Qx+xE7HcORnfQ3sHGNGTk9ZZX8Q
 05w/wFbIp3/OIOHSAnXbHHPxeK/9VgagfuMoTaDthRq3ZwRGw95g=
X-Google-Smtp-Source: AGHT+IHvmV8SC+99GAurQLJK7pXRnhgAy82g6MEVovo31bEINDdevwzskC9SUT7D4KYAtIRpt6uwxA==
X-Received: by 2002:a05:6000:2381:b0:3b8:d7c7:62d7 with SMTP id
 ffacd0b85a97d-3b910fd9b92mr383900f8f.16.1754931821731; 
 Mon, 11 Aug 2025 10:03:41 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:3e73:96b1:418e:3053])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm41215266f8f.39.2025.08.11.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 10:03:41 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 11 Aug 2025 18:03:40 +0100
Subject: [PATCH 2/2] serial: msm-geni: No need to NULL check priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-serial_msm_geni-v1-2-4499179491bc@linaro.org>
References: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
In-Reply-To: <20250811-serial_msm_geni-v1-0-4499179491bc@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The NULL check for priv in qcom_geni_serial_poll_bit serves no useful
prupose as too much other code surrounding it relies on priv being
valid. Remove the NULL check for priv and other related code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/serial/serial_msm_geni.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 33016f0cb53..0eb90f82a34 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -288,23 +288,19 @@ static bool qcom_geni_serial_poll_bit(const struct udevice *dev, int offset,
 	unsigned int tx_fifo_depth;
 	unsigned int tx_fifo_width;
 	unsigned int fifo_bits;
-	unsigned long timeout_us = 10000;
-
-	baud = 115200;
-
-	if (priv) {
-		baud = priv->baud;
-		if (!baud)
-			baud = 115200;
-		tx_fifo_depth = geni_se_get_tx_fifo_depth(priv->base);
-		tx_fifo_width = geni_se_get_tx_fifo_width(priv->base);
-		fifo_bits = tx_fifo_depth * tx_fifo_width;
-		/*
-		 * Total polling iterations based on FIFO worth of bytes to be
-		 * sent at current baud. Add a little fluff to the wait.
-		 */
-		timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
-	}
+	unsigned long timeout_us;
+
+	baud = priv->baud;
+	if (!baud)
+		baud = 115200;
+	tx_fifo_depth = geni_se_get_tx_fifo_depth(priv->base);
+	tx_fifo_width = geni_se_get_tx_fifo_width(priv->base);
+	fifo_bits = tx_fifo_depth * tx_fifo_width;
+	/*
+	 * Total polling iterations based on FIFO worth of bytes to be
+	 * sent at current baud. Add a little fluff to the wait.
+	 */
+	timeout_us = ((fifo_bits * USEC_PER_SEC) / baud) + 500;
 
 	timeout_us = DIV_ROUND_UP(timeout_us, 10) * 10;
 	while (timeout_us) {

-- 
2.39.5

