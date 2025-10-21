Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35C1CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 16:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E8F8362A;
	Tue, 21 Oct 2025 18:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cEN/bQSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7795831D6; Tue, 21 Oct 2025 18:08:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7D7835A2
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 18:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471076f819bso45954915e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062915; x=1761667715; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bx8uhUo4vy9IIMK6qeNrq300sh/tnQRWFmElg8z5wUU=;
 b=cEN/bQSpiTt6o/n9Va5u738YyjuH04tl07DGhaadhVyIQ1oEBpdbER50sva6daebJ9
 5jn7N6sGBOp3cYp3z2My+vy5DL+olQXDxWs6IEULNU/J/7XHgR8JGu5soEjn1En8hEFi
 dLk4zlIMfxOQGhQce2KapgVvc5d4QBp01GzaSvMn6WDA/r5M1uemHSVJsLkFtN5lNdb+
 aUVXk0Rh3IqdYpP9sAppEHKboZYzyPrDAF/0D7inpLcjT7ckkKSY6BNoIr7ih5xHf7ZF
 Ci8ZZKH/GOUMCmwirccobDnGSGcj/S7i1Rmycw9RsVLqKyN/nxRkIOkd1P04g9SHgXlZ
 Enqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062915; x=1761667715;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bx8uhUo4vy9IIMK6qeNrq300sh/tnQRWFmElg8z5wUU=;
 b=sXLnnAb2zYarBGuh4iBBpmDqcxINFjtzrBEK9CkYX6QMs7CzeJOxkemA73/9ZDJEMj
 Wpo7kZaXV0rmOv/Oxj13gBOh1yTqJN8fmN9tLH5CSFR1JDzhlim2DP4+8C7kg3g5KD3a
 qc0LZkSEj3rT6nZEZEHLKd9QsVb1hKZxC9Njc/rNIt+Ah4K60tqv8WLX2oADMd5gTBGA
 1V/sDUehx8G6Gh8EwOuSFXHigSrw9CX8n56zhgg7mvDxmzJ02p7spHcABLZyvPheC4ee
 xIDYDLwJjfdgDZNZlV0Iv35SMq3sSP7NErEMJSqo9fK3LQA4qJObOaUi4wGwrKjJ6kLU
 hegQ==
X-Gm-Message-State: AOJu0YxnQKQe+NDvpmlcR5reuenT8WMPUbhtaJSRWeCXw2pp4edhUvkU
 a5ASKyPKNtl2zMqvWiEpXdDE6YhL156y30cFVpaMBt6SU77VhdI05ZyVIqrvFSpoDec=
X-Gm-Gg: ASbGnct+ib+rLLUEaeCs29UCtNx7lhOEDdfu41CK6sXKx8Flzm9PT1WIwLFGjVUWFl7
 3vqhPFtF2AaM0IPuaoizGGt/7ECaEk4yz8g9Z9x3AGYeMbZ3rKL7QpqJqPHxrd9B43nkAltx4AW
 p2ltcaY2b7kfTyHmI5+kWC+SmLYxbolQWjYYvbzlB1kgSUV1mMuC2ex0OBhMJkwfwT3fur4oIv5
 yKCashoO/OqNGZvbcnJFbqtXPlYmYGnzbI6yrpRmpA8YgIsuOqULa8nxlagU+mEzd26wfS/Oi6s
 b+LyiH6C/E6un0TYQclejzVDqhkf2gyCuswbWmQdbuMez1tyTWb6BKhqG7sojzyVGoTPXf/pg+r
 ZMNRRrQ73hhlXitDTixOE1nEY/ApHB5jrftU6QSddb+CjCv3EtKdLOjaxFP59bO4BI3q7VfFir1
 xhtkjaUFLGeiDR5zXzw2eJUmrjRnA=
X-Google-Smtp-Source: AGHT+IF2Kmg/gUHmGSGZREvN+Aa51F9v6SPu7UdY9XMxLqDLN39G+ng4Ldxd7dCMgKiobqwzeHZ/BA==
X-Received: by 2002:a05:6000:2210:b0:428:3da6:b1f1 with SMTP id
 ffacd0b85a97d-4283da6b26amr7352661f8f.32.1761062915359; 
 Tue, 21 Oct 2025 09:08:35 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ff54:533:2c9b:1f57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3ae9sm20830245f8f.13.2025.10.21.09.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 09:08:34 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 21 Oct 2025 17:08:30 +0100
Subject: [PATCH 6/6] timer: imx-gpt: Fix error detection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-clk_funcs-v1-6-acf51a40eea7@linaro.org>
References: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
In-Reply-To: <20251021-clk_funcs-v1-0-acf51a40eea7@linaro.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Schocher <hs@nabladev.com>, 
 Jim Liu <JJLIU0@nuvoton.com>, Stanley Chu <yschu@nuvoton.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

Testing an unisgned ivariable to be <= 0 will only detect the
case when it is 0. So correct this error test to a working version that
will behave as expected.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/timer/imx-gpt-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/timer/imx-gpt-timer.c b/drivers/timer/imx-gpt-timer.c
index 07b9fdb5e18c50236bd302f2539da9775ac2b35c..7708d1ba17f2f1460599d374771090083e9313f6 100644
--- a/drivers/timer/imx-gpt-timer.c
+++ b/drivers/timer/imx-gpt-timer.c
@@ -127,7 +127,7 @@ static int imx_gpt_timer_probe(struct udevice *dev)
 
 	/* Get timer clock rate */
 	clk_rate = clk_get_rate(&clk);
-	if (clk_rate <= 0) {
+	if (!clk_rate || IS_ERR_VALUE(clk_rate)) {
 		dev_err(dev, "Could not get clock rate...\n");
 		return -EINVAL;
 	}

-- 
2.47.3

