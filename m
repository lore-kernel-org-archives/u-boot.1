Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D847EC83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 22:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF478655E;
	Wed,  6 Sep 2023 00:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCDFrAQq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B31486543; Wed,  6 Sep 2023 00:17:03 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D4A86579
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 00:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bd6611873aso46734541fa.1
 for <u-boot@lists.denx.de>; Tue, 05 Sep 2023 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693952220; x=1694557020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yzc8WVXtOCReGjT3rJo2E5yBVov6EG5u+EMNpY8m4KM=;
 b=DCDFrAQqES8I3EvMS+xS61RVAUJav4LM7EZESMhick+exD3TQb+FEcgOvmvZ88gkgo
 kKzJ5b0DI3duid/80CVi3FGAhajtZ71uObxOuXfVRyFA6JwGB0ltp3NrJt1m3oWp4f53
 DU+yNbIwLw7G607Q4vGDbx65uMxecUtGe3M3WMAf+ZfjE6zUiCBshYXdiTSrYE68R7pX
 qrv8TxlJsMST6DBwG+XglLuwE3mjY5R9yI08YUu/Z7yZFu1qqqJ1Ha3VKBGoWSUhub36
 fYUY/Q94fJP6lcJawUpNW7U3xEj4V3XJmyMYYfcaKOPc6lHkE3YGMknonYizKiiQROAb
 v/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693952220; x=1694557020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzc8WVXtOCReGjT3rJo2E5yBVov6EG5u+EMNpY8m4KM=;
 b=kjUoRsy6UbB8XYVL3brt4xljKlJ8Xz2W0bjiOWbF69F2oETIMJvAxw5EKMradFc+AC
 Hroe7f/Tfk9E11Ug4u+GYMS2it51irVUwYZA8Z1uF03z1Nb+v2fM5QkH5Q3ERs0ke1Jx
 POnWcSQZ9wykEORu90FkIOVpQyMysMGaRV5SJ2ULr3UjtvERBT1h1Kou/46ogW7Q4QKv
 U03OvaVuYgILl8Qt9rLdZJc7Pnu/2Aq73CZ0CoxC5LQdFZ5KWWnc+w+jpBqsT33VCBdC
 WF1HiREUvbbyR2fPKbMqpK69XTxfBYxkUL3nGtHzR9QmtTW9EkLjUYuy7/Z+QOldH/Tb
 /GLw==
X-Gm-Message-State: AOJu0YzMis/epi8eYxpOajLWdup/kB30U233+H17Zy3aGaqU2FeYOpDY
 75IR4Z09g3NnIJSjHlUV/USS64b2864FYA==
X-Google-Smtp-Source: AGHT+IFAiuSF9hpaSULjpXG/+f0Pf/+3fqCzL02oX7GtBFZhlFqAZKJNA5Fw5DuHllSsy9nr6EELfw==
X-Received: by 2002:a05:6512:613:b0:4f8:7781:9870 with SMTP id
 b19-20020a056512061300b004f877819870mr761539lfe.60.1693952219307; 
 Tue, 05 Sep 2023 15:16:59 -0700 (PDT)
Received: from user-PC.. ([92.51.95.194]) by smtp.gmail.com with ESMTPSA id
 y23-20020a197517000000b004fbc6a8ad08sm2519643lfe.306.2023.09.05.15.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 15:16:59 -0700 (PDT)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: u-boot@lists.denx.de
Cc: Maksim Kiselev <bigunclemax@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v1] clk: use private clk struct in CLK_CCF's enable/disable
 functions
Date: Wed,  6 Sep 2023 01:16:49 +0300
Message-Id: <20230905221649.3577929-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

In clk_enable()/clk_disable() functions, when CCF is activated,
we must pass a private clk struct to enable()/disable() ops functions.
Otherwise, the use of a container_of() construction within these ops
should be banned. Because passing a non-private clk struct to
container_of() results in an out of range error.

At the moment, clk-mux, clk-fixed-factor, clk-gate and possibly other
clocks use container_of() in their enable()/disable() functions.
Therefore, for these functions to work correclty, private clk struct
must be passed.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/clk/clk-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index dc3e9d6a26..542ec41cba 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -649,7 +649,7 @@ int clk_enable(struct clk *clk)
 		}
 
 		if (ops->enable) {
-			ret = ops->enable(clk);
+			ret = ops->enable(clkp ? clkp : clk);
 			if (ret) {
 				printf("Enable %s failed\n", clk->dev->name);
 				return ret;
@@ -706,7 +706,7 @@ int clk_disable(struct clk *clk)
 		}
 
 		if (ops->disable) {
-			ret = ops->disable(clk);
+			ret = ops->disable(clkp ? clkp : clk);
 			if (ret)
 				return ret;
 		}
-- 
2.39.2

