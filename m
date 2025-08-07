Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F02C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380BA84659;
	Thu,  7 Aug 2025 18:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yuBmEjTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E7E83C2F; Thu,  7 Aug 2025 18:35:24 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA3C83C6C
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so11724425e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584522; x=1755189322; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IBvLLpJlkoItKpIkXXDa3NUSQPLt8LwFXBTT93fCbvo=;
 b=yuBmEjTv0yku2wFqeY+sKaiAwXfl3idY/7rwmDhYyINZff+ePrX6LKwRY8UCF/4ZAO
 owdM53946f8oJ1x9v5fPuq7Xtre+0tfv4EFrkQ1QejYgXqkyew/wGJJEduly3r2mqjAL
 bmqnNIhwGg32gHN42NvZNhoMvhOvbcD+QiPrhyZaUaPy4N71Y4TcLo41RTBkzDjfi8lM
 ikcKFvQlWNAQUoqRxeQHzqPwW9VtMfkQV9vkmyf8g7uVfnFTViWsFtSM79IZLvbL1gsH
 c5ExCMcdQ3m62XxNfqmi7d2KoA2wlRBcZM9rPX0GbelC2Z1h38m2MmfUoWoscvGD97ZP
 ChEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584522; x=1755189322;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBvLLpJlkoItKpIkXXDa3NUSQPLt8LwFXBTT93fCbvo=;
 b=pq9ZKfrN4CVrf2nNctW6s2LcROPJARepVzaoygXCKcg49TGzToOPSYNw5IfK1wUDZ5
 T1eiU2AcOmRd6NBHLrWuw3nzHEseGleAji7031HlmPehy3EjLTVGSh76HToo15A3b55I
 MGMJ3xl3GjRqNDD56X2aEUq6m4+aVasumBh7Ou0m30ISBH4FkD+Q0K0vYrU/Prm70H4O
 LnS1HOcXgsDCGdYfU/EVMUsS4YjLMm2bZC3TGnM9av4kaGlgv14p5J7an9C3sQ4gygAD
 wkMelJ9Ackoel1xzTIEq20iIH4gA5c2M1U7DEVqIAu9IXGO1HUEFdVhzOkNUJeY2Lct1
 8buw==
X-Gm-Message-State: AOJu0Yw+SDdcfCUcFU8ZB6RkePfomleAevZ2/vqBCvRX4lwDXukUQthI
 NF03G4j3fwuW9Ndvc3/IEm7TN5awEndU1kHqUtzT1pvBluR0W/7fB/wEHQ8sTs/Rwc8=
X-Gm-Gg: ASbGncuPdpug2M4aK5bEq4ixvUxSeLwHx7Z6BeuuD3Ne+wJP4zfup0Fw/Aud1xnzoE9
 Aiuk8t8hhI8k5ppwtiG+tBXFrEA35upfFusPUk+thx9PimGqQA2NUxyvdY1NE+6gCk0bBIapEkW
 kHyzNcybiGwnXkUh5Z8E0aZVo2L+yBiz4o+y1+scLlpf9BqvNlUvO/EinjnHw5ov485J9aXbQoN
 beCINb7319uRBL9l9jZkPaed2g+h+JKokzBROhuO4tNhU/6CTxdqs3oOUGtq7T3+Zw3aza+ib13
 t5NCYteitD+8yhgyib56bs9IK9z3Ip0bbJcfTbhARvCFosfZw9DMFcyxvr+pw85/KTpJrlknmr0
 DCV1a4ttzVnfIPB5PomL/XoDdCr0jMoZ75WE1mY14eW5HxWYLWKw=
X-Google-Smtp-Source: AGHT+IHgJkgjq2EnTVBfxdoqFYgQCEfNMa+rhdq2NPw52n3c+qh0hCw4yY4zPO0Xh9okTM7/IK5aXw==
X-Received: by 2002:a05:600c:1d1d:b0:456:1bca:7faf with SMTP id
 5b1f17b1804b1-459e74907aemr76419255e9.16.1754584522049; 
 Thu, 07 Aug 2025 09:35:22 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:21 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:18 +0100
Subject: [PATCH 1/6] power: regulator: lp873x: Cannot test unsigned for
 being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-1-42a4105336ec@linaro.org>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
In-Reply-To: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul Barker <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
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

In lp873x_buck_val and lp873x_ldo_val hex is an unsigned variable being
assigned the return value from a function that returns int. Change hex
to be an int so that the following test for an error as a negative value
will work as expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/power/regulator/lp873x_regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/regulator/lp873x_regulator.c b/drivers/power/regulator/lp873x_regulator.c
index 271a7e45139..62d91a23f77 100644
--- a/drivers/power/regulator/lp873x_regulator.c
+++ b/drivers/power/regulator/lp873x_regulator.c
@@ -83,8 +83,8 @@ static int lp873x_buck_hex2volt(int hex)
 
 static int lp873x_buck_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret;
+	unsigned int adr;
+	int hex, ret;
 	struct dm_regulator_uclass_plat *uc_pdata;
 
 	uc_pdata = dev_get_uclass_plat(dev);
@@ -177,8 +177,8 @@ static int lp873x_ldo_hex2volt(int hex)
 
 static int lp873x_ldo_val(struct udevice *dev, int op, int *uV)
 {
-	unsigned int hex, adr;
-	int ret;
+	unsigned int adr;
+	int hex, ret;
 
 	struct dm_regulator_uclass_plat *uc_pdata;
 

-- 
2.39.5

