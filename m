Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F1FC83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 15:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25FDA8357F;
	Wed, 23 Jul 2025 17:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jyQ1sm/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF618317B; Wed, 23 Jul 2025 17:54:12 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56D583531
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 17:54:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso34744085e9.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753286050; x=1753890850; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LudaXMFt/WTlQGov2yRr7wqif/So5PBLkf6nmO/Y9Qc=;
 b=jyQ1sm/FVBZfu8XSmzfKjkT9yQ4mVTEtYFVYgyCinw1B1ddKlqbsiMc6WWu5D2COEl
 TEhQ/rtfOAmmxcXFEqL2OYieXOqH1o/g2zmRYknl0bAcxaXtw4XMefs29tZ0P1Sx4/l2
 06yO+yGBe+HAvDG17ACgfHPP3vDm3usbthUqBYxXVdA5bfvGxgjRD2E321OlT0+OVRZB
 j/O0ezScrdg7LiXpouO9zwmKpJzSMkLmKJjKy4rSsIePVFt7NDrtOSgA3CS7yGants1Y
 W0oVkTUt9gp5na/SK7vX/fUb/f8XEMpLDfe7JhBiOjTVgGB72O8QwXVAEFRi/lq3pF2j
 82Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286050; x=1753890850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LudaXMFt/WTlQGov2yRr7wqif/So5PBLkf6nmO/Y9Qc=;
 b=kD91ca7u41cTAWlOZE7dHAaaSue2VTAN48UE1oCyIr9HmTCtT/yZ+Ep4lNi7vzYf1X
 PA5pzGvEwQTGOmUVnM4GreYTOktnkg5Eor8eySSre9RcxasbNCfeTEV5X6SkTPzd6Aq4
 n5jiqHRiI9FxAyUEtBCdVCiFsRrMLm1XXaRypoVSjp8X+Nzaf3qdifdhLf79ISXoOzOQ
 DCVWHORNZxXTee1/TxOjyg/MwTXsc1P+wlveRCEkEjVO6KhBq8zL+s4FvAMnxohcd9CZ
 eluiWTXqyWYQ4bIDWnE9A69HJsSLGpOFbTwamEYm+08uYS5k4pH0ojA5jWFWgv5VNbMQ
 fCag==
X-Gm-Message-State: AOJu0YyyWBeB2idN9VgYhEWWR3+rUoYvUji3yvNl94dA2G9J2VoXD9RR
 L7TtAxdn/RCvZFFfpfymaI7YP/aPIbRTb1ffuZQN96JZp/oJ/v48NbHfmhJZ+wR5PS0=
X-Gm-Gg: ASbGncs80X+puHtCPoQOpK6HdZcrofRo+7raV8gmnpVWTMKrmiRtQKi+8y759ECzSZo
 mUGdGslSVMb7TVOSPvYpqPH6ypqmD8mb06BCZt70OMe1FI+7nphwZvPf91Mf5qjLqgKSBymHFME
 5iAjFcyTRkgvfDn6eLulvZCQUQq0TpTQJrQ+rBPXYEVS+9ul92qZCUTRc5gr+Xm3kzXJ3+OvJwO
 rk4DJaIT4dYSpDPYOKY7Vu1Zi8vZetNcqT5s6xKN8pSKqOjl7By3P9/YAPSB2zZkUXi5IRBCIUp
 QuwflFQJjib9im4BcIP+KwkjnL9u4st3kU4hSa8TCXxUf8Q1Aqv2WvVF7TVRiPEgamE/eMcUfDF
 5kh2qJ8zJfr/cIyG6A/eJOgWt9xgNfsxd3XEBXLSjJLHRvHSbEEA=
X-Google-Smtp-Source: AGHT+IEOosXMIxny96AGjPDgduhCcoA8eECfoN9Zdn4v5zNZsYGHmB/2HmIQXgI4bho3r5x4rTI81w==
X-Received: by 2002:a05:600c:34c8:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-4586e52be2bmr1272625e9.6.1753286049983; 
 Wed, 23 Jul 2025 08:54:09 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45868ef50d8sm28345045e9.0.2025.07.23.08.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:54:09 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 16:54:07 +0100
Subject: [PATCH 1/2] clk: versaclock: return value calculated by ERR_PTR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-clk_versaclock-v1-1-9d70f2530871@linaro.org>
References: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
In-Reply-To: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

In versaclock_get_name -ENOMEM is passed to ERR_PTR but nothing is
done with the value that this calculates which is obviously not the
intention of the code. This is confirmed by the code around where this
function is called.
Instead return the value from ERR_PTR.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk_versaclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 9ccaf13d242..790ea4dbe82 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -850,7 +850,7 @@ static char *versaclock_get_name(const char *dev_name, const char *clk_name, int
 
 	buf = malloc(length);
 	if (!buf)
-		ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
 	if (index < 0)
 		snprintf(buf, length, "%s.%s", dev_name, clk_name);

-- 
2.39.5

