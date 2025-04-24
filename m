Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF046C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1D978210D;
	Thu, 24 Apr 2025 11:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KQRuPiLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FD2809D4; Thu, 24 Apr 2025 11:17:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050BD81E14
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4720285e9.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 02:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745486221; x=1746091021; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=apXP5/3htbLyy39AfE+jXbzfAzZU0GnsTRn3fdGCZcY=;
 b=KQRuPiLQGXxiAkvLrXA8DwtdmK9iUAKUjX77AhEP7HCim0Q+t3qGwloSguO5bP/3QI
 UZ1H92udj/KpJgarOCNzyHKzGLdxR7kUU+x5fhL9iqnjjXOHv1MOOoGQvvkcUVTqg6Gv
 /QW58ur5+ndX7YX+ZWc4u8peWq2kUoVSQsJMYugYm/OTq87Fc5KToEzZ0UoZH5rRLPZJ
 tM/kYHfjBBUvkFb3k87iUZBS2JAm2yRaPN2XmjLkuXBWrfIHm9XYSyOC87Xqiz9ArIik
 T8jL542dZI/WLTUmiQ11ONQ4BW4Zun0RcPB7fWAh+Pi59CB/MVjKdktJrqWefvSRN1/v
 muvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745486221; x=1746091021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apXP5/3htbLyy39AfE+jXbzfAzZU0GnsTRn3fdGCZcY=;
 b=azRLxZHNS0Wwhlcc+QvQi1RC9LU4oW5gB9S6bmhv01K8poB08Lo6sLeC1Fa9PSRntw
 QeG9zujQ3yFA5xV6hs0pQY9XNvMKkSVNKkWVAWndlB1l4/op6zUsFHbzSuI4ikw9ktt8
 /yIXHUyYct1CY+Di1ipxVZre+y/16au9WqGxRrDIEJmNbsuQyiDzZ4bb1HfO5UnxhPuK
 GSW1ath6PYyzR+iuStOsfuyl5+c1WMnAOh9aEAiIA68GNPIW497h596wm8B7SDsE+cn8
 1m+FeNYfzH/55hj1LjeX88q94gJ5Ogjf+pkbzXM0OOswOpcRooASb2CP1oJrAmWCCT09
 K70Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeC9n3IG1tyKiISkY3U/XIzjSt6KT5g4ghRpsbJ9LQFOTC5wRJF//sGtRQni1I8xzvEJ4LXO4=@lists.denx.de
X-Gm-Message-State: AOJu0YyM+4EJLVq1cMbv7JsT4rcp3+GdB6HyaRtL70zty77C8P1M3RLD
 RJhq3kGoaZBwcBaZcc4HNodeyrq8+zaSAK1WtPRptz6v65nCR2uJBNw0R0O5YTs=
X-Gm-Gg: ASbGncu608RdZOHwNzQ5FbpbvnLog/tytreZfM2YpnfSxy9gQtSbyPf/mf9ExwJHaTD
 6dhlEZkWipX4P3Pga7odKqnPjy6W6sUdHB8CMrproR+gi/lrHM2GWf9EwJat47MtRcZpgcLGhFQ
 1/16kKfGRI6bSxL8Y8kbRUU0cAl3VKsI6lhEdtWi1KCBrIHcm/k7vvNfUm+kM5ysdP19IDX9zeS
 eWjzkqsoDlKsVMJ0PmWQnlnnfwhahuCK+2udHAwxh9sc8cZNqKpZa7pEdIM0Gk0hap6bdGwXcwy
 LKmLpUHrSQf/6trveGF8vDZnqpWeOixWD+La8l6CFjdVJMQP+dPy1MvSQZWc/A==
X-Google-Smtp-Source: AGHT+IGtdOrkjTTyaLOMpOHaGJo0jDWEIrMDVHUtwgoS+Ld48VJpgqAXaDD58BrtdD/mm4JoW4/Izw==
X-Received: by 2002:a05:600c:4e14:b0:440:6a68:8260 with SMTP id
 5b1f17b1804b1-4409bcfb62dmr18992805e9.3.1745486221270; 
 Thu, 24 Apr 2025 02:17:01 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d677:e5de:3a6:836])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d1e19e1sm13000945e9.0.2025.04.24.02.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 02:17:00 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 24 Apr 2025 11:16:43 +0200
Subject: [PATCH v2 3/6] clk: qcom: Use setbits_le32() for
 qcom_gate_clk_en()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-apq8016-clock-fixes2-v2-3-fcc371c9e45f@linaro.org>
References: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
In-Reply-To: <20250424-apq8016-clock-fixes2-v2-0-fcc371c9e45f@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

The other clock enable functions in clock-qcom.c use setbits_le32() to
read/modify/write the enable registers. Use the same for qcom_gate_clk_en()
to simplify the code a bit.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 5018851725b03d1c55c6fc40934bd7bea6344da1..7a259db79342c31dfe85220c68c82197861ccdf6 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -76,16 +76,13 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
 
 int qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
 {
-	u32 val;
 	if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0) {
 		log_err("gcc@%#08llx: unknown clock ID %lu!\n",
 			priv->base, id);
 		return -ENOENT;
 	}
 
-	val = readl(priv->base + priv->data->clks[id].reg);
-	writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
-
+	setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
 	return 0;
 }
 

-- 
2.47.2

