Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFCFC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0344C8467A;
	Thu,  7 Aug 2025 18:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mGL+EMJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC1683C6C; Thu,  7 Aug 2025 18:35:27 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86668460E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458ba079338so9156205e9.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754584525; x=1755189325; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I54zOaJGWG8E0eUBH1sI0ySXJr6u2r5auDpEKW8IMso=;
 b=mGL+EMJzyi/pPZCbKxCvTMOLbac3plWtAU+Q/JdumeSO7/a/PpXH02XXvhBHzOh8qY
 yJokfhB4v0YPdrRgYo6+bzWm/pOs7cdcMWyMbDgE2bz/iWFoznkGUHC2ezvsj6JwWpTU
 6j6yiGN+P5RbXRuQVHao9DOO7+0/uWOlMCW1h3d6oPOnzx1S57N0BIZobSMFhEjBJCow
 +6v9GF41wunL/RGcaSWlDW9f/vkz2qYKjYP5mF0jr7xXSsg+Kkp1uiK4R8qltpmd11ta
 weY+EfcvFdJdleCereQ/ClI9RF0OE4VWqCxSsyNvYsJphSTUKRL7JmZpq/FUMRsz+pMH
 YRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584525; x=1755189325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I54zOaJGWG8E0eUBH1sI0ySXJr6u2r5auDpEKW8IMso=;
 b=uwx2yUdYZOcxudc0fGw6UWDDwcAhuoltlA5h9inz4Dnzk9vadBJYfDvgZql0TBhE6e
 ERsB5nXlewEXzJS3123GVCWqz9EBcLQ+MiFJgOJIYCigFJitkDR9cfYca14pc3zXvHEY
 iz49WnInqykA8g6AQK0KrZuq+7AJQb++fHWNshJtGwLucPHICpBa6z4TujmpPrhmJgjw
 qF1W+Kq9s6MA/p+2t0OdrpjZrmsoZvvzKPaJcJvMovH2t8MFg4N7M7R+dI8k4116LWmU
 4sTeUfiGzXNtqKSf6LEABxt4GQP8Fcf7mBvz7YN6Q38aiV5PRqo8hmmMoY55X4q2qGaN
 MJlA==
X-Gm-Message-State: AOJu0YyaUfvLiRbNqsVe8/upV48irSSQwb9yd8Ufm8slbcoNQXziu51W
 TlHHjRCvg1xhS+QbS0NzFJIcBn5yNJOrV2+n49w4FW4YpPzKbYxx60yyWUVn7vGNAcA=
X-Gm-Gg: ASbGnct3tSqvepQBtPA+1BikvKDAP6fFMYz7+IC9HQj4XrPvPdiPn7MNBzpx3Wu5z1i
 YebgxDGe4ecE321TsJdfTXkKILcCwMkM+wSoojyrAVhg7CgIDOu1o2IddJz/cxJTDmIhneQvufE
 GKP4jhvFC+DaOGO/xH4AEb1RXoLklhNLxTvCtGZoODgsz39ggDDwmJ5AgfXltw8Ty1mNdVKlJkQ
 wdbZiCTZVt+H5lMlm9zuoz/SLAN9Wdh4tO3+gs0QUYSHNjerVqTHlviVJ5b2GjLi3xFUrNwZL9B
 mbkgZWRhQKAPagn89cFf1asvkRz3bvl9m8bkI+BLu4pyFDSHvqI8P2t03tUkPxKTH1jjkwbu3b1
 xR8jfGiPbGDt2Enp2aguLO9auDMGPBZieBGp19IFukERiBZqYfNI=
X-Google-Smtp-Source: AGHT+IHqlBbF0vSBt7+aGNGYclMxaXYNuTp/Nu8a7HCUYysVLe4auyPPaKKW2YE3QyjzX31d3QGuEw==
X-Received: by 2002:a05:600c:6205:b0:439:4b23:9e8e with SMTP id
 5b1f17b1804b1-459ede887cfmr51419085e9.3.1754584525222; 
 Thu, 07 Aug 2025 09:35:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:377e:cf4f:d0ff:80bf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5b84674sm108141375e9.30.2025.08.07.09.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:35:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 07 Aug 2025 17:35:22 +0100
Subject: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
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

The code in tps65910_regulator.c treats the field supply in struct
tps65910_regulator_pdata as an int and even tests the value for being
negative so change it from a u32 to int so that the code all works as
expected.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 include/power/tps65910_pmic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/power/tps65910_pmic.h b/include/power/tps65910_pmic.h
index 2026ec2f426..8fa02f33ab1 100644
--- a/include/power/tps65910_pmic.h
+++ b/include/power/tps65910_pmic.h
@@ -123,7 +123,7 @@ enum {
 
 /* platform data */
 struct tps65910_regulator_pdata {
-	u32 supply;	/* regulator supply voltage in uV */
+	int supply;	/* regulator supply voltage in uV */
 	uint unit;	/* unit-address according to DT */
 };
 

-- 
2.39.5

