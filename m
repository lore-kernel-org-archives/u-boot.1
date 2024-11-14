Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4FD65C56
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 07:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F837890B9;
	Thu, 14 Nov 2024 08:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mUk0n0hB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC36895C0; Thu, 14 Nov 2024 08:35:28 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36B2C88FFC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 08:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb498a92f6so2541541fa.1
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 23:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731569725; x=1732174525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sh3S7W3CyXTwuVrsKJeLXhpwXCoU3/9P/ICVsi3z/Cw=;
 b=mUk0n0hB4X4fAQO89n5YSXYhGbH182pZp3tFuyf6s4777qIfo493zwH8sD+jtw1Vne
 qL1jAn6cD7eQ47rjfpgF/OyhVY/Jfib+eGUoLQthignbGkc4VXN6OL8mxTxMig+20hKY
 AGIie7aBNTH9Ll9ItSuRjLfaHrY52oAdOZhavRR/mDwVIstUqWNDzW2G/uhNVwYCAR9T
 HNTIRzOr4s0ro8QD5lqm/+LHUpnvDX4Ja0pAskFir9Iq1ndt/3EChJSYoEHaUeQzzfvq
 /l+irhJv5QjDailnUmyNiD9NVOHhPKizxCAqdAtBod5GDoTlMZ0xFL5qOwD8iMMXMQjW
 P7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731569725; x=1732174525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sh3S7W3CyXTwuVrsKJeLXhpwXCoU3/9P/ICVsi3z/Cw=;
 b=cignfAUAm8G/WDZkoTtc0fIS4+k6Tw0Gp4Z6BhwOiGDR7I8DWlVxHtrc+9AUqNKhQG
 FFcbbk6brahgN78f8MsjC+kMdk/RdSL81sGn/fGCbrAWWzP1qaUQExh9Ci+vgK8No5rs
 5fj5HYQmXNLv21dlOpMQfPLIJjb7HJUadJolqktHfcba5e+OAoC6yhI8ohYeb3RnlseU
 VRgfBdztZ7dCeaE7f28J2gHM2ZBf9W0zeNyKGAE5L/8szly8+TBc3cgec2RFa5MECAmz
 z8QRtDmljkV5sviQF5A94/XqSgUh0tIDsMBuBtYVlLYH2YbE5gWjdHDJLWt+V/gORCpN
 +9ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsi0qEgpnRvSMa3RdL0fUrnB3wpwyyK144EEJWsO+lG0oWfoY0UtZVz9iCfBJJ5vprBrD1/bc=@lists.denx.de
X-Gm-Message-State: AOJu0YzFUAOQdRwCCJh7YcyFpaQw3FG3V+H5R34vweULM6S6G5vlNIEM
 QKBz70/Hnk6IN5+QJ06lkj/8n9KXGcAx33j6mKFKs22n0bPThogzHbm+3Q7u8lc=
X-Google-Smtp-Source: AGHT+IGXJb/PTw3wtiR1T93e34XtdSOK+aUmTn7Pnjv+13oO+Gq/sU6UBh35Y3nclfn7E1xmxWqO+g==
X-Received: by 2002:a05:651c:88a:b0:2f5:2e2:eadf with SMTP id
 38308e7fff4ca-2ff2021c215mr115995691fa.10.1731569725303; 
 Wed, 13 Nov 2024 23:35:25 -0800 (PST)
Received: from localhost.localdomain (ppp078087235066.access.hol.gr.
 [78.87.235.66]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79c0aa50sm271804a12.59.2024.11.13.23.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 23:35:24 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: jerome.forissier@linaro.org,
	raymond.mao@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH] net: lwip: Change https entropy requests
Date: Thu, 14 Nov 2024 09:35:12 +0200
Message-ID: <20241114073514.418723-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

mbedTLS requires some randomess in order to setup a TLS conection.
Since we don't have known APIs -- e.g /dev/urandom, we must define
our own function which mbedTLS uses.
The crypto library will call that function recursively until it gets all
the randomness it needs. Instead of doing it in 8b chunks fill in whatever
mbedTLS asks for in one call.

It's worth noting that 'len' in this function is controlled by mbedTLS
at build-time options and currently defaults to 128b.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 net/lwip/wget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ba8579899002..4fd552fd306e 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -42,7 +42,6 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
 			  size_t *olen)
 {
 	struct udevice *dev;
-	u64 rng = 0;
 	int ret;
 
 	*olen = 0;
@@ -52,12 +51,11 @@ int mbedtls_hardware_poll(void *data, unsigned char *output, size_t len,
 		log_err("Failed to get an rng: %d\n", ret);
 		return ret;
 	}
-	ret = dm_rng_read(dev, &rng, sizeof(rng));
+	ret = dm_rng_read(dev, output, len);
 	if (ret)
 		return ret;
 
-	memcpy(output, &rng, len);
-	*olen = sizeof(rng);
+	*olen = len;
 
 	return 0;
 }
-- 
2.45.2

