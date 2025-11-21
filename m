Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EB0CFC299
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F66A83A8A;
	Fri, 21 Nov 2025 18:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fNLIQRUs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF18683A57; Fri, 21 Nov 2025 18:34:38 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAB1839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477b198f4bcso16423365e9.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763746476; x=1764351276; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2dHk+aO2AP1znErKPC/EOM2GZQ4+P/mUkLKJLPvyQoE=;
 b=fNLIQRUsJwZuYAeJT8JvE4Z2RKB5TS61iOiuQxbeMYUjpitRhtv0hkxvofErq8lRxK
 ND9g61xJBMtmV4as0JgwOtHyezO0qAja8i3kCrZ/InPyGk2ob1N5AlTPwx8ySx5VPSo8
 i9a627tkqBjR4/azhVFdsph3N4SfJBAnlmoC9ZEfi7oSNfUEtvjikJS0c5GGrA6fRzg8
 zOmyJHui1mHcdcW5WlGsjl36wI3bkzVHGeLYkwgMc8oIjs+rnTluJPMkJo3iKqsN71Qt
 xLrKOkVj5AEO6YJwTAdWHIDbPiE0OcSJ2qxtq9xb/taYxyGZV2igSCOfLKhh5nLFluKL
 fL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746476; x=1764351276;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2dHk+aO2AP1znErKPC/EOM2GZQ4+P/mUkLKJLPvyQoE=;
 b=IsFZ+K3V00fKUlUV35g6dDiHKRRVOD9hJOnV1Nx9zv3E9Is+1RLwpcw/WPhhEl31fs
 N1KDtdR6K+x95AcXPaOPErb+hb8D1P6m1b0XPwJCN1FCQgM/+iiDQKOeSnlFVaVeFjV6
 DZnX9ixrW+2vYxnqgQ0BRfAAzk57Q1s/4iC/Y2WFB65OH1uNwBMzfvIurrm9Be/49JyR
 Og+MgQwz4v1k0+icgtAr/K98Zn4Q93Q1vysguAWaCBJzRR6yikSEAtCKpqFLa1s89DrM
 3ffiAqHHgWdcfe4LTbMvGtk2neufNnRYL4W3FBwOiDik/hn4ajVI7NbZiTcvpMxBj4ye
 YrgA==
X-Gm-Message-State: AOJu0YywxqAkierRqwdU8Ai0r1rbd/8FtZ3TAzjVVNCUKk8mSin87KDS
 gBnQo5gl+mUoQvPMO9ivSPk3OpBaKHqE1MKVtOx3p1+mKpa4mhxWoaZNqflDaz1hOUg=
X-Gm-Gg: ASbGnctsKSUfIAE+jYDQyyBRsZbmfRg5GUtHMjVFG54my1v1SJh2UdYZLpcMxxaIt6M
 4Q1/55+lVvaYzBCPYN8qcezHXXdMQQcvJeVJlJo8R2ADouMLWxjI+DKwsVC6EyjKXQHwB2ACI6D
 1zvYGXni1PUgdlxjHVB3WEGs1M15lG3bLlub/zjKQfpwv7jAj7WrU4B+GHkva1Gci1/EYeZweN5
 VZspUSy/peC9xjh3rMiTayUusaBMawgcMPwJyMRDCMkzcgq5fvG3DejlOd2d5GESjPH+men7o6B
 8RgWw6pNwN+LHWUHI6kh1n356sMRrttscncgPGUJnvcAv9UxVML9Nz5VhHyl++8gpoLzmS7KGDd
 ITP1dbitKboM+SoGyu/soUvD7/okT6rHc9kpqNKgFSeOqRjMojJvZm2S5BOeSopcvplxs8Xvxw8
 xvuOeE1GBvBJSkd1PjqWwH9FuRVezSc3n+g7a7Gd0=
X-Google-Smtp-Source: AGHT+IEv+R3J+yM1E6F7tSqwy2w4OWxIXNDCRH0/iHQ23B550psgFKRFVLGjBkORCX4Q8bnG6W13RA==
X-Received: by 2002:a05:600c:1f94:b0:477:7725:c16a with SMTP id
 5b1f17b1804b1-477c0170de8mr33366195e9.10.1763746476289; 
 Fri, 21 Nov 2025 09:34:36 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:2c01:4a49:22af:8b98:6c9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm87078365e9.17.2025.11.21.09.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:34:35 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Fri, 21 Nov 2025 17:34:33 +0000
Subject: [PATCH v2 3/3] clk: Prevent memory leak on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-clk_uclass_fix-v2-3-74f4ea10e194@linaro.org>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
In-Reply-To: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Ye Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, 
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

In clk_set_default_rates() memory is allocated to store the clock rates
that are read. Direct returns fail to free this memory leading to a
memory leak so instead use 'goto fail;' which will then perform the free
before exiting the function.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index a72a67d75a165c2d98bb702888e848f6b075fc7d..bf9f104193573918ad2efbce2bd2578948e44811 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -338,7 +338,7 @@ static int clk_set_default_rates(struct udevice *dev,
 				continue;
 			}
 
-			return ret;
+			goto fail;
 		}
 
 		/* This is clk provider device trying to program itself

-- 
2.47.3

