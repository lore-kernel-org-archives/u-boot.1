Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB589CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 12:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F9E83164;
	Tue, 12 Aug 2025 14:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ougnOdW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A076E8319A; Tue, 12 Aug 2025 14:01:07 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FCEA83096
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 14:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459e20ec1d9so52848405e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755000062; x=1755604862; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kNtwJkp5fDv5+JcrYQtQLc3qLvetHXqKELh56XvHN+8=;
 b=ougnOdW/Vxg4idaOqkC+UjHwVOenZbIEQj3PZoOFa5FLd0TDt0xcVULQ5ve33qGM4n
 Pm/OuLsIMCDWCHGsbaNgD9aIUa8wmgKJYDIuMwukZsxYPvgHA8N5R/Syx7t5QZGDZYxT
 V4Po0KXibkQbobg4Ek6F+VMyFvRjFvX0PHMdPn644Q5vDTvr8tZmLuGY6X6GoODyEQGc
 HfyEuxFmQrzJS98vaVWigJnIARGN4oZX2oDGodm/eRoKAIDl8Tvg2w5bgvksXeGIwLnU
 OMRtnPQtq+oXnP7p0zW8mblB9tHE7Fuq8rs8T5fWn6K5PKMUVDhC7AtVszzMQ8CxiDVB
 6oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755000062; x=1755604862;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kNtwJkp5fDv5+JcrYQtQLc3qLvetHXqKELh56XvHN+8=;
 b=v1MS1YU2V5D4u7kLh8EJHAsqLht0rruhL2D1E8dMJzdVY38F86BBj/5BAOSBWuKLue
 MUoF1euwclOBNN3iJQ5VO2rxQHitcybSEzalgo6/erzfbrFSetkptcTcFxA3+g6wPVMv
 mL4OijJYjIWqbVbw6Khrz5cv7LZzI3foqKmxmrmKCb6IFmX+UExnchY7wRQfDP93rNxg
 bEFTpl/ypc1YtY0dKvIfh1Ri5DOrvPyKHL8e9djlqcENJBLP7tj4GlJQFvnGtAfi93KU
 ZOxEQsoveqAsEeDYy77LglkG3hwLCOQEwSIYyGx6vnfJmZVQXQYih21WRasfMeTrEfgK
 zFWQ==
X-Gm-Message-State: AOJu0YyiL+2GEFDGaTvzy8NaPpHbdjrG59GDCA0FT2pLQ2hlFQQEJBSR
 cvFPc1an5rLzSfqgyWzYMxycHQJaVT9wT7NAbUcq0dNsYFu0tUmaKcWxNUO5XhDGBi8=
X-Gm-Gg: ASbGncvbYCEGBDB1EQQ3um4c4gD5zdmYxZ1gknbfR6xNiA6AyalEjCMD/UX/dvu8wf4
 dsT4PdomdCgyXOIfGLyo2BoFMi66OBPbP6YllxxgDiBCN2pPE1GMuAeYBu31osUzKOVFYzbrSoe
 2iY548sOmS2xkSsHxDARsm6IASUyADXz+1BkduiiGRch8gTrbOs1M9BO/sXb0jGrSKxdLwJyjdg
 yaPyOJnir45hU2pRRXkKdwhxDHzhBTDQoTCAb+c8p3z1eEE41bfPbi8mBZ1BX+9G3uhgie0StWJ
 +iasY50etkbWmujVQbyb3rIHpK4Uu/jqQk+JyP3mFhERSL2QfeF+uw1pRo7/HydrkvPpMUXsdOq
 R5OwxyzLS8OaP2lxozW5hSaqI/pCn5W8OYdRxTYoWH9nHBRX141w=
X-Google-Smtp-Source: AGHT+IG/WkQ9fAb8+I31wA1hB2kET5qohIx0EJC+9LFs6n9ZbGrp0gr7M5P7l3nMUS4AkKkvv5hySw==
X-Received: by 2002:a05:600c:19d2:b0:459:ddad:a3bd with SMTP id
 5b1f17b1804b1-45a114c20e9mr28575935e9.15.1755000062340; 
 Tue, 12 Aug 2025 05:01:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:97a2:1bc7:9f2e:6519])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c45346asm44004676f8f.39.2025.08.12.05.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 05:01:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 12 Aug 2025 13:01:01 +0100
Subject: [PATCH] spi: exynos: Remove extra term from test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-exynos_spi-v1-1-bd0813ff6593@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPwsm2gC/x2NwQqDMBAFf0X23ICJSEN/pZSSxNe6l1WyIhHx3
 40eZ2CYnRSZofRqdspYWXmSCvbRUBqD/GF4qEyudX3rrTMom0z61ZmNt0+HFDsbfEc1iEFhYg6
 SxisRlOXSc8aPy/14f47jBIodtqdzAAAA
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

In spi_rx_tx there comes a test for execution of a code block that
allows execution if rxp is not NULL or stopping is true. However all the
code in this block relies on rxp being valid so allowing entry just if
stopping is true does not make sense. So remove this from the test
expression leaving just a NULL check for rxp.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/spi/exynos_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
index 1b9bf004b7c..d11952afe5d 100644
--- a/drivers/spi/exynos_spi.c
+++ b/drivers/spi/exynos_spi.c
@@ -166,7 +166,7 @@ static int spi_rx_tx(struct exynos_spi_priv *priv, int todo,
 						stopping = 0;
 					}
 				} else {
-					if (rxp || stopping) {
+					if (rxp) {
 						if (step == 4)
 							*(uint32_t *)rxp = temp;
 						else

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-exynos_spi-8172ecb31a83

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

