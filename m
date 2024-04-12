Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48062C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 09:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23675881F8;
	Fri, 12 Apr 2024 11:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VR5HzBCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18F288080; Fri, 12 Apr 2024 11:55:18 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE81881FA
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 11:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5aa27dba8a1so443815eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712915714; x=1713520514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rK9W2AGbnOfcXupe9xf5SOw7PSXaV/7az0Pvlu4dzww=;
 b=VR5HzBCcjkJBKPDmB0odWhX86oG1cYny9Cwzy6yK6BfHiUUmQb5cSDyM0WvKV8p4JN
 IJPWshf0TjV9PH5oULYq/gRuiby9XIc5itbfR/FaSytssi3EvNq3GnGEuM5jV/bslupg
 h1DToxhkbqz9Xrir8fdml4CAtAwAzdtZpGl7hz7Z4zGDk3MSuweif1VwOCPr/Lbac7qX
 V4Q3SZUu2tjo0uMO4wgJQVfUZrBP3kn7eH7Hvzs6iwLmF2MH2qnLvSEIiD7ZtDT1uAcS
 Jzy3iLrh8aqPhQKoBlJbBi7F6PdeDNQXqxJeS6duWAXEwJt+HbMhSm+a5DlU1zjeDVOM
 36dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712915714; x=1713520514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rK9W2AGbnOfcXupe9xf5SOw7PSXaV/7az0Pvlu4dzww=;
 b=sueONotIGt+OaDLkgk/v1iRc/GLDmAr4CYPl9CdiKTGZFw+dzX8FlzI8NW4shuqh3q
 iG95R3XWTo9OIi8R/Yqqrm9EqYC4IZyoxD59R1IzDNvzjG1i0jDS8Bz39nyXisZCUiSA
 sGyOBNX3E4dODOMYBTNnS9vepR3V7WzccSn50WojFHtIYTjAZpWOAI9TcB+xAQ1NJEW4
 x0YSQxF44/ISz90NmMoOrdTmg5uDGeS0VtbJOizvoC7MayLi3gT0ZCGcgR6HbkN2pG4L
 30J6UXxmd1G58+OhILY0vIYLR3rTcieoeXHazzNXmCk1jPvxvO3iCV1ltkQxdx5b1Q2d
 UfDw==
X-Gm-Message-State: AOJu0Yy7O+Z/8aWknkGQbquZdHz00p2FEDcLXf2q/ujOMJH4KrqW8kBh
 VOApfr6IaC1T0FjvDFgVRGXLtMOuPkjlw8QQtc0RoN4jEaxpwlbvtZ2PnOmR4Yig0KDe4ZN5cKG
 /
X-Google-Smtp-Source: AGHT+IEUCCDsYKC/Vam04l7Luei99sk+RSG0+0a3VWHA3+AOuiGeXdp/CpqqK4OudO8+WPEknHjiFg==
X-Received: by 2002:a05:6358:9786:b0:183:4d1d:dcae with SMTP id
 f6-20020a056358978600b001834d1ddcaemr3131096rwb.28.1712915713734; 
 Fri, 12 Apr 2024 02:55:13 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 bn19-20020a056a00325300b006ed0b798f1fsm2534839pfb.119.2024.04.12.02.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 02:55:13 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com,
 jimmy.lalande@se.com, benjamin.missey@non.se.com,
 daniel.thompson@linaro.org, stephan@gerhold.net,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 5/7] pinctrl: qcom: apq8016: Add GPIO pinctrl function
Date: Fri, 12 Apr 2024 15:24:36 +0530
Message-Id: <20240412095438.410570-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412095438.410570-1-sumit.garg@linaro.org>
References: <20240412095438.410570-1-sumit.garg@linaro.org>
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

Add GPIO pinctrl function to enable driving GPIO pins as output low or
high.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-apq8016.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
index 1ee8b7db1a2..b14a8921af4 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
@@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
 };
 
 static const struct pinctrl_function msm_pinctrl_functions[] = {
+	{"gpio", 0},
 	{"blsp_uart1", 2},
 	{"blsp_uart2", 2},
 };
-- 
2.34.1

