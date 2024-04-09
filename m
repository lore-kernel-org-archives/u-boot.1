Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86421C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7E5881A0;
	Tue,  9 Apr 2024 20:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xhBZnacg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC3A87DCA; Tue,  9 Apr 2024 20:03:15 +0200 (CEST)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D5C48810D
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d8a2cbe1baso13875001fa.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685792; x=1713290592; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=COZBImoxll+oAM1n1Wapod0ocBZ+XrwdpBWvp9I07do=;
 b=xhBZnacgIwXLZSmQvrNGzElR7fDabf9UUcfn7ZhplTr7uZch3k14gOE41OzqTsZX58
 ybfrHyzUkF5O1+1RYfzzms1nwzWrdx5lHOVyqy6N+6pj1s7G7jZzRX5TiY0DRg+bi+OB
 W/NlOYlBUnnKOXchkJRU+a9mlw/Dfw+lsFrRv+K5Ph6344WoBNskyIqzNAYhgb6oCFX2
 DeF6uIV9zLeuYYrUegeb2TccV3dx7rhQ07vG83LfGKQNYTtTh+LYZ9HVzj8kTF8lgdJN
 P874HO43fCAK/BZIiJIsgbvFvktRd7nO8IkWXbPHteW+KmF4MAOGy4dWqN1K5F+0EkRD
 08Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685792; x=1713290592;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=COZBImoxll+oAM1n1Wapod0ocBZ+XrwdpBWvp9I07do=;
 b=YyeFm6aY3U9+sLBXVg3QXAJW7q3fIXLLR4VCkdkld+K+CO6LzdsAmqL8O3lJuzmuo8
 k5OMUHjh/U8cXPRwCO1mr4ODdzZTRCkvjSw8RLvLRpu6Qw5zK7ysxPH5jBj8aly4RR1c
 3tKVoguvk+H1eYACiDTKXvF3OQs1wDHjx/FfFXYUZ08cKXUL6t0zucTW8vc1A80RTcf1
 SQYP9VKqvrcThlExc0KxGjQBi5eTaCRd6eWxaD0dS/q9BpHbHUxo9ZfJzgQwCcvBmwXc
 JTGA4Elt8E2UFrdWh6bvH7AU8ir7yKJhL5xgdjLVavbIyrEkYxjHi/go9rtk5wNqhCwA
 drgg==
X-Gm-Message-State: AOJu0Yy0Se8y5qfOoMwvajpYnve05fz0oare10cj+/ike43SYqREua9S
 2gj60smT1Ykz7rQKAURMTgoJN90M6f9gB5V4PwJDdh49a9I2UJFTRgMI8KzmvqU=
X-Google-Smtp-Source: AGHT+IG8wM5jRYf98yS8T46sq1I/2GA0ZSaF/RzQmuKPKicRKqlQXmzRGHtzmmzMED5PrbHAd/3XnA==
X-Received: by 2002:ac2:5bc8:0:b0:516:c3ee:5c7c with SMTP id
 u8-20020ac25bc8000000b00516c3ee5c7cmr128130lfn.4.1712685792506; 
 Tue, 09 Apr 2024 11:03:12 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:11 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:03 +0200
Subject: [PATCH 4/7] mmc: msm_sdhci: use a more sensible default clock rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-4-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=b7ukOh81BnIglY63qkvOvISFqDbdcJ+fCYYkTyYzjF8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLYuGOmjIpGlcYiDSdNWQx0ILo5xeNIbcKHw
 1Fp/1A/nfuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tnXeEACckNQ2EuQfyGNPEMQZDAy7hduXEsxls5ihyKBJl0Ph3ePhBzQhcIVkz8AjOHiLQSq63BN
 kKz5oM78ScBS75AWk8AQkrXE0/aEpJFpgHJ8sdtRlcrOpSPFxokV38HGCRp0qzCYnOmG/hiYtDU
 3XTUYpWeMu1zzcxazHtrx7ni28WuuZ0xjjNviARSb/FtBYhwkXbLj0GbRw1PPUKZ5U2j3lEU7oO
 ZxuyA9W5cdCn0JkbPOtwbINx1QA0VG0QXPrxdqULcnjRTkgSogKzG4h+DkaE0VnaXs4D7KGR1TA
 +QO4HDkn9WtZ0d55DFtoaaBhNuW72eo7yvTtTmq1C9SA+qoJtCZELjFw4tAHWrMg7ttZReU95FG
 S+/sjFNhMHycr0pQ0UIlhLxSa5ABkRHRVkoN1XPfiSlAw0eahcTUaUffWphYm9wOk5V4DNn3/Hp
 BIMLSbsWy/bV1d1GI1nmWl+jCe/VNq+wPbkxvd4Nxr1cs/egRip8/nFZhaLmcLqhbTgoaJn71hX
 CIePe71+42vNekOVs5mdLlzYNrcMxKPHTH8JlD2LbK1qjhGRNDePqh9cJMTaelxgBSDcfBKdWVG
 XjF8qRjAGj0lgLQ/k9wlc7Xc1ahzaesoZ5FqZNiiiilLVB2IYqqT+l27nOG6X5xpLYPxyQ2ohTW
 W6LD3uqHanswpJg==
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

We currently default to the lowest rate but this actually doesn't work
on most platforms. Default to the HS400 speed instead which is most
common on Qualcomm platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index ea5d6b4cbbee..2144772ac325 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -61,9 +61,9 @@ static int msm_sdc_clk_init(struct udevice *dev)
 	const char *clk_name;
 
 	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
 	if (ret)
-		clk_rate = 400000;
+		clk_rate = 201500000;
 
 	ret = clk_get_bulk(dev, &prv->clks);
 	if (ret) {
 		log_warning("Couldn't get mmc clocks: %d\n", ret);

-- 
2.44.0

