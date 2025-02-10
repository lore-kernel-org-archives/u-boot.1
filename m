Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23D2C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E27B2807D6;
	Mon, 10 Feb 2025 17:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cLm089+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C61980BA8; Mon, 10 Feb 2025 17:30:47 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AE3980548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:30:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394820123dso5785205e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205043; x=1739809843; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x8PQnZE5b8NQtCMRK0jBSqoQ2N1Llfc/MGZGREVK/KE=;
 b=cLm089+eRcH2kA7NhcHBdB4sbYxwEgqR94jFgXjBKqsH4kYHrel88UyleiAZTO7qe6
 5+XhmHUR+oeDz0LUCS1bMXOI2aPKhQeKxnvBea5DYPZhkMXRaRXXHYYFf13amZYQ9xFy
 bQs9diKCj5aGcmJKkw/ZcH/9NhijvNBaBtW0I6QF1WL9Xq2xxOkNtyBT8dookx3NtYh1
 eNrKw7PZFB4+ygAHJJJWRrjYzvcmEE9x+zieSwsop5uqObpZp7s+x9XLaJM/+QApG2qB
 g95FbOR9mrg1YgVL6s/vDiMcdFwkoS5XeUswu4GNnTSQNEY2coeHxQe8fxDFmWG5jAx5
 ZW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205043; x=1739809843;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8PQnZE5b8NQtCMRK0jBSqoQ2N1Llfc/MGZGREVK/KE=;
 b=w5dyA7k2qVIdPi9QHbeJB6hn5CpO687zcqK8LR/NIfJZ4XXhWmfGYoCMAc1/YFqX+q
 jGG6zTN76iAQrxT7wVl9YXrKqAWbUS4vpn64dGOk1DwXfvrpOYkAwL6YKTxKc6xBmXCr
 zb1mm9GFuWSA90ExhL2edAhPXj9dtO4qB6MANnSajKLbvubcg/s4mkGp1CLyyFvRjh+8
 ZaOjwMt2AOVFuWSvhEs8xW/900szvFKfNrx9z6B7qlrBDP/vsO4dBUJqpFkXamzqxcrL
 ID1eISZGR+ABjuVYlsAoAJ3ngl37aVgOko74+yeLURaIMLtlJBV5g2e88aosukkOijZ2
 L23A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWttdHyzUKkbqNovIWlVzvagq0m8lyuTVetUEdpagAnkYdrBl4S0CzQwlfgNN3ytnbmNgFPPfY=@lists.denx.de
X-Gm-Message-State: AOJu0Yweo8kG5BB2HgmIznSrRsb5ernn4RozmkQJZ0g6KWuudede6gkx
 AkfJdwABZvHcunii5sJE+/2WMqI4mMMeqiXvInWT8/SBIgXHGaCvi6HcA7AKtfkyXXhmsqeh3GR
 6XNQ=
X-Gm-Gg: ASbGncv4VCg0WyeHMQOuxikwN/bTHSyz3LGi3ljdQeBfDodeLuxO/77L+/c4Udm29zX
 HxjldmphRNiAyvXq0Ii4GzFluk3y3OcabFkOykT8OZcthigHGycXsrHrLzbvMtZ2O217BryjA6g
 wDJjbGx9iS0D+8TmrZEfQEY7XYG9uxAVGcpOiJ/086tx0jB9cRa6qU+MfOcxoNJHY1ynMSBMYEP
 N77NOj2HKVrvnUBYIvAgfXi/OxREz1bj2iKeq6UgUkrLLbNbkzi3b6PXZY8hE1LRCO5BPkPJglK
 9U9ObACaLCbei7Gy1z8XKxK2abRrawg=
X-Google-Smtp-Source: AGHT+IFDKY+0gINAhCFNLBX6tYJJzi40nfCq1Ld8YLr0qxRT1GBqfhv2HvdGdfr0KQhctXvqIqtipw==
X-Received: by 2002:a05:600c:254:b0:439:34d3:63dd with SMTP id
 5b1f17b1804b1-43934d365a2mr73687045e9.7.1739205043569; 
 Mon, 10 Feb 2025 08:30:43 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439447ee508sm36211545e9.6.2025.02.10.08.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:30:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 10 Feb 2025 16:30:24 +0000
Subject: [PATCH 2/2] pinctrl: qcom: sm8250: fix pin count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-b4-rb5-sdcard-v1-2-3c34a8bee77b@linaro.org>
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
In-Reply-To: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=IkvOUgdMUtpJLP4C4m0FqyaDSV8dD3UMaeYoTWLeziY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVmhuCa1x9qy795PjvnRYw5fHPkJLCgCf9G5X37zBr0
 TbzyyvrKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABP5vZ+RYV6KvZdm6YK5eVs/
 PU7gmDB1wtxvi1bm6p1eVdzzbKU6nzvD/8ALNbHfZgv52F3Z+6b/dmsMg73XwkLekwo555w8z8z
 5MhUA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The pin count wasn't updated when the special pins were added, as a
result it was never possible to configure the special pins on SM8250
boards.

Fix the pin count and allow the special pins to be configured. This
fixes sdcard support on the RB5.

Fixes: 58fa52042471 ("pinctr: qcom: sm8250: add special pins pins configuration data")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
index cab42fa64ed2eeda7259b0f6065bae8779d06d34..b21cdc4d24b7abd34d3a08a5e1f5d74f9bba4184 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
@@ -106,9 +106,9 @@ static unsigned int sm8250_get_function_mux(__maybe_unused unsigned int pin, uns
 
 static struct msm_pinctrl_data sm8250_data = {
 	.pin_data = {
 		.pin_offsets = sm8250_pin_offsets,
-		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
+		.pin_count = 184,
 		.special_pins_start = 180,
 		.special_pins_data = sm8250_special_pins_data,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),

-- 
2.48.1

