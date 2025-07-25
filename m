Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0858C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 11:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012E683935;
	Fri, 25 Jul 2025 13:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zXWQ1XHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314598393C; Fri, 25 Jul 2025 13:48:26 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117F9836A3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 13:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso1785030f8f.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 04:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753444103; x=1754048903; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rApfXgBueQ38mgvvPWop4glhbqIxQYAaoJ0xJp1UaUE=;
 b=zXWQ1XHTi5nlLpgg6bK0FUzCexuDe9br16RtPTpQfi3Gb2xloOQMj//tKKo8PyX63j
 SWBt/tqUDeT1/MUqfjr0YdoSEzpXG7ddZS7Oo/y/hTWBLWOL/Al+3lrHz3LQisJsAFmh
 45pCQgnsNuQ9BrO/7QWTzuPgT8ghOoafvefjbmtc7vD3baewSb6/sS+8ypntkEDEZtkT
 6qL7M00PH2i+lvOI77D0OeSoeOINT8PxOlJWj7zENozg2TwvfNmjTWLLRbBsRjlYXdZf
 UHgG7VTjcs8zm60J1Pq/w6IrYeh3GjIzUVGBYlTIBN008Nrhhcbzi4SoenPEM++JEhQU
 wPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753444103; x=1754048903;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rApfXgBueQ38mgvvPWop4glhbqIxQYAaoJ0xJp1UaUE=;
 b=BhYpz7NO2gWi0zThCvSGA9aJyZJzi9gAZcJ+UdrbtIE1KV/lLS3QdFi47/smwo36fJ
 v1dFmP4l+7d5Sq/+Pr/eyMnLIi4Kjw4YNhRO7G03RFZKEoGUsDcOp0iuISYF9t00QOh0
 jZZqHWp0Sm7GjmiZKkM12v1NH4EbnsfZVgxYWUK/ErfaWcBl+H0xgLFK/Re6xjP+4LtG
 ALatujrdvTIaoAtssz1MlIK4sD5tAEGETzBfdlr6/B+DC1VVOew/nK8406oEI3i+b5BY
 a62RkB1G2R4OzlgZPq49Elz/QvMjyzcXPCZsXUD/j6qg3P+yZZ4mhZIH75ttQ9TH4ltl
 WZQw==
X-Gm-Message-State: AOJu0YwopBegKkiczm+93NJSmvhvAbkiqXQlOSwQ1ZTBTvYOiulWNCI2
 ELiO17bMv9+QFTACvjj0XiVW23h3UT0AdwvWAEMgFfv1kBYC91hbbiuSedDWSkQ389ICX/s70rD
 HuWQQThU=
X-Gm-Gg: ASbGnctqhlRxye+4NzWem3SpTOkKHzpIt0aLecQasxwL5dT91PFuwkWYHTzOi2En+Tj
 sQsY4gJ6pnFb9Y7uDXTcowy0Zeg/v9cDKHl62TybIrO0mqL9KtMQitOBnce2r929Xl9O+Xf6HVA
 qI/QJdMuh+qsgeX5zgXRA2mL7YtOTlDI/zuumkrvGv3TUnBaRb9xuATkNkqJIjspkn6fZMMHx4V
 8KDrknOS4ucPPX5rmDLt9ays3WllT3gA90PsddDC5LNCpTbntxReOA5pXekKyH5Uxs8gqM07rpA
 pR10yp+JsGBWMcn7jYiJd7wpS5Ij1fLgT8Czj48K+7CkhDNP7FzsnoZF1Ub2U8Ni5rsV89TzdmN
 XX10Jk9SqKnjouD4n/676Hf4YOqd9ucpoAuuIXKjz0wQb5kIkIw==
X-Google-Smtp-Source: AGHT+IGCJOGWxZ9lOF50QImI5FvGmD0WqjQA8ktMhhTagzR/zqHJKOFzrTb1Wfdrc4nN3cwVYFCboA==
X-Received: by 2002:a05:6000:2209:b0:3a4:f50a:bd5f with SMTP id
 ffacd0b85a97d-3b776644ea3mr1491698f8f.31.1753444103385; 
 Fri, 25 Jul 2025 04:48:23 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:707a:1ff:4c94:1748])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc6eaf3sm4812782f8f.27.2025.07.25.04.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 04:48:22 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 25 Jul 2025 12:48:22 +0100
Subject: [PATCH] gpio: dwapb_gpio: Using wrong function to free memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-dwapb_gpio-v1-1-ee09ac9db7eb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAVvg2gC/x2NwQrCMBAFf6Xs2UATaYv+iohs0me7B9OwW1Qo/
 XdTj8MwzEYGFRhdm40UbzFZcgV/aijNnCc4GStTaEPXDqFz44dLfExFFud56H1I6C84Uw0iG1x
 Uzmk+khfbCj1EUTzl+7/c7vv+A+8xv1J1AAAA
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
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

In gpio_dwapb_bind plat is used to reference memory allocated by
devm_kcalloc but it is attempted to be freed using kfree. Instead free
this memory using the correct devm_kfree function.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/gpio/dwapb_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
index 04639a4cb68..7ab48780332 100644
--- a/drivers/gpio/dwapb_gpio.c
+++ b/drivers/gpio/dwapb_gpio.c
@@ -193,7 +193,7 @@ static int gpio_dwapb_bind(struct udevice *dev)
 				 ofnode_get_name(node));
 			plat->name = strdup(name);
 			if (!plat->name) {
-				kfree(plat);
+				devm_kfree(dev, plat);
 				return -ENOMEM;
 			}
 		}

---
base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
change-id: 20250725-dwapb_gpio-1a7612ce69e3

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

